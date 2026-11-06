//! Transpiled from Horizon Rust crate
package horizon_client_native_reload_listeners

import "core:fmt"
import "core:mem"
import "core:math"

// Native mods' own data folders, read on each data load of a server
// (NeoForge's `AddServerReloadListenersEvent`, docs/native-mods.md). A mod
// names a folder under `data/<namespace>/` (`native_add_server_reload_listeners`);
// when a world opens and on `/reload`, the folder's `.json` files of the
// resource root (vanilla's and content mods') and of the world's enabled data
// packs are read as vanilla's `SimpleJsonResourceReloadListener.prepare` reads
// its folder, and handed to the mod (`native_server_reload_listener_apply`).
// use super::{Game, functions};
// use horizon_client::datapack::DataPack;
// use std::collections::BTreeMap;
// use std::path::{Component, Path};

// A folder of JSON files a mod reads from the data packs, as vanilla's
// `SimpleJsonResourceReloadListener` over `FileToIdConverter.json(folder)`.
NativeReloadListener :: struct {
    // `mymod:ore_veins`: which of the mod's listeners the files are for.
    id: string,
    // The folder under `data/<namespace>/`: `ore_veins`, `mymod/ore_veins`.
    folder: string,
}

    // rust: impl NativeReloadListener {
    // The `.json` files of `data/<namespace>/<folder>/`, for listener `id`.
json :: proc(id: string, folder: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: id: id.to_owned(),
    // rust: folder: folder.to_owned(),
}
}
}

// Whether `folder` stays below `data/<namespace>/`.
folder_ok :: proc(folder: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let path = Path::new(folder);
    // rust: !folder.contains('\\')
    // rust: && path.components().next().is_some()
    // rust: && path.components().all(|c| matches!(c, Component::Normal(_)))
}

// `FileToIdConverter.fileToId`: `data/<ns>/<folder>/<path>.json` is
// `<ns>:<path>`; None for a file of another folder or extension.
file_id :: proc(file: string, folder: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (ns, rest) = file.strip_prefix("data/")?.split_once('/')?;
    // rust: let path = rest
    // rust: .strip_prefix(folder)?
    // rust: .strip_prefix('/')?
    // rust: .strip_suffix(".json")?;
    // rust: (!path.is_empty()).then(|| format!("{ns}:{path}"))
}

// The folder's files over `packs`, the bottom one first: each id's file is
// the top pack's (`ResourceManager.listResources`), parsed; one that isn't
// JSON is logged and skipped, as `prepare` does. Sorted by id.
    // rust: fn read_folder(
    // rust: packs: &[&DataPack],
    // rust: listener: &str,
    // rust: folder: &str,
    // rust: ) -> Vec<(String, serde_json::Value)> {
    // rust: let mut top: BTreeMap<String, (&DataPack, String)> = BTreeMap::new();
    // rust: for pack in packs {
    // rust: for file in pack.list_folder(folder) {
    // rust: if let Some(id) = file_id(&file, folder) {
    // rust: top.insert(id, (pack, file));
}
}
}
    // rust: let mut files = Vec::with_capacity(top.len());
    // rust: for (id, (pack, file)) in top {
    // rust: let Some(bytes) = pack.read(&file) else {
    // rust: continue;
}
    // rust: match serde_json::from_slice(&bytes) {
    // rust: Ok(json) => files.push((id, json)),
    // rust: Err(e) => log::error!(
    // rust: "Horizon: couldn't parse data file '{id}' from '{file}' in pack {} for {listener}: {e}",
    // rust: pack.id
    // rust: ),
}
}
    // rust: files
}

    // rust: impl Game<'_> {
    // A server's data load (a world opening, `/reload`): every listener's
    // files go to its mod, before `native_server_data_loaded`.
    // rust: pub(super) fn native_reload_listeners(&mut self) {
    // rust: let mut listeners = Vec::new();
    // rust: self.native_add_server_reload_listeners(&mut listeners);
    // rust: if listeners.is_empty() {
    // rust: return;
}
    // rust: let stack = functions::pack_stack(
    // rust: &self.world_root,
    // rust: &self.options.resources,
    // rust: self.cmds.vanilla_disabled,
    // rust: &self.level.enabled_features,
    // rust: );
    // rust: let packs: Vec<&DataPack> = stack.builtin.iter().chain(stack.enabled_packs()).collect();
    // rust: for listener in &listeners {
    // rust: if !folder_ok(&listener.folder) {
    // rust: log::warn!(
    // rust: "Horizon: reload listener {} folder {:?} is not a folder under data/<namespace>/",
    // rust: listener.id,
    // rust: listener.folder
    // rust: );
    // rust: continue;
}
    // rust: let files = read_folder(&packs, &listener.id, &listener.folder);
    // rust: self.native_server_reload_listener_apply(listener, &files);
}
}
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;
//     use std::fs;
//     use std::path::PathBuf;

Folder :: struct {

    // rust: impl Folder {
new :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-reload-listeners-{name}-{}",
    std: :process::id(),
    // rust: ));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: Self(dir)
}
        // A folder pack with these files.
pack :: proc(self: ^Self, name: string, files: ^[(string) {
}
    // rust: let root = self.0.join(name);
    // rust: for (path, text) in files {
    // rust: let path = root.join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: DataPack::builtin(&root)
}
}

    // rust: impl Drop for Folder {
drop :: proc(self: ^Self) {
}
    // rust: let _ = fs::remove_dir_all(&self.0);
}
}

the_top_pack_wins_each_id_and_ids_drop_the_folder_and_extension :: proc() {
}
    // rust: let dir = Folder::new("top");
    // rust: let root = dir.pack(
    // rust: "root",
    // rust: &[
    // rust: ("data/gt/ore_veins/copper.json", r#"{"weight": 1}"#),
    // rust: ("data/gt/ore_veins/deep/tin.json", r#"{"weight": 2}"#),
    // rust: ("data/other/ore_veins/zinc.json", r#"{"weight": 3}"#),
                // Another folder, and a name that only starts like it.
    // rust: ("data/gt/recipe/plate.json", "{}"),
    // rust: ("data/gt/ore_veins_old/lead.json", "{}"),
    // rust: ],
    // rust: );
    // rust: let world = dir.pack(
    // rust: "world",
    // rust: &[
    // rust: ("data/gt/ore_veins/copper.json", r#"{"weight": 10}"#),
    // rust: ("data/gt/ore_veins/notes.txt", "not json, not read"),
    // rust: ],
    // rust: );
    // rust: let files = read_folder(&[&root, &world], "gt:veins", "ore_veins");
    // rust: assert_eq!(
    // rust: files,
    // rust: [
    // rust: ("gt:copper".to_owned(), json!({"weight": 10})),
    // rust: ("gt:deep/tin".to_owned(), json!({"weight": 2})),
    // rust: ("other:zinc".to_owned(), json!({"weight": 3})),
    // rust: ]
    // rust: );
}

a_broken_top_file_is_skipped_without_falling_back :: proc() {
}
    // rust: let dir = Folder::new("broken");
    // rust: let root = dir.pack(
    // rust: "root",
    // rust: &[
    // rust: ("data/gt/machines/press.json", r#"{"tier": 1}"#),
    // rust: ("data/gt/machines/mixer.json", r#"{"tier": 2}"#),
    // rust: ],
    // rust: );
    // rust: let world = dir.pack("world", &[("data/gt/machines/press.json", "{ tier: ")]);
    // rust: let files = read_folder(&[&root, &world], "gt:machines", "machines");
    // rust: assert_eq!(files, [("gt:mixer".to_owned(), json!({"tier": 2}))]);
}

a_nested_folder_reads_only_below_it :: proc() {
}
    // rust: let dir = Folder::new("nested");
    // rust: let pack = dir.pack(
    // rust: "root",
    // rust: &[
    // rust: ("data/gt/gt/veins/a.json", "1"),
    // rust: ("data/gt/gt/other/b.json", "2"),
    // rust: ],
    // rust: );
    // rust: let files = read_folder(&[&pack], "gt:veins", "gt/veins");
    // rust: assert_eq!(files, [("gt:a".to_owned(), json!(1))]);
}

a_zipped_pack_reads_only_the_folder :: proc() {
}
    // rust: let dir = Folder::new("zip");
    // rust: let packs = dir.0.join("datapacks");
    // rust: fs::create_dir_all(&packs).unwrap();
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(packs.join("veins.zip")).unwrap());
    // rust: for (name, text) in [
    // rust: ("pack.mcmeta", r#"{"pack":{"pack_format":48}}"#),
    // rust: ("data/gt/ore_veins/iron.json", r#"{"y": -16}"#),
    // rust: ("data/gt/ore_veins_old/lead.json", "{}"),
    // rust: ("data/gt/recipe/plate.json", "{}"),
    // rust: ] {
    // rust: zip.start_file(name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: std::io::Write::write_all(&mut zip, text.as_bytes()).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: let found = horizon_client::datapack::discover_folder(&packs);
    // rust: let refs: Vec<&DataPack> = found.iter().collect();
    // rust: let files = read_folder(&refs, "gt:veins", "ore_veins");
    // rust: assert_eq!(files, [("gt:iron".to_owned(), json!({"y": -16}))]);
}

a_folder_outside_the_namespace_is_refused :: proc() {
}
    // rust: assert!(folder_ok("ore_veins"));
    // rust: assert!(folder_ok("gt/ore_veins"));
    // rust: for bad in ["", "..", "../recipe", "gt/../../x", "/abs", "a\\b"] {
    // rust: assert!(!folder_ok(bad), "{bad:?}");
}
}
}
