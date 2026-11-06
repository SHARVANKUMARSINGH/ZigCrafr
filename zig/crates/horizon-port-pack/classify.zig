//! Transpiled from Horizon Rust crate
//! Module: horizon-port-pack_classify
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Step 2 and 3: classify each mod (class and API tier, `docs/modpacks.md`)
//! and order them by required dependencies.
// use std::collections::{BTreeMap, HashMap};

/// The reviewed table: ATM10's 495 rows (`docs/modpacks/atm10-mods.csv`).
/// It wins over the heuristics.
pub const KNOWN_CSV: []const u8 = include_str!("../../../docs/modpacks/atm10-mods.csv");

pub const Known = struct {
    by_key: HashMap<[]const u8,
};

/// Lowercase letters and digits only: `Get It Together, Drops!` ->
/// `getittogetherdrops`.
pub fn normalise(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.chars()
    // rust: .filter(char::is_ascii_alphanumeric)
    // rust: .map(|c| c.to_ascii_lowercase())
    // rust: .collect()
}

/// One CSV line, with `"quoted, fields"`.
pub fn csv_fields(line: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut out, mut field, mut quoted) = (Vec::new(), String::new(), false);
    // rust: let mut chars = line.chars().peekable();
    // rust: while let Some(c) = chars.next() {
    // rust: match c {
    // rust: '"' if quoted && chars.peek() == Some(&'"') => {
    // rust: field.push('"');
    // rust: chars.next();
}
    // rust: '"' => quoted = !quoted,
    // rust: ',' if !quoted => out.push(std::mem::take(&mut field)),
    // rust: c => field.push(c),
}
}
    // rust: out.push(field);
    // rust: out
}

    // rust: impl Known {
pub fn atm10() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut by_key = HashMap::new();
    // rust: for line in KNOWN_CSV.lines().skip(1) {
    // rust: let f = csv_fields(line);
    // rust: if f.len() < 6 || f[5] == "guess" {
    // rust: continue;
}
    // rust: let value = (f[3].clone(), f[4].clone());
    // rust: by_key.insert(normalise(&f[0]), value.clone());
    // rust: by_key.entry(normalise(&f[1])).or_insert(value);
}
    // rust: Known { by_key }
}

    /// By mod id, Modrinth slug or name, in that order.
pub fn get(self: *Self, keys: *[[]const u8]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: keys.iter()
    // rust: .filter(|k| !k.is_empty())
    // rust: .find_map(|k| self.by_key.get(&normalise(k)))
}
}

/// What the rules look at.
pub const Facts = struct {
    /// `mods`, `resourcepacks`, `shaderpacks`, `datapacks`.
    kind: *'a str,
    client: *'a str,
    server: *'a str,
    /// Modrinth categories.
    categories: *'a [[]const u8],
    /// From the jar: classes, and whether it has blocks, items or data.
    classes: ?usize,
    has_content: bool,
};

/// Class, tier and confidence (`known` is set by the caller).
pub fn rules(f: *Facts) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let has = |c: &str| f.categories.iter().any(|x| x == c);
    // rust: match f.kind {
    // rust: "resourcepacks" => return ("other", "data", "kind"),
    // rust: "shaderpacks" => return ("other", "none", "kind"),
    // rust: "datapacks" => return ("content", "data", "kind"),
    // rust: _ => {}
}
    // rust: if has("library") {
    // rust: return ("library", "none", "categories");
}
    // rust: if has("optimization") {
    // rust: return ("performance", "none", "categories");
}
    // rust: if f.client != "unsupported" && f.server == "unsupported" {
    // rust: return ("client-ui", "client", "sides");
}
    // rust: if f.client == "unsupported" && f.server != "unsupported" && !f.server.is_empty() {
    // rust: return ("server-only", "logic", "sides");
}
    // rust: if f.classes == Some(0) && f.has_content {
    // rust: return ("content", "data", "jar");
}
    // rust: let content = [
    // rust: "adventure",
    // rust: "decoration",
    // rust: "equipment",
    // rust: "food",
    // rust: "game-mechanics",
    // rust: "magic",
    // rust: "mobs",
    // rust: "storage",
    // rust: "technology",
    // rust: "transportation",
    // rust: "worldgen",
    // rust: ];
    // rust: if f.categories.iter().any(|c| content.contains(&c.as_str())) {
    // rust: let tier = if has("mobs") || has("magic") || has("adventure") {
    // rust: "deep"
    // rust: } else if has("technology") || has("storage") || has("transportation") {
    // rust: "machines"
    // rust: } else if f.categories.iter().all(|c| {
    // rust: ["worldgen", "decoration", "food"].contains(&c.as_str())
    // rust: || !content.contains(&c.as_str())
    // rust: }) {
    // rust: "data"
    // rust: } else {
    // rust: "logic"
}
    // rust: return ("content", tier, "categories");
}
    // rust: if has("utility") || has("management") || has("social") {
    // rust: return ("other", "logic", "guess");
}
    // rust: ("unknown", "none", "unknown")
}

/// Layer of each mod: 0 needs nothing in the pack, n needs layer n-1.
/// Mods in a cycle get one layer past the rest; dependencies outside the
/// pack are left out (the caller lists them).
pub fn layers(depends: *BTreeMap<[]const u8) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: BTreeMap<String, usize> = BTreeMap::new();
    // rust: loop {
    // rust: let mut progressed = false;
    // rust: for (id, deps) in depends {
    // rust: if out.contains_key(id) {
    // rust: continue;
}
    // rust: let inside = deps.iter().filter(|d| depends.contains_key(*d) && *d != id);
    // rust: let mut layer = 0;
    // rust: let mut ready = true;
    // rust: for d in inside {
    // rust: match out.get(d) {
    // rust: Some(l) => layer = layer.max(l + 1),
    // rust: None => ready = false,
}
}
    // rust: if ready {
    // rust: out.insert(id.clone(), layer);
    // rust: progressed = true;
}
}
    // rust: if !progressed {
    // rust: break;
}
}
    // rust: let past = out.values().max().map_or(0, |m| m + 1);
    // rust: for id in depends.keys() {
    // rust: out.entry(id.clone()).or_insert(past);
}
    // rust: out
}

    // rust: mod tests {
//     use super::*;

pub fn known_table_matches_ids_and_names() void {
}
    // rust: let k = Known::atm10();
    // rust: assert_eq!(k.get(&["create"]).map(|v| v.0.as_str()), Some("content"));
    // rust: assert_eq!(
    // rust: k.get(&["", "Get It Together, Drops!"])
    // rust: .map(|v| v.0.as_str()),
    // rust: Some("performance")
    // rust: );
    // rust: assert_eq!(k.get(&["sodium"]).map(|v| v.1.as_str()), Some("none"));
    // rust: assert!(k.get(&["not-a-mod"]).is_none());
}

pub fn rules_follow_sides_then_categories() void {
}
    // rust: let cats = |c: &[&str]| c.iter().map(|s| s.to_string()).collect::<Vec<_>>();
    // rust: let f = |client, server, c: &[String]| {
    // rust: rules(&Facts {
    // rust: kind: "mods",
    // rust: client,
    // rust: server,
    // rust: categories: c,
    // rust: ..Facts::default()
    // rust: })
}
    // rust: assert_eq!(f("required", "unsupported", &[]).0, "client-ui");
    // rust: assert_eq!(f("unsupported", "required", &[]).0, "server-only");
    // rust: assert_eq!(f("required", "required", &cats(&["library"])).0, "library");
    // rust: assert_eq!(
    // rust: f("required", "unsupported", &cats(&["optimization"])).0,
    // rust: "performance"
    // rust: );
    // rust: assert_eq!(
    // rust: f("required", "required", &cats(&["technology", "utility"])),
    // rust: ("content", "machines", "categories")
    // rust: );
    // rust: assert_eq!(
    // rust: f("required", "required", &cats(&["worldgen", "neoforge"])),
    // rust: ("content", "data", "categories")
    // rust: );
    // rust: assert_eq!(f("", "", &[]).0, "unknown");
}

pub fn layers_put_dependencies_first() void {
}
    // rust: let d = |v: &[&str]| v.iter().map(|s| s.to_string()).collect::<Vec<_>>();
    // rust: let deps = BTreeMap::from([
    // rust: ("lib".to_string(), d(&[])),
    // rust: ("create".to_string(), d(&["lib", "outside"])),
    // rust: ("addon".to_string(), d(&["create", "lib"])),
    // rust: ("a".to_string(), d(&["b"])),
    // rust: ("b".to_string(), d(&["a"])),
    // rust: ]);
    // rust: let l = layers(&deps);
    // rust: assert_eq!((l["lib"], l["create"], l["addon"]), (0, 1, 2));
    // rust: assert_eq!((l["a"], l["b"]), (3, 3));
}
}
