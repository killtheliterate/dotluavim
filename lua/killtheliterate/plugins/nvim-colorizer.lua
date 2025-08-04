return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  config = function()
    require('colorizer').setup {
      filetypes = { '*' },

      user_default_options = {
        css = true, -- enables parsing of `var(--*)` when resolvable
        -- names = false,
        tailwind = true, -- Enable tailwind colors
        tailwind_opts = { -- Options for highlighting tailwind names
          update_names = 'both', -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
        },
      },
    }
  end,
}
