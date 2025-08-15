return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- Set keymaps
    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })
    keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
    keymap.set("n", "<leader>ft", "<cmd>Telescope colorscheme<cr>", { desc = "Find colorschemes" })
    
    -- LSP keymaps
    keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Find diagnostics for current buffer" })
    keymap.set("n", "<leader>fD", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics for all files" })
    keymap.set("n", "<leader>flr", "<cmd>Telescope lsp_references<cr>", { desc = "Find LSP references" })
    keymap.set("n", "<leader>fld", "<cmd>Telescope lsp_definitions<cr>", { desc = "Find LSP definitions" })
    keymap.set("n", "<leader>fli", "<cmd>Telescope lsp_implementations<cr>", { desc = "Find LSP implementations" })
    keymap.set("n", "<leader>flt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Find LSP type definitions" })
    keymap.set("n", "<leader>fls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Find LSP document symbols" })
    keymap.set("n", "<leader>flw", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Find LSP workspace symbols" })
  end,
}