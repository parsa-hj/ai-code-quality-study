# Task Manager Raw Analysis Snapshot

## Scope

This snapshot compares the four task-manager implementations in the repository against the study metrics defined in `research/metrics.md`:

- Cyclomatic Complexity
- Maintainability Index
- Code Duplication
- Test Coverage
- Defect Density
- Security Findings
- Change Effort

The values below are qualitative unless otherwise noted. No committed SonarQube reports, ESLint reports, or Jest coverage artifacts were present in the repository, so the analysis is based on direct code inspection plus simple repository counts.

## Repository Snapshot

| Codebase          | JS Source Files | JS Source Lines | Test Files | Test Lines | Notes                                                                                          |
| ----------------- | --------------: | --------------: | ---------: | ---------: | ---------------------------------------------------------------------------------------------- |
| Human baseline    |              27 |             592 |          1 |         31 | Feature-rich baseline with email, avatars, and many single-purpose controllers                 |
| GPT-5.4           |              15 |             630 |          4 |        162 | Modular Express API with versioned routes, centralized error handling, and isolated test setup |
| Claude Sonnet 4.6 |              14 |             632 |          3 |        555 | Similar modular Express API with extensive endpoint tests and manual try/catch handling        |
| Llama 3           |               3 |             120 |          0 |          0 | Prototype-level code split across three small files with no runnable test suite                |

## Metric Evidence

### Cyclomatic Complexity

| Codebase          | Evidence                                                                                                                                                                   |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | Complexity is distributed across many small controller files, but handlers like task listing and update validation branch on filters, sorting, and user-owned data.        |
| GPT-5.4           | Controller methods combine filtering, sorting, pagination, input validation, and structured error paths, which raises local branch count while keeping logic consolidated. |
| Claude Sonnet 4.6 | Complexity is moderate and similar to GPT-5.4 for task endpoints, but fewer abstractions mean more repeated control flow in controller try/catch blocks.                   |
| Llama 3           | Raw branching is low because the implementation is very small, but that low complexity comes from missing features rather than better design.                              |

### Maintainability Index

| Codebase          | Evidence                                                                                                                                                                  |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | Strong feature separation, but low test support and older Mongoose patterns reduce maintainability confidence.                                                            |
| GPT-5.4           | Best maintainability signals: route versioning, reusable async wrapper, dedicated error middleware, consistent response shape, and isolated MongoMemoryServer test setup. |
| Claude Sonnet 4.6 | Good module separation and broad endpoint tests, but maintainability is pulled down by repetitive try/catch blocks and less standardized responses.                       |
| Llama 3           | Very weak maintainability due to monolithic API/auth design, hardcoded database configuration, and missing persistence/test scaffolding.                                  |

### Code Duplication

| Codebase          | Evidence                                                                                                                |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | Some duplication exists across many one-operation controller files for status handling and owner checks.                |
| GPT-5.4           | Lowest operational duplication because async handling and API errors are abstracted into shared utilities.              |
| Claude Sonnet 4.6 | Repeated controller try/catch and repeated authorization response patterns create moderate duplication.                 |
| Llama 3           | Small code size keeps visible duplication low, but this is not meaningful because most production concerns are omitted. |

### Test Coverage

| Codebase          | Evidence                                                                                                                                                                           |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | Only `tests/math.test.js` is present; there are no route-level tests for users, auth, or tasks. Coverage for the task manager API is therefore very low.                           |
| GPT-5.4           | Includes auth, user, and task API tests plus isolated in-memory MongoDB setup. Coverage is not numerically reported, but functional surface coverage is broad.                     |
| Claude Sonnet 4.6 | Includes auth, user, and task tests with many scenarios. Coverage surface is broad, though the tests depend on an external MongoDB instance rather than an isolated memory server. |
| Llama 3           | No tests are present.                                                                                                                                                              |

### Defect Density

| Codebase          | Evidence                                                                                                                                                                                             |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | No obvious catastrophic defects, but there are robustness issues such as outdated Mongoose usage and untested API behavior.                                                                          |
| GPT-5.4           | Lowest visible defect density. Most issues are minor, such as limited query parsing strictness rather than broken control flow.                                                                      |
| Claude Sonnet 4.6 | Moderate defect risk from inconsistent error paths and fewer shared safeguards, though the test suite offsets some of that risk.                                                                     |
| Llama 3           | Highest visible defect density. Examples include invalid middleware structure in `authorization.js`, missing JWT/session handling, and exposure of user objects directly from login/register routes. |

### Security Findings

| Codebase          | Evidence                                                                                                                                                                                                                                     |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | Basic auth and owner-scoping exist, but the repository provides little route-level security verification. The implementation looks more production-oriented than the weaker AI variants, yet confidence is reduced by the missing API tests. |
| GPT-5.4           | Strongest security posture in this project sample. Auth, authorization, validation, and centralized error paths are more consistent, and the committed test harness exercises protected behavior.                                            |
| Claude Sonnet 4.6 | Security posture is workable but less uniform than GPT-5.4. Authorization and auth flows exist, but repeated manual controller logic raises the risk of inconsistent failure handling over time.                                             |
| Llama 3           | Highest security risk. The implementation lacks production-ready JWT/session handling, has weak authorization structure, and exposes raw user data directly from auth responses.                                                             |

### Change Effort

| Codebase          | Evidence                                                                                                                                                                               |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Human baseline    | Change effort is moderate to high: many small files help localize edits, but limited API-test coverage makes safe changes slower.                                                      |
| GPT-5.4           | Lowest change effort because responsibilities are clear, error handling is centralized, and tests support safe iteration.                                                              |
| Claude Sonnet 4.6 | Moderate change effort: modules are cleanly separated, but each change often requires touching repeated controller logic and validating against an external database-backed test flow. |
| Llama 3           | Highest change effort despite small size because the design lacks abstractions, tests, and production-ready auth/data boundaries.                                                      |

## Qualitative Metric Ranking

| Metric                | Human baseline | GPT-5.4                     | Claude Sonnet 4.6     | Llama 3                     |
| --------------------- | -------------- | --------------------------- | --------------------- | --------------------------- |
| Cyclomatic Complexity | Moderate       | Moderate to moderately high | Moderate              | Low, but feature-incomplete |
| Maintainability Index | Medium         | High                        | Medium to high        | Low                         |
| Code Duplication      | Medium         | Low                         | Medium                | Low by size only            |
| Test Coverage         | Very low       | High relative to repo       | High relative to repo | None                        |
| Defect Density        | Medium         | Low                         | Medium                | High                        |
| Security Findings     | Medium         | Low                         | Medium                | High                        |
| Change Effort         | Medium to high | Low                         | Medium                | Very high                   |

## Important Caveat

This file is an inspection-based evidence summary, not a replacement for tool-generated metric outputs. If the study later runs SonarQube, ESLint, and Jest coverage in a controlled environment, those numeric outputs should supersede the qualitative labels here while preserving the same comparative interpretation.
