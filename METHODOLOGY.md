# Context-Driven Spec Development Methodology

This methodology guides AI-assisted development through conversational specification building, emphasizing continuous context, iterative refinement, and EARS-formatted requirements.

## Core Philosophy

Unlike command-based approaches, this methodology treats Claude as a collaborative partner in a continuous conversation. Specifications evolve through dialogue, context accumulates naturally, and refinement happens organically without rigid phase gates.

**IMPORTANT**: While conversational in nature, Claude MUST proactively ensure spec-driven development principles are followed. Claude acts as the disciplined partner who maintains methodology rigor while the human drives the conversation freely.

## Claude's Responsibilities

### Proactive Specification Management
Claude MUST:
1. **Create .spec.md files automatically** when discussing any new feature or component
2. **Update specifications continuously** as understanding evolves
3. **Reference specifications** before any implementation
4. **Remind about missing specs** if implementation is requested without them
5. **Suggest specification reviews** when changes accumulate
6. **Track session progress** in specifications for continuity

### Specification Creation Triggers
Claude MUST create or update specs when hearing:
- "implement", "build", "create", "add feature", "develop"
- "need", "want", "should have", "require"
- "how about", "what if we", "let's add"
- "fix", "improve", "optimize", "refactor"
- Any discussion of new functionality or changes

### Specification File Structure
For any feature discussion, Claude MUST automatically create:
```
specs/
└── [feature-name]/
    ├── [feature-name].spec.md     # Comprehensive specification
    └── history/                   # Optional: significant versions
        └── [timestamp]-[change].md
```

### Workflow Enforcement
Even in free-flowing conversation, Claude MUST ensure:
1. **Requirements before Design**: "Let me first capture these requirements in a spec file..."
2. **Design before Implementation**: "Before we code, let me document the design approach..."
3. **Tests from Requirements**: "Based on our requirements, here are the test cases..."
4. **Incremental Progress**: "Let's implement this one piece and validate before moving on..."

## Workflow Overview

### 1. Context Establishment
Begin each session by establishing comprehensive understanding:
```
"Please read the project context files and confirm your understanding of:
- Technical constraints and patterns (.claude/PROJECT_CONTEXT.md)
- Business domain and terminology (.claude/context/glossary.md)
- Quality standards and conventions (.claude/context/conventions.md)
- Current specification state (specs/)"
```

### 2. Specification Development Flow

#### 2.1 Feature Exploration
Start with understanding before specification:
- Explore the problem space through questions
- Identify edge cases and constraints
- Consider stakeholder perspectives
- Document assumptions for validation
- **Create initial spec file immediately**

#### 2.2 Requirements Evolution
Build requirements iteratively using EARS format:
- Start with core functionality (ubiquitous requirements)
- Add behavioral requirements (When-Then)
- Include state-based requirements (While)
- Cover error scenarios (If-Then)
- Specify optional features (Where)
- **Update spec file with each requirement**

#### 2.3 Design Through Dialogue
Develop technical design conversationally:
- Propose multiple approaches
- Discuss trade-offs openly
- Refine based on feedback
- Document decisions and rationale
- **Capture all decisions in spec file**

#### 2.4 Test Specification
Create comprehensive test strategies:
- Map each EARS requirement to test cases
- Define test data and fixtures
- Specify acceptance criteria
- Include performance benchmarks
- **Document in Testing Strategy section**

#### 2.5 Task Planning
Break implementation into contextual tasks:
- Reference accumulated context
- Maintain requirement traceability
- Enable incremental delivery
- Support various implementation styles
- **Create implementation phases with success criteria**

## EARS Requirements Format

### Templates
```
Ubiquitous:    The [system] SHALL [requirement]
Event-Driven:  WHEN [trigger] THEN the [system] SHALL [response]
State-Driven:  WHILE [state] the [system] SHALL [requirement]
Conditional:   IF [condition] THEN the [system] SHALL [requirement]
Optional:      WHERE [feature] the [system] SHALL [requirement]
```

### Best Practices
- One requirement per statement
- Use active voice with SHALL
- Make requirements testable with specific metrics
- Avoid ambiguous terms ("fast", "user-friendly", "appropriate")
- Include acceptance criteria for each requirement

## Context Management

### Project Context Structure
```
project-root/
├── .claude/
│   ├── PROJECT_CONTEXT.md     # Project-specific information
│   ├── context/
│   │   ├── patterns.md        # Discovered code patterns
│   │   ├── decisions.md       # Architectural decisions record
│   │   ├── glossary.md        # Domain terminology
│   │   └── conventions.md     # Coding standards
│   ├── commands/              # Project-specific command overrides (optional)
│   └── templates/             # Project-specific templates (optional)
└── specs/                     # Feature specifications
    └── [feature-name]/
        └── [feature-name].spec.md
```

**Note**: The methodology itself (METHODOLOGY.md) resides either in:
- `~/.claude/` for global installations
- `.claude/` for standalone project installations

### Context Preservation Strategies
1. **Summarize key decisions** at conversation milestones
2. **Update context files** with new understanding
3. **Reference previous discussions** when building on ideas
4. **Document rationale** for future reference
5. **Create session summaries** in spec files

## Specification Template

```markdown
# [Feature Name] Specification

**Status**: 🟡 In Progress | ✅ Complete | 🔄 Needs Update | 🔴 Blocked
**Created**: [Date]
**Last Updated**: [Timestamp]

## Overview

[Brief description of the feature/component and its purpose]

## Requirements Analysis

### Functional Requirements

**FR-1**: The system SHALL [requirement]
- [Sub-requirement or clarification]
- [Acceptance criteria]

**FR-2**: WHEN [trigger] THEN the system SHALL [response]
- [Additional context]

### Non-Functional Requirements

**NFR-1**: The system SHALL [performance/security/usability requirement]
- [Specific metrics or criteria]

## Architecture Decisions

### AD-1: [Decision Title]

**Decision**: [What was decided]

**Rationale**: 
[Why this approach was chosen]

**Alternatives Considered**:
- [Option 1]: [Pros/Cons]
- [Option 2]: [Pros/Cons]

**Trade-offs**:
- [What we gain]
- [What we sacrifice]

## Design Details

### Component Design
[Technical design details, schemas, interfaces]

### Data Model
[If applicable, data structures and relationships]

### Integration Points
[How this connects with existing system]

## Implementation Phases

### Phase 1: [Phase Name]

**Objective**: [What this phase accomplishes]

**Success Criteria**:
- [ ] [Specific measurable outcome]
- [ ] [Another measurable outcome]

**Implementation Approach**: 
[How to implement this phase]

**Validation Method**: 
[How to verify success]

**Status**: ⏳ Not Started | 🚧 In Progress | ✅ Complete | 🔴 Blocked

### Phase 2: [Next Phase]
[Continue pattern...]

## Testing Strategy

### Unit Tests
[Test categories and approach]

### Integration Tests
[Integration test requirements]

### Validation Tests
[How to validate requirements are met]

## Open Questions

1. [Question needing resolution]?
2. [Another open question]?

## Session Status Updates

### Session [Date/Time]

**Progress**:
- ✅ Completed [what was done]
- 🚧 In Progress [what's being worked on]
- ⏭️ Next [what's planned next]

**Decisions Made**:
- [Key decision from session]

**Blockers**:
- [Any blocking issues]

### Session Summary for Handoff
**Specs Updated**: [Which sections changed]
**Current Phase**: [Active implementation phase]  
**Next Steps**: [What to do next session]
**Context**: [Key information for next session]
```

## Core Development Principles

### Incremental Development Process
All development MUST follow these principles:
- **Work in smallest possible chunks** - Break features into 1-2 hour implementation blocks
- **Interactive feedback loops** - Present each increment for validation
- **Test foundational assumptions first** - Validate core concepts before building
- **One success criteria at a time** - Focus on single, measurable outcomes
- **Progressive complexity** - Start simple, add complexity based on validated learnings

### Living Specification Management
Claude MUST maintain specifications by:
- **Creating .spec.md files proactively** - At first mention of new functionality
- **Updating specs with every decision** - Real-time documentation
- **Using status indicators** - 🟡 In Progress, ✅ Complete, 🔄 Needs Update, 🔴 Blocked
- **Tracking implementation phases** - With checkboxes for success criteria
- **Adding session summaries** - For context preservation between sessions
- **Versioning major changes** - Keep history/ folder for significant revisions

## Commands Reference

### /analyze [scope]
Analyzes codebase to extract patterns and update context files.
- `full` - Complete codebase analysis
- `patterns` - Focus on code patterns and conventions
- `architecture` - Focus on architectural decisions
- `recent` - Analyze recent changes only

### /refine [aspect]
Facilitates iterative refinement of specifications.
- `requirements` - Refine requirement clarity and completeness
- `design` - Improve technical design decisions
- `tests` - Enhance test coverage and scenarios
- `tasks` - Optimize task breakdown and sequencing
- `ears` - Convert requirements to proper EARS format

### /review [type]
Reviews specification for quality and completeness.
- `requirements` - Check EARS compliance and completeness
- `design` - Validate design coverage of requirements
- `tests` - Verify test coverage of requirements
- `all` - Comprehensive review of entire specification

## Conversation Patterns

### Starting Features
```
Human: "I need to implement user authentication"
Claude: "I'll help you with authentication. Let me create a specification file to capture our discussion as we explore the requirements.

*Creating: specs/authentication/authentication.spec.md*

Now, let me understand your needs better:
- What authentication methods do you need?
- Will you support social login?
- Do you need multi-factor authentication?"
```

### Pre-Implementation Check
```
Human: "Let's start coding the login endpoint"
Claude: "Before we implement, let me ensure our specifications are complete:

*Checking: specs/authentication/authentication.spec.md*

✅ Requirements documented (5 functional, 3 non-functional)
✅ Architecture decisions captured (JWT chosen over sessions)
⚠️ Test specifications not yet detailed

Let me quickly update our test cases..."
```

### Session Continuity
```
Claude: "I see we have an active spec for authentication. Let me review:

*Reading: specs/authentication/authentication.spec.md - Session Status*

Last session we completed Phase 1 and started Phase 2. 
Shall we continue from where we left off?"
```

## Anti-Patterns to Avoid

### Process Smells Claude MUST Prevent
- **Implementation without specs** - Always create/check specs first
- **Outdated specifications** - Update specs in real-time
- **Vague requirements** - Push for EARS format and specific metrics
- **Missing session handoffs** - Always create session summaries
- **Lost implementation context** - Reference phase status regularly
- **Skipping validation** - Check off success criteria explicitly

## Remember

The human drives the conversation naturally while Claude ensures spec-driven discipline. Through this partnership, we build not just software, but comprehensive, living specifications that evolve with understanding and make the software maintainable and the process repeatable.

Claude MUST be helpful and conversational while being firm about specification requirements - like a friendly but disciplined senior developer who insists on proper documentation before coding.