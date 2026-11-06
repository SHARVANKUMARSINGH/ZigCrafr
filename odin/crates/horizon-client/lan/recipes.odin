//! Transpiled from Horizon Rust crate
package horizon_client_recipes

import "core:fmt"
import "core:mem"
import "core:math"

// ClientboundUpdateRecipesPacket: what RecipeManager.finalizeRecipeLoading
// synchronizes, the recipe property sets (the items each furnace, smithing
// table slot and brewing stand slot accepts) and the stonecutter's recipes,
// read from the data pack's recipe files.
// use super::data::SyncData;
// use horizon_protocol::buf::Writer;
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet, HashMap},
    // rust: path::Path,
    // rust: sync::{Arc, Mutex},
}

// RecipeManager.RECIPE_PROPERTY_SETS: each set and the ingredients it takes
// from a recipe of the given type.
    // rust: const PROPERTY_SETS: &[(&str, &str, &[&str])] = &[
    // rust: ("smithing_addition", "smithing", &["addition"]),
    // rust: ("smithing_base", "smithing", &["base"]),
    // rust: ("smithing_template", "smithing", &["template"]),
    // rust: ("furnace_input", "minecraft:smelting", &["ingredient"]),
    // rust: ("blast_furnace_input", "minecraft:blasting", &["ingredient"]),
    // rust: ("smoker_input", "minecraft:smoking", &["ingredient"]),
    // rust: (
    // rust: "campfire_input",
    // rust: "minecraft:campfire_cooking",
    // rust: &["ingredient"],
    // rust: ),
    // rust: ("brewing_input", "minecraft:brewing", &["input"]),
    // rust: ("brewing_reagent", "minecraft:brewing", &["reagent"]),
    // rust: ];

// An ingredient as its HolderSet: a tag, or the items listed.
Ingredient :: enum {
    Tag(String),
    Items(Vec<String>),
}

ingredient :: proc(v: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::String(s) => Some(match s.strip_prefix('#') {
    // rust: Some(tag) => Ingredient::Tag(tag.to_owned()),
    // rust: None => Ingredient::Items(vec![s.clone()]),
    // rust: }),
    // rust: Value::Array(a) => Some(Ingredient::Items(
    // rust: a.iter()
    // rust: .filter_map(|s| s.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: )),
        // A brewing slot: the item predicate's `item` ingredient.
    // rust: Value::Object(o) => ingredient(o.get("item")?),
    // rust: _ => None,
}
}

// Every recipe file, by recipe id (the registry's order): read through
// `json_folder`, so a load holding the folder shares one read of it. A file
// that can't be read or doesn't parse is left out.
    // rust: pub(super) fn recipes(dir: &Path, out: &mut BTreeMap<String, Value>) {
    // rust: let Ok(folder) = horizon_world::json_folder::read(dir) else {
    // rust: return;
}
    // rust: for file in &folder.files {
    // rust: if let Ok(v) = serde_json::from_slice(file.bytes().unwrap_or_default()) {
    // rust: out.insert(format!("minecraft:{}", file.name), v);
}
}
}

// The recipes by id in vanilla's registration order (path, then namespace),
// the order `RecipeManager` numbers groups and lists the stonecutter's
// recipes in, and so the order the host's own tables keep.
    // rust: fn registration_order<V>(all: &BTreeMap<String, V>) -> Vec<&V> {
    // rust: let mut ordered: Vec<_> = all.iter().collect();
    // rust: ordered.sort_by_cached_key(|(id, _)| horizon_client::crafting::registration_key(id));
    // rust: ordered.into_iter().map(|(_, v)| v).collect()
}

// The packs' recipe files over the game's own: the top pack's file for
// each id (`SimpleJsonResourceReloadListener`).
    // rust: pub(super) fn overlay_recipes(
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: out: &mut BTreeMap<String, Value>,
    // rust: ) {
    // rust: for (id, files) in overlay.kind("recipe") {
    // rust: if let Ok(v) = serde_json::from_slice::<Value>(horizon_world::loot::PackOverlay::top(files))
    // rust: {
    // rust: out.insert(id.to_owned(), v);
}
}
}

// The network copy's recipes: every recipe file and overlay recipe, each
// ingredient object — NeoForge's shapes, a brewing slot's item predicate —
// replaced by the flat item list the crafting copy resolves it to. The
// crafting copy resolves these shapes where it loads them; this copy reads
// the files again, and `holder_set` writes any object it meets as an empty
// list. A recipe that keeps an object the loader cannot parse (a mod's own
// ingredient kind) is left out: the server does not load it, and an empty
// ingredient in its place misleads the client.
    // rust: pub(super) fn network_recipes(
    // rust: resources: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: ) -> (BTreeMap<String, Box<str>>, HashMap<String, i32>) {
    // rust: let mut all = BTreeMap::new();
    // rust: recipes(&resources.join("data/minecraft/recipe"), &mut all);
    // rust: overlay_recipes(overlay, &mut all);
    // The data's recipe filters, as the server's own tables apply them
    // (#5910), once, before the ingredient normalization, so a swapped
    // name resolves and every copy — the book's displays, the property
    // sets — agrees on the swapped recipe.
    // rust: let filters = horizon_items::recipe_filters::RecipeFilters::load(resources, overlay);
    // rust: all.retain(|id, r| filters.apply(id, r));
    // rust: match horizon_client::items::Items::catalog(resources, overlay) {
    // rust: Ok(items) => all.retain(|_, r| normalize_ingredients(r, &items)),
    // rust: Err(e) => log::warn!("recipes: NeoForge's ingredient shapes stay unresolved: {e}"),
}
    // RecipeManager.unpackRecipeInfo's group numbers, while the files are
    // still parsed.
    // rust: let mut groups = HashMap::new();
    // rust: for r in registration_order(&all) {
    // rust: if let Some(g) = r["group"].as_str().filter(|g| !g.is_empty()) {
    // rust: let next = groups.len() as i32;
    // rust: groups.entry(g.to_owned()).or_insert(next);
}
}
    // Each file as its compact JSON text: a book entry parses the one it
    // needs, and the parsed files would keep about 5 MB alive for the
    // server's whole run.
    // rust: let all = all
    // rust: .into_iter()
    // rust: .map(|(id, r)| (id, r.to_string().into_boxed_str()))
    // rust: .collect();
    // rust: (all, groups)
}

// An ingredient object's flat item list: the shape NeoForge's standard
// kinds resolve to, or a brewing predicate's `item`. `None`: the object is
// a kind the loader does not know, a mod's own.
flat :: proc(ing: ^Value, items: ^horizon_client::items::Items) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !ing.is_object() {
    // rust: return None;
}
    // rust: let parsed = horizon_client::crafting::Ingredient::parse(ing, items).or_else(|| {
        // A brewing slot's item predicate: its `ingredient`, as the
        // property sets have always read it.
    // rust: ing.get("item")
    // rust: .and_then(|v| horizon_client::crafting::Ingredient::parse(v, items))
    // rust: })?;
    // rust: Some(Value::Array(
    // rust: parsed
    // rust: .order
    // rust: .iter()
    // rust: .map(|i| Value::String(i.clone()))
    // rust: .collect(),
    // rust: ))
}

// Replace each of a recipe's ingredient objects with its flat item list,
// so `holder_set` writes the items instead of an empty list. `false`: the
// recipe keeps an object the loader cannot parse.
normalize_ingredients :: proc(r: ^Value, items: ^horizon_client::items::Items) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let known = r["type"]
    // rust: .as_str()
    // rust: .is_some_and(|t| t.starts_with("minecraft:"));
    // rust: if !known {
    // rust: return true;
}
    // rust: let mut parsed = true;
    // The shaped recipe's key: a map of symbols to ingredients.
    // rust: if let Some(map) = r.get_mut("key").and_then(|k| k.as_object_mut()) {
    // rust: for ing in map.values_mut() {
    // rust: if let Some(replacement) = flat(ing, items) {
    // rust: *ing = replacement;
    // rust: } else if ing.is_object() {
    // rust: parsed = false;
}
}
}
    // The list and single-ingredient keys, the smithing trio, the brewing
    // pair.
    // rust: for key in [
    // rust: "ingredients",
    // rust: "ingredient",
    // rust: "base",
    // rust: "addition",
    // rust: "template",
    // rust: "input",
    // rust: "reagent",
    // rust: ] {
    // rust: let Some(ing) = r.get_mut(key) else { continue };
    // rust: if let Some(replacement) = flat(ing, items) {
    // rust: *ing = replacement;
    // rust: continue;
}
    // rust: if let Value::Array(a) = ing {
    // rust: for entry in a.iter_mut() {
    // rust: if let Some(replacement) = flat(entry, items) {
    // rust: *entry = replacement;
    // rust: } else if entry.is_object() {
    // rust: parsed = false;
}
}
    // rust: } else if ing.is_object() {
    // rust: parsed = false;
}
}
    // rust: parsed
}

// The packet's payload for the network copy's recipes (`network_recipes`).
update_recipes :: proc(all: ^BTreeMap<string, sync: ^SyncData) -> V {
    // Ported from Horizon
    return {}
}
    // The copy is already filtered and swapped (`network_recipes`); the
    // filters never run twice, so one swap cannot feed a later one again.
    // Parsing every recipe takes about a millisecond.
    // rust: let chosen: Vec<Value> = registration_order(all)
    // rust: .into_iter()
    // rust: .filter_map(|text| serde_json::from_str::<Value>(text).ok())
    // rust: .collect();
    // rust: let tags: BTreeMap<&str, &[i32]> = sync
    // rust: .tags
    // rust: .registries
    // rust: .iter()
    // rust: .filter(|r| r.registry == "minecraft:item")
    // rust: .flat_map(|r| r.tags.iter())
    // rust: .map(|t| (t.name.trim_start_matches("minecraft:"), t.ids.as_slice()))
    // rust: .collect();
    // An item the registries do not know is left out, not sent as id 0.
    // rust: let item = |name: &str| sync.id("minecraft:item", name);
    // rust: let items = |i: &Ingredient| -> Vec<i32> {
    // rust: match i {
    // rust: Ingredient::Tag(t) => tags
    // rust: .get(t.trim_start_matches("minecraft:"))
    // rust: .map(|ids| ids.to_vec())
    // rust: .unwrap_or_default(),
    // rust: Ingredient::Items(list) => list.iter().filter_map(|n| item(n)).collect(),
}
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(PROPERTY_SETS.len() as i32);
    // rust: for (key, kind, fields) in PROPERTY_SETS {
    // rust: let mut set = BTreeSet::new();
    // rust: for recipe in &chosen {
    // rust: let t = recipe["type"].as_str().unwrap_or("");
    // rust: let matches = if *kind == "smithing" {
    // rust: t.starts_with("minecraft:smithing_")
    // rust: } else {
    // rust: t == *kind
}
    // rust: if matches {
    // rust: for field in *fields {
    // rust: if let Some(i) = ingredient(&recipe[*field]) {
    // rust: set.extend(items(&i));
}
}
}
}
    // rust: w.string(&format!("minecraft:{key}"));
    // rust: w.varint(set.len() as i32);
    // rust: for id in set {
    // rust: w.varint(id);
}
}
    // SelectableRecipe.SingleInputSet: each stonecutting recipe's input and
    // its result as an ItemStackSlotDisplay.
    // rust: let stonecutting: Vec<&Value> = chosen
    // rust: .iter()
    // rust: .filter(|r| r["type"] == "minecraft:stonecutting")
    // rust: .collect();
    // rust: let item_stack = sync
    // rust: .id("minecraft:slot_display", "minecraft:item_stack")
    // rust: .unwrap_or(0);
    // rust: w.varint(stonecutting.len() as i32);
    // rust: for r in stonecutting {
    // rust: match ingredient(&r["ingredient"]) {
    // rust: Some(Ingredient::Tag(t)) => {
    // rust: w.varint(0);
    // rust: w.string(&t);
}
    // rust: Some(i) => {
    // rust: let ids = items(&i);
    // rust: w.varint(ids.len() as i32 + 1);
    // rust: for id in ids {
    // rust: w.varint(id);
}
}
    // rust: None => w.varint(1),
}
    // rust: w.varint(item_stack);
    // rust: w.varint(
    // rust: item(horizon_world::loot::recipe_result_id(&r["result"]).unwrap_or("minecraft:air"))
    // rust: .unwrap_or(0),
    // rust: );
    // rust: w.varint(r["result"]["count"].as_i64().unwrap_or(1) as i32);
    // rust: w.varint(0); // no components added
    // rust: w.varint(0); // nor removed
}
    // rust: w.data
}

// The Horizon channel a server sends its clients the recipes its native mods
// asked for (`native_datapack_sync`), NeoForge's
// `OnDatapackSyncEvent.sendRecipes`. Horizon clients only.
CONTENT_CHANNEL :: "horizon:recipe_content"
// `ClientboundCustomPayloadPacket`'s cap on a payload, less room for the
// envelope.
CONTENT_MAX :: 1_048_576 - 1024

// One payload of the recipe content: some recipes as `(id, json)`, and on the
// last one the recipe types they replace on the client (a type the server has
// no recipe of still empties the client's).
ContentPart :: struct {
    recipes: Vec<(string,
    last: Maybe([dynamic]string),
}

// The payloads for `types`' recipes among `sources` (`Recipes::sources`,
// vanilla's ids bare), ids made whole (`minecraft:<name>`). With no type
// asked for: nothing, or with `reset` (this server sent recipes before) one
// last part with no types, which puts its clients back on their own. A
// recipe too big for a payload of its own is left out.
encode_content :: proc(types: ^[string], sources: ^[(string) {
}
    // The last part carries the types: they count against its cap too.
    // rust: let types_len = serde_json::to_string(types).map_or(0, |t| t.len()) + 32;
    // rust: if types_len > CONTENT_MAX {
    // rust: log::warn!("Horizon: too many recipe types to send to clients");
    // rust: return Vec::new();
}
    // rust: if types.is_empty() && !reset {
    // rust: return Vec::new();
}
    // rust: let mut out = Vec::new();
    // rust: let mut part: Vec<(String, Value)> = Vec::new();
    // rust: let mut size = 0;
    // rust: for (name, v) in sources {
    // rust: if !types.iter().any(|t| v["type"].as_str() == Some(t)) {
    // rust: continue;
}
    // rust: let id = if name.contains(':') {
    // rust: name.clone()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
    // rust: let len = id.len() + v.to_string().len() + 8;
    // rust: if len > CONTENT_MAX {
    // rust: log::warn!("Horizon: recipe {id} is too big to send to clients");
    // rust: continue;
}
    // rust: if size + len > CONTENT_MAX {
    // rust: let recipes = std::mem::take(&mut part);
    // rust: out.push(
    // rust: serde_json::to_vec(&ContentPart {
    // rust: recipes,
    // rust: last: None,
    // rust: })
    // rust: .unwrap_or_default(),
    // rust: );
    // rust: size = 0;
}
    // rust: size += len;
    // rust: part.push((id, v.clone()));
}
    // rust: if size + types_len > CONTENT_MAX {
    // rust: let recipes = std::mem::take(&mut part);
    // rust: out.push(
    // rust: serde_json::to_vec(&ContentPart {
    // rust: recipes,
    // rust: last: None,
    // rust: })
    // rust: .unwrap_or_default(),
    // rust: );
}
    // rust: let last = ContentPart {
    // rust: recipes: part,
    // rust: last: Some(types.to_vec()),
}
    // rust: out.push(serde_json::to_vec(&last).unwrap_or_default());
    // rust: out
}

// What the server sends its Horizon clients now (`set_content`).
CONTENT :: Mutex::new(None)

// The recipe content the server sends from now on, at a join and after a
// `/reload` (one server per process, as `lan::sync_data`).
set_content :: proc(payloads: [dynamic]Vec<u8>) {
}
    // rust: if !payloads.is_empty() {
    // rust: SENT.store(true, std::sync::atomic::Ordering::Relaxed);
}
    // rust: *CONTENT.lock().unwrap_or_else(|e| e.into_inner()) = Some(Arc::new(payloads));
}

// Whether this server sent its clients recipes before: a later load that
// asks for none must put them back on their own (`encode_content`'s reset).
SENT :: std::sync::atomic::AtomicBool::new(false)

sent_before :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: SENT.load(std::sync::atomic::Ordering::Relaxed)
}

// The payloads to send a Horizon client; none when no mod asked.
content :: proc() -> A {
    // Ported from Horizon
    return {}
}
    // rust: CONTENT
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .clone()
    // rust: .unwrap_or_default()
}

    // rust: mod content_tests {
//     use super::*;
//     use serde_json::json;

content_keeps_the_asked_types_and_ends_with_them :: proc() {
}
    // rust: let sources = vec![
    // rust: ("furnace".to_owned(), json!({"type": "minecraft:smelting"})),
    // rust: (
    // rust: "stick".to_owned(),
    // rust: json!({"type": "minecraft:crafting_shaped"}),
    // rust: ),
    // rust: ("mymod:crush".to_owned(), json!({"type": "mymod:crusher"})),
    // rust: ];
    // rust: assert!(encode_content(&[], &sources, false).is_empty());
        // After a sync that sent recipes, asking for none sends an empty last part.
    // rust: let reset = encode_content(&[], &sources, true);
    // rust: assert_eq!(reset.len(), 1);
    // rust: let part: ContentPart = serde_json::from_slice(&reset[0]).unwrap();
    // rust: assert!(part.recipes.is_empty());
    // rust: assert_eq!(part.last.as_deref(), Some(&[][..]));
    // rust: let types = vec![
    // rust: "minecraft:smelting".to_owned(),
    // rust: "mymod:crusher".to_owned(),
    // rust: "x:none".to_owned(),
    // rust: ];
    // rust: let parts = encode_content(&types, &sources, false);
    // rust: assert_eq!(parts.len(), 1);
    // rust: let part: ContentPart = serde_json::from_slice(&parts[0]).unwrap();
    // rust: let ids: Vec<&str> = part.recipes.iter().map(|(id, _)| id.as_str()).collect();
    // rust: assert_eq!(ids, ["minecraft:furnace", "mymod:crush"]);
    // rust: assert_eq!(part.last.as_deref(), Some(types.as_slice()));
}

content_splits_under_the_payload_cap :: proc() {
}
    // rust: let big = "x".repeat(300_000);
    // rust: let sources: Vec<_> = (0..10)
    // rust: .map(|i| (format!("m:r{i}"), json!({"type": "m:t", "pad": big})))
    // rust: .collect();
    // rust: let parts = encode_content(&["m:t".to_owned()], &sources, false);
    // rust: assert!(parts.len() >= 3);
    // rust: let mut n = 0;
    // rust: for (i, p) in parts.iter().enumerate() {
    // rust: assert!(p.len() <= 1_048_576);
    // rust: let part: ContentPart = serde_json::from_slice(p).unwrap();
    // rust: assert_eq!(part.last.is_some(), i + 1 == parts.len());
    // rust: n += part.recipes.len();
}
    // rust: assert_eq!(n, 10);
}

a_long_type_list_keeps_the_last_part_under_the_cap :: proc() {
}
    // rust: let types: Vec<String> = (0..5000)
    // rust: .map(|i| format!("mod{i}:type_with_a_long_name"))
    // rust: .collect();
    // rust: let big = "x".repeat(1_000_000);
    // rust: let sources = vec![(
    // rust: "m:r".to_owned(),
    // rust: json!({"type": "mod0:type_with_a_long_name", "pad": big}),
    // rust: )];
    // rust: let parts = encode_content(&types, &sources, false);
    // rust: assert_eq!(parts.len(), 2);
    // rust: assert!(parts.iter().all(|p| p.len() <= 1_048_576));
    // rust: let last: ContentPart = serde_json::from_slice(&parts[1]).unwrap();
    // rust: assert!(last.recipes.is_empty());
    // rust: assert_eq!(last.last.map(|t| t.len()), Some(5000));
}
}
