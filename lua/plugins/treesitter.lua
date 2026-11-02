-- nvim-treesitter `main` branch (the `master` branch is frozen and does not support Neovim 0.12).
-- Requires the `tree-sitter` CLI and a C compiler to build parsers.
local parsers = {
  "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
  "go", "gomod", "gosum", "gowork",
  "astro", "typescript", "javascript", "tsx", "html", "css",
  "php", "python", "rust", "c", "cpp",
  "json", "yaml", "toml", "dockerfile", "bash",
  "http", -- used by rest.nvim
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- the main branch does not support lazy-loading
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(parsers)

    -- Highlighting, folding and indentation are started per buffer.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
      callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
