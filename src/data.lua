local minimum_darkness = settings.startup["necessary-lights-player-minimum-darkness"].value
local player_lighting_intensity = settings.startup["necessary-lights-player-intensity"].value
local player_lighting_size = settings.startup["necessary-lights-player-size"].value

data.raw["character"]["character"].light = {
    {
        minimum_darkness = minimum_darkness,
        intensity = player_lighting_intensity,
        size = player_lighting_size,
    }
}
