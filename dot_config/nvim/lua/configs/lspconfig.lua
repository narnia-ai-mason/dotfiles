require("nvchad.configs.lspconfig").defaults()

vim.diagnostic.config {
  virtual_text = false, -- Disable text next to code
  signs = true, -- Show signs in gutter
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  -- Only show diagnostics with Error severity
  severity = {
    min = vim.diagnostic.severity.ERROR,
  },
}

-- Show diagnostic popup on cursor hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

local nvlsp = require "nvchad.configs.lspconfig"
local servers = { "html", "cssls", "clangd", "vtsls" }

for _, server in ipairs(servers) do
  vim.lsp.config[server] = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- pyrefly: uvx로 실행 (전역 설치 불가)
vim.lsp.config["pyrefly"] = {
  cmd = { "uvx", "pyrefly", "lsp" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

vim.lsp.enable(servers)
vim.lsp.enable("pyrefly")

