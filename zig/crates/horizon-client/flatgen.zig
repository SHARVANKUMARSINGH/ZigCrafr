//! Transpiled from Horizon Rust crate
//! Module: horizon-client_flatgen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! FlatLevelSource: superflat worlds (`minecraft:flat` generator).
// use crate::{
    // rust: chunk::{Chunk, LevelShape},
    // rust: streaming::ChunkGenerator,
}
// use horizon_world::{
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId},
    // rust: worldgen::feature::{BasicFeature, FeatureBlocks, FeatureWorld},
}

/// The layers of a flat generator, bottom up from the world's minimum Y.
pub const FlatTerrain = struct {
    /// The Overworld's shape: the layers start at its minimum Y and stop at
    /// its top.
    shape: LevelShape,
    layers: std.ArrayList(u32),
    biome: u16,
    surface: ?crate::lod::Surface,
    /// The blocks of `minecraft:void_start_platform`, when the adjusted
    /// generation settings place it (the Void preset).
    void_platform: ?FeatureBlocks,
};
/// `GenerationStep.Decoration` ordinals `adjustGenerationSettings` leaves out.
pub const LAKES: usize = 1;
pub const UNDERGROUND_STRUCTURES: usize = 3;
pub const SURFACE_STRUCTURES: usize = 4;
/// FlatLevelGeneratorSettings.adjustGenerationSettings for the world's own
/// biome: its placed features, by step, when `features` is on and the world
/// isn't only air (`voidGen`) or its biome is the_void. The structure steps
/// are left out, and the lakes step when `lakes` puts the lava lakes there.
    // rust: fn decoration_features(
    // rust: biome_features: &[Vec<String>],
    // rust: features: bool,
    // rust: lakes: bool,
    // rust: void_gen: bool,
    // rust: the_void: bool,
    // rust: ) -> impl Iterator<Item = &str> {
    // rust: let decorate = (!void_gen || the_void) && features;
    // rust: biome_features
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(move |&(step, _)| {
    // rust: decorate
    // rust: && step != UNDERGROUND_STRUCTURES
    // rust: && step != SURFACE_STRUCTURES
    // rust: && !(lakes && step == LAKES)
    // rust: })
    // rust: .flat_map(|(_, step)| step.iter().map(String::as_str))
}
/// The proto chunk as the world a feature writes in.
pub const ChunkWorld = struct {};
    // rust: impl FeatureWorld for ChunkWorld<'_> {
    // rust: type Error = std::convert::Infallible;
pub fn block(self: *Self, z]: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.0.block(x, y, z))
}
    // rust: fn set_block(
    // rust: &mut self,
    // rust: [x, y, z]: [i32; 3],
    // rust: state: BlockStateId,
    // rust: _: i32,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: self.0.set(x, y, z, state.0);
    // rust: Ok(true)
}
}
    // rust: impl FlatTerrain {
    /// The overworld generator of `world_gen_settings` (`data.dimensions`), if it
    /// is flat. Its layers, as FlatLevelSource places them, and of the features
    /// its settings decorate the world with, `void_start_platform`. A world that
    /// places other features or lakes runs on the pipeline instead
    /// ([`Self::pipeline_settings`]).
    // rust: pub fn from_settings(
    // rust: settings: &Tag,
    // rust: registry: &BlockRegistry,
    // rust: biomes: &crate::biome::Biomes,
    // rust: shape: LevelShape,
    // rust: ) -> Option<Self> {
    // rust: let generator = settings
    // rust: .get("dimensions")?
    // rust: .get("minecraft:overworld")?
    // rust: .get("generator")?;
    // rust: if crate::save::text(generator.get("type"))?.trim_start_matches("minecraft:") != "flat" {
    // rust: return None;
}
    // rust: let s = generator.get("settings")?;
    // rust: let biome = crate::save::text(s.get("biome")).unwrap_or_else(|| "minecraft:plains".into());
    // rust: let mut layers = Vec::new();
    // rust: if let Some(Tag::List(list)) = s.get("layers") {
    // rust: for layer in list {
    // rust: let block = crate::save::text(layer.get("block"))?;
    // rust: let height = crate::save::number(layer.get("height")).unwrap_or(0).max(0);
    // rust: let state = registry.default_state(&block)?.0;
    // rust: layers.extend(std::iter::repeat_n(state, height as usize));
}
}
    // rust: let biome = biomes.id(&biome);
        // FlatLevelGeneratorSettings.updateLayers: every layer is Blocks.AIR.
    // rust: let void_gen = layers.iter().all(|&id| {
    // rust: registry
    // rust: .state(BlockStateId(id))
    // rust: .is_some_and(|s| s.name == "minecraft:air")
    // rust: });
    // rust: let flag = |key| crate::save::number(s.get(key)).is_some_and(|v| v != 0);
    // rust: let info = biomes.get(biome);
    // rust: let void_platform = if decoration_features(
    // rust: &info.features,
    // rust: flag("features"),
    // rust: flag("lakes"),
    // rust: void_gen,
    // rust: info.name == "minecraft:the_void",
    // rust: )
    // rust: .any(|f| f == "minecraft:void_start_platform")
    // rust: {
    // rust: FeatureBlocks::from_registry(registry)
    // rust: .inspect_err(|e| log::warn!("Horizon: no void_start_platform: {e}"))
    // rust: .ok()
    // rust: } else {
    // rust: None
}
    // rust: let mut water = None;
    // rust: let mut surface = None;
    // rust: for (i, &id) in layers.iter().take(shape.height as usize).enumerate().rev() {
    // rust: let state = horizon_world::registry::BlockStateId(id);
    // rust: let name = registry.state(state)?.name.as_str();
    // rust: if matches!(
    // rust: name,
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: ) {
    // rust: continue;
}
    // rust: let height = shape.min_y + i as i32 + 1;
    // rust: if matches!(name, "minecraft:water" | "minecraft:lava") {
    // rust: water.get_or_insert((height, state));
    // rust: } else {
    // rust: surface = Some(crate::lod::Surface {
    // rust: height,
    // rust: state,
    // rust: water,
    // rust: biome,
    // rust: });
    // rust: break;
}
}
    // rust: Some(Self {
    // rust: shape,
    // rust: layers,
    // rust: biome,
    // rust: surface,
    // rust: void_platform,
    // rust: })
}
    /// The settings of a superflat overworld that runs on the structure and feature
    /// pipeline (`FlatLevelSource`): one that lets structure sets generate
    /// (`createState`: no `structure_overrides` key means every set, `[]` none) or
    /// that decorates (`features` or `lakes`, `adjustGenerationSettings`). `None` for a
    /// world with neither, the Void preset's biome (its platform is a feature this
    /// generator places) or one that is not superflat.
    // rust: pub fn pipeline_settings(
    // rust: settings: &Tag,
    // rust: ) -> Option<horizon_world::worldgen::generator::FlatSettings> {
    // rust: let generator = settings
    // rust: .get("dimensions")?
    // rust: .get("minecraft:overworld")?
    // rust: .get("generator")?;
    // rust: if crate::save::text(generator.get("type"))?.trim_start_matches("minecraft:") != "flat" {
    // rust: return None;
}
    // rust: let s = generator.get("settings")?;
    // rust: let biome = crate::save::text(s.get("biome")).unwrap_or_else(|| "minecraft:plains".into());
    // rust: if biome == "minecraft:the_void" {
    // rust: return None;
}
    // rust: let mut layers = Vec::new();
    // rust: if let Some(Tag::List(list)) = s.get("layers") {
    // rust: for layer in list {
    // rust: let block = crate::save::text(layer.get("block"))?;
    // rust: let height = crate::save::number(layer.get("height")).unwrap_or(0).max(0) as i32;
    // rust: layers.push((block, height));
}
}
    // rust: let structure_overrides = match s.get("structure_overrides") {
    // rust: Some(Tag::List(sets)) => Some(
    // rust: sets.iter()
    // rust: .filter_map(|set| crate::save::text(Some(set)))
    // rust: .collect::<Vec<_>>(),
    // rust: ),
    // rust: Some(Tag::String(set)) => Some(vec![set.to_string_lossy()]),
    // rust: _ => None,
}
    // rust: let flag = |key| crate::save::number(s.get(key)).is_some_and(|v| v != 0);
    // rust: let decorates = flag("features") || flag("lakes");
    // rust: if structure_overrides.as_ref().is_some_and(Vec::is_empty) && !decorates {
    // rust: return None;
}
    // rust: Some(horizon_world::worldgen::generator::FlatSettings {
    // rust: layers,
    // rust: biome,
    // rust: structure_overrides,
    // rust: features: flag("features"),
    // rust: lakes: flag("lakes"),
    // rust: })
}
    /// FlatLevelSource.getSpawnHeight: the top of the layers.
pub fn spawn_height(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shape.min_y + self.layers.len().min(self.shape.height as usize) as i32
}
}
/// DimensionType.Y_SIZE: the most layers FlatLevelGeneratorSettings takes.
pub const Y_SIZE: i64 = 4064;

/// FlatLevelGeneratorSettings.CODEC reading a dedicated server's
/// `generator-settings` (DedicatedServerProperties.WorldDimensionData for
/// the `minecraft:flat` preset): the settings as `world_gen_settings` stores
/// them, and the errors vanilla logs, in order (the constructor's, then
/// `resultOrPartial`'s). No settings means the preset's own layers; a layer
/// that doesn't parse is left out, as the codec's partial result leaves it.
/// `is_block` says whether a block id is registered, `is_biome` a biome id.
    // rust: pub fn settings_from_json(
    // rust: json: &crate::server::json::Json,
    // rust: is_block: impl Fn(&str) -> bool,
    // rust: is_biome: impl Fn(&str) -> bool,
    // rust: ) -> (Option<Tag>, Vec<String>) {
//     use crate::server::json::Json;
    // rust: let id = |s: &str| {
    // rust: if s.contains(':') {
    // rust: s.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{s}")
}
}
    // rust: let Some(Json::Array(list)) = json.get("layers") else {
    // rust: let error = match json.get("layers") {
    // rust: None => format!("No key layers in MapLike[{}]", json.compact()),
    // rust: Some(v) => format!("Not a list: {}", v.compact()),
}
    // rust: return (None, vec![error]);
}
    // rust: let mut errors = Vec::new();
    // rust: let mut layers = Vec::new();
    // rust: let mut total = 0;
    // rust: for layer in list {
    // rust: let height = layer.get("height").and_then(Json::as_string);
    // rust: let height = height.as_deref().and_then(|h| h.parse::<i64>().ok());
    // rust: let block = layer.get("block").and_then(Json::as_string).map(|b| id(&b));
    // rust: match (height, block) {
    // rust: (Some(h), _) if !(0..=Y_SIZE).contains(&h) => {
    // rust: errors.push(format!("Value {h} outside of range [0:{Y_SIZE}]"));
}
    // rust: (Some(h), Some(b)) if is_block(&b) => {
    // rust: total += h;
    // rust: layers.push(Tag::compound([
    // rust: ("height", Tag::Int(h as i32)),
    // rust: ("block", Tag::String(b.as_str().into())),
    // rust: ]));
}
    // rust: (Some(_), Some(b)) => errors.push(format!(
    // rust: "Unknown registry key in ResourceKey[minecraft:root / minecraft:block]: {b}"
    // rust: )),
    // rust: (None, _) => errors.push(format!("No key height in MapLike[{}]", layer.compact())),
    // rust: (_, None) => errors.push(format!("No key block in MapLike[{}]", layer.compact())),
}
}
    // The constructor: Biome.CODEC is lenient, and a biome that is missing
    // or unknown is Plains.
    // rust: let biome = json
    // rust: .get("biome")
    // rust: .and_then(Json::as_string)
    // rust: .map(|b| id(&b))
    // rust: .filter(|b| is_biome(b));
    // rust: let mut logged = Vec::new();
    // rust: if biome.is_none() {
    // rust: logged.push("Unknown biome, defaulting to plains".to_owned());
}
    // rust: let biome = biome.unwrap_or_else(|| "minecraft:plains".to_owned());
    // validateHeight.
    // rust: if total > Y_SIZE {
    // rust: errors.push(format!("Sum of layer heights is > {Y_SIZE}"));
    // rust: logged.push(errors.join("; "));
    // rust: return (None, logged);
}
    // rust: let flag = |key: &str| match json.get(key) {
    // rust: Some(Json::Bool(b)) => *b,
    // rust: Some(Json::Number(n)) => n.parse::<f64>().is_ok_and(|v| v != 0.0),
    // rust: _ => false,
}
    // rust: let mut settings = Vec::new();
    // RegistryCodecs.holderSet, lenient too: a tag or a list of ids.
    // rust: match json.get("structure_overrides") {
    // rust: Some(Json::String(s)) => {
    // rust: settings.push(("structure_overrides", Tag::String(s.as_str().into())))
}
    // rust: Some(Json::Array(ids)) if ids.iter().all(|i| matches!(i, Json::String(_))) => settings
    // rust: .push((
    // rust: "structure_overrides",
    // rust: Tag::List(
    // rust: ids.iter()
    // rust: .filter_map(Json::as_string)
    // rust: .map(|i| Tag::String(id(&i).as_str().into()))
    // rust: .collect(),
    // rust: ),
    // rust: )),
    // rust: _ => {}
}
    // rust: settings.extend([
    // rust: ("layers", Tag::List(layers)),
    // rust: ("lakes", Tag::Byte(i8::from(flag("lakes")))),
    // rust: ("features", Tag::Byte(i8::from(flag("features")))),
    // rust: ("biome", Tag::String(biome.as_str().into())),
    // rust: ]);
    // rust: if !errors.is_empty() {
    // rust: logged.push(errors.join("; "));
}
    // rust: (Some(Tag::compound(settings)), logged)
}
    // rust: impl ChunkGenerator for FlatTerrain {
    // rust: type Worker = ();
pub fn worker(self: *Self) void {
}
pub fn lod_surface(self: *Self, _: *mut () void {
}
    // rust: self.surface
}
pub fn proto(self: *Self, _: *mut () void {
}
    // rust: let mut chunk = Chunk::with_layout(cx, cz, self.shape.column());
    // rust: for s in &mut chunk.sections {
    // rust: std::sync::Arc::make_mut(s).biomes = horizon_core::paletted::PalettedContainer::new(
    // rust: crate::chunk::BIOME_STRATEGY,
    // rust: u32::from(self.biome),
    // rust: );
}
    // rust: let height = self.shape.height as usize;
    // rust: for (i, &block) in self.layers.iter().enumerate().take(height) {
    // rust: if block == 0 {
    // rust: continue;
}
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: chunk.set(x, self.shape.min_y + i as i32, z, block);
}
}
}
        // ChunkGenerator.applyBiomeDecoration at the chunk's section origin.
        // VoidStartPlatformFeature writes only inside its own chunk and draws
        // no random numbers, so placing it here gives the FEATURES result.
    // rust: if let Some(blocks) = self.void_platform {
    // rust: let origin = [cx * 16, self.shape.min_y, cz * 16];
    // rust: let mut random = horizon_core::random::LegacyRandom::new(0);
    // rust: if let Err(e) = BasicFeature::VoidStartPlatform.place(
    // rust: &mut ChunkWorld(&mut chunk),
    // rust: &mut random,
    // rust: origin,
    // rust: blocks,
    // rust: ) {
    // rust: log::warn!("Horizon: placing void_start_platform failed: {e}");
}
}
    // rust: for s in &mut chunk.sections {
    // rust: std::sync::Arc::make_mut(s).compact();
}
    // rust: Box::new(chunk)
}
    /// FlatLevelSource.spawnOriginalMobs is empty: no generation-time spawns.
pub fn finish(self: *Self, proto: crate::streaming::Proto) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *proto.downcast::<Chunk>().expect("flat terrain proto")
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::save::{number, text};
//     use crate::server::json::{self, Json};

pub fn read(text: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let json: Json = json::parse(text, false).unwrap();
    // rust: settings_from_json(
    // rust: &json,
    // rust: |b| ["minecraft:stone", "minecraft:bedrock"].contains(&b),
    // rust: |b| ["minecraft:plains", "minecraft:desert"].contains(&b),
    // rust: )
}

    /// A world_gen_settings with a flat overworld of `layers` (block, height).
pub fn flat_world(biome: []const u8, features: bool, layers: *[([]const u8) void {
}
    // rust: let layers = layers
    // rust: .iter()
    // rust: .map(|&(block, height)| {
    // rust: Tag::compound([
    // rust: ("block", Tag::String(block.into())),
    // rust: ("height", Tag::Int(height)),
    // rust: ])
    // rust: })
    // rust: .collect();
    // rust: let settings = Tag::compound([
    // rust: ("biome", Tag::String(biome.into())),
    // rust: ("features", Tag::Byte(i8::from(features))),
    // rust: ("lakes", Tag::Byte(0)),
    // rust: ("layers", Tag::List(layers)),
    // rust: ]);
    // rust: let generator = Tag::compound([
    // rust: ("type", Tag::String("minecraft:flat".into())),
    // rust: ("settings", settings),
    // rust: ]);
    // rust: Tag::compound([(
    // rust: "dimensions",
    // rust: Tag::compound([(
    // rust: "minecraft:overworld",
    // rust: Tag::compound([("generator", generator)]),
    // rust: )]),
    // rust: )])
}

pub fn the_void_preset_places_the_start_platform() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let biomes = crate::biome::Biomes::load(&root).unwrap();
    // rust: let terrain = |biome, features, layers: &[(&str, i32)]| {
    // rust: FlatTerrain::from_settings(
    // rust: &flat_world(biome, features, layers),
    // rust: registry,
    // rust: &biomes,
    // rust: LevelShape::OVERWORLD,
    // rust: )
    // rust: .unwrap()
}
    // rust: let block = |terrain: &FlatTerrain, [x, y, z]: [i32; 3]| {
    // rust: let chunk = terrain.finish(terrain.proto(&mut (), x >> 4, z >> 4));
    // rust: registry.state(chunk.block(x, y, z)).unwrap().name.clone()
}
        // The Void preset (flat_level_generator_preset/the_void): the_void's
        // only feature, VoidStartPlatformFeature, at the minimum Y + 3: a
        // 33×33 stone square around 8, 8 with cobblestone at its centre, in
        // the chunks within one of chunk 0, 0.
    // rust: let void = terrain("minecraft:the_void", true, &[("minecraft:air", 1)]);
    // rust: for (pos, expected) in [
    // rust: ([8, -61, 8], "minecraft:cobblestone"),
    // rust: ([0, -61, 0], "minecraft:stone"),
    // rust: ([-8, -61, -8], "minecraft:stone"),
    // rust: ([24, -61, 24], "minecraft:stone"),
    // rust: ([24, -61, -8], "minecraft:stone"),
    // rust: ([-9, -61, 8], "minecraft:air"),
    // rust: ([25, -61, 8], "minecraft:air"),
    // rust: ([8, -60, 8], "minecraft:air"),
    // rust: ([8, -62, 8], "minecraft:air"),
    // rust: ([40, -61, 8], "minecraft:air"),
    // rust: ] {
    // rust: assert_eq!(block(&void, pos), expected, "{pos:?}");
}
        // The decoration is off without `features`.
    // rust: let plain = terrain("minecraft:the_void", false, &[("minecraft:air", 1)]);
    // rust: assert_eq!(block(&plain, [8, -61, 8]), "minecraft:air");
        // the_void over solid layers still gets its platform.
    // rust: let floor = terrain("minecraft:the_void", true, &[("minecraft:bedrock", 1)]);
    // rust: assert_eq!(block(&floor, [8, -64, 8]), "minecraft:bedrock");
    // rust: assert_eq!(block(&floor, [8, -61, 8]), "minecraft:cobblestone");
}

pub fn adjusted_generation_settings_keep_the_biome_features_outside_structures() void {
}
    // rust: let steps: Vec<Vec<String>> = (0..11).map(|step| vec![format!("f{step}")]).collect();
    // rust: let kept = |features, lakes, void_gen, the_void| {
    // rust: decoration_features(&steps, features, lakes, void_gen, the_void)
    // rust: .map(str::to_owned)
    // rust: .collect::<Vec<_>>()
}
    // rust: let all_but_structures = ["f0", "f1", "f2", "f5", "f6", "f7", "f8", "f9", "f10"];
    // rust: assert_eq!(kept(true, false, false, false), all_but_structures);
        // The lava lakes take the LAKES step's place.
    // rust: assert_eq!(kept(true, true, false, false)[1..], all_but_structures[2..]);
        // An all-air world is decorated only in the_void.
    // rust: assert!(kept(true, false, true, false).is_empty());
    // rust: assert_eq!(kept(true, false, true, true), all_but_structures);
    // rust: assert!(kept(false, false, false, true).is_empty());
}

pub fn generator_settings_read_as_flat_level_generator_settings() void {
}
        // server.properties' default: the preset's own layers, and the codec's error.
    // rust: assert_eq!(
    // rust: read("{}"),
    // rust: (None, vec!["No key layers in MapLike[{}]".into()])
    // rust: );
    // rust: let (settings, errors) = read(
    // rust: r#"{"layers":[{"block":"bedrock","height":1},{"block":"minecraft:stone","height":3}],"biome":"desert","features":true}"#,
    // rust: );
    // rust: assert!(errors.is_empty());
    // rust: let settings = settings.unwrap();
    // rust: let Some(Tag::List(layers)) = settings.get("layers") else {
    // rust: panic!("{settings:?}")
}
    // rust: assert_eq!(layers.len(), 2);
    // rust: assert_eq!(
    // rust: text(layers[0].get("block")).as_deref(),
    // rust: Some("minecraft:bedrock")
    // rust: );
    // rust: assert_eq!(number(layers[1].get("height")), Some(3));
    // rust: assert_eq!(
    // rust: text(settings.get("biome")).as_deref(),
    // rust: Some("minecraft:desert")
    // rust: );
    // rust: assert_eq!(number(settings.get("features")), Some(1));
    // rust: assert_eq!(number(settings.get("lakes")), Some(0));
        // A layer that doesn't parse is left out; an unknown biome is Plains, and logged first.
    // rust: let (settings, errors) = read(
    // rust: r#"{"layers":[{"block":"nope","height":2},{"block":"stone","height":2}],"biome":"x"}"#,
    // rust: );
    // rust: assert_eq!(errors.len(), 2);
    // rust: assert_eq!(errors[0], "Unknown biome, defaulting to plains");
    // rust: assert!(errors[1].contains("minecraft:nope"));
    // rust: let settings = settings.unwrap();
    // rust: let Some(Tag::List(layers)) = settings.get("layers") else {
    // rust: panic!("{settings:?}")
}
    // rust: assert_eq!(layers.len(), 1);
    // rust: assert_eq!(
    // rust: text(settings.get("biome")).as_deref(),
    // rust: Some("minecraft:plains")
    // rust: );
        // validateHeight.
    // rust: assert_eq!(
    // rust: read(
    // rust: r#"{"layers":[{"block":"stone","height":4000},{"block":"stone","height":100}],"biome":"plains"}"#
    // rust: ),
    // rust: (None, vec!["Sum of layer heights is > 4064".into()])
    // rust: );
}

    /// `FlatLevelSource.createState`: the settings a flat world's structure sets run with.
pub fn a_flat_world_names_the_structure_sets_that_may_generate() void {
}
    // rust: let world = |generator: Tag| {
    // rust: Tag::compound([(
    // rust: "dimensions",
    // rust: Tag::compound([(
    // rust: "minecraft:overworld",
    // rust: Tag::compound([("generator", generator)]),
    // rust: )]),
    // rust: )])
}
    // rust: let flat = |extra: Vec<(&str, Tag)>, biome: &str| {
    // rust: let mut settings = vec![
    // rust: ("biome", Tag::String(biome.into())),
    // rust: (
    // rust: "layers",
    // rust: Tag::List(vec![Tag::compound([
    // rust: ("block", Tag::String("minecraft:stone".into())),
    // rust: ("height", Tag::Int(3)),
    // rust: ])]),
    // rust: ),
    // rust: ];
    // rust: settings.extend(extra);
    // rust: world(Tag::compound([
    // rust: ("type", Tag::String("minecraft:flat".into())),
    // rust: ("settings", Tag::compound(settings)),
    // rust: ]))
}
        // No key: every set. A list: those. An empty list: none. The void and a noise world: none.
    // rust: let all = FlatTerrain::pipeline_settings(&flat(vec![], "minecraft:plains")).unwrap();
    // rust: assert_eq!(all.structure_overrides, None);
    // rust: assert_eq!(all.layers, [("minecraft:stone".to_owned(), 3)]);
    // rust: let some = FlatTerrain::pipeline_settings(&flat(
    // rust: vec![(
    // rust: "structure_overrides",
    // rust: Tag::List(vec![Tag::String("minecraft:villages".into())]),
    // rust: )],
    // rust: "minecraft:desert",
    // rust: ))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: some.structure_overrides,
    // rust: Some(vec!["minecraft:villages".to_owned()])
    // rust: );
    // rust: assert_eq!(some.biome, "minecraft:desert");
    // rust: assert!(
    // rust: FlatTerrain::pipeline_settings(&flat(
    // rust: vec![("structure_overrides", Tag::List(vec![]))],
    // rust: "minecraft:plains"
    // rust: ))
    // rust: .is_none()
    // rust: );
        // No structure set, but features or lakes to place: the pipeline, with no set.
    // rust: for key in ["features", "lakes"] {
    // rust: let decorated = FlatTerrain::pipeline_settings(&flat(
    // rust: vec![
    // rust: ("structure_overrides", Tag::List(vec![])),
    // rust: (key, Tag::Byte(1)),
    // rust: ],
    // rust: "minecraft:plains",
    // rust: ))
    // rust: .unwrap();
    // rust: assert_eq!(decorated.structure_overrides, Some(vec![]), "{key}");
    // rust: assert_eq!(
    // rust: (decorated.features, decorated.lakes),
    // rust: (key == "features", key == "lakes")
    // rust: );
}
    // rust: assert!(FlatTerrain::pipeline_settings(&flat(vec![], "minecraft:the_void")).is_none());
    // rust: assert!(
    // rust: FlatTerrain::pipeline_settings(&world(Tag::compound([(
    // rust: "type",
    // rust: Tag::String("minecraft:noise".into())
    // rust: )])))
    // rust: .is_none()
    // rust: );
}
}
