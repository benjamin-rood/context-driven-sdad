# Claude Code Configuration

## Context-Driven Spec Development

### Purpose and Intent

This configuration optimizes Claude Code for **spec-driven agentic development** - a collaborative approach where Claude acts as an intelligent development partner rather than a simple code generator. The goal is to move beyond "write this function" requests toward sophisticated specification development, architectural reasoning, and context-aware implementation planning.

By treating Claude as a domain expert who can engage in technical dialogue, explore requirements iteratively, and maintain project context across conversations, we enable more thoughtful software development that produces better specifications, cleaner implementations, and maintainable systems.

The methodology below prioritizes **understanding before implementation**, **conversation over commands**, and **accumulated context over isolated tasks**.

---

Please read the METHODOLOGY.md file in this directory for the complete development methodology and approach.

This methodology emphasizes conversational specification building, EARS requirements format, and context accumulation across development sessions.

## Global Installation

This is a global installation providing shared methodology, commands, and templates for all projects.

Individual projects can override commands and templates by placing them in their local `.claude/` directories.

## Usage

In any project:
1. Create `.claude/` directory with PROJECT_CONTEXT.md
2. Start Claude Code and reference this methodology
3. Use hierarchical command system (project overrides global)