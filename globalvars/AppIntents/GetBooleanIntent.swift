import AppIntents

struct GetBooleanIntent: AppIntent {
    static let title: LocalizedStringResource = "Get Boolean Global Variable"
    static let description = IntentDescription("Gets the value of a boolean variable")

    @Parameter(title: "Variable Name")
    var variableName: String

    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<Bool> {
        guard let value = VariableStore.shared.getBoolean(forKey: variableName) else {
            throw IntentError.variableNotFound(variableName)
        }
        return .result(value: value)
    }
}
