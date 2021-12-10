import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBar.tintColor = Asset.newBlack.color
        self.tabBar.unselectedItemTintColor = Asset.newBlack.color
        self.tabBar.barTintColor = Asset.lightBlue.color
        
        setupTabBar()
        self.customTabBar()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.simpleAnnimationWhenSelectItem(item)
    }
}

extension TabBarController {
    func setupTabBar() {
        let introVC = UINavigationController(rootViewController: IntroViewController())
        introVC.tabBarItem = UITabBarItem(title: L10n.homeTitle,
                                          image: UIImage(systemName: "house"),
                                          selectedImage: UIImage(systemName: "house.fill"))
        
        let magicBallVC = UINavigationController(rootViewController: AnswerViewController(AnswerViewModel(model: AnswerModel()))!)
        magicBallVC.tabBarItem = UITabBarItem(title: L10n.gameTitle,
                                              image: UIImage(systemName: "gamecontroller"),
                                              selectedImage: UIImage(systemName: "gamecontroller.fill"))
        
        let historyVC = UINavigationController(rootViewController: HistoryViewController(HistoryViewModel(with: HistoryModel()))!)
        historyVC.tabBarItem = UITabBarItem(title: L10n.historyTitle,
                                            image: UIImage(systemName: "folder"),
                                            selectedImage: UIImage(systemName: "folder.fill"))
        
        viewControllers = [introVC, magicBallVC, historyVC]
    }
    
    func customTabBar() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func simpleAnnimationWhenSelectItem(_ item: UITabBarItem){
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        let timeInterval: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
}
