//
//  ScenesRegistry.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class ScenesRegistry {
    
    private let app: XCUIApplication
    private let testCase: XCTestCase
    
    init(app: XCUIApplication, testCase: XCTestCase) {
        self.app = app
        self.testCase = testCase
    }
    
    func getSplashScene() -> SplashScene {
        return SplashScene(app: app, testCase: testCase)
    }
    
    func getMenuScene() -> MenuScene {
        return MenuScene(app: app, testCase: testCase)
    }
}
