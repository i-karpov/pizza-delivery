import UIKit

class MenuViewController: UIViewController {

    // MARK: - MVP Infractructure

    var presenter: MenuPresenterProtocol! {
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

extension MenuViewController: MenuViewProtocol {

    func setIsAcitityIndicatorVisible(_ isVisible: Bool) {
        fatalError("Not implemented")
    }
    
    func showTextForError(_ error: CommonError) {
        fatalError("Not implemented")
    }
    
    func showTextWithRetryForError(_ error: CommonError) {
        fatalError("Not implemented")
    }
    
    func setPizzas(_ pizzas: [Pizza]) {
        fatalError("Not implemented")
    }
    
}
