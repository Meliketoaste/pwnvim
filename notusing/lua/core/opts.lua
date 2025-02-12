local opt = vim.opt
local g = vim.g
local opts = {}

opts.initial = function()
  g.mapleader = " "
  opt.laststatus = 0
  opt.clipboard = "unnamedplus"
  opt.termguicolors = true
  opt.fillchars:append { eob = " " }
  opt.shortmess:append "aIF"
  opt.cursorline = true
  opt.cursorlineopt = "number"
  opt.ruler = true
  opt.number = true
  opt.relativenumber = true
  opt.breakindent = true
  opt.linebreak = true
  opt.expandtab = true
  opt.swapfile = false
  opt.undofile = true
  opt.cmdheight = 0
end

opts.final = function()
  opt.completeopt = { "menuone", "noselect", "noinsert" }
  opt.wildmenu = true
  opt.pumheight = 20
  opt.ignorecase = true
  opt.smartcase = true
  opt.timeout = false
  opt.updatetime = 400
  opt.confirm = false
  opt.equalalways = false
  opt.splitbelow = true
  opt.splitright = true
  opt.scrolloff = 2
  opt.sidescrolloff = 2
  local statusline_ascii = ""
  opt.statusline = "%#Normal#" .. statusline_ascii .. "%="
end

--- load shada after ui-enter
local shada = vim.o.shada
vim.o.shada = ""
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.o.shada = shada
    pcall(vim.cmd.rshada, { bang = true })
  end,
})

vim.diagnostic.config {
  virtual_text = {
    prefix = "",
    suffix = "",
    format = function(diagnostic)
      return "󰍡 " .. diagnostic.message .. " "
    end,
  },
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = "󱐮",
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.INFO] = "◉",
      [vim.diagnostic.severity.WARN] = "",
    },
  },
}

return opts
