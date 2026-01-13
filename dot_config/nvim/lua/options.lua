require "nvchad.options"

-- add yours here!

local o = vim.o
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99

-- o.cursorlineopt ='both' -- to enable cursorline!
