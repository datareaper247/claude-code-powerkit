# MCP Server Setup

Essential MCP servers for the Claude Code Powerkit.

## Pre-configured MCPs

These are installed and configured globally:

### 1. Memory Keeper
Persistent context management across sessions.

```bash
# Already installed via:
claude mcp add --scope user memory-keeper -- npx mcp-memory-keeper
```

**Features:**
- Short-term: Save/retrieve within session
- Mid-term: Search across sessions
- Long-term: Journal entries, relationships, analysis

**Key Commands:**
- `context_save` - Store context items
- `context_get` - Retrieve context
- `context_checkpoint` - Create restore points
- `context_search_all` - Cross-session search
- `context_prepare_compaction` - Auto-save before compacting

### 2. Context7
Up-to-date documentation for any library.

```bash
# Already installed via:
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest
```

**Usage:**
- Say "use context7" in prompts
- Or let Claude auto-detect when library docs are needed

**Key Commands:**
- `resolve-library-id` - Find library identifier
- `get-library-docs` - Fetch documentation

## Optional MCPs to Add

### Database Access

```bash
# Supabase
claude mcp add supabase -- npx @supabase/mcp-server

# PostgreSQL
claude mcp add postgres -- npx @anthropic/mcp-postgres
```

### Browser Automation

```bash
# Playwright
claude mcp add playwright -- npx @anthropic/mcp-playwright
```

### Cloud Platforms

```bash
# AWS
claude mcp add aws -- npx @anthropic/mcp-aws

# GitHub
claude mcp add github -- npx @anthropic/mcp-github
```

## Verify Installation

```bash
claude mcp list
```

Should show:
```
memory-keeper: npx mcp-memory-keeper - ✓ Connected
context7: npx -y @upstash/context7-mcp@latest - ✓ Connected
```

## Troubleshooting

### MCP not connecting
```bash
# Check server health
claude mcp list

# Remove and re-add
claude mcp remove <name>
claude mcp add <name> -- <command>
```

### Use bunx instead of npx
If you get ERR_MODULE_NOT_FOUND:
```bash
claude mcp add context7 -- bunx @upstash/context7-mcp@latest
```

## Reference

- [Memory Keeper GitHub](https://github.com/mkreyman/mcp-memory-keeper)
- [Context7 GitHub](https://github.com/upstash/context7)
- [Awesome MCP Servers](https://github.com/punkpeye/awesome-mcp-servers)
