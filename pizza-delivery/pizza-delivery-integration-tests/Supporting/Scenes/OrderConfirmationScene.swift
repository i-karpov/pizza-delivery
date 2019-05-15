//
//  OrderConfirmationScene.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class OrderConfirmationScene: BaseScene {
    
    var backButton: Button { return Button(app: app,
                                           id: AccessibilityIdentitier.Order.CommonButton.backButton) }
    var closeButton: Button { return Button(app: app,
                                            id: AccessibilityIdentitier.Order.CommonButton.closeButton) }
    var orderButton: Button { return Button(app: app,
                                            id: AccessibilityIdentitier.Order.ConfirmOrder.confirmButton) }
    
    func isDisplayed() {
        let view = app.otherElements[AccessibilityIdentitier.Order.ConfirmOrder.rootView]
        XCTAssert(view.waitForExistence(timeout: 2), "Confirmation Scene is not displayed.")
    }
    
    func totalAmountIs(_ expectedTotalAount: String) {
        let actualAmount = app
            .staticTexts[AccessibilityIdentitier.Order.ConfirmOrder.totalSumLabel]
            .label
        XCTAssertEqual(actualAmount, expectedTotalAount, "Total amount is not correct.")
    }
    
    func nameIs(_ expectedName: String) {
        let actualName = app
            .staticTexts[AccessibilityIdentitier.Order.ConfirmOrder.nameValueLabel]
            .label
        XCTAssertEqual(actualName, expectedName, "Name is not correct.")
    }
    
    func phoneNumberIs(_ expectedPhoneNumber: String) {
        let actualValue = app
            .staticTexts[AccessibilityIdentitier.Order.ConfirmOrder.phoneNumberValueLabel]
            .label
        XCTAssertEqual(actualValue, expectedPhoneNumber, "Phone Number is not correct.")
    }
    
    func addressIs(_ expectedAddress: String) {
        let actualValue = app
            .staticTexts[AccessibilityIdentitier.Order.ConfirmOrder.addressValueLabel]
            .label
        XCTAssertEqual(actualValue, expectedAddress, "Address is not correct.")
    }
    
    func paymentMethodIs(_ expectedPaymentMethod: String) {
        let actualValue = app
            .staticTexts[AccessibilityIdentitier.Order.ConfirmOrder.paymentMethodValueLabel]
            .label
        XCTAssertEqual(actualValue, expectedPaymentMethod, "Payment Method is not correct.")
    }
    
    func pizzaTitleIs(_ expectedPizzaTitle: String) {
        let actualValue = app
            .staticTexts[AccessibilityIdentitier.Order.ConfirmOrder.pizzaTitleValueLabel]
            .label
        XCTAssertEqual(actualValue, expectedPizzaTitle, "Pizza Title is not correct.")
    }
    
}
