//
//  Scene.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

enum Scene {
    
    enum Order {
        case selectAddress(SelectAddressInitData)
        case enterDeliveryDetails(EnterDeliveryDetailsInitData)
        case selectPaymentMethod(SelectPaymentMethodInitData)
        case confirmOrder(ConfirmOrderInitData)
        case success(OrderSuccessScreenInitData)
    }
    
    case splash
    case tabs
    case menu
    case ordersHistory
    case order(Order)
}

