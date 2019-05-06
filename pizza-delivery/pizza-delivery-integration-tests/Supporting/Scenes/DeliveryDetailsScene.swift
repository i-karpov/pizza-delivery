//
//  DeliveryDetailsScene.swift
//  pizza-delivery-integration-tests
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest

class DeliveryDetailsScene: BaseScene {
    
    var backButton: Button { return Button(id: "backButton") }
    var closeButton: Button { return Button(id: "closeButton") }
    var nextButton: Button { return Button(id: "next") }
    var nameInput: Input { return Input(id: "nameInput") }
    var streetInput: Input { return Input(id: "streetInput") }
    var buildingInput: Input { return Input(id: "buildingInput") }
    var entranceInput: Input { return Input(id: "entranceInput") }
    var floorInput: Input { return Input(id: "floorInput") }
    var apartmentInput: Input { return Input(id: "apartmentInput") }
    var commentInput: Input { return Input(id: "commentInput") }
    var phoneNumberInput: Input { return Input(id: "phoneNumberInput") }
    
    func isDisplayed() {
        XCTFail("Not Implemented")
    }

}
