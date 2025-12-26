import AppIntents
import WidgetKit

enum VariableTypeOption: String, AppEnum {
    case boolean
    case string

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Variable Type"
    static var caseDisplayRepresentations: [VariableTypeOption: DisplayRepresentation] = [
        .boolean: "Boolean",
        .string: "String"
    ]
}

enum DisplayFormatOption: String, AppEnum {
    case valueOnly
    case withKey
    case customPrefix

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Display Format"
    static var caseDisplayRepresentations: [DisplayFormatOption: DisplayRepresentation] = [
        .valueOnly: "Value only",
        .withKey: "With variable name",
        .customPrefix: "Custom prefix"
    ]
}

struct SelectVariableIntent: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Select Variable"
    static let description = IntentDescription("Choose which variable to display and how")

    @Parameter(title: "Variable Name", default: "")
    var variableName: String

    @Parameter(title: "Variable Type", default: .boolean)
    var variableType: VariableTypeOption

    @Parameter(title: "Display Format", default: .valueOnly)
    var displayFormat: DisplayFormatOption

    @Parameter(title: "Custom Prefix", default: "")
    var customPrefix: String

    @Parameter(title: "Text for True", default: "true")
    var trueText: String

    @Parameter(title: "Text for False", default: "false")
    var falseText: String

    init() {}

    init(variableName: String, variableType: VariableTypeOption) {
        self.variableName = variableName
        self.variableType = variableType
    }
}
