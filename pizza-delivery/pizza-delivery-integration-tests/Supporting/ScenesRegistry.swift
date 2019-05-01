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
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func getSplashScene() -> SplashScene {
        return SplashScene(app: app)
    }
    
    func getMenuScene() -> MenuScene {
        return MenuScene(app: app)
    }
}
