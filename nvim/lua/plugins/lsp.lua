return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            -- local lspconfig = require('lspconfig')
            -- lspconfig.lua_ls.setup {}
            -- lspconfig.gopls.setup {}
            vim.lsp.enable('lua_ls', 'gopls', 'eslint')
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {'vim'}
                        }
                    }
                }
            })
            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local opts = { buffer = ev.buf }

                    vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
                    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    -- vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<Leader>la', vim.lsp.buf.code_action, opts)
                    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    
                    vim.keymap.set('n', '<Leader>lf',
                        function() vim.lsp.buf.format { async = true } end, opts)
                end
            })
        end
    }
}
