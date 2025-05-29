return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      menu = {
        border = "rounded",
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name", gap = 1 },
          },
        },
      },
      documentation = {
        window = {
          border = "rounded",
        },
      },
    },
    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      compat = {
        "avante_commands",
        "avante_mentions",
        "avante_files",
      },
    },
  },
}
