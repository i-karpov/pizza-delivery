//
//  Button.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class Button {
    
    private let app: XCUIApplication
    private let id: String
    
    init(app: XCUIApplication, id: String) {
        self.id = id
        self.app = app
    }
    
    func isDisplayed() {
        let button = app.buttons[id]
        XCTAssert(button.exists && button.isHittable, "Button \(id) is not displayed.")
    }
    
    func isNotDisplayed() {
        let button = app.buttons[id]
        XCTAssert(!button.exists || !button.isHittable, "Button \(id) is displayed.")
    }
    
    func isEnabled() {
        let button = app.buttons[id]
        XCTAssert(button.isEnabled, "Button \(id) is disabled.")
    }
    
    func isDisabled() {
        let button = app.buttons[id]
        XCTAssertFalse(button.isEnabled, "Button \(id) is enabled.")
    }
    
    func tap() {
        let button = app.buttons[id]
        button.tap()
    }
}
