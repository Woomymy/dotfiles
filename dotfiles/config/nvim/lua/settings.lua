vim.g.mapleader = ","

-- Mouse
vim.o.mouse = "a"

vim.o.number = true
vim.o.linebreak = true
vim.o.ignorecase = true

-- Indent
vim.o.expandtab = true -- Spaces
vim.o.shiftwidth = 4
vim.o.tabstop = 4 -- 1 tab == 4 spaces
vim.o.smartindent = true -- autoindent new lines

-- Enforce spaces in makefiles
vim.cmd [[
    autocmd FileType make setlocal expandtab
]]

-- Use 2 spaces for YAML,CSS,JSON
vim.cmd [[
    autocmd FileType javascript,typescript,yaml,css,json setlocal shiftwidth=2 tabstop=2
]]

