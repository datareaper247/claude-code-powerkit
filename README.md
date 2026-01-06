# Claude Code Powerkit

A comprehensive enhancement suite for Claude Code with 800+ skills, 251 agents, 67 plugins, and a unified CLI for all operations.

## Features

| Category | Count | Description |
|----------|-------|-------------|
| **Skills** | 800+ | Auto-activated capabilities for specialized tasks |
| **Agents** | 251 | Specialized AI assistants for specific domains |
| **Plugins** | 67 | Modular packages with commands and MCP servers |
| **MCP Servers** | 10+ | Gemini, mobile dev, memory, context7, and more |

## Quick Start

```bash
# Clone and install
git clone https://github.com/YOUR_USERNAME/claude-code-powerkit.git ~/.claude/powerkit
cd ~/.claude/powerkit && ./scripts/setup.sh

# Add to PATH (add to ~/.zshrc)
export PATH="$HOME/.claude/powerkit/bin:$PATH"

# Verify installation
powerkit doctor
```

## The `powerkit` Command

One command to rule them all:

```bash
# Core commands
powerkit start [path]        # Start Claude session
powerkit doctor              # Check installation health
powerkit init <path>         # Initialize project with CLAUDE.md

# Model selection
powerkit opus                # Use Opus 4.5 (complex tasks)
powerkit sonnet              # Use Sonnet 4.5 (default)
powerkit haiku               # Use Haiku 4.5 (fast/cheap)

# Execution modes
powerkit full                # Base layer: sandbox + mobile access
powerkit sandbox             # Permission-controlled sandbox
powerkit parallel --boris    # Boris's 5-terminal workflow
powerkit cleanup             # Remove worktrees interactively
powerkit autonomous <task>   # Ralph autonomous loop
powerkit happy               # Mobile-enabled session (Happy Coder)

# Maintenance
powerkit update              # Update skills/agents
powerkit install-mcps        # Install MCP servers
powerkit uninstall           # Remove powerkit

# Utilities
powerkit mcp                 # List MCP servers
powerkit skills              # Show skill count
powerkit agents              # Show agent count
powerkit status              # Current session status
```

## Key Integrations

### Gemini CLI
Claude automatically delegates to Gemini for:
- Large files (>50K tokens) - Gemini has 1M+ context
- Real-time web search
- Second opinions on approaches
- Visual verification (screenshots, video)

```bash
# Uses Google login, no API keys needed
gemini  # First-time setup
```

### Memory Keeper
Persistent context across sessions:
- `context_save` / `context_get` - Store and retrieve context
- `context_checkpoint` - Named restore points
- `context_search_all` - Search across sessions

### Autonomous Agents
Run long tasks unattended:
```bash
powerkit autonomous "add tests until 80% coverage"
# Or use continuous-claude or ralph directly
```

### Mobile Development
iOS Simulator and Android control:
```bash
# MCPs auto-installed
claude mcp list | grep mobile
```

### Sandboxed Execution
Run with full permissions safely:
```bash
powerkit sandbox
# Permission requests get whitelisted
```

## Project Structure

```
~/.claude/
├── CLAUDE.md              # Global instructions
├── rules/                 # Modular rules
├── skills/                # 800+ skill symlinks
├── skill-repos/           # 36 source repositories
├── agents/                # 251 specialized agents
├── plugins/               # Plugin marketplaces
└── powerkit/              # Sandbox state, configs

~/.claude/powerkit/        # This repo
├── bin/powerkit           # CLI wrapper
├── scripts/               # Setup, update, uninstall
├── config/                # Sample configs
└── docs/                  # Documentation
```

## Skills & Agents

### Auto-Activated Skills
Skills trigger based on context:
- `test-driven-development` - TDD methodology
- `systematic-debugging` - Structured bug investigation
- `verification-before-completion` - Quality gates

### Available Agents
Use via Task tool:
```
"Use the code-reviewer agent to review this PR"
"Have the security-auditor check for vulnerabilities"
"Ask the architect-reviewer about this design"
```

Key agents: `pr-reviewer`, `debugger`, `security-auditor`, `architect-reviewer`, `ui-engineer`, `api-designer`, `database-administrator`

## Using Plugins

```bash
# List available plugins
/plugin

# Install plugins
/plugin install python-development
/plugin install kubernetes-operations
/plugin install full-stack-orchestration
```

Categories: Development, Infrastructure, Quality, Business, Data

## Documentation

- [Quick Start Guide](docs/QUICKSTART.md)
- [Complete Cheatsheet](docs/COMPLETE-CHEATSHEET.md)
- [Advanced Features](docs/POWERKIT-ENHANCEMENTS.md)
- [Project Integration](docs/PROJECT-INTEGRATION.md)

## Requirements

- Node.js 20+
- Claude Code CLI (`npm install -g @anthropic-ai/claude-code`)
- git
- (Optional) Docker for sandbox mode
- (Optional) Xcode for iOS development

## Updates

```bash
powerkit update
# Or
~/.claude/update-skills.sh
```

## Uninstall

```bash
powerkit uninstall
# Or
./scripts/uninstall.sh
```

This removes powerkit but keeps Claude Code CLI and backs up your CLAUDE.md.

## Contributing

1. Fork this repository
2. Add improvements
3. Submit a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This collection aggregates open-source repositories under their respective licenses.

## Acknowledgments

- Anthropic team for Claude Code
- @obra for superpowers
- @wshobson for agents collection
- All contributors to the included repositories
