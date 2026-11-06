//! Transpiled from Horizon Rust crate
//! Module: horizon-port-pack_jar
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What a mod jar holds, read without decompiling: its metadata
//! (`neoforge.mods.toml`, `mods.toml`, `fabric.mod.json`, `mcmod.info`) and a
//! census of its data, assets and classes. Legacy metadata contributes identity
//! only; license and dependency fields are not interpreted.
// use serde::{Deserialize, Serialize};
// use std::{fs, io::Read, path::Path};

pub const JarInfo = struct {
    mod_id: []const u8,
    name: []const u8,
    version: []const u8,
    license: []const u8,
    /// Required dependencies by mod id (loaders and `minecraft` left out).
    depends: std.ArrayList([]const u8),
    census: Census,
};

pub const Census = struct {
    blockstates: usize,
    item_models: usize,
    recipes: usize,
    loot_tables: usize,
    tags: usize,
    worldgen: usize,
    structures: usize,
    languages: usize,
    textures: usize,
    sounds: usize,
    classes: usize,
    mixin_configs: usize,
};

pub const NOT_MODS: [[]const u8; 5] = ["minecraft", "neoforge", "forge", "fabricloader", "java"];

pub fn read(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = fs::File::open(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let text = |zip: &mut zip::ZipArchive<fs::File>, name: &str| -> Option<String> {
    // rust: let mut s = String::new();
    // rust: zip.by_name(name).ok()?.read_to_string(&mut s).ok()?;
    // rust: Some(s)
}
    // rust: let tomls: Vec<String> = ["META-INF/neoforge.mods.toml", "META-INF/mods.toml"]
    // rust: .iter()
    // rust: .filter_map(|n| text(&mut zip, n))
    // rust: .collect();
    // rust: let mut info = if !tomls.is_empty() {
    // rust: metadata(&tomls)?
    // rust: } else if let Some(t) = text(&mut zip, "fabric.mod.json") {
    // rust: fabric(&t)?
    // rust: } else if let Some(t) = text(&mut zip, "mcmod.info") {
    // rust: mcmod_info(&t)?
    // rust: } else {
    // rust: JarInfo::default()
}
    // `version = "${file.jarVersion}"` is filled in from the manifest at load.
    // rust: if info.version.starts_with("${") {
    // rust: info.version = text(&mut zip, "META-INF/MANIFEST.MF")
    // rust: .and_then(|m| manifest_value(&m, "Implementation-Version"))
    // rust: .unwrap_or_default();
}
    // rust: let names: Vec<String> = zip
    // rust: .file_names()
    // rust: .map(|name| name.map(|name| name.into_owned()))
    // rust: .collect::<Result<_, _>>()
    // rust: .map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: info.census = census(&names);
    // rust: if info.mod_id.is_empty() {
    // rust: info.mod_id = path
    // rust: .file_stem()
    // rust: .map(|s| s.to_string_lossy().into_owned())
    // rust: .unwrap_or_default();
}
    // rust: Ok(info)
}

/// A main-section attribute of `META-INF/MANIFEST.MF`.
pub fn manifest_value(manifest: []const u8, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: manifest
    // rust: .lines()
    // rust: .take_while(|l| !l.trim().is_empty())
    // rust: .find_map(|l| l.strip_prefix(key)?.strip_prefix(':'))
    // rust: .map(|v| v.trim().to_owned())
    // rust: .filter(|v| !v.is_empty())
}

/// The jar's mod from its metadata files (`neoforge.mods.toml` first, then
/// `mods.toml`). A jar built for one loader may carry the other loader's file
/// as an unfilled template (`modId = "${id}"`, `[[dependencies.${id}]]`), which
/// its own loader never reads: the first file that parses and names a real mod
/// id is the one. When none parses, the first file is read line by line
/// ([`mods_toml_lines`]), as a loader that reads past what it does not need.
pub fn metadata(tomls: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let real = |i: &JarInfo| !i.mod_id.is_empty() && !i.mod_id.contains("${");
    // rust: let mut first_error = None;
    // rust: for t in tomls {
    // rust: match mods_toml(t) {
    // rust: Ok(i) if real(&i) => return Ok(i),
    // rust: Ok(_) => {}
    // rust: Err(e) => {
    // rust: first_error.get_or_insert(e);
}
}
}
    // rust: tomls
    // rust: .iter()
    // rust: .map(|t| mods_toml_lines(t))
    // rust: .find(real)
    // rust: .ok_or_else(|| first_error.unwrap_or_else(|| "mods.toml: no [[mods]] modId".into()))
}

/// The first `[[mods]]` table's `modId`, `displayName` and `version` and the
/// top-level `license`, read line by line (`key = "value"`, `#` comments), for
/// a metadata file a TOML parser refuses. Dependencies are not read.
pub fn mods_toml_lines(text: []const u8) J {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut info = JarInfo::default();
    // 0: top level, 1: the first [[mods]], 2: past it.
    // rust: let mut section = 0;
    // rust: for line in text.lines() {
    // rust: let line = line.trim();
    // rust: if line.starts_with('[') {
    // rust: let name = line.trim_matches(['[', ']']).trim();
    // rust: section = match (section, name) {
    // rust: (0, "mods") => 1,
    // rust: _ => 2,
}
    // rust: continue;
}
    // rust: let Some((key, value)) = line.split_once('=') else {
    // rust: continue;
}
    // rust: let value = value.trim();
    // rust: let Some(value) = value
    // rust: .strip_prefix('"')
    // rust: .and_then(|v| v.split_once('"'))
    // rust: .or_else(|| value.strip_prefix('\'').and_then(|v| v.split_once('\'')))
    // rust: .map(|(v, _)| v.to_owned())
    // rust: else {
    // rust: continue;
}
    // rust: match (section, key.trim()) {
    // rust: (0, "license") => info.license = value,
    // rust: (1, "modId") if info.mod_id.is_empty() => info.mod_id = value,
    // rust: (1, "displayName") => info.name = value,
    // rust: (1, "version") => info.version = value,
    // rust: _ => {}
}
}
    // rust: info
}

/// `[[mods]]` (the first one is the jar's mod), the top-level `license`, and
/// `[[dependencies.<id>]]` with `type = "required"` (or the older
/// `mandatory = true`).
pub fn mods_toml(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let doc: toml::Table = toml::from_str(text).map_err(|e| format!("mods.toml: {e}"))?;
    // rust: let first = doc
    // rust: .get("mods")
    // rust: .and_then(|m| m.as_array())
    // rust: .and_then(|m| m.first())
    // rust: .and_then(|m| m.as_table());
    // rust: let get = |t: Option<&toml::Table>, k: &str| {
    // rust: t.and_then(|t| t.get(k))
    // rust: .and_then(|v| v.as_str())
    // rust: .unwrap_or("")
    // rust: .to_owned()
}
    // rust: let mod_id = get(first, "modId");
    // rust: let mut depends = Vec::new();
    // rust: if let Some(deps) = doc
    // rust: .get("dependencies")
    // rust: .and_then(|d| d.get(&mod_id))
    // rust: .and_then(|d| d.as_array())
    // rust: {
    // rust: for d in deps.iter().filter_map(|d| d.as_table()) {
    // rust: let required = d.get("type").and_then(|t| t.as_str()).map_or_else(
    // rust: || d.get("mandatory").and_then(|m| m.as_bool()) == Some(true),
    // rust: |t| t.eq_ignore_ascii_case("required"),
    // rust: );
    // rust: let id = get(Some(d), "modId");
    // rust: if required && !NOT_MODS.contains(&id.as_str()) && !id.is_empty() {
    // rust: depends.push(id);
}
}
}
    // rust: Ok(JarInfo {
    // rust: name: get(first, "displayName"),
    // rust: version: get(first, "version"),
    // rust: license: get(Some(&doc), "license"),
    // rust: mod_id,
    // rust: depends,
    // rust: census: Census::default(),
    // rust: })
}

pub fn fabric(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v: serde_json::Value =
    // rust: serde_json::from_str(text).map_err(|e| format!("fabric.mod.json: {e}"))?;
    // rust: let s = |k: &str| v[k].as_str().unwrap_or("").to_owned();
    // rust: let license = match &v["license"] {
    // rust: serde_json::Value::Array(l) => l
    // rust: .iter()
    // rust: .filter_map(|x| x.as_str())
    // rust: .collect::<Vec<_>>()
    // rust: .join(" OR "),
    // rust: l => l.as_str().unwrap_or("").to_owned(),
}
    // rust: let depends = v["depends"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(id, _)| id.clone())
    // rust: .filter(|id| !NOT_MODS.contains(&id.as_str()) && !id.starts_with("fabric"))
    // rust: .collect();
    // rust: Ok(JarInfo {
    // rust: mod_id: s("id"),
    // rust: name: s("name"),
    // rust: version: s("version"),
    // rust: license,
    // rust: depends,
    // rust: census: Census::default(),
    // rust: })
}

/// Read the first mod's identity from legacy Forge metadata.
/// License and dependency fields remain unknown.
pub fn mcmod_info(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value: serde_json::Value =
    // rust: serde_json::from_str(text).map_err(|e| format!("mcmod.info: {e}"))?;
    // rust: let first = match &value {
    // rust: serde_json::Value::Array(mods) => mods.first(),
    // rust: serde_json::Value::Object(root) => root
    // rust: .get("modList")
    // rust: .and_then(serde_json::Value::as_array)
    // rust: .and_then(|mods| mods.first()),
    // rust: _ => None,
}
    // rust: .and_then(serde_json::Value::as_object);
    // rust: let get = |key: &str| {
    // rust: first
    // rust: .and_then(|mod_info| mod_info.get(key))
    // rust: .and_then(serde_json::Value::as_str)
    // rust: .unwrap_or("")
    // rust: .to_owned()
}
    // rust: Ok(JarInfo {
    // rust: mod_id: get("modid"),
    // rust: name: get("name"),
    // rust: version: get("version"),
    // rust: ..JarInfo::default()
    // rust: })
}

pub fn census(names: *[[]const u8]) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut c = Census::default();
    // rust: for n in names {
    // rust: let parts: Vec<&str> = n.split('/').collect();
    // rust: if n.ends_with(".class") {
    // rust: c.classes += 1;
    // rust: } else if n.ends_with(".mixins.json") || (parts.len() == 1 && n.contains("mixins")) {
    // rust: c.mixin_configs += 1;
}
        // assets/<ns>/<kind>/... and data/<ns>/<kind>/...
    // rust: let (Some(root), Some(kind)) = (parts.first(), parts.get(2)) else {
    // rust: continue;
}
    // rust: let json = n.ends_with(".json");
    // rust: match (*root, *kind) {
    // rust: ("assets", "blockstates") if json => c.blockstates += 1,
    // rust: ("assets", "models") if json && parts.get(3) == Some(&"item") => c.item_models += 1,
    // rust: ("assets", "lang") => c.languages += 1,
    // rust: ("assets", "textures") if n.ends_with(".png") => c.textures += 1,
    // rust: ("assets", "sounds.json") => c.sounds += 1,
    // rust: ("data", "recipe" | "recipes") if json => c.recipes += 1,
    // rust: ("data", "loot_table" | "loot_tables") if json => c.loot_tables += 1,
    // rust: ("data", "tags") if json => c.tags += 1,
    // rust: ("data", "worldgen") if json => c.worldgen += 1,
    // rust: ("data", "structure" | "structures") if n.ends_with(".nbt") => c.structures += 1,
    // rust: _ => {}
}
}
    // rust: c
}

    // rust: mod tests {
//     use super::*;
//     use std::{
    // rust: io::Write,
    // rust: path::PathBuf,
    // rust: sync::atomic::{AtomicU64, Ordering},
}

pub const NEXT_TEST_JAR: AtomicU64 = AtomicU64::new(0);

pub const SyntheticJar = struct {};

    // rust: impl Drop for SyntheticJar {
pub fn drop(self: *Self) void {
}
    // rust: let _ = fs::remove_file(&self.0);
    // rust: let _ = fs::remove_dir(&self.1);
}
}

pub fn synthetic_jar(stem: []const u8, entries: *[([]const u8) void {
}
    // rust: let id = NEXT_TEST_JAR.fetch_add(1, Ordering::Relaxed);
    // rust: let dir = Path::new(env!("CARGO_MANIFEST_DIR")).join(format!(
    // rust: ".jar-info-test-{}-{}-{id}",
    // rust: std::process::id(),
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_nanos()
    // rust: ));
    // rust: fs::create_dir(&dir).unwrap();
    // rust: let path = dir.join(format!("{stem}.jar"));
    // rust: let mut archive = zip::ZipWriter::new(fs::File::create(&path).unwrap());
    // rust: for (name, contents) in entries {
    // rust: archive
    // rust: .start_file(*name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: archive.write_all(contents.as_bytes()).unwrap();
}
    // rust: archive.finish().unwrap();
    // rust: SyntheticJar(path, dir)
}

pub fn reads_neoforge_metadata() void {
}
    // rust: let info = mods_toml(
    // rust: r#"modLoader = "javafml"
    // rust: license = "MIT"
    // rust: [[mods]]
    // rust: modId = "ruby"
    // rust: version = "1.2.0"
    // rust: displayName = "Ruby"
    // rust: [[dependencies.ruby]]
    // rust: modId = "neoforge"
    // rust: type = "required"
    // rust: [[dependencies.ruby]]
    // rust: modId = "geckolib"
    // rust: type = "required"
    // rust: [[dependencies.ruby]]
    // rust: modId = "jei"
    // rust: type = "optional"
    // rust: [[dependencies.ruby]]
    // rust: modId = "curios"
    // rust: mandatory = true
    // rust: "#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: (
    // rust: info.mod_id.as_str(),
    // rust: info.version.as_str(),
    // rust: info.license.as_str()
    // rust: ),
    // rust: ("ruby", "1.2.0", "MIT")
    // rust: );
    // rust: assert_eq!(info.depends, ["geckolib", "curios"]);
}

    /// Drip Sounds' Forge jar carries an unfilled NeoForge template beside its
    /// `mods.toml`; a file no parser reads still gives its id line by line.
pub fn templates_and_broken_files_are_read_tolerantly() void {
}
    // rust: let template = "license = \"LGPL\"\n[[mods]]\nmodId = \"${id}\"\nversion = \"${version}\"\n\n[[dependencies.${id}]]\nmodId = \"minecraft\"\n";
    // rust: let forge = "license = \"LGPL-3.0-only\"\n[[mods]]\nmodId = \"waterdripsound\"\ndisplayName = \"Drip Sounds\"\nversion = \"0.6.3\"\n[[dependencies.waterdripsound]]\nmodId = \"cloth_config\"\nmandatory = true\n";
    // rust: assert!(mods_toml(template).is_err());
    // rust: let info = metadata(&[template.to_owned(), forge.to_owned()]).unwrap();
    // rust: assert_eq!(
    // rust: (info.mod_id.as_str(), info.version.as_str()),
    // rust: ("waterdripsound", "0.6.3")
    // rust: );
    // rust: assert_eq!(info.depends, ["cloth_config"]);
        // Nothing parses: the lines still name the mod (a duplicate key is a TOML error).
    // rust: let broken = "license = 'MIT' # x\n[[mods]]\nmodId = \"ruby\"\nmodId = \"ruby\"\nversion = \"2\"\ndisplayName = \"Ruby\"\n[[mods]]\nmodId = \"other\"\n";
    // rust: assert!(mods_toml(broken).is_err());
    // rust: let info = metadata(&[template.to_owned(), broken.to_owned()]).unwrap();
    // rust: assert_eq!(
    // rust: (
    // rust: info.mod_id.as_str(),
    // rust: info.name.as_str(),
    // rust: info.license.as_str()
    // rust: ),
    // rust: ("ruby", "Ruby", "MIT")
    // rust: );
    // rust: assert!(metadata(&[template.to_owned()]).is_err());
}

pub fn reads_fabric_metadata() void {
}
    // rust: let info = fabric(
    // rust: r#"{"id": "gem", "version": "3", "name": "Gem", "license": ["MIT", "Apache-2.0"],
    // rust: "depends": {"fabricloader": "*", "fabric-api": "*", "minecraft": "1.21.1", "cloth-config": "*"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(info.license, "MIT OR Apache-2.0");
    // rust: assert_eq!(info.depends, ["cloth-config"]);
}

pub fn reads_first_legacy_mod_from_root_array_without_inventing_license_or_dependencies() void {
}
    // rust: let jar = synthetic_jar(
    // rust: "legacy-array",
    // rust: &[(
    // rust: "mcmod.info",
    // rust: r#"[
    // rust: {"modid":"legacy_array","name":"Legacy Array","version":"1.2.3","requiredMods":["other_mod"]},
    // rust: {"modid":"ignored_second","name":"Second Mod","version":"9.9"}
    // rust: ]"#,
    // rust: )],
    // rust: );

    // rust: let info = read(&jar.0).unwrap();

    // rust: assert_eq!(
    // rust: (
    // rust: info.mod_id.as_str(),
    // rust: info.name.as_str(),
    // rust: info.version.as_str()
    // rust: ),
    // rust: ("legacy_array", "Legacy Array", "1.2.3")
    // rust: );
    // rust: assert!(info.license.is_empty());
    // rust: assert!(
    // rust: info.depends.is_empty(),
    // rust: "legacy dependency fields are intentionally not interpreted"
    // rust: );
}

pub fn reads_first_legacy_mod_from_object_mod_list_and_keeps_unverified_license_empty() void {
}
    // rust: let jar = synthetic_jar(
    // rust: "legacy-object",
    // rust: &[(
    // rust: "mcmod.info",
    // rust: r#"{
    // rust: "modListVersion": 2,
    // rust: "modList": [
    // rust: {"modid":"legacy_object","name":"Legacy Object","version":"2.4","license":"unverified-custom"},
    // rust: {"modid":"ignored_second","name":"Second Mod","version":"9.9"}
    // rust: ]
    // rust: }"#,
    // rust: )],
    // rust: );

    // rust: let info = read(&jar.0).unwrap();

    // rust: assert_eq!(
    // rust: (
    // rust: info.mod_id.as_str(),
    // rust: info.name.as_str(),
    // rust: info.version.as_str()
    // rust: ),
    // rust: ("legacy_object", "Legacy Object", "2.4")
    // rust: );
    // rust: assert!(info.license.is_empty());
    // rust: assert!(info.depends.is_empty());
}

pub fn preserves_neoforge_forge_and_fabric_precedence_over_legacy_metadata() void {
}
    // rust: let neoforge = synthetic_jar(
    // rust: "neoforge-precedence",
    // rust: &[
    // rust: (
    // rust: "META-INF/neoforge.mods.toml",
    // rust: "[[mods]]\nmodId = \"neo\"\nversion = \"neo-version\"\ndisplayName = \"NeoForge\"\n",
    // rust: ),
    // rust: (
    // rust: "META-INF/mods.toml",
    // rust: "[[mods]]\nmodId = \"forge\"\nversion = \"forge-version\"\ndisplayName = \"Forge\"\n",
    // rust: ),
    // rust: (
    // rust: "fabric.mod.json",
    // rust: r#"{"id":"fabric","name":"Fabric","version":"fabric-version"}"#,
    // rust: ),
    // rust: (
    // rust: "mcmod.info",
    // rust: r#"[{"modid":"legacy","name":"Legacy","version":"legacy-version"}]"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let forge = synthetic_jar(
    // rust: "forge-precedence",
    // rust: &[
    // rust: (
    // rust: "META-INF/mods.toml",
    // rust: "[[mods]]\nmodId = \"forge\"\nversion = \"forge-version\"\ndisplayName = \"Forge\"\n",
    // rust: ),
    // rust: (
    // rust: "fabric.mod.json",
    // rust: r#"{"id":"fabric","name":"Fabric","version":"fabric-version"}"#,
    // rust: ),
    // rust: (
    // rust: "mcmod.info",
    // rust: r#"[{"modid":"legacy","name":"Legacy","version":"legacy-version"}]"#,
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let fabric = synthetic_jar(
    // rust: "fabric-precedence",
    // rust: &[
    // rust: (
    // rust: "fabric.mod.json",
    // rust: r#"{"id":"fabric","name":"Fabric","version":"fabric-version"}"#,
    // rust: ),
    // rust: (
    // rust: "mcmod.info",
    // rust: r#"[{"modid":"legacy","name":"Legacy","version":"legacy-version"}]"#,
    // rust: ),
    // rust: ],
    // rust: );

    // rust: let neo_info = read(&neoforge.0).unwrap();
    // rust: let forge_info = read(&forge.0).unwrap();
    // rust: let fabric_info = read(&fabric.0).unwrap();

    // rust: assert_eq!(
    // rust: (neo_info.mod_id.as_str(), neo_info.version.as_str()),
    // rust: ("neo", "neo-version")
    // rust: );
    // rust: assert_eq!(
    // rust: (forge_info.mod_id.as_str(), forge_info.version.as_str()),
    // rust: ("forge", "forge-version")
    // rust: );
    // rust: assert_eq!(
    // rust: (fabric_info.mod_id.as_str(), fabric_info.version.as_str()),
    // rust: ("fabric", "fabric-version")
    // rust: );
}

pub fn malformed_legacy_json_is_an_error_instead_of_filename_fallback() void {
}
    // rust: let jar = synthetic_jar("malformed-legacy", &[("mcmod.info", "[{not-json]")]);

    // rust: let error = read(&jar.0).unwrap_err();

    // rust: assert!(error.starts_with("mcmod.info:"), "{error}");
}

pub fn missing_or_empty_legacy_mod_id_uses_the_jar_filename() void {
}
    // rust: let missing = synthetic_jar(
    // rust: "missing-id",
    // rust: &[(
    // rust: "mcmod.info",
    // rust: r#"[{"name":"No Identifier","version":"1.0"}]"#,
    // rust: )],
    // rust: );
    // rust: let empty = synthetic_jar(
    // rust: "empty-id",
    // rust: &[(
    // rust: "mcmod.info",
    // rust: r#"[{"modid":"","name":"Empty Identifier","version":"1.1"}]"#,
    // rust: )],
    // rust: );

    // rust: let missing_info = read(&missing.0).unwrap();
    // rust: let empty_info = read(&empty.0).unwrap();

    // rust: assert_eq!(missing_info.mod_id, "missing-id");
    // rust: assert_eq!(empty_info.mod_id, "empty-id");
    // rust: assert_eq!(missing_info.name, "No Identifier");
    // rust: assert_eq!(missing_info.version, "1.0");
    // rust: assert_eq!(empty_info.name, "Empty Identifier");
    // rust: assert_eq!(empty_info.version, "1.1");
}

pub fn resolves_legacy_version_placeholder_from_manifest() void {
}
    // rust: let jar = synthetic_jar(
    // rust: "legacy-manifest-version",
    // rust: &[
    // rust: (
    // rust: "mcmod.info",
    // rust: r#"[{"modid":"legacy","name":"Legacy","version":"${file.jarVersion}"}]"#,
    // rust: ),
    // rust: (
    // rust: "META-INF/MANIFEST.MF",
    // rust: "Manifest-Version: 1.0\r\nImplementation-Version: 6.2.1\r\n\r\n",
    // rust: ),
    // rust: ],
    // rust: );

    // rust: let info = read(&jar.0).unwrap();

    // rust: assert_eq!(info.version, "6.2.1");
}

pub fn counts_files_by_kind() void {
}
    // rust: let names = [
    // rust: "assets/ruby/blockstates/ruby_block.json",
    // rust: "assets/ruby/models/item/ruby.json",
    // rust: "assets/ruby/models/block/ruby_block.json",
    // rust: "assets/ruby/textures/item/ruby.png",
    // rust: "assets/ruby/lang/en_us.json",
    // rust: "data/ruby/recipe/ruby.json",
    // rust: "data/ruby/loot_table/blocks/ruby_block.json",
    // rust: "data/minecraft/tags/block/mineable/pickaxe.json",
    // rust: "data/ruby/structure/hut.nbt",
    // rust: "com/example/Ruby.class",
    // rust: "ruby.mixins.json",
    // rust: ]
    // rust: .map(String::from);
    // rust: let c = census(&names);
    // rust: assert_eq!(
    // rust: (c.blockstates, c.item_models, c.textures, c.languages),
    // rust: (1, 1, 1, 1)
    // rust: );
    // rust: assert_eq!(
    // rust: (c.recipes, c.loot_tables, c.tags, c.structures),
    // rust: (1, 1, 1, 1)
    // rust: );
    // rust: assert_eq!((c.classes, c.mixin_configs), (1, 1));
}
}
