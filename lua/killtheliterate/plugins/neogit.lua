return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('neogit').setup {}

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { desc = 'Neogit: ' .. desc })
    end

    map('<leader>Go', function()
      local neogit = require 'neogit'

      neogit.open { kind = 'split' }
    end, 'Open')

    map('<leader>Gd', function()
      local neogit = require 'neogit'

      neogit.open { 'diff' }
    end, 'Diff')
  end,
}
