import Foundation

class EnterDeliveryDetailsPresenter {

    private unowned let view: EnterDeliveryDetailsViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let initData: EnterDeliveryDetailsInitData

    init(view: EnterDeliveryDetailsViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: EnterDeliveryDetailsInitData) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
    }

}

// MARK: - Presenter Protocol

extension EnterDeliveryDetailsPresenter: EnterDeliveryDetailsPresenterProtocol {

    func handleViewLoaded() {
        // Method is called after view loading is finished.
    }

}
