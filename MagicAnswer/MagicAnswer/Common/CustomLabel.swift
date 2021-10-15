//
//  CustomLabel.swift
//  MagicAnswer
//
//  Created by Iryna Kopchynska on 27.09.2021.
//  Copyright © 2021 Iryna Kopchynska. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        newTextLabel()
    }
    
    func newTextLabel(){
        self.textColor = UIColor.whiteColor
        self.clipsToBounds = true
    }
}
