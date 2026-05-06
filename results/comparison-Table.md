# Comparison Table

## Task Manager Study Snapshot

| Metric                | Human                                                                                                        | AI (GPT-5.4)                                                                                                    | AI (Claude Sonnet 4.6)                                                                                         | AI (Llama 3)                                                                                |
| --------------------- | ------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| Cyclomatic Complexity | Moderate. Complexity is spread across many small controller files.                                           | Moderate to moderately high. More branching from validation, filtering, sorting, and structured error handling. | Moderate. Similar endpoint logic to GPT-5.4 but with less abstraction.                                         | Low by size only. Simpler because major concerns are omitted.                               |
| Maintainability Index | Medium. Good separation, but weak API-test support lowers maintainability confidence.                        | High. Best abstraction quality, route organization, and error-handling consistency in the repo.                 | Medium to high. Modular, but more repetitive and less standardized than GPT-5.4.                               | Low. Prototype-level structure with weak auth and no testing support.                       |
| Code Duplication      | Medium. Many small files repeat controller patterns.                                                         | Low. Shared async and error utilities reduce repeated logic.                                                    | Medium. Repeated try/catch and controller patterns remain visible.                                             | Low in raw count, but only because the implementation is minimal.                           |
| Test Coverage         | Very low. Only a math utility test is committed; task-manager API routes are effectively untested.           | High relative to this repo. Auth, user, and task endpoints are covered with isolated in-memory DB setup.        | High relative to this repo. Broad route-level tests exist, though they depend on an external MongoDB instance. | None. No tests are present.                                                                 |
| Defect Density        | Medium. Reasonable design, but older patterns and low API-test coverage leave more latent risk.              | Low. Few visible defects and the best guardrails against regressions.                                           | Medium. Generally solid, but inconsistent error and validation paths raise risk.                               | High. Missing production-ready auth, weak authorization flow, and unsafe response patterns. |
| Change Effort         | Medium to high. Small focused files help, but low route-level test support makes changes slower to validate. | Low. Clear modules and a usable test harness make changes easiest here.                                         | Medium. Modular but repetitive, so consistency costs more during changes.                                      | Very high. Structural cleanup is needed before safe feature work.                           |

## Supporting Evidence

| Codebase          | Source Files | Source Lines | Test Files | Test Lines |
| ----------------- | -----------: | -----------: | ---------: | ---------: |
| Human             |           27 |          592 |          1 |         31 |
| GPT-5.4           |           15 |          630 |          4 |        162 |
| Claude Sonnet 4.6 |           14 |          632 |          3 |        555 |
| Llama 3           |            3 |          120 |          0 |          0 |

## Overall Ranking

1. GPT-5.4
2. Claude Sonnet 4.6
3. Human baseline
4. Llama 3

The ranking above is based on the repository's defined metrics and the code committed in this workspace. It is qualitative rather than tool-generated because the repository does not yet contain committed SonarQube, ESLint, or Jest coverage reports for the task-manager implementations.
