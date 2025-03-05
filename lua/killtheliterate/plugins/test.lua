return {
  'vim-test/vim-test',
  config = function()
    local helpers = require 'killtheliterate.helpers'

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { noremap = true, silent = true, desc = 'VimTest: ' .. desc })
    end

    map('<leader>uu', ':TestNearest<CR>', 'Run test nearest the cursor')
    map('<leader>uU', ':TestFile<CR>', 'Run entire test file')
    map('<leader>ua', ':TestSuite<CR>', 'Run suite')
    map('<leader>ul', ':TestLast<CR>', 'Run last test')
    map('<leader>ug', ':TestVisit<CR>', 'Visit file for last run test')

    vim.g['test#strategy'] = {
      nearest = 'neovim',
    }

    if helpers.has_vitest() then
      vim.g['test#javascript#runner'] = 'vitest'
    elseif helpers.has_deno_json() then
      vim.g['test#javascript#runner'] = 'deno'
    end
  end,
}
