return {
  --'arcticicestudio/nord-vim',
  'shaunsingh/nord.nvim',
  config = function()
    vim.cmd("colorscheme nord") -- Set the color scheme to Nord
  end
}
-- return {
--   "Vallen217/eidolon.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd [[colorscheme eidolon]]
--     vim.api.nvim_set_hl(0, "Visual", { bg = "#262754" })
--   end
-- }
