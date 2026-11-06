//! Transpiled from Horizon Rust crate
//! Module: horizon-client_game_mode_switcher
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Selection and hit testing for the debug game-mode switcher.
// use crate::command::args::GameMode;

    // rust: pub const MODES: [GameMode; 4] = [
    // rust: GameMode::Creative,
    // rust: GameMode::Survival,
    // rust: GameMode::Adventure,
    // rust: GameMode::Spectator,
    // rust: ];

    // rust: pub const ICONS: [&str; 4] = [
    // rust: "minecraft:grass_block",
    // rust: "minecraft:iron_sword",
    // rust: "minecraft:buried_treasure_map",
    // rust: "minecraft:ender_eye",
    // rust: ];

pub const SLOT_SIZE: i32 = 26;

pub fn slot_origin(width: i32, height: i32, index: usize) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (width / 2 - 59 + index as i32 * 31, height / 2 - 31)
}

pub const GameModeSwitcher = struct {
    selected: GameMode,
    first_mouse: Option<(i32,
};

    // rust: impl GameModeSwitcher {
pub fn new(current: GameMode, previous: ?GameMode) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: selected: previous.unwrap_or(if current == GameMode::Creative {
    // rust: GameMode::Survival
    // rust: } else {
    // rust: GameMode::Creative
    // rust: }),
    // rust: first_mouse: None,
}
}

pub fn cycle(self: *Self) void {
}
    // rust: let index = MODES.iter().position(|m| *m == self.selected).unwrap();
    // rust: self.selected = MODES[(index + 1) % MODES.len()];
    // rust: self.first_mouse = None;
}

pub fn hover(self: *Self, width: i32, height: i32, cursor: (i32) void {
}
    // rust: if *self.first_mouse.get_or_insert(cursor) == cursor {
    // rust: return;
}
    // rust: for (index, mode) in MODES.iter().enumerate() {
    // rust: let (x, y) = slot_origin(width, height, index);
    // rust: if cursor.0 >= x
    // rust: && cursor.0 < x + SLOT_SIZE
    // rust: && cursor.1 >= y
    // rust: && cursor.1 < y + SLOT_SIZE
    // rust: {
    // rust: self.selected = *mode;
    // rust: return;
}
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn initial_selection_and_cycle_follow_debug_order() void {
}
    // rust: assert_eq!(
    // rust: GameModeSwitcher::new(GameMode::Creative, None).selected,
    // rust: GameMode::Survival
    // rust: );
    // rust: for current in [GameMode::Survival, GameMode::Adventure, GameMode::Spectator] {
    // rust: assert_eq!(
    // rust: GameModeSwitcher::new(current, None).selected,
    // rust: GameMode::Creative
    // rust: );
}
    // rust: let mut state = GameModeSwitcher::new(GameMode::Survival, Some(GameMode::Adventure));
    // rust: for mode in [
    // rust: GameMode::Adventure,
    // rust: GameMode::Spectator,
    // rust: GameMode::Creative,
    // rust: GameMode::Survival,
    // rust: ] {
    // rust: assert_eq!(state.selected, mode);
    // rust: state.cycle();
}
}

pub fn stationary_mouse_does_not_override_keyboard_selection() void {
}
    // rust: let mut state = GameModeSwitcher::new(GameMode::Creative, None);
    // rust: let cursor = slot_origin(320, 240, 0);
    // rust: state.hover(320, 240, cursor);
    // rust: state.hover(320, 240, cursor);
    // rust: assert_eq!(state.selected, GameMode::Survival);
    // rust: state.hover(320, 240, (cursor.0 + 1, cursor.1));
    // rust: assert_eq!(state.selected, GameMode::Creative);
    // rust: state.cycle();
    // rust: state.hover(320, 240, (cursor.0 + 1, cursor.1));
    // rust: assert_eq!(state.selected, GameMode::Survival);
}

pub fn hover_slots_exclude_gaps_and_right_and_bottom_edges() void {
}
    // rust: let mut state = GameModeSwitcher::new(GameMode::Creative, None);
    // rust: state.hover(320, 240, (0, 0));
    // rust: let (x, y) = slot_origin(320, 240, 2);
    // rust: for cursor in [(x - 1, y), (x + 26, y), (x, y - 1), (x, y + 26)] {
    // rust: state.hover(320, 240, cursor);
    // rust: assert_eq!(state.selected, GameMode::Survival);
}
    // rust: state.hover(320, 240, (x + 25, y + 25));
    // rust: assert_eq!(state.selected, GameMode::Adventure);
}
}
