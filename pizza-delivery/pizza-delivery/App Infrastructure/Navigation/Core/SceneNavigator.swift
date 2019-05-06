//
//  SceneNavigator.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

class SceneNavigator: SceneNavigatorProtocol {
    
    private enum AssociatedObjectsKey {
        static var flow = "UIViewController_Associated_Flow"
    }
    
    private let compositionRoot: CompositionRoot
    
    private let window: UIWindow
    private var currentViewController: UIViewController!
    private var flowsExitors: [CommonBlock.EmptyAction]
    
    required init(window: UIWindow, rootScene: Scene, compositionRoot: CompositionRoot) {
        self.compositionRoot = compositionRoot
        self.window = window
        flowsExitors = []
        self.compositionRoot.navigator = self
        initViewControllerHierarchy(withRootScene: rootScene)
    }
    
    private func initViewControllerHierarchy(withRootScene rootScene: Scene) {
        let viewController = compositionRoot.composeScene(rootScene)
        currentViewController = actualViewController(for: viewController)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    private func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            guard let firstViewController = navigationController.viewControllers.first else {
                fatalError("NavigationController is expected to have at least one View Controller")
            }
            return firstViewController
        } else {
            return viewController
        }
    }

    // MARK: - Navigate To Next Scene
    
    private func navigateTo(_ viewController: UIViewController, transitionType: SceneTransitionType) {
        switch transitionType {
        case .root:
            replaceRootWith(viewController)
        case .push:
            pushTo(viewController)
        case .modal:
            presentAsModal(viewController)
        }
    }
    
    func navigateTo(_ scene: Scene, transitionType: SceneTransitionType) {
        let viewController = compositionRoot.composeScene(scene)
        navigateTo(viewController, transitionType: transitionType)
    }
    
    private func replaceRootWith(_ targetViewController: UIViewController) {
        currentViewController = actualViewController(for: targetViewController)
        window.set(rootViewController: targetViewController)
    }
    
    private func pushTo(_ targetViewController: UIViewController) {
        var currentController = currentViewController
        if let tabBarController = actualViewController(for: currentViewController) as? UITabBarController {
            currentController = tabBarController.selectedViewController
        }
        
        if let navigationController = currentController?.navigationController {
            currentController = navigationController
        }
        guard let navigationController = currentController as? UINavigationController else {
            fatalError("Can't push a view controller without a current navigation controller")
        }
        
        navigationController.pushViewController(targetViewController, animated: true)
    }
    
    private func presentAsModal(_ targetViewController: UIViewController) {
        targetViewController.modalTransitionStyle = .crossDissolve
        currentViewController.present(targetViewController, animated: true)
        currentViewController = actualViewController(for: targetViewController)
    }
    
    // MARK: - Return Back To Previous Scene
    
    func returnToPreviousScene(animated: Bool) {
        if let presentingViewController = currentViewController.presentingViewController {
            // dismiss a modal controller
            currentViewController.dismiss(animated: animated) {
                self.currentViewController = self.actualViewController(for: presentingViewController)
            }
        } else if let navigationController = currentViewController.navigationController {
            navigateUpTheStackIn(navigationController, animated: animated)
        } else if let tabBarController = currentViewController as? UITabBarController {
            // navigate up the stack in TabBar
            navigateUpTheStackIn(tabBarController, animated: animated)
        } else {
            let viewDesc = String(describing: currentViewController)
            fatalError("Not a modal, no navigation controller: can't navigate back from \(viewDesc))")
        }
    }
    
    private func navigateUpTheStackIn(_ navigationController: UINavigationController, animated: Bool) {
        guard navigationController.popViewController(animated: animated) != nil else {
            fatalError("can't navigate back from \(String(describing: currentViewController))")
        }
        guard let lastViewController = navigationController.viewControllers.last else {
            fatalError("NavigationController is expected to have at least one View Controller")
        }
        currentViewController = actualViewController(for: lastViewController)
    }
    
    private func navigateUpTheStackIn(_ tabBarController: UITabBarController, animated: Bool) {
        guard let navigationController = tabBarController.selectedViewController as? UINavigationController else {
            let selectedViewCOntrollerDescription = String(describing: tabBarController.selectedViewController)
            fatalError("no navigation controller: can't navigate back from \(selectedViewCOntrollerDescription)")
        }
        guard navigationController.popViewController(animated: animated) != nil else {
            fatalError("can't navigate back from \(String(describing: tabBarController.selectedViewController))")
        }
    }
    
    // MARK: - Flows
    
    func startFlow(_ flow: Flow, transitionType: SceneTransitionType) {
        guard transitionType == .modal else {
            fatalError("Starting flow not as modals is not supported yet.")
        }
        
        flowsExitors.append({ [weak currentViewController] in
            currentViewController?.dismiss(animated: true, completion: nil)
        })
        
        let flow = compositionRoot.composeFlow(flow)
        flow.start(rootTransitionType: transitionType)
    }
    
    func navigateTo(_ scene: Scene, retainingFlow flowToRetain: Any, transitionType: SceneTransitionType) {
        let viewController = compositionRoot.composeScene(scene)
        retainFlow(flowToRetain, by: viewController)
        navigateTo(viewController, transitionType: transitionType)
    }
    
    func exitCurrentFlow(animated: Bool) {
        guard let exitFlow = flowsExitors.last else {
            fatalError("Cannot exit unexisting flow.")
        }
        
        exitFlow()
        _ = flowsExitors.removeLast()
    }
    
    // MARK: - Private Helpers
    
    private func retainFlow(_ flow: Any, by viewController: UIViewController) {
        objc_setAssociatedObject(viewController,
                                 &AssociatedObjectsKey.flow,
                                 flow,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
