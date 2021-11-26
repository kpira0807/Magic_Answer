import Foundation

class HistoryModel {
    
    struct AnswerHistoryModel {
        let date: Date
        let message: String
    }
    
    private let storage: HistoryStorage
    
    init(storage: HistoryStorage = HistoryStorage()) {
        self.storage = storage
    }
    
    func getAnswer() -> [AnswerHistoryModel] {
        return storage.getGivenAnswer().map{ AnswerHistoryModel.init(date: $0.date, message: $0.message) }
    }
}
