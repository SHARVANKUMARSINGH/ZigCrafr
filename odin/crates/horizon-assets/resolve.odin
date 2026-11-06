//! Transpiled from Horizon Rust crate
package horizon_assets_resolve

import "core:fmt"
import "core:mem"
import "core:math"

// Cuboid parent inheritance and texture-slot resolution.
// use crate::{
    // rust: json::*,
    // rust: model::*,
    // rust: obj::{ObjModel, parse_mtl, parse_obj},
}
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: sync::{Arc, Mutex},
}

MISSING_MODEL :: "minecraft:builtin/missing"
// `ItemModelGenerator.GENERATED_ITEM_MODEL_ID`.
GENERATED_MODEL :: "minecraft:builtin/generated"
// Composite children nest through parents that may name the composite again.
MAX_LOADER_DEPTH :: 8

// Reads asset files that models point at (`namespace:path` is `assets/namespace/path`).
    // rust: pub trait AssetReader: Send + Sync {
read_text :: proc(self: ^Self, location: string) -> O {
    // Ported from Horizon
    return {}
}
}
// Decoded models are immutable and their inherited geometry is shared.
ModelLibrary :: struct {
    models: BTreeMap<string,
    missing: ^CuboidModel,
    assets: Maybe(^dyn AssetReader),
    // Keyed by obj and mtl override; `None` is a file that failed, already warned about.
    objs: Mutex<BTreeMap<(string,
}
// What a model's loader adds to its own elements.
ResolvedLoader :: enum {
    // The shown children, resolved on their own, in order.
    Composite(Vec<ResolvedCuboidModel>),
    Obj {,
        // `None` when the file failed to load.
    model: Option<Arc<ObjModel>>,
    flip_v: bool,
    shade: bool,
        // Objects the model chain's `visibility` hides.
    hidden: BTreeSet<String>,
    // rust: },
}
ResolvedCuboidModel :: struct {
    ambient_occlusion: bool,
    gui_light: GuiLight,
    display: ItemTransforms,
    textures: BTreeMap<string,
    // Cyclic and dangling aliases are absent from `textures`.
    unresolved_textures: BTreeSet<string>,
    // NeoForge's `render_type`; the leaf-most model that sets one wins.
    render_type: Maybe(string),
    geometry: Maybe(^CuboidModel),
    generated: bool,
    loader: Maybe(ResolvedLoader),
}
    // rust: impl ResolvedCuboidModel {
    // Geometry from a custom loader, baked after the elements.
loader :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.loader.as_ref()
}
    // Whether the top geometry is `builtin/generated`'s layer extrusion
    // (no model closer to the leaf has elements of its own).
uses_item_generator :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.generated
}
elements :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.geometry
    // rust: .as_ref()
    // rust: .and_then(|m| m.elements.as_deref())
    // rust: .unwrap_or(&[])
}
    // Native slot lookup strips a single leading '#'. Non-reference names
    // are still slot names, not direct sprite identifiers.
material :: proc(self: ^Self, slot: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if slot.is_empty() {
    // rust: return Err(error("empty texture lookup"));
}
    // rust: Ok(self.textures.get(slot.strip_prefix('#').unwrap_or(slot)))
}
}
    // rust: impl ModelLibrary {
    // A library that also knows `builtin/generated`, the parent of every
    // flat item model; the native client registers it as a special model.
with_item_generator :: proc(mut models: BTreeMap<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: models.insert(GENERATED_MODEL.to_owned(), Self::item_generator_model());
    // rust: Self::new(models)
}
    // Register the item built-in while reusing already decoded resources.
    // rust: pub fn with_shared_item_generator(
    // rust: mut models: BTreeMap<String, Arc<CuboidModel>>,
    // rust: ) -> Result<Self> {
    // rust: models.insert(
    // rust: GENERATED_MODEL.to_owned(),
    // rust: Arc::new(Self::item_generator_model()),
    // rust: );
    // rust: Self::from_shared(models)
}
item_generator_model :: proc() -> C {
    // Ported from Horizon
    return {}
}
    // rust: CuboidModel {
    // rust: parent: None,
    // rust: loader: None,
    // rust: ambient_occlusion: None,
    // rust: gui_light: Some(GuiLight::Front),
    // rust: textures: BTreeMap::from([(
    // rust: "particle".to_owned(),
    // rust: TextureSlot::Reference("layer0".to_owned()),
    // rust: )]),
    // rust: elements: None,
    // rust: display: None,
    // rust: render_type: None,
    // rust: visibility: BTreeMap::new(),
}
}
new :: proc(models: BTreeMap<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::from_models(
    // rust: models
    // rust: .into_iter()
    // rust: .map(|(name, model)| (name, Arc::new(model))),
    // rust: )
}
    // Build an immutable resolution view without copying model geometry.
from_shared :: proc(models: BTreeMap<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::from_models(models)
}
from_models :: proc(models: impl IntoIterator<Item = (string) {
}
    // rust: let mut decoded = BTreeMap::new();
    // rust: for (name, model) in models {
    // rust: if decoded.insert(identifier(&name)?, model).is_some() {
    // rust: return Err(error("duplicate normalized model identifier"));
}
}
    // rust: let missing = Arc::new(missing_model());
        // The native discovery registers this built-in before consulting resources.
    // rust: decoded.insert(MISSING_MODEL.to_owned(), missing.clone());
    // rust: Ok(Self {
    // rust: models: decoded,
    // rust: missing,
    // rust: assets: None,
    // rust: objs: Mutex::default(),
    // rust: })
}
    // Where `neoforge:obj` models find their files.
with_assets :: proc(assets: ^dyn AssetReader) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.assets = Some(assets);
    // rust: self
}
    // This library plus `extra` models; an `extra` model replaces a
    // same-named one, but not the built-in missing and generated models.
    // Every existing model is shared, not copied.
overlaid :: proc(self: ^Self, extra: BTreeMap<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut models = self.models.clone();
    // rust: let mut added = BTreeSet::new();
    // rust: for (name, model) in extra {
    // rust: let name = identifier(&name)?;
    // rust: if !added.insert(name.clone()) {
    // rust: return Err(error("duplicate normalized model identifier"));
}
            // The built-ins win, as `from_models` keeps `missing` and
            // `with_item_generator` keeps `generated`.
    // rust: if name != MISSING_MODEL && name != GENERATED_MODEL {
    // rust: models.insert(name, Arc::new(model));
}
}
    // rust: Ok(Self {
    // rust: models,
    // rust: missing: Arc::clone(&self.missing),
    // rust: assets: self.assets.clone(),
    // rust: objs: Mutex::default(),
    // rust: })
}
    // Follow the complete parent chain. A missing resource uses the built-in
    // model; a cyclic chain is rejected, as native discovery excludes it.
    // The returned model can outlive this library without copying its elements.
resolve :: proc(self: ^Self, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.resolve_name(name, None)
}
    // Whether `name` and every parent it reaches are models of this library,
    // with no cycle: `resolve` puts the missing model in for any other.
resolves :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(mut name) = identifier(name) else {
    // rust: return false;
}
    // rust: let mut visited = BTreeSet::new();
    // rust: loop {
    // rust: let Some(model) = self.models.get(&name) else {
    // rust: return false;
}
    // rust: if !visited.insert(name.clone()) {
    // rust: return false;
}
    // rust: match &model.parent {
    // rust: Some(parent) => name = parent.clone(),
    // rust: None => return true,
}
}
}
    // `name`'s resolved model with a virtual child in front of it that has
    // only `textures`: the child's slots win, and `#references` anywhere in
    // the chain re-bind through them (so `builtin/generated`'s
    // `particle: #layer0` follows a replaced `layer0`). The child's slots are
    // taken as given: sprites namespaced, references without their `#`, as
    // the JSON decoder leaves them. A cyclic chain is an
    // error, as for `resolve`: a caller wanting the missing model falls
    // back to it.
    // rust: pub fn resolve_with_textures(
    // rust: &self,
    // rust: name: &str,
    // rust: child: &BTreeMap<String, TextureSlot>,
    // rust: ) -> Result<ResolvedCuboidModel> {
    // rust: self.resolve_name(name, Some(child))
}
    // rust: fn resolve_name(
    // rust: &self,
    // rust: name: &str,
    // rust: child: Option<&BTreeMap<String, TextureSlot>>,
    // rust: ) -> Result<ResolvedCuboidModel> {
    // rust: let next = Some(identifier(name)?);
    // rust: self.resolve_chain(Vec::new(), Vec::new(), next, &BTreeMap::new(), child, 0)
}
    // `chain` and `names` start with models that are not in the library (a
    // composite child); `next` is the parent to follow. `fallback` slots lose
    // to any slot the chain defines.
    // rust: fn resolve_chain(
    // rust: &self,
    // rust: mut chain: Vec<Arc<CuboidModel>>,
    // rust: mut names: Vec<String>,
    // rust: mut next: Option<String>,
    // rust: fallback: &BTreeMap<String, TextureSlot>,
    // rust: child: Option<&BTreeMap<String, TextureSlot>>,
    // rust: depth: u8,
    // rust: ) -> Result<ResolvedCuboidModel> {
    // rust: if depth > MAX_LOADER_DEPTH {
    // rust: return Err(error("composite models nest too deeply"));
}
    // rust: let mut visited = BTreeSet::new();
    // rust: while let Some(name) = next.take() {
    // rust: if !visited.insert(name.clone()) {
    // rust: return Err(error("cyclic model parent"));
}
    // rust: let model = self.models.get(&name).unwrap_or(&self.missing);
    // rust: chain.push(Arc::clone(model));
    // rust: names.push(name);
    // rust: next = model.parent.clone();
}
    // rust: let ambient_occlusion = chain
    // rust: .iter()
    // rust: .find_map(|m| m.ambient_occlusion)
    // rust: .unwrap_or(true);
    // rust: let gui_light = chain
    // rust: .iter()
    // rust: .find_map(|m| m.gui_light)
    // rust: .unwrap_or(GuiLight::Side);
    // rust: let render_type = chain.iter().find_map(|m| m.render_type.clone());
    // rust: let geometry = chain.iter().find(|m| m.elements.is_some()).map(Arc::clone);
    // rust: let generated = chain
    // rust: .iter()
    // rust: .zip(&names)
    // rust: .find(|(m, name)| m.elements.is_some() || *name == GENERATED_MODEL)
    // rust: .is_some_and(|(_, name)| name == GENERATED_MODEL);
    // rust: let display = ItemTransforms {
    // rust: contexts: std::array::from_fn(|index| {
    // rust: chain
    // rust: .iter()
    // rust: .filter_map(|m| m.display.as_ref())
    // rust: .map(|d| &d.contexts[index])
    // rust: .find(|t| **t != DisplayTransform::Inherit)
    // rust: .cloned()
    // rust: .unwrap_or(DisplayTransform::Inherit)
    // rust: }),
}
        // Resolve aliases only after applying every child override. A reference
        // inherited from a parent binds to the child's final slot definition.
    // rust: let mut slots: BTreeMap<String, &TextureSlot> =
    // rust: fallback.iter().map(|(k, v)| (k.clone(), v)).collect();
    // rust: for model in chain.iter().rev() {
    // rust: slots.extend(model.textures.iter().map(|(k, v)| (k.clone(), v)));
}
    // rust: if let Some(child) = child {
    // rust: slots.extend(child.iter().map(|(k, v)| (k.clone(), v)));
}
    // rust: let loader = match chain.iter().find_map(|m| m.loader.as_ref()) {
    // rust: Some(Loader::Composite {
    // rust: children,
    // rust: visibility,
    // rust: }) => {
    // rust: let inherited: BTreeMap<String, TextureSlot> = slots
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), (*v).clone()))
    // rust: .collect();
                // A model closer to the leaf overrides the loader's own map.
    // rust: let mut visibility = visibility.clone();
    // rust: for model in chain.iter().rev() {
    // rust: visibility.extend(model.visibility.iter().map(|(k, v)| (k.clone(), *v)));
}
    // rust: let mut resolved = Vec::new();
    // rust: for (child_name, child_model) in children {
    // rust: if visibility.get(child_name) == Some(&false) {
    // rust: continue;
}
    // rust: resolved.push(self.resolve_chain(
    // rust: vec![Arc::clone(child_model)],
    // rust: vec![format!("{}#{child_name}", names[0])],
    // rust: child_model.parent.clone(),
    // rust: &inherited,
    // rust: None,
    // rust: depth + 1,
    // rust: )?);
}
    // rust: Some(ResolvedLoader::Composite(resolved))
}
    // rust: Some(Loader::Obj {
    // rust: model,
    // rust: flip_v,
    // rust: shade_quads,
    // rust: mtl_override,
    // rust: }) => {
                // Leaf wins: a model closer to the leaf overrides its parents' entries.
    // rust: let mut visibility = BTreeMap::new();
    // rust: for model in chain.iter().rev() {
    // rust: visibility.extend(model.visibility.iter().map(|(k, v)| (k.clone(), *v)));
}
    // rust: Some(ResolvedLoader::Obj {
    // rust: model: self.load_obj(&names[0], model, mtl_override.as_deref()),
    // rust: flip_v: *flip_v,
    // rust: shade: shade_quads.unwrap_or(true),
    // rust: hidden: visibility
    // rust: .into_iter()
    // rust: .filter(|(_, shown)| !shown)
    // rust: .map(|(name, _)| name)
    // rust: .collect(),
    // rust: })
}
    // rust: Some(Loader::Unknown(_)) | None => None,
}
    // rust: let mut textures = BTreeMap::<String, Material>::new();
    // rust: let mut unresolved_textures = BTreeSet::<String>::new();
    // rust: for start in slots.keys() {
    // rust: let mut current = start.as_str();
    // rust: let mut seen = BTreeSet::new();
    // rust: let mut path = Vec::new();
    // rust: let material = loop {
    // rust: if let Some(material) = textures.get(current) {
    // rust: break Some(material.clone());
}
    // rust: if unresolved_textures.contains(current) || !seen.insert(current) {
    // rust: break None;
}
    // rust: let Some(slot) = slots.get(current) else {
    // rust: break None;
}
    // rust: path.push(current);
    // rust: match slot {
    // rust: TextureSlot::Reference(target) => current = target,
    // rust: TextureSlot::Material(material) => break Some(material.clone()),
}
}
            // Cache the entire walk, including failures, so long alias chains
            // and cycles are traversed once rather than once per referencing slot.
    // rust: match material {
    // rust: Some(material) => {
    // rust: for name in path {
    // rust: textures.insert(name.to_owned(), material.clone());
}
}
    // rust: None => {
    // rust: unresolved_textures.extend(path.into_iter().map(str::to_owned));
}
}
}
    // rust: Ok(ResolvedCuboidModel {
    // rust: ambient_occlusion,
    // rust: gui_light,
    // rust: display,
    // rust: textures,
    // rust: unresolved_textures,
    // rust: render_type,
    // rust: geometry,
    // rust: generated,
    // rust: loader,
    // rust: })
}
    // Parse an obj and its materials once; a failure warns once and yields no geometry.
load_obj :: proc(self: ^Self, label: string, model: string, mtl: Maybe(string)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let key = (model.to_owned(), mtl.map(str::to_owned));
    // rust: let mut cache = self.objs.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some(found) = cache.get(&key) {
    // rust: return found.clone();
}
    // rust: let loaded = self.read_obj(model, mtl);
    // rust: if let Err(message) = &loaded {
    // rust: log::warn!("Horizon: obj model {label} ({model}): {message}");
}
    // rust: let loaded = loaded.ok().map(Arc::new);
    // rust: cache.insert(key, loaded.clone());
    // rust: loaded
}
read_obj :: proc(self: ^Self, model: string, mtl: Maybe(string)) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let assets = self.assets.as_ref().ok_or("no asset source")?;
    // rust: let text = assets.read_text(model).ok_or("file not found")?;
    // rust: let parsed = parse_obj(&text)?;
    // rust: let mtl = match (mtl, &parsed.mtllib) {
    // rust: (Some(location), _) => Some(location.to_owned()),
    // rust: (None, Some(file)) if file.contains(':') => Some(file.clone()),
    // rust: (None, Some(file)) => {
    // rust: let (namespace, path) = model.split_once(':').unwrap_or(("minecraft", model));
    // rust: let directory = path.rsplit_once('/').map_or("", |(dir, _)| dir);
    // rust: Some(if directory.is_empty() {
    // rust: format!("{namespace}:{file}")
    // rust: } else {
    // rust: format!("{namespace}:{directory}/{file}")
    // rust: })
}
    // rust: (None, None) => None,
}
    // rust: let materials = match mtl {
    // rust: Some(location) => match assets.read_text(&location) {
    // rust: Some(text) => parse_mtl(&text),
    // rust: None => {
    // rust: log::warn!("Horizon: obj material file {location} not found");
    // rust: BTreeMap::new()
}
    // rust: },
    // rust: None => BTreeMap::new(),
}
    // rust: Ok(ObjModel {
    // rust: faces: parsed.faces,
    // rust: materials,
    // rust: })
}
}
// The native missing-model cube uses slot names without a leading '#'.
missing_model :: proc() -> C {
    // Ported from Horizon
    return {}
}
    // rust: let faces = Direction::ALL
    // rust: .into_iter()
    // rust: .map(|direction| {
    // rust: (
    // rust: direction,
    // rust: Some(Face {
    // rust: cull: Some(direction),
    // rust: tint_index: -1,
    // rust: texture: "missingno".to_owned(),
    // rust: uv: Some([0.0, 0.0, 16.0, 16.0]),
    // rust: rotation: 0,
    // rust: light_emission: None,
    // rust: neoforge_data: None,
    // rust: }),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: CuboidModel {
    // rust: parent: None,
    // rust: loader: None,
    // rust: ambient_occlusion: None,
    // rust: gui_light: None,
    // rust: elements: Some(vec![Some(Element {
    // rust: from: [0.0; 3],
    // rust: to: [16.0; 3],
    // rust: faces,
    // rust: rotation: None,
    // rust: shade_direction_override: None,
    // rust: light_emission: 0,
    // rust: neoforge_data: None,
    // rust: })]),
    // rust: display: Some(ItemTransforms {
    // rust: contexts: std::array::from_fn(|_| DisplayTransform::Inherit),
    // rust: }),
    // rust: render_type: None,
    // rust: textures: BTreeMap::from([
    // rust: (
    // rust: "particle".to_owned(),
    // rust: TextureSlot::Reference("missingno".to_owned()),
    // rust: ),
    // rust: (
    // rust: "missingno".to_owned(),
    // rust: TextureSlot::Material(Material {
    // rust: sprite: "minecraft:missingno".to_owned(),
    // rust: force_translucent: false,
    // rust: }),
    // rust: ),
    // rust: ]),
    // rust: visibility: BTreeMap::new(),
}
}

    // rust: mod tests {
//     use super::*;
inherited_alias_uses_child_material_and_geometry_outlives_library :: proc() {
}
    // rust: let parent = CuboidModel::from_json(r##"{"textures":{"side":"#all","all":"block/stone"},"elements":[{"from":[0,0,0],"to":[16,8,16],"faces":{"up":{"texture":"#side"}}}]}"##).unwrap();
    // rust: let child = CuboidModel::from_json(r#"{"parent":"horizon:parent","textures":{"all":{"sprite":"block/glass","force_translucent":true}}}"#).unwrap();
    // rust: let library = ModelLibrary::new(BTreeMap::from([
    // rust: ("horizon:parent".into(), parent),
    // rust: ("horizon:child".into(), child),
    // rust: ]))
    // rust: .unwrap();
    // rust: let model = library.resolve("horizon:child").unwrap();
    // rust: drop(library);
    // rust: assert_eq!(model.elements()[0].as_ref().unwrap().to, [16.0, 8.0, 16.0]);
    // rust: assert_eq!(
    // rust: model.material("#side").unwrap().unwrap(),
    // rust: &Material {
    // rust: sprite: "minecraft:block/glass".into(),
    // rust: force_translucent: true
}
    // rust: );
}
library :: proc(models: ^[(string) {
}
    // rust: ModelLibrary::with_item_generator(
    // rust: models
    // rust: .iter()
    // rust: .map(|(name, json)| (name.to_string(), CuboidModel::from_json(json).unwrap()))
    // rust: .collect(),
    // rust: )
    // rust: .unwrap()
}
GENERATED :: r#"{"parent":"builtin/generated","display":{"ground":{"translation":[0,2,0],"scale":[0.5,0.5,0.5]}}}"#
CIT :: "horizon_cit:minecraft/optifine/cit/x"
child_textures_replace_slots_and_rebind_the_generated_particle :: proc() {
}
    // rust: let library = library(&[
    // rust: ("item/generated", GENERATED),
    // rust: (
    // rust: "item/stick",
    // rust: r#"{"parent":"item/generated","textures":{"layer0":"item/stick"}}"#,
    // rust: ),
    // rust: ]);
    // rust: let child = BTreeMap::from([(
    // rust: "layer0".to_owned(),
    // rust: TextureSlot::Material(Material {
    // rust: sprite: CIT.to_owned(),
    // rust: force_translucent: false,
    // rust: }),
    // rust: )]);
    // rust: let model = library.resolve_with_textures("item/stick", &child).unwrap();
    // rust: assert!(model.uses_item_generator());
    // rust: assert_eq!(model.material("layer0").unwrap().unwrap().sprite, CIT);
    // rust: assert_eq!(model.material("particle").unwrap().unwrap().sprite, CIT);
    // rust: assert_eq!(
    // rust: model.display.contexts[6],
    // rust: DisplayTransform::Explicit(Some(ItemTransform {
    // rust: rotation: [0.0; 3],
    // rust: translation: [0.0, 0.125, 0.0],
    // rust: scale: [0.5; 3],
    // rust: }))
    // rust: );
        // The library itself is untouched.
    // rust: let plain = library.resolve("item/stick").unwrap();
    // rust: assert_eq!(
    // rust: plain.material("particle").unwrap().unwrap().sprite,
    // rust: "minecraft:item/stick"
    // rust: );
}
overlaid_models_inherit_from_the_library_and_share_the_rest :: proc() {
}
    // rust: let base = library(&[
    // rust: ("item/generated", GENERATED),
    // rust: (
    // rust: "item/handheld",
    // rust: r#"{"parent":"item/generated","display":{"thirdperson_righthand":{"rotation":[0,-90,55]}}}"#,
    // rust: ),
    // rust: (
    // rust: "item/stick",
    // rust: r#"{"parent":"item/generated","textures":{"layer0":"item/stick"}}"#,
    // rust: ),
    // rust: (
    // rust: "item/apple",
    // rust: r#"{"parent":"item/generated","textures":{"layer0":"item/apple"}}"#,
    // rust: ),
    // rust: ]);
    // rust: let cit = format!(r#"{{"parent":"item/handheld","textures":{{"layer0":"{CIT}"}}}}"#);
    // rust: let over = base
    // rust: .overlaid(BTreeMap::from([
    // rust: (CIT.to_owned(), CuboidModel::from_json(&cit).unwrap()),
    // rust: (
    // rust: "item/stick".to_owned(),
    // rust: CuboidModel::from_json(
    // rust: r#"{"parent":"item/generated","textures":{"layer0":"item/bone"}}"#,
    // rust: )
    // rust: .unwrap(),
    // rust: ),
    // rust: ]))
    // rust: .unwrap();
    // rust: let model = over.resolve(CIT).unwrap();
    // rust: assert!(model.uses_item_generator());
    // rust: assert_eq!(model.material("particle").unwrap().unwrap().sprite, CIT);
    // rust: let DisplayTransform::Explicit(Some(right)) = &model.display.contexts[1] else {
    // rust: panic!("handheld's right-hand transform is inherited");
}
    // rust: assert_eq!(right.rotation, [0.0, -90.0, 55.0]);
    // rust: let sprite = |l: &ModelLibrary| {
    // rust: l.resolve("item/stick").unwrap().textures["layer0"]
    // rust: .sprite
    // rust: .clone()
}
    // rust: assert_eq!(sprite(&over), "minecraft:item/bone");
    // rust: assert_eq!(sprite(&base), "minecraft:item/stick");
    // rust: assert!(!base.resolve(CIT).unwrap().uses_item_generator());
    // rust: assert!(Arc::ptr_eq(
    // rust: &base.models["minecraft:item/apple"],
    // rust: &over.models["minecraft:item/apple"]
    // rust: ));
}
material :: proc(sprite: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: TextureSlot::Material(Material {
    // rust: sprite: sprite.to_owned(),
    // rust: force_translucent: false,
    // rust: })
}
child_slots_take_part_in_reference_chains :: proc() {
}
    // rust: let library = library(&[
    // rust: (
    // rust: "item/two",
    // rust: r##"{"textures":{"layer0":"#tex","layer1":"item/b","tex":"item/a"}}"##,
    // rust: ),
    // rust: ("horizon:loop", r#"{"parent":"horizon:loop2"}"#),
    // rust: ("horizon:loop2", r#"{"parent":"horizon:loop"}"#),
    // rust: ]);
    // rust: let child = BTreeMap::from([
            // A base alias binds through a slot only the child sets...
    // rust: ("tex".to_owned(), material(CIT)),
            // ...and a child alias through the base's slots.
    // rust: (
    // rust: "particle".to_owned(),
    // rust: TextureSlot::Reference("layer1".to_owned()),
    // rust: ),
            // A child alias to itself resolves to nothing, without looping.
    // rust: ("self".to_owned(), TextureSlot::Reference("self".to_owned())),
    // rust: ]);
    // rust: let model = library.resolve_with_textures("item/two", &child).unwrap();
    // rust: assert_eq!(model.material("layer0").unwrap().unwrap().sprite, CIT);
    // rust: assert_eq!(
    // rust: model.material("particle").unwrap().unwrap().sprite,
    // rust: "minecraft:item/b"
    // rust: );
    // rust: assert_eq!(model.material("self").unwrap(), None);
    // rust: assert!(model.unresolved_textures.contains("self"));
        // An absent base is the missing cube under the child; a cyclic one an error.
    // rust: let absent = library
    // rust: .resolve_with_textures("item/absent", &child)
    // rust: .unwrap();
    // rust: assert_eq!(absent.elements().len(), 1);
    // rust: assert!(
    // rust: library
    // rust: .resolve_with_textures("horizon:loop", &child)
    // rust: .is_err()
    // rust: );
}
an_overlay_replaces_parents_but_not_the_built_ins_and_refuses_twins :: proc() {
}
    // rust: let base = library(&[
    // rust: ("item/generated", GENERATED),
    // rust: ("item/handheld", r#"{"parent":"item/generated"}"#),
    // rust: (
    // rust: "item/sword",
    // rust: r#"{"parent":"item/handheld","textures":{"layer0":"item/sword"}}"#,
    // rust: ),
    // rust: ]);
    // rust: let model = |json: &str| CuboidModel::from_json(json).unwrap();
    // rust: let over = base
    // rust: .overlaid(BTreeMap::from([
    // rust: (
    // rust: "item/handheld".to_owned(),
    // rust: model(
    // rust: r#"{"parent":"item/generated","display":{"head":{"rotation":[0,45,0]}}}"#,
    // rust: ),
    // rust: ),
                // Neither built-in can be replaced.
    // rust: ("builtin/missing".to_owned(), model(r#"{"elements":[]}"#)),
    // rust: ("builtin/generated".to_owned(), model("{}")),
    // rust: ]))
    // rust: .unwrap();
        // The base's sword sees the overlay's parent; the base library does not.
    // rust: let head = |l: &ModelLibrary| l.resolve("item/sword").unwrap().display.contexts[4].clone();
    // rust: let DisplayTransform::Explicit(Some(rotated)) = head(&over) else {
    // rust: panic!("the replaced parent's head transform");
}
    // rust: assert_eq!(rotated.rotation, [0.0, 45.0, 0.0]);
    // rust: assert_ne!(head(&base), head(&over));
        // The generator kept: its `particle: #layer0`, which `{}` would drop.
    // rust: let sword = over.resolve("item/sword").unwrap();
    // rust: assert_eq!(
    // rust: sword.material("particle").unwrap().unwrap().sprite,
    // rust: "minecraft:item/sword"
    // rust: );
        // The missing cube kept, looked up by its own name, not as a fallback.
    // rust: let missing = over.resolve("builtin/missing").unwrap();
    // rust: assert_eq!(missing.elements().len(), 1);
        // Two spellings of one id.
    // rust: let twins = BTreeMap::from([
    // rust: ("item/x".to_owned(), model("{}")),
    // rust: ("minecraft:item/x".to_owned(), model("{}")),
    // rust: ]);
    // rust: assert!(base.overlaid(twins).is_err());
}
absent_parents_fall_back_but_cycles_invalidate_descendants :: proc() {
}
    // rust: let a = CuboidModel::from_json(r#"{"parent":"horizon:b"}"#).unwrap();
    // rust: let b = CuboidModel::from_json(r#"{"parent":"horizon:a"}"#).unwrap();
    // rust: let child = CuboidModel::from_json(r#"{"parent":"horizon:a","elements":[]}"#).unwrap();
    // rust: let library = ModelLibrary::new(BTreeMap::from([
    // rust: ("horizon:a".into(), a),
    // rust: ("horizon:b".into(), b),
    // rust: ("horizon:child".into(), child),
    // rust: ]))
    // rust: .unwrap();
    // rust: assert!(library.resolve("horizon:child").is_err());
    // rust: let absent = library.resolve("horizon:absent").unwrap();
    // rust: assert_eq!(absent.elements().len(), 1);
    // rust: assert_eq!(
    // rust: absent.material("particle").unwrap().unwrap().sprite,
    // rust: "minecraft:missingno"
    // rust: );
}
a_model_resolves_only_with_its_whole_parent_chain :: proc() {
}
    // rust: let library = library(&[
    // rust: ("item/generated", GENERATED),
    // rust: (
    // rust: "item/stick",
    // rust: r#"{"parent":"item/generated","textures":{"layer0":"item/stick"}}"#,
    // rust: ),
    // rust: ("item/orphan", r#"{"parent":"item/gone"}"#),
    // rust: ("item/a", r#"{"parent":"item/b"}"#),
    // rust: ("item/b", r#"{"parent":"item/a"}"#),
    // rust: ]);
    // rust: assert!(library.resolves("item/stick"));
    // rust: assert!(library.resolves("minecraft:item/stick"));
    // rust: assert!(!library.resolves("item/absent"));
    // rust: assert!(!library.resolves("item/orphan"));
    // rust: assert!(!library.resolves("item/a"));
    // rust: assert!(!library.resolves("Item/Stick"));
}
    // rust: const LIGHTS: &str = r##"{"textures":{"a":"block/a"},"render_type":"minecraft:cutout","elements":[
    // rust: {"from":[0,0,0],"to":[16,16,16],"light_emission":4,"neoforge_data":{"block_light":9,"color":-65536,"ambient_occlusion":false},
    // rust: "faces":{"north":{"texture":"#a","neoforge_data":{"block_light":2,"sky_light":15,"unknown":1}},
    // rust: "south":{"texture":"#a","light_emission":11},
    // rust: "up":{"texture":"#a"}}}]}"##;
neoforge_data_of_a_face_overrides_its_element_key_by_key :: proc() {
}
//         use crate::bake::bake_block_model;
    // rust: let library = library(&[("block/lights", LIGHTS)]);
    // rust: let model = library.resolve("block/lights").unwrap();
    // rust: let quads =
    // rust: bake_block_model(&model, crate::bake::BlockModelTransform::new([0; 3], false)).unwrap();
    // rust: let by = |d| quads.iter().find(|q| q.facing == d).unwrap();
    // rust: let north = by(Direction::North);
    // rust: assert_eq!(north.light, [4, 15]);
    // rust: assert_eq!(north.color, Some(-65536));
    // rust: assert_eq!(north.ambient_occlusion, Some(false));
    // rust: assert_eq!(by(Direction::South).light, [11, 11]);
    // rust: assert_eq!(by(Direction::South).light_emission, 11);
    // rust: assert_eq!(by(Direction::Up).light, [9, 4]);
    // rust: assert!(
    // rust: quads
    // rust: .iter()
    // rust: .all(|q| q.render_type == Some(crate::bake::RenderType::Cutout))
    // rust: );
}
vanilla_models_bake_without_extra_face_data :: proc() {
}
//         use crate::bake::bake_block_model;
    // rust: let library = library(&[(
    // rust: "block/plain",
    // rust: r##"{"textures":{"a":"block/a"},"elements":[{"from":[0,0,0],"to":[16,16,16],"light_emission":6,"faces":{"up":{"texture":"#a"}}}]}"##,
    // rust: )]);
    // rust: let model = library.resolve("block/plain").unwrap();
    // rust: let quad = &bake_block_model(&model, crate::bake::BlockModelTransform::new([0; 3], false))
    // rust: .unwrap()[0];
    // rust: assert_eq!((quad.light, quad.light_emission), ([6, 6], 6));
    // rust: assert_eq!(
    // rust: (quad.color, quad.ambient_occlusion, quad.render_type),
    // rust: (None, None, None)
    // rust: );
}
render_type_comes_from_the_leaf_most_model_and_loses_its_prefix :: proc() {
}
    // rust: let library = library(&[
    // rust: ("block/base", r#"{"render_type":"translucent"}"#),
    // rust: ("block/mid", r#"{"parent":"block/base"}"#),
    // rust: (
    // rust: "block/leaf",
    // rust: r#"{"parent":"block/mid","render_type":"minecraft:cutout_mipped"}"#,
    // rust: ),
    // rust: ("block/bare", r#"{"parent":"block/mid"}"#),
    // rust: ]);
    // rust: let render = |name| library.resolve(name).unwrap().render_type;
    // rust: assert_eq!(render("block/leaf").as_deref(), Some("cutout_mipped"));
    // rust: assert_eq!(render("block/bare").as_deref(), Some("translucent"));
    // rust: assert_eq!(render("block/absent"), None);
    // rust: assert_eq!(
    // rust: crate::bake::RenderType::by_name("minecraft:tripwire"),
    // rust: Some(crate::bake::RenderType::Tripwire)
    // rust: );
    // rust: assert_eq!(crate::bake::RenderType::by_name("mod:glow"), None);
}
neoforge_data_colour_and_legacy_emission_spellings :: proc() {
}
    // rust: let model = CuboidModel::from_json(
    // rust: r##"{"elements":[{"from":[0,0,0],"to":[1,1,1],"faces":{
    // rust: "up":{"texture":"#a","neoforge_data":{"color":"#80FF0000","light_emission":7}},
    // rust: "down":{"texture":"#a","neoforge_data":{"color":4294967295,"block_light":99}}}}]}"##,
    // rust: )
    // rust: .unwrap();
    // rust: let elements = model.elements.unwrap();
    // rust: let faces = &elements[0].as_ref().unwrap().faces;
    // rust: let up = faces[&Direction::Up]
    // rust: .as_ref()
    // rust: .unwrap()
    // rust: .neoforge_data
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: (up.color, up.block_light, up.sky_light),
    // rust: (Some(0x80FF0000u32 as i32), Some(7), Some(7))
    // rust: );
    // rust: let down = faces[&Direction::Down]
    // rust: .as_ref()
    // rust: .unwrap()
    // rust: .neoforge_data
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: (down.color, down.block_light, down.sky_light),
    // rust: (Some(-1), Some(15), None)
    // rust: );
}
}
