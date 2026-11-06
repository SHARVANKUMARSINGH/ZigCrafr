//! Transpiled from Horizon Rust crate
package horizon_client_titles

import "core:fmt"
import "core:mem"
import "core:math"

// Titles, the action bar and the selected item name: the state and layout
// live in `hud_overlays` (`Titles`, `ToolHighlight`); this feeds and draws them.
// use super::Game;
    // rust: pub(super) use horizon_client::hud_overlays::Titles;
// use horizon_client::{
    // rust: hud::HudBatch,
    // rust: hud_layout,
    // rust: hud_overlays::HeldName,
    // rust: item_tooltip,
    // rust: text::{self, Text},
}

    // rust: impl Game<'_> {
    // `ServerPlayer.sendOverlayMessage`: the steady player sees it on this
    // game's HUD; a server client receives it as a packet.
    // rust: pub(super) fn send_overlay_message(&mut self, message: Text) {
    // rust: if self.lan_acting.is_some() {
    // rust: self.guest_packets
    // rust: .push(horizon_protocol::packets::play::Clientbound::SystemChat(
    // rust: horizon_protocol::packets::play::SystemChat {
    // rust: content: horizon_client::lan::data::component_nbt(&message.component()),
    // rust: overlay: true,
    // rust: },
    // rust: ));
    // rust: } else if self.options.dedicated.is_none() {
    // rust: self.titles.set_overlay(message, false);
}
}
    // `Hud.extractOverlayMessage`: the action bar.
    // rust: pub(super) fn draw_overlay_message(&self, batch: &mut HudBatch, bar_height: i32) {
    // rust: let (w, h) = (batch.width as i32, batch.height as i32);
    // rust: let partial = self.clock.fraction() as f32;
    // rust: let background = self.settings.text_background(0.0);
    // rust: let font = &self.gui.atlas.font;
    // rust: let draws = self
    // rust: .titles
    // rust: .overlay_message(w, h, bar_height, partial, font, background);
    // rust: hud_layout::paint(batch, &self.gui.atlas, &draws);
}
    // `Hud.extractTitle`.
    // rust: pub(super) fn draw_title(&self, batch: &mut HudBatch) {
    // rust: let (w, h) = (batch.width as i32, batch.height as i32);
    // rust: let partial = self.clock.fraction() as f32;
    // rust: let background = self.settings.text_background(0.0);
    // rust: let font = &self.gui.atlas.font;
    // rust: let draws = self.titles.title(w, h, partial, font, background);
    // rust: hud_layout::paint(batch, &self.gui.atlas, &draws);
}
    // `Hud.extractSavingIndicator`, under the screens: the option, then the
    // fading "Saving world" text.
    // rust: pub(super) fn draw_saving_indicator(&self, batch: &mut HudBatch) {
    // rust: if !self.settings.autosave_indicator {
    // rust: return;
}
    // rust: let draws = self.saving_indicator.draw(
    // rust: batch.width as i32,
    // rust: batch.height as i32,
    // rust: self.clock.fraction() as f32,
    // rust: &self.gui.atlas.font,
    // rust: Text::literal(self.translate("menu.savingLevel", "Saving world")),
    // rust: self.settings.text_background(0.0),
    // rust: );
    // rust: hud_layout::paint(batch, &self.gui.atlas, &draws);
}
    // The selected stack as `Hud.tick` compares it for the name highlight.
held_name :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let stack = self.inventory.get(self.selected)?.as_ref()?;
    // rust: let custom = stack.data().is_some_and(|data| data.custom_name.is_some());
    // rust: let default_rarity = self.item_rarity(&stack.item);
    // rust: let rarity = item_tooltip::rarity(stack, &default_rarity);
    // rust: Some(HeldName {
    // rust: item: stack.item.to_string(),
    // rust: hover_name: item_tooltip::styled_name(stack, || {
    // rust: item_tooltip::name_line(stack, &|key| self.pack.names.display_get(key))
    // rust: }),
    // rust: rarity_color: match rarity {
    // rust: "uncommon" => text::YELLOW,
    // rust: "rare" => text::AQUA,
    // rust: "epic" => text::LIGHT_PURPLE,
    // rust: _ => text::WHITE,
    // rust: },
    // rust: custom_name: custom,
    // rust: })
}
    // The title, action bar and selected-item parts of `Hud.tick`.
    // rust: pub(super) fn tick_hud(&mut self) {
    // rust: self.titles.tick();
    // rust: self.tick_in_bed_chat();
        // `MinecraftServer.isCurrentlySaving` of single player's server.
    // rust: let saving = self
    // rust: .integrated
    // rust: .as_ref()
    // rust: .map_or(self.autosaving, |server| server.is_saving());
    // rust: self.saving_indicator.tick(saving);
    // rust: let held = self.held_name();
    // rust: self.tool_highlight
    // rust: .tick(held, f64::from(self.settings.notification_display_time));
}
    // `Hud.extractSelectedItemName`.
    // rust: pub(super) fn draw_selected_name(&self, batch: &mut HudBatch, bar_height: i32, can_hurt: bool) {
    // rust: let draws = self.tool_highlight.draw(
    // rust: batch.width as i32,
    // rust: batch.height as i32,
    // rust: bar_height,
    // rust: can_hurt,
    // rust: &self.gui.atlas.font,
    // rust: self.settings.text_background(0.0),
    // rust: );
    // rust: hud_layout::paint(batch, &self.gui.atlas, &draws);
}
}
