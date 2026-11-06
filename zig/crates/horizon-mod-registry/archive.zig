//! Transpiled from Horizon Rust crate
//! Module: horizon-mod-registry_archive
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The upload's zip, checked once before any kind's own reader opens it: every
//! reader (registry, launcher, game) then sees the same plain files.
//!
//! Refused: a local header that disagrees with the central directory (one
//! zip that reads as two), two entries for one path, overlapping entries,
//! symlinks and other special files, encrypted entries, and more entries or
//! declared bytes than any kind's reader takes.
// use std::{collections::HashSet, path::Path};

/// Entries: a content mod's 65 536 files and their folders.
pub const MAX_ENTRIES: usize = 100_000;
/// Declared uncompressed bytes: above every kind's own total (a content mod's
/// 512 MiB and a native bundle's 64 MiB).
pub const MAX_UNCOMPRESSED: u64 = 1 << 30;

/// File type bits of a Unix mode: a regular file, a folder, or none named.
pub const S_IFMT: u32 = 0o170000;
pub const S_IFREG: u32 = 0o100000;
pub const S_IFDIR: u32 = 0o040000;

pub fn check(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: check_with(path, MAX_ENTRIES, MAX_UNCOMPRESSED)
}

pub fn check_with(path: *Path, max_entries: usize, max_bytes: u64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = std::fs::File::open(path).map_err(|e| e.to_string())?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| format!("not a zip: {e}"))?;
    // rust: if zip.len() > max_entries {
    // rust: return Err(format!("over {max_entries} entries in the zip"));
}
    // Duplicate central names, local headers that differ from the central
    // directory (name, sizes, method, flags), entries sharing bytes.
    // rust: zip.validate_header_consistency()
    // rust: .map_err(|e| e.to_string())?;
    // rust: let mut seen = HashSet::new();
    // rust: let mut total = 0u64;
    // rust: for i in 0..zip.len() {
    // rust: let entry = zip.by_index_raw(i).map_err(|e| e.to_string())?;
    // rust: let name = entry.name().map_err(|e| e.to_string())?.into_owned();
    // rust: if entry
    // rust: .unix_mode()
    // rust: .is_some_and(|m| ![0, S_IFREG, S_IFDIR].contains(&(m & S_IFMT)))
    // rust: {
    // rust: return Err(format!("{name:?} is a symlink or special file"));
}
    // rust: if entry.encrypted() {
    // rust: return Err(format!("{name:?} is encrypted"));
}
        // One path on a case-insensitive disk, a file and a folder alike.
    // rust: if !seen.insert(name.trim_end_matches('/').to_lowercase()) {
    // rust: return Err(format!("{name:?} is in the zip twice"));
}
    // rust: total = total.saturating_add(entry.size());
    // rust: if total > max_bytes {
    // rust: return Err(format!("the zip expands beyond {} MiB", max_bytes >> 20));
}
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;
//     use std::io::{Cursor, Write};
//     use zip::{CompressionMethod, ZipWriter, write::SimpleFileOptions};

pub fn stored() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SimpleFileOptions::default().compression_method(CompressionMethod::Stored)
}

pub fn zip_of(files: *[([]const u8) void {
}
    // rust: let mut zip = ZipWriter::new(Cursor::new(Vec::new()));
    // rust: for (name, bytes) in files {
    // rust: zip.start_file(*name, stored()).unwrap();
    // rust: zip.write_all(bytes).unwrap();
}
    // rust: zip.finish().unwrap().into_inner()
}

    /// Replaces the `nth` (0-based, `None` = every) occurrence of `from` by
    /// `to` (same length): a name in a local header comes before its central
    /// directory record.
pub fn patch(bytes: []u8, from: []const u8, to: []const u8, nth: ?usize) void {
}
    // rust: assert_eq!(from.len(), to.len());
    // rust: let at: Vec<usize> = (0..=bytes.len() - from.len())
    // rust: .filter(|&i| &bytes[i..i + from.len()] == from)
    // rust: .collect();
    // rust: assert!(!at.is_empty());
    // rust: for (k, &i) in at.iter().enumerate() {
    // rust: if nth.is_none_or(|n| n == k) {
    // rust: bytes[i..i + to.len()].copy_from_slice(to);
}
}
}

pub fn checked(bytes: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: checked_with(bytes, MAX_ENTRIES, MAX_UNCOMPRESSED)
}

pub fn checked_with(bytes: []const u8, entries: usize, total: u64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "registry-archive-{}-{:?}",
    // rust: std::process::id(),
    // rust: std::thread::current().id()
    // rust: ));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let path = dir.join("upload.zip");
    // rust: std::fs::write(&path, bytes).unwrap();
    // rust: let result = check_with(&path, entries, total);
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: result
}

pub fn plain_files_and_folders_pass() void {
}
    // rust: let mut zip = ZipWriter::new(Cursor::new(Vec::new()));
    // rust: zip.add_directory("assets/", stored()).unwrap();
    // rust: zip.start_file("assets/a.png", stored()).unwrap();
    // rust: zip.write_all(b"png").unwrap();
    // rust: zip.start_file("horizon-mod.toml", SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(b"id = \"a\"").unwrap();
    // rust: assert_eq!(checked(&zip.finish().unwrap().into_inner()), Ok(()));
}

pub fn a_symlink_is_refused() void {
}
    // rust: let mut zip = ZipWriter::new(Cursor::new(Vec::new()));
    // rust: zip.start_file("a.txt", stored()).unwrap();
    // rust: zip.write_all(b"x").unwrap();
    // rust: zip.add_symlink("assets/link", "/etc/passwd", stored())
    // rust: .unwrap();
    // rust: let err = checked(&zip.finish().unwrap().into_inner()).unwrap_err();
    // rust: assert!(err.contains("\"assets/link\" is a symlink"), "{err}");
}

pub fn a_fifo_is_refused() void {
}
    // rust: let mut zip = ZipWriter::new(Cursor::new(Vec::new()));
    // rust: zip.start_file("pipe", stored().external_attributes(0o010644 << 16))
    // rust: .unwrap();
    // rust: let err = checked(&zip.finish().unwrap().into_inner()).unwrap_err();
    // rust: assert!(err.contains("special file"), "{err}");
}

    /// The central directory says `good.txt`, the local header `evil.txt`: a
    /// streaming reader would see another file than the checks did.
pub fn a_local_header_that_differs_is_refused() void {
}
    // rust: let mut bytes = zip_of(&[("good.txt", b"x")]);
    // rust: patch(&mut bytes, b"good.txt", b"evil.txt", Some(0));
    // rust: assert!(checked(&bytes).unwrap_err().contains("mismatch"));
}

pub fn two_entries_for_one_path_are_refused() void {
}
    // rust: let mut bytes = zip_of(&[("a.txt", b"one"), ("b.txt", b"two")]);
    // rust: patch(&mut bytes, b"b.txt", b"a.txt", None);
    // rust: assert!(checked(&bytes).unwrap_err().contains("duplicate"));
        // Two cases of one name are one file on macOS and Windows.
    // rust: let bytes = zip_of(&[("Data/x.json", b"{}"), ("data/X.json", b"{}")]);
    // rust: let err = checked(&bytes).unwrap_err();
    // rust: assert!(err.contains("\"data/X.json\" is in the zip twice"), "{err}");
}

pub fn an_encrypted_entry_is_refused() void {
}
    // rust: let mut bytes = zip_of(&[("a.txt", b"x")]);
        // Bit 0 of the general purpose flags, in the local header (offset 6)
        // and the central record (offset 8): the headers still agree.
    // rust: bytes[6] |= 1;
    // rust: let central = (0..bytes.len() - 4)
    // rust: .find(|&i| &bytes[i..i + 4] == b"PK\x01\x02")
    // rust: .unwrap();
    // rust: bytes[central + 8] |= 1;
    // rust: assert!(checked(&bytes).unwrap_err().contains("encrypted"));
}

pub fn entries_and_declared_size_are_capped() void {
}
    // rust: let bytes = zip_of(&[("a", b""), ("b", b""), ("c", b"")]);
    // rust: assert_eq!(checked_with(&bytes, 3, 1 << 20), Ok(()));
    // rust: assert!(
    // rust: checked_with(&bytes, 2, 1 << 20)
    // rust: .unwrap_err()
    // rust: .contains("over 2 entries")
    // rust: );
    // rust: let mut zip = ZipWriter::new(Cursor::new(Vec::new()));
    // rust: zip.start_file("big", SimpleFileOptions::default()).unwrap();
    // rust: zip.write_all(&vec![0; 3 << 20]).unwrap();
    // rust: let bytes = zip.finish().unwrap().into_inner();
    // rust: assert!(bytes.len() < 1 << 20);
    // rust: assert_eq!(checked_with(&bytes, 10, 4 << 20), Ok(()));
    // rust: let err = checked_with(&bytes, 10, 2 << 20).unwrap_err();
    // rust: assert!(err.contains("expands beyond 2 MiB"), "{err}");
}
}
