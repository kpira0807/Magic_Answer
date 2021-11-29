import Foundation

class HistoryViewModel {
    
    private var answers: [Answers] = []
    private let model: HistoryModel
    
    init(with model: HistoryModel) {
        self.model = model
    }
    
    struct Answers {
        let date: String
        let message: String
    }
    
    func loadInfo() {
        self.answers = model.getAnswer().map {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            return Answers.init(date: dateFormatter.string(from: $0.date), message: $0.message)
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return answers.count
    }
    
    func message(for index: Int) -> String {
        return answers[index].message
    }
    
    func dateString(for index: Int) -> String {
        return answers[index].date
    }
}

