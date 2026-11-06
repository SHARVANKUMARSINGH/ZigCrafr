//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_block_entity_cem
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! OptiFine custom entity models over the block entities' models (`block_entity_render`'s
//! `MODELS`): `chest.jem`, `shulker_box.jem`, `banner.jem`, `bell.jem`, `head_zombie.jem`... (the
//! "Block entity name" table of OptiFine's `cem_model.txt`, and Entity Model Features' one-file
//! `banner`), found and read as the mobs' are ([`horizon_optifine::cem::files`]). Each entry
//! replaces or joins the boxes of the vanilla part it names and takes its `scale`; animations
//! don't run yet. A `.jem`'s texture paints the models it reshapes instead of vanilla's when the
//! atlas has it.
//!
//! An entry's part is OptiFine's name for it, else the vanilla part's own name. Trapped and
//! ender chests take only their own file, and copper chests (no CEM name) keep vanilla's chest.
//! Lectern and enchanting-table books take theirs, else `book`. Signs, hanging signs and beds are
//! block models here, so their files are not read; copper golem statues have no CEM name.

// use crate::block_entity_render::ModelPart;
// use horizon_optifine::cem::{
    // rust: files::{atlas_name, jem_files, load_jem},
    // rust: model::{Bone, EntityModel},
}
// use std::{
    // rust: collections::{BTreeMap, HashMap, HashSet},
    // rust: path::Path,
}

/// One model the renderer draws, the CEM names that reshape it, best first, and OptiFine's
/// names for its vanilla parts.
pub const Target = struct {
    key: *'static str,
    /// The vanilla model it starts from: `key` itself, or the one a block the renderer tells
    /// apart shares (a trapped chest's is the chest's).
    base: *'static str,
    names: *'static [*'static str],
    parts: *'static [(*'static str,
};

    // rust: const CHEST: &[(&str, &str)] = &[
    // rust: ("root", "root"),
    // rust: ("base", "bottom"),
    // rust: ("lid", "lid"),
    // rust: ("knob", "lock"),
    // rust: ];
pub const SHULKER: *[([]const u8, []const u8)] = &[("root", "root"), ("base", "base"), ("lid", "lid")];
pub const BANNER: *[([]const u8, []const u8)] = &[("stand", "pole"), ("top", "bar")];
pub const FLAG: *[([]const u8, []const u8)] = &[("slate", "flag")];
pub const HEAD: *[([]const u8, []const u8)] = &[("root", "root"), ("head", "head")];
pub const DRAGON: *[([]const u8, []const u8)] = &[("root", "root"), ("head", "head"), ("jaw", "jaw")];
    // rust: const PIGLIN: &[(&str, &str)] = &[
    // rust: ("root", "root"),
    // rust: ("head", "head"),
    // rust: ("left_ear", "left_ear"),
    // rust: ("right_ear", "right_ear"),
    // rust: ];
    // rust: const BELL: &[(&str, &str)] = &[
    // rust: ("root", "root"),
    // rust: ("body", "bell_body"),
    // rust: ("base", "bell_base"),
    // rust: ];
    // rust: const BOOK: &[(&str, &str)] = &[
    // rust: ("root", "root"),
    // rust: ("cover_right", "right_lid"),
    // rust: ("cover_left", "left_lid"),
    // rust: ("pages_right", "right_pages"),
    // rust: ("pages_left", "left_pages"),
    // rust: ("flipping_page_right", "flip_page1"),
    // rust: ("flipping_page_left", "flip_page2"),
    // rust: ("book_spine", "seam"),
    // rust: ];
pub const POT_BASE: *[([]const u8, []const u8)] = &[("neck", "neck"), ("top", "top"), ("bottom", "bottom")];
    // rust: const POT_SIDES: &[(&str, &str)] = &[
    // rust: ("front", "front"),
    // rust: ("back", "back"),
    // rust: ("left", "left"),
    // rust: ("right", "right"),
    // rust: ];

    // rust: const fn model(
    // rust: key: &'static str,
    // rust: names: &'static [&'static str],
    // rust: parts: &'static [(&'static str, &'static str)],
    // rust: ) -> Target {
    // rust: Target {
    // rust: key,
    // rust: base: key,
    // rust: names,
    // rust: parts,
}
}
    // rust: const fn copy(
    // rust: key: &'static str,
    // rust: base: &'static str,
    // rust: names: &'static [&'static str],
    // rust: parts: &'static [(&'static str, &'static str)],
    // rust: ) -> Target {
    // rust: Target {
    // rust: key,
    // rust: base,
    // rust: names,
    // rust: parts,
}
}

/// In order: a copy comes after its base.
    // rust: const TARGETS: &[Target] = &[
    // rust: model("chest", &["chest"], CHEST),
    // rust: model("double_chest_left", &["chest_left"], CHEST),
    // rust: model("double_chest_right", &["chest_right"], CHEST),
    // rust: copy("trapped_chest", "chest", &["trapped_chest"], CHEST),
    // rust: copy(
    // rust: "trapped_chest_left",
    // rust: "double_chest_left",
    // rust: &["trapped_chest_left"],
    // rust: CHEST,
    // rust: ),
    // rust: copy(
    // rust: "trapped_chest_right",
    // rust: "double_chest_right",
    // rust: &["trapped_chest_right"],
    // rust: CHEST,
    // rust: ),
    // rust: copy("ender_chest", "chest", &["ender_chest"], CHEST),
    // rust: model("shulker_box", &["shulker_box"], SHULKER),
    // rust: model("standing_banner", &["banner_base", "banner"], BANNER),
    // rust: model("wall_banner", &["banner_base", "banner"], BANNER),
    // rust: model("standing_banner_flag", &["banner_flag", "banner"], FLAG),
    // rust: model("wall_banner_flag", &["banner_flag", "banner"], FLAG),
    // rust: model("skeleton_skull", &["head_skeleton"], HEAD),
    // rust: model("wither_skeleton_skull", &["head_wither_skeleton"], HEAD),
    // rust: model("zombie_head", &["head_zombie"], HEAD),
    // rust: model("creeper_head", &["head_creeper"], HEAD),
    // rust: model("dragon_skull", &["head_dragon"], DRAGON),
    // rust: model("piglin_head", &["head_piglin"], PIGLIN),
    // rust: model("player_head", &["head_player"], HEAD),
    // rust: model("bell", &["bell"], BELL),
    // rust: model("book", &["enchanting_book", "book"], BOOK),
    // rust: copy("lectern_book", "book", &["lectern_book", "book"], BOOK),
    // rust: model("conduit_shell", &["conduit"], &[("base", "shell")]),
    // rust: model("conduit_cage", &["conduit"], &[("cage", "shell")]),
    // rust: model("conduit_wind", &["conduit"], &[("wind", "wind")]),
    // rust: model("conduit_eye", &["conduit"], &[("eye", "eye")]),
    // rust: model("decorated_pot_base", &["decorated_pot"], POT_BASE),
    // rust: model("decorated_pot_sides", &["decorated_pot"], POT_SIDES),
    // rust: ];

/// Every model, reshaped or vanilla's, and the atlas names of the `.jem` textures by model.
    // rust: pub type Reshaped = (
    // rust: HashMap<&'static str, ModelPart>,
    // rust: HashMap<&'static str, String>,
    // rust: );

/// The models the packs under `root` reshape, over `vanilla`'s; None when no block entity has
/// a `.jem` there.
pub fn reshape(root: *Path, vanilla: *HashMap<*'static str) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (reshaped, unused) = reshape_all(root, vanilla)?;
    // rust: for (path, part) in unused {
    // rust: log::warn!("Horizon: custom entity model {path}: no part {part}");
}
    // rust: Some(reshaped)
}

/// [`reshape`]'s models, and each file's entries whose part none of the models it reshapes has.
    // rust: fn reshape_all(
    // rust: root: &Path,
    // rust: vanilla: &HashMap<&'static str, ModelPart>,
    // rust: ) -> Option<(Reshaped, Vec<(String, String)>)> {
    // rust: let files = jem_files(root);
    // rust: let named = |t: &Target| t.names.iter().any(|n| files.contains_key(*n));
    // rust: if !TARGETS.iter().any(named) {
    // rust: return None;
}
    // rust: let mut models = vanilla.clone();
    // rust: let mut textures = HashMap::new();
    // rust: let mut reshaped = HashSet::new();
    // Each file parsed once; which of its entries found a part in some model.
    // rust: let mut parsed: HashMap<&str, Option<EntityModel>> = HashMap::new();
    // rust: let mut used: BTreeMap<&str, Vec<bool>> = BTreeMap::new();
    // rust: for t in TARGETS {
    // rust: let Some(model) = vanilla.get(t.base) else {
    // rust: continue;
}
    // rust: let found = t
    // rust: .names
    // rust: .iter()
    // rust: .flat_map(|name| files.get(*name).into_iter().flatten())
    // rust: .map(String::as_str)
    // rust: .find(|&path| {
    // rust: parsed
    // rust: .entry(path)
    // rust: .or_insert_with(|| load_jem(root, path))
    // rust: .is_some()
    // rust: });
    // rust: let Some(path) = found else {
            // A copy of a reshaped base that has no file of its own stays vanilla.
    // rust: if t.key != t.base && reshaped.contains(t.base) {
    // rust: models.insert(t.key, model.clone());
}
    // rust: continue;
}
    // rust: let Some(Some(jem)) = parsed.get(path) else {
    // rust: continue;
}
    // rust: let mut out = model.clone();
    // rust: let hits = apply(&mut out, jem, t.parts);
        // A file shared by several models (the conduit's, the pot's) paints only the models
        // it reshapes: vanilla geometry keeps its own texture's layout.
    // rust: let reshapes = hits.iter().any(|hit| *hit);
    // rust: let marks = used
    // rust: .entry(path)
    // rust: .or_insert_with(|| vec![false; jem.parts.len()]);
    // rust: for (mark, hit) in marks.iter_mut().zip(hits) {
    // rust: *mark |= hit;
}
    // rust: models.insert(t.key, out);
    // rust: reshaped.insert(t.key);
    // rust: if reshapes && let Some(texture) = jem.texture.as_deref().and_then(atlas_name) {
    // rust: textures.insert(t.key, texture);
}
}
    // rust: let mut unused = Vec::new();
    // rust: for (path, marks) in &used {
    // rust: let Some(Some(jem)) = parsed.get(path) else {
    // rust: continue;
}
    // rust: for (p, _) in jem.parts.iter().zip(marks).filter(|(_, hit)| !**hit) {
    // rust: unused.push(((*path).to_owned(), p.part.clone()));
}
}
    // rust: Some(((models, textures), unused))
}

/// `jem`'s entries on `model`, OptiFine's part names read through `parts`, else as the vanilla
/// part's own name: a replacing entry clears its part's boxes, and each joins the part as a child
/// `cem#<n>`. Which entries found their part.
pub fn apply(model: *mut ModelPart, jem: *EntityModel, parts: *[([]const u8) void {
}
    // rust: let mut count = 0;
    // rust: let mut hits = Vec::with_capacity(jem.parts.len());
    // rust: for p in &jem.parts {
    // rust: let mapped = parts.iter().find(|(of, _)| *of == p.part).map(|&(_, v)| v);
    // rust: let target = match mapped {
    // rust: Some(vanilla) if find_mut(model, vanilla).is_some() => vanilla,
    // rust: _ => p.part.as_str(),
}
    // rust: let Some(node) = find_mut(model, target) else {
    // rust: hits.push(false);
    // rust: continue;
}
    // rust: if !p.attach {
    // rust: node.polygons.clear();
}
    // rust: let (name, mut bone) = part(&p.bone, &mut count);
    // rust: bone.pose[6..9].fill(p.scale);
    // rust: node.children.push((name, bone));
    // rust: hits.push(true);
}
    // rust: hits
}

/// The model itself for `root`, else its first part named `name`, depth first.
    // rust: fn find_mut<'a>(model: &'a mut ModelPart, name: &str) -> Option<&'a mut ModelPart> {
    // rust: fn child<'a>(part: &'a mut ModelPart, name: &str) -> Option<&'a mut ModelPart> {
    // rust: part.children.iter_mut().find_map(|(n, c)| {
    // rust: if n.as_str() == name {
    // rust: Some(c)
    // rust: } else {
    // rust: child(c, name)
}
    // rust: })
}
    // rust: if name == "root" {
    // rust: return Some(model);
}
    // rust: child(model, name)
}

/// A baked bone as a model part, named `cem#<n>`: unique in the model, so no vanilla pose
/// change by name reaches it.
pub fn part(bone: *Bone, count: *mut usize) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = format!("cem#{count}");
    // rust: *count += 1;
    // rust: let [x, y, z] = bone.pivot;
    // rust: let [rx, ry, rz] = bone.rotation;
    // rust: let out = ModelPart {
    // rust: pose: [x, y, z, rx, ry, rz, 1.0, 1.0, 1.0],
    // rust: polygons: bone.quads.iter().map(|q| q.vertices).collect(),
    // rust: children: bone.children.iter().map(|c| part(c, count)).collect(),
}
    // rust: (name, out)
}

    // rust: pub(crate) mod tests {
//     use super::*;
//     use std::{collections::BTreeSet, fs};

    /// A part with one face and `children`.
    // rust: pub(crate) fn plane(children: Vec<(&str, ModelPart)>) -> ModelPart {
    // rust: ModelPart {
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: vec![[[0.0; 5]; 4]],
    // rust: children: children
    // rust: .into_iter()
    // rust: .map(|(n, c)| (n.to_owned(), c))
    // rust: .collect(),
}
}
    // rust: pub(crate) fn chest() -> ModelPart {
    // rust: let mut root = plane(vec![
    // rust: ("bottom", plane(vec![])),
    // rust: ("lid", plane(vec![])),
    // rust: ("lock", plane(vec![])),
    // rust: ]);
    // rust: root.polygons.clear();
    // rust: root
}
    // rust: pub(crate) const BOX: &str =
    // rust: r#""boxes": [{"coordinates": [0, 0, 0, 1, 1, 1], "textureOffset": [0, 0]}]"#;
    /// A fresh pack folder named for `test`, holding `files` under `assets/minecraft/`.
    // rust: pub(crate) fn pack(test: &str, files: &[(&str, String)]) -> std::path::PathBuf {
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-be-cem-{test}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: for (path, text) in files {
    // rust: let path = root.join("assets/minecraft").join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, text).unwrap();
}
    // rust: root
}
    /// A `.jem` replacing each of `parts` with one box.
pub fn jem(parts: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entries: Vec<_> = parts
    // rust: .iter()
    // rust: .map(|p| format!(r#"{{"part": "{p}", {BOX}}}"#))
    // rust: .collect();
    // rust: format!(r#"{{"models": [{}]}}"#, entries.join(", "))
}
    /// A `.jem` replacing each of `parts` with a box of its own: the `i`th is `i + 1` pixels
    /// deep, so a part that took another entry's box shows.
pub fn jem_sized(parts: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entries: Vec<_> = parts
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, p)| {
    // rust: let depth = i + 1;
    // rust: format!(
    // rust: r#"{{"part": "{p}", "boxes": [{{"coordinates": [0, 0, 0, 1, 1, {depth}], "textureOffset": [0, 0]}}]}}"#
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: format!(r#"{{"models": [{}]}}"#, entries.join(", "))
}
    /// How deep (z) the custom box under `model`'s part `name` is.
pub fn depth(model: *ModelPart, name: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let part = model.child(name).unwrap();
    // rust: let zs = part
    // rust: .children
    // rust: .iter()
    // rust: .flat_map(|(_, c)| c.polygons.iter().flatten().map(|v| v[2]));
    // rust: let (lo, hi) = zs.fold((f32::MAX, f32::MIN), |(lo, hi), z| (lo.min(z), hi.max(z)));
    // rust: hi - lo
}
    /// Whether `model`'s part `name` was replaced by one custom box: its own face gone, and one
    /// child of a box's six faces.
pub fn replaced(model: *ModelPart, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let part = model.child(name).unwrap();
    // rust: match part.children.as_slice() {
    // rust: [(_, only)] => part.polygons.is_empty() && only.polygons.len() == 6,
    // rust: _ => false,
}
}

pub fn every_optifine_part_name_lands_on_its_vanilla_part() void {
}
        // File, OptiFine's part, the model it reshapes, vanilla's part there.
    // rust: let cases = [
    // rust: ("chest", "base", "chest", "bottom"),
    // rust: ("chest", "lid", "chest", "lid"),
    // rust: ("chest", "knob", "chest", "lock"),
    // rust: ("chest_left", "base", "double_chest_left", "bottom"),
    // rust: ("chest_left", "lid", "double_chest_left", "lid"),
    // rust: ("chest_left", "knob", "double_chest_left", "lock"),
    // rust: ("chest_right", "base", "double_chest_right", "bottom"),
    // rust: ("chest_right", "lid", "double_chest_right", "lid"),
    // rust: ("chest_right", "knob", "double_chest_right", "lock"),
    // rust: ("trapped_chest", "base", "trapped_chest", "bottom"),
    // rust: ("trapped_chest", "knob", "trapped_chest", "lock"),
    // rust: ("trapped_chest_left", "base", "trapped_chest_left", "bottom"),
    // rust: ("trapped_chest_left", "knob", "trapped_chest_left", "lock"),
    // rust: (
    // rust: "trapped_chest_right",
    // rust: "base",
    // rust: "trapped_chest_right",
    // rust: "bottom",
    // rust: ),
    // rust: ("trapped_chest_right", "knob", "trapped_chest_right", "lock"),
    // rust: ("ender_chest", "base", "ender_chest", "bottom"),
    // rust: ("ender_chest", "knob", "ender_chest", "lock"),
    // rust: ("shulker_box", "base", "shulker_box", "base"),
    // rust: ("shulker_box", "lid", "shulker_box", "lid"),
    // rust: ("banner", "stand", "standing_banner", "pole"),
    // rust: ("banner", "top", "standing_banner", "bar"),
    // rust: ("banner", "top", "wall_banner", "bar"),
    // rust: ("banner", "slate", "standing_banner_flag", "flag"),
    // rust: ("banner", "slate", "wall_banner_flag", "flag"),
    // rust: ("head_skeleton", "head", "skeleton_skull", "head"),
    // rust: (
    // rust: "head_wither_skeleton",
    // rust: "head",
    // rust: "wither_skeleton_skull",
    // rust: "head",
    // rust: ),
    // rust: ("head_zombie", "head", "zombie_head", "head"),
    // rust: ("head_creeper", "head", "creeper_head", "head"),
    // rust: ("head_dragon", "head", "dragon_skull", "head"),
    // rust: ("head_dragon", "jaw", "dragon_skull", "jaw"),
    // rust: ("head_piglin", "head", "piglin_head", "head"),
    // rust: ("head_piglin", "left_ear", "piglin_head", "left_ear"),
    // rust: ("head_piglin", "right_ear", "piglin_head", "right_ear"),
    // rust: ("head_player", "head", "player_head", "head"),
    // rust: ("bell", "body", "bell", "bell_body"),
    // rust: ("bell", "base", "bell", "bell_base"),
    // rust: ("enchanting_book", "cover_right", "book", "right_lid"),
    // rust: ("enchanting_book", "cover_left", "book", "left_lid"),
    // rust: ("enchanting_book", "pages_right", "book", "right_pages"),
    // rust: ("enchanting_book", "pages_left", "book", "left_pages"),
    // rust: (
    // rust: "enchanting_book",
    // rust: "flipping_page_right",
    // rust: "book",
    // rust: "flip_page1",
    // rust: ),
    // rust: (
    // rust: "enchanting_book",
    // rust: "flipping_page_left",
    // rust: "book",
    // rust: "flip_page2",
    // rust: ),
    // rust: ("enchanting_book", "book_spine", "book", "seam"),
    // rust: ("lectern_book", "cover_right", "lectern_book", "right_lid"),
    // rust: ("lectern_book", "pages_left", "lectern_book", "left_pages"),
    // rust: (
    // rust: "lectern_book",
    // rust: "flipping_page_right",
    // rust: "lectern_book",
    // rust: "flip_page1",
    // rust: ),
    // rust: ("lectern_book", "book_spine", "lectern_book", "seam"),
    // rust: ("conduit", "base", "conduit_shell", "shell"),
    // rust: ("conduit", "cage", "conduit_cage", "shell"),
    // rust: ("conduit", "wind", "conduit_wind", "wind"),
    // rust: ("conduit", "eye", "conduit_eye", "eye"),
    // rust: ("decorated_pot", "neck", "decorated_pot_base", "neck"),
    // rust: ("decorated_pot", "top", "decorated_pot_base", "top"),
    // rust: ("decorated_pot", "bottom", "decorated_pot_base", "bottom"),
    // rust: ("decorated_pot", "front", "decorated_pot_sides", "front"),
    // rust: ("decorated_pot", "back", "decorated_pot_sides", "back"),
    // rust: ("decorated_pot", "left", "decorated_pot_sides", "left"),
    // rust: ("decorated_pot", "right", "decorated_pot_sides", "right"),
    // rust: ];
        // One file per name with each of its parts, and a stub of each model holding its parts
        // (chest models all of theirs, so a misplaced entry shows).
    // rust: let mut files: BTreeMap<&str, BTreeSet<&str>> = BTreeMap::new();
    // rust: let mut trees: BTreeMap<&str, BTreeSet<&str>> = BTreeMap::new();
    // rust: for (file, part, key, vanilla) in cases {
    // rust: files.entry(file).or_default().insert(part);
    // rust: trees.entry(key).or_default().insert(vanilla);
}
    // rust: for key in ["chest", "double_chest_left", "double_chest_right"] {
    // rust: trees
    // rust: .entry(key)
    // rust: .or_default()
    // rust: .extend(["bottom", "lid", "lock"]);
}
    // rust: let files_by_name = files.clone();
    // rust: let files: Vec<_> = files
    // rust: .iter()
    // rust: .map(|(file, parts)| {
    // rust: let parts: Vec<_> = parts.iter().copied().collect();
    // rust: (format!("optifine/cem/{file}.jem"), jem_sized(&parts))
    // rust: })
    // rust: .collect();
    // rust: let files: Vec<_> = files.iter().map(|(p, t)| (p.as_str(), t.clone())).collect();
    // rust: let root = pack("parts", &files);
    // rust: let vanilla: HashMap<&'static str, ModelPart> = trees
    // rust: .iter()
    // rust: .map(|(key, parts)| {
    // rust: let parts = parts.iter().map(|p| (*p, plane(vec![]))).collect();
    // rust: (*key, plane(parts))
    // rust: })
    // rust: .collect();
    // rust: let result = reshape_all(&root, &vanilla);
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: let ((models, _), unused) = result.unwrap();
    // rust: for (file, part, key, vanilla) in cases {
    // rust: assert!(
    // rust: replaced(&models[key], vanilla),
    // rust: "{file}.jem {part}: {key} {vanilla}"
    // rust: );
            // The box is this entry's own: swapped names (left and right, body and base) show.
    // rust: let own = files_by_name[file].iter().position(|p| *p == part).unwrap() + 1;
    // rust: assert_eq!(
    // rust: depth(&models[key], vanilla),
    // rust: own as f32,
    // rust: "{file}.jem {part}: {key} {vanilla}"
    // rust: );
}
    // rust: assert_eq!(unused, Vec::new());
}

pub fn a_chest_jem_reshapes_the_chest_alone_and_warns_of_entries_without_a_part() void {
}
    // rust: let root = pack(
    // rust: "chest",
    // rust: &[(
    // rust: "optifine/cem/chest.jem",
    // rust: format!(
    // rust: r#"{{"texture": "textures/entity/chest/fancy.png", "models": [
    // rust: {{"part": "lid", {BOX}}},
    // rust: {{"part": "knob", "attach": true, "scale": 2, {BOX}}},
    // rust: {{"part": "bottom", {BOX}}},
    // rust: {{"part": "tail", {BOX}}}]}}"#
    // rust: ),
    // rust: )],
    // rust: );
    // rust: let vanilla: HashMap<_, _> = [("chest", chest()), ("double_chest_left", chest())].into();
    // rust: let result = reshape_all(&root, &vanilla);
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: let ((models, textures), unused) = result.unwrap();
    // rust: let chest = &models["chest"];
        // Replaced: the lid's own face goes and the custom box (6 faces) joins it.
    // rust: assert!(replaced(chest, "lid"));
        // `bottom` is no OptiFine name but vanilla's own: it reaches the part as well.
    // rust: assert!(replaced(chest, "bottom"));
        // Attached: the lock keeps its face beside the scaled box.
    // rust: let lock = chest.child("lock").unwrap();
    // rust: assert_eq!((lock.polygons.len(), lock.children.len()), (1, 1));
    // rust: assert_eq!(lock.children[0].1.pose[6..], [2.0, 2.0, 2.0]);
        // `tail` names no chest part: the one warning.
    // rust: assert_eq!(
    // rust: unused,
    // rust: [(
    // rust: "assets/minecraft/optifine/cem/chest.jem".to_owned(),
    // rust: "tail".to_owned()
    // rust: )]
    // rust: );
        // The double chest has no file, nor do trapped and ender chests: vanilla's own, and
        // only the chest takes the texture.
    // rust: for key in ["double_chest_left", "trapped_chest", "ender_chest"] {
    // rust: let lid = models[key].child("lid").unwrap();
    // rust: assert_eq!((lid.polygons.len(), lid.children.len()), (1, 0), "{key}");
}
    // rust: assert_eq!(
    // rust: textures,
    // rust: HashMap::from([("chest", "entity/chest/fancy".to_owned())])
    // rust: );
}

pub fn banners_split_one_file_and_books_fall_back() void {
}
    // rust: let root = pack(
    // rust: "banner",
    // rust: &[
    // rust: ("optifine/cem/banner.jem", jem(&["stand", "top", "slate"])),
    // rust: ("emf/cem/enchanting_book.jem", jem(&["cover_left"])),
    // rust: ],
    // rust: );
    // rust: let banner = plane(vec![("pole", plane(vec![])), ("bar", plane(vec![]))]);
    // rust: let wall = plane(vec![("bar", plane(vec![]))]);
    // rust: let flag = plane(vec![("flag", plane(vec![]))]);
    // rust: let book = plane(vec![("left_lid", plane(vec![]))]);
    // rust: let vanilla: HashMap<_, _> = [
    // rust: ("standing_banner", banner),
    // rust: ("wall_banner", wall),
    // rust: ("wall_banner_flag", flag),
    // rust: ("book", book),
    // rust: ]
    // rust: .into();
    // rust: let result = reshape_all(&root, &vanilla);
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: let ((models, textures), unused) = result.unwrap();
    // rust: assert!(replaced(&models["standing_banner"], "pole"));
    // rust: assert!(replaced(&models["standing_banner"], "bar"));
    // rust: assert!(replaced(&models["wall_banner"], "bar"));
    // rust: assert!(replaced(&models["wall_banner_flag"], "flag"));
    // rust: assert!(replaced(&models["book"], "left_lid"));
        // The lectern's book has no file of its own nor `book.jem`: vanilla's.
    // rust: let lectern = models["lectern_book"].child("left_lid").unwrap();
    // rust: assert_eq!((lectern.polygons.len(), lectern.children.len()), (1, 0));
    // rust: assert!(textures.is_empty());
        // Each entry found its part in one of the models: no warning.
    // rust: assert_eq!(unused, Vec::new());
}

pub fn book_jem_reshapes_the_lectern_book_without_its_own_file() void {
}
    // rust: let root = pack("book", &[("optifine/cem/book.jem", jem(&["cover_left"]))]);
    // rust: let vanilla: HashMap<_, _> = [("book", plane(vec![("left_lid", plane(vec![]))]))].into();
    // rust: let result = reshape(&root, &vanilla);
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: let (models, _) = result.unwrap();
    // rust: assert!(replaced(&models["book"], "left_lid"));
    // rust: assert!(replaced(&models["lectern_book"], "left_lid"));
}

pub fn a_shared_file_paints_only_the_models_it_reshapes() void {
}
        // The conduit's file reshapes its eye alone: the shell, cage and wind keep their
        // vanilla geometry and so their own textures.
    // rust: let file = format!(
    // rust: r#"{{"texture": "textures/entity/conduit/custom.png", "models": [{{"part": "eye", {BOX}}}]}}"#
    // rust: );
    // rust: let root = pack("conduit", &[("optifine/cem/conduit.jem", file)]);
    // rust: let vanilla: HashMap<_, _> = [
    // rust: "conduit_shell",
    // rust: "conduit_cage",
    // rust: "conduit_wind",
    // rust: "conduit_eye",
    // rust: ]
    // rust: .map(|key| {
    // rust: let part = if key == "conduit_eye" { "eye" } else { "shell" };
    // rust: (key, plane(vec![(part, plane(vec![]))]))
    // rust: })
    // rust: .into();
    // rust: let result = reshape(&root, &vanilla);
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: let (models, textures) = result.unwrap();
    // rust: assert!(replaced(&models["conduit_eye"], "eye"));
    // rust: let painted: BTreeSet<_> = textures.keys().copied().collect();
    // rust: assert_eq!(painted, BTreeSet::from(["conduit_eye"]));
    // rust: assert_eq!(textures["conduit_eye"], "entity/conduit/custom");
}
}
