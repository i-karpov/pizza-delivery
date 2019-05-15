//
//  PaymentMethodScene.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class PaymentMethodScene: BaseScene {
    
    class PaymentMethodPicker {
        func cashIsSelected() {
            XCTFail("Not Implemented")
        }
        func cardIsSelected() {
            XCTFail("Not Implemented")
        }
        func tapCard() {
            XCTFail("Not Implemented")
        }
        func tapCash() {
            XCTFail("Not Implemented")
        }
    }
    
    var picker: PaymentMethodPicker { return PaymentMethodPicker() }
    var cashAmountInput: SingleLineTextInput { return SingleLineTextInput(app: app,
                                              id: AccessibilityIdentitier.Order.SelectPaymentMethod.cashAmountInput) }
    var backButton: Button { return Button(app: app,
                                           id: AccessibilityIdentitier.Order.CommonButton.backButton) }
    var closeButton: Button { return Button(app: app,
                                            id: AccessibilityIdentitier.Order.CommonButton.closeButton) }
    var nextButton: Button { return Button(app: app,
                                           id: AccessibilityIdentitier.Order.CommonButton.nextButton) }
    
    func isDisplayed() {
        let view = app.otherElements[AccessibilityIdentitier.Order.SelectPaymentMethod.rootView]
        XCTAssert(view.waitForExistence(timeout: 2), "Select Payment Method Scene is not displayed.")
    }
    
    func totalAmountIs(_ expectedTotalAount: String) {
        let sumElement = app.staticTexts[AccessibilityIdentitier.Order.SelectPaymentMethod.totalSumLabel]
        let actualSum = sumElement.label
        XCTAssertEqual(actualSum, expectedTotalAount, "Total amount is not correct.")
    }

}
