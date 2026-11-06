//! Transpiled from Horizon Rust crate
package horizon_world_tags

import "core:fmt"
import "core:mem"
import "core:math"

// Version-pinned tag codecs, resource-stack merging and dependency resolution.
// use super::{DecodeError, Object, optional, required};
// use horizon_core::random::java_string_hash;
// use serde_json::value::RawValue;
// use std::collections::{BTreeMap, BTreeSet};

TagEntry :: struct {
    id: string,
    tag: bool,
    required: bool,
}
    // rust: impl TagEntry {
from_json :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let raw: Box<RawValue> = serde_json::from_str(json)?;
    // rust: let (name, mandatory) = if raw.get().starts_with('"') {
    // rust: (serde_json::from_str::<String>(raw.get())?, true)
    // rust: } else {
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: (
    // rust: serde_json::from_str(required(&object, "id")?.get())?,
    // rust: optional(&object, "required")
    // rust: .map(|v| serde_json::from_str(v.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(true),
    // rust: )
}
    // rust: let (tag, name) = name
    // rust: .strip_prefix('#')
    // rust: .map_or((false, name.as_str()), |s| (true, s));
    // rust: Ok(Self {
    // rust: id: identifier(name)?,
    // rust: tag,
    // rust: required: mandatory,
    // rust: })
}
display :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "{}{}{}",
    // rust: if self.tag { "#" } else { "" },
    // rust: self.id,
    // rust: if self.required { "" } else { "?" }
    // rust: )
}
}
TagFile :: struct {
    entries: [dynamic]TagEntry,
    replace: bool,
}
    // rust: impl TagFile {
from_json :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let values: Vec<Box<RawValue>> = serde_json::from_str(required(&object, "values")?.get())?;
    // rust: let entries = values
    // rust: .iter()
    // rust: .map(|v| TagEntry::from_json(v.get()))
    // rust: .collect::<Result<_, _>>()?;
    // rust: let replace = optional(&object, "replace")
    // rust: .map(|v| serde_json::from_str(v.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(false);
    // rust: Ok(Self { entries, replace })
}
}
// Identifier.CODEC permits the empty path as well as an omitted namespace.
    // rust: pub(crate) fn identifier(name: &str) -> Result<String, DecodeError> {
    // rust: let (namespace, path) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: let namespace = if namespace.is_empty() {
    // rust: "minecraft"
    // rust: } else {
    // rust: namespace
}
    // rust: let valid = |c: u8| c.is_ascii_lowercase() || c.is_ascii_digit() || b"_.-".contains(&c);
    // rust: if !namespace.bytes().all(valid) || !path.bytes().all(|c| valid(c) || c == b'/') {
    // rust: return Err(DecodeError::Registry(format!(
    // rust: "invalid tag identifier: {name}"
    // rust: )));
}
    // rust: Ok(format!("{namespace}:{path}"))
}
TagEntryWithSource :: struct {
    entry: TagEntry,
    source: string,
}
TagDefinitions :: struct {
    entries: BTreeMap<string,
    insertion_order: [dynamic]string,
}
BuiltTags :: struct {
    tags: BTreeMap<string,
    missing: BTreeMap<string,
}
TagBuildError :: enum {
    TooManyTags,
    DependencyDepth,
    HashTreeBucket,
}
    // rust: impl std::fmt::Display for TagBuildError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str(match self {
    // rust: Self::TooManyTags => "tag definitions exceed 8192 entries",
    // rust: Self::DependencyDepth => {
    // rust: "tag dependency depth exceeds 256 or cyclic reachability does not terminate"
}
    // rust: Self::HashTreeBucket => "tag identifiers require an unsupported Java hash tree bucket",
    // rust: })
}
}
    // rust: impl std::error::Error for TagBuildError {}
    // rust: impl TagDefinitions {
    // Apply resources in their pack priority order. A successfully decoded
    // replace file clears earlier entries; a rejected file changes nothing.
add :: proc(self: ^Self, name: string, source: string, file: TagFile) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let name = identifier(name)?;
    // rust: if !self.entries.contains_key(&name) {
    // rust: self.insertion_order.push(name.clone());
}
    // rust: let entries = self.entries.entry(name).or_default();
    // rust: if file.replace {
    // rust: entries.clear();
}
    // rust: entries.extend(file.entries.into_iter().map(|entry| TagEntryWithSource {
    // rust: entry,
    // rust: source: source.into(),
    // rust: }));
    // rust: Ok(())
}
    // A valid JSON resource with a codec error still creates an empty tag in
    // vanilla's resource loader; existing entries are retained on that error.
apply_json :: proc(self: ^Self, name: string, source: string, json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let _: Box<RawValue> = serde_json::from_str(json)?;
    // rust: let name = identifier(name)?;
    // rust: if !self.entries.contains_key(&name) {
    // rust: self.insertion_order.push(name.clone());
    // rust: self.entries.insert(name.clone(), Vec::new());
}
    // rust: self.add(&name, source, TagFile::from_json(json)?)
}
definitions :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.entries
}
    // Missing required references invalidate their own tags, not unrelated tags.
    // Element lookup receives the entry's required flag, as in vanilla.
    // rust: pub fn build<T: Clone + Ord>(
    // rust: &self,
    // rust: mut lookup: impl FnMut(&str, bool) -> Option<T>,
    // rust: ) -> Result<BuiltTags<T>, TagBuildError> {
    // rust: if self.entries.len() > 8192 {
    // rust: return Err(TagBuildError::TooManyTags);
}
        // DependencySorter owns a fresh default-sized HashMap. Required edges
        // are inserted for every tag before any optional edge is considered.
        // The resource loader creates keys with HashMap.computeIfAbsent,
        // which inserts at the head of a bucket. DependencySorter then copies
        // that map with put (tail insertion), retaining the reversed order of
        // colliding resource keys. Resizing preserves each split chain's order.
    // rust: let order = java_bucket_order(self.insertion_order.iter().rev().map(String::as_str), 16)?;
    // rust: let mut edges: BTreeMap<&str, Vec<&str>> = BTreeMap::new();
    // rust: for mandatory in [true, false] {
    // rust: for &name in &order {
    // rust: for entry in &self.entries[name] {
    // rust: let e = &entry.entry;
    // rust: if e.tag && e.required == mandatory && !reaches(&edges, &e.id, name, 0)? {
    // rust: let children = edges.entry(name).or_default();
    // rust: if !children.contains(&e.id.as_str()) {
    // rust: children.push(&e.id);
}
}
}
}
}
        // Guava HashMultimap value sets start with capacity four (two expected
        // values). Their native bucket order matters when cycles are pruned.
    // rust: let edges = edges
    // rust: .into_iter()
    // rust: .map(|(key, children)| Ok((key, java_bucket_order(children, 4)?)))
    // rust: .collect::<Result<BTreeMap<_, _>, TagBuildError>>()?;
    // rust: let mut visited = BTreeSet::new();
    // rust: let mut sorted = Vec::new();
    // rust: for name in order {
    // rust: visit(name, &edges, &mut visited, &mut sorted, 0)?;
}
    // rust: let mut result: BuiltTags<T> = BuiltTags {
    // rust: tags: BTreeMap::new(),
    // rust: missing: BTreeMap::new(),
}
    // rust: for name in sorted {
    // rust: let Some(entries) = self.entries.get(name) else {
    // rust: continue;
}
    // rust: let mut seen = BTreeSet::new();
    // rust: let mut values = Vec::new();
    // rust: let mut missing = Vec::new();
    // rust: for sourced in entries {
    // rust: let entry = &sourced.entry;
    // rust: if entry.tag {
    // rust: if let Some(children) = result.tags.get(&entry.id) {
    // rust: for value in children {
    // rust: if seen.insert(value.clone()) {
    // rust: values.push(value.clone());
}
}
    // rust: } else if entry.required {
    // rust: missing.push(sourced.clone());
}
    // rust: } else if let Some(value) = lookup(&entry.id, entry.required) {
    // rust: if seen.insert(value.clone()) {
    // rust: values.push(value);
}
    // rust: } else if entry.required {
    // rust: missing.push(sourced.clone());
}
}
    // rust: if missing.is_empty() {
    // rust: result.tags.insert(name.into(), values);
    // rust: } else {
    // rust: result.missing.insert(name.into(), missing);
}
}
    // rust: Ok(result)
}
}
    // rust: fn reaches(
    // rust: edges: &BTreeMap<&str, Vec<&str>>,
    // rust: from: &str,
    // rust: target: &str,
    // rust: depth: usize,
    // rust: ) -> Result<bool, TagBuildError> {
    // rust: if depth > 256 {
    // rust: return Err(TagBuildError::DependencyDepth);
}
    // rust: if let Some(children) = edges.get(from) {
    // rust: if children.contains(&target) {
    // rust: return Ok(true);
}
    // rust: for child in children {
    // rust: if reaches(edges, child, target, depth + 1)? {
    // rust: return Ok(true);
}
}
}
    // rust: Ok(false)
}
    // rust: fn visit<'a>(
    // rust: name: &'a str,
    // rust: edges: &BTreeMap<&'a str, Vec<&'a str>>,
    // rust: visited: &mut BTreeSet<&'a str>,
    // rust: sorted: &mut Vec<&'a str>,
    // rust: depth: usize,
    // rust: ) -> Result<(), TagBuildError> {
    // rust: if !visited.insert(name) {
    // rust: return Ok(());
}
    // rust: if depth > 256 {
    // rust: return Err(TagBuildError::DependencyDepth);
}
    // rust: if let Some(children) = edges.get(name) {
    // rust: for child in children {
    // rust: visit(child, edges, visited, sorted, depth + 1)?;
}
}
    // rust: sorted.push(name);
    // rust: Ok(())
}
hash :: proc(name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let (namespace, path) = name.split_once(':').expect("canonical tag identifier");
    // rust: let raw = java_string_hash(namespace.encode_utf16())
    // rust: .wrapping_mul(31)
    // rust: .wrapping_add(java_string_hash(path.encode_utf16())) as u32;
    // rust: raw ^ (raw >> 16)
}
    // rust: fn java_bucket_order<'a>(
    // rust: names: impl IntoIterator<Item = &'a str>,
    // rust: initial: usize,
    // rust: ) -> Result<Vec<&'a str>, TagBuildError> {
    // rust: let names: Vec<_> = names.into_iter().collect();
    // rust: let mut capacity = initial;
    // rust: for count in 1..=names.len() {
    // rust: let bucket = hash(names[count - 1]) as usize & (capacity - 1);
    // rust: let collisions = names[..count]
    // rust: .iter()
    // rust: .filter(|name| hash(name) as usize & (capacity - 1) == bucket)
    // rust: .count();
    // rust: if collisions >= 9 {
    // rust: if capacity < 64 {
    // rust: capacity *= 2;
    // rust: } else {
    // rust: return Err(TagBuildError::HashTreeBucket);
}
}
    // rust: if count > capacity * 3 / 4 {
    // rust: capacity *= 2;
}
}
    // rust: let mut ordered = names;
    // rust: ordered.sort_by_key(|name| hash(name) as usize & (capacity - 1));
    // rust: Ok(ordered)
}

    // rust: mod tests {
//     use super::*;
invalid_replacement_keeps_entries_and_codec_error_can_create_empty_tag :: proc() {
}
    // rust: let mut definitions = TagDefinitions::default();
    // rust: definitions
    // rust: .apply_json("a", "first", r##"{"values":["one","two","one"]}"##)
    // rust: .unwrap();
    // rust: assert!(
    // rust: definitions
    // rust: .apply_json("a", "bad", r##"{"replace":true,"values":[false]}"##)
    // rust: .is_err()
    // rust: );
    // rust: assert!(definitions.apply_json("empty", "bad", "{}").is_err());
    // rust: assert!(definitions.apply_json("syntax", "bad", "{").is_err());
    // rust: let built = definitions.build(|id, _| Some(id.to_owned())).unwrap();
    // rust: assert_eq!(
    // rust: built.tags["minecraft:a"],
    // rust: vec!["minecraft:one", "minecraft:two"]
    // rust: );
    // rust: assert_eq!(built.tags["minecraft:empty"], Vec::<String>::new());
    // rust: assert!(!built.tags.contains_key("minecraft:syntax"));
    // rust: definitions
    // rust: .apply_json(
    // rust: "a",
    // rust: "replacement",
    // rust: r##"{"replace":true,"values":["three"]}"##,
    // rust: )
    // rust: .unwrap();
    // rust: let built = definitions.build(|id, _| Some(id.to_owned())).unwrap();
    // rust: assert_eq!(built.tags["minecraft:a"], vec!["minecraft:three"]);
}
required_edges_precede_optional_edges_and_missing_tags_do_not_poison_siblings :: proc() {
}
    // rust: let mut definitions = TagDefinitions::default();
    // rust: for (name, json) in [
    // rust: ("a", r##"{"values":[{"id":"#b","required":false},"one"]}"##),
    // rust: ("b", r##"{"values":["#a","two"]}"##),
    // rust: ("bad", r##"{"values":["absent","also_absent"]}"##),
    // rust: (
    // rust: "c",
    // rust: r##"{"values":[{"id":"#bad","required":false},"two"]}"##,
    // rust: ),
    // rust: ] {
    // rust: definitions.apply_json(name, "fixture", json).unwrap();
}
    // rust: let built = definitions
    // rust: .build(|id, _| (!id.ends_with("absent")).then(|| id.to_owned()))
    // rust: .unwrap();
    // rust: assert_eq!(built.tags["minecraft:a"], vec!["minecraft:one"]);
    // rust: assert_eq!(
    // rust: built.tags["minecraft:b"],
    // rust: vec!["minecraft:one", "minecraft:two"]
    // rust: );
    // rust: assert_eq!(built.tags["minecraft:c"], vec!["minecraft:two"]);
    // rust: assert_eq!(
    // rust: built.missing["minecraft:bad"]
    // rust: .iter()
    // rust: .map(|e| e.entry.id.as_str())
    // rust: .collect::<Vec<_>>(),
    // rust: vec!["minecraft:absent", "minecraft:also_absent"]
    // rust: );
}
}
