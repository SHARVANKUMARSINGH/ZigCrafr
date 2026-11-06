//! Transpiled from Horizon Rust crate
package horizon_world_json_folder

import "core:fmt"
import "core:mem"
import "core:math"

// A data folder's files read from the disk once while a load holds them.
// Several tables are built from the same folder (the recipes: the crafting
// tables, the stations, the recipe book, brewing), and each used to list and
// read every file again: on a hard disk or under a virus scanner, each open
// costs. The first reader lists and reads the folder; later readers share
// those bytes for as long as one of them holds the [`Folder`], then it is
// gone (nothing is kept past the load).
// use std::{
    // rust: fs, io,
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Mutex, Weak},
}

// One file: its path inside the folder without `.json` (`a/b`, as an id has
// it), the file, and its bytes or the error reading it gave.
File :: struct {
    name: string,
    path: PathBuf,
    bytes: Result<^[u8],
}
    // rust: impl File {
bytes :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.bytes
    // rust: .as_deref()
    // rust: .map_err(|(kind, message)| io::Error::new(*kind, message.clone()))
}
}

// Every `.json` file under a folder, its subfolders' too, in name order.
Folder :: struct {
    files: [dynamic]File,
}

OPEN :: Mutex::new(Vec::new())

find :: proc(open: ^[(PathBuf) {
}
    // rust: open.iter()
    // rust: .find(|(d, _)| d == dir)
    // rust: .and_then(|(_, f)| f.upgrade())
}

// `dir`'s files if another reader holds them, without reading anything.
held :: proc(dir: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: find(&OPEN.lock().unwrap_or_else(|e| e.into_inner()), dir)
}

// The `.json` files under `dir`: shared with any other reader holding them,
// else listed and read now. An error when `dir` itself can't be listed.
read :: proc(dir: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(folder) = held(dir) {
    // rust: return Ok(folder);
}
    // rust: let files = match prepared(dir) {
    // rust: Some(files) => files,
    // rust: None => list(dir)?
    // rust: .into_iter()
    // rust: .map(|(name, path)| {
    // rust: let bytes = fs::read(&path)
    // rust: .map(Vec::into_boxed_slice)
    // rust: .map_err(|e| (e.kind(), e.to_string()));
    // rust: File { name, path, bytes }
    // rust: })
    // rust: .collect(),
}
    // rust: let folder = Arc::new(Folder { files });
    // rust: let mut open = OPEN.lock().unwrap_or_else(|e| e.into_inner());
    // Another reader may have read it meanwhile: share one copy.
    // rust: if let Some(theirs) = find(&open, dir) {
    // rust: return Ok(theirs);
}
    // rust: open.retain(|(_, f)| f.strong_count() > 0);
    // rust: open.push((dir.to_owned(), Arc::downgrade(&folder)));
    // rust: Ok(folder)
}

// `dir`'s `.json` files from its prepared root's `horizon-data.bin`, when
// that holds them: one open handle instead of a file opened for each.
prepared :: proc(dir: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (data, rel) = horizon_core::prepared_files::find(dir)?;
    // rust: let prefix = format!("{rel}/");
    // rust: let mut files: Vec<File> = data
    // rust: .list(&rel)?
    // rust: .into_iter()
    // rust: .filter_map(|full| {
    // rust: let name = full.strip_prefix(&prefix)?.strip_suffix(".json")?;
    // rust: let bytes = data.read(full)?;
    // rust: Some(File {
    // rust: name: name.to_owned(),
    // rust: path: dir.join(format!("{name}.json")),
    // rust: bytes: bytes
    // rust: .map(Vec::into_boxed_slice)
    // rust: .map_err(|e| (e.kind(), e.to_string())),
    // rust: })
    // rust: })
    // rust: .collect();
    // In `list`'s order: by id, not by file name.
    // rust: files.sort_by(|a, b| a.name.cmp(&b.name));
    // rust: Some(files)
}

// The `.json` files under `dir` and its subfolders, in name order: each
// one's path inside the folder without the extension (`a/b`) and its file.
// An error when `dir` itself can't be listed; a subfolder or an entry that
// can't be is warned and skipped, as vanilla's `PathPackResources` keeps
// what it found.
list :: proc(dir: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut files = Vec::new();
    // rust: let mut stack = vec![fs::read_dir(dir)?];
    // rust: while let Some(entries) = stack.pop() {
    // rust: for entry in entries {
    // rust: let entry = match entry {
    // rust: Ok(entry) => entry,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: failed to list an entry of {}: {e}", dir.display());
    // rust: continue;
}
}
    // rust: let path = entry.path();
    // rust: if path.is_dir() {
    // rust: match fs::read_dir(&path) {
    // rust: Ok(list) => stack.push(list),
    // rust: Err(e) => log::warn!("Horizon: failed to list {}: {e}", path.display()),
}
    // rust: } else if path.extension().is_some_and(|e| e == "json") {
    // rust: files.push(path);
}
}
}
    // rust: let mut named: Vec<(String, PathBuf)> = files
    // rust: .into_iter()
    // rust: .map(|path| {
    // rust: let inside = path.strip_prefix(dir).unwrap_or(&path).with_extension("");
    // rust: let name: Vec<_> = inside.iter().map(|c| c.to_string_lossy()).collect();
    // rust: (name.join("/"), path)
    // rust: })
    // rust: .collect();
    // Vanilla lists resources by id, in a map keyed by it
    // (`FallbackResourceManager`): `crushing` before `crushing/iron`, where
    // a path's components put the subfolder's file first.
    // rust: named.sort_by(|a, b| a.0.cmp(&b.0));
    // rust: Ok(named)
}

    // rust: mod tests {
//     use super::*;

folder :: proc(tag: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-json-folder-{tag}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(dir.join("brewing")).unwrap();
    // rust: fs::write(dir.join("stick.json"), b"{\"a\":1}").unwrap();
    // rust: fs::write(dir.join("brewing/awkward.json"), b"{}").unwrap();
    // rust: fs::write(dir.join("notes.txt"), b"not json").unwrap();
    // rust: dir
}

readers_share_the_bytes_while_one_holds_them_and_read_again_after :: proc() {
}
    // rust: let dir = folder("share");
    // rust: let first = read(&dir).unwrap();
    // rust: let names: Vec<_> = first.files.iter().map(|f| f.name.as_str()).collect();
    // rust: assert_eq!(names, ["brewing/awkward", "stick"]);
    // rust: assert_eq!(first.files[1].bytes().unwrap(), b"{\"a\":1}");
        // Held: a change on the disk isn't seen, the copy read is shared.
    // rust: fs::write(dir.join("stick.json"), b"{\"a\":2}").unwrap();
    // rust: let second = read(&dir).unwrap();
    // rust: assert!(Arc::ptr_eq(&first, &second));
    // rust: drop((first, second));
        // Let go: the next reader reads the folder again.
    // rust: assert_eq!(read(&dir).unwrap().files[1].bytes().unwrap(), b"{\"a\":2}");
    // rust: fs::remove_dir_all(&dir).unwrap();
}

    // Under a prepared root with a `horizon-data.bin`, the folder is read
    // from it: the same files, names and order as the folder's.
a_prepared_root_reads_the_folder_from_its_data_file :: proc() {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-json-folder-root-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let recipes = root.join("data/minecraft/recipe");
    // rust: fs::create_dir_all(recipes.join("crushing")).unwrap();
    // rust: fs::write(root.join("horizon-resources.json"), b"{}").unwrap();
    // rust: fs::write(recipes.join("crushing.json"), b"{\"c\":0}").unwrap();
    // rust: fs::write(recipes.join("crushing/iron.json"), b"{\"c\":1}").unwrap();
    // rust: fs::write(recipes.join("stick.json"), b"{\"a\":1}").unwrap();
    // rust: fs::write(recipes.join("notes.txt"), b"not json").unwrap();
    // rust: let from_folder: Vec<_> = list(&recipes)
    // rust: .unwrap()
    // rust: .into_iter()
    // rust: .map(|(n, _)| n)
    // rust: .collect();
    // rust: horizon_core::prepared_files::write(&root).unwrap();
        // Only the data file still has the stick's first bytes.
    // rust: fs::write(recipes.join("stick.json"), b"{\"a\":2}").unwrap();
    // rust: let folder = read(&recipes).unwrap();
    // rust: let names: Vec<_> = folder.files.iter().map(|f| f.name.clone()).collect();
    // rust: assert_eq!(names, from_folder);
    // rust: assert_eq!(names, ["crushing", "crushing/iron", "stick"]);
    // rust: assert_eq!(folder.files[2].bytes().unwrap(), b"{\"a\":1}");
    // rust: assert_eq!(folder.files[2].path, recipes.join("stick.json"));
    // rust: drop(folder);
    // rust: fs::remove_dir_all(&root).unwrap();
}

a_folder_that_cannot_be_listed_is_an_error :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-json-folder-none-{}", std::process::id()));
    // rust: assert!(read(&dir).is_err());
}
}
