//! Transpiled from Horizon Rust crate
//! Module: horizon-world_loot
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Loot tables: `LootTable.fill` for chest-style loot tables (pools,
//! weighted entries, nested tables, item modifiers and conditions, the
//! stack splitter and the slot shuffle) and `LootTable.getRandomItems` for
//! entity loot (the victim, its killer, the damage source and the last
//! player to hurt it), with vanilla's random draw order.
//!
//! Items keep their id, count, damage, enchantments and potion. Exploration
//! maps are kept as found (structure search is not run); conditions that
//! need an entity, tool or damage source fail when the context has none, as
//! they do for containers.
// use crate::{lazy_json::LazyJson, nbt::Tag};
// use horizon_core::random::{LegacyRandom, RandomSource};
// use serde_json::Value;
// use std::{
    // rust: cell::RefCell,
    // rust: collections::HashMap,
    // rust: fs, io,
    // rust: path::Path,
    // rust: rc::Rc,
    // rust: sync::{Arc, Mutex, Weak},
}

/// Raw files a world's data packs add over the game's own data, by
/// `<kind>/<ns>:<path>` (a `recipe/minecraft:stick` key names the file
/// `data/minecraft/recipe/stick.json`), each id's files in pack order.
/// `datapack::DataStore.files` is the source; the content tables merge these
/// over what they read from the resource root, the way
/// `SimpleJsonResourceReloadListener` and `TagLoader` layer a pack stack.
pub const PackOverlay = struct {
    files: *'a [([]const u8,
};
    // rust: impl PackOverlay<'static> {
    /// No packs: the tables are the resource root's alone.
pub const NONE: Self = Self { files: &[] };
}
    // rust: impl PackOverlay<'_> {
    /// The overlay's files under `<kind>/`, with the prefix stripped.
pub fn kind(self: *Self, kind: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let prefix = format!("{kind}/");
    // rust: self.files
    // rust: .iter()
    // rust: .filter_map(move |(key, files)| Some((key.strip_prefix(&prefix)?, files)))
}
    /// The overlay's tag files of one registry, over every namespace: the
    /// keys are `tags/<ns>:<registry>/<path>`, and the yielded id is the
    /// tag id `<ns>:<path>` the game's own tags are keyed by
    /// (`TagLoader`'s ids).
pub fn tag_kind(self: *Self, registry: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let prefix = format!("{registry}/");
    // rust: self.files.iter().filter_map(move |(key, files)| {
    // rust: let rest = key.strip_prefix("tags/")?;
    // rust: let (ns, path) = rest.split_once(':')?;
    // rust: let path = path.strip_prefix(&prefix)?;
    // rust: Some((format!("{ns}:{path}"), files))
    // rust: })
}
    /// The last pack's file for an id, which is the one
    /// `ResourceManager.listMatchingResources` hands out.
pub fn top(files: *[std.ArrayList(u8)]) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: files.last().map(Vec::as_slice).unwrap_or_default()
}
}

/// A loot function of a mod's own kind: the entry named a `type` in a
/// namespace outside `minecraft:`, and the roll kept it for this call.
/// The kind, the JSON, the context and the stack to change are here.
/// API 133.
    // rust: pub fn native_loot_function(
    // rust: kind: &str,
    // rust: data: &Value,
    // rust: ctx: &NativeLootContext<'_>,
    // rust: stack: &mut LootStack,
    // rust: ) {
    // rust: crate::native_load_hooks::loot_function(kind, data, ctx, stack);
}

/// A loot condition of a mod's own kind: the entry named a `type` in a
/// namespace outside `minecraft:`. The kind, the JSON, the context and
/// whether it holds are here (`holds` starts `false`; a mod that claims
/// the kind sets it). API 133.
    // rust: pub fn native_loot_condition(
    // rust: kind: &str,
    // rust: data: &Value,
    // rust: ctx: &NativeLootContext<'_>,
    // rust: holds: &mut bool,
    // rust: ) {
    // rust: crate::native_load_hooks::loot_condition(kind, data, ctx, holds);
}

/// The tool a loot context names: its item id and enchantments.
pub const NativeLootTool = struct {
    item: []const u8,
    enchantments: Vec<([]const u8,
};

/// What a mod's own loot kinds see of the roll: the entity, the damage,
/// the player who killed it, the tool, the block, the luck, the biome,
/// where the roll happens, and a seed from the roll's random. The tool and
/// block are filled by the items engine (block drops, entity drops,
/// loot_table, interact_loot); the entity, damage and player by the main
/// loot engine; each is None in the other. A table without a mod's kinds
/// draws nothing and stays bit-for-bit the same.
pub const NativeLootContext = struct {
    /// The entity the table names (`this`), if any.
    entity: ?*'a LootEntity,
    /// The damage that killed it, if any.
    damage: ?*'a LootDamage,
    /// The player whose kill dropped the table (`LootEntity`), if any.
    player: ?*'a LootEntity,
    /// The tool used, if any. The items engine fills it (all of its
    /// tables: block drops, entity drops, loot_table, interact_loot);
    /// the main loot engine has no tool in its context.
    tool: ?NativeLootTool,
    /// The block a block-drop table breaks, if any. The items engine
    /// fills it; the main loot engine has no block in its context.
    block: ?*'a str,
    /// `LootContext.getLuck`.
    luck: f32,
    /// The biome the roll is in, if any.
    biome: ?*'a str,
    /// A seed from the roll's random, for a mod's own draws. Drawn only
    /// when a mod's kind is in the table.
    seed: i64,
    /// Where the roll happens: the origin, the block entity and the level,
    /// when the game rolled the table at a place (a broken block's drops,
    /// a mob's death loot); None for the other rolls. Either engine fills it.
    /// API 156.
    place: ?*NativeLootPlace,
};

/// Where a loot roll happens, as a mod's own loot kinds see it:
/// `LootContextParams.ORIGIN`, `LootContextParams.BLOCK_ENTITY`, and what
/// vanilla's own conditions read of `LootContext.getLevel` (`TimeCheck`:
/// the time; `WeatherCheck`: the rain and the thunder). The game sets it
/// around a roll with [`with_native_loot_place`]. API 156.
pub const NativeLootPlace = struct {
    /// `ORIGIN`: a broken block's centre, a dead mob's position.
    origin: Option<[f64,
    /// `BLOCK_ENTITY`: the broken block's entity as it was before the
    /// break, saved with its id and position (`saveWithFullMetadata`); a
    /// mod's block entity carries its own data and its `Items`.
    block_entity: ?Tag,
    /// The level the roll is in.
    level: ?NativeLootLevel,
};

/// The level a loot roll is in, as a mod's own loot kinds see it.
pub const NativeLootLevel = struct {
    /// The dimension's id (`minecraft:overworld`).
    dimension: []const u8,
    /// `Level.getGameTime`.
    game_time: i64,
    /// `Level.getDayTime`: it counts on from day to day, so the time of
    /// day is `day_time % 24000` (night from 13000 to 23000).
    day_time: i64,
    /// `Level.isRaining`.
    raining: bool,
    /// `Level.isThundering`.
    thundering: bool,
};

    // rust: thread_local! {
pub const NATIVE_LOOT_PLACE: RefCell<?*NativeLootPlace> = const { RefCell::new(None) };
}

/// Runs `roll` with `place` as where its loot rolls happen: every
/// [`NativeLootContext`] made inside it, by either engine, carries it. The
/// place before is back when `roll` returns, so these nest.
/// API 156.
    // rust: pub fn with_native_loot_place<T>(place: NativeLootPlace, roll: impl FnOnce() -> T) -> T {
pub const Restore = struct {};
    // rust: impl Drop for Restore {
pub fn drop(self: *Self) void {
}
    // rust: let before = self.0.take();
    // rust: NATIVE_LOOT_PLACE.with(|p| *p.borrow_mut() = before);
}
}
    // rust: let _restore = Restore(NATIVE_LOOT_PLACE.with(|p| p.replace(Some(Rc::new(place)))));
    // rust: roll()
}

/// The place [`with_native_loot_place`] set for the rolls now running, if any.
pub fn current_native_loot_place() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NATIVE_LOOT_PLACE.with(|p| p.borrow().clone())
}

/// One generated item stack.
pub const LootStack = struct {
    item: []const u8,
    count: i32,
    damage: i32,
    enchantments: Vec<([]const u8,
    potion: ?[]const u8,
    /// Set by exploration_map (the map_id component of a found map).
    map: bool,
    /// The search an exploration_map function asked for, left to the game
    /// (it needs the level's structures and maps).
    exploration: ?*ExplorationMap,
    /// Set by set_ominous_bottle_amplifier.
    ominous_amplifier: ?i32,
    /// Added by set_stew_effect (the `suspicious_stew_effects` component):
    /// (effect id, duration in ticks).
    stew_effects: Vec<([]const u8,
    /// Set by set_name: (`custom_name` or `item_name`, the text component).
    names: Vec<([]const u8,
    /// Set by set_components: (component id, its JSON value; null removes
    /// it), a later patch of the same id replacing an earlier one.
    components: Vec<([]const u8,
};
/// `ExplorationMapFunction`'s settings.
pub const ExplorationMap = struct {
    /// A structure tag, without `#`.
    destination: []const u8,
    decoration: []const u8,
    zoom: u8,
    search_radius: i32,
    skip_existing_chunks: bool,
};
    // rust: impl ExplorationMap {
    /// The function's fields with their codec defaults (`DEFAULT_DESTINATION`
    /// on_treasure_maps, `DEFAULT_DECORATION` mansion, zoom 2, radius 50,
    /// skipping known structures).
pub fn from_json(f: *Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: destination: f["destination"]
    // rust: .as_str()
    // rust: .unwrap_or("#minecraft:on_treasure_maps")
    // rust: .trim_start_matches('#')
    // rust: .to_owned(),
    // rust: decoration: f["decoration"]
    // rust: .as_str()
    // rust: .unwrap_or("minecraft:mansion")
    // rust: .to_owned(),
    // rust: zoom: f["zoom"].as_u64().unwrap_or(2) as u8,
    // rust: search_radius: f["search_radius"].as_i64().unwrap_or(50) as i32,
    // rust: skip_existing_chunks: f["skip_existing_chunks"].as_bool().unwrap_or(true),
}
}
}
    // rust: impl LootStack {
pub fn new(item: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: item: item.to_owned(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: enchantments: Vec::new(),
    // rust: potion: None,
    // rust: map: false,
    // rust: exploration: None,
    // rust: ominous_amplifier: None,
    // rust: stew_effects: Vec::new(),
    // rust: names: Vec::new(),
    // rust: components: Vec::new(),
}
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.count <= 0 || self.item == "minecraft:air"
}
    /// `ItemStack.getCount`: 0 for an empty stack.
pub fn get_count(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() { 0 } else { self.count }
}
}

pub const ItemFacts = struct {
    max_stack: i32,
    max_damage: i32,
    enchantable: ?i32,
};
pub const Enchantment = struct {
    name: []const u8,
    supported: Value,
    primary: ?Value,
    exclusive: Value,
    max_level: i32,
    weight: i32,
    min_cost: (i32,
    max_cost: (i32,
    /// `slots`: the equipment slot groups the enchantment works in.
    slots: std.ArrayList([]const u8),
    /// `effects` (equipment_drops and others).
    effects: Value,
};
    // rust: impl Enchantment {
pub fn min_cost(self: *Self, level: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min_cost.0 + self.min_cost.1 * (level - 1)
}
pub fn max_cost(self: *Self, level: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.max_cost.0 + self.max_cost.1 * (level - 1)
}
}

/// Loot tables, items, enchantments and the tags they reference.
pub const LootData = struct {
    tables: *LootTables,
    modifiers: HashMap<[]const u8,
    predicates: HashMap<[]const u8,
    items: HashMap<[]const u8,
    /// Enchantments in registry (identifier) order.
    enchantments: std.ArrayList(Enchantment),
    /// Raw tag files by (registry, tag id).
    tags: HashMap<([]const u8,
    /// Smelting recipes in recipe id order: (ingredient, result, result count).
    smelting: Vec<(Value,
};

/// An entity a loot context names (`this`, `attacker`, `direct_attacker`,
/// `attacking_player`): the facts entity predicates read.
pub const LootEntity = struct {
    /// Entity type id (`minecraft:zombie`).
    kind: []const u8,
    /// A `LivingEntity` (has equipment and enchantment levels).
    living: bool,
    /// `Entity.isOnFire` (fire-immune entities never are).
    on_fire: bool,
    baby: bool,
    /// The entity it rides (`getVehicle`).
    vehicle: ?*LootEntity,
    /// `AbstractCubeMob.getSize`.
    cube_size: ?i32,
    /// A sheep's colour name and whether it is sheared.
    sheep: Option<([]const u8,
    /// A raider: whether it is a captain (wears the ominous banner).
    captain: ?bool,
    /// A frog's variant id (`minecraft:warm`).
    frog_variant: ?[]const u8,
    /// A chicken's variant id (`minecraft:warm`).
    chicken_variant: ?[]const u8,
    /// A charged creeper (`Creeper.isPowered`).
    powered: bool,
    /// Worn and held items by `EquipmentSlot` name (mainhand, offhand,
    /// feet, legs, chest, head, body, saddle).
    equipment: Vec<([]const u8,
};
    // rust: impl LootEntity {
pub fn new(kind: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: kind: kind.to_owned(),
    // rust: living: true,
    // rust: ..Self::default()
}
}
pub fn item(self: *Self, slot: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.equipment
    // rust: .iter()
    // rust: .find(|(s, i)| s == slot && !i.is_empty())
    // rust: .map(|(_, i)| i)
}
}
/// A `DamageSource`: its damage type and the entities behind it.
pub const LootDamage = struct {
    /// Damage type id (`minecraft:player_attack`).
    kind: []const u8,
    /// `getEntity`: the attacker (the shooter of a projectile).
    source: ?LootEntity,
    /// `getDirectEntity`: the projectile, or the attacker itself.
    direct: ?LootEntity,
};
/// The parameters of `LivingEntity.dropFromLootTable`.
pub const EntityLootParams = struct {
    this: LootEntity,
    damage: ?LootDamage,
    /// `LAST_DAMAGE_PLAYER`: set when a player killed the entity.
    player: ?LootEntity,
    /// The killing player's luck.
    luck: f32,
};
/// `EquipmentSlot.VALUES` order.
    // rust: pub const EQUIPMENT_SLOTS: [&str; 8] = [
    // rust: "mainhand", "offhand", "feet", "legs", "chest", "head", "body", "saddle",
    // rust: ];
/// `EquipmentSlotGroup.test`.
pub fn slot_in_group(slot: []const u8, group: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match group {
    // rust: "any" => true,
    // rust: "hand" => slot == "mainhand" || slot == "offhand",
    // rust: "armor" => matches!(slot, "feet" | "legs" | "chest" | "head" | "body"),
    // rust: _ => slot == group,
}
}
/// The item a recipe's `result` names. `ItemStackTemplate.CODEC` and `TransmuteResult.CODEC`
/// read a stack's fields (`id`, `count`, `components`) or, as their alternative, a bare item id
/// (`Item.CODEC`): `"result": {"id": "mod:item"}` and `"result": "mod:item"` are the same item.
/// None for a stack without an `id` and for anything else, such as the `item` key of older
/// versions.
pub fn recipe_result_id(result: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match result {
    // rust: Value::String(id) => Some(id),
    // rust: Value::Object(fields) => fields.get("id")?.as_str(),
    // rust: _ => None,
}
}
/// `LevelBasedValue.calculate`.
pub fn level_value(v: *Value, level: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::Number(n) => n.as_f64().unwrap_or(0.) as f32,
    // rust: Value::Object(_) => match v["type"].as_str().unwrap_or("") {
    // rust: "minecraft:linear" => {
    // rust: level_value(&v["base"], level)
    // rust: + level_value(&v["per_level_above_first"], level) * (level - 1) as f32
}
    // rust: "minecraft:constant" => level_value(&v["value"], level),
    // rust: "minecraft:clamped" => {
    // rust: let value = level_value(&v["value"], level);
    // rust: let min = v["min"].as_f64().unwrap_or(0.) as f32;
    // rust: let max = v["max"].as_f64().unwrap_or(0.) as f32;
    // rust: value.clamp(min, max)
}
    // rust: "minecraft:fraction" => {
    // rust: level_value(&v["numerator"], level) / level_value(&v["denominator"], level)
}
    // rust: "minecraft:levels_squared" => {
    // rust: (level * level) as f32 + v["added"].as_f64().unwrap_or(0.) as f32
}
    // rust: "minecraft:lookup" => {
    // rust: let values = v["values"].as_array().map_or(&[][..], Vec::as_slice);
    // rust: match values.get((level - 1).max(0) as usize) {
    // rust: Some(x) if level >= 1 => x.as_f64().unwrap_or(0.) as f32,
    // rust: _ => level_value(&v["fallback"], level),
}
}
    // rust: _ => 0.,
    // rust: },
    // rust: _ => 0.,
}
}
/// `MinMaxBounds.Ints.matches` (a number or `{min, max}`).
pub fn int_bounds(v: *Value, value: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::Null => true,
    // rust: Value::Number(n) => n.as_i64() == Some(i64::from(value)),
    // rust: Value::Object(o) => {
    // rust: o.get("min")
    // rust: .and_then(Value::as_i64)
    // rust: .is_none_or(|m| i64::from(value) >= m)
    // rust: && o.get("max")
    // rust: .and_then(Value::as_i64)
    // rust: .is_none_or(|m| i64::from(value) <= m)
}
    // rust: _ => false,
}
}

/// A JSON number read by an int codec (`Number.intValue`): `3.0`, which
/// 1.21.1 mods write for rolls and counts, is 3.
pub fn int_value(v: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v.as_i64().or_else(|| v.as_f64().map(|f| f as i64))
}

/// `data/<ns>/<kind>/` of every namespace, as `ns:path`: vanilla's, and in
/// a content mods' root theirs (docs/modpacks.md), whose chests name their
/// own loot tables.
/// A kind's overlay files over what the resource root provided: the top
/// pack's file for each id replaces the rest (`SimpleJsonResourceReloadListener`
/// sees one resource per id).
pub fn overlay_map(overlay: *PackOverlay, kind: []const u8, out: *mut HashMap<[]const u8) void {
}
    // rust: for (id, files) in overlay.kind(kind) {
    // rust: let Ok(v) = serde_json::from_slice::<Value>(PackOverlay::top(files)) else {
    // rust: continue;
}
    // rust: out.insert(id.to_owned(), v);
}
}

/// Loot tables by id. Each is kept as its JSON text and read into a [`Value`]
/// the first time it is rolled: of vanilla's ~1,450 tables a game rolls a
/// few, and as `Value`s they took ~7 MB for 0.6 MB of JSON. Every table was
/// read whole when it loaded, so reading it again cannot fail.
pub const LootTables = struct {};
    // rust: impl LootTables {
    /// The table `id`.
pub fn get(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.get(id).map(LazyJson::get)
}
pub fn contains_key(self: *Self, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.contains_key(id)
}
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.len()
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.is_empty()
}
}
/// Each table kept as its JSON, the last of an id winning as in a map.
    // rust: impl FromIterator<(String, Value)> for LootTables {
    // rust: fn from_iter<I: IntoIterator<Item = (String, Value)>>(tables: I) -> Self {
    // rust: Self(
    // rust: tables
    // rust: .into_iter()
    // rust: .map(|(id, table)| (id, LazyJson::new(&table)))
    // rust: .collect(),
    // rust: )
}
}
    // rust: impl std::ops::Index<&str> for LootTables {
    // rust: type Output = Value;
    /// As a map indexes: panics on a missing table.
pub fn index(self: *Self, id: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(id).unwrap_or_else(|| panic!("no loot table {id}"))
}
}

/// The loot tables of every namespace in `root`'s `data/`, with `overlay`'s
/// over them. Shared while one is alive: `Items` and [`LootData`] of the
/// same root and packs hold one map, not a copy each (7 MB). The key holds
/// the packs' bytes and each root file's size and modification time, so a
/// table changed on disk is read again rather than taken from a held map.
pub fn shared_tables(root: *Path, overlay: *PackOverlay) i {
    // Implementation ported from Horizon
    return undefined;
}
pub const LOADED: Mutex<std.ArrayList((u64, Weak<LootTables))>> = Mutex::new(Vec::new());
    // rust: let key = {
//         use std::hash::{DefaultHasher, Hash, Hasher};
    // rust: let mut hasher = DefaultHasher::new();
    // rust: root.hash(&mut hasher);
    // rust: let data = root.join("data");
    // rust: let mut namespaces: Vec<_> = fs::read_dir(&data)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .collect();
    // rust: namespaces.sort();
    // rust: for namespace in namespaces {
    // rust: hash_files(&namespace.join("loot_table"), &mut hasher);
}
    // rust: overlay
    // rust: .kind("loot_table")
    // rust: .for_each(|file| file.hash(&mut hasher));
    // rust: hasher.finish()
}
    // rust: let held = |loaded: &mut Vec<(u64, Weak<LootTables>)>| {
    // rust: loaded.retain(|(_, tables)| tables.strong_count() > 0);
    // rust: loaded
    // rust: .iter()
    // rust: .find(|(k, _)| *k == key)
    // rust: .and_then(|(_, tables)| tables.upgrade())
}
    // rust: if let Some(tables) = held(&mut LOADED.lock().unwrap_or_else(|e| e.into_inner())) {
    // rust: return Ok(tables);
}
    // rust: let mut tables = HashMap::new();
    // rust: load_kind(&root.join("data"), "loot_table", &mut tables)?;
    // rust: overlay_map(overlay, "loot_table", &mut tables);
    // The mods' hooks run outside the lock.
    // rust: let mut each: Vec<_> = tables.into_iter().collect();
    // rust: each.sort_by(|a, b| a.0.cmp(&b.0));
    // rust: let tables: LootTables = each
    // rust: .into_iter()
    // rust: .map(|(id, mut table)| {
    // rust: native_loot_table_load(&id, &mut table);
    // rust: (id, table)
    // rust: })
    // rust: .collect();
    // rust: let mut loaded = LOADED.lock().unwrap_or_else(|e| e.into_inner());
    // Another thread may have loaded the same tables meanwhile: keep one.
    // rust: if let Some(tables) = held(&mut loaded) {
    // rust: return Ok(tables);
}
    // rust: let tables = Arc::new(tables);
    // rust: loaded.push((key, Arc::downgrade(&tables)));
    // rust: Ok(tables)
}

/// A native mod's hook point (docs/native-mods.md), listed in `native-hooks.json` with the game's:
/// the loot table `id` (`minecraft:chests/simple_dungeon`, `minecraft:blocks/stone`,
/// `minecraft:entities/zombie`) as it loads, its JSON after the data packs', before anything
/// rolls it (NeoForge's `LootTableLoadEvent`, Fabric's `LootTableEvents.MODIFY`). Add pools to
/// `table["pools"]` or entries to a pool's `entries`, change or replace it (no pools: it drops
/// nothing; keep its `random_sequence` when replacing it, as a mob's table without one drops
/// nothing). Called once per table and load, in id order, wherever the tables load: the server,
/// and a client too, so make the same change each time, and don't load loot tables from here.
/// Two loads may run at once on two threads. A `/reload` or a world opened with other packs
/// may load them again, or keep the tables already loaded from the same files. API
/// 75.
pub fn native_loot_table_load(id: []const u8, table: *mut Value) void {
}
    // rust: crate::native_load_hooks::loot_table_load(id, table);
}

pub fn load_kind(data: *Path, kind: []const u8, out: *mut HashMap<[]const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Ok(entries) = fs::read_dir(data) else {
    // rust: return Ok(());
}
    // rust: let mut namespaces: Vec<String> = entries
    // rust: .flatten()
    // rust: .filter(|e| e.path().is_dir())
    // rust: .filter_map(|e| e.file_name().to_str().map(str::to_owned))
    // rust: .collect();
    // rust: namespaces.sort();
    // rust: for ns in namespaces {
    // rust: load_dir(&data.join(&ns).join(kind), &ns, "", out)?;
}
    // rust: Ok(())
}

/// Every file's path, size and modification time under `dir`, in name order.
pub fn hash_files(dir: *Path, hasher: *mut impl std::hash::Hasher) void {
}
//     use std::hash::Hash;
    // rust: let Ok(entries) = fs::read_dir(dir) else {
    // rust: return;
}
    // rust: let mut entries: Vec<_> = entries.flatten().collect();
    // rust: entries.sort_by_key(|e| e.file_name());
    // rust: for entry in entries {
    // rust: let path = entry.path();
    // rust: let Ok(meta) = entry.metadata() else {
    // rust: continue;
}
    // rust: if meta.is_dir() {
    // rust: hash_files(&path, hasher);
    // rust: } else {
    // rust: path.hash(hasher);
    // rust: meta.len().hash(hasher);
    // rust: meta.modified().ok().hash(hasher);
}
}
}

    // rust: fn load_dir(
    // rust: dir: &Path,
    // rust: namespace: &str,
    // rust: prefix: &str,
    // rust: out: &mut HashMap<String, Value>,
    // rust: ) -> io::Result<()> {
    // Through `json_folder`: a load holding the folder (the recipes, read by
    // the item tables, the recipe book and the server's sync too) shares one
    // read of it.
    // rust: let Ok(folder) = crate::json_folder::read(dir) else {
    // rust: return Ok(());
}
    // rust: for file in &folder.files {
    // rust: let value = serde_json::from_slice(file.bytes()?)?;
    // rust: out.insert(format!("{namespace}:{prefix}{}", file.name), value);
}
    // rust: Ok(())
}
pub fn cost(v: *Value) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: v["base"].as_i64().unwrap_or(0) as i32,
    // rust: v["per_level_above_first"].as_i64().unwrap_or(0) as i32,
    // rust: )
}

    // rust: impl LootData {
    /// Load from a resource root holding `items.json` and `data/`: loot
    /// tables, item modifiers, predicates, tags and recipes of every
    /// namespace, vanilla's enchantments. `overlay` adds a world's data
    /// packs over it.
pub fn load(root: *Path, overlay: *PackOverlay) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let all = root.join("data");
    // rust: let data = all.join("minecraft");
    // rust: let tables = shared_tables(root, overlay)?;
    // rust: let mut modifiers = HashMap::new();
    // rust: load_kind(&all, "item_modifier", &mut modifiers)?;
    // rust: overlay_map(overlay, "item_modifier", &mut modifiers);
    // rust: let mut predicates = HashMap::new();
    // rust: load_kind(&all, "predicate", &mut predicates)?;
    // rust: overlay_map(overlay, "predicate", &mut predicates);
    // rust: let raw = crate::item_defaults::shared(root)?;
    // rust: let items = raw
    // rust: .iter()
    // rust: .map(|(name, c)| {
    // rust: (
    // rust: name.clone(),
    // rust: ItemFacts {
    // rust: max_stack: c["minecraft:max_stack_size"].as_i64().unwrap_or(64) as i32,
    // rust: max_damage: c["minecraft:max_damage"].as_i64().unwrap_or(0) as i32,
    // rust: enchantable: c["minecraft:enchantable"]["value"]
    // rust: .as_i64()
    // rust: .map(|v| v as i32),
    // rust: },
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let mut raw_enchantments = HashMap::new();
    // rust: load_dir(
    // rust: &data.join("enchantment"),
    // rust: "minecraft",
    // rust: "",
    // rust: &mut raw_enchantments,
    // rust: )?;
    // rust: let mut names: Vec<&String> = raw_enchantments.keys().collect();
    // rust: names.sort();
    // rust: let enchantments = names
    // rust: .into_iter()
    // rust: .map(|name| {
    // rust: let e = &raw_enchantments[name];
    // rust: Enchantment {
    // rust: name: name.clone(),
    // rust: supported: e["supported_items"].clone(),
    // rust: primary: e.get("primary_items").cloned(),
    // rust: exclusive: e.get("exclusive_set").cloned().unwrap_or(Value::Null),
    // rust: max_level: e["max_level"].as_i64().unwrap_or(1) as i32,
    // rust: weight: e["weight"].as_i64().unwrap_or(1) as i32,
    // rust: min_cost: cost(&e["min_cost"]),
    // rust: max_cost: cost(&e["max_cost"]),
    // rust: slots: e["slots"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(Value::as_str)
    // rust: .map(str::to_owned)
    // rust: .collect(),
    // rust: effects: e["effects"].clone(),
}
    // rust: })
    // rust: .collect();
    // rust: let mut tags = HashMap::new();
    // rust: for registry in [
    // rust: "item",
    // rust: "enchantment",
    // rust: "instrument",
    // rust: "entity_type",
    // rust: "damage_type",
            // What `location_check`'s `biomes` names.
    // rust: "worldgen/biome",
    // rust: ] {
    // rust: let mut raw = HashMap::new();
    // rust: load_kind(&all, &format!("tags/{registry}"), &mut raw)?;
    // rust: for (name, value) in raw {
    // rust: let values = value["values"].as_array().cloned().unwrap_or_default();
    // rust: tags.insert((registry.to_owned(), name), values);
}
            // The packs' entries join the game's own, in pack order; a
            // `replace` file drops what the lower sources put in
            // (`TagLoader.load` walks the resource stack the same way).
    // rust: for (id, files) in overlay.tag_kind(registry) {
    // rust: let slot = tags
    // rust: .entry((registry.to_owned(), id.to_owned()))
    // rust: .or_default();
    // rust: for bytes in files {
    // rust: let Ok(v) = serde_json::from_slice::<Value>(bytes) else {
    // rust: continue;
}
    // rust: if v["replace"].as_bool() == Some(true) {
    // rust: slot.clear();
}
    // rust: slot.extend(v["values"].as_array().cloned().unwrap_or_default());
}
}
}
    // rust: let mut recipes = HashMap::new();
    // rust: load_kind(&all, "recipe", &mut recipes)?;
    // rust: overlay_map(overlay, "recipe", &mut recipes);
    // rust: let mut ids: Vec<&String> = recipes.keys().collect();
    // rust: ids.sort();
    // rust: let smelting = ids
    // rust: .into_iter()
    // rust: .map(|id| &recipes[id])
    // rust: .filter(|r| r["type"] == "minecraft:smelting")
    // rust: .filter_map(|r| {
    // rust: let result = recipe_result_id(&r["result"])?.to_owned();
    // rust: let count = r["result"]["count"].as_i64().unwrap_or(1) as i32;
    // rust: Some((r["ingredient"].clone(), result, count))
    // rust: })
    // rust: .collect();
    // rust: Ok(Self {
    // rust: tables,
    // rust: modifiers,
    // rust: predicates,
    // rust: items,
    // rust: enchantments,
    // rust: tags,
    // rust: smelting,
    // rust: })
}
pub fn has_table(self: *Self, table: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tables.contains_key(table)
}
    /// The table's `random_sequence` (where `getRandomItems` draws from).
pub fn random_sequence(self: *Self, table: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tables.get(table)?["random_sequence"].as_str()
}
pub fn max_stack(self: *Self, item: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.facts(item).max_stack
}
pub fn max_damage(self: *Self, item: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.facts(item).max_damage
}
    /// Whether a registry tag (`entity_type`, `damage_type`, `item`...) holds `id`.
pub fn in_tag(self: *Self, registry: []const u8, tag: []const u8, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tag(registry, tag).iter().any(|m| m == id)
}
    /// `EnchantmentHelper.getEnchantmentLevel(enchantment, entity)`: the best
    /// level on the items in the enchantment's slots.
pub fn enchantment_level(self: *Self, enchantment: []const u8, entity: *LootEntity) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(e) = self.enchantments.iter().find(|e| e.name == enchantment) else {
    // rust: return 0;
}
    // rust: if !entity.living {
    // rust: return 0;
}
    // rust: EQUIPMENT_SLOTS
    // rust: .iter()
    // rust: .filter(|slot| e.slots.iter().any(|g| slot_in_group(slot, g)))
    // rust: .filter_map(|slot| entity.item(slot))
    // rust: .map(|stack| item_level(stack, enchantment))
    // rust: .max()
    // rust: .unwrap_or(0)
}
    /// Whether an item carries an enchantment with `prevent_equipment_drop`.
pub fn prevents_equipment_drop(self: *Self, stack: *LootStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack.enchantments.iter().any(|(name, _)| {
    // rust: self.enchantments.iter().any(|e| {
    // rust: &e.name == name && !e.effects["minecraft:prevent_equipment_drop"].is_null()
    // rust: })
    // rust: })
}
    /// `EnchantmentHelper.processEquipmentDropChance`: the victim's and the
    /// attacker's `equipment_drops` effects (Looting) applied to `chance`.
pub fn equipment_drop_chance(self: *Self, params: *EntityLootParams, chance: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
        // Enchantment.damageContext: no luck and no killing player.
    // rust: let damage_params = EntityLootParams {
    // rust: this: params.this.clone(),
    // rust: damage: params.damage.clone(),
    // rust: player: None,
    // rust: luck: 0.0,
}
    // rust: let mut c = Context {
    // rust: data: self,
    // rust: random: LegacyRandom::new(0),
    // rust: biome: None,
    // rust: visited: Vec::new(),
    // rust: luck: 0.0,
    // rust: open_water: None,
    // rust: entity: Some(&damage_params),
}
    // rust: let mut chance = chance;
    // rust: c.equipment_drops(&params.this, "victim", &mut chance);
    // rust: if let Some(attacker) = params
    // rust: .damage
    // rust: .as_ref()
    // rust: .and_then(|d| d.source.as_ref())
    // rust: .filter(|a| a.living)
    // rust: {
    // rust: c.equipment_drops(attacker, "attacker", &mut chance);
}
    // rust: chance
}
    /// Tag members in tag order (nested tags expanded in place, duplicates
    /// dropped).
pub fn tag(self: *Self, registry: []const u8, name: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
pub fn visit(data: *LootData, registry: []const u8, name: []const u8, out: *mut std.ArrayList([]const u8), depth: u32) void {
}
    // rust: if depth > 16 {
    // rust: return;
}
    // rust: let Some(values) = data.tags.get(&(registry.to_owned(), name.to_owned())) else {
    // rust: return;
}
    // rust: for v in values {
    // rust: let id = match v {
    // rust: Value::String(s) => s.as_str(),
    // rust: Value::Object(o) => o.get("id").and_then(Value::as_str).unwrap_or(""),
    // rust: _ => continue,
}
    // rust: match id.strip_prefix('#') {
    // rust: Some(tag) => visit(data, registry, tag, out, depth + 1),
    // rust: None if !out.iter().any(|x| x == id) => out.push(id.to_owned()),
    // rust: None => {}
}
}
}
    // rust: let mut out = Vec::new();
    // rust: visit(self, registry, name, &mut out, 0);
    // rust: out
}
    /// A HolderSet: "#tag", "id" or a list of ids.
pub fn holder_set(self: *Self, registry: []const u8, v: *Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::String(s) => match s.strip_prefix('#') {
    // rust: Some(tag) => self.tag(registry, tag),
    // rust: None => vec![s.clone()],
    // rust: },
    // rust: Value::Array(a) => a
    // rust: .iter()
    // rust: .filter_map(Value::as_str)
    // rust: .map(str::to_owned)
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
}
pub fn item_in(self: *Self, item: []const u8, set: *Value) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.holder_set("item", set).iter().any(|i| i == item)
}
pub fn facts(self: *Self, item: []const u8) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.items.get(item).copied().unwrap_or(ItemFacts {
    // rust: max_stack: 64,
    // rust: ..ItemFacts::default()
    // rust: })
}

    /// LootTable.getRandomItems with the given random (its state is
    /// advanced), luck and, for fishing, whether the hook is in open water.
    // rust: pub fn roll<R: RandomSource + Clone>(
    // rust: &self,
    // rust: table: &str,
    // rust: random: &mut R,
    // rust: luck: f32,
    // rust: biome: Option<&str>,
    // rust: open_water: Option<bool>,
    // rust: ) -> Vec<LootStack> {
    // rust: let Some(json) = self.tables.get(table) else {
    // rust: return Vec::new();
}
    // rust: let mut c = Context {
    // rust: data: self,
    // rust: random: random.clone(),
    // rust: biome,
    // rust: visited: Vec::new(),
    // rust: luck,
    // rust: open_water,
    // rust: entity: None,
}
    // rust: let mut items = Vec::new();
    // rust: c.table_raw(table, json, &mut |c, stack| c.data.split(stack, &mut items));
    // rust: *random = c.random;
    // rust: items
}
    /// LootTable.getRandomItems for an entity context: the generated stacks
    /// after the stack splitter, in order. `random` is the table's random
    /// sequence (or the level random) and is advanced.
    // rust: pub fn roll_entity<R: RandomSource + Clone>(
    // rust: &self,
    // rust: table: &str,
    // rust: random: &mut R,
    // rust: params: &EntityLootParams,
    // rust: ) -> Vec<LootStack> {
    // rust: let Some(json) = self.tables.get(table) else {
    // rust: return Vec::new();
}
    // rust: let mut c = Context {
    // rust: data: self,
    // rust: random: random.clone(),
    // rust: biome: None,
    // rust: visited: Vec::new(),
    // rust: luck: params.luck,
    // rust: open_water: None,
    // rust: entity: Some(params),
}
    // rust: let mut items = Vec::new();
    // rust: c.table_raw(table, json, &mut |c, stack| c.data.split(stack, &mut items));
    // rust: *random = c.random;
    // rust: items
}
    /// LootTable.getRandomItems with an empty context (a trial spawner's
    /// reward): the stacks after the stack splitter. `random` is the table's
    /// random sequence (or the level random) and is advanced.
    // rust: pub fn roll_split<R: RandomSource + Clone>(
    // rust: &self,
    // rust: table: &str,
    // rust: random: &mut R,
    // rust: ) -> Vec<LootStack> {
    // rust: let Some(json) = self.tables.get(table) else {
    // rust: return Vec::new();
}
    // rust: let mut c = Context {
    // rust: data: self,
    // rust: random: random.clone(),
    // rust: biome: None,
    // rust: visited: Vec::new(),
    // rust: luck: 0.0,
    // rust: open_water: None,
    // rust: entity: None,
}
    // rust: let mut items = Vec::new();
    // rust: c.table_raw(table, json, &mut |c, stack| c.data.split(stack, &mut items));
    // rust: *random = c.random;
    // rust: items
}
    /// LootTable.createStackSplitter (every item is enabled).
pub fn split(self: *Self, stack: LootStack, items: *mut std.ArrayList(LootStack)) void {
}
    // rust: let max = self.facts(&stack.item).max_stack.max(1);
    // rust: if stack.count < max {
    // rust: items.push(stack);
    // rust: } else {
    // rust: let mut count = stack.count;
    // rust: while count > 0 {
    // rust: let mut copy = stack.clone();
    // rust: copy.count = max.min(count);
    // rust: count -= copy.count;
    // rust: items.push(copy);
}
}
}
    /// LootTable.fill into an empty container of `slots` slots with
    /// `RandomSource.create(seed)`; `biome` is the container's biome for
    /// location checks (None: no origin, checks fail).
    // rust: pub fn fill(
    // rust: &self,
    // rust: table: &str,
    // rust: seed: i64,
    // rust: slots: usize,
    // rust: biome: Option<&str>,
    // rust: ) -> Vec<Option<LootStack>> {
    // rust: self.fill_with(table, &mut LegacyRandom::new(seed), slots, biome)
}
    /// LootTable.fill drawing from `random` (a seeded random or the table's
    /// random sequence), which is advanced.
    // rust: pub fn fill_with<R: RandomSource + Clone>(
    // rust: &self,
    // rust: table: &str,
    // rust: random: &mut R,
    // rust: slots: usize,
    // rust: biome: Option<&str>,
    // rust: ) -> Vec<Option<LootStack>> {
    // rust: let mut out = vec![None; slots];
    // rust: let Some(json) = self.tables.get(table) else {
    // rust: return out;
}
    // rust: let mut c = Context {
    // rust: data: self,
    // rust: random: random.clone(),
    // rust: biome,
    // rust: visited: Vec::new(),
    // rust: luck: 0.0,
    // rust: open_water: None,
    // rust: entity: None,
}
    // rust: let mut items = Vec::new();
    // rust: c.table_raw(table, json, &mut |c, stack| c.data.split(stack, &mut items));
    // rust: *random = c.random;
    // rust: let mut available: Vec<usize> = (0..slots).collect();
    // rust: shuffle(&mut available, random);
    // rust: shuffle_and_split(&mut items, available.len(), random);
    // rust: for stack in items {
    // rust: let Some(slot) = available.pop() else { break };
    // rust: out[slot] = (!stack.is_empty()).then_some(stack);
}
    // rust: out
}
}

/// `MobEffect.isInstantaneous`.
pub fn is_instantaneous(effect: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: effect,
    // rust: "minecraft:saturation" | "minecraft:instant_health" | "minecraft:instant_damage"
    // rust: )
}
/// The level of one enchantment on a stack (its `enchantments` component).
pub fn item_level(stack: *LootStack, enchantment: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack
    // rust: .enchantments
    // rust: .iter()
    // rust: .find(|(n, _)| n == enchantment)
    // rust: .map_or(0, |(_, l)| *l)
}
/// Util.shuffle.
    // rust: fn shuffle<T>(list: &mut [T], random: &mut impl RandomSource) {
    // rust: for i in (2..=list.len()).rev() {
    // rust: let j = random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: list.swap(i - 1, j);
}
}
/// Mth.nextInt.
pub fn next_int(random: *mut impl RandomSource, min: i32, max: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if min >= max {
    // rust: min
    // rust: } else {
    // rust: random.next_int_bound(max - min + 1).unwrap_or(0) + min
}
}
/// LootTable.shuffleAndSplitItems.
pub fn shuffle_and_split(result: *mut std.ArrayList(LootStack), slots: usize, random: *mut impl RandomSource) void {
}
    // rust: let mut splittable = Vec::new();
    // rust: result.retain(|s| {
    // rust: if s.is_empty() {
    // rust: false
    // rust: } else if s.count > 1 {
    // rust: splittable.push(s.clone());
    // rust: false
    // rust: } else {
    // rust: true
}
    // rust: });
    // rust: while slots as i64 - result.len() as i64 - splittable.len() as i64 > 0 && !splittable.is_empty()
    // rust: {
    // rust: let index = next_int(random, 0, splittable.len() as i32 - 1) as usize;
    // rust: let mut stack = splittable.remove(index);
    // rust: let remove = next_int(random, 1, stack.count / 2).min(stack.count);
    // rust: let mut copy = stack.clone();
    // rust: copy.count = remove;
    // rust: stack.count -= remove;
    // rust: if stack.count > 1 && random.next_boolean() {
    // rust: splittable.push(stack);
    // rust: } else {
    // rust: result.push(stack);
}
    // rust: if copy.count > 1 && random.next_boolean() {
    // rust: splittable.push(copy);
    // rust: } else {
    // rust: result.push(copy);
}
}
    // rust: result.append(&mut splittable);
    // rust: shuffle(result, random);
}

pub const Context = struct {
    data: *'a LootData,
    random: R,
    biome: ?*'a str,
    visited: std.ArrayList([]const u8),
    /// LootContext.getLuck.
    luck: f32,
    /// A fishing hook's `is_open_water` for `entity_properties` (None: no entity).
    open_water: ?bool,
    /// The entity, damage source and killer parameters.
    entity: ?*'a EntityLootParams,
};
    // rust: type Sink<'s, R> = dyn FnMut(&mut Context<'_, R>, LootStack) + 's;

    // rust: impl<R: RandomSource> Context<'_, R> {
    /// A `LootContext.EntityTarget` parameter.
pub fn target(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = self.entity?;
    // rust: match name {
    // rust: "this" => Some(&p.this),
    // rust: "attacker" => p.damage.as_ref()?.source.as_ref(),
    // rust: "direct_attacker" => p.damage.as_ref()?.direct.as_ref(),
    // rust: "attacking_player" => p.player.as_ref(),
    // rust: _ => None,
}
}
    /// The `ATTACKING_ENTITY` parameter when it is a living entity.
pub fn living_attacker(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.target("attacker").filter(|a| a.living)
}
    /// The `equipment_drops` effects on one entity's equipment
    /// (`runIterationOnEquipment`), for the given `enchanted` target.
pub fn equipment_drops(self: *Self, holder: *LootEntity, enchanted: []const u8, chance: *mut f32) void {
}
    // rust: let data = self.data;
    // rust: for slot in EQUIPMENT_SLOTS {
    // rust: let Some(stack) = holder.item(slot) else {
    // rust: continue;
}
    // rust: for (name, level) in &stack.enchantments {
    // rust: let Some(e) = data.enchantments.iter().find(|e| &e.name == name) else {
    // rust: continue;
}
    // rust: if !e.slots.iter().any(|g| slot_in_group(slot, g)) {
    // rust: continue;
}
    // rust: for effect in e.effects["minecraft:equipment_drops"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: if effect["enchanted"].as_str() != Some(enchanted)
    // rust: || effect["affected"].as_str().unwrap_or("victim") != "victim"
    // rust: {
    // rust: continue;
}
    // rust: if !effect["requirements"].is_null() && !self.condition(&effect["requirements"])
    // rust: {
    // rust: continue;
}
    // rust: let value = level_value(&effect["effect"]["value"], *level);
    // rust: *chance = match effect["effect"]["type"].as_str().unwrap_or("") {
    // rust: "minecraft:add" => *chance + value,
    // rust: "minecraft:multiply" => *chance * value,
    // rust: "minecraft:set" => value,
    // rust: _ => *chance,
}
}
}
}
}
    /// EntityPredicate.matches (false without an entity).
pub fn entity_matches(self: *Self, p: *Value, e: ?*LootEntity) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(e) = e else { return false };
    // rust: let Some(parts) = p.as_object() else {
    // rust: return true;
}
    // rust: let data = self.data;
    // rust: parts.iter().all(|(key, v)| match key.as_str() {
    // rust: "minecraft:entity_type" => match v.as_str() {
    // rust: Some(s) => match s.strip_prefix('#') {
    // rust: Some(tag) => data.in_tag("entity_type", tag, &e.kind),
    // rust: None => s == e.kind,
    // rust: },
    // rust: None => v
    // rust: .as_array()
    // rust: .is_some_and(|a| a.iter().any(|x| x.as_str() == Some(&e.kind))),
    // rust: },
    // rust: "minecraft:flags" => v.as_object().into_iter().flatten().all(|(flag, want)| {
    // rust: let want = want.as_bool().unwrap_or(false);
    // rust: match flag.as_str() {
    // rust: "is_on_fire" => e.on_fire == want,
                    // EntityFlagsPredicate: only living entities have an age.
    // rust: "is_baby" => !e.living || e.baby == want,
    // rust: "is_fall_flying" => !e.living || !want,
    // rust: _ => !want,
}
    // rust: }),
    // rust: "minecraft:equipment" => {
    // rust: e.living
    // rust: && v.as_object().into_iter().flatten().all(|(slot, item)| {
    // rust: e.item(slot)
    // rust: .is_some_and(|stack| self.item_matches(item, stack))
    // rust: })
}
    // rust: "minecraft:components" => v.as_object().into_iter().flatten().all(|(c, want)| match c
    // rust: .as_str()
    // rust: {
    // rust: "minecraft:sheep/color" => e
    // rust: .sheep
    // rust: .as_ref()
    // rust: .is_some_and(|(color, _)| want.as_str() == Some(color)),
    // rust: "minecraft:frog/variant" => {
    // rust: e.frog_variant.is_some() && want.as_str() == e.frog_variant.as_deref()
}
    // rust: "minecraft:chicken/variant" => {
    // rust: e.chicken_variant.is_some() && want.as_str() == e.chicken_variant.as_deref()
}
    // rust: _ => false,
    // rust: }),
    // rust: "minecraft:type_specific/sheep" => e
    // rust: .sheep
    // rust: .as_ref()
    // rust: .is_some_and(|(_, sheared)| v["sheared"].as_bool().is_none_or(|w| w == *sheared)),
    // rust: "minecraft:type_specific/cube_mob" => {
    // rust: e.cube_size.is_some_and(|size| int_bounds(&v["size"], size))
}
            // RaiderPredicate: no raid is running here.
    // rust: "minecraft:type_specific/raider" => e.captain.is_some_and(|captain| {
    // rust: !v["has_raid"].as_bool().unwrap_or(false)
    // rust: && captain == v["is_captain"].as_bool().unwrap_or(false)
    // rust: }),
    // rust: "minecraft:vehicle" => self.entity_matches(v, e.vehicle.as_deref()),
    // rust: _ => false,
    // rust: })
}
    /// A number provider. An unknown type gives 0, as in items.rs `number`
    /// (a data pack's typo yields nothing rather than a full roll).
pub fn int(self: *Self, v: *Value) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::Number(_) => int_value(v).unwrap_or(0) as i32,
    // rust: Value::Object(_) => match v["type"].as_str().unwrap_or("") {
    // rust: "minecraft:constant" => self.int(&v["value"]),
    // rust: "minecraft:uniform" => {
    // rust: let min = self.int(&v["min"]);
    // rust: let max = self.int(&v["max"]);
    // rust: next_int(&mut self.random, min, max)
}
    // rust: "minecraft:binomial" => {
    // rust: let n = self.int(&v["n"]);
    // rust: let p = self.float(&v["p"]);
    // rust: (0..n).filter(|_| self.random.next_float() < p).count() as i32
}
    // rust: _ => 0,
    // rust: },
    // rust: _ => 0,
}
}
pub fn float(self: *Self, v: *Value) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::Number(n) => n.as_f64().unwrap_or(0.) as f32,
    // rust: Value::Object(_) => match v["type"].as_str().unwrap_or("") {
    // rust: "minecraft:constant" => self.float(&v["value"]),
    // rust: "minecraft:uniform" => {
    // rust: let min = self.float(&v["min"]);
    // rust: let max = self.float(&v["max"]);
    // rust: if min >= max {
    // rust: min
    // rust: } else {
    // rust: self.random.next_float() * (max - min) + min
}
}
    // rust: _ => 0.,
    // rust: },
    // rust: _ => 0.,
}
}
pub fn condition(self: *Self, c: *Value) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = self.data;
    // rust: match c {
    // rust: Value::Null => true,
    // rust: Value::Array(list) => list.iter().all(|c| self.condition(c)),
    // rust: Value::String(id) => match data.predicates.get(id) {
    // rust: Some(p) => self.condition(p),
    // rust: None => false,
    // rust: },
    // rust: Value::Object(_) => match c["type"].as_str().unwrap_or("") {
    // rust: "minecraft:inverted" => !self.condition(&c["term"]),
    // rust: "minecraft:all_of" => c["terms"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|t| self.condition(t)),
    // rust: "minecraft:any_of" => c["terms"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .any(|t| self.condition(t)),
    // rust: "minecraft:entity_properties" if self.entity.is_some() => {
    // rust: let target = self.target(c["entity"].as_str().unwrap_or("this"));
    // rust: c["predicate"].is_null() || self.entity_matches(&c["predicate"], target)
}
                // FishingHookPredicate: the only entity property a hook has.
    // rust: "minecraft:entity_properties" => {
    // rust: let predicate = &c["predicate"];
    // rust: let fishing = &predicate["minecraft:type_specific/fishing_hook"];
    // rust: let only_hook = predicate.as_object().is_some_and(|o| o.len() == 1);
    // rust: match self.open_water {
    // rust: Some(open) if only_hook && fishing.is_object() => fishing["in_open_water"]
    // rust: .as_bool()
    // rust: .is_none_or(|want| want == open),
    // rust: _ => false,
}
}
    // rust: "minecraft:killed_by_player" => self.entity.is_some_and(|p| p.player.is_some()),
    // rust: "minecraft:random_chance_with_enchanted_bonus" => {
    // rust: let level = self.living_attacker().map_or(0, |a| {
    // rust: data.enchantment_level(c["enchantment"].as_str().unwrap_or(""), a)
    // rust: });
    // rust: let chance = if level > 0 {
    // rust: level_value(&c["enchanted_chance"], level)
    // rust: } else {
    // rust: c["unenchanted_chance"].as_f64().unwrap_or(0.) as f32
}
    // rust: self.random.next_float() < chance
}
                // DamageSourcePredicate (false without a damage source).
    // rust: "minecraft:damage_source_properties" => {
    // rust: let Some(damage) = self.entity.and_then(|p| p.damage.as_ref()) else {
    // rust: return false;
}
    // rust: let p = &c["predicate"];
    // rust: let tags_ok = p["tags"].as_array().into_iter().flatten().all(|t| {
    // rust: let id = t["id"].as_str().unwrap_or("");
    // rust: let has = match id.strip_prefix('#') {
    // rust: Some(tag) => data.in_tag("damage_type", tag, &damage.kind),
    // rust: None => id == damage.kind,
}
    // rust: has == t["expected"].as_bool().unwrap_or(false)
    // rust: });
    // rust: tags_ok
    // rust: && (p["direct_entity"].is_null()
    // rust: || self.entity_matches(&p["direct_entity"], damage.direct.as_ref()))
    // rust: && (p["source_entity"].is_null()
    // rust: || self.entity_matches(&p["source_entity"], damage.source.as_ref()))
    // rust: && p["is_direct"].as_bool().is_none_or(|want| {
    // rust: let direct = match (&damage.source, &damage.direct) {
    // rust: (Some(a), Some(b)) => a.kind == b.kind,
    // rust: (None, None) => true,
    // rust: _ => false,
}
    // rust: direct == want
    // rust: })
}
    // rust: "minecraft:random_chance" => {
    // rust: let chance = self.float(&c["chance"]);
    // rust: self.random.next_float() < chance
}
    // rust: "minecraft:location_check" => {
    // rust: let Some(biome) = self.biome else {
    // rust: return false;
}
                    // `LocationPredicate.biomes`: a HolderSet, so a `#tag`
                    // (the loot data's biome tags, packs included), an id or
                    // a list of ids.
    // rust: match &c["predicate"]["biomes"] {
    // rust: Value::Null => true,
    // rust: set => data
    // rust: .holder_set("worldgen/biome", set)
    // rust: .iter()
    // rust: .any(|b| b == biome),
}
}
                // A mod's own kind: the hook answers; a bare type name is
                // minecraft's own and an unknown one fails.
    // rust: k if k.contains(':') && !k.starts_with("minecraft:") => {
    // rust: let mut holds = false;
    // rust: native_loot_condition(k, c, &self.native_ctx(), &mut holds);
    // rust: holds
}
                // An unknown type fails, as in items.rs `condition`.
    // rust: _ => false,
    // rust: },
    // rust: _ => false,
}
}
    /// An item modifier (typed object, inline list or registry reference).
pub fn modify(self: *Self, m: *Value, stack: LootStack) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = self.data;
    // rust: match m {
    // rust: Value::Null => stack,
    // rust: Value::Array(list) => list.iter().fold(stack, |s, f| self.modify(f, s)),
    // rust: Value::String(id) => match data.modifiers.get(id) {
    // rust: Some(f) => self.modify(f, stack),
    // rust: None => stack,
    // rust: },
    // rust: Value::Object(_) => {
    // rust: if !m["condition"].is_null() && !self.condition(&m["condition"]) {
    // rust: return stack;
}
    // rust: self.run(m, stack)
}
    // rust: _ => stack,
}
}
    /// The context a mod's own loot kinds see: drawn lazily, only when
    /// the table has a mod's kind, so the random stays untouched without.
pub fn native_ctx(self: *Self) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let seed = self.random.next_long();
    // rust: NativeLootContext {
    // rust: entity: self.entity.map(|e| &e.this),
    // rust: damage: self.entity.and_then(|e| e.damage.as_ref()),
    // rust: player: self.entity.and_then(|e| e.player.as_ref()),
    // rust: tool: None, // The tool is not in this engine's context.
    // rust: block: None,
    // rust: luck: self.luck,
    // rust: biome: self.biome,
    // rust: seed,
    // rust: place: current_native_loot_place(),
}
}
pub fn run(self: *Self, f: *Value, mut stack: LootStack) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = self.data;
    // rust: match f["type"].as_str().unwrap_or("") {
    // rust: "minecraft:sequence" => {
    // rust: for function in f["functions"].as_array().into_iter().flatten() {
    // rust: stack = self.modify(function, stack);
}
}
    // rust: "minecraft:set_count" => {
    // rust: let base = if f["add"].as_bool() == Some(true) {
    // rust: stack.get_count()
    // rust: } else {
    // rust: 0
}
    // rust: stack.count = base + self.int(&f["count"]);
}
    // rust: "minecraft:limit_count" => {
    // rust: let limit = &f["limit"];
    // rust: let mut count = stack.get_count();
    // rust: if let Some(min) = int_value(&limit["min"]) {
    // rust: count = count.max(min as i32);
}
    // rust: if let Some(max) = int_value(&limit["max"]) {
    // rust: count = count.min(max as i32);
}
    // rust: stack.count = count;
}
    // rust: "minecraft:set_damage" => {
    // rust: let max = data.facts(&stack.item).max_damage;
    // rust: if max > 0 {
    // rust: let base = if f["add"].as_bool() == Some(true) {
    // rust: 1. - stack.damage as f32 / max as f32
    // rust: } else {
    // rust: 0.
}
    // rust: let pct = 1. - (self.float(&f["damage"]) + base).clamp(0., 1.);
    // rust: stack.damage = (pct * max as f32).floor() as i32;
}
}
    // rust: "minecraft:enchant_randomly" => {
    // rust: let book = stack.item == "minecraft:book";
    // rust: let check = !book && f["only_compatible"].as_bool().unwrap_or(true);
    // rust: let options: Vec<usize> = match f.get("options") {
    // rust: Some(o) => data
    // rust: .holder_set("enchantment", o)
    // rust: .iter()
    // rust: .filter_map(|n| data.enchantments.iter().position(|e| &e.name == n))
    // rust: .collect(),
    // rust: None => (0..data.enchantments.len()).collect(),
}
    // rust: let options: Vec<usize> = options
    // rust: .into_iter()
    // rust: .filter(|&i| {
    // rust: !check || data.item_in(&stack.item, &data.enchantments[i].supported)
    // rust: })
    // rust: .collect();
    // rust: if !options.is_empty() {
    // rust: let pick = self
    // rust: .random
    // rust: .next_int_bound(options.len() as i32)
    // rust: .unwrap_or(0) as usize;
    // rust: let e = &data.enchantments[options[pick]];
    // rust: let level = next_int(&mut self.random, 1, e.max_level);
    // rust: if book {
    // rust: stack.item = "minecraft:enchanted_book".into();
}
    // rust: enchant(&mut stack, &e.name, level);
}
}
    // rust: "minecraft:enchant_with_levels" => {
    // rust: let cost = self.int(&f["levels"]);
    // rust: let source: Vec<usize> = match f.get("options") {
    // rust: Some(o) => data
    // rust: .holder_set("enchantment", o)
    // rust: .iter()
    // rust: .filter_map(|n| data.enchantments.iter().position(|e| &e.name == n))
    // rust: .collect(),
    // rust: None => (0..data.enchantments.len()).collect(),
}
    // rust: let chosen = self.select_enchantments(&stack.item, cost, &source);
    // rust: if stack.item == "minecraft:book" {
    // rust: stack.item = "minecraft:enchanted_book".into();
}
    // rust: for (i, level) in chosen {
    // rust: enchant(&mut stack, &data.enchantments[i].name, level);
}
}
    // rust: "minecraft:set_enchantments" => {
    // rust: if let Some(map) = f["enchantments"].as_object() {
    // rust: if stack.item == "minecraft:book" {
    // rust: stack.item = "minecraft:enchanted_book".into();
}
    // rust: for (name, level) in map {
    // rust: let level = self.int(level);
    // rust: enchant(&mut stack, name, level);
}
}
}
    // rust: "minecraft:set_potion" => stack.potion = f["id"].as_str().map(str::to_owned),
    // rust: "minecraft:set_stew_effect" => {
    // rust: let effects = f["effects"].as_array().cloned().unwrap_or_default();
    // rust: if stack.item == "minecraft:suspicious_stew" && !effects.is_empty() {
    // rust: let pick = self
    // rust: .random
    // rust: .next_int_bound(effects.len() as i32)
    // rust: .unwrap_or(0) as usize;
    // rust: let effect = effects[pick]["type"].as_str().unwrap_or("");
    // rust: let mut duration = self.int(&effects[pick]["duration"]);
                    // Seconds, unless the effect is instantaneous.
    // rust: if !is_instantaneous(effect) {
    // rust: duration *= 20;
}
                    // SuspiciousStewEffects.withEffectAdded
    // rust: stack.stew_effects.push((effect.to_owned(), duration));
}
}
    // rust: "minecraft:set_ominous_bottle_amplifier" => {
    // rust: stack.ominous_amplifier = Some(self.int(&f["amplifier"]));
}
            // SetInstrumentFunction: `options.getRandomElement(random)` becomes the item's
            // `instrument` component (a goat horn's tune).
    // rust: "minecraft:set_instrument" => {
    // rust: let options = data.holder_set("instrument", &f["options"]);
    // rust: if !options.is_empty() {
    // rust: let pick = self
    // rust: .random
    // rust: .next_int_bound(options.len() as i32)
    // rust: .unwrap_or(0) as usize;
    // rust: stack
    // rust: .components
    // rust: .retain(|(k, _)| k != "minecraft:instrument");
    // rust: stack.components.push((
    // rust: "minecraft:instrument".to_owned(),
    // rust: Value::String(options[pick].clone()),
    // rust: ));
}
}
    // rust: "minecraft:set_item" => {
    // rust: if let Some(item) = f["item"].as_str() {
    // rust: stack.item = item.to_owned();
}
}
            // ExplorationMapFunction needs an origin; with one, the map is
            // taken as found here and the game runs the structure search
            // (it drops the map when nothing is found, as the filtered
            // map_id check after it would).
    // rust: "minecraft:exploration_map" => {
    // rust: stack.map = self.biome.is_some();
    // rust: if stack.map {
    // rust: stack.exploration = Some(Box::new(ExplorationMap::from_json(f)));
}
}
    // rust: "minecraft:filtered" => {
    // rust: let pass = self.item_matches(&f["item_filter"], &stack);
    // rust: let branch = if pass { &f["on_pass"] } else { &f["on_fail"] };
    // rust: stack = self.modify(branch, stack);
}
    // rust: "minecraft:discard" => stack.count = 0,
    // rust: "minecraft:enchanted_count_increase" => {
    // rust: if let Some(attacker) = self.living_attacker() {
    // rust: let level =
    // rust: data.enchantment_level(f["enchantment"].as_str().unwrap_or(""), attacker);
    // rust: if level != 0 {
    // rust: let addition = level as f32 * self.float(&f["count"]);
                        // ItemStack.grow(Math.round(addition)).
    // rust: stack.count = stack.get_count() + (addition + 0.5).floor() as i32;
    // rust: let limit = int_value(&f["limit"]).unwrap_or(0) as i32;
    // rust: if limit > 0 && !stack.is_empty() && stack.count > limit {
    // rust: stack.count = limit;
}
}
}
}
    // rust: "minecraft:furnace_smelt" => {
    // rust: if !stack.is_empty()
    // rust: && let Some((_, result, count)) = data
    // rust: .smelting
    // rust: .iter()
    // rust: .find(|(ingredient, _, _)| data.item_in(&stack.item, ingredient))
    // rust: {
    // rust: let input = if f["use_input_count"].as_bool().unwrap_or(true) {
    // rust: stack.count
    // rust: } else {
    // rust: 1
}
    // rust: let mut smelted = LootStack::new(result);
    // rust: smelted.count = (input * count).min(data.facts(result).max_stack);
    // rust: stack = smelted;
}
}
            // SetNameFunction: the component the target names (custom_name by
            // default). The entity-resolved selectors and scores are not
            // modelled; no table uses `entity`.
    // rust: "minecraft:set_name" if !f["name"].is_null() => {
    // rust: let target = f["target"].as_str().unwrap_or("custom_name");
    // rust: let id = format!("minecraft:{target}");
    // rust: stack.names.retain(|(k, _)| *k != id);
    // rust: stack.names.push((id, f["name"].clone()));
}
            // SetComponentsFunction: the patch's components, applied when the
            // stack becomes an item (trim on worn armour, see `mobs::finalize`).
    // rust: "minecraft:set_components" => {
    // rust: for (id, value) in f["components"].as_object().into_iter().flatten() {
    // rust: stack.components.retain(|(k, _)| k != id);
    // rust: stack.components.push((id.clone(), value.clone()));
}
}
            // A mod's own kind: the hook changes the stack.
    // rust: k if k.contains(':') && !k.starts_with("minecraft:") => {
    // rust: native_loot_function(k, f, &self.native_ctx(), &mut stack);
}
            // Lore and other data without random draws.
    // rust: _ => {}
}
    // rust: stack
}
    /// ItemPredicate subset used by filtered modifiers and equipment.
pub fn item_matches(self: *Self, p: *Value, stack: *LootStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !p["items"].is_null() && !self.data.item_in(&stack.item, &p["items"]) {
    // rust: return false;
}
    // rust: if !int_bounds(&p["count"], stack.count) {
    // rust: return false;
}
    // rust: if p["predicates"].get("minecraft:map_id").is_some() && !stack.map {
    // rust: return false;
}
        // EnchantmentsPredicate: every entry must hold.
    // rust: if let Some(list) = p["predicates"]["minecraft:enchantments"].as_array() {
    // rust: let data = self.data;
    // rust: let ok = list.iter().all(|e| {
    // rust: let levels = &e["levels"];
    // rust: match &e["enchantments"] {
    // rust: Value::Null => stack
    // rust: .enchantments
    // rust: .iter()
    // rust: .any(|(_, l)| int_bounds(levels, *l)),
    // rust: set => data.holder_set("enchantment", set).iter().any(|name| {
    // rust: let level = item_level(stack, name);
    // rust: level != 0 && int_bounds(levels, level)
    // rust: }),
}
    // rust: });
    // rust: if !ok {
    // rust: return false;
}
}
    // rust: true
}
    /// EnchantmentHelper.selectEnchantment.
    // rust: fn select_enchantments(
    // rust: &mut self,
    // rust: item: &str,
    // rust: mut cost: i32,
    // rust: source: &[usize],
    // rust: ) -> Vec<(usize, i32)> {
    // rust: let data = self.data;
    // rust: let mut results = Vec::new();
    // rust: let Some(value) = data.facts(item).enchantable else {
    // rust: return results;
}
    // rust: cost += 1
    // rust: + self.random.next_int_bound(value / 4 + 1).unwrap_or(0)
    // rust: + self.random.next_int_bound(value / 4 + 1).unwrap_or(0);
    // rust: let span = (self.random.next_float() + self.random.next_float() - 1.) * 0.15;
    // rust: cost = ((cost as f32 + cost as f32 * span + 0.5).floor() as i32).max(1);
    // rust: let book = item == "minecraft:book";
    // rust: let mut available: Vec<(usize, i32)> = Vec::new();
    // rust: for &i in source {
    // rust: let e = &data.enchantments[i];
    // rust: let primary = data.item_in(item, &e.supported)
    // rust: && e.primary.as_ref().is_none_or(|p| data.item_in(item, p));
    // rust: if !primary && !book {
    // rust: continue;
}
    // rust: for level in (1..=e.max_level).rev() {
    // rust: if cost >= e.min_cost(level) && cost <= e.max_cost(level) {
    // rust: available.push((i, level));
    // rust: break;
}
}
}
    // rust: if available.is_empty() {
    // rust: return results;
}
    // rust: let pick = |random: &mut R, list: &[(usize, i32)]| -> Option<(usize, i32)> {
    // rust: let total: i32 = list.iter().map(|&(i, _)| data.enchantments[i].weight).sum();
    // rust: if total <= 0 {
    // rust: return None;
}
    // rust: let mut selection = random.next_int_bound(total).unwrap_or(0);
    // rust: for &entry in list {
    // rust: selection -= data.enchantments[entry.0].weight;
    // rust: if selection < 0 {
    // rust: return Some(entry);
}
}
    // rust: None
}
    // rust: results.extend(pick(&mut self.random, &available));
    // rust: while self.random.next_int_bound(50).unwrap_or(0) <= cost {
    // rust: if let Some(&(last, _)) = results.last() {
    // rust: available.retain(|&(i, _)| self.compatible(last, i));
}
    // rust: if available.is_empty() {
    // rust: break;
}
    // rust: results.extend(pick(&mut self.random, &available));
    // rust: cost /= 2;
}
    // rust: results
}
    /// Enchantment.areCompatible.
pub fn compatible(self: *Self, a: usize, b: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = self.data;
    // rust: let (ea, eb) = (&data.enchantments[a], &data.enchantments[b]);
    // rust: a != b
    // rust: && !data
    // rust: .holder_set("enchantment", &ea.exclusive)
    // rust: .contains(&eb.name)
    // rust: && !data
    // rust: .holder_set("enchantment", &eb.exclusive)
    // rust: .contains(&ea.name)
}
    /// LootTable.getRandomItemsRaw.
pub fn table_raw(self: *Self, name: []const u8, table: *Value, sink: *mut Sink<'_) void {
}
    // rust: if self.visited.iter().any(|v| v == name) {
    // rust: return;
}
    // rust: self.visited.push(name.to_owned());
    // rust: let table_modifier = &table["modifier"];
    // rust: for pool in table["pools"].as_array().into_iter().flatten() {
    // rust: if !pool["condition"].is_null() && !self.condition(&pool["condition"]) {
    // rust: continue;
}
    // rust: let bonus = if pool["bonus_rolls"].is_null() {
    // rust: 0.0
    // rust: } else {
    // rust: self.float(&pool["bonus_rolls"])
}
    // rust: let rolls = self.int(&pool["rolls"]) + (bonus * self.luck).floor() as i32;
    // rust: for _ in 0..rolls {
    // rust: self.add_random_item(pool, &mut |c, stack| {
    // rust: let stack = c.modify(&pool["modifier"], stack);
    // rust: let stack = c.modify(table_modifier, stack);
    // rust: sink(c, stack);
    // rust: });
}
}
    // rust: self.visited.pop();
}
    /// LootPool.addRandomItem.
pub fn add_random_item(self: *Self, pool: *Value, sink: *mut Sink<'_) void {
}
    // rust: let mut valid: Vec<Choice<'_>> = Vec::new();
    // rust: for entry in pool["entries"].as_array().into_iter().flatten() {
    // rust: self.expand(entry, &mut valid);
}
        // EntryBase.getWeight: max(floor(weight + quality * luck), 0).
    // rust: let luck = self.luck;
    // rust: let weight = |c: &Choice<'_>| {
    // rust: let e = c.entry;
    // rust: let w = int_value(&e["weight"]).unwrap_or(1) as f32
    // rust: + int_value(&e["quality"]).unwrap_or(0) as f32 * luck;
    // rust: w.floor().max(0.0) as i32
}
    // rust: let total: i32 = valid.iter().map(&weight).sum();
    // rust: if total == 0 || valid.is_empty() {
    // rust: return;
}
    // rust: let chosen = if valid.len() == 1 {
    // rust: valid.swap_remove(0)
    // rust: } else {
    // rust: let mut index = self.random.next_int_bound(total).unwrap_or(0);
    // rust: let Some(at) = valid.iter().position(|e| {
    // rust: index -= weight(e);
    // rust: index < 0
    // rust: }) else {
    // rust: return;
}
    // rust: valid.swap_remove(at)
}
    // rust: self.create(&chosen, sink);
}
    /// LootPoolEntryContainer.expand: the singleton entries that can run.
    // rust: fn expand<'v>(&mut self, entry: &'v Value, out: &mut Vec<Choice<'v>>) -> bool {
    // rust: if !entry["condition"].is_null() && !self.condition(&entry["condition"]) {
    // rust: return false;
}
    // rust: let children = || entry["children"].as_array().into_iter().flatten();
    // rust: match entry["type"].as_str().unwrap_or("") {
    // rust: "minecraft:alternatives" => children().any(|c| self.expand(c, out)),
    // rust: "minecraft:group" => {
    // rust: for c in children() {
    // rust: self.expand(c, out);
}
    // rust: true
}
    // rust: "minecraft:sequence" => {
    // rust: for c in children() {
    // rust: if !self.expand(c, out) {
    // rust: return false;
}
}
    // rust: true
}
    // rust: "minecraft:item" | "minecraft:empty" | "minecraft:loot_table" => {
    // rust: if int_value(&entry["weight"]).unwrap_or(1) > 0 {
    // rust: out.push(Choice { entry, item: None });
}
    // rust: true
}
            // TagEntry: one choice per item when expanded, else one for all.
    // rust: "minecraft:tag" => {
    // rust: if entry["expand"].as_bool().unwrap_or(false) {
    // rust: let items = self.data.holder_set("item", &entry["items"]);
    // rust: for item in items {
    // rust: if int_value(&entry["weight"]).unwrap_or(1) > 0 {
    // rust: out.push(Choice {
    // rust: entry,
    // rust: item: Some(item),
    // rust: });
}
}
    // rust: true
    // rust: } else {
    // rust: if int_value(&entry["weight"]).unwrap_or(1) > 0 {
    // rust: out.push(Choice { entry, item: None });
}
    // rust: true
}
}
    // rust: _ => false,
}
}
    /// LootPoolEntry.createItemStack with the entry's modifier.
pub fn create(self: *Self, choice: *Choice<'_>, sink: *mut Sink<'_) void {
}
    // rust: let entry = choice.entry;
    // rust: let modifier = &entry["modifier"];
    // rust: let mut out = |c: &mut Context<'_, R>, stack: LootStack| {
    // rust: let stack = c.modify(modifier, stack);
    // rust: sink(c, stack);
}
    // rust: match entry["type"].as_str().unwrap_or("") {
    // rust: "minecraft:item" => {
    // rust: let stack = LootStack::new(entry["name"].as_str().unwrap_or("minecraft:air"));
    // rust: out(self, stack);
}
    // rust: "minecraft:tag" => match &choice.item {
    // rust: Some(item) => out(self, LootStack::new(item)),
    // rust: None => {
    // rust: for item in self.data.holder_set("item", &entry["items"]) {
    // rust: out(self, LootStack::new(&item));
}
}
    // rust: },
    // rust: "minecraft:loot_table" => match &entry["value"] {
    // rust: Value::String(name) => {
    // rust: if let Some(table) = self.data.tables.get(name) {
    // rust: self.table_raw(name, table, &mut out);
}
}
    // rust: inline @ Value::Object(_) => self.table_raw("<inline>", inline, &mut out),
    // rust: _ => {}
    // rust: },
    // rust: _ => {}
}
}
}
/// A pool entry that can be chosen (an expanded tag entry names its item).
pub const Choice = struct {
    entry: *'v Value,
    item: ?[]const u8,
};
pub fn enchant(stack: *mut LootStack, name: []const u8, level: i32) void {
}
    // rust: match stack.enchantments.iter_mut().find(|(n, _)| n == name) {
    // rust: Some(slot) => slot.1 = level,
    // rust: None => stack.enchantments.push((name.to_owned(), level)),
}
}

    // rust: mod namespace_tests {
//     use super::*;

    /// The same root and packs share one map while it is held; other packs
    /// get their own.
pub fn loot_tables_are_shared_per_root_and_packs() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-loot-share-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: fs::create_dir_all(root.join("data/minecraft/loot_table/chests")).unwrap();
    // rust: fs::write(
    // rust: root.join("data/minecraft/loot_table/chests/a.json"),
    // rust: r#"{"pools": []}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let first = shared_tables(&root, &PackOverlay::NONE).unwrap();
    // rust: let again = shared_tables(&root, &PackOverlay::NONE).unwrap();
    // rust: assert!(Arc::ptr_eq(&first, &again));
    // rust: assert!(first.contains_key("minecraft:chests/a"));
    // rust: let files = [(
    // rust: "loot_table/minecraft:chests/b".to_owned(),
    // rust: vec![br#"{"pools": []}"#.to_vec()],
    // rust: )];
    // rust: let packs = shared_tables(&root, &PackOverlay { files: &files }).unwrap();
    // rust: assert!(!Arc::ptr_eq(&first, &packs));
    // rust: assert!(packs.contains_key("minecraft:chests/b"));
        // A table changed at the same path while `first` is still held: the
        // new file is read, not the held map.
    // rust: fs::write(
    // rust: root.join("data/minecraft/loot_table/chests/a.json"),
    // rust: r#"{"pools": [], "random_sequence": "minecraft:chests/a"}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let changed = shared_tables(&root, &PackOverlay::NONE).unwrap();
    // rust: assert!(!Arc::ptr_eq(&first, &changed));
    // rust: assert!(
    // rust: changed["minecraft:chests/a"]
    // rust: .get("random_sequence")
    // rust: .is_some()
    // rust: );
    // rust: assert!(first["minecraft:chests/a"].get("random_sequence").is_none());
    // rust: let _ = fs::remove_dir_all(&root);
}

    /// A table kept as its text reads back as the file's JSON (floats, big
    /// integers, nesting, key order); a file that is not JSON still fails
    /// the load.
pub fn loot_tables_read_back_as_loaded() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-loot-text-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let dir = root.join("data/minecraft/loot_table/blocks");
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let table = r#"{"type": "minecraft:block", "pools": [{"rolls": 1.5,
    // rust: "bonus_rolls": 0.1, "entries": [{"type": "minecraft:item", "name": "minecraft:stone",
    // rust: "weight": 9007199254740993, "functions": [{"function": "minecraft:set_count",
    // rust: "count": {"type": "minecraft:uniform", "min": -2.25e-7, "max": 1e300}}]}]}],
    // rust: "z": null, "a": [true, false, "\u00e9\n"]}"#;
    // rust: fs::write(dir.join("stone.json"), table).unwrap();
    // rust: let tables = shared_tables(&root, &PackOverlay::NONE).unwrap();
    // rust: let expected: Value = serde_json::from_str(table).unwrap();
    // rust: assert_eq!(tables.get("minecraft:blocks/stone"), Some(&expected));
    // rust: assert_eq!(tables.len(), 1);
    // rust: assert!(tables.get("minecraft:blocks/dirt").is_none());
    // rust: drop(tables);
    // rust: fs::write(dir.join("dirt.json"), r#"{"pools": [}"#).unwrap();
    // rust: assert!(shared_tables(&root, &PackOverlay::NONE).is_err());
    // rust: let _ = fs::remove_dir_all(&root);
}

    /// A content mods' root: the mods' loot tables and tags load beside
    /// vanilla's, under their own namespaces.
pub fn loads_every_namespace() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-loot-ns-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let files = [
    // rust: ("items.json", r#"{"minecraft:bread": {}}"#),
    // rust: (
    // rust: "data/minecraft/loot_table/chests/village.json",
    // rust: r#"{"pools": []}"#,
    // rust: ),
    // rust: (
    // rust: "data/kaisyn/loot_table/village/forest/house.json",
    // rust: r#"{"pools": []}"#,
    // rust: ),
    // rust: (
    // rust: "data/kaisyn/tags/item/food.json",
    // rust: r#"{"values": ["minecraft:bread"]}"#,
    // rust: ),
    // rust: ];
    // rust: for (name, text) in files {
    // rust: let path = root.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: let data = LootData::load(&root, &PackOverlay::NONE).unwrap();
    // rust: assert!(data.has_table("minecraft:chests/village"));
    // rust: assert!(data.has_table("kaisyn:village/forest/house"));
    // rust: assert!(!data.has_table("minecraft:village/forest/house"));
    // rust: assert!(data.in_tag("item", "kaisyn:food", "minecraft:bread"));
        // Rolls and weights written as floats (Towns and Towers' tables).
    // rust: let table = r#"{"pools": [{"rolls": {"type": "minecraft:uniform", "min": 3.0, "max": 3.0},
    // rust: "entries": [{"type": "minecraft:item", "name": "minecraft:bread", "weight": 2.0}]}]}"#;
    // rust: fs::write(
    // rust: root.join("data/kaisyn/loot_table/village/forest/house.json"),
    // rust: table,
    // rust: )
    // rust: .unwrap();
    // rust: let data = LootData::load(&root, &PackOverlay::NONE).unwrap();
    // rust: let filled = data.fill("kaisyn:village/forest/house", 1, 27, None);
    // rust: let count: i32 = filled.iter().flatten().map(|s| s.count).sum();
    // rust: assert_eq!(count, 3);
    // rust: let _ = fs::remove_dir_all(&root);
}

    /// `SetInstrumentFunction`: a goat horn from a loot table gets one of the options as its instrument.
pub fn set_instrument_picks_one_of_its_options() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-loot-horn-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let table = r##"{"pools": [{"rolls": 1, "entries": [{"type": "minecraft:item", "name": "minecraft:goat_horn",
    // rust: "modifier": [{"type": "minecraft:set_instrument", "options": ["minecraft:ponder_goat_horn", "minecraft:sing_goat_horn"]}]}]}]}"##;
    // rust: let files = [
    // rust: ("items.json", r#"{"minecraft:goat_horn": {}}"#),
    // rust: ("data/minecraft/loot_table/chests/horn.json", table),
    // rust: ];
    // rust: for (name, text) in files {
    // rust: let path = root.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: let data = LootData::load(&root, &PackOverlay::NONE).unwrap();
    // rust: let mut seen = std::collections::BTreeSet::new();
    // rust: for seed in (0..40).map(|n| n * 7_919) {
    // rust: let filled = data.fill("minecraft:chests/horn", seed, 27, None);
    // rust: let horn = filled.iter().flatten().next().expect("a horn");
    // rust: let instrument: Vec<_> = horn
    // rust: .components
    // rust: .iter()
    // rust: .filter(|(k, _)| k == "minecraft:instrument")
    // rust: .collect();
    // rust: assert_eq!(instrument.len(), 1, "{:?}", horn.components);
    // rust: seen.insert(instrument[0].1.as_str().unwrap().to_owned());
}
    // rust: assert_eq!(
    // rust: seen.into_iter().collect::<Vec<_>>(),
    // rust: ["minecraft:ponder_goat_horn", "minecraft:sing_goat_horn"]
    // rust: );
    // rust: let _ = fs::remove_dir_all(&root);
}

    // `content_id`'s tag key shape (`tags/<ns>:<registry>/<path>`) through
    // `tag_kind`: the id loses the registry segment, keeps the namespace.
pub fn tag_kind_yields_tag_loader_ids_for_content_id_keys() void {
}
    // rust: let overlay = PackOverlay {
    // rust: files: &[
    // rust: (
    // rust: "tags/minecraft:item/food".to_owned(),
    // rust: vec![br#"{"values": ["minecraft:bread"]}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "tags/minecraft:enchantment/trades/desert_common".to_owned(),
    // rust: vec![br#"{"values": ["minecraft:infinity"]}"#.to_vec()],
    // rust: ),
    // rust: ],
}
    // rust: let item: Vec<_> = overlay.tag_kind("item").map(|(id, _)| id).collect();
    // rust: assert_eq!(item, ["minecraft:food"]);
    // rust: let enchantment: Vec<_> = overlay.tag_kind("enchantment").map(|(id, _)| id).collect();
    // rust: assert_eq!(enchantment, ["minecraft:trades/desert_common"]);
        // Another registry's files stay out.
    // rust: assert_eq!(overlay.tag_kind("instrument").count(), 0);
}

    /// A pack's tag file joins the game's own in `TagLoader` order, and its
    /// `replace` drops what the lower sources put in.
pub fn pack_tags_join_and_replace_the_game_own() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-loot-tag-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: fs::create_dir_all(root.join("data/minecraft/tags/item")).unwrap();
    // rust: fs::write(root.join("items.json"), "{}").unwrap();
    // rust: fs::write(
    // rust: root.join("data/minecraft/tags/item/food.json"),
    // rust: r#"{"values": ["minecraft:bread", "minecraft:cookie"]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let overlay = PackOverlay {
    // rust: files: &[(
    // rust: "tags/minecraft:item/food".to_owned(),
    // rust: vec![
    // rust: br#"{"values": ["minecraft:kelp"]}"#.to_vec(),
    // rust: br#"{"replace": true, "values": ["minecraft:apple"]}"#.to_vec(),
    // rust: ],
    // rust: )],
}
    // rust: let data = LootData::load(&root, &overlay).unwrap();
    // rust: assert!(data.in_tag("item", "minecraft:food", "minecraft:apple"));
    // rust: assert!(!data.in_tag("item", "minecraft:food", "minecraft:bread"));
    // rust: assert!(!data.in_tag("item", "minecraft:food", "minecraft:kelp"));
    // rust: let _ = fs::remove_dir_all(&root);
}
}

    // rust: mod native_kinds_tests {
//     use super::*;

pub fn table(name: []const u8, json: []const u8) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::env::temp_dir().join(format!("loot-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let dir = root.join("data/minecraft/loot_table");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join("test.json"), json).unwrap();
        // LootData::load reads items.json too.
    // rust: std::fs::write(root.join("items.json"), "{}").unwrap();
    // rust: let data = LootData::load(&root, &PackOverlay::NONE).unwrap();
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: data
}

pub fn fishing_roll_can_advance_a_persistent_xoroshiro_sequence() void {
}
    // rust: let data = table(
    // rust: "fishing_sequence",
    // rust: r#"{"pools":[{"rolls":{"type":"minecraft:uniform","min":1,"max":5},"entries":[{"type":"minecraft:item","name":"minecraft:cod"}]}]}"#,
    // rust: );
    // rust: let mut sequence = horizon_core::random::XoroshiroRandom::from_state(123, 456);
    // rust: let mut expected = sequence.clone();
    // rust: for _ in 0..2 {
    // rust: let count = 1 + expected.next_int_bound(5).unwrap();
    // rust: assert_eq!(
    // rust: data.roll("minecraft:test", &mut sequence, 0.0, None, Some(true))
    // rust: .len(),
    // rust: count as usize
    // rust: );
}
    // rust: assert_eq!(sequence.next_long(), expected.next_long());
}

pub fn fishing_roll_splits_oversized_stacks() void {
}
    // rust: let data = table(
    // rust: "fishing_split",
    // rust: r#"{"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"minecraft:cod","modifier":[{"type":"minecraft:set_count","count":130}]}]}]}"#,
    // rust: );
    // rust: let mut random = LegacyRandom::new(1);
    // rust: let counts: Vec<_> = data
    // rust: .roll("minecraft:test", &mut random, 0.0, None, Some(true))
    // rust: .iter()
    // rust: .map(|stack| stack.count)
    // rust: .collect();
    // rust: assert_eq!(counts, [64, 64, 2]);
}

    /// An unclaimed condition fails (the pool drops nothing) and an
    /// unclaimed function leaves the stack's count as it was.
pub fn unclaimed_kinds_fail_the_condition_and_leave_the_stack() void {
}
    // rust: let data = table(
    // rust: "cond",
    // rust: r#"{"pools":[{"rolls":1,"condition":{"type":"mymod:always_true"},
    // rust: "entries":[{"type":"minecraft:item","name":"minecraft:stone"}]}]}"#,
    // rust: );
    // rust: let mut random = horizon_core::random::LegacyRandom::new(42);
    // rust: let items = data.roll("minecraft:test", &mut random, 0.0, None, None);
    // rust: assert!(items.is_empty());

    // rust: let data = table(
    // rust: "func",
    // rust: r#"{"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"minecraft:stone"}],
    // rust: "modifier":[{"type":"mymod:duplicate","factor":2}]}]}"#,
    // rust: );
    // rust: let mut random = horizon_core::random::LegacyRandom::new(42);
    // rust: let items = data.roll("minecraft:test", &mut random, 0.0, None, None);
    // rust: assert_eq!(items.len(), 1);
    // rust: assert_eq!(items[0].count, 1);
}

    /// A table without a mod's kind doesn't shift the random; one with a
    /// kind draws exactly one `next_long`; the same seed gives the same
    /// result.
pub fn a_mod_kind_draws_exactly_one_long_and_a_vanilla_table_none() void {
}
        // A vanilla table: the random is untouched.
    // rust: let vanilla = table(
    // rust: "seed_vanilla",
    // rust: r#"{"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"minecraft:stone"}]}]}"#,
    // rust: );
    // rust: let mut r1 = horizon_core::random::LegacyRandom::new(100);
    // rust: let mut r2 = horizon_core::random::LegacyRandom::new(100);
    // rust: let _ = vanilla.roll("minecraft:test", &mut r1, 0.0, None, None);
    // rust: let expected: Vec<_> = (0..5).map(|_| r2.next_long()).collect();
    // rust: let got: Vec<_> = (0..5).map(|_| r1.next_long()).collect();
    // rust: assert_eq!(got, expected, "vanilla table shifted the random");

        // A mod kind: exactly one next_long is drawn.
    // rust: let modded = table(
    // rust: "seed_mod",
    // rust: r#"{"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"minecraft:stone"}],
    // rust: "modifier":[{"type":"lootmod:x"}]}]}"#,
    // rust: );
    // rust: let mut r3 = horizon_core::random::LegacyRandom::new(100);
    // rust: let mut r4 = horizon_core::random::LegacyRandom::new(100);
    // rust: let _ = modded.roll("minecraft:test", &mut r3, 0.0, None, None);
    // rust: let _ = r4.next_long(); // the one draw
    // rust: let after_mod: Vec<_> = (0..5).map(|_| r4.next_long()).collect();
    // rust: let after_run: Vec<_> = (0..5).map(|_| r3.next_long()).collect();
    // rust: assert_eq!(after_run, after_mod, "mod table drew != 1 next_long");

        // Same seed, same result.
    // rust: let mut r5 = horizon_core::random::LegacyRandom::new(42);
    // rust: let a = modded.roll("minecraft:test", &mut r5, 0.0, None, None);
    // rust: let mut r6 = horizon_core::random::LegacyRandom::new(42);
    // rust: let b = modded.roll("minecraft:test", &mut r6, 0.0, None, None);
    // rust: assert_eq!(a, b, "same seed, different result");
}

pub fn place(x: f64) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NativeLootPlace {
    // rust: origin: Some([x, 64.0, 0.5]),
    // rust: ..NativeLootPlace::default()
}
}

    /// A roll sees the innermost place set around it; the outer one is back
    /// after the inner returns, and nothing after the outer, even when the
    /// roll panicked.
pub fn a_place_holds_for_its_roll_only() void {
}
    // rust: assert_eq!(current_native_loot_place(), None);
    // rust: with_native_loot_place(place(1.5), || {
    // rust: with_native_loot_place(place(2.5), || {
    // rust: assert_eq!(
    // rust: current_native_loot_place().unwrap().origin,
    // rust: Some([2.5, 64.0, 0.5])
    // rust: );
    // rust: });
    // rust: assert_eq!(
    // rust: current_native_loot_place().unwrap().origin,
    // rust: Some([1.5, 64.0, 0.5])
    // rust: );
    // rust: });
    // rust: assert_eq!(current_native_loot_place(), None);

    // rust: let panicked = std::panic::catch_unwind(|| {
    // rust: with_native_loot_place(place(3.5), || panic!("a roll failed"));
    // rust: });
    // rust: assert!(panicked.is_err());
    // rust: assert_eq!(current_native_loot_place(), None);
}

    /// A place changes nothing a table rolls: the same items, and the random
    /// left where it was, with a mod's kind in the table or not.
pub fn a_place_leaves_the_roll_as_it_was() void {
}
    // rust: for (name, json) in [
    // rust: (
    // rust: "place_vanilla",
    // rust: r#"{"pools":[{"rolls":{"type":"minecraft:uniform","min":1,"max":4},
    // rust: "entries":[{"type":"minecraft:item","name":"minecraft:stone"},
    // rust: {"type":"minecraft:item","name":"minecraft:dirt"}]}]}"#,
    // rust: ),
    // rust: (
    // rust: "place_mod",
    // rust: r#"{"pools":[{"rolls":2,"entries":[{"type":"minecraft:item","name":"minecraft:stone"}],
    // rust: "modifier":[{"type":"lootmod:x"}]}]}"#,
    // rust: ),
    // rust: ] {
    // rust: let data = table(name, json);
    // rust: let mut plain = horizon_core::random::LegacyRandom::new(7);
    // rust: let mut placed = horizon_core::random::LegacyRandom::new(7);
    // rust: let without = data.roll("minecraft:test", &mut plain, 0.0, None, None);
    // rust: let with = with_native_loot_place(place(0.5), || {
    // rust: data.roll("minecraft:test", &mut placed, 0.0, None, None)
    // rust: });
    // rust: assert_eq!(with, without, "{name}");
    // rust: assert_eq!(placed.next_long(), plain.next_long(), "{name}");
}
}

pub fn an_unknown_minecraft_function_is_skipped() void {
}
    // rust: let data = table(
    // rust: "vanilla",
    // rust: r#"{"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"minecraft:stone"}],
    // rust: "modifier":[{"type":"minecraft:future_function"},{"type":"minecraft:set_count","count":5}]}]}"#,
    // rust: );
    // rust: let mut random = horizon_core::random::LegacyRandom::new(42);
    // rust: let items = data.roll("minecraft:test", &mut random, 0.0, None, None);
    // rust: assert_eq!(items.len(), 1);
    // rust: assert_eq!(items[0].count, 5);
}
}

    // rust: mod recipe_result_tests {
//     use super::*;

    /// `ItemStackTemplate.CODEC` reads a stack's fields or a bare item id.
pub fn a_result_is_an_object_with_an_id_or_a_bare_item_id() void {
}
    // rust: let id = |json: &str| {
    // rust: let v: Value = serde_json::from_str(json).unwrap();
    // rust: recipe_result_id(&v).map(str::to_owned)
}
    // rust: assert_eq!(
    // rust: id(r#"{"id": "ruby:ruby", "count": 3}"#).as_deref(),
    // rust: Some("ruby:ruby")
    // rust: );
    // rust: assert_eq!(id(r#""ruby:ruby""#).as_deref(), Some("ruby:ruby"));
        // No `id` (a transmuting recipe keeps its input's item), the `item` key of older
        // versions and anything that is neither an object nor a string name no item.
    // rust: assert_eq!(id(r#"{"count": 2}"#), None);
    // rust: assert_eq!(id(r#"{"item": "minecraft:stick"}"#), None);
    // rust: assert_eq!(id(r#"{"id": 7}"#), None);
    // rust: assert_eq!(id("null"), None);
    // rust: assert_eq!(id("[]"), None);
}
}

    // rust: mod location_check_biome_tests {
//     use super::*;

    /// A table that drops one stone where `biomes` matches, read with a
    /// jungle biome tag of the game's own and `packs` over it.
pub fn table(name: []const u8, biomes: []const u8, packs: *[([]const u8) void {
}
    // rust: let root = std::env::temp_dir().join(format!("loot-biomes-{name}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let dir = root.join("data/minecraft/loot_table");
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let json = format!(
    // rust: r#"{{"pools":[{{"rolls":1,"entries":[{{"type":"minecraft:item","name":"minecraft:stone",
    // rust: "condition":{{"type":"minecraft:location_check","predicate":{{"biomes":{biomes}}}}}}}]}}]}}"#
    // rust: );
    // rust: fs::write(dir.join("test.json"), json).unwrap();
    // rust: let tags = root.join("data/minecraft/tags/worldgen/biome");
    // rust: fs::create_dir_all(&tags).unwrap();
    // rust: fs::write(
    // rust: tags.join("is_jungle.json"),
    // rust: r#"{"values": ["minecraft:jungle", "minecraft:bamboo_jungle"]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(root.join("items.json"), "{}").unwrap();
    // rust: let data = LootData::load(&root, &PackOverlay { files: packs }).unwrap();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: data
}

pub fn drops(data: *LootData, biome: ?[]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !data
    // rust: .roll(
    // rust: "minecraft:test",
    // rust: &mut LegacyRandom::new(1),
    // rust: 0.0,
    // rust: biome,
    // rust: None,
    // rust: )
    // rust: .is_empty()
}

    /// `LocationPredicate.biomes` is a HolderSet: a `#tag` names the biomes
    /// of the tag, which used to fail everywhere.
pub fn a_biome_tag_matches_its_biomes() void {
}
    // rust: let data = table("tag", r##""#minecraft:is_jungle""##, &[]);
    // rust: assert!(drops(&data, Some("minecraft:jungle")));
    // rust: assert!(drops(&data, Some("minecraft:bamboo_jungle")));
    // rust: assert!(!drops(&data, Some("minecraft:desert")));
        // `LocationCheck.test`: no origin, no match.
    // rust: assert!(!drops(&data, None));
        // An unknown tag is empty.
    // rust: let data = table("unknown", r##""#minecraft:is_nothing""##, &[]);
    // rust: assert!(!drops(&data, Some("minecraft:jungle")));
}

    /// A single id and a list of ids keep matching as before.
pub fn an_id_and_a_list_of_ids_still_match() void {
}
    // rust: let data = table("id", r#""minecraft:desert""#, &[]);
    // rust: assert!(drops(&data, Some("minecraft:desert")));
    // rust: assert!(!drops(&data, Some("minecraft:jungle")));
    // rust: let data = table(
    // rust: "list",
    // rust: r#"["minecraft:jungle", "minecraft:sparse_jungle"]"#,
    // rust: &[],
    // rust: );
    // rust: assert!(drops(&data, Some("minecraft:sparse_jungle")));
    // rust: assert!(!drops(&data, Some("minecraft:bamboo_jungle")));
}

    /// The world's packs' biome tags join the game's own, as
    /// `TagLoader.loadTagsForExistingRegistries` binds them.
pub fn a_pack_biome_tag_counts() void {
}
    // rust: let packs = vec![
    // rust: (
    // rust: "tags/minecraft:worldgen/biome/is_jungle".to_owned(),
    // rust: vec![br#"{"values":["minecraft:plains"]}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "tags/mypack:worldgen/biome/warm".to_owned(),
    // rust: vec![br##"{"values":["#minecraft:is_jungle","minecraft:desert"]}"##.to_vec()],
    // rust: ),
    // rust: ];
    // rust: let data = table("pack", r##""#minecraft:is_jungle""##, &packs);
    // rust: assert!(drops(&data, Some("minecraft:plains")));
    // rust: assert!(drops(&data, Some("minecraft:jungle")));
    // rust: let data = table("packown", r##""#mypack:warm""##, &packs);
    // rust: assert!(drops(&data, Some("minecraft:bamboo_jungle")));
    // rust: assert!(drops(&data, Some("minecraft:desert")));
    // rust: assert!(!drops(&data, Some("minecraft:savanna")));
}
}
