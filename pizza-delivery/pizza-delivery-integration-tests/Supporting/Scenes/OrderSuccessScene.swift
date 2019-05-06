//
//  OrderSuccessScene.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class OrderSuccessScene: BaseScene {
    
    var backButton: Button { return Button(id: "backButton") }
    var closeButton: Button { return Button(id: "closeButton") }
    var finishButton: Button { return Button(id: "finishButton") }
    
    func isDisplayed() {
        XCTFail("Not Implemented")
    }

}
