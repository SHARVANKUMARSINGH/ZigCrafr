//! Transpiled from Horizon Rust crate
//! Module: horizon-server_prune
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `[prune_chunks]` in server.toml: deletes the chunks players barely visited, so a world that players
//! crossed in every direction shrinks back (docs/hosting.md). A chunk whose `InhabitedTime` (vanilla's
//! count of the ticks a player spent near it) is under `min_inhabited_ticks` generates again from the
//! seed, as it was, when someone comes back. Kept whatever their time: the chunks within `spawn_radius`
//! of the world spawn (of 0 0 in the other dimensions), the chunks the files in `keep_files` name (the
//! SMP mod's claims and homes), every chunk that can't be read, and `ring` chunks around every kept
//! chunk, so no seam opens beside a build.
//!
//! `mode = "dry-run"` only writes the report, while the game runs; `mode = "delete"` prunes before the
//! game starts. Either sets `mode` back to "off". The chunk's entries in `entities/` and `poi/` go with
//! it; region files are rewritten compacted in vanilla's format (each kept chunk's bytes and timestamp
//! copied as they were) and a file left empty is deleted. Nothing else in the world is touched: not
//! level.dat, player data, stats or advancements.

// use horizon_world::{
    // rust: nbt::{self, Limits, Tag},
    // rust: region::{ChunkRecord, RegionFile, RegionWriter, position_from_path},
}
// use serde::{Deserialize, Serialize};
// use std::{
    // rust: collections::{BTreeMap, HashSet},
    // rust: fmt::Write as _,
    // rust: fs,
    // rust: io::{self, Read, Seek, SeekFrom},
    // rust: path::{Path, PathBuf},
    // rust: sync::atomic::{AtomicUsize, Ordering},
}

pub const SECTOR: u64 = 4096;
/// Where rewritten files wait, inside each folder, before they replace the old ones in one rename.
pub const STAGING: []const u8 = ".horizon-prune";
/// The decoded bytes read first: `InhabitedTime` comes before the sections in vanilla's and Horizon's
/// chunks, so most chunks are never decoded in full.
pub const PREFIX: usize = 16 * 1024;
pub const KINDS: [[]const u8; 3] = ["region", "entities", "poi"];

pub const Mode = enum {
    Off,
    DryRun,
    Delete,
};

pub const Settings = struct {
    /// "off", "dry-run" (a report, the game starts at once) or "delete" (before the game starts).
    mode: Mode,
    /// Chunks with less `InhabitedTime` than this go (1200 ticks: a minute).
    min_inhabited_ticks: i64,
    /// Chunks this close to the spawn (in chunks, on each axis) are kept.
    spawn_radius: u32,
    /// Chunks this close to a kept chunk are kept too.
    ring: u32,
    /// JSON files in the world folder naming chunks to keep: keys or strings `<dimension> <chunk x>
    /// <chunk z>` (claims), and objects with `dimension`, `x` and `z` (homes, warps). A file that is
    /// missing is skipped; one that can't be read stops the prune.
    keep_files: std.ArrayList([]const u8),
};

    // rust: impl Default for Settings {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: mode: Mode::Off,
    // rust: min_inhabited_ticks: 1200,
    // rust: spawn_radius: 32,
    // rust: ring: 1,
    // rust: keep_files: vec![
    // rust: "horizon-smp/claims.json".into(),
    // rust: "horizon-smp/places.json".into(),
    // rust: ],
}
}
}

    // rust: impl Settings {
pub fn is_default(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self == Self::default()
}

pub fn check(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.min_inhabited_ticks < 0 || self.ring > 8 {
    // rust: return Err("prune_chunks: min_inhabited_ticks must be 0 or more, ring 0 to 8".into());
}
    // rust: if let Some(bad) = self
    // rust: .keep_files
    // rust: .iter()
    // rust: .find(|f| Path::new(f).is_absolute() || f.split(['/', '\\']).any(|p| p == ".."))
    // rust: {
    // rust: return Err(format!(
    // rust: "prune_chunks.keep_files: {bad:?} must be a path inside the world folder"
    // rust: ));
}
    // rust: Ok(())
}
}

    // rust: type Chunk = (i32, i32);

pub const Bits = struct {};
    // rust: impl Bits {
pub fn set(self: *Self, i: usize) void {
}
    // rust: self.0[i / 64] |= 1 << (i % 64);
}
pub fn has(self: *Self, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0[i / 64] & (1 << (i % 64)) != 0
}
pub fn count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.iter().map(|w| w.count_ones()).sum()
}
}

pub fn slot(c: Chunk) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (c.0 & 31) as usize + (c.1 & 31) as usize * 32
}

/// A region file's header, read without its chunks.
pub const Header = struct {
    len: u64,
    /// Each slot's sector count (0: no chunk).
    sectors: [u8,
    /// A chunk too big for the file lives in its own `.mcc` file: such regions are left as they are.
    oversized: bool,
};

pub fn header(path: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut file = fs::File::open(path)?;
    // rust: let len = file.metadata()?.len();
    // As vanilla's RegionFile: a short file reads as far as it goes, and entries that overlap the header,
    // are empty or start past the end hold no chunk.
    // rust: let mut table = Vec::with_capacity(4096);
    // rust: (&mut file).take(4096).read_to_end(&mut table)?;
    // rust: table.resize(4096, 0);
    // rust: let mut sectors = [0; 1024];
    // rust: let mut oversized = false;
    // rust: for (i, entry) in table.as_chunks::<4>().0.iter().enumerate() {
    // rust: let entry = u32::from_be_bytes(*entry);
    // rust: let start = u64::from(entry >> 8);
    // rust: if start < 2 || entry & 255 == 0 || start * SECTOR > len {
    // rust: continue;
}
    // rust: sectors[i] = (entry & 255) as u8;
    // rust: let mut head = [0; 5];
    // rust: file.seek(SeekFrom::Start(u64::from(entry >> 8) * SECTOR))?;
    // rust: if file.read_exact(&mut head).is_ok() && head[4] & 128 != 0 {
    // rust: oversized = true;
}
}
    // rust: Ok(Header {
    // rust: len,
    // rust: sectors,
    // rust: oversized,
    // rust: })
}

/// What a compacted file would hold without `drop`: its new length (0: deleted).
pub fn compacted_len(h: *Header, gone: *Bits) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kept: u64 = (0..1024)
    // rust: .filter(|&i| h.sectors[i] != 0 && !gone.has(i))
    // rust: .map(|i| u64::from(h.sectors[i]))
    // rust: .sum();
    // rust: if kept == 0 { 0 } else { (2 + kept) * SECTOR }
}

/// One region file of chunks after the scan.
pub const Scan = enum {
    Read {,
    present: Bits,
        /// Inhabited long enough, or unreadable.
    busy: Bits,
    unreadable: u32,
    header: Header,
    // rust: },
    /// The file couldn't be read: every chunk in it counts as kept.
    Failed(String),
};

pub fn scan_region(path: *Path, min_ticks: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let result = (|| -> io::Result<Scan> {
    // rust: let header = header(path)?;
    // rust: let mut file = RegionFile::open(path)?;
    // rust: let (mut present, mut busy, mut unreadable) = (Bits::default(), Bits::default(), 0);
    // rust: let chunks: Vec<_> = file.chunks().map(|(c, _)| c).collect();
    // rust: for c in chunks {
    // rust: let i = slot((c.x, c.z));
    // rust: present.set(i);
    // rust: match file.read(c).ok().flatten().and_then(|r| inhabited(&r)) {
    // rust: Some(t) if t < min_ticks => {}
    // rust: Some(_) => busy.set(i),
    // rust: None => {
    // rust: busy.set(i);
    // rust: unreadable += 1;
}
}
}
    // rust: Ok(Scan::Read {
    // rust: present,
    // rust: busy,
    // rust: unreadable,
    // rust: header,
    // rust: })
    // rust: })();
    // rust: result.unwrap_or_else(|e| Scan::Failed(e.to_string()))
}

/// A chunk's `InhabitedTime`, or None when it has none or can't be read.
pub fn inhabited(record: *ChunkRecord) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut bytes = Vec::new();
    // rust: let whole = record
    // rust: .compression
    // rust: .decode_into(&record.compressed, PREFIX, &mut bytes)
    // rust: .is_ok();
    // rust: match skim(&bytes, "InhabitedTime") {
    // rust: Ok(found) => found,
    // rust: Err(Skim::Short) if !whole => {
    // rust: let bytes = record
    // rust: .compression
    // rust: .decode(&record.compressed, Limits::saved().max_bytes)
    // rust: .ok()?;
    // rust: skim(&bytes, "InhabitedTime").ok().flatten()
}
    // rust: Err(_) => None,
}
}

pub const Skim = enum {
    Short,
    Bad,
};

/// A long tag at the top of an NBT root, read without building the tree.
pub fn skim(bytes: []const u8, key: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut c = Cursor { bytes, at: 0 };
    // rust: if c.take(1)?[0] != 10 {
    // rust: return Err(Skim::Bad);
}
    // rust: let n = c.short()?;
    // rust: c.take(n)?;
    // rust: loop {
    // rust: let id = c.take(1)?[0];
    // rust: if id == 0 {
    // rust: return Ok(None);
}
    // rust: let n = c.short()?;
    // rust: let name = c.take(n)?;
    // rust: if id == 4 && name == key.as_bytes() {
    // rust: return Ok(Some(i64::from_be_bytes(c.take(8)?.try_into().unwrap())));
}
    // rust: c.skip(id, 0)?;
}
}

pub const Cursor = struct {
    bytes: *'a [u8],
    at: usize,
};

    // rust: impl<'a> Cursor<'a> {
pub fn take(self: *Self, n: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let end = self.at.checked_add(n).ok_or(Skim::Bad)?;
    // rust: let out = self.bytes.get(self.at..end).ok_or(Skim::Short)?;
    // rust: self.at = end;
    // rust: Ok(out)
}
pub fn short(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(u16::from_be_bytes(self.take(2)?.try_into().unwrap()) as usize)
}
pub fn count(self: *Self, width: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = i32::from_be_bytes(self.take(4)?.try_into().unwrap());
    // rust: usize::try_from(n)
    // rust: .map_err(|_| Skim::Bad)?
    // rust: .checked_mul(width)
    // rust: .ok_or(Skim::Bad)
}
    /// Skips a payload of type `id`.
pub fn skip(self: *Self, id: u8, depth: u32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if depth > 512 {
    // rust: return Err(Skim::Bad);
}
    // rust: match id {
    // rust: 1 => drop(self.take(1)?),
    // rust: 2 => drop(self.take(2)?),
    // rust: 3 | 5 => drop(self.take(4)?),
    // rust: 4 | 6 => drop(self.take(8)?),
    // rust: 7 => drop(self.count(1).and_then(|n| self.take(n))?),
    // rust: 11 => drop(self.count(4).and_then(|n| self.take(n))?),
    // rust: 12 => drop(self.count(8).and_then(|n| self.take(n))?),
    // rust: 8 => drop(self.short().and_then(|n| self.take(n))?),
    // rust: 9 => {
    // rust: let element = self.take(1)?[0];
    // rust: let n = self.count(1)?;
    // rust: for _ in 0..n {
    // rust: self.skip(element, depth + 1)?;
}
}
    // rust: 10 => loop {
    // rust: let id = self.take(1)?[0];
    // rust: if id == 0 {
    // rust: break;
}
    // rust: let n = self.short()?;
    // rust: self.take(n)?;
    // rust: self.skip(id, depth + 1)?;
    // rust: },
    // rust: _ => return Err(Skim::Bad),
}
    // rust: Ok(())
}
}

/// One dimension's folder and its scanned regions.
pub const Dimension = struct {
    id: []const u8,
    folder: PathBuf,
    center: Chunk,
    regions: BTreeMap<Chunk,
};

pub const Tally = struct {
    chunks: u64,
    pruned: u64,
    listed: u64,
    spawn: u64,
    busy: u64,
    ring: u64,
    unreadable: u64,
    files: u64,
    emptied: u64,
    skipped: u64,
    /// Bytes freed per kind (region, entities, poi).
    freed: [u64,
    /// Bytes of every file of each kind before.
    before: [u64,
};

/// The world's spawn chunk from level.dat (`spawn.pos` in 26.3, `SpawnX`/`SpawnZ` before), else 0 0.
pub fn spawn_chunk(world: *Path) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let read = || -> Option<Chunk> {
    // rust: let bytes = fs::read(world.join("level.dat")).ok()?;
    // rust: let bytes = horizon_world::compression::Compression::Gzip
    // rust: .decode(&bytes, Limits::saved().max_bytes)
    // rust: .ok()?;
    // rust: let (root, _) = nbt::read_named(&bytes, Limits::saved()).ok()?;
    // rust: let data = root.tag.get("Data")?;
    // rust: let int = |t: Option<&Tag>| match t {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: _ => None,
}
    // rust: let (x, z) = match data.get("spawn").and_then(|s| s.get("pos")) {
    // rust: Some(Tag::IntArray(p)) if p.len() == 3 => (p[0], p[2]),
    // rust: _ => (int(data.get("SpawnX"))?, int(data.get("SpawnZ"))?),
}
    // rust: Some((x >> 4, z >> 4))
}
    // rust: read().unwrap_or((0, 0))
}

/// The chunks `keep_files` name, by dimension. Err when a file exists but can't be read.
    // rust: fn listed(
    // rust: world: &Path,
    // rust: files: &[String],
    // rust: notes: &mut Vec<String>,
    // rust: ) -> Result<HashSet<(String, i32, i32)>, String> {
    // rust: let mut out = HashSet::new();
    // rust: for name in files {
    // rust: let path = world.join(name);
    // rust: let text = match fs::read_to_string(&path) {
    // rust: Ok(t) => t,
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => {
    // rust: notes.push(format!("{name}: not there, nothing kept from it"));
    // rust: continue;
}
    // rust: Err(e) => return Err(format!("{}: {e}", path.display())),
}
    // rust: let value: serde_json::Value =
    // rust: serde_json::from_str(&text).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let before = out.len();
    // rust: collect(&value, &mut out);
    // rust: notes.push(format!("{name}: {} chunks kept", out.len() - before));
}
    // rust: Ok(out)
}

pub fn collect(value: *serde_json::Value, out: *mut HashSet<([]const u8) void {
}
    // rust: let named = |s: &str, out: &mut HashSet<_>| {
    // rust: let mut w = s.split(' ');
    // rust: if let (Some(d), Some(Ok(x)), Some(Ok(z)), None) = (
    // rust: w.next(),
    // rust: w.next().map(str::parse),
    // rust: w.next().map(str::parse),
    // rust: w.next(),
    // rust: ) && d.contains(':')
    // rust: {
    // rust: out.insert((d.to_owned(), x, z));
}
}
    // rust: match value {
    // rust: serde_json::Value::String(s) => named(s, out),
    // rust: serde_json::Value::Array(items) => items.iter().for_each(|v| collect(v, out)),
    // rust: serde_json::Value::Object(map) => {
    // rust: if let (Some(d), Some(x), Some(z)) = (
    // rust: map.get("dimension").and_then(|v| v.as_str()),
    // rust: map.get("x").and_then(|v| v.as_f64()),
    // rust: map.get("z").and_then(|v| v.as_f64()),
    // rust: ) {
    // rust: out.insert((
    // rust: d.to_owned(),
    // rust: (x.floor() as i32) >> 4,
    // rust: (z.floor() as i32) >> 4,
    // rust: ));
}
    // rust: for (k, v) in map {
    // rust: named(k, out);
    // rust: collect(v, out);
}
}
    // rust: _ => {}
}
}

/// The dimension folders of a world: `dimensions/<namespace>/<path>` (26.3), and the older `region/`,
/// `DIM-1/`, `DIM1/` if a world still has them.
pub fn dimensions(world: *Path, spawn: Chunk) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let center = |id: &str| {
    // rust: if id == "minecraft:overworld" {
    // rust: spawn
    // rust: } else {
    // rust: (0, 0)
}
}
    // rust: for (id, folder) in [
    // rust: ("minecraft:overworld", world.to_owned()),
    // rust: ("minecraft:the_nether", world.join("DIM-1")),
    // rust: ("minecraft:the_end", world.join("DIM1")),
    // rust: ] {
    // rust: if folder.join("region").is_dir() {
    // rust: out.push((id.to_owned(), folder, center(id)));
}
}
    // rust: let mut namespaces: Vec<_> = fs::read_dir(world.join("dimensions"))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .collect();
    // rust: namespaces.sort_by_key(|e| e.file_name());
    // rust: for ns in namespaces {
    // rust: let mut paths: Vec<_> = fs::read_dir(ns.path())
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .collect();
    // rust: paths.sort_by_key(|e| e.file_name());
    // rust: for p in paths {
    // rust: if p.path().join("region").is_dir() {
    // rust: let id = format!(
    // rust: "{}:{}",
    // rust: ns.file_name().to_string_lossy(),
    // rust: p.file_name().to_string_lossy()
    // rust: );
    // rust: let c = center(&id);
    // rust: out.push((id, p.path(), c));
}
}
}
    // rust: out
}

pub fn region_files(folder: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: Vec<_> = fs::read_dir(folder)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: let p = e.path();
    // rust: let at = position_from_path(&p).ok()?;
    // rust: p.is_file().then_some(((at.x, at.z), p))
    // rust: })
    // rust: .collect();
    // rust: out.sort();
    // rust: out
}

/// `f` over `items` on `threads` threads, results in order.
    // rust: fn parallel<T: Sync, R: Send>(items: &[T], threads: usize, f: impl Fn(&T) -> R + Sync) -> Vec<R> {
    // rust: let next = AtomicUsize::new(0);
    // rust: let mut out: Vec<(usize, R)> = std::thread::scope(|s| {
    // rust: let workers: Vec<_> = (0..threads.max(1))
    // rust: .map(|_| {
    // rust: s.spawn(|| {
    // rust: let mut mine = Vec::new();
    // rust: loop {
    // rust: let i = next.fetch_add(1, Ordering::Relaxed);
    // rust: let Some(item) = items.get(i) else { break };
    // rust: mine.push((i, f(item)));
}
    // rust: mine
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: workers
    // rust: .into_iter()
    // rust: .flat_map(|w| w.join().unwrap())
    // rust: .collect()
    // rust: });
    // rust: out.sort_by_key(|(i, _)| *i);
    // rust: out.into_iter().map(|(_, r)| r).collect()
}

/// Rewrites a region file without the chunks in `drop`, compacted; deletes it if nothing is left.
/// The new file replaces the old one in one rename, so a stop halfway leaves the old file whole.
pub fn rewrite(path: *Path, gone: *Bits) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let folder = path.parent().unwrap_or(Path::new("."));
    // rust: let staged = folder.join(STAGING).join(path.file_name().unwrap());
    // rust: match fs::remove_file(&staged) {
    // rust: Err(e) if e.kind() != io::ErrorKind::NotFound => return Err(e),
    // rust: _ => {}
}
    // rust: let mut source = RegionFile::open(path)?;
    // rust: let chunks: Vec<_> = source.chunks().map(|(c, _)| c).collect();
    // rust: let mut writer = None;
    // rust: for c in chunks {
    // rust: if gone.has(slot((c.x, c.z))) {
    // rust: continue;
}
    // rust: let record = source
    // rust: .read(c)?
    // rust: .ok_or_else(|| io::Error::other("a chunk vanished while copying"))?;
    // rust: if writer.is_none() {
    // rust: writer = Some(RegionWriter::create(&staged)?);
}
    // rust: writer.as_mut().unwrap().write(c, &record)?;
}
    // rust: drop(source);
    // rust: match writer {
    // rust: Some(w) => {
    // rust: w.finish()?;
            // The new file keeps the old one's permissions (a server folder readable by its owner only).
    // rust: fs::set_permissions(&staged, fs::metadata(path)?.permissions())?;
    // rust: fs::rename(&staged, path)
}
    // rust: None => fs::remove_file(path),
}
}

/// What a run found (and, deleting, did): the report's text.
pub const Outcome = struct {
    report: []const u8,
    summary: []const u8,
};

/// Scans the world and, with `delete`, prunes it. The game must not be running when `delete` is set.
    // rust: pub fn run(
    // rust: world: &Path,
    // rust: settings: &Settings,
    // rust: delete: bool,
    // rust: threads: usize,
    // rust: ) -> Result<Outcome, String> {
    // rust: let started = std::time::Instant::now();
    // rust: let mut notes = Vec::new();
    // rust: let keep = listed(world, &settings.keep_files, &mut notes)?;
    // rust: let spawn = spawn_chunk(world);
    // rust: let mut dims: Vec<Dimension> = Vec::new();
    // rust: for (id, folder, center) in dimensions(world, spawn) {
    // rust: let files = region_files(&folder.join("region"));
    // rust: let scans = parallel(&files, threads, |(_, p)| {
    // rust: scan_region(p, settings.min_inhabited_ticks)
    // rust: });
    // rust: let regions = files.into_iter().map(|(at, _)| at).zip(scans).collect();
    // rust: dims.push(Dimension {
    // rust: id,
    // rust: folder,
    // rust: center,
    // rust: regions,
    // rust: });
}
    // rust: let (r, ring) = (settings.spawn_radius as i32, settings.ring as i32);
    // rust: let mut tallies = Vec::new();
    // rust: let mut errors = Vec::new();
    // rust: for dim in &dims {
    // rust: let near_spawn =
    // rust: |c: Chunk| (c.0 - dim.center.0).abs() <= r && (c.1 - dim.center.1).abs() <= r;
    // rust: let mine: HashSet<Chunk> = keep
    // rust: .iter()
    // rust: .filter(|(d, _, _)| *d == dim.id)
    // rust: .map(|&(_, x, z)| (x, z))
    // rust: .collect();
    // rust: let is_listed = |c: Chunk| mine.contains(&c);
    // rust: let kept = |c: Chunk| {
    // rust: near_spawn(c)
    // rust: || is_listed(c)
    // rust: || match dim.regions.get(&(c.0 >> 5, c.1 >> 5)) {
    // rust: Some(Scan::Read { busy, .. }) => busy.has(slot(c)),
    // rust: Some(Scan::Failed(_)) => true,
    // rust: None => false,
}
}
    // rust: let mut t = Tally::default();
    // rust: let mut work: Vec<(PathBuf, Bits)> = Vec::new();
    // rust: for (kind, k) in KINDS.iter().zip(0..) {
    // rust: t.before[k] = region_files(&dim.folder.join(kind))
    // rust: .iter()
    // rust: .filter_map(|(_, p)| fs::metadata(p).ok())
    // rust: .map(|m| m.len())
    // rust: .sum();
}
    // rust: for (&(rx, rz), scan) in &dim.regions {
    // rust: t.files += 1;
    // rust: let (present, busy, unreadable, head) = match scan {
    // rust: Scan::Read {
    // rust: present,
    // rust: busy,
    // rust: unreadable,
    // rust: header,
    // rust: } => (present, busy, *unreadable, header),
    // rust: Scan::Failed(e) => {
    // rust: errors.push(format!("{} r.{rx}.{rz}.mca: {e} (left as it is)", dim.id));
    // rust: t.skipped += 1;
    // rust: continue;
}
}
    // rust: t.unreadable += u64::from(unreadable);
    // rust: let mut gone = Bits::default();
    // rust: for i in (0..1024).filter(|&i| present.has(i)) {
    // rust: let c = (rx * 32 + (i % 32) as i32, rz * 32 + (i / 32) as i32);
    // rust: t.chunks += 1;
    // rust: if is_listed(c) {
    // rust: t.listed += 1;
    // rust: } else if near_spawn(c) {
    // rust: t.spawn += 1;
    // rust: } else if busy.has(i) {
    // rust: t.busy += 1;
    // rust: } else if (-ring..=ring)
    // rust: .any(|dx| (-ring..=ring).any(|dz| kept((c.0 + dx, c.1 + dz))))
    // rust: {
    // rust: t.ring += 1;
    // rust: } else {
    // rust: gone.set(i);
}
}
    // rust: if gone.count() == 0 {
    // rust: continue;
}
    // rust: let name = format!("r.{rx}.{rz}.mca");
    // rust: let others: io::Result<Vec<_>> = KINDS[1..]
    // rust: .iter()
    // rust: .map(|kind| dim.folder.join(kind).join(&name))
    // rust: .filter(|p| p.is_file())
    // rust: .map(|p| header(&p).map(|h| (p, h)))
    // rust: .collect();
    // rust: let others = match others {
    // rust: Ok(o) => o,
    // rust: Err(e) => {
    // rust: errors.push(format!(
    // rust: "{} {name}'s entities or poi: {e} (left as it is)",
    // rust: dim.id
    // rust: ));
    // rust: t.skipped += 1;
    // rust: continue;
}
}
    // rust: if head.oversized || others.iter().any(|(_, h)| h.oversized) {
    // rust: t.skipped += 1;
    // rust: continue;
}
    // rust: t.pruned += u64::from(gone.count());
    // rust: let new = compacted_len(head, &gone);
    // rust: t.freed[0] += head.len.saturating_sub(new);
    // rust: t.emptied += u64::from(new == 0);
    // rust: for (p, h) in others {
    // rust: let k = 1 + usize::from(p.parent().is_some_and(|f| f.ends_with("poi")));
    // rust: t.freed[k] += h.len.saturating_sub(compacted_len(&h, &gone));
    // rust: work.push((p, gone));
}
            // Entities and POI first: a chunk generated again must never find the old one's entities.
    // rust: work.push((dim.folder.join("region").join(&name), gone));
}
    // rust: if delete {
    // rust: for kind in KINDS {
    // rust: let _ = fs::create_dir_all(dim.folder.join(kind).join(STAGING));
}
    // rust: let failed = parallel(&work, threads, |(p, gone)| {
    // rust: rewrite(p, gone)
    // rust: .err()
    // rust: .map(|e| format!("{}: {e}", p.display()))
    // rust: });
    // rust: errors.extend(failed.into_iter().flatten());
    // rust: for kind in KINDS {
    // rust: let _ = fs::remove_dir_all(dim.folder.join(kind).join(STAGING));
}
}
    // rust: tallies.push((dim.id.clone(), t));
}
    // rust: let seconds = started.elapsed().as_secs();
    // rust: Ok(report(
    // rust: settings, delete, spawn, &tallies, &notes, &errors, seconds,
    // rust: ))
}

pub fn mib(b: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{:.1}", b as f64 / 1_048_576.0)
}

    // rust: fn report(
    // rust: settings: &Settings,
    // rust: delete: bool,
    // rust: spawn: Chunk,
    // rust: tallies: &[(String, Tally)],
    // rust: notes: &[String],
    // rust: errors: &[String],
    // rust: seconds: u64,
    // rust: ) -> Outcome {
    // rust: let mut text = String::new();
    // rust: let verb = if delete {
    // rust: "Deleted"
    // rust: } else {
    // rust: "Would delete (dry run)"
}
    // rust: let _ = writeln!(
    // rust: text,
    // rust: "Chunk prune, {}: chunks with InhabitedTime < {} ticks, except within {} chunks of the spawn \
    // rust: (chunk {} {} in the overworld, 0 0 elsewhere), the listed chunks and a ring of {} around every kept chunk.",
    // rust: if delete { "deleted" } else { "dry run" },
    // rust: settings.min_inhabited_ticks,
    // rust: settings.spawn_radius,
    // rust: spawn.0,
    // rust: spawn.1,
    // rust: settings.ring
    // rust: );
    // rust: for n in notes {
    // rust: let _ = writeln!(text, "  keep_files {n}");
}
    // rust: let _ = writeln!(
    // rust: text,
    // rust: "\n{:<24} {:>9} {:>9} {:>8} {:>7} {:>9} {:>7} {:>6} {:>7} {:>7} {:>7} {:>11} {:>11} {:>11}",
    // rust: "dimension",
    // rust: "chunks",
    // rust: "pruned",
    // rust: "listed",
    // rust: "spawn",
    // rust: "inhabited",
    // rust: "ring",
    // rust: "unread",
    // rust: "files",
    // rust: "emptied",
    // rust: "skipped",
    // rust: "region MiB",
    // rust: "entity MiB",
    // rust: "poi MiB"
    // rust: );
    // rust: let mut total = Tally::default();
    // rust: for (id, t) in tallies {
    // rust: let _ = writeln!(
    // rust: text,
    // rust: "{:<24} {:>9} {:>9} {:>8} {:>7} {:>9} {:>7} {:>6} {:>7} {:>7} {:>7} {:>11} {:>11} {:>11}",
    // rust: id,
    // rust: t.chunks,
    // rust: t.pruned,
    // rust: t.listed,
    // rust: t.spawn,
    // rust: t.busy,
    // rust: t.ring,
    // rust: t.unreadable,
    // rust: t.files,
    // rust: t.emptied,
    // rust: t.skipped,
    // rust: format!("-{} of {}", mib(t.freed[0]), mib(t.before[0])),
    // rust: format!("-{}", mib(t.freed[1])),
    // rust: format!("-{}", mib(t.freed[2])),
    // rust: );
    // rust: for (a, b) in [
    // rust: (&mut total.chunks, t.chunks),
    // rust: (&mut total.pruned, t.pruned),
    // rust: (&mut total.emptied, t.emptied),
    // rust: (&mut total.skipped, t.skipped),
    // rust: ] {
    // rust: *a += b;
}
    // rust: for k in 0..3 {
    // rust: total.freed[k] += t.freed[k];
    // rust: total.before[k] += t.before[k];
}
}
    // rust: let freed: u64 = total.freed.iter().sum();
    // rust: let before: u64 = total.before.iter().sum();
    // rust: let summary = format!(
    // rust: "{verb} {} of {} chunks; {} MiB of {} MiB of region, entities and poi files freed, {} files emptied, {} left as they were, in {} s{}",
    // rust: total.pruned,
    // rust: total.chunks,
    // rust: mib(freed),
    // rust: mib(before),
    // rust: total.emptied,
    // rust: total.skipped,
    // rust: seconds,
    // rust: if errors.is_empty() {
    // rust: String::new()
    // rust: } else {
    // rust: format!(", {} errors", errors.len())
}
    // rust: );
    // rust: let _ = writeln!(text, "\n{summary}");
    // rust: let _ = writeln!(
    // rust: text,
    // rust: "listed/spawn/inhabited/ring: kept for that reason (first that applies); unread: kept, can't be read; \
    // rust: skipped: files left whole (a chunk in its own .mcc file, or a file that can't be read)."
    // rust: );
    // rust: for e in errors {
    // rust: let _ = writeln!(text, "ERROR {e}");
}
    // rust: Outcome {
    // rust: report: text,
    // rust: summary,
}
}

/// Writes the report to `logs/prune-chunks-<time>.txt`; returns its path.
pub fn write_report(dir: *Path, outcome: *Outcome) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let logs = dir.join("logs");
    // rust: fs::create_dir_all(&logs)?;
    // rust: let path = logs.join(format!(
    // rust: "prune-chunks-{}.txt",
    // rust: chrono::Utc::now().format("%Y-%m-%dT%H-%M-%SZ")
    // rust: ));
    // rust: fs::write(&path, &outcome.report)?;
    // rust: Ok(path)
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::position::ChunkPos;
//     use horizon_world::{compression::Compression, nbt::NamedTag};

pub fn temp(name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-prune-{name}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

    /// A chunk as vanilla saves it, with `filler` bytes of sections before or after InhabitedTime.
pub fn chunk(c: Chunk, ticks: ?i64, filler: usize, late: bool) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries: Vec<(&str, Tag)> = vec![
    // rust: ("DataVersion", Tag::Int(4700)),
    // rust: ("xPos", Tag::Int(c.0)),
    // rust: ("zPos", Tag::Int(c.1)),
    // rust: ("Status", Tag::String("minecraft:full".into())),
    // rust: ];
    // rust: let sections = (
    // rust: "sections",
    // rust: Tag::List(vec![Tag::compound([(
    // rust: "data",
                // Values that don't compress away, so a big chunk takes many sectors.
    // rust: Tag::LongArray(
    // rust: (0..filler as i64 / 8)
    // rust: .map(|i| {
    // rust: (i ^ i64::from(c.0)).wrapping_mul(0x9E37_79B9_7F4A_7C15_u64 as i64)
    // rust: })
    // rust: .collect(),
    // rust: ),
    // rust: )])]),
    // rust: );
    // rust: if late {
    // rust: entries.push(sections.clone());
}
    // rust: if let Some(t) = ticks {
    // rust: entries.push(("InhabitedTime", Tag::Long(t)));
}
    // rust: if !late {
    // rust: entries.push(sections);
}
    // rust: let root = NamedTag {
    // rust: name: Default::default(),
    // rust: tag: Tag::compound(entries),
}
    // rust: ChunkRecord::from_nbt(&root, Compression::Zlib, 1_700_000_000, Limits::saved()).unwrap()
}

pub fn write_region(path: *Path, chunks: *[(Chunk) void {
}
    // rust: let mut w = RegionWriter::create(path).unwrap();
    // rust: for (c, r) in chunks {
    // rust: w.write(ChunkPos::new(c.0, c.1), r).unwrap();
}
    // rust: w.finish().unwrap();
}

    /// The chunks a region file holds, read back by horizon-world's port of vanilla's RegionFile.
pub fn chunks_in(path: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut f = RegionFile::open(path).unwrap();
    // rust: let mut out: Vec<_> = f.chunks().map(|(c, _)| (c.x, c.z)).collect();
    // rust: out.sort();
    // rust: for c in &out {
    // rust: f.read(ChunkPos::new(c.0, c.1))
    // rust: .unwrap()
    // rust: .unwrap()
    // rust: .nbt(Limits::saved())
    // rust: .unwrap();
}
    // rust: out
}

pub fn settings(radius: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Settings {
    // rust: spawn_radius: radius,
    // rust: ..Settings::default()
}
}

pub fn reads_inhabited_time_wherever_it_is() void {
}
    // rust: assert_eq!(inhabited(&chunk((1, 2), Some(1234), 64, false)), Some(1234));
        // Past the decoded prefix: the whole chunk is decoded.
    // rust: assert_eq!(inhabited(&chunk((1, 2), Some(77), 200_000, true)), Some(77));
    // rust: assert_eq!(inhabited(&chunk((1, 2), None, 64, false)), None);
    // rust: let broken = ChunkRecord {
    // rust: compression: Compression::Zlib,
    // rust: compressed: vec![1, 2, 3],
    // rust: timestamp: 0,
}
    // rust: assert_eq!(inhabited(&broken), None);
}

    /// Overworld region r.2.0 (chunks 64..95, 0..31), far from the spawn at 0 0.
pub fn world(name: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = temp(name);
    // rust: let world = dir.join("world");
    // rust: let ow = world.join("dimensions/minecraft/overworld");
    // rust: let mut chunks = vec![
            // A build: kept, and its ring of 8 with it.
    // rust: ((70, 5), chunk((70, 5), Some(50_000), 64, false)),
    // rust: ((80, 5), chunk((80, 5), Some(0), 64, false)),
    // rust: ((85, 5), chunk((85, 5), Some(1199), 64, false)),
    // rust: ((90, 5), chunk((90, 5), Some(1200), 64, false)),
            // Two apart from the 1200 chunk: pruned, its neighbour (91) is ring.
    // rust: ((92, 5), chunk((92, 5), Some(3), 64, false)),
    // rust: ((91, 5), chunk((91, 5), Some(3), 64, false)),
            // A big chunk, after which compaction must still find every kept chunk.
    // rust: ((64, 25), chunk((64, 25), Some(0), 50_000, false)),
    // rust: ((65, 20), chunk((65, 20), Some(9_000), 64, false)),
    // rust: ];
    // rust: for dx in -1..=1 {
    // rust: for dz in -1..=1 {
    // rust: if (dx, dz) != (0, 0) {
    // rust: let c = (70 + dx, 5 + dz);
    // rust: chunks.push((c, chunk(c, Some(10), 64, false)));
}
}
}
    // rust: write_region(&ow.join("region/r.2.0.mca"), &chunks);
        // The spawn region: never visited, kept by the spawn radius.
    // rust: write_region(
    // rust: &ow.join("region/r.0.0.mca"),
    // rust: &[
    // rust: ((0, 0), chunk((0, 0), Some(0), 64, false)),
    // rust: ((3, 3), chunk((3, 3), Some(0), 64, false)),
    // rust: ],
    // rust: );
        // A region nobody stayed in: emptied, so deleted.
    // rust: write_region(
    // rust: &ow.join("region/r.5.5.mca"),
    // rust: &[((170, 170), chunk((170, 170), Some(5), 64, false))],
    // rust: );
        // The same chunks' entities and POI.
    // rust: let entities = |c: Chunk| chunk(c, Some(0), 16, false);
    // rust: write_region(
    // rust: &ow.join("entities/r.2.0.mca"),
    // rust: &[((70, 5), entities((70, 5))), ((80, 5), entities((80, 5)))],
    // rust: );
    // rust: write_region(&ow.join("poi/r.2.0.mca"), &[((85, 5), entities((85, 5)))]);
    // rust: write_region(
    // rust: &ow.join("entities/r.5.5.mca"),
    // rust: &[((170, 170), entities((170, 170)))],
    // rust: );
    // rust: (dir, ow)
}

pub fn prunes_barely_visited_chunks_and_keeps_the_rest_readable() void {
}
    // rust: let (dir, ow) = world("prune");
    // rust: let world = dir.join("world");
    // rust: let before = fs::read(ow.join("region/r.2.0.mca")).unwrap();

    // rust: let dry = run(&world, &settings(4), false, 2).unwrap();
    // rust: assert_eq!(
    // rust: fs::read(ow.join("region/r.2.0.mca")).unwrap(),
    // rust: before,
    // rust: "a dry run writes nothing"
    // rust: );
    // rust: assert!(ow.join("region/r.5.5.mca").is_file());
    // rust: assert!(
    // rust: dry.summary
    // rust: .contains("Would delete (dry run) 5 of 19 chunks"),
    // rust: "{}",
    // rust: dry.report
    // rust: );

    // rust: {
//             use std::os::unix::fs::PermissionsExt;
    // rust: fs::set_permissions(
    // rust: ow.join("region/r.2.0.mca"),
    // rust: fs::Permissions::from_mode(0o600),
    // rust: )
    // rust: .unwrap();
}
    // rust: let done = run(&world, &settings(4), true, 2).unwrap();
    // rust: assert!(
    // rust: done.summary.starts_with("Deleted 5 of 19 chunks"),
    // rust: "{}",
    // rust: done.report
    // rust: );
    // rust: let mut kept: Vec<Chunk> = vec![(65, 20), (90, 5), (91, 5)];
    // rust: for dx in -1..=1 {
    // rust: for dz in -1..=1 {
    // rust: kept.push((70 + dx, 5 + dz));
}
}
    // rust: kept.sort();
    // rust: assert_eq!(chunks_in(&ow.join("region/r.2.0.mca")), kept);
    // rust: assert_eq!(
    // rust: chunks_in(&ow.join("region/r.0.0.mca")),
    // rust: vec![(0, 0), (3, 3)]
    // rust: );
    // rust: assert!(
    // rust: !ow.join("region/r.5.5.mca").exists(),
    // rust: "an emptied region file is deleted"
    // rust: );
    // rust: assert!(!ow.join("entities/r.5.5.mca").exists());
    // rust: assert_eq!(chunks_in(&ow.join("entities/r.2.0.mca")), vec![(70, 5)]);
    // rust: assert!(!ow.join("poi/r.2.0.mca").exists());
    // rust: assert!(!ow.join("region").join(STAGING).exists());
    // rust: {
//             use std::os::unix::fs::PermissionsExt;
    // rust: let mode = fs::metadata(ow.join("region/r.2.0.mca"))
    // rust: .unwrap()
    // rust: .permissions()
    // rust: .mode();
    // rust: assert_eq!(
    // rust: mode & 0o777,
    // rust: 0o600,
    // rust: "a rewritten file keeps its permissions"
    // rust: );
}

        // Compacted: 2 header sectors plus one per kept chunk (each fits one), and the kept bytes as they were.
    // rust: let after = fs::read(ow.join("region/r.2.0.mca")).unwrap();
    // rust: assert_eq!(after.len() as u64, (2 + kept.len() as u64) * SECTOR);
    // rust: assert!(after.len() < before.len());
    // rust: let mut f = RegionFile::open(ow.join("region/r.2.0.mca")).unwrap();
    // rust: let r = f.read(ChunkPos::new(70, 5)).unwrap().unwrap();
    // rust: assert_eq!(inhabited(&r), Some(50_000));
    // rust: assert_eq!(r.timestamp, 1_700_000_000);

        // A second run finds nothing more to do.
    // rust: let again = run(&world, &settings(4), true, 2).unwrap();
    // rust: assert!(
    // rust: again.summary.starts_with("Deleted 0 of 14 chunks"),
    // rust: "{}",
    // rust: again.report
    // rust: );
    // rust: let _ = fs::remove_dir_all(dir);
}

pub fn claims_homes_and_the_spawn_radius_keep_chunks() void {
}
    // rust: let (dir, ow) = world("claims");
    // rust: let world = dir.join("world");
    // rust: fs::create_dir_all(world.join("horizon-smp")).unwrap();
    // rust: fs::write(
    // rust: world.join("horizon-smp/claims.json"),
    // rust: r#"{"chunks": {"minecraft:overworld 80 5": "8a0c0b8e-0000-0000-0000-000000000001",
    // rust: "minecraft:the_nether 85 5": "8a0c0b8e-0000-0000-0000-000000000001"}, "trust": {}}"#,
    // rust: )
    // rust: .unwrap();
        // A home at x 2720.5, z 2730: chunk 170 170.
    // rust: fs::write(
    // rust: world.join("horizon-smp/places.json"),
    // rust: r#"{"homes": {"p": {"base": {"dimension": "minecraft:overworld", "x": 2720.5, "y": 70.0, "z": 2730.0}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let mut s = settings(4);
    // rust: run(&world, &s, true, 1).unwrap();
    // rust: let left = chunks_in(&ow.join("region/r.2.0.mca"));
    // rust: assert!(left.contains(&(80, 5)), "a claimed chunk stays");
    // rust: assert!(
    // rust: !left.contains(&(85, 5)),
    // rust: "a claim in another dimension keeps nothing here"
    // rust: );
    // rust: assert!(
    // rust: ow.join("region/r.5.5.mca").is_file(),
    // rust: "a home's chunk stays"
    // rust: );
    // rust: assert_eq!(
    // rust: chunks_in(&ow.join("entities/r.2.0.mca")),
    // rust: vec![(70, 5), (80, 5)]
    // rust: );

        // The spawn radius reaches region r.2.0 (64 chunks out): everything there stays.
    // rust: s.spawn_radius = 100;
    // rust: let all = run(&world, &s, false, 1).unwrap();
    // rust: assert!(all.summary.contains(" 0 of "), "{}", all.report);

        // A claims file that can't be read stops the prune before anything goes.
    // rust: fs::write(world.join("horizon-smp/claims.json"), "{not json").unwrap();
    // rust: assert!(run(&world, &settings(4), true, 1).is_err());
    // rust: let _ = fs::remove_dir_all(dir);
}

pub fn server_toml_turns_it_on_and_the_supervisor_turns_it_off() void {
}
    // rust: let dir = temp("toml");
    // rust: let text = format!(
    // rust: "{}\n[prune_chunks]\nmode = \"delete\"\nring = 2\n",
    // rust: crate::config::TEMPLATE
    // rust: );
    // rust: fs::write(dir.join("server.toml"), text).unwrap();
    // rust: let config = crate::config::Config::load(&dir).unwrap();
    // rust: assert_eq!(
    // rust: (config.prune_chunks.mode, config.prune_chunks.ring),
    // rust: (Mode::Delete, 2)
    // rust: );
    // rust: crate::config::update(
    // rust: &dir,
    // rust: "prune_chunks",
    // rust: "mode",
    // rust: toml::Value::String("off".into()),
    // rust: )
    // rust: .unwrap();
    // rust: let config = crate::config::Config::load(&dir).unwrap();
    // rust: assert_eq!(
    // rust: (config.prune_chunks.mode, config.prune_chunks.ring),
    // rust: (Mode::Off, 2)
    // rust: );
    // rust: assert!(
    // rust: fs::read_to_string(dir.join("server.toml"))
    // rust: .unwrap()
    // rust: .contains("[discord]")
    // rust: );
    // rust: fs::write(
    // rust: dir.join("server.toml"),
    // rust: "[prune_chunks]\nkeep_files = [\"../ops.json\"]\n",
    // rust: )
    // rust: .unwrap();
    // rust: assert!(
    // rust: crate::config::Config::load(&dir).is_err(),
    // rust: "keep_files stay inside the world"
    // rust: );
    // rust: let _ = fs::remove_dir_all(dir);
}

pub fn spawn_comes_from_level_dat() void {
}
    // rust: let dir = temp("spawn");
    // rust: let root = NamedTag {
    // rust: name: Default::default(),
    // rust: tag: Tag::compound([(
    // rust: "Data",
    // rust: Tag::compound([(
    // rust: "spawn",
    // rust: Tag::compound([("pos", Tag::IntArray(vec![1300, 64, -40]))]),
    // rust: )]),
    // rust: )]),
}
    // rust: let bytes = nbt::write_named(&root, Limits::saved()).unwrap();
    // rust: fs::write(
    // rust: dir.join("level.dat"),
    // rust: Compression::Gzip.encode(&bytes).unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(spawn_chunk(&dir), (81, -3));
    // rust: assert_eq!(spawn_chunk(&dir.join("missing")), (0, 0));
    // rust: let _ = fs::remove_dir_all(dir);
}
}
