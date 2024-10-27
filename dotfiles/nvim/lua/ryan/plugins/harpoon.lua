return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		keymap.set("n", "<leader>m", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		-- Go to buffer at harpoon index (offset 1)
		keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end)
		keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end)
		keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end)
		keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		keymap.set("n", "<leader>H", function()
			harpoon:list():prev()
		end)
		keymap.set("n", "<leader>L", function()
			harpoon:list():next()
		end)

		harpoon:extend({
			UI_CREATE = function(cx)
				keymap.set("n", "v", function()
					harpoon.ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr })

				keymap.set("n", "s", function()
					harpoon.ui:select_menu_item({ split = true })
				end, { buffer = cx.bufnr })

				keymap.set("n", "t", function()
					harpoon.ui:select_menu_item({ tabedit = true })
				end, { buffer = cx.bufnr })
			end,
		})
	end,
}
