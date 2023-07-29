local commands = require("notes.commands")
local config = require("notes.config")
local logger = require("notes.logger")
local M = {}

local did_setup = false

function M.setup(user_config)
    if did_setup then
        return logger.info("Already did setup!")
    end
    did_setup = true

    if user_config ~= nil then
        config.extend_config(user_config)
    end

    if config.note_dir == nil then
        return logger.info("Note directory is nil!")
    end
    commands.setup()
end

function M.open(filename)
    if filename == nil then
        return vim.cmd.edit(config.note_dir)
    end
    vim.cmd.edit(config.note_dir .. filename .. ".md")
end

function M.today()
    local filename = os.date("%Y-%m-%d")
    vim.cmd.edit(config.note_dir .. filename .. ".md")
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
    vim.cmd.edit(config.note_dir .. filename .. ".md")
end

function M.sync()
    if config.git_remote == nil then
        return logger.error("Git remote not set!")
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
