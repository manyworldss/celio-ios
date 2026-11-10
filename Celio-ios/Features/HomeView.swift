import SwiftUI

struct HomeView: View {
    @Binding var languageID: String
    @Binding var hapticsEnabled: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var activeSheet: HomeSheet?
    @State private var isPresenting = false

    private var language: ExchangeLanguage? { ExchangeLanguage(rawValue: languageID) }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    HomeHeader { activeSheet = .settings }
                    if let language {
                        HomeGreeting(language: language)
                            .id(language.id)
                            .transition(.opacity)
                        Button { isPresenting = true } label: {
                            ExchangePreview(language: language)
                        }
                        .buttonStyle(.plain)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("Exchange preview, celiac disease, \(language.nativeName)")
                        .accessibilityHint("Opens the full-screen design preview")
                        Button { isPresenting = true } label: {
                            HStack {
                                Text("Start Exchange")
                                Spacer()
                                Image(systemName: "arrow.up.right")
                            }
                        }
                        .buttonStyle(CelioPrimaryStyle())
                    } else {
                        ContentUnavailableView("Choose a language",
                                               systemImage: "character.bubble",
                                               description: Text("Your saved language is unavailable. Select one to continue."))
                    }
                    Button { activeSheet = .language } label: {
                        HomeRow(title: "Exchange language",
                                subtitle: language?.nativeName ?? "Choose a language",
                                symbol: "character.bubble")
                    }
                    .buttonStyle(.plain)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("AT YOUR PACE")
                            .font(.caption2.weight(.semibold)).tracking(1.4)
                        Text("Hold it up. Keep it in your hands.\nMake room for a conversation.")
                            .font(.system(.title3, design: .serif))
                    }
                    .foregroundStyle(CelioColor.secondaryInk)
                    .padding(.top, 4)
                    Text("Opening-screen prototype · Dietary content, questions, sharing and recorded audio are still to come.")
                        .font(.footnote)
                        .foregroundStyle(CelioColor.tertiaryInk)
                }
                .padding(20)
                .padding(.bottom, 20)
            }
            .background {
                CelioColor.background.ignoresSafeArea()
                RadialGradient(colors: [CelioColor.sage.opacity(0.7), .clear],
                               center: .center, startRadius: 20, endRadius: 330)
                    .ignoresSafeArea()
            }
            .toolbar(.hidden, for: .navigationBar)
            .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .language:
                    LanguagePickerView(selection: $languageID)
                case .settings:
                    OpeningSettingsView(hapticsEnabled: $hapticsEnabled)
                }
            }
            .fullScreenCover(isPresented: $isPresenting) {
                if let language {
                    ExchangePresentationView(language: language)
                }
            }
        }
        .foregroundStyle(CelioColor.ink)
        .tint(CelioColor.action)
        .animation(.easeInOut(duration: reduceMotion ? 0.2 : 0.35), value: languageID)
        .sensoryFeedback(.selection, trigger: languageID) { _, _ in hapticsEnabled }
        .sensoryFeedback(.impact(weight: .light), trigger: isPresenting) { _, newValue in
            hapticsEnabled && newValue
        }
    }
}

private enum HomeSheet: String, Identifiable {
    case language, settings
    var id: String { rawValue }
}

private struct HomeHeader: View {
    let onSettings: () -> Void

    var body: some View {
        HStack(alignment: .center) {
            CelioWordmark()
            Spacer()
            Button(action: onSettings) {
                Image(systemName: "gearshape")
                    .frame(minWidth: 44, minHeight: 44)
            }
            .buttonStyle(.glass)
            .accessibilityLabel("Settings")
        }
    }
}

private struct HomeGreeting: View {
    let language: ExchangeLanguage

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            OfflineLabel()
            Text(verbatim: language.greeting)
                .font(.system(.largeTitle, design: .serif).italic())
                .fixedSize(horizontal: false, vertical: true)
            Text("Less explaining. More experiencing.")
                .font(.subheadline)
                .foregroundStyle(CelioColor.secondaryInk)
        }
        .padding(.top, 12)
    }
}

private struct HomeRow: View {
    let title: LocalizedStringKey
    let subtitle: String
    let symbol: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: symbol)
                .frame(width: 40, height: 40)
                .background(CelioColor.fill, in: .rect(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.headline)
                Text(verbatim: subtitle)
                    .font(.subheadline).foregroundStyle(CelioColor.secondaryInk)
            }
            Spacer(minLength: 4)
            Image(systemName: "chevron.right").font(.caption.weight(.semibold))
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
        .background(CelioColor.surface, in: .rect(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(CelioColor.line, lineWidth: 1))
        .contentShape(Rectangle())
    }
}

#Preview("Home") {
    HomeView(languageID: .constant("es"), hapticsEnabled: .constant(true))
}

#Preview("Home · dark") {
    HomeView(languageID: .constant("pt"), hapticsEnabled: .constant(true))
        .preferredColorScheme(.dark)
}

#Preview("Home · largest text") {
    HomeView(languageID: .constant("de"), hapticsEnabled: .constant(false))
        .environment(\.dynamicTypeSize, .accessibility5)
}
