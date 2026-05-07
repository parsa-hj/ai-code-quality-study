# Methodology

## Experimental Design

This study compares human-written and AI-generated implementations of the same software systems.

The repository currently includes two comparison targets:

- A task-manager API
- A grocery shopping Flutter application

## Controlled Variables

- Same project requirements
- Same evaluation metrics
- Same runtime environment within each project family

## Independent Variable

- Code generation method (human vs AI)

## Dependent Variables

- Code quality metrics
- Maintainability indicators
- Defect rates
- Security findings

## Limitations

- Human code assumed to be non-AI-assisted
- Single developer bias
- Small sample size
- Some findings remain qualitative because committed SonarQube, ESLint, Flutter analyze, Flutter test, and Jest coverage artifacts are incomplete or absent for parts of the repository
