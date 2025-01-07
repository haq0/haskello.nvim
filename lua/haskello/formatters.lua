local M = {}

local function bool_to_flag(value)
  return value and "true" or "false"
end

local arg_maps = {
  fourmolu = {
    mode = "--mode",
    indentation = "--indentation",
    column_limit = "--column-limit",
    function_arrows = "--function-arrows",
    comma_style = "--comma-style",
    import_export_style = "--import-export-style",
    indent_wheres = "--indent-wheres",
    record_brace_space = "--record-brace-space",
    newlines_between_decls = "--newlines-between-decls",
    haddock_style = "--haddock-style",
    haddock_style_module = "--haddock-style-module",
    let_style = "--let-style",
    in_style = "--in-style",
    single_constraint_parens = "--single-constraint-parens",
    single_deriving_parens = "--single-deriving-parens",
    unicode = "--unicode",
    respectful = "--respectful",
    import_grouping = "--import-grouping",
    sort_constraints = "--sort-constraints",
  },
  ormolu = {
    mode = "--mode",
    color = "--color",
    debug = "--debug",
    check_idempotence = "--check-idempotence",
    no_cabal = "--no-cabal",
    unsafe = "--unsafe"
  },
  brittany = {
    config_file = "--config-file",
    write_mode = "--write-mode",
    indent = "--indent",
    columns = "--columns",
    no_user_config = "--no-user-config"
  },
  stylish_haskell = {
    config = "--config",
    inplace = "--inplace",
    quiet = "--quiet"
  }
}

-- Format command builders for each formatter
local format_commands = {
  fourmolu = function(args, file)
    local cmd_args = M.build_args("fourmolu", args)
    table.insert(cmd_args, file)
    return cmd_args
  end,

  ormolu = function(args, file)
    local cmd_args = M.build_args("ormolu", args)
    if not vim.tbl_contains(cmd_args, "--mode") then
      table.insert(cmd_args, "--mode")
      table.insert(cmd_args, "inplace")
    end
    table.insert(cmd_args, file)
    return cmd_args
  end,

  brittany = function(args, file)
    local cmd_args = M.build_args("brittany", args)
    if not vim.tbl_contains(cmd_args, "--write-mode") then
      table.insert(cmd_args, "--write-mode")
      table.insert(cmd_args, "inplace")
    end
    table.insert(cmd_args, file)
    return cmd_args
  end,

  stylish_haskell = function(args, file)
    local cmd_args = M.build_args("stylish_haskell", args)
    if not vim.tbl_contains(cmd_args, "--inplace") then
      table.insert(cmd_args, "--inplace")
    end
    table.insert(cmd_args, file)
    return cmd_args
  end,

  hls = function(_, _)
    return {}  -- HLS uses LSP formatting, no command line args needed
  end
}

function M.build_args(formatter_name, args)
  local result = {}
  local arg_map = arg_maps[formatter_name]

  if not arg_map then
    return result
  end

  for key, value in pairs(args) do
    if arg_map[key] then
      if type(value) == "boolean" then
        table.insert(result, arg_map[key])
        table.insert(result, bool_to_flag(value))
      elseif type(value) == "number" or (type(value) == "string" and value ~= "") then
        table.insert(result, arg_map[key])
        table.insert(result, tostring(value))
      end
    end
  end
  return result
end

function M.get_format_command(formatter_name, args, file)
  local format_command = format_commands[formatter_name]
  if format_command then
    return format_command(args, file)
  end
  return {}
end

-- Validate formatter configuration
function M.validate_config(formatter_name, args)
  -- Add validation logic here if needed
  return true
end

return M

