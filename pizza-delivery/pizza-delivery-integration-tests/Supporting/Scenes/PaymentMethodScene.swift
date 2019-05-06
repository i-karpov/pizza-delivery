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
    var cashAmountInput: Input { return Input(id: "cashInput") }
    var backButton: Button { return Button(id: "backButton") }
    var closeButton: Button { return Button(id: "closeButton") }
    var nextButton: Button { return Button(id: "next") }
    
    func isDisplayed() {
        XCTFail("Not Implemented")
    }
    
    
    func totalAmountIs(_ expectedTotalAount: String) {
        XCTFail("Not Implemented")
    }
    
    
}
