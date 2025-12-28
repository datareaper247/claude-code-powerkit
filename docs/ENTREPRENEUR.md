# Entrepreneur & Solo Founder Toolkit

Complete toolkit for building and launching B2B/B2C SaaS, micro-SaaS, and apps with AI assistance.

## Market Research MCPs

### Reddit Research
```bash
claude mcp add --scope user reddit -- npx -y mcp-reddit
```

**Capabilities**:
- Search any subreddit for pain points
- Find "I wish there was..." posts
- Analyze competitor discussions
- Track problem validation signals

**Usage**:
```
"Search r/SaaS for complaints about project management tools"
"Find posts where people ask for alternatives to Notion"
"What problems are people having with current invoice software?"
```

### HackerNews
```bash
claude mcp add --scope user hackernews -- npx -y mcp-hacker-news
```

**Capabilities**:
- Track Show HN launches
- Monitor tech trends
- Find Ask HN unmet needs
- Spot B2B opportunities

**Usage**:
```
"Show me recent Show HN posts about developer tools"
"Find Ask HN posts about productivity problems"
"What are people saying about AI startups this week?"
```

### Web Scraping (Jina or Firecrawl)

**Option A: Jina (Free, no API key)**
```bash
claude mcp add --scope user jina -- npx -y jina-mcp-tools
```

**Option B: Firecrawl (Requires API key)**
```bash
export FIRECRAWL_API_KEY=your_key_here
claude mcp add --scope user firecrawl -- npx -y firecrawl-mcp
```

**Capabilities**:
- Scrape competitor websites
- Extract pricing pages
- Monitor landing page changes
- Analyze feature lists
- Convert web pages to clean markdown

**Usage**:
```
"Scrape Linear's pricing page and summarize tiers"
"Compare features listed on Notion vs Coda homepages"
"Get testimonials from competitor landing pages"
```

## Startup Skills & Agents

### The Agentic Startup (rsmdt/the-startup)
```bash
/plugin marketplace add rsmdt/the-startup
/plugin install start@the-startup
/plugin install team@the-startup
```

**Features**:
- 11 agent roles across 27 specializations
- Phase-by-phase execution
- Spec-driven development
- Parallel agent execution

### Business Agents

| Agent | Purpose |
|-------|---------|
| `ceo-advisor` | Strategy, fundraising, pivots, board prep |
| `cto-advisor` | Architecture, tech stack, hiring |
| `marketing-strategy-pmm` | GTM, positioning, messaging |
| `pricing-strategist` | Pricing optimization, competitor analysis |
| `competitive-analyst` | Market mapping, SWOT analysis |
| `market-researcher` | TAM/SAM/SOM, trends |
| `product-manager` | Roadmap, prioritization |
| `growth-hacker` | Acquisition, activation, retention |

### Subagent Collections

**NicholasSpisak/claude-code-subagents** (76+ agents):
- Financial analysts
- Market researchers
- Competitive strategists
- Pricing specialists

**ChrisRoyse/610ClaudeSubagents** (610 agents):
- Business Launch agents
- Growth Scaling agents
- Market Expansion agents
- Competitive Analysis agents

## SaaS Boilerplates

### Quick Start with Claude
```bash
# Use IncomeStreamSurfer's boilerplate
/setup-boilerplate
```

### Manual Options

| Boilerplate | Stack | Link |
|-------------|-------|------|
| next-supabase-stripe-starter | Next.js + Supabase + Stripe | [GitHub](https://github.com/KolbySisk/next-supabase-stripe-starter) |
| Saas-Kit-supabase | React + Next.js + Tailwind | [GitHub](https://github.com/Saas-Starter-Kit/Saas-Kit-supabase) |
| saas-template | Next.js + Supabase + Clerk | [GitHub](https://github.com/adrianhajdin/saas-template) |

### Reference Lists
- [awesome-opensource-boilerplates](https://github.com/EinGuterWaran/awesome-opensource-boilerplates)
- [awesome-saas-boilerplates](https://github.com/tyaga001/awesome-saas-boilerplates-and-starter-kits)

## Workflow: Idea to Launch

### Phase 1: Problem Discovery (Week 1)

```markdown
1. Define target market
2. Use Reddit MCP:
   - Search 5-10 relevant subreddits
   - Find recurring complaints
   - Note upvote counts as validation

3. Use HackerNews MCP:
   - Search for "someone should build"
   - Check Ask HN for unmet needs

4. Document in memory-keeper:
   context_save key: "problems-{market}"
   category: "note"
   priority: "high"
```

### Phase 2: Validation (Week 2)

```markdown
1. Create landing page (Carrd, Framer, or Next.js)
2. Run $50 ad test
3. Measure signup rate (target >5%)
4. Conduct 20 customer interviews
5. Decision point: Build or pivot

Save decision:
context_save key: "validation-decision"
category: "decision"
```

### Phase 3: MVP Build (Weeks 3-6)

```markdown
1. Use SaaS boilerplate
2. Core features only (max 3)
3. Deploy immediately
4. Get 5 paying customers
5. Iterate based on feedback

Track progress:
context_save key: "mvp-progress"
category: "progress"
```

### Phase 4: Launch

```markdown
1. ProductHunt preparation
   - Hunter lined up
   - Assets ready
   - Launch time optimized

2. HackerNews Show HN
3. Reddit soft launch
4. Twitter/X announcement

Save learnings:
context_journal_entry tags: ["launch", "{product-name}"]
```

### Phase 5: Growth

```markdown
1. SEO content strategy
2. Paid acquisition tests
3. Referral program
4. Feature expansion (data-driven)

Track metrics:
context_save key: "metrics-week-{n}"
category: "progress"
```

## Competitive Analysis Workflow

```markdown
1. Identify competitors:
   - ProductHunt search
   - G2/Capterra categories
   - Reddit "alternatives to X" posts

2. Deep analysis (use Firecrawl):
   - Pricing structures
   - Feature lists
   - Positioning/messaging
   - Customer testimonials

3. Find gaps:
   - Missing features (from complaints)
   - Underserved segments
   - Pricing tier gaps
   - Poor UX areas

4. Document:
   context_save key: "competitor-{name}"
   category: "note"
```

## Indie Hacker Resources

### Awesome Lists (Installed)

| Resource | Description |
|----------|-------------|
| awesome-indiehackers | Complete indie hacker toolkit |
| awesome-indie | Resources for making money as dev |
| awesome-indie-maker | Tools for indie makers |
| awesome-saas-boilerplates | SaaS starter templates |

### Communities to Monitor
- r/SaaS
- r/startups
- r/Entrepreneur
- r/indiehackers
- Indie Hackers (indiehackers.com)
- HackerNews

## Memory Management

### What to Save

```markdown
# Customer insights
context_save key: "customer-{name}-insights"
category: "note"

# Pivot decisions
context_save key: "pivot-decision-{date}"
category: "decision"
priority: "high"

# Competitor updates
context_save key: "competitor-{name}-update"
category: "note"

# Weekly metrics
context_save key: "metrics-{date}"
category: "progress"
```

### Cross-Session Search

```markdown
# Find all competitor notes
context_search_all query: "competitor"

# Find all decisions
context_get category: "decision"

# Find recent progress
context_timeline groupBy: "week"
```

## Quick Reference

### MCP Installation
```bash
claude mcp add --scope user reddit -- npx -y mcp-reddit
claude mcp add --scope user hackernews -- npx -y mcp-hacker-news
claude mcp add --scope user jina -- npx -y jina-mcp-tools  # Free alternative to firecrawl
```

### Plugin Installation
```bash
/plugin marketplace add rsmdt/the-startup
/plugin install start@the-startup
```

### Update All
```bash
~/.claude/update-skills.sh
```
