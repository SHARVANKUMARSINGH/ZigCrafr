//! Transpiled from Horizon Rust crate
package horizon_items_enchant

import "core:fmt"
import "core:mem"
import "core:math"

// Data-driven enchantments (`data/minecraft/enchantment/*.json`): the
// registry, ordered enchantment tags, `EnchantmentHelper` selection and cost
// rules used by the enchanting table, display names, and evaluation of the
// value/attribute effect components (`LevelBasedValue`, `EnchantmentValueEffect`
// and the loot-condition subset that enchantment requirements use).
// use crate::items::{ItemStack, Items};
// use horizon_core::random::{LegacyRandom, RandomSource};
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, HashMap, HashSet},
    // rust: path::Path,
    // rust: sync::{
    // rust: Arc,
    // rust: atomic::{AtomicBool, Ordering},
    // rust: },
}

// Levels as numbers in enchantment names ("Sharpness 5"): Horizon's PvP & HUD option, off by
// default (vanilla's numerals).
NUMERIC_LEVELS :: AtomicBool::new(false)
set_numeric_levels :: proc(on: bool) {
}
    // rust: NUMERIC_LEVELS.store(on, Ordering::Relaxed);
}

// `Enchantment.Cost`: base + per_level_above_first * (level - 1).
Cost :: struct {
    base: i32,
    per_level: i32,
}
    // rust: impl Cost {
parse :: proc(v: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: base: v["base"].as_i64().unwrap_or(1) as i32,
    // rust: per_level: v["per_level_above_first"].as_i64().unwrap_or(0) as i32,
}
}
calculate :: proc(self: ^Self, level: u32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.base + self.per_level * (level as i32 - 1)
}
}
Enchantment :: struct {
    id: ^str,
    // The name the pinned English map gave at load: the fallback for a
    // language that has no entry for the key below.
    description: string,
    // `description`'s translation key (`enchantment.minecraft.<name>`).
    description_key: string,
    max_level: u32,
    weight: u32,
    anvil_cost: u32,
    min_cost: Cost,
    max_cost: Cost,
    // `supported_items` / `primary_items`: item ids or `#tags`.
    supported: [dynamic]string,
    primary: Maybe([dynamic]string),
    exclusive: map[^str]struct{},
    slots: [dynamic]string,
    effects: Value,
}
// Item components the enchanting, anvil and smithing rules read.
ItemProps :: struct {
    // `minecraft:enchantable.value`.
    enchantable: u32,
    // `minecraft:repairable.items` (ids or a `#tag`).
    repairable: [dynamic]string,
    glint: bool,
    rarity: string,
    // `minecraft:provides_trim_material`.
    trim_material: Maybe(string),
    // `minecraft:brewing_fuel` present.
    brewing_fuel: bool,
}
Enchantments :: struct {
    list: [dynamic]Enchantment,
    index: HashMap<^str,
    // Enchantment tags in vanilla `HolderSet` order (nested tags expanded in place).
    tags: HashMap<string,
    entity_tags: HashMap<string,
    damage_tags: HashMap<string,
    props: HashMap<^str,
    lang: HashMap<string,
}

string_list :: proc(v: ^Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::String(s) => vec![s.clone()],
    // rust: Value::Array(a) => a
    // rust: .iter()
    // rust: .filter_map(|e| e.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: _ => vec![],
}
}
read_tag_dir :: proc(dir: ^Path) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(folder) = horizon_world::json_folder::read(dir) else {
    // rust: return HashMap::new();
}
    // rust: folder
    // rust: .files
    // rust: .iter()
    // rust: .filter_map(|file| {
    // rust: let v = serde_json::from_slice::<Value>(file.bytes().ok()?).ok()?;
    // rust: let values = v["values"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|e| e.as_str().or_else(|| e["id"].as_str()).map(str::to_owned))
    // rust: .collect();
    // rust: Some((format!("minecraft:{}", file.name), values))
    // rust: })
    // rust: .collect()
}
// Expand a tag keeping first-seen order (`TagLoader` builds a linked set).
    // rust: fn expand_ordered(
    // rust: name: &str,
    // rust: raw: &HashMap<String, Vec<String>>,
    // rust: out: &mut Vec<String>,
    // rust: depth: u32,
    // rust: ) {
    // rust: if depth > 16 {
    // rust: return;
}
    // rust: for v in raw.get(name).into_iter().flatten() {
    // rust: match v.strip_prefix('#') {
    // rust: Some(t) => expand_ordered(t, raw, out, depth + 1),
    // rust: None if !out.contains(v) => out.push(v.clone()),
    // rust: None => {}
}
}
}
// Roman numerals as in `enchantment.level.N` (falls back to the number).
level_name :: proc(level: u32) -> S {
    // Ported from Horizon
    return {}
}
NAMES :: ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"]
    // rust: NAMES
    // rust: .get(level.wrapping_sub(1) as usize)
    // rust: .map_or_else(|| level.to_string(), |s| (*s).to_owned())
}

// One registry entry from its definition (`Enchantment.DIRECT_CODEC`).
    // rust: fn parse_entry(
    // rust: id: &str,
    // rust: v: &Value,
    // rust: tags: &HashMap<String, Vec<Arc<str>>>,
    // rust: lang: &HashMap<String, String>,
    // rust: ) -> Enchantment {
    // rust: let exclusive = match &v["exclusive_set"] {
    // rust: Value::String(s) if s.starts_with('#') => tags.get(&s[1..]).cloned().unwrap_or_default(),
    // rust: other => string_list(other)
    // rust: .into_iter()
    // rust: .map(|s| Arc::from(s.as_str()))
    // rust: .collect(),
}
    // rust: let key = v["description"]["translate"].as_str().unwrap_or("");
    // rust: Enchantment {
    // rust: id: Arc::from(id),
    // rust: description: lang.get(key).cloned().unwrap_or_else(|| {
            // A data pack's entry may name itself with a literal component
            // rather than a translation key.
    // rust: if key.is_empty() && !v["description"].is_null() {
    // rust: horizon_client_core::scoreboard::comp_text(&v["description"]).plain()
    // rust: } else {
    // rust: id.trim_start_matches("minecraft:").replace('_', " ")
}
    // rust: }),
    // rust: description_key: key.to_owned(),
    // rust: max_level: v["max_level"].as_u64().unwrap_or(1) as u32,
    // rust: weight: v["weight"].as_u64().unwrap_or(1) as u32,
    // rust: anvil_cost: v["anvil_cost"].as_u64().unwrap_or(0) as u32,
    // rust: min_cost: Cost::parse(&v["min_cost"]),
    // rust: max_cost: Cost::parse(&v["max_cost"]),
    // rust: supported: string_list(&v["supported_items"]),
    // rust: primary: v.get("primary_items").map(string_list),
    // rust: exclusive: exclusive.into_iter().collect(),
    // rust: slots: string_list(&v["slots"]),
    // rust: effects: v["effects"].clone(),
}
}

    // rust: impl Enchantments {
    // Use the same frozen registry and resolved tags as player damage.
bind_damage_catalog :: proc(self: ^Self, catalog: ^horizon_world::damage_source::Catalog) {
}
    // rust: self.damage_tags = catalog
    // rust: .tags()
    // rust: .map(|tag| {
    // rust: (
    // rust: tag.to_owned(),
    // rust: catalog.tag_members(tag).map(str::to_owned).collect(),
    // rust: )
    // rust: })
    // rust: .collect();
}
load :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::load_with(root, &horizon_world::loot::PackOverlay::NONE)
}
    // Load from a resource root; `overlay` (a world's data packs' content
    // files) joins the game's own enchantment tags in pack order, a
    // `replace` file dropping the lower sources' (`TagLoader.load`).
load_with :: proc(root: ^Path, overlay: ^horizon_world::loot::PackOverlay) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let data = root.join("data/minecraft");
    // rust: let mut raw_tags = read_tag_dir(&data.join("tags/enchantment"));
    // rust: for (id, files) in overlay.tag_kind("enchantment") {
    // rust: let slot = raw_tags.entry(id).or_default();
    // rust: for bytes in files {
    // rust: let Ok(v) = serde_json::from_slice::<Value>(bytes) else {
    // rust: continue;
}
    // rust: if v["replace"].as_bool() == Some(true) {
    // rust: slot.clear();
}
    // rust: if let Some(values) = v["values"].as_array() {
    // rust: slot.extend(
    // rust: values
    // rust: .iter()
    // rust: .filter_map(|e| e.as_str().or_else(|| e["id"].as_str()))
    // rust: .map(str::to_owned),
    // rust: );
}
}
}
    // rust: let tags: HashMap<String, Vec<Arc<str>>> = raw_tags
    // rust: .keys()
    // rust: .map(|k| {
    // rust: let mut v = Vec::new();
    // rust: expand_ordered(k, &raw_tags, &mut v, 0);
    // rust: (
    // rust: k.clone(),
    // rust: v.into_iter().map(|s| Arc::from(s.as_str())).collect(),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let unordered = |raw: HashMap<String, Vec<String>>| -> HashMap<String, HashSet<String>> {
    // rust: raw.keys()
    // rust: .map(|k| {
    // rust: let mut v = Vec::new();
    // rust: expand_ordered(k, &raw, &mut v, 0);
    // rust: (k.clone(), v.into_iter().collect())
    // rust: })
    // rust: .collect()
}
    // rust: let entity_tags = unordered(read_tag_dir(&data.join("tags/entity_type")));
    // rust: let damage_tags = match horizon_world::damage_source::Catalog::load(root, overlay) {
    // rust: Ok(catalog) => catalog
    // rust: .tags()
    // rust: .map(|tag| {
    // rust: (
    // rust: tag.to_owned(),
    // rust: catalog.tag_members(tag).map(str::to_owned).collect(),
    // rust: )
    // rust: })
    // rust: .collect(),
            // Small tools/fixtures may not carry the prepared catalog.
    // rust: Err(_) => unordered(read_tag_dir(&data.join("tags/damage_type"))),
}
        // The registry lists entries sorted by id, like the data-pack loader.
    // rust: let mut files: BTreeMap<String, Value> = BTreeMap::new();
        // The folder's own files, not its subfolders'.
    // rust: if let Ok(folder) = horizon_world::json_folder::read(&data.join("enchantment")) {
    // rust: for file in folder.files.iter().filter(|f| !f.name.contains('/')) {
    // rust: if let Ok(v) = serde_json::from_slice(file.bytes().unwrap_or_default()) {
    // rust: files.insert(format!("minecraft:{}", file.name), v);
}
}
}
    // rust: let lang: HashMap<String, String> =
    // rust: horizon_core::prepared_files::read(&root.join("assets/minecraft/lang/en_us.json"))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<HashMap<String, String>>(&b).ok())
    // rust: .unwrap_or_default()
    // rust: .into_iter()
    // rust: .filter(|(k, _)| {
    // rust: k.starts_with("enchantment.")
    // rust: || k.starts_with("attribute.")
    // rust: || k.starts_with("item.modifiers.")
    // rust: || k.starts_with("effect.")
    // rust: || k.starts_with("item.minecraft.potion")
    // rust: || k.starts_with("item.minecraft.splash_potion")
    // rust: || k.starts_with("item.minecraft.lingering_potion")
    // rust: || k.starts_with("item.minecraft.tipped_arrow")
    // rust: || k.starts_with("item.minecraft.firework_rocket.")
    // rust: || k.starts_with("item.minecraft.firework_star.")
    // rust: || k.starts_with("trim_")
    // rust: || k.starts_with("potion.")
    // rust: || k.starts_with("container.")
    // rust: || k.starts_with("merchant.")
    // rust: || k.starts_with("entity.minecraft.")
    // rust: || k.starts_with("gui.recipebook.")
    // rust: || k.starts_with("gui.togglable_slot")
    // rust: || k.starts_with("block.minecraft.banner.")
    // rust: || k.starts_with("recipe.toast.")
    // rust: })
    // rust: .collect();
    // rust: let list = files
    // rust: .iter()
    // rust: .map(|(id, v)| parse_entry(id, v, &tags, &lang))
    // rust: .collect::<Vec<_>>();
    // rust: let index = list
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, e)| (e.id.clone(), i))
    // rust: .collect();
    // rust: let mut props = HashMap::new();
    // rust: if let Ok(raw) = horizon_world::item_defaults::read(root) {
    // rust: for (id, c) in raw {
    // rust: props.insert(
    // rust: Arc::from(id.as_str()),
    // rust: ItemProps {
    // rust: enchantable: c["minecraft:enchantable"]["value"].as_u64().unwrap_or(0)
    // rust: as u32,
    // rust: repairable: string_list(&c["minecraft:repairable"]["items"]),
    // rust: glint: c["minecraft:enchantment_glint_override"]
    // rust: .as_bool()
    // rust: .unwrap_or(false),
    // rust: rarity: c["minecraft:rarity"]
    // rust: .as_str()
    // rust: .unwrap_or("common")
    // rust: .to_owned(),
    // rust: trim_material: c["minecraft:provides_trim_material"]
    // rust: .as_str()
    // rust: .map(str::to_owned),
    // rust: brewing_fuel: c.get("minecraft:brewing_fuel").is_some(),
    // rust: },
    // rust: );
}
}
    // rust: Self {
    // rust: list,
    // rust: index,
    // rust: tags,
    // rust: entity_tags,
    // rust: damage_tags,
    // rust: props,
    // rust: lang,
}
}
get :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.index.get(id).map(|&i| &self.list[i])
}
    // The table a client plays a server with: this one and the server's
    // entries it lacks (a data pack's), from the definitions the registry
    // sync sent; `None` when there are none. The names then come from the
    // entries' own `description`, as `Enchantment.getFullname` reads it.
    // rust: pub fn with_entries<'a>(
    // rust: &self,
    // rust: entries: impl IntoIterator<Item = (&'a str, &'a Value)>,
    // rust: ) -> Option<Self> {
    // rust: let mut table = None::<Self>;
    // rust: for (id, v) in entries {
    // rust: if self.index.contains_key(id) {
    // rust: continue;
}
    // rust: let t = table.get_or_insert_with(|| self.clone());
    // rust: let e = parse_entry(id, v, &t.tags, &t.lang);
    // rust: t.index.insert(e.id.clone(), t.list.len());
    // rust: t.list.push(e);
}
    // rust: table
}
    // The longest `minecraft:ignite` the attacker's `minecraft:post_attack`
    // effects (Fire Aspect) set on the victim, in seconds: the effects whose
    // requirements hold for `ctx` (0 when none).
    // rust: pub fn ignite_seconds(
    // rust: &self,
    // rust: enchants: &[(Arc<str>, u32)],
    // rust: ctx: &EffectContext<'_>,
    // rust: random: &mut LegacyRandom,
    // rust: ) -> f32 {
    // rust: let mut seconds = 0.0f32;
    // rust: for (id, level) in enchants {
    // rust: let Some(def) = self.get(id) else { continue };
    // rust: for effect in def.effects["minecraft:post_attack"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: let e = &effect["effect"];
    // rust: let is_ignite = matches!(e["type"].as_str(), Some("minecraft:ignite" | "ignite"));
    // rust: if !is_ignite
    // rust: || effect["enchanted"] != "attacker"
    // rust: || effect["affected"] != "victim"
    // rust: || !effect
    // rust: .get("requirements")
    // rust: .is_none_or(|r| self.condition(r, *level, ctx, random))
    // rust: {
    // rust: continue;
}
    // rust: seconds = seconds.max(level_value(&e["duration"], *level));
}
}
    // rust: seconds
}
tag :: proc(self: ^Self, name: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.tags
    // rust: .get(name.trim_start_matches('#'))
    // rust: .map_or(&[], Vec::as_slice)
}
in_tag :: proc(self: ^Self, name: string, id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.tag(name).iter().any(|e| &**e == id)
}
is_curse :: proc(self: ^Self, id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.in_tag("minecraft:curse", id)
}
translate :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.lang.get(key).map(String::as_str)
}
props :: proc(self: ^Self, item: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.props.get(item)
}
enchantable :: proc(self: ^Self, item: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.props(item).map_or(0, |p| p.enchantable)
}
    // Whether `item` matches an id / `#tag` list.
item_in :: proc(items: ^Items, specs: ^[string], item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: specs.iter().any(|s| match s.strip_prefix('#') {
    // rust: Some(tag) => items.item_tags.get(tag).is_some_and(|t| t.contains(item)),
    // rust: None => s == item,
    // rust: })
}
    // `Enchantment.canEnchant` / `isSupportedItem`.
can_enchant :: proc(self: ^Self, items: ^Items, id: string, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.get(id)
    // rust: .is_some_and(|e| Self::item_in(items, &e.supported, item))
}
    // `Enchantment.isPrimaryItem`.
is_primary :: proc(self: ^Self, items: ^Items, e: ^Enchantment, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Self::item_in(items, &e.supported, item)
    // rust: && e.primary
    // rust: .as_ref()
    // rust: .is_none_or(|p| Self::item_in(items, p, item))
}
    // `Enchantment.areCompatible`.
compatible :: proc(self: ^Self, a: string, b: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if a == b {
    // rust: return false;
}
    // rust: let excl = |x: &str, y: &str| self.get(x).is_some_and(|e| e.exclusive.contains(y));
    // rust: !excl(a, b) && !excl(b, a)
}
    // `Enchantment.getFullname` as plain text and whether it is a curse (red).
full_name :: proc(self: ^Self, id: string, level: u32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let language = horizon_client_core::lang::current();
    // rust: self.full_name_in(language.as_deref(), id, level)
}
    // `Enchantment.getFullname` against `language`; `None` (no language loaded: a
    // dedicated server, the probes) keeps the English names loaded above.
    // rust: pub fn full_name_in(
    // rust: &self,
    // rust: language: Option<&horizon_client_core::lang::Language>,
    // rust: id: &str,
    // rust: level: u32,
    // rust: ) -> (String, bool) {
    // rust: let numeric = NUMERIC_LEVELS.load(Ordering::Relaxed);
    // rust: self.full_name_with(language, id, level, numeric)
}
    // [`Enchantments::full_name_in`] with the level as a number when `numeric`.
    // rust: fn full_name_with(
    // rust: &self,
    // rust: language: Option<&horizon_client_core::lang::Language>,
    // rust: id: &str,
    // rust: level: u32,
    // rust: numeric: bool,
    // rust: ) -> (String, bool) {
    // rust: let tr = |key: &str| language.and_then(|l| l.get(key).map(str::to_owned));
    // rust: let Some(e) = self.get(id) else {
    // rust: return (format!("{id} {}", level_name(level)), false);
}
    // rust: let mut name = tr(&e.description_key).unwrap_or_else(|| e.description.clone());
    // rust: if (level != 1 || e.max_level != 1) && numeric {
    // rust: name.push(' ');
    // rust: name.push_str(&level.to_string());
    // rust: } else if level != 1 || e.max_level != 1 {
    // rust: name.push(' ');
    // rust: let key = format!("enchantment.level.{level}");
    // rust: let suffix = tr(&key)
    // rust: .or_else(|| self.lang.get(&key).cloned())
    // rust: .unwrap_or_else(|| {
    // rust: if (1..=10).contains(&level) {
    // rust: level_name(level)
    // rust: } else {
    // rust: key
}
    // rust: });
    // rust: name.push_str(&suffix);
}
    // rust: (name, self.is_curse(id))
}
    // Tooltip lines for a level list, in `#tooltip_order` then remaining order.
tooltip :: proc(self: ^Self, levels: ^[(^str) {
}
    // rust: let order = self.tag("minecraft:tooltip_order");
    // rust: let mut out = Vec::new();
    // rust: for id in order {
    // rust: if let Some((_, l)) = levels.iter().find(|(e, _)| e == id) {
    // rust: out.push(self.full_name(id, *l));
}
}
    // rust: for (id, l) in levels {
    // rust: if !order.contains(id) {
    // rust: out.push(self.full_name(id, *l));
}
}
    // rust: out
}

    // ---- Enchanting table (EnchantmentHelper) ----

    // `EnchantmentHelper.getEnchantmentCost`.
    // rust: pub fn enchantment_cost<R: RandomSource>(
    // rust: &self,
    // rust: random: &mut R,
    // rust: slot: usize,
    // rust: bookcases: i32,
    // rust: item: &str,
    // rust: ) -> i32 {
    // rust: if self.enchantable(item) == 0 {
    // rust: return 0;
}
    // rust: let bookcases = bookcases.min(15);
    // rust: let selected = next_int(random, 8) + 1 + (bookcases >> 1) + next_int(random, bookcases + 1);
    // rust: match slot {
    // rust: 0 => (selected / 3).max(1),
    // rust: 1 => selected * 2 / 3 + 1,
    // rust: _ => selected.max(bookcases * 2),
}
}
    // `EnchantmentHelper.getAvailableEnchantmentResults`.
    // rust: pub fn available_results(
    // rust: &self,
    // rust: items: &Items,
    // rust: value: i32,
    // rust: item: &str,
    // rust: pool: &[Arc<str>],
    // rust: ) -> Vec<(Arc<str>, u32)> {
    // rust: let book = item == "minecraft:book";
    // rust: let mut out = Vec::new();
    // rust: for id in pool {
    // rust: let Some(e) = self.get(id) else { continue };
    // rust: if !(book || self.is_primary(items, e, item)) {
    // rust: continue;
}
    // rust: for level in (1..=e.max_level).rev() {
    // rust: if value >= e.min_cost.calculate(level) && value <= e.max_cost.calculate(level) {
    // rust: out.push((e.id.clone(), level));
    // rust: break;
}
}
}
    // rust: out
}
    // rust: fn weighted<R: RandomSource>(
    // rust: &self,
    // rust: random: &mut R,
    // rust: list: &[(Arc<str>, u32)],
    // rust: ) -> Option<(Arc<str>, u32)> {
    // rust: let total: i32 = list
    // rust: .iter()
    // rust: .map(|(id, _)| self.get(id).map_or(0, |e| e.weight as i32))
    // rust: .sum();
    // rust: if total <= 0 {
    // rust: return None;
}
    // rust: let mut index = next_int(random, total);
    // rust: for (id, l) in list {
    // rust: index -= self.get(id).map_or(0, |e| e.weight as i32);
    // rust: if index < 0 {
    // rust: return Some((id.clone(), *l));
}
}
    // rust: None
}
    // `EnchantmentHelper.selectEnchantment`.
    // rust: pub fn select<R: RandomSource>(
    // rust: &self,
    // rust: items: &Items,
    // rust: random: &mut R,
    // rust: item: &str,
    // rust: cost: i32,
    // rust: pool: &[Arc<str>],
    // rust: ) -> Vec<(Arc<str>, u32)> {
    // rust: let mut results = Vec::new();
    // rust: let value = self.enchantable(item) as i32;
    // rust: if value == 0 {
    // rust: return results;
}
    // rust: let mut cost = cost + 1 + next_int(random, value / 4 + 1) + next_int(random, value / 4 + 1);
    // rust: let span = (random.next_float() + random.next_float() - 1.0) * 0.15;
    // rust: cost = ((cost as f32 + cost as f32 * span).round() as i32).max(1);
    // rust: let mut available = self.available_results(items, cost, item, pool);
    // rust: if !available.is_empty() {
    // rust: if let Some(first) = self.weighted(random, &available) {
    // rust: results.push(first);
}
    // rust: while next_int(random, 50) <= cost {
    // rust: if let Some((last, _)) = results.last() {
    // rust: let last = last.clone();
    // rust: available.retain(|(e, _)| self.compatible(&last, e));
}
    // rust: if available.is_empty() {
    // rust: break;
}
    // rust: if let Some(next) = self.weighted(random, &available) {
    // rust: results.push(next);
}
    // rust: cost /= 2;
}
}
    // rust: results
}

    // ---- Effect components ----

    // Run `component` value effects of every enchantment on `stack` over `value`.
    // rust: pub fn modify_value(
    // rust: &self,
    // rust: stack: Option<&ItemStack>,
    // rust: component: &str,
    // rust: ctx: &EffectContext<'_>,
    // rust: random: &mut LegacyRandom,
    // rust: value: f32,
    // rust: ) -> f32 {
    // rust: let Some(stack) = stack else { return value };
    // rust: let mut value = value;
    // rust: for (id, level) in stack.enchantments() {
    // rust: value = self.modify_value_with(id, *level, component, ctx, random, value);
}
    // rust: value
}
    // rust: pub fn modify_value_with(
    // rust: &self,
    // rust: id: &str,
    // rust: level: u32,
    // rust: component: &str,
    // rust: ctx: &EffectContext<'_>,
    // rust: random: &mut LegacyRandom,
    // rust: mut value: f32,
    // rust: ) -> f32 {
    // rust: let Some(e) = self.get(id) else { return value };
    // rust: for effect in e.effects[component].as_array().into_iter().flatten() {
    // rust: if let Some(req) = effect.get("requirements")
    // rust: && !self.condition(req, level, ctx, random)
    // rust: {
    // rust: continue;
}
    // rust: value = apply_value_effect(&effect["effect"], level, random, value);
}
    // rust: value
}
    // Whether `stack` has any enchantment providing `component`.
has_component :: proc(self: ^Self, stack: ^ItemStack, component: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: stack.enchantments().iter().any(|(id, _)| {
    // rust: self.get(id)
    // rust: .is_some_and(|e| e.effects.get(component).is_some())
    // rust: })
}
    // `minecraft:attributes` contributions of `stack`: (attribute, id, amount, operation).
attributes :: proc(self: ^Self, stack: ^ItemStack) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for (id, level) in stack.enchantments() {
    // rust: let Some(e) = self.get(id) else { continue };
    // rust: for a in e.effects["minecraft:attributes"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: out.push((
    // rust: a["attribute"].as_str().unwrap_or("").to_owned(),
    // rust: a["id"].as_str().unwrap_or("").to_owned(),
    // rust: f64::from(level_value(&a["amount"], *level)),
    // rust: a["operation"].as_str().unwrap_or("add_value").to_owned(),
    // rust: ));
}
}
    // rust: out
}
    // `EnchantmentHelper.forEachModifier` as an item's tooltip lists them: the
    // `minecraft:attributes` effects of `stack`'s enchantments as rows of
    // (attribute, id, amount, operation, slot group), one per slot group the
    // enchantment lists.
modifier_rows :: proc(self: ^Self, stack: ^ItemStack) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut rows = Vec::new();
    // rust: for (id, level) in stack.enchantments() {
    // rust: let Some(e) = self.get(id) else { continue };
    // rust: for a in e.effects["minecraft:attributes"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: for slot in &e.slots {
    // rust: rows.push((
    // rust: a["attribute"].as_str().unwrap_or("").to_owned(),
    // rust: a["id"].as_str().unwrap_or("").to_owned(),
    // rust: f64::from(level_value(&a["amount"], *level)),
    // rust: a["operation"].as_str().unwrap_or("add_value").to_owned(),
    // rust: slot.clone(),
    // rust: ));
}
}
}
    // rust: rows
}
    // Sum of `add_value` amounts of one attribute from enchantments on `stack`.
attribute_add :: proc(self: ^Self, stack: Maybe(^ItemStack), attribute: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: stack.map_or(0.0, |s| {
    // rust: self.attributes(s)
    // rust: .iter()
    // rust: .filter(|a| a.0 == attribute && a.3 == "add_value")
    // rust: .map(|a| a.2)
    // rust: .sum()
    // rust: })
}
entity_matches :: proc(self: ^Self, spec: ^Value, entity: Maybe(string)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(entity) = entity else { return false };
    // rust: match spec.as_str() {
    // rust: Some(s) => match s.strip_prefix('#') {
    // rust: Some(tag) => self
    // rust: .entity_tags
    // rust: .get(tag)
    // rust: .is_some_and(|t| t.contains(entity)),
    // rust: None => s == entity,
    // rust: },
    // rust: None => string_list(spec).iter().any(|s| s == entity),
}
}
    // The loot-condition subset enchantment `requirements` use.
    // rust: pub fn condition(
    // rust: &self,
    // rust: c: &Value,
    // rust: level: u32,
    // rust: ctx: &EffectContext<'_>,
    // rust: random: &mut LegacyRandom,
    // rust: ) -> bool {
    // rust: match c["type"].as_str().or(c["condition"].as_str()).unwrap_or("") {
    // rust: "minecraft:inverted" => !self.condition(&c["term"], level, ctx, random),
    // rust: "minecraft:all_of" => c["terms"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|t| self.condition(t, level, ctx, random)),
    // rust: "minecraft:any_of" => c["terms"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .any(|t| self.condition(t, level, ctx, random)),
    // rust: "minecraft:match_tool" => {
    // rust: let Some(tool) = ctx.tool else { return false };
    // rust: let items = &c["predicate"]["items"];
    // rust: if items.is_null() {
    // rust: return true;
}
    // rust: string_list(items)
    // rust: .iter()
    // rust: .any(|s| match s.strip_prefix('#') {
    // rust: Some(tag) => ctx.items.is_some_and(|i| {
    // rust: i.item_tags.get(tag).is_some_and(|t| t.contains(tool))
    // rust: }),
    // rust: None => s == tool,
    // rust: })
}
    // rust: "minecraft:damage_source_properties" => {
    // rust: let p = &c["predicate"];
    // rust: if let Some(direct) = p["is_direct"].as_bool()
    // rust: && direct != ctx.is_direct
    // rust: {
    // rust: return false;
}
    // rust: p["tags"].as_array().into_iter().flatten().all(|t| {
    // rust: let tag = t["id"].as_str().unwrap_or("").trim_start_matches('#');
    // rust: let has = ctx
    // rust: .damage_type
    // rust: .is_some_and(|d| self.damage_tags.get(tag).is_some_and(|s| s.contains(d)));
    // rust: has == t["expected"].as_bool().unwrap_or(true)
    // rust: })
}
    // rust: "minecraft:entity_properties" => {
    // rust: let entity = match c["entity"].as_str().unwrap_or("this") {
    // rust: "this" => ctx.this,
    // rust: "attacker" => ctx.attacker,
    // rust: "direct_attacker" => ctx.direct_attacker,
    // rust: _ => None,
}
    // rust: let spec = &c["predicate"]["minecraft:entity_type"];
    // rust: let spec = if spec.is_null() {
    // rust: &c["predicate"]["type"]
    // rust: } else {
    // rust: spec
}
    // rust: (spec.is_null() && entity.is_some() || self.entity_matches(spec, entity))
    // rust: && movement_matches(&c["predicate"], role_state(c, ctx))
}
    // rust: "minecraft:random_chance" => {
    // rust: let chance = match &c["chance"] {
    // rust: Value::Object(o)
    // rust: if o.get("type").and_then(Value::as_str)
    // rust: == Some("minecraft:enchantment_level") =>
    // rust: {
    // rust: level_value(&c["chance"]["amount"], level)
}
    // rust: v => v
    // rust: .as_f64()
    // rust: .map_or_else(|| level_value(v, level), |f| f as f32),
}
    // rust: random.next_float() < chance
}
    // rust: _ => false,
}
}
}
// What enchantment requirement predicates can see.
EffectContext :: struct {
    items: Maybe(^'a Items),
    // The tool for `match_tool` (the enchanted item, or the ammo for ammo_use).
    tool: Maybe(^'a str),
    // Damage type id (e.g. `minecraft:fall`).
    damage_type: Maybe(^'a str),
    is_direct: bool,
    // Entity type ids: the victim/user ("this"), attacker and direct attacker.
    this: Maybe(^'a str),
    attacker: Maybe(^'a str),
    direct_attacker: Maybe(^'a str),
    // The direct attacker's fall distance and whether it flies (elytra or
    // abilities), for `movement` and `flags` predicates.
    direct_motion: Option<(f64,
}
// The fall distance and flying flag known for an `entity_properties` role.
role_state :: proc(c: ^Value, ctx: ^EffectContext<'_>) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match c["entity"].as_str().unwrap_or("this") {
    // rust: "direct_attacker" => ctx.direct_motion,
    // rust: _ => None,
}
}
// `EntityPredicate`'s `minecraft:movement` fall distance and
// `minecraft:flags` is_flying (the parts enchantment requirements use); an
// entity whose state is unknown matches neither.
movement_matches :: proc(predicate: ^Value, state: Option<(f64) {
}
    // rust: let fall = &predicate["minecraft:movement"]["fall_distance"];
    // rust: let flying = predicate["minecraft:flags"]["is_flying"].as_bool();
    // rust: if fall.is_null() && flying.is_none() {
    // rust: return true;
}
    // rust: let Some((distance, is_flying)) = state else {
    // rust: return false;
}
    // MinMaxBounds.Doubles: a number is an exact bound.
    // rust: let bound = |key: &str| {
    // rust: fall.as_f64()
    // rust: .or_else(|| fall.get(key).and_then(Value::as_f64))
}
    // MinMaxBounds.Doubles.matches
    // rust: bound("min").is_none_or(|min| min <= distance)
    // rust: && bound("max").is_none_or(|max| distance <= max)
    // rust: && flying.is_none_or(|f| f == is_flying)
}
    // rust: fn next_int<R: RandomSource>(random: &mut R, bound: i32) -> i32 {
    // rust: random.next_int_bound(bound.max(1)).unwrap_or(0)
}
// `LevelBasedValue.calculate`.
level_value :: proc(v: ^Value, level: u32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let l = level as f32;
    // rust: match v {
    // rust: Value::Number(n) => n.as_f64().unwrap_or(0.0) as f32,
    // rust: Value::Object(o) => {
    // rust: let f = |k: &str| o.get(k).and_then(Value::as_f64).unwrap_or(0.0) as f32;
    // rust: match o.get("type").and_then(Value::as_str).unwrap_or("") {
    // rust: "minecraft:linear" => f("base") + f("per_level_above_first") * (l - 1.0),
    // rust: "minecraft:levels_squared" => l * l + f("added"),
    // rust: "minecraft:clamped" => level_value(&o["value"], level).clamp(f("min"), f("max")),
    // rust: "minecraft:fraction" => {
    // rust: let d = level_value(&o["denominator"], level);
    // rust: if d == 0.0 {
    // rust: 0.0
    // rust: } else {
    // rust: level_value(&o["numerator"], level) / d
}
}
    // rust: "minecraft:exponent" => {
    // rust: level_value(&o["base"], level).powf(level_value(&o["power"], level))
}
    // rust: "minecraft:lookup" => {
    // rust: let values = o.get("values").and_then(Value::as_array);
    // rust: match values.and_then(|a| a.get(level as usize - 1)) {
    // rust: Some(v) => v.as_f64().unwrap_or(0.0) as f32,
    // rust: None => level_value(&o["fallback"], level),
}
}
    // rust: _ => f("value"),
}
}
    // rust: _ => 0.0,
}
}
// `EnchantmentValueEffect.process`.
    // rust: pub fn apply_value_effect(
    // rust: effect: &Value,
    // rust: level: u32,
    // rust: random: &mut LegacyRandom,
    // rust: value: f32,
    // rust: ) -> f32 {
    // rust: match effect["type"].as_str().unwrap_or("") {
    // rust: "minecraft:add" => value + level_value(&effect["value"], level),
    // rust: "minecraft:multiply" => value * level_value(&effect["factor"], level),
    // rust: "minecraft:set" => level_value(&effect["value"], level),
    // rust: "minecraft:remove_binomial" => {
    // rust: let p = level_value(&effect["chance"], level);
    // rust: let n = value;
            // Normal approximation for large counts (written as vanilla's negated tests).
    // rust: let large = n > 128.0 && n * p >= 20.0 && n * (1.0 - p) >= 20.0;
    // rust: let removed = if large {
    // rust: let miu = (f64::from(n) * f64::from(p)).floor();
    // rust: let sigma = (f64::from(n) * f64::from(p) * f64::from(1.0 - p)).sqrt();
    // rust: ((miu + random.next_gaussian() * sigma).round() as i32).clamp(0, n as i32)
    // rust: } else {
    // rust: let mut d = 0;
    // rust: for _ in 0..n as i32 {
    // rust: if random.next_float() < p {
    // rust: d += 1;
}
}
    // rust: d
}
    // rust: n - removed as f32
}
    // rust: "minecraft:all_of" => effect["effects"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .fold(value, |v, e| apply_value_effect(e, level, random, v)),
    // rust: _ => value,
}
}

    // rust: pub mod tests {
//     use super::*;
//     use serde_json::json;

    // A small registry built from literal JSON matching the vanilla files.
sample :: proc() -> E {
    // Ported from Horizon
    return {}
}
    // rust: let defs = [
    // rust: (
    // rust: "minecraft:sharpness",
    // rust: json!({"anvil_cost":1,"description":{"translate":"enchantment.minecraft.sharpness"},"exclusive_set":"#minecraft:exclusive_set/damage","max_cost":{"base":21,"per_level_above_first":11},"max_level":5,"min_cost":{"base":1,"per_level_above_first":11},"primary_items":"#minecraft:enchantable/melee_weapon","supported_items":"#minecraft:enchantable/sharp_weapon","weight":10,"slots":["mainhand"],"effects":{"minecraft:damage":[{"effect":{"type":"minecraft:add","value":{"type":"minecraft:linear","base":1.0,"per_level_above_first":0.5}}}]}}),
    // rust: ),
    // rust: (
    // rust: "minecraft:smite",
    // rust: json!({"anvil_cost":2,"exclusive_set":"#minecraft:exclusive_set/damage","max_cost":{"base":25,"per_level_above_first":8},"max_level":5,"min_cost":{"base":5,"per_level_above_first":8},"primary_items":"#minecraft:enchantable/melee_weapon","supported_items":"#minecraft:enchantable/weapon","weight":5,"effects":{"minecraft:damage":[{"effect":{"type":"minecraft:add","value":{"type":"minecraft:linear","base":2.5,"per_level_above_first":2.5}},"requirements":{"type":"minecraft:entity_properties","entity":"this","predicate":{"minecraft:entity_type":"#minecraft:sensitive_to_smite"}}}]}}),
    // rust: ),
    // rust: (
    // rust: "minecraft:unbreaking",
    // rust: json!({"anvil_cost":2,"max_cost":{"base":55,"per_level_above_first":8},"max_level":3,"min_cost":{"base":5,"per_level_above_first":8},"supported_items":"#minecraft:enchantable/durability","weight":5,"effects":{"minecraft:item_damage":[{"effect":{"type":"minecraft:remove_binomial","chance":{"type":"minecraft:fraction","denominator":{"type":"minecraft:linear","base":2.0,"per_level_above_first":1.0},"numerator":{"type":"minecraft:linear","base":1.0,"per_level_above_first":1.0}}}}]}}),
    // rust: ),
    // rust: (
    // rust: "minecraft:mending",
    // rust: json!({"anvil_cost":4,"max_cost":{"base":75,"per_level_above_first":25},"max_level":1,"min_cost":{"base":25,"per_level_above_first":25},"supported_items":"#minecraft:enchantable/durability","weight":2}),
    // rust: ),
    // rust: (
    // rust: "minecraft:feather_falling",
    // rust: json!({"anvil_cost":2,"max_cost":{"base":11,"per_level_above_first":6},"max_level":4,"min_cost":{"base":5,"per_level_above_first":6},"supported_items":"#minecraft:enchantable/foot_armor","weight":5,"effects":{"minecraft:damage_protection":[{"effect":{"type":"minecraft:add","value":{"type":"minecraft:linear","base":3.0,"per_level_above_first":3.0}},"requirements":{"type":"minecraft:damage_source_properties","predicate":{"tags":[{"expected":true,"id":"#minecraft:is_fall"},{"expected":false,"id":"#minecraft:bypasses_invulnerability"}]}}}]}}),
    // rust: ),
    // rust: ];
    // rust: let list: Vec<Enchantment> = defs
    // rust: .iter()
    // rust: .map(|(id, v)| Enchantment {
    // rust: id: Arc::from(*id),
    // rust: description: id.trim_start_matches("minecraft:").into(),
    // rust: description_key: v["description"]["translate"].as_str().unwrap_or("").into(),
    // rust: max_level: v["max_level"].as_u64().unwrap() as u32,
    // rust: weight: v["weight"].as_u64().unwrap() as u32,
    // rust: anvil_cost: v["anvil_cost"].as_u64().unwrap() as u32,
    // rust: min_cost: Cost::parse(&v["min_cost"]),
    // rust: max_cost: Cost::parse(&v["max_cost"]),
    // rust: supported: string_list(&v["supported_items"]),
    // rust: primary: v.get("primary_items").map(string_list),
    // rust: exclusive: if v["exclusive_set"].is_null() {
    // rust: HashSet::new()
    // rust: } else {
    // rust: [
    // rust: Arc::from("minecraft:sharpness"),
    // rust: Arc::from("minecraft:smite"),
    // rust: ]
    // rust: .into_iter()
    // rust: .collect()
    // rust: },
    // rust: slots: vec![],
    // rust: effects: v["effects"].clone(),
    // rust: })
    // rust: .collect();
    // rust: let index = list
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, e)| (e.id.clone(), i))
    // rust: .collect();
    // rust: let pool: Vec<Arc<str>> = [
    // rust: "minecraft:feather_falling",
    // rust: "minecraft:sharpness",
    // rust: "minecraft:smite",
    // rust: "minecraft:unbreaking",
    // rust: "minecraft:mending",
    // rust: ]
    // rust: .iter()
    // rust: .map(|s| Arc::from(*s))
    // rust: .collect();
    // rust: let mut tags = HashMap::new();
    // rust: tags.insert(
    // rust: "minecraft:in_enchanting_table".to_owned(),
    // rust: pool[..4].to_vec(),
    // rust: );
    // rust: tags.insert(
    // rust: "minecraft:tooltip_order".to_owned(),
    // rust: vec![
    // rust: Arc::from("minecraft:sharpness"),
    // rust: Arc::from("minecraft:unbreaking"),
    // rust: ],
    // rust: );
    // rust: let mut entity_tags = HashMap::new();
    // rust: entity_tags.insert(
    // rust: "minecraft:sensitive_to_smite".to_owned(),
    // rust: ["minecraft:zombie".to_owned()].into_iter().collect(),
    // rust: );
    // rust: let mut damage_tags = HashMap::new();
    // rust: damage_tags.insert(
    // rust: "minecraft:is_fall".to_owned(),
    // rust: ["minecraft:fall".to_owned()].into_iter().collect(),
    // rust: );
    // rust: let mut props = HashMap::new();
    // rust: for (item, value) in [
    // rust: ("minecraft:diamond_sword", 10),
    // rust: ("minecraft:iron_sword", 14),
    // rust: ("minecraft:book", 1),
    // rust: ("minecraft:iron_boots", 9),
    // rust: ] {
    // rust: props.insert(
    // rust: Arc::from(item),
    // rust: ItemProps {
    // rust: enchantable: value,
    // rust: ..Default::default()
    // rust: },
    // rust: );
}
    // rust: Enchantments {
    // rust: list,
    // rust: index,
    // rust: tags,
    // rust: entity_tags,
    // rust: damage_tags,
    // rust: props,
    // rust: lang: HashMap::new(),
}
}
sample_items :: proc() -> I {
    // Ported from Horizon
    return {}
}
    // rust: let mut item_tags: HashMap<String, HashSet<String>> = HashMap::new();
    // rust: let swords = ["minecraft:diamond_sword", "minecraft:iron_sword"];
    // rust: for tag in [
    // rust: "enchantable/melee_weapon",
    // rust: "enchantable/sharp_weapon",
    // rust: "enchantable/weapon",
    // rust: "enchantable/durability",
    // rust: ] {
    // rust: item_tags.insert(
    // rust: format!("minecraft:{tag}"),
    // rust: swords.iter().map(|s| (*s).to_owned()).collect(),
    // rust: );
}
    // rust: item_tags
    // rust: .get_mut("minecraft:enchantable/durability")
    // rust: .unwrap()
    // rust: .insert("minecraft:iron_boots".into());
    // rust: item_tags.insert(
    // rust: "minecraft:enchantable/foot_armor".into(),
    // rust: ["minecraft:iron_boots".to_owned()].into_iter().collect(),
    // rust: );
    // rust: Items::for_tests(item_tags)
}

level_based_values :: proc() {
}
    // rust: assert_eq!(
    // rust: level_value(
    // rust: &json!({"type":"minecraft:linear","base":1.0,"per_level_above_first":0.5}),
    // rust: 5
    // rust: ),
    // rust: 3.0
    // rust: );
    // rust: assert_eq!(
    // rust: level_value(&json!({"type":"minecraft:levels_squared","added":1.0}), 3),
    // rust: 10.0
    // rust: );
    // rust: assert_eq!(
    // rust: level_value(
    // rust: &json!({"type":"minecraft:fraction","numerator":{"type":"minecraft:linear","base":1.0,"per_level_above_first":1.0},"denominator":{"type":"minecraft:linear","base":2.0,"per_level_above_first":1.0}}),
    // rust: 3
    // rust: ),
    // rust: 0.75
    // rust: );
    // rust: assert_eq!(level_name(4), "IV");
    // rust: assert_eq!(
    // rust: Cost {
    // rust: base: 1,
    // rust: per_level: 11
}
    // rust: .calculate(5),
    // rust: 45
    // rust: );
}

enchanting_cost_matches_vanilla_formula :: proc() {
}
    // rust: let e = sample();
        // Replays EnchantmentHelper.getEnchantmentCost draws by hand.
    // rust: for seed in [0i64, 1, 42, -7, 123456] {
    // rust: for bookcases in [0, 5, 15, 20] {
    // rust: let mut a = LegacyRandom::new(seed);
    // rust: let mut b = LegacyRandom::new(seed);
    // rust: let costs: Vec<i32> = (0..3)
    // rust: .map(|slot| {
    // rust: e.enchantment_cost(&mut a, slot, bookcases, "minecraft:diamond_sword")
    // rust: })
    // rust: .collect();
    // rust: let bc = bookcases.min(15);
    // rust: let expect: Vec<i32> = (0..3)
    // rust: .map(|slot| {
    // rust: let s = b.next_int_bound(8).unwrap()
    // rust: + 1
    // rust: + (bc >> 1)
    // rust: + b.next_int_bound(bc + 1).unwrap();
    // rust: match slot {
    // rust: 0 => (s / 3).max(1),
    // rust: 1 => s * 2 / 3 + 1,
    // rust: _ => s.max(bc * 2),
}
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(costs, expect);
    // rust: assert!(costs[2] <= 30);
}
}
    // rust: assert_eq!(
    // rust: e.enchantment_cost(&mut LegacyRandom::new(0), 0, 15, "minecraft:stick"),
    // rust: 0
    // rust: );
}

selection_respects_costs_and_exclusivity :: proc() {
}
    // rust: let e = sample();
    // rust: let items = sample_items();
    // rust: let pool = e.tag("minecraft:in_enchanting_table").to_vec();
    // rust: for seed in 0..200 {
    // rust: let mut r = LegacyRandom::new(seed);
    // rust: let picked = e.select(&items, &mut r, "minecraft:diamond_sword", 30, &pool);
    // rust: assert!(!picked.is_empty());
    // rust: let has = |id: &str| picked.iter().any(|(p, _)| &**p == id);
    // rust: assert!(
    // rust: !(has("minecraft:sharpness") && has("minecraft:smite")),
    // rust: "{picked:?}"
    // rust: );
    // rust: assert!(!has("minecraft:feather_falling"));
    // rust: for (id, l) in &picked {
    // rust: assert!(*l >= 1 && *l <= e.get(id).unwrap().max_level);
}
}
        // Books accept every enchantment in the pool.
    // rust: let mut r = LegacyRandom::new(3);
    // rust: let available = e.available_results(&items, 20, "minecraft:book", &pool);
    // rust: assert!(
    // rust: available
    // rust: .iter()
    // rust: .any(|(id, _)| &**id == "minecraft:feather_falling")
    // rust: );
    // rust: assert!(
    // rust: e.select(&items, &mut r, "minecraft:stick", 30, &pool)
    // rust: .is_empty()
    // rust: );
}

value_effects_and_requirements :: proc() {
}
    // rust: let e = sample();
    // rust: let items = sample_items();
    // rust: let mut sword = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: sword.enchant("minecraft:sharpness", 5);
    // rust: let mut r = LegacyRandom::new(1);
    // rust: let ctx = EffectContext {
    // rust: items: Some(&items),
    // rust: this: Some("minecraft:zombie"),
    // rust: ..Default::default()
}
    // rust: assert_eq!(
    // rust: e.modify_value(Some(&sword), "minecraft:damage", &ctx, &mut r, 0.0),
    // rust: 3.0
    // rust: );
    // rust: let mut smite = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: smite.enchant("minecraft:smite", 2);
    // rust: assert_eq!(
    // rust: e.modify_value(Some(&smite), "minecraft:damage", &ctx, &mut r, 0.0),
    // rust: 5.0
    // rust: );
    // rust: let pig = EffectContext {
    // rust: this: Some("minecraft:pig"),
    // rust: ..ctx
}
    // rust: assert_eq!(
    // rust: e.modify_value(Some(&smite), "minecraft:damage", &pig, &mut r, 0.0),
    // rust: 0.0
    // rust: );
    // rust: let mut boots = ItemStack::new("minecraft:iron_boots", 1);
    // rust: boots.enchant("minecraft:feather_falling", 4);
    // rust: let fall = EffectContext {
    // rust: damage_type: Some("minecraft:fall"),
    // rust: ..Default::default()
}
    // rust: assert_eq!(
    // rust: e.modify_value(
    // rust: Some(&boots),
    // rust: "minecraft:damage_protection",
    // rust: &fall,
    // rust: &mut r,
    // rust: 0.0
    // rust: ),
    // rust: 12.0
    // rust: );
    // rust: let lava = EffectContext {
    // rust: damage_type: Some("minecraft:lava"),
    // rust: ..Default::default()
}
    // rust: assert_eq!(
    // rust: e.modify_value(
    // rust: Some(&boots),
    // rust: "minecraft:damage_protection",
    // rust: &lava,
    // rust: &mut r,
    // rust: 0.0
    // rust: ),
    // rust: 0.0
    // rust: );
        // Unbreaking III keeps about 1/4 of durability hits.
    // rust: let mut tool = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: tool.enchant("minecraft:unbreaking", 3);
    // rust: let kept: f32 = (0..4000)
    // rust: .map(|_| e.modify_value(Some(&tool), "minecraft:item_damage", &ctx, &mut r, 1.0))
    // rust: .sum();
    // rust: assert!((800.0..1200.0).contains(&kept), "{kept}");
}

names_and_tooltip_order :: proc() {
}
    // rust: let e = sample();
    // rust: assert_eq!(e.full_name("minecraft:mending", 1).0, "mending");
    // rust: assert_eq!(e.full_name("minecraft:sharpness", 1).0, "sharpness I");
        // PvP & HUD's numbers: any level, past vanilla's numerals too; a one-level
        // enchantment still has none.
    // rust: let number = |id, level| e.full_name_with(None, id, level, true).0;
    // rust: assert_eq!(number("minecraft:sharpness", 5), "sharpness 5");
    // rust: assert_eq!(number("minecraft:sharpness", 255), "sharpness 255");
    // rust: assert_eq!(number("minecraft:mending", 1), "mending");
    // rust: let levels = vec![
    // rust: (Arc::from("minecraft:unbreaking"), 3),
    // rust: (Arc::from("minecraft:mending"), 1),
    // rust: (Arc::from("minecraft:sharpness"), 2),
    // rust: ];
    // rust: let lines: Vec<String> = e.tooltip(&levels).into_iter().map(|l| l.0).collect();
    // rust: assert_eq!(lines, ["sharpness II", "unbreaking III", "mending"]);
    // rust: assert!(!e.compatible("minecraft:sharpness", "minecraft:smite"));
    // rust: assert!(e.compatible("minecraft:sharpness", "minecraft:unbreaking"));
}

high_enchantment_names_keep_the_untranslated_key :: proc() {
}
    // rust: let mut e = sample();
    // rust: assert_eq!(
    // rust: e.full_name_in(None, "minecraft:sharpness", 255).0,
    // rust: "sharpness enchantment.level.255"
    // rust: );
        // A pack may supply names beyond vanilla's I through X, including
        // the English fallback used when no client language is loaded.
    // rust: e.lang.insert("enchantment.level.11".into(), "XI".into());
    // rust: assert_eq!(
    // rust: e.full_name_in(None, "minecraft:sharpness", 11).0,
    // rust: "sharpness XI"
    // rust: );
}

    // A server's data-pack enchantment the game lacks is named by the
    // `description` it sent (`Enchantment.getFullname`), with the level
    // numeral unless both the level and the maximum are 1; the game's own
    // entries keep their tables.
synced_entries_name_themselves :: proc() {
}
    // rust: let e = sample();
    // rust: assert_eq!(e.full_name("enchex:drill", 2).0, "enchex:drill II");
    // rust: let drill = json!({"description":{"text":"Drill"},"max_level":3,"supported_items":"#minecraft:enchantable/mining"});
    // rust: let hex = json!({"description":"Hex","max_level":1});
    // rust: let other = json!({"description":{"text":"Other"},"max_level":5});
    // rust: let synced = e
    // rust: .with_entries([
    // rust: ("enchex:drill", &drill),
    // rust: ("enchex:hex", &hex),
    // rust: ("minecraft:sharpness", &other),
    // rust: ])
    // rust: .unwrap();
    // rust: assert_eq!(synced.full_name("enchex:drill", 2).0, "Drill II");
    // rust: assert_eq!(synced.full_name("enchex:drill", 1).0, "Drill I");
    // rust: assert_eq!(synced.full_name("enchex:hex", 1).0, "Hex");
    // rust: assert_eq!(synced.full_name("minecraft:sharpness", 1).0, "sharpness I");
    // rust: assert_eq!(synced.list.len(), e.list.len() + 2);
        // Nothing new: the game's table stays in use.
    // rust: assert!(e.with_entries([("minecraft:sharpness", &other)]).is_none());
}

    // The enchantment's name and its level come from the selected language,
    // with the English name loaded above as the fallback.
names_follow_the_language :: proc() {
}
Mem :: struct {
    // rust: impl horizon_client_core::lang::ResourceSource for Mem {
read :: proc(self: ^Self, path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.0.get(path).cloned()
}
}
    // rust: let ru = Mem(HashMap::from([(
    // rust: "assets/minecraft/lang/ru_ru.json".to_owned(),
    // rust: r#"{"enchantment.minecraft.sharpness":"Острота","enchantment.level.5":"V"}"#
    // rust: .as_bytes()
    // rust: .to_vec(),
    // rust: )]));
    // rust: let ru = horizon_client_core::lang::Language::load(&[&ru], "ru_ru");
    // rust: let e = sample();
    // rust: assert_eq!(
    // rust: e.full_name_in(Some(&ru), "minecraft:sharpness", 5).0,
    // rust: "Острота V"
    // rust: );
        // mending carries no key in the fixture: the English name stays.
    // rust: assert_eq!(
    // rust: e.full_name_in(Some(&ru), "minecraft:mending", 1).0,
    // rust: "mending"
    // rust: );
}
}

    // rust: mod ignite_tests {
//     use super::*;
//     use serde_json::json;

    // Fire Aspect as the data pack has it: 4 seconds per level.
registry :: proc() -> E {
    // Ported from Horizon
    return {}
}
    // rust: let fire_aspect = Enchantment {
    // rust: id: Arc::from("minecraft:fire_aspect"),
    // rust: description: "fire_aspect".into(),
    // rust: description_key: String::new(),
    // rust: max_level: 2,
    // rust: weight: 2,
    // rust: anvil_cost: 4,
    // rust: min_cost: Cost::parse(&json!({"base":10,"per_level_above_first":20})),
    // rust: max_cost: Cost::parse(&json!({"base":60,"per_level_above_first":20})),
    // rust: supported: vec![],
    // rust: primary: None,
    // rust: exclusive: HashSet::new(),
    // rust: slots: vec![],
    // rust: effects: json!({"minecraft:post_attack":[{"effect":{"type":"minecraft:ignite","duration":{"type":"minecraft:linear","base":4.0,"per_level_above_first":4.0}},"enchanted":"attacker","affected":"victim"}]}),
}
    // rust: let index = [(fire_aspect.id.clone(), 0)].into_iter().collect();
    // rust: Enchantments {
    // rust: list: vec![fire_aspect],
    // rust: index,
    // rust: ..Default::default()
}
}

fire_aspect_ignites_for_four_seconds_a_level :: proc() {
}
    // rust: let reg = registry();
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let ctx = EffectContext {
    // rust: this: Some("minecraft:player"),
    // rust: ..Default::default()
}
    // rust: let mut fire = |level| {
    // rust: let held = [(Arc::from("minecraft:fire_aspect"), level)];
    // rust: reg.ignite_seconds(&held, &ctx, &mut random)
}
    // rust: assert_eq!(fire(1) * 20.0, 80.0);
    // rust: assert_eq!(fire(2) * 20.0, 160.0);
    // rust: assert_eq!(reg.ignite_seconds(&[], &ctx, &mut random), 0.0);
}
}
