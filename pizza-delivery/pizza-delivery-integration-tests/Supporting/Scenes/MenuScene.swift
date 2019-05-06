//
//  MenuSceneAccessor.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class MenuScene: BaseScene {
    
    func isDisplayed() {
        let menuView = app.otherElements[AccessibilityIdentitier.Menu.rootView]
        XCTAssert(menuView.exists, "Splash screen is not displayed.")
    }
    
    func waitUntilMenuIsLoaded() {
        let firstCell = app.cells[String(format: AccessibilityIdentitier.Menu.pizzaCellFormat, "0")]
        XCTAssert(firstCell.waitForExistence(timeout: 10))
    }
    
    func firstPizzaTitleIs(_ expectedTitle: String) {
        let firstCell = app.cells[String(format: AccessibilityIdentitier.Menu.pizzaCellFormat, "0")]
        let actualTitle = firstCell.staticTexts[AccessibilityIdentitier.Menu.pizzaCellTitle].label
        XCTAssertEqual(actualTitle, expectedTitle, "First pizza name is not correct.")
    }
    
    func firstPizzaPriceIs(_ expectedPrice: String) {
        let firstCell = app.cells[String(format: AccessibilityIdentitier.Menu.pizzaCellFormat, "0")]
        let actualPrice = firstCell.staticTexts[AccessibilityIdentitier.Menu.pizzaCellPrice].label
        XCTAssertEqual(actualPrice, expectedPrice, "First pizza price is not correct.")
    }
    
    func tapOrderFirstPizza() {
        XCTFail("Not Implemented")
    }
}
