import UIKit

extension SceneFactory {
    
    internal static func makeEnterDeliveryDetails(
        navigator: SceneNavigatorProtocol,
        initData: EnterDeliveryDetailsInitData) -> UIViewController {
            
        let viewController: EnterDeliveryDetailsViewController = EnterDeliveryDetailsViewController.storyboardInstance()
        let presenter = EnterDeliveryDetailsPresenter(
            view: viewController,
            navigator: navigator,
            initData: initData)
        viewController.presenter = presenter
        
        return viewController
    }
}