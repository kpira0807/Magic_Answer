import Foundation

protocol AnswerDownloaderProtocol {
    func getQuestionResponse(success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

final class AnswerDownloader: AnswerDownloaderProtocol {

    private let answerURL = "https://8ball.delegator.com/magic/JSON/question"

    private let session: URLSession

    init(_ session: URLSession =  URLSession.shared) {
        self.session = session
    }

    func getQuestionResponse(success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {

        guard let url = URL(string: answerURL) else { return }

        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error: ", error)
                failure(error)
                return
            }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(Magic.self, from: data)
                success(data.magic.answer)

            } catch let jsonError {
                print(jsonError)
                failure(jsonError)
            }
        }.resume()
    }
}
