import Foundation

final class AnswerModel {

    private let downloader: AnswerDownloaderProtocol
    private let storage: AnswerStorageProtocol
    private let defaultAnswer: HardcodedAnswers
    
    init(_ downloader: AnswerDownloaderProtocol = AnswerDownloader(),
         storage: AnswerStorageProtocol = AnswerStorage(),
         defaultAnswer: HardcodedAnswers = HardcodedAnswers()) {
        self.downloader = downloader
        self.storage = storage
        self.defaultAnswer = defaultAnswer
    }

    func getRandomAnswer(_ completion: @escaping (String) -> Void) {
        downloader.getQuestionResponse(success: { answer in completion(answer)

        }, failure: {[weak self] _ in
            guard let strongSelf = self else {
                return
            }
            completion(strongSelf.getStoredAnswer())
        })
    }

    private func getStoredAnswer() -> String {
        guard let answer = storage.getAnswer()?.randomElement() else {
            let defaultsAnswer = defaultAnswer.firstArrayAnswers.randomElement()

            return defaultsAnswer ?? defaultAnswer.defaultRandomAnswer
        }
        return answer
    }
}
