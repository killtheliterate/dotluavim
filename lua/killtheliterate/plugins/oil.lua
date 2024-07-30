-- Oil.nvim

return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local oil = require 'oil'

    oil.setup {
      view_options = {
        natural_order = false,
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
