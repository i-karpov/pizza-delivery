//
//  MenuSceneAccessor.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class MenuScene: BaseScene {
    
    override func isDisplayed() {
        // TODO: assert that screen is present
        XCTAssertFalse(true)
        fatalError("not implemented")
    }
    
    func waitUntilMenuIsLoaded() {
        fatalError("not implemented")
    }
    
    func firstPizzaTitleIs(_ expectedTitle: String) {
        let actualTitle = "" // TODO: retreive real title
        XCTAssertEqual(actualTitle, expectedTitle, "First pizza name is not correct.")
        fatalError("not implemented")
    }
    
    func firstPizzaPriceIs(_ expectedPrice: String) {
        let actualPrice = "" // TODO: retreive real title
        XCTAssertEqual(actualPrice, expectedPrice, "First pizza price is not correct.")
        fatalError("not implemented")
    }
}
