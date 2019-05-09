import Foundation

class SelectAddressPresenter {

    private unowned let view: SelectAddressViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let orderService: OrderServiceProtocol
    
    private let initData: SelectAddressInitData

    init(view: SelectAddressViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: SelectAddressInitData,
         orderService: OrderServiceProtocol) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
        self.orderService = orderService
    }

}

// MARK: - Presenter Protocol

extension SelectAddressPresenter: SelectAddressPresenterProtocol {

    func handleViewLoaded() {
        view.setIsStreetInputEnabled(false)
        view.setIsBuildingInputEnabled(false)
        view.setIsNextButtonEnabled(false)
        
        view.setIsAcitityIndicatorVisible(true)
        orderService.getStreets { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.view.setIsAcitityIndicatorVisible(false)
            
            switch result {
            case .success(let streets):
                strongSelf.view.setAvailableStreets(streets)
                strongSelf.view.setIsStreetInputEnabled(true)
            case .failure(let error):
                strongSelf.view.showTextForError(error)
            }
        }
    }
    
    func handleStreetValueChanged(_ newStreet: Street) {
        // TODO: Implement
    }
    
    func handleBuildingValueChanged(_ newBuilding: Building) {
        // TODO: Implement
    }
    
    func handleCloseTapped() {
        // TODO: Implement
    }
    
    func handleErrorDismissed() {
        // TODO: Implement
    }
    
    func handleNextTapped() {
        let street = Street(id: 1, title: "1")
        let building = Building(id: 1, title: "1")
        initData.handleEnteringFinished(SelectAddressInitData.SelectAddressSceneOutput(street: street,
                                                                                       buidling: building))
    }

}
