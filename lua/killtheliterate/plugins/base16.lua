return {
  'RRethy/base16-nvim',
  lazy = false,
  priority = 1000,
  config = function()
    -- @NOTE: https://rrethy.github.io/book/colorscheme.html
    vim.cmd 'colorscheme base16-gruvbox-dark-soft'
  end,
}
