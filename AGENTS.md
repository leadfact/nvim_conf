# Repository Guidelines

## Project Structure & Module Organization
- Main entry: `init.lua` wires base options, keymaps, and plugin loading.
- `lua/lazy-setup.lua` bootstraps `lazy.nvim`; extend specs under `lua/plugins/specs/` (e.g., `lsp.lua`, `ui.lua`, `tools.lua`).
- Core settings live in `lua/base/` (search, tabs, misc) and keymaps in `lua/keys/` (alias, plugins). Plugin configs sit in `lua/plugins/` alongside Mason, cmp, lualine, neo-tree, treesitter, etc.
- `plugin/` holds auto-generated runtime files from Lazy; avoid manual edits. Assets/screenshots go in `misc/`; custom dictionaries in `spell/`.

## Setup, Build & Development Commands
- `./install.sh` — bootstrap on a new machine (backs up old config, installs plugins/LSPs).
- `nvim --headless "+Lazy sync" +qa` — install/update plugins headlessly.
- `nvim --headless "+checkhealth" +qa` — validate runtime health after changes.
- In Neovim: `:Mason` to manage LSP servers; `:Lazy update` to refresh plugins; `:Lazy clean` before locking versions.

## Coding Style & Naming Conventions
- Lua files: match surrounding style (tabs currently common; keep short lines and trailing commas where tables span lines).
- Modules and files use `snake_case`; plugin spec tables return `{ "repo/name", opts = { ... } }` patterns. Keep keymaps descriptive and grouped.
- Prefer explicit option names over globals; keep Russian/English comments concise and practical. Avoid editing generated `plugin/` files.

## Testing Guidelines
- No automated test suite; validate by running `nvim --headless "+Lazy sync" +qa` then `nvim --headless "+checkhealth" +qa`.
- Manually smoke-test: launch `nvim`, open `:Lazy`, toggle Neo-tree (`<leader>v`), run a formatter (`gf`), and confirm telescope (`<leader>f`) works.
- After plugin or LSP changes, verify `lazy-lock.json` updates and Mason installs succeed.

## Commit & Pull Request Guidelines
- Commits: short imperative subject (e.g., `tweak search options`, `add go tooling`); keep scope narrow and include lockfile changes when plugins move.
- PRs: summarize motivation and behavior, list impacted plugins/modules, and note manual checks (headless health, keymap smoke-test). Attach screenshots for UI tweaks (statusline, tree, theme) and link issues if applicable.

## Security & Configuration Tips
- Do not commit machine-specific caches; keep secrets (API keys, tokens) out of any Lua files. Back up `~/.local/share/nvim` before destructive experiments.
- When adding plugins, prefer lazy-loaded specs and document new keybindings in `lua/keys/plugins.lua` to avoid surprises.
