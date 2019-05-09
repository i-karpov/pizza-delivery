//
//  DtoToModelMapper.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

class DtoToModelMapper {
    
    func map(_ dto: PizzaDto) -> Pizza {
        return Pizza(id: dto.id,
                     title: dto.title,
                     price: MoneyAmount(cents: dto.priceForMediumSize / 100),
                     description: dto.description,
                     smallImageUrl: dto.smallImageUrl)
    }
    
    func map(_ dto: StreetDto) -> Street {
        return Street(id: dto.id,
                     title: dto.title)
    }
    
    func map(_ dto: BuildingDto) -> Building {
        return Building(id: dto.id,
                        title: dto.title)
    }
}
