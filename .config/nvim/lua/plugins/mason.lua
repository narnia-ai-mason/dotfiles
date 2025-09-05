-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "williamboman/mason.nvim",
    opts = {
      -- pip 설정을 추가하여 공식 PyPI 저장소만 사용하도록 강제합니다.
      pip = {
        install_args = {
          "--index-url",
          "https://pypi.org/simple",
        },
      },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        -- "ruff-lsp",
        "basedpyright",

        -- install formatters
        "stylua",
        "ruff",

        -- install debuggers
        -- "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
