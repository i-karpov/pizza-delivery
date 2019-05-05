import Foundation

class OrdersHistoryPresenter {

    private unowned let view: OrdersHistoryViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let initData: OrdersHistoryInitData

    init(view: OrdersHistoryViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: OrdersHistoryInitData) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
    }

}

// MARK: - Presenter Protocol

extension OrdersHistoryPresenter: OrdersHistoryPresenterProtocol {

    func handleViewLoaded() {
        // Method is called after view loading is finished.
    }

}
