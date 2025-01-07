local api = vim.api
local formatters = require('haskello.formatters')
local config = require('haskello.config')

local M = {}

local function format_async(formatter_name, args, bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  local filename = api.nvim_buf_get_name(bufnr)

  local cmd_args = formatters.get_format_command(formatter_name, args, filename)
  if vim.tbl_isempty(cmd_args) then return end

  local cmd = args.cmd or formatter_name

  vim.fn.jobstart({cmd, unpack(cmd_args)}, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        local win = api.nvim_get_current_win()
        local cursor = api.nvim_win_get_cursor(win)
        vim.cmd('checktime')
        api.nvim_win_set_cursor(win, cursor)
      else
        vim.notify("Formatting failed", vim.log.levels.ERROR)
      end
    end,
  })
end

function M.format()
  local opts = config.options
  local formatter = opts.formatters[opts.formatter]
  if not formatter then
    vim.notify("No formatter configured", vim.log.levels.ERROR)
    return
  end

  format_async(opts.formatter, formatter.args)
end

function M.setup(opts)
  config.setup(opts)

  if config.options.format_on_save then
    local group = api.nvim_create_augroup("Haskello", { clear = true })
    api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.hs",
      group = group,
      callback = M.format
    })
  end
end

return M

