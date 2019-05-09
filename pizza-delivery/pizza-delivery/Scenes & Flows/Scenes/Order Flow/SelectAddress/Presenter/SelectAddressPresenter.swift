import Foundation

class SelectAddressPresenter {

    private unowned let view: SelectAddressViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let orderService: OrderServiceProtocol
    
    private let initData: SelectAddressInitData

    private var selectedStreet: Street?
    private var selectedBuilding: Building?
    
    init(view: SelectAddressViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: SelectAddressInitData,
         orderService: OrderServiceProtocol) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
        self.orderService = orderService
        
        selectedStreet = .none
        selectedBuilding = .none
    }

    // MARK: - Private Methods
    
    fileprivate func loadStreetsAndEnablePicker() {
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
    
    fileprivate func loadBuildingsAndEnablePicker(streetId: Int) {
        view.setIsAcitityIndicatorVisible(true)
        orderService.getBuildingsByStreetId(streetId) { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.view.setIsAcitityIndicatorVisible(false)
            
            switch result {
            case .success(let buildings):
                strongSelf.view.setAvailableBuildings(buildings)
                strongSelf.view.setIsBuildingInputEnabled(true)
            case .failure(let error):
                strongSelf.view.showTextForError(error)
            }
        }
    }
}

// MARK: - Presenter Protocol

extension SelectAddressPresenter: SelectAddressPresenterProtocol {

    func handleViewLoaded() {
        view.setIsStreetInputEnabled(false)
        view.setIsBuildingInputEnabled(false)
        view.setIsNextButtonEnabled(false)
        loadStreetsAndEnablePicker()
    }
    
    func handleStreetValueChanged(_ newStreet: Street?) {
        selectedStreet = newStreet
        selectedBuilding = .none
        view.eraseBuildingInput()
        view.setIsNextButtonEnabled(false)
        if let newStreet = newStreet {
            loadBuildingsAndEnablePicker(streetId: newStreet.id)
        }
    }
    
    func handleBuildingValueChanged(_ newBuilding: Building?) {
        selectedBuilding = newBuilding
        if newBuilding != nil {
            view.setIsNextButtonEnabled(true)
        }
    }
    
    func handleCloseTapped() {
        initData.handleCloseTapped()
    }
    
    func handleErrorDismissed() {
        initData.handleCloseTapped()
    }
    
    func handleNextTapped() {
        guard let street = selectedStreet, let building = selectedBuilding else {
            fatalError("Invalid state.")
        }
        initData.handleEnteringFinished(SelectAddressInitData.SelectAddressSceneOutput(street: street,
                                                                                       buidling: building))
    }

}
