describe("data.lua", function()
    local character

    before_each(function()
        character = {}

        settings = {
            startup = {
                ["necessary-lights-player-minimum-darkness"] = { value = 0.3 },
                ["necessary-lights-player-intensity"] = { value = 0.2 },
                ["necessary-lights-player-size"] = { value = 30 },
            },
        }

        data = {
            raw = {
                character = {
                    character = character,
                },
            },
        }

        dofile("src/data.lua")
    end)

    after_each(function()
        settings = nil
        data = nil
    end)

    describe("character light configuration", function()
        it("sets minimum_darkness from setting value", function()
            assert.are.equal(0.3, character.light[1].minimum_darkness)
        end)

        it("sets intensity from setting value", function()
            assert.are.equal(0.2, character.light[1].intensity)
        end)

        it("sets size from setting value", function()
            assert.are.equal(30, character.light[1].size)
        end)
    end)

    describe("boundary values", function()
        it("size=0 produces no-radius light", function()
            settings.startup["necessary-lights-player-size"].value = 0
            dofile("src/data.lua")
            assert.are.equal(0, character.light[1].size)
        end)

        it("size=2000 produces maximum-radius light", function()
            settings.startup["necessary-lights-player-size"].value = 2000
            dofile("src/data.lua")
            assert.are.equal(2000, character.light[1].size)
        end)

        it("minimum_darkness=0 means light always activates", function()
            settings.startup["necessary-lights-player-minimum-darkness"].value = 0
            dofile("src/data.lua")
            assert.are.equal(0, character.light[1].minimum_darkness)
        end)

        it("minimum_darkness=1.0 means light never activates", function()
            settings.startup["necessary-lights-player-minimum-darkness"].value = 1.0
            dofile("src/data.lua")
            assert.are.equal(1.0, character.light[1].minimum_darkness)
        end)

        it("intensity=0 produces no light output", function()
            settings.startup["necessary-lights-player-intensity"].value = 0
            dofile("src/data.lua")
            assert.are.equal(0, character.light[1].intensity)
        end)

        it("intensity=1 produces maximum light output", function()
            settings.startup["necessary-lights-player-intensity"].value = 1
            dofile("src/data.lua")
            assert.are.equal(1, character.light[1].intensity)
        end)
    end)
end)
