//
//  StreetDto.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 08.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

struct StreetDto: Codable {
    
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}
