//
//  OrderFlow.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation
import UIKit

class OrderFlow: FlowProtocol {
    
    private let navigator: SceneNavigatorProtocol

    private let pizza: Pizza
    private var street: Street?
    private var building: Building?
    private var deliveryDetails: DeliveryDetails?
    private var paymentMethod: PaymentMethod?
    private var orderDraft: OrderDraft?

    init(navigator: SceneNavigatorProtocol,
         initData: OrderFlowInitData) {
        self.navigator = navigator
        pizza = initData.pizza
    }

    func start(rootTransitionType: SceneTransitionType) {
        goToSelectAddress(transitionType: rootTransitionType)
    }

    private func goToSelectAddress(transitionType: SceneTransitionType) {
        let initData = SelectAddressInitData(
            handleCloseTapped: makeWeakCloseFlowBlock(),
            handleEnteringFinished: { [weak self] (output) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.street = output.street
                strongSelf.building = output.buidling
                strongSelf.goDeliveryDetails()
            })
        navigator.navigateTo(.order(.selectAddress(initData)),
                             retainingFlow: self,
                             transitionType: transitionType)
    }

    private func goDeliveryDetails() {
        guard let street = street, let building = building else {
            fatalError("Incorrect state")
        }

        let initData = EnterDeliveryDetailsInitData(
            selectedStreet: street,
            selectedBuilding: building,
            handleCloseTapped: makeWeakCloseFlowBlock(),
            handleEnteringFinished: { [weak self] (deliveryDetails) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.deliveryDetails = deliveryDetails
                strongSelf.goToPaymentMethodSelection()
            })
        navigator.navigateTo(.order(.enterDeliveryDetails(initData)),
                             retainingFlow: self,
                             transitionType: .push)
    }

    private func goToPaymentMethodSelection() {
        let initData = SelectPaymentMethodInitData(
            totalPrice: pizza.price,
            handleCloseTapped: makeWeakCloseFlowBlock(),
            handleEnteringFinished: { [weak self] (paymentMethod) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.paymentMethod = paymentMethod
                strongSelf.goToConfirmationScreen()
            })
        navigator.navigateTo(.order(.selectPaymentMethod(initData)),
                             retainingFlow: self,
                             transitionType: .push)
    }

    private func goToConfirmationScreen() {
        let orderDraft = makeOrderDraft()
        let initData = ConfirmOrderInitData(
            orderDraft: orderDraft,
            handleCloseTapped: makeWeakCloseFlowBlock(),
            handleOrderSentSuccessully: { [weak self] (deliveryWaitingTime) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.goToSuccessScreen(deliveryWaitingTime: deliveryWaitingTime)
            })
        navigator.navigateTo(.order(.confirmOrder(initData)),
                             retainingFlow: self,
                             transitionType: .push)
    }

    private func goToSuccessScreen(deliveryWaitingTime: DeliveryWaitingTime) {
        let initData = OrderSuccessScreenInitData(
            deliveryWaitingTime: deliveryWaitingTime,
            handleCloseTapped: makeWeakCloseFlowBlock())
        navigator.navigateTo(.order(.success(initData)),
                             retainingFlow: self,
                             transitionType: .push)
    }

    private func makeOrderDraft() -> OrderDraft {
        guard let deliveryDetails = deliveryDetails, let paymentMethod = paymentMethod else {
            fatalError("Incorrect state")
        }

        let orderDraft = OrderDraft(pizza: pizza,
                                    deliveryDetails: deliveryDetails,
                                    paymentMethod: paymentMethod)
        return orderDraft
    }

    private func makeWeakCloseFlowBlock() -> CommonBlock.EmptyAction {
        return { [weak self] in
            self?.navigator.exitCurrentFlow(animated: true)
        }
    }
}
