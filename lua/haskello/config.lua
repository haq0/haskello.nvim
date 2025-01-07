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
        indentation = 2,
        column_limit = "none",
        function_arrows = "trailing",
        comma_style = "leading",
        import_export_style = "leading",
        indent_wheres = true,
        record_brace_space = true,
        newlines_between_decls = 1,
        haddock_style = "multi-line",
        haddock_style_module = "null",
        let_style = "auto",
        in_style = "right-align",
        single_constraint_parens = "always",
        single_deriving_parens = "always",
        unicode = "never",
        respectful = true,
        import_grouping = "legacy",
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

