import SwiftUI

struct WelcomeView: View {
    let onContinue: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                CelioWordmark().padding(.top, 16)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Less explaining.")
                        .font(.system(.largeTitle, design: .serif))
                    Text("More experiencing.")
                        .font(.system(.largeTitle, design: .serif).italic())
                        .foregroundStyle(CelioColor.action)
                }
                .accessibilityElement(children: .combine)
                Text("A little more understanding.\nWherever you’re eating.")
                    .font(.title3)
                    .foregroundStyle(CelioColor.secondaryInk)
                ExchangePreview(language: .english)
                    .accessibilityElement(children: .combine)
                VStack(alignment: .leading, spacing: 16) {
                    Label("Show your needs at a glance", systemImage: "text.alignleft")
                    Label("Choose from five languages", systemImage: "character.bubble")
                    Label("Keep control of your phone", systemImage: "hand.raised")
                }
                .font(.subheadline)
                .foregroundStyle(CelioColor.secondaryInk)
                Text("An early design preview for celiac communication. Dietary wording and audio are awaiting review.")
                    .font(.footnote)
                    .foregroundStyle(CelioColor.tertiaryInk)
            }
            .padding(24)
        }
        .safeAreaInset(edge: .bottom) {
            WelcomeAction(onContinue: onContinue)
        }
        .background(CelioColor.background)
        .foregroundStyle(CelioColor.ink)
    }
}

private struct WelcomeAction: View {
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Button("Get started", action: onContinue)
                .buttonStyle(CelioPrimaryStyle())
            Label("No account. Preferences stay on this iPhone.", systemImage: "lock")
                .font(.footnote)
                .foregroundStyle(CelioColor.secondaryInk)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(CelioColor.background)
    }
}

#Preview("Welcome") {
    WelcomeView(onContinue: {})
}
