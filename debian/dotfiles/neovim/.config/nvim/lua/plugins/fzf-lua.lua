return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts, {
      fzf_opts = {
        -- Global history file (used by all pickers)
        -- Or specify per-picker under grep = { ... }
        ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
      },
      files = {
        -- Optional: Use a specific history file just for files
        fzf_opts = {
          ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history",
        },
      },
      grep = {
        -- Optional: Use a specific history file just for grep
        fzf_opts = {
          ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
        },
      },
      keymap = {
        fzf = {
          -- Keybinds to navigate history within the fzf window
          ["ctrl-p"] = "prev-history",
          ["ctrl-n"] = "next-history",
        },
      },
    })
  end,
}
