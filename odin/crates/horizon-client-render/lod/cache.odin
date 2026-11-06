//! Transpiled from Horizon Rust crate
package horizon_client_render_cache

import "core:fmt"
import "core:mem"
import "core:math"

// Decorated far-terrain chunks kept on disk, beside a dimension's save, so a
// world opened again shows them without generating them again. One append-only
// file per 32x32 chunk region; a file written by another build, block registry
// or format is cleared on first use.
// use super::{Column, Span, Surface};
// use crate::fast_hash::FxHashMap;
// use horizon_world::registry::BlockStateId;
// use std::{
    // rust: fs::{File, OpenOptions},
    // rust: io::{Read, Seek, SeekFrom, Write},
    // rust: path::PathBuf,
    // rust: sync::{Arc, Mutex},
}

MAGIC :: b"HLOD"
FORMAT :: 1
HEADER :: 16
// A record: chunk x and z, then the deflated columns' length.
RECORD :: 12
// Columns of a chunk are a few kilobytes deflated; anything larger is damage.
MAX_RECORD :: 1 << 22

    // rust: type Columns = Arc<[Column; 256]>;

Region :: struct {
    file: File,
    // Each chunk's latest record: the offset of its deflated columns, and
    // their length.
    index: FxHashMap<(i32,
}

DiskCache :: struct {
    dir: PathBuf,
    key: u64,
    // ponytail: one lock for every region, with file reads under it; per-region
    // locks if the sampling threads ever wait on it.
    regions: Mutex<FxHashMap<(i32,
}

    // rust: impl DiskCache {
    // `key`: what the cached columns depend on (`build_key`); files with
    // another are cleared.
new :: proc(dir: PathBuf, key: u64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: dir,
    // rust: key,
    // rust: regions: Mutex::default(),
}
}

get :: proc(self: ^Self, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut regions = self.regions.lock().ok()?;
    // rust: let region = self.region(&mut regions, x, z, false)?;
    // rust: let &(offset, len) = region.index.get(&(x, z))?;
    // rust: let mut bytes = vec![0; len as usize];
    // rust: region.file.seek(SeekFrom::Start(offset)).ok()?;
    // rust: region.file.read_exact(&mut bytes).ok()?;
    // rust: drop(regions);
    // rust: decode(&bytes).map(Arc::new)
}

contains :: proc(self: ^Self, x: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(mut regions) = self.regions.lock() else {
    // rust: return false;
}
    // rust: self.region(&mut regions, x, z, false)
    // rust: .is_some_and(|region| region.index.contains_key(&(x, z)))
}

    // Writes a chunk not cached yet. One already cached stays as it is: the
    // build key clears stale ones, and a generation batch hands back
    // neighbours cached before, which appended again grew the files each
    // session.
put :: proc(self: ^Self, x: i32, z: i32, columns: ^[Column; 256]) {
}
    // rust: if self.contains(x, z) {
    // rust: return;
}
    // rust: let bytes = encode(columns);
    // rust: let Ok(mut regions) = self.regions.lock() else {
    // rust: return;
}
    // rust: let Some(region) = self.region(&mut regions, x, z, true) else {
    // rust: return;
}
        // Another sampler's thread may have written it while this one encoded.
    // rust: if region.index.contains_key(&(x, z)) {
    // rust: return;
}
    // rust: let mut record = Vec::with_capacity(RECORD as usize + bytes.len());
    // rust: record.extend_from_slice(&x.to_le_bytes());
    // rust: record.extend_from_slice(&z.to_le_bytes());
    // rust: record.extend_from_slice(&(bytes.len() as u32).to_le_bytes());
    // rust: record.extend_from_slice(&bytes);
    // rust: let Ok(end) = region.file.seek(SeekFrom::End(0)) else {
    // rust: return;
}
        // One write, so a crash leaves at most a torn last record, which
        // the next open cuts off.
    // rust: if region.file.write_all(&record).is_ok() {
    // rust: region
    // rust: .index
    // rust: .insert((x, z), (end + RECORD, bytes.len() as u32));
}
}

    // rust: fn region<'a>(
    // rust: &self,
    // rust: regions: &'a mut FxHashMap<(i32, i32), Option<Region>>,
    // rust: x: i32,
    // rust: z: i32,
    // rust: create: bool,
    // rust: ) -> Option<&'a mut Region> {
    // rust: let at = (x >> 5, z >> 5);
    // rust: if create && matches!(regions.get(&at), Some(None)) {
    // rust: regions.remove(&at);
}
    // rust: regions
    // rust: .entry(at)
    // rust: .or_insert_with(|| self.open(at, create))
    // rust: .as_mut()
}

open :: proc(self: ^Self) {
}
    // rust: let path = self.dir.join(format!("r.{rx}.{rz}.hlod"));
    // rust: if !create && !path.exists() {
    // rust: return None;
}
    // rust: if create {
    // rust: std::fs::create_dir_all(&self.dir).ok()?;
}
    // rust: let mut file = OpenOptions::new()
    // rust: .read(true)
    // rust: .write(true)
    // rust: .create(create)
    // rust: .truncate(false)
    // rust: .open(&path)
    // rust: .ok()?;
    // rust: let mut header = [0; HEADER as usize];
    // rust: let current = file.read_exact(&mut header).is_ok()
    // rust: && header[..4] == *MAGIC
    // rust: && header[4..8] == FORMAT.to_le_bytes()
    // rust: && header[8..] == self.key.to_le_bytes();
    // rust: let mut index = FxHashMap::default();
    // rust: if current {
    // rust: let size = file.metadata().ok()?.len();
    // rust: let mut at = HEADER;
    // rust: let mut record = [0; RECORD as usize];
    // rust: while at + RECORD <= size {
    // rust: file.seek(SeekFrom::Start(at)).ok()?;
    // rust: file.read_exact(&mut record).ok()?;
    // rust: let field = |i: usize| u32::from_le_bytes(record[i..i + 4].try_into().unwrap());
    // rust: let len = field(8);
    // rust: if len > MAX_RECORD || at + RECORD + u64::from(len) > size {
    // rust: break;
}
    // rust: index.insert((field(0) as i32, field(4) as i32), (at + RECORD, len));
    // rust: at += RECORD + u64::from(len);
}
    // rust: if at < size {
    // rust: file.set_len(at).ok()?;
}
    // rust: } else {
    // rust: file.set_len(0).ok()?;
    // rust: file.seek(SeekFrom::Start(0)).ok()?;
    // rust: let mut header = Vec::with_capacity(HEADER as usize);
    // rust: header.extend_from_slice(MAGIC);
    // rust: header.extend_from_slice(&FORMAT.to_le_bytes());
    // rust: header.extend_from_slice(&self.key.to_le_bytes());
    // rust: file.write_all(&header).ok()?;
}
    // rust: Some(Region { file, index })
}
}

// What cached columns depend on: this build (its commit, or for a local
// build the executable's own time, so a rebuilt generator starts afresh),
// the block states and the biomes.
build_key :: proc(states: uint, biomes: uint) -> u {
    // Ported from Horizon
    return {}
}
//     use std::hash::{Hash, Hasher};
    // rust: let mut hasher = std::hash::DefaultHasher::new();
    // rust: FORMAT.hash(&mut hasher);
    // rust: env!("CARGO_PKG_VERSION").hash(&mut hasher);
    // rust: match option_env!("HORIZON_COMMIT") {
    // rust: Some(commit) => commit.hash(&mut hasher),
    // rust: None => std::env::current_exe()
    // rust: .and_then(|exe| exe.metadata()?.modified())
    // rust: .ok()
    // rust: .hash(&mut hasher),
}
    // rust: states.hash(&mut hasher);
    // rust: biomes.hash(&mut hasher);
    // rust: hasher.finish()
}

encode :: proc(columns: ^[Column; 256]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for column in columns {
    // rust: match column.surface {
    // rust: None => out.push(0),
    // rust: Some(s) => {
    // rust: out.push(1 + u8::from(s.water.is_some()));
    // rust: out.extend_from_slice(&s.height.to_le_bytes());
    // rust: out.extend_from_slice(&s.state.0.to_le_bytes());
    // rust: out.extend_from_slice(&s.biome.to_le_bytes());
    // rust: if let Some((height, state)) = s.water {
    // rust: out.extend_from_slice(&height.to_le_bytes());
    // rust: out.extend_from_slice(&state.0.to_le_bytes());
}
}
}
    // rust: out.extend_from_slice(&(column.spans.len() as u16).to_le_bytes());
    // rust: for span in &column.spans {
    // rust: out.extend_from_slice(&span.min.to_le_bytes());
    // rust: out.extend_from_slice(&span.max.to_le_bytes());
    // rust: out.extend_from_slice(&span.state.0.to_le_bytes());
    // rust: out.extend_from_slice(&span.biome.to_le_bytes());
    // rust: out.extend_from_slice(&span.light.to_le_bytes());
}
}
    // rust: let mut deflate =
    // rust: flate2::write::DeflateEncoder::new(Vec::new(), flate2::Compression::default());
    // Writing to a Vec cannot fail.
    // rust: deflate.write_all(&out).unwrap();
    // rust: deflate.finish().unwrap()
}

decode :: proc(bytes: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut raw = Vec::new();
    // rust: flate2::read::DeflateDecoder::new(bytes)
    // rust: .take(u64::from(MAX_RECORD) * 8)
    // rust: .read_to_end(&mut raw)
    // rust: .ok()?;
    // rust: let mut at = 0;
    // rust: let mut take = |n: usize| {
    // rust: let field = raw.get(at..at + n)?;
    // rust: at += n;
    // rust: Some(field)
}
    // rust: let mut columns: [Column; 256] = std::array::from_fn(|_| Column::default());
    // rust: for column in &mut columns {
    // rust: let i32_ = |b: &[u8]| i32::from_le_bytes(b.try_into().unwrap());
    // rust: let u32_ = |b: &[u8]| u32::from_le_bytes(b.try_into().unwrap());
    // rust: let u16_ = |b: &[u8]| u16::from_le_bytes(b.try_into().unwrap());
    // rust: let i16_ = |b: &[u8]| i16::from_le_bytes(b.try_into().unwrap());
    // rust: let tag = take(1)?[0];
    // rust: if tag > 2 {
    // rust: return None;
}
    // rust: if tag > 0 {
    // rust: let height = i32_(take(4)?);
    // rust: let state = BlockStateId(u32_(take(4)?));
    // rust: let biome = u16_(take(2)?);
    // rust: let water = if tag == 2 {
    // rust: Some((i32_(take(4)?), BlockStateId(u32_(take(4)?))))
    // rust: } else {
    // rust: None
}
    // rust: column.surface = Some(Surface {
    // rust: height,
    // rust: state,
    // rust: water,
    // rust: biome,
    // rust: });
}
    // rust: let count = u16_(take(2)?);
    // rust: column.spans.reserve(count.into());
    // rust: for _ in 0..count {
    // rust: let span = Span {
    // rust: min: i16_(take(2)?),
    // rust: max: i16_(take(2)?),
    // rust: state: BlockStateId(u32_(take(4)?)),
    // rust: biome: u16_(take(2)?),
    // rust: light: u16_(take(2)?),
}
    // rust: if span.min >= span.max {
    // rust: return None;
}
    // rust: column.spans.push(span);
}
}
    // rust: (at == raw.len()).then_some(columns)
}

    // rust: mod tests {
//     use super::*;

columns :: proc(seed: u32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|i| {
    // rust: let i = i as u32 + seed;
    // rust: Column {
    // rust: surface: (!i.is_multiple_of(3)).then(|| Surface {
    // rust: height: 60 + (i % 7) as i32,
    // rust: state: BlockStateId(i),
    // rust: water: (i.is_multiple_of(2)).then_some((63, BlockStateId(9))),
    // rust: biome: (i % 5) as u16,
    // rust: }),
    // rust: spans: (0..i % 4)
    // rust: .map(|n| Span {
    // rust: min: (n * 10) as i16 - 64,
    // rust: max: (n * 10 + 4) as i16 - 64,
    // rust: state: BlockStateId(n + i),
    // rust: biome: 2,
    // rust: light: 240,
    // rust: })
    // rust: .collect(),
}
    // rust: })
}

chunks_survive_reopening_and_a_torn_last_record :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-lod-cache-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let cache = DiskCache::new(dir.clone(), 7);
    // rust: assert!(cache.get(3, -40).is_none(), "nothing cached yet");
    // rust: cache.put(3, -40, &columns(0));
    // rust: cache.put(4, -40, &columns(1));
    // rust: let path = dir.join("r.0.-2.hlod");
    // rust: let size = std::fs::metadata(&path).unwrap().len();
        // A chunk cached already is not appended again.
    // rust: cache.put(3, -40, &columns(2));
    // rust: assert_eq!(*cache.get(3, -40).unwrap(), columns(0));
    // rust: assert_eq!(std::fs::metadata(&path).unwrap().len(), size);
    // rust: drop(cache);

    // rust: let file = OpenOptions::new().write(true).open(&path).unwrap();
    // rust: file.set_len(size + 7).unwrap();
    // rust: drop(file);
    // rust: let cache = DiskCache::new(dir.clone(), 7);
    // rust: assert_eq!(*cache.get(3, -40).unwrap(), columns(0));
    // rust: assert_eq!(*cache.get(4, -40).unwrap(), columns(1));
    // rust: assert_eq!(
    // rust: std::fs::metadata(&path).unwrap().len(),
    // rust: size,
    // rust: "torn tail cut"
    // rust: );
    // rust: drop(cache);

        // Another build's files are cleared, not read.
    // rust: let cache = DiskCache::new(dir.clone(), 8);
    // rust: assert!(cache.get(3, -40).is_none());
    // rust: cache.put(5, -40, &columns(3));
    // rust: assert!(cache.get(4, -40).is_none());
    // rust: assert_eq!(*cache.get(5, -40).unwrap(), columns(3));
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

damaged_records_read_as_missing :: proc() {
}
    // rust: let bytes = encode(&columns(0));
    // rust: assert_eq!(decode(&bytes).unwrap(), columns(0));
    // rust: assert!(decode(&bytes[..bytes.len() / 2]).is_none());
    // rust: assert!(decode(b"not deflate").is_none());
}
}
