# Code Review: Add Tests

**Date**: 2026-04-14 | **Reviewer**: Claude | **Branch**: 001-add-tests

**Scope**: tests/settings_spec.lua, tests/control_spec.lua, tests/data_spec.lua (all new files)

---

## Critical Issues

### 1. FR-007 boundary value gaps

**FR-007** requires: "Tests MUST cover boundary values for each setting (minimum, maximum, default)."

The following boundary tests are missing:

- **`player-intensity`**: No boundary tests at all. Neither 0 (minimum) nor 1 (maximum) are tested.
- **`player-size`**: Maximum boundary (2000) is not tested. Only 0 (minimum) is covered.
- **`player-minimum-darkness`**: Minimum boundary (0) is not tested. Only 1.0 (maximum) is covered.

These gaps mean a regression in `data.lua` at those boundary values would go undetected.

**File**: `tests/data_spec.lua`

---

## Moderate Issues

### 2. `on_event` stub does not verify the registered event type

In `tests/control_spec.lua:31-36`, the `script.on_event` stub discards the first argument:

```lua
on_event = function(_, handler)
    on_event_handler = handler
end,
```

If the source code were changed to register for a different event (e.g., `defines.events.on_player_joined_game` instead of `defines.events.on_runtime_mod_setting_changed`), all tests would still pass. The stub should capture and assert the event type.

### 3. No test verifying exactly 4 settings are registered

`tests/settings_spec.lua` validates properties of each known setting but never asserts the total count. If a developer adds a 5th setting (or removes one), the existing tests would still pass. A single assertion on the number of entries passed to `data:extend()` would catch this.

---

## Minor Issues

### 4. [pre-existing] Typo: "lightning" instead of "lighting" in `src/data.lua`

```lua
player_lightning_intensity = settings.startup["necessary-lights-player-intensity"].value
player_lightning_size = settings.startup["necessary-lights-player-size"].value
```

The variables are named `player_lightning_*` (as in thunderbolt) instead of `player_lighting_*` (as in illumination). The tests faithfully reproduce this behavior, which is correct, but the source typo is worth noting.

### 5. [pre-existing] Global variable leakage in `src/data.lua`

`minimum_darkness`, `player_lightning_intensity`, and `player_lightning_size` are declared without `local`, making them global. In Factorio's sandboxed Lua environment this is tolerable, but it is generally poor practice and could cause subtle bugs if another mod file is loaded in the same environment.

### 6. [pre-existing] Empty `localised_description` for 3 of 4 settings

`necessary-lights-player-minimum-darkness`, `necessary-lights-player-intensity`, and `necessary-lights-player-size` all have `localised_description = ""`. This means the Factorio settings UI shows no tooltip for these settings. Only the darkness setting has a meaningful description.

---

## Observations (No Action Required)

- Test structure is clean — each file is self-contained with its own stubs per the R2 research decision.
- The `dofile()` loading strategy (R3) works correctly, including in boundary tests that call `dofile()` a second time after changing stub values.
- Default value paths are implicitly covered since all `before_each` blocks configure stubs with production default values.
- All four spec-defined edge cases are tested.

---

## Review Response

**Date**: 2026-04-14 | **Responder**: Claude

### Issue #1: FR-007 boundary value gaps — FIXED

Added the four missing boundary tests to `tests/data_spec.lua`:

- **`player-intensity` min/max**: Added `intensity=0 produces no light output` and `intensity=1 produces maximum light output` tests.
- **`player-size` max**: Added `size=2000 produces maximum-radius light` test.
- **`player-minimum-darkness` min**: Added `minimum_darkness=0 means light always activates` test.

The boundary values section now covers both min and max for all three data-phase settings, matching FR-007's requirement. Total boundary tests in `data_spec.lua` went from 2 to 6.

### Issue #2: `on_event` stub does not verify event type — FIXED

The `script.on_event` stub in `tests/control_spec.lua` now captures the `event_type` argument into `registered_event_type`. A new `describe("event registration")` block asserts that `defines.events.on_runtime_mod_setting_changed` is the registered event type. If the source code were changed to register for a different event, this test would now catch it.

### Issue #3: No test verifying exactly 4 settings — FIXED

Added a `captured_count` variable to the `data:extend()` stub in `tests/settings_spec.lua` that increments for each setting entry. A new top-level test `it("registers exactly 4 settings")` asserts this count equals 4. Adding or removing a setting from `src/settings.lua` will now cause a test failure.

### Issue #4: Typo "lightning" instead of "lighting" — FIXED

Renamed `player_lightning_intensity` to `player_lighting_intensity` and `player_lightning_size` to `player_lighting_size` in `src/data.lua`. These are local variables (see #5) with no external consumers, so the rename is safe and has zero impact on mod behavior. Fixed directly because it's a single-line change and leaving a known typo in source code that tests validate against would propagate confusion.

### Issue #5: Global variable leakage — FIXED

Added `local` keyword to all three variable declarations in `src/data.lua` (`minimum_darkness`, `player_lighting_intensity`, `player_lighting_size`). These variables are only used within the file to build the `light` table, so scoping them locally is correct. This prevents potential conflicts with other mod files loaded in the same Lua environment. Fixed directly because it's a three-character change per line with no behavioral impact.

### Issue #6: Empty `localised_description` — OUT OF SCOPE

The empty description strings for three settings are a content/UX decision, not a code defect. Choosing appropriate tooltip text requires game design context (what information helps the player configure these settings). This is not something that should be addressed in a test-suite branch. The existing `localised_name` tests already verify that display names are present and non-empty, which is the testable requirement from the spec.
