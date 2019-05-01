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
    
    func composeScene(_ scene: Scene) -> UIViewController {
        let factoryMethodsMap = getScenesFactoryMethodsMap()
        guard let makeScene = factoryMethodsMap[scene] else {
            fatalError("Cannot compose unrecognized scene.")
        }
        
        let scene = makeScene()
        return scene
    }
    
    // MARK: - Private
    
    private func getScenesFactoryMethodsMap() -> [Scene: () -> UIViewController] {
        let factoryMethodsMap: [Scene: () -> UIViewController] = [
            .splash: { [unowned self] in
                SceneFactory.makeSplash(navigator: self.navigator)
            },
            .menu: { [unowned self] in
                SceneFactory.makeMenu(navigator: self.navigator)
            },
            .ordersHistory: { [unowned self] in
                SceneFactory.makeOrdersHistory(navigator: self.navigator)
            },
            .tabs: { [unowned self] in
                SceneFactory.makeTabs(
                    navigator: self.navigator,
                    menuScene: self.composeScene(.menu),
                    ordersHistoryScene: self.composeScene(.ordersHistory))
            }
        ]
        return factoryMethodsMap
    }
    
    private func composeScene<T: UIViewController>(_ scene: Scene) -> T {
        guard let sceneModul = composeScene(scene) as? T else {
            fatalError("Could not compose scene: \(scene)")
        }
        return sceneModul
    }
}
