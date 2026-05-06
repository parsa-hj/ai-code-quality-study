# Task Manager Comparative Analysis

## Overview

The task-manager portion of this repository compares one human-written API against three AI-generated variants using the metrics defined in `research/metrics.md`. All four implementations target the same general problem space, but they differ materially in architecture maturity, test strategy, and operational robustness.

The main result is that code quality does not track feature count alone. The strongest implementation is the one that combines modular structure with consistent error handling and a runnable test harness. In this repository, that is the GPT-5.4 version. The weakest implementation is not merely the smallest one; it is the one that omits the engineering scaffolding needed for safe change, which is the Llama 3 version.

## Metric-by-Metric Interpretation

### Cyclomatic Complexity

The human baseline keeps most endpoint logic in narrow controller files, which contains complexity locally but spreads the system across many files. GPT-5.4 and Claude Sonnet 4.6 both implement richer task-query behavior such as filtering, sorting, pagination, and owner scoping in shared controllers, so their per-function branching is somewhat higher. Llama 3 appears simplest only because it implements a much smaller subset of the required behavior.

For this study, complexity should not be read in isolation. Higher branch counts in GPT-5.4 and Claude Sonnet 4.6 are partly the cost of implementing more explicit validation and request handling. Llama 3's low apparent complexity reflects missing capability, not superior design.

### Maintainability Index

GPT-5.4 is the most maintainable implementation in the repository. It has clear module boundaries, versioned routing, centralized error handling, shared async utilities, and a consistent response contract. Those features reduce the amount of code a maintainer must understand to make a safe change.

Claude Sonnet 4.6 is structurally solid, but it relies on repeated manual try/catch blocks and less standardized API responses. The human baseline remains understandable because each action is isolated in a small file, yet maintainability is limited by weak test support for the actual API surface and older persistence patterns. Llama 3 has the lowest maintainability because responsibilities are collapsed into a tiny, under-structured codebase.

### Code Duplication

GPT-5.4 shows the least meaningful duplication because it factors common concerns into reusable utilities. Claude Sonnet 4.6 repeats controller and error-path structure more often. The human baseline also repeats route-adjacent patterns because each user/task action lives in its own file, which improves local readability but increases repeated status handling and owner-scoping logic. Llama 3 has little visible duplication only because the implementation is extremely small.

### Test Coverage

Test support is one of the clearest differentiators in this repository. GPT-5.4 includes auth, user, and task tests with an isolated in-memory MongoDB setup, which makes repeatable validation feasible. Claude Sonnet 4.6 also includes a broad suite of route-level tests, though its setup depends on a MongoDB instance rather than a memory-backed harness.

The human baseline has almost no task-manager API coverage in the repository: its only committed test file exercises a separate math utility. That weakens confidence in future changes even if the runtime behavior is otherwise reasonable. Llama 3 has no tests at all, which makes any maintainability or reliability claim very weak.

### Defect Density

The repository does not include a numeric bug log, so defect density must be inferred from visible defects and robustness gaps. GPT-5.4 has the lowest apparent defect density because its code paths are guarded and test-backed. Claude Sonnet 4.6 has moderate risk because validation and error handling are less uniform. The human baseline has fewer obvious design mistakes than Llama 3, but its missing API tests and older data-access patterns increase the chance of latent faults.

Llama 3 has the highest defect density by inspection. Its authorization flow is not production-ready, it lacks JWT/session handling, and it returns raw user objects from auth routes. Those are not just style issues; they materially increase security and correctness risk.

### Change Effort

Change effort is lowest in GPT-5.4 because its abstractions align with the likely axes of change: route expansion, validation updates, error handling, and authenticated task access. Claude Sonnet 4.6 is still reasonably changeable, but repeated controller boilerplate increases the cost of consistent updates. The human baseline requires more care because API behavior is spread across many files without matching route-level tests. Llama 3 would require structural rework before even routine enhancements could be made safely.

## Codebase Summaries

### Human Baseline

The human-written code is the most feature-rich baseline in the repository, including avatar management and email utilities in addition to task and auth flows. Its main quality trade-off is that it is more complete than it is measurable: the code is organized, but the committed tests do not cover the API that the study is evaluating.

### GPT-5.4

This is the strongest overall implementation for the task-manager study. It balances modularity, operational concerns, and testability better than the alternatives. Its main weaknesses are relatively minor and mostly concern incremental refinement rather than broken design.

### Claude Sonnet 4.6

Claude Sonnet 4.6 produces a capable, modular API with broad endpoint tests, but it is less polished than GPT-5.4 in consistency and cross-cutting abstractions. It sits in the middle: clearly more maintainable than Llama 3 and more testable than the human baseline as committed in this repository, but not as operationally mature as GPT-5.4.

### Llama 3

Llama 3 is best treated as a prototype rather than a comparable production-style implementation. Its low source size and apparent simplicity are misleading because they come from omitted concerns such as secure authentication, proper authorization boundaries, structured error handling, and tests.

## Conclusion

For the task-manager task in this repository, the strongest evidence supports a mixed conclusion rather than a blanket claim that AI-generated code is worse than human-written code. One AI system, GPT-5.4, produced the most maintainable and testable implementation in this sample. Another AI system, Llama 3, produced the weakest implementation by a large margin. The human baseline sits between them: it is feature-complete and recognizable as real application code, but its lack of task-manager API tests raises maintenance cost for future changes.

That means the repository's current evidence supports a model-sensitive conclusion: AI-assisted development can produce either strong or weak code quality outcomes, and the decisive factors are engineering discipline, consistency, and validation support rather than authorship label alone.
