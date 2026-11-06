//! Transpiled from Horizon Rust crate
package horizon_port_pack_pipeline

import "core:fmt"
import "core:mem"
import "core:math"

// The steps on a work folder, as the command line and the launcher run
// them. Each one reads what the earlier steps wrote and says what it did
// through `log`, one line at a time.
// use crate::{carry, fetch, import, inventory, modrinth, oracle, report};
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: fs,
    // rust: path::Path,
}

// Where a step's lines go: the terminal, or the launcher's log.
    // rust: pub type Log<'a> = &'a dyn Fn(String);

write_json :: proc(path: ^Path, value: ^impl serde::Serialize) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let text = serde_json::to_string_pretty(value).map_err(|e| e.to_string())?;
    // rust: fs::write(path, text).map_err(|e| format!("{}: {e}", path.display()))
}

    // rust: pub fn read_json<T: serde::de::DeserializeOwned>(path: &Path) -> Result<T, String> {
    // rust: let text = fs::read_to_string(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: serde_json::from_str(&text).map_err(|e| format!("{}: {e}", path.display()))
}

// Step 1: the pack at `pack` to `<work>/pack.json`.
import :: proc(source: ^Path, work: ^Path, log: Log) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let pack = import::import(source)?;
    // rust: fs::create_dir_all(work).map_err(|e| format!("{}: {e}", work.display()))?;
    // A bad resource-pack entry must not stop the pack's mods from importing.
    // rust: match crate::resourcepacks::stage(source, work, &pack).and_then(|r| r.save(work)) {
    // rust: Ok(()) => {}
    // rust: Err(e) => log(format!("resource packs not staged: {e}")),
}
    // rust: write_json(&work.join("pack.json"), &pack)?;
    // rust: let mut kinds = BTreeMap::<&str, usize>::new();
    // rust: for f in &pack.files {
    // rust: *kinds.entry(f.kind()).or_default() += 1;
}
    // rust: log(format!(
    // rust: "{} ({}): Minecraft {}, {} {}; files {kinds:?}; overrides {:?}",
    // rust: pack.name, pack.format, pack.minecraft, pack.loader, pack.loader_version, pack.overrides
    // rust: ));
    // rust: Ok(pack)
}

// Step 2: `<work>/inventory.json` and `inventory.csv`. Online, Modrinth is
// asked about the files it has not answered for yet; when it cannot be
// reached, the cached answers and the reviewed table classify alone.
inventory :: proc(work: ^Path, offline: bool, log: Log) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let pack: import::Pack = read_json(&work.join("pack.json"))?;
    // rust: let cache_path = work.join("modrinth.json");
    // rust: let mut cache = modrinth::Cache::load(&cache_path);
    // rust: if !offline {
    // rust: let hashes: Vec<String> = pack.files.iter().filter_map(|f| f.sha1.clone()).collect();
    // rust: match cache.fetch(&hashes) {
    // rust: Ok(()) => write_json(&cache_path, &cache)?,
    // rust: Err(e) => log(format!("Modrinth not reached, classifying offline: {e}")),
}
}
    // rust: let records = inventory::build(&pack, &cache, work);
    // rust: write_json(&work.join("inventory.json"), &records)?;
    // rust: fs::write(work.join("inventory.csv"), inventory::csv(&records))
    // rust: .map_err(|e| format!("inventory.csv: {e}"))?;
    // rust: let jars = records.iter().filter(|r| r.jar.is_some()).count();
    // rust: log(format!("{} files, {jars} jars read", records.len()));
    // rust: for (title, field) in [
    // rust: (
    // rust: "class",
    // rust: (|r: &inventory::Record| r.class.as_str()) as fn(&inventory::Record) -> &str,
    // rust: ),
    // rust: ("tier", |r| r.tier.as_str()),
    // rust: ("confidence", |r| r.confidence.as_str()),
    // rust: ("source", |r| r.source.as_str()),
    // rust: ] {
    // rust: log(format!("{title}: {:?}", inventory::counts(&records, field)));
}
    // rust: let layers = records.iter().map(|r| r.layer).max().map_or(0, |m| m + 1);
    // rust: let per_layer: Vec<usize> = (0..layers)
    // rust: .map(|l| records.iter().filter(|r| r.layer == l).count())
    // rust: .collect();
    // rust: log(format!("layers: {per_layer:?}"));
    // rust: let missing: usize = records.iter().map(|r| r.missing.len()).sum();
    // rust: if missing > 0 {
    // rust: log(format!(
    // rust: "{missing} required dependencies are not in the pack (see inventory.json)"
    // rust: ));
}
    // rust: Ok(records)
}

// The vanilla blocks a prepared resource root has (`facts.json`'s defaults).
vanilla_blocks :: proc(resources: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let facts: serde_json::Value = read_json(&resources.join("facts.json"))?;
    // rust: let defaults = facts["defaults"]
    // rust: .as_object()
    // rust: .ok_or("facts.json: no defaults")?;
    // rust: Ok(defaults.keys().cloned().collect())
}

// Step 4: the content mods with a jar (or the ones in `only`) carried over
// into `<work>/mods/<id>/carry/`. Returns how many were.
    // rust: pub fn carry(
    // rust: work: &Path,
    // rust: resources: Option<&Path>,
    // rust: only: &[String],
    // rust: log: Log,
    // rust: ) -> Result<usize, String> {
    // rust: let records: Vec<inventory::Record> = read_json(&work.join("inventory.json"))?;
    // rust: let facts_path = work.join("oracle/facts.json");
    // rust: let facts = if facts_path.exists() {
    // rust: let mut f = oracle::Facts::read(&facts_path)?;
    // rust: if let Some(r) = resources {
    // rust: f.vanilla_items = read_json(&r.join("items.json"))
    // rust: .inspect_err(|e| log(format!("items patched without the game's tables: {e}")))
    // rust: .unwrap_or_default();
}
    // rust: log(format!(
    // rust: "oracle facts: {} blocks, {} items",
    // rust: f.blocks.len(),
    // rust: f.items.len()
    // rust: ));
    // rust: Some(f)
    // rust: } else {
    // rust: None
}
    // Without the prepared tables, templates are not limited to what the game has.
    // rust: let vanilla = resources.and_then(|r| {
    // rust: vanilla_blocks(r)
    // rust: .inspect_err(|e| log(format!("templates not limited to the game's blocks: {e}")))
    // rust: .ok()
    // rust: });
    // rust: let allowed = |b: &str| vanilla.as_ref().is_none_or(|v| v.contains(b));
    // rust: let conventions = crate::worldgen::loader_biome_tags(work);
    // rust: let chosen = |r: &inventory::Record| {
    // rust: if only.is_empty() {
    // rust: r.class == "content"
    // rust: } else {
    // rust: only.contains(&r.key)
}
}
    // The mods ported along (carried now or before), for the conditions of
    // the mods' worldgen modifiers.
    // rust: let ported: BTreeSet<&str> = records
    // rust: .iter()
    // rust: .filter(|r| {
    // rust: r.jar.is_some() && (chosen(r) || work.join("mods").join(&r.key).join("carry").is_dir())
    // rust: })
    // rust: .filter_map(|r| Some(r.info.as_ref()?.mod_id.as_str()))
    // rust: .chain(["minecraft"])
    // rust: .collect();
    // rust: let loaded = |m: &str| ported.contains(m);
    // Every mod of the pack, ported or not: a namespace one of them has as
    // its id is never another mod's.
    // rust: let in_pack: BTreeSet<&str> = records
    // rust: .iter()
    // rust: .flat_map(|r| {
    // rust: [
    // rust: Some(r.key.as_str()),
    // rust: r.info.as_ref().map(|i| i.mod_id.as_str()),
    // rust: ]
    // rust: })
    // rust: .flatten()
    // rust: .collect();
    // A namespace two carried mods both claim (a library's they both use, such as YUNG's API's
    // `yungsapi`, whose own jar isn't read) is neither's: either would refuse the other in the
    // game. Its files stay outside both.
    // rust: let claims = records.iter().filter(|r| chosen(r)).filter_map(|r| {
    // rust: let (jar, info) = (r.jar.as_ref()?, r.info.as_ref()?);
    // rust: let owned = carry::namespaces_claimed(jar, &info.mod_id, &|m| in_pack.contains(m)).ok()?;
    // rust: Some((r.key.as_str(), owned))
    // rust: });
    // rust: let shared = shared_namespaces(claims, log);
    // rust: let in_pack = |m: &str| in_pack.contains(m) || shared.contains(m);
    // rust: let pack = carry::Pack {
    // rust: loaded: &loaded,
    // rust: mods: &in_pack,
}
    // rust: let mut done = 0;
    // rust: for r in &records {
    // rust: let chosen = chosen(r);
    // rust: let (Some(jar), Some(info)) = (&r.jar, &r.info) else {
    // rust: if chosen && !only.is_empty() {
    // rust: log(format!(
    // rust: "{}: no jar (put it in {}/jars/)",
    // rust: r.key,
    // rust: work.display()
    // rust: ));
}
    // rust: continue;
}
    // rust: if !chosen {
    // rust: continue;
}
        // The oracle's facts for the mods it ran; a mod it did not load (a
        // library missing) keeps the guesses from its blockstates.
    // rust: let prefix = format!("{}:", info.mod_id);
    // rust: let seen = |f: &&oracle::Facts| {
    // rust: f.blocks
    // rust: .keys()
    // rust: .chain(f.items.keys())
    // rust: .any(|k| k.starts_with(&prefix))
}
    // rust: match carry::carry(
    // rust: jar,
    // rust: info,
    // rust: &work.join("mods").join(&r.key),
    // rust: facts.as_ref().filter(seen),
    // rust: &allowed,
    // rust: &pack,
    // rust: &conventions,
    // rust: ) {
    // rust: Ok(report) => {
    // rust: done += 1;
    // rust: log(format!(
    // rust: "{}: {} files, {} recipes upgraded ({} kept), {} loot tables upgraded ({} added), {} item definitions added, {} blocks ({} left out, {} with differences), {} items ({} left out), {} convention tags, {} outside",
    // rust: r.key,
    // rust: report.copied,
    // rust: report.recipes_upgraded,
    // rust: report.recipes_kept.len(),
    // rust: report.loot_tables_upgraded,
    // rust: report.loot_tables_added,
    // rust: report.item_definitions_added,
    // rust: report.blocks.len(),
    // rust: report.blocks_unknown.len(),
    // rust: report.differences.len(),
    // rust: report.items,
    // rust: report.items_unknown.len(),
    // rust: report.convention_tags,
    // rust: report.outside.len()
    // rust: ));
}
    // rust: Err(e) => log(format!("{}: {e}", r.key)),
}
}
    // rust: log(format!(
    // rust: "{done} mods carried over into {}",
    // rust: work.join("mods").display()
    // rust: ));
    // rust: Ok(done)
}

// Which carried-over mods (`mods/<key>/carry` folders) the game loads together, in the order
// given: as the game does, the first of two owning one namespace stays on. Returns the ones on,
// and a line for each one left off.
loadable :: proc(mods: ^[std::path::PathBuf]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut on: Vec<(std::path::PathBuf, String, Vec<String>)> = Vec::new();
    // rust: let mut off = Vec::new();
    // rust: for path in mods {
    // rust: let manifest = fs::read_to_string(path.join(horizon_mods::manifest::MANIFEST))
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|t| horizon_mods::Manifest::parse(&t));
    // rust: let m = match manifest {
    // rust: Ok(m) => m,
    // rust: Err(e) => {
    // rust: off.push(format!("{}: {e}", path.display()));
    // rust: continue;
}
}
    // rust: let owned: Vec<String> = std::iter::once(m.id.clone())
    // rust: .chain(m.namespaces.iter().cloned())
    // rust: .collect();
    // rust: let clash = on
    // rust: .iter()
    // rust: .find_map(|(_, id, ns)| horizon_mods::content::clash((id, ns), (&m.id, &owned)));
    // rust: match clash {
    // rust: Some(why) => off.push(format!("{} not loaded: {why}", m.id)),
    // rust: None => on.push((path.clone(), m.id, owned)),
}
}
    // rust: (on.into_iter().map(|(p, _, _)| p).collect(), off)
}

// The namespaces more than one mod claims, from each mod's (key, claimed namespaces).
    // rust: fn shared_namespaces<'a>(
    // rust: claims: impl Iterator<Item = (&'a str, Vec<String>)>,
    // rust: log: Log,
    // rust: ) -> BTreeSet<String> {
    // rust: let mut by_namespace: BTreeMap<String, Vec<&str>> = BTreeMap::new();
    // rust: for (key, owned) in claims {
    // rust: for ns in owned {
    // rust: by_namespace.entry(ns).or_default().push(key);
}
}
    // rust: by_namespace
    // rust: .into_iter()
    // rust: .filter(|(_, mods)| mods.len() > 1)
    // rust: .map(|(ns, mods)| {
    // rust: log(format!(
    // rust: "namespace {ns} is claimed by {}: left to none of them",
    // rust: mods.join(", ")
    // rust: ));
    // rust: ns
    // rust: })
    // rust: .collect()
}

// The pack's title as the report heads it.
title :: proc(pack: ^import::Pack) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "{} ({} {}, Minecraft {})",
    // rust: pack.name, pack.loader, pack.loader_version, pack.minecraft
    // rust: )
}

// Step 7: `<work>/coverage.json` and `coverage.md`.
report :: proc(work: ^Path, log: Log) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let pack: import::Pack = read_json(&work.join("pack.json"))?;
    // rust: let records: Vec<inventory::Record> = read_json(&work.join("inventory.json"))?;
    // rust: let rows = report::build(&records, work);
    // rust: write_json(&work.join("coverage.json"), &rows)?;
    // rust: let title = title(&pack);
    // rust: fs::write(work.join("coverage.md"), report::markdown(&title, &rows))
    // rust: .map_err(|e| format!("coverage.md: {e}"))?;
    // rust: log(format!(
    // rust: "{title}: {} files: {:?}",
    // rust: rows.len(),
    // rust: report::counts(&rows)
    // rust: ));
    // rust: Ok(rows)
}

// What a player's machine can port today without an agent: content mods
// of the data tier (carry-over only).
portable :: proc(r: ^inventory::Record) -> b {
    // Ported from Horizon
    return {}
}
    // rust: r.class == "content" && r.tier == "data"
}

// Everything after the import, for the portable mods: their jars (`fetch`,
// from `from` when the player has them), the inventory again with the jars
// read, the carry-over and the report. `resources` is the prepared
// version the ports will play on.
    // rust: pub fn port(
    // rust: work: &Path,
    // rust: resources: Option<&Path>,
    // rust: from: Option<&Path>,
    // rust: log: Log,
    // rust: ) -> Result<(fetch::Fetched, Vec<report::Row>), String> {
    // rust: let records = match read_json::<Vec<inventory::Record>>(&work.join("inventory.json")) {
    // rust: Ok(r) => r,
    // rust: Err(_) => inventory(work, false, log)?,
}
    // rust: crate::resourcepacks::fetch(work, log)?;
    // rust: let fetched = fetch::fetch(work, &records, from, &portable, log)?;
    // The jars tell classes and tiers better than metadata alone.
    // rust: let records = inventory(work, true, log)?;
    // rust: let only: Vec<String> = records
    // rust: .iter()
    // rust: .filter(|r| portable(r) && r.jar.is_some())
    // rust: .map(|r| r.key.clone())
    // rust: .collect();
    // rust: if only.is_empty() {
    // rust: log("no portable mod has its jar: nothing to carry over".into());
    // rust: } else {
    // rust: carry(work, resources, &only, log)?;
}
    // rust: Ok((fetched, report(work, log)?))
}

    // rust: mod tests {
//     use super::*;

prepared_resources_without_items_json_still_carry :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("port-pack-no-items-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let (work, resources) = (root.join("work"), root.join("resources"));
    // rust: fs::create_dir_all(work.join("oracle")).unwrap();
    // rust: fs::create_dir_all(&resources).unwrap();
    // rust: fs::write(work.join("inventory.json"), "[]").unwrap();
    // rust: fs::write(
    // rust: work.join("oracle/facts.json"),
    // rust: r#"{"blocks": {}, "items": {}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let logged = std::cell::RefCell::new(Vec::new());
    // rust: let log = |line: String| logged.borrow_mut().push(line);
    // rust: assert_eq!(carry(&work, Some(&resources), &[], &log), Ok(0));
    // rust: let logged = logged.borrow();
    // rust: assert!(
    // rust: logged
    // rust: .iter()
    // rust: .any(|l| l.contains("without the game's tables")),
    // rust: "{logged:?}"
    // rust: );
    // rust: fs::remove_dir_all(&root).unwrap();
}

a_namespace_two_mods_claim_is_neither_s :: proc() {
}
    // rust: let claims = [
    // rust: ("betterdungeons", vec!["yungsapi".to_owned()]),
    // rust: ("betterfortresses", vec!["yungsapi".to_owned()]),
    // rust: (
    // rust: "towns_and_towers",
    // rust: vec!["kaisyn".to_owned(), "towns_and_towers".to_owned()],
    // rust: ),
    // rust: ];
    // rust: let shared = shared_namespaces(claims.into_iter(), &|_| {});
    // rust: assert_eq!(shared.into_iter().collect::<Vec<_>>(), ["yungsapi"]);
}

the_first_of_two_mods_owning_a_namespace_loads :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("port-pack-loadable-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let carry = |key: &str, namespaces: &str| {
    // rust: let dir = root.join(key).join("carry");
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: fs::write(
    // rust: dir.join("horizon-mod.toml"),
    // rust: format!(
    // rust: "id = \"{key}\"\nname = \"{key}\"\nversion = \"1\"\napi = \"0.2\"\n\
    // rust: capabilities = [\"registries\"]\nnamespaces = [{namespaces}]\n"
    // rust: ),
    // rust: )
    // rust: .unwrap();
    // rust: dir
}
    // rust: let mods = [
    // rust: carry("betterdungeons", "\"yungsapi\""),
    // rust: carry("betterfortresses", "\"yungsapi\""),
    // rust: carry("ruby", ""),
    // rust: ];
    // rust: let (on, off) = loadable(&mods);
    // rust: assert_eq!(on, [mods[0].clone(), mods[2].clone()]);
    // rust: assert_eq!(off.len(), 1);
    // rust: assert!(off[0].starts_with("betterfortresses not loaded"), "{off:?}");
    // rust: fs::remove_dir_all(&root).unwrap();
}
}
