//
//  PizzasResponseDto.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

struct ArrayResponseDto<T>: Codable where T: Codable {
    struct ResponseDto: Codable {
        let data: [T]
    }
    
    let error: Bool
    let response: ResponseDto
}
