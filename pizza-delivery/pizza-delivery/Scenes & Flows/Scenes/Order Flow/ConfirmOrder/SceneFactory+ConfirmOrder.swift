import UIKit

extension SceneFactory {
    
    internal static func makeConfirmOrder(
        navigator: SceneNavigatorProtocol,
        initData: ConfirmOrderInitData,
        orderService: OrderServiceProtocol,
        errorToTextMapper: ErrorToTextMapper) -> UIViewController {
            
        let viewController: ConfirmOrderViewController = ConfirmOrderViewController.storyboardInstance()
        let presenter = ConfirmOrderPresenter(
            view: viewController,
            navigator: navigator,
            initData: initData,
            orderService: orderService)
        viewController.presenter = presenter
        viewController.errorToTextMapper = errorToTextMapper
        
        return viewController
    }
}
