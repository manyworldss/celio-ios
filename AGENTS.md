# Celio development guidance

Build cleanly and modularly, with clear separation of concerns. Do not bolt features onto unsuitable code. If a substantial refactor is needed, explain the reason and affected components before proceeding. Prefer small working slices over speculative architecture.

## Product boundaries
- Native iPhone app, iOS 26+, SwiftUI. Exchange is the central communication experience.
- V1 focuses on celiac disease. Initial languages: English, Spanish, Portuguese, French, German.
- Core communication is offline and local. No accounts, analytics, backend, or AI medical translations.
- Medical content and recordings require professional review. Draft/unavailable content must be explicit in every build, not only Debug. Never silently substitute another language.
- Staff answers are statements, never safety guarantees. Responses remain reversible and in memory.
- Follow system appearance, Reduce Motion, Reduce Transparency, and Increase Contrast. Staff text stays still on solid backgrounds.
- Audio is deliberate and uses reviewed recordings. Do not substitute speech synthesis for medical wording.

## Collaboration
Explain major changes briefly before implementation and describe verification afterward. Tie short practical teaching to the actual code. Do not claim device, accessibility, offline, or content validation that has not happened.

Keep checkpoints in Git. Preserve user changes. Do not push unreviewed work or destructively replace files without explaining the impact.
