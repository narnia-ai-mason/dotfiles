require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- 외부에서 파일이 변경되면 자동으로 버퍼 갱신
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- 파일을 열 때마다 Treesitter 기반 Folding 설정 강제 적용
autocmd({ "BufReadPost", "FileReadPost" }, {
  pattern = "*",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})