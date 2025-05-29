-- local function augroup(name)
--   return vim.api.nvim_create_augroup('killtheliterate_' .. name, { clear = true })
-- end

vim.api.nvim_create_user_command('OpenInVSCode', function()
  local filepath = vim.fn.expand '%:p' -- ':p' expands to full path

  os.execute('code ' .. filepath)
end, { desc = 'Open the current file in VSCode' })

vim.api.nvim_create_user_command('OpenInCursor', function()
  local filepath = vim.fn.expand '%:p' -- ':p' expands to full path

  os.execute('cursor ' .. filepath)
end, { desc = 'Open the current file in Cursor' })

vim.api.nvim_create_user_command('OpenInWindsurf', function()
  local filepath = vim.fn.expand '%:p' -- ':p' expands to full path

  os.execute('windsurf ' .. filepath)
end, { desc = 'Open the current file in Cursor' })

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

-- vim.filetype.add {
--   pattern = {
--     ['.*'] = {
--       function(path, buf)
--         return vim.bo[buf].filetype ~= 'bigfile' and path and vim.fn.getfsize(path) > vim.g.bigfile_size and 'bigfile' or nil
--       end,
--     },
--   },
-- }
--
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   group = augroup 'bigfile',
--   pattern = 'bigfile',
--   callback = function(ev)
--     vim.b.minianimate_disable = true
--     vim.schedule(function()
--       vim.bo[ev.buf].syntax = vim.filetype.match { buf = ev.buf } or ''
--     end)
--   end,
-- })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en' -- You can set other languages if needed
  end,
})

-- Turn off spell in floating windows
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    if vim.api.nvim_win_get_config(0).relative ~= '' then
      vim.wo.spell = false
    end
  end,
})

if not vim.lsp._open_floating_preview_patched then
  local orig = vim.lsp.util.open_floating_preview

  rawset(vim.lsp.util, 'open_floating_preview', function(contents, syntax, opts)
    opts = opts or {}
    opts.wrap = true
    local bufnr, winid = orig(contents, syntax, opts)
    if winid then
      vim.wo[winid].spell = false
    end
    return bufnr, winid
  end)

  vim.lsp._open_floating_preview_patched = true
end
