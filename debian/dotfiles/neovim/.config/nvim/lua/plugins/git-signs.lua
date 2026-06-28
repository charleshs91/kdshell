return {
  "lewis6991/gitsigns.nvim",
  ---@type gitsigns.Options
  opts = {
    -- Enable current line blame by default
    current_line_blame = true,
    -- Optional: Further customize the appearance or behavior
    current_line_blame_opts = {
      virt_text = true, -- Show blame as virtual text
      virt_text_pos = "eol", -- Position the text at the end of the line
      delay = 500, -- Delay in milliseconds
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>", -- Customize the blame message format
  },
}
