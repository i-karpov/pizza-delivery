//
//  AppDelegate+CompositionRootFactory.swift
//  pizza-delivery-fake
//
//  Created by Igor Karpov on 12.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

extension AppDelegate {
    func makeCompositionRoot() -> CompositionRoot {
        return CompositionRoot(urlsConfig: FakeServerUrlsConfig())
    }
}
