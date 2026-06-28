-- https://github.com/folke/snacks.nvim
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      layout = {
        cycle = false,
      },
      hidden = true,
      ignored = true,
      sources = {
        explorer = {
          auto_close = true,
          cycle = true,
          layout = {
            preview = "main",
          },
        },
        files = {
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
