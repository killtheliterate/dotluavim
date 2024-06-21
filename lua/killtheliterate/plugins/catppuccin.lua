return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    -- @NOTE: https://rrethy.github.io/book/colorscheme.html

    require('catppuccin').setup {
      flavour = 'frappe',
      show_end_of_buffer = true,
      dim_inactive = {
        enabled = true,
      },
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
