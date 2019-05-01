//
//  API.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 02.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

class API: APIProtocol {
    
    private let urlsConfig: UrlsConfigProtocol
    
    init(urlsConfig: UrlsConfigProtocol) {
        self.urlsConfig = urlsConfig
    }
    
    func getPizzas(_ completion: @escaping CommonBlock.ResultCompletionBlock<[PizzaDto]>) {
        
        completion(.success([
                PizzaDto(id: "1",
                         title: "Pizza 1",
                         priceCentsForMediumSize: 12600,
                         description: "Description 1",
                         smallImageUrl: "https://tinyurl.com/y2owbr6b"),
                PizzaDto(id: "2",
                      title: "Pizza 2",
                      priceCentsForMediumSize: 17600,
                      description: "Description 2",
                      smallImageUrl: "https://tinyurl.com/y2owbr6b")
            ]))
    }
    
}
