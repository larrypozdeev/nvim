vim.g.mapleader = " "

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

vim.opt.colorcolumn = "80"


-- Map <leader>o & <leader>O to newline without insert mode
vim.api.nvim_set_keymap("n", "<leader>o",
  [[:<C-u>call append(line("."), repeat([""], v:count1))<CR>]],
  { silent = true, desc = "newline below (no insert-mode)" })
vim.api.nvim_set_keymap("n", "<leader>O",
  [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]],
  { silent = true, desc = "newline above (no insert-mode)" })

vim.api.nvim_set_keymap("n", "<C-up>", "<C-w><up>", {silent = true})
vim.api.nvim_set_keymap("n", "<C-down>", "<C-w><down>", {silent = true})
vim.api.nvim_set_keymap("n", "<C-left>", "<C-w><left>", {silent = true})
vim.api.nvim_set_keymap("n", "<C-right>", "<C-w><right>", {silent = true})

-- qwerty
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", {silent = true})
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", {silent = true})
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", {silent = true})
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", {silent = true})


