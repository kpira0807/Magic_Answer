import Foundation
import UIKit

class CustomViewBackground: UIView {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createBorder()
    }

    func createBorder() {
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.blueColor
        self.clipsToBounds = true
    }
}
