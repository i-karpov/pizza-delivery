//
//  MockMenuView.swift
//  pizza-delivery-unit-tests
//
//  Created by Igor Karpov on 05.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation
@testable import pizza_delivery

class MockMenuView: MenuViewProtocol {
    
    enum Operation {
        case setIsAcitityIndicatorVisible(isVisible: Bool)
        case showTextForError(error: CommonError)
        case showTextWithRetryForError(error: CommonError)
        case setPizzas(pizzas: [Pizza])
    }
    
    var recordedOperations = [Operation]()
    
    func setIsAcitityIndicatorVisible(_ isVisible: Bool) {
        recordedOperations.append(.setIsAcitityIndicatorVisible(isVisible: isVisible))
    }
    
    func showTextForError(_ error: CommonError) {
        recordedOperations.append(.showTextForError(error: error))
    }
    
    func showTextWithRetryForError(_ error: CommonError) {
        recordedOperations.append(.showTextWithRetryForError(error: error))
    }
    
    func setPizzas(_ pizzas: [Pizza]) {
        recordedOperations.append(.setPizzas(pizzas: pizzas))
    }
    
}
