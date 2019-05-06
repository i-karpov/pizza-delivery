import UIKit

extension SceneFactory {
    
    internal static func makeSelectAddress(
        navigator: SceneNavigatorProtocol,
        initData: SelectAddressInitData) -> UIViewController {
            
        let viewController: SelectAddressViewController = SelectAddressViewController.storyboardInstance()
        let presenter = SelectAddressPresenter(
            view: viewController,
            navigator: navigator,
            initData: initData)
        viewController.presenter = presenter
        
        return viewController
    }
}
