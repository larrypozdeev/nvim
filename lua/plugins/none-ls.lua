return {
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          -- Diagnostics
          "hadolint",
          "markdownlint", -- This is both, formatter and diagnostics

          -- Formatters
          "prettier",
          "stylua",

          -- Deprecated LSPs in none-ls plugin
          "eslint_d",
        },
      })
    end,
    lazy = true,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "jay-babu/mason-null-ls.nvim",
      -- Adding this as a dependency because some of the default lsps were removed
      -- See https://github.com/nvimtools/none-ls.nvim/discussions/81 for more information
      "nvimtools/none-ls-extras.nvim",
    },
    lazy = true,
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,

        -- Formatters based-off the new none-ls-extras plugin
        require("none-ls.code_actions.eslint_d"),
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.formatting.eslint_d"),
      })

      vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, {})
    end
  }
}
