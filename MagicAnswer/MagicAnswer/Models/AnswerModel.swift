import Foundation

struct Answer: Codable {
    var answer: String
    var question: String
    var type: String
}

struct Magic: Codable {
    var magic: Answer
}
