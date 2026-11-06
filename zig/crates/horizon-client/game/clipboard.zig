//! Transpiled from Horizon Rust crate
//! Module: horizon-client_clipboard
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Copy and paste in the text fields: `KeyboardHandler`'s clipboard and the
//! shortcuts of `EditBox`, `MultiLineEditBox` and `TextFieldHelper`.
// use super::*;
// use horizon_client::clipboard::{self, EditShortcut};
// use winit::event::KeyEvent;

    // rust: impl Game<'_> {
    /// `InputWithModifiers.isSelectAll`/`isCopy`/`isPaste`/`isCut` of a key
    /// press (or repeat): the keyboard's modifier state, or a modifier key an
    /// agent holds.
    // rust: pub(super) fn edit_shortcut(&self, event: &KeyEvent) -> Option<EditShortcut> {
    // rust: if event.state != ElementState::Pressed {
    // rust: return None;
}
    // rust: let m = self.modifiers;
    // rust: let held = |keys: [KeyCode; 2]| keys.iter().any(|k| self.keys.raw(k));
    // rust: clipboard::edit_shortcut(
    // rust: clipboard::shortcut_letter(&event.logical_key, event.physical_key),
    // rust: self.has_control_down_with_quirk(),
    // rust: m.shift_key() || held([KeyCode::ShiftLeft, KeyCode::ShiftRight]),
    // rust: m.alt_key() || held([KeyCode::AltLeft, KeyCode::AltRight]),
    // rust: )
}
    /// `InputWithModifiers.hasControlDownWithQuirk`: the edit shortcuts'
    /// modifier (`InputQuirks.EDIT_SHORTCUT_KEY_MODIFIER`: Cmd on macOS, Ctrl
    /// elsewhere), held on the keyboard or by an agent.
    // rust: pub(super) fn has_control_down_with_quirk(&self) -> bool {
    // rust: let held = |keys: [KeyCode; 2]| keys.iter().any(|k| self.keys.raw(k));
    // rust: if cfg!(target_os = "macos") {
    // rust: self.modifiers.super_key() || held([KeyCode::SuperLeft, KeyCode::SuperRight])
    // rust: } else {
    // rust: self.modifiers.control_key() || held([KeyCode::ControlLeft, KeyCode::ControlRight])
}
}
    /// Whether the held keys let a key's text through to the focused field
    /// (`clipboard::types_text`): not with the edit modifier, unless it is
    /// part of AltGr.
    // rust: pub(super) fn types_text(&self) -> bool {
    // rust: let held = |keys: [KeyCode; 2]| keys.iter().any(|k| self.physical_keys.contains(k));
    // rust: let edit = if cfg!(target_os = "macos") {
    // rust: held([KeyCode::SuperLeft, KeyCode::SuperRight])
    // rust: } else {
    // rust: held([KeyCode::ControlLeft, KeyCode::ControlRight])
}
    // rust: clipboard::types_text(
    // rust: edit,
    // rust: held([KeyCode::AltLeft, KeyCode::AltRight]),
    // rust: clipboard::ALTGR_IS_CTRL_ALT,
    // rust: )
}
    /// A shortcut in an append-only field limited to `max_chars` characters
    /// (an `EditBox` with `setMaxLength`). True when the value changed.
    // rust: pub(super) fn append_shortcut(
    // rust: selection: &mut clipboard::AppendSelection,
    // rust: board: &mut clipboard::SystemClipboard,
    // rust: id: clipboard::FieldId,
    // rust: value: &mut String,
    // rust: shortcut: EditShortcut,
    // rust: max_chars: usize,
    // rust: ) -> bool {
    // rust: selection.apply(id, value, shortcut, board, |v, t| {
    // rust: clipboard::append_limited(v, t, max_chars)
    // rust: })
}
    /// Shortcuts on the title, world creation and server screens.
    // rust: pub(super) fn title_shortcut(&mut self, shortcut: EditShortcut) {
    // rust: let Some(title) = self.title.as_mut() else {
    // rust: return;
}
    // rust: if title.has_caret_field() {
    // rust: return title.field_shortcut(shortcut, &mut self.clipboard);
}
    // rust: if let Some((id, value, max)) = title.focused_field() {
    // rust: let changed = Self::append_shortcut(
    // rust: &mut self.text_selection,
    // rust: &mut self.clipboard,
    // rust: id,
    // rust: value,
    // rust: shortcut,
    // rust: max,
    // rust: );
    // rust: if changed {
    // rust: title.search_changed();
}
}
}
    /// Typing or a backspace in a title-screen field. A field that still only
    /// appends replaces a Select All selection before the edit.
    // rust: pub(super) fn title_edit(&mut self, typed: Option<&str>, backspace: bool) {
    // rust: let Some(title) = self.title.as_mut() else {
    // rust: return;
}
    // rust: let cleared = !title.has_caret_field()
    // rust: && title
    // rust: .focused_field()
    // rust: .is_some_and(|(id, value, _)| self.text_selection.take(id, value));
    // rust: if cleared {
    // rust: title.search_changed();
}
    // rust: if backspace {
    // rust: if !cleared {
    // rust: title.backspace();
}
    // rust: } else if let Some(text) = typed {
    // rust: title.type_text(text);
}
}
    /// Shortcuts in the creative inventory's search box (an `EditBox` of 50).
    // rust: pub(super) fn creative_search_shortcut(&mut self, shortcut: EditShortcut) {
    // rust: if self
    // rust: .creative_screen
    // rust: .search
    // rust: .shortcut(shortcut, &mut self.clipboard)
    // rust: {
    // rust: self.creative_screen.scroll = 0.0;
}
}
    /// A backspace in the creative search box: with Ctrl, the whole word
    /// before the caret (`EditBox.deleteWords(-1)`), otherwise one character.
    /// A selection is what it deletes, as in `EditBox.keyPressed`.
    // rust: pub(super) fn creative_search_backspace(&mut self, ctrl: bool) {
    // rust: self.creative_screen
    // rust: .search
    // rust: .key(KeyCode::Backspace, ctrl, false);
    // rust: self.creative_screen.scroll = 0.0;
}
    /// Typing in the creative search box.
    // rust: pub(super) fn creative_search_edit(&mut self, typed: Option<&str>) {
    // rust: if let Some(text) = typed {
    // rust: self.creative_screen.search.insert_text(text);
    // rust: self.creative_screen.scroll = 0.0;
}
}
}

/// `CreativeModeInventoryScreen`'s search box: `setMaxLength(50)`.
    // rust: pub(super) const CREATIVE_SEARCH_CHARS: usize = 50;
