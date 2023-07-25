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
    vim.cmd [[command! -nargs=1 NoteNew lua require("notes").new(<f-args>)]]
    vim.cmd [[command! NoteNow lua require("notes").now()]]
end
function M.new(note_name)
    local filename = os.date("%Y-%m-%d") .. "_" .. note_name
    vim.cmd("e" .. config.note_dir .. filename .. ".md")
end

function M.now()
    local filename = os.date("%Y-%m-%d")
    vim.cmd("e" .. config.note_dir .. filename .. ".md")
end

return M
