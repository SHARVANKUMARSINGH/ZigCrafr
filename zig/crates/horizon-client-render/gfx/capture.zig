//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_capture
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-ctl render-capture`: what the renderer needs to draw the current frame again
//! without the game, for `examples/scene_replay.rs` (docs/graphics.md, "Render capture and
//! replay").
//!
//! The renderer keeps no CPU copy of the meshes it uploads, so while capturing is on
//! (`Renderer::keep_capture_copies`) it keeps one of every section and far tile mesh as it is
//! handed over, at the mesher-to-renderer seam. A capture writes those of the sections and
//! tiles it holds, the frame's camera and inputs, and the settings that change GPU work. Only
//! the build that wrote a capture reads it.
//!
//! Files: `scene.json` (`Scene`), `sections.json` and `tiles.json` (one `MeshRecord` per mesh,
//! in order), `sections.bin` and `tiles.bin` (each mesh's solid then translucent
//! `TerrainVertex`es), `celestial.bin` (the sun and moon `Vertex`es).
// use super::{Frame, Renderer, SectionKey};
// use crate::{
    // rust: Result,
    // rust: environment::Sky,
    // rust: fast_hash::{FxHashMap, FxHashSet},
    // rust: fog::FogData,
    // rust: graphics::GraphicsApi,
    // rust: hud::HudBatch,
    // rust: lod::TileKey,
    // rust: mesher::{SectionMesh, Sides, TerrainVertex, Vertex},
}
// use glam::{DVec3, Mat4, Vec3};
// use serde::{Deserialize, Serialize};
// use std::{
    // rust: fs::{self, File},
    // rust: io::{BufReader, BufWriter, Read, Write},
    // rust: path::{Path, PathBuf},
}

/// CPU copies of the meshes uploaded since capturing was turned on.
    // rust: pub(super) struct Copies {
    // rust: sections: FxHashMap<SectionKey, SectionMesh>,
    // rust: tiles: FxHashMap<TileKey, SectionMesh>,
}

    // rust: impl Copies {
    // rust: pub(super) fn section(&mut self, key: SectionKey, mesh: &SectionMesh) {
    // rust: self.sections.insert(key, copy(mesh));
}
    /// Columns unloaded (`Renderer::remove_columns`).
    // rust: pub(super) fn remove_columns(&mut self, columns: &[(i32, i32)]) {
    // rust: if columns.is_empty() {
    // rust: return;
}
    // rust: let gone: FxHashSet<(i32, i32)> = columns.iter().copied().collect();
    // rust: self.sections
    // rust: .retain(|&(x, _, z), _| !gone.contains(&(x, z)));
}
    // rust: pub(super) fn tile(&mut self, key: TileKey, mesh: &SectionMesh) {
    // rust: self.tiles.insert(key, copy(mesh));
}
    // rust: pub(super) fn forget_tile(&mut self, key: TileKey) {
    // rust: self.tiles.remove(&key);
}
    // rust: pub(super) fn clear_tiles(&mut self) {
    // rust: self.tiles.clear();
}
}

pub fn copy(mesh: *SectionMesh) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SectionMesh {
    // rust: solid: mesh.solid.clone(),
    // rust: sides: mesh.sides,
    // rust: translucent: mesh.translucent.clone(),
    // rust: packed: mesh.packed.clone(),
    // rust: solid_tints: Vec::new(),
    // rust: visibility: mesh.visibility,
    // rust: block_entities: mesh.block_entities.clone(),
    // rust: lights: mesh.lights.clone(),
    // rust: sprite_layers: mesh.sprite_layers.clone(),
    // rust: bounds: mesh.bounds,
    // rust: keep: mesh.keep,
}
}

/// A capture asked for: where to write it, and the game's settings the renderer does not hold.
pub const Request = struct {
    dir: PathBuf,
    settings: Settings,
};

/// The game's settings that change GPU work, as the game applied them to the renderer.
pub const Settings = struct {
    /// `GraphicsApi`'s variant name.
    graphics_api: []const u8,
    translucent_batching: bool,
    /// `textureFiltering` and `maxAnisotropyBit` (`Renderer::set_texture_filtering`).
    texture_filtering: i32,
    anisotropy_bit: i32,
    mipmap_levels: u32,
    /// `Renderer::set_world_post`'s arguments.
    resolution_scale: f32,
    fxaa: bool,
    taa: bool,
    upscale: f32,
    /// Chunks.
    render_distance: i32,
    lod_distance: u32,
    /// The game's prepared resources, where the replay loads the block sprites from.
    resources: PathBuf,
    /// The block sprites the meshes were made against.
    atlas: AtlasCheck,
};

    // rust: impl Settings {
pub fn graphics_api(self: *Self) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: GraphicsApi::ALL
    // rust: .into_iter()
    // rust: .find(|api| format!("{api:?}") == self.graphics_api)
    // rust: .unwrap_or_default()
}
}

/// Which block sprite layers the meshes' vertices name: the replay's must be the same.
pub const AtlasCheck = struct {
    sprite_size: u32,
    texture_layers: u32,
    /// FNV-1a of every sprite's name and layer.
    layers: u64,
};

    // rust: impl AtlasCheck {
pub fn of(render: *crate::assets::RenderAssets) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut hash = 0xcbf2_9ce4_8422_2325u64;
    // rust: for (name, layer) in &render.sprite_layers {
    // rust: for byte in name.bytes().chain(layer.to_le_bytes()) {
    // rust: hash = (hash ^ u64::from(byte)).wrapping_mul(0x0000_0100_0000_01b3);
}
}
    // rust: Self {
    // rust: sprite_size: render.sprite_size,
    // rust: texture_layers: render.texture_layers,
    // rust: layers: hash,
}
}
}

/// The renderer's own state that changes GPU work.
pub const RendererState = struct {
    adapter: []const u8,
    backend: []const u8,
    /// The frame's size in pixels.
    size: [u32,
    /// The column layout: lowest block y and sections.
    min_y: i32,
    sections: usize,
    flat_draws: bool,
    section_cull: bool,
    section_sides: bool,
    gpu_culling: bool,
    gamma: f32,
    fullbright: bool,
    improved_transparency: bool,
    animated_textures: bool,
    /// A shader pack was running; the replay draws without it.
    shader_pack: bool,
};

/// The cloud inputs of the frame (`clouds::Input`), with the clouds texture.
pub const Clouds = struct {
    texture: (u32,
    uv: [f32,
    camera: [f64,
    time: i64,
    partial_tick: f64,
    range: i32,
    fast: bool,
    color: [f32,
};

/// The frame's camera and the inputs of its globals, sky, fog and lightmap.
pub const FrameInputs = struct {
    camera: [f64,
    yaw: f32,
    pitch: f32,
    fov_degrees: f32,
    eye: [f64,
    eye_rotation: [f32,
    first_person: bool,
    bob: [f32,
    spin: [f32,
    sky: Sky,
    distance: f32,
    detail_distance: f32,
    depth_far: f32,
    underwater: bool,
    water_plane: ?f32,
    cave_culling: bool,
    sky_blocked: bool,
    skybox: bool,
    end_sky: bool,
    end_sky_sprite: Option<[f32,
    environment_fog: Option<(f32,
    water_fog: [f32,
    fog: ?FogData,
    dark_disc: bool,
    nether_lighting: bool,
    glint_alpha: f32,
    glint_ticks: f32,
    hand_fov_degrees: f32,
    stars: Option<([f32,
    clouds: ?Clouds,
    game_time: f32,
    shader_game_time: f32,
    end_portal_sprites: [[f32,
    crumbling_sprite: [f32,
    ticks: u64,
    darkness: (f32,
    night_vision: f32,
    block_flicker: f32,
    boss_darken: f32,
};

/// `scene.json`.
pub const Scene = struct {
    settings: Settings,
    renderer: RendererState,
    frame: FrameInputs,
    sections: usize,
    tiles: usize,
    /// The chunk columns far tiles leave out for full-detail sections.
    lod_cutout: Vec<(i32,
    /// `celestial.bin`.
    celestial: std.ArrayList(Vertex),
};

/// One mesh of `sections.json` or `tiles.json`; its vertices follow the previous mesh's in
/// the `.bin` file. `key` is (x, section y, z) for a section, (x, z, level) for a tile.
pub const MeshRecord = struct {
    key: [i32,
    solid: usize,
    translucent: usize,
    sides: Sides,
    visibility: u64,
    block_entities: Vec<([i32,
    lights: Vec<([i32,
    sprite_layers: std.ArrayList(u16),
    bounds: Option<[[f32,
    keep: bool,
};

/// Writes `name.json` and `name.bin`: (meshes, vertex bytes).
    // rust: fn write_meshes<'m>(
    // rust: dir: &Path,
    // rust: name: &str,
    // rust: meshes: impl Iterator<Item = ([i32; 3], &'m SectionMesh)>,
    // rust: ) -> Result<(usize, u64)> {
    // rust: let mut blob = BufWriter::new(File::create(dir.join(format!("{name}.bin")))?);
    // rust: let mut records = Vec::new();
    // rust: let mut bytes = 0u64;
    // rust: for (key, mesh) in meshes {
    // rust: for part in [&mesh.solid, &mesh.translucent] {
    // rust: let raw: &[u8] = bytemuck::cast_slice(part.as_slice());
    // rust: blob.write_all(raw)?;
    // rust: bytes += raw.len() as u64;
}
    // rust: records.push(MeshRecord {
    // rust: key,
    // rust: solid: mesh.solid.len(),
    // rust: translucent: mesh.translucent.len(),
    // rust: sides: mesh.sides,
    // rust: visibility: mesh.visibility,
    // rust: block_entities: mesh.block_entities.clone(),
    // rust: lights: mesh.lights.clone(),
    // rust: sprite_layers: mesh.sprite_layers.clone(),
    // rust: bounds: mesh
    // rust: .bounds
    // rust: .map(|[min, max]| [min.to_array(), max.to_array()]),
    // rust: keep: mesh.keep,
    // rust: });
}
    // rust: blob.flush()?;
    // rust: let mut list = BufWriter::new(File::create(dir.join(format!("{name}.json")))?);
    // rust: serde_json::to_writer(&mut list, &records)?;
    // rust: list.flush()?;
    // rust: Ok((records.len(), bytes))
}

/// Reads `name.json` and `name.bin`, handing each mesh to `each` as it is read.
    // rust: pub fn read_meshes(
    // rust: dir: &Path,
    // rust: name: &str,
    // rust: mut each: impl FnMut([i32; 3], SectionMesh),
    // rust: ) -> Result<()> {
    // rust: let records: Vec<MeshRecord> = serde_json::from_reader(BufReader::new(File::open(
    // rust: dir.join(format!("{name}.json")),
    // rust: )?))?;
    // rust: let mut blob = BufReader::new(File::open(dir.join(format!("{name}.bin")))?);
    // rust: for record in records {
    // rust: let mut solid = vec![<TerrainVertex as bytemuck::Zeroable>::zeroed(); record.solid];
    // rust: blob.read_exact(bytemuck::cast_slice_mut::<TerrainVertex, u8>(
    // rust: solid.as_mut_slice(),
    // rust: ))?;
    // rust: let mut translucent =
    // rust: vec![<TerrainVertex as bytemuck::Zeroable>::zeroed(); record.translucent];
    // rust: blob.read_exact(bytemuck::cast_slice_mut::<TerrainVertex, u8>(
    // rust: translucent.as_mut_slice(),
    // rust: ))?;
    // rust: each(
    // rust: record.key,
    // rust: SectionMesh {
    // rust: solid,
    // rust: sides: record.sides,
    // rust: translucent,
    // rust: visibility: record.visibility,
    // rust: block_entities: record.block_entities,
    // rust: lights: record.lights,
    // rust: sprite_layers: record.sprite_layers,
    // rust: bounds: record
    // rust: .bounds
    // rust: .map(|[min, max]| [Vec3::from_array(min), Vec3::from_array(max)]),
    // rust: keep: record.keep,
    // rust: ..Default::default()
    // rust: },
    // rust: );
}
    // rust: Ok(())
}

    // rust: impl Renderer {
    /// Keeps CPU copies of the meshes uploaded from now on, for `render-capture`, or drops
    /// them. They start empty: the caller meshes everything again for a complete capture.
pub fn keep_capture_copies(self: *Self, on: bool) void {
}
    // rust: if on != self.capture_copies.is_some() {
    // rust: self.capture_copies = on.then(Copies::default);
}
}
pub fn keeps_capture_copies(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.capture_copies.is_some()
}

    /// Writes the scene `frame` draws to `request.dir` (`render` calls it for `capture`).
    // rust: pub(super) fn write_capture(
    // rust: &self,
    // rust: request: &Request,
    // rust: frame: &Frame,
    // rust: ) -> Result<serde_json::Value> {
    // rust: let copies = self
    // rust: .capture_copies
    // rust: .as_ref()
    // rust: .ok_or("no mesh copies kept: render-capture on first")?;
    // rust: let dir = &request.dir;
    // rust: fs::create_dir_all(dir)?;
    // rust: let (sections, section_bytes) = write_meshes(
    // rust: dir,
    // rust: "sections",
    // rust: copies
    // rust: .sections
    // rust: .iter()
    // rust: .map(|(&(x, y, z), mesh)| ([x, y, z], mesh)),
    // rust: )?;
    // rust: let standing = self.standing_lods();
    // rust: let (tiles, tile_bytes) = write_meshes(
    // rust: dir,
    // rust: "tiles",
    // rust: copies
    // rust: .tiles
    // rust: .iter()
    // rust: .filter(|(key, _)| standing.contains(*key))
    // rust: .map(|(key, mesh)| ([key.x, key.z, i32::from(key.level)], mesh)),
    // rust: )?;
    // rust: fs::write(
    // rust: dir.join("celestial.bin"),
    // rust: bytemuck::cast_slice::<Vertex, u8>(frame.celestial),
    // rust: )?;
    // rust: let scene = Scene {
    // rust: settings: request.settings.clone(),
    // rust: renderer: RendererState {
    // rust: adapter: self.info.name.clone(),
    // rust: backend: format!("{:?}", self.info.backend),
    // rust: size: [self.config.width, self.config.height],
    // rust: min_y: self.layout.min_y(),
    // rust: sections: self.layout.sections(),
    // rust: flat_draws: self.flat_draws(),
    // rust: section_cull: self.section_cull(),
    // rust: section_sides: self.section_sides(),
    // rust: gpu_culling: self.gpu_culling(),
    // rust: gamma: self.gamma,
    // rust: fullbright: self.fullbright,
    // rust: improved_transparency: self.improved_transparency,
    // rust: animated_textures: self.animated_textures,
    // rust: shader_pack: self.pack_post.is_some() || self.native.is_some(),
    // rust: },
    // rust: frame: FrameInputs {
    // rust: camera: frame.camera.to_array(),
    // rust: yaw: frame.yaw,
    // rust: pitch: frame.pitch,
    // rust: fov_degrees: frame.fov_degrees,
    // rust: eye: frame.eye.to_array(),
    // rust: eye_rotation: frame.eye_rotation,
    // rust: first_person: frame.first_person,
    // rust: bob: frame.bob.to_cols_array(),
    // rust: spin: frame.spin.to_cols_array(),
    // rust: sky: frame.sky,
    // rust: distance: frame.distance,
    // rust: detail_distance: frame.detail_distance,
    // rust: depth_far: frame.depth_far,
    // rust: underwater: frame.underwater,
    // rust: water_plane: frame.water_plane,
    // rust: cave_culling: frame.cave_culling,
    // rust: sky_blocked: frame.sky_blocked,
    // rust: skybox: frame.skybox,
    // rust: end_sky: frame.end_sky,
    // rust: end_sky_sprite: frame.end_sky_sprite,
    // rust: environment_fog: frame.environment_fog,
    // rust: water_fog: frame.water_fog,
    // rust: fog: frame.fog,
    // rust: dark_disc: frame.dark_disc,
    // rust: nether_lighting: frame.nether_lighting,
    // rust: glint_alpha: frame.glint_alpha,
    // rust: glint_ticks: frame.glint_ticks,
    // rust: hand_fov_degrees: frame.hand_fov_degrees,
    // rust: stars: frame
    // rust: .stars
    // rust: .map(|(rotation, brightness)| (rotation.to_cols_array(), brightness)),
    // rust: clouds: frame.clouds.as_ref().map(|c| Clouds {
    // rust: texture: c.texture.clone(),
    // rust: uv: c.uv,
    // rust: camera: c.camera.to_array(),
    // rust: time: c.time,
    // rust: partial_tick: c.partial_tick,
    // rust: range: c.range,
    // rust: fast: c.fast,
    // rust: color: c.color,
    // rust: }),
    // rust: game_time: frame.game_time,
    // rust: shader_game_time: frame.shader_game_time,
    // rust: end_portal_sprites: frame.end_portal_sprites,
    // rust: crumbling_sprite: frame.crumbling_sprite,
    // rust: ticks: frame.ticks,
    // rust: darkness: frame.darkness,
    // rust: night_vision: frame.night_vision,
    // rust: block_flicker: frame.block_flicker,
    // rust: boss_darken: frame.boss_darken,
    // rust: },
    // rust: sections,
    // rust: tiles,
    // rust: lod_cutout: self.lod_cutout.iter().copied().collect(),
    // rust: celestial: Vec::new(),
}
    // rust: let mut out = BufWriter::new(File::create(dir.join("scene.json"))?);
    // rust: serde_json::to_writer_pretty(&mut out, &scene)?;
    // rust: out.flush()?;
    // rust: Ok(serde_json::json!({
    // rust: "ok": true,
    // rust: "dir": dir.display().to_string(),
    // rust: "sections": sections,
    // rust: "tiles": tiles,
    // rust: "vertex_bytes": section_bytes + tile_bytes,
    // rust: "shader_pack_left_out": scene.renderer.shader_pack,
    // rust: }))
}
}

    // rust: impl Scene {
    /// Reads `scene.json` and `celestial.bin` (the meshes: `read_meshes`).
pub fn read(dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut scene: Scene =
    // rust: serde_json::from_reader(BufReader::new(File::open(dir.join("scene.json"))?))?;
    // rust: let bytes = fs::read(dir.join("celestial.bin"))?;
    // rust: let size = std::mem::size_of::<Vertex>();
    // rust: let mut celestial = vec![<Vertex as bytemuck::Zeroable>::zeroed(); bytes.len() / size];
    // rust: let len = celestial.len() * size;
    // rust: bytemuck::cast_slice_mut::<Vertex, u8>(celestial.as_mut_slice())
    // rust: .copy_from_slice(&bytes[..len]);
    // rust: scene.celestial = celestial;
    // rust: Ok(scene)
}

    /// The captured frame: its camera, sky, fog, clouds, sun, moon and stars, without
    /// entities, particles, weather, the hand, the outline or the HUD.
    // rust: pub fn frame<'a>(&'a self, hud: &'a HudBatch) -> Frame<'a> {
    // rust: let f = &self.frame;
    // rust: Frame {
    // rust: weather: &[],
    // rust: hand_items: &[],
    // rust: weather_time: crate::weather::Time::new(0, 0.0),
    // rust: camera: DVec3::from_array(f.camera),
    // rust: yaw: f.yaw,
    // rust: pitch: f.pitch,
    // rust: fov_degrees: f.fov_degrees,
    // rust: eye: DVec3::from_array(f.eye),
    // rust: eye_rotation: f.eye_rotation,
    // rust: first_person: f.first_person,
    // rust: bob: Mat4::from_cols_array(&f.bob),
    // rust: spin: Mat4::from_cols_array(&f.spin),
    // rust: sky: f.sky,
    // rust: shadow_scene_revision: (0, 0),
    // rust: shadow_cache: false,
    // rust: distance: f.distance,
    // rust: detail_distance: f.detail_distance,
    // rust: depth_far: f.depth_far,
    // rust: underwater: f.underwater,
    // rust: water_plane: f.water_plane,
    // rust: cave_culling: f.cave_culling,
    // rust: title: false,
    // rust: sky_blocked: f.sky_blocked,
    // rust: skybox: f.skybox,
    // rust: end_sky: f.end_sky,
    // rust: end_sky_sprite: f.end_sky_sprite,
    // rust: environment_fog: f.environment_fog,
    // rust: water_fog: f.water_fog,
    // rust: fog: f.fog,
    // rust: dark_disc: f.dark_disc,
    // rust: outline: Vec::new(),
    // rust: outline_after_terrain: false,
    // rust: outline_high_contrast: false,
    // rust: pvp: Default::default(),
    // rust: debug_lines: &[],
    // rust: debug_lines_on_top: &[],
    // rust: debug_crosshair: &[],
    // rust: hud,
    // rust: glint_alpha: f.glint_alpha,
    // rust: glint_ticks: f.glint_ticks,
    // rust: nether_lighting: f.nether_lighting,
    // rust: entities: &[],
    // rust: static_block_entities: &[],
    // rust: visible_static_block_entity_sections: &[],
    // rust: static_block_entity_stats: Default::default(),
    // rust: entity_motion: &[],
    // rust: entity_spans: &[],
    // rust: skin: None,
    // rust: glowing: &[],
    // rust: dynamic_lights: &[],
    // rust: colored_lights: &[],
    // rust: emissive_layers: &[],
    // rust: clouds: f.clouds.as_ref().map(|c| crate::clouds::Input {
    // rust: texture: &c.texture,
    // rust: uv: c.uv,
    // rust: camera: DVec3::from_array(c.camera),
    // rust: time: c.time,
    // rust: partial_tick: c.partial_tick,
    // rust: range: c.range,
    // rust: fast: c.fast,
    // rust: color: c.color,
    // rust: }),
    // rust: lightning: Default::default(),
    // rust: additive: &[],
    // rust: see_through: &[],
    // rust: world_primitives: Default::default(),
    // rust: shadow_only: &[],
    // rust: celestial: &self.celestial,
    // rust: stars: f
    // rust: .stars
    // rust: .map(|(rotation, brightness)| (Mat4::from_cols_array(&rotation), brightness)),
    // rust: hand: &[],
    // rust: hand_fov_degrees: f.hand_fov_degrees,
    // rust: screen: &[],
    // rust: pack: Default::default(),
    // rust: border: None,
    // rust: game_time: f.game_time,
    // rust: shader_game_time: f.shader_game_time,
    // rust: end_portal_sprites: f.end_portal_sprites,
    // rust: crumbling_sprite: f.crumbling_sprite,
    // rust: ticks: f.ticks,
    // rust: darkness: f.darkness,
    // rust: night_vision: f.night_vision,
    // rust: block_flicker: f.block_flicker,
    // rust: boss_darken: f.boss_darken,
    // rust: chunk_fade: 0.0,
    // rust: post_effects: crate::post_chain::Request::none(),
    // rust: menu_blur: None,
}
}
}
