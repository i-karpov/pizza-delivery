import Foundation

class SelectAddressPresenter {

    private unowned let view: SelectAddressViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let initData: SelectAddressInitData

    init(view: SelectAddressViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: SelectAddressInitData) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
    }

}

// MARK: - Presenter Protocol

extension SelectAddressPresenter: SelectAddressPresenterProtocol {

    func handleViewLoaded() {
        // Method is called after view loading is finished.
    }

}
