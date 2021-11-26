import Foundation
import RealmSwift

class PresentedAnswer: Object {
    
    enum Property: String {
        case message, date
    }
    
    @objc dynamic var date: Date = Date()
    @objc dynamic var message: String = ""
}
