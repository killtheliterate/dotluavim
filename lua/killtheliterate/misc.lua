vim.api.nvim_create_user_command('OpenInVSCode', function()
  local filepath = vim.fn.expand '%:p' -- ':p' expands to full path

  os.execute('code ' .. filepath)
end, { desc = 'Open the current file in Visual Studio Code' })

vim.diagnostic.config {
  severity_sort = true,

  virtual_text = {
    source = false,
    prefix = '●',
    format = function()
      return ''
    end,
  },

  float = {
    source = 'if_many',
    format = function(diagnostic)
      if diagnostic.source == 'eslint' then
        return string.format('%s [%s]', diagnostic.message, diagnostic.user_data.lsp.code)
      end

      return string.format('%s [%s]', diagnostic.message, diagnostic.source)
    end,
  },

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✗',
      [vim.diagnostic.severity.WARN] = '⚠',
      [vim.diagnostic.severity.HINT] = '➤',
      [vim.diagnostic.severity.INFO] = 'i',
    },
  },
}

-- vim.api.nvim_set_hl(0, 'Comment', { italic = true })

-- vim: ts=2 sts=2 sw=2 et
