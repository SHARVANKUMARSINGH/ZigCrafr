//! Transpiled from Horizon Rust crate
//! Module: horizon-client_advancements_screen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The Advancements screen (`AdvancementsScreen`, `AdvancementTab`,
//! `AdvancementWidget`): one tab per displayed root, the tree laid out by
//! `TreeNodePosition`, dragged or scrolled inside the 252x140 window, with
//! the progress tooltip of the hovered advancement.
// use super::{Game, Screen, advancements::text_of};
// use horizon_client::{
    // rust: advancements::{Frame, Tree},
    // rust: hud::HudBatch,
    // rust: items::ItemStack,
    // rust: text::{Style, Text},
    // rust: ui,
}
// use std::{sync::Arc, time::Instant};

pub const INSIDE_W: i32 = 234;
pub const INSIDE_H: i32 = 113;
pub const FOOTER: f32 = 33.0;
/// The roots in the order the tabs appear.
    // rust: const TAB_ORDER: [&str; 5] = [
    // rust: "minecraft:story/root",
    // rust: "minecraft:nether/root",
    // rust: "minecraft:end/root",
    // rust: "minecraft:adventure/root",
    // rust: "minecraft:husbandry/root",
    // rust: ];
/// `AdvancementTabType`: (kind, width, height, max).
    // rust: const TAB_TYPES: [(Side, f32, f32, usize); 4] = [
    // rust: (Side::Above, 28.0, 32.0, 8),
    // rust: (Side::Below, 28.0, 32.0, 8),
    // rust: (Side::Left, 32.0, 28.0, 5),
    // rust: (Side::Right, 32.0, 28.0, 5),
    // rust: ];
pub const Side = enum {
    Above,
    Below,
    Left,
    Right,
};
pub fn tab_type(mut index: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for t in TAB_TYPES {
    // rust: if index < t.3 {
    // rust: return Some((t, index));
}
    // rust: index -= t.3;
}
    // rust: None
}
/// Tab position relative to the window (`getX`/`getY`).
pub fn tab_pos() void {
}
    // rust: let i = i as f32;
    // rust: match side {
    // rust: Side::Above => ((w + 4.0) * i, -h + 4.0),
    // rust: Side::Below => ((w + 4.0) * i, 136.0),
    // rust: Side::Left => (-w + 4.0, h * i),
    // rust: Side::Right => (248.0, h * i),
}
}
pub fn tab_sprite() void {
}
    // rust: let (first, middle, last) = match side {
    // rust: Side::Above => ("above_left", "above_middle", "above_right"),
    // rust: Side::Below => ("below_left", "below_middle", "below_right"),
    // rust: Side::Left => ("left_top", "left_middle", "left_bottom"),
    // rust: Side::Right => ("right_top", "right_middle", "right_bottom"),
}
    // rust: let part = if i == 0 {
    // rust: first
    // rust: } else if i == max - 1 {
    // rust: last
    // rust: } else {
    // rust: middle
}
    // rust: let sel = if selected { "_selected" } else { "" };
    // rust: format!("gui/sprites/advancements/tab_{part}{sel}")
}
pub fn icon_offset(side: Side) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match side {
    // rust: Side::Above => (6.0, 9.0),
    // rust: Side::Below => (6.0, 6.0),
    // rust: Side::Left => (10.0, 5.0),
    // rust: Side::Right => (6.0, 5.0),
}
}
pub fn frame_sprite(frame: Frame, obtained: bool) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (frame, obtained) {
    // rust: (Frame::Task, true) => "gui/sprites/advancements/task_frame_obtained",
    // rust: (Frame::Task, false) => "gui/sprites/advancements/task_frame_unobtained",
    // rust: (Frame::Goal, true) => "gui/sprites/advancements/goal_frame_obtained",
    // rust: (Frame::Goal, false) => "gui/sprites/advancements/goal_frame_unobtained",
    // rust: (Frame::Challenge, true) => "gui/sprites/advancements/challenge_frame_obtained",
    // rust: (Frame::Challenge, false) => "gui/sprites/advancements/challenge_frame_unobtained",
}
}
pub fn box_sprite(obtained: bool) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if obtained {
    // rust: "gui/sprites/advancements/box_obtained"
    // rust: } else {
    // rust: "gui/sprites/advancements/box_unobtained"
}
}
/// The layout of the loaded tree, cached per tree.
pub const Cache = struct {
    tree: *Tree,
    kids: std.ArrayList(Vec<usize)>,
    /// Widget pixel position (`x * 28`, `y * 27`).
    pos: Vec<Option<(i32,
};
    // rust: pub(super) struct AdvUi {
    // rust: cache: Option<Cache>,
    /// The selected tab's root advancement (kept between openings).
    // rust: tab: Option<usize>,
    /// Scroll of the selected tab; `None` until centred.
    // rust: scroll: Option<(f64, f64)>,
    // rust: fade: f32,
    // rust: hovered: Option<usize>,
    /// The cursor at the last drag step while the left button is down.
    // rust: drag: Option<(f32, f32)>,
    // rust: scrolling: bool,
    // rust: from_pause: bool,
    // rust: last_frame: Option<Instant>,
}
/// What the current frame shows: tabs, the visible widgets of the
/// selected one (tree order) and its bounds.
pub const View = struct {
    tabs: std.ArrayList(usize),
    widgets: std.ArrayList(usize),
    parent: std.ArrayList(?usize),
    bounds: (i32,
};
pub fn window(w: f32, h: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (((w - 252.0) / 2.0).floor(), ((h - 140.0) / 2.0).floor())
}
    // rust: impl Game<'_> {
    // rust: pub(super) fn open_advancements(&mut self, from_pause: bool) {
    // rust: self.load_advancements();
    // rust: let tab = self.adv_ui.tab;
    // rust: self.adv_ui = AdvUi {
    // rust: cache: self.adv_ui.cache.take(),
    // rust: tab,
    // rust: from_pause,
    // rust: ..Default::default()
}
    // rust: self.screen = Screen::Advancements;
    // rust: self.capture(false);
}
    // rust: pub(super) fn close_advancements(&mut self) {
    // rust: if self.adv_ui.from_pause {
    // rust: self.screen = Screen::Paused;
    // rust: } else {
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
}
pub fn adv_cache(self: *Self) void {
}
    // rust: if self
    // rust: .adv_ui
    // rust: .cache
    // rust: .as_ref()
    // rust: .is_some_and(|c| Arc::ptr_eq(&c.tree, &self.adv.tree))
    // rust: {
    // rust: return;
}
    // rust: let tree = self.adv.tree.clone();
    // rust: let kids = tree.children();
        // A server's advancements come placed (`DisplayInfo` x, y).
    // rust: let pos = match &self.adv.positions {
    // rust: Some(server) => server
    // rust: .iter()
    // rust: .map(|&(x, y)| Some(((x * 28.0).floor() as i32, (y * 27.0).floor() as i32)))
    // rust: .collect(),
    // rust: None => tree
    // rust: .layout()
    // rust: .into_iter()
    // rust: .map(|p| p.map(|(x, y)| (x * 28, (y * 27.0).floor() as i32)))
    // rust: .collect(),
}
    // rust: self.adv_ui.cache = Some(Cache { tree, kids, pos });
}
pub fn adv_done(self: *Self, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.adv.progress.done(&self.adv.tree.list[i])
}
pub fn adv_view(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.adv_cache();
    // rust: let Some(c) = self.adv_ui.cache.as_ref() else {
    // rust: return View {
    // rust: tabs: Vec::new(),
    // rust: widgets: Vec::new(),
    // rust: parent: Vec::new(),
    // rust: bounds: (0, 0, 0, 0),
}
}
    // rust: let tree = &c.tree;
        // A server sends only what the player may see.
    // rust: let visible = if self.adv.positions.is_some() {
    // rust: vec![true; tree.list.len()]
    // rust: } else {
    // rust: tree.visible(&c.kids, |i| self.adv.progress.done(&tree.list[i]))
}
        // AdvancementTab.create: a displayed root with a background.
    // rust: let mut tabs: Vec<usize> = (0..tree.list.len())
    // rust: .filter(|&i| {
    // rust: let a = &tree.list[i];
    // rust: a.parent.is_none()
    // rust: && visible[i]
    // rust: && a.display.as_ref().is_some_and(|d| d.background.is_some())
    // rust: })
    // rust: .collect();
    // rust: tabs.sort_by_key(|&i| {
    // rust: let id = &tree.list[i].id;
    // rust: (
    // rust: TAB_ORDER
    // rust: .iter()
    // rust: .position(|r| r == id)
    // rust: .unwrap_or(TAB_ORDER.len()),
    // rust: id.clone(),
    // rust: )
    // rust: });
    // rust: tabs.truncate(26);
    // rust: let tab = self
    // rust: .adv_ui
    // rust: .tab
    // rust: .filter(|t| tabs.contains(t))
    // rust: .or_else(|| tabs.first().copied());
    // rust: let mut parent = vec![None; tree.list.len()];
    // rust: let mut widgets = Vec::new();
    // rust: let mut bounds = (i32::MAX, i32::MAX, i32::MIN, i32::MIN);
    // rust: if let Some(t) = tab {
            // Tree order from the root, nearest displayed ancestor as parent.
    // rust: let mut stack = vec![(t, None::<usize>)];
    // rust: while let Some((i, up)) = stack.pop() {
    // rust: let shown = visible[i] && tree.list[i].display.is_some() && c.pos[i].is_some();
    // rust: let next = if shown {
    // rust: parent[i] = up;
    // rust: widgets.push(i);
    // rust: let (x, y) = c.pos[i].unwrap_or_default();
    // rust: bounds.0 = bounds.0.min(x);
    // rust: bounds.1 = bounds.1.min(y);
    // rust: bounds.2 = bounds.2.max(x + 28);
    // rust: bounds.3 = bounds.3.max(y + 27);
    // rust: Some(i)
    // rust: } else {
    // rust: up
}
    // rust: for &k in c.kids[i].iter().rev() {
    // rust: stack.push((k, next));
}
}
}
    // rust: self.adv_ui.tab = tab;
    // rust: View {
    // rust: tabs,
    // rust: widgets,
    // rust: parent,
    // rust: bounds,
}
}
pub fn adv_scroll_by(self: *Self, view: *View, dx: f64, dy: f64) void {
}
    // rust: let (min_x, min_y, max_x, max_y) = view.bounds;
    // rust: let Some((sx, sy)) = self.adv_ui.scroll.as_mut() else {
    // rust: return;
}
    // rust: if max_x - min_x > INSIDE_W {
    // rust: *sx = (*sx + dx).clamp(f64::from(-(max_x - INSIDE_W)), 0.0);
}
    // rust: if max_y - min_y > INSIDE_H {
    // rust: *sy = (*sy + dy).clamp(f64::from(-(max_y - INSIDE_H)), 0.0);
}
}
    /// `AdvancementWidget`'s title lines, description lines and width.
pub fn adv_widget_text(self: *Self, i: usize) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let font = &self.gui.atlas.font;
    // rust: let a = &self.adv.tree.list[i];
    // rust: let Some(d) = &a.display else {
    // rust: return (Vec::new(), Vec::new(), 0.0);
}
    // rust: let title = font.split(&text_of(&d.title), 163.0);
    // rust: let title_w = title
    // rust: .iter()
    // rust: .map(|l| font.width_text(l))
    // rust: .fold(0.0f32, f32::max)
    // rust: .max(80.0);
    // rust: let n = a.requirements.len();
    // rust: let progress_w = if n <= 1 {
    // rust: 0.0
    // rust: } else {
    // rust: let t = Text::translate(
    // rust: "advancements.progress",
    // rust: &[Text::literal(n.to_string()), Text::literal(n.to_string())],
    // rust: );
    // rust: font.width_text(&t) + 8.0
}
    // rust: let mut longest = 29.0 + title_w + progress_w;
    // rust: let color = match d.frame {
    // rust: Frame::Challenge => 0xAA00AA,
    // rust: _ => 0x55FF55,
}
    // rust: let desc = text_of(&d.description).with_style(&Style::color(color));
        // findOptimalLines.
    // rust: let mut best: Option<(f32, Vec<Text>)> = None;
    // rust: for margin in [0.0, 10.0, -10.0, 25.0, -25.0] {
    // rust: let lines = font.split(&desc, longest - margin);
    // rust: let widest = lines.iter().map(|l| font.width_text(l)).fold(0.0, f32::max);
    // rust: let distance = (widest - longest).abs();
    // rust: if distance <= 10.0 {
    // rust: best = Some((distance, lines));
    // rust: break;
}
    // rust: if best.as_ref().is_none_or(|(d, _)| distance < *d) {
    // rust: best = Some((distance, lines));
}
}
    // rust: let desc = best.map(|b| b.1).unwrap_or_default();
    // rust: for l in &desc {
    // rust: longest = longest.max(font.width_text(l));
}
    // rust: (title, desc, longest + 3.0 + 5.0)
}
    // rust: pub(super) fn draw_advancements(&mut self, batch: &mut HudBatch) {
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: horizon_client::widgets::ScreenInfo::new(
    // rust: "advancements",
    // rust: super::screen_info::tr("gui.advancements", &[]),
    // rust: )
    // rust: });
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let view = self.adv_view();
    // rust: let (left, top) = window(w, h);
    // rust: let (ix, iy) = (left + 9.0, top + 18.0);
        // Centre a freshly opened tab.
    // rust: if self.adv_ui.scroll.is_none() && !view.widgets.is_empty() {
    // rust: let (min_x, min_y, max_x, max_y) = view.bounds;
    // rust: self.adv_ui.scroll = Some((
    // rust: f64::from(117 - (max_x + min_x) / 2),
    // rust: f64::from(56 - (max_y + min_y) / 2),
    // rust: ));
}
    // rust: let (sx, sy) = self.adv_ui.scroll.unwrap_or_default();
    // rust: let (sx, sy) = (sx.floor() as i32, sy.floor() as i32);
    // rust: self.adv_tick_hover(&view, sx, sy, left, top);
    // rust: let atlas = &self.gui.atlas;
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, true);
    // rust: let title = Text::translate("gui.advancements", &[]);
    // rust: let tw = atlas.font.width_text(&title);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: ((w - tw) / 2.0).floor(),
    // rust: 12.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
        // The inside.
    // rust: let tree = self.adv.tree.clone();
    // rust: let tab = self.adv_ui.tab;
    // rust: match tab {
    // rust: None => {
    // rust: batch.fill(atlas, ix, iy, 234.0, 113.0, 0xFF00_0000);
    // rust: let mid = ix + 117.0;
    // rust: for (key, y) in [
    // rust: ("advancements.empty", iy + 56.0 - 4.0),
    // rust: ("advancements.sad_label", iy + 113.0 - 9.0),
    // rust: ] {
    // rust: let t = Text::translate(key, &[]);
    // rust: let tw = atlas.font.width_text(&t);
    // rust: batch.text_styled(atlas, &t, (mid - tw / 2.0).floor(), y, u32::MAX, true);
}
}
    // rust: Some(root) => {
    // rust: let start = batch.vertices.len();
    // rust: let bg = tree.list[root]
    // rust: .display
    // rust: .as_ref()
    // rust: .and_then(|d| d.background.clone())
    // rust: .unwrap_or_default();
    // rust: let bg = bg.strip_prefix("minecraft:").unwrap_or(&bg).to_owned();
    // rust: let (l, t) = ((sx % 16) as f32, (sy % 16) as f32);
    // rust: for x in -1..=15 {
    // rust: for y in -1..=8 {
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: &bg,
    // rust: ix + l + 16.0 * x as f32,
    // rust: iy + t + 16.0 * y as f32,
    // rust: 16.0,
    // rust: 16.0,
    // rust: u32::MAX,
    // rust: );
}
}
    // rust: let all = self
    // rust: .adv_ui
    // rust: .cache
    // rust: .as_ref()
    // rust: .map(|c| c.pos.clone())
    // rust: .unwrap_or_default();
    // rust: let pos = |i: usize| all.get(i).copied().flatten().unwrap_or_default();
    // rust: let (ox, oy) = (ix as i32 + sx, iy as i32 + sy);
    // rust: for background in [true, false] {
    // rust: let col = if background { 0xFF00_0000 } else { u32::MAX };
    // rust: let hline = |batch: &mut HudBatch, x0: i32, x1: i32, y: i32| {
    // rust: let (a, b) = (x0.min(x1), x0.max(x1));
    // rust: batch.fill(atlas, a as f32, y as f32, (b + 1 - a) as f32, 1.0, col);
}
    // rust: let vline = |batch: &mut HudBatch, x: i32, y0: i32, y1: i32| {
    // rust: let (a, b) = (y0.min(y1), y0.max(y1));
    // rust: if b > a + 1 {
    // rust: batch.fill(
    // rust: atlas,
    // rust: x as f32,
    // rust: (a + 1) as f32,
    // rust: 1.0,
    // rust: (b - a - 1) as f32,
    // rust: col,
    // rust: );
}
}
    // rust: for &i in &view.widgets {
    // rust: let Some(p) = view.parent[i] else {
    // rust: continue;
}
    // rust: let (px, py) = pos(p);
    // rust: let (mx, my) = pos(i);
    // rust: let dep_x = ox + px + 13;
    // rust: let split_x = ox + px + 26 + 4;
    // rust: let dep_y = oy + py + 13;
    // rust: let (my_x, my_y) = (ox + mx + 13, oy + my + 13);
    // rust: if background {
    // rust: hline(batch, split_x, dep_x, dep_y - 1);
    // rust: hline(batch, split_x + 1, dep_x, dep_y);
    // rust: hline(batch, split_x, dep_x, dep_y + 1);
    // rust: hline(batch, my_x, split_x - 1, my_y - 1);
    // rust: hline(batch, my_x, split_x - 1, my_y);
    // rust: hline(batch, my_x, split_x - 1, my_y + 1);
    // rust: vline(batch, split_x - 1, my_y, dep_y);
    // rust: vline(batch, split_x + 1, my_y, dep_y);
    // rust: } else {
    // rust: hline(batch, split_x, dep_x, dep_y);
    // rust: hline(batch, my_x, split_x, my_y);
    // rust: vline(batch, split_x, my_y, dep_y);
}
}
}
    // rust: for &i in &view.widgets {
    // rust: let a = &tree.list[i];
    // rust: let Some(d) = &a.display else { continue };
    // rust: let done = self.adv_done(i);
    // rust: if d.hidden && !done {
    // rust: continue;
}
    // rust: let (x, y) = pos(i);
    // rust: let (x, y) = ((ox + x) as f32, (oy + y) as f32);
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: frame_sprite(d.frame, done),
    // rust: x + 3.0,
    // rust: y,
    // rust: 26.0,
    // rust: 26.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let icon = ItemStack::new(&d.icon, 1);
    // rust: self.draw_item(batch, &icon, x + 8.0, y + 5.0);
}
    // rust: batch.clip_since(start, ix, iy, ix + 234.0, iy + 113.0);
}
}
        // The window, tabs and title.
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: "gui/advancements/window",
    // rust: [left, top, 252.0, 140.0],
    // rust: 256.0,
    // rust: 256.0,
    // rust: );
    // rust: if view.tabs.len() > 1 {
    // rust: for (n, &t) in view.tabs.iter().enumerate() {
    // rust: let Some((ty, i)) = tab_type(n) else { continue };
    // rust: let (x, y) = tab_pos(ty, i);
    // rust: let sprite = tab_sprite(ty, i, ty.3, Some(t) == tab);
    // rust: horizon_client::widgets::target_as(
    // rust: [left + x, top + y, ty.1, ty.2],
    // rust: horizon_client::widgets::Kind::Tab(Some(t) == tab),
    // rust: );
    // rust: batch.sprite_scaled(
    // rust: &self.gui.atlas,
    // rust: &sprite,
    // rust: left + x,
    // rust: top + y,
    // rust: ty.1,
    // rust: ty.2,
    // rust: u32::MAX,
    // rust: );
}
    // rust: for (n, &t) in view.tabs.iter().enumerate() {
    // rust: let Some((ty, i)) = tab_type(n) else { continue };
    // rust: let (x, y) = tab_pos(ty, i);
    // rust: let (dx, dy) = icon_offset(ty.0);
    // rust: if let Some(d) = &tree.list[t].display {
    // rust: let icon = ItemStack::new(&d.icon, 1);
    // rust: self.draw_item(batch, &icon, left + x + dx, top + y + dy);
}
}
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let title = tab.and_then(|t| tree.list[t].display.as_ref()).map_or_else(
    // rust: || Text::translate("gui.advancements", &[]),
    // rust: |d| text_of(&d.title),
    // rust: );
    // rust: batch.text_styled(atlas, &title, left + 8.0, top + 6.0, 0xFF40_4040, false);
        // Tooltips.
    // rust: if tab.is_some() {
    // rust: let alpha = (self.adv_ui.fade * 255.0).floor() as u32;
    // rust: batch.fill(atlas, ix, iy, 234.0, 113.0, alpha << 24);
    // rust: if let Some(i) = self.adv_ui.hovered {
    // rust: self.adv_draw_hover(batch, i, ix, iy, sx, sy, left, w);
}
}
        // Done.
    // rust: let atlas = &self.gui.atlas;
    // rust: let (bx, by) = ((w / 2.0 - 100.0).floor(), h - FOOTER + 6.0);
    // rust: let hover = ui::hovered(self.cursor, bx, by, 200.0, 20.0);
    // rust: ui::action_button(
    // rust: batch,
    // rust: atlas,
    // rust: horizon_client::widgets::Action::Done,
    // rust: bx,
    // rust: by,
    // rust: 200.0,
    // rust: 20.0,
    // rust: &Text::translate("gui.done", &[]),
    // rust: true,
    // rust: hover,
    // rust: );
        // Tab tooltips: the tab title under the cursor.
    // rust: if view.tabs.len() > 1 {
    // rust: for (n, &t) in view.tabs.iter().enumerate() {
    // rust: let Some((ty, i)) = tab_type(n) else { continue };
    // rust: let (x, y) = tab_pos(ty, i);
    // rust: let (x, y) = (left + x, top + y);
    // rust: let (cx, cy) = self.cursor;
    // rust: if cx > x && cx < x + ty.1 && cy > y && cy < y + ty.2 {
    // rust: if let Some(d) = &tree.list[t].display {
    // rust: ui::tooltip(batch, &self.gui.atlas, &[text_of(&d.title)], self.cursor);
}
    // rust: break;
}
}
}
}
    /// `AdvancementTab.tick`, run per frame at the tick rate's pace.
pub fn adv_tick_hover(self: *Self, view: *View, sx: i32, sy: i32, left: f32, top: f32) void {
}
    // rust: let now = Instant::now();
    // rust: let ticks = self
    // rust: .adv_ui
    // rust: .last_frame
    // rust: .map_or(0.0, |t| (now - t).as_secs_f32() * 20.0)
    // rust: .min(5.0);
    // rust: self.adv_ui.last_frame = Some(now);
    // rust: let mx = (self.cursor.0 - left - 9.0).floor() as i32;
    // rust: let my = (self.cursor.1 - top - 18.0).floor() as i32;
    // rust: let mut hovered = None;
    // rust: if mx > 0 && mx < INSIDE_W && my > 0 && my < INSIDE_H {
    // rust: for &i in &view.widgets {
    // rust: let hidden = self.adv.tree.list[i]
    // rust: .display
    // rust: .as_ref()
    // rust: .is_some_and(|d| d.hidden);
    // rust: if hidden && !self.adv_done(i) {
    // rust: continue;
}
    // rust: let Some((x, y)) = self.adv_ui.cache.as_ref().and_then(|c| c.pos[i]) else {
    // rust: continue;
}
    // rust: let (x0, y0) = (sx + x, sy + y);
    // rust: if mx >= x0 && mx <= x0 + 26 && my >= y0 && my <= y0 + 26 {
    // rust: hovered = Some(i);
    // rust: break;
}
}
}
    // rust: if hovered.is_some() {
    // rust: self.adv_ui.hovered = hovered;
    // rust: self.adv_ui.fade = (self.adv_ui.fade + 0.06 * ticks).clamp(0.0, 0.3);
    // rust: } else {
    // rust: self.adv_ui.hovered = None;
    // rust: self.adv_ui.fade = (self.adv_ui.fade - 0.12 * ticks).clamp(0.0, 1.0);
}
}
    /// `AdvancementWidget.extractHover`, in GUI pixels.
    // rust: fn adv_draw_hover(
    // rust: &mut self,
    // rust: batch: &mut HudBatch,
    // rust: i: usize,
    // rust: ix: f32,
    // rust: iy: f32,
    // rust: sx: i32,
    // rust: sy: i32,
    // rust: left: f32,
    // rust: screen_w: f32,
    // rust: ) {
    // rust: let (title, desc, width) = self.adv_widget_text(i);
    // rust: let tree = self.adv.tree.clone();
    // rust: let a = &tree.list[i];
    // rust: let Some(d) = &a.display else { return };
    // rust: let Some((wx, wy)) = self.adv_ui.cache.as_ref().and_then(|c| c.pos[i]) else {
    // rust: return;
}
    // rust: let width = width as i32;
    // rust: let (x, y) = (sx + wx, sy + wy);
    // rust: let title_bar_h = 9 * title.len() as i32 + 9 + 8;
    // rust: let title_top = y + (26 - title_bar_h) / 2;
    // rust: let title_bottom = title_top + title_bar_h;
    // rust: let desc_text_h = desc.len() as i32 * 9;
    // rust: let desc_h = 6 + desc_text_h;
    // rust: let left_side = left as i32 + x + width + 26 >= screen_w as i32;
    // rust: let (got, total) = self.adv.progress.counts(a);
    // rust: let progress = (total > 1 && !a.criteria.is_empty()).then(|| {
    // rust: Text::translate(
    // rust: "advancements.progress",
    // rust: &[
    // rust: Text::literal(got.to_string()),
    // rust: Text::literal(total.to_string()),
    // rust: ],
    // rust: )
    // rust: });
    // rust: let atlas = &self.gui.atlas;
    // rust: let progress_w = progress.as_ref().map_or(0.0, |t| atlas.font.width_text(t)) as i32;
    // rust: let top_side = title_bottom + desc_h >= INSIDE_H;
    // rust: let amount = if a.criteria.is_empty() || total == 0 {
    // rust: 0.0
    // rust: } else {
    // rust: got as f32 / total as f32
}
    // rust: let mut first_w = (amount * width as f32).floor() as i32;
    // rust: let (first, second, icon_frame) = if amount >= 1.0 {
    // rust: first_w = width / 2;
    // rust: (true, true, true)
    // rust: } else if first_w < 2 {
    // rust: first_w = width / 2;
    // rust: (false, false, false)
    // rust: } else if first_w > width - 2 {
    // rust: first_w = width / 2;
    // rust: (true, true, false)
    // rust: } else {
    // rust: (true, false, false)
}
    // rust: let second_w = width - first_w;
    // rust: let title_left = if left_side { x - width + 26 + 6 } else { x };
    // rust: let bg_h = title_bar_h + desc_h;
    // rust: let f = |v: i32| v as f32;
    // rust: if !desc.is_empty() {
    // rust: let by = if top_side {
    // rust: title_bottom - bg_h
    // rust: } else {
    // rust: title_top
}
    // rust: ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/advancements/title_box",
    // rust: ix + f(title_left),
    // rust: iy + f(by),
    // rust: f(width),
    // rust: f(bg_h),
    // rust: u32::MAX,
    // rust: );
}
    // rust: if first != second {
    // rust: for (sprite, src_x, at, w) in [
    // rust: (box_sprite(first), 0, title_left, first_w),
    // rust: (
    // rust: box_sprite(second),
    // rust: 200 - second_w,
    // rust: title_left + first_w,
    // rust: second_w,
    // rust: ),
    // rust: ] {
    // rust: let start = batch.vertices.len();
    // rust: ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: sprite,
    // rust: ix + f(at - src_x),
    // rust: iy + f(title_top),
    // rust: 200.0,
    // rust: f(title_bar_h),
    // rust: u32::MAX,
    // rust: );
    // rust: batch.clip_since(
    // rust: start,
    // rust: ix + f(at),
    // rust: iy + f(title_top),
    // rust: ix + f(at + w),
    // rust: iy + f(title_bottom),
    // rust: );
}
    // rust: } else {
    // rust: ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: box_sprite(first),
    // rust: ix + f(title_left),
    // rust: iy + f(title_top),
    // rust: f(width),
    // rust: f(title_bar_h),
    // rust: u32::MAX,
    // rust: );
}
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: frame_sprite(d.frame, icon_frame),
    // rust: ix + f(x + 3),
    // rust: iy + f(y),
    // rust: 26.0,
    // rust: 26.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let desc_left = title_left + 5;
    // rust: let lines = |batch: &mut HudBatch, lines: &[Text], x: i32, y: i32, color: u32| {
    // rust: for (n, l) in lines.iter().enumerate() {
    // rust: batch.text_styled(atlas, l, ix + f(x), iy + f(y + n as i32 * 9), color, true);
}
}
    // rust: let (title_x, progress_x) = if left_side {
    // rust: (desc_left, x - progress_w)
    // rust: } else {
    // rust: (x + 32, x + width - progress_w - 5)
}
    // rust: lines(batch, &title, title_x, title_top + 9, u32::MAX);
    // rust: if let Some(p) = &progress {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: p,
    // rust: ix + f(progress_x),
    // rust: iy + f(title_top + 9),
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: let desc_y = if top_side {
    // rust: title_top - desc_text_h + 1
    // rust: } else {
    // rust: title_bottom
}
    // rust: lines(batch, &desc, desc_left, desc_y, 0xFF00_FF00);
    // rust: let icon = ItemStack::new(&d.icon, 1);
    // rust: self.draw_item(batch, &icon, ix + f(x + 8), iy + f(y + 5));
}
    /// A left button press or release.
    // rust: pub(super) fn advancements_mouse(&mut self, pressed: bool, size: [u32; 2]) {
    // rust: if !pressed {
    // rust: self.adv_ui.drag = None;
    // rust: self.adv_ui.scrolling = false;
    // rust: return;
}
    // rust: let b = HudBatch::new(size);
    // rust: let (w, h) = (b.width, b.height);
    // rust: if ui::hovered(
    // rust: self.cursor,
    // rust: (w / 2.0 - 100.0).floor(),
    // rust: h - FOOTER + 6.0,
    // rust: 200.0,
    // rust: 20.0,
    // rust: ) {
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: self.close_advancements();
    // rust: return;
}
    // rust: let view = self.adv_view();
    // rust: let (left, top) = window(w, h);
    // rust: for (n, &t) in view.tabs.iter().enumerate() {
    // rust: let Some((ty, i)) = tab_type(n) else { continue };
    // rust: let (x, y) = tab_pos(ty, i);
    // rust: let (x, y) = (left + x, top + y);
    // rust: let (cx, cy) = self.cursor;
    // rust: if cx > x && cx < x + ty.1 && cy > y && cy < y + ty.2 {
    // rust: if self.adv_ui.tab != Some(t) {
    // rust: self.adv_ui.tab = Some(t);
    // rust: self.adv_ui.scroll = None;
}
    // rust: return;
}
}
    // rust: self.adv_ui.drag = Some(self.cursor);
}
    /// `mouseDragged` with the left button: the first step starts
    /// scrolling, later ones move the tree.
    // rust: pub(super) fn advancements_drag(&mut self) {
    // rust: let Some(last) = self.adv_ui.drag else {
    // rust: return;
}
    // rust: let (dx, dy) = (self.cursor.0 - last.0, self.cursor.1 - last.1);
    // rust: self.adv_ui.drag = Some(self.cursor);
    // rust: if !self.adv_ui.scrolling {
    // rust: self.adv_ui.scrolling = true;
    // rust: return;
}
    // rust: let view = self.adv_view();
    // rust: self.adv_scroll_by(&view, f64::from(dx), f64::from(dy));
}
    // rust: pub(super) fn advancements_scroll(&mut self, x: f32, y: f32) {
    // rust: let view = self.adv_view();
    // rust: self.adv_scroll_by(&view, f64::from(x) * 16.0, f64::from(y) * 16.0);
}
}
