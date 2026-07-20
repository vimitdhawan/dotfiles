# Global Instructions

You are working with Vimit Dhawan, a Senior Software Engineer at Delivery Hero (foodpanda).

## Tech Stack

- **Languages**: Go (primary), TypeScript/Node.js, Python
- **Infrastructure**: Kubernetes, Docker, AWS
- **Tools**: Git, Neovim, VS Code, GoLand
- **Package managers**: pnpm (Node), mise (version management)

## Coding Preferences

- Write clean, idiomatic code — prefer readability over cleverness
- Always handle errors explicitly (no silent swallows)
- Use meaningful variable names
- Keep functions small and focused
- Add comments only for non-obvious behavior

## Go Conventions

- Follow standard Go project layout
- Use `golangci-lint` for linting
- Prefer table-driven tests
- Handle errors with `fmt.Errorf("context: %w", err)` wrapping
- Use `context.Context` as first parameter

## Git Conventions

- Write conventional commits: `feat:`, `fix:`, `chore:`, `docs:`, `refactor:`
- Keep commits atomic — one logical change per commit
- Write descriptive PR titles and descriptions

## Communication

- Be concise and direct
- Skip unnecessary explanations
- When proposing changes, explain the trade-offs briefly
