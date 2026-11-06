//! Transpiled from Horizon Rust crate
//! Module: horizon-shader-api_package
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A shader pack on disk: a folder holding `horizon-shaders.toml`, or the
//! same files zipped as a `.hshader` (what the registry and the launcher
//! carry). Both read into one [`Pack`].
// use crate::manifest::{MANIFEST, Manifest};
// use std::{
    // rust: collections::BTreeMap,
    // rust: io::{Read, Write},
    // rust: path::Path,
}

/// A packaged pack's extension.
pub const EXTENSION: []const u8 = "hshader";
/// Bytes per WGSL file, per other file, and in all.
pub const MAX_WGSL: u64 = 256 << 10;
pub const MAX_OTHER: u64 = 1 << 20;
pub const MAX_TOTAL: u64 = 8 << 20;
/// Files in a `.hshader`.
pub const MAX_ENTRIES: usize = 512;
/// Files a pack may hold beside its manifest and WGSL.
    // rust: const EXTRAS: [&str; 5] = [
    // rust: "README.md",
    // rust: "LICENSE",
    // rust: "LICENSE.md",
    // rust: "LICENSE.txt",
    // rust: "icon.png",
    // rust: ];

/// A pack read from a folder or a `.hshader`: its manifest and every file,
/// by path from the pack's root (`/`-separated).
pub const Pack = struct {
    manifest: Manifest,
    files: BTreeMap<[]const u8,
};

/// A relative path made of plain parts: no root, `..`, `\`, empty or
/// hidden parts.
pub fn plain_path(path: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !path.is_empty()
    // rust: && path.split('/').all(|part| {
    // rust: !part.is_empty()
    // rust: && !part.starts_with('.')
    // rust: && part
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_alphanumeric() || b"._-".contains(&b))
    // rust: })
}

/// Whether `path` is a pack of this format: a folder holding
/// `horizon-shaders.toml`, or a `.hshader` file.
pub fn is_pack(path: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: path.join(MANIFEST).is_file()
    // rust: || (path.is_file() && path.extension().is_some_and(|e| e == EXTENSION))
}

    // rust: impl Pack {
    /// Reads `path`: a `.hshader` file, or a folder (its hidden files and
    /// folders, such as `.git`, are skipped).
pub fn read(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut files = BTreeMap::new();
    // rust: if path.is_dir() {
    // rust: read_dir(path, "", &mut files)?;
    // rust: } else {
    // rust: let file = std::fs::File::open(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let mut zip = zip::ZipArchive::new(file)
    // rust: .map_err(|e| format!("{}: not a .{EXTENSION} (zip): {e}", path.display()))?;
    // rust: if zip.len() > MAX_ENTRIES {
    // rust: return Err(format!("over {MAX_ENTRIES} files in the package"));
}
    // rust: for i in 0..zip.len() {
    // rust: let mut entry = zip.by_index(i).map_err(|e| e.to_string())?;
    // rust: if entry.is_dir() {
    // rust: continue;
}
    // rust: let name = entry.name().map_err(|e| e.to_string())?.into_owned();
    // rust: let mut bytes = Vec::new();
    // rust: (&mut entry)
    // rust: .take(MAX_OTHER.max(MAX_WGSL) + 1)
    // rust: .read_to_end(&mut bytes)
    // rust: .map_err(|e| format!("{name}: {e}"))?;
    // rust: if files.insert(name.clone(), bytes).is_some() {
    // rust: return Err(format!("{name} is in the package twice"));
}
}
}
    // rust: Pack::from_files(files)
}

    /// Checks a pack's files: a manifest, the WGSL it names (as UTF-8),
    /// nothing it doesn't use, and sizes within bounds.
pub fn from_files(files: BTreeMap<[]const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = files
    // rust: .get(MANIFEST)
    // rust: .ok_or_else(|| format!("{MANIFEST}: missing at the pack's root"))?;
    // rust: let manifest = Manifest::parse(
    // rust: std::str::from_utf8(text).map_err(|_| format!("{MANIFEST}: not UTF-8"))?,
    // rust: )?;
    // rust: let used = manifest.files();
    // rust: let mut total = 0;
    // rust: for (name, bytes) in &files {
    // rust: if !plain_path(name) {
    // rust: return Err(format!("{name:?} is not a plain path"));
}
    // rust: let size = bytes.len() as u64;
    // rust: total += size;
    // rust: let max = if name.ends_with(".wgsl") {
    // rust: if !used.contains(&name.as_str()) {
    // rust: return Err(format!("{name} is not used by any stage or in shared"));
}
    // rust: if std::str::from_utf8(bytes).is_err() {
    // rust: return Err(format!("{name}: not UTF-8"));
}
    // rust: MAX_WGSL
    // rust: } else if name == MANIFEST
    // rust: || EXTRAS.contains(&name.as_str())
    // rust: || manifest.textures.iter().any(|t| &t.file == name)
    // rust: {
    // rust: MAX_OTHER
    // rust: } else {
    // rust: return Err(format!(
    // rust: "{name}: a pack holds only {MANIFEST}, .wgsl files, its [[textures]] and {}",
    // rust: EXTRAS.join(", ")
    // rust: ));
}
    // rust: if size > max {
    // rust: return Err(format!("{name} is over {} KiB", max >> 10));
}
}
    // rust: if total > MAX_TOTAL {
    // rust: return Err(format!("the pack is over {} MiB", MAX_TOTAL >> 20));
}
    // rust: if let Some(t) = manifest
    // rust: .textures
    // rust: .iter()
    // rust: .find(|t| !files.contains_key(&t.file))
    // rust: {
    // rust: return Err(format!("{}: named in {MANIFEST} but missing", t.file));
}
    // rust: if let Some(missing) = used.iter().find(|f| !files.contains_key(**f)) {
    // rust: return Err(format!("{missing}: named in {MANIFEST} but missing"));
}
    // rust: Ok(Pack { manifest, files })
}

    /// The bytes of the pack's file `file` (a `[[textures]]` image).
pub fn source_bytes(self: *Self, file: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.files.get(file).map(Vec::as_slice)
}

    /// A WGSL file's text (every file the manifest names is checked UTF-8).
pub fn source(self: *Self, file: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.files
    // rust: .get(file)
    // rust: .and_then(|b| std::str::from_utf8(b).ok())
}

    /// The `.hshader` bytes: the files in path order, with fixed times and
    /// permissions, so the same pack always gives the same bytes (and the
    /// same SHA-256).
pub fn package(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut zip = zip::ZipWriter::new(std::io::Cursor::new(Vec::new()));
    // rust: let options = zip::write::SimpleFileOptions::default()
    // rust: .compression_method(zip::CompressionMethod::Deflated)
    // rust: .last_modified_time(zip::DateTime::default())
    // rust: .unix_permissions(0o644);
    // rust: let err = |e: zip::result::ZipError| e.to_string();
    // rust: for (name, bytes) in &self.files {
    // rust: zip.start_file(name.as_str(), options).map_err(err)?;
    // rust: zip.write_all(bytes).map_err(|e| e.to_string())?;
}
    // rust: Ok(zip.finish().map_err(err)?.into_inner())
}

    /// The SHA-256 of [`Pack::package`], in lowercase hex: the pack's
    /// identity in the registry.
pub fn sha256(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(sha256_hex(&self.package()?))
}
}

/// SHA-256 in lowercase hex.
pub fn sha256_hex(bytes: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
//     use sha2::Digest;
    // rust: sha2::Sha256::digest(bytes)
    // rust: .iter()
    // rust: .map(|b| format!("{b:02x}"))
    // rust: .collect()
}

pub fn read_dir(dir: *Path, prefix: []const u8, files: *mut BTreeMap<[]const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entries = std::fs::read_dir(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
    // rust: for entry in entries {
    // rust: let entry = entry.map_err(|e| format!("{}: {e}", dir.display()))?;
    // rust: let name = entry.file_name().to_string_lossy().into_owned();
    // rust: if name.starts_with('.') {
    // rust: continue;
}
    // rust: let path = entry.path();
    // rust: let rel = format!("{prefix}{name}");
    // rust: if path.is_dir() {
    // rust: read_dir(&path, &format!("{rel}/"), files)?;
    // rust: } else {
    // rust: let size = entry.metadata().map_err(|e| format!("{rel}: {e}"))?.len();
    // rust: if size > MAX_TOTAL {
    // rust: return Err(format!("{rel} is over {} MiB", MAX_TOTAL >> 20));
}
    // rust: let bytes = std::fs::read(&path).map_err(|e| format!("{rel}: {e}"))?;
    // rust: files.insert(rel, bytes);
}
}
    // rust: Ok(())
}
