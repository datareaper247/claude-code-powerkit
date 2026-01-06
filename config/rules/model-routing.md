# Model Routing Strategy (2026)

## Decision Matrix

Use this matrix to select the appropriate model for each task:

### Heavy Lifting (Opus 4.5 + Gemini Pro)

Use **Claude Opus 4.5** (`claude --model opus`) for:
- Architecture design and system design
- Complex refactoring (>500 lines affected)
- Security audits and penetration testing
- Code review of critical systems (auth, payments)
- Debugging complex race conditions
- Database schema design
- API design decisions

Use **Gemini Pro** (`mcp__gemini-cli__ask-gemini`) for:
- Analyzing files >50K tokens (1M context window)
- Multimodal analysis (screenshots, videos, diagrams)
- Real-time web search for latest docs
- Cross-referencing large codebases
- Visual verification of UI implementations
- Video analysis where Claude fails

### Daily Coding (Sonnet 4.5 + Gemini Flash)

Use **Claude Sonnet 4.5** (default) for:
- Feature implementation
- Writing tests
- Code generation
- Documentation
- Routine bug fixes
- Code reviews (non-critical)

Use **Gemini Flash** (`mcp__gemini-cli__ask-gemini model: "gemini-2.5-flash"`) for:
- Quick lookups
- Simple summarization
- Fast validation
- Large file scanning
- Second opinion on approach

### Grunt Work (Haiku 4.5)

Use **Claude Haiku 4.5** (`claude --model haiku`) for:
- Code formatting
- Linting suggestions
- Simple refactors (rename, extract)
- JSON/YAML validation
- Quick syntax checks
- Pre-commit validations
- Simple file operations

## Automatic Routing Rules

Add to your workflow:

```bash
# Complex task → Opus
if [[ "$TASK" =~ "architect|design|security|critical" ]]; then
  claude --model opus "$TASK"
fi

# Large file → Gemini
if [[ $(wc -l < "$FILE") -gt 1000 ]]; then
  mcp__gemini-cli__ask-gemini prompt: "Analyze @$FILE"
fi

# Simple validation → Haiku
claude --model haiku "Verify this JSON is valid: $CONTENT"
```

## Cost Optimization

| Model | Cost/1M tokens (in) | Use When |
|-------|---------------------|----------|
| Opus 4.5 | $15 | Accuracy critical |
| Sonnet 4.5 | $3 | Daily work |
| Haiku 4.5 | $0.25 | Bulk operations |
| Gemini Flash | ~Free | Large context |
| Gemini Pro | $3.50 | Multimodal |

## Validation Loop Pattern

```
1. Plan with Opus → High-quality plan
2. Implement with Sonnet → Cost-effective coding
3. Validate with Haiku → Cheap syntax/lint check
4. Visual verify with Gemini → Multimodal confirmation
5. Final review with Opus → Ensure quality
```
