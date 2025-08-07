local servers = {
	clangd = {
		cmd = { "clangd" },
		filetypes = { "c", "cpp" },
        root_markers = { ".git", "main.c", "main.cpp", ".clangd" }
	},
	pyright = {
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
        root_markers = { ".git", "main.py", "pyproject.toml" },
        settings = {
            python = {
                analysis = {
                    useLibraryCodeForTypes = true,
                },
            },
        },
	},
}

for name, config in pairs(servers) do
	vim.lsp.config(name, config)
	vim.lsp.enable(name)
end

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user.lsp", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        local function setkeymap(mode, keys, called_function)
            vim.keymap.set(mode, keys, called_function, { buffer = bufnr })
        end

        setkeymap('n', 'gd', vim.lsp.buf.definition)
        setkeymap('n', 'gr', vim.lsp.buf.references)
        setkeymap('n', 'K', vim.lsp.buf.hover)
        setkeymap('n', '<leader>rn', vim.lsp.buf.rename)

    end
})



