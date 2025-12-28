# Agents Reference

Complete reference of all 251 agents included in the Claude Code Powerkit.

## Agents by Source

### chusri-agents (77 agents)
Full-stack development specialists.

**Frontend:**
- `react-specialist`, `vue-specialist`, `angular-specialist`
- `nextjs-developer`, `svelte-developer`
- `css-architect`, `accessibility-expert`

**Backend:**
- `nodejs-expert`, `python-backend`, `golang-developer`
- `rust-engineer`, `java-architect`
- `api-designer`, `graphql-specialist`

**Database:**
- `postgresql-expert`, `mongodb-specialist`
- `redis-architect`, `elasticsearch-expert`

**DevOps:**
- `kubernetes-operator`, `docker-expert`
- `terraform-engineer`, `ansible-specialist`
- `cicd-architect`, `cloud-architect`

**Security:**
- `security-auditor`, `penetration-tester`
- `devsecops-engineer`

### lst97-subagents (40 agents)
Specialized task-focused agents.

**Development:**
- `code-reviewer`, `refactoring-specialist`
- `performance-optimizer`, `debug-detective`

**Architecture:**
- `system-designer`, `microservices-architect`
- `event-driven-architect`

**Testing:**
- `test-strategist`, `e2e-tester`
- `load-tester`, `chaos-engineer`

**Documentation:**
- `api-documenter`, `technical-writer`
- `diagram-creator`

### feiskyer-agents (7 agents)
Deep thinking and review specialists.

| Agent | Description |
|-------|-------------|
| `pr-reviewer` | Comprehensive PR code review |
| `deep-reflector` | Deep analysis and reasoning |
| `ui-engineer` | UI/UX development specialist |
| `github-issue-fixer` | Automated issue resolution |
| `insight-documenter` | Document insights and decisions |
| `instruction-reflector` | Reflect on instructions |
| `command-creator` | Create custom commands |

### VoltAgent-subagents (100+ reference agents)
Reference implementations for various domains.

**Core Development:**
- `api-designer`, `backend-developer`, `frontend-developer`
- `fullstack-developer`, `mobile-developer`

**Infrastructure:**
- `database-administrator`, `kubernetes-specialist`
- `cloud-architect`, `network-engineer`
- `sre-engineer`, `platform-engineer`

**Quality:**
- `code-reviewer`, `test-automator`, `qa-expert`
- `security-auditor`, `performance-engineer`

**Data & AI:**
- `data-scientist`, `ml-engineer`, `data-engineer`
- `nlp-engineer`, `llm-architect`

**Business:**
- `product-manager`, `project-manager`
- `business-analyst`, `technical-writer`

## Using Agents

### Via Task Tool
```
Use the Task tool with subagent_type parameter:
- subagent_type: "code-reviewer"
- subagent_type: "frontend-developer"
```

### Custom Agents
Create agents in `~/.claude/agents/` or project's `.claude/agents/`.

Example agent file:
```markdown
---
name: my-agent
description: What this agent does
model: sonnet  # or opus, haiku
---

# My Agent

You are a specialized agent for...

## Capabilities
- Capability 1
- Capability 2

## Instructions
When working on tasks:
1. Step 1
2. Step 2
```

## Agent Selection Guide

| Task Type | Recommended Agent |
|-----------|-------------------|
| Code review | `pr-reviewer`, `code-reviewer` |
| Bug investigation | `debug-detective`, `systematic-debugging` |
| Architecture | `system-designer`, `microservices-architect` |
| Performance | `performance-optimizer`, `load-tester` |
| Security | `security-auditor`, `penetration-tester` |
| Documentation | `technical-writer`, `api-documenter` |
| UI/UX | `ui-engineer`, `frontend-developer` |
| API Design | `api-designer`, `graphql-specialist` |
| Database | `postgresql-expert`, `database-administrator` |
| DevOps | `kubernetes-operator`, `cicd-architect` |
