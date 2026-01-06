# Changelog

All notable changes to Claude Code Powerkit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-06

### Added
- **powerkit CLI wrapper** - Unified command interface for all operations
- **Health check system** - `powerkit doctor` to verify installation
- **Happy Coder integration** - Mobile access and push notifications
- **PowerKit Sandbox** - Permission whitelist system for safe execution
- **Remote Access documentation** - Section 6 in POWERKIT-ENHANCEMENTS.md
- **Gemini CLI integration** - Auto-delegation for large files and second opinions
- **Memory Keeper integration** - Persistent context across sessions
- **Context7 integration** - Up-to-date library documentation
- **Autonomous agents** - Ralph and continuous-claude support
- **Mobile development MCPs** - iOS Simulator and Android ADB
- **Validation hooks** - Pre/post tool use verification
- **Auto-learning system** - Pattern extraction from sessions
- **Project integration guide** - How to use powerkit in existing projects

### Changed
- Cleaned root directory - moved unrelated files to docs/archive/
- Standardized all scripts to zsh with proper error handling
- Fixed hardcoded paths in configuration files
- Consolidated MCP server configuration to single source of truth
- Updated documentation to match actual implementation

### Fixed
- MCP installation now actually installs all documented servers
- Scripts now verify dependencies before proceeding
- Proper error handling throughout all scripts
- Symlink creation with fallback for non-sudo environments

### Security
- Added dangerous command filtering in hooks
- Protected file patterns (.env, .git, node_modules)
- Sandbox whitelist system for controlled external access

## [0.9.0] - 2024-12-28

### Added
- Initial release
- 800+ skills from 36 repositories
- 251 agents from multiple sources
- 67 plugins from wshobson marketplace
- Basic setup and update scripts

---

## Upgrade Guide

### From 0.9.x to 1.0.0

```bash
cd ~/.claude/powerkit  # or wherever you cloned
git pull origin main
./scripts/setup.sh
./scripts/setup-enhancements.sh
```

The 1.0.0 release is backward compatible. Your existing CLAUDE.md files will continue to work.

New features are opt-in:
- Run `powerkit doctor` to check installation health
- Run `powerkit sandbox` for permission-controlled execution
- Install Happy Coder with `npm install -g happy-coder` for mobile access
