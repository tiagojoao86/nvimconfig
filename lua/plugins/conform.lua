return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      xmlformatter = {
        command = "xmlformat",
        args = { "$FILENAME" },
      },
    },
    formatters_by_ft = {
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      less = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      handlebars = { "prettier" },
      xml = { "xmlformatter" },
    },
  },
}
