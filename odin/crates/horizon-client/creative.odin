//! Transpiled from Horizon Rust crate
package horizon_client_creative

import "core:fmt"
import "core:mem"
import "core:math"

// Creative inventory (CreativeModeInventoryScreen): vanilla's tabs and their
// contents as built by the game's own display generators
// (`creative-inventory.json`), a 9x5 scrolling grid and the search tab.
// use crate::{Result, items::ItemStack, ui::EditBox};
// use serde_json::Value;
// use std::{
    // rust: collections::HashMap,
    // rust: fs,
    // rust: path::Path,
    // rust: sync::{Arc, Mutex},
}

Tab :: struct {
    id: string,
    title: string,
    icon: string,
    items: [dynamic]ItemStack,
    top: bool,
    column: u32,
    search: bool,
    inventory: bool,
    // `CreativeModeTab.Type.HOTBAR`: the saved toolbars, filled when the
    // tab is selected (`set_saved_hotbars`).
    hotbar: bool,
    // The page of tabs it is on: vanilla's are 0, mods' after, as NeoForge
    // pages them.
    page: u32,
}
    // rust: impl Tab {
    // The tab without its stacks.
header :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: id: self.id.clone(),
    // rust: title: self.title.clone(),
    // rust: icon: self.icon.clone(),
    // rust: items: Vec::new(),
    // rust: top: self.top,
    // rust: column: self.column,
    // rust: search: self.search,
    // rust: inventory: self.inventory,
    // rust: hotbar: self.hotbar,
    // rust: page: self.page,
}
}
}
// A tab as exported, built with permissions: `operator` marks the stacks a
// build without them leaves out (the export's `permissions_only`).
Exported :: struct {
    tab: Tab,
    // `CreativeModeTab.Type.CATEGORY`: shown only with a stack (`shouldDisplay`).
    category: bool,
    operator: [dynamic]bool,
}
// What the client's creative search trees (SessionSearchTrees) index for one
// stack of the search tab: its creative tooltip lines and its item tags.
SearchEntry :: struct {
    // The item id's namespace and path, lower-cased.
    namespace: string,
    path: string,
    // Tooltip lines, lower-cased; empty when the resources predate them.
    lines: [dynamic]string,
    // Item tags as (namespace, path), lower-cased.
    tags: Vec<(string,
}
Creative :: struct {
    // The tabs shown (`CreativeModeTabs.tabs()`), with the stacks the current
    // permissions put in them.
    tabs: [dynamic]Tab,
    selected: uint,
    // The page of tabs shown.
    page: u32,
    // Scroll position 0..1 (scrollOffs).
    scroll: f32,
    // The scrollbar is held (scrolling): dragging moves it.
    scrolling: bool,
    // CreativeModeInventoryScreen's search box: an unbordered `EditBox` of 50.
    search: EditBox,
    // The search tab's stacks, in its display order.
    search_items: [dynamic]ItemStack,
    search_index: [dynamic]SearchEntry,
    // Every exported tab, and the search tab's stacks with their entries and
    // whether only permissions list them: `rebuild` keeps what is shown.
    exported: [dynamic]Exported,
    exported_search: Vec<(ItemStack,
    // The `hasPermissions` the tabs were last built with
    // (`CreativeModeTabs.tryRebuildTabContents`).
    permissions: bool,
    // ItemPickerMenu.items: what the grid shows, filled when the tab or the
    // search changes (selectTab, refreshSearchResults), not on every frame.
    shown: Mutex<Maybe(Shown)>,
    // SessionSearchTrees.creativeByNameSearch: the lower-cased tooltip lines
    // of every search item in one language (keyed by the `itemGroup.search`
    // string), built on the first search and kept until the language or the
    // item list changes.
    lines_cache: Mutex<Option<(string,
}
// The grid's stacks for one tab, search text and language.
Shown :: struct {
    tab: uint,
    search: string,
    // A display name, so a language change refills the search results.
    language: string,
    items: ^[ItemStack],
}
// Display names from the pinned en_us language file.
Names :: struct {
    map: HashMap<string,
}
    // rust: impl Names {
load :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let read = |namespace: &str| {
    // rust: fs::read(root.join(format!("assets/{namespace}/lang/en_us.json")))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<HashMap<String, String>>(&b).ok())
    // rust: .unwrap_or_default()
}
    // rust: let mut map = read("minecraft");
        // Content mods' names (docs/modpacks.md); none in a vanilla root.
    // rust: for namespace in crate::mod_content::namespaces(root) {
    // rust: map.extend(read(&namespace));
}
    // rust: Self { map }
}
item :: proc(self: ^Self, id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (namespace, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: self.map
    // rust: .get(&format!("item.{namespace}.{path}"))
    // rust: .or_else(|| self.map.get(&format!("block.{namespace}.{path}")))
    // rust: .cloned()
    // rust: .unwrap_or_else(|| path.replace('_', " "))
}
    // An item's display name in the selected language: `item.*` then
    // `block.*`, then the pinned English map (`Names::item`).
display_item :: proc(self: ^Self, id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (namespace, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: if let Some(lang) = crate::lang::current() {
    // rust: for prefix in ["item", "block"] {
    // rust: if let Some(name) = lang.get(&format!("{prefix}.{namespace}.{path}")) {
    // rust: return name.to_owned();
}
}
}
    // rust: self.item(id)
}
    // A translation key's text in the selected language, else the pinned
    // English map (`HoverName` and tooltip keys such as potion names).
display_get :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: crate::lang::current()
    // rust: .and_then(|lang| lang.get(key).map(str::to_owned))
    // rust: .or_else(|| self.get(key).map(str::to_owned))
}
get :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.map.get(key).map(String::as_str)
}
}

// `CreativeModeTabs`' key for an exported tab id (`itemGroup.*`); the
// export's `title` is the English fallback.
item_group_key :: proc(id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match id.trim_start_matches("minecraft:") {
    // rust: "building_blocks" => "itemGroup.buildingBlocks",
    // rust: "colored_blocks" => "itemGroup.coloredBlocks",
    // rust: "natural_blocks" => "itemGroup.natural",
    // rust: "functional_blocks" => "itemGroup.functional",
    // rust: "redstone_blocks" => "itemGroup.redstone",
    // rust: "hotbar" => "itemGroup.hotbar",
    // rust: "search" => "itemGroup.search",
    // rust: "tools_and_utilities" => "itemGroup.tools",
    // rust: "combat" => "itemGroup.combat",
    // rust: "food_and_drinks" => "itemGroup.foodAndDrink",
    // rust: "ingredients" => "itemGroup.ingredients",
    // rust: "spawn_eggs" => "itemGroup.spawnEggs",
    // rust: "op_blocks" => "itemGroup.op",
    // rust: "inventory" => "itemGroup.inventory",
    // rust: _ => return None,
    // rust: })
}
    // rust: impl Creative {
WIDTH :: 195.0
HEIGHT :: 136.0
TRASH_POSITION :: (173.0, 112.0)

    // Visible player slots in the creative inventory tab (game slot ids).
inventory_slots :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: (0..36).chain(500..505)
}

    // CreativeModeInventoryScreen.selectTab positions its InventoryMenu wrappers.
inventory_slot_position :: proc(slot: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match slot {
    // rust: 0..9 => Some((9.0 + slot as f32 * 18.0, 112.0)),
    // rust: 9..36 => Some((
    // rust: 9.0 + ((slot - 9) % 9) as f32 * 18.0,
    // rust: 54.0 + ((slot - 9) / 9) as f32 * 18.0,
    // rust: )),
    // rust: 500..504 => {
    // rust: let position = slot - 500;
    // rust: Some((
    // rust: 54.0 + (position / 2) as f32 * 54.0,
    // rust: 6.0 + (position % 2) as f32 * 27.0,
    // rust: ))
}
    // rust: 504 => Some((35.0, 20.0)),
    // rust: _ => None,
}
}
    // Game slot id of an item tab's first display slot (ItemPickerMenu's
    // `CustomCreativeSlot`s, 9 by 5); its hotbar row keeps ids 0..9.
DISPLAY :: 900

    // Visible slots of an item tab (game slot ids).
tab_slots :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: (Self::DISPLAY..Self::DISPLAY + 45).chain(0..9)
}

    // ItemPickerMenu's slot positions.
tab_slot_position :: proc(slot: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match slot {
    // rust: 0..9 => Some((9.0 + slot as f32 * 18.0, 112.0)),
    // rust: _ if (Self::DISPLAY..Self::DISPLAY + 45).contains(&slot) => {
    // rust: let i = slot - Self::DISPLAY;
    // rust: Some((9.0 + (i % 9) as f32 * 18.0, 18.0 + (i / 9) as f32 * 18.0))
}
    // rust: _ => None,
}
}
    // The scrollbar track (insideScrollbar), relative to the screen origin.
SCROLL_X :: 175.0
SCROLL_Y :: 18.0
SCROLL_WIDTH :: 14.0
SCROLL_HEIGHT :: 112.0
    // `creative-inventory.json` (VanillaCreativeTabsExporter); resources
    // prepared before it fall back to `creative-tabs.json`'s item ids.
load :: proc(root: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let path = root.join("creative-inventory.json");
    // rust: if path.exists() {
    // rust: Self::from_json(&serde_json::from_slice(&fs::read(path)?)?)
    // rust: } else {
    // rust: Self::from_legacy(&serde_json::from_slice(&fs::read(
    // rust: root.join("creative-tabs.json"),
    // rust: )?)?)
}
}
from_json :: proc(raw: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut tabs = Vec::new();
    // rust: let mut search = Vec::new();
    // rust: for t in raw["tabs"].as_array().into_iter().flatten() {
            // The stacks only a build with permissions lists, by index.
    // rust: let only: Vec<u64> = t["permissions_only"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(Value::as_u64)
    // rust: .collect();
    // rust: let mut items = Vec::new();
    // rust: let mut operator = Vec::new();
    // rust: for (i, v) in t["items"].as_array().into_iter().flatten().enumerate() {
    // rust: let snbt = v.as_str().unwrap_or("-");
    // rust: if let Some(stack) = crate::item_data::parse_stack(snbt)? {
    // rust: items.push(stack);
    // rust: operator.push(only.contains(&(i as u64)));
}
}
    // rust: let kind = t["type"].as_str().unwrap_or("");
    // rust: if kind == "SEARCH" {
    // rust: let strings = |v: &Value| -> Vec<String> {
    // rust: v.as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|s| s.as_str().map(java_lower))
    // rust: .collect()
}
    // rust: for (i, stack) in items.iter().enumerate() {
    // rust: let (namespace, path) = split_id(&java_lower(&stack.item));
    // rust: let entry = SearchEntry {
    // rust: namespace,
    // rust: path,
    // rust: lines: strings(&t["lines"][i]),
    // rust: tags: strings(&t["tags"][i]).iter().map(|t| split_id(t)).collect(),
}
    // rust: search.push((stack.clone(), entry, operator[i]));
}
}
    // rust: let icon = t["icon"]
    // rust: .as_str()
    // rust: .and_then(|s| crate::item_data::parse_stack(s).ok().flatten());
    // rust: tabs.push(Exported {
    // rust: tab: Tab {
    // rust: id: t["id"].as_str().unwrap_or("").to_owned(),
    // rust: title: t["title"].as_str().unwrap_or("").to_owned(),
    // rust: icon: icon.map_or_else(|| "minecraft:stone".to_owned(), |s| s.item.to_string()),
    // rust: items,
    // rust: top: t["row"] == "TOP",
    // rust: column: t["column"].as_u64().unwrap_or(0) as u32,
    // rust: search: kind == "SEARCH",
    // rust: inventory: kind == "INVENTORY",
    // rust: hotbar: kind == "HOTBAR",
    // rust: page: t["page"].as_u64().unwrap_or(0) as u32,
    // rust: },
    // rust: category: kind == "CATEGORY",
    // rust: operator,
    // rust: });
}
    // rust: Ok(Self::new(tabs, search))
}
    // The old export: item ids per tab, no components, tooltips or tags.
from_legacy :: proc(raw: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut tabs = Vec::new();
    // rust: let mut search_items: Vec<ItemStack> = Vec::new();
    // rust: for t in raw.as_array().into_iter().flatten() {
    // rust: let items: Vec<ItemStack> = t["items"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|v| v.as_str().map(|id| ItemStack::new(id, 1)))
    // rust: .collect();
    // rust: if t["id"] == "minecraft:hotbar" || t["id"] == "minecraft:op_blocks" {
    // rust: continue;
}
    // rust: for i in &items {
    // rust: if !search_items.iter().any(|s| s.item == i.item) {
    // rust: search_items.push(i.clone());
}
}
    // rust: let kind = t["type"].as_str().unwrap_or("");
    // rust: tabs.push(Exported {
    // rust: operator: vec![false; items.len()],
    // rust: tab: Tab {
    // rust: id: t["id"].as_str().unwrap_or("").to_owned(),
    // rust: title: t["title"].as_str().unwrap_or("").to_owned(),
    // rust: icon: t["icon"].as_str().unwrap_or("minecraft:stone").to_owned(),
    // rust: items,
    // rust: top: t["row"] == "TOP",
    // rust: column: t["column"].as_u64().unwrap_or(0) as u32,
    // rust: search: kind == "SEARCH",
    // rust: inventory: kind == "INVENTORY",
    // rust: hotbar: false,
    // rust: page: 0,
    // rust: },
    // rust: category: false,
    // rust: });
}
    // rust: let search = search_items
    // rust: .into_iter()
    // rust: .map(|s| {
    // rust: let (namespace, path) = split_id(&java_lower(&s.item));
    // rust: let entry = SearchEntry {
    // rust: namespace,
    // rust: path,
    // rust: ..Default::default()
}
    // rust: (s, entry, false)
    // rust: })
    // rust: .collect();
    // rust: Ok(Self::new(tabs, search))
}
new :: proc(exported: [dynamic]Exported, exported_search: Vec<(ItemStack) {
}
    // rust: let mut creative = Self {
    // rust: tabs: Vec::new(),
    // rust: selected: 0,
    // rust: page: 0,
    // rust: scroll: 0.0,
    // rust: scrolling: false,
    // rust: search: {
    // rust: let mut search = EditBox::new(0.0, 0.0, 80.0, 9.0);
    // rust: search.bordered = false;
    // rust: search.max_length = 50;
    // rust: search.text_color = u32::MAX;
    // rust: search
    // rust: },
    // rust: search_items: Vec::new(),
    // rust: search_index: Vec::new(),
    // rust: exported,
    // rust: exported_search,
    // rust: permissions: false,
    // rust: shown: Mutex::new(None),
    // rust: lines_cache: Mutex::new(None),
}
    // rust: creative.rebuild();
    // rust: creative
}
    // `CreativeModeTabs.buildAllTabContents` with `permissions`: the operator
    // tab's display items generator lists its stacks only with them
    // (`hasPermissions`), and the search tab with it; a category tab is
    // shown with a stack (`CreativeModeTab.shouldDisplay`).
rebuild :: proc(self: ^Self) {
}
    // rust: let permissions = self.permissions;
    // rust: let keep = |operator: bool| permissions || !operator;
    // rust: self.tabs = self
    // rust: .exported
    // rust: .iter()
    // rust: .filter_map(|e| {
    // rust: let items: Vec<ItemStack> = (e.tab.items.iter().zip(&e.operator))
    // rust: .filter(|(_, o)| keep(**o))
    // rust: .map(|(s, _)| s.clone())
    // rust: .collect();
    // rust: (!e.category || !items.is_empty()).then(|| Tab {
    // rust: items,
    // rust: ..e.tab.header()
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: *self.lines_cache.lock().unwrap_or_else(|e| e.into_inner()) = None;
    // rust: (self.search_items, self.search_index) = self
    // rust: .exported_search
    // rust: .iter()
    // rust: .filter(|(_, _, o)| keep(*o))
    // rust: .map(|(s, e, _)| (s.clone(), e.clone()))
    // rust: .unzip();
    // rust: self.forget_items();
}
    // `CreativeModeInventoryScreen.tryRefreshInvalidatedTabs`, which its
    // constructor and `containerTick` run with `hasPermissions`
    // (`Player.canUseGameMasterBlocks` and the Operator Items Tab option):
    // when that changed, the tabs are built again. A selected tab left
    // without stacks (the operator tab) gives way to the default tab; any
    // other keeps its first row (`refreshCurrentTabContents`). True when the
    // tabs were rebuilt.
set_permissions :: proc(self: ^Self, permissions: bool, names: ^Names) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if permissions == self.permissions {
    // rust: return false;
}
    // rust: let selected = self.tab().id.clone();
    // rust: let row = self.first_row(names);
    // rust: self.permissions = permissions;
    // rust: self.rebuild();
    // rust: match self.tabs.iter().position(|t| t.id == selected) {
    // rust: Some(tab) => {
    // rust: self.selected = tab;
                // ItemPickerMenu.getScrollForRowIndex.
    // rust: let hidden = self.hidden_rows(names);
    // rust: self.scroll = if hidden > 0 {
    // rust: (row as f32 / hidden as f32).clamp(0.0, 1.0)
    // rust: } else {
    // rust: 0.0
}
}
    // rust: None => {
                // CreativeModeTabs.getDefaultTab.
    // rust: let default = self
    // rust: .tabs
    // rust: .iter()
    // rust: .position(|t| t.id == "minecraft:building_blocks");
    // rust: self.select(default.unwrap_or(0));
}
}
    // rust: true
}
    // Where a stack comes in the creative tabs (the search tab lists them
    // all, in tab order): the same stack's place, else its item's first.
    // None for items the tabs don't show.
order_of :: proc(self: ^Self, stack: ^ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let items = &self.search_items;
    // rust: items
    // rust: .iter()
    // rust: .position(|s| s.same_item_same_components(stack))
    // rust: .or_else(|| items.iter().position(|s| s.item == stack.item))
}
    // The tabs without their stacks: what the screen draws of them each frame.
tab_headers :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.tabs.iter().map(Tab::header).collect()
}
tab :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.tabs[self.selected.min(self.tabs.len() - 1)]
}
    // selectTab: a different tab empties the search box; the scrollbar goes to the top.
    // A tab on another page shows that page.
select :: proc(self: ^Self, tab: uint) {
}
    // rust: if tab != self.selected {
    // rust: self.search.set_value("");
}
    // rust: self.selected = tab;
    // rust: if let Some(t) = self.tabs.get(tab)
    // rust: && !Self::on_every_page(t)
    // rust: {
    // rust: self.page = t.page;
}
    // rust: self.scroll = 0.0;
    // rust: if self.tab().search {
    // rust: self.search.focused = true;
    // rust: self.search.reset_blink();
}
}
    // How many pages of tabs there are (1 without mods' tabs).
pages :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.tabs.iter().map(|t| t.page + 1).max().unwrap_or(1)
}
    // The tabs every page shows (NeoForge's): the right-hand ones, saved
    // hotbars, search, operator blocks and the inventory.
on_every_page :: proc(t: ^Tab) -> b {
    // Ported from Horizon
    return {}
}
    // rust: t.column >= 5
}
    // Whether tab `t` shows on the page shown.
on_page :: proc(self: ^Self, t: ^Tab) -> b {
    // Ported from Horizon
    return {}
}
    // rust: t.page == self.page || Self::on_every_page(t)
}
    // Shows page `page` (NeoForge's page buttons) and selects its first tab,
    // unless the selected tab is one every page shows.
set_page :: proc(self: ^Self, page: u32) {
}
    // rust: let page = page.min(self.pages() - 1);
    // rust: let kept = self
    // rust: .tabs
    // rust: .get(self.selected)
    // rust: .is_some_and(Self::on_every_page);
    // rust: if !kept
    // rust: && let Some(first) = self
    // rust: .tabs
    // rust: .iter()
    // rust: .position(|t| t.page == page && !Self::on_every_page(t))
    // rust: {
    // rust: self.select(first);
}
    // rust: self.page = page;
}
    // The search tab's stacks.
search_items :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.search_items
}
    // Opening the screen: vanilla rebuilds CreativeModeInventoryScreen, whose
    // init() makes a fresh search box and a zeroed scrollbar; only the tab
    // persists (its static selectedTab). selectTab on the reopened screen
    // takes the oldTab != tab branch, so it empties and refocuses the box.
reopen :: proc(self: ^Self) {
}
    // rust: self.search.set_value("");
    // rust: self.release();
    // rust: self.scroll = 0.0;
    // rust: self.search.focused = self.tab().search;
    // rust: if self.search.focused {
    // rust: self.search.reset_blink();
}
}
    // Indices into `search_items` that CreativeModeInventoryScreen.refreshSearchResults
    // shows for `term`: the whole tab when empty, the tag tree after `#`, else
    // the name tree, both over vanilla's suffix arrays (substring matches,
    // results in the tab's order).
search_results :: proc(self: ^Self, term: string, names: ^Names) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let english =
    // rust: names.display_get("itemGroup.search").as_deref() == names.get("itemGroup.search");
    // rust: let local = if term.is_empty() || term.starts_with('#') {
    // rust: Arc::from([])
    // rust: } else if english && self.search_index.iter().all(|e| !e.lines.is_empty()) {
            // The exported English lines are the whole index.
    // rust: Arc::from([])
    // rust: } else {
    // rust: let language = names.display_get("itemGroup.search").unwrap_or_default();
    // rust: let mut cache = self.lines_cache.lock().unwrap_or_else(|e| e.into_inner());
    // rust: match cache.as_ref().filter(|(l, _)| *l == language) {
    // rust: Some((_, lines)) => lines.clone(),
    // rust: None => {
    // rust: let lines = self.localized_lines(&|k| names.display_get(k));
    // rust: *cache = Some((language, lines.clone()));
    // rust: lines
}
}
}
    // rust: self.search_results_in(term, names, &local, english)
}
    // Every search item's tooltip lines through `translate`, lower-cased.
localized_lines :: proc(self: ^Self, translate: ^dyn Fn(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.search_items
    // rust: .iter()
    // rust: .map(|s| {
    // rust: crate::item_tooltip::lines(s, None, translate)
    // rust: .iter()
    // rust: .map(|l| java_lower(l))
    // rust: .collect()
    // rust: })
    // rust: .collect()
}
    // rust: fn search_results_in(
    // rust: &self,
    // rust: term: &str,
    // rust: names: &Names,
    // rust: local: &[Vec<String>],
    // rust: english: bool,
    // rust: ) -> Vec<usize> {
    // rust: let all = 0..self.search_index.len();
    // rust: if term.is_empty() {
    // rust: return all.collect();
}
    // rust: if let Some(tag) = term.strip_prefix('#') {
            // IdSearchTree over the stacks' tags.
    // rust: let text = java_lower(tag);
    // rust: return all
    // rust: .filter(|&i| {
    // rust: let tags = &self.search_index[i].tags;
    // rust: match text.split_once(':') {
    // rust: None => any(tags.iter().map(|t| t.1.as_str()), &text),
    // rust: Some((ns, path)) => {
    // rust: let (ns, path) = (java_trim(ns), java_trim(path));
    // rust: any(tags.iter().map(|t| t.0.as_str()), ns)
    // rust: && any(tags.iter().map(|t| t.1.as_str()), path)
}
}
    // rust: })
    // rust: .collect();
}
        // FullTextSearchTree: the creative tooltip lines in the selected
        // language, and the item id after a colon. The export's lines are
        // English (they come from the vanilla jars), so they stand in only
        // while the language is English; otherwise every line (name, lore,
        // effects, ...) is rebuilt through the language, as vanilla's
        // getTooltipLines does.
    // rust: let text = java_lower(term);
    // rust: all.filter(|&i| {
    // rust: let e = &self.search_index[i];
    // rust: let fallback;
    // rust: let lines: &[String] = if e.lines.is_empty() {
    // rust: fallback = [java_lower(&names.item(&self.search_items[i].item))];
    // rust: &fallback
    // rust: } else {
    // rust: &e.lines
}
    // rust: let exported = english || e.lines.is_empty();
    // rust: let local = local.get(i).map_or(&[][..], Vec::as_slice);
    // rust: let hit = |t: &str| {
    // rust: (exported && any(lines.iter().map(String::as_str), t))
    // rust: || any(local.iter().map(String::as_str), t)
}
    // rust: match text.split_once(':') {
    // rust: None => hit(&text),
    // rust: Some((ns, path)) => {
    // rust: let (ns, path) = (java_trim(ns), java_trim(path));
    // rust: e.namespace.contains(ns) && (e.path.contains(path) || hit(path))
}
}
    // rust: })
    // rust: .collect()
}
    // Items shown by the selected tab (the search tab filters by `search`),
    // worked out again only when the tab, the search or the language changed.
items :: proc(self: ^Self, names: ^Names) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let tab = self.selected.min(self.tabs.len() - 1);
    // rust: let search = if self.tab().search {
    // rust: self.search.value.as_str()
    // rust: } else {
    // rust: ""
}
    // rust: let language = names.display_get("itemGroup.search").unwrap_or_default();
    // rust: let mut shown = self.shown.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some(s) = shown.as_ref()
    // rust: && s.tab == tab
    // rust: && s.search == search
    // rust: && s.language == language
    // rust: {
    // rust: return s.items.clone();
}
    // rust: let items: Arc<[ItemStack]> = if self.tab().search {
    // rust: self.search_results(search, names)
    // rust: .into_iter()
    // rust: .map(|i| self.search_items[i].clone())
    // rust: .collect()
    // rust: } else {
    // rust: self.tab().items.as_slice().into()
}
    // rust: *shown = Some(Shown {
    // rust: tab,
    // rust: search: search.to_owned(),
    // rust: language,
    // rust: items: items.clone(),
    // rust: });
    // rust: items
}
    // The stack in grid cell `index` (row-major from the tab's top), None
    // for an empty cell: a saved toolbar's empty slot, or past the end.
shown :: proc(self: ^Self, names: ^Names, index: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.items(names)
    // rust: .get(index)
    // rust: .filter(|s| s.count > 0)
    // rust: .cloned()
}
    // `CreativeModeInventoryScreen.selectTab` for the HOTBAR tab: the nine
    // saved rows of `HotbarManager` as the tab's items, an empty stack (count
    // 0) for an empty slot.
set_saved_hotbars :: proc(self: ^Self, items: [dynamic]ItemStack) {
}
    // rust: if let Some(tab) = self.tabs.iter_mut().find(|t| t.hotbar) {
    // rust: tab.items = items;
}
    // rust: self.forget_items();
}
    // Drop the shown items, so the next `items` works them out again: a
    // reload can rename items without changing the Search label.
forget_items :: proc(self: ^Self) {
}
    // rust: *self.shown.lock().unwrap_or_else(|e| e.into_inner()) = None;
}
rows :: proc(self: ^Self, names: ^Names) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.items(names).len().div_ceil(9)
}
    // ItemPickerMenu.calculateRowCount: rows beyond the five shown.
hidden_rows :: proc(self: ^Self, names: ^Names) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.rows(names) as i32 - 5
}
    // First visible grid row for the scroll position (getRowIndexForScroll).
first_row :: proc(self: ^Self, names: ^Names) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ((self.scroll * self.hidden_rows(names) as f32 + 0.5) as i32).max(0) as usize
}
    // CreativeModeInventoryScreen.canScroll: more than five rows, on a tab with a scrollbar.
can_scroll :: proc(self: ^Self, names: ^Names) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.tab().inventory && self.items(names).len() > 45
}
    // insideScrollbar, for a point relative to the screen origin.
inside_scrollbar :: proc(self: ^Self, x: f32, y: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: x >= Self::SCROLL_X
    // rust: && y >= Self::SCROLL_Y
    // rust: && x < Self::SCROLL_X + Self::SCROLL_WIDTH
    // rust: && y < Self::SCROLL_Y + Self::SCROLL_HEIGHT
    // rust: && !self.tab().inventory
}
    // mouseClicked on the scrollbar: it is held only if the tab can scroll
    // (the thumb doesn't move until the mouse does).
press_scrollbar :: proc(self: ^Self, x: f32, y: f32, names: ^Names) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !self.inside_scrollbar(x, y) {
    // rust: return false;
}
    // rust: self.scrolling = self.can_scroll(names);
    // rust: true
}
    // mouseDragged while the scrollbar is held, at a cursor height relative to
    // the screen origin, wherever the cursor is (even off the track or the window).
drag_scrollbar :: proc(self: ^Self, y: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !self.scrolling {
    // rust: return false;
}
    // rust: let (top, bottom) = (Self::SCROLL_Y, Self::SCROLL_Y + Self::SCROLL_HEIGHT);
    // rust: self.scroll = ((y - top - 7.5) / (bottom - top - 15.0)).clamp(0.0, 1.0);
    // rust: true
}
    // mouseReleased.
release :: proc(self: ^Self) {
}
    // rust: self.scrolling = false;
}
    // mouseScrolled: ItemPickerMenu.subtractInputFromScroll.
wheel :: proc(self: ^Self, amount: f64, names: ^Names) {
}
    // rust: if !self.can_scroll(names) {
    // rust: return;
}
    // rust: let rows = self.hidden_rows(names) as f64;
    // rust: self.scroll = (self.scroll - (amount / rows) as f32).clamp(0.0, 1.0);
}
    // The scroller sprite's offset from the top of the track.
scroller_offset :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((Self::SCROLL_HEIGHT - 17.0) * self.scroll) as i32 as f32
}
    // The tabs whose `CreativeModeTab.contains(stack)` holds, in
    // `CreativeModeTabs.tabs()` order, the search tab left out: the stack is
    // among the tab's search-tab items, by item and components. The export
    // lists each tab's own items; the search tab's stacks that no tab shows
    // (the enchanted books below their top level, `SEARCH_TAB_ONLY`) belong
    // to the tabs that show their item.
tabs_containing :: proc(self: ^Self, stack: ^ItemStack) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let category = |t: &Tab| !t.search && !t.inventory;
    // rust: let tabs_where = |shows: &dyn Fn(&ItemStack) -> bool| -> Vec<usize> {
    // rust: (0..self.tabs.len())
    // rust: .filter(|&i| category(&self.tabs[i]) && self.tabs[i].items.iter().any(shows))
    // rust: .collect()
}
    // rust: let found = tabs_where(&|s| same_components(s, stack));
    // rust: if found.is_empty() && self.search_items.iter().any(|s| same_components(s, stack)) {
    // rust: return tabs_where(&|s| s.item == stack.item);
}
    // rust: found
}
    // The `#namespace:path` lines `getTooltipFromContainerItem` adds for a
    // search tab stack while the search is a `#` query: the item tags
    // `updateVisibleTags` keeps for the text after `#` (the path contains it;
    // with a colon, the namespace and the path each contain their part) that
    // the stack has.
search_tag_lines :: proc(self: ^Self, stack: ^ItemStack) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(text) = self.search.value.strip_prefix('#') else {
    // rust: return Vec::new();
}
    // rust: let Some(entry) = self
    // rust: .search_items
    // rust: .iter()
    // rust: .position(|s| same_components(s, stack))
    // rust: .and_then(|i| self.search_index.get(i))
    // rust: else {
    // rust: return Vec::new();
}
    // rust: let visible = |(ns, path): &(String, String)| match text.split_once(':') {
    // rust: None => path.contains(text),
    // rust: Some((n, p)) => ns.contains(java_trim(n)) && path.contains(java_trim(p)),
}
    // rust: entry
    // rust: .tags
    // rust: .iter()
    // rust: .filter(|t| visible(t))
    // rust: .map(|(ns, path)| format!("#{ns}:{path}"))
    // rust: .collect()
}
    // Tab button position relative to the screen origin (CreativeModeInventoryScreen.getTabX/Y).
tab_position :: proc(tab: ^Tab) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut x = tab.column as f32 * 27.0;
    // rust: if tab.column >= 5 {
            // Right-aligned tabs (search, operator, inventory).
    // rust: x = Self::WIDTH - 27.0 * (7 - tab.column) as f32 + 1.0;
}
    // rust: let y = if tab.top { -28.0 } else { Self::HEIGHT - 4.0 };
    // rust: (x, y)
}
    // `CreativeModeInventoryScreen.extractTabButton`'s cursor: an unselected
    // tab asks for the pointing hand when the whole-pixel mouse, relative to
    // the screen origin, is strictly inside its 26x32 button.
tab_wants_hand :: proc(tab: ^Tab, selected: bool, mouse: (f32) {
}
    // rust: let (x, y) = Self::tab_position(tab);
    // rust: let (mx, my) = (mouse.0.floor(), mouse.1.floor());
    // rust: !selected && mx > x && my > y && mx < x + 26.0 && my < y + 32.0
}
}
// Whether a suffix array of `strings` has a suffix starting with `text`:
// some string contains it (none for no strings, even when `text` is empty).
    // rust: fn any<'a>(strings: impl IntoIterator<Item = &'a str>, text: &str) -> bool {
    // rust: strings.into_iter().any(|s| s.contains(text))
}
// `ItemStack.isSameItemSameComponents`, the count left out, as the
// tabs' `ItemStackLinkedSet` compares: no components and empty ones match.
same_components :: proc(a: ^ItemStack, b: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let none = crate::item_data::StackData::default();
    // rust: a.item == b.item
    // rust: && a.damage == b.damage
    // rust: && a.data().unwrap_or(&none) == b.data().unwrap_or(&none)
}
// `CreativeModeInventoryScreen.getTooltipFromContainerItem`: the plain
// tooltip only for a category tab's own grid slots (`CustomCreativeSlot`);
// everywhere else in the screen the tab names (and, on the search tab's
// grid, the tag lines) follow the item's name.
tooltip_lists_tabs :: proc(category_tab: bool, grid_slot: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !(category_tab && grid_slot)
}
// String.toLowerCase(Locale.ROOT).
java_lower :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: s.to_lowercase()
}
// String.trim: strips code points up to U+0020.
java_trim :: proc(s: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: s.trim_matches(|c: char| c <= ' ')
}
// Identifier.parse's namespace and path (default namespace `minecraft`).
split_id :: proc(id: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match id.split_once(':') {
    // rust: Some((ns, path)) => (ns.to_owned(), path.to_owned()),
    // rust: None => ("minecraft".to_owned(), id.to_owned()),
}
}
// The slot under the cursor, for the search tab's keys.
Hover :: enum {
    Nothing,
    // A display slot (`isCreativeSlot`), showing an item or past the end.
    Display {,
    filled: bool,
    // rust: },
    // Any other slot: the hotbar row, or the inventory tab's slots.
    Slot,
}

// `CreativeModeInventoryScreen.keyPressed` on the search tab: whether a
// key is a hotbar swap on the hovered slot instead of text for the search
// box. `numeric` is `getNumericKeyValue().isPresent()` (the digit and keypad
// keys); `hotbar_key` is a `keyHotbarSlots` key. Over an empty display slot
// the key types (`doQuickSwap` is false), and `checkHotbarKeyPressed` needs
// a hovered slot and an empty cursor.
search_key_swaps :: proc(numeric: bool, hotbar_key: bool, hover: Hover, carrying: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let quick_swap = hover != Hover::Display { filled: false };
    // rust: quick_swap && numeric && hotbar_key && !carrying && hover != Hover::Nothing
}

// What a click on an item tab's display slot does besides changing the
// carried stack.
DisplayClick :: enum {
    Nothing,
    // SWAP: the hotbar slot gets a full stack of the item.
    Hotbar(usize, ItemStack),
    // SWAP with button 40 (Key F): the off-hand gets a full stack of the item.
    Offhand(ItemStack),
    // THROW: a copy of the item is dropped.
    Drop(ItemStack),
}

// Whether a stack has `minecraft:creative_slot_lock`.
slot_locked :: proc(stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: stack
    // rust: .data()
    // rust: .is_some_and(|d| d.other("minecraft:creative_slot_lock").is_some())
}

// `CreativeModeInventoryScreen.slotClicked` on a display slot
// (`slot.container == CONTAINER`): `shown` is the slot's item (None past
// the tab's end) and `max` gives an item's max stack size. The tab's items
// are never changed: clicks make copies.
    // rust: pub fn click_display(
    // rust: carried: &mut Option<ItemStack>,
    // rust: shown: Option<&ItemStack>,
    // rust: max: impl Fn(&ItemStack) -> u32,
    // rust: button: i32,
    // rust: input: crate::menu::Input,
    // rust: ) -> DisplayClick {
//     use crate::menu::Input;
    // CustomCreativeSlot.mayPickup: a `creative_slot_lock` stack (the saved
    // toolbars' hint) can't be clicked at all.
    // rust: if shown.is_some_and(slot_locked) {
    // rust: return DisplayClick::Nothing;
}
    // rust: let copy = |s: &ItemStack, count: u32| ItemStack { count, ..s.clone() };
    // rust: let quick_key = input == Input::QuickMove;
    // rust: match input {
    // rust: Input::Swap => {
    // rust: return match shown {
    // rust: Some(s) if button == 40 => DisplayClick::Offhand(copy(s, max(s))),
    // rust: Some(s) if (0..9).contains(&button) => {
    // rust: DisplayClick::Hotbar(button as usize, copy(s, max(s)))
}
    // rust: Some(_) | None => DisplayClick::Nothing,
}
}
    // rust: Input::Clone => {
    // rust: if carried.is_none()
    // rust: && let Some(s) = shown
    // rust: {
    // rust: *carried = Some(copy(s, max(s)));
}
    // rust: return DisplayClick::Nothing;
}
    // rust: Input::Throw => {
    // rust: return match shown {
    // rust: Some(s) => DisplayClick::Drop(copy(s, if button == 0 { 1 } else { max(s) })),
    // rust: None => DisplayClick::Nothing,
}
}
    // rust: _ => {}
}
    // rust: match (carried.as_mut(), shown) {
    // rust: (Some(c), Some(s)) if c.item == s.item && c.extra == s.extra && c.damage == s.damage => {
            // isSameItemSameComponents: grow, fill or shrink what is carried.
    // rust: if button == 0 {
    // rust: if quick_key {
    // rust: c.count = max(c);
    // rust: } else if c.count < max(c) {
    // rust: c.count += 1;
}
    // rust: } else {
    // rust: c.count -= 1;
}
}
    // rust: (None, Some(s)) => {
    // rust: *carried = Some(copy(s, if quick_key { max(s) } else { s.count }));
}
    // rust: (Some(c), _) => {
    // rust: if button == 0 {
    // rust: *carried = None;
    // rust: } else {
    // rust: c.count -= 1;
}
}
    // rust: (None, None) => {}
}
    // rust: if carried.as_ref().is_some_and(|c| c.count == 0) {
    // rust: *carried = None;
}
    // rust: DisplayClick::Nothing
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::nbt::Tag;

stack :: proc(item: string, count: u32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: ItemStack {
    // rust: item: format!("minecraft:{item}").into(),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
}
}

    // One click on a display slot showing one stone (max 64; pearls 16).
    // rust: fn display(
    // rust: carried: Option<ItemStack>,
    // rust: button: i32,
    // rust: input: crate::menu::Input,
    // rust: ) -> (Option<ItemStack>, DisplayClick) {
    // rust: let mut carried = carried;
    // rust: let max = |s: &ItemStack| if s.item.ends_with("pearl") { 16 } else { 64 };
    // rust: let effect = click_display(&mut carried, Some(&stack("stone", 1)), max, button, input);
    // rust: (carried, effect)
}

    // Tabs as the export lists them: two block tabs sharing the oak log,
    // ingredients with the top-level book only, the search tab with every
    // stack (a level 1 book only there) and its tags, the inventory.
tooltip_tabs :: proc() -> C {
    // Ported from Horizon
    return {}
}
    // rust: let book = |level: u8| {
    // rust: format!(
    // rust: r#"{{components:{{"minecraft:stored_enchantments":{{"minecraft:sharpness":{level}}}}},count:1,id:"minecraft:enchanted_book"}}"#
    // rust: )
}
    // rust: let log = r#"{count:1,id:"minecraft:oak_log"}"#;
    // rust: let dirt = r#"{count:1,id:"minecraft:dirt"}"#;
    // rust: let tab = |id: &str, kind: &str, items: Vec<String>| serde_json::json!({"id": id, "type": kind, "title": id, "icon": log, "items": items});
    // rust: let mut search = tab(
    // rust: "minecraft:search",
    // rust: "SEARCH",
    // rust: vec![log.into(), dirt.into(), book(1), book(5)],
    // rust: );
    // rust: search["lines"] = serde_json::json!([[], [], [], []]);
    // rust: search["tags"] = serde_json::json!([
    // rust: [
    // rust: "minecraft:logs",
    // rust: "minecraft:oak_logs",
    // rust: "minecraft:logs_that_burn"
    // rust: ],
    // rust: ["minecraft:dirt"],
    // rust: [],
    // rust: []
    // rust: ]);
    // rust: Creative::from_json(&serde_json::json!({"tabs": [
    // rust: tab("minecraft:building_blocks", "CATEGORY", vec![log.into()]),
    // rust: tab("minecraft:natural_blocks", "CATEGORY", vec![log.into(), dirt.into()]),
    // rust: tab("minecraft:hotbar", "HOTBAR", vec![]),
    // rust: search,
    // rust: tab("minecraft:ingredients", "CATEGORY", vec![book(5)]),
    // rust: tab("minecraft:inventory", "INVENTORY", vec![]),
    // rust: ]}))
    // rust: .unwrap()
}

tooltip_lists_the_tabs_that_contain_the_stack :: proc() {
}
    // rust: let c = tooltip_tabs();
    // rust: let ids = |s: &ItemStack| -> Vec<&str> {
    // rust: c.tabs_containing(s)
    // rust: .into_iter()
    // rust: .map(|i| c.tabs[i].id.as_str())
    // rust: .collect()
}
        // In tab order, the search and inventory tabs left out; the count
        // doesn't matter.
    // rust: assert_eq!(
    // rust: ids(&stack("oak_log", 37)),
    // rust: ["minecraft:building_blocks", "minecraft:natural_blocks"]
    // rust: );
    // rust: assert_eq!(ids(&stack("dirt", 1)), ["minecraft:natural_blocks"]);
        // A stack no tab holds: other components, or no creative item.
    // rust: let mut damaged = stack("oak_log", 1);
    // rust: damaged.damage = 3;
    // rust: assert!(ids(&damaged).is_empty());
    // rust: assert!(ids(&stack("barrier", 1)).is_empty());
        // A level 1 book is a search-tab-only stack of the ingredients tab.
    // rust: let books: Vec<&ItemStack> = c
    // rust: .search_items()
    // rust: .iter()
    // rust: .filter(|s| &*s.item == "minecraft:enchanted_book")
    // rust: .collect();
    // rust: assert_eq!(ids(books[0]), ["minecraft:ingredients"]);
    // rust: assert_eq!(ids(books[1]), ["minecraft:ingredients"]);
}

tooltip_tab_names_skip_only_a_category_tab_grid :: proc() {
}
    // rust: assert!(!tooltip_lists_tabs(true, true));
        // The hotbar row of a category tab, the search tab's grid and hotbar,
        // the inventory tab.
    // rust: assert!(tooltip_lists_tabs(true, false));
    // rust: assert!(tooltip_lists_tabs(false, true));
    // rust: assert!(tooltip_lists_tabs(false, false));
}

tag_search_lists_the_matching_tags_of_the_stack :: proc() {
}
    // rust: let mut c = tooltip_tabs();
    // rust: let log = stack("oak_log", 1);
    // rust: assert!(c.search_tag_lines(&log).is_empty());
    // rust: c.search.set_value("logs");
    // rust: assert!(c.search_tag_lines(&log).is_empty());
    // rust: c.search.set_value("#logs");
    // rust: assert_eq!(
    // rust: c.search_tag_lines(&log),
    // rust: [
    // rust: "#minecraft:logs",
    // rust: "#minecraft:oak_logs",
    // rust: "#minecraft:logs_that_burn"
    // rust: ]
    // rust: );
    // rust: c.search.set_value("#oak");
    // rust: assert_eq!(c.search_tag_lines(&log), ["#minecraft:oak_logs"]);
    // rust: c.search.set_value("#mine : burn");
    // rust: assert_eq!(c.search_tag_lines(&log), ["#minecraft:logs_that_burn"]);
    // rust: assert!(c.search_tag_lines(&stack("dirt", 1)).is_empty());
}

search_tab_number_keys_swap_over_a_slot_before_typing :: proc() {
}
    // rust: let filled = Hover::Display { filled: true };
    // rust: let empty = Hover::Display { filled: false };
        // Over an item, the hotbar row or another slot: the hotbar swap.
    // rust: assert!(search_key_swaps(true, true, filled, false));
    // rust: assert!(search_key_swaps(true, true, Hover::Slot, false));
        // Over an empty display slot, nothing or with a carried stack: text.
    // rust: assert!(!search_key_swaps(true, true, empty, false));
    // rust: assert!(!search_key_swaps(true, true, Hover::Nothing, false));
    // rust: assert!(!search_key_swaps(true, true, filled, true));
        // Letters always type; so do the digits no hotbar key is bound to.
    // rust: assert!(!search_key_swaps(false, false, filled, false));
    // rust: assert!(!search_key_swaps(true, false, filled, false));
}

display_slot_clicks_follow_slot_clicked :: proc() {
}
//         use crate::menu::Input::*;
        // An empty hand takes the shown stack, or a full one with Shift.
    // rust: assert_eq!(display(None, 0, Pickup).0, Some(stack("stone", 1)));
    // rust: assert_eq!(display(None, 1, Pickup).0, Some(stack("stone", 1)));
    // rust: assert_eq!(display(None, 0, QuickMove).0, Some(stack("stone", 64)));
        // The same item grows by one (left), fills (Shift) or shrinks (right).
    // rust: assert_eq!(
    // rust: display(Some(stack("stone", 5)), 0, Pickup).0,
    // rust: Some(stack("stone", 6))
    // rust: );
    // rust: assert_eq!(
    // rust: display(Some(stack("stone", 64)), 0, Pickup).0,
    // rust: Some(stack("stone", 64))
    // rust: );
    // rust: assert_eq!(
    // rust: display(Some(stack("stone", 5)), 0, QuickMove).0,
    // rust: Some(stack("stone", 64))
    // rust: );
    // rust: assert_eq!(
    // rust: display(Some(stack("stone", 5)), 1, Pickup).0,
    // rust: Some(stack("stone", 4))
    // rust: );
    // rust: assert_eq!(display(Some(stack("stone", 1)), 1, QuickMove).0, None);
        // Another item is deleted (left) or loses one (right).
    // rust: assert_eq!(display(Some(stack("ender_pearl", 9)), 0, Pickup).0, None);
    // rust: assert_eq!(display(Some(stack("ender_pearl", 9)), 0, QuickMove).0, None);
    // rust: assert_eq!(
    // rust: display(Some(stack("ender_pearl", 9)), 1, Pickup).0,
    // rust: Some(stack("ender_pearl", 8))
    // rust: );
        // Number keys fill a hotbar slot, F fills off-hand, Q drops copies, pick block clones.
    // rust: assert_eq!(
    // rust: display(None, 3, Swap).1,
    // rust: DisplayClick::Hotbar(3, stack("stone", 64))
    // rust: );
    // rust: assert_eq!(
    // rust: display(None, 40, Swap).1,
    // rust: DisplayClick::Offhand(stack("stone", 64))
    // rust: );
    // rust: assert_eq!(
    // rust: display(None, 0, Throw).1,
    // rust: DisplayClick::Drop(stack("stone", 1))
    // rust: );
    // rust: assert_eq!(
    // rust: display(None, 1, Throw).1,
    // rust: DisplayClick::Drop(stack("stone", 64))
    // rust: );
    // rust: assert_eq!(display(None, 2, Clone).0, Some(stack("stone", 64)));
    // rust: assert_eq!(
    // rust: display(Some(stack("dirt", 2)), 2, Clone).0,
    // rust: Some(stack("dirt", 2))
    // rust: );
}

an_empty_display_slot_deletes_or_shrinks_the_carried_stack :: proc() {
}
//         use crate::menu::Input::Pickup;
    // rust: let mut carried = Some(stack("dirt", 3));
    // rust: click_display(&mut carried, None, |_| 64, 1, Pickup);
    // rust: assert_eq!(carried, Some(stack("dirt", 2)));
    // rust: click_display(&mut carried, None, |_| 64, 0, Pickup);
    // rust: assert_eq!(carried, None);
}

creative :: proc(items: uint) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut stacks: Vec<String> = ["anvil", "crafting_table", "wooden_hoe"]
    // rust: .iter()
    // rust: .map(|i| format!("{{count:1,id:\"minecraft:{i}\"}}"))
    // rust: .collect();
    // rust: stacks.extend((0..items).map(|i| format!("{{count:1,id:\"minecraft:item_{i}\"}}")));
    // rust: let mut lines = vec![
    // rust: vec!["Anvil"],
    // rust: vec!["Crafting Table"],
    // rust: vec!["Wooden Hoe", "When in Main Hand:", "-3 Attack Speed"],
    // rust: ];
    // rust: lines.extend(vec![vec!["Thing"]; items]);
    // rust: let mut tags = vec![
    // rust: vec!["minecraft:anvil"],
    // rust: vec![],
    // rust: vec!["minecraft:hoes", "minecraft:enchantable/mining"],
    // rust: ];
    // rust: tags.extend(vec![vec![]; items]);
    // rust: let raw = serde_json::json!({"schema": 2, "tabs": [
    // rust: {"id": "minecraft:functional_blocks", "type": "CATEGORY", "row": "TOP", "column": 3, "title": "Functional Blocks",
    // rust: "icon": "{count:1,id:\"minecraft:oak_sign\"}", "visible": true,
    // rust: "items": ["{count:1,id:\"minecraft:anvil\"}", "{count:1,id:\"minecraft:crafting_table\"}"]},
    // rust: {"id": "minecraft:op_blocks", "type": "CATEGORY", "row": "BOTTOM", "column": 5, "title": "Operator Utilities",
    // rust: "icon": "{count:1,id:\"minecraft:command_block\"}", "visible": false, "items": []},
    // rust: {"id": "minecraft:search", "type": "SEARCH", "row": "TOP", "column": 6, "title": "Search Items",
    // rust: "icon": "{count:1,id:\"minecraft:compass\"}", "visible": true,
    // rust: "items": stacks, "lines": lines, "tags": tags},
    // rust: {"id": "minecraft:inventory", "type": "INVENTORY", "row": "BOTTOM", "column": 6, "title": "Survival Inventory",
    // rust: "icon": "{count:1,id:\"minecraft:chest\"}", "visible": true, "items": []}
    // rust: ]});
    // rust: Creative::from_json(&raw).unwrap()
}

inventory_tab_slot_layout_matches_vanilla :: proc() {
}
    // rust: assert_eq!(Creative::inventory_slots().count(), 41);
    // rust: for (slot, expected) in [
    // rust: (0, (9.0, 112.0)),
    // rust: (8, (153.0, 112.0)),
    // rust: (9, (9.0, 54.0)),
    // rust: (35, (153.0, 90.0)),
    // rust: (500, (54.0, 6.0)),
    // rust: (501, (54.0, 33.0)),
    // rust: (502, (108.0, 6.0)),
    // rust: (503, (108.0, 33.0)),
    // rust: (504, (35.0, 20.0)),
    // rust: ] {
    // rust: assert_eq!(Creative::inventory_slot_position(slot), Some(expected));
}
    // rust: assert_eq!(Creative::inventory_slot_position(100), None);
    // rust: assert_eq!(Creative::TRASH_POSITION, (173.0, 112.0));
    // rust: let mut c = creative(90);
    // rust: c.select(2);
    // rust: assert!(c.tab().inventory);
    // rust: assert!(!c.can_scroll(&Names {
    // rust: map: HashMap::new()
    // rust: }));
}

inventory_tab_can_return_to_category_and_search :: proc() {
}
    // rust: let mut c = creative(90);
    // rust: for (selected, inventory, search) in [
    // rust: (2, true, false),
    // rust: (0, false, false),
    // rust: (1, false, true),
    // rust: (2, true, false),
    // rust: ] {
    // rust: c.search.set_value("anvil");
    // rust: c.scroll = 0.5;
    // rust: c.select(selected);
    // rust: assert_eq!(c.selected, selected);
    // rust: assert_eq!(c.tab().inventory, inventory);
    // rust: assert_eq!(c.tab().search, search);
    // rust: assert!(c.search.value.is_empty());
    // rust: assert_eq!(c.scroll, 0.0);
}
}

hidden_tabs_are_skipped :: proc() {
}
    // rust: let c = creative(0);
    // rust: let ids: Vec<&str> = c.tabs.iter().map(|t| t.id.as_str()).collect();
    // rust: assert_eq!(
    // rust: ids,
    // rust: [
    // rust: "minecraft:functional_blocks",
    // rust: "minecraft:search",
    // rust: "minecraft:inventory"
    // rust: ]
    // rust: );
    // rust: assert_eq!(c.tabs[0].items[0].item.as_ref(), "minecraft:anvil");
    // rust: let mut c = c;
    // rust: c.select(1);
    // rust: c.search.set_value("anvil");
    // rust: c.scroll = 0.5;
    // rust: c.select(1);
    // rust: assert_eq!((c.search.value.as_str(), c.scroll), ("anvil", 0.0));
    // rust: c.select(0);
    // rust: assert_eq!(c.search.value, "");
}

stepping_through_tabs_turns_their_pages :: proc() {
}
    // rust: let stack = |id: &str| format!("{{count:1,id:\"minecraft:{id}\"}}");
    // rust: let tab = |id: &str, column: u32, page: u32| {
    // rust: serde_json::json!({"id": format!("minecraft:{id}"), "type": "CATEGORY", "row": "TOP",
    // rust: "column": column, "page": page, "title": id, "icon": stack("stone"),
    // rust: "visible": true, "items": [stack("stone")]})
}
    // rust: let raw = serde_json::json!({"schema": 3, "tabs": [
    // rust: tab("first", 0, 0), tab("second", 1, 0), tab("modded", 0, 1), tab("more", 1, 2),
    // rust: tab("everywhere", 6, 0)
    // rust: ]});
    // rust: let mut c = Creative::from_json(&raw).unwrap();
    // rust: assert_eq!(c.pages(), 3);
    // rust: let count = c.tabs.len();
    // rust: let mut pages = Vec::new();
    // rust: for step in 1..=count {
    // rust: let tab = (c.selected + 1) % count;
    // rust: c.select(tab);
    // rust: assert_eq!(c.selected, tab, "step {step}");
    // rust: assert!(
    // rust: c.on_page(&c.tabs[tab]),
    // rust: "tab {tab} selected on another page"
    // rust: );
    // rust: pages.push(c.page);
}
        // A tab every page shows keeps the page it was reached from; then it wraps.
    // rust: assert_eq!(pages, [0, 1, 2, 2, 0]);
        // Backwards off the first tab, across pages, the same way.
    // rust: c.select((c.selected + count - 1) % count);
    // rust: assert_eq!(c.page, 0);
    // rust: c.select((c.selected + count - 1) % count);
    // rust: assert_eq!(c.page, 2);
}

    // An export built with permissions: the operator tab's stacks, and their
    // place at the end of the search tab, only with them.
with_operator_tab :: proc() -> C {
    // Ported from Horizon
    return {}
}
    // rust: let stack = |id: &str| format!("{{count:1,id:\"minecraft:{id}\"}}");
    // rust: let raw = serde_json::json!({"schema": 3, "tabs": [
    // rust: {"id": "minecraft:building_blocks", "type": "CATEGORY", "row": "TOP", "column": 0, "title": "Building Blocks",
    // rust: "icon": stack("bricks"), "visible": true, "items": [stack("stone")]},
    // rust: {"id": "minecraft:op_blocks", "type": "CATEGORY", "row": "BOTTOM", "column": 5, "title": "Operator Utilities",
    // rust: "icon": stack("command_block"), "visible": false,
    // rust: "items": [stack("command_block"), stack("barrier")], "permissions_only": [0, 1]},
    // rust: {"id": "minecraft:search", "type": "SEARCH", "row": "TOP", "column": 6, "title": "Search Items",
    // rust: "icon": stack("compass"), "visible": true,
    // rust: "items": [stack("stone"), stack("command_block"), stack("barrier")],
    // rust: "lines": [["Stone"], ["Command Block"], ["Barrier"]], "tags": [[], [], []],
    // rust: "permissions_only": [1, 2]},
    // rust: {"id": "minecraft:inventory", "type": "INVENTORY", "row": "BOTTOM", "column": 6, "title": "Survival Inventory",
    // rust: "icon": stack("chest"), "visible": true, "items": []}
    // rust: ]});
    // rust: Creative::from_json(&raw).unwrap()
}

tab_ids :: proc(c: ^Creative) -> V {
    // Ported from Horizon
    return {}
}
    // rust: c.tabs.iter().map(|t| t.id.as_str()).collect()
}

operator_stacks_stay_out_without_permissions :: proc() {
}
    // rust: let c = with_operator_tab();
    // rust: let names = Names::default();
    // rust: assert_eq!(
    // rust: tab_ids(&c),
    // rust: [
    // rust: "minecraft:building_blocks",
    // rust: "minecraft:search",
    // rust: "minecraft:inventory"
    // rust: ]
    // rust: );
    // rust: assert_eq!(c.search_items().len(), 1);
    // rust: assert!(c.search_results("command", &names).is_empty());
    // rust: assert_eq!(c.search_results("", &names), [0]);
}

operator_tab_comes_and_goes_with_permissions :: proc() {
}
    // rust: let mut c = with_operator_tab();
    // rust: let names = Names::default();
    // rust: assert!(!c.set_permissions(false, &names));
    // rust: assert!(c.set_permissions(true, &names));
    // rust: assert!(!c.set_permissions(true, &names));
    // rust: assert_eq!(
    // rust: tab_ids(&c),
    // rust: [
    // rust: "minecraft:building_blocks",
    // rust: "minecraft:op_blocks",
    // rust: "minecraft:search",
    // rust: "minecraft:inventory"
    // rust: ]
    // rust: );
    // rust: let op: Vec<&str> = c.tabs[1].items.iter().map(|s| s.item.as_ref()).collect();
    // rust: assert_eq!(op, ["minecraft:command_block", "minecraft:barrier"]);
    // rust: assert_eq!(c.search_results("command", &names), [1]);
    // rust: assert_eq!(c.search_results("", &names), [0, 1, 2]);
        // The search tab keeps its place across the rebuild.
    // rust: c.select(2);
    // rust: c.search.set_value("block");
    // rust: assert!(c.set_permissions(false, &names));
    // rust: assert!(c.tab().search);
    // rust: assert_eq!(c.search.value, "block");
    // rust: assert!(c.items(&names).is_empty());
        // The selected operator tab is left empty: the default tab instead.
    // rust: c.set_permissions(true, &names);
    // rust: c.select(1);
    // rust: assert_eq!(c.items(&names).len(), 2);
    // rust: c.set_permissions(false, &names);
    // rust: assert_eq!(c.tab().id, "minecraft:building_blocks");
    // rust: assert_eq!(c.items(&names)[0].item.as_ref(), "minecraft:stone");
}

saved_hotbars_tab_shows_its_rows_and_locks_the_hint :: proc() {
}
    // rust: let mut c = Creative::from_json(&serde_json::json!({"schema": 2, "tabs": [
    // rust: {"id": "minecraft:hotbar", "type": "HOTBAR", "row": "TOP", "column": 5, "title": "Saved Hotbars",
    // rust: "icon": "{count:1,id:\"minecraft:bookshelf\"}", "visible": true, "items": []},
    // rust: {"id": "minecraft:inventory", "type": "INVENTORY", "row": "BOTTOM", "column": 6, "title": "Survival Inventory",
    // rust: "icon": "{count:1,id:\"minecraft:chest\"}", "visible": true, "items": []}
    // rust: ]}))
    // rust: .unwrap();
    // rust: assert!(c.tab().hotbar);
    // rust: assert!(!c.tab_headers()[1].hotbar);
    // rust: let mut hint = stack("paper", 1);
    // rust: hint.data_mut().set_other(
    // rust: "minecraft:creative_slot_lock",
    // rust: Some(Tag::compound(Vec::<(&str, Tag)>::new())),
    // rust: );
        // A saved sword in slot 0, an empty slot, then the hint.
    // rust: c.set_saved_hotbars(vec![stack("diamond_sword", 1), stack("air", 0), hint]);
    // rust: let names = Names {
    // rust: map: HashMap::new(),
}
    // rust: assert_eq!(c.shown(&names, 0), Some(stack("diamond_sword", 1)));
    // rust: assert_eq!(c.shown(&names, 1), None);
    // rust: assert_eq!(c.shown(&names, 3), None);
    // rust: let hint = c.shown(&names, 2).unwrap();
    // rust: assert!(slot_locked(&hint));
    // rust: assert!(!slot_locked(&stack("diamond_sword", 1)));
        // CustomCreativeSlot.mayPickup: the hint is never taken, and a carried
        // stack stays as it is.
//         use crate::menu::Input::*;
    // rust: for (carried, button, input) in [
    // rust: (None, 0, Pickup),
    // rust: (None, 0, QuickMove),
    // rust: (None, 2, Clone),
    // rust: (None, 3, Swap),
    // rust: (None, 0, Throw),
    // rust: (Some(stack("dirt", 2)), 0, Pickup),
    // rust: (Some(stack("dirt", 2)), 1, Pickup),
    // rust: ] {
    // rust: let mut carried = carried;
    // rust: let before = carried.clone();
    // rust: let effect = click_display(&mut carried, Some(&hint), |_| 64, button, input);
    // rust: assert_eq!(effect, DisplayClick::Nothing);
    // rust: assert_eq!(carried, before);
}
}

search_matches_vanilla_trees :: proc() {
}
    // rust: let c = creative(0);
    // rust: let names = Names {
    // rust: map: HashMap::new(),
}
    // rust: let q = |s: &str| c.search_results(s, &names);
    // rust: assert_eq!(q(""), [0, 1, 2]);
    // rust: assert_eq!(q("ANVIL"), [0]);
    // rust: assert_eq!(q("table"), [1]);
    // rust: assert_eq!(q("a"), [0, 1, 2]);
        // Tooltip lines, not just names; no trimming without a colon.
    // rust: assert_eq!(q("attack speed"), [2]);
    // rust: assert_eq!(q(" anvil"), Vec::<usize>::new());
        // A colon searches the id: namespace, then the path or a tooltip line.
    // rust: assert_eq!(q("minecraft:crafting_t"), [1]);
    // rust: assert_eq!(q(" minecraft : hoe "), [2]);
    // rust: assert_eq!(q("mine:anvil"), [0]);
    // rust: assert_eq!(q("other:anvil"), Vec::<usize>::new());
    // rust: assert_eq!(q(":"), [0, 1, 2]);
        // Tags after "#": only stacks with tags.
    // rust: assert_eq!(q("#"), [0, 2]);
    // rust: assert_eq!(q("#hoe"), [2]);
    // rust: assert_eq!(q("#minecraft:enchantable/"), [2]);
    // rust: assert_eq!(q("#craft"), Vec::<usize>::new());
}

search_matches_the_display_name_in_the_selected_language :: proc() {
}
    // rust: let c = creative(0);
    // rust: let names = Names {
    // rust: map: HashMap::from([
    // rust: ("item.minecraft.anvil".to_owned(), "铁砧".to_owned()),
    // rust: ("item.minecraft.wooden_hoe".to_owned(), "木锄".to_owned()),
    // rust: ]),
}
    // rust: let tr = |k: &str| names.get(k).map(str::to_owned);
    // rust: let local = c.localized_lines(&tr);
    // rust: let q = |s: &str| c.search_results_in(s, &names, &local, false);
    // rust: assert_eq!(q("铁砧"), [0]);
    // rust: assert_eq!(q("木锄"), [2]);
        // Only the selected language's lines count outside English.
    // rust: assert!(q("anvil").is_empty());
    // rust: assert_eq!(c.search_results_in("anvil", &names, &local, true), [0]);
        // A colon's path searches the display name too.
    // rust: assert_eq!(q("minecraft:铁砧"), [0]);
}

search_matches_every_localized_tooltip_line :: proc() {
}
        // Vanilla's FullTextSearchTree indexes the selected language's
        // tooltip lines; the export's English lines do not apply.
    // rust: let c = creative(0);
    // rust: let names = Names::default();
    // rust: let ru: HashMap<&str, &str> = HashMap::from([("item.minecraft.anvil", "Наковальня")]);
    // rust: let tr = |k: &str| ru.get(k).map(|v| (*v).to_owned());
    // rust: let local = c.localized_lines(&tr);
    // rust: let q = |s: &str, english| c.search_results_in(s, &names, &local, english);
    // rust: assert_eq!(q("наков", false), [0]);
    // rust: assert!(q("anvil", false).is_empty());
    // rust: assert_eq!(q("anvil", true), [0]);
}

scrollbar_drag_follows_the_mouse_while_held :: proc() {
}
    // rust: let mut c = creative(90);
    // rust: let names = Names {
    // rust: map: HashMap::new(),
}
    // rust: c.selected = 1;
        // Pressing the track holds the scrollbar without moving it.
    // rust: assert!(c.press_scrollbar(180.0, 60.0, &names));
    // rust: assert!(c.scrolling);
    // rust: assert_eq!(c.scroll, 0.0);
        // Dragging maps the cursor height onto the track (minus half the thumb).
    // rust: assert!(c.drag_scrollbar(18.0 + 7.5 + 48.5));
    // rust: assert!((c.scroll - 0.5).abs() < 1e-6);
        // The cursor may leave the track, the panel or the window: it keeps scrolling.
    // rust: c.drag_scrollbar(400.0);
    // rust: assert_eq!(c.scroll, 1.0);
    // rust: c.drag_scrollbar(-50.0);
    // rust: assert_eq!(c.scroll, 0.0);
    // rust: c.drag_scrollbar(18.0 + 7.5 + 97.0 * 0.25);
    // rust: assert!((c.scroll - 0.25).abs() < 1e-6);
    // rust: let rows = (93usize.div_ceil(9) - 5) as f32;
    // rust: assert_eq!(c.first_row(&names), (0.25 * rows + 0.5) as usize);
        // Releasing stops it.
    // rust: c.release();
    // rust: assert!(!c.drag_scrollbar(400.0));
    // rust: assert!((c.scroll - 0.25).abs() < 1e-6);
        // Off the track, or with too few items, it isn't held.
    // rust: assert!(!c.press_scrollbar(170.0, 60.0, &names));
    // rust: assert!(!c.press_scrollbar(180.0, 130.0, &names));
    // rust: c.selected = 0;
    // rust: assert!(c.press_scrollbar(180.0, 60.0, &names));
    // rust: assert!(!c.scrolling);
}

creative_tab_titles_have_vanilla_keys :: proc() {
}
    // rust: assert_eq!(
    // rust: item_group_key("minecraft:building_blocks"),
    // rust: Some("itemGroup.buildingBlocks")
    // rust: );
    // rust: assert_eq!(
    // rust: item_group_key("minecraft:food_and_drinks"),
    // rust: Some("itemGroup.foodAndDrink")
    // rust: );
    // rust: assert_eq!(item_group_key("minecraft:hotbar"), Some("itemGroup.hotbar"));
    // rust: assert_eq!(item_group_key("minecraft:nonsense"), None);
}

wheel_moves_one_row_per_notch :: proc() {
}
    // rust: let mut c = creative(90);
    // rust: let names = Names {
    // rust: map: HashMap::new(),
}
    // rust: c.selected = 1;
    // rust: let rows = (93usize.div_ceil(9) - 5) as f32;
    // rust: c.wheel(-1.0, &names);
    // rust: assert!((c.scroll - 1.0 / rows).abs() < 1e-6);
    // rust: assert_eq!(c.first_row(&names), 1);
    // rust: c.wheel(5.0, &names);
    // rust: assert_eq!(c.scroll, 0.0);
    // rust: assert_eq!(c.scroller_offset(), 0.0);
    // rust: c.scroll = 1.0;
    // rust: assert_eq!(c.scroller_offset(), 95.0);
}

search_edits_at_its_cursor :: proc() {
}
//         use winit::keyboard::KeyCode;
    // rust: let mut c = creative(0);
    // rust: c.select(1);
    // rust: c.search.insert_text("hello world");
    // rust: for _ in 0..5 {
    // rust: assert!(c.search.key(KeyCode::ArrowLeft, false, false));
}
    // rust: c.search.insert_text("X");
    // rust: assert_eq!(c.search.value, "hello Xworld");
    // rust: c.search.key(KeyCode::Home, false, true);
    // rust: c.search.insert_text("Y");
    // rust: assert_eq!(c.search.value, "Yworld");
        // Ctrl+Left jumps a word; one step right and Backspace deletes before the cursor.
    // rust: c.search.key(KeyCode::ArrowLeft, true, false);
    // rust: c.search.key(KeyCode::ArrowRight, false, false);
    // rust: c.search.key(KeyCode::Backspace, false, false);
    // rust: assert_eq!(c.search.value, "world");
}

unselected_tabs_want_the_hand_strictly_inside :: proc() {
}
    // rust: let tab = |top, column| Tab {
    // rust: id: String::new(),
    // rust: title: String::new(),
    // rust: icon: String::new(),
    // rust: items: Vec::new(),
    // rust: top,
    // rust: column,
    // rust: search: false,
    // rust: inventory: false,
    // rust: hotbar: false,
    // rust: page: 0,
}
        // Top row, second column: the button spans x 27..53, y -28..4.
    // rust: let t = tab(true, 1);
    // rust: assert!(Creative::tab_wants_hand(&t, false, (40.0, -10.0)));
    // rust: assert!(!Creative::tab_wants_hand(&t, true, (40.0, -10.0)));
        // Its edges ask for nothing; the mouse counts in whole pixels.
    // rust: assert!(!Creative::tab_wants_hand(&t, false, (27.0, -10.0)));
    // rust: assert!(!Creative::tab_wants_hand(&t, false, (27.9, -10.0)));
    // rust: assert!(Creative::tab_wants_hand(&t, false, (28.0, -10.0)));
    // rust: assert!(Creative::tab_wants_hand(&t, false, (52.9, -10.0)));
    // rust: assert!(!Creative::tab_wants_hand(&t, false, (53.0, -10.0)));
    // rust: assert!(!Creative::tab_wants_hand(&t, false, (40.0, -28.0)));
    // rust: assert!(Creative::tab_wants_hand(&t, false, (40.0, -27.0)));
    // rust: assert!(Creative::tab_wants_hand(&t, false, (40.0, 3.9)));
    // rust: assert!(!Creative::tab_wants_hand(&t, false, (40.0, 4.0)));
        // Bottom row, right-aligned inventory column: x 169..195, y 132..164.
    // rust: let b = tab(false, 6);
    // rust: assert!(Creative::tab_wants_hand(&b, false, (180.0, 140.0)));
    // rust: assert!(!Creative::tab_wants_hand(&b, false, (169.0, 140.0)));
    // rust: assert!(Creative::tab_wants_hand(&b, false, (170.0, 140.0)));
    // rust: assert!(!Creative::tab_wants_hand(&b, false, (180.0, 132.0)));
}
}
