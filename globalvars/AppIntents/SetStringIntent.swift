import AppIntents

struct SetStringIntent: AppIntent {
    static let title: LocalizedStringResource = "Set String Global Variable"
    static let description = IntentDescription("Sets a string global variable to the specified value", categoryName: "String")

    @Parameter(title: "Variable Name")
    var variableName: String

    @Parameter(title: "Value")
    var value: String

    @MainActor
    func perform() async throws -> some IntentResult {
        VariableStore.shared.setString(value, forKey: variableName)
        return .result()
    }
}
