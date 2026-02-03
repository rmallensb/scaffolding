return {
	"greggh/claude-code.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local claude = require("claude-code")
		local is_fullscreen = false

		local split_config = {
			window = {
				position = "botright",
				split_ratio = 0.25,
			},
		}

		local float_config = {
			window = {
				position = "float",
				float = {
					width = "95%",
					height = "95%",
					row = "center",
					col = "center",
					border = "rounded",
				},
			},
		}

		-- Start with split config
		claude.setup(split_config)

		-- Toggle between split and fullscreen float
		local function toggle_fullscreen()
			is_fullscreen = not is_fullscreen
			-- Close current window
			claude.toggle()
			-- Reconfigure
			claude.setup(is_fullscreen and float_config or split_config)
			-- Reopen with new config
			claude.toggle()
			-- Re-enter terminal mode after window settles
			vim.defer_fn(function()
				vim.cmd("startinsert")
			end, 50)
		end

		vim.keymap.set({ "n", "t" }, "<leader>cf", toggle_fullscreen, { desc = "Toggle Claude fullscreen" })

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
