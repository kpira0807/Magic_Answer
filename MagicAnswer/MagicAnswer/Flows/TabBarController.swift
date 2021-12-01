import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.tabBar.tintColor = Asset.newBlack.color
        
        setupTabBar()
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
}
