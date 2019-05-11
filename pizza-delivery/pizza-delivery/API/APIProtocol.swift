//
//  APIProtocol.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

protocol APIProtocol {
    
    func resetSession()
    
    func getPizzas(_ completion: @escaping CommonBlock.ResultCompletionBlock<[PizzaDto]>)
    func getStreets(_ completion: @escaping CommonBlock.ResultCompletionBlock<[StreetDto]>)
    func getBuildingsByStreetId(_ streetId: Int,
                                _ completion: @escaping CommonBlock.ResultCompletionBlock<[BuildingDto]>)
    
    func addPizza(id: Int, completion: @escaping CommonBlock.ResultCompletionBlock<Void>)
    func updateAddress(_ addressDto: AddressDto, completion: @escaping CommonBlock.ResultCompletionBlock<Void>)
    func saveCart(completion: @escaping CommonBlock.ResultCompletionBlock<Void>)
    func getSettings(completion: @escaping CommonBlock.ResultCompletionBlock<SettingsDto>)
}
