import UIKit

class EnterDeliveryDetailsViewController: BaseOrderFlowViewController {

    // MARK: - MVP Infractructure

    var presenter: EnterDeliveryDetailsPresenterProtocol! {
        didSet {
            guard oldValue == nil else { 
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    // MARK: - Properties
    
    @IBOutlet weak private var nameInput: SingleLineTextInput!
    @IBOutlet weak private var phoneNumberInput: SingleLineTextInput!
    @IBOutlet weak private var streetInput: SingleLineTextInput!
    @IBOutlet weak private var buildingInput: SingleLineTextInput!
    @IBOutlet weak private var entranceInput: SingleLineTextInput!
    @IBOutlet weak private var apartmentInput: SingleLineTextInput!
    @IBOutlet weak private var floorInput: SingleLineTextInput!
    @IBOutlet weak private var commentInput: SingleLineTextInput!
    @IBOutlet weak private var nextButton: Button!
    
    // MARK: - Init & Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        presenter.handleViewLoaded()
    }

    private func setupSelf() {
    
        setupNavbar()
        setupTexts()
        setupBindings()
        
        streetInput.isEnabled = false
        buildingInput.isEnabled = false
        
        nextButton.isEnabled = false

    }
    
    private func setupTexts() {
        navigationItem.title = R.string.localizable.orderFlowEnterDeliveryDetailsSceneTitle().uppercased()
        nameInput.setTitle(R.string.localizable.orderFlowFieldNameName())
        phoneNumberInput.setTitle(R.string.localizable.orderFlowFieldNamePhoneNumber())
        streetInput.setTitle(R.string.localizable.orderFlowFieldNameStreet())
        buildingInput.setTitle(R.string.localizable.orderFlowFieldNameBuilding())
        entranceInput.setTitle(R.string.localizable.orderFlowFieldNameEntrance())
        apartmentInput.setTitle(R.string.localizable.orderFlowFieldNameApartment())
        floorInput.setTitle(R.string.localizable.orderFlowFieldNameFloor())
        commentInput.setTitle(R.string.localizable.orderFlowFieldNameComment())
        nextButton.setTitle(R.string.localizable.orderFlowButtonTitleNext().uppercased(),
                            for: .normal)
    }
    
    private func setupBindings() {
        nameInput.handleValueChanged = { [weak self] newValue in
            self?.presenter.handleNameChanged(newValue)
        }
        
        entranceInput.handleValueChanged = { [weak self] newValue in
            self?.presenter.handleEntranceChanged(newValue)
        }
        phoneNumberInput.handleValueChanged = { [weak self] newValue in
            self?.presenter.handlePhoneNumberChanged(newValue)
        }
        apartmentInput.handleValueChanged = { [weak self] newValue in
            self?.presenter.handleApartmentChanged(newValue)
        }
        floorInput.handleValueChanged = { [weak self] newValue in
            self?.presenter.handleFloorChanged(newValue)
        }
        commentInput.handleValueChanged = { [weak self] newValue in
            self?.presenter.handleCommentChanged(newValue)
        }
    }

    // MARK: -
    @IBAction func handleNextButtonTap() {
        presenter.handleNextButtonTapped()
    }
    
    @objc
    override func handleCloseTapped() {
        presenter.handleCloseTapped()
    }
}

// MARK: - View Protocol

extension EnterDeliveryDetailsViewController: EnterDeliveryDetailsViewProtocol {

    func setStreet(_ street: Street) {
        streetInput.setValue(street.title)
    }
    
    func setBuilding(_ building: Building) {
        buildingInput.setValue(building.title)
    }
    
    func setIsNextButtonEnabled(_ isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
}
