//! Transpiled from Horizon Rust crate
package horizon_client_native_panel_recipes

import "core:fmt"
import "core:mem"
import "core:math"

// A mod's recipes shown in its item panel's place (`native_panel_recipes`,
// or `browser.set-recipes` of a WebAssembly mod, docs/mods.md), laid out by the game with its own slots, arrows and
// buttons, paged to the panel's height, under a title and a back button.
// The mod hears clicks on their slots, their action buttons, the back
// button and page turns.
// use super::{
    // rust: Game,
    // rust: native_hooks::{
    // rust: NativePanelEvent as BrowserEvent, NativeRecipeLayout as BrowserLayout,
    // rust: NativeRecipeView as BrowserRecipe, NativeStack as BrowserStack,
    // rust: },
    // rust: native_panel::{Layout, Owner, browser_stack, inside},
}
// use horizon_client::{
    // rust: hud::{HudBatch, rgba},
    // rust: items::ItemStack,
}
// use std::time::Instant;

SLOT :: 18.0
// The title row's height, and the gap under each recipe.
TITLE :: 18.0
// A tab's step: an 18 px slot and a gap.
TAB :: 20.0
GAP :: 6.0

// Recipes a page may show, slots in one, stacks a slot cycles, and tabs.
RECIPES :: 256
RECIPE_SLOTS :: 9
SLOT_STACKS :: 64
TABS :: 16

// What the panel shows instead of its items: a title, tabs (`tab` the
// selected one) and the recipes.
    // rust: pub(super) struct RecipePage {
    // rust: pub(super) title: String,
    // rust: pub(super) tabs: Vec<BrowserStack>,
    // rust: pub(super) tab: u32,
    // rust: pub(super) recipes: Vec<BrowserRecipe>,
}
    // rust: impl RecipePage {
    // `native_panel_recipes`' page, cut as `set-recipes` cuts one; none
    // without recipes (the items again).
    // rust: pub(super) fn new(
    // rust: title: &str,
    // rust: tabs: Vec<BrowserStack>,
    // rust: tab: u32,
    // rust: recipes: Vec<BrowserRecipe>,
    // rust: ) -> Option<Self> {
    // rust: let cycle = |mut list: Vec<BrowserStack>| {
    // rust: list.truncate(SLOT_STACKS);
    // rust: list
}
    // rust: let recipes: Vec<BrowserRecipe> = recipes
    // rust: .into_iter()
    // rust: .take(RECIPES)
    // rust: .map(|r| BrowserRecipe {
    // rust: width: r.width.clamp(1, 3),
    // rust: height: r.height.clamp(1, 3),
    // rust: slots: r.slots.into_iter().take(RECIPE_SLOTS).map(cycle).collect(),
    // rust: results: cycle(r.results),
    // rust: ..r
    // rust: })
    // rust: .collect();
    // rust: (!recipes.is_empty()).then(|| Self {
    // rust: title: title.to_owned(),
    // rust: tabs: tabs.into_iter().take(TABS).collect(),
    // rust: tab,
    // rust: recipes,
    // rust: })
}
}

// One recipe as the game draws it.
    // rust: pub(super) struct Shown {
    // rust: layout: BrowserLayout,
    // rust: width: usize,
    // rust: height: usize,
    // Each slot's stacks (the result last), as the mod sent them and as
    // stacks; a stack the game doesn't have is left out of the cycle.
    // rust: slots: Vec<Vec<(BrowserStack, ItemStack)>>,
    // rust: note: String,
    // rust: action: Option<bool>,
}

// The recipes a panel shows, and its page.
    // rust: pub(super) struct Pages {
    // rust: title: String,
    // The tabs' icons and the selected one.
    // rust: tabs: Vec<(BrowserStack, Option<ItemStack>)>,
    // rust: tab: usize,
    // rust: recipes: Vec<Shown>,
    // rust: page: usize,
    // rust: since: Instant,
}

    // rust: impl Pages {
    // rust: pub(super) fn new(
    // rust: items: &horizon_client::items::Items,
    // rust: shown: &RecipePage,
    // rust: old: Option<Pages>,
    // rust: ) -> Self {
    // rust: let (title, list, tab) = (&shown.title, &shown.recipes, shown.tab as usize);
    // rust: let kept = old.filter(|o| o.title == *title && o.tab == tab);
    // rust: let cycle = |stacks: &[BrowserStack]| -> Vec<(BrowserStack, ItemStack)> {
    // rust: stacks
    // rust: .iter()
    // rust: .filter_map(|s| Some((s.clone(), browser_stack(items, s)?)))
    // rust: .collect()
}
    // rust: let recipes = list
    // rust: .iter()
    // rust: .map(|r| {
    // rust: let mut slots: Vec<_> = r.slots.iter().map(|s| cycle(s)).collect();
    // rust: slots.push(cycle(&r.results));
    // rust: Shown {
    // rust: layout: r.layout,
    // rust: width: r.width as usize,
    // rust: height: r.height as usize,
    // rust: slots,
    // rust: note: r.note.clone(),
    // rust: action: r.action,
}
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: title: title.clone(),
    // rust: tabs: shown
    // rust: .tabs
    // rust: .iter()
    // rust: .map(|t| (t.clone(), browser_stack(items, t)))
    // rust: .collect(),
    // rust: tab,
    // rust: recipes,
    // rust: page: kept.as_ref().map_or(0, |o| o.page),
    // rust: since: kept.map_or_else(Instant::now, |o| o.since),
}
}
}

    // rust: impl Shown {
    // The inputs' block: its size and each input slot's place in it.
inputs :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let row = |n: usize| (0..n).map(|i| (i as f32 * SLOT, 0.0)).collect();
    // rust: match self.layout {
    // rust: BrowserLayout::Grid => {
    // rust: let (w, h) = (self.width.max(1), self.height.max(1));
    // rust: let at = (0..w * h)
    // rust: .map(|i| ((i % w) as f32 * SLOT, (i / w) as f32 * SLOT))
    // rust: .collect();
    // rust: ((w as f32 * SLOT, h as f32 * SLOT), at)
}
            // The input over the flame.
    // rust: BrowserLayout::Cooking => ((SLOT, 2.0 * SLOT), vec![(0.0, 0.0)]),
    // rust: BrowserLayout::Single => ((SLOT, SLOT), row(1)),
    // rust: BrowserLayout::Smithing => ((3.0 * SLOT, SLOT), row(3)),
    // rust: BrowserLayout::Brewing => ((2.0 * SLOT, SLOT), row(2)),
}
}
    // The height of its slots, arrow and button, `room` wide.
block :: proc(self: ^Self, room: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let h = self.inputs().0.1;
    // rust: let (_, _, action) = self.places(room);
    // rust: match self.action {
    // rust: Some(_) => h.max(action.1 + 12.0),
    // rust: None => h,
}
}
height :: proc(self: ^Self, room: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let note = if self.note.is_empty() { 0.0 } else { 11.0 };
    // rust: self.block(room) + note + GAP
}
    // Every slot's place from the recipe's corner (the result last), the
    // arrow's and the action button's: beside the result, or under it
    // when the panel is `room` wide and that doesn't fit.
places :: proc(self: ^Self, room: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let ((w, h), mut at) = self.inputs();
        // The mod's slots beyond the layout's are not shown.
    // rust: at.truncate(self.slots.len() - 1);
    // rust: let arrow = (w + 4.0, ((h - 16.0) / 2.0).floor());
    // rust: let result = (w + 32.0, ((h - SLOT) / 2.0).floor());
    // rust: let action = if result.0 + SLOT + 16.0 <= room {
    // rust: (result.0 + SLOT + 4.0, ((h - 12.0) / 2.0).floor())
    // rust: } else {
    // rust: (result.0 + 3.0, result.1 + SLOT + 2.0)
}
    // rust: while at.len() < self.slots.len() - 1 {
    // rust: at.push((f32::NAN, f32::NAN));
}
    // rust: at.push(result);
    // rust: (at, arrow, action)
}
}

// The tabs' places, in rows under the title row.
tab_places :: proc(pages: ^Pages, layout: ^Layout) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let per_row = ((layout.width() / TAB).floor() as usize).max(1);
    // rust: (0..pages.tabs.len())
    // rust: .map(|i| {
    // rust: (
    // rust: layout.grid.0 + (i % per_row) as f32 * TAB,
    // rust: layout.grid.1 + TITLE + 3.0 + (i / per_row) as f32 * TAB,
    // rust: )
    // rust: })
    // rust: .collect()
}
// Where the recipes start: under the title row and the tabs.
recipes_top :: proc(pages: ^Pages, layout: ^Layout) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let tabs = tab_places(pages, layout);
    // rust: tabs.last()
    // rust: .map_or(layout.grid.1 + TITLE, |&(_, y)| y + TAB + 3.0)
}

    // rust: impl Game<'_> {
    // The first recipe of each page, filling the panel from the tabs to
    // the search box.
recipe_pages :: proc(pages: ^Pages, layout: ^Layout) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let room = layout.search[1] - 4.0 - recipes_top(pages, layout);
    // rust: let mut starts = vec![0];
    // rust: let mut used = 0.0;
    // rust: for (i, r) in pages.recipes.iter().enumerate() {
    // rust: let h = r.height(layout.width());
    // rust: if used > 0.0 && used + h > room {
    // rust: starts.push(i);
    // rust: used = 0.0;
}
    // rust: used += h;
}
    // rust: starts
}
    // The recipes on the open page, each with its corner.
recipes_shown :: proc(self: ^Self, layout: ^Layout) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(pages) = &self.panel.recipes else {
    // rust: return Vec::new();
}
    // rust: let starts = Self::recipe_pages(pages, layout);
    // rust: let page = pages.page.min(starts.len() - 1);
    // rust: let end = starts.get(page + 1).copied().unwrap_or(pages.recipes.len());
    // rust: let mut y = recipes_top(pages, layout);
    // rust: (starts[page]..end)
    // rust: .map(|i| {
    // rust: let at = (layout.grid.0, y);
    // rust: y += pages.recipes[i].height(layout.width());
    // rust: (i, at)
    // rust: })
    // rust: .collect()
}
back_button :: proc(self: ^Self, layout: ^Layout) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let label = self.translate("gui.back", "Back");
    // rust: let w = HudBatch::text_width(&self.gui.atlas, &label) + 8.0;
    // rust: ([layout.grid.0, layout.grid.1, w, 14.0], label)
}
    // What a slot of a shown recipe holds now: its stacks cycle once a second.
recipe_slot_now :: proc(self: ^Self, recipe: uint, slot: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let pages = self.panel.recipes.as_ref()?;
    // rust: let stacks = pages.recipes.get(recipe)?.slots.get(slot)?;
    // rust: let n = pages.since.elapsed().as_secs() as usize;
    // rust: stacks.get(n % stacks.len().max(1))
}
    // The tab under the pointer: its index and icon.
    // rust: pub(super) fn recipe_tab_hovered(
    // rust: &self,
    // rust: layout: &Layout,
    // rust: ) -> Option<(usize, BrowserStack, ItemStack)> {
    // rust: let pages = self.panel.recipes.as_ref()?;
    // rust: let places = tab_places(pages, layout);
    // rust: places.iter().enumerate().find_map(|(i, &(x, y))| {
    // rust: if !inside(self.cursor, [x, y, SLOT, SLOT]) {
    // rust: return None;
}
    // rust: let (sent, stack) = pages.tabs.get(i)?;
    // rust: Some((i, sent.clone(), stack.clone()?))
    // rust: })
}
    // The recipe slot under the pointer: recipe, slot, and its stack now.
    // rust: pub(super) fn recipe_slot_hovered(
    // rust: &self,
    // rust: layout: &Layout,
    // rust: ) -> Option<(usize, usize, BrowserStack, ItemStack)> {
    // rust: let pages = self.panel.recipes.as_ref()?;
    // rust: self.recipes_shown(layout)
    // rust: .into_iter()
    // rust: .find_map(|(i, (x, y))| {
    // rust: let (at, _, _) = pages.recipes[i].places(layout.width());
    // rust: at.iter().enumerate().find_map(|(k, &(sx, sy))| {
    // rust: if !inside(self.cursor, [x + sx, y + sy, SLOT, SLOT]) {
    // rust: return None;
}
    // rust: let (mod_stack, stack) = self.recipe_slot_now(i, k)?.clone();
    // rust: Some((i, k, mod_stack, stack))
    // rust: })
    // rust: })
}

    // Draws the title row, the page's recipes and the page arrows.
    // rust: pub(super) fn draw_browser_recipes(&mut self, batch: &mut HudBatch, layout: &Layout) {
    // rust: let Some(pages) = &self.panel.recipes else {
    // rust: return;
}
    // rust: let cursor = self.cursor;
    // rust: let starts = Self::recipe_pages(pages, layout);
    // rust: let page = pages.page.min(starts.len() - 1);
    // rust: let (title, pages_n) = (pages.title.clone(), starts.len());
    // rust: let (back, label) = self.back_button(layout);
    // rust: let atlas = &self.gui.atlas;
    // rust: let hover = inside(cursor, back);
    // rust: horizon_client::widgets::declare_action(horizon_client::widgets::Action::Back, back, true);
    // rust: let sprite = if hover {
    // rust: "gui/sprites/widget/button_highlighted"
    // rust: } else {
    // rust: "gui/sprites/widget/button"
}
    // rust: horizon_client::ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: sprite,
    // rust: back[0],
    // rust: back[1],
    // rust: back[2],
    // rust: back[3],
    // rust: u32::MAX,
    // rust: );
    // rust: batch.text(atlas, &label, back[0] + 4.0, back[1] + 3.0, u32::MAX, true);
    // rust: horizon_client::widgets::record(&label, back, true);
    // rust: let room = layout.width() - back[2] - 4.0;
        // Cut to the panel with vanilla's ellipsis (CommonComponents.ELLIPSIS).
    // rust: let shown = if atlas.font.fit(&title, room) >= title.chars().count() {
    // rust: title
    // rust: } else {
    // rust: let fit = atlas.font.fit(&title, room - atlas.font.width("..."));
    // rust: let kept: String = title.chars().take(fit).collect();
    // rust: format!("{}...", kept.trim_end())
}
    // rust: batch.text(
    // rust: atlas,
    // rust: &shown,
    // rust: back[0] + back[2] + 4.0,
    // rust: back[1] + 3.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: self.draw_recipe_tabs(batch, layout);
    // rust: if pages_n > 1 {
    // rust: let labels = [
    // rust: self.translate("gui.recipebook.previous_page", "Previous Page"),
    // rust: self.translate("gui.recipebook.next_page", "Next Page"),
    // rust: ];
    // rust: let visible = [page > 0, page + 1 < pages_n];
    // rust: let atlas = &self.gui.atlas;
    // rust: for (((x, y), name), (label, visible)) in layout
    // rust: .arrows()
    // rust: .into_iter()
    // rust: .zip(["page_backward", "page_forward"])
    // rust: .zip(labels.iter().zip(visible))
    // rust: {
    // rust: if !visible {
    // rust: continue;
}
    // rust: let suffix = if inside(cursor, [x, y, 12.0, 17.0]) {
    // rust: "_highlighted"
    // rust: } else {
    // rust: ""
}
    // rust: batch.sprite(
    // rust: atlas,
    // rust: &format!("gui/sprites/recipe_book/{name}{suffix}"),
    // rust: x,
    // rust: y,
    // rust: );
    // rust: horizon_client::widgets::record(label, [x, y, 12.0, 17.0], true);
}
    // rust: let text = format!("{}/{pages_n}", page + 1);
    // rust: let w = HudBatch::text_width(atlas, &text);
    // rust: let x = (layout.grid.0 + (layout.width() - w) / 2.0).floor();
    // rust: batch.text(atlas, &text, x, layout.arrows_y + 5.0, u32::MAX, true);
}
    // rust: for (i, (x, y)) in self.recipes_shown(layout) {
    // rust: let Some(r) = self.panel.recipes.as_ref().map(|p| &p.recipes[i]) else {
    // rust: break;
}
    // rust: let (at, arrow, action) = r.places(layout.width());
    // rust: let h = r.block(layout.width());
    // rust: let (cooking, note, button) =
    // rust: (r.layout == BrowserLayout::Cooking, r.note.clone(), r.action);
    // rust: let atlas = &self.gui.atlas;
    // rust: for &(sx, sy) in at.iter().filter(|p| p.0.is_finite()) {
    // rust: batch.sprite(atlas, "gui/sprites/container/slot", x + sx, y + sy);
}
    // rust: if cooking {
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/furnace/lit_progress",
    // rust: x + 2.0,
    // rust: y + SLOT + 2.0,
    // rust: );
}
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/furnace/burn_progress",
    // rust: x + arrow.0,
    // rust: y + arrow.1,
    // rust: );
    // rust: if let Some(enabled) = button {
    // rust: let rect = [x + action.0, y + action.1, 12.0, 12.0];
    // rust: let sprite = match (enabled, inside(cursor, rect)) {
    // rust: (false, _) => "gui/sprites/widget/button_disabled",
    // rust: (true, true) => "gui/sprites/widget/button_highlighted",
    // rust: (true, false) => "gui/sprites/widget/button",
}
    // rust: horizon_client::ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: sprite,
    // rust: rect[0],
    // rust: rect[1],
    // rust: 12.0,
    // rust: 12.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let color = if enabled {
    // rust: u32::MAX
    // rust: } else {
    // rust: rgba(160, 160, 160, 255)
}
    // rust: batch.text(atlas, "+", rect[0] + 3.0, rect[1] + 2.0, color, true);
    // rust: horizon_client::widgets::record(&format!("+ {i}"), rect, enabled);
}
    // rust: if !note.is_empty() {
    // rust: batch.text(atlas, &note, x, y + h + 2.0, rgba(224, 224, 224, 255), true);
}
    // rust: for (k, &(sx, sy)) in at.iter().enumerate().filter(|(_, p)| p.0.is_finite()) {
    // rust: let Some((_, stack)) = self.recipe_slot_now(i, k).cloned() else {
    // rust: continue;
}
    // rust: self.draw_item(batch, &stack, x + sx + 1.0, y + sy + 1.0);
    // rust: if inside(cursor, [x + sx, y + sy, SLOT, SLOT]) {
    // rust: batch.fill(
    // rust: &self.gui.atlas,
    // rust: x + sx + 1.0,
    // rust: y + sy + 1.0,
    // rust: 16.0,
    // rust: 16.0,
    // rust: rgba(255, 255, 255, 128),
    // rust: );
}
    // rust: let name = self.pack.names.display_item(&stack.item);
    // rust: horizon_client::widgets::record_as(
    // rust: &format!("{name} {i}:{k}"),
    // rust: [x + sx + 1.0, y + sy + 1.0, 16.0, 16.0],
    // rust: true,
    // rust: horizon_client::widgets::Kind::Button,
    // rust: );
}
}
}

    // The tabs, on slots; the selected one framed.
draw_recipe_tabs :: proc(self: ^Self, batch: ^HudBatch, layout: ^Layout) {
}
    // rust: let Some(pages) = &self.panel.recipes else {
    // rust: return;
}
    // rust: let places = tab_places(pages, layout);
    // rust: let tabs: Vec<Option<ItemStack>> = pages.tabs.iter().map(|t| t.1.clone()).collect();
    // rust: let selected = pages.tab;
    // rust: for (i, (&(x, y), stack)) in places.iter().zip(tabs).enumerate() {
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.sprite(atlas, "gui/sprites/container/slot", x, y);
    // rust: let Some(stack) = stack else {
    // rust: continue;
}
    // rust: self.draw_item(batch, &stack, x + 1.0, y + 1.0);
            // The selected tab: a white frame around its slot.
    // rust: if i == selected {
    // rust: let white = rgba(255, 255, 255, 255);
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.fill(atlas, x - 1.0, y - 1.0, SLOT + 2.0, 1.0, white);
    // rust: batch.fill(atlas, x - 1.0, y + SLOT, SLOT + 2.0, 1.0, white);
    // rust: batch.fill(atlas, x - 1.0, y, 1.0, SLOT, white);
    // rust: batch.fill(atlas, x + SLOT, y, 1.0, SLOT, white);
}
    // rust: if inside(self.cursor, [x, y, SLOT, SLOT]) {
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
    // rust: let rect = [x + 1.0, y + 1.0, 16.0, 16.0];
    // rust: let kind = horizon_client::widgets::Kind::Tab(i == selected);
    // rust: horizon_client::widgets::record_as(&format!("{name} tab"), rect, true, kind);
            // The kind reaches the bumpers only as a target (`key_focus::drawn_targets`).
    // rust: horizon_client::widgets::target_as(rect, kind);
}
}

    // A press on the recipes: true when it hit one of their parts.
    // rust: pub(super) fn browser_recipes_press(
    // rust: &mut self,
    // rust: layout: &Layout,
    // rust: owner: &Owner,
    // rust: right: bool,
    // rust: ) -> bool {
    // rust: let Some(pages) = &self.panel.recipes else {
    // rust: return false;
}
    // rust: let cursor = self.cursor;
    // rust: let starts = Self::recipe_pages(pages, layout);
    // rust: let page = pages.page.min(starts.len() - 1);
    // rust: let [back_arrow, forward] = layout.arrows();
    // rust: let turn = if page > 0 && inside(cursor, [back_arrow.0, back_arrow.1, 12.0, 17.0]) {
    // rust: Some(page - 1)
    // rust: } else if page + 1 < starts.len() && inside(cursor, [forward.0, forward.1, 12.0, 17.0]) {
    // rust: Some(page + 1)
    // rust: } else {
    // rust: None
}
    // rust: if let Some(to) = turn {
    // rust: if let Some(p) = self.panel.recipes.as_mut() {
    // rust: p.page = to;
}
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: self.panel_event(owner, BrowserEvent::Page(starts[to] as u32));
    // rust: return true;
}
    // rust: if let Some((tab, _, _)) = self.recipe_tab_hovered(layout) {
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: self.panel_event(owner, BrowserEvent::Tab(tab as u32));
    // rust: return true;
}
    // rust: if inside(cursor, self.back_button(layout).0) {
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: self.panel_event(owner, BrowserEvent::Back);
    // rust: return true;
}
    // rust: if let Some((recipe, slot, stack, _)) = self.recipe_slot_hovered(layout) {
    // rust: let event = BrowserEvent::SlotClicked {
    // rust: recipe: recipe as u32,
    // rust: slot: slot as u32,
    // rust: stack,
    // rust: right,
}
    // rust: self.panel_event(owner, event);
    // rust: return true;
}
    // rust: let action = self.recipes_shown(layout).into_iter().find(|&(i, (x, y))| {
    // rust: let r = &pages.recipes[i];
    // rust: let (_, _, (ax, ay)) = r.places(layout.width());
    // rust: r.action.is_some() && inside(cursor, [x + ax, y + ay, 12.0, 12.0])
    // rust: });
    // rust: if let Some((i, _)) = action {
    // rust: if pages.recipes[i].action == Some(true) {
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: self.panel_event(owner, BrowserEvent::Action(i as u32));
}
    // rust: return true;
}
    // rust: false
}
}
