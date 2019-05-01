import UIKit

extension SceneFactory {
    
    internal static func makeOrdersHistory(navigator: SceneNavigatorProtocol) -> UIViewController {
            
        let viewController: OrdersHistoryViewController = OrdersHistoryViewController.storyboardInstance()
        let presenter = OrdersHistoryPresenter(
            view: viewController,
            navigator: navigator)
        viewController.presenter = presenter
        
        return viewController
    }
}
