# /analyze - Codebase Analysis Command

## Purpose
Analyzes existing codebase to extract patterns, conventions, and architectural decisions for context building.

## Usage
```
/analyze [scope]
```

Scopes:
- `full` - Complete codebase analysis
- `patterns` - Focus on code patterns and conventions
- `architecture` - Focus on architectural decisions
- `recent` - Analyze recent changes only

## Process

1. **Scan Project Structure**
   - Identify technology stack
   - Map directory organization
   - Detect framework patterns

2. **Extract Patterns**
   - Naming conventions
   - File organization
   - Common abstractions
   - Error handling approaches

3. **Identify Architecture**
   - Component relationships
   - Data flow patterns
   - External integrations
   - State management

4. **Update Context Files**
   - `.claude/context/patterns.md`
   - `.claude/context/decisions.md`
   - `.claude/context/conventions.md`

## Output Format

```markdown
## Analysis Summary
- **Technology Stack**: [Detected technologies]
- **Architecture Style**: [Identified patterns]
- **Code Conventions**: [Discovered standards]

## Detected Patterns
[Detailed findings organized by category]

## Recommendations
[Suggestions for context documentation]
```

## Example Interaction

```
Human: /analyze patterns

Claude: I'll analyze the codebase focusing on patterns. Let me examine:
- File naming conventions
- Code structure patterns  
- Common abstractions
- Testing approaches

[Analysis results...]

Based on this analysis, I've identified:
1. You're using Repository pattern for data access
2. Tests follow AAA pattern (Arrange-Act-Assert)
3. Error handling uses custom exception classes

Should I update the context files with these findings?
```