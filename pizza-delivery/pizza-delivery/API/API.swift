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
    
    func resetSession() {
        HTTPCookieStorage.shared.cookies?.forEach(HTTPCookieStorage.shared.deleteCookie)
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
            .responseDecodable { (response: DataResponse<ResponseDto<[PizzaDto]>>) in
                let result = response.result
                    .flatMap({ $0.isError ? .failure(CommonError.unknown) : .success($0.response.data) })
                    .mapError(self.mapErrorToCommonError)
                completion(result)
            }
    }
    
    func getStreets(_ completion: @escaping CommonBlock.ResultCompletionBlock<[StreetDto]>) {
        let urlString = baseUrl + "/streets"
        let parameters = [
            "order": "title:asc"
        ]
        
        AF.request(urlString,
                   parameters: parameters)
            .validate()
            .responseDecodable { (response: DataResponse<ResponseDto<[StreetDto]>>) in
                let result = response.result
                    .flatMap({ $0.isError ? .failure(CommonError.unknown) : .success($0.response.data) })
                    .mapError(self.mapErrorToCommonError)
                completion(result)
            }
    }
    
    func getBuildingsByStreetId(_ streetId: Int,
                                _ completion: @escaping CommonBlock.ResultCompletionBlock<[BuildingDto]>) {
        let urlString = baseUrl + "/streets/\(streetId)"
        let parameters = [
            "order": "title:asc",
            "load": "region.pizzeria"
        ]
        
        AF.request(urlString,
                   parameters: parameters)
            .validate()
            .responseDecodable { [weak self] (response: DataResponse<ResponseDto<[BuildingDto]>>) in
                guard let strongSelf = self else {
                    return
                }
                let result = response.result
                    .flatMap({ $0.isError ? .failure(CommonError.unknown) : .success($0.response.data) })
                    .mapError(strongSelf.mapErrorToCommonError)
                completion(result)
            }
    }
    
    // MARK: - Cart
    
    func addPizza(id: Int, completion: @escaping CommonBlock.ResultCompletionBlock<Void>) {
        let urlString = baseUrl + "/basket/add-item"
        let parameters: Parameters = [
            "type": "pizza",
            "id": id,
            "size": "medium",
            "dough": "thin"
        ]
        
        AF.request(urlString,
                   method: .post,
                   parameters: parameters)
            .validate()
            .responseDecodable { [weak self] (response: DataResponse<VoidResponseDto>) in
                guard let strongSelf = self else {
                    return
                }
                let result = response.result
                    .flatMap({ $0.isError ? .failure(CommonError.unknown) : .success(()) })
                    .mapError(strongSelf.mapErrorToCommonError)
                completion(result)
            }
    }
    
    func updateAddress(
        _ addressDto: AddressDto,
        completion: @escaping CommonBlock.ResultCompletionBlock<Void>) {
        let urlString = baseUrl + "/basket/update-address"
        
        AF.request(urlString,
                   method: .post,
                   parameters: addressDto)
            .validate()
            .responseDecodable { [weak self] (response: DataResponse<VoidResponseDto>) in
                guard let strongSelf = self else {
                    return
                }
                let result = response.result
                    .flatMap({ $0.isError ? .failure(CommonError.unknown) : .success(()) })
                    .mapError(strongSelf.mapErrorToCommonError)
                completion(result)
            }
    }
    
    func saveCart(completion: @escaping CommonBlock.ResultCompletionBlock<Void>) {
        let urlString = baseUrl + "/basket/save"
        AF.request(urlString,
                   method: .post,
                   parameters: nil)
            .validate()
            .responseDecodable { [weak self] (response: DataResponse<VoidResponseDto>) in
                guard let strongSelf = self else {
                    return
                }
                let result = response.result
                    .flatMap({ $0.isError ? .failure(CommonError.unknown) : .success(()) })
                    .mapError(strongSelf.mapErrorToCommonError)
                completion(result)
            }
    }
    
    func getSettings(completion: @escaping CommonBlock.ResultCompletionBlock<SettingsDto>) {
        let urlString = baseUrl + "/settings"
        AF.request(urlString)
            .validate()
            .responseDecodable { (response: DataResponse<ResponseDto<SettingsDto>>) in
                let result = response.result
                    .flatMap({ $0.isError ? .failure(CommonError.unknown) : .success($0.response.data) })
                    .mapError(self.mapErrorToCommonError)
                completion(result)
            }
    }

    // MARK: - Private Methods
    
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
