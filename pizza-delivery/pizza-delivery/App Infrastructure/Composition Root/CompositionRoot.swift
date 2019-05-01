//
//  CompositionRoot.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

class CompositionRoot {
    
    var navigator: SceneNavigatorProtocol!
    private let serviceFactory: ServiceFactoryProtocol
    
    init(serviceFactory: ServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory
    }

    private func getScenesFactoryMethodsMap() -> [Scene: () -> UIViewController] {
        let factoryMethodsMap: [Scene: () -> UIViewController] = [
            .splash: { [unowned self] in
                SceneFactory.makeSplash(navigator: self.navigator)
            }
        ]
        return factoryMethodsMap
    }
    
    func composeScene(_ scene: Scene) -> UIViewController {
        let factoryMethodsMap = getScenesFactoryMethodsMap()
        guard let makeScene = factoryMethodsMap[scene] else {
            fatalError("Cannot compose unrecognized scene.")
        }
        
        let scene = makeScene()
        return scene
    }
}
