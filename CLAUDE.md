---
imports:
  - ~/.claude/CLAUDE.md
---

# claude-code-powerkit Project Configuration

## Project Type
- **Type**: generic
- **Suggested Plugins**: tdd-workflows, code-review-ai

## Commands

### Testing
```bash
npm test
```

### Linting
```bash
npm run lint
```

### Build
```bash
# Add project-specific build command
```

## Project-Specific Rules

### Code Standards
- Follow existing code patterns in this project
- Use project's existing naming conventions
- Maintain consistency with existing architecture

### Pre-Commit Checklist
- [ ] Tests pass: `npm test`
- [ ] Linting passes: `npm run lint`
- [ ] No new TODO comments without issue links
- [ ] Documentation updated if public API changed

### Sensitive Files (DO NOT MODIFY)
- .env, .env.* - Environment variables
- **/secrets/** - Secret files
- **/*.key - Private keys

### Architecture Notes
<!-- Add project architecture notes here -->

## Memory Context

When starting work on this project:
```
context_search query: "claude-code-powerkit"
context_get category: "progress"
```

Before ending session:
```
context_save key: "claude-code-powerkit-progress" category: "progress"
context_checkpoint name: "claude-code-powerkit-checkpoint"
```
