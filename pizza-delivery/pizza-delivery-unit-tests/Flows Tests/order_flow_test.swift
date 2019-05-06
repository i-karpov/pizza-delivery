//
//  order_flow_test.swift
//  pizza-delivery-unit-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest
@testable import pizza_delivery

class order_flow_test: XCTestCase {

    // MARK: - Properties
    
    private var mockNavigator: MockSceneNavigator!
    
    private var selectAddressOutput: SelectAddressInitData.SelectAddressSceneOutput!
    private var enterDeliveryDetailsOutput: DeliveryDetails!
    private var selectPaymentMethodOutput: PaymentMethod!
    private var confirmOrderOutput: DeliveryWaitingTime!
    private var expectedOrderDraft: OrderDraft!
    
    private var pizza: Pizza!
    private var orderFlow: OrderFlow!
    
    // MARK: - SetUp & TearDown
    
    override func setUp() {
        mockNavigator = MockSceneNavigator()
        pizza = Pizza(id: 12,
                      title: "Some Pizza",
                      price: MoneyAmount(cents: 1250),
                      description: "Some Description",
                      smallImageUrl: "Some URL")
        orderFlow = OrderFlow(navigator: mockNavigator, initData: OrderFlowInitData(pizza: pizza))
        
        selectAddressOutput = SelectAddressInitData.SelectAddressSceneOutput(
            street: Street(id: 1, title: "Street 1"),
            buidling: Building(id: 1, title: "Building 1")
        )
        enterDeliveryDetailsOutput = DeliveryDetails(street: selectAddressOutput.street,
                                                     building: selectAddressOutput.buidling,
                                                     name: "Some Name",
                                                     phoneNumber: "1234567",
                                                     entrance: "1",
                                                     apartment: "2",
                                                     floor: "3",
                                                     comment: "Some Comment")
        selectPaymentMethodOutput = PaymentMethod.byCash(cashAmountToCalculateChange: MoneyAmount(cents: 2000))
        confirmOrderOutput = DeliveryWaitingTime(minutes: 45)
        expectedOrderDraft = OrderDraft(pizza: pizza,
                                        deliveryDetails: enterDeliveryDetailsOutput,
                                        paymentMethod: selectPaymentMethodOutput)
    }

    // MARK: - Tests
    
    func test_when_flow_started_then_it_can_be_completed_correctly() {
        
        // Act
        
        orderFlow.start(rootTransitionType: .modal)
        proceedIfPosibleFromSelectAddress(with: selectAddressOutput)
        proceedIfPossibleFromDeliveryDetails(with: enterDeliveryDetailsOutput)
        proceedIfPossibleFromPaymentSelection(with: selectPaymentMethodOutput)
        proceedIfPossibleFromOrderConfirmation(with: confirmOrderOutput)
        closeSuccessScreenIfPossible()
        
        // Assert
        
        var isStep1SelectAddress = false
        var isStep2EnterDeliveryDetails = false
        var isStep3SelectPaymentMethod = false
        var isStep4ConfirmOrder = false
        var isStep5SuccessScreen = false
        var isClosedAfterwards = false
        var actualOrderDraft: OrderDraft? = .none
        if mockNavigator.recordedOperations.count >= 6 {
            if case .navigateTo(.order(.selectAddress(_)), _, _) = getNavigationOperationAt(0) {
                isStep1SelectAddress = true
            }
            if case .navigateTo(.order(.enterDeliveryDetails(_)), _, _) = getNavigationOperationAt(1) {
                isStep2EnterDeliveryDetails = true
            }
            if case .navigateTo(.order(.selectPaymentMethod(_)), _, _) = getNavigationOperationAt(2) {
                isStep3SelectPaymentMethod = true
            }
            if case .navigateTo(.order(.confirmOrder(let initData)), _, _) = getNavigationOperationAt(3) {
                isStep4ConfirmOrder = true
                actualOrderDraft = initData.orderDraft
            }
            if case .navigateTo(.order(.success(_)), _, _) = getNavigationOperationAt(4) {
                isStep5SuccessScreen = true
            }
            if case .exitCurrentFlow(_) = getNavigationOperationAt(5) {
                isClosedAfterwards = true
            }
        }
        
        XCTAssertEqual(mockNavigator.recordedOperations.count, 6, "Wrong amount of navigation operations.")
        XCTAssert(isStep1SelectAddress, "Step 1 is incorrect")
        XCTAssert(isStep2EnterDeliveryDetails, "Step 2 is incorrect")
        XCTAssert(isStep3SelectPaymentMethod, "Step 3 is incorrect")
        XCTAssert(isStep4ConfirmOrder, "Step 4 is incorrect")
        XCTAssert(isStep5SuccessScreen, "Step 5 is incorrect")
        XCTAssert(isClosedAfterwards, "Not closed afterwards")
        XCTAssertNotNil(actualOrderDraft, "Order draft is nil.")
        XCTAssertEqual(actualOrderDraft, expectedOrderDraft, "Order draft is incorrect.")
    }
    
    func test_when_on_confirmation_step_then_flow_can_be_exited() {
        
        // Act
        
        orderFlow.start(rootTransitionType: .modal)
        proceedIfPosibleFromSelectAddress(with: selectAddressOutput)
        proceedIfPossibleFromDeliveryDetails(with: enterDeliveryDetailsOutput)
        proceedIfPossibleFromPaymentSelection(with: selectPaymentMethodOutput)
        closeOrderConfirmationIfPossible()
        
        // Assert
        
        var isClosedAfterwards = false
        if mockNavigator.recordedOperations.count >= 5 {
            if case .exitCurrentFlow(_) = getLastNavigationOperation()! {
                isClosedAfterwards = true
            }
        }
        
        XCTAssertEqual(mockNavigator.recordedOperations.count, 5, "Wrong amount of navigation operations.")
        XCTAssert(isClosedAfterwards, "Not closed afterwards")
    }
    
    // MARK: - Private Helpers
    
    private func closeSuccessScreenIfPossible() {
        if case .navigateTo(.order(.success(let initData)), _, _)? = getLastNavigationOperation() {
            initData.handleCloseTapped()
        }
    }
    
    private func closeOrderConfirmationIfPossible() {
        if case .navigateTo(.order(.confirmOrder(let initData)), _, _)? = getLastNavigationOperation() {
            initData.handleCloseTapped()
        }
    }
    
    private func proceedIfPossibleFromOrderConfirmation(with output: DeliveryWaitingTime) {
        if case .navigateTo(.order(.confirmOrder(let initData)), _, _)? = getLastNavigationOperation() {
            initData.handleOrderSentSuccessully(output)
        }
    }
    
    private func proceedIfPossibleFromPaymentSelection(with output: PaymentMethod) {
        if case .navigateTo(.order(.selectPaymentMethod(let initData)), _, _)? = getLastNavigationOperation() {
            initData.handleEnteringFinished(output)
        }
    }
    
    private func proceedIfPossibleFromDeliveryDetails(with output: DeliveryDetails) {
        if case .navigateTo(.order(.enterDeliveryDetails(let initData)), _, _)? = getLastNavigationOperation() {
            initData.handleEnteringFinished(output)
        }
    }
    
    private func proceedIfPosibleFromSelectAddress(with output: SelectAddressInitData.SelectAddressSceneOutput) {
        if case .navigateTo(.order(.selectAddress(let initData)), _, _)? = getLastNavigationOperation() {
            initData.handleEnteringFinished(output)
        }
    }
    
    private func getLastNavigationOperation() -> MockSceneNavigator.Operation? {
        return mockNavigator.recordedOperations.last
    }
    
    private func getNavigationOperationAt(_ index: Int) -> MockSceneNavigator.Operation {
        return mockNavigator.recordedOperations[index]
    }
}
