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
- 🏃 Quickrun files with `<leader>rr` using `Coderunner.nvim`
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

|     |           |
| --- | --------- |
| ✅  | Supported |
| 🌀  | Linting   |

## 🌟 Showcase

<details>
<summary>Dashboard</summary>
  <img width="700" alt="Landing Page Dashboard For Easy Shortcuts" src="https://imgur.com/fJcOqfb.png">
</details>

<details>
<summary>Tiny Dashboard</summary>
  <img width="700" alt="Size Aware Dashboard For Mini Editing" src="https://i.imgur.com/Fqd0OJP.png">
</details>

<details>
<summary>Which-Key provides easy reminders for more complex keybinds</summary>
  <img width="700" alt="Editor showing commands, in WhichKey popup" src="https://i.imgur.com/pKxSs5s.png">
</details>

<details>
<summary>Example: Editing an R file, with R REPL in Toggleable Terminal</summary>
  <img width="700" alt="Example: Editing an R file, with R Repl in Toggleable Terminal, Explorer Tree in Left Panel" src="https://i.imgur.com/AC1yls3.png">
</details>

<details>
<summary>Example: LSP inspections</summary>
  <img width="700" alt="Examining the documentation for .iter() in Rust" src="https://i.imgur.com/gMwu1WJ.png">
</details>

<details>
<summary>Example: Debugging</summary>
  <img width="700" alt="Debugging in Neovim, Rust example" src="https://i.imgur.com/xpAu3IN.png">
</details>

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

### Acknowledgements

- [TJ Devries](https://github.com/tjdevries)
- [chris@machine](https://github.com/ChristianChiarulli)
- [devaslife](https://github.com/craftzdog)
- [ThePrimeagen](https://github.com/ThePrimeagen)
