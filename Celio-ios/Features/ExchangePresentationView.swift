import SwiftUI

/// A solid, still reading surface. Reviewed dietary content will replace the
/// explicit placeholders; the selected language never falls back to English.
struct ExchangePresentationView: View {
    let language: ExchangeLanguage
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    Text(verbatim: language.nativeName)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(CelioColor.staffSecondary)
                    Text(verbatim: language.prototypeHeading)
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                    Text(verbatim: language.draftNotice)
                        .font(.title2)
                        .fixedSize(horizontal: false, vertical: true)
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Draft layout only", systemImage: "exclamationmark.triangle")
                            .font(.headline)
                        Text("Reviewed dietary requirements and cross-contact guidance will appear here. This preview must not be used to communicate a dietary requirement.")
                            .font(.body)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(CelioColor.cautionInk)
                    .background(CelioColor.caution, in: .rect(cornerRadius: 18))
                    Text(verbatim: language.thanks)
                        .font(.title3)
                        .foregroundStyle(CelioColor.staffSecondary)
                    Text("You can hold the phone or choose to hand it over.")
                        .font(.body)
                        .foregroundStyle(CelioColor.staffSecondary)
                }
                .padding(24)
            }
            .background(CelioColor.staffBackground)
            .foregroundStyle(CelioColor.staffInk)
            .navigationTitle("Exchange")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close", systemImage: "xmark") { dismiss() }
                        .labelStyle(.iconOnly)
                        .frame(minWidth: 44, minHeight: 44)
                        .accessibilityLabel("Close Exchange")
                }
            }
            .toolbarBackground(CelioColor.staffBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview("Exchange · Spanish") {
    ExchangePresentationView(language: .spanish)
}
