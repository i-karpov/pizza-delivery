import Foundation

protocol EnterDeliveryDetailsPresenterProtocol: class {

    // MARK: - Signals from View

    func handleViewLoaded()
    
    func handleNameChanged(_ newValue: String?)
    func handlePhoneNumberChanged(_ newValue: String?)
    func handleEntranceChanged(_ newValue: String?)
    func handleApartmentChanged(_ newValue: String?)
    func handleFloorChanged(_ newValue: String?)
    func handleCommentChanged(_ newValue: String?)
    
    func handleNextButtonTapped()
    
    // MARK: - Other Signals
}
