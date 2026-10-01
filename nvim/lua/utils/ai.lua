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

  Functions:
    refactor_file() : nil
      Asks Copilot to refactor the current file in place
      (cleaner code, same behavior) and reloads it when done.
    fix_file() : nil
      Asks Copilot to fix only the current file's diagnostics.
      Does nothing when there is nothing to fix.
--]]

local M = {}

local running = false
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

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
				pcall(vim.lsp.buf.format)
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

return M
