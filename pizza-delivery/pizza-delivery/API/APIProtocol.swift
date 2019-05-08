//
//  APIProtocol.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

protocol APIProtocol {
    
    func getPizzas(_ completion: @escaping CommonBlock.ResultCompletionBlock<[PizzaDto]>)
    func getStreets(_ completion: @escaping CommonBlock.ResultCompletionBlock<[StreetDto]>)
    func getBuildingsByStreetId(_ streetId: Int,
                                _ completion: @escaping CommonBlock.ResultCompletionBlock<[BuildingDto]>)
    
}
