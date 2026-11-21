return {
  'folke/zen-mode.nvim',
  opts = {
    plugins = {
      tmux = { enabled = true }, -- disables the tmux statusline
      todo = { enabled = true }, -- if set to "true", todo-comments.nvim highlights will be disabled
      kitty = {
        enabled = false,
        font = '+4', -- font size increment
      },
    },
  },
}
