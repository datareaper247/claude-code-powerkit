# Entrepreneur & Solo Founder Rules

## Core Principles

### Speed Over Perfection
- Ship MVP in 2-4 weeks, not months
- Perfect is the enemy of good enough
- Validate before building features
- Kill features that don't move metrics

### Data-Driven Decisions
- Every feature needs a hypothesis
- Track metrics from day 1
- Talk to customers weekly
- Let data override opinions

### Focus Ruthlessly
- One product, one customer segment
- Say no to 90% of feature requests
- Solve one problem exceptionally well
- Expand only after PMF

## Research Phase

### Problem Discovery
1. **Reddit Mining**:
   - Search: "I hate when...", "I wish there was..."
   - Track recurring complaints in target subreddits
   - Note upvote counts as validation signal
   - Save all findings to memory-keeper

2. **HackerNews Signals**:
   - Monitor Show HN for competitor launches
   - Track Ask HN for unmet needs
   - Watch for "someone should build..." comments

3. **Competitor Intelligence**:
   - Scrape pricing pages monthly
   - Track feature announcements
   - Monitor their Reddit/Twitter mentions
   - Analyze negative reviews (G2, Capterra)

### Validation Checklist
- [ ] 20+ customer interviews completed
- [ ] Problem confirmed by 80%+ of interviews
- [ ] Willingness to pay confirmed
- [ ] Landing page converts >5%
- [ ] 100+ waitlist signups

## Building Phase

### MVP Rules
- Maximum 3 core features
- No admin dashboard (use Supabase UI)
- No fancy animations
- Auth + Core Feature + Payments only
- Deploy on day 1

### Tech Stack (Recommended)
- **Frontend**: Next.js + Tailwind + shadcn/ui
- **Backend**: Supabase (auth, db, storage)
- **Payments**: Stripe
- **Hosting**: Vercel
- **Analytics**: Mixpanel or PostHog

### Launch Preparation
1. ProductHunt assets ready
2. 50 beta users lined up
3. Testimonials collected
4. Launch day tweets drafted
5. HN Show HN post written

## Growth Phase

### Acquisition Channels
- **SEO**: Long-tail competitor keywords
- **Content**: Solve problems your product solves
- **Communities**: Genuine participation (not spam)
- **Paid**: Only after organic proves concept
- **Partnerships**: Integration with popular tools

### Pricing Tactics
- Start higher than comfortable
- Offer annual discount (20-30%)
- Lifetime deals for early traction
- Grandfather early customers

### Retention Focus
- Onboarding is product
- Email sequences for activation
- Weekly usage reports
- Feature announcements
- NPS surveys monthly

## Decision Framework

### Build vs Buy vs Skip
- **Build**: Core differentiator only
- **Buy**: Everything else (auth, payments, email)
- **Skip**: Nice-to-haves, edge cases

### Feature Prioritization
1. Will it increase conversion?
2. Will it reduce churn?
3. Will it generate word-of-mouth?
4. If no to all → skip

### When to Pivot
- 3 months without PMF signals
- Can't get 40% "very disappointed"
- CAC > 3x LTV
- Churn > 10% monthly

## B2B vs B2C Rules

### B2B SaaS
- Sales-led for >$500/mo products
- Demo before trial
- Contract minimum 6 months
- Upsell to annual aggressively
- Build for IT buyer AND end user

### B2C / Micro-SaaS
- Self-serve always
- Freemium or free trial
- Credit card upfront
- Focus on viral loops
- Mobile-first design

## AI-Assisted Workflow

### Use Agents For
- `ceo-advisor`: Strategy decisions, board prep
- `cto-advisor`: Architecture, build vs buy
- `marketing-strategy-pmm`: Positioning, messaging
- `competitive-analyst`: Market mapping
- `pricing-strategist`: Pricing optimization

### Use MCPs For
- `reddit`: Problem discovery, validation
- `hackernews`: Trend spotting, tech validation
- `firecrawl`: Competitor scraping
- `context7`: Tech documentation

### Memory Management
- Save all customer insights
- Track all pivot decisions
- Document competitor changes
- Record metrics weekly

## Anti-Patterns (Avoid)

- Building in stealth for months
- Perfect code before launch
- Adding features without validation
- Ignoring negative feedback
- Scaling before PMF
- Hiring before revenue
- Multiple products at once
- Chasing vanity metrics
