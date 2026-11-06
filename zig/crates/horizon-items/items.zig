//! Transpiled from Horizon Rust crate
//! Module: horizon-items_items
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Items from vanilla's default-component reports, block<->item mapping,
//! tool mining rules and block loot tables (`LootTable`/`LootPool` semantics
//! for the condition, entry and modifier types used by block drops).
// use crate::{Result, blocks::BlockFacts};
// use horizon_core::random::RandomSource;
// use horizon_world::loot::PackOverlay;
// use horizon_world::registry::{BlockRegistry, BlockStateId};
// use serde_json::Value;
// use std::{
    // rust: collections::{HashMap, HashSet},
    // rust: fs,
    // rust: path::Path,
    // rust: sync::Arc,
}

/// A fire starter's use sound: `SoundEvents.FIRECHARGE_USE` or
/// `FLINTANDSTEEL_USE`.
pub fn fire_starter_sound(fire_charge: bool) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if fire_charge {
    // rust: "minecraft:item.firecharge.use"
    // rust: } else {
    // rust: "minecraft:item.flintandsteel.use"
}
}

/// The pitch of a fire starter's use sound, from the level's random:
/// `FlintAndSteelItem.useOn`'s `nextFloat() * 0.4 + 0.8`, or
/// `FireChargeItem.playSound`'s `(nextFloat() - nextFloat()) * 0.2 + 1.0`.
pub fn fire_starter_pitch(fire_charge: bool, random: *mut impl RandomSource) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if fire_charge {
    // rust: (random.next_float() - random.next_float()) * 0.2 + 1.0
    // rust: } else {
    // rust: random.next_float() * 0.4 + 0.8
}
}

pub const ToolRule = struct {
    blocks: std.ArrayList([]const u8),
    speed: ?f32,
    correct: ?bool,
};
pub const ConsumeEffectSpec = struct {
    id: []const u8,
    duration: i32,
    amplifier: i32,
    /// `MobEffectInstance`'s `ambient` (default false) and `show_particles` (default true).
    ambient: bool,
    show_particles: bool,
};

pub const ConsumeEffect = enum {
    ApplyEffects {,
    effects: Vec<ConsumeEffectSpec>,
    probability: f32,
    // rust: },
    ClearAllEffects,
    RemoveEffects(Vec<String>),
    /// `TeleportRandomlyConsumeEffect`.
    TeleportRandomly(horizon_world::teleport_consume::TeleportConsume),
    PlaySound(String),
    /// A mod's own kind, kept as the file wrote it (the loader used to drop
    /// it silently): the game hands it to `native_consume_effect`.
    /// API 74
    Native {,
    kind: String,
    data: serde_json::Value,
    // rust: },
};

/// One `on_consume_effects` entry. A bare type name is minecraft's own, as
/// a bare item id is: `apply_effects` and `:apply_effects` are
/// `minecraft:apply_effects`. A
/// namespaced kind outside `minecraft:` is the mod's own, kept whole for
/// the hook. An unknown `minecraft:` kind and a missing type are dropped.
pub fn parse_consume_effect(effect: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = effect.get("type")?.as_str()?;
    // `Identifier.bySeparator`: no namespace, or an empty one (`:clear_all_effects`), is minecraft's.
    // rust: let kind = match kind.split_once(':') {
    // rust: Some(("", path)) => format!("minecraft:{path}"),
    // rust: Some(_) => kind.to_owned(),
    // rust: None => format!("minecraft:{kind}"),
}
    // rust: match kind.as_str() {
    // rust: "minecraft:apply_effects" => {
    // rust: let probability = effect
    // rust: .get("probability")
    // rust: .and_then(|p| p.as_f64())
    // rust: .map_or(1.0, |p| p as f32);
    // rust: let mut specs = Vec::new();
    // rust: if let Some(list) = effect.get("effects").and_then(|l| l.as_array()) {
    // rust: specs.extend(list.iter().filter_map(consume_effect_spec));
}
    // rust: Some(ConsumeEffect::ApplyEffects {
    // rust: effects: specs,
    // rust: probability,
    // rust: })
}
    // rust: "minecraft:clear_all_effects" => Some(ConsumeEffect::ClearAllEffects),
    // rust: "minecraft:remove_effects" => {
    // rust: let mut targets = Vec::new();
    // rust: if let Some(eff) = effect.get("effects") {
    // rust: if let Some(s) = eff.as_str() {
    // rust: targets.push(s.to_string());
    // rust: } else if let Some(arr) = eff.as_array() {
    // rust: for item in arr {
    // rust: if let Some(s) = item.as_str() {
    // rust: targets.push(s.to_string());
}
}
}
}
    // rust: Some(ConsumeEffect::RemoveEffects(targets))
}
    // rust: "minecraft:teleport_randomly" => Some(ConsumeEffect::TeleportRandomly(
    // rust: horizon_world::teleport_consume::TeleportConsume {
    // rust: diameter: effect
    // rust: .get("diameter")
    // rust: .and_then(serde_json::Value::as_f64)
    // rust: .map_or(16.0, |d| d as f32),
    // rust: directional_particles: effect
    // rust: .get("directional_particles")
    // rust: .and_then(serde_json::Value::as_bool)
    // rust: .unwrap_or(true),
    // rust: },
    // rust: )),
    // rust: "minecraft:play_sound" => effect
    // rust: .get("sound")
    // rust: .and_then(|s| s.as_str())
    // rust: .map(|s| ConsumeEffect::PlaySound(s.to_string())),
    // rust: k if !k.starts_with("minecraft:") => Some(ConsumeEffect::Native {
    // rust: kind: k.to_owned(),
    // rust: data: effect.clone(),
    // rust: }),
    // rust: _ => None,
}
}

pub const ItemInfo = struct {
    fire_resistant: bool,
    id: *str,
    max_stack: u32,
    max_damage: u32,
    block: ?BlockStateId,
    tool: std.ArrayList(ToolRule),
    tool_default_speed: f32,
    /// The `tool` component's `damage_per_block`, when the item has the
    /// component (a mace or trident has one without rules).
    tool_damage_per_block: ?u32,
    /// `tool.can_destroy_blocks_in_creative` (defaults to true).
    can_destroy_blocks_in_creative: bool,
    food: Option<(u32,
    can_always_eat: bool,
    /// `consumable`: its timing, sound, particles and `on_consume_effects`.
    consumable: Option<horizon_world::consumable::Consumable<[]const u8,
    /// `use_remainder`: what a finished use leaves (`UseRemainder`).
    use_remainder: ?[]const u8,
    /// `use_cooldown`: the cooldown a use starts (`UseCooldown`).
    use_cooldown: ?crate::cooldowns::UseCooldown,
    model: []const u8,
    /// Main-hand `attack_damage` / `attack_speed` modifier amounts.
    attack_damage: f32,
    attack_speed: f32,
    /// `cooking_fuel`: burn-time and speed-multiplier provider references.
    fuel: Option<(Value,
    /// `brewing_fuel`: uses and speed-multiplier provider references.
    brewing_fuel: Option<(Value,
    /// `compostable.layers`: the layers provider (`ComposterBlock.addLayer`).
    compostable: ?Value,
    /// Item left behind after crafting/fuel use (e.g. bucket).
    remainder: ?[]const u8,
    /// `equippable.slot` (head, chest, legs, feet, ...).
    equip_slot: ?[]const u8,
    /// `equippable.asset_id`: the equipment asset drawn when worn.
    equip_asset: ?[]const u8,
    /// All `attribute_modifiers`: (attribute, id, amount, operation, slot group).
    modifiers: Vec<([]const u8,
    /// `blocks_attacks` (shields).
    blocks_attacks: ?BlocksAttacks,
    /// `weapon.disable_blocking_for_seconds` (axes).
    disable_blocking_seconds: f32,
    /// `weapon.item_damage_per_attack`, when the item is a weapon.
    weapon_damage: ?u32,
    /// `villager_food.nutrition`: what a villager gets from eating it.
    villager_food: ?i32,
    /// `use_effects.speed_multiplier` (UseEffects.DEFAULT: 0.2).
    use_speed: f32,
    /// `use_effects.can_sprint` (default false): sprinting may start while the
    /// item is in use.
    can_sprint: bool,
    /// `use_effects.interact_vibrations` (default true).
    interact_vibrations: bool,
    /// `glider` (elytra).
    glider: bool,
    /// `equippable.swappable` and `equip_sound`.
    swappable: bool,
    /// `equippable.dispensable` (dispensers may put it on an entity).
    equip_dispensable: bool,
    /// `equippable.damage_on_hurt`: the item wears when its wearer is hurt
    /// (false for the elytra).
    equip_damage_on_hurt: bool,
    /// `equippable.allowed_entities` resolved to entity type ids; None allows all.
    equip_allowed: ?std.AutoHashMap([]const u8, void),
    equip_sound: ?[]const u8,
    /// `jukebox_playable`: the jukebox song it plays.
    jukebox_song: ?[]const u8,
    /// `crafting_remainder`: what stays in the grid when the item is used in a recipe.
    crafting_remainder: ?[]const u8,
    /// `dye`: the dye colour name (dyes, and anything else with the component).
    dye: ?[]const u8,
    /// `cushion/color`: the DyeColor name of a cushion item.
    cushion_color: ?[]const u8,
    /// `block_transformer`: the registry entry an axe, hoe or shovel uses on blocks.
    block_transformer: ?[]const u8,
    /// Has a default `bundle_contents` (the bundles, `BundleItem`).
    bundle: bool,
    /// The ids of the item's default components (its prototype's keys).
    components: std.ArrayList([]const u8),
    /// Opaque native component defaults, keyed by their registered name.
    custom_components: std::collections::BTreeMap<[]const u8,
};
/// `Item.Properties.craftRemainder` (not a data component, so not in the
/// default-component report): what an item leaves in the grid when crafted with.
    // rust: pub const CRAFT_REMAINDERS: [(&str, &str); 5] = [
    // rust: ("minecraft:water_bucket", "minecraft:bucket"),
    // rust: ("minecraft:lava_bucket", "minecraft:bucket"),
    // rust: ("minecraft:milk_bucket", "minecraft:bucket"),
    // rust: ("minecraft:dragon_breath", "minecraft:glass_bottle"),
    // rust: ("minecraft:honey_bottle", "minecraft:glass_bottle"),
    // rust: ];
/// In a root built by `mod_content::build`: the content mods' items' crafting
/// remainders, by item. Other roots have none.
pub const MOD_CRAFT_REMAINDERS: []const u8 = "horizon-mod-craft-remainders.json";
/// A reduction of `blocks_attacks.damage_reductions`.
pub const BlockReduction = struct {
    horizontal_angle: f32,
    /// Damage type ids or `#tags`; None blocks every type.
    types: ?std.ArrayList([]const u8),
    base: f32,
    factor: f32,
};
/// The `blocks_attacks` component.
pub const BlocksAttacks = struct {
    delay_seconds: f32,
    disable_scale: f32,
    reductions: std.ArrayList(BlockReduction),
    /// item_damage: (threshold, base, factor)
    item_damage: (f32,
    bypassed_by: ?[]const u8,
    block_sound: ?[]const u8,
    disabled_sound: ?[]const u8,
};
    // rust: impl BlocksAttacks {
    /// The `blocks_attacks` `stack` has (`ItemStack.get(DataComponents.BLOCKS_ATTACKS)`):
    /// its own component when it carries one (`/give @s diamond_sword[blocks_attacks={}]`,
    /// or a server's item), else its item's (`item`, a shield's).
    // rust: pub fn of_stack<'a>(
    // rust: stack: &ItemStack,
    // rust: item: Option<&'a ItemInfo>,
    // rust: ) -> Option<std::borrow::Cow<'a, Self>> {
    // rust: if let Some(own) = stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:blocks_attacks"))
    // rust: {
    // rust: let json = horizon_client_core::scoreboard::tag_to_json(own);
    // rust: return Self::parse(&json).map(std::borrow::Cow::Owned);
}
    // rust: item?
    // rust: .blocks_attacks
    // rust: .as_ref()
    // rust: .map(std::borrow::Cow::Borrowed)
}
pub fn parse(v: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !v.is_object() {
    // rust: return None;
}
    // rust: let f = |v: &Value, d: f64| v.as_f64().unwrap_or(d) as f32;
    // rust: let text = |v: &Value| v.as_str().map(str::to_owned);
    // rust: let reductions = match v["damage_reductions"].as_array() {
    // rust: Some(list) => list
    // rust: .iter()
    // rust: .map(|r| BlockReduction {
    // rust: horizontal_angle: f(&r["horizontal_blocking_angle"], 90.0),
    // rust: types: match &r["type"] {
    // rust: Value::String(s) => Some(vec![s.clone()]),
    // rust: Value::Array(a) => Some(
    // rust: a.iter()
    // rust: .filter_map(|t| t.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: ),
    // rust: _ => None,
    // rust: },
    // rust: base: f(&r["base"], 0.0),
    // rust: factor: f(&r["factor"], 0.0),
    // rust: })
    // rust: .collect(),
            // BlocksAttacks.CODEC default: block everything within 90 degrees.
    // rust: None => vec![BlockReduction {
    // rust: horizontal_angle: 90.0,
    // rust: types: None,
    // rust: base: 0.0,
    // rust: factor: 1.0,
    // rust: }],
}
    // rust: let d = &v["item_damage"];
    // rust: Some(Self {
    // rust: delay_seconds: f(&v["block_delay_seconds"], 0.0),
    // rust: disable_scale: f(&v["disable_cooldown_scale"], 1.0),
    // rust: reductions,
    // rust: item_damage: if d.is_object() {
    // rust: (
    // rust: f(&d["threshold"], 1.0),
    // rust: f(&d["base"], 0.0),
    // rust: f(&d["factor"], 1.0),
    // rust: )
    // rust: } else {
    // rust: (1.0, 0.0, 1.0)
    // rust: },
    // rust: bypassed_by: text(&v["bypassed_by"]),
    // rust: block_sound: text(&v["block_sound"]),
    // rust: disabled_sound: text(&v["disabled_sound"]),
    // rust: })
}
}
pub const ItemStack = struct {
    item: *str,
    count: u32,
    damage: u32,
    /// Components beyond count and damage (see `item_data`); None when default.
    extra: ?*crate::item_data::StackData,
};
/// `order`'s items in the registry's order (`command-registries.json`'s
/// `items`, exported from the game); `order` itself when that is missing.
pub fn registry_order(root: *Path, order: *[*str]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let listed: Vec<String> = fs::read(root.join("command-registries.json"))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<Value>(&b).ok())
    // rust: .and_then(|v| serde_json::from_value(v["items"].clone()).ok())
    // rust: .unwrap_or_default();
    // rust: if listed.is_empty() {
    // rust: return order.to_vec();
}
    // rust: let known: HashSet<&str> = order.iter().map(|i| &**i).collect();
    // rust: listed
    // rust: .iter()
    // rust: .filter(|i| known.contains(i.as_str()))
    // rust: .map(|i| Arc::from(i.as_str()))
    // rust: .collect()
}
/// Item ids standing for a loot table's `minecraft:dynamic` entries.
pub const DYNAMIC: []const u8 = "#dynamic:";
/// The item id standing for a chosen `minecraft:loot_table` entry, whose
/// table then rolls in full (`NestedLootTable`).
pub const NESTED: []const u8 = "#loot_table";
    // rust: thread_local! {
    /// The nested tables rolling now, outermost first: a table never rolls
    /// inside itself (`LootContext.pushVisitedElement`).
pub const NESTED_ROLLS: std::cell::RefCell<std.ArrayList([]const u8)> = const { std::cell::RefCell::new(Vec::new()) };
}
pub const Items = struct {
    items: HashMap<*str,
    /// Default `minecraft:mob_visibility` by item id, with the `equippable`
    /// slot it applies in (`LivingEntity.getVisibilityPercent`).
    mob_visibility: HashMap<*str,
    order: std.ArrayList(*str),
    /// The same items in item registry (network id) order, as vanilla lists
    /// them; sorted by name when the registry export is missing.
    registry_order: std.ArrayList(*str),
    /// Block tag name (without '#') -> member block names.
    block_tags: HashMap<[]const u8,
    item_tags: HashMap<[]const u8,
    /// Item tags in vanilla's order (`TagLoader`: file order, nested tags in
    /// place, first occurrence kept), the order `TagSlotDisplay` resolves.
    item_tag_order: HashMap<[]const u8,
    loot: *horizon_world::loot::LootTables,
    /// The `jukebox_song` registry.
    songs: HashMap<[]const u8,
    /// The `instrument` registry (goat horns).
    instruments: HashMap<[]const u8,
    /// The enchantment registry: loot functions enchant the items they roll
    /// (`EnchantWithLevelsFunction`, `EnchantRandomlyFunction`), and the
    /// station menus share this copy.
    enchantments: *crate::enchant::Enchantments,
};
/// A `JukeboxSong`.
pub const Song = struct {
    sound: []const u8,
    length_ticks: i64,
    comparator: i32,
    description: Value,
};
    // rust: impl Song {
    /// `hasFinished`: the length plus one second.
pub fn finished(self: *Self, ticks: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ticks >= self.length_ticks + 20
}
}
/// An `Instrument`: what a goat horn plays.
pub const Instrument = struct {
    sound: []const u8,
    /// Seconds the horn stays up, and its cooldown.
    use_duration: f32,
    /// How far it carries, in blocks (`range / 16` is its volume).
    range: f32,
};
    // rust: impl Instrument {
    /// `InstrumentItem.getUseDuration`: `Mth.floor(useDuration * 20)`.
pub fn use_ticks(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.use_duration * 20.0).floor() as i32
}
}
/// The id of a goat horn's instrument (`InstrumentItem.getInstrument`): the
/// stack's own `instrument` component, else the item's `ponder_goat_horn`.
/// None for an inline instrument (see `inline_instrument`).
pub fn instrument_id(stack: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if &*stack.item != "minecraft:goat_horn" {
    // rust: return None;
}
    // rust: match stack.data().and_then(|d| d.other("minecraft:instrument")) {
    // rust: Some(horizon_world::nbt::Tag::String(id)) => Some(id.to_string_lossy()),
    // rust: Some(horizon_world::nbt::Tag::Compound(_)) => None,
    // rust: _ => Some("minecraft:ponder_goat_horn".to_owned()),
}
}
/// A goat horn's inline `instrument` component (`Instrument.CODEC` also
/// takes the instrument itself instead of a registry id).
pub fn inline_instrument(stack: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if &*stack.item != "minecraft:goat_horn" {
    // rust: return None;
}
    // rust: match stack.data().and_then(|d| d.other("minecraft:instrument")) {
    // rust: Some(tag @ horizon_world::nbt::Tag::Compound(_)) => Some(tag),
    // rust: _ => None,
}
}
/// `Instrument.DIRECT_CODEC`: a `sound_event` that is an id or `{sound_id}`,
/// `use_duration` and `range`.
pub fn parse_instrument(v: *Value) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sound = match &v["sound_event"] {
    // rust: Value::String(s) => s.clone(),
    // rust: other => other["sound_id"].as_str().unwrap_or("").to_owned(),
}
    // rust: Instrument {
    // rust: sound,
    // rust: use_duration: v["use_duration"].as_f64().unwrap_or(0.0) as f32,
    // rust: range: v["range"].as_f64().unwrap_or(0.0) as f32,
}
}
pub fn load_instruments(root: *Path) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut instruments = HashMap::new();
    // rust: let Ok(dir) = fs::read_dir(root.join("data/minecraft/instrument")) else {
    // rust: return instruments;
}
    // rust: for entry in dir.flatten() {
    // rust: let path = entry.path();
    // rust: let (Some(stem), Ok(bytes)) = (path.file_stem().and_then(|s| s.to_str()), fs::read(&path))
    // rust: else {
    // rust: continue;
}
    // rust: let Ok(v) = serde_json::from_slice::<Value>(&bytes) else {
    // rust: continue;
}
    // rust: instruments.insert(format!("minecraft:{stem}"), parse_instrument(&v));
}
    // rust: instruments
}
pub fn load_songs(root: *Path) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut songs = HashMap::new();
    // rust: let Ok(dir) = fs::read_dir(root.join("data/minecraft/jukebox_song")) else {
    // rust: return songs;
}
    // rust: for entry in dir.flatten() {
    // rust: let path = entry.path();
    // rust: let (Some(stem), Ok(bytes)) = (path.file_stem().and_then(|s| s.to_str()), fs::read(&path))
    // rust: else {
    // rust: continue;
}
    // rust: let Ok(v) = serde_json::from_slice::<Value>(&bytes) else {
    // rust: continue;
}
    // rust: let sound = match &v["sound_event"] {
    // rust: Value::String(s) => s.clone(),
    // rust: other => other["sound_id"].as_str().unwrap_or("").to_owned(),
}
    // rust: songs.insert(
    // rust: format!("minecraft:{stem}"),
    // rust: Song {
    // rust: sound,
    // rust: length_ticks: (v["length_in_seconds"].as_f64().unwrap_or(0.0) as f32 * 20.0).ceil()
    // rust: as i64,
    // rust: comparator: v["comparator_output"].as_i64().unwrap_or(0) as i32,
    // rust: description: v["description"].clone(),
    // rust: },
    // rust: );
}
    // rust: songs
}
    // rust: pub fn load_tags(
    // rust: root: &Path,
    // rust: kind: &str,
    // rust: overlay: &PackOverlay,
    // rust: ) -> Result<HashMap<String, HashSet<String>>> {
    // rust: Ok(load_tag_lists(root, kind, overlay)?
    // rust: .into_iter()
    // rust: .map(|(k, v)| (k, v.into_iter().collect()))
    // rust: .collect())
}
/// Every tag's contents in `TagLoader.tryBuildTag` order (a `LinkedHashSet`).
/// `overlay` adds a world's data packs over the game's own tag files.
    // rust: pub(crate) fn load_tag_lists(
    // rust: root: &Path,
    // rust: kind: &str,
    // rust: overlay: &PackOverlay,
    // rust: ) -> Result<HashMap<String, Vec<String>>> {
    // rust: let mut raw: HashMap<String, Vec<String>> = HashMap::new();
    /// Through `json_folder`: from the prepared data file, and read once for
    /// the tables a load builds from the same tags.
pub fn walk(dir: *Path, namespace: []const u8, raw: *mut HashMap<[]const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for file in &horizon_world::json_folder::read(dir)?.files {
    // rust: let v: Value = serde_json::from_slice(file.bytes()?)?;
    // rust: let values = v["values"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|e| e.as_str().or_else(|| e["id"].as_str()).map(str::to_owned))
    // rust: .collect();
    // rust: raw.insert(format!("{namespace}:{}", file.name), values);
}
    // rust: Ok(())
}
    // Vanilla's tags; with content mods also the convention (`c`) tags and the mods' own.
    // rust: for namespace in crate::content_namespaces::tag_namespaces(root) {
    // rust: let dir = root.join(format!("data/{namespace}/tags/{kind}"));
    // rust: if dir.exists() {
    // rust: walk(&dir, &namespace, &mut raw)?;
}
}
    // The packs' entries join the game's own, in pack order; a `replace`
    // file drops what the lower sources put in (`TagLoader.load` walks the
    // resource stack the same way). `tag_kind` reads the packs' keys
    // (`tags/<ns>:<registry>/<path>`) and yields the `ns:path` ids the raw
    // map is keyed by.
    // rust: for (id, files) in overlay.tag_kind(kind) {
    // rust: let slot = raw.entry(id.to_owned()).or_default();
    // rust: for bytes in files {
    // rust: let Ok(v) = serde_json::from_slice::<Value>(bytes) else {
    // rust: continue;
}
    // rust: if v["replace"].as_bool() == Some(true) {
    // rust: slot.clear();
}
    // rust: slot.extend(
    // rust: v["values"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|e| e.as_str().or_else(|| e["id"].as_str()).map(str::to_owned)),
    // rust: );
}
}
pub fn resolve(name: []const u8, raw: *HashMap<[]const u8, out: *mut std.ArrayList([]const u8), depth: u32) void {
}
    // rust: if depth > 32 {
    // rust: return;
}
    // rust: for v in raw.get(name).into_iter().flatten() {
    // rust: if let Some(tag) = v.strip_prefix('#') {
    // rust: resolve(tag, raw, out, depth + 1);
    // rust: } else if !out.contains(v) {
    // rust: out.push(v.clone());
}
}
}
    // rust: Ok(raw
    // rust: .keys()
    // rust: .map(|k| {
    // rust: let mut list = Vec::new();
    // rust: resolve(k, &raw, &mut list, 0);
    // rust: (k.clone(), list)
    // rust: })
    // rust: .collect())
}
/// An entity type id or `#tag` as the set of entity type ids it names.
pub fn entity_spec(tags: *HashMap<[]const u8, spec: []const u8) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match spec.strip_prefix('#') {
    // rust: Some(tag) => tags.get(tag).cloned().unwrap_or_default(),
    // rust: None => HashSet::from([spec.to_owned()]),
}
}
/// `MobVisibility`: entity types a worn item hides its wearer from, and the
/// factor `LivingEntity.getVisibilityPercent` multiplies by.
pub const MobVisibility = struct {
    targeting: std.AutoHashMap([]const u8, void),
    visibility: f32,
};
/// `minecraft:mob_visibility` (`targeting_entity_types` is one id, a `#tag`,
/// or a list) when the object is present and names at least one type.
    // rust: fn parse_mob_visibility(
    // rust: v: &Value,
    // rust: tags: &HashMap<String, HashSet<String>>,
    // rust: ) -> Option<MobVisibility> {
    // rust: if !v.is_object() {
    // rust: return None;
}
    // rust: let visibility = v.get("visibility")?.as_f64()? as f32;
    // rust: let targeting = match v.get("targeting_entity_types")? {
    // rust: Value::String(spec) => entity_spec(tags, spec),
    // rust: Value::Array(list) => list
    // rust: .iter()
    // rust: .filter_map(Value::as_str)
    // rust: .flat_map(|spec| entity_spec(tags, spec))
    // rust: .collect(),
    // rust: _ => return None,
}
    // rust: if targeting.is_empty() {
    // rust: return None;
}
    // rust: Some(MobVisibility {
    // rust: targeting,
    // rust: visibility,
    // rust: })
}
/// The item's `equippable.slot` and `mob_visibility`, when both are set.
/// `getVisibilityPercent` multiplies only when the stack is in that slot.
    // rust: fn worn_mob_visibility(
    // rust: components: &Value,
    // rust: tags: &HashMap<String, HashSet<String>>,
    // rust: ) -> Option<(String, MobVisibility)> {
    // rust: let slot = components
    // rust: .get("minecraft:equippable")?
    // rust: .get("slot")?
    // rust: .as_str()?
    // rust: .to_owned();
    // rust: Some((
    // rust: slot,
    // rust: parse_mob_visibility(components.get("minecraft:mob_visibility")?, tags)?,
    // rust: ))
}
/// Every item of the last item registry loaded with its `villager_food`
/// nutrition (0 without the component): what the mobs' villagers read, since
/// a mob does not hold the registry (`None` until one is loaded).
    // rust: static VILLAGER_FOOD: std::sync::RwLock<Option<HashMap<Arc<str>, i32>>> =
    // rust: std::sync::RwLock::new(None);
pub fn set_villager_food(items: *HashMap<*str) void {
}
    // rust: let food = items
    // rust: .values()
    // rust: .map(|i| (i.id.clone(), i.villager_food.unwrap_or(0)))
    // rust: .collect();
    // rust: *VILLAGER_FOOD
    // rust: .write()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner) = Some(food);
}
/// `item`'s `villager_food` nutrition (`DataComponents.VILLAGER_FOOD`): its
/// value in the loaded registry (0 for an item without the component), or
/// `None` while no registry is loaded or the loaded one lacks the item (a
/// test's content root without the vanilla items).
pub fn villager_food(item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let food = VILLAGER_FOOD
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: food.as_ref().and_then(|f| f.get(item).copied())
}

    // rust: impl Items {
pub fn resists_fire(self: *Self, stack: *ItemStack, source: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(data) = stack.data()
    // rust: && let Some((_, v)) = data
    // rust: .other
    // rust: .iter()
    // rust: .find(|(key, _)| key == "minecraft:damage_resistant")
    // rust: {
    // rust: return match v.get("types") {
    // rust: Some(horizon_world::nbt::Tag::String(tag)) => {
    // rust: tag.to_string().is_ok_and(|id|id=="#minecraft:is_fire" || id==source)
}
    // rust: Some(horizon_world::nbt::Tag::List(tags)) => tags.iter().any(
    // rust: |t| matches!(t,horizon_world::nbt::Tag::String(id) if id.to_string().is_ok_and(|id|id==source)),
    // rust: ),
    // rust: _ => false,
}
}
    // rust: self.get(&stack.item).is_some_and(|i| i.fire_resistant)
}

    /// `ItemStack.canBeHurtBy` for the cactus damage type: a `damage_resistant`
    /// component naming `minecraft:cactus`, or a damage type tag that holds it.
    /// (`#minecraft:is_fire`, as on netherite gear, does not.)
pub fn resists_cactus(self: *Self, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: const CACTUS_TAGS: [&str; 5] = [
    // rust: "#minecraft:bypasses_shield",
    // rust: "#minecraft:no_knockback",
    // rust: "#minecraft:panic_environmental_causes",
    // rust: "#minecraft:panic_causes",
    // rust: "#minecraft:sulfur_cube_with_block_immune_to",
    // rust: ];
    // rust: let Some((_, v)) = stack.data().and_then(|data| {
    // rust: data.other
    // rust: .iter()
    // rust: .find(|(key, _)| key == "minecraft:damage_resistant")
    // rust: }) else {
    // rust: return false;
}
    // rust: match v.get("types") {
    // rust: Some(horizon_world::nbt::Tag::String(id)) => id
    // rust: .to_string()
    // rust: .is_ok_and(|id| id == "minecraft:cactus" || CACTUS_TAGS.contains(&id.as_str())),
    // rust: Some(horizon_world::nbt::Tag::List(ids)) => ids.iter().any(|t| {
    // rust: matches!(t, horizon_world::nbt::Tag::String(id)
    // rust: if id.to_string().is_ok_and(|id| id == "minecraft:cactus"))
    // rust: }),
    // rust: _ => false,
}
}

    // rust: pub fn load(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: facts: &BlockFacts,
    // rust: overlay: &PackOverlay,
    // rust: ) -> Result<Self> {
    // rust: let mut block_for_item: HashMap<&str, BlockStateId> = HashMap::new();
    // rust: for (i, s) in facts.states.iter().enumerate() {
    // rust: let default = registry.default_state(&s.name);
    // rust: if default == Some(BlockStateId(i as u32)) && &*s.item != "minecraft:air" {
    // rust: block_for_item
    // rust: .entry(&s.item)
    // rust: .or_insert(BlockStateId(i as u32));
}
}
    // rust: Self::load_with(root, &block_for_item, overlay)
}
    /// Every item's default components and the tags, without the block <->
    /// item mapping (for headless tools that never place blocks).
pub fn catalog(root: *Path, overlay: *PackOverlay) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::load_with(root, &HashMap::new(), overlay)
}
    // rust: fn load_with(
    // rust: root: &Path,
    // rust: block_for_item: &HashMap<&str, BlockStateId>,
    // rust: overlay: &PackOverlay,
    // rust: ) -> Result<Self> {
    // rust: let raw = horizon_world::item_defaults::shared(root)?;
    // rust: let entity_tags = load_tags(root, "entity_type", overlay)?;
    // rust: let path = root.join(MOD_CRAFT_REMAINDERS);
    // rust: let mod_remainders: HashMap<String, String> = match fs::read(&path) {
    // rust: Ok(bytes) => {
    // rust: serde_json::from_slice(&bytes).map_err(|e| format!("{}: {e}", path.display()))?
}
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => HashMap::new(),
    // rust: Err(e) => return Err(format!("{}: {e}", path.display()).into()),
}
    // rust: let mut items = HashMap::new();
    // rust: let mut order = Vec::new();
    // rust: let mut mob_visibility = HashMap::new();
    // rust: for (name, c) in raw.iter() {
    // rust: let id: Arc<str> = Arc::from(name.as_str());
    // rust: let tool = c["minecraft:tool"]["rules"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|r| ToolRule {
    // rust: blocks: match &r["blocks"] {
    // rust: Value::String(s) => vec![s.clone()],
    // rust: Value::Array(a) => a
    // rust: .iter()
    // rust: .filter_map(|v| v.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: _ => vec![],
    // rust: },
    // rust: speed: r["speed"].as_f64().map(|v| v as f32),
    // rust: correct: r["correct_for_drops"].as_bool(),
    // rust: })
    // rust: .collect();
    // rust: let modifier = |kind: &str| -> f32 {
    // rust: c["minecraft:attribute_modifiers"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|m| {
    // rust: m["type"].as_str() == Some(kind)
    // rust: && m["operation"].as_str() == Some("add_value")
    // rust: })
    // rust: .filter_map(|m| m["amount"].as_f64())
    // rust: .sum::<f64>() as f32
}
    // rust: let food = c.get("minecraft:food").map(|f| {
    // rust: (
    // rust: f["nutrition"].as_u64().unwrap_or(0) as u32,
    // rust: f["saturation"].as_f64().unwrap_or(0.0) as f32,
    // rust: )
    // rust: });
    // rust: let can_always_eat = c
    // rust: .get("minecraft:food")
    // rust: .and_then(|f| f.get("can_always_eat"))
    // rust: .and_then(|v| v.as_bool())
    // rust: .unwrap_or(false);
    // rust: let mut consume_effects = Vec::new();
    // rust: if let Some(effects) = c
    // rust: .get("minecraft:consumable")
    // rust: .and_then(|cons| cons.get("on_consume_effects"))
    // rust: .and_then(|e| e.as_array())
    // rust: {
    // rust: for effect in effects {
    // rust: if let Some(parsed) = parse_consume_effect(effect) {
    // rust: consume_effects.push(parsed);
}
}
}
    // rust: items.insert(
    // rust: id.clone(),
    // rust: ItemInfo {
    // rust: fire_resistant: c["minecraft:damage_resistant"]["types"].as_str()
    // rust: == Some("#minecraft:is_fire"),
    // rust: id: id.clone(),
    // rust: max_stack: c["minecraft:max_stack_size"].as_u64().unwrap_or(64) as u32,
    // rust: max_damage: c["minecraft:max_damage"].as_u64().unwrap_or(0) as u32,
    // rust: block: block_for_item.get(name.as_str()).copied(),
    // rust: tool,
    // rust: tool_default_speed: c["minecraft:tool"]["default_mining_speed"]
    // rust: .as_f64()
    // rust: .unwrap_or(1.0) as f32,
    // rust: tool_damage_per_block: c
    // rust: .get("minecraft:tool")
    // rust: .map(|t| t["damage_per_block"].as_u64().unwrap_or(1) as u32),
    // rust: can_destroy_blocks_in_creative:
    // rust: c["minecraft:tool"]["can_destroy_blocks_in_creative"]
    // rust: .as_bool()
    // rust: .unwrap_or(true),
    // rust: food,
    // rust: can_always_eat,
                    // Consumable.CODEC's defaults.
    // rust: consumable: c.get("minecraft:consumable").map(|cons| {
    // rust: horizon_world::consumable::Consumable {
    // rust: seconds: cons["consume_seconds"].as_f64().map_or(1.6, |s| s as f32),
    // rust: animation: crate::use_animation::consumable_animation(cons),
    // rust: sound: cons["sound"]
    // rust: .as_str()
    // rust: .unwrap_or("minecraft:entity.generic.eat")
    // rust: .to_owned(),
    // rust: particles: cons["has_consume_particles"].as_bool().unwrap_or(true),
    // rust: effects: std::mem::take(&mut consume_effects),
}
    // rust: }),
    // rust: use_remainder: c["minecraft:use_remainder"]["id"]
    // rust: .as_str()
    // rust: .map(str::to_owned),
    // rust: use_cooldown: c
    // rust: .get("minecraft:use_cooldown")
    // rust: .and_then(crate::cooldowns::UseCooldown::from_json),
    // rust: model: c["minecraft:item_model"]
    // rust: .as_str()
    // rust: .unwrap_or(name)
    // rust: .to_owned(),
    // rust: glider: c["minecraft:glider"].is_object(),
    // rust: swappable: c["minecraft:equippable"]["swappable"]
    // rust: .as_bool()
    // rust: .unwrap_or(true),
    // rust: equip_dispensable: c["minecraft:equippable"]["dispensable"]
    // rust: .as_bool()
    // rust: .unwrap_or(true),
    // rust: equip_damage_on_hurt: c["minecraft:equippable"]["damage_on_hurt"]
    // rust: .as_bool()
    // rust: .unwrap_or(true),
    // rust: equip_allowed: match &c["minecraft:equippable"]["allowed_entities"] {
    // rust: Value::String(spec) => Some(entity_spec(&entity_tags, spec)),
    // rust: Value::Array(list) => Some(
    // rust: list.iter()
    // rust: .filter_map(Value::as_str)
    // rust: .flat_map(|spec| entity_spec(&entity_tags, spec))
    // rust: .collect(),
    // rust: ),
    // rust: _ => None,
    // rust: },
    // rust: equip_sound: c["minecraft:equippable"]["equip_sound"]
    // rust: .as_str()
    // rust: .map(str::to_owned),
    // rust: jukebox_song: c["minecraft:jukebox_playable"].as_str().map(str::to_owned),
    // rust: dye: c["minecraft:dye"].as_str().map(str::to_owned),
    // rust: cushion_color: c["minecraft:cushion/color"].as_str().map(str::to_owned),
    // rust: block_transformer: c["minecraft:block_transformer"].as_str().map(str::to_owned),
    // rust: bundle: c.get("minecraft:bundle_contents").is_some(),
    // rust: components: c
    // rust: .as_object()
    // rust: .map(|c| c.keys().cloned().collect())
    // rust: .unwrap_or_default(),
    // rust: custom_components: c
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|(name, _)| !name.starts_with("minecraft:"))
    // rust: .map(|(name, value)| {
    // rust: (
    // rust: name.clone(),
    // rust: horizon_client_core::scoreboard::json_to_tag(value),
    // rust: )
    // rust: })
    // rust: .collect(),
    // rust: crafting_remainder: CRAFT_REMAINDERS
    // rust: .iter()
    // rust: .find(|(item, _)| *item == name)
    // rust: .map(|(_, rest)| (*rest).to_owned())
    // rust: .or_else(|| mod_remainders.get(name).cloned()),
    // rust: villager_food: c["minecraft:villager_food"]["nutrition"]
    // rust: .as_i64()
    // rust: .map(|n| n as i32),
    // rust: use_speed: c["minecraft:use_effects"]["speed_multiplier"]
    // rust: .as_f64()
    // rust: .unwrap_or(0.2) as f32,
    // rust: can_sprint: c["minecraft:use_effects"]["can_sprint"]
    // rust: .as_bool()
    // rust: .unwrap_or(false),
    // rust: interact_vibrations: c["minecraft:use_effects"]["interact_vibrations"]
    // rust: .as_bool()
    // rust: .unwrap_or(true),
    // rust: blocks_attacks: BlocksAttacks::parse(&c["minecraft:blocks_attacks"]),
    // rust: disable_blocking_seconds: c["minecraft:weapon"]["disable_blocking_for_seconds"]
    // rust: .as_f64()
    // rust: .unwrap_or(0.0) as f32,
    // rust: weapon_damage: c["minecraft:weapon"].is_object().then(|| {
    // rust: c["minecraft:weapon"]["item_damage_per_attack"]
    // rust: .as_u64()
    // rust: .unwrap_or(1) as u32
    // rust: }),
    // rust: equip_asset: c["minecraft:equippable"]["asset_id"]
    // rust: .as_str()
    // rust: .map(str::to_owned),
    // rust: equip_slot: c["minecraft:equippable"]["slot"]
    // rust: .as_str()
    // rust: .map(str::to_owned),
    // rust: modifiers: c["minecraft:attribute_modifiers"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|m| {
    // rust: Some((
    // rust: m["type"].as_str()?.to_owned(),
    // rust: m["id"].as_str()?.to_owned(),
    // rust: m["amount"].as_f64()?,
    // rust: m["operation"].as_str().unwrap_or("add_value").to_owned(),
    // rust: m["slot"].as_str().unwrap_or("any").to_owned(),
    // rust: ))
    // rust: })
    // rust: .collect(),
    // rust: fuel: c
    // rust: .get("minecraft:cooking_fuel")
    // rust: .map(|f| (f["burn_time"].clone(), f["speed_multiplier"].clone())),
    // rust: brewing_fuel: c
    // rust: .get("minecraft:brewing_fuel")
    // rust: .map(|f| (f["uses"].clone(), f["speed_multiplier"].clone())),
    // rust: compostable: c.get("minecraft:compostable").map(|f| f["layers"].clone()),
    // rust: remainder: c["minecraft:use_remainder"]["id"]
    // rust: .as_str()
    // rust: .or(c["minecraft:crafting_remainder"]["id"].as_str())
    // rust: .or(c["minecraft:crafting_remainder"].as_str())
    // rust: .map(str::to_owned),
    // rust: attack_damage: modifier("minecraft:attack_damage"),
    // rust: attack_speed: modifier("minecraft:attack_speed"),
    // rust: },
    // rust: );
    // rust: if let Some(parsed) = worn_mob_visibility(c, &entity_tags) {
    // rust: mob_visibility.insert(id.clone(), parsed);
}
    // rust: order.push(id);
}
        // Every loot table, keyed by its id (blocks/stone, entities/sheep/white,
        // gameplay/chicken_lay, shearing/sheep/red...), of every namespace
        // (content mods' tables, docs/modpacks.md), with the packs' over the
        // game's own: one map with the loot data of the same root and packs.
    // rust: let loot = horizon_world::loot::shared_tables(root, overlay)?;
    // rust: let registry_order = registry_order(root, &order);
    // rust: set_villager_food(&items);
    // rust: Ok(Self {
    // rust: items,
    // rust: mob_visibility,
    // rust: order,
    // rust: registry_order,
    // rust: block_tags: load_tags(root, "block", overlay)?,
    // rust: item_tags: load_tags(root, "item", overlay)?,
    // rust: item_tag_order: load_tag_lists(root, "item", overlay)?,
    // rust: loot,
    // rust: songs: load_songs(root),
    // rust: instruments: load_instruments(root),
    // rust: enchantments: Arc::new(crate::enchant::Enchantments::load_with(root, overlay)),
    // rust: })
}
pub fn get(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.items.get(id)
}
    /// `ItemStack.get(DataComponents.MOB_VISIBILITY).visibility()` when the
    /// prototype's equippable slot is `slot` and `targeting` is in
    /// `targetingEntityTypes`. None otherwise (`getVisibilityPercent` skips it).
pub fn worn_visibility(self: *Self, item: []const u8, slot: []const u8, targeting: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (equip, vis) = self.mob_visibility.get(item)?;
    // rust: if equip == slot && vis.targeting.contains(targeting) {
    // rust: Some(vis.visibility)
    // rust: } else {
    // rust: None
}
}
    /// Record one prototype's `equippable` and `mob_visibility` the way `load`
    /// reads them from the default-component report.
pub fn insert_mob_visibility_component(self: *Self, id: []const u8, components: *Value) void {
}
    // rust: if let Some(parsed) = worn_mob_visibility(components, &HashMap::new()) {
    // rust: self.mob_visibility.insert(Arc::from(id), parsed);
}
}
    /// The instrument a goat horn plays: its `instrument` component's
    /// registry entry or inline instrument.
pub fn instrument(self: *Self, stack: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(tag) = inline_instrument(stack) {
    // rust: return Some(parse_instrument(
    // rust: &horizon_client_core::scoreboard::tag_to_json(tag),
    // rust: ));
}
    // rust: self.instruments.get(&instrument_id(stack)?).cloned()
}
    /// Only the block and item tags (and the enchantment registry, which the
    /// station rules and loot functions are built from), for tools that need
    /// tag membership.
pub fn tags_only(root: *Path, overlay: *PackOverlay) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Self {
    // rust: items: HashMap::new(),
    // rust: mob_visibility: HashMap::new(),
    // rust: order: Vec::new(),
    // rust: registry_order: Vec::new(),
    // rust: block_tags: load_tags(root, "block", overlay)?,
    // rust: item_tags: load_tags(root, "item", overlay)?,
    // rust: item_tag_order: load_tag_lists(root, "item", overlay)?,
    // rust: loot: Default::default(),
    // rust: songs: HashMap::new(),
    // rust: instruments: HashMap::new(),
    // rust: enchantments: Arc::new(crate::enchant::Enchantments::load_with(root, overlay)),
    // rust: })
}
    /// An item table with only tags, for unit tests of item rules.
pub fn for_tests(item_tags: HashMap<[]const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: items: HashMap::new(),
    // rust: mob_visibility: HashMap::new(),
    // rust: order: Vec::new(),
    // rust: registry_order: Vec::new(),
    // rust: block_tags: HashMap::new(),
    // rust: item_tag_order: item_tags
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), v.iter().cloned().collect()))
    // rust: .collect(),
    // rust: item_tags,
    // rust: loot: Default::default(),
    // rust: songs: HashMap::new(),
    // rust: instruments: HashMap::new(),
    // rust: enchantments: Arc::new(crate::enchant::Enchantments::default()),
}
}
    /// Whether `block` is in the block tag `tag` (`minecraft:fire`, no `#`).
pub fn block_in_tag(self: *Self, tag: []const u8, block: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.block_tags.get(tag).is_some_and(|s| s.contains(block))
}
    /// Whether an item belongs to a loaded item tag.
pub fn item_in_tag(self: *Self, tag: []const u8, item: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.item_tags.get(tag).is_some_and(|s| s.contains(item))
}
pub fn block_matches(self: *Self, spec: []const u8, block: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match spec.strip_prefix('#') {
    // rust: Some(tag) => self.block_in_tag(tag, block),
    // rust: None => spec == block,
}
}
    /// `Item.canDestroyBlock`: a tool may forbid block destruction with instabuild.
pub fn can_destroy_block(self: *Self, held: ?*ItemStack, creative: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !creative {
    // rust: return true;
}
    // rust: let Some(held) = held.filter(|s| s.count > 0 && &*s.item != "minecraft:air") else {
    // rust: return true;
}
    // rust: if let Some(tool) = held.data().and_then(|d| d.other("minecraft:tool")) {
    // rust: return tool
    // rust: .get("can_destroy_blocks_in_creative")
    // rust: .and_then(|v| match v {
    // rust: horizon_world::nbt::Tag::Byte(v) => Some(*v),
    // rust: _ => None,
    // rust: })
    // rust: .is_none_or(|v| v != 0);
}
    // rust: self.get(&held.item)
    // rust: .is_none_or(|info| info.can_destroy_blocks_in_creative)
}
    /// `Tool.getMiningSpeed` for the held item (1.0 without a tool component).
pub fn mining_speed(self: *Self, held: ?*ItemStack, block: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(info) = held.and_then(|s| self.get(&s.item)) else {
    // rust: return 1.0;
}
    // rust: for rule in &info.tool {
    // rust: if let Some(speed) = rule.speed
    // rust: && rule.blocks.iter().any(|b| self.block_matches(b, block))
    // rust: {
    // rust: return speed;
}
}
    // rust: if info.tool.is_empty() {
    // rust: 1.0
    // rust: } else {
    // rust: info.tool_default_speed
}
}
    /// `Tool.isCorrectForDrops`.
pub fn correct_for_drops(self: *Self, held: ?*ItemStack, block: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(info) = held.and_then(|s| self.get(&s.item)) else {
    // rust: return false;
}
    // rust: for rule in &info.tool {
    // rust: if let Some(correct) = rule.correct
    // rust: && rule.blocks.iter().any(|b| self.block_matches(b, block))
    // rust: {
    // rust: return correct;
}
}
    // rust: false
}
    /// Whether a loot table (`minecraft:blocks/stone`, ...) exists.
pub fn has_loot_table(self: *Self, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.loot.contains_key(id)
}
    /// `LootTable.getRandomItems` of an inline table.
    // rust: pub fn inline_loot_table<R: RandomSource>(
    // rust: &self,
    // rust: table: &Value,
    // rust: random: &mut R,
    // rust: ) -> Vec<ItemStack> {
    // rust: self.inline_loot_table_with_tool(table, None, random)
}
    /// `LootCommand.dropFishingLoot`: evaluate an inline table with its TOOL.
    // rust: pub fn inline_loot_table_with_tool<R: RandomSource>(
    // rust: &self,
    // rust: table: &Value,
    // rust: held: Option<&ItemStack>,
    // rust: random: &mut R,
    // rust: ) -> Vec<ItemStack> {
    // rust: let empty = horizon_world::chunk::BlockProperties::new();
    // rust: let ctx = LootContext {
    // rust: items: self,
    // rust: block: "",
    // rust: properties: &empty,
    // rust: held,
    // rust: killed_by_player: false,
    // rust: explosion_radius: None,
    // rust: this_entity: false,
}
    // rust: ctx.evaluate(table, random)
}
    /// The server random sequence the block's loot table draws from.
    // rust: pub fn block_loot_sequence(
    // rust: &self,
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: ) -> Option<String> {
    // rust: self.loot_sequence(&self.block_loot_table(registry, state)?)
}
    /// The id of the block's loot table (`minecraft:blocks/stone`), when it
    /// has one. `Blocks.wallVariant`: wall signs, banners, heads, fans and
    /// torches use the standing block's table.
    // rust: pub fn block_loot_table(
    // rust: &self,
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: ) -> Option<String> {
    // rust: let block = registry.state(state)?;
    // rust: let (namespace, name) = block
    // rust: .name
    // rust: .split_once(':')
    // rust: .unwrap_or(("minecraft", &block.name));
    // rust: let own = format!("{namespace}:blocks/{name}");
    // rust: if self.loot.contains_key(&own) {
    // rust: return Some(own);
}
    // rust: let standing = name.replacen("_wall_", "_", 1);
    // rust: let standing = standing.strip_prefix("wall_").unwrap_or(&standing);
    // rust: let standing = standing.replacen("wall_", "", 1);
    // rust: let standing = format!("{namespace}:blocks/{standing}");
    // rust: self.loot.contains_key(&standing).then_some(standing)
}
    /// Evaluate the block's loot table for a player break without explosions.
    // rust: pub fn block_drops<R: RandomSource>(
    // rust: &self,
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: held: Option<&ItemStack>,
    // rust: random: &mut R,
    // rust: ) -> Vec<ItemStack> {
    // rust: self.block_drops_in(registry, state, held, random, None)
}
    /// `block_drops` drawing from the table's random sequence when it has one
    /// (`sequences`: the world's sequences and seed), as BlockState.getDrops.
    // rust: pub fn block_drops_in<R: RandomSource>(
    // rust: &self,
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: held: Option<&ItemStack>,
    // rust: random: &mut R,
    // rust: sequences: Option<(&mut crate::random_sequences::RandomSequences, i64)>,
    // rust: ) -> Vec<ItemStack> {
    // rust: self.block_drops_full(registry, state, held, &[], random, sequences)
}
    /// `block_drops` with the block entity's dynamic drops (`LootParams.withDynamicDrop`:
    /// a decorated pot's sherds) in place of the `minecraft:dynamic` entries.
    // rust: pub fn block_drops_with(
    // rust: &self,
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: held: Option<&ItemStack>,
    // rust: dynamic: &[ItemStack],
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Vec<ItemStack> {
    // rust: self.block_drops_full(registry, state, held, dynamic, random, None)
}
    /// `block_drops_in` with dynamic drops.
    // rust: pub fn block_drops_full(
    // rust: &self,
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: held: Option<&ItemStack>,
    // rust: dynamic: &[ItemStack],
    // rust: random: &mut impl RandomSource,
    // rust: sequences: Option<(&mut crate::random_sequences::RandomSequences, i64)>,
    // rust: ) -> Vec<ItemStack> {
    // rust: self.block_drops_exploded(
    // rust: registry, state, held, dynamic, random, sequences, None, false,
    // rust: )
}
    /// `block_drops_with` for a block a player breaks (`Block.playerDestroy`):
    /// the player is the loot context's `this` entity, so snow and chorus
    /// flower tables see an entity.
    // rust: pub fn block_drops_by_player(
    // rust: &self,
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: held: Option<&ItemStack>,
    // rust: dynamic: &[ItemStack],
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Vec<ItemStack> {
    // rust: self.block_drops_exploded(registry, state, held, dynamic, random, None, None, true)
}
    /// `block_drops_full` for a block an explosion destroys: `explosion`
    /// is its radius when the explosion decays drops (`DESTROY_WITH_DECAY`);
    /// `breaker` is whether an entity (the player) broke the block.
    // rust: pub fn block_drops_exploded(
    // rust: &self,
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: held: Option<&ItemStack>,
    // rust: dynamic: &[ItemStack],
    // rust: random: &mut impl RandomSource,
    // rust: sequences: Option<(&mut crate::random_sequences::RandomSequences, i64)>,
    // rust: explosion: Option<f32>,
    // rust: breaker: bool,
    // rust: ) -> Vec<ItemStack> {
    // rust: let drops =
    // rust: self.block_drops_raw(registry, state, held, random, sequences, explosion, breaker);
    // rust: if !drops.iter().any(|d| d.item.starts_with(DYNAMIC)) {
    // rust: return drops;
}
    // rust: drops
    // rust: .into_iter()
    // rust: .flat_map(|d| {
    // rust: if d.item.starts_with(DYNAMIC) {
    // rust: dynamic.to_vec()
    // rust: } else {
    // rust: vec![d]
}
    // rust: })
    // rust: .collect()
}
    // rust: fn block_drops_raw(
    // rust: &self,
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: held: Option<&ItemStack>,
    // rust: random: &mut impl RandomSource,
    // rust: sequences: Option<(&mut crate::random_sequences::RandomSequences, i64)>,
    // rust: explosion_radius: Option<f32>,
    // rust: breaker: bool,
    // rust: ) -> Vec<ItemStack> {
    // rust: let Some(block) = registry.state(state) else {
    // rust: return vec![];
}
    // rust: let table = self.block_loot_table(registry, state);
    // rust: let Some(table) = table.and_then(|id| self.loot.get(&id)) else {
    // rust: return vec![];
}
        // LootTable.getRandomItems draws from the table's random sequence.
    // rust: if let (Some(seq), Some(sequences)) = (
    // rust: table.get("random_sequence").and_then(Value::as_str),
    // rust: sequences,
    // rust: ) {
    // rust: let random = sequences.0.get(seq, sequences.1);
    // rust: let ctx = LootContext {
    // rust: items: self,
    // rust: block: &block.name,
    // rust: properties: &block.properties,
    // rust: held,
    // rust: killed_by_player: false,
    // rust: explosion_radius,
    // rust: this_entity: breaker,
}
    // rust: return ctx.evaluate(table, random);
}
    // rust: let ctx = LootContext {
    // rust: items: self,
    // rust: block: &block.name,
    // rust: properties: &block.properties,
    // rust: held,
    // rust: killed_by_player: false,
    // rust: explosion_radius,
    // rust: this_entity: breaker,
}
    // rust: ctx.evaluate(table, random)
}
    /// Evaluate an entity's loot table (`minecraft:entities/<name>`).
    /// Evaluate any loot table by id (e.g. `minecraft:gameplay/chicken_lay`).
    // rust: pub fn loot_table<R: RandomSource>(
    // rust: &self,
    // rust: id: &str,
    // rust: killed_by_player: bool,
    // rust: held: Option<&ItemStack>,
    // rust: random: &mut R,
    // rust: ) -> Vec<ItemStack> {
    // rust: let Some(table) = self.loot.get(id) else {
    // rust: return vec![];
}
    // rust: let empty = horizon_world::chunk::BlockProperties::new();
    // rust: let ctx = LootContext {
    // rust: items: self,
    // rust: block: "",
    // rust: properties: &empty,
    // rust: held,
    // rust: killed_by_player,
    // rust: explosion_radius: None,
    // rust: this_entity: false,
}
        // LootTable.getRandomItemsRaw visits the table itself first.
    // rust: NESTED_ROLLS.with(|v| v.borrow_mut().push(id.to_owned()));
    // rust: let out = ctx.evaluate(table, random);
    // rust: NESTED_ROLLS.with(|v| v.borrow_mut().pop());
    // rust: out
}
    /// The server random sequence a loot table draws from (`random_sequence`):
    /// vanilla's `LootContext.Builder.create` uses it instead of the level random.
pub fn loot_sequence(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.loot.get(id)?["random_sequence"]
    // rust: .as_str()
    // rust: .map(str::to_owned)
}
    /// `Block.dropFromBlockInteractLootTable`: the `block_interact` table `id`
    /// for a right click on `state` (its `match_block` conditions see the
    /// state), from the table's random sequence when it has one.
    // rust: pub fn interact_loot(
    // rust: &self,
    // rust: id: &str,
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: random: &mut impl RandomSource,
    // rust: sequences: &mut crate::random_sequences::RandomSequences,
    // rust: seed: i64,
    // rust: ) -> Vec<ItemStack> {
    // rust: let (Some(table), Some(block)) = (self.loot.get(id), registry.state(state)) else {
    // rust: return vec![];
}
    // rust: let ctx = LootContext {
    // rust: items: self,
    // rust: block: &block.name,
    // rust: properties: &block.properties,
    // rust: held: None,
    // rust: killed_by_player: false,
    // rust: explosion_radius: None,
    // rust: this_entity: false,
}
    // rust: match table.get("random_sequence").and_then(Value::as_str) {
    // rust: Some(sequence) => ctx.evaluate(table, sequences.get(sequence, seed)),
    // rust: None => ctx.evaluate(table, random),
}
}
    /// `loot_table` drawing from any random (a random sequence).
    // rust: pub fn loot_table_from(
    // rust: &self,
    // rust: id: &str,
    // rust: killed_by_player: bool,
    // rust: held: Option<&ItemStack>,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Vec<ItemStack> {
    // rust: let Some(table) = self.loot.get(id) else {
    // rust: return vec![];
}
    // rust: let empty = horizon_world::chunk::BlockProperties::new();
    // rust: let ctx = LootContext {
    // rust: items: self,
    // rust: block: "",
    // rust: properties: &empty,
    // rust: held,
    // rust: killed_by_player,
    // rust: explosion_radius: None,
    // rust: this_entity: false,
}
    // rust: ctx.evaluate(table, random)
}
    // rust: pub fn entity_drops<R: RandomSource>(
    // rust: &self,
    // rust: entity: &str,
    // rust: killed_by_player: bool,
    // rust: held: Option<&ItemStack>,
    // rust: random: &mut R,
    // rust: ) -> Vec<ItemStack> {
    // rust: let name = entity.trim_start_matches("minecraft:");
    // rust: let Some(table) = self.loot.get(&format!("minecraft:entities/{name}")) else {
    // rust: return vec![];
}
    // rust: let empty = horizon_world::chunk::BlockProperties::new();
    // rust: let ctx = LootContext {
    // rust: items: self,
    // rust: block: "",
    // rust: properties: &empty,
    // rust: held,
    // rust: killed_by_player,
    // rust: explosion_radius: None,
    // rust: this_entity: false,
}
    // rust: ctx.evaluate(table, random)
}
}
/// `DataComponents.BLOCK_STATE`.
pub const BLOCK_STATE: []const u8 = "minecraft:block_state";
    // rust: impl LootContext<'_> {
    // rust: fn evaluate<R: RandomSource>(&self, table: &Value, random: &mut R) -> Vec<ItemStack> {
    // rust: let ctx = self;
    // rust: let mut out = Vec::new();
    // rust: for pool in table["pools"].as_array().into_iter().flatten() {
    // rust: if !ctx.conditions(pool, random) {
    // rust: continue;
}
            // LootPool: rolls.getInt (Mth.randomBetweenInclusive for uniform rolls).
    // rust: let rolls = LootContext::int_number(&pool["rolls"], random).max(0) as u32;
    // rust: for _ in 0..rolls {
    // rust: let mut produced = Vec::new();
    // rust: ctx.choose(
    // rust: pool["entries"].as_array().map_or(&[][..], Vec::as_slice),
    // rust: random,
    // rust: &mut produced,
    // rust: );
    // rust: for mut stack in produced {
    // rust: ctx.modifiers(&pool["modifier"], &mut stack, random);
    // rust: ctx.modifiers(&table["modifier"], &mut stack, random);
    // rust: if stack.count > 0 {
    // rust: out.push(stack);
}
}
}
}
    // rust: out
}
}
pub const LootContext = struct {
    items: *'a Items,
    block: *'a str,
    properties: *'a horizon_world::chunk::BlockProperties,
    held: ?*'a ItemStack,
    killed_by_player: bool,
    /// `LootContextParams.EXPLOSION_RADIUS`: an explosion that decays drops.
    explosion_radius: ?f32,
    /// `LootContextParams.THIS_ENTITY` is set (a player broke the block).
    this_entity: bool,
};
    // rust: impl LootContext<'_> {
    /// Level of an enchantment on the tool / killer's weapon.
pub fn enchantment_level(self: *Self, id: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.held.map_or(0, |h| h.enchantment_level(id))
}
    /// The context a mod's own loot kind sees in this engine: the block and
    /// the tool it has, and a seed from the roll's random. The entity, the
    /// damage, the player and the biome belong to the main loot engine's
    /// rolls; they are None here (docs/native-mods.md, API 133).
    // rust: fn native_loot_context<R: RandomSource>(
    // rust: &self,
    // rust: random: &mut R,
    // rust: ) -> horizon_world::loot::NativeLootContext<'_> {
    // rust: horizon_world::loot::NativeLootContext {
    // rust: entity: None,
    // rust: damage: None,
    // rust: player: None,
    // rust: block: (!self.block.is_empty()).then_some(self.block),
    // rust: tool: self.held.map(|h| horizon_world::loot::NativeLootTool {
    // rust: item: h.item.to_string(),
    // rust: enchantments: h
    // rust: .enchantments()
    // rust: .iter()
    // rust: .map(|(id, lvl)| (id.to_string(), *lvl as i32))
    // rust: .collect(),
    // rust: }),
    // rust: luck: 0.0,
    // rust: biome: None,
    // rust: seed: random.next_long(),
    // rust: place: horizon_world::loot::current_native_loot_place(),
}
}
    // rust: fn number<R: RandomSource>(v: &Value, random: &mut R) -> f32 {
    // rust: match v {
    // rust: Value::Number(n) => n.as_f64().unwrap_or(0.0) as f32,
    // rust: Value::Object(o) => match o
    // rust: .get("type")
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or("minecraft:uniform")
    // rust: {
    // rust: "minecraft:constant" => {
    // rust: o.get("value").and_then(Value::as_f64).unwrap_or(0.0) as f32
}
    // rust: "minecraft:uniform" => {
    // rust: let min = Self::number(o.get("min").unwrap_or(&Value::Null), random);
    // rust: let max = Self::number(o.get("max").unwrap_or(&Value::Null), random);
                    // UniformGenerator.getFloat / getInt (Mth.nextInt) differ; use int for counts.
    // rust: if max <= min {
    // rust: min
    // rust: } else {
    // rust: min + random.next_float() * (max - min)
}
}
    // rust: "minecraft:binomial" => {
    // rust: let n = Self::number(o.get("n").unwrap_or(&Value::Null), random) as u32;
    // rust: let p = Self::number(o.get("p").unwrap_or(&Value::Null), random);
    // rust: (0..n).filter(|_| random.next_float() < p).count() as f32
}
                // An unknown type gives 0, as in loot.rs `int` and `float`.
    // rust: _ => 0.0,
    // rust: },
    // rust: _ => 0.0,
}
}
    // rust: fn int_number<R: RandomSource>(v: &Value, random: &mut R) -> i32 {
    // rust: if let Value::Object(o) = v
    // rust: && o.get("type")
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or("minecraft:uniform")
    // rust: == "minecraft:uniform"
    // rust: {
    // rust: let min = Self::int_number(o.get("min").unwrap_or(&Value::Null), random);
    // rust: let max = Self::int_number(o.get("max").unwrap_or(&Value::Null), random);
    // rust: return if max <= min {
    // rust: min
    // rust: } else {
    // rust: min + random.next_int_bound(max - min + 1).unwrap_or(0)
}
}
    // rust: Self::number(v, random).round() as i32
}
    // rust: fn condition<R: RandomSource>(&self, c: &Value, random: &mut R) -> bool {
    // rust: let (kind, c) = match c {
    // rust: Value::Null => return true,
    // rust: Value::Array(list) => return list.iter().all(|c| self.condition(c, random)),
    // rust: Value::String(s) => (s.as_str(), &Value::Null),
    // rust: Value::Object(o) => (o.get("type").and_then(Value::as_str).unwrap_or(""), c),
    // rust: _ => return false,
}
    // rust: match kind {
            // ExplosionCondition: 1 / radius under a decaying explosion.
    // rust: "minecraft:survives_explosion" => self
    // rust: .explosion_radius
    // rust: .is_none_or(|r| random.next_float() <= 1.0 / r),
    // rust: "minecraft:tool/can_silk_touch" => self.enchantment_level("minecraft:silk_touch") > 0,
    // rust: "minecraft:tool/can_shear" => self.held.is_some_and(|h| &*h.item == "minecraft:shears"),
    // rust: "minecraft:inverted" => !self.condition(&c["term"], random),
    // rust: "minecraft:any_of" => c["terms"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .any(|t| self.condition(t, random)),
    // rust: "minecraft:all_of" => c["terms"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|t| self.condition(t, random)),
    // rust: "minecraft:random_chance" => random.next_float() < Self::number(&c["chance"], random),
    // rust: "minecraft:table_bonus" => {
                // BonusLevelTableCondition: chances[min(level, len - 1)].
    // rust: let level =
    // rust: self.enchantment_level(c["enchantment"].as_str().unwrap_or("")) as usize;
    // rust: let chances = c["chances"].as_array().map_or(&[][..], Vec::as_slice);
    // rust: let chance = chances
    // rust: .get(level.min(chances.len().saturating_sub(1)))
    // rust: .and_then(Value::as_f64)
    // rust: .unwrap_or(0.0) as f32;
    // rust: random.next_float() < chance
}
    // rust: "minecraft:match_block" | "minecraft:block_state_property" => {
    // rust: let blocks_ok = match &c["blocks"].as_str().or(c["block"].as_str()) {
    // rust: Some(spec) => self.items.block_matches(spec, self.block),
    // rust: None => true,
}
    // rust: blocks_ok
    // rust: && c["state"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .chain(c["properties"].as_object().into_iter().flatten())
    // rust: .all(|(k, v)| {
    // rust: let have = self.properties.get(k).map(String::as_str);
    // rust: match v {
    // rust: Value::String(s) => have == Some(s.as_str()),
    // rust: Value::Object(r) => {
    // rust: let have: i64 = have.and_then(|h| h.parse().ok()).unwrap_or(0);
    // rust: r.get("min")
    // rust: .and_then(Value::as_i64)
    // rust: .is_none_or(|m| have >= m)
    // rust: && r.get("max")
    // rust: .and_then(Value::as_i64)
    // rust: .is_none_or(|m| have <= m)
}
    // rust: _ => true,
}
    // rust: })
}
    // rust: "minecraft:match_tool" => {
    // rust: let items = &c["predicate"]["items"];
    // rust: let items_ok = match (self.held, items) {
    // rust: (_, Value::Null) => self.held.is_some(),
    // rust: (Some(h), Value::String(s)) => match s.strip_prefix('#') {
    // rust: Some(tag) => self
    // rust: .items
    // rust: .item_tags
    // rust: .get(tag)
    // rust: .is_some_and(|t| t.contains(&*h.item)),
    // rust: None => **s == *h.item,
    // rust: },
    // rust: _ => false,
}
                // ItemPredicate "minecraft:enchantments": each entry needs a level in range.
    // rust: let enchants_ok = c["predicate"]["predicates"]["minecraft:enchantments"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|e| {
    // rust: let level =
    // rust: self.enchantment_level(e["enchantments"].as_str().unwrap_or(""));
    // rust: let min = e["levels"]["min"].as_u64().unwrap_or(1) as u32;
    // rust: let max = e["levels"]["max"].as_u64().map_or(u32::MAX, |m| m as u32);
    // rust: level >= min.max(1) && level <= max
    // rust: });
    // rust: items_ok && enchants_ok
}
    // rust: "minecraft:killed_by_player" => self.killed_by_player,
    // rust: "minecraft:random_chance_with_enchanted_bonus" => {
    // rust: let level = if self.killed_by_player && self.block.is_empty() {
    // rust: self.enchantment_level(c["enchantment"].as_str().unwrap_or(""))
    // rust: } else {
    // rust: 0
}
    // rust: let chance = if level > 0 {
    // rust: crate::enchant::level_value(&c["enchanted_chance"], level)
    // rust: } else {
    // rust: c["unenchanted_chance"].as_f64().unwrap_or(0.0) as f32
}
    // rust: random.next_float() < chance
}
            // `this` with no checks (snow, chorus flower) holds when an entity
            // broke the block (LootItemEntityPropertyCondition needs the entity).
    // rust: "minecraft:entity_properties"
    // rust: if self.this_entity
    // rust: && c["entity"].as_str() == Some("this")
    // rust: && c["predicate"].as_object().is_none_or(|p| p.is_empty()) =>
    // rust: {
    // rust: true
}
            // Entity flags, equipment and damage-source predicates: none hold
            // for an unenchanted player kill without fire or lightning.
    // rust: "minecraft:entity_properties" | "minecraft:damage_source_properties" => false,
            // LocationCheck reads the world at its offset, which this engine
            // does not have: held true (a double plant's other half is taken
            // as there). Unknown types fail, as in loot.rs.
    // rust: "minecraft:location_check" => true,
            // A mod's own kind: the condition hook answers.
    // rust: k if !c.is_null() && k.contains(':') && !k.starts_with("minecraft:") => {
    // rust: let ctx = self.native_loot_context(random);
    // rust: let mut holds = false;
    // rust: horizon_world::loot::native_loot_condition(k, c, &ctx, &mut holds);
    // rust: holds
}
    // rust: _ => false,
}
}
    // rust: fn conditions<R: RandomSource>(&self, o: &Value, random: &mut R) -> bool {
    // rust: if let Some(c) = o.get("condition")
    // rust: && !self.condition(c, random)
    // rust: {
    // rust: return false;
}
    // rust: o.get("conditions")
    // rust: .and_then(Value::as_array)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|c| self.condition(c, random))
}
    /// Expand entries; returns whether an entry succeeded (for alternatives).
    // rust: fn expand<R: RandomSource>(
    // rust: &self,
    // rust: e: &Value,
    // rust: random: &mut R,
    // rust: out: &mut Vec<(i32, ItemStack, Value)>,
    // rust: ) -> bool {
    // rust: if !self.conditions(e, random) {
    // rust: return false;
}
    // rust: match e["type"].as_str().unwrap_or("") {
    // rust: "minecraft:item" => {
    // rust: out.push((
    // rust: e["weight"].as_i64().unwrap_or(1) as i32,
    // rust: ItemStack {
    // rust: item: Arc::from(e["name"].as_str().unwrap_or("minecraft:air")),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: },
    // rust: e["modifier"].clone(),
    // rust: ));
    // rust: true
}
    // rust: "minecraft:alternatives" => {
    // rust: for child in e["children"].as_array().into_iter().flatten() {
    // rust: if self.expand(child, random, out) {
    // rust: return true;
}
}
    // rust: false
}
    // rust: "minecraft:group" => {
    // rust: for child in e["children"].as_array().into_iter().flatten() {
    // rust: self.expand(child, random, out);
}
    // rust: true
}
    // rust: "minecraft:sequence" => {
    // rust: for child in e["children"].as_array().into_iter().flatten() {
    // rust: if !self.expand(child, random, out) {
    // rust: break;
}
}
    // rust: true
}
            // DynamicLoot: what the block entity adds (a cracked decorated
            // pot's sherds), filled in by `block_drops_with`.
    // rust: "minecraft:dynamic" => {
    // rust: out.push((
    // rust: e["weight"].as_i64().unwrap_or(1) as i32,
    // rust: ItemStack {
    // rust: item: Arc::from(format!("{DYNAMIC}{}", e["name"].as_str().unwrap_or(""))),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: },
    // rust: Value::Null,
    // rust: ));
    // rust: true
}
            // NestedLootTable: chosen by its weight like an item; `choose`
            // then rolls its table (an id or inline) and applies its functions.
    // rust: "minecraft:loot_table" => {
    // rust: out.push((
    // rust: e["weight"].as_i64().unwrap_or(1) as i32,
    // rust: ItemStack {
    // rust: item: Arc::from(NESTED),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: },
    // rust: e.clone(),
    // rust: ));
    // rust: true
}
    // rust: "minecraft:empty" => {
    // rust: out.push((
    // rust: e["weight"].as_i64().unwrap_or(1) as i32,
    // rust: ItemStack {
    // rust: item: Arc::from("minecraft:air"),
    // rust: count: 0,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: },
    // rust: Value::Null,
    // rust: ));
    // rust: true
}
    // rust: _ => false,
}
}
    // rust: fn choose<R: RandomSource>(
    // rust: &self,
    // rust: entries: &[Value],
    // rust: random: &mut R,
    // rust: produced: &mut Vec<ItemStack>,
    // rust: ) {
    // rust: let mut candidates = Vec::new();
    // rust: for e in entries {
    // rust: self.expand(e, random, &mut candidates);
}
    // rust: if candidates.is_empty() {
    // rust: return;
}
    // rust: let pick = if candidates.len() == 1 {
    // rust: 0
    // rust: } else {
    // rust: let total: i32 = candidates.iter().map(|c| c.0.max(0)).sum();
    // rust: let mut r = random.next_int_bound(total.max(1)).unwrap_or(0);
    // rust: let mut chosen = 0;
    // rust: for (i, c) in candidates.iter().enumerate() {
    // rust: r -= c.0.max(0);
    // rust: if r < 0 {
    // rust: chosen = i;
    // rust: break;
}
}
    // rust: chosen
}
    // rust: let (_, mut stack, modifiers) = candidates.swap_remove(pick);
    // rust: if &*stack.item == NESTED {
    // rust: self.nested(&modifiers, random, produced);
    // rust: return;
}
    // rust: self.modifiers(&modifiers, &mut stack, random);
    // rust: produced.push(stack);
}
    /// `NestedLootTable.createItemStack`: the entry's table rolls in full
    /// (its pools and its own functions), then the entry's functions apply to
    /// each stack. A table already rolling further out adds nothing.
    // rust: fn nested<R: RandomSource>(
    // rust: &self,
    // rust: entry: &Value,
    // rust: random: &mut R,
    // rust: produced: &mut Vec<ItemStack>,
    // rust: ) {
    // rust: let (name, table) = match &entry["value"] {
    // rust: Value::String(name) => (name.as_str(), self.items.loot.get(name.as_str())),
    // rust: inline @ Value::Object(_) => ("<inline>", Some(inline)),
    // rust: _ => return,
}
    // rust: let Some(table) = table else { return };
    // rust: let entered = NESTED_ROLLS.with(|v| {
    // rust: let mut v = v.borrow_mut();
    // rust: let fresh = !v.iter().any(|n| n == name);
    // rust: if fresh {
    // rust: v.push(name.to_owned());
}
    // rust: fresh
    // rust: });
    // rust: if !entered {
    // rust: return;
}
    // rust: let stacks = self.evaluate(table, random);
    // rust: NESTED_ROLLS.with(|v| v.borrow_mut().pop());
    // rust: for mut stack in stacks {
    // rust: self.modifiers(&entry["modifier"], &mut stack, random);
    // rust: produced.push(stack);
}
}
    /// An enchantment function's `options` (`HolderSet`): a tag, a list or
    /// one id; every enchantment when absent (`registryAccess().listElements`).
pub fn enchant_pool(e: *crate::enchant::Enchantments, options: *Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match options {
    // rust: Value::String(s) if s.starts_with('#') => e.tag(s).to_vec(),
    // rust: Value::String(s) => vec![Arc::from(s.as_str())],
    // rust: Value::Array(a) => a.iter().filter_map(|x| x.as_str().map(Arc::from)).collect(),
    // rust: _ => e.list.iter().map(|x| Arc::clone(&x.id)).collect(),
}
}
    // rust: fn modifiers<R: RandomSource>(&self, m: &Value, stack: &mut ItemStack, random: &mut R) {
    // rust: let list: Vec<&Value> = match m {
    // rust: Value::Array(a) => a.iter().collect(),
    // rust: Value::Object(_) => vec![m],
    // rust: _ => return,
}
    // rust: for f in list {
    // rust: if !self.conditions(f, random) {
    // rust: continue;
}
    // rust: match f["type"].as_str().or(f["function"].as_str()).unwrap_or("") {
    // rust: "minecraft:set_count" => {
    // rust: let n = Self::int_number(&f["count"], random);
    // rust: let base = if f["add"].as_bool() == Some(true) {
    // rust: stack.count as i32
    // rust: } else {
    // rust: 0
}
    // rust: stack.count = (base + n).max(0) as u32;
}
                // SetItemDamageFunction.run: check damageability before the
                // float provider, so ineligible stacks do not draw randomness.
    // rust: "minecraft:set_damage" => {
    // rust: let component = |id| stack.data().and_then(|data| data.other(id));
    // rust: if stack.count == 0
    // rust: || component("minecraft:unbreakable").is_some()
    // rust: || component("!minecraft:max_damage").is_some()
    // rust: || component("!minecraft:damage").is_some()
    // rust: {
    // rust: continue;
}
    // rust: let max = match component("minecraft:max_damage") {
    // rust: Some(horizon_world::nbt::Tag::Int(value)) => {
    // rust: u32::try_from(*value).unwrap_or(0)
}
    // rust: _ => self
    // rust: .items
    // rust: .get(&stack.item)
    // rust: .map_or(0, |info| info.max_damage),
}
    // rust: if max == 0 {
    // rust: continue;
}
    // rust: let base = if f["add"].as_bool() == Some(true) {
    // rust: 1.0 - stack.damage as f32 / max as f32
    // rust: } else {
    // rust: 0.0
}
    // rust: let remaining = (Self::number(&f["damage"], random) + base).clamp(0.0, 1.0);
    // rust: stack.damage = ((1.0 - remaining) * max as f32).floor() as u32;
}
    // rust: "minecraft:apply_bonus" => {
    // rust: let level =
    // rust: self.enchantment_level(f["enchantment"].as_str().unwrap_or("")) as i32;
    // rust: let count = stack.count as i32;
    // rust: let params = &f["parameters"];
    // rust: stack.count = match f["formula"].as_str().unwrap_or("") {
    // rust: "minecraft:ore_drops" if level > 0 => {
    // rust: let bonus = (random.next_int_bound(level + 2).unwrap_or(0) - 1).max(0);
    // rust: count * (bonus + 1)
}
    // rust: "minecraft:uniform_bonus_count" => {
    // rust: let multiplier = params["bonusMultiplier"].as_i64().unwrap_or(1) as i32;
    // rust: count + random.next_int_bound(multiplier * level + 1).unwrap_or(0)
}
    // rust: "minecraft:binomial_with_bonus_count" => {
    // rust: let (extra, p) = (
    // rust: params["extra"].as_i64().unwrap_or(0) as i32,
    // rust: params["probability"].as_f64().unwrap_or(0.0) as f32,
    // rust: );
    // rust: let mut n = count;
    // rust: for _ in 0..level + extra {
    // rust: if random.next_float() < p {
    // rust: n += 1;
}
}
    // rust: n
}
    // rust: _ => count,
}
    // rust: .max(0) as u32;
}
    // rust: "minecraft:enchanted_count_increase" => {
                    // Attacker's level x count, rounded (looting).
    // rust: let level = self.enchantment_level(f["enchantment"].as_str().unwrap_or(""));
    // rust: if level > 0 && self.killed_by_player && self.block.is_empty() {
    // rust: let add = level as f32 * Self::number(&f["count"], random);
    // rust: stack.count = (stack.count as i32 + add.round() as i32).max(0) as u32;
    // rust: if let Some(limit) = f["limit"].as_i64().filter(|l| *l > 0) {
    // rust: stack.count = stack.count.min(limit as u32);
}
}
}
                // CopyBlockState: the listed properties of the broken block
                // become the item's `block_state` component.
    // rust: "minecraft:copy_state" => {
//                     use horizon_world::nbt::Tag;
    // rust: let mut copied = match stack.data().and_then(|d| d.other(BLOCK_STATE)) {
    // rust: Some(Tag::Compound(c)) => c.clone(),
    // rust: _ => Default::default(),
}
    // rust: for name in f["properties"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(Value::as_str)
    // rust: {
    // rust: if let Some(value) = self.properties.get(name) {
    // rust: copied.insert(name.into(), Tag::String(value.as_str().into()));
}
}
    // rust: if !copied.is_empty() {
    // rust: stack
    // rust: .data_mut()
    // rust: .set_other(BLOCK_STATE, Some(Tag::Compound(copied)));
}
}
                // ApplyExplosionDecay: each item survives with 1 / radius.
    // rust: "minecraft:explosion_decay" => {
    // rust: if let Some(radius) = self.explosion_radius {
    // rust: let probability = 1.0 / radius;
    // rust: stack.count = (0..stack.count)
    // rust: .filter(|_| random.next_float() <= probability)
    // rust: .count() as u32;
}
}
                // SetPotionFunction (the barter's fire resistance potions).
    // rust: "minecraft:set_potion" => {
    // rust: if let Some(id) = f["id"].as_str() {
    // rust: *stack = std::mem::replace(stack, ItemStack::new("minecraft:air", 0))
    // rust: .with_potion(id);
}
}
                // EnchantWithLevelsFunction: EnchantmentHelper.enchantItem on
                // the context's random (the End cities' gear).
    // rust: "minecraft:enchant_with_levels" => {
    // rust: let cost = Self::int_number(&f["levels"], random);
    // rust: let e = &self.items.enchantments;
    // rust: let pool = Self::enchant_pool(e, &f["options"]);
    // rust: let chosen = e.select(self.items, random, &stack.item, cost, &pool);
                    // EnchantmentHelper.enchantItem: a book becomes one
                    // enchanted book (the fresh stack's count).
    // rust: if &*stack.item == "minecraft:book" {
    // rust: *stack = ItemStack::new("minecraft:enchanted_book", 1);
}
    // rust: for (id, level) in chosen {
    // rust: stack.enchant(&id, level);
}
}
                // EnchantRandomlyFunction: one enchantment the item accepts,
                // at a level between its min and max.
    // rust: "minecraft:enchant_randomly" => {
    // rust: let e = &self.items.enchantments;
    // rust: let book = &*stack.item == "minecraft:book";
    // rust: let only_compatible = f["only_compatible"].as_bool().unwrap_or(true);
    // rust: let options: Vec<Arc<str>> = Self::enchant_pool(e, &f["options"])
    // rust: .into_iter()
    // rust: .filter(|id| {
    // rust: book || !only_compatible || e.can_enchant(self.items, id, &stack.item)
    // rust: })
    // rust: .collect();
    // rust: if options.is_empty() {
    // rust: continue;
}
    // rust: let id = options
    // rust: [random.next_int_bound(options.len() as i32).unwrap_or(0) as usize]
    // rust: .clone();
    // rust: let max = e.get(&id).map_or(1, |d| d.max_level).max(1);
                    // `Mth.nextInt(random, 1, max)`: a single-level
                    // enchantment (Mending) returns 1 without drawing, so the
                    // rolls after this one keep vanilla's sequence.
    // rust: let level = if max <= 1 {
    // rust: 1
    // rust: } else {
    // rust: 1 + random.next_int_bound(max as i32).unwrap_or(0) as u32
}
    // rust: if book {
    // rust: *stack = ItemStack::new("minecraft:enchanted_book", 1);
}
    // rust: stack.enchant(&id, level);
}
    // rust: "minecraft:limit_count" => {
    // rust: let limit = &f["limit"];
    // rust: if let Some(min) = limit["min"].as_i64() {
    // rust: stack.count = stack.count.max(min as u32);
}
    // rust: if let Some(max) = limit["max"].as_i64() {
    // rust: stack.count = stack.count.min(max as u32);
}
}
                // A mod's own kind: the function hook changes the stack, as it
                // does in the main loot engine.
    // rust: k if k.contains(':') && !k.starts_with("minecraft:") => {
    // rust: let ctx = self.native_loot_context(random);
    // rust: mod_function(k, f, &ctx, stack, horizon_world::loot::native_loot_function);
}
    // rust: _ => {}
}
}
}
}

/// The items engine's stack as the loot engine's (`LootStack`), for a mod's
/// function hook: the parts of it the hook can change and the engine takes
/// back. The components the engine keeps as saved travel as their JSON, as
/// `set_components` writes them.
pub fn loot_of(stack: *ItemStack) h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut components: Vec<(String, Value)> = Vec::new();
    // rust: if let Some(data) = stack.data() {
    // rust: for (id, value) in &data.other {
    // rust: components.push((
    // rust: id.clone(),
    // rust: horizon_client_core::scoreboard::tag_to_json(value),
    // rust: ));
}
    // rust: if let Some(name) = &data.custom_name {
    // rust: components.push((
    // rust: "minecraft:custom_name".to_owned(),
    // rust: horizon_client_core::scoreboard::tag_to_json(name),
    // rust: ));
}
    // rust: if let Some((material, pattern)) = &data.trim {
    // rust: components.push((
    // rust: "minecraft:trim".to_owned(),
    // rust: serde_json::json!({"material": &**material, "pattern": &**pattern}),
    // rust: ));
}
}
    // rust: horizon_world::loot::LootStack {
    // rust: item: stack.item.to_string(),
    // rust: count: stack.count as i32,
    // rust: damage: stack.damage as i32,
    // rust: enchantments: stack
    // rust: .crafting_enchantments()
    // rust: .iter()
    // rust: .map(|(id, level)| (id.to_string(), *level as i32))
    // rust: .collect(),
    // rust: potion: stack.potion().map(str::to_owned),
    // rust: map: false,
    // rust: exploration: None,
    // rust: ominous_amplifier: stack
    // rust: .data()
    // rust: .and_then(|d| d.ominous_amplifier)
    // rust: .map(i32::from),
    // rust: stew_effects: stack
    // rust: .data()
    // rust: .map(|d| {
    // rust: d.stew_effects
    // rust: .iter()
    // rust: .map(|(effect, ticks)| (effect.to_string(), *ticks))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default(),
    // rust: names: Vec::new(),
    // rust: components,
}
}

/// What a mod's loot function left in its stack, applied to the engine's.
/// Only what changed is written, so a field the hook did not touch keeps the
/// engine's own form of it.
    // rust: fn apply_loot(
    // rust: before: &horizon_world::loot::LootStack,
    // rust: after: &horizon_world::loot::LootStack,
    // rust: stack: &mut ItemStack,
    // rust: ) {
    // rust: if after.item != before.item {
    // rust: stack.item = Arc::from(after.item.as_str());
}
    // rust: if after.count != before.count {
    // rust: stack.count = after.count.max(0) as u32;
}
    // rust: if after.damage != before.damage {
    // rust: stack.damage = after.damage.max(0) as u32;
}
    // rust: if after.enchantments != before.enchantments {
    // rust: let levels = after
    // rust: .enchantments
    // rust: .iter()
    // rust: .filter(|(_, level)| *level > 0)
    // rust: .map(|(id, level)| (Arc::from(id.as_str()), *level as u32))
    // rust: .collect();
    // rust: stack.set_crafting_enchantments(levels);
}
    // rust: if after.potion != before.potion {
    // rust: stack.data_mut().potion = after.potion.as_deref().map(Arc::from);
}
    // rust: if after.ominous_amplifier != before.ominous_amplifier {
    // rust: stack.data_mut().ominous_amplifier = after.ominous_amplifier.map(|a| a.clamp(0, 255) as u8);
}
    // rust: if after.stew_effects != before.stew_effects {
    // rust: stack.data_mut().stew_effects = after
    // rust: .stew_effects
    // rust: .iter()
    // rust: .map(|(effect, ticks)| (Arc::from(effect.as_str()), *ticks))
    // rust: .collect();
}
    // `SetNameFunction`'s components: the names the hook set.
    // rust: for (id, text) in &after.names {
    // rust: if !before.names.iter().any(|(i, t)| i == id && t == text) {
    // rust: stack.data_mut().set_loot_name(id, text);
}
}
    // `SetComponentsFunction`'s patch: the components the hook changed or
    // added are set, and the ones it dropped (gone from the stack) removed.
    // rust: for (id, value) in &after.components {
    // rust: if !before.components.iter().any(|(i, v)| i == id && v == value) {
    // rust: stack.data_mut().set_loot_component(id, value);
}
}
    // rust: for (id, _) in &before.components {
    // rust: if !after.components.iter().any(|(i, _)| i == id) {
    // rust: stack.data_mut().set_loot_component(id, &Value::Null);
}
}
    // rust: stack.tidy();
}

/// `native_loot_function` with the items engine's stack: the stack as the
/// loot engine's, the hook, and back what it changed. `hook` is the hook
/// point (`horizon_world::loot::native_loot_function`); a test passes its own.
    // rust: fn mod_function(
    // rust: kind: &str,
    // rust: data: &Value,
    // rust: ctx: &horizon_world::loot::NativeLootContext<'_>,
    // rust: stack: &mut ItemStack,
    // rust: hook: impl FnOnce(
    // rust: &str,
    // rust: &Value,
    // rust: &horizon_world::loot::NativeLootContext<'_>,
    // rust: &mut horizon_world::loot::LootStack,
    // rust: ),
    // rust: ) {
    // rust: let before = loot_of(stack);
    // rust: let mut after = before.clone();
    // rust: hook(kind, data, ctx, &mut after);
    // rust: apply_loot(&before, &after, stack);
}

/// `DispensibleContainerItem`: shared contents for hand use and dispensers.
    // rust: pub fn bucket_contents(
    // rust: item: &str,
    // rust: ) -> Option<(horizon_world::level::BucketContent, &str, Option<&str>)> {
//     use horizon_world::{fluid::FluidKind, level::BucketContent as C};
    // rust: Some(match item {
    // rust: "minecraft:water_bucket" => (
    // rust: C::Fluid(FluidKind::Water),
    // rust: "minecraft:item.bucket.empty",
    // rust: None,
    // rust: ),
    // rust: "minecraft:lava_bucket" => (
    // rust: C::Fluid(FluidKind::Lava),
    // rust: "minecraft:item.bucket.empty_lava",
    // rust: None,
    // rust: ),
    // rust: "minecraft:powder_snow_bucket" => {
    // rust: (C::Powder, "minecraft:item.bucket.empty_powder_snow", None)
}
    // rust: "minecraft:cod_bucket" => (C::MobWater, "minecraft:item.bucket.empty_fish", Some("cod")),
    // rust: "minecraft:salmon_bucket" => (
    // rust: C::MobWater,
    // rust: "minecraft:item.bucket.empty_fish",
    // rust: Some("salmon"),
    // rust: ),
    // rust: "minecraft:pufferfish_bucket" => (
    // rust: C::MobWater,
    // rust: "minecraft:item.bucket.empty_fish",
    // rust: Some("pufferfish"),
    // rust: ),
    // rust: "minecraft:tropical_fish_bucket" => (
    // rust: C::MobWater,
    // rust: "minecraft:item.bucket.empty_fish",
    // rust: Some("tropical_fish"),
    // rust: ),
    // rust: "minecraft:axolotl_bucket" => (
    // rust: C::MobWater,
    // rust: "minecraft:item.bucket.empty_axolotl",
    // rust: Some("axolotl"),
    // rust: ),
    // rust: "minecraft:tadpole_bucket" => (
    // rust: C::MobWater,
    // rust: "minecraft:item.bucket.empty_tadpole",
    // rust: Some("tadpole"),
    // rust: ),
    // rust: "minecraft:sulfur_cube_bucket" => (
    // rust: C::Nothing,
    // rust: "minecraft:item.bucket.empty_sulfur_cube",
    // rust: Some("sulfur_cube"),
    // rust: ),
    // rust: _ => return None,
    // rust: })
}

/// One `MobEffectInstance` of an `apply_effects` consume effect (its codec's defaults).
pub fn consume_effect_spec(e: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let flag = |key: &str, default: bool| e.get(key).and_then(|v| v.as_bool()).unwrap_or(default);
    // rust: Some(ConsumeEffectSpec {
    // rust: id: e.get("id")?.as_str()?.to_string(),
    // rust: duration: e.get("duration").and_then(|d| d.as_i64()).unwrap_or(0) as i32,
    // rust: amplifier: e.get("amplifier").and_then(|a| a.as_i64()).unwrap_or(0) as i32,
    // rust: ambient: flag("ambient", false),
    // rust: show_particles: flag("show_particles", true),
    // rust: })
}

    // rust: mod bucket_use_tests {
//     use super::*;
pub fn every_filled_bucket_has_the_native_content_and_sound() void {
}
//         use horizon_world::level::BucketContent as C;
    // rust: assert_eq!(
    // rust: bucket_contents("minecraft:powder_snow_bucket"),
    // rust: Some((C::Powder, "minecraft:item.bucket.empty_powder_snow", None))
    // rust: );
    // rust: assert_eq!(
    // rust: bucket_contents("minecraft:tadpole_bucket"),
    // rust: Some((
    // rust: C::MobWater,
    // rust: "minecraft:item.bucket.empty_tadpole",
    // rust: Some("tadpole")
    // rust: ))
    // rust: );
    // rust: assert_eq!(
    // rust: bucket_contents("minecraft:sulfur_cube_bucket"),
    // rust: Some((
    // rust: C::Nothing,
    // rust: "minecraft:item.bucket.empty_sulfur_cube",
    // rust: Some("sulfur_cube")
    // rust: ))
    // rust: );
    // rust: for id in ["cod", "salmon", "pufferfish", "tropical_fish", "axolotl"] {
    // rust: assert!(bucket_contents(&format!("minecraft:{id}_bucket")).is_some());
}
    // rust: assert!(bucket_contents("minecraft:bucket").is_none());
    // rust: assert!(bucket_contents("minecraft:milk_bucket").is_none());
}
}

/// The items of the prepared resources, when they are on this machine, for
/// tests: the block registry and facts as the client's `Assets::load` reads them.
    // rust: pub(crate) fn prepared_items() -> Option<Items> {
    // rust: let root = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("items.json").exists() {
    // rust: return None;
}
    // rust: let (registry, _) =
    // rust: BlockRegistry::from_facts_json_with_flags(fs::File::open(root.join("facts.json")).ok()?)
    // rust: .ok()?;
    // rust: let facts = BlockFacts::load(&root, &registry).ok()?;
    // rust: Items::load(&root, &registry, &facts, &PackOverlay::NONE).ok()
}

    // rust: mod consume_effect_tests {
//     use super::*;

pub fn effects_keep_their_ambient_and_particle_flags() void {
}
    // rust: let quiet =
    // rust: serde_json::json!({"id": "minecraft:haste", "duration": 3600, "show_particles": false});
    // rust: let s = consume_effect_spec(&quiet).unwrap();
    // rust: assert_eq!(
    // rust: (s.id.as_str(), s.duration, s.amplifier),
    // rust: ("minecraft:haste", 3600, 0)
    // rust: );
    // rust: assert!(!s.ambient && !s.show_particles);
    // rust: let plain =
    // rust: consume_effect_spec(&serde_json::json!({"id": "minecraft:regeneration"})).unwrap();
    // rust: assert!(!plain.ambient && plain.show_particles);
}

pub fn a_mods_own_consume_effect_kind_is_kept() void {
}
    // rust: let v = |s: &str| serde_json::from_str::<serde_json::Value>(s).unwrap();
        // A mod's own kind: Native with its JSON.
    // rust: let native =
    // rust: parse_consume_effect(&v(r#"{"type":"mymod:energy_boost","amount":42}"#)).unwrap();
    // rust: assert!(matches!(&native, ConsumeEffect::Native { kind, data }
    // rust: if kind == "mymod:energy_boost" && data["amount"] == 42));
        // A bare vanilla name and its namespaced form are the same kind.
    // rust: let bare = parse_consume_effect(&v(
    // rust: r#"{"type":"apply_effects","effects":[{"id":"minecraft:speed","duration":100}]}"#,
    // rust: ))
    // rust: .unwrap();
    // rust: assert!(matches!(bare, ConsumeEffect::ApplyEffects { .. }));
    // rust: let named = parse_consume_effect(
    // rust: &v(r#"{"type":"minecraft:apply_effects","effects":[{"id":"minecraft:speed","duration":100}]}"#),
    // rust: ).unwrap();
    // rust: assert!(matches!(named, ConsumeEffect::ApplyEffects { .. }));
        // An empty namespace is minecraft's too (`Identifier.bySeparator`).
    // rust: let empty = parse_consume_effect(&v(r#"{"type":":clear_all_effects"}"#)).unwrap();
    // rust: assert!(matches!(empty, ConsumeEffect::ClearAllEffects));
        // An unknown minecraft: kind and a missing type are dropped.
    // rust: assert!(parse_consume_effect(&v(r#"{"type":"minecraft:future"}"#)).is_none());
    // rust: assert!(parse_consume_effect(&v(r#"{"amount":42}"#)).is_none());
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::LegacyRandom;
//     use serde_json::json;

    /// `LootCommand.dropFishingLoot` carries TOOL even for an inline holder.
pub fn inline_fishing_keeps_the_actual_tool_context() void {
}
    // rust: let mut items = Items::for_tests(HashMap::new());
    // rust: let table = |tool| {
    // rust: json!({"type":"minecraft:fishing","pools":[{"rolls":1,"entries":[{
    // rust: "type":"minecraft:item","name":"minecraft:diamond",
    // rust: "condition":{"type":"minecraft:match_tool","predicate":{"items":tool}}
    // rust: }]}]})
}
    // rust: let rod_table = table("minecraft:fishing_rod");
    // rust: let stick_table = table("minecraft:stick");
    // rust: let unconditioned = json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"minecraft:diamond"}]}]});
    // rust: items.loot = Arc::new(
    // rust: [
    // rust: ("test:rod".to_owned(), rod_table.clone()),
    // rust: ("test:stick".to_owned(), stick_table.clone()),
    // rust: ("test:plain".to_owned(), unconditioned.clone()),
    // rust: ]
    // rust: .into_iter()
    // rust: .collect(),
    // rust: );
    // rust: let rod = ItemStack::new("minecraft:fishing_rod", 1);
    // rust: let stick = ItemStack::new("minecraft:stick", 1);
    // rust: let summary = |drops: Vec<ItemStack>| {
    // rust: drops
    // rust: .into_iter()
    // rust: .map(|s| (s.item.to_string(), s.count))
    // rust: .collect::<Vec<_>>()
}
    // rust: for (id, table, matches) in [
    // rust: ("test:rod", &rod_table, [false, true, false]),
    // rust: ("test:stick", &stick_table, [false, false, true]),
    // rust: ("test:plain", &unconditioned, [true, true, true]),
    // rust: ] {
    // rust: for (held, matches) in [None, Some(&rod), Some(&stick)].into_iter().zip(matches) {
    // rust: let expected = if matches {
    // rust: vec![("minecraft:diamond".to_owned(), 1)]
    // rust: } else {
    // rust: vec![]
}
    // rust: let mut named_rng = LegacyRandom::new(41);
    // rust: assert_eq!(
    // rust: summary(items.loot_table(id, false, held, &mut named_rng)),
    // rust: expected
    // rust: );
    // rust: let mut inline_rng = LegacyRandom::new(41);
    // rust: assert_eq!(
    // rust: summary(items.inline_loot_table_with_tool(table, held, &mut inline_rng)),
    // rust: expected
    // rust: );
    // rust: assert_eq!(
    // rust: inline_rng.next_long(),
    // rust: named_rng.next_long(),
    // rust: "same evaluator draw order"
    // rust: );
}
    // rust: let mut random = LegacyRandom::new(41);
    // rust: let legacy = summary(items.inline_loot_table(table, &mut random));
    // rust: assert_eq!(
    // rust: legacy,
    // rust: if matches[0] {
    // rust: vec![("minecraft:diamond".to_owned(), 1)]
    // rust: } else {
    // rust: vec![]
}
    // rust: );
}
}

pub fn a_stacks_own_blocks_attacks_component_counts() void {
}
    // rust: let plain = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: assert!(BlocksAttacks::of_stack(&plain, None).is_none());
    // rust: let mut sword = plain.clone();
    // rust: let component = json!({
    // rust: "block_delay_seconds": 0.0,
    // rust: "disable_cooldown_scale": 0.0,
    // rust: "damage_reductions": [{"horizontal_blocking_angle": 180.0, "base": -0.5, "factor": 0.5}],
    // rust: "item_damage": {"threshold": 1.0e9, "base": 0.0, "factor": 0.0},
    // rust: "bypassed_by": "#minecraft:bypasses_armor",
    // rust: });
    // rust: sword.data_mut().other.push((
    // rust: "minecraft:blocks_attacks".into(),
    // rust: horizon_client_core::scoreboard::json_to_tag(&component),
    // rust: ));
    // rust: let b = BlocksAttacks::of_stack(&sword, None).expect("the stack's own component");
    // rust: assert_eq!(b.delay_seconds, 0.0);
    // rust: assert_eq!(b.disable_scale, 0.0);
    // rust: assert_eq!(b.reductions.len(), 1);
    // rust: assert_eq!(b.reductions[0].horizontal_angle, 180.0);
    // rust: assert_eq!((b.reductions[0].base, b.reductions[0].factor), (-0.5, 0.5));
    // rust: assert_eq!(b.item_damage.0, 1.0e9);
    // rust: assert_eq!(b.bypassed_by.as_deref(), Some("#minecraft:bypasses_armor"));
        // An empty compound is the codec's defaults: a shield's 90 degrees.
    // rust: let mut bare = plain.clone();
    // rust: bare.data_mut().other.push((
    // rust: "minecraft:blocks_attacks".into(),
    // rust: horizon_client_core::scoreboard::json_to_tag(&json!({})),
    // rust: ));
    // rust: let b = BlocksAttacks::of_stack(&bare, None).expect("defaults");
    // rust: assert_eq!(b.reductions[0].horizontal_angle, 90.0);
    // rust: assert_eq!(b.disable_scale, 1.0);
}

pub fn loaded_block_and_item_tags_answer_membership() void {
}
    // rust: let mut items = super::Items::for_tests(std::collections::HashMap::from([(
    // rust: "test:items".into(),
    // rust: ["test:apple".into()].into_iter().collect(),
    // rust: )]));
    // rust: items.block_tags.insert(
    // rust: "test:blocks".into(),
    // rust: ["test:stone".into()].into_iter().collect(),
    // rust: );
    // rust: assert!(items.block_in_tag("test:blocks", "test:stone"));
    // rust: assert!(!items.block_in_tag("test:blocks", "test:dirt"));
    // rust: assert!(!items.block_in_tag("test:missing", "test:stone"));
    // rust: assert!(items.item_in_tag("test:items", "test:apple"));
    // rust: assert!(!items.item_in_tag("test:items", "test:stone"));
    // rust: assert!(!items.item_in_tag("test:missing", "test:apple"));
}

    /// `NestedLootTable`: a `loot_table` entry, by id or inline, rolls that
    /// table in full and applies its own functions to each stack; a table
    /// never rolls inside itself.
pub fn loot_table_entries_roll_their_table() void {
}
    // rust: let mut items = Items::for_tests(HashMap::new());
    // rust: let diamond = json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"minecraft:diamond"}]}]});
    // rust: items.loot = Arc::new(
    // rust: [
    // rust: ("test:inner", diamond.clone()),
    // rust: ("test:outer", json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:loot_table",
    // rust: "value":"test:inner","modifier":[{"type":"minecraft:set_count","count":3}]}]}]})),
    // rust: ("test:inline", json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:loot_table",
    // rust: "value":diamond}]}]})),
    // rust: ("test:loop", json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:loot_table",
    // rust: "value":"test:loop"}]},{"rolls":1,"entries":[{"type":"minecraft:item","name":"minecraft:stick"}]}]})),
    // rust: ]
    // rust: .map(|(id, t)| (id.to_owned(), t))
    // rust: .into_iter()
    // rust: .collect(),
    // rust: );
    // rust: let roll = |id: &str| {
    // rust: items
    // rust: .loot_table(id, false, None, &mut LegacyRandom::new(1))
    // rust: .into_iter()
    // rust: .map(|s| format!("{} {}", s.item, s.count))
    // rust: .collect::<Vec<_>>()
}
    // rust: assert_eq!(roll("test:outer"), ["minecraft:diamond 3"]);
    // rust: assert_eq!(roll("test:inline"), ["minecraft:diamond 1"]);
        // `test:loop` is already rolling: its own entry adds nothing.
    // rust: assert_eq!(roll("test:loop"), ["minecraft:stick 1"]);
}

    /// `Blocks.wallVariant`: a wall block without a table of its own drops
    /// from its standing block's (vanilla's tables: `blocks/torch` for
    /// `wall_torch`, `blocks/oak_sign` for `oak_wall_sign`...).
pub fn wall_blocks_use_the_standing_blocks_table() void {
}
    // rust: let facts = br#"{"defaults":{"minecraft:air":0,"minecraft:wall_torch":1,
    // rust: "minecraft:oak_wall_sign":2,"minecraft:skeleton_wall_skull":3,
    // rust: "minecraft:dead_brain_coral_wall_fan":4,"test:wall_lamp":5,"minecraft:cobblestone_wall":6},
    // rust: "states":[
    // rust: ["air",true,false,"","minecraft:air"],
    // rust: ["a",false,false,"","minecraft:wall_torch"],
    // rust: ["b",false,false,"","minecraft:oak_wall_sign"],
    // rust: ["c",false,false,"","minecraft:skeleton_wall_skull"],
    // rust: ["d",false,false,"","minecraft:dead_brain_coral_wall_fan"],
    // rust: ["e",false,false,"","test:wall_lamp"],
    // rust: ["f",false,false,"","minecraft:cobblestone_wall"]
    // rust: ]}"#;
    // rust: let registry = BlockRegistry::from_facts_json(&facts[..]).unwrap();
    // rust: let mut items = Items::for_tests(HashMap::new());
    // rust: items.loot = Arc::new(
    // rust: [
    // rust: "minecraft:blocks/torch",
    // rust: "minecraft:blocks/oak_sign",
    // rust: "minecraft:blocks/skeleton_skull",
    // rust: "minecraft:blocks/dead_brain_coral_fan",
    // rust: "test:blocks/wall_lamp",
    // rust: "test:blocks/lamp",
    // rust: "minecraft:blocks/cobblestone_wall",
    // rust: ]
    // rust: .map(|id| (id.to_owned(), json!({"pools": []})))
    // rust: .into_iter()
    // rust: .collect(),
    // rust: );
    // rust: let table = |state| items.block_loot_table(&registry, BlockStateId(state));
    // rust: assert_eq!(table(1).as_deref(), Some("minecraft:blocks/torch"));
    // rust: assert_eq!(table(2).as_deref(), Some("minecraft:blocks/oak_sign"));
    // rust: assert_eq!(table(3).as_deref(), Some("minecraft:blocks/skeleton_skull"));
    // rust: assert_eq!(
    // rust: table(4).as_deref(),
    // rust: Some("minecraft:blocks/dead_brain_coral_fan")
    // rust: );
        // A table of its own wins over the standing block's.
    // rust: assert_eq!(table(5).as_deref(), Some("test:blocks/wall_lamp"));
    // rust: assert_eq!(
    // rust: table(6).as_deref(),
    // rust: Some("minecraft:blocks/cobblestone_wall")
    // rust: );
    // rust: assert_eq!(table(0), None);
}

pub fn content_mod_blocks_keep_their_namespace_in_loot_table_ids() void {
}
    // rust: let facts = br#"{"defaults":{"minecraft:air":0,"loot_repro:glowing_amethyst":1},
    // rust: "states":[
    // rust: ["air",true,false,"","minecraft:air"],
    // rust: ["amethyst",false,false,"","loot_repro:glowing_amethyst"]
    // rust: ]}"#;
    // rust: let registry = BlockRegistry::from_facts_json(&facts[..]).unwrap();
    // rust: let mut items = Items::for_tests(HashMap::new());
    // rust: items.loot = Arc::new(
    // rust: [(
    // rust: "loot_repro:blocks/glowing_amethyst".to_owned(),
    // rust: json!({"pools": []}),
    // rust: )]
    // rust: .into_iter()
    // rust: .collect(),
    // rust: );

    // rust: assert_eq!(
    // rust: items
    // rust: .block_loot_table(&registry, BlockStateId(1))
    // rust: .as_deref(),
    // rust: Some("loot_repro:blocks/glowing_amethyst")
    // rust: );
}

    // rust: fn ctx<'a>(
    // rust: items: &'a Items,
    // rust: held: Option<&'a ItemStack>,
    // rust: props: &'a horizon_world::chunk::BlockProperties,
    // rust: block: &'a str,
    // rust: ) -> LootContext<'a> {
    // rust: LootContext {
    // rust: items,
    // rust: block,
    // rust: properties: props,
    // rust: held,
    // rust: killed_by_player: block.is_empty(),
    // rust: explosion_radius: None,
    // rust: this_entity: false,
}
}

    /// A mod's kind nobody claims fails; a reference by name isn't a kind,
    /// and fails too.
pub fn an_unclaimed_condition_of_a_mods_kind_fails() void {
}
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let props = horizon_world::chunk::BlockProperties::new();
    // rust: let table = |condition: Value| {
    // rust: json!({"pools":[{"rolls":1,"entries":[
    // rust: {"type":"minecraft:item","name":"minecraft:stone","condition":condition}]}]})
}
    // rust: let mut random = LegacyRandom::new(7);
    // rust: let mut drops = |condition: Value, block: &str| {
    // rust: ctx(&items, None, &props, block)
    // rust: .evaluate(&table(condition), &mut random)
    // rust: .len()
}
    // rust: assert_eq!(drops(json!({"type":"mymod:always"}), "minecraft:stone"), 0);
    // rust: assert_eq!(drops(json!({"type":"mymod:always"}), ""), 0);
    // rust: assert_eq!(drops(json!("mymod:always"), "minecraft:stone"), 0);
    // rust: assert_eq!(drops(Value::Null, "minecraft:stone"), 1);
}

    /// A mod's function kind changes the stack the items engine drops: what
    /// the hook leaves in the stack comes back (item, count, a component),
    /// through the conversion the block-drop path uses.
pub fn a_mod_function_changes_the_stack_the_items_engine_drops() void {
}
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let props = horizon_world::chunk::BlockProperties::new();
    // rust: let mut random = LegacyRandom::new(7);
    // rust: let block = ctx(&items, None, &props, "minecraft:stone");
    // rust: let native = block.native_loot_context(&mut random);
    // rust: let mut stack = ItemStack::new("minecraft:stone", 1);
    // rust: mod_function(
    // rust: "mymod:seven",
    // rust: &json!({"type": "mymod:seven"}),
    // rust: &native,
    // rust: &mut stack,
    // rust: |_, _, _, loot| {
    // rust: loot.item = "minecraft:diamond".to_owned();
    // rust: loot.count = 7;
    // rust: loot.components.push((
    // rust: "minecraft:custom_data".to_owned(),
    // rust: json!({"machine": "furnace"}),
    // rust: ));
    // rust: },
    // rust: );
    // rust: assert_eq!(&*stack.item, "minecraft:diamond");
    // rust: assert_eq!(stack.count, 7);
    // rust: assert_eq!(
    // rust: stack.data().and_then(|d| d.other("minecraft:custom_data")),
    // rust: Some(&horizon_client_core::scoreboard::json_to_tag(
    // rust: &json!({"machine": "furnace"})
    // rust: ))
    // rust: );
}

    /// A function that leaves the stack alone keeps its own form: the round
    /// trip through the loot engine's stack changes nothing.
pub fn a_mod_function_that_changes_nothing_keeps_the_stacks_form() void {
}
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let props = horizon_world::chunk::BlockProperties::new();
    // rust: let mut random = LegacyRandom::new(7);
    // rust: let block = ctx(&items, None, &props, "minecraft:stone");
    // rust: let native = block.native_loot_context(&mut random);
    // rust: let mut stack = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: stack.enchant("minecraft:sharpness", 3);
    // rust: stack
    // rust: .data_mut()
    // rust: .set_loot_name("minecraft:custom_name", &json!("Excalibur"));
    // rust: let before = stack.clone();
    // rust: mod_function(
    // rust: "mymod:nothing",
    // rust: &json!({"type": "mymod:nothing"}),
    // rust: &native,
    // rust: &mut stack,
    // rust: |_, _, _, _| {},
    // rust: );
    // rust: assert_eq!(stack, before);
}

    /// The items engine reaches the function hook: a pool whose function kind
    /// is a mod's draws the hook's one `next_long` where a vanilla pool draws
    /// none. The hook is unclaimed here, so the drop keeps its count.
pub fn a_mod_function_kind_reaches_the_items_engines_roll() void {
}
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let props = horizon_world::chunk::BlockProperties::new();
    // rust: let vanilla = json!({"pools":[{"rolls":1,"entries":[
    // rust: {"type":"minecraft:item","name":"minecraft:stone"}]}]});
    // rust: let modded = json!({"pools":[{"rolls":1,"entries":[
    // rust: {"type":"minecraft:item","name":"minecraft:stone"}],
    // rust: "modifier":[{"type":"mymod:duplicate","factor":2}]}]});
    // rust: let mut a = LegacyRandom::new(100);
    // rust: let mut b = LegacyRandom::new(100);
    // rust: let _ = ctx(&items, None, &props, "minecraft:stone").evaluate(&vanilla, &mut a);
    // rust: let expected: Vec<i64> = (0..5).map(|_| b.next_long()).collect();
    // rust: let got: Vec<i64> = (0..5).map(|_| a.next_long()).collect();
    // rust: assert_eq!(got, expected, "a vanilla table shifted the random");

    // rust: let mut c = LegacyRandom::new(100);
    // rust: let mut d = LegacyRandom::new(100);
    // rust: let drops = ctx(&items, None, &props, "minecraft:stone").evaluate(&modded, &mut c);
    // rust: let _ = d.next_long(); // the hook's seed
    // rust: let expected: Vec<i64> = (0..5).map(|_| d.next_long()).collect();
    // rust: let got: Vec<i64> = (0..5).map(|_| c.next_long()).collect();
    // rust: assert_eq!(got, expected, "the mod function did not draw its seed");
    // rust: assert_eq!(drops.len(), 1);
    // rust: assert_eq!(drops[0].count, 1);
}

pub fn fortune_silk_touch_and_looting() void {
}
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let props = horizon_world::chunk::BlockProperties::new();
    // rust: let mut pick = ItemStack::new("minecraft:diamond_pickaxe", 1);
    // rust: pick.enchant("minecraft:fortune", 3);
    // rust: let ore = json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:alternatives","children":[
    // rust: {"type":"minecraft:item","condition":"minecraft:tool/can_silk_touch","name":"minecraft:diamond_ore"},
    // rust: {"type":"minecraft:item","name":"minecraft:diamond","modifier":[{"type":"minecraft:apply_bonus","enchantment":"minecraft:fortune","formula":"minecraft:ore_drops"}]}]}]}]});
    // rust: let mut random = LegacyRandom::new(7);
    // rust: let n = 20000;
    // rust: let total: u32 = (0..n)
    // rust: .map(|_| {
    // rust: ctx(&items, Some(&pick), &props, "minecraft:diamond_ore")
    // rust: .evaluate(&ore, &mut random)
    // rust: .iter()
    // rust: .map(|s| s.count)
    // rust: .sum::<u32>()
    // rust: })
    // rust: .sum();
        // Fortune III ore drops average (1 + 1 + 2 + 3 + 4) / 5 = 2.2 diamonds.
    // rust: let mean = f64::from(total) / f64::from(n);
    // rust: assert!((mean - 2.2).abs() < 0.05, "{mean}");
    // rust: let mut silk = ItemStack::new("minecraft:diamond_pickaxe", 1);
    // rust: silk.enchant("minecraft:silk_touch", 1);
    // rust: let drops =
    // rust: ctx(&items, Some(&silk), &props, "minecraft:diamond_ore").evaluate(&ore, &mut random);
    // rust: assert_eq!(&*drops[0].item, "minecraft:diamond_ore");
    // rust: let plain = ItemStack::new("minecraft:diamond_pickaxe", 1);
    // rust: let drops =
    // rust: ctx(&items, Some(&plain), &props, "minecraft:diamond_ore").evaluate(&ore, &mut random);
    // rust: assert_eq!((&*drops[0].item, drops[0].count), ("minecraft:diamond", 1));
        // Looting III adds level x uniform(0, 1) on player kills.
    // rust: let flesh = json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"minecraft:rotten_flesh","modifier":[
    // rust: {"type":"minecraft:set_count","count":{"type":"minecraft:uniform","min":0.0,"max":2.0}},
    // rust: {"type":"minecraft:enchanted_count_increase","count":{"type":"minecraft:uniform","min":0.0,"max":1.0},"enchantment":"minecraft:looting"}]}]}]});
    // rust: let mut sword = ItemStack::new("minecraft:iron_sword", 1);
    // rust: sword.enchant("minecraft:looting", 3);
    // rust: let looted: u32 = (0..n)
    // rust: .map(|_| {
    // rust: ctx(&items, Some(&sword), &props, "")
    // rust: .evaluate(&flesh, &mut random)
    // rust: .iter()
    // rust: .map(|s| s.count)
    // rust: .sum::<u32>()
    // rust: })
    // rust: .sum();
    // rust: let base: u32 = (0..n)
    // rust: .map(|_| {
    // rust: ctx(&items, None, &props, "")
    // rust: .evaluate(&flesh, &mut random)
    // rust: .iter()
    // rust: .map(|s| s.count)
    // rust: .sum::<u32>()
    // rust: })
    // rust: .sum();
    // rust: assert!(f64::from(looted) / f64::from(n) > f64::from(base) / f64::from(n) + 1.0);
        // Table bonus uses the chance for the tool's level.
    // rust: let leaves = json!({"pools":[{"rolls":1,"conditions":[{"type":"minecraft:table_bonus","enchantment":"minecraft:fortune","chances":[0.0,0.0,0.0,1.0]}],"entries":[{"type":"minecraft:item","name":"minecraft:apple"}]}]});
    // rust: assert_eq!(
    // rust: ctx(&items, Some(&pick), &props, "minecraft:oak_leaves")
    // rust: .evaluate(&leaves, &mut random)
    // rust: .len(),
    // rust: 1
    // rust: );
    // rust: assert!(
    // rust: ctx(&items, Some(&plain), &props, "minecraft:oak_leaves")
    // rust: .evaluate(&leaves, &mut random)
    // rust: .is_empty()
    // rust: );
}

pub fn set_potion_gives_the_potion_its_contents() void {
}
    // rust: let items = Items::for_tests(HashMap::new());
    // rust: let props = horizon_world::chunk::BlockProperties::new();
    // rust: let table = json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"minecraft:splash_potion",
    // rust: "modifier":{"type":"minecraft:set_potion","id":"minecraft:fire_resistance"}}]}]});
    // rust: let drops = ctx(&items, None, &props, "").evaluate(&table, &mut LegacyRandom::new(1));
    // rust: assert_eq!(drops.len(), 1);
    // rust: assert_eq!(&*drops[0].item, "minecraft:splash_potion");
    // rust: assert_eq!(drops[0].potion(), Some("minecraft:fire_resistance"));
}

    /// `/loot give` and every other table this dispatcher rolls: the two
    /// enchantment functions (`EnchantWithLevelsFunction`,
    /// `EnchantRandomlyFunction`) put their enchantments on the stack.
pub fn loot_enchant_functions_enchant_the_rolled_item() void {
}
    // rust: let Some(items) = super::prepared_items() else {
    // rust: return;
}
    // rust: let props = horizon_world::chunk::BlockProperties::new();
    // rust: let mut random = LegacyRandom::new(11);
        // A sword at levels 20..39 comes out enchanted, as in an End city.
    // rust: let levels = json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:item",
    // rust: "name":"minecraft:diamond_sword","modifier":[
    // rust: {"type":"minecraft:enchant_with_levels","levels":{"type":"minecraft:uniform","min":20.0,"max":39.0}}]}]}]});
    // rust: let mut enchanted = 0;
    // rust: for _ in 0..40 {
    // rust: let drops = ctx(&items, None, &props, "").evaluate(&levels, &mut random);
    // rust: if drops[0].enchantments().is_empty() {
    // rust: continue;
}
    // rust: enchanted += 1;
    // rust: assert_eq!(&*drops[0].item, "minecraft:diamond_sword");
            // Levels stay within the enchantment's range.
    // rust: for (id, level) in drops[0].enchantments() {
    // rust: let max = items
    // rust: .enchantments
    // rust: .get(id)
    // rust: .expect("a known enchantment")
    // rust: .max_level;
    // rust: assert!((1..=max).contains(level), "{id} at {level}");
}
}
    // rust: assert!(
    // rust: enchanted > 30,
    // rust: "only {enchanted} of 40 rolls were enchanted"
    // rust: );
        // `enchant_randomly` on a book makes one enchanted book, its levels
        // stored; the pool is the enchantment tag it names.
    // rust: let book = json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:item",
    // rust: "name":"minecraft:book","modifier":[
    // rust: {"type":"minecraft:enchant_randomly","options":"#minecraft:on_random_loot"}]}]}]});
    // rust: let drops = ctx(&items, None, &props, "").evaluate(&book, &mut random);
    // rust: assert_eq!(&*drops[0].item, "minecraft:enchanted_book");
    // rust: assert_eq!(drops[0].count, 1);
    // rust: assert!(drops[0].enchantments().is_empty());
    // rust: let stored = drops[0].stored_enchantments();
    // rust: assert_eq!(stored.len(), 1, "{stored:?}");
    // rust: assert!(
    // rust: items
    // rust: .enchantments
    // rust: .in_tag("minecraft:on_random_loot", &stored[0].0)
    // rust: );
        // An item no enchantment accepts keeps none of them.
    // rust: let dirt = json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:item",
    // rust: "name":"minecraft:dirt","modifier":[
    // rust: {"type":"minecraft:enchant_with_levels","levels":{"type":"minecraft:constant","value":30.0}}]}]}]});
    // rust: let drops = ctx(&items, None, &props, "").evaluate(&dirt, &mut random);
    // rust: assert!(drops[0].enchantments().is_empty());
}

    /// `Mth.nextInt(random, 1, max)` returns `1` without drawing when the
    /// enchantment has one level (`EnchantRandomlyFunction.enchantItem`), so
    /// the rolls after it must not shift. Vanilla with `LegacyRandom(11)`: a
    /// Mending book, then `set_count` uniform 1..64, is 46.
pub fn a_single_level_enchantment_draws_no_level() void {
}
    // rust: let Some(items) = super::prepared_items() else {
    // rust: return;
}
    // rust: let props = horizon_world::chunk::BlockProperties::new();
    // rust: let table = json!({"pools":[{"rolls":1,"entries":[{"type":"minecraft:item",
    // rust: "name":"minecraft:book","modifier":[
    // rust: {"type":"minecraft:enchant_randomly","options":"minecraft:mending"},
    // rust: {"type":"minecraft:set_count","count":{"type":"minecraft:uniform","min":1.0,"max":64.0}}]}]}]});
    // rust: let drops = ctx(&items, None, &props, "").evaluate(&table, &mut LegacyRandom::new(11));
    // rust: assert_eq!(drops.len(), 1);
    // rust: assert_eq!(&*drops[0].item, "minecraft:enchanted_book");
    // rust: assert_eq!(
    // rust: drops[0].stored_enchantments(),
    // rust: [("minecraft:mending".to_owned().into(), 1)],
    // rust: "the book keeps its single-level enchantment"
    // rust: );
        // 46 is vanilla's count for this seed; an extra level draw gives 28.
    // rust: assert_eq!(drops[0].count, 46);
}

    /// A content root's remainders reach the mods' items; vanilla's stay its own.
pub fn mod_items_take_their_crafting_remainders() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-craft-remainders-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: fs::create_dir_all(root.join("data/minecraft/loot_table")).unwrap();
    // rust: let items = r#"{"minecraft:bowl": {}, "minecraft:milk_bucket": {}, "ruby:stew": {}}"#;
    // rust: fs::write(root.join("items.json"), items).unwrap();
    // rust: let catalog = |root: &Path| Items::catalog(root, &PackOverlay::NONE).unwrap();
    // rust: let remainder = |items: &Items, id: &str| items.items[id].crafting_remainder.clone();
    // rust: let vanilla = catalog(&root);
    // rust: assert_eq!(remainder(&vanilla, "ruby:stew"), None);
    // rust: fs::write(
    // rust: root.join(MOD_CRAFT_REMAINDERS),
    // rust: r#"{"ruby:stew": "minecraft:bowl"}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let modded = catalog(&root);
    // rust: assert_eq!(
    // rust: remainder(&modded, "ruby:stew").as_deref(),
    // rust: Some("minecraft:bowl")
    // rust: );
    // rust: assert_eq!(
    // rust: remainder(&modded, "minecraft:milk_bucket").as_deref(),
    // rust: Some("minecraft:bucket")
    // rust: );
    // rust: assert_eq!(remainder(&modded, "minecraft:bowl"), None);
    // rust: fs::remove_dir_all(&root).unwrap();
}
}

/// Minecraft.handleKeybinds: spectators cannot drop from the selected slot.
    // rust: pub fn take_held_drop(
    // rust: slot: &mut Option<ItemStack>,
    // rust: all: bool,
    // rust: spectator: bool,
    // rust: ) -> Option<ItemStack> {
    // rust: if spectator {
    // rust: return None;
}
    // rust: let stack = slot.as_mut()?;
    // rust: if stack.count == 0 {
    // rust: return None;
}
    // rust: let count = if all { stack.count } else { 1 };
    // rust: let thrown = ItemStack {
    // rust: count,
    // rust: ..stack.clone()
}
    // rust: stack.count -= count;
    // rust: if stack.count == 0 {
    // rust: *slot = None;
}
    // rust: Some(thrown)
}
    // rust: mod held_drop_tests {
//     use super::*;
pub fn one_all_and_empty_drop() void {
}
    // rust: let mut slot = Some(ItemStack::new("minecraft:stone", 4));
    // rust: assert_eq!(take_held_drop(&mut slot, false, false).unwrap().count, 1);
    // rust: assert_eq!(slot.as_ref().unwrap().count, 3);
    // rust: assert_eq!(take_held_drop(&mut slot, true, false).unwrap().count, 3);
    // rust: assert!(slot.is_none());
    // rust: assert!(take_held_drop(&mut slot, false, false).is_none());
}
pub fn spectator_keeps_selected_stack_for_single_and_whole_stack_drops() void {
}
    // rust: for all in [false, true] {
    // rust: let mut slot = Some(ItemStack::new("minecraft:stone", 4));
    // rust: assert!(take_held_drop(&mut slot, all, true).is_none());
    // rust: assert_eq!(slot.as_ref().unwrap().count, 4);
            // Leaving spectator allows dropping the same selected stack again.
    // rust: assert_eq!(
    // rust: take_held_drop(&mut slot, all, false).unwrap().count,
    // rust: if all { 4 } else { 1 }
    // rust: );
}
}
}

    // rust: mod villager_food_tests {
//     use super::*;

    /// A villager's food is the item's `villager_food` component, read from the registry:
    /// vanilla's four (bread 4, the rest 1) and nothing else.
pub fn the_registry_tells_a_villagers_food() void {
}
    // rust: let Some(items) = prepared_items() else {
    // rust: return;
}
    // rust: let food: Vec<(&str, Option<i32>)> = [
    // rust: "minecraft:bread",
    // rust: "minecraft:carrot",
    // rust: "minecraft:potato",
    // rust: "minecraft:beetroot",
    // rust: "minecraft:apple",
    // rust: ]
    // rust: .map(|i| (i, items.get(i).and_then(|i| i.villager_food)))
    // rust: .into();
    // rust: assert_eq!(
    // rust: food,
    // rust: [
    // rust: ("minecraft:bread", Some(4)),
    // rust: ("minecraft:carrot", Some(1)),
    // rust: ("minecraft:potato", Some(1)),
    // rust: ("minecraft:beetroot", Some(1)),
    // rust: ("minecraft:apple", None),
    // rust: ]
    // rust: );
        // Loading the registry hands the mobs the same table.
    // rust: assert_eq!(villager_food("minecraft:bread"), Some(4));
    // rust: assert_eq!(villager_food("minecraft:apple"), Some(0));
}
}
