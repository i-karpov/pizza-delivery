import UIKit

class EnterDeliveryDetailsViewController: UIViewController {

    // MARK: - MVP Infractructure

    var presenter: EnterDeliveryDetailsPresenterProtocol! {
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
        navigationItem.title = R.string.localizable.orderFlowEnterDeliveryDetailsSceneTitle().uppercased()
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    }

    // MARK: -
}

// MARK: - View Protocol

extension EnterDeliveryDetailsViewController: EnterDeliveryDetailsViewProtocol {

}
