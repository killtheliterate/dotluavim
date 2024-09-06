require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} },
  require 'kickstart.plugins.autopairs',
  require 'kickstart/plugins/gitsigns',
  require 'kickstart/plugins/todo-comments',
  require 'kickstart/plugins/treesitter',
  require 'kickstart/plugins/which-key',

  require 'killtheliterate.plugins.catppuccin',
  require 'killtheliterate.plugins.cmp',
  require 'killtheliterate.plugins.conform',
  -- require 'killtheliterate.plugins.copilot',
  require 'killtheliterate.plugins.flash',
  require 'killtheliterate.plugins.indent_line',
  require 'killtheliterate.plugins.kitty',
  require 'killtheliterate.plugins.lint',
  require 'killtheliterate.plugins.lspconfig',
  require 'killtheliterate.plugins.mini',
  require 'killtheliterate.plugins.oil',
  require 'killtheliterate.plugins.reveal',
  require 'killtheliterate.plugins.telescope',
  require 'killtheliterate.plugins.trouble',

  'myusuf3/numbers.vim',
  'tpope/vim-eunuch',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tribela/vim-transparent',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
