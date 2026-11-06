//! Transpiled from Horizon Rust crate
//! Module: horizon-items_recipe_filters
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Recipe filters: data files that remove recipes, or swap one of their
//! inputs or outputs, by what the recipes are rather than by id.
//!
//! A file `data/<ns>/recipe_filter/<path>.json` holds `{"filters": [...]}`.
//! Each filter has match keys, all of which must hold (none matches every
//! recipe), and exactly one action:
//! - `id`: the recipe id, `*` matching any run of characters
//!   (`minecraft:*_planks`);
//! - `type`: the recipe's `type`, with the same `*`;
//! - `input`: an item id or `#tag` among the recipe's inputs;
//! - `output`: an item id among its outputs (under `result`, `results`,
//!   `output` or `outputs`);
//! - `remove: true`, or `replace_input` / `replace_output`
//!   `{"from": ..., "to": ...}`, which swaps every input (or output) that is
//!   `from` for `to`.
//!
//! Filters run on each recipe after the data packs are merged and its load
//! conditions held, so they see the final set and reach every recipe type,
//! mods' own included: they work on the recipe's JSON. Files apply in id
//! order, each file's filters in order. A pack's file replaces a file of the
//! same id, as any data file does. A filter with an unknown key or no action
//! is skipped with a warning, so a typo never matches every recipe.
// use horizon_world::loot::PackOverlay;
// use serde_json::Value;
// use std::path::Path;

/// The keys under which a recipe lists what it makes.
pub const OUTPUT_KEYS: [[]const u8; 4] = ["result", "results", "output", "outputs"];
/// Keys whose strings are never items: a type, a group, a category, the load
/// conditions.
pub const NOT_ITEMS: [[]const u8; 4] = ["type", "group", "category", "neoforge:conditions"];

pub const Action = enum {
    Remove,
    ReplaceInput(String, String),
    ReplaceOutput(String, String),
};

pub const Filter = struct {
    id: ?[]const u8,
    kind: ?[]const u8,
    input: ?[]const u8,
    output: ?[]const u8,
    action: Action,
};

/// Every recipe filter of a load, in the order they apply.
pub const RecipeFilters = struct {
    filters: std.ArrayList(Filter),
};

    // rust: impl RecipeFilters {
    /// The filters of the content root's mods (`data/<ns>/recipe_filter/`)
    /// with the world's packs' files over them.
pub fn load(root: *Path, overlay: *PackOverlay) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut files: std::collections::BTreeMap<String, Vec<u8>> = Default::default();
    // rust: for ns in crate::content_namespaces::namespaces(root) {
    // rust: let dir = root.join("data").join(&ns).join("recipe_filter");
    // rust: read_dir(&dir, &format!("{ns}:"), &mut files);
}
    // rust: for (id, versions) in overlay.kind("recipe_filter") {
    // rust: files.insert(id.to_owned(), PackOverlay::top(versions).to_vec());
}
    // rust: Self::parse(files)
}

pub fn parse(files: std::collections::BTreeMap<[]const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut filters = Vec::new();
    // rust: for (file, bytes) in files {
    // rust: let v: Value = match serde_json::from_slice(&bytes) {
    // rust: Ok(v) => v,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: recipe filter {file} not loaded: {e}");
    // rust: continue;
}
}
    // rust: for (i, f) in v["filters"].as_array().into_iter().flatten().enumerate() {
    // rust: match Filter::parse(f) {
    // rust: Ok(f) => filters.push(f),
    // rust: Err(e) => log::warn!("Horizon: recipe filter {file} #{i} skipped: {e}"),
}
}
}
    // rust: Self { filters }
}

pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.filters.is_empty()
}

    /// Runs the filters over recipe `id` (`ns:path`): false when one removes
    /// it, else `recipe` with every swap applied.
pub fn apply(self: *Self, id: []const u8, recipe: *mut Value) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for f in &self.filters {
    // rust: if !f.matches(id, recipe) {
    // rust: continue;
}
    // rust: match &f.action {
    // rust: Action::Remove => return false,
    // rust: Action::ReplaceInput(from, to) => replace(recipe, from, to, false, false),
    // rust: Action::ReplaceOutput(from, to) => replace(recipe, from, to, false, true),
}
}
    // rust: true
}
}

pub fn read_dir(dir: *Path, prefix: []const u8, out: *mut std::collections::BTreeMap<[]const u8) void {
}
    // rust: for entry in std::fs::read_dir(dir).into_iter().flatten().flatten() {
    // rust: let path = entry.path();
    // rust: let name = entry.file_name().to_string_lossy().into_owned();
    // rust: if path.is_dir() {
    // rust: read_dir(&path, &format!("{prefix}{name}/"), out);
    // rust: } else if let Some(stem) = name.strip_suffix(".json")
    // rust: && let Ok(bytes) = std::fs::read(&path)
    // rust: {
    // rust: out.insert(format!("{prefix}{stem}"), bytes);
}
}
}

    // rust: impl Filter {
pub fn parse(v: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let obj = v.as_object().ok_or("not an object")?;
    // rust: let text = |k: &str| -> Result<Option<String>, String> {
    // rust: match obj.get(k) {
    // rust: None => Ok(None),
    // rust: Some(Value::String(s)) => Ok(Some(s.clone())),
    // rust: Some(_) => Err(format!("`{k}` is not a string")),
}
}
    // rust: let swap = |k: &str| -> Result<Option<(String, String)>, String> {
    // rust: let Some(s) = obj.get(k) else {
    // rust: return Ok(None);
}
    // rust: match (s["from"].as_str(), s["to"].as_str()) {
    // rust: (Some(from), Some(to)) => Ok(Some((from.to_owned(), to.to_owned()))),
    // rust: _ => Err(format!("`{k}` needs `from` and `to` strings")),
}
}
    // rust: for k in obj.keys() {
    // rust: if !matches!(
    // rust: k.as_str(),
    // rust: "id" | "type" | "input" | "output" | "remove" | "replace_input" | "replace_output"
    // rust: ) {
    // rust: return Err(format!("unknown key `{k}`"));
}
}
    // rust: let mut actions = Vec::new();
    // rust: match obj.get("remove") {
    // rust: None | Some(Value::Bool(false)) => {}
    // rust: Some(Value::Bool(true)) => actions.push(Action::Remove),
    // rust: Some(_) => return Err("`remove` is not a boolean".into()),
}
    // rust: if let Some((from, to)) = swap("replace_input")? {
    // rust: actions.push(Action::ReplaceInput(from, to));
}
    // rust: if let Some((from, to)) = swap("replace_output")? {
    // rust: actions.push(Action::ReplaceOutput(from, to));
}
    // rust: let [action] = <[Action; 1]>::try_from(actions)
    // rust: .map_err(|_| "needs exactly one of `remove`, `replace_input`, `replace_output`")?;
    // rust: Ok(Self {
    // rust: id: text("id")?,
    // rust: kind: text("type")?,
    // rust: input: text("input")?,
    // rust: output: text("output")?,
    // rust: action,
    // rust: })
}

pub fn matches(self: *Self, id: []const u8, recipe: *Value) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.id.as_deref().is_none_or(|p| glob(p, id))
    // rust: && self
    // rust: .kind
    // rust: .as_deref()
    // rust: .is_none_or(|p| glob(p, recipe["type"].as_str().unwrap_or("")))
    // rust: && self
    // rust: .input
    // rust: .as_deref()
    // rust: .is_none_or(|i| contains(recipe, i, false, false))
    // rust: && self
    // rust: .output
    // rust: .as_deref()
    // rust: .is_none_or(|o| contains(recipe, o, false, true))
}
}

/// `pattern` with `*` as any run of characters, against `s`.
pub fn glob(pattern: []const u8, s: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut parts = pattern.split('*');
    // rust: let first = parts.next().unwrap_or("");
    // rust: let Some(mut rest) = s.strip_prefix(first) else {
    // rust: return false;
}
    // rust: let parts: Vec<&str> = parts.collect();
    // rust: let Some((last, middle)) = parts.split_last() else {
    // rust: return rest.is_empty();
}
    // rust: for part in middle {
    // rust: match rest.find(part) {
    // rust: Some(at) => rest = &rest[at + part.len()..],
    // rust: None => return false,
}
}
    // rust: rest.len() >= last.len() && rest.ends_with(last)
}

/// The item a string at `key` names: a `tag` key's value is a tag without
/// its `#` (`{"tag": "c:ingots"}`).
pub fn named(key: ?[]const u8, s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if key == Some("tag") {
    // rust: format!("#{s}")
    // rust: } else {
    // rust: s.to_owned()
}
}

/// Whether `item` is among `v`'s inputs (`outputs` false) or outputs
/// (`outputs` true). `inside` says the walk is already under an output key.
pub fn contains(v: *Value, item: []const u8, inside: bool, outputs: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
pub fn walk(v: *Value, key: ?[]const u8, item: []const u8, inside: bool, outputs: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::String(s) => inside == outputs && named(key, s) == item,
    // rust: Value::Array(a) => a.iter().any(|v| walk(v, key, item, inside, outputs)),
    // rust: Value::Object(o) => o.iter().any(|(k, v)| {
    // rust: !NOT_ITEMS.contains(&k.as_str())
    // rust: && walk(
    // rust: v,
    // rust: Some(k),
    // rust: item,
    // rust: inside || OUTPUT_KEYS.contains(&k.as_str()),
    // rust: outputs,
    // rust: )
    // rust: }),
    // rust: _ => false,
}
}
    // rust: walk(v, None, item, inside, outputs)
}

/// Swaps every input (`outputs` false) or output that is `from` for `to`.
pub fn replace(v: *mut Value, from: []const u8, to: []const u8, inside: bool, outputs: bool) void {
}
pub fn walk(v: *mut Value, key: ?[]const u8, from: []const u8, to: []const u8, inside: bool, outputs: bool) void {
}
    // rust: match v {
    // rust: Value::String(s) => {
    // rust: if inside == outputs && named(key, s) == from {
                    // A `tag` key holds the tag without its `#`.
    // rust: *s = match key {
    // rust: Some("tag") => to.trim_start_matches('#').to_owned(),
    // rust: _ => to.to_owned(),
}
}
}
    // rust: Value::Array(a) => a
    // rust: .iter_mut()
    // rust: .for_each(|v| walk(v, key, from, to, inside, outputs)),
    // rust: Value::Object(o) => {
    // rust: for (k, v) in o.iter_mut() {
    // rust: if !NOT_ITEMS.contains(&k.as_str()) {
    // rust: let inside = inside || OUTPUT_KEYS.contains(&k.as_str());
    // rust: walk(v, Some(k), from, to, inside, outputs);
}
}
}
    // rust: _ => {}
}
}
    // rust: walk(v, None, from, to, inside, outputs)
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

pub fn filters(v: Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: RecipeFilters::parse([("test:f".to_owned(), v.to_string().into_bytes())].into())
}

pub fn globs_match_runs() void {
}
    // rust: assert!(glob("minecraft:*_planks", "minecraft:oak_planks"));
    // rust: assert!(glob("*", "anything"));
    // rust: assert!(glob("a*b*c", "a-x-b-y-c"));
    // rust: assert!(!glob("a*b*c", "a-x-c"));
    // rust: assert!(!glob("minecraft:oak", "minecraft:oak_planks"));
    // rust: assert!(glob("*:oak_*", "mod:oak_log"));
    // rust: assert!(!glob("ab*ba", "aba"));
}

pub fn remove_by_id_type_and_items() void {
}
    // rust: let planks = json!({"type": "minecraft:crafting_shapeless",
    // rust: "ingredients": ["#minecraft:oak_logs"], "result": {"id": "minecraft:oak_planks", "count": 4}});
    // rust: let f = filters(json!({"filters": [{"id": "minecraft:*_planks", "remove": true}]}));
    // rust: assert!(!f.apply("minecraft:oak_planks", &mut planks.clone()));
    // rust: assert!(f.apply("minecraft:stick", &mut planks.clone()));
        // The input and output keys look on their own side only.
    // rust: let f = filters(json!({"filters": [{"output": "#minecraft:oak_logs", "remove": true}]}));
    // rust: assert!(f.apply("x:y", &mut planks.clone()));
    // rust: let f = filters(json!({"filters": [{"input": "#minecraft:oak_logs",
    // rust: "type": "minecraft:crafting_*", "remove": true}]}));
    // rust: assert!(!f.apply("x:y", &mut planks.clone()));
    // rust: let f = filters(
    // rust: json!({"filters": [{"output": "minecraft:oak_planks", "type": "minecraft:smelting", "remove": true}]}),
    // rust: );
    // rust: assert!(f.apply("x:y", &mut planks.clone()));
}

pub fn swaps_reach_mod_types_and_tag_objects() void {
}
    // rust: let mut machine = json!({"type": "gtceu:macerator",
    // rust: "inputs": {"item": [{"tag": "c:ingots/iron"}, "minecraft:iron_ingot"]},
    // rust: "outputs": {"item": ["minecraft:iron_ingot"]}});
    // rust: let f = filters(json!({"filters": [
    // rust: {"replace_input": {"from": "#c:ingots/iron", "to": "#c:ingots/gold"}},
    // rust: {"type": "gtceu:*", "replace_output": {"from": "minecraft:iron_ingot", "to": "gtceu:iron_dust"}}
    // rust: ]}));
    // rust: assert!(f.apply("gtceu:macerator/iron", &mut machine));
    // rust: assert_eq!(machine["inputs"]["item"][0]["tag"], "c:ingots/gold");
        // Only outputs were swapped for the item: the input stays.
    // rust: assert_eq!(machine["inputs"]["item"][1], "minecraft:iron_ingot");
    // rust: assert_eq!(machine["outputs"]["item"][0], "gtceu:iron_dust");
        // `type` is never an item.
    // rust: assert_eq!(machine["type"], "gtceu:macerator");
}

pub fn bad_filters_are_skipped_not_widened() void {
}
    // rust: let f = filters(json!({"filters": [
    // rust: {"Id": "minecraft:stick", "remove": true},
    // rust: {"id": "minecraft:stick"},
    // rust: {"remove": true, "replace_input": {"from": "a:b", "to": "c:d"}},
    // rust: {"replace_input": {"from": "a:b"}}
    // rust: ]}));
    // rust: assert!(f.is_empty());
    // rust: assert!(RecipeFilters::parse([("t:f".to_owned(), b"{nope".to_vec())].into()).is_empty());
}

pub fn packs_replace_a_mods_file_and_files_apply_in_id_order() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-recipe-filters-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let dir = root.join("data/mymod/recipe_filter");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(
    // rust: root.join(crate::content_namespaces::MARKER),
    // rust: json!(["mymod"]).to_string(),
    // rust: )
    // rust: .unwrap();
    // rust: let remove_sticks = json!({"filters": [{"id": "minecraft:stick", "remove": true}]});
    // rust: std::fs::write(dir.join("a.json"), remove_sticks.to_string()).unwrap();
    // rust: let swap = json!({"filters": [{"replace_output": {"from": "minecraft:stone", "to": "minecraft:dirt"}}]});
    // rust: std::fs::write(dir.join("b.json"), swap.to_string()).unwrap();
    // rust: let mut stone = json!({"type": "minecraft:smelting", "ingredient": "minecraft:cobblestone", "result": {"id": "minecraft:stone"}});
    // rust: let f = RecipeFilters::load(&root, &PackOverlay::NONE);
    // rust: assert!(!f.apply("minecraft:stick", &mut json!({})));
    // rust: assert!(f.apply("minecraft:stone", &mut stone));
    // rust: assert_eq!(stone["result"]["id"], "minecraft:dirt");
        // A pack's file of the same id replaces the mod's: sticks stay.
    // rust: let files = vec![(
    // rust: "recipe_filter/mymod:a".to_owned(),
    // rust: vec![json!({"filters": []}).to_string().into_bytes()],
    // rust: )];
    // rust: let f = RecipeFilters::load(&root, &PackOverlay { files: &files });
    // rust: assert!(f.apply("minecraft:stick", &mut json!({})));
    // rust: let _ = std::fs::remove_dir_all(&root);
}
}
