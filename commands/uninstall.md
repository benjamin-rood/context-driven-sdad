# /uninstall - Remove Context-Driven Spec Development Framework

## Purpose
Removes the Context-Driven Spec Development framework installation with user confirmation and safety checks.

## Usage
```
/uninstall [type]
```

Types:
- `project` - Remove only project-level installation (default)
- `global` - Remove global methodology installation
- `all` - Remove both global and project installations

## Process

1. **Detect Current Installation**
   - Check for global installation (`~/.claude/`)
   - Check for project installation (`.claude/`)
   - Identify what can be safely removed

2. **Confirm Removal Scope**
   - Show what will be removed
   - Request explicit user confirmation
   - Warn about data loss implications

3. **Execute Removal**
   - Remove specified components
   - Preserve user data where possible
   - Provide completion confirmation

## Detection and Removal Logic

### Project Removal (Default)
```
IF .claude/ directory exists:
    REMOVE .claude/ directory
    PRESERVE specs/ directory (user specifications)
    RESTORE CLAUDE.md.backup if it exists
ELSE:
    NOTIFY no project installation found
```

### Global Removal
```
IF ~/.claude/METHODOLOGY.md exists AND user confirms:
    REMOVE ~/.claude/ directory entirely
    WARN about impact on other projects
ELSE:
    NOTIFY no global installation found or user cancelled
```

### Complete Removal (All)
```
EXECUTE project removal
EXECUTE global removal
VERIFY all SDD components removed
```

## Output Format

### Project Removal
```markdown
🗑️ Removing Context-Driven SDD Project Installation

## What will be removed:
- .claude/ directory and all contents
- Project-specific context files
- Local command and template overrides

## What will be preserved:
- specs/ directory (your specifications)
- CLAUDE.md.backup (if exists)

⚠️ This action cannot be undone.

Confirm removal? (y/N): [Wait for confirmation]

✅ Project installation removed successfully.
Your specifications in specs/ have been preserved.
```

### Global Removal
```markdown
🗑️ Removing Context-Driven SDD Global Installation

## What will be removed:
- ~/.claude/ directory and all contents
- Global methodology and templates
- Shared commands across all projects

⚠️ This will affect ALL projects using the global methodology.
⚠️ This action cannot be undone.

Confirm removal? (y/N): [Wait for confirmation]

✅ Global installation removed successfully.
Projects with standalone installations remain unaffected.
```

### No Installation Found
```markdown
ℹ️ No Context-Driven SDD Installation Found

No SDD framework components detected in:
- Current project (.claude/)
- Global installation (~/.claude/)

Nothing to remove.
```

## Safety Features

1. **Confirmation Required**: Always ask for explicit user confirmation
2. **Preserve User Data**: Keep specs/ directory and backup files
3. **Clear Communication**: Show exactly what will be removed
4. **Reversible When Possible**: Restore backup files if removal cancelled

## Example Interactions

```
Human: /uninstall

Claude: 🗑️ Context-Driven SDD Removal

Detected installations:
- ✅ Project installation (.claude/)
- ❌ No global installation

This will remove:
- .claude/ directory and all project context
- Local methodology and command overrides

This will preserve:
- specs/ directory (your specifications)
- CLAUDE.md.backup (if exists)

Type 'CONFIRM' to proceed with removal:
```

```
Human: /uninstall global

Claude: ⚠️ Global SDD Removal Warning

This will remove ~/.claude/ affecting ALL projects that use global methodology.

Projects with standalone installations will remain unaffected.

Type 'CONFIRM GLOBAL REMOVAL' to proceed:
```

## Implementation Notes

- Require explicit confirmation phrases for safety
- Check file existence before attempting removal
- Provide clear feedback about what was actually removed
- Handle permission errors gracefully
- Offer guidance for reinstallation if desired