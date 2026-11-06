//! Transpiled from Horizon Rust crate
//! Module: horizon-client_debug_options
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `DebugOptionsScreen` (F3+F6): every debug entry with Off / In Overlay /
//! Always buttons, a search box over them, the two built-in profiles and the
//! debug overlay's GUI scale. The statuses live in `debug-profile.json`
//! (`horizon_client::debug_entries`).
//! https://mcsrc.dev/2/26.3/net/minecraft/client/gui/screens/debug/DebugOptionsScreen
// use super::{Game, Screen};
// use horizon_client::{
    // rust: debug_entries::{Category, Entry, Profile, Status, search},
    // rust: hud::HudBatch,
    // rust: options_file::V,
    // rust: text::Text,
    // rust: ui::{self, EditBox, Scroll},
}
// use winit::event::{ElementState, KeyEvent};
// use winit::keyboard::{KeyCode, PhysicalKey};

/// `HeaderAndFooterLayout(this, 61, 33)`.
pub const HEADER: f32 = 61.0;
pub const FOOTER: f32 = 33.0;
/// `OptionList.getRowWidth` and `ITEM_HEIGHT`.
pub const ROW_WIDTH: f32 = 350.0;
pub const ITEM: f32 = 20.0;
/// `OptionEntry.BUTTON_WIDTH`, at the CycleButtons' 16 pixels high.
pub const BUTTON: f32 = 60.0;
/// The footer: two profile buttons, the GUI scale and Done, 4 pixels apart.
pub const FOOTER_BUTTONS: [f32; 4] = [120.0, 120.0, 110.0, 60.0];
/// `debug.options.warning`'s colour (-2142128) and the buttons' text colours.
pub const WARNING: u32 = 0xDF_5050;
pub const UNSELECTED: u32 = 0xBA_BABA;
pub const OVERLAY: u32 = 0xFF_FF55;
pub const NOT_ALLOWED: u32 = 0x80_8080;
/// `EditBox.SEARCH_HINT_STYLE`: `ChatFormatting.GRAY`.
pub const HINT: u32 = 0xAA_AAAA;

/// The open screen: its search box and the list's scroll.
    // rust: pub(super) struct DebugOptionsUi {
    // rust: search: EditBox,
    // rust: scroll: Scroll,
}

    // rust: impl DebugOptionsUi {
    // rust: pub(super) fn search_focused(&self) -> bool {
    // rust: self.search.focused
}
}

/// One list row (`AbstractOptionEntry`).
pub const Row = enum {
    Category(Category),
    Option(&'static Entry),
};

/// `OptionList.updateSearch`: a category row before each category's entries.
pub fn rows(value: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut rows = Vec::new();
    // rust: let mut current = None;
    // rust: for entry in search(value) {
    // rust: if current != Some(entry.category) {
    // rust: rows.push(Row::Category(entry.category));
    // rust: current = Some(entry.category);
}
    // rust: rows.push(Row::Option(entry));
}
    // rust: rows
}

/// `AbstractSelectionList.contentHeight`.
pub fn content_height(n: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: n as f32 * ITEM + 4.0
}
/// `getRowLeft`: the list spans the screen, its rows centred.
pub fn row_left(w: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (w / 2.0).floor() - ROW_WIDTH / 2.0
}
/// The three buttons' left edges (Off, In Overlay, Always) for a row whose
/// content starts at `x` (`extractContent`).
pub fn button_xs(content_x: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = content_x + ROW_WIDTH - 4.0 - 3.0 * BUTTON;
    // rust: [start, start + BUTTON, start + 2.0 * BUTTON]
}
/// The footer buttons' left edges and their row's top.
pub fn footer(w: f32, h: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let total: f32 = FOOTER_BUTTONS.iter().sum::<f32>() + 3.0 * 4.0;
    // rust: let mut x = ((w - total) / 2.0).floor();
    // rust: let mut xs = [0.0; 4];
    // rust: for (slot, width) in xs.iter_mut().zip(FOOTER_BUTTONS) {
    // rust: *slot = x;
    // rust: x += width + 4.0;
}
    // rust: (xs, h - FOOTER + ((FOOTER - 20.0) / 2.0).floor())
}
/// The three buttons' statuses and texts, in their order on the row.
    // rust: const BUTTONS: [(Status, &str, u32); 3] = [
    // rust: (Status::Never, "options.off", 0xFF_FFFF),
    // rust: (Status::InOverlay, "debug.entry.overlay", OVERLAY),
    // rust: (Status::AlwaysOn, "debug.entry.always", WARNING),
    // rust: ];

    // rust: impl Game<'_> {
    /// `KeyboardHandler`'s F3+F6: closes the screen if it is open, else opens
    /// it over whatever screen yields (`canInterruptScreen`), closing that
    /// screen first.
    // rust: pub(super) fn toggle_debug_options(&mut self) {
    // rust: if self.screen == Screen::DebugOptions {
    // rust: self.close_debug_options();
    // rust: return;
}
    // rust: if !debug_options_interrupts(self.screen, self.screen_over_playing()) {
    // rust: return;
}
    // rust: self.close_screen_behind_debug_options();
    // rust: let mut search = EditBox::new(0.0, 0.0, (ROW_WIDTH / 3.0).floor(), 20.0);
    // rust: search.max_length = 32;
    // rust: self.debug_options = Some(DebugOptionsUi {
    // rust: search,
    // rust: scroll: Scroll::default(),
    // rust: });
    // rust: self.screen = Screen::DebugOptions;
    // rust: self.pause_menu = true;
    // rust: self.capture(false);
    // rust: self.mining = None;
}
    /// The interrupted screen's own close (`Screen.onClose`): the containers
    /// hand their state back and a mod's hooks hear of the screen going. A
    /// screen whose close only swaps the screen (stats, links, the pause menu)
    /// yields by being overwritten instead.
pub fn close_screen_behind_debug_options(self: *Self) void {
}
    // rust: match self.screen {
    // rust: Screen::Inventory => {
    // rust: self.close_container();
    // rust: self.pause_focus = None;
    // rust: self.screen = Screen::Playing;
    // rust: self.pause_menu = true;
    // rust: self.capture(true);
}
    // rust: Screen::Creative => {
    // rust: self.pad_clear_focus();
    // rust: self.carried = None;
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
    // rust: Screen::Mod => self.close_mod_screen(),
    // rust: _ => {}
}
}
    /// `Screen.onClose`: back to the game.
    // rust: pub(super) fn close_debug_options(&mut self) {
    // rust: self.debug_options = None;
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
    /// The header's title row and warning (`init`'s vertical layout,
    /// centred in the header): the title's x, the row's top, the warning's
    /// lines with their y.
pub fn debug_options_header(self: *Self, w: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let font = &self.gui.atlas.font;
    // rust: let title = Text::translate("debug.options.title", &[]);
    // rust: let warning = Text::translate("debug.options.warning", &[]).with_color(WARNING);
    // rust: let lines = font.split(&warning, ROW_WIDTH);
    // rust: let height = 20.0 + 8.0 + lines.len() as f32 * 9.0;
    // rust: let top = ((HEADER - height) / 2.0).floor();
    // rust: let third = (ROW_WIDTH / 3.0).floor();
    // rust: let tw = font.width_text(&title);
    // rust: let row = third + 8.0 + tw + 8.0 + third;
    // rust: let title_x = ((w - row) / 2.0).floor() + third + 8.0;
    // rust: let lines = lines
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(i, line)| (line, top + 28.0 + i as f32 * 9.0))
    // rust: .collect();
    // rust: (title_x, top, lines)
}
    /// `debugGuiScale`'s button: `GUI Scale: Unchanged`, `Auto` or the scale.
pub fn debug_gui_scale_label(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value = match self.settings.file.int("debugGuiScale") {
    // rust: -1 => Text::translate("options.debugGuiScale.unchanged", &[]),
    // rust: 0 => Text::translate("options.guiScale.auto", &[]),
    // rust: n => Text::literal(n.to_string()),
}
    // rust: Text::translate(
    // rust: "options.generic_value",
    // rust: &[Text::translate("options.guiScale", &[]), value],
    // rust: )
}
    /// `ClampingLazyMaxIntRange(-1, window.calculateScale(0, unicode))` as a
    /// CycleButton: the next value, or the previous one with Shift.
pub fn cycle_debug_gui_scale(self: *Self, back: bool) void {
}
    // rust: let size = self.renderer.as_ref().map_or([1280, 720], |r| {
    // rust: [r.config.width as i32, r.config.height as i32]
    // rust: });
    // rust: let max = horizon_client::window::calculate_scale(size, 0, self.settings.force_unicode);
    // rust: let current = self.settings.file.int("debugGuiScale").clamp(-1, max);
    // rust: let next = match (back, current) {
    // rust: (false, c) if c >= max => -1,
    // rust: (false, c) => c + 1,
    // rust: (true, -1) => max,
    // rust: (true, c) => c - 1,
}
    // rust: self.settings.file.set("debugGuiScale", V::Int(next));
    // rust: self.settings.save(&Self::options_path());
}
    // rust: pub(super) fn draw_debug_options(&mut self, batch: &mut HudBatch) {
    // rust: let Some(mut s) = self.debug_options.take() else {
    // rust: return;
}
    // rust: let (w, h) = (batch.width, batch.height);
        // extractBlurredBackground: the debug overlay goes under the screen.
    // rust: let size = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or([w as u32, h as u32], |r| [r.config.width, r.config.height]);
    // rust: self.draw_debug_overlay_under(batch, size);
    // rust: let atlas = &self.gui.atlas;
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, true);
    // rust: let reduced = self.reduced_debug_info();
    // rust: let rows = rows(&s.search.value);
    // rust: let (top, bottom) = (HEADER, h - FOOTER);
    // rust: let content = content_height(rows.len());
    // rust: s.scroll.clamp(top, bottom, content);
        // The list: background, rows clipped to it, separators, scrollbar.
    // rust: ui::list_background(batch, atlas, top, bottom, true);
    // rust: let first = batch.vertices.len();
    // rust: let left = row_left(w);
    // rust: let inside = self.cursor.1 >= top && self.cursor.1 < bottom;
    // rust: let mut tooltip = None;
    // rust: for (i, row) in rows.iter().enumerate() {
    // rust: let y = top + 2.0 - s.scroll.amount.trunc() + i as f32 * ITEM;
    // rust: if y + ITEM < top || y > bottom {
    // rust: continue;
}
    // rust: let (cx, cy) = (left + 2.0, y + 2.0);
    // rust: match row {
    // rust: Row::Category(category) => {
    // rust: let label = Text::translate(category.translation_key(), &[])
    // rust: .bold()
    // rust: .underlined();
    // rust: let lw = atlas.font.width_text(&label);
    // rust: let lx = (cx + (ROW_WIDTH - 4.0) / 2.0 - (lw + 8.0) / 2.0).floor() + 4.0;
    // rust: batch.text_styled(atlas, &label, lx, cy + 4.0, u32::MAX, true);
}
    // rust: Row::Option(entry) => {
    // rust: let allowed = entry.reduced || !reduced;
    // rust: let name = if allowed {
    // rust: Text::literal(entry.path)
    // rust: } else {
    // rust: Text::literal(entry.path).italic().with_color(NOT_ALLOWED)
}
    // rust: batch.text_styled(atlas, &name, cx, cy + 5.0, u32::MAX, true);
    // rust: let xs = button_xs(cx);
    // rust: let status = self.debug_entries.status(entry.path);
    // rust: for ((status_of, key, color), x) in BUTTONS.into_iter().zip(xs) {
    // rust: let selected = status == status_of;
    // rust: let label = Text::translate(key, &[]).with_color(if selected {
    // rust: color
    // rust: } else {
    // rust: UNSELECTED
    // rust: });
    // rust: let hover = inside && ui::hovered(self.cursor, x, cy, BUTTON, 16.0);
    // rust: ui::button(batch, atlas, x, cy, BUTTON, 16.0, &label, !selected, hover);
}
    // rust: if !allowed && inside && ui::hovered(self.cursor, cx, y, xs[0] - cx, ITEM) {
    // rust: tooltip = Some(Text::translate("debug.options.notAllowed.tooltip", &[]));
}
}
}
}
    // rust: batch.clip_since(first, 0.0, top, w, bottom);
    // rust: ui::separators(batch, atlas, top, bottom, true);
    // rust: ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: left + ROW_WIDTH + 8.0,
    // rust: top,
    // rust: bottom,
    // rust: content,
    // rust: s.scroll.amount.trunc(),
    // rust: );
        // The header: title, search box, warning.
    // rust: let (title_x, header_top, lines) = self.debug_options_header(w);
    // rust: let title = Text::translate("debug.options.title", &[]);
    // rust: batch.text_styled(atlas, &title, title_x, header_top + 5.0, u32::MAX, true);
    // rust: s.search.x = title_x + atlas.font.width_text(&title) + 8.0;
    // rust: s.search.y = header_top;
    // rust: s.search.draw(batch, atlas, None);
    // rust: if s.search.value.is_empty() {
    // rust: let hint = Text::translate("debug.options.search", &[])
    // rust: .with_color(HINT)
    // rust: .italic();
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &hint,
    // rust: s.search.text_x(),
    // rust: s.search.text_y(),
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: for (line, y) in &lines {
    // rust: let lw = atlas.font.width_text(line);
    // rust: batch.text_styled(atlas, line, ((w - lw) / 2.0).floor(), *y, u32::MAX, true);
}
        // The footer.
    // rust: let (xs, fy) = footer(w, h);
    // rust: let labels = [
    // rust: Text::translate(Profile::Default.translation_key(), &[]),
    // rust: Text::translate(Profile::Performance.translation_key(), &[]),
    // rust: self.debug_gui_scale_label(),
    // rust: Text::translate("gui.done", &[]),
    // rust: ];
    // rust: let active = [
    // rust: !self.debug_entries.is_using_profile(Profile::Default),
    // rust: !self.debug_entries.is_using_profile(Profile::Performance),
    // rust: true,
    // rust: true,
    // rust: ];
    // rust: for (i, label) in labels.iter().enumerate() {
    // rust: let hover = ui::hovered(self.cursor, xs[i], fy, FOOTER_BUTTONS[i], 20.0);
    // rust: if i == 3 {
    // rust: horizon_client::widgets::declare_action(
    // rust: horizon_client::widgets::Action::Done,
    // rust: [xs[i], fy, FOOTER_BUTTONS[i], 20.0],
    // rust: true,
    // rust: );
}
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: xs[i],
    // rust: fy,
    // rust: FOOTER_BUTTONS[i],
    // rust: 20.0,
    // rust: label,
    // rust: active[i],
    // rust: hover,
    // rust: );
    // rust: if i == 2 && hover {
    // rust: tooltip = Some(Text::translate("options.debugGuiScale.tooltip", &[]));
}
}
    // rust: if let Some(tooltip) = tooltip {
    // rust: let lines = atlas.font.split(&tooltip, 200.0);
    // rust: ui::tooltip(batch, atlas, &lines, self.cursor);
}
    // rust: self.debug_options = Some(s);
}
    /// A left click: a status button, the search box, a footer button.
    // rust: pub(super) fn debug_options_click(&mut self) {
    // rust: let Some(mut s) = self.debug_options.take() else {
    // rust: return;
}
    // rust: let (w, h) = self.gui_size();
    // rust: let (top, bottom) = (HEADER, h - FOOTER);
    // rust: let rows = rows(&s.search.value);
    // rust: let left = row_left(w);
        // A press on the scrollbar holds it and clicks nothing else.
    // rust: if s.scroll.press(
    // rust: self.cursor,
    // rust: left + ROW_WIDTH + 8.0,
    // rust: top,
    // rust: bottom,
    // rust: content_height(rows.len()),
    // rust: ) {
    // rust: self.debug_options = Some(s);
    // rust: return;
}
    // rust: let shift = self.has_shift_down();
    // rust: s.search.focused = ui::hovered(
    // rust: self.cursor,
    // rust: s.search.x,
    // rust: s.search.y,
    // rust: s.search.width,
    // rust: s.search.height,
    // rust: );
    // rust: if s.search.focused {
    // rust: s.search.click(&self.gui.atlas, self.cursor.0, shift, false);
}
    // rust: let inside = self.cursor.1 >= top && self.cursor.1 < bottom;
    // rust: let mut clicked = None;
    // rust: if inside {
    // rust: for (i, row) in rows.iter().enumerate() {
    // rust: let Row::Option(entry) = row else { continue };
    // rust: let cy = top + 2.0 - s.scroll.amount.trunc() + i as f32 * ITEM + 2.0;
    // rust: let status = self.debug_entries.status(entry.path);
    // rust: for ((status_of, _, _), x) in BUTTONS.into_iter().zip(button_xs(left + 2.0)) {
    // rust: if status != status_of && ui::hovered(self.cursor, x, cy, BUTTON, 16.0) {
    // rust: clicked = Some((entry.path, status_of));
}
}
}
}
    // rust: self.debug_options = Some(s);
    // rust: if let Some((path, status)) = clicked {
            // OptionEntry.setValue.
    // rust: self.audio.play_button_click();
    // rust: self.debug_entries.set_status(path, status);
    // rust: return;
}
    // rust: let (xs, fy) = footer(w, h);
    // rust: let Some(i) =
    // rust: (0..4).find(|&i| ui::hovered(self.cursor, xs[i], fy, FOOTER_BUTTONS[i], 20.0))
    // rust: else {
    // rust: return;
}
    // rust: match i {
    // rust: 0 | 1 => {
    // rust: let profile = if i == 0 {
    // rust: Profile::Default
    // rust: } else {
    // rust: Profile::Performance
}
    // rust: if self.debug_entries.is_using_profile(profile) {
    // rust: return;
}
    // rust: self.audio.play_button_click();
    // rust: self.debug_entries.load_profile(profile);
}
    // rust: 2 => {
    // rust: self.audio.play_button_click();
    // rust: self.cycle_debug_gui_scale(shift);
}
    // rust: _ => {
    // rust: self.audio.play_button_click();
    // rust: self.close_debug_options();
}
}
}
    /// The mouse wheel over the list (`scrollRate`: half a row).
    // rust: pub(super) fn debug_options_scroll(&mut self, delta: f32) {
    // rust: let (_, h) = self.gui_size();
    // rust: if let Some(s) = &mut self.debug_options {
    // rust: let content = content_height(rows(&s.search.value).len());
    // rust: s.scroll
    // rust: .wheel(delta, ITEM / 2.0, HEADER, h - FOOTER, content);
}
}
    /// The pointer moved while the list's scrollbar is held.
    // rust: pub(super) fn debug_options_drag(&mut self) {
    // rust: let (_, h) = self.gui_size();
    // rust: let y = self.cursor.1;
    // rust: if let Some(s) = &mut self.debug_options
    // rust: && s.scroll.held()
    // rust: {
    // rust: let content = content_height(rows(&s.search.value).len());
    // rust: s.scroll.drag(y, HEADER, h - FOOTER, content);
}
}
    /// The button came up: the scrollbar lets go.
    // rust: pub(super) fn debug_options_release(&mut self) {
    // rust: if let Some(s) = &mut self.debug_options {
    // rust: s.scroll.release();
}
}
    /// A key the debug keys left: Escape closes, the rest edits the search.
    // rust: pub(super) fn debug_options_key(&mut self, event: &KeyEvent) {
    // rust: if event.state != ElementState::Pressed {
    // rust: return;
}
    // rust: let PhysicalKey::Code(key) = event.physical_key else {
    // rust: return;
}
    // rust: if key == KeyCode::Escape {
    // rust: self.close_debug_options();
    // rust: return;
}
    // rust: let shortcut = self.edit_shortcut(event);
    // rust: let ctrl = self.has_control_down_with_quirk();
    // rust: let shift = self.has_shift_down();
    // rust: let types_text = self.types_text();
    // rust: let Some(s) = &mut self.debug_options else {
    // rust: return;
}
    // rust: if !s.search.focused {
    // rust: return;
}
    // rust: if let Some(shortcut) = shortcut {
    // rust: s.search.shortcut(shortcut, &mut self.clipboard);
    // rust: } else if !s.search.key(key, ctrl, shift)
    // rust: && types_text
    // rust: && let Some(text) = event.text.as_deref()
    // rust: {
    // rust: self.debug_options_type(text);
}
}
    /// One character off the search box, for the controller's on-screen keyboard.
    // rust: pub(super) fn debug_options_backspace(&mut self) {
    // rust: if let Some(s) = &mut self.debug_options
    // rust: && s.search.focused
    // rust: {
    // rust: s.search.key(KeyCode::Backspace, false, false);
}
}
    /// Characters typed into the search box (`EditBox.charTyped`).
    // rust: pub(super) fn debug_options_type(&mut self, typed: &str) {
    // rust: let allowed: String = typed
    // rust: .chars()
    // rust: .filter(|&c| c != '\u{a7}' && c >= ' ' && c != '\u{7f}')
    // rust: .collect();
    // rust: if let Some(s) = &mut self.debug_options
    // rust: && s.search.focused
    // rust: && !allowed.is_empty()
    // rust: {
    // rust: s.search.insert_text(&allowed);
}
}
}

/// `Minecraft.canInterruptScreen` (Gui): whether F3+F6 opens the debug
/// options screen over `screen`, closing it first. `Screen
/// .canInterruptWithAnotherScreen` defaults to `shouldCloseOnEsc`, so every
/// screen Escape closes yields; the death screen and the level teardown keep
/// theirs, and the title never reaches the debug keys. The text-box screens
/// (chat, options, sign, book, the search tabs) do not reach it either: a
/// focused box takes every key press first. A playing overlay (a dialog, a
/// prompt) keeps its own Esc. The credits' close is fallible and this path is
/// not, so it keeps its screen too (vanilla interrupts it).
pub fn debug_options_interrupts(screen: Screen, playing_overlay: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match screen {
    // rust: Screen::Playing | Screen::Paused => !playing_overlay,
    // rust: Screen::Inventory
    // rust: | Screen::Creative
    // rust: | Screen::GameModeSwitcher
    // rust: | Screen::EmoteWheel
    // rust: | Screen::Stats
    // rust: | Screen::Advancements
    // rust: | Screen::Friends
    // rust: | Screen::Social
    // rust: | Screen::ServerLinks
    // rust: | Screen::ConfirmLink
    // rust: | Screen::DialogWarning
    // rust: | Screen::Mod => true,
    // rust: Screen::Chat
    // rust: | Screen::Options
    // rust: | Screen::WorldOptions
    // rust: | Screen::CommandBlock
    // rust: | Screen::BlockEditor
    // rust: | Screen::Dead
    // rust: | Screen::Win
    // rust: | Screen::DebugOptions
    // rust: | Screen::HudEditor => false,
}
}

    // rust: mod tests {
//     use super::*;

pub fn rows_put_a_category_before_each_section() void {
}
    // rust: let all = rows("");
    // rust: assert_eq!(all.len(), 48);
    // rust: assert!(matches!(all[0], Row::Category(Category::Text)));
    // rust: let renderer = all
    // rust: .iter()
    // rust: .position(|r| matches!(r, Row::Category(Category::Renderer)))
    // rust: .unwrap();
    // rust: assert!(matches!(all[renderer + 1], Row::Option(e) if e.path == "3d_crosshair"));
        // A search inside one section shows only its heading.
    // rust: let hitboxes = rows("hitbox");
    // rust: assert_eq!(hitboxes.len(), 2);
    // rust: assert!(matches!(hitboxes[0], Row::Category(Category::Renderer)));
}

pub fn the_layout_matches_vanilla_at_854_by_480() void {
}
        // 854x480 at GUI scale 2 is 427x240.
    // rust: assert_eq!(row_left(427.0), 38.0);
    // rust: assert_eq!(button_xs(40.0), [206.0, 266.0, 326.0]);
    // rust: assert_eq!(footer(427.0, 240.0), ([2.0, 126.0, 250.0, 364.0], 213.0));
}

    /// F3+F6 interrupts every screen whose Esc would close it
    /// (`Minecraft.canInterruptScreen`), and none whose would not.
pub fn the_debug_options_screen_interrupts_what_escape_would_close() void {
}
    // rust: assert!(debug_options_interrupts(Screen::Playing, false));
    // rust: assert!(debug_options_interrupts(Screen::Paused, false));
    // rust: assert!(!debug_options_interrupts(Screen::Playing, true));
    // rust: assert!(!debug_options_interrupts(Screen::Paused, true));
    // rust: for screen in [
    // rust: Screen::Inventory,
    // rust: Screen::Creative,
    // rust: Screen::GameModeSwitcher,
    // rust: Screen::Stats,
    // rust: Screen::Advancements,
    // rust: Screen::Friends,
    // rust: Screen::Social,
    // rust: Screen::ServerLinks,
    // rust: Screen::ConfirmLink,
    // rust: Screen::DialogWarning,
    // rust: Screen::Mod,
    // rust: ] {
    // rust: assert!(
    // rust: debug_options_interrupts(screen, false),
    // rust: "{} yields",
    // rust: screen.id()
    // rust: );
}
    // rust: for screen in [
    // rust: Screen::Dead,
    // rust: Screen::Chat,
    // rust: Screen::Options,
    // rust: Screen::WorldOptions,
    // rust: Screen::CommandBlock,
    // rust: Screen::BlockEditor,
    // rust: Screen::Win,
    // rust: ] {
    // rust: assert!(
    // rust: !debug_options_interrupts(screen, false),
    // rust: "{} keeps its screen",
    // rust: screen.id()
    // rust: );
}
}
}
