# Global Claude Code Configuration

This is the global CLAUDE.md file that applies to all Claude Code sessions on this machine.

## Skills Available

Claude has access to 800+ skills organized across multiple categories. Skills are loaded dynamically based on context.

### Core Development Skills
- **obra-superpowers**: TDD, systematic debugging, code review, git worktrees
- **anthropics-skills**: Official Anthropic skills for documents, design, MCP building

### Full-Stack Development
- **wshobson plugins**: 67 professional plugins for backend, frontend, DevOps, security
- **maxritter-claude-codepro**: Backend/frontend standards, testing guidelines

### Framework-Specific
- **Rails**: alec-c4-rails-skills (13 skills)
- **Scientific**: K-Dense-AI scientific skills (139 skills)

### Productivity & Business
- **alirezarezvani**: C-level advisors, engineering team roles
- **levnikolaevich**: 52 Agile automation tools with Linear MCP

## Agents Available

251 specialized agents across:
- feiskyer: PR reviewer, deep reflector, UI engineer
- chusri: 77 full-stack development agents
- lst97: 40 specialized subagents

## Preferred Workflows

### For New Features
1. Use brainstorming skill for initial design
2. Create plan using writing-plans skill
3. Implement with TDD using test-driven-development skill
4. Review with requesting-code-review skill

### For Debugging
1. Start with systematic-debugging skill
2. Use verification-before-completion before marking done

### For Code Review
1. Use code-reviewer agent for comprehensive review
2. Follow receiving-code-review skill for addressing feedback

## Quality Standards

- Always run tests before committing
- Use conventional commits format
- Follow language-specific best practices from maxritter-claude-codepro skills
- Security review for any auth or data handling code

## MCP Servers Reference

Reference awesome-mcp-servers repo for:
- Database connections (Supabase, Postgres, MongoDB)
- Browser automation (Playwright, Puppeteer)
- Cloud platforms (AWS, GCP, Azure)
- Productivity (Linear, Notion, Slack)
