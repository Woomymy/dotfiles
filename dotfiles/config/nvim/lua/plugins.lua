-- THX https://github.com/wbthomason/packer.nvim#bootstrapping
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
                                      install_path})
end

return require('packer').startup(function()
    if packer_bootstrap then
        require('packer').sync()
    end
    -- I used the package manager to manage de package manager
    use 'wbthomason/packer.nvim'
    -- Ayu color scheme
    use 'Shatur/neovim-ayu'
    -- Auto pairs (() "" {})
    use 'windwp/nvim-autopairs'
    --  Dashboard
    use {
        'goolord/alpha-nvim',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    -- Add gentoo ebuilds and typst syntax
    use 'gentoo/gentoo-syntax'
    use { 'kaarmu/typst.vim', ft = {'typst'} }
    -- Lualine
    use 'nvim-lualine/lualine.nvim'
    -- Lsp configuration
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'folke/trouble.nvim' -- Problems list
    use 'udalov/kotlin-vim'-- Kotlin support
end)
