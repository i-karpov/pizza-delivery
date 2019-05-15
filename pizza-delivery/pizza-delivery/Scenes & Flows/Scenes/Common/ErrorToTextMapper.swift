//
//  ErrorToTextMapper.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 09.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

class ErrorToTextMapper {
    
    func makeErrorTextForError(_ error: CommonError) -> String {
        switch error {
        case .serverBusinessError(let errorText):
            return errorText
        case .serverCommunicationError(.noConnection):
            return R.string.localizable.commonErrorMessageNoConnection()
        default:
            return R.string.localizable.commonErrorMessageGeneric()
        }
    }
    
}
