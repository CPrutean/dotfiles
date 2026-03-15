return {
  "mfussenegger/nvim-lint",
  -- LazyVim allows you to configure nvim-lint using 'opts'
  opts = {
    -- 1. Register the linter for Java
    linters_by_ft = {
      java = { "checkstyle" },
    },

    -- 2. Customize the linter args (Crucial for Checkstyle!)
    linters = {
      checkstyle = {
        -- This overrides the default args to point to your specific config file
        args = {
          "-c",
          -- CHANGE THIS PATH below to match where you put your xml file
          vim.fn.expand("~/.config/nvim/google_checks.xml"),
        },
      },
    },
  },
}
