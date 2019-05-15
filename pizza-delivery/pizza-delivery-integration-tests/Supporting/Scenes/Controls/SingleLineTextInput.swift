//
//  Input.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class SingleLineTextInput {
    
    private let app: XCUIApplication
    private let id: String
    
    init(app: XCUIApplication, id: String) {
        self.id = id
        self.app = app
    }

    func isNotDisplayed() {
        let input = app.otherElements[id]
        XCTAssert(!input.exists || !input.isHittable, "Input \(id) is displayed.")
    }
    
    func isDisplayed() {
        let input = app.otherElements[id]
        XCTAssert(input.exists && input.isHittable, "Input \(id) is not displayed.")
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
            .textFields[AccessibilityIdentitier.CommonInputControl.value]
            .value as? String
    
        XCTAssertEqual(actualValue, expectedValue, "Input value is not correct.")
    }
    
    func enter(_ valueToAppend: String) {
        app
            .otherElements[id]
            .textFields[AccessibilityIdentitier.CommonInputControl.value]
            .typeText(valueToAppend)
    }

}
