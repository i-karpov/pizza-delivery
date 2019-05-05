//
//  DtoToModelMapper.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

class DtoToModelMapper {
    
    func map(_ pizzaDto: PizzaDto) -> Pizza {
        return Pizza(id: pizzaDto.id,
                     title: pizzaDto.title,
                     price: Price(cents: pizzaDto.priceForMediumSize / 100),
                     description: pizzaDto.description,
                     smallImageUrl: pizzaDto.smallImageUrl)
    }

}
