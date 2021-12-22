
import UIKit

final class IntroFlowCoordinator: NavigationNode, FlowCoordinator{
    
    weak var containerViewController: UIViewController?
    
    init(parent: NavigationNode) {
        
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        
        let introViewController = IntroViewController()
        let introTitle = L10n.homeTitle
        let introImage = UIImage(systemName: "house")
        let introSelectedImage = UIImage(systemName: "house.fill")
        
        let introTabBarItem = UITabBarItem(title: introTitle,
                                           image: introImage,
                                           selectedImage: introSelectedImage)
        introViewController.tabBarItem = introTabBarItem
        
        return introViewController
    }
}
