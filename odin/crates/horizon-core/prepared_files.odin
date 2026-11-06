//! Transpiled from Horizon Rust crate
package horizon_core_prepared_files

import "core:fmt"
import "core:mem"
import "core:math"

// `horizon-data.bin`: the prepared folder's small files in one file.
//
// A start reads about 22,000 files of the prepared folder (recipes, tags,
// models, textures...). Each costs a path lookup and an open, a seek on a hard
// disk and, on Windows, a Defender scan: about 1 ms a file after a signature
// update, over a minute at the first start (#1961). This file holds the same
// bytes, written from the folder itself on the owner's machine (never
// published), and is read through one open handle.
//
// A reader asks it first and falls back to the folder for what it doesn't hold
// (sounds, the top-level tables), and for everything when it is missing,
// written for another root (a resource pack's or a content mod's mirror of
// this one), from another preparation (its copy of `horizon-resources.json`
// differs), or damaged. `HORIZON_NO_DATA_FILE=1` turns it off.
//
// Layout, little-endian, every part 8-aligned:
// - `HZDATA\0\0`, the version (u32), the file count (u32), the lengths (u64)
//   of the root's path, of `horizon-resources.json` and of the name pool;
// - the root's canonical path and the bytes of `horizon-resources.json`;
// - the entries, in name order: name offset (u32) and length (u32) in the
//   pool, data offset (u64, from the start of the file) and length (u64);
// - the name pool: `/`-separated paths from the root;
// - the files' bytes.
// use std::{
    // rust: fs::{self, File},
    // rust: io::{self, BufWriter, Read, Write},
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Mutex, PoisonError},
}

// The file, in the prepared folder's root.
FILE_NAME :: "horizon-data.bin"
// The file it checks its preparation against.
SOURCE :: "horizon-resources.json"
// The folders it holds, with their subfolders: the resources, and the
// structure templates world generation loads one by one.
FOLDERS :: ["data", "assets", "worldgen/structure"]
MAGIC :: *b"HZDATA\0\0"
// 2: `worldgen/structure` joined the folders (a version 1 file lacks it).
VERSION :: 2
HEADER :: 40
ENTRY :: 24

// Whether `name` (from the root) is a file this holds: under its folders,
// and not a sound (hundreds of MB, read one at a time while playing).
holds_file :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: holds_folder(name) && !name.ends_with(".ogg")
}

// Whether `dir` (from the root) is one of the folders this holds, or under one.
holds_folder :: proc(dir: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: FOLDERS
    // rust: .iter()
    // rust: .any(|f| dir == *f || dir.strip_prefix(f).is_some_and(|r| r.starts_with('/')))
}

Entry :: struct {
    name: (u32,
    data: (u64,
}

// An open `horizon-data.bin`.
PreparedFiles :: struct {
    file: File,
    names: ^str,
    entries: ^[Entry],
}

    // rust: impl PreparedFiles {
name :: proc(self: ^Self, entry: ^Entry) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.names[entry.name.0 as usize..][..entry.name.1 as usize]
}
    // The bytes of `name` (`/`-separated, from the root); `None` when this
    // doesn't hold it (read it from the folder).
read :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.read_head(name, u64::MAX)
}
    // At most the first `max` bytes of `name`, as [`PreparedFiles::read`].
read_head :: proc(self: ^Self, name: string, max: u64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let i = self
    // rust: .entries
    // rust: .binary_search_by(|e| self.name(e).cmp(name))
    // rust: .ok()?;
    // rust: let (offset, len) = self.entries[i].data;
    // rust: let mut bytes = vec![0; len.min(max) as usize];
    // rust: Some(read_at(&self.file, &mut bytes, offset).map(|()| bytes))
}
    // The files under `dir` (`/`-separated, from the root) and its
    // subfolders, in name order, by their names from the root; `None` when
    // this doesn't hold that folder or has no file in it (list the folder).
list :: proc(self: ^Self, dir: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !holds_folder(dir) {
    // rust: return None;
}
    // rust: let prefix = format!("{dir}/");
    // rust: let start = self
    // rust: .entries
    // rust: .partition_point(|e| self.name(e) < prefix.as_str());
    // rust: let names: Vec<&str> = self.entries[start..]
    // rust: .iter()
    // rust: .map(|e| self.name(e))
    // rust: .take_while(|n| n.starts_with(&prefix))
    // rust: .collect();
    // rust: (!names.is_empty()).then_some(names)
}
open :: proc(root: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let path = root.join(FILE_NAME);
        // A mirror's link to another root's file.
    // rust: if fs::symlink_metadata(&path)?.file_type().is_symlink() {
    // rust: return Ok(None);
}
    // rust: let mut file = File::open(&path)?;
    // rust: let size = file.metadata()?.len();
    // rust: let mut header = [0; HEADER];
    // rust: file.read_exact(&mut header)?;
    // rust: let u32_at = |at: usize| u32::from_le_bytes(header[at..at + 4].try_into().unwrap());
    // rust: let u64_at = |at: usize| u64::from_le_bytes(header[at..at + 8].try_into().unwrap());
    // rust: if header[..8] != MAGIC || u32_at(8) != VERSION {
    // rust: return Ok(None);
}
    // rust: let (count, root_len, source_len, pool_len) =
    // rust: (u32_at(12) as u64, u64_at(16), u64_at(24), u64_at(32));
    // rust: let index_len = count * ENTRY as u64;
    // rust: let index_end = HEADER as u64 + pad(root_len) + pad(source_len) + index_len + pad(pool_len);
    // rust: if index_end > size {
    // rust: return Ok(None);
}
    // rust: let mut index = vec![0; (index_end - HEADER as u64) as usize];
    // rust: file.read_exact(&mut index)?;
    // rust: let (written_root, rest) = index.split_at(pad(root_len) as usize);
    // rust: let (source, rest) = rest.split_at(pad(source_len) as usize);
    // rust: let (raw_entries, pool) = rest.split_at(index_len as usize);
    // rust: if written_root[..root_len as usize]
    // rust: != *fs::canonicalize(root)?.as_os_str().as_encoded_bytes()
    // rust: || source[..source_len as usize] != *fs::read(root.join(SOURCE))?
    // rust: {
    // rust: return Ok(None);
}
    // rust: let Ok(names) = std::str::from_utf8(&pool[..pool_len as usize]) else {
    // rust: return Ok(None);
}
    // rust: let entries: Box<[Entry]> = raw_entries
    // rust: .chunks_exact(ENTRY)
    // rust: .map(|e| {
    // rust: let at = |i: usize, n: usize| {
    // rust: let mut b = [0; 8];
    // rust: b[..n].copy_from_slice(&e[i..i + n]);
    // rust: u64::from_le_bytes(b)
}
    // rust: Entry {
    // rust: name: (at(0, 4) as u32, at(4, 4) as u32),
    // rust: data: (at(8, 8), at(16, 8)),
}
    // rust: })
    // rust: .collect();
    // rust: let files = Self {
    // rust: file,
    // rust: names: names.into(),
    // rust: entries,
}
        // Every name in the pool, in strict order; every file's bytes inside the file.
    // rust: let mut last: Option<&str> = None;
    // rust: for e in files.entries.iter() {
    // rust: let (at, len) = (e.name.0 as usize, e.name.1 as usize);
    // rust: let name = files.names.get(at..at + len);
    // rust: let in_file = e
    // rust: .data
    // rust: .0
    // rust: .checked_add(e.data.1)
    // rust: .is_some_and(|end| end <= size);
    // rust: if name.is_none_or(|n| last.is_some_and(|l| l >= n)) || !in_file {
    // rust: return Ok(None);
}
    // rust: last = name;
}
    // rust: Ok(Some(files))
}
}

// `root`'s file, opened once per process; `None` when it has no usable one.
open :: proc(root: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: type Opened = Vec<(PathBuf, Option<Arc<PreparedFiles>>)>;
OPENED :: Mutex::new(Vec::new())
    // rust: let mut opened = OPENED.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: if let Some((_, files)) = opened.iter().find(|(r, _)| r == root) {
    // rust: return files.clone();
}
    // rust: let files = if std::env::var_os("HORIZON_NO_DATA_FILE").is_some() {
    // rust: None
    // rust: } else {
    // rust: match PreparedFiles::open(root) {
    // rust: Ok(files) => files.map(Arc::new),
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => None,
    // rust: Err(e) => {
    // rust: eprintln!("Horizon: {} not used: {e}", root.join(FILE_NAME).display());
    // rust: None
}
}
}
    // rust: opened.push((root.to_owned(), files.clone()));
    // rust: files
}

// The file holding `path` (a file or folder under a prepared root) and
// `path` from that root; `None` when no root above it has a usable file.
find :: proc(path: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: path.ancestors().skip(1).find_map(|root| {
        // Only a root holding one of the folders: no lookup for other paths.
    // rust: let rel = path.strip_prefix(root).ok()?;
    // rust: let rel = rel.to_str()?.replace(std::path::MAIN_SEPARATOR, "/");
    // rust: holds_folder(&rel).then_some(())?;
    // rust: Some((open(root)?, rel))
    // rust: })
}

// `path`'s bytes: from its prepared root's data file when that holds it,
// where a file the data file doesn't have is missing (`NotFound`, without
// asking the disk: a texture's `.mcmeta` or LabPBR maps, mostly absent);
// else from the disk.
read :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match find(path) {
    // rust: Some((files, rel)) if holds_file(&rel) => files
    // rust: .read(&rel)
    // rust: .unwrap_or_else(|| Err(io::ErrorKind::NotFound.into())),
    // rust: _ => fs::read(path),
}
}

// The files under `dir` (a folder of a prepared root) and its subfolders, as
// `/`-separated paths from `dir` in name order, from the root's data file
// without listing the disk: empty when it holds none there. `None` when no
// data file holds `dir` (walk the folder).
files_under :: proc(dir: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (files, rel) = find(dir)?;
    // rust: let names = files.list(&rel).unwrap_or_default();
    // rust: Some(
    // rust: names
    // rust: .into_iter()
    // rust: .map(|name| name[rel.len() + 1..].to_owned())
    // rust: .collect(),
    // rust: )
}

// At most the first `max` bytes of `path`, from where [`read`] takes them:
// a header, without reading the whole file.
read_head :: proc(path: ^Path, max: u64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match find(path) {
    // rust: Some((files, rel)) if holds_file(&rel) => files
    // rust: .read_head(&rel, max)
    // rust: .unwrap_or_else(|| Err(io::ErrorKind::NotFound.into())),
    // rust: _ => {
    // rust: let mut bytes = Vec::new();
    // rust: io::Read::read_to_end(&mut io::Read::take(File::open(path)?, max), &mut bytes)?;
    // rust: Ok(bytes)
}
}
}

// [`read`] as UTF-8 text.
read_to_string :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: String::from_utf8(read(path)?).map_err(|e| io::Error::new(io::ErrorKind::InvalidData, e))
}

// Write `root`'s file from its folders: through a temporary file renamed
// into place, so a reader sees the old file or the new one. Nothing is
// written for a root without `horizon-resources.json`.
write :: proc(root: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let source = fs::read(root.join(SOURCE))?;
    // rust: let canonical = fs::canonicalize(root)?;
    // rust: let root_bytes = canonical.as_os_str().as_encoded_bytes();
    // rust: let mut files = Vec::new();
    // rust: for folder in FOLDERS {
    // rust: walk(&root.join(folder), folder, &mut files)?;
}
    // rust: files.sort_by(|a, b| a.0.cmp(&b.0));
    // rust: let pool_len: usize = files.iter().map(|(n, _, _)| n.len()).sum();
    // rust: let data_start = HEADER as u64
    // rust: + pad(root_bytes.len() as u64)
    // rust: + pad(source.len() as u64)
    // rust: + (files.len() * ENTRY) as u64
    // rust: + pad(pool_len as u64);
    // rust: let tmp = root.join(format!("{FILE_NAME}.{}.tmp", std::process::id()));
    // rust: let result = (|| {
    // rust: let mut out = BufWriter::new(File::create(&tmp)?);
    // rust: out.write_all(&MAGIC)?;
    // rust: out.write_all(&VERSION.to_le_bytes())?;
    // rust: out.write_all(
    // rust: &u32::try_from(files.len())
    // rust: .map_err(io::Error::other)?
    // rust: .to_le_bytes(),
    // rust: )?;
    // rust: for len in [root_bytes.len(), source.len(), pool_len] {
    // rust: out.write_all(&(len as u64).to_le_bytes())?;
}
    // rust: write_padded(&mut out, root_bytes)?;
    // rust: write_padded(&mut out, &source)?;
    // rust: let (mut name_at, mut data_at) = (0u32, data_start);
    // rust: for (name, _, len) in &files {
    // rust: out.write_all(&name_at.to_le_bytes())?;
    // rust: out.write_all(&(name.len() as u32).to_le_bytes())?;
    // rust: out.write_all(&data_at.to_le_bytes())?;
    // rust: out.write_all(&len.to_le_bytes())?;
    // rust: name_at += name.len() as u32;
    // rust: data_at += len;
}
    // rust: write_padded(
    // rust: &mut out,
    // rust: files
    // rust: .iter()
    // rust: .flat_map(|(n, _, _)| n.bytes())
    // rust: .collect::<Vec<_>>()
    // rust: .as_slice(),
    // rust: )?;
    // rust: for (_, path, len) in &files {
    // rust: let bytes = fs::read(path)?;
            // Changed since it was listed: the offsets would be wrong.
    // rust: if bytes.len() as u64 != *len {
    // rust: return Err(io::Error::other(format!("{} changed", path.display())));
}
    // rust: out.write_all(&bytes)?;
}
    // rust: out.into_inner()
    // rust: .map_err(io::IntoInnerError::into_error)?
    // rust: .sync_all()?;
    // rust: fs::rename(&tmp, root.join(FILE_NAME))
    // rust: })();
    // rust: if result.is_err() {
    // rust: let _ = fs::remove_file(&tmp);
}
    // rust: result
}

// The files under `dir` (named `name` from the root) this holds, with their
// paths and sizes.
walk :: proc(dir: ^Path, name: string, out: ^Vec<(string) {
}
    // rust: let entries = match fs::read_dir(dir) {
    // rust: Ok(entries) => entries,
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => return Ok(()),
    // rust: Err(e) => return Err(e),
}
    // rust: for entry in entries {
    // rust: let entry = entry?;
    // rust: let path = entry.path();
    // rust: let Some(file_name) = entry.file_name().to_str().map(str::to_owned) else {
            // A name a reader of the file couldn't ask for: list the folder instead.
    // rust: return Err(io::Error::other(format!("{} is not UTF-8", path.display())));
}
    // rust: let child = format!("{name}/{file_name}");
    // rust: let meta = fs::metadata(&path)?;
    // rust: if meta.is_dir() {
    // rust: walk(&path, &child, out)?;
    // rust: } else if holds_file(&child) {
    // rust: out.push((child, path, meta.len()));
}
}
    // rust: Ok(())
}

pad :: proc(len: u64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: len.next_multiple_of(8)
}

write_padded :: proc(out: ^impl Write, bytes: []u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: out.write_all(bytes)?;
    // rust: out.write_all(&[0; 8][..(pad(bytes.len() as u64) as usize - bytes.len())])
}

read_at :: proc(file: ^File, buf: []u8, offset: u64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: std::os::unix::fs::FileExt::read_exact_at(file, buf, offset)
}
read_at :: proc(file: ^File, mut buf: []u8, mut offset: u64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: while !buf.is_empty() {
    // rust: match std::os::windows::fs::FileExt::seek_read(file, buf, offset) {
    // rust: Ok(0) => return Err(io::ErrorKind::UnexpectedEof.into()),
    // rust: Ok(n) => {
    // rust: buf = &mut buf[n..];
    // rust: offset += n as u64;
}
    // rust: Err(e) if e.kind() == io::ErrorKind::Interrupted => {}
    // rust: Err(e) => return Err(e),
}
}
    // rust: Ok(())
}
read_at :: proc(file: ^File, buf: []u8, offset: u64) -> i {
    // Ported from Horizon
    return {}
}
//     use std::io::Seek;
LOCK :: Mutex::new(())
    // rust: let _held = LOCK.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: let mut file = file;
    // rust: file.seek(io::SeekFrom::Start(offset))?;
    // rust: file.read_exact(buf)
}

    // rust: mod tests {
//     use super::*;

    // A prepared root with a few files, as `horizon-prepare` leaves it.
root :: proc(tag: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::env::temp_dir().join(format!("hz-prepared-{tag}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: for (name, bytes) in [
    // rust: (SOURCE, &b"{\"client_sha256\":\"a\"}"[..]),
    // rust: ("data/minecraft/recipe/stick.json", b"{\"stick\":1}"),
    // rust: ("data/minecraft/recipe/brewing/awkward.json", b"{}"),
    // rust: ("data/minecraft/tags/item/logs.json", b"[1,2,3]"),
    // rust: ("assets/minecraft/textures/block/stone.png", b"\x89PNG..."),
    // rust: ("assets/minecraft/sounds/ambient/cave1.ogg", b"OggS"),
    // rust: (
    // rust: "worldgen/structure/minecraft/fossil/spine_1.nbt",
    // rust: b"\x1f\x8b",
    // rust: ),
    // rust: ("worldgen/biomes.json", b"{}"),
    // rust: ("facts.json", b"{}"),
    // rust: ] {
    // rust: let path = root.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, bytes).unwrap();
}
    // rust: root
}

    // Every file of its folders reads back as the folder has it; the sounds
    // and the top-level tables are left to the folder.
the_file_reads_and_lists_what_the_folders_hold :: proc() {
}
    // rust: let root = root("reads");
    // rust: write(&root).unwrap();
    // rust: let files = PreparedFiles::open(&root).unwrap().unwrap();
    // rust: for name in [
    // rust: "data/minecraft/recipe/stick.json",
    // rust: "data/minecraft/recipe/brewing/awkward.json",
    // rust: "data/minecraft/tags/item/logs.json",
    // rust: "assets/minecraft/textures/block/stone.png",
    // rust: ] {
    // rust: assert_eq!(
    // rust: files.read(name).unwrap().unwrap(),
    // rust: fs::read(root.join(name)).unwrap()
    // rust: );
}
    // rust: assert!(
    // rust: files
    // rust: .read("assets/minecraft/sounds/ambient/cave1.ogg")
    // rust: .is_none()
    // rust: );
    // rust: assert!(files.read("facts.json").is_none());
    // rust: assert!(files.read("worldgen/biomes.json").is_none());
    // rust: assert_eq!(
    // rust: files
    // rust: .read("worldgen/structure/minecraft/fossil/spine_1.nbt")
    // rust: .unwrap()
    // rust: .unwrap(),
    // rust: b"\x1f\x8b"
    // rust: );
    // rust: assert!(files.read("data/minecraft/recipe/missing.json").is_none());
    // rust: assert_eq!(
    // rust: files.list("data/minecraft/recipe").unwrap(),
    // rust: [
    // rust: "data/minecraft/recipe/brewing/awkward.json",
    // rust: "data/minecraft/recipe/stick.json"
    // rust: ]
    // rust: );
        // `recipe` is not a prefix of `recipes`.
    // rust: assert!(files.list("data/minecraft/recipes").is_none());
    // rust: assert!(files.list("worldgen").is_none());
    // rust: let _ = fs::remove_dir_all(&root);
}

    // A file from another preparation, damaged, or a link from another
    // root's mirror is not used: the folder is read instead.
a_file_that_does_not_match_its_root_is_not_used :: proc() {
}
    // rust: let root = root("stale");
    // rust: write(&root).unwrap();
    // rust: fs::write(root.join(SOURCE), b"{\"client_sha256\":\"b\"}").unwrap();
    // rust: assert!(
    // rust: PreparedFiles::open(&root).unwrap().is_none(),
    // rust: "another preparation"
    // rust: );

    // rust: write(&root).unwrap();
    // rust: let bin = root.join(FILE_NAME);
    // rust: let bytes = fs::read(&bin).unwrap();
    // rust: fs::write(&bin, &bytes[..bytes.len() - 3]).unwrap();
    // rust: assert!(PreparedFiles::open(&root).unwrap().is_none(), "cut short");

    // rust: write(&root).unwrap();
        // A mirror of the root (a resource pack's, a content mod's) holding a
        // copy of its file and its horizon-resources.json.
    // rust: let mirror =
    // rust: std::env::temp_dir().join(format!("hz-prepared-mirror-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&mirror);
    // rust: fs::create_dir_all(&mirror).unwrap();
    // rust: fs::copy(&bin, mirror.join(FILE_NAME)).unwrap();
    // rust: fs::copy(root.join(SOURCE), mirror.join(SOURCE)).unwrap();
    // rust: assert!(
    // rust: PreparedFiles::open(&mirror).unwrap().is_none(),
    // rust: "another root's copy"
    // rust: );
    // rust: {
    // rust: fs::remove_file(mirror.join(FILE_NAME)).unwrap();
    // rust: std::os::unix::fs::symlink(&bin, mirror.join(FILE_NAME)).unwrap();
    // rust: assert!(
    // rust: PreparedFiles::open(&mirror).unwrap().is_none(),
    // rust: "another root's link"
    // rust: );
}
    // rust: let _ = fs::remove_dir_all(&mirror);
    // rust: let _ = fs::remove_dir_all(&root);
}

    // A folder's files come from the file, without the disk: one added since
    // isn't listed (as `read` doesn't find it), and a folder it holds nothing
    // in is empty. Outside its folders, the disk is walked.
files_under_lists_a_folder_from_the_file :: proc() {
}
    // rust: let root = root("under");
    // rust: write(&root).unwrap();
    // rust: fs::write(root.join("assets/minecraft/textures/block/added.png"), b"x").unwrap();
    // rust: assert_eq!(
    // rust: files_under(&root.join("assets/minecraft/textures")).unwrap(),
    // rust: ["block/stone.png"]
    // rust: );
    // rust: assert_eq!(
    // rust: files_under(&root.join("worldgen/structure")).unwrap(),
    // rust: ["minecraft/fossil/spine_1.nbt"]
    // rust: );
    // rust: assert!(
    // rust: files_under(&root.join("assets/minecraft/textures/entity"))
    // rust: .unwrap()
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(files_under(&root.join("worldgen")), None);
    // rust: let _ = fs::remove_dir_all(&root);
}

    // `find` gives the file and the path from its root for a folder under a
    // root that has one, and nothing elsewhere.
find_walks_up_to_the_root_with_a_file :: proc() {
}
    // rust: let root = root("find");
    // rust: write(&root).unwrap();
    // rust: let (_, rel) = find(&root.join("data/minecraft/recipe")).unwrap();
    // rust: assert_eq!(rel, "data/minecraft/recipe");
    // rust: let (_, rel) = find(&root.join("worldgen/structure/minecraft")).unwrap();
    // rust: assert_eq!(rel, "worldgen/structure/minecraft");
        // The top-level tables beside the structures stay on the disk.
    // rust: assert!(find(&root.join("worldgen")).is_none());
    // rust: assert!(find(&root.join("worldgen/biomes.json")).is_none());
    // rust: let _ = fs::remove_dir_all(&root);
}

    // Under a root with a file, a file it holds reads from it and a file it
    // doesn't is missing even when the disk has one now; a file outside its
    // folders, or a sound, reads from the disk.
read_takes_the_file_for_what_it_holds :: proc() {
}
    // rust: let root = root("read");
    // rust: write(&root).unwrap();
    // rust: let stick = root.join("data/minecraft/recipe/stick.json");
    // rust: fs::write(&stick, b"changed on disk").unwrap();
    // rust: assert_eq!(read(&stick).unwrap(), b"{\"stick\":1}");
    // rust: let added = root.join("assets/minecraft/textures/block/stone_n.png");
    // rust: fs::write(&added, b"added after").unwrap();
    // rust: assert_eq!(read(&added).unwrap_err().kind(), io::ErrorKind::NotFound);
    // rust: assert_eq!(read(&root.join("facts.json")).unwrap(), b"{}");
    // rust: let sound = root.join("assets/minecraft/sounds/ambient/cave1.ogg");
    // rust: assert_eq!(read(&sound).unwrap(), b"OggS");
    // rust: assert_eq!(read_to_string(&stick).unwrap(), "{\"stick\":1}");
        // A header: from the file for what it holds, from the disk for the rest.
    // rust: assert_eq!(read_head(&stick, 4).unwrap(), b"{\"st");
    // rust: assert_eq!(read_head(&stick, 100).unwrap(), b"{\"stick\":1}");
    // rust: assert_eq!(read_head(&sound, 2).unwrap(), b"Og");
    // rust: assert_eq!(
    // rust: read_head(&added, 2).unwrap_err().kind(),
    // rust: io::ErrorKind::NotFound
    // rust: );
    // rust: let _ = fs::remove_dir_all(&root);
}
}
