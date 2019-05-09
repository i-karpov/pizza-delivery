import UIKit

class ConfirmOrderViewController: BaseOrderFlowViewController {

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
        setupNavbar()
        setupTexts()
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
    
    @objc
    override func handleCloseTapped() {
        presenter.handleCloseTapped()
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
