-- -----------------
-- Setup environment
-- -----------------

-- Auto reload config file on save.
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-- None of this animation shit:
hs.window.animationDuration = 0
-- Get list of screens and refresh that list whenever screens are plugged or unplugged:
local screens = hs.screen.allScreens()
local screenwatcher = hs.screen.watcher.new(function()
	screens = hs.screen.allScreens()
end)
screenwatcher:start()

-- Modifier shortcuts
local alt = {"alt"}
local hyper = {"cmd", "alt", "ctrl", "shift"}
local nudgekey = {"cmd", "ctrl"}
local yankkey = {"cmd", "ctrl","shift"}
local pushkey = {"alt", "cmd"}
local sendkey= {"ctrl", "cmd", "alt"}

-- --------------------------------------------------------
-- Helper functions - these do all the heavy lifting below.
-- Names are roughly stolen from same functions in Slate :)
-- --------------------------------------------------------

-- Move a window a number of pixels in x and y
function nudge(xpos, ypos)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.x = f.x + xpos
	f.y = f.y + ypos
	win:setFrame(f)
end

-- Resize a window by moving the bottom
function yank(xpixels,ypixels)
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.w = f.w + xpixels
	f.h = f.h + ypixels
	win:setFrame(f)
end

-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function push(x, y, w, h)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w*x)
	f.y = max.y + (max.h*y)
	f.w = max.w*w
	f.h = max.h*h
	win:setFrame(f)
end

-- Move to monitor x. Checks to make sure monitor exists, if not moves to last monitor that exists
function moveToMonitor(x)
	local win = hs.window.focusedWindow()
	local newScreen = nil
	while not newScreen do
		newScreen = screens[x]
		x = x-1
	end

	win:moveToScreen(newScreen)
end

-- -----------------
-- Window management
-- -----------------

-- Movement hotkeys
--hs.hotkey.bind(nudgekey, 'down', function() nudge(0,100) end) 	--down
--hs.hotkey.bind(nudgekey, "up", function() nudge(0,-100) end)	--up
--hs.hotkey.bind(nudgekey, "right", function() nudge(100,0) end)	--right
--hs.hotkey.bind(nudgekey, "left", function() nudge(-100,0) end)	--left

-- Resize hotkeys
--hs.hotkey.bind(yankkey, "up", function() yank(0,-100) end) -- yank bottom up
--hs.hotkey.bind(yankkey, "down", function() yank(0,100) end) -- yank bottom down
--hs.hotkey.bind(yankkey, "right", function() yank(100,0) end) -- yank right side right
--hs.hotkey.bind(yankkey, "left", function() yank(-100,0) end) -- yank right side left

-- Push to screen edge
hs.hotkey.bind(hyper,"left", function() push(0,0,0.5,1) end) 		-- left side
hs.hotkey.bind(hyper,"right", function() push(0.5,0,0.5,1) end)	-- right side
hs.hotkey.bind(hyper,"up", function()	push(0,0,1,0.5) end) 		-- top half
hs.hotkey.bind(hyper,"down", function()	push(0,0.5,1,0.5) end)	-- bottom half

---- Push to corners
---- top left
--hs.hotkey.bind(mash.corner, "up", adjust(0, 0, 0.5, 0.5))
---- top right
--hs.hotkey.bind(mash.corner, "right", adjust(0.5, 0, 0.5, 0.5))
---- bottom right
--hs.hotkey.bind(mash.corner, "down", adjust(0.5, 0.5, 0.5, 0.5))
---- bottom left
--hs.hotkey.bind(mash.corner, "left", adjust(0, 0.5, 0.5, 0.5))
---- fullscreen
--hs.hotkey.bind(mash.split, ",", adjustCenterTop(1, 1))
---- Center window with some room to see the desktop
--hs.hotkey.bind(pushkey, "c", function() push(0.05,0.05,0.9,0.9) end)

-- Fullscreen
hs.hotkey.bind(pushkey, "f", function() push(0,0,1,1) end)

-- Focus windows
local function focus(direction)
  local fn = "focusWindow" .. (direction:gsub("^%l", string.upper))

  return function()
    local win = hs.window:focusedWindow()
    if not win then return end

    win[fn]()
  end
end

-- Modal window layouts
hs.hints.showTitleThresh = 0
hs.hints.style = "vimperator"
hs.hotkey.bind(hyper, 'f', hs.hints.windowHints)

-- Window navigation
hs.hotkey.bind(hyper, "k", focus("north"))
hs.hotkey.bind(hyper, "l", focus("east"))
hs.hotkey.bind(hyper, "j", focus("south"))
hs.hotkey.bind(hyper, "h", focus("west"))

hs.grid.ui.showExtraKeys = false
hs.grid.ui.textSize = 25
hs.grid.setGrid('12x2')
hs.hotkey.bind(hyper, "u", function()
  hs.grid.show()
end)

-------------
-- LAYOUTS - Currently not in use.
-------------

hs.hotkey.bind(hyper, "z", function()
  hs.mjomatic.go({
    "i",
    "",
    "i iTerm"
  })
end)
hs.hotkey.bind(hyper, "x", function()
  hs.mjomatic.go({
    "c",
    "",
    "c Google Chrome"
  })
end)
hs.hotkey.bind(hyper, "c", function()
  hs.mjomatic.go({
    "sssssstttt",
    "ssssssmmmm",
    "",
    "s Slack",
    "t Textual IRC Client",
    "m Messages"
  })
end)
hs.hotkey.bind(hyper, "v", function()
  hs.mjomatic.go({
    "s",
    "",
    "s Spotify"
  })
end)


----------
-- App Shortcuts
----------

hs.hotkey.bind(hyper, "u", function()
  hs.application.launchOrFocus("Google Chrome")
end)
hs.hotkey.bind(hyper, "y", function()
  hs.application.launchOrFocus("Safari")
end)
hs.hotkey.bind(hyper, "i", function()
  hs.application.launchOrFocus("iTerm")
end)
--[[
hs.hotkey.bind(hyper, "o", function()
  hs.application.launchOrFocus("Discord")
end)
hs.hotkey.bind(hyper, "p", function()
  hs.application.launchOrFocus("Messages")
end)
]]--
hs.hotkey.bind(hyper, ";", function()
  hs.application.launchOrFocus("Spotify")
end)
