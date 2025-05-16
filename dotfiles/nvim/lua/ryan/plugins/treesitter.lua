return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		---@diagnostic disable-next-line: missing-fields
		treesitter.setup({
			-- enable syntax highlighting
			-- A list of parser names, or "all"
			ensure_installed = { "go", "sql", "typescript", "lua", "graphql", "markdown", "yaml" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			--
			-- enable indentation
			indent = { enable = true },

			-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			diagnostics = { disable = { "missing-fields" } },

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,
			--
			-- incremental_selection = {
			--   enable = true,
			--   keymaps = {
			--     init_selection = "<C-space>",
			--     node_incremental = "<C-space>",
			--     scope_incremental = false,
			--     node_decremental = "<bs>",
			--   },
			-- },

			highlight = {
				-- `false` will disable the whole extension
				enable = true,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
