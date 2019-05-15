//
//  Input.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class Dropdown {
    
    private let app: XCUIApplication
    private let id: String
    
    init(app: XCUIApplication, id: String) {
        self.id = id
        self.app = app
    }
    
    func isNotDisplayed() {
        let input = app.otherElements[id]
        XCTAssertFalse(!input.exists || !input.isHittable, "Dropdown \(id) is displayed.")
    }
    
    func isDisplayed() {
        let input = app.otherElements[id]
        XCTAssert(input.exists && input.isHittable, "Dropdown \(id) is not displayed.")
    }
    
    func isEnabled() {
        let button = app.otherElements[id]
        XCTAssert(button.isEnabled, "Dropdown \(id) is disabled.")
    }
    
    func isDisabled() {
        let button = app.otherElements[id]
        XCTAssert(!button.isHittable || !button.isEnabled, "Dropdown \(id) is enabled.")
    }
    
    func isEmpty() {
        valueIs("")
    }
    
    func tap() {
        let input = app.otherElements[id]
        input.tap()
    }
    
    func valueIs(_ expectedValue: String) {
        let actualValue = app
            .otherElements[id]
            .staticTexts[AccessibilityIdentitier.CommonInputControl.value]
            .label
        
        XCTAssertEqual(actualValue, expectedValue, "Dropdown value is not correct.")
    }
        
}
