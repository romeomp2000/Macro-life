import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "Title", content: "Content")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), title: "Title", content: "Content")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let sharedDefaults = UserDefaults(suiteName: "group.mx.posibilidades.macrolife")
        let title = sharedDefaults?.string(forKey: "title") ?? "Title"
        let content = sharedDefaults?.string(forKey: "content") ?? "Content"

        let entryDate = Date()
        let entry = SimpleEntry(date: entryDate, title: title, content: content)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let content: String
}

struct HomeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.title)
                .font(.headline)
            Text(entry.content)
                .font(.body)
        }.containerBackground(.white, for: .widget)
    }
}

struct HomeWidget: Widget {
    let kind: String = "HomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HomeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Macrolife Widget")
        .description("Widgets para mostrar el progreso de los usuarios.")
    }
}
