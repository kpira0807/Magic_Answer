import UIKit

final class SettingsFlowCoordinator: NavigationNode, FlowCoordinator{
    
    var containerViewController: UIViewController?
    
    private let answers: HardcodedAnswers
    private let storage: AnswerStorageProtocol
    
    init(parent: NavigationNode,
         answers: HardcodedAnswers = HardcodedAnswers(),
         storage: AnswerStorageProtocol = AnswerStorage()) {
        
        self.answers = answers
        self.storage = storage
        
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let settingModel = SettingModel(parent: self,
                                        answers: answers,
                                        storage: storage)
        let settingViewModel = SettingViewModel(model: settingModel)
        let settingViewController = SettingViewController(settingViewModel)
        
        let settingTitle = L10n.settingTitle
        let settingImage = UIImage(systemName: "plus.square.on.square")
        let settingSelectedImage = UIImage(systemName: "plus.square.fill.on.square.fill")
        
        let settingTabBarItem = UITabBarItem(title: settingTitle,
                                             image: settingImage,
                                             selectedImage: settingSelectedImage)
        settingViewController?.tabBarItem = settingTabBarItem
        
        return settingViewController!
    }
}
