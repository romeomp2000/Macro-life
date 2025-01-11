import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "Title", content: "Content", progress: 0.0, proLogo: "", carLogo: "", fatLogo: "", carbs: "", protein: "", fats: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), title: "1234", content: "Calorías restantes", progress: 0.34, proLogo: "", carLogo: "", fatLogo: "", carbs: "", protein: "", fats: "")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let sharedDefaults = UserDefaults(suiteName: "group.mx.posibilidades.macrolife")
        let title = sharedDefaults?.string(forKey: "title") ?? "1234"
        let content = sharedDefaults?.string(forKey: "content") ?? "Calorías restantes"
        let progress = sharedDefaults?.double(forKey: "progress") ?? 0.34
        let proLogo = sharedDefaults?.string(forKey: "proLogo") ?? ""
        let carLogo = sharedDefaults?.string(forKey: "carLogo") ?? ""
        let fatLogo = sharedDefaults?.string(forKey: "fatLogo") ?? ""
        
        let protein = sharedDefaults?.string(forKey: "protein") ?? "234"
        let carbs = sharedDefaults?.string(forKey: "carbs") ?? "45"
        let fats = sharedDefaults?.string(forKey: "fats") ?? "65"

        let entryDate = Date()
        let entry = SimpleEntry(date: entryDate, title: title, content: content, progress: progress, proLogo: proLogo, carLogo: carLogo, fatLogo: fatLogo, carbs: carbs, protein: protein, fats: fats)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String //Son las calorias
    let content: String
    let progress: Double
    let proLogo: String
    let carLogo: String
    let fatLogo: String
    
    let carbs: String //Carbohidratos
    let protein: String //Proteinas
    let fats: String //Grasas
}

struct HomeWidgetEntryView: View {
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.colorScheme) var colorScheme
    
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            // Vista para widgets pequeños
            HStack{
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 30, height: 100)

                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .dark ? Color.white : Color.black)
                        .frame(width: 30, height: CGFloat(entry.progress * 100))
                }
                VStack(alignment: .center, spacing: 5) {
                    Text(entry.title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text(entry.content)
                        .font(.caption)
                        .foregroundColor(.gray)
//                    ProgressView(value: entry.progress)
//                        .progressViewStyle(LinearProgressViewStyle())
//                        .frame(height: 10)
                }
            }
            .containerBackground(Color.clear, for: .widget)

        case .systemMedium:
            // Vista para widgets medianos
            HStack {
                // Barra de progreso vertical
                VStack {
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 30, height: 100)

                        RoundedRectangle(cornerRadius: 10)
                            .fill(colorScheme == .dark ? Color.white : Color.black)
                            .frame(width: 30, height: CGFloat(entry.progress * 100))
                    }
                }

                // Calorías restantes
                VStack(alignment: .center, spacing: 2) {
                    Text(entry.title)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(entry.content)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()
                VStack(alignment: .center, spacing: 2) {
                    HStack {
                        if let uiImage = UIImage(contentsOfFile: entry.proLogo) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 15, height: 15)
                                .padding(4)
                                .background(Circle().fill(Color.white))
                        }
                        VStack(alignment: .center, spacing: 1) {
                            
//                            if let val = Double(entry.protein) {
//                                    Text("\(abs(Int(val)))")
//                                        .font(.system(size: 13, weight: .bold))
//                                        .foregroundColor(.white)
//                                }
                            Text("\(entry.protein)g")
                                .fontWeight(.bold)
                            Text("Proteína")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    }
                    HStack {
                        if let uiImage = UIImage(contentsOfFile: entry.carLogo) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 15, height: 15)
                                .padding(4)
                                .background(Circle().fill(Color.white))
                        }
                        VStack(alignment: .center, spacing: 1) {
                            Text("\(entry.carbs)g")
                                .fontWeight(.bold)
                            Text("Carbohidratos")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    }
                    HStack {
                        if let uiImage = UIImage(contentsOfFile: entry.fatLogo) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 15, height: 15)
                                .padding(4)
                                .background(Circle().fill(Color.white))
                        }
                        VStack(alignment: .center, spacing: 1) {
                            Text("\(entry.fats)g")
                                .fontWeight(.bold)
                            Text("Grasas")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    }
                }
                .padding(.trailing)
            }
            .padding()
            .containerBackground(Color.clear, for: .widget)

        default:
            Text("Widget no soportado")
        }
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
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

