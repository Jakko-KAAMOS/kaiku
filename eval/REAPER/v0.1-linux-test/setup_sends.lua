-- setup_sends.lua
-- Wires the v0.1-linux-test routing matrix:
--   Tracks named "Kaiku ..." or "Trabant radio ..." send to every track named "BUS · ..."
-- Run from REAPER: Actions → Load ReaScript → pick this file → Run.

local function track_name(tr)
  local _, name = reaper.GetTrackName(tr)
  return name or ""
end

local function is_source(name)
  return name:match("^Kaiku") or name:match("^Trabant radio")
end

local function is_bus(name)
  return name:match("^BUS")
end

reaper.Undo_BeginBlock()

local total = reaper.CountTracks(0)
local sources, buses = {}, {}

for i = 0, total - 1 do
  local tr = reaper.GetTrack(0, i)
  local nm = track_name(tr)
  if is_source(nm) then sources[#sources+1] = tr end
  if is_bus(nm)    then buses[#buses+1]    = tr end
end

local added, skipped = 0, 0
for _, src in ipairs(sources) do
  for _, dst in ipairs(buses) do
    -- Check for an existing send from src to dst to avoid duplicates
    local exists = false
    local n_sends = reaper.GetTrackNumSends(src, 0) -- 0 = sends
    for s = 0, n_sends - 1 do
      local dest = reaper.BR_GetMediaTrackSendInfo_Track(src, 0, s, 1) -- 1 = destination
      if dest == dst then exists = true; break end
    end
    if exists then
      skipped = skipped + 1
    else
      reaper.CreateTrackSend(src, dst)
      added = added + 1
    end
  end
end

reaper.Undo_EndBlock("Kaiku v0.1 — wire IR bus sends", -1)
reaper.ShowMessageBox(
  string.format("Sends wired.\n\nSources: %d\nBuses:   %d\nAdded:   %d\nSkipped (already present): %d",
    #sources, #buses, added, skipped),
  "Kaiku v0.1 send setup", 0)
