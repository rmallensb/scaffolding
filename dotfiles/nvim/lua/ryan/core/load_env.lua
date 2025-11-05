-- core/load_env.lua
local M = {}

function M.load_env_file(filepath)
  local file = io.open(filepath, "r")
  if not file then
    vim.notify("Failed to open .env file: " .. filepath, vim.log.levels.WARN)
    return
  end

  for line in file:lines() do
    local key, value = line:match("^([%w_]+)%s*=%s*(.+)$")
    if key and value then
      vim.fn.setenv(key, value)
    end
  end

  file:close()
end

return M
