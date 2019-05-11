//
//  OrderServiceProtocol.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 08.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

protocol OrderServiceProtocol {
    
    func getStreets(_ completion: @escaping CommonBlock.ResultCompletionBlock<[Street]>)
    func getBuildingsByStreetId(_ streetId: Int,
                                _ completion: @escaping CommonBlock.ResultCompletionBlock<[Building]>)
    func sendOrder(_ orderDraft: OrderDraft,
                   _ completion: @escaping CommonBlock.ResultCompletionBlock<DeliveryWaitingTime>)
}
