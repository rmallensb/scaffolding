-- Simple surround helper for visual mode
-- Select text, press <leader>( to wrap in (), etc.

local mappings = {
	{ "(", "()" },
	{ ")", "()" },
	{ "{", "{}" },
	{ "}", "{}" },
	{ "[", "[]" },
	{ "]", "[]" },
	{ '"', '""' },
	{ "'", "''" },
	{ "`", "``" },
	{ "<", "<>" },
	{ ">", "<>" },
}

for _, pair in ipairs(mappings) do
	local key = pair[1]
	local open = pair[2]:sub(1, 1)
	local close = pair[2]:sub(2, 2)

	vim.keymap.set("v", "<leader>" .. key, '"zc' .. open .. close .. '<Esc>"zP', {
		desc = "Surround with " .. pair[2],
	})
end

return {}
