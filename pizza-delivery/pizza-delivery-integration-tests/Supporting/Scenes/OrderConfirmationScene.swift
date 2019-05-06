//
//  OrderConfirmationScene.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class OrderConfirmationScene: BaseScene {
    
    var backButton: Button { return Button(id: "backButton") }
    var closeButton: Button { return Button(id: "closeButton") }
    var orderButton: Button { return Button(id: "orderButton") }
    
    func isDisplayed() {
        XCTFail("Not Implemented")
    }
    
    func totalAmountIs(_ expectedTotalAount: String) {
        XCTFail("Not Implemented")
    }
    
    func nameIs(_ expectedName: String) {
        XCTFail("Not Implemented")
    }
    
    func phoneNumberIs(_ expectedPhoneNumber: String) {
        XCTFail("Not Implemented")
    }
    
    func addressIs(_ expectedAddress: String) {
        XCTFail("Not Implemented")
    }
    
    func paymentMethodIs(_ expectedPaymentMethod: String) {
        XCTFail("Not Implemented")
    }
    
    func pizzaTitleIs(_ expectedPizzaTitle: String) {
        XCTFail("Not Implemented")
    }
    
}
