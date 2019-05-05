import UIKit

extension SceneFactory {
    
    internal static func makeSplash(navigator: SceneNavigatorProtocol) -> UIViewController {
            
        let viewController: SplashViewController = SplashViewController.storyboardInstance()
        let presenter = SplashPresenter(
            view: viewController,
            navigator: navigator)
        viewController.presenter = presenter
        
        return viewController
    }
}
