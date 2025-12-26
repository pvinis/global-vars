import WidgetKit
import SwiftUI

struct VariableEntry: TimelineEntry {
    let date: Date
    let displayText: String
}

struct VariableProvider: AppIntentTimelineProvider {
    typealias Entry = VariableEntry
    typealias Intent = SelectVariableIntent

    func placeholder(in context: Context) -> VariableEntry {
        VariableEntry(date: .now, displayText: "Variable: value")
    }

    func snapshot(for configuration: SelectVariableIntent, in context: Context) async -> VariableEntry {
        getEntry(for: configuration)
    }

    func timeline(for configuration: SelectVariableIntent, in context: Context) async -> Timeline<VariableEntry> {
        let entry = getEntry(for: configuration)
        return Timeline(entries: [entry], policy: .after(.now.addingTimeInterval(60)))
    }

    private func getEntry(for configuration: SelectVariableIntent) -> VariableEntry {
        let store = VariableStore.shared
        let name = configuration.variableName

        let valueText: String
        switch configuration.variableType {
        case .boolean:
            if let value = store.getBoolean(forKey: name) {
                valueText = value ? configuration.trueText : configuration.falseText
            } else {
                valueText = "not set"
            }
        case .string:
            valueText = store.getString(forKey: name) ?? "not set"
        }

        let displayText: String
        switch configuration.displayFormat {
        case .valueOnly:
            displayText = valueText
        case .withKey:
            displayText = "\(name): \(valueText)"
        case .customPrefix:
            let prefix = configuration.customPrefix.isEmpty ? "" : "\(configuration.customPrefix): "
            displayText = "\(prefix)\(valueText)"
        }

        return VariableEntry(date: .now, displayText: displayText)
    }
}

struct VariableWidgetEntryView: View {
    var entry: VariableEntry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .accessoryInline:
            Text(entry.displayText)
        case .accessoryCircular:
            ZStack {
                AccessoryWidgetBackground()
                VStack(spacing: 2) {
                    Image(systemName: "globe.americas")
                        .font(.caption)
                    Text(entry.displayText)
                        .font(.caption2)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
            }
        case .accessoryRectangular:
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Image(systemName: "globe.americas")
                    Text("Global Var")
                        .font(.headline)
                }
                Text(entry.displayText)
                    .font(.body)
                    .minimumScaleFactor(0.7)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        default:
            Text(entry.displayText)
        }
    }
}

struct VariableWidget: Widget {
    let kind: String = "VariableWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: SelectVariableIntent.self,
            provider: VariableProvider()
        ) { entry in
            VariableWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Global Variable")
        .description("Displays a global variable value")
        .supportedFamilies([.accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}

#Preview(as: .accessoryInline) {
    VariableWidget()
} timeline: {
    VariableEntry(date: .now, displayText: "status: active")
}

#Preview(as: .accessoryCircular) {
    VariableWidget()
} timeline: {
    VariableEntry(date: .now, displayText: "ON")
}

#Preview(as: .accessoryRectangular) {
    VariableWidget()
} timeline: {
    VariableEntry(date: .now, displayText: "status: active")
}
