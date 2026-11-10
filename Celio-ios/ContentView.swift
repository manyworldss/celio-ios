import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedWelcome") private var hasCompletedWelcome = false
    @AppStorage("exchangeLanguage") private var languageID = ExchangeLanguage.english.rawValue
    @AppStorage("hapticsEnabled") private var hapticsEnabled = true
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Group {
            if hasCompletedWelcome {
                HomeView(languageID: $languageID, hapticsEnabled: $hapticsEnabled)
                    .transition(.opacity)
            } else {
                WelcomeView {
                    withAnimation(.easeInOut(duration: reduceMotion ? 0.2 : 0.35)) {
                        hasCompletedWelcome = true
                    }
                }
                .transition(.opacity)
            }
        }
        .tint(CelioColor.action)
        .sensoryFeedback(.selection, trigger: hasCompletedWelcome) { _, _ in hapticsEnabled }
    }
}

#Preview {
    ContentView()
}
