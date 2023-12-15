-- Thx @Keyboard-Slayer
require("lualine").setup{
    options = {
        icons_enabled = true,
        theme = "auto",
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'filetype'},
        lualine_y = {''},
        lualine_z = {'location'}
  },
}
