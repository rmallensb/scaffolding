return {
  'numtostr/comment.nvim',
  config = function()
    require('Comment').setup()

    vim.keymap.set('v', '\\', '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<cr>', { noremap = true, silent = true })
  end
}
