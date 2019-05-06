//
//  PizzasResponseDto.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

struct PizzasResponseDto: Codable {
    struct ResponseDto: Codable {
        let data: [PizzaDto]
    }
    
    let error: Bool
    let response: ResponseDto
}
