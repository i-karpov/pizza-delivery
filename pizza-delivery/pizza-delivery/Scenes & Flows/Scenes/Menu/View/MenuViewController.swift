import UIKit
import MBProgressHUD

class MenuViewController: UIViewController {

    // MARK: - MVP Infractructure

    var presenter: MenuPresenterProtocol! {
        didSet {
            guard oldValue == nil else { 
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    // MARK: - Properties

    private var hud: MBProgressHUD?
    
    @IBOutlet weak private var errorWithRetryView: UIView!
    @IBOutlet weak private var errorLabel: UILabel!
    @IBOutlet weak private var retryButton: UIButton!
    
    @IBOutlet weak private var contentWrapperView: UIView!
    @IBOutlet weak private var pizzasCollectionView: UICollectionView!
    
    private var pizzas: [Pizza]!
    
    // MARK: - Init & Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        presenter.handleViewLoaded()
    }

    private func setupSelf() {
        view.accessibilityIdentifier = AccessibilityIdentitier.Menu.rootView
        
        pizzas = []
        pizzasCollectionView.dataSource = self
        pizzasCollectionView.registerNib(PizzaCollectionViewCell.self)
        
        if let flowLayout = pizzasCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        setupLocalizedStrings()
    }
    
    private func setupLocalizedStrings() {
        navigationItem.title = R.string.localizable.menuScreenTitle()
        retryButton.titleLabel?.text = R.string.localizable.commonRetryButtonTitle()
    }

    // MARK: - Signals
    
    @IBAction func handleRetryTapped() {
        presenter.handleRetryTapped()
    }
}

// MARK: - Collection View Data Source

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pizzas.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PizzaCollectionViewCell = pizzasCollectionView.dequeueReusableCell(for: indexPath)
        let pizza = pizzas[indexPath.row]
        cell.accessibilityIdentifier = String(format: AccessibilityIdentitier.Menu.pizzaCellFormat,
                                              "\(indexPath.row)")
        cell.configureWithPizza(pizzas[indexPath.row],
                                onOrderTapped: { [weak self] in
                                    guard let strongSelf = self else {
                                        return
                                    }
                                    strongSelf.presenter.handleOrderPizzaTapped(pizza: pizza)
        })
        return cell
    }
}

// MARK: - View Protocol

extension MenuViewController: MenuViewProtocol {

    func setIsAcitityIndicatorVisible(_ isVisible: Bool) {
        if isVisible {
            if hud == nil {
                hud = MBProgressHUD.showAdded(to: view, animated: true)
            }
        } else {
            hud?.hide(animated: true)
        }
    }
    
    func showTextForError(_ error: CommonError) {
        let errorText = makeErrorTextForError(error)
        showOKAlert(title: "", message: errorText)
    }
    
    func showTextWithRetryForError(_ error: CommonError) {
        errorLabel.text = makeErrorTextForError(error)
        errorWithRetryView.isHidden = false
        contentWrapperView.isHidden = true
    }
    
    func setPizzas(_ pizzas: [Pizza]) {
        self.pizzas = pizzas
        pizzasCollectionView.reloadData()
        contentWrapperView.isHidden = false
        errorWithRetryView.isHidden = true
    }
    
    private func makeErrorTextForError(_ error: CommonError) -> String {
        switch error {
        case .serverBusinessError(let errorText):
            return errorText
        case .serverCommunicationError(.noConnection):
            return R.string.localizable.commonErrorMessageNoConnection()
        default:
            return R.string.localizable.commonErrorMessageGeneric()
        }
    }
}
