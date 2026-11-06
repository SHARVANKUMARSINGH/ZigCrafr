//! Transpiled from Horizon Rust crate
package horizon_port_pack_inventory

import "core:fmt"
import "core:mem"
import "core:math"

// Step 2, inventory: one record per pack file, from the jar (when the
// user's instance has it) and Modrinth's metadata, classified and ordered.
// use crate::{
    // rust: classify::{self, Facts, Known},
    // rust: import::Pack,
    // rust: jar::{self, JarInfo},
    // rust: modrinth::Cache,
}
// use serde::{Deserialize, Serialize};
// use std::{
    // rust: collections::{BTreeMap, HashMap},
    // rust: path::{Path, PathBuf},
}

Record :: struct {
    // The mod id from the jar, else the Modrinth slug, else the file name.
    key: string,
    name: string,
    version: string,
    path: string,
    class: string,
    tier: string,
    // `known` (reviewed table), `sides`, `categories`, `jar`, `kind`,
    // `guess` or `unknown`.
    confidence: string,
    // `modrinth`, `curseforge` or `file`.
    source: string,
    license: string,
    client: string,
    server: string,
    categories: [dynamic]string,
    // Required dependencies inside the pack, by key.
    depends: [dynamic]string,
    // Required dependencies the pack does not have.
    missing: [dynamic]string,
    layer: uint,
    jar: Maybe(PathBuf),
    info: Maybe(JarInfo),
}

// The jar of a pack file: the instance's own, or one the user put in
// `<work>/jars/`.
jar_of :: proc(pack_jar: Maybe(^PathBuf), file_name: string, work: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: pack_jar
    // rust: .cloned()
    // rust: .or_else(|| Some(work.join("jars").join(file_name)))
    // rust: .filter(|p| p.is_file())
}

build :: proc(pack: ^Pack, cache: ^Cache, work: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let known = Known::atm10();
    // rust: let mut records = Vec::new();
    // Modrinth project id -> record key, for dependencies.
    // rust: let mut by_project: HashMap<String, String> = HashMap::new();
    // rust: let mut project_deps: Vec<Vec<String>> = Vec::new();
    // rust: for f in &pack.files {
    // rust: let jar = jar_of(f.jar.as_ref(), f.file_name(), work);
    // rust: let info = jar.as_deref().and_then(|j| jar::read(j).ok());
    // rust: let sha1 = f.sha1.as_deref().unwrap_or("");
    // rust: let project = cache.project_of(sha1);
    // rust: let p = |k: &str| project.and_then(|p| p[k].as_str()).unwrap_or("").to_owned();
    // rust: let categories: Vec<String> = project
    // rust: .into_iter()
    // rust: .flat_map(|p| {
    // rust: ["categories", "additional_categories"]
    // rust: .iter()
    // rust: .flat_map(|k| p[*k].as_array().cloned().unwrap_or_default())
    // rust: })
    // rust: .filter_map(|c| c.as_str().map(str::to_owned))
    // rust: .collect();
    // rust: let stem = f.file_name().trim_end_matches(".jar").to_owned();
    // rust: let key = info
    // rust: .as_ref()
    // rust: .map(|i| i.mod_id.clone())
    // rust: .filter(|k| !k.is_empty())
    // rust: .or_else(|| f.mod_id.clone())
    // rust: .or_else(|| Some(p("slug")).filter(|s| !s.is_empty()))
    // rust: .unwrap_or(stem);
    // rust: let (client, server) = match project {
    // rust: Some(_) if f.client.is_empty() => (p("client_side"), p("server_side")),
    // rust: _ => (f.client.clone(), f.server.clone()),
}
    // rust: let census = info.as_ref().map(|i| &i.census);
    // rust: let facts = Facts {
    // rust: kind: f.kind(),
    // rust: client: &client,
    // rust: server: &server,
    // rust: categories: &categories,
    // rust: classes: census.map(|c| c.classes),
    // rust: has_content: census.is_some_and(|c| c.blockstates + c.item_models + c.recipes > 0),
}
    // rust: let name = info
    // rust: .as_ref()
    // rust: .map(|i| i.name.clone())
    // rust: .filter(|n| !n.is_empty())
    // rust: .or_else(|| Some(p("title")).filter(|t| !t.is_empty()))
    // rust: .or_else(|| f.name.clone())
    // rust: .unwrap_or_default();
    // rust: let (class, tier, confidence) =
    // rust: match known.get(&[key.as_str(), p("slug").as_str(), name.as_str()]) {
    // rust: Some((c, t)) => (c.clone(), t.clone(), "known".to_owned()),
    // rust: None => {
    // rust: let (c, t, conf) = classify::rules(&facts);
    // rust: (c.into(), t.into(), conf.into())
}
}
    // rust: let license = info
    // rust: .as_ref()
    // rust: .map(|i| i.license.clone())
    // rust: .filter(|l| !l.is_empty())
    // rust: .or_else(|| project.and_then(|p| p["license"]["id"].as_str().map(str::to_owned)))
    // rust: .unwrap_or_else(|| "unknown".into());
    // rust: if let Some(id) = project.and_then(|p| p["id"].as_str()) {
    // rust: by_project.insert(id.to_owned(), key.clone());
}
    // rust: project_deps.push(cache.required(sha1));
    // rust: records.push(Record {
    // rust: name,
    // rust: version: info.as_ref().map(|i| i.version.clone()).unwrap_or_else(|| {
    // rust: cache
    // rust: .versions
    // rust: .get(sha1)
    // rust: .and_then(|v| v["version_number"].as_str())
    // rust: .map(str::to_owned)
    // rust: .or_else(|| f.version.clone())
    // rust: .unwrap_or_default()
    // rust: }),
    // rust: path: f.path.clone(),
    // rust: class,
    // rust: tier,
    // rust: confidence,
    // rust: source: if project.is_some() {
    // rust: "modrinth".into()
    // rust: } else if f.curseforge.is_some() {
    // rust: "curseforge".into()
    // rust: } else {
    // rust: "file".into()
    // rust: },
    // rust: license,
    // rust: client,
    // rust: server,
    // rust: categories,
    // rust: depends: info.as_ref().map(|i| i.depends.clone()).unwrap_or_default(),
    // rust: jar,
    // rust: info,
    // rust: key,
    // rust: ..Record::default()
    // rust: });
}
    // Dependencies: the jar's mod ids, else Modrinth's required projects.
    // rust: let keys: std::collections::HashSet<String> = records.iter().map(|r| r.key.clone()).collect();
    // rust: for (r, deps) in records.iter_mut().zip(project_deps) {
    // rust: if r.depends.is_empty() {
    // rust: r.depends = deps
    // rust: .iter()
    // rust: .map(|p| {
    // rust: by_project
    // rust: .get(p)
    // rust: .cloned()
    // rust: .unwrap_or_else(|| format!("modrinth:{p}"))
    // rust: })
    // rust: .collect();
}
    // rust: let (inside, missing): (Vec<String>, Vec<String>) =
    // rust: r.depends.drain(..).partition(|d| keys.contains(d));
    // rust: r.depends = inside;
    // rust: r.missing = missing;
}
    // rust: let graph: BTreeMap<String, Vec<String>> = records
    // rust: .iter()
    // rust: .map(|r| (r.key.clone(), r.depends.clone()))
    // rust: .collect();
    // rust: let layers = classify::layers(&graph);
    // rust: for r in &mut records {
    // rust: r.layer = layers.get(&r.key).copied().unwrap_or(0);
}
    // rust: records.sort_by(|a, b| (a.layer, &a.key).cmp(&(b.layer, &b.key)));
    // rust: records
}

// Counts by a field, largest first.
    // rust: pub fn counts<'a>(
    // rust: records: &'a [Record],
    // rust: field: impl Fn(&'a Record) -> &'a str,
    // rust: ) -> Vec<(&'a str, usize)> {
    // rust: let mut m: BTreeMap<&str, usize> = BTreeMap::new();
    // rust: for r in records {
    // rust: *m.entry(field(r)).or_default() += 1;
}
    // rust: let mut v: Vec<_> = m.into_iter().collect();
    // rust: v.sort_by(|a, b| b.1.cmp(&a.1).then(a.0.cmp(b.0)));
    // rust: v
}

// `inventory.csv`: the columns of `docs/modpacks/atm10-mods.csv`, plus the layer.
csv :: proc(records: ^[Record]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let field = |s: &str| {
    // rust: if s.contains([',', '"', '\n']) {
    // rust: format!("\"{}\"", s.replace('"', "\"\""))
    // rust: } else {
    // rust: s.to_owned()
}
}
    // rust: let mut out = String::from(
    // rust: "mod_id,name,version,class,tier,confidence,source,license,client,server,layer\n",
    // rust: );
    // rust: for r in records {
    // rust: let row = [
    // rust: &r.key,
    // rust: &r.name,
    // rust: &r.version,
    // rust: &r.class,
    // rust: &r.tier,
    // rust: &r.confidence,
    // rust: &r.source,
    // rust: &r.license,
    // rust: &r.client,
    // rust: &r.server,
    // rust: ];
    // rust: let cells: Vec<String> = row.iter().map(|s| field(s)).collect();
    // rust: out.push_str(&format!("{},{}\n", cells.join(","), r.layer));
}
    // rust: out
}
