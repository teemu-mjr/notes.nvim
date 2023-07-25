M = {}
local config = {}

function M.setup(user_config)
    config = user_config
    if (config.note_dir == nil) then
        return
    end
    M.make_commands()
end

function M.make_commands()
    vim.cmd [[command! NoteNow lua require("notes").now()]]
end

function M.now()
    local filename = os.date("%Y-%m-%d")
    vim.cmd("e" .. config.note_dir .. filename .. ".md")
end

return M
