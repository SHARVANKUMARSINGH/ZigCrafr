//! Transpiled from Horizon Rust crate
package horizon_port_pack_oracle

import "core:fmt"
import "core:mem"
import "core:math"

// The NeoForge oracle's facts (`tools/neoforge_oracle.py export`, in
// `<work>/oracle/facts.json`): every block, item, recipe and tag the pack's
// mods register, read from the running game, and the vanilla blocks beside
// them. Carry-over uses them in place of guesses: a block's template is the
// vanilla block of the same class and states whose shapes and sounds match
// best, and the declared properties are the mod's own numbers.
// use serde::Deserialize;
// use serde_json::{Map, Value, json};
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: path::Path,
}

Facts :: struct {
    blocks: BTreeMap<string,
    items: BTreeMap<string,
    tags: Tags,
    // The game's items' default components (`items.json`), so item ports leave out what their template has.
    vanilla_items: BTreeMap<string,
}

Tags :: struct {
    block: BTreeMap<string,
    item: BTreeMap<string,
}

Block :: struct {
    // The class and its superclasses, most derived first.
    class: [dynamic]string,
    properties: BTreeMap<string,
    default: string,
    item: string,
    explosion_resistance: f32,
    friction: f32,
    speed_factor: f32,
    jump_factor: f32,
    block_set_type: Maybe(SetType),
    wood_type: Maybe(string),
    states: BTreeMap<string,
}

SetType :: struct {
    name: string,
    can_open_by_hand: bool,
}

State :: struct {
    hardness: f32,
    emission: u8,
    requires_tool: bool,
    map_color_id: u8,
    sound: Value,
    outline: Value,
    collision: Value,
    // What breaking the state drops, per tool (`hand`, `diamond_pickaxe`,
    // `shears`, `silk_touch_pickaxe`...): item id → count.
    drops: BTreeMap<string,
}

Item :: struct {
    class: string,
    max_stack_size: u8,
    rarity: string,
    block: Maybe(string),
    food: Maybe(Value),
    // The default data components in 1.21.1's form; empty in facts from before they were exported.
    components: Map<string,
    attribute_modifiers: Maybe(Value),
    enchantment_value: Maybe(u32),
    repair_items: Maybe([dynamic]string),
    armor: Maybe(Armor),
}

Armor :: struct {
    // `head`, `chest`, `legs` or `feet`.
    slot: string,
    // The armour material's id: the 26.3 equipment asset it becomes.
    material: string,
    equip_sound: Maybe(string),
    layers: [dynamic]ArmorLayer,
}

// A 1.21.1 armour layer's textures: `<ns>:textures/models/armor/<name>_layer_1.png` and `_layer_2`.
ArmorLayer :: struct {
    texture: string,
    texture_legs: string,
    dyeable: bool,
}

    // rust: impl Armor {
    // Whether carry writes the material's equipment asset: in the mod's own namespaces, from layers it can place.
asset_carried :: proc(self: ^Self, owned: ^[string]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.material
    // rust: .split_once(':')
    // rust: .is_some_and(|(ns, _)| owned.contains(&ns))
    // rust: && self.equipment().is_some()
}

    // The 26.3 equipment asset of the material (`layers` by kind), and the 1.21.1 textures to copy, as (from, to) paths in the mod.
equipment :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.material.split_once(':')?;
    // rust: let mut copies = Vec::new();
    // rust: let mut kinds = Map::new();
    // rust: for (kind, legs) in [("humanoid", false), ("humanoid_leggings", true)] {
    // rust: let mut list = Vec::new();
    // rust: for layer in &self.layers {
    // rust: let texture = if legs {
    // rust: &layer.texture_legs
    // rust: } else {
    // rust: &layer.texture
}
    // rust: let (ns, path) = texture.split_once(':')?;
    // rust: let file = path.strip_prefix("textures/models/armor/")?;
    // rust: let name = file.strip_suffix(if legs { "_layer_2.png" } else { "_layer_1.png" })?;
    // rust: copies.push((
    // rust: format!("assets/{ns}/{path}"),
    // rust: format!("assets/{ns}/textures/entity/equipment/{kind}/{name}.png"),
    // rust: ));
    // rust: let mut entry = json!({"texture": format!("{ns}:{name}")});
    // rust: if layer.dyeable {
    // rust: entry["dyeable"] = json!({});
}
    // rust: list.push(entry);
}
    // rust: kinds.insert(kind.into(), Value::Array(list));
}
    // rust: Some((json!({"layers": kinds}), copies))
}
}

// The vanilla item standing in for an item of a vanilla class, for the behaviour the class gives.
item_template :: proc(item: ^Item) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let class = item.class.strip_prefix("net.minecraft.world.item.");
    // rust: match (class, item.armor.as_ref().map(|a| a.slot.as_str())) {
    // rust: (Some("SwordItem"), _) => "minecraft:iron_sword",
    // rust: (Some("PickaxeItem"), _) => "minecraft:iron_pickaxe",
    // rust: (Some("AxeItem"), _) => "minecraft:iron_axe",
    // rust: (Some("ShovelItem"), _) => "minecraft:iron_shovel",
    // rust: (Some("HoeItem"), _) => "minecraft:iron_hoe",
    // rust: (Some("ArmorItem"), Some("head")) => "minecraft:iron_helmet",
    // rust: (Some("ArmorItem"), Some("chest")) => "minecraft:iron_chestplate",
    // rust: (Some("ArmorItem"), Some("legs")) => "minecraft:iron_leggings",
    // rust: (Some("ArmorItem"), Some("feet")) => "minecraft:iron_boots",
    // rust: _ => "minecraft:stick",
}
}

// 1.21.1's `{"modifiers": [...]}` as 26.3's list, with attribute ids' `generic.` and `player.` dropped.
modifiers_26_3 :: proc(v: ^Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let list = v["modifiers"].as_array().cloned().unwrap_or_default();
    // rust: Value::Array(
    // rust: list.into_iter()
    // rust: .map(|mut m| {
    // rust: if let Some(t) = m["type"].as_str() {
    // rust: let t = t.replacen(":generic.", ":", 1).replacen(":player.", ":", 1);
    // rust: m["type"] = json!(t);
}
    // rust: m
    // rust: })
    // rust: .collect(),
    // rust: )
}

VANILLA_PACKAGE :: "net.minecraft."

// A state key with its properties sorted, so keys compare across blocks.
// Which states of a block drop the block itself.
SelfDrop :: enum {
    // Every state: `dropSelf`.
    Always,
    // Only the states where this property has this value.
    When(String, String),
}

// A state key's `property=value` pairs.
pairs :: proc(key: string) -> B {
    // Ported from Horizon
    return {}
}
    // rust: key.split(',')
    // rust: .filter_map(|p| p.split_once('='))
    // rust: .map(|(k, v)| (k.to_owned(), v.to_owned()))
    // rust: .collect()
}

state_key :: proc(key: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut parts: Vec<&str> = key.split(',').filter(|p| !p.is_empty()).collect();
    // rust: parts.sort_unstable();
    // rust: parts.join(",")
}

    // rust: impl Block {
    // The first vanilla class in the chain.
vanilla_class :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.class
    // rust: .iter()
    // rust: .find(|c| c.starts_with(VANILLA_PACKAGE))
    // rust: .map_or("", String::as_str)
}
    // Its own class is a mod class: behaviour code the template may not have.
custom_class :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.class
    // rust: .first()
    // rust: .is_some_and(|c| !c.starts_with(VANILLA_PACKAGE))
}
    // Every state drops one `item` (the block's own) with every tool, except
    // where the state needs a tool and gets none: vanilla's `dropSelf`. Or
    // only the states where one property has one value do, and the others
    // drop nothing with any tool: a door's lower half (`createDoorTable`).
    // Mods often register these tables in code, so their jar has no file.
drops_itself :: proc(self: ^Self, item: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let one = BTreeMap::from([(item.to_owned(), 1)]);
    // rust: let (mut dropping, mut nothing) = (Vec::new(), Vec::new());
    // rust: for (key, state) in &self.states {
    // rust: if state.drops.is_empty() {
    // rust: continue;
}
    // rust: let mut drops = false;
    // rust: let mut short = false;
    // rust: for got in state.drops.values() {
    // rust: if *got == one {
    // rust: drops = true;
    // rust: } else if got.is_empty() {
    // rust: short = true;
    // rust: } else {
    // rust: return None;
}
}
    // rust: match (drops, short) {
    // rust: (true, true) if !state.requires_tool => return None,
    // rust: (true, _) => dropping.push(pairs(key)),
    // rust: (false, _) => nothing.push(pairs(key)),
}
}
    // rust: let (first, rest) = dropping.split_first()?;
    // rust: if nothing.is_empty() {
    // rust: return Some(SelfDrop::Always);
}
    // rust: first
    // rust: .iter()
    // rust: .filter(|pair| rest.iter().all(|s| s.contains(*pair)))
    // rust: .find(|pair| nothing.iter().all(|s| !s.contains(*pair)))
    // rust: .map(|(p, v)| SelfDrop::When(p.clone(), v.clone()))
}
default_state :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.states
    // rust: .get(&self.default)
    // rust: .or_else(|| self.states.values().next())
}
same_states :: proc(self: ^Self, other: ^Block) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.properties.len() == other.properties.len()
    // rust: && self.properties.iter().all(|(k, v)| {
    // rust: other.properties.get(k).is_some_and(|w| {
    // rust: v.iter().collect::<BTreeSet<_>>() == w.iter().collect::<BTreeSet<_>>()
    // rust: })
    // rust: })
}
by_key :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.states.iter().map(|(k, s)| (state_key(k), s)).collect()
}
}

// The template carry-over gives a mod block.
Choice :: struct {
    template: string,
    // `data/<mod>/horizon/block/<name>.json`'s `properties`.
    properties: Map<string,
    // What the template does not reproduce, for the report.
    differences: [dynamic]string,
}

// Equal JSON, numbers compared as f64 (the oracle writes `6.0` where the game's table has `6`).
same :: proc(a: ^Value, b: ^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match (a, b) {
    // rust: (Value::Number(x), Value::Number(y)) => x.as_f64() == y.as_f64(),
    // rust: (Value::Array(x), Value::Array(y)) => {
    // rust: x.len() == y.len() && x.iter().zip(y).all(|(x, y)| same(x, y))
}
    // rust: (Value::Object(x), Value::Object(y)) => {
    // rust: x.len() == y.len() && x.iter().all(|(k, v)| y.get(k).is_some_and(|w| same(v, w)))
}
    // rust: _ => a == b,
}
}

    // rust: impl Facts {
read :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = std::fs::read(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: serde_json::from_slice(&bytes).map_err(|e| format!("{}: {e}", path.display()))
}

    // The vanilla block that best stands in for `id`: the same vanilla
    // class and states, then the most states with the same outline and
    // collision, then the same sounds, set type, wood type and hardness.
    // `None` when no vanilla block has its class and states.
template :: proc(self: ^Self, id: string, allowed: ^dyn Fn(string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let block = self.blocks.get(id)?;
    // rust: let class = block.vanilla_class();
    // rust: let own = block.by_key();
    // rust: let ours = block.default_state()?;
    // rust: let mut best: Option<(i64, &str, &Block)> = None;
    // rust: for (name, v) in &self.blocks {
    // rust: if !name.starts_with("minecraft:")
    // rust: || v.vanilla_class() != class
    // rust: || v.custom_class()
    // rust: || !block.same_states(v)
    // rust: || !allowed(name)
    // rust: {
    // rust: continue;
}
    // rust: let theirs = v.by_key();
    // rust: let shapes = own
    // rust: .iter()
    // rust: .filter(|(k, s)| {
    // rust: theirs
    // rust: .get(*k)
    // rust: .is_some_and(|t| t.outline == s.outline && t.collision == s.collision)
    // rust: })
    // rust: .count() as i64;
    // rust: let Some(td) = v.default_state() else {
    // rust: continue;
}
    // rust: let same_set = match (&block.block_set_type, &v.block_set_type) {
    // rust: (Some(a), Some(b)) => {
    // rust: (a.name == b.name) as i64 * 2
    // rust: + (a.can_open_by_hand == b.can_open_by_hand) as i64 * 8
}
    // rust: _ => 0,
}
    // rust: let score = shapes * 1000
    // rust: + (td.sound == ours.sound) as i64 * 100
    // rust: + same_set * 10
    // rust: + (block.wood_type.is_some() && block.wood_type == v.wood_type) as i64 * 20
    // rust: + (td.hardness == ours.hardness) as i64 * 5
    // rust: + (td.map_color_id == ours.map_color_id) as i64;
    // rust: if best.is_none_or(|(s, n, _)| score > s || (score == s && name.as_str() < n)) {
    // rust: best = Some((score, name, v));
}
}
    // rust: let (_, template, t) = best?;
    // rust: Some(self.choice(block, template, t, allowed))
}

    // rust: fn choice(
    // rust: &self,
    // rust: block: &Block,
    // rust: template: &str,
    // rust: t: &Block,
    // rust: allowed: &dyn Fn(&str) -> bool,
    // rust: ) -> Choice {
    // rust: let (ours, theirs) = (block.default_state(), t.default_state());
    // rust: let mut properties = Map::new();
    // rust: let mut differences = Vec::new();
    // rust: if let Some(s) = ours {
    // rust: properties.insert("hardness".into(), json!(s.hardness));
    // rust: properties.insert(
    // rust: "explosion_resistance".into(),
    // rust: json!(block.explosion_resistance),
    // rust: );
    // rust: properties.insert("light".into(), json!(s.emission));
    // rust: properties.insert("requires_tool".into(), json!(s.requires_tool));
    // rust: properties.insert("friction".into(), json!(block.friction));
    // rust: properties.insert("map_color".into(), json!(s.map_color_id));
    // rust: if theirs.is_none_or(|t| t.sound != s.sound) {
    // rust: match self.sound_block(&s.sound, allowed) {
    // rust: Some(b) => {
    // rust: properties.insert("sounds".into(), json!(b));
}
    // rust: None => differences.push("sounds: no vanilla block has them".into()),
}
}
}
    // rust: if (block.speed_factor, block.jump_factor) != (t.speed_factor, t.jump_factor) {
    // rust: differences.push(format!(
    // rust: "speed and jump factors {} {} (template {} {})",
    // rust: block.speed_factor, block.jump_factor, t.speed_factor, t.jump_factor
    // rust: ));
}
    // rust: let theirs = t.by_key();
    // rust: let mut shapes = 0;
    // rust: let mut varying = BTreeSet::new();
    // rust: let first = ours.map(|s| (s.hardness, s.emission, s.requires_tool, s.map_color_id));
    // rust: for (k, s) in block.by_key() {
    // rust: let Some(v) = theirs.get(&k) else {
    // rust: continue;
}
    // rust: if v.outline != s.outline || v.collision != s.collision {
    // rust: shapes += 1;
}
    // rust: if Some((s.hardness, s.emission, s.requires_tool, s.map_color_id)) != first {
    // rust: varying.insert("per-state hardness, light or map colour");
}
}
    // rust: if shapes > 0 {
    // rust: differences.push(format!(
    // rust: "shapes differ from {template} in {shapes} of {} states",
    // rust: block.states.len()
    // rust: ));
}
    // rust: differences.extend(varying.into_iter().map(str::to_owned));
    // rust: if block.custom_class() {
    // rust: differences.push(format!(
    // rust: "class {} (behaviour beyond {})",
    // rust: block.class[0],
    // rust: block.vanilla_class()
    // rust: ));
}
    // rust: Choice {
    // rust: template: template.to_owned(),
    // rust: properties,
    // rust: differences,
}
}

    // A vanilla block whose default state has these sounds.
sound_block :: proc(self: ^Self, sound: ^Value, allowed: ^dyn Fn(string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks
    // rust: .iter()
    // rust: .filter(|(n, _)| n.starts_with("minecraft:") && allowed(n))
    // rust: .find(|(_, b)| b.default_state().is_some_and(|s| &s.sound == sound))
    // rust: .map(|(n, _)| n.as_str())
}

    // An item declaration for a mod item that is not a declared block's:
    // the vanilla item of its class with its stack size, rarity and numbers,
    // and what it does not reproduce.
item :: proc(self: ^Self, id: string, owned: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let item = self.items.get(id).ok_or("not in the oracle")?;
    // rust: if item.block.is_some() {
    // rust: return Err("a block item without a block".into());
}
    // rust: let mut differences = Vec::new();
    // rust: if !item.class.starts_with(VANILLA_PACKAGE) {
    // rust: differences.push(format!("class {} (behaviour beyond Item)", item.class));
}
    // rust: if item.food.is_some() {
    // rust: return Err("food (no food template yet)".into());
}
    // rust: let template = item_template(item);
    // rust: let mut decl = json!({"template": template});
    // rust: if item.max_stack_size != 64 {
    // rust: decl["max_stack_size"] = json!(item.max_stack_size);
}
    // rust: if item.rarity != "common" {
    // rust: decl["rarity"] = json!(item.rarity);
}
    // rust: if let Some(armor) = item.armor.as_ref().filter(|a| !a.material.is_empty())
    // rust: && !self.armor_asset_exists(armor, owned)
    // rust: {
    // rust: differences.push(format!(
    // rust: "armour material {} has no equipment asset: it draws the template's",
    // rust: armor.material
    // rust: ));
}
    // rust: let components = self.item_components(item, template, owned);
    // rust: if !components.is_empty() {
    // rust: decl["components"] = Value::Object(components);
}
    // rust: Ok((decl, differences))
}

    // The item's numbers as a 26.3 component patch over `template`'s, leaving out what already matches.
armor_asset_exists :: proc(self: ^Self, armor: ^Armor, owned: ^[string]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: armor.asset_carried(owned)
    // rust: || self.vanilla_items.values().any(|i| {
    // rust: i["minecraft:equippable"]["asset_id"].as_str() == Some(armor.material.as_str())
    // rust: })
}

item_components :: proc(self: ^Self, item: ^Item, template: string, owned: ^[string]) -> M {
    // Ported from Horizon
    return {}
}
    // rust: if item.components.is_empty() {
    // rust: return Map::new();
}
    // rust: let base = self.vanilla_items.get(template);
    // rust: let mut want = Map::new();
    // rust: want.insert(
    // rust: "minecraft:max_damage".into(),
    // rust: item.components
    // rust: .get("minecraft:max_damage")
    // rust: .cloned()
    // rust: .unwrap_or(Value::Null),
    // rust: );
    // rust: if let Some(m) = &item.attribute_modifiers {
    // rust: want.insert("minecraft:attribute_modifiers".into(), modifiers_26_3(m));
}
        // The mod's rules as they are; what 1.21.1 kept in the class (can_destroy_blocks_in_creative) stays the template's.
    // rust: let tool = item.components.get("minecraft:tool").map(|t| {
    // rust: let mut tool = base
    // rust: .and_then(|b| b.get("minecraft:tool"))
    // rust: .cloned()
    // rust: .unwrap_or_else(|| json!({}));
    // rust: for key in ["rules", "default_mining_speed", "damage_per_block"] {
    // rust: match t.get(key) {
    // rust: Some(v) => tool[key] = v.clone(),
    // rust: None => _ = tool.as_object_mut().map(|o| o.remove(key)),
}
}
    // rust: tool
    // rust: });
    // rust: want.insert("minecraft:tool".into(), tool.unwrap_or(Value::Null));
    // rust: if let Some(value) = item.enchantment_value {
    // rust: let enchantable = (value > 0).then(|| json!({"value": value}));
    // rust: want.insert(
    // rust: "minecraft:enchantable".into(),
    // rust: enchantable.unwrap_or(Value::Null),
    // rust: );
}
    // rust: if let Some(repair) = &item.repair_items {
    // rust: let items = match repair.as_slice() {
    // rust: [] => Value::Null,
    // rust: [one] => json!({"items": one}),
    // rust: many => json!({"items": many}),
}
    // rust: want.insert("minecraft:repairable".into(), items);
}
    // rust: if let Some(armor) = item.armor.as_ref().filter(|a| !a.material.is_empty()) {
    // rust: let mut equippable = base.and_then(|b| b.get("minecraft:equippable")).cloned();
    // rust: if self.armor_asset_exists(armor, owned) {
    // rust: equippable.get_or_insert_with(|| json!({"slot": armor.slot}))["asset_id"] =
    // rust: json!(armor.material);
}
    // rust: if let Some(mut equippable) = equippable {
    // rust: if let Some(sound) = &armor.equip_sound {
    // rust: equippable["equip_sound"] = json!(sound);
}
    // rust: want.insert("minecraft:equippable".into(), equippable);
}
}
    // rust: let mut patch = Map::new();
    // rust: for (key, value) in want {
    // rust: let had = base.and_then(|b| b.get(&key));
    // rust: match (value, had) {
    // rust: (Value::Null, None) => {}
    // rust: (Value::Null, Some(_)) => _ = patch.insert(format!("!{key}"), json!({})),
    // rust: (v, Some(h)) if same(&v, h) => {}
    // rust: (v, _) => _ = patch.insert(key, v),
}
}
    // rust: patch
}

    // A tag's members the content mod may name: vanilla's and its own.
tag_members :: proc(self: ^Self, kind: string, tag: string, own: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let map = if kind == "block" {
    // rust: &self.tags.block
    // rust: } else {
    // rust: &self.tags.item
}
    // rust: let members = map.get(tag)?;
    // rust: Some(
    // rust: members
    // rust: .iter()
    // rust: .filter(|m| {
    // rust: m.split_once(':')
    // rust: .is_some_and(|(ns, _)| ns == "minecraft" || ns == own)
    // rust: })
    // rust: .cloned()
    // rust: .collect(),
    // rust: )
}
}

    // rust: mod tests {
//     use super::*;

state :: proc(hardness: f32, sound: string, outline: Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: json!({"hardness": hardness, "emission": 0, "requires_tool": false, "map_color_id": 13,
    // rust: "sound": {"break": sound}, "outline": outline, "collision": outline})
}
block :: proc(class: ^[string], props: Value, states: Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let default = states
    // rust: .as_object()
    // rust: .unwrap()
    // rust: .keys()
    // rust: .next()
    // rust: .unwrap()
    // rust: .to_owned();
    // rust: json!({"class": class, "properties": props, "default": default, "item": "x",
    // rust: "explosion_resistance": 3.0, "friction": 0.6, "speed_factor": 1.0,
    // rust: "jump_factor": 1.0, "states": states})
}

templates_follow_class_shapes_and_sounds :: proc() {
}
    // rust: let cube = json!([[0, 0, 0, 1, 1, 1]]);
    // rust: let low = json!([[0, 0, 0, 1, 0.9375, 1]]);
    // rust: let block_class = ["net.minecraft.world.level.block.Block"];
    // rust: let path = ["net.minecraft.world.level.block.DirtPathBlock"];
    // rust: let facts: Facts = serde_json::from_value(json!({
    // rust: "blocks": {
    // rust: "minecraft:stone": block(&block_class, json!({}), json!({"": state(1.5, "stone", cube.clone())})),
    // rust: "minecraft:oak_planks": block(&block_class, json!({}), json!({"": state(2.0, "wood", cube.clone())})),
    // rust: "minecraft:dirt_path": block(&path, json!({}), json!({"": state(0.65, "grass", low.clone())})),
    // rust: "m:wood_tile": block(&["m.Tile", block_class[0]], json!({}), json!({"": state(2.5, "wood", cube.clone())})),
    // rust: "m:path": block(&["m.Path", block_class[0]], json!({}), json!({"": state(1.0, "stone", low.clone())})),
    // rust: "m:gadget": block(&["m.Gadget", block_class[0]], json!({"mode": ["a", "b"]}),
    // rust: json!({"mode=a": state(1.0, "stone", cube.clone()), "mode=b": state(1.0, "stone", cube)})),
    // rust: },
    // rust: "items": {}
    // rust: }))
    // rust: .unwrap();
    // rust: let any = |_: &str| true;
    // rust: let tile = facts.template("m:wood_tile", &any).unwrap();
    // rust: assert_eq!(tile.template, "minecraft:oak_planks");
    // rust: assert_eq!(tile.properties["hardness"], json!(2.5));
    // rust: assert!(!tile.properties.contains_key("sounds"));
    // rust: assert_eq!(
    // rust: tile.differences,
    // rust: ["class m.Tile (behaviour beyond net.minecraft.world.level.block.Block)"]
    // rust: );
        // A plain Block is never templated on a DirtPathBlock: shapes differ, and say so.
    // rust: let path = facts.template("m:path", &any).unwrap();
    // rust: assert_eq!(path.template, "minecraft:stone");
    // rust: assert!(
    // rust: path.differences[0].starts_with("shapes differ"),
    // rust: "{:?}",
    // rust: path.differences
    // rust: );
    // rust: assert_eq!(facts.template("m:gadget", &any), None);
    // rust: let tile = facts
    // rust: .template("m:wood_tile", &|n: &str| n != "minecraft:oak_planks")
    // rust: .unwrap();
    // rust: assert_eq!(tile.template, "minecraft:stone");
    // rust: assert_eq!(tile.differences[0], "sounds: no vanilla block has them");
}

drops_itself_is_vanillas_drop_self :: proc() {
}
    // rust: let cube = json!([[0, 0, 0, 1, 1, 1]]);
    // rust: let with = |requires_tool: bool, drops: Value| {
    // rust: let mut s = state(1.5, "stone", cube.clone());
    // rust: s["requires_tool"] = json!(requires_tool);
    // rust: s["drops"] = drops;
    // rust: let b: Block = serde_json::from_value(block(&[], json!({}), json!({"": s}))).unwrap();
    // rust: b.drops_itself("m:tile")
}
    // rust: let me = json!({"m:tile": 1});
    // rust: let always = Some(SelfDrop::Always);
    // rust: assert_eq!(with(false, json!({"hand": me, "shears": me})), always);
        // A state that needs a tool drops nothing by hand, as dropSelf does.
    // rust: assert_eq!(
    // rust: with(true, json!({"hand": {}, "diamond_pickaxe": me})),
    // rust: always
    // rust: );
    // rust: assert_eq!(
    // rust: with(false, json!({"hand": {}, "diamond_pickaxe": me})),
    // rust: None
    // rust: );
        // Two of itself (a double slab), or something else, is not dropSelf.
    // rust: assert_eq!(with(false, json!({"hand": {"m:tile": 2}})), None);
    // rust: assert_eq!(with(false, json!({"hand": {"m:other": 1}})), None);
    // rust: assert_eq!(with(false, json!({})), None);
}

a_door_drops_from_its_lower_half :: proc() {
}
    // rust: let cube = json!([[0, 0, 0, 1, 1, 1]]);
    // rust: let me = json!({"hand": {"m:door": 1}, "shears": {"m:door": 1}});
    // rust: let none = json!({"hand": {}, "shears": {}});
    // rust: let door = |upper: &Value| {
    // rust: let mut states = serde_json::Map::new();
    // rust: for (key, drops) in [
    // rust: ("half=lower,open=false", &me),
    // rust: ("half=lower,open=true", &me),
    // rust: ("half=upper,open=false", upper),
    // rust: ("half=upper,open=true", upper),
    // rust: ] {
    // rust: let mut s = state(3.0, "wood", cube.clone());
    // rust: s["drops"] = drops.clone();
    // rust: states.insert(key.to_owned(), s);
}
    // rust: let props = json!({"half": ["upper", "lower"], "open": ["true", "false"]});
    // rust: let b: Block =
    // rust: serde_json::from_value(block(&[], props, Value::Object(states))).unwrap();
    // rust: b.drops_itself("m:door")
}
    // rust: assert_eq!(
    // rust: door(&none),
    // rust: Some(SelfDrop::When("half".to_owned(), "lower".to_owned()))
    // rust: );
    // rust: assert_eq!(door(&me), Some(SelfDrop::Always));
        // Something else from the upper half: not a door table.
    // rust: assert_eq!(door(&json!({"hand": {"m:other": 1}})), None);
}

items_of_vanilla_classes_take_their_template_and_numbers :: proc() {
}
    // rust: let mut facts: Facts = serde_json::from_value(json!({
    // rust: "blocks": {},
    // rust: "items": {
    // rust: "m:sword": {"class": "net.minecraft.world.item.SwordItem", "max_stack_size": 1, "rarity": "common",
    // rust: "components": {"minecraft:max_damage": 905, "minecraft:tool": {"rules": [
    // rust: {"blocks": "minecraft:cobweb", "speed": 15.0, "correct_for_drops": true}], "damage_per_block": 2}},
    // rust: "attribute_modifiers": {"modifiers": [{"type": "minecraft:generic.attack_damage",
    // rust: "id": "minecraft:base_attack_damage", "amount": 5.5, "operation": "add_value", "slot": "mainhand"}]},
    // rust: "enchantment_value": 14, "repair_items": ["minecraft:emerald"]},
    // rust: "m:boots": {"class": "net.minecraft.world.item.ArmorItem", "max_stack_size": 1, "rarity": "common",
    // rust: "components": {"minecraft:max_damage": 1}, "enchantment_value": 0, "repair_items": [],
    // rust: "armor": {"slot": "feet"}},
    // rust: "m:gem": {"class": "net.minecraft.world.item.Item", "max_stack_size": 64, "rarity": "common"},
}
    // rust: }))
    // rust: .unwrap();
    // rust: facts.vanilla_items = serde_json::from_value(json!({
    // rust: "minecraft:iron_sword": {"minecraft:max_damage": 250, "minecraft:enchantable": {"value": 14},
    // rust: "minecraft:repairable": {"items": "#minecraft:iron_tool_materials"},
    // rust: "minecraft:tool": {"can_destroy_blocks_in_creative": false, "damage_per_block": 2,
    // rust: "rules": [{"blocks": "#minecraft:sword_efficient", "speed": 1.5}]}},
    // rust: "minecraft:iron_boots": {"minecraft:max_damage": 195, "minecraft:enchantable": {"value": 9},
    // rust: "minecraft:repairable": {"items": "#minecraft:repairs_iron_armor"}},
    // rust: }))
    // rust: .unwrap();
    // rust: let (sword, _) = facts.item("m:sword", &["m"]).unwrap();
    // rust: assert_eq!(sword["template"], "minecraft:iron_sword");
    // rust: let c = &sword["components"];
    // rust: assert_eq!(c["minecraft:max_damage"], 905);
    // rust: assert_eq!(
    // rust: c["minecraft:attribute_modifiers"][0]["type"],
    // rust: "minecraft:attack_damage"
    // rust: );
    // rust: assert_eq!(
    // rust: c["minecraft:repairable"],
    // rust: json!({"items": "minecraft:emerald"})
    // rust: );
        // The mod's rules replace the template's; the creative flag the class gave stays.
    // rust: assert_eq!(
    // rust: c["minecraft:tool"],
    // rust: json!({"can_destroy_blocks_in_creative": false, "damage_per_block": 2,
    // rust: "rules": [{"blocks": "minecraft:cobweb", "speed": 15.0, "correct_for_drops": true}]})
    // rust: );
        // Equal to the template's: left out.
    // rust: assert!(c.get("minecraft:enchantable").is_none());
    // rust: let (boots, _) = facts.item("m:boots", &["m"]).unwrap();
    // rust: assert_eq!(boots["template"], "minecraft:iron_boots");
    // rust: assert_eq!(boots["components"]["!minecraft:enchantable"], json!({}));
    // rust: assert_eq!(boots["components"]["!minecraft:repairable"], json!({}));
        // Facts without components (exported before they were) keep the plain template.
    // rust: let (gem, _) = facts.item("m:gem", &["m"]).unwrap();
    // rust: assert_eq!(gem, json!({"template": "minecraft:stick"}));
}

armour_materials_become_equipment_assets :: proc() {
}
    // rust: let armor: Armor = serde_json::from_value(json!({"slot": "legs", "material": "m:ruby",
    // rust: "equip_sound": "minecraft:item.armor.equip_diamond", "layers": [
    // rust: {"texture": "m:textures/models/armor/ruby_layer_1.png",
    // rust: "texture_legs": "m:textures/models/armor/ruby_layer_2.png", "dyeable": false},
    // rust: {"texture": "m:textures/models/armor/ruby_overlay_layer_1.png",
    // rust: "texture_legs": "m:textures/models/armor/ruby_overlay_layer_2.png", "dyeable": true}]}))
    // rust: .unwrap();
    // rust: let (asset, copies) = armor.equipment().unwrap();
    // rust: assert_eq!(
    // rust: asset["layers"]["humanoid_leggings"],
    // rust: json!([{"texture": "m:ruby"}, {"texture": "m:ruby_overlay", "dyeable": {}}])
    // rust: );
    // rust: assert_eq!(
    // rust: copies[2],
    // rust: (
    // rust: "assets/m/textures/models/armor/ruby_layer_2.png".to_owned(),
    // rust: "assets/m/textures/entity/equipment/humanoid_leggings/ruby.png".to_owned()
    // rust: )
    // rust: );
    // rust: let mut facts: Facts =
    // rust: serde_json::from_value(json!({"blocks": {}, "items": {"m:ruby_leggings": {
    // rust: "class": "net.minecraft.world.item.ArmorItem", "max_stack_size": 1, "rarity": "common",
    // rust: "components": {"minecraft:max_damage": 300}, "armor": armor_json()}}}))
    // rust: .unwrap();
    // rust: facts.vanilla_items = serde_json::from_value(json!({"minecraft:iron_leggings": {
    // rust: "minecraft:equippable": {"asset_id": "minecraft:iron", "equip_sound": "minecraft:item.armor.equip_iron", "slot": "legs"}}}))
    // rust: .unwrap();
    // rust: let (decl, _) = facts.item("m:ruby_leggings", &["m"]).unwrap();
    // rust: assert_eq!(
    // rust: decl["components"]["minecraft:equippable"],
    // rust: json!({"asset_id": "m:ruby", "equip_sound": "minecraft:item.armor.equip_diamond", "slot": "legs"})
    // rust: );
        // Layers outside models/armor/ have no 26.3 place to go.
    // rust: let odd: Armor =
    // rust: serde_json::from_value(json!({"slot": "head", "material": "m:odd", "layers": [
    // rust: {"texture": "m:textures/odd.png", "texture_legs": "m:textures/odd.png"}]}))
    // rust: .unwrap();
    // rust: assert!(odd.equipment().is_none());
}

armour_only_names_an_equipment_asset_that_exists :: proc() {
}
    // rust: let leggings = |material: &str, layers: Value| {
    // rust: json!({"class": "net.minecraft.world.item.ArmorItem", "max_stack_size": 1, "rarity": "common",
    // rust: "components": {"minecraft:max_damage": 300},
    // rust: "armor": {"slot": "legs", "material": material,
    // rust: "equip_sound": "minecraft:item.armor.equip_diamond", "layers": layers}})
}
    // rust: let odd = json!([{"texture": "m:textures/odd.png", "texture_legs": "m:textures/odd.png"}]);
    // rust: let mut facts: Facts = serde_json::from_value(json!({"blocks": {}, "items": {
    // rust: "m:ruby": leggings("m:ruby", json!([])),
    // rust: "m:odd": leggings("m:odd", odd),
    // rust: "m:other": leggings("other:steel", json!([])),
    // rust: "m:unknown": leggings("minecraft:steel", json!([])),
    // rust: "m:diamond": leggings("minecraft:diamond", json!([]))}}))
    // rust: .unwrap();
    // rust: facts.vanilla_items = serde_json::from_value(json!({
    // rust: "minecraft:iron_leggings": {"minecraft:equippable": {"asset_id": "minecraft:iron", "slot": "legs"}},
    // rust: "minecraft:diamond_leggings": {"minecraft:equippable": {"asset_id": "minecraft:diamond", "slot": "legs"}}}))
    // rust: .unwrap();
    // rust: let asset = |id: &str| {
    // rust: let (decl, differences) = facts.item(id, &["m"]).unwrap();
    // rust: let asset = decl["components"]["minecraft:equippable"]["asset_id"].clone();
    // rust: (asset, !differences.is_empty())
}
    // rust: assert_eq!(asset("m:ruby"), (json!("m:ruby"), false));
    // rust: assert_eq!(asset("m:diamond"), (json!("minecraft:diamond"), false));
    // rust: for id in ["m:odd", "m:other", "m:unknown"] {
    // rust: assert_eq!(asset(id), (json!("minecraft:iron"), true), "{id}");
}
        // Without the game's tables the template's own component stays whole.
    // rust: facts.vanilla_items.clear();
    // rust: let (decl, _) = facts.item("m:odd", &["m"]).unwrap();
    // rust: assert!(decl["components"].get("minecraft:equippable").is_none());
}

armor_json :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: json!({"slot": "legs", "material": "m:ruby", "equip_sound": "minecraft:item.armor.equip_diamond"})
}

state_keys_sort :: proc() {
}
    // rust: assert_eq!(
    // rust: state_key("half=lower,facing=north"),
    // rust: "facing=north,half=lower"
    // rust: );
    // rust: assert_eq!(state_key(""), "");
}
}
