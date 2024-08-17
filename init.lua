-- ┏┓     ┓┏•
-- ┃┃┓┏┏┏┓┃┃┓┏┳┓
-- ┣┛┗┻┛┛┗┗┛┗┛┗┗
-- Neo(vim) the less is more
--               @pwnwriter/pwnvim

if vim.loader then
  vim.loader.enable()
end

local lazy_path = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazy_path) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim",
    "--branch=stable",
    lazy_path,
  }
end

vim.g.mapleader = " "

vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({ import = "custom/plugins" }, {
  change_detection = {
    notify = false,
  },
})
