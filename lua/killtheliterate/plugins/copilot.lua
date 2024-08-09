-- GitHub Copilot plugin

return {
  'github/copilot.vim',
  config = function()
    -- Disable the default tab key mapping
    vim.g.copilot_no_tab_map = true

    -- Map Copilot accept to Ctrl-J
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
    vim.g.copilot_no_tab_map = true

    -- Additional configurations
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ''
    vim.g.copilot_workspace_folders = {
      -- '~/repos',
      '~/repos/dog-nose',
      '~/repos/openmat-be',
      '~/repos/redux-saga-try-catch',
    }
  end,
}
