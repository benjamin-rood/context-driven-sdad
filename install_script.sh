#!/bin/bash

# Context-Driven Spec Development for Claude Code
# Installation Script with Hierarchical Override System

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

Context-Driven Spec Development Installation

Installation Modes:
    --global            Install methodology globally (~/.claude/)
                       Includes: METHODOLOGY.md, commands/, templates/
                       
    --project PATH      Install for specific project (default: current directory)
                       Smart installation based on global methodology presence:
                       • If global exists: minimal project setup
                       • If no global: complete standalone setup

Options:
    --force            Overwrite existing files
    --help             Show this help message

Examples:
    $0 --global                    # Install methodology globally
    $0 --project /path/to/project  # Install for specific project
    $0 --force --project .         # Force overwrite in current directory

Installation Architecture:
    Global (~/.claude/):           Shared methodology and tools
    Project (.claude/):            Project-specific context and overrides
    
    Command precedence: project → global → built-in
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

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if global methodology exists
check_global_methodology() {
    local global_path="$HOME/.claude"
    if [[ -f "$global_path/METHODOLOGY.md" ]] && [[ -d "$global_path/commands" ]] && [[ -d "$global_path/templates" ]]; then
        return 0  # Global methodology exists
    else
        return 1  # No global methodology
    fi
}

# Install global methodology
install_global() {
    local install_path="$HOME/.claude"
    
    print_info "Global installation will create/modify:"
    echo "  • $install_path/METHODOLOGY.md"
    echo "  • $install_path/CLAUDE.md (updated with methodology reference)"
    echo "  • $install_path/commands/ (analyze.md, refine.md, review.md, start.md, uninstall.md)"
    echo "  • $install_path/templates/ (requirements, design, tasks templates)"
    echo ""
    
    if [[ "$FORCE" == false ]]; then
        read -p "Continue with global installation? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled"
            exit 0
        fi
    fi
    
    # Handle existing installation
    if [[ -d "$install_path" ]] && [[ "$FORCE" == false ]]; then
        print_warning "Global installation already exists at $install_path"
        read -p "Do you want to overwrite existing files? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled"
            exit 0
        fi
    fi
    
    # Create directory structure
    print_info "Creating global directory structure..."
    mkdir -p "$install_path"/{commands,templates}
    
    # Copy core methodology files
    print_info "Installing METHODOLOGY.md..."
    cp "$SCRIPT_DIR/METHODOLOGY.md" "$install_path/"
    
    print_info "Installing command definitions..."
    cp "$SCRIPT_DIR/commands/"*.md "$install_path/commands/" 2>/dev/null || true
    
    print_info "Installing templates..."
    cp "$SCRIPT_DIR/templates/"*.md "$install_path/templates/" 2>/dev/null || true
    
    # Handle global CLAUDE.md
    if [[ -f "$install_path/CLAUDE.md" ]]; then
        print_info "Updating existing global CLAUDE.md with methodology reference..."
        
        # Check if it already has our methodology reference
        if ! grep -q "Context-Driven Spec Development" "$install_path/CLAUDE.md"; then
            # Backup existing and add methodology reference
            cp "$install_path/CLAUDE.md" "$install_path/CLAUDE.md.backup"
            
            cat > "$install_path/CLAUDE.md.temp" << 'EOF'
# Claude Code Configuration

## Context-Driven Spec Development

Please read the METHODOLOGY.md file in this directory for the complete development methodology and approach.

This methodology emphasizes conversational specification building, EARS requirements format, and context accumulation across development sessions.

---

EOF
            cat "$install_path/CLAUDE.md.backup" >> "$install_path/CLAUDE.md.temp"
            mv "$install_path/CLAUDE.md.temp" "$install_path/CLAUDE.md"
        fi
    else
        print_info "Creating global CLAUDE.md with methodology reference..."
        cp "$SCRIPT_DIR/claude_header_template.global.md" "$install_path/CLAUDE.md"
    fi
    
    print_success "Global methodology installed successfully!"
    echo ""
    print_info "Next steps:"
    echo "  • Run '$0 --project /path/to/project' to set up individual projects"
    echo "  • Projects will automatically use global methodology with minimal local setup"
    echo "  • Use /start in Claude Code to initialize sessions"
    echo "  • Projects can override commands/templates by placing them in local .claude/ directory"
}

# Install project-specific setup
install_project() {
    local project_path="$PROJECT_PATH"
    local install_path="$project_path/.claude"
    
    # Ensure project path exists
    if [[ ! -d "$project_path" ]]; then
        print_error "Project path does not exist: $project_path"
        exit 1
    fi
    
    # Check if global methodology exists
    local has_global=false
    if check_global_methodology; then
        has_global=true
        print_info "Global methodology detected - installing minimal project setup"
        print_info "Project installation will create/modify:"
        echo "  • $project_path/CLAUDE.md (methodology reference - existing content moved to PROJECT_CONTEXT.md)"
        echo "  • $install_path/PROJECT_CONTEXT.md (existing CLAUDE.md content will be moved here)"
        echo "  • $install_path/context/ (patterns.md, decisions.md, glossary.md, conventions.md)"
        echo "  • $install_path/commands/ and $install_path/templates/ (empty, for overrides)"
    else
        has_global=false
        print_info "No global methodology found - installing complete standalone setup"
        print_info "Standalone installation will create/modify:"
        echo "  • $project_path/CLAUDE.md (methodology reference - existing content moved to PROJECT_CONTEXT.md)"
        echo "  • $install_path/METHODOLOGY.md (complete methodology)"
        echo "  • $install_path/PROJECT_CONTEXT.md (existing CLAUDE.md content will be moved here)"
        echo "  • $install_path/context/ (patterns.md, decisions.md, glossary.md, conventions.md)"
        echo "  • $install_path/commands/ (analyze.md, refine.md, review.md, start.md, uninstall.md)"
        echo "  • $install_path/templates/ (requirements, design, tasks templates)"
    fi
    echo ""
    
    if [[ "$FORCE" == false ]]; then
        read -p "Continue with project installation? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled"
            exit 0
        fi
    fi
    
    # Handle existing installation
    if [[ -d "$install_path" ]] && [[ "$FORCE" == false ]]; then
        print_warning "Project installation already exists at $install_path"
        read -p "Do you want to overwrite? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled"
            exit 0
        fi
    fi
    
    # Create directory structure
    print_info "Creating project directory structure..."
    mkdir -p "$install_path"/{context,commands,templates}
    
    # Create specs directory for feature specifications
    print_info "Creating specs/ directory for feature specifications..."
    mkdir -p "$project_path/specs"
    
    # Always install PROJECT_CONTEXT.md template
    print_info "Installing PROJECT_CONTEXT.md template..."
    cp "$SCRIPT_DIR/PROJECT_CONTEXT.md" "$install_path/"
    
    # Create initial context files
    print_info "Creating initial context files..."
    
    cat > "$install_path/context/patterns.md" << 'EOF'
# Code Patterns

## Discovered Patterns
*This file will be updated as patterns are discovered in the codebase*

## Naming Conventions

## File Organization

## Common Abstractions

## Testing Patterns
EOF

    cat > "$install_path/context/decisions.md" << 'EOF'
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

    cat > "$install_path/context/glossary.md" << 'EOF'
# Domain Glossary

## Business Terms
*Define domain-specific terminology here*

## Technical Terms
*Define project-specific technical terms*

## Abbreviations
*List and define abbreviations used in the project*
EOF

    cat > "$install_path/context/conventions.md" << 'EOF'
# Coding Conventions

## Style Guide

## Naming Conventions

## File Structure

## Documentation Standards

## Testing Standards
EOF
    
    # Install methodology files based on global presence
    if [[ "$has_global" == false ]]; then
        # Complete standalone installation
        print_info "Installing complete methodology (standalone mode)..."
        cp "$SCRIPT_DIR/METHODOLOGY.md" "$install_path/"
        cp "$SCRIPT_DIR/commands/"*.md "$install_path/commands/" 2>/dev/null || true
        cp "$SCRIPT_DIR/templates/"*.md "$install_path/templates/" 2>/dev/null || true
        
        # Handle project CLAUDE.md at project root
        if [[ -f "$project_path/CLAUDE.md" ]]; then
            print_info "Updating existing project CLAUDE.md with methodology reference..."
            
            # Check if it already has our methodology reference
            if ! grep -q "Context-Driven Spec Development" "$project_path/CLAUDE.md"; then
                # Backup existing CLAUDE.md and move content to PROJECT_CONTEXT.md
                cp "$project_path/CLAUDE.md" "$project_path/CLAUDE.md.backup"

                # Move existing content to PROJECT_CONTEXT.md
                cat "$project_path/CLAUDE.md.backup" > "$install_path/PROJECT_CONTEXT.md"

                # Create new CLAUDE.md with methodology reference
                cp "$SCRIPT_DIR/claude_header_template.project_standalone.md" "$project_path/CLAUDE.md"
            fi
        else
            print_info "Creating project CLAUDE.md with methodology reference..."
            cp "$SCRIPT_DIR/claude_header_template.project_standalone.md" "$project_path/CLAUDE.md"
        fi
    else
        # Minimal installation with global methodology reference
        print_info "Installing minimal project setup (using global methodology)..."
        
        # Handle project CLAUDE.md at project root
        if [[ -f "$project_path/CLAUDE.md" ]]; then
            print_info "Updating existing project CLAUDE.md with methodology reference..."
            
            # Check if it already has our methodology reference
            if ! grep -q "Context-Driven Spec Development" "$project_path/CLAUDE.md"; then
                # Backup existing CLAUDE.md and move content to PROJECT_CONTEXT.md
                cp "$project_path/CLAUDE.md" "$project_path/CLAUDE.md.backup"

                # Move existing content to PROJECT_CONTEXT.md
                cat "$project_path/CLAUDE.md.backup" > "$install_path/PROJECT_CONTEXT.md"

                # Create new CLAUDE.md with methodology reference
                cp "$SCRIPT_DIR/claude_header_template.project_global.md" "$project_path/CLAUDE.md"
            fi
        else
            print_info "Creating project CLAUDE.md with methodology reference..."
            cp "$SCRIPT_DIR/claude_header_template.project_global.md" "$project_path/CLAUDE.md"
        fi
    fi
    
    
    if [[ "$has_global" == true ]]; then
        print_success "Minimal project setup complete!"
        echo ""
        print_info "Configuration:"
        echo "  • Using global methodology from ~/.claude/"
        echo "  • Project context in $install_path"
        echo "  • Commands/templates can be overridden locally"
    else
        print_success "Standalone project setup complete!"
        echo ""
        print_info "Configuration:"
        echo "  • Complete methodology included in project"
        echo "  • All files contained in $install_path"
        echo "  • No global dependencies"
    fi
    
    echo ""
    print_info "Next steps:"
    echo "  1. Fill in PROJECT_CONTEXT.md with your project details"
    echo "  2. Start Claude Code and use /start to initialize your session"
    echo "  3. Begin conversational development!"
}

# Verify installation
verify_installation() {
    if [[ "$INSTALL_MODE" == "global" ]]; then
        local verify_path="$HOME/.claude"
        if [[ -f "$verify_path/METHODOLOGY.md" ]] && [[ -d "$verify_path/commands" ]]; then
            return 0
        fi
    else
        local verify_path="$PROJECT_PATH/.claude"
        if [[ -f "$verify_path/PROJECT_CONTEXT.md" ]] && [[ -d "$verify_path/context" ]]; then
            return 0
        fi
    fi
    return 1
}


# Main execution
main() {
    print_info "Context-Driven Spec Development Installer"
    echo ""
    
    if [[ "$INSTALL_MODE" == "global" ]]; then
        install_global
    else
        install_project
    fi
    
    # Verify installation
    print_info "Verifying installation..."
    if verify_installation; then
        print_success "Installation completed successfully! 🎉"
        echo ""
        print_info "To get started:"
        echo "  • Start Claude Code in your project directory"
        echo "  • Use /start to initialize your session"
        echo "  • Use /uninstall to remove the framework if needed"
    else
        print_error "Installation verification failed"
        exit 1
    fi
}

# Run main function
main