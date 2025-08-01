# /upgrade-sdd - Framework Upgrade Command

## Purpose
Upgrades the Context-Driven Spec Development framework by fetching the latest version from GitHub and applying upgrades through conversational dialogue while preserving user customizations.

## Usage
```
/upgrade-sdd
```

## Process

### 1. Installation Detection
**First, detect the current installation type:**
- Check for global installation at `~/.claude/` (METHODOLOGY.md, commands/, templates/)
- Check for project installation at `.claude/` (PROJECT_CONTEXT.md, commands/, templates/)
- Report installation type and completeness

### 2. Fetch Latest Framework Files
**Use WebFetch to retrieve the latest files from GitHub repository:**

**Base URL**: `https://raw.githubusercontent.com/benjamin-rood/claude-spec-driven-agentic-development/main/`

**Required Files to Fetch:**
- `METHODOLOGY.md`
- `commands/analyze.md`
- `commands/refine.md` 
- `commands/review.md`
- `commands/start.md`
- `commands/uninstall.md`
- `templates/requirements_ears.md`
- `templates/design-iterative.md`
- `templates/tasks_contextual.md`

**Fetch each file using URLs like:**
```
https://raw.githubusercontent.com/benjamin-rood/claude-spec-driven-agentic-development/main/METHODOLOGY.md
https://raw.githubusercontent.com/benjamin-rood/claude-spec-driven-agentic-development/main/commands/analyze.md
etc.
```

### 3. Analyze Changes
**For each fetched file, compare with local version:**
- Read local file content (if exists)
- Compare with remote content using intelligent text analysis
- Identify differences: framework updates vs user customizations
- Categorize changes by impact: new features, enhancements, fixes

### 4. Present Upgrade Options
**Show the user what will be updated:**

```markdown
## 🔄 Framework Update Available

### Installation Analysis
- **Type**: [Global/Project/Mixed]
- **Current Version**: [Detected from file analysis]
- **Latest Version**: [From GitHub]

### Changes Summary
📝 **METHODOLOGY.md**: [Summary of changes]
⚡ **Commands**: [Number] new/updated commands
📋 **Templates**: [Number] updated templates

### Customizations Detected
✅ **Will be preserved**: 
- PROJECT_CONTEXT.md (your project information)
- Custom command overrides in .claude/commands/
- Custom templates in .claude/templates/
- All specifications in specs/ directories

⚠️ **Potential conflicts**:
[List any detected conflicts between updates and customizations]
```

### 5. User Choice Dialogue
**Present upgrade options:**
- **Full Upgrade**: Update all framework files while preserving customizations
- **Selective Upgrade**: Choose specific components to update
- **Dry Run**: Preview changes without applying them
- **Skip**: Cancel the upgrade process

### 6. Confirmation and Backup
**Before applying changes:**
- Create timestamped backups of files to be modified
- Show exactly what will be changed
- Ask for final confirmation

### 7. Apply Updates
**When user confirms:**
- Update framework files while preserving user content
- For files with customizations, merge updates surgically
- Validate each update was applied successfully

### 8. Completion Summary
**Provide comprehensive results:**
```markdown
## ✅ Upgrade Complete

### Files Updated
- [List of successfully updated files]

### Files Preserved  
- [List of user files that were kept unchanged]

### New Features Available
- [Highlight new capabilities from the update]

### Next Steps
- Run `/start` to reinitialize with latest methodology
- Check updated command help with `/analyze -h`, etc.
- Review METHODOLOGY.md for any new best practices
```

## Error Handling

### Network Failures
- If GitHub is unreachable, explain the situation and suggest retrying later
- Provide fallback option to specify alternative source URLs
- Handle partial failures gracefully

### File Conflicts
- If user customizations conflict with framework updates, present options:
  - Keep user version (skip framework update)
  - Keep framework version (lose user customization)  
  - Manual merge (show both versions for user decision)

### Permission Issues
- If files cannot be written, explain required permissions
- Suggest alternative approaches (different installation location)

## Implementation Notes

**For Claude to execute this command:**
1. Use WebFetch tool to retrieve all required files from GitHub
2. Use file read operations to compare with local installations
3. Use intelligent text analysis to identify meaningful changes
4. Present information using clear formatting and visual indicators
5. Guide user through decisions using natural conversation
6. Apply changes using file write operations with backups
7. Validate results and provide comprehensive feedback

**Safety Measures:**
- Always create backups before modifying files
- Never overwrite PROJECT_CONTEXT.md or user specifications
- Provide rollback capability if upgrade fails
- Use read-only operations first to validate before making changes
