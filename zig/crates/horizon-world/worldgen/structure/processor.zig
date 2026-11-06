//! Transpiled from Horizon Rust crate
//! Module: horizon-world_processor
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Structure processors (`worldgen/processor_list`) and template placement.
// use super::{BlockInfo, BoundingBox, Mirror, Rotation, StructureResources, StructureTemplate};
// use crate::{
    // rust: fluid::FluidKind,
    // rust: heightmap::HeightmapType,
    // rust: nbt::{Compound, JavaString, Tag},
    // rust: registry::BlockStateId,
    // rust: worldgen::{
    // rust: DecodeError,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: rule_test::RuleTest,
    // rust: value_provider::IntProvider,
    // rust: },
}
// use horizon_core::{
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, PositionalRandom, RandomSource, position_seed},
}
// use serde_json::Value;
// use std::{collections::BTreeSet, sync::Arc};

    // rust: mod litho;
    // rust: mod pillars;
    // rust: mod sea_level;

/// The draws processors make from StructurePlaceSettings' random.
    // rust: pub trait ProcessorRandom {
pub fn float(self: *Self) f;
pub fn int(self: *Self, bound: i32) i;
pub fn long(self: *Self) i;
}
    // rust: impl<R: RandomSource> ProcessorRandom for R {
pub fn float(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next_float()
}
pub fn int(self: *Self, bound: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next_int_bound(bound).unwrap_or(0)
}
pub fn long(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next_long()
}
}

pub const PosRule = enum {
    Always,
    Linear {,
    min_chance: f32,
    max_chance: f32,
    min_dist: i32,
    max_dist: i32,
    axis: Option<usize>,
    // rust: },
    /// `horizon:piece_origin_axis_aligned_linear_pos`: Repurposed Structures'
    /// PieceOriginAxisAlignedLinearPosRuleTest, vanilla's axis-aligned chance
    /// over the block's distance from the template's origin along one axis.
    PieceOrigin {,
    min_chance: f32,
    max_chance: f32,
    min_dist: i32,
    max_dist: i32,
    axis: usize,
    // rust: },
    /// `horizon:y_value`: Repurposed Structures' YValuePosRuleTest, the
    /// block's world height in `min_y_value..=max_y_value`.
    YValue {,
    min: i32,
    max: i32,
    // rust: },
};
pub const Modifier = enum {
    Passthrough,
    Clear,
    AppendLoot(String),
    AppendStatic(Compound),
    /// `horizon:edit`: `remove`'s keys taken out of the block entity, then
    /// `data` merged in as append_static does. The data form of the mods'
    /// processors that copy a block entity and change parts of it (Moog's
    /// trial spawners and vaults drop their saved state).
    Edit {,
    remove: Vec<String>,
    data: Compound,
    // rust: },
};
    // rust: impl PosRule {
    /// A rule's `position_predicate` (always true when missing). Types are
    /// identifiers: `"always_true"` is `minecraft:always_true`, as vanilla
    /// reads it.
pub fn decode(value: ?*Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(p) = value else {
    // rust: return Ok(Self::Always);
}
    // rust: let kind = p["predicate_type"]
    // rust: .as_str()
    // rust: .unwrap_or("minecraft:always_true");
    // rust: Ok(match super::super::tags::identifier(kind)?.as_str() {
    // rust: "minecraft:always_true" => Self::Always,
    // rust: kind @ ("minecraft:linear_pos" | "minecraft:axis_aligned_linear_pos") => Self::Linear {
    // rust: min_chance: p.get("min_chance").and_then(Value::as_f64).unwrap_or(0.) as f32,
    // rust: max_chance: p.get("max_chance").and_then(Value::as_f64).unwrap_or(0.) as f32,
    // rust: min_dist: p.get("min_dist").and_then(Value::as_i64).unwrap_or(0) as i32,
    // rust: max_dist: p.get("max_dist").and_then(Value::as_i64).unwrap_or(0) as i32,
    // rust: axis: (kind == "minecraft:axis_aligned_linear_pos").then(|| {
    // rust: match p.get("axis").and_then(Value::as_str) {
    // rust: Some("x") => 0,
    // rust: Some("z") => 2,
    // rust: _ => 1,
}
    // rust: }),
    // rust: },
    // rust: "horizon:piece_origin_axis_aligned_linear_pos" => {
    // rust: let int = |key| p.get(key).and_then(Value::as_i64).unwrap_or(0) as i32;
    // rust: let (min_dist, max_dist) = (int("min_dist"), int("max_dist"));
    // rust: if min_dist >= max_dist {
    // rust: return Err(DecodeError::Field("position predicate distance range"));
}
    // rust: Self::PieceOrigin {
    // rust: min_chance: p.get("min_chance").and_then(Value::as_f64).unwrap_or(0.) as f32,
    // rust: max_chance: p.get("max_chance").and_then(Value::as_f64).unwrap_or(0.) as f32,
    // rust: min_dist,
    // rust: max_dist,
    // rust: axis: match p.get("axis").map(|a| a.as_str()) {
    // rust: Some(Some("x")) => 0,
    // rust: None | Some(Some("y")) => 1,
    // rust: Some(Some("z")) => 2,
    // rust: _ => return Err(DecodeError::Field("position predicate axis")),
    // rust: },
}
}
    // rust: "horizon:y_value" => {
    // rust: let int = |key| {
    // rust: p.get(key)
    // rust: .and_then(Value::as_i64)
    // rust: .map(|v| v as i32)
    // rust: .ok_or(DecodeError::Field("position predicate y value"))
}
    // rust: let (min, max) = (int("min_y_value")?, int("max_y_value")?);
    // rust: if min > max {
    // rust: return Err(DecodeError::Field("position predicate y range"));
}
    // rust: Self::YValue { min, max }
}
    // rust: _ => return Err(DecodeError::Field("position predicate")),
    // rust: })
}
    /// PosRuleTest.test for a block at `world`, `relative` in its template,
    /// in a piece placed at `reference`.
    // rust: fn test(
    // rust: &self,
    // rust: relative: [i32; 3],
    // rust: world: [i32; 3],
    // rust: reference: [i32; 3],
    // rust: random: &mut impl RandomSource,
    // rust: ) -> bool {
    // rust: match *self {
    // rust: Self::Always => true,
    // rust: Self::Linear {
    // rust: min_chance,
    // rust: max_chance,
    // rust: min_dist,
    // rust: max_dist,
    // rust: axis,
    // rust: } => {
    // rust: let dist = match axis {
    // rust: None => (0..3).map(|i| (world[i] - reference[i]).abs()).sum::<i32>(),
    // rust: Some(a) => ((world[a] - reference[a]) as f32).abs() as i32,
}
    // rust: random.next_float()
    // rust: <= clamped_chance(min_chance, max_chance, min_dist, max_dist, dist)
}
    // rust: Self::PieceOrigin {
    // rust: min_chance,
    // rust: max_chance,
    // rust: min_dist,
    // rust: max_dist,
    // rust: axis,
    // rust: } => {
    // rust: let dist = (relative[axis] as f32).abs() as i32;
    // rust: random.next_float()
    // rust: <= clamped_chance(min_chance, max_chance, min_dist, max_dist, dist)
}
    // rust: Self::YValue { min, max } => (min..=max).contains(&world[1]),
}
}
}
/// Mth.clampedLerp(min_chance, max_chance, Mth.inverseLerp(dist, min_dist, max_dist)).
    // rust: fn clamped_chance(
    // rust: min_chance: f32,
    // rust: max_chance: f32,
    // rust: min_dist: i32,
    // rust: max_dist: i32,
    // rust: dist: i32,
    // rust: ) -> f32 {
    // rust: let t = (dist - min_dist) as f32 / (max_dist - min_dist) as f32;
    // rust: if t < 0. {
    // rust: min_chance
    // rust: } else if t > 1. {
    // rust: max_chance
    // rust: } else {
    // rust: min_chance + t * (max_chance - min_chance)
}
}
    // rust: impl Modifier {
    /// A rule's `block_entity_modifier` (passthrough when missing).
pub fn decode(value: ?*Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(m) = value else {
    // rust: return Ok(Self::Passthrough);
}
    // rust: Ok(
    // rust: match super::super::tags::identifier(m["type"].as_str().unwrap_or(""))?.as_str() {
    // rust: "minecraft:passthrough" => Self::Passthrough,
    // rust: "minecraft:clear" => Self::Clear,
    // rust: "minecraft:append_loot" => {
    // rust: Self::AppendLoot(m["loot_table"].as_str().unwrap_or_default().to_owned())
}
    // rust: "minecraft:append_static" => match json_to_nbt(&m["data"]) {
    // rust: Tag::Compound(c) => Self::AppendStatic(c),
    // rust: _ => Self::AppendStatic(Compound::new()),
    // rust: },
    // rust: "horizon:edit" => Self::Edit {
    // rust: remove: m["remove"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|k| k.as_str().map(str::to_owned))
    // rust: .collect::<Option<_>>()
    // rust: .ok_or(DecodeError::Field("block entity modifier keys"))?,
    // rust: data: match json_to_nbt(&m["data"]) {
    // rust: Tag::Compound(c) => c,
    // rust: _ => Compound::new(),
    // rust: },
    // rust: },
    // rust: _ => return Err(DecodeError::Field("block entity modifier")),
    // rust: },
    // rust: )
}
}
    // rust: impl Modifier {
    /// RuleBlockEntityModifier.apply: the block entity the output gets.
pub fn apply(self: *Self, nbt: ?*Compound, random: *mut impl ProcessorRandom) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Passthrough => nbt.cloned(),
    // rust: Self::Clear => Some(Compound::new()),
    // rust: Self::AppendLoot(table) => {
    // rust: let mut nbt = nbt.cloned().unwrap_or_default();
    // rust: nbt.insert("LootTable".into(), Tag::String(table.as_str().into()));
    // rust: nbt.insert("LootTableSeed".into(), Tag::Long(random.long()));
    // rust: Some(nbt)
}
    // rust: Self::AppendStatic(data) => Some(edited(nbt, &[], data)),
    // rust: Self::Edit { remove, data } => Some(edited(nbt, remove, data)),
}
}
}
/// A block entity with `remove`'s keys taken out and `data` merged in
/// (append_static is the one with nothing to remove).
pub fn edited(nbt: ?*Compound, remove: *[[]const u8], data: *Compound) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut nbt = nbt.cloned().unwrap_or_default();
    // rust: for key in remove {
    // rust: nbt.remove(&JavaString::from(key.as_str()));
}
    // rust: merge(&mut nbt, data);
    // rust: nbt
}
/// CompoundTag.merge: compounds in both are merged, anything else replaced.
pub fn merge(into: *mut Compound, other: *Compound) void {
}
    // rust: for (key, value) in other {
    // rust: match (into.get_mut(key), value) {
    // rust: (Some(Tag::Compound(mine)), Tag::Compound(theirs)) => merge(mine, theirs),
    // rust: _ => {
    // rust: into.insert(key.clone(), value.clone());
}
}
}
}
pub const Rule = struct {
    input: RuleTest,
    location: RuleTest,
    position: PosRule,
    output: BlockStateId,
    modifier: Modifier,
};
pub const Processor = enum {
    Nop,
    BlockIgnore(BTreeSet<String>),
    BlockRot {,
    rottable: Option<Arc<BTreeSet<BlockStateId>>>,
    integrity: f32,
    // rust: },
    Gravity {,
    heightmap: HeightmapType,
    offset: i32,
    // rust: },
    Rule(Vec<Rule>),
    Protected(Arc<BTreeSet<BlockStateId>>),
    Capped {,
    delegate: Box<Processor>,
    limit: IntProvider,
    // rust: },
    JigsawReplacement,
    BlockAge(f32),
    LavaSubmerged,
    BlackstoneReplace,
    SpawnerMobs(Box<SpawnerMobs>),
    Pick(Box<Pick>),
    CountCap(Box<CountCap>),
    /// `lithostitched:block_swap`: blocks by name become others, keeping
    /// the properties both have (a block the game lacks is left alone).
    BlockSwap(std::collections::BTreeMap<String, String>),
    /// `lithostitched:apply_random`: a processor list drawn by weight runs
    /// on the block.
    ApplyRandom(Box<litho::ApplyRandom>),
    /// `lithostitched:reference`: the named lists run on the block in turn.
    Reference(Vec<ProcessorList>),
    /// `lithostitched:discard_input`: the world's block stays.
    DiscardInput,
    /// `lithostitched:condition`: `then` or `else`
    /// runs on the block, by a test of it.
    Condition(Box<litho::Conditional>),
    /// `lithostitched:set_block`: the block from a state provider.
    SetBlock(Box<litho::SetBlock>),
    /// `horizon:pillar` (Repurposed Structures' and Moog's pillars): a
    /// trigger block starts a column down to the ground.
    Pillar(Box<pillars::Pillar>),
    /// `horizon:bottom_pillar` (Repurposed Structures'): the bottom layer
    /// continues down to the ground.
    BottomPillar(Box<pillars::BottomPillar>),
    /// `horizon:close_off_fluid_sources` (Repurposed Structures' and Moog's):
    /// fluid sources beside open blocks are walled off.
    CloseOffFluidSources(Box<pillars::CloseOffFluidSources>),
    /// `horizon:close_off_air_sources` (Repurposed Structures'): air and
    /// other liquids beside the template's fluids are walled off.
    CloseOffAirSources(Box<pillars::CloseOffAirSources>),
    /// `horizon:yung_pillar` (YUNG's pillars: Better Fortresses, Better
    /// Jungle Temples).
    YungPillar(Box<pillars::YungPillar>),
    /// `horizon:stair_pillar` (Better Fortresses' stair supports).
    StairPillar(Box<pillars::StairPillar>),
    /// `horizon:flood_air` (Better Ocean Monuments'): air below sea level
    /// becomes water.
    FloodAir(Box<sea_level::FloodAir>),
    /// `horizon:waterlog` (Better Ocean Monuments'): blocks below sea level
    /// are waterlogged.
    Waterlog,
    /// `horizon:keep_world_block` (Better Ocean Monuments' structure void).
    KeepWorldBlock(Box<sea_level::KeepWorldBlock>),
    /// `horizon:waterlog_in_world_water` (Repurposed Structures'): blocks
    /// are waterlogged where the world holds water, dry where it does not.
    WaterlogInWorldWater,
    /// `horizon:mineshaft_sky_view` (Repurposed Structures' mineshafts):
    /// nothing above the ocean floor but rails on solid ground.
    MineshaftSkyView,
};
pub const ProcessorList = struct {};

/// The spawner fields `horizon:spawner_mobs` writes: its JSON key, the NBT
/// key and the default (BaseSpawner's).
    // rust: const SPAWNER_FIELDS: [(&str, &str, i16); 7] = [
    // rust: ("delay", "Delay", 20),
    // rust: ("min_spawn_delay", "MinSpawnDelay", 200),
    // rust: ("max_spawn_delay", "MaxSpawnDelay", 800),
    // rust: ("spawn_count", "SpawnCount", 4),
    // rust: ("max_nearby_entities", "MaxNearbyEntities", 6),
    // rust: ("required_player_range", "RequiredPlayerRange", 16),
    // rust: ("spawn_range", "SpawnRange", 4),
    // rust: ];

/// `horizon:pick`, which `horizon-port-pack` writes for the mods' processors
/// that turn a placeholder block into one of several (YUNG's, written in
/// Java): a block of `block` takes the first of `picks` whose `below` is past
/// one `settings.getRandom(pos).nextFloat()`, else `default` (no float is
/// drawn when there are no picks; with no default the block stays).
pub const Pick = struct {
    block: []const u8,
    picks: Vec<(f32,
    default: ?Outcome,
    /// Each pick draws its own `nextFloat` (`if (r.nextFloat() < a) ...
    /// else if (r.nextFloat() < b)`), Better Ocean Monuments' way.
    redraw: bool,
    /// The picked block takes the placeholder's properties
    /// (Block.withPropertiesOf).
    keep_properties: bool,
};
pub const Outcome = struct {
    /// The state, or one of them by `nextInt(len)` (Util.getRandom), drawn
    /// after the pick.
    states: std.ArrayList(BlockStateId),
    /// The new block entity; the block's own stays when missing.
    nbt: ?Compound,
    /// Keys set to lists of `count` strings, each the first of `values`
    /// whose bound is past a new `nextFloat`, else `default` (pot sherds).
    lists: std.ArrayList(PickedList),
};
pub const PickedList = struct {
    key: []const u8,
    count: usize,
    values: Vec<(f32,
    default: []const u8,
};
pub fn below(v: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v["below"]
    // rust: .as_f64()
    // rust: .map(|b| b as f32)
    // rust: .ok_or(DecodeError::Field("pick bound"))
}
    // rust: impl Pick {
    // rust: fn decode(
    // rust: value: &Value,
    // rust: state: impl Fn(&Value) -> Result<BlockStateId, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let outcome = |v: &Value| -> Result<Outcome, DecodeError> {
    // rust: let states = match v.get("states") {
    // rust: Some(list) => list
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("pick states"))?
    // rust: .iter()
    // rust: .map(&state)
    // rust: .collect::<Result<Vec<_>, _>>()?,
    // rust: None => vec![state(&v["state"])?],
}
    // rust: if states.is_empty() {
    // rust: return Err(DecodeError::Field("pick states"));
}
    // rust: let nbt = match v.get("nbt").map(json_to_nbt) {
    // rust: Some(Tag::Compound(c)) => Some(c),
    // rust: Some(_) => return Err(DecodeError::Field("pick nbt")),
    // rust: None => None,
}
    // rust: let text = |v: &Value| {
    // rust: v.as_str()
    // rust: .map(str::to_owned)
    // rust: .ok_or(DecodeError::Field("pick list"))
}
    // rust: let lists = v["lists"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|l| {
    // rust: Ok(PickedList {
    // rust: key: text(&l["key"])?,
    // rust: count: l["count"].as_u64().ok_or(DecodeError::Field("pick list"))? as usize,
    // rust: values: l["values"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|e| Ok((below(e)?, text(&e["value"])?)))
    // rust: .collect::<Result<_, DecodeError>>()?,
    // rust: default: text(&l["default"])?,
    // rust: })
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?;
    // rust: Ok(Outcome { states, nbt, lists })
}
    // rust: Ok(Self {
    // rust: block: value["block"]
    // rust: .as_str()
    // rust: .map(|b| super::super::tags::identifier(b).map(|i| i.to_string()))
    // rust: .ok_or(DecodeError::Field("pick block"))??,
    // rust: picks: value["picks"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|p| Ok((below(p)?, outcome(p)?)))
    // rust: .collect::<Result<_, DecodeError>>()?,
    // rust: default: value.get("default").map(outcome).transpose()?,
    // rust: redraw: value["redraw"].as_bool().unwrap_or(false),
    // rust: keep_properties: value["keep_properties"].as_bool().unwrap_or(false),
    // rust: })
}
pub fn apply(self: *Self, info: BlockInfo, random: *mut dyn ProcessorRandom) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let outcome = match self.picks.is_empty() {
    // rust: true => self.default.as_ref(),
    // rust: false if self.redraw => self
    // rust: .picks
    // rust: .iter()
    // rust: .find(|(b, _)| random.float() < *b)
    // rust: .map(|(_, o)| o)
    // rust: .or(self.default.as_ref()),
    // rust: false => {
    // rust: let f = random.float();
    // rust: self.picks
    // rust: .iter()
    // rust: .find(|(b, _)| f < *b)
    // rust: .map(|(_, o)| o)
    // rust: .or(self.default.as_ref())
}
}
    // rust: let Some(outcome) = outcome else {
    // rust: return info;
}
    // rust: let state = match outcome.states.as_slice() {
    // rust: [one] => *one,
    // rust: many => many[random.int(many.len() as i32) as usize],
}
    // rust: let mut nbt = outcome.nbt.clone().or(info.nbt);
    // rust: for list in &outcome.lists {
    // rust: let values = (0..list.count)
    // rust: .map(|_| {
    // rust: let f = random.float();
    // rust: let v = list
    // rust: .values
    // rust: .iter()
    // rust: .find(|(b, _)| f < *b)
    // rust: .map_or(&list.default, |(_, v)| v);
    // rust: Tag::String(v.as_str().into())
    // rust: })
    // rust: .collect();
    // rust: nbt.get_or_insert_with(Compound::new)
    // rust: .insert(list.key.as_str().into(), Tag::List(values));
}
    // rust: BlockInfo {
    // rust: pos: info.pos,
    // rust: state,
    // rust: nbt,
}
}
}

/// `horizon:count_cap`, which `horizon-port-pack` writes for Better
/// Dungeons' chest processor (Java in the mod): of the `blocks` one
/// placement meets, the first `min` stay, the rest each stay when
/// `settings.getRandom(pos).nextFloat() <= chance` until `max` have, and the
/// others become `replacement`. The count is the placement's (the mod's
/// DungeonContext, set up per StructureTemplate.placeInWorld: one chunk of
/// the piece), shared by every such processor in it.
pub const CountCap = struct {
    blocks: BTreeSet<[]const u8>,
    min: u32,
    max: u32,
    chance: f32,
    replacement: BlockStateId,
};
    // rust: impl CountCap {
    // rust: fn decode(
    // rust: value: &Value,
    // rust: state: impl Fn(&Value) -> Result<BlockStateId, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let count = |key: &'static str| {
    // rust: value[key]
    // rust: .as_u64()
    // rust: .and_then(|n| u32::try_from(n).ok())
    // rust: .ok_or(DecodeError::Field(key))
}
    // rust: Ok(Self {
    // rust: blocks: value["blocks"]
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("blocks"))?
    // rust: .iter()
    // rust: .map(|b| {
    // rust: let b = b.as_str().ok_or(DecodeError::Field("blocks"))?;
    // rust: Ok(super::super::tags::identifier(b)?.to_string())
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?,
    // rust: min: count("min")?,
    // rust: max: count("max")?,
    // rust: chance: float(value, "chance")?,
    // rust: replacement: state(&value["replacement"])?,
    // rust: })
}
    /// Whether a counted block stays, counting it if so.
pub fn keeps(self: *Self, counted: *mut u32, roll: impl FnOnce() f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let keep = *counted < self.min || (*counted < self.max && roll() <= self.chance);
    // rust: *counted += u32::from(keep);
    // rust: keep
}
}

/// `horizon:spawner_mobs`, which `horizon-port-pack` writes for the spawner
/// randomizing processors of Moog's Structure Lib and Repurposed Structures
/// (Java code in the mods): a spawner gets one mob of a weighted list,
/// picked with `settings.getRandom(pos).nextFloat()` as theirs do, and the
/// spawner NBT they write. With no mob to pick it becomes `replacement`.
pub const SpawnerMobs = struct {
    /// Each mob's entity compound (its `id` and any NBT) and weight.
    mobs: Vec<(Compound,
    /// [`SPAWNER_FIELDS`]' values.
    fields: [i16,
    /// `custom_spawn_rules`, in `SpawnData` and the potential alike.
    rules: ?Compound,
    replacement: BlockStateId,
};
    // rust: impl SpawnerMobs {
    // rust: fn decode(
    // rust: value: &Value,
    // rust: replacement: impl FnOnce(Option<&Value>) -> Result<BlockStateId, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let mobs = value["mobs"]
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("spawner_mobs mobs"))?
    // rust: .iter()
    // rust: .map(
    // rust: |m| match (json_to_nbt(&m["entity"]), m["weight"].as_f64()) {
    // rust: (Tag::Compound(entity), Some(weight))
    // rust: if entity.contains_key(&JavaString::from("id")) =>
    // rust: {
    // rust: Ok((entity, weight))
}
    // rust: _ => Err(DecodeError::Field("spawner_mobs mob")),
    // rust: },
    // rust: )
    // rust: .collect::<Result<_, _>>()?;
    // rust: let mut fields = [0; 7];
    // rust: for (field, (key, _, default)) in fields.iter_mut().zip(SPAWNER_FIELDS) {
            // The mods' codecs read ints; the spawner saves them as shorts.
    // rust: *field = value
    // rust: .get(key)
    // rust: .map_or(Some(default), |v| v.as_i64().map(|v| v as i16))
    // rust: .ok_or(DecodeError::Field("spawner_mobs field"))?;
}
    // rust: let rules = match value.get("custom_spawn_rules").map(json_to_nbt) {
    // rust: None => None,
    // rust: Some(Tag::Compound(c)) => Some(c),
    // rust: Some(_) => return Err(DecodeError::Field("spawner_mobs custom_spawn_rules")),
}
    // rust: Ok(Self {
    // rust: mobs,
    // rust: fields,
    // rust: rules,
    // rust: replacement: replacement(value.get("replacement"))?,
    // rust: })
}
    /// The mob for a spawner, drawing from `random` only when there is one
    /// to pick (pickWeightedRandom; Repurposed Structures' getSpawnerMob,
    /// whose float product can round differently only on a boundary).
pub fn pick(self: *Self, random: impl FnOnce() f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let total: f64 = self.mobs.iter().map(|m| m.1).sum();
    // rust: if self.mobs.is_empty() || total <= 0. {
    // rust: return None;
}
    // rust: let mut pick = f64::from(random()) * total;
    // rust: for (entity, weight) in &self.mobs {
    // rust: pick -= weight;
    // rust: if pick <= 0. {
    // rust: return Some(entity);
}
}
    // rust: self.mobs.last().map(|m| &m.0)
}
    /// The spawner's NBT with `entity` as its only potential and next spawn.
pub fn nbt(self: *Self, entity: *Compound) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut data = Compound::new();
    // rust: data.insert("entity".into(), Tag::Compound(entity.clone()));
    // rust: if let Some(rules) = &self.rules {
    // rust: data.insert("custom_spawn_rules".into(), Tag::Compound(rules.clone()));
}
    // rust: let mut potential = Compound::new();
    // rust: potential.insert("data".into(), Tag::Compound(data.clone()));
    // rust: potential.insert("weight".into(), Tag::Int(1));
    // rust: let mut nbt: Compound = SPAWNER_FIELDS
    // rust: .iter()
    // rust: .zip(self.fields)
    // rust: .map(|((_, key, _), v)| (JavaString::from(*key), Tag::Short(v)))
    // rust: .collect();
    // rust: nbt.insert(
    // rust: "SpawnPotentials".into(),
    // rust: Tag::List(vec![Tag::Compound(potential)]),
    // rust: );
    // rust: nbt.insert("SpawnData".into(), Tag::Compound(data));
    // rust: nbt
}
}

    // rust: fn holder_set(
    // rust: value: &Value,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Arc<BTreeSet<BlockStateId>>, DecodeError> {
    // rust: let names: Vec<&str> = match value {
    // rust: Value::String(s) => vec![s.as_str()],
    // rust: Value::Array(a) => a.iter().filter_map(Value::as_str).collect(),
    // rust: _ => return Err(DecodeError::Field("block holder set")),
}
    // rust: let mut out = BTreeSet::new();
    // rust: for name in names {
    // rust: if let Some(tag) = name.strip_prefix('#') {
    // rust: let tag = super::super::tags::identifier(tag)?;
    // rust: out.extend(
    // rust: bindings
    // rust: .tags
    // rust: .get(&tag)
    // rust: .map(|s| s.iter().copied())
    // rust: .into_iter()
    // rust: .flatten(),
    // rust: );
    // rust: } else {
    // rust: let name = super::super::tags::identifier(name)?;
    // rust: out.extend(
    // rust: bindings
    // rust: .blocks
    // rust: .get(&name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown block {name}")))?
    // rust: .iter()
    // rust: .copied(),
    // rust: );
}
}
    // rust: Ok(Arc::new(out))
}
    // rust: pub(super) fn json_to_nbt(value: &Value) -> Tag {
    // rust: match value {
    // rust: Value::Bool(b) => Tag::Byte(i8::from(*b)),
    // rust: Value::Number(n) => match n.as_i64() {
    // rust: Some(i) if i32::try_from(i).is_ok() => Tag::Int(i as i32),
    // rust: Some(i) => Tag::Long(i),
    // rust: None => Tag::Double(n.as_f64().unwrap_or(0.).to_bits()),
    // rust: },
    // rust: Value::String(s) => Tag::String(s.as_str().into()),
    // rust: Value::Array(a) => Tag::List(a.iter().map(json_to_nbt).collect()),
    // rust: Value::Object(o) => Tag::Compound(
    // rust: o.iter()
    // rust: .map(|(k, v)| (JavaString::from(k.as_str()), json_to_nbt(v)))
    // rust: .collect(),
    // rust: ),
    // rust: Value::Null => Tag::End,
}
}
pub fn float(value: *Value, key: *'static str) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: value[key]
    // rust: .as_f64()
    // rust: .map(|v| v as f32)
    // rust: .ok_or(DecodeError::Field(key))
}
/// A required float field vanilla reads through `Codec.floatRange`: a value
/// outside the range, or a NaN, is refused at decode rather than clamped.
pub fn float_range(value: *Value, key: *'static str, min: f32, max: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = float(value, key)?;
    // rust: if !(min..=max).contains(&v) {
    // rust: return Err(DecodeError::Field(key));
}
    // rust: Ok(v)
}
    // rust: impl Processor {
    // rust: fn decode(
    // rust: value: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let kind = value["processor_type"]
    // rust: .as_str()
    // rust: .ok_or(DecodeError::Field("processor_type"))?;
    // rust: let state = |v: &Value| -> Result<BlockStateId, DecodeError> {
    // rust: bindings
    // rust: .codec
    // rust: .decode(&v.to_string(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))
}
    // rust: Ok(match super::super::tags::identifier(kind)?.as_str() {
    // rust: "minecraft:nop" => Self::Nop,
    // rust: "minecraft:block_ignore" => Self::BlockIgnore(
    // rust: value["blocks"]
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("block_ignore blocks"))?
    // rust: .iter()
    // rust: .map(|b| state(b).map(|id| resources.registry.state(id).unwrap().name.clone()))
    // rust: .collect::<Result<_, _>>()?,
    // rust: ),
    // rust: "minecraft:block_rot" => Self::BlockRot {
    // rust: rottable: match value.get("rottable_blocks") {
    // rust: Some(v) => Some(holder_set(v, bindings)?),
    // rust: None => None,
    // rust: },
    // rust: integrity: float_range(value, "integrity", 0., 1.)?,
    // rust: },
    // rust: "minecraft:gravity" => Self::Gravity {
    // rust: heightmap: match value.get("heightmap").and_then(Value::as_str) {
    // rust: Some(name) => HeightmapType::ALL
    // rust: .into_iter()
    // rust: .find(|k| k.name() == name)
    // rust: .ok_or(DecodeError::Field("gravity heightmap"))?,
    // rust: None => HeightmapType::WorldSurfaceWg,
    // rust: },
    // rust: offset: value.get("offset").and_then(Value::as_i64).unwrap_or(0) as i32,
    // rust: },
    // rust: "minecraft:protected_blocks" => Self::Protected(holder_set(&value["value"], bindings)?),
    // rust: "minecraft:jigsaw_replacement" => Self::JigsawReplacement,
    // rust: "minecraft:block_age" => Self::BlockAge(float(value, "mossiness")?),
    // rust: "minecraft:lava_submerged_block" => Self::LavaSubmerged,
    // rust: "minecraft:blackstone_replace" => Self::BlackstoneReplace,
    // rust: "minecraft:capped" => {
                // CappedProcessor's limit is IntProviders.POSITIVE_CODEC: a
                // provider that can draw 0 or less is refused at decode.
    // rust: let limit = IntProvider::from_json(&value["limit"].to_string())?;
    // rust: if limit.bounds()[0] < 1 {
    // rust: return Err(DecodeError::Field("capped limit"));
}
    // rust: Self::Capped {
    // rust: delegate: Box::new(Self::decode(&value["delegate"], resources, bindings)?),
    // rust: limit,
}
}
    // rust: "minecraft:rule" => Self::Rule(
    // rust: value["rules"]
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("rules"))?
    // rust: .iter()
    // rust: .map(|rule| {
    // rust: let test = |key| RuleTest::from_json(&rule[key].to_string(), bindings);
    // rust: let position = PosRule::decode(rule.get("position_predicate"))?;
    // rust: let modifier = Modifier::decode(rule.get("block_entity_modifier"))?;
    // rust: Ok(Rule {
    // rust: input: test("input_predicate")?,
    // rust: location: test("location_predicate")?,
    // rust: position,
    // rust: output: state(&rule["output_state"])?,
    // rust: modifier,
    // rust: })
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?,
    // rust: ),
    // rust: "horizon:spawner_mobs" => {
    // rust: Self::SpawnerMobs(Box::new(SpawnerMobs::decode(value, |v| match v {
    // rust: Some(v) => state(v),
    // rust: None => Ok(resources.registry.default_state("minecraft:air").unwrap()),
    // rust: })?))
}
    // rust: "horizon:pick" => Self::Pick(Box::new(Pick::decode(value, state)?)),
    // rust: "lithostitched:block_swap" => Self::BlockSwap(
    // rust: value["blocks"]
    // rust: .as_object()
    // rust: .ok_or(DecodeError::Field("blocks"))?
    // rust: .iter()
    // rust: .map(|(from, to)| {
    // rust: let to = to.as_str().ok_or(DecodeError::Field("blocks"))?;
    // rust: Ok((
    // rust: super::super::tags::identifier(from)?.to_string(),
    // rust: super::super::tags::identifier(to)?.to_string(),
    // rust: ))
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?,
    // rust: ),
    // rust: "horizon:count_cap" => Self::CountCap(Box::new(CountCap::decode(value, state)?)),
    // rust: "lithostitched:apply_random" => Self::ApplyRandom(Box::new(
    // rust: litho::ApplyRandom::decode(value, resources, bindings)?,
    // rust: )),
    // rust: "lithostitched:set_block" => {
    // rust: Self::SetBlock(Box::new(litho::SetBlock::decode(value, state)?))
}
    // rust: "lithostitched:reference" => {
    // rust: Self::Reference(litho::reference(value, resources, bindings)?)
}
    // rust: "lithostitched:discard_input" => Self::DiscardInput,
    // rust: "horizon:pillar" => Self::Pillar(Box::new(pillars::Pillar::decode(
    // rust: value, resources, bindings, state,
    // rust: )?)),
    // rust: "horizon:bottom_pillar" => Self::BottomPillar(Box::new(pillars::BottomPillar::decode(
    // rust: value, resources, bindings,
    // rust: )?)),
    // rust: "horizon:close_off_fluid_sources" => Self::CloseOffFluidSources(Box::new(
    // rust: pillars::CloseOffFluidSources::decode(value, resources, bindings)?,
    // rust: )),
    // rust: "horizon:close_off_air_sources" => Self::CloseOffAirSources(Box::new(
    // rust: pillars::CloseOffAirSources::decode(value, resources, bindings)?,
    // rust: )),
    // rust: "horizon:yung_pillar" => Self::YungPillar(Box::new(pillars::YungPillar::decode(
    // rust: value, bindings, state,
    // rust: )?)),
    // rust: "horizon:stair_pillar" => Self::StairPillar(Box::new(pillars::StairPillar::decode(
    // rust: value, resources, bindings,
    // rust: )?)),
    // rust: "horizon:flood_air" => {
    // rust: Self::FloodAir(Box::new(sea_level::FloodAir::decode(resources.registry)?))
}
    // rust: "horizon:waterlog" => Self::Waterlog,
    // rust: "horizon:waterlog_in_world_water" => Self::WaterlogInWorldWater,
    // rust: "horizon:mineshaft_sky_view" => Self::MineshaftSkyView,
    // rust: "horizon:keep_world_block" => {
    // rust: Self::KeepWorldBlock(Box::new(sea_level::KeepWorldBlock::decode(value)?))
}
    // rust: "lithostitched:condition" => Self::Condition(Box::new(litho::Conditional::decode(
    // rust: value, resources, bindings,
    // rust: )?)),
    // rust: _ => return Err(DecodeError::Field("structure processor type")),
    // rust: })
}
pub fn evaluates_entire_piece(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Self::Capped { .. })
}
}
    // rust: impl ProcessorList {
    /// A processor list holder: a registry name, `{"processors": [...]}` or a list.
    // rust: pub fn decode(
    // rust: json: &str,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
        // Lists name lists (a pillar's, Lithostitched's): a cycle of names
        // is refused rather than followed.
    // rust: thread_local!(static DEPTH: std::cell::Cell<u32> = const { std::cell::Cell::new(0) });
    // rust: let depth = DEPTH.get();
    // rust: if depth >= 16 {
    // rust: return Err(DecodeError::Field("processor lists nest too deep"));
}
    // rust: DEPTH.set(depth + 1);
    // rust: let decoded = Self::decode_at(json, resources, bindings);
    // rust: DEPTH.set(depth);
    // rust: decoded
}
    // rust: fn decode_at(
    // rust: json: &str,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let value: Value = serde_json::from_str(json)?;
    // rust: let value = match &value {
    // rust: Value::String(name) => {
    // rust: let name = super::super::tags::identifier(name)?;
    // rust: let raw = resources.processor_lists.get(&name).ok_or_else(|| {
    // rust: DecodeError::Registry(format!("unknown processor list {name}"))
    // rust: })?;
    // rust: serde_json::from_str(raw)?
}
    // rust: other => other.clone(),
}
    // rust: let list = match &value {
    // rust: Value::Array(a) => a.clone(),
    // rust: Value::Object(_) => value["processors"].as_array().cloned().unwrap_or_default(),
    // rust: _ => return Err(DecodeError::Field("processor list")),
}
    // rust: Ok(Self(
    // rust: list.iter()
    // rust: .map(|p| Processor::decode(p, resources, bindings))
    // rust: .collect::<Result<_, _>>()?,
    // rust: ))
}
}

/// StructurePlaceSettings without entity options.
pub const PlaceSettings = struct {
    mirror: Mirror,
    rotation: Rotation,
    pivot: [i32,
    bounding_box: ?BoundingBox,
    processors: std.ArrayList(*'a Processor),
    waterlogging: bool,
    random: ?*'a mut dyn ProcessorRandom,
    /// StructurePlaceSettings.knownShape: skip the neighbor shape updates
    /// after placement (jigsaw pieces).
    known_shape: bool,
    /// StructurePlaceSettings.ignoreEntities / finalizeEntities.
    ignore_entities: bool,
    finalize_entities: bool,
    /// The blocks `horizon:count_cap` kept in this placement.
    counted: u32,
};
    // rust: impl<'a> PlaceSettings<'a> {
pub fn new(rotation: Rotation) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: mirror: Mirror::None,
    // rust: rotation,
    // rust: pivot: [0; 3],
    // rust: bounding_box: None,
    // rust: processors: Vec::new(),
    // rust: waterlogging: true,
    // rust: random: None,
    // rust: known_shape: false,
    // rust: ignore_entities: false,
    // rust: finalize_entities: false,
    // rust: counted: 0,
}
}
pub fn with_processors(list: *'a ProcessorList) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.processors.extend(list.0.iter());
    // rust: self
}
    /// settings.getRandom(pos): the shared random, else a position-seeded one.
    // rust: fn with_random<T>(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: f: impl FnOnce(&mut dyn ProcessorRandom) -> T,
    // rust: ) -> T {
    // rust: match self.random.as_deref_mut() {
    // rust: Some(random) => f(random),
    // rust: None => f(&mut LegacyRandom::new(position_seed(BlockPos::new(
    // rust: pos[0], pos[1], pos[2],
    // rust: )))),
}
}
}

/// Block.withPropertiesOf: `block`'s default state with each property of
/// `from` it has too (by name, when the value is one of its own). None for
/// a block the registry does not know (the mod keeps the block then).
    // rust: fn with_properties_of(
    // rust: registry: &crate::registry::BlockRegistry,
    // rust: block: &str,
    // rust: from: BlockStateId,
    // rust: ) -> Option<BlockStateId> {
    // rust: let default = registry.default_state(block)?;
    // rust: let mut state = registry.state(default)?.clone();
    // rust: for (key, value) in &registry.state(from)?.properties {
    // rust: if let Some(own) = state.properties.get(key)
    // rust: && own != value
    // rust: {
    // rust: let mut changed = state.clone();
    // rust: changed.properties.insert(key.clone(), value.clone());
    // rust: if registry.id(&changed).is_some() {
    // rust: state = changed;
}
}
}
    // rust: registry.id(&state)
}

/// BlackstoneReplaceProcessor's block map.
pub fn blackstone(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match name.strip_prefix("minecraft:")? {
    // rust: "cobblestone" | "mossy_cobblestone" => "blackstone",
    // rust: "stone" => "polished_blackstone",
    // rust: "stone_bricks" | "mossy_stone_bricks" => "polished_blackstone_bricks",
    // rust: "cobblestone_stairs" | "mossy_cobblestone_stairs" => "blackstone_stairs",
    // rust: "stone_stairs" => "polished_blackstone_stairs",
    // rust: "stone_brick_stairs" | "mossy_stone_brick_stairs" => "polished_blackstone_brick_stairs",
    // rust: "cobblestone_slab" | "mossy_cobblestone_slab" => "blackstone_slab",
    // rust: "smooth_stone_slab" | "stone_slab" => "polished_blackstone_slab",
    // rust: "stone_brick_slab" | "mossy_stone_brick_slab" => "polished_blackstone_brick_slab",
    // rust: "stone_brick_wall" | "mossy_stone_brick_wall" => "polished_blackstone_brick_wall",
    // rust: "cobblestone_wall" | "mossy_cobblestone_wall" => "blackstone_wall",
    // rust: "chiseled_stone_bricks" => "chiseled_polished_blackstone",
    // rust: "cracked_stone_bricks" => "cracked_polished_blackstone_bricks",
    // rust: "iron_bars" => "iron_chain",
    // rust: _ => return None,
    // rust: })
}
    // rust: type ProcessResult = Result<Option<BlockInfo>, PlacementQueryError>;
/// The processors of a list in turn, until one removes the block.
    // rust: fn process_list<W: PlacementContext>(
    // rust: list: &ProcessorList,
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: position: [i32; 3],
    // rust: reference: [i32; 3],
    // rust: relative: [i32; 3],
    // rust: info: BlockInfo,
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: let mut current = info;
    // rust: for processor in &list.0 {
    // rust: match process_block(
    // rust: processor, world, resources, position, reference, relative, current, settings,
    // rust: )? {
    // rust: Some(next) => current = next,
    // rust: None => return Ok(None),
}
}
    // rust: Ok(Some(current))
}
/// StructureProcessor.processBlock: `position` is the piece's, `reference`
/// the structure's pivot and `relative` the block's in the template.
    // rust: fn process_block<W: PlacementContext>(
    // rust: processor: &Processor,
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: position: [i32; 3],
    // rust: reference: [i32; 3],
    // rust: relative: [i32; 3],
    // rust: info: BlockInfo,
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: let registry = resources.registry;
    // rust: let name = |id: BlockStateId| registry.state(id).map(|s| s.name.as_str()).unwrap_or("");
    // rust: Ok(match processor {
    // rust: Processor::Nop => Some(info),
    // rust: Processor::BlockIgnore(blocks) => (!blocks.contains(name(info.state))).then_some(info),
    // rust: Processor::BlockRot {
    // rust: rottable,
    // rust: integrity,
    // rust: } => {
    // rust: let candidate = rottable
    // rust: .as_ref()
    // rust: .is_none_or(|set| set.contains(&info.state));
    // rust: let keep = settings.with_random(info.pos, |r| !candidate || r.float() <= *integrity);
    // rust: keep.then_some(info)
}
    // rust: Processor::Gravity { heightmap, offset } => {
    // rust: let height = world.height(*heightmap, info.pos[0], info.pos[2])? + offset;
    // rust: Some(BlockInfo {
    // rust: pos: [info.pos[0], height + relative[1], info.pos[2]],
    // rust: ..info
    // rust: })
}
    // rust: Processor::Protected(set) => (!set.contains(&world.block_state(info.pos)?)).then_some(info),
    // rust: Processor::JigsawReplacement => {
    // rust: if !resources.is_jigsaw(info.state) {
    // rust: return Ok(Some(info));
}
    // rust: let Some(nbt) = &info.nbt else {
    // rust: return Ok(Some(info));
}
    // rust: let text = match nbt.get(&JavaString::from("final_state")) {
    // rust: Some(Tag::String(s)) => s.to_string_lossy(),
    // rust: _ => "minecraft:air".to_owned(),
}
    // rust: let Some(state) = super::template::parse_state_string(registry, &text) else {
    // rust: return Ok(None);
}
    // rust: (name(state) != "minecraft:structure_void").then_some(BlockInfo {
    // rust: pos: info.pos,
    // rust: state,
    // rust: nbt: None,
    // rust: })
}
    // rust: Processor::LavaSubmerged => {
    // rust: let lava = name(world.block_state(info.pos)?) == "minecraft:lava";
    // rust: if lava && !resources.transforms.full_block(info.state) {
    // rust: Some(BlockInfo {
    // rust: state: registry.default_state("minecraft:lava").unwrap(),
    // rust: ..info
    // rust: })
    // rust: } else {
    // rust: Some(info)
}
}
    // rust: Processor::BlockAge(mossiness) => block_age(*mossiness, info, settings, resources),
    // rust: Processor::BlackstoneReplace => {
    // rust: let Some(target) = blackstone(name(info.state)) else {
    // rust: return Ok(Some(info));
}
    // rust: let old = registry.state(info.state);
    // rust: let properties: Vec<(&str, &str)> = ["facing", "half", "type"]
    // rust: .into_iter()
    // rust: .filter_map(|k| Some((k, old?.properties.get(k)?.as_str())))
    // rust: .collect();
    // rust: Some(BlockInfo {
    // rust: state: super::legacy::state(resources, target, &properties),
    // rust: ..info
    // rust: })
}
    // rust: Processor::Rule(rules) => {
    // rust: let mut random = LegacyRandom::new(position_seed(BlockPos::new(
    // rust: info.pos[0],
    // rust: info.pos[1],
    // rust: info.pos[2],
    // rust: )));
    // rust: for rule in rules {
    // rust: if !rule.input.test(info.state, info.pos, &mut random) {
    // rust: continue;
}
    // rust: let located = world.block_state(info.pos)?;
    // rust: if !rule.location.test(located, info.pos, &mut random) {
    // rust: continue;
}
    // rust: let position_ok = rule
    // rust: .position
    // rust: .test(relative, info.pos, reference, &mut random);
    // rust: if !position_ok {
    // rust: continue;
}
    // rust: return Ok(Some(BlockInfo {
    // rust: pos: info.pos,
    // rust: state: rule.output,
    // rust: nbt: rule.modifier.apply(info.nbt.as_ref(), &mut random),
    // rust: }));
}
    // rust: Some(info)
}
    // rust: Processor::Capped { .. } => Some(info),
    // rust: Processor::BlockSwap(blocks) => {
    // rust: let swapped = blocks
    // rust: .get(name(info.state))
    // rust: .and_then(|to| with_properties_of(registry, to, info.state));
    // rust: Some(match swapped {
    // rust: Some(state) => BlockInfo { state, ..info },
    // rust: None => info,
    // rust: })
}
    // rust: Processor::CountCap(cap) => match cap.blocks.contains(name(info.state)) {
    // rust: true => {
    // rust: let pos = info.pos;
    // rust: let mut counted = settings.counted;
    // rust: let keep = cap.keeps(&mut counted, || settings.with_random(pos, |r| r.float()));
    // rust: settings.counted = counted;
    // rust: Some(match keep {
    // rust: true => info,
    // rust: false => BlockInfo {
    // rust: pos,
    // rust: state: cap.replacement,
    // rust: nbt: None,
    // rust: },
    // rust: })
}
    // rust: false => Some(info),
    // rust: },
    // rust: Processor::ApplyRandom(apply) => {
    // rust: let mut random = apply.draws.random(world.world_seed()?, position, info.pos);
    // rust: match apply.pick(&mut random) {
    // rust: Some(list) => {
    // rust: return process_list(
    // rust: list, world, resources, position, reference, relative, info, settings,
    // rust: );
}
    // rust: None => Some(info),
}
}
    // rust: Processor::Reference(lists) => {
    // rust: let mut current = info;
    // rust: for list in lists {
    // rust: match process_list(
    // rust: list, world, resources, position, reference, relative, current, settings,
    // rust: )? {
    // rust: Some(next) => current = next,
    // rust: None => return Ok(None),
}
}
    // rust: Some(current)
}
    // rust: Processor::DiscardInput => None,
    // rust: Processor::SetBlock(set) => {
    // rust: let mut random = set.draws.random(world.world_seed()?, position, info.pos);
    // rust: let state = set.state(&mut random);
    // rust: let state = match set.preserve {
    // rust: true => registry
    // rust: .state(state)
    // rust: .and_then(|s| with_properties_of(registry, &s.name, info.state))
    // rust: .unwrap_or(state),
    // rust: false => state,
}
    // rust: let nbt = set.modifier.apply(info.nbt.as_ref(), &mut random);
    // rust: Some(BlockInfo { state, nbt, ..info })
}
    // rust: Processor::Condition(c) => {
    // rust: let mut random = c.draws.random(world.world_seed()?, position, info.pos);
    // rust: let location = world.block_state(info.pos)?;
    // rust: let passed = c
    // rust: .condition
    // rust: .test(info.state, location, registry, &mut random);
    // rust: let list = if passed { &c.then } else { &c.otherwise };
    // rust: return process_list(
    // rust: list, world, resources, position, reference, relative, info, settings,
    // rust: );
}
    // rust: Processor::Pillar(p) => return p.process(world, resources, position, info, settings),
    // rust: Processor::BottomPillar(p) => {
    // rust: return p.process(world, resources, position, relative, info, settings);
}
    // rust: Processor::CloseOffFluidSources(p) => return p.process(world, info, settings),
    // rust: Processor::CloseOffAirSources(p) => return p.process(world, info, settings),
    // rust: Processor::YungPillar(p) => return p.process(world, resources, info, settings),
    // rust: Processor::StairPillar(p) => return p.process(world, resources, info, settings),
    // rust: Processor::FloodAir(p) => return p.process(world, info),
    // rust: Processor::Waterlog => {
    // rust: return sea_level::Waterlog::process(world, resources.registry, info, settings);
}
    // rust: Processor::KeepWorldBlock(p) => {
    // rust: return p.process(world, resources.registry, info, settings);
}
    // rust: Processor::WaterlogInWorldWater => {
    // rust: return sea_level::WaterlogInWorldWater::process(
    // rust: world,
    // rust: resources.registry,
    // rust: info,
    // rust: settings,
    // rust: );
}
    // rust: Processor::MineshaftSkyView => {
    // rust: return sea_level::MineshaftSkyView::process(world, resources.registry, info);
}
    // rust: Processor::Pick(pick) => match name(info.state) == pick.block {
    // rust: true => {
    // rust: let mut out = settings.with_random(info.pos, |r| pick.apply(info.clone(), r));
    // rust: if pick.keep_properties
    // rust: && let Some(kept) = registry
    // rust: .state(out.state)
    // rust: .and_then(|s| with_properties_of(registry, &s.name, info.state))
    // rust: {
    // rust: out.state = kept;
}
    // rust: Some(out)
}
    // rust: false => Some(info),
    // rust: },
    // rust: Processor::SpawnerMobs(spawner) => {
    // rust: if name(info.state) != "minecraft:spawner" {
    // rust: return Ok(Some(info));
}
    // rust: let pos = info.pos;
    // rust: let entity = spawner.pick(|| settings.with_random(pos, |r| r.float()));
    // rust: Some(match entity {
    // rust: Some(entity) => BlockInfo {
    // rust: nbt: Some(spawner.nbt(entity)),
    // rust: ..info
    // rust: },
    // rust: None => BlockInfo {
    // rust: pos,
    // rust: state: spawner.replacement,
    // rust: nbt: None,
    // rust: },
    // rust: })
}
    // rust: })
}
    // rust: fn block_age(
    // rust: mossiness: f32,
    // rust: info: BlockInfo,
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: resources: &StructureResources,
    // rust: ) -> Option<BlockInfo> {
    // rust: let registry = resources.registry;
    // rust: let state = registry.state(info.state)?.clone();
    // rust: let default = |n: &str| registry.default_state(n).unwrap();
    // rust: let with_props = |n: &str| {
    // rust: let mut target = registry.state(default(n)).unwrap().clone();
    // rust: for (k, v) in &state.properties {
    // rust: if target.properties.contains_key(k) {
    // rust: target.properties.insert(k.clone(), v.clone());
}
}
    // rust: registry.id(&target).unwrap_or(default(n))
}
    // rust: let random_stairs = |r: &mut dyn ProcessorRandom, n: &str| {
    // rust: let facing = ["north", "east", "south", "west"][r.int(4) as usize];
    // rust: let half = ["top", "bottom"][r.int(2) as usize];
    // rust: let mut target = registry.state(default(n)).unwrap().clone();
    // rust: target.properties.insert("facing".into(), facing.into());
    // rust: target.properties.insert("half".into(), half.into());
    // rust: registry.id(&target).unwrap()
}
    // rust: let name = state.name.as_str();
    // rust: let is_tag = |tag: &str| {
        // Tags are matched by block name through the template resources' bindings.
    // rust: resources
    // rust: .block_tags
    // rust: .get(tag)
    // rust: .is_some_and(|set| set.contains(name))
}
    // rust: let new_state = settings.with_random(info.pos, |r| -> Option<BlockStateId> {
    // rust: let pick = |r: &mut dyn ProcessorRandom, non: &[BlockStateId], mossy: &[BlockStateId]| {
    // rust: if r.float() < mossiness {
    // rust: mossy[r.int(mossy.len() as i32) as usize]
    // rust: } else {
    // rust: non[r.int(non.len() as i32) as usize]
}
}
    // rust: if matches!(
    // rust: name,
    // rust: "minecraft:stone_bricks" | "minecraft:stone" | "minecraft:chiseled_stone_bricks"
    // rust: ) {
    // rust: if r.float() >= 0.5 {
    // rust: return None;
}
    // rust: let non = [
    // rust: default("minecraft:cracked_stone_bricks"),
    // rust: random_stairs(r, "minecraft:stone_brick_stairs"),
    // rust: ];
    // rust: let mossy = [
    // rust: default("minecraft:mossy_stone_bricks"),
    // rust: random_stairs(r, "minecraft:mossy_stone_brick_stairs"),
    // rust: ];
    // rust: Some(pick(r, &non, &mossy))
    // rust: } else if is_tag("minecraft:stairs") {
    // rust: if r.float() >= 0.5 {
    // rust: return None;
}
    // rust: let non = [
    // rust: default("minecraft:stone_slab"),
    // rust: default("minecraft:stone_brick_slab"),
    // rust: ];
    // rust: let mossy = [
    // rust: with_props("minecraft:mossy_stone_brick_stairs"),
    // rust: default("minecraft:mossy_stone_brick_slab"),
    // rust: ];
    // rust: Some(pick(r, &non, &mossy))
    // rust: } else if is_tag("minecraft:slabs") {
    // rust: (r.float() < mossiness).then(|| with_props("minecraft:mossy_stone_brick_slab"))
    // rust: } else if is_tag("minecraft:walls") {
    // rust: (r.float() < mossiness).then(|| with_props("minecraft:mossy_stone_brick_wall"))
    // rust: } else if name == "minecraft:obsidian" {
    // rust: (r.float() < 0.15).then(|| default("minecraft:crying_obsidian"))
    // rust: } else {
    // rust: None
}
    // rust: });
    // rust: Some(match new_state {
    // rust: Some(state) => BlockInfo { state, ..info },
    // rust: None => info,
    // rust: })
}

/// StructureTemplate.processBlockInfos.
    // rust: fn process_infos<W: PlacementContext>(
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: template: &StructureTemplate,
    // rust: palette: usize,
    // rust: position: [i32; 3],
    // rust: reference: [i32; 3],
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: ) -> Result<Vec<BlockInfo>, PlacementQueryError> {
    // rust: settings.counted = 0;
    // rust: let whole = settings
    // rust: .processors
    // rust: .iter()
    // rust: .any(|p| p.evaluates_entire_piece());
    // rust: let mut original = Vec::new();
    // rust: let mut processed = Vec::new();
    // rust: for info in template.palettes()[palette].blocks() {
    // rust: let relative = StructureTemplate::transform(
    // rust: info.pos,
    // rust: settings.mirror,
    // rust: settings.rotation,
    // rust: settings.pivot,
    // rust: );
    // rust: let pos = std::array::from_fn(|i| relative[i] + position[i]);
    // rust: if !whole && settings.bounding_box.is_some_and(|b| !b.is_inside(pos)) {
    // rust: continue;
}
    // rust: let mut current = Some(BlockInfo {
    // rust: pos,
    // rust: state: info.state,
    // rust: nbt: info.nbt.clone(),
    // rust: });
    // rust: let processors = settings.processors.clone();
    // rust: for processor in processors {
    // rust: let Some(value) = current.take() else { break };
    // rust: current = process_block(
    // rust: processor, world, resources, position, reference, info.pos, value, settings,
    // rust: )?;
}
    // rust: if let Some(value) = current {
    // rust: processed.push(value);
    // rust: original.push(info.clone());
}
}
    // rust: let processors = settings.processors.clone();
    // rust: for processor in processors {
    // rust: let Processor::Capped { delegate, limit } = processor else {
    // rust: continue;
}
    // rust: if limit.bounds()[1] == 0 || processed.is_empty() || original.len() != processed.len() {
    // rust: continue;
}
    // rust: let seed = world.world_seed()?;
    // rust: let mut random = LegacyRandom::new(seed).fork_positional().at(BlockPos::new(
    // rust: position[0],
    // rust: position[1],
    // rust: position[2],
    // rust: ));
    // rust: let max = limit
    // rust: .sample(&mut random)
    // rust: .unwrap_or(0)
    // rust: .min(processed.len() as i32);
    // rust: if max < 1 {
    // rust: continue;
}
    // rust: let mut indices: Vec<usize> = (0..processed.len()).collect();
    // rust: for i in (2..=indices.len()).rev() {
    // rust: let swap = random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: indices.swap(i - 1, swap);
}
    // rust: let mut replaced = 0;
    // rust: for index in indices {
    // rust: if replaced >= max {
    // rust: break;
}
    // rust: let before = processed[index].clone();
    // rust: let altered = process_block(
    // rust: delegate,
    // rust: world,
    // rust: resources,
    // rust: position,
    // rust: reference,
    // rust: original[index].pos,
    // rust: before.clone(),
    // rust: settings,
    // rust: )?;
    // rust: if let Some(altered) = altered {
    // rust: if altered != before {
    // rust: replaced += 1;
    // rust: processed[index] = altered;
}
}
}
}
    // rust: Ok(processed)
}

/// StructureTemplate.placeInWorld. Returns false for a template with no
/// palette, with no blocks and no entities to place, or with a side below 1.
    // rust: pub fn place_in_world<W: FeatureWorld + PlacementContext>(
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: template: &StructureTemplate,
    // rust: position: [i32; 3],
    // rust: reference: [i32; 3],
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: mut loot_random: Option<&mut dyn ProcessorRandom>,
    // rust: flags: i32,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: if template.palettes().is_empty() {
    // rust: return Ok(false);
}
    // rust: let palette = match settings.random.as_deref_mut() {
    // rust: Some(r) => r.int(template.palettes().len() as i32) as usize,
    // rust: None => LegacyRandom::new(position_seed(BlockPos::new(
    // rust: position[0],
    // rust: position[1],
    // rust: position[2],
    // rust: )))
    // rust: .next_int_bound(template.palettes().len() as i32)
    // rust: .unwrap_or(0) as usize,
}
    // rust: let has_entities = !settings.ignore_entities && !template.entities.is_empty();
    // rust: if (template.palettes()[palette].blocks().is_empty() && !has_entities)
    // rust: || template.size.iter().any(|s| *s < 1)
    // rust: {
    // rust: return Ok(false);
}
    // rust: let infos = process_infos(
    // rust: world, resources, template, palette, position, reference, settings,
    // rust: )?;
    // rust: let barrier = resources
    // rust: .registry
    // rust: .default_state("minecraft:barrier")
    // rust: .unwrap();
    // rust: let mut to_fill = Vec::new();
    // rust: let mut locked = Vec::new();
    // rust: let mut placed = Vec::new();
    // rust: let world_err = |_| PlacementQueryError::Failed("template write".into());
    // rust: for info in infos {
    // rust: if settings
    // rust: .bounding_box
    // rust: .is_some_and(|b| !b.is_inside(info.pos))
    // rust: {
    // rust: continue;
}
    // rust: let previous = if settings.waterlogging {
    // rust: Some(world.fluid_state(info.pos)?)
    // rust: } else {
    // rust: None
}
    // rust: let state = resources.transforms.rotate(
    // rust: resources.transforms.mirror(info.state, settings.mirror),
    // rust: settings.rotation,
    // rust: );
    // rust: if info.nbt.is_some() {
    // rust: world.set_block(info.pos, barrier, 820).map_err(world_err)?;
}
    // rust: if !world.set_block(info.pos, state, flags).map_err(world_err)? {
    // rust: continue;
}
    // rust: placed.push(info.pos);
    // rust: if let Some(mut nbt) = info.nbt {
    // rust: if resources.transforms.loot_container(state) {
    // rust: let seed = match loot_random.as_deref_mut() {
    // rust: Some(random) => random.long(),
    // rust: None => settings.random.as_deref_mut().map_or(0, |r| r.long()),
}
    // rust: nbt.insert("LootTableSeed".into(), Tag::Long(seed));
}
    // rust: world.set_block_entity(info.pos, nbt)?;
}
    // rust: if let Some(previous) = previous {
    // rust: if resources.source_fluid(state) {
    // rust: locked.push(info.pos);
    // rust: } else if let Some(wet) = resources.waterlogged.get(&state) {
    // rust: if previous.kind() == FluidKind::Water {
    // rust: world.set_block(info.pos, *wet, 3).map_err(world_err)?;
    // rust: world.schedule_fluid_tick(info.pos, previous.kind(), 5).ok();
    // rust: } else if !previous.is_source() {
    // rust: to_fill.push(info.pos);
}
}
}
}
    // rust: let mut filled = true;
    // rust: while filled && !to_fill.is_empty() {
    // rust: filled = false;
    // rust: let mut remaining = Vec::new();
    // rust: for pos in std::mem::take(&mut to_fill) {
    // rust: let mut fluid = world.fluid_state(pos)?;
    // rust: for d in [[0, 1, 0], [0, 0, -1], [1, 0, 0], [0, 0, 1], [-1, 0, 0]] {
    // rust: if fluid.is_source() {
    // rust: break;
}
    // rust: let n = [pos[0] + d[0], pos[1] + d[1], pos[2] + d[2]];
    // rust: let neighbor = world.fluid_state(n)?;
    // rust: if neighbor.is_source() && !locked.contains(&n) {
    // rust: fluid = neighbor;
}
}
    // rust: let state = world.block_state(pos)?;
    // rust: match resources.waterlogged.get(&state) {
    // rust: Some(wet) if fluid.is_source() && fluid.kind() == FluidKind::Water => {
    // rust: world.set_block(pos, *wet, 3).map_err(world_err)?;
    // rust: world.schedule_fluid_tick(pos, fluid.kind(), 5).ok();
    // rust: filled = true;
}
    // rust: _ => remaining.push(pos),
}
}
    // rust: to_fill = remaining;
}
    // rust: if !settings.known_shape && !placed.is_empty() {
    // rust: update_shape_at_edge(world, &placed, flags)?;
    // rust: for &pos in &placed {
    // rust: world.update_from_neighbour_shapes(pos, flags & !1 | 16)?;
}
}
    // rust: if !settings.ignore_entities {
    // rust: place_entities(world, template, position, settings)?;
}
    // rust: Ok(true)
}

/// StructureTemplate.placeEntities: each saved entity moved, turned and
/// mirrored with the template, its NBT handed to the world.
    // rust: fn place_entities<W: PlacementContext>(
    // rust: world: &mut W,
    // rust: template: &StructureTemplate,
    // rust: position: [i32; 3],
    // rust: settings: &PlaceSettings<'_>,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let (mirror, rotation, pivot) = (settings.mirror, settings.rotation, settings.pivot);
    // rust: for e in &template.entities {
    // rust: let b = StructureTemplate::transform(e.block_pos, mirror, rotation, pivot);
    // rust: let block_pos = [b[0] + position[0], b[1] + position[1], b[2] + position[2]];
    // rust: if settings
    // rust: .bounding_box
    // rust: .is_some_and(|bb| !bb.is_inside(block_pos))
    // rust: {
    // rust: continue;
}
    // rust: let r = StructureTemplate::transform_vec(e.pos, mirror, rotation, pivot);
    // rust: let pos = [
    // rust: r[0] + f64::from(position[0]),
    // rust: r[1] + f64::from(position[1]),
    // rust: r[2] + f64::from(position[2]),
    // rust: ];
    // rust: let mut nbt = e.nbt.clone();
    // rust: nbt.insert(
    // rust: "Pos".into(),
    // rust: Tag::List(pos.iter().map(|v| Tag::Double(v.to_bits())).collect()),
    // rust: );
    // rust: nbt.remove(&"UUID".into());
    // rust: if nbt.contains_key(&"block_pos".into()) {
    // rust: nbt.insert("block_pos".into(), Tag::IntArray(block_pos.to_vec()));
}
    // rust: for (key, i) in [("TileX", 0), ("TileY", 1), ("TileZ", 2)] {
    // rust: if nbt.contains_key(&key.into()) {
    // rust: nbt.insert(key.into(), Tag::Int(block_pos[i]));
}
}
        // Entity.rotate + Entity.mirror on the yaw.
    // rust: let wrap = |a: f32| {
    // rust: let a = a % 360.0;
    // rust: if a >= 180.0 {
    // rust: a - 360.0
    // rust: } else if a < -180.0 {
    // rust: a + 360.0
    // rust: } else {
    // rust: a
}
}
    // rust: if let Some(Tag::List(rot)) = nbt.get(&"Rotation".into()).cloned()
    // rust: && let Some(Tag::Float(bits)) = rot.first()
    // rust: {
    // rust: let yaw = wrap(f32::from_bits(*bits));
    // rust: let rotated = match rotation {
    // rust: Rotation::Clockwise180 => yaw + 180.0,
    // rust: Rotation::Counterclockwise90 => yaw + 270.0,
    // rust: Rotation::Clockwise90 => yaw + 90.0,
    // rust: Rotation::None => yaw,
}
    // rust: let mirrored = match mirror {
    // rust: Mirror::FrontBack => -yaw,
    // rust: Mirror::LeftRight => 180.0 - yaw,
    // rust: Mirror::None => yaw,
}
    // rust: let mut rot = rot.clone();
    // rust: rot[0] = Tag::Float((rotated + mirrored - yaw).to_bits());
    // rust: nbt.insert("Rotation".into(), Tag::List(rot));
}
        // HangingEntity.rotate/mirror: the facing turns with the template.
    // rust: if let Some(&Tag::Byte(f)) = nbt.get(&"Facing".into()) {
    // rust: nbt.insert("Facing".into(), Tag::Byte(turn_facing(f, mirror, rotation)));
}
    // rust: if settings.finalize_entities {
    // rust: nbt.insert("horizon:finalize".into(), Tag::Byte(1));
}
    // rust: world.add_entity(nbt)?;
}
    // rust: Ok(())
}
/// A 3D data value (2 north, 3 south, 4 west, 5 east) mirrored then rotated.
pub fn turn_facing(f: i8, mirror: Mirror, rotation: Rotation) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !(2..=5).contains(&f) {
    // rust: return f;
}
    // rust: let mirrored = match (mirror, f) {
    // rust: (Mirror::LeftRight, 2) => 3,
    // rust: (Mirror::LeftRight, 3) => 2,
    // rust: (Mirror::FrontBack, 4) => 5,
    // rust: (Mirror::FrontBack, 5) => 4,
    // rust: (_, f) => f,
}
    // Clockwise order: north, east, south, west.
    // rust: let order = [2, 5, 3, 4];
    // rust: let i = order.iter().position(|&d| d == mirrored).unwrap_or(0);
    // rust: let steps = match rotation {
    // rust: Rotation::None => 0,
    // rust: Rotation::Clockwise90 => 1,
    // rust: Rotation::Clockwise180 => 2,
    // rust: Rotation::Counterclockwise90 => 3,
}
    // rust: order[(i + steps) % 4]
}

/// StructureTemplate.updateShapeAtEdge over the placed positions' voxel
/// shape (DiscreteVoxelShape.forAllFaces order: X-Y rows along Z, then
/// Z-X rows along Y, then Y-Z rows along X).
    // rust: fn update_shape_at_edge<W: PlacementContext>(
    // rust: world: &mut W,
    // rust: placed: &[[i32; 3]],
    // rust: flags: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
//     use horizon_core::geometry::Direction;
    // rust: let mut min = placed[0];
    // rust: let mut max = placed[0];
    // rust: for p in placed {
    // rust: for i in 0..3 {
    // rust: min[i] = min[i].min(p[i]);
    // rust: max[i] = max[i].max(p[i]);
}
}
    // rust: let size: [i32; 3] = std::array::from_fn(|i| max[i] - min[i] + 1);
    // rust: let index = |[x, y, z]: [i32; 3]| ((x * size[1] + y) * size[2] + z) as usize;
    // rust: let mut bits = vec![false; size.iter().map(|v| *v as usize).product()];
    // rust: for p in placed {
    // rust: bits[index(std::array::from_fn(|i| p[i] - min[i]))] = true;
}
    // rust: let full = |p: [i32; 3]| (0..3).all(|i| (0..size[i]).contains(&p[i])) && bits[index(p)];
    // rust: type Map = fn(i32, i32, i32) -> [i32; 3];
    // rust: let passes: [(Direction, Direction, i32, i32, i32, Map); 3] = [
    // rust: (
    // rust: Direction::North,
    // rust: Direction::South,
    // rust: size[0],
    // rust: size[1],
    // rust: size[2],
    // rust: |a, b, c| [a, b, c],
    // rust: ),
    // rust: (
    // rust: Direction::Down,
    // rust: Direction::Up,
    // rust: size[2],
    // rust: size[0],
    // rust: size[1],
    // rust: |a, b, c| [b, c, a],
    // rust: ),
    // rust: (
    // rust: Direction::West,
    // rust: Direction::East,
    // rust: size[1],
    // rust: size[2],
    // rust: size[0],
    // rust: |a, b, c| [c, a, b],
    // rust: ),
    // rust: ];
    // rust: for (negative, positive, a_size, b_size, c_size, map) in passes {
    // rust: for a in 0..a_size {
    // rust: for b in 0..b_size {
    // rust: let mut last = false;
    // rust: for c in 0..=c_size {
    // rust: let here = c != c_size && full(map(a, b, c));
    // rust: let face = if !last && here {
    // rust: Some((negative, map(a, b, c)))
    // rust: } else if last && !here {
    // rust: Some((positive, map(a, b, c - 1)))
    // rust: } else {
    // rust: None
}
    // rust: if let Some((direction, local)) = face {
    // rust: let p = std::array::from_fn(|i| min[i] + local[i]);
    // rust: world.update_shape_at_face(p, direction, flags)?;
}
    // rust: last = here;
}
}
}
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

pub fn spawner(value: Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SpawnerMobs::decode(&value, |v| {
    // rust: assert_eq!(v, Some(&json!({"id": "minecraft:cobblestone"})));
    // rust: Ok(BlockStateId(7))
    // rust: })
    // rust: .unwrap()
}
pub fn id(entity: ?*Compound) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match entity?.get(&JavaString::from("id")) {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}

pub fn spawner_mobs_pick_by_weight() void {
}
    // rust: let s = spawner(json!({
    // rust: "mobs": [
    // rust: {"entity": {"id": "minecraft:zombie"}, "weight": 1},
    // rust: {"entity": {"id": "minecraft:husk"}, "weight": 3}],
    // rust: "replacement": {"id": "minecraft:cobblestone"}}));
        // pick = nextFloat * 4, less each weight in turn, until <= 0.
    // rust: for (r, mob) in [
    // rust: (0., "zombie"),
    // rust: (0.25, "zombie"),
    // rust: (0.2501, "husk"),
    // rust: (0.999, "husk"),
    // rust: ] {
    // rust: assert_eq!(id(s.pick(|| r)), Some(format!("minecraft:{mob}")), "{r}");
}
    // rust: let empty = spawner(json!({"mobs": [], "replacement": {"id": "minecraft:cobblestone"}}));
    // rust: assert_eq!(empty.pick(|| unreachable!()), None);
    // rust: assert_eq!(empty.replacement, BlockStateId(7));
}

pub fn spawner_mobs_write_the_mods_nbt() void {
}
    // rust: let s = spawner(json!({
    // rust: "mobs": [{"entity": {"id": "minecraft:skeleton", "Health": 30}, "weight": 2}],
    // rust: "delay": 10, "spawn_count": 2,
    // rust: "custom_spawn_rules": {"block_light_limit": {"min_inclusive": 0, "max_inclusive": 7}},
    // rust: "replacement": {"id": "minecraft:cobblestone"}}));
    // rust: let nbt = s.nbt(s.pick(|| 0.5).unwrap());
    // rust: let short = |k: &str| nbt.get(&JavaString::from(k)).cloned();
    // rust: for (k, v) in [
    // rust: ("Delay", 10),
    // rust: ("MinSpawnDelay", 200),
    // rust: ("MaxSpawnDelay", 800),
    // rust: ("SpawnCount", 2),
    // rust: ("MaxNearbyEntities", 6),
    // rust: ("RequiredPlayerRange", 16),
    // rust: ("SpawnRange", 4),
    // rust: ] {
    // rust: assert_eq!(short(k), Some(Tag::Short(v)), "{k}");
}
    // rust: let Some(Tag::Compound(data)) = short("SpawnData") else {
    // rust: panic!("SpawnData")
}
    // rust: assert!(data.contains_key(&JavaString::from("custom_spawn_rules")));
    // rust: let Some(Tag::Compound(entity)) = data.get(&JavaString::from("entity")) else {
    // rust: panic!("entity")
}
    // rust: assert_eq!(entity.get(&JavaString::from("Health")), Some(&Tag::Int(30)));
    // rust: let Some(Tag::List(potentials)) = short("SpawnPotentials") else {
    // rust: panic!("SpawnPotentials")
}
    // rust: let Tag::Compound(potential) = &potentials[0] else {
    // rust: panic!("potential")
}
    // rust: assert_eq!(
    // rust: potential.get(&JavaString::from("weight")),
    // rust: Some(&Tag::Int(1))
    // rust: );
    // rust: assert_eq!(
    // rust: potential.get(&JavaString::from("data")),
    // rust: Some(&Tag::Compound(data.clone()))
    // rust: );
}

pub fn spawner_mobs_refuse_a_mob_without_an_id() void {
}
    // rust: let bad = json!({"mobs": [{"entity": {}, "weight": 1}]});
    // rust: assert!(SpawnerMobs::decode(&bad, |_| Ok(BlockStateId(0))).is_err());
}

pub fn repurposed_position_rules() void {
}
    // rust: let decode = |v: Value| PosRule::decode(Some(&v));
        // Over 3..4 blocks from the template's origin along y, 0 to 1.
    // rust: let rule = decode(
    // rust: json!({"predicate_type": "horizon:piece_origin_axis_aligned_linear_pos",
    // rust: "axis": "y", "min_chance": 0, "max_chance": 1, "min_dist": 3, "max_dist": 4}),
    // rust: )
    // rust: .unwrap();
    // rust: let mut random = LegacyRandom::new(1);
    // rust: let world = [100, 64, -100];
        // At or under min_dist the chance is 0, a roll of 0 aside; past max_dist it is 1.
    // rust: assert!(!rule.test([9, 2, 9], world, world, &mut random));
    // rust: assert!(rule.test([0, -5, 0], world, world, &mut random));
        // The world position and the piece's do not count.
    // rust: assert!(rule.test([0, 4, 0], [0, 0, 0], [50, 50, 50], &mut random));
        // Repurposed refuses an empty distance range and an unknown axis.
    // rust: for bad in [
    // rust: json!({"predicate_type": "horizon:piece_origin_axis_aligned_linear_pos"}),
    // rust: json!({"predicate_type": "horizon:piece_origin_axis_aligned_linear_pos",
    // rust: "min_dist": 0, "max_dist": 1, "axis": "w"}),
    // rust: json!({"predicate_type": "horizon:y_value", "min_y_value": 5, "max_y_value": 4}),
    // rust: json!({"predicate_type": "horizon:y_value", "min_y_value": 5}),
    // rust: ] {
    // rust: assert!(decode(bad.clone()).is_err(), "{bad}");
}
    // rust: let y = decode(
    // rust: json!({"predicate_type": "horizon:y_value", "min_y_value": 0, "max_y_value": 31}),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(y.test([0; 3], [7, 31, 7], [0; 3], &mut random));
    // rust: assert!(y.test([0, 99, 0], [7, 0, 7], [0; 3], &mut random));
    // rust: assert!(!y.test([0; 3], [7, 32, 7], [0; 3], &mut random));
    // rust: assert!(!y.test([0; 3], [7, -1, 7], [0; 3], &mut random));
}

pub fn rule_parts_read_ids_without_a_namespace() void {
}
        // CTOV writes "always_true"; vanilla reads it as minecraft:always_true.
    // rust: for kind in ["always_true", "minecraft:always_true"] {
    // rust: let p = json!({"predicate_type": kind});
    // rust: assert!(
    // rust: matches!(PosRule::decode(Some(&p)), Ok(PosRule::Always)),
    // rust: "{kind}"
    // rust: );
}
    // rust: let linear = json!({"predicate_type": "axis_aligned_linear_pos", "axis": "z",
    // rust: "min_chance": 0.1, "max_dist": 8});
    // rust: assert!(matches!(
    // rust: PosRule::decode(Some(&linear)),
    // rust: Ok(PosRule::Linear {
    // rust: axis: Some(2),
    // rust: max_dist: 8,
    // rust: ..
    // rust: })
    // rust: ));
    // rust: assert!(PosRule::decode(Some(&json!({"predicate_type": "x:unknown"}))).is_err());
    // rust: assert!(matches!(PosRule::decode(None), Ok(PosRule::Always)));
    // rust: let loot = json!({"type": "append_loot", "loot_table": "minecraft:chests/x"});
    // rust: assert!(
    // rust: matches!(Modifier::decode(Some(&loot)), Ok(Modifier::AppendLoot(t)) if t == "minecraft:chests/x")
    // rust: );
    // rust: assert!(matches!(
    // rust: Modifier::decode(Some(&json!({"type": "clear"}))),
    // rust: Ok(Modifier::Clear)
    // rust: ));
    // rust: assert!(Modifier::decode(Some(&json!({"type": ""}))).is_err());
}

pub fn block_entity_edits_merge_deep_and_drop_keys() void {
}
    // rust: let nbt = |v: Value| match json_to_nbt(&v) {
    // rust: Tag::Compound(c) => c,
    // rust: _ => unreachable!(),
}
    // rust: let vault = nbt(json!({"id": "minecraft:vault",
    // rust: "config": {"loot_table": "x:old", "key_item": {"id": "minecraft:trial_key"}},
    // rust: "server_data": {"state_updating_resumes_at": 533162741}}));
        // append_static merges compounds the way CompoundTag.merge does.
    // rust: let Ok(Modifier::AppendStatic(data)) = Modifier::decode(Some(&json!({
    // rust: "type": "append_static", "data": {"config": {"loot_table": "x:new"}}})))
    // rust: else {
    // rust: panic!("append_static")
}
    // rust: let merged = edited(Some(&vault), &[], &data);
    // rust: assert_eq!(
    // rust: merged,
    // rust: nbt(json!({"id": "minecraft:vault",
    // rust: "config": {"loot_table": "x:new", "key_item": {"id": "minecraft:trial_key"}},
    // rust: "server_data": {"state_updating_resumes_at": 533162741}}))
    // rust: );
    // rust: let Ok(Modifier::Edit { remove, data }) = Modifier::decode(Some(&json!({
    // rust: "type": "horizon:edit", "remove": ["server_data"],
    // rust: "data": {"config": {"loot_table": "x:new"}}})))
    // rust: else {
    // rust: panic!("horizon:edit")
}
    // rust: assert_eq!(
    // rust: edited(Some(&vault), &remove, &data),
    // rust: nbt(json!({"id": "minecraft:vault",
    // rust: "config": {"loot_table": "x:new", "key_item": {"id": "minecraft:trial_key"}}}))
    // rust: );
    // rust: assert_eq!(
    // rust: edited(None, &remove, &data),
    // rust: nbt(json!({"config": {"loot_table": "x:new"}}))
    // rust: );
    // rust: let bad = json!({"type": "horizon:edit", "remove": [1], "data": {}});
    // rust: assert!(Modifier::decode(Some(&bad)).is_err());
}

    /// Scripted draws: floats in turn, then ints.
pub const Draws = struct {};
    // rust: impl ProcessorRandom for Draws {
pub fn float(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.remove(0)
}
pub fn int(self: *Self, bound: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = self.1.remove(0);
    // rust: assert!(i < bound);
    // rust: i
}
pub fn long(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: unreachable!()
}
}

pub fn redrawn_picks_draw_a_float_each() void {
}
        // Better Ocean Monuments' copper: < 0.1 exposed, else a new float
        // < 0.3 weathered, else oxidized.
    // rust: let id = |v: &Value| Ok(BlockStateId(v["Name"].as_str().unwrap().len() as u32));
    // rust: let pick = Pick::decode(
    // rust: &json!({"block": "oxidized_copper", "redraw": true, "keep_properties": true,
    // rust: "picks": [{"below": 0.1, "state": {"Name": "a"}},
    // rust: {"below": 0.3, "state": {"Name": "bb"}}],
    // rust: "default": {"state": {"Name": "ccc"}}}),
    // rust: id,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(pick.keep_properties);
    // rust: let run = |f: Vec<f32>| {
    // rust: pick.apply(
    // rust: BlockInfo {
    // rust: pos: [0; 3],
    // rust: state: BlockStateId(0),
    // rust: nbt: None,
    // rust: },
    // rust: &mut Draws(f, vec![]),
    // rust: )
    // rust: .state
}
    // rust: assert_eq!(run(vec![0.05]), BlockStateId(1));
        // One float would give weathered at 0.2; the second draw decides.
    // rust: assert_eq!(run(vec![0.2, 0.5]), BlockStateId(3));
    // rust: assert_eq!(run(vec![0.2, 0.25]), BlockStateId(2));
}

pub fn picks_follow_yungs_cascade() void {
}
        // States by name: sand 1, sandstone 2, the four stairs 10..13.
    // rust: let id = |v: &Value| {
    // rust: Ok(BlockStateId(match v["Name"].as_str() {
    // rust: Some("minecraft:sand") => 1,
    // rust: Some("minecraft:sandstone") => 2,
    // rust: Some("minecraft:suspicious_sand") => 3,
    // rust: _ => {
    // rust: 10 + ["north", "east", "south", "west"]
    // rust: .iter()
    // rust: .position(|f| v["Properties"]["facing"] == *f)
    // rust: .unwrap_or(9) as u32
}
    // rust: }))
}
    // rust: let stairs: Vec<Value> = ["north", "east", "south", "west"]
    // rust: .iter()
    // rust: .map(|f| json!({"Name": "minecraft:sandstone_stairs", "Properties": {"facing": f}}))
    // rust: .collect();
    // rust: let pick = Pick::decode(
    // rust: &json!({"block": "red_stained_glass", "picks": [
    // rust: {"below": 0.01, "state": {"Name": "minecraft:suspicious_sand"},
    // rust: "nbt": {"LootTable": "minecraft:archaeology/desert_pyramid"}},
    // rust: {"below": 0.3, "state": {"Name": "minecraft:sand"}},
    // rust: {"below": 0.75, "state": {"Name": "minecraft:sandstone"}}],
    // rust: "default": {"states": stairs}}),
    // rust: id,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(pick.block, "minecraft:red_stained_glass");
    // rust: let glass = || BlockInfo {
    // rust: pos: [1, 2, 3],
    // rust: state: BlockStateId(0),
    // rust: nbt: Some(Compound::new()),
}
    // rust: let run = |f: f32, i: Vec<i32>| pick.apply(glass(), &mut Draws(vec![f], i));
    // rust: let sus = run(0.005, vec![]);
    // rust: assert_eq!(sus.state, BlockStateId(3));
    // rust: assert!(
    // rust: sus.nbt
    // rust: .unwrap()
    // rust: .contains_key(&JavaString::from("LootTable"))
    // rust: );
    // rust: assert_eq!(run(0.01, vec![]).state, BlockStateId(1));
    // rust: assert_eq!(run(0.2999, vec![]).nbt, Some(Compound::new()));
    // rust: assert_eq!(run(0.3, vec![]).state, BlockStateId(2));
        // The stairs' facing: Plane.HORIZONTAL[nextInt(4)] after the pick.
    // rust: assert_eq!(run(0.75, vec![2]).state, BlockStateId(12));
    // rust: assert_eq!(run(0.99, vec![1]).state, BlockStateId(11));

    // rust: let pot = Pick::decode(
    // rust: &json!({"block": "minecraft:decorated_pot", "default": {
    // rust: "state": {"Name": "minecraft:sand"},
    // rust: "lists": [{"key": "sherds", "count": 4, "default": "minecraft:brick",
    // rust: "values": [{"below": 0.05, "value": "minecraft:archer_pottery_sherd"},
    // rust: {"below": 0.1, "value": "minecraft:miner_pottery_sherd"}]}]}}),
    // rust: id,
    // rust: )
    // rust: .unwrap();
        // No picks: no float for them; one float per sherd.
    // rust: let out = pot.apply(
    // rust: BlockInfo {
    // rust: nbt: None,
    // rust: ..glass()
    // rust: },
    // rust: &mut Draws(vec![0.5, 0.01, 0.07, 0.1], vec![]),
    // rust: );
    // rust: let Some(Tag::List(sherds)) = out.nbt.unwrap().get(&JavaString::from("sherds")).cloned()
    // rust: else {
    // rust: panic!("sherds")
}
    // rust: let names: Vec<String> = sherds
    // rust: .iter()
    // rust: .map(|t| match t {
    // rust: Tag::String(s) => s.to_string_lossy(),
    // rust: _ => String::new(),
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(
    // rust: names,
    // rust: [
    // rust: "minecraft:brick",
    // rust: "minecraft:archer_pottery_sherd",
    // rust: "minecraft:miner_pottery_sherd",
    // rust: "minecraft:brick"
    // rust: ]
    // rust: );
    // rust: assert!(Pick::decode(&json!({"block": "a", "default": {"states": []}}), id).is_err());
}

pub fn count_caps_keep_the_first_then_some() void {
}
    // rust: let cap = CountCap::decode(
    // rust: &json!({"blocks": ["chest", "minecraft:trapped_chest"], "min": 1, "max": 2,
    // rust: "chance": 0.2, "replacement": {"id": "minecraft:cave_air"}}),
    // rust: |_| Ok(BlockStateId(5)),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(cap.blocks.contains("minecraft:chest"));
    // rust: let mut counted = 0;
        // The first stays without a roll.
    // rust: assert!(cap.keeps(&mut counted, || unreachable!()));
        // Then each stays on nextFloat <= 0.2, until two have.
    // rust: assert!(!cap.keeps(&mut counted, || 0.21));
    // rust: assert!(cap.keeps(&mut counted, || 0.2));
    // rust: assert!(!cap.keeps(&mut counted, || unreachable!()));
    // rust: assert_eq!(counted, 2);
    // rust: assert!(
    // rust: CountCap::decode(&json!({"blocks": [], "min": -1}), |_| Ok(BlockStateId(5))).is_err()
    // rust: );
}

pub fn block_swaps_keep_the_properties_both_blocks_have() void {
}
    // rust: let row = |name: &str, props: Value| json!([name, false, false, "", {"id": name, "properties": props}]);
    // rust: let facts = json!({"defaults": {"a:log": 1, "a:stairs": 4, "a:stone": 6},
    // rust: "states": [
    // rust: row("a:log", json!({"axis": "x"})), row("a:log", json!({"axis": "y"})),
    // rust: row("a:stairs", json!({"facing": "east", "half": "top"})),
    // rust: row("a:stairs", json!({"facing": "east", "half": "bottom"})),
    // rust: row("a:stairs", json!({"facing": "north", "half": "bottom"})),
    // rust: row("a:stairs", json!({"facing": "north", "half": "top"})),
    // rust: ["a:stone", false, false, "", "a:stone"]]});
    // rust: let registry =
    // rust: crate::registry::BlockRegistry::from_facts_json(facts.to_string().as_bytes()).unwrap();
        // facing and half carried over; the default where `from` has none.
    // rust: assert_eq!(
    // rust: with_properties_of(&registry, "a:stairs", BlockStateId(2)),
    // rust: Some(BlockStateId(2))
    // rust: );
    // rust: assert_eq!(
    // rust: with_properties_of(&registry, "a:stairs", BlockStateId(0)),
    // rust: Some(BlockStateId(4))
    // rust: );
    // rust: assert_eq!(
    // rust: with_properties_of(&registry, "a:stone", BlockStateId(5)),
    // rust: Some(BlockStateId(6))
    // rust: );
    // rust: assert_eq!(
    // rust: with_properties_of(&registry, "a:missing", BlockStateId(0)),
    // rust: None
    // rust: );
}
}
