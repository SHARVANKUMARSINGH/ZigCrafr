//! Transpiled from Horizon Rust crate
//! Module: horizon-optifine_files
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Where packs keep their custom entity models and how a game reads one: the `.jem` files of
//! `emf/cem/` and `optifine/cem/` by model name, each read under [`MAX_BYTES`], parsed, its
//! warnings logged; and the atlas name of a model's texture. Shared by the mobs' and the block
//! entities' models.

// use super::model::{EntityModel, MAX_BYTES, parse_jem};
// use std::{collections::BTreeMap, fs, path::Path};

/// Every `.jem` of the CEM folders by model name, sorted, each name's files best first:
/// `emf/cem` before `optifine/cem` whichever form either uses, and within one folder the flat
/// `<name>.jem` before `<name>/<name>.jem`.
pub fn jem_files(root: *Path) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: BTreeMap<String, Vec<String>> = BTreeMap::new();
    // rust: for base in ["assets/minecraft/emf/cem", "assets/minecraft/optifine/cem"] {
    // rust: let Ok(entries) = fs::read_dir(root.join(base)) else {
    // rust: continue;
}
    // rust: let (mut flat, mut nested) = (Vec::new(), Vec::new());
    // rust: for e in entries.flatten() {
    // rust: let name = e.file_name().to_string_lossy().into_owned();
    // rust: if let Some(model) = name.strip_suffix(".jem") {
                // A directory named `x.jem` isn't a model.
    // rust: if e.path().is_file() {
    // rust: flat.push((model.to_owned(), format!("{base}/{name}")));
}
    // rust: } else {
    // rust: let path = format!("{base}/{name}/{name}.jem");
    // rust: if root.join(&path).is_file() {
    // rust: nested.push((name, path));
}
}
}
    // rust: for (model, path) in flat.into_iter().chain(nested) {
    // rust: out.entry(model).or_default().push(path);
}
}
    // rust: out
}

/// The `.jem` at `path`, its warnings logged; None, with a warning, when it can't be read or
/// parsed.
pub fn load_jem(root: *Path, path: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(text) = read_small(&root.join(path)) else {
    // rust: log::warn!("Horizon: custom entity model {path}: unreadable or over {MAX_BYTES} bytes");
    // rust: return None;
}
    // rust: let jem = match parse_jem(path, &text, &mut |p: &str| read_small(&root.join(p))) {
    // rust: Ok(jem) => jem,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: custom entity model {e}");
    // rust: return None;
}
}
    // rust: for warning in &jem.warnings {
    // rust: log::warn!("Horizon: custom entity model {warning}");
}
    // rust: if let Some(texture) = &jem.texture {
    // rust: if atlas_name(texture).is_none() {
    // rust: log::warn!(
    // rust: "Horizon: custom entity model {path}: its texture {texture} is outside \
    // rust: assets/minecraft/textures/, so not in the atlas: the vanilla one draws"
    // rust: );
    // rust: } else if !root.join(texture).is_file() {
    // rust: log::warn!(
    // rust: "Horizon: custom entity model {path}: its texture {texture} doesn't exist, \
    // rust: so not in the atlas: the vanilla one draws"
    // rust: );
}
}
    // rust: Some(jem)
}

/// A pack file's text, None when it's missing or larger than a model may read: its size is
/// checked before anything is read.
pub fn read_small(path: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = fs::metadata(path).ok()?.len();
    // rust: if len > MAX_BYTES as u64 {
    // rust: return None;
}
    // rust: fs::read_to_string(path).ok()
}

/// The atlas name of a texture resource path: `assets/minecraft/textures/entity/x.png` is
/// `entity/x`. Textures outside a `textures/` folder are not in the atlas.
pub fn atlas_name(path: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rest = path.strip_prefix("assets/minecraft/textures/")?;
    // rust: Some(rest.strip_suffix(".png").unwrap_or(rest).to_owned())
}

    // rust: mod tests {
//     use super::*;

pub fn emf_files_win_and_a_flat_file_beats_its_folder() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-jem-files-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: for path in [
            // EMF's folder form over OptiFine's flat file.
    // rust: "optifine/cem/cow.jem",
    // rust: "emf/cem/cow/cow.jem",
            // One folder: the flat file over the folder form.
    // rust: "optifine/cem/pig.jem",
    // rust: "optifine/cem/pig/pig.jem",
            // A directory named `sheep.jem` is no file: the folder form stands.
    // rust: "optifine/cem/sheep.jem/readme.txt",
    // rust: "optifine/cem/sheep/sheep.jem",
    // rust: ] {
    // rust: let path = root.join("assets/minecraft").join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, "{}").unwrap();
}
    // rust: let files = jem_files(&root);
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: let paths = |paths: &[&str]| {
    // rust: paths
    // rust: .iter()
    // rust: .map(|p| format!("assets/minecraft/{p}"))
    // rust: .collect::<Vec<_>>()
}
    // rust: assert_eq!(
    // rust: files,
    // rust: BTreeMap::from([
    // rust: (
    // rust: "cow".to_owned(),
    // rust: paths(&["emf/cem/cow/cow.jem", "optifine/cem/cow.jem"])
    // rust: ),
    // rust: (
    // rust: "pig".to_owned(),
    // rust: paths(&["optifine/cem/pig.jem", "optifine/cem/pig/pig.jem"])
    // rust: ),
    // rust: ("sheep".to_owned(), paths(&["optifine/cem/sheep/sheep.jem"])),
    // rust: ])
    // rust: );
}
}
