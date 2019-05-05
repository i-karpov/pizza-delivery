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
        
    }

    // MARK: -
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
        fatalError("Not implemented")
    }
    
    func showTextWithRetryForError(_ error: CommonError) {
        // error label =
        errorWithRetryView.isHidden = false
        contentWrapperView.isHidden = true
    }
    
    func setPizzas(_ pizzas: [Pizza]) {
        self.pizzas = pizzas
        pizzasCollectionView.reloadData()
        contentWrapperView.isHidden = false
        errorWithRetryView.isHidden = true
    }
    
}
