--[[
  Module: ai
  Description: AI-assisted actions powered by the GitHub Copilot CLI.
               Runs Copilot in non-interactive mode as an async job,
               shows a spinner notification while it works, then
               reloads the file and turns the notification into a check.

  Usage:
    local ai = require("utils.ai")
    ai.refactor_file()
    ai.fix_file()
    ai.ask()

  Functions:
    refactor_file() : nil
      Asks Copilot to refactor the current file in place
      (cleaner code, same behavior) and reloads it when done.
    fix_file() : nil
      Asks Copilot to fix only the current file's diagnostics.
      Does nothing when there is nothing to fix.
    ask() : nil
      Asks an open question via vim.ui.input, shows a floating
      window with a spinner, then either applies file edits
      (and reloads) or displays the short answer below
      the question.
--]]

local M = {}

local running = false
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

local function format_buf_safely(bufnr)
	if bufnr == nil or not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end
	local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/formatting" })
	if clients == nil or #clients == 0 then
		return
	end
	-- Deferred + async: lets the LSP settle after edit! and avoids
	-- blocking the UI / noisy timeout notif on slow servers.
	vim.defer_fn(function()
		if not vim.api.nvim_buf_is_valid(bufnr) then
			return
		end
		pcall(vim.lsp.buf.format, { bufnr = bufnr, timeout_ms = 3000, async = true })
	end, 300)
end

local function get_notifier()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks and snacks.notifier then
		return snacks.notifier
	end
	return nil
end

-- Common guards + save. Returns the file path, or nil (with a
-- notification) when there is nothing to run Copilot for.
local function prepare()
	if running then
		vim.notify("Copilot task already running", vim.log.levels.WARN, { title = "Copilot" })
		return nil
	end
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" or vim.bo.buftype ~= "" then
		vim.notify("No file to process", vim.log.levels.WARN, { title = "Copilot" })
		return nil
	end
	if vim.fn.executable("copilot") ~= 1 then
		vim.notify("copilot CLI not found", vim.log.levels.ERROR, { title = "Copilot" })
		return nil
	end
	vim.cmd("silent write")
	running = true
	return path
end

-- Runs Copilot on `path` with `prompt`, shows a spinner while it works,
-- reloads the file on success. `done_msg` / `noop_msg` are suffixed
-- with the file name based on whether the file changed.
local function run_copilot_job(path, prompt, done_msg, noop_msg)
	local mtime_before = vim.fn.getftime(path)
	local fname = vim.fn.fnamemodify(path, ":t")
	local cwd = vim.fn.fnamemodify(path, ":h")

	local notifier = get_notifier()
	local notif_id = "copilot-task"
	if notifier then
		notifier.notify("⠋ Working on " .. fname .. "…", "info", { id = notif_id, title = "Copilot", timeout = false })
	end

	local frame = 0
	local timer = (vim.uv or vim.loop).new_timer()
	timer:start(0, 120, function()
		frame = frame + 1
		local spin = spinner_frames[(frame % #spinner_frames) + 1]
		vim.schedule(function()
			if notifier then
				notifier.notify(spin .. " Working on " .. fname .. "…", "info", {
					id = notif_id,
					title = "Copilot",
					timeout = false,
				})
			end
		end)
	end)

	local errors = {}

	vim.fn.jobstart({ "copilot", "-p", prompt, "-s", "--model", "auto", "--allow-all-tools" }, {
		cwd = cwd,
		stdout_buffered = true,
		stderr_buffered = true,
		on_stderr = function(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(errors, line)
				end
			end
		end,
		on_exit = function(_, code)
			vim.schedule(function()
				running = false
				if not timer:is_closing() then
					timer:stop()
					timer:close()
				end
				if code ~= 0 then
					local detail = errors[#errors] or ("exit code " .. code)
					if notifier then
						notifier.notify("✗ Task failed: " .. detail, "error", {
							id = notif_id,
							title = "Copilot",
							timeout = 5000,
						})
					else
						vim.notify("Task failed: " .. detail, vim.log.levels.ERROR, { title = "Copilot" })
					end
					return
				end
				if vim.api.nvim_buf_get_name(0) == path and vim.bo.modified then
					if notifier then
						notifier.notify("✓ Copilot finished, but the buffer has unsaved changes (:e! to load)", "warn", {
							id = notif_id,
							title = "Copilot",
							timeout = 5000,
						})
					end
					return
				end
				if vim.api.nvim_buf_get_name(0) == path then
					vim.cmd("edit!")
				end
				format_buf_safely(vim.api.nvim_get_current_buf())
				local msg = done_msg .. fname
				if vim.fn.getftime(path) == mtime_before then
					msg = noop_msg .. fname
				end
				if notifier then
					notifier.notify("✓ " .. msg, "info", { id = notif_id, title = "Copilot", timeout = 3000 })
				else
					vim.notify(msg, vim.log.levels.INFO, { title = "Copilot" })
				end
			end)
		end,
	})
end

function M.refactor_file()
	local path = prepare()
	if not path then
		return
	end
	local prompt = "Refactor the file at "
		.. path
		.. " to be clean and idiomatic. Improve naming, structure and readability. "
		.. "Do NOT change its behavior, public API, or logic. "
		.. "Apply the edits directly to the file with your file tools."
	run_copilot_job(path, prompt, "Refactor applied: ", "Nothing to refactor: ")
end

function M.fix_file()
	local path = prepare()
	if not path then
		return
	end
	local severity_names = {
		[vim.diagnostic.severity.ERROR] = "error",
		[vim.diagnostic.severity.WARN] = "warning",
	}
	local problems = {}
	for _, d in ipairs(vim.diagnostic.get(0)) do
		if d.severity == vim.diagnostic.severity.ERROR or d.severity == vim.diagnostic.severity.WARN then
			table.insert(
				problems,
				string.format(
					"%d:%d [%s] %s (%s)",
					d.lnum + 1,
					(d.col or 0) + 1,
					severity_names[d.severity],
					(d.message or ""):gsub("\n", " "),
					d.source or "lsp"
				)
			)
		end
		if #problems >= 50 then
			break
		end
	end
	if #problems == 0 then
		running = false
		local notifier = get_notifier()
		local msg = "No problems to fix"
		if notifier then
			notifier.notify("✓ " .. msg, "info", { title = "Copilot", timeout = 3000 })
		else
			vim.notify(msg, vim.log.levels.INFO, { title = "Copilot" })
		end
		return
	end
	local prompt = "Fix only the following problems in the file at "
		.. path
		.. ". Apply minimal edits directly to the file with your file tools. "
		.. "Do NOT refactor, reformat, or change anything unrelated. "
		.. "If a problem cannot be fixed safely, leave it untouched:\n"
		.. table.concat(problems, "\n")
	run_copilot_job(path, prompt, "Fixes applied: ", "Nothing to fix: ")
end

-- Opens (or reuses) the floating window for ask(): question on top,
-- answer below. Returns buf/win so the job callback can update them.
local function open_ask_window(question)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].filetype = "markdown"
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].swapfile = false

	local width = math.min(100, math.floor(vim.o.columns * 0.75))
	local height = math.min(30, math.floor(vim.o.lines * 0.6))
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " Copilot ",
		title_pos = "center",
	})
	vim.wo[win].wrap = true
	vim.wo[win].linebreak = true

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "# ❓ " .. question, "", "⠋ Working…" })
	vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true, desc = "Close Copilot answer" })
	vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = buf, silent = true, desc = "Close Copilot answer" })
	return buf, win
end

function M.ask()
	if running then
		vim.notify("Copilot task already running", vim.log.levels.WARN, { title = "Copilot" })
		return
	end
	if vim.fn.executable("copilot") ~= 1 then
		vim.notify("copilot CLI not found", vim.log.levels.ERROR, { title = "Copilot" })
		return
	end
	vim.ui.input({ prompt = "Ask Copilot: " }, function(question)
		if question == nil or question == "" then
			return
		end
		M._ask_run(question)
	end)
end

-- Runs the Copilot job for an already-validated question string.
function M._ask_run(question)
	local path = vim.api.nvim_buf_get_name(0)
	if vim.bo.buftype ~= "" then
		path = ""
	end
	local target_buf = path ~= "" and vim.api.nvim_get_current_buf() or nil
	local cwd = vim.fn.getcwd()
	if path ~= "" then
		cwd = vim.fn.fnamemodify(path, ":h")
		pcall(vim.cmd, "silent write")
	end
	running = true

	local buf, _ = open_ask_window(question)

	local frame = 0
	local timer = (vim.uv or vim.loop).new_timer()
	timer:start(0, 120, function()
		frame = frame + 1
		local spin = spinner_frames[(frame % #spinner_frames) + 1]
		vim.schedule(function()
			if vim.api.nvim_buf_is_valid(buf) then
				pcall(vim.api.nvim_buf_set_lines, buf, 2, 3, false, { spin .. " Working…" })
			end
		end)
	end)

	local mtime_before = path ~= "" and vim.fn.getftime(path) or -1
	local output = {}
	local errors = {}

	local context = path ~= "" and ("\nCurrent file open in Neovim: " .. path) or ""
	local prompt = "You are a coding assistant inside Neovim. User question: "
		.. question
		.. context
		.. "\nRules: if the question asks to create, modify, fix or refactor code/files, "
		.. "apply the edits directly to the files with your file tools, then reply with exactly one line 'APPLIED'. "
		.. "Otherwise do NOT touch any file, just answer directly and concisely: "
		.. "max 12 short lines, markdown for code, no long paragraph, same language as the question."

	vim.fn.jobstart({ "copilot", "-p", prompt, "-s", "--model", "auto", "--allow-all-tools" }, {
		cwd = cwd,
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = function(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(output, line)
				end
			end
		end,
		on_stderr = function(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(errors, line)
				end
			end
		end,
		on_exit = function(_, code)
			vim.schedule(function()
				running = false
				if not timer:is_closing() then
					timer:stop()
					timer:close()
				end
				if not vim.api.nvim_buf_is_valid(buf) then
					return
				end
				if code ~= 0 then
					local detail = errors[#errors] or output[#output] or ("exit code " .. code)
					pcall(
						vim.api.nvim_buf_set_lines,
						buf,
						2,
						-1,
						false,
						{ "", "✗ Task failed: " .. detail }
					)
					return
				end
				local applied = false
				if #output > 0 and output[1]:match("^APPLIED") then
					applied = true
				end
				local file_changed = path ~= "" and vim.fn.getftime(path) ~= mtime_before or false
				if file_changed then
					applied = true
				end
				-- Auto-refresh like refactor/fix: reload the original file buffer
				-- (not the floating answer window) when clean, warn when dirty.
				if path ~= "" and target_buf ~= nil and vim.api.nvim_buf_is_valid(target_buf) then
					if vim.bo[target_buf].modified then
						if file_changed then
							vim.notify(
								"Copilot finished, but the buffer has unsaved changes (:e! to load)",
								vim.log.levels.WARN,
								{ title = "Copilot" }
							)
						end
					else
						vim.api.nvim_buf_call(target_buf, function()
							vim.cmd("edit!")
						end)
					end
				end
				if applied then
					-- No auto-format here: the file was just reloaded via edit!
					-- and formatting right away races the LSP (stylua -32803).
					-- Use <leader>lf manually if needed.
					local fname = path ~= "" and vim.fn.fnamemodify(path, ":t") or ""
					local msg = fname ~= "" and ("File updated: " .. fname) or "File updated"
					pcall(vim.api.nvim_buf_set_lines, buf, 2, -1, false, { "", "✓ " .. msg })
					return
				end
				if #output == 0 then
					output = { "No answer returned." }
				end
				local lines = { "# ❓ " .. question, "" }
				for _, l in ipairs(output) do
					table.insert(lines, l)
				end
				pcall(vim.api.nvim_buf_set_lines, buf, 0, -1, false, lines)
			end)
		end,
	})
end

return M
