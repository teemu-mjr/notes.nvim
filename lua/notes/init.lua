M = {}
local config = {}

function M.setup(user_config)
    config = user_config
    if config.note_dir == nil then
        return
    end
    M.make_commands()
end

function M.make_commands()
    vim.cmd [[command! -nargs=* Note lua require("notes").open(<f-args>)]]
    vim.cmd [[command! NoteToday lua require("notes").today()]]
    vim.cmd [[command! NoteNext lua require("notes").change_day(1)]]
    vim.cmd [[command! NotePrev lua require("notes").change_day(-1)]]
    vim.cmd [[command! NoteSync lua require("notes").sync()]]
end

function M.open(filename, _)
    if filename == nil then
        return vim.cmd("e" .. config.note_dir)
    end
    vim.cmd("e" .. config.note_dir .. filename .. ".md")
end

function M.today()
    local filename = os.date("%Y-%m-%d")
    vim.cmd("e" .. config.note_dir .. filename .. ".md")
end

function M.change_day(amount)
    local y, m, d = vim.fn.expand("%:t:r"):match("(%d%d%d%d)-?(%d?%d?)-?(%d?%d?)$")
    local change_amount = (24 * 60 * 60) * amount
    local filename
    if (y == nil or m == nil or d == nil) then
        filename = os.date("%Y-%m-%d", os.time() + change_amount)
    else
        local current_time = os.time({ year = y, month = m, day = d })
        filename = os.date("%Y-%m-%d", current_time + change_amount)
    end
    vim.cmd("e" .. config.note_dir .. filename .. ".md")
end

function M.sync()
    if config.git_remote == nil then
        return print("Git remote not set")
    end

    vim.cmd(
        "!cd " .. config.note_dir .. " ;" ..
        "git pull;" ..
        "git add .;" ..
        "git commit -m 'sync';" ..
        "git push;"
    )
end

return M
