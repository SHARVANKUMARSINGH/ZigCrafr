//! Transpiled from Horizon Rust crate
package horizon_client_render_catalog

import "core:fmt"
import "core:mem"
import "core:math"

// Bind prepared registry states to model choices; bake each transformed model
// once and share its geometry across positions. Resource failure recovery and
// resource-pack reloads remain separate work.
// use crate::{Result, sprites::Sprites};
// use horizon_assets::{
    // rust: bake::{BlockModelTransform, ModelQuad, RenderType, bake_block_model},
    // rust: blockstate::{
    // rust: BlockStateDefinition, Variant, VariantSet,
    // rust: bind::{Properties, PropertySchema, PropertyValues, SelectedModels},
    // rust: choice::CompiledChoices,
    // rust: },
}
// use horizon_core::{
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, position_seed},
}
// use horizon_world::{
    // rust: chunk::BlockState,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: fs,
    // rust: path::Path,
}

BakedFace :: struct {
    quad: ModelQuad,
    layer: u32,
    // The texels under the quad's UVs are all opaque (`SpriteContents.computeTransparency`):
    // drawn in the solid layer without an alpha test.
    opaque: bool,
    // Fractional alpha: drawn in the sorted translucent pass.
    translucent: bool,
    // The Fusion connecting texture rule its sprite joins by ([`crate::fusion`]), plus one:
    // two bytes, within the padding every face already has.
    fusion: Maybe(std::num::NonZeroU16),
}
BakedModel :: struct {
    ambient_occlusion: bool,
    // The model's particle slot also exists for models without block faces.
    particle: Maybe(u32),
    faces: [dynamic]BakedFace,
    cube: Option<[super::cube::CubeStyle,
}
    // rust: type VariantKey = (String, [u8; 3], bool);
// Empty by default: no state has a model (a dedicated server, which draws
// nothing).
StateModels :: struct {
    // Each definition's choices, a variant standing as its index in `baked`.
    choices: [dynamic]CompiledChoices<u32>,
    // By state id: its definition in `choices` and the models it selects.
    states: Vec<Option<(uint,
    // Every transformed model once, with the variant it was baked from.
    baked: Vec<(Variant,
    // Standalone models by id: their index in `baked`.
    standalone: BTreeMap<string,
}
key :: proc(variant: ^Variant) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (variant.model.clone(), variant.rotations, variant.uv_lock)
}
// Bakes model `name` of `library`, turned and UV-locked as a variant says.
    // rust: fn bake_variant(
    // rust: root: &Path,
    // rust: sprites: &mut Sprites,
    // rust: library: &horizon_assets::resolve::ModelLibrary,
    // rust: name: &str,
    // rust: turns: [u8; 3],
    // rust: lock: bool,
    // rust: ) -> Result<BakedModel> {
    // rust: bake_resolved(root, sprites, &library.resolve(name)?, turns, lock)
}
// Bakes a resolved `model`, turned and UV-locked as a variant says.
    // rust: fn bake_resolved(
    // rust: root: &Path,
    // rust: sprites: &mut Sprites,
    // rust: model: &horizon_assets::resolve::ResolvedCuboidModel,
    // rust: turns: [u8; 3],
    // rust: lock: bool,
    // rust: ) -> Result<BakedModel> {
    // rust: let particle = model
    // rust: .material("particle")?
    // rust: .map(|material| sprites.insert(root, &material.sprite))
    // rust: .transpose()?;
    // rust: let faces: Vec<BakedFace> = bake_block_model(model, BlockModelTransform::new(turns, lock))?
    // rust: .into_iter()
    // rust: .map(|quad| {
    // rust: let layer = sprites.insert(root, &quad.material.sprite)?;
            // A model's `render_type` replaces the pass its sprite would pick.
    // rust: let (translucent, opaque) = match quad.render_type {
    // rust: Some(RenderType::Translucent | RenderType::Tripwire) => (true, false),
    // rust: Some(RenderType::Solid) => (false, true),
    // rust: Some(RenderType::Cutout | RenderType::CutoutMipped) => (false, false),
    // rust: None => (
    // rust: quad.material.force_translucent || sprites.translucent[layer as usize],
    // rust: sprites.region_opaque(layer, &quad.uv),
    // rust: ),
}
    // rust: Ok(BakedFace {
    // rust: translucent,
    // rust: opaque,
    // rust: quad,
    // rust: layer,
    // rust: fusion: None,
    // rust: })
    // rust: })
    // rust: .collect::<Result<_>>()?;
    // rust: let cube = super::cube::cube_styles(&faces);
    // rust: Ok(BakedModel {
    // rust: ambient_occlusion: model.ambient_occlusion,
    // rust: particle,
    // rust: faces,
    // rust: cube,
    // rust: })
}
// The definitions a blockstate file holds, bottom first: the layers of a
// file the pack overlay stacked (`packs::BLOCKSTATE_LAYERS`), else the
// file itself.
definition_layers :: proc(text: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: if !text.contains(crate::packs::BLOCKSTATE_LAYERS) {
    // rust: return Ok(vec![text.to_owned()]);
}
    // rust: let value: Value = serde_json::from_str(text).map_err(|e| e.to_string())?;
    // rust: match value.get(crate::packs::BLOCKSTATE_LAYERS) {
    // rust: Some(Value::Array(layers)) => Ok(layers.iter().map(Value::to_string).collect()),
    // rust: _ => Ok(vec![text.to_owned()]),
}
}
// Each state's model from definitions bound bottom first: the topmost one
// that binds the state, as (its layer, its selection). A higher pack's
// definition replaces only the states it binds (`putAll` in
// `loadBlockStateDefinitionStack`).
topmost :: proc(layers: [dynamic]Vec<Maybe(SelectedModels)>) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut picked: Vec<Option<(usize, SelectedModels)>> = Vec::new();
    // rust: for (layer, bound) in layers.into_iter().enumerate() {
    // rust: picked.resize(picked.len().max(bound.len()), None);
    // rust: for (slot, selected) in picked.iter_mut().zip(bound) {
    // rust: if let Some(selected) = selected {
    // rust: *slot = Some((layer, selected));
}
}
}
    // rust: picked
}
    // rust: impl StateModels {
    // rust: pub fn load(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: blocks: &[&str],
    // rust: sprites: &mut Sprites,
    // rust: ) -> Result<Self> {
    // rust: let facts: BTreeMap<String, Value> =
    // rust: serde_json::from_slice(&fs::read(root.join("model-states.json"))?)?;
    // rust: Self::from_facts(root, registry, blocks, sprites, &facts)
}
    // Bind and bake models using an already parsed model-state document.
    // rust: pub fn from_facts(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: blocks: &[&str],
    // rust: sprites: &mut Sprites,
    // rust: facts: &BTreeMap<String, Value>,
    // rust: ) -> Result<Self> {
    // rust: Self::from_facts_with_models(
    // rust: root,
    // rust: registry,
    // rust: blocks,
    // rust: sprites,
    // rust: facts,
    // rust: &crate::model_library::ParsedModels::default(),
    // rust: )
}
    // rust: pub(crate) fn from_facts_with_models(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: blocks: &[&str],
    // rust: sprites: &mut Sprites,
    // rust: facts: &BTreeMap<String, Value>,
    // rust: models: &crate::model_library::ParsedModels,
    // rust: ) -> Result<Self> {
    // rust: let mut choices = Vec::new();
    // rust: let mut states = vec![None; registry.len()];
    // rust: let mut variants = BTreeSet::new();
    // rust: let mut by_name: std::collections::HashMap<&str, Vec<BlockStateId>> =
    // rust: std::collections::HashMap::new();
    // rust: for i in 0..registry.len() {
    // rust: let id = BlockStateId(i as u32);
    // rust: if let Some(state) = registry.state(id) {
    // rust: by_name.entry(state.name.as_str()).or_default().push(id);
}
}
    // rust: for block in blocks.iter().copied().collect::<BTreeSet<_>>() {
            // Vanilla blocks come bare; content mods' blocks with their namespace.
    // rust: let (namespace, path) = block.split_once(':').unwrap_or(("minecraft", block));
    // rust: let name = format!("{namespace}:{path}");
    // rust: let facts = facts.get(&name).ok_or("missing block model state schema")?;
    // rust: let schema: PropertySchema = facts["schema"]
    // rust: .as_object()
    // rust: .ok_or("invalid model schema")?
    // rust: .iter()
    // rust: .map(|(key, value)| {
    // rust: let values = if let Some(range) = value.get("integer") {
    // rust: PropertyValues::Integer {
    // rust: minimum: i32::try_from(
    // rust: range[0]
    // rust: .as_i64()
    // rust: .ok_or("invalid integer property minimum")?,
    // rust: )?,
    // rust: maximum: i32::try_from(
    // rust: range[1]
    // rust: .as_i64()
    // rust: .ok_or("invalid integer property maximum")?,
    // rust: )?,
}
    // rust: } else {
    // rust: PropertyValues::Named(
    // rust: value["named"]
    // rust: .as_array()
    // rust: .ok_or("missing named property values")?
    // rust: .iter()
    // rust: .map(|v| {
    // rust: v.as_str()
    // rust: .map(str::to_owned)
    // rust: .ok_or("invalid named property value")
    // rust: })
    // rust: .collect::<std::result::Result<_, _>>()?,
    // rust: )
}
    // rust: Ok((key.clone(), values))
    // rust: })
    // rust: .collect::<Result<_>>()?;
    // rust: let possible: Vec<Properties> = serde_json::from_value(facts["states"].clone())?;
            // Vanilla's BlockStateModelLoader: a definition that does not
            // read or bind is logged and left out; with none left the block
            // gets no model, and the other blocks still load. A file several
            // packs provide binds each pack's definition on its own, bottom
            // first (`loadBlockStateDefinitionStack`).
    // rust: let layers = match horizon_core::prepared_files::read_to_string(
    // rust: &root.join(format!("assets/{namespace}/blockstates/{path}.json")),
    // rust: )
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|text| definition_layers(&text))
    // rust: {
    // rust: Ok(layers) => layers,
    // rust: Err(e) => {
    // rust: log::warn!(
    // rust: "Horizon: blockstate definition of {namespace}:{path} not loaded: {e}"
    // rust: );
    // rust: continue;
}
}
    // rust: let mut loaded = Vec::with_capacity(layers.len());
    // rust: for text in &layers {
    // rust: let layer = BlockStateDefinition::from_json(text)
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|definition| {
    // rust: let bound = definition
    // rust: .bind(&schema, &possible)
    // rust: .map_err(|e| e.to_string())?;
    // rust: Ok((definition, bound))
    // rust: });
    // rust: match layer {
    // rust: Ok(layer) => loaded.push(layer),
    // rust: Err(e) => log::warn!(
    // rust: "Horizon: blockstate definition of {namespace}:{path} not loaded: {e}"
    // rust: ),
}
}
    // rust: if loaded.is_empty() {
    // rust: continue;
}
    // rust: let native_order: Vec<_> = by_name
    // rust: .get(name.as_str())
    // rust: .map(Vec::as_slice)
    // rust: .unwrap_or_default()
    // rust: .iter()
    // rust: .map(|&id| (id, &registry.state(id).expect("indexed state").properties))
    // rust: .collect();
    // rust: if native_order.len() != possible.len()
    // rust: || native_order
    // rust: .iter()
    // rust: .zip(&possible)
    // rust: .any(|((_, a), b)| *a != b)
    // rust: {
    // rust: return Err(
    // rust: "model state definitions disagree with the imported block registry".into(),
    // rust: );
}
    // rust: let (definitions, bound): (Vec<_>, Vec<_>) = loaded.into_iter().unzip();
    // rust: let first = choices.len();
    // rust: for ((id, _), picked) in native_order.into_iter().zip(topmost(bound)) {
    // rust: if let Some((layer, selected)) = picked {
    // rust: states[id.0 as usize] = Some((first + layer, selected));
}
}
    // rust: for definition in definitions {
    // rust: for choice in definition
    // rust: .variants
    // rust: .iter()
    // rust: .flatten()
    // rust: .map(|(_, choice)| choice)
    // rust: .chain(
    // rust: definition
    // rust: .multipart
    // rust: .iter()
    // rust: .flatten()
    // rust: .map(|selector| &selector.variant),
    // rust: )
    // rust: {
    // rust: match choice {
    // rust: VariantSet::Single(v) => {
    // rust: variants.insert(key(v));
}
    // rust: VariantSet::Weighted(v) => variants.extend(v.iter().map(|(v, _)| key(v))),
}
}
    // rust: choices.push(CompiledChoices::new(&definition)?);
}
}
    // rust: let names: Vec<String> = variants.iter().map(|(name, _, _)| name.clone()).collect();
    // rust: let library = match models.block_library(root, names.clone()) {
    // rust: Ok(library) => library,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: block models incomplete ({e}); using the missing model");
    // rust: models.block_library_or_missing(root, names)?
}
}
    // rust: let resolved: Vec<_> = variants
    // rust: .iter()
    // rust: .map(|(name, ..)| library.resolve(name))
    // rust: .collect();
        // Every texture the models name, decoded side by side before the bake adds them one
        // by one in its own order.
    // rust: sprites.prefetch(
    // rust: root,
    // rust: resolved
    // rust: .iter()
    // rust: .flatten()
    // rust: .flat_map(|model| model.textures.values())
    // rust: .map(|material| material.sprite.as_str()),
    // rust: );
    // rust: let mut baked = Vec::with_capacity(variants.len());
    // rust: let mut index = BTreeMap::new();
    // rust: for ((name, turns, lock), model) in variants.into_iter().zip(resolved) {
    // rust: let model = bake_resolved(root, sprites, &model?, turns, lock)?;
    // rust: index.insert((name.clone(), turns, lock), baked.len() as u32);
    // rust: let variant = Variant {
    // rust: model: name,
    // rust: rotations: turns,
    // rust: uv_lock: lock,
}
    // rust: baked.push((variant, model));
}
        // Every variant of every definition was baked above.
    // rust: let choices = choices.iter().map(|c| c.map(|v| index[&key(v)])).collect();
    // rust: Ok(Self {
    // rust: choices,
    // rust: states,
    // rust: baked,
    // rust: standalone: BTreeMap::new(),
    // rust: })
}
    // Bakes `names`, models no blockstate needs to name (vanilla's
    // standalone models, NeoForge's `ModelEvent.RegisterStandalone`), as
    // they are, unturned, for [`Self::standalone`]. One a block state
    // already bakes unturned is shared. A model that doesn't read (missing,
    // or a parent missing) is logged and left out, as a missing blockstate
    // is; the others still bake.
    // rust: pub(crate) fn bake_standalone(
    // rust: &mut self,
    // rust: root: &Path,
    // rust: sprites: &mut Sprites,
    // rust: models: &crate::model_library::ParsedModels,
    // rust: names: &[String],
    // rust: ) -> Result<()> {
    // rust: for name in names {
    // rust: if self.standalone.contains_key(name) {
    // rust: continue;
}
    // rust: if let Some(i) = self
    // rust: .baked
    // rust: .iter()
    // rust: .position(|(v, _)| v.model == *name && v.rotations == [0; 3] && !v.uv_lock)
    // rust: {
    // rust: self.standalone.insert(name.clone(), i as u32);
    // rust: continue;
}
    // rust: let model = models
    // rust: .block_library(root, vec![name.clone()])
    // rust: .and_then(|library| bake_variant(root, sprites, &library, name, [0; 3], false));
    // rust: match model {
    // rust: Ok(model) => {
    // rust: self.standalone
    // rust: .insert(name.clone(), self.baked.len() as u32);
    // rust: let variant = Variant {
    // rust: model: name.clone(),
    // rust: rotations: [0; 3],
    // rust: uv_lock: false,
}
    // rust: self.baked.push((variant, model));
}
    // rust: Err(e) => log::warn!("Horizon: standalone model {name} not loaded: {e}"),
}
}
    // rust: Ok(())
}
    // Every baked model with the variant it was baked from, to change its faces.
models_mut :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.baked
    // rust: .iter_mut()
    // rust: .map(|(variant, model)| (&*variant, model))
}
    // A model baked by [`Self::bake_standalone`], by id (`mymod:block/shaft_half`).
standalone :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let &i = self.standalone.get(name)?;
    // rust: Some(&self.baked[i as usize].1)
}
    // rust: pub fn collect(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: position: BlockPos,
    // rust: ) -> Result<Vec<(&Variant, &BakedModel)>> {
        // Blocks use their position seed; contained/displayed blocks can supply one.
    // rust: self.collect_seeded(state, position_seed(position))
}
    // `BlockStateModel.particleMaterial`: the particle sprite layer of the
    // state's first variant (see `CompiledChoices::particle_variant`).
particle :: proc(self: ^Self, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (choice, selected) = self.state(state)?;
    // rust: let model = self.choices[*choice].particle_variant(selected)?;
    // rust: self.baked[*model as usize].1.particle
}
    // rust: pub fn collect_seeded(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: seed: i64,
    // rust: ) -> Result<Vec<(&Variant, &BakedModel)>> {
    // rust: let mut models = Vec::new();
    // rust: self.each_seeded(state, seed, |(variant, model)| {
    // rust: models.push((variant, model))
    // rust: })?;
    // rust: Ok(models)
}
    // The models a block draws at `position`, into `out` (cleared first):
    // `collect` for the mesher, which reuses one list for every block.
    // rust: pub fn models_at<'a>(
    // rust: &'a self,
    // rust: state: BlockStateId,
    // rust: position: BlockPos,
    // rust: out: &mut Vec<&'a BakedModel>,
    // rust: ) -> Result<()> {
    // rust: out.clear();
    // rust: self.each_seeded(state, position_seed(position), |(_, model)| out.push(model))
}
    // rust: fn each_seeded<'a>(
    // rust: &'a self,
    // rust: state: BlockStateId,
    // rust: seed: i64,
    // rust: mut f: impl FnMut(&'a (Variant, BakedModel)),
    // rust: ) -> Result<()> {
    // rust: let (choice, selected) = self.state(state).ok_or("unbound gallery block state")?;
    // rust: let mut random = LegacyRandom::new(seed);
    // rust: self.choices[*choice].for_each(selected, &mut random, |&model| {
    // rust: f(&self.baked[model as usize]);
    // rust: })?;
    // rust: Ok(())
}
state :: proc(self: ^Self, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.states.get(state.0 as usize)?.as_ref()
}
}

descriptor :: proc(name: string, overrides: ^[(string) {
}
    // rust: BlockState {
    // rust: name: format!("minecraft:{name}"),
    // rust: properties: overrides
    // rust: .iter()
    // rust: .map(|(k, v)| ((*k).to_owned(), (*v).to_owned()))
    // rust: .collect(),
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::model_library::ParsedModels;

    // #7013: a pack's blockstate file that defines only some states (here
    // a fence gate's `powered=true` ones) keeps vanilla's model for the
    // rest, as vanilla binds each pack's definition and lets a higher one
    // replace only what it binds.
a_partial_pack_blockstate_keeps_vanilla_for_the_other_states :: proc() {
}
    // rust: let schema: PropertySchema = BTreeMap::from([(
    // rust: "powered".to_owned(),
    // rust: PropertyValues::Named(BTreeSet::from(["false".to_owned(), "true".to_owned()])),
    // rust: )]);
    // rust: let states: Vec<Properties> = ["false", "true"]
    // rust: .iter()
    // rust: .map(|p| BTreeMap::from([("powered".to_owned(), (*p).to_owned())]))
    // rust: .collect();
    // rust: let stacked = serde_json::json!({ crate::packs::BLOCKSTATE_LAYERS: [
    // rust: {"variants":{"":{"model":"minecraft:block/oak_fence_gate"}}},
    // rust: {"variants":{"powered=true":{"model":"minecraft:block/stone"}}}
    // rust: ]})
    // rust: .to_string();
    // rust: let layers = definition_layers(&stacked).unwrap();
    // rust: assert_eq!(layers.len(), 2);
    // rust: let bound = layers
    // rust: .iter()
    // rust: .map(|text| {
    // rust: BlockStateDefinition::from_json(text)
    // rust: .unwrap()
    // rust: .bind(&schema, &states)
    // rust: .unwrap()
    // rust: })
    // rust: .collect();
    // rust: let picked = topmost(bound);
    // rust: assert_eq!(picked[0], Some((0, SelectedModels::Variant(0))));
    // rust: assert_eq!(picked[1], Some((1, SelectedModels::Variant(0))));
        // A file that isn't stacked is one definition.
    // rust: let plain = r#"{"variants":{"":{"model":"minecraft:block/stone"}}}"#;
    // rust: assert_eq!(definition_layers(plain).unwrap(), vec![plain.to_owned()]);
}

Fixture :: struct {
    // rust: impl Fixture {
write :: proc(self: ^Self, name: string, json: string) {
}
    // rust: let (namespace, path) = name.split_once(':').unwrap();
    // rust: let path = self
    // rust: .0
    // rust: .join(format!("assets/{namespace}/models/{path}.json"));
    fs: :create_dir_all(path.parent().unwrap()).unwrap(),
    fs: :write(path,
}
}
    // rust: impl Drop for Fixture {
drop :: proc(self: ^Self) {
}
    // rust: let _ = fs::remove_dir_all(&self.0);
}
}

standalone_models_bake_once_and_skip_what_does_not_read :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let fixture = Fixture(
    // rust: std::env::temp_dir().join(format!("horizon-standalone-{}", std::process::id())),
    // rust: );
        // A half shaft: one element, two faces; a child with its parent's elements.
    // rust: fixture.write(
    // rust: "lanef:block/shaft_half",
    // rust: r##"{"textures":{"side":"lanef:block/shaft"},"elements":[{"from":[6,6,0],"to":[10,10,8],"faces":{"north":{"texture":"#side"},"up":{"texture":"#side"}}}]}"##,
    // rust: );
    // rust: fixture.write(
    // rust: "lanef:block/cog",
    // rust: r#"{"parent":"lanef:block/shaft_half","textures":{"side":"lanef:block/cog"}}"#,
    // rust: );
    // rust: fixture.write("lanef:block/orphan", r#"{"parent":"lanef:block/absent"}"#);
    // rust: let mut models = StateModels::default();
    // rust: let mut sprites = Sprites::default();
    // rust: let names: Vec<String> = [
    // rust: "lanef:block/shaft_half",
    // rust: "lanef:block/cog",
    // rust: "lanef:block/orphan",
    // rust: "lanef:block/absent",
    // rust: "lanef:block/shaft_half",
    // rust: ]
    // rust: .map(str::to_owned)
    // rust: .into();
    // rust: let parsed = ParsedModels::load(&fixture.0);
    // rust: models.bake_standalone(&fixture.0, &mut sprites, &parsed, &names)?;
    // rust: let shaft = models.standalone("lanef:block/shaft_half").expect("baked");
    // rust: assert_eq!(shaft.faces.len(), 2);
    // rust: let cog = models.standalone("lanef:block/cog").expect("baked");
    // rust: assert_eq!(cog.faces.len(), 2);
    // rust: assert_ne!(cog.faces[0].layer, shaft.faces[0].layer, "its own texture");
    // rust: assert!(models.standalone("lanef:block/orphan").is_none());
    // rust: assert!(models.standalone("lanef:block/absent").is_none());
    // rust: assert!(models.standalone("lanef:block/unnamed").is_none());
        // Named twice, baked once.
    // rust: assert_eq!(models.baked.len(), 2);
        // Without a parsed library, the files are read directly.
    // rust: let mut direct = StateModels::default();
    // rust: direct.bake_standalone(&fixture.0, &mut sprites, &ParsedModels::default(), &names)?;
    // rust: assert_eq!(
    // rust: direct.standalone("lanef:block/cog").map(|m| m.faces.len()),
    // rust: Some(2)
    // rust: );
    // rust: Ok(())
}

a_standalone_model_a_state_bakes_unturned_is_shared :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut models = StateModels::default();
    // rust: let variant = |rotations| Variant {
    // rust: model: "lanef:block/shared".into(),
    // rust: rotations,
    // rust: uv_lock: false,
}
    // rust: let empty = || BakedModel {
    // rust: ambient_occlusion: true,
    // rust: particle: None,
    // rust: faces: Vec::new(),
    // rust: cube: None,
}
    // rust: models.baked.push((variant([0, 90, 0]), empty()));
    // rust: models.baked.push((variant([0; 3]), empty()));
    // rust: let names = vec!["lanef:block/shared".to_owned()];
    // rust: let root = std::env::temp_dir().join("horizon-standalone-none");
    // rust: models.bake_standalone(
    // rust: &root,
    // rust: &mut Sprites::default(),
    // rust: &ParsedModels::default(),
    // rust: &names,
    // rust: )?;
    // rust: assert_eq!(models.baked.len(), 2);
    // rust: assert_eq!(models.standalone.get("lanef:block/shared"), Some(&1));
    // rust: Ok(())
}
}
