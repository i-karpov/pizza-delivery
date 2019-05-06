import Foundation

class OrderSuccessScreenPresenter {

    private unowned let view: OrderSuccessScreenViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let initData: OrderSuccessScreenInitData

    init(view: OrderSuccessScreenViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: OrderSuccessScreenInitData) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
    }

}

// MARK: - Presenter Protocol

extension OrderSuccessScreenPresenter: OrderSuccessScreenPresenterProtocol {

    func handleViewLoaded() {
        // Method is called after view loading is finished.
    }

}
