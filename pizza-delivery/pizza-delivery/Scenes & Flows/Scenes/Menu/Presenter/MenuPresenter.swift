import Foundation

class MenuPresenter {

    private unowned let view: MenuViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let menuService: MenuServiceProtocol
    
    init(view: MenuViewProtocol,
         navigator: SceneNavigatorProtocol,
         menuService: MenuServiceProtocol) {
        self.view = view
        self.navigator = navigator
        self.menuService = menuService
    }

    private func reloadPizzasList(isRetryOnErrorAvailable: Bool = true) {
        view.setIsAcitityIndicatorVisible(true)
        menuService.getPizzas { [weak self] (result) in
            guard let strongSelf = self else {
                return
                
            }
            strongSelf.view.setIsAcitityIndicatorVisible(false)
            
            switch result {
            case .success(let pizzas):
                strongSelf.view.setPizzas(pizzas)
            case .failure(let error):
                if isRetryOnErrorAvailable {
                    strongSelf.view.showTextWithRetryForError(error)
                } else {
                    strongSelf.view.showTextForError(error)
                }
                
            }
        }
    }
}

// MARK: - Presenter Protocol

extension MenuPresenter: MenuPresenterProtocol {

    func handleViewLoaded() {
        reloadPizzasList()
    }
    
    func handleOrderPizzaTapped(pizza: Pizza) {
        navigator.startFlow(.order(OrderFlowInitData(pizza: pizza)),
                            transitionType: .modal)
    }
    
    func handleRefreshRequested() {
        reloadPizzasList(isRetryOnErrorAvailable: false)
    }
    
    func handleRetryTapped() {
        reloadPizzasList()
    }
}
