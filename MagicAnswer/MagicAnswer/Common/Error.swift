import Foundation

enum ErrorType: Error {
    case emptyField

    var message: String {
        switch self {
        case .emptyField:
            return L10n.emptyField
        }
    }
}
