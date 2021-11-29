import Foundation
import RealmSwift

final class HistoryStorage {
    func saveAnswer(_ answer: String) {
        let object = PresentedAnswer()
        object.date = Date()
        object.message = answer
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error")
        }
    }
    
    var results: Results<PresentedAnswer>!
    
    func getGivenAnswer() -> [PresentedAnswer] {
        do {
            let realm = try Realm()
            let answers = realm.objects(PresentedAnswer.self).sorted(byKeyPath: PresentedAnswer.Property.date.rawValue, ascending: false)
            let arrayAnswers = Array(answers)
            return arrayAnswers
        } catch {
            print("Error")
        }
        let arrayAnswers = Array(results)
        return arrayAnswers
    }
}
