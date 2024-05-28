return {
  'kristijanhusak/vim-dirvish-git',
  dependencies = { 'justinmk/vim-dirvish' },
  config = function()
    -- vim.g.dirvish_mode = ':sort ,^.*[\\/],'
    --
    -- vim.cmd [[
    --   autocmd FileType dirvish setlocal relativenumber
    -- ]]

    -- vim.g.dirvish_git_indicators = {
    --   Modified = '✹',
    --   Staged = '✚',
    --   Untracked = '✭',
    --   Renamed = '➜',
    --   Unmerged = '═',
    --   Ignored = '☒',
    --   Unknown = '?',
    -- }
  end,
}
