return {
	"williamboman/mason.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- lazy load
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		-- "jay-babu/mason-null-ls.nvim", -- bridge between mason and null-ls
		"neovim/nvim-lspconfig", -- Core LSP configuration
		"hrsh7th/nvim-cmp", -- nvim-cmp to enhance blink cmp with docstrings and type definitions
		"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
		-- "saghen/blink.cmp",      -- For LSP completion capabilities (using blink)
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
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "gopls", "ts_ls", "yamlls", "tflint" }, -- Ensure these LSPs are installed
			automatic_installation = true,
			automatic_enable = false, -- disable auto-starting LSP servers other than what we define
			handlers = {}, -- prevent mason-lspconfig from auto-configuring LSPs
		})

		-- Loop through all installed servers and apply default config
		--
		-- Enable nvim-cmp capabilities for LSP
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()) -- enhance with cmp_nvim_lsp

		-- Define global LSP keybindings
		local on_attach = function(client, bufnr)
			-- Trigger a notification when the LSP attaches
			vim.notify(client.name .. " LSP loaded successfully", "info", {
				title = "LSP Attached",
			})

			local keymap = vim.keymap

			-- LSP keybindings
			keymap.set(
				"n",
				"gd",
				"<cmd>Telescope lsp_definitions<CR>",
				{ noremap = true, silent = true, buffer = bufnr, desc = "Go to declaration" }
			)
			keymap.set(
				"n",
				"gi",
				"<cmd>Telescope lsp_implementations<CR>",
				{ noremap = true, silent = true, buffer = bufnr, desc = "Go to implementation" }
			)

			-- Hover displays lsp information in a floating buffer
			keymap.set("n", "<leader>H", function()
				vim.lsp.buf.hover()
			end, { noremap = true, silent = true, buffer = bufnr, desc = "Display hover details" })

			-- diagnostics
			keymap.set(
				"n",
				"<leader>D",
				"<cmd>Telescope diagnostics bufnr=0<CR>",
				{ noremap = true, silent = true, buffer = bufnr, desc = "Show buffer diagnostics" }
			)
			-- vim.diagnostics is deprecated
			-- keymap.set("n", "[d", vim.diagnostic.goto_prev,
			--   { noremap = true, silent = true, buffer = bufnr, desc = "Go to previous diagnostic" })
			-- keymap.set("n", "]d", vim.diagnostic.goto_next,
			--   { noremap = true, silent = true, buffer = bufnr, desc = "Go to next diagnostic" })
		end

		local lspconfig = require("lspconfig")
		local servers = require("mason-lspconfig").get_installed_servers()

		for _, server in ipairs(servers) do
			local opts = {
				capabilities = capabilities,
				on_attach = on_attach,
			}

			if server == "lua_ls" then
				opts.settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "blink" },
							disable = { "missing-fields" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				}
			end

			if server == "gopls" then
				opts.filetypes = { "go", "tmpl" }
				opts.settings = {
					gopls = {
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
					},
					templateExtensions = { "html", "tmpl" },
				}
			end

			if server == "yamlls" then
				opts.settings = {
					yaml = {
						schemas = {
							["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml"] = "/*",
						},
					},
				}
			end

			lspconfig[server].setup(opts)
		end
	end,
}
