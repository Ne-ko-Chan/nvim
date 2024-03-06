return {
  "lervag/vimtex",
  init = function ()
    vim.cmd("filetype plugin indent on")
    vim.cmd("syntax enable")
    vim.cmd("let g:vimtex_view_method = 'zathura'")
    vim.cmd("let g:vimtex_compiler_method = 'latexmk'")
  end
}
