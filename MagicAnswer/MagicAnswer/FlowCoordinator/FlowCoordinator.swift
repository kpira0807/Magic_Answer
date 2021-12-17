import UIKit

public protocol FlowCoordinator: class {

    // This variable must allways be of 'weak' type.
    var containerViewController: UIViewController? { get set }

    @discardableResult
    func createFlow() -> UIViewController

}
