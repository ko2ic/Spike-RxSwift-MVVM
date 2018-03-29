import Domains
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: UITabBarDelegate

    override func tabBar(_: UITabBar, didSelect _: UITabBarItem) {
    }

    // MARK: UITabBarControllerDelegate

    func tabBarController(_: UITabBarController, didSelect _: UIViewController) {
    }

    func tabBarController(_: UITabBarController, willBeginCustomizing _: [UIViewController]) {
    }

    func tabBarController(_: UITabBarController, willEndCustomizing _: [UIViewController], changed _: Bool) {
    }

    func tabBarController(_: UITabBarController, didEndCustomizing _: [UIViewController], changed _: Bool) {
    }
}
