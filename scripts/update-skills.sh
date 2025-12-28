#!/bin/bash
# Claude Code Master Update Script
# Updates all skill repositories, plugins, agents, and refreshes symlinks

set -e

SKILLS_DIR="$HOME/.claude/skills"
REPOS_DIR="$HOME/.claude/skill-repos"
AGENTS_DIR="$HOME/.claude/agents"
PLUGINS_DIR="$HOME/.claude/plugins/marketplaces"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}           Claude Code Master Updater                              ${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
echo ""

# Create directories if they don't exist
mkdir -p "$SKILLS_DIR"
mkdir -p "$REPOS_DIR"
mkdir -p "$AGENTS_DIR"

# Define all repositories to maintain
declare -A REPOS=(
    # Official & Core Skills
    ["anthropics-skills"]="https://github.com/anthropics/skills.git"
    ["obra-superpowers"]="https://github.com/obra/superpowers.git"
    ["obra-superpowers-lab"]="https://github.com/obra/superpowers-lab.git"

    # Scientific & Research
    ["scientific-skills"]="https://github.com/K-Dense-AI/claude-scientific-skills.git"
    ["zechenzhang-ai-research-skills"]="https://github.com/zechenzhangAGI/AI-research-SKILLs.git"

    # Development Tools
    ["playwright-skill"]="https://github.com/lackeyjb/playwright-skill.git"
    ["ios-simulator-skill"]="https://github.com/conorluddy/ios-simulator-skill.git"
    ["d3js-skill"]="https://github.com/Quasimondo/claude-d3js-skill.git"
    ["ffuf-skill"]="https://github.com/anonette/claude-ffuf-skill.git"
    ["web-asset-generator"]="https://github.com/webscape-io/web-asset-generator.git"

    # Professional Skill Collections
    ["daymade-claude-code-skills"]="https://github.com/daymade/claude-code-skills.git"
    ["jwiegley-claude-prompts"]="https://github.com/jwiegley/claude-prompts.git"
    ["alirezarezvani-claude-skills"]="https://github.com/alirezarezvani/claude-skills.git"
    ["maxritter-claude-codepro"]="https://github.com/maxritter/claude-codepro.git"
    ["fcakyon-claude-codex-settings"]="https://github.com/fcakyon/claude-codex-settings.git"
    ["feiskyer-settings"]="https://github.com/feiskyer/claude-code-settings.git"

    # Framework-Specific
    ["asiaostrich-universal-dev-skills"]="https://github.com/AsiaOstrich/universal-dev-skills.git"
    ["alec-c4-rails-skills"]="https://github.com/alec-c4/claude-skills-rails-dev.git"
    ["wrsmith108-linear-skill"]="https://github.com/wrsmith108/linear-claude-skill.git"
    ["levnikolaevich-claude-skills"]="https://github.com/levnikolaevich/claude-code-skills.git"

    # Agents & Subagents
    ["voltagent-subagents"]="https://github.com/VoltAgent/awesome-claude-code-subagents.git"
    ["wshobson-agents"]="https://github.com/wshobson/agents.git"
    ["wshobson-commands"]="https://github.com/wshobson/commands.git"
    ["lst97-subagents"]="https://github.com/lst97/claude-code-sub-agents.git"
    ["chusri-agents"]="https://github.com/chusri/claude-code-agents.git"
    ["rahulvrane-agents"]="https://github.com/rahulvrane/awesome-claude-agents.git"

    # Plugins & Extensions
    ["ccplugins-awesome"]="https://github.com/ccplugins/awesome-claude-code-plugins.git"
    ["jeremylongshore-plugins-skills"]="https://github.com/jeremylongshore/claude-code-plugins-plus-skills.git"
    ["dev-gom-marketplace"]="https://github.com/Dev-GOM/claude-code-marketplace.git"
    ["hekmon8-plugins"]="https://github.com/hekmon8/awesome-claude-code-plugins.git"

    # Reference & Documentation
    ["hesreallyhim-awesome-claude-code"]="https://github.com/hesreallyhim/awesome-claude-code.git"
    ["jqueryscript-awesome"]="https://github.com/jqueryscript/awesome-claude-code.git"
    ["awesome-mcp-servers"]="https://github.com/punkpeye/awesome-mcp-servers.git"
    ["mcp-official-servers"]="https://github.com/modelcontextprotocol/servers.git"

    # Video & Media
    ["tillo13-video-creator"]="https://github.com/tillo13/ai_video_creator.git"
    ["davide97l-video-generator"]="https://github.com/davide97l/ai-video-generator.git"
)

updated=0
cloned=0
failed=0

echo -e "${YELLOW}[1/4] Updating ${#REPOS[@]} repositories...${NC}"
echo ""

for repo_name in "${!REPOS[@]}"; do
    repo_url="${REPOS[$repo_name]}"
    repo_path="$REPOS_DIR/$repo_name"

    if [ -d "$repo_path" ]; then
        echo -ne "  Updating ${CYAN}$repo_name${NC}..."
        cd "$repo_path"
        if git pull --quiet 2>/dev/null; then
            echo -e " ${GREEN}✓${NC}"
            ((updated++))
        else
            echo -e " ${RED}✗${NC}"
            ((failed++))
        fi
    else
        echo -ne "  Cloning ${CYAN}$repo_name${NC}..."
        if git clone --quiet "$repo_url" "$repo_path" 2>/dev/null; then
            echo -e " ${GREEN}✓ (new)${NC}"
            ((cloned++))
        else
            echo -e " ${RED}✗${NC}"
            ((failed++))
        fi
    fi
done

echo ""
echo -e "${YELLOW}[2/4] Refreshing skill symlinks...${NC}"

new_skills=0
for repo_dir in "$REPOS_DIR"/*/; do
    repo_name=$(basename "$repo_dir" | tr '[:upper:]' '[:lower:]')

    while IFS= read -r skill_file; do
        skill_name=$(dirname "$skill_file" | xargs basename)
        link_name="${repo_name}--${skill_name}.md"
        target="$SKILLS_DIR/$link_name"

        if [ ! -L "$target" ] && [ ! -e "$target" ]; then
            ln -s "$skill_file" "$target"
            ((new_skills++))
        fi
    done < <(find "$repo_dir" -name "SKILL.md" -type f 2>/dev/null)
done
echo -e "  ${GREEN}+${NC} $new_skills new skills added"

echo ""
echo -e "${YELLOW}[3/4] Updating agents...${NC}"

# Update agents from various sources
new_agents=0
for source in feiskyer lst97 chusri rahulvrane; do
    src_dir="$REPOS_DIR/${source}-*"
    for repo in $src_dir; do
        if [ -d "$repo" ]; then
            mkdir -p "$AGENTS_DIR/$source"
            while IFS= read -r agent_file; do
                dest="$AGENTS_DIR/$source/$(basename "$agent_file")"
                if [ ! -e "$dest" ]; then
                    cp "$agent_file" "$dest"
                    ((new_agents++))
                fi
            done < <(find "$repo" -name "*.md" -path "*agents*" -type f 2>/dev/null)
        fi
    done
done
echo -e "  ${GREEN}+${NC} $new_agents new agents added"

echo ""
echo -e "${YELLOW}[4/4] Updating plugin marketplaces...${NC}"

# Update wshobson marketplace
if [ -d "$REPOS_DIR/wshobson-agents" ]; then
    mkdir -p "$PLUGINS_DIR/wshobson-agents"
    cp -r "$REPOS_DIR/wshobson-agents/plugins" "$PLUGINS_DIR/wshobson-agents/" 2>/dev/null
    echo -e "  ${GREEN}✓${NC} wshobson-agents marketplace (67 plugins)"
fi

# Count totals
total_skills=$(ls -1 "$SKILLS_DIR" 2>/dev/null | wc -l | tr -d ' ')
total_agents=$(find "$AGENTS_DIR" -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Summary:${NC}"
echo -e "  Repositories updated:   ${updated}"
echo -e "  Repositories cloned:    ${cloned}"
echo -e "  Failed:                 ${failed}"
echo -e "  New skills added:       ${new_skills}"
echo -e "  New agents added:       ${new_agents}"
echo -e "  ─────────────────────────────────"
echo -e "  ${CYAN}Total Skills:${NC}           ${total_skills}"
echo -e "  ${CYAN}Total Agents:${NC}           ${total_agents}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
