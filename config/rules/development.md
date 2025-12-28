# Development Rules

## Code Quality
- Write clean, self-documenting code
- Follow DRY (Don't Repeat Yourself) principle
- Use meaningful variable and function names
- Keep functions small and focused (single responsibility)
- Add comments only for complex logic, not obvious code

## Testing
- Write tests before or alongside implementation (TDD preferred)
- Aim for meaningful test coverage, not just high numbers
- Test edge cases and error conditions
- Use the systematic-debugging skill when tests fail

## Git Workflow
- Make atomic commits with clear messages
- Use conventional commits format: type(scope): description
- Create feature branches for new work
- Review changes before committing

## Security
- Never commit secrets or credentials
- Validate all user input
- Use parameterized queries for databases
- Follow OWASP guidelines for web applications

## Performance
- Profile before optimizing
- Avoid premature optimization
- Consider scalability in design decisions
- Use caching appropriately
