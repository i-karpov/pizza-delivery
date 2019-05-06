import Foundation

protocol MenuPresenterProtocol: class {

    // MARK: - Signals from View

    func handleViewLoaded()
    func handleOrderPizzaTapped(pizza: Pizza)
    func handleRetryTapped()
    func handleRefreshRequested()
    
    // MARK: - Other Signals
}
