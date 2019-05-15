//
//  UpdateAddressDto.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 11.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation


struct AddressDto: Encodable {
    
    let name: String
    let apartment: String
    let entrance: String
    let floor: String
    let intercom = ""
    let comment: String
    let preorderDate = ""
    let preorderTime = ""
    let payment: String
    let renting: String
    let phone: String
    let street: String
    let house: String
    
    init(name: String?,
         apartment: String?,
         entrance: String?,
         floor: String?,
         comment: String?,
         isPaymentByCard: Bool,
         renting: String?,
         phone: String,
         street: String,
         house: String) {
        self.name = name ?? ""
        self.apartment = apartment ?? ""
        self.entrance = entrance ?? ""
        self.floor = floor ?? ""
        self.comment = comment ?? ""
        payment = isPaymentByCard ? "charge" : "cash"
        self.renting = renting ?? ""
        self.phone = phone
        self.street = street
        self.house = house
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case apartment = "flat"
        case entrance = "entrance"
        case floor = "floor"
        case intercom = "intercom"
        case comment = "comment"
        case preorderDate = "preorder_date"
        case preorderTime = "preorder_time"
        case payment = "payment"
        case renting = "renting"
        case phone = "phone"
        case street = "street"
        case house = "house"
    }

}
