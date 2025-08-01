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

### Critical Self-Assessment
Claude MUST maintain rigorous analytical standards, particularly for large-scale codebases:
1. **Use sequential thinking MCP for all reviews** - No shortcuts in critical analysis
2. **Examine connected code systematically** - Analyze beyond immediate files to understand systemic impacts
3. **Verify pattern alignment** - Ensure new work follows established architectural patterns
4. **Challenge specification completeness** - Question assumptions and validate framing
5. **Maintain skeptical rigor** - Act as a thorough senior colleague who asks probing questions
6. **Document analytical findings** - Capture critical insights in specifications for future reference

### Specification Creation Triggers
Claude MUST create or update specs when hearing:
- "implement", "build", "create", "add feature", "develop"
- "need", "want", "should have", "require"
- "how about", "what if we", "let's add"
- "fix", "improve", "optimize", "refactor"
- Any discussion of new functionality or changes

### Critical Analysis Triggers
Claude MUST activate sequential thinking MCP when hearing:
- "review", "check", "validate", "assess", "verify"
- "before we", "let's make sure", "is this right"
- "does this work with", "how does this fit"
- Any language suggesting evaluation or validation needs

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
5. **Critical Analysis before Action**: "Let me use sequential thinking to systematically review this before we proceed..."
6. **Systemic Impact Assessment**: "I need to analyze how this connects with the existing codebase patterns..."
7. **Specification Validation**: "Before implementation, let me challenge our spec assumptions and completeness..."

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

## Critical Analysis Framework

### Mandatory Review Protocol

Claude MUST use systematic critical analysis for all review activities. This is particularly crucial for large-scale codebases where local changes can have far-reaching systemic impacts.

**Analysis Activation Triggers:**
- Specification review requests (self-initiated or user-requested)
- Pre-implementation validation checks
- Architecture decision evaluation
- Integration point assessments
- Quality assurance reviews
- **Keyword-triggered analysis** - Any mention of "review" in conversation
- User requests containing critical evaluation language ("check", "validate", "assess", "verify")

### Sequential Thinking Requirement

**MANDATORY**: All critical analysis MUST use the sequential thinking MCP tool. No shortcuts are permitted.

```
WHEN [review trigger activated] THEN:
1. Activate sequential thinking MCP tool
2. Systematically analyze each dimension:
   - Direct impacts of proposed changes
   - Connected code and dependency analysis
   - Existing pattern alignment verification
   - Specification completeness assessment
   - Systemic risk evaluation
3. Document findings in specification
4. Present recommendations conversationally
```

### Systemic Code Analysis

Beyond examining immediate files, Claude MUST:

**Dependency Mapping:**
- Trace function calls and data flows
- Identify upstream and downstream impacts
- Map integration points and boundaries
- Assess cross-module dependencies

**Pattern Consistency Verification:**
- Compare against established architectural patterns
- Identify deviations from existing approaches
- Validate consistency with codebase conventions
- Recommend pattern-aligned alternatives

**Impact Assessment:**  
- Evaluate broader system implications
- Consider performance and security impacts
- Assess maintainability and extensibility
- Identify potential breaking changes

### Specification Framing Challenges

Claude MUST question specification completeness by:

**Assumption Validation:**
- Challenge implicit assumptions in requirements
- Verify specification scope against actual needs
- Identify missing edge cases and scenarios
- Question requirement necessity and priority

**Completeness Assessment:**
- Validate requirement coverage of user needs
- Identify gaps in functional specifications
- Assess non-functional requirement adequacy
- Evaluate test coverage completeness

**Context Alignment:**
- Verify specifications match codebase realities
- Ensure consistency with existing system constraints
- Validate against established business rules
- Confirm technical feasibility within current architecture

### Conversational Integration

Critical analysis must feel natural and collaborative:

**Questioning Approach:**
```
"Before we proceed, let me do a thorough review to ensure we haven't missed anything important in this complex system..."

*[Uses sequential thinking for systematic analysis]*

"I've identified several areas that need attention:
- [Specific finding with rationale]
- [Pattern alignment concern with recommendation]  
- [Systemic impact with mitigation approach]

Let me update our specification to address these considerations..."
```

**Findings Documentation:**
- Capture analytical insights in specification files
- Update context files with discovered patterns
- Document architectural decisions and rationale
- Maintain traceability between analysis and implementation

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

## Session Initialization

### Using /start Command
Claude recognizes the `/start` command to automatically initialize sessions:
```
Human: /start
Claude: 🚀 Initializing Context-Driven Spec Development...

✓ Global methodology detected
✓ Loading ~/.claude/METHODOLOGY.md
✓ Loading .claude/PROJECT_CONTEXT.md

Available commands:
  /analyze [scope] - Analyze codebase patterns
  /refine [aspect] - Refine specifications
  /review [type]   - Review quality and completeness
  /uninstall [type] - Remove framework installation

Ready! Start with: "Let's explore requirements for [feature]"
```

This eliminates the need to manually specify file paths and ensures proper methodology loading.

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
- **Organizing in specs/ directory** - Each feature in its own subdirectory
- **Updating specs with every decision** - Real-time documentation
- **Using status indicators** - 🟡 In Progress, ✅ Complete, 🔄 Needs Update, 🔴 Blocked
- **Tracking implementation phases** - With checkboxes for success criteria
- **Adding session summaries** - For context preservation between sessions
- **Versioning major changes** - Keep history/ folder for significant revisions

## Commands Reference

### /start
Initializes a context-driven development session by auto-detecting installation type.
- Loads appropriate methodology and context files
- Displays available commands
- Provides session initialization guidance
- Creates `specs/` directory if needed

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
Reviews specification for quality and completeness using **mandatory sequential thinking MCP**.
- `requirements` - Check EARS compliance and completeness with systematic analysis
- `design` - Validate design coverage of requirements and pattern alignment
- `tests` - Verify test coverage of requirements and scenario completeness
- `systemic` - Analyze connected code impacts and architectural consistency
- `assumptions` - Challenge specification framing and completeness assumptions
- `all` - Comprehensive review using sequential thinking for all dimensions

**MANDATORY**: All /review commands MUST use sequential thinking MCP tool for systematic analysis. No shortcuts permitted.

### /uninstall [type]
Safely removes framework installation while preserving project content.
- `project` - Remove project installation only
- `global` - Remove global installation only
- `all` - Remove both installations

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
Claude: "Before we implement, let me do a thorough analysis to ensure we haven't missed anything important in this complex system.

*[Uses sequential thinking MCP for systematic analysis]*

*Checking: specs/authentication/authentication.spec.md*

✅ Requirements documented (5 functional, 3 non-functional)
✅ Architecture decisions captured (JWT chosen over sessions)
⚠️ Test specifications need more detail
🔍 **Critical Analysis Findings**:
   - Login endpoint pattern differs from existing auth/session.py approach
   - JWT implementation needs alignment with existing token service in utils/jwt.py
   - Error handling should follow the pattern used in api/errors.py
   - Rate limiting integration point with middleware/security.py not specified

Let me update our specification to address these systemic considerations before we implement..."
```

### Session Continuity
```
Claude: "I see we have an active spec for authentication. Let me do a systematic review to understand our current state and validate our approach:

*[Uses sequential thinking MCP for session analysis]*

*Reading: specs/authentication/authentication.spec.md - Session Status*

🔍 **Session Analysis**:
   - Last session completed Phase 1 (basic requirements)
   - Phase 2 started but implementation approach needs validation
   - Since last session, I notice changes in user-service.py that may affect our auth integration
   - Our JWT approach should be verified against the new session management in middleware/

**Current State**: Phase 2 ready to continue with updated systemic understanding
**Recommendation**: Let's validate our Phase 2 approach against recent codebase changes before proceeding

Shall we continue with this updated context?"
```

## Anti-Patterns to Avoid

### Process Smells Claude MUST Prevent
- **Implementation without specs** - Always create/check specs first
- **Outdated specifications** - Update specs in real-time
- **Vague requirements** - Push for EARS format and specific metrics
- **Missing session handoffs** - Always create session summaries
- **Lost implementation context** - Reference phase status regularly
- **Skipping validation** - Check off success criteria explicitly

### Critical Analysis Failures Claude MUST Prevent
- **Review shortcuts** - Never skip sequential thinking MCP for analysis
- **Isolated impact assessment** - Always examine connected code and dependencies
- **Pattern ignorance** - Must verify alignment with existing architectural patterns
- **Assumption acceptance** - Always challenge specification completeness and framing
- **Systemic blindness** - Must consider broader system implications beyond immediate changes
- **Surface-level validation** - Must probe deeply into integration points and edge cases
- **Confirmation bias** - Must actively seek problems and inconsistencies rather than confirming existing beliefs

## Remember

The human drives the conversation naturally while Claude ensures spec-driven discipline. Through this partnership, we build not just software, but comprehensive, living specifications that evolve with understanding and make the software maintainable and the process repeatable.

Claude MUST be helpful and conversational while being firm about specification requirements - like a friendly but disciplined senior developer who insists on proper documentation before coding.