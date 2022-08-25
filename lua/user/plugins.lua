-- shorthand
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
      "git",
      "clone",
      "--depth",
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
    use 'goolord/alpha-nvim'            -- Startup Dashboard


    -- CMP
    use "hrsh7th/nvim-cmp"              -- Autocompletion engine
    use "hrsh7th/cmp-nvim-lsp"          -- LSP cmp integration
    use "hrsh7th/cmp-buffer"            -- buffer completions
    use "hrsh7th/cmp-path"              -- path completions
    use "hrsh7th/cmp-nvim-lua"          -- LSP Lua cmp integration
    use "saadparwaiz1/cmp_luasnip"      -- snippet completions
    use "hrsh7th/cmp-cmdline"           -- cmdline completions
    use "hrsh7th/cmp-emoji"             -- Emoji snippets for...some reason

    -- Colorsheme
    use "folke/tokyonight.nvim"
    use "ellisonleao/gruvbox.nvim"
    use "luisiacc/gruvbox-baby"
    use "RRethy/nvim-base16"

    -- Lualine
    use 'nvim-lualine/lualine.nvim'          -- Bottom status bar

        -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig" -- enable LSP
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
    use "tversteeg/registers.nvim"      -- preview registers with " 
    use "RRethy/vim-illuminate" -- 
    use "SmiteshP/nvim-navic"
    use {"folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons"}

    -- Telescope
    use "nvim-telescope/telescope.nvim"     -- File/Path finder
    use 'nvim-telescope/telescope-media-files.nvim' -- View media files
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use "BurntSushi/ripgrep" -- Helps with searching contents

    -- Git
    use "lewis6991/gitsigns.nvim"

    --Treesitter
    use
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }
    use "p00f/nvim-ts-rainbow"
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-context"

    use 'JoosepAlviste/nvim-ts-context-commentstring'

    --Commenting
    use "numToStr/Comment.nvim"         -- Comment anywhere anything
    use "folke/todo-comments.nvim"      -- Keyword Highlighting

    -- Navigation
    -- Editing Support
    use "karb94/neoscroll.nvim"         -- Smooth scrolling
    use "windwp/nvim-autopairs"       -- Bracket pairing
    use "filipdutescu/renamer.nvim"    -- VsCode like renaming
    use "lukas-reineke/indent-blankline.nvim" -- VSCode like whitespace
    use "sunjon/Shade.nvim"             -- Shade unfocused buffers

    -- Terminal
    use "akinsho/toggleterm.nvim"

    -- Utility
    use "lewis6991/impatient.nvim" -- Ye Ol Nvim Load Quickener

    --UI
    use "rcarriga/nvim-notify"          -- Popup notifications

    -- Which-Key
    use "folke/which-key.nvim"          -- Visual Keymap

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

