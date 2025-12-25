import AppIntents

struct GetStringIntent: AppIntent {
    static let title: LocalizedStringResource = "Get String Global Variable"
    static let description = IntentDescription("Gets the value of a string global variable", categoryName: "String")

    @Parameter(title: "Variable Name")
    var variableName: String

    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        guard let value = VariableStore.shared.getString(forKey: variableName) else {
            throw IntentError.variableNotFound(variableName)
        }
        return .result(value: value)
    }
}
