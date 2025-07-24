# Example Workflow: Building User Authentication

This example demonstrates the context-driven approach to developing a complete feature with Claude Code.

## Starting the Conversation

### Human:
```
Please read .claude/CLAUDE.md and PROJECT_CONTEXT.md to understand our project and methodology.
```

### Claude:
```
I've read both files and understand:
- We're building a task management SaaS application
- Using Python/FastAPI with PostgreSQL
- Following context-driven spec development with EARS
- Emphasizing continuous conversation over rigid commands

I see we have REST API patterns established and JWT authentication is planned. Ready to explore your next feature using our conversational approach.
```

### Human:
```
Great! I need to implement user authentication. Let's start by exploring what this entails.
```

### Claude:
```
Let's explore user authentication for your task management system. I have several questions to understand your needs:

**Authentication Methods:**
- Just email/password, or do you need social login (Google, GitHub)?
- Any requirements for enterprise SSO?

**Security Requirements:**
- Do you need two-factor authentication?
- Any compliance requirements (SOC2, GDPR)?
- Password complexity rules?

**Session Management:**
- How long should sessions last?
- Support multiple concurrent sessions?
- Remember me functionality?

**User Experience:**
- Self-service password reset?
- Email verification for new accounts?
- Account lockout after failed attempts?

**Scale Considerations:**
- Expected number of users?
- Geographic distribution?
- Peak login times?

Let's discuss these to shape our requirements properly.
```

## Building Requirements

### Human:
```
Let's start simple: email/password only, with email verification and password reset. 
Sessions should last 24 hours with a remember me option for 30 days. 
We need basic security - password complexity and account lockout after 5 failed attempts.
Expected scale is ~10k users initially.
```

### Claude:
```
Perfect, that gives us a clear scope. Let me formalize these into EARS requirements, building them up conversationally:

## Core Authentication Requirements

**Basic Login:**
- WHEN a user submits valid email and password THEN the system SHALL authenticate the user and return a JWT token
- The JWT token SHALL contain user ID, email, and role claims
- The JWT token SHALL expire after 24 hours

**Password Security:**
- The system SHALL require passwords with minimum 8 characters, including at least one uppercase, one lowercase, one number
- The system SHALL hash passwords using bcrypt with cost factor 12
- IF a user enters incorrect credentials THEN the system SHALL NOT indicate whether email or password was wrong

**Account Lockout:**
- IF a user fails login 5 times within 10 minutes THEN the system SHALL lock the account for 30 minutes
- WHILE an account is locked the system SHALL return "Account temporarily locked" for any login attempt
- The system SHALL track failed attempts by email address, not IP

**Email Verification:**
- WHEN a new user registers THEN the system SHALL send a verification email within 2 minutes
- The verification link SHALL expire after 24 hours
- IF an unverified user attempts login THEN the system SHALL return "Please verify your email"

Should I continue with password reset and remember me? Any adjustments to these so far?
```

### Human:
```
These look good. One change - make the lockout by IP address instead of email to prevent attackers from locking out real users. Continue with the rest.
```

### Claude:
```
Good security thinking! Let me revise that and continue:

**Account Lockout (Revised):**
- IF an IP address fails login 5 times within 10 minutes THEN the system SHALL block login attempts from that IP for 30 minutes
- WHILE an IP is blocked the system SHALL return "Too many attempts. Please try again later"
- The system SHALL maintain a sliding window of attempts per IP

**Password Reset:**
- WHEN a user requests password reset THEN the system SHALL send a reset link to the registered email within 2 minutes
- The reset link SHALL contain a cryptographically secure token
- The reset token SHALL expire after 1 hour
- IF an expired reset link is used THEN the system SHALL display "This link has expired. Please request a new one"
- WHEN a password is successfully reset THEN the system SHALL invalidate all existing sessions for that user

**Remember Me:**
- WHERE a user selects "Remember me" during login the system SHALL issue a refresh token valid for 30 days
- The refresh token SHALL be stored as httpOnly, secure cookie
- WHEN a user's JWT expires AND they have a valid refresh token THEN the system SHALL automatically issue a new JWT
- IF a refresh token is used THEN the system SHALL issue a new refresh token (rotating tokens)

**Session Management:**
- The system SHALL allow users to view all active sessions
- WHEN a user logs out THEN the system SHALL invalidate both JWT and refresh token
- WHERE a user selects "Log out all devices" the system SHALL invalidate all tokens for that user

Any other scenarios we should cover? What about rate limiting for registration or password reset?
```

## Design Discussion

### Human:
```
Yes, add rate limiting. Also, I'm wondering about the technical approach. Should we build our own auth or use a library?
```

### Claude:
```
Let me add rate limiting requirements first:

**Rate Limiting:**
- The system SHALL limit registration to 5 attempts per IP address per hour
- The system SHALL limit password reset requests to 3 per email per hour
- IF rate limits are exceeded THEN the system SHALL return 429 status with retry-after header

Now for the technical approach - let's explore both options:

## Option 1: Build Custom Auth

**Pros:**
- Full control over implementation
- Exact fit for our requirements
- Learn the internals
- No external dependencies

**Cons:**
- More development time
- Security risks if we miss something
- Maintenance burden
- Need to implement token rotation, rate limiting, etc.

## Option 2: Use a Library (e.g., FastAPI-Users)

**Pros:**
- Battle-tested security
- Built-in features (verification, reset, etc.)
- Faster initial development
- Community support

**Cons:**
- May need customization
- Another dependency
- Might include unused features
- Learning curve for the library

## My Recommendation

Given your requirements and scale, I'd suggest a **hybrid approach**:
- Use `python-jose` for JWT handling (well-tested crypto)
- Use `passlib` for password hashing
- Build the business logic ourselves
- This gives us security for the critical parts while maintaining control

Would you like me to detail this architecture? Or do you prefer one of the pure approaches?
```

### Human:
```
I like the hybrid approach. Let's detail the architecture.
```

### Claude:
```
Excellent choice. Let me design the architecture for our hybrid authentication system:

## Authentication Architecture

### Component Overview

```
┌─────────────┐     ┌──────────────┐     ┌───────────────┐
│   FastAPI   │────▶│ Auth Service │────▶│  PostgreSQL   │
│  Endpoints  │     └──────────────┘     │               │
└─────────────┘            │              │  ┌─────────┐  │
                          │              │  │ users   │  │
                          ▼              │  │ sessions│  │
                    ┌──────────────┐     │  │ tokens  │  │
                    │ Rate Limiter │────▶│  │ ip_blocks│  │
                    │   (Redis)    │     │  └─────────┘  │
                    └──────────────┘     └───────────────┘
```

### Key Components

#### 1. Database Schema
```python
# Core tables we'll need
users:
  - id: UUID (primary key)
  - email: str (unique, indexed)
  - password_hash: str
  - is_verified: bool
  - created_at: timestamp
  - updated_at: timestamp

email_verifications:
  - token: str (primary key, indexed)
  - user_id: UUID (foreign key)
  - expires_at: timestamp

password_resets:
  - token: str (primary key, indexed)
  - user_id: UUID (foreign key)
  - expires_at: timestamp
  - used: bool

refresh_tokens:
  - token: str (primary key, indexed)
  - user_id: UUID (foreign key)
  - expires_at: timestamp
  - device_info: str (optional)
```

#### 2. Auth Service Layer
```python
class AuthService:
    """Core authentication logic"""
    
    async def register_user(email, password)
        # Validate email format
        # Check password complexity
        # Hash password with bcrypt
        # Create user record
        # Send verification email
        # Return user object
    
    async def verify_email(token)
        # Validate token
        # Check expiration
        # Mark user as verified
        # Delete token
    
    async def login(email, password, remember_me, ip_address)
        # Check IP rate limits
        # Verify credentials
        # Generate JWT (24hr)
        # Generate refresh token if remember_me (30d)
        # Record session
        # Return tokens
```

#### 3. Security Utilities
```python
# JWT Handler (using python-jose)
class JWTHandler:
    def create_access_token(user_id, email, role) -> str
    def verify_access_token(token) -> dict
    def create_refresh_token() -> str

# Password Handler (using passlib)
class PasswordHandler:
    def hash_password(password) -> str
    def verify_password(password, hash) -> bool
    def validate_complexity(password) -> bool

# Token Generator
def generate_secure_token() -> str:
    """For email verification and password reset"""
    return secrets.urlsafe_token()
```

#### 4. Rate Limiting (Redis)
```python
class RateLimiter:
    async def check_login_attempts(ip: str) -> bool
    async def record_login_attempt(ip: str)
    async def check_registration_limit(ip: str) -> bool
    async def check_password_reset_limit(email: str) -> bool
```

#### 5. API Endpoints
```python
# Public endpoints
POST   /api/v1/auth/register
POST   /api/v1/auth/login
POST   /api/v1/auth/logout
POST   /api/v1/auth/refresh
POST   /api/v1/auth/verify-email/{token}
POST   /api/v1/auth/forgot-password
POST   /api/v1/auth/reset-password
GET    /api/v1/auth/verify-token

# Protected endpoints
GET    /api/v1/auth/sessions
DELETE /api/v1/auth/sessions/all
```

### Security Decisions

1. **Token Storage**: 
   - JWT in memory/localStorage (client's choice)
   - Refresh token as httpOnly cookie

2. **Password Reset Flow**:
   - Never reveal if email exists
   - Same response time for existing/non-existing emails
   - Tokens are single-use

3. **Session Invalidation**:
   - JWTs can't be invalidated, so we keep them short (24hr)
   - Maintain a small blacklist for emergency invalidation

Does this architecture align with your vision? Should we dive deeper into any component?
```

## Implementation Planning

### Human:
```
This looks solid. Let's break this down into implementation tasks.
```

### Claude:
```
Let me break this down into implementation tasks, organized by testing approach and dependencies:

## Implementation Tasks

### Phase 1: Foundation (Days 1-2)

#### Task 1.1: Database Schema and Models
- **TDD Approach**: 
  - [ ] Write tests for User model validation
  - [ ] Write tests for database constraints
  - [ ] Implement SQLAlchemy models
  - [ ] Create Alembic migrations
- **Acceptance**: Schema deployed, all model tests passing

#### Task 1.2: Security Utilities
- **TDD Approach**:
  - [ ] Test password complexity validation
  - [ ] Test password hashing/verification
  - [ ] Test JWT creation and validation
  - [ ] Test secure token generation
- **Implementation**: PasswordHandler, JWTHandler, token generator
- **Acceptance**: 100% test coverage on security utilities

#### Task 1.3: Rate Limiting Setup
- **TDD Approach**:
  - [ ] Test Redis connection
  - [ ] Test sliding window counter
  - [ ] Test limit checking and recording
- **Implementation**: RateLimiter class with Redis
- **Acceptance**: Rate limiting working with tests

### Phase 2: Core Features (Days 3-5)

#### Task 2.1: User Registration
- **TDD Approach**:
  - [ ] Test successful registration flow
  - [ ] Test duplicate email handling
  - [ ] Test password validation
  - [ ] Test verification email sending
- **Implementation**: 
  - Register endpoint
  - Email service integration
  - Verification token generation
- **Acceptance**: Users can register and receive emails

#### Task 2.2: Email Verification
- **TDD Approach**:
  - [ ] Test valid token verification
  - [ ] Test expired token handling
  - [ ] Test already-used token
- **Implementation**: Verify endpoint and token management
- **Acceptance**: Email verification working end-to-end

#### Task 2.3: Login Flow
- **TDD Approach**:
  - [ ] Test successful login
  - [ ] Test invalid credentials
  - [ ] Test unverified user
  - [ ] Test IP-based lockout
- **Implementation**: Login endpoint with all security checks
- **Acceptance**: Secure login with rate limiting

### Phase 3: Advanced Features (Days 6-7)

#### Task 3.1: Remember Me & Token Refresh
- **TDD Approach**:
  - [ ] Test refresh token generation
  - [ ] Test token rotation
  - [ ] Test cookie handling
- **Implementation**: Refresh endpoint and token management
- **Acceptance**: Long-lived sessions working

#### Task 3.2: Password Reset
- **TDD Approach**:
  - [ ] Test reset request flow
  - [ ] Test token validation
  - [ ] Test password update
  - [ ] Test session invalidation
- **Implementation**: Forgot/reset password endpoints
- **Acceptance**: Complete password reset flow

#### Task 3.3: Session Management
- **TDD Approach**:
  - [ ] Test listing active sessions
  - [ ] Test logout single session
  - [ ] Test logout all sessions
- **Implementation**: Session endpoints and tracking
- **Acceptance**: Users can manage their sessions

### Phase 4: Polish (Day 8)

#### Task 4.1: Error Handling & Logging
- Consistent error responses
- Structured logging for security events
- Audit trail for sensitive operations

#### Task 4.2: Performance Optimization
- Database query optimization
- Redis connection pooling
- Response time validation

#### Task 4.3: Documentation
- API documentation with examples
- Security considerations guide
- Deployment instructions

### Key Decision Points

1. **After Task 1.3**: Verify Redis is the right choice for rate limiting
2. **After Task 2.1**: Confirm email service is working reliably
3. **After Task 2.3**: Load test the login endpoint

### Testing Strategy Notes

For each endpoint, we'll write:
1. Unit tests for service methods
2. Integration tests for API endpoints
3. End-to-end tests for complete flows

Example for login:
```python
# Unit test
async def test_validate_credentials_success():
    # Test service method in isolation

# Integration test  
async def test_login_endpoint_returns_jwt():
    # Test API endpoint with mocked dependencies

# E2E test
async def test_complete_login_flow():
    # Test from registration through login
```

Would you like me to detail any specific task further? Or shall we start with implementing Task 1.1?
```

## Starting Implementation

### Human:
```
This is great. Let's start implementing Task 1.1. Can you guide me through the TDD approach?
```

### Claude:
```
Absolutely! Let's start with TDD for the database schema and models. I'll guide you through the red-green-refactor cycle.

## Task 1.1: Database Schema and Models - TDD Approach

### Step 1: Write Our First Failing Test (RED)

Let's start with the User model. Create `tests/test_models.py`:

```python
import pytest
from datetime import datetime
from sqlalchemy.exc import IntegrityError
from app.models import User  # This doesn't exist yet!

class TestUserModel:
    
    async def test_user_creation_with_valid_data(self, db_session):
        """Test creating a user with all required fields"""
        user = User(
            email="test@example.com",
            password_hash="hashed_password_here",
            is_verified=False
        )
        
        db_session.add(user)
        await db_session.commit()
        
        assert user.id is not None  # UUID should be auto-generated
        assert user.email == "test@example.com"
        assert user.password_hash == "hashed_password_here"
        assert user.is_verified is False
        assert isinstance(user.created_at, datetime)
        assert isinstance(user.updated_at, datetime)
```

Run this test - it should fail because we haven't created the User model yet!

```bash
pytest tests/test_models.py::TestUserModel::test_user_creation_with_valid_data -v
```

### Step 2: Write Minimal Code to Pass (GREEN)

Now let's create the User model in `app/models.py`:

```python
from datetime import datetime
from uuid import uuid4
from sqlalchemy import Column, String, Boolean, DateTime
from sqlalchemy.dialects.postgresql import UUID
from app.database import Base

class User(Base):
    __tablename__ = "users"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    email = Column(String, nullable=False)
    password_hash = Column(String, nullable=False)
    is_verified = Column(Boolean, default=False, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
```

Run the test again - it should pass!

### Step 3: Add More Test Cases (RED again)

Before refactoring, let's add more test cases to ensure our model behaves correctly:

```python
async def test_user_email_must_be_unique(self, db_session):
    """Test that email addresses must be unique"""
    user1 = User(
        email="duplicate@example.com",
        password_hash="hash1"
    )
    user2 = User(
        email="duplicate@example.com",  # Same email!
        password_hash="hash2"
    )
    
    db_session.add(user1)
    await db_session.commit()
    
    db_session.add(user2)
    with pytest.raises(IntegrityError):
        await db_session.commit()

async def test_user_email_is_required(self, db_session):
    """Test that email is required"""
    user = User(
        password_hash="hash"
        # Missing email!
    )
    
    db_session.add(user)
    with pytest.raises(IntegrityError):
        await db_session.commit()
```

These tests will fail! We need to add constraints.

### Step 4: Update Model to Pass All Tests (GREEN)

Update the User model:

```python
class User(Base):
    __tablename__ = "users"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    email = Column(String, nullable=False, unique=True, index=True)  # Added unique & index
    password_hash = Column(String, nullable=False)
    is_verified = Column(Boolean, default=False, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
```

### Step 5: Refactor and Add More Models (REFACTOR)

Now let's add the other models we need, following the same pattern:

```python
# First, write tests for EmailVerification model
async def test_email_verification_creation(self, db_session):
    """Test creating email verification token"""
    user = await create_test_user(db_session)  # Helper function
    
    verification = EmailVerification(
        token="secure_token_123",
        user_id=user.id,
        expires_at=datetime.utcnow() + timedelta(hours=24)
    )
    
    db_session.add(verification)
    await db_session.commit()
    
    assert verification.token == "secure_token_123"
    assert verification.user_id == user.id
    assert verification.expires_at > datetime.utcnow()
```

Then implement:

```python
class EmailVerification(Base):
    __tablename__ = "email_verifications"
    
    token = Column(String, primary_key=True, index=True)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    expires_at = Column(DateTime, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    
    # Relationship
    user = relationship("User", back_populates="email_verifications")
```

### Next Steps

1. Continue with PasswordReset and RefreshToken models
2. Write tests for model relationships
3. Create Alembic migrations
4. Test database constraints at the database level

Would you like me to continue with the next model, or shall we create the Alembic migration for what we have so far?
```

## Continuing the Conversation

This example demonstrates how the context-driven approach:
- Builds understanding through questions
- Iteratively refines requirements
- Explores design options together
- Maintains context throughout
- Guides implementation with TDD
- Adapts based on feedback

The conversation would continue naturally, building on the established context and decisions, without needing to restart or lose understanding between phases.