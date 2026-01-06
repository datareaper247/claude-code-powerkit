#!/bin/zsh
# Claude Code Powerkit Uninstall Script
# Removes powerkit while preserving Claude Code CLI

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
echo "${BLUE}           Claude Code Powerkit Uninstaller                        ${NC}"
echo "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
echo ""

CLAUDE_DIR="$HOME/.claude"

echo "${YELLOW}This will remove:${NC}"
echo "  - Skills directory ($CLAUDE_DIR/skills)"
echo "  - Agents directory ($CLAUDE_DIR/agents)"
echo "  - Skill repositories ($CLAUDE_DIR/skill-repos)"
echo "  - Plugin marketplaces ($CLAUDE_DIR/plugins/marketplaces)"
echo "  - Rules directory ($CLAUDE_DIR/rules)"
echo "  - Powerkit sandbox state ($CLAUDE_DIR/powerkit)"
echo ""
echo "${GREEN}This will KEEP:${NC}"
echo "  - Claude Code CLI"
echo "  - Your CLAUDE.md (backed up)"
echo "  - MCP server configurations"
echo "  - Memory keeper data"
echo ""

read -r "response?Are you sure you want to uninstall? [y/N]: "
if [[ ! "$response" =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

echo ""
echo "${YELLOW}[1/5] Backing up CLAUDE.md...${NC}"
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    cp "$CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md.backup.$(date +%Y%m%d%H%M%S)"
    echo "${GREEN}✓${NC} Backed up to CLAUDE.md.backup.*"
fi

echo "${YELLOW}[2/5] Removing skills...${NC}"
rm -rf "$CLAUDE_DIR/skills"
rm -rf "$CLAUDE_DIR/skill-repos"
echo "${GREEN}✓${NC} Skills removed"

echo "${YELLOW}[3/5] Removing agents...${NC}"
rm -rf "$CLAUDE_DIR/agents"
echo "${GREEN}✓${NC} Agents removed"

echo "${YELLOW}[4/5] Removing plugins and rules...${NC}"
rm -rf "$CLAUDE_DIR/plugins/marketplaces"
rm -rf "$CLAUDE_DIR/rules"
echo "${GREEN}✓${NC} Plugins and rules removed"

echo "${YELLOW}[5/5] Removing powerkit data...${NC}"
rm -rf "$CLAUDE_DIR/powerkit"
rm -f "$CLAUDE_DIR/update-skills.sh"
echo "${GREEN}✓${NC} Powerkit data removed"

# Remove from PATH instruction
echo ""
echo "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
echo "${GREEN}Uninstall Complete!${NC}"
echo "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
echo ""
echo "To complete removal, remove this line from your ~/.zshrc:"
echo "  export PATH=\"\$HOME/.claude/powerkit/bin:\$PATH\""
echo ""
echo "Your CLAUDE.md was backed up. You can restore it with:"
echo "  mv $CLAUDE_DIR/CLAUDE.md.backup.* $CLAUDE_DIR/CLAUDE.md"
echo ""
echo "Claude Code CLI is still installed. To remove it too:"
echo "  npm uninstall -g @anthropic-ai/claude-code"
echo ""
