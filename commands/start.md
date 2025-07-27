# /start - Initialize Context-Driven Spec Development Session

## Purpose
Initializes a Claude Code session with Context-Driven Spec Development methodology and provides setup guidance based on detected installation type.

## Usage
```
/start
```

## Process

1. **Detect Installation Type**
   - Check for global methodology (`~/.claude/METHODOLOGY.md`, `~/.claude/commands/`, `~/.claude/templates/`)
   - Check for standalone project setup (`.claude/METHODOLOGY.md`)
   - Verify project context (`.claude/PROJECT_CONTEXT.md`)

2. **Load Appropriate Context Files**
   - **Global + Project**: Read `~/.claude/METHODOLOGY.md` and `.claude/PROJECT_CONTEXT.md`
   - **Standalone**: Read `.claude/METHODOLOGY.md` and `.claude/PROJECT_CONTEXT.md`
   - Load accumulated knowledge from context files

3. **Display Session Guidance**
   - Show detected configuration
   - List available commands
   - Provide next steps for development

## Detection Logic

```
IF ~/.claude/METHODOLOGY.md AND ~/.claude/commands/ AND ~/.claude/templates/ exist:
    THEN "Global installation detected"
    LOAD ~/.claude/METHODOLOGY.md
ELSE IF .claude/METHODOLOGY.md exists:
    THEN "Standalone installation detected"  
    LOAD .claude/METHODOLOGY.md
ELSE:
    THEN "No SDD installation found"
    PROVIDE setup instructions
```

## Output Format

### Global Installation Detected
```markdown
🚀 Context-Driven Spec Development Session Initialized

## Configuration
- **Installation Type**: Global methodology with project context
- **Methodology Source**: ~/.claude/METHODOLOGY.md ✅
- **Project Context**: .claude/PROJECT_CONTEXT.md ✅
- **Specifications**: [Number] existing specs found

## Session Ready
Start your session with:
> "Please read ~/.claude/METHODOLOGY.md and .claude/PROJECT_CONTEXT.md"

Then begin feature development with:
> "Let's explore requirements for [feature]"
```

### Standalone Installation Detected
```markdown
🚀 Context-Driven Spec Development Session Initialized

## Configuration  
- **Installation Type**: Standalone project setup
- **Methodology Source**: .claude/METHODOLOGY.md ✅
- **Project Context**: .claude/PROJECT_CONTEXT.md ✅
- **Specifications**: [Number] existing specs found

## Session Ready
Start your session with:
> "Please read .claude/METHODOLOGY.md and .claude/PROJECT_CONTEXT.md"

Then begin feature development with:
> "Let's explore requirements for [feature]"
```

### No Installation Found
```markdown
❌ Context-Driven Spec Development Not Installed

## Setup Required
No SDD framework detected. To install:

1. **Global Installation** (recommended):
   ```bash
   ./install_script.sh --global
   ./install_script.sh --project .
   ```

2. **Standalone Installation**:
   ```bash
   ./install_script.sh --project .
   ```

Run the installer first, then use /start to initialize your session.
```

## Available Commands
(Shown after successful initialization)
- `/analyze [scope]` - Analyze codebase patterns
- `/refine [aspect]` - Refine specifications  
- `/review [type]` - Review quality and completeness
- `/uninstall` - Remove SDD framework

## Implementation Notes

This command should:
- Use file existence checks for accurate detection
- Read and summarize key methodology points
- Count existing specifications in specs/ directory
- Provide appropriate initialization guidance based on setup type
- Set clear expectations for the conversational development approach