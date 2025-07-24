# Context-Driven Spec Development for Claude Code

A conversational methodology for building software through comprehensive specifications, designed for Claude Code's natural dialogue capabilities. Inspired by [Kiro](https://kiro.dev) and this [project by @marcelsud](https://github.com/marcelsud/spec-driven-agentic-development). Unlike that project, however, this framework attempts to find a middle-ground oriented around a conversation-based approach to spec-driven development rather than a command-based one.

_( I don't know if this approach is better, but my goal is to use both @marcelsud's and this one and compare them by logging usage and gathering metrics with [this tool](https://github.com/benjamin-rood/claude-code-dev-logger) )_

## 🎯 Philosophy

I have effectively been using a soft type of  [Spec-Driven Development](https://www.researchgate.net/publication/221592745_Agile_Specification-Driven_Development) with Claude since Autumn 2024 without knowing the proper terminology for it. With the public announcement of Kiro in July 2025 I had the concrete definition of the methodology I had intuitively found worked for me.

This framework treats Claude Code as a thinking partner rather than a command executor. Instead of rigid phases and commands, it emphasizes:

- **Continuous Context**: Understanding builds throughout the conversation
- **Natural Dialogue**: Work with Claude like a senior colleague
- **Iterative Refinement**: Specifications evolve with understanding
- **Flexible Process**: Adapt to your project's needs

## 🚀 Quick Start

### 1. Install the Framework

```bash
# Clone the repository
git clone https://github.com/benjamin-rood/context-driven-sdad
cd context-driven-sdad

# Install globally (recommended)
./install.sh --global

# Or install for a specific project
cp -r .claude /path/to/your/project/
```

### 2. Start Your First Session

```bash
# Navigate to your project
cd your-project

# Start Claude Code
claude-code

# Initialize context
> Please read .claude/CLAUDE.md and PROJECT_CONTEXT.md to understand our approach
```

### 3. Develop Your First Feature

(Example conversation flow)
```
> Let's develop user authentication. First, help me understand what we need to consider.

> Based on our discussion, let's formalize these into EARS requirements.

> Now let's explore technical approaches for implementing these requirements.

> Can you create test specifications that cover all our requirements?

> Let's break this into implementation tasks we can tackle incrementally.
```

## 🎨 Key Features

### EARS Requirements Format

_( Preserves the use of EARS in [Spec-Driven Agentic Development](https://github.com/marcelsud/spec-driven-agentic-development) )_

Transform vague ideas into precise, testable requirements:

- **Ubiquitous**: "The system SHALL [always do this]"
- **Event-Driven**: "WHEN [this happens] THEN the system SHALL [do that]"
- **State-Driven**: "WHILE [in this state] the system SHALL [behave this way]"
- **Conditional**: "IF [this condition] THEN the system SHALL [handle it]"
- **Optional**: "WHERE [feature enabled] the system SHALL [add behavior]"

### Conversational Commands
Natural language commands that guide refinement:
- `/analyze` - Understand existing code patterns
- `/refine [aspect]` - Improve specifications through dialogue
- `/review` - Check quality and completeness

### Living Documentation
- Specifications evolve with understanding
- Context accumulates valuable project knowledge
- Decisions are traced and justified
- History shows how thinking evolved

## 🔄 Typical Workflow Example

Here's how a complete feature develops through conversation:

### 1. Initial Exploration
```
"Let's explore user authentication requirements"
→ Claude asks clarifying questions
→ You provide context and constraints
→ Understanding builds naturally
```

### 2. Requirements Evolution
```
"Based on our discussion, let's formalize these into EARS requirements"
→ Claude drafts requirements
→ You provide feedback
→ Requirements refine iteratively
→ Edge cases emerge through discussion
```

### 3. Design Through Dialogue
```
"Now let's design the technical solution"
→ Claude presents options with trade-offs
→ You make decisions together
→ Design evolves based on your feedback
→ Rationale is captured
```

### 4. Test-Driven Implementation
```
"Let's implement the login endpoint using TDD"
→ Claude writes failing tests first
→ You review test scenarios
→ Implementation follows tests
→ Refactoring maintains green tests
```

## 📚 Complete Example

See `EXAMPLE_WORKFLOW.md` for a full authentication feature showing:
- How context builds through questions
- Requirements evolving from discussion
- Design options explored together
- TDD implementation with guidance
- Continuous refinement without restarts

## 🛠️ Project Contents

```
.claude/
├── CLAUDE.md              # Core methodology (this framework)
├── PROJECT_CONTEXT.md     # Your project-specific context
├── context/               # Accumulated knowledge
│   ├── patterns.md        # Discovered code patterns
│   ├── decisions.md       # Architectural decisions
│   ├── glossary.md        # Domain terminology
│   └── conventions.md     # Coding standards
├── commands/              # Conversational commands
│   ├── analyze.md         # Codebase analysis
│   ├── refine.md          # Specification refinement
│   └── review.md          # Quality review
└── templates/             # Starting points
    ├── requirements-ears.md
    ├── design-iterative.md
    └── tasks-contextual.md
```

### Core Files
- **CLAUDE.md** - Instructs Claude on the conversational methodology
- **PROJECT_CONTEXT.md** - Template for your project-specific information
- **install.sh** - Easy installation script

### Commands (/commands)
- **analyze.md** - Extract patterns from existing code
- **refine.md** - Iteratively improve specifications
- **review.md** - Check quality and completeness

### Templates (/templates)
- **requirements-ears.md** - EARS-formatted requirements
- **design-iterative.md** - Evolving technical design
- **tasks-contextual.md** - Context-aware task breakdown

### Context Files (/context)
- **patterns.md** - Discovered code patterns
- **decisions.md** - Architectural decision record
- **glossary.md** - Domain terminology
- **conventions.md** - Coding standards

## 🚀 Getting Started

1. **Install the Framework**
   ```bash
   git clone https://github.com/benjamin-rood/context-driven-sdad
   cd context-driven-sdad
   ./install.sh --global  # or --project /path/to/project
   ```

2. **Start Claude Code**
   ```bash
   cd your-project
   claude
   ```

3. **Initialize Context**
   ```
   Please read .claude/CLAUDE.md and PROJECT_CONTEXT.md
   ```

4. **Begin Development**
   ```
   Let's explore requirements for [your feature]
   ```

## 🎓 Learning the Approach

The best way to understand context-driven development is to see it in action:

1. **Read EXAMPLE_WORKFLOW.md** - See a complete feature built conversationally
2. **Start Small** - Try a simple feature first
3. **Trust the Process** - Let understanding build naturally
4. **Iterate Freely** - Refine without starting over

## 🤝 When to Use This Approach

### Perfect For:
- Complex features requiring deep understanding
- Projects where requirements evolve
- Teams valuing documentation and rationale
- Developers who think through discussion

### Consider Alternatives When:
- You need rigid process compliance
- Requirements are completely fixed
- Simple CRUD operations only
- No need for documentation

## 📈 Benefits You'll Experience

1. **Better Requirements** - Emerge through exploration
2. **Clearer Designs** - Options discussed with trade-offs
3. **Living Documentation** - Stays current with code
4. **Preserved Knowledge** - Decisions and rationale captured
5. **Natural Workflow** - Like working with a senior colleague

## 🔗 Integration with Existing Projects

This methodology works with any:
- **Language**: Python, JavaScript, Go, etc.
- **Framework**: FastAPI, Express, Django, etc.
- **Architecture**: Monolith, microservices, serverless
- **Process**: Agile, waterfall, or hybrid

Simply adapt PROJECT_CONTEXT.md to your stack.

## 🤔 FAQ

**Q: How is this different from just chatting with Claude?**
A: It provides structure and methodology while preserving natural conversation. Specifications are built systematically but conversationally.

**Q: Can I use traditional commands too?**
A: Absolutely! The commands (analyze, refine, review) enhance conversation rather than replace it.

**Q: What if I need to comply with specific standards?**
A: Add your standards to PROJECT_CONTEXT.md and Claude will follow them throughout.

**Q: How do I handle large projects?**
A: Break into features, maintain an index in specs/, and reference context across features.

## 🙏 Contributing

This framework thrives on community input:
- Share your PROJECT_CONTEXT.md templates
- Contribute domain-specific EARS examples
- Add new conversational commands
- Share success stories and patterns

## 📝 License

MIT License - Use freely in your projects

---

## 💡 Example Conversations

### Starting a Feature
```
Human: I need to add payment processing to our app.

Claude: Let me understand your payment requirements better:
- What payment methods do you need to support?
- Will you process payments directly or use a provider?
- What currencies and regions do you need to handle?
- Do you need subscription support or just one-time payments?

Based on your answers, we'll build EARS requirements iteratively...
```

### Refining Requirements
```
Human: Users should be able to save payment methods for future use.

Claude: Let me formalize this into EARS requirements:
- WHEN a user successfully completes a payment THEN the system SHALL offer to save the payment method
- WHERE a user opts to save a payment method the system SHALL store a tokenized reference
- The system SHALL NOT store actual card numbers, only payment provider tokens
- IF a saved payment method fails THEN the system SHALL prompt for an alternative

Should we also consider:
- Maximum number of saved payment methods?
- Default payment method selection?
- PCI compliance requirements?
```

### Design Evolution
```
Claude: For payment processing, I see three architectural approaches:

1. **Direct Integration** with Stripe/PayPal
   - Pros: Full control, single vendor
   - Cons: Complex PCI compliance

2. **Payment Service Abstraction**
   - Pros: Provider flexibility, cleaner architecture
   - Cons: Additional complexity layer

3. **Hosted Checkout**
   - Pros: Minimal PCI scope, quick implementation
   - Cons: Less control over UX

Given your requirements for saving payment methods and quick implementation, 
I'd lean toward #1 with Stripe. Their vault handles tokenization securely.
What are your thoughts?
```

### Test-Driven Implementation
```
Human: Let's implement the payment creation endpoint using TDD.

Claude: Perfect! Let's start with the failing tests. Based on our requirements:

\```python
async def test_successful_payment_creates_charge():
    """WHEN valid payment data submitted THEN system SHALL create charge"""
    response = await client.post("/api/v1/payments", json={
        "amount": 2999,  # $29.99
        "currency": "USD",
        "payment_method_id": "pm_test_123"
    })
    
    assert response.status_code == 200
    assert response.json()["status"] == "succeeded"
    assert response.json()["amount"] == 2999

async def test_payment_failure_returns_error():
    """IF payment fails THEN system SHALL return clear error"""
    # Test implementation...
\```

Run these - they should fail. Now let's implement the minimal code to make them pass...
```

### Handling Context Loss
```
Human: Wait, what were our security requirements for payments again?

Claude: Looking back at our conversation, we established these security requirements:
- PCI DSS compliance through tokenization (never store raw card data)
- All payment data must be encrypted in transit (HTTPS only)
- Rate limiting: 10 payment attempts per user per hour
- Audit logging for all payment operations
- If suspicious activity detected, require additional verification

We also discussed using Stripe's vault for secure token storage. Should I show how these requirements affect our current implementation?
```

### Iterative Refinement
```
Human: The requirements look good, but I realized we need to handle partial refunds too.

Claude: Good catch! Let me add partial refund requirements to our specification:

**Existing requirement:**
- WHEN a refund is requested THEN the system SHALL process full refund

**Refined requirements:**
- WHEN a refund is requested THEN the system SHALL support both full and partial refunds
- IF partial refund amount exceeds original payment THEN the system SHALL reject with error
- The system SHALL track cumulative refunds per payment
- WHERE multiple partial refunds exist the system SHALL NOT exceed original amount

This changes our data model - we'll need a refunds table to track history. Should we also consider:
- Refund approval workflow?
- Time limits on refunds?
- Webhook handling for refund status updates?
```

### Discovery Through Implementation
```
Human: I'm implementing the webhook handler and realized Stripe can send duplicate events.

Claude: Excellent discovery! This is a critical issue. Let's update our requirements and design:

**New Requirements:**
- The system SHALL process each webhook event exactly once (idempotency)
- IF duplicate webhook received THEN the system SHALL return success without reprocessing
- The system SHALL store webhook event IDs with timestamps

**Implementation approach:**
\```python
class WebhookHandler:
    async def handle_stripe_event(self, event_id: str, event_data: dict):
        # Check if we've seen this event
        if await self.event_store.exists(event_id):
            return {"status": "already_processed"}
        
        # Process event...
        # Store event_id
\```

This is why iterative development works well - implementation reveals requirements!
```

### Context Building Over Time
```
Human: Now I need to add subscription support. Can we build on what we have?

Claude: Absolutely! Let's build on our existing payment infrastructure. From our previous work:

**What we can reuse:**
- Payment method tokenization and storage
- Security requirements (PCI compliance, encryption)
- Webhook handling with idempotency
- Error handling patterns

**New requirements for subscriptions:**
- WHEN a user subscribes THEN the system SHALL create recurring payment schedule
- The system SHALL support multiple subscription tiers
- WHERE subscription payment fails the system SHALL retry up to 3 times
- IF all retries fail THEN the system SHALL suspend subscription access
- WHEN subscription cancelled the system SHALL maintain access until period ends

**Design considerations:**
Since we chose Stripe, we can use their Subscription API which integrates with our existing payment methods. Should we:
1. Store subscription state locally and sync with Stripe?
2. Use Stripe as source of truth with webhooks?
3. Hybrid approach with caching?

Your thoughts on state management?
```

### Continuous Learning
```
Human: After testing, I noticed our payment processing is slow. Any ideas?

Claude: Let's analyze the payment flow based on what we've built:

Current flow:
1. Validate input (5ms)
2. Create Stripe payment intent (200ms) ← Bottleneck
3. Store in database (20ms)
4. Send confirmation email (150ms) ← Also slow

Optimization approaches:

**Quick wins:**
- Make email sending async - don't block payment response
- Pre-create payment intents for logged-in users

**Architectural changes:**
- Queue payment processing for better reliability
- Implement optimistic UI updates

Let me update our design to show the async approach:

\```python
async def create_payment(self, payment_data: PaymentCreate):
    # Process payment with Stripe
    charge = await self.stripe.create_charge(...)
    
    # Store in DB
    await self.db.save_payment(charge)
    
    # Queue email (don't await)
    await self.queue.send("send_payment_email", {
        "payment_id": charge.id,
        "user_email": payment_data.email
    })
    
    return charge  # Return immediately
\```

This maintains our requirements while improving performance. Should we also add performance requirements to our spec?
```

### End-of-Session Reflection
```
Human: I think we've made good progress on payments. What did we accomplish?

Claude: Great session! Here's what we built together:

**Requirements Developed:**
- ✅ Payment processing with PCI compliance
- ✅ Payment method storage and reuse
- ✅ Comprehensive error handling
- ✅ Refund support (full and partial)
- ✅ Webhook idempotency
- ✅ Subscription framework

**Key Decisions Made:**
- Chose Stripe for payment provider (tokenization, vault)
- Async email sending for performance
- Separate refunds table for audit trail
- Event-driven architecture for webhooks

**Patterns Established:**
- EARS requirements format
- TDD implementation approach
- Iterative refinement based on discoveries
- Performance optimization strategies

**Still To Do:**
- Implement subscription webhooks
- Add payment analytics
- Create admin dashboard
- Load test the payment endpoints

The specifications we created are living documents - they evolved as we discovered new requirements through implementation. This conversation becomes valuable context for future work on the payment system.

Ready to tackle subscriptions in our next session?
``