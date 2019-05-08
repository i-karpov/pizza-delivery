import Foundation

protocol SelectAddressPresenterProtocol: class {

    // MARK: - Signals from View

    func handleViewLoaded()
    
    func handleStreetValueChanged(_ newStreet: Street)
    func handleBuildingValueChanged(_ newBuilding: Building)
    
    func handleNextTapped()
    
    // MARK: - Other Signals
}
