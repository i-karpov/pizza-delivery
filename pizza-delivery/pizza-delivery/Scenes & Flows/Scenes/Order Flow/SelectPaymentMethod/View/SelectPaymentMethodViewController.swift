import UIKit

class SelectPaymentMethodViewController: UIViewController {

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
        navigationItem.title = R.string.localizable.orderFlowSelectPaymentMethodSceneTitle().uppercased()
        nextButton.setTitle(R.string.localizable.orderFlowButtonTitleNext().uppercased(),
                            for: .normal)
    }
    
    // MARK: -
    
    @IBAction func handleNextButtonTapped() {
        presenter.handleNextButtonTapped()
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
