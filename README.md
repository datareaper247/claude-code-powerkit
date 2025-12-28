# Claude Code Powerkit

A comprehensive collection of 800+ skills, 251 agents, and 67 plugins for Claude Code, curated from the best open-source repositories on GitHub. This powerkit transforms Claude Code into an incredibly powerful AI development assistant.

## Features

| Category | Count | Description |
|----------|-------|-------------|
| **Skills** | 800+ | Auto-activated capabilities for specialized tasks |
| **Agents** | 251 | Specialized AI assistants for specific domains |
| **Plugins** | 67 | Modular packages with commands, skills, and MCP servers |
| **Repositories** | 36 | Curated from top GitHub projects |

## Quick Start

### Installation

```bash
# Clone this repository
git clone https://github.com/YOUR_USERNAME/claude-code-powerkit.git
cd claude-code-powerkit

# Run the setup script
./scripts/setup.sh
```

### Update All Components

```bash
# Update all skills, agents, and plugins
~/.claude/update-skills.sh
```

## Repository Structure

```
~/.claude/
├── CLAUDE.md              # Global instructions for Claude
├── settings.json          # Claude Code settings
├── rules/                 # Modular rules for different contexts
│   ├── development.md     # Development best practices
│   └── entrepreneur.md    # Business & product rules
├── skills/                # 800+ skill symlinks (auto-loaded)
├── skill-repos/           # 36 cloned repositories
├── agents/                # 251 specialized agents
│   ├── feiskyer/          # PR reviewer, deep reflector
│   ├── chusri/            # 77 full-stack agents
│   ├── lst97/             # 40 specialized subagents
│   └── rahulvrane/        # Additional agents
├── commands/              # Custom slash commands
│   ├── gh/                # GitHub commands
│   └── feiskyer/          # Thinking commands
├── plugins/
│   └── marketplaces/
│       ├── claude-plugins-official/  # Anthropic official
│       └── wshobson-agents/          # 67 professional plugins
└── update-skills.sh       # Master update script
```

## Included Repositories

### Official & Core (Must-Have)
| Repository | Stars | Description |
|------------|-------|-------------|
| [anthropics/skills](https://github.com/anthropics/skills) | 28.2k | Official Anthropic skills |
| [obra/superpowers](https://github.com/obra/superpowers) | 12.3k | Core TDD, debugging, collaboration |
| [wshobson/agents](https://github.com/wshobson/agents) | 23.7k | 99 agents, 107 skills, 67 plugins |

### Full-Stack Development
| Repository | Skills | Focus |
|------------|--------|-------|
| [daymade/claude-code-skills](https://github.com/daymade/claude-code-skills) | 25 | Professional marketplace skills |
| [maxritter/claude-codepro](https://github.com/maxritter/claude-codepro) | 11 | Backend/frontend standards |
| [fcakyon/claude-codex-settings](https://github.com/fcakyon/claude-codex-settings) | 29 | Cloud tools, plugins |
| [jeremylongshore/claude-code-plugins-plus-skills](https://github.com/jeremylongshore/claude-code-plugins-plus-skills) | 1000+ | Massive skill collection |

### Framework-Specific
| Repository | Skills | Framework |
|------------|--------|-----------|
| [alec-c4/claude-skills-rails-dev](https://github.com/alec-c4/claude-skills-rails-dev) | 13 | Ruby on Rails |
| [asiaostrich/universal-dev-skills](https://github.com/AsiaOstrich/universal-dev-skills) | 8 | Universal standards |

### Scientific & Research
| Repository | Skills | Domain |
|------------|--------|--------|
| [K-Dense-AI/claude-scientific-skills](https://github.com/K-Dense-AI/claude-scientific-skills) | 139 | Bioinformatics, genomics |
| [zechenzhangAGI/AI-research-SKILLs](https://github.com/zechenzhangAGI/AI-research-SKILLs) | 40+ | AI research |

### Entrepreneur & Business
| Repository | Skills | Focus |
|------------|--------|-------|
| [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) | 36 | C-level advisors, QA, marketing |
| [levnikolaevich/claude-code-skills](https://github.com/levnikolaevich/claude-code-skills) | 52 | Agile automation with Linear |

### Video Generation
| Repository | Description |
|------------|-------------|
| [tillo13/ai_video_creator](https://github.com/tillo13/ai_video_creator) | Flux + RunwayML + Suno pipeline |
| [davide97l/ai-video-generator](https://github.com/davide97l/ai-video-generator) | FFmpeg + MoviePy automation |

### Reference & MCP
| Repository | Stars | Description |
|------------|-------|-------------|
| [punkpeye/awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) | 77.7k | Complete MCP server directory |
| [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers) | - | Official MCP implementations |
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | 18.8k | Comprehensive resource list |

## Using wshobson Plugins

The wshobson marketplace includes 67 professional plugins:

```bash
# List available plugins
/plugin

# Install specific plugins
/plugin install python-development
/plugin install kubernetes-operations
/plugin install full-stack-orchestration
/plugin install api-scaffolding
/plugin install security-compliance
/plugin install frontend-mobile-development
/plugin install machine-learning-ops
/plugin install payment-processing
```

### Plugin Categories
- **Development**: python, javascript-typescript, jvm-languages, systems-programming
- **Infrastructure**: kubernetes-operations, cloud-infrastructure, deployment-strategies
- **Quality**: security-compliance, code-review-ai, tdd-workflows, unit-testing
- **Business**: business-analytics, content-marketing, customer-sales-automation
- **Data**: data-engineering, machine-learning-ops, database-design

## Skills Usage

Skills are auto-activated based on conversation context. Key skills include:

### Development Workflows
- `test-driven-development` - TDD methodology
- `systematic-debugging` - Structured bug investigation
- `verification-before-completion` - Quality gates

### Collaboration
- `brainstorming` - Idea generation
- `writing-plans` - Technical planning
- `requesting-code-review` / `receiving-code-review` - Code review workflow

### Documents
- `pdf`, `docx`, `pptx`, `xlsx` - Document generation

## Agents Available

### By Source
| Source | Count | Focus |
|--------|-------|-------|
| chusri | 77 | Full-stack development |
| lst97 | 40 | Specialized subagents |
| feiskyer | 7 | PR review, deep thinking |
| VoltAgent | 100+ | DevOps, data science, business |

### Key Agents
- `pr-reviewer` - Comprehensive PR reviews
- `deep-reflector` - Deep analysis and reasoning
- `ui-engineer` - UI/UX development
- `github-issue-fixer` - Automated issue resolution

## MCP Server Integration

Reference the awesome-mcp-servers repo for integrations:

### Essential MCP Servers
- **Supabase**: `npx @supabase/mcp-server`
- **Playwright**: `npx @anthropic/mcp-playwright`
- **Filesystem**: Built-in
- **Git**: Built-in

### Configuration Example
```json
{
  "mcpServers": {
    "supabase": {
      "command": "npx",
      "args": ["@supabase/mcp-server"]
    }
  }
}
```

## Customization

### Adding Project-Specific Skills
Create a `.claude/skills/` directory in your project and add SKILL.md files.

### Adding Rules
Add `.md` files to `~/.claude/rules/` for global rules or `.claude/rules/` for project-specific.

### Custom Commands
Add command files to `~/.claude/commands/` following the structure:
```
commands/
├── my-command.md
└── category/
    └── sub-command.md
```

## Updates

Run the master update script periodically:

```bash
~/.claude/update-skills.sh
```

This will:
1. Pull latest changes from all 36 repositories
2. Create symlinks for new skills
3. Update agents
4. Sync plugin marketplaces

## Contributing

1. Fork this repository
2. Add new repositories to `update-skills.sh`
3. Submit a pull request

## License

This collection aggregates open-source repositories under their respective licenses. See individual repositories for license details.

## Acknowledgments

Thanks to all the amazing contributors who created these skills, agents, and plugins:

- Anthropic team for Claude Code and official skills
- @obra for superpowers
- @wshobson for the comprehensive agents collection
- @daymade, @maxritter, @fcakyon for professional skills
- @K-Dense-AI for scientific skills
- All other contributors listed in the repositories above
