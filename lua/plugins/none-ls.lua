return {
  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     require("mason-null-ls").setup({
  --       ensure_installed = {
  --         -- Diagnostics
  --         "hadolint",
  --         "markdownlint", -- This is both, formatter and diagnostics

  --         -- Formatters
  --         "prettier",
  --         "stylua",

  --         -- Deprecated LSPs in none-ls plugin
  --         "eslint_d",
  --       },
  --       handlers={},
  --       methods = {
  --         diagnostics = true,
  --         formatting = true,
  --         code_actions = true,
  --         completion = true,
  --         hover = true,
  --         automatic_installation = true,
  --       },
  --     })
  --   end,
  --   lazy = true,
  -- },
  {
    
    "nvimtools/none-ls.nvim",
    dependencies = {
      "jay-babu/mason-null-ls.nvim",
      config = function()
        require("mason-null-ls").setup({
          automatic_installation = true,
          handlers = {}
        })
      end

    },
    lazy = true,
    config = function()
      require("null-ls").setup({
        sources = {
        }
      })
      -- null_ls.setup({
      --   sources = {
      --     require("null-ls").builtins.formatting.phpcsfixer.with({
      --       extra_args = { "--rules=@PSR12", "--using-cache=no" }, -- customize as needed
      --     }),
      --   },
      --   null_ls.builtins.formatting.stylua,
      --   null_ls.builtins.formatting.prettier,

      --   -- Formatters based-off the new none-ls-extras plugin
      --   require("none-ls.code_actions.eslint_d"),
      --   require("none-ls.diagnostics.eslint_d"),
      --   require("none-ls.formatting.eslint_d"),
      -- })

      vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, {})
    end
  }
}
