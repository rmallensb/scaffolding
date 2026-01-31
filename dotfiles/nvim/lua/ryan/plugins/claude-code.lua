return {
	"greggh/claude-code.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("claude-code").setup()

		-- Send visual selection to Claude Code
		local function send_to_claude()
			-- Yank selection to z register (preserves user's clipboard)
			vim.cmd('normal! "zy')
			local selection = vim.fn.getreg("z")

			local filetype = vim.bo.filetype
			local filename = vim.fn.expand("%:t")

			-- Format with code fence
			local text = string.format("```%s\n# %s\n%s\n```\n", filetype, filename, selection)

			-- Copy to clipboard
			vim.fn.setreg("+", text)

			-- Open Claude Code
			require("claude-code").toggle()

			-- Notify user
			vim.defer_fn(function()
				vim.notify("Code copied - paste with Ctrl+Shift+V and add your prompt", vim.log.levels.INFO)
			end, 100)
		end

		vim.keymap.set("v", "<leader>cs", send_to_claude, { desc = "Send selection to Claude" })
	end,
}
