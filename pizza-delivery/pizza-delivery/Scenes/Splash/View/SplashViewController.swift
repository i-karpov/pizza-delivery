import UIKit

class SplashViewController: UIViewController {

    // MARK: - MVP Infractructure

    var presenter: SplashPresenterProtocol! {
        didSet {
            guard oldValue == nil else { 
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    // MARK: - Properties

    // MARK: - Init & Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        presenter.handleViewLoaded()
    }

    private func setupSelf() {

    }

    // MARK: -
}

// MARK: - View Protocol

extension SplashViewController: SplashViewProtocol {

}
