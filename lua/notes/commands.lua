local M = {}

function M.setup()
    vim.api.nvim_create_user_command(
        "Note",
        function(opts)
            require("notes").open(opts.fargs[1])
        end, {
            nargs = "?",
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

return M
