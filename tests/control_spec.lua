describe("control.lua", function()
    local surface
    local on_init_handler
    local on_event_handler
    local registered_event_type

    before_each(function()
        surface = {}

        settings = {
            global = {
                ["necessary-lights-darkness"] = { value = 0.15 },
            },
        }

        game = {
            surfaces = {
                nauvis = surface,
            },
        }

        defines = {
            events = {
                on_runtime_mod_setting_changed = "on_runtime_mod_setting_changed",
            },
        }

        on_init_handler = nil
        on_event_handler = nil

        registered_event_type = nil

        script = {
            on_init = function(handler)
                on_init_handler = handler
            end,
            on_event = function(event_type, handler)
                registered_event_type = event_type
                on_event_handler = handler
            end,
        }

        dofile("src/control.lua")
    end)

    after_each(function()
        settings = nil
        game = nil
        defines = nil
        script = nil
    end)

    describe("on_init", function()
        it("sets brightness_visual_weights to {darkness, darkness, darkness}", function()
            on_init_handler()
            assert.are.same({ 0.15, 0.15, 0.15 }, surface.brightness_visual_weights)
        end)

        it("sets min_brightness to 0", function()
            on_init_handler()
            assert.are.equal(0, surface.min_brightness)
        end)
    end)

    describe("event registration", function()
        it("registers for on_runtime_mod_setting_changed event", function()
            assert.are.equal(defines.events.on_runtime_mod_setting_changed, registered_event_type)
        end)
    end)

    describe("on_runtime_mod_setting_changed", function()
        it("updates surface to new darkness value", function()
            on_init_handler()
            settings.global["necessary-lights-darkness"].value = 0.5
            on_event_handler()
            assert.are.same({ 0.5, 0.5, 0.5 }, surface.brightness_visual_weights)
        end)

        it("keeps min_brightness at 0 after setting change", function()
            on_init_handler()
            settings.global["necessary-lights-darkness"].value = 0.5
            on_event_handler()
            assert.are.equal(0, surface.min_brightness)
        end)
    end)

    describe("boundary values", function()
        it("darkness=0 results in {0, 0, 0} weights", function()
            settings.global["necessary-lights-darkness"].value = 0
            on_init_handler()
            assert.are.same({ 0, 0, 0 }, surface.brightness_visual_weights)
        end)

        it("darkness=1 results in {1, 1, 1} weights", function()
            settings.global["necessary-lights-darkness"].value = 1
            on_init_handler()
            assert.are.same({ 1, 1, 1 }, surface.brightness_visual_weights)
        end)
    end)
end)
