import Foundation

class SettingModel {
    
    private let answers: HardcodedAnswers
    private let storage: AnswerStorageProtocol

    init(answers: HardcodedAnswers = HardcodedAnswers(),
         storage: AnswerStorageProtocol = AnswerStorage()) {
        self.answers = answers
        self.storage = storage
    }
    
    var firstAnswer: [String] {
        return answers.firstArrayAnswers
    }

    var secondAnswer: [String] {
        return answers.secondArrayAnswers
    }

    var thirdAnswer: [String] {
        return answers.thirdArrayAnswers
    }

    func getAndUpdateDefaultQuestion() -> [String] {
        let answer = [answers.firstArrayAnswers[0],
                      answers.secondArrayAnswers[0],
                      answers.thirdArrayAnswers[0]]
        saveData(fields: answer)
        return answer
    }
    
    func getAndUpdateFirstAnswer(for row: Int) -> String {
        let answer = firstAnswer[row]
        updateAnswer(answer, for: row)
        return answer
    }

    func getAndUpdateSecondAnswer(for row: Int) -> String {
        let answer = secondAnswer[row]
        updateAnswer(answer, for: row)
        return answer
    }

    func getAndUpdateThirdAnswer(for row: Int) -> String {
        let answer = thirdAnswer[row]
        updateAnswer(answer, for: row)
        return answer
    }

    private func saveData(fields: [String]) {
        storage.saveAnswer(fields)
    }

    private func updateAnswer(_ answer: String, for index: Int) {
        if var allStored = storage.getAnswer(), allStored.count < index {
            allStored.remove(at: index)
            allStored.insert(answer, at: index)
            storage.saveAnswer(allStored)
        }
    }
}
