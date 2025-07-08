------------
-- Config --
------------

local default_options = {
    lazy = false,
    priority = 1000,
}

local themes = {
    -- * Dark
    purple_martin = {
        'lucas-miranda/vim-purple-martin',
        dev = true,
    },
    moonfly = 'bluz71/vim-moonfly-colors',
    zephyr = 'nvimdev/zephyr-nvim',
    bluloco = {
        'uloco/bluloco.nvim',
        dependencies = { 'rktjmp/lush.nvim' },
    },
    bamboo = 'ribru17/bamboo.nvim',
}

local theme = 'bamboo'

---

local apply_theme = function (theme_name)
    local theme = themes[theme_name]

    if type(theme) == "string" then
        theme = {
            theme,
        }
    elseif type(theme) ~= "table" then
        -- type unhandled
        return {}
    end

    print(theme[1])

    -- insert default options values (if they're not defined already)
    for opt_name, opt_value in pairs(default_options) do
        if theme[opt_name] == nil then
            theme[opt_name] = opt_value
        end
    end

    if theme.name == nil then
        theme.name = theme_name
    end

    if theme.config == nil then
        theme.config = function()
            vim.cmd.colorscheme(theme_name)
        end
    end

    return theme
end

---

return {
    apply_theme(theme)
}
