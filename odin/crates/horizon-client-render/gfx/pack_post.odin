//! Transpiled from Horizon Rust crate
package horizon_client_render_pack_post

import "core:fmt"
import "core:mem"
import "core:math"

// A shader pack's post-processing over Horizon's own world (spec 2.1 rows 4, 6, 8, 9; 6.1; 6.2;
// 6.4): the world renders into its own target as with a resolution scale, its colour becomes
// colortex0 and its depth `depthtex0`, then the pack's `prepare`, `deferred`, `composite` and
// `final` programs run in order, and `final` draws onto the screen under the hand and HUD.
// Gbuffers programs come later; until then the pack's composites read Horizon's picture.
//
// Every colortex buffer a program reads or writes has two textures, A and B. Programs read
// "main" and write "alt", and each buffer a program wrote flips afterwards (6.1.6). Every
// frame starts with A as "main". A cleared buffer has both textures cleared then (Iris 1.11.7
// reads and blends onto the clear value where a program leaves pixels, probed with a pack of our
// own). A buffer that is not cleared reads back what was written last (OQ-8): when the last
// frame ended on B, B is copied to A, and B keeps what was last written into it, which is what
// a write leaves alone or blends onto there (a model that fits Iris 1.11.7's values in probe
// packs of our own).
// Pack buffers store rows as GL does (row 0 at the bottom: the translator negates clip y), so
// the world is copied in upside down, and its reverse-Z depth becomes GL window depth.

// use std::collections::HashMap;

// use glam::{DMat4, DVec3};
// use horizon_shaders::{Format, Group, Kind, Post, SHADOW_COLORS};

// use super::pack_draw::DrawUniforms;
// use super::pack_entities::{PROGRAMS, PackEntities};
// use super::pack_images;
// use super::pack_sky::PackSky;
// use super::pack_textures;
// use super::pack_uniforms::{self, FrameUniforms, PackInputs};

BUFFERS :: horizon_shaders::BUFFERS

    // rust: mod packed;

    // rust: mod world_target_tests;

    // rust: mod higher_shadowcolor_tests;

    // rust: mod single_side_tests;

    // rust: mod shadow_faces_tests;

    // rust: mod forced_flip_tests;

    // rust: mod weather_depth_tests;

    // rust: mod custom_type_tests;

    // rust: mod sky_depth_tests;

// The texture behind a pack sampler name.
Source :: enum {
    Color(usize),
    Depth,
    // `depthtex1`: depth without translucent terrain (a copy taken before it).
    Depth1,
    // `depthtex2`: depth without translucent terrain and without the first-person hand.
    Depth2,
    Noise,
    // A 1×1 stand-in for names this slice does not provide yet.
    Dummy,
    // A 1×1 flat normal (128, 128, 255) stand-in when no normal map is present.
    Normals,
    // A 1×1 black (0, 0, 0, 0) stand-in when no specular map is present.
    Specular,
    // `texture.<stage>.<name>`: the pack's own texture, filtered and wrapped as its
    // `.mcmeta` says.
    Custom {,
    index: usize,
    blur: bool,
    clamp: bool,
    // rust: },
    // `image.<name>` through its sampler name.
    Image(usize),
    // A 1×1 depth of 1.0 behind a comparison sampler, until shadow maps exist: no shadow.
    Shadow,
    // The block atlas (pack_atlas.rs), in gbuffers programs.
    Atlas,
    Lightmap,
    // `shadowtex0`/`shadowtex1` (6.3), with depth comparison (`sampler2DShadow`) or not.
    ShadowDepth(usize, bool),
    // `shadowcolor0/1` read outside the shadow programs (in them they are `Color`).
    ShadowColor(usize),
}

Binding :: struct {
    source: Source,
    binding: u32,
    // A filtering sampler (the texture is filterable).
    filtering: bool,
    // The view's dimension: 2D, or 1D and 3D for custom textures and their stand-ins.
    dimension: wgpu::TextureViewDimension,
    // Where this texture's sampler object is bound: the first texture of each kind binds it
    // (`binding + 1`), the others share it (devices have as few as 16 sampler slots).
    sampler: u32,
}

// The sampler objects a pass binds, one slot per kind it uses.
SamplerKind :: enum {
    Linear,
    Nearest,
    Repeat,
    NearestRepeat,
    // The block atlas: nearest texels, blended between the two nearest levels.
    Atlas,
    // colortex buffers: linear, blended between the two nearest levels.
    Buffer,
    Comparison,
}

    // rust: impl SamplerKind {
of :: proc(source: Source, filtering: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match source {
    // rust: Source::Color(_) | Source::ShadowColor(_) | Source::Dummy if !filtering => {
    // rust: Self::Nearest
}
    // rust: Source::Depth | Source::Depth1 | Source::Depth2 | Source::ShadowDepth(_, false) => {
    // rust: Self::Nearest
}
    // rust: Source::Noise => Self::Repeat,
    // rust: Source::Shadow | Source::ShadowDepth(_, true) => Self::Comparison,
            // Blocks look as the game draws them: nearest texels. Between levels, Iris 1.11.7
            // blends `gtexture`'s two nearest (our probe packs, #9307: a read at level 1.25 is
            // levels 1 and 2 mixed 3:1).
    // rust: Source::Atlas if filtering => Self::Atlas,
    // rust: Source::Atlas | Source::Normals | Source::Specular => Self::NearestRepeat,
    // rust: Source::Image(_) if filtering => Self::Linear,
    // rust: Source::Image(_) => Self::Nearest,
    // rust: Source::Custom { blur, clamp, .. } => match (blur && filtering, clamp) {
    // rust: (true, true) => Self::Linear,
    // rust: (false, true) => Self::Nearest,
    // rust: (true, false) => Self::Repeat,
    // rust: (false, false) => Self::NearestRepeat,
    // rust: },
            // Iris 1.11.7 blends a buffer's two nearest mipmap levels (our probe packs, #9307:
            // every colortex read at levels 1.25 and 2.5 in composite and final).
    // rust: Source::Color(_) => Self::Buffer,
    // rust: Source::ShadowColor(_) | Source::Dummy | Source::Lightmap => Self::Linear,
}
}

binding_type :: proc(self: ^Self) -> w {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Linear | Self::Repeat | Self::Atlas | Self::Buffer => {
    // rust: wgpu::SamplerBindingType::Filtering
}
    // rust: Self::Nearest | Self::NearestRepeat => wgpu::SamplerBindingType::NonFiltering,
    // rust: Self::Comparison => wgpu::SamplerBindingType::Comparison,
}
}
}

// Points every sampler object of `module` at the slot `slot` gives its binding, so that
// samplers sharing a slot become one variable (two variables may not share a binding).
share_samplers :: proc(module: ^naga::Module, slot: ^HashMap<u32) {
}
    // rust: let mut first = HashMap::new();
    // rust: let mut same = HashMap::new();
    // rust: for (h, g) in module.global_variables.iter_mut() {
    // rust: let Some(b) = g.binding.as_mut() else {
    // rust: continue;
}
    // rust: if !matches!(module.types[g.ty].inner, naga::TypeInner::Sampler { .. }) {
    // rust: continue;
}
    // rust: let Some(&to) = slot.get(&b.binding) else {
    // rust: continue;
}
    // rust: b.binding = to;
    // rust: match first.entry(to) {
    // rust: std::collections::hash_map::Entry::Occupied(e) => _ = same.insert(h, *e.get()),
    // rust: std::collections::hash_map::Entry::Vacant(e) => _ = e.insert(h),
}
}
    // rust: if same.is_empty() {
    // rust: return;
}
    // rust: let fix = |expressions: &mut naga::Arena<naga::Expression>| {
    // rust: for (_, e) in expressions.iter_mut() {
    // rust: if let naga::Expression::GlobalVariable(g) = e
    // rust: && let Some(&to) = same.get(g)
    // rust: {
    // rust: *g = to;
}
}
}
    // rust: for (_, f) in module.functions.iter_mut() {
    // rust: fix(&mut f.expressions);
}
    // rust: for ep in &mut module.entry_points {
    // rust: fix(&mut ep.function.expressions);
}
}

// The sky's geometry and the programs that draw it: `gbuffers_skybasic` (disc, sunset, stars,
// void) and `gbuffers_skytextured` (sun, moon), each with its fallbacks. A part without a
// program is Horizon's own.
Sky :: struct {
    geometry: PackSky,
    basic: Maybe(Pass),
    textured: Maybe(Pass),
}

// Entities, block entities, translucent entity parts and particles a pack draws
// (`pack_entities::ENTITY`... order), after terrain or, `late`, after deferred; Horizon draws
// the others.
Entities :: struct {
    geometry: PackEntities,
    passes: [Maybe(Pass),
    late: [bool,
    // What draws entities and block entities into the shadow map (2.4).
    shadow: [Maybe(Pass),
    // Only the player, only block entities that emit light (3.2).
    only: (bool,
}

    // rust: impl Entities {
    // Whether a gbuffers program draws some of them (else only the shadow pass does).
drawn :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.passes.iter().any(Option::is_some)
}
}

// What an image binds: a buffer (`colorimgN`, the side its sampler reads) or one of the pack's.
Image :: enum {
    Color(usize),
    Custom(usize),
    // The copy of a buffer or a pack image taken before a dispatch, which its loads read.
    ColorBefore(usize),
    CustomBefore(usize),
    // An image no `image.*` gives: its stand-in of the declared format and dimension
    // (`pack_images::StandIn`).
    StandIn(wgpu::TextureFormat, wgpu::TextureViewDimension),
}

    // rust: impl Image {
buffer :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Image::Color(b) => Some(b),
    // rust: _ => None,
}
}
}

// The buffers and the pack images (masks) `images` read as copies taken before a dispatch.
befores :: proc(images: ^[(u32) {
}
    // rust: images
    // rust: .iter()
    // rust: .fold((0, 0), |(colors, customs), i| match i.1 {
    // rust: Image::ColorBefore(b) => (colors | 1 << b, customs),
    // rust: Image::CustomBefore(k) => (colors, customs | 1 << k),
    // rust: _ => (colors, customs),
    // rust: })
}

// The color buffers of `images`, as a mask.
image_buffers :: proc(images: ^[(u32) {
}
    // rust: images
    // rust: .iter()
    // rust: .filter_map(|i| i.1.buffer())
    // rust: .fold(0, |m, b| m | 1 << b)
}

// The format of the sink of passes that write only images.
SINK :: wgpu::TextureFormat::R8Unorm

// What packs use of the device beyond drawing. OpenGL ES and older drivers lack some of it: a
// program that needs what is missing is skipped with a note, and the game runs on without it.
Gpu :: struct {
    compute: bool,
    // Images and storage buffers written by fragment shaders.
    fragment_storage: bool,
    // Storage read and written by vertex shaders (a geometry stage).
    vertex_storage: bool,
    // `clear_texture`; without it images are cleared by copying zeros.
    clear: bool,
    adapter_formats: bool,
}

    // rust: impl Gpu {
of :: proc(adapter: ^wgpu::Adapter, features: wgpu::Features) -> S {
    // Ported from Horizon
    return {}
}
//         use wgpu::DownlevelFlags as D;
    // rust: let flags = adapter.get_downlevel_capabilities().flags;
    // rust: let mut gpu = Gpu {
    // rust: compute: flags.contains(D::COMPUTE_SHADERS),
    // rust: fragment_storage: flags.contains(D::FRAGMENT_WRITABLE_STORAGE),
    // rust: vertex_storage: flags.contains(D::VERTEX_STORAGE)
    // rust: && features.contains(wgpu::Features::VERTEX_WRITABLE_STORAGE),
    // rust: clear: features.contains(wgpu::Features::CLEAR_TEXTURE),
    // rust: adapter_formats: features
    // rust: .contains(wgpu::Features::TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES),
}
        // `HORIZON_SHADER_PACK_WITHOUT=compute,fragment-storage,vertex-storage,clear` tries the
        // fallbacks on a device that has it all.
    // rust: let without = std::env::var("HORIZON_SHADER_PACK_WITHOUT").unwrap_or_default();
    // rust: for w in without.split(',') {
    // rust: match w.trim() {
    // rust: "compute" => gpu.compute = false,
    // rust: "fragment-storage" => gpu.fragment_storage = false,
    // rust: "vertex-storage" => gpu.vertex_storage = false,
    // rust: "clear" => gpu.clear = false,
    // rust: _ => {}
}
}
    // rust: gpu
}

    // Whether textures of `format` can be bound as images.
    // rust: fn storable(
    // rust: self,
    // rust: adapter: &wgpu::Adapter,
    // rust: format: wgpu::TextureFormat,
    // rust: features: wgpu::Features,
    // rust: ) -> bool {
    // rust: let usages = if self.adapter_formats {
    // rust: adapter.get_texture_format_features(format).allowed_usages
    // rust: } else {
    // rust: format.guaranteed_format_features(features).allowed_usages
}
    // rust: (self.compute || self.fragment_storage)
    // rust: && usages.contains(wgpu::TextureUsages::STORAGE_BINDING)
}

    // The stages that may bind images and storage buffers.
storage_stages :: proc(self: ^Self) -> w {
    // Ported from Horizon
    return {}
}
    // rust: let mut stages = wgpu::ShaderStages::NONE;
    // rust: if self.compute {
    // rust: stages |= wgpu::ShaderStages::COMPUTE;
}
    // rust: if self.fragment_storage {
    // rust: stages |= wgpu::ShaderStages::FRAGMENT;
}
    // rust: if self.vertex_storage {
    // rust: stages |= wgpu::ShaderStages::VERTEX;
}
    // rust: stages
}
}

// A pass's pipeline: a draw, or a compute dispatch.
Pipeline :: enum {
    Render(wgpu::RenderPipeline),
    Compute {,
    pipeline: wgpu::ComputePipeline,
        // `workGroups`, else `workGroupsRender` and the local size.
    groups: Option<[u32; 3]>,
    render: [f32; 2],
    local: [u32; 3],
    // rust: },
}

Pass :: struct {
    name: string,
    group: Group,
    pipeline: Pipeline,
    layout: wgpu::BindGroupLayout,
    ubo: wgpu::Buffer,
    block: [dynamic]u8,
    // (index into `pack_uniforms::NAMES`, declared type, offset).
    uniforms: [dynamic](Option<uint,
    samplers: [dynamic]Binding,
    // (location, buffer) of each output that reaches a buffer.
    writes: Vec<(u32,
    // Buffers flipped after the pass.
    flip: u16,
    // `hz_depth_linear`: which of the depth samplers a plain sampler reads filter.
    depth_linear: [f32,
    // Buffers sampled, for the bind group cache key.
    reads: u16,
    // shadowcolor buffers sampled by a program of the other buffers.
    shadow_reads: u16,
    // Buffers written.
    written: u16,
    // Buffers whose mip chain is regenerated right before it (6.1.7).
    mipmaps: u16,
    // Reads the per-draw block (`DrawUniforms`).
    draw: bool,
    // What `texture` reads instead of the block atlas.
    atlas: Maybe(wgpu::TextureView),
    material_maps: bool,
    // Reads `mc_Entity`'s table (`PackPost::block_ids`).
    ids: bool,
    // Bind groups by the sides read (bits 0–15), the buffers whose mip chain is current (bits
    // 16–31) and the shadowcolor sides read (bits 32–33).
    groups: HashMap<u64,
    // The same for End portal draws, with `end_portal.png` bound as the atlas.
    portal_groups: HashMap<u64,
    // (binding, target) of each image: for a buffer, the side its sampler reads.
    images: Vec<(u32,
    // Binds the pack's storage buffers in set 4.
    buffers: bool,
    // Buffers both sampled and bound as images: sampled from a copy taken first, as wgpu binds
    // a texture one way per pass.
    copies: u16,
    // Compute programs dispatched before this pass.
    compute: [dynamic]Pass,
    // Writes no buffer, only images: draws into `Targets::sink`.
    sink: bool,
    // Instances to draw for a geometry stage folded into the vertex stage; 0 without one.
    geometry: u32,
    // The pack's images (bit n: `image.*` n) this pass samples and stores: sampled from a copy
    // taken just before it.
    image_copies: u64,
    // The pack's images a compute pass's loads read as they were before it: copied first.
    snapshots: u64,
    // `scale.<program>` (scale, offset x, offset y): the pass draws only that part of its
    // buffers and keeps the rest.
    viewport: Option<[f32,
}

    // rust: impl Pass {
render :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match &self.pipeline {
    // rust: Pipeline::Render(p) => p,
    // rust: Pipeline::Compute { .. } => unreachable!("a compute pass draws nothing"),
}
}
}

// One side of a buffer with mipmaps.
Mips :: struct {
    // Every level, for sampling.
    all: wgpu::TextureView,
    // From the second level down: its attachment, and a bind group over the level above.
    levels: Vec<(wgpu::TextureView,
}

// The picture a pack's `final` draws at the world's size while the window is another: it is
// copied onto the window once, after the pack's passes, as the game's own post pass does
// without a pack.
FinalTarget :: struct {
    size: [u32,
    view: wgpu::TextureView,
}

Targets :: struct {
    size: [u32,
    // A and B of each buffer used.
    color: [Option<[wgpu::TextureView,
    depth: wgpu::TextureView,
    depth_texture: wgpu::Texture,
    // Pre-translucent depth for `depthtex1`, also serving `depthtex2` without a shader hand.
    depth1: Option<(wgpu::Texture,
    // `depthtex2`, when a program after the hand reads it without the hand.
    depth2: Option<(wgpu::Texture,
    // Both sides' mip chains of the buffers with mipmaps (`color` is their first level).
    mips: [Option<[Mips,
    // Where a pass that both samples and stores a buffer samples it from.
    scratch: [Maybe(wgpu::TextureView),
    // Each buffer's size: the render size, or its `size.buffer`.
    sizes: [[u32,
    // The attachment of passes that write only images.
    sink: wgpu::TextureView,
}

// What a pack's gbuffers programs read and draw from the game's world.
    // rust: pub(super) struct World<'a> {
    // The block atlas and its size.
    // rust: pub atlas: Option<(wgpu::TextureView, [u32; 2])>,
    // Of a stitched block atlas, each sprite layer's place (`PackAtlas::rects_table`); empty
    // for a grid.
    // rust: pub sprite_rects: &'a [u32],
    // rust: pub material_maps: Option<[wgpu::TextureView; 2]>,
    // rust: pub lightmap: wgpu::TextureView,
    // Terrain's geometry, when the pack draws it.
    // rust: pub terrain: Option<Geometry<'a>>,
    // Of each block sprite layer, `mc_Entity` (id, then 1 for fluids or -1) and `at_midBlock.w`
    // (its block's light): three values a layer.
    // rust: pub block_ids: &'a [i32],
    // The atlas of the sun and moon's sprites.
    // rust: pub celestial: Option<wgpu::TextureView>,
    // rust: pub gui_size: [u32; 2],
    // Set 1 of the clouds' draw: their offset and palette.
    // rust: pub clouds: Option<&'a wgpu::BindGroupLayout>,
    // The game can hand its rain and snow to the pack.
    // rust: pub weather: bool,
    // The game can hand its first-person hand to the pack.
    // rust: pub hand: bool,
}

// This frame's block outline, when the pack draws it: the outline buffer (one instance per
// edge, pack_lines.rs) and the edges in it.
    // rust: pub(super) struct Lines {
    // rust: pub edges: wgpu::Buffer,
    // rust: pub count: u32,
}

// This frame's clouds, when the pack draws them: their vertices, uniform, quad indices and
// quad count.
    // rust: pub(super) struct Clouds {
    // rust: pub vertices: wgpu::Buffer,
    // rust: pub group: wgpu::BindGroup,
    // rust: pub indices: wgpu::Buffer,
    // rust: pub quads: u32,
}

// This frame's rain and snow, when the pack draws them: their vertices, the quad indices, the
// quads of each kind (rain, snow), each kind's sprite, and a number that changes with them.
    // rust: pub(super) struct Weather {
    // rust: pub vertices: wgpu::Buffer,
    // rust: pub indices: wgpu::Buffer,
    // rust: pub quads: [std::ops::Range<u32>; 2],
    // rust: pub sprites: [Option<wgpu::TextureView>; 2],
    // rust: pub generation: u64,
}

// Shadow cache: the key of the shadow map the shadow targets hold. Only the
// shadow passes write those targets, so while the key matches they still hold
// it and the pass is skipped.
ShadowCache :: struct {
    key: Maybe(ShadowCacheKey),
}

// Key for validating the shadow cache.
// Must match the cache state exactly to be considered valid.
ShadowCacheKey :: struct {
    sun_angle: f32,
    moon_angle: f32,
    snapped_camera: Maybe(DVec3),
    shadow_settings_hash: u64,
    shadow_scene_revision: (u64,
    ticks: u64,
    day_time: i64,
    shadow_uniforms_hash: u64,
}

PackPost :: struct {
    setup_pending: bool,
    notes: [dynamic]string,
    passes: [dynamic]Pass,
    // Shadow cache for temporal reprojection.
    shadow_cache: ShadowCache,
    // What draws terrain (`gbuffers_terrain` or its fallback), between `prepare` and `deferred`;
    // when the pack draws terrain in two parts, solid terrain only (`gbuffers_terrain_solid` or
    // its fallback).
    terrain: Maybe(Pass),
    // What draws cutout terrain (`gbuffers_terrain_cutout` or its fallback), after `terrain`,
    // when the pack draws terrain in two parts. A pack with no program for one part has only
    // the other.
    terrain_cutout: Maybe(Pass),
    // What draws translucent terrain (`gbuffers_water` or its fallback), after `deferred`.
    water: Maybe(Pass),
    // What draws the sky (`gbuffers_skybasic` or its fallback), before terrain, and its vertices.
    sky: Maybe(Sky),
    // What draws entities and block entities, after terrain, and their vertices.
    entities: Maybe(Entities),
    // What draws the clouds, after entities, and this frame's clouds.
    clouds: Maybe(Pass),
    // What draws the block outline (`gbuffers_line`, else `gbuffers_basic`), and this frame's.
    lines: Maybe(Pass),
    line_draw: Maybe(Lines),
    cloud_draw: Maybe(Clouds),
    // The pack draws the clouds (`gbuffers_clouds` or its fallback), even with a program that
    // writes nothing (a pack drawing its own clouds discards vanilla's), or `clouds=off`: the
    // game's clouds are not drawn.
    hides_clouds: bool,
    // The pack has a sky (`gbuffers_skybasic`) or sun and moon (`gbuffers_skytextured`)
    // program: vanilla's stays hidden even when the program writes nothing.
    hides_sky: bool,
    hides_celestial: bool,
    // `colortex0ClearColor`, when the pack sets it.
    sky_clear: Option<[f32,
    // What draws rain and snow (the same program, each with its kind's sprite as `texture`),
    // after translucent terrain, this frame's weather and the sprites' generation bound.
    weather: Option<[Pass,
    weather_draw: Maybe(Weather),
    weather_generation: u64,
    // What draws the first-person hand (`gbuffers_hand` or its fallback), after the opaque
    // world, and its vertices.
    hand: Option<(Pass,
    // The pre-translucent copy: `depthtex1`, or `depthtex2` without a shader hand.
    depth1: bool,
    // A program after the hand reads `depthtex2`: it is copied before the hand.
    depth2: bool,
    // The shadow buffers, when the shadow pass runs (2.5), and the `shadowcomp` programs.
    shadow_targets: Maybe(super::pack_shadow::ShadowTargets),
    // What draws terrain from the light (`shadow`), and translucent terrain (`shadow_water`).
    shadow_terrain: Maybe(Pass),
    // `end_portal.png`'s atlas rect this frame, and a texture of its own copied from it that
    // End portal draws bind as their atlas.
    portal_rect: [f32,
    portal_texture: Option<([f32,
    shadow_water: Maybe(Pass),
    shadow_comp: [dynamic]Pass,
    // Buffers with mipmaps (filterable ones a program asks them for).
    mipped: u16,
    // Buffers whose mip chain matches their first level, this frame.
    mips_valid: u16,
    // The downsampling pipeline of each format with mipmaps.
    down: HashMap<wgpu::TextureFormat,
    // The per-draw uniforms of gbuffers programs.
    draws: DrawUniforms,
    // Set 3 of flat terrain (`mc_Entity`'s table, then the sprites' places) and its bind group
    // for each arena page, with the page buffer it was made for.
    block_ids: Option<(wgpu::BindGroupLayout,
    page_groups: HashMap<u32,
    gui_size: [u32,
    // GPU time of each pass, while the renderer asks for it (`pack_timing.rs`).
    timing: Maybe(super::pack_timing::PassTiming),
    // `depthtex0` at the screen's centre, read back for `centerDepthSmooth`.
    center_depth: Maybe(super::pack_center_depth::CenterDepth),
    // `shaders.properties`' custom uniforms, after the frame's in `uniforms.values`.
    custom: horizon_shaders::Custom,
    atlas: Maybe(wgpu::TextureView),
    material_maps: Option<[wgpu::TextureView,
    lightmap: wgpu::TextureView,
    deferred_pre: u16,
    composite_pre: u16,
    formats: [wgpu::TextureFormat,
    clears: [Option<[f32,
    // Buffers of a three-channel format, and whether their textures are new: then they get
    // alpha 1 before the next frame.
    rgb: u16,
    rgb_unset: bool,
    used: u16,
    // Buffers some pass draws into the "alt" side of or flips; the others' B is their A.
    doubled: u16,
    // `size.buffer.*`.
    sizes: [Maybe(horizon_shaders::BufferSize),
    // Buffers bound as images, and those also copied for a pass that samples them.
    storage: u16,
    copied: u16,
    // Bit n set: B is buffer n's "main".
    main: u16,
    targets: Maybe(Targets),
    noise: wgpu::TextureView,
    dummy: wgpu::TextureView,
    dummy_black: wgpu::TextureView,
    dummy_normal: wgpu::TextureView,
    dummy_3d: wgpu::TextureView,
    dummy_1d: wgpu::TextureView,
    // `image.*` and `bufferObject.*`.
    images: [dynamic]pack_images::PackImage,
    // Set 5 of programs with a geometry stage.
    indices: Maybe(wgpu::BindGroupLayout),
    shadow_culling: horizon_shaders::ShadowCulling,
    gpu: Gpu,
    // Zeros to clear images by copying, where the device has no `clear_texture`.
    zeros: Maybe(wgpu::Buffer),
    // What the images no `image.*` gives bind.
    stand_ins: [dynamic]pack_images::StandIn,
    dump: Maybe(pack_images::Dump),
    buffers: pack_images::Buffers,
    textures: [dynamic]pack_textures::PackTexture,
    // The stand-in shadow map and its comparison sampler; cleared on the first frame.
    shadow: (wgpu::TextureView,
    shadow_cleared: bool,
    linear: wgpu::Sampler,
    nearest: wgpu::Sampler,
    repeat: wgpu::Sampler,
    nearest_repeat: wgpu::Sampler,
    atlas_sampler: wgpu::Sampler,
    // colortex buffers' (`SamplerKind::Buffer`).
    buffer_sampler: wgpu::Sampler,
    // None when it would write nothing: colortex0 holds integers and there is no depth to copy
    // nor buffer to clear.
    blit: Option<(wgpu::RenderPipeline,
    // The blit also writes depthtex0 (some program reads it) and clears these buffers.
    blit_depth: bool,
    blit_clears: [dynamic]uint,
    // Buffers cleared in passes of their own (more than the blit's eight attachments).
    other_clears: [dynamic]uint,
    // Source views identify the world target, including replacements at the same size.
    blit_group: Option<([wgpu::TextureView,
    // Shows colortex0 when the pack has no `final` (OQ-5).
    copy: (wgpu::RenderPipeline,
    // Copies the picture `final` drew at the world's size onto the window: no flip, it is
    // already in the screen's rows.
    upscale: (wgpu::RenderPipeline,
    // The picture `final` draws while the world's size is not the window's.
    final_target: Maybe(FinalTarget),
    screen: wgpu::TextureFormat,
    uniforms: FrameUniforms,
}

// The wgpu format of a pack format (6.7), the nearest one wgpu can render to.
texture_format :: proc(f: Format, features: wgpu::Features) -> w {
    // Ported from Horizon
    return {}
}
//     use wgpu::TextureFormat as T;
    // rust: let pick = |r, rg, rgba| match f.channels {
    // rust: 1 => r,
    // rust: 2 => rg,
    // rust: _ => rgba,
}
    // rust: let half = pick(T::R16Float, T::Rg16Float, T::Rgba16Float);
    // rust: match (f.kind, f.bits) {
    // rust: (Kind::Unorm, 10) => T::Rgb10a2Unorm,
    // rust: (Kind::Unorm, 16)
    // rust: if features.contains(
    // rust: wgpu::Features::TEXTURE_FORMAT_16BIT_NORM
    // rust: | wgpu::Features::TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES,
    // rust: ) =>
    // rust: {
    // rust: pick(T::R16Unorm, T::Rg16Unorm, T::Rgba16Unorm)
}
    // rust: (Kind::Unorm, b) if b <= 8 => pick(T::R8Unorm, T::Rg8Unorm, T::Rgba8Unorm),
    // rust: (Kind::Float, 32) => pick(T::R32Float, T::Rg32Float, T::Rgba32Float),
    // rust: (Kind::Float, 11) if features.contains(wgpu::Features::RG11B10UFLOAT_RENDERABLE) => {
    // rust: T::Rg11b10Ufloat
}
    // rust: (Kind::Int, 8) => pick(T::R8Sint, T::Rg8Sint, T::Rgba8Sint),
    // rust: (Kind::Int, 16) => pick(T::R16Sint, T::Rg16Sint, T::Rgba16Sint),
    // rust: (Kind::Int, _) => pick(T::R32Sint, T::Rg32Sint, T::Rgba32Sint),
    // rust: (Kind::Uint, 8) => pick(T::R8Uint, T::Rg8Uint, T::Rgba8Uint),
    // rust: (Kind::Uint, 10) => T::Rgb10a2Uint,
    // rust: (Kind::Uint, 16) => pick(T::R16Uint, T::Rg16Uint, T::Rgba16Uint),
    // rust: (Kind::Uint, _) => pick(T::R32Uint, T::Rg32Uint, T::Rgba32Uint),
        // Snorm, 16-bit norm without the feature, RGB9_E5: half floats hold them.
    // rust: _ => half,
}
}

// `format` where `renders` says it can be a colour target, else the nearest float format that can:
// the same channels at 16 bits, then `Rgba8Unorm`. On OpenGL the 32-bit and 16-bit float formats
// render only with `GL_EXT_color_buffer_float`/`half_float`, and wgpu aborts on creating a target
// without. Other formats pass through. Float colour buffers are only sampled (never blended), so
// RENDER_ATTACHMENT is the only usage that decides.
    // rust: fn renderable_float(
    // rust: format: wgpu::TextureFormat,
    // rust: renders: impl Fn(wgpu::TextureFormat) -> bool,
    // rust: ) -> wgpu::TextureFormat {
//     use wgpu::TextureFormat as T;
    // rust: let half = match format {
    // rust: T::R32Float | T::R16Float => T::R16Float,
    // rust: T::Rg32Float | T::Rg16Float => T::Rg16Float,
    // rust: T::Rgba32Float | T::Rgba16Float => T::Rgba16Float,
    // rust: _ => return format,
}
    // rust: if renders(format) {
    // rust: format
    // rust: } else if renders(half) {
    // rust: half
    // rust: } else {
    // rust: T::Rgba8Unorm
}
}

// [`texture_format`] made renderable on this adapter (see [`renderable_float`]).
    // rust: fn target_format(
    // rust: f: Format,
    // rust: features: wgpu::Features,
    // rust: adapter: &wgpu::Adapter,
    // rust: ) -> wgpu::TextureFormat {
    // rust: renderable_float(texture_format(f, features), |format| {
    // rust: (adapter.get_texture_format_features(format).allowed_usages)
    // rust: .contains(wgpu::TextureUsages::RENDER_ATTACHMENT)
    // rust: })
}

// The SNORM wgpu format of SNORM pack format `f`, where this adapter can render to it. Iris
// stores such a buffer clamped to [-1, 1] and quantised to its bits; elsewhere the half floats of
// [`texture_format`] stand in.
    // rust: fn snorm_format(
    // rust: f: Format,
    // rust: features: wgpu::Features,
    // rust: adapter: &wgpu::Adapter,
    // rust: ) -> Option<wgpu::TextureFormat> {
//     use wgpu::TextureFormat as T;
    // rust: let format = match (f.kind, f.bits, f.channels) {
    // rust: (Kind::Snorm, 8, 1) => T::R8Snorm,
    // rust: (Kind::Snorm, 8, 2) => T::Rg8Snorm,
    // rust: (Kind::Snorm, 8, _) => T::Rgba8Snorm,
    // rust: (Kind::Snorm, 16, 1) => T::R16Snorm,
    // rust: (Kind::Snorm, 16, 2) => T::Rg16Snorm,
    // rust: (Kind::Snorm, 16, _) => T::Rgba16Snorm,
    // rust: _ => return None,
}
    // rust: let mut needs = wgpu::Features::TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES;
    // rust: if f.bits == 16 {
    // rust: needs |= wgpu::Features::TEXTURE_FORMAT_16BIT_NORM;
}
    // rust: let renders = (adapter.get_texture_format_features(format).allowed_usages)
    // rust: .contains(wgpu::TextureUsages::RENDER_ATTACHMENT);
    // rust: (features.contains(needs) && renders).then_some(format)
}

// The texture behind sampler `name` in a program of the shadow buffers (`shadow_space`: buffer
// n is shadowcolor n) or of the others, when the shadow pass runs (`shadow_pass`). `shadow` is
// `shadowtex1` when the program also declares `watershadow` (6.3).
// Whether a `ty` sampler can read a custom texture of `sample_type`: custom textures hold
// colours, never depth to compare against.
fits :: proc(ty: string, sample_type: wgpu::TextureSampleType) -> b {
    // Ported from Horizon
    return {}
}
//     use wgpu::TextureSampleType as T;
    // rust: !ty.contains("Shadow")
    // rust: && match sample_type {
    // rust: T::Sint => ty.starts_with('i'),
    // rust: T::Uint => ty.starts_with('u'),
    // rust: _ => ty.starts_with('s'),
}
}

// `hz_depth_linear` for a program: 1 for each of shadowtex0, shadowtex1, `shadow` and
// `watershadow` whose depth filters (`linear`, bit n: shadowtex n). `shadow` is shadowtex1 in a
// program that also declares `watershadow` (6.3).
depth_linear :: proc(interface: ^horizon_shaders::Interface, linear: u8) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let watershadow = interface.samplers.iter().any(|s| s.name == "watershadow");
    // rust: [0, 1, usize::from(watershadow), 0].map(|n| f32::from(linear >> n & 1))
}

source :: proc(name: string, shadow_space: bool, shadow_pass: bool, watershadow: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let shadow_color = horizon_shaders::shadow_color(name);
    // rust: let shadow_depth = match name {
    // rust: "shadowtex0" | "watershadow" | "shadowtex0HW" => Some(0),
    // rust: "shadowtex1" | "shadowtex1HW" => Some(1),
    // rust: "shadow" => Some(usize::from(watershadow)),
    // rust: _ => None,
}
    // rust: if shadow_pass {
    // rust: if let Some(n) = shadow_depth {
    // rust: return Source::ShadowDepth(n, name.ends_with("HW"));
}
    // rust: if let Some(n) = shadow_color {
    // rust: return if shadow_space {
    // rust: Source::Color(n)
    // rust: } else {
    // rust: Source::ShadowColor(n)
}
}
}
    // rust: if shadow_space && horizon_shaders::buffer_index(name).is_some() {
        // colortex buffers are not this pass's.
    // rust: return Source::Dummy;
}
    // rust: match name {
    // rust: "depthtex0" | "gdepthtex" => Source::Depth,
    // rust: "depthtex1" => Source::Depth1,
    // rust: "depthtex2" => Source::Depth2,
    // rust: "noisetex" => Source::Noise,
    // rust: "texture" | "gtexture" | "tex" => Source::Atlas,
    // rust: "lightmap" => Source::Lightmap,
    // rust: "normals" => Source::Normals,
    // rust: "specular" => Source::Specular,
    // rust: n => horizon_shaders::buffer_index(n).map_or(Source::Dummy, Source::Color),
}
}

// 256×256 RGB white noise (6.4), from a fixed seed so every run looks the same.
noise :: proc(device: ^wgpu::Device, queue: ^wgpu::Queue) -> w {
    // Ported from Horizon
    return {}
}
    // rust: let mut state = 0x2545_f491_4f6c_dd1du64;
    // rust: let texels: Vec<u8> = (0..256 * 256 * 4)
    // rust: .map(|i| {
    // rust: state ^= state << 13;
    // rust: state ^= state >> 7;
    // rust: state ^= state << 17;
    // rust: if i % 4 == 3 { 255 } else { (state >> 56) as u8 }
    // rust: })
    // rust: .collect();
    // rust: texture(device, queue, "Shader pack noisetex", 256, &texels)
}

    // rust: fn texture(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: label: &str,
    // rust: side: u32,
    // rust: texels: &[u8],
    // rust: ) -> wgpu::TextureView {
    // rust: let size = wgpu::Extent3d {
    // rust: width: side,
    // rust: height: side,
    // rust: depth_or_array_layers: 1,
}
    // rust: let tex = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size,
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: queue.write_texture(
    // rust: tex.as_image_copy(),
    // rust: texels,
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(side * 4),
    // rust: rows_per_image: None,
    // rust: },
    // rust: size,
    // rust: );
    // rust: tex.create_view(&Default::default())
}

    // rust: fn sampler(
    // rust: device: &wgpu::Device,
    // rust: filter: wgpu::FilterMode,
    // rust: address: wgpu::AddressMode,
    // rust: ) -> wgpu::Sampler {
    // rust: device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Shader pack"),
    // rust: address_mode_u: address,
    // rust: address_mode_v: address,
    // rust: address_mode_w: address,
    // rust: mag_filter: filter,
    // rust: min_filter: filter,
    // rust: ..Default::default()
    // rust: })
}

// Runs `create` and returns its validation error, if any, or the backend's (a shader the
// driver's compiler refuses is an internal error). A panic while it runs is an error too:
// naga's backends turn a module they cannot write into a panic as the driver gets the pipeline
// (#3525), which a pack's program must not turn into a crash.
    // rust: fn checked<T>(device: &wgpu::Device, create: impl FnOnce() -> T) -> Result<T, String> {
    // rust: let validation = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let internal = device.push_error_scope(wgpu::ErrorFilter::Internal);
    // rust: let value = crate::crash::contain(create);
    // rust: let internal = pollster::block_on(internal.pop());
    // rust: match pollster::block_on(validation.pop()).or(internal) {
    // rust: Some(e) => {
            // The details are in the error's description or its sources.
    // rust: let mut message = match &e {
    // rust: wgpu::Error::Validation { source, .. } => format!("{source:?}"),
    // rust: e => e.to_string(),
}
    // rust: let mut source = std::error::Error::source(&e);
    // rust: while let Some(s) = source {
    // rust: message = format!("{message}: {s}");
    // rust: source = s.source();
}
    // rust: Err(message)
}
    // rust: None => value.map_err(|panic| format!("the shader compiler failed: {panic}")),
}
}

// A full-screen helper pipeline of ours (`pack_post.wgsl`).
    // rust: fn helper(
    // rust: device: &wgpu::Device,
    // rust: vertex: &str,
    // rust: entry: &str,
    // rust: entries: &[wgpu::BindGroupLayoutEntry],
    // rust: targets: &[Option<wgpu::ColorTargetState>],
    // rust: depth: Option<wgpu::DepthStencilState>,
    // rust: ) -> (wgpu::RenderPipeline, wgpu::BindGroupLayout) {
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Shader pack helpers"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("pack_post.wgsl").into()),
    // rust: });
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some(entry),
    // rust: entries,
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some(entry),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(entry),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: Some(vertex),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: depth,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: Some(entry),
    // rust: compilation_options: Default::default(),
    // rust: targets,
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: (pipeline, layout)
}

entry :: proc(binding: u32, ty: wgpu::BindingType) -> w {
    // Ported from Horizon
    return {}
}
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT | wgpu::ShaderStages::COMPUTE,
    // rust: ty,
    // rust: count: None,
}
}

texture_entry :: proc(binding: u32, sample_type: wgpu::TextureSampleType) -> w {
    // Ported from Horizon
    return {}
}
    // rust: texture_entry_of(binding, sample_type, wgpu::TextureViewDimension::D2)
}

    // rust: fn texture_entry_of(
    // rust: binding: u32,
    // rust: sample_type: wgpu::TextureSampleType,
    // rust: view_dimension: wgpu::TextureViewDimension,
    // rust: ) -> wgpu::BindGroupLayoutEntry {
    // rust: entry(
    // rust: binding,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type,
    // rust: view_dimension,
    // rust: multisampled: false,
    // rust: },
    // rust: )
}

// `blend.<program>`'s factors as wgpu's, adding both terms.
blend_state :: proc(b: horizon_shaders::Blend) -> w {
    // Ported from Horizon
    return {}
}
//     use horizon_shaders::Factor as F;
//     use wgpu::BlendFactor as W;
    // rust: let f = |f| match f {
    // rust: F::Zero => W::Zero,
    // rust: F::One => W::One,
    // rust: F::SrcColor => W::Src,
    // rust: F::OneMinusSrcColor => W::OneMinusSrc,
    // rust: F::DstColor => W::Dst,
    // rust: F::OneMinusDstColor => W::OneMinusDst,
    // rust: F::SrcAlpha => W::SrcAlpha,
    // rust: F::OneMinusSrcAlpha => W::OneMinusSrcAlpha,
    // rust: F::DstAlpha => W::DstAlpha,
    // rust: F::OneMinusDstAlpha => W::OneMinusDstAlpha,
    // rust: F::SrcAlphaSaturate => W::SrcAlphaSaturated,
}
    // rust: let component = |src, dst| wgpu::BlendComponent {
    // rust: src_factor: f(src),
    // rust: dst_factor: f(dst),
    // rust: operation: wgpu::BlendOperation::Add,
}
    // rust: wgpu::BlendState {
    // rust: color: component(b[0], b[1]),
    // rust: alpha: component(b[2], b[3]),
}
}

// A buffer whose texels are floats (normalized or not), not integers.
holds_floats :: proc(format: wgpu::TextureFormat) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: format.sample_type(None, None),
    // rust: Some(wgpu::TextureSampleType::Float { .. })
    // rust: )
}

target :: proc(format: wgpu::TextureFormat) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })
}

// Color-attachment cost includes component alignment, not only the copied texel size.
attachment_bytes :: proc(bytes: u32, format: wgpu::TextureFormat) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let alignment = format
    // rust: .target_component_alignment()
    // rust: .expect("color attachment");
    // rust: bytes.next_multiple_of(alignment) + format.target_pixel_byte_cost().expect("color attachment")
}

// The viewport of `scale.<program>` (scale, offset x, offset y) on buffers of `size`, in whole
// pixels, at least one and inside them. Buffer rows are GL's, so the offsets count from GL's
// bottom-left corner as they are.
viewport :: proc(size: [u32; 2], y]: [f32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let [w, h] = size.map(|n| n as f32);
    // rust: let (x, y) = ((x * w).floor().min(w - 1.0), (y * h).floor().min(h - 1.0));
    // rust: [
    // rust: x,
    // rust: y,
    // rust: (scale * w).floor().clamp(1.0, w - x),
    // rust: (scale * h).floor().clamp(1.0, h - y),
    // rust: ]
}

    // rust: fn attach(
    // rust: view: &wgpu::TextureView,
    // rust: ops: wgpu::Operations<wgpu::Color>,
    // rust: ) -> Option<wgpu::RenderPassColorAttachment<'_>> {
    // rust: Some(wgpu::RenderPassColorAttachment {
    // rust: view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops,
    // rust: })
}

// Which of the frame's terrain draws: the camera's solid or translucent ones, or the shadow
// camera's.
    // rust: pub(super) enum TerrainList {
    // rust: Solid,
    // rust: Translucent,
    // rust: ShadowSolid,
    // rust: ShadowTranslucent,
}

    // rust: impl TerrainList {
translucent :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Self::Translucent | Self::ShadowTranslucent)
}
}

// Draws the game's terrain of one list into a pass; calls its third argument with each arena
// page before drawing from it.
// Draws a list's terrain: indexed, or for a program with a geometry stage, without indices and
// with that many instances (and its index buffer bound in set 5 by this layout).
    // rust: pub(super) type TerrainDraw<'a> = dyn FnMut(
    // rust: &mut wgpu::RenderPass<'_>,
    // rust: TerrainList,
    // rust: &dyn Fn(&mut wgpu::RenderPass<'_>, u32),
    // rust: Option<(u32, &wgpu::BindGroupLayout)>,
    // rust: ) + 'a;

// What the shadow camera sees of the terrain, for the game's draw lists: its view and
// projection in wgpu's clip space, the direction toward the light, and how far from the camera
// terrain is drawn (`shadowDistanceRenderMul`).
    // rust: pub(super) struct ShadowView {
    // rust: pub cull: glam::Mat4,
    // rust: pub light: glam::Vec3,
    // rust: pub distance: Option<f32>,
    // Draw everything, every face, within this many blocks (`shadow.culling=false|reversed`):
    // packs that voxelize the world in their shadow pass need all of it.
    // rust: pub unculled: Option<f32>,
    // Every face of the drawn sections, not only those that can face the light. Iris 1.11.7's
    // shadow map holds the faces turned away from the light too (#9033): under a hill at low sun
    // a cave's ceiling, which faces away, is often all that shadows the cave.
    // rust: pub every_face: bool,
    // Only the sections whose shadow can fall into the camera's view: those the camera's
    // frustum, stretched toward the light, takes in (`shadow_casters`). Our probes' Iris 1.11.7
    // maps fit keeping only those with `shadow.culling` unset (#8464): under a noon sun, only
    // the terrain above the ground the camera sees; with a low sun ahead, none behind the camera.
    // rust: pub view_casters: bool,
    // Whether the projection's near and far planes in `cull` drop sections too. Our probes'
    // Iris 1.11.7 maps hold the terrain at every depth we put it along the light (from 535 blocks
    // beyond the shadow camera to about 120 before it), whatever `shadowNearPlane` and
    // `shadowFarPlane` the pack sets, or none (#10403): only its sides cull.
    // rust: pub depth_planes: bool,
}

// Set 3 of flat terrain, read by the vertex stage: the sprite layers' table (`mc_Entity`'s id
// and fluid, `at_midBlock.w`; -1, -1, 0 when empty), per arena page, the page's vertices
// (a vertex reads its quad's corners for its normal), and each sprite's place in a stitched
// atlas (`rects`; zeros for a grid, which doesn't read them).
    // rust: fn block_ids(
    // rust: device: &wgpu::Device,
    // rust: table: &[i32],
    // rust: rects: &[u32],
    // rust: ) -> (wgpu::BindGroupLayout, wgpu::Buffer, wgpu::Buffer) {
    // rust: let empty = [-1, -1, 0];
    // rust: let table = if table.is_empty() { &empty[..] } else { table };
    // rust: let buffer = |label, contents: &[u8]| {
    // rust: wgpu::util::DeviceExt::create_buffer_init(
    // rust: device,
    // rust: &wgpu::util::BufferInitDescriptor {
    // rust: label: Some(label),
    // rust: contents,
    // rust: usage: wgpu::BufferUsages::STORAGE,
    // rust: },
    // rust: )
}
    // rust: let rects = if rects.is_empty() { &[0, 0][..] } else { rects };
    // rust: let ids = buffer("Shader pack block ids", bytemuck::cast_slice(table));
    // rust: let rects = buffer("Shader pack sprite rects", bytemuck::cast_slice(rects));
    // rust: let storage = |binding| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::VERTEX,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Storage { read_only: true },
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
}
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Shader pack terrain"),
    // rust: entries: &[storage(0), storage(1), storage(2)],
    // rust: });
    // rust: (layout, ids, rects)
}

// The game's geometry a gbuffers program draws: its vertex buffers and, for flat draws
// (flat.rs), the layout of their bind group 1.
    // rust: pub(super) struct Geometry<'a> {
    // rust: pub buffers: &'a [Option<wgpu::VertexBufferLayout<'a>>],
    // rust: pub table: Option<&'a wgpu::BindGroupLayout>,
    // Writes depth (the sky does not).
    // rust: pub depth_write: bool,
    // What `texture` reads instead of the block atlas.
    // rust: pub atlas: Option<wgpu::TextureView>,
    // This draw uses the block atlas's surface identities.
    // rust: pub material_maps: bool,
    // `mc_Entity`'s table at set 3 (flat terrain).
    // rust: pub ids: Option<&'a wgpu::BindGroupLayout>,
    // Back faces are culled, as for the game's own terrain.
    // rust: pub cull: bool,
}

// What a pack brings besides its programs: custom textures, images and storage buffers.
Resources :: struct {
    textures: ^'a [pack_textures::PackTexture],
    images: ^'a [pack_images::PackImage],
    // The images this device can't make.
    left_out: ^'a [horizon_shaders::CustomImage],
    buffers: ^'a pack_images::Buffers,
    // Set 5 of a program with a geometry stage: the draw's indices.
    indices: Maybe(^'a wgpu::BindGroupLayout),
    gpu: Gpu,
    // The buffers whose format can be bound as an image.
    storable: u16,
    // The buffers of a three-channel format (`rgb`): they have no alpha to write, and read 1.
    rgb: u16,
    // The bits per channel a buffer of a small packed format keeps ([`packed::bits`]).
    packed: [Option<[u8,
    // The stage (`texture.<stage>`) of the programs built so far, and the buffers one of them
    // flipped: a `texture.<stage>.colortexN` no longer stands in for buffer N in the stage's
    // later programs, which read what was written, as in Iris. `final` continues
    // `composite`'s. (Super Duper Vanilla's `texture.composite.colortex0` is its clouds, read
    // before `composite4` writes bloom there; Bliss's `colortex6` is blue noise until
    // `composite5` writes it.)
    released: std::cell::Cell<(^'static str,
    // The formats and dimensions of the images no `image.*` gives, for their stand-ins.
    stand_ins: ^'a std::cell::RefCell<Vec<(wgpu::TextureFormat,
    // Bit n: shadowtex n read through a plain sampler filters linearly (`shadowtexNNearest`
    // unset): the translator's helpers blend a gather of it (`hz_depth_linear`).
    shadow_linear: u8,
}

// A program's bind group layout (its uniform block, samplers and images) and how each sampler
// and image binds. `None` (with a note) for an image the game can't give it.
    // rust: fn bindings(
    // rust: features: wgpu::Features,
    // rust: interface: &horizon_shaders::Interface,
    // rust: name: &str,
    // rust: group: Group,
    // rust: buffers: &[u32],
    // rust: geometry: Option<&Geometry<'_>>,
    // rust: formats: &[wgpu::TextureFormat; BUFFERS],
    // rust: shadow: Option<&[wgpu::TextureFormat; SHADOW_COLORS]>,
    // rust: notes: &mut Vec<String>,
    // rust: pack: &Resources<'_>,
    // rust: ) -> Option<(
    // rust: Vec<wgpu::BindGroupLayoutEntry>,
    // rust: Vec<Binding>,
    // rust: HashMap<u32, u32>,
    // rust: u16,
    // rust: u16,
    // rust: Vec<(u32, Image)>,
    // rust: )> {
    // rust: let textures = pack.textures;
    // rust: if let Some(b) = interface.buffers.iter().find(|&&b| !pack.buffers.has(b)) {
    // rust: notes.push(format!("{name}: buffer {b} has no `bufferObject.{b}`"));
    // rust: return None;
}
    // rust: let mut entries = vec![entry(
    // rust: 0,
    // rust: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: )];
    // rust: let mut samplers = Vec::new();
    // rust: let (mut kinds, mut slots) = (HashMap::new(), HashMap::new());
    // rust: let mut reads = 0u16;
    // rust: let mut shadow_reads = 0u16;
    // rust: let watershadow = interface.samplers.iter().any(|s| s.name == "watershadow");
    // A gbuffers pass draws into its buffers and the depth buffer: reading them as well would
    // be a feedback loop (undefined in GL, refused by wgpu), so those read a blank texture.
    // rust: let in_place = match geometry {
    // rust: Some(_) => buffers.iter().fold(0u16, |m, &b| m | 1 << b),
    // rust: None => 0,
}
    // rust: for s in &interface.samplers {
    // rust: let float = wgpu::TextureSampleType::Float { filterable: true };
        // A stand-in of the sampler's own dimension.
    // rust: let stand_in = if s.ty.contains("1D") {
    // rust: wgpu::TextureViewDimension::D1
    // rust: } else if s.ty.contains("3D") {
    // rust: wgpu::TextureViewDimension::D3
    // rust: } else {
    // rust: wgpu::TextureViewDimension::D2
}
    // rust: if let Some(def) = pack
    // rust: .left_out
    // rust: .iter()
    // rust: .find(|d| d.sampler.as_deref() == Some(s.name.as_str()))
    // rust: {
    // rust: notes.push(format!(
    // rust: "{name}: samples image `{}`, which is left out",
    // rust: def.name
    // rust: ));
    // rust: return None;
}
    // rust: let released = pack.released.get();
    // rust: let custom = pack_textures::find(textures, group, &s.ty, &s.name).filter(|&i| {
    // rust: let t = &textures[i];
            // A PNG under `texture.<stage>.<name>` whose name is no sampler of the game's
            // isn't bound: the sampler reads as if it had no texture. Iris 1.11.7 with a probe
            // pack of ours (#9064) bound it over `gaux2` and `noisetex` but not over names of its
            // own, where a raw texture was bound; this rule is a fit to those cases.
    // rust: let unbound = t.png
    // rust: && t.stage != horizon_shaders::EVERY_STAGE
    // rust: && source(&s.name, false, true, false) == Source::Dummy;
    // rust: !unbound
    // rust: && (t.stage != pack_textures::stage(group)
    // rust: || released.0 != t.stage
    // rust: || horizon_shaders::buffer_index(&t.name)
    // rust: .is_none_or(|b| released.1 & 1 << b == 0))
    // rust: });
    // rust: let image = pack
    // rust: .images
    // rust: .iter()
    // rust: .position(|i| i.def.sampler.as_deref() == Some(s.name.as_str()));
    // rust: let (src, sample_type, dimension) = match custom {
    // rust: _ if let Some(k) = image => {
    // rust: let i = &pack.images[k];
    // rust: (Source::Image(k), i.sample_type(features), i.dimension)
}
    // rust: Some(i) if !fits(&s.ty, textures[i].sample_type) => {
    // rust: notes.push(format!(
    // rust: "{name}: `{} {}` can't read texture.{}.{}",
    // rust: s.ty, s.name, textures[i].stage, textures[i].name
    // rust: ));
    // rust: (Source::Dummy, float, stand_in)
}
    // rust: Some(i) => {
    // rust: let t = &textures[i];
    // rust: let src = match t.image {
    // rust: pack_textures::Image::Lightmap => Source::Lightmap,
    // rust: pack_textures::Image::Atlas => Source::Atlas,
    // rust: pack_textures::Image::View(_) => Source::Custom {
    // rust: index: i,
    // rust: blur: t.blur,
    // rust: clamp: t.clamp,
    // rust: },
}
    // rust: (src, t.sample_type, t.dimension)
}
    // rust: None => {
    // rust: let mut src = source(&s.name, group.shadow(), shadow.is_some(), watershadow);
                // A sampler the game gives no texture reads texture unit 0, as do the atlas's
                // names: the atlas in gbuffers programs, `colortex0` in deferred, composite and
                // final (OptiFine's shaders.txt). Iris 1.11.7 read the atlas through a name of
                // ours in gbuffers_terrain, and the scene in `colortex0` through such a name and
                // through `gtexture`, `tex` and `texture` in those three, with or without
                // `colortex0` declared (probe packs of ours, #9307). Translucent programs and
                // the other groups weren't measured and keep the stand-in.
    // rust: let unit_0 = match group {
    // rust: Group::Gbuffers => Some(Source::Atlas),
    // rust: Group::Deferred | Group::Composite | Group::Final => Some(Source::Color(0)),
    // rust: _ => None,
}
                // A name of the game's that has no texture here (a shadow sampler with no
                // shadow pass) stays blank; so does a sampler that isn't 2D, and one under a
                // `texture.<stage>.<name>` left unbound (#9064's probe read a 16-texel-wide
                // texture there in final, undiagnosed).
    // rust: let unknown = src == Source::Dummy
    // rust: && source(&s.name, false, true, false) == Source::Dummy
    // rust: && s.ty == "sampler2D"
    // rust: && !textures.iter().any(|t| t.name == s.name);
                // colortex0 to colortex3 (gcolor, gdepth, gnormal, composite) are no gbuffers
                // samplers in shaders.txt's table: Iris 1.11.7 read the atlas through each of
                // colortex0-3 and gnormal in gbuffers_terrain (our probe, #9307).
    // rust: let not_gbuffers =
    // rust: group == Group::Gbuffers && matches!(src, Source::Color(n) if n < 4);
    // rust: if let Some(unit_0) = unit_0
    // rust: && (src == Source::Atlas || unknown || not_gbuffers)
    // rust: {
    // rust: src = unit_0;
}
    // rust: let blank = match src {
                    // The shadow pass writes the shadow map.
    // rust: Source::ShadowDepth(..) => group == Group::Shadow,
    // rust: Source::Atlas => geometry.is_none(),
    // rust: Source::Depth => geometry.is_some(),
                    // Translucent terrain reads the copy; opaque terrain would read itself.
    // rust: Source::Depth1 | Source::Depth2 => group == Group::Gbuffers,
    // rust: Source::Color(n) => in_place & 1 << n != 0,
    // rust: _ => false,
}
    // rust: let mut sample_type = match src {
    // rust: Source::Color(n) => formats[n]
    // rust: .sample_type(None, Some(features))
    // rust: .unwrap_or(float),
    // rust: Source::ShadowColor(n) => shadow
    // rust: .and_then(|f| f[n].sample_type(None, Some(features)))
    // rust: .unwrap_or(float),
    // rust: Source::Depth | Source::Depth1 | Source::Depth2 | Source::ShadowDepth(..) => {
    // rust: wgpu::TextureSampleType::Float { filterable: false }
}
                    // Unfilterable on WebGPU-level devices; the lightmap is sampled at texel centres.
    // rust: Source::Lightmap => float,
    // rust: _ => float,
}
    // rust: let int = !matches!(sample_type, wgpu::TextureSampleType::Float { .. });
    // rust: if s.ty == "sampler2DShadow" {
    // rust: src = match src {
    // rust: Source::ShadowDepth(n, _) => Source::ShadowDepth(n, true),
    // rust: _ => Source::Shadow,
}
    // rust: sample_type = wgpu::TextureSampleType::Depth;
}
    // rust: let wanted = match s.ty.as_str() {
    // rust: "sampler2DShadow" => true,
    // rust: "sampler2D" => !int,
    // rust: "isampler2D" => sample_type == wgpu::TextureSampleType::Sint,
    // rust: "usampler2D" => sample_type == wgpu::TextureSampleType::Uint,
    // rust: _ => false,
}
    // rust: if !wanted {
    // rust: notes.push(format!(
    // rust: "{}: `{} {}` is not provided yet",
    // rust: name, s.ty, s.name
    // rust: ));
    // rust: (src, sample_type) = (Source::Dummy, float);
}
    // rust: if blank && sample_type == wgpu::TextureSampleType::Depth {
    // rust: src = Source::Shadow;
    // rust: } else if blank {
                    // The blank texture is float: an integer sampler then fails the pipeline (a note).
    // rust: src = Source::Dummy;
    // rust: if int {
    // rust: sample_type = float;
}
}
    // rust: let dimension = match src {
    // rust: Source::Dummy => stand_in,
    // rust: _ => wgpu::TextureViewDimension::D2,
}
    // rust: (src, sample_type, dimension)
}
}
    // rust: let filtering = sample_type == float;
    // rust: match src {
    // rust: Source::Color(n) => reads |= 1 << n,
    // rust: Source::ShadowColor(n) => shadow_reads |= 1 << n,
    // rust: _ => {}
}
    // rust: entries.push(texture_entry_of(s.binding, sample_type, dimension));
    // rust: let kind = SamplerKind::of(src, filtering);
    // rust: let sampler = *kinds.entry(kind).or_insert_with(|| {
    // rust: entries.push(entry(
    // rust: s.binding + 1,
    // rust: wgpu::BindingType::Sampler(kind.binding_type()),
    // rust: ));
    // rust: s.binding + 1
    // rust: });
    // rust: slots.insert(s.binding + 1, sampler);
    // rust: samplers.push(Binding {
    // rust: source: src,
    // rust: binding: s.binding,
    // rust: filtering,
    // rust: sampler,
    // rust: dimension,
    // rust: });
}
    // rust: let mut images = Vec::new();
    // rust: for i in &interface.images {
    // rust: let buffer = i
    // rust: .name
    // rust: .strip_prefix("colorimg")
    // rust: .and_then(|n| n.parse::<usize>().ok())
    // rust: .filter(|&n| n < BUFFERS && !group.shadow());
    // rust: let own = pack.images.iter().position(|c| c.def.name == i.name);
    // rust: let Some(format) = image_format(&i.format) else {
    // rust: notes.push(format!("{name}: `{}` has format {}", i.name, i.format));
    // rust: return None;
}
    // rust: let dimension = if i.ty.ends_with("1D") {
    // rust: wgpu::TextureViewDimension::D1
    // rust: } else if i.ty.ends_with("3D") {
    // rust: wgpu::TextureViewDimension::D3
    // rust: } else {
    // rust: wgpu::TextureViewDimension::D2
}
        // An image no `image.*` gives reads zero, also after the program stored into it
        // (Iris 1.11.7, observed with a probe pack).
    // rust: let stand_in = |of: &str, notes: &mut Vec<String>| {
    // rust: notes.push(format!(
    // rust: "{name}: image `{of}` has no `image.{of}`; it reads zero"
    // rust: ));
    // rust: let mut stand_ins = pack.stand_ins.borrow_mut();
    // rust: if !stand_ins.contains(&(format, dimension)) {
    // rust: stand_ins.push((format, dimension));
}
    // rust: (Image::StandIn(format, dimension), format)
}
    // rust: let (target, actual) = match (buffer, own) {
    // rust: (_, Some(k)) => (Image::Custom(k), pack.images[k].format),
    // rust: (Some(b), None) => (Image::Color(b), formats[b]),
    // rust: (None, None) if i.before.is_some() => {
                // Bound as the image it copies.
    // rust: let of = i.before.as_deref().unwrap_or_default();
    // rust: let buffer = of
    // rust: .strip_prefix("colorimg")
    // rust: .and_then(|n| n.parse::<usize>().ok())
    // rust: .filter(|&n| n < BUFFERS && !group.shadow());
    // rust: match (buffer, pack.images.iter().position(|c| c.def.name == of)) {
    // rust: (_, Some(k)) => (Image::CustomBefore(k), pack.images[k].format),
    // rust: (Some(b), None) => (Image::ColorBefore(b), formats[b]),
    // rust: (None, None) => stand_in(of, notes),
}
}
    // rust: (None, None) => stand_in(&i.name, notes),
}
    // rust: if actual != format {
    // rust: notes.push(format!(
    // rust: "{name}: `{}` is {} but its texture is {actual:?}",
    // rust: i.name, i.format
    // rust: ));
    // rust: return None;
}
    // rust: let access = match i.access.as_str() {
    // rust: "writeonly" => wgpu::StorageTextureAccess::WriteOnly,
    // rust: "readonly" => wgpu::StorageTextureAccess::ReadOnly,
    // rust: "atomic" => wgpu::StorageTextureAccess::Atomic,
    // rust: _ => wgpu::StorageTextureAccess::ReadWrite,
}
    // rust: if let Image::Color(b) | Image::ColorBefore(b) = target
    // rust: && pack.storable & 1 << b == 0
    // rust: {
    // rust: notes.push(format!(
    // rust: "{name}: `{}` can't be an image on this GPU; skipped",
    // rust: i.name
    // rust: ));
    // rust: return None;
}
    // rust: entries.push(wgpu::BindGroupLayoutEntry {
    // rust: binding: i.binding,
    // rust: visibility: pack.gpu.storage_stages(),
    // rust: ty: wgpu::BindingType::StorageTexture {
    // rust: access,
    // rust: format,
    // rust: view_dimension: dimension,
    // rust: },
    // rust: count: None,
    // rust: });
    // rust: images.push((i.binding, target));
}
    // rust: Some((entries, samplers, slots, reads, shadow_reads, images))
}

// The wgpu format of an image's format qualifier.
image_format :: proc(qualifier: string) -> O {
    // Ported from Horizon
    return {}
}
//     use wgpu::TextureFormat as T;
    // rust: Some(match qualifier {
    // rust: "rgba32f" => T::Rgba32Float,
    // rust: "rgba16f" => T::Rgba16Float,
    // rust: "rg32f" => T::Rg32Float,
    // rust: "rg16f" => T::Rg16Float,
    // rust: "r11f_g11f_b10f" => T::Rg11b10Ufloat,
    // rust: "r32f" => T::R32Float,
    // rust: "r16f" => T::R16Float,
    // rust: "rgba16" => T::Rgba16Unorm,
    // rust: "rgb10_a2" => T::Rgb10a2Unorm,
    // rust: "rgba8" => T::Rgba8Unorm,
    // rust: "rg16" => T::Rg16Unorm,
    // rust: "rg8" => T::Rg8Unorm,
    // rust: "r16" => T::R16Unorm,
    // rust: "r8" => T::R8Unorm,
    // rust: "rgba16_snorm" => T::Rgba16Snorm,
    // rust: "rgba8_snorm" => T::Rgba8Snorm,
    // rust: "rg16_snorm" => T::Rg16Snorm,
    // rust: "rg8_snorm" => T::Rg8Snorm,
    // rust: "r16_snorm" => T::R16Snorm,
    // rust: "r8_snorm" => T::R8Snorm,
    // rust: "rgba32i" => T::Rgba32Sint,
    // rust: "rgba16i" => T::Rgba16Sint,
    // rust: "rgba8i" => T::Rgba8Sint,
    // rust: "rg32i" => T::Rg32Sint,
    // rust: "rg16i" => T::Rg16Sint,
    // rust: "rg8i" => T::Rg8Sint,
    // rust: "r32i" => T::R32Sint,
    // rust: "r16i" => T::R16Sint,
    // rust: "r8i" => T::R8Sint,
    // rust: "rgba32ui" => T::Rgba32Uint,
    // rust: "rgba16ui" => T::Rgba16Uint,
    // rust: "rgb10_a2ui" => T::Rgb10a2Uint,
    // rust: "rgba8ui" => T::Rgba8Uint,
    // rust: "rg32ui" => T::Rg32Uint,
    // rust: "rg16ui" => T::Rg16Uint,
    // rust: "rg8ui" => T::Rg8Uint,
    // rust: "r32ui" => T::R32Uint,
    // rust: "r16ui" => T::R16Uint,
    // rust: "r8ui" => T::R8Uint,
    // rust: _ => return None,
    // rust: })
}

// The value slot of the pack's custom uniform `name` for a program declaring it as GLSL type
// `ty`: after the frame's uniforms, in the order of `custom` (each with the type
// `shaders.properties` gives it). A `float`, `int`, `vec2`, `vec3` or `vec4` custom uniform
// declared as another of these types gets none, and reads 0: Iris 1.11.7 logs "Wrong uniform
// type ... Disabling that uniform" and our probes read 0 there (float as int, int as float,
// vec3 as vec2, vec2 as vec3; the vec4 cases were not probed). Other pairs (a `bool` on either
// side) keep the conversion `Value::write` makes: our probe read a float of 2.5 declared
// `bool` as true in both games.
custom_index :: proc(custom: ^[(string) {
}
STRICT :: ["float", "int", "vec2", "vec3", "vec4"]
    // rust: let k = custom.iter().position(|(c, _)| c == name)?;
    // rust: let declared = custom[k].1.as_str();
    // rust: let disabled = declared != ty && STRICT.contains(&declared) && STRICT.contains(&ty);
    // rust: (!disabled).then_some(pack_uniforms::NAMES.len() + k)
}

// The pass of program `p`: a quad, or `geometry` drawn by the game. `None` (with a note) when
// wgpu refuses it or it writes nothing. `formats` are its buffers' (for a program of the shadow
// buffers, buffer n is shadowcolor n); `shadow` the shadowcolor formats when the shadow pass
// runs.
    // rust: fn build_pass(
    // rust: device: &wgpu::Device,
    // rust: p: horizon_shaders::PostProgram,
    // rust: formats: &[wgpu::TextureFormat; BUFFERS],
    // rust: shadow: Option<&[wgpu::TextureFormat; SHADOW_COLORS]>,
    // rust: screen: wgpu::TextureFormat,
    // rust: notes: &mut Vec<String>,
    // rust: geometry: Option<&Geometry<'_>>,
    // rust: custom: &[(String, String)],
    // rust: draws: &wgpu::BindGroupLayout,
    // rust: pack: &Resources<'_>,
    // rust: ) -> Option<Pass> {
    // rust: let features = device.features();
    // The frame's uniforms, then the pack's custom ones.
    // rust: let index = |name: &str, ty: &str| {
    // rust: pack_uniforms::index_in(name, geometry.is_some()).or_else(|| custom_index(custom, name, ty))
}
    // rust: let mask = |flips: &[(u32, bool)]| flips.iter().filter(|f| f.1).fold(0u16, |m, f| m | 1 << f.0);
    // rust: let mut p = p;
    // rust: let program = p.program.take()?;
    // rust: let interface = &program.interface;
    // rust: let draw = interface.draw;
    // rust: let storage = !interface.images.is_empty() || !interface.buffers.is_empty();
    // rust: if storage && !pack.gpu.fragment_storage {
    // rust: notes.push(format!(
    // rust: "{}: this GPU can't write images from a fragment shader; skipped",
    // rust: p.name
    // rust: ));
    // rust: return None;
}
    // Terrain's geometry stage reads the draw's indices at set 5; entities' walk their quads.
    // rust: let reads_indices = p.geometry_triangles > 0
    // rust: && (program.vertex.global_variables.iter())
    // rust: .any(|(_, v)| v.binding.as_ref().is_some_and(|b| b.group == 5));
    // rust: if p.geometry_triangles > 0
    // rust: && ((reads_indices && pack.indices.is_none()) || !pack.gpu.vertex_storage)
    // rust: {
    // rust: notes.push(format!(
    // rust: "{}: this GPU can't run a geometry stage; skipped",
    // rust: p.name
    // rust: ));
    // rust: return None;
}
    // rust: let (entries, samplers, slots, reads, shadow_reads, images) = bindings(
    // rust: features, interface, &p.name, p.group, &p.buffers, geometry, formats, shadow, notes, pack,
    // rust: )?;
    // rust: let final_pass = p.group == Group::Final;
    // rust: let mut targets = Vec::new();
    // rust: let mut writes = Vec::new();
    // Outputs into a buffer of a small packed format, and the bits it keeps.
    // rust: let mut packed_outputs = Vec::new();
    // rust: for &location in &interface.outputs {
    // rust: let l = location as usize;
    // rust: if targets.len() <= l {
    // rust: targets.resize(l + 1, None);
}
    // rust: if final_pass {
    // rust: if location == 0 {
    // rust: targets[0] = target(screen);
}
    // rust: } else if let Some(&buffer) = p.buffers.get(l) {
    // rust: let format = formats[buffer as usize];
    // rust: let mut state = target(format);
    // rust: if !p.group.shadow()
    // rust: && pack.rgb & 1 << buffer != 0
    // rust: && let Some(t) = &mut state
    // rust: {
    // rust: t.write_mask = wgpu::ColorWrites::COLOR;
}
    // rust: if let (Some(t), Some(b)) = (
    // rust: &mut state,
    // rust: p.buffer_blends
    // rust: .iter()
    // rust: .find(|(n, _)| *n == buffer)
    // rust: .map_or(p.blend, |(_, b)| *b),
    // rust: ) && format
    // rust: .guaranteed_format_features(features)
    // rust: .flags
    // rust: .contains(wgpu::TextureFormatFeatureFlags::BLENDABLE)
    // rust: {
    // rust: t.blend = Some(blend_state(b));
}
    // rust: if !p.group.shadow()
    // rust: && let Some(bits) = pack.packed[buffer as usize]
    // rust: {
    // rust: packed_outputs.push((location, bits));
}
    // rust: targets[l] = state;
    // rust: writes.push((location, buffer as usize));
}
}
    // Outputs past the last buffer the program writes go nowhere, as in GL; a pass has no
    // attachment for them.
    // rust: while targets.last().is_some_and(Option::is_none) {
    // rust: targets.pop();
}
    // A program that only writes images draws into a sink that keeps nothing; one drawing
    // geometry has the depth buffer, and draws with no colour target at all.
    // rust: let sink = !final_pass && writes.is_empty() && !program.interface.images.is_empty();
    // rust: if sink && geometry.is_none() {
    // rust: targets = vec![Some(wgpu::ColorTargetState {
    // rust: format: SINK,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::empty(),
    // rust: })];
    // rust: } else if !final_pass && writes.is_empty() && !sink {
    // rust: notes.push(format!("{}: writes no buffer; skipped", p.name));
    // rust: return None;
}
    // rust: let written = writes.iter().fold(0u16, |m, w| m | 1 << w.1);
    // rust: let kept = p
    // rust: .flips
    // rust: .iter()
    // rust: .filter(|f| !f.1)
    // rust: .fold(0u16, |m, f| m | 1 << f.0);
    // Gbuffers programs write in place (6.1.6). A forced flip of a buffer the program writes
    // cancels the write's own flip, as in Iris 1.11.7 (probed with packs of our own).
    // rust: let flip = if final_pass || geometry.is_some() {
    // rust: 0
    // rust: } else {
    // rust: (written & !kept) ^ mask(&p.flips)
}
    // rust: let created = checked(device, || {
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some(&p.name),
    // rust: entries: &entries,
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some(&p.name),
    // rust: bind_group_layouts: &[
    // rust: Some(&layout),
    // rust: geometry.and_then(|g| g.table),
    // rust: draw.then_some(draws),
    // rust: geometry.and_then(|g| g.ids),
    // rust: (!interface.buffers.is_empty()).then_some(&pack.buffers.layout),
    // rust: pack.indices.filter(|_| reads_indices),
    // rust: ],
    // rust: ..Default::default()
    // rust: });
    // rust: let module = |mut m: naga::Module| {
    // rust: share_samplers(&mut m, &slots);
    // rust: device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some(&p.name),
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(m)),
    // rust: })
}
    // rust: let mut fragment = program.fragment;
    // rust: packed::quantise_outputs(&mut fragment, &packed_outputs);
    // rust: let (vs, fs) = (module(program.vertex), module(fragment));
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(&p.name),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &vs,
    // rust: entry_point: Some("main"),
    // rust: compilation_options: Default::default(),
                // A geometry stage reads its vertices itself.
    // rust: buffers: geometry
    // rust: .filter(|_| p.geometry_triangles == 0)
    // rust: .map_or(&[], |g| g.buffers),
    // rust: },
            // Rows flipped to GL's turn front faces clockwise.
    // rust: primitive: wgpu::PrimitiveState {
    // rust: front_face: wgpu::FrontFace::Cw,
    // rust: cull_mode: geometry
    // rust: .filter(|g| g.cull && p.geometry_triangles == 0)
    // rust: .map(|_| wgpu::Face::Back),
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: geometry.map(|g| wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(g.depth_write),
    // rust: depth_compare: Some(wgpu::CompareFunction::LessEqual),
    // rust: stencil: Default::default(),
    // rust: bias: if p.name == "gbuffers_damagedblock" {
    // rust: wgpu::DepthBiasState {
    // rust: constant: -10,
    // rust: slope_scale: -1.0,
    // rust: clamp: 0.0,
}
    // rust: } else {
    // rust: Default::default()
    // rust: },
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &fs,
    // rust: entry_point: Some("main"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &targets,
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: (layout, pipeline)
    // rust: });
    // rust: let (layout, pipeline) = match created {
    // rust: Ok(created) => created,
    // rust: Err(e) => {
    // rust: notes.push(format!("{}: skipped: {e}", p.name));
    // rust: return None;
}
}
    // rust: let interface = &program.interface;
    // rust: let missing: Vec<&str> = interface
    // rust: .uniforms
    // rust: .iter()
    // rust: .filter(|u| !u.name.starts_with("hz_") && index(&u.name, &u.ty).is_none())
    // rust: .map(|u| u.name.as_str())
    // rust: .collect();
    // rust: if !missing.is_empty() {
    // rust: notes.push(format!(
    // rust: "{}: shader defaults or zero: {}",
    // rust: p.name,
    // rust: missing.join(" ")
    // rust: ));
}
    // rust: let image_copies = image_copies(&samplers, &images);
    // rust: Some(Pass {
    // rust: ubo: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(&p.name),
    // rust: size: u64::from(interface.uniform_size.max(16)),
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: }),
    // rust: block: interface.initial_values.clone(),
    // rust: uniforms: interface
    // rust: .uniforms
    // rust: .iter()
    // rust: .map(|u| (index(&u.name, &u.ty), u.ty.clone(), u.offset))
    // rust: .collect(),
    // rust: name: p.name,
    // rust: group: p.group,
    // rust: pipeline: Pipeline::Render(pipeline),
    // rust: layout,
    // rust: samplers,
    // rust: writes,
    // rust: flip,
    // rust: depth_linear: depth_linear(interface, pack.shadow_linear),
    // rust: shadow_reads,
    // rust: written,
    // rust: mipmaps: p.mipmaps,
    // rust: draw,
    // rust: atlas: geometry.and_then(|g| g.atlas.clone()),
    // rust: material_maps: geometry.is_some_and(|g| g.material_maps),
    // rust: ids: geometry.is_some_and(|g| g.ids.is_some()),
    // rust: groups: HashMap::new(),
    // rust: portal_groups: HashMap::new(),
    // rust: copies: image_buffers(&images) & reads,
    // rust: reads: reads | image_buffers(&images),
    // rust: buffers: !interface.buffers.is_empty(),
    // rust: images,
    // rust: compute: Vec::new(),
    // rust: sink,
    // rust: geometry: p.geometry_triangles,
    // rust: viewport: (!final_pass && p.scale != [1.0, 0.0, 0.0]).then_some(p.scale),
    // rust: image_copies,
    // rust: snapshots: 0,
    // rust: })
}

// The pack's images a pass both samples and stores.
image_copies :: proc(samplers: ^[Binding], images: ^[(u32) {
}
    // rust: samplers
    // rust: .iter()
    // rust: .filter_map(|s| match s.source {
    // rust: Source::Image(k) if images.iter().any(|i| i.1 == Image::Custom(k)) => Some(k),
    // rust: _ => None,
    // rust: })
    // rust: .fold(0, |m, k| m | 1 << k)
}

// The pass of compute program `c` of a `group` program: `None` (with a note) when wgpu refuses
// it or it needs what the game can't give.
    // rust: fn build_compute(
    // rust: device: &wgpu::Device,
    // rust: name: String,
    // rust: group: Group,
    // rust: c: horizon_shaders::ComputeProgram,
    // rust: formats: &[wgpu::TextureFormat; BUFFERS],
    // rust: shadow: Option<&[wgpu::TextureFormat; SHADOW_COLORS]>,
    // rust: notes: &mut Vec<String>,
    // rust: custom: &[(String, String)],
    // rust: pack: &Resources<'_>,
    // rust: ) -> Option<Pass> {
    // rust: let index = |name: &str, ty: &str| {
    // rust: pack_uniforms::index(name).or_else(|| custom_index(custom, name, ty))
}
    // rust: let interface = &c.interface;
    // rust: let (entries, samplers, slots, reads, shadow_reads, images) = bindings(
    // rust: device.features(),
    // rust: interface,
    // rust: &name,
    // rust: group,
    // rust: &[],
    // rust: None,
    // rust: formats,
    // rust: shadow,
    // rust: notes,
    // rust: pack,
    // rust: )?;
    // rust: let local = c.module.entry_points[0].workgroup_size;
    // rust: let created = checked(device, || {
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some(&name),
    // rust: entries: &entries,
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some(&name),
    // rust: bind_group_layouts: &[
    // rust: Some(&layout),
    // rust: None,
    // rust: None,
    // rust: None,
    // rust: (!interface.buffers.is_empty()).then_some(&pack.buffers.layout),
    // rust: ],
    // rust: ..Default::default()
    // rust: });
    // rust: let mut module = c.module;
    // rust: share_samplers(&mut module, &slots);
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some(&name),
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(module)),
    // rust: });
    // rust: let pipeline = device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    // rust: label: Some(&name),
    // rust: layout: Some(&pipeline_layout),
    // rust: module: &module,
    // rust: entry_point: Some("main"),
    // rust: compilation_options: Default::default(),
    // rust: cache: None,
    // rust: });
    // rust: (layout, pipeline)
    // rust: });
    // rust: let (layout, pipeline) = match created {
    // rust: Ok(created) => created,
    // rust: Err(e) => {
    // rust: notes.push(format!("{name}: skipped: {e}"));
    // rust: return None;
}
}
    // rust: let written = image_buffers(&images);
    // rust: let image_copies = image_copies(&samplers, &images);
    // rust: let (before_colors, snapshots) = befores(&images);
    // rust: Some(Pass {
    // rust: ubo: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(&name),
    // rust: size: u64::from(interface.uniform_size.max(16)),
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: }),
    // rust: block: interface.initial_values.clone(),
    // rust: uniforms: interface
    // rust: .uniforms
    // rust: .iter()
    // rust: .map(|u| (index(&u.name, &u.ty), u.ty.clone(), u.offset))
    // rust: .collect(),
    // rust: name,
    // rust: group,
    // rust: pipeline: Pipeline::Compute {
    // rust: pipeline,
    // rust: groups: c.work_groups,
    // rust: render: c.work_groups_render,
    // rust: local,
    // rust: },
    // rust: layout,
    // rust: samplers,
    // rust: writes: Vec::new(),
    // rust: flip: 0,
    // rust: depth_linear: depth_linear(interface, pack.shadow_linear),
    // rust: copies: written & reads | before_colors,
    // rust: reads: reads | written,
    // rust: shadow_reads,
    // rust: written,
    // rust: mipmaps: 0,
    // rust: draw: false,
    // rust: atlas: None,
    // rust: material_maps: false,
    // rust: ids: false,
    // rust: groups: HashMap::new(),
    // rust: portal_groups: HashMap::new(),
    // rust: buffers: !interface.buffers.is_empty(),
    // rust: images,
    // rust: compute: Vec::new(),
    // rust: sink: false,
    // rust: geometry: 0,
    // rust: image_copies,
    // rust: snapshots,
    // rust: viewport: None,
    // rust: })
}

// Why a pack can't run, and the notes of loading it until then (why programs were skipped).
Refused :: struct {
    reason: string,
    notes: [dynamic]string,
}

    // rust: impl PackPost {
    // Builds the pipelines of `post` for a screen of `screen` format. An error when the pack
    // can't show anything on the screen: the game turns it off, as a pack that fails to load.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: adapter: &wgpu::Adapter,
    // rust: mut post: Post,
    // rust: screen: wgpu::TextureFormat,
    // rust: world: World<'_>,
    // rust: ) -> Result<Self, Refused> {
        // What the pack's shaders need of its storage buffers, before its parts move out.
    // rust: let minimums = post.buffer_minimums();
    // rust: let features = device.features();
    // rust: let formats: [wgpu::TextureFormat; BUFFERS] = std::array::from_fn(|i| {
    // rust: let f = post.config.buffers[i].format;
    // rust: snorm_format(f, features, adapter)
    // rust: .unwrap_or_else(|| target_format(f, features, adapter))
    // rust: });
    // rust: let sky_clear = Some(&post.config.buffers[0])
    // rust: .filter(|b| b.clear)
    // rust: .and_then(|b| b.clear_color);
        // A three-channel buffer reads alpha 1 whatever is written or cleared, as in Iris: its
        // passes leave alpha alone, and its clears and first contents set it to 1.
    // rust: let rgb = (0..BUFFERS)
    // rust: .filter(|&i| post.config.buffers[i].format.channels == 3)
    // rust: .fold(0u16, |m, i| m | 1 << i);
        // A small packed format's buffer reads back fewer bits, as in Iris: its clears and
        // what its passes write keep only those.
    // rust: let packed: [Option<[u8; 4]>; BUFFERS] =
    // rust: std::array::from_fn(|i| packed::bits(post.config.buffers[i].format));
    // rust: let clears = std::array::from_fn(|i| {
    // rust: let b = &post.config.buffers[i];
    // rust: b.clear.then(|| {
    // rust: let mut c = (b.clear_color).unwrap_or(if i == 1 { [1.0; 4] } else { [0.0; 4] });
    // rust: if rgb & 1 << i != 0 {
    // rust: c[3] = 1.0;
}
    // rust: packed[i].map_or(c, |bits| packed::quantise(c, bits))
    // rust: })
    // rust: });
    // rust: let mut notes = post.notes;
    // rust: notes.extend(post.config.notes);
    // rust: let mut sizes = post.sizes;
        // The blit writes colortex0 beside the depth buffer, at the render size.
    // rust: if sizes[0].take().is_some() {
    // rust: notes.push("size.buffer.colortex0: colortex0 keeps the render size".into());
}
    // rust: let textures = pack_textures::upload(device, queue, post.textures, &mut notes);
    // rust: let shadow_config = post.config.shadow.clone();
        // shadowcolor2 to 7 only for a pack that names `HIGHER_SHADOWCOLOR`.
    // rust: let shadow_colors = (1u16 << post.shadow_colors) - 1;
    // rust: let mut custom = post.custom;
    // rust: let custom_names: Vec<(String, String)> = (custom.uniforms())
    // rust: .map(|(name, ty)| (name.to_owned(), ty.to_owned()))
    // rust: .collect();
        // A first run finds the names neither the frame nor the pack defines.
    // rust: custom.eval(0.0, &pack_uniforms::zero);
        // Its zeros are no start for `smooth`: the first frame's values are, as in Iris.
    // rust: custom.restart_smoothing();
    // rust: if !custom.notes.is_empty() {
    // rust: notes.push(format!("custom uniforms: {}", custom.notes.join("; ")));
    // rust: custom.notes.clear();
}
    // rust: let mask =
    // rust: |flips: &[(u32, bool)]| flips.iter().filter(|f| f.1).fold(0u16, |m, f| m | 1 << f.0);
    // rust: let mut used = 1u16;
        // Buffers some pass draws into the "alt" side of, or flips: only these get a B texture.
    // rust: let mut doubled = mask(&post.deferred_pre) | mask(&post.composite_pre);
    // rust: let mut shadow_doubled = 0u16;
    // rust: let draws = DrawUniforms::new(device);
        // The shadow buffers' formats when the shadow pass runs; their programs see them as
        // buffers 0 to 7.
    // rust: let shadow_formats: Option<[wgpu::TextureFormat; SHADOW_COLORS]> =
    // rust: post.shadow_pass.then(|| {
    // rust: std::array::from_fn(|n| {
    // rust: target_format(shadow_config.colors[n].format, features, adapter)
    // rust: })
    // rust: });
    // rust: let shadow_space: [wgpu::TextureFormat; BUFFERS] = std::array::from_fn(|i| {
    // rust: shadow_formats
    // rust: .filter(|_| i < SHADOW_COLORS)
    // rust: .map_or(formats[i], |f| f[i])
    // rust: });
    // rust: let (mut storage, mut copied, mut image_copied, mut snapshotted) = (0u16, 0u16, 0u64, 0u64);
    // rust: let gpu = Gpu::of(adapter, features);
    // rust: if !gpu.compute {
    // rust: notes.push("this GPU has no compute shaders: compute programs are skipped".into());
}
        // An image this device can't make or store into: the programs using it are skipped.
    // rust: let mut image_defs = std::mem::take(&mut post.images);
    // rust: let mut left_out = Vec::new();
    // rust: image_defs.retain(|def| {
    // rust: let made = pack_images::makeable(device, def).and_then(|()| {
    // rust: if gpu.storable(adapter, pack_images::format(def.format), features) {
    // rust: Ok(())
    // rust: } else {
    // rust: Err("this GPU can't store into its format".into())
}
    // rust: });
    // rust: if let Err(e) = &made {
    // rust: notes.push(format!("image `{}`: {e}", def.name));
    // rust: left_out.push(def.clone());
}
    // rust: made.is_ok()
    // rust: });
        // A mask of a pass's images holds this many.
    // rust: let kept = image_defs.len().min(pack_images::IMAGES);
    // rust: for def in image_defs.drain(kept..) {
    // rust: notes.push(format!(
    // rust: "image `{}`: past the {} images a pack may have",
    // rust: def.name,
    // rust: pack_images::IMAGES
    // rust: ));
    // rust: left_out.push(def);
}
    // rust: let images = pack_images::images(image_defs);
    // rust: let mut objects = std::mem::take(&mut post.buffer_objects);
    // rust: if gpu.storage_stages().is_empty() {
    // rust: objects.clear();
}
    // rust: let buffers = pack_images::Buffers::new(device, objects, minimums, gpu.storage_stages());
    // rust: let storable = (0..BUFFERS)
    // rust: .filter(|&i| gpu.storable(adapter, formats[i], features))
    // rust: .fold(0u16, |m, i| m | 1 << i);
    // rust: let indices = gpu.vertex_storage.then(|| {
    // rust: device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Shader pack geometry indices"),
    // rust: entries: &[wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::VERTEX,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Storage { read_only: true },
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: }],
    // rust: })
    // rust: });
    // rust: let stand_ins = std::cell::RefCell::new(Vec::new());
    // rust: let pack = Resources {
    // rust: textures: &textures,
    // rust: images: &images,
    // rust: left_out: &left_out,
    // rust: buffers: &buffers,
    // rust: indices: indices.as_ref(),
    // rust: gpu,
    // rust: storable,
    // rust: rgb,
    // rust: packed,
    // rust: released: std::cell::Cell::new(("", 0)),
    // rust: stand_ins: &stand_ins,
    // rust: shadow_linear: (0..2)
    // rust: .filter(|&n| !shadow_config.nearest[n])
    // rust: .fold(0, |m, n| m | 1 << n),
}
    // rust: let mut build = |mut p: horizon_shaders::PostProgram, geometry: Option<&Geometry<'_>>| {
    // rust: let in_shadow = p.group.shadow();
    // rust: let mut compute = std::mem::take(&mut p.compute);
    // rust: if !gpu.compute {
    // rust: compute.clear();
    // rust: p.program.as_ref()?;
}
    // rust: let group = p.group;
    // rust: let stage = pack_textures::stage(group);
    // rust: if pack.released.get().0 != stage {
    // rust: pack.released.set((stage, 0));
}
    // rust: let mut computes: Vec<Pass> = compute
    // rust: .into_iter()
    // rust: .filter_map(|(name, c)| {
    // rust: build_compute(
    // rust: device,
    // rust: name,
    // rust: group,
    // rust: c,
    // rust: if in_shadow { &shadow_space } else { &formats },
    // rust: shadow_formats.as_ref(),
    // rust: &mut notes,
    // rust: &custom_names,
    // rust: &pack,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let mut pass = if p.program.is_none() {
                // Compute stages only: the last is the pass, the others run before it.
    // rust: let mut last = computes.pop()?;
    // rust: last.compute = computes;
    // rust: computes = Vec::new();
    // rust: last
    // rust: } else {
    // rust: build_pass(
    // rust: device,
    // rust: p,
    // rust: if in_shadow { &shadow_space } else { &formats },
    // rust: shadow_formats.as_ref(),
    // rust: screen,
    // rust: &mut notes,
    // rust: geometry,
    // rust: &custom_names,
    // rust: &draws.layout,
    // rust: &pack,
    // rust: )?
}
    // rust: pass.compute.append(&mut computes);
            // A pass's attachments share a size: the depth buffer's, for the passes that draw
            // the world.
    // rust: let size =
    // rust: |b: usize| sizes[b].unwrap_or(horizon_shaders::BufferSize::Relative([1.0; 2]));
    // rust: let depth = matches!(group, Group::Gbuffers | Group::Translucent);
    // rust: let mut written = pass.writes.iter().map(|w| size(w.1));
    // rust: let first = if depth {
    // rust: Some(horizon_shaders::BufferSize::Relative([1.0; 2]))
    // rust: } else {
    // rust: written.next()
}
    // rust: if !in_shadow && group != Group::Final && written.any(|s| Some(s) != first) {
    // rust: notes.push(format!(
    // rust: "{}: writes buffers of different sizes (size.buffer); skipped",
    // rust: pass.name
    // rust: ));
    // rust: return None;
}
            // Composite-style programs draw into the "alt" side of what they write; gbuffers,
            // shadow and `final` programs write in place, compute programs through images.
    // rust: let alt = if geometry.is_none()
    // rust: && group != Group::Final
    // rust: && matches!(pass.pipeline, Pipeline::Render(_))
    // rust: {
    // rust: pass.written
    // rust: } else {
    // rust: 0
}
    // rust: if in_shadow {
    // rust: shadow_doubled |= alt;
    // rust: } else {
    // rust: doubled |= alt;
}
    // rust: for p in std::iter::once(&pass).chain(&pass.compute) {
    // rust: let (stage, flipped) = pack.released.get();
    // rust: pack.released.set((stage, flipped | p.flip));
    // rust: if in_shadow {
    // rust: shadow_doubled |= p.flip;
    // rust: } else {
    // rust: used |= p.reads | p.written | p.flip;
    // rust: doubled |= p.flip;
}
    // rust: storage |= image_buffers(&p.images);
    // rust: image_copied |= p.image_copies;
    // rust: snapshotted |= p.snapshots;
    // rust: copied |= p.copies;
}
    // rust: Some(pass)
}
        // Flat terrain reads `mc_Entity` from a table of the sprite layers.
    // rust: let block_ids = world
    // rust: .terrain
    // rust: .as_ref()
    // rust: .filter(|g| g.table.is_some())
    // rust: .map(|_| block_ids(device, world.block_ids, world.sprite_rects));
    // rust: let terrain_geometry = world.terrain.as_ref().map(|g| Geometry {
    // rust: buffers: g.buffers,
    // rust: table: g.table,
    // rust: depth_write: g.depth_write,
    // rust: atlas: g.atlas.clone(),
    // rust: material_maps: g.material_maps,
    // rust: ids: block_ids.as_ref().map(|i| &i.0),
    // rust: cull: g.cull,
    // rust: });
    // rust: let split = post.terrain.is_some() && post.terrain_cutout.is_some();
    // rust: let mut terrain = post
    // rust: .terrain
    // rust: .zip(terrain_geometry.as_ref())
    // rust: .and_then(|(p, g)| build(p, Some(g)));
    // rust: let mut terrain_cutout = post
    // rust: .terrain_cutout
    // rust: .zip(terrain_geometry.as_ref())
    // rust: .and_then(|(p, g)| build(p, Some(g)));
    // rust: let water = post
    // rust: .water
    // rust: .zip(terrain_geometry.as_ref())
    // rust: .and_then(|(p, g)| build(p, Some(g)));
        // The shadow pass draws terrain faces from both sides, as Iris 1.11.7 does (#9033): a
        // cave ceiling faces away from the sun, and is often all that shadows the cave.
    // rust: let shadow_geometry = terrain_geometry.as_ref().map(|g| Geometry {
    // rust: buffers: g.buffers,
    // rust: table: g.table,
    // rust: depth_write: g.depth_write,
    // rust: atlas: g.atlas.clone(),
    // rust: material_maps: g.material_maps,
    // rust: ids: g.ids,
    // rust: cull: false,
    // rust: });
    // rust: let shadow_terrain = post
    // rust: .shadow
    // rust: .zip(shadow_geometry.as_ref())
    // rust: .and_then(|(p, g)| build(p, Some(g)));
    // rust: let shadow_water = post
    // rust: .shadow_water
    // rust: .zip(shadow_geometry.as_ref())
    // rust: .and_then(|(p, g)| build(p, Some(g)));
    // rust: let (hides_sky, hides_celestial) = (post.sky.is_some(), post.sky_textured.is_some());
    // rust: let sky = (post.sky.is_some() || post.sky_textured.is_some()).then(|| {
    // rust: let geometry = PackSky::new(device);
    // rust: let basic = Geometry {
    // rust: buffers: &PackSky::buffers(),
    // rust: table: Some(&geometry.layout),
    // rust: depth_write: false,
    // rust: atlas: None,
    // rust: material_maps: false,
    // rust: ids: None,
    // rust: cull: false,
}
    // rust: let basic = post.sky.and_then(|p| build(p, Some(&basic)));
    // rust: let textured = Geometry {
    // rust: buffers: &PackSky::celestial_buffers(),
    // rust: table: None,
    // rust: depth_write: false,
    // rust: atlas: world.celestial.clone(),
    // rust: material_maps: false,
    // rust: ids: None,
    // rust: cull: false,
}
    // rust: let textured = post.sky_textured.and_then(|p| build(p, Some(&textured)));
    // rust: Sky {
    // rust: geometry,
    // rust: basic,
    // rust: textured,
}
    // rust: });
    // rust: let sky = sky.filter(|s| s.basic.is_some() || s.textured.is_some());
    // rust: let programs = [
    // rust: post.entities,
    // rust: post.block,
    // rust: post.entities_translucent,
    // rust: post.particles,
    // rust: post.damaged_block,
    // rust: post.beacon_beam,
    // rust: ];
    // rust: let late = [
    // rust: false,
    // rust: false,
    // rust: post.translucent_late,
    // rust: post.particles_late,
    // rust: false,
    // rust: true,
    // rust: ];
    // rust: let shadow_only = (post.shadow_only_player, post.shadow_only_lit_blocks);
    // rust: let shadow_programs = [post.shadow_entities, post.shadow_block];
    // rust: let entity_vertices = (programs.iter().chain(&shadow_programs))
    // rust: .any(Option::is_some)
    // rust: .then(|| PackEntities::new(device, &draws.layout));
    // rust: let entity_buffers = super::pack_entities::buffers();
    // rust: let entity_geometry = entity_vertices.as_ref().map(|e| Geometry {
    // rust: buffers: &entity_buffers,
    // rust: table: Some(&e.table),
    // rust: depth_write: true,
    // rust: atlas: world.celestial.clone(),
    // rust: material_maps: false,
    // rust: ids: None,
    // rust: cull: false,
    // rust: });
    // rust: let entity_passes = programs.map(|p| {
    // rust: p.zip(entity_geometry.as_ref()).and_then(|(p, g)| {
    // rust: if p.name == "gbuffers_damagedblock" {
    // rust: let decal = Geometry {
    // rust: buffers: g.buffers,
    // rust: table: g.table,
    // rust: depth_write: false,
    // rust: atlas: g.atlas.clone(),
    // rust: material_maps: g.material_maps,
    // rust: ids: g.ids,
    // rust: cull: false,
}
    // rust: build(p, Some(&decal))
    // rust: } else {
    // rust: build(p, Some(g))
}
    // rust: })
    // rust: });
    // rust: let shadow_entities = shadow_programs.map(|p| {
    // rust: p.zip(entity_geometry.as_ref())
    // rust: .and_then(|(p, g)| build(p, Some(g)))
    // rust: });
    // rust: let entities = entity_vertices
    // rust: .filter(|_| (entity_passes.iter().chain(&shadow_entities)).any(Option::is_some))
    // rust: .map(|geometry| Entities {
    // rust: geometry,
    // rust: passes: entity_passes,
    // rust: late,
    // rust: shadow: shadow_entities,
    // rust: only: shadow_only,
    // rust: });
    // rust: let cloud_geometry = world.clouds.map(|layout| Geometry {
    // rust: buffers: &entity_buffers,
    // rust: table: Some(layout),
    // rust: depth_write: true,
    // rust: atlas: world.celestial.clone(),
    // rust: material_maps: false,
    // rust: ids: None,
    // rust: cull: false,
    // rust: });
    // rust: let hides_clouds = post.clouds_off || post.clouds.is_some() && cloud_geometry.is_some();
    // rust: let weather_geometry = world.weather.then(|| Geometry {
    // rust: buffers: &entity_buffers,
    // rust: table: None,
    // rust: depth_write: post.rain_depth,
    // rust: atlas: None,
    // rust: material_maps: false,
    // rust: ids: None,
    // rust: cull: false,
    // rust: });
    // rust: let hand_geometry = world
    // rust: .hand
    // rust: .then(|| super::pack_hand::PackHand::new(device, &draws.layout));
    // rust: let hand = post.hand.zip(hand_geometry).and_then(|(p, geometry)| {
    // rust: let g = Geometry {
    // rust: buffers: &entity_buffers,
    // rust: table: Some(&geometry.layout),
    // rust: depth_write: true,
    // rust: atlas: world.celestial.clone(),
    // rust: material_maps: false,
    // rust: ids: None,
    // rust: cull: false,
}
    // rust: build(p, Some(&g)).map(|pass| (pass, geometry))
    // rust: });
    // rust: let weather = post
    // rust: .weather
    // rust: .zip(weather_geometry.as_ref())
    // rust: .and_then(|(p, g)| build(p, Some(g)))
    // rust: .map(|rain| {
    // rust: let mut snow = rain.clone();
    // rust: snow.name = format!("{} (snow)", rain.name);
    // rust: [rain, snow]
    // rust: });
    // rust: let clouds = post
    // rust: .clouds
    // rust: .zip(cloud_geometry.as_ref())
    // rust: .and_then(|(p, g)| build(p, Some(g)));
    // rust: let line_buffers = [Some(super::pack_lines::layout())];
    // rust: let line_geometry = Geometry {
    // rust: buffers: &line_buffers,
    // rust: table: None,
    // rust: depth_write: false,
    // rust: atlas: None,
    // rust: material_maps: false,
    // rust: ids: None,
    // rust: cull: false,
}
    // rust: let lines = post.lines.and_then(|p| build(p, Some(&line_geometry)));
        // Developers' aid: `HORIZON_SHADER_PACK_SKIP=composite,final` leaves programs out.
    // rust: let skip = std::env::var("HORIZON_SHADER_PACK_SKIP").unwrap_or_default();
    // rust: let passes: Vec<Pass> = post
    // rust: .programs
    // rust: .into_iter()
    // rust: .filter(|p| !skip.split(',').any(|s| s == p.name))
    // rust: .filter_map(|p| build(p, None))
    // rust: .collect();
        // The screen gets colortex0 through `final`, or else through Horizon's copy, which reads
        // floats: an integer colortex0 (`RGBA32UI`...) with no `final` left to draw can't reach
        // it (#9165).
    // rust: let shows = passes
    // rust: .iter()
    // rust: .any(|p| p.group == Group::Final && matches!(p.pipeline, Pipeline::Render(_)));
    // rust: if !shows && !holds_floats(formats[0]) {
    // rust: return Err(Refused {
    // rust: reason: format!(
    // rust: "colortex0 has an integer format ({:?}) and no `final` program draws it to \
    // rust: the screen",
    // rust: formats[0]
    // rust: ),
    // rust: notes,
    // rust: });
}
    // rust: let shadow_comp: Vec<Pass> = post
    // rust: .shadow_comp
    // rust: .into_iter()
    // rust: .filter(|p| !skip.split(',').any(|s| s == p.name))
    // rust: .filter_map(|p| build(p, None))
    // rust: .collect();
    // rust: let stand_ins = pack_images::stand_ins(device, stand_ins.take());
        // Terrain in two parts draws both or neither: one alone would leave the other part's
        // terrain undrawn. Without either, the game draws all terrain, as when the terrain
        // program of a pack that doesn't split can't draw.
    // rust: if split
    // rust: && terrain.is_some() != terrain_cutout.is_some()
    // rust: && let Some(p) = terrain.take().or(terrain_cutout.take())
    // rust: {
    // rust: notes.push(format!(
    // rust: "{}: the other part of terrain can't draw; the game draws all terrain",
    // rust: p.name
    // rust: ));
}
    // rust: match (&terrain, &mut terrain_cutout) {
    // rust: (Some(t), None) => notes.push(format!("terrain draws with {}", t.name)),
    // rust: (t, Some(c)) => {
    // rust: if let Some(t) = t {
    // rust: notes.push(format!("solid terrain draws with {}", t.name));
}
    // rust: notes.push(format!("cutout terrain draws with {}", c.name));
                // Timed (and labelled) apart from the solid part when it runs the same program.
    // rust: if t.as_ref().is_some_and(|t| t.name == c.name) {
    // rust: c.name.push_str(" (cutout)");
}
}
    // rust: (None, None) => {}
}
    // rust: for (part, pass) in [
    // rust: ("terrain", &shadow_terrain),
    // rust: ("translucent terrain", &shadow_water),
    // rust: ] {
    // rust: if let Some(p) = pass {
    // rust: notes.push(format!("{part} casts shadows with {}", p.name));
}
}
    // rust: if let Some(w) = &water {
    // rust: notes.push(format!("translucent terrain draws with {}", w.name));
}
        // Timed (and labelled) apart from the solid shadow pass that runs the same program.
    // rust: let mut shadow_water = shadow_water;
    // rust: if let Some(p) = &mut shadow_water {
    // rust: p.name.push_str(" (translucent)");
}
    // rust: for (part, pass) in sky
    // rust: .iter()
    // rust: .flat_map(|s| [("sky", &s.basic), ("sun and moon", &s.textured)])
    // rust: {
    // rust: if let Some(p) = pass {
    // rust: notes.push(format!("the {part} draw with {}", p.name));
}
}
    // rust: let parts = [
    // rust: "entities",
    // rust: "block entities",
    // rust: "translucent entities",
    // rust: "particles",
    // rust: ];
    // rust: if let Some(l) = &lines {
    // rust: notes.push(format!("the block outline draws with {}", l.name));
}
    // rust: if let Some(c) = &clouds {
    // rust: notes.push(format!("clouds draw with {}", c.name));
}
    // rust: if let Some((h, _)) = &hand {
    // rust: notes.push(format!("the hand draws with {}", h.name));
}
    // rust: if let Some([w, _]) = &weather {
    // rust: notes.push(format!("rain and snow draw with {}", w.name));
}
    // rust: for (part, pass) in entities.iter().flat_map(|e| parts.iter().zip(&e.passes)) {
    // rust: if let Some(p) = pass {
    // rust: notes.push(format!("{part} draw with {}", p.name));
}
}
        // Timed (and labelled) apart from the terrain's shadow pass, which may run the same
        // program.
    // rust: let mut entities = entities;
    // rust: for e in entities.iter_mut() {
    // rust: let only = [
    // rust: (e.only.0, " (only the player)"),
    // rust: (e.only.1, " (only those that emit light)"),
    // rust: ];
    // rust: for ((part, pass), (only, which)) in parts.iter().zip(&mut e.shadow).zip(only) {
    // rust: if let Some(p) = pass {
    // rust: let which = if only { which } else { "" };
    // rust: notes.push(format!("{part}{which} cast shadows with {}", p.name));
    // rust: p.name.push_str(&format!(" ({part})"));
}
}
}
    // rust: let reads_depth = |source| {
    // rust: passes
    // rust: .iter()
    // rust: .filter(|p| matches!(p.group, Group::Deferred | Group::Composite | Group::Final))
    // rust: .chain(&water)
    // rust: .chain(weather.iter().take(1).flatten())
    // rust: .flat_map(|p| std::iter::once(p).chain(&p.compute))
    // rust: .any(|p| p.samplers.iter().any(|s| s.source == source))
}
    // rust: let reads_depth2 = reads_depth(Source::Depth2);
        // Without a shader hand, depth1 also serves depth2: both exclude only translucency.
    // rust: let depth1 = (water.is_some() || hand.is_some())
    // rust: && (reads_depth(Source::Depth1) || (hand.is_none() && reads_depth2));
    // rust: let depth2 = hand.is_some() && reads_depth2;
    // rust: let every_pass = || {
    // rust: (passes
    // rust: .iter()
    // rust: .chain(&shadow_comp)
    // rust: .chain(&terrain)
    // rust: .chain(&terrain_cutout)
    // rust: .chain(&water))
    // rust: .chain(shadow_terrain.iter().chain(&shadow_water))
    // rust: .chain(sky.iter().flat_map(|s| s.basic.iter().chain(&s.textured)))
    // rust: .chain(entities.iter().flat_map(|e| e.passes.iter().flatten()))
    // rust: .chain(entities.iter().flat_map(|e| e.shadow.iter().flatten()))
    // rust: .chain(&clouds)
    // rust: .chain(&lines)
    // rust: .chain(weather.iter().flatten())
    // rust: .chain(hand.iter().map(|h| &h.0))
}
    // rust: let shadow_targets = shadow_formats.map(|f| {
    // rust: let colors = every_pass().fold(0u16, |m, p| {
    // rust: let own = if p.group.shadow() {
    // rust: p.reads | p.written | p.flip
    // rust: } else {
    // rust: 0
}
    // rust: m | own | p.shadow_reads
    // rust: }) & shadow_colors;
    // rust: let depth1 = every_pass()
    // rust: .flat_map(|p| &p.samplers)
    // rust: .any(|s| matches!(s.source, Source::ShadowDepth(1, _)));
    // rust: let t = super::pack_shadow::ShadowTargets::new(
    // rust: device,
    // rust: &shadow_config,
    // rust: f,
    // rust: colors,
    // rust: shadow_doubled & colors,
    // rust: depth1,
    // rust: );
    // rust: notes.push(format!(
    // rust: "shadow map {0}x{0} over {2} blocks, sunPathRotation {3}, shadowcolor buffers {colors:#b} (two textures: {4:#b}){1}",
    // rust: t.size,
    // rust: if depth1 { ", shadowtex1" } else { "" },
    // rust: shadow_config.distance,
    // rust: shadow_config.sun_path_rotation,
    // rust: shadow_doubled & colors,
    // rust: ));
    // rust: t
    // rust: });
    // rust: log::info!(
    // rust: "shader pack: colortex buffers {used:#b}, with two textures {:#b}",
    // rust: doubled & used
    // rust: );
        // Any program can leave pixels untouched. Composite-style passes also write the
        // alternate image, so their first write does not replace the main image's clear.
    // rust: let mut cleared = Vec::new();
    // rust: for b in 1..BUFFERS {
    // rust: let bit = 1u16 << b;
    // rust: let touched = |p: &&Pass| (p.reads | p.flip | p.written) & bit != 0;
            // Gbuffers passes cover part of their targets: a clear is needed if they touch it.
    // rust: let first = sky
    // rust: .iter()
    // rust: .flat_map(|s| s.basic.iter().chain(&s.textured))
    // rust: .chain(&terrain)
    // rust: .chain(&terrain_cutout)
    // rust: .chain(entities.iter().flat_map(|e| e.passes.iter().flatten()))
    // rust: .chain(&clouds)
    // rust: .chain(&lines)
    // rust: .chain(&water)
    // rust: .chain(weather.iter().take(1).flatten())
    // rust: .chain(hand.iter().map(|h| &h.0))
    // rust: .find(touched)
    // rust: .map(|_| true)
    // rust: .or_else(|| passes.iter().find(touched).map(|_| true));
    // rust: if clears[b].is_some() && first == Some(true) {
    // rust: cleared.push(b);
}
}
        // Terrain tests against the world's depth (entities...), so the blit copies it then.
    // rust: let blit_depth = terrain.is_some()
    // rust: || terrain_cutout.is_some()
    // rust: || water.is_some()
    // rust: || sky.is_some()
    // rust: || entities.as_ref().is_some_and(Entities::drawn)
    // rust: || clouds.is_some()
    // rust: || lines.is_some()
    // rust: || weather.is_some()
    // rust: || hand.is_some()
    // rust: || passes
    // rust: .iter()
    // rust: .flat_map(|p| std::iter::once(p).chain(&p.compute))
    // rust: .any(|p| {
    // rust: p.samplers.iter().any(|s| {
    // rust: matches!(s.source, Source::Depth | Source::Depth1 | Source::Depth2)
    // rust: })
    // rust: });
        // Buffers of a size of their own clear apart from the blit, which writes colortex0.
    // rust: let (mut cleared, mut other_clears): (Vec<usize>, Vec<usize>) =
    // rust: cleared.into_iter().partition(|&b| sizes[b].is_none());
    // rust: let limits = device.limits();
    // rust: let max_attachments = (limits.max_color_attachments as usize).min(8);
    // rust: let mut bytes = attachment_bytes(0, formats[0]);
    // rust: let mut attachments = 1;
    // rust: cleared.retain(|&b| {
    // rust: let next = attachment_bytes(bytes, formats[b]);
    // rust: if attachments < max_attachments && next <= limits.max_color_attachment_bytes_per_sample
    // rust: {
    // rust: attachments += 1;
    // rust: bytes = next;
    // rust: true
    // rust: } else {
    // rust: other_clears.push(b);
    // rust: false
}
    // rust: });
    // rust: let float = wgpu::TextureSampleType::Float { filterable: true };
        // The world's colour is floats: an integer colortex0 (`RGBA32UI`...) gets only what the
        // pack writes, and is cleared in a pass of its own.
    // rust: let world_color = holds_floats(formats[0]);
    // rust: if !world_color {
    // rust: other_clears.push(0);
}
    // rust: let mut world_target = world_color.then(|| target(formats[0])).flatten();
    // rust: if rgb & 1 != 0
    // rust: && let Some(t) = &mut world_target
    // rust: {
    // rust: t.write_mask = wgpu::ColorWrites::COLOR;
}
    // rust: let blit_targets = std::iter::once(world_target);
        // Cleared by the pass's load operation; the shader writes nothing there.
    // rust: let blit_targets: Vec<_> = blit_targets
    // rust: .chain(cleared.iter().map(|&b| {
    // rust: Some(wgpu::ColorTargetState {
    // rust: format: formats[b],
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::empty(),
    // rust: })
    // rust: }))
    // rust: .collect();
    // rust: let blit = (world_color || blit_depth || !cleared.is_empty()).then(|| {
    // rust: helper(
    // rust: device,
    // rust: "vs_full",
    // rust: if blit_depth {
    // rust: "fs_blit"
    // rust: } else {
    // rust: "fs_blit_color"
    // rust: },
    // rust: &[
    // rust: texture_entry(0, float),
    // rust: texture_entry(1, wgpu::TextureSampleType::Float { filterable: false }),
    // rust: ],
    // rust: &blit_targets,
                // GL's window depth, written for depthtex0 and the terrain's depth test.
    // rust: blit_depth.then_some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(true),
    // rust: depth_compare: Some(wgpu::CompareFunction::Always),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: )
    // rust: });
    // rust: let copy = helper(
    // rust: device,
    // rust: "vs_uv",
    // rust: "fs_copy",
    // rust: &[
    // rust: texture_entry(0, float),
    // rust: entry(
    // rust: 2,
    // rust: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: ),
    // rust: ],
    // rust: &[target(screen)],
    // rust: None,
    // rust: );
    // rust: let upscale = helper(
    // rust: device,
    // rust: "vs_screen",
    // rust: "fs_copy",
    // rust: &[
    // rust: texture_entry(0, float),
    // rust: entry(
    // rust: 2,
    // rust: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: ),
    // rust: ],
    // rust: &[target(screen)],
    // rust: None,
    // rust: );
    // rust: let filterable = |b: usize| {
    // rust: formats[b].sample_type(None, Some(device.features()))
    // rust: == Some(wgpu::TextureSampleType::Float { filterable: true })
}
    // rust: let asked = passes.iter().fold(0u16, |m, p| m | p.mipmaps);
    // rust: let mipped = (0..BUFFERS)
    // rust: .filter(|&b| asked & 1 << b != 0 && filterable(b))
    // rust: .fold(0u16, |m, b| m | 1 << b);
    // rust: if asked & !mipped != 0 {
    // rust: notes.push(format!(
    // rust: "mipmaps of unfilterable buffers are not generated (buffers {:#b})",
    // rust: asked & !mipped
    // rust: ));
}
    // rust: let mut down = HashMap::new();
    // rust: for b in (0..BUFFERS).filter(|b| mipped & 1 << b != 0) {
    // rust: down.entry(formats[b]).or_insert_with(|| {
    // rust: helper(
    // rust: device,
    // rust: "vs_full",
    // rust: "fs_down",
    // rust: &[
    // rust: texture_entry(0, float),
    // rust: entry(
    // rust: 2,
    // rust: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: ),
    // rust: ],
    // rust: &[target(formats[b])],
    // rust: None,
    // rust: )
    // rust: });
}
    // rust: let white = [255u8; 4];
    // rust: let black = [0u8; 4];
    // rust: let flat_normal = [128u8, 128, 255, 255];
    // rust: Ok(Self {
    // rust: notes,
    // rust: setup_pending: true,
    // rust: passes,
    // rust: terrain,
    // rust: terrain_cutout,
    // rust: water,
    // rust: sky,
    // rust: entities,
    // rust: clouds,
    // rust: cloud_draw: None,
    // rust: lines,
    // rust: line_draw: None,
    // rust: hides_clouds,
    // rust: hides_sky,
    // rust: hides_celestial,
    // rust: sky_clear,
    // rust: weather,
    // rust: weather_draw: None,
    // rust: weather_generation: 0,
    // rust: hand,
    // rust: depth1,
    // rust: depth2,
    // rust: shadow_targets,
    // rust: shadow_terrain,
    // rust: portal_rect: [0.0; 4],
    // rust: portal_texture: None,
    // rust: shadow_water,
    // rust: shadow_comp,
    // rust: mipped,
    // rust: mips_valid: 0,
    // rust: down,
    // rust: draws,
    // rust: block_ids,
    // rust: page_groups: HashMap::new(),
    // rust: gui_size: world.gui_size,
    // rust: timing: None,
    // rust: center_depth: None,
    // rust: custom,
    // rust: atlas: world.atlas.as_ref().map(|a| a.0.clone()),
    // rust: material_maps: world.material_maps,
    // rust: lightmap: world.lightmap,
    // rust: deferred_pre: mask(&post.deferred_pre),
    // rust: composite_pre: mask(&post.composite_pre),
    // rust: formats,
    // rust: clears,
    // rust: rgb,
    // rust: rgb_unset: true,
    // rust: used,
    // rust: doubled: doubled & used,
    // rust: storage,
    // rust: copied,
    // rust: sizes,
    // rust: blit_depth,
    // rust: blit_clears: cleared,
    // rust: other_clears,
    // rust: blit_group: None,
    // rust: main: 0,
    // rust: targets: None,
    // rust: noise: pack_textures::noise(&textures)
    // rust: .cloned()
    // rust: .unwrap_or_else(|| noise(device, queue)),
    // rust: dummy: texture(device, queue, "Shader pack stand-in", 1, &white),
    // rust: dummy_black: texture(device, queue, "Shader pack black stand-in", 1, &black),
    // rust: dummy_normal: texture(
    // rust: device,
    // rust: queue,
    // rust: "Shader pack normal stand-in",
    // rust: 1,
    // rust: &flat_normal,
    // rust: ),
    // rust: images: {
    // rust: let mut images = images;
    // rust: for (k, image) in images.iter_mut().enumerate() {
    // rust: image.copied = image_copied & 1 << k != 0;
    // rust: image.snapshotted = snapshotted & 1 << k != 0;
}
    // rust: images
    // rust: },
    // rust: buffers,
    // rust: indices,
    // rust: shadow_culling: post.shadow_culling,
    // rust: gpu,
    // rust: zeros: None,
    // rust: stand_ins,
    // rust: dump: pack_images::Dump::new(),
    // rust: dummy_3d: device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Shader pack 3D stand-in"),
    // rust: size: wgpu::Extent3d {
    // rust: width: 1,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D3,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default()),
    // rust: dummy_1d: device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Shader pack 1D stand-in"),
    // rust: size: wgpu::Extent3d {
    // rust: width: 1,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D1,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default()),
    // rust: textures,
    // rust: shadow: (
    // rust: device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Shader pack shadow stand-in"),
    // rust: size: wgpu::Extent3d {
    // rust: width: 1,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::RENDER_ATTACHMENT,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default()),
    // rust: device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Shader pack shadow"),
    // rust: compare: Some(wgpu::CompareFunction::LessEqual),
    // rust: ..Default::default()
    // rust: }),
    // rust: ),
    // rust: shadow_cleared: false,
    // rust: linear: sampler(
    // rust: device,
    // rust: wgpu::FilterMode::Linear,
    // rust: wgpu::AddressMode::ClampToEdge,
    // rust: ),
    // rust: nearest: sampler(
    // rust: device,
    // rust: wgpu::FilterMode::Nearest,
    // rust: wgpu::AddressMode::ClampToEdge,
    // rust: ),
    // rust: repeat: sampler(device, wgpu::FilterMode::Linear, wgpu::AddressMode::Repeat),
    // rust: nearest_repeat: sampler(device, wgpu::FilterMode::Nearest, wgpu::AddressMode::Repeat),
    // rust: atlas_sampler: device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Shader pack atlas"),
    // rust: address_mode_u: wgpu::AddressMode::Repeat,
    // rust: address_mode_v: wgpu::AddressMode::Repeat,
    // rust: mipmap_filter: wgpu::MipmapFilterMode::Linear,
    // rust: ..Default::default()
    // rust: }),
    // rust: buffer_sampler: device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Shader pack buffers"),
    // rust: mag_filter: wgpu::FilterMode::Linear,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: mipmap_filter: wgpu::MipmapFilterMode::Linear,
    // rust: ..Default::default()
    // rust: }),
    // rust: blit,
    // rust: copy,
    // rust: upscale,
    // rust: final_target: None,
    // rust: screen,
    // rust: uniforms: {
    // rust: let mut u = FrameUniforms::default();
    // rust: u.atlas = world.atlas.map_or([0; 2], |a| a.1);
    // rust: u.shadow = shadow_config;
    // rust: u
    // rust: },
    // rust: shadow_cache: Default::default(),
    // rust: })
}

    // Writes `pass`'s uniforms for a target of `out` pixels; its bind group for the buffers'
    // current mapping. The buffers it both samples and stores to are copied first, and it
    // samples the copies.
    // rust: fn bind(
    // rust: &self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: pass: &mut Pass,
    // rust: out: [u32; 2],
    // rust: ) -> wgpu::BindGroup {
    // rust: pack_images::copy(encoder, &self.images, pass.image_copies);
    // rust: for &(_, image) in &pass.images {
    // rust: if let Image::StandIn(format, dimension) = image
    // rust: && let Some(s) = pack_images::stand_in(&self.stand_ins, format, dimension)
    // rust: {
    // rust: s.clear(encoder);
}
}
    // rust: if let Some(targets) = &self.targets {
    // rust: for i in (0..BUFFERS).filter(|i| pass.copies & 1 << i != 0) {
    // rust: if let (Some(t), Some(copy)) = (&targets.color[i], &targets.scratch[i]) {
    // rust: let side = usize::from(self.main & 1 << i != 0);
    // rust: encoder.copy_texture_to_texture(
    // rust: t[side].texture().as_image_copy(),
    // rust: copy.texture().as_image_copy(),
    // rust: t[side].texture().size(),
    // rust: );
}
}
}
    // rust: let fog = self.uniforms.fog();
        // Our block members first (`hz_target`, `hz_fog_color`, `hz_fog`, `hz_depth_linear`),
        // then the pack's.
    // rust: let ours = [
    // rust: [
    // rust: out[0] as f32,
    // rust: out[1] as f32,
    // rust: 1.0 / out[0] as f32,
    // rust: 1.0 / out[1] as f32,
    // rust: ],
    // rust: fog[0].to_array(),
    // rust: fog[1].to_array(),
    // rust: pass.depth_linear,
    // rust: ];
    // rust: let head: &[u8] = bytemuck::cast_slice(&ours);
    // rust: let n = head.len().min(pass.block.len());
    // rust: pass.block[..n].copy_from_slice(&head[..n]);
    // rust: for (index, ty, offset) in &pass.uniforms {
    // rust: let Some((i, v)) = index.and_then(|i| Some((i, self.uniforms.values.get(i)?))) else {
    // rust: continue;
}
            // A built-in of another type keeps its initial value (0); custom uniforms were
            // checked when the pass was built.
    // rust: if pack_uniforms::NAMES
    // rust: .get(i)
    // rust: .is_none_or(|name| v.read_as(name, ty))
    // rust: {
    // rust: v.write(ty, &mut pass.block, *offset as usize);
}
}
    // rust: if !pass.block.is_empty() {
    // rust: queue.write_buffer(&pass.ubo, 0, &pass.block);
}
    // rust: let targets = self.targets.as_ref().expect("resized");
    // rust: let shadow = self.shadow_targets.as_ref();
    // rust: let shadow_main = shadow.map_or(0, |s| s.main);
    // rust: let shadow_space = pass.group.shadow();
        // A chain is sampled only while it is current: a buffer written since its last chain
        // reads its first level, never stale levels (6.1.7). The shadow buffers have none.
    // rust: let (main, current) = if shadow_space {
    // rust: (shadow_main, 0)
    // rust: } else {
    // rust: (self.main, self.mips_valid & self.mipped & pass.reads)
}
    // rust: let key = u64::from(main & pass.reads)
    // rust: | u64::from(current) << 16
    // rust: | u64::from(shadow_main & pass.shadow_reads) << 32;
    // rust: let group = pass.groups.entry(key).or_insert_with(|| {
    // rust: let mut entries = vec![wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: pass.ubo.as_entire_binding(),
    // rust: }];
    // rust: for s in &pass.samplers {
    // rust: let shadow_color = |i: usize, side: usize| {
    // rust: shadow.and_then(|t| t.color[i].as_ref()).map(|c| &c[side])
}
    // rust: let texture = match s.source {
    // rust: Source::Color(i) if shadow_space => {
    // rust: shadow_color(i, usize::from(key & 1 << i != 0)).unwrap_or(&self.dummy)
}
    // rust: Source::ShadowColor(i) => {
    // rust: shadow_color(i, usize::from(key & 1 << (32 + i) != 0))
    // rust: .unwrap_or(&self.dummy)
}
    // rust: Source::ShadowDepth(i, _) => match shadow {
    // rust: Some(t) => match (i, &t.depth1) {
    // rust: (1, Some(d)) => &d.1,
    // rust: _ => &t.depth.1,
    // rust: },
    // rust: None => &self.shadow.0,
    // rust: },
    // rust: Source::Color(i) if pass.copies & 1 << i != 0 => {
    // rust: targets.scratch[i].as_ref().unwrap_or(&self.dummy)
}
    // rust: Source::Color(i) => {
    // rust: let side = usize::from(key & 1 << i != 0);
    // rust: match (&targets.mips[i], &targets.color[i]) {
    // rust: (Some(m), _) if current & 1 << i != 0 => &m[side].all,
    // rust: (_, Some(t)) => &t[side],
    // rust: (_, None) => &self.dummy,
}
}
    // rust: Source::Depth => &targets.depth,
                    // Before translucent terrain the two are the same.
    // rust: Source::Depth1 => match &targets.depth1 {
    // rust: Some(d)
    // rust: if matches!(
    // rust: pass.group,
    // rust: Group::Deferred
    // rust: | Group::Composite
    // rust: | Group::Final
    // rust: | Group::Translucent
    // rust: ) =>
    // rust: {
    // rust: &d.1
}
    // rust: _ => &targets.depth,
    // rust: },
    // rust: Source::Depth2 => match &targets.depth2 {
    // rust: Some(d)
    // rust: if matches!(
    // rust: pass.group,
    // rust: Group::Deferred
    // rust: | Group::Composite
    // rust: | Group::Final
    // rust: | Group::Translucent
    // rust: ) =>
    // rust: {
    // rust: &d.1
}
    // rust: _ => match &targets.depth1 {
    // rust: Some(d)
    // rust: if matches!(
    // rust: pass.group,
    // rust: Group::Deferred
    // rust: | Group::Composite
    // rust: | Group::Final
    // rust: | Group::Translucent
    // rust: ) =>
    // rust: {
    // rust: &d.1
}
    // rust: _ => &targets.depth,
    // rust: },
    // rust: },
    // rust: Source::Noise => &self.noise,
    // rust: Source::Dummy if s.dimension == wgpu::TextureViewDimension::D3 => {
    // rust: &self.dummy_3d
}
    // rust: Source::Dummy if s.dimension == wgpu::TextureViewDimension::D1 => {
    // rust: &self.dummy_1d
}
    // rust: Source::Normals => self
    // rust: .material_maps
    // rust: .as_ref()
    // rust: .filter(|_| pass.material_maps)
    // rust: .map_or(&self.dummy_normal, |maps| &maps[0]),
    // rust: Source::Specular => self
    // rust: .material_maps
    // rust: .as_ref()
    // rust: .filter(|_| pass.material_maps)
    // rust: .map_or(&self.dummy_black, |maps| &maps[1]),
    // rust: Source::Dummy => &self.dummy,
    // rust: Source::Image(k) if pass.image_copies & 1 << k != 0 => {
    // rust: self.images[k].copy.as_ref().unwrap_or(&self.dummy)
}
    // rust: Source::Image(k) => self.images[k].view.as_ref().unwrap_or(&self.dummy),
    // rust: Source::Custom { index, .. } => match &self.textures[index].image {
    // rust: pack_textures::Image::View(v) => v,
    // rust: _ => &self.dummy,
    // rust: },
    // rust: Source::Shadow => &self.shadow.0,
    // rust: Source::Atlas => pass
    // rust: .atlas
    // rust: .as_ref()
    // rust: .or(self.atlas.as_ref())
    // rust: .unwrap_or(&self.dummy),
    // rust: Source::Lightmap => &self.lightmap,
}
    // rust: let sampler = match SamplerKind::of(s.source, s.filtering) {
    // rust: SamplerKind::Linear => &self.linear,
    // rust: SamplerKind::Nearest => &self.nearest,
    // rust: SamplerKind::Repeat => &self.repeat,
    // rust: SamplerKind::NearestRepeat => &self.nearest_repeat,
    // rust: SamplerKind::Atlas => &self.atlas_sampler,
    // rust: SamplerKind::Buffer => &self.buffer_sampler,
    // rust: SamplerKind::Comparison => shadow.map_or(&self.shadow.1, |t| &t.comparison),
}
    // rust: entries.push(wgpu::BindGroupEntry {
    // rust: binding: s.binding,
    // rust: resource: wgpu::BindingResource::TextureView(texture),
    // rust: });
    // rust: if s.sampler == s.binding + 1 {
    // rust: entries.push(wgpu::BindGroupEntry {
    // rust: binding: s.sampler,
    // rust: resource: wgpu::BindingResource::Sampler(sampler),
    // rust: });
}
}
            // An image is the side its buffer's sampler reads.
    // rust: for &(binding, image) in &pass.images {
    // rust: let view = match image {
    // rust: Image::Color(i) => {
    // rust: let side = usize::from(key & 1 << i != 0);
    // rust: targets.color[i].as_ref().map_or(&self.dummy, |t| &t[side])
}
    // rust: Image::Custom(k) => self.images[k].view.as_ref().unwrap_or(&self.dummy),
    // rust: Image::ColorBefore(i) => targets.scratch[i].as_ref().unwrap_or(&self.dummy),
    // rust: Image::CustomBefore(k) => self.images[k].before.as_ref().unwrap_or(&self.dummy),
    // rust: Image::StandIn(format, dimension) => {
    // rust: pack_images::stand_in(&self.stand_ins, format, dimension)
    // rust: .map_or(&self.dummy, |s| &s.view)
}
}
    // rust: entries.push(wgpu::BindGroupEntry {
    // rust: binding,
    // rust: resource: wgpu::BindingResource::TextureView(view),
    // rust: });
}
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some(&pass.name),
    // rust: layout: &pass.layout,
    // rust: entries: &entries,
    // rust: })
    // rust: });
    // rust: group.clone()
}

    // Dispatches compute pass `pass` over a target of `size`.
    // rust: fn dispatch(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: pass: &mut Pass,
    // rust: size: [u32; 2],
    // rust: ) {
    // rust: let Pipeline::Compute {
    // rust: pipeline,
    // rust: groups,
    // rust: render,
    // rust: local,
    // rust: } = &pass.pipeline
    // rust: else {
    // rust: return;
}
    // rust: let groups = groups.unwrap_or_else(|| {
    // rust: let n = |k: usize| (size[k] as f32 * render[k] / local[k] as f32).ceil() as u32;
    // rust: [n(0), n(1), 1]
    // rust: });
    // rust: let (pipeline, groups) = (pipeline.clone(), groups);
    // rust: for image in (0..self.images.len()).filter(|k| pass.snapshots & 1 << k != 0) {
    // rust: pack_images::snapshot(encoder, &self.images[image]);
}
    // rust: let group = self.bind(device, queue, encoder, pass, size);
    // rust: let mut cp = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
    // rust: label: Some(&pass.name),
    // rust: timestamp_writes: self
    // rust: .timing
    // rust: .as_mut()
    // rust: .and_then(|t| t.compute_writes(&pass.name)),
    // rust: });
    // rust: cp.set_pipeline(&pipeline);
    // rust: cp.set_bind_group(0, &group, &[]);
    // rust: if pass.buffers
    // rust: && let Some(g) = &self.buffers.group
    // rust: {
    // rust: cp.set_bind_group(4, g, &[]);
}
    // rust: cp.dispatch_workgroups(groups[0], groups[1], groups[2]);
    // rust: drop(cp);
    // rust: self.mips_valid &= !pass.written;
}

    // A render pass into the buffers `pass` writes, in place, tested against the world's depth.
    // rust: fn begin<'e>(
    // rust: &mut self,
    // rust: encoder: &'e mut wgpu::CommandEncoder,
    // rust: pass: &Pass,
    // rust: ) -> wgpu::RenderPass<'e> {
    // rust: let targets = self.targets.as_ref().expect("resized");
    // rust: let load = wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
}
        // The shadow pass draws into the shadow buffers and the shadow map, the frame's first
        // one clearing them.
    // rust: let (depth_ops, shadow_ops) = match &mut self.shadow_targets {
    // rust: Some(s) if pass.group.shadow() => s.clear_ops(pass.writes.iter().map(|w| w.1)),
    // rust: _ => (super::pack_shadow::load(), [load; SHADOW_COLORS]),
}
    // rust: let shadow = self.shadow_targets.as_ref().filter(|_| pass.group.shadow());
    // rust: let mut attachments: Vec<Option<wgpu::RenderPassColorAttachment>> = Vec::new();
    // rust: for &(location, buffer) in &pass.writes {
    // rust: let l = location as usize;
    // rust: if attachments.len() <= l {
    // rust: attachments.resize(l + 1, None);
}
    // rust: attachments[l] = match shadow {
    // rust: Some(s) => s
    // rust: .color(buffer, false)
    // rust: .and_then(|v| attach(v, shadow_ops.get(buffer).copied().unwrap_or(load))),
    // rust: None => targets.color[buffer]
    // rust: .as_ref()
    // rust: .and_then(|t| attach(&t[usize::from(self.main & 1 << buffer != 0)], load)),
}
}
    // rust: let timestamp_writes = self.timing.as_mut().and_then(|t| t.writes(&pass.name));
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some(&pass.name),
    // rust: color_attachments: &attachments,
    // rust: timestamp_writes,
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: shadow.map_or(&targets.depth, |s| &s.depth.1),
    // rust: depth_ops: Some(depth_ops),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: })
}

    // Terrain (or, `translucent`, translucent terrain) with the pack's program; `draw` issues
    // the game's draws. Solid terrain in two parts has its cutout part drawn second, from the
    // same draws.
    // rust: fn draw_terrain(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: size: [u32; 2],
    // rust: list: TerrainList,
    // rust: draw: &mut TerrainDraw<'_>,
    // rust: ) {
    // rust: self.draw_terrain_part(device, queue, encoder, size, list, false, draw);
    // rust: if list == TerrainList::Solid {
    // rust: self.draw_terrain_part(device, queue, encoder, size, list, true, draw);
}
}

    // The pass that draws `list`, or the cutout part of the solid list.
terrain_slot :: proc(self: ^Self, list: TerrainList, cutout: bool) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match list {
    // rust: TerrainList::Solid if cutout => &mut self.terrain_cutout,
    // rust: TerrainList::Solid => &mut self.terrain,
    // rust: TerrainList::Translucent => &mut self.water,
    // rust: TerrainList::ShadowSolid => &mut self.shadow_terrain,
    // rust: TerrainList::ShadowTranslucent => &mut self.shadow_water,
}
}

    // rust: fn draw_terrain_part(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: size: [u32; 2],
    // rust: list: TerrainList,
    // rust: cutout: bool,
    // rust: draw: &mut TerrainDraw<'_>,
    // rust: ) {
    // rust: let Some(mut pass) = self.terrain_slot(list, cutout).take() else {
    // rust: return;
}
    // rust: let translucent = list.translucent();
    // rust: let group = self.bind(device, queue, encoder, &mut pass, size);
    // rust: {
    // rust: let mut rp = self.begin(encoder, &pass);
    // rust: rp.set_pipeline(pass.render());
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: if pass.buffers
    // rust: && let Some(g) = &self.buffers.group
    // rust: {
    // rust: rp.set_bind_group(4, g, &[]);
}
    // rust: if pass.draw {
    // rust: let stage = if translucent {
    // rust: "TERRAIN_TRANSLUCENT"
    // rust: } else {
    // rust: "TERRAIN_SOLID"
}
    // rust: self.draws.bind(&mut rp, stage);
}
    // rust: let (groups, ids) = (&self.page_groups, pass.ids);
    // rust: let page = |rp: &mut wgpu::RenderPass<'_>, page: u32| {
    // rust: if let Some((_, group)) = groups.get(&page).filter(|_| ids) {
    // rust: rp.set_bind_group(3, group, &[]);
}
}
    // rust: let geometry = self
    // rust: .indices
    // rust: .as_ref()
    // rust: .filter(|_| pass.geometry > 0)
    // rust: .map(|indices| (pass.geometry, indices));
    // rust: draw(&mut rp, list, &page, geometry);
}
    // rust: if !pass.group.shadow() {
    // rust: self.mips_valid &= !pass.written;
}
    // rust: *self.terrain_slot(list, cutout) = Some(pass);
}

    // The sky's parts in vanilla's order, each with the program that draws it; one render pass
    // while consecutive programs write the same buffers.
    // rust: fn draw_sky(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: size: [u32; 2],
    // rust: frame: &super::Frame,
    // rust: ) {
    // rust: let Some(mut sky) = self.sky.take() else {
    // rust: return;
}
    // rust: let parts = sky
    // rust: .geometry
    // rust: .prepare(queue, frame, self.uniforms.shadow.sun_path_rotation);
    // rust: let mut groups = [None, None];
    // rust: for (i, pass) in [&mut sky.basic, &mut sky.textured].into_iter().enumerate() {
    // rust: if let Some(pass) = pass {
    // rust: groups[i] = Some(self.bind(device, queue, encoder, pass, size));
    // rust: self.mips_valid &= !pass.written;
}
}
    // rust: let passes = [&sky.basic, &sky.textured];
    // rust: let mut open: Option<(wgpu::RenderPass<'_>, usize)> = None;
    // rust: for part in parts {
    // rust: let i = usize::from(part.textured);
    // rust: let (Some(pass), Some(group)) = (passes[i], &groups[i]) else {
    // rust: continue;
}
    // rust: let current = open.as_ref().map(|o| o.1);
    // rust: if current != Some(i) {
    // rust: let same = current
    // rust: .and_then(|c| passes[c].as_ref())
    // rust: .is_some_and(|p| p.writes == pass.writes);
    // rust: if !same {
    // rust: drop(open.take());
    // rust: open = Some((self.begin(encoder, pass).forget_lifetime(), i));
}
    // rust: let rp = &mut open.as_mut().expect("open").0;
    // rust: rp.set_pipeline(pass.render());
    // rust: rp.set_bind_group(0, group, &[]);
                // A sky program that reads the pack's SSBOs (Noble's `gbuffers_textured`, the
                // sun's fallback) binds them, as the other passes do.
    // rust: if pass.buffers
    // rust: && let Some(g) = &self.buffers.group
    // rust: {
    // rust: rp.set_bind_group(4, g, &[]);
}
    // rust: sky.geometry.bind(rp, part.textured);
    // rust: open.as_mut().expect("open").1 = i;
}
    // rust: let rp = &mut open.as_mut().expect("open").0;
    // rust: if pass.draw {
    // rust: self.draws.bind(rp, part.stage);
}
    // rust: rp.draw(part.range, 0..1);
}
    // rust: drop(open);
    // rust: self.sky = Some(sky);
}

    // Entities, block entities, translucent entity parts and particles with the pack's
    // programs, those drawn before deferred or (`late`) after: each run `prepare_entities` kept
    // is one draw with its own `entityId` or `blockEntityId` and `entityColor`.
    // rust: fn draw_entities(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: size: [u32; 2],
    // rust: late: bool,
    // rust: ) {
    // rust: let Some(mut entities) = self.entities.take() else {
    // rust: return;
}
    // rust: let geometry = &entities.geometry;
    // rust: for (program, pass) in entities.passes.iter_mut().enumerate() {
    // rust: let Some(pass) = pass.as_mut().filter(|_| entities.late[program] == late) else {
    // rust: continue;
}
    // rust: let mut draws = geometry
    // rust: .draws
    // rust: .iter()
    // rust: .filter(|d| d.pack && d.program == program)
    // rust: .peekable();
    // rust: if draws.peek().is_none() {
    // rust: continue;
}
    // rust: let group = self.bind(device, queue, encoder, pass, size);
    // rust: let portal_group = self.portal_group(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: pass,
    // rust: size,
    // rust: geometry
    // rust: .draws
    // rust: .iter()
    // rust: .any(|d| d.pack && d.program == program && d.portal),
    // rust: );
    // rust: {
    // rust: let mut rp = self.begin(encoder, pass);
    // rust: rp.set_pipeline(pass.render());
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: if pass.buffers
    // rust: && let Some(g) = &self.buffers.group
    // rust: {
    // rust: rp.set_bind_group(4, g, &[]);
}
    // rust: rp.set_bind_group(1, &geometry.table_group, &[]);
    // rust: rp.set_vertex_buffer(0, geometry.vertices());
    // rust: rp.set_index_buffer(geometry.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: let mut on_portal = false;
    // rust: for d in draws {
    // rust: if let Some(portal) = &portal_group
    // rust: && d.portal != on_portal
    // rust: {
    // rust: rp.set_bind_group(0, if d.portal { portal } else { &group }, &[]);
    // rust: on_portal = d.portal;
}
    // rust: if pass.draw {
    // rust: rp.set_bind_group(2, &geometry.group, &[geometry.offset(d.slot)]);
}
    // rust: rp.draw_indexed(0..d.quads * 6, d.base as i32, 0..1);
}
}
    // rust: self.mips_valid &= !pass.written;
}
    // rust: self.entities = Some(entities);
}

    // End portal faces bind `end_portal.png` as the atlas, a texture of its own, so packs that
    // wrap it with their own coordinates sample the portal sprite only. `None` when no portal
    // face draws in this pass.
    // rust: fn portal_group(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: pass: &mut Pass,
    // rust: size: [u32; 2],
    // rust: wanted: bool,
    // rust: ) -> Option<wgpu::BindGroup> {
    // rust: let atlas = pass.atlas.clone().or_else(|| self.atlas.clone())?;
    // rust: if !wanted || self.portal_rect[2] <= 0.0 {
    // rust: return None;
}
    // rust: if self
    // rust: .portal_texture
    // rust: .as_ref()
    // rust: .is_none_or(|(rect, _)| *rect != self.portal_rect)
    // rust: {
    // rust: let view = super::pack_weather::copy_sprite(
    // rust: device,
    // rust: encoder,
    // rust: atlas.texture(),
    // rust: self.portal_rect,
    // rust: );
    // rust: self.portal_texture = Some((self.portal_rect, view));
    // rust: pass.portal_groups.clear();
}
        // `bind` caches groups by a key without the atlas: the portal groups are kept in a cache
        // of their own, swapped in with the texture.
    // rust: let view = self.portal_texture.as_ref().map(|p| p.1.clone());
    // rust: let saved = std::mem::replace(&mut pass.atlas, view);
    // rust: let groups = std::mem::replace(&mut pass.groups, std::mem::take(&mut pass.portal_groups));
    // rust: let group = self.bind(device, queue, encoder, pass, size);
    // rust: pass.portal_groups = std::mem::replace(&mut pass.groups, groups);
    // rust: pass.atlas = saved;
    // rust: Some(group)
}

    // Entities and block entities into the shadow map, each run with the per-draw uniforms
    // of its gbuffers draw (2.4): opaque, so before the `shadowtex1` copy.
    // rust: fn draw_shadow_entities(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: size: [u32; 2],
    // rust: ) {
    // rust: let Some(mut entities) = self.entities.take() else {
    // rust: return;
}
    // rust: let geometry = &entities.geometry;
    // rust: for (program, pass) in entities.shadow.iter_mut().enumerate() {
    // rust: let Some(pass) = pass else {
    // rust: continue;
}
    // rust: let mut draws = (geometry.draws.iter())
    // rust: .filter(|d| d.shadow && d.program == program)
    // rust: .peekable();
    // rust: if draws.peek().is_none() {
    // rust: continue;
}
    // rust: let group = self.bind(device, queue, encoder, pass, size);
    // rust: let portal_group = self.portal_group(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: pass,
    // rust: size,
    // rust: (geometry.draws.iter()).any(|d| d.shadow && d.program == program && d.portal),
    // rust: );
    // rust: let mut on_portal = false;
    // rust: let mut rp = self.begin(encoder, pass);
    // rust: rp.set_pipeline(pass.render());
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: if pass.buffers
    // rust: && let Some(g) = &self.buffers.group
    // rust: {
    // rust: rp.set_bind_group(4, g, &[]);
}
    // rust: rp.set_bind_group(1, &geometry.table_group, &[]);
    // rust: rp.set_vertex_buffer(0, geometry.vertices());
    // rust: rp.set_index_buffer(geometry.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: for d in draws {
    // rust: if let Some(portal) = &portal_group
    // rust: && d.portal != on_portal
    // rust: {
    // rust: rp.set_bind_group(0, if d.portal { portal } else { &group }, &[]);
    // rust: on_portal = d.portal;
}
    // rust: if pass.draw {
    // rust: rp.set_bind_group(2, &geometry.group, &[geometry.offset(d.slot)]);
}
    // rust: if pass.geometry > 0 {
                    // A geometry stage reads its vertices itself: corner `c` of the run is
                    // vertex `c` past the run's first quad's six (`geometry_inputs`), one
                    // instance per triangle the stage can emit.
    // rust: let first = d.base / 4 * 6;
    // rust: rp.draw(first..first + d.quads * 6, 0..pass.geometry);
    // rust: } else {
    // rust: rp.draw_indexed(0..d.quads * 6, d.base as i32, 0..1);
}
}
}
    // rust: self.entities = Some(entities);
}

    // Splits `entities` (`Frame::entities`) between the pack and Horizon by its runs
    // (`spans`): the pack's part is uploaded for this frame's draw, Horizon's goes to `rest`.
    // rust: pub fn prepare_entities(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: entities: &[super::Vertex],
    // rust: spans: &[super::pack_draw::EntitySpan],
    // rust: crumbling: [f32; 4],
    // rust: portal: [f32; 4],
    // rust: rest: &mut Vec<super::Vertex>,
    // rust: skin: Option<&super::entity_skin::SkinFrame>,
    // rust: ) {
    // rust: self.portal_rect = portal;
    // rust: let shadow = self.shadow_casters();
    // rust: let Some(e) = &mut self.entities else {
    // rust: rest.clear();
    // rust: rest.extend_from_slice(entities);
    // rust: return;
}
    // rust: let drawn = e.passes.each_ref().map(Option::is_some);
    // rust: e.geometry.prepare(
    // rust: device,
    // rust: queue,
    // rust: &self.draws.layout,
    // rust: entities,
    // rust: spans,
    // rust: drawn,
    // rust: (crumbling, self.gui_size),
    // rust: shadow,
    // rust: rest,
    // rust: skin,
    // rust: );
}

    // Every stage a posable subject can use must have a compiled fallback.
    // Special models, player and eye/tagged layers retain their CPU paths.
skins_entities :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.entities
    // rust: .as_ref()
    // rust: .is_some_and(|e| e.passes[..3].iter().all(Option::is_some))
}

skin_target :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.entities.as_ref().map(|e| e.geometry.skin_target())
}

    // Which entity runs the shadow pass draws: none without it.
shadow_casters :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let Some(e) = self
    // rust: .entities
    // rust: .as_ref()
    // rust: .filter(|_| self.shadow_targets.is_some())
    // rust: else {
    // rust: return Default::default();
}
    // rust: super::pack_entities::Casters {
    // rust: entities: e.shadow[0].is_some(),
    // rust: only_player: e.only.0,
    // rust: blocks: e.shadow[1].is_some(),
    // rust: only_lit: e.only.1,
}
}

    // The centre depth the frame copied: its readback, started by calling it right after the
    // frame's submission.
submitted :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.center_depth.as_mut()?.submitted()
}

    // Whether the pack draws entities or block entities itself.
has_entities :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.entities.is_some()
}

    // The sky, when it shows, then terrain, entities and block entities.
    // rust: fn draw_opaque(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: size: [u32; 2],
    // rust: frame: &super::Frame,
    // rust: terrain: &mut TerrainDraw<'_>,
    // rust: ) {
    // rust: if super::sky_visible(frame) {
    // rust: self.draw_sky(device, queue, encoder, size, frame);
}
    // rust: self.draw_terrain(device, queue, encoder, size, TerrainList::Solid, terrain);
    // rust: self.draw_entities(device, queue, encoder, size, false);
    // rust: self.draw_lines(device, queue, encoder, size);
    // rust: self.draw_clouds(device, queue, encoder, size);
        // Only depth2 excludes the opaque first-person hand.
    // rust: if let Some(t) = &self.targets
    // rust: && let Some((copy, _)) = &t.depth2
    // rust: {
    // rust: encoder.copy_texture_to_texture(
    // rust: t.depth_texture.as_image_copy(),
    // rust: copy.as_image_copy(),
    // rust: t.depth_texture.size(),
    // rust: );
}
    // rust: self.draw_hand(device, queue, encoder, size, frame);
        // Depth1 includes that hand, but still precedes translucent terrain.
    // rust: if let Some(t) = &self.targets
    // rust: && let Some((copy, _)) = &t.depth1
    // rust: {
    // rust: encoder.copy_texture_to_texture(
    // rust: t.depth_texture.as_image_copy(),
    // rust: copy.as_image_copy(),
    // rust: t.depth_texture.size(),
    // rust: );
}
}

    // The first-person hand and held items, with `gbuffers_hand` at the hand's projection.
    // rust: fn draw_hand(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: size: [u32; 2],
    // rust: frame: &super::Frame,
    // rust: ) {
    // rust: let Some((mut pass, mut geometry)) = self.hand.take() else {
    // rust: return;
}
        // The hand draws through `gbufferModelView`, which holds the nausea spin the world
        // turns with; the hand doesn't (as vanilla's), so its projection takes the spin out.
    // rust: let unspin = frame.bob * frame.spin.inverse() * frame.bob.inverse();
    // rust: let projection = super::pack_hand::projection(
    // rust: frame.hand_fov_degrees,
    // rust: size[0] as f32 / size[1].max(1) as f32,
    // rust: frame.depth_far,
    // rust: ) * unspin;
    // rust: geometry.prepare(device, queue, frame.hand, frame.hand_items, projection);
    // rust: if geometry.quads > 0 {
    // rust: let group = self.bind(device, queue, encoder, &mut pass, size);
    // rust: {
    // rust: let mut rp = self.begin(encoder, &pass);
    // rust: rp.set_pipeline(pass.render());
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: if pass.buffers
    // rust: && let Some(g) = &self.buffers.group
    // rust: {
    // rust: rp.set_bind_group(4, g, &[]);
}
    // rust: rp.set_bind_group(1, &geometry.group, &[]);
    // rust: rp.set_vertex_buffer(0, geometry.vertices());
    // rust: rp.set_index_buffer(geometry.indices.slice(..), wgpu::IndexFormat::Uint32);
                // The arm and each held item: their own `currentRenderedItemId`.
    // rust: for &(first, quads, offset) in &geometry.runs {
    // rust: if pass.draw {
    // rust: rp.set_bind_group(2, &geometry.slot_group, &[offset]);
}
    // rust: rp.draw_indexed(first * 6..(first + quads) * 6, 0, 0..1);
}
}
    // rust: self.mips_valid &= !pass.written;
}
    // rust: self.hand = Some((pass, geometry));
}

    // Whether the pack draws the first-person hand itself.
has_hand :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.hand.is_some()
}

    // The clouds `set_clouds` gave for this frame, with `gbuffers_clouds`.
    // rust: fn draw_clouds(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: size: [u32; 2],
    // rust: ) {
        // The pass stays for later frames when this one has no clouds.
    // rust: let Some(clouds) = self.cloud_draw.take() else {
    // rust: return;
}
    // rust: let Some(mut pass) = self.clouds.take() else {
    // rust: return;
}
    // rust: let group = self.bind(device, queue, encoder, &mut pass, size);
    // rust: {
    // rust: let mut rp = self.begin(encoder, &pass);
    // rust: rp.set_pipeline(pass.render());
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: if pass.buffers
    // rust: && let Some(g) = &self.buffers.group
    // rust: {
    // rust: rp.set_bind_group(4, g, &[]);
}
    // rust: rp.set_bind_group(1, &clouds.group, &[]);
    // rust: if pass.draw {
    // rust: self.draws.bind(&mut rp, "CLOUDS");
}
    // rust: rp.set_vertex_buffer(0, clouds.vertices.slice(..));
    // rust: rp.set_index_buffer(clouds.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: rp.draw_indexed(0..clouds.quads * 6, 0, 0..1);
}
    // rust: self.mips_valid &= !pass.written;
    // rust: self.clouds = Some(pass);
}

    // The block outline `set_lines` gave for this frame, with the pack's lines program.
    // rust: fn draw_lines(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: size: [u32; 2],
    // rust: ) {
        // The pass stays for later frames when this one has no outline.
    // rust: let Some(lines) = self.line_draw.take() else {
    // rust: return;
}
    // rust: let Some(mut pass) = self.lines.take() else {
    // rust: return;
}
    // rust: let group = self.bind(device, queue, encoder, &mut pass, size);
    // rust: {
    // rust: let mut rp = self.begin(encoder, &pass);
    // rust: rp.set_pipeline(pass.render());
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: if pass.buffers
    // rust: && let Some(g) = &self.buffers.group
    // rust: {
    // rust: rp.set_bind_group(4, g, &[]);
}
    // rust: if pass.draw {
    // rust: self.draws.bind(&mut rp, "OUTLINE");
}
    // rust: rp.set_vertex_buffer(0, lines.edges.slice(..));
    // rust: rp.draw(0..6, 0..lines.count);
}
    // rust: self.mips_valid &= !pass.written;
    // rust: self.lines = Some(pass);
}

    // Whether the pack draws the block outline itself.
has_lines :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.lines.is_some()
}

    // The block outline to draw this frame (`None`: none).
set_lines :: proc(self: ^Self, lines: Maybe(Lines)) {
}
    // rust: self.line_draw = lines.filter(|l| l.count > 0);
}

    // Whether the pack draws the clouds itself (or hides them).
has_clouds :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.hides_clouds
}

    // The clouds to draw this frame (`None`: none).
set_clouds :: proc(self: ^Self, clouds: Maybe(Clouds)) {
}
    // rust: self.cloud_draw = clouds.filter(|c| c.quads > 0);
}

    // Translucent terrain, then the entity parts drawn after deferred.
    // rust: fn draw_translucent(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: size: [u32; 2],
    // rust: terrain: &mut TerrainDraw<'_>,
    // rust: ) {
    // rust: self.draw_terrain(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: size,
    // rust: TerrainList::Translucent,
    // rust: terrain,
    // rust: );
    // rust: self.draw_entities(device, queue, encoder, size, true);
    // rust: self.draw_weather(device, queue, encoder, size);
}

    // The rain, then the snow, `set_weather` gave for this frame, with `gbuffers_weather`.
    // rust: fn draw_weather(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: size: [u32; 2],
    // rust: ) {
        // The passes stay for later frames when this one has no rain or snow.
    // rust: let Some(weather) = self.weather_draw.take() else {
    // rust: return;
}
    // rust: let Some(mut passes) = self.weather.take() else {
    // rust: return;
}
    // rust: if weather.generation != self.weather_generation {
    // rust: self.weather_generation = weather.generation;
    // rust: for (pass, sprite) in passes.iter_mut().zip(&weather.sprites) {
    // rust: pass.atlas = sprite.clone();
    // rust: pass.groups.clear();
}
}
    // rust: for (pass, quads) in passes.iter_mut().zip(weather.quads.clone()) {
    // rust: if quads.is_empty() {
    // rust: continue;
}
    // rust: let group = self.bind(device, queue, encoder, pass, size);
    // rust: {
    // rust: let mut rp = self.begin(encoder, pass);
    // rust: rp.set_pipeline(pass.render());
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: if pass.buffers
    // rust: && let Some(g) = &self.buffers.group
    // rust: {
    // rust: rp.set_bind_group(4, g, &[]);
}
    // rust: if pass.draw {
    // rust: self.draws.bind(&mut rp, "RAIN_SNOW");
}
    // rust: rp.set_vertex_buffer(0, weather.vertices.slice(..));
    // rust: rp.set_index_buffer(weather.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: rp.draw_indexed(quads.start * 6..quads.end * 6, 0, 0..1);
}
    // rust: self.mips_valid &= !pass.written;
}
    // rust: self.weather = Some(passes);
}

    // Whether the pack draws rain and snow itself.
has_weather :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.weather.is_some()
}

    // The rain and snow to draw this frame (`None`: none).
set_weather :: proc(self: ^Self, weather: Maybe(Weather)) {
}
    // rust: self.weather_draw = weather;
}

    // Regenerates the mip chain of buffer `b`'s side that programs read.
mipmap :: proc(self: ^Self, encoder: ^wgpu::CommandEncoder, b: uint) {
}
    // rust: let (Some(targets), Some((pipeline, _))) = (&self.targets, self.down.get(&self.formats[b]))
    // rust: else {
    // rust: return;
}
    // rust: let Some(mips) = &targets.mips[b] else { return };
    // rust: let side = &mips[usize::from(self.main & 1 << b != 0)];
        // Timed as one pass per buffer (its first level), so the pass timer shows the chains.
    // rust: let label = format!("mipmaps colortex{b}");
    // rust: let mut first = true;
    // rust: for (attachment, group) in &side.levels {
    // rust: let timestamp_writes = if std::mem::take(&mut first) {
    // rust: self.timing.as_mut().and_then(|t| t.writes(&label))
    // rust: } else {
    // rust: None
}
    // rust: let mut rp = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Shader pack mipmap"),
    // rust: timestamp_writes,
    // rust: color_attachments: &[attach(
    // rust: attachment,
    // rust: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: )],
    // rust: ..Default::default()
    // rust: });
    // rust: rp.set_pipeline(pipeline);
    // rust: rp.set_bind_group(0, group, &[]);
    // rust: rp.draw(0..3, 0..1);
}
}

    // What the shadow camera draws of the terrain this frame, when the pack draws it.
shadow_view :: proc(self: ^Self, frame: ^super::Frame) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.has_shadow() {
    // rust: return None;
}
    // rust: let shadow = &self.uniforms.shadow;
    // rust: Some(ShadowView {
    // rust: cull: pack_uniforms::shadow_culling(frame, shadow),
    // rust: light: pack_uniforms::shadow_light(frame, shadow),
    // rust: distance: (shadow.render_mul > 0.0).then_some(shadow.distance * shadow.render_mul),
    // rust: unculled: match self.shadow_culling {
    // rust: horizon_shaders::ShadowCulling::On => None,
    // rust: horizon_shaders::ShadowCulling::Off => Some(f32::INFINITY),
    // rust: horizon_shaders::ShadowCulling::Reversed => Some(shadow.voxel_distance),
    // rust: },
    // rust: every_face: true,
    // rust: view_casters: true,
    // rust: depth_planes: false,
    // rust: })
}

    // Whether the pack draws terrain itself.
has_terrain :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.terrain.is_some() || self.terrain_cutout.is_some()
}

    // Whether the pack's shadow pass draws terrain (`shadow_view`).
has_shadow :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.shadow_targets.is_some()
    // rust: && (self.shadow_terrain.is_some() || self.shadow_water.is_some())
}

    // Whether the pack draws the sky (disc, sunset, stars, void) itself.
    // What the world's background is when the pack draws the sky: colortex0's clear colour
    // (`None`: the fog colour, its default).
sky_clear :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.sky_clear.filter(|_| self.has_sky())
}

    // Whether the pack has a sky program, drawing or not: vanilla's sky is then not drawn.
has_sky :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.hides_sky
}

    // Whether the pack has the sun and moon's program, drawing or not.
has_celestial :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.hides_celestial
}

    // Whether the pack draws translucent terrain itself.
has_water :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.water.is_some()
}

    // The names of the programs that run, in order.
programs :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.passes.iter().map(|p| p.name.as_str()).collect()
}

    // Drops every pass's cached bind groups, compute stages included: they name views that
    // were made again.
forget_groups :: proc(self: ^Self) {
}
    // rust: let sky = self
    // rust: .sky
    // rust: .iter_mut()
    // rust: .flat_map(|s| s.basic.iter_mut().chain(&mut s.textured));
    // rust: let entities = self
    // rust: .entities
    // rust: .iter_mut()
    // rust: .flat_map(|e| e.passes.iter_mut().chain(&mut e.shadow).flatten());
    // rust: let passes = self
    // rust: .passes
    // rust: .iter_mut()
    // rust: .chain(&mut self.terrain)
    // rust: .chain(&mut self.terrain_cutout)
    // rust: .chain(&mut self.water)
    // rust: .chain(sky)
    // rust: .chain(entities)
    // rust: .chain(&mut self.clouds)
    // rust: .chain(&mut self.lines)
    // rust: .chain(self.weather.iter_mut().flatten())
    // rust: .chain(self.hand.iter_mut().map(|h| &mut h.0))
    // rust: .chain(&mut self.shadow_terrain)
    // rust: .chain(&mut self.shadow_water)
    // rust: .chain(&mut self.shadow_comp);
    // rust: for pass in passes {
    // rust: pass.groups.clear();
    // rust: for c in &mut pass.compute {
    // rust: c.groups.clear();
}
}
}

resize :: proc(self: ^Self, device: ^wgpu::Device, size: [u32; 2]) {
}
    // rust: if pack_images::resize_images(device, &mut self.images, size) {
    // rust: self.forget_groups();
}
    // rust: self.buffers.resize(device, size);
    // rust: if self.targets.as_ref().is_some_and(|t| t.size == size) {
    // rust: return;
}
    // rust: self.setup_pending = true;
    // rust: self.rgb_unset = true;
        // Free the old targets before making the new ones: a pack with large buffers can't
        // hold both sets at once on a card it otherwise fits (a window resize ran out of video
        // memory). The bind groups hold the old views too, and the GPU may still be using
        // them, so wait for it; a resize is rare.
    // rust: if self.targets.take().is_some() {
    // rust: self.forget_groups();
    // rust: let _ = device.poll(wgpu::PollType::wait_indefinitely());
}
    // rust: let sizes: [[u32; 2]; BUFFERS] =
    // rust: std::array::from_fn(|i| self.sizes[i].map_or(size, |s| s.resolve(size)));
    // rust: let full_chain = |size: [u32; 2]| 32 - size[0].max(size[1]).max(1).leading_zeros();
    // rust: let texture_sized = |label: &str, format, usage, levels, size: [u32; 2]| {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: levels,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: usage | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: })
}
    // rust: let texture = |label: &str, format, usage| texture_sized(label, format, usage, 1, size);
    // rust: let level = |t: &wgpu::Texture, level: u32| {
    // rust: t.create_view(&wgpu::TextureViewDescriptor {
    // rust: base_mip_level: level,
    // rust: mip_level_count: Some(1),
    // rust: ..Default::default()
    // rust: })
}
    // rust: let mut mips: [Option<[Mips; 2]>; BUFFERS] = Default::default();
    // rust: let color = std::array::from_fn(|i| {
    // rust: (self.used & 1 << i != 0).then(|| {
    // rust: let label = format!("colortex{i}");
    // rust: let mipped = self.mipped & 1 << i != 0;
    // rust: let levels = if mipped { full_chain(sizes[i]) } else { 1 };
    // rust: let mut attachment = wgpu::TextureUsages::RENDER_ATTACHMENT;
    // rust: if self.storage & 1 << i != 0 {
    // rust: attachment |= wgpu::TextureUsages::STORAGE_BINDING;
                    // Atomics on a texture need it made for them (Metal ignores them otherwise).
    // rust: if device.features().contains(wgpu::Features::TEXTURE_ATOMIC)
    // rust: && matches!(
    // rust: self.formats[i],
    // rust: wgpu::TextureFormat::R32Sint | wgpu::TextureFormat::R32Uint
    // rust: )
    // rust: {
    // rust: attachment |= wgpu::TextureUsages::STORAGE_ATOMIC;
}
}
    // rust: if self.copied & 1 << i != 0 {
    // rust: attachment |= wgpu::TextureUsages::COPY_SRC;
}
                // A buffer that isn't cleared starts each frame with B copied back to A.
    // rust: if i != 0 && self.clears[i].is_none() {
    // rust: attachment |= wgpu::TextureUsages::COPY_SRC | wgpu::TextureUsages::COPY_DST;
}
    // rust: let side = || texture_sized(&label, self.formats[i], attachment, levels, sizes[i]);
    // rust: let a = side();
    // rust: let sides = [
    // rust: a.clone(),
    // rust: if self.doubled & 1 << i != 0 {
    // rust: side()
    // rust: } else {
    // rust: a
    // rust: },
    // rust: ];
    // rust: if mipped && let Some((_, layout)) = self.down.get(&self.formats[i]) {
    // rust: mips[i] = Some(sides.each_ref().map(|t| {
    // rust: Mips {
    // rust: all: t.create_view(&Default::default()),
    // rust: levels: (1..levels)
    // rust: .map(|l| {
    // rust: let group =
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some(&label),
    // rust: layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(
    // rust: &level(t, l - 1),
    // rust: ),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(
    // rust: &self.linear,
    // rust: ),
    // rust: },
    // rust: ],
    // rust: });
    // rust: (level(t, l), group)
    // rust: })
    // rust: .collect(),
}
    // rust: }));
}
    // rust: sides.map(|t| level(&t, 0))
    // rust: })
    // rust: });
    // rust: let depth32 = wgpu::TextureFormat::Depth32Float;
    // rust: let depth_texture = texture(
    // rust: "depthtex0",
    // rust: depth32,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let depth1 = self.depth1.then(|| {
    // rust: let t = texture("depthtex1", depth32, wgpu::TextureUsages::COPY_DST);
    // rust: let view = t.create_view(&Default::default());
    // rust: (t, view)
    // rust: });
    // rust: let depth2 = self.depth2.then(|| {
    // rust: let t = texture("depthtex2", depth32, wgpu::TextureUsages::COPY_DST);
    // rust: let view = t.create_view(&Default::default());
    // rust: (t, view)
    // rust: });
    // rust: let scratch = std::array::from_fn(|i| {
    // rust: (self.copied & 1 << i != 0).then(|| {
                // A copy also read as an image before a dispatch.
    // rust: let image = if self.storage & 1 << i != 0 {
    // rust: wgpu::TextureUsages::STORAGE_BINDING
    // rust: } else {
    // rust: wgpu::TextureUsages::empty()
}
    // rust: texture_sized(
    // rust: &format!("colortex{i} copy"),
    // rust: self.formats[i],
    // rust: wgpu::TextureUsages::COPY_DST | image,
    // rust: 1,
    // rust: sizes[i],
    // rust: )
    // rust: .create_view(&Default::default())
    // rust: })
    // rust: });
    // rust: let sink = texture(
    // rust: "Shader pack sink",
    // rust: SINK,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT,
    // rust: )
    // rust: .create_view(&Default::default());
    // rust: self.targets = Some(Targets {
    // rust: size,
    // rust: sink,
    // rust: sizes,
    // rust: scratch,
    // rust: color,
    // rust: depth: depth_texture.create_view(&Default::default()),
    // rust: depth_texture,
    // rust: depth1,
    // rust: depth2,
    // rust: mips,
    // rust: });
    // rust: self.forget_groups();
}

    // The shadow pass (2.1, passes 2 and 3): the shadow buffers cleared, then the `shadowcomp`
    // programs, each drawing into the "alt" side of what it writes and flipping it after.
    // rust: fn run_shadow(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: terrain: &mut TerrainDraw<'_>,
    // rust: frame: &super::Frame,
    // rust: ) {
        // Opt-in only (`horizon-graphics.txt` shadowCache). Off: always redraw, drop any cache.
    // rust: if !frame.shadow_cache {
    // rust: self.shadow_cache = ShadowCache::default();
    // rust: self.draw_shadow_pass(device, queue, encoder, terrain);
    // rust: return;
}

        // Compute the current frame's cache key before borrowing shadow_targets mutably.
    // rust: let cache_key = self.compute_shadow_cache_key(frame);

        // Entity vertices are interpolated each frame, so their shadows cannot be reused.
    // rust: let has_shadow_entities = self
    // rust: .entities
    // rust: .as_ref()
    // rust: .is_some_and(|entities| entities.geometry.draws.iter().any(|draw| draw.shadow));
        // Custom images are cleared each frame (`pack_images::clear`) before the
        // shadow pass writes them, so a pack with any redraws it too.
    // rust: let cache_hit = !has_shadow_entities
    // rust: && self.images.is_empty()
    // rust: && self.shadow_cache.key == Some(cache_key)
    // rust: && self.shadow_targets.is_some();
    // rust: if cache_hit {
            // The targets still hold this map (and `main`, the A/B side
            // `shadowcomp` left current).
    // rust: return;
}
    // rust: self.draw_shadow_pass(device, queue, encoder, terrain);
    // rust: self.shadow_cache.key = self.shadow_targets.is_some().then_some(cache_key);
}

    // The shadow pass body: terrain, entities, clears, and `shadowcomp`.
    // rust: fn draw_shadow_pass(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: terrain: &mut TerrainDraw<'_>,
    // rust: ) {
    // rust: let Some(t) = &mut self.shadow_targets else {
    // rust: return;
}
    // rust: t.begin_frame();
    // rust: let size = [t.size; 2];
    // rust: self.draw_terrain(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: size,
    // rust: TerrainList::ShadowSolid,
    // rust: terrain,
    // rust: );
    // rust: self.draw_shadow_entities(device, queue, encoder, size);
    // rust: let t = self.shadow_targets.as_mut().expect("shadow pass");
    // rust: t.clear_rest(encoder);
    // rust: t.copy_depth1(encoder);
    // rust: self.draw_terrain(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: size,
    // rust: TerrainList::ShadowTranslucent,
    // rust: terrain,
    // rust: );
    // rust: let mut comp = std::mem::take(&mut self.shadow_comp);
    // rust: for pass in &mut comp {
    // rust: let mut compute = std::mem::take(&mut pass.compute);
    // rust: for c in &mut compute {
    // rust: self.dispatch(device, queue, encoder, c, size);
}
    // rust: pass.compute = compute;
    // rust: if matches!(pass.pipeline, Pipeline::Compute { .. }) {
    // rust: self.dispatch(device, queue, encoder, pass, size);
    // rust: continue;
}
    // rust: let group = self.bind(device, queue, encoder, pass, size);
    // rust: let t = self.shadow_targets.as_ref().expect("shadow pass");
    // rust: let mut attachments: Vec<Option<wgpu::RenderPassColorAttachment>> = Vec::new();
    // rust: for &(location, buffer) in &pass.writes {
    // rust: let l = location as usize;
    // rust: if attachments.len() <= l {
    // rust: attachments.resize(l + 1, None);
}
                // A shadowcomp shader can leave part of its destination untouched.
    // rust: let ops = wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
}
    // rust: attachments[l] = t.color(buffer, true).and_then(|v| attach(v, ops));
}
    // rust: {
    // rust: let mut rp = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some(&pass.name),
    // rust: color_attachments: &attachments,
    // rust: timestamp_writes: self.timing.as_mut().and_then(|t| t.writes(&pass.name)),
    // rust: ..Default::default()
    // rust: });
    // rust: rp.set_pipeline(pass.render());
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: if pass.buffers
    // rust: && let Some(g) = &self.buffers.group
    // rust: {
    // rust: rp.set_bind_group(4, g, &[]);
}
    // rust: rp.draw(0..6, 0..1);
}
    // rust: if let Some(t) = &mut self.shadow_targets {
    // rust: t.main ^= pass.flip;
}
}
    // rust: self.shadow_comp = comp;
}

    // Computes the cache key for the current frame.
compute_shadow_cache_key :: proc(self: ^Self, frame: ^super::Frame) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let shadow = &self.uniforms.shadow;
        // Use the same logic as shadow_camera to compute the light direction and snapped camera.
        // Use the public shadow_light function which returns the normalized light direction.
    // rust: let light = super::pack_uniforms::shadow_light(frame, shadow);
    // rust: let light = light.as_dvec3();
    // rust: let up = if light.z.abs() > 0.99 {
    // rust: DVec3::Y
    // rust: } else {
    // rust: DVec3::Z
}
    // rust: let rotation = DMat4::look_to_rh(DVec3::ZERO, -light, up);
    // rust: let at = rotation.transform_vector3(frame.camera);
    // rust: let step = f64::from(shadow.interval);
    // rust: let snapped_camera = if step > 0.0 {
    // rust: Some((at / step).floor() * step)
    // rust: } else {
    // rust: Some(at)
}

        // Hash the shadow settings that affect the shadow map.
//         use std::hash::{Hash, Hasher};
    // rust: let mut hasher = std::collections::hash_map::DefaultHasher::new();
    // rust: shadow.resolution.hash(&mut hasher);
    // rust: shadow.distance.to_bits().hash(&mut hasher);
    // rust: shadow.render_mul.to_bits().hash(&mut hasher);
    // rust: shadow.interval.to_bits().hash(&mut hasher);
    // rust: shadow.sun_path_rotation.to_bits().hash(&mut hasher);
    // rust: shadow.fov.map(|f| f.to_bits()).hash(&mut hasher);
    // rust: shadow.near.map(f32::to_bits).hash(&mut hasher);
    // rust: shadow.far.map(f32::to_bits).hash(&mut hasher);
    // rust: for hf in &shadow.hardware_filtering {
    // rust: hf.hash(&mut hasher);
}
    // rust: for color in &shadow.colors {
    // rust: format!("{:?}", color.format).hash(&mut hasher);
    // rust: color.clear.hash(&mut hasher);
    // rust: if let Some(cc) = color.clear_color {
    // rust: for c in cc {
    // rust: c.to_bits().hash(&mut hasher);
}
}
    // rust: color.mipmap.hash(&mut hasher);
}
    // rust: let shadow_settings_hash = hasher.finish();
    // rust: let shadow_uniforms_hash = self.shadow_uniforms_hash();

    // rust: ShadowCacheKey {
    // rust: sun_angle: frame.sky.sun_angle,
    // rust: moon_angle: frame.sky.moon_angle,
    // rust: snapped_camera,
    // rust: shadow_settings_hash,
    // rust: shadow_scene_revision: frame.shadow_scene_revision,
    // rust: ticks: frame.ticks,
    // rust: day_time: frame.pack.day_time,
    // rust: shadow_uniforms_hash,
}
}

shadow_uniforms_hash :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
//         use std::hash::{Hash, Hasher};

    // rust: let mut hasher = std::collections::hash_map::DefaultHasher::new();
    // rust: let passes = self
    // rust: .shadow_terrain
    // rust: .iter()
    // rust: .chain(self.shadow_water.iter())
    // rust: .chain(self.shadow_comp.iter())
    // rust: .chain(
    // rust: self.entities
    // rust: .iter()
    // rust: .flat_map(|entities| entities.shadow.iter().flatten()),
    // rust: );
    // rust: for pass in passes {
    // rust: pass.name.hash(&mut hasher);
    // rust: for (index, ty, offset) in &pass.uniforms {
    // rust: index.hash(&mut hasher);
    // rust: ty.hash(&mut hasher);
    // rust: offset.hash(&mut hasher);
    // rust: let Some(value) = index.and_then(|index| self.uniforms.values.get(index)) else {
    // rust: continue;
}
    // rust: match value {
    // rust: pack_uniforms::Value::F(values) => {
    // rust: 0u8.hash(&mut hasher);
    // rust: for value in values {
    // rust: value.to_bits().hash(&mut hasher);
}
}
    // rust: pack_uniforms::Value::I(values) => {
    // rust: 1u8.hash(&mut hasher);
    // rust: values.hash(&mut hasher);
}
}
}
}
    // rust: hasher.finish()
}

    // Runs the pack over the world drawn into `world` (colour) and `world_depth`, then draws
    // the result onto `screen`.
    // rust: pub fn run(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: world: &wgpu::TextureView,
    // rust: world_depth: &wgpu::TextureView,
    // rust: screen: &wgpu::TextureView,
    // rust: frame: &super::Frame,
    // rust: inputs: &PackInputs,
    // rust: size: [u32; 2],
    // rust: window: [u32; 2],
    // rust: pages: &[(u32, wgpu::Buffer)],
    // rust: terrain: &mut TerrainDraw<'_>,
    // rust: ) {
    // rust: self.resize(device, size);
        // A resolution scale leaves the picture smaller (or larger) than the window: the pack's
        // `final` draws it at the picture's size, and one copy takes it to the window (#9291).
    // rust: let final_view = if size != window && self.passes.iter().any(|p| p.group == Group::Final) {
    // rust: if self.final_target.as_ref().is_none_or(|t| t.size != size) {
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Shader pack final"),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: self.screen,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: });
    // rust: self.final_target = Some(FinalTarget {
    // rust: size,
    // rust: view: texture.create_view(&Default::default()),
    // rust: });
}
    // rust: self.final_target.as_ref().map(|t| t.view.clone())
    // rust: } else {
    // rust: self.final_target = None;
    // rust: None
}
    // rust: if let Some((layout, ids, rects)) = &self.block_ids {
            // A page that grew has a new buffer.
    // rust: self.page_groups
    // rust: .retain(|p, (b, _)| pages.iter().any(|(q, c)| q == p && c == b));
    // rust: for (page, buffer) in pages {
    // rust: self.page_groups.entry(*page).or_insert_with(|| {
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack terrain"),
    // rust: layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: ids.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: buffer.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: rects.as_entire_binding(),
    // rust: },
    // rust: ],
    // rust: });
    // rust: (buffer.clone(), group)
    // rust: });
}
}
    // rust: if let Some(t) = &mut self.timing {
    // rust: t.begin(device, queue);
}
    // rust: self.uniforms.center_depth_raw = self
    // rust: .center_depth
    // rust: .get_or_insert_with(|| super::pack_center_depth::CenterDepth::new(device))
    // rust: .collect(device);
    // rust: self.uniforms.update(frame, inputs, size);
        // `smooth` starts on the first frame that knows the camera's biome.
    // rust: self.custom.world_frame(inputs.biome_known);
    // rust: self.uniforms.eval_custom(&mut self.custom);
    // rust: if self.targets.is_none() {
    // rust: return;
}
        // Images start the frame cleared, before the shadow pass writes them.
    // rust: if let Some(dump) = &mut self.dump {
    // rust: dump.read(device);
    // rust: dump.copy(device, encoder, &self.images);
}
    // rust: pack_images::clear(
    // rust: device,
    // rust: encoder,
    // rust: &self.images,
    // rust: self.gpu.clear,
    // rust: &mut self.zeros,
    // rust: );
    // rust: let Some(targets) = &self.targets else { return };
        // Every frame starts on A. A buffer that isn't cleared and ended the last frame on B has B
        // copied back to A, and B keeps what was last written into it: a model that fits Iris 1.11.7's
        // values in probe packs of our own (#9009), not a documented Iris rule. colortex0's A is
        // overwritten by the world below.
    // rust: for b in (1..BUFFERS).filter(|&b| self.main & 1 << b != 0 && self.clears[b].is_none()) {
    // rust: if let Some([a, b_side]) = &targets.color[b] {
    // rust: encoder.copy_texture_to_texture(
    // rust: b_side.texture().as_image_copy(),
    // rust: a.texture().as_image_copy(),
    // rust: a.texture().size(),
    // rust: );
}
}
    // rust: self.main = 0;
    // rust: let main = |m: u16, i: usize| usize::from(m & 1 << i != 0);
    // rust: let view = |m: u16, i: usize, alt: bool| {
    // rust: targets.color[i]
    // rust: .as_ref()
    // rust: .map(|t| &t[main(m, i) ^ usize::from(alt)])
}

    // rust: if !self.shadow_cleared {
    // rust: self.shadow_cleared = true;
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Shader pack shadow stand-in"),
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &self.shadow.0,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(1.0),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
}
        // Three-channel buffers start out with alpha 1 on both sides: a pass writes the side the
        // frame's clear didn't touch.
    // rust: if self.rgb_unset {
    // rust: self.rgb_unset = false;
    // rust: let start = wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
}
    // rust: for b in (0..BUFFERS).filter(|&b| self.rgb & 1 << b != 0) {
    // rust: for alt in [false, true]
    // rust: .into_iter()
    // rust: .take(1 + usize::from(self.doubled & 1 << b != 0))
    // rust: {
    // rust: if let Some(v) = view(self.main, b, alt) {
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Shader pack three-channel start"),
    // rust: color_attachments: &[attach(v, start)],
    // rust: ..Default::default()
    // rust: });
}
}
}
}
    // rust: let clear_op = |b: usize| {
    // rust: let c = self.clears[b].unwrap_or_default();
    // rust: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color {
    // rust: r: c[0].into(),
    // rust: g: c[1].into(),
    // rust: b: c[2].into(),
    // rust: a: c[3].into(),
    // rust: }),
    // rust: store: wgpu::StoreOp::Store,
}
}
        // Overwritten whole: clearing lets a tiled GPU skip loading the old content.
    // rust: let overwrite = wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
    // rust: store: wgpu::StoreOp::Store,
}
        // Attachments share a size and stay within the device's count and byte limits.
    // rust: let limits = device.limits();
    // rust: let max_attachments = (limits.max_color_attachments as usize).min(8);
        // The buffers the blit doesn't clear, and the other texture of every cleared buffer.
    // rust: let alt_clears = (0..BUFFERS)
    // rust: .filter(|&b| self.clears[b].is_some() && self.doubled & 1 << b != 0)
    // rust: .filter(|&b| view(self.main, b, true).is_some())
    // rust: .map(|b| (b, true));
    // rust: let mut by_size: Vec<([u32; 2], Vec<(usize, bool)>)> = Vec::new();
    // rust: for (b, alt) in self
    // rust: .other_clears
    // rust: .iter()
    // rust: .map(|&b| (b, false))
    // rust: .chain(alt_clears)
    // rust: {
    // rust: let at = targets.sizes[b];
    // rust: match by_size.iter_mut().find(|(s, buffers)| {
    // rust: let bytes = buffers
    // rust: .iter()
    // rust: .fold(0, |bytes, &(b, _)| attachment_bytes(bytes, self.formats[b]));
    // rust: *s == at
    // rust: && buffers.len() < max_attachments
    // rust: && attachment_bytes(bytes, self.formats[b])
    // rust: <= limits.max_color_attachment_bytes_per_sample
    // rust: }) {
    // rust: Some((_, l)) => l.push((b, alt)),
    // rust: None => by_size.push((at, vec![(b, alt)])),
}
}
    // rust: for (_, chunk) in &by_size {
    // rust: let attachments: Vec<_> = chunk
    // rust: .iter()
    // rust: .map(|&(b, alt)| attach(view(self.main, b, alt).expect("used buffer"), clear_op(b)))
    // rust: .collect();
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Shader pack clear"),
    // rust: color_attachments: &attachments,
    // rust: timestamp_writes: self.timing.as_mut().and_then(|t| t.writes("clear")),
    // rust: ..Default::default()
    // rust: });
}

        // The world into colortex0 and depthtex0, flipped to GL's rows, and the clears.
    // rust: if let Some(blit) = &self.blit
    // rust: && self
    // rust: .blit_group
    // rust: .as_ref()
    // rust: .is_none_or(|g| g.0[0] != *world || g.0[1] != *world_depth)
    // rust: {
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack world"),
    // rust: layout: &blit.1,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(world),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(world_depth),
    // rust: },
    // rust: ],
    // rust: });
    // rust: self.blit_group = Some(([world.clone(), world_depth.clone()], group));
}
    // rust: if let Some(blit) = &self.blit {
            // The blit leaves a three-channel colortex0's alpha at the 1 it starts with.
    // rust: let world_ops = if self.rgb & 1 != 0 {
    // rust: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
}
    // rust: } else {
    // rust: overwrite
}
    // rust: let mut attachments = vec![if holds_floats(self.formats[0]) {
    // rust: attach(view(self.main, 0, false).expect("colortex0"), world_ops)
    // rust: } else {
    // rust: None
    // rust: }];
    // rust: for &b in &self.blit_clears {
    // rust: attachments.push(attach(
    // rust: view(self.main, b, false).expect("used buffer"),
    // rust: clear_op(b),
    // rust: ));
}
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Shader pack world"),
    // rust: color_attachments: &attachments,
    // rust: timestamp_writes: self.timing.as_mut().and_then(|t| t.writes("world")),
    // rust: depth_stencil_attachment: self.blit_depth.then_some(
    // rust: wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &targets.depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(1.0),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: },
    // rust: ),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&blit.0);
    // rust: pass.set_bind_group(0, self.blit_group.as_ref().map(|g| &g.1), &[]);
    // rust: pass.draw(0..3, 0..1);
}

        // The world and the clears just rewrote the buffers' first levels.
    // rust: self.mips_valid = 0;
    // rust: let mut passes = std::mem::take(&mut self.passes);
    // rust: let mut seen = (false, false);
    // rust: let mut shown = false;
        // A water-only pack still needs the opaque phase to populate requested snapshots.
    // rust: let mut terrain_drawn = self.terrain.is_none()
    // rust: && self.terrain_cutout.is_none()
    // rust: && self.sky.is_none()
    // rust: && !self.entities.as_ref().is_some_and(Entities::drawn)
    // rust: && self.clouds.is_none()
    // rust: && self.lines.is_none()
    // rust: && self.hand.is_none()
    // rust: && !self.depth1
    // rust: && !self.depth2;
    // rust: let late_entities = self.entities.as_ref().is_some_and(|e| {
    // rust: e.passes
    // rust: .iter()
    // rust: .zip(e.late)
    // rust: .any(|(p, late)| p.is_some() && late)
    // rust: });
    // rust: let mut water_drawn = self.water.is_none() && self.weather.is_none() && !late_entities;
    // rust: let mut shadow_drawn = false;
    // rust: for pass in &mut passes {
    // rust: if pass.group == Group::Setup && !self.setup_pending {
    // rust: continue;
}
    // rust: let early = matches!(pass.group, Group::Setup | Group::Begin);
    // rust: if !early && !shadow_drawn {
    // rust: self.run_shadow(device, queue, encoder, terrain, frame);
    // rust: shadow_drawn = true;
}
    // rust: if !terrain_drawn && !early && pass.group != Group::Prepare {
    // rust: terrain_drawn = true;
    // rust: self.draw_opaque(device, queue, encoder, size, frame, terrain);
}
    // rust: if !water_drawn && matches!(pass.group, Group::Composite | Group::Final) {
    // rust: water_drawn = true;
    // rust: self.draw_translucent(device, queue, encoder, size, terrain);
}
    // rust: if pass.group == Group::Deferred && !seen.0 {
    // rust: seen.0 = true;
    // rust: self.main ^= self.deferred_pre;
}
    // rust: if pass.group == Group::Composite && !seen.1 {
    // rust: seen.1 = true;
    // rust: self.main ^= self.composite_pre;
}
    // rust: let mut compute = std::mem::take(&mut pass.compute);
    // rust: for c in &mut compute {
    // rust: self.dispatch(device, queue, encoder, c, size);
}
    // rust: pass.compute = compute;
    // rust: if matches!(pass.pipeline, Pipeline::Compute { .. }) {
    // rust: self.dispatch(device, queue, encoder, pass, size);
    // rust: continue;
}
    // rust: let stale = pass.mipmaps & self.mipped & !self.mips_valid;
    // rust: for b in (0..BUFFERS).filter(|b| stale & 1 << b != 0) {
    // rust: self.mipmap(encoder, b);
}
    // rust: self.mips_valid |= stale;
    // rust: let final_pass = pass.group == Group::Final;
            // A pass writing buffers of a size of their own draws at that size (they share it).
            // `final` draws the picture at the world's size; a copy takes it to the window.
    // rust: let out = match pass.writes.first() {
    // rust: Some(&(_, b)) => self.targets.as_ref().map_or(size, |t| t.sizes[b]),
    // rust: None => size,
}
    // rust: let group = self.bind(device, queue, encoder, pass, out);
    // rust: let targets = self.targets.as_ref().expect("resized");
    // rust: let view = |i: usize| {
    // rust: targets.color[i]
    // rust: .as_ref()
    // rust: .map(|t| &t[usize::from(self.main & 1 << i == 0)])
}
    // rust: let mut attachments: Vec<Option<wgpu::RenderPassColorAttachment>> = Vec::new();
            // Vertex coverage and fragment discard can leave alternate pixels untouched.
            // The unused sink can still skip loading its old contents.
    // rust: let ops = if !pass.sink || pass.viewport.is_some() {
    // rust: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
}
    // rust: } else {
    // rust: overwrite
}
    // rust: if final_pass {
    // rust: attachments.push(attach(final_view.as_ref().unwrap_or(screen), overwrite));
    // rust: shown = true;
    // rust: } else if pass.sink {
    // rust: attachments.push(attach(&targets.sink, ops));
    // rust: } else {
    // rust: for &(location, buffer) in &pass.writes {
    // rust: let l = location as usize;
    // rust: if attachments.len() <= l {
    // rust: attachments.resize(l + 1, None);
}
    // rust: attachments[l] = view(buffer).and_then(|v| attach(v, ops));
}
}
    // rust: {
    // rust: let mut rp = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some(&pass.name),
    // rust: color_attachments: &attachments,
    // rust: timestamp_writes: self.timing.as_mut().and_then(|t| t.writes(&pass.name)),
    // rust: ..Default::default()
    // rust: });
    // rust: rp.set_pipeline(pass.render());
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: if pass.buffers
    // rust: && let Some(g) = &self.buffers.group
    // rust: {
    // rust: rp.set_bind_group(4, g, &[]);
}
    // rust: if let Some(scale) = pass.viewport {
    // rust: let [x, y, w, h] = viewport(out, scale);
    // rust: rp.set_viewport(x, y, w, h, 0.0, 1.0);
}
    // rust: rp.draw(0..6, 0..1);
}
    // rust: self.main ^= pass.flip;
    // rust: self.mips_valid &= !pass.written;
}
    // rust: self.passes = passes;
    // rust: self.setup_pending = false;
    // rust: if !shadow_drawn {
    // rust: self.run_shadow(device, queue, encoder, terrain, frame);
}
    // rust: if !terrain_drawn {
    // rust: self.draw_opaque(device, queue, encoder, size, frame, terrain);
}
    // rust: if !water_drawn {
    // rust: self.draw_translucent(device, queue, encoder, size, terrain);
}
    // rust: let targets = self.targets.as_ref().expect("resized");
        // depthtex0 as the frame leaves it, for next frames' `centerDepthSmooth`.
    // rust: if let Some(center) = &mut self.center_depth {
    // rust: center.copy(device, encoder, &targets.depth_texture);
}
    // rust: let view = |m: u16, i: usize, alt: bool| {
    // rust: targets.color[i]
    // rust: .as_ref()
    // rust: .map(|t| &t[main(m, i) ^ usize::from(alt)])
}
        // Without `final`, colortex0 holds floats (`new` refuses an integer one).
    // rust: if !shown {
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack colortex0"),
    // rust: layout: &self.copy.1,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(
    // rust: view(self.main, 0, false).expect("colortex0"),
    // rust: ),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&self.linear),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let mut rp = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Shader pack colortex0"),
    // rust: color_attachments: &[attach(screen, overwrite)],
    // rust: ..Default::default()
    // rust: });
    // rust: rp.set_pipeline(&self.copy.0);
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: rp.draw(0..3, 0..1);
    // rust: } else if let Some(picture) = &final_view {
            // The picture at the world's size onto the window: one upscale, smoothly.
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack final"),
    // rust: layout: &self.upscale.1,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(picture),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&self.linear),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let mut rp = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Shader pack final"),
    // rust: color_attachments: &[attach(screen, overwrite)],
    // rust: timestamp_writes: self.timing.as_mut().and_then(|t| t.writes("final copy")),
    // rust: ..Default::default()
    // rust: });
    // rust: rp.set_pipeline(&self.upscale.0);
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: rp.draw(0..3, 0..1);
}
}
}

    // rust: mod snorm_tests;

    // rust: mod depth_test;

    // rust: mod terrain_parts_tests;

    // rust: mod tests {
//     use super::*;
//     use wgpu::TextureFormat as T;

shadow_cache_key_tracks_world_and_time_changes :: proc() {
}
    // rust: let key = ShadowCacheKey {
    // rust: sun_angle: 0.0,
    // rust: moon_angle: 180.0,
    // rust: snapped_camera: Some(DVec3::ZERO),
    // rust: shadow_settings_hash: 1,
    // rust: shadow_scene_revision: (2, 3),
    // rust: ticks: 4,
    // rust: day_time: 5,
    // rust: shadow_uniforms_hash: 6,
}

    // rust: assert_ne!(
    // rust: key,
    // rust: ShadowCacheKey {
    // rust: shadow_scene_revision: (8, 3),
    // rust: ..key
}
    // rust: );
    // rust: assert_ne!(key, ShadowCacheKey { day_time: 9, ..key });
    // rust: assert_ne!(
    // rust: key,
    // rust: ShadowCacheKey {
    // rust: shadow_uniforms_hash: 10,
    // rust: ..key
}
    // rust: );
}

    // Two textures with a sampler each become two textures sharing one sampler variable.
samplers_of_a_kind_share_one_variable :: proc() {
}
    // rust: let mut module = naga::front::wgsl::parse_str(
    // rust: "@group(0) @binding(1) var a: texture_2d<f32>;\n\
    // rust: @group(0) @binding(2) var sa: sampler;\n\
    // rust: @group(0) @binding(3) var b: texture_2d<f32>;\n\
    // rust: @group(0) @binding(4) var sb: sampler;\n\
    // rust: @fragment fn main() -> @location(0) vec4<f32> {\n\
    // rust: return textureSample(a, sa, vec2(0.5)) + textureSample(b, sb, vec2(0.5));\n}\n",
    // rust: )
    // rust: .unwrap();
    // rust: share_samplers(&mut module, &HashMap::from([(2, 2), (4, 2)]));
    // rust: let info = naga::valid::Validator::new(Default::default(), Default::default())
    // rust: .validate(&module)
    // rust: .unwrap();
    // rust: let used: Vec<u32> = module
    // rust: .global_variables
    // rust: .iter()
    // rust: .filter(|(h, _)| !info.get_entry_point(0)[*h].is_empty())
    // rust: .filter_map(|(_, g)| g.binding.as_ref().map(|b| b.binding))
    // rust: .collect();
    // rust: assert_eq!(used, [1, 2, 3]);
}

    // #3525: naga's SPIR-V writer panicked on Photon's gbuffers programs as the pipeline was
    // made. Such a panic skips the pass, as a validation error does, and the device goes on.
a_shader_compiler_panic_skips_the_pass :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let Ok((device, _queue)) = pollster::block_on(adapter.request_device(&Default::default()))
    // rust: else {
    // rust: return;
}
    // rust: let failed = checked(&device, || -> wgpu::Buffer {
    // rust: panic!("internal error: entered unreachable code: Expression [89] is not cached!")
    // rust: });
    // rust: let error = failed.expect_err("the panic comes back as an error");
    // rust: assert!(error.contains("Expression [89] is not cached!"), "{error}");
    // rust: let buffer = |usage| {
    // rust: checked(&device, || {
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 16,
    // rust: usage,
    // rust: mapped_at_creation: false,
    // rust: })
    // rust: })
}
        // The device still makes things, and its errors still come back.
    // rust: assert!(buffer(wgpu::BufferUsages::UNIFORM).is_ok());
    // rust: assert!(buffer(wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::MAP_WRITE).is_err());
}

    // `texture.composite.colortex0` stands in for buffer 0 in composite programs until one of
    // them flips that buffer; later ones, and `final`, read the buffer (Super Duper Vanilla,
    // Bliss, SEUS PTGI HRR). Another stage's flips don't release it.
a_custom_texture_over_a_buffer_ends_when_its_stage_flips_it :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let Ok((device, _queue)) = pollster::block_on(adapter.request_device(&Default::default()))
    // rust: else {
    // rust: return;
}
    // rust: let textures = [pack_textures::PackTexture {
    // rust: stage: "composite".into(),
    // rust: name: "colortex0".into(),
    // rust: dimension: wgpu::TextureViewDimension::D2,
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: blur: false,
    // rust: clamp: false,
    // rust: png: false,
    // rust: image: pack_textures::Image::Atlas,
    // rust: }];
    // rust: let interface = horizon_shaders::Interface {
    // rust: uniform_size: 48,
    // rust: initial_values: vec![0; 48],
    // rust: uniforms: Vec::new(),
    // rust: samplers: vec![horizon_shaders::Sampler {
    // rust: name: "colortex0".into(),
    // rust: ty: "sampler2D".into(),
    // rust: binding: 1,
    // rust: }],
    // rust: outputs: vec![0],
    // rust: draw: false,
    // rust: images: Vec::new(),
    // rust: buffers: Vec::new(),
}
    // rust: let buffers = pack_images::Buffers::new(
    // rust: &device,
    // rust: Default::default(),
    // rust: Default::default(),
    // rust: wgpu::ShaderStages::FRAGMENT,
    // rust: );
    // rust: let stand_ins = std::cell::RefCell::new(Vec::new());
    // rust: let pack = Resources {
    // rust: textures: &textures,
    // rust: images: &[],
    // rust: left_out: &[],
    // rust: buffers: &buffers,
    // rust: indices: None,
    // rust: gpu: Gpu::of(&adapter, device.features()),
    // rust: storable: 0,
    // rust: rgb: 0,
    // rust: packed: [None; BUFFERS],
    // rust: released: std::cell::Cell::new(("", 0)),
    // rust: stand_ins: &stand_ins,
    // rust: shadow_linear: 0,
}
    // rust: let reads = |group: Group| {
    // rust: let (_, samplers, ..) = bindings(
    // rust: device.features(),
    // rust: &interface,
    // rust: "composite",
    // rust: group,
    // rust: &[1],
    // rust: None,
    // rust: &[T::Rgba8Unorm; BUFFERS],
    // rust: None,
    // rust: &mut Vec::new(),
    // rust: &pack,
    // rust: )
    // rust: .expect("the pass is kept");
    // rust: samplers[0].source
}
    // rust: assert!(reads(Group::Composite) == Source::Atlas);
    // rust: pack.released.set(("deferred", 1));
    // rust: assert!(reads(Group::Composite) == Source::Atlas);
    // rust: pack.released.set(("composite", 1));
    // rust: assert!(reads(Group::Composite) == Source::Color(0));
    // rust: assert!(reads(Group::Final) == Source::Color(0));
}

    // Iris 1.11.7 (a probe pack of ours, #9064) didn't bind a PNG under
    // `texture.<stage>.<name>` when `name` was a name of the pack's own, no sampler of the
    // game's; a raw texture there, a PNG over `gaux2` or `noisetex`, and a `customTexture` PNG
    // were bound.
a_png_under_a_name_of_its_own_is_not_bound :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let Ok((device, _queue)) = pollster::block_on(adapter.request_device(&Default::default()))
    // rust: else {
    // rust: return;
}
    // rust: let texture = |stage: &str, name: &str, png: bool| pack_textures::PackTexture {
    // rust: stage: stage.into(),
    // rust: name: name.into(),
    // rust: dimension: wgpu::TextureViewDimension::D2,
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: blur: !png,
    // rust: clamp: !png,
    // rust: png,
    // rust: image: pack_textures::Image::Atlas,
}
    // rust: let textures = [
    // rust: texture("composite", "tp", true),
    // rust: texture("composite", "tr", false),
    // rust: texture("composite", "gaux2", true),
    // rust: texture("composite", "noisetex", true),
    // rust: texture(horizon_shaders::EVERY_STAGE, "cp", true),
    // rust: ];
    // rust: let names = ["tp", "tr", "gaux2", "noisetex", "cp"];
    // rust: let interface = horizon_shaders::Interface {
    // rust: uniform_size: 48,
    // rust: uniforms: Vec::new(),
    // rust: samplers: names
    // rust: .iter()
    // rust: .zip(1..)
    // rust: .map(|(name, k)| horizon_shaders::Sampler {
    // rust: name: (*name).into(),
    // rust: ty: "sampler2D".into(),
    // rust: binding: 2 * k - 1,
    // rust: })
    // rust: .collect(),
    // rust: outputs: vec![0],
    // rust: draw: false,
    // rust: images: Vec::new(),
    // rust: buffers: Vec::new(),
    // rust: initial_values: vec![0; 48],
}
    // rust: let buffers = pack_images::Buffers::new(
    // rust: &device,
    // rust: Default::default(),
    // rust: Default::default(),
    // rust: wgpu::ShaderStages::FRAGMENT,
    // rust: );
    // rust: let stand_ins = std::cell::RefCell::new(Vec::new());
    // rust: let pack = Resources {
    // rust: textures: &textures,
    // rust: images: &[],
    // rust: left_out: &[],
    // rust: buffers: &buffers,
    // rust: indices: None,
    // rust: gpu: Gpu::of(&adapter, device.features()),
    // rust: storable: 0,
    // rust: rgb: 0,
    // rust: released: std::cell::Cell::new(("", 0)),
    // rust: stand_ins: &stand_ins,
    // rust: shadow_linear: 0,
    // rust: packed: [None; BUFFERS],
}
    // rust: let (_, samplers, ..) = bindings(
    // rust: device.features(),
    // rust: &interface,
    // rust: "final",
    // rust: Group::Final,
    // rust: &[0],
    // rust: None,
    // rust: &[T::Rgba8Unorm; BUFFERS],
    // rust: None,
    // rust: &mut Vec::new(),
    // rust: &pack,
    // rust: )
    // rust: .expect("the pass is kept");
    // rust: let read: Vec<Source> = samplers.iter().map(|b| b.source).collect();
    // rust: assert!(
    // rust: read == [
    // rust: Source::Dummy,
    // rust: Source::Atlas,
    // rust: Source::Atlas,
    // rust: Source::Atlas,
    // rust: Source::Atlas
    // rust: ]
    // rust: );
}

    // Iris 1.11.7 runs a program whose image no `image.*` gives, and its loads read zero
    // (observed with a probe pack). Its pass is kept, the image bound to a stand-in of its
    // declared format, zero again before each pass even after one stored into it.
an_image_without_an_entry_reads_zero :: proc() {
}
//         use wgpu::TextureViewDimension as D;
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let Ok((device, queue)) = pollster::block_on(adapter.request_device(&Default::default()))
    // rust: else {
    // rust: return;
}
    // rust: let image = |name: &str, ty: &str, format: &str, binding| horizon_shaders::Image {
    // rust: name: name.into(),
    // rust: ty: ty.into(),
    // rust: format: format.into(),
    // rust: access: String::new(),
    // rust: binding,
    // rust: before: None,
}
    // rust: let interface = horizon_shaders::Interface {
    // rust: uniform_size: 48,
    // rust: initial_values: vec![0; 48],
    // rust: uniforms: Vec::new(),
    // rust: samplers: Vec::new(),
    // rust: outputs: vec![0],
    // rust: draw: false,
    // rust: images: vec![
    // rust: image("mask", "uimage3D", "r32ui", 1),
    // rust: image("other", "uimage3D", "r32ui", 2),
    // rust: image("flat", "image2D", "rgba8", 3),
    // rust: ],
    // rust: buffers: Vec::new(),
}
    // rust: let buffers = pack_images::Buffers::new(
    // rust: &device,
    // rust: Default::default(),
    // rust: Default::default(),
    // rust: wgpu::ShaderStages::FRAGMENT,
    // rust: );
    // rust: let stand_ins = std::cell::RefCell::new(Vec::new());
    // rust: let pack = Resources {
    // rust: textures: &[],
    // rust: images: &[],
    // rust: left_out: &[],
    // rust: buffers: &buffers,
    // rust: indices: None,
    // rust: gpu: Gpu::of(&adapter, device.features()),
    // rust: storable: 0,
    // rust: rgb: 0,
    // rust: packed: [None; BUFFERS],
    // rust: released: std::cell::Cell::new(("", 0)),
    // rust: stand_ins: &stand_ins,
    // rust: shadow_linear: 0,
}
    // rust: let mut notes = Vec::new();
    // rust: let (.., images) = bindings(
    // rust: device.features(),
    // rust: &interface,
    // rust: "composite",
    // rust: Group::Composite,
    // rust: &[0],
    // rust: None,
    // rust: &[T::Rgba8Unorm; BUFFERS],
    // rust: None,
    // rust: &mut notes,
    // rust: &pack,
    // rust: )
    // rust: .expect("the pass is kept");
    // rust: assert!(
    // rust: images
    // rust: == [
    // rust: (1, Image::StandIn(T::R32Uint, D::D3)),
    // rust: (2, Image::StandIn(T::R32Uint, D::D3)),
    // rust: (3, Image::StandIn(T::Rgba8Unorm, D::D2)),
    // rust: ]
    // rust: );
    // rust: assert_eq!(notes.len(), 3, "{notes:?}");
        // One stand-in for each format and dimension.
    // rust: let made = pack_images::stand_ins(&device, stand_ins.take());
    // rust: assert_eq!(made.len(), 2);
    // rust: let mask = pack_images::stand_in(&made, T::R32Uint, D::D3).expect("made");
    // rust: let texture = mask.view.texture();
    // rust: queue.write_texture(
    // rust: texture.as_image_copy(),
    // rust: &7u32.to_le_bytes(),
    // rust: wgpu::TexelCopyBufferLayout::default(),
    // rust: texture.size(),
    // rust: );
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 4,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: mask.clear(&mut encoder);
    // rust: encoder.copy_texture_to_buffer(
    // rust: texture.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout::default(),
    // rust: },
    // rust: texture.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: assert_eq!(&read.slice(..).get_mapped_range().unwrap()[..], &[0; 4]);
}

    // `scale.composite2 = 0.25 0.5 0.25` on a 1280×720 picture: Iris 1.11.7 draws x 640..960
    // and GL y 180..360 (a probe pack of our own). Rows are GL's here, so that is rows 180..360.
a_scaled_pass_draws_its_part_from_gl_s_corner :: proc() {
}
    // rust: assert_eq!(
    // rust: viewport([1280, 720], [0.25, 0.5, 0.25]),
    // rust: [640.0, 180.0, 320.0, 180.0]
    // rust: );
    // rust: assert_eq!(
    // rust: viewport([1280, 720], [0.5, 0.0, 0.0]),
    // rust: [0.0, 0.0, 640.0, 360.0]
    // rust: );
        // Whole pixels, at least one, and never past the buffer's edge.
    // rust: assert_eq!(viewport([5, 3], [0.5, 0.0, 0.0]), [0.0, 0.0, 2.0, 1.0]);
    // rust: assert_eq!(viewport([4, 4], [0.01, 0.0, 0.0]), [0.0, 0.0, 1.0, 1.0]);
    // rust: assert_eq!(
    // rust: viewport([100, 100], [1.0, 0.5, 0.75]),
    // rust: [50.0, 75.0, 50.0, 25.0]
    // rust: );
}

    // `blend.<program>` of a composite program blends its output onto what the buffer's side
    // holds (Iris 1.11.7, probed: 0.25 over 0.75 with SRC_ALPHA ONE_MINUS_SRC_ALPHA ONE ZERO and
    // a source alpha of 0.25 reads 0.625).
a_composite_program_blends_onto_its_buffer :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
        // A pass's pipeline layout has six bind group slots.
    // rust: let desc = wgpu::DeviceDescriptor {
    // rust: required_limits: adapter.limits(),
    // rust: ..Default::default()
}
    // rust: let Ok((device, queue)) = pollster::block_on(adapter.request_device(&desc)) else {
    // rust: return;
}
    // rust: let dir = std::env::temp_dir().join(format!("hz-composite-blend-{}", std::process::id()));
    // rust: let shaders = dir.join("shaders");
    // rust: std::fs::create_dir_all(&shaders).unwrap();
    // rust: let file = |name: &str, text: &str| std::fs::write(shaders.join(name), text).unwrap();
    // rust: file(
    // rust: "composite.vsh",
    // rust: "#version 120\nvoid main() { gl_Position = ftransform(); }\n",
    // rust: );
    // rust: file(
    // rust: "composite.fsh",
    // rust: "#version 120\n/* DRAWBUFFERS:3 */\n\
    // rust: void main() { gl_FragData[0] = vec4(0.25, 0.25, 1.0, 0.25); }\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::open(&dir).unwrap();
    // rust: let properties = horizon_shaders::Properties::parse(
    // rust: "blend.composite = SRC_ALPHA ONE_MINUS_SRC_ALPHA ONE ZERO\n",
    // rust: &horizon_shaders::Macros::default(),
    // rust: );
    // rust: let mut post = horizon_shaders::load_post(
    // rust: &pack,
    // rust: "",
    // rust: &properties,
    // rust: &horizon_shaders::Macros::standard(),
    // rust: &Default::default(),
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
    // rust: let program = post.programs.remove(0);
    // rust: let buffers = pack_images::Buffers::new(
    // rust: &device,
    // rust: Default::default(),
    // rust: Default::default(),
    // rust: wgpu::ShaderStages::FRAGMENT,
    // rust: );
    // rust: let stand_ins = std::cell::RefCell::new(Vec::new());
    // rust: let pack = Resources {
    // rust: textures: &[],
    // rust: images: &[],
    // rust: left_out: &[],
    // rust: buffers: &buffers,
    // rust: indices: None,
    // rust: gpu: Gpu::of(&adapter, device.features()),
    // rust: storable: 0,
    // rust: rgb: 0,
    // rust: packed: [None; BUFFERS],
    // rust: released: std::cell::Cell::new(("", 0)),
    // rust: stand_ins: &stand_ins,
    // rust: shadow_linear: 0,
}
    // rust: let draws = DrawUniforms::new(&device);
    // rust: let mut notes = Vec::new();
    // rust: let pass = build_pass(
    // rust: &device,
    // rust: program,
    // rust: &[T::Rgba8Unorm; BUFFERS],
    // rust: None,
    // rust: T::Rgba8Unorm,
    // rust: &mut notes,
    // rust: None,
    // rust: &[],
    // rust: &draws.layout,
    // rust: &pack,
    // rust: )
    // rust: .unwrap_or_else(|| panic!("the pass builds: {notes:?}"));
        // colortex3 holds (0.75, 0.5, 0.25, 0.5) before the pass.
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 64,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: T::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = texture.create_view(&Default::default());
    // rust: let head = [64.0f32, 1.0, 1.0 / 64.0, 1.0];
    // rust: queue.write_buffer(&pass.ubo, 0, bytemuck::cast_slice(&head));
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout: &pass.layout,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: pass.ubo.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let before = wgpu::Color {
    // rust: r: 0.75,
    // rust: g: 0.5,
    // rust: b: 0.25,
    // rust: a: 0.5,
}
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: color_attachments: &[attach(
    // rust: &view,
    // rust: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(before),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: )],
    // rust: ..Default::default()
    // rust: });
    // rust: {
            // Loaded, as `PackPost::render` attaches a buffer a composite pass writes.
    // rust: let load = wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
}
    // rust: let mut rp = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: color_attachments: &[attach(&view, load)],
    // rust: ..Default::default()
    // rust: });
    // rust: rp.set_pipeline(pass.render());
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: rp.draw(0..6, 0..1);
}
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 256,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_texture_to_buffer(
    // rust: texture.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout::default(),
    // rust: },
    // rust: texture.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let texel: Vec<u8> = read.slice(..).get_mapped_range().unwrap()[..4].to_vec();
        // rgb = 0.25 × src + 0.75 × dst, alpha = the source's.
    // rust: let expected = [0.625, 0.4375, 0.4375, 0.25].map(|v: f32| v * 255.0);
    // rust: for (got, want) in texel.iter().zip(expected) {
    // rust: assert!(
    // rust: (f32::from(*got) - want).abs() <= 1.0,
    // rust: "{texel:?} vs {expected:?}"
    // rust: );
}
}

pack_formats_map_to_renderable_ones :: proc() {
}
    // rust: let f = |name| texture_format(Format::parse(name).unwrap(), wgpu::Features::empty());
    // rust: assert_eq!(f("RGBA"), T::Rgba8Unorm);
    // rust: assert_eq!(f("RGB8"), T::Rgba8Unorm, "no three-channel formats in wgpu");
    // rust: assert_eq!(f("RG16F"), T::Rg16Float);
    // rust: assert_eq!(f("R32F"), T::R32Float);
    // rust: assert_eq!(f("RGB10_A2"), T::Rgb10a2Unorm);
    // rust: assert_eq!(f("R32UI"), T::R32Uint);
    // rust: assert_eq!(f("RGBA16"), T::Rgba16Float, "16-bit norm needs a feature");
    // rust: assert_eq!(f("RGBA8_SNORM"), T::Rgba16Float, "snorm is not renderable");
    // rust: assert_eq!(f("R11F_G11F_B10F"), T::Rgba16Float);
    // rust: let all = wgpu::Features::TEXTURE_FORMAT_16BIT_NORM
    // rust: | wgpu::Features::TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES
    // rust: | wgpu::Features::RG11B10UFLOAT_RENDERABLE;
    // rust: let g = |name| texture_format(Format::parse(name).unwrap(), all);
    // rust: assert_eq!(g("RGBA16"), T::Rgba16Unorm);
    // rust: assert_eq!(g("R11F_G11F_B10F"), T::Rg11b10Ufloat);
}

float_targets_fall_back_when_not_renderable :: proc() {
}
    // rust: let all = |_| true;
    // rust: assert_eq!(renderable_float(T::Rgba32Float, all), T::Rgba32Float);
        // OpenGL without GL_EXT_color_buffer_float: only half floats render.
    // rust: let half_only = |f: T| matches!(f, T::R16Float | T::Rg16Float | T::Rgba16Float);
    // rust: assert_eq!(renderable_float(T::Rgba32Float, half_only), T::Rgba16Float);
    // rust: assert_eq!(renderable_float(T::Rg32Float, half_only), T::Rg16Float);
    // rust: assert_eq!(renderable_float(T::R32Float, half_only), T::R16Float);
    // rust: assert_eq!(renderable_float(T::Rgba16Float, half_only), T::Rgba16Float);
        // Neither renders: the 8-bit last resort.
    // rust: assert_eq!(renderable_float(T::Rgba32Float, |_| false), T::Rgba8Unorm);
    // rust: assert_eq!(renderable_float(T::Rg16Float, |_| false), T::Rgba8Unorm);
        // Other formats are never replaced.
    // rust: assert_eq!(renderable_float(T::Rgba8Uint, |_| false), T::Rgba8Uint);
    // rust: assert_eq!(
    // rust: renderable_float(T::Rgb10a2Unorm, |_| false),
    // rust: T::Rgb10a2Unorm
    // rust: );
}

samplers_read_custom_textures_of_their_type :: proc() {
}
//         use wgpu::TextureSampleType as T;
    // rust: let float = T::Float { filterable: true };
    // rust: assert!(fits("sampler2D", float));
    // rust: assert!(fits("sampler3D", float));
    // rust: assert!(fits("isampler2D", T::Sint));
    // rust: assert!(fits("usampler1D", T::Uint));
    // rust: assert!(!fits("sampler2D", T::Uint));
    // rust: assert!(!fits("isampler2D", float));
    // rust: assert!(!fits("sampler2DShadow", float));
}

sampler_names :: proc() {
}
    // rust: let main = |n| source(n, false, false, false);
    // rust: assert!(main("gaux1") == Source::Color(4));
    // rust: assert!(main("gdepthtex") == Source::Depth);
    // rust: assert!(main("depthtex1") == Source::Depth1);
    // rust: assert!(main("depthtex2") == Source::Depth2);
    // rust: assert!(main("normals") == Source::Normals);
    // rust: assert!(main("specular") == Source::Specular);
    // rust: assert!(main("noisetex") == Source::Noise);
        // Without the shadow pass, the shadow buffers are stand-ins.
    // rust: assert!(main("shadowcolor0") == Source::Dummy);
    // rust: assert!(main("shadowtex0") == Source::Dummy);
        // With it: shadowcolor n is buffer n of the shadow programs, `shadow` is shadowtex1
        // beside `watershadow` (6.3), and colortex is not theirs.
    // rust: assert!(source("shadowcolor", false, true, false) == Source::ShadowColor(0));
    // rust: assert!(source("shadowcolor1", true, true, false) == Source::Color(1));
    // rust: assert!(source("colortex1", true, true, false) == Source::Dummy);
    // rust: assert!(source("shadow", false, true, false) == Source::ShadowDepth(0, false));
    // rust: assert!(source("shadow", false, true, true) == Source::ShadowDepth(1, false));
    // rust: assert!(source("watershadow", false, true, true) == Source::ShadowDepth(0, false));
    // rust: assert!(source("shadowtex1HW", false, true, false) == Source::ShadowDepth(1, true));
}
}

    // rust: mod destination_tests;

    // rust: mod material_tests;

    // rust: mod rgb_alpha_tests;

    // rust: mod packed_tests;

    // rust: mod trinary_tests;

    // rust: mod const_offset_tests;

    // rust: mod integer_colortex0_tests;

    // rust: mod atlas_mip_tests;

    // rust: mod wrong_type_uniform_tests;

    // rust: mod atlas_name_post_tests;

    // rust: mod unknown_sampler_terrain_tests;

    // rust: mod mipmap_box_tests;

    // rust: mod colortex_mip_blend_tests;
