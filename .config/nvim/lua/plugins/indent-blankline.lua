return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
      highlight = { "IblIndent" },
      smart_indent_cap = true,
      priority = 1,
    },
    whitespace = {
      highlight = { "IblWhitespace" },
      remove_blankline_trail = true,
    },
    scope = {
      enabled = true,
      char = "│",
      highlight = { "IblScope" },
      include = {
        node_type = {
          ["*"] = { "*" },
        },
      },
      exclude = {
        language = {},
        node_type = {
          ["*"] = {
            "source_file",
            "program",
          },
          python = {
            "module",
            "expression_statement",
          },
        },
      },
      show_start = true,
      show_end = false,
      injected_languages = false,
      priority = 1024,
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
  config = function(_, opts)
    local ibl = require("ibl")
    
    -- Custom highlight groups
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue", 
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }
    
    local hooks = require("ibl.hooks")
    
    -- Create the highlight groups in the highlight setup hook
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)
    
    -- Enable rainbow scope for Python files
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    
    ibl.setup(opts)
    
    -- Rainbow delimiters integration for Python
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        opts.scope.highlight = highlight
        ibl.setup(opts)
      end,
    })
  end,
}