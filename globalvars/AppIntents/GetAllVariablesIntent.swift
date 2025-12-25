import AppIntents

struct GetAllVariablesIntent: AppIntent {
    static let title: LocalizedStringResource = "Get All Global Variables"
    static let description = IntentDescription("Gets all stored global variables as a formatted list")

    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let store = VariableStore.shared
        var lines: [String] = []

        for (key, value) in store.booleans.sorted(by: { $0.key < $1.key }) {
            lines.append("\(key) = \(value) (bool)")
        }

        for (key, value) in store.strings.sorted(by: { $0.key < $1.key }) {
            lines.append("\(key) = \"\(value)\" (string)")
        }

        if lines.isEmpty {
            return .result(value: "No variables stored")
        }

        return .result(value: lines.joined(separator: "\n"))
    }
}
