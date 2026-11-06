//! Transpiled from Horizon Rust crate
//! Module: horizon-client_stats_screen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The Statistics screen (`StatsScreen`): General, Items and Mobs tabs over
//! the player's statistics, with the Done button.
// use super::{Game, Screen};
// use horizon_client::{hud::HudBatch, items::ItemStack, text::Text, ui};
// use std::fmt::Write as _;

/// `Stats.CUSTOM` in registration order with its formatter.
    // rust: const CUSTOM: &[(&str, Format)] = &[
    // rust: ("leave_game", Format::Default),
    // rust: ("play_time", Format::Time),
    // rust: ("total_world_time", Format::Time),
    // rust: ("time_since_death", Format::Time),
    // rust: ("time_since_rest", Format::Time),
    // rust: ("sneak_time", Format::Time),
    // rust: ("walk_one_cm", Format::Distance),
    // rust: ("crouch_one_cm", Format::Distance),
    // rust: ("sprint_one_cm", Format::Distance),
    // rust: ("walk_on_water_one_cm", Format::Distance),
    // rust: ("fall_one_cm", Format::Distance),
    // rust: ("climb_one_cm", Format::Distance),
    // rust: ("fly_one_cm", Format::Distance),
    // rust: ("walk_under_water_one_cm", Format::Distance),
    // rust: ("minecart_one_cm", Format::Distance),
    // rust: ("boat_one_cm", Format::Distance),
    // rust: ("pig_one_cm", Format::Distance),
    // rust: ("happy_ghast_one_cm", Format::Distance),
    // rust: ("horse_one_cm", Format::Distance),
    // rust: ("aviate_one_cm", Format::Distance),
    // rust: ("swim_one_cm", Format::Distance),
    // rust: ("strider_one_cm", Format::Distance),
    // rust: ("nautilus_one_cm", Format::Distance),
    // rust: ("jump", Format::Default),
    // rust: ("drop", Format::Default),
    // rust: ("damage_dealt", Format::Tenths),
    // rust: ("damage_dealt_absorbed", Format::Tenths),
    // rust: ("damage_dealt_resisted", Format::Tenths),
    // rust: ("damage_taken", Format::Tenths),
    // rust: ("damage_blocked_by_shield", Format::Tenths),
    // rust: ("damage_absorbed", Format::Tenths),
    // rust: ("damage_resisted", Format::Tenths),
    // rust: ("deaths", Format::Default),
    // rust: ("mob_kills", Format::Default),
    // rust: ("animals_bred", Format::Default),
    // rust: ("player_kills", Format::Default),
    // rust: ("fish_caught", Format::Default),
    // rust: ("talked_to_villager", Format::Default),
    // rust: ("traded_with_villager", Format::Default),
    // rust: ("eat_cake_slice", Format::Default),
    // rust: ("fill_cauldron", Format::Default),
    // rust: ("use_cauldron", Format::Default),
    // rust: ("clean_armor", Format::Default),
    // rust: ("clean_banner", Format::Default),
    // rust: ("clean_shulker_box", Format::Default),
    // rust: ("interact_with_brewingstand", Format::Default),
    // rust: ("interact_with_beacon", Format::Default),
    // rust: ("inspect_dropper", Format::Default),
    // rust: ("inspect_hopper", Format::Default),
    // rust: ("inspect_dispenser", Format::Default),
    // rust: ("play_noteblock", Format::Default),
    // rust: ("tune_noteblock", Format::Default),
    // rust: ("pot_flower", Format::Default),
    // rust: ("trigger_trapped_chest", Format::Default),
    // rust: ("open_enderchest", Format::Default),
    // rust: ("enchant_item", Format::Default),
    // rust: ("play_record", Format::Default),
    // rust: ("interact_with_furnace", Format::Default),
    // rust: ("interact_with_crafting_table", Format::Default),
    // rust: ("open_chest", Format::Default),
    // rust: ("sleep_in_bed", Format::Default),
    // rust: ("sleep_in_straw_bed", Format::Default),
    // rust: ("open_shulker_box", Format::Default),
    // rust: ("open_barrel", Format::Default),
    // rust: ("interact_with_blast_furnace", Format::Default),
    // rust: ("interact_with_smoker", Format::Default),
    // rust: ("interact_with_lectern", Format::Default),
    // rust: ("interact_with_campfire", Format::Default),
    // rust: ("interact_with_cartography_table", Format::Default),
    // rust: ("interact_with_loom", Format::Default),
    // rust: ("interact_with_stonecutter", Format::Default),
    // rust: ("bell_ring", Format::Default),
    // rust: ("raid_trigger", Format::Default),
    // rust: ("raid_win", Format::Default),
    // rust: ("interact_with_anvil", Format::Default),
    // rust: ("interact_with_grindstone", Format::Default),
    // rust: ("target_hit", Format::Default),
    // rust: ("interact_with_smithing_table", Format::Default),
    // rust: ];
pub const Format = enum {
    Default,
    Tenths,
    Distance,
    Time,
};
pub fn two(v: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{v:.2}")
}
/// `StatFormatter`.
pub fn format(f: Format, v: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match f {
    // rust: Format::Default => {
            // NumberFormat.getIntegerInstance(Locale.US): thousands separators.
    // rust: let digits = v.unsigned_abs().to_string();
    // rust: let mut out = String::new();
    // rust: for (i, c) in digits.chars().enumerate() {
    // rust: if i > 0 && (digits.len() - i).is_multiple_of(3) {
    // rust: out.push(',');
}
    // rust: out.push(c);
}
    // rust: if v < 0 {
    // rust: out.insert(0, '-');
}
    // rust: out
}
    // rust: Format::Tenths => two(f64::from(v) * 0.1),
    // rust: Format::Distance => {
    // rust: let m = f64::from(v) / 100.0;
    // rust: let km = m / 1000.0;
    // rust: if km > 0.5 {
    // rust: format!("{} km", two(km))
    // rust: } else if m > 0.5 {
    // rust: format!("{} m", two(m))
    // rust: } else {
    // rust: format!("{v} cm")
}
}
    // rust: Format::Time => {
    // rust: let s = f64::from(v) / 20.0;
    // rust: let (min, h) = (s / 60.0, s / 3600.0);
    // rust: let (d, y) = (h / 24.0, h / 24.0 / 365.0);
    // rust: if y > 0.5 {
    // rust: format!("{} y", two(y))
    // rust: } else if d > 0.5 {
    // rust: format!("{} d", two(d))
    // rust: } else if h > 0.5 {
    // rust: format!("{} h", two(h))
    // rust: } else if min > 0.5 {
    // rust: format!("{} min", two(min))
    // rust: } else {
                // Java's double + " s".
    // rust: let mut t = String::new();
    // rust: let _ = write!(t, "{s:?}");
    // rust: format!("{t} s")
}
}
}
}
/// The item columns: (stat type, header sprite).
    // rust: const COLUMNS: [(&str, &str); 6] = [
    // rust: ("mined", "gui/sprites/statistics/block_mined"),
    // rust: ("broken", "gui/sprites/statistics/item_broken"),
    // rust: ("crafted", "gui/sprites/statistics/item_crafted"),
    // rust: ("used", "gui/sprites/statistics/item_used"),
    // rust: ("picked_up", "gui/sprites/statistics/item_picked_up"),
    // rust: ("dropped", "gui/sprites/statistics/item_dropped"),
    // rust: ];
    // rust: pub(super) struct StatsUi {
    // rust: tab: usize,
    /// The list's scrolling: the wheel and the held scrollbar.
    // rust: scroll: horizon_client::ui::Scroll,
    // rust: sort: Option<(usize, i32)>,
}
/// `MenuTabBar` geometry: three tabs over at most 400 pixels.
pub fn tabs(w: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let total = w.min(400.0) - 28.0;
    // rust: let tab = ((total / 3.0) / 2.0).round() * 2.0;
    // rust: let x0 = ((w - tab * 3.0) / 2.0).floor();
    // rust: (x0, tab)
}
pub const TAB_H: f32 = 24.0;
pub const FOOTER: f32 = 33.0;
    // rust: impl Game<'_> {
    // rust: pub(super) fn open_stats(&mut self) {
    // rust: self.load_stats();
        // StatsScreen.init: a server's client asks for its statistics.
    // rust: if self.remote.is_some() {
    // rust: self.send(horizon_protocol::packets::play::Serverbound::ClientCommand(
    // rust: horizon_protocol::packets::play::ClientCommand { action: 1 },
    // rust: ));
}
    // rust: self.stats_ui = StatsUi::default();
    // rust: self.screen = Screen::Stats;
}
    /// The list's scrollbar column (right of the 280 pixel list) and the
    /// pixels it scrolls.
pub fn stats_bar(w: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((w - 280.0) / 2.0).floor() + 280.0 + 6.0
}
pub fn stats_content(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (row_h, rows) = self.stats_rows();
    // rust: row_h * rows as f32 + 4.0
}
pub fn stats_rows(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.stats_ui.tab {
    // rust: 0 => (14.0, CUSTOM.len()),
    // rust: 1 => (22.0, self.stat_items().len() + 1),
    // rust: _ => (36.0, self.stat_mobs().len()),
}
}
    /// Whether tab `i` can be chosen: the Items and Mobs tabs are active only
    /// while their list has rows.
pub fn stats_tab_active(self: *Self, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match i {
    // rust: 1 => !self.stat_items().is_empty(),
    // rust: 2 => !self.stat_mobs().is_empty(),
    // rust: _ => true,
}
}
    /// Items (and block items) with any non-zero column.
pub fn stat_items(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut items: Vec<String> = Vec::new();
    // rust: for (ty, _) in COLUMNS {
    // rust: if let Some(m) = self.stats.values.get(&format!("minecraft:{ty}")) {
    // rust: for (k, v) in m {
    // rust: if *v > 0 && k != "minecraft:air" && !items.contains(k) {
    // rust: items.push(k.clone());
}
}
}
}
    // rust: if let Some((col, order)) = self.stats_ui.sort {
    // rust: let ty = COLUMNS[col].0;
    // rust: items.sort_by_key(|i| self.stats.get(ty, i) * -order);
}
    // rust: items
}
pub fn stat_mobs(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut mobs: Vec<String> = Vec::new();
    // rust: for ty in ["killed", "killed_by"] {
    // rust: if let Some(m) = self.stats.values.get(&format!("minecraft:{ty}")) {
    // rust: for (k, v) in m {
    // rust: if *v > 0 && !mobs.contains(k) {
    // rust: mobs.push(k.clone());
}
}
}
}
    // rust: mobs
}
    /// `MobRow`: the mob's name, its kills and killed-by lines, and their
    /// colours (grey when none).
pub fn mob_row(self: *Self, mob: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = Text::translate(&format!("entity.{}", mob.replace(':', ".")), &[]);
    // rust: let kills = self.stats.get("killed", mob);
    // rust: let by = self.stats.get("killed_by", mob);
    // rust: let k = if kills == 0 {
    // rust: Text::translate(
    // rust: "stat_type.minecraft.killed.none",
    // rust: std::slice::from_ref(&name),
    // rust: )
    // rust: } else {
    // rust: Text::translate(
    // rust: "stat_type.minecraft.killed",
    // rust: &[Text::literal(kills.to_string()), name.clone()],
    // rust: )
}
    // rust: let b = if by == 0 {
    // rust: Text::translate(
    // rust: "stat_type.minecraft.killed_by.none",
    // rust: std::slice::from_ref(&name),
    // rust: )
    // rust: } else {
    // rust: Text::translate(
    // rust: "stat_type.minecraft.killed_by",
    // rust: &[name.clone(), Text::literal(by.to_string())],
    // rust: )
}
    // rust: let colors = (
    // rust: if kills > 0 { 0xFFBA_BABA } else { 0xFF80_8080 },
    // rust: if by > 0 { 0xFFBA_BABA } else { 0xFF80_8080 },
    // rust: );
    // rust: (name, k, b, colors)
}
    // rust: pub(super) fn draw_stats(&mut self, batch: &mut HudBatch) {
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: horizon_client::widgets::ScreenInfo::new(
    // rust: "stats",
    // rust: super::screen_info::tr("gui.stats", &[]),
    // rust: )
    // rust: });
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let atlas = &self.gui.atlas;
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, true);
    // rust: let (top, bottom) = (TAB_H, h - FOOTER);
    // rust: ui::separators(batch, atlas, top, bottom, true);
        // The tab bar.
    // rust: let mut tab_tip = false;
    // rust: let (x0, tw) = tabs(w);
pub const TABS: [[]const u8; 3] = ["stat.generalButton", "stat.itemsButton", "stat.mobsButton"];
        // Its TabNavigationBar: the hovered tab, else the current one (a
        // GridLayoutTab's extra narration is empty).
    // rust: horizon_client::widgets::narratable(|| {
//             use horizon_client::widgets::{ListKind, Narratable, Row, What};
    // rust: let row = |i: usize| {
    // rust: let mut row = Row::new(i, Text::translate(TABS[i], &[]).plain());
    // rust: row.hint = Some(String::new());
    // rust: row
}
    // rust: let hovered = (0..TABS.len())
    // rust: .find(|&i| ui::hovered(self.cursor, x0 + tw * i as f32, 0.0, tw, TAB_H));
    // rust: Narratable::new(
    // rust: What::List {
    // rust: kind: ListKind::Tabs,
    // rust: total: TABS.len(),
    // rust: hovered: hovered.map(row),
    // rust: selected: Some(row(self.stats_ui.tab.min(TABS.len() - 1))),
    // rust: },
    // rust: [x0, 0.0, tw * TABS.len() as f32, TAB_H],
    // rust: )
    // rust: .key(horizon_client::widgets::key_of(&"stats/tabs"))
    // rust: });
    // rust: for (i, key) in TABS.into_iter().enumerate() {
    // rust: let x = x0 + tw * i as f32;
    // rust: let selected = self.stats_ui.tab == i;
    // rust: let active = self.stats_tab_active(i);
            // Only one that can be chosen: the bumpers step from the selected tab by clicking.
    // rust: if active {
    // rust: horizon_client::widgets::target_as(
    // rust: [x, 0.0, tw, TAB_H],
    // rust: horizon_client::widgets::Kind::Tab(selected),
    // rust: );
}
    // rust: let hover = ui::hovered(self.cursor, x, 0.0, tw, TAB_H);
    // rust: if hover && !active {
    // rust: tab_tip = true;
}
    // rust: let sprite = match (selected, hover) {
    // rust: (true, true) => "gui/sprites/widget/tab_selected_highlighted",
    // rust: (true, false) => "gui/sprites/widget/tab_selected",
    // rust: (false, true) => "gui/sprites/widget/tab_highlighted",
    // rust: (false, false) => "gui/sprites/widget/tab",
}
    // rust: ui::nine_slice(batch, atlas, sprite, x, 0.0, tw, TAB_H, u32::MAX);
    // rust: ui::menu_tab_label(
    // rust: batch,
    // rust: atlas,
    // rust: &Text::translate(key, &[]),
    // rust: (x, 0.0, tw, TAB_H),
    // rust: selected,
    // rust: active,
    // rust: horizon_client::hud_overlays::now_ms(),
    // rust: );
    // rust: if selected {
    // rust: batch.fill(atlas, x + 2.0, TAB_H - 3.0, tw - 4.0, 1.0, u32::MAX);
}
}
        // The list.
    // rust: let (row_h, rows) = self.stats_rows();
    // rust: let content = row_h * rows as f32 + 4.0;
    // rust: self.stats_ui.scroll.clamp(top, bottom, content);
    // rust: let left = ((w - 280.0) / 2.0).floor();
    // rust: let scroll = self.stats_ui.scroll.amount;
    // rust: let row_y = |i: usize| top + 4.0 + i as f32 * row_h - scroll;
    // rust: let visible = |y: f32| y >= top && y + row_h <= bottom;
        // The list's row under the mouse (`getHovered`).
    // rust: let hovered_row = {
    // rust: let (cx, cy) = self.cursor;
    // rust: let i = ((cy - (top + 4.0) + scroll) / row_h).floor();
    // rust: let inside = cy >= top && cy < bottom && cx >= left && cx < left + 280.0;
    // rust: (inside && i >= 0.0 && (i as usize) < rows).then_some(i as usize)
}
    // rust: let list_rect = [0.0, top, w, bottom - top];
    // rust: let list_key = horizon_client::widgets::key_of(&("stats/list", self.stats_ui.tab));
    // rust: let tr = super::screen_info::tr;
        // GeneralStatisticsList and MobsStatisticsList: ObjectSelectionLists
        // narrating the hovered row (none is selected).
    // rust: let object_list = |narration: &dyn Fn(usize) -> String| {
    // rust: horizon_client::widgets::narratable(|| {
//                 use horizon_client::widgets::{ListKind, Narratable, Row};
    // rust: let hovered = hovered_row.map(|i| Row::new(i, narration(i)));
    // rust: Narratable::list(ListKind::Object, rows, hovered, None, list_rect).key(list_key)
    // rust: });
}
        // The hovered item's tooltip, drawn over the list.
    // rust: let mut tip = None;
    // rust: match self.stats_ui.tab {
    // rust: 0 => {
    // rust: let mut sorted: Vec<(Text, String)> = CUSTOM
    // rust: .iter()
    // rust: .map(|(k, f)| {
    // rust: let label = Text::translate(&format!("stat.minecraft.{k}"), &[]);
    // rust: let v = self.stats.get("custom", &format!("minecraft:{k}"));
    // rust: (label, format(*f, v))
    // rust: })
    // rust: .collect();
    // rust: sorted.sort_by_key(|(l, _)| l.plain());
    // rust: object_list(&|i| {
    // rust: let (label, value) = &sorted[i];
    // rust: tr("narrator.select", &[&format!("{} {value}", label.plain())])
    // rust: });
    // rust: for (i, (label, value)) in sorted.iter().enumerate() {
    // rust: let y = row_y(i);
    // rust: if !visible(y) {
    // rust: continue;
}
    // rust: let color = if i % 2 == 0 { u32::MAX } else { 0xFFBA_BABA };
    // rust: let ty = y + (row_h - 8.0) / 2.0;
    // rust: batch.text_styled(atlas, label, left + 2.0, ty.floor(), color, true);
    // rust: let vw = HudBatch::text_width(atlas, value);
    // rust: batch.text(
    // rust: atlas,
    // rust: value,
    // rust: left + 280.0 - vw - 4.0,
    // rust: ty.floor(),
    // rust: color,
    // rust: true,
    // rust: );
}
}
    // rust: 1 => {
    // rust: let items = self.stat_items();
    // rust: if items.is_empty() {
    // rust: return self.draw_stats_footer(batch, w, h);
}
                // ItemStatisticsList, a ContainerObjectSelectionList: the
                // header's sort buttons and each row's item.
    // rust: horizon_client::widgets::narratable(|| {
    // rust: horizon_client::widgets::Narratable::container_list(
    // rust: rows,
    // rust: hovered_row,
    // rust: list_rect,
    // rust: )
    // rust: .key(list_key)
    // rust: });
                // The header row of sort buttons.
    // rust: let y = row_y(0);
    // rust: if visible(y) {
    // rust: for (c, (ty, sprite)) in COLUMNS.iter().enumerate() {
    // rust: let x = left + 75.0 + 40.0 * c as f32 - 18.0;
    // rust: let hover = ui::hovered(self.cursor, x, y + 1.0, 18.0, 18.0);
                        // StatSortButton: an ImageButton named by its stat
                        // type, which is its tooltip too.
    // rust: horizon_client::widgets::narratable(|| {
    // rust: let name = tr(&format!("stat_type.minecraft.{ty}"), &[]);
    // rust: horizon_client::widgets::Narratable::button(
    // rust: name.clone(),
    // rust: [x, y + 1.0, 18.0, 18.0],
    // rust: true,
    // rust: )
    // rust: .hint(name)
    // rust: .key(horizon_client::widgets::key_of(&("stats/sort", c)))
    // rust: .child_of(list_key, 0)
    // rust: });
    // rust: let bg = if hover {
    // rust: "gui/sprites/statistics/header"
    // rust: } else {
    // rust: "gui/sprites/container/slot"
}
    // rust: batch.sprite(atlas, bg, x, y + 1.0);
    // rust: batch.sprite(atlas, sprite, x, y + 1.0);
    // rust: if let Some((sc, order)) = self.stats_ui.sort
    // rust: && sc == c
    // rust: {
    // rust: let s = if order < 0 {
    // rust: "gui/sprites/statistics/sort_down"
    // rust: } else {
    // rust: "gui/sprites/statistics/sort_up"
}
    // rust: batch.sprite(atlas, s, x, y + 1.0);
}
}
}
    // rust: for (i, item) in items.iter().enumerate() {
    // rust: let y = row_y(i + 1);
    // rust: if !visible(y) {
    // rust: continue;
}
    // rust: let stack = ItemStack::new(item, 1);
                    // ItemRowWidget, an ItemDisplayWidget: "Item: <name>".
    // rust: horizon_client::widgets::narratable(|| {
    // rust: let names = |id: &str| self.pack.names.display_item(id);
    // rust: let name = horizon_client::stations::hover_name(&names, &stack);
    // rust: horizon_client::widgets::Narratable::text(
    // rust: tr("narration.item", &[&name]),
    // rust: [left + 1.0, y + 1.0, 18.0, 18.0],
    // rust: )
    // rust: .key(horizon_client::widgets::key_of(&("stats/item", item)))
    // rust: .child_of(list_key, i + 1)
    // rust: .without_tooltip()
    // rust: });
    // rust: batch.sprite(
    // rust: &self.gui.atlas,
    // rust: "gui/sprites/container/slot",
    // rust: left + 1.0,
    // rust: y + 1.0,
    // rust: );
    // rust: self.draw_item(batch, &stack, left + 2.0, y + 2.0);
                    // `ItemRowWidget.extractTooltip`: the item's tooltip at the slot's corner.
    // rust: if ui::hovered(self.cursor, left + 1.0, y + 1.0, 18.0, 18.0) {
    // rust: tip = Some((stack.clone(), left + 19.0, y + 19.0));
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let color = if (i + 1) % 2 == 0 {
    // rust: u32::MAX
    // rust: } else {
    // rust: 0xFFBA_BABA
}
    // rust: for (c, (ty, _)) in COLUMNS.iter().enumerate() {
    // rust: let x = left + 75.0 + 40.0 * c as f32;
    // rust: let block = c == 0
    // rust: && self
    // rust: .res
    // rust: .items()
    // rust: .get(item)
    // rust: .is_some_and(|i| i.block.is_some());
    // rust: let text = if c == 0 && !block {
    // rust: Text::translate("stats.none", &[]).plain()
    // rust: } else {
    // rust: format(Format::Default, self.stats.get(ty, item))
}
    // rust: let tw = HudBatch::text_width(atlas, &text);
    // rust: batch.text(atlas, &text, x - tw, (y + 7.0).floor(), color, true);
}
}
}
    // rust: _ => {
    // rust: let mobs = self.stat_mobs();
    // rust: object_list(&|i| {
    // rust: let (_, kills, killed_by, _) = self.mob_row(&mobs[i]);
    // rust: let both = horizon_client::widgets::join_for_narration(&[
    // rust: &kills.plain(),
    // rust: &killed_by.plain(),
    // rust: ]);
    // rust: tr("narrator.select", &[&both])
    // rust: });
    // rust: for (i, mob) in mobs.iter().enumerate() {
    // rust: let y = row_y(i);
    // rust: if !visible(y) {
    // rust: continue;
}
    // rust: let (name, k, b, (ck, cb)) = self.mob_row(mob);
    // rust: batch.text_styled(atlas, &name, left + 2.0, y + 1.0, u32::MAX, true);
    // rust: batch.text_styled(atlas, &k, left + 12.0, y + 10.0, ck, true);
    // rust: batch.text_styled(atlas, &b, left + 12.0, y + 19.0, cb, true);
}
}
}
    // rust: let atlas = &self.gui.atlas;
    // rust: ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: Self::stats_bar(w),
    // rust: top,
    // rust: bottom,
    // rust: content,
    // rust: self.stats_ui.scroll.amount,
    // rust: );
    // rust: self.draw_stats_footer(batch, w, h);
    // rust: if let Some((stack, x, y)) = tip {
    // rust: self.draw_stack_tooltip(batch, &stack, x, y);
}
        // The empty tab's Tooltip.create(gui.stats.none_found).
    // rust: if tab_tip {
    // rust: let atlas = &self.gui.atlas;
    // rust: let tip = Text::translate("gui.stats.none_found", &[]);
            // Tooltip.splitTooltip: font.split(message, 170).
    // rust: ui::tooltip(batch, atlas, &atlas.font.split(&tip, 170.0), self.cursor);
}
}
pub fn draw_stats_footer(self: *Self, batch: *mut HudBatch, w: f32, h: f32) void {
}
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
}
    // rust: pub(super) fn stats_click(&mut self, size: [u32; 2]) {
        // A press on the scrollbar holds it and clicks nothing else.
    // rust: if self.stats_press_scrollbar(size) {
    // rust: return;
}
    // rust: let b = HudBatch::new(size);
    // rust: let (w, h) = (b.width, b.height);
    // rust: let (x0, tw) = tabs(w);
    // rust: for i in 0..3 {
    // rust: if ui::hovered(self.cursor, x0 + tw * i as f32, 0.0, tw, TAB_H)
    // rust: && self.stats_ui.tab != i
    // rust: && self.stats_tab_active(i)
    // rust: {
    // rust: self.stats_ui.tab = i;
    // rust: self.stats_ui.scroll.amount = 0.0;
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: return;
}
}
    // rust: if ui::hovered(
    // rust: self.cursor,
    // rust: (w / 2.0 - 100.0).floor(),
    // rust: h - FOOTER + 6.0,
    // rust: 200.0,
    // rust: 20.0,
    // rust: ) {
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: self.screen = Screen::Paused;
    // rust: return;
}
    // rust: if self.stats_ui.tab == 1 {
    // rust: let left = ((w - 280.0) / 2.0).floor();
    // rust: let y = TAB_H + 4.0 - self.stats_ui.scroll.amount;
    // rust: for c in 0..COLUMNS.len() {
    // rust: let x = left + 75.0 + 40.0 * c as f32 - 18.0;
    // rust: if ui::hovered(self.cursor, x, y + 1.0, 18.0, 18.0) {
                    // sortByColumn: descending, ascending, off.
    // rust: self.stats_ui.sort = match self.stats_ui.sort {
    // rust: Some((sc, -1)) if sc == c => Some((c, 1)),
    // rust: Some((sc, _)) if sc == c => None,
    // rust: _ => Some((c, -1)),
}
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
}
}
}
}
    // rust: pub(super) fn stats_scroll(&mut self, amount: f32) {
    // rust: let (row_h, _) = self.stats_rows();
    // rust: let h = self.gui_size().1;
    // rust: let content = self.stats_content();
    // rust: self.stats_ui
    // rust: .scroll
    // rust: .wheel(amount, row_h / 2.0, TAB_H, h - FOOTER, content);
}
    /// A press on the statistics list's scrollbar holds it
    /// (`AbstractSelectionList.updateScrolling`).
    // rust: pub(super) fn stats_press_scrollbar(&mut self, size: [u32; 2]) -> bool {
    // rust: let b = HudBatch::new(size);
    // rust: let (w, h) = (b.width, b.height);
    // rust: let content = self.stats_content();
    // rust: self.stats_ui
    // rust: .scroll
    // rust: .press(self.cursor, Self::stats_bar(w), TAB_H, h - FOOTER, content)
}
    /// The pointer moved while the scrollbar is held.
    // rust: pub(super) fn stats_drag(&mut self) {
    // rust: if !self.stats_ui.scroll.held() {
    // rust: return;
}
    // rust: let h = self.gui_size().1;
    // rust: let content = self.stats_content();
    // rust: self.stats_ui
    // rust: .scroll
    // rust: .drag(self.cursor.1, TAB_H, h - FOOTER, content);
}
    /// The button came up: the scrollbar lets go.
    // rust: pub(super) fn stats_release(&mut self) {
    // rust: self.stats_ui.scroll.release();
}
}
