//! Transpiled from Horizon Rust crate
package horizon_client_native_data_maps

import "core:fmt"
import "core:mem"
import "core:math"

// Data maps for native server mods (docs/native-mods.md): values a data pack
// attaches to the entries of a registry, under the types a mod registered
// (`native_data_map_types`). Vanilla has no data maps; the contract is
// NeoForge's `DataMapType`: files at
// `data/<map namespace>/data_maps/<registry path>/<map path>.json` hold
// `replace`, `values` (entry ids and `#tags` to values) and `remove`, and a
// newer value overrides an older one for the same entry. The files are the
// world's data packs' and what mods contribute through
// `native_data_pack_files` (key `data_maps/<ns>:<registry path>/<map path>`),
// merged each time the server's tables are built: a world's first open and
// every `/reload`.
// use super::Game;
// use serde_json::Value;
// use std::collections::{BTreeMap, HashMap, HashSet};

// A data map type a mod registers (`RegisterDataMapTypesEvent`).
NativeDataMapType :: struct {
    // `mod_id:name`: not in the `minecraft` namespace. Its files are
    // `data/<mod_id>/data_maps/<registry path>/<name>.json`.
    id: string,
    // The registry it is for: `minecraft:item` or `minecraft:block`.
    registry: string,
}

// The registries data maps can be attached to so far, with their folder
// (the registry's path: `minecraft` registries have no namespace folder).
REGISTRIES :: [("minecraft:item", "item"), ("minecraft:block", "block")]

// The merged values of every registered type: `(registry, type id)` to the
// value of each entry that has one.
    // rust: pub(crate) struct DataMaps {
    // rust: maps: HashMap<(String, String), BTreeMap<String, Value>>,
}

// `minecraft:` for an id written without a namespace.
full_id :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}

// A file's value for an entry: the data itself, or the wrapper
// `{"value": ..., "replace": false}` (`DataMapEntry`'s codec). `replace` only
// matters to mergers, which types don't have yet: a newer value overrides.
entry_value :: proc(raw: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Value::Object(map) = raw
    // rust: && let Some(value) = map.get("value")
    // rust: && map
    // rust: .iter()
    // rust: .all(|(k, v)| k == "value" || (k == "replace" && v.is_boolean()))
    // rust: {
    // rust: return Some(value.clone());
}
    // rust: (!raw.is_null()).then(|| raw.clone())
}

// One file over what earlier files made of the type: `replace` clears it,
// `values` attach (a tag to every entry in it), then `remove` takes entries
// away, as `DataMapFile` is applied. False when the file isn't a data map.
    // rust: fn apply_file(
    // rust: map: &mut BTreeMap<String, Value>,
    // rust: file: &Value,
    // rust: tags: &HashMap<String, HashSet<String>>,
    // rust: ) -> bool {
    // rust: let (Some(root), Some(values)) = (file.as_object(), file.get("values")) else {
    // rust: return false;
}
    // rust: let Some(values) = values.as_object() else {
    // rust: return false;
}
    // rust: if root.get("replace").and_then(Value::as_bool) == Some(true) {
    // rust: map.clear();
}
    // The members of a tag or the entry itself.
    // rust: let members = |key: &str| -> Vec<String> {
    // rust: match key.strip_prefix('#') {
    // rust: Some(tag) => tags
    // rust: .get(&full_id(tag))
    // rust: .map(|set| set.iter().cloned().collect())
    // rust: .unwrap_or_default(),
    // rust: None => vec![full_id(key)],
}
}
    // rust: for (key, raw) in values {
    // rust: let Some(value) = entry_value(raw) else {
    // rust: continue;
}
    // rust: for entry in members(key) {
    // rust: map.insert(entry, value.clone());
}
}
    // rust: for removal in root
    // rust: .get("remove")
    // rust: .and_then(Value::as_array)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
        // An entry or `{"key": entry}`, as `DataMapEntry.Removal` reads it.
    // rust: let key = removal.as_str().or_else(|| removal["key"].as_str());
    // rust: for entry in key.map(members).unwrap_or_default() {
    // rust: map.remove(&entry);
}
}
    // rust: true
}

    // rust: impl DataMaps {
    // The types' values from `files` (the server's tables' pack files, in
    // pack order, mods' below the packs'), tags resolved against the
    // loaded `item_tags` and `block_tags`. A type with an unsupported
    // registry or a bad id is left out with a warning; a file that isn't a
    // data map is skipped alone.
    // rust: pub(crate) fn load(
    // rust: types: &[NativeDataMapType],
    // rust: files: &[(String, Vec<Vec<u8>>)],
    // rust: item_tags: &HashMap<String, HashSet<String>>,
    // rust: block_tags: &HashMap<String, HashSet<String>>,
    // rust: ) -> Self {
    // rust: let mut maps: HashMap<(String, String), BTreeMap<String, Value>> = HashMap::new();
    // rust: for ty in types {
    // rust: let Some((_, dir)) = REGISTRIES.iter().find(|(r, _)| *r == ty.registry) else {
    // rust: log::warn!(
    // rust: "Horizon: data map {} is for {}, which has no data maps yet: left out",
    // rust: ty.id,
    // rust: ty.registry
    // rust: );
    // rust: continue;
}
    // rust: let valid = |s: &str| {
    // rust: !s.is_empty()
    // rust: && s.chars()
    // rust: .all(|c| c.is_ascii_lowercase() || c.is_ascii_digit() || "_-./".contains(c))
}
    // rust: let ok = ty
    // rust: .id
    // rust: .split_once(':')
    // rust: .is_some_and(|(ns, path)| ns != "minecraft" && valid(ns) && valid(path));
    // rust: if !ok {
    // rust: log::warn!(
    // rust: "Horizon: data map type {} is not a mod's id: left out",
    // rust: ty.id
    // rust: );
    // rust: continue;
}
    // rust: let key = (ty.registry.clone(), ty.id.clone());
    // rust: if maps.contains_key(&key) {
    // rust: log::warn!(
    // rust: "Horizon: data map {} registered twice: the first is kept",
    // rust: ty.id
    // rust: );
    // rust: continue;
}
    // rust: let tags = if *dir == "item" {
    // rust: item_tags
    // rust: } else {
    // rust: block_tags
}
    // rust: let (ns, path) = ty.id.split_once(':').unwrap_or_default();
    // rust: let wanted = format!("data_maps/{ns}:{dir}/{path}");
    // rust: let mut map = BTreeMap::new();
    // rust: if let Some((_, versions)) = files.iter().find(|(k, _)| *k == wanted) {
    // rust: for bytes in versions {
    // rust: let applied = serde_json::from_slice::<Value>(bytes)
    // rust: .ok()
    // rust: .is_some_and(|file| apply_file(&mut map, &file, tags));
    // rust: if !applied {
    // rust: log::warn!(
    // rust: "Horizon: a data map file of {} is not a data map, skipped",
    // rust: ty.id
    // rust: );
}
}
}
    // rust: maps.insert(key, map);
}
    // rust: Self { maps }
}
}

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    // The merged data map of `type_id` for `registry`, none unless this is a
    // server whose tables were built from packs or mods' files.
    // rust: fn native_data_map_of(
    // rust: &self,
    // rust: registry: &str,
    // rust: type_id: &str,
    // rust: ) -> Option<&BTreeMap<String, Value>> {
    // rust: if self.serving.is_none() && self.options.dedicated.is_none() {
    // rust: return None;
}
    // rust: let key = (registry.to_owned(), type_id.to_owned());
    // rust: self.world_tables.as_ref()?.data_maps.maps.get(&key)
}
    // `Holder.getData(type)`: the value the data pack and mod files gave
    // `entry` (`minecraft:coal`) in data map `type_id` for `registry`
    // (`minecraft:item`, `minecraft:block`), as the JSON the file held. None
    // when the entry has none, the type isn't registered for that registry
    // (`native_data_map_types`), or this isn't a server whose tables hold
    // files.
    // rust: pub(in crate::game) fn native_data_map(
    // rust: &self,
    // rust: registry: &str,
    // rust: type_id: &str,
    // rust: entry: &str,
    // rust: ) -> Option<&Value> {
    // rust: self.native_data_map_of(registry, type_id)?
    // rust: .get(&full_id(entry))
}
    // Every entry that has a value in data map `type_id` for `registry`, in
    // id order. Empty where `native_data_map` is none for all.
    // rust: pub(in crate::game) fn native_data_map_entries(
    // rust: &self,
    // rust: registry: &str,
    // rust: type_id: &str,
    // rust: ) -> Vec<(&str, &Value)> {
    // rust: self.native_data_map_of(registry, type_id)
    // rust: .map(|map| map.iter().map(|(k, v)| (k.as_str(), v)).collect())
    // rust: .unwrap_or_default()
}
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

tags :: proc(list: ^[(string) {
}
    // rust: list.iter()
    // rust: .map(|(tag, members)| {
    // rust: (
    // rust: (*tag).to_owned(),
    // rust: members.iter().map(|m| (*m).to_owned()).collect(),
    // rust: )
    // rust: })
    // rust: .collect()
}

ty :: proc(id: string, registry: string) -> N {
    // Ported from Horizon
    return {}
}
    // rust: NativeDataMapType {
    // rust: id: id.to_owned(),
    // rust: registry: registry.to_owned(),
}
}

files :: proc(list: ^[(string) {
}
    // rust: list.iter()
    // rust: .map(|(key, versions)| {
    // rust: (
    // rust: (*key).to_owned(),
    // rust: versions
    // rust: .iter()
    // rust: .map(|v| v.to_string().into_bytes())
    // rust: .collect(),
    // rust: )
    // rust: })
    // rust: .collect()
}

load :: proc(files: ^[(string) {
}
    // rust: let items = tags(&[(
    // rust: "minecraft:logs",
    // rust: &["minecraft:oak_log", "minecraft:birch_log"],
    // rust: )]);
    // rust: DataMaps::load(
    // rust: &[ty("mymod:fuel", "minecraft:item")],
    // rust: files,
    // rust: &items,
    // rust: &HashMap::new(),
    // rust: )
}

    // rust: fn get<'a>(maps: &'a DataMaps, entry: &str) -> Option<&'a Value> {
    // rust: maps.maps[&("minecraft:item".to_owned(), "mymod:fuel".to_owned())].get(entry)
}

values_attach_to_entries_and_to_every_member_of_a_tag :: proc() {
}
    // rust: let f = files(&[(
    // rust: "data_maps/mymod:item/fuel",
    // rust: &[json!({"values": {
    // rust: "minecraft:coal": {"burn": 1600},
    // rust: "stick": 100,
    // rust: "#minecraft:logs": {"burn": 300}
    // rust: }})],
    // rust: )]);
    // rust: let maps = load(&f);
    // rust: assert_eq!(get(&maps, "minecraft:coal"), Some(&json!({"burn": 1600})));
        // An id without a namespace is a `minecraft` one.
    // rust: assert_eq!(get(&maps, "minecraft:stick"), Some(&json!(100)));
    // rust: assert_eq!(get(&maps, "minecraft:oak_log"), Some(&json!({"burn": 300})));
    // rust: assert_eq!(
    // rust: get(&maps, "minecraft:birch_log"),
    // rust: Some(&json!({"burn": 300}))
    // rust: );
    // rust: assert_eq!(get(&maps, "minecraft:stone"), None);
}

a_newer_file_overrides_and_replace_clears_what_came_before :: proc() {
}
    // rust: let f = files(&[(
    // rust: "data_maps/mymod:item/fuel",
    // rust: &[
    // rust: json!({"values": {"minecraft:coal": 1, "minecraft:stick": 2}}),
    // rust: json!({"values": {"minecraft:coal": 10}}),
    // rust: ],
    // rust: )]);
    // rust: let maps = load(&f);
    // rust: assert_eq!(get(&maps, "minecraft:coal"), Some(&json!(10)));
    // rust: assert_eq!(get(&maps, "minecraft:stick"), Some(&json!(2)));
    // rust: let f = files(&[(
    // rust: "data_maps/mymod:item/fuel",
    // rust: &[
    // rust: json!({"values": {"minecraft:coal": 1, "minecraft:stick": 2}}),
    // rust: json!({"replace": true, "values": {"minecraft:coal": 10}}),
    // rust: ],
    // rust: )]);
    // rust: let maps = load(&f);
    // rust: assert_eq!(get(&maps, "minecraft:coal"), Some(&json!(10)));
    // rust: assert_eq!(get(&maps, "minecraft:stick"), None);
}

remove_takes_entries_and_tags_away_after_the_files_own_values :: proc() {
}
    // rust: let f = files(&[(
    // rust: "data_maps/mymod:item/fuel",
    // rust: &[
    // rust: json!({"values": {"#minecraft:logs": 5, "minecraft:coal": 1}}),
                // The file's own value for coal is attached, then removed.
    // rust: json!({"values": {"minecraft:coal": 9}, "remove": ["minecraft:coal", "#minecraft:logs"]}),
    // rust: ],
    // rust: )]);
    // rust: let maps = load(&f);
    // rust: assert_eq!(get(&maps, "minecraft:coal"), None);
    // rust: assert_eq!(get(&maps, "minecraft:oak_log"), None);
}

the_wrapper_form_gives_its_value_and_a_plain_object_is_a_value :: proc() {
}
    // rust: let f = files(&[(
    // rust: "data_maps/mymod:item/fuel",
    // rust: &[json!({"values": {
    // rust: "minecraft:coal": {"value": {"burn": 3}, "replace": true},
    // rust: "minecraft:stick": {"value": 1, "other": 2}
    // rust: }})],
    // rust: )]);
    // rust: let maps = load(&f);
    // rust: assert_eq!(get(&maps, "minecraft:coal"), Some(&json!({"burn": 3})));
        // More than `value` and `replace`: the object is the data.
    // rust: assert_eq!(
    // rust: get(&maps, "minecraft:stick"),
    // rust: Some(&json!({"value": 1, "other": 2}))
    // rust: );
}

a_bad_file_is_skipped_alone_and_bad_types_are_left_out :: proc() {
}
    // rust: let mut f = files(&[(
    // rust: "data_maps/mymod:item/fuel",
    // rust: &[json!({"values": {"minecraft:coal": 1}})],
    // rust: )]);
    // rust: f[0].1.insert(0, b"{nope".to_vec());
    // rust: f[0].1
    // rust: .push(json!({"nothing": true}).to_string().into_bytes());
    // rust: let maps = load(&f);
    // rust: assert_eq!(get(&maps, "minecraft:coal"), Some(&json!(1)));
    // rust: let maps = DataMaps::load(
    // rust: &[
    // rust: ty("minecraft:fuel", "minecraft:item"),
    // rust: ty("mymod:x", "minecraft:biome"),
    // rust: ty("nonamespace", "minecraft:item"),
    // rust: ty("mymod:a", "minecraft:block"),
    // rust: ty("mymod:a", "minecraft:block"),
    // rust: ],
    // rust: &[],
    // rust: &HashMap::new(),
    // rust: &HashMap::new(),
    // rust: );
        // Only the one good type, registered once, empty.
    // rust: assert_eq!(maps.maps.len(), 1);
    // rust: assert!(
    // rust: maps.maps
    // rust: .contains_key(&("minecraft:block".to_owned(), "mymod:a".to_owned()))
    // rust: );
}

block_maps_read_the_block_tags :: proc() {
}
    // rust: let blocks = tags(&[("minecraft:logs", &["minecraft:oak_log"])]);
    // rust: let f = files(&[(
    // rust: "data_maps/mymod:block/hardness",
    // rust: &[json!({"values": {"#minecraft:logs": 2}})],
    // rust: )]);
    // rust: let maps = DataMaps::load(
    // rust: &[ty("mymod:hardness", "minecraft:block")],
    // rust: &f,
    // rust: &HashMap::new(),
    // rust: &blocks,
    // rust: );
    // rust: let map = &maps.maps[&("minecraft:block".to_owned(), "mymod:hardness".to_owned())];
    // rust: assert_eq!(map.get("minecraft:oak_log"), Some(&json!(2)));
}
}
