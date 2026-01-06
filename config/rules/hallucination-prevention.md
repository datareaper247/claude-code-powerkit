# Hallucination Prevention Rules

## Core Principles

1. **Never trust AI output without verification**
2. **Verify file paths before writing**
3. **Run tests after code changes**
4. **Cross-check with Gemini for critical decisions**

## Pre-Implementation Checks

Before writing ANY code, Claude MUST:

1. **Verify target paths exist**:
   ```bash
   ls -la $(dirname "$TARGET_FILE")
   ```

2. **Check for existing patterns**:
   ```bash
   grep -r "similar_function" --include="*.ts" .
   ```

3. **Validate imports are available**:
   ```bash
   grep -r "export.*FunctionName" --include="*.ts" .
   ```

## Post-Implementation Checks

After writing code, Claude MUST:

1. **Verify file was created/modified**:
   ```bash
   ls -la "$MODIFIED_FILE"
   cat "$MODIFIED_FILE" | head -20
   ```

2. **Run linter**:
   ```bash
   npx eslint "$MODIFIED_FILE" 2>&1 || true
   ```

3. **Run type check (TypeScript)**:
   ```bash
   npx tsc --noEmit "$MODIFIED_FILE" 2>&1 || true
   ```

4. **Run related tests**:
   ```bash
   npm test -- --findRelatedTests "$MODIFIED_FILE" 2>&1 || true
   ```

## Cross-Validation with Gemini

For critical changes, use Gemini to verify:

```bash
# Verify code logic
mcp__gemini-cli__ask-gemini prompt: "Review this code for logical errors: @$FILE"

# Verify visual output (screenshots)
mcp__gemini-cli__ask-gemini prompt: "Does this screenshot show [expected UI]? @$SCREENSHOT"

# Verify architecture decisions
mcp__gemini-cli__ask-gemini prompt: "Challenge this approach: [description]. What could go wrong?"
```

## Common Hallucination Patterns to Watch

1. **Invented APIs**: Claude may invent function signatures that don't exist
   - Fix: Always `grep` for the function first

2. **Wrong file paths**: Claude may reference files that don't exist
   - Fix: Always `ls` before writing

3. **Outdated patterns**: Claude may use deprecated APIs
   - Fix: Check Context7 for latest docs

4. **Optimistic success**: Claude may claim success without verification
   - Fix: Always run actual commands to verify

5. **Missing dependencies**: Claude may import packages not installed
   - Fix: Check package.json/requirements.txt first

## Verification Hooks

Add these to your settings.json:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "hooks": [{
          "type": "command",
          "command": "test -f \"$FILE_PATH\" && echo 'File verified' || (echo 'ERROR: File not created' && exit 2)"
        }]
      }
    ]
  }
}
```

## The Golden Rule

> **If Claude says "I've done X", verify X actually happened.**
>
> Never accept "The code has been updated" without seeing the actual file content.
