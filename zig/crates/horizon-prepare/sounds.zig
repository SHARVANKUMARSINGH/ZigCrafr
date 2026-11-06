//! Transpiled from Horizon Rust crate
//! Module: horizon-prepare_sounds
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The pinned version's sounds, title panorama, Unifont glyphs and built-in resource packs
//! from the player's own launcher install, each object checked against the asset index's SHA-1, copied into
//! `.local/horizon-client/<version>/assets` where the game reads them (tools/fetch_sounds.py and
//! the tools/lab.py functions it called). Nothing is downloaded.

// use crate::artifacts::{self, Inputs, Lock};
// use crate::pyjson::Value;
// use crate::{digest, Log};
// use std::collections::{HashMap, HashSet};
// use std::fs;
// use std::path::{Path, PathBuf};

/// The launcher's asset directory and the pinned version's asset index (tools/lab.py
/// `launcher_assets`). Mojang republishes a version's index under the same id for translation
/// fixes, and a launcher keeps only the last one it downloaded (#1076): an index the lock does
/// not know is still used, with a line in the log, since every object copied from it is
/// checked against its own SHA-1.
    // rust: fn launcher_assets(
    // rust: lock: &Lock,
    // rust: manifest: &Value,
    // rust: files: &artifacts::GameFiles,
    // rust: cached_index: &Path,
    // rust: log: Log,
    // rust: ) -> Result<(PathBuf, PathBuf, Vec<u8>), String> {
    // rust: let assets = files.assets.clone();
    // rust: let info = manifest
    // rust: .get("assetIndex")
    // rust: .ok_or("The version JSON has no assetIndex")?;
    // rust: let field = |key: &str| {
    // rust: info.get(key)
    // rust: .and_then(Value::as_str)
    // rust: .ok_or_else(|| format!("The version JSON's assetIndex has no {key}"))
}
    // rust: let (id, sha1) = (field("id")?, field("sha1")?);
    // rust: if artifacts::safe_relative(id).is_none_or(|p| p.components().count() != 1) {
    // rust: return Err(format!("Unsafe asset index id {id:?}"));
}
    // rust: let mut index = assets.join("indexes").join(format!("{id}.json"));
    // rust: if !index.is_file() && cached_index.is_file() {
    // rust: index = cached_index.to_path_buf();
}
    // rust: if !index.is_file() {
    // rust: let version = manifest.get("id").and_then(Value::as_str).unwrap_or("");
    // rust: return Err(format!(
    // rust: "Missing {}. {}",
    // rust: index.display(),
    // rust: files.hint(version)
    // rust: ));
}
    // rust: let bytes = fs::read(&index).map_err(|e| format!("{}: {e}", index.display()))?;
    // rust: let checksum = crate::hex(&<sha1::Sha1 as sha1::Digest>::digest(&bytes));
    // rust: if checksum != sha1 && !lock.asset_index_accepted(&checksum) {
    // rust: log(&format!(
    // rust: "{} is an asset index Horizon does not know yet (sha1 {checksum}); Mojang may have \
    // rust: republished it. Using it: every file is still checked against its own SHA-1.",
    // rust: index.display()
    // rust: ));
}
    // rust: Ok((assets, index, bytes))
}

/// Where the launcher's asset store keeps the object with this SHA-1.
pub fn object_path(assets: *Path, checksum: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if checksum.len() != 40 || !checksum.bytes().all(|b| b.is_ascii_hexdigit()) {
    // rust: return Err(format!("Bad asset hash {checksum:?} in the asset index"));
}
    // rust: Ok(assets.join("objects").join(&checksum[..2]).join(checksum))
}

/// Whether the game plays this asset: sounds.json and everything under sounds/.
pub fn is_sound(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name == "minecraft/sounds.json" || name.starts_with("minecraft/sounds/")
}

/// Copies the pinned version's asset index and sounds from the official launcher's game
/// directory (`minecraft`, else HORIZON_MINECRAFT_DIR, else the launcher's own) into `root`'s
/// `.local/horizon-client/<version>`; returns that folder. Files already there with the right
/// SHA-1 are kept.
pub fn sounds(root: *Path, minecraft: ?*Path, log: Log) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: add_assets("sounds", root, None, minecraft, &Inputs::default(), log)
}

/// Replaces the client JAR's 1x1 title placeholders with the full panorama from the
/// launcher's asset store. Also usable on already-prepared resources without Java.
pub fn panorama(root: *Path, minecraft: ?*Path, log: Log) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: add_assets("panorama", root, None, minecraft, &Inputs::default(), log)
}

/// Replaces the client JAR's empty `font/include/unifont.json` with the asset index's, and
/// adds the GNU Unifont glyphs it names (`font/unifont*.zip`): the default font's fallback for
/// every character the bitmap fonts lack (#1076). Also usable on prepared resources without Java.
pub fn fonts(root: *Path, minecraft: ?*Path, log: Log) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: add_assets("fonts", root, None, minecraft, &Inputs::default(), log)
}

/// Every bundled language and the language list, both of which only the asset index holds
/// (the client JAR carries `en_us` alone): `pack.mcmeta`'s `language` section is what the
/// language screen offers, `minecraft/lang/<code>.json` the strings each one draws (#1272).
/// Also usable on already-prepared resources without Java.
pub fn languages(root: *Path, minecraft: ?*Path, log: Log) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: add_assets("languages", root, None, minecraft, &Inputs::default(), log)
}

pub const LANGUAGES: [[]const u8; 1] = ["pack.mcmeta"];

pub fn is_language(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name == "pack.mcmeta" || name.starts_with("minecraft/lang/")
}

/// Full preparation can run from cached JARs without an official launcher install.
pub fn optional_assets(root: *Path, minecraft: ?*Path, log: Log) void {
}
    // rust: optional_imports(
    // rust: Assets::load(root, None, minecraft, &Inputs::default(), log)
    // rust: .as_mut()
    // rust: .map_err(|e| e.as_str()),
    // rust: log,
    // rust: );
}

    // rust: pub(crate) fn optional_imports(mut assets: Result<&mut Assets, &str>, log: Log) {
    // rust: for (wanted, label, required, failure, command) in [
    // rust: (
    // rust: is_panorama as fn(&str) -> bool,
    // rust: "Panorama",
    // rust: PANORAMA.as_slice(),
    // rust: "Title panorama",
    // rust: "panorama",
    // rust: ),
    // rust: (
    // rust: is_font,
    // rust: "Font",
    // rust: UNIFONT.as_slice(),
    // rust: "Unifont glyphs",
    // rust: "fonts",
    // rust: ),
    // rust: (
    // rust: is_built_in_pack,
    // rust: "Built-in pack",
    // rust: BUILT_IN_PACKS.as_slice(),
    // rust: "Programmer Art and High Contrast",
    // rust: "packs",
    // rust: ),
    // rust: (
    // rust: is_language,
    // rust: "Language",
    // rust: LANGUAGES.as_slice(),
    // rust: "Languages",
    // rust: "languages",
    // rust: ),
    // rust: ] {
    // rust: let result = match &mut assets {
    // rust: Ok(assets) => assets.copy(wanted, label, required, log).map(|_| ()),
    // rust: Err(error) => Err(error.to_string()),
}
    // rust: if let Err(error) = result {
    // rust: log(&format!(
    // rust: "{failure} not imported: {error}; run horizon-prepare {command} later"
    // rust: ));
}
}
}

    // rust: const PANORAMA: [&str; 7] = [
    // rust: "minecraft/textures/gui/title/background/panorama_0.png",
    // rust: "minecraft/textures/gui/title/background/panorama_1.png",
    // rust: "minecraft/textures/gui/title/background/panorama_2.png",
    // rust: "minecraft/textures/gui/title/background/panorama_3.png",
    // rust: "minecraft/textures/gui/title/background/panorama_4.png",
    // rust: "minecraft/textures/gui/title/background/panorama_5.png",
    // rust: "minecraft/textures/gui/title/background/panorama_overlay.png",
    // rust: ];

pub fn is_panorama(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PANORAMA.contains(&name)
}

    // rust: const UNIFONT: [&str; 2] = [
    // rust: "minecraft/font/include/unifont.json",
    // rust: "minecraft/font/unifont.zip",
    // rust: ];

/// Adds the built-in Programmer Art and High Contrast packs, which only the asset index holds
/// (`BuiltInPackSource.populatePackList` lists `minecraft:resourcepacks` of the vanilla pack).
/// Packs made to sit on Programmer Art, like Golden Days, show the default textures without it.
/// Also usable on prepared resources without Java.
pub fn packs(root: *Path, minecraft: ?*Path, log: Log) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: add_assets("packs", root, None, minecraft, &Inputs::default(), log)
}

/// The built-in packs `packs` copies, under the prepared resources' `assets`.
    // rust: pub const BUILT_IN_PACKS: [&str; 2] = [
    // rust: "minecraft/resourcepacks/programmer_art.zip",
    // rust: "minecraft/resourcepacks/high_contrast.zip",
    // rust: ];

pub fn is_built_in_pack(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name.starts_with("minecraft/resourcepacks/")
}

/// The fonts only the asset index holds (the JAR has the bitmap fonts).
pub fn is_font(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name.starts_with("minecraft/font/")
}

/// What each `horizon-prepare <kind>` copies: the assets it wants, its log label, the files it needs.
    // rust: type Kind = (
    // rust: &'static str,
    // rust: fn(&str) -> bool,
    // rust: &'static str,
    // rust: &'static [&'static str],
    // rust: );

    // rust: const KINDS: [Kind; 5] = [
    // rust: ("sounds", is_sound, "Sound", &["minecraft/sounds.json"]),
    // rust: ("panorama", is_panorama, "Panorama", &PANORAMA),
    // rust: ("fonts", is_font, "Font", &UNIFONT),
    // rust: ("packs", is_built_in_pack, "Built-in pack", &BUILT_IN_PACKS),
    // rust: ("languages", is_language, "Language", &LANGUAGES),
    // rust: ];

/// `horizon-prepare <kind>`: copies what `kind` names (`sounds`, `panorama`, `fonts`, `packs` or
/// `languages`) into the resources at `output` (default: `root`'s `.local/horizon-client/<version>`),
/// from the asset store of `minecraft` or the one `inputs` names.
    // rust: pub fn add_assets(
    // rust: kind: &str,
    // rust: root: &Path,
    // rust: output: Option<&Path>,
    // rust: minecraft: Option<&Path>,
    // rust: inputs: &Inputs,
    // rust: log: Log,
    // rust: ) -> Result<PathBuf, String> {
    // rust: let (_, wanted, label, required) = KINDS
    // rust: .iter()
    // rust: .find(|(name, ..)| *name == kind)
    // rust: .ok_or_else(|| format!("no assets called {kind}"))?;
    // rust: let mut assets = Assets::load(root, output, minecraft, inputs, log)?;
    // rust: let _lock = crate::hold_lock(&assets.target, log)?;
    // rust: assets.copy(*wanted, label, required, log)
}

/// A preparation's index and verified destinations. Never persisted: a later invocation
/// checks the bytes again, including when repairing a corrupt prepared file.
    // rust: pub(crate) struct Assets {
    // rust: store: PathBuf,
    // rust: target: PathBuf,
    // rust: objects: Vec<(String, Value)>,
    // rust: verified: HashSet<PathBuf>,
}

    // rust: impl Assets {
    // rust: pub(crate) fn load(
    // rust: root: &Path,
    // rust: output: Option<&Path>,
    // rust: minecraft: Option<&Path>,
    // rust: inputs: &Inputs,
    // rust: log: Log,
    // rust: ) -> Result<Self, String> {
    // rust: let lock = Lock::read(root)?;
    // rust: let files = artifacts::game_files(minecraft, &lock.version).with(inputs);
    // rust: let manifest = artifacts::import_manifest(&lock, &files)?;
    // rust: let target = crate::resources_dir(root, &lock.version, output);
    // rust: let (store, index, bytes) = launcher_assets(
    // rust: &lock,
    // rust: &manifest,
    // rust: &files,
    // rust: &target.join("asset-index.json"),
    // rust: log,
    // rust: )?;
    // rust: let text = std::str::from_utf8(&bytes).map_err(|e| e.to_string())?;
    // rust: let objects = crate::pyjson::loads(text)?;
    // rust: let objects = objects
    // rust: .get("objects")
    // rust: .and_then(Value::as_object)
    // rust: .ok_or_else(|| format!("{} has no objects", index.display()))?
    // rust: .to_vec();
    // rust: fs::create_dir_all(&target).map_err(|e| e.to_string())?;
    // rust: crate::write_if_changed(&target.join("asset-index.json"), &bytes)?;
    // rust: Ok(Self {
    // rust: store,
    // rust: target,
    // rust: objects,
    // rust: verified: HashSet::new(),
    // rust: })
}

    /// Preserve indexed replacements instead of overwriting them with JAR placeholders.
    // rust: pub(crate) fn imported(&mut self, name: &str) -> Result<bool, String> {
    // rust: let Some(name) = name.strip_prefix("assets/") else {
    // rust: return Ok(false);
}
    // rust: if !(is_panorama(name) || is_font(name) || is_language(name)) {
    // rust: return Ok(false);
}
    // rust: let Some((_, info)) = self.objects.iter().rev().find(|(n, _)| n == name) else {
    // rust: return Ok(false);
}
    // rust: let Some(hash) = info.get("hash").and_then(Value::as_str) else {
    // rust: return Ok(false);
}
    // rust: let destination = self.target.join("assets").join(name);
    // rust: if destination.is_file() && digest(&destination, "sha1")? == hash {
    // rust: self.verified.insert(destination);
    // rust: return Ok(true);
}
    // rust: Ok(false)
}

    // rust: fn copy(
    // rust: &mut self,
    // rust: wanted_asset: fn(&str) -> bool,
    // rust: label: &str,
    // rust: required: &[&str],
    // rust: log: Log,
    // rust: ) -> Result<PathBuf, String> {
    // rust: copy_indexed(self, wanted_asset, label, required, log)
}
}

    // rust: fn copy_indexed(
    // rust: assets: &mut Assets,
    // rust: wanted_asset: fn(&str) -> bool,
    // rust: label: &str,
    // rust: required: &[&str],
    // rust: log: Log,
    // rust: ) -> Result<PathBuf, String> {
    // rust: let objects = &assets.objects;
    // A repeated name keeps its first place and its last value, as a Python dict does.
    // rust: let mut wanted: Vec<(&str, &Value)> = Vec::new();
    // rust: let mut positions = HashMap::new();
    // rust: for (name, info) in objects.iter().filter(|(name, _)| wanted_asset(name)) {
    // rust: if let Some(&position) = positions.get(name.as_str()) {
    // rust: wanted[position] = (name.as_str(), info);
    // rust: } else {
    // rust: positions.insert(name.as_str(), wanted.len());
    // rust: wanted.push((name, info));
}
}
    // rust: for name in required {
    // rust: if !wanted.iter().any(|(n, _)| n == name) {
    // rust: return Err(format!("{name} is missing from the asset index"));
}
}
    // rust: let mut total: u64 = 0;
    // rust: let mut copies = Vec::with_capacity(wanted.len());
    // rust: for (name, info) in &wanted {
    // rust: let hash = info
    // rust: .get("hash")
    // rust: .and_then(Value::as_str)
    // rust: .ok_or_else(|| format!("{name} has no hash in the asset index"))?;
    // rust: let size = info
    // rust: .get("size")
    // rust: .and_then(Value::as_i64)
    // rust: .and_then(|s| u64::try_from(s).ok())
    // rust: .ok_or_else(|| format!("{name} has no size in the asset index"))?;
    // rust: let relative = artifacts::safe_relative(name)
    // rust: .ok_or_else(|| format!("Unsafe asset name {name:?} in the asset index"))?;
    // rust: let source = object_path(&assets.store, hash)?;
    // rust: let destination = assets.target.join("assets").join(relative);
    // rust: let import = crate::files::Import::stage(
    // rust: &source,
    // rust: &destination,
    // rust: hash,
    // rust: "sha1",
    // rust: assets.verified.contains(&destination),
    // rust: )
    // rust: .map_err(|error| {
    // rust: if !source.is_file() {
    // rust: format!(
    // rust: "Missing asset object {}. Play the pinned version once in your launcher.",
    // rust: source.display()
    // rust: )
    // rust: } else if error.contains(" is not the pinned file:") {
    // rust: format!(
    // rust: "Corrupt asset object {}; let the launcher repair it: {error}",
    // rust: source.display()
    // rust: )
    // rust: } else {
    // rust: error
}
    // rust: })?;
    // rust: copies.push((import, destination));
    // rust: total += size;
}
    // Check the entire set before replacing any placeholders: a missing late face
    // must not leave a mixture of real textures and gray faces in either entry point.
    // rust: for (import, destination) in copies {
    // rust: import.commit()?;
    // rust: assets.verified.insert(destination);
}
    // rust: log(&format!(
    // rust: "{label} assets ready: {} files, {:.1} MB",
    // rust: wanted.len(),
    // rust: total as f64 / 1e6
    // rust: ));
    // rust: Ok(assets.target.clone())
}

    // rust: mod tests {
//     use super::*;
//     use sha1::Digest;

pub fn sha1_hex(data: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::hex(&sha1::Sha1::digest(data))
}

    /// Where the fixture's built-in packs and panorama objects start.
pub const FIRST_PACK: usize = 6;
pub const FIRST_FACE: usize = 8;

    /// A Horizon folder and an official launcher directory holding version `9.9` with
    /// sounds, a language file, Unifont, the built-in packs and the full title panorama in its
    /// asset store.
pub const Fixture = struct {
    dir: PathBuf,
    root: PathBuf,
    minecraft: PathBuf,
    objects: Vec<(*'static str,
};

    // rust: impl Fixture {
pub fn new(name: []const u8) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with_panorama(name, &PANORAMA)
}

pub fn with_panorama(name: []const u8, panorama: *[*'static str]) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with_extras(name, panorama, &[])
}

        /// The same store with extra index entries, for the files the index alone holds.
    // rust: fn with_extras(
    // rust: name: &str,
    // rust: panorama: &[&'static str],
    // rust: extras: &[(&'static str, &'static [u8])],
    // rust: ) -> Fixture {
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-prepare-sounds-{name}-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: let root = dir.join("horizon");
    // rust: let minecraft = dir.join("minecraft");
    // rust: let mut objects: Vec<(&'static str, Vec<u8>)> = vec![
    // rust: ("minecraft/sounds.json", b"{\"a\": {}}".to_vec()),
    // rust: ("minecraft/sounds/ambient/cave1.ogg", b"OggS cave".to_vec()),
    // rust: ("minecraft/sounds/dig/stone1.ogg", b"OggS stone".to_vec()),
    // rust: ("minecraft/lang/fr_fr.json", b"{}".to_vec()),
    // rust: (
    // rust: UNIFONT[0],
    // rust: b"{\"providers\": [{\"type\": \"unihex\"}]}".to_vec(),
    // rust: ),
    // rust: (UNIFONT[1], b"PK unifont".to_vec()),
    // rust: (BUILT_IN_PACKS[0], b"PK programmer art".to_vec()),
    // rust: (BUILT_IN_PACKS[1], b"PK high contrast".to_vec()),
    // rust: ];
    // rust: for &name in panorama {
                // Distinct object bytes let the test catch swapped faces too.
    // rust: objects.push((name, name.as_bytes().to_vec()));
}
    // rust: for &(name, data) in extras {
    // rust: objects.push((name, data.to_vec()));
}
    // rust: let mut index = String::from("{\"objects\": {");
    // rust: for (i, (name, data)) in objects.iter().enumerate() {
    // rust: let hash = sha1_hex(data);
    // rust: let path = minecraft
    // rust: .join("assets/objects")
    // rust: .join(&hash[..2])
    // rust: .join(&hash);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(&path, data).unwrap();
    // rust: let comma = if i > 0 { ", " } else { "" };
    // rust: index += &format!(
    // rust: "{comma}\"{name}\": {{\"hash\": \"{hash}\", \"size\": {}}}",
    // rust: data.len()
    // rust: );
}
    // rust: index += "}}";
    // rust: let indexes = minecraft.join("assets/indexes");
    // rust: fs::create_dir_all(&indexes).unwrap();
    // rust: fs::write(indexes.join("7.json"), &index).unwrap();
    // rust: let manifest = format!(
    // rust: "{{\"id\": \"9.9\", \"assetIndex\": {{\"id\": \"7\", \"sha1\": \"{}\"}}, \
    // rust: \"downloads\": {{\"client\": {{\"sha1\": \"c\"}}, \"server\": {{\"sha1\": \"s\"}}}}, \
    // rust: \"javaVersion\": {{\"majorVersion\": 25}}}}",
    // rust: sha1_hex(index.as_bytes())
    // rust: );
    // rust: let versions = minecraft.join("versions/9.9");
    // rust: fs::create_dir_all(&versions).unwrap();
    // rust: fs::write(versions.join("9.9.json"), &manifest).unwrap();
    // rust: fs::create_dir_all(&root).unwrap();
    // rust: fs::write(
    // rust: root.join("research-lock.json"),
    // rust: format!(
    // rust: "{{\"minecraft\": {{\"version\": \"9.9\", \"java_major\": 25, \
    // rust: \"client_sha1\": \"c\", \"server_sha1\": \"s\", \"manifest_sha1\": \"{}\"}}}}",
    // rust: sha1_hex(manifest.as_bytes())
    // rust: ),
    // rust: )
    // rust: .unwrap();
    // rust: Fixture {
    // rust: dir,
    // rust: root,
    // rust: minecraft,
    // rust: objects,
}
}

pub fn run(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: sounds(&self.root, Some(&self.minecraft), &|_| {})
}

pub fn object(self: *Self, i: usize) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let hash = sha1_hex(&self.objects[i].1);
    // rust: self.minecraft
    // rust: .join("assets/objects")
    // rust: .join(&hash[..2])
    // rust: .join(hash)
}
}

    // rust: impl Drop for Fixture {
pub fn drop(self: *Self) void {
}
    // rust: let _ = fs::remove_dir_all(&self.dir);
}
}

pub fn sounds_land_where_the_game_reads_them() void {
}
    // rust: let f = Fixture::new("layout");
    // rust: let lines = std::cell::RefCell::new(Vec::new());
    // rust: let target = sounds(&f.root, Some(&f.minecraft), &|l| {
    // rust: lines.borrow_mut().push(l.to_string())
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(target, f.root.join(".local/horizon-client/9.9"));
    // rust: for (name, data) in &f.objects[..3] {
    // rust: assert_eq!(&fs::read(target.join("assets").join(name)).unwrap(), data);
}
    // rust: assert!(!target.join("assets/minecraft/lang").exists());
    // rust: assert!(!target.join("assets/minecraft/textures").exists());
    // rust: assert_eq!(
    // rust: fs::read(target.join("asset-index.json")).unwrap(),
    // rust: fs::read(f.minecraft.join("assets/indexes/7.json")).unwrap()
    // rust: );
    // rust: assert!(f.root.join(".local/minecraft/9.9/manifest.json").is_file());
    // rust: assert_eq!(*lines.borrow(), ["Sound assets ready: 3 files, 0.0 MB"]);
        // Again: the verified copies are kept.
    // rust: f.run().unwrap();
}

pub fn languages_come_from_the_asset_store() void {
}
        // The client JAR carries `en_us` alone, so every other language and the list in
        // `pack.mcmeta` come from the index (#1272).
    // rust: let f = Fixture::with_extras(
    // rust: "languages",
    // rust: &[],
    // rust: &[("pack.mcmeta", b"{\"language\": {\"fr_fr\": {}}}")],
    // rust: );
    // rust: let lines = std::cell::RefCell::new(Vec::new());
    // rust: let target = languages(&f.root, Some(&f.minecraft), &|l| {
    // rust: lines.borrow_mut().push(l.to_string())
    // rust: })
    // rust: .unwrap();
    // rust: assert!(fs::read(target.join("assets/pack.mcmeta"))
    // rust: .unwrap()
    // rust: .starts_with(b"{\"language\""));
    // rust: assert_eq!(
    // rust: fs::read(target.join("assets/minecraft/lang/fr_fr.json")).unwrap(),
    // rust: b"{}"
    // rust: );
        // Each entry point copies its own set: the sounds stay where they belong.
    // rust: assert!(!target.join("assets/minecraft/sounds.json").exists());
    // rust: assert_eq!(*lines.borrow(), ["Language assets ready: 2 files, 0.0 MB"]);
}

    /// `--assets-dir` (and `--version-json`) alone name the store: nothing comes from the
    /// Minecraft folder, which is empty.
pub fn named_asset_store_serves_the_asset_commands() void {
}
    // rust: let f = Fixture::with_extras(
    // rust: "assets-dir",
    // rust: &[],
    // rust: &[("pack.mcmeta", b"{\"language\": {\"fr_fr\": {}}}")],
    // rust: );
    // rust: let store = f.dir.join("asset store");
    // rust: fs::rename(f.minecraft.join("assets"), &store).unwrap();
    // rust: let version_json = f.dir.join("meta/9.9.json");
    // rust: fs::create_dir_all(version_json.parent().unwrap()).unwrap();
    // rust: fs::rename(f.minecraft.join("versions/9.9/9.9.json"), &version_json).unwrap();
    // rust: let empty = f.dir.join("no minecraft");
    // rust: fs::create_dir_all(&empty).unwrap();
        // Without --assets-dir the empty folder has no store.
    // rust: let only_json = crate::artifacts::Inputs {
    // rust: version_json: Some(version_json.clone()),
    // rust: ..Default::default()
}
    // rust: assert!(add_assets(
    // rust: "languages",
    // rust: &f.root,
    // rust: None,
    // rust: Some(&empty),
    // rust: &only_json,
    // rust: &|_| {}
    // rust: )
    // rust: .is_err());
    // rust: let inputs = crate::artifacts::Inputs {
    // rust: version_json: Some(version_json),
    // rust: assets_dir: Some(store),
    // rust: ..Default::default()
}
    // rust: let target =
    // rust: add_assets("languages", &f.root, None, Some(&empty), &inputs, &|_| {}).unwrap();
    // rust: assert!(fs::read(target.join("assets/pack.mcmeta"))
    // rust: .unwrap()
    // rust: .starts_with(b"{\"language\""));
}

    /// #1076: the launcher holds an index Mojang republished under the same id, so its SHA-1
    /// is not the one in the version JSON. A known one is used quietly, an unknown one with a
    /// line in the log; the sounds come through either way.
pub fn republished_asset_indexes_still_give_sounds() void {
}
    // rust: let f = Fixture::new("republished");
    // rust: let index = f.minecraft.join("assets/indexes/7.json");
    // rust: let republished = format!("{}\n", fs::read_to_string(&index).unwrap());
    // rust: fs::write(&index, &republished).unwrap();
    // rust: let checksum = sha1_hex(republished.as_bytes());
    // rust: let lock = f.root.join("research-lock.json");
    // rust: let pinned = fs::read_to_string(&lock).unwrap();
    // rust: let sound = f
    // rust: .root
    // rust: .join(".local/horizon-client/9.9/assets/minecraft/sounds/dig/stone1.ogg");
    // rust: for known in [true, false] {
    // rust: let accepted = if known { checksum.as_str() } else { "0" };
    // rust: fs::write(
    // rust: &lock,
    // rust: pinned.replace(
    // rust: "\"manifest_sha1\"",
    // rust: &format!("\"accepted_asset_index_sha1\": [\"{accepted}\"], \"manifest_sha1\""),
    // rust: ),
    // rust: )
    // rust: .unwrap();
    // rust: let _ = fs::remove_file(&sound);
    // rust: let lines = std::cell::RefCell::new(Vec::new());
    // rust: sounds(&f.root, Some(&f.minecraft), &|l| {
    // rust: lines.borrow_mut().push(l.to_string())
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(fs::read(&sound).unwrap(), b"OggS stone");
    // rust: let lines = lines.into_inner();
    // rust: assert_eq!(lines.last().unwrap(), "Sound assets ready: 3 files, 0.0 MB");
    // rust: assert_eq!(lines.len(), if known { 1 } else { 2 }, "{lines:?}");
    // rust: if !known {
    // rust: assert!(
    // rust: lines[0].contains(&format!("does not know yet (sha1 {checksum})")),
    // rust: "{}",
    // rust: lines[0]
    // rust: );
}
}
}

pub fn every_object_is_checked() void {
}
    // rust: let f = Fixture::new("corrupt");
    // rust: fs::write(f.object(1), b"not the sound").unwrap();
    // rust: let error = f.run().unwrap_err();
    // rust: assert!(error.starts_with("Corrupt asset object"), "{error}");
    // rust: assert!(!f
    // rust: .root
    // rust: .join(".local/horizon-client/9.9/assets/minecraft/sounds/ambient/cave1.ogg")
    // rust: .exists());
    // rust: fs::remove_file(f.object(1)).unwrap();
    // rust: assert!(f.run().unwrap_err().starts_with("Missing asset object"));
}

pub fn panorama_replaces_jar_placeholders_and_repairs_repeated_preparations() void {
}
    // rust: let f = Fixture::new("panorama");
    // rust: let target = f.root.join(".local/horizon-client/9.9");
    // rust: for _ in 0..2 {
            // Full preparation extracts the JAR before importing the asset store.
    // rust: for (name, _) in &f.objects[FIRST_FACE..] {
    // rust: let path = target.join("assets").join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, b"1x1 gray placeholder").unwrap();
}
    // rust: assert_eq!(
    // rust: panorama(&f.root, Some(&f.minecraft), &|_| {}).unwrap(),
    // rust: target
    // rust: );
    // rust: for (name, data) in &f.objects[FIRST_FACE..] {
    // rust: assert_eq!(&fs::read(target.join("assets").join(name)).unwrap(), data);
}
}
    // rust: assert!(!target.join("assets/minecraft/sounds.json").exists());
    // rust: assert!(!target.join("assets/minecraft/lang").exists());
}

pub fn panorama_objects_are_verified_before_replacing_placeholders() void {
}
    // rust: let f = Fixture::new("panorama-corrupt");
    // rust: fs::write(f.object(FIRST_FACE), b"corrupt panorama").unwrap();
    // rust: let path = f
    // rust: .root
    // rust: .join(".local/horizon-client/9.9/assets")
    // rust: .join(f.objects[FIRST_FACE].0);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(&path, b"placeholder").unwrap();
    // rust: assert!(panorama(&f.root, Some(&f.minecraft), &|_| {})
    // rust: .unwrap_err()
    // rust: .starts_with("Corrupt asset object"));
    // rust: assert_eq!(fs::read(path).unwrap(), b"placeholder");
    // rust: fs::remove_file(f.object(FIRST_FACE)).unwrap();
    // rust: assert!(panorama(&f.root, Some(&f.minecraft), &|_| {})
    // rust: .unwrap_err()
    // rust: .starts_with("Missing asset object"));
}

pub fn panorama_requires_every_face_and_the_overlay_in_the_index() void {
}
    // rust: let f = Fixture::with_panorama("panorama-incomplete", &PANORAMA[..6]);
    // rust: let error = panorama(&f.root, Some(&f.minecraft), &|_| {}).unwrap_err();
    // rust: assert_eq!(
    // rust: error,
    // rust: format!("{} is missing from the asset index", PANORAMA[6])
    // rust: );
    // rust: assert!(!f.root.join(".local/horizon-client/9.9/assets").exists());
}

pub fn full_preparation_keeps_placeholders_when_panorama_is_unavailable() void {
}
    // rust: for missing in ["store", "install", "last-object"] {
    // rust: let f = Fixture::new(&format!("optional-panorama-{missing}"));
            // The JARs and manifest were imported earlier; the launcher need not remain.
    // rust: artifacts::import_manifest(
    // rust: &Lock::read(&f.root).unwrap(),
    // rust: &artifacts::game_files(Some(&f.minecraft), "9.9"),
    // rust: )
    // rust: .unwrap();
    // rust: let target = f.root.join(".local/horizon-client/9.9/assets");
    // rust: for name in PANORAMA {
    // rust: let path = target.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, b"jar placeholder").unwrap();
}
    // rust: match missing {
    // rust: "store" => fs::remove_dir_all(f.minecraft.join("assets")).unwrap(),
    // rust: "install" => fs::remove_dir_all(&f.minecraft).unwrap(),
    // rust: _ => fs::remove_file(f.object(f.objects.len() - 1)).unwrap(),
}
            // The repair subcommand remains strict, even for a missing final object.
    // rust: let error = panorama(&f.root, Some(&f.minecraft), &|_| {}).unwrap_err();
    // rust: let lines = std::cell::RefCell::new(Vec::new());
            // This is the optional import step used by full preparation after extraction.
    // rust: optional_assets(&f.root, Some(&f.minecraft), &|line| {
    // rust: lines.borrow_mut().push(line.to_string())
    // rust: });
    // rust: let lines = lines.into_inner();
    // rust: assert_eq!(
    // rust: lines[0],
    // rust: format!("Title panorama not imported: {error}; run horizon-prepare panorama later")
    // rust: );
            // The fonts and packs come on their own when only a panorama face is missing.
    // rust: match missing {
    // rust: "last-object" => assert_eq!(
    // rust: lines[1..],
    // rust: [
    // rust: "Font assets ready: 2 files, 0.0 MB",
    // rust: "Built-in pack assets ready: 2 files, 0.0 MB",
                        // This store has no `pack.mcmeta`, so the languages report it.
    // rust: "Languages not imported: pack.mcmeta is missing from the asset index; \
    // rust: run horizon-prepare languages later"
    // rust: ]
    // rust: ),
    // rust: _ => {
    // rust: assert!(lines[1].starts_with("Unifont glyphs not imported: "));
    // rust: assert!(
    // rust: lines[2].starts_with("Programmer Art and High Contrast not imported: ")
    // rust: && lines[2].ends_with("; run horizon-prepare packs later"),
    // rust: "{lines:?}"
    // rust: );
    // rust: assert!(
    // rust: lines[3].starts_with("Languages not imported: ")
    // rust: && lines[3].ends_with("; run horizon-prepare languages later"),
    // rust: "{lines:?}"
    // rust: );
}
}
    // rust: assert_eq!(lines.len(), 4);
    // rust: for name in PANORAMA {
    // rust: assert_eq!(fs::read(target.join(name)).unwrap(), b"jar placeholder");
}
}
}

    /// #1076: the JAR's `font/include/unifont.json` is empty; the asset index has the real
    /// one and the glyph archives it names.
pub fn fonts_replace_the_jar_include_and_add_unifont() void {
}
    // rust: let f = Fixture::new("fonts");
    // rust: let target = f.root.join(".local/horizon-client/9.9");
    // rust: let include = target.join("assets").join(UNIFONT[0]);
    // rust: fs::create_dir_all(include.parent().unwrap()).unwrap();
    // rust: fs::write(&include, b"{\"providers\": []}").unwrap();
    // rust: let lines = std::cell::RefCell::new(Vec::new());
    // rust: let done = fonts(&f.root, Some(&f.minecraft), &|l| {
    // rust: lines.borrow_mut().push(l.to_string())
    // rust: });
    // rust: assert_eq!(done.unwrap(), target);
    // rust: for (name, data) in &f.objects[4..FIRST_PACK] {
    // rust: assert_eq!(&fs::read(target.join("assets").join(name)).unwrap(), data);
}
    // rust: assert_eq!(*lines.borrow(), ["Font assets ready: 2 files, 0.0 MB"]);
    // rust: assert!(!target.join("assets/minecraft/sounds.json").exists());
    // rust: assert!(!target.join("assets/minecraft/textures").exists());
}

    /// Golden Days is made to sit on Programmer Art, which the client JAR lacks: the asset
    /// index has it, where `BuiltInPackSource` lists `minecraft:resourcepacks`.
pub fn packs_add_programmer_art_and_high_contrast_where_the_pack_list_finds_them() void {
}
    // rust: let f = Fixture::new("packs");
    // rust: let target = f.root.join(".local/horizon-client/9.9");
    // rust: let lines = std::cell::RefCell::new(Vec::new());
    // rust: let done = packs(&f.root, Some(&f.minecraft), &|l| {
    // rust: lines.borrow_mut().push(l.to_string())
    // rust: });
    // rust: assert_eq!(done.unwrap(), target);
    // rust: for (name, data) in &f.objects[FIRST_PACK..FIRST_FACE] {
    // rust: assert_eq!(&fs::read(target.join("assets").join(name)).unwrap(), data);
}
    // rust: assert!(target
    // rust: .join("assets/minecraft/resourcepacks/programmer_art.zip")
    // rust: .is_file());
    // rust: assert_eq!(
    // rust: *lines.borrow(),
    // rust: ["Built-in pack assets ready: 2 files, 0.0 MB"]
    // rust: );
    // rust: assert!(!target.join("assets/minecraft/sounds.json").exists());
    // rust: assert!(!target.join("assets/minecraft/font").exists());
}

pub fn the_index_must_hold_the_sounds() void {
}
    // rust: let f = Fixture::new("index");
    // rust: let index = f.minecraft.join("assets/indexes/7.json");
    // rust: fs::write(&index, "{\"objects\": {}}").unwrap();
    // rust: assert_eq!(
    // rust: f.run().unwrap_err(),
    // rust: "minecraft/sounds.json is missing from the asset index"
    // rust: );
    // rust: fs::remove_file(&index).unwrap();
    // rust: fs::remove_file(f.root.join(".local/horizon-client/9.9/asset-index.json")).unwrap();
    // rust: let error = f.run().unwrap_err();
    // rust: assert!(
    // rust: error.starts_with("Missing ") && error.contains("play 9.9 once"),
    // rust: "{error}"
    // rust: );
}

pub fn late_corruption_discards_all_staged_replacements() void {
}
    // rust: let f = Fixture::new("late-corruption");
    // rust: let target = f.root.join(".local/horizon-client/9.9/assets");
    // rust: for name in PANORAMA {
    // rust: let path = target.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, b"placeholder").unwrap();
}
    // rust: fs::write(f.object(FIRST_FACE + 6), b"bad overlay").unwrap();
    // rust: assert!(panorama(&f.root, Some(&f.minecraft), &|_| {}).is_err());
    // rust: for name in PANORAMA {
    // rust: assert_eq!(fs::read(target.join(name)).unwrap(), b"placeholder");
}
    // rust: assert_eq!(
    // rust: fs::read_dir(target.join("minecraft/textures/gui/title/background"))
    // rust: .unwrap()
    // rust: .count(),
    // rust: 7
    // rust: );
}

pub fn one_index_snapshot_serves_every_import_and_reruns_repair_corruption() void {
}
    // rust: let f = Fixture::with_extras("snapshot", &PANORAMA, &[("pack.mcmeta", b"{}")]);
    // rust: let mut assets = Assets::load(
    // rust: &f.root,
    // rust: None,
    // rust: Some(&f.minecraft),
    // rust: &Inputs::default(),
    // rust: &|_| {},
    // rust: )
    // rust: .unwrap();
    // rust: fs::remove_file(f.minecraft.join("assets/indexes/7.json")).unwrap();
    // rust: let lines = std::cell::RefCell::new(Vec::new());
    // rust: optional_imports(Ok(&mut assets), &|line| {
    // rust: lines.borrow_mut().push(line.to_string())
    // rust: });
    // rust: assert_eq!(lines.borrow().len(), 4);
    // rust: assert!(lines
    // rust: .borrow()
    // rust: .iter()
    // rust: .all(|line| line.contains("assets ready")));
    // rust: assets
    // rust: .copy(is_sound, "Sound", &["minecraft/sounds.json"], &|_| {})
    // rust: .unwrap();
    // rust: let sound = assets
    // rust: .target
    // rust: .join("assets/minecraft/sounds/ambient/cave1.ogg");
    // rust: let time = fs::metadata(&sound).unwrap().modified().unwrap();
    // rust: fs::remove_file(f.object(1)).unwrap();
    // rust: f.run().unwrap(); // A verified destination works even without the source object/index.
    // rust: assert_eq!(fs::metadata(&sound).unwrap().modified().unwrap(), time);
    // rust: fs::write(&sound, b"corrupt").unwrap();
    // rust: assert!(f.run().is_err()); // Verification never carries over to another invocation.
    // rust: fs::write(f.object(1), &f.objects[1].1).unwrap();
    // rust: f.run().unwrap();
    // rust: assert_eq!(fs::read(sound).unwrap(), f.objects[1].1);
}

pub fn jar_reruns_preserve_indexed_assets_and_repair_missing_or_corrupt_members() void {
}
//         use std::io::Write;
    // rust: let f = Fixture::with_extras(
    // rust: "extract",
    // rust: &PANORAMA,
    // rust: &[
    // rust: ("pack.mcmeta", b"{}"),
    // rust: ("minecraft/lang/en_us.json", b"{\"indexed\":true}"),
    // rust: ],
    // rust: );
    // rust: optional_assets(&f.root, Some(&f.minecraft), &|_| {});
    // rust: let target = f.root.join(".local/horizon-client/9.9");
    // rust: let jar = f.root.join("client.jar");
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(&jar).unwrap());
    // rust: for (name, data) in [
    // rust: ("version.json", "{\"world_version\": 1}"),
    // rust: (
    // rust: "assets/minecraft/textures/gui/title/background/panorama_0.png",
    // rust: "gray",
    // rust: ),
    // rust: ("assets/minecraft/font/include/unifont.json", "{}"),
    // rust: ("assets/minecraft/lang/en_us.json", "{}"),
    // rust: ("data/minecraft/test.json", "data"),
    // rust: ("pack.png", "icon"),
    // rust: ] {
    // rust: zip.start_file(name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(data.as_bytes()).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: let face = target.join("assets").join(PANORAMA[0]);
    // rust: let time = fs::metadata(&face).unwrap().modified().unwrap();
        // Preparing from cached JARs must also preserve full imports without the launcher.
    // rust: fs::remove_dir_all(f.minecraft.join("assets")).unwrap();
    // rust: for _ in 0..2 {
    // rust: let mut assets = Assets::load(
    // rust: &f.root,
    // rust: None,
    // rust: Some(&f.minecraft),
    // rust: &Inputs::default(),
    // rust: &|_| {},
    // rust: )
    // rust: .unwrap();
    // rust: let (_, count) =
    // rust: crate::extract_client_resources(&jar, &target, Some(&mut assets)).unwrap();
    // rust: assert_eq!(count, 5);
    // rust: optional_imports(Ok(&mut assets), &|_| {});
    // rust: assert_eq!(fs::read(&face).unwrap(), PANORAMA[0].as_bytes());
    // rust: assert_eq!(fs::metadata(&face).unwrap().modified().unwrap(), time);
    // rust: assert_eq!(
    // rust: fs::read(target.join("assets").join(UNIFONT[0])).unwrap(),
    // rust: f.objects[4].1
    // rust: );
    // rust: assert_eq!(
    // rust: fs::read(target.join("assets/minecraft/lang/en_us.json")).unwrap(),
    // rust: b"{\"indexed\":true}"
    // rust: );
    // rust: assert_eq!(
    // rust: fs::read(target.join("data/minecraft/test.json")).unwrap(),
    // rust: b"data"
    // rust: );
    // rust: assert_eq!(fs::read(target.join("pack.png")).unwrap(), b"icon");
    // rust: fs::write(target.join("data/minecraft/test.json"), b"oops").unwrap();
    // rust: fs::remove_file(target.join("pack.png")).unwrap();
}
}

pub fn object_paths_come_from_real_hashes() void {
}
    // rust: let store = Path::new("assets");
    // rust: let hash = "abfaa525f923f807df8b4e4d29c1b5e3a104adbe";
    // rust: assert_eq!(
    // rust: object_path(store, hash).unwrap(),
    // rust: store.join("objects/ab").join(hash)
    // rust: );
    // rust: assert!(object_path(store, "../../etc/passwd").is_err());
    // rust: assert!(is_sound("minecraft/sounds/x.ogg") && is_sound("minecraft/sounds.json"));
    // rust: assert!(!is_sound("minecraft/soundsx.json") && !is_sound("realms/sounds/x.ogg"));
}
}
