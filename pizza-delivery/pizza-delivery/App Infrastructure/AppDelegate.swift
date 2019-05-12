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
        handleAppLaunched()
        navigator = SceneNavigator(window: UIWindow(frame: UIScreen.main.bounds),
                                   rootScene: .splash,
                                   compositionRoot: makeCompositionRoot())
        
        return true
    }
}
