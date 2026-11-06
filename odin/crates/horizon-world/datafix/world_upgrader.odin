//! Transpiled from Horizon Rust crate
package horizon_world_world_upgrader

import "core:fmt"
import "core:mem"
import "core:math"

// `net.minecraft.util.worldupdate.WorldUpgrader` and `RegionStorageUpgrader`:
// Optimize World. A worker thread reads every chunk of each dimension's
// `entities`, `poi` and `region` folders, brings it to the current DataVersion
// and writes it back, reporting its counts through an [`UpgradeProgress`] the
// screen reads. Unlike [`super::files::upgrade_world`] (the converter that
// runs when an older world opens) it works on a world that is already at the
// current layout and decides per chunk whether anything changed.
// use super::dynamic::{as_int, has, remove};
// use super::files::{generators, subdirectories};
// use super::progress::{UpgradeDataFixType, UpgradeProgress, UpgradeStatus, UpgradeType};
// use super::schema::Ty;
// use super::{CURRENT, update_chunk_to, update_region_tag_to};
// use crate::compression::Compression;
// use crate::nbt::{Limits, Tag};
// use crate::region::{ChunkRecord, RegionFile};
// use horizon_core::position::ChunkPos;
// use std::collections::{BTreeMap, HashSet};
// use std::fs;
// use std::io;
// use std::path::{Path, PathBuf};
// use std::sync::Arc;
// use std::thread::JoinHandle;

NEW_DIRECTORY_PREFIX :: "new_"

// `RegionStorageUpgrader.TagModifier`: may change the upgraded tag and
// reports whether it did.
    // rust: pub type TagModifier = Box<dyn Fn(ChunkPos, &mut Tag) -> bool + Send + Sync>;

OVERWORLD :: "minecraft:overworld"
NETHER :: "minecraft:the_nether"
END :: "minecraft:the_end"

// `LevelStorageAccess.getDimensionPath`: `dimensions/<namespace>/<path>`.
dimension_path :: proc(base: ^Path, dimension: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let (namespace, path) = dimension
    // rust: .split_once(':')
    // rust: .unwrap_or(("minecraft", dimension));
    // rust: base.join("dimensions").join(namespace).join(path)
}

// The dimensions of a world: the three of vanilla, then any other folder
// below `dimensions/` (a datapack's, standing in for the `LEVEL_STEM` registry).
world_dimensions :: proc(base: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out: Vec<String> = [OVERWORLD, NETHER, END].map(str::to_owned).into();
    // rust: for namespace in subdirectories(&base.join("dimensions")) {
    // rust: for dimension in subdirectories(&namespace) {
    // rust: let id = format!(
    // rust: "{}:{}",
    // rust: namespace.file_name().unwrap_or_default().to_string_lossy(),
    // rust: dimension.file_name().unwrap_or_default().to_string_lossy()
    // rust: );
    // rust: if !out.contains(&id) {
    // rust: out.push(id);
}
}
}
    // rust: out
}

// `WorldUpgrader.verifyChunkPos`: warns about a chunk stored under another
// position; never reports a change.
verify_chunk_pos :: proc(pos: ChunkPos, upgraded: ^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let stored = ChunkPos::new(
    // rust: as_int(upgraded.get("xPos"), 0),
    // rust: as_int(upgraded.get("zPos"), 0),
    // rust: );
    // rust: if stored != pos {
    // rust: eprintln!("Chunk {pos:?} has invalid position {stored:?}");
}
    // rust: false
}

// `WorldUpgrader.verifyChunkPosAndEraseCache`: also drops the heightmaps,
// the light flag and the stored light of every section.
verify_chunk_pos_and_erase_cache :: proc(pos: ChunkPos, upgraded: ^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: verify_chunk_pos(pos, upgraded);
    // rust: let mut changed = has(upgraded, "Heightmaps");
    // rust: remove(upgraded, "Heightmaps");
    // rust: changed = changed || has(upgraded, "isLightOn");
    // rust: remove(upgraded, "isLightOn");
    // rust: if let Some(Tag::List(sections)) = upgraded.get_mut("sections") {
    // rust: for section in sections {
    // rust: if matches!(section, Tag::Compound(_)) {
    // rust: changed = changed || has(section, "BlockLight");
    // rust: remove(section, "BlockLight");
    // rust: changed = changed || has(section, "SkyLight");
    // rust: remove(section, "SkyLight");
}
}
}
    // rust: changed
}

// `UpgradeStatusTranslator.translate`: the translation key of the status line.
status_key :: proc(progress: ^UpgradeProgress) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match progress.status() {
    // rust: UpgradeStatus::Failed => return "optimizeWorld.stage.failed".into(),
    // rust: UpgradeStatus::Counting => return "optimizeWorld.stage.counting".into(),
    // rust: _ => {}
}
    // rust: let Some(ty) = progress.data_fix_type() else {
    // rust: return "optimizeWorld.stage.counting".into();
}
    // rust: let kind = match ty {
    // rust: UpgradeDataFixType::Chunk => "chunks",
    // rust: UpgradeDataFixType::EntityChunk => "entities",
    // rust: UpgradeDataFixType::PoiChunk => "poi",
}
    // rust: match progress.status() {
    // rust: UpgradeStatus::Upgrading => format!("optimizeWorld.stage.upgrading.{kind}"),
    // rust: _ => format!("optimizeWorld.stage.finished.{kind}"),
}
}

// `FileToUpgrade`: a region file and the chunks it holds.
FileToUpgrade :: struct {
    path: PathBuf,
    chunks: [dynamic]ChunkPos,
}

// `RegionStorageUpgrader.Builder`, as far as `WorldUpgrader` uses it.
Builder :: struct {
    data_fix_type: UpgradeDataFixType,
    folder: ^'static str,
    default_version: i32,
    recreate_region_files: bool,
    // The `__context` of a chunk: the dimension and generator type.
    context: Option<(string,
    tag_modifiers: BTreeMap<i32,
}

    // rust: impl Builder {
new :: proc(data_fix_type: UpgradeDataFixType, folder: ^'static str, recreate: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: data_fix_type,
    // rust: folder,
    // rust: default_version: if data_fix_type == UpgradeDataFixType::PoiChunk {
    // rust: 1945
    // rust: } else {
    // rust: -1
    // rust: },
    // rust: recreate_region_files: recreate,
    // rust: context: None,
    // rust: tag_modifiers: BTreeMap::new(),
}
}
    // `addTagModifier`: at most one per data version.
add_tag_modifier :: proc(self: ^Self, version: i32, modifier: TagModifier) {
}
    // rust: let previous = self.tag_modifiers.insert(version, Arc::new(modifier));
    // rust: assert!(
    // rust: previous.is_none(),
    // rust: "Can't add two fixers for the same data version"
    // rust: );
}
}

// `RegionStorageUpgrader`: one data type of one dimension.
RegionStorageUpgrader :: struct {
    builder: Builder,
    progress: ^UpgradeProgress,
    start_index: i32,
    dimension: string,
    region_folder: PathBuf,
    files: [dynamic]FileToUpgrade,
    // The open file chunks are written to (the source file itself, or the
    // new one of `recreate_region_files`).
    writer: Option<(PathBuf,
    // The open file chunks are read from.
    reader: Option<(PathBuf,
}

    // rust: impl RegionStorageUpgrader {
    // `init`: counts the chunks of the dimension's folder.
    // rust: fn init(
    // rust: builder: Builder,
    // rust: progress: Arc<UpgradeProgress>,
    // rust: start_index: i32,
    // rust: dimension: &str,
    // rust: base: &Path,
    // rust: ) -> Self {
    // rust: let region_folder = dimension_path(base, dimension).join(builder.folder);
    // rust: let files = all_chunk_positions(&region_folder);
    // rust: progress.add_total_file_fix_operations(files.len() as i32);
    // rust: progress.add_total_chunks(files.iter().map(|f| f.chunks.len() as i32).sum());
    // rust: Self {
    // rust: builder,
    // rust: progress,
    // rust: start_index,
    // rust: dimension: dimension.to_owned(),
    // rust: region_folder,
    // rust: files,
    // rust: writer: None,
    // rust: reader: None,
}
}

file_amount :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.files.len() as i32
}

    // `upgrade`.
upgrade :: proc(self: ^Self) {
}
    // rust: if self.files.is_empty() {
    // rust: return;
}
    // rust: let total_size = self.progress.total_file_fix_stats().total_operations() as f32;
    // rust: self.progress.set_status(UpgradeStatus::Upgrading);
    // rust: let files = std::mem::take(&mut self.files);
    // rust: let mut next = 0usize;
    // rust: while !self.progress.is_canceled() {
    // rust: let mut worked = false;
    // rust: if let Some(file) = files.get(next) {
    // rust: next += 1;
    // rust: let mut converted = true;
    // rust: for &pos in &file.chunks {
                    // `converted && processOnePosition(..)`: once a chunk was not
                    // converted the rest of the file is not looked at.
    // rust: converted = converted && self.process_one_position(&file.path, pos);
    // rust: worked = true;
}
    // rust: if self.builder.recreate_region_files {
    // rust: if converted {
    // rust: self.on_file_finished(&file.path);
    // rust: } else {
    // rust: eprintln!("Failed to convert region file {}", file.path.display());
}
}
}
    // rust: let dimension_progress = next as f32 / total_size;
    // rust: let total_progress = (self.start_index as usize + next) as f32 / total_size;
    // rust: self.progress
    // rust: .set_dimension_progress(&self.dimension, dimension_progress);
    // rust: self.progress.set_total_progress(total_progress);
    // rust: if !worked {
    // rust: break;
}
}
    // rust: self.progress.set_status(UpgradeStatus::Finished);
    // rust: self.close();
}

    // `processOnePosition`: an IO error skips the chunk, the logged way.
process_one_position :: proc(self: ^Self, file: ^Path, pos: ChunkPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let converted = match self.try_process_one_position(file, pos) {
    // rust: Ok(converted) => converted,
    // rust: Err(e) => {
    // rust: eprintln!("Error upgrading chunk {pos:?}: {e}");
    // rust: false
}
}
    // rust: if converted {
    // rust: self.progress.increment_converted();
    // rust: } else {
    // rust: self.progress.increment_skipped();
}
    // rust: converted
}

upgrade_tag :: proc(self: ^Self, tag: ^Tag, target_version: i32) {
}
    // rust: let version = as_int(tag.get("DataVersion"), self.builder.default_version);
    // rust: if version >= target_version {
    // rust: return;
}
    // rust: match self.builder.data_fix_type {
    // rust: UpgradeDataFixType::Chunk => {
    // rust: let (dimension, generator) = self
    // rust: .builder
    // rust: .context
    // rust: .as_ref()
    // rust: .map_or((self.dimension.as_str(), None), |(d, g)| {
    // rust: (d.as_str(), g.as_deref())
    // rust: });
    // rust: update_chunk_to(tag, dimension, generator, target_version);
}
    // rust: UpgradeDataFixType::EntityChunk => {
    // rust: update_region_tag_to(Ty::EntityChunk, tag, target_version)
}
    // rust: UpgradeDataFixType::PoiChunk => update_region_tag_to(Ty::PoiChunk, tag, target_version),
}
}

    // `tryProcessOnePosition`.
try_process_one_position :: proc(self: ^Self, file: ^Path, pos: ChunkPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let limits = Limits::default();
    // rust: if self.reader.as_ref().is_none_or(|(path, _)| path != file) {
    // rust: self.reader = Some((file.to_path_buf(), RegionFile::open(file)?));
}
    // rust: let Some(record) = self
    // rust: .reader
    // rust: .as_mut()
    // rust: .map_or(Ok(None), |(_, r)| r.read(pos))?
    // rust: else {
    // rust: return Ok(false);
}
    // rust: let mut root = record.nbt(limits)?;
    // rust: let version = as_int(root.tag.get("DataVersion"), -1);
    // rust: let mut changed = false;
    // rust: let modifiers: Vec<(i32, Arc<TagModifier>)> = self
    // rust: .builder
    // rust: .tag_modifiers
    // rust: .iter()
    // rust: .map(|(v, m)| (*v, m.clone()))
    // rust: .collect();
    // rust: for (needed_version, modifier) in modifiers {
    // rust: self.upgrade_tag(&mut root.tag, needed_version);
    // rust: changed |= modifier(pos, &mut root.tag);
}
    // rust: self.upgrade_tag(&mut root.tag, CURRENT);
    // rust: changed |= version < CURRENT;
    // rust: if changed || self.builder.recreate_region_files {
    // rust: let timestamp = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs() as u32);
    // rust: let out = ChunkRecord::from_nbt(&root, Compression::Zlib, timestamp, limits)?;
    // rust: let target = if self.builder.recreate_region_files {
    // rust: let dir = resolve_recreate_directory(&self.region_folder);
    // rust: fs::create_dir_all(&dir)?;
    // rust: dir.join(file.file_name().unwrap_or_default())
    // rust: } else {
    // rust: file.to_path_buf()
}
    // rust: if self.writer.as_ref().is_none_or(|(path, _)| *path != target) {
    // rust: self.writer = Some((target.clone(), RegionFile::open_writable(&target, true)?));
}
    // rust: if let Some((_, writer)) = self.writer.as_mut() {
    // rust: writer.write(pos, &out)?;
    // rust: writer.sync()?;
}
    // rust: return Ok(true);
}
    // rust: Ok(false)
}

    // `onFileFinished`: the rewritten file replaces the old one.
on_file_finished :: proc(self: ^Self, file: ^Path) {
}
    // rust: self.writer = None;
    // rust: self.reader = None;
    // rust: let new_file = resolve_recreate_directory(file.parent().unwrap_or(Path::new(".")))
    // rust: .join(file.file_name().unwrap_or_default());
    // rust: if new_file.exists() {
    // rust: if let Err(e) = fs::remove_file(file).and_then(|()| fs::rename(&new_file, file)) {
    // rust: eprintln!("Failed to replace an old region file: {e}");
}
    // rust: } else {
    // rust: eprintln!(
    // rust: "Failed to replace an old region file. New file {} does not exist.",
    // rust: new_file.display()
    // rust: );
}
}

    // `RecreatingSimpleRegionStorage.close`: the folder of the new files goes.
close :: proc(self: ^Self) {
}
    // rust: self.writer = None;
    // rust: self.reader = None;
    // rust: if self.builder.recreate_region_files {
    // rust: let _ = fs::remove_dir_all(resolve_recreate_directory(&self.region_folder));
}
}
}

// `resolveRecreateDirectory`: `new_` + the folder's name, beside it.
resolve_recreate_directory :: proc(folder: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let name = folder.file_name().unwrap_or_default().to_string_lossy();
    // rust: folder.with_file_name(format!("{NEW_DIRECTORY_PREFIX}{name}"))
}

// `r.<x>.<z>.mca`'s coordinates (`REGEX`).
region_coordinates :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let rest = name.strip_prefix("r.")?.strip_suffix(".mca")?;
    // rust: let (x, z) = rest.split_once('.')?;
    // rust: let digits = |s: &str| {
    // rust: let body = s.strip_prefix('-').unwrap_or(s);
    // rust: !body.is_empty() && body.bytes().all(|b| b.is_ascii_digit())
}
    // rust: if !digits(x) || !digits(z) {
    // rust: return None;
}
    // rust: Some((x.parse().ok()?, z.parse().ok()?))
}

// `getAllChunkPositions`: the region files of a folder and the chunks in each.
all_chunk_positions :: proc(folder: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(read) = fs::read_dir(folder) else {
    // rust: return Vec::new();
}
    // rust: let mut paths: Vec<PathBuf> = read.filter_map(Result::ok).map(|e| e.path()).collect();
    // rust: paths.sort();
    // rust: let mut out = Vec::new();
    // rust: for path in paths {
    // rust: let name = path
    // rust: .file_name()
    // rust: .unwrap_or_default()
    // rust: .to_string_lossy()
    // rust: .into_owned();
    // rust: let Some((rx, rz)) = region_coordinates(&name) else {
    // rust: continue;
}
    // rust: let (x_offset, z_offset) = (rx.wrapping_shl(5), rz.wrapping_shl(5));
    // rust: match RegionFile::open(&path) {
    // rust: Ok(region) => {
    // rust: let present: HashSet<ChunkPos> = region.chunks().map(|(p, _)| p).collect();
    // rust: let mut chunks = Vec::new();
    // rust: for x in 0..32 {
    // rust: for z in 0..32 {
    // rust: let pos = ChunkPos::new(x + x_offset, z + z_offset);
    // rust: if present.contains(&pos) {
    // rust: chunks.push(pos);
}
}
}
    // rust: if !chunks.is_empty() {
    // rust: out.push(FileToUpgrade { path, chunks });
}
}
    // rust: Err(e) => eprintln!(
    // rust: "Failed to read chunks from region file {}: {e}",
    // rust: path.display()
    // rust: ),
}
}
    // rust: out
}

// `WorldUpgrader`: runs on its own thread from [`WorldUpgrader::new`] on.
WorldUpgrader :: struct {
    levels: [dynamic]string,
    progress: ^UpgradeProgress,
    thread: Maybe(JoinHandle<())>,
}

    // rust: impl WorldUpgrader {
    // Start upgrading the world in `base` (the folder with `level.dat`):
    // `levels` are its dimensions ([`world_dimensions`]).
    // rust: pub fn new(
    // rust: base: &Path,
    // rust: levels: Vec<String>,
    // rust: erase_cache: bool,
    // rust: recreate_region_files: bool,
    // rust: ) -> Self {
    // rust: let progress = Arc::new(UpgradeProgress::new());
    // rust: let worker_progress = progress.clone();
    // rust: let worker_levels = levels.clone();
    // rust: let base = base.to_path_buf();
    // rust: let thread = std::thread::Builder::new()
    // rust: .name("World Upgrader #0".into())
    // rust: .spawn(move || {
    // rust: let result = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
    // rust: work(
    // rust: &base,
    // rust: &worker_levels,
    // rust: &worker_progress,
    // rust: erase_cache,
    // rust: recreate_region_files,
    // rust: );
    // rust: }));
    // rust: if result.is_err() {
                    // The uncaught exception handler.
    // rust: eprintln!("Error upgrading world");
    // rust: worker_progress.set_status(UpgradeStatus::Failed);
    // rust: worker_progress.set_finished(true);
}
    // rust: })
    // rust: .ok();
    // rust: Self {
    // rust: levels,
    // rust: progress,
    // rust: thread,
}
}

    // `cancel`: stops after the file in hand and waits for the worker.
cancel :: proc(self: ^Self) {
}
    // rust: self.progress.set_canceled();
    // rust: if let Some(thread) = self.thread.take() {
    // rust: let _ = thread.join();
}
}
is_finished :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.progress.is_finished()
}
levels :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.levels
}
dimension_progress :: proc(self: ^Self, dimension: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.progress.dimension_progress(dimension)
}
total_progress :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.progress.total_progress()
}
total_chunks :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.progress.total_chunks()
}
converted :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.progress.converted()
}
skipped :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.progress.skipped()
}
    // `getStatus`, as a translation key.
status_key :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: status_key(&self.progress)
}
}

    // rust: impl Drop for WorldUpgrader {
drop :: proc(self: ^Self) {
}
        // The screen's `removed`: `cancel` then `close`.
    // rust: self.cancel();
}
}

// `WorldUpgrader.work`.
    // rust: fn work(
    // rust: base: &Path,
    // rust: levels: &[String],
    // rust: progress: &Arc<UpgradeProgress>,
    // rust: erase_cache: bool,
    // rust: recreate: bool,
    // rust: ) {
    // rust: let started = std::time::Instant::now();
    // rust: upgrade_levels(
    // rust: base,
    // rust: levels,
    // rust: progress,
    // rust: Builder::new(UpgradeDataFixType::EntityChunk, "entities", recreate),
    // rust: |_, _| {},
    // rust: );
    // rust: upgrade_levels(
    // rust: base,
    // rust: levels,
    // rust: progress,
    // rust: Builder::new(UpgradeDataFixType::PoiChunk, "poi", recreate),
    // rust: |_, _| {},
    // rust: );
    // rust: let generators = generators(base).unwrap_or_default();
    // rust: upgrade_levels(
    // rust: base,
    // rust: levels,
    // rust: progress,
    // rust: Builder::new(UpgradeDataFixType::Chunk, "region", recreate),
    // rust: |builder, level| {
    // rust: let generator = generators
    // rust: .iter()
    // rust: .find(|(d, _)| d == level)
    // rust: .map(|(_, g)| g.clone());
    // rust: builder.context = Some((level.to_owned(), generator));
    // rust: let modifier: TagModifier = if erase_cache {
    // rust: Box::new(verify_chunk_pos_and_erase_cache)
    // rust: } else {
    // rust: Box::new(verify_chunk_pos)
}
    // rust: builder.add_tag_modifier(CURRENT, modifier);
    // rust: },
    // rust: );
    // rust: eprintln!(
    // rust: "World optimization finished after {} seconds",
    // rust: started.elapsed().as_secs()
    // rust: );
    // rust: progress.set_finished(true);
}

// `upgradeLevels`: counts every dimension first, then upgrades them in turn.
    // rust: fn upgrade_levels(
    // rust: base: &Path,
    // rust: levels: &[String],
    // rust: progress: &Arc<UpgradeProgress>,
    // rust: builder: Builder,
    // rust: level_specific: impl Fn(&mut Builder, &str),
    // rust: ) {
    // rust: progress.reset(builder.data_fix_type);
    // rust: progress.set_type(UpgradeType::Regions);
    // rust: let mut previous_copies_file_amounts = 0;
    // rust: let mut upgraders = Vec::new();
    // rust: for level in levels {
    // rust: let mut copy = builder.clone();
    // rust: level_specific(&mut copy, level);
    // rust: let upgrader = RegionStorageUpgrader::init(
    // rust: copy,
    // rust: progress.clone(),
    // rust: previous_copies_file_amounts,
    // rust: level,
    // rust: base,
    // rust: );
    // rust: previous_copies_file_amounts += upgrader.file_amount();
    // rust: upgraders.push(upgrader);
}
    // rust: for upgrader in &mut upgraders {
    // rust: upgrader.upgrade();
}
}

    // rust: mod tests;
