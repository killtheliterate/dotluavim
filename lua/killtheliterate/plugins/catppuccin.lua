return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    -- @NOTE: https://rrethy.github.io/book/colorscheme.html

    require('catppuccin').setup {
      show_end_of_buffer = true,
      dim_inactive = {
        enabled = true,
      },
    }

    local function set_colorscheme(file, name)
      vim.fn.writefile({ name }, file)
      vim.cmd('colorscheme ' .. name)

      vim.loop.spawn('kitten', {
        args = { 'themes', '--reload-in=all', name },
      }, nil)
    end

    local nvim_theme_file = vim.fn.expand '~/.config/nvim/current-theme'
    set_colorscheme(nvim_theme_file, vim.fn.readfile(nvim_theme_file)[1])

    vim.keymap.set('n', '<leader>T', function()
      local action_state = require 'telescope.actions.state'
      local actions = require 'telescope.actions'
      local colors = { 'Catppuccin-Frappe', 'Catppuccin-Latte' }
      local theme = require('telescope.themes').get_dropdown()

      require('telescope.pickers')
        .new(theme, {
          prompt = 'Change catppuccin Colorscheme',
          finder = require('telescope.finders').new_table { results = colors },
          sorter = require('telescope.config').values.generic_sorter(theme),
          attach_mappings = function(bufnr)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry().value

              actions.close(bufnr)

              set_colorscheme(nvim_theme_file, selection)
            end)
            return true
          end,
        })
        :find()
    end, { desc = 'Catppuccin: [T]heme' })
  end,
}
