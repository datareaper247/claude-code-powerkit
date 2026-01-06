# Claude Code Powerkit - Complete Cheatsheet

> Print-ready reference for all commands, tools, and workflows

---

## Quick Start Commands

```bash
# Start Claude with context
powerkit start .

# Check system health
powerkit status

# Switch models
powerkit opus          # Heavy thinking ($15/1M)
powerkit sonnet        # Default coding ($3/1M)
powerkit haiku         # Validation ($0.25/1M)

# Parallel execution (4 terminals)
powerkit parallel .

# Initialize new project
powerkit init /path/to/project
```

---

## Model Routing Guide

| Task | Model | Command/Trigger |
|------|-------|-----------------|
| Architecture decisions | Opus 4.5 | `powerkit opus` |
| Security review | Opus 4.5 | Auto or manual |
| Daily coding | Sonnet 4.5 | Default |
| Implementation | Sonnet 4.5 | Default |
| Formatting/linting | Haiku 4.5 | `powerkit haiku` |
| Validation checks | Haiku 4.5 | Auto via hooks |
| Large files (>50K) | Gemini Pro | Auto-delegate |
| Image/video analysis | Gemini | `ask gemini @file` |
| Real-time search | Gemini | `search using gemini` |

---

## Ralph - Autonomous Loops

### Setup New Project
```bash
ralph-setup my-project     # Create project structure
cd my-project
nano PROMPT.md             # Edit requirements
```

### Run Autonomous Loop
```bash
ralph --monitor            # With live dashboard
ralph --timeout 30         # 30-minute limit
ralph --calls 50           # Rate limit (calls/hour)
ralph --verbose            # Detailed output
```

### Monitor Separately
```bash
ralph-monitor              # Watch running loop
```

### Project Structure
```
my-project/
├── PROMPT.md              # Your requirements
├── SHARED_TASK_NOTES.md   # Progress tracking (auto)
├── .claude/
│   └── settings.local.json
└── [your code files]
```

### Best Practices
- Always set `--timeout` or `--calls` limits
- Work in git branch, not main
- Review `SHARED_TASK_NOTES.md` for progress
- Use for: tests, docs, refactoring, migrations

---

## Session Analysis (claude-extract)

### List Sessions
```bash
claude-extract --list                    # All sessions
claude-extract --list --recent 5         # Last 5
claude-extract --list --detailed         # With metadata
```

### Search Sessions
```bash
claude-extract --search "pattern"        # Search all
claude-extract --search "error" --recent 10
claude-extract --search-regex "fix.*bug"
claude-extract --search "topic" --search-speaker assistant
```

### Export Sessions
```bash
claude-extract --export ./output         # Export to folder
claude-extract --recent 5 --format json  # JSON format
claude-extract --recent 5 --format html  # HTML format
claude-extract --all --output ./backup   # Full backup
```

### Interactive Mode
```bash
claude-extract --interactive             # Browse sessions
```

---

## Memory Keeper (MCP)

### Save Context
```bash
# In Claude session:
context_save key:"feature-progress" value:"Completed auth module" category:"progress"
context_save key:"decision-db" value:"Using PostgreSQL for X reason" category:"decision"
context_save key:"blocker-api" value:"API rate limit issue" category:"note" priority:"high"
```

### Retrieve Context
```bash
context_get category:"progress"          # All progress items
context_get key:"feature-progress"       # Specific item
context_search query:"authentication"    # Search
context_search_all query:"feature"       # Cross-session
```

### Checkpoints
```bash
context_checkpoint name:"before-refactor"
context_checkpoint name:"v1-complete" description:"MVP done"
context_restore_checkpoint name:"before-refactor"
```

### Session Management
```bash
context_session_start name:"feature-auth" description:"Auth implementation"
context_session_list limit:10
context_summarize                        # AI summary
context_diff since:"2 hours ago"         # Recent changes
```

### Before Ending Session
```bash
context_prepare_compaction               # Auto-save critical
context_checkpoint name:"session-end"
```

---

## Gemini Integration (MCP)

### Query Gemini
```bash
# Large file analysis
ask gemini to analyze @src/large-file.ts

# Second opinion
ask gemini: is microservices the right approach here?

# Real-time search
search for Next.js 15 best practices using gemini

# Codebase summary
use gemini to summarize @./src
```

### MCP Tool Usage
```bash
mcp__gemini-cli__ask-gemini prompt:"Analyze @file.ts for issues"
mcp__gemini-cli__ask-gemini prompt:"Test this code" sandbox:true
mcp__gemini-cli__brainstorm prompt:"Solutions for X" domain:"software"
```

### When to Use Gemini
- Files > 1000 lines or 50K tokens
- Image/video analysis (Claude can't see these)
- Need second opinion
- Real-time information needed
- Sandbox code testing

---

## Project Integration

### For Existing Projects
Add to your project's `CLAUDE.md`:
```markdown
---
imports:
  - ~/.claude/CLAUDE.md
  - ~/.claude/rules/development.md
---

# Your existing project rules below
```

### Import Options
```markdown
# Minimal
imports:
  - ~/.claude/CLAUDE.md

# Standard
imports:
  - ~/.claude/CLAUDE.md
  - ~/.claude/rules/development.md

# Full Stack
imports:
  - ~/.claude/CLAUDE.md
  - ~/.claude/rules/development.md
  - ~/.claude/rules/hallucination-prevention.md

# Entrepreneur
imports:
  - ~/.claude/CLAUDE.md
  - ~/.claude/rules/entrepreneur.md

# Mobile Dev
imports:
  - ~/.claude/CLAUDE.md
  - ~/.claude/rules/mobile-development.md
```

### For New Projects
```bash
powerkit init /path/to/project
# or
~/.claude/scripts/generate-project-claude-md.sh /path/to/project
```

---

## Auto-Learning System

### How It Works
1. Every session end triggers `auto-learn.sh`
2. Analyzes recent session for patterns
3. Creates `.claude/skills/auto-learned.md` in project
4. Next session inherits learned patterns

### Manual Trigger
```bash
~/.claude/scripts/auto-learn.sh $(pwd)
```

### What Gets Learned
- Verification commands used
- Errors encountered
- Successful patterns

---

## Hooks Reference

### Configured Hooks (settings.json)

| Hook | Trigger | Action |
|------|---------|--------|
| SessionStart | Session begins | Claudio notification |
| PreToolUse | Before any tool | Claudio check |
| PostToolUse | After any tool | Claudio notification |
| Stop | Session ends | Auto-learn + notification |
| Notification | Permission needed | Claudio alert |

### Hook Location
```bash
cat ~/.claude/settings.json
```

---

## Parallel Execution

### Quick Start (4 Terminals)
```bash
powerkit parallel /path/to/project
# or
~/.claude/scripts/parallel-claude.sh /path/to/project
```

### Manual Git Worktrees
```bash
cd /path/to/project
git worktree add ../proj-feature feature/new-thing
git worktree add ../proj-tests tests/coverage
git worktree add ../proj-docs docs/update
git worktree add ../proj-fixes fix/bugs
```

### Terminal Layout
| Terminal | Branch | Purpose |
|----------|--------|---------|
| T1 | feature/* | Implementation |
| T2 | tests/* | Test coverage |
| T3 | docs/* | Documentation |
| T4 | fix/* | Bug fixes |

### Cleanup
```bash
git worktree remove ../proj-feature
git worktree prune
```

---

## MCP Servers Available

```bash
/mcp                       # List all in Claude session
```

| Server | Purpose | Key Tools |
|--------|---------|-----------|
| memory-keeper | Context persistence | context_save, checkpoint |
| context7 | Library docs | resolve-library-id, query-docs |
| gemini-cli | AI collaboration | ask-gemini, brainstorm |
| reddit | Research | get_subreddit_posts, search |
| hackernews | Tech trends | getTopStories, getComments |
| jina | Web scraping | jina_reader |
| mobile-mcp | Mobile dev | list_apps, take_screenshot |
| ios-simulator | iOS dev | record_video, ui_tap |

---

## Hallucination Prevention

### Before Writing Code
```bash
ls -la $(dirname "$TARGET")           # Verify path
grep -r "FunctionName" --include="*.ts" .  # Check imports
```

### After Writing Code
```bash
ls -la "$FILE"                        # Verify created
cat "$FILE" | head -20                # Check content
npm test -- --findRelatedTests "$FILE" # Run tests
```

### Cross-Validate
```bash
ask gemini: review @file for errors
```

---

## File Locations

| Path | Purpose |
|------|---------|
| `~/.claude/CLAUDE.md` | Global rules |
| `~/.claude/settings.json` | Hooks config |
| `~/.claude/rules/` | Modular rules |
| `~/.claude/scripts/` | Powerkit scripts |
| `~/.claude/references/` | Documentation |
| `~/.claude/COMPLETE-CHEATSHEET.md` | This file |
| `~/.ralph/` | Ralph installation |
| `./CLAUDE.md` | Project rules |
| `./.claude/skills/` | Auto-learned |

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Command not found | `source ~/.zshrc` or new terminal |
| Rate limit | Use checkpoints, wait |
| Context lost | `context_restore_checkpoint` |
| Hallucination | Verify with `ls`, `grep`, Gemini |
| MCP not working | `/mcp` to check, restart Claude |
| Ralph stuck | Check `SHARED_TASK_NOTES.md` |

### Health Check
```bash
powerkit status
```

### Reset Session
```bash
claude --resume              # Continue last
claude                       # Fresh start
```

---

## Weekly Maintenance

```bash
# Generate insights report
~/.claude/scripts/weekly-analysis.sh

# Update skills
~/.claude/update-skills.sh

# Health check
powerkit status

# Backup sessions
claude-extract --all --output ~/backup/claude-$(date +%Y%m%d)
```

---

## Quick Workflows

### Bug Fix
```bash
powerkit start .
# In Claude: context_get category:"progress"
# Fix the bug
# In Claude: context_save key:"bugfix-X" value:"Fixed by..."
```

### New Feature
```bash
powerkit opus                # Heavy thinking for design
# Plan architecture
powerkit sonnet              # Switch to implementation
# Build feature
# In Claude: context_checkpoint name:"feature-X-done"
```

### Code Review
```bash
# Use code-reviewer agent
# Or: ask gemini to review @src/
```

### Autonomous Task
```bash
ralph-setup batch-tests
cd batch-tests
echo "Add unit tests to all files in src/" > PROMPT.md
ralph --monitor --timeout 60
```

---

## Environment Info

- Platform: macOS
- Shell: zsh
- Claude: 2.0.76
- Powerkit: v1.0
- Ralph: Installed
- claude-extract: Installed

---

*Generated: 2026-01-06 | Source: ~/.claude/COMPLETE-CHEATSHEET.md*
