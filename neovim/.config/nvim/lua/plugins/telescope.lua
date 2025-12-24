return {
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.2.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        end,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        opts = {
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                    
                    }
                },
            },
        },
        config = function()
            require("telescope").load_extension("ui-select") 
        end,
    },
}
