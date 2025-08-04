return {
  'brenoprata10/nvim-highlight-colors',
  event = 'VeryLazy', -- or "BufReadPre" if you want it sooner
  config = function()
    require('nvim-highlight-colors').setup {
      render = 'virtual', -- options: "background", "foreground", "virtual"

      virtual_symbol = '●',

      enable_named_colors = false,
      enable_short_hex = false,
      enable_tailwind = true,
      enable_var_usage = true,
    }
  end,
}
