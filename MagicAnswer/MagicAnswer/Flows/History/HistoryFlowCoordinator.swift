import UIKit

final class HistoryFlowCoordinator: NavigationNode, FlowCoordinator{
    
    weak var containerViewController: UIViewController?
    private let storage: HistoryStorage
    
    init(parent: NavigationNode,
         storage: HistoryStorage = HistoryStorage()) {
        
        self.storage = storage
        
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let historyModel = HistoryModel(parent: self, storage: storage)
        
        let historyViewModel = HistoryViewModel(with: historyModel)
        let historyViewController = HistoryViewController(historyViewModel)
        
        let historyTitle = L10n.historyTitle
        let historyImage = UIImage(systemName: "folder")
        let historySelectedImage = UIImage(systemName: "folder.fill")
        
        let historyTabBarItem = UITabBarItem(title: historyTitle,
                                             image: historyImage,
                                             selectedImage: historySelectedImage)
        historyViewController?.tabBarItem = historyTabBarItem
        
        return historyViewController!
    }
}
