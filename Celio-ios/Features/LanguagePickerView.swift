import SwiftUI

struct LanguagePickerView: View {
    @Binding var selection: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(ExchangeLanguage.allCases) { language in
                        Button {
                            selection = language.rawValue
                            dismiss()
                        } label: {
                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(verbatim: language.nativeName).font(.headline)
                                    Text(verbatim: language.englishName)
                                        .font(.subheadline)
                                        .foregroundStyle(CelioColor.secondaryInk)
                                }
                                Spacer()
                                if selection == language.rawValue {
                                    Image(systemName: "checkmark")
                                        .accessibilityHidden(true)
                                }
                            }
                            .frame(minHeight: 56)
                            .foregroundStyle(CelioColor.ink)
                            .contentShape(Rectangle())
                        }
                        .accessibilityAddTraits(selection == language.rawValue ? .isSelected : [])
                        .listRowBackground(CelioColor.surface)
                    }
                } footer: {
                    Text("All five languages are included in this design preview. Dietary translations and Portuguese regional wording still need review. Your choice stays on this iPhone.")
                }
            }
            .scrollContentBackground(.hidden)
            .background(CelioColor.background)
            .navigationTitle("Exchange language")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .tint(CelioColor.action)
        .presentationDetents([.large])
    }
}

struct OpeningSettingsView: View {
    @Binding var hapticsEnabled: Bool
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Your Exchange") {
                    LabeledContent("Dietary need", value: "Celiac disease")
                    LabeledContent("Content status", value: "Design preview")
                }
                Section("Interaction") {
                    Toggle("Subtle haptics", isOn: $hapticsEnabled)
                    Text("Sound stays off. Reviewed recordings will be added in a later build.")
                        .font(.footnote).foregroundStyle(.secondary)
                }
                Section("Privacy") {
                    Text("No account. No network requests. Only your language, welcome completion and haptics preference are saved locally.")
                }
                Section("About this preview") {
                    Text("The opening screens are ready to explore. This build does not contain reviewed dietary statements and is not ready for use in a meal decision.")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .tint(CelioColor.action)
    }
}
