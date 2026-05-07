# Grocery App Comparative Analysis

## Overview

The grocery-app portion of this repository compares one human-written Flutter baseline against three AI-generated variants using the metrics defined in `research/metrics.md`. Unlike the task-manager project, the grocery-app implementations are all UI-heavy, mock-data-oriented applications with no committed automated tests. That difference matters: the grocery-app evidence is weaker on reliability and makes architecture and security hygiene more important as comparison signals.

The main result is that the grocery-app study does not produce a simple human-versus-AI split either. GPT-5.4 is the most balanced grocery implementation because it keeps the feature set reasonably broad while maintaining a comparatively compact structure. Claude Sonnet 4.6 is feature-rich and better validated at the form level, but it is much larger and carries more repeated surface area. The human baseline is broad but heavily template-shaped. Llama 3 remains a prototype-level outlier.

## Metric-by-Metric Interpretation

### Cyclomatic Complexity

Complexity in the grocery project is driven less by backend-style branching and more by the amount of UI flow, state wiring, and screen-specific controller logic. The human baseline has the highest aggregate complexity because it spreads behavior across a very large number of generated screens, bindings, and models. Claude Sonnet 4.6 also has a large and feature-rich footprint.

GPT-5.4 keeps complexity more controlled by concentrating behavior into a smaller set of repositories, controllers, and shared widgets. Llama 3 looks simplest only because the app is drastically incomplete.

### Maintainability Index

GPT-5.4 is the strongest grocery variant for maintainability. It has clearer module boundaries than the other grocery implementations and avoids the heavy generated surface visible in the human baseline. Claude Sonnet 4.6 is still structured, but its larger code volume and broader feature spread make maintenance cost higher.

The human baseline is maintainable in the sense that patterns repeat predictably, but those repeated generated structures increase navigation cost and change scope. Llama 3 has the weakest maintainability because it lacks enough architectural stability to support normal feature work.

### Code Duplication

Duplication is a major differentiator in the grocery project. The human baseline repeats screen, binding, and model scaffolding extensively, which is typical of generator-driven Flutter output. Claude Sonnet 4.6 also repeats patterns more often because of its large controller and screen surface. GPT-5.4 reduces duplication most effectively through shared widgets and a tighter module count.

Llama 3 again appears small rather than disciplined; its low duplication is mostly a side effect of missing functionality.

### Test Coverage

This is the weakest metric across the entire grocery-app study. None of the four grocery implementations include committed tests. That means no grocery variant earns a strong reliability score, and all maintainability conclusions should be read with lower confidence than in the task-manager project.

The absence of tests also changes how to interpret apparent polish. A cleaner architecture is helpful, but without widget, controller, or integration tests, even the best grocery variant remains harder to evolve safely than the best task-manager variant.

### Defect Density

GPT-5.4 has the lowest visible defect density among the grocery implementations because its structure is coherent and its mock-data boundaries are clear. Claude Sonnet 4.6 is still usable, but its heavier implementation and demo-specific auth choices introduce more visible risk. The human baseline has many fewer obvious logic failures than Llama 3, yet its generated bulk and lack of verification create more latent risk than the screen count alone suggests.

Llama 3 has the highest defect density by inspection. It includes broken architectural references, thin controllers, and HTTP calls without visible safety checks, which is not enough for a trustworthy application baseline.

### Security Findings

Security is weak across the grocery project compared with the best task-manager implementations. All four grocery variants are effectively demo applications rather than security-mature products. GPT-5.4 avoids some risk by staying mock-data-centric, but it still relies on plain shared-preferences persistence rather than secure storage. Claude Sonnet 4.6 validates user input more carefully, yet it persists mock auth tokens in plain shared preferences and advertises demo credentials directly in code paths.

The human baseline exposes less explicit auth logic, which limits direct exploit discussion, but it also provides little evidence of secure session management. Llama 3 is again the weakest because its networking and app structure do not establish reliable security boundaries at all.

### Change Effort

Change effort is lowest in GPT-5.4 for the grocery project because it combines a manageable file count with clear ownership boundaries. Claude Sonnet 4.6 is changeable but more expensive because more files and repeated flows need coordinated updates. The human baseline would be costly to evolve because many UI changes would cascade across repeated generated structures.

Llama 3 would require repair before ordinary feature work, so its effective change effort is highest despite its tiny codebase.

## Codebase Summaries

### Human Baseline

The human grocery baseline is broad and visually complete, but it behaves more like a large generated UI scaffold than a deeply engineered application. Its biggest costs are duplication, size, and missing automated verification.

### GPT-5.4

GPT-5.4 is the strongest grocery-app implementation in this repository. It does not solve the test gap, but it provides the best balance of modularity, scope, and changeability.

### Claude Sonnet 4.6

Claude Sonnet 4.6 produces a capable and feature-rich Flutter app with better form validation than the other grocery variants. Its main weakness is that it pays for that breadth with much higher code volume and less restraint around repeated patterns and token persistence.

### Llama 3

Llama 3 is not competitive with the other grocery implementations. It is better described as an incomplete prototype that lacks the structure needed for reliable maintenance or trustworthy security review.

## Conclusion

The grocery-app results reinforce the same broad pattern as the task-manager project, but with an important qualifier: project type matters. In a backend API task, strong AI output can pair modularity with real verification. In this UI-heavy Flutter task, the best implementations still lack committed tests and rely on demo-grade security practices.

That makes the cross-project conclusion more precise. AI assistance does not uniformly reduce code quality relative to human-written code, but it does produce highly variable outcomes that depend on both the model and the kind of software being generated. In the grocery project, the main weakness is not just who wrote the code; it is the absence of verification and production-ready security discipline across the entire comparison set.
