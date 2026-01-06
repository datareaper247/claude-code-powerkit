# How Projects Use the Powerkit

> Guide for existing and new projects to leverage the Claude Code Powerkit

---

## How It Works

### Global → Project Inheritance

```
~/.claude/CLAUDE.md (Global)
         ↓
    [inherited by]
         ↓
./CLAUDE.md (Project-specific)
         ↓
    [merged with]
         ↓
./.claude/skills/auto-learned.md (Auto-generated)
```

**Claude automatically reads all three levels** and combines them.

---

## For Existing Projects

### Option 1: Add Import Header (Recommended)

Edit your existing `CLAUDE.md` and add imports at the top:

```markdown
---
imports:
  - ~/.claude/CLAUDE.md
  - ~/.claude/rules/development.md
---

# Your Existing Project Configuration

[Your existing content stays here unchanged]
```

**That's it.** Your project now inherits:
- Model routing rules
- Hallucination prevention
- Memory-keeper integration
- Gemini collaboration patterns
- All global rules

### Option 2: Auto-Generate + Merge

```bash
# Generate new project CLAUDE.md
~/.claude/scripts/generate-project-claude-md.sh /path/to/project

# This creates CLAUDE.md with imports
# Then manually merge your existing rules into it
```

### Option 3: Keep Separate (Manual)

Keep your existing `CLAUDE.md` as-is. Claude still reads `~/.claude/CLAUDE.md` globally, so you get:
- ✅ Global rules apply
- ✅ Your project rules apply
- ❌ No explicit import chain (less organized)

---

## For New Projects

### Quick Setup

```bash
cd /path/to/new/project
powerkit init .
# or
~/.claude/scripts/generate-project-claude-md.sh .
```

This creates a `CLAUDE.md` with:
- Imports from global config
- Auto-detected project type (React, Python, Go, etc.)
- Suggested plugins
- Test/lint commands
- Memory context patterns

---

## Auto-Learning (Automatic)

Every session end triggers `auto-learn.sh` which:

1. Analyzes recent session data
2. Extracts patterns (verification commands, issues)
3. Creates/updates `.claude/skills/auto-learned.md` in the project

**No action needed** - this happens automatically via the Stop hook.

### What Gets Learned

```markdown
# .claude/skills/auto-learned.md

## Verification Commands Used
ls -la, grep -r, cat | head

## Issues Encountered
error, failed, not found

## Recommendations
- Always verify paths before writing
- Run tests after changes
```

---

## Project Structure After Setup

```
your-project/
├── CLAUDE.md                    # Project config (with imports)
├── .claude/
│   └── skills/
│       └── auto-learned.md      # Auto-generated patterns
├── src/
└── ...
```

---

## Import Options

### Minimal (Just Global)

```markdown
---
imports:
  - ~/.claude/CLAUDE.md
---
```

### Standard (Global + Development)

```markdown
---
imports:
  - ~/.claude/CLAUDE.md
  - ~/.claude/rules/development.md
---
```

### Full Stack

```markdown
---
imports:
  - ~/.claude/CLAUDE.md
  - ~/.claude/rules/development.md
  - ~/.claude/rules/hallucination-prevention.md
  - ~/.claude/rules/model-routing.md
---
```

### Entrepreneur Mode

```markdown
---
imports:
  - ~/.claude/CLAUDE.md
  - ~/.claude/rules/entrepreneur.md
---
```

### Mobile Development

```markdown
---
imports:
  - ~/.claude/CLAUDE.md
  - ~/.claude/rules/mobile-development.md
---
```

---

## Available Rule Modules

| Rule File | Content |
|-----------|---------|
| `development.md` | Code quality, testing, git workflow |
| `hallucination-prevention.md` | Pre/post verification checks |
| `model-routing.md` | Opus/Sonnet/Haiku/Gemini routing |
| `entrepreneur.md` | Solo founder tactics, SaaS building |
| `mobile-development.md` | React Native, iOS, Android |
| `containerization.md` | Docker, sandbox execution |
| `autonomous-agents.md` | Ralph, continuous loops |
| `gemini-integration.md` | Gemini CLI collaboration |
| `image-handling.md` | Screenshot/image processing |

---

## Example: Existing React Project

**Before (your existing CLAUDE.md):**
```markdown
# My React App

## Rules
- Use TypeScript
- Follow existing component patterns
- Run tests before PR
```

**After (add imports):**
```markdown
---
imports:
  - ~/.claude/CLAUDE.md
  - ~/.claude/rules/development.md
---

# My React App

## Rules
- Use TypeScript
- Follow existing component patterns
- Run tests before PR
```

**Result:** Your rules + global rules + model routing + hallucination prevention + memory integration.

---

## Memory Context Per Project

Each project can use memory-keeper for continuity:

```markdown
## In your project CLAUDE.md

### Memory Context

When starting work:
```
context_search query: "my-project-name"
context_get category: "progress"
```

Before ending:
```
context_save key: "my-project-progress" category: "progress"
context_checkpoint name: "my-project-checkpoint"
```
```

---

## Troubleshooting

### Imports Not Working

Check that the import paths are absolute:
```markdown
# Correct
- ~/.claude/CLAUDE.md

# Wrong
- ../CLAUDE.md
- ./global/CLAUDE.md
```

### Project Rules Override Global

Project CLAUDE.md rules take precedence. If you want global rules to win, remove conflicting project rules.

### Auto-Learn Not Creating Skills

Check that:
1. Stop hook is configured in `~/.claude/settings.json`
2. Script is executable: `chmod +x ~/.claude/scripts/auto-learn.sh`
3. There's recent session data in `~/.claude/projects/`

---

## Quick Reference

```bash
# Generate project CLAUDE.md
powerkit init /path/to/project

# Check what Claude sees
cat ~/.claude/CLAUDE.md
cat ./CLAUDE.md
cat ./.claude/skills/auto-learned.md

# Manual auto-learn trigger
~/.claude/scripts/auto-learn.sh $(pwd)
```
