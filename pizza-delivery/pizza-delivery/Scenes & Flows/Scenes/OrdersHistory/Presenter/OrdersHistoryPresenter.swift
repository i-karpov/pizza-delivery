import Foundation

class OrdersHistoryPresenter {

    private unowned let view: OrdersHistoryViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    init(view: OrdersHistoryViewProtocol,
         navigator: SceneNavigatorProtocol) {
        self.view = view
        self.navigator = navigator
    }

}

// MARK: - Presenter Protocol

extension OrdersHistoryPresenter: OrdersHistoryPresenterProtocol {

    func handleViewLoaded() {
        // Method is called after view loading is finished.
    }

}
