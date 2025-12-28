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

## Auto-Plugin System

### Detection Rules
When you detect these patterns, suggest or auto-install the relevant plugin:

| Pattern Detected | Plugin to Install |
|-----------------|-------------------|
| Python files (.py), pip, poetry | `python-development` |
| TypeScript/JavaScript, React, Vue | `frontend-mobile-development` |
| Kubernetes, Docker, k8s manifests | `kubernetes-operations` |
| API design, OpenAPI, REST | `api-scaffolding` |
| Tests, pytest, jest, TDD | `tdd-workflows` |
| Security audit, OWASP, auth | `security-compliance` |
| ML, PyTorch, TensorFlow | `machine-learning-ops` |
| Database schema, SQL, migrations | `database-design` |
| CI/CD, GitHub Actions, pipelines | `deployment-strategies` |
| Business analysis, metrics | `business-analytics` |
| Video, ffmpeg, media processing | Use video-creator skills |

### Auto-Install Command
```bash
/plugin install <plugin-name>
```

### Full-Stack Essentials (Pre-install these)
For full-stack development, these should be active:
- `full-stack-orchestration`
- `api-scaffolding`
- `tdd-workflows`
- `code-review-ai`

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

### Full-Stack (wshobson - 67 plugins)
- Backend, frontend, DevOps, security, data

### Scientific (K-Dense-AI - 139 skills)
- Bioinformatics, data science, chemistry

### Business (alirezarezvani - 36 skills)
- CEO/CTO advisors, engineering roles, compliance

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

### For Code Review
1. Use code-reviewer or pr-reviewer agent
2. Check Context7 for best practices
3. Follow receiving-code-review skill
4. Save decisions: `context_save` with category "decision"

### Session Management
**Start of session**:
- `context_session_start` with descriptive name
- `context_get` to check for pending work

**During work**:
- `context_save` key decisions and progress
- `context_checkpoint` before major changes

**End of session**:
- `context_prepare_compaction`
- `context_checkpoint` with summary

## Quality Standards

- Always use Context7 for up-to-date library documentation
- Run tests before committing
- Use conventional commits format
- Security review for auth/data handling
- Save important decisions to memory-keeper

## Video Generation Pipeline

For video work, use skills from:
- `tillo13-ai-video-creator` - Flux + RunwayML + Suno
- `davide97l-ai-video-generator` - FFmpeg + MoviePy

## Entrepreneur Mode

When working on business/product tasks:
- Use CEO/CTO advisor skills for strategic decisions
- Use market-researcher and competitive-analyst skills
- Track decisions with memory-keeper for continuity
- Use business-analytics plugin for metrics

## Updates

Run periodically:
```bash
~/.claude/update-skills.sh
```
