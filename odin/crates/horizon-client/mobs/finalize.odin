//! Transpiled from Horizon Rust crate
package horizon_client_finalize

import "core:fmt"
import "core:mem"
import "core:math"

// `Mob.finalizeSpawn` and its overrides, for every spawn path (natural
// spawning, chunk generation, spawners, trial spawners, spawn eggs,
// commands, structures, patrols, raids, jockeys, conversions...).
//
// Every draw vanilla takes from `level.getRandom()` comes from the random
// the caller passes (the level's random for a running level, the region's
// for chunk generation); the few that come from the entity's own random
// (`Zombie.handleAttributes`, `Piglin.createSpawnWeapon`, salmon sizes) come
// from `Mob::random`. The order of the draws follows vanilla's class chain:
// each species runs its own part before or after its superclass as vanilla
// does. Jockeys a mob brings (`EntityType.create` inside finalizeSpawn) are
// made through [`FinalizeLevel::create`], finalized with the same random and
// returned in [`Ctx::created`].
//
// Variant state kept in [`super::Extra`]: `variant` is the registry or enum
// index of the species' variant (cat, wolf, frog, farm animals by climate,
// zombie nautilus, horse, llama, fox, rabbit, parrot, axolotl, salmon,
// tropical fish pattern, panda main gene, villager type), `variant2` the
// second part (horse markings, llama strength, panda hidden gene, tropical
// fish base colour), `variant3` the tropical fish pattern colour, and
// `sound_variant` the index in the species' sound variant registry.
// use super::{Mob, Species, farm::Climate, gear, spawning::LocalDifficulty};
// use crate::{enchant::Enchantments, items::Items};
// use horizon_core::{
    // rust: geometry::Aabb,
    // rust: random::{LegacyRandom, RandomSource},
}
// use serde_json::Value;
// use std::{fs, path::Path, sync::Arc};

// `EntitySpawnReason`.
Reason :: enum {
    Natural,
    ChunkGeneration,
    Spawner,
    Structure,
    Breeding,
    MobSummoned,
    Jockey,
    Event,
    Conversion,
    Reinforcement,
    Triggered,
    Bucket,
    SpawnItemUse,
    Command,
    Dispenser,
    Patrol,
    TrialSpawner,
    Load,
    DimensionTravel,
}
    // rust: impl Reason {
    // rust: pub const ALL: [Self; 19] = [
    // rust: Self::Natural,
    // rust: Self::ChunkGeneration,
    // rust: Self::Spawner,
    // rust: Self::Structure,
    // rust: Self::Breeding,
    // rust: Self::MobSummoned,
    // rust: Self::Jockey,
    // rust: Self::Event,
    // rust: Self::Conversion,
    // rust: Self::Reinforcement,
    // rust: Self::Triggered,
    // rust: Self::Bucket,
    // rust: Self::SpawnItemUse,
    // rust: Self::Command,
    // rust: Self::Dispenser,
    // rust: Self::Patrol,
    // rust: Self::TrialSpawner,
    // rust: Self::Load,
    // rust: Self::DimensionTravel,
    // rust: ];
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Natural => "NATURAL",
    // rust: Self::ChunkGeneration => "CHUNK_GENERATION",
    // rust: Self::Spawner => "SPAWNER",
    // rust: Self::Structure => "STRUCTURE",
    // rust: Self::Breeding => "BREEDING",
    // rust: Self::MobSummoned => "MOB_SUMMONED",
    // rust: Self::Jockey => "JOCKEY",
    // rust: Self::Event => "EVENT",
    // rust: Self::Conversion => "CONVERSION",
    // rust: Self::Reinforcement => "REINFORCEMENT",
    // rust: Self::Triggered => "TRIGGERED",
    // rust: Self::Bucket => "BUCKET",
    // rust: Self::SpawnItemUse => "SPAWN_ITEM_USE",
    // rust: Self::Command => "COMMAND",
    // rust: Self::Dispenser => "DISPENSER",
    // rust: Self::Patrol => "PATROL",
    // rust: Self::TrialSpawner => "TRIAL_SPAWNER",
    // rust: Self::Load => "LOAD",
    // rust: Self::DimensionTravel => "DIMENSION_TRAVEL",
}
}
parse :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL.into_iter().find(|r| r.name() == name)
}
}

// The level as finalizeSpawn reads it.
    // rust: pub trait FinalizeLevel {
    // The biome id at a block.
biome :: proc(self: ^Self, pos: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // The biome at a block is in a biome tag (`minecraft:...`).
biome_tag :: proc(self: ^Self, tag: string, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // The structures with a piece at a block.
structures_with_piece_at :: proc(self: ^Self, pos: [i32; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // `EnvironmentAttributes.MOON_PHASE` at a block (0 full moon to 7).
moon_phase :: proc(self: ^Self, pos: [i32; 3]) -> u {
    // Ported from Horizon
    return {}
}
    // `ServerLevel.isSpawningMonsters`.
spawning_monsters :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // `Level.noCollision(AABB)`.
no_collision :: proc(self: ^Self, bounds: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // The first chicken (in entity order) whose box meets `bounds` and
    // that is not being ridden (`Zombie.finalizeSpawn`'s chicken jockeys).
free_chicken :: proc(self: ^Self, bounds: Aabb) -> O {
    // Ported from Horizon
    return {}
}
    // A chicken found by `free_chicken` carries the zombie `rider`
    // (`setChickenJockey(true)` and `startRiding`).
ride_chicken :: proc(self: ^Self, chicken: u32, rider: u32) {
}
    // `getGameTime`.
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // `SpecialDates.isHalloween`.
halloween :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // `EntityType.create(level, reason)`: a new mob of a type (an id and an
    // own random from the caller), or None where it cannot exist (monsters
    // in peaceful).
create :: proc(self: ^Self, kind: string, reason: Reason) -> O {
    // Ported from Horizon
    return {}
}
}

// `AgeableMob.AgeableMobGroupData`.
Ageable :: struct {
    size: i32,
    should_spawn_baby: bool,
    baby_chance: f32,
}
    // rust: impl Ageable {
new :: proc(should_spawn_baby: bool, baby_chance: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: size: 0,
    // rust: should_spawn_baby,
    // rust: baby_chance,
}
}
    // `AgeableMobGroupData(boolean)`.
babies :: proc(should_spawn_baby: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(should_spawn_baby, 0.05)
}
    // `AgeableMobGroupData(float)`.
chance :: proc(baby_chance: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(true, baby_chance)
}
}
// `SpawnGroupData`: what the mobs of a pack share.
Group :: enum {
    Ageable(Ageable),
    // `Zombie.ZombieGroupData`, and `Husk.HuskGroupData` with `tried_camel`.
    Zombie {,
    baby: bool,
    jockey: bool,
    husk: Option<bool>,
    // rust: },
    // `Spider.SpiderEffectsGroupData`.
    Spider(Option<&'static str>),
    Horse(Ageable, u8),
    Llama(Ageable, u8),
    Fox(Ageable, u8),
    Rabbit(Ageable, u8),
    Axolotl(Ageable, [u8; 2]),
    Wolf(Ageable, u8),
    // `AbstractSchoolingFish.SchoolSpawnGroupData` (the leader's id), and
    // `TropicalFishGroupData` with its variant.
    School(u32, Option<(u8, u8, u8)>),
}
    // rust: impl Group {
ageable :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Ageable(a)
    // rust: | Self::Horse(a, _)
    // rust: | Self::Llama(a, _)
    // rust: | Self::Fox(a, _)
    // rust: | Self::Rabbit(a, _)
    // rust: | Self::Axolotl(a, _)
    // rust: | Self::Wolf(a, _) => Some(a),
    // rust: _ => None,
}
}
}

// A variant registry entry's spawn conditions (`SpawnPrioritySelectors`).
Condition :: enum {
    Biome(Vec<String>),
    Structure(Vec<String>),
    Moon(Option<f64>, Option<f64>),
}
VariantRegistry :: struct {
    // Entry names in registry order (sorted by id).
    names: [dynamic]string,
    selectors: Vec<(uint,
}
    // rust: impl VariantRegistry {
load :: proc(dir: ^Path, structure_tags: ^dyn Fn(string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut names: Vec<String> = fs::read_dir(dir)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: e.file_name()
    // rust: .to_str()
    // rust: .and_then(|n| n.strip_suffix(".json"))
    // rust: .map(str::to_owned)
    // rust: })
    // rust: .collect();
    // rust: names.sort();
    // rust: let mut selectors = Vec::new();
    // rust: for (i, name) in names.iter().enumerate() {
    // rust: let Ok(bytes) = fs::read(dir.join(format!("{name}.json"))) else {
    // rust: continue;
}
    // rust: let Ok(v) = serde_json::from_slice::<Value>(&bytes) else {
    // rust: continue;
}
    // rust: for s in v["spawn_conditions"].as_array().into_iter().flatten() {
    // rust: let priority = s["priority"].as_i64().unwrap_or(0) as i32;
    // rust: let c = &s["condition"];
    // rust: let list = |v: &Value| -> Vec<String> {
    // rust: match v {
    // rust: Value::String(s) => vec![s.clone()],
    // rust: Value::Array(a) => a
    // rust: .iter()
    // rust: .filter_map(|x| x.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
}
    // rust: let condition = match c["type"].as_str() {
    // rust: Some("minecraft:biome") => Some(Condition::Biome(list(&c["biomes"]))),
    // rust: Some("minecraft:structure") => Some(Condition::Structure(
    // rust: list(&c["structures"])
    // rust: .into_iter()
    // rust: .flat_map(|s| match s.strip_prefix('#') {
    // rust: Some(tag) => structure_tags(tag),
    // rust: None => vec![s],
    // rust: })
    // rust: .collect(),
    // rust: )),
    // rust: Some("minecraft:moon_brightness") => {
    // rust: let r = &c["range"];
    // rust: Some(match r.as_f64() {
    // rust: Some(x) => Condition::Moon(Some(x), Some(x)),
    // rust: None => Condition::Moon(r["min"].as_f64(), r["max"].as_f64()),
    // rust: })
}
    // rust: _ => None,
}
    // rust: selectors.push((i, condition, priority));
}
}
    // rust: Self { names, selectors }
}
index :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: self.names.iter().position(|n| n == name)
}
    // `VariantUtils.selectVariantToSpawn`: the entries of the highest
    // priority whose condition holds, one of them at random.
    // rust: pub fn select<L: FinalizeLevel + ?Sized>(
    // rust: &self,
    // rust: level: &L,
    // rust: pos: [i32; 3],
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Option<usize> {
    // rust: let mut unpacked: Vec<&(usize, Option<Condition>, i32)> = self.selectors.iter().collect();
    // rust: unpacked.sort_by_key(|s| std::cmp::Reverse(s.2));
    // rust: let mut highest = i32::MIN;
    // rust: let mut selected = Vec::new();
    // rust: for (entry, condition, priority) in unpacked {
    // rust: if *priority < highest {
    // rust: continue;
}
    // rust: let ok = match condition {
    // rust: None => true,
    // rust: Some(Condition::Biome(list)) => list.iter().any(|b| match b.strip_prefix('#') {
    // rust: Some(tag) => level.biome_tag(tag, pos),
    // rust: None => level.biome(pos) == *b,
    // rust: }),
    // rust: Some(Condition::Structure(list)) => {
    // rust: let here = level.structures_with_piece_at(pos);
    // rust: here.iter().any(|s| list.contains(s))
}
    // rust: Some(Condition::Moon(min, max)) => {
    // rust: let b = f64::from(super::spawning::MOON_BRIGHTNESS[level.moon_phase(pos) & 7]);
    // rust: min.is_none_or(|m| b >= m) && max.is_none_or(|m| b <= m)
}
}
    // rust: if ok {
    // rust: highest = *priority;
    // rust: selected.push(*entry);
}
}
    // rust: if selected.is_empty() {
    // rust: return None;
}
    // rust: Some(selected[random.next_int_bound(selected.len() as i32).unwrap_or(0) as usize])
}
    // `Registry.getRandom`: any entry.
random :: proc(self: ^Self, random: ^impl RandomSource) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if self.names.is_empty() {
    // rust: return 0;
}
    // rust: random.next_int_bound(self.names.len() as i32).unwrap_or(0) as usize
}
}

// The registries finalizeSpawn reads.
SpawnRegistries :: struct {
    pig: VariantRegistry,
    cow: VariantRegistry,
    chicken: VariantRegistry,
    cat: VariantRegistry,
    wolf: VariantRegistry,
    frog: VariantRegistry,
    zombie_nautilus: VariantRegistry,
    pig_sound: VariantRegistry,
    cow_sound: VariantRegistry,
    chicken_sound: VariantRegistry,
    cat_sound: VariantRegistry,
    wolf_sound: VariantRegistry,
}
    // rust: impl SpawnRegistries {
    // Loads the variant registries from a resources directory
    // (`data/minecraft/<registry>/`).
load :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let data = root.join("data/minecraft");
    // rust: let structure_tag = |tag: &str| -> Vec<String> {
    // rust: let path = tag.strip_prefix("minecraft:").unwrap_or(tag);
    // rust: let file = data.join(format!("tags/worldgen/structure/{path}.json"));
    // rust: let Ok(bytes) = fs::read(file) else {
    // rust: return Vec::new();
}
    // rust: serde_json::from_slice::<Value>(&bytes)
    // rust: .ok()
    // rust: .and_then(|v| v["values"].as_array().cloned())
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|x| x.as_str().map(str::to_owned))
    // rust: .collect()
}
    // rust: let r = |name: &str| VariantRegistry::load(&data.join(name), &structure_tag);
    // rust: Self {
    // rust: pig: r("pig_variant"),
    // rust: cow: r("cow_variant"),
    // rust: chicken: r("chicken_variant"),
    // rust: cat: r("cat_variant"),
    // rust: wolf: r("wolf_variant"),
    // rust: frog: r("frog_variant"),
    // rust: zombie_nautilus: r("zombie_nautilus_variant"),
    // rust: pig_sound: r("pig_sound_variant"),
    // rust: cow_sound: r("cow_sound_variant"),
    // rust: chicken_sound: r("chicken_sound_variant"),
    // rust: cat_sound: r("cat_sound_variant"),
    // rust: wolf_sound: r("wolf_sound_variant"),
}
}
}

// What finalizeSpawn needs besides the level: registries, enchantments.
SpawnData :: struct {
    registries: ^'a SpawnRegistries,
    enchantments: ^'a Enchantments,
    items: ^'a Items,
    // `EntityTypes.CAMEL_HUSK` dimensions (width, height).
    camel_husk_size: (f32,
}

// A finalizeSpawn call and the entities it made.
Ctx :: struct {
    level: ^'a mut L,
    random: ^'a mut R,
    difficulty: LocalDifficulty,
    data: ^'a SpawnData<'a>,
    // Jockeys and mounts made along the way, finalized, with their riding
    // links set (`Extra::mount` / `Extra::rider`).
    created: [dynamic]Mob,
    // The rider as it was when its new chicken was added to the level, before
    // its equipment and attributes: what a generated chunk keeps of it
    // (`ProtoChunk.addEntity` saves the chicken with its passenger then).
    jockey_rider: Maybe(Mob),
}

// ---- attributes -----------------------------------------------------------

// The attributes finalizeSpawn changes.
Attr :: enum {
    MaxHealth,
    MovementSpeed,
    FollowRange,
    AttackDamage,
    KnockbackResistance,
    SpawnReinforcements,
    JumpStrength,
    Armor,
    BurningTime,
    // `Attributes.FLYING_SPEED`: what `FlyingMoveControl` flies at.
    FlyingSpeed,
}
    // rust: impl Attr {
    // rust: pub const ALL: [Self; 10] = [
    // rust: Self::MaxHealth,
    // rust: Self::MovementSpeed,
    // rust: Self::FollowRange,
    // rust: Self::AttackDamage,
    // rust: Self::KnockbackResistance,
    // rust: Self::SpawnReinforcements,
    // rust: Self::JumpStrength,
    // rust: Self::Armor,
    // rust: Self::BurningTime,
    // rust: Self::FlyingSpeed,
    // rust: ];
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::MaxHealth => "max_health",
    // rust: Self::MovementSpeed => "movement_speed",
    // rust: Self::FollowRange => "follow_range",
    // rust: Self::AttackDamage => "attack_damage",
    // rust: Self::KnockbackResistance => "knockback_resistance",
    // rust: Self::SpawnReinforcements => "spawn_reinforcements",
    // rust: Self::JumpStrength => "jump_strength",
    // rust: Self::Armor => "armor",
    // rust: Self::BurningTime => "burning_time",
    // rust: Self::FlyingSpeed => "flying_speed",
}
}
    // The attribute's registry id (`minecraft:` and its name), without
    // building it: mob ticks and entity tracking ask for every mob.
id :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::MaxHealth => "minecraft:max_health",
    // rust: Self::MovementSpeed => "minecraft:movement_speed",
    // rust: Self::FollowRange => "minecraft:follow_range",
    // rust: Self::AttackDamage => "minecraft:attack_damage",
    // rust: Self::KnockbackResistance => "minecraft:knockback_resistance",
    // rust: Self::SpawnReinforcements => "minecraft:spawn_reinforcements",
    // rust: Self::JumpStrength => "minecraft:jump_strength",
    // rust: Self::Armor => "minecraft:armor",
    // rust: Self::BurningTime => "minecraft:burning_time",
    // rust: Self::FlyingSpeed => "minecraft:flying_speed",
}
}
    // `RangedAttribute` bounds.
range :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::MaxHealth => (1.0, 1024.0),
    // rust: Self::MovementSpeed => (0.0, 1024.0),
    // rust: Self::FollowRange => (0.0, 2048.0),
    // rust: Self::AttackDamage => (0.0, 2048.0),
    // rust: Self::KnockbackResistance | Self::SpawnReinforcements => (0.0, 1.0),
    // rust: Self::JumpStrength => (0.0, 32.0),
    // rust: Self::Armor => (0.0, 30.0),
    // rust: Self::BurningTime | Self::FlyingSpeed => (0.0, 1024.0),
}
}
}
// `AttributeModifier.Operation`.
Op :: enum {
    AddValue,
    AddMultipliedBase,
    AddMultipliedTotal,
}
// A permanent attribute modifier (`AttributeModifier`).
Modifier :: struct {
    attr: Attr,
    id: std::borrow::Cow<'static,
    amount: f64,
    op: Op,
}
// Attribute base values that differ from the type's and the permanent
// modifiers finalizeSpawn added, in the order vanilla adds them.
Attributes :: struct {
    bases: Vec<(Attr,
    modifiers: [dynamic]Modifier,
}
// The attribute `/attribute` names (`follow_range`, not
// `minecraft:follow_range`) when gameplay reads it from this store. Armor
// has its own map (`armor_attributes`).
command_attr :: proc(short: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Attr::ALL
    // rust: .into_iter()
    // rust: .find(|a| *a != Attr::Armor && a.name() == short)
}
// The type's default value of an attribute, if the mob has it.
default_value :: proc(m: ^Mob, a: Attr) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.kind.attributes.get(a.id()).copied()
}
base_value :: proc(m: ^Mob, a: Attr) -> f {
    // Ported from Horizon
    return {}
}
    // rust: base_value_with(m, a, || default_value(m, a))
}
// [`base_value`] with the type's default given (`default_value`), for a
// caller that already looked it up for the mob's type.
base_value_with :: proc(m: ^Mob, a: Attr, default: impl FnOnce() -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra
    // rust: .attributes
    // rust: .as_ref()
    // rust: .and_then(|s| s.bases.iter().find(|(x, _)| *x == a).map(|(_, v)| *v))
    // rust: .or_else(default)
    // rust: .unwrap_or(match a {
    // rust: Attr::BurningTime => 1.0,
            // The registry's default, as the type's `flying_speed` falls back to.
    // rust: Attr::FlyingSpeed => 0.4,
    // rust: _ => 0.0,
    // rust: })
}
// The transient modifiers of the mob's state (`SPEED_MODIFIER_BABY`).
transient :: proc(m: ^Mob, a: Attr) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if a != Attr::MovementSpeed || !m.is_baby() {
    // rust: return None;
}
    // rust: match m.species() {
    // rust: Species::Zombie
    // rust: | Species::Husk
    // rust: | Species::Drowned
    // rust: | Species::ZombieVillager
    // rust: | Species::ZombifiedPiglin => Some((0.5, Op::AddMultipliedBase)),
    // rust: Species::Piglin => Some((f64::from(0.2f32), Op::AddMultipliedBase)),
    // rust: _ => None,
}
}
// The attribute modifier one status effect grants (`MobEffect.addAttributeModifier`),
// scaled by the amplifier plus one; `None` when the effect does not touch `a`.
effect_modifier :: proc(effect: string, amplifier: i32, a: Attr) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let level = f64::from(amplifier + 1);
    // rust: match (effect.trim_start_matches("minecraft:"), a) {
    // rust: ("strength", Attr::AttackDamage) => Some((3.0 * level, Op::AddValue)),
    // rust: ("weakness", Attr::AttackDamage) => Some((-4.0 * level, Op::AddValue)),
    // rust: ("speed", Attr::MovementSpeed) => Some((f64::from(0.2f32) * level, Op::AddMultipliedTotal)),
    // rust: ("slowness", Attr::MovementSpeed) => {
    // rust: Some((f64::from(-0.15f32) * level, Op::AddMultipliedTotal))
}
    // rust: ("health_boost", Attr::MaxHealth) => Some((4.0 * level, Op::AddValue)),
    // rust: _ => None,
}
}
// The attribute modifiers of the mob's effects (`MobEffect.addAttributeModifier`),
// scaled by the amplifier plus one.
effect_modifiers :: proc(m: ^Mob, a: Attr) -> i {
    // Ported from Horizon
    return {}
}
    // rust: m.extra
    // rust: .effects
    // rust: .iter()
    // rust: .filter_map(move |&(effect, _, amplifier)| effect_modifier(effect, amplifier, a))
}
// `AttributeInstance.getValue`: the base, then the modifiers by operation.
value :: proc(m: ^Mob, a: Attr) -> f {
    // Ported from Horizon
    return {}
}
    // rust: compute(m, a, true, &[])
}
// `value` with more modifiers, such as the ones worn equipment grants.
value_with :: proc(m: ^Mob, a: Attr, extra: ^[(f64) {
}
    // rust: compute(m, a, true, extra)
}
compute :: proc(m: ^Mob, a: Attr, with_transient: bool, extra: ^[(f64) {
}
    // rust: let mut base = base_value(m, a);
    // rust: let empty = Vec::new();
    // rust: let mods = m.extra.attributes.as_ref().map_or(&empty, |s| &s.modifiers);
    // rust: let mut ops: Vec<(f64, Op)> = mods
    // rust: .iter()
    // rust: .filter(|x| x.attr == a)
    // rust: .map(|x| (x.amount, x.op))
    // rust: .collect();
    // rust: if with_transient {
    // rust: ops.extend(transient(m, a));
    // rust: ops.extend(effect_modifiers(m, a));
}
    // rust: ops.extend(extra.iter().copied());
    // rust: for (amount, op) in &ops {
    // rust: if *op == Op::AddValue {
    // rust: base += amount;
}
}
    // rust: let mut result = base;
    // rust: for (amount, op) in &ops {
    // rust: if *op == Op::AddMultipliedBase {
    // rust: result += base * amount;
}
}
    // rust: for (amount, op) in &ops {
    // rust: if *op == Op::AddMultipliedTotal {
    // rust: result *= 1.0 + amount;
}
}
    // rust: let (lo, hi) = a.range();
    // rust: if result.is_nan() {
    // rust: lo
    // rust: } else {
    // rust: result.clamp(lo, hi)
}
}
// Copies the attribute values into the fields the game reads.
refresh :: proc(m: ^Mob, a: Attr) {
}
    // rust: match a {
    // rust: Attr::MaxHealth => m.attrs.max_health = value(m, a) as f32,
    // rust: Attr::MovementSpeed => m.attrs.speed = base_with_modifiers(m, a),
    // rust: Attr::FollowRange => {
    // rust: m.attrs.follow_range = value(m, a);
    // rust: m.update_max_visited_nodes();
}
    // rust: Attr::AttackDamage => m.attrs.attack_damage = value(m, a) as f32,
    // rust: Attr::KnockbackResistance => m.attrs.knockback_resistance = value(m, a),
    // rust: Attr::SpawnReinforcements => m.attrs.spawn_reinforcements = value(m, a),
    // rust: Attr::JumpStrength => m.attrs.jump_strength = value(m, a),
    // rust: Attr::Armor | Attr::BurningTime | Attr::FlyingSpeed => {}
}
}
// The value without the transient baby modifier (`speed_bonus` applies
// that one to movement speed).
base_with_modifiers :: proc(m: ^Mob, a: Attr) -> f {
    // Ported from Horizon
    return {}
}
    // rust: compute(m, a, false, &[])
}
// `AttributeInstance.setBaseValue`.
set_base :: proc(m: ^Mob, a: Attr, v: f64) {
}
    // rust: let s = m.extra.attributes.get_or_insert_with(Box::default);
    // rust: match s.bases.iter_mut().find(|(x, _)| *x == a) {
    // rust: Some(b) => b.1 = v,
    // rust: None => s.bases.push((a, v)),
}
    // rust: refresh(m, a);
}
has_modifier :: proc(m: ^Mob, a: Attr, id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra
    // rust: .attributes
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.modifiers.iter().any(|x| x.attr == a && x.id == id))
}
// The amount of a permanent modifier, if the mob has it.
modifier_amount :: proc(m: ^Mob, a: Attr, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra
    // rust: .attributes
    // rust: .as_ref()
    // rust: .and_then(|s| s.modifiers.iter().find(|x| x.attr == a && x.id == id))
    // rust: .map(|x| x.amount)
}
// `addOrReplacePermanentModifier`.
    // rust: pub fn add_modifier(
    // rust: m: &mut Mob,
    // rust: a: Attr,
    // rust: id: impl Into<std::borrow::Cow<'static, str>>,
    // rust: amount: f64,
    // rust: op: Op,
    // rust: ) {
    // rust: let id = id.into();
    // rust: let s = m.extra.attributes.get_or_insert_with(Box::default);
    // rust: let new = Modifier {
    // rust: attr: a,
    // rust: id: id.clone(),
    // rust: amount,
    // rust: op,
}
    // rust: match s.modifiers.iter_mut().find(|x| x.attr == a && x.id == id) {
    // rust: Some(x) => *x = new,
    // rust: None => s.modifiers.push(new),
}
    // rust: refresh(m, a);
}
// `AttributeInstance.removeModifier`.
remove_modifier :: proc(m: ^Mob, a: Attr, id: string) {
}
    // rust: if let Some(s) = m.extra.attributes.as_mut() {
    // rust: s.modifiers.retain(|x| x.attr != a || x.id != id);
}
    // rust: refresh(m, a);
}
// `Mob.finalizeSpawn`, which every mob's own `finalizeSpawn` reaches
// through `super`: the `random_spawn_bonus` follow range modifier (once)
// and `setLeftHanded(nextFloat() < 0.05F)`.
mob_spawn :: proc(m: ^Mob, random: ^impl RandomSource) {
}
    // rust: if !has_modifier(m, Attr::FollowRange, "minecraft:random_spawn_bonus") {
    // rust: let bonus = random.triangle(0.0, 0.114_850_000_000_000_01);
    // rust: add_modifier(
    // rust: m,
    // rust: Attr::FollowRange,
    // rust: "minecraft:random_spawn_bonus",
    // rust: bonus,
    // rust: Op::AddMultipliedBase,
    // rust: );
}
    // rust: m.extra.left_handed = random.next_float() < 0.05;
}
// `Zombie.handleAttributes`, from the zombie's own random.
zombie_attributes :: proc(m: ^Mob, special: f32, reason: Reason) {
}
    // rust: let r = &mut m.random;
    // rust: let reinforcements = if m.kind.species == Species::ZombifiedPiglin {
    // rust: 0.0
    // rust: } else {
    // rust: r.next_double() * f64::from(0.1f32)
}
    // rust: let knockback = r.next_double() * f64::from(0.05f32);
    // rust: let follow = r.next_double() * 1.5 * f64::from(special);
    // rust: let leader = r.next_float() < special * 0.05;
    // rust: let leader_rolls = leader.then(|| (r.next_double() * 0.25 + 0.5, r.next_double() * 3.0 + 1.0));
    // rust: set_base(m, Attr::SpawnReinforcements, reinforcements);
    // rust: add_modifier(
    // rust: m,
    // rust: Attr::KnockbackResistance,
    // rust: "minecraft:random_spawn_bonus",
    // rust: knockback,
    // rust: Op::AddValue,
    // rust: );
    // rust: if follow > 1.0 {
    // rust: add_modifier(
    // rust: m,
    // rust: Attr::FollowRange,
    // rust: "minecraft:zombie_random_spawn_bonus",
    // rust: follow,
    // rust: Op::AddMultipliedTotal,
    // rust: );
}
    // rust: if let Some((reinforce, health)) = leader_rolls {
    // rust: add_modifier(
    // rust: m,
    // rust: Attr::SpawnReinforcements,
    // rust: "minecraft:leader_zombie_bonus",
    // rust: reinforce,
    // rust: Op::AddValue,
    // rust: );
    // rust: add_modifier(
    // rust: m,
    // rust: Attr::MaxHealth,
    // rust: "minecraft:leader_zombie_bonus",
    // rust: health,
    // rust: Op::AddMultipliedTotal,
    // rust: );
    // rust: if !matches!(
    // rust: reason,
    // rust: Reason::Conversion | Reason::Load | Reason::DimensionTravel
    // rust: ) {
    // rust: m.health = max_health(m);
}
    // rust: super::doors::set_can_break_doors(m, true);
}
}
max_health :: proc(m: ^Mob) -> f {
    // Ported from Horizon
    return {}
}
    // rust: value(m, Attr::MaxHealth) as f32
}

// ---- species facts --------------------------------------------------------

// `AgeableMob` subclasses.
ageable :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
//     use Species as S;
    // rust: matches!(
    // rust: s,
    // rust: S::Pig
    // rust: | S::Cow
    // rust: | S::Mooshroom
    // rust: | S::Sheep
    // rust: | S::Chicken
    // rust: | S::Rabbit
    // rust: | S::Horse
    // rust: | S::Donkey
    // rust: | S::Mule
    // rust: | S::Llama
    // rust: | S::TraderLlama
    // rust: | S::Goat
    // rust: | S::Panda
    // rust: | S::PolarBear
    // rust: | S::Fox
    // rust: | S::Wolf
    // rust: | S::Cat
    // rust: | S::Ocelot
    // rust: | S::Parrot
    // rust: | S::Bee
    // rust: | S::Turtle
    // rust: | S::Armadillo
    // rust: | S::Frog
    // rust: | S::Axolotl
    // rust: | S::Squid
    // rust: | S::GlowSquid
    // rust: | S::Dolphin
    // rust: | S::Villager
    // rust: | S::WanderingTrader
    // rust: | S::Slime
    // rust: | S::MagmaCube
    // rust: | S::SulfurCube
    // rust: | S::Hoglin
    // rust: | S::Strider
    // rust: | S::Camel
    // rust: | S::CamelHusk
    // rust: | S::Sniffer
    // rust: | S::HappyGhast
    // rust: | S::Nautilus
    // rust: | S::ZombieNautilus
    // rust: | S::ZombieHorse
    // rust: | S::SkeletonHorse
    // rust: )
}
zombie :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Zombie
    // rust: | Species::Husk
    // rust: | Species::Drowned
    // rust: | Species::ZombieVillager
    // rust: | Species::ZombifiedPiglin
    // rust: )
}
skeleton :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Skeleton
    // rust: | Species::Stray
    // rust: | Species::Bogged
    // rust: | Species::Parched
    // rust: | Species::WitherSkeleton
    // rust: )
}
raider :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: super::raider::is_raider(s)
}
// `EntityType.isAllowedInPeaceful`: the types built with `notInPeaceful`.
allowed_in_peaceful :: proc(kind: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !matches!(
    // rust: kind.strip_prefix("minecraft:").unwrap_or(kind),
    // rust: "blaze"
    // rust: | "bogged"
    // rust: | "breeze"
    // rust: | "cave_spider"
    // rust: | "creaking"
    // rust: | "creeper"
    // rust: | "drowned"
    // rust: | "elder_guardian"
    // rust: | "enderman"
    // rust: | "endermite"
    // rust: | "evoker"
    // rust: | "ghast"
    // rust: | "giant"
    // rust: | "guardian"
    // rust: | "hoglin"
    // rust: | "husk"
    // rust: | "illusioner"
    // rust: | "magma_cube"
    // rust: | "parched"
    // rust: | "phantom"
    // rust: | "piglin_brute"
    // rust: | "pillager"
    // rust: | "ravager"
    // rust: | "silverfish"
    // rust: | "skeleton"
    // rust: | "slime"
    // rust: | "spider"
    // rust: | "stray"
    // rust: | "vex"
    // rust: | "vindicator"
    // rust: | "warden"
    // rust: | "witch"
    // rust: | "wither"
    // rust: | "wither_skeleton"
    // rust: | "zoglin"
    // rust: | "zombie"
    // rust: | "zombie_villager"
    // rust: | "zombified_piglin"
    // rust: )
}
// `AgeableMob.getBabyStartAge` (a sniffer's is -48000).
baby_start_age :: proc(s: Species) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if s == Species::Sniffer {
    // rust: super::sniffer::BABY_START_AGE
    // rust: } else {
    // rust: -24000
}
}
// The age a non-ageable baby (zombies, piglins, zoglins) keeps.
NON_AGEABLE_BABY :: i32::MIN / 2

// `AgeableMob.setAge`, with each class's `ageBoundaryReached`.
set_age :: proc(m: ^Mob, age: i32) {
}
    // rust: let old = m.extra.age;
    // rust: m.extra.age = age;
    // rust: if (old < 0) != (age < 0) {
    // rust: age_boundary_reached(m);
}
}
age_boundary_reached :: proc(m: ^Mob) {
}
    // rust: let baby = m.is_baby();
    // rust: match m.species() {
    // rust: Species::Goat => set_base(m, Attr::AttackDamage, if baby { 1.0 } else { 2.0 }),
    // rust: Species::Hoglin => set_base(m, Attr::AttackDamage, if baby { 0.5 } else { 6.0 }),
    // rust: Species::SulfurCube if !baby => sulfur_size(m, 2),
        // HappyGhast.ageBoundaryReached: adultGhastSetup or babyGhastSetup,
        // then Animal's no-op. A hatched ghastling needs it before it is in
        // the level (DriedGhastBlock.spawnGhastling sets the baby age before
        // addFreshEntity), or its first tick flies the adult goals.
    // rust: Species::HappyGhast => super::happy_ghast::ensure_setup(m),
    // rust: _ => {}
}
}
// `Goat.finalizeSpawn` on a natural spawn (the spawn path in spawning.rs): the ram
// cooldowns (`GoatAi.initMemories`), screaming 2 percent of the time and a
// horn lost 10 percent of the time, adults only.
goat_spawn :: proc(m: ^Mob) {
}
    // rust: let jump = m
    // rust: .random
    // rust: .next_int_between_inclusive(600, 1200)
    // rust: .unwrap_or(600);
    // rust: set_memory(m, "long_jump_cooling_down", i64::from(jump), i64::MAX);
    // rust: let ram = m
    // rust: .random
    // rust: .next_int_between_inclusive(600, 6000)
    // rust: .unwrap_or(600);
    // rust: set_memory(m, "ram_cooldown_ticks", i64::from(ram), i64::MAX);
    // rust: m.extra.screaming = m.random.next_double() < 0.02;
    // rust: age_boundary_reached(m);
    // rust: if !m.is_baby() && m.random.next_float() < 0.1 {
    // rust: let left = m.random.next_boolean();
    // rust: m.extra.lost_horns[usize::from(!left)] = true;
}
}
// `SpawnEggItem.spawnsEntity`: the spawn egg is for the mob's own kind, so
// it is used on it (`Mob.checkAndHandleImportantInteractions`).
spawn_egg_is_for :: proc(egg: string, kind: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: egg.strip_suffix("_spawn_egg") == Some(kind)
}

// `SpawnEggItem.spawnOffspringFromSpawnEgg`: the offspring of a spawn egg
// used on a mob of the same kind is a baby of that kind: it starts with
// the age of a baby and keeps the parent's variant and colour.
spawn_egg_offspring :: proc(child: ^Mob, species: Species, variant: u8, color: u8) {
}
    // rust: set_baby(child, true);
    // rust: child.extra.variant = variant;
    // rust: if species == Species::Sheep {
    // rust: child.extra.color = color;
}
    // `SulfurCube.getBreedOffspring`: `setSize(1, true)`.
    // rust: if species == Species::SulfurCube {
    // rust: sulfur_size(child, 1);
}
}
// `setBaby`: AgeableMob through its age, zombies, piglins and zoglins.
set_baby :: proc(m: ^Mob, baby: bool) {
}
    // rust: let s = m.species();
    // rust: if ageable(s) {
    // rust: set_age(m, if baby { baby_start_age(s) } else { 0 });
    // rust: return;
}
    // rust: match s {
    // rust: _ if zombie(s) || s == Species::Piglin => {
    // rust: m.extra.age = if baby { NON_AGEABLE_BABY } else { 0 };
}
    // rust: Species::Zoglin => {
    // rust: m.extra.age = if baby { NON_AGEABLE_BABY } else { 0 };
    // rust: if baby {
    // rust: set_base(m, Attr::AttackDamage, 0.5);
}
}
    // rust: _ => {}
}
}

// ---- equipment ------------------------------------------------------------

// `EquipmentSlot` names (the `drops::SLOTS` order).
SLOT_NAMES :: super::drops::SLOTS
MAINHAND :: 0
OFFHAND :: 1
FEET :: 2
LEGS :: 3
CHEST :: 4
HEAD :: 5
SADDLE :: 7
// The `gear` slot of an `EquipmentSlot`.
gear_slot :: proc(slot: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match slot {
    // rust: MAINHAND => gear::MAIN,
    // rust: OFFHAND => gear::OFF,
    // rust: FEET => gear::FEET,
    // rust: LEGS => gear::LEGS,
    // rust: CHEST => gear::CHEST,
    // rust: _ => gear::HEAD,
}
}
item :: proc(m: ^Mob, slot: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match slot {
    // rust: MAINHAND => m.extra.main_hand.clone(),
    // rust: OFFHAND => m.extra.off_hand.clone(),
    // rust: FEET => m.extra.feet.clone(),
    // rust: LEGS => m.extra.legs.clone(),
    // rust: CHEST => m.extra.chest.clone(),
    // rust: HEAD => m.extra.head.clone(),
    // rust: SADDLE => m.extra.saddled.then(|| Arc::from("minecraft:saddle")),
    // rust: _ => None,
}
}
// The whole stack a mob keeps in `slot` (damage, name, components, count,
// enchantments and trim), when it kept more than the item id.
stored_stack :: proc(m: ^Mob, slot: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = item(m, slot)?;
    // rust: let index = gear_slot(slot);
    // rust: let mut stack = if slot == MAINHAND {
    // rust: m.extra.main_hand_stack()?.clone()
    // rust: } else {
    // rust: gear::gear(m)?.stacks[index]
    // rust: .clone()
    // rust: .filter(|s| s.item == id)?
}
    // rust: if let Some(g) = gear::gear(m) {
    // rust: if !g.slots[index].is_empty() {
    // rust: stack.data_mut().enchantments = g.slots[index].clone();
}
    // rust: if g.trims[index].is_some() {
    // rust: stack.data_mut().trim = g.trims[index].clone();
}
}
    // rust: Some(stack)
}
// What a mob has in `slot` as a stack: the one it kept, else one item with
// its enchantments.
item_stack :: proc(m: ^Mob, slot: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: stored_stack(m, slot).or_else(|| {
    // rust: let mut stack = crate::items::ItemStack::new(&item(m, slot)?, 1);
    // rust: stack.set_crafting_enchantments(slot_enchantments(m, slot));
    // rust: Some(stack)
    // rust: })
}
// `setItemSlot` with the whole `stack`: its enchantments, trim, damage, name
// and count stay with the mob.
set_item_stack :: proc(m: ^Mob, slot: uint, stack: crate::items::ItemStack) {
}
    // rust: set_item(m, slot, &stack.item);
    // rust: set_slot_enchantments(m, slot, stack.enchantments().to_vec());
    // rust: if slot == MAINHAND {
    // rust: m.extra.set_main_hand_stack(Some(stack));
    // rust: } else if slot <= HEAD {
    // rust: gear::set_stack(m, gear_slot(slot), stack);
}
}
// `setItemSlot` with a fresh stack (enchantments cleared).
set_item :: proc(m: ^Mob, slot: uint, id: string) {
}
    // rust: let v = Some(Arc::from(id));
    // rust: match slot {
    // rust: MAINHAND => m.extra.set_main_hand(v),
    // rust: OFFHAND => m.extra.off_hand = v,
    // rust: FEET => m.extra.feet = v,
    // rust: LEGS => m.extra.legs = v,
    // rust: CHEST => m.extra.chest = v,
    // rust: HEAD => m.extra.head = v,
    // rust: SADDLE => {
    // rust: m.extra.saddled = true;
    // rust: m.extra.saddle_stack = None;
    // rust: return;
}
    // rust: _ => return,
}
    // rust: gear::set(m, gear_slot(slot), Vec::new());
}
// The enchantments on what `m` has in `slot`.
slot_enchantments :: proc(m: ^Mob, slot: uint) -> g {
    // Ported from Horizon
    return {}
}
    // rust: gear::gear(m).map_or_else(Vec::new, |g| g.slots[gear_slot(slot)].clone())
}
// Replace the enchantments of what `m` has in `slot` (after `set_item`).
set_slot_enchantments :: proc(m: ^Mob, slot: uint, levels: gear::Levels) {
}
    // rust: gear::set(m, gear_slot(slot), levels);
}
// `EquipmentUser.equip` for one rolled stack: `setItemSlot` puts the item in
// `slot` with its own enchantments and trim (set_components), then the
// slot's drop chance is stored when the table names one.
    // rust: pub fn equip_stack(
    // rust: m: &mut Mob,
    // rust: slot: usize,
    // rust: stack: &horizon_world::loot::LootStack,
    // rust: drop_chance: Option<f32>,
    // rust: ) {
    // rust: set_item(m, slot, &stack.item);
    // rust: if slot <= HEAD {
    // rust: let levels = stack
    // rust: .enchantments
    // rust: .iter()
    // rust: .map(|(id, level)| (Arc::from(id.as_str()), (*level).max(0) as u32))
    // rust: .collect();
    // rust: gear::set(m, gear_slot(slot), levels);
    // rust: let trim = stack
    // rust: .components
    // rust: .iter()
    // rust: .find(|(id, _)| id == "minecraft:trim")
    // rust: .and_then(|(_, v)| {
    // rust: Some((
    // rust: Arc::from(v["material"].as_str()?),
    // rust: Arc::from(v["pattern"].as_str()?),
    // rust: ))
    // rust: });
    // rust: gear::set_trim(m, gear_slot(slot), trim);
}
    // rust: if let Some(chance) = drop_chance {
    // rust: set_drop_chance(m, slot, chance);
}
}
// `Mob.setDropChance`.
set_drop_chance :: proc(m: ^Mob, slot: uint, chance: f32) {
}
    // rust: let c = m
    // rust: .extra
    // rust: .drop_chances
    // rust: .get_or_insert_with(|| Box::new([super::drops::DEFAULT_DROP_CHANCE; 8]));
    // rust: c[slot] = chance;
}
// The drop chance stored for a slot (`DropChances.byEquipment`).
stored_drop_chance :: proc(m: ^Mob, slot: uint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: m.extra
    // rust: .drop_chances
    // rust: .as_ref()
    // rust: .map_or(super::drops::DEFAULT_DROP_CHANCE, |c| c[slot])
}

// `SpecialDates.isHalloween`: October 31.
halloween_date :: proc(month: u32, day: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (month, day) == (10, 31)
}

// `SpecialDates.isHalloween` from the local calendar.
is_halloween :: proc() -> b {
    // Ported from Horizon
    return {}
}
//     use chrono::Datelike;
    // rust: let today = chrono::Local::now();
    // rust: halloween_date(today.month(), today.day())
}

// `Zombie` / `AbstractSkeleton` halloween pumpkin: 25% of empty heads, 10%
// of those a jack o'lantern, drop chance 0.
halloween_head :: proc(m: ^Mob, random: ^impl RandomSource, halloween: bool) {
}
    // rust: if !(zombie(m.species()) || skeleton(m.species())) {
    // rust: return;
}
    // rust: if m.extra.head.is_none() && halloween && random.next_float() < 0.25 {
    // rust: let head = if random.next_float() < 0.1 {
    // rust: "minecraft:jack_o_lantern"
    // rust: } else {
    // rust: "minecraft:carved_pumpkin"
}
    // rust: set_item(m, HEAD, head);
    // rust: set_drop_chance(m, HEAD, 0.0);
}
}

    // rust: impl<L: FinalizeLevel + ?Sized, R: RandomSource> Ctx<'_, L, R> {
float :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.random.next_float()
}
int :: proc(self: ^Self, bound: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.random.next_int_bound(bound).unwrap_or(0)
}
special :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.difficulty.special()
}
    // `UniformInt.sample`.
uniform :: proc(self: ^Self, min: i32, max: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.random
    // rust: .next_int_between_inclusive(min, max)
    // rust: .unwrap_or(min)
}

    // ---- Mob ----------------------------------------------------------

    // `Mob.finalizeSpawn`: the follow range spawn bonus and left-handedness.
mob :: proc(self: ^Self, m: ^Mob, g: Maybe(Group)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: mob_spawn(m, self.random);
    // rust: g
}
    // `AgeableMob.finalizeSpawn`.
ageable :: proc(self: ^Self, m: ^Mob, g: Maybe(Group)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut g = g.unwrap_or(Group::Ageable(Ageable::babies(true)));
    // rust: if let Some(a) = g.ageable() {
    // rust: let (should, size, chance) = (a.should_spawn_baby, a.size, a.baby_chance);
    // rust: if should && size > 0 && self.float() <= chance {
    // rust: let start = baby_start_age(m.species());
    // rust: set_age(m, start);
}
    // rust: if let Some(a) = g.ageable() {
    // rust: a.size += 1;
}
}
    // rust: self.mob(m, Some(g))
}
    // `Mob.populateDefaultEquipmentSlots`: a set of armour from the head
    // down, of one material.
armor :: proc(self: ^Self, m: ^Mob) {
}
    // rust: if self.float() >= 0.15 * self.special() {
    // rust: return;
}
    // rust: let mut kind = self.int(3);
    // rust: for _ in 1..=3 {
    // rust: if self.float() < 0.1087 {
    // rust: kind += 1;
}
}
    // rust: let partial = if self.difficulty.hard { 0.1 } else { 0.25 };
    // rust: const MATERIAL: [&str; 6] = [
    // rust: "leather",
    // rust: "copper",
    // rust: "golden",
    // rust: "chainmail",
    // rust: "iron",
    // rust: "diamond",
    // rust: ];
    // rust: let mut first = true;
        // EQUIPMENT_POPULATION_ORDER: head, chest, legs, feet.
    // rust: for (slot, piece) in [
    // rust: (HEAD, "helmet"),
    // rust: (CHEST, "chestplate"),
    // rust: (LEGS, "leggings"),
    // rust: (FEET, "boots"),
    // rust: ] {
    // rust: if !first && self.float() < partial {
    // rust: break;
}
    // rust: first = false;
    // rust: if item(m, slot).is_none()
    // rust: && let Some(material) = MATERIAL.get(kind as usize)
    // rust: {
    // rust: set_item(m, slot, &format!("minecraft:{material}_{piece}"));
}
}
}
    // `populateDefaultEquipmentSlots` of each class.
populate :: proc(self: ^Self, m: ^Mob) {
}
//         use Species as S;
    // rust: match m.species() {
    // rust: S::Zombie | S::Husk | S::ZombieVillager => {
    // rust: self.armor(m);
    // rust: let chance = if self.difficulty.hard { 0.05 } else { 0.01 };
    // rust: if self.float() < chance {
    // rust: let weapon = match self.int(6) {
    // rust: 0 => "minecraft:iron_sword",
    // rust: 1 => "minecraft:iron_spear",
    // rust: _ => "minecraft:iron_shovel",
}
    // rust: set_item(m, MAINHAND, weapon);
}
}
    // rust: S::Drowned => {
    // rust: if f64::from(self.float()) > 0.9 {
    // rust: let weapon = if self.int(16) < 10 {
    // rust: "minecraft:trident"
    // rust: } else {
    // rust: "minecraft:fishing_rod"
}
    // rust: set_item(m, MAINHAND, weapon);
}
}
    // rust: S::ZombifiedPiglin => {
    // rust: let weapon = if self.int(20) == 0 {
    // rust: "minecraft:golden_spear"
    // rust: } else {
    // rust: "minecraft:golden_sword"
}
    // rust: set_item(m, MAINHAND, weapon);
}
    // rust: S::WitherSkeleton => set_item(m, MAINHAND, "minecraft:stone_sword"),
    // rust: s if skeleton(s) => {
    // rust: self.armor(m);
    // rust: set_item(m, MAINHAND, "minecraft:bow");
}
    // rust: S::Pillager => set_item(m, MAINHAND, "minecraft:crossbow"),
    // rust: S::Vindicator => {
    // rust: if super::raider::state(m).is_none_or(|s| s.raid_id.is_none()) {
    // rust: set_item(m, MAINHAND, "minecraft:iron_axe");
}
}
    // rust: S::Piglin => {
    // rust: if !m.is_baby() {
    // rust: for (slot, piece) in [
    // rust: (HEAD, "helmet"),
    // rust: (CHEST, "chestplate"),
    // rust: (LEGS, "leggings"),
    // rust: (FEET, "boots"),
    // rust: ] {
    // rust: if self.float() < 0.1 {
    // rust: set_item(m, slot, &format!("minecraft:golden_{piece}"));
}
}
}
}
    // rust: S::PiglinBrute => set_item(m, MAINHAND, "minecraft:golden_axe"),
    // rust: S::Vex => {
    // rust: set_item(m, MAINHAND, "minecraft:iron_sword");
    // rust: set_drop_chance(m, MAINHAND, 0.0);
}
    // rust: S::Fox => {
    // rust: if self.float() < 0.2 {
    // rust: let odds = self.float();
    // rust: let held = if odds < 0.05 {
    // rust: "minecraft:emerald"
    // rust: } else if odds < 0.2 {
    // rust: "minecraft:egg"
    // rust: } else if odds < 0.4 {
    // rust: if self.random.next_boolean() {
    // rust: "minecraft:rabbit_foot"
    // rust: } else {
    // rust: "minecraft:rabbit_hide"
}
    // rust: } else if odds < 0.6 {
    // rust: "minecraft:wheat"
    // rust: } else if odds < 0.8 {
    // rust: "minecraft:leather"
    // rust: } else {
    // rust: "minecraft:feather"
}
    // rust: set_item(m, MAINHAND, held);
}
}
    // rust: _ => self.armor(m),
}
}
    // `Mob.populateDefaultEquipmentEnchantments`: the weapon one time in
    // four and each piece of armour one time in two, scaled by the local
    // difficulty, through the `mob_spawn_equipment` provider.
enchant :: proc(self: ^Self, m: ^Mob) {
}
    // rust: if m.species() == Species::WitherSkeleton {
    // rust: return;
}
    // rust: self.enchant_slot(m, MAINHAND, 0.25);
        // Pillager.enchantSpawnedWeapon: one crossbow in 300 pierces
        // (`pillager_spawn_crossbow`).
    // rust: if m.species() == Species::Pillager
    // rust: && self.int(300) == 0
    // rust: && item(m, MAINHAND).as_deref() == Some("minecraft:crossbow")
    // rust: {
    // rust: gear::upgrade(m, gear::MAIN, "minecraft:piercing", 1);
}
        // EquipmentSlot.VALUES order: feet, legs, chest, head.
    // rust: for slot in [FEET, LEGS, CHEST, HEAD] {
    // rust: self.enchant_slot(m, slot, 0.5);
}
}
enchant_slot :: proc(self: ^Self, m: ^Mob, slot: uint, chance: f32) {
}
    // rust: let Some(id) = item(m, slot) else { return };
    // rust: if self.float() >= chance * self.special() {
    // rust: return;
}
    // rust: self.enchant_by_cost(m, slot, &id);
}
    // `EnchantmentsByCostWithDifficulty.enchant` (`mob_spawn_equipment`:
    // cost 5 to 5 + 17 x the special multiplier, `#on_mob_spawn_equipment`).
enchant_by_cost :: proc(self: ^Self, m: ^Mob, slot: uint, id: string) {
}
    // rust: let top = 5 + (self.special() * 17.0) as i32;
    // rust: let cost = self.random.next_int_between_inclusive(5, top).unwrap_or(5);
    // rust: let e = self.data.enchantments;
    // rust: let pool = e.tag("minecraft:on_mob_spawn_equipment");
    // rust: let picked = e.select(self.data.items, self.random, id, cost, pool);
    // rust: for (enchantment, level) in picked {
    // rust: gear::upgrade(m, gear_slot(slot), &enchantment, level);
}
}
halloween :: proc(self: ^Self, m: ^Mob) {
}
    // rust: halloween_head(m, self.random, self.level.halloween());
}

    // ---- jockeys ------------------------------------------------------

create :: proc(self: ^Self, kind: string, reason: Reason, at: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut j = self.level.create(kind, reason)?;
        // snapTo(x, y, z, yRot, 0).
    // rust: j.position = at.position;
    // rust: j.previous = at.position;
    // rust: j.yaw = at.yaw;
    // rust: j.previous_yaw = at.yaw;
    // rust: j.body_yaw = at.yaw;
    // rust: j.head_yaw = at.yaw;
    // rust: j.head_pitch = 0.0;
    // rust: Some(j)
}
    // `startRiding`: the rider leaves the vehicle it was on.
ride :: proc(self: ^Self, rider: ^Mob, vehicle: ^Mob) {
}
    // rust: if let Some(old) = rider.extra.mount
    // rust: && let Some(v) = self.created.iter_mut().find(|c| c.id == old)
    // rust: && v.extra.rider == Some(rider.id)
    // rust: {
    // rust: v.extra.rider = None;
}
    // rust: rider.extra.mount = Some(vehicle.id);
    // rust: rider.extra.passenger = true;
    // rust: if vehicle.extra.rider.is_none() {
    // rust: vehicle.extra.rider = Some(rider.id);
}
}

    // ---- the classes --------------------------------------------------

zombie :: proc(self: ^Self, m: ^Mob, g: Maybe(Group), reason: Reason) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut g = self.mob(m, g);
    // rust: let special = self.special();
    // rust: if reason != Reason::Conversion {
    // rust: m.extra.pick_up_loot = self.float() < 0.55 * special;
}
    // rust: if g.is_none() {
    // rust: g = Some(Group::Zombie {
    // rust: baby: self.float() < 0.05,
    // rust: jockey: true,
    // rust: husk: None,
    // rust: });
}
    // rust: if let Some(Group::Zombie { baby, jockey, .. }) = g {
    // rust: if baby {
    // rust: set_baby(m, true);
    // rust: if jockey {
    // rust: if f64::from(self.float()) < 0.05 {
    // rust: let search = m
    // rust: .bounds()
    // rust: .inflate(horizon_core::geometry::Vec3::new(5.0, 3.0, 5.0));
    // rust: if let Some(chicken) = self.level.free_chicken(search) {
    // rust: self.level.ride_chicken(chicken, m.id);
    // rust: m.extra.mount = Some(chicken);
    // rust: m.extra.passenger = true;
}
    // rust: } else if f64::from(self.float()) < 0.05
    // rust: && let Some(mut chicken) =
    // rust: self.create("minecraft:chicken", Reason::Jockey, m)
    // rust: {
    // rust: self.finalize(&mut chicken, Reason::Jockey, None);
    // rust: chicken.extra.jockey = true;
    // rust: self.ride(m, &mut chicken);
    // rust: self.jockey_rider = Some(m.clone());
    // rust: self.created.push(chicken);
}
}
}
    // rust: let can_break_doors = self.float() < special * 0.1;
    // rust: super::doors::set_can_break_doors(m, can_break_doors);
    // rust: if reason != Reason::Conversion {
    // rust: self.populate(m);
    // rust: self.enchant(m);
}
}
    // rust: self.halloween(m);
    // rust: zombie_attributes(m, special, reason);
    // rust: g
}
husk :: proc(self: ^Self, m: ^Mob, g: Maybe(Group), reason: Reason) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut g = self.zombie(m, g, reason);
    // rust: if reason != Reason::Conversion {
    // rust: m.extra.pick_up_loot = self.float() < 0.55 * self.special();
}
    // rust: if let Some(Group::Zombie { baby, jockey, .. }) = g {
    // rust: g = Some(Group::Zombie {
    // rust: baby,
    // rust: jockey,
    // rust: husk: Some(reason != Reason::Natural),
    // rust: });
}
    // rust: if let Some(Group::Zombie {
    // rust: husk: Some(tried @ false),
    // rust: ..
    // rust: }) = &mut g
    // rust: {
    // rust: let (bx, by, bz) = (
    // rust: m.position.x.floor(),
    // rust: m.position.y.floor(),
    // rust: m.position.z.floor(),
    // rust: );
    // rust: let (w, h) = self.data.camel_husk_size;
    // rust: let half = w / 2.0;
    // rust: let bounds = Aabb::new(
    // rust: horizon_core::geometry::Vec3::new(
    // rust: bx + 0.5 - f64::from(half),
    // rust: by,
    // rust: bz + 0.5 - f64::from(half),
    // rust: ),
    // rust: horizon_core::geometry::Vec3::new(
    // rust: bx + 0.5 + f64::from(half),
    // rust: by + f64::from(h),
    // rust: bz + 0.5 + f64::from(half),
    // rust: ),
    // rust: );
    // rust: if self.level.no_collision(bounds) {
    // rust: *tried = true;
    // rust: if self.float() < 0.1 {
    // rust: set_item(m, MAINHAND, "minecraft:iron_spear");
    // rust: if let Some(mut camel) =
    // rust: self.level.create("minecraft:camel_husk", Reason::Natural)
    // rust: {
                        // setPos: the husk's position, the camel's own rotation.
    // rust: camel.position = m.position;
    // rust: camel.previous = m.position;
    // rust: self.finalize(&mut camel, reason, None);
    // rust: self.ride(m, &mut camel);
    // rust: if let Some(mut parched) =
    // rust: self.create("minecraft:parched", Reason::Natural, m)
    // rust: {
    // rust: self.finalize(&mut parched, reason, None);
    // rust: self.ride(&mut parched, &mut camel);
    // rust: self.created.push(camel);
    // rust: self.created.push(parched);
    // rust: } else {
    // rust: self.created.push(camel);
}
}
}
}
}
    // rust: g
}
drowned :: proc(self: ^Self, m: ^Mob, g: Maybe(Group), reason: Reason) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let g = self.zombie(m, g, reason);
    // rust: if m.extra.off_hand.is_none() && self.float() < 0.03 {
    // rust: set_item(m, OFFHAND, "minecraft:nautilus_shell");
    // rust: set_drop_chance(m, OFFHAND, 2.0);
}
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: if matches!(reason, Reason::Natural | Reason::Structure)
    // rust: && m.extra.main_hand.as_deref() == Some("minecraft:trident")
    // rust: && self.float() < 0.5
    // rust: && !m.is_baby()
    // rust: && !self
    // rust: .level
    // rust: .biome_tag("minecraft:more_frequent_drowned_spawns", at)
    // rust: && let Some(mut nautilus) = self.create("minecraft:zombie_nautilus", Reason::Jockey, m)
    // rust: {
    // rust: if reason == Reason::Structure {
    // rust: nautilus.persistent = true;
}
    // rust: self.finalize(&mut nautilus, reason, None);
    // rust: self.ride(m, &mut nautilus);
    // rust: self.created.push(nautilus);
}
    // rust: g
}
skeleton :: proc(self: ^Self, m: ^Mob, g: Maybe(Group)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let g = self.mob(m, g);
    // rust: self.populate(m);
    // rust: self.enchant(m);
    // rust: m.extra.pick_up_loot = self.float() < 0.55 * self.special();
    // rust: self.halloween(m);
    // rust: if m.species() == Species::WitherSkeleton {
    // rust: set_base(m, Attr::AttackDamage, 4.0);
}
    // rust: g
}
spider :: proc(self: ^Self, m: ^Mob, g: Maybe(Group), reason: Reason) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut g = self.mob(m, g);
    // rust: if self.int(100) == 0
    // rust: && let Some(mut skeleton) = self.create("minecraft:skeleton", Reason::Jockey, m)
    // rust: {
    // rust: self.finalize(&mut skeleton, reason, None);
    // rust: self.ride(&mut skeleton, m);
    // rust: self.created.push(skeleton);
}
    // rust: if g.is_none() {
    // rust: let mut effect = None;
    // rust: if self.difficulty.hard && self.float() < 0.1 * self.special() {
    // rust: effect = Some(match self.int(5) {
    // rust: 0 | 1 => "minecraft:speed",
    // rust: 2 => "minecraft:strength",
    // rust: 3 => "minecraft:regeneration",
    // rust: _ => "minecraft:invisibility",
    // rust: });
}
    // rust: g = Some(Group::Spider(effect));
}
    // rust: if let Some(Group::Spider(Some(effect))) = g {
    // rust: m.add_effect(effect, -1, 0);
}
    // rust: g
}
    // `Raider` then `PatrollingMonster.finalizeSpawn`.
raider :: proc(self: ^Self, m: ^Mob, g: Maybe(Group), reason: Reason) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let witch = m.species() == Species::Witch;
    // rust: super::raider::state_mut(m).can_join_raid = !witch || reason != Reason::Natural;
    // rust: if !matches!(reason, Reason::Patrol | Reason::Event | Reason::Structure)
    // rust: && self.float() < 0.06
    // rust: && super::raider::can_be_leader(m.species())
    // rust: {
    // rust: super::raider::state_mut(m).patrol_leader = true;
}
    // rust: if super::raider::state(m).is_some_and(|s| s.patrol_leader) {
    // rust: set_item(m, HEAD, super::raider::BANNER);
    // rust: set_drop_chance(m, HEAD, 2.0);
}
    // rust: if reason == Reason::Patrol {
    // rust: super::raider::state_mut(m).patrolling = true;
}
    // rust: self.mob(m, g)
}
piglin :: proc(self: ^Self, m: ^Mob, g: Maybe(Group), reason: Reason) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if reason != Reason::Structure {
    // rust: if self.float() < 0.2 {
    // rust: set_baby(m, true);
    // rust: } else if !m.is_baby() {
                // createSpawnWeapon, from the piglin's own random.
    // rust: let r = &mut m.random;
    // rust: let weapon = if f64::from(r.next_float()) < 0.5 {
    // rust: "minecraft:crossbow"
    // rust: } else if r.next_int_bound(10).unwrap_or(1) == 0 {
    // rust: "minecraft:golden_spear"
    // rust: } else {
    // rust: "minecraft:golden_sword"
}
    // rust: set_item(m, MAINHAND, weapon);
}
}
        // PiglinAi.initMemories: HUNTED_RECENTLY for 30 to 120 seconds.
    // rust: let hunt = self.uniform(600, 2400);
    // rust: set_memory(m, "hunted_recently", 1, i64::from(hunt));
    // rust: self.populate(m);
    // rust: self.enchant(m);
    // rust: self.mob(m, g)
}
strider :: proc(self: ^Self, m: ^Mob, g: Maybe(Group)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if m.is_baby() {
    // rust: return self.ageable(m, g);
}
    // rust: let mut g = g;
    // rust: if self.int(30) == 0 && self.level.spawning_monsters() {
    // rust: if let Some(mut jockey) = self.create("minecraft:zombified_piglin", Reason::Jockey, m) {
    // rust: let baby = self.float() < 0.05;
    // rust: g = Some(self.strider_jockey(
    // rust: m,
    // rust: &mut jockey,
    // rust: Some(Group::Zombie {
    // rust: baby,
    // rust: jockey: false,
    // rust: husk: None,
    // rust: }),
    // rust: ));
    // rust: set_item(&mut jockey, MAINHAND, "minecraft:warped_fungus_on_a_stick");
    // rust: set_item(m, SADDLE, "minecraft:saddle");
    // rust: set_drop_chance(m, SADDLE, 2.0);
    // rust: self.created.push(jockey);
}
    // rust: } else if self.int(10) == 0 {
    // rust: if let Some(mut jockey) = self.create("minecraft:strider", Reason::Jockey, m) {
    // rust: set_age(&mut jockey, -24000);
    // rust: g = Some(self.strider_jockey(m, &mut jockey, None));
    // rust: self.created.push(jockey);
}
    // rust: } else {
    // rust: g = Some(Group::Ageable(Ageable::chance(0.5)));
}
    // rust: self.ageable(m, g)
}
    // `Strider.spawnJockey`.
strider_jockey :: proc(self: ^Self, m: ^Mob, jockey: ^Mob, g: Maybe(Group)) -> G {
    // Ported from Horizon
    return {}
}
    // rust: jockey.position = m.position;
    // rust: jockey.yaw = m.yaw;
    // rust: self.finalize(jockey, Reason::Jockey, g);
    // rust: self.ride(jockey, m);
    // rust: Group::Ageable(Ageable::chance(0.0))
}
    // `AbstractHorse.finalizeSpawn` with each `randomizeAttributes`.
horse :: proc(self: ^Self, m: ^Mob, g: Maybe(Group)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let g = g.or(Some(Group::Ageable(Ageable::chance(0.2))));
//         use Species as S;
    // rust: match m.species() {
    // rust: S::Horse => {
    // rust: let health = self.horse_health();
    // rust: set_base(m, Attr::MaxHealth, f64::from(health));
    // rust: let speed = self.horse_speed();
    // rust: set_base(m, Attr::MovementSpeed, speed);
    // rust: let jump = self.horse_jump();
    // rust: set_base(m, Attr::JumpStrength, jump);
}
    // rust: S::Donkey | S::Mule | S::Llama | S::TraderLlama => {
    // rust: let health = self.horse_health();
    // rust: set_base(m, Attr::MaxHealth, f64::from(health));
}
    // rust: S::SkeletonHorse => {
    // rust: let jump = self.horse_jump();
    // rust: set_base(m, Attr::JumpStrength, jump);
}
    // rust: S::ZombieHorse => {
    // rust: let d = 0.066_666_666_666_666_67;
    // rust: let jump = 0.5
    // rust: + self.random.next_double() * d
    // rust: + self.random.next_double() * d
    // rust: + self.random.next_double() * d;
    // rust: set_base(m, Attr::JumpStrength, jump);
    // rust: let speed = (9.0
    // rust: + self.random.next_double()
    // rust: + self.random.next_double()
    // rust: + self.random.next_double())
    // rust: / f64::from(42.16f32);
    // rust: set_base(m, Attr::MovementSpeed, speed);
}
    // rust: _ => {}
}
    // rust: self.ageable(m, g)
}
horse_health :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 15.0 + self.int(8) as f32 + self.int(9) as f32
}
horse_speed :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (f64::from(0.45f32)
    // rust: + self.random.next_double() * 0.3
    // rust: + self.random.next_double() * 0.3
    // rust: + self.random.next_double() * 0.3)
    // rust: * 0.25
}
horse_jump :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(0.4f32)
    // rust: + self.random.next_double() * 0.2
    // rust: + self.random.next_double() * 0.2
    // rust: + self.random.next_double() * 0.2
}
villager_type :: proc(self: ^Self, m: ^Mob) {
}
    // rust: let at = block(m);
    // rust: m.extra.variant = villager_type(&self.level.biome(at));
}
    // `VariantUtils.selectVariantToSpawn` into `variant`, by registry name.
variant :: proc(self: ^Self, m: ^Mob, registry: fn(^SpawnRegistries) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let r = registry(self.data.registries);
    // rust: let at = block(m);
    // rust: if let Some(i) = r.select(&*self.level, at, self.random) {
    // rust: let name = r.names[i].clone();
    // rust: m.extra.variant = variant_index(m.species(), &name);
}
}
sound :: proc(self: ^Self, m: ^Mob, registry: fn(^SpawnRegistries) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let r = registry(self.data.registries);
    // rust: m.extra.sound_variant = Some(r.random(self.random) as u8);
}

    // `finalizeSpawn` of the mob's class.
finalize :: proc(self: ^Self, m: ^Mob, reason: Reason, g: Maybe(Group)) -> O {
    // Ported from Horizon
    return {}
}
//         use Species as S;
    // rust: let s = m.species();
    // rust: match s {
    // rust: S::Pig | S::Cow | S::Chicken => {
    // rust: let (v, sound): (
    // rust: fn(&SpawnRegistries) -> &VariantRegistry,
    // rust: fn(&SpawnRegistries) -> &VariantRegistry,
    // rust: ) = match s {
    // rust: S::Pig => (|r| &r.pig, |r| &r.pig_sound),
    // rust: S::Cow => (|r| &r.cow, |r| &r.cow_sound),
    // rust: _ => (|r| &r.chicken, |r| &r.chicken_sound),
}
    // rust: self.variant(m, v);
    // rust: self.sound(m, sound);
    // rust: self.ageable(m, g)
}
    // rust: S::Cat => {
    // rust: let g = self.ageable(m, g);
    // rust: self.variant(m, |r| &r.cat);
    // rust: self.sound(m, |r| &r.cat_sound);
    // rust: g
}
    // rust: S::Wolf => {
    // rust: let g = match g {
    // rust: Some(Group::Wolf(a, v)) => {
    // rust: m.extra.variant = v;
    // rust: Some(Group::Wolf(a, v))
}
    // rust: other => {
    // rust: let r = &self.data.registries.wolf;
    // rust: let at = block(m);
    // rust: match r.select(&*self.level, at, self.random) {
    // rust: Some(i) => {
    // rust: let v = variant_index(s, &r.names[i]);
    // rust: m.extra.variant = v;
    // rust: Some(Group::Wolf(Ageable::babies(false), v))
}
    // rust: None => other,
}
}
}
    // rust: self.sound(m, |r| &r.wolf_sound);
    // rust: self.ageable(m, g)
}
    // rust: S::Frog => {
    // rust: self.variant(m, |r| &r.frog);
    // rust: let jump = self.uniform(100, 140);
    // rust: set_memory(m, "long_jump_cooling_down", i64::from(jump), i64::MAX);
    // rust: self.ageable(m, g)
}
    // rust: S::ZombieNautilus => {
    // rust: self.variant(m, |r| &r.zombie_nautilus);
    // rust: let cooldown = self.uniform(2400, 3600);
    // rust: set_memory(m, "attack_target_cooldown", i64::from(cooldown), i64::MAX);
    // rust: m.extra.counter = cooldown;
    // rust: self.ageable(m, g)
}
    // rust: S::Nautilus => {
    // rust: let cooldown = self.uniform(2400, 3600);
    // rust: set_memory(m, "attack_target_cooldown", i64::from(cooldown), i64::MAX);
    // rust: m.extra.counter = cooldown;
    // rust: self.ageable(m, g)
}
    // rust: S::Sheep => {
    // rust: let climate = if self
    // rust: .level
    // rust: .biome_tag("minecraft:spawns_warm_variant_farm_animals", block(m))
    // rust: {
    // rust: Climate::Warm
    // rust: } else if self
    // rust: .level
    // rust: .biome_tag("minecraft:spawns_cold_variant_farm_animals", block(m))
    // rust: {
    // rust: Climate::Cold
    // rust: } else {
    // rust: Climate::Temperate
}
    // rust: m.extra.color = super::farm::sheep_color(climate, self.random);
    // rust: self.ageable(m, g)
}
    // rust: S::Rabbit => {
    // rust: let at = block(m);
    // rust: let roll = self.int(100);
    // rust: let mut variant = if self.level.biome_tag("minecraft:spawns_white_rabbits", at) {
    // rust: if roll < 80 { 1 } else { 3 }
    // rust: } else if self.level.biome_tag("minecraft:spawns_gold_rabbits", at) {
    // rust: 4
    // rust: } else if roll < 50 {
    // rust: 0
    // rust: } else if roll < 90 {
    // rust: 5
    // rust: } else {
    // rust: 2
}
    // rust: let g = match g {
    // rust: Some(Group::Rabbit(a, v)) => {
    // rust: variant = v;
    // rust: Group::Rabbit(a, v)
}
    // rust: _ => Group::Rabbit(Ageable::chance(1.0), variant),
}
    // rust: m.extra.variant = variant;
    // rust: self.ageable(m, Some(g))
}
    // rust: S::Horse => {
    // rust: let (g, variant) = match g {
    // rust: Some(Group::Horse(a, v)) => (Group::Horse(a, v), v),
    // rust: _ => {
    // rust: let v = self.int(7) as u8;
    // rust: (Group::Horse(Ageable::babies(true), v), v)
}
}
    // rust: let markings = self.int(5) as u8;
    // rust: m.extra.variant = variant;
    // rust: m.extra.variant2 = markings;
    // rust: self.horse(m, Some(g))
}
    // rust: S::Llama | S::TraderLlama => {
    // rust: let mut g = g;
    // rust: if s == S::TraderLlama {
    // rust: if reason == Reason::Event {
    // rust: set_age(m, 0);
}
    // rust: if g.is_none() {
    // rust: g = Some(Group::Ageable(Ageable::babies(false)));
}
}
    // rust: let max = if self.float() < 0.04 { 5 } else { 3 };
    // rust: m.extra.variant2 = (1 + self.int(max)) as u8;
    // rust: let g = match g {
    // rust: Some(Group::Llama(a, v)) => {
    // rust: m.extra.variant = v;
    // rust: Group::Llama(a, v)
}
    // rust: _ => {
    // rust: let v = self.int(4) as u8;
    // rust: m.extra.variant = v;
    // rust: Group::Llama(Ageable::babies(true), v)
}
}
    // rust: self.horse(m, Some(g))
}
    // rust: S::Donkey | S::Mule | S::SkeletonHorse => self.horse(m, g),
    // rust: S::ZombieHorse => {
    // rust: if reason == Reason::Natural
    // rust: && let Some(mut zombie) = self.create("minecraft:zombie", Reason::Jockey, m)
    // rust: {
    // rust: self.finalize(&mut zombie, reason, None);
    // rust: set_item(&mut zombie, MAINHAND, "minecraft:iron_spear");
    // rust: self.ride(&mut zombie, m);
    // rust: self.created.push(zombie);
}
    // rust: self.horse(m, g)
}
    // rust: S::Camel | S::CamelHusk => {
    // rust: let now = self.level.game_time();
    // rust: m.extra.pose_change_tick = (now - 52 - 1).max(0);
    // rust: super::camel::stand_up_instantly(m);
    // rust: self.horse(m, g)
}
    // rust: S::Goat => {
    // rust: goat_init_memories(m, self.random);
    // rust: m.extra.screaming = self.random.next_double() < 0.02;
    // rust: age_boundary_reached(m);
    // rust: if !m.is_baby() && self.float() < 0.1 {
    // rust: let left = self.random.next_boolean();
    // rust: m.extra.lost_horns[usize::from(!left)] = true;
}
    // rust: self.ageable(m, g)
}
    // rust: S::Panda => {
    // rust: let main = panda_gene(self.int(16));
    // rust: let hidden = panda_gene(self.int(16));
    // rust: m.extra.variant = main;
    // rust: m.extra.variant2 = hidden;
    // rust: super::panda::set_attributes(m);
    // rust: self.ageable(m, g.or(Some(Group::Ageable(Ageable::chance(0.2)))))
}
    // rust: S::PolarBear | S::Ocelot => {
    // rust: self.ageable(m, g.or(Some(Group::Ageable(Ageable::chance(1.0)))))
}
    // rust: S::Fox => {
    // rust: let at = block(m);
    // rust: let mut variant = u8::from(self.level.biome_tag("minecraft:spawns_snow_foxes", at));
    // rust: let mut baby = false;
    // rust: let g = match g {
    // rust: Some(Group::Fox(a, v)) => {
    // rust: variant = v;
    // rust: baby = a.size >= 2;
    // rust: Group::Fox(a, v)
}
    // rust: _ => Group::Fox(Ageable::babies(false), variant),
}
    // rust: m.extra.variant = variant;
    // rust: if baby {
    // rust: set_age(m, -24000);
}
    // rust: self.populate(m);
    // rust: self.ageable(m, Some(g))
}
    // rust: S::Parrot => {
    // rust: m.extra.variant = self.int(5) as u8;
    // rust: self.ageable(m, g.or(Some(Group::Ageable(Ageable::babies(false)))))
}
    // rust: S::Axolotl => {
    // rust: if reason == Reason::Bucket {
    // rust: return g;
}
    // rust: let mut baby = false;
    // rust: let g = match g {
    // rust: Some(Group::Axolotl(a, types)) => {
    // rust: baby = a.size >= 2;
    // rust: Group::Axolotl(a, types)
}
    // rust: _ => {
    // rust: let a = self.int(4) as u8;
    // rust: let b = self.int(4) as u8;
    // rust: Group::Axolotl(Ageable::babies(false), [a, b])
}
}
    // rust: if let Group::Axolotl(_, types) = g {
    // rust: m.extra.variant = types[self.int(2) as usize];
}
    // rust: if baby {
    // rust: set_age(m, -24000);
}
    // rust: self.ageable(m, Some(g))
}
    // rust: S::Squid | S::GlowSquid => {
    // rust: self.ageable(m, g.or(Some(Group::Ageable(Ageable::chance(0.05)))))
}
    // rust: S::Dolphin => {
    // rust: m.air = 4800;
    // rust: m.head_pitch = 0.0;
    // rust: self.ageable(m, g.or(Some(Group::Ageable(Ageable::chance(0.1)))))
}
    // rust: S::Turtle => {
    // rust: m.extra.home = Some(block(m));
    // rust: self.ageable(m, g)
}
    // rust: S::Villager | S::WanderingTrader => {
    // rust: if s == S::Villager {
    // rust: if reason == Reason::Breeding {
    // rust: m.extra.variant2 = 0;
}
    // rust: self.villager_type(m);
}
    // rust: self.ageable(m, g.or(Some(Group::Ageable(Ageable::babies(false)))))
}
    // rust: S::Hoglin => {
    // rust: if self.float() < 0.2 {
    // rust: set_baby(m, true);
}
    // rust: self.ageable(m, g)
}
    // rust: S::Zoglin => {
    // rust: if self.float() < 0.2 {
    // rust: set_baby(m, true);
}
    // rust: self.mob(m, g)
}
    // rust: S::Strider => self.strider(m, g),
    // rust: S::Slime | S::MagmaCube | S::SulfurCube => {
    // rust: let g = if s == S::SulfurCube {
    // rust: g
    // rust: } else {
    // rust: g.or(Some(Group::Ageable(Ageable::babies(false))))
}
    // rust: let g = self.ageable(m, g);
    // rust: if s == S::SulfurCube {
    // rust: let size = if m.is_baby() { 1 } else { 2 };
    // rust: sulfur_size(m, size);
    // rust: } else {
    // rust: let mut scale = self.int(3);
    // rust: if scale < 2 && self.float() < 0.5 * self.special() {
    // rust: scale += 1;
}
    // rust: cube_size(m, 1 << scale);
}
    // rust: g
}
    // rust: S::Cod | S::Salmon | S::TropicalFish => {
    // rust: if s == S::Salmon {
                    // A weighted list (small 30, medium 50, large 15) on the
                    // salmon's own random.
    // rust: let r = m.random.next_int_bound(95).unwrap_or(0);
    // rust: m.extra.variant = if r < 30 {
    // rust: 0
    // rust: } else if r < 80 {
    // rust: 1
    // rust: } else {
    // rust: 2
}
}
    // rust: let given = g;
    // rust: self.mob(m, None);
    // rust: let g = match given {
    // rust: None => Group::School(m.id, None),
    // rust: Some(Group::School(leader, v)) => {
    // rust: m.extra.leader = Some(leader);
    // rust: Group::School(leader, v)
}
    // rust: Some(other) => other,
}
    // rust: if s != S::TropicalFish {
    // rust: return Some(g);
}
    // rust: let (g, (p, b, c)) = match g {
    // rust: Group::School(leader, Some(v)) => (Group::School(leader, Some(v)), v),
    // rust: other => {
    // rust: if f64::from(self.float()) < 0.9 {
    // rust: let v = super::aquatic::COMMON_TROPICAL[self.int(22) as usize];
    // rust: (Group::School(m.id, Some(v)), v)
    // rust: } else {
    // rust: m.extra.lone = true;
    // rust: let p = self.int(12) as u8;
    // rust: let b = self.int(16) as u8;
    // rust: let c = self.int(16) as u8;
    // rust: (other, (p, b, c))
}
}
}
    // rust: m.extra.variant = p;
    // rust: m.extra.variant2 = b;
    // rust: m.extra.variant3 = c;
    // rust: Some(g)
}
    // rust: S::Zombie | S::ZombifiedPiglin => self.zombie(m, g, reason),
    // rust: S::ZombieVillager => {
    // rust: self.villager_type(m);
                // ZombieVillager's constructor picks the profession from the
                // fresh entity's random, before anything seeds it: an
                // independent draw that leaves the mob's own random alone.
    // rust: let mut fresh = LegacyRandom::new(
    // rust: (m.random.state() as i64).wrapping_mul(0x5851_F42D_4C95_7F2D) ^ i64::from(m.id),
    // rust: );
    // rust: m.extra.variant2 = fresh.next_int_bound(15).unwrap_or(0) as u8;
    // rust: self.zombie(m, g, reason)
}
    // rust: S::Husk => self.husk(m, g, reason),
    // rust: S::Drowned => self.drowned(m, g, reason),
    // rust: s if skeleton(s) => self.skeleton(m, g),
    // rust: S::Spider => self.spider(m, g, reason),
            // CaveSpider.finalizeSpawn returns at once.
    // rust: S::CaveSpider => g,
    // rust: S::Pillager => {
    // rust: self.populate(m);
    // rust: self.enchant(m);
    // rust: self.raider(m, g, reason)
}
    // rust: S::Vindicator => {
    // rust: let g = self.raider(m, g, reason);
    // rust: self.populate(m);
    // rust: self.enchant(m);
    // rust: g
}
    // rust: S::Illusioner => {
    // rust: set_item(m, MAINHAND, "minecraft:bow");
    // rust: self.raider(m, g, reason)
}
    // rust: s if raider(s) => self.raider(m, g, reason),
    // rust: S::Piglin => self.piglin(m, g, reason),
    // rust: S::PiglinBrute => {
    // rust: let home = block(m);
    // rust: m.extra.home = Some(home);
    // rust: set_memory(m, "home", 0, i64::MAX);
    // rust: self.populate(m);
    // rust: self.mob(m, g)
}
    // rust: S::Vex => {
    // rust: self.populate(m);
    // rust: self.enchant(m);
    // rust: self.mob(m, g)
}
    // rust: S::Warden => {
    // rust: super::warden::finalize(m, reason == Reason::Triggered, &mut Vec::new());
    // rust: set_memory(m, "dig_cooldown", 0, 1200);
    // rust: if reason == Reason::Triggered {
    // rust: set_memory(m, "is_emerging", 0, super::warden::EMERGE_DURATION);
}
    // rust: self.mob(m, g)
}
    // rust: S::Phantom => {
    // rust: let at = block(m);
    // rust: m.extra.home = Some([at[0], at[1] + 5, at[2]]);
    // rust: m.extra.size = 0;
    // rust: self.mob(m, g)
}
    // rust: S::Shulker => {
    // rust: m.yaw = 0.0;
    // rust: m.head_yaw = 0.0;
    // rust: m.previous_yaw = 0.0;
    // rust: m.previous_head_yaw = 0.0;
    // rust: self.mob(m, g)
}
    // rust: _ if ageable(s) => self.ageable(m, g),
    // rust: _ => self.mob(m, g),
}
}
}

// `Mob.finalizeSpawn` of a fresh mob. Returns the group data for the next
// mob of the pack.
    // rust: pub fn finalize<L: FinalizeLevel + ?Sized, R: RandomSource>(
    // rust: cx: &mut Ctx<'_, L, R>,
    // rust: m: &mut Mob,
    // rust: reason: Reason,
    // rust: g: Option<Group>,
    // rust: ) -> Option<Group> {
    // rust: cx.finalize(m, reason, g)
}

block :: proc(m: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]
}
// A brain memory finalizeSpawn sets: value and ticks until it expires.
set_memory :: proc(m: ^Mob, name: ^'static str, value: i64, ttl: i64) {
}
    // rust: match m.extra.memories.iter_mut().find(|x| x.0 == name) {
    // rust: Some(x) => *x = (name, value, ttl),
    // rust: None => m.extra.memories.push((name, value, ttl)),
}
}
// `GoatAi.initMemories`: a long jump cooldown (600 to 1200 ticks) and a ram
// cooldown (600 to 6000), drawn from `random`.
goat_init_memories :: proc(m: ^Mob, random: ^impl RandomSource) {
}
    // rust: let jump = random.next_int_between_inclusive(600, 1200).unwrap_or(600);
    // rust: set_memory(m, "long_jump_cooling_down", i64::from(jump), i64::MAX);
    // rust: let ram = random.next_int_between_inclusive(600, 6000).unwrap_or(600);
    // rust: set_memory(m, "ram_cooldown_ticks", i64::from(ram), i64::MAX);
}
// `Panda.Gene.getRandom` (enum order: normal, lazy, worried, playful,
// brown, weak, aggressive).
panda_gene :: proc(roll: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match roll {
    // rust: 0 => 1,
    // rust: 1 => 2,
    // rust: 2 => 3,
    // rust: 4 => 6,
    // rust: r if r < 9 => 5,
    // rust: r if r < 11 => 4,
    // rust: _ => 0,
}
}
// `Panda.Gene.getVariantFromGenes`: a recessive gene shows when both match.
panda_variant :: proc(main: u8, hidden: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let recessive = matches!(main, 4 | 5);
    // rust: if recessive && main != hidden { 0 } else { main }
}
// `AbstractCubeMob.setSize(size, true)` for slimes and magma cubes.
// `SulfurCube.setSize(size, true)`, with the attribute bases it sets.
sulfur_size :: proc(m: ^Mob, size: i32) {
}
    // rust: super::sulfur_cube::set_size(m, size, true);
    // rust: let size = m.extra.size;
    // rust: set_base(m, Attr::MaxHealth, f64::from(4 * size));
    // rust: set_base(
    // rust: m,
    // rust: Attr::MovementSpeed,
    // rust: f64::from(0.2f32 + 0.1f32 * size as f32),
    // rust: );
    // rust: m.health = max_health(m);
}
cube_size :: proc(m: ^Mob, size: i32) {
}
    // rust: super::cube::set_size(m, size);
}
// The index the game keeps for a variant registry entry.
variant_index :: proc(s: Species, name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: let i = match s {
    // rust: Species::Cat => super::tame::CAT_VARIANTS.iter().position(|v| *v == name),
    // rust: Species::Wolf => super::tame::WOLF_VARIANTS.iter().position(|v| v.0 == name),
    // rust: Species::ZombieNautilus => super::nautilus::VARIANTS.iter().position(|v| *v == name),
        // MushroomCow.Variant: red is the codec's default, brown the other.
    // rust: Species::Mooshroom => ["red", "brown"].iter().position(|v| *v == name),
        // Fox.Variant, read from a `minecraft:fox/variant` component; the save
        // keeps the same two names under `Type`.
    // rust: Species::Fox => ["red", "snow"].iter().position(|v| *v == name),
        // Horse.Variant and Llama.Variant, the coat colours their
        // `.../variant` components carry; a trader llama inherits the llama's.
    // rust: Species::Horse => super::equine::VARIANT_NAMES.iter().position(|v| *v == name),
    // rust: Species::Llama | Species::TraderLlama => {
    // rust: super::llama::VARIANTS.iter().position(|v| *v == name)
}
    // rust: _ => ["temperate", "warm", "cold"]
    // rust: .iter()
    // rust: .position(|v| *v == name),
}
    // rust: i.unwrap_or(0) as u8
}
// The variant data component a mob reports (`Entity.get`, e.g.
// `Wolf.get(DataComponents.WOLF_VARIANT)`): component id and registry entry.
variant_component :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: species_variant_component(m.species(), m.extra.variant)
}
// [`variant_component`] of a species with the game's variant index.
species_variant_component :: proc(s: Species, variant: u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let component = match s {
    // rust: Species::Wolf => "minecraft:wolf/variant",
    // rust: Species::Cat => "minecraft:cat/variant",
    // rust: Species::Frog => "minecraft:frog/variant",
    // rust: Species::Pig => "minecraft:pig/variant",
    // rust: Species::Cow => "minecraft:cow/variant",
    // rust: Species::Mooshroom => "minecraft:mooshroom/variant",
    // rust: Species::Chicken => "minecraft:chicken/variant",
    // rust: Species::ZombieNautilus => "minecraft:zombie_nautilus/variant",
    // rust: Species::Horse => "minecraft:horse/variant",
    // rust: Species::Llama | Species::TraderLlama => "minecraft:llama/variant",
    // rust: _ => return None,
}
    // rust: Some((component, format!("minecraft:{}", variant_name(s, variant))))
}
// Whether the mob's save keeps its variant under `variant` — the registry
// id `VariantUtils.writeVariant` stores — rather than under its own key (a
// fox's and a mooshroom's `Type`) or a packed int (a horse's and a llama's
// `Variant`). Only these seven classes call `writeVariant`, so reporting the
// component does not mean the save carries the name.
saves_variant_name :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Wolf
    // rust: | Species::Cat
    // rust: | Species::Frog
    // rust: | Species::Pig
    // rust: | Species::Cow
    // rust: | Species::Chicken
    // rust: | Species::ZombieNautilus
    // rust: )
}
// The `*_sound_variant` registry of a species, in registry order.
sound_variants :: proc(s: Species) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match s {
    // rust: Species::Pig => &["big", "classic", "mini"],
    // rust: Species::Cow => &["classic", "moody"],
    // rust: Species::Chicken => &["classic", "picky"],
    // rust: Species::Cat => &["classic", "royal"],
    // rust: Species::Wolf => &["angry", "big", "classic", "cute", "grumpy", "puglin", "sad"],
    // rust: _ => &[],
}
}
// A sound of the mob's `*_sound_variant` set (`Pig.getSoundSet`,
// `Wolf.getSoundSet`, `Cat.getSoundSet`, ...): `kind` is the sound's key
// (`ambient`, `hurt`, `step`, `growl`, `purreow`...). Babies use the species'
// baby set (cows have none); an adult's set is `entity.<species>.*` for
// `classic` and `entity.<species>_<variant>.*` otherwise, except the
// footsteps that every variant shares (not the cow's). None for a species
// without sound variants.
variant_sound :: proc(m: ^Mob, kind: string) -> O {
    // Ported from Horizon
    return {}
}
//     use std::{collections::HashMap, sync::Mutex};
    // rust: let species = m.species();
    // rust: let name = match species {
    // rust: Species::Pig => "pig",
    // rust: Species::Cow => "cow",
    // rust: Species::Chicken => "chicken",
    // rust: Species::Wolf => "wolf",
    // rust: Species::Cat => "cat",
    // rust: _ => return None,
}
    // rust: let variant = m
    // rust: .extra
    // rust: .sound_variant
    // rust: .and_then(|i| sound_variants(species).get(i as usize))
    // rust: .copied()
    // rust: .unwrap_or("classic");
    // rust: let id = if m.is_baby() && species != Species::Cow {
    // rust: format!("entity.baby_{name}.{kind}")
    // rust: } else if variant == "classic" || (kind == "step" && species != Species::Cow) {
    // rust: format!("entity.{name}.{kind}")
    // rust: } else {
    // rust: format!("entity.{name}_{variant}.{kind}")
}
    // A handful of ids in all: keep each one as a `&'static str`.
IDS :: Mutex::new(None)
    // rust: let mut ids = IDS.lock().ok()?;
    // rust: let ids = ids.get_or_insert_with(HashMap::new);
    // rust: Some(
    // rust: *ids.entry(id)
    // rust: .or_insert_with_key(|k| Box::leak(k.clone().into_boxed_str())),
    // rust: )
}
// The registry name of the game's variant index.
variant_name :: proc(s: Species, index: u8) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let i = index as usize;
    // rust: match s {
    // rust: Species::Cat => super::tame::CAT_VARIANTS.get(i).copied().unwrap_or("tabby"),
    // rust: Species::Wolf => super::tame::WOLF_VARIANTS.get(i).map_or("pale", |v| v.0),
    // rust: Species::ZombieNautilus => super::nautilus::VARIANTS
    // rust: .get(i)
    // rust: .copied()
    // rust: .unwrap_or("temperate"),
    // rust: Species::Mooshroom => ["red", "brown"].get(i).copied().unwrap_or("red"),
    // rust: Species::Horse => super::equine::VARIANT_NAMES
    // rust: .get(i)
    // rust: .copied()
    // rust: .unwrap_or("white"),
    // rust: Species::Llama | Species::TraderLlama => {
    // rust: super::llama::VARIANTS.get(i).copied().unwrap_or("creamy")
}
    // rust: _ => ["temperate", "warm", "cold"]
    // rust: .get(i)
    // rust: .copied()
    // rust: .unwrap_or("temperate"),
}
}
// `VillagerType.byBiome` (index into `render::VILLAGER_TYPES`: plains,
// desert, jungle, savanna, snow, swamp, taiga).
villager_type :: proc(biome: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match biome.strip_prefix("minecraft:").unwrap_or(biome) {
    // rust: "badlands" | "desert" | "eroded_badlands" | "wooded_badlands" => 1,
    // rust: "bamboo_jungle" | "jungle" | "sparse_jungle" => 2,
    // rust: "savanna_plateau" | "savanna" | "windswept_savanna" => 3,
    // rust: "deep_frozen_ocean" | "frozen_ocean" | "frozen_river" | "ice_spikes" | "snowy_beach"
    // rust: | "snowy_taiga" | "snowy_plains" | "grove" | "snowy_slopes" | "frozen_peaks"
    // rust: | "jagged_peaks" => 4,
    // rust: "swamp" | "mangrove_swamp" => 5,
    // rust: "old_growth_spruce_taiga"
    // rust: | "old_growth_pine_taiga"
    // rust: | "windswept_gravelly_hills"
    // rust: | "windswept_hills"
    // rust: | "taiga"
    // rust: | "windswept_forest" => 6,
    // rust: _ => 0,
}
}

    // rust: mod tests {
//     use super::*;

panda_genes_follow_the_vanilla_table :: proc() {
}
    // rust: assert_eq!(panda_gene(0), 1);
    // rust: assert_eq!(panda_gene(3), 5);
    // rust: assert_eq!(panda_gene(4), 6);
    // rust: assert_eq!(panda_gene(9), 4);
    // rust: assert_eq!(panda_gene(15), 0);
    // rust: assert_eq!(panda_variant(4, 0), 0);
    // rust: assert_eq!(panda_variant(4, 4), 4);
    // rust: assert_eq!(panda_variant(6, 0), 6);
}
    // `MushroomCow.get(DataComponentGetter)`: a mooshroom reports its colour
    // as the variant component, and the name maps back to the index.
a_mooshroom_reports_its_variant_component :: proc() {
}
    // rust: for (index, name) in [(0, "minecraft:red"), (1, "minecraft:brown")] {
    // rust: assert_eq!(
    // rust: species_variant_component(Species::Mooshroom, index),
    // rust: Some(("minecraft:mooshroom/variant", name.to_owned()))
    // rust: );
    // rust: assert_eq!(variant_index(Species::Mooshroom, name), index);
    // rust: assert_eq!(
    // rust: format!("minecraft:{}", variant_name(Species::Mooshroom, index)),
    // rust: name
    // rust: );
}
        // Variant.DEFAULT is red: an unknown name, or an index past brown.
    // rust: assert_eq!(variant_index(Species::Mooshroom, "minecraft:temperate"), 0);
    // rust: assert_eq!(variant_name(Species::Mooshroom, 2), "red");
}
    // `Horse.get(DataComponents.HORSE_VARIANT)` and
    // `Llama.get(DataComponents.LLAMA_VARIANT)`: the coat colour a horse or a
    // llama reports, and the names a `.../variant` component carries.
a_horse_and_a_llama_report_their_variant_component :: proc() {
}
    // rust: for (species, component, names) in [
    // rust: (
    // rust: Species::Horse,
    // rust: "minecraft:horse/variant",
    // rust: &crate::mobs::equine::VARIANT_NAMES[..],
    // rust: ),
    // rust: (
    // rust: Species::Llama,
    // rust: "minecraft:llama/variant",
    // rust: &crate::mobs::llama::VARIANTS[..],
    // rust: ),
    // rust: (
    // rust: Species::TraderLlama,
    // rust: "minecraft:llama/variant",
    // rust: &crate::mobs::llama::VARIANTS[..],
    // rust: ),
    // rust: ] {
    // rust: for (index, name) in names.iter().enumerate() {
    // rust: let index = index as u8;
    // rust: let name = format!("minecraft:{name}");
    // rust: assert_eq!(
    // rust: species_variant_component(species, index),
    // rust: Some((component, name.clone())),
    // rust: "{species:?} {index}"
    // rust: );
    // rust: assert_eq!(variant_index(species, &name), index, "{name}");
    // rust: assert_eq!(format!("minecraft:{}", variant_name(species, index)), name);
}
}
        // Horse.Variant.WHITE and Llama.Variant.CREAMY are the defaults.
    // rust: assert_eq!(variant_index(Species::Horse, "minecraft:temperate"), 0);
    // rust: assert_eq!(variant_index(Species::Llama, "minecraft:temperate"), 0);
    // rust: assert_eq!(variant_name(Species::Horse, 7), "white");
    // rust: assert_eq!(variant_name(Species::TraderLlama, 4), "creamy");
        // Only `VariantUtils.writeVariant` species save the name; a horse and
        // a llama save a packed `Variant` int, a fox and a mooshroom `Type`.
    // rust: for species in [Species::Wolf, Species::Cat, Species::Chicken, Species::Pig] {
    // rust: assert!(saves_variant_name(species), "{species:?}");
}
    // rust: for species in [
    // rust: Species::Horse,
    // rust: Species::Llama,
    // rust: Species::TraderLlama,
    // rust: Species::Fox,
    // rust: Species::Mooshroom,
    // rust: ] {
    // rust: assert!(!saves_variant_name(species), "{species:?}");
}
}
    // #2269: the offspring of a spawn egg used on a mob is a baby of that
    // kind (`SpawnEggItem.spawnOffspringFromSpawnEgg`), and only the mob's
    // own kind takes the egg.
a_spawn_egg_offspring_is_a_baby :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let kind = std::sync::Arc::new(data.types.get("minecraft:cow").unwrap().clone());
    // rust: let mut child = crate::mobs::Mob::new(
    // rust: 2,
    // rust: kind,
    // rust: horizon_core::geometry::Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: assert!(!child.is_baby());
    // rust: spawn_egg_offspring(&mut child, Species::Cow, 3, 0);
        // The offspring is a baby of the mob's kind.
    // rust: assert!(child.is_baby());
        // It keeps the parent's variant.
    // rust: assert_eq!(child.extra.variant, 3);
        // The egg is for the mob's own kind.
    // rust: assert!(spawn_egg_is_for("minecraft:cow_spawn_egg", "minecraft:cow"));
    // rust: assert!(!spawn_egg_is_for(
    // rust: "minecraft:pig_spawn_egg",
    // rust: "minecraft:cow"
    // rust: ));
    // rust: assert!(!spawn_egg_is_for("minecraft:stick", "minecraft:cow"));
}
    // #7877: `/attribute <mob> <attr> modifier add` hands `add_modifier` an
    // id typed at run time; it lands in the value, reads back, and goes.
a_command_modifier_with_a_runtime_id_changes_the_value :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let kind = std::sync::Arc::new(data.types.get("minecraft:zombie").unwrap().clone());
    // rust: let mut m = crate::mobs::Mob::new(
    // rust: 2,
    // rust: kind,
    // rust: horizon_core::geometry::Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: set_base(&mut m, Attr::AttackDamage, 4.0);
    // rust: let id = String::from("test:typed");
    // rust: add_modifier(&mut m, Attr::AttackDamage, id.clone(), 3.0, Op::AddValue);
    // rust: assert!(has_modifier(&m, Attr::AttackDamage, &id));
    // rust: assert_eq!(modifier_amount(&m, Attr::AttackDamage, &id), Some(3.0));
    // rust: assert_eq!(m.attrs.attack_damage, 7.0);
    // rust: assert_eq!(value(&m, Attr::AttackDamage), 7.0);
    // rust: remove_modifier(&mut m, Attr::AttackDamage, &id);
    // rust: assert!(!has_modifier(&m, Attr::AttackDamage, &id));
    // rust: assert_eq!(m.attrs.attack_damage, 4.0);
}
    // #7877: every attribute `/attribute` can name on a mob is edited in the
    // store the mob reads: base, modifier and removal reach the cached field
    // gameplay uses, for each attribute the mob types hold.
every_command_attribute_reaches_the_store_the_mob_reads :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let mut covered = 0;
    // rust: for a in Attr::ALL {
    // rust: let short = a.name();
    // rust: assert_eq!(command_attr(short), (a != Attr::Armor).then_some(a));
    // rust: if a == Attr::Armor {
    // rust: continue;
}
            // Any type holding the attribute, in a stable order.
    // rust: let mut names: Vec<_> = data.types.keys().collect();
    // rust: names.sort();
    // rust: let Some(kind) = names
    // rust: .into_iter()
    // rust: .map(|n| &data.types[n])
    // rust: .find(|k| k.attributes.contains_key(a.id()))
    // rust: else {
    // rust: continue;
}
    // rust: let mut m = crate::mobs::Mob::new(
    // rust: 2,
    // rust: std::sync::Arc::new(kind.clone()),
    // rust: horizon_core::geometry::Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: let cached = |m: &crate::mobs::Mob| match a {
    // rust: Attr::MaxHealth => Some(f64::from(m.attrs.max_health)),
    // rust: Attr::MovementSpeed => Some(m.attrs.speed),
    // rust: Attr::FollowRange => Some(m.attrs.follow_range),
    // rust: Attr::AttackDamage => Some(f64::from(m.attrs.attack_damage)),
    // rust: Attr::KnockbackResistance => Some(m.attrs.knockback_resistance),
    // rust: Attr::SpawnReinforcements => Some(m.attrs.spawn_reinforcements),
    // rust: Attr::JumpStrength => Some(m.attrs.jump_strength),
    // rust: _ => None,
}
            // Max health clamps below 1.
    // rust: let base = if a == Attr::MaxHealth { 2.0 } else { 0.5 };
    // rust: set_base(&mut m, a, base);
    // rust: assert_eq!(base_value(&m, a), base, "{short} base");
    // rust: add_modifier(&mut m, a, format!("test:{short}"), 0.25, Op::AddValue);
    // rust: assert_eq!(modifier_amount(&m, a, &format!("test:{short}")), Some(0.25));
    // rust: assert_eq!(value(&m, a), base + 0.25, "{short} value");
    // rust: if let Some(c) = cached(&m) {
    // rust: assert_eq!(c, base + 0.25, "{short} cached field");
}
    // rust: remove_modifier(&mut m, a, &format!("test:{short}"));
    // rust: assert!(!has_modifier(&m, a, &format!("test:{short}")));
    // rust: if let Some(c) = cached(&m) {
    // rust: assert_eq!(c, base, "{short} cached field after removal");
}
    // rust: covered += 1;
}
    // rust: assert!(covered >= 7, "only {covered} attributes had a mob type");
}
    // #7877: `/attribute <mob> movement_speed|attack_damage base set` goes
    // through `AttributeInstance.setBaseValue`, so the value survives the
    // next refresh (an effect's modifier) instead of snapping back.
a_set_base_survives_a_later_modifier_refresh :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let kind = std::sync::Arc::new(data.types.get("minecraft:zombie").unwrap().clone());
    // rust: let mut m = crate::mobs::Mob::new(
    // rust: 2,
    // rust: kind,
    // rust: horizon_core::geometry::Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: set_base(&mut m, Attr::MovementSpeed, 0.5);
    // rust: set_base(&mut m, Attr::AttackDamage, 7.0);
        // Refresh through another attribute's change and a modifier.
    // rust: set_base(&mut m, Attr::MaxHealth, 30.0);
    // rust: add_modifier(
    // rust: &mut m,
    // rust: Attr::MovementSpeed,
    // rust: "test:x",
    // rust: 0.5,
    // rust: Op::AddMultipliedTotal,
    // rust: );
    // rust: assert_eq!(base_value(&m, Attr::MovementSpeed), 0.5);
    // rust: assert_eq!(m.attrs.speed, 0.75);
    // rust: remove_modifier(&mut m, Attr::MovementSpeed, "test:x");
    // rust: assert_eq!(m.attrs.speed, 0.5);
    // rust: assert_eq!(base_value(&m, Attr::AttackDamage), 7.0);
    // rust: assert_eq!(m.attrs.attack_damage, 7.0);
}
    // #3887: Weakness and Slowness (and Health Boost) carry attribute
    // modifiers in vanilla (`MobEffects`), and every effect's amount is
    // scaled by the amplifier plus one (`MobEffect.addAttributeModifier`);
    // before this only strength and speed were mapped.
weakness_slowness_and_health_boost_carry_attribute_modifiers :: proc() {
}
    // rust: let close = |a: f64, b: f64| (a - b).abs() < 1e-9;
    // rust: let modifier = |effect: &str, amplifier: i32, attr: Attr| {
    // rust: effect_modifier(effect, amplifier, attr).expect("the effect should carry a modifier")
}
        // MobEffects.WEAKNESS: attack damage -4 per level, ADD_VALUE.
    // rust: let (amount, op) = modifier("minecraft:weakness", 0, Attr::AttackDamage);
    // rust: assert!(close(amount, -4.0));
    // rust: assert_eq!(op, Op::AddValue);
    // rust: let (amount, _) = modifier("weakness", 1, Attr::AttackDamage);
    // rust: assert!(close(amount, -8.0));
        // MobEffects.SLOWNESS: movement speed -0.15F per level, ADD_MULTIPLIED_TOTAL.
    // rust: let (amount, op) = modifier("minecraft:slowness", 0, Attr::MovementSpeed);
    // rust: assert!(close(amount, f64::from(-0.15f32)));
    // rust: assert_eq!(op, Op::AddMultipliedTotal);
    // rust: let (amount, _) = modifier("slowness", 1, Attr::MovementSpeed);
    // rust: assert!(close(amount, f64::from(-0.15f32) * 2.0));
        // MobEffects.HEALTH_BOOST: max health +4 per level, ADD_VALUE.
    // rust: let (amount, op) = modifier("minecraft:health_boost", 0, Attr::MaxHealth);
    // rust: assert!(close(amount, 4.0));
    // rust: assert_eq!(op, Op::AddValue);
        // The effects that already worked keep their vanilla amounts.
    // rust: let (amount, _) = modifier("strength", 0, Attr::AttackDamage);
    // rust: assert!(close(amount, 3.0));
    // rust: let (amount, _) = modifier("speed", 0, Attr::MovementSpeed);
    // rust: assert!(close(amount, f64::from(0.2f32)));
        // An effect does not touch attributes it does not modify.
    // rust: assert!(effect_modifier("weakness", 0, Attr::MovementSpeed).is_none());
    // rust: assert!(effect_modifier("poison", 0, Attr::AttackDamage).is_none());
}
reasons_round_trip :: proc() {
}
    // rust: for r in Reason::ALL {
    // rust: assert_eq!(Reason::parse(r.name()), Some(r));
}
}
villager_types_by_biome :: proc() {
}
    // rust: assert_eq!(villager_type("minecraft:badlands"), 1);
    // rust: assert_eq!(villager_type("minecraft:grove"), 4);
    // rust: assert_eq!(villager_type("minecraft:plains"), 0);
}
october_31_is_halloween :: proc() {
}
    // rust: assert!(halloween_date(10, 31));
    // rust: assert!(!halloween_date(10, 30));
    // rust: assert!(!halloween_date(11, 1));
    // rust: assert!(!halloween_date(1, 1));
}
}
