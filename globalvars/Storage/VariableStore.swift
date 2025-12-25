import Foundation

@MainActor
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

    // MARK: - Boolean Operations

    func setBoolean(_ value: Bool, forKey key: String) {
        booleans[key] = value
        saveBooleans()
    }

    func getBoolean(forKey key: String) -> Bool? {
        return booleans[key]
    }

    func removeBoolean(forKey key: String) {
        booleans.removeValue(forKey: key)
        saveBooleans()
    }

    // MARK: - String Operations

    func setString(_ value: String, forKey key: String) {
        strings[key] = value
        saveStrings()
    }

    func getString(forKey key: String) -> String? {
        return strings[key]
    }

    func removeString(forKey key: String) {
        strings.removeValue(forKey: key)
        saveStrings()
    }

    // MARK: - Persistence

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

    private func saveBooleans() {
        if let data = try? JSONEncoder().encode(booleans) {
            defaults.set(data, forKey: booleansKey)
        }
    }

    private func saveStrings() {
        if let data = try? JSONEncoder().encode(strings) {
            defaults.set(data, forKey: stringsKey)
        }
    }
}
