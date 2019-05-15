//
//  placing_and_order_tests.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class order_flow_tests: XCTestCase {

    // MARK: - Properties
    
    private var scenesRegistry: ScenesRegistry!
    private var menuScene: MenuScene!
    private var selectAddressScene: SelectAddressScene!
    private var deliveryDetailsScene: DeliveryDetailsScene!
    private var paymentMethodScene: PaymentMethodScene!
    private var confirmationScene: OrderConfirmationScene!
    private var successScene: OrderSuccessScene!
    
    // MARK: - SetUp & TearDown
    
    override func setUp() {
        continueAfterFailure = false
        let app = XCUIApplication()
        scenesRegistry = ScenesRegistry(app: app, testCase: self)
        app.launch()
        
        // Arrange
        
        menuScene = scenesRegistry.getMenuScene()
        selectAddressScene = scenesRegistry.getSelectAddressScene()
        deliveryDetailsScene = scenesRegistry.getDeliveryDetailsScene()
        paymentMethodScene = scenesRegistry.getPaymentMethodScene()
        confirmationScene = scenesRegistry.getOrderConfirmationScene()
        successScene = scenesRegistry.getOrderSuccessScene()
        
        goFromSplashToMenuScene()
        menuScene.waitUntilMenuIsLoaded()
    }
    
    // MARK: - Tests
    
    func test_order_can_be_sent_successfully() {
        menuScene.tapOrderFirstPizza()
        
        fillAddress()
        selectAddressScene.nextButton.tap()
        checkAndFillDeliveryDetails()
        deliveryDetailsScene.nextButton.tap()
        checkPaymentMethod()
        paymentMethodScene.nextButton.tap()
        checkConfirmation()
        confirmationScene.orderButton.tap()
        
        successScene.isDisplayed()
        successScene.backButton.isNotDisplayed()
        successScene.closeButton.isNotDisplayed()
        successScene.finishButton.tap()
        
        menuScene.isDisplayed()
    }
    
    func test_when_on_confirmation_step_then_flow_can_be_exited() {
        menuScene.tapOrderFirstPizza()
        fillAddress()
        selectAddressScene.nextButton.tap()
        checkAndFillDeliveryDetails()
        deliveryDetailsScene.nextButton.tap()
        checkPaymentMethod()
        paymentMethodScene.nextButton.tap()
        checkConfirmation()
        
        confirmationScene.closeButton.tap()
        menuScene.isDisplayed()
    }
    
    func test_when_on_confirmation_step_then_can_return_to_first_step() {
        menuScene.tapOrderFirstPizza()
        fillAddress()
        selectAddressScene.nextButton.tap()
        checkAndFillDeliveryDetails()
        deliveryDetailsScene.nextButton.tap()
        checkPaymentMethod()
        paymentMethodScene.nextButton.tap()
        checkConfirmation()
        
        confirmationScene.backButton.tap()
        paymentMethodScene.isDisplayed()
        paymentMethodScene.backButton.tap()
        deliveryDetailsScene.isDisplayed()
        deliveryDetailsScene.backButton.tap()
        selectAddressScene.isDisplayed()
    }
    
    // MARK: - Private Helpers
    
    private func goFromSplashToMenuScene() {
        let splashScene = scenesRegistry.getSplashScene()
        splashScene.isDisplayed()
        splashScene.waitUntilPassed()
        menuScene.isDisplayed()
    }

    private func fillAddress() {
        
        selectAddressScene.isDisplayed()
        selectAddressScene.backButton.isNotDisplayed()
        selectAddressScene.closeButton.isDisplayed()
        
        selectAddressScene.nextButton.isDisabled()
        selectAddressScene.streetInput.isEmpty()
        selectAddressScene.buildingInput.isEmpty()
        
        selectAddressScene.streetInput.tap()
        selectAddressScene.picker.isDisplayed()
        selectAddressScene.picker.firstItemIs("Нарочанская")
        selectAddressScene.picker.scrollToLast()
        selectAddressScene.picker.lastItemIs("Независимости просп.")
        selectAddressScene.picker.pickLast()
        selectAddressScene.picker.isNotDisplayed()
        selectAddressScene.streetInput.valueIs("Независимости просп.")
        
        selectAddressScene.loadingIndicatorIsDisplayed()
        selectAddressScene.buildingInput.isDisabled()
        selectAddressScene.waitUntilLoadingIndicatorDisappears()
        selectAddressScene.buildingInput.isEnabled()
        
        selectAddressScene.buildingInput.tap()
        selectAddressScene.picker.isDisplayed()
        selectAddressScene.picker.firstItemIs("1")
        selectAddressScene.picker.pickFirst()
        selectAddressScene.picker.isNotDisplayed()
        selectAddressScene.buildingInput.valueIs("1")
    }
    
    private func checkAndFillDeliveryDetails() {
        deliveryDetailsScene.isDisplayed()
        deliveryDetailsScene.backButton.isDisplayed()
        deliveryDetailsScene.closeButton.isDisplayed()
        
        deliveryDetailsScene.nextButton.isDisabled()
        deliveryDetailsScene.nameInput.isEmpty()
        deliveryDetailsScene.streetInput.valueIs("Независимости просп.")
        deliveryDetailsScene.buildingInput.valueIs("1")
        
        deliveryDetailsScene.nameInput.tap()
        deliveryDetailsScene.nameInput.enter("Name")
        deliveryDetailsScene.nextButton.isDisabled()
        deliveryDetailsScene.entranceInput.tap()
        deliveryDetailsScene.entranceInput.enter("1")
        deliveryDetailsScene.nextButton.isDisabled()
        deliveryDetailsScene.apartmentInput.tap()
        deliveryDetailsScene.apartmentInput.enter("2")
        deliveryDetailsScene.nextButton.isDisabled()
        deliveryDetailsScene.floorInput.tap()
        deliveryDetailsScene.floorInput.enter("3")
        deliveryDetailsScene.nextButton.isDisabled()
        deliveryDetailsScene.scrollToBottom()
        deliveryDetailsScene.commentInput.tap()
        deliveryDetailsScene.commentInput.enter("some multiline\ncomment")
        deliveryDetailsScene.nextButton.isDisabled()
        
        deliveryDetailsScene.phoneNumberInput.tap()
        deliveryDetailsScene.phoneNumberInput.enter("+375111111111")
        deliveryDetailsScene.nextButton.isEnabled()
    }
    
    private func checkPaymentMethod() {
        paymentMethodScene.isDisplayed()
        paymentMethodScene.backButton.isDisplayed()
        paymentMethodScene.closeButton.isDisplayed()
        
        paymentMethodScene.nextButton.isEnabled()
        paymentMethodScene.totalAmountIs("12.90")
    }
    
    private func checkConfirmation() {
        confirmationScene.isDisplayed()
        confirmationScene.backButton.isDisplayed()
        confirmationScene.closeButton.isDisplayed()
        
        confirmationScene.orderButton.isEnabled()
        confirmationScene.totalAmountIs("12.90")
        
        confirmationScene.nameIs("Name")
        confirmationScene.phoneNumberIs("+375111111111")
        confirmationScene.addressIs("Независимости просп., 1, 1, 2, 3")
        confirmationScene.paymentMethodIs("Card")
        confirmationScene.pizzaTitleIs("Ранч пицца")
    }
}
