-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet
vim.g.use_nerd_icons = true
if vim.fn.has("mac") == 1 or vim.g.use_nerd_icons then
    return {
        kind = {
            Array = "",
            Boolean = "",
            Class = "",
            Color = "",
            Constant = "",
            Constructor = "",
            Enum = "",
            EnumMember = "",
            Event = "",
            Field = "",
            File = "",
            Folder = "",
            Function = "󰊕",
            Interface = "",
            Key = "",
            Keyword = "",
            Method = "",
            Module = "",
            Namespace = "",
            Null = "ﳠ",
            Number = "",
            Object = "",
            Operator = "",
            Package = "",
            Property = "",
            Reference = "",
            Snippet = "", --
            String = "",
            Struct = "",
            Text = "",
            TypeParameter = "",
            Unit = "",
            Value = "",
            Variable = "",
        },
        type = {
            Array = " ",
            Number = "",
            String = "",
            Boolean = "蘒",
            Object = "",
        },
        documents = {
            File = "",
            Files = "",
            Folder = "󰉋",
            Default = "",
            OpenFolderEmpty = "",
            OpenFolder = "",
            SymlinkFolder = "",
            SymlinkFile = "",
            SymlinkArrow = "➛",
        },
        git = {
            Add = "",
            Mod = "",
            Remove = "",
            Ignore = "",
            Rename = "",
            Diff = "",
            Repo = "",
            Octoface = "",
            Deleted = " ",
            Unmerged = " ",
            Untracked = "u",
            IgnoreCircle = "◌",
            StagedCircle = "",
            UnstagedCircle = "",
        },
        ui = {
            ArrowClosed = "",
            ArrowOpen = "",
            Lock = "",
            Circle = " ",
            BigCircle = "",
            BigUnfilledCircle = "",
            Close = "",
            NewFile = "",
            Search = "",
            Lightbulb = "",
            Project = "",
            Dashboard = "",
            History = "  ",
            Comment = "  ",
            Bug = "",
            Stacks = "",
            Scopes = "",
            DebugConsole = "",
            Code = "",
            Telescope = "",
            Gear = "",
            Package = "",
            List = "",
            SignIn = "",
            SignOut = "",
            Check = "",
            Fire = "",
            Note = "",
            BookMark = "",
            Pencil = "",
            -- ChevronRight = "",
            ChevronRight = ">",
            Table = "",
            Calendar = "",
            CloudDownload = "",
        },
        diagnostics = {
            Error = "",
            Warning = "",
            Information = "",
            Question = "",
            Hint = "",
        },
        misc = {
            Robot = "󰚩",
            Squirrel = "",
            Tag = "",
            Watch = "",
            Smiley = "ﲃ",
            Package = "",
            CircuitBoard = "",
            Repo = "",
            Word = "",
        },
    }
else
    --   פּ ﯟ   蘒練 some other good icons
    return {
        kind = {
            Text = " ",
            Method = " ",
            Function = " ",
            Constructor = " ",
            Field = " ",
            Variable = " ",
            Class = " ",
            Interface = " ",
            Module = " ",
            Property = " ",
            Unit = " ",
            Value = " ",
            Enum = " ",
            Keyword = " ",
            Snippet = " ",
            Color = " ",
            File = " ",
            Reference = " ",
            Folder = " ",
            EnumMember = " ",
            Constant = " ",
            Struct = " ",
            Event = " ",
            Operator = " ",
            TypeParameter = " ",
            Misc = " ",
        },
        type = {
            Array = " ",
            Number = " ",
            String = " ",
            Boolean = " ",
            Object = " ",
        },
        documents = {
            File = " ",
            Files = " ",
            Folder = " ",
            Default = " ",
            OpenFolderEmpty = " ",
            OpenFolder = " ",
            SymlinkFolder = " ",
            SymlinkFile = "",
            SymlinkArrow = " ➛ ",
        },
        git = {
            Add = " ",
            Mod = " ",
            Remove = " ",
            Rename = " ",
            Repo = " ",
            Octoface = " ",
            Ignore = " ",
            Deleted = " ",
            Diff = " ",
            Unmerged = " ",
            Untracked = "u ",
            IgnoreCircle = "◌ ",
            StagedCircle = " ",
            UnstagedCircle = " ",
        },
        ui = {
            ArrowClosed = "",
            ArrowOpen = "",
            Lock = " ",
            Circle = " ",
            BigCircle = " ",
            BigUnfilledCircle = " ",
            Close = " ",
            NewFile = " ",
            Search = " ",
            Lightbulb = " ",
            Project = " ",
            Dashboard = " ",
            History = " ",
            Comment = " ",
            Bug = " ",
            Code = " ",
            Telescope = " ",
            Gear = " ",
            Package = " ",
            List = " ",
            SignIn = " ",
            SignOut = " ",
            NoteBook = " ",
            Check = " ",
            Fire = " ",
            Note = " ",
            BookMark = " ",
            Pencil = " ",
            ChevronRight = "",
            Table = " ",
            Calendar = " ",
            CloudDownload = " ",
        },
        diagnostics = {
            Error = " ",
            Warning = " ",
            Information = " ",
            Question = " ",
            Hint = " ",
        },
        misc = {
            Robot = " ",
            Squirrel = " ",
            Tag = " ",
            Watch = " ",
            Smiley = " ",
            Package = " ",
            CircuitBoard = " ",
        },
    }
end
