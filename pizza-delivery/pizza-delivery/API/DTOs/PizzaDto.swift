//
//  PizzaDto.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

struct PizzaDto: Codable {
    
    let id: Int
    let title: String
    let priceForMediumSize: Int
    let description: String
    let smallImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case priceForMediumSize = "medium_price"
        case description = "anonce"
        case smallImageUrl = "photo_small"
    }
}
