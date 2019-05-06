//
//  SceneNavigatorProtocol.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

protocol SceneNavigatorProtocol: class {
    
    func navigateTo(_ scene: Scene, transitionType: SceneTransitionType)
    func returnToPreviousScene(animated: Bool)
    
    func startFlow(_ flow: Flow, transitionType: SceneTransitionType)
    func navigateTo(_ scene: Scene, retainingFlow flowToRetain: Any, transitionType: SceneTransitionType)
}
