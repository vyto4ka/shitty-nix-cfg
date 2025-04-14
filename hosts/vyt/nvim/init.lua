-- init.lua для Neovim с LazyVim
-- При первом запуске lazy.nvim автоматически загрузит и установит плагины

vim.cmd([[packadd lazy.nvim]])
require("lazy").setup({
  spec = {
    { import = "lazyvim.plugins" }
  }
})
