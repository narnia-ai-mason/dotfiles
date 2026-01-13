local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- C/C++
    c = { "clang-format" },
    cpp = { "clang-format" },
    -- JavaScript/TypeScript (biome)
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },
    -- YAML
    yaml = { "yamlfmt" },
    -- dprint (markdown, toml 등)
    markdown = { "dprint" },
    toml = { "dprint" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
