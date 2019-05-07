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

    
    @IBOutlet weak private var nameInput: SingleLineTextInput!
    @IBOutlet weak private var phoneNumberInput: SingleLineTextInput!
    @IBOutlet weak private var streetInput: SingleLineTextInput!
    @IBOutlet weak private var buildingInput: SingleLineTextInput!
    @IBOutlet weak private var entranceInput: SingleLineTextInput!
    @IBOutlet weak private var apartmentInput: SingleLineTextInput!
    @IBOutlet weak private var floorInput: SingleLineTextInput!
    @IBOutlet weak private var commentInput: SingleLineTextInput!
    @IBOutlet weak var nextButton: Button!
    
    
    // MARK: - Init & Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        presenter.handleViewLoaded()
    }

    private func setupSelf() {
        navigationItem.title = R.string.localizable.orderFlowEnterDeliveryDetailsSceneTitle().uppercased()
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        
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
        
        streetInput.isEnabled = false
        buildingInput.isEnabled = false
        
        nextButton.isEnabled = false

    }

    // MARK: -
    @IBAction func handleNextButtonTap() {
        print("Next tapped")
    }
    
}

// MARK: - View Protocol

extension EnterDeliveryDetailsViewController: EnterDeliveryDetailsViewProtocol {

}
