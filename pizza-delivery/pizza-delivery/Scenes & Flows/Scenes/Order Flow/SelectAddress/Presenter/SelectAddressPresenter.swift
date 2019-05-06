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
    
    func handleNextTapped() {
        let street = Street(id: 1, title: "1")
        let building = Building(id: 1, title: "1")
        initData.handleEnteringFinished(SelectAddressInitData.SelectAddressSceneOutput(street: street,
                                                                                       buidling: building))
    }

}
