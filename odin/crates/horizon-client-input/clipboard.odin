//! Transpiled from Horizon Rust crate
package horizon_client_input_clipboard

import "core:fmt"
import "core:mem"
import "core:math"

// The system clipboard and the text-editing shortcuts of 26.3:
// `KeyboardHandler.getClipboard`/`setClipboard`, `InputWithModifiers.isSelectAll`,
// `isCopy`, `isPaste` and `isCut`, `StringUtil.filterText` and
// `ChatFormatting.stripFormatting`.

// use winit::keyboard::{Key, KeyCode, PhysicalKey};

// A text-editing shortcut (`InputWithModifiers.isSelectAll`, `isCopy`,
// `isPaste`, `isCut`).
EditShortcut :: enum {
    SelectAll,
    Copy,
    Paste,
    Cut,
}

// The letter a key stands for in shortcuts (`KeyEvent.shortcutKey`, SDL's
// keycode): the layout's letter, or the key's US-layout letter when the
// layout's is not a Latin one (SDL's default `latin_letters` keycode option).
shortcut_letter :: proc(logical: ^Key, physical: PhysicalKey) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Key::Character(s) = logical {
    // rust: let mut chars = s.chars();
    // rust: if let (Some(c), None) = (chars.next(), chars.next())
    // rust: && c.is_ascii_alphabetic()
    // rust: {
    // rust: return Some(c.to_ascii_lowercase());
}
}
    // rust: let PhysicalKey::Code(code) = physical else {
    // rust: return None;
}
    // rust: Some(match code {
    // rust: KeyCode::KeyA => 'a',
    // rust: KeyCode::KeyC => 'c',
    // rust: KeyCode::KeyV => 'v',
    // rust: KeyCode::KeyX => 'x',
    // rust: _ => return None,
    // rust: })
}

// `InputWithModifiers.isSelectAll`/`isCopy`/`isPaste`/`isCut`: A, C, V or X
// with the edit modifier (`InputQuirks.EDIT_SHORTCUT_KEY_MODIFIER`: Cmd on
// macOS, Ctrl elsewhere) and neither Shift nor Alt.
    // rust: pub fn edit_shortcut(
    // rust: letter: Option<char>,
    // rust: edit_modifier: bool,
    // rust: shift: bool,
    // rust: alt: bool,
    // rust: ) -> Option<EditShortcut> {
    // rust: if !edit_modifier || shift || alt {
    // rust: return None;
}
    // rust: Some(match letter? {
    // rust: 'a' => EditShortcut::SelectAll,
    // rust: 'c' => EditShortcut::Copy,
    // rust: 'v' => EditShortcut::Paste,
    // rust: 'x' => EditShortcut::Cut,
    // rust: _ => return None,
    // rust: })
}

// Windows reports AltGr as Ctrl plus Alt: the system presses a left Control
// in front of the right Alt.
ALTGR_IS_CTRL_ALT :: cfg!(windows)

// Whether a key's text reaches the screen (`KeyboardHandler.textInput`, then
// `charTyped` per code point). The edit modifier's shortcuts type nothing,
// but `textInput` takes no modifiers: with AltGr held (Ctrl plus Alt where
// `altgr_is_ctrl_alt`) the layout's third-level characters are text, as `/`
// on ABNT2, `@`, `{` and `[` on German or the Polish letters.
types_text :: proc(edit_modifier: bool, alt: bool, altgr_is_ctrl_alt: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !edit_modifier || (altgr_is_ctrl_alt && alt)
}

// `StringUtil.isAllowedChatCharacter`.
is_allowed_chat_character :: proc(c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: c != '§' && c >= ' ' && c != '\u{7f}'
}

// `StringUtil.filterText`: the allowed characters, and line breaks where
// the field takes several lines.
filter_text :: proc(input: string, multiline: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: input
    // rust: .chars()
    // rust: .filter(|&c| is_allowed_chat_character(c) || (multiline && c == '\n'))
    // rust: .collect()
}

// `ChatFormatting.stripFormatting`: `§` followed by a format code removed.
strip_formatting :: proc(input: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(input.len());
    // rust: let mut chars = input.chars().peekable();
    // rust: while let Some(c) = chars.next() {
    // rust: if c == '§'
    // rust: && chars.peek().is_some_and(
    // rust: |n| matches!(n.to_ascii_lowercase(), '0'..='9' | 'a'..='f' | 'k'..='o' | 'r'),
    // rust: )
    // rust: {
    // rust: chars.next();
    // rust: continue;
}
    // rust: out.push(c);
}
    // rust: out
}

// `TextFieldHelper.getClipboardContents`: formatting and carriage returns
// removed (signs).
helper_clipboard_contents :: proc(clipboard: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: strip_formatting(&clipboard.replace('\r', ""))
}

// A clipboard: the system's, or an in-memory one in tests.
    // rust: pub trait Clipboard {
    // `KeyboardHandler.getClipboard`: empty when there is no text.
get :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // `KeyboardHandler.setClipboard`: empty text is not copied.
set :: proc(self: ^Self, text: string) {
}
}

// The system clipboard (`ClipboardManager`). On Wayland, arboard uses the
// data-control protocol and falls back to X11 (XWayland) on compositors
// without it. When no system clipboard can be reached, text copied in the
// game can still be pasted in the game.
SystemClipboard :: struct {
    system: Maybe(arboard::Clipboard),
    // The text Horizon last copied (`horizon-ctl status`).
    copied: Maybe(string),
}

    // rust: impl SystemClipboard {
    // The text last copied by the game.
copied :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.copied.as_deref()
}
system :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.system.is_none() {
    // rust: self.system = arboard::Clipboard::new().ok();
}
    // rust: self.system.as_mut()
}
}

    // rust: impl Clipboard for SystemClipboard {
get :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let Some(system) = self.system() else {
    // rust: return self.copied.clone().unwrap_or_default();
}
    // rust: match system.get_text() {
    // rust: Ok(text) => text,
    // rust: Err(arboard::Error::ContentNotAvailable) => String::new(),
    // rust: Err(_) => {
                // A lost connection (a restarted compositor): reconnect next time.
    // rust: self.system = None;
    // rust: String::new()
}
}
}
set :: proc(self: ^Self, text: string) {
}
    // rust: if text.is_empty() {
    // rust: return;
}
    // rust: self.copied = Some(text.to_owned());
    // rust: if let Some(system) = self.system()
    // rust: && system.set_text(text.to_owned()).is_err()
    // rust: {
    // rust: self.system = None;
}
}
}

// A clipboard in memory.
MemoryClipboard :: struct {

    // rust: impl Clipboard for MemoryClipboard {
get :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.0.clone()
}
set :: proc(self: ^Self, text: string) {
}
    // rust: if !text.is_empty() {
    // rust: self.0 = text.to_owned();
}
}
}

// A text field with a cursor and a selection (`EditBox`).
    // rust: pub trait Editable {
    // Select All: the cursor at the end, the selection from the start.
select_all :: proc(self: ^Self) {
}
    // `getHighlighted`.
selected_text :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // `insertText`, with the field's own filter and length limit. True when
    // the value changed.
insert :: proc(self: ^Self, text: string) -> b {
    // Ported from Horizon
    return {}
}
}

// `EditBox.keyPressed`'s shortcuts. True when the value changed.
    // rust: pub fn apply(
    // rust: field: &mut dyn Editable,
    // rust: shortcut: EditShortcut,
    // rust: clipboard: &mut dyn Clipboard,
    // rust: ) -> bool {
    // rust: match shortcut {
    // rust: EditShortcut::SelectAll => {
    // rust: field.select_all();
    // rust: false
}
    // rust: EditShortcut::Copy => {
    // rust: clipboard.set(&field.selected_text());
    // rust: false
}
    // rust: EditShortcut::Paste => field.insert(&clipboard.get()),
    // rust: EditShortcut::Cut => {
    // rust: clipboard.set(&field.selected_text());
    // rust: field.insert("")
}
}
}

// Which append-only field a Select All covers: a name and an index (a
// sign line, a book page).
    // rust: pub type FieldId = (&'static str, usize);

// The selection of Horizon's append-only fields, whose cursor stays at the
// end: Select All selects the whole value, which the next copy, cut, paste,
// typed text or backspace replaces. It is forgotten as soon as the field or
// its value changes.
AppendSelection :: struct {

    // rust: impl AppendSelection {
    // Whether `value` of field `id` is wholly selected.
covers :: proc(self: ^Self, id: FieldId, value: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.as_ref().is_some_and(|(i, v)| *i == id && v == value)
}
    // Select the whole `value` of field `id`, as Select All does.
select :: proc(self: ^Self, id: FieldId, value: string) {
}
    // rust: self.0 = Some((id, value.to_owned()));
}
    // Before typing or a backspace: an all-selected value is cleared (true).
take :: proc(self: ^Self, id: FieldId, value: ^string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let covered = self.covers(id, value);
    // rust: self.0 = None;
    // rust: if covered {
    // rust: value.clear();
}
    // rust: covered
}
    // A shortcut in an append-only field. `insert` adds pasted text to a
    // value the field's own way and says whether it accepted it (a field
    // that rejects it keeps its value, as `TextFieldHelper.insertText`).
    // True when the value changed.
    // rust: pub fn apply(
    // rust: &mut self,
    // rust: id: FieldId,
    // rust: value: &mut String,
    // rust: shortcut: EditShortcut,
    // rust: clipboard: &mut dyn Clipboard,
    // rust: insert: impl FnOnce(&mut String, &str) -> bool,
    // rust: ) -> bool {
    // rust: let covered = self.covers(id, value);
    // rust: match shortcut {
    // rust: EditShortcut::SelectAll => {
    // rust: self.select(id, value);
    // rust: false
}
    // rust: EditShortcut::Copy => {
    // rust: if covered {
    // rust: clipboard.set(value);
}
    // rust: false
}
    // rust: EditShortcut::Cut => {
    // rust: self.0 = None;
    // rust: if !covered {
    // rust: return false;
}
    // rust: clipboard.set(value);
    // rust: let changed = !value.is_empty();
    // rust: value.clear();
    // rust: changed
}
    // rust: EditShortcut::Paste => {
    // rust: self.0 = None;
    // rust: let text = clipboard.get();
    // rust: let mut next = if covered {
    // rust: String::new()
    // rust: } else {
    // rust: value.clone()
}
    // rust: if !insert(&mut next, &text) || next == *value {
    // rust: return false;
}
    // rust: *value = next;
    // rust: true
}
}
}
}

// `EditBox.insertText` for a field without a cursor: the filtered text,
// cut to the room left by `max_chars`.
append_limited :: proc(value: ^string, text: string, max_chars: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let room = max_chars.saturating_sub(value.chars().count());
    // rust: if room == 0 {
    // rust: return false;
}
    // rust: value.extend(filter_text(text, false).chars().take(room));
    // rust: true
}

    // rust: mod tests {
//     use super::*;

altgr_types_text_where_it_is_ctrl_alt :: proc() {
}
        // Plain keys and Shift type.
    // rust: assert!(types_text(false, false, true));
    // rust: assert!(types_text(false, false, false));
        // Ctrl (Cmd) shortcuts do not.
    // rust: assert!(!types_text(true, false, true));
    // rust: assert!(!types_text(true, false, false));
        // AltGr on Windows is Ctrl+Alt: ABNT2 `/`, German `@` type.
    // rust: assert!(types_text(true, true, true));
        // Where AltGr is its own modifier, Ctrl+Alt is a shortcut.
    // rust: assert!(!types_text(true, true, false));
        // Alt alone (macOS Option, Linux AltGr) types.
    // rust: assert!(types_text(false, true, false));
}

shortcuts_need_the_edit_modifier_alone :: proc() {
}
    // rust: let c = Some('c');
    // rust: assert_eq!(
    // rust: edit_shortcut(c, true, false, false),
    // rust: Some(EditShortcut::Copy)
    // rust: );
    // rust: assert_eq!(
    // rust: edit_shortcut(Some('v'), true, false, false),
    // rust: Some(EditShortcut::Paste)
    // rust: );
    // rust: assert_eq!(
    // rust: edit_shortcut(Some('x'), true, false, false),
    // rust: Some(EditShortcut::Cut)
    // rust: );
    // rust: assert_eq!(
    // rust: edit_shortcut(Some('a'), true, false, false),
    // rust: Some(EditShortcut::SelectAll)
    // rust: );
    // rust: assert_eq!(edit_shortcut(c, false, false, false), None);
    // rust: assert_eq!(edit_shortcut(c, true, true, false), None);
    // rust: assert_eq!(edit_shortcut(c, true, false, true), None);
    // rust: assert_eq!(edit_shortcut(Some('b'), true, false, false), None);
}

the_layout_letter_decides_and_non_latin_layouts_use_the_position :: proc() {
}
    // rust: let q = PhysicalKey::Code(KeyCode::KeyQ);
        // AZERTY: the key at Q's position types an A.
    // rust: assert_eq!(shortcut_letter(&Key::Character("a".into()), q), Some('a'));
        // Russian: the key at C's position types с.
    // rust: let c = PhysicalKey::Code(KeyCode::KeyC);
    // rust: assert_eq!(shortcut_letter(&Key::Character("с".into()), c), Some('c'));
    // rust: assert_eq!(shortcut_letter(&Key::Character("C".into()), q), Some('c'));
}

filter_text_keeps_line_breaks_only_for_multiline_fields :: proc() {
}
    // rust: let s = "a\u{7}b§c\nd\re\u{80}";
    // rust: assert_eq!(filter_text(s, false), "abcde\u{80}");
    // rust: assert_eq!(filter_text(s, true), "abc\nde\u{80}");
    // rust: assert_eq!(strip_formatting("§aRed§r §zx§"), "Red §zx§");
    // rust: assert_eq!(helper_clipboard_contents("§lone\r\ntwo"), "one\ntwo");
        // TextFieldHelper.getClipboardContents runs before insertText's filter.
    // rust: assert_eq!(
    // rust: filter_text(&helper_clipboard_contents("§aHello"), false),
    // rust: "Hello"
    // rust: );
}

Field :: struct {
    value: string,
    cursor: uint,
    highlight: uint,
}
    // rust: impl Editable for Field {
select_all :: proc(self: ^Self) {
}
    // rust: self.cursor = self.value.len();
    // rust: self.highlight = 0;
}
selected_text :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (a, b) = (
    // rust: self.cursor.min(self.highlight),
    // rust: self.cursor.max(self.highlight),
    // rust: );
    // rust: self.value[a..b].to_owned()
}
insert :: proc(self: ^Self, text: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (a, b) = (
    // rust: self.cursor.min(self.highlight),
    // rust: self.cursor.max(self.highlight),
    // rust: );
    // rust: self.value.replace_range(a..b, text);
    // rust: self.cursor = a + text.len();
    // rust: self.highlight = self.cursor;
    // rust: true
}
}

edit_box_shortcuts :: proc() {
}
    // rust: let mut clip = MemoryClipboard("old".into());
    // rust: let mut f = Field {
    // rust: value: "hello".into(),
    // rust: cursor: 5,
    // rust: highlight: 5,
}
        // Nothing selected: copying leaves the clipboard alone (setClipboard skips "").
    // rust: apply(&mut f, EditShortcut::Copy, &mut clip);
    // rust: assert_eq!(clip.0, "old");
    // rust: apply(&mut f, EditShortcut::SelectAll, &mut clip);
    // rust: apply(&mut f, EditShortcut::Copy, &mut clip);
    // rust: assert_eq!(clip.0, "hello");
    // rust: assert!(apply(&mut f, EditShortcut::Cut, &mut clip));
    // rust: assert_eq!(f.value, "");
    // rust: assert!(apply(&mut f, EditShortcut::Paste, &mut clip));
    // rust: assert!(apply(&mut f, EditShortcut::Paste, &mut clip));
    // rust: assert_eq!(f.value, "hellohello");
}

append_only_fields_select_everything_or_nothing :: proc() {
}
    // rust: let id = ("search", 0);
    // rust: let mut clip = MemoryClipboard("stone".into());
    // rust: let mut sel = AppendSelection::default();
    // rust: let mut value = String::from("dirt");
    // rust: let insert = |v: &mut String, t: &str| append_limited(v, t, 6);
        // Without Select All, copy and cut do nothing and paste appends.
    // rust: sel.apply(id, &mut value, EditShortcut::Copy, &mut clip, insert);
    // rust: assert_eq!(clip.0, "stone");
    // rust: assert!(!sel.apply(id, &mut value, EditShortcut::Cut, &mut clip, insert));
    // rust: assert!(sel.apply(id, &mut value, EditShortcut::Paste, &mut clip, insert));
    // rust: assert_eq!(value, "dirtst");
        // Select All then paste replaces the value.
    // rust: sel.apply(id, &mut value, EditShortcut::SelectAll, &mut clip, insert);
    // rust: assert!(sel.apply(id, &mut value, EditShortcut::Paste, &mut clip, insert));
    // rust: assert_eq!(value, "stone");
        // Select All then cut empties it and copies it.
    // rust: sel.apply(id, &mut value, EditShortcut::SelectAll, &mut clip, insert);
    // rust: clip.0 = "x".into();
    // rust: assert!(sel.apply(id, &mut value, EditShortcut::Cut, &mut clip, insert));
    // rust: assert_eq!((value.as_str(), clip.0.as_str()), ("", "stone"));
        // A selection is forgotten once the value changes or another field is used.
    // rust: value = "ab".into();
    // rust: sel.apply(id, &mut value, EditShortcut::SelectAll, &mut clip, insert);
    // rust: assert!(!sel.covers(("other", 0), &value));
    // rust: value.push('c');
    // rust: assert!(!sel.take(id, &mut value));
    // rust: assert_eq!(value, "abc");
    // rust: sel.apply(id, &mut value, EditShortcut::SelectAll, &mut clip, insert);
    // rust: assert!(sel.take(id, &mut value));
    // rust: assert_eq!(value, "");
}

a_rejected_paste_keeps_the_selected_value :: proc() {
}
        // TextFieldHelper.insertText: a line too wide is not set at all.
    // rust: let id = ("sign", 1);
    // rust: let mut clip = MemoryClipboard("far too long".into());
    // rust: let mut sel = AppendSelection::default();
    // rust: let mut value = String::from("ok");
    // rust: sel.apply(
    // rust: id,
    // rust: &mut value,
    // rust: EditShortcut::SelectAll,
    // rust: &mut clip,
    // rust: |_, _| true,
    // rust: );
    // rust: let fits = |v: &mut String, t: &str| {
    // rust: let next = format!("{v}{t}");
    // rust: next.len() <= 5 && {
    // rust: *v = next;
    // rust: true
}
}
    // rust: assert!(!sel.apply(id, &mut value, EditShortcut::Paste, &mut clip, fits));
    // rust: assert_eq!(value, "ok");
}
}
