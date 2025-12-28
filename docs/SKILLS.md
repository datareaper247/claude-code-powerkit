# Skills Reference

Complete reference of all 800+ skills included in the Claude Code Powerkit.

## Skills by Repository

### anthropics-skills (17 skills)
Official Anthropic skills for document creation and design.

| Skill | Description |
|-------|-------------|
| `algorithmic-art` | Generate algorithmic art |
| `brand-guidelines` | Create brand guidelines |
| `canvas-design` | Design on canvas |
| `doc-coauthoring` | Collaborative document editing |
| `docx` | Create Word documents |
| `frontend-design` | Frontend UI design |
| `internal-comms` | Internal communications |
| `mcp-builder` | Build MCP servers |
| `pdf` | Create PDF documents |
| `pptx` | Create PowerPoint presentations |
| `skill-creator` | Create new skills |
| `slack-gif-creator` | Create Slack GIFs |
| `theme-factory` | Create themes |
| `web-artifacts-builder` | Build web artifacts |
| `webapp-testing` | Test web applications |
| `xlsx` | Create Excel spreadsheets |

### obra-superpowers (14 skills)
Core development workflows from obra.

| Skill | Description |
|-------|-------------|
| `brainstorming` | Idea generation and exploration |
| `dispatching-parallel-agents` | Multi-agent coordination |
| `executing-plans` | Execute development plans |
| `finishing-a-development-branch` | Complete branch work |
| `receiving-code-review` | Handle code review feedback |
| `requesting-code-review` | Request code reviews |
| `subagent-driven-development` | Development with subagents |
| `systematic-debugging` | Structured bug investigation |
| `test-driven-development` | TDD methodology |
| `using-git-worktrees` | Git worktree workflow |
| `using-superpowers` | Meta skill usage |
| `verification-before-completion` | Quality gates |
| `writing-plans` | Technical planning |
| `writing-skills` | Create new skills |

### scientific-skills (139 skills)
Comprehensive scientific and research skills.

**Bioinformatics:**
- `biopython`, `scanpy`, `pydeseq2`, `anndata`
- `alphafold-database`, `uniprot-database`, `pubmed-database`

**Data Science:**
- `matplotlib`, `seaborn`, `plotly`, `polars`
- `scikit-learn`, `pytorch-lightning`, `transformers`

**Chemistry:**
- `rdkit`, `deepchem`, `pubchem-database`

**Document Creation:**
- `scientific-writing`, `literature-review`, `latex-posters`

### daymade-claude-code-skills (25 skills)
Professional development skills.

| Skill | Description |
|-------|-------------|
| `github-ops` | GitHub operations |
| `mermaid-tools` | Diagram generation |
| `pdf-creator` | PDF creation |
| `ppt-creator` | Presentation creation |
| `qa-expert` | QA testing |
| `skill-creator` | Skill development |
| `ui-designer` | UI design |
| `youtube-downloader` | Video downloading |

### levnikolaevich-claude-skills (52 skills)
Agile automation with Linear MCP.

**Documentation:**
- `ln-100-documents-pipeline`
- `ln-110-project-docs-coordinator`
- `ln-111-root-docs-creator`
- `ln-112-project-core-creator`

**Story Management:**
- `ln-220-story-coordinator`
- `ln-221-story-creator`
- `ln-310-story-validator`
- `ln-400-story-pipeline`

**Quality Auditing:**
- `ln-620-codebase-auditor`
- `ln-621-security-auditor`
- `ln-623-architecture-auditor`
- `ln-630-test-auditor`

### alirezarezvani-claude-skills (36 skills)
Business and engineering team skills.

**C-Level Advisors:**
- `ceo-advisor`, `cto-advisor`

**Engineering Team:**
- `senior-frontend`, `senior-backend`, `senior-fullstack`
- `senior-architect`, `senior-devops`, `senior-security`
- `senior-ml-engineer`, `senior-data-scientist`
- `code-reviewer`, `senior-qa`

**Marketing:**
- `content-creator`, `marketing-strategy-pmm`

**Compliance:**
- `gdpr-dsgvo-expert`, `iso27001`, `fda-consultant-specialist`

### jeremylongshore-plugins-skills (1000+ skills)
Massive collection across all domains.

**Categories:**
- Database (25 skills): schema-designer, migration-manager, query-optimizer
- Crypto (25 skills): portfolio-tracker, defi-yield-optimizer, whale-alert
- DevOps (50+ skills): deployment, monitoring, infrastructure
- Frontend (50+ skills): component development, state management
- Backend (50+ skills): API design, authentication, caching

## Skills Auto-Activation

Skills are loaded dynamically based on:
1. File extensions in the project
2. Keywords in conversation
3. Tool usage patterns
4. Explicit skill invocation

## Creating Custom Skills

```markdown
---
name: my-skill
description: Description of what this skill does
---

# My Skill

## When to Use
- Condition 1
- Condition 2

## Instructions
1. Step 1
2. Step 2

## Examples
- Example usage
```

Save as `SKILL.md` in a folder under `~/.claude/skills/` or project's `.claude/skills/`.
