local snacks = require("snacks")
local wk = require("which-key")
local tca = require("tiny-code-action")
local lazydocker = require("lazydocker")

local keymaps = {
	-- Vim maps
	{
		"aa",
		function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
			vim.lsp.buf.format()
			vim.cmd("w")
			snacks.notify.info("File saved")
		end,
		mode = "i",
		desc = "Exit insert mode",
	},
	{
		"<C-s>",
		function()
			vim.lsp.buf.format()
			vim.cmd("w")
		end,
		desc = "Save file",
	},
	{
		"<C-z>",
		function()
			snacks.zen.zoom()
		end,
		desc = "Show/hide explorer",
	},
	-- Top Picks & Explorer
	{
		"<leader>e",
		function()
			local explorerWin = snacks.picker.get({ source = "explorer" })[1]
			if explorerWin == nil then
				snacks.picker.explorer()
			elseif explorerWin:is_focused() then
				vim.cmd("b#")
			else
				snacks.picker.explorer()
				snacks.picker.explorer()
			end
		end,
		desc = "Toggle explorer",
		icon = "󰙅",
	},
	{
		"<leader>:",
		function()
			snacks.picker.command_history()
		end,
		desc = "Command history",
		icon = "󰋚",
	},

	-- File
	{
		"<leader>f",
		group = "File",
		icon = "󰈔",
	},
	{
		"<leader>fg",
		":bn<CR>",
		desc = "Next file",
		icon = "󱨽",
	},
	{
		"<leader>fd",
		":bp<CR>",
		desc = "Prev file",
		icon = "󱨻",
	},
	{
		"<leader>fc",
		function()
			snacks.bufdelete()
		end,
		desc = "Close file",
		icon = "󰮘",
	},
	{
		"<leader>fr",
		function()
			snacks.rename.rename_file()
		end,
		desc = "Rename file",
		icon = "󱇧",
	},

	-- Search
	{
		"<leader>s",
		group = "Search",
	},
	{
		"<leader>sc",
		function()
			snacks.picker.lines()
		end,
		desc = "Search in file",
		icon = "󰺮",
	},
	{
		"<leader>sg",
		function()
			snacks.picker.grep()
		end,
		desc = "Grep",
		icon = "󱎸",
	},
	{
		"<leader>sf",
		function()
			snacks.picker.files()
		end,
		desc = "Find files",
		icon = "󰱼",
	},
	{
		"<leader>sr",
		function()
			snacks.picker.recent()
		end,
		desc = "Recent files",
		icon = "󰱼",
	},
	{
		"<leader>si",
		function()
			snacks.picker.icons()
		end,
		desc = "Find icons",
		icon = "",
	},

	-- LSP
	{
		"<leader>l",
		group = "LSP",
		icon = "󰒋",
	},
	{
		"<leader>lc",
		function()
			tca.code_action()
		end,
		desc = "Code action",
	},
	{
		"<leader>lf",
		vim.lsp.buf.format,
		desc = "Format",
	},
	{
		"<leader>lh",
		vim.lsp.buf.hover,
		desc = "Hover",
		icon = "󰙎",
	},
	{
		"<leader>lg",
		vim.lsp.buf.definition,
		desc = "Go to definition",
		icon = "󰬲",
	},
	{
		"<leader>ld",
		function()
			snacks.picker.diagnostics_buffer()
		end,
		desc = "Diagnostics",
	},

	-- Scratch / Notes
	{
		"<leader>n",
		group = "Note",
		icon = "󰚸",
	},
	{
		"<leader>na",
		function()
			snacks.scratch()
		end,
		desc = "New note",
		icon = "󰎜",
	},
	{
		"<leader>nl",
		function()
			snacks.scratch.select()
		end,
		desc = "List notes",
		icon = "󱙓",
	},

	-- Package managers
	{
		"<leader>p",
		group = "Package managers",
		icon = "󰏗",
	},
	{
		"<leader>pl",
		":Lazy<CR>",
		desc = "Lazy",
		icon = "󰒲",
	},
	{
		"<leader>pm",
		":Mason<CR>",
		desc = "Mason",
		icon = "󱁤",
	},
	{
		"<leader>pt",
		":TSModuleInfo<CR>",
		desc = "Treesitter",
		icon = "󰚔",
	},

	-- Tools
	{
		"<leader>t",
		group = "Tools",
		icon = "󱁤",
	},
	{
		"<leader>tg",
		function()
			snacks.lazygit()
		end,
		desc = "Git",
	},
	{
		"<leader>ts",
		":LazySql<CR>",
		desc = "SQL",
		icon = "󰆼",
	},
	{
		"<leader>td",
		function()
			lazydocker.toggle({ engine = "docker" })
		end,
		desc = "Docker",
		icon = "󰡨",
	},

	-- Save & Exit
	{
		"<leader>q",
		group = "Exit",
		icon = "󰈆",
	},
	{
		"<leader>qw",
		function()
			vim.lsp.buf.format()
			vim.cmd("wqa")
		end,
		desc = "Save",
		icon = "󱣪",
	},
	{
		"<leader>qq",
		":qa!<CR>",
		desc = "Force",
		icon = "󰜺",
	},
}

wk.add(keymaps)
