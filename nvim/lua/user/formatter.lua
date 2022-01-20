-- used with prettierd formatter from npm for now
-- see https://github.com/fsouza/prettierd#supported-languages--plugins
-- see https://github.com/mhartington/formatter.nvim

-- You can provide a default configuration for the prettier via 
-- setting the environment variable PRETTIERD_DEFAULT_CONFIG to 
-- the exact path of the prettier configuration file.

-- ex: 
-- in your .env file you have 
-- PRETTIERD_DEFAULT_CONFIG=~/Documents/projects/web/js/ts/basics/.prettierrc.json
--
-- OR
--
-- PRETTIERD_DEFAULT_CONFIG=$HOME/.config/.prettierrc.json
--
-- If for some reson the .env setting does not seem to be taking effect, kill the prettierd process
-- and then try to reformat (or close/reopen your file to restart the prettierd process)
--
-- ps aux | grep prettierd
-- kill <process number>

-- The config json is the same as the original prettier (see https://prettier.io/docs/en/configuration.html)

-- Doing a protected call for formatter to prevent broken config
local formatter_status_ok, formatter = pcall(require, "formatter")
if not formatter_status_ok then
  print("Could not require formatter")
  return
end

formatter.setup({
  logging = false,
  filetype = {
  -- Whenever you update this for a new filetype, be sure to update the autocommand below
    typescript = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
    typescriptreact = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
    javascript = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
    javascriptreact = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
    lua = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
    rust = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
    java = {
      -- prettier
			function()
				return {
					exe = "prettier",
          args = {vim.api.nvim_buf_get_name(0)},
					stdin = true,
				}
			end
		},
    -- other formatters ...
  }
})

-- Auto Command to Format on Save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  echo "running autocmd"
  autocmd BufWritePost *.ts,*.tsx,*.js,*.jsx,*.lua,*.rs FormatWrite
augroup END
]], true)
