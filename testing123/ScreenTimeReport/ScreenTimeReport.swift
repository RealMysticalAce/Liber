//
//  ScreenTimeReport.swift
//  ScreenTimeReport
//
//  Created by Valeriy Yauseichyk on 08/03/2026.
//

import DeviceActivity
import ExtensionKit
import SwiftUI

@MainActor
struct ScreenTimeReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}

