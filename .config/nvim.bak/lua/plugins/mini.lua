return {
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("mini.pairs").setup({
        modes = { insert = true, command = false, terminal = false },
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        skip_ts = { "string" },
        skip_unbalanced = true,
        markdown = true,
        mappings = {
          ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
          
          [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
          ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
          ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
          
          ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
          ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
          ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
        },
      })
    end,
  },
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup({
        custom_surroundings = nil,
        highlight_duration = 500,
        mappings = {
          add = "ys",           -- Add surrounding in Normal and Visual modes
          delete = "ds",        -- Delete surrounding
          find = "gzf",         -- Find surrounding (to the right)
          find_left = "gzF",    -- Find surrounding (to the left)
          highlight = "gzh",    -- Highlight surrounding
          replace = "cs",       -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`

          suffix_last = "l",    -- Suffix to search with "prev" method
          suffix_next = "n",    -- Suffix to search with "next" method
        },
        n_lines = 20,
        respect_selection_type = false,
        search_method = "cover",
        silent = false,
      })
    end,
  },
}