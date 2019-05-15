//
//  OrderSuccessScene.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class OrderSuccessScene: BaseScene {
    
    var backButton: Button { return Button(app: app,
                                           id: AccessibilityIdentitier.Order.CommonButton.backButton) }
    var closeButton: Button { return Button(app: app,
                                            id: AccessibilityIdentitier.Order.CommonButton.closeButton) }
    var finishButton: Button { return Button(app: app,
                                             id: AccessibilityIdentitier.Order.OrderSuccessScreen.finishButton) }
    
    func isDisplayed() {
        let view = app.otherElements[AccessibilityIdentitier.Order.OrderSuccessScreen.rootView]
        XCTAssert(view.waitForExistence(timeout: 15), "Order Success Scene is not displayed.")
    }

}
