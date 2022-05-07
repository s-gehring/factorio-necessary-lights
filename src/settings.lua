data:extend(
        {
            {
                type = "double-setting",
                name = "necessary-lights-darkness",
                default_value = 0.15,
                minimum_value = 0,
                maximum_value = 1,
                order = 1,
                setting_type = "runtime-global",
                localised_name = "Darkness",
                localised_description = "Alters the amount of darkness your experience. 0 being normal and 1 being pitch black."
            },
            {
                type = "double-setting",
                name = "necessary-lights-player-minimum-darkness",
                default_value = 0.3,
                minimum_value = 0,
                maximum_value = 1,
                order = 2,
                setting_type = "startup",
                localised_name = "Character Light (Minimum Darkness)",
                localised_description = ""
            },
            {
                type = "double-setting",
                name = "necessary-lights-player-intensity",
                default_value = 0.2,
                minimum_value = 0,
                maximum_value = 1,
                order = 3,
                setting_type = "startup",
                localised_name = "Character Light Intensity",
                localised_description = ""
            },
            {
                type = "int-setting",
                name = "necessary-lights-player-size",
                default_value = 30,
                minimum_value = 0,
                maximum_value = 2000,
                order = 4,
                setting_type = "startup",
                localised_name = "Character Light Size",
                localised_description = ""
            },
        }
)