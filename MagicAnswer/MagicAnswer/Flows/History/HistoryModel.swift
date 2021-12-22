import Foundation

class HistoryModel: NavigationNode {
    
    struct AnswerHistoryModel {
        let date: Date
        let message: String
    }
    
    private let storage: HistoryStorage
    
    init(parent: NavigationNode,
         storage: HistoryStorage = HistoryStorage()) {
        
        self.storage = storage
        
        super.init(parent: parent)
    }
    
    func getAnswer() -> [AnswerHistoryModel] {
        return storage.getGivenAnswer().map{ AnswerHistoryModel.init(date: $0.date, message: $0.message) }
    }
}
