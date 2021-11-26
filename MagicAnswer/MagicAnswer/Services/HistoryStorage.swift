import Foundation
import RealmSwift

final class HistoryStorage {
    func saveAnswer(_ answer: String) {
        let object = PresentedAnswer()
        object.date = Date()
        object.message = answer
        
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.add(object)
        }
    }
    
    func getGivenAnswer() -> Results<PresentedAnswer> {
        let realm = try? Realm()
        return realm!.objects(PresentedAnswer.self).sorted(byKeyPath: PresentedAnswer.Property.date.rawValue,
                                                           ascending: false)
    }
}
