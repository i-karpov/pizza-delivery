//
//  AppDelegate.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 30.04.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var navigator: SceneNavigatorProtocol!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        navigator = SceneNavigator(window: UIWindow(frame: UIScreen.main.bounds),
                                   rootScene: .splash,
                                   compositionRoot: makeCompositionRoot())
        
        setupAppearance()
        
        return true
    }
    
    private func setupAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        ]
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
    }
}
