import Foundation

class SettingViewModel {

    private let model: SettingModel

    var updateData: ((Fields) -> Void)?

    private var currentFields: Fields

    typealias Fields = (first: String?, second: String?, third: String?)

    init(model: SettingModel) {
        self.model = model
        self.currentFields = SettingViewModel.convertToFields(model.getAndUpdateDefaultQuestion())
    }

    func viewLoaded() {
        updateData?(currentFields)
    }

    func firstAnswerDidSelectRow(row: Int) {
        let answer = model.getAndUpdateFirstAnswer(for: row)
        currentFields.first = answer
        updateData?(currentFields)
    }

    func secondAnswerDidSelectRow(row: Int) {
        let answer = model.getAndUpdateSecondAnswer(for: row)
        currentFields.second = answer
        updateData?(currentFields)
    }

    func thirdAnswerDidSelectRow(row: Int) {
        let answer = model.getAndUpdateThirdAnswer(for: row)
        currentFields.third = answer
        updateData?(currentFields)
    }

    func getFirstAnswerNum() -> Int {
        return model.firstAnswer.count
    }

    func getSecondAnswerNum() -> Int {
        return model.secondAnswer.count
    }

    func getThirdAnswerNum() -> Int {
        return model.thirdAnswer.count
    }

    func getFirstAnswers(for row: Int) -> String? {
        return model.firstAnswer[row]
    }

    func getSecondAnswers(for row: Int) -> String? {
        return model.secondAnswer[row]
    }

    func getThirdAnswers(for row: Int) -> String? {
        return model.thirdAnswer[row]
    }

    private static func convertToFields(_ convertAnswer: [String]) -> Fields {
        let convertAnswer1 = convertAnswer[0]
        let convertAnswer2 = convertAnswer[1]
        let convertAnswer3 = convertAnswer[2]

        let fields: Fields = (first: convertAnswer1, second: convertAnswer2, third: convertAnswer3)
        return fields
    }
}
