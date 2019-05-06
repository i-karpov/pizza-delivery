import Foundation

class SelectPaymentMethodPresenter {

    private unowned let view: SelectPaymentMethodViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let initData: SelectPaymentMethodInitData

    init(view: SelectPaymentMethodViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: SelectPaymentMethodInitData) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
    }

}

// MARK: - Presenter Protocol

extension SelectPaymentMethodPresenter: SelectPaymentMethodPresenterProtocol {

    func handleViewLoaded() {
        // Method is called after view loading is finished.
    }

}