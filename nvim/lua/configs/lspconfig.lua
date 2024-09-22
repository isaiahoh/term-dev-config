-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "taplo", "marksman" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
lspconfig.clangd.setup {
  on_new_config = function(new_config, _)
    local status, cmake = pcall(require, "cmake-tools")
    if status then
      cmake.clangd_on_new_config(new_config)
    end
  end,
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--clang-tidy-checks=*",
    "--completion-style=bundled",
    "--header-insertion=iwyu",
  },
}

lspconfig.cmake.setup {
  -- Customize any additional options for the language server here
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "cmake-language-server" },
  filetypes = { "cmake" },
  init_options = {
    buildDirectory = "build",
  },
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
  end,
  settings = {},
}

lspconfig.pyright.setup {
  on_init = nvlsp.on_init,
  on_attach = nvlsp.on_attach,
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
    },
  },
  capabilities = nvlsp.capabilities,
  filetypes = { "python" },
}
lspconfig.ruff.setup {
  on_init = nvlsp.on_init,
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
}

lspconfig.rust_analyzer.setup {
  on_init = nvlsp.on_init,
  on_attach = nvlsp.on_attach,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
    },
  },
  capabilities = nvlsp.capabilities,
  filtypes = { "rust" },
}

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
