# Opening screens checkpoint

## Implemented
Welcome → Home → full-screen Exchange layout, language selection, and Settings.
iPhone / iOS 26.0 minimum; Swift 6 language mode.
Five locally compiled language metadata sets. Only nonmedical prototype messages are present. All dietary content remains unavailable pending review.
Light, dark, and high-contrast palette assets. Glass frame and settings control; solid primary action and staff surface. Optional sensory feedback. Reduced-motion-aware press feedback and crossfades.
UserDefaults stores only welcome completion, language identifier, and haptics preference. Unknown language identifiers require an explicit selection.

## Deliberate scope
No questionnaire, audio, sharing, brightness changes, idle-timer changes, widget, or Wallet yet. No logo source was supplied; the wordmark is temporary system typography. No automatic cycling or floating animation. The launch experience uses one welcome page rather than four setup steps.
No claims of reviewed wording, medical accuracy, or readiness for meal decisions. Portuguese region must be chosen with the content reviewer.

## Manual checks
- Get started, select each of the five languages, open and close Exchange.
- Relaunch: language and haptics preference should persist; welcome should not repeat.
- Verify light/dark, Increase Contrast, Reduce Transparency, Reduce Motion, and largest Dynamic Type.
- Check VoiceOver order and labels. Check haptics on physical iPhone.
- Launch and navigate in airplane mode on physical iPhone.

## Architecture
ContentView owns persistent preferences and first-run routing. HomeView owns temporary sheet/presentation state. ExchangeLanguage holds language metadata, not clinical content. CelioStyle holds shared visual components; Assets holds adaptive colors. Feature views receive values or bindings, without a global state object.

## Verification so far
- Xcode BuildProject succeeded for iPhone 17 / iOS 26.3.1 with no reported errors.
- Preview renderer timed out; this is not a successful visual check.
- Calculated contrast for primary, secondary, tertiary, action, caution, sage, and staff text pairs passes 4.5:1 in both appearances. Light ink3 adjusted from #62756F (4.49:1 on ivory) to #60736D (4.62:1). These calculations do not replace on-device accessibility inspection.
- Simulator interaction verification was blocked: install/run and capture reported a 120-second boot timeout (last state Booted). One install retry also failed. The session was closed. Navigation, persistence, VoiceOver, haptics, and rendered layouts remain manually unverified.
- Welcome primary action stays in a bottom safe-area inset. Added an English-source String Catalog for UI string extraction; staff-facing medical content remains separate and unavailable.
