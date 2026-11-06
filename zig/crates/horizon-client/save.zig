//! Transpiled from Horizon Rust crate
//! Module: horizon-client_save
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! World persistence in the vanilla 26.3 layout, readable by both Horizon and
//! the vanilla game:
//! - `level.dat` (`Data`: name, game type, time, spawn, difficulty, version)
//!   plus the saved-data files `data/minecraft/{weather,world_clocks,
//!   world_gen_settings,game_rules}.dat`;
//! - the player in `players/data/<uuid>.dat` (`singleplayer_uuid`);
//! - per dimension `dimensions/minecraft/<name>/region/r.X.Z.mca` (chunks:
//!   paletted sections with light, heightmaps, block entities, scheduled
//!   block/fluid ticks) and `entities/r.X.Z.mca` (entities, `entity_nbt`).
//!
//! Data Horizon does not simulate (structure references, unknown block
//! entities and entities, player fields such as the ender chest or effects,
//! game rules) is kept from the loaded files and written back unchanged.
//! Worlds saved by older Horizon builds (`region/`, `DIM-1/`, `Player` in
//! `level.dat`) are migrated on open.
// use crate::{
    // rust: Result,
    // rust: beehive::BeehiveExt,
    // rust: biome::Biomes,
    // rust: chunk::{BIOME_STRATEGY, Chunk, ColumnLayout, Light, Section, block_strategy},
    // rust: mobs::{spawner::SpawnerExt, trial_spawner::TrialSpawnerExt},
    // rust: streaming::ChunkGenerator,
}
// use horizon_core::{
    // rust: paletted::PalettedContainer,
    // rust: position::{BlockPos, ChunkPos},
    // rust: ticks::{SavedTick, TickPriority, TickTypeId},
}
// use horizon_world::attachments::{ATTACHMENTS_KEY, attachment_compound};
// use horizon_world::{
    // rust: DATA_VERSION,
    // rust: chunk::BlockState,
    // rust: chunk_status::ChunkStatus,
    // rust: compression::Compression,
    // rust: heightmap::{Heightmap, HeightmapChunk, HeightmapState, HeightmapType},
    // rust: nbt::{self, Compound, JavaString, Limits, NamedTag, Tag},
    // rust: region::{ChunkRecord, RegionFile},
    // rust: registry::{BlockRegistry, BlockStateId},
    // rust: worldgen::terrain::TerrainBlockStates,
}
// use std::{
    // rust: collections::{BTreeMap, HashMap, HashSet},
    // rust: fs,
    // rust: path::{Path, PathBuf},
    // rust: sync::{
    // rust: Arc, Condvar, Mutex, OnceLock,
    // rust: atomic::{AtomicU64, Ordering},
    // rust: mpsc,
    // rust: },
}

pub const VERSION_NAME: []const u8 = horizon_core::VANILLA_VERSION;

    // rust: mod gateway;
    // rust: mod loot_tests;

/// Snapshot live block entities and custom names for a save batch without
/// mutating the world. Each map is visited once, retaining its iteration order
/// within each chunk (including repeated chunk coordinates in the input).
/// An empty batch skips both maps; one chunk uses the direct filter path.
    // rust: pub fn chunks_with_block_entities<'a, N: std::hash::BuildHasher>(
    // rust: chunks: impl IntoIterator<Item = &'a Arc<Chunk>>,
    // rust: entities: &HashMap<(i32, i32, i32), crate::containers::BlockEntity>,
    // rust: names: &HashMap<(i32, i32, i32), String, N>,
    // rust: ) -> Vec<Chunk> {
    // rust: let chunks: Vec<_> = chunks.into_iter().collect();
    // rust: if chunks.is_empty() {
    // rust: return Vec::new();
}
    // rust: if chunks.len() == 1 {
    // rust: let mut c = (**chunks[0]).clone();
    // rust: c.block_entities = entities
    // rust: .iter()
    // rust: .filter(|(p, _)| p.0 >> 4 == c.x && p.2 >> 4 == c.z)
    // rust: .map(|(p, e)| (*p, e.clone()))
    // rust: .collect();
    // rust: c.block_names = names
    // rust: .iter()
    // rust: .filter(|(p, _)| p.0 >> 4 == c.x && p.2 >> 4 == c.z)
    // rust: .map(|(p, n)| (*p, n.clone()))
    // rust: .collect();
    // rust: return vec![c];
}
    // Index only requested chunks, borrowing their entries so unsaved entities
    // are never cloned. Clone one chunk at a time for inventory cache locality.
    // rust: let mut grouped = crate::fast_hash::FxHashMap::<_, (Vec<_>, Vec<_>)>::default();
    // rust: grouped.reserve(chunks.len());
    // rust: for c in &chunks {
    // rust: grouped.entry((c.x, c.z)).or_default();
}
    // rust: for (p, e) in entities {
    // rust: if let Some((entries, _)) = grouped.get_mut(&(p.0 >> 4, p.2 >> 4)) {
    // rust: entries.push((p, e));
}
}
    // rust: for (p, n) in names {
    // rust: if let Some((_, entries)) = grouped.get_mut(&(p.0 >> 4, p.2 >> 4)) {
    // rust: entries.push((p, n));
}
}
    // rust: chunks
    // rust: .into_iter()
    // rust: .map(|chunk| {
    // rust: let mut c = (**chunk).clone();
    // rust: let (entities, names) = &grouped[&(c.x, c.z)];
    // rust: c.block_entities = entities.iter().map(|(p, e)| (**p, (*e).clone())).collect();
    // rust: c.block_names = names.iter().map(|(p, n)| (**p, (*n).clone())).collect();
    // rust: c
    // rust: })
    // rust: .collect()
}

// use horizon_client_core::nbt_value::string;
    // rust: pub use horizon_client_core::nbt_value::{float, number, text};
/// Insert or replace a key of a compound tag.
    // rust: pub(crate) fn put(tag: &mut Tag, key: &str, value: Tag) {
    // rust: if let Tag::Compound(map) = tag {
    // rust: map.insert(key.into(), value);
}
}
pub fn compound_or_empty(tag: ?Tag) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Some(t @ Tag::Compound(_)) => t,
    // rust: _ => Tag::Compound(Compound::new()),
}
}

/// `dimensions/<namespace>/<path>` inside a world folder.
pub fn dimension_dir(world: *Path, dimension: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (namespace, path) = dimension
    // rust: .split_once(':')
    // rust: .unwrap_or(("minecraft", dimension));
    // rust: world.join("dimensions").join(namespace).join(path)
}
/// `DirectoryLock`: `session.lock` holds "\u{2603}" (UTF-16BE) under an exclusive
/// file lock for as long as the world is open, so two instances cannot share it.
pub const SessionLock = struct {};
    // rust: impl Drop for SessionLock {
    /// `DirectoryLock.close`: release the lock, then close the file. Closing
    /// alone keeps the lock while any copy of the descriptor lives on, such as
    /// the one a process spawned on another thread holds until its `exec`.
pub fn drop(self: *Self) void {
}
    // rust: let _ = self.0.unlock();
}
}
    // rust: impl SessionLock {
pub fn acquire(world: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
//         use std::io::Write;
    // rust: fs::create_dir_all(world)?;
    // rust: let mut file = fs::OpenOptions::new()
    // rust: .write(true)
    // rust: .create(true)
    // rust: .truncate(false)
    // rust: .open(world.join("session.lock"))?;
    // rust: file.try_lock()
    // rust: .map_err(|_| format!("{} is already open in another instance", world.display()))?;
    // rust: file.set_len(0)?;
    // rust: file.write_all(&[0x26, 0x03])?;
    // rust: file.flush()?;
    // rust: Ok(Self(file))
}
    /// `DirectoryLock.isLocked`: another copy holds the world's `session.lock`.
    /// A world without the file is not locked; one whose file may not be opened
    /// is.
pub fn is_locked(world: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = match fs::OpenOptions::new()
    // rust: .write(true)
    // rust: .open(world.join("session.lock"))
    // rust: {
    // rust: Ok(file) => file,
    // rust: Err(e) => return e.kind() == std::io::ErrorKind::PermissionDenied,
}
    // rust: match file.try_lock() {
    // rust: Err(fs::TryLockError::WouldBlock) => true,
    // rust: Err(_) => false,
            // Take the probe's own lock back at once, as `SessionLock` does on drop.
    // rust: Ok(()) => {
    // rust: let _ = file.unlock();
    // rust: false
}
}
}
}
/// Bring a world last saved by an older game version to the current format, as
/// 26.3 does when it opens one: the file fixes and level.dat first
/// (`FileFixerUpper`), then the DataFixers upgrades of every chunk, entity chunk,
/// POI chunk, player, saved data, advancements and statistics file. Vanilla runs
/// the latter as it reads each file; Horizon runs them all on opening, which reads
/// the same data, and region records still older in a world whose level.dat is
/// current are upgraded as they are read (`upgrade_record`).
pub fn upgrade_older_world(world: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: upgrade_older_world_with(
    // rust: world,
    // rust: &horizon_world::datafix::progress::UpgradeProgress::new(),
    // rust: )
}
/// [`upgrade_older_world`] reporting to `progress`, which `FileFixerProgressScreen` reads.
    // rust: pub fn upgrade_older_world_with(
    // rust: world: &Path,
    // rust: progress: &horizon_world::datafix::progress::UpgradeProgress,
    // rust: ) -> Result<()> {
    // rust: let Some(root) = read_dat(&world.join("level.dat")) else {
    // rust: return Ok(());
}
    // rust: let version = root.get("Data").map_or(i64::from(DATA_VERSION), |d| {
    // rust: number(d.get("DataVersion")).unwrap_or(-1) // saves of 1.8 and before have none
    // rust: });
    // rust: if version >= i64::from(DATA_VERSION) {
    // rust: return Ok(());
}
    // rust: if version < i64::from(horizon_world::datafix::OLDEST_SUPPORTED) {
    // rust: return Err(format!(
    // rust: "{} was saved with DataVersion {version}; worlds older than DataVersion {} \
    // rust: cannot be upgraded yet (tools/upgrade_world.py runs vanilla's own upgrader)",
    // rust: world.display(),
    // rust: horizon_world::datafix::OLDEST_SUPPORTED
    // rust: )
    // rust: .into());
}
    // rust: horizon_world::datafix::files::upgrade_world_with(world, progress)
    // rust: .map_err(|e| format!("upgrading {}: {e}", world.display()))?;
    // rust: Ok(())
}
/// Whether opening the world runs file fixes, which vanilla asks for a backup
/// first (`BackupStatus.FILE_FIXING_REQUIRED`). Saves of 1.8 and before have no
/// DataVersion, read as -1.
pub fn needs_file_fixes(world: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(root) = read_dat(&world.join("level.dat")) else {
    // rust: return false;
}
    // rust: let Some(data) = root.get("Data") else {
    // rust: return false;
}
    // rust: let version = number(data.get("DataVersion")).unwrap_or(-1);
    // rust: i32::try_from(version).is_ok_and(horizon_world::datafix::files::requires_file_fixing)
}
/// `LevelVersion.parse`: the saved game version's name, this build's when the `Version`
/// compound has no `Name`, and empty without a `Version` (`getWorldVersionName` then
/// shows `selectWorld.versionUnknown`).
pub fn saved_version_name(version: ?*Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match version {
    // rust: Some(v) => text(v.get("Name")).unwrap_or_else(|| VERSION_NAME.to_string()),
    // rust: None => String::new(),
}
}
/// `LevelSummary.isCompatible` (`DataVersion.isCompatible`: the saved series must be
/// the current `main` one). None when the world opens; otherwise the saved game
/// version's name, empty when it has none (`getWorldVersionName`).
pub fn incompatible_version(world: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = read_dat(&world.join("level.dat"))?;
    // rust: let version = root.get("Data")?.get("Version");
    // rust: let series = text(version.and_then(|v| v.get("Series"))).unwrap_or_else(|| "main".into());
    // rust: if series == "main" {
    // rust: return None;
}
    // rust: Some(saved_version_name(version))
}
/// `LevelSummary.backupStatus` DOWNGRADE: the saved game version's name (empty when it
/// has none) when the world's `Version.Id` is newer than this build's `DataVersion`
/// (`LevelVersion.parse`: no `Version` reads as 0, no `Id` as the current one).
pub fn downgraded_from(world: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = read_dat(&world.join("level.dat"))?;
    // rust: let version = root.get("Data")?.get("Version");
    // rust: let id = version.map_or(0, |v| {
    // rust: number(v.get("Id")).unwrap_or_else(|| i64::from(DATA_VERSION))
    // rust: });
    // rust: if id <= i64::from(DATA_VERSION) {
    // rust: return None;
}
    // rust: Some(saved_version_name(version))
}
/// `LevelStorageAccess.checkForLowDiskSpace`: under 64 MiB usable.
pub const LOW_DISK_SPACE: u64 = 67_108_864;
/// `LevelStorageAccess.estimateDiskSpace`: the usable bytes of the disk holding `dir`
/// (`FileStore.getUsableSpace`), `u64::MAX` when it cannot be asked.
pub fn estimate_disk_space(dir: *Path) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fs4::available_space(dir).unwrap_or(u64::MAX)
}
/// `LevelStorageAccess.checkForLowDiskSpace`.
pub fn low_disk_space(dir: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: estimate_disk_space(dir) < LOW_DISK_SPACE
}
/// `WorldOptions.isOldCustomizedWorld`: the generator settings keep `legacy_custom_options`.
pub fn is_old_customized_world(world: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: world_gen_settings(world).is_some_and(|s| text(s.get("legacy_custom_options")).is_some())
}
/// A dimension's `LevelStem` field read as a resource location (an inline definition is not one).
pub fn stem_id(tag: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = text(tag)?;
    // rust: Some(if id.contains(':') {
    // rust: id
    // rust: } else {
    // rust: format!("minecraft:{id}")
    // rust: })
}
/// `WorldDimensions.isVanillaLike`: whether a saved dimension is the stable Overworld, Nether or
/// End (`isStableOverworld`, `isStableNether`, `isStableEnd`); any other key never is.
pub fn dimension_is_vanilla_like(key: []const u8, dimension: *Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = stem_id(dimension.get("type"));
    // rust: let generator = dimension.get("generator");
    // rust: let source = generator.and_then(|g| g.get("biome_source"));
    // rust: let source_kind = source.and_then(|s| stem_id(s.get("type")));
    // MultiNoiseBiomeSource.stable(preset): a reference to the preset, not its parameters.
    // rust: let multi_noise_preset = |preset: &str| {
    // rust: source_kind.as_deref() == Some("minecraft:multi_noise")
    // rust: && stem_id(source.and_then(|s| s.get("preset"))).as_deref() == Some(preset)
}
    // NoiseBasedChunkGenerator.stable(settings): the generator uses the settings by key.
    // rust: let noise_settings = |settings: &str| {
    // rust: generator.is_some_and(|g| stem_id(g.get("type")).as_deref() == Some("minecraft:noise"))
    // rust: && stem_id(generator.and_then(|g| g.get("settings"))).as_deref() == Some(settings)
}
    // rust: match key {
    // rust: "minecraft:overworld" => {
    // rust: matches!(
    // rust: kind.as_deref(),
    // rust: Some("minecraft:overworld" | "minecraft:overworld_caves")
    // rust: ) && (source_kind.as_deref() != Some("minecraft:multi_noise")
    // rust: || multi_noise_preset("minecraft:overworld"))
}
    // rust: "minecraft:the_nether" => {
    // rust: kind.as_deref() == Some("minecraft:the_nether")
    // rust: && noise_settings("minecraft:nether")
    // rust: && multi_noise_preset("minecraft:nether")
}
    // rust: "minecraft:the_end" => {
    // rust: kind.as_deref() == Some("minecraft:the_end")
    // rust: && noise_settings("minecraft:end")
    // rust: && source_kind.as_deref() == Some("minecraft:the_end")
}
    // rust: _ => false,
}
}
/// A data pack's JSON as the NBT `dimension_is_vanilla_like` reads (what a codec gets from
/// either one is the same data).
pub fn json_tag(value: *serde_json::Value) T {
    // Implementation ported from Horizon
    return undefined;
}
//     use serde_json::Value;
    // rust: match value {
    // rust: Value::Null => Tag::compound(std::iter::empty::<(&str, Tag)>()),
    // rust: Value::Bool(b) => Tag::Byte(i8::from(*b)),
    // rust: Value::Number(n) => n.as_i64().map_or_else(
    // rust: || Tag::Double(n.as_f64().unwrap_or_default().to_bits()),
    // rust: Tag::Long,
    // rust: ),
    // rust: Value::String(s) => Tag::String(s.as_str().into()),
    // rust: Value::Array(items) => Tag::List(items.iter().map(json_tag).collect()),
    // rust: Value::Object(map) => Tag::compound(map.iter().map(|(k, v)| (k.as_str(), json_tag(v)))),
}
}
/// The level stems the world's enabled data packs define, as `WorldOpenFlows.loadWorldStem`'s
/// `datapackDimensions`.
pub fn datapack_dimensions(world: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let packs = crate::datapack::discover(world);
    // rust: let enabled_features = Level::read(world)
    // rust: .map(|l| l.enabled_features)
    // rust: .unwrap_or_default();
    // rust: let enabled = crate::datapack::enabled_ids(world, &packs, &enabled_features);
    // rust: let enabled: Vec<&crate::datapack::DataPack> = enabled
    // rust: .iter()
    // rust: .filter_map(|id| packs.iter().find(|p| &p.id == id))
    // rust: .collect();
    // rust: crate::datapack::dimension_stems(&enabled)
    // rust: .into_iter()
    // rust: .map(|(id, json)| (id, json_tag(&json)))
    // rust: .collect()
}
/// `data.worldGenSettingsLifecycle() != Lifecycle.stable()` (`WorldDimensions.bake`): the known
/// dimensions (the saved ones and the enabled data packs', a pack's replacing the saved one of
/// its id) lack one of the three builtin ones, or have one that is not the vanilla one.
pub fn world_gen_unstable(world: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let saved = world_gen_settings(world)
    // rust: .as_ref()
    // rust: .and_then(|s| s.get("dimensions"))
    // rust: .cloned();
    // rust: let stems = datapack_dimensions(world);
    // rust: if saved.is_none() && stems.is_empty() {
    // rust: return false;
}
    // rust: let mut dimensions: std::collections::BTreeMap<String, Tag> = match saved {
    // rust: Some(Tag::Compound(saved)) => saved
    // rust: .into_iter()
    // rust: .map(|(key, dimension)| (key.to_string_lossy(), dimension))
    // rust: .collect(),
    // rust: _ => std::collections::BTreeMap::new(),
}
    // `baseDimensions.getOptional(key).or(saved)`.
    // rust: dimensions.extend(stems);
    // rust: let builtin = [
    // rust: "minecraft:overworld",
    // rust: "minecraft:the_nether",
    // rust: "minecraft:the_end",
    // rust: ];
    // rust: builtin.iter().any(|key| !dimensions.contains_key(*key))
    // rust: || dimensions
    // rust: .iter()
    // rust: .any(|(key, dimension)| !dimension_is_vanilla_like(key, dimension))
}
/// Move a world saved by an older Horizon build (pre-26.3 layout with a
/// DataVersion that keeps vanilla from upgrading it) into the 26.3 layout.
pub fn migrate_legacy(world: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for (old, dimension) in [
    // rust: ("", "minecraft:overworld"),
    // rust: ("DIM-1", "minecraft:the_nether"),
    // rust: ("DIM1", "minecraft:the_end"),
    // rust: ] {
    // rust: let from = if old.is_empty() {
    // rust: world.to_owned()
    // rust: } else {
    // rust: world.join(old)
}
    // rust: let to = dimension_dir(world, dimension);
    // rust: for folder in ["region", "entities", "poi"] {
    // rust: let (src, dst) = (from.join(folder), to.join(folder));
    // rust: if src.is_dir() && !dst.exists() {
    // rust: fs::create_dir_all(&to)?;
    // rust: fs::rename(&src, &dst)?;
}
}
    // rust: if !old.is_empty() && from.is_dir() && fs::read_dir(&from)?.next().is_none() {
    // rust: let _ = fs::remove_dir(&from);
}
}
    // rust: Ok(())
}

/// Registry lookups shared by chunk encoding and decoding.
pub const SaveTables = struct {
    /// Block registry IDs (`BlockId`, scheduled tick types) in registry order.
    block_names: std.ArrayList([]const u8),
    block_ids: HashMap<[]const u8,
    /// Default state of each state's block, to write vanilla's short palette form.
    default_state: std.ArrayList(bool),
    block_entity: std.ArrayList(bool),
    heightmaps: crate::assets::Properties,
    air: u32,
    /// The POI type and its max tickets of each state (`PoiTypes`).
    poi: Vec<Option<(*'static str,
};
/// `PoiTypes.register`: the POI type of a block state and its max tickets.
pub fn poi_type(state: *horizon_world::chunk::BlockState) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = state.name.strip_prefix("minecraft:")?;
    // rust: Some(match name {
    // rust: "blast_furnace" => ("minecraft:armorer", 1),
    // rust: "smoker" => ("minecraft:butcher", 1),
    // rust: "cartography_table" => ("minecraft:cartographer", 1),
    // rust: "brewing_stand" => ("minecraft:cleric", 1),
    // rust: "composter" => ("minecraft:farmer", 1),
    // rust: "barrel" => ("minecraft:fisherman", 1),
    // rust: "fletching_table" => ("minecraft:fletcher", 1),
    // rust: "cauldron" | "lava_cauldron" | "water_cauldron" | "powder_snow_cauldron" => {
    // rust: ("minecraft:leatherworker", 1)
}
    // rust: "lectern" => ("minecraft:librarian", 1),
    // rust: "stonecutter" => ("minecraft:mason", 1),
    // rust: "loom" => ("minecraft:shepherd", 1),
    // rust: "smithing_table" => ("minecraft:toolsmith", 1),
    // rust: "grindstone" => ("minecraft:weaponsmith", 1),
    // rust: "bell" => ("minecraft:meeting", 32),
    // rust: "beehive" => ("minecraft:beehive", 0),
    // rust: "bee_nest" => ("minecraft:bee_nest", 0),
    // rust: "nether_portal" => ("minecraft:nether_portal", 0),
    // rust: "lodestone" => ("minecraft:lodestone", 0),
    // rust: "test_instance_block" => ("minecraft:test_instance", 0),
        // PoiTypes.BEDS is the sixteen colours: no straw bed.
    // rust: bed if bed.ends_with("_bed") && bed != "straw_bed" => {
    // rust: if state.properties.get("part").map(String::as_str) != Some("head") {
    // rust: return None;
}
    // rust: ("minecraft:home", 1)
}
    // rust: rod if rod.ends_with("lightning_rod") => ("minecraft:lightning_rod", 0),
    // rust: _ => return None,
    // rust: })
}
    // rust: impl SaveTables {
pub fn new(assets: *crate::assets::Assets) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let registry = assets.registry;
    // rust: let mut block_names: Vec<String> = Vec::new();
    // rust: let mut default_state = Vec::with_capacity(registry.len());
    // rust: for id in 0..registry.len() {
    // rust: let state = registry
    // rust: .state(BlockStateId(id as u32))
    // rust: .expect("registry state");
    // rust: if block_names.last() != Some(&state.name) {
    // rust: block_names.push(state.name.clone());
}
    // rust: default_state
    // rust: .push(registry.default_state(&state.name) == Some(BlockStateId(id as u32)));
}
    // rust: let block_ids = block_names
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, n)| (n.clone(), i as u16))
    // rust: .collect();
    // rust: Self {
    // rust: block_names,
    // rust: block_ids,
    // rust: default_state,
    // rust: block_entity: Vec::new(),
    // rust: heightmaps: assets.properties.clone(),
    // rust: air: registry.default_state("minecraft:air").map_or(0, |s| s.0),
    // rust: poi: (0..registry.len())
    // rust: .map(|id| registry.state(BlockStateId(id as u32)).and_then(poi_type))
    // rust: .collect(),
}
}
    /// Tables with only the heightmaps' state facts, for tests.
    // rust: pub(crate) fn for_heightmaps(heightmaps: crate::assets::Properties) -> Self {
    // rust: Self {
    // rust: block_names: Vec::new(),
    // rust: block_ids: HashMap::new(),
    // rust: default_state: Vec::new(),
    // rust: block_entity: Vec::new(),
    // rust: heightmaps,
    // rust: air: 0,
    // rust: poi: Vec::new(),
}
}
    /// Which states carry a block entity (`BlockFacts`), to drop entries for
    /// unknown block entities whose block is gone.
pub fn with_block_entities(facts: *crate::blocks::BlockFacts) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.block_entity = facts.states.iter().map(|s| s.block_entity).collect();
    // rust: self
}
}

    // rust: pub use crate::chunk::{ChunkExtras, RolledLoot, SavedProto};

/// A container was opened, or a command's tag dropped or replaced its roll: the
/// table it was loaded with is no longer what it holds.
pub fn consume_container_loot(extras: *mut ChunkExtras, pos: (i32) void {
}
    // rust: let before = extras.rolled_loot.len();
    // rust: extras.rolled_loot.retain(|r| r.pos != pos);
    // rust: if extras.rolled_loot.len() == before {
    // rust: return;
}
    // The source compound participates in the save overlay. From here on,
    // even an emptied chest must not inherit its old loot table from there.
    // rust: for (source_pos, source) in &mut extras.block_entity_sources {
    // rust: if *source_pos == pos
    // rust: && let Tag::Compound(map) = source
    // rust: {
    // rust: map.remove(&"LootTable".into());
    // rust: map.remove(&"LootTableSeed".into());
}
}
}

pub fn tick_list(ticks: *[SavedTick], name: impl Fn(u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::List(
    // rust: ticks
    // rust: .iter()
    // rust: .filter_map(|t| {
    // rust: Some(Tag::compound([
    // rust: ("i", string(&name(t.kind.0)?)),
    // rust: ("x", Tag::Int(t.pos.x)),
    // rust: ("y", Tag::Int(t.pos.y)),
    // rust: ("z", Tag::Int(t.pos.z)),
    // rust: ("t", Tag::Int(t.delay)),
    // rust: ("p", Tag::Int(t.priority as i32)),
    // rust: ]))
    // rust: })
    // rust: .collect(),
    // rust: )
}
    // rust: fn read_ticks(
    // rust: tag: Option<&Tag>,
    // rust: chunk: (i32, i32),
    // rust: id: impl Fn(&str) -> Option<u32>,
    // rust: ) -> Vec<SavedTick> {
    // rust: let Some(Tag::List(list)) = tag else {
    // rust: return Vec::new();
}
    // rust: list.iter()
    // rust: .filter_map(|t| {
    // rust: let kind = id(&text(t.get("i"))?)?;
    // rust: let pos = BlockPos::new(
    // rust: number(t.get("x"))? as i32,
    // rust: number(t.get("y"))? as i32,
    // rust: number(t.get("z"))? as i32,
    // rust: );
            // SavedTick.filterTickListForChunk
    // rust: if (pos.x >> 4, pos.z >> 4) != chunk {
    // rust: return None;
}
    // rust: Some(SavedTick {
    // rust: kind: TickTypeId(kind),
    // rust: pos,
    // rust: delay: number(t.get("t")).unwrap_or(0) as i32,
    // rust: priority: TickPriority::by_value(number(t.get("p")).unwrap_or(0) as i32),
    // rust: })
    // rust: })
    // rust: .collect()
}
pub fn fluid_name(kind: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_world::fluid::FluidKind;
    // rust: let fluid = *FluidKind::ALL.get(kind as usize)?;
    // rust: Some(
    // rust: match fluid {
    // rust: FluidKind::Empty => return None,
    // rust: FluidKind::FlowingWater => "minecraft:flowing_water",
    // rust: FluidKind::Water => "minecraft:water",
    // rust: FluidKind::FlowingLava => "minecraft:flowing_lava",
    // rust: FluidKind::Lava => "minecraft:lava",
}
    // rust: .to_owned(),
    // rust: )
}
pub fn fluid_id(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_world::fluid::FluidKind;
    // rust: Some(match name {
    // rust: "minecraft:flowing_water" => FluidKind::FlowingWater,
    // rust: "minecraft:water" => FluidKind::Water,
    // rust: "minecraft:flowing_lava" => FluidKind::FlowingLava,
    // rust: "minecraft:lava" => FluidKind::Lava,
    // rust: _ => return None,
    // rust: } as u32)
}

    // rust: pub use horizon_items::item_nbt::{
    // rust: decode_items, encode_item, encode_items, item_from_nbt, item_to_nbt,
}
/// The block entity type ID for the block it sits in (a chest-like container
/// is a chest, trapped chest or barrel).
pub fn block_entity_id(e: *crate::containers::BlockEntity, block: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (e, block) {
    // rust: (
    // rust: crate::containers::BlockEntity::Chest(_),
    // rust: "minecraft:trapped_chest" | "minecraft:barrel" | "minecraft:dropper",
    // rust: ) => block.to_owned(),
    // rust: (crate::containers::BlockEntity::Chest(_), b) if b.ends_with("shulker_box") => {
    // rust: "minecraft:shulker_box".to_owned()
}
    // rust: _ => e.id().to_owned(),
}
}
    // rust: pub fn encode_block_entity(
    // rust: p: (i32, i32, i32),
    // rust: e: &crate::containers::BlockEntity,
    // rust: block: &str,
    // rust: ) -> Tag {
//     use crate::containers::BlockEntity;
    // rust: if let BlockEntity::Mod(m) = e {
    // rust: let mut map = m.nbt.clone();
    // rust: map.insert("id".into(), string(&m.id));
    // rust: if m.items.iter().any(Option::is_some) {
    // rust: map.insert("Items".into(), encode_items(&m.items));
}
    // rust: for (key, v) in [("x", p.0), ("y", p.1), ("z", p.2)] {
    // rust: map.insert(key.into(), Tag::Int(v));
}
    // rust: return Tag::Compound(map);
}
    // rust: let components = match e {
    // rust: BlockEntity::Banner(b) => b.components.clone(),
    // rust: _ => Compound::new(),
}
    // rust: let mut entries = vec![
    // rust: ("id", string(&block_entity_id(e, block))),
    // rust: ("x", Tag::Int(p.0)),
    // rust: ("y", Tag::Int(p.1)),
    // rust: ("z", Tag::Int(p.2)),
    // rust: ("keepPacked", Tag::Byte(0)),
    // rust: ("components", Tag::Compound(components)),
    // rust: ];
    // rust: match e {
    // rust: BlockEntity::Chest(items) => entries.push(("Items", encode_items(items))),
    // rust: BlockEntity::Furnace(f) => {
    // rust: entries.push(("Items", encode_items(&f.items)));
    // rust: entries.push(("lit_time_remaining", Tag::Int(f.lit_remaining)));
    // rust: entries.push(("lit_total_time", Tag::Int(f.lit_total)));
    // rust: entries.push(("cooking_time_spent", Tag::Int(f.cooking_timer)));
    // rust: entries.push(("cooking_total_time", Tag::Int(f.cooking_total)));
    // rust: entries.push(("speed_multiplier", Tag::Float(f.speed.to_bits())));
    // rust: let used: Compound = f
    // rust: .recipes_used
    // rust: .iter()
    // rust: .map(|(id, count)| (id.as_str().into(), Tag::Int(*count as i32)))
    // rust: .collect();
    // rust: entries.push(("RecipesUsed", Tag::Compound(used)));
}
    // rust: BlockEntity::Brewing(b) => {
    // rust: entries.push(("Items", encode_items(&b.items)));
    // rust: entries.push(("BrewTime", Tag::Int(b.brew_time)));
    // rust: entries.push(("total_brew_time", Tag::Int(b.total_brew_time)));
    // rust: entries.push(("Fuel", Tag::Int(b.fuel)));
    // rust: entries.push(("total_fuel", Tag::Int(b.total_fuel)));
    // rust: entries.push(("speed_multiplier", Tag::Float(b.speed.to_bits())));
}
    // rust: BlockEntity::Sign(sign) => entries.extend(sign.encode()),
    // rust: BlockEntity::Jukebox(j) => {
    // rust: if let Some(record) = j.record() {
    // rust: entries.push(("RecordItem", item_to_nbt(record)));
}
    // rust: entries.push(("ticks_since_song_started", Tag::Long(j.ticks)));
}
    // rust: BlockEntity::Beacon(b) => {
    // rust: if let Some(p) = &b.primary {
    // rust: entries.push(("primary_effect", string(p)));
}
    // rust: if let Some(s) = &b.secondary {
    // rust: entries.push(("secondary_effect", string(s)));
}
    // rust: entries.push(("Levels", Tag::Int(b.levels)));
}
    // rust: BlockEntity::Lectern(l) => {
    // rust: if let Some(book) = &l.book {
    // rust: entries.push(("Book", item_to_nbt(book)));
    // rust: entries.push(("Page", Tag::Int(l.page)));
}
}
    // rust: BlockEntity::Sculk(s) => entries.extend(s.to_nbt()),
    // rust: BlockEntity::Shelf(shelf) => {
    // rust: entries.push(("Items", encode_items(&shelf.items)));
    // rust: entries.push((
    // rust: "align_items_to_bottom",
    // rust: Tag::Byte(i8::from(shelf.align_to_bottom)),
    // rust: ));
}
        // ChiseledBookShelfBlockEntity.saveAdditional.
    // rust: BlockEntity::ChiseledBookshelf(b) => {
    // rust: entries.push(("Items", encode_items(&b.items)));
    // rust: entries.push(("last_interacted_slot", Tag::Int(b.last_slot)));
}
        // CampfireBlockEntity.saveAdditional.
    // rust: BlockEntity::Campfire(c) => {
    // rust: entries.push(("Items", encode_items(&c.items)));
    // rust: entries.push(("CookingTimes", Tag::IntArray(c.progress.to_vec())));
    // rust: entries.push(("CookingTotalTimes", Tag::IntArray(c.total.to_vec())));
}
    // rust: BlockEntity::Crafter(c) => {
    // rust: entries.push(("Items", encode_items(&c.items)));
    // rust: entries.push((
    // rust: "disabled_slots",
    // rust: Tag::IntArray(
    // rust: (0..9)
    // rust: .filter(|&i| c.disabled[i])
    // rust: .map(|i| i as i32)
    // rust: .collect(),
    // rust: ),
    // rust: ));
    // rust: entries.push(("triggered", Tag::Int(i32::from(c.triggered))));
    // rust: entries.push(("crafting_ticks_remaining", Tag::Int(c.crafting_ticks)));
}
    // rust: BlockEntity::Banner(b) => {
    // rust: if !b.layers.is_empty() {
    // rust: entries.push(("patterns", crate::banner::layers_to_nbt(&b.layers)));
}
    // rust: if let Some(name) = &b.name {
    // rust: entries.push(("CustomName", string(name)));
}
}
    // rust: BlockEntity::CreakingHeart(h) => {
    // rust: if let Some((_, uuid)) = h.creaking {
    // rust: entries.push(("creaking", uuid_tag(uuid)));
}
}
    // rust: BlockEntity::Skull(s) => {
    // rust: if let Some(profile) = &s.profile {
    // rust: entries.push(("profile", profile.clone()));
}
    // rust: if let Some(sound) = &s.note_block_sound {
    // rust: entries.push(("note_block_sound", string(sound)));
}
    // rust: if let Some(name) = &s.custom_name {
    // rust: entries.push(("custom_name", name.clone()));
}
}
        // TheEndGatewayBlockEntity.saveAdditional.
    // rust: BlockEntity::EndGateway(g) => {
    // rust: entries.push(("Age", Tag::Long(g.age)));
    // rust: if let Some(exit) = g.exit_portal {
    // rust: entries.push(("exit_portal", Tag::IntArray(exit.to_vec())));
}
    // rust: if g.exact_teleport {
    // rust: entries.push(("ExactTeleport", Tag::Byte(1)));
}
}
    // rust: BlockEntity::Spawner(s) => entries.extend(s.save()),
    // rust: BlockEntity::TrialSpawner(s) => entries.extend(s.save()),
    // rust: BlockEntity::Vault(v) => entries.extend(v.save()),
    // rust: BlockEntity::Beehive(h) => entries.extend(h.to_nbt()),
    // rust: BlockEntity::CommandBlock(c) => entries.extend(c.save()),
    // rust: BlockEntity::StructureBlock(b) => entries.extend(b.save()),
    // rust: BlockEntity::JigsawBlock(b) => entries.extend(b.save()),
    // rust: BlockEntity::TestBlock(b) => entries.extend(b.save()),
    // rust: BlockEntity::TestInstanceBlock(b) => entries.extend(b.save()),
    // rust: BlockEntity::Brushable(b) => {
    // rust: if let Some(table) = &b.loot_table {
    // rust: entries.push(("LootTable", table.clone()));
    // rust: if let Some(seed) = &b.loot_seed {
    // rust: entries.push(("LootTableSeed", seed.clone()));
}
    // rust: } else if let Some(item) = &b.item {
    // rust: entries.push(("item", item_to_nbt(item)));
}
}
        // Encoded above.
    // rust: BlockEntity::DaylightDetector | BlockEntity::Mod(_) => {}
        // PotentSulfurBlockEntity.saveAdditional.
    // rust: BlockEntity::PotentSulfur(sulfur) => {
    // rust: entries.push(("countdown", Tag::Int(sulfur.waiting_countdown)))
}
}
    // rust: Tag::compound(entries)
}
/// `block_entity_nbt::overlay`, then a container that now holds items loses its
/// loot table (vanilla clears it when the loot is generated into the container).
pub fn merge_block_entity(original: *Tag, loaded: *Tag, current: *Tag) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut merged = crate::block_entity_nbt::overlay(original, loaded, current);
    // rust: let has_items = matches!(current.get("Items"), Some(Tag::List(items)) if !items.is_empty());
    // rust: if has_items && let Tag::Compound(map) = &mut merged {
    // rust: map.remove(&"LootTable".into());
    // rust: map.remove(&"LootTableSeed".into());
}
    // rust: merged
}
/// `BlockDataAccessor.getData` (`BlockEntity.saveWithFullMetadata`): the tag
/// `data get block` shows and `data merge block` changes, without the
/// chunk-only `keepPacked`, and with the fields Horizon keeps outside its
/// model: a container's `lock` (`LockCode`), from the tag it was loaded or set
/// with.
    // rust: pub fn block_entity_data(
    // rust: p: (i32, i32, i32),
    // rust: e: &crate::containers::BlockEntity,
    // rust: block: &str,
    // rust: lock: Option<&Tag>,
    // rust: ) -> Tag {
    // rust: let mut tag = encode_block_entity(p, e, block);
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"keepPacked".into());
    // rust: if let Some(lock) = lock {
    // rust: map.insert("lock".into(), lock.clone());
}
}
    // rust: tag
}
/// `BannerBlockEntity.loadAdditional` (and the `components` a block entity keeps).
pub fn decode_banner(tag: *Tag) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::containers::Banner {
    // rust: layers: crate::banner::layers_from_nbt(tag.get("patterns")),
    // rust: name: text(tag.get("CustomName")),
    // rust: components: match tag.get("components") {
    // rust: Some(Tag::Compound(c)) => c.clone(),
    // rust: _ => Compound::new(),
    // rust: },
}
}
/// A loaded container with a loot table and no items yet, rolled as
/// generation rolls it (Horizon does not unpack on first open).
    // rust: fn roll_loaded_loot(
    // rust: chunk: &Chunk,
    // rust: biomes: &Biomes,
    // rust: tag: &Tag,
    // rust: be: &mut ((i32, i32, i32), crate::containers::BlockEntity),
    // rust: ) -> Option<RolledLoot> {
    // rust: let crate::containers::BlockEntity::Chest(slots) = &mut be.1 else {
    // rust: return None;
}
    // `tryLoadLootTable`: a key the codec rejects is no table at all.
    // rust: let table = text(tag.get("LootTable"))
    // rust: .and_then(|id| horizon_client_core::identifier::normalize_id(&id))?;
    // rust: if slots.iter().any(Option::is_some) {
    // rust: return None;
}
    // rust: let loot = crate::structure_blocks::loaded_loot_data()?;
    // rust: let (x, y, z) = be.0;
    // rust: let biome = &biomes.get(chunk.biome(x & 15, y, z & 15)).name;
    // rust: let seed = crate::structure_blocks::loot_seed(tag);
    // rust: Some(crate::structure_blocks::roll_container(
    // rust: slots,
    // rust: Some(&loot),
    // rust: table,
    // rust: seed,
    // rust: be.0,
    // rust: biome,
    // rust: ))
}
/// `TheEndGatewayBlockEntity.loadAdditional`.
pub fn decode_end_gateway(tag: *Tag) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::containers::EndGateway {
    // rust: age: number(tag.get("Age")).unwrap_or(0),
    // rust: exit_portal: tag
    // rust: .get("exit_portal")
    // rust: .and_then(crate::block_entity_nbt::gateway_exit),
    // rust: exact_teleport: number(tag.get("ExactTeleport")).unwrap_or(0) != 0,
}
}
/// A mod's block entity: its compound without `id` and the position, and
/// its `Items` as slots (`ContainerHelper.loadAllItems`; the game sizes them
/// to the block's container when it uses them). `Items` that are not an item
/// list saved exactly so stay the mod's own.
pub fn decode_mod_block_entity(id: []const u8, tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Tag::Compound(map) = tag else {
    // rust: return None;
}
    // rust: let mut nbt = map.clone();
    // rust: for key in ["id", "x", "y", "z"] {
    // rust: nbt.remove(&key.into());
}
    // `Slot` is a byte: 256 slots at most.
    // rust: let mut items = decode_items(nbt.get(&"Items".into()), 256);
    // rust: if nbt.get(&"Items".into()) == Some(&encode_items(&items)) {
    // rust: nbt.remove(&"Items".into());
    // rust: while items.last().is_some_and(Option::is_none) {
    // rust: items.pop();
}
    // rust: } else {
    // rust: items.clear();
}
    // rust: Some(
    // rust: crate::containers::ModBlockEntityFields {
    // rust: id,
    // rust: nbt,
    // rust: items,
    // rust: data: Vec::new(),
}
    // rust: .into(),
    // rust: )
}
pub fn decode_block_entity(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use crate::containers::BlockEntity;
    // rust: let int = |k: &str| number(tag.get(k)).map(|v| v as i32);
    // rust: let id = text(tag.get("id"))?;
    // rust: let pos = (int("x")?, int("y")?, int("z")?);
    // rust: if id.contains(':') && !id.starts_with("minecraft:") {
    // rust: return Some((
    // rust: pos,
    // rust: BlockEntity::Mod(Box::new(decode_mod_block_entity(id, tag)?)),
    // rust: ));
}
    // rust: if id == "minecraft:end_gateway" {
    // rust: return Some((pos, BlockEntity::EndGateway(decode_end_gateway(tag))));
}
    // rust: if id == "minecraft:jukebox" {
    // rust: let record = tag.get("RecordItem").and_then(item_from_nbt);
    // rust: let ticks = number(tag.get("ticks_since_song_started")).unwrap_or(0);
    // rust: let playing = record.is_some();
    // rust: return Some((
    // rust: pos,
    // rust: BlockEntity::Jukebox(crate::containers::Jukebox {
    // rust: items: [record],
    // rust: ticks,
    // rust: playing,
    // rust: }),
    // rust: ));
}
    // rust: if id == "minecraft:creaking_heart" {
    // rust: let heart = crate::containers::CreakingHeart {
    // rust: creaking: uuid_from_tag(tag.get("creaking")).map(|uuid| (None, uuid)),
    // rust: ..Default::default()
}
    // rust: return Some((pos, BlockEntity::CreakingHeart(Box::new(heart))));
}
    // rust: if id == "minecraft:lectern" {
        // `LecternBlockEntity.loadAdditional`: the page is `Mth.clamp(Page, 0,
        // getPageCount(book) - 1)`, so a stored page before the book's first
        // page or past its last comes back as the page the block holds. No
        // book, or a book with no pages, counts 0 pages: the maximum is then
        // -1, and `Mth.clamp` (`Math.min(Math.max(value, min), max)`) answers
        // it, -1.
    // rust: let book = tag.get("Book").and_then(item_from_nbt);
    // rust: let count = book.as_ref().map_or(0, crate::menu::book_pages) as i32;
    // rust: let lectern = crate::containers::Lectern {
    // rust: book,
    // rust: page: int("Page").unwrap_or(0).max(0).min(count - 1),
}
    // rust: return Some((pos, BlockEntity::Lectern(lectern)));
}
    // rust: if id == "minecraft:banner" {
    // rust: return Some((pos, BlockEntity::Banner(decode_banner(tag))));
}
    // rust: if id == "minecraft:beacon" {
    // rust: let beacon = crate::containers::Beacon {
    // rust: levels: int("Levels").unwrap_or(0),
    // rust: primary: text(tag.get("primary_effect")),
    // rust: secondary: text(tag.get("secondary_effect")),
    // rust: last_check_y: i32::MIN / 2,
    // rust: ..Default::default()
}
    // rust: return Some((pos, BlockEntity::Beacon(Box::new(beacon))));
}
    // A skull's block entity id is not its block's name (every head block).
    // rust: if id == "minecraft:skull" {
    // rust: return Some((
    // rust: pos,
    // rust: BlockEntity::Skull(crate::containers::Skull::new(
    // rust: tag.get("profile").cloned(),
    // rust: text(tag.get("note_block_sound")),
    // rust: tag.get("custom_name")
    // rust: .and_then(crate::block_entity_nbt::component),
    // rust: )),
    // rust: ));
}
    // A spawner's block entity id is not its block's name.
    // rust: let block = match id.as_str() {
    // rust: "minecraft:mob_spawner" => "minecraft:spawner",
    // rust: other => other,
}
    // rust: let mut entity = BlockEntity::for_block(block)?;
    // rust: match &mut entity {
    // rust: BlockEntity::Chest(items) => {
            // Randomizable containers reset their inventory, then load Items only
            // when tryLoadLootTable did not read a valid loot-table key.
    // rust: let has_table = text(tag.get("LootTable"))
    // rust: .and_then(|id| horizon_client_core::identifier::normalize_id(&id))
    // rust: .is_some();
    // rust: if !has_table {
    // rust: *items = decode_items(tag.get("Items"), items.len());
}
}
    // rust: BlockEntity::Furnace(f) => {
    // rust: let items = decode_items(tag.get("Items"), 3);
    // rust: f.items = [items[0].clone(), items[1].clone(), items[2].clone()];
    // rust: f.lit_remaining = int("lit_time_remaining").unwrap_or(0);
    // rust: f.lit_total = int("lit_total_time").unwrap_or(0);
    // rust: f.cooking_timer = int("cooking_time_spent").unwrap_or(0);
    // rust: f.cooking_total = int("cooking_total_time").unwrap_or(0);
    // rust: if let Some(speed) = float(tag.get("speed_multiplier")) {
    // rust: f.speed = speed as f32;
}
            // A save without it owes nothing: the field is newer than some worlds.
    // rust: if let Some(Tag::Compound(used)) = tag.get("RecipesUsed") {
    // rust: for (id, count) in used {
    // rust: let count = match count {
    // rust: Tag::Int(n) => *n,
    // rust: _ => continue,
}
                    // Saves from before the key was namespaced hold both forms of an id.
    // rust: *f.recipes_used
    // rust: .entry(crate::containers::recipe_used_key(&id.to_string_lossy()))
    // rust: .or_insert(0) += count.max(0) as u32;
}
}
}
    // rust: BlockEntity::Brewing(b) => {
    // rust: let items = decode_items(tag.get("Items"), 5);
    // rust: b.items = [
    // rust: items[0].clone(),
    // rust: items[1].clone(),
    // rust: items[2].clone(),
    // rust: items[3].clone(),
    // rust: items[4].clone(),
    // rust: ];
    // rust: b.brew_time = int("BrewTime").unwrap_or(0);
    // rust: b.total_brew_time = int("total_brew_time").unwrap_or(400);
    // rust: if b.brew_time > 0 {
    // rust: b.ingredient = b.items[3].as_ref().map(|s| s.item.clone());
}
    // rust: b.fuel = int("Fuel").unwrap_or(0);
    // rust: b.total_fuel = int("total_fuel").unwrap_or(20);
    // rust: b.speed = match tag.get("speed_multiplier") {
    // rust: Some(Tag::Float(f)) => f32::from_bits(*f),
    // rust: _ => 1.0,
}
}
    // rust: BlockEntity::Brushable(b) => {
    // rust: b.loot_table = tag.get("LootTable").cloned();
    // rust: b.loot_seed = tag.get("LootTableSeed").cloned();
    // rust: b.item = if b.loot_table.is_none() {
    // rust: tag.get("item").and_then(item_from_nbt)
    // rust: } else {
    // rust: None
}
    // rust: b.hit_direction = int("hit_direction").filter(|v| (0..=5).contains(v));
}
    // rust: BlockEntity::Sign(sign) => sign.decode(tag),
    // rust: BlockEntity::Sculk(s) => s.load(tag),
    // rust: BlockEntity::Shelf(shelf) => {
    // rust: for (slot, item) in decode_items(tag.get("Items"), 3).into_iter().enumerate() {
    // rust: shelf.items[slot] = item;
}
    // rust: shelf.align_to_bottom = int("align_items_to_bottom").unwrap_or(0) != 0;
}
        // ChiseledBookShelfBlockEntity.loadAdditional.
    // rust: BlockEntity::ChiseledBookshelf(b) => {
    // rust: for (slot, item) in decode_items(tag.get("Items"), 6).into_iter().enumerate() {
    // rust: b.items[slot] = item;
}
    // rust: b.last_slot = int("last_interacted_slot").unwrap_or(-1);
}
        // CampfireBlockEntity.loadAdditional: missing time arrays stay zeros.
    // rust: BlockEntity::Campfire(c) => {
    // rust: for (slot, item) in decode_items(tag.get("Items"), 4).into_iter().enumerate() {
    // rust: c.items[slot] = item;
}
    // rust: let ints = |key: &str| match tag.get(key) {
    // rust: Some(Tag::IntArray(v)) => std::array::from_fn(|i| v.get(i).copied().unwrap_or(0)),
    // rust: _ => [0; 4],
}
    // rust: c.progress = ints("CookingTimes");
    // rust: c.total = ints("CookingTotalTimes");
}
    // rust: BlockEntity::Crafter(c) => {
    // rust: for (slot, item) in decode_items(tag.get("Items"), 9).into_iter().enumerate() {
    // rust: c.items[slot] = item;
}
    // rust: if let Some(Tag::IntArray(slots)) = tag.get("disabled_slots") {
    // rust: for &slot in slots {
    // rust: if (0..9).contains(&slot) && c.items[slot as usize].is_none() {
    // rust: c.disabled[slot as usize] = true;
}
}
}
    // rust: c.triggered = int("triggered").unwrap_or(0) != 0;
    // rust: c.state_triggered = None;
    // rust: c.crafting_ticks = int("crafting_ticks_remaining").unwrap_or(0);
}
        // PotentSulfurBlockEntity.loadAdditional.
    // rust: BlockEntity::PotentSulfur(sulfur) => {
    // rust: if let Some(countdown) = int("countdown") {
    // rust: sulfur.waiting_countdown = countdown;
}
}
    // rust: BlockEntity::Jukebox(_)
    // rust: | BlockEntity::Beacon(_)
    // rust: | BlockEntity::Lectern(_)
    // rust: | BlockEntity::Banner(_)
    // rust: | BlockEntity::CreakingHeart(_)
    // rust: | BlockEntity::EndGateway(_)
    // rust: | BlockEntity::Skull(_)
    // rust: | BlockEntity::DaylightDetector
    // rust: | BlockEntity::Mod(_) => {}
    // rust: BlockEntity::Spawner(s) => **s = crate::mobs::spawner::Spawner::load(tag),
    // rust: BlockEntity::TrialSpawner(s) => **s = crate::mobs::trial_spawner::TrialSpawner::load(tag),
    // rust: BlockEntity::Vault(v) => **v = crate::vault::Vault::load(tag),
    // rust: BlockEntity::Beehive(h) => **h = crate::beehive::Beehive::from_nbt(tag),
    // rust: BlockEntity::CommandBlock(c) => **c = crate::command_block::CommandBlock::load(tag),
    // rust: BlockEntity::StructureBlock(b) => **b = crate::structure_block::StructureBlock::load(tag),
    // rust: BlockEntity::TestBlock(b) => **b = crate::test_block::TestBlock::load(tag),
    // rust: BlockEntity::TestInstanceBlock(b) => b.load(tag),
        // The state is not known here; a saved jigsaw always has its joint.
    // rust: BlockEntity::JigsawBlock(b) => {
    // rust: **b = crate::jigsaw_block::JigsawBlock::load(
    // rust: tag,
    // rust: crate::jigsaw_block::JointType::Rollable,
    // rust: )
}
}
    // rust: Some((pos, entity))
}

/// The chunk's points of interest as `PoiManager` saves them: each section
/// with POI blocks, valid, with a record per block at its max tickets (a
/// freshly made world). None when the chunk has none.
pub fn encode_poi(chunk: *Chunk, tables: *SaveTables) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = |v: u32| tables.poi.get(v as usize).copied().flatten();
    // rust: let mut sections = Compound::new();
    // rust: let mut states = [0u32; 4096];
    // rust: for (si, section) in chunk.sections.iter().enumerate() {
    // rust: if !section.blocks.maybe_has(|v| kind(v).is_some()) {
    // rust: continue;
}
    // rust: section.unpack(&mut states);
    // rust: let y = (chunk.min_y() >> 4) + si as i32;
    // rust: let records: Vec<Tag> = states
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, &v)| {
    // rust: let (id, tickets) = kind(v)?;
    // rust: let i = i as i32;
    // rust: let pos = [
    // rust: chunk.x * 16 + (i & 15),
    // rust: y * 16 + (i >> 8),
    // rust: chunk.z * 16 + ((i >> 4) & 15),
    // rust: ];
    // rust: let mut record = vec![("pos", Tag::IntArray(pos.to_vec())), ("type", string(id))];
                // PoiRecord.CODEC: free_tickets defaults to 0 and is then left out.
    // rust: if tickets != 0 {
    // rust: record.push(("free_tickets", Tag::Int(tickets)));
}
    // rust: Some(Tag::compound(record))
    // rust: })
    // rust: .collect();
    // rust: if !records.is_empty() {
    // rust: sections.insert(
    // rust: y.to_string().as_str().into(),
    // rust: Tag::compound([("Valid", Tag::Byte(1)), ("Records", Tag::List(records))]),
    // rust: );
}
}
    // rust: (!sections.is_empty()).then(|| poi_root(sections))
}
/// A record's `free_tickets` from the POI file the chunk had, while the same
/// POI is still there: a bed or job site a villager claimed stays claimed.
pub fn keep_claims(saved: *mut NamedTag, old: *NamedTag) void {
}
    // rust: let key = |r: &Tag| match (r.get("pos"), text(r.get("type"))) {
    // rust: (Some(Tag::IntArray(pos)), Some(kind)) => Some((pos.clone(), kind)),
    // rust: _ => None,
}
    // rust: let mut claims = HashMap::new();
    // rust: if let Some(Tag::Compound(sections)) = old.tag.get("Sections") {
    // rust: for section in sections.values() {
    // rust: if let Some(Tag::List(records)) = section.get("Records") {
    // rust: for r in records {
    // rust: if let Some(k) = key(r) {
    // rust: claims.insert(k, number(r.get("free_tickets")).unwrap_or(0) as i32);
}
}
}
}
}
    // rust: let Tag::Compound(root) = &mut saved.tag else {
    // rust: return;
}
    // rust: let Some(Tag::Compound(sections)) = root.get_mut(&"Sections".into()) else {
    // rust: return;
}
    // rust: for section in sections.values_mut() {
    // rust: let Tag::Compound(section) = section else {
    // rust: continue;
}
    // rust: let Some(Tag::List(records)) = section.get_mut(&"Records".into()) else {
    // rust: continue;
}
    // rust: for r in records {
    // rust: let Some(&tickets) = key(r).and_then(|k| claims.get(&k)) else {
    // rust: continue;
}
    // rust: if let Tag::Compound(r) = r {
    // rust: if tickets == 0 {
    // rust: r.remove(&"free_tickets".into());
    // rust: } else {
    // rust: r.insert("free_tickets".into(), Tag::Int(tickets));
}
}
}
}
}
pub fn poi_root(sections: Compound) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: ("Sections", Tag::Compound(sections)),
    // rust: ]),
}
}

    // rust: pub use crate::chunk::LevelShape;

/// A column's sections as `Heightmap.primeHeightmaps` reads them.
pub const HeightmapView = struct {
    sections: *'a [*Section],
    /// The minimum Y of `sections[0]`.
    column_min_y: i32,
    tables: *'a SaveTables,
    min_y: i32,
    height: i32,
};
    // rust: impl HeightmapChunk for HeightmapView<'_> {
    // rust: type State = crate::assets::StateFacts;
pub fn min_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min_y
}
pub fn height(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.height
}
pub fn highest_section_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let top = self
    // rust: .sections
    // rust: .iter()
    // rust: .rposition(|s| !s.is_uniform(self.tables.air))
    // rust: .unwrap_or(0);
    // rust: self.column_min_y + top as i32 * 16
}
pub fn block_state(self: *Self, x: i32, y: i32, z: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
        // Chunk.get: no block outside the sections.
    // rust: let state = usize::try_from((y - self.column_min_y) >> 4)
    // rust: .ok()
    // rust: .and_then(|s| self.sections.get(s))
    // rust: .map_or(0, |s| s.get(crate::chunk::index(x, y, z)));
    // rust: self.tables.heightmaps.heightmap_state(BlockStateId(state))
}
}
/// Heightmaps kept after world generation (`ChunkStatus.FULL.heightmapsAfter`).
pub fn heightmaps(chunk: *Chunk, tables: *SaveTables, shape: LevelShape) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kinds = [
    // rust: HeightmapType::WorldSurface,
    // rust: HeightmapType::OceanFloor,
    // rust: HeightmapType::MotionBlocking,
    // rust: HeightmapType::MotionBlockingNoLeaves,
    // rust: ];
    // rust: let mut maps: Vec<Heightmap> = kinds
    // rust: .iter()
    // rust: .filter_map(|k| Heightmap::new(*k, shape.min_y, shape.height).ok())
    // rust: .collect();
    // rust: let view = HeightmapView {
    // rust: sections: &chunk.sections,
    // rust: column_min_y: chunk.min_y(),
    // rust: tables,
    // rust: min_y: shape.min_y,
    // rust: height: shape.height,
}
    // rust: let mut refs: Vec<&mut Heightmap> = maps.iter_mut().collect();
    // rust: if Heightmap::prime(&view, &mut refs).is_err() {
    // rust: return Tag::Compound(Compound::new());
}
    // rust: Tag::compound(maps.iter().map(|m| {
    // rust: (
    // rust: m.kind().name(),
    // rust: Tag::LongArray(m.raw_data().iter().map(|&w| w as i64).collect()),
    // rust: )
    // rust: }))
}
/// The client heightmaps of a column's sections (from `column_min_y`), in a
/// level from `min_y`, `height` blocks high.
    // rust: pub fn client_heightmaps_in(
    // rust: sections: &[Arc<Section>],
    // rust: column_min_y: i32,
    // rust: tables: &SaveTables,
    // rust: min_y: i32,
    // rust: height: i32,
    // rust: ) -> Vec<(i32, Vec<i64>)> {
    // rust: let kinds = [
    // rust: (1, HeightmapType::WorldSurface),
    // rust: (4, HeightmapType::MotionBlocking),
    // rust: (5, HeightmapType::MotionBlockingNoLeaves),
    // rust: ];
    // rust: let mut maps: Vec<(i32, Heightmap)> = kinds
    // rust: .iter()
    // rust: .filter_map(|(id, k)| Heightmap::new(*k, min_y, height).ok().map(|m| (*id, m)))
    // rust: .collect();
    // rust: let view = HeightmapView {
    // rust: sections,
    // rust: column_min_y,
    // rust: tables,
    // rust: min_y,
    // rust: height,
}
    // rust: let mut refs: Vec<&mut Heightmap> = maps.iter_mut().map(|(_, m)| m).collect();
    // rust: if Heightmap::prime(&view, &mut refs).is_err() {
    // rust: return Vec::new();
}
    // rust: maps.iter()
    // rust: .map(|(id, m)| (*id, m.raw_data().iter().map(|&w| w as i64).collect()))
    // rust: .collect()
}
/// Vanilla light layer (nibbles, index y<<8|z<<4|x, low nibble first).
pub fn nibbles(light: *Light, sky: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = vec![0u8; 2048];
    // rust: for (i, byte) in out.iter_mut().enumerate() {
    // rust: let value = |j: usize| {
    // rust: let v = light.get(j);
    // rust: if sky { v >> 4 } else { v & 15 }
}
    // rust: *byte = value(2 * i) | value(2 * i + 1) << 4;
}
    // rust: out
}

pub fn encode(chunk: *Chunk, registry: *BlockRegistry, biomes: *Biomes) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: encode_with(chunk, registry, biomes, None, LevelShape::OVERWORLD)
}
/// The chunk NBT vanilla's `SerializableChunkData.write` produces for a full
/// chunk in a level of `shape`.
    // rust: pub fn encode_with(
    // rust: chunk: &Chunk,
    // rust: registry: &BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: tables: Option<&SaveTables>,
    // rust: shape: LevelShape,
    // rust: ) -> NamedTag {
    // rust: let sky_light = shape.sky_light;
    // rust: let mut sections = Vec::new();
    // rust: let air = tables.map_or(0, |t| t.air);
    // Sky layers below the highest section with light other than 15 are
    // written (even all-zero ones): vanilla derives missing layers from the
    // layer above them.
    // rust: let top_sky = chunk
    // rust: .sections
    // rust: .iter()
    // rust: .rposition(|s| s.light.any_not(0xF0, 0xF0));
    // rust: for (si, section) in chunk.sections.iter().enumerate() {
    // rust: let y = (chunk.min_y() >> 4) + si as i32;
    // rust: if !shape.has_section(y) {
    // rust: continue;
}
        // PalettedContainer.pack: distinct states in index order, indices at
        // the saved width.
    // rust: let packed = section.blocks.pack();
    // rust: let mut states = vec![(
    // rust: "palette",
    // rust: Tag::List(
    // rust: packed
    // rust: .palette
    // rust: .iter()
    // rust: .map(|&id| {
    // rust: let state = registry.state(BlockStateId(id));
    // rust: match state {
                            // BlockState.CODEC: the block name for default states.
    // rust: Some(s)
    // rust: if tables.is_some_and(|t| {
    // rust: t.default_state.get(id as usize) == Some(&true)
    // rust: }) =>
    // rust: {
    // rust: string(&s.name)
}
    // rust: Some(s) => s.to_nbt(),
    // rust: None => string("minecraft:air"),
}
    // rust: })
    // rust: .collect(),
    // rust: ),
    // rust: )];
    // rust: if let Some(data) = &packed.data {
    // rust: states.push((
    // rust: "data",
    // rust: Tag::LongArray(data.iter().map(|&w| w as i64).collect()),
    // rust: ));
}
    // rust: let biome_packed = section.biomes.pack();
    // rust: let mut biome_tag = vec![(
    // rust: "palette",
    // rust: Tag::List(
    // rust: biome_packed
    // rust: .palette
    // rust: .iter()
    // rust: .map(|&b| string(&biomes.get(b as u16).name))
    // rust: .collect(),
    // rust: ),
    // rust: )];
    // rust: if let Some(data) = &biome_packed.data {
    // rust: biome_tag.push((
    // rust: "data",
    // rust: Tag::LongArray(data.iter().map(|&w| w as i64).collect()),
    // rust: ));
}
    // rust: let mut entries = vec![
    // rust: ("Y", Tag::Byte(y as i8)),
    // rust: ("block_states", Tag::compound(states)),
    // rust: ("biomes", Tag::compound(biome_tag)),
    // rust: ];
    // rust: if chunk.lit {
    // rust: let block_lit = section.light.any(15);
    // rust: if block_lit {
    // rust: entries.push(("BlockLight", Tag::ByteArray(nibbles(&section.light, false))));
}
    // rust: if sky_light && top_sky.is_some_and(|top| si <= top + 1) {
    // rust: entries.push(("SkyLight", Tag::ByteArray(nibbles(&section.light, true))));
}
}
    // rust: let _ = air;
    // rust: sections.push(Tag::compound(entries));
}
    // rust: let extras = chunk.saved.as_deref();
    // rust: let block_name = |p: &(i32, i32, i32)| -> String {
    // rust: registry
    // rust: .state(chunk.block(p.0 & 15, p.1, p.2 & 15))
    // rust: .map_or_else(String::new, |s| s.name.clone())
}
    // rust: let mut block_entities: Vec<Tag> = chunk
    // rust: .block_entities
    // rust: .iter()
        // A mod block entity a native mod is ticking right now
        // (`tick_mod_block_entity`): its data is out of the world.
    // rust: .filter(|(_, e)| !matches!(e, crate::containers::BlockEntity::Mod(m) if m.id.is_empty()))
    // rust: .map(|(p, e)| {
    // rust: let block = block_name(p);
    // rust: let mut current = encode_block_entity(*p, e, &block);
    // rust: if let Some((_, name)) = chunk.block_names.iter().find(|(q, _)| q == p)
    // rust: && let Tag::Compound(map) = &mut current
    // rust: {
    // rust: map.insert("CustomName".into(), string(name));
}
    // rust: let source = extras
    // rust: .and_then(|x| x.block_entity_sources.iter().find(|(q, _)| q == p))
    // rust: .map(|(_, tag)| tag)
    // rust: .filter(|tag| {
    // rust: crate::block_entity_nbt::id(tag) == crate::block_entity_nbt::id(&current)
    // rust: });
    // rust: let merged = match source {
    // rust: Some(original) => {
    // rust: let loaded = decode_block_entity(original).map_or_else(
    // rust: || current.clone(),
    // rust: |(q, e)| encode_block_entity(q, &e, &block),
    // rust: );
    // rust: merge_block_entity(original, &loaded, &current)
}
    // rust: None => current,
}
    // rust: let mut saved = crate::block_entity_nbt::canonical(&merged).unwrap_or(merged);
    // rust: if let Some((_, attachments)) =
    // rust: extras.and_then(|e| e.block_entity_attachments.iter().find(|(pos, _)| pos == p))
    // rust: && let Tag::Compound(map) = &mut saved
    // rust: && attachment_compound(map.get(&ATTACHMENTS_KEY.into())).is_ok()
    // rust: {
    // rust: let data = attachments.to_nbt();
    // rust: if data.is_empty() {
    // rust: map.remove(&ATTACHMENTS_KEY.into());
    // rust: } else {
    // rust: map.insert(ATTACHMENTS_KEY.into(), Tag::Compound(data));
}
}
    // rust: if let Some(r) = extras.and_then(|x| x.rolled_loot.iter().find(|r| r.pos == *p))
    // rust: && let Tag::Compound(map) = &mut saved
    // rust: && !r.restore(map)
    // rust: {
                // A loaded source still carries the table; kept, it rolls again on load.
    // rust: map.remove(&"LootTable".into());
    // rust: map.remove(&"LootTableSeed".into());
}
    // rust: saved
    // rust: })
    // rust: .collect();
    // rust: if let Some(extras) = extras {
    // rust: for raw in &extras.block_entities {
    // rust: let pos = (
    // rust: number(raw.get("x")).unwrap_or(0) as i32,
    // rust: number(raw.get("y")).unwrap_or(0) as i32,
    // rust: number(raw.get("z")).unwrap_or(0) as i32,
    // rust: );
    // rust: let state = chunk.get(pos.0 & 15, pos.1, pos.2 & 15) as usize;
    // rust: let still_there =
    // rust: tables.is_none_or(|t| t.block_entity.get(state).copied().unwrap_or(true));
    // rust: if still_there && !chunk.block_entities.iter().any(|(p, _)| *p == pos) {
    // rust: block_entities
    // rust: .push(crate::block_entity_nbt::canonical(raw).unwrap_or_else(|| raw.clone()));
}
}
}
    // rust: let mut root = extras
    // rust: .map(|e| Tag::Compound(e.root.clone()))
    // rust: .unwrap_or_else(|| Tag::Compound(Compound::new()));
    // rust: for (key, value) in [
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: ("xPos", Tag::Int(chunk.x)),
    // rust: ("zPos", Tag::Int(chunk.z)),
    // rust: ("yPos", Tag::Int(shape.min_section())),
    // rust: ("Status", string("minecraft:full")),
    // rust: ("LastUpdate", Tag::Long(extras.map_or(0, |e| e.last_update))),
    // rust: ("isLightOn", Tag::Byte(i8::from(chunk.lit))),
    // rust: ("sections", Tag::List(sections)),
    // rust: ("block_entities", Tag::List(block_entities)),
    // rust: ] {
    // rust: put(&mut root, key, value);
}
    // rust: if let Some(Tag::Compound(map)) = Some(&mut root) {
    // rust: if let Some(extras) = extras
    // rust: && attachment_compound(map.get(&ATTACHMENTS_KEY.into())).is_ok()
    // rust: {
    // rust: let attachments = extras.attachments.to_nbt();
    // rust: if attachments.is_empty() {
    // rust: map.remove(&ATTACHMENTS_KEY.into());
    // rust: } else {
    // rust: map.insert(ATTACHMENTS_KEY.into(), Tag::Compound(attachments));
}
}
    // rust: map.entry("InhabitedTime".into()).or_insert(Tag::Long(0));
    // rust: map.entry("structures".into()).or_insert_with(|| {
    // rust: Tag::compound([
    // rust: ("References", Tag::Compound(Compound::new())),
    // rust: ("starts", Tag::Compound(Compound::new())),
    // rust: ])
    // rust: });
    // rust: if !chunk.structure_refs.is_empty()
    // rust: && let Some(Tag::Compound(s)) = map.get_mut(&"structures".into())
    // rust: {
    // rust: let mut refs: std::collections::BTreeMap<&str, Vec<i64>> = Default::default();
    // rust: for (id, (x, z)) in &chunk.structure_refs {
    // rust: refs.entry(id)
    // rust: .or_default()
    // rust: .push(i64::from(*x as u32) | i64::from(*z) << 32);
}
    // rust: let refs: Compound = refs
    // rust: .into_iter()
    // rust: .map(|(id, v)| (id.into(), Tag::LongArray(v)))
    // rust: .collect();
    // rust: s.insert("References".into(), Tag::Compound(refs));
}
    // rust: let starts: Compound = chunk
    // rust: .structure_starts
    // rust: .iter()
    // rust: .filter_map(|start| match start.save() {
    // rust: Some(tag) => Some((start.name.as_str().into(), tag)),
    // rust: None => {
    // rust: log::warn!(
    // rust: "Horizon: structure start {} not saved: one of its pieces cannot be",
    // rust: start.name
    // rust: );
    // rust: None
}
    // rust: })
    // rust: .collect();
    // rust: if !starts.is_empty()
    // rust: && let Some(Tag::Compound(s)) = map.get_mut(&"structures".into())
    // rust: {
    // rust: s.insert("starts".into(), Tag::Compound(starts));
}
    // rust: map.entry("PostProcessing".into())
    // rust: .or_insert_with(|| Tag::List(vec![Tag::List(Vec::new()); shape.section_count()]));
}
    // rust: if let Some(t) = tables {
    // rust: put(&mut root, "Heightmaps", heightmaps(chunk, t, shape));
    // rust: let names = |k: u32| t.block_names.get(k as usize).cloned();
    // rust: let (blocks, fluids) = extras.map_or((&[][..], &[][..]), |e| {
    // rust: (&e.block_ticks[..], &e.fluid_ticks[..])
    // rust: });
    // rust: put(&mut root, "block_ticks", tick_list(blocks, names));
    // rust: put(&mut root, "fluid_ticks", tick_list(fluids, fluid_name));
}
    // rust: NamedTag {
    // rust: name: "".into(),
    // rust: tag: root,
}
}
/// Root keys `encode_with` regenerates; everything else is kept as loaded.
    // rust: const GENERATED_KEYS: [&str; 14] = [
    // rust: "DataVersion",
    // rust: "xPos",
    // rust: "zPos",
    // rust: "yPos",
    // rust: "Status",
    // rust: "LastUpdate",
    // rust: "isLightOn",
    // rust: "sections",
    // rust: "block_entities",
    // rust: "Heightmaps",
    // rust: "block_ticks",
    // rust: "fluid_ticks",
    // rust: "entities",
    // rust: "CarvingMask",
    // rust: ];
pub fn decode(root: *NamedTag, registry: *BlockRegistry, biomes: *Biomes) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: decode_with(root, registry, biomes, None, ColumnLayout::VANILLA)
}
/// Only full chunks load here; partially generated ones (vanilla's world
/// border of proto chunks) resume generation through `decode_proto`.
    // rust: pub fn decode_with(
    // rust: root: &NamedTag,
    // rust: registry: &BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: tables: Option<&SaveTables>,
    // rust: layout: ColumnLayout,
    // rust: ) -> Option<Chunk> {
    // rust: if text(root.tag.get("Status")).is_some_and(|s| s != "minecraft:full" && s != "full") {
    // rust: return None;
}
    // rust: decode_column(root, registry, biomes, tables, layout)
}
/// A full chunk with the light saved with it (`isLightOn`), as far terrain
/// reads another client's cache of a server; `None` without its light.
    // rust: pub fn decode_lit(
    // rust: root: &NamedTag,
    // rust: registry: &BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: layout: ColumnLayout,
    // rust: sky_light: bool,
    // rust: ) -> Option<Chunk> {
    // rust: let mut chunk = decode_with(root, registry, biomes, None, layout)?;
    // rust: load_light(&root.tag, &mut chunk, sky_light);
    // rust: chunk.light_loaded.then_some(chunk)
}
/// `decode_with` whatever the chunk's status, into a chunk of `layout`
/// (sections outside it are left out).
    // rust: fn decode_column(
    // rust: root: &NamedTag,
    // rust: registry: &BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: tables: Option<&SaveTables>,
    // rust: layout: ColumnLayout,
    // rust: ) -> Option<Chunk> {
    // rust: let tag = &root.tag;
    // rust: let Tag::Int(x) = tag.get("xPos")? else {
    // rust: return None;
}
    // rust: let Tag::Int(z) = tag.get("zPos")? else {
    // rust: return None;
}
    // rust: let mut chunk = Chunk::with_layout(*x, *z, layout);
    // structures.References: structure id -> packed start chunk positions.
    // rust: if let Some(Tag::Compound(refs)) = tag.get("structures").and_then(|s| s.get("References")) {
    // rust: for (id, v) in refs {
    // rust: if let Tag::LongArray(starts) = v {
    // rust: let id: Arc<str> = Arc::from(id.to_string_lossy());
    // rust: for &p in starts {
    // rust: chunk
    // rust: .structure_refs
    // rust: .push((id.clone(), (p as i32, (p >> 32) as i32)));
}
}
}
}
    // rust: let air = registry.default_state("minecraft:air")?.0;
    // rust: let mut cache: HashMap<String, u32> = HashMap::new();
    // rust: let Some(Tag::List(sections)) = tag.get("sections") else {
    // rust: return Some(chunk);
}
    // rust: for section in sections {
    // rust: let Some(y) = number(section.get("Y")) else {
    // rust: continue;
}
    // rust: let Some(si) = layout.section_index(y as i32 * 16) else {
    // rust: continue;
}
    // rust: if let Some(states) = section.get("block_states")
    // rust: && let Some(Tag::List(palette)) = states.get("palette")
    // rust: {
    // rust: let palette: Vec<u32> = palette
    // rust: .iter()
    // rust: .map(|p| {
    // rust: let state = BlockState::from_nbt(p).ok();
    // rust: let key = state
    // rust: .as_ref()
    // rust: .map(|s| format!("{}{:?}", s.name, s.properties))
    // rust: .unwrap_or_default();
    // rust: *cache.entry(key).or_insert_with(|| {
    // rust: state
    // rust: .and_then(|s| {
    // rust: registry.id(&s).or_else(|| {
                                    // Missing properties take the block's defaults.
    // rust: let default = registry.default_state(&s.name)?;
    // rust: let mut full = registry.state(default)?.clone();
    // rust: for (k, v) in &s.properties {
    // rust: if full.properties.contains_key(k) {
    // rust: full.properties.insert(k.clone(), v.clone());
}
}
    // rust: registry.id(&full).or(Some(default))
    // rust: })
    // rust: })
    // rust: .map_or(air, |id| id.0)
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let target = Arc::make_mut(&mut chunk.sections[si]);
    // rust: let data = match states.get("data") {
    // rust: Some(Tag::LongArray(data)) => {
    // rust: Some(data.iter().map(|&w| w as u64).collect::<Vec<_>>())
}
    // rust: _ => None,
}
    // rust: if let Ok(blocks) =
    // rust: PalettedContainer::from_packed(block_strategy(), palette, data.as_deref())
    // rust: {
    // rust: target.blocks = blocks;
}
}
    // rust: if let Some(b) = section.get("biomes")
    // rust: && let Some(Tag::List(palette)) = b.get("palette")
    // rust: {
    // rust: let ids: Vec<u16> = palette
    // rust: .iter()
    // rust: .map(|p| match p {
    // rust: Tag::String(s) => biomes.id(&s.to_string_lossy()),
    // rust: _ => 0,
    // rust: })
    // rust: .collect();
    // rust: let data = match b.get("data") {
    // rust: Some(Tag::LongArray(data)) => {
    // rust: Some(data.iter().map(|&w| w as u64).collect::<Vec<_>>())
}
    // rust: _ => None,
}
    // rust: let palette: Vec<u32> = ids.iter().map(|&id| u32::from(id)).collect();
    // rust: let target = Arc::make_mut(&mut chunk.sections[si]);
    // rust: if let Ok(container) =
    // rust: PalettedContainer::from_packed(BIOME_STRATEGY, palette.clone(), data.as_deref())
    // rust: {
    // rust: target.biomes = container;
    // rust: } else if let Some(&first) = palette.first() {
    // rust: target.biomes = PalettedContainer::new(BIOME_STRATEGY, first);
}
}
}
    // rust: let mut extras = ChunkExtras {
    // rust: last_update: number(tag.get("LastUpdate")).unwrap_or(0),
    // rust: ..ChunkExtras::default()
}
    // rust: if let Some(Tag::List(entities)) = tag.get("block_entities") {
    // rust: for e in entities {
    // rust: let int = |k: &str| number(e.get(k)).map(|v| v as i32);
    // rust: if let (Some(x), Some(y), Some(z)) = (int("x"), int("y"), int("z")) {
    // rust: extras.block_entity_order.push((x, y, z));
}
    // rust: match decode_block_entity(e) {
    // rust: Some(mut be) => {
    // rust: if let Ok(Some(data)) = attachment_compound(e.get(ATTACHMENTS_KEY)) {
    // rust: extras.block_entity_attachments.push((
    // rust: be.0,
    // rust: horizon_world::attachments::Attachments::from_nbt(data.clone()),
    // rust: ));
}
    // rust: if let Some(name) = text(e.get("CustomName")) {
    // rust: chunk.block_names.push((be.0, name));
}
    // rust: if let Some(rolled) = roll_loaded_loot(&chunk, biomes, e, &mut be) {
    // rust: extras.rolled_loot.push(rolled);
}
    // rust: extras.block_entity_sources.push((be.0, e.clone()));
    // rust: chunk.block_entities.push(be);
}
    // rust: None => extras.block_entities.push(e.clone()),
}
}
}
    // rust: if let Tag::Compound(map) = tag {
    // rust: if let Ok(Some(data)) = attachment_compound(map.get(&ATTACHMENTS_KEY.into())) {
    // rust: extras.attachments = horizon_world::attachments::Attachments::from_nbt(data.clone());
}
    // rust: extras.root = map
    // rust: .iter()
    // rust: .filter(|(k, _)| !GENERATED_KEYS.contains(&k.to_string_lossy().as_str()))
    // rust: .map(|(k, v)| (k.clone(), v.clone()))
    // rust: .collect();
}
    // rust: if let Some(t) = tables {
    // rust: extras.block_ticks = read_ticks(tag.get("block_ticks"), (*x, *z), |n| {
    // rust: t.block_ids.get(n).map(|&i| u32::from(i))
    // rust: });
    // rust: extras.fluid_ticks = read_ticks(tag.get("fluid_ticks"), (*x, *z), fluid_id);
}
    // rust: chunk.saved = Some(Arc::new(extras));
    // rust: Some(chunk)
}

    // rust: pub fn encode_proto(
    // rust: proto: &SavedProto,
    // rust: registry: &BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: tables: Option<&SaveTables>,
    // rust: shape: LevelShape,
    // rust: ) -> NamedTag {
    // rust: let mut root = encode_with(&proto.column, registry, biomes, tables, shape);
    // rust: let status = if proto.decorated {
    // rust: ChunkStatus::Features
    // rust: } else {
    // rust: ChunkStatus::Terrain
}
    // ProtoChunk.postProcessing: one list per section, packed section offsets.
    // rust: let mut marks = vec![Vec::new(); shape.section_count()];
    // rust: for &[x, y, z] in &proto.column.postprocess {
    // rust: let section = usize::try_from((y - shape.min_y) >> 4).ok();
    // rust: if let Some(list) = section.and_then(|s| marks.get_mut(s)) {
    // rust: list.push(Tag::Short(
    // rust: ((x & 15) | (y & 15) << 4 | (z & 15) << 8) as i16,
    // rust: ));
}
}
    // rust: for (key, value) in [
    // rust: ("Status", string(status.name())),
    // rust: ("isLightOn", Tag::Byte(0)),
    // rust: ("block_entities", Tag::List(proto.block_entities.clone())),
    // rust: ("entities", Tag::List(proto.entities.clone())),
    // rust: (
    // rust: "PostProcessing",
    // rust: Tag::List(marks.into_iter().map(Tag::List).collect()),
    // rust: ),
    // rust: ] {
    // rust: put(&mut root.tag, key, value);
}
    // rust: root
}
/// A proto chunk generation can resume: `terrain` (written to by a
/// neighbour's decoration) up to `spawn`. Earlier statuses hold nothing that
/// generating the chunk again doesn't reproduce.
    // rust: pub fn decode_proto(
    // rust: root: &NamedTag,
    // rust: registry: &BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: tables: Option<&SaveTables>,
    // rust: layout: ColumnLayout,
    // rust: ) -> Option<SavedProto> {
    // rust: let status = ChunkStatus::parse(&text(root.tag.get("Status"))?).ok()?;
    // rust: if !(ChunkStatus::Terrain..ChunkStatus::Full).contains(&status) {
    // rust: return None;
}
    // rust: let mut column = decode_column(root, registry, biomes, tables, layout)?;
    // rust: column.block_entities.clear();
    // rust: let base = number(root.tag.get("yPos")).map_or(column.min_y(), |y| y as i32 * 16);
    // rust: if let Some(Tag::List(sections)) = root.tag.get("PostProcessing") {
    // rust: for (si, marks) in sections.iter().enumerate() {
    // rust: let Tag::List(marks) = marks else {
    // rust: continue;
}
    // rust: for mark in marks {
    // rust: if let Tag::Short(p) = mark {
    // rust: let p = i32::from(*p);
    // rust: column.postprocess.push([
    // rust: column.x * 16 + (p & 15),
    // rust: base + si as i32 * 16 + ((p >> 4) & 15),
    // rust: column.z * 16 + ((p >> 8) & 15),
    // rust: ]);
}
}
}
}
    // rust: let list = |key: &str| match root.tag.get(key) {
    // rust: Some(Tag::List(list)) => list.clone(),
    // rust: _ => Vec::new(),
}
    // rust: Some(SavedProto {
    // rust: column,
    // rust: decorated: status >= ChunkStatus::Features,
    // rust: block_entities: list("block_entities"),
    // rust: entities: list("entities"),
    // rust: })
}

/// Read the stored `SkyLight`/`BlockLight` layers of a chunk saved with
/// `isLightOn` (`SerializableChunkData.read` + `ThreadedLevelLightEngine`),
/// so it needs no relighting. A missing sky layer repeats the bottom layer of
/// the section above it (15 above the highest stored one); a missing block
/// layer is dark.
pub fn load_light(tag: *Tag, chunk: *mut Chunk, sky_light: bool) void {
}
    // rust: if tag.get("isLightOn") != Some(&Tag::Byte(1)) {
    // rust: return;
}
    // rust: let Some(Tag::List(sections)) = tag.get("sections") else {
    // rust: return;
}
    // rust: let mut layers: Vec<(Option<&[u8]>, Option<&[u8]>)> = vec![(None, None); chunk.sections.len()];
    // rust: for section in sections {
    // rust: let Some(y) = number(section.get("Y")) else {
    // rust: continue;
}
    // rust: let Some(si) = chunk.section_index(y as i32 * 16) else {
    // rust: continue;
}
    // rust: let layer = |name: &str| match section.get(name) {
    // rust: Some(Tag::ByteArray(a)) if a.len() == 2048 => Some(&a[..]),
    // rust: _ => None,
}
    // rust: layers[si] = (layer("SkyLight"), layer("BlockLight"));
}
    // Uniform saved layers need no expanded allocation. Both nibbles of
    // each byte must match, not merely the bytes across the layer.
    // rust: let uniform_layer = |layer: &[u8]| {
    // rust: let first = layer[0];
    // rust: (first & 15 == first >> 4 && layer.iter().all(|&v| v == first)).then_some(first & 15)
}
    // rust: let mut above = [if sky_light { 15 } else { 0 }; 256];
    // rust: for (si, (sky, block)) in layers.into_iter().enumerate().rev() {
    // rust: let sky = sky.filter(|_| sky_light);
    // rust: let sky_uniform = sky.map_or_else(
    // rust: || above.iter().all(|&v| v == above[0]).then_some(above[0]),
    // rust: uniform_layer,
    // rust: );
    // rust: let block_uniform = block.map_or(Some(0), uniform_layer);
    // rust: let section = Arc::make_mut(&mut chunk.sections[si]);
    // rust: if let (Some(s), Some(b)) = (sky_uniform, block_uniform) {
    // rust: section.light = Light::Uniform(s << 4 | b);
    // rust: above.fill(s);
    // rust: } else {
    // rust: let mut data = Box::new([0u8; 4096]);
    // rust: match (sky, block) {
    // rust: (Some(sky), Some(block)) => {
    // rust: for ((pair, &s), &b) in
    // rust: data.as_chunks_mut::<2>().0.iter_mut().zip(sky).zip(block)
    // rust: {
    // rust: pair[0] = s << 4 | (b & 15);
    // rust: pair[1] = (s & 0xf0) | (b >> 4);
}
}
    // rust: (Some(sky), None) => {
    // rust: for (pair, &s) in data.as_chunks_mut::<2>().0.iter_mut().zip(sky) {
    // rust: pair[0] = s << 4;
    // rust: pair[1] = s & 0xf0;
}
}
    // rust: (None, Some(block)) => {
    // rust: for (i, (pair, &b)) in data
    // rust: .as_chunks_mut::<2>()
    // rust: .0
    // rust: .iter_mut()
    // rust: .zip(block)
    // rust: .enumerate()
    // rust: {
    // rust: pair[0] = above[(i * 2) & 255] << 4 | (b & 15);
    // rust: pair[1] = above[(i * 2 + 1) & 255] << 4 | (b >> 4);
}
}
    // rust: (None, None) => {
    // rust: for layer in data.as_chunks_mut::<256>().0 {
    // rust: for (v, &s) in layer.iter_mut().zip(&above) {
    // rust: *v = s << 4;
}
}
}
}
    // rust: if let Some(sky) = sky {
    // rust: for (pair, &s) in above.as_chunks_mut::<2>().0.iter_mut().zip(sky) {
    // rust: pair[0] = s & 15;
    // rust: pair[1] = s >> 4;
}
}
    // rust: section.light = Light::Full(data);
}
    // rust: section.compact();
}
    // rust: chunk.lit = true;
    // rust: chunk.light_loaded = true;
}

    // rust: type RegionCache = Mutex<RegionFiles>;
/// `RegionFileStorage.MAX_CACHE_SIZE`: the region files of a folder kept
/// open. Each holds a file descriptor: kept for every region ever visited,
/// a server whose players travel runs out of them (`Too many open files`).
pub const MAX_OPEN_REGIONS: usize = 256;
/// A folder's region files, and the ones known to be missing, by region,
/// with when each was last asked for.
pub const RegionFiles = struct {
    regions: HashMap<(i32,
    clock: u64,
};
    // rust: impl RegionFiles {
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.regions.is_empty()
}
    /// The open region files.
pub fn open(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.regions.values().filter(|(r, _)| r.is_some()).count()
}
    /// Close the least recently used regions until there is room for one
    /// more, as `RegionFileStorage.getRegionFile` does. A region a reader or
    /// the writer still holds stays: closing it under them would let a
    /// second handle read a header older than its sectors.
pub fn make_room(self: *Self) void {
}
    // rust: while self.regions.len() >= MAX_OPEN_REGIONS {
    // rust: let oldest = self
    // rust: .regions
    // rust: .iter()
    // rust: .filter(|(_, (r, _))| r.as_ref().is_none_or(|r| Arc::strong_count(r) == 1))
    // rust: .min_by_key(|(_, (_, used))| *used)
    // rust: .map(|(key, _)| *key);
    // rust: let Some(key) = oldest else {
    // rust: return;
}
    // rust: self.regions.remove(&key);
}
}
}
/// The region file at `path` through the cache, which readers and the writer
/// share, so a read never sees a header older than the sectors it points to.
/// `create` makes a missing file (for a write); otherwise a missing file is
/// `None`, until a write creates it.
    // rust: fn cached_region(
    // rust: cache: &RegionCache,
    // rust: key: (i32, i32),
    // rust: path: &Path,
    // rust: create: bool,
    // rust: ) -> Result<Option<Arc<Mutex<RegionFile>>>> {
    // rust: let mut cache = cache.lock().map_err(|_| "region cache poisoned")?;
    // rust: cache.clock += 1;
    // rust: let now = cache.clock;
    // rust: if let Some((cached, used)) = cache.regions.get_mut(&key)
    // rust: && (cached.is_some() || !create)
    // rust: {
    // rust: *used = now;
    // rust: return Ok(cached.clone());
}
    // rust: cache.make_room();
    // rust: if create && let Some(parent) = path.parent() {
    // rust: fs::create_dir_all(parent)?;
}
    // A file this process can't write (a read-only world) is still read.
    // rust: let region = match RegionFile::open_writable(path, create) {
    // rust: Err(e) if !create && e.kind() == std::io::ErrorKind::PermissionDenied => {
    // rust: RegionFile::open(path)
}
    // rust: other => other,
}
    // rust: let region = match region {
    // rust: Ok(r) => Some(Arc::new(Mutex::new(r))),
    // rust: Err(_) if !create => None,
    // rust: Err(e) => return Err(e.into()),
}
    // rust: cache.regions.insert(key, (region.clone(), now));
    // rust: Ok(region)
}
/// Write `records` into the region files of `folder` in place, as vanilla's
/// `RegionFile.write` does: each chunk takes free sectors and the header
/// then points to it; the region's other chunks are not touched. `None`
/// clears a chunk. The chunks are encoded and compressed before their region
/// is locked for the writes (`compress_records`), and each region is flushed
/// to the disk once.
    // rust: fn write_region_records(
    // rust: root: &Path,
    // rust: cache: &RegionCache,
    // rust: folder: &str,
    // rust: records: &[((i32, i32), &Record)],
    // rust: ) -> Result<()> {
    // rust: let timestamp = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs() as u32);
    // rust: let compressed = compress_records(records, timestamp);
    // rust: let mut by_region: BTreeMap<(i32, i32), Vec<(ChunkPos, Option<ChunkRecord>)>> = BTreeMap::new();
    // rust: for (&((x, z), _), record) in records.iter().zip(compressed) {
    // rust: let record = record?;
    // rust: by_region
    // rust: .entry((x >> 5, z >> 5))
    // rust: .or_default()
    // rust: .push((ChunkPos::new(x, z), record));
}
    // rust: for ((rx, rz), list) in by_region {
    // rust: let path = region_path(root, folder, rx, rz);
        // Clearing chunks of a region that doesn't exist changes nothing.
    // rust: let create = list.iter().any(|(_, r)| r.is_some());
    // rust: let Some(region) = cached_region(cache, (rx, rz), &path, create)? else {
    // rust: continue;
}
    // rust: let mut region = region.lock().map_err(|_| "region file poisoned")?;
    // rust: let mut changed = false;
    // rust: for (pos, record) in &list {
    // rust: match record {
    // rust: Some(record) => {
    // rust: region.write(*pos, record)?;
    // rust: changed = true;
}
    // rust: None => changed |= region.clear(*pos, timestamp)?,
}
}
    // rust: if changed {
    // rust: region.sync()?;
}
}
    // rust: Ok(())
}

/// Fewest chunks each helper of `compress_records` takes: below this a thread
/// costs more to start than it saves.
pub const CHUNKS_PER_HELPER: usize = 4;
/// Each record encoded and compressed (`None` for a deletion), in the order
/// given. Vanilla's IOWorker does this one chunk after another; here a batch
/// is shared out to scoped threads, which take the next chunk as they finish
/// one. Each chunk's bytes depend only on the chunk, and the writes stay in
/// order, so the files are the same as from one thread. At most half the
/// hardware threads help, leaving the rest to the game and its workers.
    // rust: fn compress_records(
    // rust: records: &[((i32, i32), &Record)],
    // rust: timestamp: u32,
    // rust: ) -> Vec<std::io::Result<Option<ChunkRecord>>> {
    // rust: let compress = |record: &Record| {
    // rust: record
    // rust: .tag()
    // rust: .map(|tag| ChunkRecord::from_nbt(&tag, Compression::Zlib, timestamp, Limits::saved()))
    // rust: .transpose()
}
    // rust: let helpers = horizon_threads::worker_count()
    // rust: .div_ceil(2)
    // rust: .min(records.len() / CHUNKS_PER_HELPER);
    // rust: if helpers <= 1 {
    // rust: return records.iter().map(|(_, r)| compress(r)).collect();
}
    // rust: share_out(records.len(), helpers, |i| compress(records[i].1), || true)
}

/// `job(i)` for every `i` below `count`, in order, shared between this thread
/// and up to `helpers - 1` scoped threads, each taking the next index as it
/// finishes one. A helper the system refuses to start (`start` false, or a
/// container at its limit of threads: EAGAIN) leaves its share to the
/// others: this thread does all of it at worst, and never panics for it, as
/// `thread::scope`'s own `spawn` would, which stopped the region writer.
    // rust: fn share_out<R: Send>(
    // rust: count: usize,
    // rust: helpers: usize,
    // rust: job: impl Fn(usize) -> R + Sync,
    // rust: mut start: impl FnMut() -> bool,
    // rust: ) -> Vec<R> {
    // rust: let next = std::sync::atomic::AtomicUsize::new(0);
    // rust: let work = || {
    // rust: let mut out = Vec::new();
    // rust: loop {
    // rust: let i = next.fetch_add(1, Ordering::Relaxed);
    // rust: if i >= count {
    // rust: return out;
}
    // rust: out.push((i, job(i)));
}
}
    // rust: let mut done: Vec<(usize, R)> = std::thread::scope(|scope| {
    // rust: let threads: Vec<_> = (1..helpers)
    // rust: .filter(|_| start())
    // rust: .filter_map(|_| std::thread::Builder::new().spawn_scoped(scope, work).ok())
    // rust: .collect();
    // rust: let mut done = work();
    // rust: for t in threads {
    // rust: done.extend(t.join().unwrap_or_else(|e| std::panic::resume_unwind(e)));
}
    // rust: done
    // rust: });
    // rust: done.sort_unstable_by_key(|(i, _)| *i);
    // rust: done.into_iter().map(|(_, r)| r).collect()
}

pub fn region_path(root: *Path, folder: []const u8, rx: i32, rz: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: root.join(format!("{folder}/r.{rx}.{rz}.mca"))
}

/// A record waiting for the writer thread.
pub const Record = enum {
    Tag(Arc<NamedTag>),
    /// A chunk to encode on the writer thread.
    Chunk(Arc<Chunk>, Arc<Encoding>),
    /// A chunk's points of interest, made on the writer thread against the
    /// saved ones (`resolve_poi`).
    Poi(Arc<Chunk>, Arc<SaveTables>),
    Delete,
};
/// What encoding a chunk needs, captured when it is queued.
pub const Encoding = struct {
    registry: *'static BlockRegistry,
    biomes: *Biomes,
    tables: ?*SaveTables,
    shape: LevelShape,
};
    // rust: impl Record {
pub fn tag(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Record::Tag(t) => Some(t.clone()),
    // rust: Record::Chunk(c, e) => Some(Arc::new(encode_with(
    // rust: c,
    // rust: e.registry,
    // rust: &e.biomes,
    // rust: e.tables.as_deref(),
    // rust: e.shape,
    // rust: ))),
    // rust: Record::Poi(c, t) => encode_poi(c, t).map(Arc::new),
    // rust: Record::Delete => None,
}
}
}
/// A queued POI record as it is written: claims kept from the saved one, and
/// a chunk that lost its last POI gets an empty one, as vanilla trusts a
/// saved section. None when the chunk never had any.
    // rust: fn resolve_poi(
    // rust: root: &Path,
    // rust: cache: &RegionCache,
    // rust: (x, z): (i32, i32),
    // rust: record: &Record,
    // rust: ) -> Option<Record> {
    // rust: let Record::Poi(chunk, tables) = record else {
    // rust: return Some(record.clone());
}
    // rust: let old = read_region_record(root, cache, "poi", x, z)
    // rust: .and_then(|old| {
    // rust: old.map(|mut old| {
    // rust: upgrade_record(Folder::Poi, &mut old, || None)?;
    // rust: Ok(old)
    // rust: })
    // rust: .transpose()
    // rust: })
    // rust: .unwrap_or_else(|e| {
    // rust: log::warn!("Horizon: could not read the poi record of chunk {x} {z}: {e}");
    // rust: None
    // rust: });
    // rust: let tag = match (encode_poi(chunk, tables), old) {
    // rust: (Some(mut tag), Some(old)) => {
    // rust: keep_claims(&mut tag, &old);
    // rust: tag
}
    // rust: (Some(tag), None) => tag,
    // rust: (None, Some(_)) => poi_root(Compound::new()),
    // rust: (None, None) => return None,
}
    // rust: Some(Record::Tag(Arc::new(tag)))
}
    // rust: fn read_region_record(
    // rust: root: &Path,
    // rust: cache: &RegionCache,
    // rust: folder: &str,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> Result<Option<NamedTag>> {
    // rust: let key = (x >> 5, z >> 5);
    // rust: let path = region_path(root, folder, key.0, key.1);
    // rust: let Some(region) = cached_region(cache, key, &path, false)? else {
    // rust: return Ok(None);
}
    // rust: let record = region
    // rust: .lock()
    // rust: .map_err(|_| "region file poisoned")?
    // rust: .read(ChunkPos::new(x, z))?;
    // rust: Ok(match record {
    // rust: Some(r) => Some(r.nbt(Limits::saved())?),
    // rust: None => None,
    // rust: })
}
/// The `__context` the chunk fixes read: the dimension and its generator type
/// (`ChunkMap.getChunkDataFixContextTag`).
pub const DatafixContext = struct {
    dimension: []const u8,
    generator: ?[]const u8,
};
    // rust: impl DatafixContext {
    /// From a dimension folder made by [`dimension_dir`] and the world's
    /// `world_gen_settings.dat`; None for a folder outside a world's `dimensions/`.
pub fn of(root: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut parts = Vec::new();
    // rust: let mut at = root;
    // rust: while at.file_name()? != "dimensions" {
    // rust: parts.push(at.file_name()?.to_str()?);
    // rust: at = at.parent()?;
}
    // rust: let world = at.parent()?;
    // rust: let namespace = parts.pop()?;
    // rust: if parts.is_empty() {
    // rust: return None;
}
    // rust: parts.reverse();
    // rust: let dimension = format!("{namespace}:{}", parts.join("/"));
    // rust: let generator = horizon_world::datafix::files::generators(world)
    // rust: .ok()
    // rust: .and_then(|g| g.into_iter().find(|(d, _)| *d == dimension))
    // rust: .map(|(_, g)| g);
    // rust: Some(Self {
    // rust: dimension,
    // rust: generator,
    // rust: })
}
}
/// `SimpleRegionStorage.upgradeChunkTag`, as `ChunkMap.upgradeChunkTag` (chunks),
/// `EntityStorage` and `SectionStorage.PackedChunk.parse` (POI) call it on every
/// record they read: a world 26.3 has opened keeps the chunks nobody loaded since
/// an older version in that version's format, and `upgrade_older_world` only runs
/// for an older level.dat. A record without a DataVersion counts as -1 (POI: 1945).
/// `context` is needed only for an older chunk; without one it stays as saved.
    // rust: fn upgrade_record<'a>(
    // rust: folder: Folder,
    // rust: record: &mut NamedTag,
    // rust: context: impl FnOnce() -> Option<&'a DatafixContext>,
    // rust: ) -> Result<()> {
//     use horizon_world::datafix::{self, schema::Ty};
    // rust: let default = if folder == Folder::Poi { 1945 } else { -1 };
    // rust: if number(record.tag.get("DataVersion")).unwrap_or(default) >= i64::from(DATA_VERSION) {
    // rust: return Ok(());
}
    // rust: let context = match folder {
    // rust: Folder::Region => match context() {
    // rust: Some(c) => Some(c),
    // rust: None => return Ok(()),
    // rust: },
    // rust: _ => None,
}
    // rust: let tag = &mut record.tag;
    // rust: std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| match (folder, context) {
    // rust: (Folder::Region, Some(c)) => {
    // rust: datafix::update_chunk(tag, &c.dimension, c.generator.as_deref());
}
    // rust: (Folder::Entities, _) => datafix::update_region_tag(Ty::EntityChunk, tag),
    // rust: (Folder::Poi, _) => datafix::update_region_tag(Ty::PoiChunk, tag),
    // rust: (Folder::Region, None) => {}
    // rust: }))
    // rust: .map_err(|_| "upgrading an older record failed".into())
}
/// Chunk and entity records waiting for the writer thread, by (entities?,
/// x, z): reads see them before the region files do.
    // rust: type PendingWrites = Mutex<HashMap<(Folder, i32, i32), (u64, Record)>>;
    // rust: type WriteBatch = (Folder, Vec<((i32, i32), Record, u64)>);
/// The region folders of a dimension.
pub const Folder = enum {
    Region,
    Entities,
    Poi,
};
    // rust: impl Folder {
pub fn of(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "entities" => Self::Entities,
    // rust: "poi" => Self::Poi,
    // rust: _ => Self::Region,
}
}
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Region => "region",
    // rust: Self::Entities => "entities",
    // rust: Self::Poi => "poi",
}
}
}

/// The background thread that encodes chunks and writes them into the region files, in
/// submission order.
pub const Writer = struct {
    send: mpsc::Sender<WriteBatch>,
    thread: std::thread::JoinHandle<()>,
};

/// Writes still queued or running, with a condition to wait for none.
pub const Outstanding = struct {
    count: Mutex<usize>,
    error: Mutex<?[]const u8>,
    done: Condvar,
};
/// One dimension folder (`dimensions/minecraft/<name>`). Region files are
/// read lazily by worker threads.
pub const SaveDir = struct {
    root: PathBuf,
    regions: *RegionCache,
    entity_regions: *RegionCache,
    poi_regions: *RegionCache,
    pending: *PendingWrites,
    sequence: AtomicU64,
    writer: Mutex<?Writer>,
    outstanding: *Outstanding,
    /// Set by `Persistent` before the first load.
    tables: OnceLock<*SaveTables>,
    /// The dimension's skylight and height, from its folder name.
    shape: LevelShape,
    /// Which chunks each region file holds, for far terrain (`lod_saved`).
    lod_regions: Mutex<crate::fast_hash::FxHashMap<(i32,
    /// Saved chunks decoded for far terrain, shared by its sampling threads
    /// (`lod_surfaces_shared`), oldest first.
    lod_decoded: Mutex<LodDecoded>,
    /// What older chunks are upgraded with, found on the first one read.
    datafix_context: OnceLock<?DatafixContext>,
};
pub fn is_forced_ticket(ticket: *Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(ticket.get("type"), Some(Tag::String(t)) if *t == JavaString::from("minecraft:forced"))
}
pub const LodDecoded = struct {
    chunks: crate::fast_hash::FxHashMap<(i32,
    order: std::collections::VecDeque<(i32,
};
/// Saved chunks kept decoded for far terrain (each tens of kilobytes), and
/// for how long: edits saved later show after it.
pub const LOD_DECODED: usize = 1024;
pub const LOD_DECODED_TTL: std::time::Duration = std::time::Duration::from_secs(30);
/// A region file's saved chunks (bit `x + z * 32`), `None` without the file,
/// as of `checked`.
pub const LodRegion = struct {
    checked: std::time::Instant,
    chunks: Option<[u64,
};
/// How long far terrain trusts a region file's chunk list: chunks saved after
/// it was read show in the far view this long after.
pub const LOD_REGION_TTL: std::time::Duration = std::time::Duration::from_secs(10);
    // rust: impl SaveDir {
    /// This dimension's server-owned mod attachments: `data/horizon/attachments.dat`, Horizon's
    /// own namespace. A file that doesn't read is moved aside to `attachments.dat.corrupt`, with
    /// a warning, and the level opens without them (as vanilla's `SavedDataStorage` starts a
    /// saved data over when its file is broken), so the next save can't overwrite it.
pub fn load_attachments(self: *Self) h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = self.attachments_path();
    // rust: let data = match try_read_dat(&path) {
    // rust: Err(DatIssue::Missing) => return Default::default(),
    // rust: Ok(root) => match root.get("data") {
    // rust: Some(Tag::Compound(data)) => Ok(data.clone()),
    // rust: _ => Err("no data compound".to_owned()),
    // rust: },
    // rust: Err(DatIssue::Unreadable(why)) => Err(why),
}
    // rust: data.map(horizon_world::attachments::Attachments::from_nbt)
    // rust: .unwrap_or_else(|why| {
    // rust: let aside = path.with_extension("dat.corrupt");
    // rust: log::warn!(
    // rust: "{}: {why}; mod attachments start over, the file is kept as {}",
    // rust: path.display(),
    // rust: aside.display()
    // rust: );
    // rust: let _ = fs::rename(&path, &aside);
    // rust: Default::default()
    // rust: })
}

    /// Save this dimension's server-owned mod attachments; nothing while it has none and never had.
    // rust: pub fn save_attachments(
    // rust: &self,
    // rust: attachments: &horizon_world::attachments::Attachments,
    // rust: ) -> Result<()> {
    // rust: let path = self.attachments_path();
    // rust: let data = attachments.to_nbt();
    // rust: if data.is_empty() && !path.exists() {
    // rust: return Ok(());
}
    // rust: write_dat(
    // rust: &path,
    // rust: Tag::compound([
    // rust: ("data", Tag::Compound(data)),
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: ]),
    // rust: )
}

pub fn attachments_path(self: *Self) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.root
    // rust: .join("data")
    // rust: .join("horizon")
    // rust: .join("attachments.dat")
}

    /// The saves of a level of `shape` at `root` (its dimension folder).
pub fn new(root: PathBuf, shape: LevelShape) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: root,
    // rust: regions: Default::default(),
    // rust: entity_regions: Default::default(),
    // rust: poi_regions: Default::default(),
    // rust: pending: Default::default(),
    // rust: sequence: AtomicU64::new(0),
    // rust: writer: Mutex::new(None),
    // rust: outstanding: Default::default(),
    // rust: tables: OnceLock::new(),
    // rust: shape,
    // rust: lod_regions: Default::default(),
    // rust: lod_decoded: Default::default(),
    // rust: datafix_context: OnceLock::new(),
}
}
    /// 26.3's TicketStorage: persistent tickets live in each dimension's
    /// data/minecraft/chunk_tickets.dat, with ChunkPos.CODEC's [x, z] int array.
pub fn load_forced_chunks(self: *Self) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(data) = read_saved_data(&self.root, "chunk_tickets") else {
    // rust: return HashSet::new();
}
    // rust: let Some(Tag::List(tickets)) = data.get("tickets") else {
    // rust: return HashSet::new();
}
    // rust: tickets
    // rust: .iter()
    // rust: .filter(|t| is_forced_ticket(t))
    // rust: .filter_map(|t| match t.get("chunk_pos")? {
    // rust: Tag::IntArray(pos) if pos.len() == 2 => Some((pos[0], pos[1])),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}
pub fn save_forced_chunks(self: *Self, forced: *HashSet<(i32) void {
}
    // rust: if forced.is_empty() && !saved_data_path(&self.root, "chunk_tickets").exists() {
    // rust: return Ok(());
}
    // rust: let mut data = compound_or_empty(read_saved_data(&self.root, "chunk_tickets"));
        // Preserve persistent tickets Horizon does not simulate.
    // rust: let mut tickets = match data.get("tickets") {
    // rust: Some(Tag::List(tickets)) => tickets
    // rust: .iter()
    // rust: .filter(|t| !is_forced_ticket(t))
    // rust: .cloned()
    // rust: .collect::<Vec<_>>(),
    // rust: _ => Vec::new(),
}
    // rust: let mut chunks: Vec<_> = forced.iter().copied().collect();
    // rust: chunks.sort_unstable();
    // rust: tickets.extend(chunks.into_iter().map(|(x, z)| {
    // rust: Tag::compound([
    // rust: ("type", Tag::String("minecraft:forced".into())),
    // rust: ("level", Tag::Int(31)), // ChunkMap.FORCED_TICKET_LEVEL: ENTITY_TICKING.
    // rust: ("chunk_pos", Tag::IntArray(vec![x, z])),
    // rust: ])
    // rust: }));
    // rust: put(&mut data, "tickets", Tag::List(tickets));
    // rust: write_saved_data(&self.root, "chunk_tickets", data)
}
    /// Whether chunk `x z` is in its region file, from a chunk list kept
    /// `LOD_REGION_TTL`. Far terrain asks for every column of the view: it
    /// opened the region file each time, also where there is none, which
    /// held the far view back for minutes.
pub fn lod_saved(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = (x >> 5, z >> 5);
    // rust: let mut regions = self.lod_regions.lock().unwrap();
    // rust: let fresh = regions
    // rust: .get(&key)
    // rust: .is_some_and(|region| region.checked.elapsed() < LOD_REGION_TTL);
    // rust: if !fresh {
    // rust: let chunks = RegionFile::open(self.region_path("region", key.0, key.1))
    // rust: .ok()
    // rust: .map(|region| {
    // rust: let mut bits = [0u64; 16];
    // rust: for (pos, _) in region.chunks() {
    // rust: let index = ((pos.x & 31) + (pos.z & 31) * 32) as usize;
    // rust: bits[index / 64] |= 1 << (index % 64);
}
    // rust: bits
    // rust: });
    // rust: regions.insert(
    // rust: key,
    // rust: LodRegion {
    // rust: checked: std::time::Instant::now(),
    // rust: chunks,
    // rust: },
    // rust: );
}
    // rust: let index = ((x & 31) + (z & 31) * 32) as usize;
    // rust: regions[&key]
    // rust: .chunks
    // rust: .is_some_and(|bits| bits[index / 64] & (1 << (index % 64)) != 0)
}
pub fn region_path(self: *Self, folder: []const u8, rx: i32, rz: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: region_path(&self.root, folder, rx, rz)
}
    /// The chunks of a region file that an older version generated, as
    /// `IOWorker.createOldDataForRegion` finds them (bit `x + z * 32`): saved
    /// before DataVersion 4997, or with `blending_data`.
pub fn old_chunk_bits(self: *Self, rx: i32, rz: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut bits = [0u64; 16];
    // rust: let Ok(region) = RegionFile::open(self.region_path("region", rx, rz)) else {
    // rust: return bits;
}
    // rust: let present: Vec<ChunkPos> = region.chunks().map(|(pos, _)| pos).collect();
    // rust: drop(region);
    // rust: for pos in present {
            // `IOWorker` reads the record as saved, before any upgrade.
    // rust: let Some(root) = self.read_record_raw("region", pos.x, pos.z) else {
    // rust: continue;
}
    // rust: if record_is_old(&root) {
    // rust: let index = ((pos.x & 31) + (pos.z & 31) * 32) as usize;
    // rust: bits[index / 64] |= 1 << (index % 64);
}
}
    // rust: bits
}
    /// Whether the saved chunk at `x, z` is old ([`Self::old_chunk_bits`]'s test), from its
    /// record alone: false for a chunk not saved.
pub fn is_old_chunk(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.read_record_raw("region", x, z)
    // rust: .is_some_and(|root| record_is_old(&root))
}
    /// A saved chunk brought to the current version, for the readers of its
    /// fields that `load` does not decode (`blending_data`).
pub fn raw_chunk(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.read_record("region", x, z)
}
    /// The references a saved chunk keeps for its structure start `name`
    /// (`StructureStart.getReferences`, saved as `references`): 0 for a chunk
    /// not saved yet, a start it does not have or one without the field.
pub fn start_references(self: *Self, x: i32, z: i32, name: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(root) = self.read_record("region", x, z) else {
    // rust: return 0;
}
    // rust: match root
    // rust: .tag
    // rust: .get("structures")
    // rust: .and_then(|s| s.get("starts"))
    // rust: .and_then(|s| s.get(name))
    // rust: .and_then(|s| s.get("references"))
    // rust: {
    // rust: Some(Tag::Int(n)) => *n,
    // rust: _ => 0,
}
}
    /// A record as saved: the pending write first, then the region file.
pub fn read_record_raw(self: *Self, folder: []const u8, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pending = self
    // rust: .pending
    // rust: .lock()
    // rust: .ok()?
    // rust: .get(&(Folder::of(folder), x, z))
    // rust: .map(|(_, r)| r.clone());
    // rust: if let Some(record) = pending {
    // rust: return record.tag().map(|t| (*t).clone());
}
    // rust: let cache = match Folder::of(folder) {
    // rust: Folder::Region => &self.regions,
    // rust: Folder::Entities => &self.entity_regions,
    // rust: Folder::Poi => &self.poi_regions,
}
    // rust: match read_region_record(&self.root, cache, folder, x, z) {
    // rust: Ok(record) => record,
    // rust: Err(e) => {
    // rust: crate::chunk_io::report_load_failure(&self.root, x, z, &e);
    // rust: None
}
}
}
    /// A record brought to the current version (`upgrade_record`).
pub fn read_record(self: *Self, folder: []const u8, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut record = self.read_record_raw(folder, x, z)?;
    // rust: match self.upgrade_record(Folder::of(folder), &mut record) {
    // rust: Ok(()) => Some(record),
    // rust: Err(e) => {
    // rust: crate::chunk_io::report_load_failure(&self.root, x, z, &e);
    // rust: None
}
}
}
pub fn upgrade_record(self: *Self, folder: Folder, record: *mut NamedTag) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: upgrade_record(folder, record, || {
    // rust: self.datafix_context
    // rust: .get_or_init(|| DatafixContext::of(&self.root))
    // rust: .as_ref()
    // rust: })
}
pub fn load(self: *Self, x: i32, z: i32, registry: *BlockRegistry, biomes: *Biomes) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = self.read_record("region", x, z)?;
    // rust: let tables = self.tables.get().map(|t| &**t);
    // rust: let mut chunk = decode_with(&root, registry, biomes, tables, self.shape.column())?;
    // rust: load_light(&root.tag, &mut chunk, self.shape.sky_light);
    // rust: Some(chunk)
}
    /// A saved full chunk read for a player's far ring (`lan::far`), as `load` but past the gameplay
    /// region cache, and only where the region file lists it (no file opened where there is none).
    // rust: pub fn load_far(
    // rust: &self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: registry: &BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: ) -> Option<Chunk> {
    // rust: let pending = self
    // rust: .pending
    // rust: .lock()
    // rust: .ok()?
    // rust: .get(&(Folder::Region, x, z))
    // rust: .map(|(_, record)| record.clone());
    // rust: let root = if let Some(record) = pending {
    // rust: record.tag().map(|tag| (*tag).clone())?
    // rust: } else {
    // rust: if !self.lod_saved(x, z) {
    // rust: return None;
}
    // rust: let mut region = RegionFile::open(self.region_path("region", x >> 5, z >> 5)).ok()?;
    // rust: let mut root = region
    // rust: .read(ChunkPos::new(x, z))
    // rust: .ok()??
    // rust: .nbt(Limits::default())
    // rust: .ok()?;
    // rust: self.upgrade_record(Folder::Region, &mut root).ok()?;
    // rust: root
}
    // rust: let tables = self.tables.get().map(|t| &**t);
    // rust: let mut chunk = decode_with(&root, registry, biomes, tables, self.shape.column())?;
    // rust: load_light(&root.tag, &mut chunk, self.shape.sky_light);
        // Without its saved light (`isLightOn`) it would need the light engine: not one for the far ring.
    // rust: chunk.light_loaded.then_some(chunk)
}
    /// Chunks queued for the writer thread and not yet in their region files.
pub fn pending_writes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pending.lock().map_or(0, |p| p.len())
}
    /// A proto chunk saved before it became final (`decode_proto`).
    // rust: pub fn load_proto(
    // rust: &self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: registry: &BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: ) -> Option<SavedProto> {
    // rust: let root = self.read_record("region", x, z)?;
    // rust: let tables = self.tables.get().map(|t| &**t);
    // rust: decode_proto(&root, registry, biomes, tables, self.shape.column())
}
    /// Queue proto chunks for the writer thread; loads see them meanwhile.
    // rust: pub fn save_protos(
    // rust: &self,
    // rust: protos: &[SavedProto],
    // rust: registry: &BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: ) -> Result<()> {
    // rust: let tables = self.tables.get().map(|t| &**t);
    // rust: let records = protos
    // rust: .iter()
    // rust: .map(|p| {
    // rust: let tag = encode_proto(p, registry, biomes, tables, self.shape);
    // rust: ((p.column.x, p.column.z), Some(tag))
    // rust: })
    // rust: .collect();
    // rust: self.write_records("region", records, false)
}
    /// Entities saved for a chunk (`entities/`; older chunks may still keep
    /// them in the chunk's own `entities` list).
pub fn load_entities(self: *Self, x: i32, z: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: if let Some(root) = self.read_record("entities", x, z)
    // rust: && let Some(Tag::List(list)) = root.tag.get("Entities")
    // rust: {
    // rust: out.extend(list.iter().cloned());
}
    // rust: out
}
    /// Queue `records` for the writer thread; with `wait`, return once
    /// they and every earlier write are on disk.
    // rust: fn write_records(
    // rust: &self,
    // rust: folder: &str,
    // rust: records: Vec<((i32, i32), Option<NamedTag>)>,
    // rust: wait: bool,
    // rust: ) -> Result<()> {
    // rust: let records = records
    // rust: .into_iter()
    // rust: .map(|(k, t)| (k, t.map_or(Record::Delete, |t| Record::Tag(Arc::new(t)))))
    // rust: .collect();
    // rust: self.queue(Folder::of(folder), records, wait)
}
pub fn queue(self: *Self, folder: Folder, records: Vec<((i32) void {
}
    // rust: if !records.is_empty() {
    // rust: let mut batch = Vec::with_capacity(records.len());
    // rust: {
    // rust: let mut pending = self.pending.lock().map_err(|_| "pending writes poisoned")?;
    // rust: for (key, record) in records {
    // rust: let seq = self.sequence.fetch_add(1, Ordering::Relaxed);
    // rust: pending.insert((folder, key.0, key.1), (seq, record.clone()));
    // rust: batch.push((key, record, seq));
}
}
    // rust: *self
    // rust: .outstanding
    // rust: .count
    // rust: .lock()
    // rust: .map_err(|_| "writer poisoned")? += 1;
    // rust: let mut writer = self.writer.lock().map_err(|_| "writer poisoned")?;
    // rust: let writer = writer.get_or_insert_with(|| self.start_writer());
    // rust: if writer.send.send((folder, batch)).is_err() {
    // rust: *self
    // rust: .outstanding
    // rust: .error
    // rust: .lock()
    // rust: .map_err(|_| "writer poisoned")? = Some("the region writer stopped".into());
    // rust: *self
    // rust: .outstanding
    // rust: .count
    // rust: .lock()
    // rust: .map_err(|_| "writer poisoned")? -= 1;
    // rust: self.outstanding.done.notify_all();
    // rust: return Err("the region writer stopped".into());
}
}
    // rust: if wait {
    // rust: self.flush()?;
}
    // rust: Ok(())
}
pub fn start_writer(self: *Self) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (send, receive) = mpsc::channel::<WriteBatch>();
    // rust: let root = self.root.clone();
    // rust: let (regions, entity_regions, poi_regions) = (
    // rust: self.regions.clone(),
    // rust: self.entity_regions.clone(),
    // rust: self.poi_regions.clone(),
    // rust: );
    // rust: let pending = self.pending.clone();
    // rust: let outstanding = self.outstanding.clone();
    // rust: let thread = std::thread::Builder::new()
    // rust: .name("horizon-region-writer".into())
    // rust: .spawn(move || {
    // rust: for (kind, batch) in receive {
    // rust: let cache = match kind {
    // rust: Folder::Region => &regions,
    // rust: Folder::Entities => &entity_regions,
    // rust: Folder::Poi => &poi_regions,
}
    // rust: let folder = kind.name();
                    // IOWorker.pendingWrites: a chunk queued again since is
                    // written once, by its newest batch.
    // rust: let newest = |k: &(i32, i32), seq: u64| {
    // rust: pending.lock().map_or(true, |p| {
    // rust: p.get(&(kind, k.0, k.1)).is_none_or(|p| p.0 <= seq)
    // rust: })
}
    // rust: let resolved: Vec<_> = batch
    // rust: .iter()
    // rust: .filter(|(k, _, seq)| newest(k, *seq))
    // rust: .filter_map(|(k, r, _)| Some((*k, resolve_poi(&root, cache, *k, r)?)))
    // rust: .collect();
    // rust: let records: Vec<_> = resolved.iter().map(|(k, r)| (*k, r)).collect();
    // rust: let result = write_region_records(&root, cache, folder, &records);
    // rust: if let Err(e) = &result {
    // rust: let message = format!("failed to write {folder} files: {e}");
    // rust: log::warn!("Horizon: {message}");
    // rust: *outstanding.error.lock().unwrap() = Some(message);
                        // `reportChunkSaveFailure` for each chunk of the batch.
    // rust: for (k, _, _) in &batch {
    // rust: crate::chunk_io::report_save_failure(&root, k.0, k.1, e);
}
}
                    // Keep failed snapshots readable; never report them as durable.
    // rust: if result.is_ok()
    // rust: && let Ok(mut pending) = pending.lock()
    // rust: {
    // rust: for (k, _, seq) in &batch {
    // rust: if pending.get(&(kind, k.0, k.1)).is_some_and(|p| p.0 == *seq) {
    // rust: pending.remove(&(kind, k.0, k.1));
}
}
}
    // rust: if let Ok(mut count) = outstanding.count.lock() {
    // rust: *count -= 1;
    // rust: outstanding.done.notify_all();
}
}
    // rust: })
    // rust: .expect("spawn region writer");
    // rust: Writer { send, thread }
}
    /// Wait until every queued write is on disk.
pub fn flush(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut count = self
    // rust: .outstanding
    // rust: .count
    // rust: .lock()
    // rust: .map_err(|_| "writer poisoned")?;
    // rust: while *count > 0 {
    // rust: count = self
    // rust: .outstanding
    // rust: .done
    // rust: .wait(count)
    // rust: .map_err(|_| "writer poisoned")?;
}
    // rust: self.write_result()
}
    /// Poll durability without holding up the event loop. Errors remain visible
    /// to every waiter, including a later synchronous shutdown.
pub fn writes_finished(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let count = self
    // rust: .outstanding
    // rust: .count
    // rust: .lock()
    // rust: .map_err(|_| "writer poisoned")?;
    // rust: self.write_result()?;
    // rust: Ok(*count == 0)
}
pub fn write_result(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &*self
    // rust: .outstanding
    // rust: .error
    // rust: .lock()
    // rust: .map_err(|_| "writer poisoned")?
    // rust: {
    // rust: Some(error) => Err(error.clone().into()),
    // rust: None => Ok(()),
}
}
    /// Write `chunks` into their region files and wait until they are on disk.
    // rust: pub fn save(
    // rust: &self,
    // rust: chunks: &[Arc<Chunk>],
    // rust: registry: &BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: ) -> Result<usize> {
    // rust: let tables = self.tables.get().map(|t| &**t);
    // rust: let records = chunks
    // rust: .iter()
    // rust: .map(|c| {
    // rust: (
    // rust: (c.x, c.z),
    // rust: Some(encode_with(c, registry, biomes, tables, self.shape)),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: self.write_records("region", records, true)?;
    // rust: self.save_poi(chunks, true)?;
    // rust: Ok(chunks.len())
}
pub fn save_poi(self: *Self, chunks: *[*Chunk], wait: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(tables) = self.tables.get() else {
    // rust: return Ok(());
}
    // rust: let records = chunks
    // rust: .iter()
    // rust: .map(|c| ((c.x, c.z), Record::Poi(c.clone(), tables.clone())))
    // rust: .collect();
    // rust: self.queue(Folder::Poi, records, wait)
}
    /// `save` on the writer thread: returns before the files are written;
    /// loads see the chunks meanwhile.
    // rust: pub fn save_later(
    // rust: &self,
    // rust: chunks: &[Arc<Chunk>],
    // rust: registry: &'static BlockRegistry,
    // rust: biomes: &Arc<Biomes>,
    // rust: ) -> Result<usize> {
    // rust: let encoding = Arc::new(Encoding {
    // rust: registry,
    // rust: biomes: biomes.clone(),
    // rust: tables: self.tables.get().cloned(),
    // rust: shape: self.shape,
    // rust: });
    // rust: let records = chunks
    // rust: .iter()
    // rust: .map(|c| ((c.x, c.z), Record::Chunk(c.clone(), encoding.clone())))
    // rust: .collect();
    // rust: self.queue(Folder::Region, records, false)?;
    // rust: self.save_poi(chunks, false)?;
    // rust: Ok(chunks.len())
}
    /// Write the entity chunks (`EntityStorage`): an empty list deletes it.
pub fn save_entities(self: *Self, chunks: Vec<((i32) void {
}
    // rust: self.write_entities(chunks, true)
}
    /// `save_entities` on the writer thread.
pub fn save_entities_later(self: *Self, chunks: Vec<((i32) void {
}
    // rust: self.write_entities(chunks, false)
}
pub fn write_entities(self: *Self, chunks: Vec<((i32) void {
}
    // rust: let records = chunks
    // rust: .into_iter()
    // rust: .map(|((x, z), entities)| {
    // rust: let tag = (!entities.is_empty()).then(|| NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: ("Position", Tag::IntArray(vec![x, z])),
    // rust: ("Entities", Tag::List(entities)),
    // rust: ]),
    // rust: });
    // rust: ((x, z), tag)
    // rust: })
    // rust: .collect();
    // rust: self.write_records("entities", records, wait)
}
}

    // rust: impl Drop for SaveDir {
    /// Finish queued writes before the world is let go.
pub fn drop(self: *Self) void {
}
    // rust: if let Some(writer) = self.writer.get_mut().ok().and_then(Option::take) {
    // rust: drop(writer.send);
    // rust: let _ = writer.thread.join();
}
}
}

pub fn read_dat(path: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: try_read_dat(path).ok()
}
/// `read_dat`, with why the file did not read.
pub fn try_read_dat(path: *Path) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bytes = fs::read(path).map_err(|e| match e.kind() {
    // rust: std::io::ErrorKind::NotFound => DatIssue::Missing,
    // rust: _ => DatIssue::Unreadable(e.to_string()),
    // rust: })?;
    // rust: let raw = match Compression::Gzip.decode(&bytes, Limits::saved().max_bytes) {
    // rust: Ok(raw) => raw,
    // rust: Err(_) => bytes,
}
    // rust: nbt::read_named(&raw, Limits::saved())
    // rust: .map(|(named, _)| named.tag)
    // rust: .map_err(|e| DatIssue::Unreadable(e.to_string()))
}
/// What `LevelStorageAccess.collectIssues` finds wrong with a level.dat.
pub const DatIssue = enum {
    /// No such file (`FileNotFoundException`).
    Missing,
    /// It exists but does not read as a level: why.
    Unreadable(String),
};
/// `LevelStorageAccess.collectIssues`: why level.dat (level.dat_old with
/// `old`) can't be read as the world's level data, `None` when it can.
pub fn level_dat_issue(dir: *Path, old: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = if old { "level.dat_old" } else { "level.dat" };
    // rust: match try_read_dat(&dir.join(file)) {
    // rust: Ok(root) if matches!(root.get("Data"), Some(Tag::Compound(_))) => None,
    // rust: Ok(_) => Some(DatIssue::Unreadable("Invalid root tag".into())),
    // rust: Err(issue) => Some(issue),
}
}
/// `WorldOpenFlows.openWorldLoadLevelData`: what keeps `world`'s level data from reading, which
/// opens RecoverWorldDataScreen instead of the world. A folder with neither level.dat nor
/// level.dat_old is a world not made yet, not a broken one.
pub fn level_data_needs_recovery(world: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match level_dat_issue(world, false)? {
    // rust: DatIssue::Missing if !world.join("level.dat_old").exists() => None,
    // rust: issue => Some(issue),
}
}
/// `LevelStorageAccess.restoreLevelDataFromOld` (`Util.safeReplaceOrMoveFile`):
/// level.dat moves aside to `level.dat_corrupted_<time>` and level.dat_old
/// takes its place. Whether it worked. Vanilla passes `noRollback` and reports
/// success even when level.dat_old could not be moved in; here the broken
/// level.dat goes back and the failure is reported.
pub fn restore_level_data_from_old(dir: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (current, latest) = (dir.join("level.dat"), dir.join("level.dat_old"));
    // rust: let backup = dir.join(format!("level.dat_corrupted_{}", backup_stamp()));
    // rust: if current.exists() && fs::rename(&current, &backup).is_err() {
    // rust: return false;
}
    // rust: if fs::rename(&latest, &current).is_err() {
    // rust: if backup.exists() {
    // rust: let _ = fs::rename(&backup, &current);
}
    // rust: return false;
}
    // rust: true
}
/// `FileNameDateFormatter`: the time in the names of backed-up unreadable files.
pub fn backup_stamp() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: chrono::Local::now().format("%Y-%m-%d_%H-%M-%S").to_string()
}
/// `LevelStorageAccess.getUnfixedDataTagWithFallback`, which the dedicated server's `Main` calls:
/// a level.dat that does not read falls back to level.dat_old, which is restored in its place
/// (`restoreLevelDataFromOld`). Whether it did; `false` leaves the world as it was, for the
/// caller to refuse (both files broken, or nothing to fall back to).
pub fn fall_back_to_level_dat_old(world: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: level_dat_issue(world, false).is_some()
    // rust: && world.join("level.dat_old").exists()
    // rust: && level_dat_issue(world, true).is_none()
    // rust: && restore_level_data_from_old(world)
}
/// `LevelStorageSource.readLevelDataTagFixed`: level.dat, else level.dat_old.
pub fn read_level_dat(dir: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: read_dat(&dir.join("level.dat")).or_else(|| read_dat(&dir.join("level.dat_old")))
}
/// `restoreLevelDataFromOld`: an unreadable level.dat is kept as
/// `level.dat_corrupted_<time>` and level.dat_old takes its place, so the next
/// write does not bury either file.
pub fn restore_level_dat(dir: *Path) void {
}
    // rust: let path = dir.join("level.dat");
    // rust: if read_dat(&path).is_some() {
    // rust: return;
}
    // rust: if path.exists() {
    // rust: let _ = fs::rename(
    // rust: &path,
    // rust: dir.join(format!("level.dat_corrupted_{}", backup_stamp())),
    // rust: );
}
    // rust: let old = dir.join("level.dat_old");
    // rust: if read_dat(&old).is_some() {
    // rust: let _ = fs::rename(old, path);
}
}
/// `PlayerDataStorage.backup`: a player file that fails to load is copied to
/// `<uuid>_corrupted_<time>.dat` before it is written over.
pub fn back_up_unreadable_player(path: *Path) void {
}
    // rust: if path.is_file()
    // rust: && read_dat(path).is_none()
    // rust: && let Some(stem) = path.file_stem().and_then(|s| s.to_str())
    // rust: {
    // rust: let _ = fs::copy(
    // rust: path,
    // rust: path.with_file_name(format!("{stem}_corrupted_{}.dat", backup_stamp())),
    // rust: );
}
}
/// Write a gzip NBT file the way vanilla does (`<name>_new`, keep `_old`).
pub fn write_dat(path: *Path, tag: Tag) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write_dat_as(path, tag, false)
}

/// [`write_dat`], synced to the disk: the new file before it is renamed into place, and the
/// folder after, so a power loss leaves the old file or the new one. A hand-over's commit
/// point (`player-confirm`) replies only once its files are.
pub fn write_dat_durable(path: *Path, tag: Tag) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write_dat_as(path, tag, true)
}

/// `bytes` written to `path` through `<name>_new` and a rename, synced to the disk as
/// [`write_dat_durable`] syncs: never a half-written file in place.
pub fn write_durable(path: *Path, bytes: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(dir) = path.parent() {
    // rust: fs::create_dir_all(dir)?;
}
    // rust: let file = path.file_name().and_then(|n| n.to_str()).unwrap_or("data");
    // rust: let temporary = path.with_file_name(format!("{file}_new"));
    // rust: write_synced(&temporary, bytes)?;
    // rust: fs::rename(&temporary, path)?;
    // rust: sync_folder(path)?;
    // rust: Ok(())
}

pub fn write_synced(path: *Path, bytes: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::io::Write;
    // rust: let mut file = fs::File::create(path)?;
    // rust: file.write_all(bytes)?;
    // rust: file.sync_all()
}

/// The folder of `path` synced, so that a rename into it is on the disk (POSIX; Windows has
/// no folder handle to sync, and its rename is journaled by NTFS).
pub fn sync_folder(path: *Path) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(dir) = path.parent() {
    // rust: fs::File::open(dir)?.sync_all()?;
}
    // rust: let _ = path;
    // rust: Ok(())
}

pub fn write_dat_as(path: *Path, tag: Tag, durable: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(dir) = path.parent() {
    // rust: fs::create_dir_all(dir)?;
}
    // rust: let bytes = nbt::write_named(
    // rust: &NamedTag {
    // rust: name: "".into(),
    // rust: tag,
    // rust: },
    // rust: Limits::saved(),
    // rust: )
    // rust: .map_err(|e| e.to_string())?;
    // rust: let compressed = Compression::Gzip.encode(&bytes)?;
    // rust: let file = path
    // rust: .file_name()
    // rust: .and_then(|n| n.to_str())
    // rust: .unwrap_or("data.dat");
    // rust: let temporary = path.with_file_name(format!("{file}_new"));
    // rust: if durable {
    // rust: write_synced(&temporary, &compressed)?;
    // rust: } else {
    // rust: fs::write(&temporary, compressed)?;
}
    // rust: if path.exists() {
    // rust: let old = match file.strip_suffix(".dat") {
    // rust: Some(stem) => path.with_file_name(format!("{stem}.dat_old")),
    // rust: None => path.with_file_name(format!("{file}_old")),
}
        // Util.safeReplaceFile: no backup, no replacement.
    // rust: fs::rename(path, old).map_err(|e| format!("{}: {e}", path.display()))?;
}
    // rust: fs::rename(temporary, path)?;
    // rust: if durable {
    // rust: sync_folder(path)?;
}
    // rust: Ok(())
}
/// `SavedDataStorage`: `{data: ..., DataVersion}` under `data/minecraft/`.
pub fn saved_data_path(world: *Path, name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: world
    // rust: .join("data")
    // rust: .join("minecraft")
    // rust: .join(format!("{name}.dat"))
}
pub fn read_saved_data(world: *Path, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: read_dat(&saved_data_path(world, name))?
    // rust: .get("data")
    // rust: .cloned()
}
/// The world's generator settings: world_gen_settings.dat (26.3) or
/// level.dat's Data.WorldGenSettings.
pub fn world_gen_settings(world: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // A world still to be file-fixed has them in level.dat in an older shape: they are read as
    // the fixes would leave them, so the questions on opening it are the same ones.
    // rust: if let Ok(Some(settings)) = horizon_world::datafix::files::current_world_gen_settings(world) {
    // rust: return Some(settings);
}
    // rust: read_saved_data(world, "world_gen_settings").or_else(|| {
    // rust: read_dat(&world.join("level.dat"))?
    // rust: .get("Data")?
    // rust: .get("WorldGenSettings")
    // rust: .cloned()
    // rust: })
}
pub fn write_saved_data(world: *Path, name: []const u8, data: Tag) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write_dat(
    // rust: &saved_data_path(world, name),
    // rust: Tag::compound([("data", data), ("DataVersion", Tag::Int(DATA_VERSION))]),
    // rust: )
}
    // rust: pub use horizon_client_core::uuid::{uuid_from_text, uuid_text};
/// A random (version 4) UUID as vanilla's four-int form.
///
/// Every call gets its own: the generator is seeded once from the clock and
/// the process, then each call takes the next step of one shared counter. A
/// seed from the clock alone repeats within its resolution (a microsecond on
/// macOS): a pack of mobs generated together all had the same UUID, and a
/// vanilla client keeps only one entity per UUID (the rest never moved).
pub fn random_uuid() [ {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::sync::{
    // rust: OnceLock,
    // rust: atomic::{AtomicU64, Ordering},
}
pub const NEXT: OnceLock<AtomicU64> = OnceLock::new();
    // rust: let next = NEXT.get_or_init(|| {
    // rust: let t = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_nanos() as u64);
    // rust: AtomicU64::new(t ^ (std::process::id() as u64).rotate_left(32))
    // rust: });
    // SplitMix64: distinct steps give distinct outputs.
    // rust: let split = || {
    // rust: let mut z = next
    // rust: .fetch_add(0x9E37_79B9_7F4A_7C15, Ordering::Relaxed)
    // rust: .wrapping_add(0x9E37_79B9_7F4A_7C15);
    // rust: z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
    // rust: z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
    // rust: z ^ (z >> 31)
}
    // rust: let (a, b) = (split(), split());
    // rust: let a = (a & !0xF000) | 0x4000;
    // rust: let b = (b & !(0xC000_0000_0000_0000)) | 0x8000_0000_0000_0000;
    // rust: [(a >> 32) as i32, a as i32, (b >> 32) as i32, b as i32]
}
    // rust: pub(crate) fn uuid_tag(u: [i32; 4]) -> Tag {
    // rust: Tag::IntArray(u.to_vec())
}
    // rust: pub(crate) fn uuid_from_tag(tag: Option<&Tag>) -> Option<[i32; 4]> {
    // rust: match tag? {
    // rust: Tag::IntArray(v) if v.len() == 4 => Some([v[0], v[1], v[2], v[3]]),
    // rust: Tag::String(s) => uuid_from_text(&s.to_string_lossy()),
    // rust: _ => None,
}
}
    // rust: pub(crate) fn doubles(values: &[f64]) -> Tag {
    // rust: Tag::List(values.iter().map(|v| Tag::Double(v.to_bits())).collect())
}
    // rust: pub(crate) fn floats(values: &[f32]) -> Tag {
    // rust: Tag::List(values.iter().map(|v| Tag::Float(v.to_bits())).collect())
}
    // rust: pub(crate) fn read_doubles<const N: usize>(tag: Option<&Tag>) -> Option<[f64; N]> {
    // rust: match tag? {
    // rust: Tag::List(l) if l.len() == N => {
    // rust: let mut out = [0.0; N];
    // rust: for (o, v) in out.iter_mut().zip(l) {
    // rust: *o = float(Some(v))?;
}
    // rust: Some(out)
}
    // rust: _ => None,
}
}

/// Default game rules of a new 26.3 world (`data/minecraft/game_rules.dat`).
    // rust: const GAME_RULES: [(&str, i32); 58] = [
    // rust: ("spawn_wandering_traders", 1),
    // rust: ("block_drops", 1),
    // rust: ("reduced_debug_info", 0),
    // rust: ("show_death_messages", 1),
    // rust: ("spawner_blocks_work", 1),
    // rust: ("spawn_monsters", 1),
    // rust: ("tnt_explodes", 1),
    // rust: ("player_movement_check", 1),
    // rust: ("immediate_respawn", 0),
    // rust: ("block_explosion_drop_decay", 1),
    // rust: ("spread_vines", 1),
    // rust: ("max_entity_cramming", 24),
    // rust: ("forgive_dead_players", 1),
    // rust: ("fall_damage", 1),
    // rust: ("send_command_feedback", 1),
    // rust: ("global_sound_events", 1),
    // rust: ("elytra_movement_check", 1),
    // rust: ("fire_spread_radius_around_player", 128),
    // rust: ("freeze_damage", 1),
    // rust: ("mob_explosion_drop_decay", 1),
    // rust: ("natural_health_regeneration", 1),
    // rust: ("players_nether_portal_default_delay", 80),
    // rust: ("mob_drops", 1),
    // rust: ("log_admin_commands", 1),
    // rust: ("mob_griefing", 1),
    // rust: ("spawn_mobs", 1),
    // rust: ("pvp", 1),
    // rust: ("spectators_generate_chunks", 1),
    // rust: ("max_command_sequence_length", 65536),
    // rust: ("players_nether_portal_creative_delay", 0),
    // rust: ("players_sleeping_percentage", 100),
    // rust: ("advance_weather", 1),
    // rust: ("max_block_modifications", 32768),
    // rust: ("max_command_forks", 65536),
    // rust: ("drowning_damage", 1),
    // rust: ("command_block_output", 1),
    // rust: ("locator_bar", 1),
    // rust: ("show_advancement_messages", 1),
    // rust: ("respawn_radius", 10),
    // rust: ("raids", 1),
    // rust: ("spawn_phantoms", 1),
    // rust: ("max_snow_accumulation_height", 1),
    // rust: ("limited_crafting", 0),
    // rust: ("allow_entering_nether_using_portals", 1),
    // rust: ("lava_source_conversion", 0),
    // rust: ("tnt_explosion_drop_decay", 0),
    // rust: ("universal_anger", 0),
    // rust: ("keep_inventory", 0),
    // rust: ("spawn_patrols", 1),
    // rust: ("random_tick_speed", 3),
    // rust: ("fire_damage", 1),
    // rust: ("entity_drops", 1),
    // rust: ("advance_time", 1),
    // rust: ("command_blocks_work", 1),
    // rust: ("spawn_wardens", 1),
    // rust: ("water_source_conversion", 1),
    // rust: ("projectiles_can_break_blocks", 1),
    // rust: ("ender_pearls_vanish_on_death", 1),
    // rust: ];
/// Integer-valued rules; the others are booleans stored as bytes.
    // rust: const INT_RULES: [&str; 11] = [
    // rust: "max_snow_accumulation_height",
    // rust: "random_tick_speed",
    // rust: "max_entity_cramming",
    // rust: "fire_spread_radius_around_player",
    // rust: "players_nether_portal_default_delay",
    // rust: "max_command_sequence_length",
    // rust: "players_nether_portal_creative_delay",
    // rust: "players_sleeping_percentage",
    // rust: "max_block_modifications",
    // rust: "max_command_forks",
    // rust: "respawn_radius",
    // rust: ];

/// The world presets of 26.3's `worldgen/world_preset` that the create
/// screen offers, in the order of `WorldPresetTags.NORMAL`.
pub const WorldPreset = enum {
    Normal,
    Flat,
    LargeBiomes,
    Amplified,
    SingleBiomeSurface,
    /// `minecraft:debug_all_block_states`: a grid of every block state
    /// (`DebugLevelSource`). The create screen does not offer it; a data
    /// pack, `level-type` or a saved world names it.
    Debug,
};
    // rust: impl WorldPreset {
    /// The presets, in the order the world-type button cycles through them.
    // rust: pub const ALL: [Self; 5] = [
    // rust: Self::Normal,
    // rust: Self::Flat,
    // rust: Self::LargeBiomes,
    // rust: Self::Amplified,
    // rust: Self::SingleBiomeSurface,
    // rust: ];
    /// The preset's registry id (`minecraft:normal`).
    // rust: pub const fn id(self) -> &'static str {
    // rust: match self {
    // rust: Self::Normal => "minecraft:normal",
    // rust: Self::Flat => "minecraft:flat",
    // rust: Self::LargeBiomes => "minecraft:large_biomes",
    // rust: Self::Amplified => "minecraft:amplified",
    // rust: Self::SingleBiomeSurface => "minecraft:single_biome_surface",
    // rust: Self::Debug => "minecraft:debug_all_block_states",
}
}
    /// The preset an id names, if it is one of them.
pub fn of_id(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL
    // rust: .into_iter()
    // rust: .chain([Self::Debug])
    // rust: .find(|preset| preset.id() == id)
}
    /// The language key the world-type button shows
    /// (`Identifier.toLanguageKey("generator")`).
    // rust: pub const fn label(self) -> &'static str {
    // rust: match self {
    // rust: Self::Normal => "generator.minecraft.normal",
    // rust: Self::Flat => "generator.minecraft.flat",
    // rust: Self::LargeBiomes => "generator.minecraft.large_biomes",
    // rust: Self::Amplified => "generator.minecraft.amplified",
    // rust: Self::SingleBiomeSurface => "generator.minecraft.single_biome_surface",
    // rust: Self::Debug => "generator.minecraft.debug_all_block_states",
}
}
    /// The preset the world-type button cycles to next.
pub fn next(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = Self::ALL
    // rust: .iter()
    // rust: .position(|preset| *preset == self)
    // rust: .unwrap_or(0);
    // rust: Self::ALL[(index + 1) % Self::ALL.len()]
}
    /// The preset the world-type button cycles to previously.
pub fn prev(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = Self::ALL
    // rust: .iter()
    // rust: .position(|preset| *preset == self)
    // rust: .unwrap_or(0);
    // rust: Self::ALL[(index + Self::ALL.len() - 1) % Self::ALL.len()]
}
    /// The preset a saved overworld generator is: the noise settings name
    /// the preset, and the single-biome preset shares the overworld's noise
    /// settings, so its fixed biome source tells the two apart.
pub fn of_generator(generator: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if text(generator.get("type")).as_deref() == Some("minecraft:flat") {
    // rust: return Self::Flat;
}
    // rust: if text(generator.get("type")).as_deref() == Some("minecraft:debug") {
    // rust: return Self::Debug;
}
    // rust: let source = generator.get("biome_source");
    // rust: let fixed = text(source.and_then(|s| s.get("type"))).as_deref() == Some("minecraft:fixed");
    // rust: match text(generator.get("settings")).as_deref() {
    // rust: Some("minecraft:large_biomes") => Self::LargeBiomes,
    // rust: Some("minecraft:amplified") => Self::Amplified,
    // rust: Some("minecraft:overworld") if fixed => Self::SingleBiomeSurface,
    // rust: _ => Self::Normal,
}
}
}
/// World and player state stored in `level.dat`, the saved-data files and
/// the player file.
/// The world options CreateWorldScreen sets (`WorldOptions` and the world
/// preset) that `world_gen_settings` keeps.
pub const WorldGen = struct {
    /// The world preset the world is created with.
    preset: WorldPreset,
    structures: bool,
    bonus_chest: bool,
};
    // rust: impl WorldGen {
    /// A saved world's choices, from its `world_gen_settings`.
pub fn read(world: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let settings = world_gen_settings(world)?;
    // rust: let flag = |key: &str, default: bool| number(settings.get(key)).map_or(default, |v| v != 0);
    // rust: let generator = settings
    // rust: .get("dimensions")
    // rust: .and_then(|d| d.get("minecraft:overworld"))
    // rust: .and_then(|o| o.get("generator"));
    // rust: Some(Self {
    // rust: preset: generator.map_or(WorldPreset::Normal, WorldPreset::of_generator),
    // rust: structures: flag("generate_structures", true),
    // rust: bonus_chest: flag("bonus_chest", false),
    // rust: })
}
    /// The bundled world preset a saved world's overworld was generated
    /// with, from its generator: `minecraft:amplified` and
    /// `minecraft:large_biomes` by their noise settings, and
    /// `minecraft:single_biome_surface` by a fixed biome source. Anything
    /// else (and any world without settings) is `minecraft:normal`.
pub fn preset(world: *Path) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let settings = world_gen_settings(world);
    // rust: let generator = settings
    // rust: .as_ref()
    // rust: .and_then(|s| s.get("dimensions"))
    // rust: .and_then(|d| d.get("minecraft:overworld"))
    // rust: .and_then(|o| o.get("generator"));
    // rust: let noise = text(generator.and_then(|g| g.get("settings")));
    // rust: let fixed_biome = generator
    // rust: .and_then(|g| g.get("biome_source"))
    // rust: .and_then(|b| text(b.get("type")))
    // rust: .is_some_and(|t| t == "minecraft:fixed");
    // rust: match noise.as_deref() {
    // rust: Some("minecraft:amplified") => "minecraft:amplified",
    // rust: Some("minecraft:large_biomes") => "minecraft:large_biomes",
    // rust: Some("minecraft:overworld") if fixed_biome => "minecraft:single_biome_surface",
    // rust: _ => "minecraft:normal",
}
}
}
    // rust: impl Default for WorldGen {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: preset: WorldPreset::Normal,
    // rust: structures: true,
    // rust: bonus_chest: false,
}
}
}
/// Writes a new world's `world_gen_settings` (seed, options and dimensions).
pub fn write_world_gen_settings(dir: *Path, seed: i64, options: WorldGen) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write_world_gen_settings_with(dir, seed, options, None, None)
}
/// [`write_world_gen_settings`] with a flat overworld's own generator
/// settings (FlatLevelGeneratorSettings, as `flatgen::settings_from_json`
/// reads them) instead of the Superflat preset's classic layers, and with the
/// biome the single-biome preset fixes (`CreateBuffetWorldScreen`'s choice,
/// `minecraft:plains` when none was made).
    // rust: pub fn write_world_gen_settings_with(
    // rust: dir: &Path,
    // rust: seed: i64,
    // rust: options: WorldGen,
    // rust: flat_settings: Option<Tag>,
    // rust: single_biome: Option<&str>,
    // rust: ) -> Result<()> {
    // rust: fs::create_dir_all(dir)?;
    // worldgen/world_preset/flat.json's overworld: the classic flat layers.
    // rust: let layer = |block: &str, height: i32| {
    // rust: Tag::compound([("block", string(block)), ("height", Tag::Int(height))])
}
    // rust: let classic = || {
    // rust: Tag::compound([
    // rust: ("biome", string("minecraft:plains")),
    // rust: ("features", Tag::Byte(0)),
    // rust: ("lakes", Tag::Byte(0)),
    // rust: (
    // rust: "layers",
    // rust: Tag::List(vec![
    // rust: layer("minecraft:bedrock", 1),
    // rust: layer("minecraft:dirt", 2),
    // rust: layer("minecraft:grass_block", 1),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "structure_overrides",
    // rust: Tag::List(vec![
    // rust: string("minecraft:strongholds"),
    // rust: string("minecraft:villages"),
    // rust: ]),
    // rust: ),
    // rust: ])
}
    // rust: let flat = Tag::compound([
    // rust: ("type", string("minecraft:overworld")),
    // rust: (
    // rust: "generator",
    // rust: Tag::compound([
    // rust: ("type", string("minecraft:flat")),
    // rust: ("settings", flat_settings.unwrap_or_else(classic)),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: let dimension = |kind: &str, settings: &str, source: Tag| {
    // rust: Tag::compound([
    // rust: ("type", string(kind)),
    // rust: (
    // rust: "generator",
    // rust: Tag::compound([
    // rust: ("type", string("minecraft:noise")),
    // rust: ("settings", string(settings)),
    // rust: ("biome_source", source),
    // rust: ]),
    // rust: ),
    // rust: ])
}
    // rust: let preset = |p: &str| {
    // rust: Tag::compound([
    // rust: ("type", string("minecraft:multi_noise")),
    // rust: ("preset", string(p)),
    // rust: ])
}
    // The overworld generator of worldgen/world_preset/<preset>.json: the
    // noise settings and the biome source each preset uses.
    // rust: let overworld = match options.preset {
    // rust: WorldPreset::Flat => flat,
    // rust: WorldPreset::LargeBiomes => dimension(
    // rust: "minecraft:overworld",
    // rust: "minecraft:large_biomes",
    // rust: preset("minecraft:overworld"),
    // rust: ),
    // rust: WorldPreset::Amplified => dimension(
    // rust: "minecraft:overworld",
    // rust: "minecraft:amplified",
    // rust: preset("minecraft:overworld"),
    // rust: ),
    // rust: WorldPreset::SingleBiomeSurface => dimension(
    // rust: "minecraft:overworld",
    // rust: "minecraft:overworld",
    // rust: Tag::compound([
    // rust: ("type", string("minecraft:fixed")),
    // rust: ("biome", string(single_biome.unwrap_or("minecraft:plains"))),
    // rust: ]),
    // rust: ),
    // rust: WorldPreset::Normal => dimension(
    // rust: "minecraft:overworld",
    // rust: "minecraft:overworld",
    // rust: preset("minecraft:overworld"),
    // rust: ),
        // worldgen/world_preset/debug_all_block_states.json's overworld.
    // rust: WorldPreset::Debug => Tag::compound([
    // rust: ("type", string("minecraft:overworld")),
    // rust: (
    // rust: "generator",
    // rust: Tag::compound([("type", string("minecraft:debug"))]),
    // rust: ),
    // rust: ]),
}
    // rust: write_saved_data(
    // rust: dir,
    // rust: "world_gen_settings",
    // rust: Tag::compound([
    // rust: ("seed", Tag::Long(seed)),
    // rust: (
    // rust: "generate_structures",
    // rust: Tag::Byte(i8::from(options.structures)),
    // rust: ),
    // rust: ("bonus_chest", Tag::Byte(i8::from(options.bonus_chest))),
    // rust: (
    // rust: "dimensions",
    // rust: Tag::compound([
    // rust: ("minecraft:overworld", overworld),
    // rust: (
    // rust: "minecraft:the_nether",
    // rust: dimension(
    // rust: "minecraft:the_nether",
    // rust: "minecraft:nether",
    // rust: preset("minecraft:nether"),
    // rust: ),
    // rust: ),
    // rust: (
    // rust: "minecraft:the_end",
    // rust: dimension(
    // rust: "minecraft:the_end",
    // rust: "minecraft:end",
    // rust: Tag::compound([("type", string("minecraft:the_end"))]),
    // rust: ),
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: ]),
    // rust: )
}
pub const Level = struct {
    name: []const u8,
    seed: i64,
    creative: bool,
    /// The game mode id (0 survival, 1 creative, 2 adventure, 3 spectator);
    /// `creative` wins when the two disagree.
    game_mode: i32,
    /// `previousPlayerGameType`: the mode the player left last (the F3+F4 switcher's
    /// return mode), when it has one.
    previous_game_mode: ?i32,
    time: i64,
    day_time: i64,
    /// Where the player respawns when it has no bed or anchor: its forced
    /// Overworld point (`spawnpoint`), or the world spawn.
    spawn: Option<[f64,
    /// A respawn point resolved through its block when the player respawns
    /// (a bed, a respawn anchor, a forced point outside the Overworld):
    /// dimension, block, yaw and `forced`.
    respawn_elsewhere: Option<([]const u8,
    position: Option<[f64,
    rotation: [f32,
    health: f32,
    /// LivingEntity `AbsorptionAmount`: the golden hearts left.
    absorption: f32,
    food: i32,
    saturation: f32,
    /// (slot, item, count, damage): 0..36 inventory, 100..103 armor (feet..head), 150 offhand.
    inventory: Vec<(u8,
    /// Extra item components of `inventory` entries, by slot.
    inventory_components: HashMap<u8,
    /// Player.XpSeed: the enchanting table seed.
    xp_seed: i32,
    /// ServerPlayer.seenCredits: the end poem has been shown.
    seen_credits: bool,
    /// ServerPlayer.postEffects: the `post_effect` chains `/posteffect` set.
    post_effects: std.ArrayList([]const u8),
    /// Player.lastDeathLocation: the dimension and block of the last death.
    last_death: Option<([]const u8,
    /// Player.active_effects: (id, duration, amplifier, ambient, show_particles).
    active_effects: Vec<([]const u8,
    /// Player.EnderItems: the ender chest inventory (27 slots).
    ender_items: std.ArrayList(?crate::items::ItemStack),
    /// The `recipeBook` compound: open/filter settings and unlocked recipes.
    recipe_book: crate::recipe_book::Settings,
    xp_level: i32,
    xp_progress: f32,
    xp_total: i32,
    weather: crate::world::Weather,
    /// Player.Dimension (minecraft:overworld / minecraft:the_nether).
    dimension: []const u8,
    /// World spawn (`level.dat` `spawn`), distinct from a bed respawn point.
    world_spawn: Option<[i32,
    /// The world spawn's yaw and pitch (`setworldspawn`'s rotation).
    world_spawn_angle: [f32,
    difficulty: []const u8,
    hardcore: bool,
    /// `difficulty_settings.locked` (LevelData.isDifficultyLocked).
    difficulty_locked: bool,
    /// `allowCommands`: read from `level.dat` or chosen on the Create New
    /// World screen; unset is written as off.
    allow_commands: ?bool,
    /// `DataPackConfig` (Create World's Data Packs and Experiments): the
    /// enabled and disabled pack ids. Unset keeps vanilla's defaults.
    data_packs: Option<(std.ArrayList([]const u8),
    /// `WorldDataConfiguration`'s `enabled_features`: the feature flag ids
    /// the world enables, `minecraft:vanilla` included. Empty is vanilla's
    /// default, which the level.dat omits.
    enabled_features: std.ArrayList([]const u8),
    /// Game rule values by name without namespace (`keep_inventory`, ...).
    game_rules: BTreeMap<[]const u8,
    player_uuid: Option<[i32,
    selected_slot: i32,
    motion: [f64,
    fall_distance: f64,
    on_ground: bool,
    food_exhaustion: f32,
    food_tick_timer: i32,
    /// Abilities.flying: whether creative/spectator flight is active.
    flying: bool,
    /// Abilities.flyingSpeed, when the file has one (vanilla's is 0.05).
    fly_speed: ?f32,
    /// The vehicle the player rides, by UUID (`ServerPlayer.saveParentVehicle`'s
    /// "RootVehicle"), so the ride comes back on the next login.
    root_vehicle: Option<[i32,
    /// The player compound as loaded, for fields Horizon does not model
    /// (ender chest, effects, abilities, recipe book, attributes, ...).
    player_extra: ?Tag,
    /// The player was read from the file level.dat names (`singleplayer_uuid`,
    /// or its `.dat_old`): `PlayerList.loadPlayerData` gives the world's owner
    /// that file, not their own.
    singleplayer_file: bool,
};
    // rust: impl Level {
    /// `PrimaryLevelData.setDifficulty`: the level data holds the world's
    /// difficulty, so the game and the file follow each other and a world
    /// that was set to hard is hard when it is opened again.
pub fn set_difficulty(self: *Self, difficulty: u8) void {
}
    // rust: self.difficulty = crate::title::DIFFICULTIES[difficulty as usize % 4].to_owned();
}

    /// `PrimaryLevelData.getDifficulty`: the id of the level data's
    /// difficulty (peaceful 0 .. hard 3), normal when it is not one of them.
pub fn difficulty_id(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::title::DIFFICULTIES
    // rust: .iter()
    // rust: .position(|d| *d == self.difficulty)
    // rust: .map_or(2, |i| i as u8)
}
    /// Initialize the offline single-player identity before saving or dropping items.
pub fn ensure_player_uuid(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self.player_uuid.get_or_insert_with(|| {
    // rust: let u = horizon_protocol::crypto::offline_uuid("Player");
    // rust: [
    // rust: (u >> 96) as u32 as i32,
    // rust: (u >> 64) as u32 as i32,
    // rust: (u >> 32) as u32 as i32,
    // rust: u as u32 as i32,
    // rust: ]
    // rust: })
}
pub fn game_rule(self: *Self, name: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game_rules
    // rust: .get(name)
    // rust: .copied()
    // rust: .or_else(|| GAME_RULES.iter().find(|(n, _)| *n == name).map(|(_, v)| *v))
    // rust: .unwrap_or(0)
}
    /// The saved game mode id.
pub fn mode(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (self.creative, self.game_mode) {
    // rust: (true, _) => 1,
    // rust: (false, 1) => 0,
    // rust: (false, m) => m.clamp(0, 3),
}
}
pub fn read(dir: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::read_root(dir, read_level_dat(dir)?)
}
    /// `read` from level.dat alone, without the level.dat_old fallback: what
    /// `LevelStorageSource.readLevelSummary` reads for the world list.
pub fn read_summary(dir: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::read_root(dir, read_dat(&dir.join("level.dat"))?)
}
pub fn read_root(dir: *Path, root: Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = root.get("Data")?;
    // rust: let n = |t: Option<&Tag>| number(t).unwrap_or(0);
    // rust: let mut level = Self {
    // rust: name: text(data.get("LevelName")).unwrap_or_else(|| "World".into()),
    // rust: creative: n(data.get("GameType")) == 1,
    // rust: game_mode: n(data.get("GameType")) as i32,
    // rust: time: n(data.get("Time")),
    // rust: health: 20.0,
    // rust: food: 20,
    // rust: saturation: 5.0,
    // rust: dimension: "minecraft:overworld".into(),
    // rust: difficulty: "normal".into(),
    // rust: ..Self::default()
}
        // 26.3: spawn {pos: [I; x, y, z], dimension, yaw, pitch}; older: SpawnX/Y/Z.
    // rust: level.world_spawn = match data.get("spawn").and_then(|s| s.get("pos")) {
    // rust: Some(Tag::IntArray(p)) if p.len() == 3 => Some([p[0], p[1], p[2]]),
    // rust: _ => data.get("SpawnX").map(|_| {
    // rust: [
    // rust: n(data.get("SpawnX")) as i32,
    // rust: n(data.get("SpawnY")) as i32,
    // rust: n(data.get("SpawnZ")) as i32,
    // rust: ]
    // rust: }),
}
    // rust: let angle = |k: &str| match data.get("spawn").and_then(|s| s.get(k)) {
    // rust: Some(Tag::Float(b)) => f32::from_bits(*b),
    // rust: _ => 0.0,
}
    // rust: level.world_spawn_angle = [angle("yaw"), angle("pitch")];
    // rust: if let Some(d) = data.get("difficulty_settings") {
    // rust: level.difficulty = text(d.get("difficulty")).unwrap_or_else(|| "normal".into());
    // rust: level.hardcore = n(d.get("hardcore")) != 0;
    // rust: level.difficulty_locked = n(d.get("locked")) != 0;
}
    // rust: level.allow_commands = Some(n(data.get("allowCommands")) != 0);
        // WorldDataConfiguration.MAP_CODEC's `enabled_features`, flat in the
        // Data compound and omitted when the flags are vanilla's default.
    // rust: if let Some(Tag::List(flags)) = data.get("enabled_features") {
    // rust: level.enabled_features = flags
    // rust: .iter()
    // rust: .filter_map(|f| match f {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
}
    // rust: if let Some(packs) = data.get("DataPacks") {
    // rust: let ids = |key| match packs.get(key) {
    // rust: Some(Tag::List(ids)) => ids.iter().filter_map(|id| text(Some(id))).collect(),
    // rust: _ => Vec::new(),
}
    // rust: level.data_packs = Some((ids("Enabled"), ids("Disabled")));
}
    // rust: let mut rules: BTreeMap<String, i32> = GAME_RULES
    // rust: .iter()
    // rust: .map(|(k, v)| ((*k).to_owned(), *v))
    // rust: .collect();
    // rust: let saved_rules = read_saved_data(dir, "game_rules");
    // rust: if let Some(Tag::Compound(map)) = &saved_rules {
    // rust: for (k, v) in map {
    // rust: let name = k.to_string_lossy();
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(&name).to_owned();
    // rust: if let Some(v) = number(Some(v)) {
    // rust: rules.insert(name, v as i32);
}
}
}
        // GameRules(enabledFeatures, map) removes disabled experimental rules
        // and supplies their defaults when enabled but absent from saved data.
    // rust: let minecart_rule = &crate::gamerules::MAX_MINECART_SPEED;
    // rust: if level
    // rust: .enabled_features
    // rust: .iter()
    // rust: .any(|f| f == crate::gamerules::MINECART_IMPROVEMENTS)
    // rust: {
    // rust: let crate::gamerules::Value::Int(default) = minecart_rule.default else {
    // rust: unreachable!()
}
    // rust: let value = rules
    // rust: .entry(minecart_rule.name.to_owned())
    // rust: .or_insert(default);
    // rust: if !(minecart_rule.min..=minecart_rule.max).contains(value) {
    // rust: *value = default;
}
    // rust: } else {
    // rust: rules.remove(minecart_rule.name);
}
    // rust: level.game_rules = rules;
        // Seed: world_gen_settings.dat (26.3) or Data.WorldGenSettings.
    // rust: level.seed = read_saved_data(dir, "world_gen_settings")
    // rust: .and_then(|w| number(w.get("seed")))
    // rust: .or_else(|| number(data.get("WorldGenSettings").and_then(|w| w.get("seed"))))
    // rust: .unwrap_or(0);
        // Day time: the overworld clock (26.3) or Data.DayTime.
    // rust: level.day_time = read_saved_data(dir, "world_clocks")
    // rust: .and_then(|c| {
    // rust: number(
    // rust: c.get("minecraft:overworld")
    // rust: .and_then(|o| o.get("total_ticks")),
    // rust: )
    // rust: })
    // rust: .or_else(|| number(data.get("DayTime")))
    // rust: .unwrap_or(level.time);
    // rust: let weather = read_saved_data(dir, "weather");
    // rust: let w = |new: &str, old: &str| {
    // rust: number(weather.as_ref().and_then(|w| w.get(new)))
    // rust: .or_else(|| number(data.get(old)))
    // rust: .unwrap_or(0)
}
    // rust: let raining = w("raining", "raining") != 0;
    // rust: let thundering = w("thundering", "thundering") != 0;
    // rust: level.weather = crate::world::Weather {
    // rust: clear_time: w("clear_weather_time", "clearWeatherTime") as i32,
    // rust: rain_time: w("rain_time", "rainTime") as i32,
    // rust: thunder_time: w("thunder_time", "thunderTime") as i32,
    // rust: raining,
    // rust: thundering,
    // rust: rain_level: if raining { (1.0, 1.0) } else { (0.0, 0.0) },
    // rust: thunder_level: if thundering { (1.0, 1.0) } else { (0.0, 0.0) },
}
        // The player: players/data/<singleplayer_uuid>.dat, or the legacy Data.Player. With no
        // `singleplayer_uuid` (a world from a server, a Realms download) the owner loads their
        // own file, not another player's (`PlayerList.loadPlayerData`): `load_owner` does.
    // rust: let uuid = uuid_from_tag(data.get("singleplayer_uuid"));
    // rust: let player_dir = dir.join("players").join("data");
        // PlayerDataStorage.load: the player's file, else its .dat_old.
    // rust: let owner = uuid.and_then(|u| {
    // rust: let name = uuid_text(u);
    // rust: read_dat(&player_dir.join(format!("{name}.dat")))
    // rust: .or_else(|| read_dat(&player_dir.join(format!("{name}.dat_old"))))
    // rust: });
    // rust: level.singleplayer_file = owner.is_some();
    // rust: let player = owner.or_else(|| data.get("Player").cloned());
    // rust: level.player_uuid = uuid_from_tag(player.as_ref().and_then(|p| p.get("UUID"))).or(uuid);
    // rust: let spawn = level
    // rust: .world_spawn
    // rust: .map(|s| [f64::from(s[0]), f64::from(s[1]), f64::from(s[2])]);
    // rust: level.spawn = spawn;
    // rust: if let Some(p) = &player {
    // rust: level.read_player(p);
}
    // rust: level.player_extra = player;
    // rust: Some(level)
}
pub fn read_player(self: *Self, p: *Tag) void {
}
    // rust: let n = |k: &str| number(p.get(k));
    // rust: let f = |k: &str| float(p.get(k));
    // rust: self.position = read_doubles::<3>(p.get("Pos"));
    // rust: if let Some(r) = read_doubles::<2>(p.get("Rotation")) {
    // rust: self.rotation = [r[0] as f32, r[1] as f32];
}
    // rust: self.motion = read_doubles::<3>(p.get("Motion")).unwrap_or_default();
    // rust: self.health = f("Health").map_or(20.0, |v| v as f32);
    // rust: self.absorption = f("AbsorptionAmount").map_or(0.0, |v| v as f32);
    // rust: self.food = n("foodLevel").map_or(20, |v| v as i32);
    // rust: self.saturation = f("foodSaturationLevel").map_or(5.0, |v| v as f32);
    // rust: self.food_exhaustion = f("foodExhaustionLevel").unwrap_or(0.0) as f32;
    // rust: self.food_tick_timer = n("foodTickTimer").unwrap_or(0) as i32;
    // rust: self.xp_level = n("XpLevel").unwrap_or(0) as i32;
    // rust: self.xp_progress = f("XpP").unwrap_or(0.0) as f32;
    // rust: self.xp_total = n("XpTotal").unwrap_or(0) as i32;
    // rust: self.selected_slot = n("SelectedItemSlot").unwrap_or(0) as i32;
    // rust: self.fall_distance = f("fall_distance").unwrap_or(0.0);
    // rust: self.on_ground = n("OnGround").unwrap_or(0) != 0;
    // rust: self.seen_credits = n("seenCredits").unwrap_or(0) != 0;
    // rust: self.post_effects = match p.get("post_effects") {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .filter_map(|t| match t {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
    // rust: _ => None,
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: self.last_death = p.get("LastDeathLocation").and_then(|d| {
    // rust: let Some(Tag::IntArray(pos)) = d.get("pos") else {
    // rust: return None;
}
    // rust: Some((
    // rust: text(d.get("dimension"))?,
    // rust: [*pos.first()?, *pos.get(1)?, *pos.get(2)?],
    // rust: ))
    // rust: });
    // rust: if let Some(mode) = n("playerGameType") {
    // rust: self.creative = mode == 1;
    // rust: self.game_mode = mode as i32;
}
    // rust: self.previous_game_mode = n("previousPlayerGameType").map(|m| m as i32);
    // rust: self.flying = p
    // rust: .get("abilities")
    // rust: .and_then(|a| number(a.get("flying")))
    // rust: .is_some_and(|v| v != 0);
    // rust: self.fly_speed = p
    // rust: .get("abilities")
    // rust: .and_then(|a| float(a.get("flySpeed")))
    // rust: .map(|v| v as f32);
    // rust: if let Some(d) = text(p.get("Dimension")) {
    // rust: self.dimension = d;
}
    // rust: if let Some(respawn) = p.get("respawn")
    // rust: && let Some(Tag::IntArray(pos)) = respawn.get("pos")
    // rust: && pos.len() == 3
    // rust: {
    // rust: let dimension =
    // rust: text(respawn.get("dimension")).unwrap_or_else(|| "minecraft:overworld".into());
    // rust: let forced = number(respawn.get("forced")).is_some_and(|v| v != 0);
            // A forced point in the Overworld (`spawnpoint`) is where the
            // player respawns; anything else (a bed, an anchor) is resolved
            // through its block then.
    // rust: if dimension == "minecraft:overworld" && forced {
    // rust: self.spawn = Some([f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2])]);
    // rust: } else {
    // rust: let yaw = match respawn.get("yaw") {
    // rust: Some(Tag::Float(b)) => f32::from_bits(*b),
    // rust: _ => 0.0,
}
    // rust: self.respawn_elsewhere = Some((dimension, [pos[0], pos[1], pos[2]], yaw, forced));
}
}
    // rust: let mut inventory = Vec::new();
    // rust: let mut inventory_components = HashMap::new();
    // rust: if let Some(Tag::List(items)) = p.get("Inventory") {
    // rust: for it in items {
    // rust: let slot = number(it.get("Slot")).unwrap_or(0) as i8 as u8;
    // rust: if let Some(stack) = item_from_nbt(it) {
    // rust: let slot = if slot as i8 == -106 { 150 } else { slot };
    // rust: if let Some(extra) = &stack.extra {
    // rust: inventory_components.insert(slot, extra.clone());
}
                    // Legacy armor slots 100..103 and offhand -106 (150).
    // rust: let slot = if slot as i8 == -106 { 150 } else { slot };
    // rust: inventory.push((slot, stack.item.to_string(), stack.count, stack.damage));
}
}
}
    // rust: if let Some(eq) = p.get("equipment") {
    // rust: for (name, slot) in [
    // rust: ("feet", 100u8),
    // rust: ("legs", 101),
    // rust: ("chest", 102),
    // rust: ("head", 103),
    // rust: ("offhand", 150),
    // rust: ] {
    // rust: if let Some(stack) = eq.get(name).and_then(item_from_nbt) {
    // rust: inventory.retain(|(s, ..)| *s != slot);
    // rust: if let Some(extra) = &stack.extra {
    // rust: inventory_components.insert(slot, extra.clone());
}
    // rust: inventory.push((slot, stack.item.to_string(), stack.count, stack.damage));
}
}
}
    // rust: self.inventory = inventory;
    // rust: self.ender_items = decode_items(p.get("EnderItems"), 27);
    // rust: self.recipe_book = crate::recipe_book::Settings::read(p.get("recipeBook"));
    // rust: self.inventory_components = inventory_components;
    // rust: self.xp_seed = n("XpSeed").unwrap_or(0) as i32;
    // rust: self.active_effects = match p.get("active_effects") {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .filter_map(|e| {
    // rust: let id = text(e.get("id"))?;
    // rust: let get = |k: &str| number(e.get(k));
                    // `MobEffectInstance.Details` stores `amplifier` as
                    // `ExtraCodecs.UNSIGNED_BYTE`: the NBT byte is signed, and
                    // `UnsignedBytes.toInt` maps it back to 0..=255. A plain
                    // sign-extend turns 255 (byte -1) into -1, which
                    // `EffectInstance::new` then clamps to the lowest level.
    // rust: let amplifier = match e.get("amplifier") {
    // rust: Some(Tag::Byte(v)) => i32::from(*v as u8),
    // rust: other => number(other).unwrap_or(0) as i32,
}
    // rust: Some((
    // rust: id,
    // rust: get("duration").unwrap_or(0) as i32,
    // rust: amplifier,
    // rust: get("ambient").unwrap_or(0) != 0,
    // rust: get("show_particles").is_none_or(|v| v != 0),
    // rust: ))
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
        // ServerPlayer.saveParentVehicle: the mount the player rides, by
        // UUID; the vehicle tree stays in the raw compound until it is back.
    // rust: self.root_vehicle = p
    // rust: .get("RootVehicle")
    // rust: .and_then(|r| uuid_from_tag(r.get("Attach")));
}
    /// The player compound: the loaded one with Horizon's state written over it.
pub fn player_tag(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = compound_or_empty(self.player_extra.clone());
        // Keys rewritten from scratch.
    // rust: if let Tag::Compound(map) = &mut p {
    // rust: for key in [
    // rust: "Inventory",
    // rust: "EnderItems",
    // rust: "equipment",
    // rust: "active_effects",
    // rust: "post_effects",
    // rust: "Pos",
    // rust: "respawn",
    // rust: "recipeBook",
    // rust: "LastDeathLocation",
    // rust: "previousPlayerGameType",
    // rust: ] {
    // rust: map.remove(&JavaString::from(key));
}
}
    // rust: let mut inventory = Vec::new();
    // rust: let mut equipment = Vec::new();
    // rust: for (slot, id, count, damage) in &self.inventory {
    // rust: let extra = self.inventory_components.get(slot).cloned();
    // rust: let stack = crate::items::ItemStack {
    // rust: item: Arc::from(id.as_str()),
    // rust: count: *count,
    // rust: damage: *damage,
    // rust: extra,
}
    // rust: match slot {
    // rust: 0..=35 => {
    // rust: let mut entries = vec![("Slot", Tag::Byte(*slot as i8))];
    // rust: entries.extend(encode_item(&stack));
    // rust: inventory.push(Tag::compound(entries));
}
    // rust: 100 => equipment.push(("feet", item_to_nbt(&stack))),
    // rust: 101 => equipment.push(("legs", item_to_nbt(&stack))),
    // rust: 102 => equipment.push(("chest", item_to_nbt(&stack))),
    // rust: 103 => equipment.push(("head", item_to_nbt(&stack))),
    // rust: 150 => equipment.push(("offhand", item_to_nbt(&stack))),
    // rust: _ => {}
}
}
        // GameType.updatePlayerAbilities.
    // rust: let mode = self.mode();
    // rust: let (creative, spectator) = (mode == 1, mode == 3);
    // rust: let mut abilities = compound_or_empty(p.get("abilities").cloned());
    // rust: for (k, v) in [
    // rust: ("invulnerable", creative || spectator),
    // rust: ("mayfly", creative || spectator),
    // rust: ("instabuild", creative),
    // rust: ("mayBuild", mode < 2),
    // rust: ] {
    // rust: put(&mut abilities, k, Tag::Byte(i8::from(v)));
}
    // rust: if spectator {
    // rust: put(&mut abilities, "flying", Tag::Byte(1));
    // rust: } else if creative {
    // rust: put(&mut abilities, "flying", Tag::Byte(i8::from(self.flying)));
    // rust: } else {
    // rust: put(&mut abilities, "flying", Tag::Byte(0));
}
    // rust: if let Tag::Compound(map) = &mut abilities {
    // rust: map.entry("mayBuild".into()).or_insert(Tag::Byte(1));
    // rust: if let Some(speed) = self.fly_speed {
    // rust: map.insert("flySpeed".into(), Tag::Float(speed.to_bits()));
}
    // rust: map.entry("flySpeed".into())
    // rust: .or_insert(Tag::Float(0.05f32.to_bits()));
    // rust: map.entry("walkSpeed".into())
    // rust: .or_insert(Tag::Float(0.1f32.to_bits()));
    // rust: map.entry("flying".into()).or_insert(Tag::Byte(0));
}
    // rust: let uuid = self.player_uuid.unwrap_or([0, 0, 0, 0]);
    // rust: let mut entries: Vec<(&str, Tag)> = vec![
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: ("UUID", uuid_tag(uuid)),
    // rust: ("Rotation", floats(&self.rotation)),
    // rust: ("Motion", doubles(&self.motion)),
    // rust: ("OnGround", Tag::Byte(i8::from(self.on_ground))),
    // rust: ("fall_distance", Tag::Double(self.fall_distance.to_bits())),
    // rust: ("Health", Tag::Float(self.health.to_bits())),
    // rust: ("AbsorptionAmount", Tag::Float(self.absorption.to_bits())),
    // rust: ("foodLevel", Tag::Int(self.food)),
    // rust: ("foodSaturationLevel", Tag::Float(self.saturation.to_bits())),
    // rust: (
    // rust: "foodExhaustionLevel",
    // rust: Tag::Float(self.food_exhaustion.to_bits()),
    // rust: ),
    // rust: ("foodTickTimer", Tag::Int(self.food_tick_timer)),
    // rust: ("XpLevel", Tag::Int(self.xp_level)),
    // rust: ("XpP", Tag::Float(self.xp_progress.to_bits())),
    // rust: ("XpTotal", Tag::Int(self.xp_total)),
    // rust: ("SelectedItemSlot", Tag::Int(self.selected_slot)),
    // rust: ("XpSeed", Tag::Int(self.xp_seed)),
    // rust: (
    // rust: "active_effects",
    // rust: Tag::List(
    // rust: self.active_effects
    // rust: .iter()
    // rust: .map(|(id, duration, amplifier, ambient, particles)| {
    // rust: Tag::compound([
    // rust: ("id", string(id)),
    // rust: ("duration", Tag::Int(*duration)),
                                // Same unsigned byte the codec writes:
                                // `Mth.clamp` to 0..=255, then `byteValue`.
    // rust: (
    // rust: "amplifier",
    // rust: Tag::Byte((*amplifier).clamp(0, 255) as u8 as i8),
    // rust: ),
    // rust: ("ambient", Tag::Byte(i8::from(*ambient))),
    // rust: ("show_particles", Tag::Byte(i8::from(*particles))),
    // rust: ("show_icon", Tag::Byte(i8::from(*particles))),
    // rust: ])
    // rust: })
    // rust: .collect(),
    // rust: ),
    // rust: ),
    // rust: ("playerGameType", Tag::Int(self.mode())),
    // rust: ("Inventory", Tag::List(inventory)),
    // rust: ("EnderItems", encode_items(&self.ender_items)),
    // rust: ("recipeBook", self.recipe_book.write()),
    // rust: ("abilities", abilities),
    // rust: (
    // rust: "Dimension",
    // rust: string(if self.dimension.is_empty() {
    // rust: "minecraft:overworld"
    // rust: } else {
    // rust: &self.dimension
    // rust: }),
    // rust: ),
    // rust: ];
        // LivingEntity.addAdditionalSaveData omits empty equipment and an empty
        // effect list. PlayerEquipment.isEmpty also counts the selected hotbar
        // item, which the codec never writes: holding one saves `equipment: {}`.
    // rust: let holding = self
    // rust: .inventory
    // rust: .iter()
    // rust: .any(|(slot, _, count, _)| i32::from(*slot) == self.selected_slot && *count > 0);
    // rust: if holding || !equipment.is_empty() {
    // rust: entries.push(("equipment", Tag::compound(equipment)));
}
    // rust: if self.active_effects.is_empty() {
    // rust: entries.retain(|(key, _)| *key != "active_effects");
}
    // rust: if let Some(pos) = self.position {
    // rust: entries.push(("Pos", doubles(&pos)));
}
    // rust: entries.push(("seenCredits", Tag::Byte(i8::from(self.seen_credits))));
        // `output.store` writes the list even when it is empty.
    // rust: entries.push((
    // rust: "post_effects",
    // rust: Tag::List(self.post_effects.iter().map(|e| string(e)).collect()),
    // rust: ));
    // rust: if let Some((dimension, pos)) = &self.last_death {
    // rust: entries.push((
    // rust: "LastDeathLocation",
    // rust: Tag::compound([
    // rust: ("dimension", string(dimension)),
    // rust: ("pos", Tag::IntArray(pos.to_vec())),
    // rust: ]),
    // rust: ));
}
        // A respawn point other than the world spawn: an anchor elsewhere, or a bed.
    // rust: if let Some((dimension, block, yaw, forced)) = &self.respawn_elsewhere {
    // rust: let mut respawn = vec![
    // rust: ("dimension", string(dimension)),
    // rust: ("pos", Tag::IntArray(block.to_vec())),
    // rust: ("yaw", Tag::Float(yaw.to_bits())),
    // rust: ("pitch", Tag::Float(0f32.to_bits())),
    // rust: ];
    // rust: if *forced {
    // rust: respawn.push(("forced", Tag::Byte(1)));
}
    // rust: entries.push(("respawn", Tag::compound(respawn)));
    // rust: } else if let Some(s) = self.spawn {
    // rust: let block = [
    // rust: s[0].floor() as i32,
    // rust: s[1].floor() as i32,
    // rust: s[2].floor() as i32,
    // rust: ];
            // A point of the player's own in the Overworld other than a bed
            // (`respawn_elsewhere`): `spawnpoint`'s, forced.
    // rust: if Some(block) != self.world_spawn {
    // rust: entries.push((
    // rust: "respawn",
    // rust: Tag::compound([
    // rust: ("dimension", string("minecraft:overworld")),
    // rust: ("pos", Tag::IntArray(block.to_vec())),
    // rust: ("yaw", Tag::Float(0f32.to_bits())),
    // rust: ("pitch", Tag::Float(0f32.to_bits())),
    // rust: ("forced", Tag::Byte(1)),
    // rust: ]),
    // rust: ));
}
}
        // ServerPlayer.storeGameTypes: storeNullable, so absent without one.
    // rust: if let Some(mode) = self.previous_game_mode {
    // rust: entries.push(("previousPlayerGameType", Tag::Int(mode)));
}
    // rust: for (key, value) in entries {
    // rust: put(&mut p, key, value);
}
    // rust: if let Tag::Compound(map) = &mut p {
    // rust: for (key, value) in [
    // rust: ("Air", Tag::Short(300)),
    // rust: ("Fire", Tag::Short(-20)),
    // rust: ("Invulnerable", Tag::Byte(0)),
    // rust: ("PortalCooldown", Tag::Int(0)),
    // rust: ("Score", Tag::Int(0)),
    // rust: ("SleepTimer", Tag::Short(0)),
    // rust: ("XpSeed", Tag::Int(0)),
    // rust: ("seenCredits", Tag::Byte(0)),
    // rust: ("HurtTime", Tag::Short(0)),
    // rust: ("DeathTime", Tag::Short(0)),
    // rust: ("FallFlying", Tag::Byte(0)),
    // rust: ] {
    // rust: map.entry(key.into()).or_insert(value);
}
}
        // ServerPlayer.saveParentVehicle: the savers put the whole
        // RootVehicle in the compound; a mount known by UUID alone (older
        // Horizon files) is still named.
    // rust: if let Some(vehicle) = self.root_vehicle
    // rust: && p.get("RootVehicle").is_none()
    // rust: {
    // rust: put(
    // rust: &mut p,
    // rust: "RootVehicle",
    // rust: Tag::compound([("Attach", uuid_tag(vehicle))]),
    // rust: );
}
    // rust: p
}
    /// Write every file; a world without a player UUID gets a random one.
pub fn write(self: *Self, dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.write_internal(dir, true)
}

    /// Dedicated servers save connected players separately.
pub fn write_without_player(self: *Self, dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.write_internal(dir, false)
}

    /// The player's file alone, `players/data/<singleplayer_uuid>.dat`
    /// (`PlayerDataStorage.save`): the one level.dat names.
pub fn write_player(self: *Self, dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let uuid = self.ensure_player_uuid();
    // rust: let player_file = dir
    // rust: .join("players")
    // rust: .join("data")
    // rust: .join(format!("{}.dat", uuid_text(uuid)));
    // rust: back_up_unreadable_player(&player_file);
    // rust: write_dat(&player_file, self.player_tag())
}

pub fn write_internal(self: *Self, dir: *Path, write_player: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fs::create_dir_all(dir)?;
    // rust: restore_level_dat(dir);
    // rust: let existing = read_dat(&dir.join("level.dat")).and_then(|r| r.get("Data").cloned());
    // rust: let legacy = existing
    // rust: .as_ref()
    // rust: .is_some_and(|d| d.get("Player").is_some() || d.get("WorldGenSettings").is_some());
    // rust: let mut data = compound_or_empty(existing);
    // rust: if let Tag::Compound(map) = &mut data {
            // Pre-26.3 keys now stored elsewhere (a legacy Horizon level.dat).
    // rust: for key in [
    // rust: "Player",
    // rust: "WorldGenSettings",
    // rust: "DayTime",
    // rust: "SpawnX",
    // rust: "SpawnY",
    // rust: "SpawnZ",
    // rust: "SpawnAngle",
    // rust: "clearWeatherTime",
    // rust: "rainTime",
    // rust: "thunderTime",
    // rust: "raining",
    // rust: "thundering",
    // rust: "Difficulty",
    // rust: "hardcore",
    // rust: "GameRules",
    // rust: "DimensionData",
    // rust: "WanderingTraderSpawnChance",
    // rust: "WanderingTraderSpawnDelay",
    // rust: "WanderingTraderId",
    // rust: "BorderCenterX",
    // rust: "BorderCenterZ",
    // rust: "BorderSize",
    // rust: "BorderSafeZone",
    // rust: "BorderWarningBlocks",
    // rust: "BorderWarningTime",
    // rust: "BorderSizeLerpTime",
    // rust: "BorderSizeLerpTarget",
    // rust: "BorderDamagePerBlock",
    // rust: "DifficultyLocked",
    // rust: "ScheduledEvents",
    // rust: "CustomBossEvents",
    // rust: "DragonFight",
    // rust: ] {
    // rust: map.remove(&JavaString::from(key));
}
}
    // rust: let uuid = self.ensure_player_uuid();
        // A new world's first spawn point is its world spawn.
    // rust: if self.world_spawn.is_none() {
    // rust: self.world_spawn = self.spawn.map(|s| {
    // rust: [
    // rust: s[0].floor() as i32,
    // rust: s[1].floor() as i32,
    // rust: s[2].floor() as i32,
    // rust: ]
    // rust: });
}
    // rust: let spawn = self.world_spawn.unwrap_or([0, 64, 0]);
    // rust: let mut history: Vec<Tag> = match data.get("version_history") {
    // rust: Some(Tag::List(l)) => l.clone(),
    // rust: _ => Vec::new(),
}
    // rust: if history.last() != Some(&Tag::Int(DATA_VERSION)) {
    // rust: history.push(Tag::Int(DATA_VERSION));
}
    // rust: let mut brands: Vec<Tag> = match data.get("ServerBrands") {
    // rust: Some(Tag::List(l)) => l.clone(),
    // rust: _ => Vec::new(),
}
    // rust: if !brands.contains(&string("horizon")) {
    // rust: brands.push(string("horizon"));
}
    // rust: let mut difficulty = compound_or_empty(data.get("difficulty_settings").cloned());
    // rust: put(
    // rust: &mut difficulty,
    // rust: "difficulty",
    // rust: string(if self.difficulty.is_empty() {
    // rust: "normal"
    // rust: } else {
    // rust: &self.difficulty
    // rust: }),
    // rust: );
    // rust: put(
    // rust: &mut difficulty,
    // rust: "hardcore",
    // rust: Tag::Byte(i8::from(self.hardcore)),
    // rust: );
    // rust: put(
    // rust: &mut difficulty,
    // rust: "locked",
    // rust: Tag::Byte(i8::from(self.difficulty_locked)),
    // rust: );
    // rust: let now = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis() as i64);
    // rust: for (key, value) in [
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "Version",
    // rust: Tag::compound([
    // rust: ("Name", string(VERSION_NAME)),
    // rust: ("Id", Tag::Int(DATA_VERSION)),
    // rust: ("Snapshot", Tag::Byte(0)),
    // rust: ("Series", string("main")),
    // rust: ]),
    // rust: ),
    // rust: ("version_history", Tag::List(history)),
    // rust: ("version", Tag::Int(19133)),
    // rust: ("LevelName", string(&self.name)),
    // rust: ("GameType", Tag::Int(self.mode())),
    // rust: ("Time", Tag::Long(self.time)),
    // rust: ("LastPlayed", Tag::Long(now)),
    // rust: (
    // rust: "spawn",
    // rust: Tag::compound([
    // rust: ("pos", Tag::IntArray(spawn.to_vec())),
    // rust: ("dimension", string("minecraft:overworld")),
    // rust: ("yaw", Tag::Float(self.world_spawn_angle[0].to_bits())),
    // rust: ("pitch", Tag::Float(self.world_spawn_angle[1].to_bits())),
    // rust: ]),
    // rust: ),
    // rust: ("difficulty_settings", difficulty),
    // rust: ("initialized", Tag::Byte(1)),
    // rust: ("singleplayer_uuid", uuid_tag(uuid)),
    // rust: ("ServerBrands", Tag::List(brands)),
    // rust: ] {
    // rust: put(&mut data, key, value);
}
    // rust: if let Tag::Compound(map) = &mut data {
    // rust: map.entry("allowCommands".into()).or_insert(Tag::Byte(0));
    // rust: if let Some(allow) = self.allow_commands {
    // rust: map.insert("allowCommands".into(), Tag::Byte(i8::from(allow)));
}
    // rust: map.entry("WasModded".into()).or_insert(Tag::Byte(0));
            // lenientOptionalFieldOf("enabled_features", DEFAULT_FLAGS): the
            // tag is left out when the set is vanilla's default, so a
            // `["minecraft:vanilla"]`-only list does not reach the file.
    // rust: let vanilla_only = self.enabled_features == ["minecraft:vanilla"];
    // rust: if !self.enabled_features.is_empty() && !vanilla_only {
    // rust: map.insert(
    // rust: "enabled_features".into(),
    // rust: Tag::List(self.enabled_features.iter().map(|s| string(s)).collect()),
    // rust: );
}
    // rust: map.entry("DataPacks".into()).or_insert_with(|| {
    // rust: let (enabled, disabled) = self.data_packs.clone().unwrap_or_else(|| {
    // rust: (
    // rust: vec!["vanilla".into()],
    // rust: [
    // rust: "minecart_improvements",
    // rust: "redstone_experiments",
    // rust: "trade_rebalance",
    // rust: ]
    // rust: .iter()
    // rust: .map(|s| s.to_string())
    // rust: .collect(),
    // rust: )
    // rust: });
    // rust: let list = |ids: Vec<String>| Tag::List(ids.iter().map(|s| string(s)).collect());
    // rust: Tag::compound([("Enabled", list(enabled)), ("Disabled", list(disabled))])
    // rust: });
}
        // Saved data: weather, clocks, and (when missing or legacy) world
        // generation settings and game rules.
    // rust: write_saved_data(
    // rust: dir,
    // rust: "weather",
    // rust: Tag::compound([
    // rust: ("clear_weather_time", Tag::Int(self.weather.clear_time)),
    // rust: ("rain_time", Tag::Int(self.weather.rain_time)),
    // rust: ("thunder_time", Tag::Int(self.weather.thunder_time)),
    // rust: ("raining", Tag::Byte(i8::from(self.weather.raining))),
    // rust: ("thundering", Tag::Byte(i8::from(self.weather.thundering))),
    // rust: ]),
    // rust: )?;
    // rust: let mut clocks = compound_or_empty(read_saved_data(dir, "world_clocks"));
    // rust: let mut overworld = compound_or_empty(clocks.get("minecraft:overworld").cloned());
    // rust: put(&mut overworld, "total_ticks", Tag::Long(self.day_time));
    // rust: put(&mut clocks, "minecraft:overworld", overworld);
    // rust: if let Tag::Compound(map) = &mut clocks {
    // rust: map.entry("minecraft:the_end".into())
    // rust: .or_insert_with(|| Tag::compound([("total_ticks", Tag::Long(self.time))]));
}
    // rust: write_saved_data(dir, "world_clocks", clocks)?;
    // rust: if legacy || !saved_data_path(dir, "world_gen_settings").exists() {
    // rust: write_world_gen_settings(dir, self.seed, WorldGen::default())?;
}
    // rust: if !saved_data_path(dir, "game_rules").exists() || !self.game_rules.is_empty() {
            // Only rules vanilla knows: an unknown key makes it reject the file.
    // rust: let mut rules = Tag::Compound(Compound::new());
    // rust: for (name, default) in GAME_RULES {
    // rust: let value = self.game_rules.get(name).copied().unwrap_or(default);
    // rust: let tag = if INT_RULES.contains(&name) {
    // rust: Tag::Int(value)
    // rust: } else {
    // rust: Tag::Byte(i8::from(value != 0))
}
    // rust: put(&mut rules, &format!("minecraft:{name}"), tag);
}
    // rust: if self
    // rust: .enabled_features
    // rust: .iter()
    // rust: .any(|f| f == crate::gamerules::MINECART_IMPROVEMENTS)
    // rust: {
    // rust: let rule = &crate::gamerules::MAX_MINECART_SPEED;
    // rust: let crate::gamerules::Value::Int(default) = rule.default else {
    // rust: unreachable!()
}
    // rust: let value = self
    // rust: .game_rules
    // rust: .get(rule.name)
    // rust: .copied()
    // rust: .filter(|v| (rule.min..=rule.max).contains(v))
    // rust: .unwrap_or(default);
    // rust: put(
    // rust: &mut rules,
    // rust: &format!("minecraft:{}", rule.name),
    // rust: Tag::Int(value),
    // rust: );
}
    // rust: write_saved_data(dir, "game_rules", rules)?;
}
    // rust: if write_player {
    // rust: self.write_player(dir)?;
}
    // rust: write_dat(&dir.join("level.dat"), Tag::compound([("Data", data)]))?;
    // rust: Ok(())
}
}
/// Loads saved chunks before falling back to generation.
pub const Persistent = struct {
    inner: *G,
    save: *SaveDir,
    registry: *crate::assets::Assets,
    biomes: *Biomes,
};
    // rust: type LodSurfaces = Arc<[crate::lod::Column; 256]>;
/// The coarsest far tile spacing whose columns read saved chunks: 16 blocks
/// a column, and 4 with Reduced far detail (`LodSampler::set_approximate`).
pub const SAVED_LOD_STRIDE: i32 = 16;
pub const SAVED_LOD_STRIDE_REDUCED: i32 = 4;
pub const SavedLodSampler = struct {
    generator: *Persistent<G>,
    inner: *dyn crate::streaming::LodSampler,
    cache: std::collections::VecDeque<((i32,
    details: std.ArrayList(crate::streaming::LodDetail),
    /// Reduced far detail: saved chunks only in tiles up to
    /// `SAVED_LOD_STRIDE_REDUCED` blocks a column.
    approximate: bool,
    /// Chunks the generator decorated for far terrain alone, kept from
    /// earlier sessions; saved chunks take precedence over them.
    generated: *crate::lod::cache::DiskCache,
};
    // rust: impl<G: ChunkGenerator> SavedLodSampler<G> {
pub fn saved_columns(self: *Self, key: (i32) void {
}
    // rust: let cached = match self.cache.iter().position(|(at, _)| *at == key) {
    // rust: Some(index) => self.cache.remove(index).unwrap(),
    // rust: None => (
    // rust: key,
    // rust: self.generator.save.lod_surfaces_shared(
    // rust: key.0,
    // rust: key.1,
    // rust: &self.generator.registry,
    // rust: &self.generator.biomes,
    // rust: ),
    // rust: ),
}
    // rust: let columns = cached.1.clone();
    // rust: self.cache.push_front(cached);
    // rust: self.cache.truncate(128);
    // rust: columns
}
}
    // rust: impl<G: ChunkGenerator> crate::streaming::LodSampler for SavedLodSampler<G> {
pub fn fork(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(Box::new(Self {
    // rust: generator: self.generator.clone(),
    // rust: inner: self.inner.fork()?,
    // rust: cache: Default::default(),
    // rust: details: Vec::new(),
    // rust: approximate: self.approximate,
    // rust: generated: self.generated.clone(),
    // rust: }))
}
pub fn set_approximate(self: *Self, approximate: bool) void {
}
    // rust: self.approximate = approximate;
    // rust: self.inner.set_approximate(approximate);
}
pub fn request_detail(self: *Self, chunks: *[(i32) void {
}
    // rust: let mut missing = Vec::new();
    // rust: for &key in chunks {
            // Generated chunks from earlier sessions answer only these
            // requests: reading them for every sampled cell of a coarse tile
            // slowed sampling more than it saved.
    // rust: if let Some(columns) = self
    // rust: .saved_columns(key)
    // rust: .or_else(|| self.generated.get(key.0, key.1))
    // rust: {
    // rust: self.details.push((key, columns));
    // rust: } else {
    // rust: missing.push(key);
}
}
    // rust: self.inner.request_detail(&missing, center);
}
pub fn drain_details(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut details = std::mem::take(&mut self.details);
    // rust: for (key, generated) in self.inner.drain_details() {
            // A generation batch also returns neighbouring, unrequested chunks.
            // Their saved builds must take precedence too.
    // rust: let columns = self.saved_columns(key).unwrap_or_else(|| {
    // rust: self.generated.put(key.0, key.1, &generated);
    // rust: generated
    // rust: });
    // rust: details.push((key, columns));
}
    // rust: details
}
pub fn grid(self: *Self, x: i32, z: i32, stride: i32, side: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut columns = self.inner.grid(x, z, stride, side);
        // Saved chunks show in tiles up to 16 blocks a column. With Reduced far
        // detail only up to 4 (within about a kilometre): coarser tiles keep
        // the generator's terrain, which saved chunks were made from, since
        // decoding up to 256 saved chunks for each of them held the whole far
        // view back for minutes in large saves. Edits that far away show once
        // their tiles refine on approach.
    // rust: let limit = if self.approximate {
    // rust: SAVED_LOD_STRIDE_REDUCED
    // rust: } else {
    // rust: SAVED_LOD_STRIDE
}
    // rust: if stride <= limit {
    // rust: for (index, column) in columns.iter_mut().enumerate() {
    // rust: let (wx, wz) = (
    // rust: x + (index % side) as i32 * stride,
    // rust: z + (index / side) as i32 * stride,
    // rust: );
    // rust: if let Some(saved) = self.saved_columns((wx >> 4, wz >> 4)) {
    // rust: *column = crate::lod::Column::reduced(
    // rust: &saved,
    // rust: (wx & 15) as usize,
    // rust: (wz & 15) as usize,
    // rust: stride as usize,
    // rust: );
}
}
}
    // rust: columns
}
pub fn sample(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.column(x, z).surface
}
pub fn column(self: *Self, x: i32, z: i32) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.reduced_column(x, z, 1)
}
pub fn reduced_column(self: *Self, x: i32, z: i32, width: i32) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if width <= 16
    // rust: && let Some(columns) = self.saved_columns((x >> 4, z >> 4))
    // rust: {
    // rust: return crate::lod::Column::reduced(
    // rust: &columns,
    // rust: (x & 15) as usize,
    // rust: (z & 15) as usize,
    // rust: width as usize,
    // rust: );
}
    // rust: self.inner.reduced_column(x, z, width)
}
}

/// Read one palette index without expanding the other entries in the section.
    // rust: fn lod_palette_index(
    // rust: container: &Tag,
    // rust: index: usize,
    // rust: entries: usize,
    // rust: minimum_bits: u32,
    // rust: ) -> Option<usize> {
    // rust: let Tag::List(palette) = container.get("palette")? else {
    // rust: return None;
}
    // rust: if palette.is_empty() || palette.len() > entries || index >= entries {
    // rust: return None;
}
    // rust: if palette.len() == 1 {
    // rust: return Some(0);
}
    // rust: let bits = (usize::BITS - (palette.len() - 1).leading_zeros()).max(minimum_bits);
    // rust: let per_word = 64 / bits as usize;
    // rust: let Tag::LongArray(data) = container.get("data")? else {
    // rust: return None;
}
    // rust: if data.len() != entries.div_ceil(per_word) {
    // rust: return None;
}
    // rust: let value = ((data[index / per_word] as u64 >> ((index % per_word) * bits as usize))
    // rust: & ((1 << bits) - 1)) as usize;
    // rust: (value < palette.len()).then_some(value)
}
pub fn lod_light_layers(sections: *[(i32) void {
}
    // rust: let mut layers = vec![(None, None); layout.sections()];
    // rust: for &(y, section) in sections {
    // rust: let layer = |name: &str| match section.get(name) {
    // rust: Some(Tag::ByteArray(data)) if data.len() == 2048 => Some(&data[..]),
    // rust: _ => None,
}
    // rust: layers[(y - (layout.min_y() >> 4)) as usize] = (
    // rust: if sky_light { layer("SkyLight") } else { None },
    // rust: layer("BlockLight"),
    // rust: );
}
    // rust: let mut light = vec![0u8; layout.sections() * 4096].into_boxed_slice();
    // rust: let mut above = [if sky_light { 15u8 } else { 0 }; 256];
    // rust: let nibble = |data: &[u8], index: usize| (data[index / 2] >> ((index & 1) * 4)) & 15;
    // rust: for si in (0..layout.sections()).rev() {
    // rust: let (sky, block) = layers[si];
    // rust: let section = &mut light[si * 4096..(si + 1) * 4096];
    // rust: for (index, value) in section.iter_mut().enumerate() {
    // rust: *value = sky.map_or(above[index & 255], |data| nibble(data, index)) << 4
    // rust: | block.map_or(0, |data| nibble(data, index));
}
        // Missing sky layers inherit the bottom layer above, as load_light does.
    // rust: for (index, value) in above.iter_mut().enumerate() {
    // rust: *value = section[index] >> 4;
}
}
    // rust: light
}
pub fn lod_face_light(light: []const u8, x: usize, y: usize, z: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = y * 256 + z * 16 + x;
    // rust: let mut sky = light[index] >> 4;
    // rust: let mut block = light[index] & 15;
    // rust: for (valid, index) in [
    // rust: (x > 0, index.wrapping_sub(1)),
    // rust: (x < 15, index + 1),
    // rust: (z > 0, index.wrapping_sub(16)),
    // rust: (z < 15, index + 16),
    // rust: (y > 0, index.wrapping_sub(256)),
    // rust: (index + 256 < light.len(), index + 256),
    // rust: ] {
    // rust: if valid {
    // rust: sky = sky.max(light[index] >> 4);
    // rust: block = block.max(light[index] & 15);
}
}
    // rust: u16::from(sky) << 4 | u16::from(block) << 12
}
    // rust: fn decode_lod_surfaces(
    // rust: root: &NamedTag,
    // rust: assets: &crate::assets::Assets,
    // rust: biomes: &Biomes,
    // rust: layout: ColumnLayout,
    // rust: sky_light: bool,
    // rust: ) -> Option<LodSurfaces> {
    // rust: let Tag::List(sections) = root.tag.get("sections")? else {
    // rust: return None;
}
    // rust: let water_state = assets.registry.default_state("minecraft:water");
    // rust: let mut sections: Vec<_> = sections
    // rust: .iter()
    // rust: .filter_map(|section| {
    // rust: let y = number(section.get("Y"))? as i32;
    // rust: layout
    // rust: .section_index(y * 16)
    // rust: .is_some()
    // rust: .then_some((y, section))
    // rust: })
    // rust: .collect();
    // rust: sections.sort_unstable_by_key(|(y, _)| std::cmp::Reverse(*y));
    // rust: let mut columns: Box<[crate::lod::Column; 256]> =
    // rust: Box::new(std::array::from_fn(|_| crate::lod::Column {
    // rust: surface: None,
    // rust: spans: crate::lod::Spans::new(),
    // rust: }));
    // rust: let mut water = [None; 256];
    // rust: let light = lod_light_layers(&sections, layout, sky_light);
    // rust: let mut states = BTreeMap::new();
    // rust: for (section_y, section) in sections {
    // rust: if let Some(blocks) = section.get("block_states") {
    // rust: let Tag::List(palette) = blocks.get("palette")? else {
    // rust: return None;
}
            // Resolve each state once per palette, rather than parsing NBT for every block.
    // rust: let palette: Vec<_> = palette
    // rust: .iter()
    // rust: .map(|entry| {
    // rust: let descriptor = BlockState::from_nbt(entry).ok()?;
    // rust: let state = *states.entry(descriptor.clone()).or_insert_with(|| {
    // rust: assets
    // rust: .registry
    // rust: .id(&descriptor)
    // rust: .or_else(|| assets.registry.default_state(&descriptor.name))
    // rust: });
    // rust: Some(state.map(|state| {
    // rust: let properties = assets.properties.heightmap_state(state);
    // rust: let fluid = matches!(
    // rust: descriptor.name.as_str(),
    // rust: "minecraft:water" | "minecraft:lava"
    // rust: );
                        // Chorus is thin and non-solid but still far-End detail.
    // rust: let chorus = matches!(
    // rust: descriptor.name.as_str(),
    // rust: "minecraft:chorus_plant" | "minecraft:chorus_flower"
    // rust: );
    // rust: let solid = properties.blocks_motion_in_heightmap();
                        // Kelp and seagrass: the water they hold. Left out, the
                        // water stopped short where they reach the surface.
    // rust: match water_state {
    // rust: Some(water) if !fluid && !solid && properties.has_fluid() => {
    // rust: (water, true, true)
}
    // rust: _ => (state, fluid, fluid || solid || chorus),
}
    // rust: }))
    // rust: })
    // rust: .collect::<Option<_>>()?;
    // rust: let biome_palette: Vec<_> = section
    // rust: .get("biomes")
    // rust: .and_then(|container| match container.get("palette")? {
    // rust: Tag::List(palette) => Some(palette),
    // rust: _ => None,
    // rust: })
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|entry| match entry {
    // rust: Tag::String(name) => biomes.id(&name.to_string_lossy()),
    // rust: _ => 0,
    // rust: })
    // rust: .collect();
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: let cell = z * 16 + x;
    // rust: let column = &mut columns[cell];
    // rust: for y in (0..16).rev() {
    // rust: let index = y * 256 + cell;
    // rust: let palette_index = lod_palette_index(blocks, index, 4096, 4)?;
    // rust: let Some((state, fluid, kept)) = palette[palette_index] else {
    // rust: continue;
}
    // rust: if !kept {
    // rust: continue;
}
    // rust: let biome = section
    // rust: .get("biomes")
    // rust: .and_then(|container| {
    // rust: lod_palette_index(
    // rust: container,
    // rust: (y / 4) * 16 + (z / 4) * 4 + x / 4,
    // rust: 64,
    // rust: 1,
    // rust: )
    // rust: })
    // rust: .and_then(|index| biome_palette.get(index))
    // rust: .copied()
    // rust: .unwrap_or(0);
    // rust: let height = section_y * 16 + y as i32 + 1;
    // rust: if column.surface.is_none() {
    // rust: if fluid {
    // rust: water[cell].get_or_insert((height, state));
    // rust: } else {
    // rust: column.surface = Some(crate::lod::Surface {
    // rust: height,
    // rust: state,
    // rust: water: water[cell],
    // rust: biome,
    // rust: });
}
}
    // rust: let light =
    // rust: lod_face_light(&light, x, (height - 1 - layout.min_y()) as usize, z);
    // rust: let min = (height - 1) as i16;
    // rust: let max = height as i16;
    // rust: if let Some(previous) = column.spans.last_mut()
    // rust: && previous.min == max
    // rust: && (previous.state, previous.biome, previous.light)
    // rust: == (state, biome, light)
    // rust: {
    // rust: previous.min = min;
    // rust: } else {
    // rust: column.spans.push(crate::lod::Span {
    // rust: min,
    // rust: max,
    // rust: state,
    // rust: biome,
    // rust: light,
    // rust: });
}
}
}
}
}
}
    // Spans are pushed top down, so the reverse puts the topmost last, as
    // `Column::from_chunk` leaves them. Water keeps the chunk's own light,
    // a level less per block, as the generator's far columns shade it.
    // rust: for column in &mut *columns {
    // rust: column.spans.reverse();
}
    // rust: Some(Arc::from(columns))
}

    // rust: impl SaveDir {
    /// `lod_surfaces`, decoded once for all far sampling threads: each saved
    /// chunk lies under far tiles of several levels, sampled on any thread.
    // rust: fn lod_surfaces_shared(
    // rust: &self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: assets: &crate::assets::Assets,
    // rust: biomes: &Biomes,
    // rust: ) -> Option<LodSurfaces> {
    // rust: if let Some((at, columns)) = self.lod_decoded.lock().unwrap().chunks.get(&(x, z))
    // rust: && at.elapsed() < LOD_DECODED_TTL
    // rust: {
    // rust: return Some(columns.clone());
}
    // rust: let columns = self.lod_surfaces(x, z, assets, biomes)?;
    // rust: let mut decoded = self.lod_decoded.lock().unwrap();
    // rust: let fresh = (std::time::Instant::now(), columns.clone());
    // rust: if decoded.chunks.insert((x, z), fresh).is_none() {
    // rust: decoded.order.push_back((x, z));
    // rust: while decoded.order.len() > LOD_DECODED {
    // rust: if let Some(old) = decoded.order.pop_front() {
    // rust: decoded.chunks.remove(&old);
}
}
}
    // rust: Some(columns)
}
    // rust: fn lod_surfaces(
    // rust: &self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: assets: &crate::assets::Assets,
    // rust: biomes: &Biomes,
    // rust: ) -> Option<LodSurfaces> {
    // rust: let pending = self
    // rust: .pending
    // rust: .lock()
    // rust: .ok()?
    // rust: .get(&(Folder::Region, x, z))
    // rust: .map(|(_, record)| record.clone());
    // rust: let root = if let Some(record) = pending {
    // rust: record.tag().map(|tag| (*tag).clone())?
    // rust: } else {
    // rust: if !self.lod_saved(x, z) {
    // rust: return None;
}
            // Far-only reads must not populate the gameplay region cache across the whole view.
    // rust: let mut region = RegionFile::open(self.region_path("region", x >> 5, z >> 5)).ok()?;
    // rust: let mut root = region
    // rust: .read(ChunkPos::new(x, z))
    // rust: .ok()??
    // rust: .nbt(Limits::default())
    // rust: .ok()?;
    // rust: self.upgrade_record(Folder::Region, &mut root).ok()?;
    // rust: root
}
        // Proto saves may still be missing decoration from their neighbors.
    // rust: if text(root.tag.get("Status"))
    // rust: .is_some_and(|status| status != "minecraft:full" && status != "full")
    // rust: {
    // rust: return None;
}
    // rust: decode_lod_surfaces(
    // rust: &root,
    // rust: assets,
    // rust: biomes,
    // rust: self.shape.column(),
    // rust: self.shape.sky_light,
    // rust: )
}
}

    // rust: impl<G: ChunkGenerator> ChunkGenerator for Persistent<G> {
    // rust: type Worker = G::Worker;
pub fn worker(self: *Self) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.worker()
}
pub fn lod_sampler(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let inner = ChunkGenerator::lod_sampler(self.inner.clone());
    // rust: let generated = Arc::new(crate::lod::cache::DiskCache::new(
    // rust: self.save.root.join("data/horizon_far_terrain"),
    // rust: crate::lod::cache::build_key(self.registry.registry.len(), self.biomes.list.len()),
    // rust: ));
    // rust: Box::new(SavedLodSampler {
    // rust: generator: self,
    // rust: inner,
    // rust: cache: Default::default(),
    // rust: details: Vec::new(),
    // rust: approximate: false,
    // rust: generated,
    // rust: })
}
pub fn load(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.save
    // rust: .tables
    // rust: .get_or_init(|| Arc::new(SaveTables::new(&self.registry)));
    // rust: let mut chunk = self.save.load(x, z, self.registry.registry, &self.biomes)?;
    // rust: for s in &mut chunk.sections {
    // rust: Arc::make_mut(s).compact();
}
    // rust: chunk.entities = self.save.load_entities(x, z);
    // rust: Some(chunk)
}
pub fn lod_surface(self: *Self, worker: *mut G::Worker, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
        // Resident/visited summaries override this procedural fallback in the LOD cache.
    // rust: self.inner.lod_surface(worker, x, z)
}
pub fn prepare_loaded(self: *Self, worker: *mut G::Worker, chunk: *Chunk) void {
}
    // rust: self.inner.prepare_loaded(worker, chunk);
}
pub fn all_idle(self: *Self) void {
}
    // rust: self.inner.all_idle();
}
pub fn idle(self: *Self, worker: *mut G::Worker) void {
}
    // rust: self.inner.idle(worker);
}
pub fn proto(self: *Self, worker: *mut G::Worker, x: i32, z: i32) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut proto = self.inner.proto(worker, x, z);
    // rust: if let Some(saved) = self
    // rust: .save
    // rust: .load_proto(x, z, self.registry.registry, &self.biomes)
    // rust: {
    // rust: self.inner.restore_proto(&mut proto, saved);
}
    // rust: proto
}
pub fn is_decorated(self: *Self, proto: *crate::streaming::Proto) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.is_decorated(proto)
}
pub fn light_view(self: *Self, proto: *crate::streaming::Proto) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.light_view(proto)
}
    // rust: fn non_air_sections(
    // rust: &self,
    // rust: proto: &crate::streaming::Proto,
    // rust: ) -> Option<crate::section_mask::SectionMask> {
    // rust: self.inner.non_air_sections(proto)
}
pub fn cache_census(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.cache_census()
}
pub fn proto_heap_bytes(self: *Self, proto: *crate::streaming::Proto) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.proto_heap_bytes(proto)
}
pub fn save_protos(self: *Self, protos: *[*crate::streaming::Proto]) void {
}
    // rust: self.save
    // rust: .tables
    // rust: .get_or_init(|| Arc::new(SaveTables::new(&self.registry)));
    // rust: let saved: Vec<SavedProto> = protos
    // rust: .iter()
    // rust: .filter_map(|p| self.inner.saved_proto(p))
    // rust: .collect();
    // rust: if let Err(e) = self
    // rust: .save
    // rust: .save_protos(&saved, self.registry.registry, &self.biomes)
    // rust: {
    // rust: log::warn!("Horizon: failed to save proto chunks: {e}");
}
}
pub fn save_finished(self: *Self, mut chunk: Chunk) void {
}
    // rust: self.save
    // rust: .tables
    // rust: .get_or_init(|| Arc::new(SaveTables::new(&self.registry)));
    // rust: let key = (chunk.x, chunk.z);
    // rust: let entities = std::mem::take(&mut chunk.entities);
    // rust: let saved = self
    // rust: .save
    // rust: .save_later(&[Arc::new(chunk)], self.registry.registry, &self.biomes)
    // rust: .and_then(|_| self.save.save_entities_later(vec![(key, entities)]));
    // rust: if let Err(e) = saved {
    // rust: log::warn!("Horizon: failed to save chunk {} {}: {e}", key.0, key.1);
}
}
pub fn decorates(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.decorates()
}
pub fn decorates_beside_final(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.decorates_beside_final()
}
    // rust: fn proto_beside_final(
    // rust: &self,
    // rust: worker: &mut G::Worker,
    // rust: snapshot: &Chunk,
    // rust: ) -> Option<crate::streaming::Proto> {
    // rust: self.inner.proto_beside_final(worker, snapshot)
}
    // rust: fn final_writes(
    // rust: &self,
    // rust: snapshot: &Chunk,
    // rust: proto: &crate::streaming::Proto,
    // rust: ) -> Vec<([i32; 3], u32)> {
    // rust: self.inner.final_writes(snapshot, proto)
}
    // rust: fn final_block_entities(
    // rust: &self,
    // rust: proto: &crate::streaming::Proto,
    // rust: writes: &[([i32; 3], u32)],
    // rust: ) -> Vec<((i32, i32, i32), crate::chunk::block_entity::BlockEntity)> {
    // rust: self.inner.final_block_entities(proto, writes)
}
pub fn decorate(self: *Self, worker: *mut G::Worker, region: *mut [crate::streaming::Proto; 9]) void {
}
    // rust: self.inner.decorate(worker, region);
}
pub fn finish(self: *Self, proto: crate::streaming::Proto) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.finish(proto)
}
}

/// `IOWorker.createOldDataForRegion`'s test of one record: saved before DataVersion 4997, or
/// with `blending_data`.
pub fn record_is_old(root: *NamedTag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let before_blending = match root.tag.get("DataVersion") {
    // rust: Some(Tag::Int(version)) => *version < 4997,
    // rust: _ => true,
}
    // rust: before_blending || root.tag.get("blending_data").is_some()
}
    // rust: mod tests {
//     use crate::mobs::spawner::SpawnDataExt;

pub fn a_server_falls_back_to_level_dat_old_and_restores_it() void {
}
    // rust: let world = std::env::temp_dir().join(format!("horizon-dat-old-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&world);
    // rust: fs::create_dir_all(&world).unwrap();
    // rust: let level = |name: &str| {
    // rust: Tag::compound([(
    // rust: "Data",
    // rust: Tag::compound([("LevelName", Tag::String(name.into()))]),
    // rust: )])
}
        // Both files broken, or only level.dat_old there: nothing to fall back to.
    // rust: fs::write(world.join("level.dat"), b"cut short").unwrap();
    // rust: assert!(!fall_back_to_level_dat_old(&world));
    // rust: fs::write(world.join("level.dat_old"), b"cut short").unwrap();
    // rust: assert!(!fall_back_to_level_dat_old(&world));
        // A good level.dat_old: it takes level.dat's place and the broken file is kept.
    // rust: write_dat(&world.join("level.dat_old"), level("old")).unwrap();
    // rust: assert!(fall_back_to_level_dat_old(&world));
    // rust: assert!(level_dat_issue(&world, false).is_none());
    // rust: let kept = fs::read_dir(&world)
    // rust: .unwrap()
    // rust: .filter_map(|e| e.ok())
    // rust: .filter(|e| {
    // rust: e.file_name()
    // rust: .to_string_lossy()
    // rust: .starts_with("level.dat_corrupted_")
    // rust: })
    // rust: .count();
    // rust: assert_eq!(kept, 1);
        // A readable level.dat is left alone.
    // rust: assert!(!fall_back_to_level_dat_old(&world));
    // rust: let _ = fs::remove_dir_all(&world);
}

pub fn points_of_interest_save_as_poi_sections() void {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES") else {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&PathBuf::from(root)).expect("assets");
    // rust: let tables = SaveTables::new(&assets);
    // rust: let state = |name: &str, props: &[(&str, &str)]| {
    // rust: let mut s = assets
    // rust: .registry
    // rust: .state(assets.registry.default_state(name).unwrap())
    // rust: .unwrap()
    // rust: .clone();
    // rust: for (k, v) in props {
    // rust: s.properties.insert((*k).into(), (*v).into());
}
    // rust: assets.registry.id(&s).unwrap().0
}
    // rust: let mut chunk = Chunk::empty(2, -1);
    // rust: chunk.set(1, 70, 1, state("minecraft:red_bed", &[("part", "head")]));
    // rust: chunk.set(1, 70, 2, state("minecraft:red_bed", &[("part", "foot")]));
    // rust: chunk.set(5, 71, 5, state("minecraft:bell", &[]));
    // rust: chunk.set(6, 71, 5, state("minecraft:stone", &[]));
    // rust: chunk.set(9, 70, 9, state("minecraft:straw_bed", &[("part", "head")]));
    // rust: assert!(encode_poi(&Chunk::empty(0, 0), &tables).is_none());
    // rust: let saved = encode_poi(&chunk, &tables).expect("records");
    // rust: let Some(Tag::Compound(sections)) = saved.tag.get("Sections") else {
    // rust: panic!("no sections");
}
    // rust: assert_eq!(sections.len(), 1);
    // rust: let section = &sections[&"4".into()];
    // rust: assert_eq!(section.get("Valid"), Some(&Tag::Byte(1)));
    // rust: let Some(Tag::List(records)) = section.get("Records") else {
    // rust: panic!("no records");
}
    // rust: let records: Vec<_> = records
    // rust: .iter()
    // rust: .map(|r| {
    // rust: (
    // rust: text(r.get("type")).unwrap(),
    // rust: r.get("pos").cloned(),
    // rust: number(r.get("free_tickets")),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(
    // rust: records,
    // rust: [
    // rust: (
    // rust: "minecraft:home".into(),
    // rust: Some(Tag::IntArray(vec![33, 70, -15])),
    // rust: Some(1)
    // rust: ),
    // rust: (
    // rust: "minecraft:meeting".into(),
    // rust: Some(Tag::IntArray(vec![37, 71, -11])),
    // rust: Some(32)
    // rust: ),
    // rust: ]
    // rust: );
}

pub fn a_chunk_that_loses_its_last_poi_saves_empty_sections() void {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES") else {
    // rust: return;
}
    // rust: let root = PathBuf::from(root);
    // rust: let assets = crate::assets::Assets::load(&root).expect("assets");
    // rust: let biomes = Arc::new(Biomes::load(&root).expect("biomes"));
    // rust: let bell = assets.registry.default_state("minecraft:bell").unwrap().0;
    // rust: let dir = std::env::temp_dir().join(format!("horizon-poi-save-{}", std::process::id()));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let save = SaveDir::new(dir.clone(), LevelShape::OVERWORLD);
    // rust: let _ = save.tables.set(Arc::new(SaveTables::new(&assets)));
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: chunk.set(5, 71, 5, bell);
    // rust: let sections = |save: &SaveDir| match save.read_record("poi", 0, 0)?.tag.get("Sections") {
    // rust: Some(Tag::Compound(s)) => Some(s.len()),
    // rust: _ => None,
}
    // rust: save.save_later(&[Arc::new(chunk.clone())], assets.registry, &biomes)
    // rust: .unwrap();
    // rust: save.flush().unwrap();
    // rust: assert_eq!(sections(&save), Some(1));
    // rust: chunk.set(5, 71, 5, 0);
    // rust: save.save_later(&[Arc::new(chunk)], assets.registry, &biomes)
    // rust: .unwrap();
    // rust: save.flush().unwrap();
    // rust: assert_eq!(
    // rust: sections(&SaveDir::new(dir.clone(), LevelShape::OVERWORLD)),
    // rust: Some(0)
    // rust: );
    // rust: let _ = fs::remove_dir_all(&dir);
}

pub fn saved_poi_records_keep_their_claims() void {
}
    // rust: let record = |pos: [i32; 3], kind: &str, tickets: Option<i32>| {
    // rust: let mut r = vec![("pos", Tag::IntArray(pos.to_vec())), ("type", string(kind))];
    // rust: if let Some(t) = tickets {
    // rust: r.push(("free_tickets", Tag::Int(t)));
}
    // rust: Tag::compound(r)
}
    // rust: let poi = |records: Vec<Tag>| {
    // rust: let mut sections = Compound::new();
    // rust: sections.insert(
    // rust: "4".into(),
    // rust: Tag::compound([("Valid", Tag::Byte(1)), ("Records", Tag::List(records))]),
    // rust: );
    // rust: poi_root(sections)
}
    // rust: let old = poi(vec![
    // rust: record([1, 70, 1], "minecraft:home", None),
    // rust: record([5, 71, 5], "minecraft:meeting", Some(30)),
    // rust: ]);
    // rust: let mut saved = poi(vec![
    // rust: record([1, 70, 1], "minecraft:home", Some(1)),
    // rust: record([5, 71, 5], "minecraft:meeting", Some(32)),
    // rust: record([9, 71, 9], "minecraft:home", Some(1)),
    // rust: ]);
    // rust: keep_claims(&mut saved, &old);
    // rust: let expected = poi(vec![
    // rust: record([1, 70, 1], "minecraft:home", None),
    // rust: record([5, 71, 5], "minecraft:meeting", Some(30)),
    // rust: record([9, 71, 9], "minecraft:home", Some(1)),
    // rust: ]);
    // rust: assert_eq!(saved.tag, expected.tag);
}

pub fn level_attachments_survive_save_and_load() void {
}
//         use horizon_world::attachments::{
    // rust: AttachmentCodec, AttachmentError, AttachmentType, Attachments,
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-level-attachments-{}", std::process::id()));
    // rust: let save = SaveDir::new(dir.clone(), LevelShape::OVERWORLD);
    // rust: let key = AttachmentType {
    // rust: namespace: "test",
    // rust: name: "counter",
    // rust: default: || 0,
    // rust: codec: Some(AttachmentCodec {
    // rust: encode: |n: &i32| Ok([("count".into(), Tag::Int(*n))].into()),
    // rust: decode: |c: &Compound| match c.get(&"count".into()) {
    // rust: Some(Tag::Int(n)) => Ok(*n),
    // rust: _ => Err(AttachmentError::Decode),
    // rust: },
    // rust: }),
    // rust: copy_on_death: false,
    // rust: sync: false,
}
    // rust: let mut map = Attachments::default();
    // rust: map.set(&key, 7).unwrap();
    // rust: save.save_attachments(&map).unwrap();
    // rust: assert_eq!(save.load_attachments().get(&key), Ok(7));
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

pub fn chunk_attachments_survive_save_and_load() void {
}
//         use horizon_world::attachments::{AttachmentCodec, AttachmentError, AttachmentType};
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES") else {
    // rust: return;
}
    // rust: let root = PathBuf::from(root);
    // rust: let assets = crate::assets::Assets::load(&root).expect("assets");
    // rust: let biomes = Biomes::load(&root).expect("biomes");
    // rust: let key = AttachmentType {
    // rust: namespace: "test",
    // rust: name: "counter",
    // rust: default: || 0,
    // rust: codec: Some(AttachmentCodec {
    // rust: encode: |n: &i32| Ok([("count".into(), Tag::Int(*n))].into()),
    // rust: decode: |c: &Compound| match c.get(&"count".into()) {
    // rust: Some(Tag::Int(n)) => Ok(*n),
    // rust: _ => Err(AttachmentError::Decode),
    // rust: },
    // rust: }),
    // rust: copy_on_death: false,
    // rust: sync: false,
}
    // rust: let mut chunk = Chunk::empty(2, 3);
    // rust: let mut extras = ChunkExtras::default();
    // rust: extras.attachments.set(&key, 42).unwrap();
    // rust: let mut block_data = horizon_world::attachments::Attachments::default();
    // rust: block_data.set(&key, 21).unwrap();
    // rust: let pos = (33, 64, 50);
    // rust: let chest = assets.registry.default_state("minecraft:chest").unwrap();
    // rust: chunk.set(1, 64, 2, chest.0);
    // rust: chunk
    // rust: .block_entities
    // rust: .push((pos, crate::containers::BlockEntity::Chest(vec![None; 27])));
    // rust: extras.block_entity_attachments.push((pos, block_data));
    // rust: chunk.saved = Some(Arc::new(extras));
    // rust: let saved = encode(&chunk, assets.registry, &biomes);
    // rust: let mut loaded = decode(&saved, assets.registry, &biomes).expect("chunk");
    // rust: assert_eq!(
    // rust: Arc::make_mut(loaded.saved.as_mut().unwrap())
    // rust: .attachments
    // rust: .get(&key),
    // rust: Ok(42)
    // rust: );
    // rust: let extras = Arc::make_mut(loaded.saved.as_mut().unwrap());
    // rust: assert_eq!(extras.block_entity_attachments[0].0, pos);
    // rust: assert_eq!(extras.block_entity_attachments[0].1.get(&key), Ok(21));
}

pub fn unopened_rolled_containers_save_their_loot_table() void {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES") else {
    // rust: return;
}
    // rust: let root = PathBuf::from(root);
    // rust: let assets = crate::assets::Assets::load(&root).expect("assets");
    // rust: let biomes = Biomes::load(&root).expect("biomes");
    // rust: let tables = SaveTables::new(&assets);
    // rust: let chest = assets.registry.default_state("minecraft:chest").unwrap();
    // rust: let mut slots = vec![None; 27];
    // rust: slots[3] = Some(crate::items::ItemStack::new("minecraft:bone", 2));
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: chunk.set(1, 64, 2, chest.0);
    // rust: chunk.block_entities.push((
    // rust: (1, 64, 2),
    // rust: crate::containers::BlockEntity::Chest(slots.clone()),
    // rust: ));
    // rust: let rolled = RolledLoot {
    // rust: pos: (1, 64, 2),
    // rust: table: "minecraft:chests/simple_dungeon".into(),
    // rust: seed: Some(42),
    // rust: items: encode_items(&slots),
}
    // rust: chunk.saved = Some(Arc::new(ChunkExtras {
    // rust: rolled_loot: vec![rolled],
    // rust: ..ChunkExtras::default()
    // rust: }));
    // rust: let saved_chest = |chunk: &Chunk| -> Tag {
    // rust: let saved = encode_with(
    // rust: chunk,
    // rust: assets.registry,
    // rust: &biomes,
    // rust: Some(&tables),
    // rust: LevelShape::OVERWORLD,
    // rust: );
    // rust: let Some(Tag::List(list)) = saved.tag.get("block_entities") else {
    // rust: panic!("no block entities");
}
    // rust: list[0].clone()
}
    // rust: let unopened = saved_chest(&chunk);
    // rust: assert_eq!(
    // rust: text(unopened.get("LootTable")).as_deref(),
    // rust: Some("minecraft:chests/simple_dungeon")
    // rust: );
    // rust: assert_eq!(number(unopened.get("LootTableSeed")), Some(42));
    // rust: assert!(unopened.get("Items").is_none());
        // Taking an item makes the items the container's own.
    // rust: if let crate::containers::BlockEntity::Chest(s) = &mut chunk.block_entities[0].1 {
    // rust: s[3] = None;
    // rust: s[4] = Some(crate::items::ItemStack::new("minecraft:bone", 1));
}
    // rust: let opened = saved_chest(&chunk);
    // rust: assert!(opened.get("LootTable").is_none());
    // rust: assert!(opened.get("Items").is_some());
        // Loaded with its table, rolled, then emptied: no table, or it refills on load.
    // rust: let mut extras = ChunkExtras::clone(chunk.saved.as_ref().unwrap());
    // rust: extras.block_entity_sources = vec![(
    // rust: (1, 64, 2),
    // rust: Tag::compound([
    // rust: ("id", string("minecraft:chest")),
    // rust: ("x", Tag::Int(1)),
    // rust: ("y", Tag::Int(64)),
    // rust: ("z", Tag::Int(2)),
    // rust: ("LootTable", string("minecraft:chests/simple_dungeon")),
    // rust: ("LootTableSeed", Tag::Long(42)),
    // rust: ]),
    // rust: )];
    // rust: chunk.saved = Some(Arc::new(extras));
    // rust: if let crate::containers::BlockEntity::Chest(s) = &mut chunk.block_entities[0].1 {
    // rust: s.fill(None);
}
    // rust: let emptied = saved_chest(&chunk);
    // rust: assert!(emptied.get("LootTable").is_none());
    // rust: assert!(emptied.get("LootTableSeed").is_none());
}

pub fn a_tall_level_saves_and_loads_its_whole_height() void {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES") else {
    // rust: return;
}
    // rust: let root = PathBuf::from(root);
    // rust: let assets = crate::assets::Assets::load(&root).expect("assets");
    // rust: let biomes = Biomes::load(&root).expect("biomes");
    // rust: let tables = SaveTables::new(&assets);
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
        // To The Max's Overworld: -64..2032, 131 sections.
    // rust: let shape = LevelShape::new(-64, 2096, 2096, true, false).unwrap();
    // rust: let mut chunk = Chunk::with_layout(0, 0, shape.column());
    // rust: chunk.set(0, -64, 0, stone.0);
    // rust: chunk.set(0, 2000, 0, stone.0);
    // rust: let saved = encode_with(&chunk, assets.registry, &biomes, Some(&tables), shape);
    // rust: assert_eq!(number(saved.tag.get("yPos")), Some(-4));
    // rust: let Some(Tag::List(sections)) = saved.tag.get("sections") else {
    // rust: panic!("no sections");
}
    // rust: assert_eq!(sections.len(), 131);
        // 12-bit heightmap entries: y 2000's top reads 2001 - -64.
    // rust: let Some(Tag::LongArray(surface)) = saved
    // rust: .tag
    // rust: .get("Heightmaps")
    // rust: .and_then(|h| h.get("WORLD_SURFACE"))
    // rust: else {
    // rust: panic!("no WORLD_SURFACE");
}
    // rust: assert_eq!(surface[0] & 0xfff, 2065);
    // rust: let back = decode_with(
    // rust: &saved,
    // rust: assets.registry,
    // rust: &biomes,
    // rust: Some(&tables),
    // rust: shape.column(),
    // rust: )
    // rust: .expect("decodes");
    // rust: assert_eq!(back.sections.len(), 131);
    // rust: assert_eq!(back.get(0, 2000, 0), stone.0);
    // rust: assert_eq!(back.get(0, -64, 0), stone.0);
        // Read into the vanilla column, the sections above it are left out.
    // rust: let short = decode_with(
    // rust: &saved,
    // rust: assets.registry,
    // rust: &biomes,
    // rust: Some(&tables),
    // rust: ColumnLayout::VANILLA,
    // rust: )
    // rust: .expect("decodes");
    // rust: assert_eq!(short.sections.len(), SECTIONS);
    // rust: assert_eq!(short.get(0, 2000, 0), 0);
    // rust: assert_eq!(short.get(0, -64, 0), stone.0);
}

pub fn nether_and_end_chunks_save_with_their_own_height() void {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES") else {
    // rust: return;
}
    // rust: let root = PathBuf::from(root);
    // rust: let assets = crate::assets::Assets::load(&root).expect("assets");
    // rust: let biomes = Biomes::load(&root).expect("biomes");
    // rust: let tables = SaveTables::new(&assets);
    // rust: let rack = assets
    // rust: .registry
    // rust: .default_state("minecraft:netherrack")
    // rust: .unwrap();
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: for y in 0..128 {
    // rust: chunk.set(0, y, 0, rack.0);
}
    // rust: let saved = encode_with(
    // rust: &chunk,
    // rust: assets.registry,
    // rust: &biomes,
    // rust: Some(&tables),
    // rust: LevelShape::NETHER,
    // rust: );
    // rust: assert_eq!(number(saved.tag.get("yPos")), Some(0));
    // rust: let Some(Tag::List(sections)) = saved.tag.get("sections") else {
    // rust: panic!("no sections");
}
    // rust: let ys: Vec<i32> = sections
    // rust: .iter()
    // rust: .filter_map(|s| number(s.get("Y")).map(|y| y as i32))
    // rust: .collect();
    // rust: assert_eq!(ys, (0..16).collect::<Vec<_>>());
    // rust: let Some(Tag::List(post)) = saved.tag.get("PostProcessing") else {
    // rust: panic!("no PostProcessing");
}
    // rust: assert_eq!(post.len(), 16);
        // Heightmap values count from the level's minimum: the column's top
        // block at y=127 reads 128 (vanilla), not 192 (from the Overworld's -64).
    // rust: let Some(Tag::LongArray(surface)) = saved
    // rust: .tag
    // rust: .get("Heightmaps")
    // rust: .and_then(|h| h.get("WORLD_SURFACE"))
    // rust: else {
    // rust: panic!("no WORLD_SURFACE");
}
    // rust: assert_eq!(surface[0] & 0x1ff, 128);
    // rust: let overworld = encode_with(
    // rust: &chunk,
    // rust: assets.registry,
    // rust: &biomes,
    // rust: Some(&tables),
    // rust: LevelShape::OVERWORLD,
    // rust: );
    // rust: assert_eq!(number(overworld.tag.get("yPos")), Some(-4));
}

    /// The far ring's reads (`lan::far`): a chunk saved with its light, without the gameplay's region
    /// cache; none for a chunk not saved, or saved without its light.
pub fn far_reads_take_saved_lit_chunks_only() void {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES") else {
    // rust: return;
}
    // rust: let root = PathBuf::from(root);
    // rust: let assets = crate::assets::Assets::load(&root).expect("assets");
    // rust: let biomes = Biomes::load(&root).expect("biomes");
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: let mut lit = Chunk::empty(4, -7);
    // rust: lit.set(1, 70, 2, stone.0);
    // rust: let mut dark = lit.clone();
    // rust: dark.x = 5;
    // rust: lit.lit = true;
    // rust: let dir = std::env::temp_dir().join(format!("horizon-far-save-{}", std::process::id()));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let save = SaveDir::new(dir.clone(), LevelShape::OVERWORLD);
    // rust: let records =
    // rust: [&lit, &dark].map(|c| ((c.x, c.z), Some(encode(c, assets.registry, &biomes))));
    // rust: save.write_records("region", records.into(), true).unwrap();
    // rust: let reopened = SaveDir::new(dir.clone(), LevelShape::OVERWORLD);
    // rust: let far = reopened
    // rust: .load_far(4, -7, assets.registry, &biomes)
    // rust: .expect("saved with its light");
    // rust: assert_eq!(far.block(1, 70, 2), stone);
    // rust: assert!(far.lit && far.light_loaded);
    // rust: assert!(reopened.load_far(5, -7, assets.registry, &biomes).is_none());
    // rust: assert!(reopened.load_far(6, -7, assets.registry, &biomes).is_none());
    // rust: assert!(reopened.regions.lock().unwrap().is_empty());
    // rust: fs::remove_dir_all(&dir).ok();
}

pub fn saved_far_surface_reads_builds_and_water_without_gameplay_chunks() void {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES") else {
    // rust: return;
}
    // rust: let root = PathBuf::from(root);
    // rust: let assets = crate::assets::Assets::load(&root).expect("assets");
    // rust: let biomes = Biomes::load(&root).expect("biomes");
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: let sand = assets.registry.default_state("minecraft:sand").unwrap();
    // rust: let dirt = assets.registry.default_state("minecraft:dirt").unwrap();
    // rust: let leaves = assets
    // rust: .registry
    // rust: .default_state("minecraft:oak_leaves")
    // rust: .unwrap();
    // rust: let end_stone = assets
    // rust: .registry
    // rust: .default_state("minecraft:end_stone")
    // rust: .unwrap();
    // rust: let chorus = assets
    // rust: .registry
    // rust: .default_state("minecraft:chorus_plant")
    // rust: .unwrap();
    // rust: let flower = assets
    // rust: .registry
    // rust: .default_state("minecraft:chorus_flower")
    // rust: .unwrap();
    // rust: let mut chunk = Chunk::empty(-2, 3);
    // rust: chunk.set(0, 109, 0, stone.0);
    // rust: chunk.set(3, 121, 5, stone.0);
    // rust: chunk.set(3, 122, 5, stone.0);
    // rust: chunk.set(3, 120, 5, dirt.0);
    // rust: chunk.set(3, 119, 5, dirt.0);
    // rust: chunk.set(3, 115, 5, stone.0);
    // rust: chunk.set(11, 125, 11, stone.0);
    // rust: chunk.set(14, 127, 14, stone.0);
    // rust: chunk.set(14, 112, 14, stone.0);
    // rust: for y in 95..98 {
    // rust: chunk.set(2, y, 6, stone.0);
}
    // rust: chunk.lit = true;
    // rust: let mut cave_light = Box::new([0x03; 4096]);
    // rust: cave_light[crate::chunk::index(12, 125, 11)] = 0xa7;
    // rust: Arc::make_mut(&mut chunk.sections[((121 - MIN_Y) >> 4) as usize]).light =
    // rust: Light::Full(cave_light);
    // rust: chunk.set(7, 90, 9, sand.0);
    // rust: chunk.set(7, 98, 9, leaves.0);
    // rust: let forest = biomes.id("minecraft:forest");
    // rust: chunk.set_biome_cell(7 / 4, (98 - MIN_Y) / 4, 9 / 4, forest);
    // rust: chunk.set(4, 54, 4, sand.0);
    // rust: for y in 55..64 {
    // rust: chunk.set(4, y, 4, water.0);
}
        // Chorus is thin and non-solid but still part of the far End.
    // rust: chunk.set(12, 100, 2, end_stone.0);
    // rust: chunk.set(12, 101, 2, chorus.0);
    // rust: chunk.set(12, 102, 2, flower.0);
    // rust: let mut saved = encode(&chunk, assets.registry, &biomes);
    // rust: put(
    // rust: &mut saved.tag,
    // rust: "block_entities",
    // rust: Tag::String("not decoded by far sampling".into()),
    // rust: );
    // rust: let dir = std::env::temp_dir().join(format!("horizon-lod-save-{}", std::process::id()));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let save = SaveDir::new(dir.clone(), LevelShape::OVERWORLD);
    // rust: save.write_records("region", vec![((-2, 3), Some(saved))], true)
    // rust: .unwrap();
    // rust: let reopened = SaveDir::new(dir.clone(), LevelShape::OVERWORLD);
    // rust: let surfaces = reopened
    // rust: .lod_surfaces(-2, 3, &assets, &biomes)
    // rust: .expect("saved summary");
    // rust: assert_eq!(surfaces[0].surface.unwrap().height, 110);
    // rust: assert_eq!(surfaces[0].surface.unwrap().state, stone);
    // rust: let narrow_build = surfaces[5 * 16 + 3].surface.unwrap();
    // rust: assert_eq!((narrow_build.height, narrow_build.state), (123, stone));
    // rust: assert!(
    // rust: surfaces[5 * 16 + 2].surface.is_none(),
    // rust: "adjacent columns stay distinct"
    // rust: );
    // rust: let strata = &surfaces[5 * 16 + 3].spans;
    // rust: assert_eq!(
    // rust: strata
    // rust: .iter()
    // rust: .map(|span| (span.min, span.max, span.state))
    // rust: .collect::<Vec<_>>(),
    // rust: vec![(115, 116, stone), (119, 121, dirt), (121, 123, stone)]
    // rust: );
    // rust: assert!(
    // rust: strata.iter().all(|span| span.light == 0x3000),
    // rust: "saved cave darkness and block light survive"
    // rust: );
    // rust: assert_eq!(
    // rust: surfaces[11 * 16 + 11].spans[0].light,
    // rust: 0x70a0,
    // rust: "neighbor face light uses separate sky/block channels"
    // rust: );
    // rust: let boundaries = &surfaces[14 * 16 + 14].spans;
    // rust: assert_eq!(boundaries.len(), 2);
    // rust: assert!(
    // rust: boundaries.iter().all(|span| span.light == 0x30f0),
    // rust: "face light crosses section boundaries above and below"
    // rust: );
    // rust: let across_sections = &surfaces[6 * 16 + 2].spans;
    // rust: assert_eq!(across_sections.len(), 1);
    // rust: assert_eq!((across_sections[0].min, across_sections[0].max), (95, 98));
    // rust: let canopy = surfaces[9 * 16 + 7].surface.unwrap();
    // rust: assert_eq!(
    // rust: (canopy.height, canopy.state, canopy.biome),
    // rust: (99, leaves, forest)
    // rust: );
    // rust: let underwater = surfaces[4 * 16 + 4].surface.unwrap();
    // rust: assert_eq!((underwater.height, underwater.state), (55, sand));
    // rust: assert_eq!(underwater.water, Some((64, water)));
    // rust: let chorus_column = &surfaces[2 * 16 + 12];
    // rust: assert_eq!(
    // rust: chorus_column
    // rust: .surface
    // rust: .map(|surface| (surface.height, surface.state)),
    // rust: Some((103, flower))
    // rust: );
    // rust: assert_eq!(
    // rust: chorus_column
    // rust: .spans
    // rust: .iter()
    // rust: .map(|span| (span.min, span.max, span.state))
    // rust: .collect::<Vec<_>>(),
    // rust: vec![
    // rust: (100, 101, end_stone),
    // rust: (101, 102, chorus),
    // rust: (102, 103, flower)
    // rust: ]
    // rust: );
    // rust: assert!(surfaces[15].surface.is_none(), "saved void stays empty");
    // rust: assert!(
    // rust: reopened.regions.lock().unwrap().is_empty(),
    // rust: "far reads do not grow gameplay region cache"
    // rust: );
    // rust: let mut proto = encode(&chunk, assets.registry, &biomes);
    // rust: put(
    // rust: &mut proto.tag,
    // rust: "Status",
    // rust: string(ChunkStatus::Terrain.name()),
    // rust: );
    // rust: put(&mut proto.tag, "xPos", Tag::Int(-3));
    // rust: save.write_records("region", vec![((-3, 3), Some(proto))], true)
    // rust: .unwrap();
    // rust: assert!(
    // rust: reopened.lod_surfaces(-3, 3, &assets, &biomes).is_none(),
    // rust: "unfinished proto saves must not suppress complete decoration"
    // rust: );
    // rust: let nether = SaveDir::new(dir.clone(), LevelShape::NETHER);
    // rust: let dark = nether.lod_surfaces(-2, 3, &assets, &biomes).unwrap();
    // rust: assert!(
    // rust: dark.iter()
    // rust: .flat_map(|c| &c.spans)
    // rust: .all(|s| s.light & 0xf0 == 0),
    // rust: "no invented skylight in Nether saves"
    // rust: );
pub const SavedOnly = struct {};
    // rust: impl crate::streaming::LodSampler for SavedOnly {
pub fn sample(self: *Self, _: i32, _: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: panic!("saved data must win")
}
pub fn request_detail(self: *Self, chunks: *[(i32) void {
}
    // rust: assert!(
    // rust: chunks.is_empty(),
    // rust: "saved builds must not request speculative generation"
    // rust: );
}
pub fn drain_details(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.0)
}
}
    // rust: let inner = Arc::new(crate::testgen::TestTerrain::new(assets.registry, &biomes).unwrap());
    // rust: let generator = Arc::new(Persistent {
    // rust: inner,
    // rust: save: Arc::new(reopened),
    // rust: registry: Arc::new(assets),
    // rust: biomes: Arc::new(biomes),
    // rust: });
    // rust: let mut sampler = SavedLodSampler {
    // rust: generator,
    // rust: inner: Box::new(SavedOnly(Vec::new())),
    // rust: cache: Default::default(),
    // rust: details: Vec::new(),
    // rust: approximate: false,
    // rust: generated: Arc::new(crate::lod::cache::DiskCache::new(dir.join("far"), 1)),
}
//         use crate::streaming::LodSampler;
    // rust: sampler.request_detail(&[(-2, 3)], [-32, 48]);
    // rust: let details = sampler.drain_details();
    // rust: assert_eq!(details.len(), 1);
    // rust: assert_eq!(&details[0].1[..], &surfaces[..]);
    // rust: sampler.cache.clear();
    // rust: let generated: LodSurfaces =
    // rust: Arc::new(std::array::from_fn(|_| crate::lod::Column::default()));
    // rust: sampler.inner = Box::new(SavedOnly(vec![
    // rust: ((-2, 3), generated.clone()),
    // rust: ((-9, 9), generated.clone()),
    // rust: ]));
    // rust: let details = sampler.drain_details();
    // rust: assert_eq!(
    // rust: &details[0].1[..],
    // rust: &surfaces[..],
    // rust: "unrequested batch neighbours must preserve saved builds"
    // rust: );
    // rust: assert!(Arc::ptr_eq(&details[1].1, &generated));
    // rust: assert!(
    // rust: sampler.generated.get(-2, 3).is_none(),
    // rust: "saved builds are not cached as generated"
    // rust: );
    // rust: assert_eq!(sampler.generated.get(-9, 9).unwrap(), generated);
        // A later session reads the generated chunk back instead of
        // generating it again.
    // rust: sampler.request_detail(&[(-9, 9)], [-144, 144]);
    // rust: assert_eq!(sampler.drain_details()[0].1, generated);
    // rust: sampler.inner =
    // rust: crate::streaming::ChunkGenerator::lod_sampler(sampler.generator.inner.clone());
    // rust: let grid = sampler.grid(-32, 48, 2, 16);
    // rust: for z in 0..8 {
    // rust: for x in 0..8 {
    // rust: assert_eq!(
    // rust: grid[z * 16 + x],
    // rust: crate::lod::Column::reduced(&surfaces, x * 2, z * 2, 2),
    // rust: "saved builds must override a batched direct grid"
    // rust: );
}
}
    // rust: drop((save, sampler, nether));
    // rust: fs::remove_dir_all(dir).unwrap();
}

pub fn saved_far_surface_rejects_invalid_packed_palettes() void {
}
    // rust: let mut states = Tag::compound([
    // rust: ("palette", Tag::List(vec![Tag::Byte(0), Tag::Byte(1)])),
    // rust: ("data", Tag::LongArray(vec![0; 256])),
    // rust: ]);
    // rust: assert_eq!(lod_palette_index(&states, 4095, 4096, 4), Some(0));
    // rust: assert_eq!(lod_palette_index(&states, 4096, 4096, 4), None);
    // rust: put(&mut states, "data", Tag::LongArray(vec![15; 256]));
    // rust: assert_eq!(lod_palette_index(&states, 0, 4096, 4), None);
    // rust: put(&mut states, "data", Tag::LongArray(vec![0; 255]));
    // rust: assert_eq!(lod_palette_index(&states, 0, 4096, 4), None);
}

pub fn save_batch_preserves_order_coordinates_and_ownership() void {
}
//         use crate::containers::BlockEntity;
    // rust: let mut entities = HashMap::new();
    // rust: let mut names = HashMap::new();
    // rust: for x in [i32::MIN, -17, -16, -1, 0, 15, 16, i32::MAX] {
    // rust: for z in [-17, -16, -1, 0, 15, 16] {
    // rust: let p = (x, 64, z);
    // rust: entities.insert(p, BlockEntity::Chest(vec![None; 27]));
    // rust: names.insert(p, format!("container {x},{z}"));
}
}
        // Names without a modelled entity must also survive the snapshot.
    // rust: names.insert((-2, 80, -3), "orphan name".into());
    // rust: let mut source = Chunk::empty(-1, -1);
    // rust: source
    // rust: .block_entities
    // rust: .push(((99, 0, 99), BlockEntity::Chest(vec![])));
    // rust: source.block_names.push(((99, 0, 99), "stale".into()));
    // rust: source.saved = Some(Arc::new(ChunkExtras::default()));
    // rust: let source = Arc::new(source);
    // rust: let batch = vec![
    // rust: source.clone(),
    // rust: Arc::new(Chunk::empty(1, 1)),
    // rust: Arc::new(Chunk::empty(-2, 0)),
    // rust: source.clone(), // Preserve input order and repeated coordinates.
    // rust: Arc::new(Chunk::empty(i32::MIN >> 4, -2)),
    // rust: Arc::new(Chunk::empty(i32::MAX >> 4, 1)),
    // rust: Arc::new(Chunk::empty(100, 100)),
    // rust: ];
    // rust: let encode = |entries: &[((i32, i32, i32), BlockEntity)]| {
    // rust: entries
    // rust: .iter()
    // rust: .map(|(p, e)| encode_block_entity(*p, e, "minecraft:chest"))
    // rust: .collect::<Vec<_>>()
}
    // rust: for input in [&batch[..0], &batch[..1], &batch[..]] {
    // rust: let actual = chunks_with_block_entities(input, &entities, &names);
    // rust: assert_eq!(actual.len(), input.len());
    // rust: for (c, original) in actual.iter().zip(input) {
    // rust: let expected: Vec<_> = entities
    // rust: .iter()
    // rust: .filter(|(p, _)| (p.0 >> 4, p.2 >> 4) == (c.x, c.z))
    // rust: .map(|(p, e)| (*p, e.clone()))
    // rust: .collect();
    // rust: let expected_names: Vec<_> = names
    // rust: .iter()
    // rust: .filter(|(p, _)| (p.0 >> 4, p.2 >> 4) == (c.x, c.z))
    // rust: .map(|(p, n)| (*p, n.clone()))
    // rust: .collect();
    // rust: assert_eq!((c.x, c.z), (original.x, original.z));
    // rust: assert_eq!(encode(&c.block_entities), encode(&expected));
    // rust: assert_eq!(c.block_names, expected_names);
    // rust: assert!(Arc::ptr_eq(&c.sections[0], &original.sections[0]));
    // rust: if let Some(saved) = &original.saved {
    // rust: assert!(Arc::ptr_eq(c.saved.as_ref().unwrap(), saved));
}
}
}
    // rust: let snapshot = chunks_with_block_entities(&batch, &entities, &names);
    // rust: entities.clear();
    // rust: names.clear();
    // rust: assert!(!snapshot[0].block_entities.is_empty());
    // rust: assert!(!snapshot[0].block_names.is_empty());
    // rust: assert_eq!(source.block_names[0].1, "stale");
    // rust: assert_eq!(source.block_entities[0].0, (99, 0, 99));
}

pub fn work_shared_out_is_all_done_in_order_when_no_helper_can_start() void {
}
//         use super::share_out;
    // rust: let squares = |i: usize| i * i;
    // rust: let want: Vec<usize> = (0..40).map(squares).collect();
        // Every helper refused (a container at its thread limit): this thread does it all.
    // rust: assert_eq!(share_out(40, 4, squares, || false), want);
        // Some refused, some started.
    // rust: let mut asked = 0;
    // rust: let some = || {
    // rust: asked += 1;
    // rust: asked % 2 == 0
}
    // rust: assert_eq!(share_out(40, 4, squares, some), want);
    // rust: assert_eq!(share_out(40, 4, squares, || true), want);
    // rust: assert_eq!(share_out(0, 4, squares, || true), Vec::<usize>::new());
}

pub fn records_compressed_on_helpers_match_one_thread_in_order() void {
}
//         use super::{Record, compress_records};
    // rust: let records: Vec<((i32, i32), Record)> = (0..53i32)
    // rust: .map(|i| {
    // rust: let record = if i % 7 == 3 {
    // rust: Record::Delete
    // rust: } else {
    // rust: let payload: Vec<i64> = (0..i * 97 % 2000).map(|v| i64::from(v * i)).collect();
    // rust: Record::Tag(Arc::new(NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([
    // rust: ("xPos", Tag::Int(i)),
    // rust: ("Data", Tag::LongArray(payload)),
    // rust: ]),
    // rust: }))
}
    // rust: ((i, -i), record)
    // rust: })
    // rust: .collect();
    // rust: let refs: Vec<_> = records.iter().map(|(k, r)| (*k, r)).collect();
    // rust: let compressed = compress_records(&refs, 1234);
    // rust: assert_eq!(compressed.len(), records.len());
    // rust: for ((_, record), got) in records.iter().zip(compressed) {
    // rust: let want = record
    // rust: .tag()
    // rust: .map(|t| ChunkRecord::from_nbt(&t, Compression::Zlib, 1234, Limits::default()))
    // rust: .transpose()
    // rust: .unwrap();
    // rust: let got = got.unwrap();
    // rust: assert_eq!(
    // rust: got.as_ref().map(|r| (&r.compressed, r.timestamp)),
    // rust: want.as_ref().map(|r| (&r.compressed, r.timestamp))
    // rust: );
}
}

pub fn older_worlds_are_upgraded_on_opening() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-dv-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let level =
    // rust: |v: i32| Tag::compound([("Data", Tag::compound([("DataVersion", Tag::Int(v))]))]);
    // rust: let version = |dir: &std::path::Path| {
    // rust: super::read_dat(&dir.join("level.dat"))
    // rust: .and_then(|r| super::number(r.get("Data")?.get("DataVersion")))
}
        // 1.12.2 and 1.16.5: upgraded too, every server fix is ported.
    // rust: for old in [1343, 2586] {
    // rust: super::write_dat(&dir.join("level.dat"), level(old)).unwrap();
    // rust: super::upgrade_older_world(&dir).unwrap();
    // rust: assert_eq!(version(&dir), Some(i64::from(super::DATA_VERSION)));
}
        // 1.21.1: upgraded to the current version.
    // rust: super::write_dat(&dir.join("level.dat"), level(3955)).unwrap();
    // rust: super::upgrade_older_world(&dir).unwrap();
    // rust: assert_eq!(version(&dir), Some(i64::from(super::DATA_VERSION)));
    // rust: super::upgrade_older_world(&dir).unwrap();
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
pub fn region_files_kept_open_stay_under_vanillas_cache_size() void {
}
    // rust: let open_fds = || std::fs::read_dir("/dev/fd").map_or(0, |d| d.count());
    // rust: let dir = std::env::temp_dir().join(format!("horizon-save-fds-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let save = super::SaveDir::new(dir.clone(), LevelShape::OVERWORLD);
    // rust: let before = open_fds();
    // rust: let held = super::cached_region(
    // rust: &save.regions,
    // rust: (0, 0),
    // rust: &save.region_path("region", 0, 0),
    // rust: true,
    // rust: )
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: for x in 1..=600 {
    // rust: super::cached_region(
    // rust: &save.regions,
    // rust: (x, 0),
    // rust: &save.region_path("region", x, 0),
    // rust: true,
    // rust: )
    // rust: .unwrap()
    // rust: .unwrap();
}
        // Other tests open files at the same time: a margin, far below 600.
    // rust: let grown = open_fds().saturating_sub(before);
    // rust: assert!(
    // rust: grown <= super::MAX_OPEN_REGIONS + 32,
    // rust: "{grown} descriptors more"
    // rust: );
    // rust: let cache = save.regions.lock().unwrap();
    // rust: assert!(
    // rust: cache.open() <= super::MAX_OPEN_REGIONS,
    // rust: "{} open",
    // rust: cache.open()
    // rust: );
        // The one still held is never closed under its holder.
    // rust: assert!(Arc::ptr_eq(
    // rust: &cache.regions[&(0, 0)].0.clone().unwrap(),
    // rust: &held
    // rust: ));
    // rust: drop(cache);
        // What was written to regions since closed reads back from the disk.
    // rust: let entity = |x: i32| Tag::compound([("x", Tag::Int(x))]);
    // rust: save.save_entities_later((0..300).map(|i| ((i * 32, 0), vec![entity(i)])).collect())
    // rust: .unwrap();
    // rust: save.flush().unwrap();
    // rust: assert!(save.entity_regions.lock().unwrap().open() <= super::MAX_OPEN_REGIONS);
    // rust: for i in [0, 1, 150, 299] {
    // rust: assert_eq!(save.load_entities(i * 32, 0), vec![entity(i)]);
}
    // rust: drop(held);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
pub fn write_completion_polls_without_waiting_and_keeps_latest_snapshot() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-save-poll-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let save = super::SaveDir::new(dir.clone(), LevelShape::OVERWORLD);
    // rust: let lock = super::SessionLock::acquire(&dir).unwrap();
    // rust: let path = save.region_path("entities", 0, 0);
    // rust: let region = super::cached_region(&save.entity_regions, (0, 0), &path, true)
    // rust: .unwrap()
    // rust: .unwrap();
        // Hold the actual region lock, rather than relying on disk speed or sleeps.
    // rust: let blocked = region.lock().unwrap();
    // rust: let entity = |version| Tag::compound([("version", Tag::Int(version))]);
    // rust: save.save_entities_later(vec![((1, 2), vec![entity(1)])])
    // rust: .unwrap();
    // rust: save.save_entities_later(vec![((1, 2), vec![entity(2)])])
    // rust: .unwrap();
    // rust: assert!(!save.writes_finished().unwrap());
    // rust: assert_eq!(save.load_entities(1, 2), vec![entity(2)]);
    // rust: assert!(super::SessionLock::acquire(&dir).is_err());
    // rust: drop(blocked);
    // rust: save.flush().unwrap();
    // rust: assert!(save.writes_finished().unwrap());
    // rust: let reopened = super::SaveDir::new(dir.clone(), LevelShape::OVERWORLD);
    // rust: assert_eq!(reopened.load_entities(1, 2), vec![entity(2)]);
    // rust: save.save_entities_later(vec![((1, 2), vec![])]).unwrap();
    // rust: save.flush().unwrap();
    // rust: assert!(
    // rust: super::SaveDir::new(dir.clone(), LevelShape::OVERWORLD)
    // rust: .load_entities(1, 2)
    // rust: .is_empty()
    // rust: );
    // rust: drop((reopened, save, lock));
    // rust: let _ = std::fs::remove_dir_all(dir);
}

pub fn failed_async_writes_are_readable_and_never_reported_durable() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-save-failure-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
        // A file where a directory is needed causes a real writer I/O error.
    // rust: std::fs::write(dir.join("entities"), b"blocked").unwrap();
    // rust: let save = super::SaveDir::new(dir.clone(), LevelShape::OVERWORLD);
    // rust: let entity = Tag::compound([("version", Tag::Int(3))]);
    // rust: save.save_entities_later(vec![((0, 0), vec![entity.clone()])])
    // rust: .unwrap();
    // rust: assert!(save.flush().is_err());
    // rust: assert!(save.writes_finished().is_err());
    // rust: assert_eq!(save.load_entities(0, 0), vec![entity]);
        // The failure stays visible on subsequent barriers too.
    // rust: assert!(save.flush().is_err());
    // rust: drop(save);
    // rust: let _ = std::fs::remove_dir_all(dir);
}

pub fn session_lock_is_exclusive() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-lock-{}", std::process::id()));
    // rust: let first = super::SessionLock::acquire(&dir).expect("first lock");
    // rust: assert!(super::SessionLock::acquire(&dir).is_err());
    // rust: drop(first);
        // Windows refuses a read through another handle while the file is
        // locked, so the bytes are read once the lock is released.
    // rust: assert_eq!(
    // rust: std::fs::read(dir.join("session.lock")).unwrap(),
    // rust: [0x26, 0x03]
    // rust: );
    // rust: assert!(super::SessionLock::acquire(&dir).is_ok());
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
    /// #749: a copy of the lock's descriptor (a child process spawned on
    /// another thread holds one until it execs) must not keep a released
    /// world locked.
pub fn session_lock_releases_while_a_descriptor_copy_lives() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-lock-copy-{}", std::process::id()));
    // rust: let lock = super::SessionLock::acquire(&dir).expect("first lock");
    // rust: let copy = lock.0.try_clone().unwrap();
    // rust: drop(lock);
    // rust: assert!(super::SessionLock::acquire(&dir).is_ok());
    // rust: drop(copy);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
pub fn crafter_block_entity_round_trips() void {
}
    // rust: let mut crafter = crate::containers::Crafter::default();
    // rust: crafter.items[2] = Some(crate::items::ItemStack::new("minecraft:stick", 5));
    // rust: crafter.disabled[4] = true;
    // rust: crafter.triggered = true;
    // rust: crafter.crafting_ticks = 3;
    // rust: let tag = encode_block_entity(
    // rust: (7, 8, 9),
    // rust: &crate::containers::BlockEntity::Crafter(crafter),
    // rust: "minecraft:crafter",
    // rust: );
    // rust: let (pos, back) = decode_block_entity(&tag).expect("crafter");
    // rust: assert_eq!(pos, (7, 8, 9));
    // rust: let crate::containers::BlockEntity::Crafter(back) = back else {
    // rust: panic!("not a crafter");
}
    // rust: assert_eq!(back.items[2].as_ref().map(|s| s.count), Some(5));
    // rust: assert!(back.disabled[4] && !back.disabled[3]);
    // rust: assert!(back.triggered);
    // rust: assert_eq!(back.crafting_ticks, 3);
    // rust: assert_eq!(back.redstone_signal(), 2);
}
pub fn campfire_block_entity_round_trips() void {
}
    // rust: let mut c = crate::containers::Campfire::default();
    // rust: c.items[1] = Some(crate::items::ItemStack::new("minecraft:beef", 1));
    // rust: c.progress[1] = 120;
    // rust: c.total[1] = 600;
    // rust: let tag = encode_block_entity(
    // rust: (3, 64, -2),
    // rust: &crate::containers::BlockEntity::Campfire(Box::new(c.clone())),
    // rust: "minecraft:soul_campfire",
    // rust: );
        // One block entity type for both campfires.
    // rust: assert_eq!(text(tag.get("id")).as_deref(), Some("minecraft:campfire"));
    // rust: let (pos, back) = decode_block_entity(&tag).expect("campfire");
    // rust: assert_eq!(pos, (3, 64, -2));
    // rust: let crate::containers::BlockEntity::Campfire(back) = back else {
    // rust: panic!("not a campfire");
}
    // rust: assert_eq!(*back, c);
        // The update tag a server's clients get: the items alone.
    // rust: let update =
    // rust: crate::lan::chunks::entity_tag(&crate::containers::BlockEntity::Campfire(Box::new(c)))
    // rust: .expect("update tag");
    // rust: assert!(update.get("Items").is_some() && update.get("CookingTimes").is_none());
}
    /// `LecternBlockEntity.loadAdditional`: `Page` is clamped to
    /// `0..getPageCount(book) - 1`, so a stored page outside the book loads as
    /// the first or last page the block holds. A bookless lectern counts no
    /// pages and loads page -1.
pub fn a_lecterns_page_loads_within_its_book() void {
}
    // rust: let page_of = |tag: &str| {
    // rust: let tag = horizon_world::nbt::parse_snbt(tag).unwrap().0;
    // rust: let (_, entity) = decode_block_entity(&tag).expect("lectern");
    // rust: let crate::containers::BlockEntity::Lectern(l) = entity else {
    // rust: panic!("not a lectern");
}
    // rust: l.page
}
    // rust: let book = |pages: &str| {
    // rust: format!(
    // rust: r#"id:"minecraft:written_book",count:1,components:{{
    // rust: "minecraft:written_book_content":{{title:"t",author:"a",pages:[{pages}]}}
    // rust: }}"#
    // rust: )
}
        // Two pages: a stored 7 is the last page, a stored -3 the first.
    // rust: assert_eq!(
    // rust: page_of(&format!(
    // rust: r#"{{id:"minecraft:lectern",x:1,y:64,z:2,Page:7,Book:{{{}}}}}"#,
    // rust: book(r#""one","two""#)
    // rust: )),
    // rust: 1
    // rust: );
    // rust: assert_eq!(
    // rust: page_of(&format!(
    // rust: r#"{{id:"minecraft:lectern",x:1,y:64,z:2,Page:-3,Book:{{{}}}}}"#,
    // rust: book(r#""one","two""#)
    // rust: )),
    // rust: 0
    // rust: );
        // No book counts no pages, so any page loads as -1, as vanilla's.
    // rust: assert_eq!(
    // rust: page_of(r#"{id:"minecraft:lectern",x:1,y:64,z:2,Page:4}"#),
    // rust: -1
    // rust: );
        // A page already inside the book is kept, and saved back as it is.
    // rust: let tag = format!(
    // rust: r#"{{id:"minecraft:lectern",x:1,y:64,z:2,Page:1,Book:{{{}}}}}"#,
    // rust: book(r#""one","two","three""#)
    // rust: );
    // rust: let tag = horizon_world::nbt::parse_snbt(&tag).unwrap().0;
    // rust: let (pos, entity) = decode_block_entity(&tag).expect("lectern");
    // rust: let crate::containers::BlockEntity::Lectern(l) = entity else {
    // rust: panic!("not a lectern");
}
    // rust: assert_eq!(l.page, 1);
    // rust: let saved = encode_block_entity(
    // rust: pos,
    // rust: &crate::containers::BlockEntity::Lectern(l),
    // rust: "minecraft:lectern",
    // rust: );
    // rust: assert_eq!(number(saved.get("Page")), Some(1));
}
pub fn a_chest_loot_table_takes_precedence_over_saved_items() void {
}
    // rust: let mut saved = horizon_world::nbt::parse_snbt(
    // rust: r#"{id:"minecraft:chest",x:1,y:2,z:3,Items:[{Slot:3b,id:"minecraft:diamond",count:7}],LootTable:"minecraft:chests/simple_dungeon",LootTableSeed:42L}"#,
    // rust: )
    // rust: .unwrap()
    // rust: .0;
    // rust: let (_, mut chest) = decode_block_entity(&saved).expect("chest");
    // rust: assert!(
    // rust: chest.slots().iter().all(Option::is_none),
    // rust: "ChestBlockEntity.loadAdditional ignores Items when a loot table loads"
    // rust: );
        // The command path rolls an empty inventory and keeps the table/seed
        // for data get and saving. No loot resources are needed to keep that state.
    // rust: let rolled = crate::structure_blocks::roll_container(
    // rust: chest.slots_mut(),
    // rust: None,
    // rust: "minecraft:chests/simple_dungeon".into(),
    // rust: Some(42),
    // rust: (1, 2, 3),
    // rust: "minecraft:plains",
    // rust: );
    // rust: let mut stored = block_entity_data((1, 2, 3), &chest, "minecraft:chest", None);
    // rust: let Tag::Compound(fields) = &mut stored else {
    // rust: panic!("compound");
}
    // rust: assert!(rolled.restore(fields));
    // rust: assert_eq!(stored.get("LootTable"), saved.get("LootTable"));
    // rust: assert_eq!(stored.get("LootTableSeed"), saved.get("LootTableSeed"));
    // rust: assert!(stored.get("Items").is_none());
    // rust: let Tag::Compound(fields) = &mut saved else {
    // rust: panic!("compound");
}
    // rust: fields.remove(&"LootTable".into());
    // rust: let (_, chest) = decode_block_entity(&saved).expect("chest without table");
    // rust: let item = chest.slots()[3].as_ref().expect("saved item");
    // rust: assert_eq!(item.item.as_ref(), "minecraft:diamond");
    // rust: assert_eq!(item.count, 7);
}

    /// `tryLoadLootTable` in every `RandomizableContainer`'s `loadAdditional`
    /// (barrel, shulker boxes, hopper, dispenser, dropper):
    /// a valid table leaves the saved `Items` unread, as for the chest.
pub fn every_randomizable_container_lets_its_loot_table_win_over_saved_items() void {
}
    // rust: for (id, size) in [
    // rust: ("minecraft:barrel", 27),
    // rust: ("minecraft:shulker_box", 27),
    // rust: ("minecraft:white_shulker_box", 27),
    // rust: ("minecraft:hopper", crate::containers::HOPPER_SLOTS),
    // rust: ("minecraft:dispenser", 9),
    // rust: ("minecraft:dropper", 9),
    // rust: ] {
    // rust: let mut saved = horizon_world::nbt::parse_snbt(&format!(
    // rust: r#"{{id:"{id}",x:1,y:2,z:3,Items:[{{Slot:3b,id:"minecraft:diamond",count:7}}],LootTable:"minecraft:chests/simple_dungeon",LootTableSeed:42L}}"#
    // rust: ))
    // rust: .unwrap()
    // rust: .0;
    // rust: let (_, mut container) = decode_block_entity(&saved).expect(id);
    // rust: assert_eq!(container.slots().len(), size, "{id}");
    // rust: assert!(
    // rust: container.slots().iter().all(Option::is_none),
    // rust: "{id}: loadAdditional ignores Items when a loot table loads"
    // rust: );
    // rust: let rolled = crate::structure_blocks::roll_container(
    // rust: container.slots_mut(),
    // rust: None,
    // rust: "minecraft:chests/simple_dungeon".into(),
    // rust: Some(42),
    // rust: (1, 2, 3),
    // rust: "minecraft:plains",
    // rust: );
    // rust: let mut stored = block_entity_data((1, 2, 3), &container, id, None);
    // rust: let Tag::Compound(fields) = &mut stored else {
    // rust: panic!("compound");
}
    // rust: assert!(rolled.restore(fields), "{id}");
    // rust: assert_eq!(stored.get("LootTable"), saved.get("LootTable"), "{id}");
    // rust: assert_eq!(
    // rust: stored.get("LootTableSeed"),
    // rust: saved.get("LootTableSeed"),
    // rust: "{id}"
    // rust: );
    // rust: assert!(stored.get("Items").is_none(), "{id}");
    // rust: let Tag::Compound(fields) = &mut saved else {
    // rust: panic!("compound");
}
    // rust: fields.remove(&"LootTable".into());
    // rust: let (_, container) = decode_block_entity(&saved).expect(id);
    // rust: let item = container.slots()[3].as_ref().expect("saved item");
    // rust: assert_eq!(item.item.as_ref(), "minecraft:diamond", "{id}");
    // rust: assert_eq!(item.count, 7, "{id}");
}
}

pub fn invalid_container_loot_tables_leave_saved_items_intact() void {
}
    // rust: for id in [
    // rust: "minecraft:chest",
    // rust: "minecraft:trapped_chest",
    // rust: "minecraft:barrel",
    // rust: "minecraft:shulker_box",
    // rust: "minecraft:hopper",
    // rust: "minecraft:dispenser",
    // rust: "minecraft:dropper",
    // rust: ] {
    // rust: for invalid in ["INVALID TABLE", "bad:table/with spaces", "bad@id"] {
    // rust: let saved = horizon_world::nbt::parse_snbt(&format!(
    // rust: r#"{{id:"{id}",x:1,y:2,z:3,Items:[{{Slot:0b,id:"minecraft:diamond",count:3}}],LootTable:"{invalid}"}}"#
    // rust: ))
    // rust: .unwrap()
    // rust: .0;
    // rust: let (_, container) = decode_block_entity(&saved).expect(id);
    // rust: let item = container.slots()[0]
    // rust: .as_ref()
    // rust: .expect("saved item with invalid table");
    // rust: assert_eq!(item.item.as_ref(), "minecraft:diamond");
    // rust: assert_eq!(item.count, 3);
}
}
}

    /// `LockCode`: a chest's `lock` is not in Horizon's model, so `data get`
    /// takes it from the tag the block entity was loaded (or set) with.
pub fn a_locked_chest_keeps_its_lock_through_decode_and_encode() void {
}
    // rust: let saved = horizon_world::nbt::parse_snbt(
    // rust: r#"{id:"minecraft:chest",x:1,y:2,z:3,lock:{items:"minecraft:gold_ingot"}}"#,
    // rust: )
    // rust: .unwrap()
    // rust: .0;
    // rust: let (pos, chest) = decode_block_entity(&saved).expect("chest");
    // rust: assert_eq!(chest.slots().len(), 27);
    // rust: assert_eq!(pos, (1, 2, 3));
        // The encoded entity has no field to carry the lock...
    // rust: let plain = encode_block_entity(pos, &chest, "minecraft:chest");
    // rust: assert!(plain.get("lock").is_none());
        // ...so `data get` puts back the one it was loaded with.
    // rust: let data = block_entity_data(pos, &chest, "minecraft:chest", saved.get("lock"));
    // rust: let lock = horizon_world::nbt::parse_snbt(r#"{items:"minecraft:gold_ingot"}"#)
    // rust: .unwrap()
    // rust: .0;
    // rust: assert_eq!(data.get("lock"), Some(&lock));
}
pub fn spawner_block_entity_round_trips() void {
}
        // A dungeon spawner as vanilla saves it (`id` is mob_spawner, not the block).
    // rust: let saved = horizon_world::nbt::parse_snbt(
    // rust: r#"{id:"minecraft:mob_spawner",x:67,y:-52,z:-64,Delay:20s,SpawnData:{entity:{id:"minecraft:zombie"}},SpawnPotentials:[]}"#,
    // rust: )
    // rust: .unwrap()
    // rust: .0;
    // rust: let (pos, back) = decode_block_entity(&saved).expect("spawner");
    // rust: assert_eq!(pos, (67, -52, -64));
    // rust: let crate::containers::BlockEntity::Spawner(spawner) = &back else {
    // rust: panic!("not a spawner");
}
    // rust: let next = spawner.next_data().and_then(|d| d.id());
    // rust: assert_eq!(next.as_deref(), Some("minecraft:zombie"));
    // rust: let tag = encode_block_entity(pos, &back, "minecraft:spawner");
    // rust: let (_, again) = decode_block_entity(&tag).expect("spawner again");
    // rust: let crate::containers::BlockEntity::Spawner(again) = again else {
    // rust: panic!("not a spawner");
}
    // rust: assert_eq!(again.update_tag(), spawner.update_tag());
}
pub fn mod_block_entity_round_trips() void {
}
    // rust: let saved = horizon_world::nbt::parse_snbt(
    // rust: r#"{id:"gtmod:macerator",x:5,y:-60,z:12,energy:1200L,progress:7,Items:[{Slot:0b,id:"minecraft:iron_ore",count:3}]}"#,
    // rust: )
    // rust: .unwrap()
    // rust: .0;
    // rust: let (pos, back) = decode_block_entity(&saved).expect("mod block entity");
    // rust: assert_eq!(pos, (5, -60, 12));
    // rust: let crate::containers::BlockEntity::Mod(m) = &back else {
    // rust: panic!("not a mod's");
}
    // rust: assert_eq!(m.id, "gtmod:macerator");
        // The mod sees its own fields only.
    // rust: for key in ["id", "x", "y", "z"] {
    // rust: assert!(!m.nbt.contains_key(&key.into()), "{key}");
}
    // rust: assert_eq!(m.nbt.get(&"energy".into()), Some(&Tag::Long(1200)));
        // `Items` are its slots, not the mod's compound.
    // rust: assert!(!m.nbt.contains_key(&"Items".into()));
    // rust: assert_eq!(m.items.len(), 1);
    // rust: assert_eq!(m.items[0].as_ref().map(|s| s.count), Some(3));
    // rust: assert_eq!(encode_block_entity(pos, &back, "gtmod:macerator"), saved);
        // `Items` that are not an item list stay the mod's, as saved.
    // rust: for items in [
    // rust: r#"Items:{energy:5}"#,
    // rust: r#"Items:[1,2,3]"#,
    // rust: r#"Items:[{Slot:0b,id:"minecraft:air",count:1}]"#,
    // rust: r#"Items:[{Slot:0b,id:"minecraft:stone",count:1,note:"mine"}]"#,
    // rust: ] {
    // rust: let saved = horizon_world::nbt::parse_snbt(&format!(
    // rust: r#"{{id:"gtmod:cable",x:0,y:0,z:0,{items}}}"#
    // rust: ))
    // rust: .unwrap()
    // rust: .0;
    // rust: let (pos, back) = decode_block_entity(&saved).expect("mod block entity");
    // rust: let crate::containers::BlockEntity::Mod(m) = &back else {
    // rust: panic!("not a mod's");
}
    // rust: assert!(m.items.is_empty(), "{items}");
    // rust: assert_eq!(
    // rust: encode_block_entity(pos, &back, "gtmod:cable"),
    // rust: saved,
    // rust: "{items}"
    // rust: );
}
        // Vanilla's types are never a mod's, modelled or not.
    // rust: let ender = horizon_world::nbt::parse_snbt(r#"{id:"minecraft:ender_chest",x:0,y:0,z:0}"#)
    // rust: .unwrap()
    // rust: .0;
    // rust: assert!(!matches!(
    // rust: decode_block_entity(&ender),
    // rust: Some((_, crate::containers::BlockEntity::Mod(_)))
    // rust: ));
}
pub fn banner_block_entity_round_trips() void {
}
    // rust: let banner = crate::containers::Banner {
    // rust: layers: vec![crate::banner::BannerLayer::new("minecraft:creeper", "lime")],
    // rust: name: Some("Flag".into()),
    // rust: components: [("minecraft:rarity".into(), string("uncommon"))].into(),
}
    // rust: let tag = encode_block_entity(
    // rust: (1, 2, 3),
    // rust: &crate::containers::BlockEntity::Banner(banner.clone()),
    // rust: "minecraft:red_banner",
    // rust: );
    // rust: let (pos, back) = decode_block_entity(&tag).expect("banner");
    // rust: assert_eq!(pos, (1, 2, 3));
    // rust: let crate::containers::BlockEntity::Banner(back) = back else {
    // rust: panic!("not a banner");
}
    // rust: assert_eq!(back.layers, banner.layers);
    // rust: assert_eq!(back.name, banner.name);
    // rust: assert_eq!(back.components, banner.components);
}
//     use super::*;
//     use crate::chunk::{MIN_Y, SECTIONS};

pub fn end_gateway_block_entity_round_trips() void {
}
//         use crate::containers::{BlockEntity, EndGateway};
    // rust: let plain = BlockEntity::for_block("minecraft:end_gateway").expect("gateway");
    // rust: assert!(matches!(&plain, BlockEntity::EndGateway(g) if *g == EndGateway::default()));
    // rust: for exit in [None, Some([8, 100, 0])] {
    // rust: for exact in [false, true] {
    // rust: let gateway = EndGateway {
    // rust: age: 201,
    // rust: exit_portal: exit,
    // rust: exact_teleport: exact,
}
    // rust: let tag = encode_block_entity(
    // rust: (702, 100, 0),
    // rust: &BlockEntity::EndGateway(gateway.clone()),
    // rust: "minecraft:end_gateway",
    // rust: );
    // rust: assert_eq!(
    // rust: text(tag.get("id")).as_deref(),
    // rust: Some("minecraft:end_gateway")
    // rust: );
    // rust: assert_eq!(tag.get("Age"), Some(&Tag::Long(201)));
    // rust: assert_eq!(
    // rust: tag.get("exit_portal"),
    // rust: exit.map(|p| Tag::IntArray(p.to_vec())).as_ref()
    // rust: );
    // rust: assert_eq!(
    // rust: tag.get("ExactTeleport"),
    // rust: exact.then_some(Tag::Byte(1)).as_ref()
    // rust: );
    // rust: let (pos, back) = decode_block_entity(&tag).expect("gateway");
    // rust: assert_eq!(pos, (702, 100, 0));
    // rust: assert!(matches!(back, BlockEntity::EndGateway(g) if g == gateway));
}
}
}

pub fn end_gateway_exit_requires_spawnable_bounds() void {
}
    // rust: for (exit, valid) in [
    // rust: (vec![-30_000_000, -20_000_000, -30_000_000], true),
    // rust: (vec![29_999_999, 19_999_999, 29_999_999], true),
    // rust: (vec![30_000_000, 0, 0], false),
    // rust: (vec![0, 0, 30_000_000], false),
    // rust: (vec![-30_000_001, 0, 0], false),
    // rust: (vec![0, 0, -30_000_001], false),
    // rust: (vec![0, 20_000_000, 0], false),
    // rust: (vec![0, -20_000_001, 0], false),
    // rust: (vec![i32::MIN, 0, 0], false),
    // rust: (vec![0, 100], false),
    // rust: ] {
    // rust: let tag = Tag::compound([
    // rust: ("id", string("minecraft:end_gateway")),
    // rust: ("x", Tag::Int(702)),
    // rust: ("y", Tag::Int(100)),
    // rust: ("z", Tag::Int(0)),
    // rust: ("exit_portal", Tag::IntArray(exit)),
    // rust: ]);
    // rust: let (_, crate::containers::BlockEntity::EndGateway(g)) =
    // rust: decode_block_entity(&tag).unwrap()
    // rust: else {
    // rust: panic!("gateway");
}
    // rust: assert_eq!(g.exit_portal.is_some(), valid);
    // rust: let canonical = crate::block_entity_nbt::canonical(&tag).expect("gateway NBT");
    // rust: assert_eq!(canonical.get("exit_portal").is_some(), valid);
}
    // rust: assert_eq!(
    // rust: decode_end_gateway(&Tag::Compound(Compound::new())),
    // rust: crate::containers::EndGateway::default()
    // rust: );
}

pub fn skull_block_entity_keeps_its_profile() void {
}
        // A placed `player_head` as vanilla saves it: the owning player's
        // `profile` survives load, encode and `canonical`.
    // rust: let saved = horizon_world::nbt::parse_snbt(
    // rust: r#"{id:"minecraft:skull",x:10,y:64,z:20,profile:{name:"Steve",id:[I;1,2,3,4],properties:[{name:"textures",value:"abc"}]},note_block_sound:"minecraft:entity.player.hurt",custom_name:"Trophy"}"#,
    // rust: )
    // rust: .unwrap()
    // rust: .0;
    // rust: let (pos, back) = decode_block_entity(&saved).expect("skull");
    // rust: assert_eq!(pos, (10, 64, 20));
    // rust: let crate::containers::BlockEntity::Skull(skull) = &back else {
    // rust: panic!("not a skull");
}
    // rust: assert_eq!(skull.profile, saved.get("profile").cloned());
    // rust: assert_eq!(
    // rust: skull.note_block_sound.as_deref(),
    // rust: Some("minecraft:entity.player.hurt")
    // rust: );
    // rust: assert_eq!(back.id(), "minecraft:skull");
    // rust: let tag = encode_block_entity(pos, &back, "minecraft:player_head");
    // rust: assert_eq!(
    // rust: crate::block_entity_nbt::id(&tag).as_deref(),
    // rust: Some("minecraft:skull")
    // rust: );
    // rust: assert_eq!(tag.get("profile"), saved.get("profile"));
    // rust: let (_, again) = decode_block_entity(&tag).expect("skull again");
    // rust: let crate::containers::BlockEntity::Skull(again) = again else {
    // rust: panic!("not a skull");
}
    // rust: assert_eq!(again.profile, skull.profile);
        // A profile-less head (skeleton, creeper) round-trips too.
    // rust: let plain = encode_block_entity(
    // rust: pos,
    // rust: &crate::containers::BlockEntity::Skull(crate::containers::Skull::default()),
    // rust: "minecraft:creeper_head",
    // rust: );
    // rust: let (_, decoded) = decode_block_entity(&plain).expect("plain skull");
    // rust: assert!(matches!(decoded, crate::containers::BlockEntity::Skull(_)));
        // The heads and skulls have one; the piston's head is no skull.
//         use crate::containers::BlockEntity;
    // rust: assert!(matches!(
    // rust: BlockEntity::for_block("minecraft:player_wall_head"),
    // rust: Some(BlockEntity::Skull(_))
    // rust: ));
    // rust: assert!(BlockEntity::for_block("minecraft:piston_head").is_none());
}

pub fn uuid_text_round_trips() void {
}
    // rust: let u = [-158327916, 1572358581, -2125825222, -487948715];
    // rust: assert_eq!(uuid_from_text(&uuid_text(u)), Some(u));
    // rust: assert_eq!(
    // rust: uuid_text([0, 1, 2, 3]),
    // rust: "00000000-0000-0001-0000-000200000003"
    // rust: );
    // rust: let r = random_uuid();
    // rust: assert_eq!((r[1] >> 12) & 0xF, 4, "version 4");
}
pub fn random_uuids_made_at_once_differ() void {
}
    // rust: let made: std::collections::HashSet<[i32; 4]> =
    // rust: (0..10_000).map(|_| random_uuid()).collect();
    // rust: assert_eq!(made.len(), 10_000);
}
pub fn creaking_heart_keeps_its_protector_uuid() void {
}
//         use crate::containers::{BlockEntity, CreakingHeart};
    // rust: let heart = CreakingHeart {
    // rust: creaking: Some((Some(7), [1, 2, 3, 4])),
    // rust: ..Default::default()
}
    // rust: let tag = encode_block_entity(
    // rust: (3, 70, -5),
    // rust: &BlockEntity::CreakingHeart(Box::new(heart)),
    // rust: "minecraft:creaking_heart",
    // rust: );
    // rust: assert_eq!(
    // rust: tag.get("creaking"),
    // rust: Some(&Tag::IntArray(vec![1, 2, 3, 4])),
    // rust: "vanilla stores the protector's UUID under `creaking`"
    // rust: );
    // rust: let (pos, entity) = decode_block_entity(&tag).expect("heart decodes");
    // rust: assert_eq!(pos, (3, 70, -5));
    // rust: let BlockEntity::CreakingHeart(h) = entity else {
    // rust: panic!("a creaking heart");
}
        // The entity id is resolved again once the creaking is loaded.
    // rust: assert_eq!(h.creaking, Some((None, [1, 2, 3, 4])));
    // rust: let lonely = encode_block_entity(
    // rust: (0, 0, 0),
    // rust: &BlockEntity::CreakingHeart(Box::default()),
    // rust: "minecraft:creaking_heart",
    // rust: );
    // rust: assert!(lonely.get("creaking").is_none());
}
pub fn light_nibbles_use_vanilla_order() void {
}
    // rust: let mut a = Box::new([0u8; 4096]);
    // rust: a[0] = 0xF3; // sky 15, block 3 at x=0
    // rust: a[1] = 0x52; // sky 5, block 2 at x=1
    // rust: let light = Light::Full(a);
    // rust: assert_eq!(nibbles(&light, false)[0], 0x23);
    // rust: assert_eq!(nibbles(&light, true)[0], 0x5F);
}
pub fn stored_light_loads_with_vanilla_defaults() void {
}
    // rust: let mut sky = vec![0u8; 2048];
    // rust: sky[0] = 0x5A; // x=0 -> 10, x=1 -> 5
    // rust: let section = |y: i8, entries: Vec<(&str, Tag)>| {
    // rust: let mut all = vec![("Y", Tag::Byte(y))];
    // rust: all.extend(entries);
    // rust: Tag::compound(all)
}
    // rust: let tag = Tag::compound([
    // rust: ("isLightOn", Tag::Byte(1)),
    // rust: (
    // rust: "sections",
    // rust: Tag::List(vec![
    // rust: section(
    // rust: -4,
    // rust: vec![
    // rust: ("SkyLight", Tag::ByteArray(sky)),
    // rust: ("BlockLight", Tag::ByteArray(vec![0x21; 2048])),
    // rust: ],
    // rust: ),
                    // No sky layer: repeats the bottom layer of the section above.
    // rust: section(-3, vec![]),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: load_light(&tag, &mut chunk, true);
    // rust: assert!(chunk.lit && chunk.light_loaded);
    // rust: let at = |c: &Chunk, si: usize, i: usize| c.sections[si].light(i);
    // rust: assert_eq!(at(&chunk, 0, 0), 0xA1, "stored sky 10, block 1");
    // rust: assert_eq!(at(&chunk, 0, 1), 0x52, "stored sky 5, block 2");
        // Section -3 has no layers; above it (-2..) sky defaults to 15.
    // rust: assert_eq!(at(&chunk, 1, 0), 0xF0);
    // rust: assert_eq!(at(&chunk, SECTIONS - 1, 5), 0xF0);
    // rust: let mut dark = Chunk::empty(0, 0);
    // rust: load_light(&tag, &mut dark, false);
    // rust: assert_eq!(at(&dark, 1, 0), 0x00, "no skylight dimension");
    // rust: let mut unlit = Chunk::empty(0, 0);
    // rust: load_light(
    // rust: &Tag::compound([("isLightOn", Tag::Byte(0))]),
    // rust: &mut unlit,
    // rust: true,
    // rust: );
    // rust: assert!(!unlit.lit && !unlit.light_loaded);
}
pub fn saved_light_matches_reference_for_layers_and_metadata() void {
}
pub fn reference(tag: *Tag, chunk: *mut Chunk, sky_light: bool) void {
}
    // rust: if tag.get("isLightOn") != Some(&Tag::Byte(1)) {
    // rust: return;
}
    // rust: let Some(Tag::List(sections)) = tag.get("sections") else {
    // rust: return;
}
    // rust: let mut layers: Vec<(Option<&[u8]>, Option<&[u8]>)> = vec![(None, None); SECTIONS];
    // rust: for section in sections {
    // rust: let Some(y) = number(section.get("Y")) else {
    // rust: continue;
}
    // rust: let si = y as i32 - (MIN_Y >> 4);
    // rust: if !(0..SECTIONS as i32).contains(&si) {
    // rust: continue;
}
    // rust: let layer = |name: &str| match section.get(name) {
    // rust: Some(Tag::ByteArray(a)) if a.len() == 2048 => Some(&a[..]),
    // rust: _ => None,
}
    // rust: layers[si as usize] = (layer("SkyLight"), layer("BlockLight"));
}
    // rust: let above = [if sky_light { 15 } else { 0 }; 256];
    // rust: crate::light::light_from_layers(chunk, &layers, above, sky_light);
}

    // rust: let section = |y: Tag, sky: Option<Tag>, block: Option<Tag>| {
    // rust: let mut entries = vec![("Y", y)];
    // rust: if let Some(v) = sky {
    // rust: entries.push(("SkyLight", v));
}
    // rust: if let Some(v) = block {
    // rust: entries.push(("BlockLight", v));
}
    // rust: Tag::compound(entries)
}
    // rust: let root = |sections| {
    // rust: Tag::compound([
    // rust: ("isLightOn", Tag::Byte(1)),
    // rust: ("sections", Tag::List(sections)),
    // rust: ])
}
    // rust: let check = |tag: &Tag| {
    // rust: for sky_light in [false, true] {
    // rust: let mut expected = Chunk::empty(-3, 5);
    // rust: let s = Arc::make_mut(&mut expected.sections[0]);
    // rust: s.light = Light::Full(Box::new([0xab; 4096]));
    // rust: s.blocks.set(0, 1);
    // rust: s.blocks.set(0, 0);
    // rust: s.biomes.set(0, 1);
    // rust: s.biomes.set(0, 0);
    // rust: let mut actual = expected.clone();
    // rust: reference(tag, &mut expected, sky_light);
    // rust: load_light(tag, &mut actual, sky_light);
    // rust: assert_eq!(
    // rust: (actual.lit, actual.light_loaded),
    // rust: (expected.lit, expected.light_loaded)
    // rust: );
    // rust: for (a, b) in actual.sections.iter().zip(&expected.sections) {
    // rust: assert_eq!(
    // rust: std::mem::discriminant(&a.light),
    // rust: std::mem::discriminant(&b.light)
    // rust: );
    // rust: assert_eq!(
    // rust: format!("{:?}", a.blocks.to_wire()),
    // rust: format!("{:?}", b.blocks.to_wire())
    // rust: );
    // rust: assert_eq!(
    // rust: format!("{:?}", a.biomes.to_wire()),
    // rust: format!("{:?}", b.biomes.to_wire())
    // rust: );
    // rust: for i in 0..4096 {
    // rust: assert_eq!(a.light(i), b.light(i), "index {i}, sky {sky_light}");
}
}
}
}
    // rust: for tag in [
    // rust: Tag::compound(Vec::<(&str, Tag)>::new()),
    // rust: Tag::compound([("isLightOn", Tag::Byte(0))]),
    // rust: Tag::compound([("isLightOn", Tag::Byte(2))]),
    // rust: Tag::compound([("isLightOn", Tag::Int(1)), ("sections", Tag::List(vec![]))]),
    // rust: Tag::compound([("isLightOn", Tag::Byte(1)), ("sections", Tag::Int(0))]),
    // rust: root(vec![]),
    // rust: ] {
    // rust: check(&tag);
}
        // Cover every repeated byte, including 0xF0/0x0F: a uniform byte
        // array need not hold uniform nibbles.
    // rust: for byte in 0..=255u8 {
    // rust: check(&root(vec![section(
    // rust: Tag::Byte(19),
    // rust: Some(Tag::ByteArray(vec![byte; 2048])),
    // rust: Some(Tag::ByteArray(vec![255 - byte; 2048])),
    // rust: )]));
}
        // Every pair of uniform sky/block nibble values, with missing
        // sections below inheriting the stored bottom row.
    // rust: for sky in 0..16u8 {
    // rust: for block in 0..16u8 {
    // rust: check(&root(vec![section(
    // rust: Tag::Byte(1),
    // rust: Some(Tag::ByteArray(vec![sky * 17; 2048])),
    // rust: Some(Tag::ByteArray(vec![block * 17; 2048])),
    // rust: )]));
}
}
    // rust: for length in [0, 1, 2047, 2048, 2049] {
    // rust: for invalid in [
    // rust: Tag::Int(1),
    // rust: Tag::List(vec![]),
    // rust: Tag::ByteArray(vec![0xf0; length]),
    // rust: ] {
    // rust: check(&root(vec![section(
    // rust: Tag::Byte(-4),
    // rust: Some(invalid.clone()),
    // rust: Some(invalid),
    // rust: )]));
}
}
    // rust: let varied: Vec<u8> = (0..2048)
    // rust: .map(|i| (i as u8).wrapping_mul(73).wrapping_add(31))
    // rust: .collect();
    // rust: check(&root(vec![
    // rust: section(Tag::Byte(-5), Some(Tag::ByteArray(varied.clone())), None),
    // rust: section(Tag::Byte(20), Some(Tag::ByteArray(varied.clone())), None),
    // rust: section(
    // rust: Tag::String("19".into()),
    // rust: Some(Tag::ByteArray(varied.clone())),
    // rust: None,
    // rust: ),
    // rust: section(Tag::Byte(19), Some(Tag::ByteArray(varied.clone())), None),
    // rust: section(Tag::Byte(17), None, Some(Tag::ByteArray(varied.clone()))),
    // rust: section(Tag::Byte(-4), Some(Tag::ByteArray(varied.clone())), None),
            // Last duplicate wins, even when its arrays have wrong types.
    // rust: section(
    // rust: Tag::Byte(-4),
    // rust: Some(Tag::Int(15)),
    // rust: Some(Tag::ByteArray(vec![7; 2047])),
    // rust: ),
    // rust: section(Tag::Byte(0), None, Some(Tag::ByteArray(varied))),
    // rust: ]));
}
    /// #2571: the difficulty is a property of the world: the level data
    /// holds it, so a world that was set to hard is hard when it is opened
    /// again, and a world that was downloaded keeps the difficulty it was
    /// made with.
pub fn the_level_data_holds_the_difficulty() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-difficulty-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: let mut level = Level {
    // rust: name: "Test".into(),
    // rust: ..Level::default()
}
        // The world's difficulty is the level data's.
    // rust: level.set_difficulty(3);
    // rust: assert_eq!(level.difficulty, "hard");
    // rust: assert_eq!(level.difficulty_id(), 3);
        // It survives the save, so the world comes back with it.
    // rust: level.write(&dir).unwrap();
    // rust: let back = Level::read(&dir).unwrap();
    // rust: assert_eq!(back.difficulty, "hard");
    // rust: assert_eq!(back.difficulty_id(), 3);
        // A world whose difficulty is not one of ours is normal.
    // rust: let other = Level {
    // rust: difficulty: "extreme".into(),
    // rust: ..Level::default()
}
    // rust: assert_eq!(other.difficulty_id(), 2);
    // rust: let _ = fs::remove_dir_all(&dir);
}

    /// Dedicated world saves must not overwrite separately managed player data.
pub fn dedicated_world_save_preserves_player_file() void {
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-dedicated-player-save-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = fs::remove_dir_all(&dir);

    // rust: let mut level = Level {
    // rust: name: "Test".into(),
    // rust: position: Some([12.5, 70.0, -8.25]),
    // rust: inventory: vec![(0, "minecraft:diamond".into(), 7, 0)],
    // rust: ..Level::default()
}

        // Create a real player file using the existing singleplayer writer.
    // rust: level.write(&dir).unwrap();
    // rust: let uuid = level.player_uuid.unwrap();
    // rust: let player_file = dir
    // rust: .join("players")
    // rust: .join("data")
    // rust: .join(format!("{}.dat", uuid_text(uuid)));

    // rust: let before = fs::read(&player_file).unwrap();

        // Simulate an incomplete world-level player state.
    // rust: level.position = None;
    // rust: level.inventory.clear();
    // rust: level.day_time = 12345;

        // Dedicated saves must update metadata without touching player data.
    // rust: level.write_without_player(&dir).unwrap();

    // rust: let after = fs::read(&player_file).unwrap();
    // rust: assert_eq!(before, after, "dedicated save overwrote player data");

        // The world metadata must still be persisted.
    // rust: let reopened = Level::read(&dir).unwrap();
    // rust: assert_eq!(reopened.day_time, 12345);

    // rust: let _ = fs::remove_dir_all(&dir);
}

pub fn level_round_trips_through_the_vanilla_files() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-level-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: let mut level = Level {
    // rust: name: "Test".into(),
    // rust: seed: -42,
    // rust: time: 1234,
    // rust: day_time: 25000,
    // rust: creative: true,
    // rust: position: Some([1.5, 70.0, -3.25]),
    // rust: rotation: [90.0, 10.0],
    // rust: health: 17.0,
    // rust: absorption: 5.0,
    // rust: food: 15,
    // rust: saturation: 2.5,
    // rust: inventory: vec![
    // rust: (0, "minecraft:stone".into(), 12, 0),
    // rust: (5, "minecraft:iron_sword".into(), 1, 3),
    // rust: (103, "minecraft:iron_helmet".into(), 1, 0),
    // rust: ],
    // rust: xp_level: 3,
    // rust: xp_progress: 0.5,
    // rust: xp_total: 30,
    // rust: dimension: "minecraft:the_nether".into(),
    // rust: world_spawn: Some([8, 64, 8]),
    // rust: world_spawn_angle: [45.0, -10.0],
    // rust: spawn: Some([20.0, 70.0, 20.0]),
    // rust: difficulty_locked: true,
    // rust: flying: true,
    // rust: ..Level::default()
}
    // rust: level.weather.raining = true;
    // rust: level.weather.rain_time = 500;
    // rust: level.game_rules.insert("keep_inventory".into(), 1);
    // rust: level.write(&dir).unwrap();
    // rust: let back = Level::read(&dir).unwrap();
    // rust: assert_eq!(back.name, "Test");
    // rust: assert_eq!(back.seed, -42);
    // rust: assert_eq!((back.time, back.day_time), (1234, 25000));
    // rust: assert!(back.creative);
    // rust: assert!(back.flying);
    // rust: assert_eq!(back.position, Some([1.5, 70.0, -3.25]));
    // rust: assert_eq!(back.rotation, [90.0, 10.0]);
    // rust: assert_eq!((back.health, back.food, back.saturation), (17.0, 15, 2.5));
    // rust: assert_eq!(back.absorption, 5.0);
    // rust: let mut inv = back.inventory.clone();
    // rust: inv.sort();
    // rust: assert_eq!(
    // rust: inv,
    // rust: vec![
    // rust: (0, "minecraft:stone".into(), 12, 0),
    // rust: (5, "minecraft:iron_sword".into(), 1, 3),
    // rust: (103, "minecraft:iron_helmet".into(), 1, 0)
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: (back.xp_level, back.xp_progress, back.xp_total),
    // rust: (3, 0.5, 30)
    // rust: );
    // rust: assert_eq!(back.dimension, "minecraft:the_nether");
    // rust: assert_eq!(back.world_spawn, Some([8, 64, 8]));
    // rust: assert_eq!(back.world_spawn_angle, [45.0, -10.0]);
    // rust: assert_eq!(back.spawn, Some([20.0, 70.0, 20.0]));
    // rust: assert!(back.difficulty_locked);
    // rust: assert!(back.weather.raining);
    // rust: assert_eq!(back.weather.rain_time, 500);
    // rust: assert_eq!(back.game_rule("keep_inventory"), 1);
    // rust: assert_eq!(back.game_rule("random_tick_speed"), 3);
        // Unknown player data survives another save.
    // rust: let mut extra = back.player_extra.clone().unwrap();
    // rust: put(
    // rust: &mut extra,
    // rust: "ShoulderEntityLeft",
    // rust: Tag::compound([("id", string("minecraft:parrot"))]),
    // rust: );
    // rust: let mut ender = vec![None; 27];
    // rust: ender[3] = Some(crate::items::ItemStack::new("minecraft:diamond", 2));
    // rust: let mut again = Level {
    // rust: player_extra: Some(extra),
    // rust: ender_items: ender,
            // The live amount, not the one the loaded compound held (#1307).
    // rust: absorption: 2.0,
    // rust: ..back
}
    // rust: again.write(&dir).unwrap();
    // rust: let third = Level::read(&dir).unwrap();
    // rust: assert_eq!(third.absorption, 2.0);
    // rust: assert!(matches!(
    // rust: third
    // rust: .player_extra
    // rust: .as_ref()
    // rust: .and_then(|p| p.get("ShoulderEntityLeft")),
    // rust: Some(Tag::Compound(_))
    // rust: ));
        // EnderItems round-trip by slot.
    // rust: assert_eq!(
    // rust: third.ender_items[3].as_ref().map(|s| (&*s.item, s.count)),
    // rust: Some(("minecraft:diamond", 2))
    // rust: );
        // A dead player's empty inventory replaces the previously loaded items.
    // rust: let mut dead = third;
    // rust: dead.health = 0.0;
    // rust: dead.inventory.clear();
    // rust: dead.inventory_components.clear();
    // rust: dead.write(&dir).unwrap();
    // rust: let dead = Level::read(&dir).unwrap();
    // rust: assert_eq!(dead.health, 0.0);
    // rust: assert!(dead.inventory.is_empty());
    // rust: assert!(dead.inventory_components.is_empty());
    // rust: assert!(dead.player_extra.unwrap().get("equipment").is_none());
    // rust: assert!(dir.join("data/minecraft/world_gen_settings.dat").exists());
    // rust: let _ = fs::remove_dir_all(&dir);
}

pub fn effects_that_ended_are_not_saved_again() void {
}
        // A player loaded with an effect that has since run out: the loaded
        // compound still holds it, but the save writes only what is active.
    // rust: let mut level = Level {
    // rust: active_effects: vec![("minecraft:speed".into(), 200, 1, false, true)],
    // rust: ..Level::default()
}
    // rust: let loaded = level.player_tag();
    // rust: assert!(loaded.get("active_effects").is_some());
    // rust: level.player_extra = Some(loaded);
    // rust: level.active_effects.clear();
    // rust: assert!(level.player_tag().get("active_effects").is_none());
}

pub fn effect_amplifier_255_reloads_as_an_unsigned_byte() void {
}
        // `MobEffectInstance.MAX_AMPLIFIER` is 255. `Details.MAP_CODEC` writes
        // it with `ExtraCodecs.UNSIGNED_BYTE`: `255.byteValue()` is -1 and
        // `128.byteValue()` is -128; `UnsignedBytes.toInt` restores both.
    // rust: let effects = vec![
    // rust: ("minecraft:strength".into(), -1, 255, false, true),
    // rust: ("minecraft:regeneration".into(), -1, 128, false, true),
    // rust: ("minecraft:speed".into(), 40, 1, false, true),
    // rust: ];
    // rust: let level = Level {
    // rust: active_effects: effects.clone(),
    // rust: ..Level::default()
}
    // rust: let tag = level.player_tag();
    // rust: let Tag::List(saved) = tag.get("active_effects").expect("active_effects") else {
    // rust: panic!("active_effects list");
}
    // rust: assert_eq!(
    // rust: saved
    // rust: .iter()
    // rust: .map(|e| e.get("amplifier").cloned())
    // rust: .collect::<Vec<_>>(),
    // rust: vec![
    // rust: Some(Tag::Byte(-1)),
    // rust: Some(Tag::Byte(-128)),
    // rust: Some(Tag::Byte(1)),
    // rust: ]
    // rust: );
    // rust: let mut loaded = Level::default();
    // rust: loaded.read_player(&tag);
    // rust: assert_eq!(loaded.active_effects, effects);
}

pub fn creative_flight_status_persists_in_save_and_resets_for_survival() void {
}
    // rust: let mut level = Level {
    // rust: creative: true,
    // rust: flying: true,
    // rust: ..Level::default()
}
    // rust: let tag = level.player_tag();
    // rust: let flying_byte = tag
    // rust: .get("abilities")
    // rust: .and_then(|a| number(a.get("flying")))
    // rust: .unwrap_or(0);
    // rust: assert_eq!(flying_byte, 1);

    // rust: let mut loaded = Level::default();
    // rust: loaded.read_player(&tag);
    // rust: assert!(loaded.flying);

        // Survival mode resets flying ability to 0 in save.
    // rust: level.creative = false;
    // rust: level.game_mode = 0;
    // rust: let tag_survival = level.player_tag();
    // rust: let flying_survival = tag_survival
    // rust: .get("abilities")
    // rust: .and_then(|a| number(a.get("flying")))
    // rust: .unwrap_or(0);
    // rust: assert_eq!(flying_survival, 0);
}

pub fn unconsumed_root_vehicle_keeps_the_complete_vanilla_tree() void {
}
    // rust: let entity = Tag::compound([
    // rust: ("id", Tag::String("minecraft:horse".into())),
    // rust: ("UUID", uuid_tag([5, 6, 7, 8])),
    // rust: (
    // rust: "Passengers",
    // rust: Tag::List(vec![Tag::compound([
    // rust: ("id", Tag::String("minecraft:pig".into())),
    // rust: ("UUID", uuid_tag([1, 2, 3, 4])),
    // rust: ])]),
    // rust: ),
    // rust: ]);
    // rust: let vehicle = Tag::compound([("Attach", uuid_tag([1, 2, 3, 4])), ("Entity", entity)]);
    // rust: let raw = Tag::compound([("RootVehicle", vehicle.clone())]);
    // rust: let mut level = Level::default();
    // rust: level.read_player(&raw);
    // rust: level.player_extra = Some(raw);
    // rust: assert_eq!(level.root_vehicle, Some([1, 2, 3, 4]));
    // rust: assert_eq!(level.player_tag().get("RootVehicle"), Some(&vehicle));
        // Even saving before the vehicle is restored must not destroy it.
    // rust: level.root_vehicle = None;
    // rust: assert_eq!(level.player_tag().get("RootVehicle"), Some(&vehicle));
}

    /// `RecipesUsed` is what a furnace owes in experience, so a save that drops it pays the
    /// player nothing after a reload.
pub fn a_furnaces_recipes_used_survive_a_save() void {
}
//         use crate::containers::BlockEntity;
    // rust: let Some(BlockEntity::Furnace(mut f)) = BlockEntity::for_block("minecraft:furnace") else {
    // rust: panic!("a furnace");
}
    // rust: f.recipes_used
    // rust: .insert("minecraft:cooked_porkchop".to_owned(), 3);
    // rust: let tag = encode_block_entity((1, 64, 2), &BlockEntity::Furnace(f), "minecraft:furnace");
    // rust: let Some((_, BlockEntity::Furnace(back))) = decode_block_entity(&tag) else {
    // rust: panic!("a furnace back");
}
    // rust: assert_eq!(back.recipes_used.get("minecraft:cooked_porkchop"), Some(&3));
}
    /// The world's save (Level.write) writes the rules as they are now, and a
    /// world opened again reads them back (#74).
pub fn level_save_keeps_changed_rules() void {
}
//         use crate::gamerules::{GameRules, Value};
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-gamerules-level-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let mut level = super::Level::default();
    // rust: level.write(&dir).unwrap();
        // Rules changed while playing, then saved and loaded again.
    // rust: let mut rules = GameRules::load(&dir);
    // rust: assert_eq!(rules, GameRules::default());
    // rust: assert!(rules.set("advance_time", Value::Bool(false)));
    // rust: assert!(rules.set("advance_weather", Value::Bool(false)));
    // rust: assert!(rules.set("random_tick_speed", Value::Int(0)));
    // rust: level.game_rules = rules.by_name();
    // rust: level.write(&dir).unwrap();
    // rust: assert_eq!(GameRules::load(&dir), rules);
    // rust: let read = super::Level::read(&dir).unwrap();
    // rust: assert_eq!(read.game_rules, rules.by_name());
    // rust: assert_eq!(read.game_rule("advance_time"), 0);
    // rust: let _ = std::fs::remove_dir_all(dir);
}

    /// A save written before the key was namespaced holds an id twice, once bare: vanilla
    /// refuses such a furnace, so a load merges them under the full id.
pub fn a_furnaces_recipes_used_merges_bare_and_full_ids() void {
}
//         use crate::containers::BlockEntity;
    // rust: let Some(BlockEntity::Furnace(mut f)) = BlockEntity::for_block("minecraft:furnace") else {
    // rust: panic!("a furnace");
}
    // rust: f.recipes_used
    // rust: .insert("iron_ingot_from_smelting_iron_ore".to_owned(), 2);
    // rust: f.recipes_used
    // rust: .insert("minecraft:iron_ingot_from_smelting_iron_ore".to_owned(), 3);
    // rust: let tag = encode_block_entity((1, 64, 2), &BlockEntity::Furnace(f), "minecraft:furnace");
    // rust: let Some((_, BlockEntity::Furnace(back))) = decode_block_entity(&tag) else {
    // rust: panic!("a furnace back");
}
    // rust: assert_eq!(back.recipes_used.len(), 1);
    // rust: assert_eq!(
    // rust: back.recipes_used
    // rust: .get("minecraft:iron_ingot_from_smelting_iron_ore"),
    // rust: Some(&5)
    // rust: );
}

    /// `WorldDataConfiguration.MAP_CODEC`'s `lenientOptionalFieldOf
    /// ("enabled_features", DEFAULT_FLAGS)`: a picked experiment's list
    /// round-trips, a vanilla-only selection leaves the tag out.
pub fn enabled_features_round_trip_and_omit_the_vanilla_default() void {
}
    // rust: let dir = gen_world("enabled-features");
    // rust: let mut level = Level {
    // rust: name: "Features".into(),
    // rust: enabled_features: vec![
    // rust: "minecraft:vanilla".into(),
    // rust: "minecraft:minecart_improvements".into(),
    // rust: ],
    // rust: ..Level::default()
}
    // rust: level.write(&dir).unwrap();
    // rust: let back = Level::read(&dir).unwrap();
    // rust: assert_eq!(back.enabled_features, level.enabled_features);
        // The tag is in the file.
    // rust: let raw = crate::save::read_level_dat(&dir).unwrap();
    // rust: if let Tag::Compound(data) = &raw {
    // rust: let data = data.get(&JavaString::from("Data")).unwrap();
    // rust: assert!(matches!(data.get("enabled_features"), Some(Tag::List(_))));
}
        // A vanilla-only selection writes no tag, and reads back as the
        // same vanilla-only list. A fresh folder: write_internal keeps an
        // older file's fields.
    // rust: let dir2 = gen_world("enabled-features-vanilla");
    // rust: level.enabled_features = vec!["minecraft:vanilla".into()];
    // rust: level.write(&dir2).unwrap();
    // rust: let raw = crate::save::read_level_dat(&dir2).unwrap();
    // rust: if let Tag::Compound(data) = &raw {
    // rust: let data = data.get(&JavaString::from("Data")).unwrap();
    // rust: assert!(data.get("enabled_features").is_none());
}
    // rust: let back = Level::read(&dir2).unwrap();
        // The read side keeps its own convention: empty is the vanilla
        // default the file omitted.
    // rust: assert!(back.enabled_features.is_empty());
    // rust: let _ = fs::remove_dir_all(dir);
    // rust: let _ = fs::remove_dir_all(dir2);
}

pub fn gen_world(name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-{name}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

    /// `WorldOpenFlows.openWorldCheckWorldStemCompatibility`: every world a preset makes is
    /// stable, and a world with a changed dimension, a custom one or a customized generator
    /// is asked about.
pub fn world_stem_compatibility_flags_unstable_and_customized_worlds() void {
}
    // rust: for preset in [
    // rust: WorldPreset::Normal,
    // rust: WorldPreset::Flat,
    // rust: WorldPreset::LargeBiomes,
    // rust: WorldPreset::Amplified,
    // rust: WorldPreset::SingleBiomeSurface,
    // rust: WorldPreset::Debug,
    // rust: ] {
    // rust: let dir = gen_world("stem-stable");
    // rust: write_world_gen_settings(
    // rust: &dir,
    // rust: 7,
    // rust: WorldGen {
    // rust: preset,
    // rust: structures: true,
    // rust: bonus_chest: false,
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: assert!(!world_gen_unstable(&dir), "{preset:?}");
    // rust: assert!(!is_old_customized_world(&dir));
    // rust: let _ = fs::remove_dir_all(dir);
}
        // Without world_gen_settings there is nothing to ask about.
    // rust: let dir = gen_world("stem-none");
    // rust: assert!(!world_gen_unstable(&dir) && !is_old_customized_world(&dir));
    // rust: let _ = fs::remove_dir_all(dir);

    // rust: let dir = gen_world("stem-edit");
    // rust: write_world_gen_settings(&dir, 7, WorldGen::default()).unwrap();
    // rust: let settings = world_gen_settings(&dir).unwrap();
    // rust: let edit = |change: &dyn Fn(&mut Tag)| {
    // rust: let mut tag = settings.clone();
    // rust: change(&mut tag);
    // rust: write_saved_data(&dir, "world_gen_settings", tag).unwrap();
}
    // rust: fn dimension<'a>(tag: &'a mut Tag, key: &str) -> &'a mut Tag {
    // rust: tag.get_mut("dimensions").unwrap().get_mut(key).unwrap()
}
        // A custom biome source in the Nether is not the preset.
    // rust: edit(&|tag| {
    // rust: let nether = dimension(tag, "minecraft:the_nether");
    // rust: let generator = nether.get_mut("generator").unwrap();
    // rust: *generator.get_mut("biome_source").unwrap() = Tag::compound([
    // rust: ("type", string("minecraft:fixed")),
    // rust: ("biome", string("minecraft:plains")),
    // rust: ]);
    // rust: });
    // rust: assert!(world_gen_unstable(&dir));
        // The End on another dimension type.
    // rust: edit(&|tag| {
    // rust: let end = dimension(tag, "minecraft:the_end");
    // rust: *end.get_mut("type").unwrap() = string("minecraft:overworld");
    // rust: });
    // rust: assert!(world_gen_unstable(&dir));
        // Another noise settings in the Overworld is fine (amplified), in the Nether it is not.
    // rust: edit(&|tag| {
    // rust: let nether = dimension(tag, "minecraft:the_nether");
    // rust: *nether
    // rust: .get_mut("generator")
    // rust: .unwrap()
    // rust: .get_mut("settings")
    // rust: .unwrap() = string("minecraft:overworld");
    // rust: });
    // rust: assert!(world_gen_unstable(&dir));
        // A fourth dimension, and a missing builtin one.
    // rust: edit(&|tag| {
    // rust: if let Some(Tag::Compound(dimensions)) = tag.get_mut("dimensions") {
    // rust: let end = dimensions.get(&"minecraft:the_end".into()).unwrap().clone();
    // rust: dimensions.insert("mypack:moon".into(), end);
}
    // rust: });
    // rust: assert!(world_gen_unstable(&dir));
    // rust: edit(&|tag| {
    // rust: if let Some(Tag::Compound(dimensions)) = tag.get_mut("dimensions") {
    // rust: dimensions.remove(&"minecraft:the_end".into());
}
    // rust: });
    // rust: assert!(world_gen_unstable(&dir));
        // legacy_custom_options marks an old customized world.
    // rust: edit(&|tag| {
    // rust: if let Tag::Compound(map) = tag {
    // rust: map.insert("legacy_custom_options".into(), string("{\"seaLevel\":63}"));
}
    // rust: });
    // rust: assert!(is_old_customized_world(&dir));
    // rust: let _ = fs::remove_dir_all(dir);
}

    /// `WorldOpenFlows.loadWorldStem`: the enabled data packs' level stems are the base of
    /// `WorldDimensions.bake`, replacing the saved one of their id.
pub fn world_stem_compatibility_reads_data_pack_dimensions() void {
}
    // rust: let dir = gen_world("stem-datapack");
    // rust: write_world_gen_settings(&dir, 7, WorldGen::default()).unwrap();
    // rust: assert!(!world_gen_unstable(&dir));
    // rust: let write = |pack: &str, file: &str, text: &str| {
    // rust: let path = dir.join("datapacks").join(pack).join(file);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: write("p", "pack.mcmeta", "{}");
        // A pack's dimension of another id is not vanilla-like.
    // rust: write(
    // rust: "p",
    // rust: "data/mypack/dimension/moon.json",
    // rust: r#"{"type":"minecraft:the_end","generator":{"type":"minecraft:noise","settings":"minecraft:end","biome_source":{"type":"minecraft:the_end"}}}"#,
    // rust: );
    // rust: assert!(world_gen_unstable(&dir));
        // Disabled, it counts for nothing.
    // rust: fs::write(dir.join("datapacks.json"), r#"{"disabled":["file/p"]}"#).unwrap();
    // rust: assert!(!world_gen_unstable(&dir));
    // rust: fs::remove_file(dir.join("datapacks.json")).unwrap();
    // rust: fs::remove_file(dir.join("datapacks/p/data/mypack/dimension/moon.json")).unwrap();
    // rust: assert!(!world_gen_unstable(&dir));
        // A pack's Nether with another biome source replaces the saved vanilla one.
    // rust: write(
    // rust: "p",
    // rust: "data/minecraft/dimension/the_nether.json",
    // rust: r#"{"type":"minecraft:the_nether","generator":{"type":"minecraft:noise","settings":"minecraft:nether","biome_source":{"type":"minecraft:fixed","biome":"minecraft:plains"}}}"#,
    // rust: );
    // rust: assert!(world_gen_unstable(&dir));
        // And a vanilla-like one stays stable.
    // rust: write(
    // rust: "p",
    // rust: "data/minecraft/dimension/the_nether.json",
    // rust: r#"{"type":"minecraft:the_nether","generator":{"type":"minecraft:noise","settings":"minecraft:nether","biome_source":{"type":"minecraft:multi_noise","preset":"minecraft:nether"}}}"#,
    // rust: );
    // rust: assert!(!world_gen_unstable(&dir));
    // rust: let _ = fs::remove_dir_all(dir);
}

    /// A world that still needs its file fixes keeps its generator settings in level.dat; they
    /// are read as the fixes would leave them, so the question is asked on the first open.
pub fn world_gen_settings_of_a_world_needing_file_fixes_are_read_in_memory() void {
}
    // rust: let dir = gen_world("stem-prefix");
    // rust: write_world_gen_settings(&dir, 7, WorldGen::default()).unwrap();
    // rust: let settings = world_gen_settings(&dir).unwrap();
    // rust: let customized = {
    // rust: let mut tag = settings.clone();
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.insert("legacy_custom_options".into(), string("{\"seaLevel\":63}"));
}
    // rust: tag
}
        // 26.3 layout moved back to the old one: settings in level.dat, no saved data file.
    // rust: fs::remove_file(saved_data_path(&dir, "world_gen_settings")).unwrap();
    // rust: write_dat(
    // rust: &dir.join("level.dat"),
    // rust: Tag::compound([(
    // rust: "Data",
    // rust: Tag::compound([
    // rust: ("DataVersion", Tag::Int(4700)),
    // rust: ("WorldGenSettings", customized),
    // rust: ]),
    // rust: )]),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(needs_file_fixes(&dir));
    // rust: let read = world_gen_settings(&dir).expect("settings");
    // rust: assert!(read.get("dimensions").is_some());
    // rust: assert!(!world_gen_unstable(&dir));
    // rust: let _ = fs::remove_dir_all(dir);
}

pub fn low_disk_space_is_under_64_mib_usable() void {
}
    // rust: assert_eq!(LOW_DISK_SPACE, 64 * 1024 * 1024);
    // rust: let dir = std::env::temp_dir();
    // rust: assert!(estimate_disk_space(&dir) > 0);
    // rust: assert_eq!(
    // rust: low_disk_space(&dir),
    // rust: estimate_disk_space(&dir) < LOW_DISK_SPACE
    // rust: );
        // A path that does not exist cannot be asked: vanilla reads that as plenty.
    // rust: assert_eq!(
    // rust: estimate_disk_space(&dir.join("horizon-no-such-folder/x")),
    // rust: u64::MAX
    // rust: );
}

pub fn mod_attachments_save_in_horizons_namespace_only_when_some() void {
}
//         use horizon_world::attachments::Attachments;
    // rust: let root = std::env::temp_dir().join(format!("horizon-attach-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let save = SaveDir::new(root.clone(), LevelShape::OVERWORLD);
    // rust: let file = root.join("data/horizon/attachments.dat");
    // rust: save.save_attachments(&Attachments::default()).unwrap();
    // rust: assert!(
    // rust: !root.join("data").exists(),
    // rust: "a level without mod data writes nothing"
    // rust: );
    // rust: let data = Compound::from_iter([("example:count".into(), Tag::Int(3))]);
    // rust: save.save_attachments(&Attachments::from_nbt(data.clone()))
    // rust: .unwrap();
    // rust: assert!(file.is_file());
    // rust: assert_eq!(save.load_attachments().to_nbt(), data);
    // rust: fs::write(&file, b"not nbt").unwrap();
    // rust: assert!(save.load_attachments().to_nbt().is_empty());
    // rust: assert_eq!(
    // rust: fs::read(root.join("data/horizon/attachments.dat.corrupt")).unwrap(),
    // rust: b"not nbt"
    // rust: );
    // rust: assert!(!file.exists());
    // rust: fs::remove_dir_all(&root).unwrap();
}

pub fn forced_chunks_survive_dimension_restarts_and_removals() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-forced-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let dimensions = [
    // rust: "minecraft:overworld",
    // rust: "minecraft:the_nether",
    // rust: "minecraft:the_end",
    // rust: ];
    // rust: for (i, dim) in dimensions.iter().enumerate() {
    // rust: let save = SaveDir::new(dimension_dir(&root, dim), LevelShape::OVERWORLD);
    // rust: assert!(save.load_forced_chunks().is_empty());
    // rust: let forced = HashSet::from([(i as i32, -17), (-23, i as i32), (-1, -1)]);
    // rust: save.save_forced_chunks(&forced).unwrap();
}
    // rust: for (i, dim) in dimensions.iter().enumerate() {
    // rust: let path = dimension_dir(&root, dim);
    // rust: let save = SaveDir::new(path.clone(), LevelShape::OVERWORLD);
    // rust: let mut forced = save.load_forced_chunks();
    // rust: assert_eq!(
    // rust: forced,
    // rust: HashSet::from([(i as i32, -17), (-23, i as i32), (-1, -1)])
    // rust: );
    // rust: let mut data = read_saved_data(&path, "chunk_tickets").unwrap();
    // rust: let other = Tag::compound([
    // rust: ("type", Tag::String("minecraft:portal".into())),
    // rust: ("level", Tag::Int(30)),
    // rust: ("chunk_pos", Tag::IntArray(vec![7, -8])),
    // rust: ("ticks_left", Tag::Long(42)),
    // rust: ]);
    // rust: if let Some(Tag::List(tickets)) = data.get_mut("tickets") {
    // rust: assert!(
    // rust: tickets
    // rust: .iter()
    // rust: .all(|t| t.get("level") == Some(&Tag::Int(31)))
    // rust: );
    // rust: tickets.push(other.clone());
}
    // rust: write_saved_data(&path, "chunk_tickets", data).unwrap();
    // rust: forced.remove(&(-1, -1));
    // rust: save.save_forced_chunks(&forced).unwrap();
    // rust: drop(save);
    // rust: let reopened = SaveDir::new(path.clone(), LevelShape::OVERWORLD);
    // rust: assert_eq!(reopened.load_forced_chunks(), forced);
    // rust: reopened.save_forced_chunks(&HashSet::new()).unwrap();
    // rust: assert!(
    // rust: SaveDir::new(path.clone(), LevelShape::OVERWORLD)
    // rust: .load_forced_chunks()
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(
    // rust: read_saved_data(&path, "chunk_tickets")
    // rust: .unwrap()
    // rust: .get("tickets"),
    // rust: Some(&Tag::List(vec![other]))
    // rust: );
}
    // rust: fs::remove_dir_all(root).unwrap();
}

    /// The Debug preset (`worldgen/world_preset/debug_all_block_states.json`): its id names it,
    /// the saved overworld generator is `minecraft:debug` and reads back as it, and the create
    /// screen's button never cycles to it.
pub fn the_debug_preset_is_saved_and_read_back() void {
}
    // rust: assert_eq!(
    // rust: WorldPreset::of_id("minecraft:debug_all_block_states"),
    // rust: Some(WorldPreset::Debug)
    // rust: );
    // rust: assert!(!WorldPreset::ALL.contains(&WorldPreset::Debug));
    // rust: let dir = gen_world("debug-preset");
    // rust: write_world_gen_settings(
    // rust: &dir,
    // rust: 7,
    // rust: WorldGen {
    // rust: preset: WorldPreset::Debug,
    // rust: structures: true,
    // rust: bonus_chest: false,
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: let settings = world_gen_settings(&dir).unwrap();
    // rust: let generator = settings
    // rust: .get("dimensions")
    // rust: .and_then(|d| d.get("minecraft:overworld"))
    // rust: .and_then(|o| o.get("generator"))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: text(generator.get("type")).as_deref(),
    // rust: Some("minecraft:debug")
    // rust: );
    // rust: assert_eq!(WorldGen::read(&dir).unwrap().preset, WorldPreset::Debug);
    // rust: let _ = fs::remove_dir_all(dir);
}

pub fn world_preset_next_and_prev_cycle_bidirectionally() void {
}
    // rust: let first = WorldPreset::Normal;
    // rust: assert_eq!(first.next(), WorldPreset::Flat);
    // rust: assert_eq!(first.prev(), WorldPreset::SingleBiomeSurface);
    // rust: assert_eq!(WorldPreset::SingleBiomeSurface.next(), WorldPreset::Normal);
    // rust: for preset in WorldPreset::ALL {
    // rust: assert_eq!(preset.next().prev(), preset);
    // rust: assert_eq!(preset.prev().next(), preset);
}
}
    /// A region record of the dimension folder `save` at chunk (0, 0), written
    /// as an older version left it.
pub fn write_old_record(save: *SaveDir, folder: []const u8, tag: Tag) void {
}
    // rust: let record = Record::Tag(Arc::new(NamedTag {
    // rust: name: "".into(),
    // rust: tag,
    // rust: }));
    // rust: let cache = match Folder::of(folder) {
    // rust: Folder::Region => &save.regions,
    // rust: Folder::Entities => &save.entity_regions,
    // rust: Folder::Poi => &save.poi_regions,
}
    // rust: super::write_region_records(&save.root, cache, folder, &[((0, 0), &record)]).unwrap();
}

pub fn older_records_of_a_current_world_upgrade_as_they_are_read() void {
}
    // rust: let world = std::env::temp_dir().join(format!("horizon-lazy-dv-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&world);
    // rust: let save = SaveDir::new(
    // rust: super::dimension_dir(&world, "minecraft:overworld"),
    // rust: LevelShape::OVERWORLD,
    // rust: );
        // A 1.20.1 chunk (DataVersion 3465): 1.20.3 renamed its grass to short_grass.
    // rust: let section = Tag::compound([
    // rust: ("Y", Tag::Byte(-4)),
    // rust: (
    // rust: "block_states",
    // rust: Tag::compound([(
    // rust: "palette",
    // rust: Tag::List(vec![Tag::compound([("Name", string("minecraft:grass"))])]),
    // rust: )]),
    // rust: ),
    // rust: (
    // rust: "biomes",
    // rust: Tag::compound([("palette", Tag::List(vec![string("minecraft:plains")]))]),
    // rust: ),
    // rust: ]);
    // rust: write_old_record(
    // rust: &save,
    // rust: "region",
    // rust: Tag::compound([
    // rust: ("DataVersion", Tag::Int(3465)),
    // rust: ("xPos", Tag::Int(0)),
    // rust: ("zPos", Tag::Int(0)),
    // rust: ("yPos", Tag::Int(-4)),
    // rust: ("Status", string("minecraft:full")),
    // rust: ("sections", Tag::List(vec![section])),
    // rust: ]),
    // rust: );
    // rust: let chunk = save.raw_chunk(0, 0).expect("the chunk reads");
    // rust: assert_eq!(
    // rust: number(chunk.tag.get("DataVersion")),
    // rust: Some(i64::from(DATA_VERSION))
    // rust: );
    // rust: let Some(Tag::List(sections)) = chunk.tag.get("sections") else {
    // rust: panic!("no sections: {:?}", chunk.tag);
}
    // rust: let Some(Tag::List(palette)) = sections[0]
    // rust: .get("block_states")
    // rust: .and_then(|b| b.get("palette"))
    // rust: else {
    // rust: panic!("no palette");
}
    // rust: assert_eq!(
    // rust: text(palette[0].get("id")).as_deref(),
    // rust: Some("minecraft:short_grass")
    // rust: );
        // Decoded, it keeps its blocks: read raw, the 26.x decoder finds no `id` in a
        // 1.20 palette (`Name`) and the whole column is air.
    // rust: if let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES") {
    // rust: let root = PathBuf::from(root);
    // rust: let assets = crate::assets::Assets::load(&root).expect("assets");
    // rust: let biomes = Biomes::load(&root).expect("biomes");
    // rust: let grass = assets
    // rust: .registry
    // rust: .default_state("minecraft:short_grass")
    // rust: .unwrap();
    // rust: let loaded = save
    // rust: .load(0, 0, assets.registry, &biomes)
    // rust: .expect("the chunk loads");
    // rust: assert_eq!(loaded.get(3, -60, 7), grass.0);
}
        // A 1.20.1 item entity: 1.20.5 made its stack `count` (an int) from `Count`.
    // rust: write_old_record(
    // rust: &save,
    // rust: "entities",
    // rust: Tag::compound([
    // rust: ("DataVersion", Tag::Int(3465)),
    // rust: ("Position", Tag::IntArray(vec![0, 0])),
    // rust: (
    // rust: "Entities",
    // rust: Tag::List(vec![Tag::compound([
    // rust: ("id", string("minecraft:item")),
    // rust: (
    // rust: "Item",
    // rust: Tag::compound([
    // rust: ("id", string("minecraft:stone")),
    // rust: ("Count", Tag::Byte(3)),
    // rust: ]),
    // rust: ),
    // rust: ])]),
    // rust: ),
    // rust: ]),
    // rust: );
    // rust: let entities = save.load_entities(0, 0);
    // rust: let item = entities[0].get("Item").expect("the item stack");
    // rust: assert_eq!(item.get("count"), Some(&Tag::Int(3)));
    // rust: assert!(item.get("Count").is_none());
    // rust: let _ = std::fs::remove_dir_all(&world);
}

pub fn old_chunks_are_found_in_the_saved_records_and_old_poi_upgrade() void {
}
    // rust: let world = std::env::temp_dir().join(format!("horizon-lazy-old-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&world);
    // rust: let nether = SaveDir::new(
    // rust: super::dimension_dir(&world, "minecraft:the_nether"),
    // rust: LevelShape::NETHER,
    // rust: );
        // A 1.20.1 Nether chunk: upgraded it has no `blending_data` (only Overworld
        // chunks blend) and the current DataVersion, so only the saved record says
        // it is older than blending (4997), as `IOWorker.isOldChunk` reads it.
    // rust: write_old_record(
    // rust: &nether,
    // rust: "region",
    // rust: Tag::compound([
    // rust: ("DataVersion", Tag::Int(3465)),
    // rust: ("xPos", Tag::Int(0)),
    // rust: ("zPos", Tag::Int(0)),
    // rust: ("yPos", Tag::Int(0)),
    // rust: ("Status", string("minecraft:full")),
    // rust: ("sections", Tag::List(Vec::new())),
    // rust: ]),
    // rust: );
    // rust: let upgraded = nether.raw_chunk(0, 0).expect("the chunk reads");
    // rust: assert!(upgraded.tag.get("blending_data").is_none());
    // rust: assert_ne!(nether.old_chunk_bits(0, 0)[0] & 1, 0);
        // One chunk's record tells the same, without the region's other chunks; a chunk this
        // version saved, and one not saved, are not old.
    // rust: let current = Record::Tag(Arc::new(NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: ("xPos", Tag::Int(1)),
    // rust: ("zPos", Tag::Int(0)),
    // rust: ("yPos", Tag::Int(0)),
    // rust: ("Status", string("minecraft:full")),
    // rust: ("sections", Tag::List(Vec::new())),
    // rust: ]),
    // rust: }));
    // rust: super::write_region_records(
    // rust: &nether.root,
    // rust: &nether.regions,
    // rust: "region",
    // rust: &[((1, 0), &current)],
    // rust: )
    // rust: .unwrap();
    // rust: assert!(nether.is_old_chunk(0, 0));
    // rust: assert!(!nether.is_old_chunk(1, 0));
    // rust: assert!(!nether.is_old_chunk(2, 0));
    // rust: assert_eq!(nether.old_chunk_bits(0, 0)[0] & 0b110, 0);
        // A POI record of before 1.14.4 (no DataVersion, read as 1945): its
        // sections at the root, which 1946 moved under `Sections`.
    // rust: let overworld = SaveDir::new(
    // rust: super::dimension_dir(&world, "minecraft:overworld"),
    // rust: LevelShape::OVERWORLD,
    // rust: );
    // rust: write_old_record(
    // rust: &overworld,
    // rust: "poi",
    // rust: Tag::compound([(
    // rust: "0",
    // rust: Tag::compound([("Valid", Tag::Byte(1)), ("Records", Tag::List(Vec::new()))]),
    // rust: )]),
    // rust: );
    // rust: let poi = overworld.read_record("poi", 0, 0).expect("the POI reads");
    // rust: assert!(poi.tag.get("Sections").and_then(|s| s.get("0")).is_some());
    // rust: assert_eq!(
    // rust: number(poi.tag.get("DataVersion")),
    // rust: Some(i64::from(DATA_VERSION))
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&world);
}

pub fn a_chunk_from_before_1_18_is_brought_to_the_current_layout() void {
}
    // rust: let world = std::env::temp_dir().join(format!("horizon-lazy-117-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&world);
    // rust: let save = SaveDir::new(
    // rust: super::dimension_dir(&world, "minecraft:overworld"),
    // rust: LevelShape::OVERWORLD,
    // rust: );
        // A 1.17.1 chunk (DataVersion 2730), its fields under `Level`: section 0 all stone.
    // rust: let section = Tag::compound([
    // rust: ("Y", Tag::Byte(0)),
    // rust: (
    // rust: "Palette",
    // rust: Tag::List(vec![
    // rust: Tag::compound([("Name", string("minecraft:air"))]),
    // rust: Tag::compound([("Name", string("minecraft:stone"))]),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "BlockStates",
    // rust: Tag::LongArray(vec![0x1111_1111_1111_1111; 256]),
    // rust: ),
    // rust: ]);
    // rust: write_old_record(
    // rust: &save,
    // rust: "region",
    // rust: Tag::compound([
    // rust: ("DataVersion", Tag::Int(2730)),
    // rust: (
    // rust: "Level",
    // rust: Tag::compound([
    // rust: ("xPos", Tag::Int(0)),
    // rust: ("zPos", Tag::Int(0)),
    // rust: ("Status", string("full")),
    // rust: ("Biomes", Tag::IntArray(vec![1; 1024])),
    // rust: ("Sections", Tag::List(vec![section])),
    // rust: ]),
    // rust: ),
    // rust: ]),
    // rust: );
    // rust: let chunk = save.raw_chunk(0, 0).expect("the chunk reads");
    // rust: assert!(
    // rust: chunk.tag.get("Level").is_none(),
    // rust: "still wrapped: {:?}",
    // rust: chunk.tag
    // rust: );
    // rust: assert_eq!(number(chunk.tag.get("xPos")), Some(0));
        // 1.18's height fix: an Overworld chunk older than the new heights blends with them.
    // rust: assert!(chunk.tag.get("blending_data").is_some());
    // rust: let _ = std::fs::remove_dir_all(&world);
}

    /// A chunk as Bobby leaves it on disk, its palettes in both shapes: a
    /// list of names, and compounds where a name without properties is
    /// wrapped as `{"": name}` (a mixed list), read back summarized by far
    /// terrain and kept in its own folder.
pub fn far_terrain_reads_and_keeps_bobby_chunks() void {
}
//         use crate::server_terrain::{Bobby, DecodeChunk, ServerTerrain};
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES") else {
    // rust: return;
}
    // rust: let root = PathBuf::from(root);
    // rust: let assets = crate::assets::Assets::load(&root).expect("assets");
    // rust: let biomes = Arc::new(Biomes::load(&root).expect("biomes"));
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).expect("facts");
    // rust: let dir = std::env::temp_dir().join(format!("horizon-bobby-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: let (own, bobby) = (dir.join("own"), dir.join("bobby"));
    // rust: fs::create_dir_all(&bobby).unwrap();
    // rust: let name = |s: &str| Tag::String(s.into());
    // rust: let biome = Tag::compound([("palette", Tag::List(vec![name("minecraft:plains")]))]);
    // rust: let section = |y: i8, states: Tag| {
    // rust: Tag::compound([
    // rust: ("Y", Tag::Byte(y)),
    // rust: ("block_states", states),
    // rust: ("biomes", biome.clone()),
    // rust: ("SkyLight", Tag::ByteArray(vec![0xff; 2048])),
    // rust: ])
}
        // y 48..64 stone; y 64 an upright oak log, air above.
    // rust: let stone = Tag::compound([("palette", Tag::List(vec![name("minecraft:stone")]))]);
    // rust: let log = Tag::compound([
    // rust: ("id", name("minecraft:oak_log")),
    // rust: ("properties", Tag::compound([("axis", name("y"))])),
    // rust: ]);
    // rust: let mut data = vec![0i64; 256];
    // rust: data[..16].fill(0x1111_1111_1111_1111);
    // rust: let logs = Tag::compound([
    // rust: ("palette", Tag::List(vec![name("minecraft:air"), log])),
    // rust: ("data", Tag::LongArray(data)),
    // rust: ]);
    // rust: let chunk = |version: i32| NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([
    // rust: ("isLightOn", Tag::Byte(1)),
    // rust: ("Status", name("full")),
    // rust: ("zPos", Tag::Int(5)),
    // rust: ("block_entities", Tag::List(Vec::new())),
    // rust: ("yPos", Tag::Int(-4)),
    // rust: ("DataVersion", Tag::Int(version)),
    // rust: ("xPos", Tag::Int(-2)),
    // rust: (
    // rust: "sections",
    // rust: Tag::List(vec![section(3, stone.clone()), section(4, logs.clone())]),
    // rust: ),
    // rust: ("age", Tag::Long(1_793_576_311_368)),
    // rust: ]),
}
    // rust: let region = bobby.join("r.-1.0.mca");
    // rust: let mut file = RegionFile::open_writable(&region, true).unwrap();
    // rust: let record = ChunkRecord::from_nbt(
    // rust: &chunk(DATA_VERSION),
    // rust: Compression::Zlib,
    // rust: 0,
    // rust: Limits::default(),
    // rust: );
    // rust: file.write(ChunkPos::new(-2, 5), &record.unwrap()).unwrap();
    // rust: let record = ChunkRecord::from_nbt(
    // rust: &chunk(DATA_VERSION - 1),
    // rust: Compression::Zlib,
    // rust: 0,
    // rust: Limits::default(),
    // rust: );
    // rust: file.write(ChunkPos::new(-1, 5), &record.unwrap()).unwrap();
    // rust: drop(file);
    // rust: let before = fs::read(&region).unwrap();
    // rust: let registry = assets.registry;
    // rust: let decode: DecodeChunk =
    // rust: Box::new(move |root| decode_lit(root, registry, &biomes, ColumnLayout::VANILLA, true));
    // rust: let terrain =
    // rust: ServerTerrain::with_bobby(own.clone(), None, Some(Bobby::new(bobby, decode, &facts)));
    // rust: let mut upright = registry
    // rust: .state(registry.default_state("minecraft:oak_log").unwrap())
    // rust: .unwrap()
    // rust: .clone();
    // rust: upright.properties.insert("axis".into(), "y".into());
    // rust: let upright = registry.id(&upright).unwrap();
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let columns = terrain.chunk(-2, 5).expect("Bobby's chunk");
    // rust: for column in columns.iter() {
    // rust: let surface = column.surface.expect("a surface");
    // rust: assert_eq!((surface.height, surface.state), (65, upright));
    // rust: assert!(
    // rust: column
    // rust: .spans
    // rust: .as_slice()
    // rust: .iter()
    // rust: .any(|span| span.state == stone)
    // rust: );
}
        // Another game version's chunk is none.
    // rust: assert_eq!(terrain.chunk(-1, 5), None);
    // rust: drop(terrain);
    // rust: assert_eq!(
    // rust: fs::read(&region).unwrap(),
    // rust: before,
    // rust: "Bobby's folder is only read"
    // rust: );
    // rust: assert_eq!(ServerTerrain::new(own, None).chunk(-2, 5), Some(columns));
    // rust: let _ = fs::remove_dir_all(&dir);
}
    /// A cache Bobby really wrote (`HORIZON_TEST_BOBBY`, its `.bobby`: the
    /// fork's bobby-observe run, three local servers): found as the client
    /// would find it, and every chunk of its Overworld folders decodes.
pub fn far_terrain_reads_a_real_bobby_cache() void {
}
//         use crate::server_terrain::{Bobby, DecodeChunk, ServerTerrain, bobby_level_dir};
    // rust: let (Some(resources), Some(cache)) = (
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES"),
    // rust: std::env::var_os("HORIZON_TEST_BOBBY"),
    // rust: ) else {
    // rust: return;
}
    // rust: let resources = PathBuf::from(resources);
    // rust: let cache = PathBuf::from(cache);
    // rust: let assets = crate::assets::Assets::load(&resources).expect("assets");
    // rust: let biomes = Arc::new(Biomes::load(&resources).expect("biomes"));
    // rust: let facts = crate::blocks::BlockFacts::load(&resources, assets.registry).expect("facts");
    // rust: let registry = assets.registry;
    // rust: let levels = [
    // rust: ("127.0.0.1", -9030034075591913594),
    // rust: ("127.0.0.1", 4696776658964135993),
    // rust: ("localhost:25566", -7181178862026813658),
    // rust: ];
    // rust: for (address, seed) in levels {
    // rust: let dir = bobby_level_dir(&cache, address, seed, "minecraft:overworld")
    // rust: .unwrap_or_else(|| panic!("{address} {seed}: no folder"));
    // rust: let mut chunks = Vec::new();
    // rust: for entry in fs::read_dir(&dir).unwrap().flatten() {
    // rust: if entry.path().extension().is_some_and(|e| e == "mca") {
    // rust: let file = RegionFile::open(entry.path()).unwrap();
    // rust: chunks.extend(file.chunks().map(|(pos, _)| pos));
}
}
    // rust: assert!(
    // rust: chunks.len() > 100,
    // rust: "{address} {seed}: {} chunks",
    // rust: chunks.len()
    // rust: );
    // rust: let own = std::env::temp_dir()
    // rust: .join(format!("horizon-real-bobby-{seed}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&own);
    // rust: let biomes = biomes.clone();
    // rust: let decode: DecodeChunk = Box::new(move |root| {
    // rust: decode_lit(root, registry, &biomes, ColumnLayout::VANILLA, true)
    // rust: });
    // rust: let terrain =
    // rust: ServerTerrain::with_bobby(own.clone(), None, Some(Bobby::new(dir, decode, &facts)));
    // rust: let read = chunks
    // rust: .iter()
    // rust: .filter(|pos| {
    // rust: terrain
    // rust: .chunk(pos.x, pos.z)
    // rust: .is_some_and(|columns| columns.iter().all(|c| c.surface.is_some()))
    // rust: })
    // rust: .count();
    // rust: assert_eq!(
    // rust: read,
    // rust: chunks.len(),
    // rust: "{address} {seed}: chunks read with a surface"
    // rust: );
    // rust: let _ = fs::remove_dir_all(&own);
}
}
}

/// Far-terrain floating-cell census on a real save: `HORIZON_TEST_RESOURCES`
/// (prepared data), `HORIZON_FAR_SAVE` (a world folder), `HORIZON_FAR_SEED`
/// and `HORIZON_FAR_AT` ("x,z", the camera). Samples the tiles each level
/// draws around the camera as the far sampler gives them (saved chunks up to
/// 16 blocks a cell, the seed beyond) and counts components of drawn cells
/// that touch neither the world's bottom nor the tile's halo.
    // rust: mod far_census {
//     use super::*;
//     use crate::lod::Column;
//     use crate::streaming::ChunkGenerator;

pub const Census = struct {
    tiles: usize,
    floating: usize,
    cells: usize,
    kinds: std::collections::BTreeMap<*'static str,
    water_over_air: usize,
};

pub fn kind(name: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if name.ends_with("_leaves") {
    // rust: "leaves"
    // rust: } else if name.ends_with("_log") || name.ends_with("_wood") || name.contains("stem") {
    // rust: "log"
    // rust: } else if name == "minecraft:water" || name == "minecraft:lava" {
    // rust: "fluid"
    // rust: } else if name.contains("snow") || name.contains("ice") {
    // rust: "snow/ice"
    // rust: } else {
    // rust: "ground"
}
}

    /// `columns`: `side` x `side`, the outer ring a halo.
    // rust: fn count(
    // rust: columns: &[Column],
    // rust: side: usize,
    // rust: name: &dyn Fn(horizon_world::registry::BlockStateId) -> String,
    // rust: out: &mut Census,
    // rust: origin: (i32, i32, i32),
    // rust: ) {
        // Runs of touching spans, per column: (min, max, top state).
    // rust: let runs: Vec<Vec<(i16, i16, horizon_world::registry::BlockStateId)>> = columns
    // rust: .iter()
    // rust: .map(|column| {
    // rust: let mut runs: Vec<(i16, i16, _)> = Vec::new();
    // rust: for span in column.spans.iter().filter(|s| s.min < s.max) {
    // rust: match runs.last_mut() {
    // rust: Some(run) if run.1 == span.min => {
    // rust: run.1 = span.max;
    // rust: run.2 = span.state;
}
    // rust: _ => runs.push((span.min, span.max, span.state)),
}
}
    // rust: runs
    // rust: })
    // rust: .collect();
    // rust: let mut first = Vec::with_capacity(runs.len());
    // rust: let mut total = 0;
    // rust: for column in &runs {
    // rust: first.push(total);
    // rust: total += column.len();
}
    // rust: let mut parent: Vec<usize> = (0..total).collect();
pub fn find(parent: *mut [usize], mut i: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: while parent[i] != i {
    // rust: parent[i] = parent[parent[i]];
    // rust: i = parent[i];
}
    // rust: i
}
    // rust: let union = |parent: &mut Vec<usize>, a: usize, b: usize| {
    // rust: let (a, b) = (find(parent, a), find(parent, b));
    // rust: if a != b {
    // rust: parent[a] = b;
}
}
    // rust: for z in 0..side {
    // rust: for x in 0..side {
    // rust: let i = z * side + x;
    // rust: for j in [
    // rust: (x + 1 < side).then(|| i + 1),
    // rust: (z + 1 < side).then(|| i + side),
    // rust: ]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: for (a, &(lo, hi, _)) in runs[i].iter().enumerate() {
    // rust: for (b, &(other_lo, other_hi, _)) in runs[j].iter().enumerate() {
                            // Cells meeting at an edge (an acacia's
                            // diagonal branch) look joined too.
    // rust: if lo <= other_hi && other_lo <= hi {
    // rust: union(&mut parent, first[i] + a, first[j] + b);
}
}
}
}
}
}
        // Per component: grounded, touches the halo, cells, top state.
    // rust: let mut grounded = vec![false; total];
    // rust: let mut halo = vec![false; total];
    // rust: let mut cells = vec![0usize; total];
    // rust: let mut top = vec![None; total];
    // rust: let mut at = vec![(0, 0); total];
    // rust: for z in 0..side {
    // rust: for x in 0..side {
    // rust: let i = z * side + x;
    // rust: let ring = x == 0 || z == 0 || x + 1 == side || z + 1 == side;
    // rust: for (a, &(lo, hi, state)) in runs[i].iter().enumerate() {
    // rust: let root = find(&mut parent, first[i] + a);
    // rust: grounded[root] |= i32::from(lo) <= crate::chunk::MIN_Y;
    // rust: halo[root] |= ring;
    // rust: cells[root] += 1;
    // rust: if top[root].is_none_or(|(y, _)| hi > y) {
    // rust: top[root] = Some((hi, state));
    // rust: at[root] = (
    // rust: origin.0 + x as i32 * origin.2,
    // rust: origin.1 + z as i32 * origin.2,
    // rust: );
}
}
    // rust: if !ring {
    // rust: let spans = &columns[i].spans;
    // rust: for (k, span) in spans.iter().enumerate() {
    // rust: let n = name(span.state);
    // rust: if kind(&n) == "fluid" && (k == 0 || spans[k - 1].max < span.min) {
    // rust: out.water_over_air += 1;
    // rust: if std::env::var_os("HORIZON_FAR_DEBUG").is_some() {
    // rust: println!(
    // rust: "  fluid over air at {} {} y {}..{} {n}",
    // rust: origin.0 + x as i32 * origin.2,
    // rust: origin.1 + z as i32 * origin.2,
    // rust: span.min,
    // rust: span.max
    // rust: );
}
}
}
}
}
}
    // rust: for root in 0..total {
    // rust: if find(&mut parent, root) != root || grounded[root] || halo[root] {
    // rust: continue;
}
    // rust: out.floating += 1;
    // rust: out.cells += cells[root];
    // rust: let (y, state) = top[root].unwrap();
    // rust: *out.kinds.entry(kind(&name(state))).or_default() += 1;
    // rust: if std::env::var_os("HORIZON_FAR_DEBUG").is_some() {
    // rust: println!(
    // rust: "  floating at {:?} top {y} {} ({} cells)",
    // rust: at[root],
    // rust: name(state),
    // rust: cells[root]
    // rust: );
}
}
}

pub fn far_floating_cells_per_level() void {
}
    // rust: let var = |name: &str| std::env::var(name).unwrap_or_else(|_| panic!("{name}"));
    // rust: let root = PathBuf::from(var("HORIZON_TEST_RESOURCES"));
    // rust: let world = PathBuf::from(var("HORIZON_FAR_SAVE"));
    // rust: let seed: i64 = var("HORIZON_FAR_SEED").parse().unwrap();
    // rust: let at: Vec<i32> = var("HORIZON_FAR_AT")
    // rust: .split(',')
    // rust: .map(|n| n.trim().parse().unwrap())
    // rust: .collect();
    // rust: let assets = Arc::new(crate::assets::Assets::load(&root).expect("assets"));
    // rust: let biomes = Arc::new(Biomes::load(&root).expect("biomes"));
    // rust: let registry = assets.registry;
    // rust: let terrain = Arc::new(
    // rust: crate::vanillagen::VanillaTerrain::new(&root.join("worldgen"), registry, &biomes, seed)
    // rust: .expect("terrain"),
    // rust: );
    // rust: let save = Arc::new(SaveDir::new(
    // rust: world.join("dimensions/minecraft/overworld"),
    // rust: LevelShape::OVERWORLD,
    // rust: ));
    // rust: let generator = Arc::new(Persistent {
    // rust: inner: terrain,
    // rust: save: save.clone(),
    // rust: registry: assets.clone(),
    // rust: biomes: biomes.clone(),
    // rust: });
    // rust: let mut sampler = ChunkGenerator::lod_sampler(generator);
    // rust: let name = |state| {
    // rust: registry
    // rust: .state(state)
    // rust: .map_or_else(String::new, |s| s.name.to_string())
}
    // rust: let limit: usize = std::env::var("HORIZON_FAR_TILES")
    // rust: .ok()
    // rust: .and_then(|n| n.parse().ok())
    // rust: .unwrap_or(48);
    // rust: for level in 1..=6u8 {
    // rust: let size = 16 << level;
    // rust: let width = size / 16;
            // The ring this level is drawn in (`Plan::visit` splits a tile
            // closer than 8 of its widths).
    // rust: let (near, far) = (8 * size, 16 * size);
    // rust: let mut tiles = Vec::new();
    // rust: for tz in (at[1] - far).div_euclid(size)..=(at[1] + far).div_euclid(size) {
    // rust: for tx in (at[0] - far).div_euclid(size)..=(at[0] + far).div_euclid(size) {
    // rust: let (cx, cz) = (tx * size + size / 2, tz * size + size / 2);
    // rust: let d = (((cx - at[0]) as f64).powi(2) + ((cz - at[1]) as f64).powi(2)).sqrt();
    // rust: if d >= f64::from(near) && d < f64::from(far) {
    // rust: tiles.push((tx, tz));
}
}
}
    // rust: let step = tiles.len().div_ceil(limit).max(1);
    // rust: let mut saved = Census::default();
    // rust: let mut seeded = Census::default();
    // rust: let started = std::time::Instant::now();
    // rust: for &(tx, tz) in tiles.iter().step_by(step) {
    // rust: let (x, z) = (tx * size - width, tz * size - width);
    // rust: let columns = sampler.grid(x, z, width, 18);
    // rust: let all_saved = width <= SAVED_LOD_STRIDE
    // rust: && (x.div_euclid(16)..=(x + 18 * width - 1).div_euclid(16)).all(|cx| {
    // rust: (z.div_euclid(16)..=(z + 18 * width - 1).div_euclid(16))
    // rust: .all(|cz| save.lod_surfaces_shared(cx, cz, &assets, &biomes).is_some())
    // rust: });
    // rust: let out = if all_saved { &mut saved } else { &mut seeded };
    // rust: out.tiles += 1;
    // rust: count(&columns, 18, &name, out, (x, z, width));
}
    // rust: println!(
    // rust: "level {level} (cells {width}, {near}..{far} blocks, {:.1}s): saved {saved:?} | seed {seeded:?}",
    // rust: started.elapsed().as_secs_f32()
    // rust: );
}
}
}
