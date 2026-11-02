vim.g.mapleader = " "
vim.o.termguicolors = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.textwidth = 80
vim.opt.formatoptions:append("t")
vim.opt.colorcolumn = "80"

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Decrease update time
vim.opt.updatetime = 50

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.api.nvim_set_keymap("n", "<leader>pv", ":Explore<CR>", { silent = true, desc = "Open netrw file explorer" })

-- Map <leader>o & <leader>O to newline without insert mode
vim.api.nvim_set_keymap(
  "n",
  "<leader>o",
  [[:<C-u>call append(line("."), repeat([""], v:count1))<CR>]],
  { silent = true, desc = "Insert blank line(s) below (stay in normal mode)" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>O",
  [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]],
  { silent = true, desc = "Insert blank line(s) above (stay in normal mode)" }
)

vim.api.nvim_set_keymap("n", "<C-up>", "<C-w><up>", { silent = true, desc = "Move to window above" })
vim.api.nvim_set_keymap("n", "<C-down>", "<C-w><down>", { silent = true, desc = "Move to window below" })
vim.api.nvim_set_keymap("n", "<C-left>", "<C-w><left>", { silent = true, desc = "Move to window left" })
vim.api.nvim_set_keymap("n", "<C-right>", "<C-w><right>", { silent = true, desc = "Move to window right" })

-- qwerty
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to window left" })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to window below" })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to window above" })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to window right" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show [E]rror/diagnostic under cursor in a popup" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Send file diagnostics to location list ([Q]uickfix)" })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = "Go to next [D]iagnostic message" })

-- Show diagnostics inline at the end of the line (off by default since Neovim 0.11)
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = "rounded", source = true },
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[P]aste over selection, keep yanked text" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[D]elete without overwriting yanked text" })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open tmux-sessionizer (switch project)" })
