-- Telescope helper functions

local function current_buffer_search()
  require('telescope.builtin').current_buffer_fuzzy_find({
    fuzzy = false,
    case_mode = 'ignore_case'
  })
end

-- Export as global for easy keymap access
_G.telescope_helpers = {
  current_buffer_search = current_buffer_search,
}
