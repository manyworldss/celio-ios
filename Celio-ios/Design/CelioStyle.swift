import SwiftUI

enum CelioColor {
    static let background = Color("bg")
    static let surface = Color("surface")
    static let ink = Color("ink")
    static let secondaryInk = Color("ink2")
    static let tertiaryInk = Color("ink3")
    static let line = Color("line")
    static let action = Color("action")
    static let onAction = Color("onAction")
    static let sage = Color("sage")
    static let sageInk = Color("sageInk")
    static let stamp = Color("stamp")
    static let fill = Color("fill")
    static let caution = Color("cautionBg")
    static let cautionInk = Color("cautionInk")
    static let staffBackground = Color("staffBg")
    static let staffInk = Color("staffInk")
    static let staffSecondary = Color("staffSub")
}

struct CelioPrimaryStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, minHeight: 56)
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
            .foregroundStyle(CelioColor.onAction)
            .background(CelioColor.action, in: Capsule())
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.975 : 1)
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(reduceMotion ? .easeOut(duration: 0.2) : .spring(duration: 0.3, bounce: 0.15),
                       value: configuration.isPressed)
    }
}

struct CelioGlassFrame: ViewModifier {
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    func body(content: Content) -> some View {
        if reduceTransparency {
            content.background(CelioColor.surface, in: .rect(cornerRadius: 32))
        } else {
            content.glassEffect(.regular, in: .rect(cornerRadius: 32))
        }
    }
}

struct CelioWordmark: View {
    var body: some View {
        // Temporary typographic wordmark until the supplied logo artwork is available.
        HStack(alignment: .top, spacing: 4) {
            Text("Celio").font(.system(.title2, design: .rounded).weight(.bold))
            Circle().fill(CelioColor.action).frame(width: 8, height: 8)
                .accessibilityHidden(true)
        }
        .foregroundStyle(CelioColor.ink)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Celio")
    }
}

struct OfflineLabel: View {
    var body: some View {
        Label("On this iPhone", systemImage: "iphone")
            .font(.caption.weight(.medium))
            .foregroundStyle(CelioColor.sageInk)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(CelioColor.sage, in: Capsule())
    }
}

struct DraftLabel: View {
    var body: some View {
        Label("Draft · design preview", systemImage: "pencil")
            .font(.caption.weight(.semibold))
            .foregroundStyle(CelioColor.cautionInk)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(CelioColor.caution, in: Capsule())
    }
}

struct ExchangePreview: View {
    let language: ExchangeLanguage

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("YOUR EXCHANGE")
                        .font(.caption2.weight(.semibold)).tracking(1.4)
                        .foregroundStyle(CelioColor.tertiaryInk)
                    Text("Celiac disease")
                        .font(.system(.largeTitle, design: .serif))
                        .foregroundStyle(CelioColor.ink)
                }
                Spacer(minLength: 8)
                Text(verbatim: language.stamp)
                    .font(.system(.title3, design: .serif).weight(.medium))
                    .foregroundStyle(CelioColor.stamp)
                    .frame(width: 56, height: 56)
                    .overlay(Circle().strokeBorder(CelioColor.stamp, lineWidth: 1.5))
                    .rotationEffect(.degrees(-12))
                    .accessibilityHidden(true)
            }
            Text("Your needs, clearly communicated. At the table or before you arrive.")
                .font(.body)
                .foregroundStyle(CelioColor.secondaryInk)
                .fixedSize(horizontal: false, vertical: true)
            Rectangle().fill(CelioColor.line).frame(height: 1)
            ViewThatFits(in: .horizontal) {
                HStack {
                    Text(verbatim: language.nativeName).font(.subheadline.weight(.medium))
                    Spacer()
                    DraftLabel()
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text(verbatim: language.nativeName).font(.subheadline.weight(.medium))
                    DraftLabel()
                }
            }
            .foregroundStyle(CelioColor.sageInk)
        }
        .padding(24)
        .background(CelioColor.surface, in: .rect(cornerRadius: 26))
        .overlay(RoundedRectangle(cornerRadius: 26).strokeBorder(CelioColor.line, lineWidth: 1))
        .padding(6)
        .modifier(CelioGlassFrame())
    }
}
