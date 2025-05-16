return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer",       -- Buffer source for nvim-cmp
    "hrsh7th/cmp-path",         -- Path source for nvim-cmp
    "hrsh7th/cmp-cmdline",      -- Command-line source for nvim-cmp
    "saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
    "L3MON4D3/LuaSnip",         -- Snippet engine
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      -- sources for autocompletion
      sources = cmp.config.sources({
        -- Dont suggest Text from nvm_lsp
        {
          name = "nvim_lsp",
          entry_filter = function(entry, ctx)
            --return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
            local kind = cmp.lsp.CompletionItemKind[entry:get_kind()]
            if kind == "Text" then
              return false
            end
            return true
          end,
        },
        { name = "path" },    -- file system paths
        { name = "luasnip" }, -- snippets
        { name = "buffer" },  -- text within current buffer (e.g. local variables)
      }),

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },

      -- keybindings
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        -- ["<Tab>"] = cmp.mapping.select_next_item(),   -- next suggestion
        -- ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<Esc>"] = cmp.mapping.abort(),        -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),

      experimental = {
        ghost_text = true,
      }
    })

    -- For `/` (search)
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- For `:` (commands)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
