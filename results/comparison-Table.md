# Comparison Table

## Task Manager Study Snapshot

| Metric                | Human                                                                                                        | AI (GPT-5.4)                                                                                                    | AI (Claude Sonnet 4.6)                                                                                         | AI (Llama 3)                                                                                |
| --------------------- | ------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| Cyclomatic Complexity | Moderate. Complexity is spread across many small controller files.                                           | Moderate to moderately high. More branching from validation, filtering, sorting, and structured error handling. | Moderate. Similar endpoint logic to GPT-5.4 but with less abstraction.                                         | Low by size only. Simpler because major concerns are omitted.                               |
| Maintainability Index | Medium. Good separation, but weak API-test support lowers maintainability confidence.                        | High. Best abstraction quality, route organization, and error-handling consistency in the repo.                 | Medium to high. Modular, but more repetitive and less standardized than GPT-5.4.                               | Low. Prototype-level structure with weak auth and no testing support.                       |
| Code Duplication      | Medium. Many small files repeat controller patterns.                                                         | Low. Shared async and error utilities reduce repeated logic.                                                    | Medium. Repeated try/catch and controller patterns remain visible.                                             | Low in raw count, but only because the implementation is minimal.                           |
| Test Coverage         | Very low. Only a math utility test is committed; task-manager API routes are effectively untested.           | High relative to this repo. Auth, user, and task endpoints are covered with isolated in-memory DB setup.        | High relative to this repo. Broad route-level tests exist, though they depend on an external MongoDB instance. | None. No tests are present.                                                                 |
| Defect Density        | Medium. Reasonable design, but older patterns and low API-test coverage leave more latent risk.              | Low. Few visible defects and the best guardrails against regressions.                                           | Medium. Generally solid, but inconsistent error and validation paths raise risk.                               | High. Missing production-ready auth, weak authorization flow, and unsafe response patterns. |
| Security Findings     | Medium. More production-like than Llama 3, but route-level security behavior is not well verified.           | Low. Best security posture in this project sample thanks to stronger auth, validation, and test support.        | Medium. Auth and authorization exist, but consistency is weaker than GPT-5.4.                                  | High. Missing production-ready session handling and weak authorization boundaries.          |
| Change Effort         | Medium to high. Small focused files help, but low route-level test support makes changes slower to validate. | Low. Clear modules and a usable test harness make changes easiest here.                                         | Medium. Modular but repetitive, so consistency costs more during changes.                                      | Very high. Structural cleanup is needed before safe feature work.                           |

## Grocery App Study Snapshot

| Metric                | Human                                                                                                     | AI (GPT-5.4)                                                                                            | AI (Claude Sonnet 4.6)                                                                                     | AI (Llama 3)                                                                               |
| --------------------- | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| Cyclomatic Complexity | High overall. The app is spread across many generated screens, bindings, and model files.                 | Moderate. UI flow and controller complexity are present but better contained.                           | Moderate to high. Feature breadth and validation paths increase branch count.                              | Low by size only. Simplicity mostly reflects missing features and incomplete architecture. |
| Maintainability Index | Medium. Broad feature surface, but template-style structure and code volume raise maintenance cost.       | Medium to high. Best balance of modularity, size, and navigable structure among the grocery variants.   | Medium. Organized, but the largest code footprint and repeated patterns reduce maintainability confidence. | Low. Broken references and thin architecture make safe evolution difficult.                |
| Code Duplication      | High. Screen, binding, and model scaffolding repeat heavily.                                              | Low to medium. Shared widgets and tighter module structure reduce repeated code.                        | Medium. Repeated screen and controller patterns remain visible.                                            | Low in raw count, but mostly because the implementation is minimal.                        |
| Test Coverage         | None. No committed widget, unit, or integration tests were found.                                         | None. No committed tests were found.                                                                    | None. No committed tests were found.                                                                       | None. No tests are present.                                                                |
| Defect Density        | Medium. Large UI scaffold with weak verification and app-specific behavior depth.                         | Low to medium. Coherent structure, but still demo-grade in auth and persistence.                        | Medium. Stronger validation than peers, but hardcoded demo auth choices and larger surface add risk.       | High. Broken imports, thin controllers, and raw HTTP usage without visible safety checks.  |
| Security Findings     | Medium. Shared preferences and platform capability hooks exist, but secure auth/session behavior is thin. | Medium. Mock-data-first design avoids some exposure, but persistence still relies on plain preferences. | Medium to high. Input validation is stronger, but tokens and demo credentials are handled in plain form.   | High. No trustworthy auth boundary, little network safety, and incomplete app structure.   |
| Change Effort         | High. Large repeated UI surface makes consistent edits expensive.                                         | Medium. Clearest ownership boundaries make it the easiest grocery variant to extend.                    | Medium to high. Broad but heavier implementation raises coordination cost.                                 | Very high. Structural repair is needed before routine feature work.                        |

## Supporting Evidence

| Project      | Codebase          | Source Files | Source Lines | Test Files | Test Lines |
| ------------ | ----------------- | -----------: | -----------: | ---------: | ---------: |
| Task manager | Human             |           27 |          592 |          1 |         31 |
| Task manager | GPT-5.4           |           15 |          630 |          4 |        162 |
| Task manager | Claude Sonnet 4.6 |           14 |          632 |          3 |        555 |
| Task manager | Llama 3           |            3 |          120 |          0 |          0 |
| Grocery app  | Human             |          168 |         8239 |          0 |          0 |
| Grocery app  | GPT-5.4           |           65 |         3967 |          0 |          0 |
| Grocery app  | Claude Sonnet 4.6 |           69 |        10727 |          0 |          0 |
| Grocery app  | Llama 3           |           12 |          221 |          0 |          0 |

## Project Rankings

### Task Manager

1. GPT-5.4
2. Claude Sonnet 4.6
3. Human baseline
4. Llama 3

### Grocery App

1. GPT-5.4
2. Claude Sonnet 4.6
3. Human baseline
4. Llama 3

## Cross-Project Interpretation

The repository does not support a single human-versus-AI ranking. Instead, it shows that outcome quality is strongly model-sensitive and project-sensitive. GPT-5.4 is the most consistently strong implementation family across both projects, Claude Sonnet 4.6 is usually viable but less restrained, the human baselines are broader but not always easier to maintain, and Llama 3 remains prototype-level in both cases.

These rankings are qualitative rather than tool-generated because the repository does not yet contain complete committed SonarQube, ESLint, Jest coverage, `flutter analyze`, or `flutter test` outputs for all study variants.
