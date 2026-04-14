describe("settings.lua", function()
    local captured_settings
    local captured_count

    before_each(function()
        captured_settings = {}
        captured_count = 0
        data = {
            extend = function(_, entries)
                for _, entry in ipairs(entries) do
                    captured_settings[entry.name] = entry
                    captured_count = captured_count + 1
                end
            end,
        }
        dofile("src/settings.lua")
    end)

    after_each(function()
        data = nil
    end)

    it("registers exactly 4 settings", function()
        assert.are.equal(4, captured_count)
    end)

    describe("darkness setting", function()
        it("is a double-setting", function()
            assert.are.equal("double-setting", captured_settings["necessary-lights-darkness"].type)
        end)

        it("has default 0.15", function()
            assert.are.equal(0.15, captured_settings["necessary-lights-darkness"].default_value)
        end)

        it("has minimum 0", function()
            assert.are.equal(0, captured_settings["necessary-lights-darkness"].minimum_value)
        end)

        it("has maximum 1", function()
            assert.are.equal(1, captured_settings["necessary-lights-darkness"].maximum_value)
        end)

        it("is runtime-global", function()
            assert.are.equal("runtime-global", captured_settings["necessary-lights-darkness"].setting_type)
        end)
    end)

    describe("player-minimum-darkness setting", function()
        it("is a double-setting", function()
            assert.are.equal("double-setting", captured_settings["necessary-lights-player-minimum-darkness"].type)
        end)

        it("has default 0.3", function()
            assert.are.equal(0.3, captured_settings["necessary-lights-player-minimum-darkness"].default_value)
        end)

        it("has minimum 0", function()
            assert.are.equal(0, captured_settings["necessary-lights-player-minimum-darkness"].minimum_value)
        end)

        it("has maximum 1", function()
            assert.are.equal(1, captured_settings["necessary-lights-player-minimum-darkness"].maximum_value)
        end)

        it("is startup", function()
            assert.are.equal("startup", captured_settings["necessary-lights-player-minimum-darkness"].setting_type)
        end)
    end)

    describe("player-intensity setting", function()
        it("is a double-setting", function()
            assert.are.equal("double-setting", captured_settings["necessary-lights-player-intensity"].type)
        end)

        it("has default 0.2", function()
            assert.are.equal(0.2, captured_settings["necessary-lights-player-intensity"].default_value)
        end)

        it("has minimum 0", function()
            assert.are.equal(0, captured_settings["necessary-lights-player-intensity"].minimum_value)
        end)

        it("has maximum 1", function()
            assert.are.equal(1, captured_settings["necessary-lights-player-intensity"].maximum_value)
        end)

        it("is startup", function()
            assert.are.equal("startup", captured_settings["necessary-lights-player-intensity"].setting_type)
        end)
    end)

    describe("player-size setting", function()
        it("is an int-setting", function()
            assert.are.equal("int-setting", captured_settings["necessary-lights-player-size"].type)
        end)

        it("has default 30", function()
            assert.are.equal(30, captured_settings["necessary-lights-player-size"].default_value)
        end)

        it("has minimum 0", function()
            assert.are.equal(0, captured_settings["necessary-lights-player-size"].minimum_value)
        end)

        it("has maximum 2000", function()
            assert.are.equal(2000, captured_settings["necessary-lights-player-size"].maximum_value)
        end)

        it("is startup", function()
            assert.are.equal("startup", captured_settings["necessary-lights-player-size"].setting_type)
        end)
    end)

    describe("ordering", function()
        it("assigns order 1 to darkness", function()
            assert.are.equal(1, captured_settings["necessary-lights-darkness"].order)
        end)

        it("assigns order 2 to player-minimum-darkness", function()
            assert.are.equal(2, captured_settings["necessary-lights-player-minimum-darkness"].order)
        end)

        it("assigns order 3 to player-intensity", function()
            assert.are.equal(3, captured_settings["necessary-lights-player-intensity"].order)
        end)

        it("assigns order 4 to player-size", function()
            assert.are.equal(4, captured_settings["necessary-lights-player-size"].order)
        end)
    end)

    describe("localised names", function()
        it("sets localised_name for darkness", function()
            assert.is_not_nil(captured_settings["necessary-lights-darkness"].localised_name)
            assert.are_not.equal("", captured_settings["necessary-lights-darkness"].localised_name)
        end)

        it("sets localised_name for player-minimum-darkness", function()
            assert.is_not_nil(captured_settings["necessary-lights-player-minimum-darkness"].localised_name)
            assert.are_not.equal("", captured_settings["necessary-lights-player-minimum-darkness"].localised_name)
        end)

        it("sets localised_name for player-intensity", function()
            assert.is_not_nil(captured_settings["necessary-lights-player-intensity"].localised_name)
            assert.are_not.equal("", captured_settings["necessary-lights-player-intensity"].localised_name)
        end)

        it("sets localised_name for player-size", function()
            assert.is_not_nil(captured_settings["necessary-lights-player-size"].localised_name)
            assert.are_not.equal("", captured_settings["necessary-lights-player-size"].localised_name)
        end)
    end)
end)
