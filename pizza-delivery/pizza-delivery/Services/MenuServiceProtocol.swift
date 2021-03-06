//
//  MenuServiceProtocol.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

protocol MenuServiceProtocol {
    
    func getPizzas(_ completion: @escaping CommonBlock.ResultCompletionBlock<[Pizza]>)
    
}
