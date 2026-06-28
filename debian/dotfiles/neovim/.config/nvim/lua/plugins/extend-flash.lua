if not vim.g.vscode then
  -- change the highlight color of the label
  vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#5A0E24", bold = true })
end

-- https://github.com/folke/flash.nvim
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  vscode = true,
  opts = {
    modes = {
      char = {
        jump_labels = true,
      },
      search = {
        enabled = true,
      },
    },
  },
}
