//
//  Logic.swift
//  testing123
//
//  Created by Valeriy Yauseichyk on 19/03/2026.
//
import FamilyControls
import SwiftUI
internal import Combine
import ManagedSettings

class Authorization: ObservableObject {
    @Published var authorizationStatus: FamilyControls.AuthorizationStatus = .notDetermined
    init() {
        // Check initial status if needed when the app starts
        Task {
            await checkAuthorization()
        }
    }
    func requestAuthorization() async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            self.authorizationStatus = AuthorizationCenter.shared.authorizationStatus
        } catch {
            print("Failed to request authorization: \(error)")
            self.authorizationStatus = .denied
        }
    }
    func checkAuthorization() async {
         self.authorizationStatus = AuthorizationCenter.shared.authorizationStatus
    }
}
