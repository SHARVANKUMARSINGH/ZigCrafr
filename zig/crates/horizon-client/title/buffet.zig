//! Transpiled from Horizon Rust crate
//! Module: horizon-client_buffet
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! CreateBuffetWorldScreen: the single-biome preset's biome list with its
//! search box, and the Done and Cancel that hand a biome back to Create New
//! World (`WorldCreationUiState.updateDimensions`).
// use super::{Button, Title};
// use crate::{
    // rust: hud::{HudAtlas, HudBatch},
    // rust: lang,
    // rust: text::Text,
    // rust: ui,
}
// use serde_json::Value;
// use std::path::Path;

/// The search box's text field, for the caret, selection and clipboard.
    // rust: pub(super) const SEARCH: crate::clipboard::FieldId = ("world.buffet-search", 0);
/// HeaderAndFooterLayout's header: the title's font line, 13 above it, the
/// 15-pixel search box 3 under it.
pub const HEADER: f32 = 40.0;
/// HeaderAndFooterLayout's default footer.
pub const FOOTER: f32 = 33.0;
/// The header's search box (`new EditBox(font, 200, 15, ...)`).
pub const SEARCH_WIDTH: f32 = 200.0;
pub const SEARCH_HEIGHT: f32 = 15.0;
/// The search box's top: 13 + the title's 9-pixel line + 3.
pub const SEARCH_TOP: f32 = 25.0;
/// `ObjectSelectionList`'s row: 220 wide and the list's default 20 high.
pub const ROW_WIDTH: f32 = 220.0;
pub const ROW_HEIGHT: f32 = 20.0;

/// One biome the screen offers: its registry id and the name it shows
/// (`Component.translatable(id.toLanguageKey("biome"))`, else the id).
    // rust: pub(super) struct Biome {
    // rust: pub(super) id: String,
    // rust: pub(super) name: String,
}

/// CreateBuffetWorldScreen's state: the biomes the prepared worldgen data
/// holds, the search text, and the biome the overworld will be made of.
pub const State = struct {
    /// `EditBox`'s text: the rows whose name contains it, case-folded.
    // rust: pub(super) query: String,
    // rust: pub(super) query_focused: bool,
    /// The fixed biome (`CreateBuffetWorldScreen.biome`): plains until the
    /// world says otherwise, and what `write_world_gen_settings` writes.
    // rust: pub(super) biome: String,
    // rust: pub(super) scroll: ui::Scroll,
    biomes: std.ArrayList(Biome),
};
    // rust: impl State {
    /// The screen over `biome`, the biome the selected preset fixes, with the
    /// biomes of the prepared resource root.
    // rust: pub(super) fn new(root: &Path, biome: &str) -> Self {
    // rust: Self {
    // rust: query: String::new(),
    // rust: query_focused: false,
    // rust: biome: biome.to_owned(),
    // rust: scroll: ui::Scroll::default(),
    // rust: biomes: load(root),
}
}
    /// The biome the world will be made of, for the control socket's state.
pub fn biome(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.biome
}
    /// The search text, for the control socket's state.
pub fn query(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.query
}
    /// The rows the search text leaves, in the order the list shows them.
    // rust: pub(super) fn rows(&self) -> Vec<usize> {
    // rust: let query = self.query.to_lowercase();
    // rust: self.biomes
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, biome)| query.is_empty() || biome.name.to_lowercase().contains(&query))
    // rust: .map(|(index, _)| index)
    // rust: .collect()
}
    /// The selected row, while the search text still shows the biome.
    // rust: pub(super) fn selected(&self) -> Option<usize> {
    // rust: self.rows()
    // rust: .iter()
    // rust: .position(|index| self.biomes[*index].id == self.biome)
}
pub fn name(self: *Self, row: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.biomes.get(row).map(|biome| biome.name.as_str())
}
pub fn select(self: *Self, row: usize) void {
}
    // rust: if let Some(biome) = self.biomes.get(row) {
    // rust: self.biome = biome.id.clone();
}
}
}
/// The biome registry of the prepared resources, by the name each is shown
/// under: `Registry.listElements` sorted with a locale collator, which for
/// these names is a case-insensitive order with the id breaking ties.
pub fn load(root: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Ok(text) = std::fs::read_to_string(root.join("worldgen/biomes.json")) else {
    // rust: return Vec::new();
}
    // rust: let Ok(value) = serde_json::from_str::<Value>(&text) else {
    // rust: return Vec::new();
}
    // rust: let mut biomes: Vec<Biome> = value
    // rust: .as_object()
    // rust: .map(|entries| {
    // rust: entries
    // rust: .keys()
    // rust: .map(|id| Biome {
    // rust: id: id.clone(),
    // rust: name: display_name(id),
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: biomes.sort_by_cached_key(|biome| (biome.name.to_lowercase(), biome.id.clone()));
    // rust: biomes
}
/// `Identifier.toLanguageKey("biome")`: `biome.<namespace>.<path>` with the
/// path's separators turned into dots. An id the language has no name for is
/// shown as it is, as `CreateBuffetWorldScreen$BiomeList$Entry` does.
pub fn display_name(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (namespace, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: let key = format!("biome.{namespace}.{}", path.replace(['/', '.'], "."));
    // rust: if lang::has(&key) {
    // rust: Text::translate(&key, &[]).plain()
    // rust: } else {
    // rust: id.to_owned()
}
}
/// The list's area: under the header, above the footer, `ROW_WIDTH` wide in
/// the middle of the screen.
pub fn list_area(size: (f32) void {
}
    // rust: let (w, h) = (size.0.ceil(), size.1.ceil());
    // rust: (
    // rust: HEADER,
    // rust: h - FOOTER,
    // rust: ((w - ROW_WIDTH) * 0.5).floor(),
    // rust: rows as f32 * ROW_HEIGHT + 4.0,
    // rust: )
}
    // rust: pub(super) fn search_box(w: f32) -> [f32; 4] {
    // rust: [
    // rust: ((w - SEARCH_WIDTH) * 0.5).floor(),
    // rust: SEARCH_TOP,
    // rust: SEARCH_WIDTH,
    // rust: SEARCH_HEIGHT,
    // rust: ]
}
/// The row under the pointer, if any (`getEntryAtPosition`).
pub fn row_at(state: *State, cursor: (f32) void {
}
    // rust: let rows = state.rows();
    // rust: let (top, bottom, left, _) = list_area(size, rows.len());
    // rust: if cursor.0 < left || cursor.0 >= left + ROW_WIDTH || cursor.1 < top || cursor.1 >= bottom {
    // rust: return None;
}
    // rust: let row = ((cursor.1 - top + state.scroll.amount.trunc()) / ROW_HEIGHT) as usize;
    // rust: rows.get(row).copied()
}
/// A press on the screen: the search box, the list, or the scrollbar.
    // rust: pub(super) fn click(state: &mut State, cursor: (f32, f32), size: (f32, f32)) {
    // rust: let rows = state.rows();
    // rust: let (top, bottom, left, content) = list_area(size, rows.len());
    // rust: let field = search_box(size.0.ceil());
    // rust: state.query_focused = ui::hovered(cursor, field[0], field[1], field[2], field[3]);
    // rust: if state
    // rust: .scroll
    // rust: .press(cursor, left + ROW_WIDTH + 6.0, top, bottom, content)
    // rust: {
    // rust: return;
}
    // rust: if let Some(row) = row_at(state, cursor, size) {
    // rust: state.select(row);
}
}
/// The focus landed on the row at `cursor`: it is selected, and the search box no longer has the
/// keys. Whether a row was there.
    // rust: pub(super) fn focus_row(state: &mut State, cursor: (f32, f32), size: (f32, f32)) -> bool {
    // rust: let Some(row) = row_at(state, cursor, size) else {
    // rust: return false;
}
    // rust: state.query_focused = false;
    // rust: state.select(row);
    // rust: true
}
    // rust: pub(super) fn wheel(state: &mut State, delta: f32, cursor: (f32, f32), size: (f32, f32)) {
    // rust: let rows = state.rows();
    // rust: let (top, bottom, _, content) = list_area(size, rows.len());
    // rust: if cursor.1 < top || cursor.1 >= bottom {
    // rust: return;
}
    // rust: state.scroll.wheel(delta, ROW_HEIGHT, top, bottom, content);
}
    // rust: pub(super) fn drag(state: &mut State, cursor: (f32, f32), size: (f32, f32)) {
    // rust: let rows = state.rows();
    // rust: let (top, bottom, _, content) = list_area(size, rows.len());
    // rust: state.scroll.drag(cursor.1, top, bottom, content);
}
    // rust: pub(super) fn release(state: &mut State) {
    // rust: state.scroll.release();
}
/// Done and Cancel, 150 wide and 8 apart in the footer
/// (`LinearLayout.horizontal().spacing(8)`); Done needs a biome.
    // rust: pub(super) fn buttons(w: f32, h: f32, state: &State) -> Vec<Button> {
    // rust: let x = ((w.ceil() - 308.0) * 0.5).trunc();
    // rust: let b = |x: f32, key: &str, fallback: &str, enabled: bool, id: u8| Button {
    // rust: x,
    // rust: y: h.ceil() - 27.0,
    // rust: w: 150.0,
    // rust: label: lang::get_or(key, fallback),
    // rust: enabled,
    // rust: id,
    // rust: icon: None,
    // rust: trailing: None,
    // rust: action: None,
}
    // rust: vec![
    // rust: b(x, "gui.done", "Done", state.selected().is_some(), 80).does(crate::widgets::Action::Done),
    // rust: b(x + 158.0, "gui.cancel", "Cancel", true, 81).does(crate::widgets::Action::Cancel),
    // rust: ]
}
/// The screen: the menu background, the title, the search box and the rows.
    // rust: pub(super) fn draw(
    // rust: title: &Title,
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: cursor: (f32, f32),
    // rust: state: &State,
    // rust: ) {
    // rust: let (w, h) = (batch.width.ceil(), batch.height.ceil());
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: super::centered(
    // rust: atlas,
    // rust: batch,
    // rust: &lang::get_or(
    // rust: "createWorld.customize.buffet.title",
    // rust: "Single Biome Customization",
    // rust: ),
    // rust: 8.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let field = search_box(w);
    // rust: let focused = state.query_focused;
    // rust: title.caret.borrow_mut().draw(
    // rust: batch,
    // rust: atlas,
    // rust: (SEARCH, &state.query, 50),
    // rust: field,
    // rust: focused,
    // rust: title.started,
    // rust: );
    // rust: crate::widgets::name_last_edit_box(|| {
    // rust: lang::get_or("createWorld.customize.buffet.search", "Search...")
    // rust: });
    // rust: if state.query.is_empty() && !focused {
    // rust: let box_ = ui::EditBox::new(field[0], field[1], field[2], field[3]);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &Text::translate("createWorld.customize.buffet.search", &[])
    // rust: .with_color(crate::text::DARK_GRAY),
    // rust: box_.text_x(),
    // rust: box_.text_y(),
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: let rows = state.rows();
    // rust: let (top, bottom, left, content) = list_area((w, h), rows.len());
    // rust: ui::list_background(batch, atlas, top, bottom, false);
    // rust: crate::ui::separators(batch, atlas, top, bottom, false);
    // rust: let first = batch.vertices.len();
    // rust: let offset = state.scroll.amount.trunc();
    // rust: let selected = state.selected();
    // rust: let hovered = row_at(state, cursor, (w, h))
    // rust: .and_then(|biome| rows.iter().position(|index| *index == biome));
    // ObjectSelectionList: every row narrates "narrator.select" with its name.
    // rust: crate::widgets::narratable(|| {
//         use crate::widgets::{ListKind, Narratable, Row};
    // rust: let row = |at: usize| {
    // rust: let name = rows.get(at).and_then(|index| state.name(*index));
    // rust: let narration = Text::translate(
    // rust: "narrator.select",
    // rust: &[Text::literal(name.unwrap_or_default())],
    // rust: )
    // rust: .plain();
    // rust: Row::new(at, narration)
}
    // rust: Narratable::list(
    // rust: ListKind::Object,
    // rust: rows.len(),
    // rust: hovered.map(row),
    // rust: selected.map(row),
    // rust: [left, top, ROW_WIDTH, bottom - top],
    // rust: )
    // rust: .key(crate::widgets::key_of(&"create_world/buffet"))
    // rust: });
    // rust: for (at, index) in rows.iter().enumerate() {
    // rust: let y = top + 2.0 + at as f32 * ROW_HEIGHT - offset;
    // rust: let target = [left, y - 2.0, ROW_WIDTH, ROW_HEIGHT];
    // rust: if let Some(name) = state.name(*index) {
    // rust: super::flat::row_target(name, target, top, bottom);
}
    // rust: if selected == Some(at) {
    // rust: batch.fill(
    // rust: atlas,
    // rust: target[0],
    // rust: target[1],
    // rust: target[2],
    // rust: target[3],
    // rust: crate::hud::rgba(255, 255, 255, 70),
    // rust: );
    // rust: } else if hovered == Some(at) {
    // rust: batch.fill(
    // rust: atlas,
    // rust: target[0],
    // rust: target[1],
    // rust: target[2],
    // rust: target[3],
    // rust: crate::hud::rgba(255, 255, 255, 25),
    // rust: );
}
        // `Entry.extractContent`: the name at contentX + 5, contentY + 2.
    // rust: if let Some(biome) = state.biomes.get(*index) {
    // rust: batch.text(atlas, &biome.name, left + 5.0, y, u32::MAX, true);
}
}
    // rust: batch.clip_since(first, left, top, left + ROW_WIDTH, bottom);
    // rust: ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: left + ROW_WIDTH + 6.0,
    // rust: top,
    // rust: bottom,
    // rust: content,
    // rust: state.scroll.amount,
    // rust: );
}
