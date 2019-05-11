//
//  SomeResponse.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 11.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

struct VoidResponseDto: Decodable {
    let isError: Bool
    
    enum CodingKeys: String, CodingKey {
        case isError = "error"
    }
}
