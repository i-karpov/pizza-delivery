import UIKit

class OrderSuccessScreenViewController: UIViewController {

    // MARK: - MVP Infractructure

    var presenter: OrderSuccessScreenPresenterProtocol! {
        didSet {
            guard oldValue == nil else { 
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    // MARK: - Properties
    
    @IBOutlet weak private var thankYouLabel: UILabel!
    @IBOutlet weak private var expectedArrivalTimeLabel: UILabel!
    @IBOutlet weak private var closeButton: UIButton!
    
    // MARK: - Init & Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        presenter.handleViewLoaded()
    }

    private func setupSelf() {
        setAccessibilityIdentifiers()
        
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        thankYouLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        thankYouLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        expectedArrivalTimeLabel.font = UIFont.systemFont(ofSize: 18.0)
        expectedArrivalTimeLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        
        setupTexts()
    }
    
    private func setAccessibilityIdentifiers() {
        view.accessibilityIdentifier = AccessibilityIdentitier.Order.OrderSuccessScreen.rootView
        closeButton.accessibilityIdentifier = AccessibilityIdentitier.Order.OrderSuccessScreen.finishButton
    }
    
    private func setupTexts() {
        closeButton.setTitle(
            R.string.localizable.orderFlowSuccessSceneCloseButtonTitle().uppercased(),
            for: .normal)
    }

    // MARK: -
    
    @IBAction func handleCloseTapped() {
        presenter.handleCloseTapped()
    }
    
}

// MARK: - View Protocol

extension OrderSuccessScreenViewController: OrderSuccessScreenViewProtocol {

    func setDeliveryWaitingTime(_ waitingTime: DeliveryWaitingTime) {
        thankYouLabel.text = R.string.localizable
            .orderFlowSuccessSceneThankYouMessageFormat("\(waitingTime.minutes)")
        if let deliveryDate = Calendar.current.date(byAdding: .minute, value: waitingTime.minutes, to: Date()) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let time = dateFormatter.string(from: deliveryDate)
            
            expectedArrivalTimeLabel.text =
                "\(R.string.localizable.orderFlowSuccessSceneExpectedTimeLabel()) \(time)"
        }
    }
    
}
