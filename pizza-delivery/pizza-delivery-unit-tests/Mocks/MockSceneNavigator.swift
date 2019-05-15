//
//  MockSceneNavigator.swift
//  pizza-delivery-unit-tests
//
//  Created by Igor Karpov on 05.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation
@testable import pizza_delivery

class MockSceneNavigator: SceneNavigatorProtocol {

    enum Operation {
        case navigateTo(scene: Scene, transitionType: SceneTransitionType)
        case returnToPreviousScene(animated: Bool)
        case startFlow(flow: Flow, transitionType: SceneTransitionType)
        case navigateTo(scene: Scene, flowToRetain: Any, transitionType: SceneTransitionType)
        case exitCurrentFlow(animated: Bool)
    }
    
    var recordedOperations = [Operation]()
    
    func navigateTo(_ scene: Scene, transitionType: SceneTransitionType) {
        recordedOperations.append(.navigateTo(scene: scene, transitionType: transitionType))
    }
    
    func returnToPreviousScene(animated: Bool) {
        recordedOperations.append(.returnToPreviousScene(animated: animated))
    }
    
    func startFlow(_ flow: Flow, transitionType: SceneTransitionType) {
        recordedOperations.append(.startFlow(flow: flow, transitionType: transitionType))
    }
    
    func navigateTo(_ scene: Scene, retainingFlow flowToRetain: Any, transitionType: SceneTransitionType) {
        recordedOperations.append(.navigateTo(scene: scene,
                                              flowToRetain: flowToRetain,
                                              transitionType: transitionType))
    }
    
    func exitCurrentFlow(animated: Bool) {
        recordedOperations.append(.exitCurrentFlow(animated: animated))
    }
}
