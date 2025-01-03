import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "Title", content: "Content", progress: 0.0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), title: "Sin datos", content: "Para hacer uso de este widget termina de configurar tu perfil", progress: 0.0)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let sharedDefaults = UserDefaults(suiteName: "group.mx.posibilidades.macrolife")
        let title = sharedDefaults?.string(forKey: "title") ?? "Sin datos"
        let content = sharedDefaults?.string(forKey: "content") ?? "Para hacer uso de este widget termina de configurar tu perfil"
        let progress = sharedDefaults?.double(forKey: "progress") ?? 0.0

        let entryDate = Date()
        let entry = SimpleEntry(date: entryDate, title: title, content: content, progress: progress)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let content: String
    let progress: Double
}

struct HomeWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                    Circle()
                        .trim(from: 0.0, to: CGFloat(entry.progress))
                        .stroke(Color.pink, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90)) // Inicia desde arriba
                        .animation(.easeInOut, value: entry.progress)
                }
                .frame(width: 80, height: 80)

                // Mostrar título y contenido
                Text(entry.title)
                    .font(.headline)
                Text(entry.content)
                    .font(.subheadline)
           
        }
        .containerBackground(Color.clear, for: .widget)
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

struct HomeWidget_Previews: PreviewProvider {
    static var previews: some View {
        HomeWidgetEntryView(entry: SimpleEntry(date: Date(), title: "Preview", content: "Contenido de prueba", progress: 0.6))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

