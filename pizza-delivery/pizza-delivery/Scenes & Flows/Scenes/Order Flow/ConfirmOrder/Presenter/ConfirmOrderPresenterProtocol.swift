import Foundation

protocol ConfirmOrderPresenterProtocol: class {

    // MARK: - Signals from View

    func handleViewLoaded()
    func handleCloseTapped()
    func handleOrderConfirmed()
    
    // MARK: - Other Signals
}
