import Foundation

protocol AnswerStorageProtocol {
    func saveAnswer(_ answer: [String])
    func getAnswer() -> [String]?
}

final class AnswerStorage: AnswerStorageProtocol {
    
    private let userDefaultsAnswerKey = "answer"
    
    func saveAnswer(_ answer: [String]) {
        UserDefaults.standard.set(answer, forKey: userDefaultsAnswerKey)
    }
    
    func getAnswer() -> [String]? {
        guard let answer = UserDefaults.standard.array(forKey: userDefaultsAnswerKey) as? [String] else {
            return nil
        }
        return answer
    }
}
