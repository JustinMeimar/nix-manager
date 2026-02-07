-- Symmetric delimiters that skip formatting when encountered
local SKIP_DELIMITERS = {
    ['```'] = true,
    ['---'] = true,
}

local function format_paragraph(para_lines, width)
    if #para_lines == 0 then return {} end

    local first_line = para_lines[1]
    local initial_indent = first_line:match('^%s*') or ''

    -- Detect if this is a list item (-, *, --, etc. followed by space)
    local list_marker = first_line:match('^%s*([%-*]+)%s')
    local continuation_indent

    if list_marker then
        -- Find first non-space char after marker
        local marker_pos = #initial_indent + #list_marker + 1
        continuation_indent = string.rep(' ', marker_pos)
    else
        -- For non-list items, align continuation to first non-space char
        local first_nonspace = first_line:match('^%s*()')
        if first_nonspace and first_nonspace > 1 then
            continuation_indent = string.rep(' ', first_nonspace - 1)
        else
            continuation_indent = initial_indent
        end
    end

    -- Collapse paragraph into words
    local words = {}
    for _, line in ipairs(para_lines) do
        for word in line:gmatch('%S+') do
            table.insert(words, word)
        end
    end

    if #words == 0 then return {first_line} end

    -- Reflow words
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

local function format_to_col(text, width)
    local lines = vim.split(text, '\n', {plain = true})
    local result = {}
    local skip_stack = {}
    local i = 1

    while i <= #lines do
        local line = lines[i]
        local delimiter = check_delimiter(line)

        if delimiter then
            -- Toggle skip mode for this delimiter
            if #skip_stack > 0 and skip_stack[#skip_stack] == delimiter then
                table.remove(skip_stack)
            else
                table.insert(skip_stack, delimiter)
            end
            table.insert(result, line)
            i = i + 1
        elseif #skip_stack > 0 then
            -- Inside skip block, preserve exactly
            table.insert(result, line)
            i = i + 1
        elseif line:match('^%s*$') then
            -- Preserve empty lines
            table.insert(result, line)
            i = i + 1
        else
            -- Process paragraph until empty line or delimiter
            local para_lines = {line}
            local j = i + 1
            while j <= #lines do
                local next_line = lines[j]
                if next_line:match('^%s*$') or check_delimiter(next_line) then
                    break
                end
                table.insert(para_lines, next_line)
                j = j + 1
            end

            -- Format this paragraph
            local formatted = format_paragraph(para_lines, width)
            for _, fline in ipairs(formatted) do
                table.insert(result, fline)
            end

            i = j
        end
    end

    return table.concat(result, '\n')
end

local function format_text_file()
    -- Common text files like markdown, typst and text can be formated such that
    -- no line exceedsd a column width. This makes a text file readable in a terminal
    -- pane.
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local text = table.concat(lines, '\n')
    local formatted = format_to_col(text, 70)

    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(formatted, '\n', {plain = true}))
end

vim.keymap.set('n', '<leader>fw', format_text_file, {desc = 'Format text file to width'})

