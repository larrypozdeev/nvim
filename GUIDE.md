# Neovim Setup — Guide & Refresher

> **Leader key = `Space`.** Anywhere below, `<leader>x` means *press Space, then x*.
> Forgot something? Press **Space and wait** — which-key pops up a menu of everything available.
> Or search all keymaps with **`<leader>sk`**.

---

## Table of contents

1. [How the config is organized](#1-how-the-config-is-organized)
2. [Everyday editing](#2-everyday-editing)
3. [Moving between windows](#3-moving-between-windows)
4. [Finding things — Telescope](#4-finding-things--telescope)
5. [Files & navigation — Neo-tree, netrw, Harpoon](#5-files--navigation)
6. [Code intelligence — LSP](#6-code-intelligence--lsp)
7. [Diagnostics & Trouble](#7-diagnostics--trouble)
8. [Completion & snippets](#8-completion--snippets)
9. [Git — gitsigns & fugitive](#9-git)
10. [Debugging — DAP](#10-debugging--dap)
11. [AI — Claude Code & Ollama](#11-ai--claude-code--ollama)
12. [Language extras — Go, REST](#12-language-extras)
13. [Other tools](#13-other-tools)
14. [Maintenance](#14-maintenance)
15. [Cheat sheet — all leader keys](#15-cheat-sheet--all-leader-keys)

---

## 1. How the config is organized

```
~/.config/nvim/                (symlinked from ~/.dotfiles/nvim)
├── init.lua                   bootstraps lazy.nvim, loads settings + plugins
├── lazy-lock.json             exact plugin versions (commit this)
└── lua/
    ├── vim-settings.lua       options + general keymaps (no plugins)
    └── plugins/               one file per plugin — lazy.nvim loads them all
        ├── claudecode.lua     Claude Code integration
        ├── completions.lua    nvim-cmp, LuaSnip, Minuet (Ollama autocomplete)
        ├── dap.lua            debugger
        ├── git-stuff.lua      gitsigns + fugitive
        ├── go-config.lua      go.nvim
        ├── harpoon.lua        quick file marks
        ├── lsp-config.lua     language servers (Mason + native vim.lsp)
        ├── telescope.lua      fuzzy finder
        ├── treesitter.lua     syntax parsing (main branch)
        ├── which-key.lua      key hint popup + group names
        └── …                  alpha, catppuccin, neo-tree, none-ls, ollama,
                               rest, todo-comments, trouble, undotree, centerpad
```

**To add a plugin:** create a new file in `lua/plugins/` returning a lazy.nvim spec, restart, done.
**To add a language server:** add its name to the `servers` table in `lsp-config.lua` — Mason installs it and it's enabled automatically.
**To add a syntax parser:** add it to the `parsers` list in `treesitter.lua`.

### Key settings worth knowing

| Setting | Effect |
|---|---|
| 2-space indent, spaces not tabs | `tabstop/shiftwidth = 2`, `expandtab` |
| Relative line numbers | count-based jumps like `5j` are easy to read off |
| No line wrap, column guide at 80 | `textwidth = 80` also **auto-wraps text as you type** |
| Persistent undo | undo history survives restarts (`~/.vim/undodir`) |
| Smart case search | `/foo` is case-insensitive, `/Foo` is case-sensitive |
| `scrolloff = 8` | cursor always keeps 8 lines of context |
| Live `:s` preview | `:%s/old/new` shows results in a split as you type |
| Folding via treesitter | off by default — `zi` toggles folding, `za` toggles one fold |
| Yank highlight | yanked text flashes briefly |

---

## 2. Everyday editing

| Keys | Mode | Action |
|---|---|---|
| `<leader>y` | normal / visual | Yank to **system clipboard** |
| `<leader>Y` | normal | Yank whole line to system clipboard |
| `<leader>p` | visual | Paste over selection **without losing** what you yanked |
| `<leader>d` | normal / visual | Delete **without overwriting** your yank register |
| `<leader>o` | normal | Insert blank line below, stay in normal mode (`3<leader>o` = 3 lines) |
| `<leader>O` | normal | Insert blank line above, stay in normal mode |
| `<leader>f` | normal | Format the current file (via LSP) |
| `<leader><F5>` | normal | Toggle **Undotree** — browse/restore any past state of the file |

> **Combo:** yank something with `y`, then select other text and `<leader>p` repeatedly — the original yank stays in the register.

---

## 3. Moving between windows

| Keys | Action |
|---|---|
| `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` | Move to window left / below / above / right |
| `Ctrl-←` / `Ctrl-↓` / `Ctrl-↑` / `Ctrl-→` | Same, with arrow keys |
| `Ctrl-f` | Open **tmux-sessionizer** in a new tmux window (jump to another project) |

Built-ins that pair well: `:vsp` / `:sp` to split, `Ctrl-w =` to equalize, `Ctrl-w q` to close. Mouse works for resizing splits.

---

## 4. Finding things — Telescope

| Keys | Searches |
|---|---|
| `<leader>sf` | **Files** in the current directory |
| `<leader>pf` | Git-tracked files only (faster in big repos) |
| `<leader>sg` | **Live grep** — text across the whole project |
| `<leader>sw` | Grep for the **word under the cursor** |
| `<leader><leader>` | Open **buffers** |
| `<leader>s.` | Recently opened files |
| `<leader>sd` | All diagnostics |
| `<leader>sh` | Neovim help tags |
| `<leader>sk` | **Keymaps** — find any binding |
| `<leader>sy` | Symbols (functions, types…) in the current file *(LSP)* |
| `<leader>ws` | Symbols across the whole workspace *(LSP)* |
| `<leader>ss` | List of all Telescope pickers |
| `<leader>sr` | **Resume** the last picker exactly where you left it |
| `<leader>rh` | Pick a rest.nvim environment |

**Inside a Telescope window:**

| Keys | Action |
|---|---|
| `Ctrl-n` / `Ctrl-p` | Next / previous result |
| `Enter` | Open |
| `Ctrl-x` / `Ctrl-v` / `Ctrl-t` | Open in horizontal split / vertical split / new tab |
| `Ctrl-q` | Send all results to the **quickfix list** |
| `Ctrl-u` / `Ctrl-d` | Scroll the preview |
| `Esc` (twice) | Close |
| `Ctrl-/` (insert) or `?` (normal) | Show all picker keys |

> **Combo — project-wide rename by hand:** `<leader>sg` → type the pattern → `Ctrl-q` → `:cdo s/old/new/g | update`.

---

## 5. Files & navigation

### Neo-tree (file tree)

| Keys | Action |
|---|---|
| `Ctrl-n` | Toggle the file tree on the right |

Inside the tree: `a` add file (end with `/` for a folder) · `d` delete · `r` rename · `m` move · `c` copy · `H` toggle hidden files · `/` filter · `?` help.

### netrw

| Keys | Action |
|---|---|
| `<leader>pv` | Open the built-in netrw explorer in the current window |

### Harpoon (your 4 most-used files, one keypress away)

| Keys | Action |
|---|---|
| `<leader>a` | **Add** the current file to your marks |
| `<leader>1` … `<leader>4` | Jump to marked file 1–4 |
| `Ctrl-e` | Quick menu — **reorder/delete** marks by editing lines, then close |
| `Ctrl-p` | Browse marks in Telescope (with preview) |

> **Workflow:** open the 3–4 files you're working on, `<leader>a` each, then bounce between them with `<leader>1-4` instead of searching. Marks are saved per project.

Built-in jumps you have back: `Ctrl-o` (jump back) and `Ctrl-i` (jump forward) — e.g. after `gd`, `Ctrl-o` returns you.

---

## 6. Code intelligence — LSP

Language servers start automatically when you open a matching file. Configured: **Go** (gopls), **TypeScript/JS** (ts_ls), **Python** (pyright), **Rust** (rust_analyzer), **C/C++** (clangd), **PHP** (phpactor), **Lua** (lua_ls), **HTML/CSS/Emmet/HTMX**, **Astro**, **ESLint**, **Docker** — plus anything else you've installed through `:Mason`.

| Keys | Action |
|---|---|
| `gd` | **Go to definition** |
| `gr` | **List references** (everywhere this is used) |
| `gI` | Go to implementation |
| `gD` | Go to declaration (e.g. the C header) |
| `<leader>D` | Go to the *type's* definition |
| `K` | Hover docs for the symbol under cursor (press again to enter the popup) |
| `<leader>rn` | **Rename** symbol across the project |
| `<leader>ca` | **Code actions** — quick fixes, imports, refactors |
| `<leader>th` | Toggle inlay hints (inline type / parameter names) |
| `<leader>sy` / `<leader>ws` | Symbols in file / workspace |
| `<leader>f` | Format file |

Words under the cursor get highlighted everywhere they appear after a moment. Progress of servers loading shows in the bottom-right (fidget).

> **Combo — understand unfamiliar code:** `K` to read docs → `gd` to jump in → `gr` to see callers → `Ctrl-o` to come back.

---

## 7. Diagnostics & Trouble

Errors and warnings show **inline at the end of the line** and as signs in the left column.

| Keys | Action |
|---|---|
| `]d` / `[d` | Jump to next / previous diagnostic (and show it in a popup) |
| `<leader>e` | Show the full diagnostic under the cursor in a popup |
| `<leader>q` | Put this file's diagnostics in the location list |
| `<leader>sd` | Fuzzy-search all diagnostics (Telescope) |

### Trouble (nicer list panels)

| Keys | Action |
|---|---|
| `<leader>xx` | All diagnostics in the project |
| `<leader>xX` | Diagnostics in the current file only |
| `<leader>cs` | Symbol outline of the file |
| `<leader>cl` | LSP panel — definitions / references / implementations on the right |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |

All Trouble keys **toggle** — press again to close.

---

## 8. Completion & snippets

Completion pops up automatically in insert mode. Sources: LSP, snippets (friendly-snippets), file paths, and **Minuet** (local AI completions from Ollama's `codellama:code`). Ghost text previews the top suggestion.

| Keys (insert mode) | Action |
|---|---|
| `Ctrl-n` / `Ctrl-p` | Next / previous suggestion |
| `Ctrl-y` | **Accept** suggestion |
| `Ctrl-e` | Close the menu |
| `Ctrl-Space` | Open the menu manually |
| `Ctrl-b` / `Ctrl-f` | Scroll the docs window |
| `Ctrl-l` | Expand snippet / jump to **next** placeholder |
| `Ctrl-h` | Jump to **previous** placeholder |

> Minuet needs Ollama running (`ollama serve`) with `codellama:code` pulled; otherwise it's silently skipped.

---

## 9. Git

### gitsigns — changes in the gutter

| Keys | Action |
|---|---|
| `]h` / `[h` | Next / previous changed hunk |
| `<leader>hp` | **Preview** the hunk's diff |
| `<leader>hs` | **Stage** hunk (in visual mode: stage just the selected lines) |
| `<leader>hr` | **Reset** hunk — discard the change (visual: selected lines) |
| `<leader>hS` / `<leader>hR` | Stage / reset the whole file |
| `<leader>hb` | Blame the current line (full commit info) |
| `<leader>hd` | Diff the file against the index |
| `<leader>tb` | Toggle inline blame on every line |

### fugitive — full git from inside Neovim

| Command | Action |
|---|---|
| `:G` | Status window — `s` stage, `u` unstage, `=` inline diff, `cc` commit, `ca` amend |
| `:G push` / `:G pull` | Push / pull |
| `:G log` | Log |
| `:G blame` | Blame the whole file side by side |
| `:Gvdiffsplit` | Diff the working copy vs index side by side |

> **Combo — clean commits:** `]h` through your changes → `<leader>hp` to review each → `<leader>hs` the ones that belong → `:G` → `cc`.

---

## 10. Debugging — DAP

Configured for **Go** (Delve via nvim-dap-go). The debug UI opens automatically when a session starts and closes when it ends; variable values appear inline next to the code.

| Keys | Action |
|---|---|
| `<leader>b` | Toggle **breakpoint** on the current line |
| `F1` | **Start / continue** |
| `F2` | Step **into** |
| `F3` | Step **over** |
| `F4` | Step **out** |
| `F5` | Step back (if the adapter supports it) |
| `Shift-F1` (`F13`) | Restart the session |
| `<leader>gb` | Run until the cursor line |
| `<leader>?` | Evaluate the variable under cursor in a popup |

> **Workflow:** `<leader>b` on a suspicious line → `F1` → pick a config (e.g. *Debug test*) → `F3` to walk through → `<leader>?` to inspect values.

---

## 11. AI — Claude Code & Ollama

Everything AI lives under **`<leader>i`**.

### Claude Code

Runs the `claude` CLI in a split on the right, connected to Neovim: Claude sees your current file and selection, and its proposed edits open as **side-by-side diffs** you approve.

| Keys | Mode | Action |
|---|---|---|
| `<leader>ic` | normal | **Toggle** Claude window |
| `<leader>if` | normal | Focus the Claude window |
| `<leader>ir` | normal | Resume a previous session (picker) |
| `<leader>iC` | normal | Continue the most recent session |
| `<leader>im` | normal | Choose the model |
| `<leader>ib` | normal | Add the current file to Claude's context |
| `<leader>is` | visual | **Send the selection** to Claude |
| `<leader>is` | in Neo-tree | Add the file under the cursor |
| `<leader>ia` | normal | **Accept** the proposed diff |
| `<leader>id` | normal | **Deny** the proposed diff |

> **Workflow:** select a function → `<leader>is` → "add error handling here" → review the diff → `<leader>ia` or `<leader>id`.
> Already running `claude` in another terminal? Type `/ide` there to connect it to this Neovim.

### Ollama (local models)

| Keys | Mode | Action |
|---|---|---|
| `<leader>io` | normal / visual | Open the Ollama prompt menu (acts on selection if any) |
| `<leader>ig` | normal / visual | Generate code |

Uses `gpt-oss:20b` at `127.0.0.1:11434`. `:OllamaModel` switches model.

---

## 12. Language extras

### Go (go.nvim)

Loads automatically in `.go` files. Handy commands:

| Command | Action |
|---|---|
| `:GoTest` / `:GoTestFunc` | Run package tests / the test under cursor |
| `:GoIfErr` | Insert an `if err != nil { … }` block |
| `:GoFillStruct` | Fill a struct literal with all fields |
| `:GoAddTag` | Add JSON (or other) tags to struct fields |
| `:GoImpl` | Generate methods to implement an interface |
| `:GoImports` | Fix imports |
| `:GoCoverage` | Show test coverage in the gutter |

### REST (rest.nvim)

Write requests in a `.http` file, put the cursor on one, and run `:Rest run`. Pick an environment file with `<leader>rh`.

```http
GET https://api.example.com/users
Authorization: Bearer {{TOKEN}}
```

---

## 13. Other tools

| Tool | How to use |
|---|---|
| **Dashboard** (alpha) | Shown when you open `nvim` with no file — recent files + shortcuts |
| **todo-comments** | `TODO:`, `FIX:`, `HACK:`, `NOTE:`, `WARN:` get highlighted. `:TodoTelescope` / `:TodoTrouble` list them all |
| **Undotree** | `<leader><F5>` — tree of every edit; move and `Enter` to restore |
| **Centerpad** | `:Centerpad` — center the buffer for focused writing |
| **which-key** | Press `Space` (or `g`, `]`, `z`…) and wait for a menu of next keys |
| **Theme** | Catppuccin with transparent background |

---

## 14. Maintenance

| Command | What it does |
|---|---|
| `:Lazy` | Plugin manager UI — `S` sync (install + update + clean), `U` update, `X` clean |
| `:Lazy sync` | Same as `S`; commit `lazy-lock.json` afterwards |
| `:Mason` | Install / update language servers, formatters, debuggers (`i` install, `U` update all) |
| `:TSUpdate` | Update treesitter parsers |
| `:checkhealth` | Diagnose problems (`:checkhealth vim.lsp` for language servers) |
| `:LspInfo` / `:checkhealth vim.lsp` | Which servers are attached to this buffer |
| `:messages` | See recent errors / notifications |

> **Tip:** after `:Lazy sync` updates big plugins (treesitter especially), **restart Neovim** before doing anything else.

---

## 15. Cheat sheet — all leader keys

| Prefix | Group | Keys |
|---|---|---|
| `<leader><leader>` | — | buffers |
| `<leader>1-4` | Harpoon | jump to marked file |
| `<leader>a` | Harpoon | add file |
| `<leader>b` | Debug | breakpoint |
| `<leader>c` | Code | `a` code action · `s` symbols (Trouble) · `l` LSP panel |
| `<leader>d` | — | delete without yanking |
| `<leader>D` | LSP | type definition |
| `<leader>e` | Diagnostics | show under cursor |
| `<leader>f` | — | format file |
| `<leader>g` | Debug | `b` run to cursor |
| `<leader>h` | Git hunk | `s` stage · `r` reset · `S` stage file · `R` reset file · `p` preview · `b` blame · `d` diff |
| `<leader>i` | AI | `c` Claude · `f` focus · `r` resume · `C` continue · `m` model · `b` add buffer · `s` send · `a` accept · `d` deny · `o` Ollama · `g` generate |
| `<leader>o` / `O` | — | blank line below / above |
| `<leader>p` | Project | `f` git files · `v` netrw · *(visual)* paste keep yank |
| `<leader>q` | Diagnostics | to location list |
| `<leader>r` | Rename / REST | `n` rename symbol · `h` REST env |
| `<leader>s` | Search | `f` files · `g` grep · `w` word · `d` diagnostics · `h` help · `k` keymaps · `y` symbols · `s` pickers · `r` resume · `.` recent |
| `<leader>t` | Toggle | `h` inlay hints · `b` inline git blame |
| `<leader>w` | Workspace | `s` symbols |
| `<leader>x` | Trouble | `x` diagnostics · `X` file diagnostics · `L` loclist · `Q` quickfix |
| `<leader>y` / `Y` | — | yank to clipboard / line |
| `<leader>?` | Debug | evaluate under cursor |
| `<leader><F5>` | — | Undotree |

**Non-leader:** `Ctrl-h/j/k/l` windows · `Ctrl-n` file tree · `Ctrl-e` harpoon menu · `Ctrl-p` harpoon list · `Ctrl-f` tmux-sessionizer · `gd` `gr` `gI` `gD` `K` LSP · `]d` `[d` diagnostics · `]h` `[h` hunks · `F1`–`F5` debugger.
