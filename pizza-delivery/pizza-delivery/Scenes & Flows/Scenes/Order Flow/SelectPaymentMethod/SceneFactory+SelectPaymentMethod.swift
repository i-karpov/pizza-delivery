import UIKit

extension SceneFactory {
    
    internal static func makeSelectPaymentMethod(
        navigator: SceneNavigatorProtocol,
        initData: SelectPaymentMethodInitData) -> UIViewController {
            
        let viewController: SelectPaymentMethodViewController = SelectPaymentMethodViewController.storyboardInstance()
        let presenter = SelectPaymentMethodPresenter(
            view: viewController,
            navigator: navigator,
            initData: initData)
        viewController.presenter = presenter
        
        return viewController
    }
}