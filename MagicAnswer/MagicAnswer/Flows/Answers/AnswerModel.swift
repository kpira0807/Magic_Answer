import Foundation
import RxSwift

final class AnswerModel {
    
    private let downloader: AnswerDownloaderProtocol
    private let storage: AnswerStorageProtocol
    private let defaultAnswer: HardcodedAnswers
    private let history: HistoryStorage
    
    init(_ downloader: AnswerDownloaderProtocol = AnswerDownloader(),
         storage: AnswerStorageProtocol = AnswerStorage(),
         defaultAnswer: HardcodedAnswers = HardcodedAnswers(),
         history: HistoryStorage = HistoryStorage()) {
        self.downloader = downloader
        self.storage = storage
        self.defaultAnswer = defaultAnswer
        self.history = history
    }
    
    var randomAnswer = PublishSubject<String>()
    
    func generateRandomAnswer() {
        downloader.getQuestionResponse(success: { [weak self] answer in
            self?.randomAnswer.onNext(answer)
            }, failure: {[weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.randomAnswer.onNext(strongSelf.getStoredAnswer())
        })
    }
    
    private func getStoredAnswer() -> String {
        guard let answer = storage.getAnswer()?.randomElement() else {
            let defaultsAnswer = defaultAnswer.firstArrayAnswers.randomElement()
            
            return defaultsAnswer ?? defaultAnswer.defaultRandomAnswer
        }
        return answer
    }
    
    func saveShakeAnswer(_ text: String) {
        history.saveAnswer(text)
    }
}
