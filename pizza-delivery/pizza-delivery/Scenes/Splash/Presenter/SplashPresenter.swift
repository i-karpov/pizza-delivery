import Foundation

class SplashPresenter {

    private unowned let view: SplashViewProtocol
    private unowned let navigator: SceneNavigatorProtocol

    init(view: SplashViewProtocol,
         navigator: SceneNavigatorProtocol) {
        self.view = view
        self.navigator = navigator
    }

}

// MARK: - Presenter Protocol

extension SplashPresenter: SplashPresenterProtocol {

    func handleViewLoaded() {
        // Method is called after view loading is finished.
    }

}
