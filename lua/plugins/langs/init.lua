local plugins = {
}

local langs = {
    'csharp',
    'gdscript',
    'hlsl',
    'kotlin',
    'renpy',
    'rust',
    'wgsl',
}

for _, lang in ipairs(langs) do
    for _, lang_plugin in ipairs(require('plugins.langs.' .. lang)) do
        table.insert(plugins, lang_plugin)
    end
end

return plugins
