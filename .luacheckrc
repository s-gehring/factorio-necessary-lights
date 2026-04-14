std = "lua52+busted"

files["src/"] = {
    globals = {
        "data",
        "game",
    },
    read_globals = {
        "settings",
        "script",
        "defines",
    },
}
