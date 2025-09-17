-- Oil.nvim

return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local oil = require 'oil'

    oil.setup {
      view_options = {
        case_insensitive = true,
        natural_order = false,
        show_hidden = true,
        sort = {
          { 'name', 'asc' },
        },
      },

      keymaps = {
        ['<C-t>'] = false,
      },
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
