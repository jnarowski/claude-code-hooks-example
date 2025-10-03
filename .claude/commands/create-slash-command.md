---
allowed-tools: Bash, Read, Write
description: Creates a new structured Claude Slash Command
---

# Create Slash Command

Run the commands under the `Execute` section to gather information about the project, and then review the files listed under `Read` to understand the project's purpose and functionality then `Report` your findings.

<template>
    ---
    allowed-tools: [Example: Bash, Read]
    description: [short description]

    ---

    # [Name of File - EG: Create Slach Command]

    [A 2-3 sentence overview written for AI on what to do with this command]

    ## Variables

    `VARIABLE_ONE` = $ARGUMENTS[0]
    `VARIABLE_TWO` = $ARGUMENTS[1]

    ## Instructions

    [You may not need an instructions section separate from your workflow section. Use instructions if you want to add additional context that might not fit into the step-by-step workflow below]

    - Something
    - Another thing to know

    ## Workflow

    [The step-by-step commands the agent will follow when executing this command]

    1. Do this
    2. Then do this
    3. Finally do this

    ## Report

    [Output the agent provides after finishing the work. Not all commands will have a report section]

</template>

<example_1>
---
allowed-tools: Bash, Read
description: Load context for a new agent session by analyzing codebase structure, documentation and README
---

    # Prime

    Run the commands under the `Workflow` section to gather information about the project, and then review the files listed under `Read` to understand the project's purpose and functionality then `Report` your findings.

    ## Workflow

    1. Execute `git ls-files`
    2. Read README.md

    ## Report

    - Provide a summary of your understanding of the project

</example_1>

## Workflow

1. Use the context provided by the user to create a new file in .claude/commands
2. Use "template" for the structure
3. Ask the user any clarifying questions you might need to successfully implement the hook, one-by-one

## Report

- Output the name of the created command along with a brief description of what the command does.
