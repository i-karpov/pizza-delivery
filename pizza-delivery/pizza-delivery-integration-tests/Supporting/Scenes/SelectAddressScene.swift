//
//  SelectAddressScene.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class SelectAddressScene: BaseScene {
    
    var backButton: Button { return Button(id: "backButton") }
    var closeButton: Button { return Button(id: "closeButton") }
    var nextButton: Button { return Button(id: "next") }
    var streetInput: Input { return Input(id: "street") }
    var buildingInput: Input { return Input(id: "building") }
    var streetPicker: Picker { return Picker(id: "streetPicker") }
    var buildingPicker: Picker { return Picker(id: "buildingPicker") }
    
    func isDisplayed() {
        XCTFail("Not Implemented")
    }
}
