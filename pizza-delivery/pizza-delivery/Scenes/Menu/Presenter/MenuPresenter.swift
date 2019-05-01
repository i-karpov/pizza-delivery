import Foundation

class MenuPresenter {

    private unowned let view: MenuViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let initData: MenuInitData

    init(view: MenuViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: MenuInitData) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
    }

}

// MARK: - Presenter Protocol

extension MenuPresenter: MenuPresenterProtocol {

    func handleViewLoaded() {
        // Method is called after view loading is finished.
    }

}
