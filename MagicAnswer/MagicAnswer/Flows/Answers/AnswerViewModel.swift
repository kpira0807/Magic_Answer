import Foundation

class AnswerViewModel {

    private let model: AnswerModel

    init(model: AnswerModel) {
        self.model = model
    }

    var updateAnswerLabel: ((String) -> Void)?
    var showError: ((ErrorType) -> Void)?

    func userDidShake(with question: String) {

        if isQuestionExist(question) {
            showError?(ErrorType.emptyField)
        } else {

            model.getRandomAnswer { answer in
                self.updateAnswerLabel?(answer)
            }
        }
    }
    private enum LocalConstant {
        static let minQuestionLength = 5
    }

    private func isQuestionExist(_ text: String?) -> Bool {
        return (text == "") ||
            (text == " ") ||
            (text?.count ?? 0 < LocalConstant.minQuestionLength)
    }
}
