//! Transpiled from Horizon Rust crate
package horizon_world_cache

import "core:fmt"
import "core:mem"
import "core:math"

// Disposable, versioned snapshots of resolved data: the behaviour tables
// and the block-state registry.
//
// The source resources remain authoritative. Failed reads, unsupported
// versions, corrupt payloads and write failures always use the normal loader.
// Snapshots live in the game's own cache folder ([`set_dir`]), never in the
// resource folder: that one is shared by worktrees and copied between installed
// versions by the launcher. Its key includes a hash of the code that resolves
// the tables (this crate, `horizon-core`, their dependencies; see `build.rs`),
// so a build that resolves them differently never reads another build's
// snapshot, while a rebuild that only touched other crates keeps them.
// use super::*;
// use crate::registry::snapshot as registry_snapshot;
// use serde::{Deserialize, Serialize};
// use sha2::{Digest, Sha256};
// use std::{
    // rust: io::Write,
    // rust: path::PathBuf,
    // rust: sync::{
    // rust: Mutex, OnceLock,
    // rust: atomic::{AtomicU32, Ordering},
    // rust: },
    // rust: time::SystemTime,
}

MAGIC :: b"HZBEHAV\0"
VERSION :: 2
FILE_NAME :: "behaviours-v2.bin"
REGISTRY_MAGIC :: b"HZREGIS\0"
REGISTRY_VERSION :: 1
REGISTRY_FILE_NAME :: "registry-v1.bin"
MAX_FILE_BYTES :: 128 * 1024 * 1024
MAX_DECODED_BYTES :: 256 * 1024 * 1024
NEXT_TEMP :: AtomicU32::new(0)
DIR :: OnceLock::new()

// Keep snapshots in `dir` (the client passes `<game folder>/.horizon-cache`).
// Without it (tests, tools, servers), `Behaviours::load` and `load_registry`
// always use the source loaders.
    // rust: pub(in crate::level) fn set_dir(dir: PathBuf) {
    // rust: let _ = DIR.set(dir);
}

Snapshot :: struct {
    tags: HashMap<string,
    facts: [dynamic]Fact,
    shapes: [dynamic]Shape,
    shape_info: Vec<[u8,
    fluid_tags: [u8,
    blocks: [dynamic]Block,
    items: HashMap<string,
}

Fact :: struct {
    flags: u32,
    sturdy: u32,
    weak: u32,
    strong: u32,
    fluid_kind: u8,
    fluid_amount: u8,
    fluid_falling: bool,
    emission: u8,
    dampening: u8,
    hardness: f32,
    push: u8,
    instrument: u8,
    shape: i32,
}

Shape :: struct {
    coords: [[dynamic]f64,
    occupied: [dynamic]bool,
    cube: bool,
    coordinate_cubes: [bool,
    min: [i32,
    max: [i32,
    // Preserve the shared singleton identities used by vanilla shape shortcuts.
    singleton: u8,
}

SetTypeSnapshot :: struct {
    name: string,
    can_open_by_hand: bool,
    can_open_by_wind_charge: bool,
    arrows: bool,
    mobs_only: bool,
    door_open: string,
    door_close: string,
    trapdoor_open: string,
    trapdoor_close: string,
    plate_on: string,
    plate_off: string,
    button_on: string,
    button_off: string,
}

SoundsSnapshot :: struct {
    volume: f32,
    pitch: f32,
    place: string,
    break_: string,
    fall: string,
}

Block :: struct {
    chain: [dynamic]u16,
    interfaces: u16,
    set_type: Maybe(SetTypeSnapshot),
    gate_open: Maybe(string),
    gate_close: Maybe(string),
    open_sound: Maybe(string),
    close_sound: Maybe(string),
    ticks_to_stay_pressed: i32,
    max_weight: i32,
    link: Maybe(u16),
    link2: Maybe(u16),
    support_tag: Maybe([dynamic]u64),
    support_tag2: Maybe([dynamic]u64),
    feature: Maybe(string),
    grow_probability: f64,
    growth_direction: u8,
    schedule_fluid_ticks: bool,
    weather: u8,
    ignite_odds: i32,
    burn_odds: i32,
    sounds: SoundsSnapshot,
    item: string,
    dynamic_shape: bool,
}

Item :: struct {
    block: u16,
    wall_block: Maybe(u16),
    attachment: Maybe(u8),
    kind: u8,
    game_master: bool,
}

// The build that resolves the tables: a hash of this crate's and
// `horizon-core`'s sources, `Cargo.lock` and the profile (`build.rs`). The
// version constant alone misses loader changes that keep a snapshot's layout.
hash_build :: proc(hasher: ^Sha256) {
}
    // rust: hash_str(hasher, env!("HORIZON_WORLD_SOURCES"));
}

fingerprint :: proc(registry: ^BlockRegistry, root: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut hasher = Sha256::new();
    // rust: hasher.update(b"horizon resolved behaviours 2");
    // The build that resolved the tables.
    // rust: hash_build(&mut hasher);
    // rust: hasher.update(sources_digest(root)?);
    // The registry argument may be modified independently of facts.json.
    // rust: hasher.update((registry.len() as u64).to_le_bytes());
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: for index in 0..registry.len() {
    // rust: let state = registry
    // rust: .state(BlockStateId(index as u32))
    // rust: .ok_or_else(|| invalid("missing registry state"))?;
    // rust: hash_str(&mut hasher, &state.name);
    // rust: let mut props: Vec<_> = state.properties.iter().collect();
    // rust: props.sort_by_key(|(key, _)| *key);
    // rust: hasher.update((props.len() as u32).to_le_bytes());
    // rust: for (key, value) in props {
    // rust: hash_str(&mut hasher, key);
    // rust: hash_str(&mut hasher, value);
}
    // rust: if seen.insert(state.name.as_str()) {
    // rust: let default = registry
    // rust: .default_state(&state.name)
    // rust: .ok_or_else(|| invalid("missing default state"))?;
    // rust: hasher.update(default.0.to_le_bytes());
}
}
    // rust: Ok(hasher.finalize().into())
}

// The source files the snapshot is resolved from, as their lengths and
// modification times, and the hash of their contents.
    // rust: type Sources = (Vec<(PathBuf, u64, Option<SystemTime>)>, [u8; 32]);
// Source hashes already computed by this process: the client's tables and
// the world generator's are loaded from the same folder, and hashing its
// 70 MB again took a third of a second on a 4-thread laptop. A file whose
// length or modification time changed is read again.
SOURCES :: Mutex::new(Vec::new())

sources_digest :: proc(root: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut paths: Vec<PathBuf> = [
    // rust: "facts.json",
    // rust: "block-behaviours.json",
    // rust: "gameplay-facts.json",
    // rust: "block-tags.json",
    // rust: "cached-collision.nbt",
    // rust: ]
    // rust: .iter()
    // rust: .map(|relative| root.join(relative))
    // rust: .collect();
    // rust: let mut fluids: Vec<PathBuf> = fs::read_dir(root.join("data/minecraft/tags/fluid"))?
    // rust: .map(|entry| entry.map(|entry| entry.path()))
    // rust: .collect::<io::Result<_>>()?;
    // rust: fluids.sort();
    // rust: paths.extend(fluids);
    // rust: paths_digest(root, &paths)
}

// `paths` as the hash of their names (relative to `root`), lengths and
// contents. Digests already computed by this process are kept by the files'
// lengths and modification times in [`SOURCES`]: a file that changed is read
// again.
paths_digest :: proc(root: ^Path, paths: ^[PathBuf]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let stamps = paths
    // rust: .iter()
    // rust: .map(|path| {
    // rust: let meta = fs::metadata(path)?;
    // rust: Ok((path.clone(), meta.len(), meta.modified().ok()))
    // rust: })
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: let known = SOURCES.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some((_, digest)) = known.iter().find(|(s, _)| *s == stamps) {
    // rust: return Ok(*digest);
}
    // rust: drop(known);
    // rust: let mut hasher = Sha256::new();
    // rust: for path in paths {
    // rust: hash_file(&mut hasher, root, path)?;
}
    // rust: let digest: [u8; 32] = hasher.finalize().into();
    // rust: SOURCES
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .push((stamps, digest));
    // rust: Ok(digest)
}

hash_str :: proc(hasher: ^Sha256, text: string) {
}
    // rust: hasher.update((text.len() as u64).to_le_bytes());
    // rust: hasher.update(text.as_bytes());
}

hash_file :: proc(hasher: ^Sha256, root: ^Path, path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let relative = path
    // rust: .strip_prefix(root)
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: hash_str(hasher, &relative.to_string_lossy());
    // rust: let bytes = fs::read(path)?;
    // rust: hasher.update((bytes.len() as u64).to_le_bytes());
    // rust: hasher.update(hash_contents(&bytes));
    // rust: Ok(())
}

// A content hash's piece: files bigger than this hash piece by piece across
// the idle cores — one SHA-256 stream over tens of megabytes is the
// fingerprint's cost.
HASH_PIECE :: 4 << 20

// `bytes`' digest: one SHA-256 up to [`HASH_PIECE`]; bigger, the SHA-256 of
// the per-piece digests in order. The scheme is a function of the bytes
// alone, so every machine keys the same file to the same fingerprint.
hash_contents :: proc(bytes: []u8) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let pieces: Vec<&[u8]> = bytes.chunks(HASH_PIECE).collect();
    // rust: if pieces.len() <= 1 {
    // rust: return Sha256::digest(bytes).into();
}
    // rust: let workers = pieces
    // rust: .len()
    // rust: .min(std::thread::available_parallelism().map_or(1, |n| n.get()));
    // rust: if workers <= 1 {
    // rust: let mut hasher = Sha256::new();
    // rust: for piece in pieces {
    // rust: hasher.update(Sha256::digest(piece));
}
    // rust: return hasher.finalize().into();
}
    // rust: let span = pieces.len().div_ceil(workers);
    // rust: std::thread::scope(|scope| {
        // The last span hashes here while the workers run.
    // rust: let (rest, last) = pieces.split_at(pieces.len() - span);
    // rust: let tasks: Vec<_> = rest
    // rust: .chunks(span)
    // rust: .map(|run| scope.spawn(move || run.iter().map(Sha256::digest).collect::<Vec<_>>()))
    // rust: .collect();
    // rust: let last: Vec<_> = last.iter().map(Sha256::digest).collect();
    // rust: let mut hasher = Sha256::new();
    // rust: for task in tasks {
    // rust: for digest in task.join().unwrap() {
    // rust: hasher.update(digest);
}
}
    // rust: for digest in last {
    // rust: hasher.update(digest);
}
    // rust: hasher.finalize().into()
    // rust: })
}

direction :: proc(index: u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Direction::ALL
    // rust: .get(index as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| invalid("cached direction out of range"))
}
direction_index :: proc(direction: Direction) -> u {
    // Ported from Horizon
    return {}
}
    // rust: Direction::ALL.iter().position(|d| *d == direction).unwrap() as u8
}
class :: proc(index: u16) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Class::ALL
    // rust: .get(index as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| invalid("cached block class out of range"))
}
kind :: proc(index: u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match index {
    // rust: 0 => ItemKind::Block,
    // rust: 1 => ItemKind::DoubleHigh,
    // rust: 2 => ItemKind::StandingAndWall,
    // rust: 3 => ItemKind::Scaffolding,
    // rust: 4 => ItemKind::PlaceOnWater,
    // rust: 5 => ItemKind::HangingSign,
    // rust: 6 => ItemKind::SolidBucket,
    // rust: 7 => ItemKind::Other,
    // rust: _ => return Err(invalid("cached item kind out of range")),
    // rust: })
}
kind_index :: proc(kind: ItemKind) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match kind {
    // rust: ItemKind::Block => 0,
    // rust: ItemKind::DoubleHigh => 1,
    // rust: ItemKind::StandingAndWall => 2,
    // rust: ItemKind::Scaffolding => 3,
    // rust: ItemKind::PlaceOnWater => 4,
    // rust: ItemKind::HangingSign => 5,
    // rust: ItemKind::SolidBucket => 6,
    // rust: ItemKind::Other => 7,
}
}
push :: proc(index: u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match index {
    // rust: 0 => PushReaction::PushPull,
    // rust: 1 => PushReaction::Push,
    // rust: 2 => PushReaction::Popped,
    // rust: 3 => PushReaction::Immoveable,
    // rust: 4 => PushReaction::IgnoreEntity,
    // rust: _ => return Err(invalid("cached push reaction out of range")),
    // rust: })
}
push_index :: proc(push: PushReaction) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match push {
    // rust: PushReaction::PushPull => 0,
    // rust: PushReaction::Push => 1,
    // rust: PushReaction::Popped => 2,
    // rust: PushReaction::Immoveable => 3,
    // rust: PushReaction::IgnoreEntity => 4,
}
}

    // rust: impl From<&SetType> for SetTypeSnapshot {
from :: proc(value: ^SetType) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: name: value.name.to_string(),
    // rust: can_open_by_hand: value.can_open_by_hand,
    // rust: can_open_by_wind_charge: value.can_open_by_wind_charge,
    // rust: arrows: value.arrows,
    // rust: mobs_only: value.mobs_only,
    // rust: door_open: value.door_open.to_string(),
    // rust: door_close: value.door_close.to_string(),
    // rust: trapdoor_open: value.trapdoor_open.to_string(),
    // rust: trapdoor_close: value.trapdoor_close.to_string(),
    // rust: plate_on: value.plate_on.to_string(),
    // rust: plate_off: value.plate_off.to_string(),
    // rust: button_on: value.button_on.to_string(),
    // rust: button_off: value.button_off.to_string(),
}
}
}
    // rust: impl From<SetTypeSnapshot> for SetType {
from :: proc(value: SetTypeSnapshot) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: name: value.name.into(),
    // rust: can_open_by_hand: value.can_open_by_hand,
    // rust: can_open_by_wind_charge: value.can_open_by_wind_charge,
    // rust: arrows: value.arrows,
    // rust: mobs_only: value.mobs_only,
    // rust: door_open: Arc::from(value.door_open),
    // rust: door_close: Arc::from(value.door_close),
    // rust: trapdoor_open: Arc::from(value.trapdoor_open),
    // rust: trapdoor_close: Arc::from(value.trapdoor_close),
    // rust: plate_on: Arc::from(value.plate_on),
    // rust: plate_off: Arc::from(value.plate_off),
    // rust: button_on: Arc::from(value.button_on),
    // rust: button_off: Arc::from(value.button_off),
}
}
}
    // rust: impl From<&Sounds> for SoundsSnapshot {
from :: proc(value: ^Sounds) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: volume: value.volume,
    // rust: pitch: value.pitch,
    // rust: place: value.place.to_string(),
    // rust: break_: value.break_.to_string(),
    // rust: fall: value.fall.to_string(),
}
}
}
    // rust: impl From<SoundsSnapshot> for Sounds {
from :: proc(value: SoundsSnapshot) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: volume: value.volume,
    // rust: pitch: value.pitch,
    // rust: place: Arc::from(value.place),
    // rust: break_: Arc::from(value.break_),
    // rust: fall: Arc::from(value.fall),
}
}
}

    // rust: impl Snapshot {
capture :: proc(behaviours: ^Behaviours) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let tags = behaviours
    // rust: .all_tags
    // rust: .iter()
    // rust: .map(|(key, value)| (key.clone(), value.0.clone()))
    // rust: .collect();
    // rust: let facts = behaviours
    // rust: .facts
    // rust: .iter()
    // rust: .map(|fact| Fact {
    // rust: flags: fact.flags,
    // rust: sturdy: fact.sturdy,
    // rust: weak: fact.weak,
    // rust: strong: fact.strong,
    // rust: fluid_kind: fact.fluid.kind() as u8,
    // rust: fluid_amount: fact.fluid.amount(),
    // rust: fluid_falling: fact.fluid.falling(),
    // rust: emission: fact.emission,
    // rust: dampening: fact.dampening,
    // rust: hardness: fact.hardness,
    // rust: push: push_index(fact.push),
    // rust: instrument: fact.instrument,
    // rust: shape: fact.shape,
    // rust: })
    // rust: .collect();
    // rust: let shapes = behaviours
    // rust: .shapes
    // rust: .iter()
    // rust: .map(|shape| {
    // rust: let sizes = shape.sizes();
    // rust: let mut occupied = Vec::with_capacity(sizes.iter().product());
    // rust: for x in 0..sizes[0] {
    // rust: for y in 0..sizes[1] {
    // rust: for z in 0..sizes[2] {
    // rust: occupied.push(shape.is_full(x as i32, y as i32, z as i32));
}
}
}
    // rust: let (min, max) = shape.discrete_bounds();
    // rust: Shape {
    // rust: coords: std::array::from_fn(|axis| {
    // rust: shape
    // rust: .coordinates(
    // rust: [
    // rust: horizon_core::geometry::Axis::X,
    // rust: horizon_core::geometry::Axis::Y,
    // rust: horizon_core::geometry::Axis::Z,
    // rust: ][axis],
    // rust: )
    // rust: .to_vec()
    // rust: }),
    // rust: occupied,
    // rust: cube: shape.is_cube(),
    // rust: coordinate_cubes: shape.cube_coordinate_axes(),
    // rust: min,
    // rust: max,
    // rust: singleton: if shape.same_identity(&VoxelShape::block()) {
    // rust: 1
    // rust: } else if shape.same_identity(&VoxelShape::empty()) {
    // rust: 2
    // rust: } else {
    // rust: 0
    // rust: },
}
    // rust: })
    // rust: .collect();
    // rust: let shape_info = behaviours
    // rust: .shape_info
    // rust: .iter()
    // rust: .map(|info| [info.full_faces, info.nonempty_faces, info.wall_cover])
    // rust: .collect();
    // rust: let f = behaviours.fluid_tags;
    // rust: let fluid_tags = [
    // rust: f.water,
    // rust: f.lava,
    // rust: f.supports_frogspawn,
    // rust: f.supports_lily_pad,
    // rust: f.supports_sugar_cane_adjacently,
    // rust: f.bubble_column_can_occupy,
    // rust: ];
    // rust: let blocks = behaviours
    // rust: .blocks
    // rust: .iter()
    // rust: .map(|block| Block {
    // rust: chain: block.chain.iter().map(|class| *class as u16).collect(),
    // rust: interfaces: block.interfaces,
    // rust: set_type: block
    // rust: .set_type
    // rust: .as_ref()
    // rust: .map(|value| SetTypeSnapshot::from(value.as_ref())),
    // rust: gate_open: block.gate_open.as_ref().map(|v| v.to_string()),
    // rust: gate_close: block.gate_close.as_ref().map(|v| v.to_string()),
    // rust: open_sound: block.open_sound.as_ref().map(|v| v.to_string()),
    // rust: close_sound: block.close_sound.as_ref().map(|v| v.to_string()),
    // rust: ticks_to_stay_pressed: block.ticks_to_stay_pressed,
    // rust: max_weight: block.max_weight,
    // rust: link: block.link.map(|v| v.0),
    // rust: link2: block.link2.map(|v| v.0),
    // rust: support_tag: block.support_tag.as_ref().map(|v| v.0.clone()),
    // rust: support_tag2: block.support_tag2.as_ref().map(|v| v.0.clone()),
    // rust: feature: block.feature.as_ref().map(|v| v.to_string()),
    // rust: grow_probability: block.grow_probability,
    // rust: growth_direction: direction_index(block.growth_direction),
    // rust: schedule_fluid_ticks: block.schedule_fluid_ticks,
    // rust: weather: block.weather,
    // rust: ignite_odds: block.ignite_odds,
    // rust: burn_odds: block.burn_odds,
    // rust: sounds: SoundsSnapshot::from(block.sounds.as_ref()),
    // rust: item: block.item.to_string(),
    // rust: dynamic_shape: block.dynamic_shape,
    // rust: })
    // rust: .collect();
    // rust: let items = behaviours
    // rust: .items
    // rust: .iter()
    // rust: .map(|(name, item)| {
    // rust: (
    // rust: name.clone(),
    // rust: Item {
    // rust: block: item.block.0,
    // rust: wall_block: item.wall_block.map(|v| v.0),
    // rust: attachment: item.attachment.map(direction_index),
    // rust: kind: kind_index(item.kind),
    // rust: game_master: item.game_master,
    // rust: },
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: tags,
    // rust: facts,
    // rust: shapes,
    // rust: shape_info,
    // rust: fluid_tags,
    // rust: blocks,
    // rust: items,
}
}

restore :: proc(self: ^Self, registry: ^BlockRegistry) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut table = StateTable::new(registry)?;
    // rust: let props = Props::resolve(&mut table);
    // rust: let named = Named::resolve(&table)?;
    // rust: if self.facts.len() != table.state_count()
    // rust: || self.blocks.len() != table.block_count()
    // rust: || self.shape_info.len() != self.shapes.len()
    // rust: {
    // rust: return Err(invalid("cached behaviour table size mismatch"));
}
    // rust: let all_tags: HashMap<String, Arc<BlockSet>> = self
    // rust: .tags
    // rust: .into_iter()
    // rust: .map(|(key, value)| (key, Arc::new(BlockSet(value))))
    // rust: .collect();
    // rust: let tags = Tags::resolve(&all_tags);
    // rust: let shapes = self
    // rust: .shapes
    // rust: .into_iter()
    // rust: .map(|wire| {
    // rust: let shape = match wire.singleton {
    // rust: 1 => VoxelShape::block(),
    // rust: 2 => VoxelShape::empty(),
    // rust: 0 => {
    // rust: if wire.cube {
    // rust: let sizes = std::array::from_fn(|axis| {
    // rust: wire.coords[axis].len().saturating_sub(1)
    // rust: });
    // rust: VoxelShape::from_cube(sizes, &wire.occupied)
    // rust: .map_err(|e| invalid(e.to_string()))?
    // rust: } else {
    // rust: VoxelShape::from_mixed_grid(
    // rust: wire.coords,
    // rust: &wire.occupied,
    // rust: wire.coordinate_cubes,
    // rust: )
    // rust: .map_err(|e| invalid(e.to_string()))?
}
}
    // rust: _ => return Err(invalid("invalid cached shape identity")),
}
    // rust: shape
    // rust: .with_discrete_bounds(wire.min, wire.max)
    // rust: .map_err(|e| invalid(e.to_string()))
    // rust: })
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: let shape_info = self
    // rust: .shape_info
    // rust: .into_iter()
    // rust: .map(|row| ShapeInfo {
    // rust: full_faces: row[0],
    // rust: nonempty_faces: row[1],
    // rust: wall_cover: row[2],
    // rust: })
    // rust: .collect();
    // rust: let facts = self
    // rust: .facts
    // rust: .into_iter()
    // rust: .map(|wire| {
    // rust: if wire.shape < -1 || wire.shape >= shapes.len() as i32 {
    // rust: return Err(invalid("cached shape index out of range"));
}
    // rust: let fluid_kind = FluidKind::ALL
    // rust: .get(wire.fluid_kind as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| invalid("cached fluid kind out of range"))?;
    // rust: Ok(StateFacts {
    // rust: flags: wire.flags,
    // rust: sturdy: wire.sturdy,
    // rust: weak: wire.weak,
    // rust: strong: wire.strong,
    // rust: fluid: FluidState::new(fluid_kind, wire.fluid_amount, wire.fluid_falling),
    // rust: emission: wire.emission,
    // rust: dampening: wire.dampening,
    // rust: hardness: wire.hardness,
    // rust: push: push(wire.push)?,
    // rust: instrument: wire.instrument,
    // rust: shape: wire.shape,
    // rust: })
    // rust: })
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: let f = self.fluid_tags;
    // rust: let fluid_tags = FluidTags {
    // rust: water: f[0],
    // rust: lava: f[1],
    // rust: supports_frogspawn: f[2],
    // rust: supports_lily_pad: f[3],
    // rust: supports_sugar_cane_adjacently: f[4],
    // rust: bubble_column_can_occupy: f[5],
}
    // rust: let blocks = self
    // rust: .blocks
    // rust: .into_iter()
    // rust: .map(|wire| {
    // rust: let chain = wire
    // rust: .chain
    // rust: .into_iter()
    // rust: .map(class)
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: let mut classes = ClassSet::default();
    // rust: for class in &chain {
    // rust: classes.insert(*class);
}
    // rust: let class = chain.first().copied().unwrap_or(Class::Block);
    // rust: for link in [wire.link, wire.link2].into_iter().flatten() {
    // rust: if link as usize >= table.block_count() {
    // rust: return Err(invalid("cached block link out of range"));
}
}
    // rust: Ok(BlockData {
    // rust: class,
    // rust: chain,
    // rust: classes,
    // rust: interfaces: wire.interfaces,
    // rust: set_type: wire.set_type.map(|v| Arc::new(SetType::from(v))),
    // rust: gate_open: wire.gate_open.map(Arc::from),
    // rust: gate_close: wire.gate_close.map(Arc::from),
    // rust: open_sound: wire.open_sound.map(Arc::from),
    // rust: close_sound: wire.close_sound.map(Arc::from),
    // rust: ticks_to_stay_pressed: wire.ticks_to_stay_pressed,
    // rust: max_weight: wire.max_weight,
    // rust: link: wire.link.map(BlockId),
    // rust: link2: wire.link2.map(BlockId),
    // rust: support_tag: wire.support_tag.map(|v| Arc::new(BlockSet(v))),
    // rust: support_tag2: wire.support_tag2.map(|v| Arc::new(BlockSet(v))),
    // rust: feature: wire.feature.map(Arc::from),
    // rust: grow_probability: wire.grow_probability,
    // rust: growth_direction: direction(wire.growth_direction)?,
    // rust: schedule_fluid_ticks: wire.schedule_fluid_ticks,
    // rust: weather: wire.weather,
    // rust: ignite_odds: wire.ignite_odds,
    // rust: burn_odds: wire.burn_odds,
    // rust: sounds: Arc::new(Sounds::from(wire.sounds)),
    // rust: item: Arc::from(wire.item),
    // rust: dynamic_shape: wire.dynamic_shape,
    // rust: })
    // rust: })
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: let items = self
    // rust: .items
    // rust: .into_iter()
    // rust: .map(|(name, wire)| {
    // rust: if wire.block as usize >= table.block_count()
    // rust: || wire
    // rust: .wall_block
    // rust: .is_some_and(|id| id as usize >= table.block_count())
    // rust: {
    // rust: return Err(invalid("cached item block out of range"));
}
    // rust: Ok((
    // rust: name,
    // rust: ItemBinding {
    // rust: block: BlockId(wire.block),
    // rust: wall_block: wire.wall_block.map(BlockId),
    // rust: attachment: wire.attachment.map(direction).transpose()?,
    // rust: kind: kind(wire.kind)?,
    // rust: game_master: wire.game_master,
    // rust: },
    // rust: ))
    // rust: })
    // rust: .collect::<io::Result<HashMap<_, _>>>()?;
    // rust: let liquid_blocks = FluidBlockBindings::new(registry)?;
    // rust: let mut dynamic = HashMap::new();
    // rust: for (id, fact) in facts.iter().enumerate() {
    // rust: if fact.shape < 0 {
    // rust: let state = BlockStateId(id as u32);
    // rust: if let Some(support) = crate::dynamic_support::DynamicSupport::from_state(
    // rust: registry.state(state).unwrap(),
    // rust: )? {
    // rust: dynamic.insert(state, support);
}
}
}
    // rust: let potted_by_content = super::potted_by_content(&blocks, &table);
    // rust: Ok(Behaviours {
    // rust: table,
    // rust: props,
    // rust: named,
    // rust: tags,
    // rust: all_tags,
    // rust: facts,
    // rust: shapes,
    // rust: shape_info,
    // rust: fluid_tags,
    // rust: blocks,
    // rust: items,
    // rust: potted_by_content,
    // rust: liquid_blocks,
    // rust: dynamic,
    // rust: occlusion_cache: Default::default(),
    // rust: growth: Default::default(),
    // rust: })
}
}

// `bytes`' decompressed payload when it is a `magic`/`version` snapshot made
// for `fingerprint`; anything else — short, another key, a corrupt body —
// is no snapshot.
    // rust: fn decode_snapshot(
    // rust: bytes: &[u8],
    // rust: magic: &[u8; 8],
    // rust: version: u32,
    // rust: fingerprint: &[u8; 32],
    // rust: ) -> Option<Vec<u8>> {
    // Validate bounds before decoding untrusted cache contents.
    // rust: if bytes.len() < 8 + 4 + 32 + 32 || bytes.len() > MAX_FILE_BYTES {
    // rust: return None;
}
    // rust: if &bytes[..8] != magic
    // rust: || u32::from_le_bytes(bytes[8..12].try_into().ok()?) != version
    // rust: || bytes[12..44] != fingerprint[..]
    // rust: {
    // rust: return None;
}
    // rust: let body = &bytes[76..];
    // rust: if Sha256::digest(body).as_slice() != &bytes[44..76] {
    // rust: return None;
}
    // rust: let expanded_len = u32::from_le_bytes(body.get(..4)?.try_into().ok()?) as usize;
    // rust: if expanded_len > MAX_DECODED_BYTES {
    // rust: return None;
}
    // rust: lz4_flex::decompress_size_prepended(body).ok()
}

    // rust: fn write_snapshot(
    // rust: dir: &Path,
    // rust: file_name: &str,
    // rust: magic: &[u8; 8],
    // rust: version: u32,
    // rust: fingerprint: &[u8; 32],
    // rust: serialized: &[u8],
    // rust: ) -> io::Result<()> {
    // rust: let body = lz4_flex::compress_prepend_size(serialized);
    // rust: if body.len() + 76 > MAX_FILE_BYTES {
    // rust: return Err(invalid("snapshot cache too large"));
}
    // rust: let mut bytes = Vec::with_capacity(76 + body.len());
    // rust: bytes.extend_from_slice(magic);
    // rust: bytes.extend_from_slice(&version.to_le_bytes());
    // rust: bytes.extend_from_slice(fingerprint);
    // rust: bytes.extend_from_slice(&Sha256::digest(&body));
    // rust: bytes.extend_from_slice(&body);
    // rust: fs::create_dir_all(dir)?;
    // rust: let path = dir.join(file_name);
    // rust: let tmp = dir.join(format!(
    // rust: "{file_name}.tmp-{}-{}",
    // rust: std::process::id(),
    // rust: NEXT_TEMP.fetch_add(1, Ordering::Relaxed)
    // rust: ));
    // rust: let result = (|| {
    // rust: let mut file = fs::OpenOptions::new()
    // rust: .write(true)
    // rust: .create_new(true)
    // rust: .open(&tmp)?;
    // rust: file.write_all(&bytes)?;
    // rust: file.sync_all()?;
    // rust: fs::rename(&tmp, &path)
    // rust: })();
    // rust: if result.is_err() {
    // rust: let _ = fs::remove_file(&tmp);
}
    // rust: result
}

    // rust: pub(super) fn load(registry: &BlockRegistry, root: &Path) -> Option<Behaviours> {
    // rust: load_from(DIR.get()?, registry, root)
}

load_from :: proc(dir: ^Path, registry: ^BlockRegistry, root: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = fs::read(dir.join(FILE_NAME)).ok()?;
    // rust: let fingerprint = fingerprint(registry, root).ok()?;
    // rust: let expanded = decode_snapshot(&bytes, MAGIC, VERSION, &fingerprint)?;
    // rust: let snapshot: Snapshot = postcard::from_bytes(&expanded).ok()?;
    // rust: snapshot.restore(registry).ok()
}

    // rust: pub(super) fn store(registry: &BlockRegistry, root: &Path, behaviours: &Behaviours) {
    // rust: if let Some(dir) = DIR.get() {
    // rust: let _ = write(dir, registry, root, behaviours);
}
}

    // rust: fn write(
    // rust: dir: &Path,
    // rust: registry: &BlockRegistry,
    // rust: root: &Path,
    // rust: behaviours: &Behaviours,
    // rust: ) -> io::Result<()> {
    // rust: let fingerprint = fingerprint(registry, root)?;
    // rust: let snapshot = Snapshot::capture(behaviours);
    // rust: let serialized = postcard::to_allocvec(&snapshot).map_err(|e| invalid(e.to_string()))?;
    // rust: write_snapshot(dir, FILE_NAME, MAGIC, VERSION, &fingerprint, &serialized)
}

// `facts.json` is the registry's only source.
registry_fingerprint :: proc(root: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut hasher = Sha256::new();
    // rust: hasher.update(b"horizon block registry 1");
    // rust: hash_build(&mut hasher);
    // rust: hasher.update(paths_digest(root, &[root.join("facts.json")])?);
    // rust: Ok(hasher.finalize().into())
}

// The registry and each state's `(air, fluid)` facts.json columns.
    // rust: type RegistryLoad = (BlockRegistry, Vec<(bool, bool)>);

    // rust: pub(super) fn load_registry(root: &Path) -> Option<RegistryLoad> {
    // rust: load_registry_from(DIR.get()?, root)
}

load_registry_from :: proc(dir: ^Path, root: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = fs::read(dir.join(REGISTRY_FILE_NAME)).ok()?;
    // rust: let fingerprint = registry_fingerprint(root).ok()?;
    // rust: let expanded = decode_snapshot(&bytes, REGISTRY_MAGIC, REGISTRY_VERSION, &fingerprint)?;
    // rust: let snapshot: registry_snapshot::Snapshot = postcard::from_bytes(&expanded).ok()?;
    // rust: registry_snapshot::restore(snapshot).ok()
}

    // rust: pub(super) fn store_registry(root: &Path, registry: &BlockRegistry, flags: &[(bool, bool)]) {
    // rust: if let Some(dir) = DIR.get() {
    // rust: let _ = write_registry(dir, root, registry, flags);
}
}

    // rust: fn write_registry(
    // rust: dir: &Path,
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: flags: &[(bool, bool)],
    // rust: ) -> io::Result<()> {
    // rust: if flags.len() != registry.len() {
    // rust: return Err(invalid("registry flags do not match its states"));
}
    // rust: let fingerprint = registry_fingerprint(root)?;
    // rust: let snapshot = registry_snapshot::capture(registry, flags);
    // rust: let serialized = postcard::to_allocvec(&snapshot).map_err(|e| invalid(e.to_string()))?;
    // rust: write_snapshot(
    // rust: dir,
    // rust: REGISTRY_FILE_NAME,
    // rust: REGISTRY_MAGIC,
    // rust: REGISTRY_VERSION,
    // rust: &fingerprint,
    // rust: &serialized,
    // rust: )
}

    // rust: mod tests {
//     use super::*;
//     use std::sync::atomic::AtomicU32;

NEXT_FIXTURE :: AtomicU32::new(0)

FixtureDir :: struct {
    // rust: impl Drop for FixtureDir {
drop :: proc(self: ^Self) {
}
    // rust: let _ = fs::remove_dir_all(&self.0);
}
}

fixture :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let source = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: if !source.join("block-behaviours.json").exists() {
    // rust: eprintln!("skipping behaviour cache tests: no client resources");
    // rust: return None;
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-behaviour-cache-test-{}-{}",
    // rust: std::process::id(),
    // rust: NEXT_FIXTURE.fetch_add(1, Ordering::Relaxed),
    // rust: ));
    // rust: fs::create_dir_all(dir.join("data/minecraft/tags/fluid")).unwrap();
    // rust: for file in [
    // rust: "facts.json",
    // rust: "block-behaviours.json",
    // rust: "gameplay-facts.json",
    // rust: "block-tags.json",
    // rust: "cached-collision.nbt",
    // rust: ] {
    // rust: fs::copy(source.join(file), dir.join(file)).unwrap();
}
    // rust: for entry in fs::read_dir(source.join("data/minecraft/tags/fluid")).unwrap() {
    // rust: let entry = entry.unwrap();
    // rust: if entry.file_type().unwrap().is_file() {
    // rust: fs::copy(
    // rust: entry.path(),
    // rust: dir.join("data/minecraft/tags/fluid")
    // rust: .join(entry.file_name()),
    // rust: )
    // rust: .unwrap();
}
}
    // rust: Some(FixtureDir(dir))
}

resolved_snapshot_roundtrips_all_fields :: proc() {
}
    // rust: let Some(root) = fixture() else {
    // rust: return;
}
    // rust: let registry = super::super::load_registry(&root.0).unwrap();
    // rust: let original = super::super::load_uncached(&registry, &root.0).unwrap();
    // rust: let captured = Snapshot::capture(&original);
    // rust: let restored = captured.restore(&registry).unwrap();
    // rust: assert_eq!(
    // rust: serde_json::to_value(Snapshot::capture(&original)).unwrap(),
    // rust: serde_json::to_value(Snapshot::capture(&restored)).unwrap(),
    // rust: "all resolved fields, shape grids and identities should roundtrip",
    // rust: );
}

    // A folder's sources are hashed once while they stay as they are; a
    // file rewritten at the same length is hashed again.
sources_are_hashed_once_until_a_file_changes :: proc() {
}
    // rust: let Some(root) = fixture() else {
    // rust: return;
}
    // rust: let entries = || {
    // rust: SOURCES
    // rust: .lock()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .filter(|(stamps, _)| stamps[0].0.starts_with(&root.0))
    // rust: .count()
}
    // rust: let first = sources_digest(&root.0).unwrap();
    // rust: assert_eq!(sources_digest(&root.0).unwrap(), first);
    // rust: assert_eq!(entries(), 1);
    // rust: let tags = root.0.join("block-tags.json");
    // rust: let mut bytes = fs::read(&tags).unwrap();
    // rust: bytes[0] ^= 1;
    // rust: fs::write(&tags, bytes).unwrap();
    // rust: assert_ne!(sources_digest(&root.0).unwrap(), first);
    // rust: assert_eq!(entries(), 2);
}

cache_invalidates_sources_and_recovers_from_corruption :: proc() {
}
    // rust: let Some(root) = fixture() else {
    // rust: return;
}
        // The game's cache folder, apart from the resources.
    // rust: let dir = root.0.join("game/.horizon-cache");
    // rust: let registry = super::super::load_registry(&root.0).unwrap();
        // What `data::load` does once `set_dir` gave it a folder.
    // rust: let load_or_build = || {
    // rust: load_from(&dir, &registry, &root.0).unwrap_or_else(|| {
    // rust: let built = super::super::load_uncached(&registry, &root.0).unwrap();
    // rust: write(&dir, &registry, &root.0, &built).unwrap();
    // rust: built
    // rust: })
}
    // rust: assert!(load_from(&dir, &registry, &root.0).is_none());
    // rust: let initial = load_or_build();
    // rust: assert!(dir.join(FILE_NAME).is_file());
    // rust: assert!(
    // rust: !root.0.join(FILE_NAME).exists(),
    // rust: "the resource folder stays untouched"
    // rust: );
    // rust: let hit = load_from(&dir, &registry, &root.0).expect("cache hit");
    // rust: assert_eq!(initial.table.state_count(), hit.table.state_count());
    // rust: let tags = root.0.join("block-tags.json");
    // rust: fs::OpenOptions::new()
    // rust: .append(true)
    // rust: .open(&tags)
    // rust: .unwrap()
    // rust: .write_all(b"\n")
    // rust: .unwrap();
    // rust: assert!(
    // rust: load_from(&dir, &registry, &root.0).is_none(),
    // rust: "changed resource must invalidate"
    // rust: );
    // rust: load_or_build();
    // rust: assert!(
    // rust: load_from(&dir, &registry, &root.0).is_some(),
    // rust: "fallback should replace cache"
    // rust: );
    // rust: let cache_file = dir.join(FILE_NAME);
    // rust: let mut bytes = fs::read(&cache_file).unwrap();
    // rust: bytes[80] ^= 0x80;
    // rust: fs::write(&cache_file, bytes).unwrap();
    // rust: assert!(
    // rust: load_from(&dir, &registry, &root.0).is_none(),
    // rust: "checksum failure must invalidate"
    // rust: );
    // rust: load_or_build();
    // rust: assert!(load_from(&dir, &registry, &root.0).is_some());
        // A snapshot written under another key (another build of the game,
        // other resources) is never trusted.
    // rust: let mut other = fs::read(&cache_file).unwrap();
    // rust: other[12] ^= 1;
    // rust: fs::write(&cache_file, other).unwrap();
    // rust: assert!(load_from(&dir, &registry, &root.0).is_none());
}

    // The content digest depends on the bytes alone: a small file is its
    // SHA-256, a bigger one the digest of its 4 MB pieces' digests — the same
    // on any machine and thread count.
content_hash_pieces_in_order :: proc() {
}
    // rust: assert_eq!(
    // rust: hash_contents(b"abc"),
    // rust: <[u8; 32]>::from(Sha256::digest(b"abc"))
    // rust: );
    // rust: let bytes = vec![7u8; HASH_PIECE * 2 + 3];
    // rust: let mut hasher = Sha256::new();
    // rust: for piece in bytes.chunks(HASH_PIECE) {
    // rust: hasher.update(Sha256::digest(piece));
}
    // rust: assert_eq!(hash_contents(&bytes), <[u8; 32]>::from(hasher.finalize()));
}

    // `facts.json` alone is a registry fixture's whole resource root.
facts_fixture :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let source = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: if !source.join("facts.json").exists() {
    // rust: eprintln!("skipping registry cache test: no client resources");
    // rust: return None;
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-registry-cache-test-{}-{}",
    // rust: std::process::id(),
    // rust: NEXT_FIXTURE.fetch_add(1, Ordering::Relaxed),
    // rust: ));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: fs::copy(source.join("facts.json"), dir.join("facts.json")).unwrap();
    // rust: Some(FixtureDir(dir))
}

registry_snapshot_roundtrips_and_recovers_from_corruption :: proc() {
}
    // rust: let Some(root) = facts_fixture() else {
    // rust: return;
}
    // rust: let (registry, flags) = BlockRegistry::from_facts_json_with_flags(
    // rust: std::fs::File::open(root.0.join("facts.json")).unwrap(),
    // rust: )
    // rust: .unwrap();
        // The game's cache folder, apart from the resources.
    // rust: let dir = root.0.join("game/.horizon-cache");
    // rust: assert!(load_registry_from(&dir, &root.0).is_none());
    // rust: write_registry(&dir, &root.0, &registry, &flags).unwrap();
    // rust: assert!(
    // rust: !root.0.join(REGISTRY_FILE_NAME).exists(),
    // rust: "the resource folder stays untouched"
    // rust: );
    // rust: let (hit, hit_flags) = load_registry_from(&dir, &root.0).expect("cache hit");
    // rust: assert_eq!(hit.len(), registry.len());
    // rust: assert_eq!(hit_flags, flags);
    // rust: let mut names = std::collections::BTreeSet::new();
    // rust: for i in 0..registry.len() as u32 {
    // rust: let id = BlockStateId(i);
    // rust: assert_eq!(hit.state(id), registry.state(id));
    // rust: assert_eq!(hit.id(registry.state(id).unwrap()), Some(id));
    // rust: names.insert(&registry.state(id).unwrap().name);
}
    // rust: for name in names {
    // rust: assert_eq!(hit.default_state(name), registry.default_state(name));
}
        // A changed source invalidates; the loader rebuilds and replaces it.
    // rust: fs::OpenOptions::new()
    // rust: .append(true)
    // rust: .open(root.0.join("facts.json"))
    // rust: .unwrap()
    // rust: .write_all(b"\n")
    // rust: .unwrap();
    // rust: assert!(
    // rust: load_registry_from(&dir, &root.0).is_none(),
    // rust: "changed resource must invalidate"
    // rust: );
    // rust: write_registry(&dir, &root.0, &registry, &flags).unwrap();
    // rust: assert!(load_registry_from(&dir, &root.0).is_some());
    // rust: let cache_file = dir.join(REGISTRY_FILE_NAME);
    // rust: let mut bytes = fs::read(&cache_file).unwrap();
    // rust: bytes[80] ^= 0x80;
    // rust: fs::write(&cache_file, bytes).unwrap();
    // rust: assert!(
    // rust: load_registry_from(&dir, &root.0).is_none(),
    // rust: "checksum failure must invalidate"
    // rust: );
        // A snapshot written under another key is never trusted.
    // rust: write_registry(&dir, &root.0, &registry, &flags).unwrap();
    // rust: let mut other = fs::read(&cache_file).unwrap();
    // rust: other[12] ^= 1;
    // rust: fs::write(&cache_file, other).unwrap();
    // rust: assert!(load_registry_from(&dir, &root.0).is_none());
}
}
