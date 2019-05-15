import UIKit
import MBProgressHUD

class SelectAddressViewController: BaseOrderFlowViewController {

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
    
    @IBOutlet weak private var streetDropdown: Dropdown!
    @IBOutlet weak private var buildingDropdown: Dropdown!
    @IBOutlet weak private var nextButton: Button!
    
    private var hud: MBProgressHUD?
    
    // MARK: - Init & Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        presenter.handleViewLoaded()
    }

    private func setupSelf() {
        setAccessibilityIdentifiers()
        
        navigationItem.title = R.string.localizable.orderFlowSelectAddresSceneTitle().uppercased()
        streetDropdown.setTitle(R.string.localizable.orderFlowFieldNameStreet())
        buildingDropdown.setTitle(R.string.localizable.orderFlowFieldNameBuilding())
        
        nextButton.setTitle(R.string.localizable.orderFlowButtonTitleNext().uppercased(),
                            for: .normal)
        
        buildingDropdown.isEnabled = false

        setupNavbar()
        setupDropdownsHandlers()
    }
    
    private func setAccessibilityIdentifiers() {
        view.accessibilityIdentifier = AccessibilityIdentitier.Order.SelectAddress.rootView
        streetDropdown.accessibilityIdentifier = AccessibilityIdentitier.Order.SelectAddress.streetInput
        buildingDropdown.accessibilityIdentifier = AccessibilityIdentitier.Order.SelectAddress.buildingInput
        nextButton.accessibilityIdentifier = AccessibilityIdentitier.Order.CommonButton.nextButton
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

    @objc
    override func handleCloseTapped() {
        presenter.handleCloseTapped()
    }
}

// MARK: - View Protocol

extension SelectAddressViewController: SelectAddressViewProtocol {
    
    func setIsAcitityIndicatorVisible(_ isVisible: Bool) {
        if isVisible {
            if hud == nil {
                hud = MBProgressHUD.showAdded(to: view, animated: true)
                hud?.accessibilityIdentifier = AccessibilityIdentitier.activityIndicator
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
            Dropdown.ItemDescriptor(displayTitle: street.title, item: street)
        }))
    }
    
    func setAvailableBuildings(_ buildings: [Building]) {
        buildingDropdown.setAvailableItems(buildings.map({ (builidng: Building) in
            Dropdown.ItemDescriptor(displayTitle: builidng.title, item: builidng)
        }))
    }
    
    func eraseBuildingInput() {
        buildingDropdown.clear()
    }
}
