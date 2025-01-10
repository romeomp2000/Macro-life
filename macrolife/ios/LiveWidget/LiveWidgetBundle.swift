//
//  LiveWidgetBundle.swift
//  LiveWidget
//
//  Created by Osvaldo on 07/01/25.
//

import WidgetKit
import SwiftUI

@main
struct LiveWidgetBundle: WidgetBundle {
    var body: some Widget {
        LiveWidget()
        LiveWidgetControl()
        LiveWidgetLiveActivity()
    }
}
