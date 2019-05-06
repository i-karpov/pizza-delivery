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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.navigator.navigateTo(.tabs, transitionType: .modal)
        }
    }

}
