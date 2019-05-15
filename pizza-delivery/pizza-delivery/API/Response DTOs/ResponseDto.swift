//
//  PizzasResponseDto.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

struct ResponseDto<T>: Decodable where T: Decodable {
    struct ResponseDto: Decodable {
        let data: T
    }
    
    let isError: Bool
    let response: ResponseDto
    
    enum CodingKeys: String, CodingKey {
        case isError = "error"
        case response
    }
}
