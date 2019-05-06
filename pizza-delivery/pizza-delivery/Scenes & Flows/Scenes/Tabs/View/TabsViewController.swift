import UIKit

class TabsViewController: UITabBarController {

    // MARK: - MVP Infractructure

    var presenter: TabsPresenterProtocol! {
        didSet {
            guard oldValue == nil else { 
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    // MARK: - Init & Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 0
    }
    
    func setupViewControllers(menuScene: MenuViewController,
                              ordersHistoryScene: OrdersHistoryViewController) {
        viewControllers = [
            makeTabChildController(from: menuScene, tabTitle: R.string.localizable.tabsMenuTitle()),
            makeTabChildController(from: ordersHistoryScene, tabTitle: R.string.localizable.tabsHistoryTitle())
        ]
    }

    private func makeTabChildController(from controller: UIViewController,
                                        tabTitle: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.tabBarItem = UITabBarItem(title: tabTitle, image: nil, selectedImage: nil)
        return navigationController
    }
    
    // MARK: -
}

// MARK: - View Protocol

extension TabsViewController: TabsViewProtocol {

}
