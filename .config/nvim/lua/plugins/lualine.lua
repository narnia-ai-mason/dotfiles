return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")

    -- Function to get Python environment
    local function python_env()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return " " .. vim.fn.fnamemodify(venv, ":t")
      end
      
      -- Check for .venv
      local venv_path = vim.fn.getcwd() .. "/.venv"
      if vim.fn.isdirectory(venv_path) == 1 then
        return " .venv"
      end
      
      return ""
    end

    -- Simple LSP status
    local function lsp_status()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        return ""
      end
      
      local names = {}
      for _, client in pairs(clients) do
        if client.name ~= "GitHub Copilot" then
          table.insert(names, client.name)
        end
      end
      
      if #names == 0 then
        return ""
      end
      
      return " " .. table.concat(names, ", ")
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { 
          "branch", 
          "diff",
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " " },
          }
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            newfile_status = false,
            path = 1,
            shorting_target = 40,
            symbols = {
              modified = "[+]",
              readonly = "[-]",
              unnamed = "[No Name]",
              newfile = "[New]",
            }
          }
        },
        lualine_x = {
          {
            python_env,
            color = { fg = "#98c379" },
          },
          {
            lsp_status,
            color = { fg = "#61afef" },
          },
          "encoding",
          "fileformat",
          "filetype"
        },
        lualine_y = { "progress" },
        lualine_z = { "location" }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { "trouble", "quickfix" }
    })
  end,
}