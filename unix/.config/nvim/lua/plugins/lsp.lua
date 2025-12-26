return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {
          settings = {
            ["nil"] = {
              formatting = {
                command = { "alejandra" },
              },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              experimentalWorkspaceModule = true,
            },
          },
        },
      },
    },
  },
}
