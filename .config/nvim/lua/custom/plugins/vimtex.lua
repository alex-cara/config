return {
  'lervag/vimtex',
  init = function()
    vim.g.vimtex_compiler_latexmk = {
      build_dir = '.latexmk',
      options = {
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-interaction=nonstopmode',
        '-synctex=1',
      },
    }
    vim.g.vimtex_view_method = 'zathura'
  end,
}
