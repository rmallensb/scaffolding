return {
	"williamboman/mason.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig", -- still useful: provides default per-server configs used by vim.lsp.config
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "~",
					package_uninstalled = "✗",
				},
			},
		})

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

		local servers = { "lua_ls", "gopls", "ts_ls", "yamlls", "tflint" }

		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_installation = true,
			automatic_enable = false, -- we explicitly enable below
			handlers = {}, -- don't auto-configure
		})

		-- Capabilities (nvim-cmp)
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		-- Apply defaults to ALL configs (including those provided by nvim-lspconfig)
		vim.lsp.config("*", { capabilities = capabilities })

		-- Your keymaps + notify on attach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("RyanLspAttach", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then
					return
				end

				vim.notify(client.name .. " LSP loaded successfully", vim.log.levels.INFO, {
					title = "LSP Attached",
				})

				local bufnr = args.buf
				local keymap = vim.keymap

				keymap.set("n", "gd", vim.lsp.buf.definition, {
					noremap = true,
					silent = true,
					buffer = bufnr,
					desc = "Go to definition",
				})
				keymap.set("n", "gi", vim.lsp.buf.implementation, {
					noremap = true,
					silent = true,
					buffer = bufnr,
					desc = "Go to implementation",
				})
				keymap.set("n", "<leader>H", vim.lsp.buf.hover, {
					noremap = true,
					silent = true,
					buffer = bufnr,
					desc = "Display hover details",
				})
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", {
					noremap = true,
					silent = true,
					buffer = bufnr,
					desc = "Show buffer diagnostics",
				})
			end,
		})

		-- Start only the servers you list
		vim.lsp.enable(servers)
	end,
}
