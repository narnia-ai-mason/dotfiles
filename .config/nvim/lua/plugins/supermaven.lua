return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-a>",
        clear_suggestion = "<C-h>",
        accept_word = "<C-l>",
      }
    })
  end,
}
