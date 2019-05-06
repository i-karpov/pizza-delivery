import UIKit

extension SceneFactory {
    
    internal static func makeOrderSuccessScreen(
        navigator: SceneNavigatorProtocol,
        initData: OrderSuccessScreenInitData) -> UIViewController {
            
        let viewController: OrderSuccessScreenViewController = OrderSuccessScreenViewController.storyboardInstance()
        let presenter = OrderSuccessScreenPresenter(
            view: viewController,
            navigator: navigator,
            initData: initData)
        viewController.presenter = presenter
        
        return viewController
    }
}
