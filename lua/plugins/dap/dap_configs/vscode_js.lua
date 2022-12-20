local get_config = function (options)
  local config = {
    test = {
      type = "pwa-node",
      request = "launch",
      name = "Debug Mocha Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "npx",
      runtimeArgs = {
        "hardhat",
        "test",
        vim.fn.expand("%"),
      },
      -- rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      resolveSourceMapLocations = { "${workspaceFolder}/dist/**/*.js", "${workspaceFolder}/**", "!**/node_modules/**" },
      internalConsoleOptions = "neverOpen",
    },
    launch = {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    attach = {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    }
  }
  return vim.tbl_map(function (option)
    return config[option]
  end, options)
end

return get_config
