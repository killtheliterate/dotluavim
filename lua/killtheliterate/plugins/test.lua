return {
  'vim-test/vim-test',
  config = function()
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
  end,
}
