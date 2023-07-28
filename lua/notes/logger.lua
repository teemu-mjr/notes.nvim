local config = require("notes.config")
local M = {}

function M.info(msg)
    print(msg)
end

function M.error(msg)
    print("[ERROR] " .. msg)
end

function M.debug(msg)
    if config.debug then
        print("[DEBUG]" .. msg)
    end
end

return M
