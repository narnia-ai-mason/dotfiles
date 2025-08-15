return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
			ensure_installed = {
				"basedpyright",
				"svelte",
				"lua_ls",
				"tailwindcss",
				"eslint",
				"html",
				"cssls",
				"jsonls",
			},
			handlers = {
				-- Prevent pyright from being auto-configured since we use basedpyright
				["pyright"] = function() end,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_nvim_lsp.default_capabilities()
			)

			local lspconfig = require("lspconfig")

			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.ruby_lsp.setup({
				capabilities = capabilities,
				cmd = { "/home/typecraft/.asdf/shims/ruby-lsp" },
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			-- Python LSP with basedpyright
			local function get_python_path(workspace)
				-- Try .venv in workspace
				local venv_path = workspace .. "/.venv"
				if vim.fn.isdirectory(venv_path) == 1 then
					if vim.fn.has("win32") == 1 then
						return venv_path .. "/Scripts/python.exe"
					else
						return venv_path .. "/bin/python"
					end
				end

				-- Try poetry
				local handle = io.popen("cd " .. workspace .. " && poetry env info -p 2>/dev/null")
				if handle then
					local poetry_path = handle:read("*a"):gsub("%s+", "")
					handle:close()
					if poetry_path and poetry_path ~= "" then
						local poetry_python = poetry_path .. (vim.fn.has("win32") == 1 and "/Scripts/python.exe" or "/bin/python")
						if vim.fn.executable(poetry_python) == 1 then
							return poetry_python
						end
					end
				end

				-- Try conda
				local conda_env = os.getenv("CONDA_DEFAULT_ENV")
				if conda_env and conda_env ~= "base" then
					local conda_python = os.getenv("CONDA_PREFIX") .. (vim.fn.has("win32") == 1 and "/python.exe" or "/bin/python")
					if vim.fn.executable(conda_python) == 1 then
						return conda_python
					end
				end

				-- Fallback to system python
				return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
			end

			lspconfig.basedpyright.setup({
				capabilities = capabilities,
				on_new_config = function(config, root_dir)
					local python_path = get_python_path(root_dir)
					config.settings.python = config.settings.python or {}
					config.settings.python.pythonPath = python_path
					
					-- Debug: print detected Python path
					vim.notify("BasedPyright using Python: " .. python_path, vim.log.levels.INFO)
				end,
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "standard",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							autoImportCompletions = true,
						},
					},
					python = {
						pythonPath = get_python_path(vim.fn.getcwd()),
						analysis = {
							extraPaths = {},
						},
					},
				},
			})

			-- Svelte LSP
			lspconfig.svelte.setup({
				capabilities = capabilities,
				settings = {
					svelte = {
						plugin = {
							html = { completions = { enable = true, emmet = false } },
							svelte = { completions = { enable = true, emmet = true } },
							css = { completions = { enable = true, emmet = true } },
						},
					},
				},
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
		end,
	},
}
