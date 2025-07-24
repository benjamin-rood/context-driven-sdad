# Context-Driven Spec Development Methodology

This methodology guides AI-assisted development through conversational specification building, emphasizing continuous context, iterative refinement, and EARS-formatted requirements.

## Core Philosophy

Unlike command-based approaches, this methodology treats Claude as a collaborative partner in a continuous conversation. Specifications evolve through dialogue, context accumulates naturally, and refinement happens organically without rigid phase gates.

## Workflow Overview

### 1. Context Establishment
Begin each session by establishing comprehensive understanding:
```
"Please read the project context files and confirm your understanding of:
- Technical constraints and patterns
- Business domain and terminology  
- Quality standards and conventions
- Current specification state"
```

### 2. Specification Development Flow

#### 2.1 Feature Exploration
Start with understanding before specification:
- Explore the problem space through questions
- Identify edge cases and constraints
- Consider stakeholder perspectives
- Document assumptions for validation

#### 2.2 Requirements Evolution
Build requirements iteratively using EARS:
- Start with core functionality (ubiquitous requirements)
- Add behavioral requirements (When-Then)
- Include state-based requirements (While)
- Cover error scenarios (If-Then)
- Specify optional features (Where)

#### 2.3 Design Through Dialogue
Develop technical design conversationally:
- Propose multiple approaches
- Discuss trade-offs openly
- Refine based on feedback
- Document decisions and rationale

#### 2.4 Test Specification
Create comprehensive test strategies:
- Map each EARS requirement to test cases
- Define test data and fixtures
- Specify acceptance criteria
- Include performance benchmarks

#### 2.5 Task Planning
Break implementation into contextual tasks:
- Reference accumulated context
- Maintain requirement traceability
- Enable incremental delivery
- Support various implementation styles

## EARS Integration

### Format Templates
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
- Make requirements testable
- Avoid ambiguous terms
- Include specific metrics

### Example Evolution
Initial: "The system needs good performance"
Refined: "The API SHALL respond within 200ms for 95% of requests"
Further: "WHEN processing payments THEN the API SHALL respond within 500ms"

## Context Management

### Project Context Structure
```
.claude/
├── CLAUDE.md              # This methodology
├── PROJECT_CONTEXT.md     # Project-specific information
├── context/
│   ├── patterns.md        # Discovered patterns
│   ├── decisions.md       # Architectural decisions
│   ├── glossary.md        # Domain terminology
│   └── conventions.md     # Coding standards
└── commands/
    ├── analyze.md         # Codebase analysis
    ├── refine.md          # Iterative refinement
    └── review.md          # Specification review
```

### Context Preservation Strategies
1. **Summarize key decisions** at conversation milestones
2. **Update context files** with new understanding
3. **Reference previous discussions** when building on ideas
4. **Document rationale** for future reference

## Conversational Patterns

### Starting Features
```
Human: "I need to implement user authentication"
Claude: "Let me understand the requirements better. A few questions:
- What authentication methods do you need?
- Will you support social login?
- Do you need multi-factor authentication?
- What are your session management needs?"
```

### Refining Requirements
```
Human: "Users should be able to reset passwords"
Claude: "Let me formalize this with EARS:
- WHEN a user requests password reset THEN the system SHALL send a reset link via email
- The reset link SHALL expire after 24 hours
- IF an expired link is used THEN the system SHALL display an error message
Does this capture your intent? What about rate limiting?"
```

### Design Exploration
```
Claude: "For authentication, I see three architectural approaches:
1. JWT with refresh tokens - stateless, scalable
2. Session-based - simpler, server state
3. OAuth2 flow - complex but standard
Given your requirements for [context], I'd lean toward #1 because...
What are your thoughts?"
```

## Implementation Approaches

### Test-Driven Development (TDD)
When user prefers TDD:
1. Write failing tests from requirements
2. Implement minimal passing code
3. Refactor while maintaining green
4. Document learnings in context

### Exploratory Implementation
When exploring new territory:
1. Build proof of concept
2. Identify challenges
3. Refine requirements based on learnings
4. Rebuild with proper structure

### Collaborative Development
When working together:
1. Claude provides options
2. Human makes decisions
3. Implementation follows discussion
4. Context captures rationale

## Quality Practices

### Continuous Validation
- Confirm understanding before implementing
- Validate assumptions explicitly
- Test requirements for completeness
- Review designs for feasibility

### Iterative Refinement
- Start simple, add complexity
- Refactor based on learnings
- Update specs as understanding grows
- Maintain alignment with context

### Documentation as Conversation
- Specs tell the story of decisions
- Comments explain the "why"
- Tests demonstrate the "what"
- Context preserves the journey

## Advanced Techniques

### Multi-Feature Coordination
When features interact:
- Map dependencies explicitly
- Consider integration points
- Plan incremental integration
- Document interface contracts

### Legacy Integration
When working with existing code:
- Analyze current patterns
- Respect existing conventions
- Plan gradual migration
- Document deviations

### Performance Optimization
When addressing performance:
- Start with measurable requirements
- Profile before optimizing
- Document performance decisions
- Update requirements with findings

## Anti-Patterns to Avoid

### Specification Smells
- Vague requirements ("user-friendly", "fast")
- Missing error scenarios
- Untestable statements
- Assumed context

### Process Smells
- Jumping to implementation
- Ignoring context
- Breaking conversation flow
- Losing decision rationale

## Commands Reference

### /analyze
Analyzes codebase to extract patterns and update context

### /refine [aspect]
Facilitates iterative refinement of specifications

### /review [spec]
Reviews specification for EARS compliance and completeness

### /context [update]
Updates project context with new information

## Getting Started

1. **Establish Context**: "Please read CLAUDE.md and PROJECT_CONTEXT.md"
2. **Explore Feature**: "Let's discuss [feature] requirements"
3. **Build Specifications**: Through natural conversation
4. **Implement**: With continuous reference to context

## Key Differentiators

This methodology emphasizes:
- **Continuous context** over isolated commands
- **Natural dialogue** over rigid structure
- **Iterative discovery** over upfront planning
- **Preserved rationale** over just outcomes
- **Flexible adaptation** over fixed process

## Remember

The goal is not perfect specifications on first try, but rather specifications that evolve with understanding. Through conversation, we build not just software, but shared context that makes the software maintainable and the process repeatable.