local HOME = os.getenv("HOME")
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", HOME .. "/.markdownlint-cli2.yaml", "--" },
      },
      golangcilint = {
        -- This function finds the nearest go.mod to the current file
        cwd = function()
          local root = vim.fs.find({ "go.mod" }, { upward = true, path = vim.fn.expand("%:p:h") })[1]
          if root then
            return vim.fs.dirname(root)
          end
          return vim.fn.getcwd()
        end,
        args = {
          "run",
          "--out-format",
          "json",
          "--show-stats=false",
          "--print-issued-lines=false",
          "--print-linter-name=false",
        },
      },
    },
  },
}
