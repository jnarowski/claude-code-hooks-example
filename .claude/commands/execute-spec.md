---
description: Execute scoped development plan with automated QA and review
argument-hint: <plan-file> [phase-number]
allowed-tools: *
---

# Execute Spec

Act like a professional staff-level software developer and implement the work outlined in the provided spec file.

## Variables

`FILENAME` = $ARGUMENTS[0] (required): Path to plan file (e.g., `docs/plans/feature-x.md`)
`PHASE` = $ARGUMENTS[1] (optional): Specific phase number to execute (if omitted, execute all phases)

## Instructions

- if `FILENAME` is not provided, STOP immediately and ask the user for this.

## Workflow

1. Read `FILENAME` file and load any relevant context you need after reading the plan.
2. Implement the plan, one phase at a time. If `PHASE` is provided, implement only that phase and then stop
3. After you finish each phase:
   a. Stop after each phase and run linting and tests
   b. Update the markdown tasks you have completed
   c. Add any relevant context within the phase for what you did, decisions you made etc that could be useful for another developer
4. Commit with message: "feat(phase-$2): [description]"

## Report

[name of phase implemented] - repeat phase heading and tasks for each phase completed

- ✅ task 1 completed
- ✅ task 2 completed

Linting

- xx tests passing
- xx linting issues/warnings (or all green)
- xx type issues
