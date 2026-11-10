import Foundation

/// Language metadata only. Medical wording is supplied separately after review.
enum ExchangeLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case spanish = "es"
    case portuguese = "pt"
    case french = "fr"
    case german = "de"

    var id: String { rawValue }

    var nativeName: String {
        switch self {
        case .english: "English"
        case .spanish: "Español"
        case .portuguese: "Português"
        case .french: "Français"
        case .german: "Deutsch"
        }
    }

    var englishName: String {
        switch self {
        case .english: "English"
        case .spanish: "Spanish"
        case .portuguese: "Portuguese"
        case .french: "French"
        case .german: "German"
        }
    }

    var stamp: String { rawValue.uppercased() }

    var greeting: String {
        switch self {
        case .english: "Enjoy the moment."
        case .spanish: "Buen provecho."
        case .portuguese: "Bom apetite."
        case .french: "Bon appétit."
        case .german: "Guten Appetit."
        }
    }

    var prototypeHeading: String {
        switch self {
        case .english: "Let’s make understanding easier."
        case .spanish: "Entendernos puede ser más fácil."
        case .portuguese: "Vamos facilitar a comunicação."
        case .french: "Pour mieux se comprendre."
        case .german: "Damit wir uns besser verstehen."
        }
    }

    var draftNotice: String {
        switch self {
        case .english: "Design prototype. Dietary information is not available yet."
        case .spanish: "Prototipo de diseño. La información alimentaria aún no está disponible."
        case .portuguese: "Protótipo de design. As informações alimentares ainda não estão disponíveis."
        case .french: "Prototype de présentation. Les informations alimentaires ne sont pas encore disponibles."
        case .german: "Designprototyp. Informationen zu Ernährungsanforderungen sind noch nicht verfügbar."
        }
    }

    var thanks: String {
        switch self {
        case .english: "Thank you for your help."
        case .spanish: "Gracias por su ayuda."
        case .portuguese: "Obrigado pela ajuda."
        case .french: "Merci pour votre aide."
        case .german: "Vielen Dank für Ihre Hilfe."
        }
    }
}
