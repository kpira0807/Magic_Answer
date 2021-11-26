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
        introVC.tabBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(systemName: "house"),
                                          selectedImage: UIImage(systemName: "house.fill"))
        introVC.tabBarItem.tag = 0
        
        let magicBallVC = UINavigationController(rootViewController: AnswerViewController(AnswerViewModel(model: AnswerModel()))!)
        magicBallVC.tabBarItem = UITabBarItem(title: "Game",
                                              image: UIImage(systemName: "gamecontroller"),
                                              selectedImage: UIImage(systemName: "gamecontroller.fill"))
        magicBallVC.tabBarItem.tag = 1
        
        let historyVC = UINavigationController(rootViewController: HistoryViewController(HistoryViewModel(with: HistoryModel()))!)
        historyVC.tabBarItem = UITabBarItem(title: "History",
                                            image: UIImage(systemName: "folder"),
                                            selectedImage: UIImage(systemName: "folder.fill"))
        historyVC.tabBarItem.tag = 2
        
        viewControllers = [introVC, magicBallVC, historyVC]
    }
}
