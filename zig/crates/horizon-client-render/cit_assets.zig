//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_cit_assets
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The ids Custom Item Textures' files take in Horizon's atlas and model library. A CIT rule
//! names its textures and models by resource path, mostly under `optifine/cit/` where vanilla
//! never looks: those take the reserved namespace [`NAMESPACE`], their path the resource path's
//! (`assets/minecraft/optifine/cit/swords/flame.png` is
//! `horizon_cit:minecraft/optifine/cit/swords/flame`). A file already under `textures/` (or
//! `models/`) keeps its vanilla id, so it is not packed twice.

// use horizon_assets::model::{CuboidModel, TextureSlot};
// use horizon_optifine::cit::{Kind, Rule};
// use std::collections::{BTreeMap, BTreeSet};
// use std::fs;
// use std::path::Path;

/// The namespace of CIT files outside `textures/` and `models/`.
pub const NAMESPACE: []const u8 = "horizon_cit";

/// `<namespace>:<path>`, if both keep to the identifier rules (lower-case letters, digits,
/// `_.-`, and `/` in the path). CIT Resewn refuses the other paths too.
pub fn identifier(namespace: []const u8, path: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if namespace.is_empty() || path.is_empty() {
    // rust: return None;
}
    // rust: horizon_client_core::identifier::parse_identifier(&format!("{namespace}:{path}"))
}

/// The id of a resource path ending in `.<ext>`: `assets/<ns>/<folder>/<p>` is `<ns>:<p>`, any
/// other `assets/<rest>` is `horizon_cit:<rest>`.
pub fn id(resource: []const u8, folder: []const u8, ext: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rest = resource
    // rust: .strip_prefix("assets/")?
    // rust: .strip_suffix(ext)?
    // rust: .strip_suffix('.')?;
    // rust: if let Some((namespace, path)) = rest.split_once('/')
    // rust: && let Some(path) = path.strip_prefix(folder).and_then(|p| p.strip_prefix('/'))
    // rust: {
        // A pack's own `assets/horizon_cit/` would name another file than its id maps back to.
    // rust: return (namespace != NAMESPACE)
    // rust: .then(|| identifier(namespace, path))
    // rust: .flatten();
}
    // rust: identifier(NAMESPACE, rest)
}

/// The atlas sprite id of a `.png` resource path.
pub fn sprite_id(resource: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: id(resource, "textures", "png")
}

/// The model id of a `.json` resource path.
pub fn model_id(resource: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: id(resource, "models", "json")
}

/// The resource path of a `horizon_cit` id, with the extension `ext`; `None` for other ids,
/// and for one that would leave the resource root (a pack model may write any id).
pub fn resource(id: []const u8, ext: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rest = id.strip_prefix(NAMESPACE)?.strip_prefix(':')?;
    // rust: horizon_optifine::paths::valid(rest).then(|| format!("assets/{rest}.{ext}"))
}

/// Sprite ids the rules whose kind passes `keep` draw: their `texture` and `texture.<name>`
/// values. A path no id can name is skipped with a warning.
pub fn rule_sprites(rules: *[Rule], keep: impl Fn(Kind) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = BTreeSet::new();
    // rust: for rule in rules.iter().filter(|r| keep(r.kind)) {
    // rust: let named = rule.textures.iter().map(|(_, path)| path);
    // rust: for path in rule.texture.iter().chain(named) {
    // rust: match sprite_id(path) {
    // rust: Some(id) => {
    // rust: out.insert(id);
}
    // rust: None => log::warn!(
    // rust: "custom item textures: {} names {path}, which is not a valid texture id",
    // rust: rule.path
    // rust: ),
}
}
}
    // rust: out
}

/// Sprite ids the item rules draw (`Kind::Item`, see [`rule_sprites`]). Textures named by CIT
/// JSON models are [`model_sprites`].
pub fn item_sprites(rules: *[Rule]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: rule_sprites(rules, |kind| kind == Kind::Item)
}

/// The resource path a model value `./x` (or `./../x`, `../x`) names beside the file at `file`,
/// ending in `.<ext>` (added unless the value has it). `None` for other values and for paths
/// that would leave the root.
pub fn relative(file: []const u8, value: []const u8, ext: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut rest = value
    // rust: .strip_prefix("./")
    // rust: .or_else(|| value.starts_with("../").then_some(value))?;
    // rust: let mut dir = file.rsplit_once('/')?.0;
    // rust: while let Some(up) = rest.strip_prefix("../") {
    // rust: dir = dir.rsplit_once('/')?.0;
    // rust: rest = up;
}
    // rust: let rest = rest
    // rust: .strip_suffix(ext)
    // rust: .and_then(|r| r.strip_suffix('.'))
    // rust: .unwrap_or(rest);
    // rust: let path = format!("{dir}/{rest}.{ext}");
    // rust: horizon_optifine::paths::valid(&path).then_some(path)
}

/// The id a relative value of the model at `file` names, as `CuboidModel::from_json` read it
/// (`./x` is `minecraft:./x` there), with the resource path of the file it names.
pub fn rebase(file: []const u8, id: []const u8, ext: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = relative(file, id.strip_prefix("minecraft:")?, ext)?;
    // rust: let id = if ext == "png" {
    // rust: sprite_id(&path)
    // rust: } else {
    // rust: model_id(&path)
    // rust: }?;
    // rust: Some((id, path))
}

/// Parents followed from a rule's model before the rest are left to the library.
pub const MAX_PARENTS: usize = 16;

/// The CIT JSON models the item rules name (`model`, `model.<name>`) under their [`model_id`]s,
/// with the parents they reach by relative path. Their `./x` texture and parent values become
/// the ids of the files beside them. Only `horizon_cit` models: the others are in the model
/// library already. A file that does not read or parse is left out, and a rule's layer that
/// names it (or a model whose parents reach it) keeps its vanilla model.
pub fn load_models(root: *Path, rules: *[Rule]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = BTreeMap::new();
    // rust: let mut seen = BTreeSet::new();
    // rust: for rule in rules.iter().filter(|r| r.kind == Kind::Item) {
    // rust: let named = rule.models.iter().map(|(_, path)| path);
    // rust: for path in rule.model.iter().chain(named) {
    // rust: load_model(root, path, 0, &mut seen, &mut out);
}
}
    // rust: out
}

    // rust: fn load_model(
    // rust: root: &Path,
    // rust: resource: &str,
    // rust: depth: usize,
    // rust: seen: &mut BTreeSet<String>,
    // rust: out: &mut BTreeMap<String, CuboidModel>,
    // rust: ) {
    // rust: let Some(id) = model_id(resource) else {
    // rust: log::warn!("custom item textures: {resource} is not a valid model id");
    // rust: return;
}
    // rust: let ours = id
    // rust: .strip_prefix(NAMESPACE)
    // rust: .is_some_and(|r| r.starts_with(':'));
    // rust: if !ours || depth > MAX_PARENTS || !seen.insert(id.clone()) {
    // rust: return;
}
    // rust: let model = fs::read_to_string(root.join(resource))
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|text| CuboidModel::from_json(&text).map_err(|e| e.to_string()));
    // rust: let mut model = match model {
    // rust: Ok(model) => model,
    // rust: Err(e) => {
    // rust: log::warn!("custom item textures: skipped model {resource}: {e}");
    // rust: return;
}
}
    // rust: for slot in model.textures.values_mut() {
    // rust: if let TextureSlot::Material(m) = slot
    // rust: && let Some((id, _)) = rebase(resource, &m.sprite, "png")
    // rust: {
    // rust: m.sprite = id;
}
}
    // rust: let parent = model
    // rust: .parent
    // rust: .as_deref()
    // rust: .and_then(|p| rebase(resource, p, "json"));
    // rust: if let Some((id, path)) = parent {
    // rust: model.parent = Some(id);
    // rust: load_model(root, &path, depth + 1, seen, out);
}
    // rust: out.insert(id, model);
}

/// The `horizon_cit` sprites `models` name, which the atlas packs beside [`item_sprites`].
pub fn model_sprites(models: *BTreeMap<[]const u8) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let prefix = format!("{NAMESPACE}:");
    // rust: models
    // rust: .values()
    // rust: .flat_map(|m| m.textures.values())
    // rust: .filter_map(|slot| match slot {
    // rust: TextureSlot::Material(m) if m.sprite.starts_with(&prefix) => Some(m.sprite.clone()),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;
//     use crate::atlas_sources::texture_path;
//     use std::path::Path;

pub fn cit_paths_take_the_reserved_namespace_and_come_back() void {
}
    // rust: let png = "assets/minecraft/optifine/cit/swords/flame.png";
    // rust: let id = sprite_id(png).unwrap();
    // rust: assert_eq!(id, "horizon_cit:minecraft/optifine/cit/swords/flame");
    // rust: assert_eq!(resource(&id, "png").as_deref(), Some(png));
    // rust: let json = "assets/minecraft/optifine/cit/swords/flame.json";
    // rust: let id = model_id(json).unwrap();
    // rust: assert_eq!(id, "horizon_cit:minecraft/optifine/cit/swords/flame");
    // rust: assert_eq!(resource(&id, "json").as_deref(), Some(json));
}

pub fn files_under_textures_and_models_keep_their_vanilla_ids() void {
}
    // rust: let id = sprite_id("assets/minecraft/textures/item/stick.png");
    // rust: assert_eq!(id.as_deref(), Some("minecraft:item/stick"));
    // rust: let id = model_id("assets/gems/models/item/ruby.json");
    // rust: assert_eq!(id.as_deref(), Some("gems:item/ruby"));
        // A model id is not a resource of this module's own.
    // rust: assert_eq!(resource("minecraft:item/stick", "png"), None);
        // `textures` as a folder name elsewhere is still a CIT path.
    // rust: let id = sprite_id("assets/minecraft/optifine/cit/textures/a.png");
    // rust: assert_eq!(
    // rust: id.as_deref(),
    // rust: Some("horizon_cit:minecraft/optifine/cit/textures/a")
    // rust: );
}

pub fn paths_no_identifier_can_name_are_refused() void {
}
    // rust: for path in [
    // rust: "assets/minecraft/optifine/cit/Flame.png",
    // rust: "assets/minecraft/optifine/cit/fire sword.png",
    // rust: "assets/minecraft/textures/item/Stick.png",
    // rust: "assets/minecraft/optifine/cit/a.json",
    // rust: "optifine/cit/a.png",
    // rust: ] {
    // rust: assert_eq!(sprite_id(path), None, "{path}");
}
    // rust: assert_eq!(model_id("assets/minecraft/optifine/cit/A.json"), None);
    // rust: assert_eq!(
    // rust: sprite_id("assets//textures/item/x.png"),
    // rust: None,
    // rust: "no namespace"
    // rust: );
}

pub fn the_reserved_namespace_names_only_files_inside_the_root() void {
}
        // A pack's own `horizon_cit` namespace would map back to another file.
    // rust: assert_eq!(sprite_id("assets/horizon_cit/textures/item/x.png"), None);
        // A model may write any id: only ones inside the root name a file.
    // rust: for id in [
    // rust: "horizon_cit:../../etc/x",
    // rust: "horizon_cit:a/../../x",
    // rust: "horizon_cit:a\\..\\x",
    // rust: ] {
    // rust: assert_eq!(resource(id, "png"), None, "{id}");
            // Nor does the texture's file: refused, not read from elsewhere.
    // rust: let file = texture_path(Path::new("/r"), id, "textures");
    // rust: assert!(file.starts_with("/r/assets") && !file.to_string_lossy().contains(".."));
}
    // rust: let escape = texture_path(Path::new("/r"), "minecraft:../../../x", "textures");
    // rust: assert!(!escape.to_string_lossy().contains(".."), "{escape:?}");
}

pub fn both_id_forms_find_their_file() void {
}
    // rust: let root = Path::new("/r");
    // rust: assert_eq!(
    // rust: texture_path(root, "horizon_cit:minecraft/optifine/cit/a", "textures"),
    // rust: root.join("assets/minecraft/optifine/cit/a.png")
    // rust: );
    // rust: assert_eq!(
    // rust: texture_path(root, "minecraft:item/stick", "textures"),
    // rust: root.join("assets/minecraft/textures/item/stick.png")
    // rust: );
}

pub fn rule_models_load_with_their_relative_textures_and_parents() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-cit-models-{}", std::process::id()));
    // rust: let cit = root.join("assets/minecraft/optifine/cit");
    // rust: fs::create_dir_all(cit.join("swords")).unwrap();
    // rust: let write = |rel: &str, text: &str| fs::write(cit.join(rel), text).unwrap();
    // rust: write(
    // rust: "swords/flame.json",
    // rust: r#"{"parent":"./../base","textures":{"layer0":"./flame","layer1":"item/stick"}}"#,
    // rust: );
    // rust: write(
    // rust: "base.json",
    // rust: r#"{"parent":"item/handheld","textures":{"layer2":"./glow.png"}}"#,
    // rust: );
    // rust: let props =
    // rust: horizon_optifine::Properties::parse_equals_first("items=stick\nmodel=./swords/flame");
    // rust: let rule = Rule::parse("assets/minecraft/optifine/cit/a.properties", &props, |p| {
    // rust: root.join(p).is_file()
    // rust: })
    // rust: .unwrap();
    // rust: let models = load_models(&root, &[rule]);
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let cit = |p: &str| format!("horizon_cit:minecraft/optifine/cit/{p}");
    // rust: assert_eq!(
    // rust: models.keys().cloned().collect::<Vec<_>>(),
    // rust: [cit("base"), cit("swords/flame")]
    // rust: );
    // rust: let flame = &models[&cit("swords/flame")];
    // rust: assert_eq!(flame.parent.as_deref(), Some(cit("base").as_str()));
    // rust: assert_eq!(
    // rust: models[&cit("base")].parent.as_deref(),
    // rust: Some("minecraft:item/handheld")
    // rust: );
    // rust: assert_eq!(
    // rust: model_sprites(&models).into_iter().collect::<Vec<_>>(),
    // rust: [cit("glow"), cit("swords/flame")]
    // rust: );
}

pub fn relative_values_stay_in_the_root() void {
}
    // rust: let file = "assets/minecraft/optifine/cit/a/m.json";
    // rust: let at = |v: &str| relative(file, v, "png");
    // rust: assert_eq!(
    // rust: at("./x").as_deref(),
    // rust: Some("assets/minecraft/optifine/cit/a/x.png")
    // rust: );
    // rust: assert_eq!(
    // rust: at("./../x.png").as_deref(),
    // rust: Some("assets/minecraft/optifine/cit/x.png")
    // rust: );
    // rust: assert_eq!(
    // rust: at("../../x").as_deref(),
    // rust: Some("assets/minecraft/optifine/x.png")
    // rust: );
    // rust: assert_eq!(at("item/x"), None);
    // rust: assert_eq!(at("./../../../../../x"), None);
    // rust: assert_eq!(at("./a/../x"), None);
}
}
