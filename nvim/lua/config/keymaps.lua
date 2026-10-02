local snacks = require("snacks")
local wk = require("which-key")
local tca = require("tiny-code-action")
local lazydocker = require("lazydocker")

local keymaps = {
	-- Vim maps
	{
		"a",
		"i",
		mode = "n",
		desc = "Insert left (like i)",
	},
	{
		"aa",
		function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
			vim.lsp.buf.format()
			vim.cmd("w")
			snacks.notify.info("File saved")
		end,
		mode = "i",
		desc = "Save & exit insert mode",
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
		desc = "Toggle zen mode",
	},
	-- Top Picks & Explorer
	{
		"<leader>e",
		function()
			if vim.bo.filetype == "snacks_dashboard" then
				vim.cmd("enew")
			end
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
		"<leader>fn",
		":bn<CR>",
		desc = "Next file",
		icon = "󱨽",
	},
	{
		"<leader>fp",
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
		icon = "󰺮",
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
		icon = "󰈔",
	},
	{
		"<leader>si",
		function()
			snacks.picker.icons()
		end,
		desc = "Find icons",
		icon = "",
	},
	{
		"<leader>sw",
		function()
			vim.ui.input({ prompt = "Web search: " }, function(input)
				if input == nil or input == "" then
					return
				end
				vim.ui.open("https://www.google.com/search?q=" .. vim.uri_encode(input))
			end)
		end,
		desc = "Web search",
		icon = "󰖟",
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
		icon = "󰁨",
	},
	{
		"<leader>lf",
		vim.lsp.buf.format,
		desc = "Format",
		icon = "󰉿",
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
		icon = "󰋚",
	},

	-- Scratch / Notes
	{
		"<leader>n",
		function()
			snacks.scratch()
		end,
		desc = "Edit note",
		icon = "󰚸",
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
	{
		"<leader>tt",
		function()
			snacks.terminal.toggle(nil, {
				win = {
					position = "float",
					width = 0.8,
					height = 0.8,
					border = "rounded",
				},
				interactive = true,
				start_insert = true,
				auto_insert = true,
			})
			vim.schedule(function()
				if vim.bo.filetype == "snacks_terminal" then
					vim.cmd("startinsert")
				end
			end)
		end,
		mode = { "n", "t" },
		desc = "Floating terminal",
		icon = "",
	},
	{
		"qq",
		function()
			vim.cmd("stopinsert")
			vim.cmd("hide")
		end,
		mode = "t",
		desc = "Hide terminal (keep session)",
	},

	-- AI
	{
		"<leader>a",
		group = "AI",
		icon = "",
	},
	{
		"<leader>aa",
		function()
			require("utils.ai").ask()
		end,
		desc = "One-shot question",
		icon = "󰫢",
	},
	{
		"<leader>ar",
		function()
			require("utils.ai").refactor_file()
		end,
		desc = "Refactor file",
		icon = "󰉿",
	},
	{
		"<leader>af",
		function()
			require("utils.ai").fix_file()
		end,
		desc = "Fix file problems",
		icon = "󰁨",
	},
	{
		"<leader>ac",
		function()
			if vim.fn.executable("tmux") == 1 and vim.env.TMUX then
				vim.fn.jobstart({ "tmux", "select-window", "-t", "dev:ai" }, { detach = true })
			else
				snacks.notify.warn("Not in tmux", { title = "Chat" })
			end
		end,
		desc = "Go to chat",
		icon = "󰋚",
	},

	-- Music
	{
		"<leader>m",
		group = "Music",
		icon = "󰎆",
	},
	{
		"<leader>mh",
		function()
			vim.system({ "media-control", "previous-track" })
		end,
		desc = "Previous track",
		icon = "󱨻",
	},
	{
		"<leader>mp",
		function()
			vim.system({ "media-control", "toggle-play-pause" })
		end,
		desc = "Play / pause",
		icon = "󰏤",
	},
	{
		"<leader>ml",
		function()
			vim.system({ "media-control", "next-track" })
		end,
		desc = "Next track",
		icon = "󱨽",
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
		desc = "Save & quit all",
		icon = "󱣪",
	},
	{
		"<leader>qq",
		":qa!<CR>",
		desc = "Quit without saving",
		icon = "󰜺",
	},
}

wk.add(keymaps)
