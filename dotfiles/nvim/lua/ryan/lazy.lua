local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable", -- latest stable release
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "ryan.plugins" },
  { import = "ryan.plugins.lsp" },
  -- small-config plugins that don't need a dedicated file.
  {
    -- harpoon lets you set "marks" to quickly bounce between buffers
    "ThePrimeagen/harpoon",
    event = { "VeryLazy" },
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- {
  --   -- auto add closing pair for ", (, [, {, etc
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   config = true,
  -- },
  {
    -- markdown preview
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  {
    -- simpler lua_ls setup
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = { "neovim/nvim-lspconfig" },
  },
}, {
  -- automatically check for plugin updates
  checker = { enabled = true },
  -- change_detection = {
  --   notify = false,
  -- },
})
