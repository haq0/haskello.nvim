local M = {}

local arg_maps = {
  ormolu = {
    mode = "--mode",
    check_idempotence = "--check-idempotence",
    no_cabal = "--no-cabal",
    unsafe = "--unsafe",
    debug = "--debug",
    color = "--color",
    module_name = "--module-name",
    ghc_opt = "--ghc-opt",
    file_extensions = "--file-extensions"
  },
  fourmolu = {
    mode = "--mode",
    check_idempotence = "--check-idempotence",
    no_cabal = "--no-cabal",
    format_imports = "--format-imports",
    indentation = "--indentation",
    column_limit = "--column-limit",
    respecting_pragma = "--respecting-pragma",
    newlines_between_decls = "--newlines-between-decls",
    haddock_style = "--haddock-style",
    indentation_policy = "--indentation-policy",
    record_brace_space = "--record-brace-space",
    comma_style = "--comma-style",
    ghc_opt = "--ghc-opt"
  },
  hindent = {
    indent_size = "--indent-size",
    line_length = "--line-length",
    sort_imports = "--sort-imports",
    force_trailing_newline = "--force-trailing-newline",
    preserve_line_breaks = "--preserve-line-breaks",
    preserve_vertical_space = "--preserve-vertical-space",
    flexible_oneline = "--flexible-oneline"
  }
}

function M.build_args(formatter_name, args)
  local result = {}
  local arg_map = arg_maps[formatter_name]

  for key, value in pairs(args) do
    if type(value) == "boolean" and value then
      table.insert(result, arg_map[key])
    elseif type(value) == "number" or (type(value) == "string" and value ~= "") then
      table.insert(result, arg_map[key])
      table.insert(result, tostring(value))
    elseif type(value) == "table" then
      for _, v in ipairs(value) do
        table.insert(result, arg_map[key])
        table.insert(result, tostring(v))
      end
    end
  end
  return result
end

return M

