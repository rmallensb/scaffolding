return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true })
        vim.notify("formated successfully", "info", {
          title = "Conform Finished",
        })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports", "gofmt" },
      json = { "jq" },
      sql = { "pg_format" },
      md = { "markdownfmt" },
      yaml = { "yamlfmt" },
      yml = { "yamlfmt" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype == "go" then
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "go")
        if ok and parser then
          local trees = parser:parse()
          for _, tree in ipairs(trees) do
            if tree:root():has_error() then
              return nil
            end
          end
        end
      end

      return {
        timeout_ms = 500,
        lsp_format = "fallback",
      }
    end,
    -- Customize formatters
    -- formatters = {
    -- 	shfmt = {
    -- 		prepend_args = { "-i", "2" },
    -- 	},
    -- },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
