# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration built on [LazyVim](https://lazyvim.github.io/). Plugin management is handled by [lazy.nvim](https://github.com/folke/lazy.nvim). The entry point is `init.lua`, which bootstraps lazy.nvim and delegates to `lua/config/lazy.lua`.

## Formatting

Lua code is formatted with [StyLua](https://github.com/JohnnyMorganz/StyLua):

```
stylua .
```

Config: 2-space indentation, 120-column width (see `stylua.toml`).

## Architecture

```
lua/
  config/         # Core LazyVim lifecycle files (auto-loaded by LazyVim)
    lazy.lua      # Plugin manager bootstrap + spec wiring
    options.lua   # vim.opt settings (loaded before lazy)
    keymaps.lua   # Key mappings (loaded on VeryLazy)
    autocmds.lua  # Autocommands (loaded on VeryLazy)
  plugins/        # Custom plugin specs (each file returns a lazy.nvim spec table)
```

**Adding a plugin**: create a new file in `lua/plugins/` that returns a lazy.nvim spec table. LazyVim auto-imports everything under `lua/plugins/`.

**`floaterminal.lua`** is a lazy spec that uses `plenary.nvim` as a dummy dependency and its `init` callback to register the `:T` command (toggling floating terminal) at startup. It is not a plugin in the traditional sense.

**`example.lua`** is a boilerplate reference/template file from LazyVim that is never loaded — it short-circuits with `if true then return {} end`.

## Custom Plugins

| Plugin | Purpose | Key bindings |
|--------|---------|--------------|
| `compile-mode.nvim` | Build/compile buffer | `<leader>rc` compile, `<leader>rr` recompile, `<leader>rn`/`<leader>rN` next/prev error; default command: `make -k -j$(gnproc) SOC=` |
| `claudecode.nvim` | Claude Code integration | `<leader>ac` toggle (normal) / send selection (visual), `<leader>af` focus, `<leader>ar` resume, `<leader>aC` continue, `<leader>am` model select, `<leader>ab` add buffer, `<leader>as` add file (oil/neo-tree/etc), `<leader>aa` accept diff, `<leader>ad` deny diff |
| `oil.nvim` | File explorer (default) | `-` open parent dir; `<M-h>` split select; shows hidden files; deletes go to trash; `<C-h/j/k/l>` disabled to avoid split conflicts |
| `oil-git.nvim` | Git status decorations in oil | automatic |
| `flash.nvim` | Motion jumps | `zk` jump, `Zk` treesitter jump; `r` remote (operator), `R` treesitter search (operator/visual), `<c-s>` toggle (cmdline) |
| `onedarkpro.nvim` | Colorscheme | `onedark_dark` with transparency |
| `zdiff.nvim` | Multi-buffer git diff viewer | `<leader>zd` prompts for a branch to diff against (blank = uncommitted changes); overrides `DiffAdd`/`DiffDelete` globally with opaque backgrounds so highlights show through onedarkpro's transparency |
| floaterminal (`:T`) | Toggling floating terminal | `:T` — persists buffer across toggles |

## Key Options

- Autoformat disabled globally (`vim.g.autoformat = false`)
- Indentation: 4 spaces (`tabstop`, `softtabstop`, `shiftwidth = 4`), `expandtab = true`
- Auto-indent disabled (`cindent`, `autoindent`, `smartindent` all off)
- Persistent undo (`undofile = true`)
- Terminal `<Esc>` exits to normal mode (both in `options.lua` and `floaterminal.lua` via `<esc><esc>`)
- `<leader>ut` toggles typewriter/cursor-lock mode (`scrolloff` between 989 and 999)
- Plugin updates are checked automatically but silently