//
//  SettingsDto.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 11.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

struct SettingsDto: Decodable {
    let isDeliveryTime45: Bool
    
    enum CodingKeys: String, CodingKey {
        case isDeliveryTime45 = "is_delivery_45"
    }
}
