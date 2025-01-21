import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "Title", content: "Content", progress: 0.0, proLogo: "", carLogo: "", fatLogo: "", carbs: "", protein: "", fats: "", progressCarbs: 0.1, progressProt: 0.2, progressFats: 0.3)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), title: "1234", content: "Calorías restantes", progress: 0.34, proLogo: "", carLogo: "", fatLogo: "", carbs: "", protein: "", fats: "", progressCarbs: 0.1, progressProt: 0.2, progressFats: 0.3)
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
        
        let progressCarbs = sharedDefaults?.double(forKey: "progressCarbs") ?? 0.34
        let progressProt = sharedDefaults?.double(forKey: "progressProt") ?? 0.34
        let progressFats = sharedDefaults?.double(forKey: "progressFats") ?? 0.34
        
        let entryDate = Date()
        let entry = SimpleEntry(date: entryDate, title: title, content: content, progress: progress, proLogo: proLogo, carLogo: carLogo, fatLogo: fatLogo, carbs: carbs, protein: protein, fats: fats, progressCarbs: progressCarbs, progressProt: progressProt, progressFats: progressFats)
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
    
    let progressCarbs: Double
    let progressProt: Double
    let progressFats: Double
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
                ZStack(alignment: .center) {
                    //                    RoundedRectangle(cornerRadius: 10)
                    //                        .fill(Color.gray.opacity(0.2))
                    //                        .frame(width: 30, height: 100)
                    //
                    //                    RoundedRectangle(cornerRadius: 10)
                    //                        .fill(colorScheme == .dark ? Color.white : Color.black)
                    //                        .frame(width: 30, height: CGFloat(entry.progress * 100))
                    
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                    Circle()
                        .trim(from: 0.0, to: CGFloat(entry.progress))
                        .stroke(colorScheme == .dark ? Color.white : Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut, value: 0)
                    VStack(alignment: .center, spacing: 5) {
                        Text(entry.title)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text(entry.content)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                //                VStack(alignment: .center, spacing: 5) {
                //                    Text(entry.title)
                //                        .font(.subheadline)
                //                        .fontWeight(.bold)
                //                    Text(entry.content)
                //                        .font(.caption)
                //                        .foregroundColor(.gray)
                //                    ProgressView(value: entry.progress)
                //                        .progressViewStyle(LinearProgressViewStyle())
                //                        .frame(height: 10)
                //                }
            }
            .containerBackground(Color.clear, for: .widget)
            
        case .systemMedium:
            // Vista para widgets medianos
            HStack(alignment: .top) {
                // Barra de progreso vertical
                VStack {
                    ZStack(alignment: .center) {
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color.gray.opacity(0.2))
//                            .frame(width: 30, height: 100)
//                        
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(colorScheme == .dark ? Color.white : Color.black)
//                            .frame(width: 30, height: CGFloat(entry.progress * 100))
                        
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                        Circle()
                            .trim(from: 0.0, to: CGFloat(entry.progress))
                            .stroke(colorScheme == .dark ? Color.white : Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut, value: 0)
                        VStack(alignment: .center, spacing: 5) {
                            Text(entry.title)
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text(entry.content)
                                .font(.caption)
                                .lineLimit(2)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                   
                }
                
                //                // Calorías restantes
                //                VStack(alignment: .center, spacing: 2) {
                //                    Text(entry.title)
                //                        .font(.title)
                //                        .fontWeight(.bold)
                //                    Text(entry.content)
                //                        .font(.caption)
                //                        .foregroundColor(.gray)
                //                }
                
                Spacer(minLength: 1)
                VStack(alignment: .leading, spacing: 15) {
                    HStack(alignment: .top ) {
                        ZStack(alignment: .center ){
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 3)
                            Circle()
                                .trim(from: 0.0, to: CGFloat(entry.progressProt))
//                                .stroke(colorScheme == .dark ? Color.white : Color.black,
                                .stroke(Color.init(red: 215/255, green: 105/255, blue: 119/255),
                                        style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                .rotationEffect(.degrees(-90))
                                .animation(.easeInOut, value: 0)
                            if let uiImage = UIImage(contentsOfFile: entry.proLogo) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .padding(4)
                                    .background(Circle().fill(Color.white))
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 1) {
                            
                            Text("\(entry.protein)")
                                .font(.caption)
                                .fontWeight(.bold)
                            Text("Proteína")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    }
                    
                    
                    HStack(alignment: .top ) {
                        ZStack(alignment: .center ){
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 3)
                            Circle()
                                .trim(from: 0.0, to: CGFloat(entry.progressCarbs))
//                                .stroke(colorScheme == .dark ? Color.white : Color.black,
                                .stroke(Color.init(red: 224/255, green: 160/255, blue: 121/255),
                                        style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                .rotationEffect(.degrees(-90))
                                .animation(.easeInOut, value: 0)
                            if let uiImage = UIImage(contentsOfFile: entry.carLogo) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .padding(4)
                                    .background(Circle().fill(Color.white))
                            }
                        }
                
                        
                        VStack(alignment: .leading, spacing: 1) {
                            Text("\(entry.carbs)")
                                .font(.caption)
                                .fontWeight(.bold)
                            Text("Carbohidratos")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    }
                    HStack(alignment: .top ) {
                        ZStack(alignment: .center ){
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 3)
                            Circle()
                                .trim(from: 0.0, to: CGFloat(entry.progressFats))
//                                .stroke(colorScheme == .dark ? Color.white : Color.black,
                                .stroke(Color.init(red: 124/255, green: 165/255, blue: 225/255),
                                        style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                .rotationEffect(.degrees(-90))
                                .animation(.easeInOut, value: 0)
                            if let uiImage = UIImage(contentsOfFile: entry.fatLogo) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .padding(4)
                                    .background(Circle().fill(Color.white))
                            }
                        }
                      
                        VStack(alignment: .leading, spacing: 1) {
                            Text("\(entry.fats)")
                                .font(.caption)
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

