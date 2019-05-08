//
//  MockOrderService.swift
//  pizza-delivery-unit-tests
//
//  Created by Igor Karpov on 08.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation
@testable import pizza_delivery

class MockOrderService: OrderServiceProtocol {
    
    struct Responses {
        var getStreets: Result<[Street], CommonError>!
        var getBuildings: Result<[Building], CommonError>!
    }
    
    enum Operation {
        case getStreets
        case getBuildings(streetId: Int)
    }
    
    var responses = Responses()
    var recordedOperations = [Operation]()
    
    func getStreets(_ completion: @escaping CommonBlock.ResultCompletionBlock<[Street]>) {
        recordedOperations.append(.getStreets)
        completion(responses.getStreets)
    }
    
    func getBuildingsByStreetId(_ streetId: Int,
                                _ completion: @escaping CommonBlock.ResultCompletionBlock<[Building]>) {
        recordedOperations.append(.getBuildings(streetId: streetId))
        completion(responses.getBuildings)
    }
}
