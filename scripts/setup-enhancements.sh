#!/bin/zsh
# Setup script for Claude Code Powerkit Enhancements
# Run this after the main setup.sh

set -e

echo "=========================================="
echo "Claude Code Powerkit - Enhancements Setup"
echo "=========================================="

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

success() { echo "${GREEN}✓ $1${NC}"; }
warn() { echo "${YELLOW}! $1${NC}"; }
error() { echo "${RED}✗ $1${NC}"; }

# Check Node.js version
NODE_VERSION=$(node -v 2>/dev/null | cut -d'v' -f2 | cut -d'.' -f1)
if [ -z "$NODE_VERSION" ] || [ "$NODE_VERSION" -lt 20 ]; then
    error "Node.js 20+ required. Current: $(node -v 2>/dev/null || echo 'not installed')"
    exit 1
fi
success "Node.js version OK: $(node -v)"

# 1. Install Gemini CLI
echo ""
echo "1. Installing Gemini CLI..."
if command -v gemini &> /dev/null; then
    success "Gemini CLI already installed"
else
    npm install -g @google/gemini-cli
    success "Gemini CLI installed"
    echo "   Run 'gemini' and login with your Google account"
fi

# 2. Install Continuous Claude
echo ""
echo "2. Installing Continuous Claude..."
if command -v continuous-claude &> /dev/null; then
    success "Continuous Claude already installed"
else
    curl -fsSL https://raw.githubusercontent.com/AnandChowdhary/continuous-claude/main/install.sh | bash
    success "Continuous Claude installed"
fi

# 3. Install Claude Code Sandbox
echo ""
echo "3. Installing Claude Code Sandbox..."
SANDBOX_DIR="$HOME/tools/claude-code-sandbox"
if [ -d "$SANDBOX_DIR" ]; then
    success "Claude Code Sandbox already cloned"
else
    mkdir -p ~/tools
    git clone https://github.com/rvaidya/claude-code-sandbox "$SANDBOX_DIR"
    chmod +x "$SANDBOX_DIR/claude-code-sandbox"
    sudo ln -sf "$SANDBOX_DIR/claude-code-sandbox" /usr/local/bin/claude-code-sandbox 2>/dev/null || \
        ln -sf "$SANDBOX_DIR/claude-code-sandbox" ~/.local/bin/claude-code-sandbox
    success "Claude Code Sandbox installed"
fi

# 4. Install Mobile MCP Servers
echo ""
echo "4. Installing Mobile MCP Servers..."

# Check if claude CLI is available
if ! command -v claude &> /dev/null; then
    warn "Claude CLI not found. Install MCPs manually later."
else
    # Add mobile-mcp
    claude mcp add mobile-mcp -- npx -y @mobilenext/mobile-mcp@latest 2>/dev/null || true
    success "Mobile MCP added"

    # Add ios-simulator (macOS only)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        claude mcp add ios-simulator -- npx -y ios-simulator-mcp 2>/dev/null || true
        success "iOS Simulator MCP added"
    fi
fi

# 5. Install Android Debug Bridge MCP
echo ""
echo "5. Installing Android Debug Bridge MCP..."
npm install -g android-debug-bridge-mcp 2>/dev/null || warn "Android ADB MCP install failed (may need sudo)"
success "Android Debug Bridge MCP installed (if ADB is available)"

# 6. Clone Ralph for Claude Code
echo ""
echo "6. Installing Ralph for Claude Code..."
RALPH_DIR="$HOME/tools/ralph-claude-code"
if [ -d "$RALPH_DIR" ]; then
    success "Ralph already cloned"
else
    git clone https://github.com/frankbria/ralph-claude-code "$RALPH_DIR"
    cd "$RALPH_DIR" && ./install.sh 2>/dev/null || warn "Ralph install script may need manual run"
    success "Ralph installed"
fi

# 7. Clone Computer Use Reference Implementation
echo ""
echo "7. Cloning Computer Use Reference..."
COMPUTER_USE_DIR="$HOME/tools/anthropic-quickstarts"
if [ -d "$COMPUTER_USE_DIR" ]; then
    success "Anthropic Quickstarts already cloned"
else
    git clone https://github.com/anthropics/claude-quickstarts "$COMPUTER_USE_DIR"
    success "Computer Use reference cloned to $COMPUTER_USE_DIR"
fi

# 8. Verify installations
echo ""
echo "=========================================="
echo "Verification"
echo "=========================================="

echo ""
echo "Installed tools:"
command -v gemini &> /dev/null && success "gemini" || warn "gemini (run 'gemini' to setup)"
command -v continuous-claude &> /dev/null && success "continuous-claude" || warn "continuous-claude"
command -v claude-code-sandbox &> /dev/null && success "claude-code-sandbox" || warn "claude-code-sandbox"
command -v ralph &> /dev/null && success "ralph" || warn "ralph (may need PATH update)"

echo ""
echo "MCP Servers (verify with 'claude mcp list'):"
echo "  - mobile-mcp"
echo "  - ios-simulator (macOS)"
echo "  - android-debug-bridge-mcp"

echo ""
echo "=========================================="
echo "Next Steps"
echo "=========================================="
echo ""
echo "1. Run 'gemini' and login with your Google account"
echo "2. Verify MCPs: claude mcp list"
echo "3. Test sandbox: claude-code-sandbox --help"
echo "4. Read docs: cat docs/POWERKIT-ENHANCEMENTS.md"
echo ""
echo "For iOS development:"
echo "  - Ensure Xcode is installed"
echo "  - Install IDB: brew install facebook/fb/idb-companion"
echo ""
echo "For Android development:"
echo "  - Ensure Android Studio is installed"
echo "  - Ensure ANDROID_HOME is set"
echo "  - Ensure adb is in PATH"
echo ""
success "Enhancement setup complete!"
