//
//  DeliveryDetailsScene.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class DeliveryDetailsScene: BaseScene {
    
    var backButton: Button { return Button(app: app,
                                           id: AccessibilityIdentitier.Order.CommonButton.backButton) }
    var closeButton: Button { return Button(app: app,
                                            id: AccessibilityIdentitier.Order.CommonButton.closeButton) }
    var nextButton: Button { return Button(app: app,
                                           id: AccessibilityIdentitier.Order.CommonButton.nextButton) }
    var nameInput: SingleLineTextInput { return SingleLineTextInput(app: app,
                                        id: AccessibilityIdentitier.Order.EnterDeliveryDetails.nameInput) }
    var streetInput: SingleLineTextInput { return SingleLineTextInput(app: app,
                                          id:  AccessibilityIdentitier.Order.EnterDeliveryDetails.streetInput) }
    var buildingInput: SingleLineTextInput { return SingleLineTextInput(app: app,
                                            id:  AccessibilityIdentitier.Order.EnterDeliveryDetails.buildingInput) }
    var entranceInput: SingleLineTextInput { return SingleLineTextInput(app: app,
                                            id:  AccessibilityIdentitier.Order.EnterDeliveryDetails.entranceInput) }
    var floorInput: SingleLineTextInput { return SingleLineTextInput(app: app,
                                         id: AccessibilityIdentitier.Order.EnterDeliveryDetails.floorInput) }
    var apartmentInput: SingleLineTextInput { return SingleLineTextInput(app: app,
                                             id: AccessibilityIdentitier.Order.EnterDeliveryDetails.ataprtmentInput) }
    var commentInput: SingleLineTextInput { return SingleLineTextInput(app: app,
                                           id: AccessibilityIdentitier.Order.EnterDeliveryDetails.commentInput) }
    var phoneNumberInput: SingleLineTextInput { return SingleLineTextInput(app: app,
                                               id:  AccessibilityIdentitier.Order.EnterDeliveryDetails.phoneNumberInput) }
    
    func isDisplayed() {
        let view = app.otherElements[AccessibilityIdentitier.Order.EnterDeliveryDetails.rootView]
        XCTAssert(view.waitForExistence(timeout: 2), "Enter Delivery Details Scene is not displayed.")
    }
    
    func scrollToBottom() {
        app.otherElements[AccessibilityIdentitier.Order.EnterDeliveryDetails.rootView]
            .scrollViews
            .element
            .swipeUp()
    }

}
