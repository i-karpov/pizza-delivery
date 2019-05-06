import Foundation

protocol SelectAddressPresenterProtocol: class {

    // MARK: - Signals from View

    func handleViewLoaded()
    func handleNextTapped()

    // MARK: - Other Signals
}
