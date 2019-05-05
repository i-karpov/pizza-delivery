//
//  BaseScene.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class BaseScene {
    
    let app: XCUIApplication
    let testCase: XCTestCase
    
    init(app: XCUIApplication, testCase: XCTestCase) {
        self.app = app
        self.testCase = testCase
    }
    
    func isDisplayed() {
        fatalError("Abstract method should be implemented in successors.")
    }
    
}
