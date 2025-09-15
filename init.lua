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
vim.diagnostic.config({
	virtual_text = true,
})

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
	use("windwp/nvim-ts-autotag")

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
					typescript = { "prettier" },
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

	-- AI support
	use({ "zbirenbaum/copilot.lua" })
	-- Avante.nvim with build process
	use({ "yetone/avante.nvim", branch = "main", run = "make" })
	use({
		"ravitemer/mcphub.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		cmd = { "MCPHub" }, -- Lazy load on command
		run = "npm install -g mcp-hub@latest",
		config = function()
			require("mcphub").setup()
		end,
	})

	-- Additional plugins
	use("tpope/vim-obsession")
	use("stevearc/dressing.nvim")
	use("MunifTanjim/nui.nvim")
	use("MeanderingProgrammer/render-markdown.nvim")

	-- Language-specific plugins
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
	mapping = require("cmp").mapping.preset.insert({
		["<C-b>"] = require("cmp").mapping.scroll_docs(-4),
		["<C-f>"] = require("cmp").mapping.scroll_docs(4),
		["<C-Space>"] = require("cmp").mapping.complete(),
		["<C-e>"] = require("cmp").mapping.abort(),
		["<CR>"] = require("cmp").mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
})

-- -- Flutter tools settings
-- require("flutter-tools").setup({}) -- use defaults

-- Treesitter settings
require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go", "python" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},
})

-- Git signs settings
require("gitsigns").setup()

-- Git blame settings
vim.keymap.set("n", "<A-b>", ":BlameToggle<CR>")

-- Copilot settings
require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		hide_during_completion = true,
		debounce = 75,
		trigger_on_accept = true,
		keymap = {
			accept = "<Tab>",
			accept_word = false,
			accept_line = false,
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
})

-- Avente.nvim settings
local avante_settings = {
	provider = "ollama",
	providers = {
		ollama = {
			endpoint = "http://localhost:11434",
			model = "deepseek-coder:6.7b-instruct",
		},
	},
}
require("avante").setup(avante_settings)

-- Autotag setting
require("nvim-ts-autotag").setup({
	opts = {
		-- Defaults
		enable_close = true, -- Auto close tags
		enable_rename = true, -- Auto rename pairs of tags
		enable_close_on_slash = false, -- Auto close on trailing </
	},
})

-- Formatting settings
-- Telescope key mappings
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-f>", telescope_builtin.find_files)
vim.keymap.set("n", "<C-g>", telescope_builtin.live_grep)
vim.keymap.set("n", "<C-b>", telescope_builtin.buffers)
vim.keymap.set("n", "<C-h>", telescope_builtin.help_tags)
