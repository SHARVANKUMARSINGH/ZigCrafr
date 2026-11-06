//! Transpiled from Horizon Rust crate
//! Module: horizon-shader-api_manifest
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-shaders.toml`, a shader pack's manifest (schema 1, docs/shaders.md).
// use serde::Deserialize;

/// The manifest's file name at the root of a pack.
pub const MANIFEST: []const u8 = "horizon-shaders.toml";
/// The manifest schema this build reads.
pub const SCHEMA: u32 = 1;
/// The shader API line packs are written for unless they opt into a newer one: what the
/// templates write, and what the game and the registry take.
pub const API: []const u8 = Api::V0_1.as_str();

/// A shader API line: the stages, their signatures and the inputs a pack's WGSL may read.
pub const Api = enum {
    /// Vanilla's gamma values.
    V0_1,
    /// Linear light (docs/design/hdr-linear-light.md). Experimental: checked, not yet drawn.
    V0_2,
};

    // rust: impl Api {
    /// Every line this build reads and checks, oldest first.
pub const SERVED: [Api; 2] = [Api::V0_1, Api::V0_2];

    /// The manifest's `api` value.
    // rust: pub const fn as_str(self) -> &'static str {
    // rust: match self {
    // rust: Api::V0_1 => "0.1",
    // rust: Api::V0_2 => "0.2",
}
}

pub fn parse(line: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::SERVED.into_iter().find(|a| a.as_str() == line)
}
}

    // rust: impl std::fmt::Display for Api {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str(self.as_str())
}
}

/// `[frame] blend` (0.2): what the frame stores, and so how see-through draws blend.
pub const Blend = enum {
    /// Vanilla's gamma, values above 1 kept: Horizon encodes a stage's result before it is
    /// stored and blended.
    Gamma,
    /// Linear light: glass, water and smoke blend as light does.
    Linear,
};
/// Full-screen passes a pack may chain.
pub const MAX_POST_PASSES: usize = 12;
/// Options a pack may declare.
pub const MAX_OPTIONS: usize = 64;
/// Settings pages a pack may declare, and the items one page may hold.
pub const MAX_PAGES: usize = 32;
pub const MAX_PAGE_ITEMS: usize = 64;
/// The most GPU time a pack may declare for itself, in milliseconds.
pub const MAX_GPU_MS: f32 = 16.0;
/// `[[materials]]` entries a manifest may declare.
pub const MAX_MATERIALS: usize = 1024;
/// `[[textures]]` a pack may declare, and the side of the largest.
pub const MAX_TEXTURES: usize = 8;
pub const MAX_TEXTURE_SIZE: u32 = 2048;
/// `[[lights]]` entries a manifest may declare.
pub const MAX_LIGHTS: usize = 256;
/// `[[particle_lights]]` entries a manifest may declare.
pub const MAX_PARTICLE_LIGHTS: usize = 32;
/// Sprite tags a pack may declare: the bits of `MaterialInput.tags`.
pub const MAX_TAGS: usize = 32;

/// A checked manifest.
pub const Manifest = struct {
    /// `[a-z0-9_]{1,64}`: the pack's settings key and registry id.
    id: []const u8,
    name: []const u8,
    version: []const u8,
    /// The API line the pack is written for.
    api: Api,
    description: []const u8,
    authors: std.ArrayList([]const u8),
    license: ?[]const u8,
    /// WGSL files put before every stage's own file, in order.
    shared: std.ArrayList([]const u8),
    sky: ?Stage,
    material: ?Stage,
    /// Where corners of terrain are drawn: needs `material`, and shares its module.
    vertex: ?Stage,
    /// The colour of rain and snow streaks (Minecraft's own when absent).
    weather: ?Stage,
    /// Full-screen passes, in the order they run.
    post: std.ArrayList(Stage),
    /// 0.2: the picture for the display, after the post chain (Horizon's tone curve when absent).
    tonemap: ?Stage,
    /// 0.2: `[frame] blend`.
    blend: Blend,
    options: std.ArrayList(PackOption),
    /// How the settings page lays the options out; the first page is the one it opens on.
    /// Empty: one page with every option.
    pages: std.ArrayList(OptionPage),
    /// Sprite tags the material stage reads, in bit order.
    tags: std.ArrayList(SpriteTag),
    /// Material ids by sprite: the first entry with a matching pattern wins.
    materials: std.ArrayList(Material),
    /// Images every stage reads, in order (`TEXTURE_BINDING` + their index).
    textures: std.ArrayList(PackTexture),
    /// The colour of block light by the block giving it off: the first entry with a matching
    /// pattern wins (`Manifest::light_of`).
    lights: std.ArrayList(LightColor),
    /// Particles that join the frame's coloured lights (`MaterialInput.colored_light`): the first
    /// entry naming a particle wins.
    particle_lights: std.ArrayList(ParticleLight),
    budget: Budget,
    /// When the material stage's water mirror (`reflection`) is drawn.
    reflection: ?Reflection,
    /// The shadow map the material and post stages read, if the pack asks for one.
    shadow: ?Shadow,
    /// Relief as geometry near the camera, if the pack asks for it; needs `[material]`.
    displacement: ?Displacement,
};

/// `[displacement]`: within `distance` of the camera, the faces of solid terrain whose
/// resource pack textures have LabPBR heights are drawn as a grid of `cells` by `cells`, each
/// corner moved along the face's normal by the material stage's
/// `fn displacement(input: DisplacementInput) -> f32`: relief that is geometry, which
/// occludes itself, writes its depth and is lit at its true place.
pub const Displacement = struct {
    /// How far from the camera faces are displaced, in blocks; the relief eases out over the
    /// last quarter.
    distance: f32,
    /// The grid's cells along a face's side (fewer where the textures have fewer texels).
    cells: u32,
    /// The `bool` option that turns it on, if any (else it is always on).
    option: ?[]const u8,
    /// A `choice` option whose values are cell counts, if any: the player's value replaces
    /// `cells`.
    cells_option: ?[]const u8,
    /// A `bool` option, if any: while it is on each cell is a flat step with walls, the
    /// height map's texels standing out sharply, rather than a smooth surface through them.
    steps_option: ?[]const u8,
};

/// How far from the camera `[displacement]` reaches, in blocks, and its grid's cells a side.
pub const DISPLACEMENT_DISTANCES: std::ops::RangeInclusive<f32> = 4.0..=32.0;
pub const DISPLACEMENT_CELLS: std::ops::RangeInclusive<u32> = 4..=64;

/// `[shadow]`: the renderer draws the solid terrain and entities as the sun (the moon by night)
/// sees them into a square depth map each frame, which the material and post stages read.
pub const Shadow = struct {
    /// The map's side, in texels.
    resolution: u32,
    /// Half the side of the square the map covers around the camera, in blocks.
    distance: f32,
    /// `[[materials]]` ids drawn into the map whole, their cutouts ignored: leaves cast
    /// a full shadow, say, whatever holes they show.
    solid_materials: std.ArrayList(u32),
    /// The option the map is drawn while it is not 0 (a bool on, a number other than 0), if
    /// any: while it is 0 there is no map and no shadow pass, and `has_shadow` reads 0.
    option: ?[]const u8,
    /// An `int` option, or a `choice` whose values are numbers, if any: the player's value
    /// replaces `resolution`.
    resolution_option: ?[]const u8,
    /// An `int` option, or a `choice` whose values are numbers, if any: the player's value
    /// replaces `distance`.
    distance_option: ?[]const u8,
};

    // rust: impl Default for Shadow {
    /// `[shadow]` with no keys.
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Shadow {
    // rust: resolution: default_shadow_resolution(),
    // rust: distance: default_shadow_distance(),
    // rust: solid_materials: Vec::new(),
    // rust: option: None,
    // rust: resolution_option: None,
    // rust: distance_option: None,
}
}
}

/// The shadow map's side, in texels.
pub const SHADOW_RESOLUTIONS: std::ops::RangeInclusive<u32> = 256..=8192;
/// Half the side of the square the shadow map covers, in blocks.
pub const SHADOW_DISTANCES: std::ops::RangeInclusive<f32> = 32.0..=512.0;

pub const RawDisplacement = struct {
    distance: f32,
    cells: u32,
    option: ?[]const u8,
    cells_option: ?[]const u8,
    steps_option: ?[]const u8,
};

pub fn default_displacement_distance() f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 12.0
}

pub fn default_displacement_cells() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 16
}

pub fn default_shadow_resolution() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 2048
}

pub fn default_shadow_distance() f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 128.0
}

/// `[reflection]`: when Horizon draws the water mirror the material stage reads as
/// `reflection`. Without it, whenever the stage reads that texture.
pub const Reflection = struct {
    /// The option the mirror is drawn while it is not 0 (a bool on, a number other than 0),
    /// if any.
    option: ?[]const u8,
};

/// `[[textures]]`: a PNG of the pack every stage reads, as `<id>` and `<id>_sampler`.
pub const PackTexture = struct {
    /// The WGSL name of the texture.
    id: []const u8,
    /// The PNG, a plain path in the pack.
    file: []const u8,
    /// Bilinear filtering (else the nearest texel).
    linear: bool,
    /// Coordinates outside 0..1 repeat the image (else they clamp to its edges).
    repeat: bool,
};

/// `[[particle_lights]]`: `particles` (names, as `firefly` or `minecraft:firefly`) light what's
/// within `reach` blocks in `color`, as strongly as they are opaque.
pub const ParticleLight = struct {
    particles: std.ArrayList([]const u8),
    color: [f32,
    reach: f32,
};

/// `[[lights]]`: the colour of the block light from some blocks, as the material stage reads
/// it through `block_light_color`.
pub const LightColor = struct {
    /// Each channel 0 to 4.
    color: [f32,
    /// Block names such as `minecraft:soul_torch` (the namespace defaults to `minecraft`),
    /// each with any number of `*` matching any run of characters.
    blocks: std.ArrayList([]const u8),
};

/// A set of block sprites the material stage can tell apart: its bit in
/// `MaterialInput.tags` is its index in the manifest.
pub const SpriteTag = struct {
    /// A WGSL identifier, for the pack's own reading and its errors.
    id: []const u8,
    /// Sprite names such as `minecraft:block/glass` (the namespace defaults to
    /// `minecraft`), each with at most one `*` matching any run of characters.
    sprites: std.ArrayList([]const u8),
};

    // rust: impl SpriteTag {
    /// Whether the sprite `name` (`namespace:path`) is one of the tag's.
pub fn matches(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sprites.iter().any(|p| sprite_matches(p, name))
}
}

/// `[[materials]]`: a number the material stage reads as `MaterialInput.material`, for the
/// many kinds of surface a pack treats differently, where `[[tags]]` hold 32 sets.
pub const Material = struct {
    /// 1 to 65535 (0 is a sprite without an entry). Entries may share one.
    id: u32,
    /// Sprite names such as `minecraft:block/oak_leaves` (the namespace defaults to
    /// `minecraft`), each with any number of `*` matching any run of characters.
    sprites: std.ArrayList([]const u8),
    /// Blocks (`oak_log`, `minecraft:stone`, `grass_block:snowy=true`): the sprites their models
    /// draw with take the id where no entry's `sprites` names them.
    blocks: std.ArrayList([]const u8),
    /// This id's sprites draw in the translucent pass (sorted, blended, `input.translucent`),
    /// clear texels and all, rather than cut out with the solid terrain.
    translucent: bool,
};

    // rust: impl Material {
    /// Whether the sprite `name` (`namespace:path`) has this entry's id.
pub fn matches(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sprites.iter().any(|p| sprite_matches(p, name))
}
}

/// Whether the sprite or block `name` (`namespace:path`) fits `pattern`: the namespace
/// defaults to `minecraft`, and each `*` matches any run of characters.
/// The colour of the first of `lights` whose patterns match the block `name`
/// (`Manifest::light_of`, for a copy of the entries).
pub fn light_color(lights: *[LightColor], name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lights
    // rust: .iter()
    // rust: .find(|l| l.blocks.iter().any(|pattern| sprite_matches(pattern, name)))
    // rust: .map(|l| l.color)
}

pub fn sprite_matches(pattern: []const u8, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pattern = match pattern.contains(':') {
    // rust: true => std::borrow::Cow::Borrowed(pattern),
    // rust: false => std::borrow::Cow::Owned(format!("minecraft:{pattern}")),
}
    // rust: let Some((head, rest)) = pattern.split_once('*') else {
    // rust: return pattern == name;
}
    // rust: let Some(mut left) = name.strip_prefix(head) else {
    // rust: return false;
}
    // rust: let (middle, tail) = rest.rsplit_once('*').unwrap_or(("", rest));
    // rust: for part in middle.split('*').filter(|p| !p.is_empty()) {
    // rust: let Some(at) = left.find(part) else {
    // rust: return false;
}
    // rust: left = &left[at + part.len()..];
}
    // rust: left.ends_with(tail)
}

/// One stage: the WGSL file that defines its function.
pub const Stage = struct {
    file: []const u8,
    /// WGSL files put before `file`, after the shared ones, for this stage only.
    files: std.ArrayList([]const u8),
    /// Shown in the GPU time overlay; the file name when absent.
    name: ?[]const u8,
    /// The material stage only: whether Horizon applies its fog after the pack's colour
    /// (true when absent); false for a pack that fogs its surfaces itself.
    fog: ?bool,
    /// The sky stage only: whether Minecraft's clouds still draw (true when absent); false for
    /// a pack whose sky draws its own.
    clouds: ?bool,
    /// The sky stage only: whether Minecraft's sun still draws over the sky (true when absent);
    /// false for a pack whose sky draws its own. The moon stays.
    sun: ?bool,
    /// The sky stage only: whether Minecraft's stars still draw over the sky (true when absent);
    /// false for a pack whose sky draws its own.
    stars: ?bool,
    /// A post pass only: its target's size against the world's, 1, 0.5 or 0.25 (1 when
    /// absent); below 1 the pass writes an `output`.
    scale: ?f32,
    /// A post pass only: the pack target it writes in place of the chain of passes. The
    /// passes after it read that target by name, and the next one's `previous` is still the
    /// chain's last picture.
    output: ?[]const u8,
};

/// The scales a post pass may draw at.
pub const POST_SCALES: [f32; 3] = [1.0, 0.5, 0.25];
/// The most targets a pack's post passes may write.
pub const MAX_POST_TARGETS: usize = 4;

/// An option the player can change: a WGSL `override` constant of the
/// same name, set when the pipelines are built.
pub const PackOption = struct {
    /// The `override`'s name in the pack's WGSL.
    id: []const u8,
    name: []const u8,
    description: []const u8,
    kind: OptionKind,
};

pub const OptionKind = enum {
    /// `override <id>: bool`.
    Bool { default: bool },
    /// `override <id>: f32`; the slider moves by `step`.
    Float {,
    default: f32,
    min: f32,
    max: f32,
    step: f32,
    // rust: },
    /// `override <id>: i32`.
    Int { default: i32, min: i32, max: i32 },
    /// `override <id>: u32`, the index of the chosen value.
    Choice { values: Vec<String>, default: u32 },
};

/// `[[pages]]`: a page of the pack's settings screen.
pub const OptionPage = struct {
    /// What `page:<id>` items link to.
    id: []const u8,
    /// The page's title, and the label of the buttons linking to it.
    name: []const u8,
    /// The tooltip of the buttons linking to it.
    description: []const u8,
    /// 1 or 2: full-width buttons, or two a row.
    columns: u8,
    items: std.ArrayList(PageItem),
};

/// What a page shows in one slot, in order: left to right, then down.
pub const PageItem = enum {
    /// `"<id>"`: the option of that id.
    Option(usize),
    /// `"page:<id>"`: a button opening `Manifest::pages[i]`.
    Page(usize),
    /// `""`: an empty slot.
    Empty,
};

pub const Budget = struct {
    /// The GPU time the pack aims to add to a frame, in milliseconds; the
    /// overlay shows the pack over budget past it.
    gpu_ms: ?f32,
};

pub const Raw = struct {
    schema: u32,
    id: []const u8,
    name: []const u8,
    version: []const u8,
    api: []const u8,
    description: []const u8,
    authors: std.ArrayList([]const u8),
    license: ?[]const u8,
    shared: std.ArrayList([]const u8),
    sky: ?Stage,
    material: ?Stage,
    vertex: ?Stage,
    weather: ?Stage,
    post: std.ArrayList(Stage),
    tonemap: ?Stage,
    frame: ?RawFrame,
    options: std.ArrayList(RawOption),
    pages: std.ArrayList(RawPage),
    tags: std.ArrayList(SpriteTag),
    materials: std.ArrayList(Material),
    textures: std.ArrayList(RawTexture),
    lights: std.ArrayList(LightColor),
    particle_lights: std.ArrayList(ParticleLight),
    budget: RawBudget,
    reflection: ?Reflection,
    shadow: ?Shadow,
    displacement: ?RawDisplacement,
};

pub const RawOption = struct {
    id: []const u8,
    name: []const u8,
    description: []const u8,
    kind: []const u8,
    default: toml::Value,
    min: ?toml::Value,
    max: ?toml::Value,
    step: ?f64,
    values: ?std.ArrayList([]const u8),
};

pub const RawFrame = struct {
    blend: ?[]const u8,
};

pub const RawBudget = struct {
    gpu_ms: ?f64,
};

/// `[[post]] scale` and `output`: scales from `POST_SCALES`, below 1 only with an output,
/// the last pass drawing the picture itself, outputs named as WGSL names no other resource
/// takes, each at one scale, `MAX_POST_TARGETS` at most.
pub fn check_post_targets(post: *[Stage]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let reserved = [
    // rust: "frame",
    // rust: "scene_color",
    // rust: "scene_depth",
    // rust: "previous",
    // rust: "linear_sampler",
    // rust: "nearest_sampler",
    // rust: "shadow_map",
    // rust: "shadow_sampler",
    // rust: "history",
    // rust: "shadow_map_translucent",
    // rust: "shadow_color",
    // rust: "scene_surface",
    // rust: ];
    // rust: let mut targets: Vec<(&str, f32)> = Vec::new();
    // rust: for (i, p) in post.iter().enumerate() {
    // rust: let scale = p.scale.unwrap_or(1.0);
    // rust: if !POST_SCALES.contains(&scale) {
    // rust: return Err(format!(
    // rust: "{}: scale {scale} is not one of {POST_SCALES:?}",
    // rust: p.file
    // rust: ));
}
    // rust: if i + 1 == post.len() && (p.output.is_some() || scale != 1.0) {
    // rust: return Err(format!(
    // rust: "{}: the last [[post]] pass draws the picture: no `output` or `scale`",
    // rust: p.file
    // rust: ));
}
    // rust: let Some(name) = &p.output else {
    // rust: if scale != 1.0 {
    // rust: return Err(format!("{}: a scaled pass writes an `output`", p.file));
}
    // rust: continue;
}
    // rust: let valid = name.len() <= 32
    // rust: && name.starts_with(|c: char| c.is_ascii_lowercase())
    // rust: && name
    // rust: .chars()
    // rust: .all(|c| c.is_ascii_lowercase() || c.is_ascii_digit() || c == '_')
    // rust: && !name.starts_with("horizon_");
    // rust: if !valid || reserved.contains(&name.as_str()) {
    // rust: return Err(format!(
    // rust: "{}: output {name:?} is not a free WGSL name ([a-z][a-z0-9_]*, at most 32)",
    // rust: p.file
    // rust: ));
}
    // rust: match targets.iter().find(|t| t.0 == name) {
    // rust: Some(&(_, s)) if s != scale => {
    // rust: return Err(format!(
    // rust: "{}: output {name:?} is written at two scales",
    // rust: p.file
    // rust: ));
}
    // rust: Some(_) => {}
    // rust: None => targets.push((name, scale)),
}
}
    // rust: if targets.len() > MAX_POST_TARGETS {
    // rust: return Err(format!(
    // rust: "{} [[post]] outputs; a pack may write {MAX_POST_TARGETS}",
    // rust: targets.len()
    // rust: ));
}
    // rust: Ok(())
}

    // rust: impl Manifest {
pub fn parse(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let raw: Raw = toml::from_str(text).map_err(|e| format!("{MANIFEST}: {e}"))?;
    // rust: let err = |e: String| format!("{MANIFEST}: {e}");
    // rust: if raw.schema != SCHEMA {
    // rust: return Err(err(format!(
    // rust: "schema {}; this Horizon reads {SCHEMA}",
    // rust: raw.schema
    // rust: )));
}
    // rust: let Some(api) = Api::parse(&raw.api) else {
    // rust: return Err(err(format!(
    // rust: "written for shader API {}; this Horizon serves 0.1 and 0.2",
    // rust: raw.api
    // rust: )));
}
    // rust: if api == Api::V0_1 {
    // rust: for (present, key) in [
    // rust: (raw.tonemap.is_some(), "[tonemap]"),
    // rust: (raw.frame.is_some(), "[frame]"),
    // rust: ] {
    // rust: if present {
    // rust: return Err(err(format!(
    // rust: "{key} is shader API 0.2: the pack says api = \"0.1\""
    // rust: )));
}
}
}
    // rust: let blend = match raw.frame.as_ref().and_then(|f| f.blend.as_deref()) {
    // rust: None | Some("gamma") => Blend::Gamma,
    // rust: Some("linear") => Blend::Linear,
    // rust: Some(b) => return Err(err(format!("frame.blend {b:?}: gamma or linear"))),
}
    // rust: let id_ok = (1..=64).contains(&raw.id.len())
    // rust: && raw
    // rust: .id
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_');
    // rust: if !id_ok {
    // rust: return Err(err(format!("id {:?} is not [a-z0-9_]{{1,64}}", raw.id)));
}
    // rust: if raw.name.trim().is_empty() || raw.version.trim().is_empty() {
    // rust: return Err(err("name and version can't be empty".into()));
}
    // rust: if raw.sky.is_none()
    // rust: && raw.material.is_none()
    // rust: && raw.weather.is_none()
    // rust: && raw.post.is_empty()
    // rust: && raw.tonemap.is_none()
    // rust: {
    // rust: return Err(err(match api {
    // rust: Api::V0_1 => "no stage: give it a [sky], a [material], a [weather] or a [[post]]",
    // rust: Api::V0_2 => {
    // rust: "no stage: give it a [sky], a [material], a [weather], a [[post]] or a [tonemap]"
}
}
    // rust: .into()));
}
    // rust: if raw.vertex.is_some() && raw.material.is_none() {
    // rust: return Err(err(
    // rust: "[vertex] needs a [material]: they draw terrain together".into(),
    // rust: ));
}
    // rust: if raw
    // rust: .sky
    // rust: .iter()
    // rust: .chain(&raw.vertex)
    // rust: .chain(&raw.post)
    // rust: .chain(&raw.tonemap)
    // rust: .any(|s| s.fog.is_some())
    // rust: {
    // rust: return Err(err("`fog` is a key of [material] only".into()));
}
    // rust: if raw
    // rust: .sky
    // rust: .iter()
    // rust: .chain(&raw.material)
    // rust: .chain(&raw.vertex)
    // rust: .chain(&raw.tonemap)
    // rust: .any(|s| s.scale.is_some() || s.output.is_some())
    // rust: {
    // rust: return Err(err("`scale` and `output` are keys of [[post]] only".into()));
}
    // rust: check_post_targets(&raw.post).map_err(err)?;
    // rust: if raw.post.len() > MAX_POST_PASSES {
    // rust: return Err(err(format!(
    // rust: "{} post passes; a pack may chain {MAX_POST_PASSES}",
    // rust: raw.post.len()
    // rust: )));
}
    // rust: let stages = raw
    // rust: .sky
    // rust: .iter()
    // rust: .chain(&raw.material)
    // rust: .chain(&raw.vertex)
    // rust: .chain(&raw.weather)
    // rust: .chain(&raw.post)
    // rust: .chain(&raw.tonemap);
    // rust: for file in raw
    // rust: .shared
    // rust: .iter()
    // rust: .chain(stages.flat_map(|s| s.files.iter().chain(std::iter::once(&s.file))))
    // rust: {
    // rust: if !crate::package::plain_path(file) || !file.ends_with(".wgsl") {
    // rust: return Err(err(format!("{file:?} is not a plain path to a .wgsl file")));
}
}
    // rust: let sky_only = |s: &Stage| s.clouds.is_some() || s.sun.is_some() || s.stars.is_some();
    // rust: if raw
    // rust: .material
    // rust: .iter()
    // rust: .chain(&raw.post)
    // rust: .chain(&raw.tonemap)
    // rust: .any(sky_only)
    // rust: {
    // rust: return Err(err(
    // rust: "`clouds`, `sun` and `stars` are keys of [sky] only".into()
    // rust: ));
}
    // rust: if raw.options.len() > MAX_OPTIONS {
    // rust: return Err(err(format!(
    // rust: "{} options; a pack may declare {MAX_OPTIONS}",
    // rust: raw.options.len()
    // rust: )));
}
    // rust: let mut options = Vec::with_capacity(raw.options.len());
    // rust: for (i, o) in raw.options.into_iter().enumerate() {
    // rust: let id = o.id.clone();
    // rust: let option = o.check().map_err(|e| err(format!("option {id:?}: {e}")))?;
    // rust: if options[..i].iter().any(|p: &PackOption| p.id == option.id) {
    // rust: return Err(err(format!("option {id:?} is declared twice")));
}
    // rust: options.push(option);
}
    // rust: if !raw.tags.is_empty() && raw.material.is_none() {
    // rust: return Err(err(
    // rust: "tags are read by the material stage: give it a [material]".into(),
    // rust: ));
}
    // rust: if raw.tags.len() > MAX_TAGS {
    // rust: return Err(err(format!(
    // rust: "{} tags; a pack may declare {MAX_TAGS}",
    // rust: raw.tags.len()
    // rust: )));
}
    // rust: for (i, tag) in raw.tags.iter().enumerate() {
    // rust: let id = &tag.id;
    // rust: if !pack_identifier(id) {
    // rust: return Err(err(format!("tag {id:?}: the id must be a WGSL identifier")));
}
    // rust: if raw.tags[..i].iter().any(|t| &t.id == id) {
    // rust: return Err(err(format!("tag {id:?} is declared twice")));
}
    // rust: let sprite_ok = |p: &String| !p.is_empty() && p.matches('*').count() <= 1;
    // rust: if tag.sprites.is_empty() || !tag.sprites.iter().all(sprite_ok) {
    // rust: return Err(err(format!(
    // rust: "tag {id:?}: needs sprites, each a name with at most one *"
    // rust: )));
}
}
    // rust: let solid_ids = raw.shadow.iter().any(|s| !s.solid_materials.is_empty());
    // rust: if !raw.materials.is_empty() && raw.material.is_none() && !solid_ids {
    // rust: return Err(err(
    // rust: "materials are read by the material stage and shadow.solid_materials: \
    // rust: give it a [material] or use them there"
    // rust: .into(),
    // rust: ));
}
    // rust: if raw.materials.len() > MAX_MATERIALS {
    // rust: return Err(err(format!(
    // rust: "{} materials; a pack may declare {MAX_MATERIALS}",
    // rust: raw.materials.len()
    // rust: )));
}
    // rust: for m in &raw.materials {
    // rust: if !(1..=65535).contains(&m.id) {
    // rust: return Err(err(format!("material id {} is not in 1..=65535", m.id)));
}
    // rust: let listed = m.sprites.iter().chain(&m.blocks);
    // rust: if m.sprites.is_empty() && m.blocks.is_empty() || listed.clone().any(String::is_empty) {
    // rust: return Err(err(format!("material {}: needs sprites or blocks", m.id)));
}
    // rust: if let Some(block) = m.blocks.iter().find(|b| b.contains(char::is_whitespace)) {
    // rust: return Err(err(format!(
    // rust: "material {}: the block {block:?} has a space in it",
    // rust: m.id
    // rust: )));
}
}
    // rust: for id in raw.shadow.iter().flat_map(|s| &s.solid_materials) {
    // rust: if !raw.materials.iter().any(|m| m.id == *id) {
    // rust: return Err(err(format!(
    // rust: "shadow.solid_materials: no [[materials]] entry has id {id}"
    // rust: )));
}
}
    // rust: let pages = check_pages(raw.pages, &options).map_err(err)?;
    // rust: if raw.textures.len() > MAX_TEXTURES {
    // rust: return Err(err(format!(
    // rust: "{} [[textures]]; a pack may declare {MAX_TEXTURES}",
    // rust: raw.textures.len()
    // rust: )));
}
    // rust: let mut textures: Vec<PackTexture> = Vec::new();
    // rust: for t in raw.textures {
    // rust: if !pack_identifier(&t.id) || textures.iter().any(|o| o.id == t.id) {
    // rust: return Err(err(format!(
    // rust: "texture id {:?} is not a WGSL identifier, or is declared twice",
    // rust: t.id
    // rust: )));
}
    // rust: if !crate::package::plain_path(&t.file) || !t.file.ends_with(".png") {
    // rust: return Err(err(format!(
    // rust: "{:?} is not a plain path to a .png file",
    // rust: t.file
    // rust: )));
}
    // rust: let linear = match t.filter.as_deref() {
    // rust: None | Some("linear") => true,
    // rust: Some("nearest") => false,
    // rust: Some(f) => return Err(err(format!("texture filter {f:?}: linear or nearest"))),
}
    // rust: let repeat = match t.wrap.as_deref() {
    // rust: None | Some("repeat") => true,
    // rust: Some("clamp") => false,
    // rust: Some(w) => return Err(err(format!("texture wrap {w:?}: repeat or clamp"))),
}
    // rust: textures.push(PackTexture {
    // rust: id: t.id,
    // rust: file: t.file,
    // rust: linear,
    // rust: repeat,
    // rust: });
}
    // rust: if !raw.lights.is_empty() && raw.material.is_none() {
    // rust: return Err(err(
    // rust: "lights are read by the material stage: give it a [material]".into(),
    // rust: ));
}
    // rust: if !raw.particle_lights.is_empty() && raw.material.is_none() {
    // rust: return Err(err(
    // rust: "particle lights are read by the material stage: give it a [material]".into(),
    // rust: ));
}
    // rust: if raw.particle_lights.len() > MAX_PARTICLE_LIGHTS {
    // rust: return Err(err(format!(
    // rust: "{} [[particle_lights]]; a pack may declare {MAX_PARTICLE_LIGHTS}",
    // rust: raw.particle_lights.len()
    // rust: )));
}
    // rust: for l in &raw.particle_lights {
    // rust: if l.particles.is_empty() {
    // rust: return Err(err("a [[particle_lights]] entry needs particles".into()));
}
    // rust: if l.color.iter().any(|c| !(0.0..=1.0).contains(c)) {
    // rust: return Err(err(format!(
    // rust: "particle light color {:?} is not in 0..=1 per channel",
    // rust: l.color
    // rust: )));
}
    // rust: if !(0.25..=16.0).contains(&l.reach) {
    // rust: return Err(err(format!(
    // rust: "particle light reach {} is not in 0.25..=16",
    // rust: l.reach
    // rust: )));
}
}
    // rust: if raw.lights.len() > MAX_LIGHTS {
    // rust: return Err(err(format!(
    // rust: "{} [[lights]]; a pack may declare {MAX_LIGHTS}",
    // rust: raw.lights.len()
    // rust: )));
}
    // rust: if let Some(l) = raw
    // rust: .lights
    // rust: .iter()
    // rust: .find(|l| l.color.iter().any(|c| !(0.0..=4.0).contains(c)))
    // rust: {
    // rust: return Err(err(format!(
    // rust: "light color {:?} is not in 0..=4 per channel",
    // rust: l.color
    // rust: )));
}
    // rust: if raw
    // rust: .lights
    // rust: .iter()
    // rust: .any(|l| l.blocks.is_empty() || l.blocks.iter().any(String::is_empty))
    // rust: {
    // rust: return Err(err("a [[lights]] entry needs blocks".into()));
}
    // rust: let gpu_ms = match raw.budget.gpu_ms {
    // rust: Some(ms) if !(ms > 0.0 && ms <= f64::from(MAX_GPU_MS)) => {
    // rust: return Err(err(format!(
    // rust: "budget.gpu_ms {ms} is not in (0, {MAX_GPU_MS}]"
    // rust: )));
}
    // rust: ms => ms.map(|ms| ms as f32),
}
    // rust: if let Some(r) = &raw.reflection {
    // rust: if raw.material.is_none() {
    // rust: return Err(err("[reflection] needs [material]".into()));
}
    // rust: if let Some(id) = &r.option
    // rust: && !options.iter().any(|o| o.id == *id)
    // rust: {
    // rust: return Err(err(format!("reflection.option: `{id}` is no option")));
}
}
    // rust: if let Some(s) = &raw.shadow {
    // rust: if raw.material.is_none() && raw.post.is_empty() {
    // rust: return Err(err("[shadow] needs [material] or [[post]]".into()));
}
    // rust: if !SHADOW_RESOLUTIONS.contains(&s.resolution) {
    // rust: return Err(err(format!(
    // rust: "shadow.resolution {} is not in {SHADOW_RESOLUTIONS:?}",
    // rust: s.resolution
    // rust: )));
}
    // rust: if !SHADOW_DISTANCES.contains(&s.distance) {
    // rust: return Err(err(format!(
    // rust: "shadow.distance {} is not in {SHADOW_DISTANCES:?}",
    // rust: s.distance
    // rust: )));
}
    // rust: if let Some(id) = &s.option
    // rust: && !options.iter().any(|o| o.id == *id)
    // rust: {
    // rust: return Err(err(format!("shadow.option: `{id}` is no option")));
}
    // rust: let resolution = |v: f64| v.fract() == 0.0 && SHADOW_RESOLUTIONS.contains(&(v as u32));
    // rust: if let Some(id) = &s.resolution_option
    // rust: && !numbers_in(&options, id, resolution)
    // rust: {
    // rust: return Err(err(format!(
    // rust: "shadow.resolution_option: `{id}` is no int or choice of resolutions in \
    // rust: {SHADOW_RESOLUTIONS:?}"
    // rust: )));
}
    // rust: let distance = |v: f64| SHADOW_DISTANCES.contains(&(v as f32));
    // rust: if let Some(id) = &s.distance_option
    // rust: && !numbers_in(&options, id, distance)
    // rust: {
    // rust: return Err(err(format!(
    // rust: "shadow.distance_option: `{id}` is no int or choice of distances in \
    // rust: {SHADOW_DISTANCES:?}"
    // rust: )));
}
}
    // rust: let displacement = match raw.displacement {
    // rust: Some(_) if raw.material.is_none() => {
    // rust: return Err(err("[displacement] needs [material]".into()));
}
    // rust: Some(d) if !DISPLACEMENT_DISTANCES.contains(&d.distance) => {
    // rust: return Err(err(format!(
    // rust: "displacement.distance {} is not in {DISPLACEMENT_DISTANCES:?}",
    // rust: d.distance
    // rust: )));
}
    // rust: Some(d) if !DISPLACEMENT_CELLS.contains(&d.cells) => {
    // rust: return Err(err(format!(
    // rust: "displacement.cells {} is not in {DISPLACEMENT_CELLS:?}",
    // rust: d.cells
    // rust: )));
}
    // rust: Some(d) => {
    // rust: if let Some(id) = &d.option
    // rust: && !options
    // rust: .iter()
    // rust: .any(|o| o.id == *id && matches!(o.kind, OptionKind::Bool { .. }))
    // rust: {
    // rust: return Err(err(format!(
    // rust: "displacement.option: `{id}` is no bool option"
    // rust: )));
}
    // rust: if let Some(id) = &d.steps_option
    // rust: && !options
    // rust: .iter()
    // rust: .any(|o| o.id == *id && matches!(o.kind, OptionKind::Bool { .. }))
    // rust: {
    // rust: return Err(err(format!(
    // rust: "displacement.steps_option: `{id}` is no bool option"
    // rust: )));
}
    // rust: if let Some(id) = &d.cells_option
    // rust: && !options.iter().any(|o| {
    // rust: o.id == *id
    // rust: && matches!(&o.kind, OptionKind::Choice { values, .. } if values
    // rust: .iter()
    // rust: .all(|v| v.parse().is_ok_and(|c| DISPLACEMENT_CELLS.contains(&c))))
    // rust: })
    // rust: {
    // rust: return Err(err(format!(
    // rust: "displacement.cells_option: `{id}` is no choice of cell counts in \
    // rust: {DISPLACEMENT_CELLS:?}"
    // rust: )));
}
    // rust: Some(Displacement {
    // rust: distance: d.distance,
    // rust: cells: d.cells,
    // rust: option: d.option,
    // rust: cells_option: d.cells_option,
    // rust: steps_option: d.steps_option,
    // rust: })
}
    // rust: None => None,
}
    // rust: Ok(Manifest {
    // rust: id: raw.id,
    // rust: name: raw.name,
    // rust: version: raw.version,
    // rust: api,
    // rust: description: raw.description,
    // rust: authors: raw.authors,
    // rust: license: raw.license,
    // rust: shared: raw.shared,
    // rust: sky: raw.sky,
    // rust: material: raw.material,
    // rust: vertex: raw.vertex,
    // rust: weather: raw.weather,
    // rust: post: raw.post,
    // rust: tonemap: raw.tonemap,
    // rust: blend,
    // rust: options,
    // rust: pages,
    // rust: tags: raw.tags,
    // rust: materials: raw.materials,
    // rust: textures,
    // rust: lights: raw.lights,
    // rust: particle_lights: raw.particle_lights,
    // rust: budget: Budget { gpu_ms },
    // rust: reflection: raw.reflection,
    // rust: shadow: raw.shadow,
    // rust: displacement,
    // rust: })
}

    /// The tags of each block sprite `(name, layer)` that has any, as `(layer, bits)` in
    /// layer order: what the material stage's `MaterialInput.tags` reads.
    // rust: pub fn sprite_tags<'a>(
    // rust: &self,
    // rust: sprites: impl IntoIterator<Item = (&'a str, u32)>,
    // rust: ) -> Vec<(u32, u32)> {
        // Identical stills share one layer under several names: their tags are or-ed
        // together, so each layer is one case of the shader's `switch`.
    // rust: let mut layers = std::collections::BTreeMap::<u32, u32>::new();
    // rust: for (name, layer) in sprites {
    // rust: let bits = self
    // rust: .tags
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, t)| t.matches(name))
    // rust: .fold(0, |bits, (i, _)| bits | 1 << i);
    // rust: if bits != 0 {
    // rust: *layers.entry(layer).or_default() |= bits;
}
}
    // rust: layers.into_iter().collect()
}

    /// The material id of each block sprite `(name, layer)` that has one, as `(layer, id)` in
    /// layer order: what the material stage's `MaterialInput.material` reads.
    // rust: pub fn sprite_materials<'a>(
    // rust: &self,
    // rust: sprites: impl IntoIterator<Item = (&'a str, u32)>,
    // rust: ) -> Vec<(u32, u32)> {
        // Identical stills share one layer under several names: the earliest entry any of
        // them matches decides, whatever order the names come in.
    // rust: let mut layers = std::collections::BTreeMap::<u32, usize>::new();
    // rust: for (name, layer) in sprites {
    // rust: if let Some(entry) = self.materials.iter().position(|m| m.matches(name)) {
    // rust: let best = layers.entry(layer).or_insert(entry);
    // rust: *best = entry.min(*best);
}
}
    // rust: layers
    // rust: .into_iter()
    // rust: .map(|(layer, entry)| (layer, self.materials[entry].id))
    // rust: .collect()
}

    /// The `blocks` lists in `block.properties`' form, for matching them against block states.
    /// Empty without any.
pub fn material_blocks(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.materials
    // rust: .iter()
    // rust: .filter(|m| !m.blocks.is_empty())
    // rust: .map(|m| format!("block.{}={}\n", m.id, m.blocks.join(" ")))
    // rust: .collect()
}

    /// Which of `layers` sprite layers draw in the translucent pass, by `materials` as
    /// `sprite_materials` gives them: empty when none does.
pub fn translucent_layers(self: *Self, materials: *[(u32) void {
}
    // rust: let mut out = vec![false; layers];
    // rust: for (layer, id) in materials {
    // rust: if self.materials.iter().any(|m| m.translucent && m.id == *id)
    // rust: && let Some(l) = out.get_mut(*layer as usize)
    // rust: {
    // rust: *l = true;
}
}
    // rust: if out.contains(&true) { out } else { Vec::new() }
}

    /// The `[[lights]]` colour of the block `name` (`namespace:path`): the first entry with a
    /// matching pattern.
pub fn light_of(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: light_color(&self.lights, name)
}

    /// The pack targets its post passes write (`[[post]] output`), in the order first
    /// written, with their scale.
pub fn post_targets(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: Vec<(&str, f32)> = Vec::new();
    // rust: for p in &self.post {
    // rust: if let Some(name) = &p.output
    // rust: && !out.iter().any(|t| t.0 == name)
    // rust: {
    // rust: out.push((name, p.scale.unwrap_or(1.0)));
}
}
    // rust: out
}

    /// Every WGSL file the manifest names, shared files first, each once.
pub fn files(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut files: Vec<&str> = Vec::new();
    // rust: let stages = self
    // rust: .sky
    // rust: .iter()
    // rust: .chain(&self.material)
    // rust: .chain(&self.vertex)
    // rust: .chain(&self.weather)
    // rust: .chain(&self.post)
    // rust: .chain(&self.tonemap);
    // rust: for file in self
    // rust: .shared
    // rust: .iter()
    // rust: .chain(stages.flat_map(|s| s.files.iter().chain(std::iter::once(&s.file))))
    // rust: {
    // rust: if !files.contains(&file.as_str()) {
    // rust: files.push(file);
}
}
    // rust: files
}
}

/// Whether `id` is an `int` option or a `choice` whose every value stands for a number
/// (`OptionKind::number`) that `valid` takes.
pub fn numbers_in(options: *[PackOption], id: []const u8, valid: impl Fn(f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: options.iter().any(|o| {
    // rust: o.id == id
    // rust: && match &o.kind {
    // rust: OptionKind::Int { min, max, .. } => {
    // rust: valid(f64::from(*min)) && valid(f64::from(*max))
}
    // rust: OptionKind::Choice { values, .. } => {
    // rust: (0..values.len()).all(|i| o.kind.number(i as f64).is_some_and(&valid))
}
    // rust: _ => false,
}
    // rust: })
}

/// A WGSL identifier the renderer leaves to packs: ASCII, not starting
/// with a digit, `_` or the renderer's own `horizon_` prefix.
pub fn pack_identifier(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut bytes = name.bytes();
    // rust: bytes.next().is_some_and(|b| b.is_ascii_alphabetic())
    // rust: && bytes.all(|b| b.is_ascii_alphanumeric() || b == b'_')
    // rust: && name.len() <= 64
    // rust: && !name.starts_with("horizon_")
}

pub const RawPage = struct {
    id: []const u8,
    name: []const u8,
    description: []const u8,
    columns: u8,
    items: std.ArrayList([]const u8),
};

pub fn default_columns() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 2
}

/// `[[pages]]` checked against the options: known ids, each page's own id once, links to
/// other pages only, and every page and option reached from the first page.
pub fn check_pages(raw: std.ArrayList(RawPage), options: *[PackOption]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pages = read_pages(&raw, options)?;
    // rust: if pages.is_empty() {
    // rust: return Ok(pages);
}
    // rust: let (mut seen, mut next, mut shown) = (
    // rust: vec![false; pages.len()],
    // rust: vec![0],
    // rust: vec![false; options.len()],
    // rust: );
    // rust: seen[0] = true;
    // rust: while let Some(at) = next.pop() {
    // rust: for item in &pages[at].items {
    // rust: match *item {
    // rust: PageItem::Option(i) => shown[i] = true,
    // rust: PageItem::Page(i) if !seen[i] => {
    // rust: seen[i] = true;
    // rust: next.push(i);
}
    // rust: _ => {}
}
}
}
    // rust: if let Some(i) = seen.iter().position(|s| !s) {
    // rust: return Err(format!(
    // rust: "page {:?} can't be reached from the first page, {:?}",
    // rust: pages[i].id, pages[0].id
    // rust: ));
}
    // rust: if let Some(i) = shown.iter().position(|s| !s) {
    // rust: return Err(format!(
    // rust: "option {:?} is on no page the settings reach",
    // rust: options[i].id
    // rust: ));
}
    // rust: Ok(pages)
}

pub fn read_pages(raw: *[RawPage], options: *[PackOption]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if raw.len() > MAX_PAGES {
    // rust: return Err(format!(
    // rust: "{} pages; a pack may declare {MAX_PAGES}",
    // rust: raw.len()
    // rust: ));
}
    // rust: for (i, page) in raw.iter().enumerate() {
    // rust: if !pack_identifier(&page.id) {
    // rust: return Err(format!(
    // rust: "page {:?}: the id must be a letter, then letters, digits or _, up to 64",
    // rust: page.id
    // rust: ));
}
    // rust: if raw[..i].iter().any(|p| p.id == page.id) {
    // rust: return Err(format!("page {:?} is declared twice", page.id));
}
}
    // rust: raw.iter()
    // rust: .enumerate()
    // rust: .map(|(at, page)| {
    // rust: let fail = |e: String| format!("page {:?}: {e}", page.id);
    // rust: if page.name.trim().is_empty() {
    // rust: return Err(fail("needs a name".into()));
}
    // rust: if !(1..=2).contains(&page.columns) {
    // rust: return Err(fail(format!("columns = {}; 1 or 2", page.columns)));
}
    // rust: if page.items.len() > MAX_PAGE_ITEMS {
    // rust: return Err(fail(format!(
    // rust: "{} items; a page may hold {MAX_PAGE_ITEMS}",
    // rust: page.items.len()
    // rust: )));
}
    // rust: let mut items = Vec::with_capacity(page.items.len());
    // rust: for item in &page.items {
    // rust: let item = if item.is_empty() {
    // rust: PageItem::Empty
    // rust: } else if let Some(link) = item.strip_prefix("page:") {
    // rust: match raw.iter().position(|p| p.id == link) {
    // rust: Some(i) if i == at => return Err(fail("links to itself".into())),
    // rust: Some(i) => PageItem::Page(i),
    // rust: None => return Err(fail(format!("no page {link:?} to link to"))),
}
    // rust: } else {
    // rust: match options.iter().position(|o| o.id == *item) {
    // rust: Some(i) => PageItem::Option(i),
    // rust: None => return Err(fail(format!("no option {item:?}"))),
}
}
    // rust: if item != PageItem::Empty && items.contains(&item) {
    // rust: return Err(fail(format!(
    // rust: "{:?} is on the page twice",
    // rust: page.items[items.len()]
    // rust: )));
}
    // rust: items.push(item);
}
    // rust: Ok(OptionPage {
    // rust: id: page.id.clone(),
    // rust: name: page.name.clone(),
    // rust: description: page.description.clone(),
    // rust: columns: page.columns,
    // rust: items,
    // rust: })
    // rust: })
    // rust: .collect()
}

pub const RawTexture = struct {
    id: []const u8,
    file: []const u8,
    filter: ?[]const u8,
    wrap: ?[]const u8,
};

    // rust: impl RawOption {
pub fn check(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !pack_identifier(&self.id) {
    // rust: return Err(
    // rust: "the id must be a WGSL identifier: a letter, then letters, digits or _, up to 64, not starting with horizon_".into(),
    // rust: );
}
    // rust: let int = |v: &toml::Value| {
    // rust: v.as_integer()
    // rust: .and_then(|i| i32::try_from(i).ok())
    // rust: .ok_or_else(|| format!("{v} is not a 32-bit integer"))
}
    // rust: let float = |v: &toml::Value| {
    // rust: v.as_float()
    // rust: .or_else(|| v.as_integer().map(|i| i as f64))
    // rust: .filter(|f| f.is_finite())
    // rust: .map(|f| f as f32)
    // rust: .ok_or_else(|| format!("{v} is not a number"))
}
    // rust: let need = |v: Option<toml::Value>, key: &str| v.ok_or_else(|| format!("needs {key}"));
    // rust: let unused = |present: bool, key: &str| {
    // rust: if present {
    // rust: Err(format!("{key} doesn't apply to type = {:?}", self.kind))
    // rust: } else {
    // rust: Ok(())
}
}
    // rust: let kind = match self.kind.as_str() {
    // rust: "bool" => {
    // rust: unused(self.min.is_some() || self.max.is_some(), "min/max")?;
    // rust: unused(self.step.is_some(), "step")?;
    // rust: unused(self.values.is_some(), "values")?;
    // rust: let default = self
    // rust: .default
    // rust: .as_bool()
    // rust: .ok_or("default must be true or false")?;
    // rust: OptionKind::Bool { default }
}
    // rust: "float" => {
    // rust: unused(self.values.is_some(), "values")?;
    // rust: let (min, max) = (
    // rust: float(&need(self.min, "min")?)?,
    // rust: float(&need(self.max, "max")?)?,
    // rust: );
    // rust: let default = float(&self.default)?;
    // rust: let step = self.step.map_or((max - min) / 100.0, |s| s as f32);
    // rust: if !(min < max && (min..=max).contains(&default)) {
    // rust: return Err(format!("needs min < max and default in [{min}, {max}]"));
}
    // rust: if !(step > 0.0 && step <= max - min) {
    // rust: return Err(format!("step {step} is not in (0, max - min]"));
}
    // rust: OptionKind::Float {
    // rust: default,
    // rust: min,
    // rust: max,
    // rust: step,
}
}
    // rust: "int" => {
    // rust: unused(self.step.is_some(), "step")?;
    // rust: unused(self.values.is_some(), "values")?;
    // rust: let (min, max) = (int(&need(self.min, "min")?)?, int(&need(self.max, "max")?)?);
    // rust: let default = int(&self.default)?;
    // rust: if !(min < max && (min..=max).contains(&default)) {
    // rust: return Err(format!("needs min < max and default in [{min}, {max}]"));
}
    // rust: OptionKind::Int { default, min, max }
}
    // rust: "choice" => {
    // rust: unused(self.min.is_some() || self.max.is_some(), "min/max")?;
    // rust: unused(self.step.is_some(), "step")?;
    // rust: let values = self.values.ok_or("needs values")?;
    // rust: if !(2..=32).contains(&values.len()) {
    // rust: return Err("needs 2 to 32 values".into());
}
    // rust: if values
    // rust: .iter()
    // rust: .enumerate()
    // rust: .any(|(i, v)| v.trim().is_empty() || values[..i].contains(v))
    // rust: {
    // rust: return Err("values must be distinct and not empty".into());
}
    // rust: let default = self
    // rust: .default
    // rust: .as_str()
    // rust: .and_then(|d| values.iter().position(|v| v == d))
    // rust: .ok_or("default must be one of the values")?;
    // rust: OptionKind::Choice {
    // rust: values,
    // rust: default: default as u32,
}
}
    // rust: other => {
    // rust: return Err(format!("type {other:?} is not bool, float, int or choice"));
}
}
    // rust: Ok(PackOption {
    // rust: id: self.id,
    // rust: name: self.name,
    // rust: description: self.description,
    // rust: kind,
    // rust: })
}
}

    // rust: impl OptionKind {
    /// The WGSL type of the option's `override`.
pub fn wgsl_type(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: OptionKind::Bool { .. } => "bool",
    // rust: OptionKind::Float { .. } => "f32",
    // rust: OptionKind::Int { .. } => "i32",
    // rust: OptionKind::Choice { .. } => "u32",
}
}

    /// The number the pipeline constant `value` stands for: an `int`'s own, the value a
    /// `choice` picks read as a number; none for other kinds, or a choice that is no number.
pub fn number(self: *Self, value: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: OptionKind::Int { .. } => Some(value),
    // rust: OptionKind::Choice { values, .. } => values.get(value as usize)?.parse().ok(),
    // rust: _ => None,
}
}

    /// The default as the pipeline constant wgpu takes.
pub fn default_constant(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match *self {
    // rust: OptionKind::Bool { default } => f64::from(u8::from(default)),
    // rust: OptionKind::Float { default, .. } => f64::from(default),
    // rust: OptionKind::Int { default, .. } => f64::from(default),
    // rust: OptionKind::Choice { default, .. } => f64::from(default),
}
}
}
