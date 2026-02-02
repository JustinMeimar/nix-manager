local function format_to_col(text, width)
    local result = {}
    -- Split into paragraphs (separated by empty lines)
    local paragraphs = vim.split(text, '\n\n', {plain = true})

    for i, para in ipairs(paragraphs) do
        if para:match('^%s*$') then
            -- Preserve empty paragraphs
            table.insert(result, para)
        else
            -- Detect indentation from first line
            local indent = para:match('^%s*') or ''
            -- Collapse paragraph into single line of words
            local words = {}
            for word in para:gmatch('%S+') do
                table.insert(words, word)
            end

            -- Reflow words into lines of max width
            local lines = {}
            local current = indent

            for j, word in ipairs(words) do
                local test = current == indent and (current .. word) or (current .. ' ' .. word)
                if #test <= width then
                    current = test
                else
                    if current ~= indent then
                        table.insert(lines, current)
                    end
                    current = indent .. word
                end
            end
            if current ~= indent then
                table.insert(lines, current)
            end

            table.insert(result, table.concat(lines, '\n'))
        end
    end

    return table.concat(result, '\n\n')
end

local function format_text_file()
    -- Common text files like markdown, typst and text can be formated such that
    -- no line exceedsd a column width. This makes a text file readable in a terminal
    -- pane.

    local ft = vim.bo.filetype
    local allowed = {md = true, markdown = true, typst = true, text = true}

    if not allowed[ft] then
        print("Filetype '" .. ft .. "' not supported.")
        return
    end

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local text = table.concat(lines, '\n')
    local formatted = format_to_col(text, 80)

    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(formatted, '\n', {plain = true}))
end

vim.keymap.set('n', '<leader>fw', format_text_file, {desc = 'Format text file to width'})

