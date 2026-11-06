//! Transpiled from Horizon Rust crate
package horizon_port_pack_carry

import "core:fmt"
import "core:mem"
import "core:math"

// Step 4, carry-over: a jar's `assets/` and `data/` into a folder content
// mod (API 0.2) for local use. Files are copied, never code; recipes are
// upgraded from 1.21.1 to 26.3, item models get their `items/` client
// definitions, and each blockstate gets a vanilla template guessed from its
// properties until the oracle's facts replace the guess.
// use crate::{jar::JarInfo, oracle::Facts};
// use serde::Serialize;
// use serde_json::{Value, json};
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: fs,
    // rust: io::Read,
    // rust: path::Path,
}

Report :: struct {
    copied: uint,
    // Namespaces besides the mod id its content owns ([`extra_namespaces`]),
    // listed in the manifest's `namespaces`.
    namespaces: [dynamic]string,
    // Files outside what a content mod may hold (other namespaces, vanilla
    // data other than tags), kept in `outside/` for review.
    outside: [dynamic]string,
    // Files of the mod's own content the game would refuse, kept in
    // `outside/` too, with why: a path vanilla does not read (upper case),
    // JSON that does not parse.
    unreadable: BTreeMap<string,
    recipes_upgraded: uint,
    loot_tables_upgraded: uint,
    // Advancements whose criteria were rewritten ([`upgrade_advancement`]).
    advancements_upgraded: uint,
    // Blocks whose jar has no loot table but drop themselves in the oracle:
    // the mod registers that table in code, and carry-over writes it.
    loot_tables_added: uint,
    // Worldgen and structure files (`data/<id>/worldgen/`, `structure/`).
    worldgen: uint,
    // Recipes left as they were: custom types, NeoForge conditions.
    recipes_kept: [dynamic]string,
    // Recipes whose result is one of the mod's own items that isn't declared (its block was
    // left out), moved to `outside/`: vanilla refuses a recipe for an unknown item, and the
    // game would craft air.
    recipes_unregistered: [dynamic]string,
    item_definitions_added: uint,
    // Templates and properties came from the NeoForge oracle's facts, not
    // from guesses.
    oracle: bool,
    // Declared blocks and their templates.
    blocks: BTreeMap<string,
    // What a declared block's template does not reproduce (oracle only).
    differences: BTreeMap<string,
    // Blocks left out, and why.
    blocks_unknown: BTreeMap<string,
    items: uint,
    // Equipment assets written from 1.21.1 armour materials.
    equipment: uint,
    // Items left out, and why (oracle only).
    items_unknown: BTreeMap<string,
    // Convention (`c:`) tags the recipes use, filled in from the oracle.
    convention_tags: uint,
    // Structure, placement and pool element types rewritten as vanilla's,
    // and those left as they are.
    worldgen_types: crate::worldgen::Upgrade,
    // The loader's convention biome tags the structures name, carried.
    convention_biome_tags: uint,
}

// The pack around a mod being carried.
Pack :: struct {
    // The mods ported along, for the conditions of worldgen modifiers.
    loaded: ^'a dyn Fn(string) -> bool,
    // Every mod of the pack by id, ported or not: their namespaces are theirs.
    mods: ^'a dyn Fn(string) -> bool,
}

// Vanilla blocks by their sorted property names.
    // rust: const TEMPLATES: &[(&str, &str)] = &[
    // rust: ("", "minecraft:stone"),
    // rust: ("axis", "minecraft:oak_log"),
    // rust: ("type,waterlogged", "minecraft:oak_slab"),
    // rust: ("facing,half,shape,waterlogged", "minecraft:oak_stairs"),
    // rust: ("facing,half,hinge,open,powered", "minecraft:oak_door"),
    // rust: (
    // rust: "facing,half,open,powered,waterlogged",
    // rust: "minecraft:oak_trapdoor",
    // rust: ),
    // rust: ("east,north,south,waterlogged,west", "minecraft:oak_fence"),
    // rust: ("east,north,south,waterlogged,west", "minecraft:glass_pane"),
    // rust: (
    // rust: "east,north,south,up,waterlogged,west",
    // rust: "minecraft:cobblestone_wall",
    // rust: ),
    // rust: ("facing,in_wall,open,powered", "minecraft:oak_fence_gate"),
    // rust: ("face,facing,powered", "minecraft:oak_button"),
    // rust: ("powered", "minecraft:oak_pressure_plate"),
    // rust: ("facing", "minecraft:carved_pumpkin"),
    // rust: ("facing,lit", "minecraft:furnace"),
    // rust: ("lit", "minecraft:redstone_lamp"),
    // rust: ("waterlogged", "minecraft:chain"),
    // rust: ("age", "minecraft:wheat"),
    // rust: ("distance,persistent,waterlogged", "minecraft:oak_leaves"),
    // rust: ("stage", "minecraft:oak_sapling"),
    // rust: ];

// A guess without the oracle: the template whose properties include the
// blockstate's with the fewest left over (a blockstate may leave out what
// its models ignore, such as `powered` or `waterlogged`), the block's name
// breaking ties (`_pane`, `_gate`, `_trapdoor`).
template :: proc(name: string, properties: ^BTreeSet<string>) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let fits = TEMPLATES.iter().filter_map(|(k, t)| {
    // rust: let have: BTreeSet<&str> = k.split(',').filter(|p| !p.is_empty()).collect();
    // rust: properties
    // rust: .iter()
    // rust: .all(|p| have.contains(p.as_str()))
    // rust: .then(|| (have.len() - properties.len(), *t))
    // rust: });
    // rust: let hint = |t: &str| {
    // rust: let kind = t.rsplit('_').next().unwrap_or(t);
    // rust: !name.ends_with(&format!("_{kind}"))
}
    // rust: fits.min_by_key(|&(extra, t)| (extra, hint(t)))
    // rust: .map(|(_, t)| t)
}

// [`template`] for a blockstate file. A wall's sides are `none`, `low` or
// `tall`; sides and `up` that are `true` or `false` are a vine's (Chipped's
// vines), which the names alone take for a wall.
block_template :: proc(name: string, blockstate: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let t = template(name, &properties(blockstate))?;
    // rust: let boolean = ["north", "east", "south", "west"]
    // rust: .iter()
    // rust: .flat_map(|side| values(blockstate, side))
    // rust: .any(|v| v == "true" || v == "false");
    // rust: Some(if t == "minecraft:cobblestone_wall" && boolean {
    // rust: "minecraft:vine"
    // rust: } else {
    // rust: t
    // rust: })
}

// The values a blockstate file tests a property for.
values :: proc(blockstate: ^Value, property: string) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = BTreeSet::new();
    // rust: for key in blockstate["variants"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(k, _)| k)
    // rust: {
    // rust: for pair in key.split(',') {
    // rust: if let Some((k, v)) = pair.split_once('=')
    // rust: && k == property
    // rust: {
    // rust: out.insert(v.to_owned());
}
}
}
    // rust: for part in blockstate["multipart"].as_array().into_iter().flatten() {
    // rust: let when = &part["when"];
    // rust: let mut conditions: Vec<&Value> = vec![when];
    // rust: for or in ["OR", "AND"] {
    // rust: conditions.extend(when[or].as_array().into_iter().flatten());
}
    // rust: for v in conditions.iter().filter_map(|c| c[property].as_str()) {
    // rust: out.extend(v.trim_start_matches('!').split('|').map(str::to_owned));
}
}
    // rust: out
}

// The property names a blockstate file uses.
properties :: proc(blockstate: ^Value) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = BTreeSet::new();
    // rust: let mut add = |pairs: &str| {
    // rust: for pair in pairs.split(',').filter(|p| !p.is_empty()) {
    // rust: out.insert(pair.split('=').next().unwrap_or(pair).to_owned());
}
}
    // rust: for key in blockstate["variants"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(k, _)| k)
    // rust: {
    // rust: add(key);
}
    // rust: for part in blockstate["multipart"].as_array().into_iter().flatten() {
    // rust: let when = &part["when"];
    // rust: let mut conditions: Vec<&Value> = vec![when];
    // rust: for or in ["OR", "AND"] {
    // rust: conditions.extend(when[or].as_array().into_iter().flatten());
}
    // rust: for c in conditions {
    // rust: for (k, _) in c.as_object().into_iter().flatten() {
    // rust: if k != "OR" && k != "AND" {
    // rust: out.insert(k.clone());
}
}
}
}
    // rust: out
}

// A 1.21.1 ingredient (`{"item": id}`, `{"tag": t}` or a list of those) as
// 26.3's (`"id"`, `"#t"`, `["id", ...]`); `None` for what has no 26.3 form
// (custom ingredient types, tags inside lists).
ingredient :: proc(v: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::String(_) => Some(v.clone()),
    // rust: Value::Object(o) if o.len() == 1 => {
    // rust: if let Some(Value::String(id)) = o.get("item") {
    // rust: Some(json!(id))
    // rust: } else if let Some(Value::String(tag)) = o.get("tag") {
    // rust: Some(json!(format!("#{tag}")))
    // rust: } else {
    // rust: None
}
}
    // rust: Value::Array(list) => {
    // rust: let ids: Option<Vec<Value>> = list
    // rust: .iter()
    // rust: .map(|x| {
    // rust: x.get("item")
    // rust: .filter(|_| x.as_object().is_some_and(|o| o.len() == 1))
    // rust: .cloned()
    // rust: })
    // rust: .collect();
    // rust: match ids? {
    // rust: ids if ids.len() == 1 => ids.into_iter().next(),
    // rust: ids => Some(Value::Array(ids)),
}
}
    // rust: _ => None,
}
}

// A vanilla recipe upgraded in place; `false` (unchanged) when it is not
// a vanilla type or one of its ingredients has no 26.3 form.
upgrade_recipe :: proc(recipe: ^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let kind = recipe["type"].as_str().unwrap_or("");
    // rust: if !kind.starts_with("minecraft:") || recipe.get("neoforge:conditions").is_some() {
    // rust: return false;
}
    // rust: let mut out = recipe.clone();
    // rust: if let Some(key) = out.get_mut("key").and_then(Value::as_object_mut) {
    // rust: for v in key.values_mut() {
    // rust: let Some(new) = ingredient(v) else {
    // rust: return false;
}
    // rust: *v = new;
}
}
    // rust: if let Some(list) = out.get_mut("ingredients").and_then(Value::as_array_mut) {
    // rust: for v in list.iter_mut() {
    // rust: let Some(new) = ingredient(v) else {
    // rust: return false;
}
    // rust: *v = new;
}
}
    // rust: for field in ["ingredient", "base", "addition", "template"] {
    // rust: if let Some(v) = out.get_mut(field) {
    // rust: let Some(new) = ingredient(v) else {
    // rust: return false;
}
    // rust: *v = new;
}
}
    // rust: *recipe = out;
    // rust: true
}

// Block and item ids vanilla renamed after 1.21.1, as its datafixers
// rename them in worlds (DataVersion 4541: the chain became the iron chain
// when copper chains came in). A data file naming the old id fails to load
// in 26.3: a recipe, a loot entry, a processor's block match.
RENAMED_IDS :: [("minecraft:chain", "minecraft:iron_chain")]

// Every string of a data file that is a renamed id ([`RENAMED_IDS`]) set to
// the new one, in place; whether any was.
renamed_ids :: proc(v: ^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::String(s) => match RENAMED_IDS.iter().find(|(old, _)| s == old) {
    // rust: Some((_, new)) => {
    // rust: *s = (*new).to_owned();
    // rust: true
}
    // rust: None => false,
    // rust: },
    // rust: Value::Array(a) => a.iter_mut().fold(false, |c, x| renamed_ids(x) | c),
    // rust: Value::Object(o) => o.values_mut().fold(false, |c, x| renamed_ids(x) | c),
    // rust: _ => false,
}
}

// A 1.21.1 advancement in 26.3's shape, in place: an `enter_block`
// criterion names its block as `blocks`, which 26.3 reads as a block list.
// 26.3 skips the old `block` field, so the criterion matched any block the
// player entered (Regions Unexplored's "Downer" on the first dive).
upgrade_advancement :: proc(v: ^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut changed = false;
    // rust: let criteria = v.get_mut("criteria").and_then(Value::as_object_mut);
    // rust: for c in criteria.into_iter().flat_map(|o| o.values_mut()) {
    // rust: let trigger = c.get("trigger").and_then(Value::as_str);
    // rust: if !matches!(trigger, Some("minecraft:enter_block" | "enter_block")) {
    // rust: continue;
}
    // rust: if let Some(conditions) = c.get_mut("conditions").and_then(Value::as_object_mut)
    // rust: && !conditions.contains_key("blocks")
    // rust: && let Some(block) = conditions.remove("block")
    // rust: {
    // rust: conditions.insert("blocks".into(), block);
    // rust: changed = true;
}
}
    // rust: changed
}

// A 1.21.1 loot table in 26.3's shape, in place: `conditions` lists become
// one `condition` (`all_of` for several), `functions` become `modifier`,
// and conditions and functions name their kind in `type`. A tool match on
// silk touch alone, or on shears alone, becomes 26.3's
// `minecraft:tool/can_silk_touch` or `minecraft:tool/can_shear`. Number
// providers written as a bare `{min, max}` get their `type`
// ([`type_number`]).
upgrade_loot :: proc(v: ^Value) {
}
    // rust: match v {
    // rust: Value::Array(a) => a.iter_mut().for_each(upgrade_loot),
    // rust: Value::Object(o) => {
    // rust: if let Some(Value::Array(pools)) = o.get_mut("pools") {
    // rust: for pool in pools {
    // rust: for key in ["rolls", "bonus_rolls"] {
    // rust: if let Some(n) = pool.get_mut(key) {
    // rust: type_number(n);
}
}
}
}
    // rust: if let Some(Value::Array(mut list)) = o.remove("conditions") {
    // rust: list.iter_mut().for_each(upgrade_condition);
    // rust: let one = match <[Value; 1]>::try_from(list) {
    // rust: Ok([c]) => c,
    // rust: Err(list) => json!({"type": "minecraft:all_of", "terms": list}),
}
    // rust: o.insert("condition".to_owned(), one);
}
    // rust: if let Some(Value::Array(mut list)) = o.remove("functions") {
    // rust: for f in &mut list {
    // rust: rename_kind(f, "function");
    // rust: type_function_numbers(f);
    // rust: upgrade_loot(f);
}
    // rust: o.insert("modifier".to_owned(), Value::Array(list));
}
    // rust: for (k, x) in o.iter_mut() {
    // rust: if k != "condition" && k != "modifier" {
    // rust: upgrade_loot(x);
}
}
}
    // rust: _ => {}
}
}

// A number provider in 26.3's shape, in place. 1.21.1 read a `{min, max}`
// with no `type` as a uniform one (NumberProviders.CODEC's fallback to
// UniformGenerator); 26.3 dispatches on `type` alone and refuses the table.
// Bounds nested in a uniform or binomial one get theirs too.
type_number :: proc(v: ^Value) {
}
    // rust: let Some(o) = v.as_object_mut() else {
    // rust: return;
}
    // rust: if !o.contains_key("type") && o.contains_key("min") && o.contains_key("max") {
    // rust: o.insert("type".to_owned(), json!("minecraft:uniform"));
}
    // rust: let kind = o.get("type").and_then(Value::as_str).unwrap_or_default();
    // rust: let bounds: &[&str] = match kind.strip_prefix("minecraft:").unwrap_or(kind) {
    // rust: "uniform" => &["min", "max"],
    // rust: "binomial" => &["n", "p"],
    // rust: _ => &[],
}
    // rust: for key in bounds {
    // rust: if let Some(b) = o.get_mut(*key) {
    // rust: type_number(b);
}
}
}

// The number providers of one loot function ([`type_number`]): the fields
// its 1.21.1 codec reads with NumberProviders.CODEC. Range bounds such as
// `limit_count`'s are providers too, the range itself is not.
type_function_numbers :: proc(f: ^Value) {
}
    // rust: let kind = f["type"].as_str().unwrap_or_default().to_owned();
    // rust: let Some(f) = f.as_object_mut() else {
    // rust: return;
}
    // rust: let mut each = |list: &str, key: &str| {
    // rust: for x in f
    // rust: .get_mut(list)
    // rust: .and_then(Value::as_array_mut)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: if let Some(n) = x.get_mut(key) {
    // rust: type_number(n);
}
}
}
    // rust: match kind.strip_prefix("minecraft:").unwrap_or(&kind) {
    // rust: "set_stew_effect" => each("effects", "duration"),
    // rust: "set_attributes" => each("modifiers", "amount"),
    // rust: "set_enchantments" => {
    // rust: for level in f
    // rust: .get_mut("enchantments")
    // rust: .and_then(Value::as_object_mut)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: type_number(level.1);
}
}
    // rust: "limit_count" => {
    // rust: if let Some(limit) = f.get_mut("limit") {
    // rust: for key in ["min", "max"] {
    // rust: if let Some(n) = limit.get_mut(key) {
    // rust: type_number(n);
}
}
}
}
    // rust: k => {
    // rust: let key = match k {
    // rust: "set_count" | "enchanted_count_increase" => "count",
    // rust: "set_damage" => "damage",
    // rust: "enchant_with_levels" => "levels",
    // rust: "set_ominous_bottle_amplifier" => "amplifier",
    // rust: _ => return,
}
    // rust: if let Some(n) = f.get_mut(key) {
    // rust: type_number(n);
}
}
}
}

// `{"<key>": kind, ...}` as `{"type": kind, ...}`.
rename_kind :: proc(v: ^Value, key: string) {
}
    // rust: if let Some(o) = v.as_object_mut()
    // rust: && !o.contains_key("type")
    // rust: && let Some(kind) = o.remove(key)
    // rust: {
    // rust: o.insert("type".to_owned(), kind);
}
}

// One 1.21.1 loot condition in 26.3's shape.
upgrade_condition :: proc(c: ^Value) {
}
    // rust: rename_kind(c, "condition");
    // rust: if let Some(term) = c.get_mut("term") {
    // rust: upgrade_condition(term);
}
    // rust: if let Some(Value::Array(terms)) = c.get_mut("terms") {
    // rust: terms.iter_mut().for_each(upgrade_condition);
}
    // rust: if c["type"] == "minecraft:match_tool"
    // rust: && let Some(named) = named_tool_condition(&c["predicate"])
    // rust: {
    // rust: *c = json!(named);
}
    // rust: match c["type"].as_str() {
    // rust: Some("minecraft:entity_properties") => {
    // rust: if let Some(p) = c.get_mut("predicate") {
    // rust: upgrade_entity_predicate(p);
}
}
    // rust: Some("minecraft:damage_source_properties") => {
    // rust: for key in ["direct_entity", "source_entity"] {
    // rust: if let Some(p) = c["predicate"].get_mut(key) {
    // rust: upgrade_entity_predicate(p);
}
}
}
    // rust: _ => {}
}
}

// The fields of a 1.21 entity predicate that are, in 26.3, sub-predicates
// keyed by their registry name (`minecraft:<field>`), as 26.3's own data
// writes them (`"minecraft:flags": {"is_on_fire": true}`).
    // rust: const ENTITY_FIELDS: [&str; 15] = [
    // rust: "distance",
    // rust: "movement",
    // rust: "location",
    // rust: "stepping_on",
    // rust: "movement_affected_by",
    // rust: "effects",
    // rust: "nbt",
    // rust: "flags",
    // rust: "equipment",
    // rust: "periodic_tick",
    // rust: "team",
    // rust: "slots",
    // rust: "components",
    // rust: "predicates",
    // rust: "type_specific",
    // rust: ];

// Entity predicates nested in an entity predicate (1.21 field names).
ENTITY_NESTED :: ["vehicle", "passenger", "targeted_entity"]

// Kinds of 1.21's `type_specific` whose `variant` 26.3 matches as a component
// (`"minecraft:components": {"minecraft:cat/variant": ...}`).
    // rust: const VARIANT_KINDS: [&str; 14] = [
    // rust: "axolotl",
    // rust: "cat",
    // rust: "chicken",
    // rust: "cow",
    // rust: "fox",
    // rust: "frog",
    // rust: "horse",
    // rust: "llama",
    // rust: "mooshroom",
    // rust: "painting",
    // rust: "parrot",
    // rust: "pig",
    // rust: "rabbit",
    // rust: "wolf",
    // rust: ];

// A 1.21 entity predicate in 26.3's shape, in place: `type` is
// `minecraft:entity_type`, every other field `minecraft:<field>`, `vehicle`,
// `passenger` and `targeted_entity` recursively; `type_specific {"type": k,
// ...}` is `minecraft:type_specific/<k>` (`slime` is `cube_mob`), a variant
// kind's `variant` and a sheep's `color` go to `minecraft:components`. The
// game's loot code reads only these keys, so an old-shaped predicate never
// matched. A predicate already in 26.3's shape stays as it is.
    // rust: pub(crate) fn upgrade_entity_predicate(p: &mut Value) {
    // rust: let Some(o) = p.as_object_mut() else {
    // rust: return;
}
    // rust: let key = |f: &str| format!("minecraft:{f}");
    // rust: if let Some(t) = o.remove("type") {
    // rust: o.insert(key("entity_type"), t);
}
    // rust: for f in ENTITY_NESTED {
    // rust: if let Some(mut inner) = o.remove(f) {
    // rust: upgrade_entity_predicate(&mut inner);
    // rust: o.insert(key(f), inner);
}
}
    // rust: for f in ENTITY_FIELDS {
    // rust: if let Some(v) = o.remove(f) {
    // rust: o.insert(key(f), v);
}
}
    // rust: let Some(Value::Object(mut ts)) = o.remove("minecraft:type_specific") else {
    // rust: return;
}
    // rust: let kind = ts.remove("type");
    // rust: let kind = kind.as_ref().and_then(Value::as_str).unwrap_or("any");
    // rust: let kind = match kind.trim_start_matches("minecraft:") {
    // rust: "slime" => "cube_mob",
    // rust: k => k,
}
    // rust: let component = match kind {
    // rust: k if VARIANT_KINDS.contains(&k) => {
    // rust: ts.remove("variant").map(|v| (format!("{k}/variant"), v))
}
    // rust: "sheep" => ts.remove("color").map(|v| ("sheep/color".to_owned(), v)),
    // rust: _ => None,
}
    // rust: if let Some((name, v)) = component {
    // rust: let components = o.entry(key("components")).or_insert_with(|| json!({}));
    // rust: if let Some(c) = components.as_object_mut() {
    // rust: c.insert(key(&name), v);
}
}
    // A player's `looking_at`, a lightning bolt's `entity_struck`.
    // rust: for f in ["looking_at", "entity_struck"] {
    // rust: if let Some(v) = ts.get_mut(f) {
    // rust: upgrade_entity_predicate(v);
}
}
    // A variant kind with nothing else to match is the component alone.
    // rust: if !ts.is_empty() || !(kind == "any" || VARIANT_KINDS.contains(&kind)) {
    // rust: o.insert(key(&format!("type_specific/{kind}")), Value::Object(ts));
}
}

// 26.3's named tool conditions for the 1.21.1 predicates they replace.
named_tool_condition :: proc(predicate: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let keys: Vec<&str> = predicate.as_object()?.keys().map(String::as_str).collect();
    // rust: match keys.as_slice() {
    // rust: ["predicates"] => {
    // rust: let list = predicate["predicates"]["minecraft:enchantments"].as_array()?;
    // rust: let [e] = list.as_slice() else {
    // rust: return None;
}
    // rust: let silk = e["enchantments"] == "minecraft:silk_touch"
    // rust: && e["levels"]["min"].as_u64().unwrap_or(1) <= 1
    // rust: && e["levels"].get("max").is_none()
    // rust: && predicate["predicates"].as_object()?.len() == 1;
    // rust: silk.then_some("minecraft:tool/can_silk_touch")
}
    // rust: ["items"] => {
    // rust: let items = &predicate["items"];
    // rust: let shears = items == "minecraft:shears" || *items == json!(["minecraft:shears"]);
    // rust: shears.then_some("minecraft:tool/can_shear")
}
    // rust: _ => None,
}
}

// A jar entry's root (`assets` or `data`), namespace and the rest, for
// the files a content mod may carry.
split :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut parts = name.splitn(3, '/');
    // rust: let (root, ns, rest) = (parts.next()?, parts.next()?, parts.next()?);
    // rust: let carried = (root == "assets" || root == "data") && !rest.is_empty() && !name.ends_with('/');
    // rust: carried.then_some((root, ns, rest))
}

// Additions to vanilla and convention tags, which every mod may hold.
shared_tag :: proc(root: string, ns: string, rest: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: root == "data" && (ns == "minecraft" || ns == "c") && rest.starts_with("tags/")
}

// Sources a mod adds to vanilla's atlases, which the game appends to vanilla's as a reload does.
shared_atlas :: proc(root: string, ns: string, rest: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: root == "assets" && ns == "minecraft" && rest.starts_with("atlases/") && rest.ends_with(".json")
}

// Where a jar entry goes: `Some(true)` inside the content mod (its own
// namespaces, additions to vanilla and convention tags and to vanilla's
// atlases), `Some(false)` to `outside/`, `None` not carried (code, metadata).
place :: proc(name: string, owned: ^[string]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (root, ns, rest) = split(name)?;
    // rust: Some(owned.contains(&ns) || shared_tag(root, ns, rest) || shared_atlas(root, ns, rest))
}

// Namespaces no carried mod claims: vanilla's, the convention tags', the
// game's own and the loaders'.
NOT_CLAIMED :: ["minecraft", "c", "horizon", "forge", "neoforge", "fabric"]

// The namespaces besides `id` a mod's content owns. Some mods ship their
// files under other names than their id (Towns and Towers, `t_and_t`,
// under `kaisyn` and `towns_and_towers`); others ship files for mods they
// support (`wares`, `morevillagers`) or configure (`cristellib`). A
// namespace is the mod's when its own files (its id's, its tag additions
// and the namespaces already claimed) name ids in it, and no mod of the
// pack (`pack_mod`) has it as its id.
    // rust: fn extra_namespaces(
    // rust: zip: &mut zip::ZipArchive<fs::File>,
    // rust: id: &str,
    // rust: pack_mod: &dyn Fn(&str) -> bool,
    // rust: ) -> Vec<String> {
    // rust: let mut candidates = BTreeSet::new();
    // rust: for name in zip.file_names().filter_map(Result::ok) {
    // rust: if let Some((_, ns, _)) = split(&name)
    // rust: && ns != id
    // rust: && !NOT_CLAIMED.contains(&ns)
    // rust: && !pack_mod(ns)
    // rust: {
    // rust: candidates.insert(ns.to_owned());
}
}
    // rust: if candidates.is_empty() {
    // rust: return Vec::new();
}
    // The JSON files that could be the mod's, by namespace ("" for tag additions).
    // rust: let mut texts: Vec<(String, Vec<u8>)> = Vec::new();
    // rust: for i in 0..zip.len() {
    // rust: let Ok(mut entry) = zip.by_index(i) else {
    // rust: continue;
}
    // rust: let Ok(name) = entry.name().map(|n| n.into_owned()) else {
    // rust: continue;
}
    // rust: let Some((root, ns, rest)) = split(&name) else {
    // rust: continue;
}
    // rust: let ns = match () {
    // rust: _ if shared_tag(root, ns, rest) => String::new(),
    // rust: _ if ns == id || candidates.contains(ns) => ns.to_owned(),
    // rust: _ => continue,
}
    // rust: let mut bytes = Vec::new();
    // rust: if name.ends_with(".json") && entry.read_to_end(&mut bytes).is_ok() {
    // rust: texts.push((ns, bytes));
}
}
    // rust: let mut owned: BTreeSet<String> = [String::new(), id.to_owned()].into();
    // rust: let mut claimed = Vec::new();
    // rust: loop {
    // rust: let named = candidates.iter().find(|ns| {
    // rust: let (id, tag) = (format!("\"{ns}:"), format!("\"#{ns}:"));
    // rust: texts.iter().any(|(owner, text)| {
    // rust: owned.contains(owner)
    // rust: && (contains(text, id.as_bytes()) || contains(text, tag.as_bytes()))
    // rust: })
    // rust: });
    // rust: let Some(ns) = named.cloned() else {
    // rust: break;
}
    // rust: candidates.remove(&ns);
    // rust: owned.insert(ns.clone());
    // rust: claimed.push(ns);
}
    // rust: claimed.sort();
    // rust: claimed
}

// The namespaces besides `id` the mod in `jar` would own ([`extra_namespaces`]), for the
// pack to find the ones several mods claim.
    // rust: pub fn namespaces_claimed(
    // rust: jar: &Path,
    // rust: id: &str,
    // rust: pack_mod: &dyn Fn(&str) -> bool,
    // rust: ) -> Result<Vec<String>, String> {
    // rust: let file = fs::File::open(jar).map_err(|e| format!("{}: {e}", jar.display()))?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| format!("{}: {e}", jar.display()))?;
    // rust: Ok(extra_namespaces(&mut zip, id, pack_mod))
}

contains :: proc(haystack: []u8, needle: []u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: haystack.windows(needle.len()).any(|w| w == needle)
}

// Why the game would refuse a file of the mod's own content, if it would.
// Vanilla skips such files one by one (an invalid resource path, a data
// file that does not parse); Horizon's content loader refuses the whole
// set, so they stay out of the carry.
unreadable :: proc(name: string, bytes: ^[dynamic]u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Err(e) = horizon_mods::content::check_path(name) {
    // rust: return Some(e);
}
    // rust: if !(name.ends_with(".json") || name.ends_with(".mcmeta")) {
    // rust: return None;
}
    // A byte-order mark: Horizon's JSON readers take the file without it.
    // rust: if bytes.starts_with(b"\xEF\xBB\xBF") {
    // rust: bytes.drain(..3);
}
    // rust: let mut value: Value = match serde_json::from_slice(bytes) {
    // rust: Ok(v) => v,
        // Minecraft reads data files with Gson's lenient reader, which skips
        // comments: YUNG's pools have them. The carry is plain JSON.
    // rust: Err(e) => match serde_json::from_slice::<Value>(&without_comments(bytes)) {
    // rust: Ok(v) => {
    // rust: *bytes = serde_json::to_vec_pretty(&v).expect("a parsed value serializes");
    // rust: v
}
    // rust: Err(_) => return Some(format!("does not parse as JSON: {e}")),
    // rust: },
}
    // A vanilla or convention tag that replaces is kept: the game honours it
    // as a data pack's, with a warning (docs/mods.md). A tag of the mod's own
    // that replaces: no pack before it defines the tag, so it is the same tag
    // added to (Towns and Towers' biome tags).
    // rust: let shared_tag = name.starts_with("data/minecraft/tags/") || name.starts_with("data/c/tags/");
    // rust: let own_tag = !shared_tag && name.starts_with("data/") && name.contains("/tags/");
    // rust: if own_tag && let Some(o) = value.as_object_mut().filter(|o| o.contains_key("replace")) {
    // rust: o.remove("replace");
    // rust: *bytes = serde_json::to_vec_pretty(&value).expect("a parsed value serializes");
}
    // rust: None
}

// JSON text without the comments Gson's lenient reader skips: `//` and
// `#` to the end of the line, and `/* ... */`, outside strings.
without_comments :: proc(bytes: []u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::with_capacity(bytes.len());
    // rust: let mut i = 0;
    // rust: let mut string = false;
    // rust: while i < bytes.len() {
    // rust: let b = bytes[i];
    // rust: if string {
    // rust: out.push(b);
    // rust: if b == b'\\' {
    // rust: out.extend(bytes.get(i + 1));
    // rust: i += 1;
    // rust: } else if b == b'"' {
    // rust: string = false;
}
    // rust: i += 1;
    // rust: continue;
}
    // rust: match (b, bytes.get(i + 1)) {
    // rust: (b'"', _) => {
    // rust: string = true;
    // rust: out.push(b);
    // rust: i += 1;
}
    // rust: (b'/', Some(b'/')) | (b'#', _) => {
    // rust: while i < bytes.len() && bytes[i] != b'\n' {
    // rust: i += 1;
}
}
    // rust: (b'/', Some(b'*')) => {
    // rust: i += 2;
    // rust: while i < bytes.len() && !bytes[i..].starts_with(b"*/") {
    // rust: i += 1;
}
    // rust: i += 2;
    // rust: out.push(b' ');
}
    // rust: _ => {
    // rust: out.push(b);
    // rust: i += 1;
}
}
}
    // rust: out
}

// Item models another item's overrides reach: looks, not items; models that only reach each other stay items.
variant_models :: proc(overrides: ^BTreeMap<string) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let targets: BTreeSet<&String> = overrides.values().flatten().collect();
    // rust: let mut todo: Vec<&String> = overrides.keys().filter(|m| !targets.contains(m)).collect();
    // rust: let mut variants = BTreeSet::new();
    // rust: while let Some(m) = todo.pop() {
    // rust: for target in overrides.get(m).into_iter().flatten() {
    // rust: if variants.insert(target.clone()) {
    // rust: todo.push(target);
}
}
}
    // rust: variants
}

// Carries `jar` over into `out/carry/`. With the oracle's `facts`, blocks
// and items are the ones the mod registers, with the templates and numbers
// the facts give; `allowed` says which vanilla blocks the game has;
// `pack` which mods the pack holds and ports along.
    // rust: pub fn carry(
    // rust: jar: &Path,
    // rust: info: &JarInfo,
    // rust: out: &Path,
    // rust: facts: Option<&Facts>,
    // rust: allowed: &dyn Fn(&str) -> bool,
    // rust: pack: &Pack,
    // rust: conventions: &BTreeMap<String, Value>,
    // rust: ) -> Result<Report, String> {
    // rust: let loaded = pack.loaded;
    // rust: let id = &info.mod_id;
    // rust: if id.is_empty()
    // rust: || id.len() > 64
    // rust: || !id
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_')
    // rust: {
    // rust: return Err(format!(
    // rust: "mod id {id:?} is not [a-z0-9_]{{1,64}}: rename it before carrying over"
    // rust: ));
}
    // rust: let file = fs::File::open(jar).map_err(|e| format!("{}: {e}", jar.display()))?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| format!("{}: {e}", jar.display()))?;
    // The previous harness verdict describes the content we are about to replace.
    // rust: let verdict = out.join("harness/result.json");
    // rust: if let Err(e) = fs::remove_file(&verdict)
    // rust: && e.kind() != std::io::ErrorKind::NotFound
    // rust: {
    // rust: return Err(format!("{}: {e}", verdict.display()));
}
    // rust: let (inside, outside) = (out.join("carry"), out.join("outside"));
    // rust: let _ = fs::remove_dir_all(&inside);
    // rust: let _ = fs::remove_dir_all(&outside);
    // rust: let mut report = Report::default();
    // rust: let mut blockstates: BTreeMap<String, Value> = BTreeMap::new();
    // rust: let mut item_models = BTreeSet::new();
    // Models another item model's `overrides` switch to (trim looks, a bow's pull): variants, not items.
    // rust: let mut model_overrides: BTreeMap<String, BTreeSet<String>> = BTreeMap::new();
    // rust: let mut convention = BTreeSet::new();
    // rust: let mut block_loot = BTreeSet::new();
    // rust: let mut biome_conventions = BTreeSet::new();
    // rust: let set_tags = crate::worldgen::structure_set_tags(&mut zip);
    // rust: let piece_counts = crate::worldgen::piece_counts(&mut zip);
    // rust: let mut processor_data = crate::processors::ProcessorData::read(&mut zip);
    // rust: processor_data.mark_loaded(loaded);
    // rust: report.namespaces = extra_namespaces(&mut zip, id, pack.mods);
    // rust: let owned: Vec<&str> = std::iter::once(id.as_str())
    // rust: .chain(report.namespaces.iter().map(String::as_str))
    // rust: .collect();
    // rust: for i in 0..zip.len() {
    // rust: let mut entry = zip.by_index(i).map_err(|e| e.to_string())?;
    // rust: let name = entry.name().map_err(|e| e.to_string())?.into_owned();
    // rust: let Some(keep) = place(&name, &owned) else {
    // rust: continue;
}
        // `..` or an empty part escapes on every platform; `\` or `:` (a drive or
        // a separator) escapes on Windows.
    // rust: if name.split('/').any(|p| p == ".." || p.is_empty()) || name.contains(['\\', ':']) {
    // rust: continue;
}
    // rust: let mut bytes = Vec::new();
    // rust: entry
    // rust: .read_to_end(&mut bytes)
    // rust: .map_err(|e| format!("{name}: {e}"))?;
    // rust: let unreadable = if keep {
    // rust: unreadable(&name, &mut bytes)
    // rust: } else {
    // rust: None
}
    // rust: let keep = keep && unreadable.is_none();
    // rust: if let Some(why) = unreadable {
    // rust: report.unreadable.insert(name.clone(), why);
}
    // rust: let dest = if keep {
    // rust: report.copied += 1;
    // rust: inside.join(&name)
    // rust: } else {
    // rust: report.outside.push(name.clone());
    // rust: outside.join(&name)
}
    // rust: if keep {
            // The path in one of the mod's own namespaces; "" for tag additions.
    // rust: let (ns, rel) = match split(&name) {
    // rust: Some((_, ns, rest)) if owned.contains(&ns) => (ns, rest),
    // rust: _ => ("", ""),
}
            // Blocks and items are declared under the mod id only.
    // rust: let own = ns == id;
    // rust: if name.starts_with("data/")
    // rust: && (rel.starts_with("worldgen/") || rel.starts_with("structure/"))
    // rust: {
    // rust: report.worldgen += 1;
}
    // rust: if let Some(file) = rel
    // rust: .strip_prefix("recipe/")
    // rust: .filter(|_| name.starts_with("data/"))
    // rust: {
    // rust: if let Ok(mut recipe) = serde_json::from_slice::<Value>(&bytes) {
    // rust: tags_used(&recipe, &mut convention);
    // rust: let renamed = renamed_ids(&mut recipe);
    // rust: let upgraded = upgrade_recipe(&mut recipe);
    // rust: if upgraded {
    // rust: report.recipes_upgraded += 1;
    // rust: } else {
    // rust: report.recipes_kept.push(file.to_owned());
}
    // rust: if upgraded || renamed {
    // rust: bytes = serde_json::to_vec_pretty(&recipe).unwrap_or(bytes);
}
}
    // rust: } else if let Some(kind) = rel
    // rust: .strip_prefix("worldgen/")
    // rust: .and_then(|r| r.split_once('/'))
    // rust: .map(|(kind, _)| kind)
    // rust: .filter(|_| name.starts_with("data/") && name.ends_with(".json"))
    // rust: {
    // rust: if let Ok(mut v) = serde_json::from_slice::<Value>(&bytes) {
    // rust: if kind == "structure" {
    // rust: crate::worldgen::convention_tags(&v["biomes"], &mut biome_conventions);
}
    // rust: let types = &mut report.worldgen_types;
    // rust: let carried = crate::processors::carry(
    // rust: kind,
    // rust: &mut v,
    // rust: &processor_data,
    // rust: &mut types.processors_carried,
    // rust: ) | crate::processors::rule_tests(
    // rust: kind,
    // rust: &mut v,
    // rust: &mut types.rule_tests_carried,
    // rust: );
    // rust: let mut changed =
    // rust: crate::worldgen::upgrade(kind, &mut v, types, &set_tags) || carried;
    // rust: if kind == "structure" {
    // rust: let path = rel.trim_start_matches("worldgen/structure/");
    // rust: let structure = format!("{ns}:{}", path.trim_end_matches(".json"));
    // rust: changed |=
    // rust: crate::worldgen::add_piece_counts(&structure, &mut v, &piece_counts);
}
    // rust: if changed {
    // rust: bytes = serde_json::to_vec_pretty(&v).unwrap_or(bytes);
}
}
    // rust: } else if let Some(path) = rel
    // rust: .strip_prefix("lithostitched/worldgen_modifier/")
    // rust: .filter(|_| name.starts_with("data/") && name.ends_with(".json"))
    // rust: {
                // Additions to other sets and pools, as files the game merges.
    // rust: let modifier = serde_json::from_slice::<Value>(&bytes).ok();
    // rust: let types = &mut report.worldgen_types;
    // rust: if let Some((kind, mut added)) =
    // rust: modifier.and_then(|v| crate::lithostitched::modifier(&v, loaded, types))
    // rust: {
    // rust: crate::processors::carry(
    // rust: kind,
    // rust: &mut added,
    // rust: &processor_data,
    // rust: &mut types.processors_carried,
    // rust: );
    // rust: crate::processors::rule_tests(kind, &mut added, &mut types.rule_tests_carried);
    // rust: crate::worldgen::upgrade(kind, &mut added, types, &set_tags);
    // rust: let to = format!(
    // rust: "data/{id}/worldgen/{kind}/{}/{path}",
    // rust: crate::worldgen::ADDED
    // rust: );
    // rust: write(
    // rust: &inside.join(to),
    // rust: &serde_json::to_vec_pretty(&added).unwrap_or_default(),
    // rust: )?;
}
    // rust: } else if rel.starts_with("trial_spawner/")
    // rust: && name.starts_with("data/")
    // rust: && name.ends_with(".json")
    // rust: {
                // Trial spawner configs (Moog's arenas): their mobs' NBT.
    // rust: if let Ok(mut config) = serde_json::from_slice::<Value>(&bytes)
    // rust: && crate::processors::upgrade_trial_spawner(&mut config)
    // rust: {
    // rust: bytes = serde_json::to_vec_pretty(&config).unwrap_or(bytes);
}
    // rust: } else if rel.starts_with("tags/worldgen/biome/") && name.starts_with("data/") {
    // rust: if let Ok(v) = serde_json::from_slice::<Value>(&bytes) {
    // rust: crate::worldgen::convention_tags(&v, &mut biome_conventions);
}
    // rust: } else if rel.starts_with("advancement/")
    // rust: && name.starts_with("data/")
    // rust: && name.ends_with(".json")
    // rust: {
    // rust: if let Ok(mut advancement) = serde_json::from_slice::<Value>(&bytes)
    // rust: && upgrade_advancement(&mut advancement)
    // rust: {
    // rust: report.advancements_upgraded += 1;
    // rust: bytes = serde_json::to_vec_pretty(&advancement).unwrap_or(bytes);
}
    // rust: } else if rel.starts_with("loot_table/") && name.starts_with("data/") {
    // rust: if let Some(b) = rel
    // rust: .strip_prefix("loot_table/blocks/")
    // rust: .and_then(|b| b.strip_suffix(".json"))
    // rust: .filter(|_| own)
    // rust: {
    // rust: block_loot.insert(b.to_owned());
}
    // rust: if let Ok(mut table) = serde_json::from_slice::<Value>(&bytes) {
    // rust: let before = table.clone();
    // rust: upgrade_loot(&mut table);
    // rust: renamed_ids(&mut table);
    // rust: if table != before {
    // rust: report.loot_tables_upgraded += 1;
    // rust: bytes = serde_json::to_vec_pretty(&table).unwrap_or(bytes);
}
}
    // rust: } else if let Some(b) = rel
    // rust: .strip_prefix("blockstates/")
    // rust: .and_then(|b| b.strip_suffix(".json"))
    // rust: .filter(|_| own)
    // rust: {
    // rust: if let Ok(v) = serde_json::from_slice(&bytes) {
    // rust: blockstates.insert(b.to_owned(), v);
}
    // rust: } else if let Some(m) = rel
    // rust: .strip_prefix("models/item/")
    // rust: .and_then(|m| m.strip_suffix(".json"))
    // rust: .filter(|_| own)
    // rust: {
    // rust: item_models.insert(m.to_owned());
    // rust: let model: Value = serde_json::from_slice(&bytes).unwrap_or_default();
    // rust: for o in model["overrides"].as_array().into_iter().flatten() {
                    // A target without a namespace is vanilla's, not the mod's.
    // rust: let target = o["model"].as_str().and_then(|t| t.split_once(':'));
    // rust: if let Some(v) = target
    // rust: .filter(|(ns, _)| *ns == id)
    // rust: .and_then(|(_, path)| path.strip_prefix("item/"))
    // rust: .filter(|v| *v != m)
    // rust: {
    // rust: model_overrides
    // rust: .entry(m.to_owned())
    // rust: .or_default()
    // rust: .insert(v.to_owned());
}
}
}
}
    // rust: write(&dest, &bytes)?;
}
    // Entries the mod adds to other structure sets in Java code, for the
    // structures it has.
    // rust: for (file, set, entries) in crate::legacy_structure_mods::ctov::code_set_entries(id) {
    // rust: let entries: Vec<Value> = entries
    // rust: .into_iter()
    // rust: .filter(|(s, _)| {
    // rust: s.split_once(':').is_some_and(|(ns, path)| {
    // rust: inside
    // rust: .join(format!("data/{ns}/worldgen/structure/{path}.json"))
    // rust: .exists()
    // rust: })
    // rust: })
    // rust: .map(|(structure, weight)| json!({"structure": structure, "weight": weight}))
    // rust: .collect();
    // rust: if entries.is_empty() {
    // rust: continue;
}
    // rust: let added = &mut report.worldgen_types.added_to;
    // rust: *added.entry(set.to_owned()).or_default() += entries.len();
    // rust: let to = format!(
    // rust: "data/{id}/worldgen/structure_set/{}/{file}.json",
    // rust: crate::worldgen::ADDED
    // rust: );
    // rust: let v = json!({"horizon:add_to": set, "structures": entries});
    // rust: write(
    // rust: &inside.join(to),
    // rust: &serde_json::to_vec_pretty(&v).unwrap_or_default(),
    // rust: )?;
}
    // rust: let variants = variant_models(&model_overrides);
    // rust: let registered = |m: &str| facts.is_some_and(|f| f.items.contains_key(&format!("{id}:{m}")));
    // rust: item_models.retain(|m| !variants.contains(m) || registered(m));
    // 1.21.4 moved item models behind `items/<name>.json` definitions.
    // rust: for m in &item_models {
    // rust: let def = inside.join(format!("assets/{id}/items/{m}.json"));
    // rust: if !def.exists() {
    // rust: let model =
    // rust: json!({"model": {"type": "minecraft:model", "model": format!("{id}:item/{m}")}});
    // rust: write(&def, &serde_json::to_vec_pretty(&model).unwrap_or_default())?;
    // rust: report.item_definitions_added += 1;
}
}
    // The loader's convention biome tags the structures and their tags name
    // (NeoForge's `c:is_plains`...): the game has no loader, so they come along.
    // rust: for tag in crate::worldgen::with_included(&biome_conventions, conventions) {
    // rust: let file = inside.join(format!("data/c/tags/worldgen/biome/{tag}.json"));
    // rust: if !file.exists() {
    // rust: write(
    // rust: &file,
    // rust: &serde_json::to_vec_pretty(&conventions[&tag]).unwrap_or_default(),
    // rust: )?;
    // rust: report.convention_biome_tags += 1;
}
}
    // rust: let decl = inside.join(format!("data/{id}/horizon"));
    // rust: let write_decl = |kind: &str, name: &str, v: &Value| {
    // rust: let text = serde_json::to_vec_pretty(v).unwrap_or_default();
    // rust: write(&decl.join(format!("{kind}/{name}.json")), &text)
}
    // rust: if let Some(facts) = facts {
    // rust: report.oracle = true;
    // rust: let prefix = format!("{id}:");
    // rust: let mut declared = BTreeSet::new();
    // rust: for (full, block) in facts.blocks.range(prefix.clone()..) {
    // rust: let Some(b) = full.strip_prefix(&prefix) else {
    // rust: break;
}
    // rust: let Some(choice) = facts.template(full, allowed) else {
    // rust: let props: Vec<&str> = block.properties.keys().map(String::as_str).collect();
    // rust: let why = format!(
    // rust: "no vanilla {} with properties [{}]",
    // rust: block.vanilla_class().rsplit('.').next().unwrap_or(""),
    // rust: props.join(", ")
    // rust: );
    // rust: report.blocks_unknown.insert(b.to_owned(), why);
    // rust: continue;
}
    // rust: let mut v = json!({"template": choice.template, "properties": choice.properties});
    // rust: if block.item == "minecraft:air" {
    // rust: v["item"] = json!(false);
    // rust: } else if block.item != *full {
    // rust: v["item"] = json!(false);
    // rust: report
    // rust: .differences
    // rust: .entry(b.to_owned())
    // rust: .or_default()
    // rust: .push(format!("its item is {}", block.item));
    // rust: } else {
    // rust: declared.insert(full.clone());
    // rust: let drop = (!block_loot.contains(b))
    // rust: .then(|| block.drops_itself(full))
    // rust: .flatten();
    // rust: if let Some(drop) = drop {
    // rust: let mut entry = json!({"type": "minecraft:item", "name": full});
    // rust: if let crate::oracle::SelfDrop::When(property, value) = drop {
    // rust: entry["condition"] = json!({
    // rust: "type": "minecraft:match_block",
    // rust: "blocks": full,
    // rust: "state": {property: value}
    // rust: });
}
    // rust: let table = json!({
    // rust: "type": "minecraft:block",
    // rust: "pools": [{
    // rust: "condition": {"type": "minecraft:survives_explosion"},
    // rust: "entries": [entry],
    // rust: "rolls": 1
    // rust: }],
    // rust: "random_sequence": format!("{id}:blocks/{b}")
    // rust: });
    // rust: let file = inside.join(format!("data/{id}/loot_table/blocks/{b}.json"));
    // rust: write(
    // rust: &file,
    // rust: &serde_json::to_vec_pretty(&table).unwrap_or_default(),
    // rust: )?;
    // rust: report.loot_tables_added += 1;
}
}
    // rust: write_decl("block", b, &v)?;
    // rust: report.blocks.insert(b.to_owned(), choice.template);
    // rust: if !choice.differences.is_empty() {
    // rust: report
    // rust: .differences
    // rust: .entry(b.to_owned())
    // rust: .or_default()
    // rust: .extend(choice.differences);
}
}
    // rust: for (full, item) in facts.items.range(prefix.clone()..) {
    // rust: let Some(name) = full.strip_prefix(&prefix) else {
    // rust: break;
}
    // rust: if declared.contains(full) {
    // rust: continue;
}
    // rust: if item
    // rust: .block
    // rust: .as_ref()
    // rust: .is_some_and(|b| facts.blocks.contains_key(b))
    // rust: && report.blocks_unknown.contains_key(name)
    // rust: {
    // rust: report
    // rust: .items_unknown
    // rust: .insert(name.to_owned(), "its block is left out".into());
    // rust: continue;
}
    // rust: match facts.item(full, &owned) {
    // rust: Ok((v, differences)) => {
    // rust: write_decl("item", name, &v)?;
    // rust: report.items += 1;
    // rust: if !differences.is_empty() {
    // rust: report.differences.insert(name.to_owned(), differences);
}
}
    // rust: Err(e) => {
    // rust: report.items_unknown.insert(name.to_owned(), e);
}
}
}
        // 26.3 draws worn armour from an equipment asset per material, in the mod's own namespaces.
    // rust: let mut materials = BTreeSet::new();
    // rust: for (full, item) in facts.items.range(prefix.clone()..) {
    // rust: if !full.starts_with(&prefix) {
    // rust: break;
}
    // rust: let Some(armor) = &item.armor else { continue };
    // rust: let Some((ns, path)) = armor.material.split_once(':') else {
    // rust: continue;
}
    // rust: if !owned.contains(&ns) || !materials.insert(armor.material.clone()) {
    // rust: continue;
}
    // rust: let Some((asset, copies)) = armor.equipment() else {
    // rust: continue;
}
    // rust: for (from, to) in copies {
    // rust: if let Ok(bytes) = fs::read(inside.join(&from)) {
    // rust: write(&inside.join(to), &bytes)?;
}
}
    // rust: let text = serde_json::to_vec_pretty(&asset).unwrap_or_default();
    // rust: write(
    // rust: &inside.join(format!("assets/{ns}/equipment/{path}.json")),
    // rust: &text,
    // rust: )?;
    // rust: report.equipment += 1;
}
        // Convention tags are NeoForge's and the pack's: the recipes get the
        // members the oracle saw, those of vanilla and of this mod.
    // rust: for tag in &convention {
    // rust: let Some(path) = tag.strip_prefix("c:") else {
    // rust: continue;
}
    // rust: let file = inside.join(format!("data/c/tags/item/{path}.json"));
    // rust: if file.exists() {
    // rust: continue;
}
    // rust: if let Some(members) = facts.tag_members("item", tag, id) {
    // rust: let v = json!({"values": members});
    // rust: write(&file, &serde_json::to_vec_pretty(&v).unwrap_or_default())?;
    // rust: report.convention_tags += 1;
}
}
    // rust: } else {
    // rust: for (b, state) in &blockstates {
    // rust: match block_template(b, state) {
    // rust: Some(t) => {
    // rust: write_decl("block", b, &json!({"template": t}))?;
    // rust: report.blocks.insert(b.clone(), t.to_owned());
}
    // rust: None => {
    // rust: let props: Vec<String> = properties(state).into_iter().collect();
    // rust: let why = format!("no template for properties [{}]", props.join(", "));
    // rust: report.blocks_unknown.insert(b.clone(), why);
}
}
}
    // rust: for m in item_models.iter().filter(|m| !blockstates.contains_key(*m)) {
    // rust: write_decl("item", m, &json!({"template": "minecraft:stick"}))?;
    // rust: report.items += 1;
}
}
    // rust: let owned: Vec<String> = owned.iter().map(|n| n.to_string()).collect();
    // rust: let owned: Vec<&str> = owned.iter().map(String::as_str).collect();
    // rust: unregistered_recipes(&inside, &outside, id, &owned, &mut report)?;
    // rust: let q = |s: &str| toml::Value::String(s.to_owned()).to_string();
    // rust: let name = if info.name.is_empty() { id } else { &info.name };
    // rust: let mut manifest = format!(
    // rust: "# Carried over from {jar} by horizon-port-pack, for local use only.\n# Licence: {license}\nid = {}\nname = {}\nversion = {}\napi = \"0.2\"\nside = \"both\"\ncapabilities = [\"registries\"]\n",
    // rust: q(id),
    // rust: q(name),
    // rust: q(&info.version),
    // rust: jar = jar.file_name().unwrap_or_default().to_string_lossy(),
    // rust: license = if info.license.is_empty() {
    // rust: "not stated"
    // rust: } else {
    // rust: &info.license
    // rust: },
    // rust: );
    // rust: if !report.namespaces.is_empty() {
    // rust: let list: Vec<String> = report.namespaces.iter().map(|n| q(n)).collect();
    // rust: manifest.push_str(&format!("namespaces = [{}]\n", list.join(", ")));
}
    // rust: write(&inside.join("horizon-mod.toml"), manifest.as_bytes())?;
    // rust: write(
    // rust: &out.join("carry-report.json"),
    // rust: &serde_json::to_vec_pretty(&report).unwrap_or_default(),
    // rust: )?;
    // rust: Ok(report)
}

// The item a recipe makes: `result.id` (1.21 and later), `result.item` or a bare id.
recipe_result :: proc(recipe: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let r = &recipe["result"];
    // rust: r.as_str()
    // rust: .or_else(|| r["id"].as_str())
    // rust: .or_else(|| r["item"].as_str())
}

// Moves the recipes whose result is an undeclared item of the mod's own namespaces from
// `inside` to `outside` ([`Report::recipes_unregistered`]). The declared items are the blocks
// with their item and the items under `data/<id>/horizon/`.
    // rust: fn unregistered_recipes(
    // rust: inside: &Path,
    // rust: outside: &Path,
    // rust: id: &str,
    // rust: owned: &[&str],
    // rust: report: &mut Report,
    // rust: ) -> Result<(), String> {
    // rust: let decl = inside.join(format!("data/{id}/horizon"));
    // rust: let mut declared = BTreeSet::new();
    // rust: for kind in ["block", "item"] {
    // rust: for f in fs::read_dir(decl.join(kind))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: {
    // rust: let path = f.path();
    // rust: let Some(name) = path.file_stem().and_then(|n| n.to_str()) else {
    // rust: continue;
}
    // rust: let has_item = kind == "item"
    // rust: || fs::read(&path)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<Value>(&b).ok())
    // rust: .is_none_or(|v| v["item"] != json!(false));
    // rust: if has_item {
    // rust: declared.insert(format!("{id}:{name}"));
}
}
}
    // rust: for ns in owned {
    // rust: let dir = inside.join(format!("data/{ns}/recipe"));
    // rust: let mut stack = vec![dir.clone()];
    // rust: while let Some(d) = stack.pop() {
    // rust: for f in fs::read_dir(&d).into_iter().flatten().flatten() {
    // rust: let path = f.path();
    // rust: if path.is_dir() {
    // rust: stack.push(path);
    // rust: continue;
}
    // rust: let Some(recipe) = fs::read(&path)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<Value>(&b).ok())
    // rust: else {
    // rust: continue;
}
    // rust: let Some(result) = recipe_result(&recipe) else {
    // rust: continue;
}
    // rust: let unknown = result
    // rust: .split_once(':')
    // rust: .is_some_and(|(n, _)| owned.contains(&n) && !declared.contains(result));
    // rust: if !unknown {
    // rust: continue;
}
    // rust: let rel = path.strip_prefix(inside).map_err(|e| e.to_string())?;
    // rust: let to = outside.join(rel);
    // rust: if let Some(parent) = to.parent() {
    // rust: fs::create_dir_all(parent).map_err(|e| format!("{}: {e}", parent.display()))?;
}
    // rust: fs::rename(&path, &to).map_err(|e| format!("{}: {e}", to.display()))?;
    // rust: report.copied = report.copied.saturating_sub(1);
    // rust: report
    // rust: .recipes_unregistered
    // rust: .push(rel.to_string_lossy().into_owned());
}
}
}
    // rust: report.recipes_unregistered.sort();
    // rust: Ok(())
}

// The tags a recipe's ingredients name (`#ns:path` or `{"tag": ...}`).
tags_used :: proc(v: ^Value, out: ^BTreeSet<string>) {
}
    // rust: match v {
    // rust: Value::String(s) => {
    // rust: if let Some(t) = s.strip_prefix('#') {
    // rust: out.insert(t.to_owned());
}
}
    // rust: Value::Array(a) => a.iter().for_each(|x| tags_used(x, out)),
    // rust: Value::Object(o) => {
    // rust: for (k, x) in o {
    // rust: match (k.as_str(), x) {
    // rust: ("tag", Value::String(t)) => {
    // rust: out.insert(t.clone());
}
    // rust: ("result", _) => {}
    // rust: _ => tags_used(x, out),
}
}
}
    // rust: _ => {}
}
}

write :: proc(path: ^Path, bytes: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(dir) = path.parent() {
    // rust: fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
}
    // rust: fs::write(path, bytes).map_err(|e| format!("{}: {e}", path.display()))
}

    // rust: mod tests {
//     use super::*;
//     use std::io::Write;

recarry_invalidates_the_verdict_before_replacing_content :: proc() {
}
//         use crate::{
    // rust: inventory::Record,
    // rust: report::{self, Status},
}

    // rust: let nonce = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_nanos();
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-recarry-{}-{nonce}", std::process::id()));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let jar = dir.join("example.jar");
    // rust: let payload = br#"{"variants":{"":{"model":"example:block/stone"}}}"#;
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(&jar).unwrap());
    // rust: zip.start_file(
    // rust: "assets/example/blockstates/stone.json",
    // rust: zip::write::SimpleFileOptions::default()
    // rust: .compression_method(zip::CompressionMethod::Stored),
    // rust: )
    // rust: .unwrap();
    // rust: zip.write_all(payload).unwrap();
    // rust: zip.finish().unwrap();
    // rust: let work = dir.join("work");
    // rust: let out = work.join("mods/example");
    // rust: let verdict = out.join("harness/result.json");
    // rust: let info = crate::jar::JarInfo {
    // rust: mod_id: "example".into(),
    // rust: ..Default::default()
}
    // rust: let run = |source: &Path| {
    // rust: carry(
    // rust: source,
    // rust: &info,
    // rust: &out,
    // rust: None,
    // rust: &|_| true,
    // rust: &Pack {
    // rust: loaded: &|_| true,
    // rust: mods: &|_| false,
    // rust: },
    // rust: &BTreeMap::new(),
    // rust: )
}
    // rust: let records = [Record {
    // rust: key: "example".into(),
    // rust: class: "content".into(),
    // rust: tier: "data".into(),
    // rust: ..Default::default()
    // rust: }];
    // rust: let row = || report::build(&records, &work).pop().unwrap();
    // rust: run(&jar).unwrap();
    // rust: fs::create_dir_all(verdict.parent().unwrap()).unwrap();
    // rust: let green = br#"{"checks":{"blocks":{"passed":1,"failed":0}}}"#;
    // rust: let untouched = work.join("mods/untouched/harness/result.json");
    // rust: fs::create_dir_all(untouched.parent().unwrap()).unwrap();
    // rust: fs::write(&untouched, green).unwrap();
    // rust: for aggregate in [false, true] {
    // rust: let result = if aggregate {
    // rust: br#"{"passed":true,"checks":{"blocks":{"passed":1,"failed":0}}}"#.as_slice()
    // rust: } else {
    // rust: green.as_slice()
}
    // rust: fs::write(&verdict, result).unwrap();
    // rust: assert_eq!(row().status, Status::Ported);
    // rust: run(&jar).unwrap();
    // rust: assert_eq!(row().status, Status::Partial);
    // rust: assert!(row().reason.contains("harness not run"));
    // rust: assert!(!verdict.exists());
    // rust: assert_eq!(fs::read(&untouched).unwrap(), green);
}
    // rust: fs::write(&verdict, green).unwrap();
        // An invalid archive has not changed the old content, so its evidence stays valid.
    // rust: let bad = dir.join("invalid.jar");
    // rust: fs::write(&bad, b"not a zip").unwrap();
    // rust: assert!(run(&bad).is_err());
    // rust: assert_eq!(row().status, Status::Ported);
    // rust: assert_eq!(fs::read(&verdict).unwrap(), green);

        // Opening this ZIP succeeds, but reading its payload fails the CRC after mutation starts.
    // rust: let mut corrupt = fs::read(&jar).unwrap();
    // rust: let offset = corrupt
    // rust: .windows(payload.len())
    // rust: .position(|w| w == payload)
    // rust: .unwrap();
    // rust: corrupt[offset] ^= 1;
    // rust: fs::write(&bad, corrupt).unwrap();
    // rust: assert!(run(&bad).is_err());
    // rust: assert_eq!(row().status, Status::Partial);
    // rust: assert!(!verdict.exists());
    // rust: run(&jar).unwrap();
    // rust: fs::write(&verdict, green).unwrap();
    // rust: assert_eq!(row().status, Status::Ported);

        // An invalidation error must leave the carried content alone.
    // rust: fs::remove_file(&verdict).unwrap();
    // rust: fs::create_dir(&verdict).unwrap();
    // rust: let sentinel = out.join("carry/keep.txt");
    // rust: fs::write(&sentinel, b"keep").unwrap();
    // rust: assert!(run(&jar).is_err());
    // rust: assert_eq!(fs::read(&sentinel).unwrap(), b"keep");
    // rust: fs::remove_dir_all(&dir).unwrap();
}

    // YUNG's pools carry comments, which Minecraft's lenient reader skips;
    // the carry holds them as plain JSON. A comment marker inside a string
    // stays, and text that is not JSON without its comments is refused.
reads_json_with_comments_as_minecraft_does :: proc() {
}
    // rust: let name = "data/m/worldgen/template_pool/bridge.json";
    // rust: let mut bytes = br#"{
  // Pillar w/ chance of unlit beacon
    // rust: "elements": [ /* one */ {"weight": 20, "location": "m:a//b#c"} ], # done
    // rust: "fallback": "minecraft:empty"
    // rust: }"#
    // rust: .to_vec();
    // rust: assert_eq!(unreadable(name, &mut bytes), None);
    // rust: let v: Value = serde_json::from_slice(&bytes).unwrap();
    // rust: assert_eq!(
    // rust: v,
    // rust: json!({"elements": [{"weight": 20, "location": "m:a//b#c"}],
    // rust: "fallback": "minecraft:empty"})
    // rust: );
    // rust: let mut plain = br#"{"a": "b\"//"}"#.to_vec();
    // rust: assert_eq!(unreadable(name, &mut plain), None);
    // rust: assert_eq!(plain, br#"{"a": "b\"//"}"#.to_vec());
    // rust: let mut broken = b"{\"a\": 1} trailing".to_vec();
    // rust: assert!(
    // rust: unreadable(name, &mut broken)
    // rust: .unwrap()
    // rust: .starts_with("does not parse")
    // rust: );
}

enter_block_criteria_name_their_blocks :: proc() {
}
    // rust: let mut a = json!({"criteria": {
    // rust: "dive": {"trigger": "minecraft:enter_block",
    // rust: "conditions": {"block": "m:giant_lily_pad"}},
    // rust: "swim": {"trigger": "minecraft:enter_block",
    // rust: "conditions": {"blocks": ["minecraft:water"]}},
    // rust: "has": {"trigger": "minecraft:recipe_unlocked",
    // rust: "conditions": {"recipe": "m:boat"}}}});
    // rust: assert!(upgrade_advancement(&mut a));
    // rust: assert_eq!(
    // rust: a["criteria"]["dive"]["conditions"],
    // rust: json!({"blocks": "m:giant_lily_pad"})
    // rust: );
    // rust: assert_eq!(
    // rust: a["criteria"]["swim"]["conditions"],
    // rust: json!({"blocks": ["minecraft:water"]})
    // rust: );
    // rust: assert_eq!(
    // rust: a["criteria"]["has"]["conditions"],
    // rust: json!({"recipe": "m:boat"})
    // rust: );
        // Already 26.3's: unchanged.
    // rust: assert!(!upgrade_advancement(&mut a));
    // rust: assert!(!upgrade_advancement(&mut json!({"parent": "m:root"})));
}

upgrades_ingredients :: proc() {
}
    // rust: let mut r = json!({"type": "minecraft:crafting_shaped", "pattern": ["##"],
    // rust: "key": {"#": {"item": "gem:gem"}, "s": {"tag": "c:rods/wooden"}},
    // rust: "result": {"id": "gem:gem_block", "count": 1}});
    // rust: assert!(upgrade_recipe(&mut r));
    // rust: assert_eq!(r["key"], json!({"#": "gem:gem", "s": "#c:rods/wooden"}));
    // rust: let mut custom = json!({"type": "gem:infuse", "ingredient": {"item": "gem:gem"}});
    // rust: assert!(!upgrade_recipe(&mut custom));
    // rust: let mut tag_list = json!({"type": "minecraft:smelting",
    // rust: "ingredient": [{"tag": "c:ores"}, {"item": "gem:gem"}]});
    // rust: assert!(!upgrade_recipe(&mut tag_list));
}

upgrades_loot_tables :: proc() {
}
    // rust: let mut slab = json!({"type": "minecraft:block", "pools": [{"rolls": 1.0, "entries": [{
    // rust: "type": "minecraft:item", "name": "m:slab",
    // rust: "functions": [{"function": "minecraft:set_count", "count": 2.0, "add": false,
    // rust: "conditions": [{"condition": "minecraft:block_state_property", "block": "m:slab",
    // rust: "properties": {"type": "double"}}]},
    // rust: {"function": "minecraft:explosion_decay"}]}]}]});
    // rust: upgrade_loot(&mut slab);
    // rust: assert_eq!(
    // rust: slab["pools"][0]["entries"][0]["modifier"][0],
    // rust: json!({"type": "minecraft:set_count", "count": 2.0, "add": false,
    // rust: "condition": {"type": "minecraft:block_state_property", "block": "m:slab",
    // rust: "properties": {"type": "double"}}})
    // rust: );
    // rust: let silk = json!({"condition": "minecraft:match_tool", "predicate": {"predicates": {
    // rust: "minecraft:enchantments": [{"enchantments": "minecraft:silk_touch", "levels": {"min": 1}}]}}});
    // rust: let shears = json!({"condition": "minecraft:match_tool", "predicate": {"items": "minecraft:shears"}});
    // rust: let mut glass = json!({"pools": [{"conditions": [silk.clone()], "entries": []},
    // rust: {"conditions": [{"condition": "minecraft:any_of", "terms": [silk, shears]},
    // rust: {"condition": "minecraft:survives_explosion"}], "entries": []}]});
    // rust: upgrade_loot(&mut glass);
    // rust: assert_eq!(
    // rust: glass["pools"][0]["condition"],
    // rust: "minecraft:tool/can_silk_touch"
    // rust: );
    // rust: assert_eq!(
    // rust: glass["pools"][1]["condition"],
    // rust: json!({"type": "minecraft:all_of", "terms": [
    // rust: {"type": "minecraft:any_of", "terms": ["minecraft:tool/can_silk_touch", "minecraft:tool/can_shear"]},
    // rust: {"type": "minecraft:survives_explosion"}]})
    // rust: );
        // A loot table already in 26.3's shape stays as it is.
    // rust: let mut new = glass.clone();
    // rust: upgrade_loot(&mut new);
    // rust: assert_eq!(new, glass);
}

    // Entity predicates in 26.3's keys, as its own tables write them; the
    // 1.21 shape never matched in the game's loot code.
entity_predicates_get_26_3_keys :: proc() {
}
    // rust: let mut t = json!({"pools": [{"rolls": 1, "entries": [{"type": "minecraft:item", "name": "m:hide",
    // rust: "functions": [{"function": "minecraft:furnace_smelt", "conditions": [{
    // rust: "condition": "minecraft:entity_properties", "entity": "this",
    // rust: "predicate": {"flags": {"is_on_fire": true}}}]}],
    // rust: "conditions": [
    // rust: {"condition": "minecraft:entity_properties", "entity": "this",
    // rust: "predicate": {"type": "minecraft:cow", "vehicle": {"type": "#minecraft:boats"},
    // rust: "type_specific": {"type": "minecraft:frog", "variant": "minecraft:warm"}}},
    // rust: {"condition": "minecraft:damage_source_properties", "predicate": {
    // rust: "source_entity": {"type": "minecraft:player", "equipment": {"mainhand": {"items": "minecraft:shears"}}},
    // rust: "is_direct": true}},
    // rust: {"condition": "minecraft:entity_properties", "entity": "attacker",
    // rust: "predicate": {"type_specific": {"type": "minecraft:slime", "size": {"min": 2}}}},
    // rust: {"condition": "minecraft:entity_properties", "entity": "this",
    // rust: "predicate": {"type_specific": {"type": "sheep", "sheared": false, "color": "black"}}}
    // rust: ]}]}]});
    // rust: upgrade_loot(&mut t);
    // rust: let e = &t["pools"][0]["entries"][0];
    // rust: assert_eq!(
    // rust: e["modifier"][0]["condition"]["predicate"],
    // rust: json!({"minecraft:flags": {"is_on_fire": true}})
    // rust: );
    // rust: let c = &e["condition"]["terms"];
    // rust: assert_eq!(
    // rust: c[0]["predicate"],
    // rust: json!({"minecraft:entity_type": "minecraft:cow",
    // rust: "minecraft:vehicle": {"minecraft:entity_type": "#minecraft:boats"},
    // rust: "minecraft:components": {"minecraft:frog/variant": "minecraft:warm"}})
    // rust: );
    // rust: assert_eq!(
    // rust: c[1]["predicate"],
    // rust: json!({"source_entity": {"minecraft:entity_type": "minecraft:player",
    // rust: "minecraft:equipment": {"mainhand": {"items": "minecraft:shears"}}}, "is_direct": true})
    // rust: );
    // rust: assert_eq!(
    // rust: c[2]["predicate"],
    // rust: json!({"minecraft:type_specific/cube_mob": {"size": {"min": 2}}})
    // rust: );
    // rust: assert_eq!(
    // rust: c[3]["predicate"],
    // rust: json!({"minecraft:type_specific/sheep": {"sheared": false},
    // rust: "minecraft:components": {"minecraft:sheep/color": "black"}})
    // rust: );
        // Already 26.3's shape: unchanged.
    // rust: let again = t.clone();
    // rust: upgrade_loot(&mut t);
    // rust: assert_eq!(t, again);
}

types_bare_number_ranges :: proc() {
}
        // When Dungeons Arise's and Structory's chests: rolls and counts as
        // bare ranges, nested in each other or in a binomial.
    // rust: let mut chest = json!({"pools": [{"rolls": {"min": 1, "max": 2}, "bonus_rolls": 0,
    // rust: "entries": [{"type": "minecraft:item", "name": "minecraft:cod", "functions": [
    // rust: {"function": "minecraft:set_count", "count": {"min": 3, "max": {"min": 5, "max": 7}}},
    // rust: {"function": "minecraft:enchant_with_levels", "levels": {"type": "minecraft:binomial",
    // rust: "n": {"min": 1, "max": 3}, "p": 0.5}},
    // rust: {"function": "minecraft:limit_count", "limit": {"min": {"min": 0, "max": 1}, "max": 4}},
    // rust: {"function": "minecraft:set_count", "count": 2,
    // rust: "conditions": [{"condition": "minecraft:match_tool",
    // rust: "predicate": {"count": {"min": 1, "max": 3}}}]}]}]}]});
    // rust: upgrade_loot(&mut chest);
    // rust: let uniform =
    // rust: |min: Value, max: Value| json!({"type": "minecraft:uniform", "min": min, "max": max});
    // rust: let pool = &chest["pools"][0];
    // rust: assert_eq!(pool["rolls"], uniform(json!(1), json!(2)));
    // rust: assert_eq!(pool["bonus_rolls"], 0);
    // rust: let modifiers = &pool["entries"][0]["modifier"];
    // rust: assert_eq!(
    // rust: modifiers[0]["count"],
    // rust: uniform(json!(3), uniform(json!(5), json!(7)))
    // rust: );
    // rust: assert_eq!(modifiers[1]["levels"]["n"], uniform(json!(1), json!(3)));
        // A range stays a range; its bounds are providers.
    // rust: assert_eq!(
    // rust: modifiers[2]["limit"],
    // rust: json!({"min": uniform(json!(0), json!(1)), "max": 4})
    // rust: );
        // An item predicate's count is a range too.
    // rust: assert_eq!(
    // rust: modifiers[3]["condition"]["predicate"]["count"],
    // rust: json!({"min": 1, "max": 3})
    // rust: );
        // Already typed, it stays as it is.
    // rust: let mut again = chest.clone();
    // rust: upgrade_loot(&mut again);
    // rust: assert_eq!(again, chest);
}

renames_ids_vanilla_renamed :: proc() {
}
    // rust: let mut recipe = json!({"type": "minecraft:crafting_shaped", "pattern": ["c"],
    // rust: "key": {"c": {"item": "minecraft:chain"}}, "result": {"id": "m:sign", "count": 1}});
    // rust: assert!(renamed_ids(&mut recipe));
    // rust: assert_eq!(recipe["key"]["c"]["item"], "minecraft:iron_chain");
    // rust: let mut rule = json!({"input_predicate": {"predicate_type": "minecraft:block_match",
    // rust: "block": "minecraft:chain"}, "output_state": {"id": "minecraft:chain",
    // rust: "properties": {"axis": "y"}}});
    // rust: assert!(renamed_ids(&mut rule));
    // rust: assert_eq!(rule["input_predicate"]["block"], "minecraft:iron_chain");
    // rust: assert_eq!(rule["output_state"]["id"], "minecraft:iron_chain");
        // Only whole ids: other blocks and mods' own chains stay.
    // rust: let mut other = json!([
    // rust: "minecraft:chain_command_block",
    // rust: "m:chain",
    // rust: "minecraft:iron_chain"
    // rust: ]);
    // rust: assert!(!renamed_ids(&mut other));
}

variant_models_are_the_ones_a_base_model_reaches :: proc() {
}
    // rust: let overrides = |edges: &[(&str, &str)]| {
    // rust: let mut map: BTreeMap<String, BTreeSet<String>> = BTreeMap::new();
    // rust: for (from, to) in edges {
    // rust: map.entry((*from).into()).or_default().insert((*to).into());
}
    // rust: map
}
    // rust: let names = |set: BTreeSet<String>| set.into_iter().collect::<Vec<_>>();
    // rust: assert_eq!(
    // rust: names(variant_models(&overrides(&[
    // rust: ("gem", "glow"),
    // rust: ("glow", "bright")
    // rust: ]))),
    // rust: ["bright", "glow"]
    // rust: );
    // rust: assert!(variant_models(&overrides(&[("a", "b"), ("b", "a")])).is_empty());
    // rust: assert!(variant_models(&BTreeMap::new()).is_empty());
}

templates_from_blockstate_properties :: proc() {
}
    // rust: let door =
    // rust: json!({"variants": {"facing=east,half=lower,hinge=left,open=false,powered=false": {}}});
    // rust: assert_eq!(
    // rust: template("gem_door", &properties(&door)),
    // rust: Some("minecraft:oak_door")
    // rust: );
        // Models that ignore `powered`: still a door.
    // rust: let door = json!({"variants": {"facing=east,half=lower,hinge=left,open=false": {}}});
    // rust: assert_eq!(
    // rust: template("gem_door", &properties(&door)),
    // rust: Some("minecraft:oak_door")
    // rust: );
    // rust: let trapdoor = json!({"variants": {"facing=east,half=top,open=false": {}}});
    // rust: assert_eq!(
    // rust: template("gem_trapdoor", &properties(&trapdoor)),
    // rust: Some("minecraft:oak_trapdoor")
    // rust: );
    // rust: let sides = json!({"multipart": [{"when": {"north": "true"}}, {"when": {"east": "true"}},
    // rust: {"when": {"south": "true"}}, {"when": {"west": "true"}}]});
    // rust: assert_eq!(
    // rust: template("gem_pane", &properties(&sides)),
    // rust: Some("minecraft:glass_pane")
    // rust: );
    // rust: assert_eq!(
    // rust: template("gem_fence", &properties(&sides)),
    // rust: Some("minecraft:oak_fence")
    // rust: );
    // rust: let fence = json!({"multipart": [{"apply": {}}, {"when": {"north": "true"}, "apply": {}},
    // rust: {"when": {"east": "true"}}, {"when": {"south": "true"}}, {"when": {"west": "true"}},
    // rust: {"when": {"OR": [{"waterlogged": "true"}]}}]});
    // rust: assert_eq!(
    // rust: template("gem_fence", &properties(&fence)),
    // rust: Some("minecraft:oak_fence")
    // rust: );
    // rust: assert_eq!(
    // rust: template("gem_block", &properties(&json!({"variants": {"": {}}}))),
    // rust: Some("minecraft:stone")
    // rust: );
        // Walls and vines have the same sides and up; their values tell them apart.
    // rust: let wall = json!({"multipart": [{"when": {"up": "true"}},
    // rust: {"when": {"north": "low"}}, {"when": {"east": "tall"}},
    // rust: {"when": {"south": "low"}}, {"when": {"west": "low"}}]});
    // rust: assert_eq!(
    // rust: block_template("gem_wall", &wall),
    // rust: Some("minecraft:cobblestone_wall")
    // rust: );
    // rust: let vine = json!({"multipart": [{"when": {"up": "true"}},
    // rust: {"when": {"up": "false", "north": "false", "east": "false", "south": "false",
    // rust: "west": "false"}}, {"when": {"north": "true"}}]});
    // rust: assert_eq!(block_template("gem_vine", &vine), Some("minecraft:vine"));
    // rust: let odd = json!({"variants": {"charge=1,mode=fast": {}}});
    // rust: assert_eq!(template("gem_core", &properties(&odd)), None);
}

    // A small NeoForge jar carried over is a content mod Horizon loads.
carried_jar_is_a_content_mod :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-port-pack-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let jar = dir.join("gem-1.0.jar");
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(&jar).unwrap());
    // rust: let files: &[(&str, &str)] = &[
    // rust: (
    // rust: "META-INF/neoforge.mods.toml",
    // rust: "license = \"MIT\"\n[[mods]]\nmodId = \"gem\"\nversion = \"1.0\"\ndisplayName = \"Gem\"\n",
    // rust: ),
    // rust: ("com/example/gem/Gem.class", "not real bytecode"),
    // rust: (
    // rust: "assets/gem/blockstates/gem_block.json",
    // rust: r#"{"variants": {"": {"model": "gem:block/gem_block"}}}"#,
    // rust: ),
    // rust: (
    // rust: "assets/gem/blockstates/gem_door.json",
    // rust: r#"{"variants": {"facing=east,half=lower,hinge=left,open=false,powered=false": {"model": "gem:block/gem_door"}}}"#,
    // rust: ),
    // rust: (
    // rust: "assets/gem/blockstates/gem_core.json",
    // rust: r#"{"variants": {"charge=1": {"model": "gem:block/gem_core"}}}"#,
    // rust: ),
    // rust: (
    // rust: "assets/gem/models/item/gem.json",
    // rust: r#"{"parent": "minecraft:item/generated", "textures": {"layer0": "gem:item/gem"},
    // rust: "overrides": [{"predicate": {"minecraft:trim_type": 0.1}, "model": "gem:item/gem_glowing"}]}"#,
    // rust: ),
            // A look the gem's model switches to, not an item of its own.
    // rust: (
    // rust: "assets/gem/models/item/gem_glowing.json",
    // rust: r#"{"parent": "gem:item/gem"}"#,
    // rust: ),
    // rust: (
    // rust: "assets/gem/models/item/gem_block.json",
    // rust: r#"{"parent": "gem:block/gem_block"}"#,
    // rust: ),
    // rust: ("assets/gem/textures/item/gem.png", "png"),
    // rust: ("assets/gem/lang/en_us.json", r#"{"item.gem.gem": "Gem"}"#),
    // rust: (
    // rust: "data/gem/recipe/gem_block.json",
    // rust: r####"{"type": "minecraft:crafting_shaped", "pattern": ["###", "###", "###"],
    // rust: "key": {"#": {"item": "gem:gem"}}, "result": {"id": "gem:gem_block", "count": 1}}"####,
    // rust: ),
    // rust: (
    // rust: "data/gem/recipe/infuse.json",
    // rust: r#"{"type": "gem:infuse", "ingredient": {"item": "gem:gem"}}"#,
    // rust: ),
    // rust: (
    // rust: "data/gem/loot_table/blocks/gem_block.json",
    // rust: r#"{"type": "minecraft:block", "pools": []}"#,
    // rust: ),
    // rust: (
    // rust: "data/minecraft/tags/block/mineable/pickaxe.json",
    // rust: r#"{"values": ["gem:gem_block"]}"#,
    // rust: ),
    // rust: ("data/c/tags/item/gems.json", r#"{"values": ["gem:gem"]}"#),
    // rust: (
    // rust: "data/gem/lithostitched/worldgen_modifier/houses.json",
    // rust: r#"{"type": "lithostitched:add_template_pool_elements",
    // rust: "template_pools": "minecraft:village/plains/houses",
    // rust: "elements": [{"weight": 2, "element": {"element_type": "minecraft:single_pool_element",
    // rust: "location": "gem:hut", "projection": "rigid",
    // rust: "processors": {"processors": [{"processor_type": "lithostitched:block_swap"}]}}}]}"#,
    // rust: ),
    // rust: (
    // rust: "data/minecraft/tags/worldgen/biome/has_structure/village_plains.json",
    // rust: r#"{"replace": true, "values": []}"#,
    // rust: ),
            // What the game would refuse: vanilla skips these files alone.
    // rust: ("assets/gem/lang/ry_UA.json", r#"{"item.gem.gem": "Gem"}"#),
    // rust: ("data/gem/tags/item/empty.json", ""),
    // rust: (
    // rust: "assets/gem/lang/de_de.json",
    // rust: "\u{feff}{\"item.gem.gem\": \"Juwel\"}",
    // rust: ),
    // rust: ];
    // rust: for (name, text) in files {
    // rust: zip.start_file(*name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(text.as_bytes()).unwrap();
}
    // rust: zip.finish().unwrap();

    // rust: let info = crate::jar::read(&jar).unwrap();
    // rust: assert_eq!(
    // rust: (info.mod_id.as_str(), info.license.as_str()),
    // rust: ("gem", "MIT")
    // rust: );
    // rust: assert_eq!(info.census.classes, 1);
    // rust: let out = dir.join("work/mods/gem");
    // rust: let report = carry(
    // rust: &jar,
    // rust: &info,
    // rust: &out,
    // rust: None,
    // rust: &|_| true,
    // rust: &Pack {
    // rust: loaded: &|_| true,
    // rust: mods: &|_| false,
    // rust: },
    // rust: &BTreeMap::new(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(report.copied, 16);
    // rust: let unreadable: Vec<&str> = report.unreadable.keys().map(String::as_str).collect();
    // rust: assert_eq!(
    // rust: unreadable,
    // rust: [
    // rust: "assets/gem/lang/ry_UA.json",
    // rust: "data/gem/tags/item/empty.json"
    // rust: ]
    // rust: );
    // rust: assert_eq!(report.outside.len(), 2);
        // A vanilla tag that replaces is kept as it is: the game honours it.
    // rust: let replacing: Value = serde_json::from_slice(
    // rust: &fs::read(out.join(
    // rust: "carry/data/minecraft/tags/worldgen/biome/has_structure/village_plains.json",
    // rust: ))
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(replacing, json!({"replace": true, "values": []}));
    // rust: assert!(!out.join("carry/data/gem/tags/item/empty.json").exists());
        // A byte-order mark is dropped, the file kept.
    // rust: assert_eq!(
    // rust: fs::read(out.join("carry/assets/gem/lang/de_de.json")).unwrap()[0],
    // rust: b'{'
    // rust: );
    // rust: assert_eq!((report.recipes_upgraded, report.recipes_kept.len()), (1, 1));
    // rust: assert_eq!(report.item_definitions_added, 2);
    // rust: assert_eq!(report.blocks["gem_door"], "minecraft:oak_door");
    // rust: assert_eq!(report.blocks["gem_block"], "minecraft:stone");
    // rust: assert_eq!(
    // rust: report.blocks_unknown.keys().collect::<Vec<_>>(),
    // rust: ["gem_core"]
    // rust: );
    // rust: assert_eq!(report.items, 1);
    // rust: let carried = out.join("carry");
    // rust: assert!(!carried.join("com").exists());
    // rust: let recipe: Value = serde_json::from_slice(
    // rust: &fs::read(carried.join("data/gem/recipe/gem_block.json")).unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(recipe["key"]["#"], "gem:gem");
        // A lithostitched pool addition, as a file the game merges, upgraded
        // as the mod's own pools are.
    // rust: let added: Value = serde_json::from_slice(
    // rust: &fs::read(carried.join("data/gem/worldgen/template_pool/horizon_added/houses.json"))
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: added["horizon:add_to"],
    // rust: json!(["minecraft:village/plains/houses"])
    // rust: );
    // rust: assert_eq!(
    // rust: added["elements"][0]["element"]["processors"],
    // rust: json!({"processors": []})
    // rust: );
    // rust: assert_eq!(
    // rust: report.worldgen_types.added_to["minecraft:village/plains/houses"],
    // rust: 1
    // rust: );

        // Horizon's own reader accepts it: blocks and items declared, files fenced.
    // rust: let package = horizon_mods::Package::read(&carried).unwrap();
    // rust: let content = horizon_mods::Content::read(&carried, &package.manifest).unwrap();
    // rust: let blocks: Vec<&str> = content.blocks.iter().map(|b| b.id.as_str()).collect();
    // rust: assert_eq!(blocks, ["gem:gem_block", "gem:gem_door"]);
    // rust: assert_eq!(content.items.len(), 1);
    // rust: assert_eq!(content.items[0].id, "gem:gem");
    // rust: fs::remove_dir_all(&dir).unwrap();
}

    // A mod shipping its files under other names than its id: the
    // namespaces its own files name are its, compat files for other mods
    // and a pack mod's namespace stay outside.
claims_the_namespaces_its_files_name :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-port-pack-ns-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let jar = dir.join("towers-1.0.jar");
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(&jar).unwrap());
    // rust: let files: &[(&str, &str)] = &[
    // rust: (
    // rust: "META-INF/neoforge.mods.toml",
    // rust: "license = \"MIT\"\n[[mods]]\nmodId = \"towers\"\nversion = \"1.0\"\n",
    // rust: ),
            // Its tag addition names its structure; the structure names its pool.
    // rust: (
    // rust: "data/minecraft/tags/worldgen/structure/village.json",
    // rust: r#"{"values": ["towers_wg:tower"]}"#,
    // rust: ),
    // rust: (
    // rust: "data/towers_wg/worldgen/structure/tower.json",
    // rust: r#"{"type": "minecraft:jigsaw", "start_pool": "kaisyn:tower/start"}"#,
    // rust: ),
    // rust: ("data/kaisyn/structure/tower.nbt", "nbt"),
    // rust: (
    // rust: "data/towers_wg/tags/worldgen/biome/has_tower.json",
    // rust: r#"{"replace": true, "values": ["minecraft:plains"]}"#,
    // rust: ),
    // rust: (
    // rust: "assets/kaisyn/blockstates/brick.json",
    // rust: r#"{"variants": {}}"#,
    // rust: ),
            // Compat for a mod outside the pack, named by nothing of its own.
    // rust: ("data/wares/loot_table/crate.json", r#"{"pools": []}"#),
            // A pack mod's config naming the mod's sets, and a loader's file.
    // rust: (
    // rust: "data/cristel/config/towers.json",
    // rust: r#"{"sets": ["towers_wg:towns"]}"#,
    // rust: ),
    // rust: (
    // rust: "data/neoforge/loot_modifiers/global.json",
    // rust: r#"{"entries": ["towers_wg:x"]}"#,
    // rust: ),
    // rust: ];
    // rust: for (name, text) in files {
    // rust: zip.start_file(*name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(text.as_bytes()).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: let info = crate::jar::read(&jar).unwrap();
    // rust: let out = dir.join("work/mods/towers");
    // rust: let pack = Pack {
    // rust: loaded: &|_| true,
    // rust: mods: &|m| m == "cristel",
}
    // rust: let report = carry(&jar, &info, &out, None, &|_| true, &pack, &BTreeMap::new()).unwrap();
    // rust: assert_eq!(report.namespaces, ["kaisyn", "towers_wg"]);
    // rust: assert_eq!(report.worldgen, 2);
    // rust: assert_eq!(
    // rust: report.outside,
    // rust: [
    // rust: "data/wares/loot_table/crate.json",
    // rust: "data/cristel/config/towers.json",
    // rust: "data/neoforge/loot_modifiers/global.json",
    // rust: ]
    // rust: );
        // No block is declared from another namespace's blockstate.
    // rust: assert!(report.blocks.is_empty());
    // rust: let carried = out.join("carry");
    // rust: let package = horizon_mods::Package::read(&carried).unwrap();
    // rust: assert_eq!(package.manifest.namespaces, ["kaisyn", "towers_wg"]);
    // rust: let content = horizon_mods::Content::read(&carried, &package.manifest).unwrap();
    // rust: assert!(
    // rust: content
    // rust: .files
    // rust: .contains(&"data/kaisyn/structure/tower.nbt".to_owned())
    // rust: );
    // rust: assert!(content.blocks.is_empty());
        // Its own tag that replaces is the same tag added to.
    // rust: let tag: Value = serde_json::from_slice(
    // rust: &fs::read(carried.join("data/towers_wg/tags/worldgen/biome/has_tower.json")).unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(tag, json!({"values": ["minecraft:plains"]}));
    // rust: fs::remove_dir_all(&dir).unwrap();
}

    // Overrides make looks of the mod's own models only, and never of an item it registers.
override_targets_lose_their_definition_only_when_they_are_looks :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-port-pack-looks-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let jar = dir.join("gem-1.0.jar");
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(&jar).unwrap());
    // rust: for (name, text) in [
    // rust: (
    // rust: "META-INF/neoforge.mods.toml",
    // rust: "license = \"MIT\"\n[[mods]]\nmodId = \"gem\"\nversion = \"1.0\"\n",
    // rust: ),
    // rust: (
    // rust: "assets/gem/models/item/gem.json",
    // rust: r#"{"overrides": [{"model": "gem:item/look"}, {"model": "gem:item/shard"},
    // rust: {"model": "minecraft:item/vanilla_named"}, {"model": "item/unqualified"},
    // rust: {"model": "other:item/foreign"}]}"#,
    // rust: ),
    // rust: ("assets/gem/models/item/look.json", "{}"),
    // rust: ("assets/gem/models/item/shard.json", "{}"),
    // rust: ("assets/gem/models/item/vanilla_named.json", "{}"),
    // rust: ("assets/gem/models/item/unqualified.json", "{}"),
    // rust: ("assets/gem/models/item/foreign.json", "{}"),
    // rust: (
    // rust: "assets/gem/models/item/left.json",
    // rust: r#"{"overrides": [{"model": "gem:item/right"}]}"#,
    // rust: ),
    // rust: (
    // rust: "assets/gem/models/item/right.json",
    // rust: r#"{"overrides": [{"model": "gem:item/left"}]}"#,
    // rust: ),
    // rust: ] {
    // rust: zip.start_file(name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(text.as_bytes()).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: let info = crate::jar::read(&jar).unwrap();
    // rust: let pack = Pack {
    // rust: loaded: &|_| true,
    // rust: mods: &|_| false,
}
    // rust: let facts: Facts = serde_json::from_value(json!({"blocks": {}, "items": {
    // rust: "gem:shard": {"class": "net.minecraft.world.item.Item", "max_stack_size": 64, "rarity": "common"}}}))
    // rust: .unwrap();
    // rust: let defined = |out: &Path, m: &str| {
    // rust: out.join(format!("carry/assets/gem/items/{m}.json"))
    // rust: .exists()
}
    // rust: let out = dir.join("with-facts");
    // rust: carry(
    // rust: &jar,
    // rust: &info,
    // rust: &out,
    // rust: Some(&facts),
    // rust: &|_| true,
    // rust: &pack,
    // rust: &BTreeMap::new(),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(!defined(&out, "look"));
    // rust: for m in [
    // rust: "gem",
    // rust: "shard",
    // rust: "vanilla_named",
    // rust: "unqualified",
    // rust: "foreign",
    // rust: "left",
    // rust: "right",
    // rust: ] {
    // rust: assert!(defined(&out, m), "{m}");
}
    // rust: let out = dir.join("no-facts");
    // rust: carry(&jar, &info, &out, None, &|_| true, &pack, &BTreeMap::new()).unwrap();
    // rust: assert!(!defined(&out, "look"));
    // rust: assert!(!defined(&out, "shard"));
    // rust: assert!(defined(&out, "left") && defined(&out, "right"));
    // rust: fs::remove_dir_all(&dir).unwrap();
}

    // A jar entry whose name escapes through a Windows separator writes
    // nothing: not into `carry`, not into `outside`, nowhere.
entry_names_cannot_escape_the_output :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-port-pack-esc-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let jar = dir.join("evil-1.0.jar");
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(&jar).unwrap());
    // rust: for (name, text) in [
    // rust: (
    // rust: "META-INF/neoforge.mods.toml",
    // rust: "license = \"MIT\"\n[[mods]]\nmodId = \"evil\"\nversion = \"1.0\"\n",
    // rust: ),
    // rust: ("data/evil/recipe/..\\..\\..\\evil.json", "{}"),
    // rust: ] {
    // rust: zip.start_file(name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(text.as_bytes()).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: let info = crate::jar::read(&jar).unwrap();
    // rust: let out = dir.join("work/mods/evil");
    // rust: let pack = Pack {
    // rust: loaded: &|_| true,
    // rust: mods: &|_| false,
}
    // rust: let report = carry(&jar, &info, &out, None, &|_| true, &pack, &BTreeMap::new()).unwrap();
    // rust: assert_eq!(report.copied, 0);
    // rust: assert!(report.outside.is_empty());
    // rust: assert!(!dir.join("evil.json").exists());
    // rust: fs::remove_dir_all(&dir).unwrap();
}
}
