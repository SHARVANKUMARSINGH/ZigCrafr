//! Transpiled from Horizon Rust crate
package horizon_client_native_panel

import "core:fmt"
import "core:mem"
import "core:math"

// The item panel beside container screens: the items a recipe viewer mod
// lists (a native mod's `native_panel_items`, or WIT `interface browser`
// of a WebAssembly mod, docs/mods.md), drawn as the game's own item slots
// in pages right of the screen's window, with a search box under them. The
// mod says what the panel holds; the game pages it and tells the mod what
// the player clicked, typed, and which keys went down over an item
// (`native_panel_event`). With no mod showing a panel, each hook here
// returns after one check.
// use super::{
    // rust: Game, Screen,
    // rust: native_hooks::{NativePanelEvent as BrowserEvent, NativeStack as BrowserStack},
    // rust: native_panel_recipes::RecipePage,
}
// use horizon_client::{
    // rust: hud::{HudBatch, rgba},
    // rust: items::ItemStack,
    // rust: ui::EditBox,
}

// One slot of the panel, in GUI pixels.
SLOT :: 18.0
// The most columns the panel takes, and the fewest it shows with.
COLUMNS :: (12, 2)
// The gap between the window and the panel, and the screen's edges.
MARGIN :: 8.0

// Items a panel may hold.
ITEMS :: 8192

// Whose panel it is: a native mod's id.
    // rust: pub(super) enum Owner {
    // rust: Native(String),
}
    // rust: impl Owner {
native_id :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let Owner::Native(id) = self;
    // rust: id
}
}

// What a mod shows on the panel: its items, and the recipes shown in
// their place.
    // rust: pub(super) struct Shown {
    // rust: pub(super) owner: Owner,
    // Which change the panel is from, so the game converts it once.
    // rust: pub(super) version: u64,
    // rust: pub(super) items: Vec<BrowserStack>,
    // rust: pub(super) recipes: Option<RecipePage>,
}

// The panel's state in the game.
    // rust: pub(super) struct Panel {
    // A native mod's panel: the last one to show something.
    // rust: native: Option<Shown>,
    // The last native change.
    // rust: versions: u64,
    // The items' owner and version they were made from.
    // rust: of: Option<(Owner, u64)>,
    // The mod's items as stacks; `None` for an item the game doesn't have.
    // rust: stacks: Vec<Option<ItemStack>>,
    // rust: page: usize,
    // rust: search: Option<EditBox>,
    // The search text the mod last heard.
    // rust: sent: String,
    // The recipes shown instead of the items.
    // rust: pub(super) recipes: Option<super::native_panel_recipes::Pages>,
}

    // rust: impl Panel {
    // What the panel shows: a native mod's, one `on`.
    // rust: pub(super) fn shown(&self, on: impl Fn(&str) -> bool) -> Option<&Shown> {
    // rust: self.native.as_ref().filter(|s| on(s.owner.native_id()))
}
    // `native_panel_items`.
    // rust: pub(super) fn show_items(&mut self, mod_id: &str, mut items: Vec<BrowserStack>) {
    // rust: items.truncate(ITEMS);
    // rust: if let Some(shown) = self.native_of(mod_id, !items.is_empty()) {
    // rust: shown.items = items;
    // rust: self.native_changed();
}
}
    // `native_panel_recipes`.
    // rust: pub(super) fn show_recipes(&mut self, mod_id: &str, page: Option<RecipePage>) {
    // rust: if let Some(shown) = self.native_of(mod_id, page.is_some()) {
    // rust: shown.recipes = page;
    // rust: self.native_changed();
}
}
    // Mod `mod_id`'s panel, made when it shows something on another's;
    // none when it clears a panel that isn't its own.
native_of :: proc(self: ^Self, mod_id: string, showing: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let own = self
    // rust: .native
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.owner.native_id() == mod_id);
    // rust: if !own {
    // rust: if !showing {
    // rust: return None;
}
    // rust: self.native = Some(Shown {
    // rust: owner: Owner::Native(mod_id.to_owned()),
    // rust: version: 0,
    // rust: items: Vec::new(),
    // rust: recipes: None,
    // rust: });
}
    // rust: self.native.as_mut()
}
    // A native panel changed: a new version, and no panel once it shows
    // nothing.
native_changed :: proc(self: ^Self) {
}
    // rust: self.versions += 1;
    // rust: if let Some(shown) = self.native.as_mut() {
    // rust: shown.version = self.versions;
    // rust: if shown.items.is_empty() && shown.recipes.is_none() {
    // rust: self.native = None;
}
}
}
}

// Where the panel's parts are this frame.
    // rust: pub(super) struct Layout {
    // The panel's whole area, for clicks that hit none of its parts.
    // rust: pub(super) area: [f32; 4],
    // The grid's top left corner, its columns and rows.
    // rust: pub(super) grid: (f32, f32),
    // rust: pub(super) columns: usize,
    // rust: pub(super) rows: usize,
    // The page arrows' row.
    // rust: pub(super) arrows_y: f32,
    // rust: pub(super) search: [f32; 4],
}
    // rust: impl Layout {
per_page :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.columns * self.rows
}
    // rust: pub(super) fn width(&self) -> f32 {
    // rust: self.columns as f32 * SLOT
}
slot :: proc(self: ^Self, n: uint) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: self.grid.0 + (n % self.columns) as f32 * SLOT,
    // rust: self.grid.1 + (n / self.columns) as f32 * SLOT,
    // rust: )
}
    // The page arrows: backward, then forward.
    // rust: pub(super) fn arrows(&self) -> [(f32, f32); 2] {
    // rust: [
    // rust: (self.grid.0, self.arrows_y),
    // rust: (self.grid.0 + self.width() - 12.0, self.arrows_y),
    // rust: ]
}
}

    // rust: pub(super) fn inside(p: (f32, f32), [x, y, w, h]: [f32; 4]) -> bool {
    // rust: p.0 >= x && p.1 >= y && p.0 < x + w && p.1 < y + h
}

    // rust: impl Game<'_> {
browser_batch :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let r = self.renderer.as_ref()?;
    // rust: Some(HudBatch::new([r.config.width, r.config.height]))
}
    // The mod showing a panel, with its items made into stacks once per
    // change; none while no mod shows one or no container screen is up.
browser_sync :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.screen != Screen::Inventory || self.title.is_some() {
    // rust: return None;
}
    // rust: let disabled = &self.settings.mods.disabled;
    // rust: let Some(shown) = self.panel.shown(|id| !disabled.contains(id)) else {
    // rust: self.panel.of = None;
    // rust: self.panel.stacks.clear();
    // rust: return None;
}
    // rust: let of = (shown.owner.clone(), shown.version);
    // rust: if self.panel.of.as_ref() != Some(&of) {
    // rust: let items = world_items!(self);
    // rust: let stacks = shown
    // rust: .items
    // rust: .iter()
    // rust: .map(|s| browser_stack(items, s))
    // rust: .collect();
    // rust: let shown = shown.recipes.clone();
    // rust: self.panel.stacks = stacks;
            // The same title again (the mod updating its buttons) keeps the page.
    // rust: let old = self.panel.recipes.take();
    // rust: self.panel.recipes = shown
    // rust: .as_ref()
    // rust: .map(|shown| super::native_panel_recipes::Pages::new(items, shown, old));
    // rust: self.panel.of = Some(of.clone());
}
    // rust: Some(of.0)
}
    // What the panel shows now.
panel_shown :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let disabled = &self.settings.mods.disabled;
    // rust: self.panel.shown(|id| !disabled.contains(id))
}
    // The player did `event` on `owner`'s panel.
    // rust: pub(super) fn panel_event(&mut self, owner: &Owner, event: BrowserEvent) {
    // rust: let Owner::Native(id) = owner;
    // rust: self.native_panel_event(id, &event);
}
    // The panel's parts: right of the window, from the top of the screen to
    // the search box at its foot. None when the screen has no room for it.
browser_layout :: proc(self: ^Self, batch: ^HudBatch) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let image = self.container_image(batch);
    // rust: let left = (image.left + image.width) as f32 + MARGIN;
    // rust: let right = batch.width - MARGIN;
    // rust: let columns = (((right - left) / SLOT).floor().max(0.0) as usize).min(COLUMNS.0);
    // rust: if columns < COLUMNS.1 {
    // rust: return None;
}
    // rust: let x = (left + (right - left - columns as f32 * SLOT) / 2.0).floor();
    // rust: let arrows_y = MARGIN;
    // rust: let top = arrows_y + 17.0 + 4.0;
    // rust: let search = [x, batch.height - MARGIN - 16.0, columns as f32 * SLOT, 16.0];
    // rust: let rows = ((search[1] - 4.0 - top) / SLOT).floor().max(0.0) as usize;
    // rust: (rows > 0).then_some(Layout {
    // rust: area: [left, 0.0, right - left, batch.height],
    // rust: grid: (x, top),
    // rust: columns,
    // rust: rows,
    // rust: arrows_y,
    // rust: search,
    // rust: })
}
browser_pages :: proc(self: ^Self, layout: ^Layout) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.panel.stacks.len().div_ceil(layout.per_page()).max(1)
}
    // The stack under the pointer on the panel, an item's or a recipe's,
    // as the mod sent it and as a stack.
browser_pointed_stack :: proc(self: ^Self, layout: ^Layout) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.panel.recipes.is_some() {
    // rust: if let Some((_, sent, stack)) = self.recipe_tab_hovered(layout) {
    // rust: return Some((sent, stack));
}
    // rust: let (_, _, sent, stack) = self.recipe_slot_hovered(layout)?;
    // rust: return Some((sent, stack));
}
    // rust: let (index, stack) = self.browser_hovered(layout)?;
    // rust: let items = &self.panel_shown()?.items;
    // rust: Some((items.get(index)?.clone(), stack))
}
    // The panel's item under the pointer: its index and stack.
browser_hovered :: proc(self: ^Self, layout: ^Layout) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.panel.recipes.is_some() {
    // rust: return None;
}
    // rust: let first = self.panel.page * layout.per_page();
    // rust: (0..layout.per_page()).find_map(|n| {
    // rust: let (x, y) = layout.slot(n);
    // rust: if !inside(self.cursor, [x, y, SLOT, SLOT]) {
    // rust: return None;
}
    // rust: let stack = self.panel.stacks.get(first + n)?.clone()?;
    // rust: Some((first + n, stack))
    // rust: })
}
browser_search :: proc(self: ^Self, layout: ^Layout) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let search = self.panel.search.get_or_insert_with(|| {
    // rust: let mut edit = EditBox::new(0.0, 0.0, 0.0, 0.0);
    // rust: edit.max_length = 50;
    // rust: edit.focused = false;
    // rust: edit
    // rust: });
    // rust: [search.x, search.y, search.width, search.height] = layout.search;
    // rust: search
}

    // The items' page arrows and grid.
draw_browser_items :: proc(self: ^Self, batch: ^HudBatch, layout: ^Layout) {
}
    // rust: let pages = self.browser_pages(layout);
    // rust: self.panel.page = self.panel.page.min(pages - 1);
    // rust: let page = self.panel.page;
    // rust: let cursor = self.cursor;
    // rust: if pages > 1 {
    // rust: let labels = [
    // rust: self.translate("gui.recipebook.previous_page", "Previous Page"),
    // rust: self.translate("gui.recipebook.next_page", "Next Page"),
    // rust: ];
    // rust: let shown = [page > 0, page + 1 < pages];
    // rust: let atlas = &self.gui.atlas;
    // rust: for (((x, y), name), (label, shown)) in layout
    // rust: .arrows()
    // rust: .into_iter()
    // rust: .zip(["page_backward", "page_forward"])
    // rust: .zip(labels.iter().zip(shown))
    // rust: {
    // rust: if !shown {
    // rust: continue;
}
    // rust: let hover = inside(cursor, [x, y, 12.0, 17.0]);
    // rust: let suffix = if hover { "_highlighted" } else { "" };
    // rust: batch.sprite(
    // rust: atlas,
    // rust: &format!("gui/sprites/recipe_book/{name}{suffix}"),
    // rust: x,
    // rust: y,
    // rust: );
    // rust: horizon_client::widgets::record(label, [x, y, 12.0, 17.0], true);
}
    // rust: let text = format!("{}/{pages}", page + 1);
    // rust: let w = HudBatch::text_width(atlas, &text);
    // rust: let x = (layout.grid.0 + (layout.width() - w) / 2.0).floor();
    // rust: batch.text(atlas, &text, x, layout.arrows_y + 5.0, u32::MAX, true);
}
    // rust: let first = page * layout.per_page();
    // rust: for n in 0..layout.per_page() {
    // rust: let Some(stack) = self.panel.stacks.get(first + n) else {
    // rust: break;
}
    // rust: let Some(stack) = stack.clone() else {
    // rust: continue;
}
    // rust: let (x, y) = layout.slot(n);
    // rust: self.draw_item(batch, &stack, x + 1.0, y + 1.0);
    // rust: let rect = [x + 1.0, y + 1.0, 16.0, 16.0];
    // rust: if inside(cursor, [x, y, SLOT, SLOT]) {
    // rust: batch.fill(
    // rust: &self.gui.atlas,
    // rust: x + 1.0,
    // rust: y + 1.0,
    // rust: 16.0,
    // rust: 16.0,
    // rust: rgba(255, 255, 255, 128),
    // rust: );
}
    // rust: let name = self.pack.names.display_item(&stack.item);
    // rust: horizon_client::widgets::record_as(
    // rust: &name,
    // rust: rect,
    // rust: true,
    // rust: horizon_client::widgets::Kind::Button,
    // rust: );
}
}
    // Draws the panel over the open container screen, then the carried
    // stack or the tooltip again so they stay on top of it.
    // rust: pub(super) fn draw_mod_browser(&mut self, batch: &mut HudBatch) {
    // rust: if self.browser_sync().is_none() {
    // rust: return;
}
    // rust: let Some(layout) = self.browser_layout(batch) else {
    // rust: return;
}
    // rust: let cursor = self.cursor;
    // rust: if self.panel.recipes.is_some() {
    // rust: self.draw_browser_recipes(batch, &layout);
    // rust: } else {
    // rust: self.draw_browser_items(batch, &layout);
}
    // rust: let hint = self.translate("gui.recipebook.search_hint", "Search...");
    // rust: let search = self.browser_search(&layout);
        // The hint shows in an empty box without focus, as the recipe book's.
    // rust: search.suggestion = (search.value.is_empty() && !search.focused).then_some(hint);
    // rust: let mut search = search.clone();
    // rust: search.draw(batch, &self.gui.atlas, None);
    // rust: self.panel.search = Some(search);
    // rust: if self.carried.is_some() {
    // rust: self.draw_carried(batch);
    // rust: } else if let Some(stack) = self.browser_pointed_stack(&layout) {
    // rust: self.draw_stack_tooltip(batch, &stack.1, cursor.0, cursor.1);
    // rust: } else {
    // rust: self.draw_slot_tooltip(batch);
}
}

    // A mouse press on a container screen: true when the panel took it
    // (its search box, page arrows, items or empty space; a click there
    // never throws the carried stack).
    // rust: pub(super) fn mod_browser_press(&mut self, right: bool) -> bool {
    // rust: let Some(owner) = self.browser_sync() else {
    // rust: return false;
}
    // rust: let Some(batch) = self.browser_batch() else {
    // rust: return false;
}
    // rust: let Some(layout) = self.browser_layout(&batch) else {
    // rust: return false;
}
    // rust: let cursor = self.cursor;
    // rust: let shift = self.has_shift_down();
    // rust: let atlas = &self.gui.atlas;
    // rust: let search = self.panel.search.get_or_insert_with(|| {
    // rust: let mut edit = EditBox::new(0.0, 0.0, 0.0, 0.0);
    // rust: edit.max_length = 50;
    // rust: edit
    // rust: });
    // rust: [search.x, search.y, search.width, search.height] = layout.search;
    // rust: if inside(cursor, layout.search) {
    // rust: search.focused = true;
    // rust: search.click(atlas, cursor.0, shift, false);
    // rust: search.reset_blink();
    // rust: return true;
}
    // rust: search.focused = false;
    // rust: if self.panel.recipes.is_some() {
    // rust: return self.browser_recipes_press(&layout, &owner, right)
    // rust: || inside(cursor, layout.area);
}
    // rust: let pages = self.browser_pages(&layout);
    // rust: let page = self.panel.page;
    // rust: let [back, forward] = layout.arrows();
    // rust: let step = if pages > 1 && page > 0 && inside(cursor, [back.0, back.1, 12.0, 17.0]) {
    // rust: Some(page - 1)
    // rust: } else if pages > 1
    // rust: && page + 1 < pages
    // rust: && inside(cursor, [forward.0, forward.1, 12.0, 17.0])
    // rust: {
    // rust: Some(page + 1)
    // rust: } else {
    // rust: None
}
    // rust: if let Some(to) = step {
    // rust: self.panel.page = to;
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: return true;
}
    // rust: if let Some((index, _)) = self.browser_hovered(&layout) {
    // rust: let event = BrowserEvent::Clicked {
    // rust: index: index as u32,
    // rust: right,
}
    // rust: self.panel_event(&owner, event);
    // rust: return true;
}
    // rust: inside(cursor, layout.area)
}

    // Whether keys go to the panel's search box.
    // rust: pub(super) fn mod_browser_typing(&self) -> bool {
    // rust: self.screen == Screen::Inventory
    // rust: && self.panel.of.is_some()
    // rust: && self.panel.search.as_ref().is_some_and(|s| s.focused)
}
    // A key press while the search box has focus.
    // rust: pub(super) fn mod_browser_key(&mut self, event: &winit::event::KeyEvent) {
//         use winit::keyboard::PhysicalKey;
    // rust: let shortcut = self.edit_shortcut(event);
    // rust: let ctrl = self.has_control_down();
    // rust: let shift = self.has_shift_down();
    // rust: let types_text = self.types_text();
    // rust: let Some(search) = self.panel.search.as_mut() else {
    // rust: return;
}
    // rust: if let Some(shortcut) = shortcut {
    // rust: search.shortcut(shortcut, &mut self.clipboard);
    // rust: } else {
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
}
    // rust: search.reset_blink();
    // rust: self.browser_searched();
}
    // Text typed (or one backspace) into the search box (`horizon-ctl type`).
    // rust: pub(super) fn mod_browser_text(&mut self, text: Option<&str>, backspace: bool) {
    // rust: let Some(search) = self.panel.search.as_mut() else {
    // rust: return;
}
    // rust: if backspace {
    // rust: search.delete_chars(-1);
    // rust: } else if let Some(text) = text {
    // rust: search.insert_text(text);
}
    // rust: self.browser_searched();
}
    // The mod hears the search text when it changed.
browser_searched :: proc(self: ^Self) {
}
    // rust: let (Some((owner, _)), Some(search)) = (&self.panel.of, &self.panel.search) else {
    // rust: return;
}
    // rust: if search.value != self.panel.sent {
    // rust: let (owner, value) = (owner.clone(), search.value.clone());
    // rust: self.panel.sent.clone_from(&value);
    // rust: self.panel.page = 0;
    // rust: self.panel_event(&owner, BrowserEvent::Search(value));
}
}
    // The container screen closed: the search box lets go of the keys.
    // rust: pub(super) fn mod_browser_closed(&mut self) {
    // rust: if let Some(search) = self.panel.search.as_mut() {
    // rust: search.focused = false;
}
}
    // The item under the pointer on a container screen, for the mods' keys
    // (the `Key` event): the panel's, else a slot's.
    // rust: pub(super) fn mod_browser_pointed(&mut self) -> Option<BrowserStack> {
    // rust: let batch = self.browser_batch()?;
    // rust: let stack = match self
    // rust: .browser_sync()
    // rust: .and_then(|_| self.browser_layout(&batch))
    // rust: {
            // The panel's stacks as the mod sent them.
    // rust: Some(layout) if inside(self.cursor, layout.area) => {
    // rust: return Some(self.browser_pointed_stack(&layout)?.0);
}
    // rust: _ => {
    // rust: let slot = self.slot_at(&batch, self.cursor.0, self.cursor.1)?;
    // rust: self.slot_view(slot)?
}
}
    // rust: Some(BrowserStack {
    // rust: item: stack.item.to_string(),
    // rust: count: stack.count,
    // rust: components: super::native_recipes::components(&stack),
    // rust: })
}
    // A key `key` (`key.keyboard.r`) went down: over an item on a container
    // screen, a native mod's panel hears it as a `Key` event.
    // rust: pub(super) fn native_panel_key(&mut self, key: &str) {
    // rust: if self.screen != Screen::Inventory || self.title.is_some() || self.mod_browser_typing() {
    // rust: return;
}
    // rust: let Some(owner) = self.browser_sync() else {
    // rust: return;
}
    // rust: if let Some(stack) = self.mod_browser_pointed() {
    // rust: let key = key.to_owned();
    // rust: self.panel_event(&owner, BrowserEvent::Key { key, stack });
}
}
}

// A mod's item as a stack: an item the game has, its components read as
// `/give` reads them (ones it can't read are left out).
    // rust: pub(super) fn browser_stack(
    // rust: items: &horizon_client::items::Items,
    // rust: s: &BrowserStack,
    // rust: ) -> Option<ItemStack> {
    // rust: items.get(&s.item)?;
    // rust: let (damage, extra) = if s.components.is_empty() {
    // rust: (0, None)
    // rust: } else {
    // rust: horizon_client::item_data::command_components(&s.components).map_or((0, None), |tag| {
    // rust: horizon_client::item_data::decode_components(Some(&tag))
    // rust: })
}
    // rust: Some(ItemStack {
    // rust: item: s.item.as_str().into(),
    // rust: count: s.count.clamp(1, 99),
    // rust: damage,
    // rust: extra,
    // rust: })
}

    // rust: mod tests {
//     use super::{BrowserStack, Owner, Panel, RecipePage};
//     use crate::game::native_hooks::{NativeRecipeLayout, NativeRecipeView};

stack :: proc(item: string) -> B {
    // Ported from Horizon
    return {}
}
    // rust: BrowserStack {
    // rust: item: item.into(),
    // rust: count: 1,
    // rust: components: String::new(),
}
}
view :: proc() -> N {
    // Ported from Horizon
    return {}
}
    // rust: NativeRecipeView {
    // rust: layout: NativeRecipeLayout::Grid,
    // rust: width: 5,
    // rust: height: 1,
    // rust: slots: vec![vec![stack("minecraft:oak_log")]; 12],
    // rust: results: vec![stack("minecraft:oak_planks")],
    // rust: note: String::new(),
    // rust: action: Some(true),
}
}

    // A native mod's items and recipe page are what the panel holds, and
    // its owner (who hears the panel's events) is that mod.
native_owner_holds_the_panel :: proc() {
}
    // rust: let mut panel = Panel::default();
    // rust: let items = vec![stack("minecraft:stone"), stack("minecraft:dirt")];
    // rust: panel.show_items("recipes", items.clone());
    // rust: let shown = panel.shown(|_| true).expect("a panel");
    // rust: assert_eq!(shown.owner, Owner::Native("recipes".into()));
    // rust: assert_eq!(shown.items, items);
    // rust: assert_eq!(shown.recipes, None);
    // rust: let first = shown.version;

    // rust: let tabs = vec![stack("minecraft:crafting_table")];
    // rust: let page = RecipePage::new("Oak Planks", tabs.clone(), 0, vec![view()]);
    // rust: panel.show_recipes("recipes", page);
    // rust: let shown = panel.shown(|_| true).expect("a panel");
    // rust: assert_ne!(shown.version, first, "the game converts each change");
    // rust: assert_eq!(shown.items, items);
    // rust: let page = shown.recipes.as_ref().expect("a recipe page");
    // rust: assert_eq!(
    // rust: (page.title.as_str(), &page.tabs, page.tab),
    // rust: ("Oak Planks", &tabs, 0)
    // rust: );
        // Cut as `set-recipes` cuts it: a 3 x 3 grid at most, 9 slots.
    // rust: let r = &page.recipes[0];
    // rust: assert_eq!((r.width, r.height, r.slots.len()), (3, 1, 9));
    // rust: assert_eq!(r.results, [stack("minecraft:oak_planks")]);

        // Another mod clearing its own (empty) panel leaves this one.
    // rust: panel.show_items("other", Vec::new());
    // rust: let owner = panel.shown(|_| true).map(|s| s.owner.clone());
    // rust: assert_eq!(owner, Some(Owner::Native("recipes".into())));
        // A mod the player turned off shows nothing.
    // rust: assert!(panel.shown(|id| id != "recipes").is_none());

        // No recipes: the items again; then no items: no panel.
    // rust: panel.show_recipes("recipes", RecipePage::new("", Vec::new(), 0, Vec::new()));
    // rust: let shown = panel.shown(|_| true).expect("a panel");
    // rust: assert_eq!((shown.items.len(), shown.recipes.is_none()), (2, true));
    // rust: panel.show_items("recipes", Vec::new());
    // rust: assert!(panel.shown(|_| true).is_none());
}
}
