local config = {
    note_dir = nil,
    git_remote = nil,
    debug = false,
}

function config.extend_config(user_config)
    new_config = vim.tbl_deep_extend("force", config, user_config)
    for key, value in pairs(new_config) do
        config[key] = value
    end
end

return config
