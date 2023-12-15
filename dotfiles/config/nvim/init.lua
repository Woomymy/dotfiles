-- Nvim config file
require('plugins') -- Load packer.nvim
require('settings') -- Load vim settings

for _, plugin in ipairs({"autopairs", "lualine",  "ayu", "alpha", "lsp", "nvim-tree", "trouble"}) do
    require("plugins/" .. plugin) -- Load all plugins
end
