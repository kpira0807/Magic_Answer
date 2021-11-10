import Foundation
import UIKit

class CustomLabel: UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        newTextLabel()
    }

    func newTextLabel() {
        self.textColor = UIColor(asset: Asset.newWhite)
        self.clipsToBounds = true
    }
}
