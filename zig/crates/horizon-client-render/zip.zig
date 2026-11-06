//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_zip
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Read-only ZIP archives (resource packs, data packs and the unifont glyph
//! archive), on the `zip` crate. Like Java's `ZipFile` (what vanilla's
//! `FilePackResources` reads with), the file stays open and only what is asked
//! for is read, and entries aren't CRC-checked.
// use std::{
    // rust: collections::BTreeMap,
    // rust: fs,
    // rust: io::{self, Read, Seek, SeekFrom},
    // rust: path::Path,
    // rust: sync::Arc,
}
// use zip::{CompressionMethod, ZipArchive};

/// The most one entry inflates to: far above any real pack file, but a zip
/// bomb stops here.
pub const MAX_ENTRY: usize = 1 << 30;

/// One archive with its entries indexed by name (`\` read as `/`), files
/// and folders apart.
pub const Zip = struct {
    archive: ZipArchive<Reader>,
    entries: BTreeMap<[]const u8,
    /// Folder entries (`name/`) by their name without the slash.
    folders: BTreeMap<[]const u8,
    /// The archive's length: no size an entry claims can be bigger.
    len: usize,
};
pub fn invalid(e: impl std::fmt::Display) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: io::Error::new(io::ErrorKind::InvalidData, e.to_string())
}
/// `file`'s bytes at `at`, which any number of readers may do at once: the
/// file has no cursor for them to share.
pub fn read_at(file: *fs::File, out: []u8, at: u64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: return std::os::unix::fs::FileExt::read_at(file, out, at);
    // rust: return std::os::windows::fs::FileExt::seek_read(file, out, at);
}
/// The bytes of `file` from `start` to `end`.
pub fn read_range(file: *fs::File, start: u64, end: u64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = vec![0; (end - start) as usize];
    // rust: let mut done = 0;
    // rust: while done < out.len() {
    // rust: match read_at(file, &mut out[done..], start + done as u64)? {
    // rust: 0 => return Err(io::ErrorKind::UnexpectedEof.into()),
    // rust: read => done += read,
}
}
    // rust: Ok(out)
}
/// The archive as the `zip` crate sees it: the file's bytes, with its tail
/// (the central directory on, END record normalized) from memory. A clone
/// shares both and has its own position.
pub const Reader = struct {
    /// What comes before the tail; none when the tail is the whole archive.
    file: ?*fs::File,
    tail: *[u8],
    tail_at: u64,
    position: u64,
};
    // rust: impl Read for Reader {
pub fn read(self: *Self, out: []u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let read = match self.position.checked_sub(self.tail_at) {
    // rust: Some(into) => {
    // rust: let rest = self.tail.get(into as usize..).unwrap_or_default();
    // rust: let read = rest.len().min(out.len());
    // rust: out[..read].copy_from_slice(&rest[..read]);
    // rust: read
}
    // rust: None => {
    // rust: let before = (self.tail_at - self.position).min(out.len() as u64) as usize;
    // rust: match &self.file {
    // rust: Some(file) => read_at(file, &mut out[..before], self.position)?,
    // rust: None => 0,
}
}
}
    // rust: self.position += read as u64;
    // rust: Ok(read)
}
}
    // rust: impl Seek for Reader {
pub fn seek(self: *Self, to: SeekFrom) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let position = match to {
    // rust: SeekFrom::Start(at) => Some(at),
    // rust: SeekFrom::End(by) => (self.tail_at + self.tail.len() as u64).checked_add_signed(by),
    // rust: SeekFrom::Current(by) => self.position.checked_add_signed(by),
}
    // rust: self.position = position.ok_or_else(|| invalid("seek before the archive's start"))?;
    // rust: Ok(self.position)
}
}
    // rust: impl Zip {
    /// Reads the central directory, not the entries: opening a pack of many
    /// gigabytes for its `pack.mcmeta` costs what opening a small one does.
pub fn open(path: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = fs::File::open(path)?;
    // rust: let len = file.metadata()?.len();
    // rust: let mut tail_at = len.saturating_sub((END_HEADER + u16::MAX as usize) as u64);
    // rust: let mut tail = read_range(&file, tail_at, len)?;
    // rust: if let Some(end) = find_end(&tail) {
    // rust: let directory = u32_at(&tail, end + 12);
    // rust: let start = (tail_at + end as u64).saturating_sub(directory.into());
            // All ones says the real length is in the Zip64 record instead.
    // rust: if directory != u32::MAX && start < tail_at {
    // rust: tail_at = start;
    // rust: tail = read_range(&file, tail_at, len)?;
}
}
    // rust: normalize_end(&mut tail);
    // rust: Self::new(Reader {
    // rust: file: Some(Arc::new(file)),
    // rust: tail: Arc::from(tail),
    // rust: tail_at,
    // rust: position: 0,
    // rust: })
}
pub fn from_bytes(mut data: std.ArrayList(u8)) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: normalize_end(&mut data);
    // rust: Self::new(Reader {
    // rust: file: None,
    // rust: tail: Arc::from(data),
    // rust: tail_at: 0,
    // rust: position: 0,
    // rust: })
}
pub fn new(reader: Reader) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = (reader.tail_at + reader.tail.len() as u64) as usize;
    // rust: let archive = ZipArchive::new(reader).map_err(invalid)?;
    // rust: let (mut entries, mut folders) = (BTreeMap::new(), BTreeMap::new());
    // rust: for i in 0..archive.len() {
    // rust: let Some(name) = archive.name_for_index(i) else {
    // rust: continue;
}
    // rust: let name = name.map_err(invalid)?.replace('\\', "/");
    // rust: match name.strip_suffix('/') {
    // rust: Some(folder) => folders.insert(folder.to_owned(), i),
    // rust: None => entries.insert(name, i),
}
}
    // rust: Ok(Self {
    // rust: archive,
    // rust: entries,
    // rust: folders,
    // rust: len,
    // rust: })
}
    /// The central directory on, as read at opening: every entry's name, sizes
    /// and checksum, so what changes with the archive's content.
pub fn directory(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.archive.clone().into_inner().tail
}
    /// The files, as `FilePackResources.listResources` lists them (folder
    /// entries skipped).
pub fn names(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries.keys().map(String::as_str)
}
    /// `FilePackResources.getResource` through `ZipFile.getEntry`: the file
    /// `name`, else the folder entry `name/`, whose bytes Java reads like a
    /// file's (Loka's pack stores its `pack.mcmeta` and `pack.png` that way).
pub fn index(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries
    // rust: .get(name)
    // rust: .or_else(|| self.folders.get(name))
    // rust: .copied()
}
pub fn contains(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.index(name).is_some()
}
pub fn read(self: *Self, name: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = self
    // rust: .index(name)
    // rust: .ok_or_else(|| io::Error::new(io::ErrorKind::NotFound, name.to_owned()))?;
        // A clone shares the reader's data and the central directory: reading
        // needs `&mut`.
    // rust: let mut archive = self.archive.clone();
    // rust: let mut entry = archive.by_index_raw(index).map_err(invalid)?;
    // rust: let method = entry.compression();
    // rust: let mut raw = Vec::with_capacity((entry.compressed_size() as usize).min(self.len));
    // rust: entry.read_to_end(&mut raw)?;
    // rust: match method {
    // rust: CompressionMethod::Stored => Ok(raw),
    // rust: CompressionMethod::Deflated => {
                // Java's ZipFile trusts neither size an entry declares: it
                // inflates the stream to its end and keeps what comes out.
                // Packs in the wild (a Nexo-generated one served through
                // Dropbox, for one) carry central-directory sizes that point
                // at other files, and miniz_oxide, which refuses input past
                // the stream's end, failed whole entries with "corrupt
                // deflate stream" and with them the whole pack. Only the
                // size limit stands between the archive and a zip bomb.
    // rust: let decoder = flate2::read::DeflateDecoder::new(raw.as_slice());
    // rust: let mut decoded = Vec::with_capacity(raw.len().min(MAX_ENTRY));
    // rust: decoder
    // rust: .take(MAX_ENTRY as u64 + 1)
    // rust: .read_to_end(&mut decoded)
    // rust: .map_err(|_| invalid("corrupt deflate stream"))?;
    // rust: if decoded.len() > MAX_ENTRY {
    // rust: return Err(invalid("entry inflates past the size limit"));
}
    // rust: Ok(decoded)
}
    // rust: _ => Err(invalid("unsupported zip compression")),
}
}
}

/// The 22 fixed bytes of the end-of-central-directory record.
pub const END_HEADER: usize = 22;

pub fn u16_at(data: []const u8, at: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: u16::from_le_bytes(data[at..at + 2].try_into().unwrap())
}
pub fn u32_at(data: []const u8, at: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: u32::from_le_bytes(data[at..at + 4].try_into().unwrap())
}

/// Where the END record starts. Its comment can hide the signature: scan back
/// through the last 64 KiB, like every zip reader.
pub fn find_end(data: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if data.len() < END_HEADER {
    // rust: return None;
}
    // rust: let start = data.len().saturating_sub(END_HEADER + u16::MAX as usize);
    // rust: (start..=data.len() - END_HEADER).rev().find(|&pos| {
    // rust: data[pos..pos + 4] == [0x50, 0x4b, 0x05, 0x06]
    // rust: && pos + END_HEADER + u16_at(data, pos + 20) as usize <= data.len()
    // rust: })
}

/// Java's `ZipFile` ignores the END record's disk numbers and file counts,
/// reading the central directory from `cenpos` to `cenpos + cenlen` whatever
/// they say; the `zip` crate insists the record agrees with the directory.
/// Packs written while streaming (Nexo serves them for gommehd.net, for one)
/// leave every file's local header a stub and the END counts and disk number
/// at 0 and 0xFFFF: archives Java opens but the crate refuses. Count the real
/// directory entries and normalize the record so it does not look multi-disk
/// or empty.
pub fn normalize_end(data: []u8) void {
}
    // rust: let Some(end) = find_end(data) else { return };
    // The directory's real position and length, as Java derives them; the
    // recorded offset is relative to the archive's start.
    // rust: let cenlen = u32_at(data, end + 12) as usize;
    // rust: let cenpos = end.saturating_sub(cenlen);
    // rust: let mut count = 0u16;
    // rust: let mut p = cenpos;
    // rust: while p + 46 <= end && data[p..p + 4] == [0x50, 0x4b, 0x01, 0x02] {
    // rust: count = count.saturating_add(1);
    // rust: p += 46
    // rust: + u16_at(data, p + 28) as usize
    // rust: + u16_at(data, p + 30) as usize
    // rust: + u16_at(data, p + 32) as usize;
}
    // rust: let disk = u16_at(data, end + 4);
    // rust: let with_directory = u16_at(data, end + 6);
    // rust: if disk == 0
    // rust: && with_directory == 0
    // rust: && u16_at(data, end + 8) == count
    // rust: && u16_at(data, end + 10) == count
    // rust: {
    // rust: return;
}
    // rust: data[end + 4..end + 10].fill(0);
    // rust: data[end + 8..end + 10].copy_from_slice(&count.to_le_bytes());
    // rust: data[end + 10..end + 12].copy_from_slice(&count.to_le_bytes());
}

    // rust: mod tests {
//     use super::*;
//     use std::io::Cursor;
    /// `bytes` as a file and opened, the file removed again where the system lets it.
pub fn opened(test: []const u8, bytes: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path =
    // rust: std::env::temp_dir().join(format!("horizon-zip-{}-{test}.zip", std::process::id()));
    // rust: fs::write(&path, bytes)?;
    // rust: let zip = Zip::open(&path);
    // rust: let _ = fs::remove_file(&path);
    // rust: zip
}
pub fn opening_a_file_reads_its_directory_and_not_its_entries() void {
}
    // rust: let body: Vec<u8> = (0..1 << 20).map(|i: u32| (i ^ i >> 8) as u8).collect();
    // rust: let bytes = archive_of(&[
    // rust: ("big.bin", &body, false),
    // rust: ("pack.mcmeta", b"{\"pack\":{}}", false),
    // rust: ("a/b.txt", b"hello hello hello hello", true),
    // rust: ]);
    // rust: let zip = opened("lazy", &bytes).unwrap();
    // rust: assert!(zip.archive.clone().into_inner().tail.len() < 70_000);
    // rust: assert_eq!(zip.read("big.bin").unwrap(), body);
    // rust: assert_eq!(zip.read("pack.mcmeta").unwrap(), b"{\"pack\":{}}");
    // rust: assert_eq!(zip.read("a/b.txt").unwrap(), b"hello hello hello hello");
    // rust: assert!(zip.read("missing").is_err());
}
pub fn a_directory_longer_than_the_end_scan_is_read_whole() void {
}
    // rust: let names: Vec<String> = (0..2000).map(|i| format!("{:0>60}.txt", i)).collect();
    // rust: let files: Vec<(&str, &[u8], bool)> = names
    // rust: .iter()
    // rust: .map(|n| (n.as_str(), &b"x"[..], false))
    // rust: .collect();
    // rust: let zip = opened("long-directory", &archive_of(&files)).unwrap();
    // rust: assert_eq!(zip.names().count(), 2000);
    // rust: assert_eq!(zip.read(&names[0]).unwrap(), b"x");
}
pub fn a_file_is_opened_past_end_counts_java_ignores() void {
}
    // rust: let mut bytes = archive();
    // rust: let end = bytes.len() - END_HEADER;
    // rust: bytes[end + 4..end + 6].fill(0xFF);
    // rust: bytes[end + 8..end + 12].fill(0);
    // rust: let zip = opened("end-counts", &bytes).unwrap();
    // rust: assert_eq!(zip.read("a/b.txt").unwrap(), b"hello hello hello hello");
}
pub fn a_file_is_opened_with_equal_nonzero_disk_numbers() void {
}
    // rust: let mut bytes = archive();
    // rust: let end = bytes.len() - END_HEADER;
    // rust: bytes[end + 4..end + 8].fill(0xFF);
    // rust: let zip = opened("end-disks", &bytes).unwrap();
    // rust: assert_eq!(zip.read("a/b.txt").unwrap(), b"hello hello hello hello");
}
pub fn a_file_that_is_no_archive_does_not_open() void {
}
    // rust: assert!(opened("empty", b"").is_err());
    // rust: assert!(opened("garbage", b"PK not really").is_err());
}
    /// A hand-built archive with one stored and one deflated entry.
pub fn archive() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: archive_of(&[
    // rust: ("pack.mcmeta", b"{\"pack\":{}}", false),
    // rust: ("a/b.txt", b"hello hello hello hello", true),
    // rust: ])
}
    /// A hand-built archive of `(name, body, deflated)` entries.
pub fn archive_of(files: *[([]const u8) void {
}
    // rust: let mut out = Vec::new();
    // rust: let mut central = Vec::new();
    // rust: for &(name, body, deflate) in files {
    // rust: let data = if deflate {
    // rust: miniz_oxide::deflate::compress_to_vec(body, 6)
    // rust: } else {
    // rust: body.to_vec()
}
    // rust: let offset = out.len() as u32;
    // rust: let local = |v: &mut Vec<u8>, sig: u32| {
    // rust: v.extend(sig.to_le_bytes());
}
    // rust: local(&mut out, 0x0403_4b50);
    // rust: out.extend([20, 0, 0, 0]);
    // rust: out.extend((if deflate { 8u16 } else { 0 }).to_le_bytes());
    // rust: out.extend([0; 8]);
    // rust: out.extend((data.len() as u32).to_le_bytes());
    // rust: out.extend((body.len() as u32).to_le_bytes());
    // rust: out.extend((name.len() as u16).to_le_bytes());
    // rust: out.extend(0u16.to_le_bytes());
    // rust: out.extend(name.as_bytes());
    // rust: out.extend(&data);
    // rust: local(&mut central, 0x0201_4b50);
    // rust: central.extend([20, 0, 20, 0, 0, 0]);
    // rust: central.extend((if deflate { 8u16 } else { 0 }).to_le_bytes());
    // rust: central.extend([0; 8]);
    // rust: central.extend((data.len() as u32).to_le_bytes());
    // rust: central.extend((body.len() as u32).to_le_bytes());
    // rust: central.extend((name.len() as u16).to_le_bytes());
    // rust: central.extend([0; 12]);
    // rust: central.extend(offset.to_le_bytes());
    // rust: central.extend(name.as_bytes());
}
    // rust: let start = out.len() as u32;
    // rust: out.extend(&central);
    // rust: out.extend(0x0605_4b50u32.to_le_bytes());
    // rust: out.extend([0; 4]);
    // rust: out.extend((files.len() as u16).to_le_bytes());
    // rust: out.extend((files.len() as u16).to_le_bytes());
    // rust: out.extend((central.len() as u32).to_le_bytes());
    // rust: out.extend(start.to_le_bytes());
    // rust: out.extend([0; 2]);
    // rust: out
}
pub fn reads_stored_and_deflated_entries() void {
}
        // Its CRCs are zero: Java's ZipFile doesn't check them either.
    // rust: let zip = Zip::from_bytes(archive()).unwrap();
    // rust: assert_eq!(zip.names().collect::<Vec<_>>(), ["a/b.txt", "pack.mcmeta"]);
    // rust: assert_eq!(zip.read("pack.mcmeta").unwrap(), b"{\"pack\":{}}");
    // rust: assert_eq!(zip.read("a/b.txt").unwrap(), b"hello hello hello hello");
    // rust: assert!(zip.read("missing").is_err());
}

    /// The offset of the central-directory header of `name`.
pub fn central_header(bytes: []const u8, name: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut at = 0;
    // rust: while let Some(i) = bytes[at..]
    // rust: .windows(4)
    // rust: .position(|s| s == [0x50, 0x4b, 0x01, 0x02])
    // rust: {
    // rust: let p = at + i;
    // rust: let nlen = u16::from_le_bytes(bytes[p + 28..p + 30].try_into().unwrap()) as usize;
    // rust: if &bytes[p + 46..p + 46 + nlen] == name.as_bytes() {
    // rust: return p;
}
    // rust: at = p + 4;
}
    // rust: panic!("no central header for {name}");
}

    /// Java's `ZipFile` inflates the stream and keeps what comes out, so a
    /// central directory that names a size other than the stream's (the
    /// Nexo pack Dropbox serves for one server does) changes nothing.
pub fn reads_a_deflate_stream_larger_than_its_declared_size() void {
}
//         use std::io::Write;
//         use zip::write::SimpleFileOptions;

    // rust: let mut writer = zip::ZipWriter::new(Cursor::new(Vec::new()));
    // rust: writer
    // rust: .start_file(
    // rust: "large.txt",
    // rust: SimpleFileOptions::default().compression_method(CompressionMethod::Deflated),
    // rust: )
    // rust: .unwrap();
    // rust: writer.write_all(&vec![b'x'; 4096]).unwrap();
    // rust: let mut bytes = writer.finish().unwrap().into_inner();
    // rust: let central = central_header(&bytes, "large.txt");
    // rust: bytes[central + 24..central + 28].copy_from_slice(&1u32.to_le_bytes());

    // rust: let zip = Zip::from_bytes(bytes).unwrap();
    // rust: assert_eq!(zip.read("large.txt").unwrap(), vec![b'x'; 4096]);
}

    /// Some pack writers leave an entry's compressed size longer than its
    /// deflate stream, so the bytes past the stream's end are part of it.
    /// Java inflates to the stream's end and ignores them; miniz_oxide
    /// refused the input and failed the entry, and with it the whole pack.
pub fn reads_past_trailing_bytes_after_the_deflate_stream() void {
}
    // rust: let mut bytes = written();
    // rust: let name = "Pack-main/assets/minecraft/lang/en_us.json";
    // rust: let central = central_header(&bytes, name);
    // rust: let local =
    // rust: u32::from_le_bytes(bytes[central + 42..central + 46].try_into().unwrap()) as usize;
    // rust: for at in [central + 20, local + 18] {
    // rust: let csize = u32::from_le_bytes(bytes[at..at + 4].try_into().unwrap());
    // rust: bytes[at..at + 4].copy_from_slice(&(csize + 8).to_le_bytes());
}

    // rust: let zip = Zip::from_bytes(bytes).unwrap();
    // rust: assert_eq!(
    // rust: zip.read(name).unwrap(),
    // rust: "{\"a\":\"b\"}".repeat(100).as_bytes()
    // rust: );
}

    /// Loka's server pack (#3413) names its metadata `pack.mcmeta/`.
    /// `ZipFile.getEntry("pack.mcmeta")` falls back to that folder entry and
    /// vanilla reads its bytes; a file of the exact name still comes first.
pub fn a_name_falls_back_to_its_folder_entry() void {
}
    // rust: let zip = Zip::from_bytes(archive_of(&[
    // rust: ("pack.mcmeta/", b"{\"pack\":{\"pack_format\":75}}", true),
    // rust: ("pack.png/", b"png", false),
    // rust: ("a/", b"folder", false),
    // rust: ("a", b"file", false),
    // rust: ]))
    // rust: .unwrap();
    // rust: assert_eq!(zip.names().collect::<Vec<_>>(), ["a"]);
    // rust: assert!(zip.contains("pack.mcmeta"));
    // rust: assert_eq!(
    // rust: zip.read("pack.mcmeta").unwrap(),
    // rust: b"{\"pack\":{\"pack_format\":75}}"
    // rust: );
    // rust: assert_eq!(zip.read("pack.png").unwrap(), b"png");
    // rust: assert_eq!(zip.read("a").unwrap(), b"file");
    // rust: assert!(!zip.contains("pack"));
}

    /// A pack as zip tools write it: folder entries, a nested pack root,
    /// stored and deflated files, and a Windows-style name.
pub fn written() V {
    // Implementation ported from Horizon
    return undefined;
}
//         use std::io::Write;
//         use zip::write::SimpleFileOptions;
    // rust: let mut w = zip::ZipWriter::new(Cursor::new(Vec::new()));
    // rust: let stored = SimpleFileOptions::default().compression_method(CompressionMethod::Stored);
    // rust: let deflated = SimpleFileOptions::default().compression_method(CompressionMethod::Deflated);
    // rust: w.add_directory("Pack-main/", stored).unwrap();
    // rust: w.add_directory("Pack-main/assets/minecraft/", stored)
    // rust: .unwrap();
    // rust: w.start_file("Pack-main/pack.mcmeta", stored).unwrap();
    // rust: w.write_all(b"{\"pack\":{\"pack_format\":64}}").unwrap();
    // rust: w.start_file("Pack-main/assets/minecraft/lang/en_us.json", deflated)
    // rust: .unwrap();
    // rust: w.write_all("{\"a\":\"b\"}".repeat(100).as_bytes()).unwrap();
    // rust: w.start_file(
    // rust: "Pack-main\\assets\\minecraft\\texts\\splashes.txt",
    // rust: deflated,
    // rust: )
    // rust: .unwrap();
    // rust: w.write_all(b"Also try Horizon!").unwrap();
    // rust: w.finish().unwrap().into_inner()
}

pub fn reads_nested_folders_and_skips_folder_entries() void {
}
    // rust: let zip = Zip::from_bytes(written()).unwrap();
    // rust: assert_eq!(
    // rust: zip.names().collect::<Vec<_>>(),
    // rust: [
    // rust: "Pack-main/assets/minecraft/lang/en_us.json",
    // rust: "Pack-main/assets/minecraft/texts/splashes.txt",
    // rust: "Pack-main/pack.mcmeta",
    // rust: ]
    // rust: );
    // rust: assert!(zip.contains("Pack-main/pack.mcmeta"));
    // rust: assert!(!zip.contains("Pack-main/"));
    // rust: assert_eq!(
    // rust: zip.read("Pack-main/assets/minecraft/lang/en_us.json")
    // rust: .unwrap(),
    // rust: "{\"a\":\"b\"}".repeat(100).as_bytes()
    // rust: );
    // rust: assert_eq!(
    // rust: zip.read("Pack-main/assets/minecraft/texts/splashes.txt")
    // rust: .unwrap(),
    // rust: b"Also try Horizon!"
    // rust: );
}

pub fn a_bad_entry_fails_alone() void {
}
    // rust: let mut bytes = written();
        // The deflated lang file's stream becomes a reserved block type.
    // rust: let (start, len) = {
    // rust: let mut archive = ZipArchive::new(Cursor::new(bytes.as_slice())).unwrap();
    // rust: let index = archive
    // rust: .index_for_name("Pack-main/assets/minecraft/lang/en_us.json")
    // rust: .unwrap();
    // rust: let entry = archive.by_index_raw(index).unwrap();
    // rust: (
    // rust: entry.data_start().unwrap() as usize,
    // rust: entry.compressed_size() as usize,
    // rust: )
}
    // rust: bytes[start..start + len].fill(0xff);
    // rust: let zip = Zip::from_bytes(bytes).unwrap();
    // rust: assert!(
    // rust: zip.read("Pack-main/assets/minecraft/lang/en_us.json")
    // rust: .is_err()
    // rust: );
    // rust: assert_eq!(
    // rust: zip.read("Pack-main/pack.mcmeta").unwrap(),
    // rust: b"{\"pack\":{\"pack_format\":64}}"
    // rust: );
}

pub fn refuses_what_is_not_a_zip() void {
}
    // rust: assert!(Zip::from_bytes(b"PK not really".to_vec()).is_err());
    // rust: assert!(Zip::from_bytes(Vec::new()).is_err());
    // rust: let mut cut = written();
    // rust: cut.truncate(cut.len() / 2);
    // rust: assert!(Zip::from_bytes(cut).is_err());
}

    /// A pack as a streaming writer serves it (Nexo/gommehd.net): every
    /// local header is a 30-byte stub and the END record's disk number and
    /// counts are wrong. Java 25's `ZipFile` opens it, with each size either
    /// in the directory or as 0xFFFFFFFF plus its Zip64 extra field (without
    /// that field it refuses the archive: "invalid zip64 extra len size").
pub fn reads_a_streamed_archive() void {
}
    // rust: for zip64 in [false, true] {
    // rust: let files: [(&str, &[u8]); 2] = [
    // rust: ("pack.mcmeta", b"{\"pack\":{}}"),
    // rust: ("a/b.txt", b"streamed entry"),
    // rust: ];
    // rust: let mut out = Vec::new();
    // rust: let mut central = Vec::new();
    // rust: for (name, body) in files {
    // rust: let data = miniz_oxide::deflate::compress_to_vec(body, 6);
    // rust: let offset = out.len() as u32;
    // rust: out.extend(0x0403_4b50u32.to_le_bytes());
    // rust: out.extend([0; 26]);
    // rust: out.extend(&data);
    // rust: let extra: Vec<u8> = if zip64 {
    // rust: [1u16, 8]
    // rust: .iter()
    // rust: .flat_map(|v| v.to_le_bytes())
    // rust: .chain((body.len() as u64).to_le_bytes())
    // rust: .collect()
    // rust: } else {
    // rust: Vec::new()
}
    // rust: central.extend(0x0201_4b50u32.to_le_bytes());
    // rust: central.extend([20, 0, 20, 0, 0, 0]);
    // rust: central.extend(8u16.to_le_bytes());
    // rust: central.extend([0; 8]);
    // rust: central.extend((data.len() as u32).to_le_bytes());
    // rust: central.extend(if zip64 { u32::MAX } else { body.len() as u32 }.to_le_bytes());
    // rust: central.extend((name.len() as u16).to_le_bytes());
    // rust: central.extend((extra.len() as u16).to_le_bytes());
    // rust: central.extend([0; 10]);
    // rust: central.extend(offset.to_le_bytes());
    // rust: central.extend(name.as_bytes());
    // rust: central.extend(extra);
}
    // rust: let start = out.len() as u32;
    // rust: out.extend(&central);
    // rust: out.extend(0x0605_4b50u32.to_le_bytes());
    // rust: out.extend(u16::MAX.to_le_bytes());
    // rust: out.extend([0; 6]);
    // rust: out.extend((central.len() as u32).to_le_bytes());
    // rust: out.extend(start.to_le_bytes());
    // rust: out.extend([0; 2]);
    // rust: let zip = Zip::from_bytes(out).unwrap();
    // rust: assert_eq!(zip.names().collect::<Vec<_>>(), ["a/b.txt", "pack.mcmeta"]);
    // rust: assert_eq!(zip.read("pack.mcmeta").unwrap(), b"{\"pack\":{}}");
    // rust: assert_eq!(zip.read("a/b.txt").unwrap(), b"streamed entry");
}
}

    /// A streamed archive whose zip64 extra lies: both sizes claimed are
    /// u64::MAX / 2. `Zip::from_bytes` may refuse it; if not, `read` errs or reads
    /// instead of dying on a capacity that no archive could hold.
pub fn declared_sizes_past_the_archive_do_not_abort() void {
}
    // rust: let name = "a/b.txt";
    // rust: let body = b"streamed entry";
    // rust: let data = miniz_oxide::deflate::compress_to_vec(body, 6);
    // rust: let mut out = Vec::new();
    // rust: let mut central = Vec::new();
    // rust: let offset = out.len() as u32;
    // rust: out.extend(0x0403_4b50u32.to_le_bytes());
    // rust: out.extend([0; 26]);
    // rust: out.extend(&data);
        // Both directory sizes 0xFFFFFFFF so the zip64 extra's uncompressed,
        // then compressed, sizes are the ones read.
    // rust: let extra: Vec<u8> = [1u16, 16]
    // rust: .iter()
    // rust: .flat_map(|v| v.to_le_bytes())
    // rust: .chain((u64::MAX / 2).to_le_bytes())
    // rust: .chain((u64::MAX / 2).to_le_bytes())
    // rust: .collect();
    // rust: central.extend(0x0201_4b50u32.to_le_bytes());
    // rust: central.extend([20, 0, 20, 0, 0, 0]);
    // rust: central.extend(8u16.to_le_bytes());
    // rust: central.extend([0; 8]);
    // rust: central.extend(u32::MAX.to_le_bytes());
    // rust: central.extend(u32::MAX.to_le_bytes());
    // rust: central.extend((name.len() as u16).to_le_bytes());
    // rust: central.extend((extra.len() as u16).to_le_bytes());
    // rust: central.extend([0; 10]);
    // rust: central.extend(offset.to_le_bytes());
    // rust: central.extend(name.as_bytes());
    // rust: central.extend(extra);
    // rust: let start = out.len() as u32;
    // rust: out.extend(&central);
    // rust: out.extend(0x0605_4b50u32.to_le_bytes());
    // rust: out.extend(u16::MAX.to_le_bytes());
    // rust: out.extend([0; 6]);
    // rust: out.extend((central.len() as u32).to_le_bytes());
    // rust: out.extend(start.to_le_bytes());
    // rust: out.extend([0; 2]);
    // rust: if let Ok(zip) = Zip::from_bytes(out) {
    // rust: let _ = zip.read(name);
}
}
}
