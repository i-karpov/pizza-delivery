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
    private let dtoToModelMapper: DtoToModelMapper
    private let modelToDtoMapper: ModelToDtoMapper
    
    init(api: APIProtocol,
         dtoToModelMapper: DtoToModelMapper,
         modelToDtoMapper: ModelToDtoMapper) {
        self.api = api
        self.dtoToModelMapper = dtoToModelMapper
        self.modelToDtoMapper = modelToDtoMapper
    }
    
    func getStreets(_ completion: @escaping CommonBlock.ResultCompletionBlock<[Street]>) {
        api.getStreets { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            completion(result.map({ $0.map(strongSelf.dtoToModelMapper.map) }))
        }
    }
    
    func getBuildingsByStreetId(_ streetId: Int,
                                _ completion: @escaping CommonBlock.ResultCompletionBlock<[Building]>) {
        api.getBuildingsByStreetId(streetId) { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            completion(result.map({ $0.map(strongSelf.dtoToModelMapper.map) }))
        }
    }
    
    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length
    func sendOrder(_ orderDraft: OrderDraft,
                   _ completion: @escaping CommonBlock.ResultCompletionBlock<DeliveryWaitingTime>) {
        
        // TODO: refactor chaining with pormises.
        
        let handleSuccess: (DeliveryWaitingTime) -> Void = { [weak self] time in
            self?.api.resetSession()
            completion(.success(time))
        }
        
        let handleError: (CommonError) -> Void = { [weak self] error in
            self?.api.resetSession()
            completion(.failure(error))
        }
        
        var deliveryWaitingTime: DeliveryWaitingTime!
        
        let getSettings: (@escaping CommonBlock.EmptyAction) -> Void = {
            [weak self] (next: @escaping CommonBlock.EmptyAction) -> Void in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.api.getSettings { [weak strongSelf] (settingsResult) in
                guard let strongSelf = strongSelf else {
                    return
                }
                switch settingsResult {
                case .success(let settingsDto):
                    deliveryWaitingTime = strongSelf.dtoToModelMapper.map(settingsDto)
                    next()
                case .failure(let error):
                    handleError(error)
                }
            }
        }
        
        let addPizza: (@escaping CommonBlock.EmptyAction) -> Void = {
            [weak self] (next: @escaping CommonBlock.EmptyAction) -> Void in
        
            self?.api.addPizza(id: orderDraft.pizza.id) { (result) in
                switch result {
                case .success:
                    next()
                case .failure(let error):
                    handleError(error)
                }
            }
        }
        
        let updateAddress: (@escaping CommonBlock.EmptyAction) -> Void = {
            [weak self] (next: @escaping CommonBlock.EmptyAction) -> Void in
            guard let strongSelf = self else {
                return
            }
            
            let addressDto = strongSelf.modelToDtoMapper.map(orderDraft)
            strongSelf.api.updateAddress(addressDto) { (result) in
                switch result {
                case .success:
                    next()
                case .failure(let error):
                    handleError(error)
                }
            }
        }
        
        let saveCart: (@escaping CommonBlock.EmptyAction) -> Void = {
            [weak self] (next: @escaping CommonBlock.EmptyAction) -> Void in

            self?.api.saveCart { (settingsResult) in
                switch settingsResult {
                case .success:
                    next()
                case .failure(let error):
                    handleError(error)
                }
            }
        }
        
        getSettings {
            addPizza {
                updateAddress {
                    saveCart {
                        handleSuccess(deliveryWaitingTime)
                    }
                }
            }
        }
        
    }
    // swiftlint:enable cyclomatic_complexity
    // swiftlint:enable function_body_length
}
