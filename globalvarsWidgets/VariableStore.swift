import Foundation

final class VariableStore {
    static let shared = VariableStore()

    private let defaults: UserDefaults
    private let booleansKey = "globalvars.booleans"
    private let stringsKey = "globalvars.strings"

    private init() {
        guard let defaults = UserDefaults(suiteName: "group.com.pvinis.globalvars") else {
            fatalError("App Group not configured")
        }
        self.defaults = defaults
    }

    func getBoolean(forKey key: String) -> Bool? {
        guard let data = defaults.data(forKey: booleansKey),
              let booleans = try? JSONDecoder().decode([String: Bool].self, from: data) else {
            return nil
        }
        return booleans[key]
    }

    func getString(forKey key: String) -> String? {
        guard let data = defaults.data(forKey: stringsKey),
              let strings = try? JSONDecoder().decode([String: String].self, from: data) else {
            return nil
        }
        return strings[key]
    }
}
