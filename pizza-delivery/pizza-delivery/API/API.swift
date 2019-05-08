//
//  API.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation
import Alamofire

class API: APIProtocol {
    
    private let baseUrl: String
    
    init(urlsConfig: UrlsConfigProtocol) {
        self.baseUrl = urlsConfig.baseUrl
    }
    
    func getPizzas(_ completion: @escaping CommonBlock.ResultCompletionBlock<[PizzaDto]>) {
        
        let urlString = baseUrl + "/pizzas"
        let parameters = [
            "filter": "meal_only:0",
            "order": "position:asc"
        ]
        
        AF.request(urlString,
                   parameters: parameters)
            .validate()
            .responseDecodable { (response: DataResponse<ArrayResponseDto<PizzaDto>>) in
                let result = response.result
                    .map({ $0.response.data })
                    .mapError(self.mapErrorToCommonError)
                completion(result)
            }
    }
    
    func getStreets(_ completion: @escaping CommonBlock.ResultCompletionBlock<[StreetDto]>) {
        fatalError("Not implemented")
    }
    
    func getBuildingsByStreetId(_ streetId: Int,
                                _ completion: @escaping CommonBlock.ResultCompletionBlock<[BuildingDto]>) {
        fatalError("Not implemented")
    }
    
    private func mapErrorToCommonError(_ error: Error) -> CommonError {
        if let urlError = error as? URLError {
            return mapURLErrorToCommon(urlError)
        } else if let afError = error as? AFError {
            return mapAFErrorToCommon(afError)
        } else {
            return .unknown
        }
    }
    
    private func mapURLErrorToCommon(_ urlError: URLError) -> CommonError {
        if urlError.code == URLError.Code.notConnectedToInternet {
            return .serverCommunicationError(.noConnection)
        } else {
            return .serverCommunicationError(.unknown)
        }
    }
    
    private func mapAFErrorToCommon(_ afError: AFError) -> CommonError {
        switch afError {
        case .responseSerializationFailed(let reason):
            switch reason {
            case .decodingFailed:
                return .appError(.parsingFailure)
            case .inputDataNilOrZeroLength:
                return .appError(.invalidData)
            default:
                return .serverCommunicationError(.unknown)
            }
        default:
            return .serverCommunicationError(.unknown)
        }
    }
}
