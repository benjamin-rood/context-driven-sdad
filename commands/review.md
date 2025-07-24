# /review - Specification Review Command

## Purpose
Reviews specifications for quality, completeness, and compliance with best practices.

## Usage
```
/review [type] [path]
```

Types:
- `requirements` - Check EARS compliance and completeness
- `design` - Validate design coverage of requirements
- `tests` - Verify test coverage of requirements
- `all` - Comprehensive review of entire specification

## Review Checklist

### Requirements Review
- [ ] All requirements use EARS format
- [ ] Each requirement is testable
- [ ] No ambiguous terms (e.g., "fast", "user-friendly")
- [ ] Error scenarios covered (If-Then)
- [ ] State behaviors defined (While)
- [ ] Optional features specified (Where)
- [ ] Performance metrics included
- [ ] Security requirements addressed

### Design Review
- [ ] All requirements have design elements
- [ ] Technology choices justified
- [ ] Integration points defined
- [ ] Error handling strategy clear
- [ ] Performance approach documented
- [ ] Security measures specified
- [ ] Scalability considered
- [ ] Migration plan included

### Test Review
- [ ] Each requirement maps to tests
- [ ] Edge cases covered
- [ ] Performance tests defined
- [ ] Integration tests planned
- [ ] Test data specified
- [ ] Acceptance criteria clear

## Review Process

1. **Structural Check**
   - Verify all sections present
   - Check formatting consistency
   - Ensure traceability links

2. **Content Analysis**
   - Identify ambiguities
   - Find missing scenarios
   - Check technical accuracy

3. **Compliance Verification**
   - EARS format compliance
   - Project standards alignment
   - Best practices adherence

4. **Gap Analysis**
   - Missing requirements
   - Uncovered edge cases
   - Integration gaps

## Output Format

```markdown
## Specification Review: [Type]

### Summary
- **Status**: [Pass/Needs Work]
- **Completeness**: [X]%
- **EARS Compliance**: [X]%
- **Critical Issues**: [Count]

### Findings

#### Strengths
- [What's done well]

#### Issues Found
1. **[Issue Category]**: [Description]
   - Location: [Where found]
   - Recommendation: [How to fix]

### Recommendations
[Prioritized list of improvements]

### Next Steps
[What to do after addressing issues]
```

## Example Interaction

```
Human: /review requirements authentication

Claude: I'll review the authentication requirements for quality and completeness.

## Specification Review: Requirements

### Summary
- **Status**: Needs Work
- **Completeness**: 75%
- **EARS Compliance**: 60%
- **Critical Issues**: 3

### Findings

#### Strengths
- Core login flow well defined
- Password complexity requirements specific
- Good use of If-Then for error cases

#### Issues Found

1. **Ambiguous Terms**: 
   - Location: Req #4 - "respond quickly"
   - Recommendation: Specify exact timing - "SHALL respond within 200ms"

2. **Missing Error Scenarios**:
   - Location: Password reset flow
   - Recommendation: Add "IF reset link already used THEN..."

3. **Incomplete State Coverage**:
   - Location: Session management
   - Recommendation: Add "WHILE session is expired..."

4. **No Performance Requirements**:
   - Location: Throughout
   - Recommendation: Add specific metrics for login, token refresh

### Recommendations
1. Convert all requirements to EARS format
2. Add specific timing requirements
3. Include session timeout scenarios
4. Add requirements for concurrent login handling
5. Specify audit logging requirements

Would you like me to help refine any of these areas?
```