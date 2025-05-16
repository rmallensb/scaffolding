return {
  "nvim-tree/nvim-tree.lua",
  lazy = false, -- Load eagerly
  -- dependencies = {
  --   "nvim-tree/nvim-web-devicons", -- Optional, for file icons
  -- },
  config = function()
    require("nvim-tree").setup({
      disable_netrw = true, -- Disable netrw for better performance
      hijack_netrw = true,
      view = {
        width = 35,    -- Width of the file tree
        side = "left", -- Position of the file tree
        -- mappings = {
        --   custom_only = true,                  -- Use custom keybindings only
        --   list = {
        --     { key = "o", action = "edit" },    -- Open file
        --     { key = "v", action = "vsplit" },  -- Open file in vertical split
        --     { key = "s", action = "hsplit" },  -- Open file in horizontal split
        --     { key = "p", action = "preview" }, -- Preview file
        --     { key = "R", action = "refresh" }, -- Refresh file tree
        --     { key = "q", action = "close" },   -- Close file tree
        --   },
        -- },
      },
      renderer = {
        -- change folder arrow icons
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true, -- Disable Git icons for better performance
          },
          glyphs = {
            folder = {
              -- arrow_closed = "", -- arrow when folder is closed
              -- arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      diagnostics = {
        enable = false, -- Disable diagnostics for faster rendering
      },
      update_focused_file = {
        enable = false, -- Highlight the current file in the tree
      },
      git = {
        enable = false,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },

      on_attach = function(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set("n", "T", api.tree.change_root_to_node, opts("Change Root"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))

        vim.keymap.set("n", "v", api.node.open.vertical, opts("Open Vertical"))
        vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open Horizontal"))
        vim.keymap.set("n", "x", api.node.navigate.parent_close, opts("Close Directory"))
      end,
    })
    --
    -- Keybindings for toggling Nvim-Tree
    vim.api.nvim_set_keymap("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    vim.api.nvim_set_keymap(                                                                                 -- toggle file explorer on current file
      "n",
      "<leader>ef",
      "<cmd>NvimTreeFindFileToggle<CR>",
      { desc = "Toggle file explorer on current file" }
    )
  end,
}
