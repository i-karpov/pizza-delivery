//
//  MockSelectAddresssView.swift
//  pizza-delivery-unit-tests
//
//  Created by Igor Karpov on 08.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation
@testable import pizza_delivery

class MockSelectAddresssView: SelectAddressViewProtocol {
    
    enum Operation {
        case setIsAcitityIndicatorVisible(isVisible: Bool)
        case showTextForError(error: CommonError)
        case setIsStreetInputEnabled(isEnabled: Bool)
        case setIsBuildingInputEnabled(isEnabled: Bool)
        case setIsNextButtonEnabled(isEnabled: Bool)
        case setAvailableStreets(streets: [Street])
        case setAvailableBuildings(buildings: [Building])
    }
    
    var recordedOperations = [Operation]()
    
    // MARK: - Helpers
    
    static func isOperationIsStreetEnabled(_ operation: MockSelectAddresssView.Operation,
                                           withParam isEnabled: Bool? = nil) -> Bool {
        if let isEnabled = isEnabled {
            if case .setIsStreetInputEnabled(isEnabled) = operation {
                return true
            }
        } else {
            if case .setIsStreetInputEnabled(_) = operation {
                return true
            }
        }
        return false
    }
    
    static func isOperationIsBuildingEnabled(_ operation: MockSelectAddresssView.Operation,
                                             withParam isEnabled: Bool? = nil) -> Bool {
        if let isEnabled = isEnabled {
            if case .setIsBuildingInputEnabled(isEnabled) = operation {
                return true
            }
        } else {
            if case .setIsBuildingInputEnabled(_) = operation {
                return true
            }
        }
        return false
    }
    
    static func isOperationIsNextButtonEnabled(_ operation: MockSelectAddresssView.Operation,
                                               withParam isEnabled: Bool? = nil) -> Bool {
        if let isEnabled = isEnabled {
            if case .setIsNextButtonEnabled(isEnabled) = operation {
                return true
            }
        } else {
            if case .setIsNextButtonEnabled(_) = operation {
                return true
            }
        }
        return false
    }
    
    static func isOperationSetIsAcitityIndicatorVisible(_ operation: MockSelectAddresssView.Operation,
                                                        withParam isVisible: Bool? = nil) -> Bool {
        if isVisible == nil {
            if case .setIsAcitityIndicatorVisible(_) = operation {
                return true
            }
        } else {
            if case .setIsAcitityIndicatorVisible(isVisible!) = operation {
                return true
            }
        }
        return false
    }
    
    static func isOperationSetAvailableStreets(_ operation: MockSelectAddresssView.Operation,
                                               withParam streets: [Street]? = nil) -> Bool {
        if let streets = streets {
            if case .setAvailableStreets(streets) = operation {
                return true
            }
        } else {
            if case .setAvailableStreets(_) = operation {
                return true
            }
        }
        
        return false
    }
    
    static func isOperationSetAvailableBuildings(_ operation: MockSelectAddresssView.Operation,
                                                 withParam buildings: [Building]? = nil) -> Bool {
        if let buildings = buildings {
            if case .setAvailableBuildings(buildings) = operation {
                return true
            }
        } else {
            if case .setAvailableBuildings(_) = operation {
                return true
            }
        }
        
        return false
    }
    
    // MARK: - Protocol Implementation
    
    func setIsAcitityIndicatorVisible(_ isVisible: Bool) {
        recordedOperations.append(.setIsAcitityIndicatorVisible(isVisible: isVisible))
    }
    
    func showTextForError(_ error: CommonError) {
        recordedOperations.append(.showTextForError(error: error))
    }
    
    func setIsStreetInputEnabled(_ isEnabled: Bool) {
        recordedOperations.append(.setIsStreetInputEnabled(isEnabled: isEnabled))
    }
    
    func setIsBuildingInputEnabled(_ isEnabled: Bool) {
        recordedOperations.append(.setIsBuildingInputEnabled(isEnabled: isEnabled))
    }
    
    func setIsNextButtonEnabled(_ isEnabled: Bool) {
        recordedOperations.append(.setIsNextButtonEnabled(isEnabled: isEnabled))
    }
    
    func setAvailableStreets(_ streets: [Street]) {
        recordedOperations.append(.setAvailableStreets(streets: streets))
    }
    
    func setAvailableBuildings(_ buildings: [Building]) {
        recordedOperations.append(.setAvailableBuildings(buildings: buildings))
    }
    
    
}
