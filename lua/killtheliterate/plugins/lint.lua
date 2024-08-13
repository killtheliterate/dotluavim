return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft['javascript'] = { 'eslint_d' }
      lint.linters_by_ft['javascriptreact'] = { 'eslint_d' }
      lint.linters_by_ft['typescript'] = { 'eslint_d' }
      lint.linters_by_ft['typescriptreact'] = { 'eslint_d' }
      lint.linters_by_ft['python'] = { 'pylint' }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set('n', '<leader>l', function()
        lint.try_lint()
      end, { desc = '[L]int buffer' })
    end,
  },
}
