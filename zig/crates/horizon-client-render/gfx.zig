//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_gfx
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! GPU renderer for streamed terrain sections, sky, block outline and HUD.
//! Section origins are supplied relative to the camera each frame so large
//! world coordinates keep full precision.
// use crate::{
    // rust: Result,
    // rust: block_entity_render::{StaticCacheFrameStats, StaticSectionRevision, StaticSectionSnapshot},
    // rust: environment::Sky,
    // rust: fast_hash::FxHashMap,
    // rust: graphics::GraphicsApi,
    // rust: hud::{HudBatch, HudRenderer},
    // rust: mesher::{Part as Quads, SectionMesh, Sides, TerrainVertex, Vertex, packed},
    // rust: section_mask::SectionMask,
    // rust: sprites::SpriteAnimation,
}
// use glam::{DVec3, Mat4, Vec3, Vec4};
// use std::{collections::HashMap, path::PathBuf, sync::Arc, time::Instant};
// use wgpu::util::DeviceExt;
// use winit::window::Window;

// RenderPipelines.CRUMBLING: dst * src + src * dst, alpha replaced.
    // rust: const CRUMBLING_BLEND: wgpu::BlendState = wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::Dst,
    // rust: dst_factor: wgpu::BlendFactor::Src,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: alpha: wgpu::BlendComponent::REPLACE,
}
/// `TerrainVertex` for `vs_terrain`: position, UV, layer, light, colour.
    // rust: const TERRAIN_ATTRIBUTES: [wgpu::VertexAttribute; 5] =
    // rust: wgpu::vertex_attr_array![0=>Float32x3,1=>Uint16x2,2=>Uint16,4=>Uint8x2,3=>Unorm8x4];

/// entity.wgsl after the OverlayTexture constants it reads.
pub fn entity_shader() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::overlay::wgsl_constants() + include_str!("entity.wgsl")
}

/// The static block-entity vertex entry point shares entity shading but lives
/// in its own source file and pipeline.
pub fn static_entity_shader() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: entity_shader() + include_str!("static_entity.wgsl")
}

    // rust: mod crumbling_tests;
    // rust: mod entity_batch;
    // rust: mod entity_outline;
    // rust: mod inter_stage_tests;
    // rust: pub(crate) mod test_gpu;
    // rust: mod weather;
    // rust: mod world_text;
// use entity_batch::EntityBatch;
    // rust: pub use entity_batch::{
    // rust: DISSOLVE_OVERLAY, DRAGON_RAYS_OVERLAY, ENERGY_SWIRL_OVERLAY, OIT_ENTITY, SHADOW_OVERLAY,
    // rust: TEXT_POLYGON_OFFSET_OVERLAY, TRANSLUCENT_GLINT_ITEM_OVERLAY, TRANSLUCENT_ITEM_OVERLAY,
    // rust: TRANSLUCENT_PARTICLE_OVERLAY, WATER_MASK_OVERLAY, WORLD_TEXT_OVERLAY,
    // rust: WORLD_TEXT_POLYGON_OFFSET_OVERLAY, mark_oit,
}
    // rust: pub use view::{View, ViewSet};

/// Window.getAppropriateLineWidth, in framebuffer pixels.
pub fn outline_width(width: u32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 2.5f32.max(width as f32 / 1920.0 * 2.5)
}

/// ScreenSize, stroke width and ProjectionType.PERSPECTIVE layering.
pub fn outline_params(width: u32, height: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: width as f32,
    // rust: height.max(1) as f32,
    // rust: outline_width(width),
    // rust: 1.0 - 1.0 / 4096.0,
    // rust: ]
}

/// Camera-relative segment endpoints; no shape expansion in vanilla 26.3.
pub fn outline_vertices(edges: *[[f64; 6]], camera: glam::DVec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: edges
    // rust: .iter()
    // rust: .map(|e| std::array::from_fn(|i| (e[i] - camera.to_array()[i % 3]) as f32))
    // rust: .collect()
}

/// Whether the renderer should initialize its occlusion culling pass (`cull`).
///
/// Software adapters spend more time running the culling pass than drawing
/// the sections it removes. Keep the pass available for explicit A/B checks,
/// while leaving hardware adapters on the existing default.
pub fn occlusion_culling_requested(info: *wgpu::AdapterInfo, env: ?[]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: env != Some("0") && (env.is_some() || info.device_type != wgpu::DeviceType::Cpu)
}

/// `DrawableGizmoPrimitives.getGroup`: a line whose ARGB alpha is 255 joins the
/// opaque group, drawn with `RenderTypes.lines` (depth written); the rest
/// with `RenderTypes.linesTranslucentNoDepthWrite`.
pub fn debug_line_opaque(line: *[f32; 8]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: line[6].to_bits() >> 24 == 0xFF
}

/// The depth-tested gizmo lines in their upload order: the opaque group first,
/// then the translucent one, each in submission order.
pub fn debug_lines_opaque_first(lines: *[[f32; 8]]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let opaque = lines.iter().filter(|l| debug_line_opaque(l));
    // rust: opaque.chain(lines.iter().filter(|l| !debug_line_opaque(l)))
}

/// Whether Translucent Batching is offered (`graphics::offer_translucent_batching`): where
/// indirect multi-draws (`multi_draw`) take its batches, but not OpenGL's, which loop over
/// their entries on the CPU (and without them every section is a call of its own anyway).
/// Frames drawn flat (Metal, Intel Gen11/Gen12's Vulkan driver) take it too: their
/// translucent calls then come one per page of its arena rather than about one per section.
pub fn translucent_batchable(info: *wgpu::AdapterInfo, multi_draw: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: multi_draw && info.backend != wgpu::Backend::Gl
}

/// The vertices flat draws bind for a call's page key: a page of the section arena, or of
/// the translucent arena up to its last range in use (`flat::TRANSLUCENT_KEYS`).
    // rust: fn flat_vertices<'a>(
    // rust: arena: &'a arena::Arena,
    // rust: translucent: Option<&'a arena::Arena>,
    // rust: ) -> impl Fn(u32) -> wgpu::BufferSlice<'a> + Copy {
    // rust: move |key| match (translucent, key.checked_sub(flat::TRANSLUCENT_KEYS)) {
    // rust: (Some(translucent), Some(page)) => translucent.binding(page),
    // rust: _ => arena.buffer(key).slice(..),
}
}

/// Bytes of `texture` with every mip level of every layer.
    // rust: pub(crate) fn texture_bytes(texture: &wgpu::Texture) -> u64 {
    // rust: let size = texture.size();
    // rust: let block = u64::from(texture.format().block_copy_size(None).unwrap_or(4));
    // rust: (0..texture.mip_level_count())
    // rust: .map(|level| {
    // rust: let side = |v: u32| u64::from((v >> level).max(1));
    // rust: side(size.width) * side(size.height) * block
    // rust: })
    // rust: .sum::<u64>()
    // rust: * u64::from(size.depth_or_array_layers)
}

/// Whether translucent quads have an arena of their own: with Translucent Batching
/// (`batching`), unless a shader pack's frames can draw terrain flat (as for `flat_frame`),
/// which reads them in the section arena through its tables: where flat draws exist and
/// are on (`flat_draws`), for a `shaders/` pack's terrain programs (`terrain`) or a shadow
/// pass (`shadow`: a `shaders/` pack's, or the `[shadow]` of one of Horizon's own).
pub fn translucent_split(batching: bool, flat_draws: bool, terrain: bool, shadow: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: batching && !(flat_draws && (terrain || shadow))
}

/// The compact layout of solid quads, unless `HORIZON_PACKED_QUADS=0` (A/B checks).
pub fn packed_wanted() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::var("HORIZON_PACKED_QUADS").as_deref() != Ok("0")
}

    // rust: mod animate;
    // rust: mod arena;
    // rust: pub mod capture;
    // rust: pub mod compositor;
    // rust: pub(crate) mod core_lines;
    // rust: mod cull;
    // rust: mod end_sky;
    // rust: pub mod entity_skin;
    // rust: mod flat;
    // rust: mod frame_gen;
    // rust: mod gpu_culling;
    // rust: mod hdr;
    // rust: mod hdr_icc;
    // rust: mod hdr_stats;
    // rust: pub use hdr::Calibration as HdrCalibration;
    // rust: pub mod block_light;
    // rust: mod displace;
    // rust: pub mod lightning;
    // rust: mod lod;
    // rust: mod native_material;
    // rust: mod native_pack;
    // rust: mod native_post;
    // rust: pub mod native_render;
    // rust: mod native_shadow;
    // rust: mod native_sky;
    // rust: mod occlusion;
    // rust: mod oit;
    // rust: mod oit_features;
    // rust: mod pack_atlas;
    // rust: mod pack_center_depth;
    // rust: pub mod pack_draw;
    // rust: mod pack_entities;
    // rust: mod pack_hand;
    // rust: mod pack_images;
    // rust: mod pack_lines;
    // rust: mod pack_post;
    // rust: mod pack_shadow;
    // rust: mod pack_sky;
    // rust: mod pack_textures;
    // rust: pub(crate) mod pack_timing;
    // rust: pub mod pack_uniforms;
    // rust: mod pack_weather;
    // rust: mod page_runs;
    // rust: pub mod panorama;
    // rust: mod readback;
    // rust: mod resident;
    // rust: mod reuse;
    // rust: mod stars;
    // rust: pub mod submit;
    // rust: mod sunrise_fan;
    // rust: mod timing;
    // rust: pub mod translucency;
    // rust: pub(crate) mod upload;
    // rust: mod view;
    // rust: mod visbuffer;
    // rust: mod wgsl_prefix;
    // rust: mod world_post;
    // rust: pub mod world_primitives;

/// A section's instance: its camera-relative origin and, in `w`, the step of
/// its fixed-point UVs (`terrain.wgsl`'s `terrain_uv`).
/// The world pass again after occlusion culling's test: it loads both
/// targets (phase 2 draws over phase 1, reading the test's results).
/// `LevelRenderer.addSkyPass`: fluids and camera effects block the sky pass.
pub fn sky_open(frame: *Frame) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !frame.sky_blocked
}

/// The Overworld-style sky (disc, sunset, stars, void) draws this frame.
pub fn sky_visible(frame: *Frame) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !frame.title && frame.skybox && sky_open(frame)
}

/// The world pass's part that draws a shader pack's solid terrain: the world's colour and
/// depth loaded, and its `surface` target, cleared on the first of these passes.
    // rust: fn surface_pass<'e>(
    // rust: encoder: &'e mut wgpu::CommandEncoder,
    // rust: view: &wgpu::TextureView,
    // rust: surface: &wgpu::TextureView,
    // rust: depth: &wgpu::TextureView,
    // rust: clear: bool,
    // rust: ) -> wgpu::RenderPass<'e> {
    // rust: let keep = |load| wgpu::Operations {
    // rust: load,
    // rust: store: wgpu::StoreOp::Store,
}
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Horizon world, pack terrain"),
    // rust: color_attachments: &[
    // rust: Some(wgpu::RenderPassColorAttachment {
    // rust: view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: keep(wgpu::LoadOp::Load),
    // rust: }),
    // rust: Some(wgpu::RenderPassColorAttachment {
    // rust: view: surface,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: keep(if clear {
    // rust: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT)
    // rust: } else {
    // rust: wgpu::LoadOp::Load
    // rust: }),
    // rust: }),
    // rust: ],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: })
}
    // rust: fn world_pass_after_culling<'e>(
    // rust: encoder: &'e mut wgpu::CommandEncoder,
    // rust: view: &wgpu::TextureView,
    // rust: depth: &wgpu::TextureView,
    // rust: keep_depth: bool,
    // rust: timing: Option<&mut pack_timing::PassTiming>,
    // rust: name: &str,
    // rust: ) -> wgpu::RenderPass<'e> {
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Horizon world, after culling"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes(name)),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
                // A shader pack reads it as depthtex0.
    // rust: store: if keep_depth {
    // rust: wgpu::StoreOp::Store
    // rust: } else {
    // rust: wgpu::StoreOp::Discard
    // rust: },
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: })
}
/// The point a `shaders/` pack's terrain is drawn relative to: the camera with the fraction of
/// each coordinate rounded to the nearest 1/65536 block. Read back with a probe pack of ours,
/// Iris 1.11.7's terrain `gl_Vertex` is the block's position minus this, for cameras from 13
/// to 40000 blocks out (#8464); `cameraPosition` and the matrices keep the exact camera. Off by
/// up to 2^-17 blocks, a fragment on a texel boundary of the shadow map reads the other texel.
pub fn pack_terrain_camera(camera: DVec3) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let whole = camera.floor();
    // rust: whole + ((camera - whole) * 65536.0).round() / 65536.0
}
/// A section's instance: its camera-relative origin and its UV step, negated
/// past its fade code while it fades in over far terrain (`lod::instance`).
pub fn section_instance(origin: [f32; 3], fade: u32, visibility: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let step = 1.0 / crate::mesher::UV_STEPS;
    // rust: [
    // rust: origin[0],
    // rust: origin[1],
    // rust: origin[2],
    // rust: if fade == 0 {
            // The step is a power of two, so its mantissa is free: it holds the vanilla
            // chunk fade-in's `1 - visibility` in 23 bits (terrain.wgsl's `instance_step` and
            // `instance_visibility` read it back). A whole section is the bare step.
    // rust: let faded = ((1.0 - visibility) * 8_388_608.0)
    // rust: .round()
    // rust: .clamp(0.0, 8_388_607.0) as u32;
    // rust: f32::from_bits(step.to_bits() | faded)
    // rust: } else {
    // rust: -(fade as f32 + step)
    // rust: },
    // rust: ]
}
/// `SectionRenderDispatcher.RenderSection.getVisibility`: how far through its fade-in a section
/// uploaded `elapsed_ms` ago is.
pub fn chunk_visibility(elapsed_ms: u64, fade_ms: u64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if elapsed_ms >= fade_ms {
    // rust: 1.0
    // rust: } else {
    // rust: elapsed_ms as f32 / fade_ms as f32
}
}
/// `Util.toMillis`: `Mth.floor(seconds * 1000.0)`.
pub fn fade_millis(seconds: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (f64::from(seconds) * 1000.0).floor().max(0.0) as u64
}
/// `chunk_visibility` at `now` of a section first uploaded at `uploaded`
/// (`Renderer::section_uploaded`; none: one that fades in over far terrain, or
/// whose column left), with the chunk fade-in `fade_ms`.
pub fn section_visibility(uploaded: ?*Instant, fade_ms: u64, now: Instant) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: uploaded.map_or(1.0, |&t| {
    // rust: let elapsed = now.saturating_duration_since(t).as_millis() as u64;
    // rust: chunk_visibility(elapsed, fade_ms)
    // rust: })
}
/// What a section's fade depends on besides the section itself
/// (`SectionGpu::drawn_faded`): the time, the chunk fade-in time, the sections'
/// first uploads (`Renderer::section_uploaded`) and those held while far
/// terrain comes in (`Renderer::lod_retiring`).
pub const FadeInputs = struct {
    now: Instant,
    fade_ms: u64,
    uploaded: *'a FxHashMap<SectionKey,
    retiring: *'a crate::fast_hash::FxHashSet<SectionKey>,
};
/// `LevelRenderer.CHUNK_VISIBILITY_THRESHOLD`: a section's block entities wait for it.
pub const CHUNK_VISIBILITY_THRESHOLD: f32 = 0.3;
/// A new value for `Renderer::block_entity_revision`.
pub fn next_block_entity_revision() u {
    // Implementation ported from Horizon
    return undefined;
}
pub const NEXT: std::sync::atomic::AtomicU64 = std::sync::atomic::AtomicU64::new(0);
    // rust: NEXT.fetch_add(1, std::sync::atomic::Ordering::Relaxed)
}

pub const Globals = struct {
    view_proj: [[f32,
    fog_color: [f32,
    fog: [f32,
    sky_color: [f32,
    misc: [f32,
    inverse_view: [[f32,
    sunrise: [f32,
    sun: [f32,
    /// x: sky fog end, y: cloud fog end, z: dark disc (camera below the horizon),
    /// w: the glint strength (`GlintAlpha`).
    fog_ends: [f32,
    /// Atlas rects (u0, v0, width, height) of end_sky.png and end_portal.png.
    end_portal_sprites: [[f32,
    /// x: vanilla's `GameTime` uniform; y: nether cardinal lighting; z: how many
    /// `dynamic_lights` are set; w: the glint scroll clock (`Glint::scroll_ticks`).
    time: [f32,
    /// Atlas rect of a destroy stage (entity.wgsl takes only its size: every stage's is the same,
    /// and each crack carries its own stage's origin).
    crumbling_sprite: [f32,
    /// Framebuffer size, selection stroke width, perspective layering scale.
    outline_params: [f32,
    /// Horizon Extras' dynamic lights: camera-relative position and level (`dynamic_light`).
    dynamic_lights: [[f32,
    colored_lights: [crate::dynamic_light::Colored,
    colored_count: [u32,
    emissive_layers: [[u32,
    emissive_count: [u32,
    /// The sunrise fan's triangles as the sky shader tests them (`sunrise_fan::normals`).
    sunrise_fan: [[f32,
    /// x: `Options.textureFiltering` (0 none, 1 RGSS, 2 anisotropic); y: the sprite arrays' width;
    /// z: the mip level at which a sprite is one texel, when the views reach it, else 0.
    filtering: [f32,
    /// HDR output's tier windows, low to very bright: where the lift starts, where it is
    /// full (`hdr::Hdr::windows`); zero without HDR.
    hdr_windows: [[f32,
    hdr_light: [f32,
};
pub const StaticEntityUniform = struct {
    camera_block: [i32,
    camera_fraction: [f32,
};
pub const GpuStaticEntitySection = struct {
    buffer: wgpu::Buffer,
    origin_buffer: wgpu::Buffer,
    origin: [i32,
    capacity: u64,
    revision: u64,
    vertices: u32,
};
    // rust: pub type SectionKey = (i32, i32, i32);
/// The water mirror's targets: the world as a camera mirrored about the water plane sees
/// it, at half the world's resolution (the material stage's `reflection`).
pub const MirrorTarget = struct {
    size: [u32,
    color: wgpu::TextureView,
    depth: wgpu::TextureView,
};
pub const SectionGpu = struct {
    /// Arena page and first vertex of its solid quads, and after them its
    /// translucent quads unless those have an arena of their own; (0, 0),
    /// unused, when that leaves it no quads in `arena`.
    page: u32,
    start: u64,
    /// The page and first vertex of its translucent quads: in
    /// `translucent_arena` when there is one, else after the solid quads.
    /// Unused without translucent quads.
    translucent_at: (u32,
    solid: u32,
    /// Slots its solid quads take in `arena`: four vertices each, or in the compact layout
    /// (`packed`, `mesher::packed`) a record each and the vertices of those without one.
    solid_slots: u64,
    packed: bool,
    /// Where the solid quads' buckets by facing side end (`mesher::Sides`).
    sides: Sides,
    translucent: u32,
    sort: translucency::SortState,
    sorted_indices: Option<(u32,
    /// Its id for flat draws (`flat::Flat::add`), when they are on.
    flat_id: ?u32,
    /// Its record's id in GPU culling's table (`gpu_culling::Records`), while
    /// that is on and it has solid quads.
    gpu_id: ?u32,
    /// Its record is `FADING` (GPU culling on): the CPU draws its solid quads
    /// while its instance carries a fade (`drawn_faded`), and GPU culling's
    /// pass leaves it out.
    gpu_fading: bool,
    /// When it began to fade in over the far terrain it replaces, which
    /// stays whole behind it until then: a section new where far tiles are
    /// drawn. Meshed again, it stays as it was.
    fading: ?std::time::Instant,
    /// When it began to fade out, its column gone over far terrain that
    /// stays behind it (`Renderer::leave_section`); released once it has.
    leaving: ?std::time::Instant,
    /// Animated sprite layers present in this section.
    animated_layers: *[u16],
};
/// Extracts the animated sprite layers present in a section mesh. Meshing
/// records the distinct layers, so uploading does not rescan every vertex.
    // rust: pub(crate) fn collect_animated_layers(
    // rust: mesh: &SectionMesh,
    // rust: is_animated: impl Fn(u16) -> bool,
    // rust: ) -> Box<[u16]> {
    // rust: mesh.sprite_layers
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&layer| is_animated(layer))
    // rust: .collect()
}

    // rust: impl SectionGpu {
    /// Its fade code this frame (`lod::fade_code`), 0 once whole. `retiring`:
    /// its column has left the render distance, far terrain is coming in
    /// under it (`lod::HELD`).
pub fn fade(self: *Self, now: std::time::Instant, retiring: bool) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.leaving {
    // rust: Some(since) => lod::fade_out_code(since, 0, now),
    // rust: None if retiring => lod::HELD,
    // rust: None => self
    // rust: .fading
    // rust: .and_then(|since| lod::fade_code(Some(since), 0, now))
    // rust: .unwrap_or(0),
}
}
    /// Its vertices in `arena`, and in `translucent_arena` when `split` (there
    /// is one): (page, first vertex, vertices) of each.
pub fn vertex_ranges(self: *Self, split: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !split {
    // rust: let vertices = self.solid_slots + u64::from(self.translucent) * 4;
    // rust: return (Some((self.page, self.start, vertices)), None);
}
    // rust: let (page, start) = self.translucent_at;
    // rust: (
    // rust: (self.solid > 0).then_some((self.page, self.start, self.solid_slots)),
    // rust: (self.translucent > 0).then(|| (page, start, u64::from(self.translucent) * 4)),
    // rust: )
}
    /// Whether GPU culling keeps a record of it at `key` while it is on (`gpu_id`):
    /// it has solid quads, in one of the level's `sections`, which the pass's
    /// tables span.
pub fn gpu_recorded(self: *Self, key: SectionKey, sections: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.solid > 0 && (0..sections as i32).contains(&key.1)
}
    /// The base vertex of its solid draws: quad `q`'s corners are `base + 4 * q` on (the
    /// quad indices). In the compact layout they name its record's slot past
    /// `PACKED_BASE` (terrain.wgsl's `section_corner`).
pub fn solid_base(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.packed {
    // rust: packed::PACKED_BASE + 4 * self.start as u32
    // rust: } else {
    // rust: self.start as u32
}
}
    /// GPU culling's record of it at `key`, its quads within `bounds`
    /// (`SectionMesh::bounds`) and in their buckets by facing side (`sides`),
    /// `FADING` while it fades (`gpu_fading`).
pub fn record(self: *Self, key: SectionKey, bounds: ?[Vec3; 2]) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let boxed = gpu_culling::rounded_box(bounds);
    // rust: gpu_culling::Record::new(
    // rust: key,
    // rust: self.page,
    // rust: u64::from(self.solid_base()),
    // rust: self.solid,
    // rust: boxed,
    // rust: )
    // rust: .facing(&self.sides)
    // rust: .fading(self.gpu_fading)
}
    /// Whether GPU frames' walk lists it within the render distance
    /// (`Resident::walk`): its mark. Its translucent quads are the CPU's, or
    /// GPU culling can have no record of it, which holds whether GPU culling is
    /// on or not; or, while it is, its solid quads are the CPU's while it fades
    /// (`gpu_fading`).
pub fn listed(self: *Self, key: SectionKey, sections: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.translucent > 0 || !self.gpu_recorded(key, sections) || self.gpu_fading
}
    /// Whether GPU culling draws its solid quads in a GPU frame, `near`: its
    /// column within the render distance.
pub fn gpu_draws_solid(self: *Self, near: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: near && self.gpu_id.is_some() && !self.gpu_fading
}
    /// Whether frames draw it faded at `f.now`: its instance, as the instance
    /// loop makes it (`section_instance` with its `fade` and its vanilla
    /// visibility), is not a whole section's. As time goes on a fade only ends:
    /// once false, this stays false until the section is meshed again, leaves,
    /// is held (`lod_retiring`), or the chunk fade-in time changes.
pub fn drawn_faded(self: *Self, key: SectionKey, f: FadeInputs<'_>) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let fade = self.fade(f.now, f.retiring.contains(&key));
    // rust: let visibility = section_visibility(f.uploaded.get(&key), f.fade_ms, f.now);
    // rust: section_instance([0.0; 3], fade, visibility)[3].to_bits()
    // rust: != section_instance([0.0; 3], 0, 1.0)[3].to_bits()
}
    /// When its fade is over at the latest (`drawn_faded`): the later of the
    /// ends of its fade-in over far terrain (`fading` and `lod::FADE`, a few
    /// milliseconds after `fade` reaches 0) and of vanilla's (its first upload
    /// and `f.fade_ms`). None while it leaves or is held, which ends only when
    /// it goes or is meshed again, and without either fade-in.
pub fn fade_end(self: *Self, key: SectionKey, f: FadeInputs<'_>) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.leaving.is_some() || f.retiring.contains(&key) {
    // rust: return None;
}
    // rust: let vanilla = f.uploaded.get(&key).filter(|_| f.fade_ms > 0);
    // rust: let vanilla = vanilla.map(|&t| t + std::time::Duration::from_millis(f.fade_ms));
    // rust: vanilla.max(self.fading.map(|t| t + lod::FADE))
}
}
/// Which of a mesh's ranges `move_off_page` moves: what it holds in the section
/// arena (`split`: its solid quads alone, `SectionGpu::vertex_ranges`), its
/// translucent quads in `translucent_arena`, or its sorted indices.
pub const Part = enum {
    Section { split: bool },
    Translucent,
    Indices,
};
    // rust: impl Part {
    /// (page, first vertex or index, count), as the release paths free it.
pub fn of(self: *Self, s: *SectionGpu) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Section { split } => s.vertex_ranges(split).0,
    // rust: Self::Translucent => s.vertex_ranges(true).1,
    // rust: Self::Indices => s
    // rust: .sorted_indices
    // rust: .map(|(page, at)| (page, at, u64::from(s.translucent) * 6)),
}
}
    /// Points the mesh where its range moved.
pub fn set(self: *Self, s: *mut SectionGpu, to: (u32) void {
}
    // rust: match self {
    // rust: Self::Section { split } => {
    // rust: (s.page, s.start) = to;
    // rust: if !split {
                    // Its translucent quads came along, after the solid ones.
    // rust: s.translucent_at = (to.0, to.1 + s.solid_slots);
}
}
    // rust: Self::Translucent => s.translucent_at = to,
    // rust: Self::Indices => s.sorted_indices = Some(to),
}
}
}
/// `Renderer::compact_arena`'s and `shrink_translucent`'s moves: what the meshes
/// hold on `page` of `arena` (`part`) goes to its other pages in video memory,
/// until the next range would pass `budget` bytes (it keeps what is left; the
/// first range moves whatever its size, so none keeps the page closed), the
/// copies into `encoder`, the ranges' flat draw ids (`flat`) and, in the
/// section arena, GPU culling's records (`records`) along. False when the other
/// pages have no room left.
    // rust: fn move_off_page<'a>(
    // rust: arena: &mut arena::Arena,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: mut flat: Option<(&mut flat::Flat, &wgpu::Device, &mut upload::Uploads)>,
    // rust: mut records: Option<&mut gpu_culling::Records>,
    // rust: meshes: impl Iterator<Item = &'a mut SectionGpu>,
    // rust: page: u32,
    // rust: part: Part,
    // rust: budget: &mut u64,
    // rust: ) -> bool {
    // rust: debug_assert!(
    // rust: records.is_none() || matches!(part, Part::Section { .. }),
    // rust: "records follow the section arena's ranges"
    // rust: );
    // rust: let mut moved = false;
    // rust: for s in meshes {
        // Nothing of a mesh here: split, one without solid quads (its (0, 0) is no
        // range of page 0); in the other arenas, one without translucent quads.
    // rust: let Some((_, start, vertices)) = part.of(s).filter(|r| r.0 == page) else {
    // rust: continue;
}
    // rust: let bytes = vertices * arena.stride();
    // rust: if moved && bytes > *budget {
    // rust: break;
}
    // rust: let Some(to) = arena.alloc_moved(vertices) else {
    // rust: return false;
}
    // rust: arena.copy(encoder, (page, start), to, vertices);
    // rust: arena.release(page, start, vertices);
    // rust: if let (Some((flat, device, uploads)), Some(id)) = (&mut flat, s.flat_id) {
    // rust: let key = match part {
    // rust: Part::Translucent => to.0 + flat::TRANSLUCENT_KEYS,
    // rust: _ => to.0,
}
    // rust: flat.place(device, encoder, uploads, id, key, to.1, vertices);
}
    // rust: part.set(s, to);
        // Its solid quads start the range in either layout.
    // rust: if let (Part::Section { .. }, Some(records), Some(id)) =
    // rust: (part, records.as_deref_mut(), s.gpu_id)
    // rust: {
    // rust: records.relocate(id, to.0, u64::from(s.solid_base()));
}
    // rust: *budget = budget.saturating_sub(bytes);
    // rust: moved = true;
}
    // rust: true
}
/// Starts moving a page of a large arena far larger than its ranges in use
/// (`Arena::oversized`) into a new page of the size they get (`Arena::open_page`),
/// for `Renderer::shrink_translucent`: the page closes and `move_off_page` empties
/// it. None: no page to shrink. False, and nothing changes: no video memory for
/// the new page, or a range there without its mesh in `meshes`, which would keep
/// the page from ever emptying.
    // rust: fn begin_shrink<'a>(
    // rust: arena: &mut arena::Arena,
    // rust: device: &wgpu::Device,
    // rust: meshes: impl Iterator<Item = &'a mut SectionGpu>,
    // rust: part: Part,
    // rust: ) -> Option<bool> {
    // rust: let (page, capacity) = arena.oversized()?;
    // rust: let held: u64 = meshes
    // rust: .filter_map(|s| part.of(s).filter(|r| r.0 == page))
    // rust: .map(|(.., n)| arena::Arena::span(n))
    // rust: .sum();
    // rust: debug_assert_eq!(held, arena.used(page), "a range in use without its mesh");
    // rust: if held != arena.used(page) || !arena.open_page(device, capacity) {
    // rust: return Some(false);
}
    // rust: arena.close(page);
    // rust: Some(true)
}
/// GPU culling's flag (`SectionGpu::gpu_fading`) for its recorded section `s`
/// at `key`, decided at `f.now`: whether it draws faded (`drawn_faded`), and if
/// time ends that, its end waited for in `fades` (`fade_end`).
    // rust: fn decide_fade(
    // rust: s: &SectionGpu,
    // rust: key: SectionKey,
    // rust: fades: &mut gpu_culling::Fades,
    // rust: f: FadeInputs<'_>,
    // rust: ) -> bool {
    // rust: let fading = s.drawn_faded(key, f);
    // rust: if let Some(end) = s.fade_end(key, f).filter(|_| fading) {
    // rust: fades.push(end, key);
}
    // rust: fading
}
/// GPU culling: the section at `key` began to fade out over far terrain
/// (`Renderer::leave_section`), or is held while far terrain comes in
/// (`Renderer::lod_retiring`). It draws faded until it goes or is meshed again,
/// so its record is flagged and the CPU draws it, with no end to wait for.
    // rust: fn hold_fading(
    // rust: sections: &mut resident::Resident<SectionGpu>,
    // rust: records: &mut gpu_culling::Records,
    // rust: key: SectionKey,
    // rust: ) {
    // rust: let Some(s) = sections.find_mut(key).filter(|s| !s.gpu_fading) else {
    // rust: return;
}
    // rust: let Some(id) = s.gpu_id else {
    // rust: return;
}
    // rust: s.gpu_fading = true;
    // rust: records.set_fading(id, true);
    // rust: sections.set_marked(key, true);
}
/// GPU culling switched off (`Renderer::set_gpu_culling`): no section keeps a
/// record or a flag, and those it flagged get back the walk marks they have
/// while it is off (`SectionGpu::listed`). `rows`: the level's sections.
pub fn forget_records(sections: *mut resident::Resident<SectionGpu>, rows: usize) void {
}
    // rust: let mut marks = Vec::new();
    // rust: for (key, s, _) in sections.iter_mut() {
    // rust: s.gpu_id = None;
    // rust: if std::mem::take(&mut s.gpu_fading) {
    // rust: marks.push((key, s.listed(key, rows)));
}
}
    // rust: for (key, marked) in marks {
    // rust: sections.set_marked(key, marked);
}
}
/// GPU culling's fading sections brought up to `f.now`, before a frame's gate
/// and `prepare`: every recorded section anew when the flags were decided with
/// another chunk fade-in time (GPU culling just switched on, or Video Settings
/// changed it), else those whose fade was due to end, handed back to the GPU if
/// whole by then. A section's record (`FADING`) and its walk mark follow its
/// `gpu_fading`. `rows`: the level's sections.
    // rust: fn mark_fades(
    // rust: sections: &mut resident::Resident<SectionGpu>,
    // rust: records: &mut gpu_culling::Records,
    // rust: fades: &mut gpu_culling::Fades,
    // rust: rows: usize,
    // rust: f: FadeInputs<'_>,
    // rust: ) {
    // rust: let mut marks = Vec::new();
    // rust: if fades.fade_ms != Some(f.fade_ms) {
    // rust: fades.clear();
    // rust: fades.fade_ms = Some(f.fade_ms);
    // rust: for (key, s, _) in sections.iter_mut() {
    // rust: let Some(id) = s.gpu_id else {
    // rust: continue;
}
    // rust: let fading = decide_fade(s, key, fades, f);
    // rust: if fading != s.gpu_fading {
    // rust: s.gpu_fading = fading;
    // rust: records.set_fading(id, fading);
    // rust: marks.push((key, s.listed(key, rows)));
}
}
    // rust: } else {
    // rust: while let Some(key) = fades.pop_due(f.now) {
            // Gone since, or no longer flagged.
    // rust: let Some(s) = sections.find_mut(key).filter(|s| s.gpu_fading) else {
    // rust: continue;
}
            // Still fading: meshed again since, with its own end waited for
            // (`decide_fade`), or leaving or held, with none.
    // rust: if s.drawn_faded(key, f) {
    // rust: continue;
}
    // rust: s.gpu_fading = false;
    // rust: records.set_fading(s.gpu_id.expect("flagged sections have records"), false);
    // rust: marks.push((key, s.listed(key, rows)));
}
}
    // rust: for (key, marked) in marks {
    // rust: sections.set_marked(key, marked);
}
}
/// Line segments the hit outline can hold.
pub const MAX_OUTLINE_EDGES: u64 = 256;
/// Staging buffer size for section meshes: a frame of uploads while
/// exploring fits in a few.
pub const SECTION_UPLOAD_CHUNK: u64 = 4 << 20;
/// Section copies are submitted early past this many staged bytes, which
/// bounds the staging memory frames that are not drawn can hold.
pub const SECTION_COPY_LIMIT: u64 = 64 << 20;
/// What compaction copies in a frame, `compact_arena` first and
/// `shrink_translucent` with what it left, and a range more where a call's
/// first is larger (`move_off_page`): a page empties over a few frames, with
/// no hitch.
pub const COMPACT_BUDGET: u64 = 32 << 20;
/// A large translucent page starts to shrink (`Renderer::shrink_translucent`)
/// this long after terrain last arrived, and `SHRINK_RETRY` after a try found
/// no room.
/// `Renderer::remove_columns` filters each store once rather than looking up every
/// section key from this many keys, or from as many as there are resident sections.
pub const BULK_REMOVAL_KEYS: usize = 256;
pub const SHRINK_SETTLE: std::time::Duration = std::time::Duration::from_secs(1);
pub const SHRINK_RETRY: std::time::Duration = std::time::Duration::from_secs(5);
/// Not before then may a large translucent page start to shrink.
pub const ShrinkGate = struct {};
    // rust: impl ShrinkGate {
    /// Not before `wait` from `now`, nor before an earlier wait is over.
pub fn wait(self: *Self, now: Instant, wait: std::time::Duration) void {
}
    // rust: self.0 = self.0.max(Some(now + wait));
}
    /// Whether one may start now: the waits are over, and `compact_arena` copied
    /// nothing this frame (it `left` the whole budget).
pub fn may_start(self: *Self, now: Instant, left: u64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: left == COMPACT_BUDGET && self.0.is_none_or(|at| now >= at)
}
}
pub const Frame = struct {
    camera: DVec3,
    yaw: f32,
    pitch: f32,
    fov_degrees: f32,
    /// The camera entity's eye and view rotation (yaw, pitch): the camera's own except in a
    /// third-person view.
    eye: DVec3,
    eye_rotation: [f32,
    /// The camera is the entity's eye: no third-person view.
    first_person: bool,
    /// The `GameRenderer.bobHurt`/`bobView` pose multiplied into the
    /// projection (`crate::camera::bob_matrix`).
    bob: Mat4,
    /// The spinning effect multiplied into the level's projection only
    /// (`crate::camera::spinning_effect_matrix`), not the hand's.
    spin: Mat4,
    sky: Sky,
    /// Block edits and chunk membership that can change the shader pack's shadow map.
    shadow_scene_revision: (u64,
    /// Opt-in reuse of the shader pack's last shadow map when the key still matches
    /// (`horizon-graphics.txt` `shadowCache`; off by default).
    shadow_cache: bool,
    /// Render distance in blocks (fog end).
    distance: f32,
    /// Full-detail terrain distance in blocks; distant LODs bypass the cave graph.
    detail_distance: f32,
    /// `Camera.depthFar`: the far plane (`crate::camera::depth_far`).
    depth_far: f32,
    underwater: bool,
    /// The y of the horizontal water plane around the camera, in world blocks, while one
    /// of Horizon's own packs reads the water mirror (`Game::water_plane`,
    /// `Renderer::wants_water_plane`).
    water_plane: ?f32,
    /// Skip sections the camera cannot see through open faces (vanilla's
    /// occlusion graph; off in spectator-like views inside blocks).
    cave_culling: bool,
    /// Title screen: only the dedicated panorama cube map and the HUD.
    title: bool,
    /// Lava, powder snow, blindness or darkness blocks the sky pass.
    sky_blocked: bool,
    /// Dimensions without a skybox (the Nether) clear to the fog colour.
    skybox: bool,
    /// The End: clear to black and draw the resident sky box behind the world.
    end_sky: bool,
    /// End sky atlas bounds (u0, v0, u1, v1); absent when the sprite is missing.
    end_sky_sprite: Option<[f32,
    /// Environmental fog start/end (Nether 10..96), if any.
    environment_fog: Option<(f32,
    water_fog: [f32,
    /// `FogRenderer.setupFog` result; replaces the underwater/environment fields when set.
    fog: ?crate::fog::FogData,
    /// Camera eye below the horizon height and not under water (`shouldRenderDarkDisc`).
    dark_disc: bool,
    /// The hit block outline as line segments (from, to) in world space.
    outline: Vec<[f64,
    /// `BlockOutlineRenderState.isTranslucent`: draw after translucent terrain.
    outline_after_terrain: bool,
    /// `BlockOutlineRenderState.highContrast`: a thick black outline under a bright one.
    outline_high_contrast: bool,
    /// The PvP & HUD page's outline and hit colour (`pvp::Frame`; default: vanilla's).
    pvp: crate::pvp::Frame,
    /// `lines` with a colour and pixel width (`gizmos::camera_relative`):
    /// the fishing line and debug gizmos, depth tested, then gizmos drawn
    /// over everything.
    debug_lines: *'a [[f32,
    debug_lines_on_top: *'a [[f32,
    /// `DebugCrosshairRenderer`'s axes, camera relative like `debug_lines`:
    /// drawn after the hand at its projection, without the bob or fog.
    debug_crosshair: *'a [[f32,
    hud: *'a HudBatch,
    /// `GlintAlpha` (accessibility Glint Strength); the entity shader uses it
    /// for held/world items, independent of what the HUD batch last drew.
    glint_alpha: f32,
    /// The glint scroll clock (`Glint::scroll_ticks`): entity.wgsl's
    /// `ARMOR_ENTITY_GLINT_TEXTURING` phase.
    glint_ticks: f32,
    /// CardinalLighting.Type.NETHER, otherwise DEFAULT.
    nether_lighting: bool,
    /// Camera-relative entity geometry textured from the shared atlas.
    entities: *'a [Vertex],
    /// Per-section cacheable block-entity models. Positions are section-local.
    static_block_entities: *'a [StaticSectionSnapshot],
    /// Sections currently intersecting the coarse camera frustum.
    visible_static_block_entity_sections: *'a [[i32,
    /// Cache work for this frame, reported in bench summaries.
    static_block_entity_stats: StaticCacheFrameStats,
    /// Which entity `entities`' vertices belong to: (first vertex, entity id), each run up
    /// to the next; id 0 for none. Frame generation follows these entities' own motion.
    entity_motion: *'a [(u32,
    /// The glowing entities' silhouettes in their team colours (`OutlineBufferSource`),
    /// outlined through walls after the hand.
    glowing: *'a [Vertex],
    /// Runs of `entities` by entity, while a shader pack draws them (`pack_draw::EntitySpan`).
    entity_spans: *'a [pack_draw::EntitySpan],
    /// Ordinary entity models posed on the GPU (`entity_skin`), drawn before `entities`'
    /// ordinary ones; only when `Renderer::skins_entities` said so.
    skin: ?*'a entity_skin::SkinFrame,
    weather: *'a [crate::weather::Vertex],
    weather_time: crate::weather::Time,
    /// Horizon Extras' dynamic lights, nearest first (`dynamic_light::select`); empty when off.
    dynamic_lights: *'a [[f32,
    colored_lights: *'a [crate::dynamic_light::Colored],
    emissive_layers: *'a [[u32,
    /// Cloud mesh inputs; geometry and GPU storage are retained by the renderer.
    clouds: ?crate::clouds::Input<'a>,
    /// Retained lightning bolts, drawn before the other additive entities.
    lightning: lightning::Input<'a>,
    /// Additive translucent geometry after lightning (dragon rays).
    additive: *'a [Vertex],
    /// Name tags over everything, without depth (`TEXT_SEE_THROUGH`).
    see_through: *'a [Vertex],
    /// Native mods' lines, boxes, beams and text (`native_world_primitives`), drawn at the end
    /// of the world pass, before the first-person hand.
    world_primitives: world_primitives::Batch<'a>,
    /// Opaque entity quads only a native pack's shadow pass draws (the local player in first
    /// person).
    shadow_only: *'a [Vertex],
    /// Camera-relative sun and moon, or the animated End flash (additive,
    /// behind everything and after the resident End sky box).
    celestial: *'a [Vertex],
    /// The stars, drawn from their static buffer after the sun and moon:
    /// the sky's rotation (camera-relative world from star space) and the
    /// star brightness.
    stars: Option<(Mat4,
    /// First-person hand and held item, drawn after clearing depth.
    hand: *'a [Vertex],
    /// Where the arm and each held item start in `hand` (first vertex), with the
    /// `currentRenderedItemId` a shader pack's `gbuffers_hand` reads for them.
    hand_items: *'a [(u32,
    /// `CameraRenderState.hudFov`: the hand's own field of view
    /// (`GameRenderer.render3dHud`).
    hand_fov_degrees: f32,
    /// Full-screen camera effects drawn over the world and hand, under the HUD.
    screen: *'a [crate::screen_effects::ScreenQuad],
    /// What a shader pack's uniforms need from the game.
    pack: pack_uniforms::PackInputs,
    /// The world border wall, when near enough to be drawn.
    border: ?BorderDraw,
    game_time: f32,
    /// `GlobalSettingsUniform` GameTime: (game time % 24000 + partial tick) / 24000.
    shader_game_time: f32,
    /// Atlas rects (u0, v0, width, height) of end_sky.png and end_portal.png
    /// (`rendertype_end_portal`'s Sampler0 and Sampler1).
    end_portal_sprites: [[f32,
    /// A destroy-stage sprite: projected UVs repeat inside a rect of this size, from the
    /// origin each crack vertex carries (`breaking::stage_light`).
    crumbling_sprite: [f32,
    ticks: u64,
    /// The darkness effect on the lightmap: the brightness it takes off the
    /// gamma option and the pulsing scale subtracted from the light.
    darkness: (f32,
    /// Night vision (or conduit water vision) intensity on the lightmap.
    night_vision: f32,
    /// Torch flicker added to the block light factor of 1.4.
    block_flicker: f32,
    /// `lightmap.fsh` BossOverlayWorldDarkeningFactor (a wither's bar).
    boss_darken: f32,
    /// `Screen.extractBlurredBackground`: blur the frame by this radius
    /// (`menuBackgroundBlurriness`) before the screen is drawn over it.
    menu_blur: ?f32,
    /// `Options.chunkSectionFadeInTime`, in seconds: how long a section takes to fade in once
    /// uploaded (0 draws it whole at once).
    chunk_fade: f32,
    /// `GameRenderer.requestedPostEffects`: the chains that run over the world.
    post_effects: crate::post_chain::Request<'a>,
};
/// One frame of the world border wall (`WorldBorderRenderer.render`).
pub const BorderDraw = struct {
    /// The cached wall buffer; uploaded only when `rebuilt`.
    vertices: [crate::border_render::BorderVertex,
    rebuilt: bool,
    transforms: crate::border_render::BorderTransforms,
    /// Walls to draw (indices of four-vertex quads), nearest first.
    sides: std.ArrayList(usize),
};
pub const BorderUniform = struct {
    color: [f32,
    offset: [f32,
};
/// A frame to save as a PNG: F2's screenshot, an agent's `game_screenshot`,
/// or the icon the Select World list shows.
pub const ScreenshotRequest = struct {
    path: PathBuf,
    /// `GameRenderer.takeAutoScreenshot`: centre-crop the frame to a square
    /// and average it down to this size. `None` saves the frame as drawn.
    size: Option<[u32,
    /// F2's: drawn at the game's resolution (Resolution Scale above 100%) times
    /// `Renderer::screenshot_quality`, not the window's.
    scaled: bool,
};
pub const Renderer = struct {
    instance: wgpu::Instance,
    adapter: wgpu::Adapter,
    /// The window's swapchain; `None` when rendering offscreen (`--offscreen`). Shared
    /// with frame generation's present thread while it runs.
    surface: ?*wgpu::Surface<'static>,
    /// The surface `release_surface` set aside for the renderer that replaces
    /// this one on the same device: reused, not created again, as a new
    /// surface for the window can come back lost (Wayland on Mesa).
    spare_surface: std::sync::Mutex<?wgpu::Surface<'static>>,
    /// The offscreen colour target, sized like `config`.
    offscreen: ?wgpu::Texture,
    /// Offscreen submissions still on the GPU: at most two frames run ahead.
    in_flight: std::collections::VecDeque<wgpu::SubmissionIndex>,
    /// Splitscreen: the caller waits for the GPU once every player has submitted
    /// (`wait_in_flight`), so one player's work overlaps the GPU drawing another's.
    paced_elsewhere: bool,
    /// Which steps of the first frame on this device still go to the log
    /// (see `startup_step`).
    first_frame: FirstFrame,
    gpu_timer: ?timing::GpuTimer,
    /// GPU frame times (ms) read back since the caller last drained them.
    gpu_times: std.ArrayList(f32),
    /// The last lightmap written, RGBA rows of sky level by block level
    /// (F3+4 shows it).
    lightmap_pixels: [u8,
    /// Time the last `render` spent blocked on the GPU or the display
    /// (acquiring, presenting, offscreen pacing, the submit thread holding the queue),
    /// excluded from CPU time.
    last_wait: std::time::Duration,
    /// CPU time of the last `render`, waits excluded.
    last_encode: std::time::Duration,
    /// What the system says about the window's display, watched only while HDR output
    /// is on; before `window`, so it's dropped first.
    display: DisplayWatch,
    /// The watch was just made: the settings' Auto values take what it reported.
    display_fresh: bool,
    window: *Window,
    device: wgpu::Device,
    /// The shader modules, layouts and pipelines kept for the next renderer on
    /// this device ([`reuse`]).
    reuse: *reuse::Reuse,
    /// Frames are finished and submitted on its submit thread ([`submit`]).
    queue: submit::Queue,
    /// The last frame went to the submit thread; whether it had no window surface.
    /// The next frame takes it in ([`Self::land_frame`]).
    deferred: ?bool,
    /// Set by the device's lost callback. wgpu reports nothing else when an
    /// operation fails on a lost device (no error scope sees it).
    device_lost: *std::sync::atomic::AtomicBool,
    config: wgpu::SurfaceConfiguration,
    solid: wgpu::RenderPipeline,
    /// `solid` split in two passes for the world pass (terrain.wgsl's `opaque_quad`).
    solid_opaque: wgpu::RenderPipeline,
    solid_cutout: wgpu::RenderPipeline,
    translucent: wgpu::RenderPipeline,
    translucent_mark: wgpu::RenderPipeline,
    /// Flat section draws (`flat`), where multi-draw is emulated.
    flat: ?flat::Flat,
    /// Sections upload their solid quads in the compact layout (`mesher::packed`): the solid
    /// passes read the arena themselves (`flat`) and no shader pack reads it as vertices.
    packed_quads: bool,
    /// The visibility buffer for flat frames' solid terrain (`visbuffer`,
    /// `HORIZON_VISBUFFER=1`).
    visbuf: ?visbuffer::Visbuffer,
    /// `flat` draws this frame's sections (off: the per-section draws).
    flat_on: bool,
    /// Occlusion culling of solid section draws, where the GPU's instance
    /// counts reach a multi-draw's entries (Vulkan, Metal).
    cull: ?cull::Cull,
    cull_on: bool,
    /// Solid quads facing away from the eye are left out (`mesher::Sides`).
    sides_on: bool,
    /// The near solid sections culled and drawn on the GPU (`gpu_culling`): its pass,
    /// records and fades while it is on, where it is offered (`gpu_culling_offer`, mirrored
    /// for the settings in `graphics::gpu_culling_offer`), and whether the last frame drew
    /// them so (`gpu_frame`).
    gpu_culling: ?gpu_culling::GpuCulling,
    gpu_culling_offer: crate::graphics::GpuCullingOffer,
    gpu_frame: bool,
    /// GPU frames since GPU culling was switched on: the first and every 64th after it
    /// check its records (`check_gpu_records`).
    gpu_checks: u32,
    sky: wgpu::RenderPipeline,
    /// The main sky without the sunrise fan, which `sunrise_pipeline` draws as
    /// geometry over it. The mirror keeps `sky`: its per-pixel fan is cheap at
    /// the reflection's size and needs no second projection.
    sky_base: wgpu::RenderPipeline,
    sunrise_pipeline: wgpu::RenderPipeline,
    sunrise_buffer: wgpu::Buffer,
    dark_disc: wgpu::RenderPipeline,
    /// Clears the world pass's depth to the far plane so the first-person hand draws in the
    /// same pass (`hand_in_world`), as the hand's own pass would clear it.
    depth_reset: wgpu::RenderPipeline,
    lines: wgpu::RenderPipeline,
    lines_secondary: wgpu::RenderPipeline,
    /// A resource pack's `core/rendertype_lines`, which draws the block outline in their place.
    core_lines: ?core_lines::CoreLines,
    /// Gizmo lines: opaque ones (`RenderTypes.lines`, which writes depth),
    /// translucent ones (`RenderTypes.linesTranslucentNoDepthWrite`) and the
    /// always-on-top ones.
    debug_lines_opaque: wgpu::RenderPipeline,
    debug_lines: wgpu::RenderPipeline,
    debug_lines_on_top: wgpu::RenderPipeline,
    debug_line_buffer: wgpu::Buffer,
    debug_line_capacity: u64,
    /// The terrain resources with the debug crosshair's projection
    /// (`crosshair_globals`).
    crosshair_group: wgpu::BindGroup,
    crosshair_globals: wgpu::Buffer,
    /// The water mirror: its solid terrain pipeline, its camera's globals and their group,
    /// and its targets once drawn.
    solid_mirror: wgpu::RenderPipeline,
    mirror_globals: wgpu::Buffer,
    mirror_group: wgpu::BindGroup,
    mirror: ?MirrorTarget,
    entity_pipeline: wgpu::RenderPipeline,
    static_entity_pipeline: wgpu::RenderPipeline,
    static_entity_group: wgpu::BindGroup,
    static_entity_transform: wgpu::Buffer,
    static_entity_camera: ?DVec3,
    static_entity_catalog_revision: u64,
    static_entity_frame_stats: StaticCacheFrameStats,
    hdr_mark_pipeline: wgpu::RenderPipeline,
    hdr_hand_unmark_pipeline: wgpu::RenderPipeline,
    hdr_mark_lightning_pipeline: wgpu::RenderPipeline,
    weather: weather::Weather,
    crumbling_pipeline: wgpu::RenderPipeline,
    shadow_blob_pipeline: wgpu::RenderPipeline,
    translucent_item_pipeline: wgpu::RenderPipeline,
    /// `RenderPipelines.WATER_MASK`: depth writes only, no colour.
    water_mask_pipeline: wgpu::RenderPipeline,
    cloud_pipeline: wgpu::RenderPipeline,
    hdr_cloud_mark_pipeline: wgpu::RenderPipeline,
    cloud_mesh: crate::clouds::Mesh,
    cloud_buffer: wgpu::Buffer,
    cloud_capacity: u64,
    cloud_uniform: wgpu::Buffer,
    cloud_group: wgpu::BindGroup,
    additive_pipeline: wgpu::RenderPipeline,
    dragon_rays_pipeline: wgpu::RenderPipeline,
    /// `RenderPipelines.ENERGY_SWIRL`: additive, unlit, the sprite repeated within itself.
    energy_swirl_pipeline: wgpu::RenderPipeline,
    lightning_pipeline: wgpu::RenderPipeline,
    lightning: lightning::Renderer,
    see_through_pipeline: wgpu::RenderPipeline,
    /// Native mods' world primitives (`Frame::world_primitives`).
    world_primitives: world_primitives::WorldPrimitives,
    text_polygon_offset_pipeline: wgpu::RenderPipeline,
    world_text_pipeline: wgpu::RenderPipeline,
    celestial_pipeline: wgpu::RenderPipeline,
    celestial_buffer: wgpu::Buffer,
    end_sky: end_sky::EndSky,
    stars: stars::Stars,
    /// The glowing entities' outline (`LevelRenderer.entityOutlineTarget`).
    entity_outline: entity_outline::EntityOutline,
    panorama: panorama::Panorama,
    /// `RenderPipelines.WORLD_BORDER` and its buffers.
    border_pipeline: wgpu::RenderPipeline,
    border_group: wgpu::BindGroup,
    border_uniform: wgpu::Buffer,
    border_vertices: wgpu::Buffer,
    /// Screen effects: alpha-blended, then vignette (`dst * (1 - src)`)
    /// pipelines, each for every sampling (index `blend * 4 + sampling`).
    screen_pipelines: [wgpu::RenderPipeline,
    screen_buffer: wgpu::Buffer,
    screen_capacity: u64,
    entity_group: wgpu::BindGroup,
    /// The layout of `entity_group`, for the native shadow pass.
    entity_bindings: wgpu::BindGroupLayout,
    /// The entity resources with the hand's projection (`hand_globals`).
    hand_group: wgpu::BindGroup,
    hand_globals: wgpu::Buffer,
    entity_buffer: wgpu::Buffer,
    entity_capacity: u64,
    static_entity_sections: HashMap<[i32,
    static_entity_indices: wgpu::Buffer,
    static_entity_index_quads: u32,
    entity_batch: EntityBatch,
    /// Ordinary entity models posed on the GPU; `None` without compute shaders.
    entity_skin: ?entity_skin::EntitySkin,
    group: wgpu::BindGroup,
    globals: wgpu::Buffer,
    /// Resource-pack normal/specular maps, split like the colour sprite arrays.
    pbr_maps: Option<Vec<[wgpu::Texture,
    lightmap: wgpu::Texture,
    /// The block sprites, `sprite_split` layers per array (the first is
    /// `sprites` in terrain.wgsl, the others `sprites_1`...).
    sprite_textures: std.ArrayList(wgpu::Texture),
    /// Block sprite layers per array on this device ([`layer_split`]).
    sprite_split: u32,
    /// A 1-layer array bound where a pack needs fewer arrays.
    sprite_unused: wgpu::TextureView,
    /// The sprite arrays as the terrain samples them (`SPRITE_ARRAYS` views, `sprite_unused`
    /// past the ones in use, the Mipmap Levels option's levels), for native mods
    /// (`WorldDrawn::block_sprites`).
    sprite_views: std.ArrayList(wgpu::TextureView),
    /// Nearest, repeating, nearest mip level: for drawing a sprite's texels sharp elsewhere.
    sprite_nearest: wgpu::Sampler,
    mip_levels: u32,
    /// The mipmap levels sampled (the Mipmap Levels option), at most `mip_levels - 1`.
    mipmaps: u32,
    terrain_layout: wgpu::BindGroupLayout,
    /// terrain.wgsl's `SPRITE_ARRAYS` and `SPRITE_SPLIT`, for a shader pack's terrain.
    terrain_sprites: [f64,
    sprite_sampler: wgpu::Sampler,
    /// `Options.textureFiltering`: 0 none, 1 RGSS, 2 anisotropic.
    texture_filtering: u32,
    /// The anisotropic sampler's clamp (`Options.maxAnisotropyValue`); 1 unless anisotropic.
    max_anisotropy: u16,
    lightmap_view: wgpu::TextureView,
    lightmap_sampler: wgpu::Sampler,
    animations: animate::SpriteAnimator,
    material_animations: std.ArrayList(SpriteAnimation),
    active_animated_layers: std.ArrayList(u64),
    uploads: upload::Uploads,
    /// Section meshes are staged through their own belt into
    /// `section_copies`, which the next frame records its commands after:
    /// `Queue::write_buffer` would make a staging buffer per write.
    section_uploads: upload::Uploads,
    section_copies: ?wgpu::CommandEncoder,
    /// Bytes staged in `section_copies`.
    section_copy_bytes: u64,
    /// When a large translucent page may start to shrink (`shrink_translucent`).
    shrink_gate: ShrinkGate,
    /// Whether `lightmap` holds `lightmap_pixels` yet.
    lightmap_uploaded: bool,
    sprite_minimum_size: u32,
    /// Each sprite layer's own side, before the arrays scaled it up (`mipmap::Settings::native_size`).
    sprite_native: std.ArrayList(u32),
    /// The Mipmap Levels option (`set_mipmap_levels`), which sets a shader pack atlas's padding.
    mipmap_option: u32,
    indices: wgpu::Buffer,
    index_quads: u32,
    instances: wgpu::Buffer,
    instance_capacity: u64,
    outline: wgpu::Buffer,
    depth: wgpu::TextureView,
    sections: resident::Resident<SectionGpu>,
    lods: HashMap<crate::lod::TileKey,
    /// Far tiles' occlusion culling slots (`lod::Tile::cull_slot`): those
    /// free, and the next never used.
    lod_cull_free: std.ArrayList(u32),
    lod_cull_next: u32,
    /// The chunk columns the resident tiles leave out (`Lod::take_cutout`):
    /// their sections are drawn even past the render distance, so terrain
    /// leaving it never opens a hole before the tiles fill it in.
    lod_cutout: crate::fast_hash::FxHashSet<(i32,
    /// Removed sections of `lod_cutout` columns, released once tiles cover them.
    lod_retiring: crate::fast_hash::FxHashSet<SectionKey>,
    /// Removed sections fading out over far terrain (`leave_section`).
    lod_leaving: Vec<(SectionKey,
    /// Finished tile meshes `upload_lods` has yet to upload.
    lod_pending: ?lod::Pending,
    detail_columns: FxHashMap<(i32,
    /// Bumped whenever a column becomes or stops being complete.
    detail_revision: u64,
    arena: arena::Arena,
    /// Translucent quads' own arena, with large pages, while the layout is split
    /// (`translucent_split`): the back-to-front list then stays in one page (and
    /// one sorted-index page) and draws in a few multi-draws rather than one per
    /// few sections.
    translucent_arena: ?arena::Arena,
    /// Translucent Batching (`Graphics::translucent_batching`, read when a renderer
    /// is made), where it is offered (`graphics::offer_translucent_batching`).
    translucent_batching: bool,
    /// Every section and far tile was dropped to change the layout since the game
    /// last asked (`take_dropped_sections`).
    sections_dropped: bool,
    sorted_indices: arena::Arena,
    /// Buffers of released arena pages, freed a few frames later on a thread of their own.
    graveyard: arena::Graveyard<wgpu::Buffer>,
    translucent_sorter: translucency::Sorter,
    translucency_cursor: usize,
    /// `DrawIndexedIndirectArgs` for this frame's solid then translucent draws.
    indirect: wgpu::Buffer,
    indirect_capacity: u64,
    /// Indirect draws may set `first_instance` (the section origin).
    multi_draw: bool,
    /// Per-frame scratch, kept to avoid allocating every frame.
    visible: std.ArrayList(resident::Visible),
    visible_lods: std.ArrayList(lod::Visible),
    /// The sections a shader pack's shadow camera sees (`pack_post::ShadowView`).
    shadow_visible: std.ArrayList(resident::Visible),
    translucent_draws: Vec<(u64,
    origins: Vec<[f32,
    /// `DrawIndexedIndirectArgs` words: index count, instance count, first
    /// index, base vertex, first instance.
    draws: Vec<[u32,
    /// Vertex arena page and optional sorted index arena page of each draw:
    /// with sorted indices (a translucent draw), a page of `translucent_arena`
    /// when there is one.
    draw_pages: Vec<(u32,
    /// Solid draws left to occlusion culling's phase 2, while the list is
    /// built, and their pages.
    phase2_draws: Vec<[u32,
    phase2_pages: Vec<(u32,
    /// Each section's solid draws, to group them by arena page.
    solid_runs: page_runs::PageRuns,
    phase2_runs: page_runs::PageRuns,
    /// The shadow camera's draws by page, in bands of distance from the light.
    shadow_runs: page_runs::PageRuns,
    /// Block-entity blocks per meshed section (world position, state id).
    block_entities: FxHashMap<SectionKey,
    /// Changes on every mesh upload for that section; block-entity static
    /// geometry also depends on the section's packed light.
    block_entity_section_revisions: FxHashMap<SectionKey,
    /// Changes only when the block-entity positions/states in a section
    /// change. Empty-section tombstones remain until that section unloads so
    /// the static cache can remove deleted models without a global flush.
    block_entity_membership_revisions: FxHashMap<SectionKey,
    /// When each section was first uploaded (`RenderSection.uploadedTime`): kept across meshing
    /// it again, gone with its column. Sections that fade in over far terrain are not in it.
    section_uploaded: FxHashMap<SectionKey,
    /// When `section_uploaded` last gained a section: once the fade time has passed since,
    /// every section is whole and frames skip the per-section lookups.
    newest_upload: ?std::time::Instant,
    /// When a section last began to fade in over far terrain (`SectionGpu::fading`), for the
    /// same shortcut.
    newest_lod_fade: ?std::time::Instant,
    /// Changes whenever `block_entities` does (unique across renderers).
    block_entity_revision: u64,
    /// The light sources of each section and their revision, for `block_light`.
    light_blocks: FxHashMap<SectionKey,
    light_revision: u64,
    /// VisGraph face connectivity per meshed section (cave culling).
    occlusion: occlusion::Occlusion,
    /// The column `occlusion`, `sections` and `detail_columns` count in: the
    /// level's (`clear_sections`).
    layout: crate::chunk::ColumnLayout,
    /// Resolution scale, FXAA and TAA (Horizon settings).
    world_post: world_post::Post,
    /// Frame generation (Horizon setting).
    frame_gen: frame_gen::FrameGen,
    /// The entities' texture atlas (`entity_group`'s), for frame generation's motion.
    entity_atlas: wgpu::TextureView,
    /// HDR output (Horizon setting): `Some` while the swapchain is HDR.
    hdr: ?hdr::Hdr,
    /// Which pixels of each block sprite may shine in HDR output (terrain.wgsl's
    /// `emission_thresholds`), measured when HDR output turns on.
    emission_stats: hdr_stats::EmissionStats,
    /// The HDR output the window's surface can present.
    hdr_output: ?hdr::Output,
    /// What every pipeline that draws the frame targets: the swapchain's 8-bit format, or
    /// `Rgba16Unorm` when the renderer was made with HDR output on (`wide_frame`) and the
    /// device draws and blends into it. A 16-bit frame with HDR off since reaches the
    /// swapchain through `readback`.
    frame_format: wgpu::TextureFormat,
    /// The marker file of an HDR output that has not presented a frame yet
    /// (`graphics::HDR_MARKER`).
    hdr_marker: ?std::path::PathBuf,
    /// The HDR Lighting setting, kept for the HDR output made when HDR turns on.
    hdr_lighting_setting: bool,
    /// The shader pack's post-processing, and the dimension (legacy id) it was loaded for.
    pack_post: Option<(i32,
    /// The post passes of one of Horizon's own shader packs; never beside `pack_post`'s.
    native: ?native_pack::NativePack,
    /// Time the shader pack's passes on the GPU (F3, or `HORIZON_SHADER_PACK_TIMING`).
    pass_timing: bool,
    /// Times Horizon's own passes on the GPU, as `pass_timing` does (`own_pass_times`).
    own_timing: ?pack_timing::PassTiming,
    /// The entity vertices Horizon draws itself while a shader pack draws the others.
    pack_entity_rest: std.ArrayList(Vertex),
    /// Set 1 of the cloud pipeline, for a shader pack's `gbuffers_clouds`.
    cloud_bindings: wgpu::BindGroupLayout,
    /// Rain and snow handed to a shader pack's `gbuffers_weather`, once a pack draws them.
    pack_weather: ?pack_weather::PackWeather,
    /// The block sprites as one atlas, while a shader pack is loaded.
    pack_atlas: ?pack_atlas::PackAtlas,
    pack_material_atlases: Option<[pack_atlas::PackAtlas,
    /// The pack's terrain program reads flat draws' vertices (`pack_terrain_inputs`).
    pack_terrain_flat: bool,
    /// OptiFine/Iris separate ambient occlusion: pass vertex alpha to hz_Color.a.
    separate_ao: bool,
    /// Lava's sprite layers, which a pack's solid terrain draws (`pack_atlas::terrain_parts`).
    pack_lava_layers: std.ArrayList(u16),
    hud: HudRenderer,
    /// Vanilla's menu background blur, made on first use.
    menu_blur: ?crate::menu_blur::MenuBlur,
    /// `post_effect` chains, made on first use.
    post_effects: ?crate::post_chain::PostEffects,
    /// Where a screenshot's frame is drawn when the swapchain cannot be read back.
    readback: readback::Readback,
    info: wgpu::AdapterInfo,
    suspended: bool,
    /// Consecutive frames whose surface acquisition failed validation. The
    /// first gets the swapchain a fresh configuration; later ones reattach
    /// the window, as a lost surface does.
    acquire_validation_failures: u32,
    /// A surface from `recreate_surface` whose configuration failed. wgpu
    /// panics when such a surface is acquired from (it never had one that
    /// worked), so frames configure it again first and skip until it takes.
    surface_unconfigured: bool,
    /// The last frame's statistics, all of one frame (`show_stats`): its sections drawn
    /// (F3's `C:`, the world icon's check), section draws (face ranges and translucent
    /// sections) and the draw calls the backend issued for them. A CPU frame's are its own;
    /// in GPU frames (`gpu_culling`) they are the newest GPU frame's whose counts came back,
    /// a frame or a few earlier (`stats_lag`).
    drawn_sections: usize,
    section_draws: usize,
    section_draw_calls: usize,
    /// `draw_frame`'s frames past its early returns, and the one whose statistics are shown.
    frame_serial: u64,
    stats_frame: u64,
    uploaded_bytes: u64,
    started: Instant,
    /// The next frame to write to a PNG path (control socket, F2, world icon).
    screenshot: ?ScreenshotRequest,
    /// Outcome of the last screenshot: frame size, or the error.
    screenshot_result: Option<std::result::Result<[u32,
    /// Screenshot Quality (Horizon setting): a `scaled` screenshot's frame is this many
    /// times the game's resolution (1, 2, 4 or 8).
    screenshot_quality: u32,
    /// How many times the pending scaled screenshot ran out of video memory: each
    /// halves its size, down to the window's.
    screenshot_halvings: u32,
    /// Brightness option (lightmap gamma), 0..1.
    gamma: f32,
    /// Optional full-light lightmap (Horizon Extras).
    fullbright: bool,
    /// The Improved transparency option (`GameRenderer.useImprovedTransparency`).
    improved_transparency: bool,
    /// Its passes and targets, made when first drawn with.
    oit: ?oit::Oit,
    /// Advance animated block textures (Horizon setting; vanilla always does).
    animated_textures: bool,
    present_modes: std.ArrayList(wgpu::PresentMode),
    /// CPU copies of the section and far tile meshes uploaded while `render-capture` is on
    /// (`keep_capture_copies`, or `HORIZON_RENDER_CAPTURE` at creation); `None` otherwise.
    capture_copies: ?capture::Copies,
    /// A scene to write from the next frame (`horizon-ctl render-capture DIR`).
    capture: ?capture::Request,
    /// Outcome of the last capture: its summary, or the error.
    capture_result: Option<std::result::Result<serde_json::Value,
};
/// Every layer's mip levels, layer major (`first` is the first layer's
/// index into `settings`), made by `MipmapGenerator`.
/// Block sprite layers per texture array at most: the
/// `max_texture_array_layers` of most GPUs. Mods add sprites past it into more
/// arrays (terrain.wgsl's `sprite`); a GPU with fewer layers per array gets a
/// smaller split ([`layer_split`]).
    // rust: pub(crate) const SPRITE_SPLIT: u32 = 2048;
/// A smaller split from `HORIZON_SPRITE_SPLIT` (dev only: vanilla's sprites
/// drawn from several arrays must look the same).
pub fn requested_split() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::var("HORIZON_SPRITE_SPLIT")
    // rust: .ok()
    // rust: .and_then(|v| v.parse().ok())
    // rust: .filter(|&n| (1..=SPRITE_SPLIT).contains(&n))
}
pub fn adapter_requested_split(info: *wgpu::AdapterInfo, requested: ?u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // Metal can fail to sample large mipmapped array textures despite advertising the layer limit.
    // rust: requested.or_else(|| (info.backend == wgpu::Backend::Metal).then_some(512))
}
/// The split the CPU mip chains are cut by before the adapter is known.
pub fn sprite_split() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: requested_split().unwrap_or(SPRITE_SPLIT)
}
/// The block sprite layers per texture array on an adapter that holds
/// `max_layers` layers per array: [`SPRITE_SPLIT`], `requested`
/// (`HORIZON_SPRITE_SPLIT`) or `max_layers`, whichever is smallest, with a full
/// array still fitting once [`array_layers`] pads it for OpenGL. Errors when
/// `layers` sprites need more than the [`SPRITE_ARRAYS`] arrays terrain.wgsl binds.
    // rust: fn layer_split(
    // rust: max_layers: u32,
    // rust: gl: bool,
    // rust: requested: Option<u32>,
    // rust: layers: u32,
    // rust: ) -> std::result::Result<u32, String> {
    // rust: let mut split = requested.unwrap_or(SPRITE_SPLIT).min(max_layers).max(1);
    // rust: if split > 1 && array_layers(split, gl) > max_layers {
    // rust: split -= 1;
}
    // rust: if layers > split * SPRITE_ARRAYS {
    // rust: return Err(format!(
    // rust: "GPU supports {max_layers} texture layers per array; {layers} block textures need \
    // rust: more than the {SPRITE_ARRAYS} arrays of {split} Horizon draws from"
    // rust: ));
}
    // rust: Ok(split)
}
/// Sprite arrays terrain.wgsl binds (`sprites`, `sprites_1`...).
pub const SPRITE_ARRAYS: u32 = 8;
/// The layers to give a square texture of `count` layers viewed as a 2D
/// array. wgpu's OpenGL backend picks a texture's target from its layer
/// count when it is created: one layer makes a 2D texture and a multiple of
/// six a cube map, neither of which can be viewed as an array.
    // rust: pub(crate) fn array_layers(count: u32, gl: bool) -> u32 {
    // rust: match count {
    // rust: _ if !gl => count,
    // rust: 0 | 1 => 2,
    // rust: n if n % 6 == 0 => n + 1,
    // rust: n => n,
}
}
/// The views of terrain.wgsl's sprite arrays, the unused ones a 1-layer
/// stand-in.
    // rust: fn sprite_views(
    // rust: textures: &[wgpu::Texture],
    // rust: unused: &wgpu::TextureView,
    // rust: mips: Option<u32>,
    // rust: ) -> Vec<wgpu::TextureView> {
    // rust: (0..SPRITE_ARRAYS as usize)
    // rust: .map(|i| match textures.get(i) {
    // rust: Some(t) => t.create_view(&wgpu::TextureViewDescriptor {
    // rust: dimension: Some(wgpu::TextureViewDimension::D2Array),
    // rust: mip_level_count: mips,
    // rust: ..Default::default()
    // rust: }),
    // rust: None => unused.clone(),
    // rust: })
    // rust: .collect()
}
/// The block sprites sampled sharp, for native mods (`WorldDrawn::block_sprites`): nearest,
/// repeating, the nearest mip level.
    // rust: const SPRITE_NEAREST: wgpu::SamplerDescriptor<'static> = wgpu::SamplerDescriptor {
    // rust: label: Some("Block sprites (nearest)"),
    // rust: address_mode_u: wgpu::AddressMode::Repeat,
    // rust: address_mode_v: wgpu::AddressMode::Repeat,
    // rust: address_mode_w: wgpu::AddressMode::ClampToEdge,
    // rust: mag_filter: wgpu::FilterMode::Nearest,
    // rust: min_filter: wgpu::FilterMode::Nearest,
    // rust: mipmap_filter: wgpu::MipmapFilterMode::Nearest,
    // rust: lod_min_clamp: 0.0,
    // rust: lod_max_clamp: 32.0,
    // rust: compare: None,
    // rust: anisotropy_clamp: 1,
    // rust: border_color: None,
}
/// The terrain sprites' sampler: LevelRenderer.chunkLayerSampler's linear one (clamped to the
/// edge) in every Texture Filtering mode, with `anisotropy` samples when it is above 1 (wgpu
/// then needs a linear mipmap filter too).
pub fn sprite_sampler_descriptor(anisotropy: u16) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: wgpu::SamplerDescriptor {
    // rust: label: Some("Block sprites (filtered)"),
    // rust: address_mode_u: wgpu::AddressMode::ClampToEdge,
    // rust: address_mode_v: wgpu::AddressMode::ClampToEdge,
    // rust: mag_filter: wgpu::FilterMode::Linear,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: mipmap_filter: wgpu::MipmapFilterMode::Linear,
    // rust: anisotropy_clamp: anisotropy,
    // rust: ..Default::default()
}
}
/// `Options.maxAnisotropyValue` for a `maxAnisotropyBit`: `1 << bit`, at most wgpu's 16.
pub fn sampler_anisotropy(bit: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 1u16 << bit.clamp(0, 4)
}
/// terrain.wgsl's group 0.
    // rust: fn terrain_group(
    // rust: device: &wgpu::Device,
    // rust: label: &str,
    // rust: layout: &wgpu::BindGroupLayout,
    // rust: globals: &wgpu::Buffer,
    // rust: sprites: &[wgpu::TextureView],
    // rust: sprite_sampler: &wgpu::Sampler,
    // rust: lightmap: &wgpu::TextureView,
    // rust: lightmap_sampler: &wgpu::Sampler,
    // rust: emission_thresholds: &wgpu::TextureView,
    // rust: ) -> wgpu::BindGroup {
    // rust: let view = |binding, view| wgpu::BindGroupEntry {
    // rust: binding,
    // rust: resource: wgpu::BindingResource::TextureView(view),
}
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some(label),
    // rust: layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: globals.as_entire_binding(),
    // rust: },
    // rust: view(1, &sprites[0]),
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(sprite_sampler),
    // rust: },
    // rust: view(3, lightmap),
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: wgpu::BindingResource::Sampler(lightmap_sampler),
    // rust: },
    // rust: view(5, &sprites[1]),
    // rust: view(6, &sprites[2]),
    // rust: view(7, &sprites[3]),
    // rust: view(8, &sprites[4]),
    // rust: view(9, &sprites[5]),
    // rust: view(10, &sprites[6]),
    // rust: view(11, &sprites[7]),
    // rust: view(12, emission_thresholds),
    // rust: ],
    // rust: })
}
/// CPU texture uploads prepared by the resource worker. Consumed by renderer
/// construction so the temporary mip chains are released after GPU upload.
pub const PreparedTextures = struct {
    sprites: std.ArrayList((Vec<u8),
    /// The sprite layers per array `sprites` is cut by.
    split: u32,
    forcefield: (std.ArrayList(u8),
    /// The LabPBR maps' mip chains (normals, specular), their levels, layers and size.
    pbr: Option<(std.ArrayList(u8),
};
/// Every level of `layers` square RGBA layers of `size`, each the mean of four texels of the
/// one above, layer major: the LabPBR maps' mips (their channels are data, not colour).
pub fn box_mip_chain(pixels: []const u8, size: u32, layers: u32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let layer_bytes = (size * size * 4) as usize;
    // rust: let mut out = Vec::new();
    // rust: for layer in pixels.chunks_exact(layer_bytes).take(layers as usize) {
    // rust: let mut level = layer.to_vec();
    // rust: let mut side = size as usize;
    // rust: out.extend_from_slice(&level);
    // rust: while side > 1 {
    // rust: let half = side / 2;
    // rust: let mut next = Vec::with_capacity(half * half * 4);
    // rust: for y in 0..half {
    // rust: for x in 0..half {
    // rust: for c in 0..4 {
    // rust: let at = |dx: usize, dy: usize| {
    // rust: u32::from(level[((2 * y + dy) * side + 2 * x + dx) * 4 + c])
}
    // rust: next.push(((at(0, 0) + at(1, 0) + at(0, 1) + at(1, 1) + 2) / 4) as u8);
}
}
}
    // rust: out.extend_from_slice(&next);
    // rust: level = next;
    // rust: side = half;
}
}
    // rust: out
}
    // rust: impl PreparedTextures {
    // rust: pub fn new(
    // rust: pixels: &[u8],
    // rust: size: u32,
    // rust: layers: u32,
    // rust: settings: &[crate::mipmap::Settings],
    // rust: forcefield: (&[u8], u32),
    // rust: ) -> Self {
    // rust: Self::with_split(pixels, size, layers, settings, forcefield, sprite_split())
}

    // rust: fn with_split(
    // rust: pixels: &[u8],
    // rust: size: u32,
    // rust: layers: u32,
    // rust: settings: &[crate::mipmap::Settings],
    // rust: forcefield: (&[u8], u32),
    // rust: split: u32,
    // rust: ) -> Self {
    // rust: let layer_bytes = (size * size * 4) as usize;
    // rust: Self {
    // rust: sprites: (0..layers.div_ceil(split).max(1))
    // rust: .map(|array| {
    // rust: let first = array * split;
    // rust: let count = layers.saturating_sub(first).clamp(1, split);
    // rust: let start = (first as usize * layer_bytes).min(pixels.len());
    // rust: mip_chain(&pixels[start..], size, settings, first, count)
    // rust: })
    // rust: .collect(),
    // rust: split,
    // rust: forcefield: mip_chain(forcefield.0, forcefield.1, &[], 0, 1),
    // rust: pbr: None,
}
}

    /// With the resource packs' LabPBR `normals` and `specular` maps (`layers` layers of
    /// `size`, as `RenderAssets` holds them; nothing when empty).
pub fn with_pbr(normals: []const u8, specular: []const u8, size: u32, layers: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !normals.is_empty() {
    // rust: self.pbr = Some((
    // rust: box_mip_chain(normals, size, layers),
    // rust: box_mip_chain(specular, size, layers),
    // rust: size.trailing_zeros() + 1,
    // rust: layers,
    // rust: size,
    // rust: ));
}
    // rust: self
}

    /// The same mip chains cut by `split` layers per array: chains made before
    /// the adapter was known, for a GPU with fewer layers per array.
pub fn resplit(layers: u32, split: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.split == split || layers <= split.min(self.split) {
    // rust: self.split = split;
    // rust: return self;
}
    // rust: let levels = self.sprites[0].1;
    // rust: let all: Vec<u8> = self
    // rust: .sprites
    // rust: .drain(..)
    // rust: .flat_map(|(bytes, _)| bytes)
    // rust: .collect();
        // Every layer's mip levels are contiguous (layer major).
    // rust: let layer_bytes = all.len() / layers as usize;
    // rust: self.sprites = all
    // rust: .chunks(layer_bytes * split as usize)
    // rust: .map(|chunk| (chunk.to_vec(), levels))
    // rust: .collect();
    // rust: self.split = split;
    // rust: self
}
}

    // rust: fn mip_chain(
    // rust: pixels: &[u8],
    // rust: size: u32,
    // rust: settings: &[crate::mipmap::Settings],
    // rust: first: u32,
    // rust: layers: u32,
    // rust: ) -> (Vec<u8>, u32) {
    // rust: let levels = size.trailing_zeros() + 1;
    // rust: let layer_bytes = (size * size * 4) as usize;
    // Exactly the chain's size: cached animation frames count their capacity.
    // rust: let chain_bytes: usize = (0..levels).map(|l| layer_bytes >> (2 * l)).sum();
    // rust: let mut out = Vec::with_capacity(chain_bytes * layers as usize);
    // rust: for layer in 0..layers as usize {
    // rust: let base = crate::mipmap::Image {
    // rust: width: size,
    // rust: height: size,
    // rust: pixels: pixels[layer * layer_bytes..(layer + 1) * layer_bytes]
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .to_vec(),
}
    // rust: let s = settings
    // rust: .get(first as usize + layer)
    // rust: .copied()
    // rust: .unwrap_or_default();
    // rust: let has_transparent = s.has_transparent || base.pixels.iter().any(|p| p[3] == 0);
    // rust: for image in crate::mipmap::generate(
    // rust: base,
    // rust: levels - 1,
    // rust: crate::mipmap::Settings {
    // rust: has_transparent,
    // rust: ..s
    // rust: },
    // rust: ) {
    // rust: out.extend(image.pixels.iter().flatten());
}
}
    // rust: debug_assert_eq!(out.len(), chain_bytes * layers as usize);
    // rust: (out, levels)
}
/// The wgpu instance options, without wgpu's validation of indirect draws
/// in release builds. That validation (meant for untrusted WebGPU content)
/// copies every indirect draw through a compute pass before the render pass
/// and costs about a tenth of `render`'s CPU time on Metal. The draws it checks
/// are the section draws `render` writes from resident sections, in
/// bounds by construction: index counts within `indices`, vertices within
/// the section's arena range, first instances below the origins written that
/// frame. Debug builds keep validating them; `WGPU_VALIDATION_INDIRECT_CALL=1`
/// turns it back on. DirectX 12 keeps it too: there wgpu-core's validation
/// pass is also what passes each draw's first instance to shaders reading
/// `instance_index`, and DirectX 12 is the fallback, where working matters
/// more than CPU time. GPU culling's count draws (`gpu_culling`) are written on
/// the GPU and never validated, in any build or backend: they are in bounds by
/// construction too (that module's doc), and no shader they run reads
/// `instance_index`.
/// `allow_nonconformant` offers the adapters wgpu hides for reporting no Vulkan
/// conformance version: Mesa's hasvk, which drives Ivy Bridge and Haswell,
/// reports 0.0.0.0 while it works. `open_device` asks for them only on a second
/// try at a backend that had no adapter at all.
    // rust: fn instance_descriptor(
    // rust: backends: wgpu::Backends,
    // rust: window: Option<&Arc<Window>>,
    // rust: allow_nonconformant: bool,
    // rust: ) -> wgpu::InstanceDescriptor {
    // rust: let mut descriptor = wgpu::InstanceDescriptor::new_without_display_handle();
    // rust: if let Some(window) = window {
    // rust: descriptor = descriptor.with_display_handle(Box::new(WindowDisplay(window.clone())));
}
    // rust: descriptor.backends = backends.with_env();
    // rust: let dx12 = cfg!(windows) && descriptor.backends.contains(wgpu::Backends::DX12);
    // FXC spends about 2.6 s on every start compiling the pipelines (DXC about
    // 1 s); what it compiled once is kept in the game folder and read back
    // after that (third_party/wgpu-hal/src/dx12/disk_cache.rs).
    // rust: if dx12 {
    // rust: wgpu::hal::dx12::disk_cache::set_file(dx12_shader_cache(&crate::logging::game_home()));
}
    // rust: if !cfg!(debug_assertions) && !dx12 {
    // rust: descriptor
    // rust: .flags
    // rust: .remove(wgpu::InstanceFlags::VALIDATION_INDIRECT_CALL);
}
    // rust: let mut descriptor = descriptor.with_env();
    // rust: if allow_nonconformant {
    // rust: descriptor
    // rust: .flags
    // rust: .insert(wgpu::InstanceFlags::ALLOW_UNDERLYING_NONCOMPLIANT_ADAPTER);
}
    // rust: descriptor
}
/// Where DX12 keeps the shaders it compiled, inside a game folder.
pub fn dx12_shader_cache(home: *std::path::Path) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: home.join("cache").join("dx12-shaders.bin")
}

/// The window's display connection, so the OpenGL backend creates its EGL
/// display from the X11 or Wayland connection the window lives on. Without
/// one, wgpu-hal falls back to `EGL_MESA_platform_surfaceless`, whose configs
/// cannot present to a window; the backend then reports the surface as
/// incompatible and the game has no OpenGL to fall back to (`gl not
/// compatible with provided surface`).
pub const WindowDisplay = struct {};
    // rust: impl wgpu::rwh::HasDisplayHandle for WindowDisplay {
    // rust: fn display_handle(
    // rust: &self,
    // rust: ) -> std::result::Result<wgpu::rwh::DisplayHandle<'_>, wgpu::rwh::HandleError> {
    // rust: wgpu::rwh::HasDisplayHandle::display_handle(&*self.0)
}
}
/// The backends to open a device on, each tried in turn until one gives a
/// device. `api` is the player's choice (`GraphicsApi::with_env` applied);
/// `os` is `std::env::consts::OS`; `wgpu_backend`: whether `WGPU_BACKEND` is set,
/// which picks the backends itself. Auto tries DirectX 12 first on Windows ARM64,
/// then Vulkan, based on the device-loss observed in a Windows ARM64 test. Other
/// Windows systems try Vulkan, then DirectX 12, then OpenGL; Linux tries Vulkan then
/// OpenGL. Each is tried when the one before has no surface, adapter or device. A native
/// crash in the driver can't be
/// caught in the game; the launcher switches the setting to DirectX 12 after one at
/// the renderer's start (#746). macOS has Metal only.
    // rust: fn backend_order(
    // rust: api: GraphicsApi,
    // rust: os: &str,
    // rust: arch: &str,
    // rust: wgpu_backend: bool,
    // rust: ) -> Vec<wgpu::Backends> {
//     use wgpu::Backends;
    // rust: if os == "macos" || wgpu_backend {
    // rust: return vec![Backends::default()];
}
    // rust: let windows = os == "windows";
    // rust: match api {
    // rust: GraphicsApi::Auto if windows && arch == "aarch64" => {
    // rust: vec![Backends::DX12, Backends::VULKAN, Backends::GL]
}
    // rust: GraphicsApi::Auto if windows => vec![Backends::VULKAN, Backends::DX12, Backends::GL],
    // rust: GraphicsApi::Auto => vec![Backends::VULKAN, Backends::GL],
    // rust: GraphicsApi::Dx12 if windows => vec![Backends::DX12],
    // rust: GraphicsApi::Vulkan | GraphicsApi::Dx12 => vec![Backends::VULKAN],
    // rust: GraphicsApi::OpenGl => vec![Backends::GL],
}
}
pub fn backends_name(backends: wgpu::Backends) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match backends {
    // rust: wgpu::Backends::VULKAN => "Vulkan",
    // rust: wgpu::Backends::DX12 => "DirectX 12",
    // rust: wgpu::Backends::GL => "OpenGL",
    // rust: _ => "graphics",
}
}
/// Whether an adapter renders on the CPU (WARP, llvmpipe).
pub fn is_software(kind: wgpu::DeviceType) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: kind == wgpu::DeviceType::Cpu
}
/// A device and what it came from.
pub const Opened = struct {
    instance: wgpu::Instance,
    surface: ?wgpu::Surface<'static>,
    adapter: wgpu::Adapter,
    device: wgpu::Device,
    queue: wgpu::Queue,
    device_lost: *std::sync::atomic::AtomicBool,
};
/// Logs the adapter and records it for telemetry and crash reports.
pub fn describe_adapter(adapter: *wgpu::Adapter) void {
}
    // rust: let info = adapter.get_info();
    // rust: log::info!(
    // rust: "Horizon renderer: {} ({:?}, {:?})",
    // rust: info.name,
    // rust: info.backend,
    // rust: info.device_type
    // rust: );
    // rust: crate::telemetry::set_gpu(crate::telemetry::Gpu {
    // rust: name: info.name.clone(),
    // rust: vendor: horizon_telemetry::system::gpu_vendor(&info.name, info.vendor).to_owned(),
    // rust: kind: crate::telemetry::gpu_kind(&format!("{:?}", info.device_type)).to_owned(),
    // rust: driver: format!("{} {}", info.driver, info.driver_info)
    // rust: .trim()
    // rust: .to_owned(),
    // rust: backend: format!("{:?}", info.backend),
    // rust: });
    // rust: crate::crash::set_detail(
    // rust: "Graphics Adapter",
    // rust: format!(
    // rust: "{} ({:?}, {:?}), driver {} {}",
    // rust: info.name, info.backend, info.device_type, info.driver, info.driver_info
    // rust: ),
    // rust: );
}
/// Whether an adapter's texture arrays hold the block textures Horizon puts
/// in one array.
pub fn check_layers(adapter: *wgpu::Adapter, layers: u32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let info = adapter.get_info();
    // rust: Ok(layer_split(
    // rust: adapter.limits().max_texture_array_layers,
    // rust: info.backend == wgpu::Backend::Gl,
    // rust: adapter_requested_split(&info, requested_split()),
    // rust: layers,
    // rust: )?)
}
/// Whether the swapchain can take a window of `width` x `height`: each side from 1 to the
/// device's `max_texture_dimension_2d` (`max`), else `Surface::configure` panics. 0 is a
/// minimized window. Past `max`: Windows lets a program size a window up to 65535 pixels
/// (`SetWindowPos`), a 984x65496 client area, when an RTX 5080 takes 32768. Vanilla's
/// `Window.onFramebufferResize` likewise keeps the last size for one that is not positive.
pub fn drawable_size(width: u32, height: u32, max: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (1..=max).contains(&width) && (1..=max).contains(&height)
}
/// The swapchain format: a non-sRGB target, because vanilla blends and tints in gamma
/// space, and 8-bit, because wgpu gives `Rgba16Float` the linear `ExtendedSrgb` color
/// space: the compositor would read these gamma-encoded values as linear light and wash
/// every colour out.
    // rust: fn surface_format(
    // rust: formats: &[wgpu::TextureFormat],
    // rust: default: wgpu::TextureFormat,
    // rust: ) -> wgpu::TextureFormat {
    // rust: [
    // rust: wgpu::TextureFormat::Bgra8Unorm,
    // rust: wgpu::TextureFormat::Rgba8Unorm,
    // rust: ]
    // rust: .into_iter()
    // rust: .find(|f| formats.contains(f))
    // rust: .or_else(|| formats.iter().copied().find(|f| !f.is_srgb()))
    // rust: .unwrap_or(default)
}
/// The 16-bit frame HDR output draws into where it can (`Renderer::frame_format`). Unorm
/// rather than float: it clips at white after every pass as the 8-bit frame does, so light
/// added past white (the sun on the sky) and then blended over (glass) looks the same.
pub const WIDE_FRAME: wgpu::TextureFormat = wgpu::TextureFormat::Rgba16Unorm;

/// Whether a device with `features` can draw, blend and filter `WIDE_FRAME`, whose
/// format features (`format`) the adapter reports. Drawing into it is an adapter-specific
/// format feature, beyond the format itself.
pub fn draws_wide_frame(features: wgpu::Features, format: wgpu::TextureFormatFeatures) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: features.contains(
    // rust: wgpu::Features::TEXTURE_FORMAT_16BIT_NORM
    // rust: | wgpu::Features::TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES,
    // rust: ) && format.allowed_usages.contains(
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | wgpu::TextureUsages::COPY_DST,
    // rust: ) && format.flags.contains(
    // rust: wgpu::TextureFormatFeatureFlags::BLENDABLE | wgpu::TextureFormatFeatureFlags::FILTERABLE,
    // rust: )
}

/// What a renderer's frame is drawn in: `WIDE_FRAME` when it is made with HDR on and Smooth
/// Gradients (`wide_frame`, `Graphics::wide_frame`), the surface offering HDR output
/// (`hdr_offered`) and the device drawing it (`draws_wide_frame`): an 8-bit frame's steps band
/// in dark gradients, and HDR shows them. Else the swapchain's 8-bit format, as without HDR.
    // rust: fn frame_format(
    // rust: wide_frame: bool,
    // rust: hdr_offered: bool,
    // rust: device_draws_it: bool,
    // rust: swapchain: wgpu::TextureFormat,
    // rust: ) -> wgpu::TextureFormat {
    // rust: if wide_frame && hdr_offered && device_draws_it {
    // rust: WIDE_FRAME
    // rust: } else {
    // rust: swapchain.remove_srgb_suffix()
}
}

/// Opens a device on the first of `backend_order`'s backends that gives one.
/// Offscreen rendering needs no surface, so it can use a GPU the window's
/// display cannot present from (a headless compositor).
    // rust: async fn open_device(
    // rust: window: &Arc<Window>,
    // rust: offscreen: bool,
    // rust: api: GraphicsApi,
    // rust: layers: u32,
    // rust: ) -> Result<Opened> {
    // rust: let wgpu_backend = std::env::var_os("WGPU_BACKEND").is_some();
    // rust: let mut first = None;
    // rust: for (order, allow_cpu) in device_search(
    // rust: api.with_env(),
    // rust: std::env::consts::OS,
    // rust: std::env::consts::ARCH,
    // rust: wgpu_backend,
    // rust: ) {
    // rust: match open_device_with(window, offscreen, &order, layers, allow_cpu).await {
    // rust: Ok(opened) => {
    // rust: if let Some(first) = &first {
    // rust: log::warn!(
    // rust: "Horizon renderer: the chosen graphics API gave no GPU ({first}); {}",
    // rust: if allow_cpu {
    // rust: "rendering on the CPU, which is slow"
    // rust: } else {
    // rust: "using the GPU through another one"
}
    // rust: );
}
    // rust: return Ok(opened);
}
    // rust: Err(e) => {
    // rust: first.get_or_insert(e);
}
}
}
    // rust: Err(first.unwrap_or_else(|| NO_GPU_DRIVER.into()))
}
/// The tries `open_device` makes, in turn: the chosen API's backends (`backend_order`) on a
/// real GPU; when the player chose one API, the other backends `Auto` would try, on a real
/// GPU; and last the chosen backends with a software adapter (WARP, llvmpipe) allowed.
/// Software rendering takes most of a weak CPU even on the title screen: an Intel HD 2500 has
/// DirectX 12 only through WARP and its GPU through OpenGL (#5185), and a Fermi GPU has no
/// Vulkan or DirectX 12 driver but OpenGL (#3978). DirectX 12 never falls back to Vulkan: the
/// launcher chooses it after Vulkan crashed in the driver (#746), which the game can't catch.
    // rust: fn device_search(
    // rust: api: GraphicsApi,
    // rust: os: &str,
    // rust: arch: &str,
    // rust: wgpu_backend: bool,
    // rust: ) -> Vec<(Vec<wgpu::Backends>, bool)> {
    // rust: let chosen = backend_order(api, os, arch, wgpu_backend);
    // rust: let others: Vec<_> = backend_order(GraphicsApi::Auto, os, arch, wgpu_backend)
    // rust: .into_iter()
    // rust: .filter(|b| !chosen.contains(b))
    // rust: .filter(|&b| !(api == GraphicsApi::Dx12 && b == wgpu::Backends::VULKAN))
    // rust: .collect();
    // rust: let mut tries = vec![(chosen.clone(), false)];
    // rust: if !others.is_empty() {
    // rust: tries.push((others, false));
}
    // rust: tries.push((chosen, true));
    // rust: tries
}
/// `open_device` on `order`'s backends in turn, taking an adapter of the CPU type
/// (software rendering) only when `allow_cpu`.
    // rust: async fn open_device_with(
    // rust: window: &Arc<Window>,
    // rust: offscreen: bool,
    // rust: order: &[wgpu::Backends],
    // rust: layers: u32,
    // rust: allow_cpu: bool,
    // rust: ) -> Result<Opened> {
    // rust: let mut failures = Vec::new();
    // rust: for (attempt, backends) in order.iter().copied().enumerate() {
    // rust: let name = backends_name(backends);
    // rust: if attempt > 0 {
    // rust: log::warn!("Horizon renderer: trying {name} ({})", failures.join("; "));
}
    // rust: match open_with_retry(backends, window, offscreen, layers, allow_cpu).await {
    // rust: Ok(opened) => return Ok(opened),
    // rust: Err(e) => failures.push(e),
}
}
    // rust: Err(format!("{NO_GPU_DRIVER} ({})", failures.join("; ")).into())
}
/// Why a backend gave no device: no adapter at all, which a second try with the
/// adapters wgpu hides can still find, or a failure after an adapter.
pub const NoDevice = enum {
    NoAdapter(String),
    Failed(String),
};
/// Opens a device on one backend, and on a backend whose adapters wgpu all hid
/// for reporting no Vulkan conformance version tries it again with them shown:
/// Mesa's hasvk drives Ivy Bridge and Haswell, works, and reports 0.0.0.0, so
/// without this the player is told they have no graphics driver while Vulkan
/// runs (a `gl not compatible with provided surface` fallback, or nothing, is
/// all they get). Returns why the backend gave no device.
    // rust: async fn open_with_retry(
    // rust: backends: wgpu::Backends,
    // rust: window: &Arc<Window>,
    // rust: offscreen: bool,
    // rust: layers: u32,
    // rust: allow_cpu: bool,
    // rust: ) -> std::result::Result<Opened, String> {
    // rust: match open_backend(backends, window, offscreen, false, layers, allow_cpu).await {
    // rust: Err(NoDevice::NoAdapter(hidden)) => {
    // rust: log::warn!(
    // rust: "Horizon renderer: {} has no conformant adapter ({hidden}); asking again for the \
    // rust: ones wgpu hides as non-conformant",
    // rust: backends_name(backends)
    // rust: );
    // rust: match open_backend(backends, window, offscreen, true, layers, allow_cpu).await {
    // rust: Ok(opened) => {
    // rust: log::warn!(
    // rust: "Horizon renderer: using {} although its driver reports no Vulkan \
    // rust: conformance version",
    // rust: opened.adapter.get_info().name
    // rust: );
    // rust: Ok(opened)
}
    // rust: Err(NoDevice::NoAdapter(e)) | Err(NoDevice::Failed(e)) => Err(e),
}
}
    // rust: Err(NoDevice::Failed(e)) => Err(e),
    // rust: Ok(opened) => Ok(opened),
}
}
/// Opens a device on `backends` alone: its surface, adapter and device, or what
/// stopped it. `allow_nonconformant` is `open_with_retry`'s second try; a
/// software adapter is taken only when `allow_cpu`.
    // rust: async fn open_backend(
    // rust: backends: wgpu::Backends,
    // rust: window: &Arc<Window>,
    // rust: offscreen: bool,
    // rust: allow_nonconformant: bool,
    // rust: layers: u32,
    // rust: allow_cpu: bool,
    // rust: ) -> std::result::Result<Opened, NoDevice> {
    // rust: let name = backends_name(backends);
    // rust: let instance = wgpu::Instance::new(instance_descriptor(
    // rust: backends,
    // rust: Some(window),
    // rust: allow_nonconformant,
    // rust: ));
    // rust: let surface = if offscreen {
    // rust: None
    // rust: } else {
    // rust: match instance.create_surface(window.clone()) {
    // rust: Ok(surface) => Some(surface),
    // rust: Err(e) => return Err(NoDevice::Failed(format!("{name} surface: {e}"))),
}
}
    // rust: let adapter = match instance
    // rust: .request_adapter(&wgpu::RequestAdapterOptions {
    // rust: power_preference: wgpu::PowerPreference::HighPerformance,
    // rust: compatible_surface: surface.as_ref(),
    // rust: force_fallback_adapter: false,
    // rust: ..Default::default()
    // rust: })
    // rust: .await
    // rust: {
    // rust: Ok(adapter) => adapter,
    // rust: Err(e) => return Err(NoDevice::NoAdapter(format!("{name}: {e}"))),
}
    // NoAdapter, so `open_with_retry` asks again: with the non-conformant
    // adapters shown, wgpu ranks a real GPU (hasvk on Ivy Bridge or Haswell)
    // above a software one. The second try's error is final either way.
    // rust: if !allow_cpu && is_software(adapter.get_info().device_type) {
    // rust: return Err(NoDevice::NoAdapter(format!(
    // rust: "{name}: only a software adapter ({})",
    // rust: adapter.get_info().name
    // rust: )));
}
    // rust: describe_adapter(&adapter);
    // rust: let info = adapter.get_info();
    // rust: let limits = adapter.limits();
    // rust: if let Err(e) = check_layers(&adapter, layers) {
    // rust: return Err(NoDevice::Failed(format!("{name}: {e}")));
}
    // Mappable primary buffers: section pages that no longer fit in
    // video memory go to system memory. Shader packs' 16-bit normalized buffers (render
    // targets with the adapter's own format features) and R11F_G11F_B10F: a float
    // stand-in neither clamps nor drops NaN. Subgroups: shader packs' compute programs
    // (`MC_GL_KHR_shader_subgroup_*`); storage buffers in vertex shaders, clearing and
    // atomics on images: their buffers and images. Filtering 32-bit float textures: shader
    // packs' RGBA32F buffers, which GL filters and mipmaps. Count draws: GPU culling's (`gpu_culling`).
    // rust: let features = timing::GpuTimer::features(&adapter)
    // rust: | cull::Cull::features(&adapter)
    // rust: | oit::features(&adapter)
    // rust: | (adapter.features()
    // rust: & (wgpu::Features::INDIRECT_FIRST_INSTANCE
    // rust: | wgpu::Features::MULTI_DRAW_INDIRECT_COUNT
    // rust: | wgpu::Features::MAPPABLE_PRIMARY_BUFFERS
    // rust: | wgpu::Features::TEXTURE_FORMAT_16BIT_NORM
    // rust: | wgpu::Features::TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES
    // rust: | wgpu::Features::RG11B10UFLOAT_RENDERABLE
    // rust: | wgpu::Features::SUBGROUP
    // rust: | wgpu::Features::VERTEX_WRITABLE_STORAGE
    // rust: | wgpu::Features::CLEAR_TEXTURE
    // rust: | wgpu::Features::TEXTURE_ATOMIC
    // rust: | wgpu::Features::FLOAT32_FILTERABLE));
    // rust: let driver = format!("{} {}", info.driver, info.driver_info);
    // rust: startup_step(format_args!(
    // rust: "requesting the device (driver {}) with features [{features}] and the adapter's \
    // rust: limits (buffers up to {} bytes, storage bindings up to {} bytes, {} texture layers)",
    // rust: match driver.trim() {
    // rust: "" => "unnamed",
    // rust: driver => driver,
    // rust: },
    // rust: limits.max_buffer_size,
    // rust: limits.max_storage_buffer_binding_size,
    // rust: limits.max_texture_array_layers,
    // rust: ));
    // rust: let desc = wgpu::DeviceDescriptor {
    // rust: label: Some("Horizon device"),
    // rust: required_features: features,
    // rust: required_limits: limits,
        // Video memory in blocks of 8-64 MiB instead of 128-256 MiB (Vulkan and DirectX 12):
        // with the larger blocks a few small buffers kept whole blocks the arena's pages had
        // left, and over half the video memory reserved was unused (1,344 MiB for 500).
    // rust: memory_hints: wgpu::MemoryHints::MemoryUsage,
    // rust: ..Default::default()
}
    // rust: let opened = match info.backend {
    // rust: wgpu::Backend::Vulkan => horizon_hdr::open_vulkan_device(&adapter, &desc),
    // rust: _ => None,
}
    // rust: let opened = None;
    // rust: let opened = match opened {
    // rust: Some(opened) => opened,
    // rust: None => adapter.request_device(&desc).await,
}
    // rust: match opened {
    // rust: Ok((device, queue)) => {
    // rust: let device_lost = Arc::new(std::sync::atomic::AtomicBool::new(false));
    // rust: let lost = device_lost.clone();
    // rust: device.set_device_lost_callback(move |reason, message| {
                // A device destroyed on purpose was not lost.
    // rust: if reason == wgpu::DeviceLostReason::Destroyed {
    // rust: return;
}
    // rust: log::warn!(
    // rust: "Horizon renderer: the graphics device was lost ({reason:?}: {message})"
    // rust: );
    // rust: lost.store(true, std::sync::atomic::Ordering::Relaxed);
    // rust: });
    // rust: Ok(Opened {
    // rust: instance,
    // rust: surface,
    // rust: adapter,
    // rust: device,
    // rust: queue,
    // rust: device_lost,
    // rust: })
}
    // rust: Err(e) => Err(NoDevice::Failed(format!("{name} device: {e}"))),
}
}
/// What to tell a player whose system offers no usable graphics adapter.
/// Vulkan is loaded at run time (the game links no graphics library), so a
/// missing driver shows here rather than as a missing-DLL dialog.
    // rust: const NO_GPU_DRIVER: &str = "No graphics driver with Vulkan, DirectX 12 or OpenGL found: Horizon needs \
    // rust: a GPU driver with one of them. Install the latest driver for your NVIDIA, AMD or Intel GPU and \
    // rust: start the game again";
pub const NO_GPU_DRIVER: []const u8 = "No Metal graphics device found";
    // rust: const NO_GPU_DRIVER: &str = "No Vulkan or OpenGL graphics driver found: Horizon needs the Vulkan loader \
    // rust: (libvulkan.so.1) and a Vulkan driver for your GPU (Mesa's, or NVIDIA's), or OpenGL through EGL";
/// Logs a step of the renderer's start, for a native crash in the graphics
/// driver: it leaves no panic or crash report, so the log's last line is the
/// only sign of where the game stopped. The log file is written unbuffered;
/// the flush is for loggers that buffer.
pub fn startup_step(step: std::fmt::Arguments) void {
}
    // rust: log::info!("Horizon renderer: {step}");
    // rust: log::logger().flush();
}
/// How far the first frame on a new device got, for `startup_step`.
pub const FirstFrame = enum {
    Acquire,
    Submit,
    Drawn,
};
pub fn on_off(on: bool) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if on { "on" } else { "off" }
}
    // rust: impl Renderer {
    /// Sections with GPU buffers, for soak tests watching residency.
pub fn resident_sections(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sections.len()
}
    /// Quads of the far terrain tiles with GPU buffers.
pub fn lod_quads(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.lods
    // rust: .values()
    // rust: .map(|tile| u64::from(tile.mesh.solid + tile.mesh.translucent))
    // rust: .sum()
}
    /// Tiles and quads of the far terrain tiles with GPU buffers, by level.
pub fn lod_levels(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut levels = Vec::new();
    // rust: for (key, tile) in &self.lods {
    // rust: let level = usize::from(key.level);
    // rust: if levels.len() <= level {
    // rust: levels.resize(level + 1, [0, 0]);
}
    // rust: levels[level][0] += 1;
    // rust: levels[level][1] += u64::from(tile.mesh.solid + tile.mesh.translucent);
}
    // rust: levels
}
    /// Bytes of the section vertex arenas' buffers, and of the vertices
    /// resident sections hold in them.
pub fn section_vertex_bytes(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stride = std::mem::size_of::<TerrainVertex>() as u64;
    // rust: let vertices: u64 = self
    // rust: .sections
    // rust: .values()
    // rust: .chain(self.lods.values().map(|tile| &tile.mesh))
    // rust: .map(|s| s.solid_slots + u64::from(s.translucent) * 4)
    // rust: .sum();
    // rust: let translucent = self.translucent_arena.as_ref();
    // rust: let arenas = self.arena.bytes() + translucent.map_or(0, arena::Arena::bytes);
    // rust: [arenas, vertices * stride]
}
    /// Bytes of the renderer's largest GPU resources, by name (`scene_replay --memory`):
    /// the terrain arenas (their pages, and what resident sections and far tiles use of
    /// them), the quad indices, the block sprites with their mips, the LabPBR maps, flat
    /// draws' buffers and the visibility buffer's.
pub fn gpu_census(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stride = std::mem::size_of::<TerrainVertex>() as u64;
    // rust: let used = |s: &SectionGpu| (s.solid_slots + u64::from(s.translucent) * 4) * stride;
    // rust: let textures = |t: &[wgpu::Texture]| t.iter().map(texture_bytes).sum::<u64>();
    // rust: let translucent = self.translucent_arena.as_ref();
    // rust: vec![
    // rust: ("section_arena_pages", self.arena.bytes()),
    // rust: (
    // rust: "translucent_arena_pages",
    // rust: translucent.map_or(0, arena::Arena::bytes),
    // rust: ),
    // rust: ("sorted_index_pages", self.sorted_indices.bytes()),
    // rust: (
    // rust: "near_section_vertices",
    // rust: self.sections.values().map(used).sum(),
    // rust: ),
    // rust: (
    // rust: "far_tile_vertices",
    // rust: self.lods.values().map(|tile| used(&tile.mesh)).sum(),
    // rust: ),
    // rust: ("quad_indices", self.indices.size()),
    // rust: ("block_sprites", textures(&self.sprite_textures)),
    // rust: (
    // rust: "pbr_maps",
    // rust: self.pbr_maps
    // rust: .as_ref()
    // rust: .map_or(0, |maps| maps.iter().flatten().map(texture_bytes).sum()),
    // rust: ),
    // rust: (
    // rust: "flat_draws",
    // rust: self.flat.as_ref().map_or(0, flat::Flat::bytes),
    // rust: ),
    // rust: (
    // rust: "visibility_buffer",
    // rust: self.visbuf.as_ref().map_or(0, visbuffer::Visbuffer::bytes),
    // rust: ),
    // rust: ]
}
    /// Device memory the backend's allocator holds, by the label of what holds
    /// it, largest first, with its allocated and reserved totals (Vulkan and
    /// DirectX 12; none on Metal and OpenGL) (`horizon-ctl memory`).
pub fn gpu_memory_by_label(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let report = self.device.generate_allocator_report()?;
    // rust: let mut by_label: HashMap<String, u64> = HashMap::new();
    // rust: for a in report.allocations {
    // rust: *by_label.entry(a.name).or_default() += a.size;
}
    // rust: let mut labels: Vec<_> = by_label.into_iter().collect();
    // rust: labels.sort_by(|a, b| b.1.cmp(&a.1).then_with(|| a.0.cmp(&b.0)));
    // rust: Some((
    // rust: report.total_allocated_bytes,
    // rust: report.total_reserved_bytes,
    // rust: labels,
    // rust: ))
}
    /// Heap bytes of the renderer's per-section bookkeeping (`horizon-ctl memory`):
    /// resident sections, far tiles, block entities and light sources by section.
pub fn cpu_census(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
//         use std::mem::size_of;
    // rust: let per_section = |map_len: usize, lists: usize| {
    // rust: map_len * (size_of::<SectionKey>() + size_of::<Vec<([i32; 3], u32)>>() + 1)
    // rust: + lists * size_of::<([i32; 3], u32)>()
}
    // rust: let lists = |map: &crate::fast_hash::FxHashMap<SectionKey, Vec<([i32; 3], u32)>>| {
    // rust: per_section(
    // rust: map.capacity(),
    // rust: map.values().map(Vec::capacity).sum::<usize>(),
    // rust: )
}
    // rust: let animated: usize = self
    // rust: .sections
    // rust: .values()
    // rust: .map(|s| s.animated_layers.len() * size_of::<u16>())
    // rust: .sum();
    // rust: [
    // rust: ("resident_sections", self.sections.heap_bytes() + animated),
    // rust: (
    // rust: "far_tiles",
    // rust: self.lods.capacity()
    // rust: * (size_of::<crate::lod::TileKey>() + size_of::<lod::Tile>() + 1),
    // rust: ),
    // rust: ("block_entities", lists(&self.block_entities)),
    // rust: ("light_sources", lists(&self.light_blocks)),
    // rust: ]
}
}
    // rust: impl Renderer {
    // rust: pub async fn new(
    // rust: window: Arc<Window>,
    // rust: offscreen: bool,
    // rust: sprite_pixels: &[u8],
    // rust: sprite_size: u32,
    // rust: sprite_minimum_size: u32,
    // rust: layers: u32,
    // rust: sprite_mips: &[crate::mipmap::Settings],
    // rust: animations: &[SpriteAnimation],
    // rust: hud_atlas: (&[u8], u32, u32),
    // rust: glint: (&[u8], u32, u32),
    // rust: glint_armor: (&[u8], u32, u32),
    // rust: forcefield: (&[u8], u32),
    // rust: panorama_faces: Arc<panorama::Faces>,
    // rust: prepared: Option<PreparedTextures>,
    // rust: previous: Option<&Self>,
    // rust: api: GraphicsApi,
    // rust: translucent_batching: bool,
    // rust: wide_frame: bool,
    // rust: shader_pack: bool,
    // rust: ) -> Result<Self> {
    // rust: let Opened {
    // rust: instance,
    // rust: surface,
    // rust: adapter,
    // rust: device,
    // rust: queue,
    // rust: device_lost,
    // rust: } = match previous {
            // Reload resources on the same device; replacing live Vulkan
            // devices can invalidate the driver's swapchain state on the same
            // window.
    // rust: Some(renderer) => {
    // rust: describe_adapter(&renderer.adapter);
    // rust: check_layers(&renderer.adapter, layers)?;
    // rust: Opened {
    // rust: surface: if offscreen {
    // rust: None
    // rust: } else {
    // rust: let spare = renderer
    // rust: .spare_surface
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner)
    // rust: .take();
    // rust: Some(match spare {
    // rust: Some(surface) => surface,
    // rust: None => renderer.instance.create_surface(window.clone())?,
    // rust: })
    // rust: },
    // rust: instance: renderer.instance.clone(),
    // rust: adapter: renderer.adapter.clone(),
    // rust: device: renderer.device.clone(),
    // rust: queue: renderer.queue.clone(),
    // rust: device_lost: renderer.device_lost.clone(),
}
}
    // rust: None => {
    // rust: let _step = crate::spans::startup::step("renderer.open_device");
    // rust: open_device(&window, offscreen, api, layers).await?
}
}
        // Computed once: the sprite arrays, the shaders' constants and the
        // shader pack atlas all cut the sprites by it.
    // rust: let split = check_layers(&adapter, layers)?;
    // rust: if split < sprite_split() {
    // rust: log::info!("Horizon: {split} block textures per array (the GPU's limit)");
}
    // rust: let info = adapter.get_info();
    // rust: crate::graphics::suggest_reduced_far_detail(crate::graphics::lod_capped(&info));
    // rust: let size = window.inner_size();
    // rust: let max_side = device.limits().max_texture_dimension_2d;
    // rust: let (config, present_modes, hdr_output) = if let Some(surface) = &surface {
    // rust: let mut config = surface
    // rust: .get_default_config(
    // rust: &adapter,
    // rust: size.width.clamp(1, max_side),
    // rust: size.height.clamp(1, max_side),
    // rust: )
    // rust: .ok_or("surface has no supported configuration")?;
    // rust: let caps = surface.get_capabilities(&adapter);
    // rust: config.format = surface_format(&caps.formats, config.format);
    // rust: config.view_formats = vec![config.format.remove_srgb_suffix()];
            // Screenshots copy the presented frame back from the swapchain, frame
            // generation's present thread copies its frames in.
    // rust: if caps.usages.contains(wgpu::TextureUsages::COPY_SRC) {
    // rust: config.usage |= wgpu::TextureUsages::COPY_SRC;
}
    // rust: if caps.usages.contains(wgpu::TextureUsages::COPY_DST) {
    // rust: config.usage |= wgpu::TextureUsages::COPY_DST;
}
    // rust: config.present_mode = previous
    // rust: .map(|renderer| renderer.config.present_mode)
    // rust: .filter(|mode| caps.present_modes.contains(mode))
    // rust: .unwrap_or_else(|| {
    // rust: if caps.present_modes.contains(&wgpu::PresentMode::Mailbox) {
    // rust: wgpu::PresentMode::Mailbox
    // rust: } else {
    // rust: wgpu::PresentMode::Fifo
}
    // rust: });
    // rust: if previous.is_none() {
    // rust: startup_step(format_args!(
    // rust: "device ready; configuring the surface ({}x{} {:?}, {:?})",
    // rust: config.width, config.height, config.format, config.present_mode
    // rust: ));
}
    // rust: surface.configure(&device, &config);
    // rust: let hdr_output = hdr::output(&caps);
    // rust: crate::graphics::offer_hdr(hdr_output.is_some());
    // rust: if previous.is_none() {
    // rust: log::info!(
    // rust: "Horizon renderer: HDR output {}",
    // rust: hdr_output.map_or("not offered by this display", hdr::Output::name)
    // rust: );
}
    // rust: (config, caps.present_modes.clone(), hdr_output)
    // rust: } else {
    // rust: let format = wgpu::TextureFormat::Bgra8Unorm;
    // rust: let config = wgpu::SurfaceConfiguration {
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | wgpu::TextureUsages::COPY_DST,
    // rust: format,
    // rust: width: size.width.clamp(1, max_side),
    // rust: height: size.height.clamp(1, max_side),
    // rust: present_mode: wgpu::PresentMode::Immediate,
    // rust: desired_maximum_frame_latency: 2,
    // rust: alpha_mode: wgpu::CompositeAlphaMode::Opaque,
    // rust: view_formats: vec![format],
    // rust: color_space: wgpu::SurfaceColorSpace::default(),
}
    // rust: let hdr_output = hdr::offscreen_output();
            // Only where one is named: splitscreen's views draw offscreen too, and their
            // window's renderer offers what its display does.
    // rust: if let Some(output) = hdr_output {
    // rust: crate::graphics::offer_hdr(true);
    // rust: if previous.is_none() {
    // rust: log::info!(
    // rust: "Horizon renderer: HDR output {} offscreen (HORIZON_HDR_OUTPUT)",
    // rust: output.name()
    // rust: );
}
}
    // rust: (config, Vec::new(), hdr_output)
}
    // rust: let offscreen = surface
    // rust: .is_none()
    // rust: .then(|| Self::offscreen_target(&device, &config));
    // rust: let wide_ok = draws_wide_frame(
    // rust: device.features(),
    // rust: adapter.get_texture_format_features(WIDE_FRAME),
    // rust: );
    // rust: crate::graphics::offer_smooth_gradients(wide_ok);
    // rust: let frame_format = frame_format(wide_frame, hdr_output.is_some(), wide_ok, config.format);
    // rust: if previous.is_none() {
    // rust: startup_step(format_args!("creating the pipelines"));
}
        // A renderer on the same device takes the previous one's shader
        // modules, layouts and pipelines where they come out the same.
    // rust: let reuse = previous.map_or_else(Default::default, |r| r.reuse.clone());
    // rust: let generation = reuse.begin();
    // rust: let kept = reuse.on(&device);
    // rust: let pipelines_step = crate::spans::startup::step("renderer.pipelines_textures");
    // rust: let terrain_step = crate::spans::startup::step("renderer.terrain_pipelines");
    // rust: let gpu_timer = timing::GpuTimer::new(&device, &queue);
    // rust: let shader = kept.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon terrain"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("terrain.wgsl").into()),
    // rust: });
    // rust: let entry = |binding, visibility, ty| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility,
    // rust: ty,
    // rust: count: None,
}
    // rust: let vf = wgpu::ShaderStages::VERTEX_FRAGMENT;
    // rust: let sprite_array = wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2Array,
    // rust: multisampled: false,
}
    // rust: let sprite_arrays = layers.div_ceil(split).max(1);
    // rust: if sprite_arrays > 1 {
    // rust: log::info!("Horizon: {layers} block textures in {sprite_arrays} arrays");
}
    // rust: let sprite_constants = [
    // rust: ("SPRITE_ARRAYS", f64::from(sprite_arrays)),
    // rust: ("SPRITE_SPLIT", f64::from(split)),
    // rust: ];
    // rust: let bindings = kept.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Horizon terrain bindings"),
    // rust: entries: &[
    // rust: entry(
    // rust: 0,
    // rust: vf,
    // rust: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: ),
    // rust: entry(
    // rust: 1,
    // rust: vf,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2Array,
    // rust: multisampled: false,
    // rust: },
    // rust: ),
    // rust: entry(
    // rust: 1 + 1,
    // rust: vf,
    // rust: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: ),
    // rust: entry(
    // rust: 3,
    // rust: vf,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: ),
    // rust: entry(
    // rust: 4,
    // rust: vf,
    // rust: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: ),
    // rust: entry(5, vf, sprite_array),
    // rust: entry(6, vf, sprite_array),
    // rust: entry(7, vf, sprite_array),
    // rust: entry(8, vf, sprite_array),
    // rust: entry(9, vf, sprite_array),
    // rust: entry(10, vf, sprite_array),
    // rust: entry(11, vf, sprite_array),
    // rust: entry(
    // rust: 12,
    // rust: vf,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: ),
    // rust: ],
    // rust: });
    // rust: let layout = kept.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Horizon terrain layout"),
    // rust: bind_group_layouts: &[Some(&bindings)],
    // rust: ..Default::default()
    // rust: });
    // rust: let instance_attributes = wgpu::vertex_attr_array![5=>Float32x4];
    // rust: let terrain_buffers = [
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<TerrainVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &TERRAIN_ATTRIBUTES,
    // rust: }),
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 16,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &instance_attributes,
    // rust: }),
    // rust: ];
    // rust: let alpha_blend = wgpu::BlendState::ALPHA_BLENDING;
    // rust: let debug_line_attributes =
    // rust: wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x3,2=>Unorm8x4,3=>Float32];
    // rust: let debug_line_buffers = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 32,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &debug_line_attributes,
    // rust: })];
    // rust: let pipeline_in = |layout: &wgpu::PipelineLayout,
    // rust: label: &str,
    // rust: vertex: &str,
    // rust: fragment: &str,
    // rust: buffers: &[Option<wgpu::VertexBufferLayout<'_>>],
    // rust: topology: wgpu::PrimitiveTopology,
    // rust: cull: Option<wgpu::Face>,
    // rust: depth_write: bool,
    // rust: depth_test: bool,
    // rust: blend: Option<wgpu::BlendState>| {
    // rust: kept.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(label),
    // rust: layout: Some(layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some(vertex),
    // rust: compilation_options: Default::default(),
    // rust: buffers,
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: topology,
    // rust: cull_mode: cull,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(depth_write),
    // rust: depth_compare: Some(if depth_test {
    // rust: wgpu::CompareFunction::GreaterEqual
    // rust: } else {
    // rust: wgpu::CompareFunction::Always
    // rust: }),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some(fragment),
    // rust: compilation_options: wgpu::PipelineCompilationOptions {
    // rust: constants: &sprite_constants,
    // rust: ..Default::default()
    // rust: },
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: frame_format,
    // rust: blend,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let pipeline = |label: &str,
    // rust: vertex: &str,
    // rust: fragment: &str,
    // rust: buffers: &[Option<wgpu::VertexBufferLayout<'_>>],
    // rust: topology: wgpu::PrimitiveTopology,
    // rust: cull: Option<wgpu::Face>,
    // rust: depth_write: bool,
    // rust: depth_test: bool,
    // rust: blend: Option<wgpu::BlendState>| {
    // rust: pipeline_in(
    // rust: &layout,
    // rust: label,
    // rust: vertex,
    // rust: fragment,
    // rust: buffers,
    // rust: topology,
    // rust: cull,
    // rust: depth_write,
    // rust: depth_test,
    // rust: blend,
    // rust: )
}
    // rust: let tri = wgpu::PrimitiveTopology::TriangleList;
    // rust: let solid = pipeline(
    // rust: "Terrain solid",
    // rust: "vs_terrain",
    // rust: "fs_solid",
    // rust: &terrain_buffers,
    // rust: tri,
    // rust: Some(wgpu::Face::Back),
    // rust: true,
    // rust: true,
    // rust: None,
    // rust: );
        // `solid` in two passes (terrain.wgsl's `opaque_quad`, `mesher::Part`), for the
        // world pass without a shader pack: no cutout first, through a shader that never
        // discards, then the rest.
    // rust: let solid_opaque = pipeline(
    // rust: "Terrain solid opaque",
    // rust: "vs_terrain_opaque",
    // rust: "fs_opaque",
    // rust: &terrain_buffers,
    // rust: tri,
    // rust: Some(wgpu::Face::Back),
    // rust: true,
    // rust: true,
    // rust: None,
    // rust: );
    // rust: let solid_cutout = pipeline(
    // rust: "Terrain solid cutout",
    // rust: "vs_terrain_cutout",
    // rust: "fs_solid",
    // rust: &terrain_buffers,
    // rust: tri,
    // rust: Some(wgpu::Face::Back),
    // rust: true,
    // rust: true,
    // rust: None,
    // rust: );
        // The water mirror's camera sees the world from the other side of the plane, which
        // flips the winding: its solid terrain culls the front.
    // rust: let solid_mirror = pipeline(
    // rust: "Terrain solid (mirrored)",
    // rust: "vs_terrain",
    // rust: "fs_solid_mirror",
    // rust: &terrain_buffers,
    // rust: tri,
    // rust: Some(wgpu::Face::Front),
    // rust: true,
    // rust: true,
    // rust: None,
    // rust: );
    // rust: let translucent = pipeline(
    // rust: "Terrain translucent",
    // rust: "vs_terrain",
    // rust: "fs_translucent",
    // rust: &terrain_buffers,
    // rust: tri,
    // rust: Some(wgpu::Face::Back),
    // rust: true,
    // rust: true,
    // rust: Some(alpha_blend),
    // rust: );
    // rust: let translucent_mark = pipeline(
    // rust: "Terrain translucent HDR mark",
    // rust: "vs_terrain",
    // rust: "fs_translucent_mark",
    // rust: &terrain_buffers,
    // rust: tri,
    // rust: Some(wgpu::Face::Back),
    // rust: false,
    // rust: true,
    // rust: Some(flat::ALPHA_ONLY),
    // rust: );
    // rust: let sky = pipeline(
    // rust: "Sky",
    // rust: "vs_sky",
    // rust: "fs_sky",
    // rust: &[],
    // rust: tri,
    // rust: None,
    // rust: false,
    // rust: false,
    // rust: None,
    // rust: );
    // rust: let sky_base = pipeline(
    // rust: "Sky base",
    // rust: "vs_sky",
    // rust: "fs_sky_base",
    // rust: &[],
    // rust: tri,
    // rust: None,
    // rust: false,
    // rust: false,
    // rust: None,
    // rust: );
    // rust: let sunrise_attributes = wgpu::vertex_attr_array![0=>Float32x4, 1=>Float32];
    // rust: let sunrise_buffers = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 20,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &sunrise_attributes,
    // rust: })];
    // rust: let sunrise_blend = wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::SrcAlpha,
    // rust: dst_factor: wgpu::BlendFactor::OneMinusSrcAlpha,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
            // The sky's HDR alpha is the destination's; the fan only tints it.
    // rust: alpha: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::Zero,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
}
    // rust: let sunrise_pipeline = pipeline(
    // rust: "Sunrise fan",
    // rust: "vs_sunrise",
    // rust: "fs_sunrise",
    // rust: &sunrise_buffers,
    // rust: tri,
    // rust: None,
    // rust: false,
    // rust: false,
    // rust: Some(sunrise_blend),
    // rust: );
    // rust: let dark_disc = pipeline(
    // rust: "Dark disc",
    // rust: "vs_sky",
    // rust: "fs_dark_disc",
    // rust: &[],
    // rust: tri,
    // rust: None,
    // rust: false,
    // rust: false,
    // rust: Some(alpha_blend),
    // rust: );
    // rust: let depth_reset = kept.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Hand depth reset"),
    // rust: layout: Some(&layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_sky"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(true),
    // rust: depth_compare: Some(wgpu::CompareFunction::Always),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some("fs_depth_reset"),
    // rust: compilation_options: wgpu::PipelineCompilationOptions {
    // rust: constants: &sprite_constants,
    // rust: ..Default::default()
    // rust: },
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: frame_format,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::empty(),
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let lines = pipeline(
    // rust: "Block outline",
    // rust: "vs_line",
    // rust: "fs_line",
    // rust: &debug_line_buffers,
    // rust: wgpu::PrimitiveTopology::TriangleStrip,
    // rust: None,
    // rust: true,
    // rust: true,
    // rust: Some(alpha_blend),
    // rust: );
        // RenderTypes.secondaryBlockOutline: the black stroke under a high contrast outline.
    // rust: let lines_secondary = pipeline(
    // rust: "Block outline secondary",
    // rust: "vs_line",
    // rust: "fs_line",
    // rust: &debug_line_buffers,
    // rust: wgpu::PrimitiveTopology::TriangleStrip,
    // rust: None,
    // rust: false,
    // rust: true,
    // rust: Some(alpha_blend),
    // rust: );
        // RenderPipelines.LINES: DepthStencilState.DEFAULT, so an opaque hitbox or
        // chunk border keeps the water and clouds drawn after it behind it.
    // rust: let debug_lines_opaque = pipeline(
    // rust: "Debug lines opaque",
    // rust: "vs_debug_line",
    // rust: "fs_debug_line",
    // rust: &debug_line_buffers,
    // rust: wgpu::PrimitiveTopology::TriangleStrip,
    // rust: None,
    // rust: true,
    // rust: true,
    // rust: Some(alpha_blend),
    // rust: );
    // rust: let debug_lines = pipeline(
    // rust: "Debug lines",
    // rust: "vs_debug_line",
    // rust: "fs_debug_line",
    // rust: &debug_line_buffers,
    // rust: wgpu::PrimitiveTopology::TriangleStrip,
    // rust: None,
    // rust: false,
    // rust: true,
    // rust: Some(alpha_blend),
    // rust: );
    // rust: let debug_lines_on_top = pipeline(
    // rust: "Debug lines on top",
    // rust: "vs_debug_line",
    // rust: "fs_debug_line",
    // rust: &debug_line_buffers,
    // rust: wgpu::PrimitiveTopology::TriangleStrip,
    // rust: None,
    // rust: false,
    // rust: false,
    // rust: Some(alpha_blend),
    // rust: );
    // rust: drop(terrain_step);
    // rust: let globals = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Horizon globals"),
    // rust: size: std::mem::size_of::<Globals>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let hand_globals = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("First-person hand globals"),
    // rust: size: std::mem::size_of::<Globals>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let crosshair_globals = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Debug crosshair globals"),
    // rust: size: std::mem::size_of::<Globals>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mirror_globals = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Water mirror globals"),
    // rust: size: std::mem::size_of::<Globals>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let prepared = match prepared {
    // rust: Some(prepared) => prepared.resplit(layers, split),
    // rust: None => PreparedTextures::with_split(
    // rust: sprite_pixels,
    // rust: sprite_size,
    // rust: layers,
    // rust: sprite_mips,
    // rust: forcefield,
    // rust: split,
    // rust: ),
}
    // rust: let mut mip_levels = 1;
    // rust: let gl = adapter.get_info().backend == wgpu::Backend::Gl;
        // Keep every colour layer's companion, split by the same device limit. Native
        // material stages read the first array; terrain packs stitch all of them.
    // rust: let pbr_maps = prepared
    // rust: .pbr
    // rust: .map(|(normals, specular, levels, map_layers, size)| {
    // rust: let layer_bytes = normals.len() / map_layers as usize;
    // rust: (0..map_layers.div_ceil(split))
    // rust: .map(|array| {
    // rust: let first = array * split;
    // rust: let used = (map_layers - first).min(split);
    // rust: let count = array_layers(used, gl);
    // rust: [("LabPBR normals", &normals), ("LabPBR specular", &specular)].map(
    // rust: |(label, data)| {
    // rust: let start = first as usize * layer_bytes;
    // rust: let mut data =
    // rust: data[start..start + used as usize * layer_bytes].to_vec();
    // rust: data.resize(layer_bytes * count as usize, 0);
    // rust: device.create_texture_with_data(
    // rust: &queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: wgpu::Extent3d {
    // rust: width: size,
    // rust: height: size,
    // rust: depth_or_array_layers: count,
    // rust: },
    // rust: mip_level_count: levels,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &data,
    // rust: )
    // rust: },
    // rust: )
    // rust: })
    // rust: .collect()
    // rust: });
    // rust: let sprite_textures: Vec<wgpu::Texture> = prepared
    // rust: .sprites
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(array, (mut mips, levels))| {
    // rust: let first = array as u32 * split;
    // rust: let used = layers.saturating_sub(first).clamp(1, split);
    // rust: let count = array_layers(used, gl);
                // The extra layers are empty.
    // rust: mips.resize(mips.len() / used as usize * count as usize, 0);
    // rust: mip_levels = levels;
    // rust: device.create_texture_with_data(
    // rust: &queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some("Block sprites"),
    // rust: size: wgpu::Extent3d {
    // rust: width: sprite_size,
    // rust: height: sprite_size,
    // rust: depth_or_array_layers: count,
    // rust: },
    // rust: mip_level_count: levels,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_DST
                            // Shader packs' atlas copies them (pack_atlas.rs).
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | wgpu::TextureUsages::STORAGE_BINDING,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &mips,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let material_animations = animations
    // rust: .iter()
    // rust: .filter(|a| a.has_materials())
    // rust: .cloned()
    // rust: .collect();
    // rust: let animations = animate::SpriteAnimator::new(
    // rust: &device,
    // rust: animations,
    // rust: sprite_size,
    // rust: sprite_mips,
    // rust: &sprite_textures,
    // rust: split,
    // rust: animate::SpriteAnimator::compute(&adapter, &device),
    // rust: );
    // rust: let active_layer_words = animations.active_layer_words();
    // rust: let sprite_unused = device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Block sprites (unused)"),
    // rust: size: wgpu::Extent3d {
    // rust: width: 1,
    // rust: height: 1,
    // rust: depth_or_array_layers: array_layers(1, gl),
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&wgpu::TextureViewDescriptor {
    // rust: dimension: Some(wgpu::TextureViewDimension::D2Array),
    // rust: ..Default::default()
    // rust: });
    // rust: let sprite_views = sprite_views(&sprite_textures, &sprite_unused, None);
    // rust: let sprite_sampler = device.create_sampler(&sprite_sampler_descriptor(1));
    // rust: let sprite_nearest = device.create_sampler(&SPRITE_NEAREST);
    // rust: let lightmap = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Lightmap"),
    // rust: size: wgpu::Extent3d {
    // rust: width: 16,
    // rust: height: 16,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: let lightmap_view = lightmap.create_view(&Default::default());
    // rust: let lightmap_sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Lightmap"),
    // rust: mag_filter: wgpu::FilterMode::Linear,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: ..Default::default()
    // rust: });
    // rust: let emission_stats =
    // rust: hdr_stats::EmissionStats::new(&device, split, sprite_textures.len() as u32);
    // rust: let group = terrain_group(
    // rust: &device,
    // rust: "Horizon terrain resources",
    // rust: &bindings,
    // rust: &globals,
    // rust: &sprite_views,
    // rust: &sprite_sampler,
    // rust: &lightmap_view,
    // rust: &lightmap_sampler,
    // rust: &emission_stats.view,
    // rust: );
    // rust: let crosshair_group = terrain_group(
    // rust: &device,
    // rust: "Debug crosshair resources",
    // rust: &bindings,
    // rust: &crosshair_globals,
    // rust: &sprite_views,
    // rust: &sprite_sampler,
    // rust: &lightmap_view,
    // rust: &lightmap_sampler,
    // rust: &emission_stats.view,
    // rust: );
    // rust: let mirror_group = terrain_group(
    // rust: &device,
    // rust: "Water mirror resources",
    // rust: &bindings,
    // rust: &mirror_globals,
    // rust: &sprite_views,
    // rust: &sprite_sampler,
    // rust: &lightmap_view,
    // rust: &lightmap_sampler,
    // rust: &emission_stats.view,
    // rust: );
    // rust: let index_quads = 1 << 16;
    // rust: let indices = Self::quad_indices(&device, index_quads);
    // rust: let instance_capacity = 4096;
    // rust: let instances = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Section origins"),
    // rust: size: instance_capacity * 16,
    // rust: usage: wgpu::BufferUsages::VERTEX
    // rust: | wgpu::BufferUsages::COPY_DST
    // rust: | wgpu::BufferUsages::STORAGE,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let outline = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Outline"),
    // rust: size: 32 * 2 * MAX_OUTLINE_EDGES,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let debug_line_buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Debug lines"),
    // rust: size: 32 * 4096,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let (atlas_pixels, atlas_width, atlas_height) = hud_atlas;
    // rust: let limit = device.limits().max_texture_dimension_2d;
    // rust: if atlas_width.max(atlas_height) > limit {
    // rust: return Err(format!(
    // rust: "the shared atlas is {atlas_width}x{atlas_height}; this GPU allows {limit}x{limit}"
    // rust: )
    // rust: .into());
}
    // rust: let atlas = device.create_texture_with_data(
    // rust: &queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some("Shared atlas"),
    // rust: size: wgpu::Extent3d {
    // rust: width: atlas_width,
    // rust: height: atlas_height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
                // COPY_SRC: a shader pack's weather copies the rain and snow sprites out.
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_DST
    // rust: | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: atlas_pixels,
    // rust: );
    // rust: let atlas_view = atlas.create_view(&Default::default());
        // vanilla's `GlintSampler`: enchanted_glint_item as its own texture,
        // repeated per pixel (`clamp: false`), linear without mipmaps
        // (`blur: true`).
    // rust: let (glint_pixels, glint_width, glint_height) = glint;
    // rust: let glint_texture = device.create_texture_with_data(
    // rust: &queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some("Enchanted glint"),
    // rust: size: wgpu::Extent3d {
    // rust: width: glint_width,
    // rust: height: glint_height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: glint_pixels,
    // rust: );
    // rust: let glint_view = glint_texture.create_view(&Default::default());
    // rust: let glint_sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Glint"),
    // rust: address_mode_u: wgpu::AddressMode::Repeat,
    // rust: address_mode_v: wgpu::AddressMode::Repeat,
    // rust: mag_filter: wgpu::FilterMode::Linear,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: ..Default::default()
    // rust: });
        // ARMOR_ENTITY_GLINT_TEXTURING's sampler is vanilla's GlintSampler: the
        // same repeat and linear filtering as the item glint.
    // rust: let (glint_armor_pixels, glint_armor_width, glint_armor_height) = glint_armor;
    // rust: let glint_armor_texture = device.create_texture_with_data(
    // rust: &queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some("Enchanted armor glint"),
    // rust: size: wgpu::Extent3d {
    // rust: width: glint_armor_width,
    // rust: height: glint_armor_height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: glint_armor_pixels,
    // rust: );
    // rust: let glint_armor_view = glint_armor_texture.create_view(&Default::default());
    // rust: let mut hud = HudRenderer::new(
    // rust: &device,
    // rust: frame_format,
    // rust: &atlas_view,
    // rust: &glint_view,
    // rust: &glint_sampler,
    // rust: )?;
    // rust: hud.atlas_texture = Some(atlas.clone());
    // rust: let entity_step = crate::spans::startup::step("renderer.entity_pipelines");
    // rust: let entity_shader = kept.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon entities"),
    // rust: source: wgpu::ShaderSource::Wgsl(entity_shader().into()),
    // rust: });
    // rust: let static_entity_shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon static block entities"),
    // rust: source: wgpu::ShaderSource::Wgsl(static_entity_shader().into()),
    // rust: });
    // rust: let entity_bindings = kept.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Entity bindings"),
    // rust: entries: &[
    // rust: entry(
    // rust: 0,
    // rust: vf,
    // rust: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: ),
    // rust: entry(
    // rust: 1,
    // rust: vf,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: ),
    // rust: entry(
    // rust: 2,
    // rust: vf,
    // rust: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: ),
    // rust: entry(
    // rust: 3,
    // rust: vf,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: ),
    // rust: entry(
    // rust: 4,
    // rust: vf,
    // rust: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: ),
    // rust: entry(
    // rust: 5,
    // rust: vf,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: ),
    // rust: entry(
    // rust: 6,
    // rust: vf,
    // rust: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: ),
    // rust: entry(
    // rust: 7,
    // rust: vf,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: ),
    // rust: ],
    // rust: });
    // rust: let static_entity_bindings =
    // rust: device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Static block-entity transform"),
    // rust: entries: &[entry(
    // rust: 0,
    // rust: wgpu::ShaderStages::VERTEX,
    // rust: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: )],
    // rust: });
    // rust: let weather =
    // rust: weather::Weather::new(&device, frame_format, &entity_bindings, &entity_shader);
    // rust: let atlas_sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Atlas"),
    // rust: ..Default::default()
    // rust: });
    // rust: let entity_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Entity resources"),
    // rust: layout: &entity_bindings,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: globals.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(&atlas_view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&atlas_sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(&lightmap_view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: wgpu::BindingResource::Sampler(&lightmap_sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 5,
    // rust: resource: wgpu::BindingResource::TextureView(&glint_view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 6,
    // rust: resource: wgpu::BindingResource::Sampler(&glint_sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 7,
    // rust: resource: wgpu::BindingResource::TextureView(&glint_armor_view),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let static_entity_transform =
    // rust: device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Static block-entity camera position"),
    // rust: contents: bytemuck::bytes_of(&StaticEntityUniform {
    // rust: camera_block: [0; 4],
    // rust: camera_fraction: [0.0; 4],
    // rust: }),
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: });
    // rust: let static_entity_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Static block-entity transform"),
    // rust: layout: &static_entity_bindings,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: static_entity_transform.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: let hand_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("First-person hand resources"),
    // rust: layout: &entity_bindings,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: hand_globals.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(&atlas_view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&atlas_sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(&lightmap_view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: wgpu::BindingResource::Sampler(&lightmap_sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 5,
    // rust: resource: wgpu::BindingResource::TextureView(&glint_view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 6,
    // rust: resource: wgpu::BindingResource::Sampler(&glint_sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 7,
    // rust: resource: wgpu::BindingResource::TextureView(&glint_armor_view),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let entity_layout = kept.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Entity layout"),
    // rust: bind_group_layouts: &[Some(&entity_bindings)],
    // rust: ..Default::default()
    // rust: });
    // rust: let static_entity_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Static block-entity layout"),
    // rust: bind_group_layouts: &[Some(&entity_bindings), Some(&static_entity_bindings)],
    // rust: ..Default::default()
    // rust: });
    // rust: let cloud_bindings = kept.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Cloud bindings"),
    // rust: entries: &[entry(
    // rust: 0,
    // rust: wgpu::ShaderStages::VERTEX,
    // rust: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: )],
    // rust: });
    // rust: let cloud_uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Cloud transforms and colors"),
    // rust: size: std::mem::size_of::<crate::clouds::Uniform>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let cloud_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Cloud resources"),
    // rust: layout: &cloud_bindings,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: cloud_uniform.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: let cloud_layout = kept.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Cloud layout"),
    // rust: bind_group_layouts: &[Some(&entity_bindings), Some(&cloud_bindings)],
    // rust: ..Default::default()
    // rust: });
    // rust: let cloud_buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Cloud vertices"),
    // rust: size: 4 * std::mem::size_of::<Vertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let entity_attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2,2=>Uint32,3=>Unorm8x4,4=>Uint8x4,5=>Snorm8x4,6=>Float32x2];
    // rust: let entity_vertex = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &entity_attributes,
    // rust: })];
    // rust: let static_entity_origin_attributes = wgpu::vertex_attr_array![7=>Sint32x3];
    // rust: let static_entity_vertex = [
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &entity_attributes,
    // rust: }),
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<[i32; 3]>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &static_entity_origin_attributes,
    // rust: }),
    // rust: ];
    // rust: let entity_pipeline_with = |label,
    // rust: cull_mode,
    // rust: depth_write,
    // rust: compare,
    // rust: bias,
    // rust: blend,
    // rust: clouds,
    // rust: fragment: &str,
    // rust: write_mask| {
    // rust: kept.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(label),
    // rust: layout: Some(if clouds {
    // rust: &cloud_layout
    // rust: } else {
    // rust: &entity_layout
    // rust: }),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &entity_shader,
    // rust: entry_point: Some(if clouds { "vs_cloud" } else { "vs_entity" }),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &entity_vertex,
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(depth_write),
    // rust: depth_compare: Some(compare),
    // rust: stencil: Default::default(),
    // rust: bias,
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &entity_shader,
    // rust: entry_point: Some(fragment),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: frame_format,
    // rust: blend: Some(blend),
    // rust: write_mask,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let entity_pipeline = |label, cull_mode, depth_write, compare, bias, blend, clouds| {
    // rust: entity_pipeline_with(
    // rust: label,
    // rust: cull_mode,
    // rust: depth_write,
    // rust: compare,
    // rust: bias,
    // rust: blend,
    // rust: clouds,
    // rust: "fs_entity",
    // rust: wgpu::ColorWrites::ALL,
    // rust: )
}
        // RenderPipelines.WATER_MASK: the boat's water patch writes depth only.
    // rust: let water_mask_pipeline = entity_pipeline_with(
    // rust: "Water mask",
    // rust: None,
    // rust: true,
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: Default::default(),
    // rust: alpha_blend,
    // rust: false,
    // rust: "fs_water_mask",
    // rust: wgpu::ColorWrites::empty(),
    // rust: );
    // rust: let crumbling_pipeline = entity_pipeline(
    // rust: "Breaking cracks",
    // rust: Some(wgpu::Face::Back),
    // rust: false,
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: wgpu::DepthBiasState {
    // rust: constant: 10,
    // rust: slope_scale: 1.0,
    // rust: clamp: 0.0,
    // rust: },
    // rust: CRUMBLING_BLEND,
    // rust: false,
    // rust: );
        // RenderPipelines.ENTITY_SHADOW: translucent, back-face culled, depth
        // test without writes. The quads lie exactly on the block tops like
        // vanilla's, facing +Y so looking up from below culls them, but
        // terrain and shadows are separate draw paths, so their fp32 depth
        // interpolations disagree by a few dozen ulps of the fragment depth
        // and the shadow's rim z-fights with the block top (speckle that
        // re-rolls as the camera drifts a subpixel). A constant bias of 128
        // ulps covers that spread at any resolution while staying far below
        // the 0.001 a model's feet sit higher, so shadows never bleed onto
        // the feet.
    // rust: let shadow_blob_pipeline = entity_pipeline_with(
    // rust: "Entity shadows",
    // rust: Some(wgpu::Face::Back),
    // rust: false,
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: wgpu::DepthBiasState {
    // rust: constant: 128,
    // rust: slope_scale: 0.015,
    // rust: clamp: 0.0,
    // rust: },
    // rust: alpha_blend,
    // rust: false,
    // rust: "fs_entity_shadow",
    // rust: wgpu::ColorWrites::ALL,
    // rust: );
        // RenderPipelines.ITEM_TRANSLUCENT: blended, depth tested and, like
        // every vanilla pipeline that does not turn it off, depth writing.
        // `LevelRenderer.executeClassicTransparency` draws the translucent
        // features before the translucent terrain, so without the writes
        // ice or water behind a dropped slime block or glass item would blend
        // over it and the item would all but vanish (#7031, #7033).
    // rust: let translucent_item_pipeline = entity_pipeline(
    // rust: "Translucent items",
    // rust: None,
    // rust: true,
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: Default::default(),
    // rust: alpha_blend,
    // rust: false,
    // rust: );
    // rust: let cloud_pipeline = entity_pipeline(
    // rust: "Clouds",
    // rust: Some(wgpu::Face::Back),
    // rust: true,
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: Default::default(),
    // rust: alpha_blend,
    // rust: true,
    // rust: );
    // rust: let hdr_cloud_mark_pipeline = entity_pipeline_with(
    // rust: "HDR cloud mark",
    // rust: Some(wgpu::Face::Back),
    // rust: false,
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: Default::default(),
    // rust: wgpu::BlendState::REPLACE,
    // rust: true,
    // rust: "fs_hdr_cloud_mark",
    // rust: wgpu::ColorWrites::ALPHA,
    // rust: );
        // RenderPipelines.TEXT_SEE_THROUGH: translucent, no depth test or
        // writes, culled like every world text pipeline (TEXT_SNIPPET keeps
        // RenderPipeline.Builder's default): a name tag or text display hides
        // its back.
    // rust: let see_through_pipeline = entity_pipeline(
    // rust: "See-through text",
    // rust: Some(wgpu::Face::Back),
    // rust: false,
    // rust: wgpu::CompareFunction::Always,
    // rust: Default::default(),
    // rust: alpha_blend,
    // rust: false,
    // rust: );
        // RenderPipelines.TEXT_POLYGON_OFFSET: a text display's text and
        // background win against the surface they lie on (bias 1, 10), from
        // the front only.
    // rust: let text_polygon_offset_pipeline = entity_pipeline(
    // rust: "Polygon offset text",
    // rust: Some(wgpu::Face::Back),
    // rust: true,
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: wgpu::DepthBiasState {
    // rust: constant: 10,
    // rust: slope_scale: 1.0,
    // rust: clamp: 0.0,
    // rust: },
    // rust: alpha_blend,
    // rust: false,
    // rust: );
    // rust: let world_text_pipeline = world_text::pipeline(
    // rust: &device,
    // rust: Some(&entity_layout),
    // rust: &entity_shader,
    // rust: config.format.remove_srgb_suffix(),
    // rust: );
        // RenderPipelines.ENTITY_SOLID: a surface of an entity that is coplanar with
        // terrain wins the tie in vanilla (the boat's floor over the trapdoor on the
        // ground it is stopped by, #5950). Terrain and entities are separate draw
        // paths here, so their fp32 depths of the same plane differ by a few dozen
        // ulps and the tie came out either way, as a jagged strip of the trapdoor
        // through the hull's floor. The same constant as the shadows' covers that
        // spread; a model's feet sit 0.001 above the ground, far beyond it.
    // rust: let entity_pipeline = entity_pipeline(
    // rust: "Entities",
    // rust: None,
    // rust: true,
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: wgpu::DepthBiasState {
    // rust: constant: 128,
    // rust: slope_scale: 0.0,
    // rust: clamp: 0.0,
    // rust: },
    // rust: alpha_blend,
    // rust: false,
    // rust: );
    // rust: let static_entity_pipeline =
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Static block entities"),
    // rust: layout: Some(&static_entity_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &static_entity_shader,
    // rust: entry_point: Some("vs_static_entity"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &static_entity_vertex,
    // rust: },
    // rust: primitive: wgpu::PrimitiveState::default(),
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(true),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &static_entity_shader,
    // rust: entry_point: Some("fs_entity"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: frame_format,
                        // fs_entity's discard handles binary cutout alpha. Any
                        // sprite with fractional alpha stays on the blended
                        // dynamic entity path.
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
        // RenderPipelines.ENERGY_SWIRL: BlendFunction.ADDITIVE (one, one), no culling; no depth
        // writes either: vanilla sorts the quads far to near, so every face passes the test.
    // rust: let one_one = wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::One,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
}
    // rust: let energy_swirl_pipeline = entity_pipeline_with(
    // rust: "Energy swirls",
    // rust: None,
    // rust: false,
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: Default::default(),
    // rust: wgpu::BlendState {
    // rust: color: one_one,
    // rust: alpha: one_one,
    // rust: },
    // rust: false,
    // rust: "fs_energy_swirl",
    // rust: wgpu::ColorWrites::ALL,
    // rust: );
        // HDR output's mark on light-giving particles (entity.wgsl fs_hdr_mark).
    // rust: let hdr_mark_pipeline = entity_pipeline_with(
    // rust: "HDR particle mark",
    // rust: None,
    // rust: false,
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: Default::default(),
    // rust: wgpu::BlendState::REPLACE,
    // rust: false,
    // rust: "fs_hdr_mark",
    // rust: wgpu::ColorWrites::ALPHA,
    // rust: );
    // rust: let hdr_hand_unmark_pipeline = entity_pipeline_with(
    // rust: "HDR hand unmark",
    // rust: None,
    // rust: false,
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: Default::default(),
    // rust: wgpu::BlendState::REPLACE,
    // rust: false,
    // rust: "fs_hdr_hand_unmark",
    // rust: wgpu::ColorWrites::ALPHA,
    // rust: );
        // Attribute 7: 6 is the entity vertex buffer's glint UV.
    // rust: let lightning_attributes = wgpu::vertex_attr_array![7=>Float32x3];
    // rust: let lightning_vertex = [
    // rust: entity_vertex[0].clone(),
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<[f32; 3]>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &lightning_attributes,
    // rust: }),
    // rust: ];
        // BlendFunction.LIGHTNING: src alpha, one; no depth writes.
    // rust: let additive_descriptor = wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Additive entities"),
    // rust: layout: Some(&entity_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &entity_shader,
    // rust: entry_point: Some("vs_entity"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &entity_vertex,
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: None,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(false),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &entity_shader,
    // rust: entry_point: Some("fs_celestial"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: frame_format,
    // rust: blend: Some(wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::SrcAlpha,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: alpha: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::SrcAlpha,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: }),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
}
    // rust: let additive_pipeline = kept.create_render_pipeline(&additive_descriptor);
        // `RenderPipelines.DRAGON_RAYS` uses DepthStencilState.DEFAULT:
        // unlike eyes, a ray hides the faces and rays behind it.
    // rust: let dragon_rays_pipeline = kept.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Dragon death rays"),
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: Some(wgpu::Face::Back),
    // rust: ..additive_descriptor.primitive
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: depth_write_enabled: Some(true),
    // rust: ..additive_descriptor.depth_stencil.clone().unwrap()
    // rust: }),
    // rust: ..additive_descriptor.clone()
    // rust: });
        // HDR output's mark on lightning bolts: fs_hdr_mark over the bolts' own vertex layout,
        // as hdr_mark_pipeline marks entities and particles (only alpha written).
    // rust: let mark_targets = [Some(wgpu::ColorTargetState {
    // rust: format: frame_format,
    // rust: blend: Some(wgpu::BlendState::REPLACE),
    // rust: write_mask: wgpu::ColorWrites::ALPHA,
    // rust: })];
    // rust: let hdr_mark_lightning_pipeline =
    // rust: kept.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("HDR lightning mark"),
    // rust: vertex: wgpu::VertexState {
    // rust: entry_point: Some("vs_lightning"),
    // rust: buffers: &lightning_vertex,
    // rust: ..additive_descriptor.vertex.clone()
    // rust: },
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &entity_shader,
    // rust: entry_point: Some("fs_hdr_mark"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &mark_targets,
    // rust: }),
    // rust: ..additive_descriptor.clone()
    // rust: });
    // rust: let lightning_pipeline = kept.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Lightning"),
    // rust: vertex: wgpu::VertexState {
    // rust: entry_point: Some("vs_lightning"),
    // rust: buffers: &lightning_vertex,
    // rust: ..additive_descriptor.vertex.clone()
    // rust: },
    // rust: ..additive_descriptor
    // rust: });
    // rust: let celestial_pipeline = kept.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Celestial bodies"),
    // rust: layout: Some(&entity_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &entity_shader,
    // rust: entry_point: Some("vs_entity"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &entity_vertex,
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: None,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(false),
    // rust: depth_compare: Some(wgpu::CompareFunction::Always),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &entity_shader,
    // rust: entry_point: Some("fs_sky_celestial"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: frame_format,
                    // RenderPipelines.CELESTIAL: additive (src alpha, one), with
                    // the colour premultiplied in fs_sky_celestial. Its alpha is
                    // how much a texel adds: HDR output (hdr.wgsl) lets the sun's
                    // and moon's discs shine; nothing else reads the frame's alpha.
    // rust: blend: Some(wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::One,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: alpha: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::Zero,
    // rust: dst_factor: wgpu::BlendFactor::OneMinusSrcAlpha,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: }),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: drop(entity_step);
        // WorldBorderRenderer: misc/forcefield.png as a MipmappedTexture
        // (repeat, linear minification with mipmaps, nearest magnification).
    // rust: let forcefield_size = forcefield.1;
    // rust: let (forcefield_mips, forcefield_levels) = prepared.forcefield;
    // rust: let forcefield_texture = device.create_texture_with_data(
    // rust: &queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some("Forcefield"),
    // rust: size: wgpu::Extent3d {
    // rust: width: forcefield_size,
    // rust: height: forcefield_size,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: forcefield_levels,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &forcefield_mips,
    // rust: );
    // rust: let forcefield_view = forcefield_texture.create_view(&Default::default());
    // rust: let forcefield_sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Forcefield"),
    // rust: address_mode_u: wgpu::AddressMode::Repeat,
    // rust: address_mode_v: wgpu::AddressMode::Repeat,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: mag_filter: wgpu::FilterMode::Nearest,
    // rust: mipmap_filter: wgpu::MipmapFilterMode::Linear,
    // rust: ..Default::default()
    // rust: });
    // rust: let border_uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("World border"),
    // rust: size: std::mem::size_of::<BorderUniform>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let border_vertices = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("World border vertices"),
    // rust: size: 16 * std::mem::size_of::<crate::border_render::BorderVertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let border_bindings = kept.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("World border bindings"),
    // rust: entries: &[
    // rust: entry(
    // rust: 0,
    // rust: vf,
    // rust: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: ),
    // rust: entry(
    // rust: 1,
    // rust: vf,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: ),
    // rust: entry(
    // rust: 2,
    // rust: vf,
    // rust: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: ),
    // rust: entry(
    // rust: 3,
    // rust: vf,
    // rust: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: ),
    // rust: ],
    // rust: });
    // rust: let border_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("World border resources"),
    // rust: layout: &border_bindings,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: globals.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(&forcefield_view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&forcefield_sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: border_uniform.as_entire_binding(),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let border_layout = kept.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("World border layout"),
    // rust: bind_group_layouts: &[Some(&border_bindings)],
    // rust: ..Default::default()
    // rust: });
    // rust: let border_shader = kept.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon world border"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("border.wgsl").into()),
    // rust: });
    // rust: let border_attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2];
        // RenderPipelines.WORLD_BORDER: BlendFunction.OVERLAY, no culling,
        // depth writes with a polygon offset of 3 towards the camera.
    // rust: let border_pipeline = kept.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("World border"),
    // rust: layout: Some(&border_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &border_shader,
    // rust: entry_point: Some("vs_border"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<crate::border_render::BorderVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &border_attributes,
    // rust: })],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: None,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(true),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: wgpu::DepthBiasState {
    // rust: constant: 3,
    // rust: slope_scale: 3.0,
    // rust: clamp: 0.0,
    // rust: },
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &border_shader,
    // rust: entry_point: Some("fs_border"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: frame_format,
    // rust: blend: Some(wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::SrcAlpha,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: alpha: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::One,
    // rust: dst_factor: wgpu::BlendFactor::Zero,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: }),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let screen_shader = kept.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon screen effects"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("screen.wgsl").into()),
    // rust: });
    // rust: let screen_attributes =
    // rust: wgpu::vertex_attr_array![0=>Float32x2,1=>Float32x2,2=>Float32x4,3=>Float32x4];
    // rust: let screen_vertex = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<crate::screen_effects::ScreenVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &screen_attributes,
    // rust: })];
    // rust: let vignette_blend = wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::Zero,
    // rust: dst_factor: wgpu::BlendFactor::OneMinusSrc,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: alpha: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::Zero,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
}
        // One per blend and `.png.mcmeta` sampling (screen_effects::SAMPLE_*):
        // the shader is specialised, so a pixel pays for none of the others.
    // rust: let screen_pipelines: [wgpu::RenderPipeline; 16] = std::array::from_fn(|i| {
    // rust: let blur = i as u32 & crate::screen_effects::SAMPLE_BLUR != 0;
    // rust: let (entry, blend) = match (i & 4 == 0, blur) {
    // rust: (true, false) => ("fs_screen", alpha_blend),
    // rust: (true, true) => ("fs_screen_blur", alpha_blend),
    // rust: (false, false) => ("fs_vignette", vignette_blend),
    // rust: (false, true) => ("fs_vignette_blur", vignette_blend),
}
    // rust: let clamp = i as u32 & crate::screen_effects::SAMPLE_CLAMP != 0;
    // rust: let constants = [("CLAMP", f64::from(u8::from(clamp)))];
    // rust: let compilation_options = wgpu::PipelineCompilationOptions {
    // rust: constants: &constants,
    // rust: ..Default::default()
}
    // rust: kept.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Screen effects"),
    // rust: layout: Some(&entity_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &screen_shader,
    // rust: entry_point: Some("vs_screen"),
    // rust: compilation_options: compilation_options.clone(),
    // rust: buffers: &screen_vertex,
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: None,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &screen_shader,
    // rust: entry_point: Some(entry),
    // rust: compilation_options,
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: frame_format,
    // rust: blend: Some(blend),
                        // 8 and up: colour only, for a tint of the world in HDR output.
    // rust: write_mask: if i & 8 == 0 {
    // rust: wgpu::ColorWrites::ALL
    // rust: } else {
    // rust: wgpu::ColorWrites::COLOR
    // rust: },
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
    // rust: });
    // rust: let screen_capacity = 64;
    // rust: let screen_buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Screen effect vertices"),
    // rust: size: screen_capacity
    // rust: * std::mem::size_of::<crate::screen_effects::ScreenVertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let celestial_buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Celestial vertices"),
    // rust: size: 2048 * 4 * std::mem::size_of::<Vertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let sunrise_buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Sunrise fan vertices"),
    // rust: size: (sunrise_fan::VERTICES * 5 * std::mem::size_of::<f32>()) as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let entity_capacity = 1 << 14;
    // rust: let entity_skin = entity_skin::EntitySkin::new(
    // rust: &device,
    // rust: animate::SpriteAnimator::compute(&adapter, &device),
    // rust: );
    // rust: let entity_buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Entity vertices"),
    // rust: size: entity_capacity * std::mem::size_of::<Vertex>() as u64,
    // rust: usage: entity_skin::EntitySkin::usage(entity_skin.is_some()),
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let static_entity_index_quads = 1 << 14;
    // rust: let static_entity_indices = Self::quad_indices(&device, static_entity_index_quads);
    // rust: let flat_wanted = flat::wanted(&adapter, &device);
        // Metal draws solid terrain in two passes (`split_solid`): meshes put all
        // their opaque quads first, so each pass draws its part in a run or two.
    // rust: crate::mesher::group_parts(adapter.get_info().backend == wgpu::Backend::Metal);
        // Readable as storage where flat draws run: a shader pack's terrain program reads them.
    // rust: let arena = arena::Arena::new(
    // rust: &device,
    // rust: std::mem::size_of::<TerrainVertex>() as u64,
    // rust: 1 << 20,
    // rust: flat_wanted,
    // rust: );
        // Sections as one index list per frame where multi-draw is emulated.
    // rust: let mut flat = flat_wanted.then(|| {
    // rust: let buffers = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<TerrainVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &TERRAIN_ATTRIBUTES,
    // rust: })];
    // rust: let info = adapter.get_info();
    // rust: let min_sections = if flat::is_broken_intel_vulkan(&info)
    // rust: || std::env::var("HORIZON_FLAT_DRAWS").as_deref() == Ok("1")
    // rust: {
    // rust: 0
    // rust: } else if flat::for_vanilla(&info) {
    // rust: flat::MIN_SECTIONS
    // rust: } else {
                // Only a shader pack's terrain and shadow pass draw flat here.
    // rust: usize::MAX
}
    // rust: flat::Flat::new(
    // rust: &device,
    // rust: &bindings,
    // rust: arena.page_vertices(),
    // rust: min_sections,
    // rust: |layout, label, vertex, fragment, blend, cull, pulled| {
    // rust: let buffers: &[Option<wgpu::VertexBufferLayout<'_>>] =
    // rust: if pulled { &[] } else { &buffers };
    // rust: pipeline_in(
    // rust: layout, label, vertex, fragment, buffers, tri, cull, true, true, blend,
    // rust: )
    // rust: },
    // rust: )
    // rust: });
        // With flat draws' page groups the per-section solid draws read their vertices from
        // the page too (`Flat::page_group`), in either layout of the solid quads
        // (`mesher::packed`): only the origins stay a vertex buffer, at slot 1.
    // rust: let (solid, solid_opaque, solid_cutout, solid_mirror) = match &flat {
    // rust: Some(f) => {
    // rust: let pulled_layout = kept.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Horizon terrain layout (pulled)"),
    // rust: bind_group_layouts: &[Some(&bindings), Some(&f.draw_layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let origins = [None, terrain_buffers[1].clone()];
    // rust: let pulled = |label: &str, vertex: &str, fragment: &str, cull| {
    // rust: pipeline_in(
    // rust: &pulled_layout,
    // rust: label,
    // rust: vertex,
    // rust: fragment,
    // rust: &origins,
    // rust: tri,
    // rust: Some(cull),
    // rust: true,
    // rust: true,
    // rust: None,
    // rust: )
}
    // rust: let back = wgpu::Face::Back;
    // rust: (
    // rust: pulled("Terrain solid", "vs_section", "fs_solid", back),
    // rust: pulled(
    // rust: "Terrain solid opaque",
    // rust: "vs_section_opaque",
    // rust: "fs_opaque",
    // rust: back,
    // rust: ),
    // rust: pulled(
    // rust: "Terrain solid cutout",
    // rust: "vs_section_cutout",
    // rust: "fs_solid",
    // rust: back,
    // rust: ),
    // rust: pulled(
    // rust: "Terrain solid (mirrored)",
    // rust: "vs_section",
    // rust: "fs_solid_mirror",
    // rust: wgpu::Face::Front,
    // rust: ),
    // rust: )
}
    // rust: None => (solid, solid_opaque, solid_cutout, solid_mirror),
}
        // The solid quads in the compact layout, while no shader pack reads the arena
        // (`follow_packed_layout`).
    // rust: let packed_quads = flat.is_some() && !shader_pack && packed_wanted();
    // rust: packed::pack_quads(packed_quads);
    // rust: let visbuf = flat
    // rust: .as_ref()
    // rust: .filter(|_| visbuffer::wanted(&device))
    // rust: .map(|f| {
    // rust: log::info!(
    // rust: "Horizon: solid terrain through a visibility buffer (HORIZON_VISBUFFER)"
    // rust: );
    // rust: visbuffer::Visbuffer::new(&device, &bindings, f, frame_format, &sprite_constants)
    // rust: });
    // rust: let multi_draw = device
    // rust: .features()
    // rust: .contains(wgpu::Features::INDIRECT_FIRST_INSTANCE)
    // rust: && adapter
    // rust: .get_downlevel_capabilities()
    // rust: .flags
    // rust: .contains(wgpu::DownlevelFlags::INDIRECT_EXECUTION);
    // rust: let batchable = translucent_batchable(&adapter.get_info(), multi_draw);
    // rust: crate::graphics::offer_translucent_batching(batchable);
    // rust: let translucent_batching = batchable && translucent_batching;
    // rust: let gpu_culling_offer = gpu_culling::offer(
    // rust: &adapter.get_info(),
    // rust: gpu_culling::supported(
    // rust: &adapter.get_info(),
    // rust: device.features(),
    // rust: adapter.get_downlevel_capabilities().flags,
    // rust: &device.limits(),
    // rust: multi_draw,
    // rust: flat.as_ref().map(|f| f.min_sections),
    // rust: ),
    // rust: flat.is_some(),
    // rust: );
        // Not again after the device was lost in one of its frames, until Horizon restarts.
    // rust: let gpu_culling_offer = if crate::graphics::gpu_culling_lost() {
    // rust: crate::graphics::GpuCullingOffer::DeviceLost
    // rust: } else {
    // rust: gpu_culling_offer
}
    // rust: crate::graphics::offer_gpu_culling(gpu_culling_offer);
        // A new renderer runs no shader pack: the game loads the picked one on its
        // first world frame (`shader_pack`: the picked pack draws flat, a `shaders/`
        // pack or one of Horizon's own with `[shadow]`), and the frames before it, the
        // level loading screen's among them, keep the layout the sections upload in
        // (`draw_frame`). It starts as that pack's, a `shaders/` pack taken to draw
        // terrain: the pack loading keeps it, and only one whose terrain and shadow
        // pass draw none meshes the sections again.
    // rust: let (sorted_indices, translucent_arena) = arena::Arena::translucent_arenas(
    // rust: &device,
    // rust: std::mem::size_of::<TerrainVertex>() as u64,
    // rust: flat.is_some(),
    // rust: translucent_split(translucent_batching, flat.is_some(), shader_pack, false),
    // rust: );
    // rust: if let (Some(flat), Some(arena)) = (&mut flat, &translucent_arena) {
    // rust: flat.set_translucent_page_vertices(arena.page_vertices());
}
        // Without indirect draws (OpenGL before 4.0 without indirect execution, or
        // before 4.2 + GL_ARB_shader_draw_parameters without indirect first instance)
        // even creating an indirect buffer fails; one draw per section reads
        // `draws` on the CPU instead.
    // rust: let indirect = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Section draws"),
    // rust: size: 1024 * 20,
    // rust: usage: if multi_draw {
    // rust: wgpu::BufferUsages::INDIRECT | wgpu::BufferUsages::COPY_DST
    // rust: } else {
    // rust: wgpu::BufferUsages::COPY_DST
    // rust: },
    // rust: mapped_at_creation: false,
    // rust: });
        // HORIZON_GPU_CULL=0 turns occlusion culling off, `all` culls every
        // frame however few its draws and little it hides, `shader` tests in
        // the shader as on Metal (A/B checks).
    // rust: let cull_env = std::env::var("HORIZON_GPU_CULL");
    // rust: let adapter_info = adapter.get_info();
    // rust: let cull = cull::Cull::supported(&adapter, &device)
    // rust: .filter(|_| occlusion_culling_requested(&adapter_info, cull_env.as_deref().ok()))
    // rust: .map(|depth_test| match cull_env.as_deref() {
    // rust: Ok("shader") => cull::DepthTest::InShader,
    // rust: _ => depth_test,
    // rust: })
    // rust: .map(|depth_test| {
    // rust: let mut cull = cull::Cull::new(&device, frame_format, depth_test);
    // rust: cull.always = cull_env.as_deref() == Ok("all");
    // rust: if !cull.always && adapter_info.backend == wgpu::Backend::Metal {
    // rust: cull.min_sections = cull::TILED_MIN_SECTIONS;
}
    // rust: cull
    // rust: });
    // rust: let depth = Self::depth(&device, &config);
    // rust: let world_post = world_post::Post::new(&device, frame_format);
    // rust: let uploads = upload::Uploads::new(&device);
    // rust: let section_uploads = upload::Uploads::with_chunk(&device, SECTION_UPLOAD_CHUNK);
    // rust: let stars = stars::Stars::new(&device, frame_format);
    // rust: let entity_outline = entity_outline::EntityOutline::new(
    // rust: &device,
    // rust: (&entity_shader, &entity_layout, &entity_vertex),
    // rust: frame_format,
    // rust: );
    // rust: let panorama = panorama::Panorama::new(&device, frame_format, panorama_faces);
    // rust: drop(pipelines_step);
    // rust: reuse.finish(generation);
    // rust: if previous.is_some() {
    // rust: log::info!(
    // rust: "Horizon renderer: rebuilt on the same device ({} shader modules, layouts and pipelines kept)",
    // rust: reuse.len()
    // rust: );
}
    // rust: if previous.is_none() {
    // rust: startup_step(format_args!(
    // rust: "pipelines ready (multi-draw {}, occlusion culling {}, GPU culling {}, GPU timer {})",
    // rust: on_off(multi_draw),
    // rust: on_off(cull.is_some()),
    // rust: if gpu_culling_offer == crate::graphics::GpuCullingOffer::Offered {
    // rust: "available"
    // rust: } else {
    // rust: "unavailable"
    // rust: },
    // rust: on_off(gpu_timer.is_some()),
    // rust: ));
}
    // rust: let world_primitives = world_primitives::WorldPrimitives::new(&device, frame_format);
    // rust: Ok(Self {
    // rust: display: DisplayWatch::default(),
    // rust: display_fresh: false,
    // rust: instance,
    // rust: adapter,
    // rust: surface: surface.map(Arc::new),
    // rust: spare_surface: std::sync::Mutex::new(None),
    // rust: offscreen,
    // rust: in_flight: std::collections::VecDeque::new(),
    // rust: paced_elsewhere: false,
    // rust: first_frame: if previous.is_none() {
    // rust: FirstFrame::Acquire
    // rust: } else {
    // rust: FirstFrame::Drawn
    // rust: },
    // rust: gpu_timer,
    // rust: gpu_times: Vec::new(),
    // rust: lightmap_pixels: [0; 16 * 16 * 4],
    // rust: last_wait: std::time::Duration::ZERO,
    // rust: last_encode: std::time::Duration::ZERO,
    // rust: window,
    // rust: device,
    // rust: reuse,
    // rust: queue: submit::Queue::new(queue, submit::wanted()),
    // rust: deferred: None,
    // rust: device_lost,
    // rust: config,
    // rust: solid,
    // rust: solid_opaque,
    // rust: solid_cutout,
    // rust: translucent,
    // rust: translucent_mark,
    // rust: flat_on: flat.is_some(),
    // rust: packed_quads,
    // rust: cull_on: cull.is_some(),
    // rust: sides_on: true,
    // rust: gpu_culling: None,
    // rust: gpu_culling_offer,
    // rust: gpu_frame: false,
    // rust: gpu_checks: 0,
    // rust: cull,
    // rust: flat,
    // rust: visbuf,
    // rust: sky,
    // rust: sky_base,
    // rust: sunrise_pipeline,
    // rust: sunrise_buffer,
    // rust: dark_disc,
    // rust: depth_reset,
    // rust: lines,
    // rust: lines_secondary,
    // rust: core_lines: None,
    // rust: debug_lines_opaque,
    // rust: debug_lines,
    // rust: debug_lines_on_top,
    // rust: debug_line_buffer,
    // rust: debug_line_capacity: 4096,
    // rust: crosshair_group,
    // rust: crosshair_globals,
    // rust: solid_mirror,
    // rust: mirror_globals,
    // rust: mirror_group,
    // rust: mirror: None,
    // rust: entity_pipeline,
    // rust: static_entity_pipeline,
    // rust: hdr_mark_pipeline,
    // rust: hdr_hand_unmark_pipeline,
    // rust: hdr_mark_lightning_pipeline,
    // rust: weather,
    // rust: crumbling_pipeline,
    // rust: shadow_blob_pipeline,
    // rust: translucent_item_pipeline,
    // rust: water_mask_pipeline,
    // rust: cloud_pipeline,
    // rust: hdr_cloud_mark_pipeline,
    // rust: cloud_mesh: Default::default(),
    // rust: cloud_buffer,
    // rust: cloud_capacity: 4,
    // rust: cloud_uniform,
    // rust: cloud_group,
    // rust: additive_pipeline,
    // rust: dragon_rays_pipeline,
    // rust: energy_swirl_pipeline,
    // rust: lightning_pipeline,
    // rust: lightning: lightning::Renderer::new(),
    // rust: see_through_pipeline,
    // rust: world_primitives,
    // rust: text_polygon_offset_pipeline,
    // rust: world_text_pipeline,
    // rust: celestial_pipeline,
    // rust: celestial_buffer,
    // rust: end_sky: end_sky::EndSky::default(),
    // rust: stars,
    // rust: entity_outline,
    // rust: panorama,
    // rust: border_pipeline,
    // rust: border_group,
    // rust: border_uniform,
    // rust: border_vertices,
    // rust: screen_pipelines,
    // rust: screen_buffer,
    // rust: screen_capacity,
    // rust: entity_group,
    // rust: entity_bindings,
    // rust: static_entity_group,
    // rust: static_entity_transform,
    // rust: static_entity_camera: None,
    // rust: static_entity_catalog_revision: 0,
    // rust: static_entity_frame_stats: Default::default(),
    // rust: hand_group,
    // rust: hand_globals,
    // rust: entity_buffer,
    // rust: entity_capacity,
    // rust: static_entity_sections: HashMap::default(),
    // rust: static_entity_indices,
    // rust: static_entity_index_quads,
    // rust: entity_batch: EntityBatch::default(),
    // rust: entity_skin,
    // rust: group,
    // rust: globals,
    // rust: pbr_maps,
    // rust: lightmap,
    // rust: sprite_textures,
    // rust: sprite_unused,
    // rust: sprite_views,
    // rust: mip_levels,
    // rust: mipmaps: mip_levels - 1,
    // rust: terrain_layout: bindings,
    // rust: terrain_sprites: sprite_constants.map(|(_, v)| v),
    // rust: sprite_split: split,
    // rust: sprite_sampler,
    // rust: sprite_nearest,
    // rust: texture_filtering: 0,
    // rust: max_anisotropy: 1,
    // rust: lightmap_view,
    // rust: lightmap_sampler,
    // rust: animations,
    // rust: material_animations,
    // rust: active_animated_layers: vec![0; active_layer_words],
    // rust: uploads,
    // rust: section_uploads,
    // rust: section_copies: None,
    // rust: section_copy_bytes: 0,
    // rust: shrink_gate: ShrinkGate::default(),
    // rust: lightmap_uploaded: false,
    // rust: sprite_minimum_size,
    // rust: sprite_native: sprite_mips.iter().map(|s| s.native_size).collect(),
    // rust: mipmap_option: 4,
    // rust: indices,
    // rust: index_quads,
    // rust: instances,
    // rust: instance_capacity,
    // rust: outline,
    // rust: depth,
    // rust: sections: resident::Resident::default(),
    // rust: lods: HashMap::new(),
    // rust: lod_cull_free: Vec::new(),
    // rust: lod_cull_next: 0,
    // rust: lod_cutout: Default::default(),
    // rust: lod_retiring: Default::default(),
    // rust: lod_leaving: Vec::new(),
    // rust: lod_pending: None,
    // rust: detail_columns: Default::default(),
    // rust: detail_revision: 0,
    // rust: arena,
    // rust: translucent_arena,
    // rust: translucent_batching,
    // rust: sections_dropped: false,
    // rust: sorted_indices,
    // rust: graveyard: Default::default(),
    // rust: translucent_sorter: translucency::Sorter::default(),
    // rust: translucency_cursor: 0,
    // rust: indirect,
    // rust: indirect_capacity: 1024,
    // rust: multi_draw,
    // rust: visible: Vec::new(),
    // rust: visible_lods: Vec::new(),
    // rust: shadow_visible: Vec::new(),
    // rust: translucent_draws: Vec::new(),
    // rust: origins: Vec::new(),
    // rust: draws: Vec::new(),
    // rust: draw_pages: Vec::new(),
    // rust: phase2_draws: Vec::new(),
    // rust: phase2_pages: Vec::new(),
    // rust: solid_runs: page_runs::PageRuns::default(),
    // rust: phase2_runs: page_runs::PageRuns::default(),
    // rust: shadow_runs: page_runs::PageRuns::default(),
    // rust: block_entities: Default::default(),
    // rust: block_entity_section_revisions: Default::default(),
    // rust: block_entity_membership_revisions: Default::default(),
    // rust: section_uploaded: Default::default(),
    // rust: newest_upload: None,
    // rust: newest_lod_fade: None,
    // rust: block_entity_revision: next_block_entity_revision(),
    // rust: light_blocks: Default::default(),
    // rust: light_revision: 0,
    // rust: occlusion: occlusion::Occlusion::new(crate::chunk::MIN_Y, crate::chunk::HEIGHT / 16),
    // rust: layout: crate::chunk::ColumnLayout::VANILLA,
    // rust: world_post,
    // rust: frame_gen: frame_gen::FrameGen::new(),
    // rust: entity_atlas: atlas_view.clone(),
    // rust: hdr: None,
    // rust: hdr_lighting_setting: true,
    // rust: emission_stats,
    // rust: hdr_output,
    // rust: frame_format,
    // rust: hdr_marker: None,
    // rust: pack_post: None,
    // rust: native: None,
    // rust: pass_timing: pack_timing::PassTiming::logging(),
    // rust: own_timing: None,
    // rust: pack_entity_rest: Vec::new(),
    // rust: cloud_bindings,
    // rust: pack_weather: None,
    // rust: pack_atlas: None,
    // rust: pack_material_atlases: None,
    // rust: pack_terrain_flat: false,
    // rust: separate_ao: false,
    // rust: pack_lava_layers: Vec::new(),
    // rust: hud,
    // rust: menu_blur: None,
    // rust: post_effects: None,
    // rust: readback: readback::Readback::default(),
    // rust: info,
    // rust: suspended: !drawable_size(size.width, size.height, max_side),
    // rust: acquire_validation_failures: 0,
    // rust: surface_unconfigured: false,
    // rust: drawn_sections: 0,
    // rust: section_draws: 0,
    // rust: section_draw_calls: 0,
    // rust: frame_serial: 0,
    // rust: stats_frame: 0,
    // rust: uploaded_bytes: 0,
    // rust: started: Instant::now(),
    // rust: screenshot: None,
    // rust: screenshot_result: None,
    // rust: screenshot_quality: 1,
    // rust: screenshot_halvings: 0,
    // rust: gamma: 0.5,
    // rust: improved_transparency: false,
    // rust: oit: None,
    // rust: fullbright: false,
    // rust: animated_textures: true,
    // rust: present_modes,
    // rust: capture_copies: std::env::var_os("HORIZON_RENDER_CAPTURE")
    // rust: .is_some()
    // rust: .then(capture::Copies::default),
    // rust: capture: None,
    // rust: capture_result: None,
    // rust: })
}
    /// The first-person hand's quads, which follow `first` quads of the entity buffer.
pub fn draw_hand(self: *Self, pass: *mut wgpu::RenderPass<'_>, quads: u32, first: u32) void {
}
    // rust: pass.set_pipeline(&self.entity_pipeline);
    // rust: pass.set_bind_group(0, &self.hand_group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(0..quads * 6, (first * 4) as i32, 0..1);
    // rust: if self.hdr.is_some() {
            // Drawn into the world: the light sources it holds are marked as the world's are.
    // rust: pass.set_pipeline(&self.hdr_mark_pipeline);
    // rust: pass.draw_indexed(0..quads * 6, (first * 4) as i32, 0..1);
}
}
    /// HDR lighting on the clouds just drawn: the sky's value (`fs_hdr_cloud_mark`).
pub fn mark_clouds(self: *Self, pass: *mut wgpu::RenderPass<'_>, quads: u32) void {
}
    // rust: if self.hdr.as_ref().is_none_or(|h| !h.lighting) {
    // rust: return;
}
    // rust: pass.set_pipeline(&self.hdr_cloud_mark_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_bind_group(1, &self.cloud_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.cloud_buffer.slice(..));
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.draw_indexed(0..quads * 6, 0, 0..1);
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    /// HDR lighting on translucent terrain, over the draws that just blended it.
    // rust: fn mark_translucent_terrain(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: flat: Option<&flat::Flat>,
    // rust: solid_draws: u32,
    // rust: translucent_draws: u32,
    // rust: ) {
    // rust: if self.hdr.as_ref().is_none_or(|h| !h.lighting) {
    // rust: return;
}
    // rust: match flat {
    // rust: Some(flat) => {
    // rust: pass.set_pipeline(&flat.translucent_mark);
    // rust: flat.draw(
    // rust: pass,
    // rust: flat.translucent_calls(),
    // rust: flat_vertices(&self.arena, self.translucent_arena.as_ref()),
    // rust: );
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: None => {
    // rust: pass.set_pipeline(&self.translucent_mark);
    // rust: pass.set_vertex_buffer(1, self.instances.slice(..));
    // rust: self.draw_sections(pass, &self.indirect, 0, solid_draws, translucent_draws);
}
}
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
}
    /// The resource packs' `core/rendertype_lines` (`HudAtlas::lines_shader`) for the block
    /// outline, or the built-in one.
pub fn set_lines_shader(self: *Self, program: ?*horizon_shaders::CoreProgram) void {
}
    // rust: let format = self.frame_format;
    // rust: self.core_lines =
    // rust: program.and_then(|program| core_lines::CoreLines::new(&self.device, format, program));
}
    /// LevelRenderer.submitBlockOutline: the buffer holds `edges` per stroke, the black
    /// secondary stroke first when high contrast is on.
pub fn draw_outline(self: *Self, pass: *mut wgpu::RenderPass<'_>, edges: u32, high_contrast: bool) void {
}
    // rust: pass.set_vertex_buffer(0, self.outline.slice(..));
        // Both strokes are LINES: a pack's rendertype_lines draws them.
    // rust: if let Some(lines) = &self.core_lines {
    // rust: if high_contrast {
    // rust: lines.draw(pass, true, 0..edges);
}
    // rust: let first = if high_contrast { edges } else { 0 };
    // rust: lines.draw(pass, false, first..first + edges);
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: return;
}
    // rust: if high_contrast {
    // rust: pass.set_pipeline(&self.lines_secondary);
    // rust: pass.draw(0..4, 0..edges);
}
    // rust: pass.set_pipeline(&self.lines);
    // rust: let first = if high_contrast { edges } else { 0 };
    // rust: pass.draw(0..4, first..first + edges);
}
pub fn quad_indices(device: *wgpu::Device, quads: u32) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let indices: Vec<u32> = (0..quads)
    // rust: .flat_map(|q| {
    // rust: let b = q * 4;
    // rust: [b, b + 1, b + 2, b, b + 2, b + 3]
    // rust: })
    // rust: .collect();
    // rust: device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Quad indices"),
    // rust: contents: bytemuck::cast_slice(&indices),
    // rust: usage: wgpu::BufferUsages::INDEX,
    // rust: })
}
    // rust: fn offscreen_target(
    // rust: device: &wgpu::Device,
    // rust: config: &wgpu::SurfaceConfiguration,
    // rust: ) -> wgpu::Texture {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Offscreen frame"),
    // rust: size: wgpu::Extent3d {
    // rust: width: config.width,
    // rust: height: config.height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: config.format,
    // rust: usage: config.usage,
    // rust: view_formats: &config.view_formats,
    // rust: })
}
    /// Hand the window surface over to the renderer that replaces this one on
    /// the same device (it takes `spare_surface`).
pub fn release_surface(self: *Self) void {
}
    // rust: self.frame_gen.stop();
    // rust: self.queue.wait();
    // rust: *self
    // rust: .spare_surface
    // rust: .get_mut()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner) =
    // rust: self.surface.take().and_then(|s| Arc::try_unwrap(s).ok());
}
    /// Reattach a window after surface loss or a failed renderer replacement.
pub fn recreate_surface(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.queue.wait();
    // rust: if self.offscreen.is_some() {
    // rust: return Ok(());
}
        // The surface set aside for a replacement that failed, else a new one
        // (Wayland allows only one tearing-control object per window surface,
        // so the old one goes first).
    // rust: let spare = self
    // rust: .spare_surface
    // rust: .get_mut()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner)
    // rust: .take();
    // rust: self.frame_gen.stop();
    // rust: self.surface = None;
    // rust: let surface = match spare {
    // rust: Some(surface) => surface,
    // rust: None => self.instance.create_surface(self.window.clone())?,
}
    // rust: let configured = Self::configure(
    // rust: &self.device,
    // rust: &surface,
    // rust: &self.surface_config(),
    // rust: self.hdr.as_ref(),
    // rust: &self.device_lost,
    // rust: );
    // rust: if let Err(e) = &configured {
    // rust: log::warn!(
    // rust: "Horizon renderer: the new window surface did not configure ({e}); retrying"
    // rust: );
}
    // rust: self.surface_unconfigured = configured.is_err();
    // rust: self.surface = Some(Arc::new(surface));
    // rust: Ok(())
}
    /// The world's depth, which occlusion culling's test and post effects may read.
pub fn depth(device: *wgpu::Device, config: *wgpu::SurfaceConfiguration) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Horizon depth"),
    // rust: size: wgpu::Extent3d {
    // rust: width: config.width,
    // rust: height: config.height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Depth32Float,
                // TEXTURE_BINDING: a post effect may read the depth buffer.
                // COPY_SRC: improved transparency and a native shader pack's
                // `opaque_depth` copy it.
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default())
}
    /// VSync on presents with Fifo, capped to the display's refresh rate in a
    /// window and in fullscreen alike; Horizon's present-mode setting applies
    /// only with VSync off (`window::chosen_present_mode`).
pub fn set_present_mode(self: *Self, vsync: bool, mode: crate::graphics::PresentMode) void {
}
//         use crate::graphics::PresentMode as P;
//         use crate::window::{PresentMode, chosen_present_mode};
    // rust: let supported: Vec<PresentMode> = self
    // rust: .present_modes
    // rust: .iter()
    // rust: .filter_map(|m| match m {
    // rust: wgpu::PresentMode::Fifo => Some(PresentMode::Fifo),
    // rust: wgpu::PresentMode::Mailbox => Some(PresentMode::Mailbox),
    // rust: wgpu::PresentMode::Immediate => Some(PresentMode::Immediate),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: let setting = match mode {
    // rust: P::Auto => None,
    // rust: P::Fifo => Some(PresentMode::Fifo),
    // rust: P::Mailbox => Some(PresentMode::Mailbox),
    // rust: P::Immediate => Some(PresentMode::Immediate),
}
    // rust: let mode = match chosen_present_mode(&supported, vsync, setting) {
    // rust: Some(PresentMode::Mailbox) => wgpu::PresentMode::Mailbox,
    // rust: Some(PresentMode::Immediate) => wgpu::PresentMode::Immediate,
    // rust: _ => wgpu::PresentMode::Fifo,
}
    // rust: if self.config.present_mode != mode && self.surface.is_some() {
    // rust: self.config.present_mode = mode;
    // rust: self.configure_surface();
}
}
    /// Follows the window to `width` x `height`. A size the swapchain can't take
    /// ([`drawable_size`]) keeps the last one and draws nothing until the next.
pub fn resize(self: *Self, width: u32, height: u32) void {
}
    // rust: let max = self.device.limits().max_texture_dimension_2d;
    // rust: self.suspended = !drawable_size(width, height, max);
    // rust: if self.suspended {
    // rust: return;
}
    // rust: self.config.width = width;
    // rust: self.config.height = height;
    // rust: if self.surface.is_some() {
    // rust: self.configure_surface();
    // rust: } else {
    // rust: self.offscreen = Some(Self::offscreen_target(&self.device, &self.config));
}
    // rust: self.depth = Self::depth(&self.device, &self.config);
}
    /// Whether sections are drawn as one index list per frame (`flat`).
pub fn flat_draws(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.flat_on
}
    /// Switches between flat and per-section draws, for A/B checks.
pub fn set_flat_draws(self: *Self, on: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if on && self.flat.is_none() {
    // rust: return Err("flat section draws are off on this device".into());
}
    // rust: self.flat_on = on;
    // rust: Ok(())
}
    /// Whether one of Horizon's own packs reads the water mirror, which needs the frame's
    /// `water_plane`.
pub fn wants_water_plane(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.native.as_ref().is_some_and(|n| n.frame.reflects)
}
    /// Whether solid quads facing away from the eye are left out.
pub fn section_sides(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sides_on
}
    /// Switches leaving out solid quads facing away, for A/B checks.
pub fn set_section_sides(self: *Self, on: bool) void {
}
    // rust: self.sides_on = on;
}
    /// Whether solid sections are occlusion culled (`cull`).
pub fn section_cull(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.cull_on
}
    /// Switches occlusion culling, for A/B checks.
pub fn set_section_cull(self: *Self, on: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if on && self.cull.is_none() {
    // rust: return Err("occlusion culling is off on this device".into());
}
    // rust: self.cull_on = on;
    // rust: Ok(())
}
    /// Of the boxes occlusion culling's last test read back drew, how many
    /// it did not see and how many it drew, and the share of solid indices
    /// it hid.
pub fn culled_sections(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.gpu_frame {
            // GPU culling's own test, on Vulkan.
    // rust: let gpu = self.gpu_culling.as_ref().filter(|_| self.cull_on);
    // rust: return gpu.and_then(|g| g.hidden());
}
    // rust: self.cull
    // rust: .as_ref()
    // rust: .filter(|_| self.cull_on)
    // rust: .map(|c| c.hidden)
}
    /// Whether the near solid sections are culled and drawn on the GPU where
    /// frames allow it (`gpu_culling`).
pub fn gpu_culling(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.gpu_culling.is_some()
}
    /// Whether the last frame GPU culling drew ran its occlusion test.
pub fn gpu_occluding(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.gpu_frame && self.gpu_culling.as_ref().is_some_and(|g| g.occluding())
}
    /// Whether the last frame drew them so.
pub fn gpu_frame(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.gpu_frame
}
    /// Of the sections GPU culling keeps records of, those it leaves to the CPU
    /// while they fade (`SectionGpu::gpu_fading`); `None` while it is off.
pub fn gpu_fading(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.gpu_culling.as_ref().map(|g| g.records.fading())
}
    /// Switches GPU culling: the GPU Culling setting sets it (`apply_ui_settings`, after
    /// every settings change and every new renderer), and so does the control word. It
    /// turns on only where it is offered (`gpu_culling_offer`); unchanged, it does nothing.
    /// Its pass, its records of the resident sections and their flags while they
    /// fade are made when it is switched on (the next world frame decides the
    /// flags, `mark_fades`) and dropped when it is switched off, with the walk
    /// marks the flags gave: nothing is kept for it while it is off but the
    /// sections' other walk marks (`SectionGpu::listed`) and the cave-culling
    /// graph's bits (`occlusion::Reach`), which are the same either way.
pub fn set_gpu_culling(self: *Self, on: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !on {
    // rust: if self.gpu_culling.take().is_some() {
    // rust: forget_records(&mut self.sections, self.layout.sections());
}
    // rust: self.gpu_frame = false;
    // rust: return Ok(());
}
    // rust: if self.gpu_culling.is_some() {
    // rust: return Ok(());
}
    // rust: if let Some(why) = self.gpu_culling_offer.reason() {
    // rust: return Err(why.into());
}
    // rust: let test = self
    // rust: .cull
    // rust: .as_ref()
    // rust: .filter(|c| c.early())
    // rust: .map(|_| self.frame_format);
    // rust: let Some(mut gpu) = gpu_culling::GpuCulling::new(&self.device, test) else {
            // Not offered from now on: its switch greys out.
    // rust: self.offer_gpu_culling(crate::graphics::GpuCullingOffer::Unsupported);
    // rust: return Err("GPU culling could not be set up on this device".into());
}
    // rust: let sections = self.layout.sections();
    // rust: for (key, s, bounds) in self.sections.iter_mut() {
    // rust: if s.gpu_recorded(key, sections) {
    // rust: s.gpu_id = Some(gpu.records.insert(s.record(key, bounds)));
}
}
    // rust: self.gpu_culling = Some(gpu);
    // rust: {
    // rust: self.gpu_checks = 0;
}
    // rust: Ok(())
}
    /// GPU culling offered or not from now on, here and in the settings' switch.
pub fn offer_gpu_culling(self: *Self, offer: crate::graphics::GpuCullingOffer) void {
}
    // rust: self.gpu_culling_offer = offer;
    // rust: crate::graphics::offer_gpu_culling(offer);
}
    /// Whether GPU culling is offered here, and why not (the status's `gpu_culling_offer`).
pub fn gpu_culling_offer(self: *Self) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.gpu_culling_offer
}
    /// Debug builds: GPU culling's records are the sections' as they are now,
    /// compaction's moves included: each section it keeps a record of
    /// (`SectionGpu::gpu_recorded`) has its own, no record is left without its
    /// section, and each page they count is the arena's. A record left behind
    /// would draw another section's quads, or from a freed page. And each
    /// section's walk mark is `SectionGpu::listed`: one unmarked that should be
    /// would leave its translucent quads, or all of it, undrawn. And the bits
    /// the pass copies of the cave-culling graph are its cells'
    /// (`occlusion::Reach`): one off would hide a section the walk shows. And,
    /// at `f.now`, a recorded section draws faded only while it is flagged
    /// (`SectionGpu::gpu_fading`, its record's `FADING`), and an end is waited
    /// for while it is unless it leaves or is held: one the pass drew whole
    /// would pop in, one flagged for good would cost the CPU its draws.
pub fn check_gpu_records(self: *Self, f: FadeInputs<'_>) void {
}
    // rust: let Some(gpu) = &self.gpu_culling else {
    // rust: return;
}
    // rust: assert!(
    // rust: self.occlusion.reach_is_exact(),
    // rust: "the reach bits are the graph's cells"
    // rust: );
    // rust: let (records, sections) = (&gpu.records, self.layout.sections());
    // rust: let pending: crate::fast_hash::FxHashSet<SectionKey> = gpu.fades.pending().collect();
    // rust: let mut pages = vec![0; records.page_sections().len()];
    // rust: let (mut live, mut flagged) = (0, 0);
    // rust: for (key, s, bounds) in self.sections.iter() {
    // rust: let recorded = s.gpu_recorded(key, sections);
    // rust: assert_eq!(s.gpu_id.is_some(), recorded, "{key:?}: a record");
    // rust: let marked = self.sections.is_marked(key);
    // rust: assert_eq!(marked, s.listed(key, sections), "{key:?}: its walk mark");
    // rust: assert!(
    // rust: !s.gpu_fading || s.gpu_id.is_some(),
    // rust: "{key:?}: flagged without a record"
    // rust: );
    // rust: assert!(
    // rust: s.gpu_id.is_none() || s.gpu_fading || !s.drawn_faded(key, f),
    // rust: "{key:?}: GPU culling draws it whole while it fades"
    // rust: );
    // rust: assert!(
    // rust: !s.gpu_fading || s.fade_end(key, f).is_none() || pending.contains(&key),
    // rust: "{key:?}: flagged, with no end waited for"
    // rust: );
    // rust: if let Some(id) = s.gpu_id {
    // rust: let record = s.record(key, bounds);
    // rust: assert_eq!(records.at(id), Some(&record), "{key:?}: its record {id}");
    // rust: pages[s.page as usize] += 1;
    // rust: live += 1;
    // rust: flagged += u32::from(s.gpu_fading);
}
}
    // rust: assert_eq!(records.live(), live, "records of sections gone");
    // rust: assert_eq!(records.fading(), flagged, "flagged records");
    // rust: assert_eq!(records.page_sections(), pages, "records per page");
    // rust: for (page, &n) in pages.iter().enumerate() {
    // rust: assert!(
    // rust: n == 0 || self.arena.has_page(page as u32),
    // rust: "records on freed page {page}"
    // rust: );
}
}
pub fn section_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sections.len()
}
    /// Whether the running native pack gives any block a `[[lights]]` colour.
pub fn has_light_colors(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.native
    // rust: .as_ref()
    // rust: .is_some_and(|native| !native.light_colors.is_empty())
}
    /// The running native pack's `[[lights]]` colour of the block `name`.
pub fn light_color(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let native = self.native.as_ref()?;
    // rust: horizon_shader_api::manifest::light_color(&native.light_colors, name)
}
    /// The running native pack's `[[particle_lights]]`.
pub fn particle_lights(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.native.as_ref().map(|n| n.particle_lights.as_slice())
}
    /// Whether one of Horizon's own packs with `[shadow]` draws, whose shadow pass takes the
    /// frame's `shadow_only` quads.
pub fn native_shadow(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.native.as_ref().is_some_and(|n| n.shadow.is_some())
}
    /// What a shader pack's shadow pass draws of the entities this frame: (entities or block
    /// entities other than the player, so those Horizon's culling hides from the camera are
    /// kept for it; the local player, so its model is built in first person too). (false,
    /// false) without a pack or its shadow pass.
pub fn pack_shadow_casters(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((_, Some(post))) = &self.pack_post else {
    // rust: return (false, false);
}
    // rust: let c = post.shadow_casters();
    // rust: ((c.entities && !c.only_player) || c.blocks, c.entities)
}

    /// A standard pack replaces mobs' vanilla blob shadows only when its compiled
    /// shadow path actually draws entities other than the player.
pub fn pack_entity_shadows(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pack_post
    // rust: .as_ref()
    // rust: .and_then(|(_, post)| post.as_ref())
    // rust: .is_some_and(|post| {
    // rust: let casters = post.shadow_casters();
    // rust: casters.entities && !casters.only_player
    // rust: })
}

pub fn has_section(self: *Self, key: SectionKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sections.contains(key)
}
    /// Bring the cave culling graph up to date for `camera` without waiting:
    /// a search this starts runs on its worker while the frame is prepared,
    /// and `render` takes it if it has finished.
pub fn start_occlusion(self: *Self, camera: DVec3, distance: f32) void {
}
    // rust: self.occlusion.update(camera, (distance / 16.0) as i32 + 2);
}
    /// Whether the camera's current section graph knows this section is
    /// reachable. `None` means the graph cannot safely answer for this camera
    /// or section, so callers should keep the geometry.
    // rust: pub fn section_occlusion_visible(
    // rust: &self,
    // rust: key: SectionKey,
    // rust: camera_section: SectionKey,
    // rust: ) -> Option<bool> {
    // rust: self.occlusion.visible_for_camera(key, camera_section)
}
pub fn upload(self: *Self, key: SectionKey, mesh: *SectionMesh) void {
}
    // rust: if let Some(copies) = &mut self.capture_copies {
    // rust: copies.section(key, mesh);
}
    // rust: self.occlusion.set(key, mesh.visibility);
    // rust: let changed = if mesh.block_entities.is_empty() {
    // rust: self.block_entities.remove(&key).is_some()
    // rust: } else {
    // rust: let old = self.block_entities.insert(key, mesh.block_entities.clone());
    // rust: old.as_deref() != Some(&mesh.block_entities[..])
}
    // rust: if changed {
    // rust: self.block_entity_revision = next_block_entity_revision();
    // rust: self.block_entity_membership_revisions
    // rust: .insert(key, self.block_entity_revision);
}
    // rust: if !mesh.block_entities.is_empty()
    // rust: || self.block_entity_membership_revisions.contains_key(&key)
    // rust: {
            // Packed light can change with an unchanged BE list. Keep a
            // tombstone for formerly occupied sections until unload so a
            // deleted last entity invalidates only its own cached section.
    // rust: self.block_entity_section_revisions
    // rust: .insert(key, next_block_entity_revision());
}
    // rust: let lights_changed = if mesh.lights.is_empty() {
    // rust: self.light_blocks.remove(&key).is_some()
    // rust: } else {
    // rust: let old = self.light_blocks.insert(key, mesh.lights.clone());
    // rust: old.as_deref() != Some(&mesh.lights[..])
}
    // rust: if lights_changed {
    // rust: self.light_revision += 1;
}
    // rust: if !self.lod_retiring.is_empty() {
    // rust: self.lod_retiring.remove(&key);
}
    // rust: if !mesh.translucent.is_empty() && !self.sections.contains(key) {
            // New translucent terrain, not an edit's remesh: large pages wait for it.
    // rust: self.shrink_gate.wait(Instant::now(), SHRINK_SETTLE);
}
    // rust: let fading = match self.sections.find(key) {
    // rust: Some(old) => old.fading,
    // rust: None if !self.lods.is_empty() => {
    // rust: let now = std::time::Instant::now();
    // rust: self.newest_lod_fade = Some(now);
    // rust: Some(now)
}
    // rust: None => None,
}
    // rust: if fading.is_none() && !self.section_uploaded.contains_key(&key) {
    // rust: let now = std::time::Instant::now();
    // rust: self.section_uploaded.insert(key, now);
    // rust: self.newest_upload = Some(now);
}
    // rust: self.release_section(key);
    // rust: let section = self
    // rust: .upload_mesh(mesh)
    // rust: .map(|section| SectionGpu { fading, ..section });
    // rust: self.set_detail(
    // rust: key,
    // rust: section.is_some() || (mesh.solid.is_empty() && mesh.translucent.is_empty()),
    // rust: );
    // rust: if let Some(mut section) = section {
    // rust: let sections = self.layout.sections();
    // rust: if let Some(gpu) = &mut self.gpu_culling
    // rust: && section.gpu_recorded(key, sections)
    // rust: {
                // A fade starts with its section: flagged from the first frame that
                // draws it, once a frame has decided the flags (`mark_fades`).
    // rust: if let Some(fade_ms) = gpu.fades.fade_ms {
    // rust: let f = FadeInputs {
    // rust: now: Instant::now(),
    // rust: fade_ms,
    // rust: uploaded: &self.section_uploaded,
    // rust: retiring: &self.lod_retiring,
}
    // rust: section.gpu_fading = decide_fade(&section, key, &mut gpu.fades, f);
}
    // rust: section.gpu_id = Some(gpu.records.insert(section.record(key, mesh.bounds)));
}
    // rust: let marked = section.listed(key, sections);
    // rust: self.sections
    // rust: .insert_marked(key, section, mesh.bounds, marked);
}
}
pub fn upload_mesh(self: *Self, mesh: *SectionMesh) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let solid = (mesh.solid.len() / 4) as u32;
    // rust: let translucent = (mesh.translucent.len() / 4) as u32;
    // rust: if solid + translucent == 0 {
    // rust: return None;
}
    // rust: let max = solid.max(translucent);
    // rust: if max > self.index_quads {
    // rust: self.index_quads = max.next_power_of_two();
    // rust: self.indices = Self::quad_indices(&self.device, self.index_quads);
}
    // rust: let encoder = self.section_copies.get_or_insert_with(|| {
    // rust: self.device
    // rust: .create_command_encoder(&wgpu::CommandEncoderDescriptor {
    // rust: label: Some("Section uploads"),
    // rust: })
    // rust: });
        // The solid quads, and the translucent ones after them unless they have
        // an arena of their own. With video and system memory both full, the
        // section is not drawn. The solid ones in the compact layout where the
        // mesher made it and the passes read it (`packed_quads`).
    // rust: let packed = self.packed_quads && !mesh.packed.is_empty() && solid > 0;
    // rust: let solid_slots = if packed {
    // rust: mesh.packed.len() as u64
    // rust: } else {
    // rust: mesh.solid.len() as u64
}
    // rust: let split = self.translucent_arena.is_some();
    // rust: let main = if split {
    // rust: solid_slots
    // rust: } else {
    // rust: solid_slots + mesh.translucent.len() as u64
}
    // rust: let (page, start) = if main > 0 {
    // rust: self.arena.alloc(&self.device, encoder, main)?
    // rust: } else {
    // rust: (0, 0)
}
    // rust: let release_main = |arena: &mut arena::Arena| {
    // rust: if main > 0 {
    // rust: arena.release(page, start, main);
}
}
    // rust: let translucent_vertices = mesh.translucent.len() as u64;
    // rust: let translucent_at = match &mut self.translucent_arena {
    // rust: Some(arena) if translucent > 0 => {
    // rust: match arena.alloc(&self.device, encoder, translucent_vertices) {
    // rust: Some(at) => at,
    // rust: None => {
    // rust: release_main(&mut self.arena);
    // rust: return None;
}
}
}
    // rust: _ => (page, start + solid_slots),
}
    // rust: let sorted_indices = if translucent > 0 {
    // rust: let indices =
    // rust: self.sorted_indices
    // rust: .alloc(&self.device, encoder, u64::from(translucent) * 6);
    // rust: if indices.is_none() {
    // rust: release_main(&mut self.arena);
    // rust: if let Some(arena) = &mut self.translucent_arena {
    // rust: arena.release(translucent_at.0, translucent_at.1, translucent_vertices);
}
    // rust: return None;
}
    // rust: indices
    // rust: } else {
    // rust: None
}
        // Flat draws name the blocks of its ranges by its id: its range in `arena` and,
        // split, its translucent quads' in `translucent_arena` (`flat::TRANSLUCENT_KEYS`).
    // rust: let translucent_key = (split && translucent > 0)
    // rust: .then(|| (translucent_at.0 + flat::TRANSLUCENT_KEYS, translucent_at.1));
    // rust: let flat_id = self.flat.as_mut().and_then(|f| {
    // rust: let ranges = [(main > 0).then_some((page, start, main))]
    // rust: .into_iter()
    // rust: .chain([translucent_key.map(|(key, first)| (key, first, translucent_vertices))]);
    // rust: let mut id = None;
    // rust: for (key, first, vertices) in ranges.flatten() {
    // rust: let uploads = &mut self.section_uploads;
    // rust: match id {
    // rust: None => id = Some(f.add(&self.device, encoder, uploads, key, first, vertices)),
    // rust: Some(id) => f.place(&self.device, encoder, uploads, id, key, first, vertices),
}
}
    // rust: id
    // rust: });
    // rust: let stride = std::mem::size_of::<TerrainVertex>() as u64;
    // rust: let translucent_arena = self.translucent_arena.as_ref().unwrap_or(&self.arena);
    // rust: let solid_bytes: &[u8] = if packed {
    // rust: bytemuck::cast_slice(&mesh.packed)
    // rust: } else {
    // rust: bytemuck::cast_slice(&mesh.solid)
}
    // rust: for (bytes, arena, (part_page, first)) in [
    // rust: (solid_bytes, &self.arena, (page, start)),
    // rust: (
    // rust: bytemuck::cast_slice(&mesh.translucent),
    // rust: translucent_arena,
    // rust: translucent_at,
    // rust: ),
    // rust: ] {
    // rust: if !bytes.is_empty() {
    // rust: self.uploaded_bytes += bytes.len() as u64;
    // rust: self.section_copy_bytes += bytes.len() as u64;
    // rust: self.section_uploads.buffer(
    // rust: encoder,
    // rust: arena.buffer(part_page),
    // rust: first * stride,
    // rust: bytes,
    // rust: );
}
}
    // rust: if self.section_copy_bytes >= SECTION_COPY_LIMIT
    // rust: && let Some(copies) = self.take_section_copies()
    // rust: {
    // rust: self.queue.submit([copies]);
}
    // rust: let animated_layers =
    // rust: collect_animated_layers(mesh, |layer| self.animations.is_animated(layer));
    // rust: Some(SectionGpu {
    // rust: page,
    // rust: start,
    // rust: translucent_at,
    // rust: solid,
    // rust: solid_slots,
    // rust: packed,
    // rust: sides: if mesh.sides.quads() == solid {
    // rust: mesh.sides
    // rust: } else {
    // rust: Sides::unsorted(solid)
    // rust: },
    // rust: translucent,
    // rust: sort: translucency::SortState::new(
    // rust: mesh.translucent
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|q| translucency::quad_center(q[0].pos, q[2].pos))
    // rust: .collect(),
    // rust: ),
    // rust: sorted_indices,
    // rust: flat_id,
    // rust: gpu_id: None,
    // rust: gpu_fading: false,
    // rust: fading: None,
    // rust: leaving: None,
    // rust: animated_layers,
    // rust: })
}
    /// The section copies recorded since the last submission, closed.
pub fn take_section_copies(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let encoder = self.section_copies.take()?;
    // rust: self.section_copy_bytes = 0;
    // rust: self.section_uploads.finish(&encoder);
    // rust: Some(encoder.finish())
}
    /// Draws `count` section draws from `first` with the arenas and section
    /// origins bound: one indirect multi-draw, or a loop without it.
    /// Consecutive draws in one arena page share a vertex buffer binding,
    /// keeping the list's order (translucent sections go back to front).
    /// `indirect` holds the list's draws from `base`. Leaves the quad
    /// indices bound, as the draws after it expect.
    // rust: fn draw_sections(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: indirect: &wgpu::Buffer,
    // rust: base: u32,
    // rust: first: u32,
    // rust: count: u32,
    // rust: ) {
    // rust: self.draw_sections_from(pass, indirect, base, first, count, false);
}
    /// `draw_sections` through the solid pipelines that read the arena page themselves
    /// (`vs_section`): each page's group is bound as their group 1.
    // rust: fn draw_solid_sections(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: indirect: &wgpu::Buffer,
    // rust: base: u32,
    // rust: first: u32,
    // rust: count: u32,
    // rust: ) {
    // rust: self.draw_sections_from(pass, indirect, base, first, count, self.flat.is_some());
}
    // rust: fn draw_sections_from(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: indirect: &wgpu::Buffer,
    // rust: base: u32,
    // rust: first: u32,
    // rust: count: u32,
    // rust: pulled: bool,
    // rust: ) {
    // rust: let (draws, pages) = (&self.draws[..], &self.draw_pages[..]);
    // rust: let (mut i, end) = (first as usize, (first + count) as usize);
    // rust: while i < end {
    // rust: let (page, index_page) = pages[i];
    // rust: let run = pages[i..end]
    // rust: .iter()
    // rust: .take_while(|&&p| p == (page, index_page))
    // rust: .count();
            // Translucent draws, and only they, have sorted indices; split, their large
            // pages are bound up to their last range in use (`Arena::binding`).
    // rust: let (vertices, indices) = match (&self.translucent_arena, index_page) {
    // rust: (Some(arena), Some(p)) => (arena.binding(page), self.sorted_indices.binding(p)),
    // rust: (_, p) => (
    // rust: self.arena.buffer(page).slice(..),
    // rust: p.map_or(&self.indices, |p| self.sorted_indices.buffer(p))
    // rust: .slice(..),
    // rust: ),
}
    // rust: pass.set_vertex_buffer(0, vertices);
    // rust: if pulled
    // rust: && index_page.is_none()
    // rust: && let Some(group) = self.flat.as_ref().and_then(|f| f.page_group(page))
    // rust: {
    // rust: pass.set_bind_group(1, group, &[]);
}
    // rust: pass.set_index_buffer(indices, wgpu::IndexFormat::Uint32);
    // rust: if self.multi_draw {
    // rust: let offset = (i - base as usize) as u64 * 20;
    // rust: pass.multi_draw_indexed_indirect(indirect, offset, run as u32);
    // rust: } else {
    // rust: for d in &draws[i..i + run] {
    // rust: pass.draw_indexed(d[2]..d[2] + d[0], d[3] as i32, d[4]..d[4] + 1);
}
}
    // rust: i += run;
}
    // rust: if pages[first as usize..end]
    // rust: .iter()
    // rust: .any(|(_, sorted)| sorted.is_some())
    // rust: {
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
}
}
pub fn release_section(self: *Self, key: SectionKey) void {
}
    // rust: if let Some(s) = self.sections.remove(key) {
    // rust: self.release_mesh(s);
}
}
pub fn release_mesh(self: *Self, s: SectionGpu) void {
}
    // rust: if let (Some(flat), Some(id)) = (&mut self.flat, s.flat_id) {
    // rust: flat.remove(id);
}
    // rust: if let (Some(gpu), Some(id)) = (&mut self.gpu_culling, s.gpu_id) {
    // rust: gpu.records.remove(id);
}
    // rust: if let Some((page, start)) = s.sorted_indices {
    // rust: self.sorted_indices
    // rust: .release(page, start, u64::from(s.translucent) * 6);
}
    // rust: let (main, translucent) = s.vertex_ranges(self.translucent_arena.is_some());
    // rust: if let Some((page, start, vertices)) = main {
    // rust: self.arena.release(page, start, vertices);
}
    // rust: if let (Some(arena), Some((page, start, vertices))) =
    // rust: (&mut self.translucent_arena, translucent)
    // rust: {
    // rust: arena.release(page, start, vertices);
}
}
    /// Video memory the arena keeps because fragmentation holds its pages
    /// partly used (a render distance that went down, far tiles that were
    /// replaced): moves the meshes off the sparsest page, a few MiB a frame,
    /// and `Arena::trim` returns the page once it is empty. Frames with the
    /// arena in system memory (video memory full) are slow, so this is what
    /// keeps the terrain in video memory. The section arena's: the large pages
    /// of the translucent arena and the sorted indices are `shrink_translucent`'s.
    /// Returns what is left of the frame's `COMPACT_BUDGET`.
pub fn compact_arena(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut budget = COMPACT_BUDGET;
    // rust: if self.arena.closing().is_none()
    // rust: && let Some(page) = self.arena.sparsest()
    // rust: {
    // rust: self.arena.close(page);
}
    // rust: let Some(page) = self.arena.closing() else {
    // rust: return budget;
}
    // rust: let encoder = self.section_copies.get_or_insert_with(|| {
    // rust: self.device
    // rust: .create_command_encoder(&wgpu::CommandEncoderDescriptor {
    // rust: label: Some("Section uploads"),
    // rust: })
    // rust: });
    // rust: let meshes = self
    // rust: .sections
    // rust: .values_mut()
    // rust: .chain(self.lods.values_mut().flat_map(|tile| tile.meshes_mut()));
    // rust: let flat = self
    // rust: .flat
    // rust: .as_mut()
    // rust: .map(|f| (f, &self.device, &mut self.section_uploads));
        // GPU culling's records move with the sections.
    // rust: let gpu = self.gpu_culling.as_mut().map(|g| &mut g.records);
    // rust: let split = self.translucent_arena.is_some();
    // rust: let (arena, part) = (&mut self.arena, Part::Section { split });
    // rust: if !move_off_page(arena, encoder, flat, gpu, meshes, page, part, &mut budget) {
            // The other pages have no room after all.
    // rust: arena.reopen();
}
        // With every mesh moved off, the page stays closed so this frame's
        // uploads can't refill it: `trim` returns it and clears `closing`.
    // rust: budget
}
    /// Shrinks the large pages of the translucent arena and the sorted indices
    /// once terrain has settled (`set_terrain_loading`): one far larger than what
    /// it holds moves into a new page of their size (`begin_shrink`), through
    /// `move_off_page` with what `compact_arena` left of the frame's budget
    /// (`left`), and `trim` returns it once empty. One page at a time, vertices
    /// first; only starts wait, a move under way finishes even if terrain comes
    /// again (stopped, the page would stay closed while the new one fills).
pub fn shrink_translucent(self: *Self, left: u64) void {
}
    // rust: let Some(vertices) = self.translucent_arena.as_mut() else {
    // rust: return; // split off: nothing to shrink
}
    // rust: let now = Instant::now();
    // rust: let mut arenas = [
    // rust: (vertices, Part::Translucent),
    // rust: (&mut self.sorted_indices, Part::Indices),
    // rust: ];
    // rust: if arenas.iter().all(|(arena, _)| arena.closing().is_none()) {
    // rust: if !self.shrink_gate.may_start(now, left) {
    // rust: return;
}
            // The next start in a second, or `SHRINK_RETRY` after a try found no room.
    // rust: let mut wait = SHRINK_SETTLE;
    // rust: for (arena, part) in &mut arenas {
    // rust: let meshes = self
    // rust: .sections
    // rust: .values_mut()
    // rust: .chain(self.lods.values_mut().flat_map(|tile| tile.meshes_mut()));
    // rust: match begin_shrink(arena, &self.device, meshes, *part) {
    // rust: Some(true) => break,
    // rust: Some(false) => wait = SHRINK_RETRY, // the other arena may still go
    // rust: None => {}
}
}
    // rust: self.shrink_gate.wait(now, wait);
}
    // rust: let Some((arena, part, page)) = arenas.into_iter().find_map(|(arena, part)| {
    // rust: let page = arena.closing()?;
    // rust: Some((arena, part, page))
    // rust: }) else {
    // rust: return;
}
    // rust: let encoder = self.section_copies.get_or_insert_with(|| {
    // rust: self.device
    // rust: .create_command_encoder(&wgpu::CommandEncoderDescriptor {
    // rust: label: Some("Section uploads"),
    // rust: })
    // rust: });
    // rust: let meshes = self
    // rust: .sections
    // rust: .values_mut()
    // rust: .chain(self.lods.values_mut().flat_map(|tile| tile.meshes_mut()));
        // As many quads a frame either way: a quad's indices are a quarter of its bytes.
    // rust: let cap = match part {
    // rust: Part::Indices => COMPACT_BUDGET / 4,
    // rust: _ => COMPACT_BUDGET,
}
    // rust: let mut budget = left.min(cap);
        // Flat draws name translucent quads' blocks by their section's id; indices have none.
    // rust: let flat = match part {
    // rust: Part::Translucent => self.flat.as_mut(),
    // rust: _ => None,
}
    // rust: .map(|f| (f, &self.device, &mut self.section_uploads));
        // GPU culling's records follow the section arena alone.
    // rust: if !move_off_page(arena, encoder, flat, None, meshes, page, part, &mut budget) {
            // New ranges took the room: both pages stay, drawn, until a later try.
    // rust: arena.reopen();
    // rust: self.shrink_gate.wait(now, SHRINK_RETRY);
}
}
    /// Block-entity blocks of every meshed section (see `SectionMesh::block_entities`).
pub fn block_entities(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.block_entities.values().flatten()
}
    /// `block_entities` of the sections far enough into their fade-in to draw them
    /// (`LevelExtractor.extractVisibleBlockEntities`: `getVisibility(now, fade) >= 0.3`).
    // rust: pub fn visible_block_entities(
    // rust: &self,
    // rust: fade_seconds: f32,
    // rust: ) -> impl Iterator<Item = &([i32; 3], u32)> {
    // rust: let fade = fade_millis(fade_seconds);
    // rust: let now = std::time::Instant::now();
    // rust: let all = !self.sections_fading_in(fade, now);
    // rust: self.block_entities
    // rust: .iter()
    // rust: .filter(move |(key, _)| {
    // rust: all || chunk_visibility(self.section_elapsed_ms(**key, now), fade)
    // rust: >= CHUNK_VISIBILITY_THRESHOLD
    // rust: })
    // rust: .flat_map(|(_, blocks)| blocks)
}
    /// Whether a section may still be fading in over `fade_ms` (vanilla's chunk fade): one was
    /// uploaded more recently than that. Otherwise every section is whole.
pub fn sections_fading_in(self: *Self, fade_ms: u64, now: std::time::Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fade_ms > 0
    // rust: && self
    // rust: .newest_upload
    // rust: .is_some_and(|t| (now.saturating_duration_since(t).as_millis() as u64) < fade_ms)
}
    /// Whether a section may be fading in or out over far terrain (`SectionGpu::fade`):
    /// otherwise every section's code is 0.
pub fn sections_fading_over_lods(self: *Self, now: std::time::Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.lod_retiring.is_empty()
    // rust: || !self.lod_leaving.is_empty()
    // rust: || self
    // rust: .newest_lod_fade
    // rust: .is_some_and(|t| now.saturating_duration_since(t) < lod::FADE)
}
    /// Block entities in sections which can intersect the camera frustum.
    /// The section bounds include the same one-block margin as the per-block
    /// check in the game. Sections wholly inside the frustum skip that finer
    /// check; sections outside it are kept only when a renderer needs to draw
    /// geometry extending beyond its block (beacon beams, gateways, outlines).
    // rust: pub fn visible_block_entities_in_frustum<'a>(
    // rust: &'a self,
    // rust: fade_seconds: f32,
    // rust: camera: DVec3,
    // rust: frustum: Option<Frustum>,
    // rust: keep_section: impl Fn(u32) -> bool + 'a,
    // rust: keep_long_range: impl Fn(u32) -> bool + 'a,
    // rust: ) -> impl Iterator<Item = (&'a ([i32; 3], u32), bool)> + 'a {
    // rust: let fade = fade_millis(fade_seconds);
    // rust: let now = Instant::now();
        // No section uploaded within the fade: all are whole, none is looked up.
    // rust: let all = !self.sections_fading_in(fade, now);
    // rust: let min_y = self.layout.min_y();
    // rust: self.block_entities
    // rust: .iter()
    // rust: .filter(move |(key, _)| {
    // rust: all || chunk_visibility(self.section_elapsed_ms(**key, now), fade)
    // rust: >= CHUNK_VISIBILITY_THRESHOLD
    // rust: })
    // rust: .filter_map(move |(key, blocks)| {
    // rust: let origin = DVec3::new(
    // rust: f64::from(key.0 * 16 - 1),
    // rust: f64::from(min_y + key.1 * 16 - 1),
    // rust: f64::from(key.2 * 16 - 1),
    // rust: ) - camera;
    // rust: let min = origin.as_vec3();
                // The last block's expanded bound ends at section_origin + 17.
    // rust: let max = min + Vec3::splat(18.0);
    // rust: let distance_squared = Vec3::ZERO.max(min).min(max).length_squared();
    // rust: let in_range = distance_squared <= 64.0 * 64.0
    // rust: || (distance_squared <= 256.0 * 256.0
    // rust: && blocks.iter().any(|(_, state)| keep_long_range(*state)));
    // rust: if !in_range {
    // rust: return None;
}
    // rust: let (intersects, fully_inside) = frustum.map_or((true, true), |view| {
    // rust: let fully_inside = view.contains(min, max);
    // rust: (fully_inside || view.intersects(min, max), fully_inside)
    // rust: });
    // rust: (intersects || blocks.iter().any(|(_, state)| keep_section(*state)))
    // rust: .then_some((blocks, fully_inside))
    // rust: })
    // rust: .flat_map(|(blocks, fully_inside)| {
    // rust: blocks.iter().map(move |block| (block, fully_inside))
    // rust: })
}
    /// The block entities of the sections a shader pack's shadow pass drew in the last frame
    /// (`shadow_visible`), within the 64 blocks `visible_block_entities_in_frustum` keeps.
    /// Our probe packs' Iris 1.11.7 shadow maps hold a block entity wherever the shadow pass
    /// draws its section's terrain, whether or not the camera's view takes it in (#8464).
    // rust: pub fn shadow_pass_block_entities(
    // rust: &self,
    // rust: camera: DVec3,
    // rust: ) -> impl Iterator<Item = &([i32; 3], u32)> + '_ {
    // rust: block_entities_within_reach(
    // rust: self.shadow_visible.iter().map(|v| v.key),
    // rust: &self.block_entities,
    // rust: camera,
    // rust: self.layout.min_y(),
    // rust: )
}
    /// Whether a shader pack's shadow pass drew the section holding block `pos` in the last
    /// frame (`shadow_pass_block_entities`).
pub fn shadow_pass_drew(self: *Self, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = (
    // rust: pos[0] >> 4,
    // rust: (pos[1] - self.layout.min_y()) >> 4,
    // rust: pos[2] >> 4,
    // rust: );
    // rust: self.shadow_visible.iter().any(|v| v.key == key)
}
    /// Milliseconds since `key` was uploaded; a section not in `section_uploaded` is old.
pub fn section_elapsed_ms(self: *Self, key: SectionKey, now: std::time::Instant) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.section_uploaded.get(&key).map_or(u64::MAX, |t| {
    // rust: now.saturating_duration_since(*t).as_millis() as u64
    // rust: })
}
    /// A value that changes whenever `block_entities` gives something else.
pub fn block_entity_revision(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.block_entity_revision
}
    /// Both mesh/light and block-entity membership revisions for a section
    /// key (`x`, section-y relative to the dimension's minimum, `z`).
    // rust: pub fn block_entity_section_revision(
    // rust: &self,
    // rust: section: [i32; 3],
    // rust: ) -> Option<StaticSectionRevision> {
    // rust: let key = (section[0], section[1], section[2]);
    // rust: Some(StaticSectionRevision {
    // rust: mesh: *self.block_entity_section_revisions.get(&key)?,
    // rust: block_entities: *self.block_entity_membership_revisions.get(&key)?,
    // rust: })
}
    /// Block-entity cache work and upload volume from the last rendered frame.
pub fn static_block_entity_frame_stats(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.static_entity_frame_stats
}
    /// Drops every section, for a level whose chunks hold `layout`.
pub fn clear_sections(self: *Self, layout: crate::chunk::ColumnLayout) void {
}
    // rust: if let Some(copies) = &mut self.capture_copies {
    // rust: *copies = capture::Copies::default();
}
    // rust: self.block_entities.clear();
    // rust: self.block_entity_section_revisions.clear();
    // rust: self.block_entity_membership_revisions.clear();
    // rust: self.section_uploaded.clear();
    // rust: self.newest_upload = None;
    // rust: self.newest_lod_fade = None;
    // rust: self.block_entity_revision = next_block_entity_revision();
    // rust: self.sections.clear();
    // rust: self.lods.clear();
    // rust: self.lod_cutout.clear();
    // rust: self.lod_retiring.clear();
    // rust: self.lod_leaving.clear();
    // rust: self.lod_pending = None;
    // rust: self.detail_columns.clear();
    // rust: self.detail_revision += 1;
        // A dimension change drops every page at once: freed later, off this thread.
    // rust: self.graveyard.add(self.arena.clear());
    // rust: if let Some(gpu) = &mut self.gpu_culling {
    // rust: gpu.records.clear();
            // The chunk fade-in time they were decided with stays.
    // rust: gpu.fades.clear();
}
    // rust: if let Some(arena) = &mut self.translucent_arena {
    // rust: self.graveyard.add(arena.clear());
}
    // rust: if let Some(flat) = &mut self.flat {
    // rust: flat.clear();
}
    // rust: self.graveyard.add(self.sorted_indices.clear());
    // rust: self.translucency_cursor = 0;
    // rust: if layout == self.layout {
    // rust: self.occlusion.clear();
    // rust: } else {
    // rust: self.layout = layout;
    // rust: self.occlusion = occlusion::Occlusion::new(layout.min_y(), layout.sections() as i32);
    // rust: self.sections.set_min_y(layout.min_y());
}
}
    /// Lays the sections out as `translucent_split` says for the shader pack that
    /// runs, before a world frame draws them. A change drops every section and far
    /// tile, as a new renderer has none, and changes the sorted indices' arena with
    /// them (large pages beside the translucent arena, else pages flat draws bind):
    /// the game meshes them again (`take_dropped_sections`).
pub fn follow_translucent_layout(self: *Self) void {
}
    // rust: let pack = self.pack_post.as_ref().and_then(|p| p.1.as_ref());
    // rust: let split = translucent_split(
    // rust: self.translucent_batching,
    // rust: self.flat.is_some() && self.flat_on,
    // rust: pack.is_some_and(pack_post::PackPost::has_terrain),
            // One of Horizon's own packs with `[shadow]` draws from the same lists (`shadow_view`).
    // rust: pack.is_some_and(pack_post::PackPost::has_shadow) || self.native_shadow(),
    // rust: );
    // rust: if split == self.translucent_arena.is_some() {
    // rust: return;
}
    // rust: self.sections_dropped |=
    // rust: self.sections.len() > 0 || !self.lods.is_empty() || self.lod_pending.is_some();
    // rust: self.clear_sections(self.layout);
    // rust: (self.sorted_indices, self.translucent_arena) = arena::Arena::translucent_arenas(
    // rust: &self.device,
    // rust: std::mem::size_of::<TerrainVertex>() as u64,
    // rust: self.flat.is_some(),
    // rust: split,
    // rust: );
    // rust: if let (Some(flat), Some(arena)) = (&mut self.flat, &self.translucent_arena) {
    // rust: flat.set_translucent_page_vertices(arena.page_vertices());
}
}
    /// Uploads solid quads in the compact layout (`packed_quads`) while no shader pack runs:
    /// a pack's terrain and shadow programs, and Horizon's own packs' stages, read the
    /// arena's vertices as `TerrainVertex`es. Leaving it drops every section and far tile
    /// for the game to mesh again, as `follow_translucent_layout` does.
pub fn follow_packed_layout(self: *Self) void {
}
    // rust: let pack = self.pack_post.as_ref().and_then(|p| p.1.as_ref()).is_some();
    // rust: let want = self.flat.is_some() && !pack && self.native.is_none() && packed_wanted();
    // rust: if want == self.packed_quads {
    // rust: return;
}
    // rust: self.packed_quads = want;
    // rust: packed::pack_quads(want);
    // rust: if !want && self.sections.values().any(|s| s.packed) {
    // rust: self.sections_dropped = true;
    // rust: self.clear_sections(self.layout);
}
}
    /// Whether every section and far tile was dropped since the last call, to be
    /// laid out again (`follow_translucent_layout`): the game meshes them again,
    /// as for a new renderer.
pub fn take_dropped_sections(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.sections_dropped)
}
    /// Whether terrain is on its way (the view not all in, events, chunks or
    /// uploads still waiting, far tiles sampled): a large translucent page shrinks
    /// once that, new translucent sections (`upload`) and far tiles to upload
    /// (`upload_lods`) have been over for `SHRINK_SETTLE`, not at the low point
    /// between a view's columns leaving and the next one's arriving, after which
    /// it would grow back by whole copies.
pub fn set_terrain_loading(self: *Self, loading: bool) void {
}
    // rust: if loading {
    // rust: self.shrink_gate.wait(Instant::now(), SHRINK_SETTLE);
}
}
    /// A column whose every section has its mesh (`lod_detail_columns`).
pub fn complete_column(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SectionMask::below(self.layout.sections())
}
pub fn lod_detail_columns(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let complete = self.complete_column();
    // rust: self.detail_columns
    // rust: .iter()
    // rust: .filter_map(move |(&column, &mask)| (mask == complete).then_some(column))
}
    /// Changes whenever `lod_detail_columns` does.
pub fn lod_detail_revision(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.detail_revision
}
    /// Whether the section at `key` has its mesh, for `lod_detail_columns`.
pub fn set_detail(self: *Self, key: SectionKey, meshed: bool) void {
}
    // rust: let column = (key.0, key.2);
    // rust: let mask = self
    // rust: .detail_columns
    // rust: .get(&column)
    // rust: .copied()
    // rust: .unwrap_or_default();
    // rust: let mut next = mask;
    // rust: if meshed {
    // rust: next.insert(key.1 as usize);
    // rust: } else {
    // rust: next.remove(key.1 as usize);
}
    // rust: let complete = self.complete_column();
    // rust: if (mask == complete) != (next == complete) {
    // rust: self.detail_revision += 1;
}
    // rust: if next.is_empty() {
    // rust: self.detail_columns.remove(&column);
    // rust: } else {
    // rust: self.detail_columns.insert(column, next);
}
}
    /// Every section of these columns goes: one lookup per column where the
    /// tables are by column, and the meshes' ranges freed in one batch. A
    /// teleport removes a few thousand columns in one frame.
    /// A section whose column far terrain now draws fades out over it, chunk by
    /// chunk as it came, and is released once it has (`release_left`): taken
    /// away at once, the column's detail dropped to the far terrain's in one
    /// frame.
pub fn leave_section(self: *Self, key: SectionKey) void {
}
    // rust: let now = std::time::Instant::now();
    // rust: if let Some(section) = self.sections.find_mut(key)
    // rust: && section.leaving.is_none()
    // rust: {
    // rust: section.leaving = Some(now);
    // rust: self.lod_leaving.push((key, now));
    // rust: if let Some(gpu) = &mut self.gpu_culling {
    // rust: hold_fading(&mut self.sections, &mut gpu.records, key);
}
}
}
    /// Releases the sections that have faded out (`leave_section`).
pub fn release_left(self: *Self, now: std::time::Instant) void {
}
    // rust: let mut done = Vec::new();
    // rust: self.lod_leaving.retain(|&(key, since)| {
    // rust: let left = now.saturating_duration_since(since) >= lod::FADE;
    // rust: if left {
    // rust: done.push((key, since));
}
    // rust: !left
    // rust: });
    // rust: for (key, since) in done {
            // Meshed again since (the player came back): it stays.
    // rust: if self
    // rust: .sections
    // rust: .find(key)
    // rust: .is_some_and(|s| s.leaving == Some(since))
    // rust: {
    // rust: self.release_section(key);
}
}
}
pub fn remove_columns(self: *Self, columns: impl IntoIterator<Item = (i32) void {
}
    // rust: let columns: Vec<(i32, i32)> = columns.into_iter().collect();
    // rust: if let Some(copies) = &mut self.capture_copies {
    // rust: copies.remove_columns(&columns);
}
        // Most of the view at once (a teleport at render distance 32 drops some 3700
        // columns): a pass over each store instead of a lookup per section key, which
        // took 10 ms of one frame. Far terrain fades the sections out instead.
    // rust: let keys = columns.len() * self.layout.sections();
    // rust: if self.lods.is_empty()
    // rust: && self.lod_cutout.is_empty()
    // rust: && keys >= self.sections.len().max(BULK_REMOVAL_KEYS)
    // rust: {
    // rust: self.remove_columns_at_once(&columns);
    // rust: return;
}
    // rust: let mut released = Vec::new();
    // rust: let mut block_entities = false;
    // rust: for (x, z) in columns {
    // rust: if self.detail_columns.remove(&(x, z)) == Some(self.complete_column()) {
    // rust: self.detail_revision += 1;
}
    // rust: self.occlusion.remove_column(x, z);
    // rust: let retiring = !self.lod_cutout.is_empty() && self.lod_cutout.contains(&(x, z));
    // rust: for sy in 0..self.layout.sections() as i32 {
    // rust: let key = (x, sy, z);
    // rust: block_entities |= self.block_entities.remove(&key).is_some();
    // rust: self.block_entity_section_revisions.remove(&key);
    // rust: self.block_entity_membership_revisions.remove(&key);
    // rust: if self.light_blocks.remove(&key).is_some() {
    // rust: self.light_revision += 1;
}
    // rust: self.section_uploaded.remove(&key);
    // rust: if retiring {
                    // Distant tiles still leave its column out: drawn until they don't.
    // rust: self.lod_retiring.insert(key);
    // rust: if let Some(gpu) = &mut self.gpu_culling {
    // rust: hold_fading(&mut self.sections, &mut gpu.records, key);
}
    // rust: } else if !self.lods.is_empty() && self.sections.contains(key) {
                    // Far terrain draws the column: it fades out over it.
    // rust: self.leave_section(key);
    // rust: } else if let Some(section) = self.sections.remove(key) {
    // rust: released.push(section);
}
}
}
    // rust: if block_entities {
    // rust: self.block_entity_revision = next_block_entity_revision();
}
    // rust: self.release_meshes(released);
}
    /// `remove_columns` for a large share of the resident sections: each store filtered
    /// once by column.
pub fn remove_columns_at_once(self: *Self, columns: *[(i32) void {
}
    // rust: let gone: crate::fast_hash::FxHashSet<(i32, i32)> = columns.iter().copied().collect();
    // rust: let complete = self.complete_column();
    // rust: for &(x, z) in columns {
    // rust: if self.detail_columns.remove(&(x, z)) == Some(complete) {
    // rust: self.detail_revision += 1;
}
}
    // rust: self.occlusion.remove_columns(&gone);
    // rust: let kept = |key: &SectionKey| !gone.contains(&(key.0, key.2));
    // rust: let before = self.block_entities.len();
    // rust: self.block_entities.retain(|key, _| kept(key));
    // rust: if self.block_entities.len() != before {
    // rust: self.block_entity_revision = next_block_entity_revision();
}
    // rust: let before = self.light_blocks.len();
    // rust: self.light_blocks.retain(|key, _| kept(key));
    // rust: self.light_revision += (before - self.light_blocks.len()) as u64;
    // rust: self.section_uploaded.retain(|key, _| kept(key));
    // rust: let released = self.sections.remove_columns(&gone);
    // rust: self.release_meshes(released);
}
    /// Gives the removed sections' quads back to their arenas; the sections themselves
    /// (their sort centres) drop on a thread of their own when there are many.
pub fn release_meshes(self: *Self, released: std.ArrayList(SectionGpu)) void {
}
    // rust: if let Some(flat) = &mut self.flat {
    // rust: for id in released.iter().filter_map(|s| s.flat_id) {
    // rust: flat.remove(id);
}
}
    // rust: if let Some(gpu) = &mut self.gpu_culling {
    // rust: gpu.records
    // rust: .remove_all(released.iter().filter_map(|s| s.gpu_id));
}
    // rust: self.sorted_indices
    // rust: .release_all(released.iter().filter_map(|s| {
    // rust: let (page, start) = s.sorted_indices?;
    // rust: Some((page, start, u64::from(s.translucent) * 6))
    // rust: }));
    // rust: let split = self.translucent_arena.is_some();
    // rust: self.arena
    // rust: .release_all(released.iter().filter_map(|s| s.vertex_ranges(split).0));
    // rust: if let Some(arena) = &mut self.translucent_arena {
    // rust: arena.release_all(released.iter().filter_map(|s| s.vertex_ranges(true).1));
}
    // rust: if released.len() >= BULK_REMOVAL_KEYS {
    // rust: arena::free_later(released);
}
}
    /// Horizon's resolution scale (world pixels per window pixel) and FXAA.
    /// Configures `surface` and, while HDR output is on, sends its HDR metadata
    /// again: a new swapchain starts without it. Errs when `surface` was left
    /// unconfigured (a validation error, or a lost device, which wgpu reports
    /// to no error scope).
    // rust: fn configure(
    // rust: device: &wgpu::Device,
    // rust: surface: &wgpu::Surface<'_>,
    // rust: config: &wgpu::SurfaceConfiguration,
    // rust: hdr: Option<&hdr::Hdr>,
    // rust: device_lost: &std::sync::atomic::AtomicBool,
    // rust: ) -> std::result::Result<(), String> {
    // rust: let validation = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let memory = device.push_error_scope(wgpu::ErrorFilter::OutOfMemory);
    // rust: surface.configure(device, config);
    // rust: let memory = pollster::block_on(memory.pop());
    // rust: if let Some(e) = memory.or(pollster::block_on(validation.pop())) {
    // rust: return Err(e.to_string());
}
    // rust: if device_lost.load(std::sync::atomic::Ordering::Relaxed) {
    // rust: return Err("the graphics device was lost".into());
}
    // rust: if let Some(hdr) = hdr {
    // rust: horizon_hdr::set_metadata(
    // rust: device,
    // rust: surface,
    // rust: hdr.paper_white,
    // rust: hdr.declared_peak(),
    // rust: hdr.black,
    // rust: );
}
    // rust: Ok(())
}
    /// Configures the window surface again. One that fails is still the one
    /// wgpu configured before, which acquisition reports as a validation error.
pub fn configure_surface(self: *Self) void {
}
    // rust: self.frame_gen.stop();
        // The submit thread may still present to the old swapchain.
    // rust: self.queue.wait();
    // rust: if let Some(surface) = &self.surface
    // rust: && let Err(e) = Self::configure(
    // rust: &self.device,
    // rust: surface,
    // rust: &self.surface_config(),
    // rust: self.hdr.as_ref(),
    // rust: &self.device_lost,
    // rust: )
    // rust: {
    // rust: log::warn!("Horizon renderer: the window surface did not configure ({e})");
}
}
    /// HDR calibration's test picture (`crate::hdr_calibration`) while it runs, else None.
pub fn set_hdr_calibration(self: *Self, calibration: ?HdrCalibration) void {
}
    // rust: let Some(hdr) = &mut self.hdr else {
    // rust: return;
}
    // rust: if hdr.calibration == calibration {
    // rust: return;
}
    // rust: let declared = hdr.declared_peak();
    // rust: hdr.calibration = calibration;
    // rust: if hdr.declared_peak() != declared {
    // rust: self.send_hdr_metadata();
}
}
pub fn send_hdr_metadata(self: *Self) void {
}
    // rust: if let (Some(surface), Some(hdr)) = (&self.surface, &self.hdr) {
    // rust: horizon_hdr::set_metadata(
    // rust: &self.device,
    // rust: surface,
    // rust: hdr.paper_white,
    // rust: hdr.declared_peak(),
    // rust: hdr.black,
    // rust: );
}
}
    /// The swapchain's configuration: `config` (what every pipeline draws in), or
    /// HDR10 or scRGB while HDR output is on.
pub fn surface_config(self: *Self) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut config = self.config.clone();
    // rust: if let Some(hdr) = &self.hdr {
    // rust: config.format = hdr.output.format();
    // rust: config.view_formats = vec![hdr.output.format()];
    // rust: config.color_space = hdr.output.color_space();
    // rust: config.usage = wgpu::TextureUsages::RENDER_ATTACHMENT;
}
    // rust: config
}
    /// The F3 screen's HDR line while the setting is on: the swapchain HDR presents to with
    /// its paper white and peak, or that the surface offers none.
    /// Whether HDR output is on: the setting, where the display offers it.
pub fn hdr_on(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.hdr.is_some()
}
pub fn hdr_line(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.hdr {
    // rust: Some(hdr) => format!(
    // rust: "HDR: {}, {}/{} nits",
    // rust: hdr.output.name(),
    // rust: hdr.paper_white.round(),
    // rust: hdr.peak.round()
    // rust: ),
    // rust: None => "HDR: not offered by this display".into(),
}
}
    /// The HDR Lighting setting (`Hdr::look`).
pub fn set_hdr_lighting(self: *Self, on: bool) void {
}
    // rust: self.hdr_lighting_setting = on;
    // rust: if let Some(hdr) = &mut self.hdr {
    // rust: hdr.look = on;
}
}
    /// HDR output (Horizon setting): HDR10 or scRGB at `paper_white` nits, the world's
    /// highlights expanded up to `peak` nits. Off where the surface can't present it.
    /// Offscreen (`hdr::offscreen_output`) the frame is drawn the same and its HDR screenshot
    /// taken, but nothing is presented, and Auto takes its defaults: no display reports.
    // rust: pub fn set_hdr(
    // rust: &mut self,
    // rust: on: bool,
    // rust: paper_white: f32,
    // rust: peak: f32,
    // rust: black: f32,
    // rust: ui: f32,
    // rust: marker: &std::path::Path,
    // rust: ) {
    // rust: let output = self
    // rust: .hdr_output
    // rust: .filter(|_| on && (self.surface.is_some() || self.offscreen.is_some()));
    // rust: if output.is_some() != self.hdr.is_some() {
            // If the game dies before HDR output shows a frame, the marker is still there at
            // the next start, which then comes up with HDR off.
    // rust: if output.is_some() {
    // rust: if self.surface.is_some() {
    // rust: let _ = std::fs::write(marker, "HDR output was being switched on\n");
    // rust: self.hdr_marker = Some(marker.to_owned());
}
    // rust: } else if let Some(marker) = self.hdr_marker.take() {
    // rust: let _ = std::fs::remove_file(marker);
}
            // Only HDR output asks the system about the display, so with HDR off the
            // game never waits on the compositor for it.
    // rust: self.display = if output.is_some() {
    // rust: let (watch, now) = if self.surface.is_some() {
    // rust: DisplayWatch::new(&self.window, self.surface.as_deref(), &self.adapter)
    // rust: } else {
    // rust: (DisplayWatch::default(), None)
}
    // rust: crate::graphics::report(now);
    // rust: self.display_fresh = true;
    // rust: watch
    // rust: } else {
    // rust: DisplayWatch::default()
}
    // rust: let format = self.frame_format;
    // rust: self.hdr =
    // rust: output.map(|output| hdr::Hdr::new(&self.device, &self.queue, format, output));
    // rust: if let Some(hdr) = &mut self.hdr {
    // rust: hdr.look = self.hdr_lighting_setting;
}
    // rust: self.configure_surface();
    // rust: match output {
    // rust: Some(output) => log::info!(
    // rust: "Horizon renderer: HDR on: {} ({:?}), {paper_white}/{peak} nits",
    // rust: output.name(),
    // rust: output.format()
    // rust: ),
    // rust: None => log::info!("Horizon renderer: HDR off"),
}
    // rust: self.measure_emission();
}
    // rust: if let Some(hdr) = &mut self.hdr {
    // rust: hdr.ui = ui;
}
    // rust: if let Some(hdr) = &mut self.hdr
    // rust: && (hdr.paper_white, hdr.peak, hdr.black) != (paper_white, peak, black)
    // rust: {
    // rust: hdr.paper_white = paper_white;
    // rust: hdr.peak = peak;
    // rust: hdr.black = black;
    // rust: self.send_hdr_metadata();
}
}
    /// Measures which pixels of each block sprite may shine (`hdr_stats`), at the current
    /// masks. Only with HDR output on: without it the frame's alpha is never read.
pub fn measure_emission(self: *Self) void {
}
    // rust: if let Some(hdr) = &self.hdr {
    // rust: let views = sprite_views(&self.sprite_textures, &self.sprite_unused, None);
    // rust: self.emission_stats
    // rust: .measure(&self.device, &self.queue, &views, hdr.masks);
}
}
    /// Whether what the system reports for the display changed (another output, the
    /// player recalibrating the desktop): the settings' Auto values follow it then, so
    /// apply them again.
pub fn display_changed(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: flush_display_log();
    // rust: if std::mem::take(&mut self.display_fresh) {
    // rust: return true;
}
    // rust: let Some(now) = self.display.changed(self.surface.as_deref(), &self.adapter) else {
    // rust: return false;
}
    // rust: crate::graphics::report(now);
    // rust: true
}
    /// The share of real frames frame generation shows a made frame before (1 while it
    /// keeps up), `None` while it isn't running.
    /// The posed models' store size (`SkinFrame::base`), with entity skinning.
pub fn skinned_models(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entity_skin
    // rust: .as_ref()
    // rust: .map(entity_skin::EntitySkin::stored)
}

    /// Whether the game may pose ordinary entity models on the GPU (`Frame::skin`).
    /// Standard packs need every bridge stage; native packs, frame generation and
    /// native observers of the CPU entity stream retain their existing fallback.
pub fn skins_entities(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entity_skin.is_some()
    // rust: && !self.frame_gen.on
    // rust: && self.pack_post.as_ref().is_none_or(|(_, post)| {
    // rust: post.as_ref().is_some_and(|post| post.skins_entities())
    // rust: && !native_render::render_needs().entity_spans
    // rust: })
    // rust: && self.native.is_none()
}

    /// Whether the layers tagged `OIT_ENTITY` (the eyes render type's, horse
    /// markings, a slime's outer cube) may be posed on the GPU too
    /// (`mobs::skin::SkinModels::tagged`): only with improved transparency off,
    /// where they are ordinary entity quads. On, `EntityBatch` sorts them into
    /// its stages by the CPU vertices' `OIT_ENTITY` tag.
pub fn skins_tagged(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.skins_entities() && !self.improved_transparency && self.pack_post.is_none()
}

pub fn frame_generation_share(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.frame_gen.made_share
}
    /// Frame generation on or off (FSR 3.1's frame interpolation).
pub fn set_frame_generation(self: *Self, on: bool) void {
}
    // rust: if !on {
    // rust: self.frame_gen.stop();
}
    // rust: self.frame_gen.on = on;
}
    /// `upscale`: output pixels per rendered pixel, for TAA to rebuild (1: native).
pub fn set_world_post(self: *Self, scale: f32, antialias: bool, taa: bool, upscale: f32) void {
}
    // rust: let taa = taa && self.world_post.supports_taa();
    // rust: self.world_post.scale = scale.clamp(0.25, 2.0);
    // rust: self.world_post.antialias = antialias && !taa;
    // rust: self.world_post.taa = taa;
    // rust: self.world_post.upscale = if taa { upscale.clamp(1.0, 4.0) } else { 1.0 };
}
    /// Runs `post` over the world from now on (`None`: no pack), for the dimension `dimension`;
    /// `block_ids` gives each block sprite layer's `mc_Entity` (id, fluid) and `at_midBlock.w`
    /// (its block's light), three values a layer.
    /// Returns the programs that run and the notes of loading them, or why the pack can't run:
    /// the dimension then runs without a pack.
    // rust: pub fn set_shader_pack(
    // rust: &mut self,
    // rust: dimension: i32,
    // rust: pack: Option<horizon_shaders::Post>,
    // rust: block_ids: &[i32],
    // rust: ) -> std::result::Result<Option<(Vec<String>, Vec<String>)>, pack_post::Refused> {
    // rust: if pack.is_none() {
    // rust: self.pack_atlas = None;
    // rust: self.pack_material_atlases = None;
}
    // rust: let instance = wgpu::vertex_attr_array![5=>Float32x4];
    // rust: let vertex = wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<TerrainVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &TERRAIN_ATTRIBUTES,
}
    // rust: let instances = wgpu::VertexBufferLayout {
    // rust: array_stride: 16,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &instance,
}
    // rust: let buffers = [Some(vertex), Some(instances)];
    // rust: let flat = self.pack_terrain_flat;
    // rust: let sprite_rects = self
    // rust: .pack_atlas
    // rust: .as_ref()
    // rust: .map_or_else(Vec::new, |a| a.rects_table());
    // rust: let post = pack.map(|post| {
    // rust: let world = pack_post::World {
    // rust: atlas: self.pack_atlas.as_ref().map(|a| (a.view.clone(), a.size())),
    // rust: sprite_rects: &sprite_rects,
    // rust: material_maps: self
    // rust: .pack_material_atlases
    // rust: .as_ref()
    // rust: .map(|a| [a[0].view.clone(), a[1].view.clone()]),
    // rust: lightmap: self.lightmap_view.clone(),
    // rust: gui_size: self
    // rust: .hud
    // rust: .atlas_texture
    // rust: .as_ref()
    // rust: .map_or([1, 1], |t| [t.width(), t.height()]),
    // rust: terrain: self.pack_atlas.as_ref().map(|_| pack_post::Geometry {
    // rust: buffers: if flat { &buffers[..1] } else { &buffers },
    // rust: table: self.flat.as_ref().filter(|_| flat).map(|f| &f.draw_layout),
    // rust: depth_write: true,
    // rust: atlas: None,
    // rust: material_maps: true,
    // rust: ids: None,
    // rust: cull: true,
    // rust: }),
    // rust: block_ids,
    // rust: celestial: self
    // rust: .hud
    // rust: .atlas_texture
    // rust: .as_ref()
    // rust: .map(|t| t.create_view(&Default::default())),
    // rust: clouds: Some(&self.cloud_bindings),
    // rust: weather: true,
    // rust: hand: true,
}
    // rust: pack_post::PackPost::new(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: &self.adapter,
    // rust: post,
    // rust: self.frame_format,
    // rust: world,
    // rust: )
    // rust: });
    // rust: let post = match post.transpose() {
    // rust: Ok(post) => post,
    // rust: Err(e) => {
    // rust: self.pack_post = Some((dimension, None));
    // rust: self.pack_atlas = None;
    // rust: self.pack_material_atlases = None;
    // rust: return Err(e);
}
}
    // rust: let report = post.as_ref().map(|p| {
    // rust: let programs = p.programs().into_iter().map(str::to_owned).collect();
    // rust: (programs, p.notes.clone())
    // rust: });
    // rust: self.pack_post = Some((dimension, post));
    // rust: if self.pack_post.as_ref().is_some_and(|p| p.1.is_some()) {
    // rust: self.native = None;
}
    // rust: Ok(report)
}
    /// Drops the running shader pack, of either kind.
pub fn drop_shader_packs(self: *Self) void {
}
    // rust: self.pack_post = None;
    // rust: self.native = None;
    // rust: self.pack_atlas = None;
    // rust: self.separate_ao = false;
}
    /// Sets whether shader pack terrain inputs pass vertex alpha to `hz_Color.a` (`separateAo=true`).
pub fn set_separate_ao(self: *Self, separate_ao: bool) void {
}
    // rust: if self.separate_ao != separate_ao {
    // rust: self.separate_ao = separate_ao;
    // rust: if let Some(atlas) = &mut self.pack_atlas {
    // rust: atlas.separate_ao = separate_ao;
}
}
}
    /// Lava's sprite layers (still and flowing), whose faces a pack's solid terrain draws.
pub fn set_pack_lava_layers(self: *Self, layers: std.ArrayList(u16)) void {
}
    // rust: self.pack_lava_layers = layers;
}
    /// Runs the sky, material and post stages of one of Horizon's own shader packs from now
    /// on (`None`: no pack), with its options' values; replaces a `shaders/` pack. Returns the
    /// stages' labels; on an error the pack that ran keeps running.
    // rust: pub fn set_native_shader_pack(
    // rust: &mut self,
    // rust: pack: Option<(
    // rust: horizon_shader_api::Report,
    // rust: Vec<(String, f64)>,
    // rust: Vec<(u32, u32)>,
    // rust: Vec<(u32, u32)>,
    // rust: block_light::LightTable,
    // rust: )>,
    // rust: ) -> std::result::Result<Vec<String>, String> {
    // rust: let Some((report, constants, sprite_tags, sprite_materials, lights)) = pack else {
    // rust: self.native = None;
    // rust: return Ok(Vec::new());
}
    // rust: let terrain = native_material::TerrainShape {
    // rust: globals: &self.terrain_layout,
    // rust: flat: self.flat.as_ref().map(|f| &f.draw_layout),
    // rust: sprites: self.terrain_sprites,
    // rust: format: self.frame_format,
    // rust: sprite_tags: &sprite_tags,
    // rust: sprite_materials: &sprite_materials,
    // rust: entities: &self.entity_bindings,
    // rust: weather_groups: [&self.weather.entity_layout, &self.weather.time_layout],
    // rust: pbr: self.pbr_maps.as_ref().and_then(|arrays| arrays.first()),
}
    // rust: let (pack, labels) = native_pack::NativePack::new(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: &terrain,
    // rust: report,
    // rust: &constants,
    // rust: lights,
    // rust: )?;
    // rust: self.native = pack.draws().then_some(pack);
    // rust: if self.native.is_some() {
    // rust: self.pack_post = None;
    // rust: self.pack_atlas = None;
    // rust: self.pack_material_atlases = None;
}
    // rust: Ok(labels)
}
    /// What a shader pack's gbuffers programs read from Horizon's geometry: the sky's, and
    /// terrain's in the pack's block atlas (made here when missing; none when it does not fit).
pub fn pack_inputs(self: *Self) h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let terrain = self.pack_terrain_inputs();
        // A geometry stage reads flat draws' vertices itself, through their index buffer.
    // rust: let terrain_geometry = terrain
    // rust: .clone()
    // rust: .filter(|_| self.pack_terrain_flat)
    // rust: .map(|mut inputs| {
    // rust: inputs.declarations.push_str(
    // rust: "layout(set = 5, binding = 0) readonly buffer HzIndices { uint hz_indices[]; };\n",
    // rust: );
    // rust: horizon_shaders::GeometryInputs {
    // rust: inputs,
    // rust: pull: pack_atlas::PULL.to_owned(),
    // rust: index: "hz_indices[@]".to_owned(),
}
    // rust: });
    // rust: horizon_shaders::GameInputs {
    // rust: terrain_parts: terrain
    // rust: .as_ref()
    // rust: .map(|t| pack_atlas::terrain_parts(t, &self.pack_lava_layers)),
    // rust: terrain,
    // rust: terrain_geometry,
    // rust: entity_geometry: Some(pack_entities::geometry_inputs()),
    // rust: sky: Some(pack_sky::inputs()),
    // rust: celestial: Some(pack_sky::celestial_inputs()),
    // rust: entities: Some(pack_entities::inputs()),
    // rust: clouds: Some(pack_entities::cloud_inputs()),
    // rust: weather: Some(pack_weather::inputs()),
    // rust: lines: Some(pack_lines::inputs()),
    // rust: hand: Some(pack_hand::inputs()),
}
}

pub fn pack_terrain_inputs(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
        // Flat draws whenever the device has them (`render` keeps them on with a pack).
    // rust: let flat = self.flat.is_some() && self.flat_on;
        // Flat draws read each sprite's place from a table: the atlas is stitched as the game's.
        // Other draws need the grid.
    // rust: if !flat && self.pack_atlas.as_ref().is_some_and(|a| a.is_stitched()) {
    // rust: self.pack_atlas = None;
}
    // rust: if self.pack_atlas.is_none() {
    // rust: let mut encoder = self.device.create_command_encoder(&Default::default());
    // rust: let layers = self
    // rust: .sprite_textures
    // rust: .iter()
    // rust: .map(|t| t.depth_or_array_layers())
    // rust: .sum();
    // rust: let sprite = self.sprite_textures[0].width();
            // Vanilla's padding counts the anisotropy bit only with anisotropic filtering.
    // rust: let anisotropy_bit = if self.texture_filtering == 2 {
    // rust: u32::from(self.max_anisotropy).trailing_zeros()
    // rust: } else {
    // rust: 0
}
    // rust: let stitched = flat
    // rust: .then(|| {
    // rust: pack_atlas::PackAtlas::stitched(
    // rust: &self.device,
    // rust: &mut encoder,
    // rust: &self.sprite_textures,
    // rust: self.sprite_split,
    // rust: sprite,
    // rust: &self.sprite_native,
    // rust: self.mipmap_option,
    // rust: anisotropy_bit,
    // rust: )
    // rust: })
    // rust: .flatten();
    // rust: if flat && stitched.is_none() {
    // rust: log::warn!(
    // rust: "shader pack block atlas: the sprites don't stitch on this device, a grid instead"
    // rust: );
}
    // rust: let mut atlas = stitched.or_else(|| {
    // rust: pack_atlas::PackAtlas::new(
    // rust: &self.device,
    // rust: &mut encoder,
    // rust: &self.sprite_textures,
    // rust: self.sprite_split,
    // rust: layers,
    // rust: sprite,
    // rust: )
    // rust: });
    // rust: if let Some(atlas) = &mut atlas {
    // rust: atlas.separate_ao = self.separate_ao;
}
    // rust: self.pack_material_atlases = atlas.as_ref().and_then(|_| {
    // rust: let maps = self.pbr_maps.as_ref()?;
    // rust: let make = |kind: usize, encoder: &mut wgpu::CommandEncoder| {
    // rust: let arrays: Vec<_> = maps.iter().map(|pair| pair[kind].clone()).collect();
    // rust: pack_atlas::PackAtlas::material(
    // rust: &self.device,
    // rust: encoder,
    // rust: &arrays,
    // rust: self.sprite_split,
    // rust: layers,
    // rust: )
}
    // rust: Some([make(0, &mut encoder)?, make(1, &mut encoder)?])
    // rust: });
    // rust: self.pack_atlas = atlas;
    // rust: self.queue.submit([encoder.finish()]);
}
    // rust: self.pack_terrain_flat = flat;
    // rust: Some(
    // rust: self.pack_atlas
    // rust: .as_ref()?
    // rust: .terrain_inputs(self.pack_terrain_flat),
    // rust: )
}
    /// Times the shader pack's passes on the GPU while `on` (the F3 overlay is open), or always
    /// with `HORIZON_SHADER_PACK_TIMING`.
pub fn set_pass_timing(self: *Self, on: bool) void {
}
    // rust: self.pass_timing = on || pack_timing::PassTiming::logging();
}
    /// The running shader pack's timer, of either kind.
    // rust: fn pass_timer<'a>(
    // rust: pack: &'a mut Option<(i32, Option<pack_post::PackPost>)>,
    // rust: native: &'a mut Option<native_pack::NativePack>,
    // rust: ) -> Option<&'a mut Option<pack_timing::PassTiming>> {
    // rust: match (pack, native) {
    // rust: (Some((_, Some(post))), _) => Some(&mut post.timing),
    // rust: (_, Some(native)) => Some(&mut native.timing),
    // rust: _ => None,
}
}
    /// Each pass of the running shader pack with its median GPU time in milliseconds, while
    /// they are timed (`set_pass_timing`).
pub fn shader_pass_times(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let timer = match (&self.pack_post, &self.native) {
    // rust: (Some((_, Some(post))), _) => post.timing.as_ref(),
    // rust: (_, Some(native)) => native.timing.as_ref(),
    // rust: _ => None,
}
    // rust: timer
    // rust: .map(pack_timing::PassTiming::medians)
    // rust: .unwrap_or_default()
}
    /// Each of Horizon's own passes with its median GPU time in milliseconds, while they are
    /// timed (`set_pass_timing`).
pub fn own_pass_times(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.own_timing
    // rust: .as_ref()
    // rust: .map(pack_timing::PassTiming::medians)
    // rust: .unwrap_or_default()
}
    /// The macros this renderer gives shader packs: the GL extensions this device has
    /// (subgroups, when it has them), and the vendor, renderer and mipmap levels
    /// (`Macros::define_renderer`).
pub fn define_pack_macros(self: *Self, macros: *mut horizon_shaders::Macros) void {
}
    // rust: macros.define_renderer(self.mipmaps);
    // rust: if self.device.features().contains(wgpu::Features::SUBGROUP) {
    // rust: for ext in [
    // rust: "basic",
    // rust: "vote",
    // rust: "arithmetic",
    // rust: "ballot",
    // rust: "shuffle",
    // rust: "shuffle_relative",
    // rust: ] {
    // rust: macros.define(format!("MC_GL_KHR_shader_subgroup_{ext}"), "");
}
}
}

    /// The dimension the shader pack was last set for.
pub fn shader_pack_dimension(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pack_post.as_ref().map(|p| p.0)
}
    /// The Texture Filtering and Max Anisotropy options (`filtering`: 0 none, 1 RGSS, 2
    /// anisotropic; `bit`: `maxAnisotropyBit`). All take LevelRenderer's chunk layer sampler
    /// (linear, clamped, `bit` anisotropy when anisotropic) and terrain.wgsl's sampleNearest,
    /// or sampleRGSS for RGSS.
pub fn set_texture_filtering(self: *Self, filtering: i32, bit: i32) void {
}
    // rust: let filtering = filtering.clamp(0, 2) as u32;
    // rust: let anisotropy = if filtering == 2 {
    // rust: sampler_anisotropy(bit)
    // rust: } else {
    // rust: 1
}
    // rust: if filtering == self.texture_filtering && anisotropy == self.max_anisotropy {
    // rust: return;
}
    // rust: self.texture_filtering = filtering;
    // rust: self.max_anisotropy = anisotropy;
    // rust: self.sprite_sampler = self
    // rust: .device
    // rust: .create_sampler(&sprite_sampler_descriptor(anisotropy));
    // rust: self.rebuild_terrain_group();
}
pub fn rebuild_terrain_group(self: *Self) void {
}
    // rust: self.sprite_views = sprite_views(
    // rust: &self.sprite_textures,
    // rust: &self.sprite_unused,
    // rust: Some(self.mipmaps + 1),
    // rust: );
    // rust: self.group = terrain_group(
    // rust: &self.device,
    // rust: "Horizon terrain resources",
    // rust: &self.terrain_layout,
    // rust: &self.globals,
    // rust: &self.sprite_views,
    // rust: &self.sprite_sampler,
    // rust: &self.lightmap_view,
    // rust: &self.lightmap_sampler,
    // rust: &self.emission_stats.view,
    // rust: );
}
    /// Block sprite layers per array on this device: a sprite's array is its layer over it, its
    /// layer in that array the rest (`block_sprites::Lookup`).
pub fn sprite_split(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sprite_split
}
    /// The Mipmap Levels option: block textures sample at most `levels`
    /// reduced copies (0: none).
pub fn set_mipmap_levels(self: *Self, levels: u32) void {
}
    // rust: self.mipmap_option = levels;
    // rust: let levels = crate::sprites::sprite_mipmap_limit(
    // rust: levels,
    // rust: self.sprite_textures[0].width(),
    // rust: self.sprite_minimum_size,
    // rust: self.mip_levels,
    // rust: );
    // rust: if levels == self.mipmaps {
    // rust: return;
}
    // rust: self.mipmaps = levels;
    // rust: self.rebuild_terrain_group();
}
    /// The views `render` draws `frame` from.
pub fn views(self: *Self, frame: *Frame) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ViewSet::single(self.screen_view(
    // rust: frame.fov_degrees,
    // rust: frame.yaw,
    // rust: frame.pitch,
    // rust: frame.depth_far,
    // rust: ))
}
    /// The view frustum `render` will cull with, for culling geometry built
    /// before the frame (entities, block entities) the same way.
    // rust: pub fn camera_frustum(
    // rust: &self,
    // rust: fov_degrees: f32,
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: bob: Mat4,
    // rust: depth_far: f32,
    // rust: ) -> Frustum {
    // rust: let views = ViewSet::single(self.screen_view(fov_degrees, yaw, pitch, depth_far));
    // rust: Frustum {
    // rust: planes: frustum(views.cull().view_proj(bob)),
}
}
pub fn screen_view(self: *Self, fov_degrees: f32, yaw: f32, pitch: f32, far: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let aspect = self.config.width as f32 / self.config.height.max(1) as f32;
    // rust: View::screen(yaw, pitch, fov_degrees, aspect, far)
}
    // rust: fn update_lightmap(
    // rust: &mut self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: sky: &Sky,
    // rust: darkness: f32,
    // rust: gamma: f32,
    // rust: night_vision: f32,
    // rust: flicker: f32,
    // rust: boss_darken: f32,
    // rust: ) {
        // lightmap.fsh: per (block, sky) level.
    // rust: let brightness = |level: f32| level / (4.0 - 3.0 * level);
    // rust: let mut pixels = [0u8; 16 * 16 * 4];
    // rust: for s in 0..16 {
    // rust: for b in 0..16 {
    // rust: let block_level = b as f32 / 15.0;
    // rust: let sky_level = s as f32 / 15.0;
    // rust: let block_brightness = brightness(block_level) * (1.4 + flicker);
    // rust: let sky_brightness = brightness(sky_level) * sky.sky_light_factor;
                // NightVisionColor defaults to 0x999999.
    // rust: let mut color =
    // rust: Vec3::from(sky.ambient_light_color).max(Vec3::splat(0.6 * night_vision));
    // rust: color += Vec3::from(sky.sky_light_color) * sky_brightness;
    // rust: let parabolic = (2.0 * block_level - 1.0).powi(2);
    // rust: let block_color = Vec3::from(sky.block_light_tint).lerp(Vec3::ONE, 0.9 * parabolic);
    // rust: color += block_color * block_brightness;
                // lightmap.fsh: a boss bar mixes the light toward 70/60/60%.
    // rust: color = color.lerp(color * Vec3::new(0.7, 0.6, 0.6), boss_darken);
    // rust: color -= Vec3::splat(darkness);
    // rust: color = color.clamp(Vec3::ZERO, Vec3::ONE);
    // rust: let max = color.max_element().max(1e-6);
    // rust: let inverted = 1.0 - max;
    // rust: let scaled = 1.0 - inverted.powi(4);
    // rust: let not_gamma = color * (scaled / max);
    // rust: color = color.lerp(not_gamma, gamma);
    // rust: let i = (s * 16 + b) * 4;
    // rust: pixels[i] = (color.x * 255.0) as u8;
    // rust: pixels[i + 1] = (color.y * 255.0) as u8;
    // rust: pixels[i + 2] = (color.z * 255.0) as u8;
    // rust: pixels[i + 3] = 255;
}
}
    // rust: if self.fullbright {
    // rust: pixels.fill(255);
}
        // The lightmap changes with the time of day, flicker and effects,
        // not every frame: upload only what differs from the texture.
    // rust: if pixels == self.lightmap_pixels && self.lightmap_uploaded {
    // rust: return;
}
    // rust: self.uploads.texture(
    // rust: encoder,
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture: &self.lightmap,
    // rust: mip_level: 0,
    // rust: origin: wgpu::Origin3d::ZERO,
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: 16,
    // rust: 16,
    // rust: &pixels,
    // rust: );
    // rust: self.lightmap_pixels = pixels;
    // rust: self.lightmap_uploaded = true;
}
pub fn animate(self: *Self, encoder: *mut wgpu::CommandEncoder, tick: u64, cull_inactive: bool) void {
}
    // rust: let active = cull_inactive.then_some(&self.active_animated_layers[..]);
    // rust: self.animations.animate(
    // rust: encoder,
    // rust: &mut self.uploads,
    // rust: tick,
    // rust: active,
    // rust: self.own_timing.as_mut(),
    // rust: );
    // rust: if let Some(arrays) = &self.pbr_maps {
    // rust: for animation in &self.material_animations {
    // rust: if !self.animations.changed().contains(&animation.layer) {
    // rust: continue;
}
    // rust: let Some(pair) = arrays.get((animation.layer / self.sprite_split) as usize) else {
    // rust: continue;
}
    // rust: for kind in 0..2 {
    // rust: let Some(pixels) = animation.material_pixels(kind, tick) else {
    // rust: continue;
}
    // rust: let texture = &pair[kind];
    // rust: let from = (pixels.len() / 4).isqrt() as u32;
    // rust: for level in 0..texture.mip_level_count() {
    // rust: let size = texture.width() >> level;
    // rust: let pixels = crate::sprites::resample(pixels, from, size);
    // rust: self.uploads.texture(
    // rust: encoder,
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture,
    // rust: mip_level: level,
    // rust: origin: wgpu::Origin3d {
    // rust: x: 0,
    // rust: y: 0,
    // rust: z: animation.layer % self.sprite_split,
    // rust: },
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: size,
    // rust: size,
    // rust: &pixels,
    // rust: );
}
}
}
    // rust: if let Some(atlases) = &self.pack_material_atlases {
    // rust: for kind in 0..2 {
    // rust: let arrays: Vec<_> = arrays.iter().map(|pair| pair[kind].clone()).collect();
    // rust: atlases[kind].copy(
    // rust: &self.device,
    // rust: encoder,
    // rust: &arrays,
    // rust: self.animations.changed().iter().copied(),
    // rust: );
}
}
}
    // rust: if let Some(atlas) = &self.pack_atlas {
    // rust: atlas.copy(
    // rust: &self.device,
    // rust: encoder,
    // rust: &self.sprite_textures,
    // rust: self.animations.changed().iter().copied(),
    // rust: );
}
}
pub fn render(self: *Self, frame: *Frame) R {
    // Implementation ported from Horizon
    return undefined;
}
        // A lost device cannot accept uploads either. Leave recovery to the
        // owner instead of submitting atlas patches to the invalid device.
    // rust: if self.device_lost() {
    // rust: return Err("the graphics device was lost".into());
}
    // rust: if let Some(request) = self.capture.take() {
    // rust: let result = self.write_capture(&request, frame);
    // rust: self.capture_result = Some(result.map_err(|e| e.to_string()));
}
    // rust: let scaled = self.screenshot_size();
    // rust: let rendered = match scaled {
    // rust: Some(size) => self.draw_scaled_frame(frame, size),
    // rust: None => self.draw_frame(frame, None),
}
        // A frame that was not drawn still submits the section copies and
        // atlas patches (glyphs, skins, maps), which the caller already took.
    // rust: if self.device_lost() {
    // rust: return Err("the graphics device was lost".into());
}
    // rust: if !matches!(rendered, Ok(true)) && !frame.hud.patches.is_empty() {
    // rust: let section_copies = self.section_copies.take();
    // rust: let has_section_copies = section_copies.is_some();
    // rust: let mut encoder = section_copies.unwrap_or_else(|| {
    // rust: self.device
    // rust: .create_command_encoder(&wgpu::CommandEncoderDescriptor {
    // rust: label: Some("Horizon atlas patches"),
    // rust: })
    // rust: });
    // rust: self.hud
    // rust: .upload_patches(&mut self.uploads, &mut encoder, &frame.hud.patches);
    // rust: self.uploads.finish(&encoder);
    // rust: if has_section_copies {
    // rust: self.section_copy_bytes = 0;
    // rust: self.section_uploads.finish(&encoder);
}
    // rust: self.queue.submit([encoder.finish()]);
    // rust: } else if let Some(copies) = self.take_section_copies() {
    // rust: self.queue.submit([copies]);
}
        // A scaled screenshot's frame never reached the window.
    // rust: rendered.map(|drawn| drawn && scaled.is_none())
}
    /// Whether the device's loss callback has fired. A surface reconfigure
    /// alone cannot restore resources belonging to a lost device.
pub fn device_lost(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.device_lost.load(std::sync::atomic::Ordering::Relaxed)
}
    /// The frame size of the pending `scaled` screenshot when it is larger than the
    /// window: the window's times the Resolution Scale (when above 100%) and
    /// `screenshot_quality`, cut down to what one texture and one readback buffer hold,
    /// and halved for each time it ran out of video memory.
pub fn screenshot_size(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let request = self.screenshot.as_ref()?;
    // rust: if !request.scaled || request.size.is_some() || self.suspended {
    // rust: return None;
}
    // rust: let window = [self.config.width, self.config.height];
    // rust: let limits = self.device.limits();
    // rust: let factor = scaled_screenshot_factor(
    // rust: window,
    // rust: self.world_post.scale,
    // rust: self.screenshot_quality,
    // rust: limits.max_texture_dimension_2d,
    // rust: limits.max_buffer_size,
    // rust: ) / 2f32.powi(self.screenshot_halvings as i32);
    // rust: (factor > 1.0).then(|| window.map(|side| (side as f32 * factor) as u32))
}
    /// Draws one frame at `size` into a texture of its own, for the pending screenshot:
    /// every pass sizes itself by `config`, which says `size` for this frame, the HUD
    /// keeps its layout at a larger scale, and the world is drawn at `size` (a Resolution
    /// Scale below 100% stays as low). The window keeps its last frame.
pub fn draw_scaled_frame(self: *Self, frame: *Frame, size: [u32; 2]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let window = [self.config.width, self.config.height];
    // rust: let mut config = self.config.clone();
    // rust: [config.width, config.height] = size;
    // rust: config.usage |= wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC;
    // rust: if self.frame_format != config.format.remove_srgb_suffix() {
            // A 16-bit frame, read back through an 8-bit copy (`take_readback`).
    // rust: config.format = self.frame_format;
    // rust: config.view_formats = vec![self.frame_format];
    // rust: config.usage |= wgpu::TextureUsages::TEXTURE_BINDING;
}
        // Out of video memory (an invalid texture's view is a validation error):
        // tried again at half the size next frame; the window keeps its last one.
    // rust: let checks = GpuChecks::push(&self.device);
    // rust: let target = Self::offscreen_target(&self.device, &config);
    // rust: let depth = Self::depth(&self.device, &config);
    // rust: if let Some(e) = checks.pop() {
    // rust: log::warn!(
    // rust: "Horizon renderer: no memory for a {}x{} screenshot ({e}); trying half the size",
    // rust: size[0],
    // rust: size[1]
    // rust: );
    // rust: self.screenshot_halvings += 1;
    // rust: return Ok(false);
}
    // rust: let scale = self.world_post.scale;
    // rust: self.world_post.scale = scale / scale.max(1.0);
    // rust: self.hud.zoom = size[0] as f32 / window[0] as f32;
    // rust: [self.config.width, self.config.height] = size;
    // rust: let surface = self.surface.take();
        // HDR presents to the swapchain; this frame goes to a file.
    // rust: let hdr = self.hdr.take();
    // rust: let offscreen = self.offscreen.replace(target);
    // rust: let window_depth = std::mem::replace(&mut self.depth, depth);
        // The frame's own targets at `size` can run out of memory too.
    // rust: let drawn = self.draw_frame(frame, Some(GpuChecks::push(&self.device)));
    // rust: self.depth = window_depth;
    // rust: self.offscreen = offscreen;
    // rust: self.hdr = hdr;
    // rust: self.surface = surface;
    // rust: [self.config.width, self.config.height] = window;
    // rust: self.hud.zoom = 1.0;
    // rust: self.world_post.scale = scale;
    // rust: drawn
}
    /// `checks`: the error scopes of a scaled screenshot's frame, checked before its PNG is written.
pub fn draw_frame(self: *Self, frame: *Frame, checks: ?GpuChecks) R {
    // Implementation ported from Horizon
    return undefined;
}
        // Its steps as spans (HORIZON_SPIKES): each lap names the step that just ended.
    // rust: let mut laps = crate::spans::laps();
    // rust: let landing = Instant::now();
    // rust: self.land_frame();
        // Waiting for the previous frame (offscreen: at most two on the GPU), not work.
    // rust: let landed = landing.elapsed();
    // rust: self.queue.take_waited();
        // World frames alone follow the shader pack: the game loads the picked one
        // before it draws one. Title frames draw no terrain and keep the layout
        // through a pack dropped (Shader Options) or not loaded yet (`Renderer::new`),
        // so the next world's sections, which the level loading screen uploads, stay.
    // rust: if !frame.title {
    // rust: self.follow_translucent_layout();
    // rust: self.follow_packed_layout();
}
    // rust: let released = self.arena.trim();
    // rust: self.graveyard.add(released);
    // rust: let left = self.compact_arena();
    // rust: if let Some(arena) = &mut self.translucent_arena {
    // rust: self.graveyard.add(arena.trim());
}
    // rust: self.graveyard.add(self.sorted_indices.trim());
    // rust: arena::free_later(self.graveyard.advance());
    // rust: self.shrink_translucent(left);
    // rust: if let Some(flat) = &mut self.flat {
    // rust: let translucent = self.translucent_arena.as_ref();
    // rust: flat.trim(|key| match key.checked_sub(flat::TRANSLUCENT_KEYS) {
    // rust: Some(page) => translucent.is_some_and(|a| a.has_page(page)),
    // rust: None => self.arena.has_page(key),
    // rust: });
}
    // rust: if self.suspended {
    // rust: return Ok(false);
}
    // rust: let started = Instant::now();
    // rust: if self.first_frame == FirstFrame::Acquire {
            // Once: a minimized window acquires nothing for a while.
    // rust: startup_step(format_args!("acquiring the first frame"));
    // rust: self.first_frame = FirstFrame::Submit;
}
    // rust: if self.surface_unconfigured
    // rust: && let Some(surface) = &self.surface
    // rust: {
            // Acquiring from it would panic: configure it again, or skip the
            // frame. A lost device never configures it.
    // rust: if self.device_lost.load(std::sync::atomic::Ordering::Relaxed) {
    // rust: return Err("the graphics device was lost".into());
}
    // rust: self.frame_gen.stop();
    // rust: if Self::configure(
    // rust: &self.device,
    // rust: surface,
    // rust: &self.surface_config(),
    // rust: self.hdr.as_ref(),
    // rust: &self.device_lost,
    // rust: )
    // rust: .is_err()
    // rust: {
    // rust: return Ok(false);
}
    // rust: self.surface_unconfigured = false;
}
    // rust: laps.lap("r_prepare");
        // Frame generation: its present thread acquires and presents, this frame draws
        // into frames of its own. Not over menus that blur the frame, a shader pack's
        // own post passes, HDR (or the 16-bit frame it was started with) or the title screen.
    // rust: let fg = self.frame_gen.on
    // rust: && !self.frame_gen.paused
    // rust: && self.hdr.is_none()
    // rust: && self.frame_format == self.config.format.remove_srgb_suffix()
    // rust: && !frame.title
    // rust: && frame.menu_blur.is_none()
    // rust: && self.pack_post.as_ref().is_none_or(|p| p.1.is_none())
    // rust: && self.native.as_ref().is_none_or(|n| n.post.is_none())
    // rust: && (self.surface.is_none()
    // rust: || self.config.usage.contains(wgpu::TextureUsages::COPY_DST));
    // rust: if !fg {
    // rust: self.frame_gen.stop();
}
        // Waits for the submit thread since the last frame's present (this frame's uploads).
    // rust: let queued = self.queue.take_waited();
    // rust: let acquire = Instant::now();
    // rust: let fg_frames = fg
    // rust: .then(|| {
    // rust: self.frame_gen.frames(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: self.surface.as_ref(),
    // rust: self.offscreen.as_ref(),
    // rust: &self.window,
    // rust: &self.config,
    // rust: )
    // rust: })
    // rust: .flatten();
        // The present thread failed: this frame acquires as without frame generation.
    // rust: let fg = fg_frames.is_some();
    // rust: let mut fg_made = false;
    // rust: let acquired = if fg {
    // rust: None
    // rust: } else {
    // rust: self.surface.as_ref().map(|s| s.get_current_texture())
}
    // rust: self.last_wait = landed + queued + acquire.elapsed();
        // Inside the acquire's time already.
    // rust: self.queue.take_waited();
    // rust: let (surface_frame, reconfigure) = match acquired {
    // rust: None => (None, false),
    // rust: Some(wgpu::CurrentSurfaceTexture::Success(f)) => (Some(f), false),
    // rust: Some(wgpu::CurrentSurfaceTexture::Suboptimal(f)) => (Some(f), true),
    // rust: Some(wgpu::CurrentSurfaceTexture::Timeout | wgpu::CurrentSurfaceTexture::Occluded) => {
    // rust: return Ok(false);
}
    // rust: Some(wgpu::CurrentSurfaceTexture::Outdated) => {
    // rust: self.configure_surface();
    // rust: return Ok(false);
}
    // rust: Some(wgpu::CurrentSurfaceTexture::Lost) => {
    // rust: self.recreate_surface()?;
    // rust: return Ok(false);
}
    // rust: Some(wgpu::CurrentSurfaceTexture::Validation) => {
                // Acquire caught a validation error: the swapchain cannot be
                // used as configured (wgpu reports a configuration raced with
                // a submission this way). Give it a fresh configuration like
                // an Outdated one, and once that has not helped, reattach the
                // window like a Lost one — a fullscreen loading screen then
                // skips frames instead of failing every one of them.
    // rust: if self.acquire_validation_failures == 0 {
    // rust: self.configure_surface();
    // rust: } else {
    // rust: self.recreate_surface()?;
}
    // rust: self.acquire_validation_failures =
    // rust: self.acquire_validation_failures.saturating_add(1);
    // rust: return Ok(false);
}
}
    // rust: if surface_frame.is_some() {
    // rust: self.acquire_validation_failures = 0;
    // rust: self.frame_gen.paused = false;
}
    // rust: let size = [self.config.width, self.config.height];
    // rust: let target_texture = match (&surface_frame, &mut self.hdr) {
    // rust: _ if let Some((real, _)) = &fg_frames => real.clone(),
    // rust: (_, Some(hdr)) => hdr.frame(&self.device, size),
            // A screenshot of a swapchain without COPY_SRC (OpenGL), and a 16-bit frame
            // with HDR off, draw into a texture of their own, then onto the swapchain or
            // the offscreen target.
    // rust: (f, None) => {
    // rust: let image = match f {
    // rust: Some(f) => f.texture.clone(),
    // rust: None => self.offscreen.clone().ok_or("no offscreen target")?,
}
    // rust: self.readback
    // rust: .target(
    // rust: &self.device,
    // rust: &image,
    // rust: self.frame_format,
    // rust: self.screenshot.is_some(),
    // rust: )
    // rust: .unwrap_or(image)
}
}
        // One command buffer for the frame, after the section copies staged
        // since the last one: Metal commits every command buffer wgpu-core
        // makes (one per run of copies and two per pass) on its own.
    // rust: let section_copies = self.section_copies.take();
    // rust: let has_section_copies = section_copies.is_some();
    // rust: let mut encoder = section_copies.unwrap_or_else(|| {
    // rust: self.device
    // rust: .create_command_encoder(&wgpu::CommandEncoderDescriptor {
    // rust: label: Some("Horizon frame"),
    // rust: })
    // rust: });
        // Horizon's own passes are timed like a shader pack's, from the frame's first pass.
    // rust: if self.own_timing.is_some() != self.pass_timing {
    // rust: self.own_timing = self
    // rust: .pass_timing
    // rust: .then(|| pack_timing::PassTiming::new(&self.device, &self.queue))
    // rust: .flatten();
}
    // rust: if let Some(t) = &mut self.own_timing {
    // rust: t.begin(&self.device, &self.queue);
}
    // rust: if self.animated_textures {
    // rust: self.hud
    // rust: .animate_sprites(&mut self.uploads, &mut encoder, frame.ticks);
}
    // rust: self.update_lightmap(
    // rust: &mut encoder,
    // rust: &frame.sky,
    // rust: frame.darkness.1,
    // rust: (self.gamma - frame.darkness.0).max(0.0),
    // rust: frame.night_vision,
    // rust: frame.block_flicker,
    // rust: frame.boss_darken,
    // rust: );
    // rust: let views = self.views(frame);
    // rust: let pose = frame.bob * frame.spin;
    // rust: let view_proj = views.primary().view_proj(pose);
    // rust: laps.lap("r_acquire");
        // TAA runs where the world post pass does, not under a shader pack's own.
    // rust: let taa = !frame.title
    // rust: && self.pack_post.as_ref().is_none_or(|p| p.1.is_none())
    // rust: && self.native.as_ref().is_none_or(|n| n.post.is_none());
    // rust: let jitter = self.world_post.jitter(
    // rust: [self.config.width, self.config.height],
    // rust: taa,
    // rust: view_proj,
    // rust: frame.camera,
    // rust: );
    // rust: let jittered = jitter * view_proj;
    // rust: if frame.title {
    // rust: self.panorama.prepare(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: self.config.width,
    // rust: self.config.height,
    // rust: frame.yaw,
    // rust: frame.pitch,
    // rust: );
    // rust: } else {
    // rust: self.panorama.release();
}
    // rust: let view = views.primary().view;
        // The hand's bob and view (`hand_globals`).
    // rust: let hand_view = frame.bob * view;
    // rust: let sun_angle = frame.sky.sun_angle.to_radians();
        // Celestial bodies rotate around the X axis; angle 0 = noon.
    // rust: let sun = Vec3::new(0.0, sun_angle.cos(), -sun_angle.sin());
    // rust: let (fog_color, fog) = if let Some(f) = frame.fog {
    // rust: (
    // rust: f.color,
    // rust: [
    // rust: f.environmental_start,
    // rust: f.environmental_end,
    // rust: f.render_distance_start,
    // rust: f.render_distance_end,
    // rust: ],
    // rust: )
    // rust: } else if frame.underwater {
    // rust: (
    // rust: [
    // rust: frame.water_fog[0],
    // rust: frame.water_fog[1],
    // rust: frame.water_fog[2],
    // rust: 1.0,
    // rust: ],
    // rust: [-8.0, 96.0, -8.0, 96.0],
    // rust: )
    // rust: } else {
    // rust: let d = frame.distance;
    // rust: (
    // rust: [
    // rust: frame.sky.fog_color[0],
    // rust: frame.sky.fog_color[1],
    // rust: frame.sky.fog_color[2],
    // rust: 1.0,
    // rust: ],
                // FogRenderer: render-distance fog starts at max(d - 16, 0)... d.
    // rust: {
    // rust: let (start, end) = frame.environment_fog.unwrap_or((f32::MAX, f32::MAX));
    // rust: [start, end, (d - d.min(64.0) * 0.25).max(0.0), d]
    // rust: },
    // rust: )
}
    // rust: let globals = Globals {
    // rust: view_proj: jittered.to_cols_array_2d(),
    // rust: fog_color,
    // rust: fog,
    // rust: sky_color: [
    // rust: frame.sky.sky_color[0],
    // rust: frame.sky.sky_color[1],
    // rust: frame.sky.sky_color[2],
    // rust: 1.0,
    // rust: ],
    // rust: misc: [
    // rust: 1.0 - frame.sky.sky_light_factor,
    // rust: frame.game_time,
    // rust: views.primary().aspect,
    // rust: views.primary().tan_half_fov,
    // rust: ],
    // rust: inverse_view: view.inverse().to_cols_array_2d(),
    // rust: sunrise: frame.sky.sunrise_color,
    // rust: sun: [sun.x, sun.y, sun.z, frame.sky.star_brightness],
    // rust: fog_ends: [
    // rust: frame.fog.map_or(frame.distance.min(512.0), |f| f.sky_end),
    // rust: frame.fog.map_or(2048.0, |f| f.cloud_end),
    // rust: if frame.dark_disc { 1.0 } else { 0.0 },
    // rust: frame.glint_alpha,
    // rust: ],
    // rust: end_portal_sprites: frame.end_portal_sprites,
    // rust: crumbling_sprite: frame.crumbling_sprite,
    // rust: time: [
    // rust: frame.shader_game_time,
    // rust: f32::from(frame.nether_lighting),
    // rust: frame.dynamic_lights.len().min(crate::dynamic_light::MAX) as f32,
    // rust: frame.glint_ticks,
    // rust: ],
    // rust: outline_params: outline_params(self.config.width, self.config.height),
    // rust: dynamic_lights: {
    // rust: let mut lights = [[0.0; 4]; crate::dynamic_light::MAX];
    // rust: for (to, from) in lights.iter_mut().zip(frame.dynamic_lights) {
    // rust: *to = *from;
}
    // rust: lights
    // rust: },
    // rust: colored_lights: {
    // rust: let mut lights = [[[0.0; 4]; 2]; crate::dynamic_light::MAX];
    // rust: for (to, from) in lights.iter_mut().zip(frame.colored_lights) {
    // rust: *to = *from;
}
    // rust: lights
    // rust: },
    // rust: colored_count: [
    // rust: frame.colored_lights.len().min(crate::dynamic_light::MAX) as u32,
                // PvP & HUD's hit colour: entity.wgsl's hurt texel, 0 for vanilla's.
    // rust: frame.pvp.hurt_texel,
                // PvP & HUD's glint colour: entity.wgsl's `tinted_glint`, 0 for vanilla's.
    // rust: frame.pvp.glint,
    // rust: 0,
    // rust: ],
    // rust: emissive_layers: {
    // rust: let mut layers = [[0; 4]; crate::native_emissive::MAX];
    // rust: for (to, from) in layers.iter_mut().zip(frame.emissive_layers) {
    // rust: *to = *from;
}
    // rust: layers
    // rust: },
    // rust: emissive_count: [
    // rust: frame.emissive_layers.len().min(crate::native_emissive::MAX) as u32,
    // rust: 0,
    // rust: 0,
    // rust: 0,
    // rust: ],
    // rust: sunrise_fan: sunrise_fan::normals(frame.sky.sunrise_color[3], sun),
    // rust: filtering: [
    // rust: self.texture_filtering as f32,
    // rust: self.sprite_textures[0].width() as f32,
                // The views' last level (`rebuild_terrain_group`), when a sprite is one texel
                // there: RGSS takes one tap from it on (terrain.wgsl's `rotated_grid`).
    // rust: if self.sprite_textures[0].width() >> self.mipmaps == 1 {
    // rust: self.mipmaps as f32
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: 0.0,
    // rust: ],
    // rust: hdr_windows: self.hdr.as_ref().map_or([[0.0; 4]; 2], hdr::Hdr::windows),
    // rust: hdr_light: [
    // rust: frame.sky.sky_light_factor,
                // The underwater overlay: the sky and fog are the water's own colour there.
    // rust: if frame.screen.iter().any(|q| q.world_tint) {
    // rust: 0.0
    // rust: } else {
    // rust: frame.sky.sky_light_factor
    // rust: },
                // Only HDR output reads the solid terrain's lighting alpha.
    // rust: if self.hdr.is_some() { 1.0 } else { 0.0 },
    // rust: 0.0,
    // rust: ],
}
    // rust: self.uploads
    // rust: .buffer(&mut encoder, &self.globals, 0, bytemuck::bytes_of(&globals));
        // The sunrise fan as sixteen triangles. Its clip positions use the sky's
        // own view (no TAA jitter, bob or spin: `fs_sky`'s `view_ray` has none),
        // and its apex weight interpolates the barycentric the shader used to
        // compute for every sky pixel.
    // rust: if frame.sky.sunrise_color[3] > 0.001 && !frame.title && frame.skybox {
    // rust: let sky_view_proj = views.primary().view_proj(Mat4::IDENTITY);
    // rust: let mut mesh = [[0.0f32; 5]; sunrise_fan::VERTICES];
    // rust: for (to, from) in mesh
    // rust: .iter_mut()
    // rust: .zip(sunrise_fan::mesh(frame.sky.sunrise_color[3], sun))
    // rust: {
    // rust: let clip = sky_view_proj * glam::Vec4::new(from[0], from[1], from[2], 1.0);
    // rust: *to = [clip.x, clip.y, clip.z, clip.w, from[3]];
}
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.sunrise_buffer,
    // rust: 0,
    // rust: bytemuck::cast_slice(&mesh),
    // rust: );
}
    // rust: laps.lap("r_targets");
        // GameRenderer.render3dHud: the hand's projection at hudFov, with the
        // bob in its pose rather than the projection (same product).
    // rust: let hand_projection = Mat4::from_cols_array(&crate::camera::hand_projection(
    // rust: frame.hand_fov_degrees,
    // rust: self.config.width as f32,
    // rust: self.config.height.max(1) as f32,
    // rust: frame.depth_far,
    // rust: ));
    // rust: let hand_view_proj = hand_projection * frame.bob * view;
    // rust: let hand_globals = Globals {
    // rust: view_proj: hand_view_proj.to_cols_array_2d(),
    // rust: ..globals
}
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.hand_globals,
    // rust: 0,
    // rust: bytemuck::bytes_of(&hand_globals),
    // rust: );
        // GameRenderer.render3dHud: DebugCrosshairRenderer draws with the
        // hand's projection but no bob, and FogMode.NONE (no fog colour).
    // rust: let crosshair_globals = Globals {
    // rust: view_proj: (hand_projection * view).to_cols_array_2d(),
    // rust: fog_color: [0.0; 4],
    // rust: ..globals
}
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.crosshair_globals,
    // rust: 0,
    // rust: bytemuck::bytes_of(&crosshair_globals),
    // rust: );
        // Frustum culling and camera-relative origins.
    // rust: let cull_proj = views.cull().view_proj(pose);
    // rust: let view = Frustum {
    // rust: planes: frustum(cull_proj),
}
    // rust: let camera = frame.camera;
    // rust: let camera_section = camera_section(camera, self.layout.min_y());
        // The water mirror draws the same lists: they take in what its camera sees too
        // (above the screen's top, the far shore, the trees against the sky).
    // rust: let mirror_plane = frame
    // rust: .water_plane
    // rust: .filter(|_| !frame.title && self.wants_water_plane());
    // rust: let mirror = mirror_plane.map(|plane| Frustum {
    // rust: planes: frustum(mirror_view_projection(
    // rust: cull_proj,
    // rust: plane - frame.camera.y as f32,
    // rust: )),
    // rust: });
        // Solid quads facing away from the eye are left out: the bob moves
        // the eye off `camera`, so it is found from the projection. With the mirror, those
        // facing its eye are kept too: it sits straight below, at this camera-relative y.
    // rust: let eye = projection_center(cull_proj).filter(|_| self.sides_on);
    // rust: let mirror_low = mirror_plane
    // rust: .zip(eye)
    // rust: .map(|(plane, eye)| 2.0 * (plane - frame.camera.y as f32) - eye.y);
    // rust: let culling = !frame.title && frame.cave_culling;
    // rust: if culling {
    // rust: crate::spans::time("occlusion", || {
    // rust: self.start_occlusion(camera, frame.detail_distance)
    // rust: });
}
        // A shader pack's shadow pass draws the sections in its camera's box, all of them (the
        // occlusion graph follows the eye, not the light), within shadowDistanceRenderMul; for
        // an Iris-format pack, only those whose shadow can fall into the camera's view.
    // rust: let shadow_view = self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|p| p.1.as_ref())
    // rust: .filter(|_| !frame.title)
    // rust: .and_then(|p| p.shadow_view(frame))
    // rust: .or_else(|| {
                // One of Horizon's own packs with `[shadow]` uses the same lists.
    // rust: let native = self.native.as_ref().filter(|_| !frame.title)?;
    // rust: native.shadow.as_ref()?;
    // rust: native.frame.shadow_view(frame)
    // rust: });
    // rust: let pack_terrain = !frame.title
    // rust: && self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|p| p.1.as_ref())
    // rust: .is_some_and(|p| p.has_terrain());
        // `LevelRenderer.extractSectionDrawGroups`' fade-in time, for the instances.
    // rust: let fade_ms = fade_millis(frame.chunk_fade);
        // GPU culling's fading sections, decided at `fades.now`: before the gate, the record
        // check and `prepare`, which sends their flags, and no later than the instances' `now`,
        // so a section the pass draws whole is whole there too. Title frames draw no terrain
        // (a loading screen's fade-in time is 0): they leave them as they are.
    // rust: let fades = FadeInputs {
    // rust: now: Instant::now(),
    // rust: fade_ms,
    // rust: uploaded: &self.section_uploaded,
    // rust: retiring: &self.lod_retiring,
}
    // rust: if !frame.title
    // rust: && let Some(gpu) = &mut self.gpu_culling
    // rust: {
    // rust: let (sections, rows) = (&mut self.sections, self.layout.sections());
    // rust: mark_fades(sections, &mut gpu.records, &mut gpu.fades, rows, fades);
}
        // The near solid sections culled and drawn on the GPU (`gpu_culling`): never where a
        // shader pack's terrain, a shadow pass or the water mirror draws the CPU's lists, nor
        // under a native pack's `[displacement]`, whose grid takes its quads from the walk's
        // `visible`. Decided before the walk, so that a pass whose buffers no longer fit can
        // still switch GPU culling off.
    // rust: let radius = (frame.detail_distance / 16.0) as i32;
    // rust: let displaced = self
    // rust: .native
    // rust: .as_ref()
    // rust: .is_some_and(|n| n.displacement.is_some());
    // rust: let mut gpu_frame = self.gpu_culling.is_some()
    // rust: && !frame.title
    // rust: && !pack_terrain
    // rust: && shadow_view.is_none()
    // rust: && mirror_plane.is_none()
    // rust: && !displaced;
    // rust: if gpu_frame {
    // rust: if self.gpu_checks.is_multiple_of(64) {
    // rust: self.check_gpu_records(fades);
}
    // rust: self.gpu_checks = self.gpu_checks.wrapping_add(1);
}
    // rust: self.frame_serial += 1;
    // rust: let serial = self.frame_serial;
        // GPU frames' statistics come back a frame or a few later (`GpuCulling::collect`).
    // rust: if let Some(gpu) = &mut self.gpu_culling
    // rust: && let Some((frame, stats)) = gpu.collect(&self.device)
    // rust: {
    // rust: self.show_stats(frame, stats);
}
        // The walk reads the graph GPU culling is given (checked after it).
    // rust: let graph_given = self.occlusion.generation();
    // rust: if gpu_frame && let Some(gpu) = &mut self.gpu_culling {
    // rust: let input = gpu_culling::FrameInputs {
    // rust: camera,
    // rust: min_y: self.sections.min_y(),
    // rust: sections: self.layout.sections() as i32,
    // rust: radius,
    // rust: frustum: &view,
    // rust: reach: self.occlusion.reach().filter(|_| culling),
    // rust: eye,
    // rust: view_proj: jittered,
    // rust: occlude: self.cull_on,
}
    // rust: let prepared = crate::spans::time("gpu culling", || {
    // rust: gpu.prepare(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: &mut self.uploads,
    // rust: &mut encoder,
    // rust: &input,
    // rust: )
    // rust: });
            // A frame whose planes leave the test's integers (the camera millions of blocks
            // above or below the level), or whose eye is not a number, is the CPU's.
    // rust: gpu_frame = prepared == gpu_culling::Prepared::Gpu;
    // rust: if prepared == gpu_culling::Prepared::OutOfMemory {
    // rust: log::warn!(
    // rust: "Horizon renderer: GPU culling off until the next start: its buffers do not fit in video memory"
    // rust: );
    // rust: self.offer_gpu_culling(crate::graphics::GpuCullingOffer::OutOfMemory);
    // rust: let _ = self.set_gpu_culling(false);
}
}
    // rust: self.gpu_frame = gpu_frame;
    // rust: let reachable = &self.occlusion;
    // rust: let cutout = &self.lod_cutout;
        // Sections fading out (`leave_section`) are past the render distance:
        // drawn there until they have, or they popped out at once.
    // rust: let leaving: crate::fast_hash::FxHashSet<(i32, i32)> = self
    // rust: .lod_leaving
    // rust: .iter()
    // rust: .map(|&((x, _, z), _)| (x, z))
    // rust: .collect();
    // rust: let mut visible = std::mem::take(&mut self.visible);
    // rust: visible.clear();
    // rust: crate::spans::time("visibility", || {
            // GPU culling draws the solid quads of the near whole sections it has records of:
            // within the render distance the walk lists only those with translucent quads,
            // without a record or fading (`SectionGpu::listed`).
    // rust: self.sections.walk(
    // rust: camera,
    // rust: radius,
    // rust: &Frusta(view, mirror),
    // rust: |k| !culling || reachable.contains(k),
    // rust: |x, z| {
    // rust: (!cutout.is_empty() && cutout.contains(&(x, z)))
    // rust: || (!leaving.is_empty() && leaving.contains(&(x, z)))
    // rust: },
    // rust: gpu_frame,
    // rust: &mut visible,
    // rust: )
    // rust: });
    // rust: assert!(
    // rust: !gpu_frame || self.occlusion.generation() == graph_given,
    // rust: "the walk reads the graph GPU culling was given"
    // rust: );
    // rust: let now = std::time::Instant::now();
    // rust: let mut visible_lods = std::mem::take(&mut self.visible_lods);
    // rust: visible_lods.clear();
    // rust: if frame.title {
    // rust: visible.clear();
    // rust: } else {
    // rust: visible_lods.extend(
    // rust: self.lods
    // rust: .iter()
    // rust: .filter_map(|(&key, tile)| tile.visible(key, camera, &view, now)),
    // rust: );
    // rust: visible_lods.sort_unstable_by_key(|v| (v.distance, v.key));
}
    // rust: let mut shadow_visible = std::mem::take(&mut self.shadow_visible);
    // rust: shadow_visible.clear();
    // rust: if let Some(v) = &shadow_view {
    // rust: let radius = (frame.detail_distance / 16.0) as i32;
    // rust: let light = ShadowCull {
    // rust: light: shadow_box(v),
    // rust: casters: v.view_casters.then(|| shadow_casters(cull_proj, v.light)),
    // rust: reach: v.distance,
}
    // rust: crate::spans::time("shadow visibility", || {
                // Within the unculled distance every section, then those in the light's box.
    // rust: if let Some(d) = v.unculled {
    // rust: let all = ShadowCull {
    // rust: light: Frustum {
    // rust: planes: [glam::Vec4::W; 6],
    // rust: },
    // rust: casters: None,
    // rust: reach: v.distance,
}
    // rust: let near = radius.min((d / 16.0).ceil() as i32);
    // rust: self.sections.visible(
    // rust: camera,
    // rust: near,
    // rust: &all,
    // rust: |_| true,
    // rust: |_, _| false,
    // rust: &mut shadow_visible,
    // rust: );
}
    // rust: let mut boxed = Vec::new();
    // rust: self.sections
    // rust: .visible(camera, radius, &light, |_| true, |_, _| false, &mut boxed);
    // rust: let seen: std::collections::HashSet<_> =
    // rust: shadow_visible.iter().map(|s| s.key).collect();
    // rust: shadow_visible.extend(boxed.into_iter().filter(|s| !seen.contains(&s.key)));
    // rust: });
            // Nearest the light first, so the depth test rejects what lies under it.
    // rust: let light = v.light;
    // rust: shadow_visible.sort_unstable_by(|a, b| {
    // rust: let height = |s: &resident::Visible| glam::Vec3::from(s.origin).dot(light);
    // rust: height(b).total_cmp(&height(a))
    // rust: });
}
        // A `shaders/` pack that draws the terrain, or its shadow, sees it as Iris does.
    // rust: let shaders_pack = !frame.title
    // rust: && self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|p| p.1.as_ref())
    // rust: .is_some_and(|p| p.has_terrain() || p.has_shadow());
    // rust: if shaders_pack {
    // rust: let from = pack_terrain_camera(camera);
    // rust: for v in visible.iter_mut().chain(shadow_visible.iter_mut()) {
    // rust: v.origin = resident::origin(v.key, self.sections.min_y(), from)
    // rust: .as_vec3()
    // rust: .to_array();
}
}
    // rust: if self.animated_textures {
    // rust: self.active_animated_layers.fill(0);
    // rust: for v in &visible {
    // rust: let s = self.sections.get(v.slot);
    // rust: for &layer in &*s.animated_layers {
    // rust: let layer = layer as usize;
    // rust: self.active_animated_layers[layer / u64::BITS as usize] |=
    // rust: 1_u64 << (layer % u64::BITS as usize);
}
}
    // rust: for v in &visible_lods {
    // rust: if let Some(tile) = self.lods.get(&v.key) {
    // rust: for &layer in &*tile.drawn().animated_layers {
    // rust: let layer = layer as usize;
    // rust: self.active_animated_layers[layer / u64::BITS as usize] |=
    // rust: 1_u64 << (layer % u64::BITS as usize);
}
    // rust: for &layer in &*tile.mesh.animated_layers {
    // rust: let layer = layer as usize;
    // rust: self.active_animated_layers[layer / u64::BITS as usize] |=
    // rust: 1_u64 << (layer % u64::BITS as usize);
}
}
}
    // rust: for v in &shadow_visible {
    // rust: let s = self.sections.get(v.slot);
    // rust: for &layer in &*s.animated_layers {
    // rust: let layer = layer as usize;
    // rust: self.active_animated_layers[layer / u64::BITS as usize] |=
    // rust: 1_u64 << (layer % u64::BITS as usize);
}
}
            // Visibility is collected before terrain draw commands are recorded,
            // so upload the current mask here and keep animation updates ahead
            // of every draw in this command buffer. A GPU frame's walk leaves out
            // the sections GPU culling draws: every layer animates.
    // rust: self.animate(&mut encoder, frame.ticks, !frame.title && !gpu_frame);
}
    // rust: let listed = visible.len() + visible_lods.len();
    // rust: let instances = listed + shadow_visible.len();
    // rust: if instances as u64 > self.instance_capacity {
    // rust: self.instance_capacity = (instances as u64).next_power_of_two();
    // rust: self.instances = self.device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Section origins"),
    // rust: size: self.instance_capacity * 16,
    // rust: usage: wgpu::BufferUsages::VERTEX
    // rust: | wgpu::BufferUsages::COPY_DST
    // rust: | wgpu::BufferUsages::STORAGE,
    // rust: mapped_at_creation: false,
    // rust: });
}
    // rust: self.origins.clear();
    // rust: let (sections, retiring) = (&self.sections, &self.lod_retiring);
    // rust: laps.lap("r_cameras");
        // `LevelRenderer.extractSectionDrawGroups`: each section's `getVisibility`. Once
        // nothing is fading (the usual frame), every section is whole without a lookup.
    // rust: let fading_in = self.sections_fading_in(fade_ms, now);
    // rust: let fading_over_lods = self.sections_fading_over_lods(now);
    // rust: let fade_code = move |section: &SectionGpu, key: &SectionKey| {
    // rust: if fading_over_lods {
    // rust: section.fade(now, retiring.contains(key))
    // rust: } else {
    // rust: 0
}
}
    // rust: let uploaded = &self.section_uploaded;
    // rust: let visibility = move |key: SectionKey| {
    // rust: if !fading_in {
    // rust: return 1.0;
}
    // rust: section_visibility(uploaded.get(&key), fade_ms, now)
}
    // rust: self.origins.extend(
    // rust: visible
    // rust: .iter()
    // rust: .map(|v| {
    // rust: let code = fade_code(sections.get(v.slot), &v.key);
    // rust: section_instance(v.origin, code, visibility(v.key))
    // rust: })
    // rust: .chain(visible_lods.iter().map(|v| lod::instance(v.origin, v.fade)))
    // rust: .chain(
    // rust: shadow_visible
    // rust: .iter()
    // rust: .map(|v| section_instance(v.origin, 0, visibility(v.key))),
    // rust: ),
    // rust: );
    // rust: if !self.origins.is_empty() {
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.instances,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.origins),
    // rust: );
}
        // `[displacement]`: the solid quads of the sections it reaches, nearest first.
    // rust: if let Some(d) = self.native.as_mut().and_then(|n| n.displacement.as_mut()) {
    // rust: let near: Vec<displace::Near<'_>> = if frame.title {
    // rust: Vec::new()
    // rust: } else {
    // rust: visible
    // rust: .iter()
    // rust: .filter(|v| {
    // rust: let o = glam::Vec3::from(v.origin);
    // rust: let closest = glam::Vec3::ZERO.clamp(o, o + 16.0);
    // rust: closest.length() < d.distance
    // rust: })
    // rust: .filter_map(|v| {
    // rust: let s = self.sections.get(v.slot);
    // rust: (s.solid > 0).then(|| displace::Near {
    // rust: buffer: self.arena.buffer(s.page),
    // rust: start: s.start,
    // rust: quads: s.solid,
    // rust: origin: v.origin,
    // rust: })
    // rust: })
    // rust: .collect()
}
    // rust: d.prepare(&self.queue, &mut encoder, &near, view_proj);
}
        // Solid sections front to back, then translucent ones back to front,
        // as one list of indirect draws over the section arena.
    // rust: self.draws.clear();
    // rust: self.draw_pages.clear();
        // Occlusion culling leaves the sections its last result did not see
        // to phase 2, after the others, with instance counts of 0. Whether
        // the frame has draws enough goes by the last one's.
        // A shader pack drawing terrain draws all of it: occlusion culling reads the depth of
        // Horizon's own terrain draw.
    // rust: let mut cull = self
    // rust: .cull
    // rust: .as_mut()
    // rust: .filter(|c| {
    // rust: self.cull_on
    // rust: && !frame.title
    // rust: && !pack_terrain
    // rust: && self.multi_draw
                    // Occlusion is found from the camera, not the mirror's eye.
    // rust: && mirror.is_none()
                    // It tests the CPU's lists, which leave out GPU culling's sections.
    // rust: && !gpu_frame
    // rust: && visible.len() >= c.min_sections
    // rust: })
    // rust: .and_then(|cull| cull.begin(&self.device).then_some(cull));
    // rust: self.phase2_draws.clear();
    // rust: self.phase2_pages.clear();
    // rust: self.solid_runs.clear();
    // rust: self.phase2_runs.clear();
        // On Metal, phase 1 goes the opaque quads of every list, then the cutout
        // ones (`Part`), each solid pass drawing its own: `[..opaque_draws]`,
        // then the rest; phase 2 likewise. A fading list's quads all draw in the
        // cutout pass.
    // rust: let split_solid = self.info.backend == wgpu::Backend::Metal;
    // rust: let parts = |fading: bool| -> &'static [(u8, Quads)] {
    // rust: match (split_solid, fading) {
    // rust: (false, _) => &[(0, Quads::All)],
    // rust: (true, false) => &[(0, Quads::Opaque), (1, Quads::Cutout)],
    // rust: (true, true) => &[(1, Quads::All)],
}
}
    // rust: let (mut opaque_draws, mut phase2_opaque) = (0, 0);
    // rust: debug_assert!(
    // rust: !(split_solid && gpu_frame),
    // rust: "GPU culling is never offered on Metal"
    // rust: );
        // In a GPU frame the GPU draws the solid quads of the whole sections within the
        // render distance that have records (`SectionGpu::gpu_draws_solid`), and the walk
        // listed those among them with translucent quads. Here stay those fading in or out
        // (`gpu_fading`), those without a record and those past the distance (far terrain's
        // cutout, and columns leaving).
    // rust: let from = resident::camera_column(camera);
        // Listed sections whose solid quads the pass draws: it counts them among the
        // sections it kept.
    // rust: let mut gpu_solid = 0;
    // rust: for (i, v) in visible.iter().enumerate() {
    // rust: let s = self.sections.get(v.slot);
    // rust: if gpu_frame
    // rust: && s.gpu_draws_solid(crate::streaming::in_view_distance(
    // rust: from, radius, v.key.0, v.key.2,
    // rust: ))
    // rust: {
    // rust: gpu_solid += 1;
    // rust: continue;
}
    // rust: let first_phase = cull.as_ref().is_none_or(|c| c.first(v.slot));
    // rust: let (draws, pages) = if first_phase {
    // rust: (&mut self.draws, &mut self.draw_pages)
    // rust: } else {
    // rust: (&mut self.phase2_draws, &mut self.phase2_pages)
}
    // rust: let instances = u32::from(first_phase);
    // rust: let mut indices = 0;
    // rust: let parts = parts(fade_code(s, &v.key) != 0);
            // Each part's (group, first draw, draws).
    // rust: let mut runs = [(0, 0, 0); 2];
    // rust: for (run, &(group, part)) in runs.iter_mut().zip(parts) {
    // rust: let start = draws.len();
    // rust: facing_runs_from(&s.sides, eye, mirror_low, v.origin, part, |first, quads| {
    // rust: indices += quads * 6;
    // rust: let base = s.solid_base() + first * 4;
    // rust: draws.push([quads * 6, instances, 0, base, i as u32]);
    // rust: pages.push((s.page, None));
    // rust: });
    // rust: *run = (group, start, draws.len() - start);
}
    // rust: let runs = &runs[..parts.len()];
    // rust: if first_phase {
    // rust: for &(group, start, len) in runs {
    // rust: if group == 0 {
    // rust: opaque_draws += len;
}
    // rust: self.solid_runs
    // rust: .push_in(group, v.distance, s.page, start, len, [0; 3]);
}
    // rust: if let Some(c) = &mut cull {
    // rust: c.drawn(i, v.slot, indices, cull::SECTION_BOX);
}
    // rust: } else if let Some(c) = &mut cull {
                // One test sees the section's draws in both passes.
    // rust: let total: usize = runs.iter().map(|r| r.2).sum();
    // rust: if let Some(test) = c.deferred(i, v.slot, total, indices, cull::SECTION_BOX) {
    // rust: for &(group, start, len) in runs {
    // rust: if group == 0 {
    // rust: phase2_opaque += len;
}
    // rust: let tag = [test, u32::from(group), 0];
    // rust: self.phase2_runs
    // rust: .push_in(group, v.distance, s.page, start, len, tag);
}
}
}
}
        // Distant terrain tiles are occlusion tested as sections are, with their meshes'
        // bounds, but for those fading or with a stand-in (`lod::Tile::cull_bounds`).
    // rust: for (i, v) in visible_lods.iter().enumerate() {
    // rust: let tile = &self.lods[&v.key];
    // rust: let s = tile.drawn();
    // rust: let index = visible.len() + i;
    // rust: let tested = cull.as_ref().and(tile.cull_bounds(v.fade));
    // rust: let slot = cull::TILE | tile.cull_slot;
    // rust: let first_phase = tested.is_none() || cull.as_ref().is_some_and(|c| c.first(slot));
    // rust: let (draws, pages) = if first_phase {
    // rust: (&mut self.draws, &mut self.draw_pages)
    // rust: } else {
    // rust: (&mut self.phase2_draws, &mut self.phase2_pages)
}
    // rust: let instances = u32::from(first_phase);
    // rust: let mut indices = 0;
    // rust: let parts = parts(v.fade != 0);
    // rust: let mut runs = [(0, 0, 0); 2];
    // rust: for (run, &(group, part)) in runs.iter_mut().zip(parts) {
    // rust: let start = draws.len();
    // rust: facing_runs_from(&s.sides, eye, mirror_low, v.origin, part, |first, quads| {
    // rust: indices += quads * 6;
    // rust: let base = s.solid_base() + first * 4;
    // rust: draws.push([quads * 6, instances, 0, base, index as u32]);
    // rust: pages.push((s.page, None));
    // rust: });
    // rust: *run = (group, start, draws.len() - start);
}
    // rust: let runs = &runs[..parts.len()];
    // rust: let (Some(bounds), Some(c)) = (tested, &mut cull) else {
    // rust: for &(group, start, len) in runs {
    // rust: if group == 0 {
    // rust: opaque_draws += len;
}
    // rust: self.solid_runs
    // rust: .push_in(group, v.distance, s.page, start, len, [0; 3]);
}
    // rust: continue;
}
    // rust: if first_phase {
    // rust: for &(group, start, len) in runs {
    // rust: if group == 0 {
    // rust: opaque_draws += len;
}
    // rust: self.solid_runs
    // rust: .push_in(group, v.distance, s.page, start, len, [0; 3]);
}
    // rust: c.drawn(index, slot, indices, bounds);
    // rust: } else {
    // rust: let total: usize = runs.iter().map(|r| r.2).sum();
    // rust: if let Some(test) = c.deferred(index, slot, total, indices, bounds) {
    // rust: for &(group, start, len) in runs {
    // rust: if group == 0 {
    // rust: phase2_opaque += len;
}
    // rust: let tag = [test, u32::from(group), 0];
    // rust: self.phase2_runs
    // rust: .push_in(group, v.distance, s.page, start, len, tag);
}
}
}
}
        // Phase 2's draws are tested where grouping left them.
    // rust: let runs = self
    // rust: .phase2_runs
    // rust: .regroup(&mut self.phase2_draws, &mut self.phase2_pages, 0);
    // rust: if let Some(c) = &mut cull {
    // rust: for r in runs {
    // rust: c.place(r.tag[0], r.tag[1], r.start, r.len);
}
}
    // rust: self.solid_runs
    // rust: .regroup(&mut self.draws, &mut self.draw_pages, 0);
    // rust: let phase1_draws = self.draws.len() as u32;
        // Draws `[..opaque_end]` hold opaque quads, `[cutout_start..phase1_draws]` cutout ones.
    // rust: let (opaque_end, cutout_start) = if split_solid {
    // rust: (opaque_draws, opaque_draws)
    // rust: } else {
    // rust: (phase1_draws as usize, 0)
}
    // rust: self.draws.extend_from_slice(&self.phase2_draws);
    // rust: self.draw_pages.extend_from_slice(&self.phase2_pages);
    // rust: let culling = cull.is_some();
    // rust: let solid_draws = self.draws.len() as u32;
        // Phase 2's draws `[phase1_draws..phase2_cutout]` hold opaque quads, the rest
        // cutout ones (without the split, all of them go through one pipeline).
    // rust: let phase2_cutout = phase1_draws + phase2_opaque as u32;
    // rust: laps.lap("r_section_groups");
        // LevelRenderer: nearby sections each frame, plus a rotating eighth
        // (at least 15) of the visible list. Cached views avoid needless sorts.
    // rust: self.translucent_draws.clear();
    // rust: let count = visible.len() + visible_lods.len();
    // rust: let budget = (count / 8).max(15).min(count);
    // rust: self.translucency_cursor %= count.max(1);
    // rust: for (i, v) in visible.iter().enumerate().rev() {
    // rust: let s = self.sections.get_mut(v.slot);
    // rust: if let Some((index_page, index_start)) = s.sorted_indices {
    // rust: let nearby = (v.key.0 - camera_section.0).abs() <= 2
    // rust: && (v.key.1 - camera_section.1).abs() <= 2
    // rust: && (v.key.2 - camera_section.2).abs() <= 2;
    // rust: let scheduled = (i + count - self.translucency_cursor) % count < budget;
    // rust: let origin = [
    // rust: v.key.0 * 16,
    // rust: self.layout.min_y() + v.key.1 * 16,
    // rust: v.key.2 * 16,
    // rust: ];
    // rust: if (!s.sort.is_sorted() || nearby || scheduled)
    // rust: && let Some(indices) =
    // rust: s.sort
    // rust: .update(camera.to_array(), origin, &mut self.translucent_sorter)
    // rust: {
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: self.sorted_indices.buffer(index_page),
    // rust: index_start * 4,
    // rust: bytemuck::cast_slice(indices),
    // rust: );
}
    // rust: let (page, first) = s.translucent_at;
    // rust: self.translucent_draws.push((
    // rust: v.distance,
    // rust: i,
    // rust: [
    // rust: s.translucent * 6,
    // rust: 1,
    // rust: index_start as u32,
    // rust: first as u32,
    // rust: i as u32,
    // rust: ],
    // rust: (page, Some(index_page)),
    // rust: ));
}
}
        // Sections went back to front (`visible` is sorted by distance, then
        // key): tiles' water only needs sorting in when there is some.
    // rust: let section_translucent = self.translucent_draws.len();
    // rust: for (i, v) in visible_lods.iter().enumerate() {
    // rust: let instance = visible.len() + i;
    // rust: let tile = self.lods.get_mut(&v.key).expect("visible resident tile");
    // rust: let s = tile.drawn_mut();
    // rust: if let Some((index_page, index_start)) = s.sorted_indices {
    // rust: let scheduled = (instance + count - self.translucency_cursor) % count < budget;
    // rust: if (!s.sort.is_sorted() || scheduled)
    // rust: && let Some(indices) = s.sort.update_lod(
    // rust: camera.to_array(),
    // rust: v.key.origin(),
    // rust: &mut self.translucent_sorter,
    // rust: )
    // rust: {
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: self.sorted_indices.buffer(index_page),
    // rust: index_start * 4,
    // rust: bytemuck::cast_slice(indices),
    // rust: );
}
    // rust: let (page, first) = s.translucent_at;
    // rust: self.translucent_draws.push((
    // rust: v.distance,
    // rust: instance,
    // rust: [
    // rust: s.translucent * 6,
    // rust: 1,
    // rust: index_start as u32,
    // rust: first as u32,
    // rust: instance as u32,
    // rust: ],
    // rust: (page, Some(index_page)),
    // rust: ));
}
}
        // Near water and distant water share one back-to-front draw order.
    // rust: if self.translucent_draws.len() > section_translucent {
            // Distant water goes after the near chunks', and replaced tiles'
            // after all: each is a hair behind the one before, so depth leaves
            // it only where that one has none. Back to front together, a far
            // tile's water under a near chunk's (one fading in, or brought
            // into view by a longer render distance) blended twice and looked
            // opaque. The cost: far water just behind near water shows no
            // surface of its own there.
    // rust: let tier = |instance: usize| match instance.checked_sub(visible.len()) {
    // rust: None => 0,
    // rust: Some(tile) if visible_lods[tile].old => 2,
    // rust: Some(_) => 1,
}
    // rust: self.translucent_draws
    // rust: .sort_unstable_by_key(|&(distance, instance, ..)| {
    // rust: (
    // rust: tier(instance),
    // rust: std::cmp::Reverse(distance),
    // rust: std::cmp::Reverse(instance),
    // rust: )
    // rust: });
}
    // rust: for &(_, _, draw, pages) in &self.translucent_draws {
    // rust: self.draws.push(draw);
    // rust: self.draw_pages.push(pages);
}
    // rust: self.translucency_cursor += budget;
    // rust: let translucent_draws = self.draws.len() as u32 - solid_draws;
    // rust: let section_draws = self.draws.len();
        // The shadow camera's sections after the camera's: quads that can face the light (all of
        // them for `every_face`), then translucent ones (in their last sorted order; depth
        // decides there).
    // rust: let shadow_first = self.draws.len() as u32;
    // rust: let mut shadow_translucent = Vec::new();
    // rust: self.shadow_runs.clear();
    // rust: if let Some(view) = &shadow_view {
    // rust: let base = listed;
            // How far below the nearest section to the light (squared, as bits, as `PageRuns`
            // takes distances): each band's draws go by page, a call per page and band.
    // rust: let height = |v: &resident::Visible| glam::Vec3::from(v.origin).dot(view.light);
    // rust: let top = shadow_visible.first().map_or(0.0, height);
    // rust: for (k, v) in shadow_visible.iter().enumerate() {
    // rust: let s = self.sections.get_mut(v.slot);
    // rust: let instance = (base + k) as u32;
    // rust: let depth = f64::from(top - height(v)).max(0.0);
    // rust: let distance = (depth * depth).to_bits();
                // A section the camera never saw has no sorted indices yet: sorted once now.
    // rust: if let Some((index_page, index_start)) = s.sorted_indices
    // rust: && !s.sort.is_sorted()
    // rust: {
    // rust: let origin = [
    // rust: v.key.0 * 16,
    // rust: self.layout.min_y() + v.key.1 * 16,
    // rust: v.key.2 * 16,
    // rust: ];
    // rust: if let Some(indices) =
    // rust: s.sort
    // rust: .update(camera.to_array(), origin, &mut self.translucent_sorter)
    // rust: {
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: self.sorted_indices.buffer(index_page),
    // rust: index_start * 4,
    // rust: bytemuck::cast_slice(indices),
    // rust: );
}
}
    // rust: let before = self.draws.len();
    // rust: shadow_runs(&s.sides, view, v.origin, |first, quads| {
    // rust: let start = s.solid_base() + first * 4;
    // rust: self.draws.push([quads * 6, 1, 0, start, instance]);
    // rust: self.draw_pages.push((s.page, None));
    // rust: });
    // rust: let len = self.draws.len() - before;
    // rust: self.shadow_runs.push(distance, s.page, before, len, [0; 3]);
    // rust: if let Some((index_page, index_start)) = s.sorted_indices {
    // rust: let (page, start) = s.translucent_at;
    // rust: shadow_translucent.push((
    // rust: distance,
    // rust: [
    // rust: s.translucent * 6,
    // rust: 1,
    // rust: index_start as u32,
    // rust: start as u32,
    // rust: instance,
    // rust: ],
    // rust: (page, Some(index_page)),
    // rust: ));
}
}
}
    // rust: let shadow_solid = self.draws.len() as u32 - shadow_first;
    // rust: self.shadow_runs
    // rust: .regroup(&mut self.draws, &mut self.draw_pages, shadow_first as usize);
    // rust: self.shadow_runs.clear();
    // rust: for (distance, draw, pages) in shadow_translucent {
    // rust: self.shadow_runs
    // rust: .push(distance, pages.0, self.draws.len(), 1, [0; 3]);
    // rust: self.draws.push(draw);
    // rust: self.draw_pages.push(pages);
}
    // rust: self.shadow_runs.regroup(
    // rust: &mut self.draws,
    // rust: &mut self.draw_pages,
    // rust: (shadow_first + shadow_solid) as usize,
    // rust: );
    // rust: let shadow_translucent = self.draws.len() as u32 - shadow_first - shadow_solid;
    // rust: laps.lap("r_nearby");
        // Metal replays a multi-draw as one draw call per entry.
    // rust: let mut section_draw_calls = if self.multi_draw && self.info.backend != wgpu::Backend::Metal
    // rust: {
    // rust: (0..section_draws)
    // rust: .filter(|&i| {
    // rust: i == 0
    // rust: || i == phase1_draws as usize
    // rust: || i == solid_draws as usize
    // rust: || self.draw_pages[i] != self.draw_pages[i - 1]
    // rust: })
    // rust: .count()
    // rust: } else {
    // rust: section_draws
}
        // GPU culling's draw calls, one per page; its draws come back with its statistics
        // (`GpuCulling::copy_stats`).
    // rust: if gpu_frame && let Some(gpu) = &self.gpu_culling {
    // rust: section_draw_calls += gpu.draw_calls();
}
    // rust: let debug_depth = frame.debug_lines.len() as u32;
    // rust: let debug_opaque = frame
    // rust: .debug_lines
    // rust: .iter()
    // rust: .filter(|l| debug_line_opaque(l))
    // rust: .count() as u32;
    // rust: let debug_top = frame.debug_lines_on_top.len() as u32;
    // rust: let crosshair = frame.debug_crosshair.len() as u32;
    // rust: if debug_depth + debug_top + crosshair > 0 {
    // rust: let needed = u64::from(debug_depth + debug_top + crosshair);
    // rust: if needed > self.debug_line_capacity {
    // rust: self.debug_line_capacity = needed.next_power_of_two();
    // rust: self.debug_line_buffer = self.device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Debug lines"),
    // rust: size: 32 * self.debug_line_capacity,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
}
    // rust: let all: Vec<[f32; 8]> = debug_lines_opaque_first(frame.debug_lines)
    // rust: .chain(frame.debug_lines_on_top)
    // rust: .chain(frame.debug_crosshair)
    // rust: .copied()
    // rust: .collect();
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.debug_line_buffer,
    // rust: 0,
    // rust: bytemuck::cast_slice(&all),
    // rust: );
}
    // rust: self.weather.prepare(
    // rust: &self.device,
    // rust: &mut encoder,
    // rust: &mut self.uploads,
    // rust: frame.weather,
    // rust: frame.weather_time,
    // rust: );
        // Native mods' world primitives, drawn as the world is: its jittered projection, the
        // line widths in the frame's pixels as the gizmo lines'.
    // rust: let world_primitives = !frame.title && {
    // rust: let (uploads, encoder) = (&mut self.uploads, &mut encoder);
    // rust: self.world_primitives.prepare(
    // rust: &self.device,
    // rust: &mut |buffer, bytes| uploads.buffer(encoder, buffer, 0, bytes),
    // rust: &frame.world_primitives,
    // rust: jittered,
    // rust: [self.config.width, self.config.height],
    // rust: &self.entity_atlas,
    // rust: )
}
    // rust: let outline_edges = frame.outline.len().min(MAX_OUTLINE_EDGES as usize);
    // rust: if outline_edges > 0 {
            // The same per-line colour and pixel width layout as the gizmo lines. A high
            // contrast outline is two strokes: the black one first, the bright one after it.
    // rust: let edges = outline_vertices(&frame.outline[..outline_edges], camera);
    // rust: let width = outline_width(self.config.width);
    // rust: let stroke = |color: u32, width: f32| {
    // rust: edges.iter().map(move |e| {
    // rust: let mut line = [0.0; 8];
    // rust: line[..6].copy_from_slice(e);
    // rust: line[6] = f32::from_bits(color);
    // rust: line[7] = width;
    // rust: line
    // rust: })
}
            // A custom outline (PvP & HUD) takes the bright stroke's colour, scales both widths.
    // rust: let (custom, scale) = frame.pvp.outline.map_or((None, 1.0), |(c, s)| (Some(c), s));
    // rust: let lines: Vec<[f32; 8]> = if frame.outline_high_contrast {
    // rust: stroke(0xff00_0000, 7.0 * scale)
    // rust: .chain(stroke(custom.unwrap_or(0xff57_ffe1), width * scale))
    // rust: .collect()
    // rust: } else {
    // rust: stroke(custom.unwrap_or(0x6600_0000), width * scale).collect()
}
    // rust: self.uploads
    // rust: .buffer(&mut encoder, &self.outline, 0, bytemuck::cast_slice(&lines));
    // rust: if let Some(core) = &self.core_lines {
    // rust: let size = [self.config.width, self.config.height];
    // rust: let block = crate::post_chain::Globals {
    // rust: glint_alpha: frame.glint_alpha,
    // rust: ..frame.post_effects.globals
}
    // rust: let [sky_end, clouds_end, ..] = globals.fog_ends;
    // rust: let data = core_lines::uniforms(
    // rust: block.bytes(size, frame.post_effects.menu_blur_radius as i32),
    // rust: views.primary(),
    // rust: pose,
    // rust: jitter,
    // rust: globals.outline_params[3],
    // rust: fog_color,
    // rust: [fog[0], fog[1], fog[2], fog[3], sky_end, clouds_end],
    // rust: );
    // rust: self.uploads.buffer(&mut encoder, core.uniform(), 0, &data);
}
}
    // rust: let skin = frame.skin.filter(|skin| match &mut self.entity_skin {
    // rust: Some(skinner) => skinner.register(&self.device, &mut self.uploads, &mut encoder, skin),
    // rust: None => false,
    // rust: });
    // rust: let pack_skin = !frame.title
    // rust: && skin.is_some()
    // rust: && self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|(_, post)| post.as_ref())
    // rust: .is_some_and(|post| post.skins_entities());
        // While a shader pack draws entities, the runs of `entity_spans` its programs draw are
        // left out of Horizon's own entity draw.
    // rust: let mut entities = frame.entities;
    // rust: if !frame.title
    // rust: && let Some((_, Some(post))) = &mut self.pack_post
    // rust: && post.has_entities()
    // rust: {
    // rust: post.prepare_entities(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: frame.entities,
    // rust: frame.entity_spans,
    // rust: frame.crumbling_sprite,
    // rust: frame.end_portal_sprites[1],
    // rust: &mut self.pack_entity_rest,
    // rust: skin.filter(|_| pack_skin),
    // rust: );
    // rust: entities = &self.pack_entity_rest;
}
        // GameRenderer.useImprovedTransparency. A shader pack keeps its own
        // path.
    // rust: let hdr_lighting = self.native.is_none()
    // rust: && self.pack_post.as_ref().is_none_or(|p| p.1.is_none())
    // rust: && std::env::var_os("HORIZON_HDR_LIGHTING").is_none_or(|v| v != "0");
    // rust: if let Some(hdr) = &mut self.hdr {
    // rust: hdr.lighting = hdr_lighting && hdr.look;
}
    // rust: let oit_on = self.improved_transparency
    // rust: && !frame.title
    // rust: && self.pack_post.as_ref().is_none_or(|p| p.1.is_none())
    // rust: && self.native.is_none()
    // rust: && oit::supported(&self.device);
    // rust: let [
    // rust: entity_quads,
    // rust: text_quads,
    // rust: crumbling_quads,
    // rust: translucent_crumbling_quads,
    // rust: water_mask_quads,
    // rust: swirl_quads,
    // rust: shadow_quads,
    // rust: translucent_particle_quads,
    // rust: translucent_item_quads,
    // rust: oit_entity_quads,
    // rust: world_text_quads,
    // rust: world_text_offset_quads,
    // rust: ] = self.entity_batch.update(
    // rust: entities,
    // rust: frame.additive,
    // rust: frame.hand,
    // rust: frame.see_through,
    // rust: oit_on,
    // rust: );
    // rust: self.entity_batch.append_shadow_only(frame.shadow_only);
        // The posed models' vertices come first: the ordinary entities' draw takes them in.
    // rust: let posed = if pack_skin {
    // rust: 0
    // rust: } else {
    // rust: skin.map_or(0, |s| s.vertices)
}
    // rust: let entity_quads = entity_quads + posed / 4;
    // rust: let weather_quads = frame.weather.len() as u32 / 4;
    // rust: let world_quads = entity_quads
    // rust: + text_quads
    // rust: + crumbling_quads
    // rust: + translucent_crumbling_quads
    // rust: + water_mask_quads
    // rust: + swirl_quads
    // rust: + shadow_quads
    // rust: + translucent_particle_quads
    // rust: + translucent_item_quads
    // rust: + oit_entity_quads
    // rust: + world_text_quads
    // rust: + world_text_offset_quads;
    // rust: laps.lap("r_draw_lists");
        // Where the tail of materials the classic and the improved passes
        // both draw ends: the shadows, particles and items count back from it.
    // rust: let base_quads =
    // rust: world_quads - oit_entity_quads - world_text_quads - world_text_offset_quads;
    // rust: let native_clouds = self.native.as_ref().is_none_or(|n| n.vanilla_clouds);
    // rust: let cloud_quads = if let Some(input) = frame.clouds.as_ref().filter(|_| native_clouds) {
    // rust: let (rebuilt, uniform) =
    // rust: crate::spans::time("clouds", || self.cloud_mesh.prepare(input));
    // rust: let vertices = self.cloud_mesh.vertices.len() as u64;
    // rust: if rebuilt && vertices > 0 {
    // rust: if vertices > self.cloud_capacity {
    // rust: self.cloud_capacity = vertices.next_power_of_two();
    // rust: self.cloud_buffer = self.device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Cloud vertices"),
    // rust: size: self.cloud_capacity * std::mem::size_of::<Vertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
}
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.cloud_buffer,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.cloud_mesh.vertices),
    // rust: );
}
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.cloud_uniform,
    // rust: 0,
    // rust: bytemuck::bytes_of(&uniform),
    // rust: );
    // rust: (vertices / 4) as u32
    // rust: } else {
    // rust: 0
}
    // rust: self.lightning.prepare(
    // rust: &self.device,
    // rust: &mut self.uploads,
    // rust: &mut encoder,
    // rust: &frame.lightning,
    // rust: camera,
    // rust: );
        // Frame generation's made frame draws its own hand, halfway, after the others.
    // rust: let made_hand_vertex = (posed as usize + self.entity_batch.combined.len()) as i32;
    // rust: if fg {
    // rust: self.frame_gen
    // rust: .halfway_hand(frame.hand, hand_view, &mut self.entity_batch.combined);
    // rust: self.frame_gen.track_entities(
    // rust: &self.device,
    // rust: &self.entity_atlas,
    // rust: frame.entities,
    // rust: frame.entity_motion,
    // rust: frame.camera,
    // rust: );
}
    // rust: let all_entities = &self.entity_batch.combined;
    // rust: let hand_quads = (frame.hand.len() / 4) as u32;
    // rust: let additive_quads = (frame.additive.len() / 4) as u32 - self.entity_batch.moved_additive;
    // rust: let see_through_quads = (frame.see_through.len() / 4) as u32;
    // rust: let shadow_only_quads = (frame.shadow_only.len() / 4) as u32;
        // Glowing entities' silhouettes posed on the GPU go last, past every
        // material (the outline pass draws them from there).
    // rust: let outline_base = posed + all_entities.len() as u32;
    // rust: let outlined = skin.map_or(0, |s| s.outline_vertices);
    // rust: let entity_vertices = u64::from(outline_base) + u64::from(outlined);
    // rust: if entity_vertices > self.entity_capacity {
    // rust: self.entity_capacity = entity_vertices.next_power_of_two();
    // rust: self.entity_buffer = self.device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Entity vertices"),
    // rust: size: self.entity_capacity * std::mem::size_of::<Vertex>() as u64,
    // rust: usage: entity_skin::EntitySkin::usage(self.entity_skin.is_some()),
    // rust: mapped_at_creation: false,
    // rust: });
}
    // rust: if !all_entities.is_empty() {
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.entity_buffer,
    // rust: u64::from(posed) * std::mem::size_of::<Vertex>() as u64,
    // rust: bytemuck::cast_slice(all_entities),
    // rust: );
}
    // rust: if let (Some(skinner), Some(skin)) = (&mut self.entity_skin, skin) {
    // rust: if pack_skin {
    // rust: let target = self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|(_, post)| post.as_ref())
    // rust: .and_then(|post| post.skin_target())
    // rust: .expect("GPU pack entity target");
    // rust: skinner.dispatch_pack(
    // rust: &self.device,
    // rust: &mut self.uploads,
    // rust: &mut encoder,
    // rust: skin,
    // rust: target,
    // rust: &self.entity_buffer,
    // rust: outline_base,
    // rust: );
    // rust: } else {
    // rust: skinner.dispatch(
    // rust: &self.device,
    // rust: &mut self.uploads,
    // rust: &mut encoder,
    // rust: skin,
    // rust: &self.entity_buffer,
    // rust: 0,
    // rust: outline_base,
    // rust: );
}
}
    // rust: let static_sections = frame.static_block_entities;
    // rust: let mut static_bytes_uploaded = 0;
    // rust: let catalog_revision = frame.static_block_entity_stats.snapshot_revision;
    // rust: if catalog_revision != self.static_entity_catalog_revision {
    // rust: self.static_entity_sections.retain(|section, _| {
    // rust: static_sections
    // rust: .binary_search_by_key(section, |snapshot| snapshot.section)
    // rust: .is_ok()
    // rust: });
    // rust: for snapshot in static_sections {
    // rust: let vertices = snapshot.vertices.len() as u64;
    // rust: let gpu = self
    // rust: .static_entity_sections
    // rust: .entry(snapshot.section)
    // rust: .or_insert_with(|| {
    // rust: let capacity = vertices.next_power_of_two().max(4);
    // rust: let origin_buffer =
    // rust: self.device
    // rust: .create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Static block-entity section origin"),
    // rust: contents: bytemuck::bytes_of(&snapshot.origin),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: static_bytes_uploaded += std::mem::size_of_val(&snapshot.origin) as u64;
    // rust: GpuStaticEntitySection {
    // rust: buffer: self.device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Static block-entity section vertices"),
    // rust: size: capacity * std::mem::size_of::<Vertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: }),
    // rust: origin_buffer,
    // rust: origin: snapshot.origin,
    // rust: capacity,
    // rust: revision: 0,
    // rust: vertices: 0,
}
    // rust: });
    // rust: if gpu.origin != snapshot.origin {
    // rust: gpu.origin_buffer =
    // rust: self.device
    // rust: .create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Static block-entity section origin"),
    // rust: contents: bytemuck::bytes_of(&snapshot.origin),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: gpu.origin = snapshot.origin;
    // rust: static_bytes_uploaded += std::mem::size_of_val(&snapshot.origin) as u64;
}
    // rust: if gpu.revision == snapshot.revision {
    // rust: continue;
}
    // rust: if vertices > gpu.capacity {
    // rust: gpu.capacity = vertices.next_power_of_two();
    // rust: gpu.buffer = self.device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Static block-entity section vertices"),
    // rust: size: gpu.capacity * std::mem::size_of::<Vertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
}
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &gpu.buffer,
    // rust: 0,
    // rust: bytemuck::cast_slice(&snapshot.vertices),
    // rust: );
    // rust: static_bytes_uploaded += vertices * std::mem::size_of::<Vertex>() as u64;
    // rust: gpu.revision = snapshot.revision;
    // rust: gpu.vertices = vertices as u32;
}
    // rust: self.static_entity_catalog_revision = catalog_revision;
}
    // rust: let static_entity_quads = frame
    // rust: .visible_static_block_entity_sections
    // rust: .iter()
    // rust: .filter_map(|section| self.static_entity_sections.get(section))
    // rust: .map(|section| section.vertices / 4)
    // rust: .sum::<u32>();
    // rust: let max_static_section_quads = frame
    // rust: .visible_static_block_entity_sections
    // rust: .iter()
    // rust: .filter_map(|section| self.static_entity_sections.get(section))
    // rust: .map(|section| section.vertices / 4)
    // rust: .max()
    // rust: .unwrap_or(0);
    // rust: if max_static_section_quads > self.static_entity_index_quads {
    // rust: self.static_entity_index_quads = max_static_section_quads.next_power_of_two();
    // rust: self.static_entity_indices =
    // rust: Self::quad_indices(&self.device, self.static_entity_index_quads);
}
    // rust: if !frame.visible_static_block_entity_sections.is_empty()
    // rust: && self.static_entity_camera != Some(frame.camera)
    // rust: {
    // rust: let camera_floor = [
    // rust: frame.camera.x.floor() as i32,
    // rust: frame.camera.y.floor() as i32,
    // rust: frame.camera.z.floor() as i32,
    // rust: ];
    // rust: let transform = StaticEntityUniform {
    // rust: camera_block: [camera_floor[0], camera_floor[1], camera_floor[2], 0],
    // rust: camera_fraction: [
    // rust: (frame.camera.x - f64::from(camera_floor[0])) as f32,
    // rust: (frame.camera.y - f64::from(camera_floor[1])) as f32,
    // rust: (frame.camera.z - f64::from(camera_floor[2])) as f32,
    // rust: 0.0,
    // rust: ],
}
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.static_entity_transform,
    // rust: 0,
    // rust: bytemuck::bytes_of(&transform),
    // rust: );
    // rust: static_bytes_uploaded += std::mem::size_of::<StaticEntityUniform>() as u64;
    // rust: self.static_entity_camera = Some(frame.camera);
}
    // rust: self.static_entity_frame_stats = frame.static_block_entity_stats;
    // rust: self.static_entity_frame_stats.static_bytes_uploaded = static_bytes_uploaded;
    // rust: self.entity_outline.prepare(
    // rust: &self.device,
    // rust: &mut self.uploads,
    // rust: &mut encoder,
    // rust: frame.glowing,
    // rust: (outline_base, outlined / 4),
    // rust: [self.config.width, self.config.height],
    // rust: );
    // rust: if let Some((rotation, brightness)) = frame.stars {
    // rust: self.stars.prepare(
    // rust: &mut self.uploads,
    // rust: &mut encoder,
    // rust: jittered * rotation,
    // rust: brightness,
    // rust: );
}
    // rust: let celestial_vertices = frame.celestial.len().min(2048 * 4);
    // rust: if frame.end_sky && !frame.title {
    // rust: self.end_sky.prepare(&self.device, frame.end_sky_sprite);
}
    // rust: if celestial_vertices > 0 {
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.celestial_buffer,
    // rust: 0,
    // rust: bytemuck::cast_slice(&frame.celestial[..celestial_vertices]),
    // rust: );
}
    // rust: let max_quads =
    // rust: (world_quads + additive_quads + hand_quads + see_through_quads + shadow_only_quads)
    // rust: .max(cloud_quads)
    // rust: .max(if frame.lightning.bolts.is_empty() {
    // rust: 0
    // rust: } else {
    // rust: lightning::QUADS
    // rust: })
    // rust: .max(weather_quads)
    // rust: .max(frame.glowing.len() as u32 / 4)
    // rust: .max(outlined / 4);
    // rust: if max_quads > self.index_quads {
    // rust: self.index_quads = max_quads.next_power_of_two();
    // rust: self.indices = Self::quad_indices(&self.device, self.index_quads);
}
    // rust: if let Some(b) = &frame.border {
    // rust: if b.rebuilt {
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.border_vertices,
    // rust: 0,
    // rust: bytemuck::cast_slice(&b.vertices),
    // rust: );
}
    // rust: let t = &b.transforms;
    // rust: let uniform = BorderUniform {
    // rust: color: t.color,
    // rust: offset: [
    // rust: t.model_offset[0],
    // rust: t.model_offset[1],
    // rust: t.model_offset[2],
    // rust: t.texture_offset,
    // rust: ],
}
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.border_uniform,
    // rust: 0,
    // rust: bytemuck::bytes_of(&uniform),
    // rust: );
}
    // rust: laps.lap("r_materials");
        // Every upload before the frame's first pass: a pass ends wgpu-core's
        // command buffer, so copies between passes would need one more.
    // rust: if !frame.screen.is_empty() {
    // rust: let vertices: Vec<crate::screen_effects::ScreenVertex> =
    // rust: frame.screen.iter().flat_map(|q| q.vertices).collect();
    // rust: if vertices.len() as u64 > self.screen_capacity {
    // rust: self.screen_capacity = (vertices.len() as u64).next_power_of_two();
    // rust: self.screen_buffer = self.device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Screen effect vertices"),
    // rust: size: self.screen_capacity
    // rust: * std::mem::size_of::<crate::screen_effects::ScreenVertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
}
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.screen_buffer,
    // rust: 0,
    // rust: bytemuck::cast_slice(&vertices),
    // rust: );
}
    // rust: self.hud.prepare(
    // rust: &self.device,
    // rust: &mut self.uploads,
    // rust: &mut encoder,
    // rust: frame.hud,
    // rust: [self.config.width, self.config.height],
    // rust: );
    // rust: if culling && let Some(cull) = &mut self.cull {
    // rust: cull.upload(
    // rust: &self.device,
    // rust: &mut self.uploads,
    // rust: &mut encoder,
    // rust: &self.draws[phase1_draws as usize..solid_draws as usize],
    // rust: &self.instances,
    // rust: &self.globals,
    // rust: );
}
    // rust: let flat_frame = match &mut self.flat {
    // rust: Some(flat)
    // rust: if self.flat_on
                    // They copy the CPU's lists alone (GPU culling is never offered
                    // where vanilla frames draw flat).
    // rust: && !gpu_frame
    // rust: && !self.draws.is_empty()
    // rust: && (listed >= flat.min_sections
    // rust: || pack_terrain
    // rust: || shadow_view.is_some()) =>
    // rust: {
                // The visibility buffer's phase 2 IDs need each call's page (`visbuffer`).
    // rust: flat.page_instances = self.visbuf.is_some()
    // rust: && !pack_terrain
    // rust: && shadow_view.is_none()
    // rust: && self.native.as_ref().is_none_or(|n| n.material.is_none());
    // rust: let sections = &self.sections;
    // rust: let lods = &self.lods;
    // rust: let sorted = &self.sorted_indices;
    // rust: let phase2 = self.cull.as_ref().filter(|_| culling).map(|c| &c.phase2);
    // rust: crate::spans::time("flatten", || {
    // rust: flat.prepare(
    // rust: &self.device,
    // rust: &mut encoder,
    // rust: &mut self.uploads,
    // rust: &self.draws,
    // rust: &self.draw_pages,
    // rust: phase1_draws as usize,
    // rust: solid_draws as usize,
    // rust: [shadow_first, shadow_first + shadow_solid].map(|d| d as usize),
    // rust: [opaque_end, cutout_start, phase2_cutout as usize],
    // rust: phase2,
    // rust: self.translucent_arena.is_some(),
    // rust: visible
    // rust: .iter()
    // rust: .chain(&shadow_visible)
    // rust: .filter_map(|v| {
    // rust: let section = sections.get(v.slot);
    // rust: let code = fade_code(section, &v.key);
    // rust: Some((
    // rust: section.flat_id?,
    // rust: section_instance(v.origin, code, visibility(v.key)),
    // rust: ))
    // rust: })
    // rust: .chain(visible_lods.iter().filter_map(|v| {
    // rust: let id = lods[&v.key].drawn().flat_id?;
    // rust: Some((id, lod::instance(v.origin, v.fade)))
    // rust: })),
    // rust: |page| sorted.buffer(page).clone(),
    // rust: self.own_timing.as_mut(),
    // rust: )
    // rust: })
}
    // rust: _ => false,
}
        // Each page's group binds the page for the solid draws, flat or not.
    // rust: if let Some(flat) = &mut self.flat {
    // rust: let arena = &self.arena;
    // rust: flat.bind_pages(&self.device, |page| {
    // rust: arena.has_page(page).then(|| arena.buffer(page))
    // rust: });
}
    // rust: if flat_frame {
    // rust: section_draw_calls = self.flat.as_ref().map_or(0, |f| f.shadow_calls[0]);
    // rust: } else if self.multi_draw && !self.draws.is_empty() {
    // rust: if self.draws.len() as u64 > self.indirect_capacity {
    // rust: self.indirect_capacity = (self.draws.len() as u64).next_power_of_two();
    // rust: self.indirect = self.device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Section draws"),
    // rust: size: self.indirect_capacity * 20,
    // rust: usage: wgpu::BufferUsages::INDIRECT | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
}
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.indirect,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.draws),
    // rust: );
}
    // rust: let view_target = target_texture.create_view(&wgpu::TextureViewDescriptor {
    // rust: format: Some(self.frame_format),
    // rust: ..Default::default()
    // rust: });
    // rust: if let Some(timer) = &mut self.gpu_timer {
    // rust: timer.begin(&mut encoder);
}
        // The frame's statistics (`show_stats`): a CPU frame's at once; a GPU frame's when the
        // pass's counts come back, with the CPU's part of it: the sections the walk listed but
        // those whose solid quads the pass drew (it counts them), its draws and every call.
    // rust: let cpu = [listed - gpu_solid, section_draws, section_draw_calls];
    // rust: if gpu_frame && let Some(gpu) = &mut self.gpu_culling {
    // rust: gpu.dispatch(&mut encoder, self.own_timing.as_mut());
    // rust: } else {
    // rust: self.show_stats(serial, cpu);
}
        // The world's targets: the screen, or the scaled target of `post`.
    // rust: let pack_post = !frame.title && self.pack_post.as_ref().is_some_and(|p| p.1.is_some());
        // One of Horizon's own packs reads the same world target.
    // rust: let native_post = !frame.title && self.native.as_ref().is_some_and(|n| n.post.is_some());
    // rust: if let Some(timer) = Self::pass_timer(&mut self.pack_post, &mut self.native)
    // rust: && timer.is_some() != self.pass_timing
    // rust: {
    // rust: *timer = self
    // rust: .pass_timing
    // rust: .then(|| pack_timing::PassTiming::new(&self.device, &self.queue))
    // rust: .flatten();
}
    // rust: let pack_reads_world = pack_post || native_post;
    // rust: laps.lap("r_uploads");
        // Phase 2 of occlusion culling draws over the depth, and a shader pack or TAA reads it.
    // rust: let keep_depth = pack_reads_world
    // rust: || (taa && self.world_post.taa)
    // rust: || oit_on
    // rust: || native_render::render_needs().world_depth
    // rust: || fg;
        // The pack's program reads the vertices this frame's draws bind.
    // rust: let pack_draws_terrain = pack_terrain && flat_frame == self.pack_terrain_flat;
        // The shadow camera's lists, drawn by the pack's shadow programs.
    // rust: let pack_draws_shadow = shadow_view.is_some() && flat_frame == self.pack_terrain_flat;
    // rust: let pack_draws_sky = pack_post
    // rust: && self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|p| p.1.as_ref())
    // rust: .is_some_and(|p| p.has_sky());
    // rust: let pack_draws_celestial = pack_post
    // rust: && self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|p| p.1.as_ref())
    // rust: .is_some_and(|p| p.has_celestial());
    // rust: let pack_draws_water = pack_draws_terrain
    // rust: && self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|p| p.1.as_ref())
    // rust: .is_some_and(|p| p.has_water());
    // rust: let pack_draws_clouds = pack_post
    // rust: && self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|p| p.1.as_ref())
    // rust: .is_some_and(|p| p.has_clouds());
    // rust: let pack_draws_outline = pack_post
    // rust: && self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|p| p.1.as_ref())
    // rust: .is_some_and(|p| p.has_lines());
    // rust: let pack_draws_hand = pack_post
    // rust: && self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|p| p.1.as_ref())
    // rust: .is_some_and(|p| p.has_hand());
    // rust: let pack_draws_weather = pack_post
    // rust: && self
    // rust: .pack_post
    // rust: .as_ref()
    // rust: .and_then(|p| p.1.as_ref())
    // rust: .is_some_and(|p| p.has_weather());
    // rust: let scaled = self.world_post.prepare(
    // rust: &self.device,
    // rust: [self.config.width, self.config.height],
    // rust: pack_reads_world || fg,
    // rust: );
    // rust: let (world_view, world_depth) = match &scaled {
    // rust: Some((color, depth)) => (color, depth),
    // rust: None => (&view_target, &self.depth),
}
    // rust: if culling && let Some(cull) = &mut self.cull {
    // rust: cull.bind_depth(&self.device, world_depth);
}
        // The hand draws at the end of the world pass, after a depth reset, when nothing runs
        // between them (a scaled world's post pass, HDR's world copy, a native mod's
        // `native_world_drawn`): one render pass fewer, ~10 µs of wgpu's encoding a frame.
    // rust: let hand_in_world = (frame.hand.len() / 4) > 0
    // rust: && !pack_draws_hand
    // rust: && scaled.is_none()
    // rust: && self.hdr.is_none()
            // Frame generation draws the hand over the real and the made frame after the world.
    // rust: && fg_frames.is_none()
    // rust: && !native_render::world_drawn_hooked();
    // rust: if oit_on {
    // rust: let size = self
    // rust: .world_post
    // rust: .size()
    // rust: .filter(|_| scaled.is_some())
    // rust: .unwrap_or([self.config.width, self.config.height]);
    // rust: let (device, layout, sprites) =
    // rust: (&self.device, &self.terrain_layout, self.terrain_sprites);
    // rust: let clouds = [0, 1].map(|i| self.cloud_pipeline.get_bind_group_layout(i));
    // rust: let format = self.frame_format;
    // rust: let flat = self
    // rust: .flat
    // rust: .as_ref()
    // rust: .map(|f| f.translucent.get_bind_group_layout(1));
    // rust: let features = [
    // rust: self.entity_pipeline.get_bind_group_layout(0),
    // rust: self.weather.pipeline().get_bind_group_layout(1),
    // rust: self.border_pipeline.get_bind_group_layout(0),
    // rust: ];
    // rust: self.oit
    // rust: .get_or_insert_with(|| {
    // rust: oit::Oit::new(
    // rust: device,
    // rust: layout,
    // rust: flat.as_ref(),
    // rust: [&features[0], &features[1], &features[2]],
    // rust: [&clouds[0], &clouds[1]],
    // rust: sprites,
    // rust: format,
    // rust: )
    // rust: })
    // rust: .prepare(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: size,
    // rust: &views.primary().projection,
    // rust: [water_mask_quads > 0, cloud_quads > 0],
    // rust: );
}
    // rust: let oit = self.oit.as_ref().filter(|_| oit_on);
    // rust: let cull = self.cull.as_ref().filter(|_| culling && solid_draws > 0);
    // rust: let pack_sky_clear = pack_draws_sky
    // rust: .then(|| self.pack_post.as_ref().and_then(|p| p.1.as_ref()))
    // rust: .flatten()
    // rust: .and_then(|p| p.sky_clear());
    // rust: let clear = if let Some([r, g, b, a]) = pack_sky_clear {
    // rust: wgpu::Color {
    // rust: r: f64::from(r),
    // rust: g: f64::from(g),
    // rust: b: f64::from(b),
    // rust: a: f64::from(a),
}
    // rust: } else if frame.title || (frame.end_sky && !frame.underwater && sky_open(frame)) {
    // rust: wgpu::Color::BLACK
    // rust: } else {
    // rust: wgpu::Color {
    // rust: r: f64::from(fog_color[0]),
    // rust: g: f64::from(fog_color[1]),
    // rust: b: f64::from(fog_color[2]),
    // rust: a: 1.0,
}
}
    // rust: let sky_visible = sky_open(frame);
    // rust: laps.lap("r_world_pass");
        // One of Horizon's own packs: this frame's inputs; in a timed frame its sky draws in a
        // pass of its own, so that it has a time of its own.
    // rust: let mut native_sky_pass = false;
    // rust: if !frame.title
    // rust: && let Some(native) = &mut self.native
    // rust: {
    // rust: let size = self
    // rust: .world_post
    // rust: .size()
    // rust: .filter(|_| scaled.is_some())
    // rust: .unwrap_or([self.config.width, self.config.height]);
    // rust: native.frame.write(&self.queue, frame, size);
    // rust: native.frame.block_light.update(
    // rust: &self.queue,
    // rust: frame.camera,
    // rust: &self.light_blocks,
    // rust: self.light_revision,
    // rust: );
    // rust: if let Some(t) = &mut native.timing {
    // rust: t.begin(&self.device, &self.queue);
    // rust: native_sky_pass =
    // rust: native.sky.is_some() && t.recording() && sky_visible && frame.skybox;
}
}
        // One of Horizon's own packs with `[shadow]`: the solid terrain the light sees, from the
        // shadow camera's lists, into the pack's shadow map (a pack without one gets its 1×1 map
        // cleared to "far" once).
    // rust: if !frame.title
    // rust: && let Some(native) = &mut self.native
    // rust: {
    // rust: native.frame.shadow_map.clear_blank(&mut encoder);
}
    // rust: if !frame.title
    // rust: && shadow_view.is_some()
    // rust: && let Some(native) = &self.native
    // rust: && let Some(shadow) = &native.shadow
    // rust: {
    // rust: let mut pass = native.frame.shadow_map.begin(
    // rust: &mut encoder,
    // rust: "Native shader pack shadow",
    // rust: self.own_timing.as_mut(),
    // rust: );
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pass.set_bind_group(horizon_shader_api::stages::GROUP, &shadow.group, &[]);
    // rust: if flat_frame
    // rust: && let Some(flat) = &self.flat
    // rust: && let Some(pipeline) = &shadow.flat
    // rust: {
    // rust: pass.set_pipeline(pipeline);
    // rust: let [first, translucent] = flat.shadow_calls;
    // rust: flat.draw(
    // rust: &mut pass,
    // rust: &flat.calls[first..translucent],
    // rust: flat_vertices(&self.arena, self.translucent_arena.as_ref()),
    // rust: );
    // rust: } else if !flat_frame {
    // rust: pass.set_pipeline(&shadow.solid);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(1, self.instances.slice(..));
    // rust: self.draw_sections(&mut pass, &self.indirect, 0, shadow_first, shadow_solid);
}
            // `[displacement]`'s grid casts in place of the flat quads it took over.
    // rust: if let Some((d, picks, pipeline)) = native
    // rust: .displacement
    // rust: .as_ref()
    // rust: .and_then(|d| Some((d, d.shadow.as_ref()?, shadow.displaced.as_ref()?)))
    // rust: {
    // rust: d.draw(&mut pass, picks, pipeline);
}
    // rust: drop(pass);
    // rust: let mut pass = native.frame.shadow_map.begin_translucent(
    // rust: &mut encoder,
    // rust: "Native shader pack translucent shadow",
    // rust: self.own_timing.as_mut(),
    // rust: );
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pass.set_bind_group(horizon_shader_api::stages::GROUP, &shadow.group, &[]);
    // rust: if flat_frame
    // rust: && let Some(flat) = &self.flat
    // rust: && let Some(pipeline) = &shadow.flat_translucent
    // rust: {
    // rust: pass.set_pipeline(pipeline);
    // rust: let [_, translucent] = flat.shadow_calls;
    // rust: flat.draw(
    // rust: &mut pass,
    // rust: &flat.calls[translucent..],
    // rust: flat_vertices(&self.arena, self.translucent_arena.as_ref()),
    // rust: );
    // rust: } else if !flat_frame {
    // rust: pass.set_pipeline(&shadow.translucent);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(1, self.instances.slice(..));
    // rust: self.draw_sections(
    // rust: &mut pass,
    // rust: &self.indirect,
    // rust: 0,
    // rust: shadow_first + shadow_solid,
    // rust: shadow_translucent,
    // rust: );
}
    // rust: drop(pass);
    // rust: if entity_quads > 0 || shadow_only_quads > 0 {
    // rust: let mut pass = native
    // rust: .frame
    // rust: .shadow_map
    // rust: .begin_entities(&mut encoder, "Native shader pack entity shadow");
    // rust: pass.set_pipeline(&shadow.entity);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_bind_group(horizon_shader_api::stages::GROUP, &shadow.group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.draw_indexed(0..entity_quads * 6, 0, 0..1);
                // At the end of the buffer (`EntityBatch::append_shadow_only`).
    // rust: let first = entity_vertices as u32 - shadow_only_quads * 4;
    // rust: pass.draw_indexed(0..shadow_only_quads * 6, first as i32, 0..1);
}
}
    // rust: if native_sky_pass
    // rust: && let Some(native) = &mut self.native
    // rust: && let Some(sky) = &native.sky
    // rust: {
    // rust: if let Some(t) = &mut native.timing {
    // rust: let format = self.frame_format;
    // rust: t.mark(&self.device, &mut encoder, (world_view, format));
}
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some(&sky.label),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: world_view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(clear),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: world_depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.0),
    // rust: store: wgpu::StoreOp::Discard,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: timestamp_writes: native.timing.as_mut().and_then(|t| t.writes(&sky.label)),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: sky.draw(&mut pass, &native.frame);
}
    // rust: laps.lap("r_pack_inputs");
        // The water mirror, for one of Horizon's own packs that reads it: the world as a
        // camera mirrored about the water plane sees it, into a half-resolution target the
        // material stage samples as `reflection`.
    // rust: let mut reflection = None;
    // rust: if let Some(plane) = mirror_plane {
    // rust: let world = self
    // rust: .world_post
    // rust: .size()
    // rust: .filter(|_| scaled.is_some())
    // rust: .unwrap_or([self.config.width, self.config.height]);
    // rust: let size = native_post::reflection_size(world);
    // rust: if self.mirror.as_ref().is_none_or(|m| m.size != size) {
    // rust: let target = |label: &'static str, format, usage| {
    // rust: self.device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default())
}
    // rust: self.mirror = Some(MirrorTarget {
    // rust: size,
    // rust: color: target(
    // rust: "Water mirror",
    // rust: self.frame_format,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: ),
    // rust: depth: target(
    // rust: "Water mirror depth",
    // rust: wgpu::TextureFormat::Depth32Float,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT,
    // rust: ),
    // rust: });
}
    // rust: if let Some(mirror) = &self.mirror {
                // Mirrored about y = `plane` (camera-relative).
    // rust: let plane = plane - frame.camera.y as f32;
    // rust: let inverse_view = mirror_inverse_view(globals.inverse_view, plane);
                // fog_ends.w: the plane, below which fs_solid_mirror cuts the world away
                // (only entity.wgsl reads the glint strength there, and no entity draws here).
    // rust: let mut fog_ends = globals.fog_ends;
    // rust: fog_ends[3] = plane;
    // rust: let mirror_globals = Globals {
    // rust: view_proj: mirror_view_projection(view_proj, plane).to_cols_array_2d(),
    // rust: inverse_view,
    // rust: fog_ends,
    // rust: ..globals
}
    // rust: self.uploads.buffer(
    // rust: &mut encoder,
    // rust: &self.mirror_globals,
    // rust: 0,
    // rust: bytemuck::bytes_of(&mirror_globals),
    // rust: );
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Water mirror"),
    // rust: timestamp_writes: self
    // rust: .own_timing
    // rust: .as_mut()
    // rust: .and_then(|t| t.writes("Water mirror")),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &mirror.color,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(clear),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &mirror.depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.0),
    // rust: store: wgpu::StoreOp::Discard,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_bind_group(0, &self.mirror_group, &[]);
    // rust: if sky_visible && frame.skybox {
    // rust: pass.set_pipeline(&self.sky);
    // rust: pass.draw(0..3, 0..1);
}
                // The solid terrain: occlusion culling is off with a mirror, so every draw
                // is phase 1's.
    // rust: if flat_frame && let Some(flat) = &self.flat {
    // rust: pass.set_pipeline(&flat.solid_mirror);
    // rust: let vertices = flat_vertices(&self.arena, self.translucent_arena.as_ref());
    // rust: flat.draw(&mut pass, &flat.calls[..flat.solid_calls], vertices);
    // rust: } else {
    // rust: pass.set_pipeline(&self.solid_mirror);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(1, self.instances.slice(..));
    // rust: self.draw_solid_sections(&mut pass, &self.indirect, 0, 0, solid_draws);
}
    // rust: drop(pass);
    // rust: reflection = Some(mirror.color.clone());
}
}
    // rust: if let Some(native) = &mut self.native {
    // rust: native
    // rust: .frame
    // rust: .set_reflection(&self.device, reflection.as_ref());
}
        // The material stage's copies of the world before translucent terrain, the size of
        // this frame's targets.
    // rust: if let Some(native) = &mut self.native
    // rust: && native.material.is_some()
    // rust: && !frame.title
    // rust: {
    // rust: let color = scaled.as_ref().map(|(c, _)| c.texture());
    // rust: native
    // rust: .frame
    // rust: .fit_opaque(&self.device, world_depth.texture(), color);
}
    // rust: if let Some(native) = self.native.as_mut().filter(|_| !frame.title) {
    // rust: let writes = native.material.as_ref().is_some_and(|m| m.writes_surface);
    // rust: let depth = world_depth.texture();
    // rust: let size = if writes {
    // rust: [depth.width(), depth.height()]
    // rust: } else {
    // rust: [1, 1]
}
    // rust: native.frame.fit_surface(&self.device, size);
}
    // rust: laps.lap("r_mirror");
        // One of Horizon's own packs with a material stage: terrain draws with its pipelines,
        // which read the pack's frame at group 3.
    // rust: let material = self
    // rust: .native
    // rust: .as_ref()
    // rust: .filter(|_| !frame.title)
    // rust: .and_then(|n| Some((n.material.as_ref()?, &n.frame.group)));
    // rust: let solid_pipeline = material.map_or(&self.solid, |(m, _)| &m.solid);
        // Two solid passes only where a discard costs the GPU its hidden surface
        // removal: Apple's tiled GPUs, behind Metal. Elsewhere the second pass
        // would double the solid draw calls and vertex work for nothing.
    // rust: let split_solid = self.info.backend == wgpu::Backend::Metal;
    // rust: let translucent_pipeline = material.map_or(&self.translucent, |(m, _)| &m.translucent);
    // rust: let pack_flat = material.and_then(|(m, _)| m.flat.as_ref());
        // A material stage's translucent pass reads a copy of the depth the solid terrain
        // left: it is stored across the pass that ends before the copy.
    // rust: let keep_depth = keep_depth || material.is_some();
        // GPU culling's occlusion test splits the world pass as cull.rs's does.
    // rust: let gpu_occluding = gpu_frame && self.gpu_culling.as_ref().is_some_and(|g| g.occluding());
    // rust: let pack_frame = |pass: &mut wgpu::RenderPass<'_>| {
    // rust: if let Some((_, group)) = material {
    // rust: pass.set_bind_group(horizon_shader_api::stages::GROUP, group, &[]);
}
}
        // A pack's solid terrain that calls `set_surface` also writes the surface target, in
        // passes of its own between the sky and everything else.
    // rust: let surface = self
    // rust: .native
    // rust: .as_ref()
    // rust: .filter(|n| {
    // rust: !frame.title
    // rust: && !pack_draws_terrain
    // rust: && n.material.as_ref().is_some_and(|m| m.writes_surface)
    // rust: })
    // rust: .map(|n| n.frame.surface_view.clone());
        // Solid terrain through the visibility buffer (`visbuffer`): flat frames without a
        // pack drawing terrain, a material stage, a surface target or a shadow pass.
    // rust: let vis_frame = flat_frame
    // rust: && !frame.title
    // rust: && !pack_terrain
    // rust: && !pack_draws_terrain
    // rust: && material.is_none()
    // rust: && surface.is_none()
    // rust: && shadow_view.is_none()
    // rust: && self
    // rust: .arena
    // rust: .page_buffers()
    // rust: .all(|(page, _)| page < visbuffer::MAX_PAGES)
    // rust: && self.visbuf.is_some();
    // rust: if vis_frame && let (Some(vis), Some(flat)) = (&mut self.visbuf, &self.flat) {
    // rust: let depth = world_depth.texture();
    // rust: vis.fit(&self.device, [depth.width(), depth.height()], flat);
}
    // rust: {
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: world_view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: if native_sky_pass {
    // rust: wgpu::LoadOp::Load
    // rust: } else {
    // rust: wgpu::LoadOp::Clear(clear)
    // rust: },
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Horizon world"),
    // rust: timestamp_writes: self.own_timing.as_mut().and_then(|t| t.writes("World")),
    // rust: color_attachments: &attachments,
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: world_depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.0),
                        // The visibility buffer's passes, and those after an occlusion test,
                        // draw on after it.
    // rust: store: if cull.is_some() || gpu_occluding || keep_depth || vis_frame {
    // rust: wgpu::StoreOp::Store
    // rust: } else {
    // rust: wgpu::StoreOp::Discard
    // rust: },
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pack_frame(&mut pass);
    // rust: if frame.title || (sky_visible && (frame.skybox || frame.end_sky)) {
    // rust: if !frame.title && frame.skybox && !pack_draws_sky && !native_sky_pass {
    // rust: match self
    // rust: .native
    // rust: .as_ref()
    // rust: .and_then(|n| Some((n.sky.as_ref()?, &n.frame)))
    // rust: {
    // rust: Some((sky, native)) => sky.draw(&mut pass, native),
    // rust: None => {
    // rust: pass.set_pipeline(&self.sky_base);
    // rust: pass.draw(0..3, 0..1);
    // rust: if frame.sky.sunrise_color[3] > 0.001 {
    // rust: pass.set_pipeline(&self.sunrise_pipeline);
    // rust: pass.set_vertex_buffer(0, self.sunrise_buffer.slice(..));
    // rust: pass.draw(0..sunrise_fan::VERTICES as u32, 0..1);
}
}
}
}
    // rust: if frame.title {
    // rust: self.panorama.draw(&mut pass);
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: } else if celestial_vertices > 0 || frame.end_sky {
    // rust: pass.set_pipeline(&self.celestial_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: if frame.end_sky {
    // rust: self.end_sky.draw(&mut pass);
}
    // rust: if celestial_vertices > 0 && !pack_draws_celestial {
                        // The Overworld's bodies start with the sun's quad
                        // (`Game::celestial_geometry`): a pack sky drawing its own skips it.
    // rust: let own_sun = !frame.end_sky
    // rust: && self
    // rust: .native
    // rust: .as_ref()
    // rust: .is_some_and(|n| n.sky.is_some() && !n.vanilla_sun);
    // rust: let first = if own_sun { 6 } else { 0 };
    // rust: pass.set_vertex_buffer(0, self.celestial_buffer.slice(..));
    // rust: pass.draw_indexed(first..(celestial_vertices as u32 / 4) * 6, 0, 0..1);
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: let own_stars = self
    // rust: .native
    // rust: .as_ref()
    // rust: .is_some_and(|n| n.sky.is_some() && !n.vanilla_stars);
    // rust: if !frame.title && frame.stars.is_some() && !pack_draws_sky && !own_stars {
    // rust: self.stars.draw(&mut pass);
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: if !frame.title && frame.dark_disc && !pack_draws_sky {
    // rust: pass.set_pipeline(&self.dark_disc);
    // rust: pass.draw(0..3, 0..1);
}
}
    // rust: let terrain_pass =
    // rust: |encoder: &mut wgpu::CommandEncoder, surface: &wgpu::TextureView, clear: bool| {
                    // Its lifetime forgotten: a closure cannot tie it to `encoder`'s.
    // rust: let mut pass = surface_pass(encoder, world_view, surface, world_depth, clear)
    // rust: .forget_lifetime();
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pack_frame(&mut pass);
    // rust: pass
}
            // The occlusion test's pipeline draws into the world's colour alone.
    // rust: let plain_pass = |encoder: &mut wgpu::CommandEncoder| {
    // rust: let mut pass =
    // rust: world_pass_after_culling(encoder, world_view, world_depth, true, None, "")
    // rust: .forget_lifetime();
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pack_frame(&mut pass);
    // rust: pass
}
    // rust: if let Some(surface) = &surface {
    // rust: drop(pass);
    // rust: pass = terrain_pass(&mut encoder, surface, true);
}
    // rust: match self
    // rust: .flat
    // rust: .as_ref()
    // rust: .filter(|_| flat_frame && !pack_draws_terrain)
    // rust: {
    // rust: _ if pack_draws_terrain => {
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
}
                // The visibility buffer: the sky stays in the world pass's colour; the solid
                // calls draw their IDs and depth (phase 1, the occlusion test, phase 2), then
                // the resolve shades them, and the world pass goes on over both.
    // rust: Some(flat) if vis_frame => {
    // rust: let vis = self.visbuf.as_ref().expect("a visibility buffer frame");
    // rust: let vertices = flat_vertices(&self.arena, self.translucent_arena.as_ref());
    // rust: drop(pass);
    // rust: let mut ids =
    // rust: vis.id_pass(&mut encoder, world_depth, true, self.own_timing.as_mut());
    // rust: ids.set_bind_group(0, &self.group, &[]);
    // rust: vis.draw_ids(&mut ids, flat, vertices);
    // rust: drop(ids);
    // rust: if let Some(cull) = cull {
                        // The test's pipeline draws into the world's colour.
    // rust: let mut test = plain_pass(&mut encoder);
    // rust: cull.test(&mut test);
    // rust: drop(test);
    // rust: cull.test_pass(&mut encoder, self.own_timing.as_mut());
    // rust: flat.flatten_phase2(&mut encoder, self.own_timing.as_mut());
    // rust: let mut ids =
    // rust: vis.id_pass(&mut encoder, world_depth, false, self.own_timing.as_mut());
    // rust: ids.set_bind_group(0, &self.group, &[]);
    // rust: vis.draw_ids_phase2(&mut ids, flat, vertices);
}
    // rust: vis.resolve(
    // rust: &self.device,
    // rust: &mut encoder,
    // rust: world_view,
    // rust: &self.group,
    // rust: flat,
    // rust: &self.arena,
    // rust: self.own_timing.as_mut(),
    // rust: );
    // rust: pass = world_pass_after_culling(
    // rust: &mut encoder,
    // rust: world_view,
    // rust: world_depth,
    // rust: keep_depth,
    // rust: self.own_timing.as_mut(),
    // rust: "World after visibility buffer",
    // rust: );
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pack_frame(&mut pass);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
}
    // rust: Some(flat) => {
    // rust: let vertices = flat_vertices(&self.arena, self.translucent_arena.as_ref());
                    // Without a pack, on Metal, the opaque pass, then the cutout one
                    // (terrain.wgsl's `opaque_quad`), each over phase 1's and phase 2's
                    // calls with quads for it (phase 2's counted from its first).
    // rust: let [opaque, cutout, phase2_split] = flat.pass_calls;
    // rust: let phase2_split = phase2_split - flat.phase1_calls;
    // rust: let phase2_calls = flat.solid_calls - flat.phase1_calls;
    // rust: type Calls = std::ops::Range<usize>;
    // rust: let passes: &[(&wgpu::RenderPipeline, Calls, Calls)] = match pack_flat {
    // rust: Some(p) => &[(&p.0, 0..flat.phase1_calls, 0..phase2_calls)],
    // rust: None if split_solid => &[
    // rust: (&flat.solid_opaque, 0..opaque, 0..phase2_split),
    // rust: (
    // rust: &flat.solid_cutout,
    // rust: cutout..flat.phase1_calls,
    // rust: phase2_split..phase2_calls,
    // rust: ),
    // rust: ],
    // rust: None => &[(&flat.solid, 0..flat.phase1_calls, 0..phase2_calls)],
}
    // rust: let draw = |pass: &mut wgpu::RenderPass<'_>| {
    // rust: for (pipeline, calls, _) in passes {
    // rust: pass.set_pipeline(pipeline);
    // rust: flat.draw(pass, &flat.calls[calls.clone()], vertices);
}
}
    // rust: match cull {
                        // As below: phase 1, the test, then phase 2's draws
                        // that the test saw, copied after it.
    // rust: Some(cull) => {
    // rust: draw(&mut pass);
    // rust: if surface.is_some() {
    // rust: drop(pass);
    // rust: pass = plain_pass(&mut encoder);
}
    // rust: cull.test(&mut pass);
    // rust: drop(pass);
    // rust: cull.test_pass(&mut encoder, self.own_timing.as_mut());
    // rust: flat.flatten_phase2(&mut encoder, self.own_timing.as_mut());
    // rust: pass = match &surface {
    // rust: Some(surface) => terrain_pass(&mut encoder, surface, false),
    // rust: None => world_pass_after_culling(
    // rust: &mut encoder,
    // rust: world_view,
    // rust: world_depth,
    // rust: keep_depth,
    // rust: self.own_timing.as_mut(),
    // rust: "World after culling",
    // rust: ),
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pack_frame(&mut pass);
    // rust: for (pipeline, _, calls) in passes {
    // rust: pass.set_pipeline(pipeline);
    // rust: flat.draw_phase2(&mut pass, calls.clone(), vertices);
}
}
                        // Without culling, phase 1 is all the solid calls.
    // rust: None => draw(&mut pass),
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
}
    // rust: None => {
                    // Without a native material, on Metal, the opaque pass, then the
                    // cutout one (terrain.wgsl's `opaque_quad`), each over phase 1's
                    // and phase 2's lists with quads for it.
    // rust: let (opaque, cutout) = (opaque_end as u32, cutout_start as u32);
    // rust: type Draws = std::ops::Range<u32>;
    // rust: let passes: &[(&wgpu::RenderPipeline, Draws, Draws)] = match material {
    // rust: None if split_solid => &[
    // rust: (&self.solid_opaque, 0..opaque, phase1_draws..phase2_cutout),
    // rust: (
    // rust: &self.solid_cutout,
    // rust: cutout..phase1_draws,
    // rust: phase2_cutout..solid_draws,
    // rust: ),
    // rust: ],
    // rust: _ => &[(solid_pipeline, 0..phase1_draws, phase1_draws..solid_draws)],
}
                    // The vanilla solid pipelines read the page themselves; a native
                    // material's take it as vertices.
    // rust: let pulled = material.is_none() && self.flat.is_some();
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(1, self.instances.slice(..));
    // rust: match cull {
    // rust: Some(cull) => {
                            // Phase 1 and the boxes against its depth (in
                            // its pass, or one of their own on Metal), then
                            // what they found in sight, in a pass that loads
                            // both targets (it reads the test's results).
    // rust: for (pipeline, draws, _) in passes {
    // rust: pass.set_pipeline(pipeline);
    // rust: self.draw_sections_from(
    // rust: &mut pass,
    // rust: &self.indirect,
    // rust: 0,
    // rust: draws.start,
    // rust: draws.len() as u32,
    // rust: pulled,
    // rust: );
}
    // rust: if surface.is_some() {
    // rust: drop(pass);
    // rust: pass = plain_pass(&mut encoder);
}
    // rust: cull.test(&mut pass);
    // rust: drop(pass);
    // rust: cull.test_pass(&mut encoder, self.own_timing.as_mut());
    // rust: pass = match &surface {
    // rust: Some(surface) => terrain_pass(&mut encoder, surface, false),
    // rust: None => world_pass_after_culling(
    // rust: &mut encoder,
    // rust: world_view,
    // rust: world_depth,
    // rust: keep_depth,
    // rust: self.own_timing.as_mut(),
    // rust: "World after culling",
    // rust: ),
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pack_frame(&mut pass);
    // rust: pass.set_index_buffer(
    // rust: self.indices.slice(..),
    // rust: wgpu::IndexFormat::Uint32,
    // rust: );
    // rust: pass.set_vertex_buffer(1, self.instances.slice(..));
    // rust: for (pipeline, _, draws) in passes {
    // rust: pass.set_pipeline(pipeline);
    // rust: self.draw_sections_from(
    // rust: &mut pass,
    // rust: &cull.phase2,
    // rust: phase1_draws,
    // rust: draws.start,
    // rust: draws.len() as u32,
    // rust: pulled,
    // rust: );
}
}
                        // Without culling, phase 1 is all the solid draws; GPU culling's
                        // own test (`GpuCulling::occluding`) leaves the CPU's to phase 2.
    // rust: None => {
    // rust: let gpu = self.gpu_culling.as_ref().filter(|_| gpu_frame);
    // rust: let occluding = gpu.is_some_and(|g| g.occluding());
    // rust: let page_group = |page: u32| {
    // rust: pulled
    // rust: .then(|| self.flat.as_ref()?.page_group(page))
    // rust: .flatten()
}
    // rust: for (pipeline, draws, _) in passes {
    // rust: pass.set_pipeline(pipeline);
                                // GPU culling's draws first, all within the render distance.
    // rust: if let Some(gpu) = gpu {
    // rust: gpu.draw(&mut pass, &self.arena, page_group, 0);
    // rust: pass.set_vertex_buffer(1, self.instances.slice(..));
}
    // rust: if !occluding {
    // rust: self.draw_sections_from(
    // rust: &mut pass,
    // rust: &self.indirect,
    // rust: 0,
    // rust: draws.start,
    // rust: draws.len() as u32,
    // rust: pulled,
    // rust: );
}
}
                            // As cull.rs's arm: the boxes against phase 1's depth, then
                            // phase 2 and the CPU's draws in a pass that loads both targets.
    // rust: if let Some(gpu) = gpu.filter(|_| occluding) {
    // rust: if surface.is_some() {
    // rust: drop(pass);
    // rust: pass = plain_pass(&mut encoder);
}
    // rust: gpu.test(&mut pass);
    // rust: drop(pass);
    // rust: gpu.compact(&mut encoder, self.own_timing.as_mut());
    // rust: pass = match &surface {
    // rust: Some(surface) => terrain_pass(&mut encoder, surface, false),
    // rust: None => world_pass_after_culling(
    // rust: &mut encoder,
    // rust: world_view,
    // rust: world_depth,
    // rust: keep_depth,
    // rust: self.own_timing.as_mut(),
    // rust: "World after culling",
    // rust: ),
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pack_frame(&mut pass);
    // rust: pass.set_index_buffer(
    // rust: self.indices.slice(..),
    // rust: wgpu::IndexFormat::Uint32,
    // rust: );
    // rust: for (pipeline, draws, _) in passes {
    // rust: pass.set_pipeline(pipeline);
    // rust: gpu.draw(&mut pass, &self.arena, page_group, 1);
    // rust: pass.set_vertex_buffer(1, self.instances.slice(..));
    // rust: self.draw_sections_from(
    // rust: &mut pass,
    // rust: &self.indirect,
    // rust: 0,
    // rust: draws.start,
    // rust: draws.len() as u32,
    // rust: pulled,
    // rust: );
}
}
}
}
}
}
            // `[displacement]`'s grid over the flat quads it took over, writing its depth.
    // rust: if let Some(n) = self
    // rust: .native
    // rust: .as_ref()
    // rust: .filter(|_| !frame.title && !pack_draws_terrain)
    // rust: && let Some(d) = &n.displacement
    // rust: && let Some(pipeline) = n.material.as_ref().and_then(|m| m.displaced.as_ref())
    // rust: {
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pack_frame(&mut pass);
    // rust: d.draw(&mut pass, &d.view, pipeline);
}
    // rust: if surface.is_some() {
    // rust: drop(pass);
    // rust: pass = plain_pass(&mut encoder);
}
    // rust: if static_entity_quads > 0 {
    // rust: pass.set_pipeline(&self.static_entity_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_bind_group(1, &self.static_entity_group, &[]);
    // rust: pass.set_index_buffer(
    // rust: self.static_entity_indices.slice(..),
    // rust: wgpu::IndexFormat::Uint32,
    // rust: );
    // rust: for section in frame.visible_static_block_entity_sections {
    // rust: let Some(gpu) = self.static_entity_sections.get(section) else {
    // rust: continue;
}
    // rust: let quads = gpu.vertices / 4;
    // rust: if quads == 0 {
    // rust: continue;
}
    // rust: pass.set_vertex_buffer(0, gpu.buffer.slice(..));
    // rust: pass.set_vertex_buffer(1, gpu.origin_buffer.slice(..));
    // rust: pass.draw_indexed(0..quads * 6, 0, 0..1);
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: if entity_quads > 0 {
    // rust: pass.set_pipeline(&self.entity_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(0..entity_quads * 6, 0, 0..1);
    // rust: if self.hdr.is_some() {
    // rust: pass.set_pipeline(&self.hdr_mark_pipeline);
    // rust: pass.draw_indexed(0..entity_quads * 6, 0, 0..1);
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: if text_quads > 0 && !oit_on {
    // rust: pass.set_pipeline(&self.text_polygon_offset_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(0..text_quads * 6, (entity_quads * 4) as i32, 0..1);
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
            // FeatureRenderDispatcher.PreparedFrame.executeTranslucent: the shadows
            // come before the translucent items, which then cover them (#7026).
    // rust: if shadow_quads > 0 && !oit_on {
    // rust: pass.set_pipeline(&self.shadow_blob_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(
    // rust: 0..shadow_quads * 6,
    // rust: ((base_quads
    // rust: - translucent_item_quads
    // rust: - translucent_particle_quads
    // rust: - shadow_quads)
    // rust: * 4) as i32,
    // rust: 0..1,
    // rust: );
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: if translucent_item_quads > 0 && !oit_on {
    // rust: pass.set_pipeline(&self.translucent_item_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(
    // rust: 0..translucent_item_quads * 6,
    // rust: ((base_quads - translucent_item_quads) * 4) as i32,
    // rust: 0..1,
    // rust: );
    // rust: if self.hdr.is_some() {
                    // A glowing item in the world (Item sheet quads), as entities are.
    // rust: pass.set_pipeline(&self.hdr_mark_pipeline);
    // rust: pass.draw_indexed(
    // rust: 0..translucent_item_quads * 6,
    // rust: ((base_quads - translucent_item_quads) * 4) as i32,
    // rust: 0..1,
    // rust: );
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: if crumbling_quads > 0 && !oit_on {
    // rust: pass.set_pipeline(&self.crumbling_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(
    // rust: 0..crumbling_quads * 6,
    // rust: ((entity_quads + text_quads) * 4) as i32,
    // rust: 0..1,
    // rust: );
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
            // BoatRenderer's water patch (RenderTypes.waterMask): depth only,
            // before translucent terrain, so no water shows inside the boat.
    // rust: if water_mask_quads > 0 && !oit_on {
    // rust: pass.set_pipeline(&self.water_mask_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(
    // rust: 0..water_mask_quads * 6,
    // rust: ((entity_quads + text_quads + crumbling_quads + translucent_crumbling_quads)
    // rust: * 4) as i32,
    // rust: 0..1,
    // rust: );
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: if !frame.lightning.bolts.is_empty() && !oit_on {
    // rust: pass.set_pipeline(&self.lightning_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: self.lightning.draw(&mut pass, &frame.lightning);
    // rust: if self.hdr.is_some() {
    // rust: pass.set_pipeline(&self.hdr_mark_lightning_pipeline);
    // rust: self.lightning.draw(&mut pass, &frame.lightning);
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: if swirl_quads > 0 && !oit_on {
    // rust: pass.set_pipeline(&self.energy_swirl_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(
    // rust: 0..swirl_quads * 6,
    // rust: ((entity_quads
    // rust: + text_quads
    // rust: + crumbling_quads
    // rust: + translucent_crumbling_quads
    // rust: + water_mask_quads)
    // rust: * 4) as i32,
    // rust: 0..1,
    // rust: );
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: if additive_quads > 0 && !oit_on {
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: let mut first = 0;
    // rust: for run in frame.additive.as_chunks::<4>().0.chunk_by(|a, b| {
    // rust: (a[0].layer & 0xffff == DRAGON_RAYS_OVERLAY)
    // rust: == (b[0].layer & 0xffff == DRAGON_RAYS_OVERLAY)
    // rust: }) {
    // rust: let rays = run[0][0].layer & 0xffff == DRAGON_RAYS_OVERLAY;
    // rust: pass.set_pipeline(if rays {
    // rust: &self.dragon_rays_pipeline
    // rust: } else {
    // rust: &self.additive_pipeline
    // rust: });
    // rust: let end = first + run.len() as u32;
    // rust: pass.draw_indexed(first * 6..end * 6, (world_quads * 4) as i32, 0..1);
    // rust: first = end;
}
    // rust: if self.hdr.is_some() {
                    // The dragon's eyes and death rays, marked as entities are.
    // rust: pass.set_pipeline(&self.hdr_mark_pipeline);
    // rust: pass.draw_indexed(0..additive_quads * 6, (world_quads * 4) as i32, 0..1);
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: if outline_edges > 0 && !frame.outline_after_terrain && !pack_draws_outline {
    // rust: self.draw_outline(&mut pass, outline_edges as u32, frame.outline_high_contrast);
}
            // DrawableGizmoPrimitives' opaque group writes depth, the translucent one does not.
    // rust: if debug_opaque > 0 {
    // rust: pass.set_pipeline(&self.debug_lines_opaque);
    // rust: pass.set_vertex_buffer(0, self.debug_line_buffer.slice(..));
    // rust: pass.draw(0..4, 0..debug_opaque);
}
    // rust: if debug_depth > debug_opaque {
    // rust: pass.set_pipeline(&self.debug_lines);
    // rust: pass.set_vertex_buffer(0, self.debug_line_buffer.slice(..));
    // rust: pass.draw(0..4, debug_opaque..debug_depth);
}
    // rust: if debug_top > 0 {
    // rust: pass.set_pipeline(&self.debug_lines_on_top);
    // rust: pass.set_vertex_buffer(0, self.debug_line_buffer.slice(..));
    // rust: pass.draw(0..4, debug_depth..debug_depth + debug_top);
}
            // One of Horizon's own packs reads the world before translucent terrain
            // (`opaque_depth`, `opaque_color`): the pass ends, the targets are copied, and a
            // pass that loads both carries on.
    // rust: if material.is_some()
    // rust: && let Some(native) = &self.native
    // rust: {
    // rust: drop(pass);
    // rust: let depth = world_depth.texture();
    // rust: encoder.copy_texture_to_texture(
    // rust: depth.as_image_copy(),
    // rust: native.frame.opaque_depth.as_image_copy(),
    // rust: depth.size(),
    // rust: );
    // rust: if let Some((color, _)) = &scaled {
    // rust: let color = color.texture();
    // rust: encoder.copy_texture_to_texture(
    // rust: color.as_image_copy(),
    // rust: native.frame.opaque_color.as_image_copy(),
    // rust: color.size(),
    // rust: );
}
    // rust: pass = world_pass_after_culling(
    // rust: &mut encoder,
    // rust: world_view,
    // rust: world_depth,
    // rust: keep_depth,
    // rust: self.own_timing.as_mut(),
    // rust: "World after copy",
    // rust: );
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pack_frame(&mut pass);
}
    // rust: match self.flat.as_ref().filter(|_| flat_frame) {
                // The pack draws translucent terrain after its deferred programs.
    // rust: _ if pack_draws_water => {}
                // LevelRenderer.executeOit in place of the classic blend; what
                // follows draws over its composite in a pass of its own.
    // rust: flat if let Some(oit) = oit => {
    // rust: drop(pass);
                    // LevelRenderer.executeOitWaterMask and CloudRenderer.renderOit.
    // rust: let mask = |pass: &mut wgpu::RenderPass<'_>| {
    // rust: pass.set_pipeline(&self.water_mask_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(
    // rust: 0..water_mask_quads * 6,
    // rust: ((entity_quads
    // rust: + text_quads
    // rust: + crumbling_quads
    // rust: + translucent_crumbling_quads)
    // rust: * 4) as i32,
    // rust: 0..1,
    // rust: );
}
    // rust: let clouds =
    // rust: |pass: &mut wgpu::RenderPass<'_>, pipeline: &wgpu::RenderPipeline| {
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_bind_group(1, &self.cloud_group, &[]);
    // rust: pass.set_index_buffer(
    // rust: self.indices.slice(..),
    // rust: wgpu::IndexFormat::Uint32,
    // rust: );
    // rust: pass.set_vertex_buffer(0, self.cloud_buffer.slice(..));
    // rust: pass.draw_indexed(0..cloud_quads * 6, 0, 0..1);
}
                    // "Features, World Border, Weather": what follows the opaque
                    // world in the classic pass, one stage at a time.
    // rust: let features = |pass: &mut wgpu::RenderPass<'_>, stage: oit::Stage| {
    // rust: let f = oit.features();
    // rust: let s = stage as usize;
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
                        // Quads of a material, `first` quads into the buffer.
    // rust: let quads = |pass: &mut wgpu::RenderPass<'_>,
    // rust: pipeline: &wgpu::RenderPipeline,
    // rust: count: u32,
    // rust: first: u32| {
    // rust: if count > 0 {
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.draw_indexed(0..count * 6, (first * 4) as i32, 0..1);
}
}
    // rust: quads(pass, &f.text[s], text_quads, entity_quads);
    // rust: quads(
    // rust: pass,
    // rust: &f.crumbling[s],
    // rust: crumbling_quads,
    // rust: entity_quads + text_quads,
    // rust: );
    // rust: quads(
    // rust: pass,
    // rust: &f.crumbling[s],
    // rust: translucent_crumbling_quads,
    // rust: entity_quads + text_quads + crumbling_quads,
    // rust: );
    // rust: quads(
    // rust: pass,
    // rust: &f.swirl[s],
    // rust: swirl_quads,
    // rust: entity_quads
    // rust: + text_quads
    // rust: + crumbling_quads
    // rust: + translucent_crumbling_quads
    // rust: + water_mask_quads,
    // rust: );
    // rust: quads(
    // rust: pass,
    // rust: &f.shadow[s],
    // rust: shadow_quads,
    // rust: base_quads
    // rust: - translucent_item_quads
    // rust: - translucent_particle_quads
    // rust: - shadow_quads,
    // rust: );
    // rust: quads(
    // rust: pass,
    // rust: &f.entity[s],
    // rust: translucent_particle_quads,
    // rust: base_quads - translucent_item_quads - translucent_particle_quads,
    // rust: );
    // rust: quads(
    // rust: pass,
    // rust: &f.entity[s],
    // rust: translucent_item_quads,
    // rust: base_quads - translucent_item_quads,
    // rust: );
                        // Translucent, emissive, eyes and breeze wind models:
                        // the same fragment, their light and shading are in
                        // the vertices.
    // rust: quads(pass, &f.entity[s], oit_entity_quads, base_quads);
    // rust: if !frame.lightning.bolts.is_empty() {
    // rust: pass.set_pipeline(&f.lightning[s]);
    // rust: self.lightning.draw(pass, &frame.lightning);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
}
    // rust: quads(pass, &f.additive[s], additive_quads, world_quads);
    // rust: self.weather
    // rust: .draw_with(pass, &f.weather[s], &self.entity_group);
    // rust: if let Some(b) = frame.border.as_ref().filter(|_| !frame.title) {
    // rust: pass.set_pipeline(&f.border[s]);
    // rust: pass.set_bind_group(0, &self.border_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.border_vertices.slice(..));
    // rust: for &side in &b.sides {
    // rust: let first = side as u32 * 6;
    // rust: pass.draw_indexed(first..first + 6, 0, 0..1);
}
}
}
    // rust: let extras = oit::Extras {
    // rust: water_mask: (water_mask_quads > 0).then_some(&mask as _),
    // rust: clouds: (cloud_quads > 0).then_some(&clouds as _),
    // rust: features: Some(&features),
}
                    // The draw closure below borrows all of `self`, so the timer is taken out.
    // rust: let mut own_timing = self.own_timing.take();
    // rust: oit.run(
    // rust: &mut encoder,
    // rust: world_view,
    // rust: world_depth,
    // rust: &|pass, stage| {
    // rust: pass.set_bind_group(0, &self.group, &[]);
                            // Flat section draws take the flat pipelines.
    // rust: if let Some((flat, pipeline)) = flat.zip(oit.flat(stage)) {
    // rust: pass.set_pipeline(pipeline);
    // rust: flat.draw(
    // rust: pass,
    // rust: flat.translucent_calls(),
    // rust: flat_vertices(&self.arena, self.translucent_arena.as_ref()),
    // rust: );
    // rust: return;
}
    // rust: pass.set_pipeline(oit.terrain(stage));
    // rust: pass.set_index_buffer(
    // rust: self.indices.slice(..),
    // rust: wgpu::IndexFormat::Uint32,
    // rust: );
    // rust: pass.set_vertex_buffer(1, self.instances.slice(..));
    // rust: self.draw_sections(
    // rust: pass,
    // rust: &self.indirect,
    // rust: 0,
    // rust: solid_draws,
    // rust: translucent_draws,
    // rust: );
    // rust: },
    // rust: &extras,
    // rust: own_timing.as_mut(),
    // rust: );
    // rust: self.own_timing = own_timing;
    // rust: pass = world_pass_after_culling(
    // rust: &mut encoder,
    // rust: world_view,
    // rust: world_depth,
    // rust: true,
    // rust: self.own_timing.as_mut(),
    // rust: "World after OIT",
    // rust: );
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: if cloud_quads > 0 && !pack_draws_clouds {
    // rust: self.mark_clouds(&mut pass, cloud_quads);
}
                    // HDR output's mark on what shines in the stages, as the classic
                    // pass marks it after drawing it: eyes, the dragon's eyes and rays,
                    // firework sparks and lightning.
    // rust: if self.hdr.is_some() {
    // rust: pass.set_pipeline(&self.hdr_mark_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: for (quads, first) in [
    // rust: (oit_entity_quads, base_quads),
    // rust: (additive_quads, world_quads),
    // rust: (translucent_item_quads, base_quads - translucent_item_quads),
    // rust: (
    // rust: translucent_particle_quads,
    // rust: base_quads - translucent_item_quads - translucent_particle_quads,
    // rust: ),
    // rust: ] {
    // rust: if quads > 0 {
    // rust: pass.draw_indexed(0..quads * 6, (first * 4) as i32, 0..1);
}
}
    // rust: if !frame.lightning.bolts.is_empty() {
    // rust: pass.set_pipeline(&self.hdr_mark_lightning_pipeline);
    // rust: self.lightning.draw(&mut pass, &frame.lightning);
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
    // rust: self.mark_translucent_terrain(&mut pass, flat, solid_draws, translucent_draws);
}
    // rust: Some(flat) => {
    // rust: pass.set_pipeline(pack_flat.map_or(&flat.translucent, |p| &p.1));
    // rust: flat.draw(
    // rust: &mut pass,
    // rust: flat.translucent_calls(),
    // rust: flat_vertices(&self.arena, self.translucent_arena.as_ref()),
    // rust: );
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: self.mark_translucent_terrain(
    // rust: &mut pass,
    // rust: Some(flat),
    // rust: solid_draws,
    // rust: translucent_draws,
    // rust: );
}
    // rust: None => {
    // rust: pass.set_pipeline(translucent_pipeline);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(1, self.instances.slice(..));
    // rust: self.draw_sections(
    // rust: &mut pass,
    // rust: &self.indirect,
    // rust: 0,
    // rust: solid_draws,
    // rust: translucent_draws,
    // rust: );
    // rust: self.mark_translucent_terrain(&mut pass, None, solid_draws, translucent_draws);
}
}
            // LevelRenderer.executeTranslucentAfterTerrain: vanilla's
            // translucent particle layer draws after translucent terrain —
            // the quads write depth, so before it they would hide the glass
            // or water behind them.
    // rust: if translucent_particle_quads > 0 && !oit_on {
    // rust: pass.set_pipeline(&self.entity_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(
    // rust: 0..translucent_particle_quads * 6,
    // rust: ((base_quads - translucent_item_quads - translucent_particle_quads) * 4) as i32,
    // rust: 0..1,
    // rust: );
    // rust: if self.hdr.is_some() {
                    // Fireworks: their sparks are translucent-layer particles.
    // rust: pass.set_pipeline(&self.hdr_mark_pipeline);
    // rust: pass.draw_indexed(
    // rust: 0..translucent_particle_quads * 6,
    // rust: ((base_quads - translucent_item_quads - translucent_particle_quads) * 4)
    // rust: as i32,
    // rust: 0..1,
    // rust: );
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
            // Native world text is an ordinary depth-tested overlay, after
            // particles (also after the OIT composite) and before the hand.
            // Its own geometry is independent of block-entity lifetime.
    // rust: if world_text_quads + world_text_offset_quads > 0 {
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: let first = base_quads + oit_entity_quads;
    // rust: for (pipeline, count, offset) in [
    // rust: (&self.world_text_pipeline, world_text_quads, first),
    // rust: (
    // rust: &self.text_polygon_offset_pipeline,
    // rust: world_text_offset_quads,
    // rust: first + world_text_quads,
    // rust: ),
    // rust: ] {
    // rust: if count > 0 {
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.draw_indexed(0..count * 6, (offset * 4) as i32, 0..1);
}
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
            // LevelRenderer.executeClassicTransparency: translucent targets'
            // outlines follow terrain, so its blending cannot wash them out.
    // rust: if outline_edges > 0 && frame.outline_after_terrain && !pack_draws_outline {
    // rust: self.draw_outline(&mut pass, outline_edges as u32, frame.outline_high_contrast);
}
    // rust: if translucent_crumbling_quads > 0 && !oit_on {
    // rust: pass.set_pipeline(&self.crumbling_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(
    // rust: 0..translucent_crumbling_quads * 6,
    // rust: ((entity_quads + text_quads + crumbling_quads) * 4) as i32,
    // rust: 0..1,
    // rust: );
}
    // rust: if cloud_quads > 0 && !pack_draws_clouds && !oit_on {
    // rust: pass.set_pipeline(&self.cloud_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_bind_group(1, &self.cloud_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.cloud_buffer.slice(..));
    // rust: pass.draw_indexed(0..cloud_quads * 6, 0, 0..1);
    // rust: self.mark_clouds(&mut pass, cloud_quads);
}
            // LevelRenderer.executeClassicTransparency: weather after translucent
            // terrain and clouds, so the water behind the rain is drawn first.
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: if !pack_draws_weather && !oit_on {
    // rust: let native_weather = self
    // rust: .native
    // rust: .as_ref()
    // rust: .filter(|_| !frame.title)
    // rust: .and_then(|n| Some((n.weather.as_ref()?, &n.frame.group)));
    // rust: self.weather
    // rust: .draw(&mut pass, &self.entity_group, native_weather);
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
            // LevelRenderer: the world border after translucent terrain and weather.
    // rust: if let Some(b) = frame.border.as_ref().filter(|_| !frame.title && !oit_on) {
    // rust: pass.set_pipeline(&self.border_pipeline);
    // rust: pass.set_bind_group(0, &self.border_group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(0, self.border_vertices.slice(..));
    // rust: for &side in &b.sides {
    // rust: let first = side as u32 * 6;
    // rust: pass.draw_indexed(first..first + 6, 0, 0..1);
}
    // rust: pass.set_bind_group(0, &self.group, &[]);
}
            // LevelRenderer.executeSeeThrough, after the rest of the world.
    // rust: if see_through_quads > 0 {
    // rust: pass.set_pipeline(&self.see_through_pipeline);
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(
    // rust: 0..see_through_quads * 6,
    // rust: ((world_quads + additive_quads + hand_quads) * 4) as i32,
    // rust: 0..1,
    // rust: );
}
            // Native mods' primitives: after the entities and the rest of the world, into its
            // targets (its resolution, reversed depth and TAA), before the hand.
    // rust: if world_primitives {
    // rust: self.world_primitives.draw(&mut pass);
}
    // rust: if hand_in_world {
    // rust: pass.set_pipeline(&self.depth_reset);
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pass.draw(0..3, 0..1);
    // rust: self.draw_hand(&mut pass, hand_quads, world_quads + additive_quads);
}
}
    // rust: if let Some((color, depth)) = &scaled
    // rust: && pack_post
    // rust: && let Some((dimension, Some(mut post))) = self.pack_post.take()
    // rust: {
    // rust: let size = self.world_post.size().unwrap_or([1, 1]);
    // rust: let weather = match &self.hud.atlas_texture {
    // rust: Some(atlas) if pack_draws_weather => self
    // rust: .pack_weather
    // rust: .get_or_insert_with(|| pack_weather::PackWeather::new(&self.device))
    // rust: .prepare(
    // rust: &self.device,
    // rust: &mut encoder,
    // rust: &mut self.uploads,
    // rust: atlas,
    // rust: frame.weather,
    // rust: frame.weather_time,
    // rust: &self.indices,
    // rust: ),
    // rust: _ => None,
}
    // rust: post.set_weather(weather);
    // rust: let flat = self.flat.as_ref().filter(|_| flat_frame);
    // rust: let pages: Vec<(u32, wgpu::Buffer)> = match flat {
    // rust: Some(_) if pack_draws_terrain || pack_draws_shadow => self
    // rust: .arena
    // rust: .page_buffers()
    // rust: .map(|(p, b)| (p, b.clone()))
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: let mut terrain =
    // rust: |rp: &mut wgpu::RenderPass<'_>,
    // rust: list: pack_post::TerrainList,
    // rust: page: &dyn Fn(&mut wgpu::RenderPass<'_>, u32),
    // rust: geometry: Option<(u32, &wgpu::BindGroupLayout)>| {
//                     use pack_post::TerrainList as L;
    // rust: let shadow = matches!(list, L::ShadowSolid | L::ShadowTranslucent);
    // rust: if !(if shadow {
    // rust: pack_draws_shadow
    // rust: } else {
    // rust: pack_draws_terrain
    // rust: }) {
    // rust: return;
}
    // rust: match flat {
    // rust: Some(flat) => {
    // rust: let [shadow, shadow_translucent] = flat.shadow_calls;
    // rust: let calls = match list {
    // rust: L::Solid => &flat.calls[..flat.solid_calls],
    // rust: L::Translucent => flat.translucent_calls(),
    // rust: L::ShadowSolid => &flat.calls[shadow..shadow_translucent],
    // rust: L::ShadowTranslucent => &flat.calls[shadow_translucent..],
}
    // rust: match geometry {
    // rust: Some((instances, layout)) => {
    // rust: let indices =
    // rust: self.device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack geometry indices"),
    // rust: layout,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: flat.indices.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: rp.set_bind_group(5, &indices, &[]);
    // rust: let vertices =
    // rust: flat_vertices(&self.arena, self.translucent_arena.as_ref());
    // rust: flat.draw_geometry(rp, calls, vertices, page, instances);
}
    // rust: None => flat.draw_with(
    // rust: rp,
    // rust: calls,
    // rust: flat_vertices(&self.arena, self.translucent_arena.as_ref()),
    // rust: page,
    // rust: ),
}
}
                        // A geometry stage reads flat draws' indices; without them it draws nothing.
    // rust: None if geometry.is_some() => {}
    // rust: None => {
    // rust: rp.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: rp.set_vertex_buffer(1, self.instances.slice(..));
    // rust: let (first, count) = match list {
    // rust: L::Solid => (0, solid_draws),
    // rust: L::Translucent => (solid_draws, translucent_draws),
    // rust: L::ShadowSolid => (shadow_first, shadow_solid),
    // rust: L::ShadowTranslucent => {
    // rust: (shadow_first + shadow_solid, shadow_translucent)
}
}
    // rust: self.draw_sections(rp, &self.indirect, 0, first, count);
}
}
}
            // Both strokes of a high contrast outline, the black one first.
    // rust: post.set_lines(pack_draws_outline.then(|| pack_post::Lines {
    // rust: edges: self.outline.clone(),
    // rust: count: outline_edges as u32 * if frame.outline_high_contrast { 2 } else { 1 },
    // rust: }));
    // rust: post.set_clouds(pack_draws_clouds.then(|| pack_post::Clouds {
    // rust: vertices: self.cloud_buffer.clone(),
    // rust: group: self.cloud_group.clone(),
    // rust: indices: self.indices.clone(),
    // rust: quads: cloud_quads,
    // rust: }));
    // rust: post.run(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: &mut encoder,
    // rust: color,
    // rust: depth,
    // rust: &view_target,
    // rust: frame,
    // rust: &frame.pack,
    // rust: size,
    // rust: [self.config.width, self.config.height],
    // rust: &pages,
    // rust: &mut terrain,
    // rust: );
    // rust: self.pack_post = Some((dimension, Some(post)));
    // rust: } else if let Some((color, depth)) = &scaled
    // rust: && native_post
    // rust: && let Some(native) = &mut self.native
    // rust: && let Some(post) = &mut native.post
    // rust: {
    // rust: let size = self.world_post.size().unwrap_or([1, 1]);
    // rust: let history_reset = native.frame.take_history_reset();
    // rust: post.run(
    // rust: &self.device,
    // rust: &mut encoder,
    // rust: (color, depth, &native.frame.surface_view),
    // rust: &view_target,
    // rust: size,
    // rust: history_reset,
    // rust: native.timing.as_mut(),
    // rust: );
    // rust: } else if let (Some((_, generated)), Some((_, depth))) = (&fg_frames, &scaled) {
    // rust: let world = self
    // rust: .frame_gen
    // rust: .world(&self.device, &self.world_post, &self.config);
    // rust: self.world_post
    // rust: .finish(&self.queue, &mut encoder, &world, self.own_timing.as_mut());
    // rust: let camera = frame_gen::Camera {
    // rust: jittered,
    // rust: view_proj,
    // rust: depth: depth.clone(),
    // rust: render_size: self.world_post.size().unwrap_or(size),
    // rust: jitter: self.world_post.jitter_pixels(),
    // rust: reproject: self.frame_gen.camera_motion(view_proj, frame.camera),
    // rust: near: NEAR_PLANE,
    // rust: far: frame.depth_far,
    // rust: fov_y: frame.fov_degrees.to_radians(),
}
    // rust: let generated_view = generated.create_view(&wgpu::TextureViewDescriptor {
    // rust: format: Some(self.config.format.remove_srgb_suffix()),
    // rust: ..Default::default()
    // rust: });
    // rust: fg_made = self.frame_gen.generate(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: &mut encoder,
    // rust: &self.world_post,
    // rust: &view_target,
    // rust: &generated_view,
    // rust: &camera,
    // rust: );
    // rust: if fg_made {
    // rust: let overlay = Overlay {
    // rust: hand_quads: hand_quads * u32::from(!pack_draws_hand),
    // rust: first_hand_vertex: made_hand_vertex,
    // rust: crosshair,
    // rust: first_crosshair: debug_depth + debug_top,
    // rust: world_depth: false,
    // rust: real: false,
    // rust: hand_drawn: !pack_draws_hand,
    // rust: hand_view_proj,
}
    // rust: self.draw_overlay(&mut encoder, frame, &generated_view, generated, &overlay);
}
    // rust: } else if scaled.is_some() {
    // rust: self.world_post.finish(
    // rust: &self.queue,
    // rust: &mut encoder,
    // rust: &view_target,
    // rust: self.own_timing.as_mut(),
    // rust: );
}
    // rust: if !frame.title {
    // rust: let (depth, depth_size) = match &scaled {
    // rust: Some((_, depth)) => (depth, self.world_post.size().unwrap_or(size)),
    // rust: None => (&self.depth, size),
}
    // rust: native_render::native_world_drawn(&mut native_render::WorldDrawn {
    // rust: device: &self.device,
    // rust: queue: &self.queue,
    // rust: encoder: &mut encoder,
    // rust: color: &target_texture,
    // rust: color_view: &view_target,
    // rust: color_format: self.frame_format,
    // rust: size,
    // rust: depth,
    // rust: depth_size,
    // rust: view_proj,
    // rust: jittered,
    // rust: camera: frame.camera,
    // rust: entities: frame.entities,
    // rust: spans: frame.entity_spans,
    // rust: motion: frame.entity_motion,
    // rust: atlas: self.hud.atlas_texture.as_ref(),
    // rust: quad_indices: &self.indices,
    // rust: block_sprites: native_render::BlockSpriteArrays {
    // rust: views: &self.sprite_views,
    // rust: split: self.sprite_split,
    // rust: size: self.sprite_textures[0].width(),
    // rust: nearest: &self.sprite_nearest,
    // rust: filtered: &self.sprite_sampler,
    // rust: },
    // rust: });
}
    // rust: let overlay = Overlay {
    // rust: hand_quads: hand_quads * u32::from(!pack_draws_hand && !hand_in_world),
    // rust: first_hand_vertex: ((world_quads + additive_quads) * 4) as i32,
    // rust: crosshair,
    // rust: first_crosshair: debug_depth + debug_top,
    // rust: world_depth: scaled.is_none(),
    // rust: real: true,
    // rust: hand_drawn: !pack_draws_hand,
    // rust: hand_view_proj,
}
    // rust: let readback =
    // rust: self.draw_overlay(&mut encoder, frame, &view_target, &target_texture, &overlay);
    // rust: if culling && let Some(cull) = &mut self.cull {
    // rust: cull.end(&self.device, &mut encoder);
}
        // GPU culling's counts once its world passes are done (phase 2's too).
    // rust: if gpu_frame && let Some(gpu) = &mut self.gpu_culling {
    // rust: gpu.copy_stats(&mut encoder, serial, cpu);
}
    // rust: if let Some(timer) = &mut self.gpu_timer {
    // rust: timer.end(
    // rust: &self.device,
    // rust: &mut encoder,
    // rust: (&view_target, self.frame_format),
    // rust: );
}
    // rust: laps.lap("r_passes");
        // Under `HORIZON_FRAMEGEN_DEBUG=generated` a screenshot is the made frame.
    // rust: let shown_texture = match &fg_frames {
    // rust: Some((_, generated)) if fg_made && frame_gen::generated_only() => generated,
    // rust: _ => &target_texture,
}
    // rust: let readback = readback.or_else(|| {
    // rust: self.screenshot
    // rust: .take()
    // rust: .and_then(|request| self.take_readback(request, &mut encoder, shown_texture))
    // rust: });
    // rust: self.uploads.finish(&encoder);
    // rust: if has_section_copies {
    // rust: self.section_copy_bytes = 0;
    // rust: self.section_uploads.finish(&encoder);
}
    // rust: if let Some(image) = surface_frame
    // rust: .as_ref()
    // rust: .map(|f| &f.texture)
    // rust: .or(self.offscreen.as_ref())
    // rust: {
    // rust: self.readback.present(&self.device, &mut encoder, image);
}
    // rust: match (&self.hdr, &surface_frame) {
    // rust: (Some(hdr), Some(f)) => hdr.present(
    // rust: &self.queue,
    // rust: &mut encoder,
    // rust: &f.texture,
    // rust: !frame.title,
    // rust: self.own_timing.as_mut(),
    // rust: ),
            // Offscreen nothing shows HDR: the target gets the frame as SDR shows it, for
            // splitscreen's compositor.
    // rust: (Some(_), None) => {
    // rust: if let Some(image) = &self.offscreen {
    // rust: self.readback
    // rust: .draw_onto(&self.device, &mut encoder, &target_texture, image);
}
}
    // rust: (None, _) => {}
}
        // With HDR on, a full-frame screenshot gets an HDR10 copy beside it.
    // rust: let hdr_readback = readback
    // rust: .as_ref()
    // rust: .filter(|(request, _)| request.size.is_none())
    // rust: .zip(self.hdr.as_ref())
    // rust: .and_then(|(_, hdr)| {
    // rust: let texture = hdr.capture(&self.device, &self.queue, &mut encoder, !frame.title)?;
    // rust: let size = [self.config.width, self.config.height];
    // rust: Some(copy_frame(&self.device, &mut encoder, &texture, size))
    // rust: });
    // rust: let first_frame = self.first_frame == FirstFrame::Submit;
        // Finished, submitted and presented on the submit thread when nothing after the
        // submission needs this one: screenshots' readbacks, the error scopes (one per
        // thread), the first frame's startup log, VSync's frame callback, a reconfigure.
        // Frame generation presents its own frames (`frame_gen.present` below).
    // rust: let (encoder, surface_frame, after) = if readback.is_none()
    // rust: && fg_frames.is_none()
    // rust: && hdr_readback.is_none()
    // rust: && checks.is_none()
    // rust: && !first_frame
    // rust: && !reconfigure
    // rust: && self.hdr_marker.is_none()
    // rust: && (surface_frame.is_none() || self.config.present_mode != wgpu::PresentMode::Fifo)
    // rust: {
    // rust: let offscreen = surface_frame.is_none();
            // Occlusion culling's results, GPU culling's statistics and a shader pack's centre
            // depth are read back as soon as the frame is submitted, as here.
    // rust: let culling = self.after_submit();
    // rust: let center = match &mut self.pack_post {
    // rust: Some((_, Some(post))) => post.submitted(),
    // rust: _ => None,
}
    // rust: let after = (culling.is_some() || center.is_some()).then(|| {
    // rust: Box::new(move || {
    // rust: if let Some(read) = culling {
    // rust: read();
}
    // rust: if let Some(read) = center {
    // rust: read();
}
    // rust: }) as submit::AfterSubmit
    // rust: });
    // rust: let job = submit::Job {
    // rust: encoder,
    // rust: surface: surface_frame,
    // rust: after,
}
    // rust: match self.queue.submit_later(job) {
    // rust: Ok(()) => {
    // rust: self.deferred = Some(offscreen);
                    // The frame's waits for the previous one on the submit thread.
    // rust: self.last_wait += self.queue.take_waited();
    // rust: self.last_encode = started.elapsed().saturating_sub(self.last_wait);
    // rust: self.visible = visible;
    // rust: self.visible_lods = visible_lods;
    // rust: self.shadow_visible = shadow_visible;
    // rust: return Ok(true);
}
    // rust: Err(back) => (back.encoder, back.surface, back.after),
}
    // rust: } else {
    // rust: (encoder, surface_frame, None)
}
    // rust: let commands = crate::spans::time("encode", || encoder.finish());
    // rust: if first_frame {
    // rust: startup_step(format_args!("submitting the first frame"));
    // rust: self.first_frame = FirstFrame::Drawn;
}
    // rust: let submission = crate::spans::time("submit", || self.queue.submit([commands]));
    // rust: if let Some(read) = after.or_else(|| self.after_submit()) {
    // rust: read();
}
    // rust: if let Some(timer) = &mut self.gpu_timer {
    // rust: timer.submitted(&self.queue);
    // rust: timer.collect(&self.device, &mut self.gpu_times);
}
    // rust: if let Some(Some(timer)) = Self::pass_timer(&mut self.pack_post, &mut self.native) {
    // rust: timer.submitted(&self.queue);
}
    // rust: if let Some(timer) = &mut self.own_timing {
    // rust: timer.submitted(&self.queue);
}
    // rust: if let Some((_, Some(post))) = &mut self.pack_post
    // rust: && let Some(read) = post.submitted()
    // rust: {
    // rust: read();
}
    // rust: let failed = checks.and_then(GpuChecks::pop);
    // rust: if let Some((request, buffer)) = readback {
            // Out of memory on the way: the PNG would be black; taken again at half the size.
    // rust: if let Some(e) = failed {
    // rust: log::warn!(
    // rust: "Horizon renderer: a {}x{} screenshot failed ({e}); trying half the size",
    // rust: self.config.width,
    // rust: self.config.height
    // rust: );
    // rust: self.screenshot_halvings += 1;
    // rust: self.screenshot = Some(request);
    // rust: } else {
    // rust: self.screenshot_halvings = 0;
    // rust: if let Some(hdr_buffer) = hdr_readback {
    // rust: let hdr_path = hdr_screenshot_path(&request.path);
    // rust: match self.write_hdr_screenshot(&hdr_path, &hdr_buffer) {
    // rust: Ok(()) => log::info!("Saved HDR screenshot to {}", hdr_path.display()),
    // rust: Err(e) => log::warn!(
    // rust: "Horizon renderer: HDR screenshot {}: {e}",
    // rust: hdr_path.display()
    // rust: ),
}
}
    // rust: self.screenshot_result = Some(
    // rust: self.write_screenshot(&request, &buffer)
    // rust: .map_err(|e| e.to_string()),
    // rust: );
}
}
        // The frame's own waits for the submit thread (its queue writes and passes).
    // rust: self.last_wait += self.queue.take_waited();
    // rust: let present = Instant::now();
    // rust: if let Some(surface_frame) = surface_frame {
            // On Wayland this ties RedrawRequested to the compositor's frame
            // callbacks, one per refresh. Only VSync (Fifo) waits for the
            // display: with it off, vanilla's window draws uncapped.
    // rust: if self.config.present_mode == wgpu::PresentMode::Fifo {
    // rust: self.window.pre_present_notify();
}
    // rust: if first_frame {
    // rust: startup_step(format_args!("presenting the first frame"));
}
    // rust: self.queue.present(surface_frame);
    // rust: if self.hdr.is_some()
    // rust: && let Some(marker) = self.hdr_marker.take()
    // rust: {
    // rust: let _ = std::fs::remove_file(marker);
    // rust: log::info!("Horizon renderer: HDR output presented its first frame");
}
    // rust: if reconfigure {
    // rust: self.configure_surface();
}
    // rust: } else if let Some((real, generated)) = fg_frames {
    // rust: self.frame_gen.present(real, generated, fg_made);
}
    // rust: if self.surface.is_none() {
            // No swapchain paces offscreen frames: keep two on the GPU at most.
    // rust: self.in_flight.push_back(submission);
    // rust: if !self.paced_elsewhere {
    // rust: self.wait_in_flight();
}
}
    // rust: self.last_wait += present.elapsed();
        // Inside the present's time already.
    // rust: self.queue.take_waited();
    // rust: self.last_encode = started.elapsed().saturating_sub(self.last_wait);
    // rust: let _ = self.started;
    // rust: self.visible = visible;
    // rust: self.visible_lods = visible_lods;
    // rust: self.shadow_visible = shadow_visible;
    // rust: Ok(true)
}
}
    // rust: impl Renderer {
    /// What draws over the world, on the real frame and frame generation's made one:
    /// the hand, entity outlines, post effects, screen effects, the debug crosshair and
    /// the HUD. Returns the world icon's readback, taken on the real frame.
    // rust: fn draw_overlay(
    // rust: &mut self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: frame: &Frame,
    // rust: view_target: &wgpu::TextureView,
    // rust: target_texture: &wgpu::Texture,
    // rust: overlay: &Overlay,
    // rust: ) -> Option<(ScreenshotRequest, wgpu::Buffer)> {
        // Horizon's own pass timings (#5887) time the real frame's overlay only: a made frame's
        // would count the same passes twice.
    // rust: let mut timing = if overlay.real {
    // rust: self.own_timing.take()
    // rust: } else {
    // rust: None
}
    // rust: if let Some(hdr) = &self.hdr {
    // rust: hdr.keep_world(encoder, timing.as_mut());
}
    // rust: if overlay.hand_quads > 0 {
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: view_target,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("First-person hand"),
    // rust: timestamp_writes: timing.as_mut().and_then(|t| t.writes("Hand")),
    // rust: color_attachments: &attachments,
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &self.depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.0),
                        // HDR output's hand marks test against it (below).
    // rust: store: if self.hdr.is_some() {
    // rust: wgpu::StoreOp::Store
    // rust: } else {
    // rust: wgpu::StoreOp::Discard
    // rust: },
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&self.entity_pipeline);
    // rust: pass.set_bind_group(0, &self.hand_group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: pass.draw_indexed(0..overlay.hand_quads * 6, overlay.first_hand_vertex, 0..1);
    // rust: drop(pass);
    // rust: if let Some(hdr) = &self.hdr {
    // rust: hdr.mark_hand(encoder, timing.as_mut());
    // rust: if let Some(view) = hdr.hand_light_view() {
                    // The light sources in the hand may shine, the rest of it stays at the
                    // world's brightness: nothing the world kept here shows through it.
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("HDR hand marks"),
    // rust: timestamp_writes: timing.as_mut().and_then(|t| t.writes("HDR hand marks")),
    // rust: color_attachments: &attachments,
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &self.depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Discard,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_bind_group(0, &self.hand_group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(0, self.entity_buffer.slice(..));
    // rust: let quads = 0..overlay.hand_quads * 6;
    // rust: pass.set_pipeline(&self.hdr_hand_unmark_pipeline);
    // rust: pass.draw_indexed(quads.clone(), overlay.first_hand_vertex, 0..1);
    // rust: pass.set_pipeline(&self.hdr_mark_pipeline);
    // rust: pass.draw_indexed(quads, overlay.first_hand_vertex, 0..1);
}
}
}
        // A native mod's turn after the hand, on the real frame only.
    // rust: if overlay.real && !frame.title {
    // rust: native_render::native_hand_drawn(&mut native_render::HandDrawn {
    // rust: device: &self.device,
    // rust: queue: &self.queue,
    // rust: encoder: &mut *encoder,
    // rust: color: target_texture,
    // rust: color_view: view_target,
    // rust: color_format: self.frame_format,
    // rust: size: [self.config.width, self.config.height],
    // rust: hand: if overlay.hand_drawn { frame.hand } else { &[] },
    // rust: view_proj: overlay.hand_view_proj,
    // rust: camera: frame.camera,
    // rust: atlas: self.hud.atlas_texture.as_ref(),
    // rust: quad_indices: &self.indices,
    // rust: });
}
        // GameRenderer.render: LevelRenderer.blitEntityOutline after the level and the hand.
    // rust: self.entity_outline.draw(
    // rust: encoder,
    // rust: view_target,
    // rust: &self.entity_group,
    // rust: &self.indices,
    // rust: &self.entity_buffer,
    // rust: timing.as_mut(),
    // rust: );
        // The world icon grabs here: after the level and the hand, before
        // the effects and the HUD draw over them (`tryTakeScreenshotIfNeeded`
        // runs right after `renderLevel`).
    // rust: let readback = self
    // rust: .screenshot
    // rust: .take_if(|request| overlay.real && request.size.is_some())
    // rust: .and_then(|request| self.take_readback(request, encoder, target_texture));
        // GameRenderer.render: applyPostEffects, after the level and before the GUI.
    // rust: if !frame.title
    // rust: && !frame.post_effects.effects.is_empty()
    // rust: && target_texture
    // rust: .usage()
    // rust: .contains(wgpu::TextureUsages::COPY_SRC)
    // rust: {
    // rust: let device = &self.device;
    // rust: let post = self
    // rust: .post_effects
    // rust: .get_or_insert_with(|| crate::post_chain::PostEffects::new(device));
            // The chains a spectated mob applies compile in the background from the
            // first frame in a world, not in the frame that first needs one.
    // rust: post.preload(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: frame.post_effects.root,
    // rust: &crate::post_chain::SPECTATOR_CHAINS,
    // rust: target_texture.format(),
    // rust: );
    // rust: post.apply(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: encoder,
    // rust: target_texture,
    // rust: view_target,
    // rust: [self.config.width, self.config.height],
                // The scaled world pass drew its own depth buffer.
    // rust: overlay.world_depth.then_some(&self.depth),
    // rust: &frame.post_effects,
    // rust: timing.as_mut(),
    // rust: );
}
    // rust: if !frame.screen.is_empty() {
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: view_target,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Screen effects"),
    // rust: timestamp_writes: timing.as_mut().and_then(|t| t.writes("Screen effects")),
    // rust: color_attachments: &attachments,
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(0, self.screen_buffer.slice(..));
    // rust: for (i, quad) in frame.screen.iter().enumerate() {
    // rust: let blend = match quad.blend {
    // rust: crate::screen_effects::Blend::Alpha => 0,
    // rust: crate::screen_effects::Blend::Vignette => 4,
}
    // rust: let tint = if quad.world_tint && self.hdr.is_some() {
    // rust: 8
    // rust: } else {
    // rust: 0
}
    // rust: pass.set_pipeline(
    // rust: &self.screen_pipelines[tint + blend + (quad.sampling & 3) as usize],
    // rust: );
    // rust: pass.draw_indexed(0..6, (i * 4) as i32, 0..1);
}
    // rust: drop(pass);
            // A tint leaves the frame's alpha and goes over the kept world too: light sources
            // under water still show the world, and still shine.
    // rust: if let Some(view) = self.hdr.as_ref().and_then(|h| h.hand_light_view())
    // rust: && frame.screen.iter().any(|quad| quad.world_tint)
    // rust: {
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Screen tints over the kept world"),
    // rust: timestamp_writes: None,
    // rust: color_attachments: &attachments,
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_bind_group(0, &self.entity_group, &[]);
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.set_vertex_buffer(0, self.screen_buffer.slice(..));
    // rust: for (i, quad) in frame.screen.iter().enumerate() {
    // rust: if quad.world_tint {
    // rust: pass.set_pipeline(&self.screen_pipelines[8 + (quad.sampling & 3) as usize]);
    // rust: pass.draw_indexed(0..6, (i * 4) as i32, 0..1);
}
}
}
}
        // GameRenderer.render3dHud: the debug crosshair after the hand and
        // the screen effects.
    // rust: if overlay.crosshair > 0 {
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: view_target,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("3d crosshair"),
    // rust: timestamp_writes: timing.as_mut().and_then(|t| t.writes("Crosshair")),
    // rust: color_attachments: &attachments,
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &self.depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.0),
    // rust: store: wgpu::StoreOp::Discard,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&self.debug_lines_on_top);
    // rust: pass.set_bind_group(0, &self.crosshair_group, &[]);
    // rust: pass.set_vertex_buffer(0, self.debug_line_buffer.slice(..));
    // rust: let first = overlay.first_crosshair;
    // rust: pass.draw(0..4, first..first + overlay.crosshair);
}
    // rust: let menu_blur = frame
    // rust: .menu_blur
    // rust: .filter(|_| self.config.usage.contains(wgpu::TextureUsages::COPY_SRC));
    // rust: let blur_at = menu_blur.map_or(0, |_| frame.hud.blur_at);
    // rust: self.hud.draw_range(
    // rust: encoder,
    // rust: view_target,
    // rust: &self.depth,
    // rust: frame.hud,
    // rust: [self.config.width, self.config.height],
    // rust: 0..blur_at,
    // rust: timing.as_mut(),
    // rust: );
    // rust: if let Some(radius) = menu_blur {
    // rust: let format = self.frame_format;
    // rust: let device = &self.device;
    // rust: let software = is_software(self.info.device_type);
    // rust: self.menu_blur
    // rust: .get_or_insert_with(|| crate::menu_blur::MenuBlur::new(device, format, software))
    // rust: .apply(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: encoder,
    // rust: target_texture,
    // rust: view_target,
    // rust: [self.config.width, self.config.height],
    // rust: radius,
    // rust: timing.as_mut(),
    // rust: );
    // rust: } else if let Some(blur) = &mut self.menu_blur {
    // rust: blur.release();
}
    // rust: self.hud.draw_range(
    // rust: encoder,
    // rust: view_target,
    // rust: &self.depth,
    // rust: frame.hud,
    // rust: [self.config.width, self.config.height],
    // rust: blur_at..frame.hud.vertices.len() as u32,
    // rust: timing.as_mut(),
    // rust: );
    // rust: if overlay.real {
    // rust: self.own_timing = timing;
}
    // rust: readback
}
}
/// Out-of-memory and validation error scopes, popped together: the first error either caught.
pub const GpuChecks = struct {
    memory: wgpu::ErrorScopeGuard,
    validation: wgpu::ErrorScopeGuard,
};
    // rust: impl GpuChecks {
pub fn push(device: *wgpu::Device) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let memory = device.push_error_scope(wgpu::ErrorFilter::OutOfMemory);
    // rust: let validation = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: Self { memory, validation }
}
pub fn pop(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let validation = pollster::block_on(self.validation.pop());
    // rust: let memory = pollster::block_on(self.memory.pop());
    // rust: memory.or(validation)
}
}
/// How many times the window's size a scaled screenshot is: the Resolution Scale
/// `world_scale` when above 1, times `quality`, as far as a side fits in
/// `max_side` pixels and the readback in `max_buffer` bytes.
    // rust: fn scaled_screenshot_factor(
    // rust: [width, height]: [u32; 2],
    // rust: world_scale: f32,
    // rust: quality: u32,
    // rust: max_side: u32,
    // rust: max_buffer: u64,
    // rust: ) -> f32 {
    // rust: let wanted = world_scale.max(1.0) * quality.max(1) as f32;
    // rust: let (w, h) = (f64::from(width.max(1)), f64::from(height.max(1)));
    // rust: let side = f64::from(max_side) / w.max(h);
    // padded_row(w * f) * h * f <= (4 * w * f + 256) * h * f <= max_buffer.
    // rust: let (a, b) = (4.0 * w * h, 256.0 * h);
    // rust: let buffer = ((b * b + 4.0 * a * max_buffer as f64).sqrt() - b) / (2.0 * a);
    // rust: wanted.min(side.min(buffer) as f32)
}
/// Bytes per row of a `width`-pixel frame read back at 4 bytes a pixel.
pub fn padded_row(width: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (width * 4).next_multiple_of(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT)
}
/// Encodes the copy of `texture`'s `size` pixels into a mappable buffer.
    // rust: pub(crate) fn copy_frame(
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: texture: &wgpu::Texture,
    // rust: [width, height]: [u32; 2],
    // rust: ) -> wgpu::Buffer {
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Horizon screenshot"),
    // rust: size: u64::from(padded_row(width)) * u64::from(height),
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_texture_to_buffer(
    // rust: texture.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(padded_row(width)),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width,
    // rust: height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
    // rust: buffer
}
    // rust: impl Renderer {
    /// The frame's readbacks to start right after its submission (on the submit thread when
    /// the frame goes there): occlusion culling's results (`cull`) and GPU culling's
    /// statistics. GPU frames leave occlusion culling off, so a frame has one at most.
pub fn after_submit(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cull = self.cull.as_mut().and_then(|c| c.submitted());
    // rust: let gpu = self.gpu_culling.as_mut().and_then(|g| g.submitted());
    // rust: match (cull, gpu) {
    // rust: (Some(c), Some(g)) => Some(Box::new(move || {
    // rust: c();
    // rust: g();
    // rust: })),
    // rust: (Some(c), None) => Some(Box::new(c)),
    // rust: (None, Some(g)) => Some(Box::new(g)),
    // rust: (None, None) => None,
}
}
    /// Frame `frame`'s statistics shown, unless a newer frame's are: a CPU frame's as it is
    /// drawn, a GPU frame's when its counts come back (`GpuCulling::collect`).
pub fn show_stats(self: *Self, frame: u64, calls]: [usize; 3]) void {
}
    // rust: if frame > self.stats_frame {
    // rust: self.stats_frame = frame;
    // rust: (
    // rust: self.drawn_sections,
    // rust: self.section_draws,
    // rust: self.section_draw_calls,
    // rust: ) = (sections, draws, calls);
}
}
    /// Frames between the last one drawn and the one whose statistics are shown: 0 after a
    /// CPU frame, one to three in GPU frames, while their counts are on their way back.
pub fn stats_lag(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.frame_serial - self.stats_frame
}
    /// Take in the frame the submit thread submitted: start its readbacks and, offscreen,
    /// keep at most two frames ahead of the GPU, as a frame submitted in place does.
pub fn land_frame(self: *Self) void {
}
    // rust: let Some(offscreen) = self.deferred.take() else {
    // rust: return;
}
    // rust: let submission = self.queue.landed();
    // rust: if let Some(timer) = &mut self.gpu_timer {
    // rust: timer.submitted(&self.queue);
    // rust: timer.collect(&self.device, &mut self.gpu_times);
}
    // rust: if let Some(Some(timer)) = Self::pass_timer(&mut self.pack_post, &mut self.native) {
    // rust: timer.submitted(&self.queue);
}
    // rust: if offscreen && let Some(submission) = submission {
    // rust: self.in_flight.push_back(submission);
    // rust: if !self.paced_elsewhere {
    // rust: self.wait_frames();
}
}
}
    /// No swapchain paces offscreen frames: keep two on the GPU at most.
pub fn wait_in_flight(self: *Self) void {
}
    // rust: self.land_frame();
    // rust: self.wait_frames();
}
    /// The frame on the submit thread submitted: a surface reconfigure waits for the
    /// device and breaks if a frame is submitted while it waits, and the compositor
    /// copies views after them. (The end of a frame already lands the frames of the
    /// turn before; this is the turn's own.)
pub fn wait_submissions(self: *Self) void {
}
    // rust: self.queue.wait();
}
pub fn wait_frames(self: *Self) void {
}
    // rust: while self.in_flight.len() > 2 {
    // rust: let index = self.in_flight.pop_front();
    // rust: let _ = self.device.poll(wgpu::PollType::Wait {
    // rust: submission_index: index,
    // rust: timeout: Some(std::time::Duration::from_secs(5)),
    // rust: });
}
}
    /// Take a screenshot request: queue the frame's copy, or report why the
    /// frame cannot be read back.
    // rust: fn take_readback(
    // rust: &mut self,
    // rust: request: ScreenshotRequest,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: texture: &wgpu::Texture,
    // rust: ) -> Option<(ScreenshotRequest, wgpu::Buffer)> {
        // The copy and PNG writer both assume 8-bit pixels; a float surface would make
        // the row stride too small for the copy and abort in validation.
    // rust: if self.config.format.block_copy_size(None) == Some(4) {
    // rust: let size = [self.config.width, self.config.height];
            // The 16-bit frame is read through an 8-bit copy in the swapchain's format.
    // rust: let copy = (texture.format() != self.config.format.remove_srgb_suffix()
    // rust: && texture.format() == self.frame_format)
    // rust: .then(|| {
    // rust: let format = self.config.format.remove_srgb_suffix();
    // rust: self.readback
    // rust: .unorm_copy(&self.device, encoder, texture, format)
    // rust: });
    // rust: let texture = copy.as_ref().unwrap_or(texture);
    // rust: Some((request, copy_frame(&self.device, encoder, texture, size)))
    // rust: } else {
    // rust: self.screenshot_result = Some(Err(format!(
    // rust: "screenshots need a 32-bit surface format, not {:?}",
    // rust: self.config.format
    // rust: )));
    // rust: None
}
}
    /// The pixels `copy_frame` read back into `buffer`, 4 bytes each, row after row.
pub fn read_frame(self: *Self, buffer: *wgpu::Buffer) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (sender, receiver) = std::sync::mpsc::channel();
    // rust: buffer.map_async(wgpu::MapMode::Read, .., move |r| {
    // rust: let _ = sender.send(r);
    // rust: });
    // rust: self.device
    // rust: .poll(wgpu::PollType::wait_indefinitely())
    // rust: .map_err(|e| e.to_string())?;
    // rust: receiver
    // rust: .recv()
    // rust: .map_err(|e| e.to_string())?
    // rust: .map_err(|e| e.to_string())?;
    // rust: let (width, height, row) = (
    // rust: self.config.width as usize,
    // rust: self.config.height as usize,
    // rust: padded_row(self.config.width) as usize,
    // rust: );
    // rust: let mut pixels = Vec::with_capacity(width * height);
    // rust: {
    // rust: let data = buffer.get_mapped_range(..).map_err(|e| e.to_string())?;
    // rust: for y in 0..height {
    // rust: pixels.extend_from_slice(data[y * row..y * row + width * 4].as_chunks::<4>().0);
}
}
    // rust: buffer.unmap();
    // rust: Ok(pixels)
}
    // rust: fn write_screenshot(
    // rust: &self,
    // rust: request: &ScreenshotRequest,
    // rust: buffer: &wgpu::Buffer,
    // rust: ) -> Result<[u32; 2]> {
    // rust: let bgra = matches!(
    // rust: self.config.format.remove_srgb_suffix(),
    // rust: wgpu::TextureFormat::Bgra8Unorm
    // rust: );
    // rust: let mut pixels = Vec::with_capacity((self.config.width * self.config.height * 4) as usize);
    // rust: for px in self.read_frame(buffer)? {
    // rust: let (r, b) = if bgra { (px[2], px[0]) } else { (px[0], px[2]) };
    // rust: pixels.extend_from_slice(&[r, px[1], b, 255]);
}
        // NativeImage.resizeSubRectTo on takeAutoScreenshot's grab: the icon
        // is the frame's centre square averaged down to its size.
    // rust: let (width, height, pixels) = match request.size {
    // rust: Some(size) => (
    // rust: size[0],
    // rust: size[1],
    // rust: square_downscale(&pixels, self.config.width, self.config.height, size),
    // rust: ),
    // rust: None => (self.config.width, self.config.height, pixels),
}
    // rust: let mut encoder = png::Encoder::new(
    // rust: std::io::BufWriter::new(std::fs::File::create(&request.path)?),
    // rust: width,
    // rust: height,
    // rust: );
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: encoder.write_header()?.write_image_data(&pixels)?;
    // rust: Ok([width, height])
}
    /// The HDR10 copy (`Hdr::capture`) as a 16-bit PNG tagged BT.2020 with PQ (cICP, PNG's
    /// third edition), with the peak and paper white as its content light levels (cLLI), and
    /// an ICC profile for the programs that don't read cICP (`hdr_icc`).
pub fn write_hdr_screenshot(self: *Self, path: *std::path::Path, buffer: *wgpu::Buffer) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(hdr) = &self.hdr else {
    // rust: return Ok(());
}
    // rust: let pixels = hdr10_to_rgb16(&self.read_frame(buffer)?);
    // rust: let mut info = png::Info::with_size(self.config.width, self.config.height);
    // rust: info.color_type = png::ColorType::Rgb;
    // rust: info.bit_depth = png::BitDepth::Sixteen;
    // rust: info.icc_profile = Some(hdr_icc::profile().into());
    // rust: let encoder =
    // rust: png::Encoder::with_info(std::io::BufWriter::new(std::fs::File::create(path)?), info)?;
    // rust: let mut writer = encoder.write_header()?;
        // BT.2020 primaries, PQ, RGB, full range.
    // rust: writer.write_chunk(png::chunk::cICP, &[9, 16, 0, 1])?;
    // rust: let nits = |n: f32| ((n * 10_000.0) as u32).to_be_bytes();
    // rust: let peak = hdr.peak.max(hdr.paper_white);
    // rust: writer.write_chunk(
    // rust: png::chunk::cLLI,
    // rust: &[nits(peak), nits(hdr.paper_white.min(peak))].concat(),
    // rust: )?;
    // rust: writer.write_image_data(&pixels)?;
    // rust: Ok(())
}
}
/// `screenshots/2026-10-28_12.00.00.png` -> `screenshots/2026-10-28_12.00.00-hdr.png`.
pub fn hdr_screenshot_path(path: *std::path::Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stem = path.file_stem().unwrap_or_default().to_string_lossy();
    // rust: path.with_file_name(format!("{stem}-hdr.png"))
}
/// `Rgb10a2Unorm` pixels as 16-bit RGB, big-endian as PNG stores it: each 10-bit value
/// with its top bits repeated below, so 0 stays 0 and 1023 becomes 65535.
pub fn hdr10_to_rgb16(pixels: *[[u8; 4]]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::with_capacity(pixels.len() * 6);
    // rust: for &px in pixels {
    // rust: let v = u32::from_le_bytes(px);
    // rust: for shift in [0, 10, 20] {
    // rust: let c = (v >> shift & 0x3ff) as u16;
    // rust: out.extend_from_slice(&(c << 6 | c >> 4).to_be_bytes());
}
}
    // rust: out
}
/// Centre-crop the frame to a square and average it down to `size`.
    // rust: pub(crate) fn square_downscale(pixels: &[u8], width: u32, height: u32, size: [u32; 2]) -> Vec<u8> {
    // rust: let (side, cx, cy) = if width > height {
    // rust: (height, (width - height) / 2, 0)
    // rust: } else {
    // rust: (width, 0, (height - width) / 2)
}
    // rust: let [tw, th] = size;
    // rust: let mut out = vec![0u8; (tw * th * 4) as usize];
    // rust: for ty in 0..th {
    // rust: let y0 = cy + ty * side / th;
    // rust: let y1 = cy + (ty + 1) * side / th;
    // rust: for tx in 0..tw {
    // rust: let x0 = cx + tx * side / tw;
    // rust: let x1 = cx + (tx + 1) * side / tw;
    // rust: let (mut r, mut g, mut b) = (0u32, 0u32, 0u32);
    // rust: for y in y0..y1 {
    // rust: for x in x0..x1 {
    // rust: let p = ((y * width + x) * 4) as usize;
    // rust: r += u32::from(pixels[p]);
    // rust: g += u32::from(pixels[p + 1]);
    // rust: b += u32::from(pixels[p + 2]);
}
}
    // rust: let count = (x1 - x0) * (y1 - y0);
    // rust: let o = ((ty * tw + tx) * 4) as usize;
    // rust: out[o..o + 4].copy_from_slice(&[
    // rust: (r / count) as u8,
    // rust: (g / count) as u8,
    // rust: (b / count) as u8,
    // rust: 255,
    // rust: ]);
}
}
    // rust: out
}
/// The union of two frusta (the camera's and its water mirror's), for `Resident::visible`.
pub const Frusta = struct {};
/// What `Resident::visible` culls with: a frustum or a union of them.
    // rust: pub trait Cull {
pub fn intersects(self: *Self, min: Vec3, max: Vec3) b;
pub fn contains(self: *Self, min: Vec3, max: Vec3) b;
    /// Whether a section is tested by the box around its geometry, not its whole 16 blocks.
pub fn tight(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
}
    // rust: impl Cull for Frustum {
pub fn intersects(self: *Self, min: Vec3, max: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Frustum::intersects(self, min, max)
}
pub fn contains(self: *Self, min: Vec3, max: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Frustum::contains(self, min, max)
}
}
    // rust: impl Cull for Frusta {
pub fn intersects(self: *Self, min: Vec3, max: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.intersects(min, max) || self.1.is_some_and(|f| f.intersects(min, max))
}
    /// Entirely inside one of them is entirely inside the union.
pub fn contains(self: *Self, min: Vec3, max: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.contains(min, max) || self.1.is_some_and(|f| f.contains(min, max))
}
}
/// A shader pack's shadow camera's box, and with `casters` only what can shade the camera's view
/// (`shadow_casters`): a box must meet all of them.
pub const ShadowCull = struct {
    light: Frustum,
    casters: Option<[Frustum,
    /// `shadowDistance × shadowDistanceRenderMul`: only what lies within this many blocks of the
    /// camera along each axis, a cube around it. Our probe's Iris 1.11.7 maps keep the sections
    /// whose box, grown by `SHADOW_CASTER_MARGIN` as for the casters, meets that cube (#8464):
    /// out to its corners, and a section 1 block past its side but not one 1.5 blocks past.
    reach: ?f32,
};
    // rust: impl ShadowCull {
    /// Whether the camera-relative box `min..max`, grown by the margin, meets (`whole`: lies
    /// within) `reach`'s cube.
pub fn within_reach(self: *Self, min: Vec3, max: Vec3, whole: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (min, max) = (min - SHADOW_CASTER_MARGIN, max + SHADOW_CASTER_MARGIN);
    // rust: self.reach.is_none_or(|d| {
    // rust: if whole {
    // rust: min.cmpge(Vec3::splat(-d)).all() && max.cmple(Vec3::splat(d)).all()
    // rust: } else {
    // rust: max.cmpge(Vec3::splat(-d)).all() && min.cmple(Vec3::splat(d)).all()
}
    // rust: })
}
}
/// How far past a section's 16 blocks the shadow pass looks for what can shade the view: our
/// probes' Iris 1.11.7 maps keep the sections whose box, grown by this much on every side, meets
/// `shadow_casters`' shape. Over 76 scenes at fields of view 30 to 110, Iris keeps every section
/// that needs up to 1.1224 blocks and drops every one that needs 1.1252 or more (#8464): one
/// growth, whatever the field of view, of 9/8 (a fit, not Iris's code). Without it the edges of
/// the wedge lose a column of terrain.
pub const SHADOW_CASTER_MARGIN: f32 = 1.125;
    // rust: impl Cull for ShadowCull {
pub fn intersects(self: *Self, min: Vec3, max: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (grown_min, grown_max) = (min - SHADOW_CASTER_MARGIN, max + SHADOW_CASTER_MARGIN);
    // rust: self.within_reach(min, max, false)
    // rust: && self.light.intersects(min, max)
    // rust: && self
    // rust: .casters
    // rust: .is_none_or(|c| c.iter().all(|f| f.intersects(grown_min, grown_max)))
}
pub fn contains(self: *Self, min: Vec3, max: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (grown_min, grown_max) = (min - SHADOW_CASTER_MARGIN, max + SHADOW_CASTER_MARGIN);
    // rust: self.within_reach(min, max, true)
    // rust: && self.light.contains(min, max)
    // rust: && self
    // rust: .casters
    // rust: .is_none_or(|c| c.iter().all(|f| f.contains(grown_min, grown_max)))
}
    /// Our probe's Iris 1.11.7 maps fit testing the casters' whole sections (a guess that matched).
pub fn tight(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.casters.is_none()
}
}
/// The block entities of `sections` whose box, a block wider on every side, comes within the
/// 64 blocks block entities are drawn to (`Renderer::visible_block_entities_in_frustum`).
    // rust: fn block_entities_within_reach<'a>(
    // rust: sections: impl Iterator<Item = SectionKey> + 'a,
    // rust: block_entities: &'a FxHashMap<SectionKey, Vec<([i32; 3], u32)>>,
    // rust: camera: DVec3,
    // rust: min_y: i32,
    // rust: ) -> impl Iterator<Item = &'a ([i32; 3], u32)> + 'a {
    // rust: sections
    // rust: .filter_map(move |key| {
    // rust: let min = (DVec3::new(
    // rust: f64::from(key.0 * 16 - 1),
    // rust: f64::from(min_y + key.1 * 16 - 1),
    // rust: f64::from(key.2 * 16 - 1),
    // rust: ) - camera)
    // rust: .as_vec3();
    // rust: let max = min + Vec3::splat(18.0);
    // rust: let near = Vec3::ZERO.max(min).min(max).length_squared() <= 64.0 * 64.0;
    // rust: near.then(|| block_entities.get(&key)).flatten()
    // rust: })
    // rust: .flatten()
}
/// The shadow camera's box that the shadow pass draws terrain in: the sides of `view.cull`, and
/// its near and far planes only with `depth_planes`.
pub fn shadow_box(view: *pack_post::ShadowView) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut planes = frustum(view.cull);
    // rust: if !view.depth_planes {
        // `frustum`'s faces at depth 0 and 1 take in everything.
    // rust: planes[4] = Vec4::W;
    // rust: planes[5] = Vec4::W;
}
    // rust: Frustum { planes }
}
/// Camera-relative clip planes (`Frustum`).
pub const Frustum = struct {
    planes: [Vec4,
};
    // rust: impl Frustum {
    /// Whether the camera-relative box `min..max` is at least partly inside.
pub fn intersects(self: *Self, min: Vec3, max: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.planes.iter().any(|p| {
    // rust: let v = Vec3::new(
    // rust: if p.x >= 0.0 { max.x } else { min.x },
    // rust: if p.y >= 0.0 { max.y } else { min.y },
    // rust: if p.z >= 0.0 { max.z } else { min.z },
    // rust: );
    // rust: p.truncate().dot(v) + p.w < 0.0
    // rust: })
}
    /// Whether a camera-relative sphere is at least partly inside. Frustum
    /// planes are normalized, so each test needs only one dot product and a
    /// radius comparison.
pub fn intersects_sphere(self: *Self, center: Vec3, radius: f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !center.is_finite() || !radius.is_finite() || radius < 0.0 {
    // rust: return true;
}
    // rust: !self
    // rust: .planes
    // rust: .iter()
    // rust: .any(|plane| plane.truncate().dot(center) + plane.w < -radius)
}
    /// Whether the camera-relative box `min..max` is entirely inside. Then
    /// `intersects` accepts every box within it: each plane's distance only
    /// grows from this box's nearest corner to the inner box's farthest, and
    /// rounding keeps that order.
pub fn contains(self: *Self, min: Vec3, max: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.planes.iter().all(|p| {
    // rust: let v = Vec3::new(
    // rust: if p.x >= 0.0 { min.x } else { max.x },
    // rust: if p.y >= 0.0 { min.y } else { max.y },
    // rust: if p.z >= 0.0 { min.z } else { max.z },
    // rust: );
    // rust: p.truncate().dot(v) + p.w >= 0.0
    // rust: })
}
}
/// Vanilla's `Projection`: reversed depth (near maps to 1, far to 0, tests
/// are GREATER_THAN_OR_EQUAL), which keeps far faces a hair apart, like
/// fire_side's 0.01 pixel in front of its block, from z-fighting.
/// The section the camera is in.
pub fn camera_section(camera: DVec3, min_y: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: (camera.x.floor() as i32) >> 4,
    // rust: (camera.y.floor() as i32 - min_y) >> 4,
    // rust: (camera.z.floor() as i32) >> 4,
    // rust: )
}

/// The near plane of the world's projection, in blocks.
pub const NEAR_PLANE: f32 = 0.05;

/// Counts and offsets `Renderer::draw_overlay` draws from this frame's buffers.
pub const Overlay = struct {
    /// Zero when a shader pack draws the hand.
    hand_quads: u32,
    first_hand_vertex: i32,
    crosshair: u32,
    first_crosshair: u32,
    /// The world drew into `depth` (post effects may read it), not a scaled target's.
    world_depth: bool,
    /// The real frame, not frame generation's made one: the world icon grabs it.
    real: bool,
    /// The game drew the first-person hand, in its own pass or at the end of the world's
    /// (`hand_in_world`), not a shader pack.
    hand_drawn: bool,
    /// Camera-relative world to clip space for the hand: its own field of view and the bob.
    hand_view_proj: Mat4,
};

pub fn world_projection(fov_degrees: f32, aspect: f32, far: f32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Mat4::perspective_rh(fov_degrees.to_radians(), aspect, far, NEAR_PLANE)
}

/// `view_proj` mirrored about the horizontal plane at the camera-relative height `plane`:
/// with F the mirror (y flips and moves to 2 * plane), `view_proj * F` negates column 1
/// and moves column 3 by 2 * plane times column 1.
///
/// `mirror_inverse_view` is the inverse's other side: F * `inverse_view`.
pub fn mirror_view_projection(view_proj: Mat4, plane: f32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut m = view_proj.to_cols_array_2d();
    // rust: let col1 = m[1];
    // rust: m[1] = col1.map(|v| -v);
    // rust: m[3] = std::array::from_fn(|i| m[3][i] + 2.0 * plane * col1[i]);
    // rust: Mat4::from_cols_array_2d(&m)
}

/// The mirror's `inverse_view` (the sky's rays): what the view sees, mirrored about the
/// horizontal plane at the camera-relative height `plane`, so F * `inverse_view`.
pub fn mirror_inverse_view(inverse_view: [[f32; 4]; 4], plane: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: inverse_view.map(|[x, y, z, w]| [x, 2.0 * plane * w - y, z, w])
}
/// Where a perspective `view_proj` sees from, in its own (camera-relative)
/// space: the point whose clip x, y and w are all 0. `None` for a
/// projection without one (orthographic).
pub fn projection_center(view_proj: Mat4) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let m = view_proj.as_dmat4();
    // rust: let rows = [m.row(0), m.row(1), m.row(3)];
    // rust: let a = glam::DMat3::from_cols(
    // rust: DVec3::new(rows[0].x, rows[1].x, rows[2].x),
    // rust: DVec3::new(rows[0].y, rows[1].y, rows[2].y),
    // rust: DVec3::new(rows[0].z, rows[1].z, rows[2].z),
    // rust: );
    // rust: let det = a.determinant();
    // rust: if !det.is_normal() {
    // rust: return None;
}
    // rust: let b = DVec3::new(rows[0].w, rows[1].w, rows[2].w);
    // rust: Some((a.inverse() * -b).as_vec3())
}
/// The runs of a section's solid quads the shadow pass draws: every face within the unculled
/// distance, or everywhere for `every_face`; else the quads that can face the light.
    // rust: fn shadow_runs(
    // rust: sides: &Sides,
    // rust: view: &pack_post::ShadowView,
    // rust: origin: [f32; 3],
    // rust: draw: impl FnMut(u32, u32),
    // rust: ) {
    // rust: let unculled = view.unculled.is_some_and(|d| {
    // rust: let o = Vec3::from(origin) + 8.0;
    // rust: o.x.abs().max(o.z.abs()) <= d + 8.0
    // rust: });
    // rust: let toward = (!unculled && !view.every_face).then_some(view.light * 1.0e5);
    // rust: facing_runs(sides, toward, origin, draw);
}

/// Calls `draw(first, quads)` for each run of a mesh's solid quads that can
/// face `eye` (`projection_center`), the mesh at the camera-relative
/// `origin`; all of them when there is no eye.
pub fn facing_runs(sides: *Sides, eye: ?Vec3, origin: [f32; 3], draw: impl FnMut(u32) void {
}
    // rust: facing_runs_from(sides, eye, None, origin, Quads::All, draw)
}
/// `facing_runs` for the eye and, with `low`, every eye straight below it down to that
/// camera-relative height (the water mirror's eye).
    // rust: fn facing_runs_from(
    // rust: sides: &Sides,
    // rust: eye: Option<Vec3>,
    // rust: low: Option<f32>,
    // rust: origin: [f32; 3],
    // rust: part: Quads,
    // rust: draw: impl FnMut(u32, u32),
    // rust: ) {
    // rust: match eye {
    // rust: Some(eye) => {
    // rust: let eye = eye - Vec3::from(origin);
    // rust: let low = low.map_or(eye.y, |y| (y - origin[1]).min(eye.y));
    // rust: sides.visible_from(eye.to_array(), low, part, draw)
}
    // rust: None => sides.every(part, draw),
}
}
/// The camera's view `view_proj` (wgpu depth, reversed or not) stretched without end toward
/// `light` (a direction): the boxes whose shadow, cast away from the light, can fall into the
/// view. Its planes are the view's faces turned toward the light, and through each edge between
/// such a face and one turned away, the plane along the light; unused ones take in everything.
pub fn shadow_casters(view_proj: Mat4, light: Vec3) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let faces = frustum(view_proj);
    // rust: let toward = faces.map(|p| p.truncate().dot(light) >= 0.0);
    // rust: let inverse = view_proj.inverse();
    // Corner (x, y, z) of clip space's box; `frustum`'s faces at x -1 and 1 are 0 and 1, at
    // y -1 and 1 are 2 and 3, at depth 0 and 1 are 4 and 5.
    // rust: let corner = |c: [usize; 3]| {
    // rust: inverse.project_point3(Vec3::new(
    // rust: c[0] as f32 * 2.0 - 1.0,
    // rust: c[1] as f32 * 2.0 - 1.0,
    // rust: c[2] as f32,
    // rust: ))
}
    // rust: let corners: Vec<[usize; 3]> = (0..8).map(|i| [i & 1, (i >> 1) & 1, i >> 2]).collect();
    // rust: let centre = corners.iter().map(|&c| corner(c)).sum::<Vec3>() / 8.0;
    // rust: let mut planes = [Vec4::W; 12];
    // rust: let mut n = 0;
    // rust: for (k, &face) in faces.iter().enumerate() {
    // rust: if toward[k] {
    // rust: planes[n] = face;
    // rust: n += 1;
}
}
    // rust: for a in &corners {
    // rust: for axis in 0..3 {
    // rust: if a[axis] == 1 {
    // rust: continue;
}
    // rust: let mut b = *a;
    // rust: b[axis] = 1;
            // The edge from a to b lies on the faces of the two other axes.
    // rust: let [f, g] = [(axis + 1) % 3, (axis + 2) % 3].map(|o| o * 2 + a[o]);
    // rust: if toward[f] == toward[g] {
    // rust: continue;
}
    // rust: let (p, q) = (corner(*a), corner(b));
    // rust: let normal = (q - p).cross(light);
    // rust: if normal.length_squared() < 1e-12 {
    // rust: continue;
}
    // rust: let normal = normal.normalize();
    // rust: let side = if normal.dot(centre - p) < 0.0 {
    // rust: -1.0
    // rust: } else {
    // rust: 1.0
}
            // At most six such edges with at most four faces toward the light: 12 planes.
    // rust: if let Some(plane) = planes.get_mut(n) {
    // rust: *plane = (normal * side).extend(-normal.dot(p) * side);
    // rust: n += 1;
}
}
}
    // rust: let [a, b] = [0, 6].map(|i| Frustum {
    // rust: planes: planes[i..i + 6].try_into().expect("six planes"),
    // rust: });
    // rust: [a, b]
}
pub fn frustum(m: Mat4) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = |i| m.row(i);
    // rust: let planes = [
    // rust: r(3) + r(0),
    // rust: r(3) - r(0),
    // rust: r(3) + r(1),
    // rust: r(3) - r(1),
    // rust: r(2),
    // rust: r(3) - r(2),
    // rust: ];
    // rust: planes.map(|p| p / p.truncate().length())
}

    // rust: mod tests {
pub fn opaque_gizmo_lines_upload_first_for_the_depth_writing_pipeline() void {
}
    // rust: let line = |argb: u32| [0.0, 0.0, 0.0, 1.0, 0.0, 0.0, f32::from_bits(argb), 2.5];
        // A hitbox's white, the chunk border's outer red columns (alpha 0x7F),
        // and the chunk border's yellow.
    // rust: let lines = [line(0xFFFF_FFFF), line(0x7FFF_0000), line(0xFFFF_FF00)];
    // rust: assert!(super::debug_line_opaque(&lines[0]));
    // rust: assert!(!super::debug_line_opaque(&lines[1]));
    // rust: assert!(!super::debug_line_opaque(&line(0xFE00_0000)));
    // rust: let order: Vec<u32> = super::debug_lines_opaque_first(&lines)
    // rust: .map(|l| l[6].to_bits())
    // rust: .collect();
    // rust: assert_eq!(order, [0xFFFF_FFFF, 0xFFFF_FF00, 0x7FFF_0000]);
}
//     use crate::gfx::static_entity_shader;

pub fn adapter(device_type: wgpu::DeviceType) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: wgpu::AdapterInfo {
    // rust: name: "test adapter".into(),
    // rust: vendor: 0,
    // rust: device: 0,
    // rust: device_type,
    // rust: device_pci_bus_id: String::new(),
    // rust: driver: String::new(),
    // rust: driver_info: String::new(),
    // rust: backend: wgpu::Backend::Vulkan,
    // rust: subgroup_min_size: 0,
    // rust: subgroup_max_size: 0,
    // rust: transient_saves_memory: None,
    // rust: limit_bucket: None,
}
}

pub fn software_occlusion_culling_is_opt_in() void {
}
    // rust: let cpu = adapter(wgpu::DeviceType::Cpu);
    // rust: let discrete = adapter(wgpu::DeviceType::DiscreteGpu);
    // rust: assert!(!super::occlusion_culling_requested(&cpu, None));
    // rust: assert!(super::occlusion_culling_requested(&discrete, None));
    // rust: assert!(super::occlusion_culling_requested(&cpu, Some("all")));
    // rust: assert!(!super::occlusion_culling_requested(&discrete, Some("0")));
}

    /// Translucent Batching is offered with indirect multi-draws that aren't OpenGL's, flat
    /// frames (Metal, Intel Gen11/Gen12 on Vulkan) included.
pub fn translucent_batching_is_offered_with_indirect_multi_draws_except_on_opengl() void {
}
    // rust: let vulkan = adapter(wgpu::DeviceType::DiscreteGpu);
    // rust: let mut metal = adapter(wgpu::DeviceType::IntegratedGpu);
    // rust: metal.backend = wgpu::Backend::Metal;
    // rust: let mut gl = adapter(wgpu::DeviceType::DiscreteGpu);
    // rust: gl.backend = wgpu::Backend::Gl;
    // rust: let batchable = super::translucent_batchable;
    // rust: assert!(batchable(&vulkan, true));
    // rust: assert!(batchable(&metal, true));
    // rust: assert!(!batchable(&vulkan, false));
    // rust: assert!(!batchable(&gl, true));
}

    /// GPU culling is offered where the device draws counts the GPU wrote and runs compute
    /// shaders with storage buffers enough, where Translucent Batching is (indirect
    /// multi-draws that aren't OpenGL's) and vanilla frames are never drawn flat, and never
    /// on Intel Gen11/Gen12's Vulkan driver, whose draws read instance-rate origins from the
    /// wrong first instance, even with flat draws off there, nor on DX12 with flat page
    /// groups, whose count draws leave the base vertex out of the pulled pipelines'
    /// `vertex_index`.
pub fn gpu_culling_is_offered_where_counts_are_drawn_and_vanilla_never_draws_flat() void {
}
    // rust: let vulkan = adapter(wgpu::DeviceType::DiscreteGpu);
    // rust: let mut gl = adapter(wgpu::DeviceType::DiscreteGpu);
    // rust: gl.backend = wgpu::Backend::Gl;
    // rust: let mut dx12 = adapter(wgpu::DeviceType::DiscreteGpu);
    // rust: dx12.backend = wgpu::Backend::Dx12;
    // rust: let mut intel = adapter(wgpu::DeviceType::IntegratedGpu);
    // rust: (intel.vendor, intel.device) = (0x8086, 0x9a49); // Tiger Lake
    // rust: let counts = wgpu::Features::MULTI_DRAW_INDIRECT_COUNT;
    // rust: let compute = wgpu::DownlevelFlags::COMPUTE_SHADERS;
    // rust: let storage = |buffers| wgpu::Limits {
    // rust: max_storage_buffers_per_shader_stage: buffers,
    // rust: ..Default::default()
}
    // rust: let offered = |info, features, downlevel, buffers, multi_draw, flat| {
    // rust: super::gpu_culling::supported(
    // rust: info,
    // rust: features,
    // rust: downlevel,
    // rust: &storage(buffers),
    // rust: multi_draw,
    // rust: flat,
    // rust: )
}
        // No flat draws, or flat draws for a shader pack's terrain alone.
    // rust: assert!(offered(&vulkan, counts, compute, 8, true, None));
    // rust: assert!(offered(&vulkan, counts, compute, 8, true, Some(usize::MAX)));
        // Vanilla frames drawn flat past MIN_SECTIONS (Metal), or all of them.
    // rust: let min = super::flat::MIN_SECTIONS;
    // rust: assert!(!offered(&vulkan, counts, compute, 8, true, Some(min)));
    // rust: assert!(!offered(&vulkan, counts, compute, 8, true, Some(0)));
    // rust: let none = wgpu::Features::empty();
    // rust: assert!(!offered(&vulkan, none, compute, 8, true, None));
    // rust: let no_compute = wgpu::DownlevelFlags::empty();
    // rust: assert!(!offered(&vulkan, counts, no_compute, 8, true, None));
    // rust: assert!(!offered(&vulkan, counts, compute, 7, true, None));
    // rust: assert!(!offered(&vulkan, counts, compute, 8, false, None));
    // rust: assert!(!offered(&gl, counts, compute, 8, true, None));
    // rust: assert!(!offered(&intel, counts, compute, 8, true, None));
    // rust: assert!(offered(&dx12, counts, compute, 8, true, None));
    // rust: assert!(!offered(&dx12, counts, compute, 8, true, Some(usize::MAX)));
        // The settings offer it there, but not on a software adapter (WARP, lavapipe),
        // whose pass would run on the CPU, and they say why not on DX12 with flat page groups.
//         use crate::graphics::GpuCullingOffer as O;
    // rust: let offer = super::gpu_culling::offer;
    // rust: assert_eq!(offer(&vulkan, true, true), O::Offered);
    // rust: assert_eq!(
    // rust: offer(&adapter(wgpu::DeviceType::IntegratedGpu), true, false),
    // rust: O::Offered
    // rust: );
    // rust: assert_eq!(
    // rust: offer(&adapter(wgpu::DeviceType::Cpu), true, false),
    // rust: O::Software
    // rust: );
    // rust: assert_eq!(offer(&vulkan, false, false), O::Unsupported);
    // rust: assert_eq!(
    // rust: offer(&adapter(wgpu::DeviceType::Cpu), false, false),
    // rust: O::Unsupported
    // rust: );
    // rust: assert_eq!(offer(&dx12, true, false), O::Offered);
    // rust: assert_eq!(offer(&dx12, false, true), O::Dx12);
}

    /// The pack-flat rule: with Translucent Batching translucent quads have an arena of
    /// their own, unless a shader pack's terrain programs or its shadow pass alone can
    /// draw flat (a pack picked and not loaded yet counts as drawing terrain).
pub fn translucent_quads_stay_in_the_section_arena_while_a_pack_can_draw_flat() void {
}
        // (batching, flat draws, the pack's terrain, its shadow pass)
    // rust: let split = super::translucent_split;
    // rust: assert!(split(true, true, false, false));
    // rust: assert!(!split(true, true, true, false));
    // rust: assert!(!split(true, true, false, true));
    // rust: assert!(!split(true, true, true, true));
        // Without flat draws, or with them off, the pack draws per section, from either.
    // rust: assert!(split(true, false, true, true));
    // rust: assert!(!split(false, true, false, false));
    // rust: assert!(!split(false, false, false, false));
}

    /// No large translucent page starts to shrink until `SHRINK_SETTLE` after terrain
    /// last arrived, nor in a frame `compact_arena` copied in; terrain arriving after
    /// a try that found no room does not cut its `SHRINK_RETRY` short. Only starts
    /// wait: a move under way finishes, or its page would stay closed while the new
    /// one fills.
pub fn shrinking_starts_once_terrain_has_settled() void {
}
//         use super::{COMPACT_BUDGET, SHRINK_RETRY, SHRINK_SETTLE, ShrinkGate};
//         use std::time::{Duration, Instant};
    // rust: let (now, ms) = (Instant::now(), Duration::from_millis(1));
    // rust: let mut gate = ShrinkGate::default();
    // rust: assert!(gate.may_start(now, COMPACT_BUDGET));
    // rust: assert!(!gate.may_start(now, COMPACT_BUDGET - 1));
    // rust: gate.wait(now, SHRINK_SETTLE);
    // rust: assert!(!gate.may_start(now + SHRINK_SETTLE - ms, COMPACT_BUDGET));
    // rust: assert!(gate.may_start(now + SHRINK_SETTLE, COMPACT_BUDGET));
    // rust: gate.wait(now, SHRINK_RETRY);
    // rust: gate.wait(now + ms, SHRINK_SETTLE);
    // rust: assert!(!gate.may_start(now + SHRINK_RETRY - ms, COMPACT_BUDGET));
    // rust: assert!(gate.may_start(now + SHRINK_RETRY, COMPACT_BUDGET));
}

pub fn the_mirror_sees_each_point_where_its_reflection_is() void {
}
//         use glam::{Mat4, Vec3, Vec4};
    // rust: let view_proj = super::world_projection(70.0, 1.5, 512.0)
    // rust: * Mat4::look_to_rh(Vec3::ZERO, Vec3::new(0.3, -0.4, -1.0), Vec3::Y);
    // rust: let plane = -3.25;
    // rust: let mirror = super::mirror_view_projection(view_proj, plane);
    // rust: for p in [Vec3::new(1.0, 2.0, -9.0), Vec3::new(-4.0, -1.5, -20.0)] {
    // rust: let reflected = Vec3::new(p.x, 2.0 * plane - p.y, p.z);
    // rust: let a = mirror * Vec4::from((p, 1.0));
    // rust: let b = view_proj * Vec4::from((reflected, 1.0));
    // rust: assert!((a - b).abs().max_element() < 1e-4, "{a} {b}");
}
}
pub fn the_mirrors_sky_rays_are_the_cameras_reflected() void {
}
//         use glam::{Mat4, Vec3, Vec4};
        // A camera looking down: its mirror looks up, by as much.
    // rust: let forward = Vec3::new(0.3, -0.64, -1.0).normalize();
    // rust: let view = Mat4::look_to_rh(Vec3::ZERO, forward, Vec3::Y);
    // rust: let mirrored = super::mirror_inverse_view(view.inverse().to_cols_array_2d(), -3.25);
    // rust: let ray = Mat4::from_cols_array_2d(&mirrored) * Vec4::new(0.0, 0.0, -1.0, 0.0);
    // rust: let reflected = Vec3::new(forward.x, -forward.y, forward.z);
    // rust: assert!((ray.truncate() - reflected).length() < 1e-5, "{ray}");
        // The view's origin, the camera, goes to the mirror's eye.
    // rust: let eye = Mat4::from_cols_array_2d(&mirrored) * Vec4::W;
    // rust: assert!(
    // rust: (eye.truncate() - Vec3::new(0.0, -6.5, 0.0)).length() < 1e-5,
    // rust: "{eye}"
    // rust: );
}
pub fn scaled_screenshots_follow_resolution_scale_and_quality_within_limits() void {
}
//         use super::scaled_screenshot_factor as factor;
    // rust: let big = u64::MAX / 2;
        // The window's size at 100% and 1x; Resolution Scale below 100% stays the window's.
    // rust: assert_eq!(factor([1920, 1080], 1.0, 1, 16384, big), 1.0);
    // rust: assert_eq!(factor([1920, 1080], 0.5, 1, 16384, big), 1.0);
        // The game's resolution, times the quality.
    // rust: assert_eq!(factor([1920, 1080], 2.0, 1, 16384, big), 2.0);
    // rust: assert_eq!(factor([1920, 1080], 1.5, 4, 16384, big), 6.0);
    // rust: assert_eq!(factor([1920, 1080], 0.5, 8, 16384, big), 8.0);
        // Cut to the largest texture side: 3840 * 4.266 = 16384.
    // rust: let f = factor([3840, 2160], 1.0, 8, 16384, big);
    // rust: assert!(
    // rust: (3840.0 * f) as u32 <= 16384 && (3840.0 * f) as u32 > 16300,
    // rust: "{f}"
    // rust: );
        // Cut to the largest buffer: 256 MiB holds about 3.8x of 1080p's readback.
    // rust: let max = 256 << 20;
    // rust: let f = factor([1920, 1080], 1.0, 8, 16384, max);
    // rust: let [w, h] = [1920, 1080].map(|s| (s as f32 * f) as u32);
    // rust: assert!(u64::from(super::padded_row(w)) * u64::from(h) <= max, "{f}");
    // rust: assert!(f > 3.7, "{f}");
}
pub fn drawable_size_skips_minimized_and_oversized_windows() void {
}
//         use super::drawable_size;
    // rust: assert!(drawable_size(1280, 720, 8192));
    // rust: assert!(drawable_size(1, 1, 8192));
    // rust: assert!(drawable_size(8192, 8192, 8192));
        // Minimized.
    // rust: assert!(!drawable_size(0, 720, 8192));
    // rust: assert!(!drawable_size(1280, 0, 8192));
    // rust: assert!(!drawable_size(0, 0, 8192));
        // One past the device's largest texture.
    // rust: assert!(!drawable_size(8193, 720, 8192));
    // rust: assert!(!drawable_size(1280, 8193, 8192));
        // The crash: a window `SetWindowPos` made 65535 pixels tall, on an RTX 5080 (32768).
    // rust: assert!(!drawable_size(984, 65496, 32768));
    // rust: assert!(!drawable_size(984, u32::MAX, 32768));
}

pub fn a_reported_black_level_rounds_down() void {
}
//         use super::hundredths_of_a_nit as h;
    // rust: assert_eq!(h(0.005), 0);
    // rust: assert_eq!(h(0.05), 5);
    // rust: assert_eq!(h(5.0), 100);
    // rust: assert_eq!(h(f32::NAN), 0);
}
pub fn os_luminances_become_auto_values() void {
}
//         use super::os_reported;
//         use crate::graphics::Reported;
    // rust: let info = |max, white| wgpu::DisplayHdrInfo {
    // rust: luminance: Some(wgpu::DisplayLuminance {
    // rust: max_nits: max,
    // rust: sdr_white_nits: white,
    // rust: ..Default::default()
    // rust: }),
    // rust: ..Default::default()
}
        // Windows' SDR content brightness slider runs 80..480 nits.
    // rust: assert_eq!(
    // rust: os_reported(&info(Some(998.4), Some(240.0))),
    // rust: Some(Reported {
    // rust: paper_white: 240,
    // rust: peak: 998,
    // rust: black: 0
    // rust: })
    // rust: );
    // rust: assert_eq!(
    // rust: os_reported(&info(Some(120.0), Some(1000.0))),
    // rust: Some(Reported {
    // rust: paper_white: 480,
    // rust: peak: 480,
    // rust: black: 0
    // rust: })
    // rust: );
        // White above the calibrated peak (a Samsung QD-OLED's 380, the slider at 456).
    // rust: assert_eq!(
    // rust: os_reported(&info(Some(380.0), Some(456.0))),
    // rust: Some(Reported {
    // rust: paper_white: 456,
    // rust: peak: 456,
    // rust: black: 0
    // rust: })
    // rust: );
    // rust: assert_eq!(os_reported(&info(Some(1000.0), None)), None);
    // rust: assert_eq!(os_reported(&info(Some(f32::NAN), Some(80.0))), None);
    // rust: assert_eq!(os_reported(&wgpu::DisplayHdrInfo::default()), None);
}
pub fn surface_is_8_bit_and_not_srgb() void {
}
//         use super::surface_format;
//         use wgpu::TextureFormat::{Bgra8Unorm, Bgra8UnormSrgb, Rgba8Unorm, Rgba16Float};
        // RADV's Wayland surfaces list the linear fp16 format first; choosing it makes the
        // compositor read gamma-encoded values as linear light.
    // rust: assert_eq!(
    // rust: surface_format(&[Rgba16Float, Bgra8UnormSrgb, Bgra8Unorm], Bgra8UnormSrgb),
    // rust: Bgra8Unorm
    // rust: );
    // rust: assert_eq!(
    // rust: surface_format(&[Bgra8UnormSrgb, Rgba8Unorm], Bgra8UnormSrgb),
    // rust: Rgba8Unorm
    // rust: );
    // rust: assert_eq!(surface_format(&[Rgba16Float], Bgra8UnormSrgb), Rgba16Float);
}
    /// A Wayland surface on a compositor with colour management, as wgpu lists it (Mesa 26.2
    /// ANV on an Intel HD 620 under weston 16): wide formats first. The pre-#1075 choice,
    /// the first non-sRGB format, took `Rgba16Float` and the window looked washed out, as if
    /// under a white overlay (#1007); XWayland lists no such format, which is why it looked fine.
pub fn a_colour_managed_wayland_surface_still_gets_8_bit() void {
}
//         use super::surface_format;
//         use wgpu::TextureFormat::*;
    // rust: let wayland = [
    // rust: Rgba16Float,
    // rust: Rgba16Unorm,
    // rust: Rgb10a2Unorm,
    // rust: Bgra8UnormSrgb,
    // rust: Bgra8Unorm,
    // rust: Rgba8UnormSrgb,
    // rust: Rgba8Unorm,
    // rust: ];
    // rust: assert_eq!(surface_format(&wayland, Bgra8UnormSrgb), Bgra8Unorm);
        // Without Bgra8: Rgba8, still not a 16- or 10-bit format.
    // rust: let without_bgra = [
    // rust: Rgba16Float,
    // rust: Rgba16Unorm,
    // rust: Rgb10a2Unorm,
    // rust: Rgba8UnormSrgb,
    // rust: Rgba8Unorm,
    // rust: ];
    // rust: assert_eq!(surface_format(&without_bgra, Rgba8UnormSrgb), Rgba8Unorm);
}
    /// The 16-bit frame only with HDR on, Smooth Gradients on, an HDR surface and a device
    /// that draws it; in every other case the swapchain's 8-bit format, as before it existed.
pub fn the_frame_is_16_bit_only_with_hdr_and_a_device_that_draws_it() void {
}
//         use super::frame_format;
//         use wgpu::TextureFormat::{Bgra8Unorm, Bgra8UnormSrgb, Rgba8Unorm, Rgba16Unorm};
    // rust: assert_eq!(frame_format(true, true, true, Bgra8Unorm), Rgba16Unorm);
    // rust: for (wide_frame, hdr_offered, draws) in [
    // rust: (false, true, true),
    // rust: (true, false, true),
    // rust: (true, true, false),
    // rust: (false, false, false),
    // rust: ] {
    // rust: assert_eq!(
    // rust: frame_format(wide_frame, hdr_offered, draws, Bgra8UnormSrgb),
    // rust: Bgra8Unorm
    // rust: );
    // rust: assert_eq!(
    // rust: frame_format(wide_frame, hdr_offered, draws, Rgba8Unorm),
    // rust: Rgba8Unorm
    // rust: );
}
}
    /// What `draws_wide_frame` needs of a device: both features, and the usages and flags
    /// every pass takes of the frame. Missing any one of them keeps the 8-bit frame.
pub fn the_16_bit_frame_needs_every_usage_and_flag_the_passes_take() void {
}
//         use super::draws_wide_frame;
//         use wgpu::{Features as F, TextureFormatFeatureFlags as Fl, TextureUsages as U};
    // rust: let features = F::TEXTURE_FORMAT_16BIT_NORM | F::TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES;
    // rust: let usages = U::RENDER_ATTACHMENT | U::TEXTURE_BINDING | U::COPY_SRC | U::COPY_DST;
    // rust: let flags = Fl::BLENDABLE | Fl::FILTERABLE;
    // rust: let format = |allowed_usages, flags| wgpu::TextureFormatFeatures {
    // rust: allowed_usages,
    // rust: flags,
}
        // A desktop GPU: all of it, and more.
    // rust: assert!(draws_wide_frame(
    // rust: features | F::FLOAT32_FILTERABLE,
    // rust: format(usages | U::STORAGE_BINDING, flags | Fl::MULTISAMPLE_X4),
    // rust: ));
    // rust: assert!(!draws_wide_frame(
    // rust: F::TEXTURE_FORMAT_16BIT_NORM,
    // rust: format(usages, flags)
    // rust: ));
    // rust: assert!(!draws_wide_frame(
    // rust: F::TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES,
    // rust: format(usages, flags)
    // rust: ));
        // A downlevel device reports no usages at all for a format it lacks.
    // rust: assert!(!draws_wide_frame(
    // rust: F::empty(),
    // rust: format(U::empty(), Fl::empty())
    // rust: ));
    // rust: for usage in [
    // rust: U::RENDER_ATTACHMENT,
    // rust: U::TEXTURE_BINDING,
    // rust: U::COPY_SRC,
    // rust: U::COPY_DST,
    // rust: ] {
    // rust: assert!(!draws_wide_frame(features, format(usages - usage, flags)));
}
    // rust: for flag in [Fl::BLENDABLE, Fl::FILTERABLE] {
    // rust: assert!(!draws_wide_frame(features, format(usages, flags - flag)));
}
}
pub fn special_material_batches_preserve_quad_order_and_offsets() void {
}
    // rust: let quad = |layer, id| {
    // rust: [super::Vertex {
    // rust: pos: [0.0; 3],
    // rust: uv: [0.0; 2],
    // rust: layer,
    // rust: color: 0xffff_ffff,
    // rust: light: id,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0, 0.0],
    // rust: }; 4]
}
    // rust: let entities: Vec<_> = [
    // rust: (0, 0),
    // rust: (14, 9),
    // rust: (4, 1),
    // rust: (11, 2),
    // rust: (15, 10),
    // rust: (7, 3),
    // rust: (35, 11),
    // rust: (4, 4),
    // rust: (12, 7),
    // rust: ]
    // rust: .into_iter()
    // rust: .flat_map(|(layer, id)| quad(layer, id))
    // rust: .collect();
    // rust: let mut batch = super::EntityBatch::default();
    // rust: let counts = batch.update(&entities, &quad(3, 5), &quad(0, 6), &quad(0, 8), false);
    // rust: let vertices = &batch.combined;
    // rust: assert_eq!(counts, [4, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0]);
    // rust: assert_eq!(
    // rust: vertices
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|q| q[0].light)
    // rust: .collect::<Vec<_>>(),
    // rust: [0, 1, 3, 4, 11, 2, 7, 9, 10, 5, 6, 8]
    // rust: );
}
pub fn software_adapters_are_last_resort() void {
}
//         use super::is_software;
    // rust: assert!(is_software(wgpu::DeviceType::Cpu));
    // rust: assert!(!is_software(wgpu::DeviceType::DiscreteGpu));
    // rust: assert!(!is_software(wgpu::DeviceType::IntegratedGpu));
    // rust: assert!(!is_software(wgpu::DeviceType::VirtualGpu));
}
pub fn auto_uses_directx_12_first_on_windows_arm64() void {
}
//         use super::{GraphicsApi, backend_order};
//         use wgpu::Backends;
    // rust: let order = |api, os, arch| backend_order(api, os, arch, false);
    // rust: assert_eq!(
    // rust: order(GraphicsApi::Auto, "windows", "x86_64"),
    // rust: [Backends::VULKAN, Backends::DX12, Backends::GL]
    // rust: );
    // rust: assert_eq!(
    // rust: order(GraphicsApi::Auto, "windows", "aarch64"),
    // rust: [Backends::DX12, Backends::VULKAN, Backends::GL]
    // rust: );
    // rust: assert_eq!(
    // rust: order(GraphicsApi::Vulkan, "windows", "aarch64"),
    // rust: [Backends::VULKAN]
    // rust: );
    // rust: assert_eq!(
    // rust: order(GraphicsApi::Dx12, "windows", "aarch64"),
    // rust: [Backends::DX12]
    // rust: );
    // rust: assert_eq!(
    // rust: order(GraphicsApi::OpenGl, "windows", "aarch64"),
    // rust: [Backends::GL]
    // rust: );
    // rust: assert_eq!(
    // rust: order(GraphicsApi::Auto, "linux", "x86_64"),
    // rust: [Backends::VULKAN, Backends::GL]
    // rust: );
    // rust: assert_eq!(
    // rust: order(GraphicsApi::Dx12, "linux", "x86_64"),
    // rust: [Backends::VULKAN]
    // rust: );
    // rust: assert_eq!(
    // rust: order(GraphicsApi::OpenGl, "linux", "x86_64"),
    // rust: [Backends::GL]
    // rust: );
        // WGPU_BACKEND picks the backends itself; macOS has Metal only.
    // rust: for api in GraphicsApi::ALL {
    // rust: assert_eq!(
    // rust: backend_order(api, "windows", "aarch64", true),
    // rust: [Backends::default()]
    // rust: );
    // rust: assert_eq!(order(api, "macos", "aarch64"), [Backends::default()]);
}
}
pub fn a_chosen_api_without_a_gpu_tries_the_others_before_software() void {
}
//         use super::{GraphicsApi, device_search};
//         use wgpu::Backends;
    // rust: let (v, d, g) = (Backends::VULKAN, Backends::DX12, Backends::GL);
    // rust: let search = |api, os, arch| device_search(api, os, arch, false);
        // #5185: DirectX 12 chosen on an Intel HD 2500 (WARP only): OpenGL's GPU before WARP.
    // rust: assert_eq!(
    // rust: search(GraphicsApi::Dx12, "windows", "x86_64"),
    // rust: [(vec![d], false), (vec![g], false), (vec![d], true)]
    // rust: );
    // rust: assert_eq!(
    // rust: search(GraphicsApi::Vulkan, "windows", "x86_64"),
    // rust: [(vec![v], false), (vec![d, g], false), (vec![v], true)]
    // rust: );
    // rust: assert_eq!(
    // rust: search(GraphicsApi::Auto, "windows", "x86_64"),
    // rust: [(vec![v, d, g], false), (vec![v, d, g], true)]
    // rust: );
    // rust: assert_eq!(
    // rust: search(GraphicsApi::Auto, "windows", "aarch64"),
    // rust: [(vec![d, v, g], false), (vec![d, v, g], true)]
    // rust: );
    // rust: assert_eq!(
    // rust: search(GraphicsApi::OpenGl, "linux", "x86_64"),
    // rust: [(vec![g], false), (vec![v], false), (vec![g], true)]
    // rust: );
        // WGPU_BACKEND and macOS: one set of backends, nothing else to try.
    // rust: let all = Backends::default();
    // rust: for (os, env) in [("windows", true), ("macos", false)] {
    // rust: assert_eq!(
    // rust: device_search(GraphicsApi::Vulkan, os, "x86_64", env),
    // rust: [(vec![all], false), (vec![all], true)]
    // rust: );
}
}
    /// The second try at a backend shows the adapters wgpu hides for reporting
    /// no Vulkan conformance version (Mesa's hasvk, which drives Ivy Bridge and
    /// Haswell, reports 0.0.0.0 and works).
pub fn the_second_try_at_a_backend_shows_nonconformant_adapters() void {
}
    // rust: let shown = |allow| {
    // rust: super::instance_descriptor(wgpu::Backends::VULKAN, None, allow)
    // rust: .flags
    // rust: .contains(wgpu::InstanceFlags::ALLOW_UNDERLYING_NONCOMPLIANT_ADAPTER)
}
    // rust: assert!(shown(true));
        // The first try keeps wgpu's own filtering, unless `with_env` turns the
        // flag on from the environment (WGPU_ALLOW_UNDERLYING_NONCOMPLIANT_ADAPTER).
    // rust: if std::env::var_os("WGPU_ALLOW_UNDERLYING_NONCOMPLIANT_ADAPTER").is_none() {
    // rust: assert!(!shown(false));
}
}
    /// Every WGSL shader file translates to HLSL as wgpu's DirectX 12 backend
    /// writes it for FXC (shader model 5.1), entry point by entry point, and
    /// every shader the OpenGL backend runs also translates to GLSL.
pub fn shaders_translate_to_hlsl_for_directx_12_and_glsl_for_opengl() void {
}
pub fn wgsl_files(dir: *std::path::Path, out: *mut std.ArrayList(std::path::PathBuf)) void {
}
    // rust: for entry in std::fs::read_dir(dir).unwrap() {
    // rust: let path = entry.unwrap().path();
    // rust: if path.is_dir() {
    // rust: wgsl_files(&path, out);
    // rust: } else if path.extension().is_some_and(|e| e == "wgsl") {
    // rust: out.push(path);
}
}
}
    // rust: let mut files = Vec::new();
    // rust: wgsl_files(
    // rust: std::path::Path::new(concat!(env!("CARGO_MANIFEST_DIR"), "/src")),
    // rust: &mut files,
    // rust: );
    // rust: assert!(files.len() >= 10, "{files:?}");
        // Improved transparency's files are appended to terrain.wgsl and entity.wgsl.
    // rust: let mut sources: Vec<(std::path::PathBuf, String)> = Vec::new();
    // rust: for path in files {
    // rust: let text = std::fs::read_to_string(&path).unwrap();
    // rust: let name = path.file_name().and_then(|n| n.to_str()).unwrap_or("");
    // rust: if name == "oit.wgsl" || name == "gpu_occlusion.wgsl" {
                // The shared maths: it needs the file it is appended to. GPU culling's
                // occlusion test is appended to gpu_culling.wgsl, on Vulkan alone.
    // rust: continue;
    // rust: } else if name == "oit_world.wgsl" {
    // rust: let base = include_str!("terrain.wgsl").to_owned() + include_str!("oit.wgsl");
    // rust: sources.push((path, base + &text));
    // rust: } else if name == "oit_features.wgsl" {
    // rust: let base = super::entity_shader() + include_str!("oit.wgsl");
    // rust: sources.push((path, base + &text));
    // rust: } else if name == "static_entity.wgsl" {
    // rust: sources.push((path, static_entity_shader()));
    // rust: } else if name == "visbuffer.wgsl" {
                // Appended to terrain.wgsl (gfx/visbuffer.rs).
    // rust: sources.push((path, include_str!("terrain.wgsl").to_owned() + &text));
    // rust: } else if name == "oit_border.wgsl" {
    // rust: let base = include_str!("border.wgsl").to_owned() + include_str!("oit.wgsl");
    // rust: sources.push((path, base + &text));
    // rust: } else if name == "oit_clouds.wgsl" {
    // rust: let base = super::entity_shader() + include_str!("oit.wgsl");
    // rust: sources.push((path, base + &text));
    // rust: } else {
    // rust: sources.push((path, text));
}
}
    // rust: let mut glsl_checked = 0;
        // Shaders the OpenGL backend runs must translate: skipping the ones
        // that fail hides exactly the bug where a shader GL needs cannot
        // compile (#9448).
    // rust: let mut glsl_failed = Vec::new();
    // rust: let mut translated = std::collections::HashSet::new();
        // naga's GLSL writer gives an image one sampler, and the HUD's glint
        // samples one image through two; one failed entry does not hide the rest.
    // rust: let known_unsupported = [("hud.wgsl", "fs_cit_glint")];
    // rust: for (path, text) in sources {
            // entity.wgsl comes after the overlay's constants (entity_shader).
    // rust: let module = naga::front::wgsl::parse_str(&text)
    // rust: .or_else(|_| {
    // rust: naga::front::wgsl::parse_str(&(crate::overlay::wgsl_constants() + &text))
    // rust: })
    // rust: .unwrap_or_else(|e| panic!("{}: {e}", path.display()));
    // rust: let info = naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap_or_else(|e| panic!("{}: {e:?}", path.display()));
            // A select between integer vectors on a vector of bools becomes GLSL's
            // mix(uvec3, uvec3, bvec3) (GLSL 4.5 or EXT_shader_integer_mix). Old AMD OpenGL
            // drivers (Radeon HD 7400M, driver 15.301) pick the float overload and refuse to
            // compile the terrain shader (#9892). Scalar selects become `?:` and work everywhere.
    // rust: let functions = module
    // rust: .functions
    // rust: .iter()
    // rust: .map(|(handle, f)| (f, &info[handle]))
    // rust: .chain(
    // rust: module
    // rust: .entry_points
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, e)| (&e.function, info.get_entry_point(i))),
    // rust: );
    // rust: for (function, function_info) in functions {
    // rust: for (handle, expression) in function.expressions.iter() {
    // rust: let naga::Expression::Select {
    // rust: condition, accept, ..
    // rust: } = *expression
    // rust: else {
    // rust: continue;
}
    // rust: let vector_of = |h: naga::Handle<naga::Expression>| match *function_info[h]
    // rust: .ty
    // rust: .inner_with(&module.types)
    // rust: {
    // rust: naga::TypeInner::Vector { scalar, .. } => Some(scalar.kind),
    // rust: _ => None,
}
    // rust: assert!(
    // rust: vector_of(condition).is_none()
    // rust: || !matches!(
    // rust: vector_of(accept),
    // rust: Some(naga::ScalarKind::Uint | naga::ScalarKind::Sint)
    // rust: ),
    // rust: "{} {:?}: select between integer vectors ({handle:?}): use scalar selects",
    // rust: path.display(),
    // rust: function.name
    // rust: );
}
}
    // rust: for entry in &module.entry_points {
    // rust: let (module, info) = naga::back::pipeline_constants::process_overrides(
    // rust: &module,
    // rust: &info,
    // rust: Some((entry.stage, &entry.name)),
    // rust: &Default::default(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut hlsl = String::new();
    // rust: naga::back::hlsl::Writer::new(
    // rust: &mut hlsl,
    // rust: &naga::back::hlsl::Options::default(),
    // rust: &naga::back::hlsl::PipelineOptions {
    // rust: entry_point: Some((entry.stage, entry.name.clone())),
    // rust: },
    // rust: )
    // rust: .write(&module, &info, None)
    // rust: .unwrap_or_else(|e| panic!("{} {}: {e}", path.display(), entry.name));
    // rust: assert!(!hlsl.is_empty());
                // OpenGL below 4.3 lacks ARB_arrays_of_arrays (#6267): no nested array may reach it.
                // Compute and storage-buffer shaders (culling, frame generation) never run on GL.
    // rust: if entry.stage == naga::ShaderStage::Compute
    // rust: || text.contains("var<storage")
    // rust: || text.contains("var<workgroup>")
    // rust: {
    // rust: continue;
}
    // rust: for version in [330, 400] {
    // rust: let mut glsl = String::new();
    // rust: let glsl_result = naga::back::glsl::Writer::new(
    // rust: &mut glsl,
    // rust: &module,
    // rust: &info,
    // rust: &naga::back::glsl::Options {
    // rust: version: naga::back::glsl::Version::Desktop(version),
    // rust: ..Default::default()
    // rust: },
    // rust: &naga::back::glsl::PipelineOptions {
    // rust: shader_stage: entry.stage,
    // rust: entry_point: entry.name.clone(),
    // rust: multiview: None,
    // rust: },
    // rust: Default::default(),
    // rust: )
    // rust: .and_then(|mut w| w.write());
    // rust: let name = path.file_name().and_then(|n| n.to_str()).unwrap_or("");
    // rust: if let Err(e) = glsl_result {
    // rust: if !known_unsupported.contains(&(name, entry.name.as_str())) {
    // rust: glsl_failed.push(format!(
    // rust: "{} {} (GLSL {version}): {e}",
    // rust: path.display(),
    // rust: entry.name
    // rust: ));
}
    // rust: continue;
}
    // rust: translated.insert((name.to_owned(), entry.name.clone()));
    // rust: glsl_checked += 1;
    // rust: assert!(
    // rust: !glsl.contains("ARB_arrays_of_arrays"),
    // rust: "{} {} needs ARB_arrays_of_arrays on GLSL {version}",
    // rust: path.display(),
    // rust: entry.name
    // rust: );
}
}
}
    // rust: assert!(
    // rust: glsl_failed.is_empty(),
    // rust: "shaders the OpenGL backend runs must translate:\n{}",
    // rust: glsl_failed.join("\n")
    // rust: );
        // These read the world's depth through `textureLoad`; before #9448 their
        // depth binding could not translate, so TAA and the blit never came up.
    // rust: for (file, entry) in [("world_post.wgsl", "fs_taa"), ("pack_post.wgsl", "fs_blit")] {
    // rust: assert!(
    // rust: translated.contains(&(file.to_owned(), entry.to_owned())),
    // rust: "{file} {entry} must translate to GLSL"
    // rust: );
}
    // rust: assert!(glsl_checked >= 10, "{glsl_checked} GLSL translations");
}
pub fn gl_sprite_arrays_are_neither_2d_textures_nor_cube_maps() void {
}
    // rust: for (count, gl) in [(1, 2), (2, 2), (5, 5), (6, 7), (12, 13), (2048, 2048)] {
    // rust: assert_eq!(super::array_layers(count, true), gl);
    // rust: assert_eq!(super::array_layers(count, false), count);
}
}
pub fn entity_shader_validates_with_its_overlay_constants() void {
}
    // rust: let module = naga::front::wgsl::parse_str(&super::entity_shader()).unwrap();
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap();
}
pub fn chunk_fade_is_vanillas_get_visibility() void {
}
//         use super::{chunk_visibility, fade_millis};
    // rust: assert_eq!(fade_millis(0.75), 750);
    // rust: assert_eq!(fade_millis(0.0), 0);
    // rust: assert_eq!(chunk_visibility(0, 750), 0.0_f32);
    // rust: assert_eq!(chunk_visibility(375, 750), 0.5);
    // rust: assert_eq!(chunk_visibility(750, 750), 1.0);
    // rust: assert_eq!(chunk_visibility(0, 0), 1.0, "Off: whole at once");
    // rust: assert_eq!(chunk_visibility(u64::MAX, 750), 1.0);
}
    /// Iris 1.11.7's terrain `gl_Vertex`, read back by a probe pack of ours, is each block's
    /// position minus the camera with its fraction rounded to 1/65536 block: these are the
    /// fractions (in 65536ths) it implied, for eyes at y 69.62 and 82.92, at x 100.3 and
    /// 40000.3, at z -13.7 and 20000.7, and off the grid by a fraction of a 65536th.
pub fn a_shader_pack_s_terrain_is_drawn_from_the_camera_in_65536ths() void {
}
    // rust: let eye = |x: f64, feet: f64, z: f64| glam::DVec3::new(x, feet + f64::from(1.62f32), z);
    // rust: let cases = [
    // rust: (eye(13.5, 68.0, -13.5), [32768.0, 40632.0, 32768.0]),
    // rust: (eye(13.5, 81.3, -13.5), [32768.0, 60293.0, 32768.0]),
    // rust: (eye(100.3, 90.0, -13.7), [19661.0, 40632.0, 19661.0]),
    // rust: (eye(40000.3, 120.0, 20000.7), [19661.0, 40632.0, 45875.0]),
    // rust: (
    // rust: eye(
    // rust: 13.0 + 0.7 / 8192.0,
    // rust: 81.0 + 0.3 / 8192.0,
    // rust: -13.0 - 0.6 / 8192.0,
    // rust: ),
    // rust: [6.0, 40635.0, 65531.0],
    // rust: ),
    // rust: ];
    // rust: for (camera, sixty_fifths) in cases {
    // rust: let from = super::pack_terrain_camera(camera);
    // rust: let fraction = (from - camera.floor()) * 65536.0;
    // rust: assert_eq!(fraction.to_array(), sixty_fifths, "{camera}");
}
}
pub fn section_instance_carries_the_fade_in_the_step() void {
}
//         use super::section_instance;
    // rust: let step = 1.0 / crate::mesher::UV_STEPS;
        // Fully visible (the option Off) is exactly the record from before the fade.
    // rust: assert_eq!(
    // rust: section_instance([1.0, 2.0, 3.0], 0, 1.0),
    // rust: [1.0, 2.0, 3.0, step]
    // rust: );
    // rust: for visibility in [0.0_f32, 0.25, 0.5, 0.999] {
    // rust: let w = section_instance([0.0; 3], 0, visibility)[3];
    // rust: let bits = w.to_bits();
    // rust: assert_eq!(f32::from_bits(bits & 0xff80_0000), step);
    // rust: let read = 1.0 - (bits & 0x7f_ffff) as f32 / 8_388_608.0;
    // rust: assert!((read - visibility).abs() < 1e-6, "{visibility}: {read}");
}
        // A section fading in over far terrain keeps its dither code unchanged.
    // rust: assert_eq!(section_instance([0.0; 3], 7, 0.5)[3], -(7.0 + step));
}
    /// A section as `Renderer::upload_mesh` makes one, with `solid` and
    /// `translucent` quads, fading in over far terrain since `fading`.
    // rust: fn section(
    // rust: solid: u32,
    // rust: translucent: u32,
    // rust: fading: Option<std::time::Instant>,
    // rust: ) -> super::SectionGpu {
    // rust: super::SectionGpu {
    // rust: page: 0,
    // rust: start: 0,
    // rust: translucent_at: (0, u64::from(solid) * 4),
    // rust: solid,
    // rust: solid_slots: u64::from(solid) * 4,
    // rust: packed: false,
    // rust: sides: crate::mesher::Sides::unsorted(solid),
    // rust: translucent,
    // rust: sort: super::translucency::SortState::new(Vec::new()),
    // rust: sorted_indices: None,
    // rust: flat_id: None,
    // rust: gpu_id: None,
    // rust: gpu_fading: false,
    // rust: fading,
    // rust: leaving: None,
    // rust: animated_layers: Box::new([]),
}
}
    /// A section's fade (`SectionGpu::drawn_faded`) only ends as time goes on,
    /// never while it leaves or is held, and by its `fade_end`, at most 10 ms
    /// after it has (a fade-in over far terrain is whole 9.4 ms before
    /// `lod::FADE`): fading in over far terrain or not, first uploaded or not,
    /// both, at every chunk fade-in time, in 1 ms steps over 3 s and at its end.
pub fn a_fade_ends_by_its_deadline_and_never_comes_back() void {
}
//         use super::FadeInputs;
//         use crate::fast_hash::{FxHashMap, FxHashSet};
//         use std::time::{Duration, Instant};
    // rust: let ms = Duration::from_millis;
        // The steps start at `zero`; what began `t` ms before it began off the steps.
    // rust: let zero = Instant::now() + Duration::from_secs(3);
    // rust: let ago = |t: u64| zero - ms(t) + Duration::from_micros(370);
    // rust: let key = (3, 5, -2);
        // Neither leaving nor held, leaving, held, both.
    // rust: let states = [(false, false), (true, false), (false, true), (true, true)];
    // rust: for fading in [None, Some(0), Some(300), Some(590), Some(700)] {
    // rust: for up in [None, Some(0), Some(1), Some(740), Some(2_500)] {
    // rust: let uploaded: FxHashMap<_, _> = up.map(|t| (key, ago(t))).into_iter().collect();
    // rust: for (leaving, held) in states {
    // rust: let mut s = section(1, 0, fading.map(ago));
    // rust: s.leaving = leaving.then(|| ago(250));
    // rust: let retiring: FxHashSet<_> = held.then_some(key).into_iter().collect();
    // rust: for fade_ms in [0, 1, 50, 300, 750, 2_000] {
    // rust: let case = (fading, up, leaving, held, fade_ms);
    // rust: let at = |now: Instant| FadeInputs {
    // rust: now,
    // rust: fade_ms,
    // rust: uploaded: &uploaded,
    // rust: retiring: &retiring,
}
    // rust: let faded = |now: Instant| s.drawn_faded(key, at(now));
    // rust: let end = s.fade_end(key, at(zero));
    // rust: if leaving || held {
    // rust: assert!(end.is_none(), "{case:?}: an end");
}
    // rust: let mut was = true;
    // rust: for t in 0..=3_000 {
    // rust: let now = zero + ms(t);
    // rust: let is = faded(now);
    // rust: assert!(was || !is, "{case:?}: faded again at {t} ms");
    // rust: was = is;
    // rust: if leaving || held {
    // rust: assert!(is, "{case:?}: whole at {t} ms");
    // rust: } else if end.is_none_or(|end| now >= end) {
    // rust: assert!(!is, "{case:?}: faded at {t} ms, past its end");
}
}
    // rust: if let Some(end) = end {
    // rust: assert!(!faded(end), "{case:?}: faded at its end");
    // rust: assert!(faded(end - ms(10)), "{case:?}: whole 10 ms before it");
}
}
}
}
}
}
    /// GPU culling's fading sections over 5 s of 16 ms frames, with no device
    /// (`mark_fades`): some 2,000 sections come, fading in as vanilla does or
    /// over far terrain, are meshed again, leave over far terrain, are held while
    /// it comes in and let go, and go, while the chunk fade-in time goes 750 ms,
    /// 2 s, Off and 750 ms. After every frame the GPU keeps only whole sections,
    /// the walk lists every other one, each record's flag is its section's, and
    /// a flagged section that neither leaves nor is held still faded a frame
    /// before. Each kind of event flags sections, and thousands go back. Once
    /// GPU culling is switched off (`forget_records`), every mark is the one a
    /// section has while it is off.
pub fn fading_sections_go_to_the_cpu_and_come_back() void {
}
//         use super::{
    // rust: FadeInputs, SectionGpu, SectionKey, decide_fade, forget_records, gpu_culling,
    // rust: hold_fading, mark_fades,
}
//         use crate::fast_hash::{FxHashMap, FxHashSet};
//         use std::time::{Duration, Instant};
        /// The level's sections: those at y -1 and 14 have no record.
pub const ROWS: usize = 14;
pub const FRAME: Duration = Duration::from_millis(16);
        /// The renderer's sections and what their fades depend on, and GPU
        /// culling's records and ends.
pub const Sim = struct {
    sections: super::resident::Resident<SectionGpu>,
    records: gpu_culling::Records,
    fades: gpu_culling::Fades,
    uploaded: FxHashMap<SectionKey,
    retiring: FxHashSet<SectionKey>,
};
    // rust: impl Sim {
            /// `Renderer::upload` at `at`: a new section, fading in over far
            /// terrain if `far`, or one meshed again.
pub fn upload(self: *Self, key: SectionKey, quads: (u32) void {
}
    // rust: self.retiring.remove(&key);
    // rust: let fading = match self.sections.find(key) {
    // rust: Some(old) => old.fading,
    // rust: None => far.then_some(at),
}
    // rust: if fading.is_none() {
    // rust: self.uploaded.entry(key).or_insert(at);
}
    // rust: self.release(key);
    // rust: let mut s = section(quads.0, quads.1, fading);
    // rust: if s.gpu_recorded(key, ROWS) {
    // rust: if let Some(fade_ms) = self.fades.fade_ms {
    // rust: let f = FadeInputs {
    // rust: now: at,
    // rust: fade_ms,
    // rust: uploaded: &self.uploaded,
    // rust: retiring: &self.retiring,
}
    // rust: s.gpu_fading = decide_fade(&s, key, &mut self.fades, f);
}
    // rust: s.gpu_id = Some(self.records.insert(s.record(key, None)));
}
    // rust: let marked = s.listed(key, ROWS);
    // rust: self.sections.insert_marked(key, s, None, marked);
}
            /// `Renderer::release_section`.
pub fn release(self: *Self, key: SectionKey) void {
}
    // rust: if let Some(id) = self.sections.remove(key).and_then(|s| s.gpu_id) {
    // rust: self.records.remove(id);
}
}
            /// `Renderer::leave_section`: its column gone (`remove_columns`), or
            /// no longer left out by far terrain while held (`set_lod_cutout`).
pub fn leave(self: *Self, key: SectionKey, at: Instant) void {
}
    // rust: self.uploaded.remove(&key);
    // rust: if let Some(s) = self.sections.find_mut(key)
    // rust: && s.leaving.is_none()
    // rust: {
    // rust: s.leaving = Some(at);
    // rust: hold_fading(&mut self.sections, &mut self.records, key);
}
}
            /// `Renderer::remove_columns`' held section: far terrain comes in under it.
pub fn hold(self: *Self, key: SectionKey) void {
}
    // rust: self.uploaded.remove(&key);
    // rust: self.retiring.insert(key);
    // rust: hold_fading(&mut self.sections, &mut self.records, key);
}
pub fn flagged(self: *Self, key: SectionKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sections.find(key).is_some_and(|s| s.gpu_fading)
}
}
    // rust: let mut seed = 0x2545_f491_u32;
    // rust: let mut next = move || {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 17;
    // rust: seed ^= seed << 5;
    // rust: seed
}
        // 16 x 16 columns of sections at y -1 to 14.
    // rust: let key = |r: u32| {
    // rust: let [x, y, z] = [0, 4, 8].map(|shift| ((r >> shift) % 16) as i32);
    // rust: (x, y - 1, z)
}
        // Solid quads alone, with translucent ones, or translucent ones alone.
    // rust: let kinds = [(64, 0), (64, 0), (64, 0), (64, 16), (64, 16), (0, 16)];
    // rust: let quads = |r: u32| kinds[r as usize % 6];
    // rust: let start = Instant::now();
    // rust: let mut sim = Sim::default();
    // rust: for r in 0..4_096 {
    // rust: if next().is_multiple_of(2) {
    // rust: sim.upload(key(r), quads(next()), next().is_multiple_of(2), start);
}
}
        // Flags set by an upload, `leave_section`, a held section and a fade-in
        // time (GPU culling switched on in the first frame), and dropped.
    // rust: let (mut set_by, mut handed_back) = ([0; 4], 0);
    // rust: let mut last = start;
    // rust: for frame in 0..=312 {
    // rust: let now = start + FRAME * frame;
    // rust: for event in 0..12 {
    // rust: let at = last + (now - last) * (event + 1) / 13;
    // rust: let r = next();
    // rust: let k = key(r);
    // rust: let was = sim.flagged(k);
    // rust: let kind = match (r >> 20) % 16 {
    // rust: 0..=7 => {
    // rust: sim.upload(k, quads(r >> 12), (r >> 24).is_multiple_of(2), at);
    // rust: 0
}
    // rust: 8 | 9 => {
    // rust: sim.leave(k, at);
    // rust: 1
}
    // rust: 10 | 11 => {
    // rust: sim.hold(k);
    // rust: 2
}
    // rust: 12 => {
                        // Far terrain no longer leaves a held section's column out.
    // rust: let held = sim.retiring.iter().next().copied();
    // rust: if let Some(held) = held {
    // rust: sim.retiring.remove(&held);
    // rust: sim.leave(held, at);
}
    // rust: continue;
}
    // rust: _ => {
    // rust: sim.uploaded.remove(&k);
    // rust: sim.release(k);
    // rust: continue;
}
}
    // rust: if !was && sim.flagged(k) {
    // rust: set_by[kind] += 1;
}
}
            // Those faded out go (`release_left`).
    // rust: let gone = |t: Instant| now.saturating_duration_since(t) >= super::lod::FADE;
    // rust: let left: Vec<SectionKey> = sim
    // rust: .sections
    // rust: .iter()
    // rust: .filter(|(_, s, _)| s.leaving.is_some_and(gone))
    // rust: .map(|(k, ..)| k)
    // rust: .collect();
    // rust: for k in left {
    // rust: sim.release(k);
}
    // rust: let flagged_before: FxHashSet<SectionKey> = sim
    // rust: .sections
    // rust: .iter()
    // rust: .filter(|(_, s, _)| s.gpu_fading)
    // rust: .map(|(k, ..)| k)
    // rust: .collect();
    // rust: let fade_ms = [750, 2_000, 0, 750][frame as usize * 4 / 313];
    // rust: let f = FadeInputs {
    // rust: now,
    // rust: fade_ms,
    // rust: uploaded: &sim.uploaded,
    // rust: retiring: &sim.retiring,
}
    // rust: mark_fades(&mut sim.sections, &mut sim.records, &mut sim.fades, ROWS, f);
    // rust: let a_frame_before = FadeInputs {
    // rust: now: now - FRAME,
    // rust: ..f
}
    // rust: let mut flagged = 0;
    // rust: for (k, s, _) in sim.sections.iter() {
    // rust: let marked = sim.sections.is_marked(k);
    // rust: assert_eq!(marked, s.listed(k, ROWS), "frame {frame}, {k:?}: its mark");
                // The GPU draws its solid quads whole, or the walk lists it.
    // rust: assert!(
    // rust: s.solid == 0 || s.gpu_draws_solid(true) || marked,
    // rust: "frame {frame}, {k:?}: drawn by neither"
    // rust: );
    // rust: assert!(
    // rust: !s.gpu_draws_solid(true) || !s.drawn_faded(k, f),
    // rust: "frame {frame}, {k:?}: drawn whole by the GPU while it fades"
    // rust: );
    // rust: if let Some(id) = s.gpu_id {
    // rust: let record = s.record(k, None);
    // rust: assert_eq!(sim.records.at(id), Some(&record), "frame {frame}, {k:?}");
}
    // rust: if s.gpu_fading {
    // rust: flagged += 1;
    // rust: set_by[3] += usize::from(!flagged_before.contains(&k));
    // rust: if s.leaving.is_none() && !sim.retiring.contains(&k) {
    // rust: assert!(
    // rust: s.drawn_faded(k, a_frame_before),
    // rust: "frame {frame}, {k:?}: flagged a frame after its fade"
    // rust: );
}
    // rust: } else {
    // rust: handed_back += usize::from(flagged_before.contains(&k));
}
}
    // rust: assert_eq!(sim.records.fading(), flagged, "frame {frame}");
    // rust: last = now;
}
    // rust: assert!(set_by.iter().all(|&n| n > 20), "flags set {set_by:?}");
    // rust: assert!(handed_back > 2_000, "{handed_back} handed back");
        // Switched off with sections still flagged: none keeps a record or a
        // flag, and each is marked as while GPU culling is off.
    // rust: assert!(sim.records.fading() > 0, "none flagged at the end");
    // rust: forget_records(&mut sim.sections, ROWS);
    // rust: for (k, s, _) in sim.sections.iter() {
    // rust: assert!(s.gpu_id.is_none() && !s.gpu_fading, "{k:?}: kept once off");
    // rust: let off = s.translucent > 0 || !s.gpu_recorded(k, ROWS);
    // rust: assert_eq!(sim.sections.is_marked(k), off, "{k:?}: its mark once off");
}
}
pub fn terrain_attributes_follow_the_terrain_vertex() void {
}
//         use super::TerrainVertex;
//         use std::mem::offset_of;
    // rust: let offsets = super::TERRAIN_ATTRIBUTES.map(|a| (a.shader_location, a.offset as usize));
    // rust: assert_eq!(
    // rust: offsets,
    // rust: [
    // rust: (0, offset_of!(TerrainVertex, pos)),
    // rust: (1, offset_of!(TerrainVertex, uv)),
    // rust: (2, offset_of!(TerrainVertex, layer)),
    // rust: (4, offset_of!(TerrainVertex, light)),
    // rust: (3, offset_of!(TerrainVertex, color)),
    // rust: ]
    // rust: );
    // rust: assert_eq!(std::mem::size_of::<TerrainVertex>(), 24);
}
pub fn cracks_multiply_instead_of_covering_the_block() void {
}
    // rust: let blend = super::CRUMBLING_BLEND;
    // rust: assert_eq!(blend.color.src_factor, wgpu::BlendFactor::Dst);
    // rust: assert_eq!(blend.color.dst_factor, wgpu::BlendFactor::Src);
    // rust: assert_eq!(blend.alpha.src_factor, wgpu::BlendFactor::One);
    // rust: assert_eq!(blend.alpha.dst_factor, wgpu::BlendFactor::Zero);
}
pub fn hdr_screenshots_keep_every_10_bit_step() void {
}
        // Rgb10a2Unorm: red in the low 10 bits, then green, then blue.
    // rust: let px = |r: u32, g: u32, b: u32| (r | g << 10 | b << 20 | 3 << 30).to_le_bytes();
    // rust: let out = super::hdr10_to_rgb16(&[px(0, 1023, 512)]);
    // rust: assert_eq!(out, [0, 0, 0xff, 0xff, 0x80, 0x20]);
    // rust: assert_eq!(
    // rust: super::hdr_screenshot_path(std::path::Path::new("screenshots/2026-10-28_12.00.00.png")),
    // rust: std::path::Path::new("screenshots/2026-10-28_12.00.00-hdr.png")
    // rust: );
}
pub fn texture_filtering_samplers() void {
}
//         use super::{sampler_anisotropy, sprite_sampler_descriptor};
        // LevelRenderer.chunkLayerSampler: linear both ways, clamped, in every mode.
    // rust: for aniso in [1, 8] {
    // rust: let d = sprite_sampler_descriptor(aniso);
    // rust: assert_eq!(d.mag_filter, wgpu::FilterMode::Linear);
    // rust: assert_eq!(d.min_filter, wgpu::FilterMode::Linear);
    // rust: assert_eq!(d.mipmap_filter, wgpu::MipmapFilterMode::Linear);
    // rust: assert_eq!(d.address_mode_v, wgpu::AddressMode::ClampToEdge);
    // rust: assert_eq!(d.anisotropy_clamp, aniso);
}
    // rust: assert_eq!(
    // rust: [1, 2, 3].map(sampler_anisotropy),
    // rust: [2, 4, 8],
    // rust: "Options.maxAnisotropyValue is 1 << bit"
    // rust: );
}
pub fn distant_tiles_repeat_their_sprite_under_the_clamped_sampler() void {
}
        // terrain.wgsl's tile_uv, evaluated by naga as a constant expression.
    // rust: let source = include_str!("terrain.wgsl");
    // rust: let body = source.split("fn tile_uv(").nth(1).unwrap();
    // rust: let body = body.split("return ").nth(1).unwrap();
    // rust: let expr = &body[..body.find(';').unwrap()];
    // rust: let tile_uv = |u: f32, v: f32| -> [f32; 2] {
    // rust: let uv = format!("vec2<f32>({u:?}, {v:?})");
    // rust: let wgsl = format!("const UV: vec2<f32> = {};", expr.replace("uv", &uv));
    // rust: let module = naga::front::wgsl::parse_str(&wgsl).unwrap();
    // rust: let (_, constant) = module.constants.iter().next().unwrap();
    // rust: let naga::Expression::Compose { components, .. } =
    // rust: &module.global_expressions[constant.init]
    // rust: else {
    // rust: panic!("{wgsl}");
}
    // rust: components
    // rust: .iter()
    // rust: .map(|&c| match module.global_expressions[c] {
    // rust: naga::Expression::Literal(naga::Literal::F32(x)) => x,
    // rust: ref e => panic!("{e:?}"),
    // rust: })
    // rust: .collect::<Vec<_>>()
    // rust: .try_into()
    // rust: .unwrap()
}
        // A section's sprite UVs, edges included, stay where the clamped sampler reads them.
    // rust: for (u, v) in [(0.0, 1.0), (0.25, 0.75), (1.0, 0.0)] {
    // rust: assert_eq!(tile_uv(u, v), [u, v]);
}
        // A merged face's UV counts blocks: each takes the sprite from its own corner.
    // rust: assert_eq!(tile_uv(1.25, 2.0), [0.25, 1.0]);
    // rust: assert_eq!(tile_uv(1023.5, 3.75), [0.5, 0.75]);
}
pub fn shader_globals_match_the_rust_layout() void {
}
        // terrain.wgsl and entity.wgsl bind the same buffer: same fields, same order.
    // rust: let fields = |source: &str| -> Vec<String> {
    // rust: let body = source.split("struct Globals {").nth(1).unwrap();
    // rust: body[..body.find('}').unwrap()]
    // rust: .lines()
    // rust: .filter_map(|l| l.trim().split_once(':').map(|(name, _)| name.to_string()))
    // rust: .filter(|name| !name.starts_with("//"))
    // rust: .collect()
}
    // rust: let terrain = fields(include_str!("terrain.wgsl"));
    // rust: assert_eq!(terrain, fields(include_str!("entity.wgsl")));
    // rust: let rust = fields(include_str!("gfx.rs"));
    // rust: assert_eq!(terrain, rust);
}
pub fn selection_outline_uses_vanilla_pixel_width() void {
}
    // rust: for width in [640, 1280, 1920] {
    // rust: assert_eq!(super::outline_width(width), 2.5);
}
    // rust: assert_eq!(super::outline_width(2560), 2560.0 / 1920.0 * 2.5);
    // rust: assert_eq!(super::outline_width(3840), 5.0);
}
pub fn the_projection_center_follows_the_view_bob() void {
}
//         use glam::{Mat4, Vec3};
    // rust: let projection = super::world_projection(70.0, 16.0 / 9.0, 512.0);
    // rust: let view = crate::camera::view_matrix(30.0, 20.0);
    // rust: let eye = super::projection_center(projection * view).unwrap();
    // rust: assert!(eye.length() < 1e-5, "{eye}");
        // A pose translated by the bob: the eye is where the pose's inverse
        // takes the view's origin.
    // rust: let bob = Mat4::from_rotation_z(0.02) * Mat4::from_translation(Vec3::new(0.03, -0.08, 0.0));
    // rust: let expected = (bob * view).inverse().transform_point3(Vec3::ZERO);
    // rust: let eye = super::projection_center(projection * bob * view).unwrap();
    // rust: assert!(eye.distance(expected) < 1e-5, "{eye} {expected}");
    // rust: assert!(expected.length() > 0.05);
    // rust: assert!(
    // rust: super::projection_center(Mat4::orthographic_rh(-1.0, 1.0, -1.0, 1.0, 0.0, 1.0))
    // rust: .is_none()
    // rust: );
}
pub fn indirect_draws_are_validated_only_in_debug_builds_and_on_directx_12() void {
}
    // rust: let validated = |backends| {
    // rust: super::instance_descriptor(backends, None, false)
    // rust: .flags
    // rust: .contains(wgpu::InstanceFlags::VALIDATION_INDIRECT_CALL)
}
    // rust: if std::env::var_os("WGPU_VALIDATION_INDIRECT_CALL").is_none()
    // rust: && std::env::var_os("WGPU_BACKEND").is_none()
    // rust: {
    // rust: assert_eq!(validated(wgpu::Backends::default()), cfg!(debug_assertions));
    // rust: assert_eq!(validated(wgpu::Backends::VULKAN), cfg!(debug_assertions));
    // rust: assert_eq!(
    // rust: validated(wgpu::Backends::DX12),
    // rust: cfg!(debug_assertions) || cfg!(windows)
    // rust: );
}
}
pub fn far_faces_a_hair_apart_keep_their_depth_order() void {
}
    // rust: let m = super::world_projection(70.0, 16.0 / 9.0, 768.0);
    // rust: let depth = |distance: f32| {
    // rust: let clip = m * glam::Vec4::new(0.0, 0.0, -distance, 1.0);
    // rust: clip.z / clip.w
}
        // fire_side at 150 blocks, 0.01 pixel in front of the block it burns on.
    // rust: let (block, fire) = (depth(150.0), depth(150.0 - 0.01 / 16.0));
    // rust: assert!(fire > block, "{fire} {block}");
    // rust: assert!((0.0..=1.0).contains(&block));
    // rust: assert!((depth(0.05) - 1.0).abs() < 1e-6);
}
pub fn selection_outline_has_vanilla_perspective_layering() void {
}
    // rust: assert_eq!(
    // rust: super::outline_params(1280, 720),
    // rust: [1280.0, 720.0, 2.5, 0.99975586]
    // rust: );
    // rust: assert_eq!(
    // rust: super::outline_params(3840, 0),
    // rust: [3840.0, 1.0, 5.0, 0.99975586]
    // rust: );
}
pub fn selection_outline_preserves_shape_edges_without_inflation() void {
}
    // rust: let edges = [[2.0, 97.5, 3.0, 3.0, 97.5, 3.0]];
    // rust: assert_eq!(
    // rust: super::outline_vertices(&edges, glam::DVec3::new(0.5, 98.62, 0.5)),
    // rust: vec![[
    // rust: 1.5,
    // rust: (97.5 - 98.62) as f32,
    // rust: 2.5,
    // rust: 2.5,
    // rust: (97.5 - 98.62) as f32,
    // rust: 2.5
    // rust: ]]
    // rust: );
    // rust: assert!(super::outline_vertices(&[], glam::DVec3::ZERO).is_empty());
}
}

    // rust: mod sprite_upload_tests {
//     use super::*;
pub fn real_rail_mips_do_not_change_with_larger_array_layers() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root
    // rust: .join("assets/minecraft/textures/block/rail.png")
    // rust: .exists()
    // rust: {
    // rust: return;
}
    // rust: let mut sprites = crate::sprites::Sprites::default();
    // rust: let layers: Vec<_> = [
    // rust: "rail",
    // rust: "powered_rail",
    // rust: "powered_rail_on",
    // rust: "detector_rail",
    // rust: "activator_rail",
    // rust: ]
    // rust: .map(|name| {
    // rust: sprites
    // rust: .insert(&root, &format!("minecraft:block/{name}"))
    // rust: .unwrap()
    // rust: })
    // rust: .into();
    // rust: sprites.finish();
    // rust: assert_eq!(sprites.size, 16);
    // rust: let native: Vec<_> = layers
    // rust: .iter()
    // rust: .map(|&layer| {
    // rust: let start = layer as usize * 16 * 16 * 4;
    // rust: mip_chain(
    // rust: &sprites.pixels[start..start + 16 * 16 * 4],
    // rust: 16,
    // rust: &sprites.mips,
    // rust: layer,
    // rust: 1,
    // rust: )
    // rust: .0
    // rust: })
    // rust: .collect();
    // rust: sprites.insert(&root, "minecraft:block/oak_sign").unwrap();
    // rust: sprites.finish();
    // rust: assert_eq!(sprites.size, 32);
    // rust: for (&layer, expected) in layers.iter().zip(native) {
    // rust: let start = layer as usize * 32 * 32 * 4;
    // rust: let (actual, _) = mip_chain(
    // rust: &sprites.pixels[start..start + 32 * 32 * 4],
    // rust: 32,
    // rust: &sprites.mips,
    // rust: layer,
    // rust: 1,
    // rust: );
    // rust: assert_eq!(&actual[32 * 32 * 4..], expected, "rail layer {layer}");
}
}
pub fn prepared_texture_uploads_preserve_layer_order_and_settings() void {
}
    // rust: let size = 4;
    // rust: let layers = 5;
    // rust: let pixels: Vec<u8> = (0..size * size * layers)
    // rust: .flat_map(|i| [i as u8, (i * 3) as u8, 99, if i % 3 == 0 { 0 } else { 255 }])
    // rust: .collect();
    // rust: let settings: Vec<_> = (0..layers)
    // rust: .map(|i| crate::mipmap::Settings {
    // rust: strategy: if i % 2 == 0 {
    // rust: crate::mipmap::Strategy::Mean
    // rust: } else {
    // rust: crate::mipmap::Strategy::StrictCutout
    // rust: },
    // rust: ..Default::default()
    // rust: })
    // rust: .collect();
    // rust: let border = [20, 30, 40, 128].repeat(16);
    // rust: let expected = mip_chain(&pixels, size, &settings, 0, layers);
        // A partial final array and an exact boundary exercise the global
        // layer offset used to select each sprite's mipmap settings.
    // rust: for split in [1, 2, 5, 8] {
    // rust: let prepared = PreparedTextures::with_split(
    // rust: &pixels,
    // rust: size,
    // rust: layers,
    // rust: &settings,
    // rust: (&border, size),
    // rust: split,
    // rust: );
    // rust: assert_eq!(prepared.sprites.len(), layers.div_ceil(split) as usize);
    // rust: let actual: Vec<_> = prepared
    // rust: .sprites
    // rust: .iter()
    // rust: .flat_map(|(bytes, levels)| {
    // rust: assert_eq!(*levels, expected.1);
    // rust: bytes.iter().copied()
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(actual, expected.0);
    // rust: assert_eq!(prepared.forcefield, mip_chain(&border, size, &[], 0, 1));
            // Chains cut before the adapter was known, cut again for it.
    // rust: for to in [1, 2, 3, 5, 8] {
    // rust: let direct = PreparedTextures::with_split(
    // rust: &pixels,
    // rust: size,
    // rust: layers,
    // rust: &settings,
    // rust: (&border, size),
    // rust: to,
    // rust: );
    // rust: let resplit = PreparedTextures::with_split(
    // rust: &pixels,
    // rust: size,
    // rust: layers,
    // rust: &settings,
    // rust: (&border, size),
    // rust: split,
    // rust: )
    // rust: .resplit(layers, to);
    // rust: assert_eq!(resplit.split, to);
    // rust: assert_eq!(resplit.sprites, direct.sprites, "{split} -> {to}");
}
}
}

pub fn sprite_split_follows_the_adapters_layer_limit() void {
}
        // The Discord report: 512 layers per array, 1291 block textures (3 arrays).
    // rust: assert_eq!(layer_split(512, false, None, 1291), Ok(512));
    // rust: assert_eq!(layer_split(512, true, None, 1291), Ok(512));
    // rust: assert_eq!(layer_split(2048, false, None, 1291), Ok(SPRITE_SPLIT));
    // rust: assert_eq!(layer_split(8192, false, None, 1291), Ok(SPRITE_SPLIT));
        // HORIZON_SPRITE_SPLIT only lowers it.
    // rust: assert_eq!(layer_split(2048, false, Some(512), 1291), Ok(512));
    // rust: assert_eq!(layer_split(256, false, Some(512), 1291), Ok(256));
        // OpenGL pads a multiple of 6 by a layer: a full array must still fit.
    // rust: assert_eq!(layer_split(600, true, None, 1291), Ok(599));
    // rust: assert_eq!(layer_split(600, false, None, 1291), Ok(600));
    // rust: assert_eq!(array_layers(599, true), 599);
        // Past the arrays terrain.wgsl binds.
    // rust: assert_eq!(layer_split(256, false, None, 256 * SPRITE_ARRAYS), Ok(256));
    // rust: let err = layer_split(128, false, None, 1291).unwrap_err();
    // rust: assert!(err.contains("128 texture layers per array"), "{err}");
    // rust: assert!(layer_split(512, false, None, 512 * SPRITE_ARRAYS + 1).is_err());
}

pub fn metal_uses_a_conservative_default_split_but_respects_overrides() void {
}
    // rust: let mut info = wgpu::AdapterInfo {
    // rust: name: "test adapter".into(),
    // rust: vendor: 0,
    // rust: device: 0,
    // rust: device_type: wgpu::DeviceType::IntegratedGpu,
    // rust: device_pci_bus_id: String::new(),
    // rust: driver: String::new(),
    // rust: driver_info: String::new(),
    // rust: backend: wgpu::Backend::Vulkan,
    // rust: subgroup_min_size: 0,
    // rust: subgroup_max_size: 0,
    // rust: transient_saves_memory: None,
    // rust: limit_bucket: None,
}
    // rust: info.backend = wgpu::Backend::Metal;
    // rust: assert_eq!(adapter_requested_split(&info, None), Some(512));
    // rust: assert_eq!(adapter_requested_split(&info, Some(1024)), Some(1024));

    // rust: info.backend = wgpu::Backend::Vulkan;
    // rust: assert_eq!(adapter_requested_split(&info, None), None);
}

pub fn mip_chain_allocates_exactly_its_size() void {
}
    // rust: for size in [16, 64] {
    // rust: let animation = crate::sprites::test_animation(size, 0);
    // rust: let (chain, _) = mip_chain(animation.pixels(0), size, &[], 0, 1);
    // rust: assert_eq!(chain.capacity(), chain.len());
}
}

pub fn collect_animated_layers_masks_opaque_layer() void {
}
//         use crate::mesher::{self, SectionMesh, TerrainVertex};
    // rust: let opaque_vertex =
    // rust: TerrainVertex::new([0.0, 0.0, 0.0], [0.0, 0.0], 7 | mesher::OPAQUE_LAYER, 0, 0);
    // rust: let translucent_vertex = TerrainVertex::new([0.0, 0.0, 0.0], [0.0, 0.0], 12, 0, 0);
    // rust: let mut mesh = SectionMesh {
    // rust: solid: vec![opaque_vertex; 4],
    // rust: translucent: vec![translucent_vertex; 4],
    // rust: ..Default::default()
}
    // rust: mesh.note_sprite_layer(7 | mesher::OPAQUE_LAYER);
    // rust: mesh.note_sprite_layer(12);
    // rust: mesh.finish_sprite_layers();

    // rust: let animated = super::collect_animated_layers(&mesh, |layer| layer == 7 || layer == 12);
    // rust: assert_eq!(&*animated, &[7, 12]);
}
}

/// What the system says about the window's display, kept up to date: on Wayland, the
/// compositor's preferred image description of the surface; elsewhere what wgpu reads
/// from the OS (on Windows, DXGI's luminances and the SDR white level).
pub const DisplayWatch = struct {
    wayland: ?horizon_hdr::wayland::Watch,
    /// Without Wayland's event, what wgpu last read and when to read it again: the OS
    /// sends no event for a moved window or a changed SDR brightness slider.
    polled: ?(Option<crate::graphics::Reported,
};
/// How often [`DisplayWatch`] reads the OS's values again where no event says they changed.
pub const DISPLAY_POLL: std::time::Duration = std::time::Duration::from_secs(2);
    // rust: impl DisplayWatch {
    /// Starts watching, with what the system reports now.
    // rust: fn new(
    // rust: window: &Window,
    // rust: surface: Option<&wgpu::Surface>,
    // rust: adapter: &wgpu::Adapter,
    // rust: ) -> (Self, Option<crate::graphics::Reported>) {
    // rust: if let Some((wayland, now)) = horizon_hdr::wayland::Watch::new(window) {
    // rust: let watch = Self {
    // rust: wayland: Some(wayland),
    // rust: polled: None,
}
    // rust: return (watch, now.map(reported));
}
    // rust: let _ = window;
    // rust: let now = surface.and_then(|surface| os_reported(&surface.display_hdr_info(adapter)));
    // rust: log_os_reported(now);
    // rust: let watch = Self {
    // rust: wayland: None,
    // rust: polled: Some((now, std::time::Instant::now() + DISPLAY_POLL)),
}
    // rust: (watch, now)
}
    /// What the system reports, if that changed since the last call.
    // rust: fn changed(
    // rust: &mut self,
    // rust: surface: Option<&wgpu::Surface>,
    // rust: adapter: &wgpu::Adapter,
    // rust: ) -> Option<Option<crate::graphics::Reported>> {
    // rust: if let Some(wayland) = &mut self.wayland {
    // rust: return wayland.changed().map(|now| now.map(reported));
}
    // rust: let (last, next) = self.polled.as_mut()?;
    // rust: let time = std::time::Instant::now();
    // rust: if time < *next {
    // rust: return None;
}
    // rust: *next = time + DISPLAY_POLL;
    // rust: let now = surface.and_then(|surface| os_reported(&surface.display_hdr_info(adapter)));
    // rust: (now != *last).then(|| {
    // rust: log_os_reported(now);
    // rust: *last = now;
    // rust: now
    // rust: })
}
}

/// The log of what the system reports about the display: one line per change. The
/// renderer is made anew a few times while the game starts and each asks again, and a
/// slider dragged in the desktop's settings changes the values many times a second, so
/// a change within [`DISPLAY_LOG_QUIET`] of the last line waits until the values have
/// held that long, and only the one they settled on is logged.
pub const DisplayLog = struct {
    last: []const u8,
    at: ?std::time::Instant,
    pending: Option<([]const u8,
};
    // rust: static DISPLAY_LOG: std::sync::Mutex<DisplayLog> = std::sync::Mutex::new(DisplayLog {
    // rust: last: String::new(),
    // rust: at: None,
    // rust: pending: None,
    // rust: });
pub const DISPLAY_LOG_QUIET: std::time::Duration = std::time::Duration::from_secs(1);
pub fn log_display(line: []const u8) void {
}
    // rust: let now = std::time::Instant::now();
    // rust: let mut log = DISPLAY_LOG
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: if line == log.last {
    // rust: log.pending = None;
    // rust: } else if log.at.is_none_or(|at| now - at >= DISPLAY_LOG_QUIET) {
    // rust: log::info!("{line}");
    // rust: (log.last, log.at, log.pending) = (line, Some(now), None);
    // rust: } else {
    // rust: log.pending = Some((line, now));
}
}
/// Logs a change [`log_display`] held back, once the values have held for
/// [`DISPLAY_LOG_QUIET`].
pub fn flush_display_log() void {
}
    // rust: let now = std::time::Instant::now();
    // rust: let mut log = DISPLAY_LOG
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: if let Some((_, since)) = &log.pending
    // rust: && now - *since >= DISPLAY_LOG_QUIET
    // rust: && let Some((line, _)) = log.pending.take()
    // rust: {
    // rust: log::info!("{line}");
    // rust: (log.last, log.at) = (line, Some(now));
}
}
/// A reported black level, within the setting's range. Rounded down: OLEDs report a figure
/// just above 0, like KWin's 0.005, which isn't worth lifting the shadows for.
pub fn hundredths_of_a_nit(nits: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if nits.is_finite() && nits > 0.0 {
    // rust: ((nits * 100.0) as u32).min(100)
    // rust: } else {
    // rust: 0
}
}
pub fn log_os_reported(reported: ?crate::graphics::Reported) void {
}
    // rust: log_display(match reported {
    // rust: Some(r) => format!(
    // rust: "Horizon renderer: the system reports SDR white at {} nits and a peak of {} nits",
    // rust: r.paper_white, r.peak
    // rust: ),
    // rust: None => "Horizon renderer: the system doesn't report the display's luminance".into(),
    // rust: });
}
/// What the OS reports in absolute nits (Windows: DXGI's `MaxLuminance` and the SDR
/// white level the brightness slider sets), which is HDR output's scale there: SDR
/// white is Paper White, the display's peak is Peak Brightness. Both are kept within
/// the settings' ranges. The OS's figures often come from the display's EDID and may
/// run optimistic; the player's own value always wins.
pub fn os_reported(info: *wgpu::DisplayHdrInfo) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let luminance = info.luminance?;
    // rust: let usable = |n: f32| n.is_finite() && n > 0.0;
    // rust: let peak = luminance.max_nits.filter(|&n| usable(n))?;
    // rust: let white = luminance.sdr_white_nits.filter(|&n| usable(n))?;
    // rust: let paper_white = (white.round() as u32).clamp(80, 480);
    // rust: Some(crate::graphics::Reported {
    // rust: paper_white,
    // rust: black: hundredths_of_a_nit(luminance.min_nits.unwrap_or(0.0)),
        // Windows' SDR brightness slider can set white above the reported peak (480 against
        // a calibrated 380): the highlights then stay at white instead of dropping below it.
    // rust: peak: (peak.round() as u32).clamp(200, 10_000).max(paper_white),
    // rust: })
}

/// What a compositor's luminances mean in HDR output's scale.
///
/// KWin maps content's reference white (203 nits in PQ, BT.2408) onto its own, so the
/// desktop's white is 203 there and the peak is the target's maximum over that ratio.
/// Checked on KWin. Hyprland (0.57) reports the standard 203, and shows HDR windows below
/// the SDR white of its desktop (which it doesn't report), so Auto can't match its desktop
/// there. Other compositors are unchecked. The peak is kept within the settings' lowest and
/// PQ's top, so the metadata never ends below the black level.
pub fn reported(l: horizon_hdr::wayland::Luminances) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let peak = (l.target_max * 203.0 / l.reference.max(1.0)).round() as u32;
    // rust: log_display(format!(
    // rust: "Horizon renderer: the compositor shows this window with reference white {} nits, \
    // rust: {}..{} nits: peak {peak} nits in HDR output's scale",
    // rust: l.reference, l.target_min, l.target_max,
    // rust: ));
    // rust: crate::graphics::Reported {
    // rust: paper_white: 203,
    // rust: peak: peak.clamp(200, 10_000),
    // rust: black: hundredths_of_a_nit(l.target_min * 203.0 / l.reference.max(1.0)),
}
}

    // rust: mod shadow_face_tests {
//     use super::*;

    /// The faces of one block at `at` (section-relative), each with its own layer:
    /// 0 +X, 1 -X, 2 +Y (up), 3 -Y (down), 4 +Z, 5 -Z; counter-clockwise from outside.
pub fn block(at: [f32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, z] = at;
    // rust: let (a, b, c) = (x + 1.0, y + 1.0, z + 1.0);
    // rust: [
    // rust: [[a, y, z], [a, b, z], [a, b, c], [a, y, c]],
    // rust: [[x, y, z], [x, y, c], [x, b, c], [x, b, z]],
    // rust: [[x, b, z], [x, b, c], [a, b, c], [a, b, z]],
    // rust: [[x, y, z], [a, y, z], [a, y, c], [x, y, c]],
    // rust: [[x, y, c], [a, y, c], [a, b, c], [x, b, c]],
    // rust: [[x, y, z], [x, b, z], [a, b, z], [a, y, z]],
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .flat_map(|(layer, q)| q.map(|p| TerrainVertex::new(p, [0.0; 2], layer as u16, 0, 0)))
    // rust: .collect()
}

    /// The layers (faces) of the quads the shadow pass draws of `solid`.
pub fn drawn(view: *pack_post::ShadowView, origin: [f32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut solid = block([7.0, 7.0, 7.0]);
    // rust: let sides = crate::mesher::sort_tinted(&mut solid, &mut Vec::new());
    // rust: let mut layers = Vec::new();
    // rust: shadow_runs(&sides, view, origin, |first, quads| {
    // rust: for q in first..first + quads {
    // rust: layers.push(solid[q as usize * 4].layer);
}
    // rust: });
    // rust: layers.sort_unstable();
    // rust: layers
}

pub fn view(every_face: bool) p {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: pack_post::ShadowView {
    // rust: cull: Mat4::IDENTITY,
    // rust: light: Vec3::Y,
    // rust: distance: None,
    // rust: unculled: None,
    // rust: every_face,
    // rust: view_casters: true,
    // rust: depth_planes: false,
}
}

    /// Iris 1.11.7's shadow map holds faces turned away from the light (#9033): the block's
    /// bottom face, under a sun straight above, is drawn too.
pub fn the_shadow_pass_draws_faces_turned_away_from_the_light() void {
}
        // A section 32 blocks under the camera.
    // rust: let origin = [-8.0, -40.0, -8.0];
    // rust: assert_eq!(drawn(&view(true), origin), [0, 1, 2, 3, 4, 5]);
        // Horizon's own packs keep drawing only what can face the light: no bottom face.
    // rust: assert!(!drawn(&view(false), origin).contains(&3));
}
}

    // rust: mod shadow_caster_tests {
//     use super::*;

pub fn the_shadow_pass_takes_the_block_entities_of_its_sections_within_64_blocks() void {
}
        // Sections 64 to 79 high (the world from -64): a chest in each of three. The shadow
        // pass drew `near` and `far`; `left_out` lies as near but the pass didn't draw it, and
        // `far`'s nearest block is 78.5 blocks away.
    // rust: let (near, left_out, far) = ((0, 8, 0), (1, 8, 0), (5, 8, 0));
    // rust: let mut block_entities = FxHashMap::default();
    // rust: block_entities.insert(near, vec![([3, 70, 3], 7)]);
    // rust: block_entities.insert(left_out, vec![([20, 70, 3], 7)]);
    // rust: block_entities.insert(far, vec![([85, 70, 3], 7)]);
    // rust: let camera = DVec3::new(0.5, 70.0, 0.5);
    // rust: let drawn = [near, far].into_iter();
    // rust: let taken: Vec<_> = block_entities_within_reach(drawn, &block_entities, camera, -64)
    // rust: .copied()
    // rust: .collect();
    // rust: assert_eq!(taken, vec![([3, 70, 3], 7)]);
}

    /// What the shadow pass keeps of a camera-relative section at `min`, the camera at the
    /// origin looking along -X (yaw 90) with the scenes' 70 degree, 16:9 view, and the light in
    /// direction `light`; the light's own box takes in everything.
pub fn kept(light: Vec3, min: [f32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: kept_looking(Vec3::NEG_X, light, min)
}

    /// `kept` with the camera looking along `forward`.
pub fn kept_looking(forward: Vec3, light: Vec3, min: [f32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let camera = world_projection(70.0, 16.0 / 9.0, 192.0)
    // rust: * Mat4::look_to_rh(Vec3::ZERO, forward, Vec3::Y);
    // rust: let cull = ShadowCull {
    // rust: light: Frustum {
    // rust: planes: [Vec4::W; 6],
    // rust: },
    // rust: casters: Some(shadow_casters(camera, light)),
    // rust: reach: None,
}
    // rust: let min = Vec3::from(min);
    // rust: cull.intersects(min, min + 16.0)
}

    /// Our probes' Iris 1.11.7 shadow maps fit keeping only the terrain whose shadow can fall
    /// into the camera's view (#8464).
pub fn the_shadow_pass_keeps_what_can_shade_the_view() void {
}
        // A noon sun: a treetop high above the ground ahead shades it, though the camera doesn't
        // see it; behind the camera, or far off to the side, nothing does.
    // rust: assert!(kept(Vec3::Y, [-48.0, 64.0, -8.0]));
    // rust: assert!(!kept(Vec3::Y, [32.0, 0.0, -8.0]));
    // rust: assert!(!kept(Vec3::Y, [-32.0, 0.0, 96.0]));
        // Nor does what lies under the ground the camera looks along.
    // rust: assert!(!kept(Vec3::Y, [-48.0, -96.0, -8.0]));
        // A low sun ahead (west, -X) throws shadows toward the camera: what is behind it can't
        // reach the view.
    // rust: let west = Vec3::new(-1.0, 0.1, 0.0).normalize();
    // rust: assert!(kept(west, [-48.0, 0.0, -8.0]));
    // rust: assert!(!kept(west, [32.0, 0.0, -8.0]));
        // The same sun behind the camera throws the terrain behind it forward, into the view.
    // rust: let east = Vec3::new(1.0, 0.1, 0.0).normalize();
    // rust: assert!(kept(east, [32.0, 0.0, -8.0]));
    // rust: assert!(kept(east, [96.0, 0.0, -8.0]));
        // Looking 20 degrees down under a noon sun, the view's sides lean out below the camera:
        // a treetop above the ground ahead still shades it, one off to the side doesn't, though
        // it lies inside each of the view's planes that faces the light.
    // rust: let down = Vec3::new(-20f32.to_radians().cos(), -20f32.to_radians().sin(), 0.0);
    // rust: assert!(kept_looking(down, Vec3::Y, [-48.0, 16.0, -8.0]));
    // rust: assert!(!kept_looking(down, Vec3::Y, [-32.0, 16.0, -96.0]));
}

    /// Our probes' Iris 1.11.7 maps keep the sections whose box, grown by a margin of 1.1224 to
    /// 1.1252 blocks, meets the shape (#8464): a camera at (13.5, 69.62, -13.5) under a noon sun with the scenes' flying
    /// field of view (77°).
pub fn the_shadow_pass_keeps_a_margin_around_the_view() void {
}
    // rust: let kept = |yaw: f32, column: [f32; 2]| {
    // rust: let camera =
    // rust: world_projection(77.0, 16.0 / 9.0, 1024.0) * crate::camera::view_matrix(yaw, 0.0);
    // rust: let cull = ShadowCull {
    // rust: light: Frustum {
    // rust: planes: [Vec4::W; 6],
    // rust: },
    // rust: casters: Some(shadow_casters(camera, Vec3::Y)),
    // rust: reach: None,
}
    // rust: let min = Vec3::new(
    // rust: column[0] * 16.0 - 13.5,
    // rust: 64.0 - 69.62,
    // rust: column[1] * 16.0 + 13.5,
    // rust: );
    // rust: cull.intersects(min, min + 16.0)
}
        // Looking west, the column at chunk (-2, -6) needs a margin of 0.9 blocks: Iris keeps it.
    // rust: assert!(kept(90.0, [-2.0, -6.0]));
        // Looking south (yaw 7.5), the one at (3, 0) needs a margin of 1.3 blocks: Iris drops it.
    // rust: assert!(!kept(7.5, [3.0, 0.0]));
}

    /// With `shadowDistanceRenderMul`, our probe's Iris 1.11.7 maps keep the sections within
    /// `shadowDistance × mul` of the camera along each axis, out to the cube's corners, and with
    /// some slack (the camera at (13.5, 69.62, -13.5)):
    /// - at 100 blocks, the column at chunk (7, 5), 98.5 and 93.5 blocks out (136 diagonally), and
    ///   the one at (-6, -7) are kept; the one at (8, -4), 114.5 out on x, is not;
    /// - at 49.5 blocks, the column at (-2, -5), 50.5 out on z, is kept; at 49 it is not;
    /// - at 50 blocks from a camera at y 151.62, the ground's sections 70 blocks below are not.
pub fn the_shadow_distance_render_mul_keeps_a_cube() void {
}
    // rust: let kept = |camera: DVec3, reach: f32, keys: &[(i32, i32)]| {
    // rust: let y = (64 - crate::chunk::MIN_Y) / 16;
    // rust: let mut sections = resident::Resident::<()>::default();
    // rust: for &(x, z) in keys {
    // rust: sections.insert_with_bounds((x, y, z), (), None);
}
    // rust: let cull = ShadowCull {
    // rust: light: Frustum {
    // rust: planes: [Vec4::W; 6],
    // rust: },
    // rust: casters: None,
    // rust: reach: Some(reach),
}
    // rust: let mut out = Vec::new();
    // rust: sections.visible(camera, 12, &cull, |_| true, |_, _| false, &mut out);
    // rust: let mut kept: Vec<_> = out.iter().map(|v| (v.key.0, v.key.2)).collect();
    // rust: kept.sort_unstable();
    // rust: kept
}
    // rust: let ground = DVec3::new(13.5, 69.62, -13.5);
    // rust: let columns = [(7, 5), (8, -4), (-6, -7)];
    // rust: assert_eq!(kept(ground, 100.0, &columns), [(-6, -7), (7, 5)]);
    // rust: assert_eq!(kept(ground, 49.5, &[(-2, -5)]), [(-2, -5)]);
    // rust: assert_eq!(kept(ground, 49.0, &[(-2, -5)]), []);
    // rust: assert_eq!(kept(DVec3::new(13.5, 151.62, -13.5), 50.0, &[(0, 0)]), []);
}

    /// With the camera looking straight up under a noon sun, our probe's Iris 1.11.7 map holds
    /// 7 columns there, which testing whole sections reproduces (a guess): the sections beside
    /// the camera whose 16 blocks reach above it are kept, even where their terrain lies below
    /// the camera.
pub fn the_shadow_pass_tests_whole_sections() void {
}
    // rust: let camera = DVec3::new(8.0, 6.0, 8.0);
    // rust: let up = world_projection(70.0, 16.0 / 9.0, 192.0)
    // rust: * Mat4::look_to_rh(Vec3::ZERO, Vec3::Y, Vec3::Z);
    // rust: let view = Frustum {
    // rust: planes: frustum(up),
}
        // The section east of the camera's, y 0..16, with ground only in its lowest 2 blocks.
    // rust: let mut sections = resident::Resident::<()>::default();
    // rust: let key = (1, -crate::chunk::MIN_Y / 16, 0);
    // rust: sections.insert_with_bounds(key, (), Some([Vec3::ZERO, Vec3::new(16.0, 2.0, 16.0)]));
    // rust: let drawn = |cull: &dyn Fn(&mut Vec<resident::Visible>)| {
    // rust: let mut out = Vec::new();
    // rust: cull(&mut out);
    // rust: out.iter().map(|v| v.key).collect::<Vec<_>>()
}
    // rust: let all = Frustum {
    // rust: planes: [Vec4::W; 6],
}
    // rust: let shadow = ShadowCull {
    // rust: light: all,
    // rust: casters: Some(shadow_casters(up, Vec3::Y)),
    // rust: reach: None,
}
    // rust: assert_eq!(
    // rust: drawn(&|out| sections.visible(camera, 4, &shadow, |_| true, |_, _| false, out)),
    // rust: [key]
    // rust: );
        // The camera's own view goes by the terrain's box, which lies below it.
    // rust: assert!(
    // rust: drawn(&|out| sections.visible(camera, 4, &view, |_| true, |_, _| false, out))
    // rust: .is_empty()
    // rust: );
}

    /// Our probe pack's Iris 1.11.7 shadow maps, under a noon sun with `shadowDistance` 128, hold
    /// the terrain at every depth along the light whatever planes the pack gives (#10403): from
    /// a cave at y -7, the surface's sections ~70 blocks toward the light with `shadowNearPlane`
    /// 0.05 and `shadowFarPlane` 256; from y 600, the ground ~535 blocks away with no planes set;
    /// and both with the planes at 200 and 210. Only the box's sides cull.
pub fn the_shadow_pass_draws_terrain_outside_the_pack_s_planes() void {
}
    // rust: let kept = |near: Option<f32>, far: Option<f32>, y: f64, min: [f32; 3], depth: bool| {
    // rust: let shadow = horizon_shaders::Shadow {
    // rust: distance: 128.0,
    // rust: near,
    // rust: far,
    // rust: ..horizon_shaders::Shadow::default()
}
    // rust: let camera = DVec3::new(13.5, y + 1.62, -13.5);
    // rust: let view = pack_post::ShadowView {
    // rust: cull: pack_uniforms::shadow_culling_at(Vec3::Y, camera, &shadow),
    // rust: light: Vec3::Y,
    // rust: distance: None,
    // rust: unculled: None,
    // rust: every_face: true,
    // rust: view_casters: false,
    // rust: depth_planes: depth,
}
    // rust: let cull = ShadowCull {
    // rust: light: shadow_box(&view),
    // rust: casters: None,
    // rust: reach: None,
}
    // rust: let min = Vec3::from(min);
    // rust: cull.intersects(min, min + 16.0)
}
        // The section holding the surface (y 64..80) above the cave, and the ground under y 600.
    // rust: let above = [-8.0, 64.0 - (-7.0 + 1.62), -8.0];
    // rust: let below = [-8.0, 64.0 - (600.0 + 1.62), -8.0];
    // rust: assert!(kept(Some(0.05), Some(256.0), -7.0, above, false));
    // rust: assert!(kept(None, None, 600.0, below, false));
    // rust: assert!(kept(Some(200.0), Some(210.0), -7.0, above, false));
    // rust: assert!(kept(Some(200.0), Some(210.0), 600.0, below, false));
        // A section 200 blocks off to the side is still outside the box.
    // rust: let side = [200.0, 0.0, -8.0];
    // rust: assert!(!kept(Some(0.05), Some(256.0), -7.0, side, false));
        // Horizon's own packs keep culling by their planes.
    // rust: assert!(!kept(Some(0.05), Some(256.0), -7.0, above, true));
}

    /// The margin doesn't follow the field of view: from the same camera under a noon sun, our
    /// probe's Iris 1.11.7 maps keep a section that needs a growth of 1.1224 blocks at a field of
    /// view of 70 (77° flying) and drop ones that need 1.1252 to 1.1422 at 50 (55° flying) and
    /// 70 (#8464).
pub fn the_shadow_pass_keeps_the_same_margin_at_every_field_of_view() void {
}
    // rust: let kept = |fov: f32, yaw: f32, pitch: f32, section: [f32; 3]| {
    // rust: let camera = world_projection(fov * 1.1, 16.0 / 9.0, 1024.0)
    // rust: * crate::camera::view_matrix(yaw, pitch);
    // rust: let cull = ShadowCull {
    // rust: light: Frustum {
    // rust: planes: [Vec4::W; 6],
    // rust: },
    // rust: casters: Some(shadow_casters(camera, Vec3::Y)),
    // rust: reach: None,
}
    // rust: let min = Vec3::new(
    // rust: section[0] * 16.0 - 13.5,
    // rust: section[1] * 16.0 - 69.62,
    // rust: section[2] * 16.0 + 13.5,
    // rust: );
    // rust: cull.intersects(min, min + 16.0)
}
        // fov 70, yaw 159, pitch 20: (4, 4, -4) needs 1.1224 blocks; Iris keeps it.
    // rust: assert!(kept(70.0, 159.0, 20.0, [4.0, 4.0, -4.0]));
        // fov 70, yaw 247.5: (1, 4, 0) needs 1.1253; Iris drops it.
    // rust: assert!(!kept(70.0, 247.5, 0.0, [1.0, 4.0, 0.0]));
        // fov 50, yaw 339, pitch -20: (3, 4, -1) needs 1.1252; looking south, (-2, 3, 0) needs
        // 1.1422. Iris drops both.
    // rust: assert!(!kept(50.0, 339.0, -20.0, [3.0, 4.0, -1.0]));
    // rust: assert!(!kept(50.0, 0.0, 0.0, [-2.0, 3.0, 0.0]));
}
}
