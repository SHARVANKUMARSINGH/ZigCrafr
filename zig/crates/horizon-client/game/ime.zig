//! Transpiled from Horizon Rust crate
//! Module: horizon-client_ime
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Input method (IME) text: committed composition goes to the focused text
//! field through the same sinks the keyboard and `horizon-ctl type` use.
//! The window only asks the OS for an input method while such a field has
//! focus, so movement keys keep arriving as plain key events.
// use super::{Game, Screen, books::BookScreen};
// use horizon_client::{
    // rust: hud::HudBatch,
    // rust: preedit::{self, PreeditEvent},
}

    // rust: impl Game<'_> {
    /// Whether a text box has focus right now (the fields `ime_commit` can fill).
    // rust: pub(super) fn text_field_focused(&mut self) -> bool {
    // rust: if self.dialog_open() {
    // rust: return self.dialog_has_text_field();
}
    // rust: if let Some(title) = self.title.as_mut() {
            // A caret field, an append-only one (`focused_field`), or a game
            // rule's box (`has_caret_field` asks the rules screen itself, and
            // `title_edit` types into it).
    // rust: return title.has_caret_field() || title.focused_field().is_some();
}
    // rust: if self.sign_edit.is_some() || matches!(self.book, Some(BookScreen::Edit { .. })) {
    // rust: return true;
}
    // rust: match self.screen {
    // rust: Screen::Chat | Screen::CommandBlock | Screen::Social => true,
    // rust: Screen::DebugOptions => self
    // rust: .debug_options
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.search_focused()),
            // The language list's search, the settings search and the pack
            // screen's search (OptionsUi::typing).
    // rust: Screen::Options => self.ui.options.typing(),
    // rust: Screen::WorldOptions => self.world_options_typing(),
    // rust: Screen::Creative => self.creative_screen.tab().search,
    // rust: Screen::BlockEditor => self.block_editor.as_ref().is_some_and(|s| s.text_focused()),
    // rust: Screen::Inventory => {
    // rust: self.mod_browser_typing() || self.recipe_search_focused() || self.station_typing()
}
    // rust: _ => false,
}
}

    /// Allow the input method only while a text box has focus.
    // rust: pub(super) fn sync_ime(&mut self) {
    // rust: let want = self.text_field_focused();
    // rust: if want != self.ime_allowed
    // rust: && let Some(window) = &self.window
    // rust: {
    // rust: window.set_ime_allowed(want);
    // rust: self.ime_allowed = want;
            // The field lost the focus (or a new one took it): the composition
            // and the candidate window's place belong to the old one.
    // rust: self.ime_area = None;
    // rust: if !want {
    // rust: preedit::set_preedit(None);
}
}
}

    /// `WindowEvent::Ime(Preedit)`: `KeyboardHandler.textEditing`. The text
    /// still being composed is shown under the focused field's caret.
    // rust: pub(super) fn ime_preedit(&mut self, text: &str, cursor: Option<(usize, usize)>) {
    // rust: preedit::set_preedit(
    // rust: self.text_field_focused()
    // rust: .then(|| PreeditEvent::from_winit(text, cursor))
    // rust: .flatten(),
    // rust: );
}

    /// With the frame's GUI built: draw the composition over it and move the
    /// input method's candidate window to the caret
    /// (`TextInputManager.setTextInputArea`, in window pixels).
    // rust: pub(super) fn flush_ime(&mut self, hud: &mut HudBatch) {
    // rust: preedit::draw_overlay(hud, &self.gui.atlas);
    // rust: let Some([x0, y0, x1, y1]) = preedit::take_text_input_area() else {
    // rust: return;
}
    // rust: let scale = hud.scale;
    // rust: let x = (x0 * scale).round() as i32;
    // rust: let y = (y0 * scale).round() as i32;
    // rust: let width = (((x1 - x0) * scale).round() as i32).max(1);
    // rust: let height = (((y1 - y0) * scale).round() as i32).max(1);
    // rust: let area = [x, y, width, height];
    // rust: if self.ime_area == Some(area) {
    // rust: return;
}
    // rust: if let Some(window) = &self.window
    // rust: && self.ime_allowed
    // rust: {
    // rust: window.set_ime_cursor_area(
    // rust: winit::dpi::PhysicalPosition::new(x, y),
    // rust: winit::dpi::PhysicalSize::new(width as u32, height as u32),
    // rust: );
    // rust: self.ime_area = Some(area);
}
}

    /// Text the input method committed (`WindowEvent::Ime(Commit)`).
    // rust: pub(super) fn ime_commit(&mut self, text: &str) {
    // rust: preedit::set_preedit(None);
    // rust: let text: String = text.chars().filter(|c| !c.is_control()).collect();
        // ScreenEvent.CharacterTyped.Pre: the input method's committed text
        // reaches a text box by characters, as a key's own text does, so the
        // open screen hears of each of them first and a cancelled one never
        // reaches the box.
    // rust: let Some(text) = self.screen_text_typed(&text) else {
    // rust: return;
}
    // rust: if text.is_empty() || !self.text_field_focused() {
    // rust: return;
}
    // rust: if self.dialog_type(&text) {
    // rust: return;
}
    // rust: if self.title.is_some() {
    // rust: self.title_edit(Some(&text), false);
    // rust: } else if self.book.is_some() {
    // rust: self.book_input(None, Some(&text));
    // rust: } else if self.sign_edit.is_some() {
    // rust: self.sign_input(None, Some(&text));
    // rust: } else {
    // rust: match self.screen {
    // rust: Screen::Chat => self.chat_type(&text),
    // rust: Screen::CommandBlock => self.command_block_type(&text),
    // rust: Screen::Social => self.social_type(&text),
    // rust: Screen::DebugOptions => self.debug_options_type(&text),
    // rust: Screen::Options => self.ui.options.type_text(&self.gui.atlas, &text),
    // rust: Screen::WorldOptions => self.world_options_text(Some(&text)),
    // rust: Screen::Creative => self.creative_search_edit(Some(&text)),
    // rust: Screen::BlockEditor => self.block_editor_type(&text),
    // rust: Screen::Inventory if self.mod_browser_typing() => {
    // rust: self.mod_browser_text(Some(&text), false)
}
    // rust: Screen::Inventory if self.recipe_search_focused() => {
    // rust: self.recipe_text(Some(&text), false)
}
    // rust: Screen::Inventory => self.station_text(Some(&text), false),
    // rust: _ => {}
}
}
}
}
