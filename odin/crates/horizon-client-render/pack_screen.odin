//! Transpiled from Horizon Rust crate
package horizon_client_render_pack_screen

import "core:fmt"
import "core:mem"
import "core:math"

// The resource pack screen (`PackSelectionScreen` with its two
// `TransferableSelectionList`s, search box and buttons) and the
// `ConfirmScreen` an incompatible pack opens, as vanilla's state machine:
// clicks, the mouse wheel and typing change the selection model, the lists'
// entries, scroll, selection and focus as the vanilla widgets do, and
// [`PackScreen::draw`] gives the screen's GUI calls. The game shows it;
// tools/test_pack_screen_parity.py compares it with vanilla.
// use crate::{
    // rust: font::Patch,
    // rust: hud::{HudAtlas, PACK_ICON_SIZE, PACK_ICON_SLOTS},
    // rust: packs::{Position, Selectable, SelectionModel},
    // rust: screen_draw::{self as d, Backdrop, Draw, Measure, TextField},
    // rust: text::{Style, Text},
}
// use std::{collections::HashMap, sync::Arc};

// `PackCompatibility`.
Compat :: enum {
    Compatible,
    TooOld,
    TooNew,
    Unknown,
}

    // rust: impl Compat {
key :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Compat::TooOld => "old",
    // rust: Compat::TooNew => "new",
    // rust: Compat::Unknown => "unknown",
    // rust: Compat::Compatible => "compatible",
}
}
}
// `PackSource`: how the description is decorated.
Source :: enum {
    Default,
    BuiltIn,
    Feature,
    World,
    Server,
}

// A pack as the screen shows it.
PackInfo :: struct {
    id: string,
    title: Text,
    description: Text,
    // The description component's own (root) style.
    description_style: Style,
    source: Source,
    compat: Compat,
    // The pack's `pack.png` ([`load_icon`]); none draws `unknown_pack`.
    icon: Maybe(^[u8]),
    required: bool,
    position: Position,
    fixed: bool,
}
    // rust: impl PackInfo {
selectable :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Selectable {
    // rust: id: self.id.clone(),
    // rust: required: self.required,
    // rust: position: self.position,
    // rust: fixed: self.fixed,
    // rust: compatible: self.compat == Compat::Compatible,
}
}
    // `PackSource.decorate` merged with the entry's grey
    // (`getExtendedDescription`, `ComponentUtils.mergeStyles`), and the style of
    // its root, which the ellipsis of a cut description takes.
extended_description :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let gray = Style::color(0x808080);
    // rust: let key = match self.source {
    // rust: Source::Default => {
    // rust: let mut root = self.description_style.clone();
    // rust: root.inherit(&gray);
    // rust: return (self.description.clone().with_style(&gray), root);
}
    // rust: Source::BuiltIn => "pack.source.builtin",
    // rust: Source::Feature => "pack.source.feature",
    // rust: Source::World => "pack.source.world",
    // rust: Source::Server => "pack.source.server",
}
    // rust: let t = Text::translate(
    // rust: "pack.nameAndSource",
    // rust: &[self.description.clone(), Text::translate(key, &[])],
    // rust: )
    // rust: .with_color(d::GRAY);
    // rust: (t, Style::color(d::GRAY))
}
}
// A `pack.png` as the pack screen draws it: RGBA, stretched to a
// `PACK_ICON_SIZE` square by nearest texels, as vanilla's icon texture is
// sampled into its 32x32 square. None when it does not decode, where
// `loadPackIcon` falls back to `unknown_pack`.
load_icon :: proc(png: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: scale_icon(crate::hud::decode_bytes(png).ok()?)
}
// A project icon Modrinth served (PNG, WebP or JPEG,
// [`crate::hud::decode_image_bytes`]), scaled as [`load_icon`] scales a pack's.
load_fetched_icon :: proc(bytes: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: scale_icon(crate::hud::decode_image_bytes(bytes).ok()?)
}
scale_icon :: proc() {
}
    // rust: if w == 0 || h == 0 {
    // rust: return None;
}
    // rust: let size = u64::from(PACK_ICON_SIZE);
    // rust: let mut out = Vec::with_capacity((size * size * 4) as usize);
    // rust: for y in 0..size {
    // rust: let sy = ((2 * y + 1) * u64::from(h) / (2 * size)) as usize;
    // rust: for x in 0..size {
    // rust: let sx = ((2 * x + 1) * u64::from(w) / (2 * size)) as usize;
    // rust: let at = (sy * w as usize + sx) * 4;
    // rust: out.extend_from_slice(&rgba[at..at + 4]);
}
}
    // rust: Some(out.into())
}
// `PackSelectionScreen.loadPackIcon`'s texture for a pack with an icon.
icon_texture :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let sanitized: String = id
    // rust: .to_lowercase()
    // rust: .chars()
    // rust: .map(|c| {
    // rust: if c.is_ascii_lowercase() || c.is_ascii_digit() || "_-./".contains(c) {
    // rust: c
    // rust: } else {
    // rust: '_'
}
    // rust: })
    // rust: .collect();
    // rust: let bytes: Vec<u8> = id.encode_utf16().flat_map(u16::to_le_bytes).collect();
    // rust: let hash: String = crate::skins::sha1(&bytes)
    // rust: .iter()
    // rust: .map(|b| format!("{b:02x}"))
    // rust: .collect();
    // rust: format!("pack/{sanitized}/{hash}/icon")
}

Row :: enum {
    Header,
    Pack(String),
}
Entry :: struct {
    row: Row,
    y: i32,
    height: i32,
}
// A `TransferableSelectionList`.
List :: struct {
    selected_side: bool,
    x: i32,
    y: i32,
    width: i32,
    height: i32,
    scroll: f64,
    entries: [dynamic]Entry,
    // `getSelected`, an index into `entries`.
    selected: Maybe(uint),
    // The list has a focused child (possibly an entry it no longer holds).
    focused: bool,
    // The pointer's last y while the scrollbar is held (`scrolling`).
    held: Maybe(f64),
}
    // rust: impl List {
new :: proc(selected_side: bool, height: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: selected_side,
    // rust: x: 0,
    // rust: y: 33,
    // rust: width: 200,
    // rust: height,
    // rust: scroll: 0.0,
    // rust: entries: Vec::new(),
    // rust: selected: None,
    // rust: focused: false,
    // rust: held: None,
}
}
bottom :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.y + self.height
}
row_left :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.x + self.width / 2 - self.row_width() / 2
}
row_width :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.width - 4
}
content_height :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.entries.iter().map(|e| e.height).sum::<i32>() + 4
}
max_scroll :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (self.content_height() - self.height).max(0)
}
scrollable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.max_scroll() > 0
}
    // `TransferableSelectionList.Entry.getWidth`.
entry_width :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.row_width() - if self.scrollable() { 6 } else { 0 }
}
next_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.y + 2 - self.scroll as i32 + self.entries.iter().map(|e| e.height).sum::<i32>()
}
add :: proc(self: ^Self, row: Row, height: i32) {
}
    // rust: let y = self.next_y();
    // rust: self.entries.push(Entry { row, y, height });
}
reposition :: proc(self: ^Self) {
}
    // rust: let mut y = self.y + 2 - self.scroll as i32;
    // rust: for e in &mut self.entries {
    // rust: e.y = y;
    // rust: y += e.height;
}
}
set_scroll :: proc(self: ^Self, v: f64) {
}
    // rust: self.scroll = v.clamp(0.0, self.max_scroll() as f64);
    // rust: self.reposition();
}
scroll_to :: proc(self: ^Self, i: uint) {
}
    // rust: let e = &self.entries[i];
    // rust: let top = e.y - self.y - 2;
    // rust: if top < 0 {
    // rust: self.set_scroll(self.scroll + top as f64);
}
    // rust: let e = &self.entries[i];
    // rust: let bottom = self.bottom() - e.y - e.height - 2;
    // rust: if bottom < 0 {
    // rust: self.set_scroll(self.scroll - bottom as f64);
}
}
set_selected :: proc(self: ^Self, i: Maybe(uint)) {
}
    // rust: self.selected = i;
    // rust: if let Some(i) = i {
    // rust: let e = &self.entries[i];
    // rust: let top = e.y + 2 < self.y;
    // rust: let bottom = e.y + 2 + e.height - 4 > self.bottom();
    // rust: if top || bottom {
    // rust: self.scroll_to(i);
}
}
}
update_size :: proc(self: ^Self, width: i32, height: i32, x: i32, y: i32) {
}
    // rust: self.width = width;
    // rust: self.height = height;
    // rust: self.x = x;
    // rust: self.y = y;
    // rust: self.reposition();
    // rust: if let Some(i) = self.selected {
    // rust: self.scroll_to(i);
}
    // rust: self.set_scroll(self.scroll);
}
is_over :: proc(self: ^Self, x: f64, y: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: x >= self.x as f64
    // rust: && y >= self.y as f64
    // rust: && x < (self.x + self.width) as f64
    // rust: && y < self.bottom() as f64
}
    // `getEntryAtPosition`.
entry_at :: proc(self: ^Self, x: i32, y: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (left, w) = (self.row_left(), self.entry_width());
    // rust: self.entries
    // rust: .iter()
    // rust: .position(|e| x >= left && x < left + w && y >= e.y && y < e.y + e.height)
}
scroll_bar_x :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.x + self.width - 6
}
scroller_height :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: ((self.height * self.height) as f32 / self.content_height() as f32) as i32
}
    // `AbstractScrollArea.mouseDragged` while the scrollbar is held.
drag :: proc(self: ^Self, y: f64) {
}
    // rust: let Some(last) = self.held else { return };
    // rust: if y < self.y as f64 {
    // rust: self.set_scroll(0.0);
    // rust: } else if y > self.bottom() as f64 {
    // rust: self.set_scroll(self.max_scroll() as f64);
    // rust: } else {
    // rust: let max = self.max_scroll().max(1) as f64;
    // rust: let bar = self.scroller_height().clamp(32, self.height - 8);
    // rust: let scale = (max / (self.height - bar) as f64).max(1.0);
    // rust: self.set_scroll(self.scroll + (y - last) * scale);
}
    // rust: self.held = Some(y);
}
}

Focus :: enum {
    None,
    Search,
    List(usize),
    // Open Pack Folder (0) or Done (1).
    Button(usize),
}

// The open `ConfirmScreen` for an incompatible pack.
Confirm :: struct {
    id: string,
    title: Text,
    message: Text,
}

// What a click on the screen asks the game to do.
Action :: enum {
    None,
    // The Open Pack Folder button.
    OpenFolder,
    // The Done button (`onClose`: commit).
    Done,
    // Horizon's own: a Modrinth hit the player picked, to download into the
    // packs folder. The screen does not know where that is.
    BrowsePick(usize),
}

// The pack screen and its state.
PackScreen :: struct {
    // `resourcePack.title`, or `dataPack.title` from Create World.
    title: Text,
    width: i32,
    height: i32,
    in_world: bool,
    packs: [dynamic]PackInfo,
    model: SelectionModel,
    search: TextField,
    focus: Focus,
    // 0: available, 1: selected.
    lists: [List,
    confirm: Maybe(Confirm),
    // The selection changed since the screen opened.
    changed: bool,
    // The packs' icons by their [`icon_texture`], and the browser's.
    icons: HashMap<string,
    // Horizon's own Add button and its Modrinth list, when the player has
    // turned `packBrowser` on. Off, the screen stays vanilla's exactly
    // (tools/test_pack_screen_parity.py).
    browser: Maybe(crate::pack_browser::Browser),
    // Which backdrop this screen wants drawn behind it this frame
    // ([`Backdrop`]). Vanilla's own pack screen never asks for one.
    backdrop: Backdrop,
    // The `icons` keys that came from the browser rather than from an
    // installed pack. Each decoded icon is `PACK_ICON_SIZE` squared in RGBA
    // (64 KiB), and a search brings twenty, so without this they piled up in
    // `icons` for the rest of the session: every search added twenty more
    // and none were ever freed.
    browser_icons: [dynamic]string,
    // Whether that button is drawn at all.
    browsing_allowed: bool,
    // The browser's own search box, separate from the one that filters the
    // player's installed packs.
    browser_search: TextField,
    // The browser's search box has the keyboard.
    browser_focus: bool,
}

tr :: proc(key: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate(key, &[])
}

// The Add button is square. The button sprite is a nine-slice built for a
// height of 20; drawn shorter, neither it nor its label sits right, so the
// button keeps that height and is centred on the shorter search box.
ADD_SIZE :: 20
// A card in the grid: its icon beside its name, author and description.
ROW_H :: 74
// The air around a card's contents.
CARD_PAD :: 6
// The sidebar of filters down the left.
SIDEBAR_W :: 108
// The bar across the top holding Back and the search box.
TOPBAR_H :: 30
// A filter row in the sidebar.
FILTER_H :: 15
// The panels' colours, dark over whatever is behind them.
PANEL :: 0xF0_14_17_22u32 as i32
CARD :: 0xFF_1E_22_30u32 as i32
CARD_HOVER :: 0xFF_2A_30_42u32 as i32
SIDEBAR_BG :: 0xFF_10_12_1Bu32 as i32
// The Install button: Modrinth's green, dimmed once a pack is in.
GREEN :: 0xFF_1B_D9_6Au32 as i32
GREEN_HOVER :: 0xFF_3B_E8_85u32 as i32
INSTALLED_GREEN :: 0xFF_2A_5E_3Fu32 as i32
GREEN_EDGE :: 0xFF_0E_7A_3Cu32 as i32
// The icon drawn at the left of a row.
ICON :: 34
// The browser's search box and the button beside it.
BROWSER_SEARCH_W :: 200
SEARCH_BTN_W :: 56
// The Back and Install buttons.
BACK_W :: 60
BACK_H :: 20
INSTALL_W :: 70

    // rust: impl PackScreen {
    // `PackSelectionScreen.init`: the lists filled, the search box focused.
    // rust: pub fn new(
    // rust: m: &Measure,
    // rust: title: Text,
    // rust: width: i32,
    // rust: height: i32,
    // rust: in_world: bool,
    // rust: packs: Vec<PackInfo>,
    // rust: selected: &[String],
    // rust: ) -> Self {
    // rust: let model = SelectionModel::new(packs.iter().map(PackInfo::selectable).collect(), selected);
    // rust: let mut search = TextField::new(0, 0, 200, 15);
    // rust: search.hint = Some(tr("gui.packSelection.search").with_style(&Style {
    // rust: color: Some(d::GRAY),
    // rust: italic: Some(true),
    // rust: ..Style::default()
    // rust: }));
    // rust: let icons = packs
    // rust: .iter()
    // rust: .filter_map(|p| Some((icon_texture(&p.id), p.icon.clone()?)))
    // rust: .collect();
    // rust: let mut s = Self {
    // rust: title,
    // rust: width,
    // rust: height,
    // rust: in_world,
    // rust: packs,
    // rust: icons,
    // rust: model,
    // rust: search,
    // rust: focus: Focus::None,
    // rust: lists: [List::new(false, height - 66), List::new(true, height - 66)],
    // rust: confirm: None,
    // rust: browser: None,
    // rust: browsing_allowed: false,
    // rust: backdrop: Backdrop::None,
    // rust: browser_icons: Vec::new(),
    // rust: browser_search: {
    // rust: let mut field = TextField::new(0, 0, BROWSER_SEARCH_W, 18);
    // rust: field.hint = Some(tr("horizon.pack.searchHint").with_style(&Style {
    // rust: color: Some(d::GRAY),
    // rust: italic: Some(true),
    // rust: ..Style::default()
    // rust: }));
    // rust: field
    // rust: },
    // rust: browser_focus: false,
    // rust: changed: false,
}
    // rust: s.reposition(m);
    // rust: s.populate(None);
    // rust: s.set_focus(Focus::Search);
    // rust: s
}
info :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.packs.iter().find(|p| p.id == id)
}
    // The header layout: title, drop info and search box, centred.
header :: proc(self: ^Self, m: ^Measure) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let tw = m.width(&self.title);
    // rust: let dw = m.width(&tr("pack.dropInfo"));
    // rust: let col = tw.max(dw).max(200);
    // rust: let frame = self.width.max(col);
    // rust: let lx = (0.5 * (frame - col) as f32) as i32;
    // rust: let cell = |w: i32| lx + (0.5 * (col - w) as f32) as i32;
    // rust: [(cell(tw), 4), (cell(dw), 17), (cell(200), 30)]
}
    // The footer's two buttons.
footer :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let frame = self.width.max(308);
    // rust: let x = (0.5 * (frame - 308) as f32) as i32;
    // rust: let y = self.height - 33 + (0.5f32 * 13.0).round() as i32;
    // rust: [(x, y), (x + 158, y)]
}
    // `repositionElements`.
reposition :: proc(self: ^Self, m: ^Measure) {
}
    // rust: let (sx, sy) = self.header(m)[2];
    // rust: self.search.x = sx;
    // rust: self.search.y = sy;
    // rust: let content = self.height - 49 - 33;
    // rust: let w = self.width;
    // rust: self.lists[0].update_size(200, content, w / 2 - 15 - 200, 49);
    // rust: self.lists[1].update_size(200, content, w / 2 + 15, 49);
}
    // `AbstractContainerEventHandler.setFocused` on the screen.
set_focus :: proc(self: ^Self, f: Focus) {
}
    // rust: if self.focus == f {
    // rust: return;
}
    // rust: match self.focus {
    // rust: Focus::Search => self.search.focused = false,
    // rust: Focus::List(i) => self.lists[i].focused = false,
    // rust: Focus::None | Focus::Button(_) => {}
}
    // rust: if f == Focus::Search {
    // rust: self.search.focused = true;
}
    // rust: self.focus = f;
}
shown :: proc(self: ^Self, side: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let value = self.search.value.to_lowercase();
    // rust: let blank = self.search.value.trim().is_empty()
    // rust: && self.search.value.chars().all(char::is_whitespace);
    // rust: let list = if side == 1 {
    // rust: &self.model.selected
    // rust: } else {
    // rust: &self.model.unselected
}
    // rust: list.iter()
    // rust: .filter(|p| {
    // rust: blank
    // rust: || p.id.to_lowercase().contains(&value)
    // rust: || self.info(&p.id).is_some_and(|i| {
    // rust: i.title.plain().to_lowercase().contains(&value)
    // rust: || i.description.plain().to_lowercase().contains(&value)
    // rust: })
    // rust: })
    // rust: .map(|p| p.id.clone())
    // rust: .collect()
}
    // `TransferableSelectionList.updateList`.
update_list :: proc(self: ^Self, side: uint, ids: [dynamic]string, transferred: Maybe(string)) {
}
    // rust: let l = &mut self.lists[side];
    // rust: l.entries.clear();
    // rust: l.selected = None;
    // rust: l.add(Row::Header, 13);
    // rust: l.set_selected(None);
    // rust: for id in ids {
    // rust: let hit = transferred == Some(id.as_str());
    // rust: self.lists[side].add(Row::Pack(id), 36);
    // rust: if hit {
    // rust: self.set_focus(Focus::List(side));
    // rust: let l = &mut self.lists[side];
    // rust: l.focused = true;
    // rust: let i = l.entries.len() - 1;
    // rust: l.set_selected(Some(i));
}
}
    // rust: let l = &mut self.lists[side];
    // rust: l.set_scroll(l.scroll);
}
    // `populateLists`: both lists, then again through the search filter.
populate :: proc(self: ^Self, transferred: Maybe(string)) {
}
    // rust: let all = |m: &SelectionModel, side: bool| -> Vec<String> {
    // rust: (if side { &m.selected } else { &m.unselected })
    // rust: .iter()
    // rust: .map(|p| p.id.clone())
    // rust: .collect()
}
    // rust: self.update_list(1, all(&self.model, true), transferred);
    // rust: self.update_list(0, all(&self.model, false), transferred);
    // rust: self.filter(transferred);
}
    // `updateFilteredEntries`.
filter :: proc(self: ^Self, transferred: Maybe(string)) {
}
    // rust: let (sel, avail) = (self.shown(1), self.shown(0));
    // rust: self.update_list(1, sel, transferred);
    // rust: self.update_list(0, avail, transferred);
}
    // The pack's index in its model list.
model_index :: proc(self: ^Self, side: uint, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let list = if side == 1 {
    // rust: &self.model.selected
    // rust: } else {
    // rust: &self.model.unselected
}
    // rust: list.iter().position(|p| p.id == id)
}
flags :: proc(self: ^Self, side: uint, id: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let Some(i) = self.model_index(side, id) else {
    // rust: return (false, false, false, false);
}
    // rust: let s = side == 1;
    // rust: (
    // rust: self.model.can_select(s, i),
    // rust: self.model.can_unselect(s, i),
    // rust: self.model.can_move_up(s, i),
    // rust: self.model.can_move_down(s, i),
    // rust: )
}
overlay :: proc(self: ^Self, id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.info(id).is_none_or(|p| !p.fixed || !p.required)
}

    // Whether a left click activates a footer or confirmation button.
    // Pack entries and the search field do not play widget click sounds.
button_at :: proc(self: ^Self, m: ^Measure, x: f64, y: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let buttons = if let Some(c) = &self.confirm {
    // rust: self.confirm_layout(m, c).2
    // rust: } else {
    // rust: self.footer()
}
    // rust: buttons.into_iter().any(|(bx, by)| {
    // rust: x >= bx as f64 && y >= by as f64 && x < (bx + 150) as f64 && y < (by + 20) as f64
    // rust: })
}
    // A left click (`Screen.mouseClicked`).
click :: proc(self: ^Self, m: ^Measure, x: f64, y: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: if self.confirm.is_some() {
    // rust: return self.confirm_click(m, x, y);
}
    // rust: if let Some(action) = self.browser_click(m, x, y) {
    // rust: return action;
}
    // rust: if self.search.contains(x, y) {
    // rust: self.search.click(m, x, false);
    // rust: self.set_focus(Focus::Search);
    // rust: return Action::None;
}
    // rust: for side in 0..2 {
    // rust: if !self.lists[side].is_over(x, y) {
    // rust: continue;
}
    // rust: let l = &self.lists[side];
    // rust: let scrolling = l.scrollable()
    // rust: && x >= l.scroll_bar_x() as f64
    // rust: && x <= (l.scroll_bar_x() + 6) as f64
    // rust: && y >= l.y as f64
    // rust: && y < l.bottom() as f64;
            // updateScrolling: a press on the scroller holds it.
    // rust: if scrolling {
    // rust: self.lists[side].held = Some(y);
    // rust: self.set_focus(Focus::List(side));
    // rust: return Action::None;
}
    // rust: let l = &self.lists[side];
    // rust: let hit = l.entry_at(x as i32, y as i32);
    // rust: let mut took = false;
    // rust: if let Some(i) = hit {
    // rust: took = true;
    // rust: match l.entries[i].row.clone() {
    // rust: Row::Header => {
    // rust: let l = &mut self.lists[side];
    // rust: l.focused = true;
    // rust: l.set_selected(Some(i));
}
    // rust: Row::Pack(id) => {
    // rust: let current = self.entry_click(m, side, i, &id, x as i32, y as i32);
    // rust: if self.lists[side]
    // rust: .entries
    // rust: .iter()
    // rust: .any(|e| e.row == Row::Pack(id.clone()))
    // rust: {
    // rust: let l = &mut self.lists[side];
    // rust: l.focused = true;
    // rust: if current {
    // rust: l.set_selected(Some(i));
}
}
}
}
}
    // rust: if took {
    // rust: self.set_focus(Focus::List(side));
}
    // rust: return Action::None;
}
    // rust: for (i, (bx, by)) in self.footer().into_iter().enumerate() {
    // rust: if x >= bx as f64 && y >= by as f64 && x < (bx + 150) as f64 && y < (by + 20) as f64 {
    // rust: self.set_focus(Focus::Button(i));
    // rust: return if i == 0 {
    // rust: Action::OpenFolder
    // rust: } else {
    // rust: Action::Done
}
}
}
    // rust: Action::None
}
    // `PackEntry.mouseClicked`; true when the entry clicked is still the
    // list's own (nothing was repopulated).
    // rust: fn entry_click(
    // rust: &mut self,
    // rust: m: &Measure,
    // rust: side: usize,
    // rust: i: usize,
    // rust: id: &str,
    // rust: x: i32,
    // rust: y: i32,
    // rust: ) -> bool {
    // rust: if !self.overlay(id) {
    // rust: return true;
}
    // rust: let e = &self.lists[side].entries[i];
    // rust: let (cx, cy) = (self.lists[side].row_left() + 2, e.y + 2);
    // rust: let (rx, ry) = (x - cx, y - cy);
    // rust: let (sel, unsel, up, down) = self.flags(side, id);
    // rust: let icon = (0..32).contains(&rx) && (0..32).contains(&ry);
    // rust: let left = (0..16).contains(&rx) && (0..32).contains(&ry);
    // rust: let top_right = (16..32).contains(&rx) && (0..16).contains(&ry);
    // rust: let bottom_right = (16..32).contains(&rx) && (16..32).contains(&ry);
    // rust: let index = self.model_index(side, id).unwrap_or(0);
    // rust: let s = side == 1;
    // rust: if sel && icon {
    // rust: if self
    // rust: .info(id)
    // rust: .is_some_and(|p| p.compat != Compat::Compatible)
    // rust: {
    // rust: self.open_confirm(id);
    // rust: return true;
}
    // rust: self.model.activate(s, index, true);
    // rust: } else if unsel && left {
    // rust: self.model.activate(s, index, false);
    // rust: } else if up && top_right {
    // rust: self.model.move_by(s, index, true);
    // rust: } else if down && bottom_right {
    // rust: self.model.move_by(s, index, false);
    // rust: } else {
    // rust: return true;
}
    // rust: self.changed = true;
    // rust: self.populate(Some(id));
    // rust: let _ = m;
    // rust: false
}
    // `handlePackSelection` of an incompatible pack: the ConfirmScreen
    // (the pack screen loses its focus as `Gui.setScreen` clears it).
open_confirm :: proc(self: ^Self, id: string) {
}
    // rust: let compat = self.info(id).map_or(Compat::Unknown, |p| p.compat);
    // rust: self.set_focus(Focus::None);
    // rust: for l in &mut self.lists {
    // rust: l.focused = false;
}
    // rust: self.confirm = Some(Confirm {
    // rust: id: id.to_owned(),
    // rust: title: tr("pack.incompatible.confirm.title"),
    // rust: message: tr(&format!("pack.incompatible.confirm.{}", compat.key())),
    // rust: });
}
    // The ConfirmScreen's layout: title, message lines and the two buttons.
    // rust: fn confirm_layout(
    // rust: &self,
    // rust: m: &Measure,
    // rust: c: &Confirm,
    // rust: ) -> ((i32, i32), (Vec<(Text, i32)>, i32, i32), [(i32, i32); 2]) {
    // rust: let max = self.width - 50;
    // rust: let lines = d::label_lines(m, &c.message, max, 15, &Style::default());
    // rust: let mw = d::label_width(&lines, max);
    // rust: let mh = lines.len() as i32 * 9;
    // rust: let tw = m.width(&c.title);
    // rust: let col = tw.max(mw).max(304);
    // rust: let total = 9 + 8 + mh + 8 + 36;
    // rust: let lx = (0.5 * (self.width - col) as f32) as i32;
    // rust: let ly = (0.5 * (self.height - total) as f32) as i32;
    // rust: let cell = |w: i32| lx + (0.5 * (col - w) as f32) as i32;
    // rust: let by = ly + 9 + 8 + mh + 8 + 16;
    // rust: let bx = cell(304);
    // rust: (
    // rust: (cell(tw), ly),
    // rust: (lines, cell(mw), ly + 17),
    // rust: [(bx, by), (bx + 154, by)],
    // rust: )
}
confirm_click :: proc(self: ^Self, m: ^Measure, x: f64, y: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let Some(c) = self.confirm.clone() else {
    // rust: return Action::None;
}
    // rust: let (_, _, buttons) = self.confirm_layout(m, &c);
    // rust: for (i, (bx, by)) in buttons.into_iter().enumerate() {
    // rust: if x >= bx as f64 && y >= by as f64 && x < (bx + 150) as f64 && y < (by + 20) as f64 {
                // The callback: back to the pack screen (repositioned), then select.
    // rust: self.confirm = None;
    // rust: self.reposition(m);
    // rust: if i == 0
    // rust: && let Some(index) = self.model_index(0, &c.id)
    // rust: {
    // rust: self.model.activate(false, index, true);
    // rust: self.changed = true;
    // rust: self.populate(Some(&c.id));
}
    // rust: return Action::None;
}
}
    // rust: Action::None
}
    // The focus, the lists' rows, scroll and selection (for debugging).
debug :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "{:?} {:?}",
    // rust: self.focus,
    // rust: self.lists
    // rust: .iter()
    // rust: .map(|l| (
    // rust: l.scroll,
    // rust: l.selected,
    // rust: l.focused,
    // rust: l.entries.iter().map(|e| e.y).collect::<Vec<_>>()
    // rust: ))
    // rust: .collect::<Vec<_>>()
    // rust: )
}
    // Whether the confirmation screen is shown.
confirming :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.confirm.is_some()
}
    // Escape on the confirmation screen answers no.
cancel_confirm :: proc(self: ^Self, m: ^Measure) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.confirm.take().is_some() {
    // rust: self.reposition(m);
    // rust: return true;
}
    // rust: false
}
    // The mouse wheel (`AbstractScrollArea.mouseScrolled`).
    // The pointer moved with the button held: a held scrollbar follows it.
drag :: proc(self: ^Self, y: f64) {
}
    // rust: for l in &mut self.lists {
    // rust: l.drag(y);
}
}
    // `onRelease`.
release :: proc(self: ^Self) {
}
    // rust: for l in &mut self.lists {
    // rust: l.held = None;
}
}
scroll :: proc(self: ^Self, x: f64, y: f64, amount: f64) {
}
    // rust: if self.confirm.is_some() || self.search.contains(x, y) {
    // rust: return;
}
    // rust: for l in &mut self.lists {
    // rust: if l.is_over(x, y) {
    // rust: l.set_scroll(l.scroll - amount * 18.0);
    // rust: return;
}
}
}
    // Typed text, when the search box has the focus.
type_text :: proc(self: ^Self, m: ^Measure, s: string) {
}
    // rust: if self.browser.is_some() {
    // rust: self.browser_search.insert_text(m, s);
    // rust: return;
}
    // rust: if self.confirm.is_none() && self.focus == Focus::Search && self.search.insert_text(m, s) {
    // rust: self.filter(None);
}
}
    // Ctrl+A/C/V/X in the search box; false when it does not have the focus.
    // rust: pub fn shortcut(
    // rust: &mut self,
    // rust: m: &Measure,
    // rust: shortcut: crate::clipboard::EditShortcut,
    // rust: clipboard: &mut dyn crate::clipboard::Clipboard,
    // rust: ) -> bool {
    // rust: if !self.search_focused() {
    // rust: return false;
}
    // rust: if self.search.shortcut(m, shortcut, clipboard) {
    // rust: self.filter(None);
}
    // rust: true
}
    // Backspace in the search box.
erase :: proc(self: ^Self, m: ^Measure, count: int) {
}
    // rust: if self.browser.is_some() {
    // rust: self.browser_search.delete_chars(m, -count);
    // rust: return;
}
    // rust: if self.confirm.is_none()
    // rust: && self.focus == Focus::Search
    // rust: && self.search.delete_chars(m, -count)
    // rust: {
    // rust: self.filter(None);
}
}
    // Keeps a browser icon, remembering it so [`Self::release_browser_icons`]
    // can free it again. The installed packs' own icons are not touched.
keep_browser_icon :: proc(self: ^Self, key: string, icon: ^[u8]) {
}
    // rust: if self.icons.insert(key.clone(), icon).is_none() {
    // rust: self.browser_icons.push(key);
}
}
    // Frees every icon the browser downloaded. Called when it closes: the
    // pack lists behind it never drew these.
release_browser_icons :: proc(self: ^Self) {
}
    // rust: for key in self.browser_icons.drain(..) {
    // rust: self.icons.remove(&key);
}
    // rust: self.icons.shrink_to_fit();
}
    // Runs the browser's search on what is typed in its box. The screen
    // calls this for the Search button and for Enter.
browser_submit :: proc(self: ^Self) {
}
    // rust: let query = self.browser_search.value.clone();
    // rust: if let Some(browser) = &mut self.browser {
    // rust: browser.query = query;
    // rust: browser.search();
}
}
    // Whether the browser's own search box has the keyboard, so the game
    // sends it typing rather than treating it as a hotkey.
browser_typing :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
        // The browser has one text field, so it always takes typing. Clearing
        // it on a click elsewhere made typing after picking a filter or a card
        // go nowhere, and Search then submitted stale text.
    // rust: self.browser.is_some()
}
search_focused :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
        // The browser's own box counts: the game routes typing by this.
    // rust: self.browser_typing() || (self.confirm.is_none() && self.focus == Focus::Search)
}
    // Resize (`Screen.init` on a new size: `repositionElements`).
resize :: proc(self: ^Self, m: ^Measure, width: i32, height: i32) {
}
    // rust: self.width = width;
    // rust: self.height = height;
    // rust: self.reposition(m);
}
    // `PackSelectionModel.commit`: the selection as options.txt stores it.
commit :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.model.commit()
}
    // Points the icon blits of `draws` at the atlas's pack icon slots and
    // writes the icons into them, one slot per icon drawn (vanilla registers a
    // texture per pack). Icons past the last slot keep `unknown_pack`.
bind_icons :: proc(self: ^Self, draws: ^[Draw], atlas: ^HudAtlas, patches: ^[dynamic]Patch) {
}
    // rust: let mut slots = 0..PACK_ICON_SLOTS;
    // rust: for draw in draws {
    // rust: let Draw::Blit { texture, .. } = draw else {
    // rust: continue;
}
    // rust: let Some(icon) = self.icons.get(texture.as_str()) else {
    // rust: continue;
}
    // rust: let Some(slot) = slots.next() else {
    // rust: return;
}
    // rust: let sprite = format!("horizon/pack-icon{slot}");
    // rust: let Some(rect) = atlas.sprites.get(&sprite) else {
    // rust: return;
}
    // rust: patches.push(Patch {
    // rust: x: (rect.u0 * atlas.width as f32).round() as u32,
    // rust: y: (rect.v0 * atlas.height as f32).round() as u32,
    // rust: width: PACK_ICON_SIZE,
    // rust: height: PACK_ICON_SIZE,
    // rust: rgba: icon.to_vec(),
    // rust: });
    // rust: *texture = sprite;
}
}

    // The shown screen's calls (`Screen.extractRenderState`); `blink_ms`
    // is the time since the search box took the focus.
draw :: proc(self: ^Self, m: ^Measure, mouse: (i32) {
}
    // rust: let mut out = Vec::new();
        // PackSelectionScreen, or the ConfirmScreen over it (its title and
        // its message).
    // rust: crate::widgets::begin_screen(|| match &self.confirm {
    // rust: Some(c) => crate::widgets::ScreenInfo::new(
    // rust: "packs/confirm",
    // rust: crate::widgets::join_for_narration(&[&c.title.plain(), &c.message.plain()]),
    // rust: ),
    // rust: None => crate::widgets::ScreenInfo::new("packs", self.title.plain()),
    // rust: });
    // rust: if let Some(c) = &self.confirm {
    // rust: let ((tx, ty), (lines, mx, my), buttons) = self.confirm_layout(m, c);
    // rust: d::string_widget(&mut out, m, &c.title, tx, ty, 0);
    // rust: d::label(&mut out, &lines, mx, my, self.width - 50, true);
    // rust: for ((bx, by), key) in buttons.into_iter().zip(["gui.yes", "gui.no"]) {
    // rust: let hover = d::inside(mouse, bx, by, 150, 20);
    // rust: crate::widgets::widget_cursor(hover, true);
    // rust: d::button(&mut out, m, &tr(key), bx, by, 150, 20, true, hover, now_ms);
}
    // rust: return out;
}
    // rust: let [(tx, ty), (dx, dy), _] = self.header(m);
    // rust: d::string_widget(&mut out, m, &self.title, tx, ty, 0);
    // rust: d::string_widget(
    // rust: &mut out,
    // rust: m,
    // rust: &tr("pack.dropInfo").with_color(d::GRAY),
    // rust: dx,
    // rust: dy,
    // rust: 0,
    // rust: );
    // rust: self.search.draw(&mut out, m, blink_ms, None);
    // rust: for side in 0..2 {
    // rust: self.draw_list(&mut out, m, side, mouse);
}
    // rust: self.draw_footer(
    // rust: &mut out,
    // rust: m,
    // rust: mouse,
    // rust: now_ms,
    // rust: [&tr("pack.openFolder"), &tr("gui.done")],
    // rust: );
    // rust: self.draw_browser(&mut out, m, mouse, now_ms);
    // rust: out
}
    // The Add button and the screen it opens. `None` leaves the click to
    // the vanilla screen beneath.
browser_click :: proc(self: ^Self, m: ^Measure, x: f64, y: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.browsing_allowed {
    // rust: return None;
}
    // rust: let point = (x as i32, y as i32);
    // rust: if self.browser.is_some() {
    // rust: let (bx, by) = self.back_button();
    // rust: if d::inside(point, bx, by, BACK_W, BACK_H) {
    // rust: self.browser = None;
    // rust: self.browser_focus = false;
                // Back to the vanilla pack screen, which wants no backdrop.
    // rust: self.backdrop = Backdrop::None;
    // rust: self.release_browser_icons();
    // rust: return Some(Action::None);
}
    // rust: let (qx, qy) = self.browser_search_box();
    // rust: if d::inside(point, qx, qy, BROWSER_SEARCH_W, 18) {
    // rust: self.browser_search.x = qx;
    // rust: self.browser_search.y = qy;
    // rust: self.browser_search.click(m, x, false);
    // rust: self.browser_focus = true;
    // rust: return Some(Action::None);
}
    // rust: let (sx2, sy2) = self.browser_search_button();
    // rust: if d::inside(point, sx2, sy2, SEARCH_BTN_W, 18) {
    // rust: self.browser_submit();
    // rust: return Some(Action::None);
}
    // rust: for i in 0..crate::pack_browser::FILTERS.len() as i32 {
    // rust: let (fx, fy, fw, fh) = self.filter_box(i);
    // rust: if d::inside(point, fx, fy, fw, fh) {
    // rust: let query = self.browser_search.value.clone();
    // rust: if let Some(browser) = &mut self.browser {
    // rust: if !browser.filters.insert(i as usize) {
    // rust: browser.filters.remove(&(i as usize));
}
                        // A filter is only meaningful once it is searched on.
    // rust: browser.query = query;
    // rust: browser.search();
}
    // rust: return Some(Action::None);
}
}
    // rust: let fits = self.browser_row_count();
    // rust: let busy = self.browser.as_ref().is_some_and(|b| b.busy);
    // rust: let hits = self.browser.as_ref().map_or(0, |b| b.hits.len() as i32);
    // rust: for i in 0..hits.min(fits) {
    // rust: let (ix, iy) = self.install_button(i);
    // rust: if d::inside(point, ix, iy, INSTALL_W, BACK_H) {
    // rust: if busy {
    // rust: return Some(Action::None);
}
    // rust: return Some(Action::BrowsePick(i as usize));
}
}
            // The screen is modal: nothing beneath it takes the click.
    // rust: return Some(Action::None);
}
    // rust: let (bx, by) = self.add_button(m);
    // rust: if d::inside(point, bx, by, ADD_SIZE, ADD_SIZE) {
    // rust: let mut browser = crate::pack_browser::Browser::new();
            // Opens on the text already in the search box, so a player who
            // searched their own packs first keeps the term; it is then the
            // browser's box that carries it.
    // rust: browser.query = self.search.value.clone();
    // rust: browser.search();
    // rust: self.browser_search.set_value(m, &self.search.value);
    // rust: self.browser_focus = true;
    // rust: self.browser = Some(browser);
            // Horizon's own screen, so it may ask for the menu panorama.
    // rust: self.backdrop = Backdrop::Panorama;
    // rust: return Some(Action::None);
}
    // rust: None
}
    // The Back button, top left of the browser.
back_button :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (8, 8)
}
    // The browser's search box and the button beside it.
browser_search_box :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let total = BROWSER_SEARCH_W + 4 + SEARCH_BTN_W;
    // rust: let left = BACK_W + 16;
    // rust: let centred = (self.width - total) / 2;
    // rust: (centred.max(left), 5)
}
browser_search_button :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (x, y) = self.browser_search_box();
    // rust: (x + BROWSER_SEARCH_W + 4, y)
}
    // The Install button of row `i`.
install_button :: proc(self: ^Self, i: i32) -> ( {
    // Ported from Horizon
    return {}
}
        // Top right, beside the name. It used to sit bottom right, where the
        // description ran under it.
    // rust: let (cx, cy, cw, _) = self.card_box(i);
    // rust: (cx + cw - INSTALL_W - CARD_PAD, cy + CARD_PAD)
}
    // The browser's content column: centred, and never wider than it reads
    // comfortably.
browser_area :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let x = SIDEBAR_W + 6;
    // rust: let top = TOPBAR_H + 6;
    // rust: let w = (self.width - x - 6).max(120);
    // rust: let h = (self.height - top - 6).max(ROW_H);
    // rust: (x, top, w, h)
}
    // Two columns where there is room for them, otherwise one.
browser_columns :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let (_, _, w, _) = self.browser_area();
    // rust: if w >= 360 { 2 } else { 1 }
}
    // The card at `i`: its box in the grid.
card_box :: proc(self: ^Self, i: i32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (px, py, pw, _) = self.browser_area();
    // rust: let cols = self.browser_columns();
    // rust: let cw = (pw - 6 * (cols - 1)) / cols;
    // rust: let (cx, cy) = (i % cols, i / cols);
    // rust: (px + cx * (cw + 6), py + cy * (ROW_H + 6), cw, ROW_H)
}
    // The filter row `i` in the sidebar.
filter_box :: proc(self: ^Self, i: i32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (6, TOPBAR_H + 18 + i * FILTER_H, SIDEBAR_W - 12, FILTER_H)
}
    // How many rows fit the column.
browser_row_count :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let (_, _, _, ph) = self.browser_area();
    // rust: (((ph + 6) / (ROW_H + 6)) * self.browser_columns()).max(0)
}
    // Horizon's Add button, and the screen it opens. Nothing is drawn
    // unless the player turned `packBrowser` on, so the screen's vanilla
    // parity is untouched by default.
draw_browser :: proc(self: ^Self, out: ^[dynamic]Draw, m: ^Measure, mouse: (i32) {
}
    // rust: if !self.browsing_allowed {
    // rust: return;
}
    // rust: let Some(browser) = &self.browser else {
    // rust: let (bx, by) = self.add_button(m);
    // rust: let hover = d::inside(mouse, bx, by, ADD_SIZE, ADD_SIZE);
    // rust: d::button(
    // rust: out,
    // rust: m,
    // rust: &tr("horizon.pack.add"),
    // rust: bx,
    // rust: by,
    // rust: ADD_SIZE,
    // rust: ADD_SIZE,
    // rust: true,
    // rust: hover,
    // rust: now_ms,
    // rust: );
    // rust: if hover {
    // rust: d::tooltip(out, m, &tr("horizon.pack.addInfo"), mouse);
}
    // rust: return;
}
        // Modal and opaque: vanilla's own menu background tiled over the
        // whole screen, then a wash, so none of the pack lists shows through.
    // rust: d::sprite(out, "gui/menu_background", 0, 0, self.width, self.height);
    // rust: d::fill(out, 0, 0, self.width, self.height, PANEL);
        // The sidebar of filters, and the bar across the top.
    // rust: d::fill(out, 0, 0, SIDEBAR_W, self.height, SIDEBAR_BG);
    // rust: d::fill(out, 0, 0, self.width, TOPBAR_H, SIDEBAR_BG);
    // rust: let (bx, by) = self.back_button();
    // rust: let back_hover = d::inside(mouse, bx, by, BACK_W, BACK_H);
    // rust: crate::widgets::declare_action(
    // rust: crate::widgets::Action::Back,
    // rust: [bx as f32, by as f32, BACK_W as f32, BACK_H as f32],
    // rust: true,
    // rust: );
    // rust: d::button(
    // rust: out,
    // rust: m,
    // rust: &tr("gui.back"),
    // rust: bx,
    // rust: by,
    // rust: BACK_W,
    // rust: BACK_H,
    // rust: true,
    // rust: back_hover,
    // rust: now_ms,
    // rust: );
        // The search row: its box and the button that runs it.
    // rust: let (qx, qy) = self.browser_search_box();
    // rust: let mut field = self.browser_search.clone();
    // rust: field.x = qx;
    // rust: field.y = qy;
    // rust: field.draw(out, m, 0, None);
    // rust: let (sbx, sby) = self.browser_search_button();
    // rust: d::button(
    // rust: out,
    // rust: m,
    // rust: &tr("horizon.pack.search"),
    // rust: sbx,
    // rust: sby,
    // rust: SEARCH_BTN_W,
    // rust: 18,
    // rust: !browser.busy,
    // rust: d::inside(mouse, sbx, sby, SEARCH_BTN_W, 18),
    // rust: now_ms,
    // rust: );
        // The sidebar's heading and its filters.
    // rust: let heading = tr("horizon.pack.filters").with_style(&Style {
    // rust: bold: Some(true),
    // rust: ..Style::default()
    // rust: });
    // rust: d::string_widget(out, m, &heading, 6, TOPBAR_H + 5, 0);
    // rust: for (i, (key, _, _)) in crate::pack_browser::FILTERS.iter().enumerate() {
    // rust: let i = i as i32;
    // rust: let (fx, fy, fw, fh) = self.filter_box(i);
    // rust: let on = browser.filters.contains(&(i as usize));
    // rust: let hover = d::inside(mouse, fx, fy, fw, fh);
    // rust: if hover {
    // rust: d::fill(out, fx - 2, fy - 1, fx + fw + 2, fy + fh - 1, CARD_HOVER);
}
            // A small box, filled when the filter is on.
    // rust: d::fill(out, fx, fy, fx + 7, fy + 7, 0xFF_44_4C_63u32 as i32);
    // rust: if on {
    // rust: d::fill(out, fx + 1, fy + 1, fx + 6, fy + 6, 0xFF_6C_C6_4Bu32 as i32);
}
    // rust: let label = tr(key).with_color(if on { d::WHITE as u32 } else { d::GRAY });
    // rust: d::string_widget(out, m, &label, fx + 11, fy - 1, 0);
}
    // rust: let (px, py, pw, ph) = self.browser_area();
    // rust: let message = if browser.busy && browser.installing.is_none() {
    // rust: Some(tr("horizon.pack.addWorking"))
    // rust: } else if let Some(status) = &browser.status {
    // rust: Some(Text::translate(
    // rust: "horizon.pack.addFailed",
    // rust: &[Text::literal(status.clone())],
    // rust: ))
    // rust: } else if browser.hits.is_empty() {
    // rust: Some(tr("horizon.pack.addNone"))
    // rust: } else {
    // rust: None
}
    // rust: if let Some(message) = message {
    // rust: let lines = d::label_lines(
    // rust: m,
    // rust: &message.with_color(d::GRAY),
    // rust: pw - 8,
    // rust: 6,
    // rust: &Style::default(),
    // rust: );
    // rust: d::label(out, &lines, px + 4, py + 20, pw - 8, true);
    // rust: return;
}
    // rust: let fits = self.browser_row_count();
    // rust: for (i, hit) in browser.hits.iter().enumerate() {
    // rust: let i = i as i32;
    // rust: if i >= fits {
    // rust: break;
}
    // rust: let (cx, cy, cw, ch) = self.card_box(i);
    // rust: if cy + ch > py + ph {
    // rust: break;
}
    // rust: let over = d::inside(mouse, cx, cy, cw, ch);
    // rust: d::fill(
    // rust: out,
    // rust: cx,
    // rust: cy,
    // rust: cx + cw,
    // rust: cy + ch,
    // rust: if over { CARD_HOVER } else { CARD },
    // rust: );
            // The icon, once one has arrived: `bind_icons` swaps the texture
            // for the atlas slot it patched the PNG into.
    // rust: let texture = icon_texture(&hit.id);
    // rust: if self.icons.contains_key(&texture) {
    // rust: out.push(Draw::Blit {
    // rust: texture,
    // rust: x: cx + CARD_PAD,
    // rust: y: cy + CARD_PAD,
    // rust: w: ICON,
    // rust: h: ICON,
    // rust: u: 0.0,
    // rust: v: 0.0,
    // rust: src: [PACK_ICON_SIZE as i32, PACK_ICON_SIZE as i32],
    // rust: tex: [PACK_ICON_SIZE as i32, PACK_ICON_SIZE as i32],
    // rust: color: d::WHITE,
    // rust: });
}
            // The name and author sit in the column between the icon and
            // the Install button; the description runs the card's full width
            // under both, so no two of them can overlap.
    // rust: let text_x = cx + CARD_PAD + ICON + CARD_PAD;
    // rust: let text_w = (cx + cw - CARD_PAD - INSTALL_W - CARD_PAD - text_x).max(20);
    // rust: let name = d::label_lines(
    // rust: m,
    // rust: &Text::literal(hit.title.clone()).with_style(&Style {
    // rust: bold: Some(true),
    // rust: ..Style::default()
    // rust: }),
    // rust: text_w,
    // rust: 1,
    // rust: &Style::default(),
    // rust: );
    // rust: d::label(out, &name, text_x, cy + CARD_PAD + 1, text_w, false);
    // rust: if !hit.author.is_empty() {
    // rust: let author = d::label_lines(
    // rust: m,
    // rust: &Text::literal(hit.author.clone()).with_color(d::GRAY),
    // rust: text_w,
    // rust: 1,
    // rust: &Style::default(),
    // rust: );
    // rust: d::label(out, &author, text_x, cy + CARD_PAD + 12, text_w, false);
}
    // rust: let body_w = (cw - 2 * CARD_PAD).max(20);
    // rust: let lines = d::label_lines(
    // rust: m,
    // rust: &Text::literal(hit.description.clone()).with_color(d::GRAY),
    // rust: body_w,
    // rust: 2,
    // rust: &Style::default(),
    // rust: );
            // Below the icon, which is the tallest thing in the top row.
    // rust: d::label(
    // rust: out,
    // rust: &lines,
    // rust: cx + CARD_PAD,
    // rust: cy + CARD_PAD + ICON + 5,
    // rust: body_w,
    // rust: false,
    // rust: );
    // rust: let (ix, iy) = self.install_button(i);
    // rust: let done = browser.installed.contains(&(i as usize));
    // rust: let running = browser.installing == Some(i as usize);
    // rust: let label = if done {
    // rust: tr("horizon.pack.installed")
    // rust: } else if running {
    // rust: tr("horizon.pack.installing")
    // rust: } else {
    // rust: tr("horizon.pack.install")
}
            // Drawn rather than the vanilla button sprite, so it can be the
            // green the design asks for.
    // rust: let hovered = d::inside(mouse, ix, iy, INSTALL_W, BACK_H);
    // rust: let face = if done {
    // rust: INSTALLED_GREEN
    // rust: } else if hovered && !browser.busy {
    // rust: GREEN_HOVER
    // rust: } else {
    // rust: GREEN
}
    // rust: d::fill(out, ix, iy, ix + INSTALL_W, iy + BACK_H, GREEN_EDGE);
    // rust: d::fill(
    // rust: out,
    // rust: ix + 1,
    // rust: iy + 1,
    // rust: ix + INSTALL_W - 1,
    // rust: iy + BACK_H - 1,
    // rust: face,
    // rust: );
    // rust: let lw = m.width(&label);
    // rust: d::string_widget(
    // rust: out,
    // rust: m,
    // rust: &label,
    // rust: ix + (INSTALL_W - lw) / 2,
    // rust: iy + (BACK_H - 8) / 2,
    // rust: 0,
    // rust: );
}
}
    // The Add button, just right of the search box.
add_button :: proc(self: ^Self, m: ^Measure) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (sx, sy) = self.header(m)[2];
        // The search box is 15 tall: centre the taller button on it.
    // rust: (sx + 204, sy - (ADD_SIZE - 15) / 2)
}
    // The footer's two buttons, "Open Pack Folder" and "Done", over their
    // labels; a label wider than its button scrolls with the clock.
    // rust: fn draw_footer(
    // rust: &self,
    // rust: out: &mut Vec<Draw>,
    // rust: m: &Measure,
    // rust: mouse: (i32, i32),
    // rust: now_ms: i64,
    // rust: labels: [&Text; 2],
    // rust: ) {
    // rust: for (i, ((bx, by), label)) in self.footer().into_iter().zip(labels).enumerate() {
    // rust: let hover = d::inside(mouse, bx, by, 150, 20);
            // The cursor follows the mouse; the highlight also keyboard focus.
    // rust: crate::widgets::widget_cursor(hover, true);
    // rust: if i == 1 && self.browser.is_none() {
    // rust: crate::widgets::declare_action(
    // rust: crate::widgets::Action::Done,
    // rust: [bx as f32, by as f32, 150.0, 20.0],
    // rust: true,
    // rust: );
}
    // rust: d::button(
    // rust: out,
    // rust: m,
    // rust: label,
    // rust: bx,
    // rust: by,
    // rust: 150,
    // rust: 20,
    // rust: true,
    // rust: hover || self.focus == Focus::Button(i),
    // rust: now_ms,
    // rust: );
    // rust: if i == 0 {
    // rust: crate::widgets::last_narratable(|n| {
    // rust: n.hint = Some(tr("pack.folderInfo").plain());
    // rust: });
}
    // rust: if i == 0 && hover {
    // rust: d::tooltip(out, m, &tr("pack.folderInfo"), mouse);
}
}
}
draw_list :: proc(self: ^Self, out: ^[dynamic]Draw, m: ^Measure, side: uint, mouse: (i32) {
}
    // rust: let l = &self.lists[side];
    // rust: let hovered = if l.is_over(mouse.0 as f64, mouse.1 as f64) {
    // rust: l.entry_at(mouse.0, mouse.1)
    // rust: } else {
    // rust: None
}
    // rust: let header = if l.selected_side {
    // rust: "pack.selected.title"
    // rust: } else {
    // rust: "pack.available.title"
}
        // TransferableSelectionList: the row under the mouse, else the
        // selected one; the header narrates its title, a pack "Selected:
        // <title>".
    // rust: crate::widgets::narratable(|| {
//             use crate::widgets::{ListKind, Narratable, Row as Narrated};
    // rust: let narrated = |i: usize| {
    // rust: let text = match &l.entries[i].row {
    // rust: Row::Header => tr(header).plain(),
    // rust: Row::Pack(id) => {
    // rust: let title = self
    // rust: .info(id)
    // rust: .map_or_else(|| Text::literal(id.clone()), |p| p.title.clone());
    // rust: Text::translate("narrator.select", &[title]).plain()
}
}
    // rust: Narrated::new(i, text)
}
    // rust: Narratable::list(
    // rust: ListKind::Object,
    // rust: l.entries.len(),
    // rust: hovered.map(narrated),
    // rust: l.selected.filter(|i| *i < l.entries.len()).map(narrated),
    // rust: [l.x as f32, l.y as f32, l.width as f32, l.height as f32],
    // rust: )
    // rust: .key(crate::widgets::key_of(&("packs", side)))
    // rust: .focused(l.focused)
    // rust: });
    // rust: let prefix = if self.in_world { "inworld_" } else { "" };
    // rust: let right = l.x + l.width;
    // rust: d::blit(
    // rust: out,
    // rust: &format!("textures/gui/{prefix}menu_list_background.png"),
    // rust: l.x,
    // rust: l.y,
    // rust: (right as f32, (l.bottom() + l.scroll as i32) as f32),
    // rust: l.width,
    // rust: l.height,
    // rust: [32, 32],
    // rust: );
    // rust: out.push(Draw::Scissor {
    // rust: x0: l.x.clamp(0, self.width),
    // rust: y0: l.y.clamp(0, self.height),
    // rust: x1: right.clamp(0, self.width),
    // rust: y1: l.bottom().clamp(0, self.height),
    // rust: });
    // rust: let (left, w) = (l.row_left(), l.entry_width());
    // rust: let narrow = if l.scrollable() { 6 } else { 0 };
    // rust: for (i, e) in l.entries.iter().enumerate() {
    // rust: if e.y + e.height < l.y || e.y > l.bottom() {
    // rust: continue;
}
    // rust: if l.selected == Some(i) {
    // rust: let color = if l.focused { -1 } else { -8355712 };
    // rust: d::fill(out, left, e.y, left + w, e.y + e.height, color);
    // rust: d::fill(
    // rust: out,
    // rust: left + 1,
    // rust: e.y + 1,
    // rust: left + w - 1,
    // rust: e.y + e.height - 1,
    // rust: -16777216,
    // rust: );
}
    // rust: let (cx, cy) = (left + 2, e.y + 2);
    // rust: match &e.row {
    // rust: Row::Header => {
    // rust: let t = tr(header).with_style(&Style {
    // rust: underlined: Some(true),
    // rust: bold: Some(true),
    // rust: ..Style::default()
    // rust: });
    // rust: let tw = m.width(&t);
    // rust: d::text(
    // rust: out,
    // rust: t,
    // rust: left + w / 2 - tw / 2,
    // rust: cy + (e.height - 4) / 2 - 4,
    // rust: -1,
    // rust: true,
    // rust: );
}
    // rust: Row::Pack(id) => {
    // rust: let Some(p) = self.info(id) else { continue };
    // rust: if p.compat != Compat::Compatible {
    // rust: d::fill(
    // rust: out,
    // rust: cx - 1,
    // rust: cy - 1,
    // rust: cx + w - 4 + 1,
    // rust: cy + e.height - 4 + 1,
    // rust: -8978432,
    // rust: );
}
    // rust: let icon = if p.icon.is_some() {
    // rust: icon_texture(id)
    // rust: } else {
    // rust: "textures/misc/unknown_pack.png".into()
}
    // rust: d::blit(out, &icon, cx, cy, (0.0, 0.0), 32, 32, [32, 32]);
    // rust: let (mut name, (mut desc, mut desc_style)) =
    // rust: (p.title.clone(), p.extended_description());
    // rust: let focus_hover = l.selected == Some(i) && l.focused;
    // rust: if self.overlay(id) && (hovered == Some(i) || focus_hover) {
    // rust: d::fill(out, cx, cy, cx + 32, cy + 32, -1601138544);
    // rust: let (rx, ry) = (mouse.0 - cx, mouse.1 - cy);
    // rust: if p.compat != Compat::Compatible {
    // rust: name = tr("pack.incompatible");
    // rust: desc = tr(&format!("pack.incompatible.{}", p.compat.key()))
    // rust: .with_color(d::GRAY);
    // rust: desc_style = Style::color(d::GRAY);
}
    // rust: let (sel, unsel, up, down) = self.flags(side, id);
    // rust: let quarter = |x0: i32, x1: i32, y0: i32, y1: i32| {
    // rust: (x0..x1).contains(&rx) && (y0..y1).contains(&ry)
}
    // rust: let mut arrow = |name: &str, on: bool| {
    // rust: let s = if on {
    // rust: format!("transferable_list/{name}_highlighted")
    // rust: } else {
    // rust: format!("transferable_list/{name}")
}
    // rust: d::sprite(out, &s, cx, cy, 32, 32);
}
    // rust: if sel {
    // rust: arrow("select", quarter(0, 32, 0, 32));
    // rust: } else {
    // rust: if unsel {
    // rust: arrow("unselect", quarter(0, 16, 0, 32));
}
    // rust: if up {
    // rust: arrow("move_up", quarter(16, 32, 0, 16));
}
    // rust: if down {
    // rust: arrow("move_down", quarter(16, 32, 16, 32));
}
}
}
    // rust: let max = 157 - narrow;
    // rust: d::string_widget(out, m, &name, cx + 34, cy + 1, max);
    // rust: let lines = d::label_lines(m, &desc, max, 2, &desc_style);
    // rust: d::label(out, &lines, cx + 34, cy + 12, max, false);
}
}
}
    // rust: out.push(Draw::NoScissor);
    // rust: d::blit(
    // rust: out,
    // rust: &format!("textures/gui/{prefix}header_separator.png"),
    // rust: l.x,
    // rust: l.y - 2,
    // rust: (0.0, 0.0),
    // rust: l.width,
    // rust: 2,
    // rust: [32, 2],
    // rust: );
    // rust: d::blit(
    // rust: out,
    // rust: &format!("textures/gui/{prefix}footer_separator.png"),
    // rust: l.x,
    // rust: l.bottom(),
    // rust: (0.0, 0.0),
    // rust: l.width,
    // rust: 2,
    // rust: [32, 2],
    // rust: );
    // rust: if l.scrollable() {
    // rust: let sh = l.scroller_height().clamp(32, l.height - 8);
    // rust: let sy = (l.scroll as i32 * (l.height - sh) / l.max_scroll() + l.y).max(l.y);
    // rust: d::sprite(
    // rust: out,
    // rust: "widget/scroller_background",
    // rust: l.scroll_bar_x(),
    // rust: l.y,
    // rust: 6,
    // rust: l.height,
    // rust: );
    // rust: d::sprite(out, "widget/scroller", l.scroll_bar_x(), sy, 6, sh);
}
}
}

    // rust: mod icon_tests {
//     use super::*;

png :: proc(w: u32, h: u32, rgba: []u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut encoder = png::Encoder::new(&mut out, w, h);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(rgba)
    // rust: .unwrap();
    // rust: out
}
pack :: proc(id: string, icon: Maybe(^[u8])) -> P {
    // Ported from Horizon
    return {}
}
    // rust: PackInfo {
    // rust: id: id.into(),
    // rust: title: Text::literal(id),
    // rust: description: Text::literal(""),
    // rust: description_style: Style::default(),
    // rust: source: Source::BuiltIn,
    // rust: compat: Compat::Compatible,
    // rust: icon,
    // rust: required: false,
    // rust: position: Position::Top,
    // rust: fixed: false,
}
}

    // Any size stretches over the whole square, nearest texels, as the
    // icon texture is sampled into its 32x32 blit.
icons_stretch_to_the_slot_by_nearest_texels :: proc() {
}
    // rust: let (red, blue) = ([255, 0, 0, 255], [0, 0, 255, 128]);
    // rust: let icon = load_icon(&png(2, 1, &[red, blue].concat())).unwrap();
    // rust: let side = PACK_ICON_SIZE as usize;
    // rust: assert_eq!(icon.len(), side * side * 4);
    // rust: let at = |x: usize, y: usize| &icon[(y * side + x) * 4..][..4];
    // rust: assert_eq!((at(0, 0), at(side / 2 - 1, side - 1)), (&red[..], &red[..]));
    // rust: assert_eq!(
    // rust: (at(side / 2, 0), at(side - 1, side - 1)),
    // rust: (&blue[..], &blue[..])
    // rust: );
    // rust: assert!(load_icon(b"not a png").is_none());
}

    // Programmer Art and High Contrast draw their own `pack.png`; a pack
    // without one keeps `unknown_pack`.
drawn_icons_take_atlas_slots :: proc() {
}
    // rust: let atlas =
    // rust: crate::hud::HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets"))
    // rust: .unwrap();
    // rust: let m = Measure(&atlas.font);
    // rust: let dirt = load_icon(&png(1, 1, &[134, 96, 67, 255])).unwrap();
    // rust: let contrast = load_icon(&png(1, 1, &[0, 0, 0, 255])).unwrap();
    // rust: let packs = vec![
    // rust: pack("programmer_art", Some(dirt.clone())),
    // rust: pack("high_contrast", Some(contrast.clone())),
    // rust: pack("file/Iconless", None),
    // rust: ];
    // rust: let screen = PackScreen::new(&m, tr("resourcePack.title"), 480, 320, false, packs, &[]);
    // rust: let mut draws = screen.draw(&m, (0, 0), 0, 0);
    // rust: let mut patches = Vec::new();
    // rust: screen.bind_icons(&mut draws, &atlas, &mut patches);
    // rust: let icons: Vec<&str> = draws
    // rust: .iter()
    // rust: .filter_map(|d| match d {
    // rust: Draw::Blit { texture, .. } if texture.contains("pack") => Some(texture.as_str()),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
        // The list shows them sorted by id.
    // rust: assert_eq!(
    // rust: icons,
    // rust: [
    // rust: "textures/misc/unknown_pack.png",
    // rust: "horizon/pack-icon0",
    // rust: "horizon/pack-icon1"
    // rust: ]
    // rust: );
    // rust: assert_eq!(patches.len(), 2);
    // rust: for (i, (patch, icon)) in patches.iter().zip([&contrast, &dirt]).enumerate() {
    // rust: let rect = atlas.sprites[&format!("horizon/pack-icon{i}")];
    // rust: assert_eq!(
    // rust: (patch.x, patch.y, patch.width, patch.height),
    // rust: (
    // rust: (rect.u0 * atlas.width as f32).round() as u32,
    // rust: (rect.v0 * atlas.height as f32).round() as u32,
    // rust: PACK_ICON_SIZE,
    // rust: PACK_ICON_SIZE
    // rust: )
    // rust: );
    // rust: assert_eq!(&patch.rgba[..], &icon[..]);
}
}
}

    // rust: mod click_sound_tests {
//     use super::*;

a_cards_parts_do_not_overlap_each_other :: proc() {
}
    // rust: let atlas =
    // rust: crate::hud::HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets"))
    // rust: .unwrap();
    // rust: let m = Measure(&atlas.font);
        // Both a wide window (two columns) and a narrow one (one column).
    // rust: for (w, h) in [(480, 320), (260, 320)] {
    // rust: let mut screen =
    // rust: PackScreen::new(&m, tr("resourcePack.title"), w, h, false, Vec::new(), &[]);
    // rust: screen.browsing_allowed = true;
    // rust: let (cx, cy, cw, ch) = screen.card_box(0);
    // rust: let (ix, iy) = screen.install_button(0);
            // Install stays inside its card.
    // rust: assert!(
    // rust: ix >= cx && ix + INSTALL_W <= cx + cw,
    // rust: "install escapes the card"
    // rust: );
    // rust: assert!(
    // rust: iy >= cy && iy + BACK_H <= cy + ch,
    // rust: "install escapes the card"
    // rust: );
            // The name column ends before Install begins, so the two cannot
            // be drawn over one another.
    // rust: let text_x = cx + CARD_PAD + ICON + CARD_PAD;
    // rust: let text_w = (cx + cw - CARD_PAD - INSTALL_W - CARD_PAD - text_x).max(20);
    // rust: assert!(
    // rust: text_x + text_w <= ix || text_w == 20,
    // rust: "the name column runs under Install"
    // rust: );
            // The description starts below the icon rather than across it.
    // rust: let description_top = cy + CARD_PAD + ICON + 5;
    // rust: assert!(
    // rust: description_top >= cy + CARD_PAD + ICON,
    // rust: "text over the icon"
    // rust: );
            // And it still fits in the card with both its lines.
    // rust: assert!(description_top + 18 <= cy + ch, "the description overflows");
}
}

the_browsers_search_button_submits_what_was_typed :: proc() {
}
    // rust: let atlas =
    // rust: crate::hud::HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets"))
    // rust: .unwrap();
    // rust: let m = Measure(&atlas.font);
    // rust: let mut screen = PackScreen::new(
    // rust: &m,
    // rust: tr("resourcePack.title"),
    // rust: 480,
    // rust: 320,
    // rust: false,
    // rust: Vec::new(),
    // rust: &[],
    // rust: );
    // rust: screen.browsing_allowed = true;
        // The Add button opens the browser.
    // rust: let (ax, ay) = screen.add_button(&m);
    // rust: screen.click(&m, f64::from(ax) + 2.0, f64::from(ay) + 2.0);
    // rust: assert!(screen.browser.is_some(), "the Add button opens the browser");
        // Typing reaches the browser's own box, not the pack filter.
    // rust: screen.type_text(&m, "blue");
    // rust: assert_eq!(screen.browser_search.value, "blue");
    // rust: assert_eq!(screen.search.value, "", "the pack filter is left alone");
        // The Search button sends it to the browser.
    // rust: let (sx, sy) = screen.browser_search_button();
    // rust: screen.click(&m, f64::from(sx) + 2.0, f64::from(sy) + 2.0);
    // rust: assert_eq!(
    // rust: screen.browser.as_ref().map(|b| b.query.as_str()),
    // rust: Some("blue"),
    // rust: "the Search button submits the box's text"
    // rust: );
        // The box and the button must not overlap, or one eats the other's
        // clicks.
    // rust: let (qx, _) = screen.browser_search_box();
    // rust: assert!(sx >= qx + BROWSER_SEARCH_W, "{sx} overlaps the box at {qx}");
}

only_footer_and_confirmation_buttons_request_a_click_sound :: proc() {
}
    // rust: let atlas =
    // rust: crate::hud::HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets"))
    // rust: .unwrap();
    // rust: let m = Measure(&atlas.font);
    // rust: let title = tr("resourcePack.title");
    // rust: let mut screen = PackScreen::new(&m, title, 480, 320, false, Vec::new(), &[]);
    // rust: assert!(!screen.button_at(&m, 0.0, 0.0));
    // rust: assert!(!screen.button_at(
    // rust: &m,
    // rust: screen.search.x as f64 + 1.0,
    // rust: screen.search.y as f64 + 1.0
    // rust: ));
    // rust: let buttons = screen.footer();
    // rust: for (i, (x, y)) in buttons.into_iter().enumerate() {
    // rust: assert!(screen.button_at(&m, x as f64 + 1.0, y as f64 + 1.0));
    // rust: assert!(!screen.button_at(&m, (x + 150) as f64, (y + 20) as f64));
    // rust: assert_eq!(
    // rust: screen.click(&m, x as f64 + 1.0, y as f64 + 1.0),
    // rust: if i == 0 {
    // rust: Action::OpenFolder
    // rust: } else {
    // rust: Action::Done
}
    // rust: );
}
    // rust: screen.confirm = Some(Confirm {
    // rust: id: "incompatible".into(),
    // rust: title: Text::literal("Confirm"),
    // rust: message: Text::literal("Use this pack?"),
    // rust: });
    // rust: let buttons = screen
    // rust: .confirm_layout(&m, screen.confirm.as_ref().unwrap())
    // rust: .2;
    // rust: for (x, y) in buttons {
    // rust: assert!(screen.button_at(&m, x as f64 + 1.0, y as f64 + 1.0));
}
    // rust: assert!(!screen.button_at(
    // rust: &m,
    // rust: screen.footer()[0].0 as f64 + 1.0,
    // rust: screen.footer()[0].1 as f64 + 1.0
    // rust: ));
    // rust: let (x, y) = buttons[1];
    // rust: assert_eq!(
    // rust: screen.click(&m, x as f64 + 1.0, y as f64 + 1.0),
    // rust: Action::None
    // rust: );
    // rust: assert!(!screen.confirming());
}
}

    // rust: mod footer_label_tests {
//     use super::*;
//     use crate::lang::{self, Language};

    // The footer drawn with these labels (no global language involved) and
    // the footer buttons' positions.
    // rust: fn footer(
    // rust: atlas: &HudAtlas,
    // rust: open_folder: &Text,
    // rust: done: &Text,
    // rust: now_ms: i64,
    // rust: ) -> (Vec<Draw>, [(i32, i32); 2]) {
    // rust: let m = Measure(&atlas.font);
    // rust: let screen = PackScreen::new(&m, Text::literal("Packs"), 480, 320, false, Vec::new(), &[]);
    // rust: let mut out = Vec::new();
    // rust: screen.draw_footer(&mut out, &m, (0, 0), now_ms, [open_folder, done]);
    // rust: (out, screen.footer())
}
    // Every label drawn in `[bx + 2, bx + 148] x [by, by + 20]` of its button:
    // the scissor of a scrolling one is that box, and the text sits between
    // the scissor's calls.
assert_labels_stay_in_their_buttons :: proc(draws: ^[Draw], buttons: ^[(i32) {
}
    // rust: let mut scissors = 0;
    // rust: let mut open = None;
    // rust: let mut button = 0;
    // rust: for d in draws {
    // rust: match d {
    // rust: Draw::Sprite { x, y, .. } => {
    // rust: button = buttons.iter().position(|b| *b == (*x, *y)).unwrap();
}
    // rust: Draw::Scissor { x0, y0, x1, y1 } => {
    // rust: let (bx, by) = buttons[button];
    // rust: assert_eq!([*x0, *y0, *x1, *y1], [bx + 2, by, bx + 148, by + 20]);
    // rust: assert!(open.replace(()).is_none());
    // rust: scissors += 1;
}
    // rust: Draw::NoScissor => assert!(open.take().is_some()),
    // rust: _ => {}
}
}
    // rust: assert!(open.is_none());
    // rust: scissors
}

    // The Resource Packs footer with a label wider than its 150 px button
    // does not panic and scrolls; the short "Done" keeps its centre.
a_footer_label_wider_than_its_button_scrolls :: proc() {
}
    // rust: let atlas =
    // rust: crate::hud::HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets"))
    // rust: .unwrap();
    // rust: let m = Measure(&atlas.font);
    // rust: let wide = Text::literal("Otvori papku s paketami resursov, i jos nesto");
    // rust: assert!(m.width(&wide) > 146);
    // rust: let (draws, buttons) = footer(&atlas, &wide, &Text::literal("Done"), 0);
    // rust: assert_eq!(assert_labels_stay_in_their_buttons(&draws, &buttons), 1);
        // The clock moves it.
    // rust: let x = |draws: &[Draw]| {
    // rust: draws
    // rust: .iter()
    // rust: .find_map(|d| match d {
    // rust: Draw::Text { x, .. } => Some(*x),
    // rust: _ => None,
    // rust: })
    // rust: .unwrap()
}
    // rust: let (later, _) = footer(&atlas, &wide, &Text::literal("Done"), 2000);
    // rust: assert_ne!(x(&draws), x(&later));
        // Both too wide: both scroll.
    // rust: let (draws, buttons) = footer(&atlas, &wide, &wide, 0);
    // rust: assert_eq!(assert_labels_stay_in_their_buttons(&draws, &buttons), 2);
}

    // The real language files: the Resource Packs footer in each of the 143
    // languages draws without a panic, and in the ones whose "Open Pack
    // Folder" is wider than the button (Afrikaans and Macedonian among them,
    // the crash of #6129) it scrolls. A local `Language` per file: the global
    // language stays as it was.
the_footer_draws_in_every_language_file :: proc() {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: let atlas = crate::hud::HudAtlas::build(&root).unwrap();
    // rust: let m = Measure(&atlas.font);
    // rust: let before = lang::code();
    // rust: let mut codes: Vec<String> = std::fs::read_dir(root.join("assets/minecraft/lang"))
    // rust: .unwrap()
    // rust: .filter_map(|e| {
    // rust: let name = e.ok()?.file_name().into_string().ok()?;
    // rust: name.strip_suffix(".json").map(str::to_owned)
    // rust: })
    // rust: .collect();
    // rust: codes.sort();
    // rust: assert!(codes.len() >= 143, "{}", codes.len());
    // rust: let mut scrolling = Vec::new();
    // rust: for code in &codes {
    // rust: let language = Language::load(&[&root], code);
    // rust: let label = |key| Text::literal(language.get(key).unwrap_or(key));
    // rust: let (open_folder, done) = (label("pack.openFolder"), label("gui.done"));
    // rust: for now_ms in [0, 700, 1300, 5000] {
    // rust: let (draws, buttons) = footer(&atlas, &open_folder, &done, now_ms);
    // rust: let n = assert_labels_stay_in_their_buttons(&draws, &buttons);
    // rust: assert_eq!(
    // rust: n,
    // rust: [&open_folder, &done]
    // rust: .iter()
    // rust: .filter(|t| m.width(t) > 146)
    // rust: .count(),
    // rust: "{code}"
    // rust: );
    // rust: if now_ms == 0 && n > 0 {
    // rust: scrolling.push(code.as_str());
}
}
}
    // rust: for code in ["af_za", "mk_mk"] {
    // rust: assert!(scrolling.contains(&code), "{code} not in {scrolling:?}");
}
    // rust: assert_eq!(lang::code(), before, "the global language was left alone");
}
}
