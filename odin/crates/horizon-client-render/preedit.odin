//! Transpiled from Horizon Rust crate
package horizon_client_render_preedit

import "core:fmt"
import "core:mem"
import "core:math"

// Input method composition text (`PreeditEvent`, `IMEPreeditOverlay`,
// `TextInputManager`): the text an input method is still composing, shown
// under the focused text field's caret, and the area the system's candidate
// window is placed at.
//
// Vanilla hands each `PreeditEvent` to the focused widget, which keeps an
// overlay and reports its caret every frame. Horizon draws its fields from
// many places, so the event is kept here and every focused field calls
// [`report_caret`] where it draws its caret; the game draws the overlay last
// with [`draw_overlay`] and applies [`take_text_input_area`] to the window.
// use crate::{
    // rust: hud::{HudAtlas, HudBatch},
    // rust: text::{Style, Text},
    // rust: ui::nine_slice,
}
// use std::{sync::Mutex, time::Instant};

// `PreeditEvent`: the composition, its caret and the blocks of text the
// input method set apart (the one being converted is `focused_block`).
PreeditEvent :: struct {
    full_text: string,
    // Byte offset of the caret in `full_text` (vanilla's UTF-16 offset).
    caret_position: uint,
    blocks: [dynamic]string,
    focused_block: uint,
}

    // rust: impl PreeditEvent {
    // `PreeditEvent.fromSdlTextEditing`: `selection_start` and
    // `selection_length` are in code points; a negative start puts the caret
    // at the end. Empty text is no composition.
    // rust: pub fn from_sdl_text_editing(
    // rust: text: Option<&str>,
    // rust: selection_start: i32,
    // rust: selection_length: i32,
    // rust: ) -> Option<Self> {
    // rust: let text = text.filter(|t| !t.is_empty())?;
    // rust: let total = text.chars().count();
    // rust: let caret_codepoint = if selection_start < 0 {
    // rust: total
    // rust: } else {
    // rust: (selection_start as usize).min(total)
}
    // rust: let caret_char = offset_by_codepoints(text, caret_codepoint);
    // rust: let single = |caret| Self {
    // rust: full_text: text.to_owned(),
    // rust: caret_position: caret,
    // rust: blocks: vec![text.to_owned()],
    // rust: focused_block: 0,
}
    // rust: if selection_length <= 0 {
    // rust: return Some(single(caret_char));
}
    // rust: let end_codepoint = (caret_codepoint + selection_length as usize).min(total);
    // rust: let end_char = offset_by_codepoints(text, end_codepoint);
    // rust: if end_char <= caret_char {
    // rust: return Some(single(caret_char));
}
    // rust: let mut blocks = Vec::new();
    // rust: let mut focused_block = 0;
    // rust: if caret_char > 0 {
    // rust: blocks.push(text[..caret_char].to_owned());
    // rust: focused_block = 1;
}
    // rust: blocks.push(text[caret_char..end_char].to_owned());
    // rust: if end_char < text.len() {
    // rust: blocks.push(text[end_char..].to_owned());
}
    // rust: Some(Self {
    // rust: full_text: text.to_owned(),
    // rust: caret_position: caret_char,
    // rust: blocks,
    // rust: focused_block,
    // rust: })
}

    // winit's `Ime::Preedit`: `cursor` is the byte range of the part being
    // converted, `None` when the input method hides its cursor. SDL's
    // `TEXTEDITING` says the same in code points.
from_winit :: proc(text: string, cursor: Option<(uint) {
}
    // rust: let (start, length) = match cursor {
    // rust: Some((from, to)) => {
    // rust: let from = from.min(text.len());
    // rust: let to = to.clamp(from, text.len());
    // rust: let start = text.get(..from).map_or(-1, |s| s.chars().count() as i32);
    // rust: let length = text.get(from..to).map_or(0, |s| s.chars().count() as i32);
    // rust: (start, length)
}
    // rust: None => (-1, 0),
}
    // rust: Self::from_sdl_text_editing(Some(text), start, length)
}

    // `PreeditEvent.toFormattedText`.
to_formatted_text :: proc(self: ^Self, focused_style: ^Style) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if self.blocks.len() == 1 {
    // rust: return Text::literal(self.blocks[0].clone()).with_style(focused_style);
}
    // rust: let mut result = Text::empty();
    // rust: for (i, block) in self.blocks.iter().enumerate() {
    // rust: let mut part = Text::literal(block.clone());
    // rust: if i == self.focused_block {
    // rust: part = part.with_style(focused_style);
}
    // rust: result.push(part);
}
    // rust: result
}
}

// `String.offsetByCodePoints(0, n)`: the byte offset after `n` characters.
offset_by_codepoints :: proc(text: string, n: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: text.char_indices().nth(n).map_or(text.len(), |(i, _)| i)
}

// The caret a field reported this frame, in GUI pixels.
Caret :: struct {
    x: f32,
    y: f32,
    input_height: f32,
}

State :: struct {
    // `KeyboardHandler.lastPreeditEvent`, with when the overlay was created.
    preedit: Option<(PreeditEvent,
    caret: Maybe(Caret),
    area: Option<[f32,
}

    // rust: static STATE: Mutex<State> = Mutex::new(State {
    // rust: preedit: None,
    // rust: caret: None,
    // rust: area: None,
    // rust: });

state :: proc() -> s {
    // Ported from Horizon
    return {}
}
    // rust: STATE.lock().unwrap_or_else(|e| e.into_inner())
}

// `KeyboardHandler.textEditing`: the input method's composition changed
// (`None`: it ended). A new `IMEPreeditOverlay` restarts the caret blink.
set_preedit :: proc(event: Maybe(PreeditEvent)) {
}
    // rust: let mut s = state();
    // rust: s.preedit = event.map(|e| (e, Instant::now()));
}

// Whether text is being composed.
composing :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: state().preedit.is_some()
}

// What the focused field's `extractRenderState` ends with: its caret is at
// (`x`, `y`) in GUI pixels and `input_height` tall (a line plus one).
// Without a composition that is the area for the candidate window; with one
// it is where the overlay goes ([`draw_overlay`]).
report_caret :: proc(x: f32, y: f32, input_height: f32) {
}
    // rust: state().caret = Some(Caret { x, y, input_height });
}

// `IMEPreeditOverlay.extractRenderState` for the caret reported this frame,
// drawn on top of everything in `batch`. Without a composition the caret is
// the text input area (`TextInputManager.setTextInputArea`).
draw_overlay :: proc(batch: ^HudBatch, atlas: ^HudAtlas) {
}
    // rust: let mut s = state();
    // rust: let Some(caret) = s.caret.take() else {
    // rust: return;
}
    // rust: let Some((event, init)) = s.preedit.as_ref() else {
    // rust: s.area = Some([
    // rust: caret.x,
    // rust: caret.y,
    // rust: caret.x + 1.0,
    // rust: caret.y + caret.input_height,
    // rust: ]);
    // rust: return;
}
    // rust: let font = &atlas.font;
    // rust: let focused = Style {
    // rust: underlined: Some(true),
    // rust: ..Style::default()
}
    // rust: let black = 0xFF00_0000;
    // rust: let text = event.to_formatted_text(&focused).with_color(black);
    // rust: let width = font.width_text(&text);
    // rust: let caret_pos = font.width(&event.full_text[..event.caret_position]);
    // rust: let blink_visible = (init.elapsed().as_millis() / 300).is_multiple_of(2);
    // rust: let line = 9.0;
    // rust: let (gui_w, gui_h) = (batch.width, batch.height);
    // rust: let mut left = caret.x;
    // rust: let mut right = left + width;
    // rust: if right > gui_w {
    // rust: left = gui_w - width;
    // rust: right = left + width;
}
    // rust: let input_bottom = caret.y + caret.input_height;
    // rust: let mut bottom = input_bottom + 4.0 + line;
    // rust: if bottom > gui_h {
    // rust: bottom = caret.y - 4.0 - line;
}
    // rust: let top = bottom - line;
    // rust: s.area = Some([left, top, right, bottom]);
    // rust: drop(s);
    // rust: nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/widget/preedit",
    // rust: left - 5.0,
    // rust: top - 5.0,
    // rust: right - left + 10.0,
    // rust: bottom - top + 10.0,
    // rust: u32::MAX,
    // rust: );
    // rust: batch.text_styled(atlas, &text, left, top, black, false);
    // rust: if blink_visible {
    // rust: batch.fill(atlas, left + caret_pos, top - 1.0, 1.0, 11.0, black);
}
}

// The text input area (`x0, y0, x1, y1` in GUI pixels) set since the last
// call, for `Window.set_ime_cursor_area`.
take_text_input_area :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: state().area.take()
}

    // rust: mod tests {
//     use super::*;

empty_text_is_no_composition :: proc() {
}
    // rust: assert_eq!(PreeditEvent::from_sdl_text_editing(None, 0, 0), None);
    // rust: assert_eq!(PreeditEvent::from_sdl_text_editing(Some(""), 0, 0), None);
}

a_negative_start_puts_the_caret_at_the_end :: proc() {
}
    // rust: let e = PreeditEvent::from_sdl_text_editing(Some("abc"), -1, 0).unwrap();
    // rust: assert_eq!(
    // rust: (e.caret_position, e.blocks, e.focused_block),
    // rust: (3, vec!["abc".into()], 0)
    // rust: );
}

the_caret_counts_code_points :: proc() {
}
        // Two code points before the caret, the second outside the BMP.
    // rust: let e = PreeditEvent::from_sdl_text_editing(Some("a\u{1F600}b"), 2, 0).unwrap();
    // rust: assert_eq!(e.caret_position, "a\u{1F600}".len());
    // rust: let past = PreeditEvent::from_sdl_text_editing(Some("ab"), 9, 0).unwrap();
    // rust: assert_eq!(past.caret_position, 2);
}

a_selection_splits_the_text_into_blocks :: proc() {
}
    // rust: let e = PreeditEvent::from_sdl_text_editing(Some("abcdef"), 2, 2).unwrap();
    // rust: assert_eq!(e.blocks, ["ab", "cd", "ef"]);
    // rust: assert_eq!((e.focused_block, e.caret_position), (1, 2));
    // rust: let first = PreeditEvent::from_sdl_text_editing(Some("abcdef"), 0, 3).unwrap();
    // rust: assert_eq!(first.blocks, ["abc", "def"]);
    // rust: assert_eq!(first.focused_block, 0);
    // rust: let last = PreeditEvent::from_sdl_text_editing(Some("abcdef"), 3, 99).unwrap();
    // rust: assert_eq!(last.blocks, ["abc", "def"]);
    // rust: assert_eq!(last.focused_block, 1);
}

winit_byte_ranges_become_code_points :: proc() {
}
    // rust: let text = "\u{3042}\u{3044}\u{3046}";
        // Converting the middle character (bytes 3..6).
    // rust: let e = PreeditEvent::from_winit(text, Some((3, 6))).unwrap();
    // rust: assert_eq!(e.blocks, ["\u{3042}", "\u{3044}", "\u{3046}"]);
    // rust: assert_eq!(e.focused_block, 1);
        // A hidden cursor sits at the end.
    // rust: let hidden = PreeditEvent::from_winit(text, None).unwrap();
    // rust: assert_eq!(hidden.caret_position, text.len());
    // rust: assert_eq!(hidden.blocks.len(), 1);
}

only_the_focused_block_is_underlined :: proc() {
}
    // rust: let focused = Style {
    // rust: underlined: Some(true),
    // rust: ..Style::default()
}
    // rust: let e = PreeditEvent::from_sdl_text_editing(Some("abcdef"), 2, 2).unwrap();
    // rust: let styled: Vec<(char, bool)> = e
    // rust: .to_formatted_text(&focused)
    // rust: .chars()
    // rust: .map(|(c, s)| (c, s.underlined == Some(true)))
    // rust: .collect();
    // rust: let underlined: String = styled.iter().filter(|x| x.1).map(|x| x.0).collect();
    // rust: assert_eq!(underlined, "cd");
    // rust: assert_eq!(styled.len(), 6);
    // rust: let one = PreeditEvent::from_sdl_text_editing(Some("ab"), 0, 0).unwrap();
    // rust: assert!(
    // rust: one.to_formatted_text(&focused)
    // rust: .chars()
    // rust: .all(|(_, s)| s.underlined == Some(true))
    // rust: );
}
}
