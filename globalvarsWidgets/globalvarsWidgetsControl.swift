import AppIntents
import SwiftUI
import WidgetKit

struct ControlVariableConfiguration: ControlConfigurationIntent {
    static let title: LocalizedStringResource = "Select Variable"
    static let description = IntentDescription("Choose which boolean variable to display")

    @Parameter(title: "Variable Name", default: "")
    var variableName: String

    @Parameter(title: "Shortcut Name", default: "")
    var shortcutName: String

    @Parameter(title: "Text for True", default: "ON")
    var trueText: String

    @Parameter(title: "Text for False", default: "OFF")
    var falseText: String
}

struct RunShortcutIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Run Shortcut"

    @Parameter(title: "Is On")
    var value: Bool

    @Parameter(title: "Shortcut Name")
    var shortcutName: String

    init() {}

    init(value: Bool, shortcutName: String) {
        self.value = value
        self.shortcutName = shortcutName
    }

    func perform() async throws -> some IntentResult {
        if !shortcutName.isEmpty {
            let encodedName = shortcutName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? shortcutName
            if let url = URL(string: "shortcuts://run-shortcut?name=\(encodedName)") {
                return .result(opensIntent: OpenURLIntent(url))
            }
        }
        return .result()
    }
}

struct GlobalVarControlWidget: ControlWidget {
    var body: some ControlWidgetConfiguration {
        AppIntentControlConfiguration(
            kind: "com.pvinis.globalvars.control",
            intent: ControlVariableConfiguration.self
        ) { configuration in
            ControlWidgetToggle(
                isOn: getCurrentValue(for: configuration.variableName),
                action: RunShortcutIntent(
                    value: !getCurrentValue(for: configuration.variableName),
                    shortcutName: configuration.shortcutName
                )
            ) { isOn in
                Label(
                    isOn ? configuration.trueText : configuration.falseText,
                    systemImage: isOn ? "checkmark.circle.fill" : "circle"
                )
            }
        }
        .displayName("Global Variable")
        .description("Toggle a global variable via shortcut")
    }

    private func getCurrentValue(for variableName: String) -> Bool {
        guard !variableName.isEmpty else { return false }
        return VariableStore.shared.getBoolean(forKey: variableName) ?? false
    }
}
