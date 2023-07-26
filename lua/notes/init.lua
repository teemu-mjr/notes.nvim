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
    vim.cmd [[command! -nargs=* Note lua require("notes").open(<f-args>)]]
    vim.cmd [[command! NoteToday lua require("notes").today()]]
    vim.cmd [[command! NoteNext lua require("notes").next()]]
    vim.cmd [[command! NotePrev lua require("notes").prev()]]
end

function M.open(note_name, _)
    if (note_name == nil) then
        return vim.cmd("e" .. config.note_dir)
    end
    vim.cmd("e" .. config.note_dir .. note_name .. ".md")
end

function M.today()
    local filename = os.date("%Y-%m-%d")
    vim.cmd("e" .. config.note_dir .. filename .. ".md")
end

function M.next()
    local y, m, d = vim.fn.expand("%:t:r"):match("(%d%d%d%d)-?(%d?%d?)-?(%d?%d?)$")
    local day = 24 * 60 * 60
    local filename
    if (y == nil or m == nil or d == nil) then
        filename = os.date("%Y-%m-%d", os.time() + day)
    else
        local current_time = os.time({ year = y, month = m, day = d })
        filename = os.date("%Y-%m-%d", current_time + day)
    end
    vim.cmd("e" .. config.note_dir .. filename .. ".md")
end

function M.prev()
    local y, m, d = vim.fn.expand("%:t:r"):match("(%d%d%d%d)-?(%d?%d?)-?(%d?%d?)$")
    local day = 24 * 60 * 60
    local filename
    if (y == nil or m == nil or d == nil) then
        filename = os.date("%Y-%m-%d", os.time() - day)
    else
        local current_time = os.time({ year = y, month = m, day = d })
        filename = os.date("%Y-%m-%d", current_time - day)
    end
    vim.cmd("e" .. config.note_dir .. filename .. ".md")
end

return M
