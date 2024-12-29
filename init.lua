-- Basic settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.encoding = "utf-8"
vim.o.guifont = "Hack Nerd Font :h11"
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.fillchars = "vert:│"
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable syntax highlighting and file type detection
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Key mappings
vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")
vim.keymap.set("n", "<Up>", "gk")
vim.keymap.set("n", "<Down>", "gj")

-- Plugin management with Packer
require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Visual and UI improvements
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("nvim-lualine/lualine.nvim")
	use({ "akinsho/bufferline.nvim", requires = "nvim-tree/nvim-web-devicons" })
	use("karb94/neoscroll.nvim")
	use("lewis6991/gitsigns.nvim")
	use({
		"FabijanZulj/blame.nvim",
		lazy = false,
		config = function()
			require("blame").setup({})
		end,
	})

	-- Text editing enhancements
	use("tpope/vim-surround")
	use("tpope/vim-commentary")
	use("jiangmiao/auto-pairs")
	use("unblevable/quick-scope")
	use("tpope/vim-sensible")

	-- LSP and completion
	use("VonHeikemen/lsp-zero.nvim")
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use({
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					dart = { "dart_format", "dcm_format" },
					terraform = { "terraform_fmt" },
					tf = { "terraform_fmt" },
					["terraform-vars"] = { "terraform_fmt" },
				},
				format_on_save = {
					lsp_format = "fallback",
					timeout_ms = 2000,
				},
				log_level = vim.log.levels.ERROR,
				notify_on_error = true,
				notify_no_formatters = true,
			})
		end,
	})
	use("zapling/mason-conform.nvim")

	-- File navigation and search
	use("nvim-telescope/telescope.nvim")
	use("nvim-lua/plenary.nvim")
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
	})
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	})

	-- Treesitter for syntax highlighting
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- Additional plugins
	use("tpope/vim-obsession")
	use("github/copilot.vim")

	-- Language specific plugins
	use({
		"akinsho/flutter-tools.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
	})
	use("crispgm/nvim-go")
	use("lervag/vimtex")
end)

-- Colorscheme settings
vim.cmd.colorscheme("catppuccin-mocha")
vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NonText guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight LineNr guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight SignColumn guibg=NONE ctermbg=NONE]])

-- NvimTree settings
local function my_nvim_tree_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		}
	end

	-- Default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- Custom mappings
	vim.keymap.set("n", "R", api.fs.rename, opts("Rename"))
	vim.keymap.set("n", "C", api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "T", api.fs.create, opts("New file"))
	vim.keymap.set("n", "dd", api.fs.remove, opts("Delete"))
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close parent"))
	vim.keymap.set("n", "<CR>", api.tree.change_root_to_node, opts("Change root"))
	vim.keymap.set("n", "<BS>", api.tree.change_root_to_parent, opts("Change root to parent"))
end

require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 40,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
	on_attach = my_nvim_tree_on_attach,
})
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

-- Neoscroll settings
require("neoscroll").setup()

-- Lualine settings
require("lualine").setup({
	options = { theme = "catppuccin", icons_enabled = true },
	sections = { lualine_a = { "tabs" } },
})

-- Bufferline settings
require("bufferline").setup({})

-- LSP settings
local lsp_zero = require("lsp-zero")
lsp_zero.extend_lspconfig({
	sign_text = true,
	lsp_attach = function(client, bufnr)
		local opts = { buffer = bufnr }
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Zathura settings
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexmk"

-- Mason settings
require("mason").setup({
	ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } },
})
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "rust_analyzer" },
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
	},
})

-- Completion settings
require("cmp").setup({
	sources = { { name = "nvim_lsp" }, { name = "path" } },
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	mapping = require("cmp").mapping.preset.insert({}),
})

-- Flutter tools settings
require("flutter-tools").setup({}) -- use defaults

-- Treesitter settings
require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the listed parsers MUST always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go", "python" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

-- Git signs settings
require("gitsigns").setup()

-- Git blame settings
vim.keymap.set("n", "<A-b>", ":BlameToggle<CR>")

-- Formatting settings
-- Telescope key mappings
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-f>", telescope_builtin.find_files)
vim.keymap.set("n", "<C-g>", telescope_builtin.live_grep)
vim.keymap.set("n", "<C-b>", telescope_builtin.buffers)
vim.keymap.set("n", "<C-h>", telescope_builtin.help_tags)
