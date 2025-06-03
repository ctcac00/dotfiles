return {
  "folke/snacks.nvim",
  dependencies = { "yetone/avante.nvim" },
  ---@type snacks.Config
  opts = {
    picker = {
      -- your picker configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      layout = {
        -- preset = "default",
        preset = "ivy",
        -- preset = "vertical",
      },
    },
  },
}
