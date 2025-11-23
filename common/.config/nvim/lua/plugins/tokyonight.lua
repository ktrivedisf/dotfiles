local Util = require("tokyonight.util")

require("tokyonight").setup({
  dim_inactive = true,
  on_highlights = function(hl, colors)
    hl["@variable.parameter"] = { fg = colors.orange, italic = true }
    -- Make sure all keyword variants are italic because settings `keywords = { italic = true }`
    -- in `styles` section below is not working
    hl["@keyword"] = { italic = true, fg = colors.purple }
    hl["@keyword.conditional"] = { italic = true, fg = colors.purple }
    hl["@keyword.repeat"] = { italic = true, fg = colors.purple }
    hl["@keyword.return"] = { italic = true, fg = colors.purple }
    hl["@keyword.operator"] = { italic = true, fg = colors.purple }
    hl["@keyword.import"] = { italic = true, fg = colors.purple }
    hl["@keyword.export"] = { italic = true, fg = colors.purple }
    hl["@keyword.function"] = { italic = true, fg = colors.purple }
    hl["@keyword.modifier"] = { italic = true, fg = colors.purple }
    hl["@keyword.type"] = { italic = true, fg = colors.purple }
    -- barbar.nvim support (https://github.com/folke/tokyonight.nvim/pull/727)
    hl.BufferAlternate = { bg = colors.none, fg = colors.fg }
    hl.BufferAlternateADDED = { bg = colors.none, fg = colors.git.add }
    hl.BufferAlternateCHANGED = { bg = colors.none, fg = colors.git.change }
    hl.BufferAlternateDELETED = { bg = colors.none, fg = colors.git.delete }
    hl.BufferAlternateERROR = { bg = colors.none, fg = colors.error }
    hl.BufferAlternateHINT = { bg = colors.none, fg = colors.hint }
    hl.BufferAlternateINFO = { bg = colors.none, fg = colors.info }
    hl.BufferAlternateIndex = { bg = colors.none, fg = colors.info }
    hl.BufferAlternateMod = { bg = colors.none, fg = colors.warning }
    hl.BufferAlternateSign = { bg = colors.none, fg = colors.info }
    hl.BufferAlternateTarget = { bg = colors.none, fg = colors.red }
    hl.BufferAlternateWARN = { bg = colors.none, fg = colors.warning }
    hl.BufferCurrent = { bg = colors.none, fg = colors.fg }
    hl.BufferCurrentADDED = { bg = colors.none, fg = colors.git.add }
    hl.BufferCurrentCHANGED = { bg = colors.none, fg = colors.git.change }
    hl.BufferCurrentDELETED = { bg = colors.none, fg = colors.git.delete }
    hl.BufferCurrentERROR = { bg = colors.none, fg = colors.error }
    hl.BufferCurrentHINT = { bg = colors.none, fg = colors.hint }
    hl.BufferCurrentINFO = { bg = colors.none, fg = colors.info }
    hl.BufferCurrentIndex = { bg = colors.none, fg = colors.info }
    hl.BufferCurrentMod = { bg = colors.none, fg = colors.warning }
    hl.BufferCurrentSign = { bg = colors.none, fg = colors.bg }
    hl.BufferCurrentTarget = { bg = colors.none, fg = colors.red }
    hl.BufferCurrentWARN = { bg = colors.none, fg = colors.warning }
    hl.BufferInactive = { bg = colors.none, fg = Util.blend_bg(colors.dark5, 0.8) }
    hl.BufferInactiveADDED = { bg = colors.none, fg = Util.blend_bg(colors.git.add, 0.8) }
    hl.BufferInactiveCHANGED = {
      bg = colors.none,
      fg = Util.blend_bg(colors.git.change, 0.8),
    }
    hl.BufferInactiveDELETED = {
      bg = colors.none,
      fg = Util.blend_bg(colors.git.delete, 0.8),
    }
    hl.BufferInactiveERROR = { bg = colors.none, fg = Util.blend_bg(colors.error, 0.8) }
    hl.BufferInactiveHINT = { bg = colors.none, fg = Util.blend_bg(colors.hint, 0.8) }
    hl.BufferInactiveINFO = { bg = colors.none, fg = Util.blend_bg(colors.info, 0.8) }
    hl.BufferInactiveIndex = { bg = colors.none, fg = colors.dark5 }
    hl.BufferInactiveMod = { bg = colors.none, fg = Util.blend_bg(colors.warning, 0.8) }
    hl.BufferInactiveSign = { bg = colors.none, fg = colors.bg }
    hl.BufferInactiveTarget = { bg = colors.none, fg = colors.red }
    hl.BufferInactiveWARN = { bg = colors.none, fg = Util.blend_bg(colors.warning, 0.8) }
    hl.BufferOffset = { bg = colors.none, fg = colors.dark5 }
    hl.BufferTabpageFill = { bg = colors.none, fg = colors.dark5 }
    hl.BufferTabpages = { bg = colors.none, fg = colors.none }
    hl.BufferVisible = { bg = colors.none, fg = colors.fg }
    hl.BufferVisibleADDED = { bg = colors.none, fg = colors.git.add }
    hl.BufferVisibleCHANGED = { bg = colors.none, fg = colors.git.change }
    hl.BufferVisibleDELETED = { bg = colors.none, fg = colors.git.delete }
    hl.BufferVisibleERROR = { bg = colors.none, fg = colors.error }
    hl.BufferVisibleHINT = { bg = colors.none, fg = colors.hint }
    hl.BufferVisibleINFO = { bg = colors.none, fg = colors.info }
    hl.BufferVisibleIndex = { bg = colors.none, fg = colors.info }
    hl.BufferVisibleMod = { bg = colors.none, fg = colors.warning }
    hl.BufferVisibleSign = { bg = colors.none, fg = colors.info }
    hl.BufferVisibleTarget = { bg = colors.none, fg = colors.red }
    hl.BufferVisibleWARN = { bg = colors.none, fg = colors.warning }
    -- Virtual text (diagnostics)
    hl.DiagnosticVirtualTextError = { fg = colors.error, italic = true }
    hl.DiagnosticVirtualTextHint = { fg = colors.hint, italic = true }
    hl.DiagnosticVirtualTextInfo = { fg = colors.info, italic = true }
    hl.DiagnosticVirtualTextWarn = { fg = colors.warning, italic = true }
    -- LSP inlay hints
    hl.LspInlayHint = { fg = colors.comment, italic = true }
    -- Support transparent bufferline (https://github.com/folke/tokyonight.nvim/pull/677)
    hl.TabLineFill = { bg = colors.none }
  end,
  plugins = {
    auto = true,
  },
  style = "storm",
  styles = {
    comments = { italic = true },
    floats = "transparent",
    keywords = { italic = true },
    sidebars = "transparent",
  },
  transparent = true,
})

vim.cmd.colorscheme("tokyonight")
