import UIKit

extension SceneFactory {
    
    internal static func makeConfirmOrder(
        navigator: SceneNavigatorProtocol,
        initData: ConfirmOrderInitData) -> UIViewController {
            
        let viewController: ConfirmOrderViewController = ConfirmOrderViewController.storyboardInstance()
        let presenter = ConfirmOrderPresenter(
            view: viewController,
            navigator: navigator,
            initData: initData)
        viewController.presenter = presenter
        
        return viewController
    }
}