return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        lazy = false,
        opts = {
            flavour = 'mocha',
            transparent_background = true,
        },
        config = function(_, opts)
            require('catppuccin').setup(opts)
        end,
    },
}
