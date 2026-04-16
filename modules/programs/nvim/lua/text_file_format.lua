local DEFAULT_WIDTH = 65

local SKIP_DELIMITERS = {
    ['```'] = true,
    ['---'] = true,
}

local function format_paragraph(para_lines, width)
    if #para_lines == 0 then return {} end

    local first_line = para_lines[1]
    local initial_indent = first_line:match('^%s*') or ''

    local list_marker = first_line:match('^%s*([%-*]+)%s')
    local continuation_indent

    if list_marker then
        local marker_pos = #initial_indent + #list_marker + 1
        continuation_indent = string.rep(' ', marker_pos)
    else
        local first_nonspace = first_line:match('^%s*()')
        if first_nonspace and first_nonspace > 1 then
            continuation_indent = string.rep(' ', first_nonspace - 1)
        else
            continuation_indent = initial_indent
        end
    end

    local words = {}
    for _, line in ipairs(para_lines) do
        for word in line:gmatch('%S+') do
            table.insert(words, word)
        end
    end

    if #words == 0 then return {first_line} end

    local result = {}
    local current = initial_indent .. words[1]

    for i = 2, #words do
        local word = words[i]
        local test = current .. ' ' .. word
        if #test <= width then
            current = test
        else
            table.insert(result, current)
            current = continuation_indent .. word
        end
    end

    if #current > #continuation_indent or #result == 0 then
        table.insert(result, current)
    end

    return result
end

local function check_delimiter(line)
    local after_indent = line:match('^%s*(.*)$')
    for delim, _ in pairs(SKIP_DELIMITERS) do
        if after_indent:sub(1, #delim) == delim then
            return delim
        end
    end
    return nil
end

local function find_skip_ranges(lines)
    local skip = {}
    local open_delimiters = {}

    for i, line in ipairs(lines) do
        local delim = check_delimiter(line)
        if delim then
            if #open_delimiters > 0 and open_delimiters[#open_delimiters][1] == delim then
                local open_idx = open_delimiters[#open_delimiters][2]
                table.remove(open_delimiters)
                for j = open_idx, i do
                    skip[j] = true
                end
            else
                table.insert(open_delimiters, {delim, i})
            end
        end
    end

    return skip
end

local function format_lines(lines, width)
    local result = {}
    local skip = find_skip_ranges(lines)
    local i = 1

    while i <= #lines do
        local line = lines[i]

        if skip[i] then
            table.insert(result, line)
            i = i + 1
        elseif line:match('^%s*$') then
            table.insert(result, line)
            i = i + 1
        else
            local para_lines = {line}
            local j = i + 1
            while j <= #lines do
                local next_line = lines[j]
                if next_line:match('^%s*$') or skip[j] then
                    break
                end
                table.insert(para_lines, next_line)
                j = j + 1
            end

            local formatted = format_paragraph(para_lines, width)
            for _, fline in ipairs(formatted) do
                table.insert(result, fline)
            end

            i = j
        end
    end

    return result
end

local function format_text_file()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local formatted = format_lines(lines, DEFAULT_WIDTH)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted)
end

local function format_text_visual()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local formatted = format_lines(lines, DEFAULT_WIDTH)
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, formatted)
end

local function format_text_paragraph()
    local cur = vim.fn.line('.')
    local total = vim.api.nvim_buf_line_count(0)

    local function is_blank(lnum)
        local line = vim.fn.getline(lnum)
        return line:match('^%s*$') ~= nil
    end

    if is_blank(cur) then return end

    local start_line = cur
    while start_line > 1 and not is_blank(start_line - 1) do
        start_line = start_line - 1
    end

    local end_line = cur
    while end_line < total and not is_blank(end_line + 1) do
        end_line = end_line + 1
    end

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local formatted = format_lines(lines, DEFAULT_WIDTH)
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, formatted)
end

local function format_text_file_prompted()
    local input = vim.fn.input('Column width: ', tostring(DEFAULT_WIDTH))
    local width = tonumber(input)
    if not width or width < 1 then return end
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local formatted = format_lines(lines, width)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted)
end

vim.keymap.set('n', '<leader>fw', format_text_file, {desc = 'Format text file to width'})
vim.keymap.set('v', '<leader>fw', format_text_visual, {desc = 'Format selected text to width'})
vim.keymap.set('n', '<leader>wp', format_text_paragraph, {desc = 'Format current paragraph to width'})
vim.keymap.set('n', '<leader>fW', format_text_file_prompted, {desc = 'Format text file to prompted width'})
