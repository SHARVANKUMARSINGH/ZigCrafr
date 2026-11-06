//! Transpiled from Horizon Rust crate
package horizon_port_pack_import

import "core:fmt"
import "core:mem"
import "core:math"

// Step 1, import: a Modrinth `.mrpack`, a CurseForge zip, an instance
// folder (Prism / MultiMC, or a plain `mods/` folder), or a Crash Assistant
// `modlist.json` (the list packs such as ATM10 publish) to `pack.json`.
// use serde::{Deserialize, Serialize};
// use serde_json::Value;
// use std::{
    // rust: collections::BTreeMap,
    // rust: fs,
    // rust: io::Read,
    // rust: path::{Path, PathBuf},
}

Pack :: struct {
    name: string,
    // `mrpack`, `curseforge` or `instance`.
    format: string,
    minecraft: string,
    // `neoforge`, `forge`, `fabric` or `quilt`.
    loader: string,
    loader_version: string,
    files: [dynamic]PackFile,
    // Override files by top folder (`config`, `kubejs`, ...).
    overrides: BTreeMap<string,
    // A CurseForge zip's files by project and file id only: how many its
    // manifest lists, when the files came from the pack's own mod list.
    curseforge_files: uint,
}

is_zero :: proc(n: ^uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: *n == 0
}

// Where Crash Assistant keeps its list in an instance (and in the
// overrides of packs that ship it, such as All the Mods 10).
MODLIST :: "config/crash_assistant/modlist.json"

PackFile :: struct {
    // Path in the instance (`mods/create-1.21.1-6.0.4.jar`).
    path: string,
    sha1: Maybe(string),
    // `required`, `optional` or `unsupported`; empty when not stated.
    client: string,
    server: string,
    downloads: [dynamic]string,
    // CurseForge project and file ids.
    curseforge: Option<(u64,
    // The mod id, name and version a mod list states (`modlist.json`).
    mod_id: Maybe(string),
    name: Maybe(string),
    version: Maybe(string),
    // The jar on disk (instances only).
    jar: Maybe(PathBuf),
}

    // rust: impl PackFile {
    // `mods`, `resourcepacks`, `shaderpacks`, `datapacks`...
kind :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.path.split('/').next().unwrap_or("")
}
file_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.path.rsplit('/').next().unwrap_or(&self.path)
}
}

    // rust: const LOADERS: [(&str, &str); 4] = [
    // rust: ("neoforge", "neoforge"),
    // rust: ("forge", "forge"),
    // rust: ("fabric-loader", "fabric"),
    // rust: ("quilt-loader", "quilt"),
    // rust: ];

import :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if path.is_dir() {
    // rust: return instance(path);
}
    // rust: if path.extension().is_some_and(|e| e == "json") {
    // rust: let text = fs::read_to_string(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let list: Value = serde_json::from_str(text.trim_start_matches('\u{feff}'))
    // rust: .map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: return modlist(&list);
}
    // rust: let file = fs::File::open(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: if let Some(index) = read_json(&mut zip, "modrinth.index.json")? {
    // rust: return Ok(mrpack(&index, &names(&zip)?));
}
    // rust: if let Some(manifest) = read_json(&mut zip, "manifest.json")? {
    // rust: let mut pack = curseforge(&manifest, &names(&zip)?);
        // The manifest names files only by CurseForge ids, which need a key
        // to resolve; the pack's own mod list names them and gives their
        // SHA-1s, so Modrinth can answer for most.
    // rust: let root = manifest["overrides"].as_str().unwrap_or("overrides");
    // rust: if let Some(list) = read_json(&mut zip, &format!("{root}/{MODLIST}"))? {
    // rust: pack.curseforge_files = pack.files.len();
    // rust: pack.files = modlist(&list)?.files;
}
    // rust: return Ok(pack);
}
    // rust: Err(format!(
    // rust: "{}: neither modrinth.index.json nor manifest.json",
    // rust: path.display()
    // rust: ))
}

names :: proc(zip: ^zip::ZipArchive<fs::File>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: zip.file_names()
    // rust: .map(|name| name.map(|name| name.into_owned()))
    // rust: .collect::<Result<_, _>>()
    // rust: .map_err(|e| e.to_string())
}

read_json :: proc(zip: ^zip::ZipArchive<fs::File>, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(mut entry) = zip.by_name(name) else {
    // rust: return Ok(None);
}
    // rust: let mut text = String::new();
    // rust: entry
    // rust: .read_to_string(&mut text)
    // rust: .map_err(|e| format!("{name}: {e}"))?;
    // rust: serde_json::from_str(text.trim_start_matches('\u{feff}'))
    // rust: .map(Some)
    // rust: .map_err(|e| format!("{name}: {e}"))
}

str_of :: proc(v: ^Value, key: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: v.get(key).and_then(Value::as_str).unwrap_or("").to_owned()
}

// Override files by top folder, below any of `roots`.
overrides :: proc(names: ^[string], roots: ^[string]) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = BTreeMap::new();
    // rust: for name in names.iter().filter(|n| !n.ends_with('/')) {
    // rust: for root in roots {
    // rust: if let Some(rest) = name.strip_prefix(root).and_then(|r| r.strip_prefix('/')) {
    // rust: let top = rest.split('/').next().unwrap_or(rest);
    // rust: *out.entry(top.to_owned()).or_default() += 1;
}
}
}
    // rust: out
}

mrpack :: proc(index: ^Value, names: ^[string]) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let deps = &index["dependencies"];
    // rust: let (loader, loader_version) = LOADERS
    // rust: .iter()
    // rust: .find_map(|(key, name)| Some((name.to_string(), deps.get(*key)?.as_str()?.to_owned())))
    // rust: .unwrap_or_default();
    // rust: let files = index["files"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|f| PackFile {
    // rust: path: str_of(f, "path"),
    // rust: sha1: f["hashes"]["sha1"].as_str().map(str::to_owned),
    // rust: client: str_of(&f["env"], "client"),
    // rust: server: str_of(&f["env"], "server"),
    // rust: downloads: f["downloads"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|d| d.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: ..PackFile::default()
    // rust: })
    // rust: .collect();
    // rust: Pack {
    // rust: name: str_of(index, "name"),
    // rust: format: "mrpack".into(),
    // rust: minecraft: str_of(deps, "minecraft"),
    // rust: loader,
    // rust: loader_version,
    // rust: files,
    // rust: overrides: overrides(
    // rust: names,
    // rust: &["overrides", "client-overrides", "server-overrides"],
    // rust: ),
    // rust: ..Pack::default()
}
}

curseforge :: proc(manifest: ^Value, names: ^[string]) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let primary = manifest["minecraft"]["modLoaders"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .find(|l| l["primary"].as_bool().unwrap_or(true))
    // rust: .map(|l| str_of(l, "id"))
    // rust: .unwrap_or_default();
    // rust: let (loader, loader_version) = primary.split_once('-').unwrap_or((&primary, ""));
    // rust: let files = manifest["files"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|f| {
    // rust: let (p, id) = (f["projectID"].as_u64(), f["fileID"].as_u64());
    // rust: PackFile {
    // rust: path: format!("mods/curseforge-{}-{}", p.unwrap_or(0), id.unwrap_or(0)),
                // CurseForge states no side; its API needs a key, so names
                // come from the user's installed instance (import that).
    // rust: curseforge: p.zip(id),
    // rust: ..PackFile::default()
}
    // rust: })
    // rust: .collect();
    // rust: let root = manifest["overrides"].as_str().unwrap_or("overrides");
    // rust: Pack {
    // rust: name: str_of(manifest, "name"),
    // rust: format: "curseforge".into(),
    // rust: minecraft: str_of(&manifest["minecraft"], "version"),
    // rust: loader: loader.to_owned(),
    // rust: loader_version: loader_version.to_owned(),
    // rust: files,
    // rust: overrides: overrides(names, &[root]),
    // rust: ..Pack::default()
}
}

// Crash Assistant's `config/crash_assistant/modlist.json`: jar name → mod
// id, name, version and Modrinth SHA-1, with the loader as an entry of its
// own. NeoForge `21.1.x` runs Minecraft 1.21.1.
modlist :: proc(list: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let entries = list.as_object().ok_or("modlist.json: not an object")?;
    // rust: let mut pack = Pack {
    // rust: name: "modlist".into(),
    // rust: format: "modlist".into(),
    // rust: ..Pack::default()
}
    // rust: for (key, e) in entries {
    // rust: let jar = e["jarName"].as_str().unwrap_or(key);
    // rust: if jar.ends_with("(modloader)") {
    // rust: let version = str_of(e, "version");
    // rust: let (loader, v) = version.split_once('-').unwrap_or(("", &version));
    // rust: pack.loader = loader.to_owned();
    // rust: pack.loader_version = v.to_owned();
    // rust: if loader == "neoforge" {
    // rust: let mut parts = v.split('.');
    // rust: if let (Some(a), Some(b)) = (parts.next(), parts.next()) {
    // rust: pack.minecraft = if b == "0" {
    // rust: format!("1.{a}")
    // rust: } else {
    // rust: format!("1.{a}.{b}")
}
}
}
    // rust: continue;
}
    // rust: let folder = if jar.ends_with(".zip") {
    // rust: "datapacks"
    // rust: } else {
    // rust: "mods"
}
    // rust: let text = |k: &str| e[k].as_str().filter(|v| !v.is_empty()).map(str::to_owned);
    // rust: pack.files.push(PackFile {
    // rust: path: format!("{folder}/{jar}"),
    // rust: sha1: text("modrinthHash"),
    // rust: mod_id: text("modId"),
    // rust: name: text("name"),
    // rust: version: text("version"),
    // rust: ..PackFile::default()
    // rust: });
}
    // rust: pack.files.sort_by(|a, b| a.path.cmp(&b.path));
    // rust: Ok(pack)
}

// A Prism / MultiMC instance (`mmc-pack.json`), a game folder, or a
// folder of jars: the jars on disk, hashed.
instance :: proc(dir: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut pack = Pack {
    // rust: name: dir
    // rust: .file_name()
    // rust: .map(|n| n.to_string_lossy().into_owned())
    // rust: .unwrap_or_default(),
    // rust: format: "instance".into(),
    // rust: ..Pack::default()
}
    // rust: if let Ok(text) = fs::read_to_string(dir.join("mmc-pack.json")) {
    // rust: let mmc: Value = serde_json::from_str(&text).map_err(|e| format!("mmc-pack.json: {e}"))?;
    // rust: for c in mmc["components"].as_array().into_iter().flatten() {
    // rust: let version = str_of(c, "version");
    // rust: match c["uid"].as_str().unwrap_or("") {
    // rust: "net.minecraft" => pack.minecraft = version,
    // rust: "net.neoforged" => {
    // rust: (pack.loader, pack.loader_version) = ("neoforge".into(), version)
}
    // rust: "net.minecraftforge" => {
    // rust: (pack.loader, pack.loader_version) = ("forge".into(), version)
}
    // rust: "net.fabricmc.fabric-loader" => {
    // rust: (pack.loader, pack.loader_version) = ("fabric".into(), version)
}
    // rust: "org.quiltmc.quilt-loader" => {
    // rust: (pack.loader, pack.loader_version) = ("quilt".into(), version)
}
    // rust: _ => {}
}
}
}
    // A CurseForge app instance has no `mmc-pack.json`; fill only when that
    // file gave no Minecraft version, so Prism behaviour is unchanged.
    // rust: if pack.minecraft.is_empty() {
    // rust: if let Some((minecraft, loader, loader_version)) = curseforge_instance_target(dir) {
    // rust: (pack.minecraft, pack.loader, pack.loader_version) =
    // rust: (minecraft, loader, loader_version);
}
}
    // rust: let game = game_dir(dir)?;
    // rust: let mods = if game.join("mods").is_dir() {
    // rust: game.join("mods")
    // rust: } else {
    // rust: game.clone()
}
    // rust: let mut jars: Vec<PathBuf> = fs::read_dir(&mods)
    // rust: .map_err(|e| format!("{}: {e}", mods.display()))?
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .filter(|p| p.extension().is_some_and(|x| x == "jar"))
    // rust: .collect();
    // rust: jars.sort();
    // rust: for jar in jars {
    // rust: let bytes = fs::read(&jar).map_err(|e| format!("{}: {e}", jar.display()))?;
    // rust: pack.files.push(PackFile {
    // rust: path: format!(
    // rust: "mods/{}",
    // rust: jar.file_name().unwrap_or_default().to_string_lossy()
    // rust: ),
    // rust: sha1: Some(sha1_hex(&bytes)),
    // rust: jar: Some(jar),
    // rust: ..PackFile::default()
    // rust: });
}
    // rust: for top in ["config", "kubejs", "defaultconfigs", "datapacks"] {
    // rust: let n = count_files(&game.join(top));
    // rust: if n > 0 {
    // rust: pack.overrides.insert(top.into(), n);
}
}
    // rust: Ok(pack)
}

// The Minecraft version, loader and loader version a CurseForge app
// instance records, or `None` when it has neither file or they are
// unreadable. `minecraftinstance.json` is the app's record of what the
// instance runs and wins over `manifest.json`, the pack author's copy,
// which goes stale when the player changes the game version or loader in the
// app (and which a custom profile never has). The triple comes from one
// file, never mixed.
curseforge_instance_target :: proc(dir: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let read = |name: &str| -> Option<Value> {
    // rust: let text = fs::read_to_string(dir.join(name)).ok()?;
    // rust: serde_json::from_str(text.trim_start_matches('\u{feff}')).ok()
}
    // rust: let from_instance = read("minecraftinstance.json").map(|v| {
    // rust: let minecraft = str_of(&v, "gameVersion");
    // rust: let id = str_of(&v["baseModLoader"], "name");
    // rust: let (loader, version) = id.split_once('-').unwrap_or((&id, ""));
        // Fabric and Quilt ids end in the Minecraft version
        // (`fabric-0.16.14-1.21.5`); it is not part of the loader's own.
    // rust: let version = version
    // rust: .strip_suffix(minecraft.as_str())
    // rust: .and_then(|v| v.strip_suffix('-'))
    // rust: .unwrap_or(version);
    // rust: (minecraft, loader.to_owned(), version.to_owned())
    // rust: });
    // rust: let from_manifest = || {
    // rust: read("manifest.json").map(|m| {
    // rust: let pack = curseforge(&m, &[]);
    // rust: (pack.minecraft, pack.loader, pack.loader_version)
    // rust: })
}
    // rust: from_instance
    // rust: .filter(|(minecraft, ..)| !minecraft.is_empty())
    // rust: .or_else(|| from_manifest().filter(|(minecraft, ..)| !minecraft.is_empty()))
}

// Resolve the game root for both mod and resource-pack instance imports.
    // rust: pub(crate) fn game_dir(dir: &Path) -> Result<PathBuf, String> {
    // rust: [".minecraft", "minecraft", "."]
    // rust: .iter()
    // rust: .map(|g| dir.join(g))
    // rust: .find(|g| g.join("mods").is_dir() || g.join("resourcepacks").is_dir())
    // rust: .or_else(|| dir.read_dir().is_ok().then(|| dir.to_path_buf()))
    // rust: .ok_or_else(|| format!("{}: no game folder", dir.display()))
}

count_files :: proc(dir: ^Path) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(entries) = fs::read_dir(dir) else {
    // rust: return 0;
}
    // rust: entries
    // rust: .flatten()
    // rust: .map(|e| {
    // rust: let p = e.path();
    // rust: if p.is_dir() { count_files(&p) } else { 1 }
    // rust: })
    // rust: .sum()
}

sha1_hex :: proc(bytes: []u8) -> S {
    // Ported from Horizon
    return {}
}
//     use sha1::Digest;
    // rust: sha1::Sha1::digest(bytes)
    // rust: .iter()
    // rust: .map(|b| format!("{b:02x}"))
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

reads_an_mrpack_index :: proc() {
}
    // rust: let index = json!({"name": "Small", "dependencies": {"minecraft": "1.21.1", "neoforge": "21.1.233"},
    // rust: "files": [{"path": "mods/create.jar", "hashes": {"sha1": "ab"}, "env": {"client": "required", "server": "required"},
    // rust: "downloads": ["https://cdn.modrinth.com/create.jar"]},
    // rust: {"path": "resourcepacks/look.zip", "hashes": {"sha1": "cd"}}]});
    // rust: let names = [
    // rust: "overrides/config/a.toml",
    // rust: "overrides/config/b/c.toml",
    // rust: "client-overrides/kubejs/x.js",
    // rust: "overrides/",
    // rust: ]
    // rust: .map(String::from);
    // rust: let p = mrpack(&index, &names);
    // rust: assert_eq!(
    // rust: (
    // rust: p.minecraft.as_str(),
    // rust: p.loader.as_str(),
    // rust: p.loader_version.as_str()
    // rust: ),
    // rust: ("1.21.1", "neoforge", "21.1.233")
    // rust: );
    // rust: assert_eq!(p.files.len(), 2);
    // rust: assert_eq!(
    // rust: (p.files[0].kind(), p.files[0].file_name()),
    // rust: ("mods", "create.jar")
    // rust: );
    // rust: assert_eq!(p.files[0].sha1.as_deref(), Some("ab"));
    // rust: assert_eq!(p.files[1].kind(), "resourcepacks");
    // rust: assert_eq!(
    // rust: p.overrides,
    // rust: BTreeMap::from([("config".into(), 2), ("kubejs".into(), 1)])
    // rust: );
}

reads_a_crash_assistant_mod_list :: proc() {
}
    // rust: let list = serde_json::json!({
    // rust: "neoforge-21.1.259 (modloader)": {"jarName": "neoforge-21.1.259 (modloader)",
    // rust: "modId": "neoforge", "version": "neoforge-21.1.259"},
    // rust: "mcw-doors-1.1.2.jar": {"jarName": "mcw-doors-1.1.2.jar", "modId": "mcwdoors",
    // rust: "modrinthHash": "0123456789abcdef0123456789abcdef01234567"},
    // rust: "sawmill.zip": {"jarName": "sawmill.zip"}
    // rust: });
    // rust: let pack = modlist(&list).unwrap();
    // rust: assert_eq!(
    // rust: (
    // rust: pack.minecraft.as_str(),
    // rust: pack.loader.as_str(),
    // rust: pack.loader_version.as_str()
    // rust: ),
    // rust: ("1.21.1", "neoforge", "21.1.259")
    // rust: );
    // rust: let paths: Vec<&str> = pack.files.iter().map(|f| f.path.as_str()).collect();
    // rust: assert_eq!(paths, ["datapacks/sawmill.zip", "mods/mcw-doors-1.1.2.jar"]);
    // rust: assert!(pack.files[1].sha1.is_some());
    // rust: assert_eq!(pack.files[1].mod_id.as_deref(), Some("mcwdoors"));
}

reads_a_curseforge_manifest :: proc() {
}
    // rust: let manifest = json!({"name": "CF", "overrides": "overrides",
    // rust: "minecraft": {"version": "1.21.1", "modLoaders": [{"id": "neoforge-21.1.259", "primary": true}]},
    // rust: "files": [{"projectID": 238222, "fileID": 5101366, "required": true}]});
    // rust: let p = curseforge(&manifest, &["overrides/kubejs/server_scripts/a.js".into()]);
    // rust: assert_eq!(
    // rust: (p.loader.as_str(), p.loader_version.as_str()),
    // rust: ("neoforge", "21.1.259")
    // rust: );
    // rust: assert_eq!(p.files[0].curseforge, Some((238222, 5101366)));
    // rust: assert_eq!(p.overrides["kubejs"], 1);
}

    // An instance folder holding the given files and an empty `mods/`.
instance_with :: proc(tag: string, files: ^[(string) {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-cf-inst-{tag}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(dir.join("mods")).unwrap();
    // rust: for (name, text) in files {
    // rust: fs::write(dir.join(name), text).unwrap();
}
    // rust: dir
}

target :: proc(pack: ^Pack) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (&pack.minecraft, &pack.loader, &pack.loader_version)
}

a_curseforge_instance_names_its_version_and_loader :: proc() {
}
    // rust: let neo = instance_with(
    // rust: "neo",
    // rust: &[(
    // rust: "minecraftinstance.json",
    // rust: r#"{"gameVersion": "1.21.1", "baseModLoader": {"name": "neoforge-21.1.133"}}"#,
    // rust: )],
    // rust: );
        // Fabric's id ends in the Minecraft version, which is not the loader's.
    // rust: let fabric = instance_with(
    // rust: "fabric",
    // rust: &[(
    // rust: "minecraftinstance.json",
    // rust: r#"{"gameVersion": "1.21.5", "baseModLoader": {"name": "fabric-0.16.14-1.21.5"}}"#,
    // rust: )],
    // rust: );
        // Only a manifest, with a byte order mark.
    // rust: let manifest = instance_with(
    // rust: "manifest",
    // rust: &[(
    // rust: "manifest.json",
    // rust: "\u{feff}{\"minecraft\": {\"version\": \"1.20.1\", \"modLoaders\": [{\"id\": \"forge-47.2.0\", \"primary\": true}]}}",
    // rust: )],
    // rust: );
    // rust: assert_eq!(
    // rust: target(&import(&neo).unwrap()),
    // rust: ("1.21.1", "neoforge", "21.1.133")
    // rust: );
    // rust: assert_eq!(
    // rust: target(&import(&fabric).unwrap()),
    // rust: ("1.21.5", "fabric", "0.16.14")
    // rust: );
    // rust: assert_eq!(
    // rust: target(&import(&manifest).unwrap()),
    // rust: ("1.20.1", "forge", "47.2.0")
    // rust: );
    // rust: for dir in [neo, fabric, manifest] {
    // rust: fs::remove_dir_all(dir).unwrap();
}
}

loader_ids_without_a_minecraft_suffix_or_loader_are_kept_whole :: proc() {
}
    // rust: let cases = [
    // rust: (
    // rust: "1.21.5",
    // rust: r#"{"name": "fabric-0.16.14"}"#,
    // rust: ("1.21.5", "fabric", "0.16.14"),
    // rust: ),
    // rust: (
    // rust: "1.21.5",
    // rust: r#"{"name": "quilt-0.26.0-1.21.5"}"#,
    // rust: ("1.21.5", "quilt", "0.26.0"),
    // rust: ),
    // rust: ("1.21.5", "null", ("1.21.5", "", "")),
    // rust: ];
    // rust: for (i, (game, loader, expected)) in cases.into_iter().enumerate() {
    // rust: let dir = instance_with(
    // rust: &format!("edge{i}"),
    // rust: &[(
    // rust: "minecraftinstance.json",
    // rust: &format!(r#"{{"gameVersion": "{game}", "baseModLoader": {loader}}}"#),
    // rust: )],
    // rust: );
    // rust: assert_eq!(target(&import(&dir).unwrap()), expected);
    // rust: fs::remove_dir_all(dir).unwrap();
}
}

minecraftinstance_wins_over_a_stale_manifest :: proc() {
}
    // rust: let dir = instance_with(
    // rust: "both",
    // rust: &[
    // rust: (
    // rust: "manifest.json",
    // rust: r#"{"minecraft": {"version": "1.20.1", "modLoaders": [{"id": "forge-47.2.0"}]}}"#,
    // rust: ),
    // rust: (
    // rust: "minecraftinstance.json",
    // rust: r#"{"gameVersion": "1.21.1", "baseModLoader": {"name": "neoforge-21.1.133"}}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: assert_eq!(
    // rust: target(&import(&dir).unwrap()),
    // rust: ("1.21.1", "neoforge", "21.1.133")
    // rust: );
    // rust: fs::remove_dir_all(dir).unwrap();
}

broken_curseforge_files_leave_the_import_working :: proc() {
}
        // A broken minecraftinstance.json falls back to the manifest; a
        // broken manifest too leaves the target empty but the jars imported.
    // rust: let fallback = instance_with(
    // rust: "fallback",
    // rust: &[
    // rust: ("minecraftinstance.json", "{not json"),
    // rust: (
    // rust: "manifest.json",
    // rust: r#"{"minecraft": {"version": "1.21.1", "modLoaders": [{"id": "neoforge-21.1.133"}]}}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let broken = instance_with(
    // rust: "broken",
    // rust: &[
    // rust: ("minecraftinstance.json", "{not json"),
    // rust: ("manifest.json", ""),
    // rust: ],
    // rust: );
    // rust: fs::write(broken.join("mods/a.jar"), b"jar").unwrap();
    // rust: assert_eq!(
    // rust: target(&import(&fallback).unwrap()),
    // rust: ("1.21.1", "neoforge", "21.1.133")
    // rust: );
    // rust: let pack = import(&broken).unwrap();
    // rust: assert_eq!(target(&pack), ("", "", ""));
    // rust: assert_eq!(pack.files.len(), 1);
    // rust: for dir in [fallback, broken] {
    // rust: fs::remove_dir_all(dir).unwrap();
}
}

mmc_pack_still_wins_over_curseforge_files :: proc() {
}
    // rust: let dir = instance_with(
    // rust: "mmc",
    // rust: &[
    // rust: (
    // rust: "mmc-pack.json",
    // rust: r#"{"components": [{"uid": "net.minecraft", "version": "1.20.4"},
    // rust: {"uid": "net.fabricmc.fabric-loader", "version": "0.15.0"}]}"#,
    // rust: ),
    // rust: (
    // rust: "minecraftinstance.json",
    // rust: r#"{"gameVersion": "1.21.1", "baseModLoader": {"name": "neoforge-21.1.133"}}"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: assert_eq!(
    // rust: target(&import(&dir).unwrap()),
    // rust: ("1.20.4", "fabric", "0.15.0")
    // rust: );
    // rust: fs::remove_dir_all(dir).unwrap();
}

a_curseforge_zip_takes_names_from_its_mod_list :: proc() {
}
//         use std::io::Write;
    // rust: let dir = std::env::temp_dir().join(format!("horizon-cf-zip-{}", std::process::id()));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let path = dir.join("pack.zip");
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(&path).unwrap());
    // rust: let opts = zip::write::SimpleFileOptions::default();
    // rust: let manifest = json!({"name": "Pack", "overrides": "overrides",
    // rust: "minecraft": {"version": "1.21.1", "modLoaders": [{"id": "neoforge-21.1.259"}]},
    // rust: "files": [{"projectID": 1, "fileID": 2}, {"projectID": 3, "fileID": 4}]});
    // rust: zip.start_file("manifest.json", opts).unwrap();
    // rust: zip.write_all(manifest.to_string().as_bytes()).unwrap();
    // rust: zip.start_file(format!("overrides/{MODLIST}"), opts)
    // rust: .unwrap();
    // rust: let list = json!({"mcw-doors-1.1.2.jar": {"jarName": "mcw-doors-1.1.2.jar",
    // rust: "modId": "mcwdoors", "modrinthHash": "0123456789abcdef0123456789abcdef01234567"}});
        // Crash Assistant writes a byte order mark.
    // rust: zip.write_all(format!("\u{feff}{list}").as_bytes()).unwrap();
    // rust: zip.finish().unwrap();
    // rust: let pack = import(&path).unwrap();
    // rust: assert_eq!(
    // rust: (pack.format.as_str(), pack.name.as_str()),
    // rust: ("curseforge", "Pack")
    // rust: );
    // rust: assert_eq!(pack.curseforge_files, 2);
    // rust: assert_eq!(pack.files.len(), 1);
    // rust: assert_eq!(pack.files[0].path, "mods/mcw-doors-1.1.2.jar");
    // rust: assert_eq!(pack.overrides["config"], 1);
    // rust: fs::remove_dir_all(&dir).unwrap();
}
}
