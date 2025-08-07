--misc options
vim.g.have_nerd_font = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.splitright = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.scrolloff = 8 -- min screen lines to keep above and below cursor
vim.opt.clipboard = 'unnamedplus'
vim.opt.numberwidth = 7
vim.opt.mouse = nvi
vim.opt.smartcase = true
vim.opt.breakindent = true --[[Every wrapped line will continue visually indented
(same amount of space as the beginning of that line),
thus preserving horizontal blocks of text. ]] --

--tab stuff
vim.opt.tabstop = 4
vim.opt.softtabstop = 4 
vim.opt.shiftwidth = 4 
vim.opt.expandtab = true 

require("config.lazy")
vim.cmd [[colorscheme vscode]]

-- greatest remap ever
vim.keymap.set("x", "<leader>p", "\"_dP")

--neotree
vim.keymap.set("n", "\\", ":Neotree toggle<CR>", { noremap = true, silent = true }) 

--window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--highlight when yanking text
--'yap' in normal mode
--see ':help vim.highlight.on_yank()'
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--highlight go away when pressing escape in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>v", "<cmd>vsp<CR>")

require("config.lsp.lsp_init")

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.c"},
    callback = function()
        vim.opt.makeprg = "build.bat"
    end,
})

-- make related stuff

vim.opt.shellpipe = "2>&1 >"
vim.keymap.set("n", "<leader>b", "<cmd>make<cr>")
vim.keymap.set("n", "<leader>qf", function()
    local qf_open = false
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            qf_open = 1
            break
        end
    end
    if qf_open then
        vim.cmd("cclose")
    else
        -- Save all open buffers
        vim.cmd("wall")

        -- Close all other windows (leave only one)
        vim.cmd("only")

        -- Open quickfix list and jump to first entry
        vim.cmd("copen")
        if vim.fn.getqflist({ size = 0 }).size > 0 then
            vim.cmd("cc")  -- Jump to first quickfix entry
        else
            print("Quickfix list is empty.")
            return
        end
    end
end)

-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--     pattern = {"*.go"},
--     callback = function()
--         vim.opt.makeprg = "go build"
--     end,
-- })
--
--
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.go",
--     callback = function()
--         vim.fn.setqflist({}) -- clear old list
--         vim.fn.system("go vet ./...")
--
--         -- Parse output and fill quickfix
--         vim.cmd("cgetexpr systemlist('go vet ./...')")
--
--         -- open QF if errors
--         if vim.fn.getqflist({ size = 0 }).size > 0 then
--             vim.cmd("copen")
--             vim.cmd("cc 1")
--             pcall(vim.treesitter.stop)
--             pcall(vim.treesitter.start)
--         else
--             vim.cmd("cclose")
--         end
--     end,
-- })
--
