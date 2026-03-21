//
//  WelcomeView.swift
//  testing123
//
//  Created by Valeriy Yauseichyk on 19/03/2026.
//

import SwiftUI

struct WelcomeView: View {
    @State var showPermissions = false
    var body: some View {
        if showPermissions {
            PermissionsView()
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
        } else{
            
            Button("Start"){
                Task{
                    showPermissions.toggle()
                }
            }
            .buttonStyle(BorderedButtonStyle())
    }
        }
            
    }

#Preview {
    WelcomeView()
}
