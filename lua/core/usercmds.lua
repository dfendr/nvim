local function start_profiling()
    vim.cmd("profile start profile.log")
    vim.cmd("profile func *")
    vim.cmd("profile file *")
end

local function stop_profiling()
    vim.cmd("profile pause")
    vim.cmd("noautocmd qall!")
end

-- Register the start profiling command
vim.api.nvim_create_user_command("StartProfiling", start_profiling, { desc = "Start profiling Vimscript execution" })

-- Register the stop profiling command
vim.api.nvim_create_user_command("StopProfiling", stop_profiling, { desc = "Stop profiling and exit Neovim" })

vim.api.nvim_create_user_command("DbToExcel", function()
    -- get buffer content
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    -- create temp file in memory
    local temp_file = "/tmp/dbout.csv"
    local f = io.open(temp_file, "w")

    -- function to escape and quote fields for CSV
    local function format_field(field)
        field = tostring(field):match("^%s*(.-)%s*$") -- trim whitespace
        return '"' .. field:gsub('"', '""') .. '"'
    end

    -- function to detect column boundaries based on the header and the first data row
    local function detect_column_boundaries(header_line, first_data_line)
        local boundaries = {}
        local pattern = "%S+" -- matches contiguous non-space characters
        for start_pos, field in header_line:gmatch("()" .. pattern) do
            table.insert(boundaries, start_pos)
        end
        table.insert(boundaries, #header_line + 1) -- add end position for the last column
        return boundaries
    end

    -- function to parse a line using detected column boundaries
    local function parse_line_with_boundaries(line, boundaries)
        local fields = {}
        for i = 1, #boundaries - 1 do
            local start_pos = boundaries[i]
            local end_pos = boundaries[i + 1] - 1
            local field = line:sub(start_pos, end_pos)
            table.insert(fields, format_field(field))
        end
        return fields
    end

    -- function to process header and data rows
    local function process_lines()
        local in_data_section = false
        local column_boundaries = {}

        for i, line in ipairs(lines) do
            if line:match("%(%d+ rows affected%)") then
                break -- skip footer lines like "(x rows affected)"
            end

            if not in_data_section then
                -- detect column boundaries from the header line and first data row
                column_boundaries = detect_column_boundaries(line, lines[i + 1])
                f:write(line:gsub("%s+", ",") .. "\n")
                in_data_section = true
            elseif line:match("%S") and not line:match("^[- ]+$") then
                -- write data rows using detected boundaries for consistent parsing
                local parsed_fields = parse_line_with_boundaries(line, column_boundaries)
                f:write(table.concat(parsed_fields, ",") .. "\n")
            end
        end
    end

    -- process lines and close the file
    process_lines()
    f:close()

    -- open the CSV file in Excel
    os.execute("open -a 'Microsoft Excel' " .. temp_file)
end, { desc = "Export dbout buffer to CSV and open in Excel" })
