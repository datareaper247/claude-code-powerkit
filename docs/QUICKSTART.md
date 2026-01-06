# Powerkit Quick Start Guide

Get up and running with Claude Code Powerkit in under 5 minutes.

## Prerequisites

- Node.js 20+
- Claude Code CLI installed (`npm install -g @anthropic-ai/claude-code`)
- git

## Installation

```bash
# Clone the powerkit
git clone https://github.com/YOUR_USERNAME/claude-code-powerkit.git ~/.claude/powerkit

# Run setup
cd ~/.claude/powerkit
./scripts/setup.sh

# (Optional) Install enhancements
./scripts/setup-enhancements.sh

# Add powerkit to PATH (add to ~/.zshrc)
export PATH="$HOME/.claude/powerkit/bin:$PATH"
```

## Verify Installation

```bash
powerkit doctor
```

You should see all green checkmarks for core dependencies.

## First Session

```bash
# Start Claude in any project
cd ~/my-project
powerkit start

# Or use Claude directly with powerkit features auto-loaded
claude
```

## Essential Commands

| Command | What it does |
|---------|--------------|
| `powerkit start` | Start Claude session |
| `powerkit doctor` | Check installation health |
| `powerkit init .` | Initialize powerkit for current project |
| `powerkit opus` | Switch to Opus model (complex tasks) |
| `powerkit haiku` | Switch to Haiku model (fast/cheap) |
| `powerkit sandbox` | Run in permission-controlled sandbox |
| `powerkit update` | Update all skills and agents |

## Using Skills

Skills auto-activate based on context. Try these:

```
# In Claude session:
"Let's use test-driven development for this feature"
"Help me debug this systematically"
"Create a technical plan for this project"
```

## Using Agents

Agents are specialized assistants. Use them via the Task tool:

```
# In Claude session:
"Use the code-reviewer agent to review my changes"
"Have the security-auditor check this code"
"Ask the architect-reviewer about this design"
```

## MCP Servers

Check installed servers:
```bash
powerkit mcp
# or
claude mcp list
```

Key servers:
- **memory-keeper**: Persistent context across sessions
- **context7**: Up-to-date library documentation
- **gemini-cli**: AI collaboration for large files

## Next Steps

1. Read the full docs: `docs/POWERKIT-ENHANCEMENTS.md`
2. Check the cheatsheet: `docs/COMPLETE-CHEATSHEET.md`
3. Explore available skills: `powerkit skills`
4. Join the community on Discord

## Troubleshooting

**Claude CLI not found:**
```bash
npm install -g @anthropic-ai/claude-code
```

**MCP servers not connecting:**
```bash
powerkit install-mcps
claude mcp list
```

**Skills not loading:**
```bash
powerkit update
# Then restart Claude
```

For more help, see `docs/TROUBLESHOOTING.md` or run `powerkit doctor`.
