-- neovim configuration
-- author: michael scholz
-- email: m@scholz.moe

-- initialise the lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- set the leader key to the biggest key available
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- load packages
require("lazy").setup({
    -- colorscheme to match my system
    {
        "dracula/vim",
        lazy = false, -- don't lazy load colors
        priority = 1000,
        config = function ()
            vim.opt.termguicolors = true -- true color support
            vim.g.dracula_colorterm = 0 -- don't color the whole background
            vim.cmd [[colo dracula]]
        end
    },

    -- nicer status line
    {
        "nvim-lualine/lualine.nvim",
        config = function ()
            require("lualine").setup({
                options = {
                    theme = "dracula",
                    -- use text over icons throughout
                    icons_enabled = false,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = {
                        -- show only 'N' for normal, 'I' for insert, etc
                        { 'mode', fmt = function(str) return str:sub(1,1) end }
                    },
                    lualine_c = {
                        -- show the current file path relative to the project root
                        { 'filename', path = 1 },
                    },
                },
            })
        end,
    },

    -- easier commenting
    {
        'numToStr/Comment.nvim',
        config = function ()
            require('Comment').setup()
        end
    },

    -- LSP interface
    {
        "neovim/nvim-lspconfig",
        config = function ()
            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup {}
            lspconfig.tsserver.setup {}

            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            vim.api.nvim_create_autocmd('LspAttach', {
              group = vim.api.nvim_create_augroup('UserLspConfig', {}),
              callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function()
                  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<space>f', function()
                  vim.lsp.buf.format { async = true }
                end, opts)
              end,
            })
        end
    },

    -- LSP output viewing
    {
        "folke/trouble.nvim",
        config = function ()
            require("trouble").setup {
                icons = false,
                mode = "document_diagnostics",
                fold_open = "v", -- icon used for open folds
                fold_closed = ">", -- icon used for closed folds
                indent_lines = false, -- add an indent guide below the fold icons
                signs = {
                    -- icons / text used for a diagnostic
                    error = "error",
                    warning = "warn",
                    hint = "hint",
                    information = "info"
                },
                use_diagnostic_signs = false
            }
        end
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    'comment',
                    'lua',
                    'python',
                    'terraform',
                    'tsx',
                    'typescript',
                },
                indent = { enable = true },
                highlight = { enable = true },
            })
        end
    },

    -- utility functions for some packages
    {
        "nvim-lua/plenary.nvim",
    },

    -- a fast finder required(ish) for telescope
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'arch -arm64 make',
    },

    -- a file browser for telescope
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },

    -- fuzzy finder like fzf
    {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        config = function ()
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<esc>"] = require('telescope.actions').close,
                        },
                    },
                },
                extensions = {
                    fzf = {}
                },
            }
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('file_browser')
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fd', ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {})
            end
        },

        -- git signs in the gutter
        {
            'lewis6991/gitsigns.nvim',
            config = function ()
                require('gitsigns').setup {
                    signs = {
                        add          = { text = '▍' },
                        change       = { text = '▍' },
                        delete       = { text = '_' },
                        topdelete    = { text = '‾' },
                        changedelete = { text = '~' },
                        untracked    = { text = '┆' },
                    },
                }
            end
        },

        -- automagic completion
        {
            "github/copilot.vim",
            config = function ()
            end
        },

        -- an LSP server for stuff like formatting
        {
            "jose-elias-alvarez/null-ls.nvim",
            requires = {
                "nvim-lua/plenary.nvim",
                "neovim/nvim-lspconfig",
            },
            config = function ()
                local null_ls = require("null-ls")
                null_ls.setup({
                    sources = {
                        null_ls.builtins.formatting.black,
                    },
                })
            end
        },
    })

-- 4 spaces > tabs for me
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.wrap = true

-- except for typescript/javascript
vim.api.nvim_create_autocmd('FileType', {
    pattern = { "*" },
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft == "typescriptreact" then
            vim.opt.shiftwidth = 2
            vim.opt.tabstop = 2
        end
    end,
})
