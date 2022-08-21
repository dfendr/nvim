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
    --use 'whynothugo/lsp_lines.nvim'     -- in line error messages
    use {'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' }}-- Startup Page
    use 'lukas-reineke/indent-blankline.nvim'
    use 'karb94/neoscroll.nvim'         -- Nice Scrolling

    -- AutoPair
    use "windwp/nvim-autopairs"       -- Bracket pairing

    -- Bufferline
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

    --Commenting
    use "numToStr/Comment.nvim"
    use "folke/todo-comments.nvim"      -- Keyword Highlighting



    -- Colorschemes/Colorizer
    use "ellisonleao/gruvbox.nvim"    -- gruvbox theme
    --use "luisiacc/gruvbox-baby"         -- gruvbox with Treesitter support
    use "norcalli/nvim-colorizer.lua" -- Adds color to Nvim

    -- Code Runner
      use "is0n/jaq-nvim"
      use {
        "0x100101/lab.nvim",
        run = "cd js && npm ci",
      }

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-emoji"        -- Emoji snippets for...some reason
    use "hrsh7th/cmp-nvim-lsp"     -- LSP cmp integration
    use "hrsh7th/cmp-nvim-lua"     -- LSP Lua cmp integration

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
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "ray-x/lsp_signature.nvim"
  use "SmiteshP/nvim-navic"
  use "simrat39/symbols-outline.nvim"
  --use "b0o/SchemaStore.nvim"


    --Lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}


    -- Telescope
    use "nvim-telescope/telescope.nvim"     -- File/Path finder
    use 'nvim-telescope/telescope-media-files.nvim' -- View media files
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use "BurntSushi/ripgrep" -- Helps with searching contents

    -- Terminal 
    use {"akinsho/toggleterm.nvim", tag = "v2.*"}

    --Treesitter
    use
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }
    use "p00f/nvim-ts-rainbow"
    use "nvim-treesitter/playground"
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- Utility
    use "lewis6991/impatient.nvim"      -- Speeds up Nvim w cache
    use "rcarriga/nvim-notify"          -- Popup notifications
    use "RRethy/vim-illuminate"         -- Highlight other uses of current word
    use "filipdutescu/renamer.nvim"    -- VsCode like renaming

    -- Which Key 
    use {"folke/which-key.nvim" }



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)


-- GRAVEYARD
-- use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }
-- use 'glepnir/dashboard-nvim'        -- Startup Screen
