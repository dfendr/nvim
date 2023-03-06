#

![Daylight](https://i.imgur.com/jh46kXC.png)
![Nighttime](https://i.imgur.com/MdLBbXT.png)

> Fenvim is a powerful and customizable Neovim configuration designed for students
> (me) and those who dabble with multiple programming languages. The configuration
> is modular and easy to use, allowing you to quickly adjust it to your specific
> needs.
> Inspired by Lunarvim, Fenvim is built for speed and includes features like
> automatic plugin installation, per-filetype keybinds, and
> daytime/nighttime UI changes.

- **Use at your own discretion, WIP**
- Linux/macOS.

## Features 🌲

- 🧩 Modular Format
- 💤 Automatic plugin installation (and lazy loading!) via `lazy.vim`
- 🌅 Daytime/NightTime changes (statusbar icons and dasboard) 🌔
- 🤏 Size aware, dynamically changes UI elements when resized.
- 📄 Per filetype shortcuts accessed with `<leader> L`
- 🌐 Automatic LSP integrations via `Mason`, with modular format for adding LSP
  options per server.
- 🏃 Quickrun files with `<leader>rr` using `Coderunnier.nvim`
- 🐛 Quick DAP setup with `mason-nvim-dap.nvim`, meaning easy debugging!
- 🤔 No need to remember _all_ keybinds, `<leader>` pops up a helpful keybind
  guide, provided by `which-key.nvim`

### Already Supported Language (e.g. Languages I use with Fenvim)

| Language  | Supported |
| --------- | :-------: |
| Bash      |    ✅     |
| Zsh       |    ✅     |
| C         |    ✅     |
| C#        |    ✅     |
| Lua       |    ✅     |
| Javacript |    ✅     |
| Java      |    🌀     |
| Markdown  |    ✅     |
| Perl      |    ✅     |
| Rust      |    ✅     |
| R         |    ✅     |

|     |                      |
| --- | -------------------- |
| ✅  | Supported            |
| 🌀  | Not fully supported. |

### Screenshots 📸

![dashboard](https://i.imgur.com/45FhVEN.png)
![mini-dashboard](https://i.imgur.com/Fqd0OJP.png)
![explorer-tree, toggleterm](https://i.imgur.com/FGkX4l1.png)
![which-key](https://i.imgur.com/gAFpLsv.png)
![rust debugging](https://i.imgur.com/r6izDC3.png)

## Install 💻

```bash
# Move into ~/.config directory
cd ~/.config

# Create nvim directory if it doesn't exist
if [ ! -d "nvim" ]; then
  mkdir nvim
fi

# Move into nvim directory
cd nvim

# Clone postfen/nvim repository
git clone https://github.com/postfen/nvim.git
```

### Dependencies

- [Neovim](https://github.com/neovim/neovim) nightly
- [NPM](https://nodejs.org/en/download/) (>= 16.0) -- for LSP

### Nice to Haves

- Not neccesary to have, but shortcuts are already mapped for them.
- [GitUI](https://github.com/extrawurst/gitui) for easy source control without
  leaving Neovim.
- [Cargo](https://www.rust-lang.org/tools/install)
  - [Silicon](https://github.com/Aloxaf/silicon) for code snippet sharing.
- [BrowserSync](https://browsersync.io/) for live updating web previews when
  working with JS/TS/HTML
