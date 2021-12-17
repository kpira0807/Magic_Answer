import UIKit

final class AppFlowCoordinator: NavigationNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    
    private let downloader: AnswerDownloaderProtocol
    private let storage: AnswerStorageProtocol
    private let defaultAnswer: HardcodedAnswers
    private let history: HistoryStorage
    
    init(parent: NavigationNode?,
         downloader: AnswerDownloaderProtocol,
         storage: AnswerStorageProtocol,
         defaultAnswer: HardcodedAnswers,
         history: HistoryStorage) {
        
        self.downloader = downloader
        self.storage = storage
        self.defaultAnswer = defaultAnswer
        self.history = history
        
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        
        
        let answerCoordinator = AnswerFlowCoordinator(parent: self,
                                                      downloader: downloader,
                                                      storage: storage,
                                                      defaultAnswer: defaultAnswer,
                                                      history: history)
        let answerViewController = answerCoordinator.createFlow()
        let answerNavigationController = UINavigationController(rootViewController: answerViewController)
        answerCoordinator.containerViewController = answerNavigationController
        
        
        let historyCoordinator = HistoryFlowCoordinator(parent: self,
                                                        storage: history)
        let historyViewController = historyCoordinator.createFlow()
        let historyNavigationController = UINavigationController(rootViewController: historyViewController)
        historyCoordinator.containerViewController = historyNavigationController
        
        
        let settingCoordinator = SettingsFlowCoordinator(parent: self,
                                                         answers: defaultAnswer,
                                                         storage: storage)
        let settingViewController = settingCoordinator.createFlow()
        let settingNavigationController = UINavigationController(rootViewController: settingViewController)
        settingCoordinator.containerViewController = settingNavigationController
        
        let introCoordinator = IntroFlowCoordinator(parent: self)
        let introViewController = introCoordinator.createFlow()
        let introNavigationController = UINavigationController(rootViewController: introViewController)
        introCoordinator.containerViewController = introNavigationController
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [introNavigationController,
                                            answerNavigationController,
                                            historyNavigationController,
                                            settingNavigationController]
        
        tabBarController.tabBar.tintColor = Asset.newBlack.color
        tabBarController.tabBar.unselectedItemTintColor = Asset.newBlack.color
        tabBarController.tabBar.barTintColor = Asset.lightBlue.color
        
        tabBarController.tabBar.layer.masksToBounds = true
        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.layer.cornerRadius = 20
        tabBarController.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return tabBarController
    }
}
