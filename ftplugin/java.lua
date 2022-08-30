vim.opt_local.shiftwidth = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.cmdheight = 2 -- more space in the neovim command line for displaying messages


local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

-- Determine OS
local home = os.getenv "HOME"
WORKSPACE_PATH = home .. "/workspace/"
CONFIG = "linux"

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name



-- This bundles definition is the same as in the previous section (java-debug installation)
local bundles = {
	vim.fn.glob(home ..
		"/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
};

-- This is the new part
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.config/nvim/vscode-java-test/server/*.jar"), "\n"))



-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		-- 💀
		"java", -- or '/path/to/java11_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. home .. "/.local/share/nvim/lsp_servers/jdtls/lombok.jar",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version

		-- 💀
		"-configuration",
		home .. "/.local/share/nvim/lsp_servers/jdtls/config_" .. CONFIG,
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	},


	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = root_dir,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- or https://github.com/redhat-developer/vscode-java#supported-vs-code-settings
	-- for a list of options

	flags = {
		allow_incremental_sync = true,
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		-- bundles = {},
		bundles = bundles
	},
	on_attach = function(client, bufnr)
		-- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
		-- you make during a debug session immediately.
		-- Remove the option if you do not want that.
		require('jdtls').setup_dap({ hotcodereplace = 'auto' })
		require('jdtls.dap').setup_dap_main_class_configs()
	end
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)


vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
-- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap("n", "<leader>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
keymap("n", "<leader>jv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
keymap("n", "<leader>jc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
keymap("n", "<leader>jt", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
keymap("n", "<leader>jT", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
keymap("n", "<leader>ju", "<Cmd>JdtUpdateConfig<CR>", opts)
keymap("n", "<F4>", "<Cmd>JdtCompile full<CR>", opts)

keymap("v", "<leader>jv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
keymap("v", "<leader>jc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
keymap("v", "<leader>jm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)



keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)

keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
