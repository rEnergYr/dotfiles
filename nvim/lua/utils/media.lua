--[[
  Module: media
  Description: Streams media playback information using the 'media-control' CLI tool.
               Maintains the current playback state in the 'now_playing' table,
               handles both full payloads and partial updates (diffs), and sends
               a notification via Snacks when a new track starts playing.

  Usage:
    local media = require("utils.media")
    print(media.now_playing and media.now_playing.title or "No track playing")

  Features:
    - Tracks current playback state in 'now_playing'
    - Detects new tracks and triggers a notification (Snacks) once per track
    - Ignores incomplete payloads (e.g., duration = 0 or empty title)
    - Handles partial updates via 'diff = true' messages

  Fields in 'now_playing' table:
    title         : string, current track title
    artist        : string, current track artist
    app           : string, bundle identifier of the app playing
    playing_state : string, "playing" or "paused"

  Internal flags:
    last_track_id : string|nil, tracks the last notified track to avoid duplicate notifications
    notified      : boolean, true if a notification has already been sent for the current track
--]]

local M = {}

M.now_playing = nil
M.last_track_id = nil
M.notified = false

function M.start_stream()
	vim.fn.jobstart({ "media-control", "stream" }, {
		stdout_buffered = false,
		on_stdout = function(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					local ok, json = pcall(vim.fn.json_decode, line)
					if not ok or json.type ~= "data" then
						goto continue
					end

					local payload = json.payload or {}

					-- Full payload
					if json.diff == false then
						if next(payload) == nil or payload.playing == false then
							M.now_playing = nil
							M.last_track_id = nil
							M.notified = false
						else
							local track_id = payload.contentItemIdentifier
							local title = payload.title or ""
							local artist = payload.artist or ""
							local duration = payload.duration or 0

							-- Only consider “valid” payloads for notification
							local valid_track = title ~= "" and duration > 0

							-- Detect new track
							local new_track = track_id ~= M.last_track_id and valid_track

							M.now_playing = {
								title = title,
								artist = artist,
								app = payload.bundleIdentifier or "",
								playing_state = payload.playing and "playing" or "paused",
							}

							if new_track then
								M.last_track_id = track_id
								M.notified = false
							end

							if valid_track and not M.notified then
								M.notified = true

								if vim.bo.filetype ~= "snacks_dashboard" then
									local snacks = require("snacks")

									local notif_title = title

									if #notif_title > 30 then
										notif_title = notif_title:sub(1, 27) .. "..."
									end

									snacks.notify.info(notif_title, {
										title = "Now playing",
									})
								end
							end
						end
					-- Partial update
					elseif json.diff == true and M.now_playing then
						if payload.title then
							M.now_playing.title = payload.title
						end
						if payload.artist then
							M.now_playing.artist = payload.artist
						end
						if payload.bundleIdentifier then
							M.now_playing.app = payload.bundleIdentifier
						end
						if payload.playbackRate ~= nil then
							M.now_playing.playing_state = (payload.playbackRate == 0) and "paused" or "playing"
						end
					end
				end
				::continue::
			end
		end,
		on_stderr = function(_, data) end,
		on_exit = function()
			vim.defer_fn(M.start_stream, 1000)
		end,
	})
end

M.start_stream()

return M
