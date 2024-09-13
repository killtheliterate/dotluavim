return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup {}

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { desc = 'Harpoon: ' .. desc })
    end

    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    map('<leader>jh', function()
      toggle_telescope(harpoon:list())
    end, 'Open telescope picker')

    map('<leader>jj', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, 'Open picker')

    map('<leader>ja', function()
      harpoon:list():add()
    end, 'Add')

    map('<leader>jq', function()
      harpoon:list():select(1)
    end, 'Select 1')

    map('<leader>jw', function()
      harpoon:list():select(2)
    end, 'Select 2')

    map('<leader>je', function()
      harpoon:list():select(3)
    end, 'Select 3')

    map('<leader>jr', function()
      harpoon:list():select(4)
    end, 'Select 4')

    map('<leader>jp', function()
      harpoon:list():prev()
    end, 'Previous')

    map('<leader>jn', function()
      harpoon:list():next()
    end, 'Next')
  end,
}
