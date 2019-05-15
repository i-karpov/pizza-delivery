//
//  ModelToDtoMapper.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 11.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

class ModelToDtoMapper {
    
    func map(_ model: OrderDraft) -> AddressDto {
        var isPaymentByCard: Bool!
        var renting: String? = .none
        switch model.paymentMethod {
        case .byCard:
            isPaymentByCard = true
        case .byCash(let cashAmount):
            isPaymentByCard = false
            renting = cashAmount
        }
        return AddressDto(name: model.deliveryDetails.name,
                          apartment: model.deliveryDetails.apartment,
                          entrance: model.deliveryDetails.entrance,
                          floor: model.deliveryDetails.floor,
                          comment: model.deliveryDetails.comment,
                          isPaymentByCard: isPaymentByCard,
                          renting: renting,
                          phone: model.deliveryDetails.phoneNumber,
                          street: model.deliveryDetails.street.title,
                          house: model.deliveryDetails.building.title)
    }

}
