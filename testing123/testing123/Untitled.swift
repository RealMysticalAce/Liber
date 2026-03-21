import FamilyControls
import SwiftUI // Or UIKit
internal import Combine
import ManagedSettings

class AuthorizationManager: ObservableObject {
    @Published var authorizationStatus: FamilyControls.AuthorizationStatus = .notDetermined
    init() {
        // Check initial status if needed when the app starts
        Task {
            await checkAuthorization()
        }
    }
    func requestAuthorization() async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual) // Use .individual for non-Family Sharing apps
            self.authorizationStatus = AuthorizationCenter.shared.authorizationStatus
        } catch {
            // Handle errors appropriately (e.g., logging, showing an alert)
            print("Failed to request authorization: \(error)")
            self.authorizationStatus = .denied // Or handle specific errors
        }
    }
    func checkAuthorization() async {
         self.authorizationStatus = AuthorizationCenter.shared.authorizationStatus
    }
}
// Example Usage in a SwiftUI View
struct ContentView: View {
    @StateObject var authManager = AuthorizationManager()
    @State private var showProfileEditor = false
    @State private var showAppBlocker = false
    @State private var lastSelection: FamilyActivitySelection? = nil

    var body: some View {
        NavigationStack {
            VStack {
                Text("Authorization Status: \(String(describing: authManager.authorizationStatus))")
                if authManager.authorizationStatus == .notDetermined {
                    Button("Request Authorization") {
                        Task { await authManager.requestAuthorization() }
                    }
                } else if authManager.authorizationStatus == .approved {
                    Text("Authorization Granted!")
                    Button("Open Profile Editor") { showProfileEditor = true }
                    if let selection = lastSelection {
                        Divider().padding(.vertical, 8)
                        Text("Last selection: \(selection.applicationTokens.count) apps, \(selection.categoryTokens.count) categories, \(selection.webDomainTokens.count) websites")
                        Button("Open App Blocker") { showAppBlocker = true }
                    }
                } else {
                    Text("Authorization Denied or Restricted. Please enable in Settings.")
                    Button("Request Authorization Again") {
                        Task { await authManager.requestAuthorization() }
                    }
                }
            }
            .padding()
            .onChange(of: authManager.authorizationStatus) { _, newValue in
                if newValue == .approved {
                    showProfileEditor = true
                }
            }
            // Present the profile editor and capture the selection via a callback
            .sheet(isPresented: $showProfileEditor) {
                ProfileEditorView { selection in
                    // store the selection and then show the AppBlocker UI
                    self.lastSelection = selection
                    self.showAppBlocker = true
                }
            }
            // Present the AppBlocker UI when needed
            .sheet(isPresented: $showAppBlocker) {
                if let selection = lastSelection {
                    AppBlockerView(selection: selection)
                } else {
                    Text("No selection available")
                        .padding()
                }
            }
            .navigationTitle("Access")
        }
    }
}

#Preview {
    ContentView()
}

struct ProfileEditorView: View {
    // Callback to deliver the user's selection back to the caller
    var onDone: (FamilyActivitySelection) -> Void

    // State to store the user's selection
    @State private var activitySelection = FamilyActivitySelection()
    // State to control the presentation of the picker
    @State private var isPickerPresented = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Selected \(activitySelection.applicationTokens.count) apps, \(activitySelection.categoryTokens.count) categories, \(activitySelection.webDomainTokens.count) websites")
            HStack {
                Button("Select Apps & Websites") { isPickerPresented = true }
                Button("Done") {
                    // hand the selection back and let the presenter decide what to do next
                    onDone(activitySelection)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .familyActivityPicker(
            isPresented: $isPickerPresented,
            selection: $activitySelection
        )
        .onChange(of: activitySelection) { _, newSelection in
            // Handle the updated selection - maybe save it?
            print("Selection Updated!")
            saveSelection(newSelection)
        }
        .padding()
        .navigationTitle("Profile Editor")
    }

    func saveSelection(_ selection: FamilyActivitySelection) {
        print("Saving selection...")
    }
}

struct AppBlockerView: View {
    let selection: FamilyActivitySelection
    private let util = AppBlockerUtil()

    @State private var statusMessage: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("App Blocker")
                .font(.title2)
            Text("Selection: \(selection.applicationTokens.count) apps, \(selection.categoryTokens.count) categories, \(selection.webDomainTokens.count) websites")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Button("Apply Restrictions") {
                    util.applyRestrictions(selection: selection)
                    statusMessage = "Restrictions applied."
                }
                .buttonStyle(.borderedProminent)

                Button("Remove Restrictions") {
                    util.removeRestrictions()
                    statusMessage = "Restrictions removed."
                }
                .buttonStyle(.bordered)
            }

            if !statusMessage.isEmpty {
                Text(statusMessage)
                    .foregroundStyle(.green)
            }
        }
        .padding()
    }
}

class AppBlockerUtil { // Simplified from the provided code
    let store = ManagedSettingsStore(named: ManagedSettingsStore.Name("yourAppRestrictionsName")) // Use a unique name
    func applyRestrictions(selection: FamilyActivitySelection) {
        print("Applying restrictions...")
        // Extract tokens from the selection
        let applicationTokens = selection.applicationTokens
        let categoryTokens = selection.categoryTokens
        let webTokens = selection.webDomainTokens
        // Apply tokens to the shield configuration
        store.shield.applications = applicationTokens.isEmpty ? nil : applicationTokens
        store.shield.applicationCategories = categoryTokens.isEmpty ? nil : .specific(categoryTokens)
        store.shield.webDomains = webTokens.isEmpty ? nil : webTokens
        print("Restrictions applied to ManagedSettingsStore.")
        // NOTE: This only defines the rules. DeviceActivity makes them active.
    }
    func removeRestrictions() {
        print("Removing restrictions...")
        // Clear the shield configuration
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        store.shield.webDomains = nil
        print("Restrictions removed from ManagedSettingsStore.")
        // NOTE: Also need to stop DeviceActivity monitoring.
    }
}

