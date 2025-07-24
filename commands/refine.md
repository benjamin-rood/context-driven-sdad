# /refine - Iterative Refinement Command

## Purpose
Facilitates focused refinement of specifications through guided conversation.

## Usage
```
/refine [aspect] [target]
```

Aspects:
- `requirements` - Refine requirement clarity and completeness
- `design` - Improve technical design decisions
- `tests` - Enhance test coverage and scenarios
- `tasks` - Optimize task breakdown and sequencing
- `ears` - Convert requirements to proper EARS format

## Process

### Requirements Refinement
1. Review existing requirements
2. Identify ambiguities or gaps
3. Check EARS compliance
4. Add missing scenarios
5. Clarify acceptance criteria

### Design Refinement
1. Validate requirement coverage
2. Explore alternative approaches
3. Address non-functional requirements
4. Consider edge cases
5. Document trade-offs

### Test Refinement
1. Map requirements to tests
2. Identify missing test cases
3. Add edge case tests
4. Specify test data needs
5. Define performance tests

## Refinement Patterns

### Clarity Check
```
"This requirement says 'fast response' - let's make it specific:
- What operation needs to be fast?
- What's the acceptable response time?
- Under what conditions?
Refined: 'The API SHALL return search results within 200ms for queries with fewer than 1000 matches'"
```

### Completeness Check
```
"I notice we handle the success case, but what about:
- Network failures?
- Invalid input?
- Concurrent requests?
Let's add If-Then requirements for these scenarios."
```

### EARS Transformation
```
Original: "Users must be able to log in"
Refined: "WHEN a user provides valid credentials THEN the system SHALL authenticate the user and return a session token"
```

## Example Interaction

```
Human: /refine requirements authentication

Claude: I'll help refine the authentication requirements. Let me review what we have:

Current requirements:
1. "Users can log in with email and password"
2. "System should be secure"
3. "Support password reset"

Let's refine these using EARS format and adding specificity:

1. WHEN a user submits valid email and password THEN the system SHALL authenticate and return a JWT token within 2 seconds

2. Security requirements need expansion:
   - The system SHALL hash passwords using bcrypt with cost factor 12
   - IF a user fails login 5 times within 10 minutes THEN the system SHALL lock the account for 30 minutes
   - The system SHALL enforce passwords with minimum 8 characters, including uppercase, lowercase, and numbers

3. Password reset flow:
   - WHEN a user requests password reset THEN the system SHALL send a reset link to the registered email
   - The reset link SHALL expire after 1 hour
   - IF an expired link is used THEN the system SHALL display "Link expired" error

What other scenarios should we cover? What about:
- Session timeout?
- Concurrent login handling?
- Social authentication?
```