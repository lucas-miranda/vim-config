
lua <<EOF
local cfg = {
    hint_prefix = "🦝 "
}

require('lsp_signature').setup(cfg)
EOF
