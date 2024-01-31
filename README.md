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
- Created for Neovim Nightly (Currently: 0.10)
- Linux/macOS.

## Features 🌲

- 🧩 Modular Format
- 💤 Automatic plugin installation (and lazy loading!) via `lazy.vim`
- 🌅 Daytime/Nighttime changes (statusbar icons and dashboard) 🌔
- 🤏 Size aware, dynamically changes UI elements when resized.
- 📄 Per filetype shortcuts accessed with `<leader> L`
- 🌐 Automatic LSP integrations via `Mason`, with modular format for adding LSP
  options per server.
- 🏃 Quick-run files with `<leader>rr` using `Coderunner.nvim`
- 🐛 Quick DAP setup with `mason-nvim-dap.nvim`, meaning easy debugging!
- ☁️ Database Explorer via dadbod-vim!
- 🤔 No need to remember _all_ keybinds, `<leader>` pops up a helpful keybind
  guide, provided by `which-key.nvim`

### Already Supported Language (e.g. Languages I use with Fenvim)

| Language     | Supported |
| ------------ | :-------: |
| Bash         |    ✅     |
| C            |    ✅     |
| C#           |    ✅     |
| Dart/Flutter |    ✅     |
| Java         |    🌀     |
| Javacript    |    ✅     |
| Lua          |    ✅     |
| Markdown     |    ✅     |
| Perl         |    ✅     |
| R            |    ✅     |
| Rust         |    ✅     |
| Zsh          |    ✅     |

|     |           |
| --- | --------- |
| ✅  | Supported |
| 🌀  | Linting   |

## 🌟 Showcase

<details>
<summary>Dashboard</summary>
  <img width="700" alt="Landing Page Dashboard For Easy Shortcuts" src="https://i.imgur.com/u3iy142.png">
</details>

<details>
<summary>Tiny Dashboard</summary>
  <img width="700" alt="Size Aware Dashboard For Mini Editing" src="https://i.imgur.com/Fqd0OJP.png">
</details>

<details>
<summary>Which-Key provides easy reminders for more complex keybinds</summary>
  <img width="700" alt="Editor showing commands, in WhichKey popup" src="https://i.imgur.com/44QPgnt.png">
</details>

<details>
<summary>Example: Editing an R file, with R REPL in Toggleable Terminal</summary>
  <img width="700" alt="Example: Editing an R file, with R Repl in Toggleable Terminal, Explorer Tree in Left Panel" src="https://i.imgur.com/PMvsZQJ.png">
</details>

<details>
<summary>Example: LSP inspections</summary>
  <img width="700" alt="Examining the documentation for .iter() in Rust" src="https://i.imgur.com/ZK296f2.png">
</details>

<details>
<summary>Database Integration</summary>
  <img width="700" alt="Querying a Sandbox Database in the editor" src="https://i.imgur.com/CnA5XB5.png">
</details>

<details>
<summary>Example: Debugging</summary>
  <img width="700" alt="Debugging in Neovim, Rust example" src="https://i.imgur.com/F6RkyFW.png">
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

# Clone dfendr/nvim repository
git clone https://github.com/postfen/nvim.git
```

### Dependencies

- [Neovim](https://github.com/neovim/neovim) nightly
- [NPM](https://nodejs.org/en/download/) (>= 16.0) -- for LSP

### Nice to Haves

- Not necessary to have, but shortcuts are already mapped for them.
- [Lazygit](https://github.com/jesseduffield/lazygit) for easy source control without
  leaving Neovim.
- [BrowserSync](https://browsersync.io/) for live updating web previews when
  working with JS/TS/HTML

### Acknowledgements

- [TJ Devries](https://github.com/tjdevries)
- [chris@machine](https://github.com/ChristianChiarulli)
- [craftzdog](https://github.com/craftzdog)
- [ThePrimeagen](https://github.com/ThePrimeagen)
