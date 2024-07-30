return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},

  config = function()
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    map('<leader>qs', require('persistence').load, 'Persistence: Restore for current directory')
    -- map('<leader>ql', require('persistence').load { last = true }, 'Persistence: Restore last session')
    map('<leader>qd', require('persistence').stop, 'Persistence: Stop')
  end,
}
