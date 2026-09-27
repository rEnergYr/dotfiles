return {
	"nvim-treesitter/nvim-treesitter",
	name = "treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local parsers = {
			"lua",
			"rust",
			"javascript",
			"typescript",
			"tsx",
			"html",
			"css",
			"yaml",
			"hjson",
			"toml",
			"jsdoc",
			"dockerfile",
			"markdown",
			"markdown_inline",
		}

		require("nvim-treesitter").install(parsers)

		local filetypes = {
			"css",
			"dockerfile",
			"hjson",
			"html",
			"javascript",
			"jsdoc",
			"lua",
			"markdown",
			"rust",
			"toml",
			"typescript",
			"typescriptreact",
			"yaml",
		}

		local group = vim.api.nvim_create_augroup("treesitter", { clear = true })

		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = filetypes,
			callback = function(args)
				vim.treesitter.start(args.buf)
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
