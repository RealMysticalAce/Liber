//
//  PermissionsView.swift
//  testing123
//
//  Created by Valeriy Yauseichyk on 19/03/2026.
//

import SwiftUI
import FamilyControls

struct PermissionsView: View {
    @StateObject var authorization = Authorization()
        var body: some View {
            if (authorization.authorizationStatus == .approved){
                DeviceActivityReportView()
            } else{
                VStack{
                    Text("Permissions")
                        .font(.title)
                        .bold(true)
                    Spacer()
                    Text("For this app to function, we require to access your screen time data. This access can be revoked at any time.")
                    Spacer()
                    Button("Request Acess"){
                        Task{
                            await authorization.requestAuthorization()
                        }
                    }
                    .padding(25)
                    .buttonStyle(.borderedProminent)
                    .shadow(radius: 10)
                }
                .padding(50)
        }
    }
}

#Preview {
    PermissionsView()
}
