import Foundation

final class VariableStore {
    static let shared = VariableStore()

    private let defaults: UserDefaults
    private let booleansKey = "globalvars.booleans"
    private let stringsKey = "globalvars.strings"

    private(set) var booleans: [String: Bool] = [:]
    private(set) var strings: [String: String] = [:]

    private init() {
        guard let defaults = UserDefaults(suiteName: "group.com.pvinis.globalvars") else {
            fatalError("App Group not configured")
        }
        self.defaults = defaults
        load()
    }

    func getBoolean(forKey key: String) -> Bool? {
        return booleans[key]
    }

    func getString(forKey key: String) -> String? {
        return strings[key]
    }

    private func load() {
        if let data = defaults.data(forKey: booleansKey),
           let decoded = try? JSONDecoder().decode([String: Bool].self, from: data) {
            booleans = decoded
        }
        if let data = defaults.data(forKey: stringsKey),
           let decoded = try? JSONDecoder().decode([String: String].self, from: data) {
            strings = decoded
        }
    }
}
