//
//  ReportExtension.swift
//  ReportExtension
//
//  Created by Valeriy Yauseichyk on 20/03/2026.
//

import DeviceActivity
import ExtensionKit
import SwiftUI

@main
struct ReportExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(data: totalActivity)
        }
        // Add more reports here...
    }
}
