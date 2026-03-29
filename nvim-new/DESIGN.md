# Modern Neovim Configuration (2026)

> Minimal, modern Neovim config replacing the legacy `nvim/` (doodleVim) setup.
> Created: 2026-03-15

## Goal

A lean, fast Neovim configuration for Go, Rust, Python, and Docker development — using fewer, more powerful plugins and leveraging Neovim 0.10+ built-ins.

## Architecture

- **Package manager:** lazy.nvim with lazy-loading by default
- **Colorscheme:** Catppuccin Mocha
- **Completion:** blink.cmp (replaces nvim-cmp + 8 source plugins)
- **Multi-purpose:** snacks.nvim (picker, notifier, indent guides, input, terminal, bigfile, statuscolumn, bufdelete)
- **Built-ins used:** native commenting (`gc`/`gcc`), native smooth scroll, native snippets via blink.cmp, treesitter folding

## Plugin Count

**19 plugins** (down from 58 in the old config)

| Category | Plugins |
|---|---|
| UI | catppuccin, lualine, bufferline.nvim, render-markdown.nvim, snacks.nvim |
| LSP | nvim-lspconfig + mason + mason-lspconfig, rustaceanvim |
| Completion | blink.cmp + friendly-snippets |
| Formatting | conform.nvim (stylua, prettier, gofmt, rustfmt, ruff_format) |
| Linting | nvim-lint (yamllint, hadolint) |
| Treesitter | nvim-treesitter + textobjects |
| Diagnostics | trouble.nvim |
| Editor | flash.nvim, nvim-surround, nvim-autopairs |
| Tools | nvim-tree, auto-session |
| Misc | which-key, todo-comments, gitsigns, wakatime |

## Dropped from Old Config

| What | Why |
|---|---|
| Comment.nvim | Neovim 0.10+ native `gc`/`gcc` |
| nvim-cmp + 8 sources | Replaced by blink.cmp (single plugin) |
| barbar (tabline) | Replaced by bufferline.nvim (lighter, Catppuccin-integrated) |
| alpha-nvim (dashboard) | auto-session restores last session |
| nvim-notify | snacks.nvim notifier |
| indent-blankline | snacks.nvim indent |
| fidget.nvim | snacks.nvim LSP progress |
| neoscroll | Neovim 0.10+ native smooth scroll |
| hop.nvim | Replaced by flash.nvim (more powerful) |
| toggleterm | Dropped — use tmux/terminal splits |
| tmux.nvim | Dropped — not needed |
| hydra.nvim | Dropped — simplified keybindings |
| nvim-dap + dap-ui | Dropped — debug via terminal |
| copilot.vim | Dropped per user request |
| neoai.nvim | Dropped per user request |
| Games (5 plugins) | Dropped per user request |
| Java LSP (jdtls) | Dropped — no longer used |
| C/C++ (clangd) | Dropped — no longer used |
| codewindow (minimap) | Dropped — minimal config |
| barbecue + navic | Dropped — minimal config |
| vim-header | Dropped — minimal config |
| im-select | Dropped — minimal config |
| telescope + fzf-native + plenary | Replaced by snacks.nvim picker |

## File Structure

```
nvim-new/
├── init.lua                          # Bootstrap lazy.nvim, load core + plugins
├── DESIGN.md                         # This file
├── lua/
│   ├── core/
│   │   ├── options.lua               # Vim options (leader, numbers, tabs, search, etc.)
│   │   ├── keymaps.lua               # Global keymaps (window nav, buffers, save/quit, etc.)
│   │   └── autocmds.lua              # Autocommands (yank highlight, last location, etc.)
│   └── plugins/
│       ├── auto-session.lua          # Session persistence & restore
│       ├── autopairs.lua             # Auto-close brackets
│       ├── blink-cmp.lua             # Completion engine (LSP, path, snippets, buffer)
│       ├── catppuccin.lua            # Colorscheme (mocha flavour)
│       ├── conform.lua               # Formatting (format-on-save)
│       ├── flash.lua                 # Quick navigation (s/S to jump)
│       ├── gitsigns.lua              # Git signs + hunk operations
│       ├── lint.lua                  # Linting (yamllint, hadolint)
│       ├── lspconfig.lua             # LSP servers + mason + diagnostics + on-attach keymaps
│       ├── lualine.lua               # Statusline
│       ├── nvim-tree.lua             # File explorer sidebar
│       ├── rustaceanvim.lua          # Rust LSP (rust-analyzer + clippy)
│       ├── snacks.lua                # Multi-purpose (picker, notifier, indent, input, terminal, bigfile, etc.)
│       ├── surround.lua              # Surround text objects
│       ├── todo-comments.lua         # Highlight & search TODOs
│       ├── trouble.lua               # Diagnostics, references, TODOs panel
│       ├── treesitter.lua            # Syntax highlighting + textobjects
│       ├── wakatime.lua              # Time tracking
│       ├── bufferline.lua             # Buffer tab bar (visual buffer management)
│       ├── render-markdown.lua       # In-buffer markdown rendering
│       └── which-key.lua             # Keybinding hints popup
```

## LSP Servers

| Server | Language |
|---|---|
| gopls | Go |
| rust-analyzer (via rustaceanvim) | Rust |
| pyright | Python |
| ruff | Python (linting/formatting) |
| lua_ls | Lua |
| dockerls | Dockerfile |
| docker_compose_language_service | Docker Compose |
| jsonls | JSON |
| yamlls | YAML |
| taplo | TOML |

## Keybinding Reference

### Leader: `<Space>`

### LSP (on attach)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `K` | Hover documentation |
| `gK` | Signature help |
| `<C-k>` (insert) | Signature help |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename |
| `<leader>cf` | Format |

### Find (`<leader>f`)

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>fh` | Help tags |
| `<leader>fc` | Command history |
| `<leader>fd` | Diagnostics |
| `<leader>fs` | Document symbols |
| `<leader>fS` | Workspace symbols |
| `<leader>fk` | Keymaps |
| `<leader>ft` | Find TODOs |
| `<leader><leader>` | Resume last search |
| `<leader>/` | Fuzzy find in buffer |

### Git (`<leader>g`)

| Key | Action |
|---|---|
| `<leader>gg` | Lazygit |
| `<leader>gl` | Lazygit log |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghS` | Stage buffer |
| `<leader>ghR` | Reset buffer |
| `<leader>ghu` | Undo stage hunk |
| `<leader>ghp` | Preview hunk inline |
| `<leader>ghb` | Blame line |
| `<leader>ghd` | Diff this |
| `]h` / `[h` | Next / previous hunk |

### Buffer (`<leader>b`)

| Key | Action |
|---|---|
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Delete other buffers |
| `<leader>bp` | Pin/unpin buffer |
| `<leader>bP` | Close unpinned buffers |

### Session (`<leader>q`)

| Key | Action |
|---|---|
| `<leader>qs` | Save session |
| `<leader>qr` | Restore session |
| `<leader>qd` | Delete session |
| `<leader>qf` | Search sessions |

### Trouble (`<leader>x`)

| Key | Action |
|---|---|
| `<leader>xx` | All diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xs` | Symbols |
| `<leader>xr` | LSP references |
| `<leader>xl` | Location list |
| `<leader>xq` | Quickfix list |
| `<leader>xt` | TODOs |

### Navigation

| Key | Action |
|---|---|
| `s` | Flash jump |
| `S` | Flash treesitter select |
| `]d` / `[d` | Next / previous diagnostic |
| `]h` / `[h` | Next / previous git hunk |
| `]t` / `[t` | Next / previous TODO |
| `]f` / `[f` | Next / previous function |
| `]c` / `[c` | Next / previous class |
| `]]` / `[[` | Next / previous reference (snacks) |

### Treesitter Textobjects

| Key | Selects |
|---|---|
| `af` / `if` | Function (outer / inner) |
| `ac` / `ic` | Class (outer / inner) |
| `al` / `il` | Loop (outer / inner) |
| `ab` / `ib` | Block (outer / inner) |
| `aa` / `ia` | Parameter (outer / inner) |
| `<leader>a` | Swap parameter forward |
| `<leader>A` | Swap parameter backward |

### Editing

| Key | Action |
|---|---|
| `<C-s>` | Save file |
| `<C-q>` | Quit all |
| `Y` | Yank to end of line |
| `x` / `X` | Delete without yank |
| `<C-d>` / `<C-u>` | Scroll down/up (centered) |
| `<C-h/j/k/l>` | Window navigation |
| `<leader>e` | Toggle file explorer |
| `<leader>E` | Find file in explorer |

### Completion (insert mode)

| Key | Action |
|---|---|
| `<CR>` | Accept completion |
| `<Tab>` / `<S-Tab>` | Next / previous item |
| `<C-space>` | Toggle completion / docs |
| `<C-u>` / `<C-d>` | Scroll docs |
| `<C-e>` | Cancel |

## Usage

Symlink or copy to `~/.config/nvim`:

```bash
ln -sf /path/to/nvim-new ~/.config/nvim
```

Launch `nvim` — lazy.nvim will bootstrap itself and install all plugins automatically.
