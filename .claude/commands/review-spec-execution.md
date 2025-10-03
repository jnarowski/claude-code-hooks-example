---
allowed-tools: [Bash, Read]
description: Review implementation against plan specifications and project standards
---

# Review Plan Execution

Reviews completed work against the original plan file to identify gaps, deviations, and quality issues. Compares git changes with plan requirements and runs quality checks.

## Variables

`SPEC_FILE` = $ARGUMENTS[0]

## Workflow

1. **Load plan and changes**

```bash
cat specs/$SPEC_FILE
git diff main...HEAD
git status
git log --oneline HEAD~10..HEAD
```

2. **Run quality checks**

```bash
pnpm check-types && pnpm lint && NODE_ENV=test pnpm test && pnpm build
```

3. **Analyze implementation**
   - Map completed files/changes to plan tasks
   - Identify missing tasks from plan
   - Flag quality issues and test gaps
   - Note any out-of-scope additions

## Report

```md
# Plan: $PLAN_FILE

## Completion Status

- Phase 1: [name] → DONE/PARTIAL/MISSING
- Phase 2: [name] → DONE/PARTIAL/MISSING
  [continue for all phases]

## Critical Gaps

**[Task X.Y] - [requirement]**

- Expected: [what plan said]
- Actual: [what exists]
- Fix: [specific action]

## Quality Issues

**[file:line]**

- Issue: [specific problem]
- Fix: [exact change needed]

## Test Gaps

- Missing: [scenario from plan]
- Coverage: [X/Y tests from plan]

## Quality Scores

- Types: PASS/FAIL
- Lint: PASS/FAIL
- Tests: PASS/FAIL (X/Y scenarios)
- Build: PASS/FAIL

## To Complete

1. [Specific file/function to fix] - [exact action]
2. [Specific test to add] - [exact scenario]
3. [Specific feature to implement] - [from Task X.Y]
```
