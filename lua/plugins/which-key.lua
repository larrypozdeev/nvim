return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    local wk = require("which-key")
    wk.setup()

    -- Register normal mode groups with descriptions.
    wk.add({
      { "<leader>c", group = "[C]ode", remap = false },
      { "<leader>r", group = "[R]ename", remap = false },
      { "<leader>s", group = "[S]earch", remap = false },
      { "<leader>t", group = "[T]oggle", remap = false },
      { "<leader>w", group = "[W]orkspace", remap = false },
      { "<leader>h", group = "Git [H]unk", remap = false },
      { "<leader>i", group = "A[I] / Claude Code", remap = false, mode = { "n", "v" } },
      { "<leader>x", group = "Trouble lists", remap = false },
      { "<leader>p", group = "[P]roject files", remap = false },
      { "<leader>g", group = "Debu[g]", remap = false },
    })

    -- Register the visual mode group.
    wk.add({
      { "<leader>h", group = "Git [H]unk", remap = false, mode = "v" },
    })
  end,
}

