return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  config = function()
    -- Function to get Python path dynamically (same as in dap.lua)
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

    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { 
            justMyCode = false,
            console = "integratedTerminal",
          },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
          python = get_python_path(),
          pytest_discover_instances = true,
        }),
      },
      discovery = {
        concurrent = 1,
        enabled = true,
      },
      diagnostic = {
        enabled = true,
        severity = 1,
      },
      floating = {
        border = "rounded",
        max_height = 0.6,
        max_width = 0.6,
        options = {},
      },
      highlights = {
        adapter_name = "NeotestAdapterName",
        border = "NeotestBorder",
        dir = "NeotestDir",
        expand_marker = "NeotestExpandMarker",
        failed = "NeotestFailed",
        file = "NeotestFile",
        focused = "NeotestFocused",
        indent = "NeotestIndent",
        marked = "NeotestMarked",
        namespace = "NeotestNamespace",
        passed = "NeotestPassed",
        running = "NeotestRunning",
        select_win = "NeotestWinSelect",
        skipped = "NeotestSkipped",
        target = "NeotestTarget",
        test = "NeotestTest",
        unknown = "NeotestUnknown",
      },
      icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "✖",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "✓",
        running = "●",
        running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
        skipped = "○",
        unknown = "?",
      },
      output = {
        enabled = true,
        open_on_run = "short",
      },
      output_panel = {
        enabled = true,
        open = "botright split | resize 15",
      },
      quickfix = {
        enabled = true,
        open = false,
      },
      run = {
        enabled = true,
      },
      running = {
        concurrent = true,
      },
      state = {
        enabled = true,
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = false,
      },
      strategies = {
        integrated = {
          height = 40,
          width = 120,
        },
      },
      summary = {
        animated = true,
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
          attach = "a",
          clear_marked = "M",
          clear_target = "T",
          debug = "d",
          debug_marked = "D",
          expand = { "<CR>", "<2-LeftMouse>" },
          expand_all = "e",
          jumpto = "i",
          mark = "m",
          next_failed = "J",
          output = "o",
          prev_failed = "K",
          run = "r",
          run_marked = "R",
          short = "O",
          stop = "u",
          target = "t",
        },
      },
    })

    -- Set keymaps
    local keymap = vim.keymap
    keymap.set("n", "<leader>tt", function()
      require("neotest").run.run()
    end, { desc = "Test: Run Nearest" })
    
    keymap.set("n", "<leader>tf", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = "Test: Run File" })
    
    keymap.set("n", "<leader>td", function()
      require("neotest").run.run({strategy = "dap"})
    end, { desc = "Test: Debug Nearest" })
    
    keymap.set("n", "<leader>ts", function()
      require("neotest").summary.toggle()
    end, { desc = "Test: Toggle Summary" })
    
    keymap.set("n", "<leader>to", function()
      require("neotest").output.open({ enter = true, auto_close = true })
    end, { desc = "Test: Show Output" })
    
    keymap.set("n", "<leader>tO", function()
      require("neotest").output_panel.toggle()
    end, { desc = "Test: Toggle Output Panel" })
    
    keymap.set("n", "<leader>tS", function()
      require("neotest").run.stop()
    end, { desc = "Test: Stop" })
    
    keymap.set("n", "]t", function()
      require("neotest").jump.next({ status = "failed" })
    end, { desc = "Test: Jump to Next Failed" })
    
    keymap.set("n", "[t", function()
      require("neotest").jump.prev({ status = "failed" })
    end, { desc = "Test: Jump to Previous Failed" })
  end,
}