-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps --

-- source init.lua
keymap.set("n", "<leader>so", ":source $MYVIMRC<CR>", { desc = "Source init.lua" })

-- use jk to exit insert mode
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- When in visual mode J and K move highlighted block up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
--keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
--keymap.set("n", "<leader>s", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>o", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height


keymap.set("n", "<leader>h", "<C-w>h", { desc = "Go to left window" })                          -- split window vertically
keymap.set("n", "<leader>j", "<C-w>j", { desc = "Go to lower window" })                         -- split window vertically
keymap.set("n", "<leader>k", "<C-w>k", { desc = "Go to upper window" })                         -- split window vertically
keymap.set("n", "<leader>l", "<C-w>l", { desc = "Go to right window" })                         -- split window vertically

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- replace visual selection
local function search_replace()
  -- save the current register value
  local saved_reg = vim.fn.getreg('"')

  -- yank the current visual selection
  vim.cmd("normal! vgvy")

  -- get the yanked text and escape special characters
  local pattern = vim.fn.escape(vim.fn.getreg('"'), "\\/.*'$^~[]")
  pattern = pattern:gsub("\n$", "")

  -- feed `:%s/<pattern>/` to the (vim) command line
  -- note that this "hangs" and waits for user input to complete the replacement
  vim.fn.feedkeys(":%s/" .. pattern .. "/", "n")

  -- restore the original register value
  vim.fn.setreg('"', saved_reg)
end

keymap.set("v", "<leader>r", function()
  search_replace()
end, { noremap = true, silent = true })

-- toppair/peek.nvim
-- markdown previews
local function toggle_peek()
  local peek = require("peek")
  local peek_open = peek.is_open()
  if peek_open then
    peek.close()
  else
    peek.open()
  end
end

keymap.set("n", "<leader>p", function()
  toggle_peek()
end, { noremap = true, silent = true })
