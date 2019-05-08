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
