local M = {}

function M.is_css_file()
  local filetype = vim.bo.filetype

  if filetype == 'css' or filetype == 'sass' or filetype == 'scss' then
    return true
  end
end

function M.has_deno_json()
  local json_path = vim.fn.getcwd() .. '/deno.json'
  return vim.fn.filereadable(json_path) == 1
end

function M.has_package_json()
  local json_path = vim.fn.getcwd() .. '/package.json'
  return vim.fn.filereadable(json_path) == 1
end

function M.has_eslintrc()
  local allowed_rc_file_names = {
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    'eslint.config.js',
    'eslint.config.mjs',
  }

  for _, file in ipairs(allowed_rc_file_names) do
    local path = vim.fn.getcwd() .. '/' .. file
    if vim.fn.filereadable(path) == 1 then
      return true
    end
  end

  return nil
end

function M.has_stylelintrc()
  local allowed_rc_file_names = {
    '.stylelintrc',
    '.stylelintrc.json',
    '.stylelintrc.yaml',
    '.stylelintrc.yml',
    'stylelint.config.cjs',
    'stylelint.config.js',
    'stylelint.config.mjs',
  }

  for _, file in ipairs(allowed_rc_file_names) do
    local path = vim.fn.getcwd() .. '/' .. file
    if vim.fn.filereadable(path) == 1 then
      return true
    end
  end

  return nil
end

function M.has_prettierrc()
  local allowed_rc_file_names = {
    '.prettierrc',
    '.prettierrc.cjs',
    '.prettierrc.js',
    '.prettierrc.json',
    '.prettierrc.toml',
    '.prettierrc.yaml',
    '.prettierrc.yml',
    'package.json',
    'prettier.config.cjs',
    'prettier.config.js',
    'prettier.config.mjs',
  }

  for _, file in ipairs(allowed_rc_file_names) do
    local path = vim.fn.getcwd() .. '/' .. file
    if vim.fn.filereadable(path) == 1 then
      return true
    end
  end

  return nil
end

function M.print_table(tbl)
  for k, v in pairs(tbl) do
    print(k, v)
  end
end

function M.map(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc })
end

return M
