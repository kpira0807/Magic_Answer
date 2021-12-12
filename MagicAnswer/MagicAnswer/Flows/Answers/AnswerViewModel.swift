import Foundation
import RxSwift

class AnswerViewModel {
    
    private let model: AnswerModel
    
    init(model: AnswerModel) {
        self.model = model
        self.subscribeOnNewAnswer()
    }
    
    enum Result {
        case success(String)
        case failed(ErrorType)
    }
    
    var answerText = PublishSubject<Result>()
    
    func userDidShake(with question: String) {
        
        if isQuestionExist(question) {
            self.answerText.onNext(.failed(ErrorType.emptyField))
        } else {
            model.generateRandomAnswer()
        }
    }
    private let disposeBag = DisposeBag()
    
    private func subscribeOnNewAnswer() {
        model.randomAnswer.subscribe(onNext: { [weak self] answer in
            self?.model.saveShakeAnswer(answer)
            self?.answerText.onNext(.success(answer))
        })
            .disposed(by: disposeBag)
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
