return {
  "mbbill/undotree",
  config = function ()
    vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle, { desc = "Toggle undo history tree" })
  end
}
