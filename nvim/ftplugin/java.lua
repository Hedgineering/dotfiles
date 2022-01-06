-- Thank You BitInByte! https://youtu.be/94IU4cBdhfM and https://github.com/BitInByte/.dotfiles/blob/main/nvim/ftplugin/java.lua
-- Keymaps at bottom of file

-- Doing a protected call for jdtls to prevent broken config
local jdtls_status_ok, jdtls = pcall(require, "jdtls")
if not jdtls_status_ok then
  print("Could not require jdtls")
  return
end

-- Doing a protected call for jdtls_setup to prevent broken config
local jdtls_setup_status_ok, jdtls_setup = pcall(require, "jdtls.setup")
if not jdtls_setup_status_ok then
  print("Could not require jdtls_setup")
  return
end

-- Doing a protected call for cmp_nvim_lsp to prevent broken config
local cmp_status_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
  print("Could not require cmp_nvim_lsp")
  return
end

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_lsp.update_capabilities(capabilities)

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀 [x]
    'java', -- or '/path/to/java11_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.langALL-UNNAMED',

    -- 💀 [x]
    '-jar', '/Users/rahulhegde/Library/Java/jdt-language-server-1.7.0/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
         -- Must point to the                                                     Change this to
         -- eclipse.jdt.ls installation                                           the actual version


    -- 💀 [x]
    '-configuration', '/Users/rahulhegde/Library/Java/jdt-language-server-1.7.0/config_mac',
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    -- Builds a workspace_dir for any given workspace you're working on and puts in ~/.cache folder
    '-data', vim.fn.expand('~/.cache/jdtls-workspace') .. workspace_dir,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = jdtls_setup.find_root({'.git', 'mvnw', 'gradlew'}),
  capabilities = capabilities,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  -- settings = {
  --   java = {
  --   }
  -- },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  -- init_options = {
  --   bundles = {}
  -- },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

-- Doing a protected call for lspsignature to prevent broken config
local lspsignature_status_ok, lspsignature = pcall(require, "lsp_signature")
if not lspsignature_status_ok then
  print("Could not require lsp_signature")
  return
end

lspsignature.on_attach()

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', 'gD',          '<cmd>lua vim.lsp.buf.declaration()<CR>',                                 opts)
vim.api.nvim_set_keymap('n', 'gd',          '<cmd>lua vim.lsp.buf.definition()<CR>',                                  opts)
vim.api.nvim_set_keymap('n', 'K',           '<cmd>lua vim.lsp.buf.hover()<CR>',                                       opts)
vim.api.nvim_set_keymap('n', 'gi',          '<cmd>lua vim.lsp.buf.implementation()<CR>',                              opts)
vim.api.nvim_set_keymap('n', '<C-k>',       '<cmd>lua vim.lsp.buf.signature_help()<CR>',                              opts)
vim.api.nvim_set_keymap('n', '<leader>jwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                        opts)
vim.api.nvim_set_keymap('n', '<leader>jwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                     opts)
vim.api.nvim_set_keymap('n', '<leader>jwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',  opts)
vim.api.nvim_set_keymap('n', '<leader>jD',  '<cmd>lua vim.lsp.buf.type_definition()<CR>',                             opts)
vim.api.nvim_set_keymap('n', '<leader>jrn', '<cmd>lua vim.lsp.buf.rename()<CR>',                                      opts)
vim.api.nvim_set_keymap('n', 'gr',          '<cmd>lua vim.lsp.buf.references()<CR>',                                  opts)
vim.api.nvim_set_keymap('n', '<leader>je',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',                opts)
vim.api.nvim_set_keymap('n', '[d',          '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',                            opts)
vim.api.nvim_set_keymap('n', ']d',          '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',                            opts)
vim.api.nvim_set_keymap('n', '<leader>jq',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',                          opts)
vim.api.nvim_set_keymap('n', '<leader>jf',  '<cmd>lua vim.lsp.buf.formatting()<CR>',                                  opts)
vim.api.nvim_set_keymap('n', '<leader>jlg', '<cmd>lua vim.lsp.buf.formatting_sync(nil, 1000)<CR>',                    opts)
vim.api.nvim_set_keymap('n','<leader>jlA',  '<cmd>lua vim.lsp.buf.code_action()<CR>',                    { silent = true })

