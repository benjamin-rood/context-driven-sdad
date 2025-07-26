# Context-Driven Spec Development for Claude Code

A conversational methodology for building software through comprehensive specifications, designed for Claude Code's natural dialogue capabilities. Inspired by [Kiro](https://kiro.dev) and this [project by @marcelsud](https://github.com/marcelsud/spec-driven-agentic-development). Unlike that project, however, this framework attempts to find a middle-ground oriented around a conversation-based approach to spec-driven development rather than a command-based one.

_( I don't know if this approach is better, but my goal is to use both @marcelsud's and this one and compare them by logging usage and gathering metrics with [this tool](https://github.com/benjamin-rood/claude-code-dev-logger) )_

## 🎯 Philosophy

I have effectively been using a soft type of  [Spec-Driven Development](https://www.researchgate.net/publication/221592745_Agile_Specification-Driven_Development) with Claude since Autumn 2024 without knowing the proper terminology for it. With the public announcement of Kiro in July 2025 I had the concrete definition of the methodology I had intuitively found worked for me.

This framework treats Claude Code as a collaborative partner who maintains spec-driven discipline while enabling natural conversation. Claude acts as the disciplined partner who ensures methodology rigor while you drive the conversation freely.

### Core Principles:
- **Proactive Spec Management**: Claude automatically creates and maintains `.spec.md` files
- **Continuous Context**: Understanding builds throughout the conversation
- **Natural Dialogue**: Work with Claude like a senior colleague
- **Incremental Development**: Work in smallest possible chunks with interactive feedback loops
- **Living Specifications**: Specifications continuously evolve and stay accurate
- **Session Continuity**: Progress tracking and handoffs between development sessions
- **Workflow Enforcement**: Requirements → Design → Tests → Implementation discipline

## 🚀 Quick Start

### 1. Install the Framework

```bash
# Clone the repository
git clone https://github.com/benjamin-rood/context-driven-sdad
cd context-driven-sdad

# Install globally (recommended for multiple projects)
./install_script.sh --global

# Then set up individual projects
./install_script.sh --project /path/to/your/project

# Or install standalone for a single project
./install_script.sh --project /path/to/your/project  # Includes everything needed
```

### 2. Start Your First Session

```bash
# Navigate to your project
cd your-project

# Use the initialization helper
./init-claude.sh

# Start Claude Code
claude

# Initialize context (commands vary based on installation)
> Please read ~/.claude/METHODOLOGY.md and .claude/PROJECT_CONTEXT.md  # Global install
> Please read .claude/METHODOLOGY.md and .claude/PROJECT_CONTEXT.md   # Standalone
```

### 3. Develop Your First Feature

(Example conversation flow with automatic spec management)
```
> Let's develop user authentication. First, help me understand what we need to consider.

→ Claude automatically creates specs/authentication/authentication.spec.md
→ Claude asks clarifying questions while updating the spec
→ Requirements emerge through dialogue and are captured in real-time

> Based on our discussion, let's formalize these into EARS requirements.

→ Claude converts discussion into EARS format in the spec file
→ You provide feedback and refinements
→ Spec file continuously updated with each decision

> Now let's explore technical approaches for implementing these requirements.

→ Claude presents options while documenting in Architecture Decisions
→ Design rationale captured as you make choices together
→ Implementation phases defined with success criteria

> Let's start implementing the login endpoint.

→ Claude checks spec completeness before coding
→ Implementation follows the documented phases
→ Progress tracked in spec file for session continuity
```

## 🔧 How Claude Manages Specifications

### Automatic Specification Creation
Claude proactively creates and maintains specifications without being asked:

- **Triggers**: Any mention of "implement", "build", "create", "add feature", "need", "want", "fix", "improve"
- **Location**: `specs/[feature-name]/[feature-name].spec.md`
- **Content**: Comprehensive template with status tracking, requirements, design decisions, and implementation phases
- **Updates**: Real-time as the conversation evolves

### Workflow Enforcement
Even in natural conversation, Claude maintains discipline:

```
Human: "Let's code the login endpoint"
Claude: "Before we implement, let me check our specifications...

*Checking: specs/authentication/authentication.spec.md*

✅ Requirements documented (5 functional, 3 non-functional)
✅ Architecture decisions captured
⚠️ Test specifications need more detail

Let me quickly update the test cases before we start coding."
```

### Session Continuity
Specs preserve context across development sessions:

- **Progress Tracking**: Implementation phases with checkboxes
- **Status Indicators**: 🟡 In Progress, ✅ Complete, 🔄 Needs Update, 🔴 Blocked  
- **Session Summaries**: What was accomplished, what's next
- **Context Handoffs**: Key information for resuming work

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
Natural language commands that guide refinement with hierarchical override support:
- `/analyze [scope]` - Understand existing code patterns  
- `/refine [aspect]` - Improve specifications through dialogue
- `/review [type]` - Check quality and completeness

Commands follow precedence: **project** → **global** → **built-in**

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

## 🛠️ Installation Architecture

The framework supports two installation modes with hierarchical override system:

### Global Installation (`~/.claude/`)
Shared methodology and tools for all projects:
```
~/.claude/
├── METHODOLOGY.md        # Core conversational methodology
├── CLAUDE.md             # Global Claude configuration
├── commands/             # Command definitions (can be overridden)
│   ├── analyze.md        # Codebase analysis
│   ├── refine.md         # Specification refinement
│   └── review.md         # Quality review
└── templates/            # Specification templates (can be overridden)
    ├── requirements_ears.md
    ├── design-iterative.md
    └── tasks_contextual.md
```

### Project Setup (`.claude/` + `specs/`)
Project-specific context and optional overrides:
```
project/
├── CLAUDE.md             # Project Claude configuration (methodology reference)
├── .claude/
│   ├── PROJECT_CONTEXT.md    # Project-specific information (always)
│   ├── context/              # Accumulated project knowledge (always)
│   │   ├── patterns.md       # Discovered code patterns
│   │   ├── decisions.md      # Architectural decisions
│   │   ├── glossary.md       # Domain terminology
│   │   └── conventions.md    # Coding standards
│   ├── commands/             # Command overrides (optional)
│   │   └── analyze.md        # Custom version supersedes global
│   └── templates/            # Template overrides (optional)
│       └── custom-spec.md    # Project-specific templates
└── specs/                    # Feature specifications (auto-created by Claude)
    ├── authentication/
    │   ├── authentication.spec.md  # Comprehensive specification
    │   └── history/                 # Optional: significant versions
    └── user-management/
        └── user-management.spec.md
```

### Hierarchical Override System
**Command Resolution Order:**
1. **Project-level** (`.claude/commands/`) - highest priority
2. **Global level** (`~/.claude/commands/`) - fallback  
3. **Built-in behavior** - default

This allows safe experimentation and project-specific customization without affecting other projects.

## 🚀 Getting Started

The installation script shows exactly what files will be created before making any changes.

**💾 Existing CLAUDE.md Files:** If you already have a `CLAUDE.md` file in your project, the installer will:
- Create a backup (`.backup` extension) 
- **Move existing content to `.claude/PROJECT_CONTEXT.md`** (where project context belongs)
- Replace CLAUDE.md with framework methodology reference
- **Keep the backup file** for your safety (remove manually when satisfied)

This separation ensures CLAUDE.md contains methodology while PROJECT_CONTEXT.md contains your project-specific information.

### Option 1: Global + Project (Recommended)

**Step 1: Global Installation**
```bash
git clone https://github.com/benjamin-rood/context-driven-sdad
cd context-driven-sdad
./install_script.sh --global
```

**Files created:**
```
~/
├── .claude/
│   ├── METHODOLOGY.md          # Core conversational methodology
│   ├── CLAUDE.md               # Global configuration (updated)
│   ├── commands/
│   │   ├── analyze.md          # Codebase analysis
│   │   ├── refine.md           # Specification refinement
│   │   └── review.md           # Quality review
│   └── templates/
│       ├── requirements_ears.md
│       ├── design-iterative.md
│       └── tasks_contextual.md
└── uninstall-claude-sdd-global.sh
```

**Step 2: Project Setup**
```bash
./install_script.sh --project /path/to/your/project
cd /path/to/your/project
```

**Files created (minimal setup):**
```
your-project/
├── CLAUDE.md                   # Project Claude configuration
├── .claude/
│   ├── PROJECT_CONTEXT.md      # Project context template
│   ├── context/
│   │   ├── patterns.md         # Code patterns (empty)
│   │   ├── decisions.md        # Architectural decisions (empty)
│   │   ├── glossary.md         # Domain terms (empty)
│   │   └── conventions.md      # Coding standards (empty)
│   ├── commands/               # Empty (for overrides)
│   └── templates/              # Empty (for overrides)
├── init-claude.sh              # Session helper
└── uninstall-claude-sdd.sh
```

### Option 2: Standalone Project

```bash
git clone https://github.com/benjamin-rood/context-driven-sdad
cd context-driven-sdad
./install_script.sh --project /path/to/your/project
```

**Files created (complete setup):**
```
your-project/
├── CLAUDE.md                   # Project Claude configuration
├── .claude/
│   ├── METHODOLOGY.md          # Complete methodology (local)
│   ├── PROJECT_CONTEXT.md      # Project context template
│   ├── context/
│   │   ├── patterns.md         # Code patterns (empty)
│   │   ├── decisions.md        # Architectural decisions (empty)
│   │   ├── glossary.md         # Domain terms (empty)
│   │   └── conventions.md      # Coding standards (empty)
│   ├── commands/
│   │   ├── analyze.md          # Codebase analysis
│   │   ├── refine.md           # Specification refinement
│   │   └── review.md           # Quality review
│   └── templates/
│       ├── requirements_ears.md
│       ├── design-iterative.md
│       └── tasks_contextual.md
├── init-claude.sh              # Session helper
└── uninstall-claude-sdd.sh
```

### Start Development

```bash
# Use the helper script for guidance
./init-claude.sh

# Start Claude Code
claude

# Initialize context (path varies by installation type)
> Please read ~/.claude/METHODOLOGY.md and .claude/PROJECT_CONTEXT.md  # Global
> Please read .claude/METHODOLOGY.md and .claude/PROJECT_CONTEXT.md   # Standalone

# Begin feature development  
> Let's explore requirements for [your feature]
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

1. **Better Requirements** - Emerge through exploration and incremental validation
2. **Clearer Designs** - Options discussed with trade-offs in small chunks
3. **Living Documentation** - Specifications continuously updated as understanding evolves
4. **Reduced Risk** - Small incremental changes with immediate feedback loops
5. **Preserved Knowledge** - Decisions and rationale captured with architectural learnings
6. **Natural Workflow** - Like working with a senior colleague on bite-sized problems

## 🔗 Integration with Existing Projects

This methodology works with any:
- **Language**: Python, JavaScript, Go, etc.
- **Framework**: FastAPI, Express, Django, etc.
- **Architecture**: Monolith, microservices, serverless
- **Process**: Agile, waterfall, or hybrid

Simply adapt PROJECT_CONTEXT.md to your stack.

## 🤔 FAQ

**Q: How is this different from just chatting with Claude?**
A: Claude proactively maintains discipline by automatically creating specifications, enforcing workflow order (requirements → design → tests → implementation), and preserving context across sessions. It's like having a senior developer who insists on proper documentation while remaining conversational.

**Q: Will Claude automatically create specification files?**
A: Yes! Whenever you mention implementing, building, or creating features, Claude automatically creates comprehensive `.spec.md` files in the `specs/` directory and updates them throughout your conversation.

**Q: What if I just want to code without specs?**
A: Claude will gently redirect you to create specifications first, but remains helpful and conversational. The methodology is designed to feel natural while maintaining necessary discipline.

**Q: Should I use global or standalone installation?**
A: Global is recommended for multiple projects - it provides shared methodology with minimal per-project setup. Use standalone for single projects or when you can't modify `~/.claude/`.

**Q: How do command overrides work?**
A: Claude checks project-level commands first, then falls back to global, then built-in behavior. You can customize commands per project without affecting others.

**Q: What if I need to comply with specific standards?**
A: Add your standards to PROJECT_CONTEXT.md and Claude will follow them throughout. The specifications will reflect your compliance requirements.

**Q: How does session continuity work?**
A: Each specification includes session status updates, progress tracking with checkboxes, and handoff summaries. When you return, Claude reads the spec status and continues from where you left off.

**Q: How do I handle large projects?**
A: Break into features with separate spec files, maintain context in the `context/` directory, and reference accumulated knowledge. Each feature gets its own specification for focused development.

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

See [EXAMPLE_CONVERSATIONS.md](EXAMPLE_CONVERSATIONS.md) for detailed conversation examples showing:

- **Starting a Feature** - How requirements emerge through dialogue
- **Refining Requirements** - Converting ideas into EARS format
- **Design Evolution** - Exploring technical approaches together
- **Test-Driven Implementation** - Writing tests that capture requirements
- **Handling Context Loss** - Maintaining project knowledge across sessions
- **Iterative Refinement** - Evolving specifications based on discoveries
- **Discovery Through Implementation** - Learning that drives requirement updates
- **Context Building Over Time** - Reusing accumulated knowledge for new features
- **Continuous Learning** - Performance optimization through conversation
- **End-of-Session Reflection** - Summarizing progress and planning next steps

These examples demonstrate the natural flow of context-driven development, where specifications evolve through understanding rather than rigid planning phases.