import Foundation
import RealmSwift

final class HistoryStorage {
    func saveAnswer(_ answer: String) {
        let object = PresentedAnswer()
        object.date = Date()
        object.message = answer
        DispatchQueue(label: "background").async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(object)
                        realm.refresh()
                    }
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    var results: Results<PresentedAnswer>!
    
    func getGivenAnswer() -> [PresentedAnswer] {
        DispatchQueue(label: "background").sync {
            do {
                let realm = try Realm()
                let answers = realm.objects(PresentedAnswer.self).sorted(byKeyPath: PresentedAnswer.Property.date.rawValue, ascending: false)
                realm.refresh()
                let arrayAnswers = Array(answers)
                return arrayAnswers
            } catch {
                print("Error")
            }
            let arrayAnswers = Array(results)
            return arrayAnswers
        }
    }
}
