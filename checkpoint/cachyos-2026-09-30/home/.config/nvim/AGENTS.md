# AGENTS.md

Guide for agentic coding assistants working in this Neovim config repo.

## Repo Snapshot

- Language: Lua (Neovim config).
- Entry point: `init.lua`.
- Main modules: `lua/preferences.lua`, `lua/keymaps.lua`, `lua/plugins/*.lua`.
- LSP server configs: `after/lsp/*.lua`.
- Plugin manager: `lazy.nvim`.
- Formatter integration: `conform.nvim`.

## Cursor / Copilot Rules

- `.cursor/rules/`: not present.
- `.cursorrules`: not present.
- `.github/copilot-instructions.md`: not present.
- If any of these are added later, treat them as higher-priority repo rules and update this file.

## Setup Commands

- Clone: `git clone https://github.com/doyalsnehil/nvim.git ~/.config/nvim/`
- Start Neovim: `nvim`
- Sync plugins headless: `nvim --headless "+Lazy! sync" +qa`
- Update Treesitter parsers headless: `nvim --headless "+TSUpdate" +qa`

## Build / Lint / Test Matrix

This repo does not currently define a formal build system, CI pipeline, or test suite.

Use these practical verification commands instead:

- Full config smoke test:
  - `nvim --headless +qa`
- Plugin bootstrap/sync check:
  - `nvim --headless "+Lazy! sync" +qa`
- Treesitter parser update check:
  - `nvim --headless "+TSUpdate" +qa`
- Runtime health checks:
  - `nvim --headless "+checkhealth" +qa`
- Formatting check/fix for Lua files (if `stylua` is installed):
  - `stylua .`

## Single-Test Guidance

There is no test runner configured yet (no `tests/`, `spec/`, `busted`, or `plenary` test harness).

If asked to "run a single test", explain that there are no repository tests and use a targeted smoke check:

- Single file load check (example):
  - `nvim --headless "+luafile %" +qa` (from inside the target file in Neovim)
- Direct Lua require check (example):
  - `nvim --headless "+lua require('preferences')" +qa`
- Single feature check (manual):
  - Open Neovim and validate the specific mapping/plugin behavior touched by the change.

If a real test framework is added later, update this section with exact single-test commands.

## Code Organization Conventions

- Keep startup logic in `init.lua` minimal (bootstrap + top-level requires).
- Put editor defaults in `lua/preferences.lua`.
- Put global keymaps/autocmds in `lua/keymaps.lua` unless feature-local maps are clearer.
- Put plugin specs under `lua/plugins/*.lua`, grouped by feature.
- Put LSP server-specific settings in `after/lsp/<server>.lua`.
- Prefer small focused modules over large mixed-purpose files.

## Lua Style Guidelines

- Respect the style already used in touched files.
- Indentation: tabs are common in this repo; do not mass-reindent unrelated lines.
- Keep lines readable; avoid dense one-liners for complex tables/functions.
- Prefer trailing commas in multiline Lua tables.
- Use `local` for functions/variables unless a global is intentionally required.
- Return plugin specs/config tables directly from modules.
- Avoid adding comments for obvious code; add short comments only for non-obvious intent.

## Imports / Requires

- Require modules by Neovim runtime path name, e.g. `require("preferences")`.
- Keep `require(...)` calls near first use unless module-level setup is intentional.
- For optional dependencies, use protected load:
  - `local ok, mod = pcall(require, "module")`
  - Guard usage with `if ok then ... end`.
- Avoid re-requiring the same module repeatedly in one scope.

## Plugin Specification Patterns

- Prefer one plugin concern per file in `lua/plugins/`.
- Use Lazy spec keys consistently (`event`, `cmd`, `opts`, `config`, `dependencies`, `build`).
- Prefer declarative `opts` when possible; use `config` for imperative setup.
- Keep `config` functions focused on setup, not unrelated side effects.
- Document unusual behavior with a brief comment.

## Types and API Discipline

- Lua is dynamically typed here; keep value shapes predictable.
- When helpful, use EmmyLua annotations sparingly (already used in `completion.lua`).
- Match expected Neovim API types (`string`, `table`, callback signatures).
- Validate assumptions before indexing nested tables from optional plugins.

## Naming Conventions

- Filenames: lowercase, descriptive, consistent with nearby files.
- Module names should match file paths.
- Local variables/functions: `snake_case` preferred.
- Constants-style values: `UPPER_SNAKE_CASE` when truly constant.
- User-facing descriptions (`desc`) should be concise and action-oriented.

## Error Handling and Resilience

- Use `pcall` around optional integrations and extension loads.
- Fail soft when a plugin is unavailable; keep core editing usable.
- Prefer explicit fallbacks (example pattern: formatter plugin -> LSP fallback).
- Avoid swallowing errors silently when they affect user-facing behavior.

## Editing Safety for Agents

- Do not rewrite unrelated files or reformat the entire repo.
- Keep diffs minimal and scoped to the requested change.
- Preserve existing keymaps and user UX unless the task explicitly changes them.
- Preserve compatibility with existing plugins unless intentionally migrating.
- Never commit secrets or machine-local credentials.

## Validation Checklist After Changes

- Run: `nvim --headless +qa`
- If plugins changed: `nvim --headless "+Lazy! sync" +qa`
- If Treesitter changed: `nvim --headless "+TSUpdate" +qa`
- If Lua formatting changed: `stylua .`
- Do a quick manual open in `nvim` and verify impacted mappings/features.

## Known Gaps (Current State)

- No dedicated `build` command.
- No formal lint command wired in repo scripts.
- No automated tests or single-test harness.
- No Cursor/Copilot instruction files yet.

When these are introduced, update this AGENTS.md first so future agents can execute the right workflows.
