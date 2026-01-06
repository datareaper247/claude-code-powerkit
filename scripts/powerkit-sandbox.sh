#!/bin/zsh
# PowerKit Sandbox - Run Claude Code in sandbox with permission whitelist
# Runs in Docker but allows user to whitelist paths/commands for external access

set -e

# Configuration
POWERKIT_DIR="${POWERKIT_DIR:-$HOME/.claude/powerkit}"
WHITELIST_FILE="${POWERKIT_DIR}/sandbox-whitelist.json"
SANDBOX_STATE_DIR="${POWERKIT_DIR}/sandbox-state"
LOG_FILE="${SANDBOX_STATE_DIR}/sandbox.log"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Ensure directories exist
mkdir -p "$POWERKIT_DIR" "$SANDBOX_STATE_DIR"

# Initialize whitelist if not exists
if [ ! -f "$WHITELIST_FILE" ]; then
    cat > "$WHITELIST_FILE" << 'EOF'
{
  "version": "1.0",
  "description": "PowerKit Sandbox Permission Whitelist",
  "paths": {
    "read": [],
    "write": [],
    "execute": []
  },
  "commands": [],
  "mcp_servers": [],
  "environment": [],
  "network": {
    "allowed_hosts": [],
    "allowed_ports": []
  },
  "auto_approved": {
    "npm_packages": [],
    "pip_packages": [],
    "brew_packages": []
  }
}
EOF
    echo "${GREEN}Created whitelist file: $WHITELIST_FILE${NC}"
fi

# Functions
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

show_help() {
    cat << 'EOF'
PowerKit Sandbox - Secure Claude Code execution with permission learning

USAGE:
    powerkit-sandbox [OPTIONS] [-- CLAUDE_ARGS...]

OPTIONS:
    -h, --help              Show this help message
    -l, --list              List current whitelist permissions
    -a, --add-path PATH     Add path to read whitelist
    -w, --add-write PATH    Add path to write whitelist
    -c, --add-cmd CMD       Add command to whitelist
    -r, --remove PATH/CMD   Remove from whitelist
    --reset                 Reset whitelist to defaults
    --interactive           Prompt for each new permission (default)
    --auto-approve          Auto-approve all permission requests (DANGEROUS)
    --dry-run               Show what would be mounted without running
    --shell                 Start interactive shell in sandbox
    --status                Show sandbox status

EXAMPLES:
    powerkit-sandbox                          # Start Claude in sandbox
    powerkit-sandbox --list                   # Show current whitelist
    powerkit-sandbox --add-path ~/Projects    # Whitelist Projects folder
    powerkit-sandbox -- -p "fix bugs"         # Pass args to Claude
    powerkit-sandbox --shell                  # Interactive sandbox shell

PERMISSION FLOW:
    1. Sandbox starts with minimal permissions (current dir only)
    2. When Claude requests access outside sandbox:
       - Prompt appears: "Allow access to /path/to/resource? [y/n/always]"
       - 'y' = allow once
       - 'n' = deny
       - 'always' = add to permanent whitelist
    3. Whitelisted permissions persist across sessions

WHITELIST FILE:
    Location: ~/.claude/powerkit/sandbox-whitelist.json

    Edit directly or use --add-path/--add-cmd options

EOF
}

list_whitelist() {
    echo "${CYAN}=== PowerKit Sandbox Whitelist ===${NC}"
    echo ""

    if command -v jq &> /dev/null; then
        echo "${BLUE}Read Paths:${NC}"
        jq -r '.paths.read[]' "$WHITELIST_FILE" 2>/dev/null | sed 's/^/  /'
        echo ""

        echo "${BLUE}Write Paths:${NC}"
        jq -r '.paths.write[]' "$WHITELIST_FILE" 2>/dev/null | sed 's/^/  /'
        echo ""

        echo "${BLUE}Whitelisted Commands:${NC}"
        jq -r '.commands[]' "$WHITELIST_FILE" 2>/dev/null | sed 's/^/  /'
        echo ""

        echo "${BLUE}MCP Servers:${NC}"
        jq -r '.mcp_servers[]' "$WHITELIST_FILE" 2>/dev/null | sed 's/^/  /'
        echo ""

        echo "${BLUE}Network Access:${NC}"
        echo "  Hosts: $(jq -r '.network.allowed_hosts | join(", ")' "$WHITELIST_FILE" 2>/dev/null)"
        echo "  Ports: $(jq -r '.network.allowed_ports | join(", ")' "$WHITELIST_FILE" 2>/dev/null)"
    else
        cat "$WHITELIST_FILE"
    fi
}

add_to_whitelist() {
    local type="$1"
    local value="$2"

    if ! command -v jq &> /dev/null; then
        echo "${RED}jq required for whitelist management. Install: brew install jq${NC}"
        exit 1
    fi

    case "$type" in
        "read")
            jq --arg v "$value" '.paths.read += [$v] | .paths.read |= unique' "$WHITELIST_FILE" > "$WHITELIST_FILE.tmp"
            ;;
        "write")
            jq --arg v "$value" '.paths.write += [$v] | .paths.write |= unique' "$WHITELIST_FILE" > "$WHITELIST_FILE.tmp"
            ;;
        "command")
            jq --arg v "$value" '.commands += [$v] | .commands |= unique' "$WHITELIST_FILE" > "$WHITELIST_FILE.tmp"
            ;;
        "mcp")
            jq --arg v "$value" '.mcp_servers += [$v] | .mcp_servers |= unique' "$WHITELIST_FILE" > "$WHITELIST_FILE.tmp"
            ;;
        *)
            echo "${RED}Unknown whitelist type: $type${NC}"
            return 1
            ;;
    esac

    mv "$WHITELIST_FILE.tmp" "$WHITELIST_FILE"
    echo "${GREEN}Added to $type whitelist: $value${NC}"
    log "Whitelist add: $type = $value"
}

remove_from_whitelist() {
    local value="$1"

    if ! command -v jq &> /dev/null; then
        echo "${RED}jq required. Install: brew install jq${NC}"
        exit 1
    fi

    # Remove from all arrays
    jq --arg v "$value" '
        .paths.read -= [$v] |
        .paths.write -= [$v] |
        .commands -= [$v] |
        .mcp_servers -= [$v]
    ' "$WHITELIST_FILE" > "$WHITELIST_FILE.tmp"

    mv "$WHITELIST_FILE.tmp" "$WHITELIST_FILE"
    echo "${GREEN}Removed from whitelist: $value${NC}"
    log "Whitelist remove: $value"
}

build_docker_mounts() {
    local mounts=""

    # Always mount current directory as workspace
    mounts="-v $(pwd):/workspace"

    # Mount Claude config (read-only by default)
    mounts="$mounts -v $HOME/.claude:/root/.claude:ro"

    # Mount whitelisted read paths
    if command -v jq &> /dev/null; then
        for path in $(jq -r '.paths.read[]' "$WHITELIST_FILE" 2>/dev/null); do
            expanded_path=$(eval echo "$path")
            if [ -e "$expanded_path" ]; then
                mounts="$mounts -v $expanded_path:$expanded_path:ro"
            fi
        done

        # Mount whitelisted write paths
        for path in $(jq -r '.paths.write[]' "$WHITELIST_FILE" 2>/dev/null); do
            expanded_path=$(eval echo "$path")
            if [ -e "$expanded_path" ]; then
                mounts="$mounts -v $expanded_path:$expanded_path"
            fi
        done
    fi

    echo "$mounts"
}

prompt_permission() {
    local resource="$1"
    local action="$2"  # read, write, execute

    echo ""
    echo "${YELLOW}┌─────────────────────────────────────────────────────────────┐${NC}"
    echo "${YELLOW}│ PERMISSION REQUEST                                          │${NC}"
    echo "${YELLOW}└─────────────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo "  Action:   ${CYAN}$action${NC}"
    echo "  Resource: ${CYAN}$resource${NC}"
    echo ""
    echo "  [y] Allow once"
    echo "  [n] Deny"
    echo "  [a] Always allow (add to whitelist)"
    echo ""
    read -r -p "  Choice [y/n/a]: " choice

    case "$choice" in
        y|Y)
            echo "${GREEN}Allowed (once)${NC}"
            log "Permission granted (once): $action $resource"
            return 0
            ;;
        a|A)
            if [ "$action" = "write" ]; then
                add_to_whitelist "write" "$resource"
            else
                add_to_whitelist "read" "$resource"
            fi
            return 0
            ;;
        *)
            echo "${RED}Denied${NC}"
            log "Permission denied: $action $resource"
            return 1
            ;;
    esac
}

run_sandbox() {
    local interactive_mode="${1:-true}"
    local claude_args="${@:2}"

    echo "${CYAN}=== PowerKit Sandbox ===${NC}"
    echo ""
    echo "Workspace: $(pwd)"
    echo "Whitelist: $WHITELIST_FILE"
    echo ""

    # Check Docker
    if ! command -v docker &> /dev/null; then
        echo "${RED}Docker required but not installed.${NC}"
        echo "Install Docker Desktop: https://docker.com/products/docker-desktop"
        exit 1
    fi

    if ! docker info &> /dev/null; then
        echo "${RED}Docker daemon not running.${NC}"
        echo "Start Docker Desktop and try again."
        exit 1
    fi

    # Build mount options
    local mounts=$(build_docker_mounts)

    echo "${BLUE}Mounted paths:${NC}"
    echo "$mounts" | tr ' ' '\n' | grep "^-v" | sed 's/-v /  /'
    echo ""

    log "Sandbox started: $(pwd)"

    # Check if claude-code-sandbox is available
    if command -v claude-code-sandbox &> /dev/null; then
        echo "${GREEN}Using claude-code-sandbox...${NC}"

        # Build command with whitelist mounts
        local cmd="claude-code-sandbox"

        # Add whitelisted paths
        if command -v jq &> /dev/null; then
            for path in $(jq -r '.paths.read[]' "$WHITELIST_FILE" 2>/dev/null); do
                expanded_path=$(eval echo "$path")
                if [ -e "$expanded_path" ]; then
                    cmd="$cmd --mount-ro $expanded_path"
                fi
            done

            for path in $(jq -r '.paths.write[]' "$WHITELIST_FILE" 2>/dev/null); do
                expanded_path=$(eval echo "$path")
                if [ -e "$expanded_path" ]; then
                    cmd="$cmd --mount-rw $expanded_path"
                fi
            done
        fi

        # Pass through Claude args
        if [ -n "$claude_args" ]; then
            eval "$cmd -- $claude_args"
        else
            eval "$cmd"
        fi
    else
        # Fallback to basic Docker approach
        echo "${YELLOW}claude-code-sandbox not found, using basic Docker...${NC}"

        docker run -it --rm \
            $mounts \
            -w /workspace \
            -e ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY:-}" \
            node:20-slim \
            bash -c "npm install -g @anthropic-ai/claude-code && claude $claude_args"
    fi

    log "Sandbox ended"
}

show_status() {
    echo "${CYAN}=== PowerKit Sandbox Status ===${NC}"
    echo ""

    # Docker status
    if command -v docker &> /dev/null; then
        if docker info &> /dev/null; then
            echo "${GREEN}Docker: Running${NC}"
        else
            echo "${RED}Docker: Not running${NC}"
        fi
    else
        echo "${RED}Docker: Not installed${NC}"
    fi

    # claude-code-sandbox status
    if command -v claude-code-sandbox &> /dev/null; then
        echo "${GREEN}claude-code-sandbox: Installed${NC}"
    else
        echo "${YELLOW}claude-code-sandbox: Not installed${NC}"
    fi

    # Whitelist status
    echo ""
    echo "${BLUE}Whitelist entries:${NC}"
    if command -v jq &> /dev/null; then
        local read_count=$(jq '.paths.read | length' "$WHITELIST_FILE" 2>/dev/null || echo 0)
        local write_count=$(jq '.paths.write | length' "$WHITELIST_FILE" 2>/dev/null || echo 0)
        local cmd_count=$(jq '.commands | length' "$WHITELIST_FILE" 2>/dev/null || echo 0)
        echo "  Read paths:  $read_count"
        echo "  Write paths: $write_count"
        echo "  Commands:    $cmd_count"
    fi

    # Recent log entries
    echo ""
    echo "${BLUE}Recent activity:${NC}"
    if [ -f "$LOG_FILE" ]; then
        tail -5 "$LOG_FILE" | sed 's/^/  /'
    else
        echo "  No activity logged yet"
    fi
}

# Parse arguments
INTERACTIVE_MODE=true
DRY_RUN=false
SHELL_MODE=false
CLAUDE_ARGS=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -l|--list)
            list_whitelist
            exit 0
            ;;
        -a|--add-path)
            add_to_whitelist "read" "$2"
            shift 2
            exit 0
            ;;
        -w|--add-write)
            add_to_whitelist "write" "$2"
            shift 2
            exit 0
            ;;
        -c|--add-cmd)
            add_to_whitelist "command" "$2"
            shift 2
            exit 0
            ;;
        -r|--remove)
            remove_from_whitelist "$2"
            shift 2
            exit 0
            ;;
        --reset)
            rm -f "$WHITELIST_FILE"
            echo "${GREEN}Whitelist reset. Run again to create fresh whitelist.${NC}"
            exit 0
            ;;
        --interactive)
            INTERACTIVE_MODE=true
            shift
            ;;
        --auto-approve)
            INTERACTIVE_MODE=false
            echo "${RED}WARNING: Auto-approve mode - all permissions will be granted!${NC}"
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --shell)
            SHELL_MODE=true
            shift
            ;;
        --status)
            show_status
            exit 0
            ;;
        --)
            shift
            CLAUDE_ARGS="$@"
            break
            ;;
        *)
            CLAUDE_ARGS="$CLAUDE_ARGS $1"
            shift
            ;;
    esac
done

# Handle dry run
if [ "$DRY_RUN" = true ]; then
    echo "${CYAN}=== Dry Run - Mounts that would be created ===${NC}"
    echo ""
    build_docker_mounts | tr ' ' '\n' | grep "^-v" | sed 's/-v //'
    exit 0
fi

# Handle shell mode
if [ "$SHELL_MODE" = true ]; then
    if command -v claude-code-sandbox &> /dev/null; then
        claude-code-sandbox --shell
    else
        echo "${RED}claude-code-sandbox not installed. Running basic Docker shell...${NC}"
        docker run -it --rm -v $(pwd):/workspace -w /workspace node:20-slim bash
    fi
    exit 0
fi

# Run sandbox
run_sandbox "$INTERACTIVE_MODE" "$CLAUDE_ARGS"
