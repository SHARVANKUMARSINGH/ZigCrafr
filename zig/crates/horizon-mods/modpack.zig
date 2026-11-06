//! Transpiled from Horizon Rust crate
//! Module: horizon-mods_modpack
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `.hpack`, a Horizon modpack (docs/api/mod-index.md): registry mods
//! played together as a profile. A zip holding `horizon-modpack.toml`, which
//! names each mod by id, version and SHA-256 (the files themselves come from
//! the registry), and optionally `overrides/`: settings and resource packs
//! copied into the profile's game folder.
// use crate::manifest::STORAGE_DIR;
// use serde::Deserialize;
// use std::{
    // rust: io::Read,
    // rust: path::{Path, PathBuf},
}

/// The manifest's file name in a `.hpack`.
pub const MANIFEST: []const u8 = "horizon-modpack.toml";
/// The manifest formats this build reads.
pub const FORMAT: u32 = 1;
pub const OVERRIDES: []const u8 = "overrides/";
/// Bytes per override file and in all, unpacked.
pub const MAX_OVERRIDE: u64 = 64 << 20;
pub const MAX_OVERRIDES: u64 = 256 << 20;
/// The settings files an override may replace.
pub const SETTINGS: [[]const u8; 3] = ["options.txt", "horizon-graphics.txt", "horizon-extras.txt"];

pub const Manifest = struct {
    format: u32,
    /// `[a-z0-9_]{1,64}`: its profile's folder.
    id: []const u8,
    name: []const u8,
    version: []const u8,
    description: []const u8,
    authors: std.ArrayList([]const u8),
    /// The Minecraft version it is for.
    game: []const u8,
    mods: std.ArrayList(PackMod),
};

pub const PackMod = struct {
    id: []const u8,
    version: []const u8,
    sha256: []const u8,
    /// Turned on in the profile (`horizon-mods.txt`).
    on: bool,
};

pub fn on() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}

    // rust: impl PackMod {
pub fn requirement(self: *Self) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::index::Requirement {
    // rust: id: self.id.clone(),
    // rust: version: self.version.clone(),
    // rust: sha256: self.sha256.clone(),
}
}
}

    // rust: impl Manifest {
pub fn parse(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let m: Manifest = toml::from_str(text).map_err(|e| format!("{MANIFEST}: {e}"))?;
    // rust: if m.format != FORMAT {
    // rust: return Err(format!(
    // rust: "{MANIFEST}: format {}; this Horizon reads {FORMAT}",
    // rust: m.format
    // rust: ));
}
    // rust: let id_ok = |id: &str| {
    // rust: (1..=64).contains(&id.len())
    // rust: && id
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_')
}
    // rust: if !id_ok(&m.id) {
    // rust: return Err(format!(
    // rust: "{MANIFEST}: id {:?} is not [a-z0-9_]{{1,64}}",
    // rust: m.id
    // rust: ));
}
    // rust: for (i, pm) in m.mods.iter().enumerate() {
    // rust: let hex = pm.sha256.len() == 64
    // rust: && pm
    // rust: .sha256
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_digit() || (b'a'..=b'f').contains(&b));
    // rust: if !id_ok(&pm.id) || !hex || pm.version.is_empty() {
    // rust: return Err(format!(
    // rust: "{MANIFEST}: mod {:?} needs an id, a version and a lowercase hex sha256",
    // rust: pm.id
    // rust: ));
}
    // rust: if m.mods[..i].iter().any(|other| other.id == pm.id) {
    // rust: return Err(format!("{MANIFEST}: mod {} is listed twice", pm.id));
}
}
    // rust: Ok(m)
}
}

/// A `.hpack` as read from disk: its manifest and its override files, by
/// path under `overrides/`.
pub const Modpack = struct {
    manifest: Manifest,
    overrides: std.ArrayList([]const u8),
};

    // rust: impl Modpack {
pub fn read(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = std::fs::File::open(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| e.to_string())?;
    // rust: let mut text = String::new();
    // rust: zip.by_name(MANIFEST)
    // rust: .map_err(|_| format!("{MANIFEST}: missing"))?
    // rust: .take(1 << 20)
    // rust: .read_to_string(&mut text)
    // rust: .map_err(|e| format!("{MANIFEST}: {e}"))?;
    // rust: let manifest = Manifest::parse(&text)?;
    // rust: let (mut overrides, mut total) = (Vec::new(), 0u64);
    // rust: for i in 0..zip.len() {
    // rust: let entry = zip.by_index_raw(i).map_err(|e| e.to_string())?;
    // rust: let name = entry.name().map_err(|e| e.to_string())?.into_owned();
    // rust: if name == MANIFEST || entry.is_dir() {
    // rust: continue;
}
    // rust: let Some(rest) = name.strip_prefix(OVERRIDES) else {
    // rust: return Err(format!(
    // rust: "{name}: a modpack holds only {MANIFEST} and overrides/"
    // rust: ));
}
    // rust: check_override(rest, &manifest)?;
    // rust: if entry.size() > MAX_OVERRIDE {
    // rust: return Err(format!("{name} is over {} MiB", MAX_OVERRIDE >> 20));
}
    // rust: total += entry.size();
    // rust: overrides.push(rest.to_owned());
}
    // rust: if total > MAX_OVERRIDES {
    // rust: return Err(format!("overrides are over {} MiB", MAX_OVERRIDES >> 20));
}
    // rust: overrides.sort();
    // rust: Ok(Modpack {
    // rust: manifest,
    // rust: overrides,
    // rust: })
}

    /// Writes the overrides of the pack at `path` into the game folder
    /// `home`, each checked again.
pub fn extract_overrides(path: *Path, home: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pack = Modpack::read(path)?;
    // rust: let file = std::fs::File::open(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| e.to_string())?;
    // rust: let mut written = Vec::new();
    // rust: let mut total = 0u64;
    // rust: for name in &pack.overrides {
            // A zip's declared sizes are the pack's own claim, so the limits
            // are counted again on the bytes actually inflated.
    // rust: let result = Self::extract_one(&mut zip, name, home, &mut total);
    // rust: match result {
    // rust: Ok(target) => written.push(target),
    // rust: Err(e) => {
    // rust: for target in &written {
    // rust: let _ = std::fs::remove_file(target);
}
    // rust: return Err(e);
}
}
}
    // rust: Ok(written)
}

    // rust: fn extract_one(
    // rust: zip: &mut zip::ZipArchive<std::fs::File>,
    // rust: name: &str,
    // rust: home: &Path,
    // rust: total: &mut u64,
    // rust: ) -> Result<PathBuf, String> {
    // rust: let mut entry = zip
    // rust: .by_name(&format!("{OVERRIDES}{name}"))
    // rust: .map_err(|e| format!("{name}: {e}"))?;
    // rust: let target = home.join(name);
    // rust: if let Some(dir) = target.parent() {
    // rust: std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
}
    // rust: let mut out =
    // rust: std::fs::File::create(&target).map_err(|e| format!("{}: {e}", target.display()))?;
    // rust: let copied = std::io::copy(&mut (&mut entry).take(MAX_OVERRIDE + 1), &mut out)
    // rust: .map_err(|e| format!("{}: {e}", target.display()))?;
    // rust: *total += copied;
    // rust: if copied > MAX_OVERRIDE || *total > MAX_OVERRIDES {
    // rust: let _ = std::fs::remove_file(&target);
    // rust: return Err(if copied > MAX_OVERRIDE {
    // rust: format!("{name} is over {} MiB", MAX_OVERRIDE >> 20)
    // rust: } else {
    // rust: format!("overrides are over {} MiB", MAX_OVERRIDES >> 20)
    // rust: });
}
    // rust: Ok(target)
}
}

/// An override's path under `overrides/`: a settings file, a resource pack
/// zip, or the stored settings of one of the pack's mods. Plain parts only.
pub fn check_override(path: []const u8, manifest: *Manifest) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bad = || {
    // rust: format!(
    // rust: "overrides/{path}: only {}, resourcepacks/<name>.zip and horizon-mods/{STORAGE_DIR}/<a listed mod>/ may be overridden",
    // rust: SETTINGS.join(", ")
    // rust: )
}
    // rust: let parts: Vec<&str> = path.split('/').collect();
    // rust: let plain = |p: &&str| {
    // rust: !p.is_empty()
    // rust: && !p.starts_with('.')
    // rust: && p.bytes()
    // rust: .all(|b| b.is_ascii_alphanumeric() || b"._-+ ".contains(&b))
}
    // rust: let ok = match parts.as_slice() {
    // rust: [file] => SETTINGS.contains(file),
    // rust: ["resourcepacks", name] => plain(name) && name.ends_with(".zip"),
    // rust: ["horizon-mods", dir, id, rest @ ..] => {
    // rust: *dir == STORAGE_DIR
    // rust: && manifest.mods.iter().any(|m| m.id == *id)
    // rust: && !rest.is_empty()
    // rust: && rest.iter().all(plain)
}
    // rust: _ => false,
}
    // rust: if ok { Ok(()) } else { Err(bad()) }
}

    // rust: mod tests {
//     use super::*;
//     use std::io::Write;

    // rust: const PACK: &str = r#"
    // rust: format = 1
    // rust: id = "cozy"
    // rust: name = "Cozy"
    // rust: version = "1.0.0"
    // rust: game = "26.3"
    // rust: [[mods]]
    // rust: id = "coords_hud"
    // rust: version = "0.1.0"
    // rust: sha256 = "0000000000000000000000000000000000000000000000000000000000000000"
    // rust: "#;

pub fn write_pack(dir: *Path, manifest: []const u8, files: *[([]const u8) void {
}
    // rust: let path = dir.join("cozy.hpack");
    // rust: let mut zip = zip::ZipWriter::new(std::fs::File::create(&path).unwrap());
    // rust: let options = zip::write::SimpleFileOptions::default();
    // rust: zip.start_file(MANIFEST, options).unwrap();
    // rust: zip.write_all(manifest.as_bytes()).unwrap();
    // rust: for (name, bytes) in files {
    // rust: zip.start_file(*name, options).unwrap();
    // rust: zip.write_all(bytes).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: path
}

pub fn scratch(name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-hpack-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

pub fn reads_a_pack_and_writes_its_overrides() void {
}
    // rust: let dir = scratch("read");
    // rust: let storage = format!("overrides/horizon-mods/{STORAGE_DIR}/coords_hud/corner.txt");
    // rust: let path = write_pack(
    // rust: &dir,
    // rust: PACK,
    // rust: &[
    // rust: ("overrides/options.txt", b"renderDistance:8\n"),
    // rust: ("overrides/resourcepacks/Cozy Look.zip", b"zip"),
    // rust: (&storage, b"top-left"),
    // rust: ],
    // rust: );
    // rust: let pack = Modpack::read(&path).unwrap();
    // rust: assert_eq!(pack.manifest.mods[0].id, "coords_hud");
    // rust: assert!(pack.manifest.mods[0].on);
    // rust: assert_eq!(pack.overrides.len(), 3);
    // rust: let home = dir.join("home");
    // rust: Modpack::extract_overrides(&path, &home).unwrap();
    // rust: let options = std::fs::read_to_string(home.join("options.txt")).unwrap();
    // rust: assert_eq!(options, "renderDistance:8\n");
    // rust: let corner = home.join(format!("horizon-mods/{STORAGE_DIR}/coords_hud/corner.txt"));
    // rust: assert!(corner.is_file());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn refuses_what_a_pack_may_not_hold() void {
}
    // rust: let dir = scratch("refuse");
    // rust: for name in [
    // rust: "mods/evil.jar",
    // rust: "overrides/../../.bashrc",
    // rust: "overrides/horizon-mods/evil.hmod",
    // rust: "overrides/resourcepacks/../options.txt",
    // rust: "overrides/servers.dat",
    // rust: "overrides/horizon-mods/.horizon-mod-data/other_mod/x",
    // rust: "overrides/resourcepacks/.hidden.zip",
    // rust: ] {
    // rust: let path = write_pack(&dir, PACK, &[(name, b"x")]);
    // rust: assert!(Modpack::read(&path).is_err(), "{name} was accepted");
}
    // rust: let twice = format!("{PACK}{}", &PACK[PACK.find("[[mods]]").unwrap()..]);
    // rust: assert!(Manifest::parse(&twice).unwrap_err().contains("twice"));
    // rust: let newer = PACK.replace("format = 1", "format = 2");
    // rust: assert!(Manifest::parse(&newer).unwrap_err().contains("format 2"));
    // rust: let short = PACK.replace("0000000000000000", "00");
    // rust: assert!(Manifest::parse(&short).is_err());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
