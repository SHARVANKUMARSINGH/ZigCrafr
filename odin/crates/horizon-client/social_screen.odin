//! Transpiled from Horizon Rust crate
package horizon_client_social_screen

import "core:fmt"
import "core:mem"
import "core:math"

// `SocialInteractionsScreen`: the players of the server in three tabs (All, Hidden, Blocked),
// a search box, and a row for each with the button that hides or shows its chat. The
// Blocked tab and each row's report button belong to Mojang's services, which Horizon does
// not offer: the first lists no one, the second is the disabled button vanilla shows when
// reporting is off.
// use crate::{
    // rust: hud::{HudAtlas, HudBatch, rgba},
    // rust: hud_layout, tab_list,
    // rust: text::Text,
    // rust: ui,
}

TITLE :: "gui.socialInteractions.title"
// `SocialInteractionsScreen`'s page.
Page :: enum {
    All,
    Hidden,
    Blocked,
}
// One `PlayerEntry`.
Entry :: struct {
    id: u128,
    name: string,
    skin: string,
    hidden: bool,
    // Not in the level any more (`PlayerEntry.isRemoved`): a hidden player who left.
    removed: bool,
    local: bool,
}
// What the screen shows (game/social.rs fills it).
SocialView :: struct {
    page: Page,
    search: string,
    // The rows of the page, sorted and filtered as `SocialInteractionsPlayerList` does.
    entries: [dynamic]Entry,
    // `serverLabel`: the server's name and the players online.
    server_label: Text,
    scroll: f32,
}
// What a click does.
Action :: enum {
    Page(Page),
    Hide(u128),
    Show(u128),
    Done,
}

IMAGE_WIDTH :: 238.0
ROW_WIDTH :: 220.0
ITEM_HEIGHT :: 36.0
LIST_START :: 88.0
BG_FILL :: 0xFF4A4A4A
BG_FILL_REMOVED :: 0xFF303030
STATUS_COLOR :: 0x8CFFFFFF
WHITE :: u32::MAX

margin_x :: proc(w: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((w - IMAGE_WIDTH) / 2.0).floor()
}
// `windowHeight`.
window_height :: proc(h: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (h - 128.0 - 16.0).max(52.0)
}
// `listEnd`.
list_end :: proc(h: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 80.0 + window_height(h) - 8.0
}
row_left :: proc(w: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((w - ROW_WIDTH) / 2.0).floor()
}
// `SocialInteractionsPlayerList.sortPlayerEntries`: the local player first, then names that
// start with a letter, a digit or `_`, then the rest, each by name ignoring case.
sort_entries :: proc(entries: ^[Entry]) {
}
    // rust: entries.sort_by_key(|e| {
    // rust: let plain = e
    // rust: .name
    // rust: .chars()
    // rust: .next()
    // rust: .is_some_and(|c| c == '_' || c.is_ascii_alphanumeric());
    // rust: (!e.local, !plain, e.name.to_lowercase())
    // rust: });
}
// The most the list scrolls: its rows less its height.
max_scroll :: proc(h: f32, rows: uint) -> f {
    // Ported from Horizon
    return {}
}
    // `AbstractSelectionList.contentHeight`: the rows and 4px.
    // rust: (rows as f32 * ITEM_HEIGHT + 4.0 - (list_end(h) - LIST_START)).max(0.0)
}
tabs :: proc(w: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let width = (ROW_WIDTH / 3.0).floor();
    // rust: let (left, right) = (row_left(w), row_left(w) + ROW_WIDTH);
    // rust: [
    // rust: (left, Page::All),
    // rust: (((left + right - width) / 2.0 + 1.0).floor(), Page::Hidden),
    // rust: (right - width + 1.0, Page::Blocked),
    // rust: ]
}
tab_label :: proc(page: Page, selected: bool) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let key = match page {
    // rust: Page::All => "gui.socialInteractions.tab_all",
    // rust: Page::Hidden => "gui.socialInteractions.tab_hidden",
    // rust: Page::Blocked => "gui.socialInteractions.tab_blocked",
}
    // rust: let label = Text::translate(key, &[]);
    // rust: if selected { label.underlined() } else { label }
}
// A row's content rectangle (`Entry.getContentX/Y/Width/Height`: 2px in from the row), `y` the
// row's top.
row_rect :: proc(w: f32, y: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: row_left(w) + 2.0,
    // rust: y + 2.0,
    // rust: ROW_WIDTH - 4.0,
    // rust: ITEM_HEIGHT - 4.0,
    // rust: ]
}
// `PlayerEntry.extractContent`: the hide or show button, and the report button after it.
row_buttons :: proc(w: f32, y: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, width, height] = row_rect(w, y);
    // rust: let hide = [
    // rust: x + (width - 20.0 - 4.0) - 20.0 - 4.0,
    // rust: y + (height - 20.0) / 2.0,
    // rust: ];
    // rust: let report = [x + (width - 20.0 - 4.0), y + (height - 20.0) / 2.0];
    // rust: (hide, report)
}
status :: proc(e: ^Entry) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let key = match (e.hidden, e.removed) {
    // rust: (true, true) => "gui.socialInteractions.status_hidden_offline",
    // rust: (true, false) => "gui.socialInteractions.status_hidden",
    // rust: (false, true) => "gui.socialInteractions.status_offline",
    // rust: (false, false) => return None,
}
    // rust: Some(Text::translate(key, &[]).italic())
}
// The rows that show: the first one at `getY() + 2 - scroll` (`getFirstEntryY`).
visible :: proc(view: ^SocialView, h: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let end = list_end(h);
    // rust: view.entries
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(move |(i, _)| (i, LIST_START + 2.0 - view.scroll + i as f32 * ITEM_HEIGHT))
    // rust: .filter(move |&(_, y)| y + ITEM_HEIGHT > LIST_START + 4.0 && y < end)
}
// The search box's rectangle.
search_box :: proc(w: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [margin_x(w) + 28.0, 74.0, 200.0, 15.0]
}
// Done's rectangle (`HeaderAndFooterLayout`'s footer).
done :: proc(w: f32, h: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [(w / 2.0).floor() - 100.0, h - 27.0, 200.0, 20.0]
}
// What is under `cursor`, if a click would do something.
click :: proc(size: (f32) {
}
    // rust: let (w, h) = size;
    // rust: for (x, page) in tabs(w) {
    // rust: if ui::hovered(cursor, x, 45.0, (ROW_WIDTH / 3.0).floor(), 20.0) {
    // rust: return Some(Action::Page(page));
}
}
    // rust: let [dx, dy, dw, dh] = done(w, h);
    // rust: if ui::hovered(cursor, dx, dy, dw, dh) {
    // rust: return Some(Action::Done);
}
    // rust: if cursor.1 < LIST_START || cursor.1 >= list_end(h) {
    // rust: return None;
}
    // rust: for (i, y) in visible(view, h) {
    // rust: let e = &view.entries[i];
    // rust: if e.local {
    // rust: continue;
}
    // rust: let (hide, _) = row_buttons(w, y);
    // rust: if ui::hovered(cursor, hide[0], hide[1], 20.0, 20.0) {
    // rust: return Some(if e.hidden {
    // rust: Action::Show(e.id)
    // rust: } else {
    // rust: Action::Hide(e.id)
    // rust: });
}
}
    // rust: None
}
// The tooltip of what the cursor is over.
tooltip :: proc(size: (f32) {
}
    // rust: let (w, h) = size;
    // rust: if cursor.1 < LIST_START || cursor.1 >= list_end(h) {
    // rust: return None;
}
    // rust: for (i, y) in visible(view, h) {
    // rust: let e = &view.entries[i];
    // rust: if e.local {
    // rust: continue;
}
    // rust: let (hide, report) = row_buttons(w, y);
    // rust: if ui::hovered(cursor, hide[0], hide[1], 20.0, 20.0) {
    // rust: let key = if e.hidden {
    // rust: "gui.socialInteractions.tooltip.show"
    // rust: } else {
    // rust: "gui.socialInteractions.tooltip.hide"
}
    // rust: return Some(Text::translate(key, &[]));
}
    // rust: if ui::hovered(cursor, report[0], report[1], 20.0, 20.0) {
    // rust: return Some(Text::translate(
    // rust: "gui.socialInteractions.tooltip.report.disabled",
    // rust: &[],
    // rust: ));
}
}
    // rust: None
}
    // rust: pub fn draw(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: view: &SocialView,
    // rust: search: &mut ui::EditBox,
    // rust: in_world: bool,
    // rust: ) {
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, in_world);
    // rust: let title = Text::translate(TITLE, &[]);
    // rust: let tw = atlas.font.width_text(&title);
    // rust: batch.text_styled(atlas, &title, ((w - tw) / 2.0).floor(), 15.0, WHITE, true);
    // `extractBackground`: the panel and the search icon.
    // rust: let mx = margin_x(w) + 3.0;
    // rust: ui::blit_sprite(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/social_interactions/background",
    // rust: mx,
    // rust: 64.0,
    // rust: 236.0,
    // rust: window_height(h) + 16.0,
    // rust: WHITE,
    // rust: );
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: "gui/sprites/icon/search",
    // rust: mx + 10.0,
    // rust: 76.0,
    // rust: 12.0,
    // rust: 12.0,
    // rust: WHITE,
    // rust: );
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &view.server_label,
    // rust: margin_x(w) + 8.0,
    // rust: 35.0,
    // rust: WHITE,
    // rust: true,
    // rust: );
    // rust: for (x, page) in tabs(w) {
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: x,
    // rust: 45.0,
    // rust: (ROW_WIDTH / 3.0).floor(),
    // rust: 20.0,
    // rust: &tab_label(page, view.page == page),
    // rust: true,
    // rust: ui::hovered(cursor, x, 45.0, (ROW_WIDTH / 3.0).floor(), 20.0),
    // rust: );
    // rust: crate::widgets::target_as(
    // rust: [x, 45.0, (ROW_WIDTH / 3.0).floor(), 20.0],
    // rust: crate::widgets::Kind::Tab(view.page == page),
    // rust: );
}
    // The search box: an `EditBox` with the focus from the start (`setInitialFocus`), so its
    // hint, shown only while unfocused, never shows.
    // rust: let [sx, sy, sw, sh] = search_box(w);
    // rust: (search.x, search.y, search.width, search.height) = (sx, sy, sw, sh);
    // rust: search.max_length = 16;
    // rust: search.text_color = WHITE;
    // rust: search.focused = true;
    // rust: search.draw(batch, atlas, None);
    // The rows, clipped to the list. It draws no scrollbar, but a focus step still walks them.
    // rust: let max = max_scroll(h, view.entries.len());
    // rust: if max > 0.0 {
    // rust: crate::widgets::scroll_area(
    // rust: [0.0, LIST_START + 4.0, w, list_end(h) - LIST_START - 4.0],
    // rust: view.scroll,
    // rust: max,
    // rust: );
}
    // rust: let start = batch.vertices.len();
    // rust: let mut faces = Vec::new();
    // rust: for (i, y) in visible(view, h) {
    // rust: let e = &view.entries[i];
    // rust: let [x, _, width, height] = row_rect(w, y);
    // rust: let (fill, text_y) = match status(e) {
    // rust: None => (BG_FILL, y + (height - 9.0) / 2.0),
    // rust: Some(_) => (BG_FILL_REMOVED, y + (height - 18.0) / 2.0),
}
    // rust: batch.fill(atlas, x, y, width, height, fill);
    // rust: let (skin_x, skin_y) = (x + 4.0, y + ((height - 24.0) / 2.0).floor());
    // rust: tab_list::face(
    // rust: &mut faces,
    // rust: &e.skin,
    // rust: skin_x as i32,
    // rust: skin_y as i32,
    // rust: 24,
    // rust: true,
    // rust: false,
    // rust: WHITE,
    // rust: );
    // rust: if e.removed {
    // rust: faces.push(hud_layout::fill(
    // rust: skin_x as i32,
    // rust: skin_y as i32,
    // rust: skin_x as i32 + 24,
    // rust: skin_y as i32 + 24,
    // rust: 0xBE000000,
    // rust: ));
}
    // rust: let text_x = skin_x + 24.0 + 4.0;
    // rust: batch.text(atlas, &e.name, text_x, text_y.floor(), WHITE, false);
    // rust: if let Some(s) = status(e) {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &s,
    // rust: text_x,
    // rust: (text_y + 12.0).floor(),
    // rust: STATUS_COLOR,
    // rust: false,
    // rust: );
}
    // rust: if !e.local {
    // rust: let (hide, report) = row_buttons(w, y);
    // rust: let sprite = |base: &str, hover: bool| {
    // rust: format!(
    // rust: "gui/sprites/social_interactions/{base}{}",
    // rust: if hover { "_highlighted" } else { "" }
    // rust: )
}
    // rust: let hovered = |p: [f32; 2]| ui::hovered(cursor, p[0], p[1], 20.0, 20.0);
    // rust: let base = if e.hidden {
    // rust: "unmute_button"
    // rust: } else {
    // rust: "mute_button"
}
            // The button's narration (`PlayerEntry`: `narration.hide` / `narration.show`).
    // rust: let key = if e.hidden {
    // rust: "gui.socialInteractions.narration.show"
    // rust: } else {
    // rust: "gui.socialInteractions.narration.hide"
}
    // rust: crate::widgets::record(
    // rust: &Text::translate(key, &[Text::literal(e.name.clone())]).plain(),
    // rust: [hide[0], hide[1], 20.0, 20.0],
    // rust: true,
    // rust: );
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: &sprite(base, hovered(hide)),
    // rust: hide[0],
    // rust: hide[1],
    // rust: 20.0,
    // rust: 20.0,
    // rust: WHITE,
    // rust: );
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: "gui/sprites/social_interactions/report_button_disabled",
    // rust: report[0],
    // rust: report[1],
    // rust: 20.0,
    // rust: 20.0,
    // rust: WHITE,
    // rust: );
}
}
    // rust: hud_layout::paint(batch, atlas, &faces);
    // `enableScissor`: from 4px below the list's top.
    // rust: batch.clip_since(start, 0.0, LIST_START + 4.0, w, list_end(h));
    // `Done`.
    // rust: let [dx, dy, dw, dh] = done(w, h);
    // rust: ui::action_button(
    // rust: batch,
    // rust: atlas,
    // rust: crate::widgets::Action::Done,
    // rust: dx,
    // rust: dy,
    // rust: dw,
    // rust: dh,
    // rust: &Text::translate("gui.done", &[]),
    // rust: true,
    // rust: ui::hovered(cursor, dx, dy, dw, dh),
    // rust: );
    // The empty page's note, in place of the list.
    // rust: if view.entries.is_empty() {
    // rust: let key = if !view.search.is_empty() {
    // rust: Some("gui.socialInteractions.search_empty")
    // rust: } else {
    // rust: match view.page {
    // rust: Page::Hidden => Some("gui.socialInteractions.empty_hidden"),
    // rust: Page::Blocked => Some("gui.socialInteractions.empty_blocked"),
    // rust: Page::All => None,
}
}
    // rust: if let Some(key) = key {
    // rust: let note = Text::translate(key, &[]);
    // rust: let nw = atlas.font.width_text(&note);
    // rust: let y = ((72.0 + list_end(h)) / 2.0).floor();
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &note,
    // rust: ((w - nw) / 2.0).floor(),
    // rust: y,
    // rust: rgba(170, 170, 170, 255),
    // rust: true,
    // rust: );
}
}
    // rust: if let Some(text) = tooltip((w, h), cursor, view) {
    // rust: ui::tooltip(batch, atlas, &[text], cursor);
}
}

    // rust: mod tests {
//     use super::*;

entry :: proc(id: u128, name: string) -> E {
    // Ported from Horizon
    return {}
}
    // rust: Entry {
    // rust: id,
    // rust: name: name.into(),
    // rust: skin: tab_list::default_skin(id).into(),
    // rust: hidden: false,
    // rust: removed: false,
    // rust: local: false,
}
}

    // A click on a row's button hides a shown player and shows a hidden one, a click on
    // one's own row does nothing, and the tabs and Done answer where vanilla puts them.
the_buttons_answer_their_clicks :: proc() {
}
    // rust: let size = (427.0, 360.0);
    // rust: let mut me = entry(1, "Me");
    // rust: me.local = true;
    // rust: let mut hidden = entry(3, "Hidden");
    // rust: hidden.hidden = true;
    // rust: let view = SocialView {
    // rust: entries: vec![me, entry(2, "Other"), hidden],
    // rust: ..SocialView::default()
}
    // rust: let rows: Vec<_> = visible(&view, size.1).collect();
    // rust: assert_eq!(rows.len(), 3);
    // rust: let at = |i: usize| {
    // rust: let (hide, _) = row_buttons(size.0, rows[i].1);
    // rust: (hide[0] + 2.0, hide[1] + 2.0)
}
    // rust: assert_eq!(
    // rust: click(size, at(0), &view),
    // rust: None,
    // rust: "no button on one's own row"
    // rust: );
    // rust: assert_eq!(click(size, at(1), &view), Some(Action::Hide(2)));
    // rust: assert_eq!(click(size, at(2), &view), Some(Action::Show(3)));
    // rust: let tab = tabs(size.0)[1];
    // rust: assert_eq!(
    // rust: click(size, (tab.0 + 2.0, 50.0), &view),
    // rust: Some(Action::Page(Page::Hidden))
    // rust: );
    // rust: let [dx, dy, ..] = done(size.0, size.1);
    // rust: assert_eq!(click(size, (dx + 2.0, dy + 2.0), &view), Some(Action::Done));
}

    // The list scrolls by whole rows less its height, and a row scrolled out is not clickable.
the_list_scrolls_and_clips :: proc() {
}
    // rust: let h = 240.0;
    // rust: let entries: Vec<_> = (0..10).map(|i| entry(i + 1, &format!("P{i}"))).collect();
    // rust: let mut view = SocialView {
    // rust: entries,
    // rust: ..SocialView::default()
}
    // rust: let shown = visible(&view, h).count();
    // rust: assert!(shown < 10, "ten rows do not fit {h}");
    // rust: let max = max_scroll(h, 10);
    // rust: assert!(max > 0.0 && max < 10.0 * ITEM_HEIGHT);
    // rust: view.scroll = max;
    // rust: let last = visible(&view, h).last().unwrap().0;
    // rust: assert_eq!(last, 9, "scrolled to the end shows the last row");
    // rust: let first = visible(&view, h).next().unwrap();
    // rust: let (hide, _) = row_buttons(427.0, first.1);
        // A cursor above the list's top does not reach a row's button.
    // rust: assert_eq!(click((427.0, h), (hide[0] + 2.0, 30.0), &view), None);
}

rows_sort_as_the_list_does :: proc() {
}
    // rust: let entry = |name: &str, local: bool| Entry {
    // rust: id: 0,
    // rust: name: name.into(),
    // rust: skin: String::new(),
    // rust: hidden: false,
    // rust: removed: false,
    // rust: local,
}
    // rust: let mut rows = vec![
    // rust: entry("zed", false),
    // rust: entry("Alpha", false),
    // rust: entry("§odd", false),
    // rust: entry("me", true),
    // rust: entry("_x", false),
    // rust: ];
    // rust: sort_entries(&mut rows);
    // rust: let names: Vec<_> = rows.iter().map(|e| e.name.as_str()).collect();
    // rust: assert_eq!(names, ["me", "_x", "Alpha", "zed", "§odd"]);
}
}
