import UIKit

extension SceneFactory {
    
    internal static func makeMenu(navigator: SceneNavigatorProtocol) -> UIViewController {
            
        let viewController: MenuViewController = MenuViewController.storyboardInstance()
        let presenter = MenuPresenter(
            view: viewController,
            navigator: navigator)
        viewController.presenter = presenter
        
        return viewController
    }
}
