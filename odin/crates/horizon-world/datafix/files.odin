//! Transpiled from Horizon Rust crate
package horizon_world_files

import "core:fmt"
import "core:mem"
import "core:math"

// Opening an older world as 26.3 does: the file fixes of `FileFixerUpper`
// (`net.minecraft.util.filefix`, from DataVersion 4772 on) that move the
// files into the 26.x layout, then level.dat brought to the current version,
// and the upgrades vanilla runs as it reads each file ([`upgrade_world`]
// does them all at once, as a converter).
// use super::dynamic::{as_bool, as_int, as_str, int_list, remove, set, string};
// use super::json::{self, Json};
// use super::progress::{UpgradeProgress, UpgradeType};
// use super::schema::Ty;
// use super::{CURRENT, update};
// use crate::compression::Compression;
// use crate::nbt::{self, Compound, JavaString, Limits, NamedTag, Tag};
// use crate::region::{ChunkRecord, RegionFile, RegionWriter};
// use std::fs;
// use std::io;
// use std::path::{Path, PathBuf};

// The name `SharedConstants.getCurrentVersion().name()` writes in level.dat.
VERSION_NAME :: horizon_core::version::VANILLA_VERSION

FILE_FIXER_INTRODUCTION :: 4772
// The versions of the file fixes, in order.
FILE_FIXES :: [1493, 4772, 4773, 4899]

// `CanceledFileFixException`: the player pressed Cancel.
canceled :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: io::Error::new(io::ErrorKind::Interrupted, "the world upgrade was canceled")
}

invalid :: proc(message: impl Into<string>) -> i {
    // Ported from Horizon
    return {}
}
    // rust: io::Error::new(io::ErrorKind::InvalidData, message.into())
}

// `NbtIo.readCompressed`: the root compound of a gzip NBT file, if it exists.
read_dat :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = match fs::read(path) {
    // rust: Ok(b) => b,
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => return Ok(None),
    // rust: Err(e) => return Err(e),
}
    // rust: let limits = Limits::default();
    // rust: let raw = Compression::Gzip.decode(&bytes, limits.max_bytes)?;
    // rust: let (root, _) = nbt::read_named(&raw, limits).map_err(|e| invalid(e.to_string()))?;
    // rust: Ok(Some(root.tag))
}

// `SavedDataStorage.readTagFromDisk`: a file without the gzip header is plain NBT.
read_saved_dat :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = match fs::read(path) {
    // rust: Ok(b) => b,
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => return Ok(None),
    // rust: Err(e) => return Err(e),
}
    // rust: let limits = Limits::default();
    // rust: let raw = if bytes.starts_with(&[0x1f, 0x8b]) {
    // rust: Compression::Gzip.decode(&bytes, limits.max_bytes)?
    // rust: } else {
    // rust: bytes
}
    // rust: let (root, _) = nbt::read_named(&raw, limits).map_err(|e| invalid(e.to_string()))?;
    // rust: Ok(Some(root.tag))
}

// `NbtIo.writeCompressed`, creating the parent folders.
write_dat :: proc(path: ^Path, tag: ^Tag) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(parent) = path.parent() {
    // rust: fs::create_dir_all(parent)?;
}
    // rust: let root = NamedTag {
    // rust: name: JavaString::default(),
    // rust: tag: tag.clone(),
}
    // rust: let raw = nbt::write_named(&root, Limits::default()).map_err(|e| invalid(e.to_string()))?;
    // rust: fs::write(path, Compression::Gzip.encode(&raw)?)
}

// `NbtUtils.getDataVersion`.
data_version :: proc(tag: ^Tag, default: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match tag.get("DataVersion") {
    // rust: Some(Tag::Int(v)) => *v,
    // rust: _ => default,
}
}

// `FileFixerUpper.requiresFileFixing`.
requires_file_fixing :: proc(level_version: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let from = if level_version < FILE_FIXER_INTRODUCTION {
    // rust: 0
    // rust: } else {
    // rust: level_version
}
    // rust: from < *FILE_FIXES.last().unwrap()
}

// ------------------------------------------------------------------ file operations

resolve :: proc(base: ^Path, relative: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: base.join(relative.trim_start_matches('/'))
}

// `FileFixUtil.moveFile`: nothing when the source is missing, an error when
// the target exists.
move_file :: proc(base: ^Path, from: string, to: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let from = resolve(base, from);
    // rust: if !from.exists() {
    // rust: return Ok(());
}
    // rust: let to = resolve(base, to);
    // rust: if to.exists() {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::AlreadyExists,
    // rust: format!(
    // rust: "cannot move {} to {}: target already exists",
    // rust: from.display(),
    // rust: to.display()
    // rust: ),
    // rust: ));
}
    // rust: if let Some(parent) = to.parent() {
    // rust: fs::create_dir_all(parent)?;
}
    // rust: fs::rename(from, to)
}

// `FileFixUtil.deleteFileOrEmptyDirectory`.
delete :: proc(base: ^Path, relative: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let path = resolve(base, relative);
    // rust: if path.is_dir() {
    // rust: let entries: Vec<_> = fs::read_dir(&path)?.collect::<Result<_, _>>()?;
    // rust: if entries.len() == 1 && entries[0].file_name() == ".DS_Store" {
    // rust: let _ = fs::remove_file(entries[0].path());
}
    // rust: if fs::read_dir(&path)?.next().is_some() {
    // rust: return Ok(());
}
    // rust: fs::remove_dir(&path)
    // rust: } else if path.exists() {
    // rust: fs::remove_file(&path)
    // rust: } else {
    // rust: Ok(())
}
}

    // rust: pub(super) fn subdirectories(path: &Path) -> Vec<PathBuf> {
    // rust: let mut out: Vec<PathBuf> = fs::read_dir(path)
    // rust: .map(|r| {
    // rust: r.filter_map(Result::ok)
    // rust: .map(|e| e.path())
    // rust: .filter(|p| p.is_dir())
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: out.sort();
    // rust: out
}

// `FileRelation.DIMENSIONS`.
dimensions :: proc(base: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let root = base.join("dimensions");
    // rust: let defaults = || {
    // rust: ["overworld", "the_nether", "the_end"]
    // rust: .map(|d| base.join("dimensions/minecraft").join(d))
    // rust: .to_vec()
}
    // rust: if !root.exists() {
    // rust: return defaults();
}
    // rust: let found: Vec<PathBuf> = subdirectories(&root)
    // rust: .iter()
    // rust: .flat_map(|ns| subdirectories(ns))
    // rust: .collect();
    // rust: if found.is_empty() { defaults() } else { found }
}

// ------------------------------------------------------------------ file accessors

// `LevelDat.read`: level.dat's `Data` brought to `version`.
read_level :: proc(base: ^Path, version: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(read_dat(&base.join("level.dat"))?.map(|root| {
    // rust: let mut data = root
    // rust: .get("Data")
    // rust: .cloned()
    // rust: .unwrap_or_else(|| Tag::Compound(Compound::new()));
    // rust: let from = data_version(&data, -1);
    // rust: update(Ty::Level, &mut data, from, version);
    // rust: data
    // rust: }))
}
write_level :: proc(base: ^Path, mut data: Tag, version: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: set(&mut data, "DataVersion", Tag::Int(version));
    // rust: write_dat(&base.join("level.dat"), &Tag::compound([("Data", data)]))
}
// `SavedDataNbt.write`.
write_saved_data :: proc(path: ^Path, data: Tag, version: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: write_dat(
    // rust: path,
    // rust: &Tag::compound([("data", data), ("DataVersion", Tag::Int(version))]),
    // rust: )
}
// `SavedDataNbt.read`: the `data` of a saved data file brought to `version`.
read_saved_data :: proc(path: ^Path, ty: Ty, version: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(read_dat(path)?.map(|mut tag| {
    // rust: let from = data_version(&tag, -1);
    // rust: update(ty, &mut tag, from, version);
    // rust: tag.get("data")
    // rust: .cloned()
    // rust: .unwrap_or_else(|| Tag::Compound(Compound::new()))
    // rust: }))
}

// ------------------------------------------------------------------ the file fixes

// 4772: `ResourcePackLocationFileFix`, `DimensionStorageFileFix`,
// `PlayerStorageFileFix`, `LevelDatToSavedDataFileFix`, `RemoveObsoleteFilesFileFix`.
fix_4772 :: proc(base: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: move_file(base, "resources.zip", "resourcepacks/resources.zip")?;

    // rust: for dim in dimensions(base) {
    // rust: let data = dim.join("data");
    // rust: move_file(&data, "chunks.dat", "minecraft/chunk_tickets.dat")?;
    // rust: move_file(&data, "raids.dat", "minecraft/raids.dat")?;
    // rust: move_file(&data, "world_border.dat", "minecraft/world_border.dat")?;
}
    // rust: for (from, to) in [
    // rust: ("data", "dimensions/minecraft/overworld/data/minecraft"),
    // rust: (
    // rust: "DIM-1/data",
    // rust: "dimensions/minecraft/the_nether/data/minecraft",
    // rust: ),
    // rust: ("DIM1/data", "dimensions/minecraft/the_end/data/minecraft"),
    // rust: ] {
    // rust: for (a, b) in [
    // rust: ("chunks.dat", "chunk_tickets.dat"),
    // rust: ("raids.dat", "raids.dat"),
    // rust: ("raids_end.dat", "raids.dat"),
    // rust: ("world_border.dat", "world_border.dat"),
    // rust: ] {
    // rust: move_file(base, &format!("{from}/{a}"), &format!("{to}/{b}"))?;
}
}
    // rust: delete(base, "DIM1/data")?;
    // rust: delete(base, "DIM-1/data")?;
    // rust: let data = base.join("data");
    // rust: for (a, b) in [
    // rust: ("scoreboard.dat", "minecraft/scoreboard.dat"),
    // rust: ("stopwatches.dat", "minecraft/stopwatches.dat"),
    // rust: ] {
    // rust: move_file(&data, a, b)?;
}
    // rust: regex_move(&data, |name| {
    // rust: let ns = name
    // rust: .strip_prefix("command_storage_")?
    // rust: .strip_suffix(".dat")?;
    // rust: (!ns.is_empty()
    // rust: && ns
    // rust: .bytes()
    // rust: .all(|b| matches!(b, b'a'..=b'z' | b'0'..=b'9' | b'_' | b'.' | b'-')))
    // rust: .then(|| format!("{ns}/command_storage.dat"))
    // rust: })?;
    // rust: move_file(&data, "idcounts.dat", "minecraft/maps/last_id.dat")?;
    // rust: regex_move(&data, |name| {
    // rust: let id = name.strip_prefix("map_")?.strip_suffix(".dat")?;
    // rust: (!id.is_empty() && id.bytes().all(|b| b.is_ascii_digit()))
    // rust: .then(|| format!("minecraft/maps/{id}.dat"))
    // rust: })?;
    // rust: move_file(
    // rust: &data,
    // rust: "random_sequences.dat",
    // rust: "minecraft/random_sequences.dat",
    // rust: )?;
    // rust: for (from, to) in [
    // rust: ("", "dimensions/minecraft/overworld"),
    // rust: ("DIM-1", "dimensions/minecraft/the_nether"),
    // rust: ("DIM1", "dimensions/minecraft/the_end"),
    // rust: ] {
    // rust: for f in ["region", "entities", "poi"] {
    // rust: move_file(base, &format!("{from}/{f}"), &format!("{to}/{f}"))?;
}
}
    // rust: delete(base, "DIM-1")?;
    // rust: delete(base, "DIM1")?;

    // rust: move_file(base, "advancements", "players/advancements")?;
    // rust: move_file(base, "playerdata", "players/data")?;
    // rust: move_file(base, "stats", "players/stats")?;

    // rust: level_dat_to_saved_data(base)?;

    // rust: for f in [
    // rust: "data/villages.dat",
    // rust: "data/villages_end.dat",
    // rust: "data/villages_nether.dat",
    // rust: "data/advancements",
    // rust: "data/functions",
    // rust: ] {
    // rust: delete(base, f)?;
}
    // rust: for s in [
    // rust: "Monument",
    // rust: "Stronghold",
    // rust: "Mineshaft",
    // rust: "Temple",
    // rust: "Mansion",
    // rust: "Village",
    // rust: "Fortress",
    // rust: "EndCity",
    // rust: ] {
    // rust: delete(base, &format!("data/{s}.dat"))?;
    // rust: delete(base, &format!("data/{s}_index.dat"))?;
}
    // rust: Ok(())
}

// `RegexMove` over the files of a folder.
regex_move :: proc(folder: ^Path, rename: impl Fn(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !folder.is_dir() {
    // rust: return Ok(());
}
    // rust: let mut names: Vec<String> = fs::read_dir(folder)?
    // rust: .filter_map(Result::ok)
    // rust: .map(|e| e.file_name().to_string_lossy().into_owned())
    // rust: .collect();
    // rust: names.sort();
    // rust: for name in names {
    // rust: if let Some(new) = rename(&name) {
    // rust: move_file(folder, &name, &new)?;
}
}
    // rust: Ok(())
}

level_dat_to_saved_data :: proc(base: ^Path) -> i {
    // Ported from Horizon
    return {}
}
V :: 4772
    // rust: let Some(mut content) = read_level(base, V)? else {
    // rust: return Ok(());
}
    // rust: let data = base.join("data/minecraft");
    // rust: let dim_data = |dim: &str, file: &str| {
    // rust: base.join(format!("dimensions/minecraft/{dim}/data/minecraft/{file}"))
}
    // rust: let extract = |content: &mut Tag, key: &str, path: PathBuf| -> io::Result<()> {
    // rust: if let Some(tag) = remove(content, key) {
    // rust: write_saved_data(&path, tag, V)?;
}
    // rust: Ok(())
}
    // rust: extract(
    // rust: &mut content,
    // rust: "dragon_fight",
    // rust: dim_data("the_end", "ender_dragon_fight.dat"),
    // rust: )?;
    // rust: if let Some(mut player) = remove(&mut content, "Player") {
    // rust: let from = data_version(&player, -1);
    // rust: update(Ty::Player, &mut player, from, V);
    // rust: let uuid = match player.get("UUID") {
    // rust: Some(u) => u.clone(),
    // rust: None => {
    // rust: set(&mut player, "DataVersion", Tag::Int(V));
    // rust: write_dat(
    // rust: &base.join("players/data/00000000-0000-0000-0000-000000000000.dat"),
    // rust: &player,
    // rust: )?;
    // rust: int_list(&[0, 0, 0, 0])
}
}
    // rust: set(&mut content, "singleplayer_uuid", uuid);
}
    // rust: extract(
    // rust: &mut content,
    // rust: "wandering_trader_migration_data",
    // rust: data.join("wandering_trader.dat"),
    // rust: )?;
    // rust: extract(
    // rust: &mut content,
    // rust: "CustomBossEvents",
    // rust: data.join("custom_boss_events.dat"),
    // rust: )?;
    // rust: extract(&mut content, "weather_data", data.join("weather.dat"))?;
    // rust: extract(
    // rust: &mut content,
    // rust: "scheduled_events",
    // rust: data.join("scheduled_events.dat"),
    // rust: )?;
    // rust: if let Some(border) = content.get("world_border").cloned() {
    // rust: for (dim, divider) in [("overworld", 1.0), ("the_nether", 8.0), ("the_end", 1.0)] {
    // rust: let mut b = border.clone();
    // rust: for k in ["center_x", "center_z"] {
    // rust: if let Some(v) = b.get(k) {
    // rust: let v = super::dynamic::as_double(Some(v), 0.0) / divider;
    // rust: set(&mut b, k, Tag::Double(v.to_bits()));
}
}
    // rust: write_saved_data(&dim_data(dim, "world_border.dat"), b, V)?;
}
}
    // rust: remove(&mut content, "world_border");
    // rust: extract(&mut content, "game_rules", data.join("game_rules.dat"))?;
    // rust: if let Some(mut settings) = remove(&mut content, "world_gen_settings") {
    // rust: let from = data_version(&content, -1);
    // rust: update(Ty::WorldGenSettings, &mut settings, from, V);
    // rust: write_saved_data(&data.join("world_gen_settings.dat"), settings, V)?;
}
    // rust: extract(&mut content, "world_clocks", data.join("world_clocks.dat"))?;
    // rust: write_level(base, content, V)
}

// 1493: `LegacyStructureFileFix`. The structures of `data/*.dat` (1.12) become the
// `Structures` of the chunks they reach, in the region folders of the old layout.
    // rust: pub(crate) fn fix_1493(base: &Path) -> io::Result<()> {
//     use std::collections::{BTreeMap, HashMap};
    // rust: const LEGACY_TO_CURRENT: [(&str, &str); 4] = [
    // rust: ("Iglu", "Igloo"),
    // rust: ("TeDP", "Desert_Pyramid"),
    // rust: ("TeJP", "Jungle_Pyramid"),
    // rust: ("TeSH", "Swamp_Hut"),
    // rust: ];
LegacyData :: struct {
    starts: HashMap<string,
    indexes: BTreeMap<string,
}
    // rust: let pack = |x: i32, z: i32| i64::from(x) & 0xFFFF_FFFF | (i64::from(z) & 0xFFFF_FFFF) << 32;
    // rust: let Some(level) = read_level(base, 1493)? else {
    // rust: return Ok(());
}
    // rust: let overworld_generator = match as_str(level.get("generatorName")).as_deref() {
    // rust: Some("flat") => "minecraft:flat",
    // rust: Some("debug_all_block_states") => "minecraft:debug",
    // rust: _ => "minecraft:noise",
}
    // rust: let dimensions: [(&[&str], &str, &str, &str); 3] = [
    // rust: (
    // rust: &["Monument", "Stronghold", "Mineshaft", "Temple", "Mansion"],
    // rust: "",
    // rust: "minecraft:overworld",
    // rust: overworld_generator,
    // rust: ),
    // rust: (
    // rust: &["Fortress"],
    // rust: "DIM-1",
    // rust: "minecraft:the_nether",
    // rust: "minecraft:noise",
    // rust: ),
    // rust: (&["EndCity"], "DIM1", "minecraft:the_end", "minecraft:noise"),
    // rust: ];
    // rust: for (ids, folder, dimension, generator) in dimensions {
    // rust: let mut structures: BTreeMap<(i32, i32), LegacyData> = BTreeMap::new();
    // rust: for id in ids {
    // rust: let path = base.join("data").join(format!("{id}.dat"));
    // rust: let Some(data) = read_saved_data(&path, Ty::SavedStructureFeatureIndices, 1493)? else {
    // rust: continue;
}
    // rust: let Some(Tag::Compound(features)) = data.get("Features") else {
    // rust: continue;
}
    // rust: let values: Vec<(String, Tag)> = features
    // rust: .iter()
    // rust: .map(|(k, v)| (k.to_string_lossy(), v.clone()))
    // rust: .collect();
    // rust: for (_, mut value) in super::items::java_hash_order(values, |(k, _)| k.clone()) {
    // rust: let chunk_x = as_int(value.get("ChunkX"), 0);
    // rust: let chunk_z = as_int(value.get("ChunkZ"), 0);
    // rust: let children = super::dynamic::stream(value.get("Children"));
    // rust: if let Some(first) = children.first()
    // rust: && let Some(current) = as_str(first.get("id"))
    // rust: .and_then(|i| LEGACY_TO_CURRENT.iter().find(|(from, _)| *from == i))
    // rust: {
    // rust: set(&mut value, "id", string(current.1));
}
    // rust: let Some(feature_id) = as_str(value.get("id")) else {
    // rust: continue;
}
    // rust: structures
    // rust: .entry((chunk_x, chunk_z))
    // rust: .or_default()
    // rust: .starts
    // rust: .insert(feature_id.clone(), value);
    // rust: for nx in chunk_x - 8..=chunk_x + 8 {
    // rust: for nz in chunk_z - 8..=chunk_z + 8 {
    // rust: structures
    // rust: .entry((nx, nz))
    // rust: .or_default()
    // rust: .indexes
    // rust: .entry(feature_id.clone())
    // rust: .or_default()
    // rust: .push(pack(chunk_x, chunk_z));
}
}
}
}
    // rust: if structures.is_empty() {
    // rust: continue;
}
    // rust: let region = if folder.is_empty() {
    // rust: base.join("region")
    // rust: } else {
    // rust: base.join(folder).join("region")
}
    // rust: upgrade_regions(&region, &Progress::none(), |tag| {
    // rust: let version = as_int(tag.get("DataVersion"), -1);
    // rust: let x = as_int(tag.get("Level").and_then(|l| l.get("xPos")), 0);
    // rust: let z = as_int(tag.get("Level").and_then(|l| l.get("zPos")), 0);
    // rust: let Some(legacy) = structures.get(&(x, z)) else {
    // rust: return;
}
    // rust: let _ = version;
    // rust: super::update_chunk_to(tag, dimension, Some(generator), 1493);
    // rust: let mut level = tag
    // rust: .get("Level")
    // rust: .cloned()
    // rust: .unwrap_or_else(super::dynamic::empty_map);
    // rust: let mut structure = level
    // rust: .get("Structures")
    // rust: .cloned()
    // rust: .filter(|s| matches!(s, Tag::Compound(_)))
    // rust: .unwrap_or_else(super::dynamic::empty_map);
    // rust: let mut starts = structure
    // rust: .get("Starts")
    // rust: .cloned()
    // rust: .filter(|s| matches!(s, Tag::Compound(_)))
    // rust: .unwrap_or_else(super::dynamic::empty_map);
    // rust: let mut references = structure
    // rust: .get("References")
    // rust: .cloned()
    // rust: .filter(|s| matches!(s, Tag::Compound(_)))
    // rust: .unwrap_or_else(super::dynamic::empty_map);
    // rust: for (id, value) in &legacy.starts {
    // rust: set(&mut starts, id, value.clone());
}
    // rust: for (id, indexes) in &legacy.indexes {
    // rust: set(&mut references, id, Tag::LongArray(indexes.clone()));
}
    // rust: set(&mut structure, "Starts", starts);
    // rust: set(&mut structure, "References", references);
    // rust: set(&mut level, "Structures", structure);
    // rust: set(tag, "Level", level);
    // rust: })?;
}
    // rust: Ok(())
}

// 4773: `GeneratedStructuresRenameFileFix`.
fix_4773 :: proc(base: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: for ns in subdirectories(&base.join("generated")) {
    // rust: move_file(&ns, "structures", "structure")?;
}
    // rust: Ok(())
}

// 4899: `ReenableSpectatorsGenerateChunksInHardcoreWorldsFileFix`.
fix_4899 :: proc(base: ^Path) -> i {
    // Ported from Horizon
    return {}
}
V :: 4899
    // rust: let Some(level) = read_level(base, V)? else {
    // rust: return Ok(());
}
    // rust: let hardcore = level
    // rust: .get("difficulty_settings")
    // rust: .is_some_and(|d| as_bool(d.get("hardcore"), false));
    // rust: if level.get("singleplayer_uuid").is_some() && hardcore {
    // rust: let path = base.join("data/minecraft/game_rules.dat");
    // rust: if let Some(mut rules) = read_saved_data(&path, Ty::SavedGameRules, V)? {
    // rust: if rules.get("minecraft:spectators_generate_chunks").is_some() {
    // rust: set(
    // rust: &mut rules,
    // rust: "minecraft:spectators_generate_chunks",
    // rust: Tag::Byte(1),
    // rust: );
}
    // rust: write_saved_data(&path, rules, V)?;
}
}
    // rust: Ok(())
}

// `FileFixerUpper.addVersionsToLevelData`.
add_versions :: proc(data: ^Tag) {
}
    // rust: set(data, "DataVersion", Tag::Int(CURRENT));
    // rust: let now = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis() as i64);
    // rust: set(data, "LastPlayed", Tag::Long(now));
    // rust: set(
    // rust: data,
    // rust: "Version",
    // rust: Tag::compound([
    // rust: ("Name", string(VERSION_NAME)),
    // rust: ("Id", Tag::Int(CURRENT)),
    // rust: ("Snapshot", Tag::Byte(0)),
    // rust: ("Series", string("main")),
    // rust: ]),
    // rust: );
}

// `FileFixerUpper.fix`: the file fixes a world saved at an older version
// needs, then its level.dat at the current version. Returns the DataVersion
// the world had.
fix_world_files :: proc(base: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let (loaded, pending) = fix_world_files_deferred(base, &UpgradeProgress::new())?;
    // rust: if let Some(data) = pending {
    // rust: write_dat(&base.join("level.dat"), &Tag::compound([("Data", data)]))?;
}
    // rust: Ok(loaded)
}

// [`fix_world_files`] without the final level.dat write: returns the loaded
// DataVersion and the level data at the current version still to be written
// (`None` when the world is already current). A caller that converts the
// world's data afterwards writes it last, so a failed upgrade keeps the old
// DataVersion and is retried on the next open.
    // rust: fn fix_world_files_deferred(
    // rust: base: &Path,
    // rust: progress: &UpgradeProgress,
    // rust: ) -> io::Result<(i32, Option<Tag>)> {
    // rust: let root = read_dat(&base.join("level.dat"))?.ok_or_else(|| invalid("missing level.dat"))?;
    // rust: let mut data = root
    // rust: .get("Data")
    // rust: .cloned()
    // rust: .unwrap_or_else(|| Tag::Compound(Compound::new()));
    // rust: let loaded = data_version(&data, -1);
    // rust: if loaded >= CURRENT {
    // rust: return Ok((loaded, None));
}
    // rust: let mut from = loaded;
    // rust: if requires_file_fixing(loaded) {
    // rust: let start = if loaded < FILE_FIXER_INTRODUCTION {
    // rust: 0
    // rust: } else {
    // rust: loaded
}
        // `FileFixerUpper.applyFileFixers`: the type, the count (a file fix is
        // one operation here), then each fixer in turn.
    // rust: let applicable: Vec<i32> = FILE_FIXES
    // rust: .into_iter()
    // rust: .filter(|&version| version > start && version <= CURRENT)
    // rust: .collect();
    // rust: progress.set_file_fixing();
    // rust: progress.set_type(UpgradeType::Files);
    // rust: progress.add_total_file_fix_operations(applicable.len() as i32);
    // rust: progress.set_applicable_fixer_amount(applicable.len() as i32);
    // rust: for (done, version) in applicable.into_iter().enumerate() {
            // `FileFix.runFixOperations` stops on a cancel, which vanilla rolls
            // back. These fixes move files in place, so only the one that
            // would be the first leaves the world as it was.
    // rust: if done == 0 && progress.is_canceled() {
    // rust: return Err(canceled());
}
    // rust: progress.increment_running_file_fixer();
    // rust: match version {
    // rust: 1493 => fix_1493(base)?,
    // rust: 4772 => fix_4772(base)?,
    // rust: 4773 => fix_4773(base)?,
    // rust: _ => fix_4899(base)?,
}
    // rust: progress.increment_finished_operations();
}
        // `writeUpdatedLevelData`, then the world swapped in and read again.
    // rust: let root =
    // rust: read_dat(&base.join("level.dat"))?.ok_or_else(|| invalid("missing level.dat"))?;
    // rust: data = root
    // rust: .get("Data")
    // rust: .cloned()
    // rust: .unwrap_or_else(|| Tag::Compound(Compound::new()));
    // rust: from = data_version(&data, -1);
    // rust: let _ = fs::remove_file(base.join("level.dat_old"));
    // rust: let _ = fs::remove_file(base.join("session.lock"));
}
    // rust: update(Ty::Level, &mut data, from, CURRENT);
    // rust: add_versions(&mut data);
    // rust: Ok((loaded, Some(data)))
}

// The world's generator settings as 26.3 reads them once the file fixes have run, without
// running them: for a world older than 4772 they come out of level.dat the way
// `LevelDatToSavedDataFileFix` moves them (`world_gen_settings.dat` is not there yet), for any
// other from the saved data file, brought to the current version. `None` when there are none.
current_world_gen_settings :: proc(base: ^Path) -> i {
    // Ported from Horizon
    return {}
}
V :: 4772
    // rust: let Some(root) = read_dat(&base.join("level.dat"))? else {
    // rust: return Ok(None);
}
    // rust: let loaded = root.get("Data").map_or(-1, |data| data_version(data, -1));
    // rust: if loaded < V {
    // rust: let Some(content) = read_level(base, V)? else {
    // rust: return Ok(None);
}
    // rust: let Some(mut settings) = content.get("world_gen_settings").cloned() else {
    // rust: return Ok(None);
}
    // rust: let from = data_version(&content, -1);
    // rust: update(Ty::WorldGenSettings, &mut settings, from, V);
    // rust: update(Ty::WorldGenSettings, &mut settings, V, CURRENT);
    // rust: return Ok(Some(settings));
}
    // rust: read_saved_data(
    // rust: &base.join("data/minecraft/world_gen_settings.dat"),
    // rust: Ty::SavedWorldGenSettings,
    // rust: CURRENT,
    // rust: )
}

// ------------------------------------------------------------------ the read-time upgrades

// Chunk generator types per dimension from `world_gen_settings.dat`, the
// `generator` of the context the chunk fixes read.
generators :: proc(base: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let Some(tag) = read_dat(&base.join("data/minecraft/world_gen_settings.dat"))? else {
    // rust: return Ok(Vec::new());
}
    // rust: let mut out = Vec::new();
    // rust: if let Some(Tag::Compound(dims)) = tag.get("data").and_then(|d| d.get("dimensions")) {
    // rust: for (id, dim) in dims {
    // rust: if let Some(ty) = dim.get("generator").and_then(|g| as_str(g.get("type"))) {
    // rust: out.push((id.to_string_lossy(), ty));
}
}
}
    // rust: Ok(out)
}

files_with_suffix :: proc(folder: ^Path, suffix: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out: Vec<PathBuf> = fs::read_dir(folder)
    // rust: .map(|r| {
    // rust: r.filter_map(Result::ok)
    // rust: .map(|e| e.path())
    // rust: .filter(|p| p.is_file() && p.to_string_lossy().ends_with(suffix))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: out.sort();
    // rust: out
}

// Rewrite every chunk of the region files of a folder with `fix`.
    // rust: fn upgrade_regions(
    // rust: folder: &Path,
    // rust: progress: &Progress,
    // rust: mut fix: impl FnMut(&mut Tag),
    // rust: ) -> io::Result<()> {
    // rust: let limits = Limits::default();
    // rust: for path in files_with_suffix(folder, ".mca") {
    // rust: progress.check()?;
    // rust: let mut region = RegionFile::open(&path)?;
    // rust: let positions: Vec<_> = region.chunks().map(|(p, _)| p).collect();
    // rust: let mut records = Vec::new();
    // rust: for pos in positions {
    // rust: let Some(record) = region.read(pos)? else {
    // rust: continue;
}
    // rust: let mut root = record.nbt(limits)?;
    // rust: fix(&mut root.tag);
    // rust: records.push((
    // rust: pos,
    // rust: ChunkRecord::from_nbt(&root, record.compression, record.timestamp, limits)?,
    // rust: ));
}
    // rust: drop(region);
    // rust: let staging = folder.join(".datafix");
    // rust: fs::create_dir_all(&staging)?;
    // rust: let temporary = staging.join(path.file_name().unwrap_or_default());
    // rust: let _ = fs::remove_file(&temporary);
    // rust: let mut writer = RegionWriter::create(&temporary)?;
    // rust: for (pos, record) in &records {
    // rust: writer.write(*pos, record)?;
}
    // rust: writer.finish()?;
    // rust: fs::rename(&temporary, &path)?;
    // rust: fs::remove_dir(&staging)?;
    // rust: progress.progress.increment_finished_operations();
}
    // rust: Ok(())
}

// The progress a data upgrade reports to and whether it may stop early: a
// cancel is honoured only while the world's files are still unmoved, since
// the DataVersion is stamped last and a retry would run the file fixes again.
Progress :: struct {
    progress: ^'a UpgradeProgress,
    cancelable: bool,
}
    // rust: impl Progress<'static> {
    // A converter run with nobody watching.
none :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: static NONE: std::sync::LazyLock<UpgradeProgress> =
    // rust: std::sync::LazyLock::new(UpgradeProgress::new);
    // rust: Progress {
    // rust: progress: &NONE,
    // rust: cancelable: false,
}
}
}
    // rust: impl Progress<'_> {
check :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.cancelable && self.progress.is_canceled() {
    // rust: Err(canceled())
    // rust: } else {
    // rust: Ok(())
}
}
}

// `SavedDataStorage.readTagFromDisk` over every known file of a data folder.
saved_data_files :: proc(data: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut files = Vec::new();
    // rust: if !data.is_dir() {
    // rust: return Ok(files);
}
    // rust: let mut stack = vec![data.to_path_buf()];
    // rust: while let Some(dir) = stack.pop() {
    // rust: for entry in fs::read_dir(&dir)?.filter_map(Result::ok) {
    // rust: let p = entry.path();
    // rust: if p.is_dir() {
    // rust: stack.push(p);
    // rust: } else if p.to_string_lossy().ends_with(".dat") {
    // rust: files.push(p);
}
}
}
    // rust: files.sort();
    // rust: Ok(files)
}

upgrade_saved_data :: proc(data: ^Path, progress: ^Progress) -> i {
    // Ported from Horizon
    return {}
}
    // rust: for file in saved_data_files(data)? {
    // rust: progress.check()?;
    // rust: let relative = file
    // rust: .strip_prefix(data)
    // rust: .unwrap_or(&file)
    // rust: .to_string_lossy()
    // rust: .replace('\\', "/");
    // rust: if let Some(ty) = super::saved_data_type(&relative)
    // rust: && let Some(mut tag) = read_saved_dat(&file)?
    // rust: {
    // rust: super::update_saved_data(ty, &mut tag);
    // rust: set(&mut tag, "DataVersion", Tag::Int(CURRENT));
    // rust: write_dat(&file, &tag)?;
}
    // rust: progress.progress.increment_finished_operations();
}
    // rust: Ok(())
}

// A JSON file of the player folders as NBT for the fixes (`JsonOps` and
// `NbtOps` see the same structure), booleans kept apart.
json_to_tag :: proc(j: ^Json) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match j {
    // rust: Json::Bool(b) => Tag::compound([("\u{0}bool", Tag::Byte(i8::from(*b)))]),
    // rust: Json::Arr(items) => Tag::List(items.iter().map(json_to_tag).collect()),
    // rust: Json::Obj(entries) => Tag::Compound(
    // rust: entries
    // rust: .iter()
    // rust: .map(|(k, v)| (JavaString(k.clone()), json_to_tag(v)))
    // rust: .collect(),
    // rust: ),
    // rust: other => json::to_nbt(other).unwrap_or(Tag::End),
}
}
tag_to_json :: proc(t: ^Tag) -> J {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Tag::Compound(c) if c.len() == 1 && c.contains_key(&JavaString::from("\u{0}bool")) => {
    // rust: Json::Bool(as_int(t.get("\u{0}bool"), 0) != 0)
}
    // rust: Tag::List(items) => Json::Arr(items.iter().map(tag_to_json).collect()),
    // rust: Tag::Compound(c) => Json::Obj(
    // rust: c.iter()
    // rust: .map(|(k, v)| (k.0.clone(), tag_to_json(v)))
    // rust: .collect(),
    // rust: ),
    // rust: other => json::from_nbt(other),
}
}

upgrade_json :: proc(path: ^Path, ty: Ty) -> i {
    // Ported from Horizon
    return {}
}
    // rust: upgrade_json_to(path, ty, CURRENT)
}

upgrade_json_to :: proc(path: ^Path, ty: Ty, to: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let text = fs::read_to_string(path)?;
    // rust: let units: Vec<u16> = text.encode_utf16().collect();
    // rust: let parsed = json::parse_lenient(&units)
    // rust: .ok_or_else(|| invalid(format!("bad JSON in {}", path.display())))?;
    // rust: let mut tag = json_to_tag(&parsed);
    // rust: let from = super::dynamic::as_int(tag.get("DataVersion"), 1343);
    // rust: if ty == Ty::Advancements {
        // `PlayerAdvancements`: the version field is not part of the data.
    // rust: remove(&mut tag, "DataVersion");
}
    // rust: update(ty, &mut tag, from, to);
    // rust: set(&mut tag, "DataVersion", Tag::Int(to));
    // rust: let out = json::to_stable_string(&tag_to_json(&tag));
    // rust: fs::write(path, String::from_utf16_lossy(&out))
}

// Everything vanilla upgrades as it reads a world, done at once: every chunk,
// entity chunk and POI chunk, saved data, player, advancements and
// statistics file. Run after [`fix_world_files`].
upgrade_world_data :: proc(base: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: upgrade_world_data_with(base, &UpgradeProgress::new(), false)
}

// [`upgrade_world_data`] reporting to `progress` (type `Regions`, one
// operation per file) and stopping on its cancel when `cancelable`.
    // rust: pub fn upgrade_world_data_with(
    // rust: base: &Path,
    // rust: progress: &UpgradeProgress,
    // rust: cancelable: bool,
    // rust: ) -> io::Result<()> {
    // rust: let generators = generators(base)?;
    // rust: let dimensions: Vec<(String, PathBuf)> = subdirectories(&base.join("dimensions"))
    // rust: .into_iter()
    // rust: .flat_map(|ns| {
    // rust: subdirectories(&ns).into_iter().map(move |dim| {
    // rust: let id = format!(
    // rust: "{}:{}",
    // rust: ns.file_name().unwrap_or_default().to_string_lossy(),
    // rust: dim.file_name().unwrap_or_default().to_string_lossy()
    // rust: );
    // rust: (id, dim)
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let players = files_with_suffix(&base.join("players/data"), ".dat");
    // rust: let advancements = files_with_suffix(&base.join("players/advancements"), ".json");
    // rust: let stats = files_with_suffix(&base.join("players/stats"), ".json");
    // Counting, as `FileFixerUpper.countFiles` does before the work.
    // rust: progress.set_type(UpgradeType::Regions);
    // rust: let mut total = players.len() + advancements.len() + stats.len();
    // rust: total += saved_data_files(&base.join("data"))?.len();
    // rust: for (_, dim) in &dimensions {
    // rust: for folder in ["region", "entities", "poi"] {
    // rust: total += files_with_suffix(&dim.join(folder), ".mca").len();
}
    // rust: total += saved_data_files(&dim.join("data"))?.len();
}
    // rust: progress.add_total_file_fix_operations(total as i32);
    // rust: let run = Progress {
    // rust: progress,
    // rust: cancelable,
}
    // rust: for (id, dim) in &dimensions {
    // rust: let generator = generators
    // rust: .iter()
    // rust: .find(|(d, _)| d == id)
    // rust: .map(|(_, g)| g.clone());
    // rust: upgrade_regions(&dim.join("region"), &run, |tag| {
    // rust: super::update_chunk(tag, id, generator.as_deref())
    // rust: })?;
    // rust: upgrade_regions(&dim.join("entities"), &run, |tag| {
    // rust: super::update_region_tag(Ty::EntityChunk, tag)
    // rust: })?;
    // rust: upgrade_regions(&dim.join("poi"), &run, |tag| {
    // rust: super::update_region_tag(Ty::PoiChunk, tag)
    // rust: })?;
    // rust: upgrade_saved_data(&dim.join("data"), &run)?;
}
    // rust: upgrade_saved_data(&base.join("data"), &run)?;
    // rust: for file in players {
    // rust: run.check()?;
    // rust: if let Some(mut tag) = read_dat(&file)? {
    // rust: super::update_player(&mut tag);
    // rust: set(&mut tag, "DataVersion", Tag::Int(CURRENT));
    // rust: write_dat(&file, &tag)?;
}
    // rust: progress.increment_finished_operations();
}
    // rust: for file in advancements {
    // rust: run.check()?;
    // rust: upgrade_json(&file, Ty::Advancements)?;
    // rust: progress.increment_finished_operations();
}
    // rust: for file in stats {
    // rust: run.check()?;
    // rust: upgrade_json(&file, Ty::Stats)?;
    // rust: progress.increment_finished_operations();
}
    // rust: Ok(())
}

// A world in the layout of before 1.16 (dimension folders in the world folder,
// `playerdata`, `stats`, `advancements`) brought to DataVersion `target` and
// no further, with the file fixes of that range but not the ones that move the
// files into the 26.x layout: the harness checks the fixes of a range of
// versions on their own (the vanilla oracle does the same given a target).
upgrade_band :: proc(base: ^Path, target: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if target >= 1493 {
    // rust: fix_1493(base)?;
}
    // rust: let level = base.join("level.dat");
    // rust: if let Some(mut root) = read_dat(&level)? {
    // rust: let mut data = root
    // rust: .get("Data")
    // rust: .cloned()
    // rust: .unwrap_or_else(|| Tag::Compound(Compound::new()));
    // rust: let from = data_version(&data, -1);
    // rust: update(Ty::Level, &mut data, from, target);
    // rust: set(&mut data, "DataVersion", Tag::Int(target));
    // rust: set(&mut root, "Data", data);
    // rust: write_dat(&level, &root)?;
}
    // rust: for (folder, id) in [
    // rust: ("", "minecraft:overworld"),
    // rust: ("DIM-1", "minecraft:the_nether"),
    // rust: ("DIM1", "minecraft:the_end"),
    // rust: ] {
    // rust: let dim = base.join(folder);
    // rust: upgrade_regions(&dim.join("region"), &Progress::none(), |tag| {
    // rust: super::update_chunk_to(tag, id, None, target)
    // rust: })?;
    // rust: upgrade_regions(&dim.join("entities"), &Progress::none(), |tag| {
    // rust: super::update_region_tag_to(Ty::EntityChunk, tag, target)
    // rust: })?;
    // rust: upgrade_regions(&dim.join("poi"), &Progress::none(), |tag| {
    // rust: super::update_region_tag_to(Ty::PoiChunk, tag, target)
    // rust: })?;
}
    // rust: for file in files_with_suffix(&base.join("playerdata"), ".dat") {
    // rust: if let Some(mut tag) = read_dat(&file)? {
    // rust: super::update_player_to(&mut tag, target);
    // rust: write_dat(&file, &tag)?;
}
}
    // rust: for (folder, ty) in [("advancements", Ty::Advancements), ("stats", Ty::Stats)] {
    // rust: for file in files_with_suffix(&base.join(folder), ".json") {
    // rust: upgrade_json_to(&file, ty, target)?;
}
}
    // The saved data of the old layout.
    // rust: for file in files_with_suffix(&base.join("data"), ".dat") {
    // rust: let name = file
    // rust: .file_stem()
    // rust: .map(|n| n.to_string_lossy().into_owned())
    // rust: .unwrap_or_default();
    // rust: let ty = match name.as_str() {
    // rust: "scoreboard" => Ty::SavedScoreboard,
    // rust: n if n
    // rust: .strip_prefix("map_")
    // rust: .is_some_and(|d| !d.is_empty() && d.bytes().all(|b| b.is_ascii_digit())) =>
    // rust: {
    // rust: Ty::SavedMapData
}
    // rust: _ => continue,
}
    // rust: if let Some(mut tag) = read_dat(&file)? {
    // rust: let from = data_version(&tag, 1343);
    // rust: update(ty, &mut tag, from, target);
    // rust: set(&mut tag, "DataVersion", Tag::Int(target));
    // rust: write_dat(&file, &tag)?;
}
}
    // rust: Ok(())
}

// Bring a whole world saved by 1.20 to 26.2 to the 26.3 format in place.
upgrade_world :: proc(base: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: upgrade_world_with(base, &UpgradeProgress::new())
}

// [`upgrade_world`] reporting to `progress`, which also carries the player's
// cancel (`FileFixerProgressScreen`'s button).
upgrade_world_with :: proc(base: ^Path, progress: ^UpgradeProgress) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let (version, pending) = fix_world_files_deferred(base, progress)?;
    // rust: upgrade_world_data_with(base, progress, !progress.is_file_fixing())?;
    // Stamp the current DataVersion only once everything converted, so a failed
    // upgrade is retried on the next open.
    // rust: if let Some(data) = pending {
    // rust: write_dat(&base.join("level.dat"), &Tag::compound([("Data", data)]))?;
}
    // rust: Ok(version)
}

    // rust: mod upgrade_tests {
//     use super::*;

level_version :: proc(base: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let root = read_dat(&base.join("level.dat")).unwrap().unwrap();
    // rust: data_version(root.get("Data").unwrap(), -1)
}

    // `FileFixerProgressScreen` reads the upgrade's counts: the data stage is
    // type `Regions` with one operation per file, and a world that needs no
    // file fixing does not open the screen.
upgrade_reports_one_operation_per_file :: proc() {
}
    // rust: let base = std::env::temp_dir().join(format!("horizon-progress-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&base);
    // rust: let level = Tag::compound([("Data", Tag::compound([("DataVersion", Tag::Int(4899))]))]);
    // rust: write_dat(&base.join("level.dat"), &level).unwrap();
    // rust: let player = Tag::compound([("DataVersion", Tag::Int(4899))]);
    // rust: write_dat(&base.join("players/data/a.dat"), &player).unwrap();
    // rust: write_dat(&base.join("players/data/b.dat"), &player).unwrap();

    // rust: let progress = UpgradeProgress::new();
    // rust: upgrade_world_with(&base, &progress).unwrap();
    // rust: assert!(!progress.is_file_fixing());
    // rust: assert_eq!(progress.upgrade_type(), Some(UpgradeType::Regions));
    // rust: assert_eq!(progress.total_file_fix_stats().total_operations(), 2);
    // rust: assert_eq!(progress.total_file_fix_stats().finished_operations(), 2);
    // rust: assert_eq!(progress.total_file_fix_stats().progress(), 1.0);
    // rust: let _ = fs::remove_dir_all(&base);
}

    // Cancel stops the data stage of a world with no file fixing before the
    // next file, and the DataVersion stays old so the next open retries.
cancel_stops_the_data_upgrade_and_keeps_the_version :: proc() {
}
    // rust: let base = std::env::temp_dir().join(format!("horizon-cancel-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&base);
    // rust: let level = Tag::compound([("Data", Tag::compound([("DataVersion", Tag::Int(4899))]))]);
    // rust: write_dat(&base.join("level.dat"), &level).unwrap();
    // rust: write_dat(
    // rust: &base.join("players/data/a.dat"),
    // rust: &Tag::compound([("DataVersion", Tag::Int(4899))]),
    // rust: )
    // rust: .unwrap();

    // rust: let progress = UpgradeProgress::new();
    // rust: progress.set_canceled();
    // rust: let error = upgrade_world_with(&base, &progress).unwrap_err();
    // rust: assert_eq!(error.kind(), io::ErrorKind::Interrupted);
    // rust: assert_eq!(progress.total_file_fix_stats().finished_operations(), 0);
    // rust: assert_eq!(level_version(&base), 4899);
    // rust: let _ = fs::remove_dir_all(&base);
}

    // A failed data upgrade must keep the old DataVersion so the next open
    // retries, and a later successful run stamps the current one.
failed_upgrade_keeps_old_data_version :: proc() {
}
    // rust: let base = std::env::temp_dir().join(format!("horizon-upgrade-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&base);
    // rust: let old = 4899;
    // rust: let level = Tag::compound([("Data", Tag::compound([("DataVersion", Tag::Int(old))]))]);
    // rust: write_dat(&base.join("level.dat"), &level).unwrap();
    // rust: let region = base.join("dimensions/minecraft/overworld/region");
    // rust: fs::create_dir_all(&region).unwrap();
        // Not a valid region file name, so opening it fails mid-upgrade.
    // rust: fs::write(region.join("broken.mca"), b"x").unwrap();

    // rust: assert!(upgrade_world(&base).is_err());
    // rust: assert_eq!(level_version(&base), old);

    // rust: fs::remove_file(region.join("broken.mca")).unwrap();
    // rust: assert_eq!(upgrade_world(&base).unwrap(), old);
    // rust: assert_eq!(level_version(&base), CURRENT);
    // rust: let _ = fs::remove_dir_all(&base);
}
}
