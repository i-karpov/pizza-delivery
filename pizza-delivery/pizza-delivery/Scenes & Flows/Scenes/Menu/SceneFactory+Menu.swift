import UIKit

extension SceneFactory {
    
    internal static func makeMenu(navigator: SceneNavigatorProtocol,
                                  menuService: MenuServiceProtocol) -> UIViewController {
            
        let viewController: MenuViewController = MenuViewController.storyboardInstance()
        let presenter = MenuPresenter(
            view: viewController,
            navigator: navigator,
            menuService: menuService)
        viewController.presenter = presenter
        
        return viewController
    }
}
