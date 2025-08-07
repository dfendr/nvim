local path = ""
local home = os.getenv("HOME")

if os.execute("[[ $OSTYPE == darwin* ]]") then
    path = home .. "/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll"
elseif os.execute("[[ $OSTYPE == linux* ]]") then
    path = home .. "/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll"
else
    path = "C:\\Users\\dylfe\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\OmniSharp.dll"
end

return {
    cmd = { "dotnet", path },
    enable_editorconfig_support = true,
    enable_ms_build_load_projects_on_demand = false,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    sdk_include_prereleases = true,
    analyze_open_documents_only = false,
}

