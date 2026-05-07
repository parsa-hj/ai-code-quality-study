# Grocery App Raw Analysis Snapshot

## Scope

This snapshot compares the four grocery-app implementations in the repository against the study metrics defined in `research/metrics.md`:

- Cyclomatic Complexity
- Maintainability Index
- Code Duplication
- Test Coverage
- Defect Density
- Security Findings
- Change Effort

The values below are qualitative unless otherwise noted. No committed `flutter test` outputs, `flutter analyze` reports, or coverage artifacts were present for the grocery-app implementations, so the analysis is based on direct code inspection plus repository counts.

## Repository Snapshot

| Codebase          | Dart Source Files | Dart Source Lines | Test Files | Test Lines | Notes                                                                                                 |
| ----------------- | ----------------: | ----------------: | ---------: | ---------: | ----------------------------------------------------------------------------------------------------- |
| Human baseline    |               168 |              8239 |          0 |          0 | Large template-style Flutter app with many generated screens, bindings, and widget fragments          |
| GPT-5.4           |                65 |              3967 |          0 |          0 | Modular Flutter app with mock repositories, reusable widgets, and compact feature implementation      |
| Claude Sonnet 4.6 |                69 |             10727 |          0 |          0 | Feature-rich Flutter app with validation helpers, session service, and the heaviest code footprint    |
| Llama 3           |                12 |               221 |          0 |          0 | Prototype-level Flutter shell with incomplete architecture, weak imports, and minimal product support |

## Metric Evidence

### Cyclomatic Complexity

| Codebase          | Evidence                                                                                                                                     |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | Complexity is high in aggregate because the app spreads behavior across many generated screen, controller, model, and binding files.         |
| GPT-5.4           | Moderate complexity. Controllers and repositories handle real UI state transitions, but the codebase stays compact and structurally regular. |
| Claude Sonnet 4.6 | Moderate to high complexity. It supports many flows and validation paths, but does so with a larger service and controller surface.          |
| Llama 3           | Low by size only. The low branch count reflects missing features and incomplete architecture rather than better design.                      |

### Maintainability Index

| Codebase          | Evidence                                                                                                                                                   |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | Medium. The app is broad and recognizable as a full UI product, but generated structure and large file count make changes expensive to reason about.       |
| GPT-5.4           | Medium to high. It has the clearest module boundaries among the grocery variants and keeps repositories, controllers, and widgets relatively well aligned. |
| Claude Sonnet 4.6 | Medium. Validation and service layers are present, but the very large code footprint and repetition reduce maintainability confidence.                     |
| Llama 3           | Low. Missing abstractions, broken imports, and thin functionality make safe extension difficult.                                                           |

### Code Duplication

| Codebase          | Evidence                                                                                                                      |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | High. The template-style screen, binding, and model pattern repeats heavily across the app.                                   |
| GPT-5.4           | Low to medium. Shared widgets and a tighter structure reduce duplication compared with the larger grocery variants.           |
| Claude Sonnet 4.6 | Medium. The architecture is organized, but the larger screen and controller surface repeats patterns more often than GPT-5.4. |
| Llama 3           | Low in raw count, but that is not meaningful because the implementation omits most of the expected grocery-app behavior.      |

### Test Coverage

| Codebase          | Evidence                                                                                                                                 |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | No committed widget, unit, or integration tests were found.                                                                              |
| GPT-5.4           | No committed tests were found despite a modular structure that would support them.                                                       |
| Claude Sonnet 4.6 | No committed tests were found. The app includes validation and service layers, but there is no automated verification in the repository. |
| Llama 3           | No tests are present.                                                                                                                    |

### Defect Density

| Codebase          | Evidence                                                                                                                                                                                           |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | Medium. The codebase is large and mostly UI-oriented; visible defects are less about catastrophic logic failure and more about generated bloat, weak app-specific behavior, and low test evidence. |
| GPT-5.4           | Low to medium. The app is coherent, but auth is still placeholder-only and some persistence concerns remain demo-grade rather than production-grade.                                               |
| Claude Sonnet 4.6 | Medium. The app is feature-rich and validates inputs better, but hardcoded mock credentials and plain token persistence leave visible robustness gaps.                                             |
| Llama 3           | High. Broken imports, thin architecture, no error handling around HTTP calls, and extremely limited functionality indicate prototype-level quality.                                                |

### Security Findings

| Codebase          | Evidence                                                                                                                                                                                                          |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | Medium. Shared preferences are present and an API client scaffold exists, but there is little evidence of a secure auth/session design. The app requests broader platform capabilities than a pure mock UI needs. |
| GPT-5.4           | Medium. Credentials and session-related state are demo-grade, and local persistence uses `shared_preferences` rather than secure storage. The app avoids obvious network exposure by using mock data.             |
| Claude Sonnet 4.6 | Medium to high. Validation is stronger than the other grocery variants, but demo credentials and auth tokens are persisted in plain shared preferences, which would be unacceptable in production.                |
| Llama 3           | High. Raw HTTP calls lack visible auth, response validation, or error handling, and the incomplete architecture does not establish trustworthy security boundaries.                                               |

### Change Effort

| Codebase          | Evidence                                                                                                                                       |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | High. The screen-heavy generated structure localizes some UI edits but creates a large amount of repeated surface area to update consistently. |
| GPT-5.4           | Medium. It is the easiest grocery variant to change because responsibilities are more clearly grouped and the code size is restrained.         |
| Claude Sonnet 4.6 | Medium to high. The feature set is broad, but its size and repeated patterns make consistency work more expensive than in GPT-5.4.             |
| Llama 3           | Very high. Structural cleanup would be required before routine feature work could be done safely.                                              |

## Qualitative Metric Ranking

| Metric                | Human baseline | GPT-5.4        | Claude Sonnet 4.6 | Llama 3                     |
| --------------------- | -------------- | -------------- | ----------------- | --------------------------- |
| Cyclomatic Complexity | High overall   | Moderate       | Moderate to high  | Low, but feature-incomplete |
| Maintainability Index | Medium         | Medium to high | Medium            | Low                         |
| Code Duplication      | High           | Low to medium  | Medium            | Low by size only            |
| Test Coverage         | None           | None           | None              | None                        |
| Defect Density        | Medium         | Low to medium  | Medium            | High                        |
| Security Findings     | Medium         | Medium         | Medium to high    | High                        |
| Change Effort         | High           | Medium         | Medium to high    | Very high                   |

## Important Caveat

This file is an inspection-based evidence summary, not a replacement for tool-generated metric outputs. If the study later runs `flutter analyze`, `flutter test`, coverage collection, or mobile security scanners in a controlled environment, those numeric outputs should supersede the qualitative labels here while preserving the same comparative interpretation.
