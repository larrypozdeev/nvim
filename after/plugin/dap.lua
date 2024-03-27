local dap = require('dap')

dap.set_log_level('INFO')

dap.configuration = {
  go = {
    {
      type = 'go',
      name = 'Launch',
      request = 'launch',
      program = '${file}'
    }
  },
  codelldb = {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false
  }
}

