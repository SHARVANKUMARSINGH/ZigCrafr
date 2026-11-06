//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_settings_shell
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What Horizon's searchable settings screens share (`graphics_ui`, `controller_ui`): the frame's
//! geometry, its list of pages, groups and rows, and how the keyboard moves through them. Which
//! settings a screen has, and what they do, stay in that screen; the look comes from
//! `graphics_style`.
// use crate::{
    // rust: graphics_style as style,
    // rust: hud::{HudAtlas, HudBatch},
    // rust: lang,
    // rust: text::Text,
    // rust: ui,
}

/// The screen's parts in GUI pixels. Down the left: the mark, the search
/// field, the page list, and Undo and Done at the foot. On the right: the
/// plate with the open page's name and its list, and the strip under it that
/// describes the hovered setting. `list_x`, `list_w`, `top` and `bottom` are
/// the list's view.
    // rust: pub(crate) struct Columns {
    // rust: pub(crate) side_x: f32,
    // rust: pub(crate) side_y: f32,
    // rust: pub(crate) plate: [f32; 4],
    // rust: pub(crate) dock: [f32; 4],
    // rust: pub(crate) list_x: f32,
    // rust: pub(crate) list_w: f32,
    // rust: pub(crate) top: f32,
    // rust: pub(crate) bottom: f32,
}
    // rust: impl Columns {
    // rust: pub(crate) fn of(w: f32, h: f32) -> Self {
    // rust: let side_w = style::CONTROL_W;
    // rust: let gap = if w >= 560.0 { 16.0 } else { 8.0 };
    // rust: let pw = (w - 16.0 - side_w - gap).min(432.0).floor();
    // rust: let side_x = ((w - side_w - gap - pw) / 2.0).floor();
    // rust: let px = side_x + side_w + gap;
        // A short screen (a 720p window at scale 3) gives the margin to the list.
    // rust: let side_y = if h >= style::TITLED { 24.0 } else { 8.0 };
    // rust: let dock = [px, h - 8.0 - style::DOCK_H, pw, style::DOCK_H];
    // rust: let plate = [px, side_y, pw, dock[1] - 4.0 - side_y];
    // rust: let list_x = px + 8.0;
    // rust: Self {
    // rust: side_x,
    // rust: side_y,
    // rust: plate,
    // rust: dock,
    // rust: list_x,
    // rust: list_w: pw - 16.0 - style::SCROLLER_W - 2.0,
    // rust: top: side_y + 30.0,
    // rust: bottom: plate[1] + plate[3] - 6.0,
}
}
    /// The search field, under the mark.
    // rust: pub(crate) fn search(&self) -> [f32; 4] {
    // rust: [
    // rust: self.side_x,
    // rust: self.side_y + 26.0,
    // rust: style::CONTROL_W,
    // rust: style::SEARCH_H,
    // rust: ]
}
    /// The search field's clear button, at its right end.
    // rust: pub(crate) fn clear(&self) -> [f32; 4] {
    // rust: let [x, y, w, h] = self.search();
    // rust: [x + w - h, y, h, h]
}
    /// Room for vanilla's scroller, whose thumb is 32 high and 8 short of its track.
    // rust: pub(crate) fn scrolls(&self) -> bool {
    // rust: self.bottom - self.top >= 40.0
}
    // rust: pub(crate) fn bar_x(&self) -> f32 {
    // rust: self.plate[0] + self.plate[2] - 8.0 - style::SCROLLER_W
}
    /// A page in the page list, under the search field.
    // rust: pub(crate) fn page(&self, i: usize) -> [f32; 4] {
    // rust: [
    // rust: self.side_x,
    // rust: self.side_y + 56.0 + i as f32 * 18.0,
    // rust: style::CONTROL_W,
    // rust: 16.0,
    // rust: ]
}
    /// Done (`0`), and Undo over it (`1`): under the page list, level with the strip.
    // rust: pub(crate) fn button(&self, i: usize) -> [f32; 4] {
    // rust: let foot = self.dock[1] + self.dock[3] - style::BUTTON_H;
    // rust: let y = if i == 0 {
    // rust: foot
    // rust: } else {
    // rust: foot - 4.0 - style::BUTTON_H
}
    // rust: [self.side_x, y, style::CONTROL_W, style::BUTTON_H]
}
    /// A row's control column: its button, tick box or slider.
    // rust: pub(crate) fn track(&self) -> (f32, f32) {
    // rust: let x = self.list_x + self.list_w - style::INSET - style::CONTROL_W;
    // rust: (x, style::CONTROL_W)
}
    /// A slider's value for the pointer at `x`: the handle's middle follows it.
    // rust: pub(crate) fn slider_at(&self, x: f32) -> f32 {
    // rust: let (tx, tw) = self.track();
    // rust: ((x - tx - 5.0) / (tw - 10.0)).clamp(0.0, 1.0)
}
    /// A row's whole width at `y`.
    // rust: pub(crate) fn row(&self, y: f32) -> [f32; 4] {
    // rust: [self.list_x, y, self.list_w, style::ROW]
}
}

/// A line of the list at `y` in its content: a page's name (only while
/// searching, which shows every page), a group's name with the height of the
/// panel its rows sit on, or a setting.
    // rust: pub(crate) struct Line<P, S> {
    // rust: pub(crate) y: f32,
    // rust: pub(crate) page: P,
    // rust: pub(crate) group: Option<(&'static str, f32)>,
    // rust: pub(crate) setting: Option<S>,
}
    // rust: impl<P, S> Line<P, S> {
    // rust: pub(crate) fn h(&self) -> f32 {
    // rust: match (&self.setting, self.group) {
    // rust: (Some(_), _) => style::ROW,
    // rust: (None, Some(_)) => style::GROUP_ROW,
    // rust: (None, None) => style::PAGE_ROW,
}
}
}

/// Lays lines out from the top.
    // rust: pub(crate) struct Lines<P, S> {
    // rust: lines: Vec<Line<P, S>>,
    // rust: y: f32,
}
    // rust: impl<P: Copy, S: Copy> Lines<P, S> {
    // rust: pub(crate) fn new() -> Self {
    // rust: Self {
    // rust: lines: Vec::new(),
    // rust: y: 0.0,
}
}
    /// A page's name over its matches, while searching.
    // rust: pub(crate) fn page(&mut self, page: P) {
    // rust: if !self.lines.is_empty() {
    // rust: self.y += style::PAGE_GAP;
}
    // rust: self.lines.push(Line {
    // rust: y: self.y,
    // rust: page,
    // rust: group: None,
    // rust: setting: None,
    // rust: });
    // rust: self.y += style::PAGE_ROW;
}
    /// A named group of rows.
    // rust: pub(crate) fn group(&mut self, page: P, name: &'static str, rows: Vec<S>) {
    // rust: self.lines.push(Line {
    // rust: y: self.y,
    // rust: page,
    // rust: group: Some((name, rows.len() as f32 * style::ROW)),
    // rust: setting: None,
    // rust: });
    // rust: self.y += style::GROUP_ROW;
    // rust: for setting in rows {
    // rust: self.lines.push(Line {
    // rust: y: self.y,
    // rust: page,
    // rust: group: None,
    // rust: setting: Some(setting),
    // rust: });
    // rust: self.y += style::ROW;
}
    // rust: self.y += style::GROUP_GAP;
}
    /// The lines and the content's height.
    // rust: pub(crate) fn finish(self) -> (Vec<Line<P, S>>, f32) {
    // rust: (self.lines, (self.y - style::GROUP_GAP).max(0.0))
}
}

/// The world or the menu's background, veiled.
    // rust: pub(crate) fn backdrop(batch: &mut HudBatch, atlas: &HudAtlas, in_world: bool) {
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, in_world);
    // rust: style::fill(batch, atlas, [0.0, 0.0, w, h], style::VEIL);
}

/// The mark and the screen's name over the search field.
    // rust: pub(crate) fn mark(batch: &mut HudBatch, atlas: &HudAtlas, cols: &Columns, title: &str) {
    // rust: let (x, y) = (cols.side_x, cols.side_y);
    // rust: style::fill(batch, atlas, [x, y + 2.0, 6.0, 6.0], style::ACCENT);
    // rust: let horizon = Text::literal("Horizon");
    // rust: batch.text_styled(atlas, &horizon, x + 10.0, y, style::WHITE, true);
    // rust: let title = Text::literal(title);
    // rust: batch.text_styled(atlas, &title, x, y + 10.0, style::MUTED, true);
}

/// A page in the page list: the open page on a plate with the accent's bar beside it, the
/// others bare text. `has`: something to show under it.
    // rust: pub(crate) fn page_tab(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: rect: [f32; 4],
    // rust: name: &str,
    // rust: (has, open, focused): (bool, bool, bool),
    // rust: cursor: (f32, f32),
    // rust: ) {
    // rust: let [px, py, pw, ph] = rect;
    // rust: crate::widgets::record(name, rect, has);
    // rust: let hover = has && ui::hovered(cursor, px, py, pw, ph);
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::button(name.to_owned(), rect, has)
    // rust: .hovered(hover)
    // rust: .focused(focused)
    // rust: });
    // rust: crate::widgets::widget_cursor(hover, has);
    // rust: if has {
    // rust: crate::widgets::target_as(rect, crate::widgets::Kind::Tab(open));
}
    // rust: if open {
    // rust: style::fill(batch, atlas, rect, style::OPEN);
    // rust: style::fill(batch, atlas, [px, py, 2.0, ph], style::ACCENT);
}
    // rust: let color = match (open || hover, has) {
    // rust: (true, _) => style::WHITE,
    // rust: (false, true) => style::SOFT,
    // rust: (false, false) => style::MUTED,
}
    // rust: let ty = py + ((ph - 8.0) / 2.0).floor();
    // rust: let name = Text::literal(style::fit(atlas, name, pw - 12.0));
    // rust: batch.text_styled(atlas, &name, px + 8.0, ty, color, true);
    // rust: if focused {
    // rust: style::ring(batch, atlas, rect, style::WHITE);
}
}

/// The search field, with its hint or clear button.
    // rust: pub(crate) fn search_field(
    // rust: search: &mut ui::EditBox,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cols: &Columns,
    // rust: cursor: (f32, f32),
    // rust: focused: bool,
    // rust: ) {
    // rust: let rect = cols.search();
    // rust: style::well(batch, atlas, rect);
    // rust: search.focused = focused;
    // rust: let [x, y, _, h] = rect;
    // rust: let clear = cols.clear();
    // rust: (search.x, search.y) = (x + 5.0, y + ((h - 8.0) / 2.0).floor());
    // rust: search.width = clear[0] - search.x;
    // rust: search.text_color = style::WHITE;
    // The clear button isn't the field's: a click at the field's end must not press it.
    // rust: let frame = [x, y, clear[0] - x, h];
    // rust: search.frame = Some(frame);
    // rust: search.draw(batch, atlas, None);
    // rust: if search.value.is_empty() && !focused {
    // rust: let hint = Text::literal(search.message.clone());
    // rust: batch.text_styled(atlas, &hint, x + 5.0, search.y, style::MUTED, true);
}
    // rust: if !search.value.is_empty() {
    // rust: let hover = ui::hovered(cursor, clear[0], clear[1], clear[2], clear[3]);
    // rust: crate::widgets::widget_cursor(hover, true);
    // rust: let color = if hover { style::WHITE } else { style::MUTED };
    // rust: let cy = y + ((h - 8.0) / 2.0).floor();
    // rust: ui::centered_text(
    // rust: batch,
    // rust: atlas,
    // rust: &Text::literal("×"),
    // rust: clear[0],
    // rust: cy,
    // rust: clear[2],
    // rust: color,
    // rust: );
}
    // rust: if focused {
    // rust: style::ring(batch, atlas, frame, style::WHITE);
}
}

/// The plate, with the open page's name (or the search's) over its list.
    // rust: pub(crate) fn plate(batch: &mut HudBatch, atlas: &HudAtlas, cols: &Columns, heading: &str) {
    // rust: let [px, py, pw, _] = cols.plate;
    // rust: style::panel(batch, atlas, cols.plate);
    // rust: let heading = Text::literal(style::fit(atlas, heading, pw - 24.0));
    // rust: batch.text_styled(atlas, &heading, px + 12.0, py + 10.0, style::WHITE, true);
    // rust: style::fill(
    // rust: batch,
    // rust: atlas,
    // rust: [px + 8.0, py + 24.0, pw - 16.0, 1.0],
    // rust: style::HEAD_RULE,
    // rust: );
}

/// The list, clipped to its view: each group's panel, then its names and rows on it. `row`
/// draws a setting at its `y`.
    // rust: pub(crate) fn list<P: Copy, S: Copy>(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cols: &Columns,
    // rust: lines: &[Line<P, S>],
    // rust: scroll: f32,
    // rust: page_name: impl Fn(P) -> &'static str,
    // rust: mut row: impl FnMut(&mut HudBatch, S, f32),
    // rust: ) {
    // rust: let start = batch.vertices.len();
    // rust: let mark = crate::widgets::targets_mark();
    // rust: let row_y = |line: &Line<P, S>| cols.top + line.y - scroll;
    // rust: let shows = |y: f32, h: f32| y + h > cols.top && y < cols.bottom;
    // rust: for line in lines {
    // rust: let y = row_y(line);
    // rust: if let Some((_, panel)) = line.group
    // rust: && shows(y + style::GROUP_ROW, panel)
    // rust: {
    // rust: let rect = [cols.list_x, y + style::GROUP_ROW, cols.list_w, panel];
    // rust: style::group(batch, atlas, rect);
}
}
    // A group's first row, which has no rule over it.
    // rust: let mut first = false;
    // rust: for line in lines {
    // rust: let y = row_y(line);
    // rust: let after_name = std::mem::replace(&mut first, line.group.is_some());
    // rust: if !shows(y, line.h()) {
    // rust: continue;
}
    // rust: let Some(setting) = line.setting else {
    // rust: let (name, color, dy) = match line.group {
    // rust: Some((name, _)) => (name, style::MUTED, 3.0),
    // rust: None => (page_name(line.page), style::ACCENT, 4.0),
}
    // rust: let name = Text::literal(lang::get(name));
    // rust: batch.text_styled(atlas, &name, cols.list_x + 2.0, y + dy, color, true);
    // rust: continue;
}
    // rust: if !after_name {
    // rust: let rule = [cols.list_x + 8.0, y, cols.list_w - 16.0, 1.0];
    // rust: style::fill(batch, atlas, rule, style::ROW_RULE);
}
    // rust: row(batch, setting, y);
}
    // rust: if lines.is_empty() {
    // rust: let none = Text::literal(lang::get("No settings match."));
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &none,
    // rust: cols.list_x + 2.0,
    // rust: cols.top + 4.0,
    // rust: style::MUTED,
    // rust: true,
    // rust: );
}
    // rust: batch.clip_since(
    // rust: start,
    // rust: cols.list_x,
    // rust: cols.top,
    // rust: cols.list_x + cols.list_w,
    // rust: cols.bottom,
    // rust: );
    // rust: crate::widgets::clip_targets(mark, cols.top, cols.bottom);
}

/// A control's label as its name and its value ("Render Distance" and "12 chunks").
    // rust: pub(crate) fn name_and_value(label: &str) -> (String, Option<String>) {
    // `options.generic_value` ("%s: %s") joins vanilla's; Horizon's use ": " too.
    // rust: let format = lang::get("options.generic_value");
    // rust: let sep = format
    // rust: .split("%s")
    // rust: .nth(1)
    // rust: .filter(|sep| !sep.is_empty() && label.contains(*sep))
    // rust: .unwrap_or(": ");
    // rust: match label.split_once(sep) {
    // rust: Some((name, value)) => (name.to_owned(), Some(value.to_owned())),
    // rust: None => (label.to_owned(), None),
}
}

/// A slider's position one step on: a step of its own, or a pixel of its `width` wide track.
    // rust: pub(crate) fn slider_step(pos: f32, steps: Option<u32>, width: f32, forward: bool) -> f32 {
    // rust: if let Some(steps) = steps {
    // rust: let steps = steps as f32;
    // rust: let current = (pos * steps).round();
    // rust: let next = if forward {
    // rust: current + 1.0
    // rust: } else {
    // rust: current - 1.0
}
    // rust: (next / steps).clamp(0.0, 1.0)
    // rust: } else {
    // rust: let delta = 1.0 / (width - 8.0).max(1.0);
    // rust: if forward {
    // rust: (pos + delta).min(1.0)
    // rust: } else {
    // rust: (pos - delta).max(0.0)
}
}
}

/// A setting's row as the screen reads it.
    // rust: pub(crate) struct RowView<'a> {
    /// The whole caption ("Render Distance: 12 chunks"), for the narrator.
    // rust: pub(crate) label: &'a str,
    // rust: pub(crate) name: &'a str,
    // rust: pub(crate) value: Option<&'a str>,
    // rust: pub(crate) switch: Option<bool>,
    // rust: pub(crate) slider: Option<f32>,
    /// Can be used now.
    // rust: pub(crate) live: bool,
    // rust: pub(crate) hover: bool,
    // rust: pub(crate) focused: bool,
    /// Its slider is being dragged.
    // rust: pub(crate) held: bool,
}

/// A setting's row at `y`, its name on the left and its control on the right.
    // rust: pub(crate) fn row(batch: &mut HudBatch, atlas: &HudAtlas, cols: &Columns, y: f32, view: &RowView) {
    // rust: let &RowView {
    // rust: label,
    // rust: name,
    // rust: value,
    // rust: switch,
    // rust: slider,
    // rust: live,
    // rust: hover,
    // rust: focused,
    // rust: held,
    // rust: } = view;
    // rust: let rect = cols.row(y);
    // rust: let (tx, tw) = cols.track();
    // rust: let right = tx + tw;
    // rust: let control = [
    // rust: tx,
    // rust: y + (style::ROW - style::CONTROL_H) / 2.0,
    // rust: tw,
    // rust: style::CONTROL_H,
    // rust: ];
    // rust: let active = live && (hover || focused || held);
    // rust: if active {
    // rust: let lit = [rect[0] + 2.0, y + 1.0, rect[2] - 4.0, style::ROW - 2.0];
    // rust: style::fill(batch, atlas, lit, style::HOVER);
}
    // rust: crate::widgets::widget_cursor(hover, live);
    // The control socket's widget tree, the narrator and a controller's focus.
    // rust: let kind = match slider {
    // rust: Some(value) => crate::widgets::Kind::Slider {
    // rust: value,
    // rust: track: [tx + 5.0, tw - 10.0],
    // rust: },
    // rust: None => crate::widgets::Kind::Button,
}
    // rust: crate::widgets::record_as(label, rect, live, kind);
    // rust: crate::widgets::narratable(|| {
    // rust: match (switch, slider) {
    // rust: (Some(on), _) => crate::widgets::Narratable::checkbox(name.to_owned(), on, rect, live),
    // rust: (_, Some(_)) => crate::widgets::Narratable::slider(label.to_owned(), rect, live),
    // rust: _ => crate::widgets::Narratable::button(label.to_owned(), rect, live),
}
    // rust: .hovered(hover)
    // rust: .focused(focused)
    // rust: });
    // rust: if live {
    // rust: crate::widgets::target_as(rect, kind);
}
    // rust: let color = if live { style::WHITE } else { style::MUTED };
    // rust: let soft = if live { style::SOFT } else { style::MUTED };
    // rust: let ty = y + ((style::ROW - 8.0) / 2.0).floor();
    // rust: let lit = live && (hover || held);
    // rust: let left = rect[0] + style::INSET;
    // An action (Calibrate...) is a button across the row, as vanilla's lists have them.
    // rust: if switch.is_none() && slider.is_none() && value.is_none() {
    // rust: let wide = [left, control[1], right - left, style::CONTROL_H];
    // rust: style::button(batch, atlas, wide, &Text::literal(name), (lit, live, false));
    // rust: } else {
    // rust: let value = value.unwrap_or_default();
    // rust: let vw = atlas.font.width(value);
        // Where the control starts, and the value's text for a slider at rest.
    // rust: let start = match (switch, slider) {
    // rust: (Some(_), _) => right - style::CONTROL_H,
    // rust: (None, Some(_)) if active => tx,
    // rust: (None, Some(_)) => right - vw,
    // rust: (None, None) => right - vw - 18.0,
}
    // rust: match (switch, slider) {
    // rust: (Some(on), _) => style::checkbox(batch, atlas, right, y, on, live),
            // A slider shows its track, the value on it, while it is pointed at, focused or held.
    // rust: (None, Some(position)) => {
    // rust: let value = Text::literal(value);
    // rust: if active {
    // rust: style::slider(batch, atlas, control, &value, position, (lit, live));
    // rust: } else {
    // rust: batch.text_styled(atlas, &value, start, ty, soft, true);
}
}
    // rust: (None, None) => {
    // rust: let value = Text::literal(value);
    // rust: style::cycler(
    // rust: batch,
    // rust: atlas,
    // rust: [start, y + 3.0, vw + 18.0, 14.0],
    // rust: &value,
    // rust: (lit, live),
    // rust: );
}
}
        // The name, cut short before the control where a translation runs long.
    // rust: let shown = Text::literal(style::fit(atlas, name, start - 6.0 - left));
    // rust: batch.text_styled(atlas, &shown, left, ty, color, true);
}
    // rust: if focused {
    // rust: style::ring(
    // rust: batch,
    // rust: atlas,
    // rust: [rect[0] + 1.0, y, rect[2] - 2.0, style::ROW],
    // rust: style::WHITE,
    // rust: );
}
}

/// Vanilla's scroller, inside the panel's right edge, sized as `ui::Scroll` drags it.
    // rust: pub(crate) fn scroller(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cols: &Columns,
    // rust: content: f32,
    // rust: scroll: f32,
    // rust: ) {
    // rust: if !cols.scrolls() {
    // rust: return;
}
    // rust: let Some((y, bar)) = ui::scrollbar_thumb(cols.top, cols.bottom, content, scroll) else {
    // rust: return;
}
    // rust: let x = cols.bar_x();
    // rust: let height = cols.bottom - cols.top;
    // rust: crate::widgets::scroll_area(
    // rust: [
    // rust: cols.list_x,
    // rust: cols.top,
    // rust: x + style::SCROLLER_W - cols.list_x,
    // rust: height,
    // rust: ],
    // rust: scroll,
    // rust: content - height,
    // rust: );
    // rust: let track = [x, cols.top, style::SCROLLER_W, height];
    // rust: style::scroller(batch, atlas, track, [x, y, style::SCROLLER_W, bar]);
}

/// The strip's text under its first line.
    // rust: pub(crate) fn dock_note(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cols: &Columns,
    // rust: text: String,
    // rust: color: u32,
    // rust: ) {
    // rust: let [x, y, w, _] = cols.dock;
    // rust: let lines = atlas.font.split(&Text::literal(text), w - 24.0);
    // rust: for (i, line) in lines.iter().take(2).enumerate() {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: line,
    // rust: x + 12.0,
    // rust: y + 20.0 + i as f32 * 10.0,
    // rust: color,
    // rust: true,
    // rust: );
}
}

/// Done or Undo at the foot of the page list.
    // rust: pub(crate) fn foot_button(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: rect: [f32; 4],
    // rust: label: &Text,
    // rust: cursor: (f32, f32),
    // rust: (focused, primary): (bool, bool),
    // rust: ) {
    // rust: let [x, y, w, h] = rect;
    // rust: let hovered = ui::hovered(cursor, x, y, w, h);
    // rust: let hover = hovered || focused;
    // rust: crate::widgets::record(&label.plain(), rect, true);
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::button(label.plain(), rect, true)
    // rust: .hovered(hovered)
    // rust: .focused(focused)
    // rust: });
    // rust: crate::widgets::widget_cursor(hovered, true);
    // rust: crate::widgets::target(rect);
    // rust: style::button(batch, atlas, rect, label, (hover, true, primary));
}

/// Of the rows (their target, `y` and whether they can take the focus), those the keys reach.
/// Tab reaches all. The arrows (`near`) only reach the rows in view and the next live one past
/// either edge, which scrolls in, over any greyed ones: a row farther out sits under the tabs or
/// the buttons and would take the step from them.
    // rust: pub(crate) fn reach<T>(
    // rust: rows: &[(T, f32, bool)],
    // rust: cols: &Columns,
    // rust: near: bool,
    // rust: ) -> std::ops::Range<usize> {
    // rust: let in_view = |y: f32| y + style::ROW > cols.top && y < cols.bottom;
    // rust: match rows.iter().position(|r| in_view(r.1)) {
    // rust: Some(first) if near => {
    // rust: let last = rows.iter().rposition(|r| in_view(r.1)).unwrap_or(first);
    // rust: let lo = rows[..first].iter().rposition(|r| r.2).unwrap_or(first);
    // rust: let hi = rows[last + 1..]
    // rust: .iter()
    // rust: .position(|r| r.2)
    // rust: .map_or(last, |i| last + 1 + i);
    // rust: lo..hi + 1
}
    // rust: None if near => 0..0,
    // rust: _ => 0..rows.len(),
}
}

/// Where Tab or Shift+Tab goes among `n` controls.
    // rust: pub(crate) fn tab_step(n: usize, current: Option<usize>, shift: bool) -> usize {
    // rust: match (current, shift) {
    // rust: (Some(i), false) => (i + 1) % n,
    // rust: (Some(i), true) => (i + n - 1) % n,
    // rust: (None, false) => 0,
    // rust: (None, true) => n - 1,
}
}

/// Where an arrow key goes among the controls. Nothing focused in view: going down, the first
/// setting from the view's top on (the next past its bottom where greyed rows fill it); going
/// up, the last one down to its bottom. `is_row`: a control that is a setting's row.
    // rust: pub(crate) fn arrow_step<T: Copy>(
    // rust: controls: &[(T, [f32; 4])],
    // rust: current: Option<usize>,
    // rust: key: winit::keyboard::KeyCode,
    // rust: cols: &Columns,
    // rust: is_row: impl Fn(T) -> bool,
    // rust: ) -> Option<usize> {
//     use crate::gamepad::Button as B;
//     use winit::keyboard::KeyCode as K;
    // rust: let dir = match key {
    // rust: K::ArrowUp => B::DPadUp,
    // rust: K::ArrowDown => B::DPadDown,
    // rust: K::ArrowLeft => B::DPadLeft,
    // rust: _ => B::DPadRight,
}
    // rust: match current {
    // rust: Some(i) => {
    // rust: let rects: Vec<[f32; 4]> = controls.iter().map(|f| f.1).collect();
    // rust: crate::gamepad::focus_step_rect(controls[i].1, dir, &rects)
}
    // rust: None => {
    // rust: let mut rows = controls.iter().enumerate().filter(|(_, (t, _))| is_row(*t));
    // rust: let pick = if key == K::ArrowUp {
    // rust: rows.rfind(|(_, (_, [_, y, ..]))| *y + style::ROW <= cols.bottom)
    // rust: } else {
    // rust: rows.find(|(_, (_, [_, y, ..]))| *y >= cols.top)
}
    // rust: pick.map(|(i, _)| i)
}
}
}

/// Scroll just enough to bring a row at `rect` into the list's view.
    // rust: pub(crate) fn scroll_into_view(
    // rust: scroll: &mut ui::Scroll,
    // rust: [_, y, _, h]: [f32; 4],
    // rust: cols: &Columns,
    // rust: content: f32,
    // rust: ) {
    // rust: if y < cols.top {
    // rust: scroll.amount -= cols.top - y;
    // rust: } else if y + h > cols.bottom {
    // rust: scroll.amount += y + h - cols.bottom;
}
    // rust: scroll.clamp(cols.top, cols.bottom, content);
}
