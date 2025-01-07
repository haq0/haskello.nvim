local M = {}

M.defaults = {
  formatter = "ormolu",
  format_on_save = true,
  formatters = {
    ormolu = {
      cmd = "ormolu",
      args = {
        mode = "inplace",
        check_idempotence = false,
        no_cabal = false,
        unsafe = false,
        debug = false,
        color = false,
        module_name = nil,
        ghc_opt = {},
        file_extensions = {},
      }
    },
    fourmolu = {
      cmd = "fourmolu",
      args = {
        mode = "inplace",
        check_idempotence = false,
        format_imports = true,
        indentation = 4,
        column_limit = 80,
        respecting_pragma = true,
        newlines_between_decls = 1,
        haddock_style = "multi-line",
        record_brace_space = true,
        comma_style = "leading",
      }
    },
    hindent = {
      cmd = "hindent",
      args = {
        indent_size = 2,
        line_length = 80,
        sort_imports = false,
        force_trailing_newline = true,
        preserve_line_breaks = false,
        preserve_vertical_space = false,
        flexible_oneline = false,
      }
    }
  }
}

M.options = {}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M

