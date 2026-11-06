//! Transpiled from Horizon Rust crate
//! Module: horizon-world_region
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Anvil region reading, export to a new region, and in-place chunk writes
//! as vanilla's `RegionFile` makes them (a file opened with `open_writable`).
//! Exports never overwrite a file: use a separate directory for offline
//! edits and copied .mcc data.
// use crate::{
    // rust: compression::{Compression, invalid},
    // rust: nbt::{self, Limits, NamedTag},
}
// use horizon_core::position::ChunkPos;
// use std::{
    // rust: fs::{self, File, OpenOptions},
    // rust: io::{self, Read, Seek, SeekFrom, Write},
    // rust: path::{Path, PathBuf},
    // rust: sync::atomic::{AtomicU32, Ordering},
}

pub const SECTOR: usize = 4096;
pub const HEADER: usize = SECTOR * 2;
pub const MAX_COMPRESSED: usize = 64 * 1024 * 1024;

pub const ChunkRecord = struct {
    compression: Compression,
    compressed: std.ArrayList(u8),
    timestamp: u32,
};
    // rust: impl ChunkRecord {
    // rust: pub fn from_nbt(
    // rust: root: &NamedTag,
    // rust: compression: Compression,
    // rust: timestamp: u32,
    // rust: limits: Limits,
    // rust: ) -> io::Result<Self> {
    // rust: let bytes = nbt::write_named(root, limits).map_err(|e| invalid(e.to_string()))?;
    // rust: Ok(Self {
    // rust: compression,
    // rust: compressed: compression.encode(&bytes)?,
    // rust: timestamp,
    // rust: })
}
    /// `RegionFileStorage.read`: the root read straight off the decompressing
    /// stream, so bytes after it, and a damaged stream past it, are never read.
pub fn nbt(self: *Self, limits: Limits) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut bytes = Vec::new();
    // rust: let decoded = self
    // rust: .compression
    // rust: .decode_into(&self.compressed, limits.max_bytes, &mut bytes);
    // rust: match nbt::read_named(&bytes, limits) {
    // rust: Ok((root, _)) => Ok(root),
    // rust: Err(e) => Err(decoded.err().unwrap_or_else(|| invalid(e.to_string()))),
}
}
}

pub const RegionFile = struct {
    file: File,
    path: PathBuf,
    position: ChunkPos,
    offsets: [u32,
    timestamps: [u32,
    /// The sectors in use (`RegionBitmap`): the header's two and every
    /// chunk's.
    used: std.ArrayList(bool),
};

pub fn position_from_path(path: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = path
    // rust: .file_name()
    // rust: .and_then(|s| s.to_str())
    // rust: .ok_or_else(|| invalid("invalid region filename"))?;
    // rust: let parts: Vec<_> = name.split('.').collect();
    // rust: if parts.len() != 4 || parts[0] != "r" || parts[3] != "mca" {
    // rust: return Err(invalid("expected r.<x>.<z>.mca"));
}
    // rust: let x: i32 = parts[1]
    // rust: .parse()
    // rust: .map_err(|_| invalid("invalid region x coordinate"))?;
    // rust: let z: i32 = parts[2]
    // rust: .parse()
    // rust: .map_err(|_| invalid("invalid region z coordinate"))?;
    // Regions outside this range cannot be addressed with signed chunk coordinates.
    // rust: if !(-67_108_864..=67_108_863).contains(&x) || !(-67_108_864..=67_108_863).contains(&z) {
    // rust: return Err(invalid("region coordinate outside chunk coordinate range"));
}
    // rust: Ok(ChunkPos::new(x, z))
}

pub fn slot(region: ChunkPos, chunk: ChunkPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if chunk.region() != region {
    // rust: return Err(invalid("chunk does not belong to this region"));
}
    // rust: let (x, z) = chunk.region_local();
    // rust: Ok(usize::from(x) + usize::from(z) * 32)
}
pub fn position(region: ChunkPos, index: usize) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ChunkPos::new(
    // rust: region.x * 32 + (index % 32) as i32,
    // rust: region.z * 32 + (index / 32) as i32,
    // rust: )
}
pub fn external_path(directory: *Path, chunk: ChunkPos) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: directory.join(format!("c.{}.{}.mcc", chunk.x, chunk.z))
}
pub fn remove_if_exists(path: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match fs::remove_file(path) {
    // rust: Err(e) if e.kind() != io::ErrorKind::NotFound => Err(e),
    // rust: _ => Ok(()),
}
}

    // rust: impl RegionFile {
pub fn position(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.position
}
pub fn open(path: impl AsRef<Path>) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = path.as_ref().to_owned();
    // rust: let file = File::open(&path)?;
    // rust: Self::from_file(path, file)
}

    /// Open for reading and in-place writes (`write`, `clear`), creating an
    /// empty region with `create`.
pub fn open_writable(path: impl AsRef<Path>, create: bool) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = path.as_ref().to_owned();
    // rust: let file = OpenOptions::new()
    // rust: .read(true)
    // rust: .write(true)
    // rust: .create(create)
    // rust: .truncate(false)
    // rust: .open(&path)?;
    // rust: Self::from_file(path, file)
}

pub fn from_file(path: PathBuf, mut file: File) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let position = position_from_path(&path)?;
    // rust: let len = file.metadata()?.len();
        // RegionFile's constructor: a short header (an empty or truncated file)
        // reads as far as it goes, the rest stays zero (no chunks).
    // rust: let mut header = [0; HEADER];
    // rust: let mut read = 0;
    // rust: while read < HEADER {
    // rust: match file.read(&mut header[read..])? {
    // rust: 0 => break,
    // rust: n => read += n,
}
}
    // rust: let mut offsets = [0; 1024];
    // rust: let mut timestamps = [0; 1024];
    // rust: for i in 0..1024 {
    // rust: offsets[i] = u32::from_be_bytes(header[i * 4..i * 4 + 4].try_into().unwrap());
    // rust: timestamps[i] = u32::from_be_bytes(
    // rust: header[SECTOR + i * 4..SECTOR + i * 4 + 4]
    // rust: .try_into()
    // rust: .unwrap(),
    // rust: );
    // rust: if offsets[i] == 0 {
    // rust: continue;
}
    // rust: let start = offsets[i] >> 8;
    // rust: let count = offsets[i] & 255;
            // Vanilla drops entries that overlap the header, are empty or start past
            // the end of the file (logged as invalid sectors).
    // rust: if start < 2 || count == 0 || u64::from(start) * SECTOR as u64 > len {
    // rust: offsets[i] = 0;
}
}
    // rust: let mut region = Self {
    // rust: file,
    // rust: path,
    // rust: position,
    // rust: offsets,
    // rust: timestamps,
    // rust: used: Vec::new(),
}
    // rust: region.force(0, 2);
    // rust: for offset in offsets.into_iter().filter(|&o| o != 0) {
    // rust: region.force((offset >> 8) as usize, (offset & 255) as usize);
}
    // rust: Ok(region)
}

    /// `RegionBitmap.force`.
pub fn force(self: *Self, start: usize, count: usize) void {
}
    // rust: if self.used.len() < start + count {
    // rust: self.used.resize(start + count, false);
}
    // rust: self.used[start..start + count].fill(true);
}
    /// `RegionBitmap.free`.
pub fn free(self: *Self, start: usize, count: usize) void {
}
    // rust: let end = (start + count).min(self.used.len());
    // rust: if start < end {
    // rust: self.used[start..end].fill(false);
}
}
    /// `RegionBitmap.allocate`: the first run of free sectors long enough
    /// (the end of the file is free).
pub fn allocate(self: *Self, count: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut current = 0;
    // rust: loop {
    // rust: let start = (current..self.used.len())
    // rust: .find(|&s| !self.used[s])
    // rust: .unwrap_or(self.used.len());
    // rust: let end = (start..self.used.len()).find(|&s| self.used[s]);
    // rust: if end.is_none_or(|end| end - start >= count) {
    // rust: self.force(start, count);
    // rust: return start;
}
    // rust: current = end.unwrap_or(start);
}
}

    /// `RegionFile.write`: the chunk goes to the first free run of sectors
    /// that holds it (an oversized one, 256 sectors or more, to its external
    /// `c.X.Z.mcc` file with a one-sector stub), the header points to it,
    /// and only then are its old sectors freed. The other chunks stay where
    /// they are. A chunk's last sector is padded with zeros.
pub fn write(self: *Self, chunk: ChunkPos, record: *ChunkRecord) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = slot(self.position, chunk)?;
    // rust: if record.compressed.len() > MAX_COMPRESSED {
    // rust: return Err(invalid("compressed chunk limit exceeded"));
}
    // rust: let required = (record.compressed.len() + 5).div_ceil(SECTOR);
    // rust: let external = required >= 256;
    // rust: let sectors = if external { 1 } else { required };
    // rust: let start = self.allocate(sectors);
    // rust: if start + sectors > 0x100_0000 {
    // rust: self.free(start, sectors);
    // rust: return Err(invalid("region sector address limit exceeded"));
}
    // rust: let directory = self.path.parent().unwrap_or(Path::new(".")).to_owned();
    // rust: let external_file = external_path(&directory, chunk);
    // rust: let mut data = Vec::with_capacity(sectors * SECTOR);
    // rust: if external {
    // rust: let temporary = directory.join(format!(".c.{}.{}.mcc.tmp", chunk.x, chunk.z));
    // rust: let written = File::create(&temporary)
    // rust: .and_then(|mut f| {
    // rust: f.write_all(&record.compressed)?;
                    // The region's sync only covers the stub, not this external payload.
    // rust: f.sync_all()
    // rust: })
    // rust: .and_then(|_| fs::rename(&temporary, &external_file));
    // rust: if let Err(e) = written {
    // rust: let _ = fs::remove_file(&temporary);
    // rust: self.free(start, sectors);
    // rust: return Err(e);
}
    // rust: data.extend_from_slice(&1u32.to_be_bytes());
    // rust: data.push(record.compression as u8 | 128);
    // rust: } else {
    // rust: data.extend_from_slice(&(record.compressed.len() as u32 + 1).to_be_bytes());
    // rust: data.push(record.compression as u8);
    // rust: data.extend_from_slice(&record.compressed);
}
    // rust: data.resize(sectors * SECTOR, 0);
    // rust: let written = self
    // rust: .file
    // rust: .seek(SeekFrom::Start((start * SECTOR) as u64))
    // rust: .and_then(|_| self.file.write_all(&data));
    // rust: if let Err(e) = written {
    // rust: self.free(start, sectors);
    // rust: return Err(e);
}
    // rust: let old = self.offsets[i];
    // rust: self.offsets[i] = (start as u32) << 8 | sectors as u32;
    // rust: self.timestamps[i] = record.timestamp;
    // rust: self.write_header()?;
    // rust: if !external {
    // rust: remove_if_exists(&external_file)?;
}
    // rust: if old != 0 {
    // rust: self.free((old >> 8) as usize, (old & 255) as usize);
}
    // rust: Ok(())
}

    /// `RegionFile.clear`: the chunk is gone; `timestamp` marks when.
    /// Returns whether the region held it.
pub fn clear(self: *Self, chunk: ChunkPos, timestamp: u32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = slot(self.position, chunk)?;
    // rust: let old = self.offsets[i];
    // rust: if old == 0 {
    // rust: return Ok(false);
}
    // rust: self.offsets[i] = 0;
    // rust: self.timestamps[i] = timestamp;
    // rust: self.write_header()?;
    // rust: let directory = self.path.parent().unwrap_or(Path::new("."));
    // rust: remove_if_exists(&external_path(directory, chunk))?;
    // rust: self.free((old >> 8) as usize, (old & 255) as usize);
    // rust: Ok(true)
}

    /// Flush the writes to the disk.
pub fn sync(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.file.sync_data()
}

    /// `RegionFile.writeHeader`: both header sectors from memory, so the
    /// entries dropped as invalid when the file was opened are zero on disk too.
pub fn write_header(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut header = [0; HEADER];
    // rust: for i in 0..1024 {
    // rust: header[i * 4..i * 4 + 4].copy_from_slice(&self.offsets[i].to_be_bytes());
    // rust: header[SECTOR + i * 4..SECTOR + i * 4 + 4]
    // rust: .copy_from_slice(&self.timestamps[i].to_be_bytes());
}
    // rust: self.file.seek(SeekFrom::Start(0))?;
    // rust: self.file.write_all(&header)
}

pub fn chunks(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.offsets
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, value)| **value != 0)
    // rust: .map(|(i, _)| (position(self.position, i), self.timestamps[i]))
}

pub fn read(self: *Self, chunk: ChunkPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = slot(self.position, chunk)?;
    // rust: let offset = self.offsets[i];
    // rust: if offset == 0 {
    // rust: return Ok(None);
}
    // rust: self.file
    // rust: .seek(SeekFrom::Start(u64::from(offset >> 8) * SECTOR as u64))?;
    // rust: let mut header = [0; 5];
    // rust: self.file.read_exact(&mut header)?;
    // rust: let len = u32::from_be_bytes(header[..4].try_into().unwrap()) as usize;
    // rust: if len < 1 || len as u64 + 4 > (u64::from(offset & 255) * SECTOR as u64) {
    // rust: return Err(invalid("invalid chunk payload length"));
}
    // rust: let compression = Compression::try_from(header[4] & 127)?;
    // rust: let compressed = if header[4] & 128 != 0 {
    // rust: if len != 1 {
    // rust: return Err(invalid("external chunk stub has inline data"));
}
    // rust: let path = external_path(self.path.parent().unwrap_or(Path::new(".")), chunk);
    // rust: let file = File::open(path)?;
    // rust: let mut data = Vec::new();
    // rust: file.take((MAX_COMPRESSED + 1) as u64)
    // rust: .read_to_end(&mut data)?;
    // rust: if data.len() > MAX_COMPRESSED {
    // rust: return Err(invalid("external chunk compressed limit exceeded"));
}
    // rust: data
    // rust: } else {
    // rust: let mut data = vec![0; len - 1];
    // rust: self.file.read_exact(&mut data)?;
    // rust: data
}
    // rust: Ok(Some(ChunkRecord {
    // rust: compression,
    // rust: compressed,
    // rust: timestamp: self.timestamps[i],
    // rust: }))
}

    /// Export all chunks, preserving untouched compressed bytes and timestamps.
    /// Overrides are keyed by chunk position; None deletes a chunk in the export.
    // rust: pub fn export(
    // rust: &mut self,
    // rust: destination: impl AsRef<Path>,
    // rust: changes: &[(ChunkPos, Option<ChunkRecord>)],
    // rust: ) -> io::Result<()> {
    // rust: let destination = destination.as_ref();
    // rust: if position_from_path(destination)? != self.position {
    // rust: return Err(invalid("export region coordinates differ"));
}
    // rust: let mut replacements = BTreeChanges::new();
    // rust: for (chunk, record) in changes {
    // rust: let i = slot(self.position, *chunk)?;
    // rust: if replacements.insert(i, record.as_ref()).is_some() {
    // rust: return Err(invalid("duplicate chunk override"));
}
}
    // rust: let mut writer = RegionWriter::create(destination)?;
    // rust: for i in 0..1024 {
    // rust: let chunk = position(self.position, i);
    // rust: if let Some(record) = replacements.get(&i) {
    // rust: if let Some(record) = record {
    // rust: writer.write(chunk, record)?;
}
    // rust: } else if let Some(record) = self.read(chunk)? {
    // rust: writer.write(chunk, &record)?;
}
}
    // rust: writer.finish()
}
}
    // rust: type BTreeChanges<'a> = std::collections::BTreeMap<usize, Option<&'a ChunkRecord>>;

pub const NEXT_TEMP: AtomicU32 = AtomicU32::new(0);

/// Writes a complete new region to a temporary sibling, then publishes it with
/// an atomic, non-overwriting hard link. Drop rolls back unpublished files.
pub const RegionWriter = struct {
    file: File,
    temporary: PathBuf,
    destination: PathBuf,
    position: ChunkPos,
    offsets: [u32,
    timestamps: [u32,
    next_sector: u32,
    externals: std.ArrayList(PathBuf),
    committed: bool,
    failed: bool,
};
    // rust: impl RegionWriter {
pub fn create(destination: impl AsRef<Path>) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let destination = destination.as_ref().to_owned();
    // rust: let position = position_from_path(&destination)?;
    // rust: if destination.try_exists()? {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::AlreadyExists,
    // rust: "destination region already exists",
    // rust: ));
}
    // rust: let parent = destination
    // rust: .parent()
    // rust: .filter(|p| !p.as_os_str().is_empty())
    // rust: .unwrap_or(Path::new("."));
    // rust: fs::create_dir_all(parent)?;
    // rust: let (temporary, file) = loop {
    // rust: let path = parent.join(format!(
    // rust: ".horizon-{}-{}.tmp",
    // rust: std::process::id(),
    // rust: NEXT_TEMP.fetch_add(1, Ordering::Relaxed)
    // rust: ));
    // rust: match OpenOptions::new()
    // rust: .read(true)
    // rust: .write(true)
    // rust: .create_new(true)
    // rust: .open(&path)
    // rust: {
    // rust: Ok(file) => break (path, file),
    // rust: Err(e) if e.kind() == io::ErrorKind::AlreadyExists => continue,
    // rust: Err(e) => return Err(e),
}
}
    // rust: let mut writer = Self {
    // rust: file,
    // rust: temporary,
    // rust: destination,
    // rust: position,
    // rust: offsets: [0; 1024],
    // rust: timestamps: [0; 1024],
    // rust: next_sector: 2,
    // rust: externals: Vec::new(),
    // rust: committed: false,
    // rust: failed: false,
}
    // rust: writer.file.write_all(&[0; HEADER])?;
    // rust: Ok(writer)
}

pub fn write(self: *Self, chunk: ChunkPos, record: *ChunkRecord) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.failed {
    // rust: return Err(invalid("region writer failed previously"));
}
    // rust: let result = self.write_record(chunk, record);
    // rust: if result.is_err() {
    // rust: self.failed = true;
}
    // rust: result
}

pub fn write_record(self: *Self, chunk: ChunkPos, record: *ChunkRecord) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = slot(self.position, chunk)?;
    // rust: if self.offsets[i] != 0 {
    // rust: return Err(invalid("chunk already written"));
}
    // rust: if record.compressed.len() > MAX_COMPRESSED {
    // rust: return Err(invalid("compressed chunk limit exceeded"));
}
    // rust: let required = (record.compressed.len() + 5).div_ceil(SECTOR);
    // rust: let external = required >= 256;
    // rust: let sectors = if external { 1 } else { required as u32 };
    // rust: if self.next_sector + sectors > 0x100_0000 {
    // rust: return Err(invalid("region sector address limit exceeded"));
}
    // rust: if external {
    // rust: let path = external_path(self.destination.parent().unwrap_or(Path::new(".")), chunk);
    // rust: let mut file = OpenOptions::new()
    // rust: .write(true)
    // rust: .create_new(true)
    // rust: .open(&path)?;
    // rust: self.externals.push(path);
    // rust: file.write_all(&record.compressed)?;
    // rust: file.sync_all()?;
}
    // rust: self.file
    // rust: .seek(SeekFrom::Start(u64::from(self.next_sector) * SECTOR as u64))?;
    // rust: let len = if external {
    // rust: 1
    // rust: } else {
    // rust: record.compressed.len() as u32 + 1
}
    // rust: self.file.write_all(&len.to_be_bytes())?;
    // rust: self.file
    // rust: .write_all(&[record.compression as u8 | if external { 128 } else { 0 }])?;
    // rust: if !external {
    // rust: self.file.write_all(&record.compressed)?;
}
    // rust: self.offsets[i] = self.next_sector << 8 | sectors;
    // rust: self.timestamps[i] = record.timestamp;
    // rust: self.next_sector += sectors;
    // rust: Ok(())
}

pub fn finish() i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.failed {
    // rust: return Err(invalid("cannot publish a failed region writer"));
}
    // rust: self.file
    // rust: .set_len(u64::from(self.next_sector) * SECTOR as u64)?;
    // rust: self.file.seek(SeekFrom::Start(0))?;
    // rust: for value in self.offsets {
    // rust: self.file.write_all(&value.to_be_bytes())?;
}
    // rust: for value in self.timestamps {
    // rust: self.file.write_all(&value.to_be_bytes())?;
}
    // rust: self.file.sync_all()?;
        // Hard-link publication fails atomically if another writer won the name.
    // rust: fs::hard_link(&self.temporary, &self.destination)?;
    // rust: self.committed = true;
    // rust: Ok(())
}
}
    // rust: impl Drop for RegionWriter {
pub fn drop(self: *Self) void {
}
    // rust: let _ = fs::remove_file(&self.temporary);
    // rust: if !self.committed {
    // rust: for path in &self.externals {
    // rust: let _ = fs::remove_file(path);
}
}
}
}
