vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

local mason_bin = vim.fn.stdpath 'data' .. '/mason/bin'
vim.env.PATH = mason_bin .. ':' .. vim.env.PATH

require 'options'
require 'keymaps'
require 'lazy-bootstrap'
require 'lazy-plugins'
require 'misc'
