//! Transpiled from Horizon Rust crate
package horizon_client_render_screen_draw

import "core:fmt"
import "core:mem"
import "core:math"

// Menu screens as the `GuiGraphicsExtractor` calls vanilla's widgets make
// (sprites, texture blits, fills, text highlight, text, scissor and the
// tooltip), with ports of the widgets that make them: `StringWidget`,
// `MultiLineTextWidget`, `Button`, `EditBox` (a font-aware port, scrolling
// included) and the label layouts. The screen layouts built on them
// (`pack_screen`) are compared with vanilla's calls by the parity harnesses;
// [`paint`] draws them with the HUD batch.
// use crate::{
    // rust: font::Font,
    // rust: hud::{HudAtlas, HudBatch},
    // rust: text::{Style, Text},
}

// One GUI call.
Draw :: enum {
    // `blitSprite`, the id without its namespace.
    Sprite {,
    sprite: String,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
    color: i32,
    // rust: },
    // `blit` of a texture region; `texture` is the full path (`textures/…png`).
    Blit {,
    texture: String,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
    u: f32,
    v: f32,
    src: [i32; 2],
    tex: [i32; 2],
    color: i32,
    // rust: },
    // `fill`, corners sorted.
    Fill {,
    x0: i32,
    y0: i32,
    x1: i32,
    y1: i32,
    color: i32,
    // rust: },
    // `textHighlight`.
    Highlight {,
    x0: i32,
    y0: i32,
    x1: i32,
    y1: i32,
    // rust: },
    Text {,
    text: Text,
    x: i32,
    y: i32,
    color: i32,
    shadow: bool,
    // rust: },
    // `enableScissor`, `disableScissor`.
    Scissor {,
    x0: i32,
    y0: i32,
    x1: i32,
    y1: i32,
    // rust: },
    NoScissor,
    // `setTooltipForNextFrame`: the split lines and the mouse.
    Tooltip {,
    lines: Vec<Text>,
    x: i32,
    y: i32,
    // rust: },
}

WHITE :: -1
GRAY :: 0xAAAAAA
DARK_GRAY :: 0x555555

fill :: proc(out: ^[dynamic]Draw, x0: i32, y0: i32, x1: i32, y1: i32, color: i32) {
}
    // rust: out.push(Draw::Fill {
    // rust: x0: x0.min(x1),
    // rust: y0: y0.min(y1),
    // rust: x1: x0.max(x1),
    // rust: y1: y0.max(y1),
    // rust: color,
    // rust: });
}
// What a screen wants drawn behind it, for screens that are Horizon's own.
//
// The panorama is the spinning cube the renderer draws before the HUD, not
// something a draw list can hold, so a screen cannot simply emit it: it says
// here that it wants one and the renderer obeys. Existing screens that
// already show a panorama (the title and the loading screens) decide it
// their own way, in `Game::shows_panorama`, and are untouched by this: a
// screen that leaves this at [`Backdrop::None`] behaves exactly as before.
//
// This exists so a new Horizon screen can have the menu panorama without
// each one growing its own special case in the frame loop.
Backdrop :: enum {
    // Whatever is already behind the screen: the world, or the flat menu
    // background the screen draws itself. The default, and what every
    // vanilla screen uses.
    None,
    // The menu panorama, as the title screen shows it. The screen should
    // still draw its own panels over it; the panorama only replaces what
    // would otherwise be empty background.
    Panorama,
}

sprite :: proc(out: ^[dynamic]Draw, sprite: string, x: i32, y: i32, w: i32, h: i32) {
}
    // rust: out.push(Draw::Sprite {
    // rust: sprite: sprite.to_owned(),
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: color: WHITE,
    // rust: });
}
// `blit(pipeline, texture, x, y, u, v, w, h, texW, texH)`.
    // rust: pub fn blit(
    // rust: out: &mut Vec<Draw>,
    // rust: texture: &str,
    // rust: x: i32,
    // rust: y: i32,
    // rust: uv: (f32, f32),
    // rust: w: i32,
    // rust: h: i32,
    // rust: tex: [i32; 2],
    // rust: ) {
    // rust: out.push(Draw::Blit {
    // rust: texture: texture.to_owned(),
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: u: uv.0,
    // rust: v: uv.1,
    // rust: src: [w, h],
    // rust: tex,
    // rust: color: WHITE,
    // rust: });
}
// `graphics.text`: dropped when fully transparent; legacy codes resolved.
text :: proc(out: ^[dynamic]Draw, text: Text, x: i32, y: i32, color: i32, shadow: bool) {
}
    // rust: if (color as u32) >> 24 != 0 {
    // rust: out.push(Draw::Text {
    // rust: text: text.resolve_legacy(),
    // rust: x,
    // rust: y,
    // rust: color,
    // rust: shadow,
    // rust: });
}
}
// `graphics.text` on text the caller already styled, drawn as it is: a `§`
// in it stays a character, as `FormattedCharSequence.forward`
// (`StringDecomposer.iterate`, not `iterateFormatted`) draws it. An edit box
// builds its own sequence that way, so a `§` in its value shows.
text_as_typed :: proc(out: ^[dynamic]Draw, text: Text, x: i32, y: i32, color: i32, shadow: bool) {
}
    // rust: if (color as u32) >> 24 != 0 {
    // rust: out.push(Draw::Text {
    // rust: text,
    // rust: x,
    // rust: y,
    // rust: color,
    // rust: shadow,
    // rust: });
}
}

// `StringDecomposer.iterateFormatted`: the drawn characters of `contents`,
// with their index in it and their style; legacy `§` codes restyle what
// follows them, `§r` returns to `reset`.
formatted :: proc(contents: string, current: ^Style, reset: ^Style) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let chars: Vec<char> = contents.chars().collect();
    // rust: let mut style = current.clone();
    // rust: let mut out = Vec::new();
    // rust: let mut i = 0;
    // rust: while i < chars.len() {
    // rust: let c = chars[i];
    // rust: if c == '§' {
    // rust: let Some(code) = chars.get(i + 1) else { break };
    // rust: let code = code.to_ascii_lowercase();
    // rust: if let Some(c) = crate::text::COLORS.iter().find(|c| c.0 == code) {
    // rust: style = Style {
    // rust: color: Some(c.2),
    // rust: bold: Some(false),
    // rust: italic: Some(false),
    // rust: underlined: Some(false),
    // rust: strikethrough: Some(false),
    // rust: obfuscated: Some(false),
    // rust: ..style
}
    // rust: } else {
    // rust: match code {
    // rust: 'k' => style.obfuscated = Some(true),
    // rust: 'l' => style.bold = Some(true),
    // rust: 'm' => style.strikethrough = Some(true),
    // rust: 'n' => style.underlined = Some(true),
    // rust: 'o' => style.italic = Some(true),
    // rust: 'r' => style = reset.clone(),
    // rust: _ => {}
}
}
    // rust: i += 2;
    // rust: continue;
}
    // rust: out.push((i, c, style.clone()));
    // rust: i += 1;
}
    // rust: out
}

// Text measurement as vanilla's `Font` and `StringSplitter` do it, on
// text whose spans may hold legacy `§` codes (each span is a component's
// contents and style).
Measure :: struct {
    // rust: impl Measure<'_> {
    // `Font.width`.
width :: proc(self: ^Self, t: ^Text) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0.width_text(&t.resolve_legacy()) as i32
}
    // `Font.width(FormattedCharSequence)` of a sequence drawn as it is: a
    // `§` in the text counts as the glyph it is drawn as.
width_drawn :: proc(self: ^Self, t: ^Text) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0.width_drawn(t) as i32
}
width_str :: proc(self: ^Self, s: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0.width(s) as i32
}
    // `StringSplitter.headByWidth`: the leading characters whose widths sum to at most `max`.
head :: proc(self: ^Self, t: ^Text, max: i32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut left = max as f32;
    // rust: let mut out = Text::empty();
    // rust: for span in &t.spans {
    // rust: let mut end = None;
    // rust: let mut position = 0;
    // rust: for (i, c, style) in formatted(&span.text, &span.style, &span.style) {
    // rust: left -= self.0.advance(c, &style);
    // rust: if left >= 0.0 {
    // rust: position = i + 1;
    // rust: } else {
    // rust: end = Some(position);
    // rust: break;
}
}
    // rust: match end {
    // rust: Some(p) => {
    // rust: out.push(Text::styled(
    // rust: span.text.chars().take(p).collect::<String>(),
    // rust: span.style.clone(),
    // rust: ));
    // rust: return out;
}
    // rust: None => out.push(Text::styled(span.text.clone(), span.style.clone())),
}
}
    // rust: t.clone()
}
    // `Font.plainSubstrByWidth`, from the start or (`tail`) the end, in characters.
plain :: proc(self: ^Self, s: string, max: i32, tail: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if tail {
    // rust: self.0.fit_reverse(s, max as f32)
    // rust: } else {
    // rust: self.0.fit(s, max as f32)
}
}
    // `StringSplitter.splitLines` (`Font.split`): breaks at a newline, or
    // at the last space (else the character) once the width is exceeded;
    // the rest of a broken part takes the style found at the break, legacy
    // codes counted from the root style.
split :: proc(self: ^Self, t: ^Text, max: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let max = (max as f32).max(1.0);
    // rust: let mut parts: Vec<(Vec<char>, Style)> = t
    // rust: .spans
    // rust: .iter()
    // rust: .filter(|s| !s.text.is_empty())
    // rust: .map(|s| (s.text.chars().collect(), s.style.clone()))
    // rust: .collect();
    // rust: let mut lines = Vec::new();
    // rust: let mut force_new_line = false;
    // rust: let root = Style::default();
    // rust: 'restart: loop {
    // rust: let (mut width, mut had_visible) = (0.0f32, false);
    // rust: let (mut last_space, mut last_space_style) = (None::<usize>, Style::default());
    // rust: let mut offset = 0;
    // rust: for (pi, (contents, style)) in parts.iter().enumerate() {
    // rust: let s: String = contents.iter().collect();
    // rust: for (i, c, st) in formatted(&s, style, &root) {
    // rust: let at = i + offset;
    // rust: let brk = if c == '\n' {
    // rust: Some((at, st.clone()))
    // rust: } else {
    // rust: if c == ' ' {
    // rust: last_space = Some(at);
    // rust: last_space_style = st.clone();
}
    // rust: let w = self.0.advance(c, &st);
    // rust: width += w;
    // rust: if !had_visible || width <= max {
    // rust: had_visible |= w != 0.0;
    // rust: None
    // rust: } else {
    // rust: Some(match last_space {
    // rust: Some(p) => (p, last_space_style.clone()),
    // rust: None => (at, st.clone()),
    // rust: })
}
}
    // rust: if let Some((at, split_style)) = brk {
    // rust: let flat: Vec<char> =
    // rust: parts.iter().flat_map(|p| p.0.iter().copied()).collect();
    // rust: let first = flat.get(at).copied().unwrap_or(' ');
    // rust: let new_line = first == '\n';
    // rust: let skip = usize::from(new_line || first == ' ');
    // rust: force_new_line = new_line;
                        // FlatComponents.splitAt.
    // rust: let mut line = Text::empty();
    // rust: let mut position = at;
    // rust: let mut rest = Vec::new();
    // rust: let mut in_skip = false;
    // rust: let mut done = false;
    // rust: for (contents, style) in parts.drain(..) {
    // rust: if done {
    // rust: rest.push((contents, style));
    // rust: continue;
}
    // rust: let size = contents.len();
    // rust: if !in_skip {
    // rust: if position > size {
    // rust: line.push(Text::styled(
    // rust: contents.iter().collect::<String>(),
    // rust: style,
    // rust: ));
    // rust: position -= size;
    // rust: continue;
}
    // rust: let before: String = contents[..position].iter().collect();
    // rust: if !before.is_empty() {
    // rust: line.push(Text::styled(before, style.clone()));
}
    // rust: position += skip;
    // rust: in_skip = true;
}
    // rust: if position <= size {
    // rust: if position < size {
    // rust: rest.push((contents[position..].to_vec(), split_style.clone()));
}
    // rust: done = true;
    // rust: continue;
}
    // rust: position -= size;
}
    // rust: let _ = pi;
    // rust: parts = rest;
    // rust: lines.push(line);
    // rust: continue 'restart;
}
}
    // rust: offset += contents.len();
}
    // rust: break;
}
    // rust: if !parts.is_empty() {
    // rust: let mut line = Text::empty();
    // rust: for (contents, style) in parts {
    // rust: line.push(Text::styled(contents.iter().collect::<String>(), style));
}
    // rust: lines.push(line);
    // rust: } else if force_new_line {
    // rust: lines.push(Text::empty());
}
    // rust: lines
}
}

// `TextAlignment.CENTER.calculateLeft`.
center_left :: proc(anchor: i32, width: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: anchor - width / 2
}

// `ComponentRenderUtils.clipText`: as much as fits before an unstyled "...".
clip :: proc(m: ^Measure, t: ^Text, width: i32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: m.head(t, width - m.width_str("..."))
    // rust: .append(Text::literal("..."))
}

// `StringWidget` (CLAMPED) at its position: its single line, clipped when wider than `max_width`.
    // rust: pub fn string_widget(
    // rust: out: &mut Vec<Draw>,
    // rust: m: &Measure,
    // rust: message: &Text,
    // rust: x: i32,
    // rust: y: i32,
    // rust: max_width: i32,
    // rust: ) {
    // rust: let w = m.width(message);
    // rust: let max = if max_width > 0 { max_width } else { w };
    // rust: let line = if w > max {
    // rust: clip(m, message, max)
    // rust: } else {
    // rust: message.clone()
}
    // rust: text(out, line, x, y, WHITE, true);
}

// `MultiLineLabel.create(font, maxWidth, maxRows, message)`: the lines and their widths;
// the last kept line gets "..." in `ellipsis` (the message's own style) when rows were cut.
    // rust: pub fn label_lines(
    // rust: m: &Measure,
    // rust: message: &Text,
    // rust: max_width: i32,
    // rust: max_rows: usize,
    // rust: ellipsis: &Style,
    // rust: ) -> Vec<(Text, i32)> {
    // rust: let split = m.split(message, max_width);
    // rust: let n = split.len().min(max_rows);
    // rust: let mut out = Vec::new();
    // rust: for (i, line) in split.iter().take(n).enumerate() {
    // rust: if i == n - 1 && n == max_rows && n != split.len() {
    // rust: let clipped = m.head(line, m.width(line) - m.width_str("..."));
    // rust: let with = clipped.append(Text::styled("...", ellipsis.clone()));
    // rust: let w = m.width(&with);
    // rust: out.push((with, w));
    // rust: } else {
    // rust: out.push((line.clone(), m.width(line)));
}
}
    // rust: out
}
// `MultiLineTextWidget.getWidth`.
label_width :: proc(lines: ^[(Text) {
}
    // rust: lines.iter().map(|l| l.1).max().unwrap_or(0).min(max_width)
}
// `MultiLineTextWidget.visitLines`.
    // rust: pub fn label(
    // rust: out: &mut Vec<Draw>,
    // rust: lines: &[(Text, i32)],
    // rust: x: i32,
    // rust: y: i32,
    // rust: max_width: i32,
    // rust: centered: bool,
    // rust: ) {
    // rust: let mid = x + label_width(lines, max_width) / 2;
    // rust: for (i, (line, w)) in lines.iter().enumerate() {
    // rust: let left = if centered { center_left(mid, *w) } else { x };
    // rust: text(out, line.clone(), left, y + 9 * i as i32, WHITE, true);
}
}

// `ActiveTextCollector.PERIOD_PER_SCROLLED_PIXEL`.
PERIOD_PER_SCROLLED_PIXEL :: 0.5
// `ActiveTextCollector.MIN_SCROLL_PERIOD`.
MIN_SCROLL_PERIOD :: 3.0

// How far `ActiveTextCollector.defaultScrollingHelper` has slid a line left
// of the box's left edge at `now_ms` (`Util.getMillis`), for a line that
// overflows the box by `max_position` pixels. A whole cycle takes
// `max(max_position * 0.5, 3)` seconds, eased with a sine, so the line rests
// a moment at each end; at time 0 it is at the far end.
scroll_offset :: proc(max_position: i32, now_ms: i64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let time = now_ms as f64 / 1000.0;
    // rust: let period = (f64::from(max_position) * PERIOD_PER_SCROLLED_PIXEL).max(MIN_SCROLL_PERIOD);
    // rust: let alpha = horizon_core::jmath::sin(
    // rust: (std::f64::consts::PI / 2.0)
    // rust: * horizon_core::jmath::cos(std::f64::consts::PI * 2.0 * time / period),
    // rust: ) / 2.0
    // rust: + 0.5;
    // `Mth.lerp(alpha, 0.0, maxPosition)`, then the `(int)` cast.
    // rust: (0.0 + alpha * (f64::from(max_position) - 0.0)) as i32
}

// `ActiveTextCollector.defaultScrollingHelper` with the line height of 9
// that `acceptScrolling` passes: a message that fits is centred on
// `center_x`, kept inside `[left, right]`; a wider one is left-aligned,
// clipped to the box and slides back and forth with the clock (`now_ms`).
// Vanilla intersects that clip with the enclosing scissor; `paint` does not
// stack scissors, so this must not be drawn inside another `Draw::Scissor`.
    // rust: pub fn scrolling_text(
    // rust: out: &mut Vec<Draw>,
    // rust: m: &Measure,
    // rust: message: &Text,
    // rust: center_x: i32,
    // rust: left: i32,
    // rust: right: i32,
    // rust: top: i32,
    // rust: bottom: i32,
    // rust: now_ms: i64,
    // rust: ) {
    // rust: let line_width = m.width(message);
    // rust: let text_top = (top + bottom - 9) / 2 + 1;
    // rust: let available = right - left;
    // rust: if line_width > available {
    // rust: let pos = scroll_offset(line_width - available, now_ms);
    // rust: out.push(Draw::Scissor {
    // rust: x0: left,
    // rust: y0: top,
    // rust: x1: right,
    // rust: y1: bottom,
    // rust: });
    // rust: text(out, message.clone(), left - pos, text_top, WHITE, true);
    // rust: out.push(Draw::NoScissor);
    // rust: } else {
        // Here `left + line_width / 2 <= right - line_width / 2`, so the
        // clamp's bounds are in order.
    // rust: let text_x = center_x.clamp(left + line_width / 2, right - line_width / 2);
    // rust: let at = center_left(text_x, line_width);
    // rust: text(out, message.clone(), at, text_top, WHITE, true);
}
}

// `ActiveTextCollector.acceptScrollingWithDefaultCenter`: `scrolling_text`
// centred between `left` and `right`.
    // rust: pub fn scrolling_with_default_center(
    // rust: out: &mut Vec<Draw>,
    // rust: m: &Measure,
    // rust: message: &Text,
    // rust: left: i32,
    // rust: right: i32,
    // rust: top: i32,
    // rust: bottom: i32,
    // rust: now_ms: i64,
    // rust: ) {
    // rust: let center = (left + right) / 2;
    // rust: scrolling_text(out, m, message, center, left, right, top, bottom, now_ms);
}

// `AbstractWidget.extractScrollingStringOverContents`: `message` over the
// widget's box less `margin` on each side (centred, or scrolling when too
// wide).
    // rust: pub fn scrolling_string_over_contents(
    // rust: out: &mut Vec<Draw>,
    // rust: m: &Measure,
    // rust: message: &Text,
    // rust: x: i32,
    // rust: y: i32,
    // rust: w: i32,
    // rust: h: i32,
    // rust: margin: i32,
    // rust: now_ms: i64,
    // rust: ) {
    // rust: let (left, right) = (x + margin, x + w - margin);
    // rust: scrolling_with_default_center(out, m, message, left, right, y, y + h, now_ms);
}

// `Button` (`extractDefaultSprite`, then `AbstractButton.extractDefaultLabel`:
// `extractScrollingStringOverContents` with a margin of 2, which scrolls a
// label wider than the button with the clock, `now_ms`).
    // rust: pub fn button(
    // rust: out: &mut Vec<Draw>,
    // rust: m: &Measure,
    // rust: label: &Text,
    // rust: x: i32,
    // rust: y: i32,
    // rust: w: i32,
    // rust: h: i32,
    // rust: active: bool,
    // rust: highlighted: bool,
    // rust: now_ms: i64,
    // rust: ) {
    // Its narration: hovered is the mouse over it (`isHovered`), which the
    // narrator tests.
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::button(
    // rust: label.plain(),
    // rust: [x as f32, y as f32, w as f32, h as f32],
    // rust: active,
    // rust: )
    // rust: });
    // rust: let sprite_id = if !active {
    // rust: "widget/button_disabled"
    // rust: } else if highlighted {
    // rust: "widget/button_highlighted"
    // rust: } else {
    // rust: "widget/button"
}
    // rust: sprite(out, sprite_id, x, y, w, h);
    // rust: scrolling_string_over_contents(out, m, label, x, y, w, h, 2, now_ms);
}
// `Tooltip.splitTooltip` of a widget's tooltip, shown under the mouse.
tooltip :: proc(out: ^[dynamic]Draw, m: ^Measure, message: ^Text, mouse: (i32) {
}
    // rust: out.push(Draw::Tooltip {
    // rust: lines: m.split(message, 170),
    // rust: x: mouse.0,
    // rust: y: mouse.1,
    // rust: });
}
// `AbstractWidget.areCoordinatesInRectangle`.
inside :: proc(mouse: (i32) {
}
    // rust: mouse.0 >= x && mouse.1 >= y && mouse.0 < x + w && mouse.1 < y + h
}

// Vanilla's `EditBox`: value, cursor, selection and the first shown
// character, which follows the cursor as `scrollTo` moves it. Positions
// are in characters.
TextField :: struct {
    value: string,
    cursor: uint,
    highlight: uint,
    display: uint,
    max_length: uint,
    bordered: bool,
    x: i32,
    y: i32,
    width: i32,
    height: i32,
    focused: bool,
    text_color: i32,
    text_shadow: bool,
    hint: Maybe(Text),
    suggestion: Maybe(string),
    // `getMessage`: what the narrator calls the box.
    message: string,
}
chars :: proc(s: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: s.chars().count()
}
sub :: proc(s: string, from: uint, to: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: s.chars().skip(from).take(to.saturating_sub(from)).collect()
}
// A text field with the font that scrolls it.
MeasuredField :: struct {
    // rust: impl crate::clipboard::Editable for MeasuredField<'_, '_> {
select_all :: proc(self: ^Self) {
}
    // rust: let len = chars(&self.0.value);
    // rust: self.0.move_cursor_to(self.1, len, false);
    // rust: self.0.set_highlight(self.1, 0);
}
selected_text :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.0.selected_text()
}
insert :: proc(self: ^Self, text: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let before = self.0.value.clone();
    // rust: self.0.insert_text(self.1, text);
    // rust: self.0.value != before
}
}
    // rust: impl TextField {
new :: proc(x: i32, y: i32, width: i32, height: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: value: String::new(),
    // rust: cursor: 0,
    // rust: highlight: 0,
    // rust: display: 0,
    // rust: max_length: 32,
    // rust: bordered: true,
    // rust: x,
    // rust: y,
    // rust: width,
    // rust: height,
    // rust: focused: false,
    // rust: text_color: -2039584,
    // rust: text_shadow: true,
    // rust: hint: None,
    // rust: suggestion: None,
    // rust: message: String::new(),
}
}
inner_width :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.bordered {
    // rust: self.width - 8
    // rust: } else {
    // rust: self.width
}
}
text_x :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.x + if self.bordered { 4 } else { 0 }
}
text_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.bordered {
    // rust: self.y + (self.height - 8) / 2
    // rust: } else {
    // rust: self.y
}
}
    // `setValue`.
set_value :: proc(self: ^Self, m: ^Measure, value: string) {
}
    // rust: self.value = value.chars().take(self.max_length).collect();
    // rust: self.move_cursor_to(m, chars(&self.value), false);
    // rust: self.set_highlight(m, self.cursor);
}
    // `insertText`: replaces the selection within the maximum length. True
    // when the value changed (its responder runs).
insert_text :: proc(self: ^Self, m: ^Measure, input: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (start, end) = (
    // rust: self.cursor.min(self.highlight),
    // rust: self.cursor.max(self.highlight),
    // rust: );
    // rust: let room = self.max_length as isize - chars(&self.value) as isize + (end - start) as isize;
    // rust: if room <= 0 {
    // rust: return false;
}
    // rust: let filtered: String = input
    // rust: .chars()
    // rust: .filter(|c| *c >= ' ' && *c != '\u{7f}' && *c != '§')
    // rust: .collect();
    // rust: let insert: String = filtered.chars().take(room as usize).collect();
    // rust: let n = chars(&insert);
    // rust: self.value = format!(
    // rust: "{}{}{}",
    // rust: sub(&self.value, 0, start),
    // rust: insert,
    // rust: sub(&self.value, end, chars(&self.value))
    // rust: );
    // rust: self.set_cursor(m, start + n);
    // rust: self.set_highlight(m, self.cursor);
    // rust: true
}
    // `deleteChars(dir)`: the selection, or `dir` characters from the cursor.
delete_chars :: proc(self: ^Self, m: ^Measure, dir: int) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.value.is_empty() {
    // rust: return false;
}
    // rust: if self.highlight != self.cursor {
    // rust: return self.insert_text(m, "");
}
    // rust: let pos = (self.cursor as isize + dir).clamp(0, chars(&self.value) as isize) as usize;
    // rust: let (start, end) = (pos.min(self.cursor), pos.max(self.cursor));
    // rust: if start == end {
    // rust: return false;
}
    // rust: self.value = format!(
    // rust: "{}{}",
    // rust: sub(&self.value, 0, start),
    // rust: sub(&self.value, end, chars(&self.value))
    // rust: );
    // rust: self.set_cursor(m, start);
    // rust: self.move_cursor_to(m, start, false);
    // rust: true
}
move_cursor_to :: proc(self: ^Self, m: ^Measure, pos: uint, extend: bool) {
}
    // rust: self.set_cursor(m, pos);
    // rust: if !extend {
    // rust: self.set_highlight(m, self.cursor);
}
}
set_cursor :: proc(self: ^Self, m: ^Measure, pos: uint) {
}
    // rust: self.cursor = pos.min(chars(&self.value));
    // rust: self.scroll_to(m, self.cursor);
}
set_highlight :: proc(self: ^Self, m: ^Measure, pos: uint) {
}
    // rust: self.highlight = pos.min(chars(&self.value));
    // rust: self.scroll_to(m, self.highlight);
}
scroll_to :: proc(self: ^Self, m: ^Measure, pos: uint) {
}
    // rust: let len = chars(&self.value);
    // rust: self.display = self.display.min(len);
    // rust: let inner = self.inner_width();
    // rust: let rest = sub(&self.value, self.display, len);
    // rust: let last = m.plain(&rest, inner, false) + self.display;
    // rust: let mut display = self.display as isize;
    // rust: if pos == self.display {
    // rust: display -= m.plain(&self.value, inner, true) as isize;
}
    // rust: if pos > last {
    // rust: display += (pos - last) as isize;
    // rust: } else if pos as isize <= display {
    // rust: display = pos as isize;
}
    // rust: self.display = display.clamp(0, len as isize) as usize;
}
    // `getWordPosition(dir, from)`: past the next space run, or back to the
    // start of the word.
word_position :: proc(self: ^Self, dir: int, from: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: crate::ui::word_position(&self.value, dir, from)
}
    // `keyPressed` of a focused, editable box: `Some(changed)` when handled.
    // rust: pub fn key(
    // rust: &mut self,
    // rust: m: &Measure,
    // rust: key: winit::keyboard::KeyCode,
    // rust: shift: bool,
    // rust: ctrl: bool,
    // rust: ) -> Option<bool> {
//         use winit::keyboard::KeyCode as K;
    // rust: let len = chars(&self.value);
    // rust: match key {
    // rust: K::Backspace | K::Delete => {
    // rust: let dir = if key == K::Backspace { -1 } else { 1 };
    // rust: if !ctrl {
    // rust: return Some(self.delete_chars(m, dir));
}
                // deleteWords.
    // rust: if self.value.is_empty() {
    // rust: return Some(false);
}
    // rust: if self.highlight != self.cursor {
    // rust: return Some(self.insert_text(m, ""));
}
    // rust: let to = self.word_position(dir, self.cursor);
    // rust: return Some(self.delete_chars(m, to as isize - self.cursor as isize));
}
    // rust: K::Home => self.move_cursor_to(m, 0, shift),
    // rust: K::End => self.move_cursor_to(m, len, shift),
    // rust: K::ArrowRight | K::ArrowLeft => {
    // rust: let dir = if key == K::ArrowRight { 1 } else { -1 };
    // rust: let to = if ctrl {
    // rust: self.word_position(dir, self.cursor)
    // rust: } else {
    // rust: (self.cursor as isize + dir).clamp(0, len as isize) as usize
}
    // rust: self.move_cursor_to(m, to, shift);
}
    // rust: K::KeyA if ctrl && !shift => {
    // rust: self.move_cursor_to(m, len, false);
    // rust: self.set_highlight(m, 0);
}
    // rust: _ => return None,
}
    // rust: Some(false)
}
    // Ctrl+A/C/V/X (`EditBox.keyPressed`). True when the value changed.
    // rust: pub fn shortcut(
    // rust: &mut self,
    // rust: m: &Measure,
    // rust: shortcut: crate::clipboard::EditShortcut,
    // rust: clipboard: &mut dyn crate::clipboard::Clipboard,
    // rust: ) -> bool {
    // rust: crate::clipboard::apply(&mut MeasuredField(self, m), shortcut, clipboard)
}
    // `getHighlighted`.
selected_text :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: sub(
    // rust: &self.value,
    // rust: self.cursor.min(self.highlight),
    // rust: self.cursor.max(self.highlight),
    // rust: )
}
    // `getScreenX`: where a character index is drawn, from the box's left.
screen_x :: proc(self: ^Self, m: ^Measure, index: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if index > chars(&self.value) {
    // rust: return self.x;
}
    // rust: self.x + m.width_str(&sub(&self.value, 0, index))
}
    // `setCursorPosition` then `setHighlightPos`.
set_cursor_and_highlight :: proc(self: ^Self, m: ^Measure, pos: uint) {
}
    // rust: self.set_cursor(m, pos);
    // rust: self.set_highlight(m, pos);
}
    // `onClick`: the cursor where the mouse is (`findClickedPositionInText`).
click :: proc(self: ^Self, m: ^Measure, x: f64, extend: bool) {
}
    // rust: let pos = (x.floor() as i32 - self.text_x()).min(self.inner_width());
    // rust: let rest = sub(&self.value, self.display, chars(&self.value));
    // rust: let at = self.display + m.plain(&rest, pos, false);
    // rust: self.move_cursor_to(m, at, extend);
}
contains :: proc(self: ^Self, x: f64, y: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: x >= self.x as f64
    // rust: && y >= self.y as f64
    // rust: && x < (self.x + self.width) as f64
    // rust: && y < (self.y + self.height) as f64
}
    // `extractWidgetRenderState`; `blink_ms` is the time since the field
    // was focused, `format` styles a substring starting at a character index.
    // rust: pub fn draw(
    // rust: &self,
    // rust: out: &mut Vec<Draw>,
    // rust: m: &Measure,
    // rust: blink_ms: u64,
    // rust: format: Option<&dyn Fn(&str, usize) -> Text>,
    // rust: ) {
    // rust: let rect = [
    // rust: self.x as f32,
    // rust: self.y as f32,
    // rust: self.width as f32,
    // rust: self.height as f32,
    // rust: ];
    // rust: crate::widgets::target_as(rect, crate::widgets::Kind::Field);
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::edit_box(self.message.clone(), self.value.clone(), rect)
    // rust: .focused(self.focused)
    // rust: });
    // rust: if self.bordered {
    // rust: let s = if self.focused {
    // rust: "widget/text_field_highlighted"
    // rust: } else {
    // rust: "widget/text_field"
}
    // rust: sprite(out, s, self.x, self.y, self.width, self.height);
}
    // rust: let color = self.text_color;
    // rust: let len = chars(&self.value);
    // rust: let rest = sub(&self.value, self.display, len);
    // rust: let shown_len = m.plain(&rest, self.inner_width(), false);
    // rust: let displayed = sub(&rest, 0, shown_len);
    // rust: let rel_cursor = self.cursor as isize - self.display as isize;
    // rust: let on_screen = rel_cursor >= 0 && rel_cursor <= shown_len as isize;
    // rust: let show_cursor = self.focused && (blink_ms / 300).is_multiple_of(2) && on_screen;
    // rust: let (tx, ty) = (self.text_x(), self.text_y());
    // rust: let mut draw_x = tx;
    // rust: let rel_highlight =
    // rust: (self.highlight as isize - self.display as isize).clamp(0, shown_len as isize) as usize;
    // rust: let styled = |s: String, offset: usize| match format {
    // rust: Some(f) => f(&s, offset),
    // rust: None => Text::literal(s),
}
    // rust: if !displayed.is_empty() {
    // rust: let half = if on_screen {
    // rust: sub(&displayed, 0, rel_cursor as usize)
    // rust: } else {
    // rust: displayed.clone()
}
    // rust: let t = styled(half, self.display);
    // rust: let w = m.width_drawn(&t);
    // rust: text_as_typed(out, t, draw_x, ty, color, self.text_shadow);
    // rust: draw_x += w + 1;
}
    // rust: let insert = self.cursor < len || len >= self.max_length;
    // rust: let mut cursor_x = draw_x;
    // rust: if !on_screen {
    // rust: cursor_x = if rel_cursor > 0 { tx + self.width } else { tx };
    // rust: } else if insert {
    // rust: cursor_x -= 1;
    // rust: draw_x -= 1;
}
    // rust: if !displayed.is_empty() && on_screen && (rel_cursor as usize) < shown_len {
    // rust: let t = styled(sub(&displayed, rel_cursor as usize, shown_len), self.cursor);
    // rust: text_as_typed(out, t, draw_x, ty, color, self.text_shadow);
}
    // rust: if let Some(hint) = &self.hint
    // rust: && displayed.is_empty()
    // rust: && !self.focused
    // rust: {
    // rust: text(out, hint.clone(), draw_x, ty, color, true);
}
    // rust: if !insert && let Some(s) = &self.suggestion {
    // rust: text(
    // rust: out,
    // rust: Text::literal(s.clone()),
    // rust: cursor_x - 1,
    // rust: ty,
    // rust: -8355712,
    // rust: self.text_shadow,
    // rust: );
}
    // rust: if rel_highlight as isize != rel_cursor {
    // rust: let hx = tx + m.width_str(&sub(&displayed, 0, rel_highlight));
    // rust: let right = self.x + self.width;
    // rust: out.push(Draw::Highlight {
    // rust: x0: cursor_x.min(right),
    // rust: y0: ty - 1,
    // rust: x1: (hx - 1).min(right),
    // rust: y1: ty + 1 + 9,
    // rust: });
}
    // rust: if show_cursor {
    // rust: if insert {
    // rust: fill(out, cursor_x, ty - 1, cursor_x + 1, ty + 10, color);
    // rust: } else {
    // rust: text(
    // rust: out,
    // rust: Text::literal("_"),
    // rust: cursor_x,
    // rust: ty,
    // rust: color,
    // rust: self.text_shadow,
    // rust: );
}
}
    // rust: if self.focused {
            // `TextInputManager.setTextInputArea`, in GUI pixels: the caret
            // the input method's composition and its candidate window go to.
            // The chat and in-bed chat boxes and the pack screen's search are
            // `TextField`s; the other fields are an `EditBox` or a multiline
            // box, which report their own.
    // rust: crate::preedit::report_caret(cursor_x as f32, ty as f32, 10.0);
}
}
}

// Draws the calls with the HUD batch: sprites nine-sliced, textures from
// the atlas (`textures/gui/x.png` is `gui/x`; tiled textures from their
// corner), scissor clipping, and the tooltip at the mouse.
paint :: proc(batch: ^HudBatch, atlas: ^HudAtlas, draws: ^[Draw]) {
}
    // rust: let mut clip: Option<(usize, [i32; 4])> = None;
    // rust: let mut tooltip = None;
    // rust: for d in draws {
    // rust: match d {
    // rust: Draw::Sprite {
    // rust: sprite,
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: color,
    // rust: } => crate::ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: &format!("gui/sprites/{sprite}"),
    // rust: *x as f32,
    // rust: *y as f32,
    // rust: *w as f32,
    // rust: *h as f32,
    // rust: crate::hud_layout::abgr(*color as u32),
    // rust: ),
    // rust: Draw::Blit {
    // rust: texture,
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: u,
    // rust: v,
    // rust: src,
    // rust: tex,
    // rust: color,
    // rust: } => {
    // rust: let key = texture
    // rust: .trim_start_matches("textures/")
    // rust: .trim_end_matches(".png");
    // rust: let key = if atlas.sprites.contains_key(key) {
    // rust: key
    // rust: } else {
    // rust: "misc/unknown_pack"
}
    // rust: let color = crate::hud_layout::abgr(*color as u32);
    // rust: if src[0] == tex[0] && src[1] == tex[1]
    // rust: || (*u == 0.0 && *v == 0.0 && src[0] <= tex[0] && src[1] <= tex[1])
    // rust: {
    // rust: if let Some(mut r) = atlas.sprites.get(key).copied() {
    // rust: let (du, dv) = (r.u1 - r.u0, r.v1 - r.v0);
    // rust: r.u1 = r.u0 + du * src[0] as f32 / tex[0] as f32;
    // rust: r.v1 = r.v0 + dv * src[1] as f32 / tex[1] as f32;
    // rust: batch.rect_uv(*x as f32, *y as f32, *w as f32, *h as f32, r, color);
}
    // rust: } else {
    // rust: crate::ui::tiled(
    // rust: batch,
    // rust: atlas,
    // rust: key,
    // rust: *x as f32,
    // rust: *y as f32,
    // rust: *w as f32,
    // rust: *h as f32,
    // rust: tex[0] as f32,
    // rust: color,
    // rust: );
}
}
    // rust: Draw::Fill {
    // rust: x0,
    // rust: y0,
    // rust: x1,
    // rust: y1,
    // rust: color,
    // rust: } => batch.fill(
    // rust: atlas,
    // rust: *x0 as f32,
    // rust: *y0 as f32,
    // rust: (x1 - x0) as f32,
    // rust: (y1 - y0) as f32,
    // rust: crate::hud_layout::abgr(*color as u32),
    // rust: ),
    // rust: Draw::Highlight { x0, y0, x1, y1 } => {
    // rust: let (a, b) = ((*x0).min(*x1), (*x0).max(*x1));
    // rust: batch.text_highlight(
    // rust: atlas,
    // rust: (a as f32, *y0 as f32, (b - a) as f32, (y1 - y0) as f32),
    // rust: true,
    // rust: );
}
    // rust: Draw::Text {
    // rust: text,
    // rust: x,
    // rust: y,
    // rust: color,
    // rust: shadow,
    // rust: } => {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: text,
    // rust: *x as f32,
    // rust: *y as f32,
    // rust: crate::hud_layout::abgr(*color as u32),
    // rust: *shadow,
    // rust: );
}
    // rust: Draw::Scissor { x0, y0, x1, y1 } => {
    // rust: clip = Some((batch.vertices.len(), [*x0, *y0, *x1, *y1]))
}
    // rust: Draw::NoScissor => {
    // rust: if let Some((start, [x0, y0, x1, y1])) = clip.take() {
    // rust: batch.clip_since(start, x0 as f32, y0 as f32, x1 as f32, y1 as f32);
}
}
    // rust: Draw::Tooltip { lines, x, y } => {
    // rust: tooltip = Some((lines.clone(), (*x as f32, *y as f32)))
}
}
}
    // rust: if let Some((lines, at)) = tooltip {
    // rust: crate::ui::tooltip(batch, atlas, &lines, at);
}
}

    // rust: mod button_label_tests {
//     use super::*;

atlas :: proc() -> H {
    // Ported from Horizon
    return {}
}
    // rust: HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap()
}
    // A label made of `n` copies of one letter.
label :: proc(n: uint) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal("W".repeat(n))
}
    // The calls of one button: its sprite, then (the scissor,) the label.
draw :: proc(m: ^Measure, text: ^Text, w: i32, now_ms: i64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: button(&mut out, m, text, 10, 20, w, 20, true, false, now_ms);
    // rust: out
}
scissor_of :: proc(draws: ^[Draw]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: draws.iter().find_map(|d| match d {
    // rust: Draw::Scissor { x0, y0, x1, y1 } => Some([*x0, *y0, *x1, *y1]),
    // rust: _ => None,
    // rust: })
}
text_x :: proc(draws: ^[Draw]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: draws
    // rust: .iter()
    // rust: .find_map(|d| match d {
    // rust: Draw::Text { x, .. } => Some(*x),
    // rust: _ => None,
    // rust: })
    // rust: .expect("the label is drawn")
}
    // A button `overflow` px too narrow for `text`, whatever the font.
width_overflowing_by :: proc(m: ^Measure, text: ^Text, overflow: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: m.width(text) - overflow + 4
}

    // `defaultScrollingHelper`: `pos` runs from the far end (`maxPosition`, at
    // time 0) to 0 at half the period (`max(maxPosition * 0.5, 3)` seconds)
    // and back, with `maxPosition / 2` a quarter of the way.
the_offset_follows_the_vanilla_period_and_easing :: proc() {
}
        // 8 px over: a 4 s period. At 3 s the cosine is a hair below 0, so
        // `pos` is a hair below 4 and the `(int)` cast truncates it to 3.
    // rust: let at = |ms| scroll_offset(8, ms);
    // rust: assert_eq!(
    // rust: [at(0), at(1000), at(2000), at(3000), at(4000)],
    // rust: [8, 4, 0, 3, 8]
    // rust: );
        // 1 px over: the 3 s minimum period, so 1.5 s is the other end.
    // rust: assert_eq!([scroll_offset(1, 0), scroll_offset(1, 1500)], [1, 0]);
        // 40 px over: a 20 s period.
    // rust: assert_eq!(
    // rust: [
    // rust: scroll_offset(40, 0),
    // rust: scroll_offset(40, 5000),
    // rust: scroll_offset(40, 10000),
    // rust: scroll_offset(40, 20000)
    // rust: ],
    // rust: [40, 20, 0, 40]
    // rust: );
        // It never leaves [0, maxPosition], and the minimum period is 3 s even
        // for a tiny overflow.
    // rust: for max in 1..200 {
    // rust: for ms in (0..60_000).step_by(37) {
    // rust: let pos = scroll_offset(max, ms);
    // rust: assert!((0..=max).contains(&pos), "{max} {ms} {pos}");
}
}
    // rust: assert_eq!(scroll_offset(2, 1500), 0);
        // tools/test_pack_screen_parity.py runs vanilla's own
        // `defaultScrollingHelper` at fixed clocks for the scrolling labels.
}

    // The bug: a label wider than the button panicked in `i32::clamp`. Now it
    // is left-aligned, clipped to the button's contents and slides with the
    // clock, and every pixel of it stays inside that box.
a_label_wider_than_its_button_scrolls_inside_its_box :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let m = Measure(&atlas.font);
    // rust: let text = label(24);
    // rust: let w = width_overflowing_by(&m, &text, 8);
    // rust: let (left, right) = (10 + 2, 10 + w - 2);
    // rust: for (ms, x) in [(0, left - 8), (1000, left - 4), (2000, left)] {
    // rust: let draws = draw(&m, &text, w, ms);
    // rust: assert_eq!(scissor_of(&draws), Some([left, 20, right, 40]), "{ms}");
    // rust: assert_eq!(text_x(&draws), x, "{ms}");
            // The scissor wraps the text and nothing else.
    // rust: assert!(matches!(draws[1], Draw::Scissor { .. }));
    // rust: assert!(matches!(draws[2], Draw::Text { .. }));
    // rust: assert_eq!(draws[3], Draw::NoScissor);
    // rust: assert_eq!(draws.len(), 4);
            // Painted, no vertex of the label leaves the box.
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: paint(&mut batch, &atlas, &draws[1..]);
    // rust: assert!(!batch.vertices.is_empty());
    // rust: for v in &batch.vertices {
    // rust: assert!(
    // rust: (left as f32..=right as f32).contains(&v.pos[0])
    // rust: && (20.0..=40.0).contains(&v.pos[1]),
    // rust: "{ms}: {:?}",
    // rust: v.pos
    // rust: );
}
}
}

    // A label as wide as the room is centred as before and takes no scissor;
    // one pixel more scrolls.
the_scroll_starts_one_pixel_past_the_room :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let m = Measure(&atlas.font);
    // rust: let text = label(10);
    // rust: let lw = m.width(&text);
    // rust: let fits = draw(&m, &text, lw + 4, 0);
    // rust: assert_eq!(scissor_of(&fits), None);
    // rust: assert_eq!(text_x(&fits), 10 + 2);
    // rust: assert_eq!(fits.len(), 2);
    // rust: let over = draw(&m, &text, lw + 3, 0);
    // rust: assert_eq!(scissor_of(&over), Some([12, 20, 10 + lw + 3 - 2, 40]));
        // maxPosition 1: the far end at time 0, the near one 1.5 s later.
    // rust: assert_eq!(text_x(&over), 12 - 1);
    // rust: assert_eq!(text_x(&draw(&m, &text, lw + 3, 1500)), 12);
}

    // A label that fits stays where it was: centred on the button.
a_label_that_fits_is_centred :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let m = Measure(&atlas.font);
    // rust: let text = label(6);
    // rust: let lw = m.width(&text);
    // rust: for w in [lw + 5, lw + 6, 150, 200] {
    // rust: let draws = draw(&m, &text, w, 12345);
    // rust: assert_eq!(scissor_of(&draws), None);
    // rust: let (left, right) = (10 + 2, 10 + w - 2);
    // rust: assert_eq!(text_x(&draws), (left + right) / 2 - lw / 2, "{w}");
}
}

    // An empty label, and a button too narrow to hold anything (a 1-px one
    // has a negative room), neither panic nor draw outside it.
empty_labels_and_tiny_buttons_do_not_panic :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let m = Measure(&atlas.font);
    // rust: for text in [Text::empty(), label(1), label(30)] {
    // rust: for w in [-5, 0, 1, 2, 3, 4, 5, 150] {
    // rust: for ms in [0, 1, 1499, 1500, 123_456_789] {
    // rust: let draws = draw(&m, &text, w, ms);
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: paint(&mut batch, &atlas, &draws);
    // rust: if let Some([x0, _, x1, _]) = scissor_of(&draws) {
                        // Whatever scrolled is clipped to the (maybe empty) box.
    // rust: for v in batch.vertices.iter().skip(sprite_vertices(&atlas, w)) {
    // rust: assert!(
    // rust: x1 <= x0 || (x0 as f32..=x1 as f32).contains(&v.pos[0]),
    // rust: "{w} {ms}: {:?}",
    // rust: v.pos
    // rust: );
}
}
}
}
}
        // 4 px wide leaves no room: an empty label fits it (0 <= 0).
    // rust: assert_eq!(scissor_of(&draw(&m, &Text::empty(), 4, 0)), None);
        // 1 px wide: the room is -3 px, even an empty label overflows it.
    // rust: assert!(scissor_of(&draw(&m, &Text::empty(), 1, 0)).is_some());
}

    // The vertices of the button's sprite alone.
sprite_vertices :: proc(atlas: ^HudAtlas, w: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: let mut out = Vec::new();
    // rust: sprite(&mut out, "widget/button", 10, 20, w, 20);
    // rust: paint(&mut batch, atlas, &out);
    // rust: batch.vertices.len()
}
}
