//
//  TotalActivityReport.swift
//  ReportExtension
//
//  Created by Valeriy Yauseichyk on 20/03/2026.
//

import DeviceActivity
import ExtensionKit
import SwiftUI

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let totalActivity = Self("Total Activity")
}

struct TotalActivityReport: DeviceActivityReportScene {
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    let content: (String) -> TotalActivityView
    
    func makeConfiguration(
        representing data: DeviceActivityResults<DeviceActivityData>
    ) async -> String {
        
        var debugText = ""

        for await activityData in data {
            debugText += "📊 New ActivityData\n"
            
            for await segment in activityData.activitySegments {
                debugText += "🕒 Segment: \(segment.dateInterval)\n"
                debugText += "Total Duration: \(segment.totalActivityDuration)\n"
                
                // ❗ categories are async
                for await category in segment.categories {
                    debugText += "📂 Category Duration: \(category.totalActivityDuration)\n"
                    
                    // ✅ applications are normal
                    for await app in category.applications {
                        debugText += "📱 App:\n"
                        debugText += "   Token: \(app.application)\n"
                        debugText += "   Duration: \(app.totalActivityDuration)\n"
                        debugText += "   Pickups: \(app.numberOfPickups)\n"
                    }
                }
                
                debugText += "\n----------------------\n"
            }
        }

        return debugText.isEmpty ? "No activity data" : debugText
    }
}
