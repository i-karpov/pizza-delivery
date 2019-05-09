import UIKit

class SelectPaymentMethodViewController: BaseOrderFlowViewController {

    // MARK: - MVP Infractructure

    var presenter: SelectPaymentMethodPresenterProtocol! {
        didSet {
            guard oldValue == nil else { 
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    // MARK: - Properties

    @IBOutlet weak private var nextButton: Button!
    @IBOutlet weak private var totalSumValueLabel: UILabel!
    
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
        navigationItem.title = R.string.localizable.orderFlowSelectPaymentMethodSceneTitle().uppercased()
        nextButton.setTitle(R.string.localizable.orderFlowButtonTitleNext().uppercased(),
                            for: .normal)
    }
    
    // MARK: -
    
    @IBAction func handleNextButtonTapped() {
        presenter.handleNextButtonTapped()
    }
    
    @objc
    override func handleCloseTapped() {
        presenter.handleCloseTapped()
    }
    
}

// MARK: - View Protocol

extension SelectPaymentMethodViewController: SelectPaymentMethodViewProtocol {

    func setTotalSum(_ totalSum: MoneyAmount) {
        let mainPart = totalSum.cents / 100
        let centsPart = totalSum.cents % 100
        totalSumValueLabel.text = "\(mainPart).\(centsPart)"
    }
    
}
