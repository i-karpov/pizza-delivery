//
//  MockMenuService.swift
//  pizza-delivery-unit-tests
//
//  Created by Igor Karpov on 05.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation
@testable import pizza_delivery

class MockMenuService: MenuServiceProtocol {
    
    struct Responses {
        var getPizzas: Result<[Pizza], CommonError>!
    }
    
    var responses = Responses()
    
    func getPizzas(_ completion: @escaping CommonBlock.ResultCompletionBlock<[Pizza]>) {
        completion(responses.getPizzas)
    }
}
