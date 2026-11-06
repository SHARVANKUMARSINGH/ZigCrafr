//! Transpiled from Horizon Rust crate
//! Module: horizon-client_recipe_book
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The recipe book of the inventory, crafting table and furnace screens
//! (`RecipeBookComponent`): the green book button, the tabs by category, the
//! search box, the craftable filter, the pages of recipe buttons with the
//! alternatives overlay, ghost recipes, and placing a recipe in the grid
//! (`ServerPlaceRecipe`). Which recipes are known comes from the advancement
//! rewards; the open and filter settings are saved with the player.
// use super::{Game, Screen};
// use horizon_client::{
    // rust: containers::{BlockEntity, FurnaceKind},
    // rust: hud::{HudBatch, Rect, rgba},
    // rust: items::ItemStack,
    // rust: menu::place::{PostPlace, Stacked},
    // rust: recipe_book::{Book, BookType, ClientBook, Collection, Entry, GhostTarget, Tab},
    // rust: recipe_book_screen::{
    // rust: self as screen, ButtonView, Call, Drawn, GhostView, ItemCall, OverlayRecipe, OverlayView,
    // rust: Screen as Layout, Search, TabView,
    // rust: },
    // rust: text::{Style, Text},
    // rust: ui::EditBox,
}
// use std::{
    // rust: collections::BTreeSet,
    // rust: hash::{Hash, Hasher},
}

pub const WIDTH: f32 = 147.0;
pub const HEIGHT: f32 = 166.0;
/// `RecipeBookComponent.TICKS_TO_SWAP_SLOT`.
pub const SWAP_TICKS: f32 = 30.0;
/// Widest GUI at which the book sits next to the menu (`widthTooNarrow`).
pub const NARROW: f32 = 379.0;

/// A ghost recipe slot: the items it cycles through.
pub const Ghost = struct {
    slot: usize,
    items: std.ArrayList(ItemStack),
    result: bool,
};
/// The alternatives overlay of a recipe button (`OverlayRecipeComponent`).
pub const Overlay = struct {
    x: f32,
    y: f32,
    /// (entry index, craftable)
    entries: Vec<(usize,
};
/// One recipe button: the collection's recipes shown in the current view.
pub const Button = struct {
    /// (entry index, craftable)
    entries: Vec<(usize,
};
    // rust: impl Button {
pub fn craftable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries.iter().any(|e| e.1)
}
}
pub const View = struct {
    /// Visible tabs.
    tabs: std.ArrayList(Tab),
    buttons: std.ArrayList(Button),
};

    // rust: pub(super) struct RecipeUi {
    // rust: book: Option<Book>,
    // rust: tab: Option<Tab>,
    // rust: search: Option<EditBox>,
    // rust: page: usize,
    /// Ticks, for the ghost and button cycling (`RecipeBookComponent.time`).
    // rust: time: f32,
    // rust: ghost: Vec<Ghost>,
    // rust: last_placed: Option<String>,
    // rust: overlay: Option<Overlay>,
    /// A press landed in the search box, so a drag selects text in it.
    // rust: search_drag: bool,
    // rust: view: View,
    // rust: view_key: u64,
    /// Squeeze animations of new recipes: ticks left per button index and tab.
    // rust: button_anim: Vec<(usize, f32)>,
    // rust: tab_anim: Vec<(Tab, f32)>,
    /// The client's copy of the known recipes (`ClientRecipeBook`), its
    /// order deciding the buttons', and the recipes it was last synced with.
    // rust: client: ClientBook,
    // rust: client_known: Option<BTreeSet<String>>,
    // rust: client_version: u64,
    /// The display a click last placed (`lastRecipe`), which Enter and Space
    /// place again; slot clicks keep it.
    // rust: last_clicked: Option<i32>,
}

    // rust: impl RecipeUi {
    /// A new screen starts without a ghost recipe, overlay or search focus.
    // rust: pub(super) fn reset_screen(&mut self) {
    // rust: self.ghost.clear();
    // rust: self.last_placed = None;
    // rust: self.overlay = None;
    // rust: self.tab = None;
    // rust: self.page = 0;
    // rust: if let Some(search) = self.search.as_mut() {
    // rust: search.focused = false;
    // rust: search.set_value("");
}
    // rust: self.view_key = 0;
    // rust: self.last_clicked = None;
}
}

pub fn inside(p: (f32) void {
}
    // rust: p.0 >= x && p.1 >= y && p.0 < x + w && p.1 < y + h
}
pub fn sprite(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("gui/sprites/recipe_book/{name}")
}

    // rust: impl Game<'_> {
    /// The book the open screen has, if any.
pub fn active_book(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.screen != Screen::Inventory || self.station.is_some() {
    // rust: return None;
}
        // A mod's screen has no book.
    // rust: if self.mount_active() || self.native_screen_height().is_some() {
    // rust: return None;
}
    // rust: match self.container_kind() {
    // rust: None if self.container.is_none() => Some(BookType::Crafting),
    // rust: Some(BlockEntity::Furnace(f)) => Some(match f.kind {
    // rust: FurnaceKind::Furnace => BookType::Furnace,
    // rust: FurnaceKind::BlastFurnace => BookType::BlastFurnace,
    // rust: FurnaceKind::Smoker => BookType::Smoker,
    // rust: }),
    // rust: _ => None,
}
}
pub fn book_open(self: *Self, book: BookType) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.level.recipe_book.open[book.index()]
}
pub fn book_filtering(self: *Self, book: BookType) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.level.recipe_book.filtering[book.index()]
}
    /// How far the open book pushes the menu to the right
    /// (`RecipeBookComponent.updateScreenPosition`).
    // rust: pub(super) fn recipe_book_shift(&self, width: f32) -> f32 {
    // rust: match self.active_book() {
    // rust: Some(book) if self.book_open(book) && width >= NARROW => 77.0,
    // rust: _ => 0.0,
}
}
    /// `AbstractRecipeBookScreen.isHovering` is false while the book is
    /// visible in a window narrower than `NARROW`: the book covers the menu,
    /// so no slot is hovered or clicked.
    // rust: pub(super) fn book_covers_menu(&self, width: f32) -> bool {
    // rust: width < NARROW && self.active_book().is_some_and(|b| self.book_open(b))
}
    /// Whether typed keys go to the search box.
    // rust: pub(super) fn recipe_search_focused(&self) -> bool {
    // rust: self.active_book().is_some_and(|b| self.book_open(b))
    // rust: && self.recipe_ui.search.as_ref().is_some_and(|s| s.focused)
}
    /// `keyChat` focuses the search box.
    // rust: pub(super) fn recipe_focus_search(&mut self) {
    // rust: if self.active_book().is_some_and(|b| self.book_open(b))
    // rust: && let Some(s) = self.recipe_ui.search.as_mut()
    // rust: {
    // rust: s.focused = true;
    // rust: s.reset_blink();
}
}
    /// Text typed (or one backspace) into the search box.
    // rust: pub(super) fn recipe_text(&mut self, text: Option<&str>, backspace: bool) {
    // rust: let Some(search) = self.recipe_ui.search.as_mut() else {
    // rust: return;
}
    // rust: if backspace {
    // rust: search.delete_chars(-1);
    // rust: } else if let Some(text) = text {
    // rust: search.insert_text(text);
}
}
    /// Ctrl+A/C/V/X in the search box.
    // rust: pub(super) fn recipe_shortcut(&mut self, shortcut: horizon_client::clipboard::EditShortcut) {
    // rust: if let Some(search) = self.recipe_ui.search.as_mut() {
    // rust: search.shortcut(shortcut, &mut self.clipboard);
}
}
    /// A key press while the search box has focus.
    // rust: pub(super) fn recipe_key(&mut self, event: &winit::event::KeyEvent) {
//         use winit::keyboard::PhysicalKey;
    // rust: if let Some(shortcut) = self.edit_shortcut(event) {
    // rust: self.recipe_shortcut(shortcut);
    // rust: return;
}
    // rust: let ctrl = self.has_control_down();
    // rust: let shift = self.has_shift_down();
    // rust: let types_text = self.types_text();
    // rust: let Some(search) = self.recipe_ui.search.as_mut() else {
    // rust: return;
}
    // rust: let handled = match event.physical_key {
    // rust: PhysicalKey::Code(code) => search.key(code, ctrl, shift),
    // rust: _ => false,
}
    // rust: if !handled
    // rust: && types_text
    // rust: && let Some(text) = &event.text
    // rust: {
    // rust: let text: String = text.chars().filter(|c| !c.is_control()).collect();
    // rust: search.insert_text(&text);
}
    // rust: search.reset_blink();
}

    /// `RecipeToast.addOrUpdate` for each display of the recipes just
    /// unlocked: its crafting station and result join the toast still
    /// queued or shown, or a new one.
    // rust: pub(super) fn recipe_toast(&mut self, recipes: &[String]) {
    // rust: if recipes.is_empty() || self.adv.quiet {
    // rust: return;
}
    // rust: self.ensure_book();
    // rust: let index = &self.stations().recipe_index;
    // rust: let book = self.recipe_ui.book.as_ref();
        // SmithingTrimDemoSlotDisplay draws from a random of its own.
    // rust: let mut random = super::dispenser::entity_random();
    // rust: let mut items = Vec::new();
    // rust: let mut first = None;
    // rust: for id in recipes {
    // rust: let Some(station) = index.toast_station(id) else {
    // rust: continue;
}
    // rust: for display in index.display_ids(id) {
                // The book's displays carry their resolved results; the
                // other recipe types name theirs, and trims are demos.
    // rust: let result = book
    // rust: .and_then(|b| {
    // rust: b.entry_of_display(display)
    // rust: .map(|i| b.entries[i].result.clone())
    // rust: })
    // rust: .or_else(|| index.result(id).map(|r| ItemStack::new(r, 1)))
    // rust: .or_else(|| {
    // rust: self.stations().recipes.trim_demo(
    // rust: &self.stations().enchantments,
    // rust: id,
    // rust: &mut |n| {
    // rust: horizon_core::random::RandomSource::next_int_bound(
    // rust: &mut random,
    // rust: n as i32,
    // rust: )
    // rust: .unwrap_or(0) as usize
    // rust: },
    // rust: )
    // rust: });
    // rust: if let Some(result) = result {
    // rust: first.get_or_insert(id);
    // rust: items.push((station.to_owned(), result));
}
}
}
    // rust: let Some(first) = first else {
    // rust: return;
}
    // rust: match self.adv.toasts.iter_mut().find(|t| t.is_recipe()) {
    // rust: Some(toast) => toast.add_recipes(items),
    // rust: None => {
    // rust: if self.toast_allowed("recipe", first) {
    // rust: let toast = super::advancements::Toast::recipe(items);
    // rust: self.adv.toasts.push_back(toast);
}
}
}
}

    // ---- recipes and what can be crafted ----

    /// The grid size of the open crafting menu.
pub fn book_grid(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.craft_size, self.craft_size)
}
    /// The items the book counts (`RecipeBookComponent.updateStackedContents`):
    /// the inventory and the menu's crafting slots, as the menu engine counts them.
pub fn book_available(self: *Self, _book: BookType) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.remote.is_some() {
            // A server's menu: the slots it last sent, counted the same way.
//             use horizon_client::menu::{Env, Kind, Menu};
    // rust: let table = self.craft_size == 3;
    // rust: let grid: Vec<_> = (0..self.craft_size * self.craft_size)
    // rust: .map(|k| self.slot_mut(100 + k).clone())
    // rust: .collect();
    // rust: let mut menu = Menu::new(if table {
    // rust: Kind::Crafting
    // rust: } else {
    // rust: Kind::Inventory
    // rust: });
    // rust: let env = Env {
    // rust: items: self.items(),
    // rust: recipes: self.recipes(),
    // rust: brewing: &self.stations().brewing,
    // rust: banners: &self.stations().banners,
    // rust: station_recipes: &self.stations().recipes,
    // rust: enchantments: &self.stations().enchantments,
    // rust: names: &self.pack.names,
    // rust: trade: None,
    // rust: maps: None,
    // rust: limited_crafting: self.limited_crafting(),
    // rust: known_recipes: Some(&self.level.recipe_book),
}
    // rust: for i in 0..36 {
    // rust: menu.set_player_item(i, self.inventory[i].clone());
}
    // rust: for (k, stack) in grid.into_iter().enumerate() {
    // rust: menu.set_slot(&env, 1 + k, stack);
}
    // rust: return menu.stacked_contents(&env);
}
    // rust: let mut out = Stacked::default();
    // rust: let stock = &mut out;
    // rust: self.menu_session(|menu, env, _| {
    // rust: *stock = menu.stacked_contents(env);
    // rust: Some(false)
    // rust: });
    // rust: out
}
    /// Sends the client book what changed in the server's: the first time a
    /// replacing batch (vanilla's server iterates an identity hash set; this
    /// one goes in id order), then each unlock and removal.
pub fn sync_client_book(self: *Self) void {
}
        // On a server the book is the server's packets' (remote_recipe_book_*).
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: let known = &self.level.recipe_book.recipes;
    // rust: let index = &world_stations!(self).recipe_index;
    // rust: let ui = &mut self.recipe_ui;
    // rust: match ui.client_known.as_ref() {
    // rust: Some(previous) if previous == known => return,
    // rust: Some(previous) => {
    // rust: for id in previous.difference(known) {
    // rust: for d in index.display_ids(id) {
    // rust: ui.client.remove(d);
}
}
    // rust: for id in known.difference(previous) {
    // rust: for d in index.display_ids(id) {
    // rust: ui.client.add(d);
}
}
}
    // rust: None => {
    // rust: ui.client.clear();
    // rust: for id in known {
    // rust: for d in index.display_ids(id) {
    // rust: ui.client.add(d);
}
}
}
}
    // rust: ui.client_known = Some(known.clone());
    // rust: ui.client_version += 1;
}
    /// Every entry of the book, in its order (`native_recipes`).
    // rust: pub(super) fn recipe_book_entries(&mut self) -> Vec<Entry> {
    // rust: self.ensure_book();
    // rust: self.recipe_ui
    // rust: .book
    // rust: .as_ref()
    // rust: .map_or_else(Vec::new, |b| b.entries.clone())
}
    /// The display ids the player's book holds, and a number that changes
    /// whenever they do (`native_known_recipes`).
    // rust: pub(super) fn recipe_book_displays(&mut self) -> (u64, Vec<i32>) {
    // rust: self.sync_client_book();
    // rust: (
    // rust: self.recipe_ui.client_version,
    // rust: self.recipe_ui.client.displays(),
    // rust: )
}
    /// The book's model is made again from `Game::recipes` when next needed:
    /// the server's recipes arrived, or a new session began.
    // rust: pub(super) fn forget_book(&mut self) {
    // rust: self.recipe_ui.book = None;
    // rust: self.recipe_tables.categories = None;
}
pub fn ensure_book(self: *Self) void {
}
    // rust: if self.recipe_ui.book.is_none() {
    // rust: let mut book = Book::build(self.recipes(), self.items());
    // rust: book.set_display_ids(&self.stations().recipe_index);
    // rust: self.recipe_ui.book = Some(book);
}
    // rust: if self.recipe_ui.search.is_none() {
    // rust: let mut search = EditBox::new(0.0, 0.0, 81.0, 14.0);
    // rust: search.message = super::screen_info::tr("itemGroup.search", &[]);
    // rust: search.max_length = 50;
    // rust: search.focused = false;
    // rust: search.text_color = u32::MAX;
    // rust: self.recipe_ui.search = Some(search);
}
}
    /// Rebuilds the tab and button lists when anything they depend on changed.
pub fn refresh_book_view(self: *Self, book_type: BookType) void {
}
    // rust: self.ensure_book();
    // rust: self.sync_client_book();
    // rust: let mut h = std::collections::hash_map::DefaultHasher::new();
    // rust: for s in self.inventory.iter().flatten() {
    // rust: (&s.item, s.count, s.damage).hash(&mut h);
}
    // rust: for slot in [
    // rust: 100usize, 101, 102, 103, 104, 105, 106, 107, 108, 300, 301, 302,
    // rust: ] {
    // rust: let stack =
    // rust: if slot < 109 && self.active_book() == Some(BookType::Crafting) || slot >= 300 {
    // rust: self.slot_mut(slot).clone()
    // rust: } else {
    // rust: None
}
    // rust: stack.map(|s| (s.item, s.count)).hash(&mut h);
}
    // rust: self.craft_size.hash(&mut h);
    // rust: self.recipe_ui.client_version.hash(&mut h);
    // rust: self.book_filtering(book_type).hash(&mut h);
    // rust: self.recipe_ui.tab.map(|t| format!("{t:?}")).hash(&mut h);
    // rust: self.recipe_ui
    // rust: .search
    // rust: .as_ref()
    // rust: .map(|s| s.value.clone())
    // rust: .hash(&mut h);
    // rust: book_type.index().hash(&mut h);
    // rust: let key = h.finish();
    // rust: if key == self.recipe_ui.view_key && !self.recipe_ui.view.tabs.is_empty() {
    // rust: return;
}
    // rust: let ui = std::mem::take(&mut self.recipe_ui);
    // rust: let view = self.build_view(&ui, book_type);
    // rust: self.recipe_ui = ui;
    // rust: self.recipe_ui.view = view;
    // rust: self.recipe_ui.view_key = key;
    // rust: let pages = self.recipe_ui.view.buttons.len().div_ceil(20);
    // rust: if self.recipe_ui.page >= pages.max(1) {
    // rust: self.recipe_ui.page = 0;
}
    // rust: self.start_new_recipe_animations(book_type);
}
    /// `RecipeBookTabButton.startAnimation` and `RecipeButton.init`: tabs
    /// holding a recipe still to be displayed squeeze, and the buttons of the
    /// shown page squeeze once and clear their recipes' highlight.
pub fn start_new_recipe_animations(self: *Self, book_type: BookType) void {
}
    // rust: if self.level.recipe_book.to_be_displayed.is_empty() {
    // rust: return;
}
    // rust: let Some(book) = self.recipe_ui.book.take() else {
    // rust: return;
}
    // rust: let filtering = self.book_filtering(book_type);
    // rust: let (gw, gh) = self.book_grid();
    // rust: let available = self.book_available(book_type);
    // rust: let shown = |e: &Entry| {
    // rust: (book_type != BookType::Crafting || e.fits(gw, gh))
    // rust: && (!filtering || book.can_craft(e, &available))
}
    // rust: let new = |level: &Self, e: &Entry| level.level.recipe_book.to_be_displayed.contains(&e.id);
    // rust: let mut tabs = Vec::new();
    // rust: for tab in self.recipe_ui.view.tabs.clone() {
    // rust: if tab == Tab::Search {
    // rust: continue;
}
    // rust: let hit = self
    // rust: .recipe_ui
    // rust: .client
    // rust: .collections(&book, book_type, tab)
    // rust: .iter()
    // rust: .flat_map(|c| c.entries.iter())
    // rust: .any(|&i| shown(&book.entries[i]) && new(self, &book.entries[i]));
    // rust: if hit {
    // rust: tabs.push((tab, 15.0));
}
}
    // rust: self.recipe_ui.tab_anim = tabs;
    // rust: let first = self.recipe_ui.page * 20;
    // rust: let mut buttons = Vec::new();
    // rust: let mut cleared = Vec::new();
    // rust: for (n, button) in self
    // rust: .recipe_ui
    // rust: .view
    // rust: .buttons
    // rust: .iter()
    // rust: .skip(first)
    // rust: .take(20)
    // rust: .enumerate()
    // rust: {
    // rust: let ids: Vec<&String> = button
    // rust: .entries
    // rust: .iter()
    // rust: .map(|e| &book.entries[e.0].id)
    // rust: .filter(|id| self.level.recipe_book.to_be_displayed.contains(*id))
    // rust: .collect();
    // rust: if !ids.is_empty() {
    // rust: buttons.push((first + n, 15.0));
    // rust: cleared.extend(ids.into_iter().cloned());
}
}
    // rust: self.level
    // rust: .recipe_book
    // rust: .to_be_displayed
    // rust: .retain(|id| !cleared.contains(id));
    // rust: self.recipe_ui.button_anim = buttons;
    // rust: self.recipe_ui.book = Some(book);
}
pub fn build_view(self: *Self, ui: *RecipeUi, book_type: BookType) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(book) = ui.book.as_ref() else {
    // rust: return View::default();
}
    // rust: let available = self.book_available(book_type);
    // rust: let (gw, gh) = self.book_grid();
    // rust: let selected = |e: &Entry| match book_type {
    // rust: BookType::Crafting => e.fits(gw, gh),
    // rust: _ => true,
}
    // rust: let craftable = |e: &Entry| selected(e) && book.can_craft(e, &available);
    // rust: let filtering = self.book_filtering(book_type);
    // rust: let mut tabs = Vec::new();
    // rust: for tab in book_type.tabs() {
    // rust: let visible = tab == Tab::Search
    // rust: || ui
    // rust: .client
    // rust: .collections(book, book_type, tab)
    // rust: .iter()
    // rust: .any(|c| c.entries.iter().any(|&i| selected(&book.entries[i])));
    // rust: if visible {
    // rust: tabs.push(tab);
}
}
    // rust: let tab = ui.tab.filter(|t| tabs.contains(t)).unwrap_or(Tab::Search);
    // rust: let query = ui
    // rust: .search
    // rust: .as_ref()
    // rust: .map(|s| s.value.clone())
    // rust: .unwrap_or_default();
    // rust: let collections: Vec<Collection> = ui.client.collections(book, book_type, tab);
    // rust: let mut buttons = Vec::new();
    // rust: for c in collections {
    // rust: if !c.entries.iter().any(|&i| selected(&book.entries[i])) {
    // rust: continue;
}
    // rust: if !query.is_empty()
    // rust: && !book.collection_matches(&c.entries, &query, &|stack| {
    // rust: horizon_client::item_tooltip::lines(
    // rust: stack,
    // rust: self.items().get(&stack.item),
    // rust: &|k| self.pack.names.display_get(k),
    // rust: )
    // rust: })
    // rust: {
    // rust: continue;
}
    // rust: let entries: Vec<(usize, bool)> = c
    // rust: .entries
    // rust: .iter()
    // rust: .filter(|&&i| selected(&book.entries[i]))
    // rust: .map(|&i| (i, craftable(&book.entries[i])))
    // rust: .collect();
    // rust: if filtering && !entries.iter().any(|e| e.1) {
    // rust: continue;
}
    // rust: let entries = if filtering {
    // rust: entries.into_iter().filter(|e| e.1).collect()
    // rust: } else {
    // rust: entries
}
    // rust: buttons.push(Button { entries });
}
    // rust: View { tabs, buttons }
}

    // ---- geometry ----

    /// `RecipeBookComponent.getXOrigin` / `getYOrigin` (`widthTooNarrow`
    /// centres the book over the menu).
pub fn book_origin(self: *Self, batch: *HudBatch) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let offset = if batch.width < NARROW { 0.0 } else { 86.0 };
    // rust: (
    // rust: ((batch.width - WIDTH) / 2.0).floor() - offset,
    // rust: ((batch.height - HEIGHT) / 2.0).floor(),
    // rust: )
}
    /// The green book button's top-left corner.
pub fn book_button_pos(self: *Self, book: BookType, ox: f32, batch: *HudBatch) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mid = (batch.height / 2.0).floor();
    // rust: match book {
    // rust: BookType::Crafting if self.craft_size == 2 => (ox + 104.0, mid - 22.0),
    // rust: BookType::Crafting => (ox + 5.0, mid - 49.0),
    // rust: _ => (ox + 20.0, mid - 49.0),
}
}
pub fn tab_pos(self: *Self, xo: f32, yo: f32, index: usize) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (xo - 30.0, yo + 3.0 + 27.0 * index as f32)
}
pub fn button_pos(xo: f32, yo: f32, i: usize) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: xo + 11.0 + 25.0 * (i % 5) as f32,
    // rust: yo + 31.0 + 25.0 * (i / 5) as f32,
    // rust: )
}
    /// `RecipeBookComponent.slotSelectTime`.
pub fn swap_index(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.recipe_ui.time / SWAP_TICKS).floor() as usize
}
pub fn batch_for_size(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = self.renderer.as_ref()?;
    // rust: Some(HudBatch::new([r.config.width, r.config.height]))
}

    // ---- clicks ----

    /// A click while a screen with a recipe book is open; true when the book
    /// used it.
    // rust: pub(super) fn recipe_book_click(&mut self, right: bool) -> bool {
    // rust: let Some(book_type) = self.active_book() else {
    // rust: return false;
}
    // rust: let Some(batch) = self.batch_for_size() else {
    // rust: return false;
}
    // rust: self.ensure_book();
    // rust: let cursor = self.cursor;
    // rust: let (ox, _) = self.inventory_origin(&batch);
        // Clicking a crafting slot drops the ghost recipe (`slotClicked`).
    // rust: if let Some(slot) = self.slot_at(&batch, cursor.0, cursor.1)
    // rust: && self.is_book_slot(book_type, slot)
    // rust: {
    // rust: self.recipe_ui.last_placed = None;
    // rust: self.recipe_ui.ghost.clear();
}
    // rust: let (bx, by) = self.book_button_pos(book_type, ox, &batch);
    // rust: if inside(cursor, bx, by, 20.0, 18.0) {
    // rust: let open = !self.book_open(book_type);
    // rust: self.level.recipe_book.open[book_type.index()] = open;
    // rust: self.send_book_settings(book_type);
    // rust: if !open {
    // rust: self.recipe_ui.overlay = None;
}
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: return true;
}
    // rust: if !self.book_open(book_type) {
    // rust: return false;
}
        // AbstractRecipeBookScreen.mouseClicked: in a narrow window the visible
        // book takes every click, even one it does not use itself.
    // rust: let narrow = batch.width < NARROW;
    // rust: if self.spectator() {
    // rust: return narrow;
}
    // rust: self.refresh_book_view(book_type);
    // rust: let (xo, yo) = self.book_origin(&batch);
        // The alternatives overlay captures the click first.
    // rust: if let Some(overlay) = self.recipe_ui.overlay.take() {
    // rust: let maxrow = if overlay.entries.len() <= 16 { 4 } else { 5 };
    // rust: for (n, (entry, _)) in overlay.entries.iter().enumerate() {
    // rust: let x = overlay.x + 4.0 + 25.0 * (n % maxrow) as f32;
    // rust: let y = overlay.y + 5.0 + 25.0 * (n / maxrow) as f32;
    // rust: if !right && inside(cursor, x, y, 24.0, 24.0) {
    // rust: let shift = self.shift_down();
    // rust: if self.try_place(*entry, shift) {
    // rust: self.remember_click(*entry);
    // rust: self.close_narrow_book(book_type, &batch);
}
    // rust: return true;
}
}
    // rust: return true;
}
    // rust: let pages = self.recipe_ui.view.buttons.len().div_ceil(20);
        // Page arrows.
    // rust: if pages > 1 {
    // rust: if self.recipe_ui.page + 1 < pages && inside(cursor, xo + 93.0, yo + 137.0, 12.0, 17.0)
    // rust: {
    // rust: self.recipe_ui.page += 1;
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: return true;
}
    // rust: if self.recipe_ui.page > 0 && inside(cursor, xo + 38.0, yo + 137.0, 12.0, 17.0) {
    // rust: self.recipe_ui.page -= 1;
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: return true;
}
}
        // Recipe buttons.
    // rust: let first = self.recipe_ui.page * 20;
    // rust: for n in 0..20 {
    // rust: let Some(button) = self.recipe_ui.view.buttons.get(first + n).cloned() else {
    // rust: break;
}
    // rust: let (x, y) = Self::button_pos(xo, yo, n);
    // rust: if !inside(cursor, x, y, 25.0, 25.0) {
    // rust: continue;
}
    // rust: if right {
    // rust: if button.entries.len() > 1 {
    // rust: self.open_overlay(&button, x, y, xo, yo);
}
    // rust: } else {
    // rust: let step = self.swap_index();
    // rust: let (entry, _) = button.entries[step % button.entries.len()];
    // rust: let shift = self.shift_down();
    // rust: if self.try_place(entry, shift) {
    // rust: self.remember_click(entry);
    // rust: self.close_narrow_book(book_type, &batch);
}
}
    // rust: return true;
}
        // Search box.
    // rust: if let Some(search) = self.recipe_ui.search.as_mut() {
    // rust: search.x = xo + 25.0;
    // rust: search.y = yo + 13.0;
            // RecipeBookComponent's magnifierIconPlacement: from the book's
            // left edge plus eight to the search box's own left edge.
    // rust: let magnifier = inside(cursor, xo + 8.0, yo + 13.0, search.x - xo, 14.0);
    // rust: if magnifier || inside(cursor, search.x, search.y, search.width, search.height) {
    // rust: self.recipe_ui.search_drag = true;
    // rust: search.focused = true;
    // rust: search.reset_blink();
    // rust: if !magnifier {
    // rust: let idx = search.index_at(&self.gui.atlas, cursor.0);
    // rust: search.set_cursor(idx, false);
}
    // rust: return true;
}
    // rust: search.focused = false;
}
        // The craftable filter.
    // rust: if inside(cursor, xo + 110.0, yo + 12.0, 26.0, 16.0) {
    // rust: let filtering = !self.book_filtering(book_type);
    // rust: self.level.recipe_book.filtering[book_type.index()] = filtering;
    // rust: self.send_book_settings(book_type);
    // rust: self.recipe_ui.page = 0;
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: return true;
}
        // Tabs.
    // rust: for (n, tab) in self.recipe_ui.view.tabs.clone().into_iter().enumerate() {
    // rust: let (x, y) = self.tab_pos(xo, yo, n);
    // rust: if inside(cursor, x, y, 35.0, 27.0) {
    // rust: if self.recipe_ui.tab.unwrap_or(Tab::Search) != tab {
    // rust: self.recipe_ui.tab = Some(tab);
    // rust: self.recipe_ui.page = 0;
}
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: return true;
}
}
    // rust: narrow
}
    /// `RecipeBookComponent.mouseClicked` after a placed recipe: it becomes
    /// `lastRecipe`.
pub fn remember_click(self: *Self, entry: usize) void {
}
    // rust: self.recipe_ui.last_clicked = self
    // rust: .recipe_ui
    // rust: .book
    // rust: .as_ref()
    // rust: .and_then(|b| b.entries.get(entry))
    // rust: .map(|e| e.display_id);
}
    /// `RecipeBookComponent.keyPressed`: Enter or Space (`isSelection`) places
    /// the recipe clicked last again, key repeats included, as many as fit
    /// with Shift. The focused search box takes the key first.
    // rust: pub(super) fn recipe_book_key(&mut self, key: winit::keyboard::KeyCode) -> bool {
//         use winit::keyboard::KeyCode;
    // rust: if !matches!(key, KeyCode::Enter | KeyCode::NumpadEnter | KeyCode::Space) {
    // rust: return false;
}
    // rust: let Some(book_type) = self.active_book() else {
    // rust: return false;
}
    // rust: if !self.book_open(book_type) || self.spectator() || self.recipe_search_focused() {
    // rust: return false;
}
    // rust: let Some(display) = self.recipe_ui.last_clicked else {
    // rust: return false;
}
        // The craft just taken changed what is craftable.
    // rust: self.refresh_book_view(book_type);
    // rust: let Some(entry) = self
    // rust: .recipe_ui
    // rust: .book
    // rust: .as_ref()
    // rust: .and_then(|b| b.entry_of_display(display))
    // rust: else {
    // rust: return false;
}
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: let shift = self.shift_down();
    // rust: self.try_place(entry, shift)
}
    /// `RecipeBookComponent.mouseDragged`: while the search box is focused a
    /// drag moves its selection end to the pointer (`EditBox.onDrag`).
    // rust: pub(super) fn recipe_book_drag(&mut self) {
    // rust: if !self.recipe_ui.search_drag || !self.active_book().is_some_and(|b| self.book_open(b)) {
    // rust: return;
}
    // rust: let x = self.cursor.0;
    // rust: if let Some(search) = self.recipe_ui.search.as_mut()
    // rust: && search.focused
    // rust: {
    // rust: search.drag_to(&self.gui.atlas, x);
}
}
    /// A mouse button let go: a drag no longer selects in the search box.
    // rust: pub(super) fn recipe_book_release(&mut self) {
    // rust: self.recipe_ui.search_drag = false;
}
    /// `RecipeBookComponent.sendUpdateSettings`: the server owns the saved book.
pub fn send_book_settings(self: *Self, book_type: BookType) void {
}
    // rust: self.send(
    // rust: horizon_protocol::packets::play::Serverbound::RecipeBookChangeSettings(
    // rust: horizon_protocol::packets::recipes::RecipeBookChangeSettings {
    // rust: book_type: book_type.index() as i32,
    // rust: open: self.book_open(book_type),
    // rust: filtering: self.book_filtering(book_type),
    // rust: },
    // rust: ),
    // rust: );
}
    // rust: pub(super) fn recipe_book_flags(&self) -> Option<(bool, bool)> {
    // rust: let book = self.active_book()?;
    // rust: Some((self.book_open(book), self.book_filtering(book)))
}
    /// How many displays the client's book holds.
    // rust: pub(super) fn recipe_book_known(&self) -> usize {
    // rust: self.recipe_ui.client.displays().len()
}
    /// The next or previous page, as the arrows turn it: nothing past either end, or with a
    /// pointer button held.
    // rust: pub(super) fn pad_recipe_page(&mut self, next: bool) {
    // rust: if self.pad.menu.held != [false; 2] {
    // rust: return;
}
    // rust: let pages = self.recipe_ui.view.buttons.len().div_ceil(20);
    // rust: let page = self.recipe_ui.page;
    // rust: let Some(to) = (if next {
    // rust: (page + 1 < pages).then_some(page + 1)
    // rust: } else {
    // rust: page.checked_sub(1)
    // rust: }) else {
    // rust: return;
}
    // rust: self.recipe_ui.page = to;
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
}
    /// The recipe book's buttons a controller can focus: the book button,
    /// recipes, page arrows, the craftable filter and the tabs (GUI pixels;
    /// the search box registers itself as a field).
    // rust: pub(super) fn recipe_book_targets(&self) -> Vec<horizon_client::widgets::Target> {
//         use horizon_client::widgets::{Kind, Target};
    // rust: let (Some(book_type), Some(batch)) = (self.active_book(), self.batch_for_size()) else {
    // rust: return Vec::new();
}
    // rust: let button = |rect| Target {
    // rust: rect,
    // rust: kind: Kind::Button,
}
    // rust: let (ox, _) = self.inventory_origin(&batch);
    // rust: let (bx, by) = self.book_button_pos(book_type, ox, &batch);
    // rust: let mut out = vec![button([bx, by, 20.0, 18.0])];
    // rust: if !self.book_open(book_type) || self.spectator() {
    // rust: return out;
}
    // rust: let (xo, yo) = self.book_origin(&batch);
    // rust: if let Some(overlay) = &self.recipe_ui.overlay {
            // The alternatives overlay takes every click while open.
    // rust: let maxrow = if overlay.entries.len() <= 16 { 4 } else { 5 };
    // rust: return (0..overlay.entries.len())
    // rust: .map(|n| {
    // rust: let x = overlay.x + 4.0 + 25.0 * (n % maxrow) as f32;
    // rust: let y = overlay.y + 5.0 + 25.0 * (n / maxrow) as f32;
    // rust: button([x, y, 24.0, 24.0])
    // rust: })
    // rust: .collect();
}
    // rust: let first = self.recipe_ui.page * 20;
    // rust: let shown = self
    // rust: .recipe_ui
    // rust: .view
    // rust: .buttons
    // rust: .len()
    // rust: .saturating_sub(first)
    // rust: .min(20);
    // rust: out.extend((0..shown).map(|n| {
    // rust: let (x, y) = Self::button_pos(xo, yo, n);
    // rust: button([x, y, 25.0, 25.0])
    // rust: }));
    // rust: let pages = self.recipe_ui.view.buttons.len().div_ceil(20);
    // rust: if pages > 1 && self.recipe_ui.page + 1 < pages {
    // rust: out.push(button([xo + 93.0, yo + 137.0, 12.0, 17.0]));
}
    // rust: if pages > 1 && self.recipe_ui.page > 0 {
    // rust: out.push(button([xo + 38.0, yo + 137.0, 12.0, 17.0]));
}
    // rust: out.push(button([xo + 110.0, yo + 12.0, 26.0, 16.0]));
    // rust: let selected = self.recipe_ui.tab.unwrap_or(Tab::Search);
    // rust: for (n, tab) in self.recipe_ui.view.tabs.iter().enumerate() {
    // rust: let (x, y) = self.tab_pos(xo, yo, n);
    // rust: out.push(Target {
    // rust: rect: [x, y, 35.0, 27.0],
    // rust: kind: Kind::Tab(*tab == selected),
    // rust: });
}
    // rust: out
}
pub fn shift_down(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.has_shift_down()
}
    /// The open screen's book for `hasClickedOutside`: (visible, selected tab
    /// hovered); None when the screen has no book.
    // rust: pub(super) fn recipe_book_area(&self, batch: &HudBatch) -> Option<(bool, bool)> {
    // rust: let book = self.active_book()?;
    // rust: if !self.book_open(book) {
    // rust: return Some((false, false));
}
    // rust: let (xo, yo) = self.book_origin(batch);
    // rust: let tabs = &self.recipe_ui.view.tabs;
    // rust: let selected = self.recipe_ui.tab.unwrap_or(Tab::Search);
    // rust: let hovered = tabs.iter().position(|t| *t == selected).is_some_and(|n| {
    // rust: let (x, y) = self.tab_pos(xo, yo, n);
    // rust: inside(self.cursor, x, y, 35.0, 27.0)
    // rust: });
    // rust: Some((true, hovered))
}
    /// The grid, result and furnace slots clicks on which end a ghost recipe.
pub fn is_book_slot(self: *Self, book: BookType, slot: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match book {
    // rust: BookType::Crafting => (100..109).contains(&slot) || slot == 200,
    // rust: _ => (300..303).contains(&slot),
}
}
    /// `OverlayRecipeComponent.init`.
pub fn open_overlay(self: *Self, button: *Button, bx: f32, by: f32, xo: f32, yo: f32) void {
}
    // rust: let mut entries: Vec<(usize, bool)> =
    // rust: button.entries.iter().copied().filter(|e| e.1).collect();
    // rust: entries.extend(button.entries.iter().copied().filter(|e| !e.1));
    // rust: let (x, y) =
    // rust: screen::overlay_origin(bx as i32, by as i32, entries.len(), xo as i32, yo as i32);
    // rust: let (x, y) = (x as f32, y as f32);
    // rust: self.recipe_ui.overlay = Some(Overlay { x, y, entries });
}

    // ---- placing a recipe ----

    /// What the book's click handler does once a recipe was placed: a book
    /// that is not offset next to the menu (`!isOffsetNextToMainGUI`, a window
    /// narrower than `NARROW`) closes with `setVisible(false)`.
pub fn close_narrow_book(self: *Self, book_type: BookType, batch: *HudBatch) void {
}
    // rust: if batch.width >= NARROW {
    // rust: return;
}
    // rust: self.level.recipe_book.open[book_type.index()] = false;
    // rust: self.send_book_settings(book_type);
    // rust: self.recipe_ui.overlay = None;
}
    /// `RecipeBookComponent.tryPlaceRecipe`: false when the click is refused.
pub fn try_place(self: *Self, entry_index: usize, use_max: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(book_type) = self.active_book() else {
    // rust: return false;
}
    // rust: let Some(id) = self
    // rust: .recipe_ui
    // rust: .book
    // rust: .as_ref()
    // rust: .and_then(|b| b.entries.get(entry_index))
    // rust: .map(|e| e.id.clone())
    // rust: else {
    // rust: return false;
}
    // rust: let button_craftable = self
    // rust: .recipe_ui
    // rust: .view
    // rust: .buttons
    // rust: .iter()
    // rust: .flat_map(|b| b.entries.iter())
    // rust: .any(|e| e.0 == entry_index && e.1);
    // rust: if !button_craftable && self.recipe_ui.last_placed.as_deref() == Some(id.as_str()) {
    // rust: return false;
}
    // rust: self.recipe_ui.last_placed = Some(id);
    // rust: self.recipe_ui.ghost.clear();
    // rust: self.place_recipe(book_type, entry_index, use_max);
    // rust: true
}
    /// Whether the open screen takes `native_place_recipe`: a crafting grid's
    /// book (the inventory's or a crafting table's).
    // rust: pub(super) fn mod_recipe_screen(&self) -> bool {
    // rust: self.screen == Screen::Inventory
    // rust: && self.active_book() == Some(BookType::Crafting)
    // rust: && !self.spectator()
}
    /// `native_place_recipe`: the book's click on the recipe with this display
    /// id, refused as `handlePlaceRecipe` refuses it (no crafting screen,
    /// not in the player's book; an impossible one in `place_recipe`).
    // rust: pub(super) fn mod_place_recipe(&mut self, display_id: i32, all: bool) {
    // rust: if !self.mod_recipe_screen() || !self.recipe_ui.client.displays().contains(&display_id) {
    // rust: return;
}
    // rust: self.ensure_book();
    // rust: let Some(index) = self
    // rust: .recipe_ui
    // rust: .book
    // rust: .as_ref()
    // rust: .and_then(|b| b.entries.iter().position(|e| e.display_id == display_id))
    // rust: else {
    // rust: return;
}
    // rust: self.recipe_ui.ghost.clear();
    // rust: self.place_recipe(BookType::Crafting, index, all);
}
    /// `ServerboundPlaceRecipePacket`: the server places the recipe
    /// (`ServerPlaceRecipe` on the menu engine) and answers with a ghost
    /// recipe when the items are missing.
pub fn place_recipe(self: *Self, book_type: BookType, entry_index: usize, use_max: bool) void {
}
    // rust: let Some(entry) = self
    // rust: .recipe_ui
    // rust: .book
    // rust: .as_ref()
    // rust: .and_then(|b| b.entries.get(entry_index))
    // rust: .cloned()
    // rust: else {
    // rust: return;
}
    // rust: if self.remote.is_some() {
            // The server places it and answers with the slots, or a ghost.
    // rust: let container = self.remote_menu_id();
    // rust: self.send(horizon_protocol::packets::play::Serverbound::PlaceRecipe(
    // rust: horizon_protocol::packets::recipes::PlaceRecipe {
    // rust: container,
    // rust: recipe: entry.display_id,
    // rust: use_max,
    // rust: },
    // rust: ));
    // rust: return;
}
    // rust: let creative = self.creative;
    // rust: let mut post = None;
    // rust: let answer = &mut post;
    // rust: self.menu_session(|menu, env, _| {
            // handlePlaceRecipe: an impossible recipe is refused outright.
    // rust: if env
    // rust: .recipes
    // rust: .placement(&entry.id)
    // rust: .is_none_or(|p| p.impossible())
    // rust: {
    // rust: return Some(false);
}
    // rust: *answer = Some(menu.place_recipe(env, &entry.id, use_max, creative, None));
    // rust: Some(true)
    // rust: });
    // rust: if post == Some(PostPlace::Ghost) {
    // rust: self.fill_ghost(book_type, &entry);
}
    // rust: self.recipe_book_changed();
}
    /// The container changed under the book: comparators and saving.
pub fn recipe_book_changed(self: *Self) void {
}
    // rust: if let Some(key) = self.container {
    // rust: self.world.modified.insert((key.0 >> 4, key.2 >> 4));
    // rust: self.container_changed(key);
}
}

    // ---- a server's recipe book ----

    /// ClientboundRecipeBookAddPacket (`ClientRecipeBook.add`): the
    /// displays join the book, highlighted when new, and the recipes whose
    /// entries ask for it show the toast.
    // rust: pub(super) fn remote_recipe_book_add(
    // rust: &mut self,
    // rust: p: horizon_protocol::packets::recipes::RecipeBookAdd,
    // rust: ) {
    // rust: let ui = &mut self.recipe_ui;
    // rust: if p.replace {
    // rust: ui.client.clear();
}
    // rust: let mut toast = Vec::new();
    // rust: for e in &p.entries {
    // rust: ui.client.add(e.id);
    // rust: if e.flags & 2 != 0 {
    // rust: ui.client.highlight.insert(e.id);
}
    // rust: if e.flags & 1 != 0
    // rust: && let Some(id) = world_stations!(self).recipe_index.recipe_of_display(e.id)
    // rust: && !toast.iter().any(|t| t == id)
    // rust: {
    // rust: toast.push(id.to_owned());
}
}
        // A local world opened later syncs its book from scratch.
    // rust: ui.client_known = None;
    // rust: ui.client_version += 1;
    // rust: self.recipe_toast(&toast);
}
    /// ClientboundRecipeBookRemovePacket.
    // rust: pub(super) fn remote_recipe_book_remove(
    // rust: &mut self,
    // rust: p: horizon_protocol::packets::recipes::RecipeBookRemove,
    // rust: ) {
    // rust: for id in p.ids {
    // rust: self.recipe_ui.client.remove(id);
}
    // rust: self.recipe_ui.client_version += 1;
}
    /// ClientboundRecipeBookSettingsPacket: each book's open and filter flags.
    // rust: pub(super) fn remote_recipe_book_settings(
    // rust: &mut self,
    // rust: p: horizon_protocol::packets::recipes::RecipeBookSettings,
    // rust: ) {
    // rust: for (i, (open, filtering)) in p.books.into_iter().enumerate() {
    // rust: self.level.recipe_book.open[i] = open;
    // rust: self.level.recipe_book.filtering[i] = filtering;
}
}
    /// ClientboundPlaceGhostRecipePacket: the recipe last placed, faded into
    /// the open menu's grid.
    // rust: pub(super) fn remote_ghost_recipe(
    // rust: &mut self,
    // rust: p: horizon_protocol::packets::recipes::PlaceGhostRecipe,
    // rust: ) {
    // rust: let open = self.remote_menu_id();
    // rust: let Some(book_type) = self.active_book() else {
    // rust: return;
}
    // rust: if p.container != open {
    // rust: return;
}
    // rust: let entry = self.recipe_ui.last_placed.as_ref().and_then(|id| {
    // rust: let book = self.recipe_ui.book.as_ref()?;
    // rust: book.entry(id).cloned()
    // rust: });
    // rust: if let Some(entry) = entry {
    // rust: self.recipe_ui.ghost.clear();
    // rust: self.fill_ghost(book_type, &entry);
}
}

    // ---- ghost recipe ----

    /// `fillGhostRecipe`: the recipe's ingredients faded into the slots.
pub fn fill_ghost(self: *Self, book_type: BookType, entry: *Entry) void {
}
    // rust: let grid = self.craft_size;
    // rust: let fuel_empty = self.slot_mut(301).is_none();
    // rust: let Some(book) = self.recipe_ui.book.as_ref() else {
    // rust: return;
}
    // rust: let ghost = book
    // rust: .ghost(entry, book_type, grid, fuel_empty, self.items())
    // rust: .into_iter()
    // rust: .map(|g| Ghost {
    // rust: slot: match (g.target, book_type) {
    // rust: (GhostTarget::Result, BookType::Crafting) => 200,
    // rust: (GhostTarget::Result, _) => 302,
    // rust: (GhostTarget::Grid(i), _) => 100 + i,
    // rust: (GhostTarget::Input, _) => 300,
    // rust: (GhostTarget::Fuel, _) => 301,
    // rust: },
    // rust: result: g.target == GhostTarget::Result,
    // rust: items: g.items,
    // rust: })
    // rust: .collect();
    // rust: self.recipe_ui.ghost = ghost;
}

    // ---- drawing ----

    /// The book button, ghost recipe and the open book.
    // rust: pub(super) fn draw_recipe_book(&mut self, batch: &mut HudBatch) {
    // rust: let Some(book_type) = self.active_book() else {
    // rust: return;
}
    // rust: self.ensure_book();
    // rust: if !self.shift_down_or_ctrl() {
    // rust: self.recipe_ui.time += self.frame_ticks;
}
    // rust: let (ox, _) = self.inventory_origin(batch);
    // rust: let cursor = self.cursor;
    // rust: let (bx, by) = self.book_button_pos(book_type, ox, batch);
    // rust: let hover = inside(cursor, bx, by, 20.0, 18.0);
    // rust: batch.sprite(
    // rust: &self.gui.atlas,
    // rust: &sprite(if hover {
    // rust: "button_highlighted"
    // rust: } else {
    // rust: "button"
    // rust: }),
    // rust: bx,
    // rust: by,
    // rust: );
    // rust: self.draw_ghost(batch, book_type);
    // rust: if self.book_open(book_type) {
    // rust: self.refresh_book_view(book_type);
    // rust: self.draw_book_panel(batch, book_type);
}
    // rust: self.narrate_recipe_book(batch, book_type, [bx, by, 20.0, 18.0]);
}
    /// `AbstractRecipeBookScreen`'s narratables: the book button (an
    /// `ImageButton` without a message) and the `RecipeBookComponent`, which
    /// narrates its recipe buttons, search box, filter and tabs while open.
pub fn narrate_recipe_book(self: *Self, batch: *HudBatch, book_type: BookType, button: [f32; 4]) void {
}
//         use horizon_client::widgets::{self, Narratable, key_of};
    // rust: if !widgets::narrating() {
    // rust: return;
}
        // The button moves with the book: it keeps the focus a click gave it.
    // rust: widgets::narratable(|| {
    // rust: Narratable::button("", button, true).key(key_of(&"recipe_book/button"))
    // rust: });
    // rust: let open = self.book_open(book_type);
    // rust: let (xo, yo) = self.book_origin(batch);
    // rust: let group = key_of(&"recipe_book");
    // rust: widgets::narratable(|| Narratable::group(open, [xo, yo, WIDTH, HEIGHT]).key(group));
    // rust: if !open {
    // rust: return;
}
    // rust: let in_book = |n: Narratable, i: usize| n.key(key_of(&(group, i))).in_group(group);
    // rust: let ui = &self.recipe_ui;
    // rust: let first = ui.page * 20;
    // rust: let shown = ui.view.buttons.iter().skip(first).take(20);
    // rust: if let Some(book) = ui.book.as_ref() {
    // rust: for (n, b) in shown.enumerate() {
    // rust: widgets::narratable(|| {
                    // RecipeButton: the result it shows now.
    // rust: let results: Vec<Vec<ItemStack>> = b
    // rust: .entries
    // rust: .iter()
    // rust: .map(|e| vec![book.entries[e.0].result.clone()])
    // rust: .collect();
    // rust: let stack = screen::display_stack(&results, self.swap_index());
    // rust: let names = |id: &str| self.pack.names.display_item(id);
    // rust: let item = horizon_client::stations::hover_name(&names, &stack);
    // rust: let (x, y) = Self::button_pos(xo, yo, n);
    // rust: in_book(
    // rust: Narratable::recipe(item, b.entries.len() > 1, [x, y, 25.0, 25.0]),
    // rust: n,
    // rust: )
    // rust: });
}
}
    // rust: let tr = |key: &str, args: &[&str]| horizon_client::screen_narrator::translate(key, args);
    // rust: if let Some(search) = &ui.search {
    // rust: widgets::narratable(|| {
    // rust: Narratable::edit_box(
    // rust: tr("itemGroup.search", &[]),
    // rust: search.value.clone(),
    // rust: [xo + 25.0, yo + 13.0, 81.0, 14.0],
    // rust: )
    // rust: .focused(search.focused)
    // rust: .key(key_of(&(group, "search")))
    // rust: .in_group(group)
    // rust: });
}
    // rust: widgets::narratable(|| {
            // A CycleButton of no name that hides its label: ": <value>",
            // the value's tooltip.
    // rust: let label = |filtering: bool| {
    // rust: tr(
    // rust: if !filtering {
    // rust: "gui.recipebook.toggleRecipes.all"
    // rust: } else {
    // rust: match book_type {
    // rust: BookType::Crafting => "gui.recipebook.toggleRecipes.craftable",
    // rust: BookType::Furnace => "gui.recipebook.toggleRecipes.smeltable",
    // rust: BookType::BlastFurnace => "gui.recipebook.toggleRecipes.blastable",
    // rust: BookType::Smoker => "gui.recipebook.toggleRecipes.smokable",
}
    // rust: },
    // rust: &[],
    // rust: )
}
    // rust: let filtering = self.book_filtering(book_type);
    // rust: let full = |filtering| tr("options.generic_value", &["", &label(filtering)]);
    // rust: Narratable::cycle(
    // rust: full(filtering),
    // rust: full(!filtering),
    // rust: [xo + 110.0, yo + 12.0, 26.0, 16.0],
    // rust: true,
    // rust: )
    // rust: .hint(label(filtering))
    // rust: .key(key_of(&(group, "filter")))
    // rust: .in_group(group)
    // rust: });
    // rust: for n in 0..ui.view.tabs.len() {
    // rust: let (x, y) = self.tab_pos(xo, yo, n);
    // rust: widgets::narratable(|| {
    // rust: Narratable::button("", [x, y, 35.0, 27.0], true)
    // rust: .key(key_of(&(group, "tab", n)))
    // rust: .in_group(group)
    // rust: });
}
}
pub fn shift_down_or_ctrl(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.has_control_down()
}
    /// `GhostSlots.extractRenderState`, among the container's slots.
pub fn draw_ghost(self: *Self, batch: *mut HudBatch, book_type: BookType) void {
}
    // rust: if self.recipe_ui.ghost.is_empty() {
    // rust: return;
}
    // rust: let (ox, oy) = self.inventory_origin(batch);
    // rust: let big_result = book_type != BookType::Crafting || self.craft_size == 3;
    // rust: let ghosts: Vec<GhostView> = self
    // rust: .recipe_ui
    // rust: .ghost
    // rust: .iter()
    // rust: .map(|g| {
    // rust: let (sx, sy) = self.slot_position(g.slot);
    // rust: GhostView {
    // rust: x: sx as i32,
    // rust: y: sy as i32,
    // rust: items: g.items.clone(),
    // rust: result: g.result,
}
    // rust: })
    // rust: .collect();
    // rust: let calls = screen::ghost(self.swap_index(), ox as i32, oy as i32, big_result, &ghosts);
    // rust: self.paint_book(batch, &calls);
}
    /// `GhostSlots.extractTooltip`: the stack a ghost shows on menu slot
    /// `slot` now, cycling like its draw; only while the open book is visible
    /// (`RecipeBookComponent.extractTooltip`).
    // rust: pub(super) fn ghost_stack(&self, slot: usize) -> Option<ItemStack> {
    // rust: if !self.book_open(self.active_book()?) {
    // rust: return None;
}
    // rust: let ghost = self
    // rust: .recipe_ui
    // rust: .ghost
    // rust: .iter()
    // rust: .find(|g| g.slot == slot && !g.items.is_empty())?;
    // rust: Some(ghost.items[self.swap_index() % ghost.items.len()].clone())
}
    /// `RecipeBookComponent.extractRenderState` and `extractTooltip`, laid
    /// out by `horizon_client::recipe_book_screen`.
pub fn draw_book_panel(self: *Self, batch: *mut HudBatch, book_type: BookType) void {
}
    // rust: let (xo, yo) = self.book_origin(batch);
    // rust: let cursor = self.cursor;
    // rust: let atlas = &self.gui.atlas;
    // rust: let search = match self.recipe_ui.search.as_mut() {
    // rust: Some(edit) => {
                // The box's place, for clicks and typing.
    // rust: edit.x = xo + 25.0;
    // rust: edit.y = yo + 13.0;
    // rust: let (display, blink_ms) = edit.view_state(atlas);
    // rust: Search {
    // rust: value: edit.value.clone(),
    // rust: cursor: edit.cursor,
    // rust: highlight: edit.highlight,
    // rust: display,
    // rust: focused: edit.focused,
    // rust: blink_ms,
}
}
    // rust: None => Search::default(),
}
    // rust: let ui = &self.recipe_ui;
    // rust: let current = ui
    // rust: .tab
    // rust: .filter(|t| ui.view.tabs.contains(t))
    // rust: .unwrap_or(Tab::Search);
    // rust: let tabs: Vec<TabView> = ui
    // rust: .view
    // rust: .tabs
    // rust: .iter()
    // rust: .map(|tab| {
    // rust: let (a, b) = tab.icons();
    // rust: TabView {
    // rust: icons: (a.to_owned(), b.map(str::to_owned)),
    // rust: selected: *tab == current,
    // rust: anim: ui
    // rust: .tab_anim
    // rust: .iter()
    // rust: .find(|e| e.0 == *tab)
    // rust: .map_or(0.0, |e| e.1),
}
    // rust: })
    // rust: .collect();
    // rust: let pages = ui.view.buttons.len().div_ceil(20);
    // rust: let first = ui.page * 20;
    // rust: let (buttons, overlay) = match ui.book.as_ref() {
    // rust: Some(book) => {
    // rust: let buttons: Vec<ButtonView> = ui
    // rust: .view
    // rust: .buttons
    // rust: .iter()
    // rust: .enumerate()
    // rust: .skip(first)
    // rust: .take(20)
    // rust: .map(|(n, b)| ButtonView {
    // rust: has_craftable: b.craftable(),
    // rust: entries: b
    // rust: .entries
    // rust: .iter()
    // rust: .map(|e| vec![book.entries[e.0].result.clone()])
    // rust: .collect(),
    // rust: anim: ui
    // rust: .button_anim
    // rust: .iter()
    // rust: .find(|e| e.0 == n)
    // rust: .map_or(0.0, |e| e.1),
    // rust: })
    // rust: .collect();
    // rust: let overlay = ui.overlay.as_ref().map(|o| OverlayView {
    // rust: x: o.x as i32,
    // rust: y: o.y as i32,
    // rust: recipes: o
    // rust: .entries
    // rust: .iter()
    // rust: .map(|&(i, craftable)| OverlayRecipe {
    // rust: craftable,
    // rust: cells: screen::overlay_cells(book, &book.entries[i]),
    // rust: })
    // rust: .collect(),
    // rust: });
    // rust: (buttons, overlay)
}
    // rust: None => (Vec::new(), None),
}
    // rust: let translate = |key: &str| self.translate(key, key);
    // rust: let text_width = |s: &str| HudBatch::text_width(atlas, s) as i32;
    // rust: let layout = Layout {
    // rust: book: book_type,
    // rust: width: batch.width as i32,
    // rust: height: batch.height as i32,
    // rust: narrow: batch.width < NARROW,
    // rust: mouse: (cursor.0.floor() as i32, cursor.1.floor() as i32),
    // rust: index: self.swap_index(),
    // rust: filtering: self.book_filtering(book_type),
    // rust: search: &search,
    // rust: tabs: &tabs,
    // rust: buttons: &buttons,
    // rust: page: ui.page,
    // rust: pages,
    // rust: overlay: overlay.as_ref(),
    // rust: ghost: None,
    // rust: translate: &translate,
    // rust: text_width: &text_width,
}
    // rust: let calls = screen::draw(&layout);
    // rust: let tooltip = self.paint_book(batch, &calls);
        // The squeeze animations run down with the frames.
    // rust: let frame = self.frame_ticks;
    // rust: for e in &mut self.recipe_ui.tab_anim {
    // rust: e.1 -= frame;
}
    // rust: for e in &mut self.recipe_ui.button_anim {
    // rust: e.1 -= frame;
}
    // rust: self.recipe_ui.tab_anim.retain(|e| e.1 > 0.0);
    // rust: self.recipe_ui.button_anim.retain(|e| e.1 > 0.0);
    // rust: if let Some(lines) = tooltip {
    // rust: self.draw_tooltip_lines(batch, &lines, cursor.0, cursor.1);
}
}
    /// Paints recipe book calls; returns the first tooltip set (vanilla keeps
    /// the first one a frame asks for).
    // rust: fn paint_book(
    // rust: &mut self,
    // rust: batch: &mut HudBatch,
    // rust: calls: &[Drawn],
    // rust: ) -> Option<Vec<(horizon_client::text::Text, u32)>> {
    // rust: let mut tooltip: Option<Vec<(horizon_client::text::Text, u32)>> = None;
    // rust: for d in calls {
    // rust: let start = batch.vertices.len();
    // rust: let atlas = &self.gui.atlas;
    // rust: match &d.call {
    // rust: Call::Blit {
    // rust: x, y, w, h, u, v, ..
    // rust: } => {
    // rust: if let Some(r) = atlas.sprites.get("gui/recipe_book").copied() {
    // rust: let (w, h) = (*w as f32, *h as f32);
    // rust: batch.rect_uv(
    // rust: *x as f32,
    // rust: *y as f32,
    // rust: w,
    // rust: h,
    // rust: sub_rect(r, [*u, *v, w, h]),
    // rust: u32::MAX,
    // rust: );
}
}
    // rust: Call::Sprite { id, x, y, w, h } => {
    // rust: let name = format!("gui/sprites/{id}");
    // rust: let native = atlas
    // rust: .sprites
    // rust: .get(&name)
    // rust: .is_some_and(|r| r.w as i32 == *w && r.h as i32 == *h);
    // rust: if native {
    // rust: batch.sprite(atlas, &name, *x as f32, *y as f32);
    // rust: } else {
    // rust: horizon_client::ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: &name,
    // rust: *x as f32,
    // rust: *y as f32,
    // rust: *w as f32,
    // rust: *h as f32,
    // rust: u32::MAX,
    // rust: );
}
}
    // rust: Call::Fill {
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
    // rust: argb(*color),
    // rust: ),
    // rust: Call::Highlight { x0, y0, x1, y1 } => {
    // rust: let (a, b) = (*x0.min(x1), *x0.max(x1));
    // rust: batch.text_highlight(
    // rust: atlas,
    // rust: (a as f32, *y0 as f32, (b - a) as f32, (y1 - y0) as f32),
    // rust: true,
    // rust: );
}
    // rust: Call::Text {
    // rust: runs,
    // rust: x,
    // rust: y,
    // rust: color,
    // rust: shadow,
    // rust: } => {
    // rust: let mut x = *x as f32;
    // rust: for r in runs {
    // rust: let style = Style {
    // rust: color: (r.color >= 0).then_some(r.color as u32),
    // rust: italic: r.italic.then_some(true),
    // rust: ..Style::default()
}
    // rust: let t = Text::styled(r.text.clone(), style);
    // rust: batch.text_styled(atlas, &t, x, *y as f32, argb(*color), *shadow);
    // rust: x += atlas.font.width_text(&t);
}
}
    // rust: Call::Item { call, stack, x, y } => match call {
    // rust: ItemCall::Item | ItemCall::Fake => {
    // rust: self.draw_item_model(batch, stack, *x as f32, *y as f32)
}
    // rust: ItemCall::Decorations => {
    // rust: self.draw_item_decorations(batch, stack, *x as f32, *y as f32, None)
}
    // rust: },
    // rust: Call::Tooltip(lines) => {
    // rust: if tooltip.is_none() {
    // rust: tooltip = Some(
    // rust: lines
    // rust: .iter()
    // rust: .map(|l| {
    // rust: (
    // rust: horizon_client::text::Text::literal(
    // rust: l.iter().map(|r| r.text.as_str()).collect::<String>(),
    // rust: ),
    // rust: u32::MAX,
    // rust: )
    // rust: })
    // rust: .collect(),
    // rust: );
}
}
    // rust: Call::ItemTooltip { stack, more } => {
    // rust: if tooltip.is_none() {
    // rust: let mut lines = self.stack_tooltip(stack);
    // rust: if *more {
    // rust: lines.push((
    // rust: horizon_client::text::Text::literal(self.translate(
    // rust: "gui.recipebook.moreRecipes",
    // rust: "Right Click for More",
    // rust: )),
    // rust: u32::MAX,
    // rust: ));
}
    // rust: tooltip = Some(lines);
}
}
    // rust: Call::Stratum => {}
}
    // rust: if d.pose != screen::IDENTITY {
    // rust: let m = d.pose;
    // rust: for v in &mut batch.vertices[start..] {
    // rust: let [x, y] = v.pos;
    // rust: v.pos = [m[0] * x + m[2] * y + m[4], m[1] * x + m[3] * y + m[5]];
}
}
}
    // rust: tooltip
}
}

/// An ARGB colour as a HUD vertex colour.
pub fn argb(c: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = c as u32;
    // rust: rgba((c >> 16) as u8, (c >> 8) as u8, c as u8, (c >> 24) as u8)
}

/// A sub-rectangle of a sprite given in texels.
pub fn sub_rect(r: Rect, h]: [f32; 4]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (du, dv) = ((r.u1 - r.u0) / r.w as f32, (r.v1 - r.v0) / r.h as f32);
    // rust: Rect {
    // rust: u0: r.u0 + x * du,
    // rust: v0: r.v0 + y * dv,
    // rust: u1: r.u0 + (x + w) * du,
    // rust: v1: r.v0 + (y + h) * dv,
    // rust: w: w as u32,
    // rust: h: h as u32,
}
}
