//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_assets
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use crate::Result;
// use horizon_world::{
    // rust: DATA_VERSION,
    // rust: heightmap::HeightmapState,
    // rust: registry::{BlockRegistry, BlockStateId},
    // rust: worldgen::{tags::TagDefinitions, terrain::TerrainBlockStates},
}
// use serde_json::Value;
// use std::{collections::BTreeSet, io, path::Path, sync::Arc};

pub const MATERIALS: [[]const u8; 6] = ["bedrock", "dirt", "stone", "sand", "oak_planks", "bricks"];
pub const StateFacts = struct {
    air: bool,
    fluid: bool,
    air_block: bool,
    motion: bool,
    no_leaves: bool,
};
    // rust: impl HeightmapState for StateFacts {
pub fn is_air(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.air
}
pub fn is_air_block(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.air_block
}
pub fn has_fluid(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fluid
}
pub fn blocks_motion_in_heightmap(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.motion
}
pub fn blocks_motion_in_heightmap_no_leaves(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.no_leaves
}
}
pub const Properties = struct {};
    // rust: impl Properties {
    /// Heightmap facts for tests, per state: (air, has a fluid, blocks
    /// motion, blocks motion but is not leaves). State 0 is minecraft:air.
pub fn for_tests(states: *[(bool) void {
}
    // rust: Self(Arc::new(
    // rust: states
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, &(air, fluid, motion, no_leaves))| StateFacts {
    // rust: air,
    // rust: fluid,
    // rust: air_block: i == 0,
    // rust: motion,
    // rust: no_leaves,
    // rust: })
    // rust: .collect(),
    // rust: ))
}
}
    // rust: impl TerrainBlockStates for Properties {
    // rust: type State = StateFacts;
pub fn heightmap_state(self: *Self, id: BlockStateId) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0[id.0 as usize]
}
}
/// The block registry and the facts read from `facts.json` and the block tags:
/// everything world generation and collisions need, with none of the block
/// models or baked sprites.
pub const Assets = struct {
    /// Leaked once per process: shared by world generation threads.
    registry: *'static BlockRegistry,
    properties: Properties,
    material_states: [BlockStateId,
    /// Block names in `#minecraft:blocks_fluid_flow` (fluid flow vectors).
    blocks_fluid_flow: BTreeSet<[]const u8>,
};
/// The block models and their baked sprites, read from the pack at `root` over
/// an existing block registry: everything the mesher and renderer need.
pub const RenderAssets = struct {
    sprite_size: u32,
    sprite_minimum_size: u32,
    /// The block sprites' RGBA, layer by layer: as built until a renderer has
    /// them, then kept compressed ([`SpritePixels`]).
    pixels: SpritePixels,
    texture_layers: u32,
    model_catalog: crate::models::StateModels,
    /// Shared parsed resources; item-only validation errors surface at item preparation.
    model_library: std::result::!Arc<horizon_assets::resolve::ModelLibrary,
    model_placements: Vec<(horizon_core::position::BlockPos,
    model_gallery: std.ArrayList(Value),
    animations: std.ArrayList(crate::sprites::SpriteAnimation),
    sprite_layers: std::collections::BTreeMap<[]const u8,
    /// OptiFine's emissive block overlays: base sprite and overlay sprite names.
    emissive: Vec<([]const u8,
    translucent_layers: std.ArrayList(bool),
    /// Each layer's `MipmapGenerator` settings.
    sprite_mips: std.ArrayList(crate::mipmap::Settings),
    /// The resource packs' LabPBR maps (normals, specular), layer by layer at `pbr_size`:
    /// empty when they ship none.
    pbr_normals: std.ArrayList(u8),
    pbr_specular: std.ArrayList(u8),
    pbr_size: u32,
    /// OptiFine connected textures (empty without `optifine/ctm` files).
    connected: crate::connected::ConnectedTextures,
    /// Fusion connected textures (empty without Fusion's connecting textures and models).
    fusion: crate::fusion::FusionTextures,
    /// Counts up each time resources load, from 1: a native mod asks again where blocks'
    /// sprites are when it changes (`native_block_sprites_version`).
    generation: u64,
};
/// The block sprites' pixels for a renderer to upload. Once a renderer has
/// them ([`Self::pack`]) they are kept lz4-compressed: the GPU holds the
/// texture array, and the copy only serves a renderer made again (another
/// window, a lost device, another graphics API), which waits for
/// [`Self::get`] to uncompress them. Shared by the window and the workers'
/// `RenderAssets`, so the compressed form replaces the raw one in place.
pub const SpritePixels = struct {};
pub const PixelStore = struct {
    len: usize,
    /// Set by the first `pack`: later calls cost one atomic read.
    packing: std::sync::atomic::AtomicBool,
    /// As built; dropped once `packed` holds them.
    raw: std::sync::Mutex<?*std.ArrayList(u8)>,
    packed: std::sync::OnceLock<std.ArrayList(u8)>,
};
    // rust: impl SpritePixels {
pub fn new(pixels: std.ArrayList(u8)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(Arc::new(PixelStore {
    // rust: len: pixels.len(),
    // rust: packing: std::sync::atomic::AtomicBool::new(false),
    // rust: raw: std::sync::Mutex::new(Some(Arc::new(pixels))),
    // rust: packed: std::sync::OnceLock::new(),
    // rust: }))
}
    /// Their size in bytes, uncompressed.
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.len
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.len == 0
}
    /// The pixels as built, uncompressed again once packed.
pub fn get(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let raw = self.0.raw.lock().unwrap_or_else(|e| e.into_inner()).clone();
    // rust: raw.unwrap_or_else(|| {
    // rust: let packed = self.0.packed.get().map(Vec::as_slice).unwrap_or_default();
    // rust: Arc::new(
    // rust: lz4_flex::decompress_size_prepended(packed)
    // rust: .ok()
    // rust: .filter(|p| p.len() == self.0.len)
    // rust: .unwrap_or_else(|| vec![0; self.0.len]),
    // rust: )
    // rust: })
}
    /// Keep them compressed from now on, once a renderer has uploaded them:
    /// compressed on a thread of their own, the raw copy dropped after.
pub fn pack(self: *Self) void {
}
//         use std::sync::atomic::Ordering;
    // rust: if self.0.len == 0 || self.0.packing.swap(true, Ordering::Relaxed) {
    // rust: return;
}
    // rust: let store = self.0.clone();
    // rust: let job = move || {
    // rust: let raw = store.raw.lock().unwrap_or_else(|e| e.into_inner()).clone();
    // rust: if let Some(raw) = raw {
    // rust: let _ = store.packed.set(lz4_flex::compress_prepend_size(&raw));
                // `get` reads the compressed copy from here on.
    // rust: *store.raw.lock().unwrap_or_else(|e| e.into_inner()) = None;
}
}
    // rust: let fallback = job.clone();
    // rust: if std::thread::Builder::new()
    // rust: .name("Sprite packing".into())
    // rust: .spawn(job)
    // rust: .is_err()
    // rust: {
    // rust: fallback();
}
}
}
/// The last `RenderAssets::generation` handed out.
pub const GENERATION: std::sync::atomic::AtomicU64 = std::sync::atomic::AtomicU64::new(0);
pub fn invalid(message: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: io::Error::new(io::ErrorKind::InvalidData, message)
}
    // rust: impl Assets {
pub fn load(root: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let manifest: Value = horizon_world::json_file::read(&root.join("horizon-resources.json"))?;
    // rust: if manifest["data_version"].as_i64() != Some(i64::from(DATA_VERSION)) {
    // rust: return Err(invalid("resources do not match Horizon's pinned data version").into());
}
    // rust: let (registry, flags) = horizon_world::level::data::load_registry_with_flags(root)?;
    // rust: let bundle: Value = horizon_world::json_file::read(&root.join("block-tags.json"))?;
    // rust: let mut definitions = TagDefinitions::default();
    // rust: for (name, text) in bundle
    // rust: .as_object()
    // rust: .ok_or_else(|| invalid("invalid block tag bundle"))?
    // rust: {
    // rust: definitions.apply_json(
    // rust: name,
    // rust: "vanilla",
    // rust: text.as_str()
    // rust: .ok_or_else(|| invalid("invalid block tag text"))?,
    // rust: )?;
}
    // rust: let built =
    // rust: definitions.build(|name, _| registry.default_state(name).map(|_| name.to_owned()))?;
    // rust: if !built.missing.is_empty() {
    // rust: return Err(invalid("unresolved block tags").into());
}
    // rust: let motion: BTreeSet<_> = built
    // rust: .tags
    // rust: .get("minecraft:blocks_motion_in_heightmap")
    // rust: .ok_or_else(|| invalid("missing motion tag"))?
    // rust: .iter()
    // rust: .map(String::as_str)
    // rust: .collect();
    // rust: let no_leaves: BTreeSet<_> = built
    // rust: .tags
    // rust: .get("minecraft:blocks_motion_in_heightmap_no_leaves")
    // rust: .ok_or_else(|| invalid("missing no-leaves motion tag"))?
    // rust: .iter()
    // rust: .map(String::as_str)
    // rust: .collect();
    // rust: let blocks_fluid_flow = built
    // rust: .tags
    // rust: .get("minecraft:blocks_fluid_flow")
    // rust: .ok_or_else(|| invalid("missing fluid flow tag"))?
    // rust: .iter()
    // rust: .cloned()
    // rust: .collect();
    // rust: let properties = Properties(Arc::new(
    // rust: flags
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, &(air, fluid))| {
    // rust: let name = &registry
    // rust: .state(BlockStateId(i as u32))
    // rust: .ok_or_else(|| invalid("missing registry state"))?
    // rust: .name;
    // rust: Ok(StateFacts {
    // rust: air,
    // rust: fluid,
    // rust: air_block: name == "minecraft:air",
    // rust: motion: motion.contains(name.as_str()),
    // rust: no_leaves: no_leaves.contains(name.as_str()),
    // rust: })
    // rust: })
    // rust: .collect::<Result<_>>()?,
    // rust: ));
    // rust: let mut material_states = [BlockStateId(0); 6];
    // rust: for (layer, name) in MATERIALS.iter().enumerate() {
    // rust: material_states[layer] = registry
    // rust: .default_state(&format!("minecraft:{name}"))
    // rust: .ok_or_else(|| invalid("missing test-scene material"))?;
}
        // Chunks hold every state of this registry: content mods can take it
        // past vanilla's 16-bit global palette.
    // rust: crate::chunk::set_block_states(registry.len());
    // rust: let registry: &'static BlockRegistry = Box::leak(Box::new(registry));
    // rust: Ok(Self {
    // rust: registry,
    // rust: properties,
    // rust: material_states,
    // rust: blocks_fluid_flow,
    // rust: })
}
    /// The models and sprites of another resource root over these blocks
    /// (resource packs changed): the registry and block facts come from the
    /// game data, which resource packs do not touch.
pub fn reload(self: *Self, root: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: RenderAssets::load(root, self)
}
    /// [`Assets::reload`] with the model library already parsed.
    ///
    /// Parsing it reads every model file under `assets/`, which needs no
    /// block registry, so a caller that has the files to spare can start
    /// it before `Assets::load` finishes and hand the result in here. On
    /// a cold cache that is most of a second of reading moved off the
    /// critical path.
    // rust: pub fn reload_with_models(
    // rust: &self,
    // rust: root: &Path,
    // rust: parsed: crate::model_library::ParsedModels,
    // rust: ) -> Result<RenderAssets> {
    // rust: RenderAssets::load_with_parsed(root, self, true, Some(parsed))
}
    /// [`Assets::reload`] for a server, which draws nothing: the sprites'
    /// layers, without the block or item models or the textures' pixels.
pub fn reload_for_server(self: *Self, root: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: RenderAssets::load_with(root, self, false)
}
}
    // rust: impl RenderAssets {
pub fn load(root: *Path, assets: *Assets) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::load_with(root, assets, true)
}
pub fn load_with(root: *Path, assets: *Assets, draws: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::load_with_parsed(root, assets, draws, None)
}
    /// `parsed`: the model library when a caller parsed it ahead of this
    /// (see [`Assets::reload_with_models`]); otherwise it is parsed here.
    // rust: fn load_with_parsed(
    // rust: root: &Path,
    // rust: assets: &Assets,
    // rust: draws: bool,
    // rust: parsed: Option<crate::model_library::ParsedModels>,
    // rust: ) -> Result<Self> {
    // rust: let registry = assets.registry;
    // rust: let mut sprites = crate::sprites::Sprites::with_disk_cache(root);
    // rust: for name in MATERIALS {
    // rust: sprites.insert(root, &format!("minecraft:block/{name}"))?;
}
        // A server draws no block and no item: its block models (about 24 MB
        // baked) and item model library (7 MB) stay empty.
    // rust: let parsed = match parsed {
    // rust: Some(parsed) => parsed,
    // rust: None if draws => {
    // rust: let _step = crate::spans::startup::step("core.models_parse");
    // rust: crate::model_library::ParsedModels::load(root)
}
    // rust: None => crate::model_library::ParsedModels::default(),
}
    // rust: let mut models = if draws {
    // rust: let _step = crate::spans::startup::step("core.models_bake");
    // rust: crate::models::prepare_with_models(root, registry, &mut sprites, &parsed)?
    // rust: } else {
    // rust: crate::models::PreparedModels::default()
}
    // rust: let model_library = {
    // rust: let _step = crate::spans::startup::step("core.item_library");
    // rust: parsed.into_item_library()
}
        // Fluids are drawn by the fluid renderer, not block models; breaking
        // progress uses the destroy-stage overlays.
    // rust: for name in [
    // rust: "water_still",
    // rust: "water_flow",
    // rust: "water_overlay",
    // rust: "lava_still",
    // rust: "lava_flow",
    // rust: ] {
    // rust: sprites.insert(root, &format!("minecraft:block/{name}"))?;
}
    // rust: for stage in 0..10 {
    // rust: sprites.insert(root, &format!("minecraft:block/destroy_stage_{stage}"))?;
    // rust: sprites.insert(root, &format!("minecraft:block/destroy_oit_stage_{stage}"))?;
}
    // rust: let fusion = if draws {
    // rust: let _step = crate::spans::startup::step("core.fusion");
    // rust: crate::fusion::FusionTextures::load(root, registry, &mut sprites, &mut models.catalog)
    // rust: } else {
    // rust: Default::default()
}
    // rust: let mut emissive = Vec::new();
    // rust: let connected = if draws {
    // rust: crate::native_emissive::load(root, &mut sprites);
            // A side's sprite, for rules that connect by tile: the first quad facing it.
    // rust: let catalog = &models.catalog;
    // rust: let mut found = Vec::new();
    // rust: crate::connected::ConnectedTextures::load(
    // rust: root,
    // rust: registry,
    // rust: &mut sprites,
    // rust: |state, face| {
    // rust: let side = horizon_assets::model::Direction::ALL[face as usize];
    // rust: catalog
    // rust: .models_at(
    // rust: state,
    // rust: horizon_core::position::BlockPos::new(0, 0, 0),
    // rust: &mut found,
    // rust: )
    // rust: .ok()?;
    // rust: found
    // rust: .iter()
    // rust: .flat_map(|m| &m.faces)
    // rust: .find(|f| f.quad.facing == side)
    // rust: .map(|f| f.layer)
    // rust: },
    // rust: )
    // rust: } else {
    // rust: Default::default()
}
        // After the connected tiles: a tile identical to a block shares its layer, and the
        // overlays skip shared layers.
    // rust: if draws {
    // rust: emissive = crate::native_emissive::load_optifine(root, &mut sprites);
}
    // rust: sprites.save_disk_cache();
    // rust: if draws {
    // rust: sprites.finish();
    // rust: } else {
    // rust: sprites.finish_without_pixels();
}
        // `finish` grows the buffer by doubling: keep only the bytes in use.
    // rust: sprites.pixels.shrink_to_fit();
    // rust: Ok(Self {
    // rust: sprite_size: sprites.size,
    // rust: sprite_minimum_size: sprites.minimum_size,
    // rust: texture_layers: u32::try_from(sprites.count())?,
    // rust: pixels: SpritePixels::new(sprites.pixels),
    // rust: model_catalog: models.catalog,
    // rust: model_library,
    // rust: model_placements: models.placements,
    // rust: model_gallery: models.states,
    // rust: animations: sprites.animations,
    // rust: sprite_layers: sprites.layers,
    // rust: emissive,
    // rust: translucent_layers: sprites.translucent,
    // rust: sprite_mips: sprites.mips,
    // rust: pbr_normals: sprites.normals,
    // rust: pbr_specular: sprites.specular,
    // rust: pbr_size: sprites.pbr_size,
    // rust: connected,
    // rust: fusion,
    // rust: generation: GENERATION.fetch_add(1, std::sync::atomic::Ordering::Relaxed) + 1,
    // rust: })
}
}

    // rust: mod tests {
//     use crate::items::ConsumeEffect;
//     use horizon_world::loot::PackOverlay;

pub fn always_edible_and_consume_effects_loaded() void {
}
    // rust: let root = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let items =
    // rust: crate::items::Items::load(&root, assets.registry, &facts, &PackOverlay::NONE).unwrap();

    // rust: let apple = items.get("minecraft:golden_apple").expect("golden apple");
    // rust: assert!(apple.can_always_eat);
    // rust: assert!(apple.food.is_some());
    // rust: assert!(!apple.consumable.as_ref().unwrap().effects.is_empty());

    // rust: let enchanted = items
    // rust: .get("minecraft:enchanted_golden_apple")
    // rust: .expect("enchanted golden apple");
    // rust: assert!(enchanted.can_always_eat);
    // rust: assert!(enchanted.food.is_some());
    // rust: assert!(!enchanted.consumable.as_ref().unwrap().effects.is_empty());

    // rust: let beef = items.get("minecraft:cooked_beef").expect("cooked beef");
    // rust: assert!(!beef.can_always_eat);
    // rust: assert!(beef.food.is_some());

        // Consumables without food, their style and their remainders.
//         use horizon_world::consumable::UseAnimation;
    // rust: let milk = items.get("minecraft:milk_bucket").expect("milk bucket");
    // rust: let drink = milk.consumable.as_ref().unwrap();
    // rust: assert!(milk.food.is_none());
    // rust: assert_eq!(drink.effects, [ConsumeEffect::ClearAllEffects]);
    // rust: assert_eq!((drink.ticks(), drink.animation), (32, UseAnimation::Drink));
    // rust: assert_eq!(drink.sound, "minecraft:entity.generic.drink");
    // rust: assert!(!drink.particles);
    // rust: assert_eq!(milk.use_remainder.as_deref(), Some("minecraft:bucket"));
    // rust: let honey = items.get("minecraft:honey_bottle").expect("honey bottle");
    // rust: let sip = honey.consumable.as_ref().unwrap();
    // rust: assert_eq!(sip.ticks(), 40);
    // rust: assert_eq!(sip.sound, "minecraft:item.honey_bottle.drink");
    // rust: assert_eq!(
    // rust: sip.effects,
    // rust: [ConsumeEffect::RemoveEffects(vec![
    // rust: "minecraft:poison".into()
    // rust: ])]
    // rust: );
    // rust: assert_eq!(
    // rust: honey.use_remainder.as_deref(),
    // rust: Some("minecraft:glass_bottle")
    // rust: );
    // rust: let kelp = items.get("minecraft:dried_kelp").unwrap();
    // rust: let bite = kelp.consumable.as_ref().unwrap();
    // rust: assert_eq!((bite.ticks(), bite.animation), (16, UseAnimation::Eat));
    // rust: assert_eq!(bite.sound, "minecraft:entity.generic.eat");
    // rust: assert!(bite.particles && kelp.use_remainder.is_none());
    // rust: let chorus = items.get("minecraft:chorus_fruit").unwrap();
    // rust: assert_eq!(
    // rust: chorus.consumable.as_ref().unwrap().effects,
    // rust: [ConsumeEffect::TeleportRandomly(
    // rust: horizon_world::teleport_consume::TeleportConsume {
    // rust: diameter: 16.0,
    // rust: directional_particles: true,
}
    // rust: )]
    // rust: );
    // rust: let chicken = items.get("minecraft:chicken").unwrap();
    // rust: assert!(matches!(
    // rust: chicken.consumable.as_ref().unwrap().effects[..],
    // rust: [ConsumeEffect::ApplyEffects { probability, .. }] if probability == 0.3
    // rust: ));
}

pub fn sprite_pixels_come_back_the_same_once_packed() void {
}
        // Two layers of 16x16 RGBA with some structure, as sprites have.
    // rust: let pixels: Vec<u8> = (0..2 * 16 * 16 * 4).map(|i| (i * 7 % 251) as u8).collect();
    // rust: let stored = super::SpritePixels::new(pixels.clone());
    // rust: assert_eq!(*stored.get(), pixels);
    // rust: stored.pack();
    // rust: stored.pack();
        // The packing thread drops the raw copy once the compressed one is set.
    // rust: let started = std::time::Instant::now();
    // rust: while stored.0.raw.lock().unwrap().is_some() {
    // rust: assert!(started.elapsed().as_secs() < 10, "packing never finished");
    // rust: std::thread::yield_now();
}
    // rust: assert!(
    // rust: stored
    // rust: .0
    // rust: .packed
    // rust: .get()
    // rust: .is_some_and(|p| p.len() < pixels.len())
    // rust: );
    // rust: assert_eq!(*stored.get(), pixels);
    // rust: assert_eq!(stored.len(), pixels.len());
}
}
