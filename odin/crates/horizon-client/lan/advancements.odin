//! Transpiled from Horizon Rust crate
package horizon_client_advancements

import "core:fmt"
import "core:mem"
import "core:math"

// A player's advancements on a server (PlayerAdvancements): on the
// player's first tick the `minecraft:tick` criteria are met, the
// advancements they complete grant their recipes (ServerRecipeBook.addRecipes:
// ClientboundRecipeBookAddPacket) and the advancements the player may see go
// out in ClientboundUpdateAdvancementsPacket (PlayerAdvancements.flushDirty).
// use super::data::{SyncData, json_to_nbt};
// use crate::{
    // rust: advancements::{Progress, Tree},
    // rust: recipe_book::{Category, RecipeIndex, Settings, crafting_category, crafting_station},
}
// use horizon_protocol::buf::Writer;
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet, HashMap},
    // rust: path::Path,
}

ServerAdvancements :: struct {
    tree: std::sync::^Tree,
    kids: [dynamic]Vec<uint>,
    layout: Vec<Option<(i32,
    // Recipe files by id, as compact JSON text with their ingredient
    // objects already resolved to flat item lists (`network_recipes`): a
    // book entry parses its recipe when a player gets it (a few µs), and
    // the ~1,400 parsed files would keep about 5 MB alive for the server's
    // whole run.
    // rust: pub(super) recipes: BTreeMap<String, Box<str>>,
    displays: RecipeIndex,
    // RecipeManager.unpackRecipeInfo's group numbers.
    groups: HashMap<string,
}

// What the first tick sends: ClientboundRecipeBookAddPacket's payload (when
// recipes were unlocked) and ClientboundUpdateAdvancementsPacket's.
FirstTick :: struct {
    recipe_book_add: Maybe([dynamic]u8),
    update_advancements: [dynamic]u8,
    granted: [dynamic]CriterionGrant,
}

// A criterion `CriteriaTriggers.TICK` newly granted, for the game to tell the mods.
CriterionGrant :: struct {
    advancement: string,
    criterion: string,
}

    // rust: impl ServerAdvancements {
    // rust: pub fn load(
    // rust: resources: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: recipes: BTreeMap<String, Box<str>>,
    // rust: groups: HashMap<String, i32>,
    // rust: ) -> Self {
    // rust: let tree = Tree::shared(&resources.join("data"), overlay);
    // rust: let kids = tree.children();
    // rust: let layout = tree.layout();
    // rust: Self {
    // rust: tree,
    // rust: kids,
    // rust: layout,
    // rust: recipes,
    // rust: displays: RecipeIndex::load(resources, overlay),
    // rust: groups,
}
}

    // The first tick of a player without advancements: the criteria
    // `minecraft:tick` meets go into `progress` and the recipes their
    // advancements reward into `book`.
    // rust: pub fn first_tick(
    // rust: &self,
    // rust: sync: &SyncData,
    // rust: now_millis: i64,
    // rust: progress: &mut Progress,
    // rust: book: &mut Settings,
    // rust: ) -> FirstTick {
        // CriteriaTriggers.TICK: the criteria it meets, and what they complete.
    // rust: let mut obtained: Vec<Vec<&str>> = vec![Vec::new(); self.tree.list.len()];
    // rust: for (i, a) in self.tree.list.iter().enumerate() {
    // rust: for c in &a.criteria {
    // rust: if c.trigger == "minecraft:tick" && c.conditions.is_null() {
    // rust: obtained[i].push(&c.name);
}
}
}
    // rust: let done: Vec<bool> = self
    // rust: .tree
    // rust: .list
    // rust: .iter()
    // rust: .zip(&obtained)
    // rust: .map(|(a, got)| {
    // rust: !a.requirements.is_empty()
    // rust: && a.requirements
    // rust: .iter()
    // rust: .all(|group| group.iter().any(|c| got.contains(&c.as_str())))
    // rust: })
    // rust: .collect();
    // rust: let date = crate::advancements::date_text(now_millis.div_euclid(1000));
    // rust: let mut granted = Vec::new();
    // rust: for (a, got) in self.tree.list.iter().zip(&obtained) {
    // rust: for c in got {
    // rust: if progress.grant(&a.id, c, &date) {
    // rust: granted.push(CriterionGrant {
    // rust: advancement: a.id.clone(),
    // rust: criterion: (*c).to_owned(),
    // rust: });
}
}
}
        // AdvancementRewards.grant: the recipes, in the advancements' order.
    // rust: let mut entries = Vec::new();
    // rust: for (i, a) in self.tree.list.iter().enumerate() {
    // rust: if !done[i] {
    // rust: continue;
}
    // rust: book.add_recipes(&self.displays, &a.rewards.recipes);
    // rust: for id in &a.rewards.recipes {
    // rust: entries.extend(self.book_entries(id, sync, NOTIFY_AND_HIGHLIGHT));
}
}
    // rust: let recipe_book_add = (!entries.is_empty()).then(|| book_add(entries, false));
        // flushDirty: every advancement the player may see, and its progress.
    // rust: let visible = self.tree.visible(&self.kids, |i| done[i]);
    // rust: let shown: Vec<usize> = (0..self.tree.list.len()).filter(|i| visible[*i]).collect();
    // rust: let mut w = Writer::new();
    // rust: w.bool(true); // the first packet resets the client's advancements
    // rust: w.varint(shown.len() as i32);
    // rust: for &i in &shown {
    // rust: self.write_advancement(&mut w, i, sync);
}
    // rust: w.varint(0); // nothing removed
    // rust: w.varint(shown.len() as i32);
    // rust: for &i in &shown {
    // rust: self.write_progress(&mut w, i, |c| {
    // rust: obtained[i].contains(&c).then_some(now_millis)
    // rust: });
}
    // rust: w.bool(true); // show the advancements
    // rust: FirstTick {
    // rust: recipe_book_add,
    // rust: update_advancements: w.data,
    // rust: granted,
}
}

    // `RecipeManager.getRecipeFromDisplay`: the recipe a display id names,
    // for `ServerRecipeBook.removeHighlight`.
recipe_of_display :: proc(self: ^Self, display: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.displays.recipe_of_display(display)
}

    // `PlayerAdvancements.reload` (`PlayerList.reloadResources`): the
    // progress is read again against the new tree (`applyFrom` ignores an
    // advancement that no longer exists and `AdvancementProgress.update`
    // drops a criterion it lost), the next `flushDirty` is a first packet
    // again, and the next `CriteriaTriggers.TICK` meets the new tree's
    // `minecraft:tick` criteria, rewarding the recipes of the advancements
    // that complete. The criteria it grants are added to `granted`. Returns
    // the recipe book packet those recipes need.
    // rust: pub fn reload(
    // rust: &self,
    // rust: sync: &SyncData,
    // rust: now_millis: i64,
    // rust: progress: &mut Progress,
    // rust: book: &mut Settings,
    // rust: granted: &mut Vec<CriterionGrant>,
    // rust: ) -> Option<Vec<u8>> {
    // rust: let by_id: HashMap<&str, &crate::advancements::Advancement> =
    // rust: self.tree.list.iter().map(|a| (a.id.as_str(), a)).collect();
    // rust: progress
    // rust: .criteria
    // rust: .retain(|id, got| match by_id.get(id.as_str()) {
    // rust: Some(a) => {
    // rust: got.retain(|name, _| a.criteria.iter().any(|c| &c.name == name));
    // rust: true
}
    // rust: None => false,
    // rust: });
    // rust: let date = crate::advancements::date_text(now_millis.div_euclid(1000));
    // rust: let mut entries = Vec::new();
    // rust: for a in &self.tree.list {
    // rust: let was_done = progress.done(a);
    // rust: for c in &a.criteria {
    // rust: if c.trigger == "minecraft:tick"
    // rust: && c.conditions.is_null()
    // rust: && progress.grant(&a.id, &c.name, &date)
    // rust: {
    // rust: granted.push(CriterionGrant {
    // rust: advancement: a.id.clone(),
    // rust: criterion: c.name.clone(),
    // rust: });
}
}
    // rust: if !was_done && progress.done(a) {
    // rust: book.add_recipes(&self.displays, &a.rewards.recipes);
    // rust: for id in &a.rewards.recipes {
    // rust: entries.extend(self.book_entries(id, sync, NOTIFY_AND_HIGHLIGHT));
}
}
}
    // rust: (!entries.is_empty()).then(|| book_add(entries, false))
}

    // `PlayerAdvancements.flushDirty`: the advancements that became visible
    // or hidden since `visible` (which it updates; empty before the first
    // packet, which resets the client's and carries everything visible) and
    // the progress of the `changed` ones still visible. None when there is
    // nothing to send.
    // rust: pub fn update(
    // rust: &self,
    // rust: sync: &SyncData,
    // rust: progress: &Progress,
    // rust: visible: &mut Vec<bool>,
    // rust: changed: &BTreeSet<usize>,
    // rust: show: bool,
    // rust: ) -> Option<Vec<u8>> {
    // rust: let n = self.tree.list.len();
    // rust: let first = visible.len() != n;
        // flushDirty does nothing unless it is the first packet or progress
        // changed: visibility follows progress alone, and every grant and
        // revoke is in `changed`. This skips walking the whole tree for
        // every player every tick.
    // rust: if !first && changed.is_empty() {
    // rust: return None;
}
    // rust: let now = self
    // rust: .tree
    // rust: .visible(&self.kids, |i| progress.done(&self.tree.list[i]));
    // rust: let was = |i: usize| !first && visible[i];
    // rust: let added: Vec<usize> = (0..n).filter(|&i| now[i] && !was(i)).collect();
    // rust: let removed: Vec<usize> = (0..n).filter(|&i| !now[i] && was(i)).collect();
    // rust: let progressed: Vec<usize> = if first {
    // rust: (0..n).filter(|&i| now[i]).collect()
    // rust: } else {
    // rust: changed
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&i| i < n && now[i])
    // rust: .collect()
}
    // rust: *visible = now;
    // rust: if !first && added.is_empty() && removed.is_empty() && progressed.is_empty() {
    // rust: return None;
}
    // rust: let mut w = Writer::new();
    // rust: w.bool(first);
    // rust: w.varint(added.len() as i32);
    // rust: for &i in &added {
    // rust: self.write_advancement(&mut w, i, sync);
}
    // rust: w.varint(removed.len() as i32);
    // rust: for &i in &removed {
    // rust: w.string(&self.tree.list[i].id);
}
    // rust: w.varint(progressed.len() as i32);
    // rust: for &i in &progressed {
    // rust: let id = &self.tree.list[i].id;
    // rust: self.write_progress(&mut w, i, |c| {
    // rust: progress
    // rust: .criteria
    // rust: .get(id)
    // rust: .and_then(|m| m.get(c))
    // rust: .map(|date| crate::advancements::date_millis(date).unwrap_or(0))
    // rust: });
}
    // rust: w.bool(show);
    // rust: Some(w.data)
}

    // `ServerAdvancementManager.get` then `PlayerAdvancements.setSelectedTab`:
    // `None` when the server has no advancement `id` (the tab is left as it
    // is), else whether a player may keep it as its tab (a root that has a
    // display).
selectable :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.tree
    // rust: .get(id)
    // rust: .map(|a| a.parent.is_none() && a.display.is_some())
}

    // Which advancements a player with `progress` may see.
visibility :: proc(self: ^Self, progress: ^Progress) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.tree
    // rust: .visible(&self.kids, |i| progress.done(&self.tree.list[i]))
}

    // `ClientboundUpdateAdvancementsPacket.PositionedAdvancement`.
write_advancement :: proc(self: ^Self, w: ^Writer, i: uint, sync: ^SyncData) {
}
    // rust: let a = &self.tree.list[i];
    // rust: w.string(&a.id);
    // rust: w.bool(a.parent.is_some());
    // rust: if let Some(p) = &a.parent {
    // rust: w.string(p);
}
    // rust: w.bool(a.display.is_some());
    // rust: if let Some(d) = &a.display {
    // rust: w.nbt(&json_to_nbt(&d.title));
    // rust: w.nbt(&json_to_nbt(&d.description));
    // rust: w.varint(sync.id("minecraft:item", &d.icon).unwrap_or(0));
    // rust: w.varint(1);
    // rust: w.varint(0);
    // rust: w.varint(0);
    // rust: w.varint(match d.frame {
    // rust: crate::advancements::Frame::Task => 0,
    // rust: crate::advancements::Frame::Challenge => 1,
    // rust: crate::advancements::Frame::Goal => 2,
    // rust: });
    // rust: w.i32(
    // rust: i32::from(d.background.is_some())
    // rust: | i32::from(d.show_toast) << 1
    // rust: | i32::from(d.hidden) << 2,
    // rust: );
    // rust: if let Some(b) = &d.background {
    // rust: w.string(b);
}
}
    // rust: w.varint(a.requirements.len() as i32);
    // rust: for group in &a.requirements {
    // rust: w.varint(group.len() as i32);
    // rust: for c in group {
    // rust: w.string(c);
}
}
    // rust: w.bool(false); // sends_telemetry_event
    // rust: let (x, y) = self.layout[i].unwrap_or((0, 0.0));
    // rust: w.f32(x as f32);
    // rust: w.f32(y);
}

    // An `AdvancementProgress`: each criterion and when it was obtained.
write_progress :: proc(self: ^Self, w: ^Writer, i: uint, obtained: impl Fn(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let a = &self.tree.list[i];
    // rust: w.string(&a.id);
    // rust: w.varint(a.criteria.len() as i32);
    // rust: for c in &a.criteria {
    // rust: w.string(&c.name);
    // rust: let at = obtained(&c.name);
    // rust: w.bool(at.is_some());
    // rust: if let Some(at) = at {
    // rust: w.i64(at);
}
}
}

    // `ServerRecipeBook.addRecipes`' packet for recipes just unlocked:
    // each display, with its notification and highlighted. None when no
    // recipe has a display.
recipes_added :: proc(self: ^Self, ids: ^[string], sync: ^SyncData) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let entries: Vec<Vec<u8>> = ids
    // rust: .iter()
    // rust: .flat_map(|id| self.book_entries(id, sync, NOTIFY_AND_HIGHLIGHT))
    // rust: .collect();
    // rust: (!entries.is_empty()).then(|| book_add(entries, false))
}

    // `ServerRecipeBook.sendInitialRecipeBook`: every known recipe, without
    // notifications, highlighted while not yet displayed, replacing the
    // client's book.
initial_recipe_book :: proc(self: ^Self, book: ^Settings, sync: ^SyncData) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let entries: Vec<Vec<u8>> = book
    // rust: .recipes
    // rust: .iter()
    // rust: .flat_map(|id| {
    // rust: let highlight = if book.to_be_displayed.contains(id) {
    // rust: 2
    // rust: } else {
    // rust: 0
}
    // rust: self.book_entries(id, sync, highlight)
    // rust: })
    // rust: .collect();
    // rust: book_add(entries, true)
}

    // The recipe's display for ClientboundPlaceGhostRecipePacket (the
    // recipes the book lists).
    // rust: pub fn ghost_display(
    // rust: &self,
    // rust: id: &str,
    // rust: sync: &SyncData,
    // rust: ) -> Option<horizon_protocol::packets::recipes::RecipeDisplay> {
    // rust: let bytes = self.book_entries(id, sync, 0).into_iter().next()?;
    // rust: let mut r = horizon_protocol::buf::Reader::new(&bytes);
    // rust: horizon_protocol::packets::recipes::RecipeBookEntry::read(&mut r)
    // rust: .ok()
    // rust: .map(|e| e.display)
}

    // ClientboundRecipeBookAddPacket.Entry for each display of a recipe:
    // highlighted, and with a notification unless the recipe turns it off.
book_entries :: proc(self: ^Self, id: string, sync: ^SyncData, flags: i8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let ids = self.displays.display_ids(id);
    // rust: if ids.len() != 1 {
            // Special recipes have no display; transmutations aren't unlocked on joining.
    // rust: return Vec::new();
}
    // rust: let Some(r) = self
    // rust: .recipes
    // rust: .get(id)
    // rust: .and_then(|text| serde_json::from_str::<Value>(text).ok())
    // rust: else {
    // rust: return Vec::new();
}
    // rust: let r = &r;
    // rust: let kind = r["type"].as_str().unwrap_or("");
    // rust: let item = |n: &str| sync.id("minecraft:item", n);
    // rust: let slot = |n: &str| sync.id("minecraft:slot_display", n).unwrap_or(0);
    // rust: let mut w = Writer::new();
    // rust: w.varint(ids.start);
        // The ingredients' TagSlotDisplays, an empty cell as an empty slot.
    // rust: let slots = |w: &mut Writer, cells: &[Option<&Value>]| {
    // rust: w.varint(cells.len() as i32);
    // rust: for cell in cells {
    // rust: match cell {
    // rust: Some(v) => {
    // rust: w.varint(slot("minecraft:tag"));
    // rust: holder_set(w, v, &item);
}
    // rust: None => w.varint(slot("minecraft:empty")),
}
}
}
        // The result as its ItemStackSlotDisplay, the station as its item.
    // rust: let result = |w: &mut Writer| {
    // rust: w.varint(slot("minecraft:item_stack"));
    // rust: w.varint(
    // rust: item(
    // rust: horizon_world::loot::recipe_result_id(&r["result"]).unwrap_or("minecraft:air"),
    // rust: )
    // rust: .unwrap_or(0),
    // rust: );
    // rust: w.varint(r["result"]["count"].as_i64().unwrap_or(1) as i32);
    // rust: w.varint(0);
    // rust: w.varint(0);
}
    // rust: let station = |w: &mut Writer, name: &str| {
    // rust: w.varint(slot("minecraft:item"));
    // rust: w.varint(item(name).unwrap_or(0));
}
        // The display, then the ingredients the craftable filter checks and
        // the category of the tab that lists it.
    // rust: let (category, placed): (&str, Vec<&Value>) = match kind {
    // rust: "minecraft:crafting_shaped" => {
    // rust: let pattern = shrink(r["pattern"].as_array().map_or(&[][..], |p| p));
    // rust: let (width, height) = (pattern.first().map_or(0, Vec::len), pattern.len());
    // rust: w.varint(sync.id("minecraft:recipe_display", kind).unwrap_or(0));
    // rust: w.varint(width as i32);
    // rust: w.varint(height as i32);
    // rust: let cells: Vec<Option<&Value>> = pattern
    // rust: .iter()
    // rust: .flatten()
    // rust: .map(|c| (*c != ' ').then(|| &r["key"][c.to_string()]))
    // rust: .collect();
    // rust: slots(&mut w, &cells);
    // rust: result(&mut w);
    // rust: station(&mut w, "minecraft:crafting_table");
    // rust: let placed = cells.iter().flatten().copied().collect();
    // rust: (
    // rust: crafting_category(r["category"].as_str().unwrap_or("")).name(),
    // rust: placed,
    // rust: )
}
    // rust: "minecraft:crafting_shapeless" => {
    // rust: w.varint(sync.id("minecraft:recipe_display", kind).unwrap_or(0));
    // rust: let cells: Vec<Option<&Value>> = r["ingredients"]
    // rust: .as_array()
    // rust: .map_or(Vec::new(), |a| a.iter().map(Some).collect());
    // rust: slots(&mut w, &cells);
    // rust: result(&mut w);
    // rust: station(&mut w, "minecraft:crafting_table");
    // rust: let placed = cells.iter().flatten().copied().collect();
    // rust: (
    // rust: crafting_category(r["category"].as_str().unwrap_or("")).name(),
    // rust: placed,
    // rust: )
}
            // AbstractCookingRecipe.display: the furnace, blast furnace,
            // smoker and campfire share one FurnaceRecipeDisplay; only the
            // station and the category differ.
    // rust: "minecraft:smelting"
    // rust: | "minecraft:blasting"
    // rust: | "minecraft:smoking"
    // rust: | "minecraft:campfire_cooking" => {
    // rust: w.varint(
    // rust: sync.id("minecraft:recipe_display", "minecraft:furnace")
    // rust: .unwrap_or(0),
    // rust: );
    // rust: w.varint(slot("minecraft:tag"));
    // rust: holder_set(&mut w, &r["ingredient"], &item);
    // rust: w.varint(slot("minecraft:any_fuel"));
    // rust: result(&mut w);
    // rust: station(&mut w, crafting_station(kind));
    // rust: w.varint(r["cookingtime"].as_i64().unwrap_or(0) as i32);
    // rust: w.f32(r["experience"].as_f64().unwrap_or(0.0) as f32);
    // rust: (cooking_category(kind, r), vec![&r["ingredient"]])
}
    // rust: _ => return Vec::new(),
}
        // The group, the recipe book category and the placement's ingredients.
    // rust: match r["group"].as_str().and_then(|g| self.groups.get(g)) {
    // rust: Some(g) => w.varint(g + 1),
    // rust: None => w.varint(0),
}
    // rust: let category = format!("minecraft:{category}");
    // rust: w.varint(
    // rust: sync.id("minecraft:recipe_book_category", &category)
    // rust: .unwrap_or(0),
    // rust: );
    // rust: w.bool(true);
    // rust: w.varint(placed.len() as i32);
    // rust: for v in placed {
    // rust: holder_set(&mut w, v, &item);
}
        // The notification only where the recipe shows one.
    // rust: let notify = r["show_notification"].as_bool().unwrap_or(true);
    // rust: w.i8(if notify { flags } else { flags & !1 });
    // rust: vec![w.data]
}
}

// ClientboundRecipeBookAddPacket.Entry flags: notification, highlight.
NOTIFY_AND_HIGHLIGHT :: 1 | 2

// ClientboundRecipeBookAddPacket: the entries, then whether they replace the book.
book_add :: proc(entries: [dynamic]Vec<u8>, replace: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(entries.len() as i32);
    // rust: for e in entries {
    // rust: w.data.extend(e);
}
    // rust: w.bool(replace);
    // rust: w.data
}

// `SmeltingRecipe.recipeBookCategory` and the other cooking recipes': the
// category of the station's book, from the recipe's `CookingBookCategory`.
cooking_category :: proc(kind: string, r: ^Value) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let category = match kind {
        // BlastingRecipe: a blocks tab, and one misc tab for the rest.
    // rust: "minecraft:blasting" => match r["category"].as_str() {
    // rust: Some("blocks") => Category::BlastBlocks,
    // rust: _ => Category::BlastMisc,
    // rust: },
    // rust: "minecraft:smoking" => Category::SmokerFood,
        // CampfireCookingRecipe: its own category, which no book's tab lists.
    // rust: "minecraft:campfire_cooking" => return "campfire",
        // SmeltingRecipe: blocks, food and misc, the default.
    // rust: _ => match r["category"].as_str() {
    // rust: Some("food") => Category::FurnaceFood,
    // rust: Some("blocks") => Category::FurnaceBlocks,
    // rust: _ => Category::FurnaceMisc,
    // rust: },
}
    // rust: category.name()
}

// ShapedRecipePattern.shrink: the pattern without blank border rows and columns.
shrink :: proc(rows: ^[Value]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let rows: Vec<Vec<char>> = rows
    // rust: .iter()
    // rust: .map(|r| r.as_str().unwrap_or("").chars().collect())
    // rust: .collect();
    // rust: let used = |r: &Vec<char>| r.iter().any(|c| *c != ' ');
    // rust: let (Some(top), Some(bottom)) = (rows.iter().position(used), rows.iter().rposition(used))
    // rust: else {
    // rust: return Vec::new();
}
    // rust: let rows = &rows[top..=bottom];
    // rust: let left = rows
    // rust: .iter()
    // rust: .filter_map(|r| r.iter().position(|c| *c != ' '))
    // rust: .min()
    // rust: .unwrap_or(0);
    // rust: let right = rows
    // rust: .iter()
    // rust: .filter_map(|r| r.iter().rposition(|c| *c != ' '))
    // rust: .max()
    // rust: .unwrap_or(0);
    // rust: rows.iter()
    // rust: .map(|r| {
    // rust: (left..=right)
    // rust: .map(|x| r.get(x).copied().unwrap_or(' '))
    // rust: .collect()
    // rust: })
    // rust: .collect()
}

// ByteBufCodecs.holderSet for an ingredient: a tag by name, or the items.
// An item the registries do not know is left out, not sent as id 0.
holder_set :: proc(w: ^Writer, v: ^Value, item: ^dyn Fn(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::String(s) if s.starts_with('#') => {
    // rust: w.varint(0);
    // rust: w.string(&s[1..]);
}
    // rust: Value::String(s) => match item(s) {
    // rust: Some(id) => {
    // rust: w.varint(2);
    // rust: w.varint(id);
}
    // rust: None => w.varint(1),
    // rust: },
    // rust: Value::Array(a) => {
    // rust: let ids: Vec<i32> = a.iter().filter_map(|s| item(s.as_str()?)).collect();
    // rust: w.varint(ids.len() as i32 + 1);
    // rust: for id in ids {
    // rust: w.varint(id);
}
}
    // rust: _ => w.varint(1),
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_protocol::{
    // rust: buf::Reader,
    // rust: item::Stack,
    // rust: packets::recipes::{HolderSet, RecipeBookEntry, RecipeDisplay, SlotDisplay},
}
//     use std::path::PathBuf;

    // The registries `book_entries` looks up, in the game's order
    // (`RecipeBookCategories` and the two display registries).
    // rust: const REGISTRIES: &str = r#"{
    // rust: "minecraft:item": {"entries": {
    // rust: "minecraft:raw_copper": {"protocol_id": 0},
    // rust: "minecraft:copper_ingot": {"protocol_id": 1},
    // rust: "minecraft:redstone_ore": {"protocol_id": 2},
    // rust: "minecraft:redstone": {"protocol_id": 3},
    // rust: "minecraft:furnace": {"protocol_id": 4},
    // rust: "minecraft:blast_furnace": {"protocol_id": 5}
    // rust: }},
    // rust: "minecraft:slot_display": {"entries": {
    // rust: "minecraft:empty": {"protocol_id": 0},
    // rust: "minecraft:any_fuel": {"protocol_id": 1},
    // rust: "minecraft:with_any_potion": {"protocol_id": 2},
    // rust: "minecraft:only_with_component": {"protocol_id": 3},
    // rust: "minecraft:item": {"protocol_id": 4},
    // rust: "minecraft:item_stack": {"protocol_id": 5},
    // rust: "minecraft:tag": {"protocol_id": 6},
    // rust: "minecraft:dyed": {"protocol_id": 7},
    // rust: "minecraft:smithing_trim": {"protocol_id": 8},
    // rust: "minecraft:with_remainder": {"protocol_id": 9},
    // rust: "minecraft:composite": {"protocol_id": 10}
    // rust: }},
    // rust: "minecraft:recipe_display": {"entries": {
    // rust: "minecraft:crafting_shapeless": {"protocol_id": 0},
    // rust: "minecraft:crafting_shaped": {"protocol_id": 1},
    // rust: "minecraft:furnace": {"protocol_id": 2},
    // rust: "minecraft:stonecutter": {"protocol_id": 3},
    // rust: "minecraft:smithing": {"protocol_id": 4}
    // rust: }},
    // rust: "minecraft:recipe_book_category": {"entries": {
    // rust: "minecraft:crafting_building_blocks": {"protocol_id": 0},
    // rust: "minecraft:crafting_redstone": {"protocol_id": 1},
    // rust: "minecraft:crafting_equipment": {"protocol_id": 2},
    // rust: "minecraft:crafting_misc": {"protocol_id": 3},
    // rust: "minecraft:furnace_food": {"protocol_id": 4},
    // rust: "minecraft:furnace_blocks": {"protocol_id": 5},
    // rust: "minecraft:furnace_misc": {"protocol_id": 6},
    // rust: "minecraft:blast_furnace_blocks": {"protocol_id": 7},
    // rust: "minecraft:blast_furnace_misc": {"protocol_id": 8},
    // rust: "minecraft:smoker_food": {"protocol_id": 9},
    // rust: "minecraft:stonecutter": {"protocol_id": 10},
    // rust: "minecraft:smithing": {"protocol_id": 11},
    // rust: "minecraft:campfire": {"protocol_id": 12}
    // rust: }}
    // rust: }"#;

    // A resources dir with those registries and the given recipe files.
resources :: proc(name: string, recipes: ^[(string) {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-recipe-book-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let dir = root.join("data/minecraft/recipe");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(root.join("registries.json"), REGISTRIES).unwrap();
    // rust: std::fs::write(root.join("items.json"), "{}").unwrap();
    // rust: for (id, json) in recipes {
    // rust: std::fs::write(dir.join(format!("{id}.json")), json).unwrap();
}
    // rust: root
}

    // The server's sync over `root`, and the one entry of `id` read back as
    // the client's `RecipeBookEntry::read` reads it.
entry :: proc(root: ^std::path::Path, id: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let sync = SyncData::load(root, &horizon_world::loot::PackOverlay::NONE).unwrap();
    // rust: let entries = sync
    // rust: .advancements
    // rust: .book_entries(id, &sync, NOTIFY_AND_HIGHLIGHT);
    // rust: assert_eq!(entries.len(), 1, "{id} has one display");
    // rust: let mut r = Reader::new(&entries[0]);
    // rust: let entry = RecipeBookEntry::read(&mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0, "the entry ends with its flags");
    // rust: (sync, entry)
}

    // A shaped recipe whose key uses one of NeoForge's ingredient shapes
    // reaches the client with the shape's items, not an empty list.
a_neoforge_ingredient_in_the_key_reaches_the_client_with_items :: proc() {
}
    // rust: let root = resources(
    // rust: "compound_key",
    // rust: &[(
    // rust: "compound_key",
    // rust: r#"{"type":"minecraft:crafting_shaped",
    // rust: "pattern":["X"],
    // rust: "key":{"X":{"type":"neoforge:compound","children":["minecraft:raw_copper","minecraft:redstone"]}},
    // rust: "result":{"id":"minecraft:copper_ingot"}}"#,
    // rust: )],
    // rust: );
    // rust: let (sync, e) = entry(&root, "minecraft:compound_key");
    // rust: let item = |n: &str| sync.id("minecraft:item", n).unwrap();
    // rust: let raw = item("minecraft:raw_copper");
    // rust: let redstone = item("minecraft:redstone");
    // rust: let req = e.requirements.as_ref().unwrap();
    // rust: assert_eq!(req.len(), 1, "one cell: {req:?}");
    // rust: match &req[0] {
    // rust: HolderSet::Items(items) => {
    // rust: assert!(
    // rust: items.contains(&raw) && items.contains(&redstone),
    // rust: "the compound's items: {items:?}"
    // rust: );
}
    // rust: other => panic!("not an item list: {other:?}"),
}
    // rust: let _ = std::fs::remove_dir_all(&root);
}

    // A recipe whose ingredient kind no loader knows stays out of the book:
    // the server does not load it, and an empty ingredient slot in its
    // place would mislead the client.
    // The shared probe: a recipe the player crafts is learned by the
    // name the crafting copy hands out, and rejoining sends what the
    // book knows.
crafted_recipe_reaches_the_book :: proc(name: string, pack: bool) {
}
    // rust: let shaped = r#"{"type":"minecraft:crafting_shaped","pattern":["X"],
    // rust: "key":{"X":"minecraft:raw_copper"},
    // rust: "result":{"id":"minecraft:copper_ingot"}}"#;
    // rust: let root = if pack {
    // rust: resources(name, &[])
    // rust: } else {
    // rust: resources(name, &[(name, shaped)])
}
    // rust: let packs = pack.then(|| {
    // rust: vec![(
    // rust: format!("recipe/minecraft:{name}"),
    // rust: vec![shaped.as_bytes().to_vec()],
    // rust: )]
    // rust: });
    // rust: let overlay = match &packs {
    // rust: Some(p) => horizon_world::loot::PackOverlay { files: p },
    // rust: None => horizon_world::loot::PackOverlay::NONE,
}
    // rust: let sync = SyncData::load(&root, &overlay).unwrap();
        // What the craft hands the book: find_with over the crafting
        // copy, the way award_crafted calls it.
    // rust: let items = crate::items::Items::catalog(&root, &overlay).unwrap();
    // rust: let recipes = crate::crafting::Recipes::load(&root, &items, &overlay).unwrap();
    // rust: let grid = vec![Some(horizon_items::items::ItemStack {
    // rust: item: "minecraft:raw_copper".into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: })];
    // rust: let (found, _) = recipes
    // rust: .find_with(&grid, 1, &|_| None)
    // rust: .unwrap_or_else(|| panic!("{name}: the recipe matches a grid"));
    // rust: assert_eq!(
    // rust: found, name,
    // rust: "{name}: the crafting copy names it bare, folder and pack alike"
    // rust: );
        // The book learns what the craft awards; rejoining sends it.
    // rust: let mut book = crate::recipe_book::Settings::default();
    // rust: let (_, unlocked) = book.add_recipes(&sync.advancements.displays, &[found.to_owned()]);
    // rust: assert_eq!(
    // rust: unlocked,
    // rust: [format!("minecraft:{name}")],
    // rust: "{name}: the book knows it under its whole id"
    // rust: );
    // rust: let bytes = sync.advancements.initial_recipe_book(&book, &sync);
    // rust: let mut r = Reader::new(&bytes);
    // rust: let add =
    // rust: <horizon_protocol::packets::recipes::RecipeBookAdd as horizon_protocol::buf::Codec<
    // rust: horizon_protocol::packets::recipes::RecipeBookAdd,
    // rust: >>::read(&mut r)
    // rust: .unwrap();
    // rust: assert!(
    // rust: !add.entries.is_empty(),
    // rust: "{name}: the crafted recipe reaches the book after rejoining"
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&root);
}

a_folder_recipe_unlocked_by_crafting_shows_in_the_book :: proc() {
}
    // rust: crafted_recipe_reaches_the_book("folder_recipe", false);
}

a_pack_recipe_unlocked_by_crafting_shows_in_the_book :: proc() {
}
    // rust: crafted_recipe_reaches_the_book("pack_recipe", true);
}

a_recipe_with_an_unknown_ingredient_kind_stays_out_of_the_book :: proc() {
}
    // rust: let root = resources(
    // rust: "mymod_kind",
    // rust: &[(
    // rust: "mymod_kind",
    // rust: r#"{"type":"minecraft:crafting_shaped",
    // rust: "pattern":["X"],
    // rust: "key":{"X":{"type":"mymod:x"}},
    // rust: "result":{"id":"minecraft:copper_ingot"}}"#,
    // rust: )],
    // rust: );
    // rust: let sync = SyncData::load(&root, &horizon_world::loot::PackOverlay::NONE).unwrap();
    // rust: assert!(
    // rust: !sync
    // rust: .advancements
    // rust: .recipes
    // rust: .contains_key("minecraft:mymod_kind"),
    // rust: "the network copy drops the recipe"
    // rust: );
    // rust: assert!(
    // rust: sync.advancements
    // rust: .book_entries("minecraft:mymod_kind", &sync, NOTIFY_AND_HIGHLIGHT)
    // rust: .is_empty()
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&root);
}

    // The property sets and the stonecutter read a NeoForge shape's items
    // too, not an empty slot: UpdateRecipes carries them.
update_recipes_sends_a_neoforge_shapes_items :: proc() {
}
    // rust: let root = resources(
    // rust: "compound_sets",
    // rust: &[
    // rust: (
    // rust: "compound_smelting",
    // rust: r#"{"type":"minecraft:smelting",
    // rust: "ingredient":{"type":"neoforge:compound","children":["minecraft:raw_copper","minecraft:redstone"]},
    // rust: "result":{"id":"minecraft:copper_ingot"}}"#,
    // rust: ),
    // rust: (
    // rust: "compound_stonecutting",
    // rust: r#"{"type":"minecraft:stonecutting",
    // rust: "ingredient":{"type":"neoforge:compound","children":["minecraft:raw_copper"]},
    // rust: "result":{"id":"minecraft:copper_ingot"}}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let sync = SyncData::load(&root, &horizon_world::loot::PackOverlay::NONE).unwrap();
    // rust: let item = |n: &str| sync.id("minecraft:item", n).unwrap();
    // rust: let raw = item("minecraft:raw_copper");
    // rust: let redstone = item("minecraft:redstone");
    // rust: let mut r = Reader::new(&sync.recipes);
        // The property sets, then the stonecutter's recipes.
    // rust: let mut furnace_input = None;
    // rust: for _ in 0..r.varint().unwrap() {
    // rust: let key = r.string(64).unwrap();
    // rust: let ids: Vec<i32> = (0..r.varint().unwrap())
    // rust: .filter_map(|_| r.varint().ok())
    // rust: .collect();
    // rust: if key == "minecraft:furnace_input" {
    // rust: furnace_input = Some(ids);
}
}
    // rust: let ids = furnace_input.expect("furnace_input set present");
    // rust: assert!(
    // rust: ids.contains(&raw) && ids.contains(&redstone),
    // rust: "the compound's items in furnace_input: {ids:?}"
    // rust: );
        // The stonecutter's entry: the compound's items, then the result.
    // rust: let stone = r.varint().unwrap();
    // rust: assert_eq!(stone, 1, "one stonecutting recipe");
    // rust: let len = r.varint().unwrap();
    // rust: assert!(len >= 2, "an item list, not empty ({len}) nor a tag");
    // rust: assert_eq!(len - 1, 1, "the compound's one item");
    // rust: assert_eq!(r.varint().unwrap(), raw);
    // rust: let _ = std::fs::remove_dir_all(&root);
}

    // The stonecutter's recipes go out in registration order (path, then
    // namespace): a guest's button picks by position in the host's list,
    // which keeps that order too.
update_recipes_lists_the_stonecutter_in_registration_order :: proc() {
}
    // rust: let cut = |input: &str| {
    // rust: format!(
    // rust: r#"{{"type":"minecraft:stonecutting","ingredient":"{input}",
    // rust: "result":{{"id":"minecraft:copper_ingot"}}}}"#
    // rust: )
}
    // rust: let vanilla = cut("minecraft:raw_copper");
    // rust: let root = resources("stonecutter_order", &[("z_cut", vanilla.as_str())]);
    // rust: let packs = [(
    // rust: "recipe/pack:a_cut".to_owned(),
    // rust: vec![cut("minecraft:redstone").into_bytes()],
    // rust: )];
    // rust: let sync =
    // rust: SyncData::load(&root, &horizon_world::loot::PackOverlay { files: &packs }).unwrap();
    // rust: let item = |n: &str| sync.id("minecraft:item", n).unwrap();
    // rust: let mut r = Reader::new(&sync.recipes);
    // rust: for _ in 0..r.varint().unwrap() {
    // rust: r.string(64).unwrap();
    // rust: for _ in 0..r.varint().unwrap() {
    // rust: r.varint().unwrap();
}
}
    // rust: let mut inputs = Vec::new();
    // rust: for _ in 0..r.varint().unwrap() {
            // An item list (its length plus one), then the result's slot
            // display: its type, item, count and two empty component lists.
    // rust: let len = r.varint().unwrap();
    // rust: inputs.push((1..len).map(|_| r.varint().unwrap()).collect::<Vec<_>>());
    // rust: for _ in 0..5 {
    // rust: r.varint().unwrap();
}
}
    // rust: assert_eq!(
    // rust: inputs,
    // rust: [
    // rust: vec![item("minecraft:redstone")],
    // rust: vec![item("minecraft:raw_copper")]
    // rust: ]
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&root);
}

    // `RecipeManager.getRecipeFromDisplay`, which
    // `handleRecipeBookSeenRecipePacket` asks: the display ids are numbered
    // over the recipes in id order, so display 0 is the first recipe and the
    // id past the last display names nothing.
a_display_id_names_the_recipe_it_was_numbered_for :: proc() {
}
    // rust: let root = resources(
    // rust: "seen_display",
    // rust: &[
    // rust: (
    // rust: "aaa_shaped",
    // rust: r#"{"type":"minecraft:crafting_shaped","pattern":["X"],
    // rust: "key":{"X":"minecraft:raw_copper"},
    // rust: "result":{"id":"minecraft:copper_ingot"}}"#,
    // rust: ),
    // rust: (
    // rust: "bbb_smelting",
    // rust: r#"{"type":"minecraft:smelting","cookingtime":200,"experience":0.7,
    // rust: "ingredient":"minecraft:raw_copper",
    // rust: "result":{"id":"minecraft:copper_ingot"}}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let sync = SyncData::load(&root, &horizon_world::loot::PackOverlay::NONE).unwrap();
    // rust: assert_eq!(
    // rust: sync.advancements.recipe_of_display(0),
    // rust: Some("minecraft:aaa_shaped")
    // rust: );
    // rust: assert_eq!(
    // rust: sync.advancements.recipe_of_display(1),
    // rust: Some("minecraft:bbb_smelting")
    // rust: );
    // rust: assert_eq!(
    // rust: sync.advancements.recipe_of_display(2),
    // rust: None,
    // rust: "past the last display"
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&root);
}

smelting_reaches_the_furnace_book :: proc() {
}
    // rust: let root = resources(
    // rust: "smelting",
    // rust: &[(
    // rust: "copper_ingot_from_smelting_raw_copper",
    // rust: r#"{"type":"minecraft:smelting","cookingtime":200,"experience":0.7,
    // rust: "group":"copper_ingot","ingredient":"minecraft:raw_copper",
    // rust: "result":{"id":"minecraft:copper_ingot"}}"#,
    // rust: )],
    // rust: );
    // rust: let (sync, e) = entry(&root, "minecraft:copper_ingot_from_smelting_raw_copper");
    // rust: let item = |n: &str| sync.id("minecraft:item", n).unwrap();
        // The fixture's only recipe: display ids are numbered over the sorted ids.
    // rust: assert_eq!(e.id, 0);
    // rust: assert_eq!(
    // rust: e.category,
    // rust: sync.id("minecraft:recipe_book_category", "minecraft:furnace_misc")
    // rust: .unwrap()
    // rust: );
    // rust: assert_eq!(e.group, 1, "copper_ingot is the first group");
    // rust: assert_eq!(e.flags, NOTIFY_AND_HIGHLIGHT);
    // rust: assert_eq!(
    // rust: e.requirements,
    // rust: Some(vec![HolderSet::Items(vec![item("minecraft:raw_copper")])])
    // rust: );
    // rust: let RecipeDisplay::Furnace {
    // rust: ingredient,
    // rust: fuel,
    // rust: result,
    // rust: station,
    // rust: duration,
    // rust: experience,
    // rust: } = e.display
    // rust: else {
    // rust: panic!("a smelting recipe shows a furnace display");
}
    // rust: assert_eq!(
    // rust: ingredient,
    // rust: SlotDisplay::Tag(HolderSet::Items(vec![item("minecraft:raw_copper")]))
    // rust: );
    // rust: assert_eq!(fuel, SlotDisplay::AnyFuel);
    // rust: assert_eq!(
    // rust: result,
    // rust: SlotDisplay::ItemStack(Stack::new(item("minecraft:copper_ingot"), 1))
    // rust: );
    // rust: assert_eq!(station, SlotDisplay::Item(item("minecraft:furnace")));
    // rust: assert_eq!(duration, 200);
    // rust: assert_eq!(experience, 0.7);
    // rust: let _ = std::fs::remove_dir_all(&root);
}

    // A recipe filter's `replace_input` (#5910) reaches the book swapped:
    // the book writes from the network copy, so the swap must have run
    // there, once, before the ingredient normalization. A world's pack
    // carries the filter (the way the game reads them).
a_recipe_filters_swapped_input_shows_swapped_in_the_book :: proc() {
}
    // rust: let root = resources(
    // rust: "filter_swap",
    // rust: &[(
    // rust: "copper_ingot_from_smelting_raw_copper",
    // rust: r#"{"type":"minecraft:smelting","cookingtime":200,"experience":0.7,
    // rust: "ingredient":"minecraft:raw_copper",
    // rust: "result":{"id":"minecraft:copper_ingot"}}"#,
    // rust: )],
    // rust: );
    // rust: let packs = vec![(
    // rust: "recipe_filter/minecraft:swap".to_owned(),
    // rust: vec![
    // rust: br#"{"filters":[{"id":"minecraft:copper_ingot_from_smelting_raw_copper",
    // rust: "replace_input":{"from":"minecraft:raw_copper","to":"minecraft:redstone"}}]}"#
    // rust: .to_vec(),
    // rust: ],
    // rust: )];
    // rust: let overlay = horizon_world::loot::PackOverlay { files: &packs };
    // rust: let sync = SyncData::load(&root, &overlay).unwrap();
    // rust: let entries = sync.advancements.book_entries(
    // rust: "minecraft:copper_ingot_from_smelting_raw_copper",
    // rust: &sync,
    // rust: NOTIFY_AND_HIGHLIGHT,
    // rust: );
    // rust: assert_eq!(entries.len(), 1, "the recipe has one display");
    // rust: let mut r = Reader::new(&entries[0]);
    // rust: let e = RecipeBookEntry::read(&mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0, "the entry ends with its flags");
    // rust: let item = |n: &str| sync.id("minecraft:item", n).unwrap();
    // rust: assert_eq!(
    // rust: e.requirements,
    // rust: Some(vec![HolderSet::Items(vec![item("minecraft:redstone")])]),
    // rust: "the filter's swapped input, not the file's"
    // rust: );
    // rust: let RecipeDisplay::Furnace { ingredient, .. } = e.display else {
    // rust: panic!("a smelting recipe shows a furnace display");
}
    // rust: assert_eq!(
    // rust: ingredient,
    // rust: SlotDisplay::Tag(HolderSet::Items(vec![item("minecraft:redstone")])),
    // rust: "the display shows the swapped input too"
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&root);
}

blasting_reaches_the_blast_furnace_book :: proc() {
}
    // rust: let root = resources(
    // rust: "blasting",
    // rust: &[(
    // rust: "redstone_from_blasting_redstone_ore",
    // rust: r#"{"type":"minecraft:blasting","category":"blocks","cookingtime":200,
    // rust: "experience":0.7,"group":"redstone",
    // rust: "ingredient":"minecraft:redstone_ore","result":{"id":"minecraft:redstone"}}"#,
    // rust: )],
    // rust: );
    // rust: let (sync, e) = entry(&root, "minecraft:redstone_from_blasting_redstone_ore");
    // rust: let item = |n: &str| sync.id("minecraft:item", n).unwrap();
    // rust: assert_eq!(e.id, 0);
    // rust: assert_eq!(
    // rust: e.category,
    // rust: sync.id(
    // rust: "minecraft:recipe_book_category",
    // rust: "minecraft:blast_furnace_blocks"
    // rust: )
    // rust: .unwrap()
    // rust: );
    // rust: let RecipeDisplay::Furnace {
    // rust: ingredient,
    // rust: station,
    // rust: duration,
    // rust: experience,
    // rust: ..
    // rust: } = e.display
    // rust: else {
    // rust: panic!("a blasting recipe shows a furnace display");
}
    // rust: assert_eq!(
    // rust: ingredient,
    // rust: SlotDisplay::Tag(HolderSet::Items(vec![item("minecraft:redstone_ore")]))
    // rust: );
    // rust: assert_eq!(station, SlotDisplay::Item(item("minecraft:blast_furnace")));
    // rust: assert_eq!(duration, 200);
    // rust: assert_eq!(experience, 0.7);
    // rust: let _ = std::fs::remove_dir_all(&root);
}
}
