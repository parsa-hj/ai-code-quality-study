# Findings

## Summary

The task-manager comparison in this repository does not support a simple human-versus-AI conclusion. Instead, it shows wide variation inside the AI-generated group itself. GPT-5.4 produced the strongest overall implementation for maintainability and testability, Claude Sonnet 4.6 produced a workable but less polished modular API, and Llama 3 produced a prototype-level codebase with major engineering gaps. The human baseline remains feature-rich and recognizable as production-style application code, but in its current committed form it is significantly under-tested at the API level.

## Key Findings

- The best-performing codebase in this sample is AI-generated. GPT-5.4 combines modular structure, centralized error handling, consistent responses, and a usable automated test setup.
- AI-generated quality is highly model-sensitive. Claude Sonnet 4.6 is materially stronger than Llama 3, which means "AI code" is too broad a category for a reliable conclusion.
- The human baseline is not the easiest system to maintain despite its maturity. It includes more end-user features, but its lack of route-level test coverage increases maintenance cost and regression risk.
- Test infrastructure is the clearest predictor of maintainability in this repository. GPT-5.4 and Claude Sonnet 4.6 are easier to evaluate and safer to change because they include endpoint tests; the human baseline and Llama 3 do not.
- Small code size can be misleading as a quality signal. Llama 3 is the smallest implementation, but that apparent simplicity results from omitted concerns such as secure authentication, robust authorization, and validation support.

## Metric Interpretation

### Cyclomatic Complexity

Moderate complexity in GPT-5.4 and Claude Sonnet 4.6 is not necessarily negative because it partly reflects explicit validation and request-shaping logic. Llama 3 looks simplest only because it leaves out important behavior.

### Maintainability Index

Maintainability is highest when the codebase couples modularity with consistent cross-cutting behavior. GPT-5.4 does this best. The human baseline is maintainable at the file level, but its low API-test support lowers long-term confidence.

### Code Duplication

Both the human baseline and Claude Sonnet 4.6 repeat controller patterns more often than GPT-5.4. GPT-5.4's shared utilities reduce duplication in the areas that matter most during future maintenance.

### Test Coverage

Coverage is the weakest point in the human baseline and the strongest differentiator in favor of GPT-5.4 and Claude Sonnet 4.6. Llama 3 provides no evidence of tested behavior.

### Defect Density

The repository does not include a numeric defect log, but visible implementation defects and robustness gaps are concentrated most heavily in Llama 3 and least heavily in GPT-5.4. The human baseline and Claude Sonnet 4.6 fall between those extremes for different reasons: the human baseline lacks validation evidence through tests, while Claude Sonnet 4.6 is less consistent in error and validation flow.

### Change Effort

Change effort is lowest for GPT-5.4 because its abstractions and tests align with the likely areas of future modification. It is highest for Llama 3 because safe feature work would first require architectural cleanup. The human baseline is harder to evolve than its feature maturity might suggest because verification support is limited.

## Interpretation

For this repository, the evidence suggests that AI-assisted development does not inherently produce lower-quality code than human development. It can produce higher-quality code when the generated output includes engineering disciplines such as modularity, centralized error handling, and automated testing. At the same time, the Llama 3 variant shows that AI-assisted generation can also produce code with high maintenance cost and obvious robustness gaps.

The more defensible conclusion is therefore conditional: AI assistance changes the distribution of outcomes, not the direction of quality in a uniform way. The maintenance cost of a generated codebase depends far more on the quality of its structure, validation, and test harness than on whether a human or model wrote the first draft.

## Future Work

- Run SonarQube, ESLint, and Jest coverage for all four task-manager implementations so the qualitative rankings can be replaced with numeric metric outputs.
- Apply the same analysis pattern to an additional project so the study is not dominated by a single task-manager example.
- Repeat the comparison after a controlled change task to measure real modification time, files changed, and post-change bugs instead of inferring change effort from structure alone.
