//! Transpiled from Horizon Rust crate
//! Module: horizon-mods_native
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Source-only native mixin bundles. Reading a bundle never executes its code.
// use super::{Facts, valid_id};
// use serde::{Deserialize, Serialize};
// use std::{collections::BTreeMap, io::Read, path::Path};

pub const MANIFEST: []const u8 = "horizon-native.json";

/// Why a native mod may not carry `mod.wasm`: WebAssembly mods don't run any more.
pub const WASM_GONE: []const u8 = "mod.wasm: WebAssembly mods don't run any more, port the code to a native mod (docs/native-mods.md)";

/// Whether `path` names a native mod's file: an `.hnmod`, or a `.hmod` holding native code
/// (one file for content and code, docs/native-mods.md).
pub fn is_file(path: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: path.extension()
    // rust: .is_some_and(|e| e == "hnmod" || e == "hmod")
}

/// Whether the mod file at `path` carries native code ([`MANIFEST`]): every `.hnmod`, and a
/// `.hmod` with code beside or instead of its content.
pub fn holds(path: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::fs::File::open(path)
    // rust: .ok()
    // rust: .and_then(|f| zip::ZipArchive::new(f).ok())
    // rust: .is_some_and(|mut zip| zip.by_name(MANIFEST).is_ok())
}

/// Whether a `.hmod`'s entry `name` is its content's (`horizon-mod.toml`, `assets/`, `data/`),
/// which [`crate::Content`] reads and checks, not the native build.
pub fn content(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name == crate::manifest::MANIFEST || name.starts_with("assets/") || name.starts_with("data/")
}

pub const Manifest = struct {
    schema: u32,
    id: []const u8,
    version: []const u8,
    game: []const u8,
    /// Exact source revisions tested together, never mutable tags.
    horizon: []const u8,
    mixins: []const u8,
    /// The version of Horizon's native hook points (`game/native_hooks.rs`,
    /// `NATIVE_HOOKS_API`) a mod that hooks nothing else needs: the launcher
    /// builds it on any Horizon with that version or a later one, and
    /// `horizon` is only the revision it was tested on.
    hooks: ?u32,
};

pub fn revision(value: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: value.len() == 40
    // rust: && value
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_digit() || (b'a'..=b'f').contains(&b))
}

    // rust: impl Manifest {
pub fn check(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.schema != 1
    // rust: || !valid_id(&self.id)
    // rust: || self.version.is_empty()
    // rust: || self.game.is_empty()
    // rust: || !revision(&self.horizon)
    // rust: || !revision(&self.mixins)
    // rust: || self.hooks == Some(0)
    // rust: {
    // rust: return Err(
    // rust: "invalid native manifest: schema 1, id, version, game and exact revisions required"
    // rust: .into(),
    // rust: );
}
    // rust: Ok(())
}

    /// Carries the exact native compatibility contract in the index's API field.
pub fn api(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("native-1/{}/{}", self.horizon, self.mixins)
}

pub fn facts(self: *Self) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Facts {
    // rust: id: Some(self.id.clone()),
    // rust: version: Some(self.version.clone()),
    // rust: api: self.api(),
    // rust: game: Some(self.game.clone()),
    // rust: hooks: self.hooks,
    // rust: ..Facts::default()
}
}
}

pub const Bundle = struct {
    manifest: Manifest,
    /// Validated relative paths: Rust and TOML, plus files under `mixins/<id>/data/` or a
    /// `data/` folder deeper in (a crate's). A `.hmod`'s content files are not among them.
    files: BTreeMap<[]const u8,
};

/// Whether `rest` (a path inside `mixins/<id>/`) is a data file: under the bundle's `data/`, or
/// under the top-level `data/` of a folder of it (a crate's, `engine/data/`), not any folder
/// named `data` deeper in.
pub fn in_data(rest: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let parts: Vec<&str> = rest.split('/').collect();
    // rust: parts.len() >= 2 && (parts[0] == "data" || (parts.len() >= 3 && parts[1] == "data"))
}

/// Whether `rest` is one of the text files a crate folder usually carries, which a crate may need
/// to compile (`#![doc = include_str!("../README.md")]`): `README*`, `LICENSE*`, `COPYING*`,
/// `NOTICE*` and `.gitignore`, in the bundle's folder or a top-level folder of it.
pub fn text(rest: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let parts: Vec<&str> = rest.split('/').collect();
    // rust: let name = parts[parts.len() - 1];
    // rust: parts.len() <= 2
    // rust: && (["README", "LICENSE", "LICENCE", "COPYING", "NOTICE"]
    // rust: .iter()
    // rust: .any(|p| name.starts_with(p))
    // rust: || name == ".gitignore")
}

/// Whether a bundle may carry the file `rest` (its path under `mixins/<id>/`): sources and
/// manifests, data, and the text files of a crate folder.
pub fn allowed(rest: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: rest.ends_with(".rs") || rest.ends_with(".toml") || in_data(rest) || text(rest)
}

    // rust: impl Bundle {
pub fn read(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = std::fs::File::open(path).map_err(|e| e.to_string())?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| e.to_string())?;
    // rust: let mut files = BTreeMap::new();
    // rust: let mut content_id = None;
    // rust: let mut total = 0u64;
    // rust: for i in 0..zip.len() {
    // rust: let mut entry = zip.by_index(i).map_err(|e| e.to_string())?;
    // rust: let name = entry.name().map_err(|e| e.to_string())?.into_owned();
    // rust: if entry.is_dir() {
    // rust: continue;
}
    // rust: if entry
    // rust: .unix_mode()
    // rust: .is_some_and(|m| m & 0o170000 != 0 && m & 0o170000 != 0o100000)
    // rust: || name.contains('\\')
    // rust: || name
    // rust: .split('/')
    // rust: .any(|p| p.is_empty() || p == "." || p == "..")
    // rust: || name.starts_with('/')
    // rust: || name.contains(':')
    // rust: {
    // rust: return Err(format!("invalid native bundle path: {name}"));
}
    // rust: if name == crate::manifest::WASM {
    // rust: return Err(WASM_GONE.into());
}
    // rust: if content(&name) {
    // rust: if name == crate::manifest::MANIFEST {
    // rust: let mut text = String::new();
    // rust: (&mut entry)
    // rust: .take(1 << 20)
    // rust: .read_to_string(&mut text)
    // rust: .map_err(|e| format!("{name}: {e}"))?;
    // rust: content_id = Some(crate::Manifest::parse(&text)?.id);
}
    // rust: continue;
}
    // rust: if files.len() >= 512 {
    // rust: return Err("native bundle has too many entries".into());
}
    // rust: let mut bytes = Vec::new();
    // rust: (&mut entry)
    // rust: .take(super::MAX_FILE + 1)
    // rust: .read_to_end(&mut bytes)
    // rust: .map_err(|e| e.to_string())?;
    // rust: total += bytes.len() as u64;
    // rust: if total > super::MAX_FILE {
    // rust: return Err("native bundle expands beyond 64 MiB".into());
}
    // rust: if files.insert(name, bytes).is_some() {
    // rust: return Err("duplicate native bundle path".into());
}
}
    // rust: let manifest: Manifest =
    // rust: serde_json::from_slice(files.get(MANIFEST).ok_or("missing horizon-native.json")?)
    // rust: .map_err(|e| e.to_string())?;
    // rust: manifest.check()?;
    // rust: if let Some(id) = content_id.filter(|id| *id != manifest.id) {
    // rust: return Err(format!(
    // rust: "its {} is mod {id}, its {MANIFEST} {}: one file is one mod",
    // rust: crate::manifest::MANIFEST,
    // rust: manifest.id
    // rust: ));
}
    // rust: let prefix = format!("mixins/{}/", manifest.id);
    // rust: for name in files.keys().filter(|n| n.as_str() != MANIFEST) {
    // rust: let Some(rest) = name.strip_prefix(&prefix) else {
    // rust: return Err(format!("unexpected native source: {name}"));
}
    // rust: if !allowed(rest) {
    // rust: return Err(format!("unexpected native source: {name}"));
}
}
    // rust: let source = files
    // rust: .get(&format!("{prefix}horizon-mixin.toml"))
    // rust: .ok_or("missing horizon-mixin.toml")?;
    // rust: let source: toml::Value =
    // rust: toml::from_str(std::str::from_utf8(source).map_err(|e| e.to_string())?)
    // rust: .map_err(|e| e.to_string())?;
    // rust: if source
    // rust: .get("mod")
    // rust: .and_then(|v| v.get("id"))
    // rust: .and_then(|v| v.as_str())
    // rust: != Some(&manifest.id)
    // rust: || source
    // rust: .get("mod")
    // rust: .and_then(|v| v.get("version"))
    // rust: .and_then(|v| v.as_str())
    // rust: != Some(&manifest.version)
    // rust: || source
    // rust: .get("compatibility")
    // rust: .and_then(|v| v.get("horizon_revision"))
    // rust: .and_then(|v| v.as_str())
    // rust: != Some(&manifest.horizon)
    // rust: {
    // rust: return Err("native manifest and mixin identity/revision differ".into());
}
    // rust: Ok(Self { manifest, files })
}
}

    // rust: mod tests {
//     use super::*;
//     use std::io::Write;

pub fn manifest() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Manifest {
    // rust: schema: 1,
    // rust: id: "veinminer".into(),
    // rust: version: "0.3.0".into(),
    // rust: game: "26.3".into(),
    // rust: horizon: "a".repeat(40),
    // rust: mixins: "b".repeat(40),
    // rust: hooks: None,
}
}
pub fn read(name: []const u8, extras: *[([]const u8) void {
}
    // rust: let path =
    // rust: std::env::temp_dir().join(format!("native-bundle-{name}-{}.hnmod", std::process::id()));
    // rust: let mut zip = zip::ZipWriter::new(std::fs::File::create(&path).unwrap());
    // rust: let options = zip::write::SimpleFileOptions::default();
    // rust: zip.start_file(MANIFEST, options).unwrap();
    // rust: zip.write_all(&serde_json::to_vec(&manifest()).unwrap())
    // rust: .unwrap();
    // rust: zip.start_file("mixins/veinminer/horizon-mixin.toml", options)
    // rust: .unwrap();
    // rust: zip.write_all(mixin.as_bytes()).unwrap();
    // rust: for (name, bytes) in extras {
    // rust: zip.start_file(*name, options).unwrap();
    // rust: zip.write_all(bytes).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: let result = Bundle::read(&path);
    // rust: std::fs::remove_file(path).unwrap();
    // rust: result
}
pub fn mixin() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!(
    // rust: "[mod]\nid = \"veinminer\"\nversion = \"0.3.0\"\n[compatibility]\nhorizon_revision = \"{}\"\n",
    // rust: "a".repeat(40)
    // rust: )
}
pub fn source_bundle_carries_exact_compatibility_into_index_facts() void {
}
    // rust: let bundle = read(
    // rust: "valid",
    // rust: &[("mixins/veinminer/hook.rs", b"fn hook() {}")],
    // rust: &mixin(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(bundle.manifest, manifest());
    // rust: let facts = bundle.manifest.facts();
    // rust: assert_eq!(
    // rust: facts.api,
    // rust: format!("native-1/{}/{}", "a".repeat(40), "b".repeat(40))
    // rust: );
    // rust: assert_eq!(facts.id.as_deref(), Some("veinminer"));
    // rust: assert!(facts.capabilities.is_empty());
}
pub fn accepts_binary_data_in_the_bundle_data_directory() void {
}
    // rust: let bytes = [0, 255, 42];
    // rust: let bundle = read(
    // rust: "data",
    // rust: &[
    // rust: ("mixins/veinminer/data/nested/table.bin", &bytes),
    // rust: ("mixins/veinminer/engine/data/model.bin", &bytes),
    // rust: ("mixins/veinminer/engine/README.md", b"# engine"),
    // rust: ("mixins/veinminer/engine/LICENSE-MIT", b"MIT"),
    // rust: ("mixins/veinminer/.gitignore", b"target/"),
    // rust: ],
    // rust: &mixin(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: bundle.files["mixins/veinminer/data/nested/table.bin"],
    // rust: bytes
    // rust: );
}
pub fn rejects_path_traversal_and_non_source_payloads() void {
}
    // rust: for (i, name) in [
    // rust: "../escape.rs",
    // rust: "/absolute.rs",
    // rust: "mixins/other/hook.rs",
    // rust: "mixins/veinminer/code.dll",
    // rust: "mixins/veinminer/data/../code.dll",
    // rust: "mixins/veinminer/database/file.bin",
    // rust: "mixins/veinminer/engine/data.bin",
    // rust: "mixins/veinminer/engine/src/data/blob.bin",
    // rust: "mixins/veinminer/engine/src/README.md",
    // rust: "mixins/veinminer/engine/README.dll/x.bin",
    // rust: "mixins/veinminer/engine/Cargo.lock",
    // rust: "mixins/other/data/file.bin",
    // rust: "mixins\\veinminer\\hook.rs",
    // rust: ]
    // rust: .iter()
    // rust: .enumerate()
    // rust: {
    // rust: assert!(read(&format!("bad-path-{i}"), &[(name, b"bad")], &mixin()).is_err());
}
}
pub fn one_hmod_carries_content_beside_its_native_code() void {
}
    // rust: let toml = r#"id = "veinminer"
    // rust: name = "Veinminer"
    // rust: version = "0.3.0"
    // rust: api = "0.2"
    // rust: capabilities = ["registries"]
    // rust: "#;
    // rust: let bundle = read(
    // rust: "unified",
    // rust: &[
    // rust: ("horizon-mod.toml", toml.as_bytes()),
    // rust: ("assets/veinminer/lang/en_us.json", b"{}"),
    // rust: ("data/veinminer/tags/item/ores.json", b"{}"),
    // rust: ("mixins/veinminer/hook.rs", b"fn hook() {}"),
    // rust: ],
    // rust: &mixin(),
    // rust: )
    // rust: .unwrap();
    // rust: let names: Vec<&str> = bundle.files.keys().map(String::as_str).collect();
    // rust: assert_eq!(
    // rust: names,
    // rust: [
    // rust: MANIFEST,
    // rust: "mixins/veinminer/hook.rs",
    // rust: "mixins/veinminer/horizon-mixin.toml"
    // rust: ]
    // rust: );
    // rust: let other = toml.replace(r#""veinminer""#, r#""other""#);
    // rust: let e = read(
    // rust: "two-ids",
    // rust: &[("horizon-mod.toml", other.as_bytes())],
    // rust: &mixin(),
    // rust: )
    // rust: .err()
    // rust: .unwrap();
    // rust: assert!(e.contains("one file is one mod"), "{e}");
    // rust: let e = read("wasm", &[("mod.wasm", b"\0asm")], &mixin())
    // rust: .err()
    // rust: .unwrap();
    // rust: assert_eq!(e, WASM_GONE);
}
pub fn rejects_missing_or_mismatched_mixin_identity_without_panicking() void {
}
    // rust: assert!(read("missing-mod", &[], "[unrelated]\nvalue = 1").is_err());
    // rust: assert!(
    // rust: read(
    // rust: "wrong-revision",
    // rust: &[],
    // rust: &mixin().replace(&"a".repeat(40), &"c".repeat(40))
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: assert!(read("wrong-version", &[], &mixin().replace("0.3.0", "0.2.0")).is_err());
    // rust: assert!(
    // rust: Manifest {
    // rust: horizon: "nightly".into(),
    // rust: ..manifest()
}
    // rust: .check()
    // rust: .is_err()
    // rust: );
}
pub fn hooks_is_optional_and_kept() void {
}
    // rust: let hooked = Manifest {
    // rust: hooks: Some(1),
    // rust: ..manifest()
}
    // rust: assert!(hooked.check().is_ok());
    // rust: let text = serde_json::to_string(&hooked).unwrap();
    // rust: assert!(text.contains("\"hooks\":1"), "{text}");
    // rust: assert_eq!(serde_json::from_str::<Manifest>(&text).unwrap(), hooked);
    // rust: let plain = serde_json::to_string(&manifest()).unwrap();
    // rust: assert!(!plain.contains("hooks"), "{plain}");
    // rust: let zero = Manifest {
    // rust: hooks: Some(0),
    // rust: ..manifest()
}
    // rust: assert!(zero.check().is_err());
}
}
