import UIKit
import MBProgressHUD

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

    var errorToTextMapper: ErrorToTextMapper!
    
    @IBOutlet weak private var streetDropdown: DropdownButton!
    @IBOutlet weak private var buildingDropdown: DropdownButton!
    @IBOutlet weak private var nextButton: Button!
    
    private var hud: MBProgressHUD?
    
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

        setupDropdownsHandlers()
    }

    private func setupDropdownsHandlers() {
        streetDropdown.handleValueChanged = { [weak self] itemDescriptor in
            if itemDescriptor == nil {
                self?.presenter.handleStreetValueChanged(.none)
                return
            }
            guard let street = itemDescriptor?.item as? Street else {
                fatalError("Wrong picker item type.")
            }
            self?.presenter.handleStreetValueChanged(street)
        }
        buildingDropdown.handleValueChanged = { [weak self] itemDescriptor in
            if itemDescriptor == nil {
                self?.presenter.handleBuildingValueChanged(.none)
                return
            }
            guard let building = itemDescriptor?.item as? Building else {
                fatalError("Wrong picker item type.")
            }
            self?.presenter.handleBuildingValueChanged(building)
        }
    }
    
    // MARK: -
    
    @IBAction func handleNextButtonTapped() {
        presenter.handleNextTapped()
    }
}

// MARK: - View Protocol

extension SelectAddressViewController: SelectAddressViewProtocol {
    
    func setIsAcitityIndicatorVisible(_ isVisible: Bool) {
        if isVisible {
            if hud == nil {
                hud = MBProgressHUD.showAdded(to: view, animated: true)
            }
        } else {
            hud?.hide(animated: true)
            hud = nil
        }
    }
    
    func showTextForError(_ error: CommonError) {
        let errorText = errorToTextMapper.makeErrorTextForError(error)
        showOKAlert(title: "", message: errorText, onDismissed: { [weak self] in
            self?.presenter.handleErrorDismissed()
        })
    }
    
    func setIsStreetInputEnabled(_ isEnabled: Bool) {
        streetDropdown.isEnabled = isEnabled
    }
    
    func setIsBuildingInputEnabled(_ isEnabled: Bool) {
        buildingDropdown.isEnabled = isEnabled
    }
    
    func setIsNextButtonEnabled(_ isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
    func setAvailableStreets(_ streets: [Street]) {
        streetDropdown.setAvailableItems(streets.map({ (street: Street) in
            DropdownButton.ItemDescriptor(displayTitle: street.title, item: street)
        }))
    }
    
    func setAvailableBuildings(_ buildings: [Building]) {
        buildingDropdown.setAvailableItems(buildings.map({ (builidng: Building) in
            DropdownButton.ItemDescriptor(displayTitle: builidng.title, item: builidng)
        }))
    }
    
    func eraseBuildingInput() {
        buildingDropdown.clear()
    }
}
