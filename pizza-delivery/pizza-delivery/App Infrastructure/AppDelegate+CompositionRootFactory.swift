//
//  AppDelegate+CompositionRootFactory.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

extension AppDelegate {
    func makeCompositionRoot() -> CompositionRoot {
        return CompositionRoot(serviceFactory: ServiceFactory())
    }
}
