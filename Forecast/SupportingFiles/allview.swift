//
//  allview.swift
//  Forecast
//
//  Created by 李青芬 on 2023/12/23.
//

import SwiftUI

struct allview: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Weather Forecast"
                          , systemImage: "thermometer.medium")
                }
            YouTubeView()
                .tabItem {
                    Label("Weather Forecast news"
                          , systemImage: "play.display")
                }
        }
        
    }
}

struct allView_Previews: PreviewProvider {
    static var previews: some View {
        allview()
    }
}
