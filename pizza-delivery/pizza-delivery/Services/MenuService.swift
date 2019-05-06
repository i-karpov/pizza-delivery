//
//  MenuService.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

class MenuService: MenuServiceProtocol {
    
    private let api: APIProtocol
    private let mapper: DtoToModelMapper
    
    init(api: APIProtocol, mapper: DtoToModelMapper) {
        self.api = api
        self.mapper = mapper
    }
    
    func getPizzas(_ completion: @escaping CommonBlock.ResultCompletionBlock<[Pizza]>) {
        api.getPizzas { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            completion(result.map({ $0.map(strongSelf.mapper.map) }))
        }

    }
    
}
