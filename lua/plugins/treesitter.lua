return {
  enable=false,
  "nvim-treesitter/nvim-treesitter",
  event = { "BufNewFile", "BufReadPost" },
  build = function()
    vim.cmd("TSUpdate")
  end,
  cmd = "TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      ensure_installed = {
        "lua",
        "astro",
        "typescript",
        "javascript",
        "tsx",
        "html",
      },
      highlight = {
        enable = true,
      },
      textsubjects = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
