# CLAUDE.md

This file provides guidance to Claude Code when working with this project.

## Context-Driven Spec Development

### Purpose and Intent

This configuration optimizes Claude Code for **spec-driven agentic development** - a collaborative approach where Claude acts as an intelligent development partner rather than a simple code generator. The goal is to move beyond "write this function" requests toward sophisticated specification development, architectural reasoning, and context-aware implementation planning.

By treating Claude as a domain expert who can engage in technical dialogue, explore requirements iteratively, and maintain project context across conversations, we enable more thoughtful software development that produces better specifications, cleaner implementations, and maintainable systems.

The methodology below prioritizes **understanding before implementation**, **conversation over commands**, and **accumulated context over isolated tasks**.

---

Please read .claude/METHODOLOGY.md and .claude/PROJECT_CONTEXT.md to understand the approach.

## Standalone Project Setup

This is a standalone project installation with complete methodology included locally in the `.claude/` directory.

## Hierarchical Override System

Commands and templates follow this precedence:
1. Project-level (.claude/commands/, .claude/templates/) - highest priority
2. Built-in behavior - fallback

When using commands like `/analyze`, `/refine`, `/review`, Claude will check:
- `.claude/commands/` first (project-specific versions)
- Built-in behavior if not found locally

## Usage

1. Read .claude/METHODOLOGY.md and .claude/PROJECT_CONTEXT.md to understand the approach
2. Use commands like `/analyze`, `/refine`, `/review` for guided development
3. Accumulate knowledge in the `.claude/context/` directory
4. Customize commands and templates in `.claude/` directories as needed

## File Structure

- `.claude/METHODOLOGY.md` - Core development methodology
- `.claude/PROJECT_CONTEXT.md` - Project-specific context (fill this in)
- `.claude/context/` - Accumulated project knowledge
- `.claude/commands/` - Command definitions (can be customized)
- `.claude/templates/` - Specification templates (can be customized)