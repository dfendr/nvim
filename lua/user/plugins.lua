-- shorthand
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augrou packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("Packer is not installed")
    return
end

-- Have packer use a popup window
packer.init({
    max_jobs = 50,
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    snapshot_path = fn.stdpath("config") .. "/snapshots",
    -- snapshot = "Oct26-2022",
})

-- Install your plugins here
----------------------------
return packer.startup(function(use)
    -- My plugins here
    use("wbthomason/packer.nvim") -- Have packer manage itself
    use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
    use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
    use("kyazdani42/nvim-tree.lua") -- Nvim Tree
    use("kyazdani42/nvim-web-devicons") -- Nvim Tree Devicons
    use("goolord/alpha-nvim") -- Startup Dashboard

    -- CMP
    use("hrsh7th/nvim-cmp") -- Autocompletion engine
    use("hrsh7th/cmp-nvim-lsp") -- LSP cmp integration
    use("hrsh7th/cmp-buffer") -- buffer completions
    use("hrsh7th/cmp-path") -- path completions
    use("hrsh7th/cmp-nvim-lua") -- LSP Lua cmp integration
    use("saadparwaiz1/cmp_luasnip") -- snippet completions
    use("hrsh7th/cmp-cmdline") -- cmdline completions
    use("hrsh7th/cmp-emoji") -- Emoji snippets for...some reason

    -- MINI
    use("echasnovski/mini.nvim")

    -- Colorsheme
    use("luisiacc/gruvbox-baby")
    -- use("sainnhe/gruvbox-material")
    use("EdenEast/nightfox.nvim")

    -- Lualine
    use("nvim-lualine/lualine.nvim") -- Bottom status bar

    -- snippets
    use("L3MON4D3/LuaSnip") --snippet engine
    use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

    -- LSP
    use("williamboman/mason.nvim") -- LSP/Linter/DAP Downloader
    use("williamboman/mason-lspconfig.nvim") -- Layer between Mason/LSPconfig
    use("neovim/nvim-lspconfig") -- enable LSP
    use({
        "jose-elias-alvarez/null-ls.nvim",--[[ , commit="bf02782" ]]
    }) -- for formatters and linters
    use("RRethy/vim-illuminate") -- illuminate words under cursor
    use("Maan2003/lsp_lines.nvim")
    use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })
    use("norcalli/nvim-colorizer.lua") -- See hex codes
    use("simrat39/symbols-outline.nvim") -- Symbol outline like vscode
    use("ray-x/lsp_signature.nvim") -- popup to help fill functions.
    -- use("folke/neodev.nvim") -- Neovim Dev LSP -- API lookups n suggestions. -- TAKES FOREVER

    -- Telescope
    use("nvim-telescope/telescope-media-files.nvim") -- View media files
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- File/Path finder
    use({ "nvim-telescope/telescope-file-browser.nvim" })
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    })
    use("nvim-telescope/telescope-dap.nvim")
    use("BurntSushi/ripgrep") -- Helps with searching contents
    use("ahmedkhalf/project.nvim")

    -- Git
    use("lewis6991/gitsigns.nvim")

    -- DAP
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")
    use("mfussenegger/nvim-dap-python") -- python debug adapter
    use("simrat39/rust-tools.nvim") -- rust debug adapter
    use({
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
    }) -- java debug adapter

    --Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use("p00f/nvim-ts-rainbow")
    use("nvim-treesitter/playground")
    use("nvim-treesitter/nvim-treesitter-context")
    use("JoosepAlviste/nvim-ts-context-commentstring")

    --Commenting
    use("folke/todo-comments.nvim") -- Keyword Highlighting
    use("numToStr/Comment.nvim") -- Comment anywhere anything

    -- Navigation
    -- Editing Support
    use("windwp/nvim-autopairs") -- Bracket pairing
    use("filipdutescu/renamer.nvim") -- VsCode like renaming
    use("lukas-reineke/indent-blankline.nvim") -- VSCode like whitespace
    use("nvim-pack/nvim-spectre") -- Project level replacements/renaming
    use("nmac427/guess-indent.nvim") -- automatically set indentation based on buffer
    use("nat-418/boole.nvim") -- ctrl-a and ctrl-x extension (toggles bools, on/off, letters)
    -- use("superhawk610/ascii-blocks.nvim") -- :AsciiBlockify - turns +- blocks into nicely formatted ascii blocks
    use("jbyuki/venn.nvim") -- Draw boxes easier
    use("lvimuser/lsp-inlayhints.nvim")

    -- Markdown Editing Support
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })
    use("gaoDean/autolist.nvim") -- auto indent and increment list elements

    -- Sessions
    use("rmagatti/auto-session")
    use("rmagatti/session-lens")

    -- Terminal
    use("akinsho/toggleterm.nvim") -- toggles terminal like vscode (but better)

    -- Utility
    use("lewis6991/impatient.nvim") -- Ye Ol Nvim Load Quickener
    use("is0n/jaq-nvim") -- Code runner

    --UI
    use("karb94/neoscroll.nvim") -- Smooth scrolling
    use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
    use("rcarriga/nvim-notify") -- Popup notifications
    use("j-hui/fidget.nvim") -- LSP startup notifications NOTE: Marked for deletion
    use("tiagovla/scope.nvim") -- Keeps buffer  within tabs -- disabled until I can disable for specific filetypes.
    use({ -- Auto Window resizer
        "anuvyklack/windows.nvim",
        requires = {
            "anuvyklack/middleclass",
            -- "anuvyklack/animation.nvim",
        },
    })

    -- Which-Key
    use("folke/which-key.nvim") -- Visual Keymap

    --Zen Mode
    use("folke/zen-mode.nvim")
    use("folke/twilight.nvim")

    -- Silly
    use("andweeb/presence.nvim") -- Discord presence :^)
    use({
        "narutoxy/silicon.lua",
        requires = { "nvim-lua/plenary.nvim" },
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

--                        ┌───────────┐
--                        │GRAVEYARD! │
---                       └───────────┘
--use({ "michaelb/sniprun", run = "bash ./install.sh" }) -- coderunner
--use("sunjon/Shade.nvim") -- Shade unfocused buffers
-- use("kdheepak/tabline.nvim")
--use("glepnir/lspsaga.nvim")
-- use("SmiteshP/nvim-navic")
--use("tversteeg/registers.nvim") -- preview registers with "

-- -Color Schemes
-- use("folke/tokyonight.nvim")
--use("ellisonleao/gruvbox.nvim")
-- use("RRethy/nvim-base16")
-- use("sainnhe/gruvbox-material")
-- use("icedman/nvim-textmate")
