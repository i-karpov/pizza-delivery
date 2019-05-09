//
//  OrderService.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 08.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

class OrderService: OrderServiceProtocol {
    
    private let api: APIProtocol
    private let mapper: DtoToModelMapper
    
    init(api: APIProtocol, mapper: DtoToModelMapper) {
        self.api = api
        self.mapper = mapper
    }
    
    func getStreets(_ completion: @escaping CommonBlock.ResultCompletionBlock<[Street]>) {
        api.getStreets { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            completion(result.map({ $0.map(strongSelf.mapper.map) }))
        }
    }
    
    func getBuildingsByStreetId(_ streetId: Int,
                                _ completion: @escaping CommonBlock.ResultCompletionBlock<[Building]>) {
        api.getBuildingsByStreetId(streetId) { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            completion(result.map({ $0.map(strongSelf.mapper.map) }))
        }
    }
    
}
