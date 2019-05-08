import UIKit

extension SceneFactory {
    
    internal static func makeSelectAddress(
        navigator: SceneNavigatorProtocol,
        initData: SelectAddressInitData,
        orderService: OrderServiceProtocol) -> UIViewController {
            
        let viewController: SelectAddressViewController = SelectAddressViewController.storyboardInstance()
        let presenter = SelectAddressPresenter(
            view: viewController,
            navigator: navigator,
            initData: initData,
            orderService: orderService)
        viewController.presenter = presenter
        
        return viewController
    }
}
