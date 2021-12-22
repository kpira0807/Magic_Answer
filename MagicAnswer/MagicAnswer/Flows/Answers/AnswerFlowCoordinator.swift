import UIKit

final class AnswerFlowCoordinator: NavigationNode, FlowCoordinator{
    
    weak var containerViewController: UIViewController?
    
    private let downloader: AnswerDownloaderProtocol
    private let storage: AnswerStorageProtocol
    private let defaultAnswer: HardcodedAnswers
    private let history: HistoryStorage
    
    init(parent: NavigationNode,
         downloader: AnswerDownloaderProtocol = AnswerDownloader(),
         storage: AnswerStorageProtocol = AnswerStorage(),
         defaultAnswer: HardcodedAnswers = HardcodedAnswers(),
         history: HistoryStorage = HistoryStorage()) {
        
        self.downloader = downloader
        self.storage = storage
        self.defaultAnswer = defaultAnswer
        self.history = history
        
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let answerModel = AnswerModel(parent: self,
                                      downloader: downloader,
                                      storage: storage,
                                      defaultAnswer: defaultAnswer,
                                      history: history)
        
        let answerViewModel = AnswerViewModel(model: answerModel)
        let answerViewController = AnswerViewController(answerViewModel)
        
        let answerTitle = L10n.gameTitle
        let answerImage = UIImage(systemName: "gamecontroller")
        let answerSelectedImage = UIImage(systemName: "gamecontroller.fill")
        
        let answerTabBarItem = UITabBarItem(title: answerTitle,
                                            image: answerImage,
                                            selectedImage: answerSelectedImage)
        answerViewController?.tabBarItem = answerTabBarItem
        
        return answerViewController!
    }
}
