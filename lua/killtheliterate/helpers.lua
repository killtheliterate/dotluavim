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
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc',
    'eslint.config.js',
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
    'stylelint.config.js',
    'stylelint.config.cjs',
    '.stylelintrc',
    '.stylelintrc.json',
    '.stylelintrc.yaml',
    '.stylelintrc.yml',
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
    '.prettierrc.json',
    '.prettierrc.yaml',
    '.prettierrc.yml',
    '.prettierrc.js',
    '.prettierrc.cjs',
    'prettier.config.js',
    'prettier.config.cjs',
    '.prettierrc.toml',
    'package.json',
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
