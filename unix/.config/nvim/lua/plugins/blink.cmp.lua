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
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      documentation = {
        window = {
          border = "rounded",
        },
      },
    },
  },
}
