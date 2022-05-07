minimum_darkness = settings.startup["necessary-lights-player-minimum-darkness"].value
player_lightning_intensity = settings.startup["necessary-lights-player-intensity"].value
player_lightning_size = settings.startup["necessary-lights-player-size"].value

data.raw["character"]["character"].light = {
    {
        minimum_darkness = minimum_darkness,
        intensity = player_lightning_intensity,
        size = player_lightning_size,
    }
}
