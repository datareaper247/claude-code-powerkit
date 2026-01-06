# Powerkit Integration Architecture

## Layered System Design

```
┌─────────────────────────────────────────────────────────────┐
│                    OPTIONAL: AUTONOMOUS                      │
│                 Ralph / continuous-claude                    │
│           (Long-running tasks, overnight work)               │
├─────────────────────────────────────────────────────────────┤
│                    PARALLEL EXECUTION                        │
│            Boris's 5-Terminal Technique                      │
│    ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐           │
│    │  T1  │ │  T2  │ │  T3  │ │  T4  │ │  T5  │           │
│    │ Plan │ │Review│ │Feat A│ │Feat B│ │ Fix  │           │
│    └──────┘ └──────┘ └──────┘ └──────┘ └──────┘           │
├─────────────────────────────────────────────────────────────┤
│                     BASE LAYERS                              │
│         ┌──────────────┐  ┌──────────────┐                  │
│         │   SANDBOX    │  │ HAPPY CODER  │                  │
│         │ (Permission  │  │   (Mobile    │                  │
│         │  Whitelist)  │  │   Access)    │                  │
│         └──────────────┘  └──────────────┘                  │
├─────────────────────────────────────────────────────────────┤
│                   FOUNDATION: MCP SERVERS                    │
│   memory-keeper │ context7 │ gemini-cli │ mobile-mcp        │
└─────────────────────────────────────────────────────────────┘
```

## Boris's 5-Terminal Technique (Proper Roles)

Based on [Boris Cherny's workflow](https://paddo.dev/blog/how-boris-uses-claude-code/):

| Terminal | Role | Branch Pattern | Workflow |
|----------|------|----------------|----------|
| **T1** | Planner/Orchestrator | `main` | Plan Mode, coordinate work, final reviews |
| **T2** | Reviewer | `review/current` | Code review, PR review, quality gates |
| **T3** | Feature A | `feature/a` | Primary feature development |
| **T4** | Feature B | `feature/b` | Secondary feature / parallel work |
| **T5** | Fixes/Polish | `fix/current` | Bug fixes, polish, small tasks |

### T1: Planner/Orchestrator
- Always starts in **Plan Mode** (Shift+Tab twice)
- Reviews plans before other terminals execute
- Monitors progress across all terminals
- Makes architectural decisions
- Coordinates merges

### T2: Reviewer
- Runs code reviews on PRs from T3/T4/T5
- Uses `pr-reviewer` or `code-reviewer` agent
- Quality gate before merging
- Security audits when needed

### T3 & T4: Feature Development
- Execute plans approved by T1
- Auto-accept mode after plan approval
- Independent features with no conflicts
- Each in isolated worktree

### T5: Fixes/Polish
- Bug fixes, small improvements
- Polish and cleanup
- Documentation updates
- CI/CD fixes

## How Layers Combine

### Base Layer: Happy Coder OR Sandbox (Choose One)

> **Note**: Happy Coder wraps Claude directly, Sandbox uses Docker isolation.
> These are alternative approaches, not composable layers.

```bash
# Mobile access (recommended for most users)
powerkit full                    # Uses Happy Coder if available
powerkit happy                   # Explicit Happy Coder

# Docker isolation (for untrusted code)
powerkit sandbox                 # Docker-based isolation
```

**Happy Coder provides:**
- Mobile app notifications & control
- Voice control from phone
- Remote session access
- E2E encryption

**Sandbox provides:**
- Docker container isolation
- Permission whitelist system
- Protected file patterns (.env, secrets)
- Command filtering

### Middle Layer: Boris Parallel (Development Sessions)

```bash
# Create 5-terminal setup with proper roles
powerkit parallel --boris

# Creates:
# T1: ../project-orchestrator (main branch)
# T2: ../project-review (review/current)
# T3: ../project-feature-a (feature/a)
# T4: ../project-feature-b (feature/b)
# T5: ../project-fixes (fix/current)
```

**Each terminal gets:**
- Isolated git worktree
- System notifications on completion
- Shared CLAUDE.md context
- Memory keeper sync

### Top Layer: Ralph Autonomous (Optional)

```bash
# Convert any terminal to autonomous mode
powerkit autonomous "add tests until 80% coverage"

# Or use Ralph directly in T5 for overnight work
cd ../project-fixes
ralph --monitor
```

## Combined Workflow Example

### Day Start
```bash
# 1. Start base layer (sandbox + mobile)
powerkit full

# 2. Create parallel terminals
powerkit parallel --boris

# 3. In T1 (Orchestrator): Create daily plan
# Use Plan Mode (Shift+Tab twice)
"Review yesterday's progress, plan today's work"
```

### During Development
```bash
# T1: Approves plans, coordinates
# T2: Reviews PRs as they come in
# T3: Implements Feature A (auto-accept after T1 approval)
# T4: Implements Feature B (parallel, no conflicts)
# T5: Handles quick fixes, polish
```

### Before Leaving
```bash
# T5: Start autonomous overnight work
powerkit autonomous "refactor auth module following new patterns"

# Or use continuous-claude with limits
continuous-claude --prompt "add missing tests" --max-cost 50.00
```

## Notification Integration

Boris uses system notifications to know when Claude needs input:

```bash
# macOS notifications (built into powerkit)
osascript -e 'display notification "T3 needs input" with title "Claude Code"'

# Terminal bell (fallback)
echo -e "\a"
```

Configure in `~/.claude/settings.json`:
```json
{
  "notifications": {
    "enabled": true,
    "sound": true,
    "onWaitingForInput": true,
    "onTaskComplete": true
  }
}
```

## Quick Reference

| What You Want | Command |
|---------------|---------|
| Start with all protections | `powerkit full` |
| Create 5 parallel terminals | `powerkit parallel --boris` |
| Start any session | `powerkit start` |
| Go autonomous overnight | `powerkit autonomous "task"` |
| Mobile access only | `powerkit happy` |
| Sandbox only | `powerkit sandbox` |
| Cleanup worktrees | `powerkit cleanup` |

**Note**: For T1 Orchestrator, enter Plan Mode manually with `Shift+Tab` twice after starting.

## Memory Sync Across Terminals

All terminals share context via memory-keeper:

```
# T1 saves plan
context_save key: "daily-plan" category: "task" priority: "high"

# T3/T4 read plan
context_get key: "daily-plan"

# T2 saves review feedback
context_save key: "review-feature-a" category: "note"

# T5 reads feedback
context_get key: "review-feature-a"
```

## File: Shared CLAUDE.md

All terminals share the same `.claude/commands/` and `CLAUDE.md`:

```
project/
├── .claude/
│   └── commands/
│       ├── commit-push-pr.md    # Boris's favorite
│       ├── review-pr.md
│       └── plan-feature.md
├── CLAUDE.md                    # Shared project context
└── ...
```
