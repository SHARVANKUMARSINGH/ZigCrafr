//! Transpiled from Horizon Rust crate
package horizon_client_command_storage

import "core:fmt"
import "core:mem"
import "core:math"

// `CommandStorage`: named compounds for `/data ... storage <id>`, kept per
// namespace in `data/<namespace>/command_storage.dat`.
// use crate::save;
// use horizon_world::nbt::{Compound, Tag};
// use std::{
    // rust: collections::BTreeMap,
    // rust: path::{Path, PathBuf},
}

CommandStorage :: struct {
    // namespace -> path -> contents.
    namespaces: BTreeMap<string,
    dirty: bool,
}
split_id :: proc(id: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: id.split_once(':').unwrap_or(("minecraft", id))
}
file :: proc(root: ^Path, namespace: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: root.join("data")
    // rust: .join(namespace)
    // rust: .join("command_storage.dat")
}
    // rust: impl CommandStorage {
    // Read every `data/<namespace>/command_storage.dat` under a world.
load :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut s = Self::default();
    // rust: let Ok(dirs) = std::fs::read_dir(root.join("data")) else {
    // rust: return s;
}
    // rust: for dir in dirs.flatten() {
    // rust: let namespace = dir.file_name().to_string_lossy().into_owned();
    // rust: let Some(data) =
    // rust: save::read_dat(&file(root, &namespace)).and_then(|t| t.get("data").cloned())
    // rust: else {
    // rust: continue;
}
    // rust: if let Some(Tag::Compound(contents)) = data.get("contents") {
    // rust: let map = contents
    // rust: .iter()
    // rust: .map(|(k, v)| (k.to_string_lossy(), v.clone()))
    // rust: .collect();
    // rust: s.namespaces.insert(namespace, map);
}
}
    // rust: s
}
save :: proc(self: ^Self, root: ^Path) {
}
    // rust: if !self.dirty {
    // rust: return;
}
    // rust: self.dirty = false;
    // rust: for (namespace, map) in &self.namespaces {
    // rust: let contents: Compound = map
    // rust: .iter()
    // rust: .map(|(k, v)| (k.as_str().into(), v.clone()))
    // rust: .collect();
    // rust: if let Err(e) = save::write_dat(
    // rust: &file(root, namespace),
    // rust: Tag::compound([
    // rust: (
    // rust: "data",
    // rust: Tag::compound([("contents", Tag::Compound(contents))]),
    // rust: ),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ]),
    // rust: ) {
    // rust: log::warn!("command storage {namespace} was not written: {e}");
}
}
}
    // `get`: an empty compound when unset.
get :: proc(self: ^Self, id: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let (ns, path) = split_id(id);
    // rust: self.namespaces
    // rust: .get(ns)
    // rust: .and_then(|m| m.get(path))
    // rust: .cloned()
    // rust: .unwrap_or_else(|| Tag::Compound(Compound::new()))
}
    // `set`: empty contents remove the entry.
set :: proc(self: ^Self, id: string, contents: Tag) {
}
    // rust: let (ns, path) = split_id(id);
    // rust: let empty = matches!(&contents, Tag::Compound(c) if c.is_empty());
    // rust: let map = self.namespaces.entry(ns.to_owned()).or_default();
    // rust: if empty {
    // rust: map.remove(path);
    // rust: } else {
    // rust: map.insert(path.to_owned(), contents);
}
    // rust: self.dirty = true;
}
    // Every stored id (`keys`).
keys :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.namespaces
    // rust: .iter()
    // rust: .flat_map(|(ns, m)| m.keys().map(move |k| format!("{ns}:{k}")))
    // rust: .collect()
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::nbt::parse_snbt;

stores_per_namespace_and_persists :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("hz-storage-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let mut s = CommandStorage::default();
    // rust: assert_eq!(s.get("minecraft:x"), Tag::Compound(Compound::new()));
    // rust: s.set("minecraft:x", parse_snbt("{a:1}").unwrap().0);
    // rust: s.set("my:pack/y", parse_snbt("{b:[1,2]}").unwrap().0);
    // rust: s.save(&dir);
    // rust: let back = CommandStorage::load(&dir);
    // rust: assert_eq!(back.get("x"), parse_snbt("{a:1}").unwrap().0);
    // rust: assert_eq!(back.get("my:pack/y"), parse_snbt("{b:[1,2]}").unwrap().0);
    // rust: assert_eq!(back.keys(), vec!["minecraft:x", "my:pack/y"]);
        // Empty contents delete.
    // rust: let mut s = back;
    // rust: s.set("x", Tag::Compound(Compound::new()));
    // rust: assert_eq!(s.keys(), vec!["my:pack/y"]);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
}
