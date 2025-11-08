vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

require("config.lazy")

vim.cmd("NvimTreeOpen")
vim.cmd([[
    autocmd BufEnter * ++nested if winnr('$') == 1 && &filetype == 'NvimTree' | quit | endif
]])
