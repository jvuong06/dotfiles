return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
        config = function()
            require("blink.cmp").setup {
                completion = {
                    menu = {
                        draw = {
                            components = {
                                -- customize the drawing of kind icons
                                kind_icon = {
                                    text = function(ctx)
                                        -- default kind icon
                                        local icon = ctx.kind_icon
                                        -- if LSP source, check for color derived from documentation
                                        if ctx.item.source_name == "LSP" then
                                            local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                                            if color_item and color_item.abbr ~= "" then
                                                icon = color_item.abbr
                                            end
                                        end
                                        return icon .. ctx.icon_gap
                                    end,
                                    highlight = function(ctx)
                                        -- default highlight group
                                        local highlight = "BlinkCmpKind" .. ctx.kind
                                        -- if LSP source, check for color derived from documentation
                                        if ctx.item.source_name == "LSP" then
                                            local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                                            if color_item and color_item.abbr_hl_group then
                                                highlight = color_item.abbr_hl_group
                                            end
                                        end
                                        return highlight
                                    end,
                                },
                            },
                        },
                    },
                },
            } 
        end,
        opts_extend = { "sources.default" }
    },
}
