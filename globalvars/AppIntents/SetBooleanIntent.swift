import AppIntents

struct SetBooleanIntent: AppIntent {
    static let title: LocalizedStringResource = "Set Boolean Global Variable"
    static let description = IntentDescription("Sets a boolean global variable to the specified value", categoryName: "Boolean")

    @Parameter(title: "Variable Name")
    var variableName: String

    @Parameter(title: "Value")
    var value: Bool

    @MainActor
    func perform() async throws -> some IntentResult {
        VariableStore.shared.setBoolean(value, forKey: variableName)
        return .result()
    }
}
