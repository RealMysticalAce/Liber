import SwiftUI

struct ScreenTimeView: View {
    @State private var jsonText: String = ""

    var body: some View {
        ScrollView {
            Text(jsonText)
                .font(.system(.footnote, design: .monospaced))
                .padding()
        }
        .onAppear {
            jsonText = loadJSONFromSharedContainer()
        }
    }

    func loadJSONFromSharedContainer() -> String {
        guard let containerURL = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "MysticalAce.test1"
        ) else { return "No container" }

        let fileURL = containerURL.appendingPathComponent("screentime.json")

        guard let data = try? Data(contentsOf: fileURL),
              let jsonString = String(data: data, encoding: .utf8) else {
            return "No data"
        }
        return jsonString
    }
}

#Preview {
    ScreenTimeView()
}
