//
//  MainInAppView.swift
//  testing123
//
//  Created by Valeriy Yauseichyk on 19/03/2026.
//

import SwiftUI

struct MainInAppView: View {
    var body: some View {
        TabView{
            Tab("Home", systemImage: "house") {
                    HomePageView()
                }
            Tab("Stats", systemImage: "chart.bar.xaxis.ascending.badge.clock"){
                StatisticsView()
            }
            Tab("Compare",systemImage: "person.2.fill"){
                CompareView()
            }
            Tab("Block", systemImage: "xmark.circle"){
                BlockingView()
            }
            Tab("Settings", systemImage: "gearshape") {
                SettingsView()
            }
        }
    }
}

#Preview {
    MainInAppView()
}
