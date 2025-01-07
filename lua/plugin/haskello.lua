if vim.fn.has("nvim-0.7.0") == 0 then
  vim.api.nvim_err_writeln("haskello requires at least nvim-0.7.0")
  return
end

if vim.g.loaded_haskello then
  return
end

vim.g.loaded_haskello = true

