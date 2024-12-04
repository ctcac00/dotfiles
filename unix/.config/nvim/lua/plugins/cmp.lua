return {
  {
    "hrsh7th/nvimcmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
}
