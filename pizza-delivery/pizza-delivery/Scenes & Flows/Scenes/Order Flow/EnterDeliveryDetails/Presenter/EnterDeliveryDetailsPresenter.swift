import Foundation

class EnterDeliveryDetailsPresenter {

    private unowned let view: EnterDeliveryDetailsViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    fileprivate let initData: EnterDeliveryDetailsInitData

    private var name: String?
    private var phoneNumber: String?
    private var entrance: String?
    private var apartment: String?
    private var floor: String?
    private var comment: String?
    
    init(view: EnterDeliveryDetailsViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: EnterDeliveryDetailsInitData) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
    }

}

// MARK: - Presenter Protocol

extension EnterDeliveryDetailsPresenter: EnterDeliveryDetailsPresenterProtocol {

    func handleViewLoaded() {
        view.setStreet(initData.selectedStreet)
        view.setBuilding(initData.selectedBuilding)
    }

    func handleNameChanged(_ newValue: String?) {
        name = newValue
    }
    
    func handlePhoneNumberChanged(_ newValue: String?) {
        phoneNumber = newValue
        view.setIsNextButtonEnabled(!(newValue?.isEmpty ?? true))
    }
    
    func handleEntranceChanged(_ newValue: String?) {
        entrance = newValue
    }
    
    func handleApartmentChanged(_ newValue: String?) {
        apartment = newValue
    }
    
    func handleFloorChanged(_ newValue: String?) {
        floor = newValue
    }
    
    func handleCommentChanged(_ newValue: String?) {
        comment = newValue
    }

    func handleNextButtonTapped() {
        guard let phoneNumber = phoneNumber else {
            fatalError("Invalid state.")
        }
        
        initData.handleEnteringFinished(DeliveryDetails(street: initData.selectedStreet,
                                                        building: initData.selectedBuilding,
                                                        name: name,
                                                        phoneNumber: phoneNumber,
                                                        entrance: entrance,
                                                        apartment: apartment,
                                                        floor: floor,
                                                        comment: comment))
    }
}
