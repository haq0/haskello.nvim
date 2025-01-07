local M = {}

function M.check()
  vim.health.start("haskello.nvim")

  local formatters = {"ormolu", "fourmolu", "hindent"}
  for _, fmt in ipairs(formatters) do
    if vim.fn.executable(fmt) == 1 then
      vim.health.ok(string.format("%s: executable found", fmt))
    else
      vim.health.warn(string.format("%s: executable not found", fmt))
    end
  end
end

return M

