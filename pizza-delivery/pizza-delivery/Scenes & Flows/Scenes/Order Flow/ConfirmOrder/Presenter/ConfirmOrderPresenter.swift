import Foundation

class ConfirmOrderPresenter {

    private unowned let view: ConfirmOrderViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let initData: ConfirmOrderInitData

    init(view: ConfirmOrderViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: ConfirmOrderInitData) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
    }

}

// MARK: - Presenter Protocol

extension ConfirmOrderPresenter: ConfirmOrderPresenterProtocol {

    func handleViewLoaded() {
        // Method is called after view loading is finished.
    }

}