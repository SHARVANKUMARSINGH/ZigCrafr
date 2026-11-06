//! Transpiled from Horizon Rust crate
package horizon_client_native_recipes

import "core:fmt"
import "core:mem"
import "core:math"

// Every item and recipe the game knows, made once for the mods that read
// them (native mods' `native_recipes`, capability `recipes` of WebAssembly
// mods, docs/mods.md), and the recipe book's known displays; placing a
// recipe and creative gifts. The recipes are the window's own data — the
// content root's — with the server's recipes of the types its native mods
// had it send (`horizon:recipe_content`) in their place, while the known
// displays follow the server's book as the recipe book does.
// use super::{
    // rust: Game,
    // rust: native_hooks::{
    // rust: NativeItem as RecipeItem, NativeRecipe as Recipe, NativeRecipeKind as RecipeKind,
    // rust: NativeRecipeStack as RecipeStack, NativeRecipes as Recipes,
    // rust: },
}
// use horizon_client::{
    // rust: crafting::{Ingredient, recipe_id},
    // rust: items::ItemStack,
    // rust: recipe_book::{Category, Display},
    // rust: stations::Smithing,
}
// use std::{collections::HashMap, sync::Arc};

// The tables, made once, and the recipe book's known displays with the
// book's version they are of.
// The most recipes a server's recipe content may carry.
MAX_SYNCED_RECIPES :: 1_000_000

    // rust: pub(super) struct RecipeTables {
    // rust: tables: Option<Arc<Recipes>>,
    // rust: pub(super) categories: Option<HashMap<String, horizon_client::recipe_book::RecipeBookCategory>>,
    // rust: known: (Option<u64>, Arc<[i32]>),
    // The server's recipes of the types its native mods sent (`horizon:
    // recipe_content`) over the window's own: what `Game::recipes` reads on
    // a client once they came.
    // rust: synced: Option<horizon_client::crafting::Recipes>,
    // The recipe content's parts so far, until its last.
    // rust: incoming: Vec<(String, serde_json::Value)>,
    // The types that came before the player did: the mods hear of them
    // once the helpers can answer (`recipes_received_now`).
    // rust: received: Option<Vec<String>>,
}

// Item id -> its index in [`Recipes::items`].
Index :: struct {
    // rust: impl Index {
stack :: proc(self: ^Self, item: string, count: u32, components: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(RecipeStack {
    item: *self.0.get(item)?,
    // rust: count,
    // rust: components,
    // rust: })
}
of :: proc(self: ^Self, s: ^ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.stack(&s.item, s.count, components(s))
}
any :: proc(self: ^Self, i: ^Ingredient) -> V {
    // Ported from Horizon
    return {}
}
    // rust: i.order
    // rust: .iter()
    // rust: .filter_map(|id| self.stack(id, 1, String::new()))
    // rust: .collect()
}
}

// A stack's components beyond its item's, as vanilla's item syntax writes
// them (`[minecraft:potion_contents={potion:"minecraft:swiftness"}]`), or "".
    // rust: pub(super) fn components(s: &ItemStack) -> String {
//     use horizon_world::nbt::Tag;
    // rust: let Some(Tag::Compound(entries)) = horizon_client::item_data::encode_components(s) else {
    // rust: return String::new();
}
    // rust: let parts: Vec<String> = entries
    // rust: .iter()
    // rust: .map(|(k, v)| {
    // rust: format!(
    // rust: "{}={}",
    // rust: k.to_string_lossy(),
    // rust: horizon_client::snbt::to_snbt(v)
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: format!("[{}]", parts.join(","))
}

recipe :: proc(id: string, kind: RecipeKind) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Recipe {
    // rust: id,
    // rust: kind,
    // rust: category: String::new(),
    // rust: group: String::new(),
    // rust: width: 0,
    // rust: height: 0,
    // rust: slots: Vec::new(),
    // rust: results: Vec::new(),
    // rust: cooking_time: 0,
    // rust: experience: 0.0,
    // rust: book_id: -1,
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn registered_recipe_book_category(
    // rust: &mut self,
    // rust: kind: &str,
    // rust: ) -> Option<horizon_client::recipe_book::RecipeBookCategory> {
    // rust: if self.recipe_tables.categories.is_none() {
    // rust: let mut declarations = Vec::new();
    // rust: self.native_recipe_book_categories(&mut declarations);
    // rust: self.recipe_tables.categories = Some(horizon_client::recipe_book::mod_categories(
    // rust: declarations,
    // rust: self.recipes(),
    // rust: self.items(),
    // rust: ));
}
    // rust: self.recipe_tables.categories.as_ref()?.get(kind).cloned()
}
    // `native_give`: `count` of `item`, refused outside a world, unless
    // creative and for an item the game doesn't have.
    // rust: pub(super) fn recipe_give(&mut self, item: &str, count: u32) -> Result<(), String> {
    // rust: if self.player.is_none() || self.res.rest.get().is_none() {
    // rust: return Err("not in a world".into());
}
    // rust: if !self.creative {
    // rust: return Err("only in creative mode".into());
}
    // rust: if self.res.items().get(item).is_none() {
    // rust: return Err(format!("no item {item}"));
}
    // rust: self.mod_give(item, count.clamp(1, 99), "");
    // rust: Ok(())
}
    // `native_place_recipe`: refused as `recipes.place` refuses it.
    // rust: pub(super) fn recipe_place(&mut self, book_id: i32, all: bool) -> Result<(), String> {
    // rust: if !self.mod_recipe_screen() {
    // rust: return Err("no screen that takes recipes is open".into());
}
    // rust: if !self.known_displays().contains(&book_id) {
    // rust: return Err(format!(
    // rust: "recipe {book_id} is not in the player's recipe book"
    // rust: ));
}
    // rust: self.mod_place_recipe(book_id, all);
    // rust: Ok(())
}
    // `recipes.give`: a creative player takes the stack as from the
    // creative inventory; a server hears it as `SetCreativeModeSlot`
    // through the inventory's sync, and refuses it unless creative.
    // rust: pub(super) fn mod_give(&mut self, item: &str, count: u32, components: &str) {
    // rust: let Some(max) = self.items().get(item).map(|i| i.max_stack) else {
    // rust: return;
}
    // rust: if !self.creative {
    // rust: return;
}
    // rust: let (damage, extra) = horizon_client::item_data::command_components(components)
    // rust: .map_or((0, None), |tag| {
    // rust: horizon_client::item_data::decode_components(Some(&tag))
    // rust: });
    // rust: let _ = self.give(ItemStack {
    // rust: item: item.into(),
            // One stack at most, as the creative inventory hands out.
    // rust: count: count.min(max),
    // rust: damage,
    // rust: extra,
    // rust: });
}
    // The tables, made on the first call; none while the world resources
    // they come from are still loading behind the title on a slow start.
    // rust: pub(super) fn made_recipes(&mut self) -> Option<Arc<Recipes>> {
    // rust: self.res.rest.get()?;
    // rust: if self.recipe_tables.tables.is_none() {
    // rust: self.recipe_tables.tables = Some(Arc::new(self.make_mod_recipes()));
}
    // rust: self.recipe_tables.tables.clone()
}
    // The `book_id`s the player's recipe book holds now.
    // rust: pub(super) fn known_displays(&mut self) -> Arc<[i32]> {
    // rust: if self.res.rest.get().is_none() {
    // rust: return Arc::from([]);
}
    // rust: let (version, known) = self.recipe_book_displays();
    // rust: if self.recipe_tables.known.0 != Some(version) {
    // rust: self.recipe_tables.known = (Some(version), known.into());
}
    // rust: self.recipe_tables.known.1.clone()
}

make_mod_recipes :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let names = &self.pack.names;
    // rust: let items = self.items();
    // rust: let mut tags: HashMap<&str, Vec<String>> = HashMap::new();
    // rust: for (tag, members) in &items.item_tags {
    // rust: for m in members {
    // rust: tags.entry(m).or_default().push(tag.clone());
}
}
    // rust: let table: Vec<RecipeItem> = items
    // rust: .registry_order
    // rust: .iter()
    // rust: .map(|id| RecipeItem {
    // rust: id: id.to_string(),
    // rust: name: names.display_item(id),
    // rust: tags: tags.remove(&**id).map_or_else(Vec::new, |mut t| {
    // rust: t.sort();
    // rust: t
    // rust: }),
    // rust: })
    // rust: .collect();
    // rust: let index = Index(
    // rust: items
    // rust: .registry_order
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, id)| (id.clone(), i as u32))
    // rust: .collect(),
    // rust: );
    // rust: let mut out = Vec::new();
    // rust: let cooking: HashMap<String, (u32, f32)> = self
    // rust: .recipes()
    // rust: .cooking
    // rust: .iter()
    // rust: .map(|c| (recipe_id(&c.id), (c.time, c.experience)))
    // rust: .collect();
    // rust: for e in self.recipe_book_entries() {
    // rust: let furnace = |c: Category| match c.name().split('_').next() {
    // rust: Some("blast") => RecipeKind::Blasting,
    // rust: Some("smoker") => RecipeKind::Smoking,
    // rust: _ => RecipeKind::Smelting,
}
    // rust: let kind = match &e.display {
    // rust: Display::Shaped { .. } => RecipeKind::CraftingShaped,
    // rust: Display::Shapeless(_) => RecipeKind::CraftingShapeless,
    // rust: Display::Furnace(_) => furnace(e.category),
}
    // rust: let mut r = recipe(e.id.clone(), kind);
    // rust: r.category = e.category.name().to_owned();
    // rust: r.group = e.group.clone().unwrap_or_default();
    // rust: r.book_id = e.display_id;
    // rust: r.slots = match &e.display {
    // rust: Display::Shaped {
    // rust: width,
    // rust: height,
    // rust: cells,
    // rust: } => {
    // rust: (r.width, r.height) = (*width as u32, *height as u32);
    // rust: cells
    // rust: .iter()
    // rust: .map(|c| c.as_ref().map_or_else(Vec::new, |i| index.any(i)))
    // rust: .collect()
}
    // rust: Display::Shapeless(list) => list.iter().map(|i| index.any(i)).collect(),
    // rust: Display::Furnace(i) => vec![index.any(i)],
}
            // Requirements shown as other stacks (an arrow's potions): the
            // requirement's index counts the filled slots only.
    // rust: let filled: Vec<usize> = (0..r.slots.len())
    // rust: .filter(
    // rust: |&k| !matches!(&e.display, Display::Shaped { cells, .. } if cells[k].is_none()),
    // rust: )
    // rust: .collect();
    // rust: for (req, stacks) in &e.stacks {
    // rust: if let Some(&k) = filled.get(*req) {
    // rust: r.slots[k] = stacks.iter().filter_map(|s| index.of(s)).collect();
}
}
    // rust: r.results = e.results().iter().filter_map(|s| index.of(s)).collect();
    // rust: if let Some(&(time, xp)) = cooking.get(&e.id) {
    // rust: (r.cooking_time, r.experience) = (time, xp);
}
    // rust: out.push(r);
}
    // rust: for c in &self.recipes().cooking {
    // rust: if c.kind == "minecraft:campfire_cooking" {
    // rust: let mut r = recipe(recipe_id(&c.id), RecipeKind::Campfire);
    // rust: r.group = c.group.clone();
    // rust: r.slots = vec![index.any(&c.ingredient)];
    // rust: r.results = index.of(&c.result).into_iter().collect();
    // rust: (r.cooking_time, r.experience) = (c.time, c.experience);
    // rust: out.push(r);
}
}
    // rust: let stations = self.stations();
    // rust: for s in &stations.recipes.stonecutting {
    // rust: let mut r = recipe(s.id.clone(), RecipeKind::Stonecutting);
    // rust: r.slots = vec![index.any(&s.input)];
    // rust: r.results = index.of(&s.result).into_iter().collect();
    // rust: out.push(r);
}
    // rust: for s in &stations.recipes.smithing {
    // rust: let (id, template, base, addition, results) = match s {
    // rust: Smithing::Transform {
    // rust: id,
    // rust: template,
    // rust: base,
    // rust: addition,
    // rust: result,
    // rust: } => (
    // rust: id,
    // rust: template,
    // rust: base,
    // rust: addition,
    // rust: index.stack(result, 1, String::new()).into_iter().collect(),
    // rust: ),
    // rust: Smithing::Trim {
    // rust: id,
    // rust: template,
    // rust: base,
    // rust: addition,
    // rust: ..
    // rust: } => (id, template, base, addition, index.any(base)),
}
    // rust: let mut r = recipe(id.clone(), RecipeKind::Smithing);
    // rust: r.slots = vec![index.any(template), index.any(base), index.any(addition)];
    // rust: r.results = results;
    // rust: out.push(r);
}
    // rust: for b in &stations.brewing.recipes {
    // rust: let potion = |p: &horizon_client::brewing::PotionIngredient| -> Vec<RecipeStack> {
    // rust: let mut item_ids: Vec<&String> = p.items.iter().collect();
    // rust: item_ids.sort();
    // rust: let mut potions: Vec<&String> = p.potions.iter().flatten().collect();
    // rust: potions.sort();
    // rust: item_ids
    // rust: .into_iter()
    // rust: .flat_map(|item| {
    // rust: let one = |c: String| index.stack(item, 1, c);
    // rust: if potions.is_empty() {
    // rust: one(String::new()).into_iter().collect::<Vec<_>>()
    // rust: } else {
    // rust: potions
    // rust: .iter()
    // rust: .filter_map(|p| {
    // rust: one(format!("[minecraft:potion_contents={{potion:\"{p}\"}}]"))
    // rust: })
    // rust: .collect()
}
    // rust: })
    // rust: .collect()
}
    // rust: let mut r = recipe(b.id.clone(), RecipeKind::Brewing);
    // rust: r.slots = vec![potion(&b.input), potion(&b.reagent)];
    // rust: r.results = index.of(&b.output).into_iter().collect();
    // rust: out.push(r);
}
    // rust: Recipes {
    // rust: items: table,
    // rust: recipes: out,
}
}
}

    // rust: impl Game<'_> {
    // The server's recipes a client was sent, over its own; None on a
    // server and until a server sends any.
    // rust: pub(super) fn synced_recipes(&self) -> Option<&horizon_client::crafting::Recipes> {
    // rust: self.recipe_tables.synced.as_ref()
}
    // A new play session (`Login`): what the last server sent is gone.
    // rust: pub(super) fn forget_synced_recipes(&mut self) {
    // rust: self.recipe_tables.synced = None;
    // rust: self.recipe_tables.incoming.clear();
    // rust: self.recipe_tables.received = None;
    // rust: self.recipe_tables.tables = None;
    // rust: self.forget_book();
}
    // `native_recipes_received` for the types that came, once the window
    // has its player: the recipes of a join come before it, and the helpers
    // answer nothing until then. Once a frame.
    // rust: pub(super) fn recipes_received_now(&mut self) {
    // rust: if self.player.is_some()
    // rust: && let Some(types) = self.recipe_tables.received.take()
    // rust: {
    // rust: self.native_recipes_received(&types);
}
}
    // `OnDatapackSyncEvent.sendRecipes`: the recipe types the native mods
    // want their clients to have, from this load's tables, become what the
    // server sends its Horizon clients at a join and after `/reload`. Called
    // once a load's tables are built, before any player hears of them.
    // rust: pub(super) fn sync_recipe_content(&mut self) {
//         use horizon_client::lan::recipes;
    // rust: let mut types = Vec::new();
    // rust: self.native_datapack_sync(&mut types);
    // rust: types.sort();
    // rust: types.dedup();
    // rust: let sources = if types.is_empty() {
    // rust: Vec::new()
    // rust: } else {
    // rust: horizon_client::crafting::Recipes::sources(&self.options.resources, &self.pack_files())
    // rust: .unwrap_or_else(|e| {
    // rust: log::warn!("Horizon: the recipes for the clients were not read: {e}");
    // rust: Vec::new()
    // rust: })
}
    // rust: recipes::set_content(recipes::encode_content(
    // rust: &types,
    // rust: &sources,
    // rust: recipes::sent_before(),
    // rust: ));
}
    // A `horizon:recipe_content` part the server sent the window. On the
    // last, the window's tables take the server's recipes of those types in
    // place of its own, and the mods hear of it (`RecipesReceivedEvent`).
    // rust: pub(super) fn remote_recipe_content(&mut self, data: &[u8]) {
    // rust: let part: horizon_client::lan::recipes::ContentPart = match serde_json::from_slice(data) {
    // rust: Ok(part) => part,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: bad recipe content from the server: {e}");
    // rust: return;
}
}
    // rust: self.recipe_tables.incoming.extend(part.recipes);
        // The server is trusted to end its parts; one that never does is
        // dropped, not kept growing.
    // rust: if self.recipe_tables.incoming.len() > MAX_SYNCED_RECIPES {
    // rust: log::warn!("Horizon: the server sent more than {MAX_SYNCED_RECIPES} recipes; dropped");
    // rust: self.recipe_tables.incoming = Vec::new();
    // rust: return;
}
    // rust: let Some(types) = part.last else {
    // rust: return;
}
    // rust: let received = std::mem::take(&mut self.recipe_tables.incoming);
        // No type any more: back on the window's own recipes.
    // rust: if types.is_empty() {
    // rust: if self.recipe_tables.synced.take().is_some() {
    // rust: self.recipe_tables.tables = None;
    // rust: self.forget_book();
    // rust: self.recipe_tables.received = Some(types);
    // rust: self.recipes_received_now();
}
    // rust: return;
}
    // rust: let root = &self.options.resources;
    // rust: let overlay = horizon_world::loot::PackOverlay::NONE;
    // rust: let built = horizon_client::crafting::Recipes::sources(root, &overlay).and_then(|own| {
    // rust: let of = |v: &serde_json::Value| types.iter().any(|t| v["type"].as_str() == Some(t));
    // rust: let mut all: Vec<_> = own.into_iter().filter(|(_, v)| !of(v)).collect();
    // rust: all.extend(received);
    // rust: horizon_client::crafting::Recipes::from_sources(root, self.items(), &overlay, all)
    // rust: });
    // rust: match built {
    // rust: Ok(recipes) => {
    // rust: self.recipe_tables.synced = Some(recipes);
                // What was made of the window's own recipes is made again.
    // rust: self.recipe_tables.tables = None;
    // rust: self.forget_book();
    // rust: self.recipe_tables.received = Some(types);
    // rust: self.recipes_received_now();
}
    // rust: Err(e) => log::warn!("Horizon: the server's recipes were not taken: {e}"),
}
}
}
