return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.options.section_separators = ""
    opts.options.component_separators = ""

    local theme = vim.deepcopy(require("lualine.themes.kanagawa"))
    for _, mode in pairs(theme) do
      if mode.b then
        mode.b.bg = "none"
      end

      if mode.c then
        mode.c.bg = "none"
      end
    end

    opts.options.theme = theme

    opts.sections.lualine_c[4] = {
      "filename",
      path = 3,
    }
  end,
}
