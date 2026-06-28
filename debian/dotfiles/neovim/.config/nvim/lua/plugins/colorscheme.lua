return {
  -- set colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },

  -- https://github.com/rebelot/kanagawa.nvim
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- Or use `event = 'VeryLazy'` if you prefer
    ---@type KanagawaConfig
    opts = {
      -- Optional: Customize Kanagawa settings here if needed
      background = {
        dark = "wave",
        light = "lotus",
      },
      transparent = true,
      colors = {
        theme = {
          all = {
            ui = {
              -- remove the background of LineNr, {Sign,Fold}Column and friends
              bg_gutter = "none",
              float = {
                -- remove background color for floating windows
                bg = "none",
              },
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme

        local makeDiagnosticColor = function(color)
          local c = require("kanagawa.lib.color")
          return { fg = color, bg = c(color):blend(theme.ui.bg_dim, 0.95):to_hex() }
        end

        return {
          -- Transparent status bar
          StatusLine = { bg = "none" },
          StatusLineNC = { bg = "none" },

          -- Transparent floating windows
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Transparent completion windows
          Pmenu = { link = "NormalFloat" },
          PmenuExtra = { link = "Pmenu" },
          PmenuKind = { link = "Pmenu" },
          PmenuSbar = { bg = "none" },
          BlinkCmpMenu = { link = "Pmenu" },
          BlinkCmpMenuBorder = { link = "FloatBorder" },
          BlinkCmpDoc = { link = "NormalFloat" },
          BlinkCmpDocBorder = { link = "FloatBorder" },
          BlinkCmpSignatureHelp = { link = "NormalFloat" },
          BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          -- Tint background of diagnostic messages with their foreground color
          DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
          DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
          DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
          DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
        }
      end,
    },
  },
}
