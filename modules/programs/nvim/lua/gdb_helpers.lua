-- Helper for GDB debugging - grab the file name and line from the current
-- buffer so that it can be pasted into a `b` (break) command for GDB.

local map = vim.keymap.set

local function copy_file_line_for_gdb()
    local filename = vim.fn.expand("%:p")
    local line = vim.fn.line(".")
    local gdb_location = filename .. ":" .. line

    -- Copy to system clipboard (+ register) and primary selection (* register)
    vim.fn.setreg("+", gdb_location)
    vim.fn.setreg("*", gdb_location)

    vim.notify("Copied to clipboard: " .. gdb_location, vim.log.levels.INFO)
end

map("n", "<leader>lg", copy_file_line_for_gdb, { desc = "Copy file:line for GDB" })
