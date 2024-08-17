local opt = vim.opt
----- Interesting Options -----

vim.cmd [[set undodir=~/.cache/vim/undodir]]
-- You have to turn this one on :)
opt.inccommand = "split"

vim.opt.inccommand = "split"
-- Best search settings :)
opt.smartcase = true
opt.ignorecase = true

----- Personal Preferences -----
opt.number = true
opt.relativenumber = true

opt.splitbelow = true
opt.splitright = true

opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

opt.listchars = {
  eol = "↲",
  tab = "|->",
  lead = " ",
  space = " ",
  trail = "•",
  extends = "→",
  precedes = "←",
  nbsp = "+",
}

opt.list = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.swapfile = false
opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true

opt.clipboard = "unnamedplus"

-- Don't have `o` add a comment
opt.formatoptions:remove "o"

opt.wrap = true
opt.linebreak = true
