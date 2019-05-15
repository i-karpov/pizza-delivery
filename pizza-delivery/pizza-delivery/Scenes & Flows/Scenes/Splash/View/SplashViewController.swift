import UIKit

class SplashViewController: UIViewController {

    // MARK: - MVP Infractructure

    var presenter: SplashPresenterProtocol! {
        didSet {
            guard oldValue == nil else { 
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    // MARK: - Properties

    @IBOutlet weak private var titleLabel: UILabel!
    
    // MARK: - Init & Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        presenter.handleViewLoaded()
    }

    private func setupSelf() {
        view.accessibilityIdentifier = AccessibilityIdentitier.Splash.rootView
        titleLabel.text = R.string.localizable.splashTitle()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = .white
        view.applyGradientFromTopToBottom(colors: [#colorLiteral(red: 1, green: 0.2941176471, blue: 0.168627451, alpha: 1), #colorLiteral(red: 1, green: 0.2549019608, blue: 0.4235294118, alpha: 1)])
    }

    // MARK: -
}

// MARK: - View Protocol

extension SplashViewController: SplashViewProtocol {

}
