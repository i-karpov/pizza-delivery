//
//  PaymentMethod.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

enum PaymentMethod {
    case byCard
    case byCash(cashAmountToCalculateChange: MoneyAmount)
}
