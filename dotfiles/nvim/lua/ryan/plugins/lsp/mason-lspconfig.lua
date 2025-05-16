return {
  "williamboman/mason.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- lazy load
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    -- "jay-babu/mason-null-ls.nvim", -- bridge between mason and null-ls
    "neovim/nvim-lspconfig", -- Core LSP configuration
    "hrsh7th/nvim-cmp",      -- nvim-cmp to enhance blink cmp with docstrings and type definitions
    -- "saghen/blink.cmp",      -- For LSP completion capabilities (using blink)
    "hrsh7th/cmp-nvim-lsp",  -- LSP source for nvim-cmp
  },
  config = function()
    -- Initialize Mason
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "~",
          package_uninstalled = "✗",
        },
      },
    })

    -- -- Initialize mason-null-ls
    -- -- This is to support golangci-lint
    -- -- (my setup is broken right and just forks off a bunch of golangci-lint processes...)
    -- require("mason-null-ls").setup({
    --   ensure_installed = { "golangci-lint" },
    --   automatic_installation = true,
    -- })

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Initialize Mason-LSPConfig
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "gopls", "ts_ls", "yamlls", "tflint" }, -- Ensure these LSPs are installed
      automatic_installation = true
    })

    -- Define global LSP keybindings
    local on_attach = function(client, bufnr)
      -- Chat GPT example
      --
      -- local opts = { noremap = true, silent = true, buffer = bufnr }
      -- local keymap = vim.api.nvim_buf_set_keymap

      -- LSP-specific keybindings
      -- keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      -- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
      -- keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementations()<CR>", opts)
      -- keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      -- keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      -- keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      -- keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
      -- keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

      -- Trigger a notification when the LSP attaches
      vim.notify(client.name .. " LSP loaded successfully", "info", {
        title = "LSP Attached",
      })

      local opts = { noremap = true, silent = true, buffer = bufnr }
      local keymap = vim.keymap

      -- LSP keybindings
      opts.desc = "Go to declaration"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      opts.desc = "Go to implementation"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      -- Hover displays lsp information in a floating buffer
      opts.desc = "Display hover details"
      keymap.set("n", "<leader>H", function() vim.lsp.buf.hover() end, opts)

      -- diagnostics
      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end


    -- Enable nvim-cmp capabilities for LSP
    local capabilities = require("cmp_nvim_lsp").default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ) -- enhance with cmp_nvim_lsp

    -- Setup LSP handlers with Mason-LSPConfig
    require("mason-lspconfig").setup_handlers({
      -- Default handler for all servers
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,

      -- Custom handler for lua_ls
      ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            Lua = {
              diagnostics = {
                -- Suppress undefined global diagnostics
                -- e.g. "undefined global 'vim'"
                globals = { "vim", "blink" },
                -- Disable specific diagnostic warnings
                disable = { "missing-fields" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true), -- Include runtime files
                checkThirdParty = false,
              },
              telemetry = { enable = false }, -- Disable telemetry
            },
          },
        })
      end,

      -- Custom handler for gopls
      ["gopls"] = function()
        require("lspconfig").gopls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          filetypes = { "go", "tmpl" },
          settings = {
            gopls = {
              usePlaceholders = true,    -- Add placeholders for function parameters
              completeUnimported = true, -- Suggest imports for packages
              staticcheck = true,        -- Enable Staticcheck diagnostics
            },
            templateExtensions = {
              "html",
              "tmpl"
            },
          },
        })
      end,

      -- Custom handler for yamlls
      ["yamlls"] = function()
        require('lspconfig').gopls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            yaml = {
              schemas = {
                ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml"] = "/*"
              }
            },
          },
        })
      end,

    })
  end,
}
