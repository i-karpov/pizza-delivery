import Foundation

protocol OrderSuccessScreenPresenterProtocol: class {

    // MARK: - Signals from View

    func handleViewLoaded()
    func handleCloseTapped()
    
    // MARK: - Other Signals
}
