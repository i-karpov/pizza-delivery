//
//  FakeServerUrlsConfig.swift
//  pizza-delivery-fake
//
//  Created by Igor Karpov on 12.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

struct FakeServerUrlsConfig: UrlsConfigProtocol {
    let baseUrl: String = "http://localhost:8080/api/v1"
}
