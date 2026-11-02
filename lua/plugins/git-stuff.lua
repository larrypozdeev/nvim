return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gs = require("gitsigns")
      gs.setup({
        on_attach = function(bufnr)
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          map("n", "]h", function() gs.nav_hunk("next") end, "Git: next changed hunk")
          map("n", "[h", function() gs.nav_hunk("prev") end, "Git: previous changed hunk")

          map("n", "<leader>hs", gs.stage_hunk, "Git: [S]tage / unstage hunk")
          map("n", "<leader>hr", gs.reset_hunk, "Git: [R]eset hunk (discard changes)")
          map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
            "Git: [S]tage selected lines")
          map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
            "Git: [R]eset selected lines")
          map("n", "<leader>hS", gs.stage_buffer, "Git: [S]tage whole file")
          map("n", "<leader>hR", gs.reset_buffer, "Git: [R]eset whole file")
          map("n", "<leader>hp", gs.preview_hunk, "Git: [P]review hunk diff")
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Git: [B]lame current line")
          map("n", "<leader>hd", gs.diffthis, "Git: [D]iff file against index")
          map("n", "<leader>tb", gs.toggle_current_line_blame, "[T]oggle inline git [B]lame")
        end,
      })
    end,
  },
  {
    "tpope/vim-fugitive", -- :Git / :G for everything else (commit, push, log, blame...)
  },
}
