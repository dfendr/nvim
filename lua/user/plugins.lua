-- shorthand
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("Packer is not installed")
    return
end

-- Have packer use a popup window
packer.init {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
}

----------------------------
-- Install your plugins here
----------------------------
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim"        -- Have packer manage itself
    use "nvim-lua/popup.nvim"           -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"         -- Useful lua functions used ny lots of plugins
    use 'kyazdani42/nvim-tree.lua'      -- Nvim Tree
    use 'kyazdani42/nvim-web-devicons'  -- Nvim Tree Devicons


    use "hrsh7th/nvim-cmp"              -- Autocompletion engine
    use "hrsh7th/cmp-nvim-lsp"          -- LSP cmp integration
    use "hrsh7th/cmp-buffer"            -- buffer completions
    use "hrsh7th/cmp-path"              -- path completions
    use "hrsh7th/cmp-nvim-lua"          -- LSP Lua cmp integration
    use "saadparwaiz1/cmp_luasnip"      -- snippet completions
    use "hrsh7th/cmp-cmdline"           -- cmdline completions
    use "hrsh7th/cmp-emoji"             -- Emoji snippets for...some reason

    -- Colorsheme
    use "ellisonleao/gruvbox.nvim"

    -- Lualine
    use 'nvim-lualine/lualine.nvim'          -- Bottom status bar

        -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- GitSigns
    use "lewis6991/gitsigns.nvim"

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    -- use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "tversteeg/registers.nvim"      -- preview registers with " 

     --Treesitter
    use
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }
    use "p00f/nvim-ts-rainbow"
    use "nvim-treesitter/playground"
    use 'JoosepAlviste/nvim-ts-context-commentstring' 

    --Commenting
    use "numToStr/Comment.nvim"
    use "folke/todo-comments.nvim"      -- Keyword Highlighting


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

