# AI Code Quality Study

## Overview

This project evaluates the impact of AI-assisted code generation on software quality and long-term maintainability. It compares a human-written task manager API (sourced from an existing GitHub repository) with multiple AI-generated implementations created using modern coding assistants.

The goal is to understand whether AI-generated code introduces higher complexity, lower maintainability, or increased technical debt compared to traditional human-written code.

---

## Research Question

**Does AI-assisted development produce code with lower quality and higher long-term maintenance cost compared to human-written code?**

---

## Methodology

### Experimental Design

* One human-written task manager API (baseline)
* Multiple AI-generated versions of the same system using different LLMs in GitHub Copilot and Ollama:

  * GPT 5.4
  * Claude Sonnet 4.6
  * Llama 3

Each version:

* Implements the same functional requirements
* Uses the same runtime environment
* Is evaluated using identical metrics

---

### Evaluation Approach

The study uses three layers of analysis:

#### 1. Static Code Analysis

* Cyclomatic Complexity
* Maintainability Index
* Code Duplication
* Code Smells and Linting Issues

#### 2. Testing & Reliability

* Test Coverage
* Defect Density (failures per 1000 lines of code)

#### 3. Maintainability (Change Task)

Each codebase is given the same modification task:

> Example: Add authentication and restrict task access per user

Measured:

* Time required
* Number of files modified
* Bugs introduced after the change

---

## Metrics

* **Cyclomatic Complexity** – Measures code logic complexity
* **Maintainability Index** – Indicates how maintainable the code is
* **Code Duplication (%)** – Identifies repeated code blocks
* **Test Coverage (%)** – Measures how much code is tested
* **Defect Density** – Bugs per 1000 lines of code
* **Change Effort** – Time and work required to modify the system

---

## Tools Used

* Static Analysis: SonarQube
* Linting: ESLint
* Testing: Jest
* AI Code Generation:

  * GitHub Copilot
  * Ollama

---

## Repository Structure

```
ai-vs-human-code-quality/
│
├── README.md
│
├── research/
│   ├── proposal.md          # Original project proposal
│   ├── methodology.md      # Detailed experimental design
│   ├── metrics.md          # Definitions of all metrics used
│   └── limitations.md      # Assumptions and constraints
│
├── projects/
│   └── task-manager/
│       ├── human/          # Human-written codebase (cleaned + documented)
│       │   └── SOURCE.md   # Original repo reference and modifications
│       │
│       └── ai/
│           ├── Claude-Sonnet-4.6/
│           ├── GPT-5.4/
│           └── Llama-3/
│
├── analysis/
│   ├── raw/                # Raw outputs from analysis tools
│   ├── processed/          # Cleaned and structured data
│   └── charts/             # Visualizations and graphs
│
├── results/
│   ├── comparison-table.md # Side-by-side metric comparison
│   └── findings.md         # Key insights and interpretations
│
├── prompts/
│   └── ai-prompts.md       # All AI prompts used in generation
│
└── tools/
    └── scripts/            # Scripts for running analysis
```

---

## Reproducibility

This project is designed to be fully reproducible:

* All AI prompts are documented in `/prompts`
* Human code source and modifications are documented in `/projects/task-manager/human/SOURCE.md`
* Analysis scripts and raw outputs are included
* Metrics definitions are clearly specified

---

## Key Assumptions & Limitations

* The human-written codebase is assumed to be developed without AI assistance
* AI-generated code quality may vary based on prompt quality
* The study uses a limited number of projects and may not generalize to large-scale systems
* Results may be influenced by developer experience and interpretation

---

## Expected Outcomes

This project aims to:

* Identify differences in code quality between AI and human development
* Quantify trade-offs between speed and maintainability
* Highlight risks such as increased coupling or hidden defects in AI-generated code
* Provide practical insights for responsible AI-assisted development

---

## Future Work

* Expand to larger and more complex systems
* Include more AI tools and models
* Analyze long-term evolution over multiple change cycles
* Incorporate team-based development scenarios
