return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>j', group = 'Harpoon [J]umps' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>u', group = '[U]nit Test' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>G', group = '[G]it' },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
