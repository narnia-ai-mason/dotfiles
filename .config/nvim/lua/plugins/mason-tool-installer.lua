return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  config = function()
    local mason_tool_installer = require("mason-tool-installer")

    mason_tool_installer.setup({
      ensure_installed = {
        -- LSP servers
        "basedpyright",
        "svelte-language-server", 
        "lua-language-server",
        "tailwindcss-language-server",
        "eslint-lsp",
        "html-lsp",
        "css-lsp",
        "json-lsp",
        
        -- Formatters
        "prettier",
        "stylua",
        "ruff",
        
        -- Linters
        "eslint_d",
        "ruff",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
    })
  end,
}