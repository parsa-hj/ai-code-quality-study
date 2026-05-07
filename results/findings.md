# Findings

## Summary

The repository now contains evidence from two project families, and the combined result still does not support a simple human-versus-AI conclusion. Instead, it shows strong variation inside the AI-generated group and meaningful differences by project type. GPT-5.4 is the most consistently strong implementation family across both task manager and grocery app, Claude Sonnet 4.6 is generally workable but less restrained, Llama 3 remains prototype-level in both projects, and the human baselines are broader and more feature-rich than some AI variants but not automatically easier to maintain or verify.

## Key Findings

- The best-performing implementation family in this sample is AI-generated. GPT-5.4 is the strongest overall across both projects because it is the most consistent in modularity, response discipline, and changeability.
- AI-generated quality is highly model-sensitive. Claude Sonnet 4.6 is materially stronger than Llama 3 in both project families, which means "AI code" is too broad a category for a reliable conclusion.
- Project type changes the observed strengths. In the task-manager API, testing and centralized backend concerns dominate the rankings. In the grocery app, UI architecture, duplication, and demo-grade security practices become the stronger differentiators because none of the variants ship committed tests.
- The human baselines are not automatically the easiest systems to maintain. The task-manager human baseline is under-tested at the API level, and the grocery-app human baseline carries a large amount of template-style repeated UI structure.
- Test infrastructure is still the clearest predictor of long-term confidence. The task-manager results are most favorable to GPT-5.4 partly because it includes a usable automated test harness. The grocery-app results are weaker across the board because all four Flutter variants lack committed tests.
- Security posture is uneven and often only demo-grade outside the best task-manager variants. The grocery-app implementations especially rely on insecure local persistence, mock credentials, or incomplete network/auth boundaries.
- Small code size can be misleading as a quality signal. Llama 3 is the smallest implementation family in both projects, but that apparent simplicity results from omitted concerns such as secure authentication, robust state management, error handling, and validation support.

## Metric Interpretation

### Cyclomatic Complexity

Moderate complexity in GPT-5.4 and Claude Sonnet 4.6 is not necessarily negative because it often reflects explicit validation, request shaping, and richer feature support. In the grocery app, aggregate complexity also comes from UI flow and repeated screen scaffolding. Llama 3 looks simplest only because it leaves out important behavior.

### Maintainability Index

Maintainability is highest when the codebase couples modularity with consistent cross-cutting behavior and a restrained code footprint. GPT-5.4 does this best across both projects. The human baselines remain understandable, but their maintenance cost rises when test support is weak or when template-generated structures create too much repeated UI surface.

### Code Duplication

Both the human baselines and Claude Sonnet 4.6 repeat patterns more often than GPT-5.4. In task manager this shows up in repeated controller logic; in grocery app it appears more heavily in generated screen, binding, and model scaffolding. GPT-5.4's shared utilities and widgets reduce duplication in the areas that matter most during future maintenance.

### Test Coverage

Coverage is still one of the strongest differentiators in the repository, but only for the task-manager project. GPT-5.4 and Claude Sonnet 4.6 are easier to trust there because they include endpoint tests. In the grocery-app project, all four variants have effectively no committed automated verification, which lowers confidence in every ranking.

### Defect Density

The repository does not include a numeric defect log, but visible implementation defects and robustness gaps are concentrated most heavily in Llama 3 and least heavily in GPT-5.4. The human baselines and Claude Sonnet 4.6 fall between those extremes for different reasons: the human task-manager baseline lacks API verification, the human grocery baseline carries a large generated surface, and Claude Sonnet 4.6 is less consistent or more expansive than GPT-5.4 depending on project.

### Security Findings

Security posture is strongest in the best task-manager variants and weakest in the grocery-app set. GPT-5.4's task-manager implementation is the most security-mature code in the repository because auth, validation, and protected routes are treated as first-class concerns. By contrast, the grocery-app implementations mostly operate at demo-app security depth: shared-preferences persistence, mock credentials, or incomplete networking/auth boundaries are common. Llama 3 is the weakest security performer in both projects.

### Change Effort

Change effort is lowest for GPT-5.4 because its abstractions align with likely areas of future modification and, in task manager, it also includes the strongest test support. It is highest for Llama 3 because safe feature work would first require architectural cleanup. The human baselines are harder to evolve than their feature maturity might suggest because verification support is limited or the code surface is too repetitive.

## Interpretation

For this repository, the evidence suggests that AI-assisted development does not inherently produce lower-quality code than human development. It can produce higher-quality code when the generated output includes engineering disciplines such as modularity, centralized error handling, reusable abstractions, validation, and automated testing. At the same time, the Llama 3 variants show that AI-assisted generation can also produce code with high maintenance cost, weak security posture, and obvious robustness gaps.

The more defensible conclusion is therefore conditional: AI assistance changes the distribution of outcomes, not the direction of quality in a uniform way. The maintenance cost and security risk of a generated codebase depend far more on the quality of its structure, validation, storage choices, and test harness than on whether a human or model wrote the first draft. The grocery-app results sharpen that conclusion by showing that a project can look visually complete while still remaining weakly verified and only demo-grade from a security perspective.

## Future Work

- Run SonarQube, ESLint, and Jest coverage for all four task-manager implementations so the qualitative rankings can be replaced with numeric metric outputs.
- Run `flutter analyze`, `flutter test`, and coverage collection for all four grocery-app implementations.
- Add security-focused checks such as secret scanning, dependency auditing, and mobile storage/auth review so the security findings can become more than inspection-based labels.
- Repeat the comparison after a controlled change task to measure real modification time, files changed, and post-change bugs instead of inferring change effort from structure alone.
