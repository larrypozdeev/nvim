return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- image support in preview window
  },
  config = function()
    vim.api.nvim_set_keymap('n', '<C-n>', ':Neotree filesystem toggle right<CR>', {silent = true})

  end
}
