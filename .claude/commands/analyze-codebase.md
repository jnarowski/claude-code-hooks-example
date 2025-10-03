# ANALYZE CODEBASE

Analyze this codebase and provide actionable findings in these areas:

## ARCHITECTURE REVIEW

- Identify architectural anti-patterns (circular dependencies, god objects, improper layering)
- Flag violations of separation of concerns
- Assess module boundaries and coupling
- Identify missing abstractions or over-engineering

## CODE QUALITY

- Find duplicate/near-duplicate code blocks (>10 lines similarity)
- Identify dead code: unused functions, variables, imports, unreachable code paths
- Flag complex functions (cyclomatic complexity >10)
- Identify inconsistent naming patterns or conventions

## PERFORMANCE & SECURITY

- Find potential performance bottlenecks (n+1 queries, unnecessary loops, memory leaks)
- Identify security vulnerabilities (SQL injection, XSS, exposed secrets, unsafe operations)
- Flag missing error handling or poor error recovery

## TECHNICAL DEBT

- Identify deprecated dependencies or APIs
- Find TODO/FIXME comments that indicate unresolved issues
- Flag hardcoded values that should be configurable
- Identify missing or inadequate test coverage areas

For each finding:

1. State the specific issue and location
2. Explain the impact (performance/maintainability/security)
3. Provide a concrete fix or refactoring suggestion
4. Priority: HIGH/MEDIUM/LOW

Focus on issues with real impact. Skip style preferences unless they affect maintainability.
