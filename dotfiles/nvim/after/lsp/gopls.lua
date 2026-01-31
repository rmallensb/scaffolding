vim.lsp.config("gopls", {
	filetypes = { "go", "tmpl" },
	settings = {
		gopls = {
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
		},
		templateExtensions = { "html", "tmpl" },
	},
})
