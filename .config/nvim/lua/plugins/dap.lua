return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup DAP UI
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25,
            position = "bottom",
          },
        },
        controls = {
          enabled = true,
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
      })

      -- Setup virtual text
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        display_callback = function(variable, buf, stackframe, node, options)
          if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value
          else
            return variable.name .. ' = ' .. variable.value
          end
        end,
        virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil
      })

      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Set keymaps
      local keymap = vim.keymap
      keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
      keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, { desc = "Debug: Set Conditional Breakpoint" })
      keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
      keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
      keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
      keymap.set("n", "<leader>de", dapui.eval, { desc = "Debug: Evaluate" })
      keymap.set("v", "<leader>de", dapui.eval, { desc = "Debug: Evaluate Selection" })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      -- Function to get Python path dynamically
      local function get_python_path()
        -- Check for .venv in project root
        local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
        if vim.fn.executable(venv_python) == 1 then
          return venv_python
        end
        
        -- Check for poetry environment
        local handle = io.popen("cd " .. vim.fn.getcwd() .. " && poetry env info -p 2>/dev/null")
        if handle then
          local poetry_path = handle:read("*a"):gsub("%s+", "")
          handle:close()
          if poetry_path and poetry_path ~= "" then
            local poetry_python = poetry_path .. "/bin/python"
            if vim.fn.executable(poetry_python) == 1 then
              return poetry_python
            end
          end
        end
        
        -- Check for conda environment
        local conda_env = os.getenv("CONDA_DEFAULT_ENV")
        if conda_env and conda_env ~= "base" then
          local conda_python = os.getenv("CONDA_PREFIX") .. "/bin/python"
          if vim.fn.executable(conda_python) == 1 then
            return conda_python
          end
        end
        
        -- Fallback to system python
        return "python"
      end

      require("dap-python").setup(get_python_path())
      
      -- Additional Python-specific keymaps
      vim.keymap.set("n", "<leader>dpt", function()
        require("dap-python").test_method()
      end, { desc = "Debug: Test Method" })
      
      vim.keymap.set("n", "<leader>dpc", function()
        require("dap-python").test_class()
      end, { desc = "Debug: Test Class" })
      
      vim.keymap.set("v", "<leader>dps", function()
        require("dap-python").debug_selection()
      end, { desc = "Debug: Selection" })
    end,
  },
}