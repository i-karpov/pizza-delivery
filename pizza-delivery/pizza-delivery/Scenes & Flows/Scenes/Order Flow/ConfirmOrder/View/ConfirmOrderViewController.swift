import UIKit

class ConfirmOrderViewController: UIViewController {

    // MARK: - MVP Infractructure

    var presenter: ConfirmOrderPresenterProtocol! {
        didSet {
            guard oldValue == nil else { 
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    // MARK: - Properties

    @IBOutlet weak private var totalSumValueLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var phoneNumberLabel: UILabel!
    @IBOutlet weak private var addressLabel: UILabel!
    @IBOutlet weak private var paymentMethodLabel: UILabel!
    @IBOutlet weak private var pizzaLabel: UILabel!
    @IBOutlet weak private var commentLabel: UILabel!
    @IBOutlet weak private var confirmOrderButton: UIButton!
    
    
    // MARK: - Init & Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        presenter.handleViewLoaded()
    }

    private func setupSelf() {
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        setupNavbar()
        setupTexts()
    }
    
    // TODO: refactor: get rid of duplicatin of this code
    private func setupNavbar() {
        self.navigationController?.navigationBar.backIndicatorImage
            = UIImage(named: "navbar-back-button")?.withInsets(UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0))
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "navbar-back-button")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: nil,
                                                                action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
    }
    
    private func setupTexts() {
        navigationItem.title = R.string.localizable.orderFlowConfirmationSceneTitle().uppercased()
        confirmOrderButton.setTitle(
            R.string.localizable.orderFlowConfirmationSceneConfirmOrderButtonTitle().uppercased(),
            for: .normal)
    }

    // MARK: -
    
    @IBAction func handleOrderConfirmed() {
        presenter.handleOrderConfirmed()
    }
}

// MARK: - View Protocol

extension ConfirmOrderViewController: ConfirmOrderViewProtocol {

    func showOrderDraft(_ orderDraft: OrderDraft) {
        let mainPart = orderDraft.pizza.price.cents / 100
        let centsPart = orderDraft.pizza.price.cents % 100
        totalSumValueLabel.text = "\(mainPart).\(centsPart)"
        
        addressLabel.text = [
            orderDraft.deliveryDetails.street.title,
            orderDraft.deliveryDetails.building.title,
            orderDraft.deliveryDetails.entrance,
            orderDraft.deliveryDetails.apartment,
            orderDraft.deliveryDetails.floor
        ]
            .compactMap({ $0 })
            .joined(separator: ", ")
        
        switch orderDraft.paymentMethod {
        case .byCard:
            paymentMethodLabel.text = R.string.localizable.orderFlowConfirmationScenePaymentMethodCard()
        case .byCash:
            paymentMethodLabel.text = R.string.localizable.orderFlowConfirmationScenePaymentMethodCash()
        }
        
        nameLabel.text = orderDraft.deliveryDetails.name ?? "-"
        phoneNumberLabel.text = orderDraft.deliveryDetails.phoneNumber
        pizzaLabel.text = orderDraft.pizza.title
        commentLabel.text = orderDraft.deliveryDetails.comment ?? "-"
    }
    
}
