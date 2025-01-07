local config = require("haskello.config")
local formatters = require("haskello.formatters")

local M = {}

function M.format()
  local cfg = config.options
  local fmt = cfg.formatters[cfg.formatter]
  if not fmt then
    vim.notify(string.format("Invalid formatter: %s", cfg.formatter), vim.log.levels.ERROR)
    return
  end

  local filename = vim.api.nvim_buf_get_name(0)
  local args = formatters.build_args(cfg.formatter, fmt.args)
  table.insert(args, filename)

  local cmd = {fmt.cmd}
  vim.list_extend(cmd, args)

  local output = vim.fn.system(cmd)

  if vim.v.shell_error == 0 then
    vim.cmd("edit!")
  else
    vim.notify(string.format("Formatting failed:\n%s", output), vim.log.levels.ERROR)
  end
end

function M.set_formatter(formatter_name)
  if config.options.formatters[formatter_name] then
    config.options.formatter = formatter_name
    vim.notify(string.format("Switched to %s", formatter_name), vim.log.levels.INFO)
  else
    vim.notify(string.format("Invalid formatter: %s", formatter_name), vim.log.levels.ERROR)
  end
end

function M.setup(opts)
  config.setup(opts)

  vim.api.nvim_create_user_command("Haskello", M.format, {})
  vim.api.nvim_create_user_command("HaskelloFormatter", function(cmd_opts)
    M.set_formatter(cmd_opts.args)
  end, {
    nargs = 1,
    complete = function()
      return {"ormolu", "fourmolu", "hindent"}
    end
  })

  if config.options.format_on_save then
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.hs",
      callback = M.format
    })
  end
end

return M

