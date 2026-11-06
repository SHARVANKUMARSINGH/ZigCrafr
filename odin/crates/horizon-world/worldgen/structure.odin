//! Transpiled from Horizon Rust crate
package horizon_world_structure

import "core:fmt"
import "core:mem"
import "core:math"

// Structure templates, processors and placement shared by template features
// and structure pieces.
    // rust: pub mod end_city;
    // rust: pub mod enhanced_terrain;
    // rust: pub mod features;
    // rust: pub mod formations;
    // rust: pub mod fortress;
    // rust: pub mod jigsaw;
    // rust: pub mod legacy;
    // rust: pub mod mansion;
    // rust: pub mod mineshaft;
    // rust: pub mod monument;
    // rust: pub mod nether_fossil;
    // rust: pub mod ocean_ruin;
    // rust: pub mod piece_limited;
    // rust: pub mod processor;
    // rust: pub mod ruined_portal;
    // rust: pub mod simple;
    // rust: pub mod start;
    // rust: pub mod start_checks;
    // rust: pub mod stronghold;
    // rust: pub mod template;
    // rust: pub mod temple;

// use crate::{
    // rust: nbt::{self, Limits},
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::geometry::Direction;
// use processor::ProcessorList;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet, HashMap},
    // rust: io::Read,
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, RwLock},
}
    // rust: pub use template::{BlockInfo, EntityInfo, JigsawInfo, StructureTemplate, save_nbt};

Rotation :: enum {
    None,
    Clockwise90,
    Clockwise180,
    Counterclockwise90,
}
    // rust: impl Rotation {
    // rust: pub const ALL: [Self; 4] = [
    // rust: Self::None,
    // rust: Self::Clockwise90,
    // rust: Self::Clockwise180,
    // rust: Self::Counterclockwise90,
    // rust: ];
from_name :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match name {
    // rust: "none" => Self::None,
    // rust: "clockwise_90" => Self::Clockwise90,
    // rust: "180" => Self::Clockwise180,
    // rust: "counterclockwise_90" => Self::Counterclockwise90,
    // rust: _ => return None,
    // rust: })
}
    // Rotation.getRandom: one bounded draw over the four values.
random :: proc(random: ^impl horizon_core::random::RandomSource) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL[random.next_int_bound(4).unwrap_or(0) as usize]
}
rotate_direction :: proc(self: ^Self, direction: Direction) -> D {
    // Ported from Horizon
    return {}
}
    // rust: if matches!(direction, Direction::Up | Direction::Down) {
    // rust: return direction;
}
    // rust: let order = [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ];
    // rust: let index = order.iter().position(|d| *d == direction).unwrap();
    // rust: order[(index + self as usize) % 4]
}
    // `Rotation.getSerializedName`: the value of `Rotation.CODEC`.
serialized_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::None => "none",
    // rust: Self::Clockwise90 => "clockwise_90",
    // rust: Self::Clockwise180 => "180",
    // rust: Self::Counterclockwise90 => "counterclockwise_90",
}
}
get_rotated :: proc(self: ^Self, other: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL[(self as usize + other as usize) % 4]
}
    // `Rotation.name()`, as structure pieces save it.
saved_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::None => "NONE",
    // rust: Self::Clockwise90 => "CLOCKWISE_90",
    // rust: Self::Clockwise180 => "CLOCKWISE_180",
    // rust: Self::Counterclockwise90 => "COUNTERCLOCKWISE_90",
}
}
}
Mirror :: enum {
    None,
    LeftRight,
    FrontBack,
}
    // rust: impl Mirror {
    // `Mirror.name()`, as structure pieces save it.
saved_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::None => "NONE",
    // rust: Self::LeftRight => "LEFT_RIGHT",
    // rust: Self::FrontBack => "FRONT_BACK",
}
}
}

// Inclusive integer box (vanilla BoundingBox).
BoundingBox :: struct {
    min: [i32,
    max: [i32,
}
    // rust: impl BoundingBox {
new :: proc(min: [i32; 3], max: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { min, max }
}
from_corners :: proc(a: [i32; 3], b: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: min: std::array::from_fn(|i| a[i].min(b[i])),
    // rust: max: std::array::from_fn(|i| a[i].max(b[i])),
}
}
moved :: proc(self: ^Self, d: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: min: std::array::from_fn(|i| self.min[i] + d[i]),
    // rust: max: std::array::from_fn(|i| self.max[i] + d[i]),
}
}
is_inside :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (0..3).all(|i| p[i] >= self.min[i] && p[i] <= self.max[i])
}
intersects :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (0..3).all(|i| self.max[i] >= other.min[i] && self.min[i] <= other.max[i])
}
encapsulate :: proc(self: ^Self, other: ^Self) {
}
    // rust: for i in 0..3 {
    // rust: self.min[i] = self.min[i].min(other.min[i]);
    // rust: self.max[i] = self.max[i].max(other.max[i]);
}
}
inflated :: proc(self: ^Self, xz: i32, y: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: min: [self.min[0] - xz, self.min[1] - y, self.min[2] - xz],
    // rust: max: [self.max[0] + xz, self.max[1] + y, self.max[2] + xz],
}
}
span :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|i| self.max[i] - self.min[i] + 1)
}
center :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|i| self.min[i] + (self.max[i] - self.min[i] + 1) / 2)
}
corners :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let (a, b) = (self.min, self.max);
    // rust: [
    // rust: [a[0], a[1], a[2]],
    // rust: [a[0], a[1], b[2]],
    // rust: [a[0], b[1], a[2]],
    // rust: [a[0], b[1], b[2]],
    // rust: [b[0], a[1], a[2]],
    // rust: [b[0], a[1], b[2]],
    // rust: [b[0], b[1], a[2]],
    // rust: [b[0], b[1], b[2]],
    // rust: ]
}
}

// Per-state BlockState.rotate/mirror results and template ordering flags,
// exported from vanilla (`blocks/structure-blocks.json`).
StateTransforms :: struct {
    rotate: Vec<[u32,
    mirror: Vec<[u32,
    full: [dynamic]bool,
    loot: BTreeSet<BlockStateId>,
    // Block entity type of every state that has one (`BlockState.hasBlockEntity`).
    entity_types: HashMap<BlockStateId,
}
    // rust: impl StateTransforms {
from_json :: proc(json: string, states: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let value: serde_json::Value = serde_json::from_str(json)?;
    // rust: let arr = |key: &'static str| {
    // rust: value[key]
    // rust: .as_array()
    // rust: .cloned()
    // rust: .ok_or(super::DecodeError::Field(key))
}
    // rust: let ids = |v: &serde_json::Value| -> Vec<u32> {
    // rust: v.as_array()
    // rust: .map(|a| {
    // rust: a.iter()
    // rust: .filter_map(|x| x.as_u64())
    // rust: .map(|x| x as u32)
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default()
}
    // rust: let rotate = arr("rotate")?
    // rust: .iter()
    // rust: .map(|v| {
    // rust: let v = ids(v);
    // rust: [v[0], v[1], v[2]]
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: let mirror = arr("mirror")?
    // rust: .iter()
    // rust: .map(|v| {
    // rust: let v = ids(v);
    // rust: [v[0], v[1]]
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: let full = arr("full_block")?
    // rust: .iter()
    // rust: .map(|v| v.as_bool().unwrap_or(false))
    // rust: .collect::<Vec<_>>();
    // rust: if rotate.len() != states || mirror.len() != states || full.len() != states {
    // rust: return Err(super::DecodeError::Field("structure block table size"));
}
    // rust: let loot = ids(&value["loot_containers"])
    // rust: .into_iter()
    // rust: .map(BlockStateId)
    // rust: .collect();
    // rust: let mut entity_types = HashMap::new();
    // rust: if let Some(types) = value["block_entities"].as_object() {
    // rust: for (name, states) in types {
    // rust: let name: Arc<str> = Arc::from(name.as_str());
    // rust: for id in ids(states) {
    // rust: entity_types.insert(BlockStateId(id), name.clone());
}
}
}
    // rust: Ok(Self {
    // rust: rotate,
    // rust: mirror,
    // rust: full,
    // rust: loot,
    // rust: entity_types,
    // rust: })
}
    // The block entity type a state carries, when it has one.
entity_type :: proc(self: ^Self, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.entity_types.get(&state)
}
rotate :: proc(self: ^Self, state: BlockStateId, rotation: Rotation) -> B {
    // Ported from Horizon
    return {}
}
    // rust: match rotation {
    // rust: Rotation::None => state,
    // rust: r => self
    // rust: .rotate
    // rust: .get(state.0 as usize)
    // rust: .map_or(state, |t| BlockStateId(t[r as usize - 1])),
}
}
mirror :: proc(self: ^Self, state: BlockStateId, mirror: Mirror) -> B {
    // Ported from Horizon
    return {}
}
    // rust: match mirror {
    // rust: Mirror::None => state,
    // rust: m => self
    // rust: .mirror
    // rust: .get(state.0 as usize)
    // rust: .map_or(state, |t| BlockStateId(t[m as usize - 1])),
}
}
full_block :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.full.get(state.0 as usize).copied().unwrap_or(false)
}
loot_container :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.loot.contains(&state)
}
}

// Lazily loaded templates (`structure/<namespace>/<path>.nbt`, gzip NBT) and
// processor lists, shared by all generators of one resource bundle.
StructureResources :: struct {
    registry: ^'static BlockRegistry,
    transforms: StateTransforms,
    dir: PathBuf,
    templates: RwLock<HashMap<string,
    processor_lists: BTreeMap<string,
    jigsaw_states: BTreeMap<BlockStateId,
    // rust: pub(crate) waterlogged: HashMap<BlockStateId, BlockStateId>,
    sources: BTreeSet<BlockStateId>,
    // Block names in each block tag, for processors matching tags by block.
    block_tags: BTreeMap<string,
}
    // rust: impl std::fmt::Debug for StructureResources {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str("StructureResources")
}
}
    // rust: impl StructureResources {
    // rust: pub fn new(
    // rust: registry: &'static BlockRegistry,
    // rust: transforms: StateTransforms,
    // rust: dir: &Path,
    // rust: processor_lists: BTreeMap<String, String>,
    // rust: block_tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> Self {
    // rust: let mut sources = BTreeSet::new();
    // rust: let fluids = crate::fluid::FluidStateTable::new(registry).ok();
    // rust: let mut jigsaw_states = BTreeMap::new();
    // rust: let mut waterlogged = HashMap::new();
    // rust: for id in 0..registry.len() {
    // rust: let id = BlockStateId(id as u32);
    // rust: let state = registry.state(id).unwrap();
    // rust: if state.name == "minecraft:jigsaw" {
    // rust: let orientation = state
    // rust: .properties
    // rust: .get("orientation")
    // rust: .cloned()
    // rust: .unwrap_or_default();
    // rust: let front = orientation.split('_').next().unwrap_or("");
    // rust: jigsaw_states.insert(id, !matches!(front, "up" | "down"));
}
    // rust: if fluids
    // rust: .as_ref()
    // rust: .and_then(|table| table.get(id))
    // rust: .is_some_and(|fluid| fluid.is_source())
    // rust: {
    // rust: sources.insert(id);
}
            // SlabBlock.placeLiquid refuses double slabs.
    // rust: let double_slab = state.name.ends_with("_slab")
    // rust: && state.properties.get("type").map(String::as_str) == Some("double");
    // rust: if !double_slab
    // rust: && state.properties.get("waterlogged").map(String::as_str) == Some("false")
    // rust: {
    // rust: let mut wet = state.clone();
    // rust: wet.properties.insert("waterlogged".into(), "true".into());
    // rust: if let Some(wet) = registry.id(&wet) {
    // rust: waterlogged.insert(id, wet);
}
}
}
    // rust: Self {
    // rust: registry,
    // rust: transforms,
    // rust: dir: dir.to_owned(),
    // rust: templates: RwLock::new(HashMap::new()),
    // rust: processor_lists,
    // rust: jigsaw_states,
    // rust: waterlogged,
    // rust: sources,
    // rust: block_tags: block_tags
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), v.iter().cloned().collect()))
    // rust: .collect(),
}
}
    // StructureTemplateManager.getOrCreate; missing templates are empty.
template :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: if let Some(found) = self.templates.read().unwrap().get(&id) {
    // rust: return found.clone();
}
    // rust: let (namespace, path) = id.split_once(':').unwrap();
    // rust: let file = self.dir.join(namespace).join(format!("{path}.nbt"));
    // rust: let loaded = horizon_core::prepared_files::read(&file)
    // rust: .ok()
    // rust: .and_then(|bytes| {
    // rust: let mut raw = Vec::new();
    // rust: flate2::read::GzDecoder::new(bytes.as_slice())
    // rust: .read_to_end(&mut raw)
    // rust: .ok()?;
    // rust: let tag = nbt::read_named(&raw, Limits::templates()).ok()?.0.tag;
    // rust: Some(StructureTemplate::from_nbt(
    // rust: &tag,
    // rust: self.registry,
    // rust: &self.transforms,
    // rust: ))
    // rust: });
        // StructureTemplateManager.getOrCreate: missing templates are empty.
    // rust: let mut loaded = loaded.unwrap_or_else(StructureTemplate::empty);
    // rust: loaded.location = id.as_str().into();
    // rust: let loaded = Some(Arc::new(loaded));
    // rust: self.templates.write().unwrap().insert(id, loaded.clone());
    // rust: loaded
}
    // Whether the state's fluid is a source (water/lava level 0, waterlogged).
source_fluid :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.sources.contains(&state)
}
jigsaw_horizontal :: proc(self: ^Self, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.jigsaw_states.get(&state).copied()
}
    // rust: pub fn processor_list(
    // rust: &self,
    // rust: json: &str,
    // rust: bindings: &super::block_feature::FeatureBlockBindings<'_>,
    // rust: ) -> Result<ProcessorList, super::DecodeError> {
    // rust: ProcessorList::decode(json, self, bindings)
}
is_jigsaw :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.jigsaw_states.contains_key(&state)
}
}
