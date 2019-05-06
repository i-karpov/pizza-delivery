import Foundation

class TabsPresenter {

    private unowned let view: TabsViewProtocol
    private unowned let navigator: SceneNavigatorProtocol

    init(view: TabsViewProtocol,
         navigator: SceneNavigatorProtocol) {
        self.view = view
        self.navigator = navigator
    }

}

// MARK: - Presenter Protocol

extension TabsPresenter: TabsPresenterProtocol {

    func handleViewLoaded() {
        // Method is called after view loading is finished.
    }

}
