import UIKit

class SelectAddressViewController: UIViewController {

    // MARK: - MVP Infractructure

    var presenter: SelectAddressPresenterProtocol! {
        didSet {
            guard oldValue == nil else { 
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    // MARK: - Properties

    @IBOutlet weak private var streetDropdown: DropdownButton!
    @IBOutlet weak private var buildingDropdown: DropdownButton!
    @IBOutlet weak private var nextButton: Button!
    
    // MARK: - Init & Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        presenter.handleViewLoaded()
    }

    private func setupSelf() {
        navigationItem.title = R.string.localizable.orderFlowSelectAddresSceneTitle().uppercased()
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        
        self.navigationController?.navigationBar.backIndicatorImage
            = UIImage(named: "navbar-back-button")?.withInsets(UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0))
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "navbar-back-button")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: nil,
                                                                action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        
        streetDropdown.setTitle(R.string.localizable.orderFlowFieldNameStreet())
        buildingDropdown.setTitle(R.string.localizable.orderFlowFieldNameBuilding())
        
        nextButton.setTitle(R.string.localizable.orderFlowButtonTitleNext().uppercased(),
                            for: .normal)
        
        buildingDropdown.isEnabled = false
    }

    // MARK: -
    
    @IBAction func handleNextButtonTapped() {
        presenter.handleNextTapped()
    }
}

// MARK: - View Protocol

extension SelectAddressViewController: SelectAddressViewProtocol {

}
