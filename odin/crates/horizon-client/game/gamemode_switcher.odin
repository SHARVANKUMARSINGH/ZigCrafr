//! Transpiled from Horizon Rust crate
package horizon_client_gamemode_switcher

import "core:fmt"
import "core:mem"
import "core:math"

// The non-pausing F3+F4 screen (`GameModeSwitcherScreen`).
// use super::{Game, ItemStack, Screen};
// use horizon_client::{
    // rust: game_mode_switcher::{GameModeSwitcher, ICONS, MODES, slot_origin},
    // rust: hud::HudBatch,
    // rust: keybinds,
    // rust: text::Text,
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn open_gamemode_switcher(&mut self) {
    // rust: self.gamemode_switcher = Some(GameModeSwitcher::new(self.mode, self.previous_mode));
    // rust: self.screen = Screen::GameModeSwitcher;
    // rust: self.keys.clear();
    // rust: self.left = false;
    // rust: self.right = false;
    // rust: self.mining = None;
    // rust: self.capture(false);
}

    // rust: pub(super) fn close_gamemode_switcher(&mut self, apply: bool) {
    // rust: let selected = self.gamemode_switcher.take().map(|s| s.selected);
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
    // rust: if apply
    // rust: && self.player.is_some()
    // rust: && self.gamemaster()
    // rust: && let Some(mode) = selected
    // rust: && mode != self.mode
    // rust: {
    // rust: self.change_game_mode(mode);
}
}

    // rust: pub(super) fn draw_gamemode_switcher(&mut self, batch: &mut HudBatch) {
    // rust: let (w, h) = (batch.width as i32, batch.height as i32);
    // rust: let Some(switcher) = &mut self.gamemode_switcher else {
    // rust: return;
}
        // GameModeSwitcherScreen: `GameNarrator.NO_TITLE`; its slots are no
        // widgets, so it says how to navigate.
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: horizon_client::widgets::ScreenInfo::new("gamemode_switcher", "")
    // rust: });
    // rust: switcher.hover(w, h, (self.cursor.0 as i32, self.cursor.1 as i32));
    // rust: let selected = switcher.selected;
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: "gui/container/gamemode_switcher",
    // rust: [(w / 2 - 62) as f32, (h / 2 - 58) as f32, 125.0, 75.0],
    // rust: 128.0,
    // rust: 128.0,
    // rust: );
    // rust: let title = Text::translate(&format!("gameMode.{}", selected.name()), &[]);
    // rust: let help = Text::translate(
    // rust: "debug.gamemodes.select_next",
    // rust: &[
    // rust: keybinds::display_name(self.settings.keys.get("key.debug.switchGameMode"))
    // rust: .with_color(0x55FFFF),
    // rust: ],
    // rust: );
    // rust: for (text, y) in [(title, h / 2 - 51), (help, h / 2 + 5)] {
    // rust: let x = w / 2 - (HudBatch::text_width(atlas, &text.plain()) / 2.0) as i32;
    // rust: batch.text_styled(atlas, &text, x as f32, y as f32, u32::MAX, true);
}
    // rust: for (index, mode) in MODES.into_iter().enumerate() {
    // rust: let (x, y) = slot_origin(w, h, index);
    // rust: batch.sprite(
    // rust: &self.gui.atlas,
    // rust: "gui/sprites/gamemode_switcher/slot",
    // rust: x as f32,
    // rust: y as f32,
    // rust: );
    // rust: if mode == selected {
    // rust: batch.sprite(
    // rust: &self.gui.atlas,
    // rust: "gui/sprites/gamemode_switcher/selection",
    // rust: x as f32,
    // rust: y as f32,
    // rust: );
}
    // rust: self.draw_item_model(
    // rust: batch,
    // rust: &ItemStack::new(ICONS[index], 1),
    // rust: (x + 5) as f32,
    // rust: (y + 5) as f32,
    // rust: );
}
}
}
