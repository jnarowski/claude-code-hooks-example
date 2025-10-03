# Create Spec

Create a spec markdown file containing a detailed outline of a feature or project that needs to be implemented.

## Variables

`CONTEXT` = $ARGUMENTS

## Instructions

- Do not provide timelines or estimates.
- Never assume others understand the context of what we're doing and why we're doing it
- Always use markdown task formatting for tasks under each phase
- We'll pass this document along to one or many devs, so please include all the context needed to implement this each phase of this spec successfully.
- If `CONTEXT` is provided, use this as context to create the spec and derive the spec name. If `CONTEXT` is not provided, use the existing context that is already loaded for the spec name and scope

## Workflow

1. Create a markdown document in `specs/[timestamp]-[spec-name].md`
2. Add all the scope as defined above into this document
3. Separate the implementation into phases with individual markdown tasks for each step of the phase.

## Report

- Provide a short summary of the spec itself
- Provide the relative to the file
