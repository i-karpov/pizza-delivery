//
//  SplashSceneAccessor.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class SplashScene: BaseScene {
    
    func isDisplayed() {
        let splashView = app.otherElements[AccessibilityIdentitier.Splash.rootView]
        XCTAssert(splashView.exists, "Splash screen is not displayed.")
    }
    
    func waitUntilPassed() {
        let splashView = app.otherElements[AccessibilityIdentitier.Splash.rootView]
        let doesNotExistPredicate = NSPredicate(format: "hittable == FALSE")
        testCase.expectation(for: doesNotExistPredicate,
                             evaluatedWith: splashView,
                             handler: nil)
        testCase.waitForExpectations(timeout: 5, handler: nil)
    }
    
}
