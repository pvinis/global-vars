import Foundation
import AppIntents

enum IntentError: Swift.Error, CustomLocalizedStringResourceConvertible {
    case variableNotFound(String)

    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .variableNotFound(let name):
            return "Variable '\(name)' not found"
        }
    }
}
