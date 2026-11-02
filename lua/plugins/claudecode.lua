-- Claude Code integration (same protocol as the official VS Code / JetBrains extensions).
-- Claude sees your current file + visual selection, and proposes edits as native nvim diffs.
-- <leader>a is taken by harpoon, so Claude lives under <leader>i ("AI").
return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" }, -- nicer terminal window; falls back to native if missing
  cmd = {
    "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSend", "ClaudeCodeAdd",
    "ClaudeCodeTreeAdd", "ClaudeCodeSelectModel", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny",
  },
  opts = {
    terminal_cmd = vim.fn.expand("~/.local/bin/claude"),
    terminal = {
      split_side = "right",
      split_width_percentage = 0.35,
    },
    diff_opts = {
      vertical_split = true,
      open_in_current_tab = true,
    },
  },
  keys = {
    { "<leader>i", nil, desc = "A[I] / Claude Code" },
    { "<leader>ic", "<cmd>ClaudeCode<cr>", desc = "Toggle [C]laude" },
    { "<leader>if", "<cmd>ClaudeCodeFocus<cr>", desc = "[F]ocus Claude" },
    { "<leader>ir", "<cmd>ClaudeCode --resume<cr>", desc = "[R]esume session" },
    { "<leader>iC", "<cmd>ClaudeCode --continue<cr>", desc = "[C]ontinue last session" },
    { "<leader>im", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select [M]odel" },
    { "<leader>ib", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current [B]uffer" },
    { "<leader>is", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "[S]end selection" },
    {
      "<leader>is",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file from tree",
      ft = { "neo-tree", "NvimTree", "oil" },
    },
    { "<leader>ia", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "[A]ccept diff" },
    { "<leader>id", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "[D]eny diff" },
  },
}
