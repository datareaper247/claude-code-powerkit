# Claude Code Powerkit Enhancements

Complete guide to advanced features including Gemini CLI integration, autonomous agents, mobile development, computer use, and containerization.

---

## Table of Contents

1. [Gemini CLI Integration](#1-gemini-cli-integration)
2. [Autonomous Agents (AutoGPT-like)](#2-autonomous-agents-autogpt-like)
3. [Computer Use](#3-computer-use)
4. [Mobile Development (React Native + iOS + Android)](#4-mobile-development)
5. [Containerization & Sandboxing](#5-containerization--sandboxing)
6. [New MCP Servers to Install](#6-new-mcp-servers-to-install)
7. [Best Repos & Resources](#7-best-repos--resources)

---

## 1. Gemini CLI Integration

### Installation

```bash
# Install globally
npm install -g @google/gemini-cli

# Or run with npx (no install)
npx https://github.com/google-gemini/gemini-cli
```

### Authentication (Google One AI Premium)

Since you have Google One AI Premium, authenticate with your Google account:

```bash
gemini
# Select "Login with Google" when prompted
# Complete browser sign-in
```

**Free Tier Limits**: 60 requests/min, 1,000 requests/day with 1M token context window.

### When to Use Gemini vs Claude

| Use Gemini For | Use Claude For |
|----------------|----------------|
| **Massive context** (1M+ tokens) | **Best coding** (SWE-bench leader) |
| **Real-time Google Search** grounding | **Structured, reliable output** |
| **Speed-critical** tasks | **Nuanced reasoning** |
| **Cost-sensitive** projects (20x cheaper) | **Autonomous agentic loops** (30+ hrs) |
| **Google Workspace** integration | **Enterprise safety** requirements |
| **Quick functional builds** | **Complex refactoring** |
| **Video generation** | **Code review & debugging** |
| **PhD-level reasoning** (Deep Think mode) | **Step-by-step explanations** |

### MCP Integration (Recommended)

The `gemini-cli` MCP server allows Claude to automatically delegate tasks to Gemini:

```bash
# Already installed! Verify with:
claude mcp list
# Should show: gemini-cli: npx -y gemini-mcp-tool - ✓ Connected
```

**Available Tools:**
- `ask-gemini` - Query Gemini for analysis, questions, file processing
- `sandbox-test` - Execute code in isolated sandbox

**Usage Examples:**
```
# Analyze large file
ask gemini to analyze @src/large-module.ts

# Get second opinion
ask gemini: is this the best approach for authentication?

# Analyze codebase
use gemini to summarize @./src the directory structure

# Search for latest info
search for React 19 features using gemini
```

### Claude Code Integration Rule

Add to `~/.claude/CLAUDE.md`:

```markdown
## Gemini CLI Integration

When to delegate to Gemini CLI:
- Processing files larger than 100K tokens
- Tasks requiring real-time web search
- Google Workspace integrations
- Quick prototypes where speed > quality
- Cost-sensitive batch processing

Usage:
\`\`\`bash
# Run Gemini for specific tasks
gemini "analyze this large codebase for patterns"

# Non-interactive mode for scripts
gemini --non-interactive "summarize changes"
\`\`\`

Gemini excels at: massive context, Google Search, speed, cost
Claude excels at: coding, structured output, reasoning, agentic loops
```

**Resources**:
- [Official GitHub](https://github.com/google-gemini/gemini-cli)
- [Getting Started Guide](https://geminicli.com/docs/get-started/)
- [Google Codelabs Tutorial](https://codelabs.developers.google.com/gemini-cli-hands-on)

---

## 2. Autonomous Agents (AutoGPT-like)

### Option A: Continuous Claude (Recommended)

Runs Claude Code in continuous loops, creating PRs, monitoring CI, and merging.

**Installation**:
```bash
curl -fsSL https://raw.githubusercontent.com/AnandChowdhary/continuous-claude/main/install.sh | bash
```

**Requirements**: Claude Code CLI, GitHub CLI (`gh`), `jq`

**Usage**:
```bash
# Run with iteration limit
continuous-claude --prompt "add unit tests until 80% coverage" --max-runs 10

# Run with cost budget
continuous-claude --prompt "refactor auth system" --max-cost 50.00

# Run with time limit
continuous-claude --prompt "fix all linting errors" --max-duration 2h

# Parallel execution with worktrees
continuous-claude --prompt "write tests" --worktree tests &
continuous-claude --prompt "update docs" --worktree docs &
```

**Key Features**:
- Persistent context via `SHARED_TASK_NOTES.md`
- Automatic PR creation/merge workflow
- Cost/time budgets prevent runaway spending
- Early stopping when task completes

**Repository**: [AnandChowdhary/continuous-claude](https://github.com/AnandChowdhary/continuous-claude)

---

### Option B: Ralph for Claude Code

Autonomous development loop with intelligent exit detection and monitoring.

**Installation**:
```bash
git clone https://github.com/frankbria/ralph-claude-code
cd ralph-claude-code
./install.sh  # One-time global setup
```

**Per-Project Setup**:
```bash
ralph-setup my-project
# or import existing requirements
ralph-import existing-requirements.md
```

**Usage**:
```bash
# Run with tmux monitoring
ralph --monitor

# Verbose mode with timeout
ralph --verbose --timeout 30

# Separate monitoring dashboard
ralph-monitor
```

**Key Features**:
- tmux dashboard for real-time status
- Rate limiting (100 API calls/hour)
- Circuit breaker for API limits
- Structured task lists via `@fix_plan.md`

**Repository**: [frankbria/ralph-claude-code](https://github.com/frankbria/ralph-claude-code)

---

### Creating Your Own Autonomous Loop

Add to `~/.claude/commands/autonomous/forever-loop.md`:

```markdown
# /autonomous/forever-loop

Run Claude Code in a continuous improvement loop on your todo list.

## Usage
\`\`\`bash
/autonomous/forever-loop [max-iterations] [focus-area]
\`\`\`

## Workflow
1. Read current todo list from memory-keeper
2. Pick highest priority incomplete task
3. Execute task using appropriate tools
4. Mark task complete, add new discovered tasks
5. Ask user for clarification if blocked
6. Repeat until all tasks complete or max iterations

## Safety
- Max 20 iterations per run (configurable)
- Checkpoints every 5 iterations
- Asks user before destructive operations
- Saves all progress to memory-keeper
```

---

## 3. Computer Use

### Official Reference Implementation

```bash
# Clone Anthropic's quickstarts
git clone https://github.com/anthropics/claude-quickstarts
cd claude-quickstarts/computer-use-demo

# Run with Docker
docker build -t computer-use .
docker run -p 8080:8080 computer-use
```

**Features**:
- Web interface for computer control
- Mouse, keyboard, screenshot tools
- Claude 4 computer_use_20251124 tool version
- XGA resolution (1024x768) recommended

### Node.js Implementation

```bash
# Community TypeScript port
git clone https://github.com/ashbuilds/computer-use
cd computer-use
npm install
```

**Resources**:
- [Official Docs](https://docs.claude.com/en/docs/agents-and-tools/tool-use/computer-use-tool)
- [Anthropic Quickstarts](https://github.com/anthropics/claude-quickstarts)
- [Anthropic Engineering Blog](https://www.anthropic.com/news/3-5-models-and-computer-use)

---

## 4. Mobile Development

### React Native as Common Base

**Recommended MCP Servers**:

1. **Mobile MCP** (iOS + Android unified)
   ```bash
   claude mcp add mobile-mcp -- npx -y @mobilenext/mobile-mcp@latest
   ```

2. **iOS Simulator MCP**
   ```bash
   claude mcp add ios-simulator -- npx -y ios-simulator-mcp
   ```

3. **Android Debug Bridge MCP**
   ```bash
   npm install -g android-debug-bridge-mcp
   claude mcp add --scope project android-debug-bridge-mcp -- npx android-debug-bridge-mcp
   ```

### iOS Simulator Recording

**Prerequisites**: macOS, Xcode, iOS Simulator

**MCP Configuration** (`~/.config/claude/mcp.json`):
```json
{
  "mcpServers": {
    "ios-simulator": {
      "command": "npx",
      "args": ["-y", "ios-simulator-mcp"],
      "env": {
        "IOS_SIMULATOR_MCP_DEFAULT_OUTPUT_DIR": "~/Downloads"
      }
    }
  }
}
```

**Available Tools**:
| Tool | Description |
|------|-------------|
| `screenshot` | Capture simulator screen |
| `record_video` | Start video recording (h264/hevc) |
| `stop_recording` | Stop current recording |
| `ui_tap` | Tap at coordinates |
| `ui_swipe` | Swipe gesture |
| `ui_type` | Input text |
| `ui_describe_all` | Get all accessibility elements |
| `launch_app` | Open app by bundle ID |
| `install_app` | Deploy .app or .ipa |

**Manual Recording**:
```bash
# Start recording
xcrun simctl io booted recordVideo video.mp4

# Stop with Ctrl+C
```

**Resources**:
- [ios-simulator-mcp](https://github.com/joshuayoes/ios-simulator-mcp)
- [mcp-ios-simulator-screenshot](https://github.com/yorifuji/mcp-ios-simulator-screenshot)
- [simctl-mcp-server](https://github.com/nzrsky/simctl-mcp-server)

---

### Android Emulator Recording

**Prerequisites**: Android Studio, Android SDK, ADB

**MCP Configuration**:
```json
{
  "mcpServers": {
    "android-adb": {
      "command": "npx",
      "args": ["-y", "android-debug-bridge-mcp"]
    }
  }
}
```

**Manual Recording**:
```bash
# Start recording (max 3 min)
adb shell screenrecord /sdcard/recording.mp4

# With options
adb shell screenrecord --size 1280x720 --bit-rate 4000000 /sdcard/recording.mp4

# Pull to local
adb pull /sdcard/recording.mp4 ./

# Multiple devices
adb -s emulator-5556 shell screenrecord /sdcard/demo.mp4
```

**Resources**:
- [Mobile MCP Wiki](https://github.com/mobile-next/mobile-mcp/wiki/Getting-Started-with-Android-Emulator)
- [android-debug-bridge-mcp](https://www.npmjs.com/package/android-debug-bridge-mcp)

---

### React Native Skill

Add to `~/.claude/skills/react-native-dev.md`:

```markdown
# React Native Development Skill

## When to Activate
- Working on .tsx/.jsx files with React Native imports
- Package.json contains "react-native"
- Expo projects (app.json/app.config.js)

## Best Practices
1. Use NativeWind (Tailwind CSS) for styling
2. Implement proper TypeScript types
3. Use React Navigation for routing
4. State management: Zustand or TanStack Query
5. Testing: Detox for E2E, Jest for unit

## Mobile MCP Integration
- Use `mobile-mcp` for cross-platform automation
- Capture screenshots for visual verification
- Record videos for demo/documentation

## Commands
- `npx react-native start` - Start Metro
- `npx react-native run-ios` - Build iOS
- `npx react-native run-android` - Build Android
```

**NativeWind UI Generator Skill**: [MCPMarket](https://mcpmarket.com/tools/skills/nativewind-ui-generator)

---

## 5. Containerization & Sandboxing

### Option A: Claude Code Sandbox (Recommended)

Safe Docker wrapper with `--dangerously-skip-permissions` enabled safely.

**Installation**:
```bash
git clone https://github.com/rvaidya/claude-code-sandbox
cd claude-code-sandbox
chmod +x claude-code-sandbox
sudo ln -sf "$(pwd)/claude-code-sandbox" /usr/local/bin/
```

**Usage**:
```bash
# Basic usage (mounts current directory as /workspace)
claude-code-sandbox

# Build with specific tools
claude-code-sandbox --build --install='python@3.12.8,nodejs@20.11.0'

# Using .tool-versions
echo "python 3.12.8
nodejs 20.11.0" > .tool-versions
claude-code-sandbox --build

# Interactive shell for debugging
claude-code-sandbox --shell

# Enable Docker inside container
claude-code-sandbox --docker
```

**Security Benefits**:
- Host system protected from all modifications
- Only mounted `/workspace` is accessible
- Supports 500+ development tools via asdf
- Automatic config mounting (npm, pip, etc.)

**Repository**: [rvaidya/claude-code-sandbox](https://github.com/rvaidya/claude-code-sandbox)

---

### Option B: Docker Sandboxes (Official)

```bash
# Run with Docker Sandbox (official Anthropic integration)
docker run -it -v $(pwd):/mnt/user anthropic/claude-sandbox claude
```

**Documentation**: [Docker Sandboxes](https://docs.docker.com/ai/sandboxes/claude-code/)

---

### Option C: DevContainers

For VSCode/Cursor integration:

`.devcontainer/devcontainer.json`:
```json
{
  "name": "Claude Code Safe Environment",
  "image": "mcr.microsoft.com/devcontainers/typescript-node:1-22",
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:2": {}
  },
  "mounts": [
    "source=${localEnv:HOME}/.claude,target=/root/.claude,type=bind"
  ],
  "postCreateCommand": "npm install -g @anthropic-ai/claude-code",
  "remoteUser": "root"
}
```

**Resources**:
- [DevContainer Guide](https://codewithandrea.com/articles/run-ai-agents-inside-devcontainer/)
- [Official Sandboxing Docs](https://code.claude.com/docs/en/sandboxing)

---

## 6. New MCP Servers to Install

### Essential MCPs for Mobile Development

```json
{
  "mcpServers": {
    "mobile-mcp": {
      "command": "npx",
      "args": ["-y", "@mobilenext/mobile-mcp@latest"],
      "description": "iOS + Android unified automation"
    },
    "ios-simulator": {
      "command": "npx",
      "args": ["-y", "ios-simulator-mcp"],
      "description": "iOS Simulator control & recording"
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-playwright"],
      "description": "Browser automation & testing"
    },
    "code-sandbox": {
      "command": "npx",
      "args": ["-y", "@anthropic/code-sandbox-mcp"],
      "description": "Safe code execution in Docker"
    }
  }
}
```

### Install Commands

```bash
# Mobile development
claude mcp add mobile-mcp -- npx -y @mobilenext/mobile-mcp@latest
claude mcp add ios-simulator -- npx -y ios-simulator-mcp

# Automation
claude mcp add playwright -- npx -y @anthropic/mcp-playwright

# Already installed (verify)
claude mcp list
```

---

## 7. Best Repos & Resources

### Computer Use
| Repository | Description |
|------------|-------------|
| [anthropics/claude-quickstarts](https://github.com/anthropics/claude-quickstarts) | Official reference implementation |
| [ashbuilds/computer-use](https://github.com/ashbuilds/computer-use) | Node.js/TypeScript port |
| [alvinunreal/awesome-claude](https://github.com/alvinunreal/awesome-claude) | Curated Claude resources |

### Autonomous Agents
| Repository | Description |
|------------|-------------|
| [AnandChowdhary/continuous-claude](https://github.com/AnandChowdhary/continuous-claude) | Continuous loop with PR automation |
| [frankbria/ralph-claude-code](https://github.com/frankbria/ralph-claude-code) | Autonomous loop with monitoring |
| [LostAbaddon/AutoClaude](https://github.com/LostAbaddon/AutoClaude) | AutoGPT-style for Claude |

### Mobile Development
| Repository | Description |
|------------|-------------|
| [mobile-next/mobile-mcp](https://github.com/mobile-next/mobile-mcp) | Cross-platform mobile automation |
| [joshuayoes/ios-simulator-mcp](https://github.com/joshuayoes/ios-simulator-mcp) | iOS Simulator control |
| [nzrsky/simctl-mcp-server](https://github.com/nzrsky/simctl-mcp-server) | iOS simctl wrapper |

### Containerization
| Repository | Description |
|------------|-------------|
| [rvaidya/claude-code-sandbox](https://github.com/rvaidya/claude-code-sandbox) | Docker sandbox wrapper |
| [textcortex/claude-code-sandbox](https://github.com/textcortex/claude-code-sandbox) | Alternative sandbox |
| [Automata-Labs-team/code-sandbox-mcp](https://github.com/Automata-Labs-team/code-sandbox-mcp) | MCP for code sandboxing |

### Skills & Workflows
| Repository | Description |
|------------|-------------|
| [travisvn/awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills) | Curated skills list |
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | Comprehensive resources |
| [obra/superpowers](https://github.com/obra/superpowers) | Core TDD/debugging skills |

### Gemini CLI
| Resource | Description |
|----------|-------------|
| [google-gemini/gemini-cli](https://github.com/google-gemini/gemini-cli) | Official repository |
| [Gemini CLI Cheatsheet](https://www.philschmid.de/gemini-cli-cheatsheet) | Quick reference |
| [DataCamp Tutorial](https://www.datacamp.com/tutorial/gemini-cli) | Practical examples |

---

## Quick Setup Checklist

```bash
# 1. Install Gemini CLI
npm install -g @google/gemini-cli
gemini  # Login with Google

# 2. Install Continuous Claude
curl -fsSL https://raw.githubusercontent.com/AnandChowdhary/continuous-claude/main/install.sh | bash

# 3. Install Mobile MCPs
claude mcp add mobile-mcp -- npx -y @mobilenext/mobile-mcp@latest
claude mcp add ios-simulator -- npx -y ios-simulator-mcp

# 4. Install Claude Code Sandbox
git clone https://github.com/rvaidya/claude-code-sandbox ~/tools/claude-code-sandbox
sudo ln -sf ~/tools/claude-code-sandbox/claude-code-sandbox /usr/local/bin/

# 5. Verify installations
gemini --version
continuous-claude --help
claude mcp list
claude-code-sandbox --help
```

---

## Sources

- [Gemini CLI Official](https://github.com/google-gemini/gemini-cli)
- [Anthropic Computer Use Docs](https://docs.claude.com/en/docs/agents-and-tools/tool-use/computer-use-tool)
- [Claude Code Sandboxing](https://www.anthropic.com/engineering/claude-code-sandboxing)
- [iOS Simulator MCP](https://github.com/joshuayoes/ios-simulator-mcp)
- [Mobile MCP](https://github.com/mobile-next/mobile-mcp)
- [Continuous Claude](https://github.com/AnandChowdhary/continuous-claude)
- [Claude Code Sandbox](https://github.com/rvaidya/claude-code-sandbox)
- [Claude vs Gemini Comparison](https://www.index.dev/blog/gemini-vs-claude-for-coding)
