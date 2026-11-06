//! Transpiled from Horizon Rust crate
package horizon_shaders_post

import "core:fmt"
import "core:mem"
import "core:math"

// The post-processing programs of one dimension, ready for the renderer: `prepare`, `deferred`,
// `composite` and `final` with their numbered variants, in the order they run (spec 2.1), each
// preprocessed and translated, with the buffers it writes and the flips that follow it, and the
// buffer settings their files carry (6.1).
//
// Decisions (impl-plan.md):
// - OQ-12: a dimension's folder (`world0`, `world-1`, `world1`) replaces the base folder for that
//   dimension when it exists; every stage file is read from it.
// - OQ-29: a program with a geometry stage is reported and treated as missing.
// - A program that fails to translate is reported and treated as missing (2.5).
// - Terrain draws with the first program of its fallback chain that loads (2.3).

// use std::collections::BTreeSet;

// use crate::config::{self, Config};
// use crate::custom::Custom;
// use crate::{
    // rust: ComputeProgram, eval_condition, preprocess, translate_composite, translate_compute,
    // rust: translate_gbuffers, translate_shadow,
}
// use crate::{GbuffersInputs, Macros, Pack, Preprocessed, Program, Properties, Target};

// Which group of 2.1 a program belongs to.
Group :: enum {
    // Compute initialization at load and after target resize.
    Setup,
    // Composite-style work before shadow rendering.
    Begin,
    Prepare,
    Deferred,
    Composite,
    Final,
    // A gbuffers program: the game draws its geometry with it, before deferred.
    Gbuffers,
    // A gbuffers program drawing translucent geometry, after deferred (2.1).
    Translucent,
    // A shadow program: the game's geometry from the shadow light, into the shadow buffers.
    Shadow,
    // `shadowcomp`..`shadowcomp99`: composite-style programs over the shadow buffers.
    ShadowComp,
}

    // rust: impl Group {
    // Whether the group writes the shadow buffers, where buffer n is shadowcolor n.
shadow :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Group::Shadow | Group::ShadowComp)
}
}

// The samplers whose use turns the shadow pass on (2.5, 6.3).
    // rust: const SHADOW_SAMPLERS: [&str; 9] = [
    // rust: "shadow",
    // rust: "watershadow",
    // rust: "shadowtex0",
    // rust: "shadowtex1",
    // rust: "shadowtex0HW",
    // rust: "shadowtex1HW",
    // rust: "shadowcolor",
    // rust: "shadowcolor0",
    // rust: "shadowcolor1",
    // rust: ];

// A blend factor of `blend.<program>` (3.2), as GL names it.
Factor :: enum {
    Zero,
    One,
    SrcColor,
    OneMinusSrcColor,
    DstColor,
    OneMinusDstColor,
    SrcAlpha,
    OneMinusSrcAlpha,
    DstAlpha,
    OneMinusDstAlpha,
    SrcAlphaSaturate,
}

    // rust: impl Factor {
parse :: proc(word: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match word {
    // rust: "ZERO" => Self::Zero,
    // rust: "ONE" => Self::One,
    // rust: "SRC_COLOR" => Self::SrcColor,
    // rust: "ONE_MINUS_SRC_COLOR" => Self::OneMinusSrcColor,
    // rust: "DST_COLOR" => Self::DstColor,
    // rust: "ONE_MINUS_DST_COLOR" => Self::OneMinusDstColor,
    // rust: "SRC_ALPHA" => Self::SrcAlpha,
    // rust: "ONE_MINUS_SRC_ALPHA" => Self::OneMinusSrcAlpha,
    // rust: "DST_ALPHA" => Self::DstAlpha,
    // rust: "ONE_MINUS_DST_ALPHA" => Self::OneMinusDstAlpha,
    // rust: "SRC_ALPHA_SATURATE" => Self::SrcAlphaSaturate,
    // rust: _ => return None,
    // rust: })
}
}

// Source and destination factors for colour, then for alpha.
    // rust: pub type Blend = [Factor; 4];

// The default blend of translucent geometry (3.2).
    // rust: pub const TRANSLUCENT_BLEND: Blend = [
    // rust: Factor::SrcAlpha,
    // rust: Factor::OneMinusSrcAlpha,
    // rust: Factor::One,
    // rust: Factor::OneMinusSrcAlpha,
    // rust: ];

// `gbuffers_water` and its fallbacks (2.3).
    // rust: const WATER: [&str; 5] = [
    // rust: "gbuffers_water",
    // rust: "gbuffers_terrain",
    // rust: "gbuffers_textured_lit",
    // rust: "gbuffers_textured",
    // rust: "gbuffers_basic",
    // rust: ];

// `gbuffers_terrain` and its fallbacks (2.3).
    // rust: const TERRAIN: [&str; 4] = [
    // rust: "gbuffers_terrain",
    // rust: "gbuffers_textured_lit",
    // rust: "gbuffers_textured",
    // rust: "gbuffers_basic",
    // rust: ];

// `gbuffers_terrain_solid` and its fallbacks (ShaderDoc's "Iris Additional Programs", as
// #9137 quotes it): solid terrain, the quads over opaque texels.
    // rust: const TERRAIN_SOLID: [&str; 5] = [
    // rust: "gbuffers_terrain_solid",
    // rust: "gbuffers_terrain",
    // rust: "gbuffers_textured_lit",
    // rust: "gbuffers_textured",
    // rust: "gbuffers_basic",
    // rust: ];

// `gbuffers_terrain_cutout` and its fallbacks (the same): cutout terrain.
    // rust: const TERRAIN_CUTOUT: [&str; 5] = [
    // rust: "gbuffers_terrain_cutout",
    // rust: "gbuffers_terrain",
    // rust: "gbuffers_textured_lit",
    // rust: "gbuffers_textured",
    // rust: "gbuffers_basic",
    // rust: ];

// `gbuffers_line` and its fallback, as in Iris: lines such as the block outline.
LINES :: ["gbuffers_line", "gbuffers_basic"]

// `gbuffers_skybasic` and its fallback (2.3).
SKY :: ["gbuffers_skybasic", "gbuffers_basic"]

// `gbuffers_skytextured` and its fallbacks (2.3).
    // rust: const SKY_TEXTURED: [&str; 3] = [
    // rust: "gbuffers_skytextured",
    // rust: "gbuffers_textured",
    // rust: "gbuffers_basic",
    // rust: ];

// `gbuffers_entities` and its fallbacks (2.3).
    // rust: const ENTITIES: [&str; 4] = [
    // rust: "gbuffers_entities",
    // rust: "gbuffers_textured_lit",
    // rust: "gbuffers_textured",
    // rust: "gbuffers_basic",
    // rust: ];

// `gbuffers_block` and its fallbacks (2.3).
    // rust: const BLOCK: [&str; 5] = [
    // rust: "gbuffers_block",
    // rust: "gbuffers_terrain",
    // rust: "gbuffers_textured_lit",
    // rust: "gbuffers_textured",
    // rust: "gbuffers_basic",
    // rust: ];

// `gbuffers_clouds` and its fallbacks, as in Iris (its ShaderDoc's gbuffers table): without
// any of them the game draws its clouds.
CLOUDS :: ["gbuffers_clouds", "gbuffers_textured", "gbuffers_basic"]

// `gbuffers_hand` and its fallbacks (2.3).
    // rust: const HAND: [&str; 4] = [
    // rust: "gbuffers_hand",
    // rust: "gbuffers_textured_lit",
    // rust: "gbuffers_textured",
    // rust: "gbuffers_basic",
    // rust: ];

// `gbuffers_weather` and its fallbacks (2.3).
    // rust: const WEATHER: [&str; 4] = [
    // rust: "gbuffers_weather",
    // rust: "gbuffers_textured_lit",
    // rust: "gbuffers_textured",
    // rust: "gbuffers_basic",
    // rust: ];

// `gbuffers_entities_translucent` and its fallbacks (2.3).
    // rust: const ENTITIES_TRANSLUCENT: [&str; 5] = [
    // rust: "gbuffers_entities_translucent",
    // rust: "gbuffers_entities",
    // rust: "gbuffers_textured_lit",
    // rust: "gbuffers_textured",
    // rust: "gbuffers_basic",
    // rust: ];

// `gbuffers_beaconbeam` and its fallbacks (the shaders.properties reference): beacon and End
// gateway beams.
BEACON_BEAM :: ["gbuffers_beaconbeam", "gbuffers_textured", "gbuffers_basic"]

// `gbuffers_particles` and its fallbacks (2.3).
    // rust: const PARTICLES: [&str; 4] = [
    // rust: "gbuffers_particles",
    // rust: "gbuffers_textured_lit",
    // rust: "gbuffers_textured",
    // rust: "gbuffers_basic",
    // rust: ];

// The sun and moon's default blend: added to the sky, as vanilla draws them.
    // rust: pub const CELESTIAL_BLEND: Blend = [
    // rust: Factor::SrcAlpha,
    // rust: Factor::One,
    // rust: Factor::One,
    // rust: Factor::OneMinusSrcAlpha,
    // rust: ];

    // rust: const GROUPS: [(Group, &str); 6] = [
    // rust: (Group::Setup, "setup"),
    // rust: (Group::Begin, "begin"),
    // rust: (Group::Prepare, "prepare"),
    // rust: (Group::Deferred, "deferred"),
    // rust: (Group::Composite, "composite"),
    // rust: (Group::Final, "final"),
    // rust: ];

PostProgram :: struct {
    // The program's name (`composite3`).
    name: string,
    group: Group,
    // The vertex and fragment stages; `None` for a program of compute stages only.
    program: Maybe(Program),
    // colortex buffer of each fragment output location (location n writes `buffers[n]`).
    buffers: [dynamic]u32,
    // `flip.<name>.<buffer>`: buffers forced to flip (true) or kept (false) after this program.
    flips: Vec<(u32,
    // How the program's output blends into its buffers; `None` writes them.
    blend: Maybe(Blend),
    // Per-buffer blend overrides, keyed by colortex index (not output location).
    buffer_blends: Vec<(u32,
    // Bit n: `colortex<n>MipmapEnabled` in its fragment stage, so buffer n's mip chain is
    // regenerated right before it (6.1.7; not for gbuffers programs).
    mipmaps: u16,
    // Compute programs that run before this one, in order: `<name>.csh`, then `_a` to `_z`.
    compute: Vec<(string,
    // A geometry stage folded into the vertex stage (`translate_geometry`): drawn non-indexed,
    // six vertices per quad, with this many instances. 0 without one.
    geometry_triangles: u32,
    // `scale.<name>`: (scale, offset x, offset y), the part of its buffers a program draws, as
    // fractions of their size from GL's bottom-left corner; [1, 0, 0] (all of them) without.
    scale: [f32,
}

// `size.buffer.<buffer>`: a size of its own, relative to the render size (floats) or in
// pixels (integers).
BufferSize :: enum {
    Relative([f32; 2]),
    Absolute([u32; 2]),
}

    // rust: impl BufferSize {
parse :: proc(value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let words: Vec<&str> = value.split_whitespace().collect();
    // rust: let [w, h] = words[..] else {
    // rust: return None;
}
    // rust: if w.contains('.') || h.contains('.') {
    // rust: let (w, h): (f32, f32) = (w.parse().ok()?, h.parse().ok()?);
    // rust: let fine = |f: f32| f.is_finite() && f > 0.0;
    // rust: (fine(w) && fine(h)).then_some(Self::Relative([w, h]))
    // rust: } else {
    // rust: Some(Self::Absolute([w.parse().ok()?, h.parse().ok()?]))
}
}

    // The size for a render size of `render`, at least one pixel and at most
    // [`BufferSize::MAX`].
resolve :: proc(self: ^Self, render: [u32; 2]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let size = match self {
    // rust: Self::Relative(s) => [0, 1].map(|k| (render[k] as f32 * s[k]) as u32),
    // rust: Self::Absolute(s) => s,
}
    // rust: size.map(|n| n.clamp(1, Self::MAX))
}

    // The largest side a buffer may have, the size every device takes for a 2D texture.
MAX :: 8192
}

// `bufferObject.<n>`: an SSBO's size in bytes, or bytes per pixel of the render size scaled.
BufferObject :: enum {
    Bytes(u64),
    PerPixel { bytes: u64, scale: [f32; 2] },
}

    // rust: impl BufferObject {
parse :: proc(value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let words: Vec<&str> = value.split_whitespace().collect();
    // rust: let bytes = words.first()?.parse().ok()?;
    // rust: match words[..] {
    // rust: [_] | [_, "false", ..] => Some(Self::Bytes(bytes)),
    // rust: [_, "true", x, y] => Some(Self::PerPixel {
    // rust: bytes,
    // rust: scale: [x.parse().ok()?, y.parse().ok()?],
    // rust: }),
    // rust: _ => None,
}
}

    // The size in bytes for a render size of `render`, at least 16.
size :: proc(self: ^Self, render: [u32; 2]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Bytes(b) => b,
    // rust: Self::PerPixel { bytes, scale } => {
    // rust: let [w, h] = [0, 1].map(|k| (render[k] as f32 * scale[k]) as u64);
    // rust: bytes.saturating_mul(w).saturating_mul(h)
}
}
    // rust: .max(16)
}
}

// `image.<name>`: an image of the pack's, read and written as `name`, sampled as `sampler`.
CustomImage :: struct {
    name: string,
    sampler: Maybe(string),
    format: crate::Format,
    // The internal format's GLSL name (`r32i`), for declarations without a format.
    qualifier: string,
    // Relative to the render size (width and height), or in pixels.
    size: ImageSize,
    // Cleared to zero before each frame.
    clear: bool,
}

ImageSize :: enum {
    Relative([f32; 2]),
    Absolute([u32; 2]),
    // Three sizes: a 3D image, whatever its depth.
    Volume([u32; 3]),
    // One size in pixels: a 1D image (a lookup table by index).
    Line(u32),
}

    // rust: impl CustomImage {
parse :: proc(name: string, value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let w: Vec<&str> = value.split_whitespace().collect();
    // rust: let [sampler, _format, internal, _ty, clear, relative, rest @ ..] = &w[..] else {
    // rust: return None;
}
    // rust: let size = match (*relative, rest) {
    // rust: ("true", [x, y, ..]) => ImageSize::Relative([x.parse().ok()?, y.parse().ok()?]),
    // rust: ("false", [x]) => ImageSize::Line(x.parse().ok()?),
    // rust: ("false", [x, y]) => ImageSize::Absolute([x.parse().ok()?, y.parse().ok()?]),
    // rust: ("false", [x, y, z]) => {
    // rust: ImageSize::Volume([x.parse().ok()?, y.parse().ok()?, z.parse().ok()?])
}
    // rust: _ => return None,
}
    // rust: Some(Self {
    // rust: name: name.to_owned(),
    // rust: sampler: (*sampler != "none").then(|| sampler.to_string()),
    // rust: format: crate::Format::parse(internal)?,
    // rust: qualifier: internal.to_ascii_lowercase(),
    // rust: size,
    // rust: clear: *clear == "true",
    // rust: })
}

    // Width, height and depth for a render size of `render`.
extent :: proc(self: ^Self, render: [u32; 2]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match self.size {
    // rust: ImageSize::Relative(s) => {
    // rust: let [w, h] = [0, 1].map(|k| ((render[k] as f32 * s[k]) as u32).max(1));
    // rust: [w, h, 1]
}
    // rust: ImageSize::Absolute([w, h]) => [w.max(1), h.max(1), 1],
    // rust: ImageSize::Volume(s) => s.map(|n| n.max(1)),
    // rust: ImageSize::Line(w) => [w.max(1), 1, 1],
}
}

    // A 1D image (`image1D`), not a 2D one.
is_1d :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self.size, ImageSize::Line(_))
}

    // A 3D image (`image3D`), not a 2D one.
is_3d :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self.size, ImageSize::Volume(_))
}
}

ShadowCulling :: enum {
    On,
    Off,
    Reversed,
}

Post :: struct {
    // The folder the programs came from: `""` for `shaders` itself, else `world0`...
    folder: string,
    programs: [dynamic]PostProgram,
    // The flips of the virtual `deferred_pre` and `composite_pre` (6.1.6).
    deferred_pre: Vec<(u32,
    composite_pre: Vec<(u32,
    // What draws solid and cutout terrain, when the game asked for it and one loads; when
    // terrain draws in two parts, solid terrain only.
    terrain: Maybe(PostProgram),
    // What draws cutout terrain when the game draws terrain in two parts
    // (`GameInputs::terrain_parts`); `terrain` then draws the solid part. A pack with
    // `gbuffers_terrain_solid` or `gbuffers_terrain_cutout` and no program for one part has
    // only the other.
    terrain_cutout: Maybe(PostProgram),
    // What draws translucent terrain (water, stained glass) after deferred.
    water: Maybe(PostProgram),
    // What draws the sky (disc, sunset, stars, void) before terrain.
    sky: Maybe(PostProgram),
    // What draws the sun and moon, between the sunset and the stars.
    sky_textured: Maybe(PostProgram),
    // What draws entities, after terrain.
    entities: Maybe(PostProgram),
    // What draws block entities, after terrain.
    block: Maybe(PostProgram),
    // What draws translucent entities (name tags, shadows), after the others.
    entities_translucent: Maybe(PostProgram),
    // What draws particles.
    particles: Maybe(PostProgram),
    // What draws beacon and End gateway beams (after deferred, blended).
    beacon_beam: Maybe(PostProgram),
    damaged_block: Maybe(PostProgram),
    // What draws the game's clouds.
    clouds: Maybe(PostProgram),
    // What draws lines (the block outline), with the pack's own transform and look.
    lines: Maybe(PostProgram),
    // What draws rain and snow, after deferred.
    weather: Maybe(PostProgram),
    // `rain.depth`: whether rain and snow write depth. Without an explicit false, retain
    // Horizon's existing writes; the inspected packs do not establish the external default.
    rain_depth: bool,
    // What draws the first-person hand and held items.
    hand: Maybe(PostProgram),
    // `clouds=off`: no clouds at all, neither the game's nor the pack's program for them.
    clouds_off: bool,
    // Some program reads a shadow buffer, or `shadow.enabled=true`: the shadow pass runs (2.5).
    shadow_pass: bool,
    // When it runs: what draws solid and cutout terrain from the light (`shadow`), and
    // translucent terrain (`shadow_water` or `shadow`), into the shadow buffers (2.4).
    shadow: Maybe(PostProgram),
    shadow_water: Maybe(PostProgram),
    // What draws entities (`shadow_entities` or `shadow`) and block entities (`shadow_block` or
    // `shadow`) from the light, unless `shadowEntities`/`shadowBlockEntities` is false.
    shadow_entities: Maybe(PostProgram),
    shadow_block: Maybe(PostProgram),
    // `shadowEntities=false` with `shadowPlayer=true`: of the entities, only the player casts.
    shadow_only_player: bool,
    // `shadowBlockEntities=false` with `shadowLightBlockEntities=true`: only block entities
    // whose block emits light cast.
    shadow_only_lit_blocks: bool,
    // `shadowcomp`..`shadowcomp99`, after the shadow pass (2.1).
    shadow_comp: [dynamic]PostProgram,
    // Translucent entities draw after deferred (`separateEntityDraws`, 3.2).
    translucent_late: bool,
    // Particles draw after deferred (`particles.ordering`, `particles.before.deferred`, 3.2).
    particles_late: bool,
    // The custom uniforms of `shaders.properties` (3.4).
    custom: Custom,
    // `texture.*`: the textures the pack binds to sampler names.
    textures: [dynamic]crate::CustomTexture,
    // `size.buffer.*`, by buffer.
    sizes: [Maybe(BufferSize),
    // The shadowcolor buffers the shadow programs have: 2, or all 8 when the pack names the
    // `HIGHER_SHADOWCOLOR` feature (`iris.features.required` or `.optional`).
    shadow_colors: uint,
    // `bufferObject.*`, by binding.
    buffer_objects: std::collections::BTreeMap<u32,
    // `image.*`.
    images: [dynamic]CustomImage,
    // `shadow.culling`: `false` draws everything within the shadow distance, every face, not
    // only what casts a shadow into view; `reversed` within `voxelDistance` of the player.
    shadow_culling: ShadowCulling,
    config: Config,
    // Programs skipped and why, as `program: message` or `file:line: message`.
    notes: [dynamic]string,
}

    // rust: impl Post {
    // Every program that loaded: the passes', what draws the game's geometry, the shadow
    // pass's and its composites.
every_program :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let draws = [
    // rust: &self.terrain,
    // rust: &self.terrain_cutout,
    // rust: &self.water,
    // rust: &self.sky,
    // rust: &self.sky_textured,
    // rust: &self.entities,
    // rust: &self.block,
    // rust: &self.entities_translucent,
    // rust: &self.particles,
    // rust: &self.damaged_block,
    // rust: &self.clouds,
    // rust: &self.weather,
    // rust: &self.hand,
    // rust: &self.shadow,
    // rust: &self.shadow_water,
    // rust: &self.shadow_entities,
    // rust: &self.shadow_block,
    // rust: ];
    // rust: self.programs
    // rust: .iter()
    // rust: .chain(draws.into_iter().flatten())
    // rust: .chain(&self.shadow_comp)
}

    // The fewest bytes each storage buffer (`bufferObject.<n>`, set 4) needs for every stage
    // that binds it: its block's size as the stage lays it out (std430). OpenGL binds a smaller buffer and leaves what lies
    // past its end undefined; wgpu refuses to draw or dispatch with one.
buffer_minimums :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let mut sizes = std::collections::BTreeMap::new();
    // rust: for p in self.every_program() {
    // rust: let stages = p.program.iter().flat_map(|s| [&s.vertex, &s.fragment]);
    // rust: for module in stages.chain(p.compute.iter().map(|(_, c)| &c.module)) {
    // rust: for (_, var) in module.global_variables.iter() {
    // rust: if let (naga::AddressSpace::Storage { .. }, Some(b)) = (var.space, &var.binding)
    // rust: && b.group == 4
    // rust: {
    // rust: let size = u64::from(module.types[var.ty].inner.size(module.to_ctx()));
    // rust: let least = sizes.entry(b.binding).or_insert(0);
    // rust: *least = size.max(*least);
}
}
}
}
    // rust: sizes
}
}

// The folder for one of Minecraft's legacy dimension numbers. Named mappings use the
// corresponding Minecraft identifier; callers with an identifier should use
// [`dimension_folder_named`] instead.
dimension_folder :: proc(pack: ^Pack, id: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let name = match id {
    // rust: -1 => "minecraft:the_nether",
    // rust: 1 => "minecraft:the_end",
    // rust: 0 => "minecraft:overworld",
    // rust: _ => "",
}
    // rust: dimension_folder_named(pack, name, id)
}

// Selects a dimension's program folder. `dimension.properties` mappings take precedence
// over legacy folders: explicit identifiers beat `*`, and an unmapped identifier uses the
// base folder. Without that file, preserve the `world<legacy_id>` selection.
dimension_folder_named :: proc(pack: ^Pack, id: string, legacy_id: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(text) = pack.read_text("dimension.properties") {
    // rust: let mappings = Properties::parse(&text, &Macros::default());
    // rust: let mut fallback = "";
    // rust: for entry in &mappings.entries {
    // rust: let Some(folder) = entry.key.strip_prefix("dimension.") else {
    // rust: continue;
}
            // A folder must stay inside shaders/, including on folder-backed packs.
    // rust: let Some(path) = crate::pack::normalize(folder).filter(|p| !p.is_empty()) else {
    // rust: continue;
}
    // rust: for name in entry.value.split_whitespace() {
    // rust: if name == "*" {
    // rust: fallback = folder;
    // rust: } else if name == id
    // rust: || (!name.contains(':') && id.strip_prefix("minecraft:") == Some(name))
    // rust: {
    // rust: return path;
}
}
}
    // rust: return crate::pack::normalize(fallback).unwrap_or_default();
}
    // rust: let folder = format!("world{legacy_id}");
    // rust: if !pack.list(&folder).is_empty() {
    // rust: folder
    // rust: } else {
    // rust: String::new()
}
}

// The game's geometry a pack may draw with its gbuffers programs: each kind's vertex inputs,
// when the game can draw it with a pack.
GameInputs :: struct {
    terrain: Maybe(GbuffersInputs),
    sky: Maybe(GbuffersInputs),
    celestial: Maybe(GbuffersInputs),
    // Entities and block entities (one vertex format).
    entities: Maybe(GbuffersInputs),
    // The clouds' mesh.
    clouds: Maybe(GbuffersInputs),
    // Rain and snow.
    weather: Maybe(GbuffersInputs),
    // Lines: the block outline.
    lines: Maybe(GbuffersInputs),
    // The first-person hand and held items.
    hand: Maybe(GbuffersInputs),
    // `terrain`, drawing only its solid quads, then only its cutout ones: given, every pack
    // draws terrain in these two parts.
    terrain_parts: Option<[GbuffersInputs,
    // Terrain read vertex by vertex, for a shadow program with a geometry stage.
    terrain_geometry: Maybe(crate::GeometryInputs),
    // Entities and block entities read vertex by vertex, for the same.
    entity_geometry: Maybe(crate::GeometryInputs),
}

// Loads the post-processing programs of `folder` and, for the geometry `inputs` describes, the
// gbuffers programs it draws with.
    // rust: pub fn load_post(
    // rust: pack: &Pack,
    // rust: folder: &str,
    // rust: properties: &Properties,
    // rust: macros: &Macros,
    // rust: inputs: &GameInputs,
    // rust: ) -> Post {
    // rust: let mut post = Post {
    // rust: folder: folder.to_owned(),
    // rust: programs: Vec::new(),
    // rust: deferred_pre: flips(properties, "deferred_pre"),
    // rust: composite_pre: flips(properties, "composite_pre"),
    // rust: terrain: None,
    // rust: terrain_cutout: None,
    // rust: water: None,
    // rust: sky: None,
    // rust: sky_textured: None,
    // rust: entities: None,
    // rust: block: None,
    // rust: entities_translucent: None,
    // rust: particles: None,
    // rust: beacon_beam: None,
    // rust: damaged_block: None,
    // rust: clouds: None,
    // rust: lines: None,
    // rust: weather: None,
    // rust: rain_depth: properties
    // rust: .get("rain.depth")
    // rust: .is_none_or(|v| v.trim() != "false"),
    // rust: hand: None,
    // rust: clouds_off: false,
    // rust: shadow_pass: false,
    // rust: shadow: None,
    // rust: shadow_water: None,
    // rust: shadow_entities: None,
    // rust: shadow_block: None,
    // rust: shadow_only_player: false,
    // rust: shadow_only_lit_blocks: false,
    // rust: shadow_comp: Vec::new(),
    // rust: translucent_late: false,
    // rust: particles_late: false,
    // rust: custom: Custom::parse(properties),
    // rust: textures: Vec::new(),
    // rust: sizes: [None; crate::BUFFERS],
    // rust: shadow_colors: if higher_shadowcolor(properties) {
    // rust: crate::SHADOW_COLORS
    // rust: } else {
    // rust: 2
    // rust: },
    // rust: buffer_objects: Default::default(),
    // rust: images: Vec::new(),
    // rust: shadow_culling: match properties.get("shadow.culling").map(str::trim) {
    // rust: Some("false") => ShadowCulling::Off,
    // rust: Some("reversed") => ShadowCulling::Reversed,
    // rust: _ => ShadowCulling::On,
    // rust: },
    // rust: config: Config::default(),
    // rust: notes: Vec::new(),
}
    // rust: let options = crate::with_options(pack, macros);
    // rust: for e in &properties.entries {
    // rust: if let Some(n) = e.key.strip_prefix("bufferObject.") {
    // rust: match (n.parse(), BufferObject::parse(&e.value)) {
    // rust: (Ok(n), Some(b)) => _ = post.buffer_objects.insert(n, b),
    // rust: _ => post.notes.push(format!("`{}`: not a buffer object", e.key)),
}
    // rust: continue;
}
    // rust: if let Some(name) = e.key.strip_prefix("image.") {
    // rust: match CustomImage::parse(name, &options.expand(&e.value)) {
    // rust: Some(i) => post.images.push(i),
    // rust: None => post.notes.push(format!("`{}`: not an image", e.key)),
}
    // rust: continue;
}
    // rust: let Some(name) = e.key.strip_prefix("size.buffer.") else {
    // rust: continue;
}
    // rust: match (crate::buffer_index(name), BufferSize::parse(&e.value)) {
    // rust: (Some(b), Some(size)) => post.sizes[b] = Some(size),
    // rust: _ => post
    // rust: .notes
    // rust: .push(format!("`{}`: not a buffer and a size", e.key)),
}
}
    // rust: let (textures, notes) = crate::load_textures(pack, properties);
    // rust: post.textures = textures;
    // rust: post.notes.extend(notes);
    // rust: let mut loader = Loader {
    // rust: pack,
    // rust: folder,
    // rust: properties,
    // rust: macros,
    // rust: switches: crate::switches_on(pack),
    // rust: options,
    // rust: geometry: None,
    // rust: post: &mut post,
}
    // rust: for (group, base) in GROUPS {
    // rust: let names: Vec<String> = if group == Group::Final {
    // rust: vec![base.to_owned()]
    // rust: } else {
    // rust: std::iter::once(base.to_owned())
    // rust: .chain((1..=99).map(|n| format!("{base}{n}")))
    // rust: .collect()
}
    // rust: let target = match group {
    // rust: Group::Final => Target::Window,
    // rust: _ => Target::Buffers,
}
    // rust: for name in names {
    // rust: if let Some(mut p) = loader.load(name, group, |v, f| translate_composite(v, f, target))
    // rust: {
                // `blend.<program>` blends every buffer the program writes. Iris 1.11.7, probed:
                // it applies to begin, prepare, deferred and composite programs, and
                // `blend.<program>.<buffer>` doesn't apply to deferred and composite ones; the
                // other cases are assumed to match.
    // rust: p.blend = blend(loader.properties, &p.name).flatten();
    // rust: p.buffer_blends.clear();
    // rust: loader.post.programs.push(p);
}
}
}
    // rust: let split_terrain = ["gbuffers_terrain_solid", "gbuffers_terrain_cutout"]
    // rust: .iter()
    // rust: .any(|n| loader.has(n));
    // Whether the pack has a program for each part, loaded or not.
    // rust: let [has_solid, has_cutout] =
    // rust: [&TERRAIN_SOLID, &TERRAIN_CUTOUT].map(|chain| chain.iter().any(|n| loader.has(n)));
    // rust: let mut gbuffers = |names: &[&str], group, inputs: &GbuffersInputs| {
    // rust: names.iter().find_map(|name| {
            // `alphaTest.<program>` replaces the geometry's default test (OQ-23).
    // rust: let key = properties.get(&format!("alphaTest.{name}"));
    // rust: let test = key.and_then(|v| crate::AlphaTest::parse(v.trim()));
    // rust: let mut inputs = inputs.clone();
    // rust: if let Some(test) = test {
    // rust: inputs.alpha_test = test;
}
    // rust: loader.load(name.to_string(), group, |v, f| {
    // rust: translate_gbuffers(v, f, Target::Buffers, &inputs)
    // rust: })
    // rust: })
}
    // The sky blends as vanilla draws its sunset fan and stars unless `blend.*` says otherwise.
    // rust: let sky = inputs
    // rust: .sky
    // rust: .as_ref()
    // rust: .and_then(|i| gbuffers(&SKY, Group::Gbuffers, i));
    // rust: let sky = sky.map(|mut p| {
    // rust: p.blend = blend(properties, &p.name).unwrap_or(Some(TRANSLUCENT_BLEND));
    // rust: p
    // rust: });
    // rust: let celestial = inputs.celestial.as_ref();
    // rust: let sky_textured = celestial.and_then(|i| gbuffers(&SKY_TEXTURED, Group::Gbuffers, i));
    // rust: let sky_textured = sky_textured.map(|mut p| {
    // rust: p.blend = blend(properties, &p.name).unwrap_or(Some(CELESTIAL_BLEND));
    // rust: p
    // rust: });
    // Entities and block entities draw without blending, as terrain does and as vanilla's
    // cutout entity types do, unless `blend.*` says otherwise (OQ-23).
    // rust: let entity_blend = |p: Option<PostProgram>| {
    // rust: p.map(|mut p| {
    // rust: p.blend = blend(properties, &p.name).flatten();
    // rust: p
    // rust: })
}
    // rust: let (entities, block) = match &inputs.entities {
    // rust: Some(i) => (
    // rust: entity_blend(gbuffers(&ENTITIES, Group::Gbuffers, i)),
    // rust: entity_blend(gbuffers(&BLOCK, Group::Gbuffers, i)),
    // rust: ),
    // rust: None => (None, None),
}
    // rust: let damaged_block = inputs
    // rust: .entities
    // rust: .as_ref()
    // rust: .and_then(|i| gbuffers(&["gbuffers_damagedblock"], Group::Gbuffers, i))
    // rust: .map(|mut p| {
    // rust: p.blend = blend(properties, &p.name).unwrap_or(Some([
    // rust: Factor::DstColor,
    // rust: Factor::SrcColor,
    // rust: Factor::One,
    // rust: Factor::Zero,
    // rust: ]));
    // rust: p
    // rust: });
    // Translucent entities and particles blend (OQ-23). Particles keep vanilla's alpha cut at
    // 0.1; translucent entities lose only fully transparent texels (a shadow fades out).
    // rust: let translucent =
    // rust: |names: &[&str],
    // rust: cut: f32,
    // rust: gbuffers: &mut dyn FnMut(&[&str], &GbuffersInputs) -> Option<PostProgram>| {
    // rust: let i = inputs.entities.as_ref()?;
    // rust: let mut i = i.clone();
    // rust: i.alpha_test = Some(crate::AlphaTest {
    // rust: op: ">",
    // rust: reference: cut,
    // rust: });
    // rust: gbuffers(names, &i).map(|mut p| {
    // rust: p.blend = blend(properties, &p.name).unwrap_or(Some(TRANSLUCENT_BLEND));
    // rust: p
    // rust: })
}
    // rust: let mut gbuffers_dyn = |names: &[&str], i: &GbuffersInputs| gbuffers(names, Group::Gbuffers, i);
    // rust: let entities_translucent = translucent(&ENTITIES_TRANSLUCENT, 0.0, &mut gbuffers_dyn);
    // rust: let particles = translucent(&PARTICLES, 0.1, &mut gbuffers_dyn);
    // rust: let beacon_beam = translucent(&BEACON_BEAM, 0.0, &mut gbuffers_dyn);
    // Clouds blend, as vanilla's do (OQ-23).
    // rust: let clouds = inputs
    // rust: .clouds
    // rust: .as_ref()
    // rust: .and_then(|i| gbuffers_dyn(&CLOUDS, i));
    // rust: let clouds = clouds.map(|mut p| {
    // rust: p.blend = blend(properties, &p.name).unwrap_or(Some(TRANSLUCENT_BLEND));
    // rust: p
    // rust: });
    // The block outline blends, as vanilla's does.
    // rust: let lines = inputs
    // rust: .lines
    // rust: .as_ref()
    // rust: .and_then(|i| gbuffers_dyn(&LINES, i))
    // rust: .map(|mut p| {
    // rust: p.blend = blend(properties, &p.name).unwrap_or(Some(TRANSLUCENT_BLEND));
    // rust: p
    // rust: });
    // Rain and snow draw after deferred and blend, as vanilla's do (OQ-23).
    // rust: let weather = inputs
    // rust: .weather
    // rust: .as_ref()
    // rust: .and_then(|i| gbuffers(&WEATHER, Group::Translucent, i));
    // rust: let weather = weather.map(|mut p| {
    // rust: p.blend = blend(properties, &p.name).unwrap_or(Some(TRANSLUCENT_BLEND));
    // rust: p
    // rust: });
    // The hand draws as entities do: no blending unless `blend.*` says otherwise (OQ-23).
    // rust: let hand = inputs
    // rust: .hand
    // rust: .as_ref()
    // rust: .and_then(|i| gbuffers(&HAND, Group::Gbuffers, i))
    // rust: .map(|mut p| {
    // rust: p.blend = blend(properties, &p.name).flatten();
    // rust: p
    // rust: });
    // rust: if let Some(terrain) = &inputs.terrain {
        // Cutout terrain's alpha test, unless `alphaTest.*` says otherwise (3.2): alpha above
        // 0.5, which `alphaTestRef` reads. Iris 1.11.7 with probe packs of ours (#9307), through
        // gbuffers_terrain alone or gbuffers_terrain_cutout: cutout fragments written with alpha
        // 0.5 and below were discarded, 0.51 and above kept, and alphaTestRef read 0.5. Vanilla's
        // cutout terrain cuts at 0.5 too (`RenderPipelines.CUTOUT_TERRAIN`'s `ALPHA_CUTOUT`).
    // rust: let cutout = |inputs: &GbuffersInputs| {
    // rust: let mut cutout = inputs.clone();
    // rust: cutout.alpha_test = cutout.alpha_test.or(Some(crate::AlphaTest {
    // rust: op: ">",
    // rust: reference: 0.5,
    // rust: }));
    // rust: cutout
}
        // Solid and cutout terrain draw apart. A pack with Iris's gbuffers_terrain_solid or
        // gbuffers_terrain_cutout draws each with its own, falling back to gbuffers_terrain's
        // chain (Iris 1.11.7 with probe packs having both, or one of them); any other pack draws
        // both parts with gbuffers_terrain's chain, each with its own alpha test (#9307). Solid
        // terrain gets no default alpha test, and alphaTestRef 0: in those probes Iris kept
        // solid fragments written with alpha 0.05, through either program, and also 0.0
        // through gbuffers_terrain alone or gbuffers_terrain_solid (#9307).
    // rust: let parts = inputs.terrain_parts.as_ref().filter(|_| split_terrain);
    // rust: let mut lone = None;
    // rust: let (solid, terrain_cutout) = match parts {
    // rust: Some([solid, cut]) => {
    // rust: let solid = gbuffers(&TERRAIN_SOLID, Group::Gbuffers, solid);
    // rust: let cut = gbuffers(&TERRAIN_CUTOUT, Group::Gbuffers, &cutout(cut));
                // One part loaded: its name, the other part, and whether the pack has a
                // program for that one.
    // rust: let one = match (&solid, &cut) {
    // rust: (Some(p), None) => Some((p.name.clone(), "cutout", has_cutout)),
    // rust: (None, Some(p)) => Some((p.name.clone(), "solid", has_solid)),
    // rust: _ => None,
}
    // rust: match one {
                    // No program in the other part's chain: that part draws nothing, and this
                    // one draws alone. Iris 1.11.7 left the other part's terrain undrawn with
                    // our probes having only gbuffers_terrain_solid, or only _cutout.
    // rust: Some((name, other, false)) => {
    // rust: lone = Some(format!(
    // rust: "{name}: no program for {other} terrain; nothing draws it"
    // rust: ));
    // rust: (solid, cut)
}
                    // The other part's program didn't load: this one doesn't draw alone, which
                    // would leave that part's terrain undrawn. The game draws all terrain, as
                    // when an unsplit pack's terrain program doesn't load.
    // rust: Some((name, other, true)) => {
    // rust: lone = Some(format!(
    // rust: "{name}: {other} terrain's program didn't load; the game draws all terrain"
    // rust: ));
    // rust: (None, None)
}
    // rust: None => (solid, cut),
}
}
    // rust: None => match &inputs.terrain_parts {
                // One program draws both parts, so both load or neither does.
    // rust: Some([solid, cut]) => match (
    // rust: gbuffers(&TERRAIN, Group::Gbuffers, solid),
    // rust: gbuffers(&TERRAIN, Group::Gbuffers, &cutout(cut)),
    // rust: ) {
    // rust: (Some(solid), Some(cut)) => (Some(solid), Some(cut)),
    // rust: _ => (None, None),
    // rust: },
                // A game that draws terrain in one part: all of it with the cutout test.
    // rust: None => (gbuffers(&TERRAIN, Group::Gbuffers, &cutout(terrain)), None),
    // rust: },
}
        // gbuffers_water falls back to gbuffers_terrain's chain (2.3).
    // rust: let water = gbuffers(&WATER, Group::Translucent, terrain);
    // rust: loader.post.notes.extend(lone);
    // rust: loader.post.terrain = solid;
    // rust: loader.post.water = water.map(|mut p| {
    // rust: p.blend = blend(properties, &p.name).unwrap_or(Some(TRANSLUCENT_BLEND));
    // rust: p
    // rust: });
    // rust: loader.post.terrain_cutout = terrain_cutout;
    // rust: let programs = [&mut loader.post.terrain, &mut loader.post.terrain_cutout];
    // rust: for p in programs.into_iter().flatten() {
    // rust: p.blend = blend(properties, &p.name).flatten();
}
}
    // rust: loader.post.sky = sky;
    // rust: loader.post.sky_textured = sky_textured;
    // rust: loader.post.entities = entities;
    // rust: loader.post.block = block;
    // rust: loader.post.entities_translucent = entities_translucent;
    // rust: loader.post.particles = particles;
    // rust: loader.post.beacon_beam = beacon_beam;
    // rust: loader.post.damaged_block = damaged_block;
    // rust: loader.post.clouds_off = properties.get("clouds").is_some_and(|v| v.trim() == "off");
    // rust: loader.post.clouds = clouds.filter(|_| !loader.post.clouds_off);
    // rust: loader.post.lines = lines;
    // rust: loader.post.weather = weather;
    // rust: loader.post.hand = hand;
    // rust: let flag = |key: &str| properties.get(key).map(|v| v.trim() == "true");
    // rust: loader.post.translucent_late = flag("separateEntityDraws").unwrap_or(false);
    // `after` when the pack has a deferred program, else `mixed`; ours are all translucent, so
    // `mixed` draws them after deferred too.
    // rust: loader.post.particles_late = match properties.get("particles.ordering").map(str::trim) {
    // rust: Some("before") => false,
    // rust: Some(_) => true,
    // rust: None => !flag("particles.before.deferred").unwrap_or(false),
}
    // rust: load_shadow(
    // rust: &mut loader,
    // rust: inputs.terrain.as_ref(),
    // rust: inputs.entities.as_ref(),
    // rust: [&inputs.terrain_geometry, &inputs.entity_geometry].map(Option::as_ref),
    // rust: );
    // rust: post
}

// Whether the shadow pass runs (2.5) and, when it does, its programs: `shadow_solid` and
// `shadow_cutout` are not used (2.4, Legacy); the game's solid and cutout terrain is one draw.
// `shadow_entities` and `shadow_block` read the entities' vertices (`entities`). A program
// with a geometry stage reads its vertices itself: `geometry` holds how, for terrain and for
// entities.
    // rust: fn load_shadow(
    // rust: loader: &mut Loader<'_>,
    // rust: terrain: Option<&GbuffersInputs>,
    // rust: entities: Option<&GbuffersInputs>,
    // rust: geometry: [Option<&crate::GeometryInputs>; 2],
    // rust: ) {
    // rust: let post = &*loader.post;
    // rust: let gbuffers = [
    // rust: &post.terrain,
    // rust: &post.terrain_cutout,
    // rust: &post.water,
    // rust: &post.sky,
    // rust: &post.sky_textured,
    // rust: &post.entities,
    // rust: &post.block,
    // rust: &post.entities_translucent,
    // rust: &post.particles,
    // rust: &post.beacon_beam,
    // rust: &post.damaged_block,
    // rust: &post.clouds,
    // rust: &post.weather,
    // rust: &post.hand,
    // rust: ];
    // rust: let reads = (post.programs.iter())
    // rust: .chain(gbuffers.into_iter().flatten())
    // rust: .flat_map(|p| p.program.iter().flat_map(|q| &q.interface.samplers))
    // rust: .any(|s| {
    // rust: SHADOW_SAMPLERS.contains(&s.name.as_str())
    // rust: || config::shadow_color(&s.name).is_some_and(|n| n < loader.post.shadow_colors)
    // rust: });
    // rust: let forced = match loader.properties.get("shadow.enabled").map(str::trim) {
    // rust: Some("true") => Some(true),
    // rust: Some("false") => Some(false),
    // rust: _ => None,
}
    // rust: let on = forced.unwrap_or(reads);
    // rust: loader.post.shadow_pass = on;
    // rust: if !on {
        // Observed in probe packs of ours (p9063a, p9063c), not a rule Iris states: Iris 1.11.7
        // honoured a `colortexNFormat` declared only in `shadow.fsh` or `shadowcomp.fsh` of a
        // pack Horizon runs without a shadow pass. So the colortex formats of the shadow
        // programs' fragment shaders are read here, and nothing else of them (nothing else was
        // probed). The other shadow programs' files were not probed; they are read as `shadow`.
    // rust: let names = ["shadow", "shadow_water", "shadow_entities", "shadow_block"]
    // rust: .map(str::to_owned)
    // rust: .into_iter()
    // rust: .chain(std::iter::once("shadowcomp".to_owned()))
    // rust: .chain((1..=99).map(|n| format!("shadowcomp{n}")));
    // rust: for name in names {
    // rust: loader.read_formats(&name);
}
    // rust: return;
}
    // rust: let names =
    // rust: std::iter::once("shadowcomp".to_owned()).chain((1..=99).map(|n| format!("shadowcomp{n}")));
    // rust: for name in names {
    // rust: let program = loader.load(name, Group::ShadowComp, |v, f| {
    // rust: translate_composite(v, f, Target::Buffers)
    // rust: });
    // rust: loader.post.shadow_comp.extend(program);
}
    // rust: let properties = loader.properties;
    // rust: let mut load =
    // rust: |names: &[&str], inputs: Option<&GbuffersInputs>, terrain: bool, cutout: bool| {
    // rust: let inputs = inputs?;
    // rust: names.iter().find_map(|name| {
                // Cutout geometry (leaves) casts the shadow of its texels only: the cutout test,
                // unless `alphaTest.<program>` says otherwise, as for the gbuffers programs.
                // Translucent terrain keeps no test, as gbuffers_water does.
    // rust: let test = match properties.get(&format!("alphaTest.{name}")) {
    // rust: Some(v) => crate::AlphaTest::parse(v.trim()).flatten(),
    // rust: None if !cutout => inputs.alpha_test,
    // rust: None => inputs.alpha_test.or(Some(crate::AlphaTest {
    // rust: op: ">",
    // rust: reference: 0.1,
    // rust: })),
}
    // rust: let mut inputs = inputs.clone();
    // rust: inputs.alpha_test = test;
    // rust: let geometry = if terrain { geometry[0] } else { geometry[1] };
    // rust: loader.geometry = geometry.cloned().map(|mut g| {
    // rust: g.inputs.alpha_test = test;
    // rust: g
    // rust: });
    // rust: let p = loader.load(name.to_string(), Group::Shadow, |v, f| {
    // rust: translate_shadow(v, f, &inputs)
    // rust: });
    // rust: p.map(|mut p| {
    // rust: p.blend = blend(properties, &p.name).flatten();
    // rust: p
    // rust: })
    // rust: })
}
    // `shadowTerrain`, `shadowTranslucent`, `shadowEntities` and `shadowBlockEntities` (3.2)
    // leave their part out of the shadow pass; all are on by default (OQ-19). `shadowPlayer`
    // and `shadowLightBlockEntities` (E, off by default) keep the player, and block entities
    // that emit light, when the first two are off.
    // rust: let keep = |key: &str| properties.get(key).is_none_or(|v| v.trim() != "false");
    // rust: let set = |key: &str| properties.get(key).is_some_and(|v| v.trim() == "true");
    // rust: let only_player = !keep("shadowEntities") && set("shadowPlayer");
    // rust: let only_lit = !keep("shadowBlockEntities") && set("shadowLightBlockEntities");
    // rust: let shadow = keep("shadowTerrain")
    // rust: .then(|| load(&["shadow"], terrain, true, true))
    // rust: .flatten();
    // rust: let water = keep("shadowTranslucent")
    // rust: .then(|| load(&["shadow_water", "shadow"], terrain, true, false))
    // rust: .flatten();
    // rust: let shadow_entities = (keep("shadowEntities") || only_player)
    // rust: .then(|| load(&["shadow_entities", "shadow"], entities, false, true))
    // rust: .flatten();
    // rust: let shadow_block = (keep("shadowBlockEntities") || only_lit)
    // rust: .then(|| load(&["shadow_block", "shadow"], entities, false, true))
    // rust: .flatten();
    // rust: if shadow.is_none() && terrain.is_some() {
    // rust: loader
    // rust: .post
    // rust: .notes
    // rust: .push("shadow: no program; the shadow map stays clear".to_owned());
}
    // rust: loader.geometry = None;
    // rust: loader.post.shadow = shadow;
    // rust: loader.post.shadow_water = water;
    // rust: loader.post.shadow_entities = shadow_entities;
    // rust: loader.post.shadow_block = shadow_block;
    // rust: loader.post.shadow_only_player = only_player;
    // rust: loader.post.shadow_only_lit_blocks = only_lit;
}

Loader :: struct {
    pack: ^'a Pack,
    folder: ^'a str,
    properties: ^'a Properties,
    macros: ^'a Macros,
    switches: BTreeSet<string>,
    // `macros` with the pack's options, for the program switches.
    options: Macros,
    // The game's geometry read vertex by vertex, while loading shadow programs.
    geometry: Maybe(crate::GeometryInputs),
    post: ^'a mut Post,
}

    // rust: impl Loader<'_> {
    // The pack has both stages of the program `name` in this folder, and doesn't turn it off
    // (`program.<name>.enabled`), as `load` reads them.
has :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: ["vsh", "fsh"].iter().all(|ext| match self.folder {
    // rust: "" => self.pack.exists(&format!("{name}.{ext}")),
    // rust: f => self.pack.exists(&format!("{f}/{name}.{ext}")),
    // rust: }) && enabled(
    // rust: self.properties,
    // rust: self.folder,
    // rust: name,
    // rust: &self.options,
    // rust: &self.switches,
    // rust: )
}

    // The program `name` translated by `translate`, or `None` when it is missing, disabled or
    // fails (with a note).
    // rust: fn load(
    // rust: &mut self,
    // rust: name: String,
    // rust: group: Group,
    // rust: translate: impl FnOnce(&Preprocessed, &Preprocessed) -> Result<Program, Vec<crate::Error>>,
    // rust: ) -> Option<PostProgram> {
    // rust: let path = |ext: &str| match self.folder {
    // rust: "" => format!("{name}.{ext}"),
    // rust: f => format!("{f}/{name}.{ext}"),
}
    // rust: let (vsh, fsh) = (path("vsh"), path("fsh"));
    // rust: if group == Group::Setup || !self.pack.exists(&fsh) || !self.pack.exists(&vsh) {
    // rust: let on = enabled(
    // rust: self.properties,
    // rust: self.folder,
    // rust: &name,
    // rust: &self.options,
    // rust: &self.switches,
    // rust: );
            // A program of compute stages only (`.csh` without `.vsh` and `.fsh`).
    // rust: let composite = matches!(
    // rust: group,
    // rust: Group::Setup
    // rust: | Group::Begin
    // rust: | Group::Prepare
    // rust: | Group::Deferred
    // rust: | Group::Composite
    // rust: | Group::ShadowComp
    // rust: );
    // rust: if !on || !composite {
    // rust: return None;
}
    // rust: let compute = self.compute(&name);
    // rust: return (!compute.is_empty()).then(|| PostProgram {
    // rust: buffer_blends: buffer_blends(self.properties, &name),
    // rust: flips: flips(self.properties, &name),
    // rust: name,
    // rust: group,
    // rust: program: None,
    // rust: buffers: Vec::new(),
    // rust: blend: None,
    // rust: mipmaps: 0,
    // rust: compute,
    // rust: geometry_triangles: 0,
    // rust: scale: FULL,
    // rust: });
}
    // rust: if !enabled(
    // rust: self.properties,
    // rust: self.folder,
    // rust: &name,
    // rust: &self.options,
    // rust: &self.switches,
    // rust: ) {
    // rust: return None;
}
    // rust: if self.pack.exists(&path("gsh")) {
    // rust: let Some(inputs) = self.geometry.clone() else {
    // rust: self.post.notes.push(format!(
    // rust: "{name}: uses a geometry stage (supported for the shadow pass's terrain and entities only); skipped"
    // rust: ));
    // rust: return None;
}
    // rust: let (vsh, gsh) = (path("vsh"), path("gsh"));
    // rust: return self.load_geometry(name, group, &vsh, &gsh, &fsh, &inputs);
}
    // rust: let vertex = self.preprocess(&vsh);
    // rust: let fragment = self.preprocess(&fsh);
    // rust: let notes = &mut self.post.notes;
    // rust: let problems: Vec<String> = [&vertex, &fragment]
    // rust: .iter()
    // rust: .flat_map(|pp| diagnostics(pp))
    // rust: .collect();
    // rust: if !problems.is_empty() {
    // rust: notes.extend(problems);
    // rust: notes.push(format!("{name}: skipped"));
    // rust: return None;
}
    // rust: notes.extend([&vertex, &fragment].iter().flat_map(|pp| warnings(pp)));
    // rust: let program = match translate(&vertex, &fragment) {
    // rust: Ok(p) => p,
    // rust: Err(errors) => {
    // rust: notes.extend(
    // rust: errors
    // rust: .iter()
    // rust: .map(|e| format!("{}:{}: {}", e.file, e.line, e.message)),
    // rust: );
    // rust: notes.push(format!("{name}: skipped"));
    // rust: return None;
}
}
    // rust: notes.extend(
    // rust: program
    // rust: .notes
    // rust: .iter()
    // rust: .map(|e| format!("{}:{}: {}", e.file, e.line, e.message)),
    // rust: );
    // rust: self.post.config.read_vertex(&vertex);
    // rust: self.post.config.read(&fragment);
    // rust: let mut buffers =
    // rust: config::draw_buffers(&fragment).unwrap_or_else(|| default_draw_buffers(group.shadow()));
    // rust: if group.shadow() {
            // Output n writes shadowcolor n (6.3); `shadow_buffers` says how many there are.
    // rust: let kept = buffers
    // rust: .iter()
    // rust: .position(|&b| b as usize >= self.shadow_buffers(&fragment))
    // rust: .unwrap_or(buffers.len());
    // rust: buffers.truncate(kept);
}
    // rust: let mipmaps = match group {
    // rust: Group::Gbuffers | Group::Translucent | Group::Shadow | Group::ShadowComp => 0,
    // rust: _ => {
    // rust: let mut own = Config::default();
    // rust: own.read(&fragment);
    // rust: (own.buffers.iter().enumerate())
    // rust: .filter(|b| b.1.mipmap)
    // rust: .fold(0, |m, (i, _)| m | 1 << i)
}
}
    // rust: let compute = match group {
    // rust: Group::Setup
    // rust: | Group::Begin
    // rust: | Group::Prepare
    // rust: | Group::Deferred
    // rust: | Group::Composite
    // rust: | Group::Final
    // rust: | Group::ShadowComp => self.compute(&name),
    // rust: _ => Vec::new(),
}
    // rust: Some(PostProgram {
    // rust: buffer_blends: buffer_blends(self.properties, &name),
    // rust: flips: flips(self.properties, &name),
    // rust: scale: scale(self.properties, &name, group),
    // rust: name,
    // rust: group,
    // rust: program: Some(program),
    // rust: buffers,
    // rust: blend: None,
    // rust: mipmaps,
    // rust: compute,
    // rust: geometry_triangles: 0,
    // rust: })
}

    // Reads the colortex formats of program `name` without loading it, when it is there and
    // enabled: those of its fragment shader, as [`Self::load`] reads them.
read_formats :: proc(self: ^Self, name: string) {
}
    // rust: let path = |ext: &str| match self.folder {
    // rust: "" => format!("{name}.{ext}"),
    // rust: f => format!("{f}/{name}.{ext}"),
}
    // rust: let (vsh, fsh) = (path("vsh"), path("fsh"));
    // rust: let on = enabled(
    // rust: self.properties,
    // rust: self.folder,
    // rust: name,
    // rust: &self.options,
    // rust: &self.switches,
    // rust: );
    // rust: if !on || !self.pack.exists(&fsh) || !self.pack.exists(&vsh) {
    // rust: return;
}
    // rust: let fragment = self.preprocess(&fsh);
    // rust: self.post.config.read_formats(&fragment);
}

    // Stage file `path` through the preprocessor; the pack's images declared without a format
    // (GLSL lets a write-only image omit it) get the one `image.*` gives them.
preprocess :: proc(self: ^Self, path: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut pp = preprocess(self.pack, path, self.macros);
    // rust: if self.post.images.is_empty() || !pp.code.contains("image") {
    // rust: return pp;
}
    // rust: let source: Vec<&str> = pp.code.split('\n').collect();
    // rust: let lines: Vec<String> = source
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(n, &line)| {
                // A qualifier on the line before (`layout(r32ui)` then `uniform uimage3D v;`).
    // rust: let qualified = line.contains("layout")
    // rust: || source[..n]
    // rust: .iter()
    // rust: .rev()
    // rust: .find(|l| !l.trim().is_empty())
    // rust: .is_some_and(|l| l.trim_start().starts_with("layout") && !l.contains(';'));
    // rust: let words: Vec<&str> = line
    // rust: .split(|c: char| !(c.is_ascii_alphanumeric() || c == '_'))
    // rust: .collect();
    // rust: let image = self
    // rust: .post
    // rust: .images
    // rust: .iter()
    // rust: .find(|i| words.contains(&i.name.as_str()));
    // rust: match image {
    // rust: Some(i)
    // rust: if words.contains(&"uniform")
    // rust: && !qualified
    // rust: && words.iter().any(|w| {
    // rust: ["image1D", "image2D", "image3D"]
    // rust: .iter()
    // rust: .any(|d| w.ends_with(d))
    // rust: }) =>
    // rust: {
    // rust: format!("layout({}) {line}", i.qualifier)
}
    // rust: _ => line.to_owned(),
}
    // rust: })
    // rust: .collect();
    // rust: pp.code = lines.join("\n");
    // rust: pp
}

    // A program with a geometry stage, folded into its vertex stage.
    // rust: fn load_geometry(
    // rust: &mut self,
    // rust: name: String,
    // rust: group: Group,
    // rust: vsh: &str,
    // rust: gsh: &str,
    // rust: fsh: &str,
    // rust: inputs: &crate::GeometryInputs,
    // rust: ) -> Option<PostProgram> {
    // rust: let stages = [vsh, gsh, fsh].map(|p| self.preprocess(p));
    // rust: let notes = &mut self.post.notes;
    // rust: let problems: Vec<String> = stages.iter().flat_map(diagnostics).collect();
    // rust: if !problems.is_empty() {
    // rust: notes.extend(problems);
    // rust: notes.push(format!("{name}: skipped"));
    // rust: return None;
}
    // rust: let [vertex, geometry, fragment] = &stages;
    // rust: let (program, triangles) =
    // rust: match crate::translate_geometry(vertex, geometry, fragment, inputs) {
    // rust: Ok(p) => p,
    // rust: Err(errors) => {
    // rust: notes.extend(
    // rust: errors
    // rust: .iter()
    // rust: .map(|e| format!("{}:{}: {}", e.file, e.line, e.message)),
    // rust: );
    // rust: notes.push(format!("{name}: skipped"));
    // rust: return None;
}
}
    // rust: notes.extend(
    // rust: program
    // rust: .notes
    // rust: .iter()
    // rust: .map(|e| format!("{}:{}: {}", e.file, e.line, e.message)),
    // rust: );
    // rust: self.post.config.read_vertex(vertex);
    // rust: self.post.config.read(fragment);
    // rust: let mut buffers =
    // rust: config::draw_buffers(fragment).unwrap_or_else(|| default_draw_buffers(true));
    // rust: let kept = buffers
    // rust: .iter()
    // rust: .position(|&b| b as usize >= self.shadow_buffers(fragment))
    // rust: .unwrap_or(buffers.len());
    // rust: buffers.truncate(kept);
    // rust: Some(PostProgram {
    // rust: buffer_blends: buffer_blends(self.properties, &name),
    // rust: flips: flips(self.properties, &name),
    // rust: scale: scale(self.properties, &name, group),
    // rust: name,
    // rust: group,
    // rust: program: Some(program),
    // rust: buffers,
    // rust: blend: None,
    // rust: mipmaps: 0,
    // rust: compute: Vec::new(),
    // rust: geometry_triangles: triangles,
    // rust: })
}

    // The shadowcolor buffers a shadow program's outputs can write: all the pack has with a
    // `RENDERTARGETS` or `DRAWBUFFERS` directive, else shadowcolor0 and 1. Iris 1.11.7 with
    // `HIGHER_SHADOWCOLOR`: a `shadow` program without a directive leaves shadowcolor2 to 7
    // alone, one with `RENDERTARGETS: 0,1,2,3,4` writes all five (probe packs of our own).
shadow_buffers :: proc(self: ^Self, fragment: ^Preprocessed) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match config::draw_buffers(fragment) {
    // rust: Some(_) => self.post.shadow_colors,
    // rust: None => 2,
}
}

    // The compute programs of composite-style program `name` that are on and translate.
compute :: proc(self: ^Self, name: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let names =
    // rust: std::iter::once(name.to_owned()).chain(('a'..='z').map(|c| format!("{name}_{c}")));
    // rust: for name in names {
    // rust: let path = match self.folder {
    // rust: "" => format!("{name}.csh"),
    // rust: f => format!("{f}/{name}.csh"),
}
    // rust: if !self.pack.exists(&path)
    // rust: || !enabled(
    // rust: self.properties,
    // rust: self.folder,
    // rust: &name,
    // rust: &self.options,
    // rust: &self.switches,
    // rust: )
    // rust: {
    // rust: continue;
}
    // rust: let pp = self.preprocess(&path);
    // rust: let problems = diagnostics(&pp);
    // rust: let notes = &mut self.post.notes;
    // rust: if !problems.is_empty() {
    // rust: notes.extend(problems);
    // rust: notes.push(format!("{name}: skipped"));
    // rust: continue;
}
    // rust: match translate_compute(&pp) {
    // rust: Ok(program) => {
    // rust: notes.extend(
    // rust: program
    // rust: .notes
    // rust: .iter()
    // rust: .map(|e| format!("{}:{}: {}", e.file, e.line, e.message)),
    // rust: );
    // rust: out.push((name, program));
}
    // rust: Err(errors) => {
    // rust: notes.extend(
    // rust: errors
    // rust: .iter()
    // rust: .map(|e| format!("{}:{}: {}", e.file, e.line, e.message)),
    // rust: );
    // rust: notes.push(format!("{name}: skipped"));
}
}
}
    // rust: out
}
}

// The buffers a program writes without `RENDERTARGETS` or `DRAWBUFFERS`: only buffer 0, except
// in the shadow pass's own programs, where outputs 0 and 1 write shadowcolor0 and shadowcolor1.
// Measured in Iris 1.11.7 with probe packs: a `gbuffers_terrain`, `begin`, `prepare`, `deferred`
// or `composite` program that writes `gl_FragData[1..]` or `layout(location = n)` leaves those
// buffers untouched, while the second output of `shadow` and `shadowcomp` lands in shadowcolor1.
default_draw_buffers :: proc(shadow: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if shadow { (0..8).collect() } else { vec![0] }
}

diagnostics :: proc(pp: ^Preprocessed) -> V {
    // Ported from Horizon
    return {}
}
    // rust: located(pp, &pp.diagnostics)
}

// `pp`'s warnings (conditions read as false, unbalanced conditionals), located.
warnings :: proc(pp: ^Preprocessed) -> V {
    // Ported from Horizon
    return {}
}
    // rust: located(pp, &pp.warnings)
}

located :: proc(pp: ^Preprocessed, list: ^[crate::preprocess::Diagnostic]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: list.iter()
    // rust: .map(|d| {
    // rust: let file = pp
    // rust: .files
    // rust: .get(d.origin.file as usize)
    // rust: .map_or("?", String::as_str);
    // rust: format!("{file}:{}: {}", d.origin.line, d.message)
    // rust: })
    // rust: .collect()
}

// `program.<name>.enabled` (or `program.<folder>/<name>.enabled`): a boolean expression over
// switch options (3.3): those on by default (8.1) and the defined macros.
    // rust: fn enabled(
    // rust: properties: &Properties,
    // rust: folder: &str,
    // rust: name: &str,
    // rust: macros: &Macros,
    // rust: switches: &BTreeSet<String>,
    // rust: ) -> bool {
    // rust: let keys = [
    // rust: format!("program.{folder}/{name}.enabled"),
    // rust: format!("program.{name}.enabled"),
    // rust: ];
    // rust: let Some(expr) = keys.iter().find_map(|k| properties.get(k)) else {
    // rust: return true;
}
    // `true`/`false` as numbers, every other name as `defined(name)`, then the `#if` arithmetic.
    // rust: let mut condition = String::new();
    // rust: for token in crate::macros::lex(expr) {
    // rust: match token {
    // rust: "true" => condition.push('1'),
    // rust: "false" => condition.push('0'),
    // rust: t if switches.contains(t) => condition.push('1'),
    // rust: t if t.starts_with(|c: char| c.is_alphabetic() || c == '_') => {
    // rust: condition.push_str(&format!("defined({t})"));
}
    // rust: t => condition.push_str(t),
}
}
    // rust: eval_condition(&condition, macros).ok() != Some(0)
}

// `blend.<program>`: `Some(None)` for `off`, `Some(factors)`, or `None` when absent or not
// four known factors.
blend :: proc(properties: ^Properties, program: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let value = properties.get(&format!("blend.{program}"))?.trim();
    // rust: if value == "off" {
    // rust: return Some(None);
}
    // rust: let factors: Vec<Factor> = value
    // rust: .split_whitespace()
    // rust: .map(Factor::parse)
    // rust: .collect::<Option<_>>()?;
    // rust: Some(Some(factors.try_into().ok()?))
}

// Blend overrides apply to buffer names even when DRAWBUFFERS remaps locations.
buffer_blends :: proc(properties: ^Properties, program: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let prefix = format!("blend.{program}.");
    // rust: properties
    // rust: .entries
    // rust: .iter()
    // rust: .filter_map(|e| {
    // rust: let buffer = config::buffer_index(e.key.strip_prefix(&prefix)?)?;
    // rust: let value = blend(
    // rust: properties,
    // rust: &format!("{program}.{}", e.key.strip_prefix(&prefix)?),
    // rust: )?;
    // rust: Some((buffer as u32, value))
    // rust: })
    // rust: .collect()
}

// A program drawing all of its buffers.
FULL :: [1.0, 0.0, 0.0]

// `scale.<program>=<scale> [<offsetX> <offsetY>]` of a deferred or composite program (OptiFine's
// "Composite render scale"); prepare programs are treated the same, unverified. Iris 1.11.7
// applies the offsets too (a probe pack of our own, composite). A value that is not a scale in (0, 1] with offsets in [0, 1) draws all of them.
scale :: proc(properties: ^Properties, program: string, group: Group) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if !matches!(group, Group::Prepare | Group::Deferred | Group::Composite) {
    // rust: return FULL;
}
    // rust: let Some(value) = properties.get(&format!("scale.{program}")) else {
    // rust: return FULL;
}
    // rust: let numbers: Option<Vec<f32>> = value.split_whitespace().map(|n| n.parse().ok()).collect();
    // rust: let fraction = |s: f32| s > 0.0 && s <= 1.0;
    // rust: let offset = |o: f32| (0.0..1.0).contains(&o);
    // rust: match numbers.as_deref() {
    // rust: Some(&[s]) if fraction(s) => [s, 0.0, 0.0],
    // rust: Some(&[s, x, y]) if fraction(s) && offset(x) && offset(y) => [s, x, y],
    // rust: _ => FULL,
}
}

// Whether the pack names the `HIGHER_SHADOWCOLOR` feature, required or optional, in any case.
higher_shadowcolor :: proc(properties: ^Properties) -> b {
    // Ported from Horizon
    return {}
}
    // rust: ["iris.features.required", "iris.features.optional"]
    // rust: .iter()
    // rust: .filter_map(|k| properties.get(k))
    // rust: .any(|v| {
    // rust: v.split_whitespace()
    // rust: .any(|w| w.eq_ignore_ascii_case("HIGHER_SHADOWCOLOR"))
    // rust: })
}

// `flip.<program>.<buffer>=<bool>` keys of one program.
flips :: proc(properties: ^Properties, program: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let prefix = format!("flip.{program}.");
    // rust: properties
    // rust: .entries
    // rust: .iter()
    // rust: .filter_map(|e| {
    // rust: let buffer = config::buffer_index(e.key.strip_prefix(&prefix)?)?;
    // rust: let value = match e.value.trim() {
    // rust: "true" => true,
    // rust: "false" => false,
    // rust: _ => return None,
}
    // rust: Some((buffer as u32, value))
    // rust: })
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;

unsupported_defaults_are_notes_without_skipping_render_or_compute :: proc() {
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "original-default-control",
    // rust: crate::pack::tests::zip(&[
    // rust: ("shaders/composite.vsh", "#version 430\nvoid main() { gl_Position = vec4(0.0); }"),
    // rust: ("shaders/composite.fsh", "#version 430\nuniform double unknown = double(2.0);\nout vec4 color; void main() { color = vec4(1.0); }"),
    // rust: ("shaders/composite.csh", "#version 430\nlayout(local_size_x=1) in; uniform double unknown = double(2.0); void main() {}"),
    // rust: ]),
    // rust: ).unwrap();
    // rust: let post = load_post(
    // rust: &pack,
    // rust: "",
    // rust: &Properties::default(),
    // rust: &Macros::standard(),
    // rust: &GameInputs::default(),
    // rust: );
    // rust: let program = post
    // rust: .programs
    // rust: .iter()
    // rust: .find(|p| p.name == "composite")
    // rust: .unwrap();
    // rust: assert!(program.program.is_some());
    // rust: assert_eq!(program.compute.len(), 1);
    // rust: for file in ["composite.fsh", "composite.csh"] {
    // rust: assert!(
    // rust: post.notes
    // rust: .iter()
    // rust: .any(|n| n.contains(file) && n.contains("unknown") && n.contains("using zero")),
    // rust: "{:?}",
    // rust: post.notes
    // rust: );
}
    // rust: assert!(
    // rust: !post.notes.iter().any(|n| n.contains("skipped")),
    // rust: "{:?}",
    // rust: post.notes
    // rust: );
}

named_dimension_folder_reaches_the_program_loader :: proc() {
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "original-dimension-control",
    // rust: crate::pack::tests::zip(&[
    // rust: (
    // rust: "shaders/dimension.properties",
    // rust: "dimension.netherShaders = minecraft:the_nether\n",
    // rust: ),
    // rust: (
    // rust: "shaders/final.vsh",
    // rust: "#version 120\nvoid main() { gl_Position = gl_Vertex; }",
    // rust: ),
    // rust: (
    // rust: "shaders/final.fsh",
    // rust: "#version 120\n/* DRAWBUFFERS:0 */\nvoid main() { gl_FragColor = vec4(0.0); }",
    // rust: ),
    // rust: (
    // rust: "shaders/netherShaders/final.vsh",
    // rust: "#version 120\nvoid main() { gl_Position = gl_Vertex; }",
    // rust: ),
    // rust: (
    // rust: "shaders/netherShaders/final.fsh",
    // rust: "#version 120\n/* DRAWBUFFERS:3 */\nvoid main() { gl_FragColor = vec4(1.0); }",
    // rust: ),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let folder = dimension_folder_named(&pack, "minecraft:the_nether", -1);
    // rust: assert_eq!(folder, "netherShaders");
    // rust: let post = load_post(
    // rust: &pack,
    // rust: &folder,
    // rust: &Properties::default(),
    // rust: &Macros::standard(),
    // rust: &GameInputs::default(),
    // rust: );
    // rust: assert!(post.notes.is_empty(), "{:?}", post.notes);
    // rust: assert_eq!(post.programs.len(), 1);
    // rust: assert_eq!(post.programs[0].buffers, [3]);
}

named_dimensions_precede_wildcards_and_legacy_folders :: proc() {
}
    // rust: for mappings in [
    // rust: "dimension.other = *\ndimension.specific = the_nether example:moon\n",
    // rust: "dimension.specific = the_nether example:moon\ndimension.other = *\n",
    // rust: ] {
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "t",
    // rust: crate::pack::tests::zip(&[
    // rust: ("shaders/dimension.properties", mappings),
    // rust: ("shaders/world-1/final.fsh", "legacy"),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(dimension_folder(&pack, -1), "specific");
    // rust: assert_eq!(dimension_folder_named(&pack, "example:moon", 0), "specific");
    // rust: assert_eq!(
    // rust: dimension_folder_named(&pack, "example:the_nether", -1),
    // rust: "other"
    // rust: );
    // rust: assert_eq!(dimension_folder(&pack, 1), "other");
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "t",
    // rust: crate::pack::tests::zip(&[
    // rust: (
    // rust: "shaders/dimension.properties",
    // rust: "dimension.specific = the_end\ndimension.../../escape = *\n",
    // rust: ),
    // rust: ("shaders/world-1/final.fsh", "legacy"),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(dimension_folder(&pack, -1), "");
    // rust: assert_eq!(dimension_folder(&pack, 1), "specific");
    // rust: let legacy = Pack::from_zip_bytes(
    // rust: "t",
    // rust: crate::pack::tests::zip(&[("shaders/world-1/final.fsh", "legacy")]),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(dimension_folder(&legacy, -1), "world-1");
    // rust: assert_eq!(dimension_folder(&legacy, 0), "");
}

dimension_mapping_paths_and_unknown_legacy_ids :: proc() {
}
    // rust: let mapped = |rules: &str| {
    // rust: Pack::from_zip_bytes(
    // rust: "t",
    // rust: crate::pack::tests::zip(&[("shaders/dimension.properties", rules)]),
    // rust: )
    // rust: .unwrap()
}
    // rust: let pack =
    // rust: mapped("dimension.over = minecraft:overworld\ndimension.nested/./fallback = *\n");
    // rust: assert_eq!(dimension_folder(&pack, 0), "over");
    // rust: assert_eq!(dimension_folder(&pack, 2), "nested/fallback");
    // rust: assert_eq!(
    // rust: dimension_folder_named(&pack, "mod:moon", 2),
    // rust: "nested/fallback"
    // rust: );
    // rust: let pack = mapped("dimension.over = overworld\ndimension.../escape = *\n");
    // rust: assert_eq!(dimension_folder(&pack, 2), "");
    // rust: let pack = mapped("dimension.over = overworld\n");
    // rust: assert_eq!(dimension_folder(&pack, 2), "");
}

image_dimensions_expand_default_and_chosen_options :: proc() {
}
    // rust: let bytes =
    // rust: crate::pack::tests::zip(&[("shaders/options.glsl", "#define SIZE 16 // [8 16]\n")]);
    // rust: for (choice, expected) in [(None, [16, 16]), (Some("8"), [8, 8])] {
    // rust: let mut pack = Pack::from_zip_bytes("image.zip", bytes.clone()).unwrap();
    // rust: if let Some(value) = choice {
    // rust: pack = pack.with_chosen(std::collections::BTreeMap::from([(
    // rust: "SIZE".into(),
    // rust: value.into(),
    // rust: )]));
}
    // rust: let macros = Macros::standard();
    // rust: let properties = Properties::parse(
    // rust: "image.grid = none RGBA RGBA8 BYTE false false SIZE SIZE",
    // rust: &macros,
    // rust: );
    // rust: let post = load_post(&pack, "", &properties, &macros, &GameInputs::default());
    // rust: assert!(post.notes.is_empty(), "{:?}", post.notes);
    // rust: assert_eq!(post.images.len(), 1);
    // rust: assert_eq!(post.images[0].size, ImageSize::Absolute(expected));
}
}

image_dimensions_keep_literals_and_reject_unknown_macros :: proc() {
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "image.zip",
    // rust: crate::pack::tests::zip(&[("shaders/placeholder.glsl", "")]),
    // rust: )
    // rust: .unwrap();
    // rust: let macros = Macros::standard();
    // rust: let properties = Properties::parse(
    // rust: "image.grid = none RGBA RGBA8 BYTE false false 8 16",
    // rust: &macros,
    // rust: );
    // rust: let post = load_post(&pack, "", &properties, &macros, &GameInputs::default());
    // rust: assert!(post.notes.is_empty(), "{:?}", post.notes);
    // rust: assert_eq!(post.images[0].size, ImageSize::Absolute([8, 16]));
    // rust: let properties = Properties::parse(
    // rust: "image.grid = none RGBA RGBA8 BYTE false false UNKNOWN UNKNOWN",
    // rust: &macros,
    // rust: );
    // rust: let post = load_post(&pack, "", &properties, &macros, &GameInputs::default());
    // rust: assert!(post.images.is_empty());
    // rust: assert!(!post.notes.is_empty());
}
//     use crate::pack::tests::zip;

VSH :: "#version 120\nvarying vec2 uv
    // rust: gl_Position = ftransform();\nuv = gl_MultiTexCoord0.xy;\n}\n";
FSH :: "#version 120\nuniform sampler2D colortex0;\nvarying vec2 uv
    // rust: void main() {\n/* DRAWBUFFERS:3 */\n\
    // rust: gl_FragData[0] = texture2D(colortex0, uv);\n}\n";

buffer_objects_and_images_parse :: proc() {
}
    // rust: assert_eq!(BufferObject::parse("4096"), Some(BufferObject::Bytes(4096)));
    // rust: assert_eq!(
    // rust: BufferObject::parse("64 false 1.0 1.0"),
    // rust: Some(BufferObject::Bytes(64))
    // rust: );
    // rust: assert_eq!(
    // rust: BufferObject::parse("16 true 0.5 0.25"),
    // rust: Some(BufferObject::PerPixel {
    // rust: bytes: 16,
    // rust: scale: [0.5, 0.25]
    // rust: })
    // rust: );
    // rust: assert_eq!(BufferObject::parse("16 true 0.5"), None);
    // rust: assert_eq!(BufferObject::parse("many"), None);
    // rust: let voxels = CustomImage::parse(
    // rust: "voxels",
    // rust: "voxelSampler RED_INTEGER R32UI UNSIGNED_INT true false 64 32 16",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(voxels.sampler.as_deref(), Some("voxelSampler"));
    // rust: assert_eq!(voxels.size, ImageSize::Volume([64, 32, 16]));
    // rust: assert!(voxels.clear);
    // rust: let half =
    // rust: CustomImage::parse("half", "none RGBA RGBA16F HALF_FLOAT false true 0.5 0.5").unwrap();
    // rust: assert_eq!(
    // rust: (half.sampler, half.size),
    // rust: (None, ImageSize::Relative([0.5, 0.5]))
    // rust: );
    // rust: assert!(!half.clear);
    // rust: assert!(
    // rust: CustomImage::parse("bad", "none RGBA RGBA17Q HALF_FLOAT false true 0.5 0.5").is_none()
    // rust: );
    // rust: assert!(CustomImage::parse("short", "none RGBA RGBA16F HALF_FLOAT false").is_none());
    // rust: let flat = CustomImage::parse("flat", "none RGBA RGBA8 BYTE false false 8 8 1").unwrap();
    // rust: assert!(flat.is_3d());
    // rust: assert_eq!(flat.extent([1, 1]), [8, 8, 1]);
    // rust: assert!(
    // rust: !CustomImage::parse("plain", "none RGBA RGBA8 BYTE false false 8 8")
    // rust: .unwrap()
    // rust: .is_3d()
    // rust: );
        // One size: a 1D image, a table read by index through its sampler.
    // rust: let table = CustomImage::parse(
    // rust: "imgTable",
    // rust: "texTable RED_INTEGER R32UI UNSIGNED_INT false false 4096",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(table.sampler.as_deref(), Some("texTable"));
    // rust: assert_eq!(table.size, ImageSize::Line(4096));
    // rust: assert!(table.is_1d() && !table.is_3d());
    // rust: assert_eq!(table.extent([1920, 1080]), [4096, 1, 1]);
    // rust: assert!(!flat.is_1d());
        // A relative size needs both.
    // rust: assert!(CustomImage::parse("r", "none RGBA RGBA8 BYTE false true 0.5").is_none());
}

    // A pack's 1D image and its sampler: the image is loaded, its `uimage1D` declaration
    // gets the image's format, and the program reading both translates.
a_1d_image_and_its_sampler_load :: proc() {
}
    // rust: let properties =
    // rust: "image.imgTable = texTable RED_INTEGER R32UI UNSIGNED_INT false false 64\n";
    // rust: let csh = "#version 430\nlayout(local_size_x = 64) in;\nwriteonly uniform uimage1D imgTable;\n\
    // rust: void main() { imageStore(imgTable, int(gl_GlobalInvocationID.x), uvec4(gl_GlobalInvocationID.x)); }\n";
    // rust: let fsh = "#version 430\nuniform usampler1D texTable;\nuniform int blockId;\n\
    // rust: /* RENDERTARGETS: 0 */\nlayout(location = 0) out vec4 color;\n\
    // rust: void main() { color = vec4(texelFetch(texTable, blockId % 64, 0).r); }\n";
    // rust: let vsh = "#version 430\nout vec2 uv;\nvoid main() { uv = vec2(0.0); gl_Position = ftransform(); }\n";
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "table.zip",
    // rust: crate::pack::tests::zip(&[
    // rust: ("shaders/shaders.properties", properties),
    // rust: ("shaders/setup.csh", csh),
    // rust: ("shaders/composite.vsh", vsh),
    // rust: ("shaders/composite.fsh", fsh),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = Macros::standard();
    // rust: let (properties, notes) = crate::read_properties(&pack, &mut macros);
    // rust: assert!(notes.is_empty(), "{notes:?}");
    // rust: let post = load_post(&pack, "", &properties, &macros, &GameInputs::default());
    // rust: assert!(post.notes.is_empty(), "{:?}", post.notes);
    // rust: assert_eq!(post.images.len(), 1);
    // rust: assert!(post.images[0].is_1d());
    // rust: let composite = post
    // rust: .programs
    // rust: .iter()
    // rust: .find(|p| p.name == "composite")
    // rust: .unwrap();
    // rust: let program = composite.program.as_ref().unwrap();
    // rust: let sampler = program
    // rust: .interface
    // rust: .samplers
    // rust: .iter()
    // rust: .find(|s| s.name == "texTable")
    // rust: .unwrap();
    // rust: assert_eq!(sampler.ty, "usampler1D");
}

    // A storage buffer declared smaller than the block a stage binds it as: the block's size
    // as the stage lays it out is what the buffer needs (std430 rounds a block to its
    // largest member's alignment), the most of every stage and program that binds it.
storage_buffers_need_their_blocks_size :: proc() {
}
    // rust: let compute = "#version 430\nlayout(local_size_x = 1) in;\n\
    // rust: layout(std430, binding = 0) buffer Sums { vec4 a; vec4 b; float c; } sums;\n\
    // rust: layout(std430, binding = 1) buffer Cells { uint count; uvec4 cells[3]; } grid;\n\
    // rust: void main() {\n    sums.c = sums.a.x + float(grid.count + grid.cells[0].x);\n}\n";
    // rust: let fsh = "#version 430\nlayout(std430, binding = 0) buffer Sums { vec4 a; } sums;\n\
    // rust: uniform sampler2D colortex0;\nvarying vec2 uv;\n\
    // rust: void main() {\n/* DRAWBUFFERS:3 */\n\
    // rust: gl_FragData[0] = texture2D(colortex0, uv) + sums.a;\n}\n";
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "t",
    // rust: zip(&[
    // rust: ("shaders/composite.vsh", VSH),
    // rust: ("shaders/composite.fsh", fsh),
    // rust: ("shaders/composite.csh", compute),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let macros = Macros::standard();
    // rust: let properties = Properties::parse("bufferObject.0 = 40\nbufferObject.1 = 4\n", &macros);
    // rust: let post = load_post(&pack, "", &properties, &macros, &GameInputs::default());
    // rust: assert!(post.notes.is_empty(), "{:?}", post.notes);
    // rust: assert_eq!(post.programs[0].compute.len(), 1);
        // `Sums`: 36 bytes rounded to vec4's 16; `Cells`: a uint padded to the array's 16,
        // then three elements.
    // rust: assert_eq!(
    // rust: post.buffer_minimums(),
    // rust: std::collections::BTreeMap::from([(0, 48), (1, 64)])
    // rust: );
}

buffer_sizes_are_bounded :: proc() {
}
    // rust: let relative = BufferSize::parse("0.5 0.25").unwrap();
    // rust: assert_eq!(relative.resolve([1920, 1080]), [960, 270]);
    // rust: assert_eq!(
    // rust: BufferSize::parse("1e30 1.0").unwrap().resolve([1920, 1080])[0],
    // rust: BufferSize::MAX
    // rust: );
    // rust: assert_eq!(BufferSize::parse("inf 1.0"), None);
    // rust: assert_eq!(BufferSize::parse("-0.5 1.0"), None);
    // rust: assert_eq!(
    // rust: BufferSize::parse("100000 0").unwrap().resolve([1, 1]),
    // rust: [BufferSize::MAX, 1]
    // rust: );
}

    // `blend.<program>` blends every buffer a composite-style program writes, while
    // `blend.<program>.<buffer>` does not apply to them (Iris 1.11.7, probed: a buffer's `off`
    // under a program blend still blends, and a buffer's factors alone do not).
composite_programs_blend_as_their_program_says :: proc() {
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "t",
    // rust: zip(&[
    // rust: ("shaders/deferred.vsh", VSH),
    // rust: ("shaders/deferred.fsh", FSH),
    // rust: ("shaders/composite.vsh", VSH),
    // rust: ("shaders/composite.fsh", FSH),
    // rust: ("shaders/composite1.vsh", VSH),
    // rust: ("shaders/composite1.fsh", FSH),
    // rust: ("shaders/composite2.vsh", VSH),
    // rust: ("shaders/composite2.fsh", FSH),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let properties = Properties::parse(
    // rust: "blend.deferred = ONE ONE ZERO ONE
    // rust: blend.composite = SRC_ALPHA ONE_MINUS_SRC_ALPHA ONE ZERO
    // rust: \
    // rust: blend.composite.colortex3 = off
    // rust: blend.composite1.colortex3 = ONE ONE ONE ONE
    // rust: \
    // rust: blend.composite2 = off
    // rust: ",
    // rust: &Macros::default(),
    // rust: );
    // rust: let post = load_post(
    // rust: &pack,
    // rust: "",
    // rust: &properties,
    // rust: &Macros::standard(),
    // rust: &GameInputs::default(),
    // rust: );
//         use Factor::*;
    // rust: let blends: Vec<(&str, Option<Blend>, usize)> = post
    // rust: .programs
    // rust: .iter()
    // rust: .map(|p| (p.name.as_str(), p.blend, p.buffer_blends.len()))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: blends,
    // rust: [
    // rust: ("deferred", Some([One, One, Zero, One]), 0),
    // rust: (
    // rust: "composite",
    // rust: Some([SrcAlpha, OneMinusSrcAlpha, One, Zero]),
    // rust: 0
    // rust: ),
    // rust: ("composite1", None, 0),
    // rust: ("composite2", None, 0),
    // rust: ]
    // rust: );
}

programs_load_in_order_with_their_settings :: proc() {
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "t",
    // rust: zip(&[
    // rust: ("shaders/composite.vsh", VSH),
    // rust: ("shaders/composite.fsh", FSH),
    // rust: ("shaders/composite2.vsh", VSH),
    // rust: ("shaders/composite2.fsh", FSH),
    // rust: ("shaders/deferred.vsh", VSH),
    // rust: (
    // rust: "shaders/deferred.fsh",
    // rust: "#version 120\nconst bool colortex5MipmapEnabled = true;\n\
    // rust: void main() { gl_FragColor = vec4(1.0); }\n",
    // rust: ),
    // rust: ("shaders/composite1.fsh", FSH),
    // rust: ("shaders/composite3.vsh", VSH),
    // rust: ("shaders/composite3.fsh", FSH),
    // rust: ("shaders/composite4.vsh", VSH),
    // rust: ("shaders/composite4.fsh", FSH),
    // rust: ("shaders/composite4.gsh", "x"),
    // rust: ("shaders/composite5.vsh", VSH),
    // rust: (
    // rust: "shaders/composite5.fsh",
    // rust: "#version 120\nvoid main() { undefined(); }\n",
    // rust: ),
    // rust: ("shaders/final.vsh", VSH),
    // rust: ("shaders/final.fsh", FSH),
    // rust: ("shaders/world-1/final.vsh", VSH),
    // rust: ("shaders/world-1/final.fsh", FSH),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let properties = Properties::parse(
    // rust: "program.composite3.enabled = HQ && !LOW\nflip.composite2.gaux1=true\n\
    // rust: flip.composite.colortex3 = false\nflip.composite_pre.colortex1=true\n",
    // rust: &Macros::default(),
    // rust: );
    // rust: assert_eq!(dimension_folder(&pack, 0), "");
    // rust: assert_eq!(dimension_folder(&pack, -1), "world-1");
    // rust: let post = load_post(
    // rust: &pack,
    // rust: "",
    // rust: &properties,
    // rust: &Macros::standard(),
    // rust: &GameInputs::default(),
    // rust: );
    // rust: let names: Vec<&str> = post.programs.iter().map(|p| p.name.as_str()).collect();
    // rust: assert_eq!(names, ["deferred", "composite", "composite2", "final"]);
    // rust: let p = &post.programs;
    // rust: assert_eq!(p[0].buffers, [0]);
    // rust: assert_eq!((p[0].mipmaps, p[1].mipmaps), (1 << 5, 0));
    // rust: assert_eq!(p[1].buffers, [3]);
    // rust: assert_eq!(p[1].flips, [(3, false)]);
    // rust: assert_eq!(p[2].flips, [(4, true)]);
    // rust: assert_eq!(post.composite_pre, [(1, true)]);
    // rust: assert_eq!(p[3].group, Group::Final);
    // rust: let notes = post.notes.join("\n");
    // rust: assert!(
    // rust: notes.contains(
    // rust: "composite4: uses a geometry stage (supported for the shadow pass's terrain and entities only)"
    // rust: ),
    // rust: "{notes}"
    // rust: );
    // rust: assert!(notes.contains("composite5.fsh:2:"), "{notes}");
    // rust: assert!(notes.contains("composite5: skipped"), "{notes}");

    // rust: let mut macros = Macros::standard();
    // rust: macros.define("HQ", "");
    // rust: let post = load_post(
    // rust: &pack,
    // rust: "world-1",
    // rust: &properties,
    // rust: &macros,
    // rust: &GameInputs::default(),
    // rust: );
    // rust: let names: Vec<&str> = post.programs.iter().map(|p| p.name.as_str()).collect();
    // rust: assert_eq!(names, ["final"]);
    // rust: let post = load_post(&pack, "", &properties, &macros, &GameInputs::default());
    // rust: assert!(post.programs.iter().any(|p| p.name == "composite3"));
}

scale_keys_give_composite_style_programs_a_viewport :: proc() {
}
    // rust: let names = [
    // rust: "deferred",
    // rust: "composite",
    // rust: "composite1",
    // rust: "composite2",
    // rust: "composite3",
    // rust: "final",
    // rust: ];
    // rust: let files: Vec<(String, &str)> = names
    // rust: .iter()
    // rust: .flat_map(|n| {
    // rust: [
    // rust: (format!("shaders/{n}.vsh"), VSH),
    // rust: (format!("shaders/{n}.fsh"), FSH),
    // rust: ]
    // rust: })
    // rust: .collect();
    // rust: let files: Vec<(&str, &str)> = files.iter().map(|(n, t)| (n.as_str(), *t)).collect();
    // rust: let pack = Pack::from_zip_bytes("t", zip(&files)).unwrap();
    // rust: let properties = Properties::parse(
    // rust: "scale.deferred = 0.5\nscale.composite = 0.25 0.5 0.25\nscale.composite1 = 2\n\
    // rust: scale.composite2 = 0.5 0.5\nscale.final = 0.5\n",
    // rust: &Macros::default(),
    // rust: );
    // rust: let post = load_post(
    // rust: &pack,
    // rust: "",
    // rust: &properties,
    // rust: &Macros::standard(),
    // rust: &GameInputs::default(),
    // rust: );
    // rust: let scales: Vec<(&str, [f32; 3])> = post
    // rust: .programs
    // rust: .iter()
    // rust: .map(|p| (p.name.as_str(), p.scale))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: scales,
    // rust: [
    // rust: ("deferred", [0.5, 0.0, 0.0]),
    // rust: ("composite", [0.25, 0.5, 0.25]),
                // Not a scale, an offset missing, a program that draws the screen: all of it.
    // rust: ("composite1", FULL),
    // rust: ("composite2", FULL),
    // rust: ("composite3", FULL),
    // rust: ("final", FULL),
    // rust: ]
    // rust: );
}

image_declarations_get_their_format_once :: proc() {
}
    // rust: let csh = |decl: &str| {
    // rust: format!(
    // rust: "#version 430\nlayout(local_size_x = 1) in;\n{decl}\nvoid main() {{ imageStore(voxels, ivec3(0), uvec4(1u)); }}\n"
    // rust: )
}
    // rust: let bare = csh("writeonly uniform uimage3D voxels;");
    // rust: let split = csh("layout(r32ui)\nwriteonly uniform uimage3D voxels;");
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "P.zip",
    // rust: zip(&[
    // rust: ("shaders/composite.vsh", VSH),
    // rust: (
    // rust: "shaders/composite.fsh",
    // rust: "#version 120\nvoid main() { gl_FragColor = vec4(1.0); }\n",
    // rust: ),
    // rust: ("shaders/composite.csh", &bare),
    // rust: ("shaders/composite_a.csh", &split),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let properties = Properties::parse(
    // rust: "image.voxels = none RED_INTEGER R32UI UNSIGNED_INT false false 4 4 4\n",
    // rust: &Macros::standard(),
    // rust: );
    // rust: let post = load_post(
    // rust: &pack,
    // rust: "",
    // rust: &properties,
    // rust: &Macros::standard(),
    // rust: &GameInputs::default(),
    // rust: );
    // rust: let compute: Vec<&str> = post.programs[0]
    // rust: .compute
    // rust: .iter()
    // rust: .map(|c| c.0.as_str())
    // rust: .collect();
    // rust: assert_eq!(compute, ["composite", "composite_a"], "{:?}", post.notes);
}

    // Without RENDERTARGETS or DRAWBUFFERS, a program writes colortex0 only, whatever outputs it
    // assigns, while the shadow program's outputs 0 and 1 still write shadowcolor0 and 1. The
    // programs are those of probe pack p8107 run in Iris 1.11.7 (the PR has the readings).
a_program_without_a_directive_writes_buffer_0_only :: proc() {
}
    // rust: let full = "#version 120\nvarying vec2 uv;\nvoid main() {\n\
    // rust: gl_Position = ftransform();\nuv = gl_MultiTexCoord0.xy;\n}\n";
    // rust: let deferred = "#version 120\nuniform sampler2D colortex0;\nvarying vec2 uv;\nvoid main() {\n\
    // rust: gl_FragData[0] = texture2D(colortex0, uv);\n\
    // rust: gl_FragData[3] = vec4(1.1875);\ngl_FragData[7] = vec4(1.4375);\n}\n";
    // rust: let composite = "#version 330 compatibility\nuniform sampler2D colortex0;\nin vec2 uv;\n\
    // rust: void main() {\ngl_FragData[0] = texture(colortex0, uv);\n\
    // rust: gl_FragData[4] = vec4(2.25);\ngl_FragData[5] = vec4(2.3125);\n}\n";
    // rust: let composite1 = "#version 330 compatibility\nuniform sampler2D colortex0;\nin vec2 uv;\n\
    // rust: layout(location = 0) out vec4 o0;\nlayout(location = 2) out vec4 o2;\n\
    // rust: void main() {\no0 = texture(colortex0, uv);\no2 = vec4(3.125);\n}\n";
    // rust: let composite3 = "#version 330 compatibility\nuniform sampler2D colortex0;\nin vec2 uv;\n\
    // rust: /* RENDERTARGETS: 0,12 */\nvoid main() {\n\
    // rust: gl_FragData[0] = texture(colortex0, uv);\ngl_FragData[1] = vec4(6.5);\n}\n";
    // rust: let terrain_vsh = "#version 120\nvarying vec2 texcoord;\nvarying vec4 color;\nvoid main() {\n\
    // rust: gl_Position = ftransform();\n\
    // rust: texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;\ncolor = gl_Color;\n}\n";
    // rust: let terrain = "#version 120\nuniform sampler2D texture;\nvarying vec2 texcoord;\n\
    // rust: varying vec4 color;\nvoid main() {\n\
    // rust: vec4 c = texture2D(texture, texcoord) * color;\nif (c.a < 0.1) discard;\n\
    // rust: gl_FragData[0] = c;\ngl_FragData[6] = vec4(5.0);\n}\n";
    // rust: let shadow_vsh = "#version 120\nvoid main() {\ngl_Position = ftransform();\n}\n";
    // rust: let shadow = "#version 120\nvoid main() {\n\
    // rust: gl_FragData[0] = vec4(0.25);\ngl_FragData[1] = vec4(0.5);\n}\n";
    // rust: let prepare = "#version 120\nvoid main() {\n\
    // rust: gl_FragData[0] = vec4(0.375);\ngl_FragData[2] = vec4(8.5);\n}\n";
    // rust: let shadowcomp = "#version 120\nvoid main() {\n\
    // rust: gl_FragData[0] = vec4(0.75);\ngl_FragData[1] = vec4(0.875);\n}\n";
    // rust: let reads_shadow = "#version 120\nuniform sampler2D shadowcolor1;\nvarying vec2 uv;\n\
    // rust: void main() { gl_FragColor = texture2D(shadowcolor1, uv); }\n";
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "t",
    // rust: zip(&[
    // rust: ("shaders/deferred.vsh", full),
    // rust: ("shaders/deferred.fsh", deferred),
    // rust: ("shaders/composite.vsh", full),
    // rust: ("shaders/composite.fsh", composite),
    // rust: ("shaders/composite1.vsh", full),
    // rust: ("shaders/composite1.fsh", composite1),
    // rust: ("shaders/composite3.vsh", full),
    // rust: ("shaders/composite3.fsh", composite3),
    // rust: ("shaders/gbuffers_terrain.vsh", terrain_vsh),
    // rust: ("shaders/gbuffers_terrain.fsh", terrain),
    // rust: ("shaders/shadow.vsh", shadow_vsh),
    // rust: ("shaders/shadow.fsh", shadow),
    // rust: ("shaders/prepare.vsh", full),
    // rust: ("shaders/prepare.fsh", prepare),
    // rust: ("shaders/shadowcomp.vsh", full),
    // rust: ("shaders/shadowcomp.fsh", shadowcomp),
    // rust: ("shaders/final.vsh", full),
    // rust: ("shaders/final.fsh", reads_shadow),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let game = crate::GbuffersInputs {
    // rust: declarations: "layout(location = 0) in vec3 hz_v_pos;".into(),
    // rust: body: "    hz_Vertex = vec4(hz_v_pos, 1.0);\n    hz_Color = vec4(1.0);\n".into(),
    // rust: ..Default::default()
}
    // rust: let inputs = GameInputs {
    // rust: terrain: Some(game.clone()),
    // rust: entities: Some(game),
    // rust: ..Default::default()
}
    // rust: let post = load_post(
    // rust: &pack,
    // rust: "",
    // rust: &Properties::default(),
    // rust: &Macros::standard(),
    // rust: &inputs,
    // rust: );
    // rust: let written: Vec<(&str, &[u32])> = (post.programs.iter())
    // rust: .chain(&post.terrain)
    // rust: .chain(&post.shadow)
    // rust: .chain(&post.shadow_comp)
    // rust: .map(|p| (p.name.as_str(), &p.buffers[..]))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: written,
    // rust: [
    // rust: ("prepare", &[0][..]),
    // rust: ("deferred", &[0]),
    // rust: ("composite", &[0]),
    // rust: ("composite1", &[0]),
    // rust: ("composite3", &[0, 12]),
    // rust: ("final", &[0]),
    // rust: ("gbuffers_terrain", &[0]),
    // rust: ("shadow", &[0, 1]),
    // rust: ("shadowcomp", &[0, 1]),
    // rust: ],
    // rust: "{:?}",
    // rust: post.notes
    // rust: );
}

    // The shadow pass runs when a program reads a shadow buffer or `shadow.enabled` says so;
    // then `shadow`, `shadow_water` and the `shadowcomp` series load, writing shadowcolor0/1.
shadow_programs_load_when_a_shadow_buffer_is_read :: proc() {
}
    // rust: let reads = "#version 120\nuniform sampler2D shadowtex0;\nvarying vec2 uv;\n\
    // rust: void main() { gl_FragColor = texture2D(shadowtex0, uv); }\n";
    // rust: let shadow = "#version 120\nvarying vec2 uv;\nvoid main() {\n/* RENDERTARGETS: 1,0,4 */\n\
    // rust: gl_FragData[0] = vec4(1.0); gl_FragData[1] = vec4(0.5); gl_FragData[2] = vec4(0.0);\n}\n";
    // rust: let files = [
    // rust: ("shaders/composite.vsh", VSH),
    // rust: ("shaders/composite.fsh", reads),
    // rust: ("shaders/shadow.vsh", VSH),
    // rust: ("shaders/shadow.fsh", shadow),
    // rust: ("shaders/shadowcomp1.vsh", VSH),
    // rust: ("shaders/shadowcomp1.fsh", FSH),
    // rust: ("shaders/shadow_block.vsh", VSH),
    // rust: ("shaders/shadow_block.fsh", FSH),
    // rust: ];
    // rust: let pack = Pack::from_zip_bytes("t", zip(&files)).unwrap();
    // rust: let game = crate::GbuffersInputs {
    // rust: declarations: "layout(location = 0) in vec3 hz_v_pos;".into(),
    // rust: body: "    hz_Vertex = vec4(hz_v_pos, 1.0);\n".into(),
    // rust: ..Default::default()
}
    // rust: let inputs = GameInputs {
    // rust: terrain: Some(game.clone()),
    // rust: entities: Some(game),
    // rust: ..Default::default()
}
    // rust: let load = |properties: &str| {
    // rust: let properties = Properties::parse(properties, &Macros::default());
    // rust: load_post(&pack, "", &properties, &Macros::standard(), &inputs)
}
    // rust: let post = load("");
    // rust: assert!(post.shadow_pass);
    // rust: let shadow = post.shadow.as_ref().expect("shadow");
    // rust: assert_eq!(
    // rust: (shadow.group, &shadow.buffers[..]),
    // rust: (Group::Shadow, &[1, 0][..])
    // rust: );
        // shadow_water falls back to shadow.
    // rust: assert_eq!(
    // rust: post.shadow_water.as_ref().map(|p| p.name.as_str()),
    // rust: Some("shadow")
    // rust: );
        // Entities fall back to shadow; block entities have their own program.
    // rust: let name = |p: &Option<PostProgram>| p.as_ref().map(|p| p.name.clone());
    // rust: assert_eq!(
    // rust: (name(&post.shadow_entities), name(&post.shadow_block)),
    // rust: (Some("shadow".into()), Some("shadow_block".into()))
    // rust: );
    // rust: let off = load("shadowEntities=false\nshadowBlockEntities = false");
    // rust: assert!(
    // rust: off.shadow.is_some() && off.shadow_entities.is_none() && off.shadow_block.is_none()
    // rust: );
        // shadowPlayer and shadowLightBlockEntities keep a part of each.
    // rust: let some = load(
    // rust: "shadowEntities=false\nshadowPlayer=true\nshadowBlockEntities=false\nshadowLightBlockEntities=true",
    // rust: );
    // rust: assert!(some.shadow_entities.is_some() && some.shadow_only_player);
    // rust: assert!(some.shadow_block.is_some() && some.shadow_only_lit_blocks);
    // rust: assert!(!post.shadow_only_player && !post.shadow_only_lit_blocks);
    // rust: let comp: Vec<_> = post
    // rust: .shadow_comp
    // rust: .iter()
    // rust: .map(|p| (p.name.as_str(), p.group))
    // rust: .collect();
    // rust: assert_eq!(comp, [("shadowcomp1", Group::ShadowComp)]);
        // DRAWBUFFERS:3 names no shadowcolor buffer.
    // rust: assert!(post.shadow_comp[0].buffers.is_empty());
    // rust: let post = load("shadow.enabled = false");
    // rust: assert!(!post.shadow_pass && post.shadow.is_none() && post.shadow_comp.is_empty());
        // Nothing reads a shadow buffer.
    // rust: let pack = Pack::from_zip_bytes("t", zip(&files[2..])).unwrap();
    // rust: let none = |properties: &str| {
    // rust: let properties = Properties::parse(properties, &Macros::default());
    // rust: load_post(&pack, "", &properties, &Macros::standard(), &inputs)
}
    // rust: assert!(!none("").shadow_pass);
    // rust: assert!(none("shadow.enabled=true").shadow.is_some());
    // rust: let post = none("shadow.enabled=true\nshadowTranslucent=false");
    // rust: assert!(post.shadow.is_some() && post.shadow_water.is_none());
}

    // `HIGHER_SHADOWCOLOR` (required or optional) gives the shadow programs shadowcolor2 to 7,
    // with their own settings; a directive reaches them, no directive still writes 0 and 1.
    // Without the feature, outputs stop at shadowcolor1 as before. As in Iris 1.11.7 with
    // probe packs p7951a to c (the PR has the readings).
higher_shadowcolor_gives_shadow_programs_eight_buffers :: proc() {
}
    // rust: let shadow_vsh = "#version 120\nvoid main() {\ngl_Position = ftransform();\n}\n";
    // rust: let writes = |targets: Option<&str>| {
    // rust: let directive =
    // rust: targets.map_or(String::new(), |t| format!("/* RENDERTARGETS: {t} */\n"));
    // rust: format!(
    // rust: "#version 120\nconst vec4 shadowcolor5ClearColor = vec4(0.3, 0.4, 0.5, 0.6);\n\
    // rust: /* const int shadowcolor6Format = RGBA32F; */\n{directive}void main() {{\n\
    // rust: gl_FragData[0] = vec4(0.0625);\ngl_FragData[1] = vec4(0.125);\n\
    // rust: gl_FragData[2] = vec4(0.1875);\ngl_FragData[3] = vec4(0.25);\n\
    // rust: gl_FragData[4] = vec4(0.3125);\n}}\n"
    // rust: )
}
    // rust: let full = "#version 120\nvarying vec2 uv;\nvoid main() {\n\
    // rust: gl_Position = ftransform();\nuv = gl_MultiTexCoord0.xy;\n}\n";
    // rust: let shadowcomp = "#version 120\n/* RENDERTARGETS: 7 */\n\
    // rust: void main() {\ngl_FragData[0] = vec4(0.9375);\n}\n";
    // rust: let reads = "#version 120\nuniform sampler2D shadowcolor7;\nvarying vec2 uv;\n\
    // rust: void main() { gl_FragColor = texture2D(shadowcolor7, uv); }\n";
    // rust: let game = crate::GbuffersInputs {
    // rust: declarations: "layout(location = 0) in vec3 hz_v_pos;".into(),
    // rust: body: "    hz_Vertex = vec4(hz_v_pos, 1.0);\n".into(),
    // rust: ..Default::default()
}
    // rust: let inputs = GameInputs {
    // rust: terrain: Some(game.clone()),
    // rust: entities: Some(game),
    // rust: ..Default::default()
}
    // rust: let load = |properties: &str, targets: Option<&str>| {
    // rust: let shadow = writes(targets);
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "t",
    // rust: zip(&[
    // rust: ("shaders/shadow.vsh", shadow_vsh),
    // rust: ("shaders/shadow.fsh", &shadow),
    // rust: ("shaders/shadowcomp.vsh", full),
    // rust: ("shaders/shadowcomp.fsh", shadowcomp),
    // rust: ("shaders/final.vsh", full),
    // rust: ("shaders/final.fsh", reads),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let properties = Properties::parse(properties, &Macros::default());
    // rust: load_post(&pack, "", &properties, &Macros::standard(), &inputs)
}
    // rust: let buffers = |post: &Post| {
    // rust: let shadow = post.shadow.as_ref().map(|p| p.buffers.clone());
    // rust: let comp: Vec<_> = post.shadow_comp.iter().map(|p| p.buffers.clone()).collect();
    // rust: (post.shadow_colors, shadow, comp)
}
    // rust: let required = "iris.features.required = HIGHER_SHADOWCOLOR\n";
    // rust: let post = load(required, Some("0,1,2,3,4"));
        // Reading shadowcolor7 alone turns the shadow pass on.
    // rust: assert!(post.shadow_pass, "{:?}", post.notes);
    // rust: assert_eq!(
    // rust: buffers(&post),
    // rust: (8, Some(vec![0, 1, 2, 3, 4]), vec![vec![7]])
    // rust: );
    // rust: let s = &post.config.shadow;
    // rust: assert_eq!(s.colors[5].clear_color, Some([0.3, 0.4, 0.5, 0.6]));
    // rust: assert_eq!(s.colors[6].format, crate::Format::parse("RGBA32F").unwrap());
    // rust: assert_eq!(s.colors[7].clear_color, Some([1.0; 4]));
    // rust: let optional = "iris.features.optional = HIGHER_SHADOWCOLOR\n";
    // rust: let post = load(optional, Some("0,1,2,3,4"));
    // rust: assert_eq!(buffers(&post).1, Some(vec![0, 1, 2, 3, 4]));
        // Iris 1.11.7 takes the name in any case (#8996, a probe pack of our own).
    // rust: let post = load(
    // rust: "iris.features.optional = higher_shadowcolor\n",
    // rust: Some("0,1,2,3,4"),
    // rust: );
    // rust: assert_eq!(buffers(&post).1, Some(vec![0, 1, 2, 3, 4]));
        // No directive: shadowcolor0 and 1, as without the feature.
    // rust: let post = load(required, None);
    // rust: assert_eq!(buffers(&post).1, Some(vec![0, 1]));
        // Without the feature: two buffers; shadowcolor7 doesn't turn the shadow pass on, and
        // with it forced on, RENDERTARGETS: 7 writes nothing.
    // rust: let post = load("", Some("0,1,2,3,4"));
    // rust: assert!(!post.shadow_pass);
    // rust: let post = load("shadow.enabled = true\n", Some("0,1,2,3,4"));
    // rust: assert_eq!(buffers(&post), (2, Some(vec![0, 1]), vec![vec![]]));
}

    // A shadow program with a geometry stage draws terrain, entities and block entities, each
    // read vertex by vertex as the game says; a draw whose vertices can't be read so skips it.
a_shadow_geometry_stage_draws_entities_and_block_entities :: proc() {
}
    // rust: let reads = "#version 120\nuniform sampler2D shadowtex0;\nvarying vec2 uv;\n\
    // rust: void main() { gl_FragColor = texture2D(shadowtex0, uv); }\n";
    // rust: let vsh = "#version 330\nout vec2 vUv;\nvoid main() { gl_Position = ftransform(); vUv = vec2(0.0); }\n";
    // rust: let gsh = "#version 330\nlayout(triangles) in;\nlayout(triangle_strip, max_vertices = 3) out;\n\
    // rust: in vec2 vUv[];\nout vec2 gUv;\nvoid main() {\n    for (int i = 0; i < 3; i++) {\n        \
    // rust: gl_Position = gl_in[i].gl_Position;\n        gUv = vUv[i];\n        EmitVertex();\n    }\n    \
    // rust: EndPrimitive();\n}\n";
    // rust: let fsh = "#version 330\nin vec2 gUv;\nlayout(location = 0) out vec4 c;\nvoid main() { c = vec4(gUv, 0.0, 1.0); }\n";
    // rust: let files = [
    // rust: ("shaders/composite.vsh", VSH),
    // rust: ("shaders/composite.fsh", reads),
    // rust: ("shaders/shadow.vsh", vsh),
    // rust: ("shaders/shadow.gsh", gsh),
    // rust: ("shaders/shadow.fsh", fsh),
    // rust: ];
    // rust: let pack = Pack::from_zip_bytes("t", zip(&files)).unwrap();
    // rust: let game = crate::GbuffersInputs {
    // rust: declarations: "layout(location = 0) in vec3 hz_v_pos;\n\
    // rust: layout(set = 1, binding = 0) readonly buffer V { uint v[]; };\n"
    // rust: .into(),
    // rust: body: "    hz_Vertex = vec4(hz_v_pos, 1.0);\n".into(),
    // rust: ..Default::default()
}
    // rust: let geometry = crate::GeometryInputs {
    // rust: inputs: game.clone(),
    // rust: pull: "        hz_v_pos = uintBitsToFloat(uvec3(v[hz_vertex_index], v[hz_vertex_index], v[hz_vertex_index]));\n"
    // rust: .into(),
    // rust: index: "uint(@)".into(),
}
    // rust: let mut inputs = GameInputs {
    // rust: terrain: Some(game.clone()),
    // rust: entities: Some(game),
    // rust: terrain_geometry: Some(geometry.clone()),
    // rust: entity_geometry: Some(geometry),
    // rust: ..Default::default()
}
    // rust: let load = |inputs: &GameInputs| {
    // rust: load_post(
    // rust: &pack,
    // rust: "",
    // rust: &Properties::default(),
    // rust: &Macros::standard(),
    // rust: inputs,
    // rust: )
}
    // rust: let post = load(&inputs);
    // rust: let triangles = |p: &Option<PostProgram>| p.as_ref().map(|p| p.geometry_triangles);
    // rust: assert_eq!(
    // rust: [&post.shadow, &post.shadow_entities, &post.shadow_block].map(triangles),
    // rust: [Some(1); 3],
    // rust: "{:?}",
    // rust: post.notes
    // rust: );
    // rust: inputs.entity_geometry = None;
    // rust: let post = load(&inputs);
    // rust: assert!(post.shadow.is_some());
    // rust: assert!(post.shadow_entities.is_none() && post.shadow_block.is_none());
    // rust: assert!(
    // rust: post.notes
    // rust: .iter()
    // rust: .any(|n| n.starts_with("shadow: uses a geometry stage")),
    // rust: "{:?}",
    // rust: post.notes
    // rust: );
}

    // Water falls back to the terrain chain and blends by default, as the sky does; entities
    // and block entities fall back along theirs; `blend.*` overrides.
    // `clouds=off` hides the game's clouds and drops the pack's own cloud program.
clouds_off_draws_no_clouds :: proc() {
}
    // rust: let vsh = "#version 120\nvoid main() { gl_Position = ftransform(); }\n";
    // rust: let fsh = "#version 120\nvoid main() { gl_FragColor = vec4(1.0); }\n";
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "clouds.zip",
    // rust: crate::pack::tests::zip(&[
    // rust: ("shaders/gbuffers_clouds.vsh", vsh),
    // rust: ("shaders/gbuffers_clouds.fsh", fsh),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let macros = Macros::standard();
    // rust: let inputs = GameInputs {
    // rust: clouds: Some(crate::GbuffersInputs {
    // rust: declarations: "layout(location = 0) in vec3 hz_v_pos;".into(),
    // rust: body: "    hz_Vertex = vec4(hz_v_pos, 1.0);\n".into(),
    // rust: ..Default::default()
    // rust: }),
    // rust: ..Default::default()
}
    // rust: let on = load_post(&pack, "", &Properties::default(), &macros, &inputs);
    // rust: assert!(on.clouds.is_some() && !on.clouds_off);
    // rust: let off = Properties::parse("clouds = off\n", &macros);
    // rust: let off = load_post(&pack, "", &off, &macros, &inputs);
    // rust: assert!(off.clouds.is_none() && off.clouds_off);
}

rain_depth_follows_live_properties_independently_of_weather_fallback :: proc() {
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "original-weather-depth",
    // rust: crate::pack::tests::zip(&[
    // rust: (
    // rust: "shaders/gbuffers_basic.vsh",
    // rust: "#version 120\nvoid main(){gl_Position=vec4(0.0,0.0,0.0,1.0);}",
    // rust: ),
    // rust: (
    // rust: "shaders/gbuffers_basic.fsh",
    // rust: "#version 120\nvoid main(){gl_FragColor=vec4(1.0);}",
    // rust: ),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let macros = Macros::standard();
    // rust: let inputs = GameInputs {
    // rust: weather: Some(GbuffersInputs::default()),
    // rust: ..Default::default()
}
    // rust: for (text, writes) in [
    // rust: ("rain.depth = true", true),
    // rust: ("rain.depth = false", false),
    // rust: (
    // rust: "#if 0\nrain.depth=true\n#else\nrain.depth = false\n#endif",
    // rust: false,
    // rust: ),
    // rust: ("rain.depth=true\nrain.depth=false", false),
    // rust: ("rain.depth=false\nrain.depth=true", true),
            // These defaults preserve accepted main as a compatibility choice, not a claim
            // about the external default contract, which the permitted packs don't establish.
    // rust: ("", true),
    // rust: ("rain.depth=invalid", true),
    // rust: ] {
    // rust: let properties = Properties::parse(text, &macros);
    // rust: let post = load_post(&pack, "", &properties, &macros, &inputs);
    // rust: assert_eq!(post.rain_depth, writes, "{text:?}");
    // rust: let weather = post.weather.expect("weather fallback loads");
    // rust: assert_eq!(weather.name, "gbuffers_basic");
    // rust: assert_eq!(weather.group, Group::Translucent);
    // rust: assert_eq!(weather.blend, Some(TRANSLUCENT_BLEND));
}
}

    // Without `gbuffers_clouds` the clouds draw with `gbuffers_textured`, else `gbuffers_basic`,
    // blended; a pack with none of them leaves the clouds to the game.
clouds_fall_back_to_textured_then_basic :: proc() {
}
    // rust: let vsh = "#version 120\nvoid main() { gl_Position = ftransform(); }\n";
    // rust: let fsh = "#version 120\nvoid main() { gl_FragColor = vec4(1.0); }\n";
    // rust: let macros = Macros::standard();
    // rust: let inputs = GameInputs {
    // rust: clouds: Some(crate::GbuffersInputs {
    // rust: declarations: "layout(location = 0) in vec3 hz_v_pos;".into(),
    // rust: body: "    hz_Vertex = vec4(hz_v_pos, 1.0);\n".into(),
    // rust: ..Default::default()
    // rust: }),
    // rust: ..Default::default()
}
    // rust: let clouds = |programs: &[&str]| {
    // rust: let files: Vec<(String, &str)> = programs
    // rust: .iter()
    // rust: .flat_map(|p| {
    // rust: [
    // rust: (format!("shaders/{p}.vsh"), vsh),
    // rust: (format!("shaders/{p}.fsh"), fsh),
    // rust: ]
    // rust: })
    // rust: .collect();
    // rust: let files: Vec<(&str, &str)> = files.iter().map(|(n, t)| (n.as_str(), *t)).collect();
    // rust: let pack = Pack::from_zip_bytes("clouds.zip", crate::pack::tests::zip(&files)).unwrap();
    // rust: load_post(&pack, "", &Properties::default(), &macros, &inputs)
    // rust: .clouds
    // rust: .map(|p| (p.name, p.blend))
}
    // rust: let blended = |name: &str| Some((name.to_owned(), Some(TRANSLUCENT_BLEND)));
    // rust: assert_eq!(
    // rust: clouds(&["gbuffers_textured", "gbuffers_basic"]),
    // rust: blended("gbuffers_textured")
    // rust: );
    // rust: assert_eq!(
    // rust: clouds(&["gbuffers_textured_lit", "gbuffers_basic"]),
    // rust: blended("gbuffers_basic")
    // rust: );
    // rust: assert_eq!(
    // rust: clouds(&["gbuffers_clouds", "gbuffers_textured"]),
    // rust: blended("gbuffers_clouds")
    // rust: );
    // rust: assert_eq!(clouds(&["gbuffers_terrain", "composite"]), None);
}

TERRAIN_VSH :: "#version 120\nvoid main() { gl_Position = ftransform(); }\n"
TERRAIN_FSH :: "#version 120\nvoid main() { gl_FragData[0] = vec4(1.0); }\n"

    // The pack of `files` (under `shaders/`), with `properties`, loaded with the game's terrain
    // inputs and, with `parts`, its two parts.
terrain_files :: proc(files: ^[(string) {
}
    // rust: let files: Vec<_> = (files.iter())
    // rust: .map(|(name, source)| (format!("shaders/{name}"), *source))
    // rust: .collect();
    // rust: let files: Vec<_> = files.iter().map(|(n, s)| (n.as_str(), *s)).collect();
    // rust: let pack = Pack::from_zip_bytes("terrain-parts", crate::pack::tests::zip(&files)).unwrap();
    // rust: let inputs = crate::GbuffersInputs {
    // rust: declarations: "layout(location = 0) in vec3 hz_v_pos;".into(),
    // rust: body: "    hz_Vertex = vec4(hz_v_pos, 1.0);\n    hz_Color = vec4(1.0);\n".into(),
    // rust: ..Default::default()
}
    // rust: let inputs = GameInputs {
    // rust: terrain_parts: parts.then(|| [inputs.clone(), inputs.clone()]),
    // rust: terrain: Some(inputs),
    // rust: ..Default::default()
}
    // rust: let macros = Macros::standard();
    // rust: let properties = Properties::parse(properties, &macros);
    // rust: load_post(&pack, "", &properties, &macros, &inputs)
}

    // `terrain_files` with `programs`, each writing white.
terrain_pack :: proc(programs: ^[string], properties: string, parts: bool) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let files: Vec<_> = (programs.iter())
    // rust: .flat_map(|p| {
    // rust: [
    // rust: (format!("{p}.vsh"), TERRAIN_VSH),
    // rust: (format!("{p}.fsh"), TERRAIN_FSH),
    // rust: ]
    // rust: })
    // rust: .collect();
    // rust: terrain_files(&files, properties, parts)
}

    // What draws solid (or all) terrain and what draws cutout terrain.
terrain_names :: proc(programs: ^[string], properties: string, parts: bool) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let post = terrain_pack(programs, properties, parts);
    // rust: [post.terrain, post.terrain_cutout].map(|p| p.map(|p| p.name))
}

    // rust: const TERRAIN_PROGRAMS: [&str; 3] = [
    // rust: "gbuffers_terrain",
    // rust: "gbuffers_terrain_solid",
    // rust: "gbuffers_terrain_cutout",
    // rust: ];

    // Iris 1.11.7 with our probe packs (#9137): `gbuffers_terrain_solid` draws solid terrain
    // and `gbuffers_terrain_cutout` cutout terrain, each falling back to `gbuffers_terrain`;
    // a pack with only `gbuffers_terrain` draws both parts with it, each with its own alpha
    // test (#9307).
terrain_solid_and_cutout_fall_back_to_terrain :: proc() {
}
    // rust: let names = |programs: &[&str], parts: bool| terrain_names(programs, "", parts);
    // rust: let some = |name: &str| Some(name.to_owned());
    // rust: let [terrain, solid, cutout] = TERRAIN_PROGRAMS;
    // rust: assert_eq!(
    // rust: names(&[terrain, solid, cutout], true),
    // rust: [some(solid), some(cutout)]
    // rust: );
    // rust: assert_eq!(names(&[terrain, solid], true), [some(solid), some(terrain)]);
    // rust: assert_eq!(
    // rust: names(&[terrain, cutout], true),
    // rust: [some(terrain), some(cutout)]
    // rust: );
    // rust: assert_eq!(names(&[terrain], true), [some(terrain), some(terrain)]);
        // Without the game's two parts, terrain draws whole.
    // rust: assert_eq!(
    // rust: names(&[terrain, solid, cutout], false),
    // rust: [some(terrain), None]
    // rust: );
}

    // A pack whose only terrain program is `gbuffers_terrain_solid` (or `_cutout`) has nothing
    // for the other part: that part draws alone, and nothing draws the other, as Iris 1.11.7
    // did with our probes `tsc-solidonly` and `tsc-cutoutonly`.
a_lone_split_program_draws_only_its_part :: proc() {
}
    // rust: let [_, solid, cutout] = TERRAIN_PROGRAMS;
    // rust: let some = |name: &str| Some(name.to_owned());
    // rust: assert_eq!(terrain_names(&[solid], "", true), [some(solid), None]);
    // rust: assert_eq!(terrain_names(&[cutout], "", true), [None, some(cutout)]);
    // rust: let post = terrain_pack(&[solid], "", true);
    // rust: let note = "gbuffers_terrain_solid: no program for cutout terrain; nothing draws it";
    // rust: assert!(post.notes.iter().any(|n| n == note), "{:?}", post.notes);
}

    // When the other part has a program that fails to load, the part that loaded doesn't draw
    // alone: the game draws all terrain (#9176's review).
a_split_part_that_fails_to_load_takes_the_other_with_it :: proc() {
}
    // rust: let [_, solid, cutout] = TERRAIN_PROGRAMS;
        // `cutout` with a stage that doesn't translate.
    // rust: let files = [
    // rust: (format!("{solid}.vsh"), TERRAIN_VSH),
    // rust: (format!("{solid}.fsh"), TERRAIN_FSH),
    // rust: (format!("{cutout}.vsh"), TERRAIN_VSH),
    // rust: (
    // rust: format!("{cutout}.fsh"),
    // rust: "void main() { gl_FragData[0] = vec4(1.0) }\n",
    // rust: ),
    // rust: ];
    // rust: let post = terrain_files(&files, "", true);
    // rust: assert!(post.terrain.is_none() && post.terrain_cutout.is_none());
    // rust: let note = "gbuffers_terrain_solid: cutout terrain's program didn't load; the game draws all terrain";
    // rust: assert!(post.notes.iter().any(|n| n == note), "{:?}", post.notes);
}

    // `program.<name>.enabled` turning off the only split program leaves both parts to
    // `gbuffers_terrain`, as for a pack without it: Iris 1.11.7 drew all terrain with
    // `gbuffers_terrain` for our probe `tsc-disabled-false`.
a_disabled_split_program_leaves_terrain_whole :: proc() {
}
    // rust: let [terrain, solid, _] = TERRAIN_PROGRAMS;
    // rust: let off = "program.gbuffers_terrain_solid.enabled = false\n";
    // rust: let some = |name: &str| Some(name.to_owned());
    // rust: assert_eq!(
    // rust: terrain_names(&[terrain, solid], off, true),
    // rust: [some(terrain), some(terrain)]
    // rust: );
    // rust: let on = "program.gbuffers_terrain_solid.enabled = true\n";
    // rust: assert_eq!(
    // rust: terrain_names(&[terrain, solid], on, true),
    // rust: [some(solid), some(terrain)]
    // rust: );
}

    // The cutout part's storage blocks count towards the buffers' sizes, like every other
    // program's.
the_cutout_parts_storage_blocks_size_their_buffers :: proc() {
}
    // rust: let fsh = "#version 430\nlayout(std430, binding = 0) buffer Sums { vec4 a[4]; } sums;\n\
    // rust: void main() {\n/* DRAWBUFFERS:0 */\ngl_FragData[0] = sums.a[3];\n}\n";
    // rust: let files = [
    // rust: ("gbuffers_terrain.vsh".into(), TERRAIN_VSH),
    // rust: ("gbuffers_terrain.fsh".into(), TERRAIN_FSH),
    // rust: ("gbuffers_terrain_cutout.vsh".into(), TERRAIN_VSH),
    // rust: ("gbuffers_terrain_cutout.fsh".into(), fsh),
    // rust: ];
    // rust: let post = terrain_files(&files, "bufferObject.0 = 16\n", true);
    // rust: let cutout = post.terrain_cutout.as_ref().map(|p| p.name.as_str());
    // rust: assert_eq!(cutout, Some("gbuffers_terrain_cutout"), "{:?}", post.notes);
    // rust: assert_eq!(
    // rust: post.buffer_minimums(),
    // rust: std::collections::BTreeMap::from([(0, 64)])
    // rust: );
}

water_falls_back_to_terrain_and_blends :: proc() {
}
    // rust: let dir = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/packs/terrain-test");
    // rust: let pack = Pack::open(&dir).unwrap();
    // rust: let macros = Macros::standard();
    // rust: let inputs = crate::GbuffersInputs {
    // rust: declarations: "layout(location = 0) in vec3 hz_v_pos;".into(),
    // rust: body: "    hz_Vertex = vec4(hz_v_pos, 1.0);\n    hz_Color = vec4(1.0);\n".into(),
    // rust: ..Default::default()
}
    // rust: let inputs = GameInputs {
    // rust: terrain: Some(inputs.clone()),
    // rust: sky: Some(inputs.clone()),
    // rust: celestial: Some(inputs.clone()),
    // rust: entities: Some(inputs.clone()),
    // rust: clouds: Some(inputs.clone()),
    // rust: weather: Some(inputs.clone()),
    // rust: lines: Some(inputs.clone()),
    // rust: hand: Some(inputs),
    // rust: terrain_parts: None,
    // rust: terrain_geometry: None,
    // rust: entity_geometry: None,
}
    // rust: let post = load_post(&pack, "", &Properties::default(), &macros, &inputs);
    // rust: let (terrain, water) = (post.terrain.unwrap(), post.water.unwrap());
    // rust: assert_eq!((terrain.group, terrain.blend), (Group::Gbuffers, None));
    // rust: assert_eq!(water.name, "gbuffers_terrain");
    // rust: let sky = post.sky.unwrap();
    // rust: assert_eq!(
    // rust: (sky.name.as_str(), sky.group, sky.blend),
    // rust: (
    // rust: "gbuffers_skybasic",
    // rust: Group::Gbuffers,
    // rust: Some(TRANSLUCENT_BLEND)
    // rust: )
    // rust: );
        // gbuffers_skytextured falls back to gbuffers_textured, then gbuffers_basic.
    // rust: let sun = post.sky_textured.unwrap();
    // rust: assert_eq!(
    // rust: (sun.name.as_str(), sun.blend),
    // rust: ("gbuffers_textured", Some(CELESTIAL_BLEND))
    // rust: );
    // rust: assert_eq!(
    // rust: (water.group, water.blend),
    // rust: (Group::Translucent, Some(TRANSLUCENT_BLEND))
    // rust: );
        // Entities fall back to gbuffers_textured, block entities to gbuffers_terrain; both
        // draw without blending.
    // rust: let (entities, block) = (post.entities.unwrap(), post.block.unwrap());
    // rust: assert_eq!(
    // rust: (entities.name.as_str(), entities.blend),
    // rust: ("gbuffers_textured", None)
    // rust: );
    // rust: assert_eq!(
    // rust: (block.name.as_str(), block.blend),
    // rust: ("gbuffers_terrain", None)
    // rust: );
        // Translucent entity parts and particles blend; particles draw after deferred unless
        // the pack says otherwise, translucent entities before unless `separateEntityDraws`.
    // rust: let (translucent, particles) = (
    // rust: post.entities_translucent.as_ref().unwrap(),
    // rust: post.particles.as_ref().unwrap(),
    // rust: );
    // rust: assert_eq!(
    // rust: (translucent.name.as_str(), translucent.blend),
    // rust: ("gbuffers_textured", Some(TRANSLUCENT_BLEND))
    // rust: );
    // rust: assert_eq!(particles.blend, Some(TRANSLUCENT_BLEND));
    // rust: assert!(post.particles_late && !post.translucent_late);
        // Clouds fall back to gbuffers_textured, blended.
    // rust: let clouds = post.clouds.as_ref().unwrap();
    // rust: assert_eq!(
    // rust: (clouds.name.as_str(), clouds.blend),
    // rust: ("gbuffers_textured", Some(TRANSLUCENT_BLEND))
    // rust: );
        // The hand falls back to gbuffers_textured and does not blend.
    // rust: let hand = post.hand.as_ref().unwrap();
    // rust: assert_eq!(
    // rust: (hand.name.as_str(), hand.group, hand.blend),
    // rust: ("gbuffers_textured", Group::Gbuffers, None)
    // rust: );
        // Weather falls back to gbuffers_textured, after deferred, blended.
    // rust: let weather = post.weather.as_ref().unwrap();
    // rust: assert_eq!(
    // rust: (weather.name.as_str(), weather.group, weather.blend),
    // rust: (
    // rust: "gbuffers_textured",
    // rust: Group::Translucent,
    // rust: Some(TRANSLUCENT_BLEND)
    // rust: )
    // rust: );
    // rust: let ordering = Properties::parse(
    // rust: "particles.ordering = before\nseparateEntityDraws = true\n",
    // rust: &macros,
    // rust: );
    // rust: let post = load_post(&pack, "", &ordering, &macros, &inputs);
    // rust: assert!(!post.particles_late && post.translucent_late);
    // rust: let properties = Properties::parse(
    // rust: "blend.gbuffers_terrain = ONE ONE ZERO ONE\nblend.gbuffers_water = off\n",
    // rust: &macros,
    // rust: );
    // rust: let terrain_blend = blend(&properties, "gbuffers_terrain");
    // rust: assert_eq!(
    // rust: terrain_blend,
    // rust: Some(Some([Factor::One, Factor::One, Factor::Zero, Factor::One]))
    // rust: );
    // rust: assert_eq!(blend(&properties, "gbuffers_water"), Some(None));
    // rust: assert_eq!(blend(&properties, "gbuffers_basic"), None);
}

formats_come_from_the_fragment_shaders_iris_reads :: proc() {
}
        // Cut down from probe packs p9063a, p9063b and p9063c (ours). Iris 1.11.7: colortex8,
        // declared only in `composite.vsh`, kept RGBA8; colortex12 and colortex6, declared only
        // in `shadow.fsh` and `shadowcomp.fsh` of a pack whose shadow pass Horizon doesn't run,
        // took RGBA16F; colortex1 with `gdepth` declared and no format kept RGBA8. Other
        // settings of those shadow files weren't probed, and Horizon leaves them out.
    // rust: let declare = |n: u32| format!("/*\nconst int colortex{n}Format = RGBA16F;\n*/\n");
    // rust: let write = "#version 120\n/* RENDERTARGETS: 1,6,8,12 */\nvoid main() { gl_FragData[0] = \
    // rust: vec4(2.5); gl_FragData[1] = vec4(2.5); gl_FragData[2] = vec4(2.5); \
    // rust: gl_FragData[3] = vec4(2.5); }\n";
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "original-format-files",
    // rust: zip(&[
    // rust: (
    // rust: "shaders/composite.vsh",
    // rust: format!("{}{VSH}", declare(8)).as_str(),
    // rust: ),
    // rust: ("shaders/composite.fsh", write),
    // rust: ("shaders/shadow.vsh", VSH),
    // rust: (
    // rust: "shaders/shadow.fsh",
    // rust: format!(
    // rust: "{}const bool colortex12Clear = false;\n{write}",
    // rust: declare(12)
    // rust: )
    // rust: .as_str(),
    // rust: ),
    // rust: ("shaders/shadowcomp.vsh", VSH),
    // rust: (
    // rust: "shaders/shadowcomp.fsh",
    // rust: format!("{}{write}", declare(6)).as_str(),
    // rust: ),
    // rust: ("shaders/final.vsh", VSH),
    // rust: (
    // rust: "shaders/final.fsh",
    // rust: "#version 120\nuniform sampler2D gdepth;\nvarying vec2 uv;\n\
    // rust: void main() { gl_FragColor = texture2D(gdepth, uv); }\n",
    // rust: ),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let macros = Macros::standard();
    // rust: let post = load_post(
    // rust: &pack,
    // rust: "",
    // rust: &Properties::default(),
    // rust: &macros,
    // rust: &GameInputs::default(),
    // rust: );
    // rust: assert!(!post.shadow_pass);
    // rust: let half = crate::Format::parse("RGBA16F").unwrap();
    // rust: let formats: Vec<bool> = [1, 6, 8, 12]
    // rust: .iter()
    // rust: .map(|&n| post.config.buffers[n].format == half)
    // rust: .collect();
    // rust: assert_eq!(formats, [false, true, false, true]);
    // rust: assert_eq!(post.config.buffers[1].format, crate::Format::RGBA8);
    // rust: assert!(post.config.buffers[12].clear);
}

horizons_test_pack_loads :: proc() {
}
    // rust: let dir = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/packs/post-test");
    // rust: let pack = Pack::open(&dir).unwrap();
    // rust: let macros = Macros::standard();
    // rust: let properties = Properties::parse(&pack.read_text("shaders.properties").unwrap(), &macros);
    // rust: let post = load_post(
    // rust: &pack,
    // rust: &dimension_folder(&pack, 0),
    // rust: &properties,
    // rust: &macros,
    // rust: &GameInputs::default(),
    // rust: );
    // rust: assert!(post.notes.is_empty(), "{:?}", post.notes);
    // rust: let names: Vec<&str> = post.programs.iter().map(|p| p.name.as_str()).collect();
    // rust: assert_eq!(names, ["composite", "composite1", "final"]);
    // rust: assert_eq!(post.programs[0].buffers, [0, 2]);
    // rust: assert_eq!(post.programs[1].buffers, [0]);
    // rust: assert_eq!(
    // rust: post.config.buffers[2].format,
    // rust: crate::Format::parse("RGBA16F").unwrap()
    // rust: );
}
}

    // rust: mod lifecycle_tests {
//     use super::*;
setup_and_begin_compute_load_before_prepare_even_with_only_a_suffix :: proc() {
}
    // rust: let compute = "#version 430\nlayout(local_size_x=1) in; void main(){}";
    // rust: let zip = crate::pack::tests::zip(&[
    // rust: ("shaders/setup.csh", compute),
    // rust: ("shaders/begin_a.csh", compute),
    // rust: ("shaders/prepare.csh", compute),
    // rust: ]);
    // rust: let pack = Pack::from_zip_bytes("lifecycle.zip", zip).unwrap();
    // rust: let post = load_post(
    // rust: &pack,
    // rust: "",
    // rust: &Properties::default(),
    // rust: &Macros::standard(),
    // rust: &GameInputs::default(),
    // rust: );
    // rust: assert!(post.notes.is_empty(), "{:?}", post.notes);
    // rust: assert_eq!(
    // rust: post.programs
    // rust: .iter()
    // rust: .map(|p| p.name.as_str())
    // rust: .collect::<Vec<_>>(),
    // rust: ["setup", "begin", "prepare"]
    // rust: );
}
}

    // rust: mod buffer_blend_tests {
//     use super::*;
buffer_blends_use_colortex_numbers_and_preserve_explicit_off :: proc() {
}
    // rust: let props = Properties::parse(
    // rust: "blend.gbuffers_water=off\nblend.gbuffers_water.colortex13=ONE ONE_MINUS_SRC_ALPHA ONE ONE_MINUS_SRC_ALPHA\nblend.gbuffers_water.colortex2=off\n",
    // rust: &Macros::standard(),
    // rust: );
    // rust: let overrides = buffer_blends(&props, "gbuffers_water");
    // rust: assert_eq!(blend(&props, "gbuffers_water"), Some(None));
    // rust: assert_eq!(
    // rust: overrides,
    // rust: vec![
    // rust: (
    // rust: 13,
    // rust: Some([
    // rust: Factor::One,
    // rust: Factor::OneMinusSrcAlpha,
    // rust: Factor::One,
    // rust: Factor::OneMinusSrcAlpha
    // rust: ])
    // rust: ),
    // rust: (2, None)
    // rust: ]
    // rust: );
}
}
