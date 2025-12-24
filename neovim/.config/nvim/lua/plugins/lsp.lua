-- List all LSP servers here
local lsp_servers = { 'lua_ls', 'clangd', "ts_ls", "qmlls" }

return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = lsp_servers
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {},
        config = function(opts)
            for _, server in ipairs(lsp_servers) do
                vim.lsp.enable(server)
            end
        end,
    },
}
