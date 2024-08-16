local function has_deno_json()
  local deno_json_path = vim.fn.getcwd() .. '/deno.json'
  return vim.fn.filereadable(deno_json_path) == 1
end

return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft['html'] = { 'htmlhint' }
      lint.linters_by_ft['javascript'] = { 'eslint_d' }
      lint.linters_by_ft['javascriptreact'] = { 'eslint_d' }
      lint.linters_by_ft['python'] = { 'pylint' }
      lint.linters_by_ft['typescript'] = { 'eslint_d' }
      lint.linters_by_ft['typescriptreact'] = { 'eslint_d' }

      -- Disable linters if it's a deno project
      if has_deno_json() then
        lint.linters_by_ft = {}
      end

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
