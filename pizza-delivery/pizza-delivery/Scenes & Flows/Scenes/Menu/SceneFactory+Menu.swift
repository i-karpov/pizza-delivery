import UIKit

extension SceneFactory {
    
    internal static func makeMenu(navigator: SceneNavigatorProtocol,
                                  menuService: MenuServiceProtocol,
                                  errorToTextMapper: ErrorToTextMapper) -> UIViewController {
            
        let viewController: MenuViewController = MenuViewController.storyboardInstance()
        let presenter = MenuPresenter(
            view: viewController,
            navigator: navigator,
            menuService: menuService)
        viewController.presenter = presenter
        viewController.errorToTextMapper = errorToTextMapper
        
        return viewController
    }
}
