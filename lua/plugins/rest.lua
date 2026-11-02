-- HTTP client: write requests in .http files and run them. The `http` parser is installed in treesitter.lua.
return {
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
}
