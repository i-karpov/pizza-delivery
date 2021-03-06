//
//  Pizza.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

struct Pizza: Equatable {
    let id: Int
    let title: String
    let price: MoneyAmount
    let description: String
    let smallImageUrl: String
}
