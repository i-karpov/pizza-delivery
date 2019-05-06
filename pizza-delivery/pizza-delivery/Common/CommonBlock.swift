//
//  CommonBlock.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

enum CommonBlock {
    typealias ResultCompletionBlock<T> = (_ response: Result<T, CommonError>) -> Void
}
