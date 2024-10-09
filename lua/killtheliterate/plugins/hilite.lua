return {
  -- for bad things that don't have treesitter support

  {
    'Glench/Vim-Jinja2-Syntax',
    ft = { 'jinja2', 'njk' },
    config = function()
      vim.cmd [[autocmd BufNewFile,BufRead *.njk set filetype=html.jinja2]]
    end,
  },
}
