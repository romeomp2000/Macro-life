//
//  HomeWidgetBundle.swift
//  HomeWidget
//
//  Created by Osvaldo on 30/12/24.
//

import WidgetKit
import SwiftUI

@main
struct HomeWidgetBundle: WidgetBundle {
    var body: some Widget {
        HomeWidget()
        HomeWidgetControl()
        HomeWidgetLiveActivity()
    }
}
