return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        -- diagnostics
        null_ls.builtins.diagnostics.codespell,
        require('none-ls.diagnostics.eslint_d').with {
          method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          condition = function(utils)
            return utils.root_has_file { 'package.json' }
          end,
        },
        null_ls.builtins.diagnostics.stylelint.with {
          filetypes = { 'scss', 'css' },
        },

        -- formatting
        null_ls.builtins.formatting.prettierd.with {
          condition = function(utils)
            return utils.root_has_file { 'package.json' }
          end,
        },
      },
    }
  end,
}
