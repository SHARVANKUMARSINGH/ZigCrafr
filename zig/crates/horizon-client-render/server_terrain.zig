//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_server_terrain
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Far terrain on servers: every chunk a server sends is kept as its
//! far-terrain summary (`lod::Column`s), on disk per server, world and
//! dimension, and drawn beyond the server's view distance on this visit and
//! the next ones. A server never sends its seed, so its
//! distant terrain can't be generated as a local world's is.
//!
//! The summaries live in Anvil region files (`r.X.Z.mca`, one NBT record a
//! chunk), under `server-terrain/<server>/<hashed seed>/<namespace>/<level>/`.
//! A chunk it doesn't have may be in the player's Bobby cache of the same
//! level (`Bobby`), only ever read; past both, the server's BlueMap may fill
//! in (`bluemap`).
// use crate::{
    // rust: blocks::BlockFacts,
    // rust: bluemap::{BlueMap, Found},
    // rust: chunk::Chunk,
    // rust: fast_hash::FxHashMap,
    // rust: lod::{Column, Span, Spans, Surface, state_kinds, summarize},
    // rust: streaming::{LodDetail, LodSampler, LodSource},
}
// use horizon_core::position::ChunkPos;
// use horizon_world::{
    // rust: DATA_VERSION,
    // rust: compression::Compression,
    // rust: nbt::{Limits, NamedTag, Tag},
    // rust: region::{ChunkRecord, RegionFile},
    // rust: registry::BlockStateId,
}
// use std::{
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Mutex},
}

/// Bumped when the summary layout changes; older records are ignored.
pub const FORMAT: i32 = 1;
/// Decoded chunks kept in memory, and open region files.
pub const MAX_CHUNKS: usize = 8192;
pub const MAX_REGIONS: usize = 64;
/// The widest cell, in chunks, drawn from the chunks kept under it
/// (`Sampler::reduced_column`): its regions all stay open.
pub const MAX_KEPT_SIDE: i32 = 128;

    // rust: type Columns = Arc<[Column; 256]>;

/// The folder of a server's terrain: its address as typed, lowercased, with
/// the default port left out, and every character a file name can't hold
/// replaced (`play.example.net:25566` → `play.example.net_25566`).
pub fn server_folder(address: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let address = address.trim().to_ascii_lowercase();
    // rust: let address = address.strip_suffix(":25565").unwrap_or(&address);
    // rust: let name: String = address
    // rust: .chars()
    // rust: .map(|c| {
    // rust: if c.is_ascii_alphanumeric() || c == '.' || c == '-' {
    // rust: c
    // rust: } else {
    // rust: '_'
}
    // rust: })
    // rust: .collect();
    // rust: let name = name.trim_matches('.');
    // rust: if name.is_empty() {
    // rust: "_".into()
    // rust: } else {
    // rust: name.into()
}
}

/// `root/<server>/<seed>/<namespace>/<path>` for a level key
/// (`minecraft:overworld`) and the login's hashed seed, which keeps
/// the worlds behind one address (a proxy's servers, a reset) apart.
pub fn level_dir(root: *Path, address: []const u8, hashed_seed: i64, level: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: root.join(server_folder(address))
    // rust: .join(hashed_seed.to_string())
    // rust: .join(level_path(level))
}

/// The official launcher's game folder (`HORIZON_MINECRAFT_DIR` if set),
/// where Bobby keeps its cache (`.bobby`): as
/// `horizon_prepare::artifacts::minecraft_dir` finds it, which this crate
/// can't depend on.
pub fn minecraft_dir() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let home = || {
    // rust: let var = if cfg!(windows) { "USERPROFILE" } else { "HOME" };
    // rust: std::env::var_os(var).map_or_else(|| PathBuf::from("."), PathBuf::from)
}
    // rust: if let Some(dir) = std::env::var_os("HORIZON_MINECRAFT_DIR").filter(|d| !d.is_empty()) {
    // rust: let dir = PathBuf::from(dir);
    // rust: if let Ok(rest) = dir.strip_prefix("~") {
    // rust: return home().join(rest);
}
    // rust: return dir;
}
    // rust: if cfg!(target_os = "macos") {
    // rust: home().join("Library/Application Support/minecraft")
    // rust: } else if cfg!(windows) {
    // rust: std::env::var_os("APPDATA")
    // rust: .map_or_else(home, PathBuf::from)
    // rust: .join(".minecraft")
    // rust: } else {
    // rust: home().join(".minecraft")
}
}

/// Bobby's folder of a level under `root` (`.bobby`), as Bobby leaves it on
/// disk: `<address as typed, ':' as '_'>/<hashed seed>/<namespace>/<path>`.
/// Names are compared without case, and `host` and `host_25565` both stand
/// for the default port: neither was seen, so both are taken.
    // rust: pub fn bobby_level_dir(
    // rust: root: &Path,
    // rust: address: &str,
    // rust: hashed_seed: i64,
    // rust: level: &str,
    // rust: ) -> Option<PathBuf> {
    // rust: let typed = address.trim().replace(':', "_");
    // rust: let bare = typed.strip_suffix("_25565").unwrap_or(&typed);
    // rust: if bare.is_empty() {
    // rust: return None;
}
    // rust: let names = [bare.to_owned(), format!("{bare}_25565")];
    // rust: let mut servers: Vec<PathBuf> = std::fs::read_dir(root)
    // rust: .ok()?
    // rust: .flatten()
    // rust: .filter(|entry| {
    // rust: entry
    // rust: .file_name()
    // rust: .to_str()
    // rust: .is_some_and(|name| names.iter().any(|n| n.eq_ignore_ascii_case(name)))
    // rust: })
    // rust: .map(|entry| entry.path())
    // rust: .collect();
    // rust: servers.sort();
    // rust: servers
    // rust: .into_iter()
    // rust: .map(|server| server.join(hashed_seed.to_string()).join(level_path(level)))
    // rust: .find(|dir| dir.is_dir())
}

/// `<namespace>/<path>` of a level key.
pub fn level_path(level: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (namespace, path) = level.split_once(':').unwrap_or(("minecraft", level));
    // rust: let clean = |s: &str| -> String {
    // rust: s.chars()
    // rust: .map(|c| {
    // rust: if c.is_ascii_alphanumeric() || matches!(c, '_' | '-' | '.') {
    // rust: c
    // rust: } else {
    // rust: '_'
}
    // rust: })
    // rust: .collect::<String>()
    // rust: .trim_matches('.')
    // rust: .to_owned()
}
    // rust: let mut dir = PathBuf::from(clean(namespace));
    // rust: for part in path.split('/').map(clean).filter(|p| !p.is_empty()) {
    // rust: dir.push(part);
}
    // rust: dir
}

pub const Region = struct {
    file: RegionFile,
    present: [bool,
};

/// Open region files by region; `None`: the file doesn't exist.
    // rust: type Regions = FxHashMap<(i32, i32), Option<Region>>;

pub const State = struct {
    regions: Regions,
    /// Bobby's, opened read-only.
    bobby: Regions,
    /// `None`: the chunk isn't stored.
    chunks: FxHashMap<(i32,
};

/// A saved full chunk with its stored light, or `None` (`save::decode_lit`
/// in the game).
    // rust: pub type DecodeChunk = Box<dyn Fn(&NamedTag) -> Option<Chunk> + Send + Sync>;

/// The chunks the player's Bobby kept of the same level: vanilla chunk NBT
/// in region files, as Bobby leaves them on disk. Only ever read; a chunk
/// far terrain needs from there is kept in the level's own folder.
pub const Bobby = struct {
    dir: PathBuf,
    decode: DecodeChunk,
    /// `lod::state_kinds`, to summarize its chunks as loaded ones are.
    kinds: std.ArrayList(u8),
};

    // rust: impl Bobby {
pub fn new(dir: PathBuf, decode: DecodeChunk, facts: *BlockFacts) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: dir,
    // rust: decode,
    // rust: kinds: state_kinds(facts),
}
}
}

/// One level's stored terrain, shared by the far-terrain threads. A chunk
/// it doesn't have comes from Bobby's cache, else the server's BlueMap, if
/// the player named it or Find BlueMap found it.
pub const ServerTerrain = struct {
    dir: PathBuf,
    blue_map: ?*BlueMap,
    bobby: ?Bobby,
    state: Mutex<State>,
    warned: std::sync::atomic::AtomicBool,
};

    // rust: impl ServerTerrain {
pub fn new(dir: PathBuf, blue_map: ?*BlueMap) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with_bobby(dir, blue_map, None)
}

    // rust: pub fn with_bobby(
    // rust: dir: PathBuf,
    // rust: blue_map: Option<Arc<BlueMap>>,
    // rust: bobby: Option<Bobby>,
    // rust: ) -> Arc<Self> {
    // rust: Arc::new(Self {
    // rust: dir,
    // rust: blue_map,
    // rust: bobby,
    // rust: state: Mutex::default(),
    // rust: warned: Default::default(),
    // rust: })
}

    /// BlueMap's coarser levels at block (x, z) (a void there is `Ready`).
pub fn coarser(self: *Self, x: i32, z: i32) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blue_map
    // rust: .as_ref()
    // rust: .map_or(Found::Absent, |map| map.coarser_column(x, z))
}

    /// A chunk's columns: stored, else BlueMap's (`Waiting`: on its way).
pub fn chunk_or_map(self: *Self, x: i32, z: i32) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(columns) = self.chunk(x, z) {
    // rust: return Found::Ready(columns);
}
    // rust: self.blue_map
    // rust: .as_ref()
    // rust: .map_or(Found::Absent, |map| map.chunk(x, z))
}

    /// The stored chunk nearest the middle of the `side` × `side` chunks
    /// from `(x, z)`, found in the region headers without reading any.
pub fn nearest(self: *Self, x: i32, z: i32, side: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.kept(x, z, side).1
}

    /// How many of the `side` × `side` chunks from `(x, z)` are stored here
    /// or in Bobby's cache, and the one nearest their middle (`nearest`).
pub fn kept(self: *Self, x: i32, z: i32, side: i32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut state = self.state.lock().unwrap();
    // rust: let middle = (x * 2 + side, z * 2 + side);
    // rust: let mut count = 0;
    // rust: let mut best: Option<(i64, (i32, i32))> = None;
    // rust: for rz in z >> 5..=(z + side - 1) >> 5 {
    // rust: for rx in x >> 5..=(x + side - 1) >> 5 {
    // rust: let mut present = region(&mut state.regions, &self.dir, (rx, rz))
    // rust: .map_or([false; 1024], |r| r.present);
    // rust: if let Some(bobby) = &self.bobby
    // rust: && let Some(theirs) = read_only(&mut state.bobby, &bobby.dir, (rx, rz))
    // rust: {
    // rust: for (here, there) in present.iter_mut().zip(theirs.present) {
    // rust: *here |= there;
}
}
    // rust: for (i, _) in present.iter().enumerate().filter(|(_, p)| **p) {
    // rust: let (cx, cz) = (rx * 32 + (i % 32) as i32, rz * 32 + (i / 32) as i32);
    // rust: if cx < x || cz < z || cx >= x + side || cz >= z + side {
    // rust: continue;
}
    // rust: count += 1;
    // rust: let (dx, dz) = (
    // rust: i64::from(cx * 2 + 1 - middle.0),
    // rust: i64::from(cz * 2 + 1 - middle.1),
    // rust: );
    // rust: let distance = dx * dx + dz * dz;
    // rust: if best.is_none_or(|(d, _)| distance < d) {
    // rust: best = Some((distance, (cx, cz)));
}
}
}
}
    // rust: (count, best.map(|(_, chunk)| chunk))
}

    /// A stored chunk's columns, else Bobby's (kept here from then on).
pub fn chunk(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(known) = self.state.lock().unwrap().chunks.get(&(x, z)) {
    // rust: return known.clone();
}
    // rust: let columns = self.stored(x, z).or_else(|| self.bobby_chunk(x, z));
    // rust: let mut state = self.state.lock().unwrap();
        // Stored by another thread meanwhile (`write`): that, newer than
        // what was read here.
    // rust: if let Some(Some(stored)) = state.chunks.get(&(x, z)) {
    // rust: return Some(stored.clone());
}
    // rust: remember(&mut state, (x, z), columns.clone());
    // rust: columns
}

    /// The chunk's record in the level's own folder; one of another game
    /// version or layout is none.
pub fn stored(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let record = {
    // rust: let mut state = self.state.lock().unwrap();
    // rust: read(
    // rust: region(&mut state.regions, &self.dir, (x >> 5, z >> 5)),
    // rust: x,
    // rust: z,
    // rust: )
    // rust: }?;
    // rust: record
    // rust: .nbt(Limits::default())
    // rust: .ok()
    // rust: .and_then(|root| decode(&root.tag))
}

    /// A chunk in Bobby's cache, summarized and kept here. One of another
    /// game version, or that doesn't decode, is none.
pub fn bobby_chunk(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bobby = self.bobby.as_ref()?;
    // rust: let (record, kept) = {
    // rust: let mut state = self.state.lock().unwrap();
    // rust: let key = (x >> 5, z >> 5);
    // rust: let kept =
    // rust: region(&mut state.regions, &self.dir, key).is_some_and(|r| r.present[slot(x, z)]);
    // rust: (
    // rust: read(read_only(&mut state.bobby, &bobby.dir, key), x, z),
    // rust: kept,
    // rust: )
}
    // rust: let record = record?;
    // rust: let root = record.nbt(Limits::default()).ok()?;
    // rust: if root.tag.get("DataVersion") != Some(&Tag::Int(DATA_VERSION)) {
    // rust: return None;
}
    // rust: let chunk = (bobby.decode)(&root).filter(|chunk| (chunk.x, chunk.z) == (x, z))?;
    // rust: let columns = summarize(&chunk, &bobby.kinds);
        // Not over a chunk the server sent while this one was decoded.
    // rust: if let Err(e) = self.write((x, z), &columns, Some(kept)) {
    // rust: self.warn_once(&e);
}
    // rust: Some(columns)
}

    /// A chunk couldn't be kept (disk full, a folder it can't write): said
    /// once a level, not for every chunk after.
pub fn warn_once(self: *Self, error: *std::io::Error) void {
}
    // rust: if !self.warned.swap(true, std::sync::atomic::Ordering::Relaxed) {
    // rust: log::warn!("Horizon: far terrain can't keep the server's chunks: {error}");
}
}

    /// Keep a chunk's columns, unless they are what is stored already.
pub fn store(self: *Self, key: (i32) void {
}
    // rust: let known = self.state.lock().unwrap().chunks.get(&key).cloned();
    // rust: let old = known.unwrap_or_else(|| {
    // rust: let old = self.stored(key.0, key.1);
    // rust: let mut state = self.state.lock().unwrap();
    // rust: if !state.chunks.contains_key(&key) {
    // rust: remember(&mut state, key, old.clone());
}
    // rust: old
    // rust: });
    // rust: if old.is_some_and(|old| *old == **columns) {
    // rust: return Ok(());
}
    // rust: self.write(key, columns, None)
}

    /// `kept`: whether the chunk's record was in the folder before; the
    /// columns aren't written over one another thread kept meanwhile.
    // rust: fn write(
    // rust: &self,
    // rust: (x, z): (i32, i32),
    // rust: columns: &Columns,
    // rust: kept: Option<bool>,
    // rust: ) -> std::io::Result<()> {
    // rust: let root = NamedTag {
    // rust: name: "".into(),
    // rust: tag: encode(x, z, columns),
}
    // rust: let record = ChunkRecord::from_nbt(&root, Compression::Zlib, now(), Limits::default())?;
    // rust: let mut state = self.state.lock().unwrap();
    // rust: let key = (x >> 5, z >> 5);
    // rust: if let Some(kept) = kept
    // rust: && (matches!(state.chunks.get(&(x, z)), Some(Some(_)))
    // rust: || (!kept
    // rust: && region(&mut state.regions, &self.dir, key)
    // rust: .is_some_and(|r| r.present[slot(x, z)])))
    // rust: {
    // rust: return Ok(());
}
    // rust: if region(&mut state.regions, &self.dir, key).is_none() {
    // rust: std::fs::create_dir_all(&self.dir)?;
    // rust: let file = RegionFile::open_writable(region_path(&self.dir, key), true)?;
    // rust: state.regions.insert(key, Some(Region::new(file)));
}
    // rust: let region = region(&mut state.regions, &self.dir, key).expect("region just opened");
    // rust: region.file.write(ChunkPos::new(x, z), &record)?;
    // rust: region.present[slot(x, z)] = true;
    // rust: remember(&mut state, (x, z), Some(columns.clone()));
    // rust: Ok(())
}
}

pub fn region_path(dir: *Path) void {
}
    // rust: dir.join(format!("r.{rx}.{rz}.mca"))
}

/// A region of `dir`, opened on first use.
    // rust: fn region<'a>(regions: &'a mut Regions, dir: &Path, key: (i32, i32)) -> Option<&'a mut Region> {
    // rust: open(regions, key, || {
    // rust: RegionFile::open_writable(region_path(dir, key), false)
    // rust: })
}

/// A region of Bobby's `dir`, opened for reading only.
    // rust: fn read_only<'a>(regions: &'a mut Regions, dir: &Path, key: (i32, i32)) -> Option<&'a mut Region> {
    // rust: open(regions, key, || RegionFile::open(region_path(dir, key)))
}

    // rust: fn open(
    // rust: regions: &mut Regions,
    // rust: key: (i32, i32),
    // rust: file: impl FnOnce() -> std::io::Result<RegionFile>,
    // rust: ) -> Option<&mut Region> {
    // rust: if !regions.contains_key(&key) {
    // rust: if regions.len() >= MAX_REGIONS {
    // rust: regions.clear();
}
    // rust: regions.insert(key, file().ok().map(Region::new));
}
    // rust: regions.get_mut(&key)?.as_mut()
}

pub fn read(region: ?*mut Region, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let region = region.filter(|r| r.present[slot(x, z)])?;
    // rust: region.file.read(ChunkPos::new(x, z)).ok().flatten()
}

    // rust: impl Region {
pub fn new(file: RegionFile) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut present = [false; 1024];
    // rust: for (pos, _) in file.chunks() {
    // rust: present[slot(pos.x, pos.z)] = true;
}
    // rust: Self { file, present }
}
}

pub fn slot(x: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (x & 31) as usize + (z & 31) as usize * 32
}

pub fn remember(state: *mut State, key: (i32) void {
}
    // rust: if state.chunks.len() >= MAX_CHUNKS {
    // rust: state.chunks.clear();
}
    // rust: state.chunks.insert(key, columns);
}

pub fn now() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs() as u32)
}

/// The columns as one int array: per column a surface (`0`, or `1`, height,
/// state, water flag, water height, water state, biome), the span count, and
/// three ints a span (min and max, state, biome and light).
pub fn encode(x: i32, z: i32, columns: *[Column; 256]) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut ints = Vec::with_capacity(256 * 8);
    // rust: for column in columns {
    // rust: match column.surface {
    // rust: None => ints.push(0),
    // rust: Some(s) => {
    // rust: let (water, water_height, water_state) = s
    // rust: .water
    // rust: .map_or((0, 0, 0), |(h, state)| (1, h, state.0 as i32));
    // rust: ints.extend([
    // rust: 1,
    // rust: s.height,
    // rust: s.state.0 as i32,
    // rust: water,
    // rust: water_height,
    // rust: water_state,
    // rust: i32::from(s.biome),
    // rust: ]);
}
}
    // rust: ints.push(column.spans.len() as i32);
    // rust: for span in &column.spans {
    // rust: ints.extend([
    // rust: i32::from(span.min as u16) << 16 | i32::from(span.max as u16),
    // rust: span.state.0 as i32,
    // rust: i32::from(span.biome) << 16 | i32::from(span.light),
    // rust: ]);
}
}
    // rust: Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: ("HorizonFarTerrain", Tag::Int(FORMAT)),
    // rust: ("xPos", Tag::Int(x)),
    // rust: ("zPos", Tag::Int(z)),
    // rust: ("columns", Tag::IntArray(ints)),
    // rust: ])
}

/// `encode`'s columns, or `None` for a record of another game version or
/// layout (their block states and biomes are numbered differently).
pub fn decode(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if tag.get("DataVersion") != Some(&Tag::Int(DATA_VERSION))
    // rust: || tag.get("HorizonFarTerrain") != Some(&Tag::Int(FORMAT))
    // rust: {
    // rust: return None;
}
    // rust: let Some(Tag::IntArray(ints)) = tag.get("columns") else {
    // rust: return None;
}
    // rust: let mut ints = ints.iter().copied();
    // rust: let mut next = || ints.next();
    // rust: let mut columns: [Column; 256] = std::array::from_fn(|_| Column::default());
    // rust: for column in &mut columns {
    // rust: column.surface = match next()? {
    // rust: 0 => None,
    // rust: 1 => {
    // rust: let height = next()?;
    // rust: let state = BlockStateId(next()? as u32);
    // rust: let water = next()?;
    // rust: let water_height = next()?;
    // rust: let water_state = BlockStateId(next()? as u32);
    // rust: let biome = next()? as u16;
    // rust: Some(Surface {
    // rust: height,
    // rust: state,
    // rust: water: (water != 0).then_some((water_height, water_state)),
    // rust: biome,
    // rust: })
}
    // rust: _ => return None,
}
    // rust: let count = usize::try_from(next()?).ok().filter(|&n| n <= 4096)?;
    // rust: column.spans = Spans::with_capacity(count);
    // rust: for _ in 0..count {
    // rust: let range = next()?;
    // rust: let state = BlockStateId(next()? as u32);
    // rust: let material = next()?;
    // rust: column.spans.push(Span {
    // rust: min: (range >> 16) as i16,
    // rust: max: range as i16,
    // rust: state,
    // rust: biome: (material >> 16) as u16,
    // rust: light: material as u16,
    // rust: });
}
}
    // rust: next().is_none().then(|| Arc::new(columns))
}

    // rust: impl LodSource for ServerTerrain {
pub fn sampler(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Box::new(Sampler {
    // rust: terrain: self,
    // rust: details: Vec::new(),
    // rust: waited: false,
    // rust: })
}
pub fn keeps_observed(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
}

    // rust: impl Sampler {
    /// For a column whose chunk of the map is on its way: its coarser
    /// levels' meanwhile, as they come first (a void there is drawn as
    /// one). None there either is a hole (`waited`: the sample isn't drawn);
    /// either way the column is sampled again when its tile arrives
    /// (`Lod::refresh`).
pub fn coarser(self: *Self, x: i32, z: i32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.terrain.coarser(x, z) {
    // rust: Found::Ready(column) => column,
    // rust: Found::Waiting | Found::Absent => {
    // rust: self.waited = true;
    // rust: Column::default()
}
}
}
}

pub const Sampler = struct {
    terrain: *ServerTerrain,
    details: std.ArrayList(LodDetail),
    /// A column was left empty for BlueMap's on its way, with no coarser
    /// level to stand in (`waited`).
    waited: bool,
};

    // rust: impl LodSampler for Sampler {
pub fn fork(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(Box::new(Self {
    // rust: terrain: self.terrain.clone(),
    // rust: details: Vec::new(),
    // rust: waited: false,
    // rust: }))
}
    /// Stored chunks come back whole, else BlueMap's (its coarser levels'
    /// where the finest is out of reach); the others are known empty. One
    /// whose BlueMap tile is still downloading is asked again later.
pub fn request_detail(self: *Self, chunks: *[(i32) void {
}
    // rust: for &(x, z) in chunks {
    // rust: let columns = match self.terrain.chunk_or_map(x, z) {
    // rust: Found::Ready(columns) => columns,
    // rust: Found::Waiting => continue,
    // rust: Found::Absent => Arc::new(std::array::from_fn(|_| Column::default())),
}
    // rust: self.details.push(((x, z), columns));
}
}
pub fn drain_details(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.details)
}
pub fn observed(self: *Self, key: (i32) void {
}
    // rust: if let Err(e) = self.terrain.store(key, columns) {
    // rust: self.terrain.warn_once(&e);
}
}
pub fn sample(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.column(x, z).surface
}
pub fn column(self: *Self, x: i32, z: i32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.terrain.chunk_or_map(x >> 4, z >> 4) {
    // rust: Found::Ready(c) => c[((z & 15) * 16 + (x & 15)) as usize].clone(),
    // rust: Found::Waiting => self.coarser(x, z),
    // rust: Found::Absent => Column::default(),
}
}
pub fn waited(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.waited)
}
    /// A cell of `width` blocks from one stored chunk: its own area up to a
    /// chunk, else the stored chunk nearest the cell's middle (the server
    /// sent only the chunks a player came near), when most of the cell is
    /// stored. With a BlueMap, a wider
    /// cell takes the chunk at its middle if stored, else the map's pixel
    /// there, and the nearest stored chunk only while the map has none.
pub fn reduced_column(self: *Self, x: i32, z: i32, width: i32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if width <= 16 {
    // rust: let chunk = match self.terrain.chunk_or_map(x >> 4, z >> 4) {
    // rust: Found::Ready(chunk) => chunk,
    // rust: Found::Waiting => return self.coarser(x, z),
    // rust: Found::Absent => return Column::default(),
}
    // rust: let width = width.max(1) as usize;
    // rust: let lx = (x & 15) as usize & !(width - 1);
    // rust: let lz = (z & 15) as usize & !(width - 1);
    // rust: return Column::reduced(&chunk, lx, lz, width);
}
    // rust: let mut waiting = false;
    // rust: if let Some(map) = &self.terrain.blue_map {
    // rust: let (mx, mz) = ((x + width / 2) >> 4, (z + width / 2) >> 4);
    // rust: if let Some(chunk) = self.terrain.chunk(mx, mz) {
    // rust: return Column::reduced(&chunk, 0, 0, 16);
}
    // rust: match map.reduced_column(x, z, width) {
    // rust: Found::Ready(column) => return column,
    // rust: Found::Waiting => waiting = true,
    // rust: Found::Absent => {}
}
}
        // Only over a cell the server sent most of, as `Column::reduced`
        // keeps what fills half a cell: one chunk drawn as a whole cell stood
        // as a flat slab far wider than anything seen there, until finer
        // tiles replaced it with the nothing they know of.
    // rust: let side = width >> 4;
        // Wider cells are never mostly sent, and counting them would open
        // thousands of region files.
    // rust: if side > MAX_KEPT_SIDE {
    // rust: self.waited |= waiting;
    // rust: return Column::default();
}
    // rust: let (count, nearest) = self.terrain.kept(x >> 4, z >> 4, side);
    // rust: let column = (count * 2 >= (side * side) as usize)
    // rust: .then(|| nearest.and_then(|(cx, cz)| self.terrain.chunk(cx, cz)))
    // rust: .flatten()
    // rust: .map(|chunk| Column::reduced(&chunk, 0, 0, 16));
    // rust: self.waited |= waiting && column.is_none();
    // rust: column.unwrap_or_default()
}
}

    // rust: mod tests {
//     use super::*;

pub fn columns() C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Arc::new(std::array::from_fn(|i| {
    // rust: if i % 3 == 0 {
    // rust: return Column::default();
}
    // rust: Column {
    // rust: surface: Some(Surface {
    // rust: height: 63 + i as i32 % 7,
    // rust: state: BlockStateId(9 + i as u32),
    // rust: water: (i % 2 == 0).then_some((62, BlockStateId(86))),
    // rust: biome: (i % 5) as u16,
    // rust: }),
    // rust: spans: vec![
    // rust: Span {
    // rust: min: -64,
    // rust: max: 40,
    // rust: state: BlockStateId(1),
    // rust: biome: 3,
    // rust: light: 0,
    // rust: },
    // rust: Span {
    // rust: min: 40,
    // rust: max: 63 + i as i16 % 7,
    // rust: state: BlockStateId(9),
    // rust: biome: 7,
    // rust: light: 0xF0,
    // rust: },
    // rust: ]
    // rust: .into(),
}
    // rust: }))
}

pub fn columns_survive_their_encoding() void {
}
    // rust: let columns = columns();
    // rust: assert_eq!(decode(&encode(3, -4, &columns)), Some(columns));
}

pub fn records_of_another_version_are_ignored() void {
}
    // rust: let mut tag = encode(0, 0, &columns());
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.insert("DataVersion".into(), Tag::Int(DATA_VERSION - 1));
}
    // rust: assert_eq!(decode(&tag), None);
}

pub fn server_folders_are_plain_names() void {
}
    // rust: assert_eq!(server_folder("Play.Example.net"), "play.example.net");
    // rust: assert_eq!(server_folder("play.example.net:25565"), "play.example.net");
    // rust: assert_eq!(
    // rust: server_folder("play.example.net:25566"),
    // rust: "play.example.net_25566"
    // rust: );
    // rust: assert_eq!(server_folder("[::1]:25570"), "___1__25570");
    // rust: assert_eq!(server_folder("../.."), "_");
    // rust: assert_eq!(
    // rust: level_dir(Path::new("/c"), "a", -7, "minecraft:the_nether"),
    // rust: Path::new("/c/a/-7/minecraft/the_nether")
    // rust: );
    // rust: assert_eq!(
    // rust: level_dir(Path::new("/c"), "a", 0, "mod:../../x"),
    // rust: Path::new("/c/a/0/mod/x")
    // rust: );
}

pub fn scratch(name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: dir
}

pub fn stored_chunks_come_back_after_a_restart() void {
}
    // rust: let dir = scratch("server-terrain");
    // rust: let columns = columns();
    // rust: {
    // rust: let terrain = ServerTerrain::new(dir.clone(), None);
    // rust: assert_eq!(terrain.chunk(-33, 5), None);
    // rust: terrain.store((-33, 5), &columns).unwrap();
}
    // rust: let terrain = ServerTerrain::new(dir.clone(), None);
    // rust: assert_eq!(terrain.chunk(-33, 5), Some(columns.clone()));
    // rust: assert_eq!(terrain.nearest(-64, 0, 64), Some((-33, 5)));
    // rust: assert_eq!(terrain.nearest(-32, 0, 64), None);
    // rust: let mut sampler = terrain.clone().sampler();
    // rust: assert_eq!(sampler.sample(-33 * 16 + 1, 5 * 16), columns[1].surface);
    // rust: assert_eq!(sampler.column(0, 0), Column::default());
        // One chunk doesn't stand for a far cell of 64 × 64.
    // rust: assert_eq!(sampler.reduced_column(-64 * 16, 0, 1024), Column::default());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn wide_cells_are_drawn_where_most_of_them_was_kept() void {
}
    // rust: let dir = scratch("server-terrain-wide");
    // rust: let columns = columns();
    // rust: let terrain = ServerTerrain::new(dir.clone(), None);
    // rust: let mut sampler = terrain.clone().sampler();
        // A cell of 4 × 4 chunks, and a chunk of it kept.
    // rust: terrain.store((2, 1), &columns).unwrap();
    // rust: assert_eq!(sampler.reduced_column(0, 0, 64), Column::default());
    // rust: for (x, z) in [(0, 0), (1, 0), (2, 0), (3, 0), (0, 1), (1, 1)] {
    // rust: terrain.store((x, z), &columns).unwrap();
    // rust: assert_eq!(sampler.reduced_column(0, 0, 64), Column::default());
}
        // Half of it: drawn from the kept chunk nearest its middle.
    // rust: terrain.store((2, 2), &columns).unwrap();
    // rust: assert_eq!(
    // rust: sampler.reduced_column(0, 0, 64),
    // rust: Column::reduced(&columns, 0, 0, 16)
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

    /// Far terrain samples a cell before the server sent its chunk, then
    /// again once it is kept: nothing remembers the empty sample.
pub fn a_chunk_kept_after_an_empty_sample_is_sampled_next_time() void {
}
    // rust: let dir = scratch("server-terrain-late");
    // rust: let columns = columns();
    // rust: let terrain = ServerTerrain::new(dir.clone(), None);
    // rust: let mut sampler = terrain.clone().sampler();
    // rust: let mut other = sampler.fork().expect("a sampling thread's own");
    // rust: for width in [1, 4, 16] {
    // rust: assert_eq!(other.reduced_column(-16, 32, width), Column::default());
}
    // rust: assert_eq!(other.grid(-16, 32, 1, 16), vec![Column::default(); 256]);
        // `Job::Observe` stores it on the far-terrain worker.
    // rust: sampler.observed((-1, 2), &columns);
    // rust: assert_eq!(other.grid(-16, 32, 1, 16), columns.to_vec());
    // rust: assert_eq!(
    // rust: other.reduced_column(-16, 32, 16),
    // rust: Column::reduced(&columns, 0, 0, 16)
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn bobby_folders_follow_the_address_as_typed() void {
}
    // rust: let root = scratch("bobby-folders");
    // rust: for dir in [
    // rust: "127.0.0.1/-9030034075591913594/minecraft/overworld",
    // rust: "127.0.0.1/-9030034075591913594/minecraft/the_nether",
    // rust: "127.0.0.1/4696776658964135993/minecraft/overworld",
    // rust: "localhost_25566/-7181178862026813658/minecraft/overworld",
    // rust: "Play.Example.net_25565/5/minecraft/overworld",
    // rust: ] {
    // rust: std::fs::create_dir_all(root.join(dir)).unwrap();
}
    // rust: let find = |address: &str, seed: i64, level: &str| {
    // rust: bobby_level_dir(&root, address, seed, level)
    // rust: .map(|dir| dir.strip_prefix(&root).unwrap().to_owned())
}
    // rust: let overworld = "minecraft:overworld";
    // rust: let first = Some(PathBuf::from(
    // rust: "127.0.0.1/-9030034075591913594/minecraft/overworld",
    // rust: ));
    // rust: assert_eq!(find("127.0.0.1", -9030034075591913594, overworld), first);
    // rust: assert_eq!(
    // rust: find("127.0.0.1:25565", -9030034075591913594, overworld),
    // rust: first
    // rust: );
    // rust: assert_eq!(
    // rust: find("127.0.0.1", -9030034075591913594, "minecraft:the_nether"),
    // rust: Some(PathBuf::from(
    // rust: "127.0.0.1/-9030034075591913594/minecraft/the_nether"
    // rust: ))
    // rust: );
    // rust: assert_eq!(
    // rust: find("127.0.0.1", 4696776658964135993, overworld),
    // rust: Some(PathBuf::from(
    // rust: "127.0.0.1/4696776658964135993/minecraft/overworld"
    // rust: ))
    // rust: );
    // rust: let other_port = Some(PathBuf::from(
    // rust: "localhost_25566/-7181178862026813658/minecraft/overworld",
    // rust: ));
    // rust: assert_eq!(
    // rust: find("localhost:25566", -7181178862026813658, overworld),
    // rust: other_port
    // rust: );
    // rust: assert_eq!(
    // rust: find("LocalHost:25566", -7181178862026813658, overworld),
    // rust: other_port
    // rust: );
    // rust: assert_eq!(
    // rust: find("play.example.net", 5, overworld),
    // rust: Some(PathBuf::from(
    // rust: "Play.Example.net_25565/5/minecraft/overworld"
    // rust: ))
    // rust: );
        // Another world behind the address, another dimension, another port.
    // rust: assert_eq!(find("127.0.0.1", 1111, overworld), None);
    // rust: assert_eq!(
    // rust: find("127.0.0.1", -9030034075591913594, "minecraft:the_end"),
    // rust: None
    // rust: );
    // rust: assert_eq!(find("localhost", -7181178862026813658, overworld), None);
    // rust: assert_eq!(
    // rust: find("localhost:25567", -7181178862026813658, overworld),
    // rust: None
    // rust: );
    // rust: assert_eq!(find("", 0, overworld), None);
    // rust: assert_eq!(
    // rust: bobby_level_dir(&root.join("none"), "127.0.0.1", 0, overworld),
    // rust: None
    // rust: );
    // rust: std::fs::remove_dir_all(&root).unwrap();
}

    /// A Bobby-shaped region of chunk records, written with `version`.
pub fn bobby_region(dir: *Path, chunks: *[(i32) void {
}
    // rust: std::fs::create_dir_all(dir).unwrap();
    // rust: let (rx, rz) = (chunks[0].0 >> 5, chunks[0].1 >> 5);
    // rust: let mut file = RegionFile::open_writable(region_path(dir, (rx, rz)), true).unwrap();
    // rust: for &(x, z) in chunks {
    // rust: let root = NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([
    // rust: ("DataVersion", Tag::Int(version)),
    // rust: ("Status", Tag::String("full".into())),
    // rust: ("xPos", Tag::Int(x)),
    // rust: ("zPos", Tag::Int(z)),
    // rust: ]),
}
    // rust: let record = ChunkRecord::from_nbt(&root, Compression::Zlib, 0, Limits::default());
    // rust: file.write(ChunkPos::new(x, z), &record.unwrap()).unwrap();
}
}

    /// Stone from y 60 to 70 in every column (the game decodes vanilla chunk NBT
    /// with `save::decode_lit`; its palettes are tested there).
pub fn stone(root: *NamedTag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (Some(Tag::Int(x)), Some(Tag::Int(z))) = (root.tag.get("xPos"), root.tag.get("zPos"))
    // rust: else {
    // rust: return None;
}
    // rust: let mut chunk = Chunk::empty(*x, *z);
    // rust: for i in 0..256 {
    // rust: for y in 60..70 {
    // rust: chunk.set(i & 15, y, i >> 4, 1);
}
}
    // rust: Some(chunk)
}

pub fn chunks_only_bobby_has_are_read_once_and_kept() void {
}
    // rust: let dir = scratch("server-terrain-bobby");
    // rust: let (own, theirs) = (dir.join("own"), dir.join("bobby"));
    // rust: bobby_region(&theirs, &[(-3, 5), (-2, 5), (-1, 6)], DATA_VERSION);
    // rust: bobby_region(&theirs.join("old"), &[(-3, 5)], DATA_VERSION - 1);
    // rust: let region = region_path(&theirs, (-1, 0));
    // rust: let before = std::fs::read(&region).unwrap();
        // State 0 air, state 1 a kept block (`lod::state_kinds`).
    // rust: let bobby = |dir: &Path| Bobby {
    // rust: dir: dir.to_owned(),
    // rust: decode: Box::new(stone),
    // rust: kinds: vec![4, 1],
}
    // rust: let terrain = ServerTerrain::with_bobby(own.clone(), None, Some(bobby(&theirs)));
        // Counted for wide cells before they are read.
    // rust: assert_eq!(terrain.kept(-4, 4, 4), (3, Some((-3, 5))));
    // rust: let expected = summarize(
    // rust: &stone(&NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([("xPos", Tag::Int(-2)), ("zPos", Tag::Int(5))]),
    // rust: })
    // rust: .unwrap(),
    // rust: &[4, 1],
    // rust: );
    // rust: assert!(expected[0].surface.is_some());
    // rust: assert_eq!(terrain.chunk(-2, 5), Some(expected.clone()));
    // rust: assert_eq!(terrain.chunk(-2, 6), None);
    // rust: let mut sampler = terrain.clone().sampler();
    // rust: assert_eq!(sampler.column(-2 * 16 + 3, 5 * 16), expected[3]);
    // rust: drop(sampler);
    // rust: drop(terrain);
        // Kept in the level's own folder; Bobby's left as it was.
    // rust: let kept = ServerTerrain::new(own.clone(), None);
    // rust: assert_eq!(kept.chunk(-2, 5), Some(expected));
    // rust: assert_eq!(kept.chunk(-3, 5), None);
    // rust: assert_eq!(std::fs::read(&region).unwrap(), before);
        // Another game version's chunk is none.
    // rust: let old =
    // rust: ServerTerrain::with_bobby(dir.join("own-old"), None, Some(bobby(&theirs.join("old"))));
    // rust: assert_eq!(old.chunk(-3, 5), None);
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
