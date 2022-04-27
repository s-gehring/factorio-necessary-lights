
local function setDarkness()
    local darkness = settings.global["necessary-lights-darkness"].value
    local surface = game.surfaces['nauvis']
    surface.brightness_visual_weights = { darkness, darkness, darkness }
    surface.min_brightness = 0
end


script.on_init(setDarkness)

script.on_event(defines.events.on_runtime_mod_setting_changed, setDarkness)
