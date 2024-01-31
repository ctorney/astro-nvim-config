return {
  "stevearc/aerial.nvim",
  config = function()
    require("aerial").setup {
      -- Enumerate all headings and calculate the optimal foldlevel, 
      -- as an alternative of `foldmethod=expr` and `foldexpr=aerial#foldexpr()`.
      enumerate = false,
      -- An array of lsp clients to exclude from the headings 
      -- calculation (e.g. {"efm", ...})
      lsp_blacklist = {},
      open_automatic = true,
      context_patterns = {
    "class",
    "return",
    "function",
        "section",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
  },
    }
  end,
}
