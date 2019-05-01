//
//  menu_tests.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class menu_tests: XCTestCase {

    private var scenesRegistry: ScenesRegistry!
    private var menuScene: MenuScene!
    
    override func setUp() {
        continueAfterFailure = false
        let app = XCUIApplication()
        scenesRegistry = ScenesRegistry(app: app)
        app.launch()
        
        // Arrange
        
        menuScene = scenesRegistry.getMenuScene()
        goFromSplashToMenuScene()
    }
    
    private func goFromSplashToMenuScene() {
        let splashScene = scenesRegistry.getSplashScene()
        splashScene.isDisplayed()
        splashScene.waitUntilPassed()
        menuScene.isDisplayed()
    }

    func test_menu_gets_loaded_and_first_pizza_is_correct() {
        menuScene.waitUntilMenuIsLoaded()
        menuScene.firstPizzaTitleIs("Гавайская")
        menuScene.firstPizzaPriceIs("12,60")
    }

}
