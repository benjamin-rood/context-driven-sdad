#!/bin/bash

# Context-Driven Spec Development for Claude Code
# Installation Script

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default values
INSTALL_MODE="project"
FORCE=false
PROJECT_PATH="."

# Print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Show usage
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Options:
    --global            Install globally for all projects
    --project PATH      Install for specific project (default: current directory)
    --force            Overwrite existing files
    --help             Show this help message

Examples:
    $0 --global                    # Install globally
    $0 --project /path/to/project  # Install for specific project
    $0 --force                     # Overwrite existing installation
EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --global)
            INSTALL_MODE="global"
            shift
            ;;
        --project)
            INSTALL_MODE="project"
            PROJECT_PATH="$2"
            shift 2
            ;;
        --force)
            FORCE=true
            shift
            ;;
        --help)
            usage
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Determine installation path
if [[ "$INSTALL_MODE" == "global" ]]; then
    INSTALL_PATH="$HOME/.claude"
    print_info "Installing globally to $INSTALL_PATH"
else
    INSTALL_PATH="$PROJECT_PATH/.claude"
    print_info "Installing to project at $INSTALL_PATH"
fi

# Handle existing installation confirmation (only for project mode)
if [[ "$INSTALL_MODE" == "project" ]] && [[ -d "$INSTALL_PATH" ]] && [[ "$FORCE" == false ]]; then
    print_warning "Installation already exists at $INSTALL_PATH"
    read -p "Do you want to overwrite? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled"
        exit 0
    fi
fi

# Create directory structure
print_info "Creating directory structure..."
mkdir -p "$INSTALL_PATH"/{commands,context,templates}

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Always copy METHODOLOGY.md as separate file
print_info "Copying METHODOLOGY.md..."
cp "$SCRIPT_DIR/METHODOLOGY.md" "$INSTALL_PATH/"

# Handle CLAUDE.md - restructure with header and methodology reference
if [[ -f "$INSTALL_PATH/CLAUDE.md" ]]; then
    print_info "Existing CLAUDE.md found - restructuring with methodology reference..."
    
    # Check if it already has our header
    if ! grep -q "## Purpose and Intent" "$INSTALL_PATH/CLAUDE.md"; then
        # Backup existing content (skip if it already has our header)
        if grep -q "^# " "$INSTALL_PATH/CLAUDE.md"; then
            # Skip first heading and extract the rest
            sed -n '/^# /,$p' "$INSTALL_PATH/CLAUDE.md" | tail -n +2 > "$INSTALL_PATH/CLAUDE.md.backup"
        else
            # No heading, backup all content
            cp "$INSTALL_PATH/CLAUDE.md" "$INSTALL_PATH/CLAUDE.md.backup"
        fi
        
        # Create new CLAUDE.md with proper structure
        cat "$SCRIPT_DIR/claude_header_template.md" > "$INSTALL_PATH/CLAUDE.md"
        
        # Append existing content if any
        if [[ -f "$INSTALL_PATH/CLAUDE.md.backup" ]] && [[ -s "$INSTALL_PATH/CLAUDE.md.backup" ]]; then
            echo "" >> "$INSTALL_PATH/CLAUDE.md"
            echo "" >> "$INSTALL_PATH/CLAUDE.md"
            cat "$INSTALL_PATH/CLAUDE.md.backup" >> "$INSTALL_PATH/CLAUDE.md"
            rm "$INSTALL_PATH/CLAUDE.md.backup"
        fi
    else
        print_info "CLAUDE.md already has proper structure, updating methodology reference only..."
    fi
else
    print_info "Creating new CLAUDE.md with methodology reference..."
    cp "$SCRIPT_DIR/claude_header_template.md" "$INSTALL_PATH/CLAUDE.md"
fi

# Copy other files only if they don't exist or if force is used or if project mode
if [[ "$INSTALL_MODE" == "project" ]] || [[ "$FORCE" == true ]] || [[ ! -f "$INSTALL_PATH/PROJECT_CONTEXT.md" ]]; then
    print_info "Copying methodology files..."
    cp "$SCRIPT_DIR/PROJECT_CONTEXT.md" "$INSTALL_PATH/"
    
    print_info "Copying command files..."
    cp "$SCRIPT_DIR/commands/"*.md "$INSTALL_PATH/commands/" 2>/dev/null || true
    
    print_info "Copying template files..."
    cp "$SCRIPT_DIR/templates/"*.md "$INSTALL_PATH/templates/" 2>/dev/null || true
fi

# Create initial context files
print_info "Creating initial context files..."
cat > "$INSTALL_PATH/context/patterns.md" << 'EOF'
# Code Patterns

## Discovered Patterns
*This file will be updated as patterns are discovered in the codebase*

## Naming Conventions

## File Organization

## Common Abstractions

## Testing Patterns
EOF

cat > "$INSTALL_PATH/context/decisions.md" << 'EOF'
# Architectural Decisions

## Decision Log
*Record architectural decisions as they're made*

### Template:
**Date**: YYYY-MM-DD  
**Decision**: What was decided  
**Context**: Why this decision was needed  
**Consequences**: What this means for the project  
**Alternatives**: What else was considered  
EOF

cat > "$INSTALL_PATH/context/glossary.md" << 'EOF'
# Domain Glossary

## Business Terms
*Define domain-specific terminology here*

## Technical Terms
*Define project-specific technical terms*

## Abbreviations
*List and define abbreviations used in the project*
EOF

cat > "$INSTALL_PATH/context/conventions.md" << 'EOF'
# Coding Conventions

## Style Guide

## Naming Conventions

## File Structure

## Documentation Standards

## Testing Standards
EOF

# Create initialization script for project mode
if [[ "$INSTALL_MODE" == "project" ]]; then
    cat > "$PROJECT_PATH/init-claude.sh" << 'EOF'
#!/bin/bash
# Initialize Claude Code session with context

echo "Initializing Claude Code with Context-Driven Spec Development..."
echo ""
echo "Start your session with:"
echo "  'Please read .claude/CLAUDE.md and PROJECT_CONTEXT.md'"
echo ""
echo "Then begin feature development with:"
echo "  'Let's explore requirements for [feature]'"
echo ""
EOF
    chmod +x "$PROJECT_PATH/init-claude.sh"
fi

# Create a simple test to verify installation
print_info "Verifying installation..."
if [[ -f "$INSTALL_PATH/CLAUDE.md" ]] && [[ -d "$INSTALL_PATH/commands" ]]; then
    print_success "Installation completed successfully!"
    echo ""
    if [[ "$INSTALL_MODE" == "global" ]]; then
        echo "Global installation complete. The methodology is available for all projects."
        echo "Copy PROJECT_CONTEXT.md to your project's .claude/ directory to get started."
    else
        echo "Project installation complete at: $INSTALL_PATH"
        echo "Run ./init-claude.sh for usage instructions."
    fi
    echo ""
    print_info "Next steps:"
    echo "  1. Start Claude Code in your project directory"
    echo "  2. Ask Claude to read .claude/CLAUDE.md"
    echo "  3. Begin developing with conversational specifications!"
else
    print_error "Installation verification failed"
    exit 1
fi

# Create uninstall script
cat > "$INSTALL_PATH/../uninstall-claude-sdd.sh" << EOF
#!/bin/bash
# Uninstall Context-Driven Spec Development

echo "Removing Context-Driven SDD installation..."
rm -rf "$INSTALL_PATH"
rm -f "$INSTALL_PATH/../init-claude.sh"
rm -f "$INSTALL_PATH/../uninstall-claude-sdd.sh"
echo "Uninstallation complete."
EOF
chmod +x "$INSTALL_PATH/../uninstall-claude-sdd.sh"

print_success "Installation complete! 🎉"