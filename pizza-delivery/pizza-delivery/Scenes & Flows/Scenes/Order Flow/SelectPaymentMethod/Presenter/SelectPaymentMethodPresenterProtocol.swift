import Foundation

protocol SelectPaymentMethodPresenterProtocol: class {

    // MARK: - Signals from View

    func handleViewLoaded()
    func handleNextButtonTapped()
    
    // MARK: - Other Signals
}
