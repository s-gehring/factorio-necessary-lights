
local function setup()

    local surface = game.surfaces['nauvis']
    surface.brightness_visual_weights = { 1 / 0.85, 1 / 0.85, 1 / 0.85 }
    surface.min_brightness = 0
    surface.daytime = 0.5 -- midnight
    surface.freeze_daytime = true
end

local function init()
    setup()
end

script.on_init(init)
