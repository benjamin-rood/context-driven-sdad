# Context-Driven Spec Development for Claude Code

A conversational methodology for building software through comprehensive specifications, designed for Claude Code's natural dialogue capabilities. Inspired by [Kiro](https://kiro.dev) and this [project by @marcelsud](https://github.com/marcelsud/spec-driven-agentic-development). Unlike that project, however, this framework attempts to find a middle-ground oriented around a conversation-based approach to [spec-driven development](https://freedium.cfd/https://medium.com/@kittikawin_ball/spec-first-code-later-the-power-of-spec-driven-development-5d6270513cb3) rather than a command-based one.

_( I don't know if this approach is better, but my goal is to use both @marcelsud's and this one and compare them by logging usage and gathering metrics with [this tool](https://github.com/benjamin-rood/claude-code-dev-logger) )_

## 🎯 Philosophy

I have effectively been using a soft type of  [Spec-Driven Development](https://www.researchgate.net/publication/221592745_Agile_Specification-Driven_Development) with Claude since Autumn 2024 without knowing the proper terminology for it. With the public announcement of Kiro in July 2025 I had the concrete definition of the methodology I had intuitively found worked for me.

This framework treats Claude Code as a collaborative partner in a continuous conversation. Specifications evolve through dialogue, context accumulates naturally, and refinement happens organically without rigid phase gates. Claude acts as the disciplined partner who maintains methodology rigor while the human drives the conversation freely.

### Core Principles:
- **Proactive Spec Management**: Claude automatically creates and maintains `.spec.md` files in the `specs/` directory when features or changes are discussed
- **Critical Analysis & Review**: Systematic validation using sequential thinking for thorough evaluation
- **Continuous Context**: Understanding builds throughout the conversation
- **Natural Dialogue**: Work with Claude like a senior colleague who asks probing questions
- **Incremental Development**: Work in smallest possible chunks (1-2 hour blocks) with interactive feedback loops
- **Living Specifications**: Specifications continuously evolve with status indicators (🟡 In Progress, ✅ Complete, 🔄 Needs Update, 🔴 Blocked)
- **Session Continuity**: Progress tracking with implementation phases, checkboxes, and handoff summaries
- **Workflow Enforcement**: Requirements → Design → Tests → Implementation discipline with validation at each step

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

# Start Claude Code
claude

# Initialize your session with the new command
> /start
```

The `/start` command will automatically:
- Detect your installation type (global or standalone)
- Load the appropriate methodology and context files
- Display available commands and next steps
- Create the `specs/` directory if it doesn't exist
- Guide you through proper session initialization

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
- **Naming**: Feature-based directories with descriptive names (e.g., `specs/user-authentication/user-authentication.spec.md`)
- **Content**: Comprehensive template with status tracking, requirements, design decisions, and implementation phases
- **Updates**: Real-time as the conversation evolves

### Workflow Enforcement
Even in natural conversation, Claude maintains discipline with systematic analysis:

```
Human: "Let's code the login endpoint"
Claude: "Before we implement, let me do a thorough analysis to ensure we haven't missed anything important in this complex system.

*[Uses sequential thinking for systematic analysis]*

*Checking: specs/authentication/authentication.spec.md*

✅ Requirements documented (5 functional, 3 non-functional)
✅ Architecture decisions captured
⚠️ Test specifications need more detail
🔍 **Critical Analysis Findings**:
   - Login endpoint pattern differs from existing auth/session.py approach
   - JWT implementation needs alignment with existing token service in utils/jwt.py  
   - Error handling should follow the pattern used in api/errors.py
   - Rate limiting integration point with middleware/security.py not specified

Let me update our specification to address these systemic considerations before we implement..."
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

### Systematic Critical Analysis
Advanced validation capabilities for complex codebases:
- **Sequential Thinking**: Mandatory use of systematic analysis tools for all reviews
- **Systemic Impact Assessment**: Examines connected code beyond immediate changes
- **Pattern Consistency**: Validates alignment with existing architectural patterns
- **Specification Challenges**: Questions assumptions and completeness of requirements
- **Keyword Activation**: Automatically triggers analysis when "review", "check", "validate" mentioned

### Conversational Commands
Natural language commands that guide refinement with hierarchical override support:
- `/start` - Initialize context-driven development session with automatic setup detection
- `/analyze [scope]` - Understand existing code patterns  
- `/refine [aspect]` - Improve specifications through dialogue
- `/review [type]` - Systematic quality review using sequential thinking analysis
- `/uninstall [type]` - Remove framework installation (project/global/all)

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
→ Claude creates specs/user-authentication/user-authentication.spec.md
→ Claude asks clarifying questions
→ You provide context and constraints
→ Understanding builds naturally
```

### 2. Requirements Evolution
```
"Based on our discussion, let's formalize these into EARS requirements"
→ Claude drafts requirements in the spec file
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
→ Rationale is captured in the spec
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
- Spec files automatically created and maintained

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
│   ├── review.md         # Quality review
│   ├── start.md          # Session initialization
│   └── uninstall.md      # Framework removal
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
│   │   ├── review.md           # Quality review
│   │   ├── start.md            # Session initialization
│   │   └── uninstall.md        # Framework removal
│   └── templates/
│       ├── requirements_ears.md
│       ├── design-iterative.md
│       └── tasks_contextual.md
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
└── .claude/
    ├── PROJECT_CONTEXT.md      # Project context template
    ├── context/
    │   ├── patterns.md         # Code patterns (empty)
    │   ├── decisions.md        # Architectural decisions (empty)
    │   ├── glossary.md         # Domain terms (empty)
    │   └── conventions.md      # Coding standards (empty)
    ├── commands/               # Empty (for overrides)
    └── templates/              # Empty (for overrides)
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
│   │   ├── review.md           # Quality review
│   │   ├── start.md            # Session initialization
│   │   └── uninstall.md        # Framework removal
│   └── templates/
│       ├── requirements_ears.md
│       ├── design-iterative.md
│       └── tasks_contextual.md
```

### Start Development

```bash
# Start Claude Code
claude

# Initialize your session automatically
> /start

# Begin feature development  
> Let's explore requirements for [your feature]
```

The `/start` command automatically detects your installation type and loads the appropriate files, eliminating the need for manual initialization.

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
6. **Thorough Validation** - Systematic analysis prevents costly oversights in complex systems
7. **Natural Workflow** - Like working with a senior colleague who asks probing questions

## ⚙️ Customizing the Methodology

The SDD framework is designed to be adaptable to specific project needs while maintaining its core principles. You can customize the methodology by creating a local `.claude/METHODOLOGY.md` file that overrides the global methodology.

### When to Customize

Consider methodology customization when:
- **Project-specific requirements**: Your project has unique specification needs
- **Tool integration**: You need to integrate with specific project tools or workflows  
- **Team standards**: Your team has established conventions that differ from defaults
- **Domain constraints**: Your domain requires specific documentation or compliance formats

### How to Customize

#### 1. Create Local Methodology Override
```bash
# Copy global methodology as starting point
cp ~/.claude/METHODOLOGY.md .claude/METHODOLOGY.md

# Or create from scratch
touch .claude/METHODOLOGY.md
```

#### 2. Document Your Customizations
Always include a clear explanation of what you've changed and why:

```markdown
# Project-Specific Methodology Customization
*Local customization for [Your Project Name]*

# Repository-Specific Customization

**IMPORTANT**: This project uses modified [specific aspect] to [reason].

## [Customization Name]

### Standard methodology uses:
[original behavior]

### This project uses:  
[modified behavior]

### Rationale for This Change
[Clear explanation of why this change is needed]
```

#### 3. Update Relevant Sections
Modify the specific sections that need changes while preserving the overall structure and core principles.

### Real Example: Framework Development

This repository itself uses a customized methodology. Here's how we adapted it:

**Customization**: You might want to change specification location for specific needs

**Rationale**: 
- **Organization**: Keep specs in a different location based on project structure
- **Integration**: Align with existing documentation systems
- **Compliance**: Meet specific regulatory or organizational requirements

**Implementation Example**:

```markdown
### Specification File Structure

For any feature discussion, Claude MUST automatically create:

custom-docs/specs/
└── [feature-name]/
    ├── [feature-name].spec.md     # Comprehensive specification
    └── history/                   # Optional: significant versions
```


### Best Practices for Customization

#### Document the "Why"
- Always explain the business or technical reason for changes
- Reference specific project constraints or requirements
- Include examples showing how the customization improves your workflow

#### Preserve Core Principles  
- Keep EARS requirements format
- Maintain proactive specification management
- Preserve conversational development approach
- Continue using living documentation practices

#### Test Your Changes
- Verify Claude understands your customizations
- Test the modified workflow with actual features
- Document any issues or refinements needed

#### Version Control Your Methodology
- Commit `.claude/METHODOLOGY.md` to your repository
- Track changes over time as your project evolves
- Share learnings with the SDD community

### Other Suggested Customizations

#### Custom Command Definitions
Override specific commands by creating local versions:
```bash
.claude/commands/analyze.md    # Override global analyze command
.claude/commands/review.md     # Override global review command
```

#### Custom Templates
Create project-specific specification templates:
```bash
.claude/templates/api-spec.md      # API-specific specification template
.claude/templates/component.md     # Component specification template
```

#### Integration Hooks
Customize how specifications integrate with your tools:
- CI/CD pipeline integration
- Issue tracker synchronization  
- Documentation generation
- Code review processes

### Sharing Customizations

If your customization would benefit others:
- **Document the pattern** in community discussions
- **Create reusable templates** for similar project types
- **Contribute back** improvements to the core methodology
- **Share success stories** showing the customization's value

Remember: Customization should enhance the methodology's effectiveness for your specific context while preserving its collaborative, conversational nature.

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

**Q: Where are specifications stored?**
A: All specifications are automatically created in the `specs/` directory at your project root. Each feature gets its own subdirectory (e.g., `specs/user-authentication/user-authentication.spec.md`).

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

**Q: What's the recommended chunk size for implementation?**
A: Work in 1-2 hour implementation blocks. This aligns with the methodology's principle of incremental development with frequent validation points.

**Q: How does the critical analysis work?**
A: Claude automatically uses systematic thinking tools when reviewing work, examining connected code beyond immediate changes, validating against existing patterns, and challenging specification assumptions. This is particularly valuable in large codebases where local changes can have far-reaching impacts.

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