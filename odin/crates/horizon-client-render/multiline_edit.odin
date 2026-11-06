//! Transpiled from Horizon Rust crate
package horizon_client_render_multiline_edit

import "core:fmt"
import "core:mem"
import "core:math"

// `MultiLineEditBox` over `MultilineTextField` (and `AbstractTextAreaWidget`'s
// frame and scroll bar): a text area that wraps its text to the box, with a
// caret and selection that move by line, a character limit, a line limit and
// a scroll bar. Indices count characters, as `EditBox`'s do.
// use crate::{
    // rust: clipboard::{Clipboard, EditShortcut, filter_text},
    // rust: font::Font,
    // rust: hud::{HudAtlas, HudBatch, rgba},
    // rust: text::Style,
    // rust: ui::{self, Scroll, java_whitespace},
}
// use std::time::Instant;
// use winit::keyboard::KeyCode;

// `AbstractTextAreaWidget.INNER_PADDING`.
PADDING :: 4.0
// `Font.lineHeight`.
LINE :: 9.0
// `AbstractScrollArea.defaultSettings((int) (9.0 / 2.0))`'s scroll rate.
SCROLL_RATE :: 4.0

// `StringSplitter.splitLines(value, width, Style.EMPTY, false, ..)`: each
// line's `[begin, end)`. A line ends at a `\n`, or once a character overflows
// the width (never the first visible one) at the last space so far, or before
// that character; the `\n` or space at the end is skipped.
split_ranges :: proc(font: ^Font, chars: ^[char], width: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let max_width = width.max(1.0);
    // rust: let style = Style::default();
    // rust: let mut out = Vec::new();
    // rust: let mut start = 0;
    // rust: while start < chars.len() {
    // rust: let (mut line_width, mut had_visible, mut last_space) = (0.0f32, false, None);
    // rust: let mut line_break = None;
    // rust: for (i, &c) in chars.iter().enumerate().skip(start) {
    // rust: if c == '\n' {
    // rust: line_break = Some(i);
    // rust: break;
}
    // rust: if c == ' ' {
    // rust: last_space = Some(i);
}
    // rust: let advance = font.advance(c, &style);
    // rust: line_width += advance;
    // rust: if !had_visible || line_width <= max_width {
    // rust: had_visible |= advance != 0.0;
    // rust: } else {
    // rust: line_break = Some(last_space.unwrap_or(i));
    // rust: break;
}
}
    // rust: let Some(at) = line_break else {
    // rust: out.push((start, chars.len()));
    // rust: break;
}
    // rust: out.push((start, at));
    // rust: start = if matches!(chars[at], '\n' | ' ') {
    // rust: at + 1
    // rust: } else {
    // rust: at
}
}
    // rust: out
}

// `MultiLineEditBox` with its `MultilineTextField`.
MultiLineEdit :: struct {
    chars: [dynamic]char,
    cursor: uint,
    select_cursor: uint,
    selecting: bool,
    // `characterLimit` (`MultilineTextField.NO_LIMIT` is `None`).
    character_limit: Maybe(uint),
    line_limit: Maybe(uint),
    // `displayLines`.
    lines: Vec<(uint,
    x: f32,
    y: f32,
    width: f32,
    height: f32,
    focused: bool,
    focused_at: Instant,
    scroll: Scroll,
}

    // rust: impl MultiLineEdit {
new :: proc(font: ^Font, x: f32, y: f32, width: f32, height: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut edit = Self {
    // rust: chars: Vec::new(),
    // rust: cursor: 0,
    // rust: select_cursor: 0,
    // rust: selecting: false,
    // rust: character_limit: None,
    // rust: line_limit: None,
    // rust: lines: Vec::new(),
    // rust: x,
    // rust: y,
    // rust: width,
    // rust: height,
    // rust: focused: false,
    // rust: focused_at: Instant::now(),
    // rust: scroll: Scroll::default(),
}
    // rust: edit.reflow(font);
    // rust: edit
}

    // `AbstractTextAreaWidget.totalInnerPadding`.
text_width :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.width - 2.0 * PADDING
}
set_character_limit :: proc(self: ^Self, limit: uint) {
}
    // rust: self.character_limit = Some(limit);
}
set_line_limit :: proc(self: ^Self, limit: uint) {
}
    // rust: self.line_limit = Some(limit);
}
value :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.chars.iter().collect()
}
cursor :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.cursor
}
line_count :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.lines.len()
}
lines :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.lines
}
has_selection :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.select_cursor != self.cursor
}
    // `getSelected`.
selected :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: self.select_cursor.min(self.cursor),
    // rust: self.select_cursor.max(self.cursor),
    // rust: )
}
selected_text :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (begin, end) = self.selected();
    // rust: self.chars[begin..end].iter().collect()
}

    // `setValue(value, false)`: kept as it was when the text has more lines
    // than the limit allows.
set_value :: proc(self: ^Self, font: ^Font, value: string) {
}
    // rust: let mut chars: Vec<char> = value.chars().collect();
    // rust: if let Some(limit) = self.character_limit {
    // rust: chars.truncate(limit);
}
    // rust: if !self.overflows_line_limit(font, &chars) {
    // rust: self.chars = chars;
    // rust: self.cursor = self.chars.len();
    // rust: self.select_cursor = self.cursor;
    // rust: self.on_value_change(font);
}
}

    // `overflowsLineLimit`.
overflows_line_limit :: proc(self: ^Self, font: ^Font, value: ^[char]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(limit) = self.line_limit else {
    // rust: return false;
}
    // rust: let lines = split_ranges(font, value, self.text_width()).len();
        // `StringUtil.endsWithNewLine`.
    // rust: lines + usize::from(value.last().is_some_and(|c| matches!(c, '\n' | '\r'))) > limit
}

    // `insertText`.
insert_text :: proc(self: ^Self, font: ^Font, input: string) {
}
    // rust: if input.is_empty() && !self.has_selection() {
    // rust: return;
}
    // rust: let mut text: Vec<char> = filter_text(input, true).chars().collect();
    // rust: if let Some(limit) = self.character_limit {
    // rust: text.truncate(limit.saturating_sub(self.chars.len()));
}
    // rust: let (begin, end) = self.selected();
    // rust: let mut value = self.chars[..begin].to_vec();
    // rust: value.extend_from_slice(&text);
    // rust: value.extend_from_slice(&self.chars[end..]);
    // rust: if !self.overflows_line_limit(font, &value) {
    // rust: self.chars = value;
    // rust: self.cursor = begin + text.len();
    // rust: self.select_cursor = self.cursor;
    // rust: self.on_value_change(font);
}
}

    // `deleteText`.
delete_text :: proc(self: ^Self, font: ^Font, dir: int) {
}
    // rust: if !self.has_selection() {
    // rust: self.select_cursor = self.cursor.saturating_add_signed(dir).min(self.chars.len());
}
    // rust: self.insert_text(font, "");
}

    // `onValueChange`: the lines again, and the cursor in view.
on_value_change :: proc(self: ^Self, font: ^Font) {
}
    // rust: self.reflow(font);
    // rust: self.scroll_to_cursor();
}

    // `reflowDisplayLines`.
reflow :: proc(self: ^Self, font: ^Font) {
}
    // rust: self.lines = if self.chars.is_empty() {
    // rust: vec![(0, 0)]
    // rust: } else {
    // rust: let mut lines = split_ranges(font, &self.chars, self.text_width());
    // rust: if self.chars.last() == Some(&'\n') {
    // rust: lines.push((self.chars.len(), self.chars.len()));
}
    // rust: lines
}
}

    // `getLineAtCursor`: -1 when no line holds the cursor.
line_at_cursor :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.lines
    // rust: .iter()
    // rust: .position(|&(begin, end)| self.cursor >= begin && self.cursor <= end)
    // rust: .map_or(-1, |i| i as isize)
}
    // `getLineView`: the index clamped to the lines.
line_view :: proc(self: ^Self, index: int) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: self.lines[index.clamp(0, self.lines.len() as isize - 1) as usize]
}
    // `getCursorLineView(offset)`.
cursor_line_view :: proc(self: ^Self, offset: int) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match self.line_at_cursor() {
    // rust: -1 => *self.lines.last().expect("a text field has a line"),
    // rust: line => self.line_view(line + offset),
}
}

    // `AbstractScrollArea.contentHeight` of the text area.
content_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: LINE * self.lines.len() as f32 + 2.0 * PADDING
}
    // `setScrollAmount`.
set_scroll :: proc(self: ^Self, amount: f32) {
}
    // rust: self.scroll.amount = amount;
    // rust: self.scroll.clamp(0.0, self.height, self.content_height());
}

    // `MultiLineEditBox.scrollToCursor`, the text field's cursor listener.
scroll_to_cursor :: proc(self: ^Self) {
}
    // rust: let mut amount = self.scroll.amount;
    // rust: let first = self.line_view((amount / LINE) as isize);
    // rust: let line = self.line_at_cursor() as f32;
    // rust: if self.cursor <= first.0 {
    // rust: amount = line * LINE;
    // rust: } else {
    // rust: let last = self.line_view(((amount + self.height) / LINE) as isize - 1);
    // rust: if self.cursor > last.1 {
    // rust: amount = line * LINE - self.height + LINE + 2.0 * PADDING;
}
}
    // rust: self.set_scroll(amount);
}

    // `seekCursor` to `cursor`, then the cursor listener.
seek_cursor :: proc(self: ^Self, cursor: uint) {
}
    // rust: self.cursor = cursor.min(self.chars.len());
    // rust: self.scroll_to_cursor();
    // rust: if !self.selecting {
    // rust: self.select_cursor = self.cursor;
}
}

    // `seekCursorLine`.
seek_cursor_line :: proc(self: ^Self, font: ^Font, offset: int) {
}
    // rust: if offset == 0 {
    // rust: return;
}
    // rust: let (begin, _) = self.cursor_line_view(0);
    // rust: let before: String = self.chars[begin..self.cursor].iter().collect();
    // rust: let old_left = font.width(&before) + 2.0;
    // rust: let (begin, end) = self.cursor_line_view(offset);
    // rust: let line: String = self.chars[begin..end].iter().collect();
    // rust: self.seek_cursor(begin + font.fit(&line, old_left));
}

    // `seekCursorToPoint`: `x` and `y` from the top left of the text.
seek_cursor_to_point :: proc(self: ^Self, font: ^Font, x: f32, y: f32) {
}
    // rust: let left = x.floor();
    // rust: let top = (y / LINE).floor() as isize;
    // rust: let (begin, end) = self.line_view(top);
    // rust: let line: String = self.chars[begin..end].iter().collect();
    // rust: self.seek_cursor(begin + font.fit(&line, left));
}

    // `getPreviousWord`: where the word starts and ends.
previous_word :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if self.chars.is_empty() {
    // rust: return (0, 0);
}
    // rust: let mut start = self.cursor.min(self.chars.len() - 1);
    // rust: while start > 0 && java_whitespace(self.chars[start - 1]) {
    // rust: start -= 1;
}
    // rust: while start > 0 && !java_whitespace(self.chars[start - 1]) {
    // rust: start -= 1;
}
    // rust: (start, self.word_end(start))
}
    // `getNextWord`.
next_word :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if self.chars.is_empty() {
    // rust: return (0, 0);
}
    // rust: let mut start = self.cursor.min(self.chars.len() - 1);
    // rust: while start < self.chars.len() && !java_whitespace(self.chars[start]) {
    // rust: start += 1;
}
    // rust: while start < self.chars.len() && java_whitespace(self.chars[start]) {
    // rust: start += 1;
}
    // rust: (start, self.word_end(start))
}
word_end :: proc(self: ^Self, from: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut end = from;
    // rust: while end < self.chars.len() && !java_whitespace(self.chars[end]) {
    // rust: end += 1;
}
    // rust: end
}
    // `selectWordAtCursor`.
select_word_at_cursor :: proc(self: ^Self) {
}
    // rust: let (begin, end) = self.previous_word();
    // rust: self.seek_cursor(begin);
    // rust: self.selecting = true;
    // rust: self.seek_cursor(end);
}

    // `MultilineTextField.keyPressed` for the keys that are not shortcuts.
    // True when the key was used.
key :: proc(self: ^Self, font: ^Font, key: KeyCode, ctrl: bool, shift: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.selecting = shift;
    // rust: match key {
    // rust: KeyCode::Backspace if ctrl => {
    // rust: let (begin, _) = self.previous_word();
    // rust: self.delete_text(font, begin as isize - self.cursor as isize);
}
    // rust: KeyCode::Backspace => self.delete_text(font, -1),
    // rust: KeyCode::Enter | KeyCode::NumpadEnter => self.insert_text(font, "\n"),
    // rust: KeyCode::Delete if ctrl => {
    // rust: let (begin, _) = self.next_word();
    // rust: self.delete_text(font, begin as isize - self.cursor as isize);
}
    // rust: KeyCode::Delete => self.delete_text(font, 1),
    // rust: KeyCode::Home if ctrl => self.seek_cursor(0),
    // rust: KeyCode::Home => self.seek_cursor(self.cursor_line_view(0).0),
    // rust: KeyCode::PageUp => self.seek_cursor(0),
    // rust: KeyCode::End if ctrl => self.seek_cursor(self.chars.len()),
    // rust: KeyCode::End => self.seek_cursor(self.cursor_line_view(0).1),
    // rust: KeyCode::PageDown => self.seek_cursor(self.chars.len()),
    // rust: KeyCode::ArrowRight if ctrl => self.seek_cursor(self.next_word().0),
    // rust: KeyCode::ArrowRight => self.seek_cursor(self.cursor + 1),
    // rust: KeyCode::ArrowLeft if ctrl => self.seek_cursor(self.previous_word().0),
    // rust: KeyCode::ArrowLeft => self.seek_cursor(self.cursor.saturating_sub(1)),
    // rust: KeyCode::ArrowDown => {
    // rust: if !ctrl {
    // rust: self.seek_cursor_line(font, 1);
}
}
    // rust: KeyCode::ArrowUp => {
    // rust: if !ctrl {
    // rust: self.seek_cursor_line(font, -1);
}
}
    // rust: _ => return false,
}
    // rust: true
}

    // Ctrl+A/C/V/X. True when the value changed.
    // rust: pub fn shortcut(
    // rust: &mut self,
    // rust: font: &Font,
    // rust: shortcut: EditShortcut,
    // rust: clipboard: &mut dyn Clipboard,
    // rust: ) -> bool {
    // rust: let before = self.chars.len();
    // rust: match shortcut {
    // rust: EditShortcut::SelectAll => {
    // rust: self.cursor = self.chars.len();
    // rust: self.select_cursor = 0;
}
    // rust: EditShortcut::Copy => clipboard.set(&self.selected_text()),
    // rust: EditShortcut::Paste => self.insert_text(font, &clipboard.get()),
    // rust: EditShortcut::Cut => {
    // rust: clipboard.set(&self.selected_text());
    // rust: self.insert_text(font, "");
}
}
    // rust: self.focused_at = Instant::now();
    // rust: self.chars.len() != before
}

    // `AbstractWidget.isMouseOver`: the box and its scroll bar.
hovered :: proc(self: ^Self) {
}
    // rust: x >= self.x && y >= self.y && x < self.x + self.width + 6.0 && y < self.y + self.height
}

    // `AbstractTextAreaWidget.mouseClicked`: a press on the scroll bar
    // holds it, else `onClick` places the cursor (`double`: selects the word).
click :: proc(self: ^Self, font: ^Font, cursor: (f32) {
}
    // rust: let bar = self.x + self.width;
    // rust: if self.scroll.press(
    // rust: cursor,
    // rust: bar,
    // rust: self.y,
    // rust: self.y + self.height,
    // rust: self.content_height(),
    // rust: ) {
    // rust: return;
}
    // rust: if double {
    // rust: self.select_word_at_cursor();
    // rust: } else {
    // rust: self.selecting = shift;
    // rust: self.seek_screen(font, cursor);
}
}
    // `onDrag`: the selection follows the pointer, or the held scroll bar does.
drag :: proc(self: ^Self, font: ^Font, cursor: (f32) {
}
    // rust: if self.scroll.held() {
    // rust: self.scroll.drag(
    // rust: cursor.1,
    // rust: self.y,
    // rust: self.y + self.height,
    // rust: self.content_height(),
    // rust: );
    // rust: return;
}
    // rust: self.selecting = true;
    // rust: self.seek_screen(font, cursor);
    // rust: self.selecting = shift;
}
    // `onRelease`.
release :: proc(self: ^Self) {
}
    // rust: self.scroll.release();
}
    // `mouseScrolled`.
wheel :: proc(self: ^Self, delta: f32) {
}
    // rust: let amount = self.scroll.amount - delta * SCROLL_RATE;
    // rust: self.set_scroll(amount);
}
    // `seekCursorScreen`.
seek_screen :: proc(self: ^Self, font: ^Font) {
}
    // rust: let mouse_x = x - self.x - PADDING;
    // rust: let mouse_y = y - self.y - PADDING + self.scroll.amount;
    // rust: self.seek_cursor_to_point(font, mouse_x, mouse_y);
}

    // `setFocused`: the caret starts to blink.
set_focused :: proc(self: ^Self, focused: bool) {
}
    // rust: if focused && !self.focused {
    // rust: self.focused_at = Instant::now();
}
    // rust: self.focused = focused;
}

    // `AbstractTextAreaWidget.withinContentAreaTopBottom`.
within :: proc(self: ^Self, top: f32, bottom: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: bottom - self.scroll.amount >= self.y && top - self.scroll.amount <= self.y + self.height
}

    // `extractWidgetRenderState`: the frame, the text under a scissor, the
    // scroll bar and the character count.
draw :: proc(self: ^Self, batch: ^HudBatch, atlas: ^HudAtlas) {
}
    // rust: crate::widgets::target_as(
    // rust: [self.x, self.y, self.width, self.height],
    // rust: crate::widgets::Kind::Field,
    // rust: );
    // rust: let sprite = if self.focused {
    // rust: "gui/sprites/widget/text_field_highlighted"
    // rust: } else {
    // rust: "gui/sprites/widget/text_field"
}
    // rust: ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: sprite,
    // rust: self.x,
    // rust: self.y,
    // rust: self.width,
    // rust: self.height,
    // rust: u32::MAX,
    // rust: );
    // rust: let start = batch.vertices.len();
    // rust: self.draw_contents(batch, atlas);
    // rust: batch.clip_since(
    // rust: start,
    // rust: self.x + 1.0,
    // rust: self.y + 1.0,
    // rust: self.x + self.width - 1.0,
    // rust: self.y + self.height - 1.0,
    // rust: );
        // Its text scrolls with its caret: not a list for the focus to step through.
    // rust: ui::scrollbar_sprites(
    // rust: batch,
    // rust: atlas,
    // rust: self.x + self.width,
    // rust: self.y,
    // rust: self.y + self.height,
    // rust: self.content_height(),
    // rust: self.scroll.amount,
    // rust: );
    // rust: if let Some(limit) = self.character_limit {
    // rust: let count = crate::lang::tr(
    // rust: "gui.multiLineEditBox.character_limit",
    // rust: &[&self.chars.len(), &limit],
    // rust: );
    // rust: let width = atlas.font.width(&count);
    // rust: batch.text(
    // rust: atlas,
    // rust: &count,
    // rust: self.x + self.width - width,
    // rust: self.y + self.height + 4.0,
    // rust: rgba(160, 160, 160, 255),
    // rust: true,
    // rust: );
}
}

    // `MultiLineEditBox.extractContents` (the placeholder is empty).
draw_contents :: proc(self: ^Self, batch: ^HudBatch, atlas: ^HudAtlas) {
}
    // rust: if self.chars.is_empty() && !self.focused {
    // rust: return;
}
    // rust: let font = &atlas.font;
    // rust: let text_color = rgba(224, 224, 224, 255);
    // rust: let cursor_color = rgba(208, 208, 208, 255);
    // rust: let slice =
    // rust: |begin: usize, end: usize| -> String { self.chars[begin..end].iter().collect() };
    // rust: let show_cursor =
    // rust: self.focused && (self.focused_at.elapsed().as_millis() / 300).is_multiple_of(2);
    // rust: let needs_valid_cursor_pos = self.focused;
    // rust: let insert_cursor = self.cursor < self.chars.len();
    // rust: let (inner_left, mut draw_top) = (self.x + PADDING, self.y + PADDING - self.scroll.amount);
    // rust: let (mut cursor_x, mut cursor_y) = (0.0f32, 0.0f32);
    // rust: let mut has_drawn_cursor = false;
        // The content is translated by the scroll amount; `within` compares
        // untranslated tops, so it is given the line's top before the shift.
    // rust: let shift = self.scroll.amount;
    // rust: for &(begin, end) in &self.lines {
    // rust: let within = self.within(draw_top + shift, draw_top + shift + LINE);
    // rust: if !has_drawn_cursor
    // rust: && (needs_valid_cursor_pos || show_cursor)
    // rust: && insert_cursor
    // rust: && self.cursor >= begin
    // rust: && self.cursor <= end
    // rust: {
    // rust: let before = slice(begin, self.cursor);
    // rust: let right = inner_left + font.width(&before);
    // rust: (cursor_x, cursor_y) = (right, draw_top);
    // rust: if within {
    // rust: let after = slice(self.cursor, end);
    // rust: batch.text(atlas, &before, inner_left, draw_top, text_color, true);
    // rust: batch.text(atlas, &after, right, draw_top, text_color, true);
    // rust: if show_cursor {
    // rust: batch.fill(atlas, cursor_x, cursor_y - 1.0, 1.0, 11.0, cursor_color);
}
}
    // rust: has_drawn_cursor = true;
    // rust: } else {
    // rust: let line = slice(begin, end);
    // rust: if within {
    // rust: batch.text(atlas, &line, inner_left, draw_top, text_color, true);
}
    // rust: if (needs_valid_cursor_pos || show_cursor) && !insert_cursor {
    // rust: cursor_x = inner_left + font.width(&line);
    // rust: cursor_y = draw_top;
}
}
    // rust: draw_top += LINE;
}
    // rust: if show_cursor && !insert_cursor && self.within(cursor_y + shift, cursor_y + shift + LINE) {
    // rust: batch.text(atlas, "_", cursor_x, cursor_y, cursor_color, true);
}
    // rust: if self.focused {
    // rust: crate::preedit::report_caret(cursor_x, cursor_y, 10.0);
}
    // rust: if self.has_selection() {
    // rust: let (sel_begin, sel_end) = self.selected();
    // rust: let draw_x = inner_left;
    // rust: let mut draw_top = self.y + PADDING - self.scroll.amount;
    // rust: for &(begin, end) in &self.lines {
    // rust: if sel_begin > end {
    // rust: draw_top += LINE;
    // rust: continue;
}
    // rust: if begin > sel_end {
    // rust: break;
}
    // rust: if self.within(draw_top + shift, draw_top + shift + LINE) {
    // rust: let draw_begin = font.width(&slice(begin, sel_begin.max(begin)));
    // rust: let draw_end = if sel_end > end {
    // rust: self.width - PADDING
    // rust: } else {
    // rust: font.width(&slice(begin, sel_end))
}
    // rust: batch.text_highlight(
    // rust: atlas,
    // rust: (draw_x + draw_begin, draw_top, draw_end - draw_begin, LINE),
    // rust: true,
    // rust: );
}
    // rust: draw_top += LINE;
}
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::hud::Rect;
//     use std::{collections::HashMap, path::Path};

font :: proc() -> F {
    // Ported from Horizon
    return {}
}
        // The missing-glyph metrics let these tests run without game assets.
    // rust: Font::load(
    // rust: Path::new("/nonexistent-horizon-multiline-test-resources"),
    // rust: &HashMap::new(),
    // rust: &[],
    // rust: (1, 1),
    // rust: (0, 0),
    // rust: Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 1,
    // rust: h: 1,
    // rust: },
    // rust: )
}

    // A box whose text is `chars` characters wide and `lines` lines tall.
edit :: proc(font: ^Font, chars: uint, lines: uint) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let advance = font.advance('a', &Style::default());
    // rust: MultiLineEdit::new(
    // rust: font,
    // rust: 0.0,
    // rust: 0.0,
    // rust: chars as f32 * advance + 8.0,
    // rust: LINE * lines as f32 + 8.0,
    // rust: )
}

lines_break_at_newlines_and_at_the_last_space_that_fits :: proc() {
}
    // rust: let font = font();
    // rust: let split = |text: &str, chars: usize| {
    // rust: let advance = font.advance('a', &Style::default());
    // rust: let text: Vec<char> = text.chars().collect();
    // rust: split_ranges(&font, &text, chars as f32 * advance)
}
    // rust: assert_eq!(split("abcd efgh", 4), [(0, 4), (5, 9)]);
        // No space to break at: before the character that overflows.
    // rust: assert_eq!(split("abcdefgh", 4), [(0, 4), (4, 8)]);
    // rust: assert_eq!(split("ab\ncd", 4), [(0, 2), (3, 5)]);
        // A trailing newline starts no line here; the text field adds it.
    // rust: assert_eq!(split("ab\n", 4), [(0, 2)]);
    // rust: assert_eq!(split("", 4), []);
}

a_trailing_newline_gets_an_empty_last_line :: proc() {
}
    // rust: let font = font();
    // rust: let mut edit = edit(&font, 8, 4);
    // rust: assert_eq!(edit.lines(), [(0, 0)]);
    // rust: edit.insert_text(&font, "ab\n");
    // rust: assert_eq!(edit.lines(), [(0, 2), (3, 3)]);
    // rust: assert_eq!(edit.cursor(), 3);
}

the_character_limit_cuts_what_is_typed_and_set :: proc() {
}
    // rust: let font = font();
    // rust: let mut edit = edit(&font, 8, 4);
    // rust: edit.set_character_limit(5);
    // rust: edit.set_value(&font, "abcdefgh");
    // rust: assert_eq!(edit.value(), "abcde");
    // rust: edit.key(&font, KeyCode::Backspace, false, false);
    // rust: edit.insert_text(&font, "wxyz");
    // rust: assert_eq!(edit.value(), "abcdw");
}

the_line_limit_refuses_an_edit_that_adds_a_line :: proc() {
}
    // rust: let font = font();
    // rust: let mut edit = edit(&font, 8, 4);
    // rust: edit.set_line_limit(2);
    // rust: edit.set_value(&font, "a\nb");
    // rust: assert_eq!(edit.value(), "a\nb");
        // A third line, by a newline or by wrapping, changes nothing.
    // rust: edit.key(&font, KeyCode::Enter, false, false);
    // rust: edit.insert_text(&font, "\nc");
    // rust: assert_eq!(edit.value(), "a\nb");
    // rust: edit.insert_text(&font, " abcdefghijkl");
    // rust: assert_eq!(edit.value(), "a\nb");
        // A value over the limit is not set at all.
    // rust: edit.set_value(&font, "1\n2\n3");
    // rust: assert_eq!(edit.value(), "a\nb");
        // A trailing newline counts as a line.
    // rust: edit.set_value(&font, "a\n");
    // rust: edit.insert_text(&font, "\n");
    // rust: assert_eq!(edit.value(), "a\n");
}

up_and_down_keep_the_column_and_home_and_end_stay_on_the_line :: proc() {
}
    // rust: let font = font();
    // rust: let mut edit = edit(&font, 8, 4);
    // rust: edit.set_value(&font, "abcd\nef\nghij");
        // From the end of `ghij` up to `ef`: the end of the shorter line.
    // rust: edit.key(&font, KeyCode::ArrowUp, false, false);
    // rust: assert_eq!(edit.cursor(), 7);
    // rust: edit.key(&font, KeyCode::ArrowUp, false, false);
    // rust: assert_eq!(edit.cursor(), 2);
    // rust: edit.key(&font, KeyCode::Home, false, false);
    // rust: assert_eq!(edit.cursor(), 0);
    // rust: edit.key(&font, KeyCode::End, false, false);
    // rust: assert_eq!(edit.cursor(), 4);
    // rust: edit.key(&font, KeyCode::End, true, false);
    // rust: assert_eq!(edit.cursor(), 12);
    // rust: edit.key(&font, KeyCode::PageUp, false, false);
    // rust: assert_eq!(edit.cursor(), 0);
}

shift_selects_and_typing_replaces_the_selection :: proc() {
}
    // rust: let font = font();
    // rust: let mut edit = edit(&font, 8, 4);
    // rust: edit.set_value(&font, "one two");
    // rust: edit.key(&font, KeyCode::ArrowLeft, true, true);
    // rust: assert_eq!(edit.selected_text(), "two");
    // rust: edit.insert_text(&font, "2");
    // rust: assert_eq!(edit.value(), "one 2");
    // rust: edit.set_value(&font, "one two");
    // rust: edit.key(&font, KeyCode::Backspace, true, false);
    // rust: assert_eq!(edit.value(), "one ");
}

the_box_scrolls_to_keep_the_cursor_in_view :: proc() {
}
    // rust: let font = font();
    // rust: let mut edit = edit(&font, 8, 2);
    // rust: edit.set_value(&font, "1\n2\n3\n4\n5");
        // Five lines in two lines' height: the end shows.
    // rust: assert_eq!(edit.scroll.amount, 9.0 * 5.0 + 8.0 - edit.height);
    // rust: edit.key(&font, KeyCode::PageUp, false, false);
    // rust: assert_eq!(edit.scroll.amount, 0.0);
    // rust: edit.wheel(-1.0);
    // rust: assert_eq!(edit.scroll.amount, SCROLL_RATE);
}

a_click_puts_the_cursor_on_the_line_and_character_under_it :: proc() {
}
    // rust: let font = font();
    // rust: let mut edit = edit(&font, 8, 4);
    // rust: edit.set_value(&font, "abcd\nefgh");
    // rust: let advance = font.advance('a', &Style::default());
        // The second line, after two characters.
    // rust: edit.click(
    // rust: &font,
    // rust: (4.0 + 2.0 * advance + 1.0, 4.0 + 9.0 + 1.0),
    // rust: false,
    // rust: false,
    // rust: );
    // rust: assert_eq!(edit.cursor(), 7);
        // Shift extends the selection.
    // rust: edit.click(&font, (4.0 + 1.0, 4.0 + 1.0), true, false);
    // rust: assert_eq!(edit.selected_text(), "abcd\nef");
        // A double click, after the plain click that starts it, selects the word.
    // rust: edit.click(&font, (4.0 + 1.0, 4.0 + 1.0), false, false);
    // rust: edit.click(&font, (4.0 + 1.0, 4.0 + 1.0), false, true);
    // rust: assert_eq!(edit.selected_text(), "abcd");
}
}
