function dynamic_header()
    local uis = vim.api.nvim_list_uis()[1]
    local height = uis.height
    local width = uis.width
    print(height, width)
end


dynamic_header()
