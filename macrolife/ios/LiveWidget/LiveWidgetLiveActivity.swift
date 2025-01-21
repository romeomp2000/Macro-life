//
//  LiveWidgetLiveActivity.swift
//  LiveWidget
//
//  Created by Osvaldo on 07/01/25.
import ActivityKit
import WidgetKit
import SwiftUI


struct Widgets: WidgetBundle {
    var body: some Widget {
        if #available(iOS 16.1, *) {
            LiveWidgetLiveActivity()
        }
    }
}

struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
    public typealias LiveDeliveryData = ContentState
    
    public struct ContentState: Codable, Hashable { }
    
    var id = UUID()
}

let sharedDefault = UserDefaults(suiteName: "group.mx.posibilidades.macrolife")!

@available(iOSApplicationExtension 16.1, *)
struct LiveWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            let cal = sharedDefault.string(forKey: context.attributes.prefixedKey("cal")) ?? "1234"
            let carbohidrato = sharedDefault.string(forKey: context.attributes.prefixedKey("carbohidratos")) ?? "1234"
            let protein = sharedDefault.string(forKey: context.attributes.prefixedKey("protein")) ?? "1234"
            let grasas = sharedDefault.string(forKey: context.attributes.prefixedKey("grasas")) ?? "1234"
            
//            let logo = sharedDefault.string(forKey: context.attributes.prefixedKey("logo"))!
            let logoCal = sharedDefault.string(forKey: context.attributes.prefixedKey("logoCal"))!
            let logoCarbs = sharedDefault.string(forKey: context.attributes.prefixedKey("logoCar"))!
            let logoGrasas = sharedDefault.string(forKey: context.attributes.prefixedKey("logoGrasa"))!
            let logoProtein = sharedDefault.string(forKey: context.attributes.prefixedKey("logoProt"))!
            
            let progress = sharedDefault.double(forKey: context.attributes.prefixedKey("progressCal"))
            let progressProtein = sharedDefault.double(forKey: context.attributes.prefixedKey("progressProtein"))
            let progressCarbs = sharedDefault.double(forKey: context.attributes.prefixedKey("progressCarbs"))
            let progressFats = sharedDefault.double(forKey: context.attributes.prefixedKey("progressFats"))
            
            
            HStack {
                VStack(alignment:.center){
                    HStack(){
                        Text("Hoy")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.white)
                            .padding(3)
                        Spacer()
                        Text("Macro Life")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                            .padding(3)
                    }.padding(10)
                    HStack(spacing: 16) { // Controla el espacio entre elementos
                        // Primera columna
                        VStack {
                            ZStack {
                                Circle()
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 5)
                                Circle()
                                    .trim(from: 0.0, to: CGFloat(progress))
                                    .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .rotationEffect(.degrees(-90))
                                    .animation(.easeInOut, value: 0)
                                
                                if let uiLogoCal = UIImage(contentsOfFile: logoCal) {
                                    Image(uiImage: uiLogoCal)
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                        .padding(4)
                                        .background(Circle().fill(Color.white))
                                }
                            }
                            .frame(width: 40, height: 40)
                            if let calValue = Double(cal) {
                                    Text("\(abs(Int(calValue)))")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    Text(calValue < 0 ? "Calorías\nmás" : "Calorías\nrestantes")
                                        .font(.system(size: 8, weight: .light))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                }
                        }
                        
                        Spacer()
                            .frame(width: 10)
                        
                        // Segunda columna
                        HStack(spacing: 8) {
                            // Proteínas
                            VStack {
                                ZStack {
                                    Circle()
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 3)
                                    Circle()
                                        .trim(from: 0.0, to: CGFloat(progressProtein))
                                        .stroke(Color.init(red: 215/255, green: 105/255, blue: 119/255), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                        .rotationEffect(.degrees(-90))
                                        .animation(.easeInOut, value: 0)
                                    
                                    if let uiLogoProt = UIImage(contentsOfFile: logoProtein) {
                                        Image(uiImage: uiLogoProt)
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                            .padding(3)
                                            .background(Circle().fill(Color.white))
                                    }
                                }
                                .frame(width: 35, height: 35)
                                .padding(5)
                                
                                if let calValue = Double(protein) {
                                        Text("\(abs(Int(calValue)))")
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(.white)
                                        
                                        Text(calValue < 0 ? "Proteínas\nmás" : "Proteínas\nrestantes")
                                            .font(.system(size: 8, weight: .light))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    }
                                
//                                Text(protein)
//                                    .font(.system(size: 10, weight: .bold))
//                                    .foregroundColor(.white)
//                                Text("Proteínas\nrestantes")
//                                    .font(.system(size: 8, weight: .light))
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.white)
                            }
                            
                            // Carbohidratos
                            VStack {
                                ZStack {
                                    Circle()
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 3)
                                    Circle()
                                        .trim(from: 0.0, to: CGFloat((progressCarbs)))
                                        .stroke(Color.init(red: 224/255, green: 160/255, blue: 121/255), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                        .rotationEffect(.degrees(-90))
                                        .animation(.easeInOut, value: 0)
                                    
                                    if let uiLogoCar = UIImage(contentsOfFile: logoCarbs) {
                                        Image(uiImage: uiLogoCar)
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                            .padding(3)
                                            .background(Circle().fill(Color.white))
                                    }
                                }
                                .frame(width: 35, height: 35)
                                .padding(5)
                                if let calValue = Double(carbohidrato) {
                                        Text("\(abs(Int(calValue)))")
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(.white)
                                        
                                        Text(calValue < 0 ? "Carbohidratos\nmás" : "Carbohidratos\nrestantes")
                                            .font(.system(size: 8, weight: .light))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    }
//                                Text(carbohidrato)
//                                    .font(.system(size: 10, weight: .bold))
//                                    .foregroundColor(.white)
//                                Text("Carbohidratos\nrestantes")
//                                    .font(.system(size: 8, weight: .light))
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.white)
                            }
                            
                            // Grasas
                            VStack {
                                ZStack {
                                    Circle()
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 3)
                                    Circle()
                                        .trim(from: 0.0, to: CGFloat(progressFats))
                                        .stroke(Color.init(red: 124/255, green: 165/255, blue: 225/255), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                        .rotationEffect(.degrees(-90))
                                        .animation(.easeInOut, value: 0)
                                    
                                    if let uiLogoGrasas = UIImage(contentsOfFile: logoGrasas) {
                                        Image(uiImage: uiLogoGrasas)
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                            .padding(3)
                                            .background(Circle().fill(Color.white))
                                    }
                                }
                                .frame(width: 35, height: 35)
                                .padding(5)
                                if let calValue = Double(grasas) {
                                        Text("\(abs(Int(calValue)))")
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(.white)
                                        
                                        Text(calValue < 0 ? "Grasas\nmás" : "Grasas\nrestantes")
                                            .font(.system(size: 8, weight: .light))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    }
//                                Text(grasas)
//                                    .font(.system(size: 10, weight: .bold))
//                                    .foregroundColor(.white)
//                                Text("Grasas\nrestantes")
//                                    .font(.system(size: 8, weight: .light))
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                }
                .padding(10) 
                .background(Color.black)
                
            }
            .background(Color.black)
            
            
        } dynamicIsland: { context in
            let cal = sharedDefault.string(forKey: context.attributes.prefixedKey("cal")) ?? "1234"
            let carbohidrato = sharedDefault.string(forKey: context.attributes.prefixedKey("carbohidratos")) ?? "1234"
            let protein = sharedDefault.string(forKey: context.attributes.prefixedKey("protein")) ?? "1234"
            let grasas = sharedDefault.string(forKey: context.attributes.prefixedKey("grasas")) ?? "1234"
            
            let logo = sharedDefault.string(forKey: context.attributes.prefixedKey("logo"))!
            let logoCal = sharedDefault.string(forKey: context.attributes.prefixedKey("logoCal"))!
            let logoCarbs = sharedDefault.string(forKey: context.attributes.prefixedKey("logoCar"))!
            let logoGrasas = sharedDefault.string(forKey: context.attributes.prefixedKey("logoGrasa"))!
            let logoProtein = sharedDefault.string(forKey: context.attributes.prefixedKey("logoProt"))!
            let progress = sharedDefault.double(forKey: context.attributes.prefixedKey("progressCal"))
            let progressProtein = sharedDefault.double(forKey: context.attributes.prefixedKey("progressProtein"))
            let progressCarbs = sharedDefault.double(forKey: context.attributes.prefixedKey("progressCarbs"))
            let progressFats = sharedDefault.double(forKey: context.attributes.prefixedKey("progressFats"))
            
            //        let progress = 0.3;
            
            return DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading){
                    Text("Hoy")
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(.white)
                        .padding(3)
                }
                DynamicIslandExpandedRegion(.trailing){
                    Text("Macro Life")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                        .padding(3)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    HStack(spacing: 16) { // Controla el espacio entre elementos
                        // Primera columna
                        VStack {
                            ZStack {
                                Circle()
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 5)
                                Circle()
                                    .trim(from: 0.0, to: CGFloat(progress))
                                    .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .rotationEffect(.degrees(-90))
                                    .animation(.easeInOut, value: 0)
                                
                                if let uiLogoCal = UIImage(contentsOfFile: logoCal) {
                                    Image(uiImage: uiLogoCal)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding(4)
                                        .background(Circle().fill(Color.white))
                                }
                            }
                            .frame(width: 40, height: 40)
                            if let calValue = Double(cal) {
                                    Text("\(abs(Int(calValue)))")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    Text(calValue < 0 ? "Calorías\nmás" : "Calorías\nrestantes")
                                        .font(.system(size: 8, weight: .light))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                }
//                            Text(cal)
//                                .font(.system(size: 13, weight: .bold))
//                                .foregroundColor(.white)
//                            Text("Calorías\nrestantes")
//                                .font(.system(size: 8, weight: .light))
//                                .foregroundColor(.white)
//                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer()
                            .frame(width: 10)
                        
                        // Segunda columna
                        HStack(spacing: 8) {
                            // Proteínas
                            VStack {
                                ZStack {
                                    Circle()
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 3)
                                    Circle()
                                        .trim(from: 0.0, to: CGFloat(progressProtein))
                                        .stroke(Color.init(red: 215/255, green: 105/255, blue: 119/255), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                        .rotationEffect(.degrees(-90))
                                        .animation(.easeInOut, value: 0)
                                    
                                    if let uiLogoProt = UIImage(contentsOfFile: logoProtein) {
                                        Image(uiImage: uiLogoProt)
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                            .padding(3)
                                            .background(Circle().fill(Color.white))
                                    }
                                }
                                .frame(width: 35, height: 35)
                                .padding(5)
                                if let calValue = Double(protein) {
                                        Text("\(abs(Int(calValue)))")
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(.white)
                                        
                                        Text(calValue < 0 ? "Proteínas\nmás" : "Proteínas\nrestantes")
                                            .font(.system(size: 8, weight: .light))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    }
//                                Text(protein)
//                                    .font(.system(size: 10, weight: .bold))
//                                    .foregroundColor(.white)
//                                Text("Proteínas\nrestantes")
//                                    .font(.system(size: 8, weight: .light))
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.white)
                            }
                            
                            // Carbohidratos
                            VStack {
                                ZStack {
                                    Circle()
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 3)
                                    Circle()
                                        .trim(from: 0.0, to: CGFloat((progressCarbs)))
                                        .stroke(Color.init(red: 224/255, green: 160/255, blue: 121/255), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                        .rotationEffect(.degrees(-90))
                                        .animation(.easeInOut, value: 0)
                                    
                                    if let uiLogoCar = UIImage(contentsOfFile: logoCarbs) {
                                        Image(uiImage: uiLogoCar)
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                            .padding(3)
                                            .background(Circle().fill(Color.white))
                                    }
                                }
                                .frame(width: 35, height: 35)
                                .padding(5)
                                
                                if let calValue = Double(carbohidrato) {
                                        Text("\(abs(Int(calValue)))")
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(.white)
                                        
                                        Text(calValue < 0 ? "Carbohidratos\nmás" : "Carbohidratos\nrestantes")
                                            .font(.system(size: 8, weight: .light))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    }
//                                Text(carbohidrato)
//                                    .font(.system(size: 10, weight: .bold))
//                                    .foregroundColor(.white)
//                                Text("Carbohidratos\nrestantes")
//                                    .font(.system(size: 8, weight: .light))
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.white)
                            }
                            
                            // Grasas
                            VStack {
                                ZStack {
                                    Circle()
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 3)
                                    Circle()
                                        .trim(from: 0.0, to: CGFloat(progressFats))
                                        .stroke(Color.init(red: 124/255, green: 165/255, blue: 225/255), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                        .rotationEffect(.degrees(-90))
                                        .animation(.easeInOut, value: 0)
                                    
                                    if let uiLogoGrasas = UIImage(contentsOfFile: logoGrasas) {
                                        Image(uiImage: uiLogoGrasas)
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                            .padding(3)
                                            .background(Circle().fill(Color.white))
                                    }
                                }
                                .frame(width: 35, height: 35)
                                .padding(5)
                                
                                if let calValue = Double(grasas) {
                                        Text("\(abs(Int(calValue)))")
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(.white)
                                        
                                        Text(calValue < 0 ? "Grasas\nmás" : "Grasas\nrestantes")
                                            .font(.system(size: 8, weight: .light))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    }
                                
//                                Text(grasas)
//                                    .font(.system(size: 10, weight: .bold))
//                                    .foregroundColor(.white)
//                                Text("Grasas\nrestantes")
//                                    .font(.system(size: 8, weight: .light))
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                }
                
            } compactLeading: {
                HStack(alignment: .center){
                    if let uiLogo = UIImage(contentsOfFile: logo)
                    {
                        Image(uiImage: uiLogo)
                            .resizable()
                            .frame(width: 15, height: 15)
                            .padding(4)
                        //                        .background(Circle().fill(Color.white))
                        
                    }
                    //                Text("M L").font(.system(size: 11, weight: .semibold))
                }
                
            } compactTrailing: {
                HStack(alignment: .center){
                    if let uiLogoCal = UIImage(contentsOfFile: logoCal)
                    {
                        Image(uiImage: uiLogoCal)
                            .resizable()
                            .frame(width: 15, height: 15)
                            .padding(4)
                            .background(Circle().fill(Color.white))
                        
                    }
                    if let calValue = Double(cal){
                        Text(calValue < 0 ? "+\(abs(Int(calValue)))" : cal)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                        
//                        Text(calValue < 0 ? "Calorías más" : "Calorías\nrestantes")
//                            .font(.system(size: 8, weight: .light))
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.center)
                    }
//                    Text(cal)
//                        .font(.system(size: 11, weight: .semibold))
//                        .foregroundColor(.white)
//                        .padding(.trailing, 4)
                }
                
            } minimal: {
                if let uiLogo = UIImage(contentsOfFile: logo)
                {
                    Image(uiImage: uiLogo)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                }
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
        
    }
}


extension LiveActivitiesAppAttributes {
    func prefixedKey(_ key: String) -> String {
        return "\(id)_\(key)"
    }
}
