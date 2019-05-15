//
//  Picker.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class Picker {
    
    private let app: XCUIApplication
    private let id: String
    
    init(app: XCUIApplication, id: String) {
        self.id = id
        self.app = app
    }
    
    func isDisplayed() {
        let picker = app.pickers[id]
        XCTAssert(picker.exists && picker.isHittable, "Picker \(id) is not displayed.")
    }
    
    func isNotDisplayed() {
        let picker = app.pickers[id]
        XCTAssert(!picker.exists || !picker.isHittable, "Picker \(id) is displayed.")
    }
    
    func firstItemIs(_ expectedFirstItem: String) {
        scrollToFirst()
        let firstValue = app.pickers[id].pickerWheels.element.value as? String
        XCTAssertEqual(firstValue, expectedFirstItem, "Picker: first item is incorrect.")
    }
    
    func scrollToFirst() {
        let pickerWheel = app.pickers[id].pickerWheels.element
        let rowsCount = pickerWheel.children(matching: .any).count
        
        for _ in 0..<rowsCount {
            pickerWheel
                .coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: -0.6))
                .tap()
        }
    }
    
    func scrollToLast() {
        let pickerWheel = app.pickers[id].pickerWheels.element
        let rowsCount = pickerWheel.children(matching: .any).count
        
        for _ in 0..<rowsCount {
            pickerWheel
                .coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.6))
                .tap()
        }
    }
    
    func lastItemIs(_ expectedLastItem: String) {
        scrollToLast()
        let lastValue = app.pickers[id].pickerWheels.element.value as? String
        XCTAssertEqual(lastValue, expectedLastItem, "Picker: last item is incorrect.")
    }
    
    func pickFirst() {
        scrollToFirst()
        app
            .buttons[AccessibilityIdentitier.CommonInputControl.pickerDoneButton]
            .tap()
    }
    
    func pickLast() {
        scrollToLast()
        app
            .buttons[AccessibilityIdentitier.CommonInputControl.pickerDoneButton]
            .tap()
    }
}
