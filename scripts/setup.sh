#!/bin/bash
# Claude Code Powerkit Setup Script
# Sets up the complete Claude Code enhancement suite

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║           Claude Code Powerkit Setup                              ║"
echo "║           800+ Skills | 251 Agents | 67 Plugins                   ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills"
REPOS_DIR="$CLAUDE_DIR/skill-repos"
AGENTS_DIR="$CLAUDE_DIR/agents"
RULES_DIR="$CLAUDE_DIR/rules"
PLUGINS_DIR="$CLAUDE_DIR/plugins/marketplaces"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Create necessary directories
echo -e "${YELLOW}[1/6] Creating directories...${NC}"
mkdir -p "$SKILLS_DIR" "$REPOS_DIR" "$AGENTS_DIR" "$RULES_DIR" "$PLUGINS_DIR"
echo -e "  ${GREEN}✓${NC} Directories created"

# Copy configuration files
echo -e "${YELLOW}[2/6] Installing configuration files...${NC}"

# Install global CLAUDE.md if not exists or backup existing
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    cp "$CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md.backup.$(date +%Y%m%d)"
    echo -e "  ${CYAN}→${NC} Backed up existing CLAUDE.md"
fi
cp "$PROJECT_DIR/config/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo -e "  ${GREEN}✓${NC} Installed global CLAUDE.md"

# Install rules
cp "$PROJECT_DIR/config/rules/"*.md "$RULES_DIR/" 2>/dev/null || true
echo -e "  ${GREEN}✓${NC} Installed rules files"

# Install update script
cp "$PROJECT_DIR/scripts/update-skills.sh" "$CLAUDE_DIR/update-skills.sh"
chmod +x "$CLAUDE_DIR/update-skills.sh"
echo -e "  ${GREEN}✓${NC} Installed update script"

# Clone repositories
echo -e "${YELLOW}[3/6] Cloning skill repositories (this may take a while)...${NC}"
"$CLAUDE_DIR/update-skills.sh"

# Setup plugin marketplaces
echo -e "${YELLOW}[4/6] Setting up plugin marketplaces...${NC}"

# Update known_marketplaces.json
cat > "$CLAUDE_DIR/plugins/known_marketplaces.json" << 'EOF'
{
  "claude-plugins-official": {
    "source": {
      "source": "github",
      "repo": "anthropics/claude-plugins-official"
    },
    "installLocation": "/Users/$USER/.claude/plugins/marketplaces/claude-plugins-official"
  },
  "wshobson-agents": {
    "source": {
      "source": "github",
      "repo": "wshobson/agents"
    },
    "installLocation": "/Users/$USER/.claude/plugins/marketplaces/wshobson-agents"
  }
}
EOF
# Fix path
sed -i '' "s|\$USER|$USER|g" "$CLAUDE_DIR/plugins/known_marketplaces.json"
echo -e "  ${GREEN}✓${NC} Updated marketplace configuration"

# Create symlinks for easy access
echo -e "${YELLOW}[5/6] Creating convenient symlinks...${NC}"
ln -sf "$CLAUDE_DIR/update-skills.sh" /usr/local/bin/claude-update 2>/dev/null || true
echo -e "  ${GREEN}✓${NC} Created 'claude-update' command (may require sudo)"

# Final summary
echo -e "${YELLOW}[6/6] Verifying installation...${NC}"
SKILL_COUNT=$(ls -1 "$SKILLS_DIR" 2>/dev/null | wc -l | tr -d ' ')
AGENT_COUNT=$(find "$AGENTS_DIR" -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
REPO_COUNT=$(ls -1 "$REPOS_DIR" 2>/dev/null | wc -l | tr -d ' ')

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Setup Complete!${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "  ${CYAN}Skills installed:${NC}      $SKILL_COUNT"
echo -e "  ${CYAN}Agents installed:${NC}      $AGENT_COUNT"
echo -e "  ${CYAN}Repositories cloned:${NC}   $REPO_COUNT"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo -e "  1. Restart Claude Code to load new skills"
echo -e "  2. Use ${CYAN}/plugin${NC} to browse available plugins"
echo -e "  3. Run ${CYAN}~/.claude/update-skills.sh${NC} periodically for updates"
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
