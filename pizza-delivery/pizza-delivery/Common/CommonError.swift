//
//  CommonError.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

enum CommonError: Error {
    case serverCommunicationError(ServerCommunicationError)
    case serverBusinessError(String)
    case appError(AppError)
}

enum ServerCommunicationError: Error {
    case noConnection
    case unknown
}

enum AppError: Error {
    case parsingFailure
    case invalidData
}
