return {
  'szw/vim-maximizer',
  config = function()
    -- Optionally set up a keybinding for toggling the maximizer
    vim.api.nvim_set_keymap('n', '<leader>z', ':MaximizerToggle<CR>', { noremap = true, silent = true })
  end
}
