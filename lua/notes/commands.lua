local M = {}

function M.setup()
    vim.cmd [[command! -nargs=* Note lua require("notes").open(<f-args>)]]
    vim.cmd [[command! NoteToday lua require("notes").today()]]
    vim.cmd [[command! NoteNext lua require("notes").change_day(1)]]
    vim.cmd [[command! NotePrev lua require("notes").change_day(-1)]]
    vim.cmd [[command! NoteSync lua require("notes").sync()]]
end

return M
