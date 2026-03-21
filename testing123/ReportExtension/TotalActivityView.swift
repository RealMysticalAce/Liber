//
//  TotalActivityView.swift
//  ReportExtension
//
//  Created by Valeriy Yauseichyk on 20/03/2026.
//

import SwiftUI

struct TotalActivityView: View {
    let data: String

    var body: some View {
        ScrollView {
            Text(data)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .font(.system(.footnote, design: .monospaced))
            
        }
    }
}

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
#Preview {
    TotalActivityView(data: "1h 23m")
}
