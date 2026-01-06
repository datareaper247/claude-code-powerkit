# Global Claude Code Configuration

This is the global CLAUDE.md file that applies to all Claude Code sessions on this machine.

## MCP Servers (Always Active)

### Context7 - Documentation Access
Always use Context7 when you need:
- Library/framework documentation (React, Next.js, Python, etc.)
- API references and code examples
- Setup and configuration steps
- Version-specific documentation

**Usage**: Include "use context7" in prompts OR proactively use `resolve-library-id` and `get-library-docs` tools when generating code that uses external libraries.

### Memory Keeper - Persistent Context
Use memory-keeper MCP for context management across sessions:

**Short-term (within session)**:
- `context_save` - Store decisions, progress, notes
- `context_get` - Retrieve saved context
- `context_checkpoint` - Create named checkpoints

**Mid-term (across related sessions)**:
- `context_session_start` - Start named sessions
- `context_search_all` - Search across sessions
- `context_diff` - Get changes since last checkpoint

**Long-term (permanent knowledge)**:
- `context_journal_entry` - Log important insights
- `context_link` - Create relationships between items
- `context_analyze` - Extract patterns and entities

**IMPORTANT**: At session start, check for existing context:
```
context_get with category: "progress" to see pending work
context_search with query: "project_name" for prior context
```

Before compacting or ending work:
```
context_prepare_compaction to auto-save critical context
context_checkpoint for named restore point
```

### Gemini CLI - AI Collaboration (CRITICAL)

**MCP Server**: `gemini-cli` (uses Google login, no API keys)

**AUTOMATIC DELEGATION**: Claude MUST proactively use Gemini for these scenarios:

| Trigger | Action |
|---------|--------|
| File > 1000 lines or 50K tokens | `ask gemini to analyze @file` |
| Analyzing unfamiliar codebase | `use gemini to summarize @./src` |
| Need second opinion on approach | `ask gemini: is this the best way to...` |
| Real-time/latest information | `search for [topic] using gemini` |
| Testing risky code | `use gemini sandbox to test: [code]` |
| Claude expresses uncertainty | Get Gemini's perspective |
| Architecture decisions | Cross-validate with Gemini |

**Available Tools**:
- `mcp__gemini-cli__ask-gemini` - Query Gemini for analysis, questions, file processing
- `mcp__gemini-cli__brainstorm` - Generate ideas with creative frameworks

**Decision Matrix**:
| Task | Use Claude | Use Gemini |
|------|------------|------------|
| Writing code | ✓ | |
| Code review (small) | ✓ | Optional |
| Code review (large) | | ✓ |
| Video/image verification | NEVER | ALWAYS |
| Autonomous loops | ✓ | |
| Quick lookup | | ✓ |
| Complex refactoring | ✓ | Validate |
| Second opinion | | ✓ |
| Architecture design | Both | Both |
| File > 50K tokens | | ✓ |

**AUTH FAILURE HANDLING**:
If Gemini returns authentication errors:
1. STOP and inform the user: "Gemini CLI needs re-authentication"
2. Instruct user to run: `gemini` in terminal and complete Google login
3. WAIT for user confirmation before retrying

## Model Routing Strategy

Use the right model for the right task:

### Heavy Lifting (Opus 4.5 + Gemini Pro)
- Architecture design, complex refactoring
- Security audits, code review of critical systems
- Debugging complex race conditions
- Large file analysis (>50K tokens) → Gemini

### Daily Coding (Sonnet 4.5 + Gemini Flash)
- Feature implementation, writing tests
- Code generation, documentation
- Routine bug fixes

### Grunt Work (Haiku 4.5)
- Code formatting, linting suggestions
- Simple refactors, JSON/YAML validation
- Pre-commit validations

**Cost Reference**:
| Model | Cost/1M tokens | Use When |
|-------|----------------|----------|
| Opus 4.5 | $15 | Accuracy critical |
| Sonnet 4.5 | $3 | Daily work |
| Haiku 4.5 | $0.25 | Bulk operations |
| Gemini Flash | ~Free | Large context |

## Parallel Execution (Boris's Technique)

### Git Worktrees for 4-Terminal Parallel Work

```bash
# Create worktrees for parallel work
git worktree add ../project-feature-a feature/a
git worktree add ../project-feature-b feature/b
git worktree add ../project-tests tests/coverage
git worktree add ../project-docs docs/update

# Run Claude in each worktree
cd ../project-feature-a && claude
```

Or use: `powerkit parallel .`

### Workflow Organization
| Terminal | Branch | Purpose |
|----------|--------|---------|
| T1 | `feature/main-work` | Primary implementation |
| T2 | `feature/tests` | Test coverage |
| T3 | `feature/docs` | Documentation |
| T4 | `fix/bugs` | Bug fixes/cleanup |

## Autonomous Agents

### When to Use Autonomous Loops
- Large-scale refactoring
- Test coverage expansion
- Dependency updates
- Documentation generation

### Usage
```bash
# Using powerkit
powerkit autonomous "add unit tests until 80% coverage"

# Using Ralph directly
ralph --monitor

# Using continuous-claude
continuous-claude --prompt "task" --max-runs 10
```

### Safety Guidelines
- Always set limits (--max-runs, --max-cost)
- Work in git repository with changes committed
- Review PRs before merging
- Check SHARED_TASK_NOTES.md for progress

## Senior Engineering Mindset (CRITICAL)

### 1. Plan Before Executing
- STOP before writing code or running commands
- Think through the high-level approach first
- Identify potential failure points and edge cases

### 2. Start Small, Validate, Then Scale
- NEVER try to do everything at once
- Perfect ONE thing first
- Validate it works completely before moving to the next

### 3. Fail Fast, Learn, Adapt
- If something fails twice the same way, STOP
- Analyze root cause before retrying
- Use Gemini for fresh perspective on stuck problems

### 4. Incremental Progress Over Big Bang
- Break complex tasks into small, verifiable steps
- Commit/checkpoint after each successful step

### Anti-Patterns to AVOID:
- Writing all code then testing at the end
- Generating multiple files before verifying the first works
- Assuming something works without verification
- Repeating failed approaches

## Auto-Plugin System

### Detection Rules
| Pattern Detected | Plugin to Install |
|-----------------|-------------------|
| Python files (.py), pip, poetry | `python-development` |
| TypeScript/JavaScript, React, Vue | `frontend-mobile-development` |
| Kubernetes, Docker, k8s manifests | `kubernetes-operations` |
| API design, OpenAPI, REST | `api-scaffolding` |
| Tests, pytest, jest, TDD | `tdd-workflows` |
| Security audit, OWASP, auth | `security-compliance` |
| ML, PyTorch, TensorFlow | `machine-learning-ops` |

## Skills Available (800+)

Skills auto-activate based on context. Key categories:

### Core Development (obra-superpowers)
- `test-driven-development` - TDD methodology
- `systematic-debugging` - Structured bug investigation
- `verification-before-completion` - Quality gates
- `brainstorming` - Idea generation
- `writing-plans` - Technical planning

### Documents (anthropics-skills)
- `pdf`, `docx`, `pptx`, `xlsx` - Document generation
- `mcp-builder` - Create MCP servers

## Agents Available (251)

Use via Task tool with `subagent_type` parameter:

| Task Type | Agent |
|-----------|-------|
| Code review | `pr-reviewer`, `code-reviewer` |
| Bug investigation | `debug-detective`, `debugger` |
| Architecture | `system-designer`, `architect-reviewer` |
| Performance | `performance-optimizer`, `performance-engineer` |
| Security | `security-auditor`, `penetration-tester` |
| Documentation | `technical-writer`, `api-documenter` |
| UI/UX | `ui-engineer`, `frontend-developer` |
| API Design | `api-designer`, `graphql-architect` |
| Database | `postgresql-expert`, `database-administrator` |
| DevOps | `kubernetes-specialist`, `devops-engineer` |
| Testing | `test-automator`, `qa-expert` |

## Preferred Workflows

### For New Features
1. Check memory for prior context: `context_search`
2. Use Context7 for library docs
3. Use brainstorming skill for design
4. Create plan with writing-plans skill
5. Implement with TDD
6. Save progress: `context_save` with category "progress"

### For Debugging
1. Load context: `context_get` for related work
2. Use systematic-debugging skill
3. Document findings: `context_save` with category "note"
4. Use verification-before-completion

### Session Management
**Start of session**:
- `context_session_start` with descriptive name
- `context_get` to check for pending work

**End of session**:
- `context_prepare_compaction`
- `context_checkpoint` with summary

## Quality Standards

- Always use Context7 for up-to-date library documentation
- Run tests before committing
- Use conventional commits format
- Security review for auth/data handling
- Save important decisions to memory-keeper

## Entrepreneur Mode (Solo Founder / Indie Hacker)

### Market Research MCPs (Always Active)

**Reddit Research** - Problem discovery & validation
**HackerNews** - Tech trends & startup signals
**Jina** - Competitive intelligence (free, no API key)

### Problem Discovery Workflow
1. Use reddit MCP → search subreddits for complaints
2. Use hackernews MCP → find frustrated comments
3. Save findings: `context_save` with category "note"

### Business Agents Available
| Task | Agent |
|------|-------|
| Strategy | `ceo-advisor` |
| Technical | `cto-advisor` |
| Marketing | `marketing-strategy-pmm` |
| Pricing | `pricing-strategist` |
| Competition | `competitive-analyst` |
| Growth | `growth-hacker` |

## Updates

Run periodically:
```bash
powerkit update
# Or
~/.claude/update-skills.sh
```
