//
//  DeliveryDetails.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

struct DeliveryDetails: Equatable {
    
    let street: Street
    let building: Building
    let name: String
    let phoneNumber: String
    let entrance: String
    let apartment: String
    let floor: String
    let comment: String
    
}
