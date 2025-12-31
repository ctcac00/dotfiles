return {
  {
    "leoluz/nvim-dap-go",
    opts = {
      -- dap_configurations: can be used to add/override configurations
      dap_configurations = {
        {
          type = "go",
          name = "Debug Package (Workspace)",
          request = "launch",
          program = "./${relativeFileDirname}", -- Points to the package of the current file
        },
      },
      -- delve configurations
      delve = {
        -- the path to the executable dlv
        path = "dlv",
        -- initialize with a build flag to handle workspace issues
        build_flags = "-gcflags='all=-N -l'",
      },
    },
  },
}
