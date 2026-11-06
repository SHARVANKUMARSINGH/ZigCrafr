//! Transpiled from Horizon Rust crate
//! Module: horizon-port-pack_check
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! One mod jar on its own, as the launcher's mod browser installs it: what
//! of it Horizon runs, said before install (Works, Partly, Doesn't run),
//! from the jar itself. The jar is carried over ([`crate::carry`]) into a
//! folder content mod, and its classes are read ([`crate::classes`]) for
//! what the carry can't take: block entities, entities, Mixins, behaviour.
//!
//! - **Works**: content only. Its blocks, items, recipes, loot, tags and
//!   worldgen port, and its code only registers them.
//! - **Partly**: the content ports; the code features listed don't.
//! - **Doesn't run**: nothing to port (everything it does is Java code), or
//!   the jar can't be carried at all.
// use crate::{carry, classes, jar};
// use serde::{Deserialize, Serialize};
// use std::{collections::BTreeMap, fs, io::Read, path::Path};

pub const Verdict = enum {
    Works,
    Partly,
    No,
};

    // rust: impl Verdict {
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Verdict::Works => "Works",
    // rust: Verdict::Partly => "Partly",
    // rust: Verdict::No => "Doesn't run",
}
}
}

/// What checking a jar found. Written as `check.json` beside the carry.
pub const Check = struct {
    mod_id: []const u8,
    name: []const u8,
    version: []const u8,
    /// `neoforge`, `forge`, `fabric`, `quilt`, or `` for a plain zip.
    loader: []const u8,
    license: []const u8,
    verdict: Verdict,
    /// One line: why this verdict.
    summary: []const u8,
    /// What ports: "12 blocks", "40 recipes"...
    ports: std.ArrayList([]const u8),
    /// What doesn't, with why.
    skipped: std.ArrayList([]const u8),
    /// Required mods, by id.
    depends: std.ArrayList([]const u8),
    /// The folder mod's namespaces (its id first): two mods on at once may
    /// not share one.
    namespaces: std.ArrayList([]const u8),
    code: classes::Code,
};

/// The loader a jar is made for, from its metadata file.
pub fn loader(names: *[[]const u8]) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let has = |n: &str| names.iter().any(|x| x == n);
    // rust: if has("META-INF/neoforge.mods.toml") {
    // rust: "neoforge"
    // rust: } else if has("META-INF/mods.toml") {
    // rust: "forge"
    // rust: } else if has("fabric.mod.json") {
    // rust: "fabric"
    // rust: } else if has("quilt.mod.json") {
    // rust: "quilt"
    // rust: } else {
    // rust: ""
}
}

/// Data folders named as before 1.21 (`recipes/`, `loot_tables/`) and none
/// as 1.21 names them: the game doesn't read them, and the carry upgrades
/// from 1.21.1 on. (Some jars keep a stale plural folder beside the new one.)
pub fn old_layout(names: *[[]const u8]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let has = |kinds: [&str; 2]| {
    // rust: names.iter().any(|n| {
    // rust: let p: Vec<&str> = n.split('/').collect();
    // rust: p.len() > 3 && p[0] == "data" && kinds.contains(&p[2]) && n.ends_with(".json")
    // rust: })
}
    // rust: has(["recipes", "loot_tables"]) && !has(["recipe", "loot_table"])
}

pub fn plural(n: usize, one: []const u8, many: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{n} {}", if n == 1 { one } else { many })
}

/// Checks `jar` and carries it over into `out/carry/` (`out/check.json`,
/// `out/carry-report.json` beside it). The carry is the folder mod an
/// install copies.
pub fn check(jar_path: *Path, out: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let info = jar::read(jar_path)?;
    // rust: let file = fs::File::open(jar_path).map_err(|e| format!("{}: {e}", jar_path.display()))?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| format!("{}: {e}", jar_path.display()))?;
    // rust: let names: Vec<String> = zip
    // rust: .file_names()
    // rust: .map(|name| name.map(|name| name.into_owned()))
    // rust: .collect::<Result<_, _>>()
    // rust: .map_err(|e| format!("{}: {e}", jar_path.display()))?;
    // rust: let mut bytes = Vec::new();
    // rust: for n in names.iter().filter(|n| n.ends_with(".class")) {
    // rust: let mut b = Vec::new();
    // rust: if let Ok(mut e) = zip.by_name(n)
    // rust: && e.size() < 1 << 24
    // rust: && e.read_to_end(&mut b).is_ok()
    // rust: {
    // rust: bytes.push(b);
}
}
    // rust: let code = classes::census(bytes.iter().map(Vec::as_slice));
    // rust: let mut check = Check {
    // rust: mod_id: info.mod_id.clone(),
    // rust: name: info.name.clone(),
    // rust: version: info.version.clone(),
    // rust: loader: loader(&names).to_owned(),
    // rust: license: info.license.clone(),
    // rust: verdict: Verdict::No,
    // rust: summary: String::new(),
    // rust: ports: Vec::new(),
    // rust: skipped: Vec::new(),
    // rust: depends: info.depends.clone(),
    // rust: namespaces: Vec::new(),
    // rust: code,
}
    // rust: fs::create_dir_all(out).map_err(|e| format!("{}: {e}", out.display()))?;
    // rust: let done = |check: Check| -> Result<Check, String> {
    // rust: crate::pipeline::write_json(&out.join("check.json"), &check)?;
    // rust: Ok(check)
}
    // rust: if old_layout(&names) {
    // rust: check.summary = "Made for Minecraft 1.20 or older: Horizon ports mods made for 1.21 \
    // rust: and later."
    // rust: .into();
    // rust: return done(check);
}
    // rust: let alone = |m: &str| m == info.mod_id || m == "minecraft";
    // rust: let pack = carry::Pack {
    // rust: loaded: &alone,
    // rust: mods: &alone,
}
    // rust: let report = match carry::carry(
    // rust: jar_path,
    // rust: &info,
    // rust: out,
    // rust: None,
    // rust: &|_| true,
    // rust: &pack,
    // rust: &BTreeMap::new(),
    // rust: ) {
    // rust: Ok(r) => r,
    // rust: Err(e) => {
    // rust: check.summary = format!("Can't be carried over: {e}");
    // rust: return done(check);
}
}
    // rust: check.namespaces = std::iter::once(info.mod_id.clone())
    // rust: .chain(report.namespaces.iter().cloned())
    // rust: .collect();
    // rust: let c = &info.census;
    // rust: let recipes = report
    // rust: .recipes_upgraded
    // rust: .saturating_sub(report.recipes_unregistered.len());
    // rust: let loot = c.loot_tables + report.loot_tables_added;
    // rust: let content =
    // rust: report.blocks.len() + report.items + recipes + loot + report.worldgen + c.structures;
    // rust: for (n, one, many) in [
    // rust: (report.blocks.len(), "block", "blocks"),
    // rust: (report.items, "item", "items"),
    // rust: (recipes, "recipe", "recipes"),
    // rust: (loot, "loot table", "loot tables"),
    // rust: (report.worldgen, "worldgen file", "worldgen files"),
    // rust: (c.textures, "texture", "textures"),
    // rust: ] {
    // rust: if n > 0 {
    // rust: check.ports.push(plural(n, one, many));
}
}
    // rust: if !report.blocks.is_empty() {
    // rust: check
    // rust: .ports
    // rust: .push("blocks take the closest vanilla block's shape, hardness and sounds".into());
}
    // rust: let mut skipped = Vec::new();
    // rust: if !report.blocks_unknown.is_empty() {
    // rust: skipped.push(plural(
    // rust: report.blocks_unknown.len(),
    // rust: "block with no vanilla block to copy (left out)",
    // rust: "blocks with no vanilla block to copy (left out)",
    // rust: ));
}
    // rust: if !report.recipes_unregistered.is_empty() {
    // rust: skipped.push(plural(
    // rust: report.recipes_unregistered.len(),
    // rust: "recipe for a left-out block",
    // rust: "recipes for left-out blocks",
    // rust: ));
}
    // rust: if !report.recipes_kept.is_empty() {
    // rust: skipped.push(plural(
    // rust: report.recipes_kept.len(),
    // rust: "recipe of a type Horizon doesn't have",
    // rust: "recipes of types Horizon doesn't have",
    // rust: ));
}
    // rust: if !report.unreadable.is_empty() {
    // rust: skipped.push(plural(
    // rust: report.unreadable.len(),
    // rust: "file the game can't read",
    // rust: "files the game can't read",
    // rust: ));
}
    // rust: let wg = &report.worldgen_types;
    // rust: let dropped = wg.processors_dropped.values().sum::<usize>();
    // rust: if dropped > 0 {
    // rust: skipped.push(plural(
    // rust: dropped,
    // rust: "structure processor written in Java",
    // rust: "structure processors written in Java",
    // rust: ));
}
    // rust: let unsupported = wg.unsupported.values().sum::<usize>();
    // rust: if unsupported > 0 {
    // rust: skipped.push(plural(
    // rust: unsupported,
    // rust: "worldgen file of a type written in Java",
    // rust: "worldgen files of types written in Java",
    // rust: ));
}
    // rust: for (f, n) in &check.code.features {
    // rust: let mut line = f.describe(*n);
    // rust: if *f == classes::Feature::Events {
    // rust: let names: Vec<&str> = check
    // rust: .code
    // rust: .events
    // rust: .iter()
    // rust: .take(3)
    // rust: .map(String::as_str)
    // rust: .collect();
    // rust: line.push_str(&format!(" ({}", names.join(", ")));
    // rust: if check.code.events.len() > 3 {
    // rust: line.push_str(", ...");
}
    // rust: line.push(')');
}
    // rust: skipped.push(line);
}
    // rust: check.skipped = skipped;
    // rust: let behaviour = check.code.behaviour();
    // rust: (check.verdict, check.summary) = if content == 0 {
    // rust: let what = if behaviour || check.code.classes > 0 {
    // rust: "everything it does is Java code, which Horizon doesn't run"
    // rust: } else {
    // rust: "it has no blocks, items, recipes or worldgen"
}
    // rust: (Verdict::No, format!("Nothing to port: {what}."))
    // rust: } else if check.skipped.is_empty() {
    // rust: (
    // rust: Verdict::Works,
    // rust: format!(
    // rust: "Content only: {} port.",
    // rust: check.ports[..check.ports.len().min(3)].join(", ")
    // rust: ),
    // rust: )
    // rust: } else {
    // rust: (
    // rust: Verdict::Partly,
    // rust: format!(
    // rust: "{} port; not {}.",
    // rust: check.ports[..check.ports.len().min(2)].join(", "),
    // rust: check.skipped[..check.skipped.len().min(2)].join(", ")
    // rust: ),
    // rust: )
}
    // rust: done(check)
}

    // rust: mod tests {
//     use super::*;
//     use std::io::Write;

pub fn jar(dir: *Path, files: *[([]const u8) void {
}
    // rust: let path = dir.join("m.jar");
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(&path).unwrap());
    // rust: for (name, bytes) in files {
    // rust: zip.start_file(*name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(bytes).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: path
}

    // rust: const TOML: &[u8] = br#"modLoader = "javafml"
    // rust: license = "MIT"
    // rust: [[mods]]
    // rust: modId = "ruby"
    // rust: version = "1.0"
    // rust: displayName = "Ruby"
    // rust: "#;

pub fn temp(name: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("port-pack-check-{name}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

pub fn content_only_works_and_code_makes_it_partly() void {
}
    // rust: let dir = temp("content");
    // rust: let blockstate = br#"{"variants": {"": {"model": "ruby:block/ruby_block"}}}"#;
    // rust: let recipe = br#"{"type": "minecraft:crafting_shapeless", "ingredients": ["minecraft:red_dye"], "result": {"id": "ruby:ruby"}}"#;
    // rust: let plain = [
    // rust: ("META-INF/neoforge.mods.toml", TOML),
    // rust: ("assets/ruby/blockstates/ruby_block.json", blockstate),
    // rust: ("assets/ruby/models/item/ruby.json", b"{}"),
    // rust: ("data/ruby/recipe/ruby.json", recipe),
    // rust: ];
    // rust: let c = check(&jar(&dir, &plain), &dir.join("out")).unwrap();
    // rust: assert_eq!(c.verdict, Verdict::Works, "{c:?}");
    // rust: assert_eq!(c.loader, "neoforge");
    // rust: assert_eq!(&c.ports[..3], ["1 block", "1 item", "1 recipe"]);
    // rust: assert!(dir.join("out/carry/horizon-mod.toml").is_file());
    // rust: assert!(dir.join("out/check.json").is_file());

    // rust: let tile = crate::classes::tests_support::class_file(
    // rust: "ruby/Tile",
    // rust: "net/minecraft/world/level/block/entity/BlockEntity",
    // rust: );
    // rust: let mut coded = plain.to_vec();
    // rust: coded.push(("ruby/Tile.class", &tile));
    // rust: let c = check(&jar(&dir, &coded), &dir.join("out")).unwrap();
    // rust: assert_eq!(c.verdict, Verdict::Partly);
    // rust: assert!(
    // rust: c.skipped[0].starts_with("1 block entity"),
    // rust: "{:?}",
    // rust: c.skipped
    // rust: );
    // rust: fs::remove_dir_all(&dir).unwrap();
}

pub fn recipes_for_left_out_blocks_are_left_out_too() void {
}
    // rust: let dir = temp("left-out");
    // rust: let odd = br#"{"variants": {"wobble=1": {"model": "ruby:block/odd"}}}"#;
    // rust: let plain = br#"{"variants": {"": {"model": "ruby:block/ruby_block"}}}"#;
    // rust: let recipe = |result: &str| {
    // rust: format!(
    // rust: r#"{{"type": "minecraft:crafting_shapeless", "ingredients": ["minecraft:red_dye"], "result": {{"id": "{result}"}}}}"#
    // rust: )
}
    // rust: let (odd_recipe, block_recipe) = (recipe("ruby:odd"), recipe("ruby:ruby_block"));
    // rust: let files = [
    // rust: ("META-INF/neoforge.mods.toml", TOML),
    // rust: ("assets/ruby/blockstates/odd.json", odd.as_slice()),
    // rust: ("assets/ruby/blockstates/ruby_block.json", plain.as_slice()),
    // rust: ("data/ruby/recipe/odd.json", odd_recipe.as_bytes()),
    // rust: ("data/ruby/recipe/ruby_block.json", block_recipe.as_bytes()),
    // rust: ];
    // rust: let c = check(&jar(&dir, &files), &dir.join("out")).unwrap();
    // rust: assert_eq!(c.verdict, Verdict::Partly);
    // rust: assert!(c.ports.contains(&"1 recipe".to_string()), "{:?}", c.ports);
    // rust: assert!(
    // rust: c.skipped
    // rust: .contains(&"1 recipe for a left-out block".to_string()),
    // rust: "{:?}",
    // rust: c.skipped
    // rust: );
    // rust: assert!(!dir.join("out/carry/data/ruby/recipe/odd.json").exists());
    // rust: assert!(dir.join("out/outside/data/ruby/recipe/odd.json").exists());
    // rust: assert!(
    // rust: dir.join("out/carry/data/ruby/recipe/ruby_block.json")
    // rust: .exists()
    // rust: );
    // rust: fs::remove_dir_all(&dir).unwrap();
}

pub fn code_only_and_old_layouts_dont_run() void {
}
    // rust: let dir = temp("code");
    // rust: let tile = crate::classes::tests_support::class_file("ruby/Mixin", "java/lang/Object");
    // rust: let c = check(
    // rust: &jar(
    // rust: &dir,
    // rust: &[
    // rust: ("META-INF/neoforge.mods.toml", TOML),
    // rust: ("ruby/A.class", &tile),
    // rust: ],
    // rust: ),
    // rust: &dir.join("out"),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(c.verdict, Verdict::No);
    // rust: assert!(c.summary.starts_with("Nothing to port"), "{}", c.summary);
    // rust: let c = check(
    // rust: &jar(
    // rust: &dir,
    // rust: &[
    // rust: ("META-INF/mods.toml", TOML),
    // rust: ("data/ruby/recipes/ruby.json", b"{}"),
    // rust: ],
    // rust: ),
    // rust: &dir.join("out"),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(c.verdict, Verdict::No);
    // rust: assert!(c.summary.contains("1.20 or older"));
    // rust: fs::remove_dir_all(&dir).unwrap();
}
}
