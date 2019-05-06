import UIKit

extension SceneFactory {
    
    internal static func makeTabs(
        navigator: SceneNavigatorProtocol,
        menuScene: MenuViewController,
        ordersHistoryScene: OrdersHistoryViewController) -> UIViewController {
            
        let viewController: TabsViewController = TabsViewController.storyboardInstance()
        viewController.setupViewControllers(menuScene: menuScene,
                                            ordersHistoryScene: ordersHistoryScene)
        let presenter = TabsPresenter(view: viewController, navigator: navigator)
        viewController.presenter = presenter
        
        return viewController
    }
}
