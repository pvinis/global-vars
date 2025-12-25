import AppIntents

struct DeleteGlobalVariableIntent: AppIntent {
    static let title: LocalizedStringResource = "Delete Global Variable"
    static let description = IntentDescription("Deletes a global variable by name", categoryName: "Misc")

    @Parameter(title: "Variable Name")
    var variableName: String

    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<Bool> {
        let store = VariableStore.shared
        var deleted = false

        if store.booleans[variableName] != nil {
            store.removeBoolean(forKey: variableName)
            deleted = true
        }

        if store.strings[variableName] != nil {
            store.removeString(forKey: variableName)
            deleted = true
        }

        return .result(value: deleted)
    }
}
