local lint = require "lint"

lint.linters.cppcheck = {
  cmd = "cppcheck",
  args = {
    "--enable=warning,performance,portability,information",
    "--language=c++",
    "--std=c++20",
    "--inline-suppr",
    "--quiet",
    "--cppcheck-build-dir=build",
    "--template={file}:{line}:{column}: [{id}] {severity}: {message}",
    "--project=compile_commands.json", -- use this if you have a compilation database
  },
  stdin = false,
  stream = "stderr",
  ignore_exitcode = true, -- cppcheck will exit with code 1 when warnings are present
  parser = require("lint.parser").from_pattern(
    "(.+):(%d+):(%d+): %[(.+)%] (.+): (.+)",
    { "file", "line", "column", "id", "severity", "message" },
    {
      error = vim.diagnostic.severity.ERROR,
      warning = vim.diagnostic.severity.WARN,
      style = vim.diagnostic.severity.INFO,
      performance = vim.diagnostic.severity.INFO,
      portability = vim.diagnostic.severity.INFO,
      information = vim.diagnostic.severity.INFO,
    },
    { source = "cppcheck" }
  ),
}

lint.linters_by_ft = {
  cpp = { "cppcheck" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
