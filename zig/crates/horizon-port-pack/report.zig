//! Transpiled from Horizon Rust crate
//! Module: horizon-port-pack_report
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Step 7, the coverage report: per mod, ported, partial, not yet or not
//! needed, with the reason, and the totals by class, tier and licence
//! (`coverage.json`, `coverage.md`). It reads what the other steps wrote:
//! the inventory, each mod's `carry-report.json` and its harness result
//! (`tools/mod_port_harness.py`).
// use crate::{
    // rust: inventory::Record,
    // rust: resourcepacks::{Outcome, Report, State},
}
// use serde::{Deserialize, Serialize};
// use serde_json::Value;
// use std::{collections::BTreeMap, fmt::Write, path::Path};

pub const Status = enum {
    Ported,
    Partial,
    NotYet,
    NotNeeded,
};
    // rust: impl Status {
    // rust: pub const ALL: [Status; 4] = [
    // rust: Status::Ported,
    // rust: Status::Partial,
    // rust: Status::NotYet,
    // rust: Status::NotNeeded,
    // rust: ];
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Status::Ported => "ported",
    // rust: Status::Partial => "partial",
    // rust: Status::NotYet => "not yet",
    // rust: Status::NotNeeded => "not needed",
}
}
    /// What the status leaves out, in plain words.
pub fn meaning(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Status::Ported => PLAIN_PORTED,
    // rust: Status::Partial => PLAIN_PARTIAL,
    // rust: Status::NotYet => "It does not come over yet.",
    // rust: Status::NotNeeded => "Nothing to port: Horizon has it built in or does not need it.",
}
}
}

    // rust: const PLAIN_PORTED: &str =
    // rust: "Its blocks and items came over and passed Horizon's checks; the mod's own code is not run.";
pub const PLAIN_PARTIAL: []const u8 = "Part of it came over, but something is left out, differs from the original or has not been checked yet; the technical detail says what.";

pub const Row = struct {
    key: []const u8,
    name: []const u8,
    class: []const u8,
    tier: []const u8,
    license: []const u8,
    /// `permissive`, `copyleft`, `all-rights-reserved`, `restricted`
    /// (non-commercial or no-derivatives), `custom` or `unknown`.
    license_kind: []const u8,
    status: Status,
    /// The technical reason, for modders (the `why` column of `coverage.md`).
    reason: []const u8,
    /// The same in plain words for a player. Empty in a `coverage.json` an older build wrote.
    plain: []const u8,
    /// Unported dependencies, kept apart so the launcher can translate the fixed sentence.
    waiting: usize,
};

    // rust: impl Row {
    /// The standalone coverage report stays English, including the dependency count.
pub fn plain_text(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut plain = self.plain.clone();
    // rust: match self.waiting {
    // rust: 0 => {}
    // rust: 1 => plain.push_str(" It also waits for 1 mod it depends on that is not ported yet."),
    // rust: n => {
    // rust: let _ = write!(
    // rust: plain,
    // rust: " It also waits for {n} mods it depends on that are not ported yet."
    // rust: );
}
}
    // rust: plain
}
}

/// The licence family of an SPDX id or a `mods.toml` licence text.
pub fn license_kind(license: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let l = license.to_ascii_lowercase();
    // rust: if l.is_empty() || l.starts_with("unknown") {
    // rust: "unknown"
    // rust: } else if l.contains("-nc") || l.contains("-nd") || l.contains("noncommercial") {
    // rust: "restricted"
    // rust: } else if l.contains("all-rights-reserved") || l.contains("all rights reserved") || l == "arr" {
    // rust: "all-rights-reserved"
    // rust: } else if ["gpl", "mpl", "eupl", "general public"]
    // rust: .iter()
    // rust: .any(|k| l.contains(k))
    // rust: {
    // rust: "copyleft"
    // rust: } else if [
    // rust: "mit",
    // rust: "apache",
    // rust: "bsd",
    // rust: "cc0",
    // rust: "cc-by",
    // rust: "unlicense",
    // rust: "isc",
    // rust: "zlib",
    // rust: ]
    // rust: .iter()
    // rust: .any(|k| l.contains(k))
    // rust: {
    // rust: "permissive"
    // rust: } else {
    // rust: "custom"
}
}

/// What still blocks a mod of this tier that has not been carried over.
pub fn not_yet(tier: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tier {
    // rust: "data" => "data tier: carry-over only, no agent; its jar is not here yet (fetch gets it)",
    // rust: "logic" => {
    // rust: "needs mod API 0.3: behaviour callbacks (use, place, break, ticks) and server events"
}
    // rust: "machines" => "needs mod API 0.4: block entities, menus, capabilities and mod networking",
    // rust: "deep" => {
    // rust: "needs mod API 0.5: entities, custom renderers and models, dimensions, new vanilla hooks"
}
    // rust: "client" => "needs the client interfaces (keys, target, inventory-read, ui, render)",
    // rust: _ => "not classified",
}
}

pub fn not_needed(class: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match class {
    // rust: "library" => "library: its API maps to Horizon's mod API and SDK",
    // rust: "performance" => "performance mod: Horizon's engine is the replacement",
    // rust: "other" => "pack tooling or an engine feature, folded into the pipeline or the engine",
    // rust: "client-ui" => "built into Horizon",
    // rust: _ => "nothing to port",
}
}

/// What keeps a mod that has not been carried over from coming over, in plain words.
pub fn plain_not_yet(r: *Record) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if r.class == "unknown" {
    // rust: return "Horizon cannot tell yet what this mod does (it needs its jar or a reviewed entry), so it cannot say whether it will come over.";
}
    // rust: if r.class == "integration" {
    // rust: return "It joins other mods together, so it waits until those are ported.";
}
    // rust: match r.tier.as_str() {
    // rust: "data" if r.jar.is_some() => {
    // rust: "Content only (blocks, items, structures). Its jar is here, but it has not been carried over yet."
}
    // rust: "data" => {
    // rust: "Content only (blocks, items, structures). It can come over once its jar is here."
}
    // rust: "logic" => {
    // rust: "Needs what blocks and items do when used, placed, broken or ticked, which Horizon's mod API cannot run from a mod yet, so it does not come over."
}
    // rust: "machines" => {
    // rust: "Needs machine-style features (block entities, menus, item, fluid and energy handling, networking) that Horizon's mod API does not have yet, so it does not come over."
}
    // rust: "deep" => {
    // rust: "Needs mobs, custom rendering and models, dimensions or new game hooks that Horizon's mod API does not have yet, so it does not come over."
}
    // rust: "client" => {
    // rust: "Needs the game's client interfaces (keys, targeting, inventory reading, interface, rendering), so it does not come over yet."
}
    // rust: _ => "Horizon has not worked out what this mod needs yet.",
}
}

pub fn plain_not_needed(class: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match class {
    // rust: "library" => {
    // rust: "A library other mods build on. Horizon's mod API and SDK take its place, so there is nothing to port."
}
    // rust: "performance" => {
    // rust: "It makes the game faster. Horizon's own engine does that, so there is nothing to port."
}
    // rust: "other" => {
    // rust: "Pack tooling or a game feature that Horizon already has, so there is nothing to port."
}
    // rust: "client-ui" => "Built into Horizon already, so there is nothing to port.",
    // rust: _ => "Nothing to port.",
}
}

/// A carried-over mod: ported when its harness passes with nothing left
/// out and nothing the templates miss; else partial, with what is missing.
pub fn carried(work: *Path, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = work.join("mods").join(key);
    // rust: let carry: Value =
    // rust: serde_json::from_slice(&std::fs::read(dir.join("carry-report.json")).ok()?).ok()?;
    // rust: let count = |k: &str| carry[k].as_object().map_or(0, |o| o.len());
    // rust: let (blocks, items) = (count("blocks"), carry["items"].as_u64().unwrap_or(0));
    // rust: let (left_blocks, left_items) = (count("blocks_unknown"), count("items_unknown"));
    // A class of its own is code the facts cannot show; anything else the
    // template misses (shapes, sounds) the harness also reports.
    // rust: let mut differences = 0;
    // rust: let mut own_code = 0;
    // rust: for list in carry["differences"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(_, v)| v)
    // rust: {
    // rust: let notes: Vec<&str> = list
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(Value::as_str)
    // rust: .collect();
    // rust: if notes.iter().any(|n| n.starts_with("class ")) {
    // rust: own_code += 1;
}
    // rust: if notes.iter().any(|n| !n.starts_with("class ")) {
    // rust: differences += 1;
}
}
    // rust: let mut gaps = Vec::new();
    // rust: if left_blocks > 0 {
    // rust: gaps.push(format!(
    // rust: "{left_blocks} blocks left out (no vanilla template)"
    // rust: ));
}
    // rust: if left_items > 0 {
    // rust: gaps.push(format!("{left_items} items left out"));
}
    // rust: if differences > 0 {
    // rust: gaps.push(format!(
    // rust: "{differences} blocks or items differ from their templates"
    // rust: ));
}
    // rust: let harness: Option<Value> = std::fs::read(dir.join("harness/result.json"))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice(&b).ok());
    // rust: let mut checked = 0;
    // rust: match &harness {
    // rust: Some(h) => {
    // rust: if h["passed"].as_bool() == Some(false) {
    // rust: gaps.push("harness failed".into());
}
    // rust: for (name, c) in h["checks"].as_object().into_iter().flatten() {
    // rust: let (p, f) = (
    // rust: c["passed"].as_u64().unwrap_or(0),
    // rust: c["failed"].as_u64().unwrap_or(0),
    // rust: );
    // rust: checked += p + f;
    // rust: if f > 0 {
    // rust: gaps.push(format!("{name} {p}/{}", p + f));
}
}
    // rust: if checked == 0 {
    // rust: gaps.push("harness has no checks".into());
}
}
    // rust: None => gaps.push("harness not run".into()),
}
    // rust: let worldgen = carry["worldgen"].as_u64().unwrap_or(0);
    // rust: if blocks == 0 && items == 0 && checked == 0 {
    // rust: let what = if worldgen > 0 {
    // rust: format!("{worldgen} worldgen files carried, not compared yet")
    // rust: } else {
    // rust: "nothing registered to compare".into()
}
    // rust: return Some((Status::Partial, what));
}
    // rust: let mut summary = format!("{blocks} blocks, {items} items");
    // rust: if own_code > 0 {
    // rust: let _ = write!(
    // rust: summary,
    // rust: " ({own_code} with code of their own, not compared)"
    // rust: );
}
    // rust: if gaps.is_empty() {
    // rust: Some((Status::Ported, format!("{summary}; harness green")))
    // rust: } else {
    // rust: Some((Status::Partial, format!("{summary}; {}", gaps.join("; "))))
}
}

pub fn resource_row(path: []const u8, outcome: ?*Outcome, record: ?*Record) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = outcome.map_or(State::Missing, |o| o.state);
    // rust: let shader = path.starts_with("shaderpacks/");
    // rust: Row {
    // rust: key: path.into(),
    // rust: name: path.into(),
    // rust: class: if shader { "shaderpack" } else { "resourcepack" }.into(),
    // rust: tier: "data".into(),
    // rust: license: record.map_or("unknown", |r| r.license.as_str()).into(),
    // rust: license_kind: license_kind(record.map_or("unknown", |r| r.license.as_str())).into(),
    // rust: status: if !shader && state == State::Available {
    // rust: Status::Partial
    // rust: } else {
    // rust: Status::NotYet
    // rust: },
    // rust: waiting: 0,
    // rust: plain: match (shader, outcome.map(|o| o.state)) {
    // rust: (true, _) => "Shader packs are not converted yet.",
    // rust: (false, Some(State::Available)) => "Copied as a resource pack; Horizon has not checked how it renders. Turn it on in the game's Resource Packs screen.",
    // rust: (false, None) => "Not downloaded yet; Port gets it.",
    // rust: (false, Some(_)) => "Horizon could not use this resource pack yet; the technical detail says why.",
}
    // rust: .into(),
    // rust: reason: outcome.map_or_else(
    // rust: || {
    // rust: if shader {
    // rust: "shader-pack conversion is pending".into()
    // rust: } else {
    // rust: "resource pack not obtained yet; run port".into()
}
    // rust: },
    // rust: |o| format!("{:?}: {}", o.state, o.detail),
    // rust: ),
}
}

pub fn build(records: *[Record], work: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let resourcepacks = Report::load(work);
    // rust: let mut rows: Vec<Row> = records
    // rust: .iter()
    // rust: .map(|r| {
    // rust: if r.path.starts_with("resourcepacks/") || r.path.starts_with("shaderpacks/") {
    // rust: return resource_row(&r.path, resourcepacks.files.get(&r.path), Some(r));
}
    // rust: let (status, reason) = if r.class == "unknown" {
    // rust: let why =
    // rust: "unclassified: its jar (mods.toml, file census) or a reviewed row decides";
    // rust: (Status::NotYet, why.to_owned())
    // rust: } else if r.tier == "none" || matches!(r.class.as_str(), "library" | "performance") {
    // rust: (Status::NotNeeded, not_needed(&r.class).to_owned())
    // rust: } else if let Some(c) = carried(work, &r.key) {
    // rust: c
    // rust: } else {
    // rust: let mut why = not_yet(&r.tier).to_owned();
    // rust: if r.tier == "data" && r.jar.is_some() {
    // rust: why = "data tier: carry-over not run yet".into();
}
    // rust: if r.class == "integration" {
    // rust: why = format!("after the mods it joins are ported; {why}");
}
    // rust: (Status::NotYet, why)
}
    // rust: Row {
    // rust: key: r.key.clone(),
    // rust: name: r.name.clone(),
    // rust: class: r.class.clone(),
    // rust: tier: r.tier.clone(),
    // rust: license: r.license.clone(),
    // rust: license_kind: license_kind(&r.license).to_owned(),
    // rust: status,
    // rust: reason,
    // rust: waiting: 0,
    // rust: plain: match status {
    // rust: Status::NotYet => plain_not_yet(r),
    // rust: Status::NotNeeded => plain_not_needed(&r.class),
    // rust: carried => carried.meaning(),
}
    // rust: .into(),
}
    // rust: })
    // rust: .collect();
    // A mod waits on its dependencies that are not ported.
    // rust: let status: BTreeMap<String, Status> = rows.iter().map(|r| (r.key.clone(), r.status)).collect();
    // rust: for (row, r) in rows.iter_mut().zip(records) {
    // rust: if row.status == Status::NotNeeded {
    // rust: continue;
}
    // rust: let waiting: Vec<&str> = r
    // rust: .depends
    // rust: .iter()
    // rust: .filter(|d| status.get(*d) == Some(&Status::NotYet))
    // rust: .map(String::as_str)
    // rust: .collect();
    // rust: if !waiting.is_empty() {
    // rust: let _ = write!(row.reason, "; waits on {}", waiting.join(", "));
    // rust: row.waiting = waiting.len();
}
}
    // rust: for (path, outcome) in &resourcepacks.files {
    // rust: if !records.iter().any(|r| &r.path == path) {
    // rust: rows.push(resource_row(path, Some(outcome), None));
}
}
    // rust: rows
}

/// What a pack's mods add up to, for the headline above the numbers. It counts the report's own
/// rows and tiers; resource packs and shader packs are not mods and are left out.
pub const Summary = struct {
    /// Mods that need a port: all but the "not needed" ones.
    needing: usize,
    /// Ported or partial: carried over, as content.
    carried: usize,
    /// Of those, partial.
    partial: usize,
    /// Not yet: content of the data tier, which port can carry over.
    ready: usize,
    /// Not yet: needs mod API Horizon does not have yet (every tier above data).
    blocked: usize,
    /// Not yet, for another reason: not identified, or waiting on other mods or other work.
    later: usize,
};

pub fn summary(rows: *[Row]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = Summary::default();
    // rust: for r in rows
    // rust: .iter()
    // rust: .filter(|r| !matches!(r.class.as_str(), "resourcepack" | "shaderpack"))
    // rust: {
    // rust: match r.status {
    // rust: Status::NotNeeded => continue,
    // rust: Status::Ported => s.carried += 1,
    // rust: Status::Partial => (s.carried, s.partial) = (s.carried + 1, s.partial + 1),
    // rust: Status::NotYet if r.class == "content" && r.tier == "data" => s.ready += 1,
    // rust: Status::NotYet
    // rust: if r.class != "unknown"
    // rust: && matches!(r.tier.as_str(), "logic" | "machines" | "deep" | "client") =>
    // rust: {
    // rust: s.blocked += 1
}
    // rust: Status::NotYet => s.later += 1,
}
    // rust: s.needing += 1;
}
    // rust: s
}

    // rust: impl Summary {
    /// The headline in plain words, one paragraph per line; none for a pack with no mod to port.
    /// The launcher words the same lines through its translations (a test keeps them equal).
pub fn lines(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.needing == 0 {
    // rust: return Vec::new();
}
    // rust: let mut lines = vec![format!(
    // rust: "{} of {} mods that need porting come over as content (blocks, items and structures); their own code does not run.",
    // rust: self.carried, self.needing
    // rust: )];
    // rust: if self.ready + self.blocked + self.later > 0 {
    // rust: lines.push(format!(
    // rust: "Not yet: {} are content mods Port can carry over, {} need mod support Horizon does not have yet (machines, menus, behaviour, mobs, dimensions, client features), {} are not sorted yet (not identified, or waiting on other mods or other work).",
    // rust: self.ready, self.blocked, self.later
    // rust: ));
}
    // rust: if self.partial > 0 {
    // rust: lines.push(
    // rust: "Partial means part of a mod came over, but something is left out, differs from the original or has not been checked yet."
    // rust: .into(),
    // rust: );
}
    // rust: lines
}
}

/// Rows counted by `field` and status.
pub fn table(rows: *[Row], title: []const u8, field: fn(*Row) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut counts: BTreeMap<&str, [usize; 4]> = BTreeMap::new();
    // rust: for r in rows {
    // rust: let i = Status::ALL.iter().position(|s| *s == r.status).unwrap_or(0);
    // rust: counts.entry(field(r)).or_default()[i] += 1;
}
    // rust: let mut out = format!(
    // rust: "| {title} | ported | partial | not yet | not needed | all |\n|---|---:|---:|---:|---:|---:|\n"
    // rust: );
    // rust: let mut totals = [0usize; 4];
    // rust: for (k, c) in &counts {
    // rust: let all: usize = c.iter().sum();
    // rust: let _ = writeln!(
    // rust: out,
    // rust: "| {k} | {} | {} | {} | {} | {all} |",
    // rust: c[0], c[1], c[2], c[3]
    // rust: );
    // rust: for (t, n) in totals.iter_mut().zip(c) {
    // rust: *t += n;
}
}
    // rust: let all: usize = totals.iter().sum();
    // rust: let _ = writeln!(
    // rust: out,
    // rust: "| **all** | **{}** | **{}** | **{}** | **{}** | **{all}** |",
    // rust: totals[0], totals[1], totals[2], totals[3]
    // rust: );
    // rust: out
}

pub fn markdown(pack: []const u8, rows: *[Row]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = format!("# Coverage: {pack}\n\n");
    // rust: let lines = summary(rows).lines();
    // rust: if !lines.is_empty() {
    // rust: out += &format!("**{}**\n\n", lines[0]);
    // rust: for line in &lines[1..] {
    // rust: out += &format!("{line}\n\n");
}
    // rust: out += "The tables below use the technical terms; the last column of the list says the same in plain words.\n\n";
}
    // rust: out += &table(rows, "class", |r| &r.class);
    // rust: out += "\n";
    // rust: out += &table(rows, "tier", |r| &r.tier);
    // rust: out += "\n";
    // rust: out += &table(rows, "licence", |r| &r.license_kind);
    // rust: out += "\nPorts stay local. Only permissive or copyleft ports could ever be published, and only after Ludovic asks the authors.\n\n";
    // rust: out += "| mod | class | tier | licence | status | why | in plain words |\n|---|---|---|---|---|---|---|\n";
    // rust: let mut sorted: Vec<&Row> = rows.iter().collect();
    // rust: sorted.sort_by(|a, b| (a.status, &a.key).cmp(&(b.status, &b.key)));
    // rust: for r in sorted {
    // rust: let _ = writeln!(
    // rust: out,
    // rust: "| {} | {} | {} | {} | {} | {} | {} |",
    // rust: r.key,
    // rust: r.class,
    // rust: r.tier,
    // rust: r.license.replace('|', "/"),
    // rust: r.status.label(),
    // rust: r.reason.replace('|', "/"),
    // rust: r.plain_text().replace('|', "/")
    // rust: );
}
    // rust: out
}

pub fn counts(rows: *[Row]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Status::ALL
    // rust: .iter()
    // rust: .map(|s| (s.label(), rows.iter().filter(|r| r.status == *s).count()))
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;

pub fn record(key: []const u8, class: []const u8, tier: []const u8, depends: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Record {
    // rust: key: key.into(),
    // rust: class: class.into(),
    // rust: tier: tier.into(),
    // rust: license: "MIT".into(),
    // rust: depends: depends.iter().map(|d| (*d).to_owned()).collect(),
    // rust: ..Record::default()
}
}

pub fn statuses_and_reasons() void {
}
    // rust: let work = std::env::temp_dir().join(format!("horizon-report-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&work);
    // rust: let write = |key: &str, carry: Value, harness: Option<Value>| {
    // rust: let dir = work.join("mods").join(key);
    // rust: std::fs::create_dir_all(dir.join("harness")).unwrap();
    // rust: std::fs::write(dir.join("carry-report.json"), carry.to_string()).unwrap();
    // rust: if let Some(h) = harness {
    // rust: std::fs::write(dir.join("harness/result.json"), h.to_string()).unwrap();
}
}
    // rust: let green = serde_json::json!({"checks": {"blocks": {"passed": 3, "failed": 0}}});
    // rust: write(
    // rust: "doors",
    // rust: serde_json::json!({"blocks": {"a": "minecraft:oak_door"}, "items": 0,
    // rust: "differences": {"a": ["class m.Door (behaviour beyond DoorBlock)"]}}),
    // rust: Some(green),
    // rust: );
    // rust: write(
    // rust: "paths",
    // rust: serde_json::json!({"blocks": {"a": "minecraft:stone"}, "items": 1,
    // rust: "blocks_unknown": {"b": "no vanilla Block"}}),
    // rust: Some(serde_json::json!({"checks": {"shapes": {"passed": 1, "failed": 2}}})),
    // rust: );
    // rust: let records = [
    // rust: record("doors", "content", "data", &[]),
    // rust: record("paths", "content", "data", &[]),
    // rust: record("lib", "library", "none", &[]),
    // rust: record("machine", "content", "machines", &["lib"]),
    // rust: record("addon", "integration", "logic", &["machine"]),
    // rust: record("mystery", "unknown", "none", &[]),
    // rust: ];
    // rust: let rows = build(&records, &work);
    // rust: let by: BTreeMap<&str, &Row> = rows.iter().map(|r| (r.key.as_str(), r)).collect();
    // rust: assert_eq!(by["doors"].status, Status::Ported);
    // rust: assert!(
    // rust: by["doors"].reason.contains("1 with code of their own"),
    // rust: "{}",
    // rust: by["doors"].reason
    // rust: );
    // rust: assert_eq!(by["paths"].status, Status::Partial);
    // rust: assert!(
    // rust: by["paths"].reason.contains("1 blocks left out"),
    // rust: "{}",
    // rust: by["paths"].reason
    // rust: );
    // rust: assert!(
    // rust: by["paths"].reason.contains("shapes 1/3"),
    // rust: "{}",
    // rust: by["paths"].reason
    // rust: );
    // rust: assert_eq!(by["lib"].status, Status::NotNeeded);
    // rust: assert_eq!(by["machine"].status, Status::NotYet);
    // rust: assert!(by["machine"].reason.contains("0.4"));
    // rust: assert!(by["addon"].reason.starts_with("after the mods it joins"));
    // rust: assert!(
    // rust: by["addon"].reason.ends_with("waits on machine"),
    // rust: "{}",
    // rust: by["addon"].reason
    // rust: );
    // rust: assert_eq!(by["mystery"].status, Status::NotYet);
    // rust: assert_eq!(
    // rust: counts(&rows),
    // rust: [
    // rust: ("ported", 1),
    // rust: ("partial", 1),
    // rust: ("not yet", 3),
    // rust: ("not needed", 1)
    // rust: ]
    // rust: );
    // rust: let md = markdown("test", &rows);
    // rust: assert!(
    // rust: md.contains("| **all** | **1** | **1** | **3** | **1** | **6** |"),
    // rust: "{md}"
    // rust: );
    // rust: std::fs::remove_dir_all(&work).unwrap();
}

pub fn carried_harness_needs_executed_checks() void {
}
    // rust: for harness in [
    // rust: serde_json::json!({"passed": false, "checks": {}}),
    // rust: serde_json::json!({"passed": true, "checks": {}}),
    // rust: serde_json::json!({"checks": {"blocks": {"passed": 0, "failed": 0}}}),
    // rust: serde_json::json!({}),
    // rust: ] {
    // rust: let row = carried_harness_row(Some(&harness.to_string()));
    // rust: assert_eq!(row.status, Status::Partial, "{harness}: {}", row.reason);
    // rust: assert!(row.reason.contains("no checks"), "{}", row.reason);
    // rust: assert!(!row.reason.contains("harness green"), "{}", row.reason);
}
}

pub fn carried_harness_rejects_failed_verdicts() void {
}
    // rust: for harness in [
    // rust: serde_json::json!({"passed": false,
    // rust: "checks": {"blocks": {"passed": 3, "failed": 0}}}),
    // rust: serde_json::json!({"passed": true,
    // rust: "checks": {"blocks": {"passed": 1, "failed": 2}}}),
    // rust: serde_json::json!({"checks": {"blocks": {"passed": 1, "failed": 2}}}),
    // rust: ] {
    // rust: let row = carried_harness_row(Some(&harness.to_string()));
    // rust: assert_eq!(row.status, Status::Partial, "{harness}: {}", row.reason);
    // rust: assert!(!row.reason.contains("harness green"), "{}", row.reason);
    // rust: if harness["passed"] == false {
    // rust: assert!(row.reason.contains("harness failed"), "{}", row.reason);
    // rust: } else {
    // rust: assert!(row.reason.contains("blocks 1/3"), "{}", row.reason);
}
}
}

pub fn carried_harness_keeps_current_and_legacy_successes() void {
}
    // rust: for harness in [
    // rust: serde_json::json!({"passed": true,
    // rust: "checks": {"blocks": {"passed": 3, "failed": 0}}}),
    // rust: serde_json::json!({"checks": {"blocks": {"passed": 3, "failed": 0}}}),
    // rust: ] {
    // rust: let row = carried_harness_row(Some(&harness.to_string()));
    // rust: assert_eq!(row.status, Status::Ported, "{harness}: {}", row.reason);
    // rust: assert!(row.reason.contains("harness green"), "{}", row.reason);
}
}

pub fn carried_harness_keeps_missing_or_unreadable_results_partial() void {
}
    // rust: for harness in [None, Some("not JSON")] {
    // rust: let row = carried_harness_row(harness);
    // rust: assert_eq!(row.status, Status::Partial, "{}", row.reason);
    // rust: assert!(row.reason.contains("harness not run"), "{}", row.reason);
}
}

pub fn carried_harness_row(harness: ?[]const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let nonce = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_nanos();
    // rust: let work = std::env::temp_dir().join(format!(
    // rust: "horizon-report-verdict-{}-{nonce}",
    // rust: std::process::id()
    // rust: ));
    // rust: std::fs::create_dir(&work).unwrap();
    // rust: let dir = work.join("mods/example");
    // rust: std::fs::create_dir_all(dir.join("harness")).unwrap();
    // rust: std::fs::write(
    // rust: dir.join("carry-report.json"),
    // rust: r#"{"blocks":{"example:block":"minecraft:stone"},"items":0}"#,
    // rust: )
    // rust: .unwrap();
    // rust: if let Some(harness) = harness {
    // rust: std::fs::write(dir.join("harness/result.json"), harness).unwrap();
}
    // rust: let row = build(&[record("example", "content", "data", &[])], &work)
    // rust: .pop()
    // rust: .unwrap();
    // rust: std::fs::remove_dir_all(work).unwrap();
    // rust: row
}

pub fn licence_families() void {
}
    // rust: assert_eq!(license_kind("MIT"), "permissive");
    // rust: assert_eq!(license_kind("CC0-1.0"), "permissive");
    // rust: assert_eq!(license_kind("LGPL-3.0-only"), "copyleft");
    // rust: assert_eq!(
    // rust: license_kind("GNU Lesser General Public License v3.0"),
    // rust: "copyleft"
    // rust: );
    // rust: assert_eq!(
    // rust: license_kind("LicenseRef-All-Rights-Reserved"),
    // rust: "all-rights-reserved"
    // rust: );
    // rust: assert_eq!(license_kind("CC-BY-NC-SA-4.0"), "restricted");
    // rust: assert_eq!(license_kind("LicenseRef-Stardust-Labs-License"), "custom");
    // rust: assert_eq!(
    // rust: license_kind("unknown (read mods.toml at import)"),
    // rust: "unknown"
    // rust: );
}
}
