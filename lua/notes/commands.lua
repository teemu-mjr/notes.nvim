local config = require("notes.config")
local M = {}

function M.setup()
    vim.api.nvim_create_user_command(
        "Note",
        function(opts)
            require("notes").open(opts.fargs[1])
        end, {
            nargs = "?",
            complete = NoteComplete
        })
    vim.api.nvim_create_user_command(
        "NoteToday", require("notes").today, {})
    vim.api.nvim_create_user_command(
        "NoteNext",
        function()
            require("notes").change_day(1)
        end, {})
    vim.api.nvim_create_user_command(
        "NotePrev",
        function()
            require("notes").change_day(-1)
        end, {})
    vim.api.nvim_create_user_command(
        "NoteSync", require("notes").sync, {})
end

function NoteComplete(ArgLead, CmdLine, CursorPos)
    local pfile = io.popen(
        "find " .. config.note_dir ..
        " -maxdepth 1 -type f -printf '%f\n' | awk -F. '{print $1}'"
    )
    if pfile == nil then
        return
    end

    local file_names = {}
    local i = 0
    for file in pfile:lines() do
        i = i + 1
        file_names[i] = file
    end
    pfile:close()
    return file_names
end

return M
