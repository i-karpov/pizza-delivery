//
//  SelectAddressScene.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class SelectAddressScene: BaseScene {
    
    var backButton: Button { return Button(app: app,
                                           id: AccessibilityIdentitier.Order.CommonButton.backButton) }
    var closeButton: Button { return Button(app: app,
                                            id: AccessibilityIdentitier.Order.CommonButton.closeButton) }
    var nextButton: Button { return Button(app: app,
                                           id: AccessibilityIdentitier.Order.CommonButton.nextButton) }
    var streetInput: Dropdown { return Dropdown(app: app,
                                                id: AccessibilityIdentitier.Order.SelectAddress.streetInput) }
    var buildingInput: Dropdown { return Dropdown(app: app,
                                                  id: AccessibilityIdentitier.Order.SelectAddress.buildingInput) }
    var picker: Picker { return Picker(app: app,
                                       id: AccessibilityIdentitier.CommonInputControl.picker) }
    
    func isDisplayed() {
        let view = app.otherElements[AccessibilityIdentitier.Order.SelectAddress.rootView]
        XCTAssert(view.exists && view.isHittable, "Select Address Scene is not displayed.")
    }
    
    func loadingIndicatorIsDisplayed() {
        let view = app.otherElements[AccessibilityIdentitier.activityIndicator]
        XCTAssert(view.exists && view.isHittable, "Loading indicator is not displayed.")
    }
    
    func waitUntilLoadingIndicatorDisappears() {
        let view = app.otherElements[AccessibilityIdentitier.activityIndicator]
        let isNotHittablePredicate = NSPredicate(format: "hittable == FALSE")
        testCase.expectation(for: isNotHittablePredicate,
                             evaluatedWith: view,
                             handler: nil)
        testCase.waitForExpectations(timeout: 5, handler: nil)
    }
}
