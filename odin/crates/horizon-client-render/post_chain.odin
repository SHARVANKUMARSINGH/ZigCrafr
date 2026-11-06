//! Transpiled from Horizon Rust crate
package horizon_client_render_post_chain

import "core:fmt"
import "core:mem"
import "core:math"

// Vanilla's post-effect chains (`PostChainConfig`, `PostChain`, `PostPass`,
// `GameRenderer.preparePostEffects` / `applyPostEffects`): a `post_effect/*.json`
// names internal targets and passes (a vertex and a fragment shader, inputs read
// from targets, the target written, std140 uniform blocks) that run over the
// frame drawn so far, before the HUD.
//
// The JSON is read at run time from the active resource root, so a resource pack
// can replace or add chains. So are the shaders the passes name: their GLSL
// (`shaders/<path>.vsh` / `.fsh`, vanilla's or a pack's own) is translated to naga
// by `post_glsl` and bound as vanilla binds it (`SamplerInfo`, `Globals`, the pass's
// own uniform blocks, a sampler per input: a target's colour or depth, or a
// `textures/effect/` image). Horizon's own WGSL stand-ins (`post_chain.wgsl`) for the
// vanilla `core/screenquad`, `post/rotscale`, `post/invert`, `post/blit`, `post/bits`,
// `post/color_convolve`, `post/box_blur` and `post/spiderclip` are only the fallback
// for a pass whose GLSL is missing or does not translate. A chain that cannot load
// (an unknown shader without a stand-in, a target the frame has no equivalent of)
// fails like a chain that does not compile (`GameRenderer.failedPostEffects`), once,
// and is skipped.
//
// Every target keeps GL's rows (row 0 is the bottom edge): the frame is flipped into
// the chain's `main` and back, and each pass draws with clip y negated.
// use serde_json::Value;
// use std::collections::{BTreeMap, HashMap, HashSet};
// use std::path::{Path, PathBuf};
// use std::sync::mpsc;

// `PostChain.MAIN_TARGET_ID`.
MAIN :: "minecraft:main"
// `PostPass`'s uniform buffers are 128 bytes.
BLOCK_BYTES :: 128
// Our uniform buffers are bigger than the blocks they feed, so a shader that declares
// more than vanilla writes still binds.
UNIFORM_BYTES :: 256

// `ResourceLocation.withDefaultNamespace` on an id read from a chain.
normalise :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}

// One uniform of a block (`UniformValue`).
Uniform :: enum {
    Int(i32),
    IVec3([i32; 3]),
    Float(f32),
    Vec2([f32; 2]),
    Vec3([f32; 3]),
    Vec4([f32; 4]),
    Matrix([f32; 16]),
}

    // rust: impl Uniform {
    // std140 (alignment, size) in bytes: `Std140SizeCalculator`.
layout :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Uniform::Int(_) | Uniform::Float(_) => (4, 4),
    // rust: Uniform::Vec2(_) => (8, 8),
    // rust: Uniform::Vec3(_) | Uniform::IVec3(_) => (16, 12),
    // rust: Uniform::Vec4(_) => (16, 16),
    // rust: Uniform::Matrix(_) => (16, 64),
}
}

write :: proc(self: ^Self, out: ^[dynamic]u8) {
}
    // rust: match self {
    // rust: Uniform::Int(v) => out.extend_from_slice(&v.to_le_bytes()),
    // rust: Uniform::IVec3(v) => v
    // rust: .iter()
    // rust: .for_each(|x| out.extend_from_slice(&x.to_le_bytes())),
    // rust: Uniform::Float(v) => out.extend_from_slice(&v.to_le_bytes()),
    // rust: Uniform::Vec2(v) => v
    // rust: .iter()
    // rust: .for_each(|x| out.extend_from_slice(&x.to_le_bytes())),
    // rust: Uniform::Vec3(v) => v
    // rust: .iter()
    // rust: .for_each(|x| out.extend_from_slice(&x.to_le_bytes())),
    // rust: Uniform::Vec4(v) => v
    // rust: .iter()
    // rust: .for_each(|x| out.extend_from_slice(&x.to_le_bytes())),
    // rust: Uniform::Matrix(v) => v
    // rust: .iter()
    // rust: .for_each(|x| out.extend_from_slice(&x.to_le_bytes())),
}
}
}

// A uniform block in std140 order, as `PostPass` builds it with `Std140Builder`.
pack_block :: proc(values: ^[Uniform]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut bytes = Vec::new();
    // rust: for value in values {
    // rust: let (align, _) = value.layout();
    // rust: while bytes.len() % align != 0 {
    // rust: bytes.push(0);
}
    // rust: value.write(&mut bytes);
}
    // rust: if bytes.len() > BLOCK_BYTES {
    // rust: return Err(format!("a uniform block of {} bytes", bytes.len()));
}
    // rust: let mut block = [0u8; BLOCK_BYTES];
    // rust: block[..bytes.len()].copy_from_slice(&bytes);
    // rust: Ok(block)
}

// `PostChainConfig.InternalTarget`.
InternalTarget :: struct {
    width: Maybe(u32),
    height: Maybe(u32),
    persistent: bool,
    // `clear_color` as straight RGBA.
    clear: [f32,
}

// What an input reads: `PostChainConfig.TargetInput` or `TextureInput`.
Source :: enum {
    // A target's colour, or its depth buffer (`use_depth_buffer`).
    Target { id: String, depth: bool },
    // `textures/effect/<location>.png`.
    Texture { location: String },
}

// `PostChainConfig.Input`.
Input :: struct {
    sampler: string,
    source: Source,
    bilinear: bool,
}

// `PostChainConfig.Pass`.
PassConfig :: struct {
    vertex: string,
    fragment: string,
    inputs: [dynamic]Input,
    output: string,
    uniforms: BTreeMap<string,
}

// `PostChainConfig`.
Config :: struct {
    targets: BTreeMap<string,
    passes: [dynamic]PassConfig,
}

    // rust: fn floats<const N: usize>(v: &Value) -> Result<[f32; N], String> {
    // rust: let a = v
    // rust: .as_array()
    // rust: .filter(|a| a.len() == N)
    // rust: .ok_or("a vector of the wrong length")?;
    // rust: let mut out = [0.0; N];
    // rust: for (o, x) in out.iter_mut().zip(a) {
    // rust: *o = x.as_f64().ok_or("a vector entry that is not a number")? as f32;
}
    // rust: Ok(out)
}

uniform :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let kind = v["type"].as_str().ok_or("a uniform without a type")?;
    // rust: let value = &v["value"];
    // rust: Ok(match kind {
    // rust: "int" => Uniform::Int(value.as_i64().ok_or("a bad int")? as i32),
    // rust: "float" => Uniform::Float(value.as_f64().ok_or("a bad float")? as f32),
    // rust: "vec2" => Uniform::Vec2(floats(value)?),
    // rust: "vec3" => Uniform::Vec3(floats(value)?),
    // rust: "vec4" => Uniform::Vec4(floats(value)?),
    // rust: "ivec3" => {
    // rust: let a = value
    // rust: .as_array()
    // rust: .filter(|a| a.len() == 3)
    // rust: .ok_or("a bad ivec3")?;
    // rust: let mut out = [0; 3];
    // rust: for (o, x) in out.iter_mut().zip(a) {
    // rust: *o = x.as_i64().ok_or("a bad ivec3")? as i32;
}
    // rust: Uniform::IVec3(out)
}
    // rust: "matrix4x4" => {
    // rust: let flat: Vec<f32> = match value.as_array() {
    // rust: Some(rows) if rows.first().is_some_and(Value::is_array) => rows
    // rust: .iter()
    // rust: .flat_map(|r| r.as_array().into_iter().flatten())
    // rust: .filter_map(|x| x.as_f64().map(|x| x as f32))
    // rust: .collect(),
    // rust: Some(flat) => flat
    // rust: .iter()
    // rust: .filter_map(|x| x.as_f64().map(|x| x as f32))
    // rust: .collect(),
    // rust: None => Vec::new(),
}
    // rust: Uniform::Matrix(flat.try_into().map_err(|_| "a bad matrix4x4")?)
}
    // rust: other => return Err(format!("unknown uniform type {other}")),
    // rust: })
}

    // rust: impl Config {
    // `PostChainConfig.CODEC` over the file's text.
parse :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let json: Value = serde_json::from_str(text).map_err(|e| e.to_string())?;
    // rust: let mut targets = BTreeMap::new();
    // rust: if let Some(map) = json.get("targets").and_then(Value::as_object) {
    // rust: for (id, t) in map {
    // rust: let size = |key: &str| -> Result<Option<u32>, String> {
    // rust: match t.get(key) {
    // rust: None => Ok(None),
    // rust: Some(v) => match v.as_u64() {
    // rust: Some(n) if n > 0 => Ok(Some(n as u32)),
    // rust: _ => Err(format!("target {id}: a bad {key}")),
    // rust: },
}
}
    // rust: let argb = t.get("clear_color").and_then(Value::as_u64).unwrap_or(0) as u32;
    // rust: let [a, r, g, b] = [24, 16, 8, 0].map(|s| ((argb >> s) & 255) as f32 / 255.0);
    // rust: targets.insert(
    // rust: normalise(id),
    // rust: InternalTarget {
    // rust: width: size("width")?,
    // rust: height: size("height")?,
    // rust: persistent: t
    // rust: .get("persistent")
    // rust: .and_then(Value::as_bool)
    // rust: .unwrap_or(false),
    // rust: clear: [r, g, b, a],
    // rust: },
    // rust: );
}
}
    // rust: let mut passes = Vec::new();
    // rust: for (n, p) in json
    // rust: .get("passes")
    // rust: .and_then(Value::as_array)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .enumerate()
    // rust: {
    // rust: let text = |key: &str| -> Result<String, String> {
    // rust: p.get(key)
    // rust: .and_then(Value::as_str)
    // rust: .map(normalise)
    // rust: .ok_or(format!("pass {n}: no {key}"))
}
    // rust: let mut inputs: Vec<Input> = Vec::new();
    // rust: for i in p
    // rust: .get("inputs")
    // rust: .and_then(Value::as_array)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: let sampler = i["sampler_name"]
    // rust: .as_str()
    // rust: .ok_or(format!("pass {n}: an input without sampler_name"))?;
    // rust: if inputs.iter().any(|x| x.sampler == sampler) {
    // rust: return Err(format!("Encountered repeated sampler name: {sampler}"));
}
                // Codec.xor(TextureInput, TargetInput): exactly one of them parses.
    // rust: let source = match (i.get("location"), i.get("target")) {
    // rust: (Some(location), None) => {
    // rust: for key in ["width", "height"] {
    // rust: if !i.get(key).and_then(Value::as_u64).is_some_and(|v| v > 0) {
    // rust: return Err(format!("pass {n}: a texture input needs a {key}"));
}
}
    // rust: Source::Texture {
    // rust: location: normalise(
    // rust: location
    // rust: .as_str()
    // rust: .ok_or(format!("pass {n}: a bad location"))?,
    // rust: ),
}
}
    // rust: (None, Some(target)) => Source::Target {
    // rust: id: normalise(target.as_str().ok_or(format!("pass {n}: a bad target"))?),
    // rust: depth: i
    // rust: .get("use_depth_buffer")
    // rust: .and_then(Value::as_bool)
    // rust: .unwrap_or(false),
    // rust: },
    // rust: _ => return Err(format!("pass {n}: an input needs a location or a target")),
}
    // rust: inputs.push(Input {
    // rust: sampler: sampler.to_owned(),
    // rust: source,
    // rust: bilinear: i.get("bilinear").and_then(Value::as_bool).unwrap_or(false),
    // rust: });
}
    // rust: let mut uniforms = BTreeMap::new();
    // rust: if let Some(map) = p.get("uniforms").and_then(Value::as_object) {
    // rust: for (block, list) in map {
    // rust: let list = list
    // rust: .as_array()
    // rust: .ok_or(format!("pass {n}: a bad uniform block"))?;
    // rust: uniforms.insert(
    // rust: block.clone(),
    // rust: list.iter().map(uniform).collect::<Result<Vec<_>, _>>()?,
    // rust: );
}
}
    // rust: passes.push(PassConfig {
    // rust: vertex: text("vertex_shader")?,
    // rust: fragment: text("fragment_shader")?,
    // rust: inputs,
    // rust: output: text("output")?,
    // rust: uniforms,
    // rust: });
}
    // rust: Ok(Config { targets, passes })
}

    // `PostChain.getReferencedExternalTargets`.
external_targets :: proc(self: ^Self) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = HashSet::new();
    // rust: for p in &self.passes {
    // rust: let targets = p.inputs.iter().filter_map(|i| match &i.source {
    // rust: Source::Target { id, .. } => Some(id),
    // rust: Source::Texture { .. } => None,
    // rust: });
    // rust: for id in targets.chain([&p.output]) {
    // rust: if !self.targets.contains_key(id) {
    // rust: out.insert(id.as_str());
}
}
}
    // rust: out
}
}

// A stand-in for a vanilla vertex shader: its entry point and uniform block.
    // rust: const VERTEX: [(&str, &str, &str); 2] = [
    // rust: ("minecraft:core/screenquad", "vs_quad_gl", ""),
    // rust: ("minecraft:post/rotscale", "vs_rotscale", "RotScaleConfig"),
    // rust: ];
// The stand-ins are the fallback for a pass whose GLSL is missing or does not translate.
// A stand-in for a vanilla fragment shader: entry point, uniform block and the
// samplers it reads (`In`, then `Blur`).
    // rust: const FRAGMENT: [(&str, &str, &str, usize); 6] = [
    // rust: ("minecraft:post/invert", "fs_invert", "InvertConfig", 1),
    // rust: ("minecraft:post/blit", "fs_blit", "BlitConfig", 1),
    // rust: ("minecraft:post/bits", "fs_bits", "BitsConfig", 1),
    // rust: (
    // rust: "minecraft:post/color_convolve",
    // rust: "fs_color_convolve",
    // rust: "ColorConfig",
    // rust: 1,
    // rust: ),
    // rust: ("minecraft:post/box_blur", "fs_box_blur", "BlurConfig", 1),
    // rust: (
    // rust: "minecraft:post/spiderclip",
    // rust: "fs_spiderclip",
    // rust: "SpiderConfig",
    // rust: 2,
    // rust: ),
    // rust: ];
SAMPLERS :: ["In", "Blur"]

// A pass input resolved against the chain's targets.
Src :: enum {
    Target {,
    index: usize,
    depth: bool,
    // rust: },
    // `Chain::images`.
    Image(usize),
}

InputRef :: struct {
    src: Src,
    bilinear: bool,
}

// What a translated shader's uniform block is bound to.
Block :: enum {
    // `SamplerInfo`: `OutSize`, then each input's size.
    Info,
    // `Globals` (`GlobalSettingsUniform`).
    Globals,
    // One of the pass's `uniforms` groups.
    Custom(wgpu::Buffer),
}

// A pass running the resources' own GLSL, translated by `post_glsl`.
Translated :: struct {
    layout: wgpu::BindGroupLayout,
    vertex: wgpu::ShaderModule,
    fragment: wgpu::ShaderModule,
    pipelines: HashMap<wgpu::TextureFormat,
    // Binding and what it holds.
    blocks: Vec<(u32,
    // A sampler's texture binding (the sampler object follows) and the input it reads.
    samplers: Vec<(u32,
}

    // rust: impl Translated {
ensure_pipeline :: proc(self: ^Self, device: ^wgpu::Device, format: wgpu::TextureFormat) {
}
    // rust: if self.pipelines.contains_key(&format) {
    // rust: return;
}
    // rust: let layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Post effect"),
    // rust: bind_group_layouts: &[Some(&self.layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Post effect pass"),
    // rust: layout: Some(&layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &self.vertex,
    // rust: entry_point: Some("main"),
    // rust: buffers: &[],
    // rust: compilation_options: Default::default(),
    // rust: },
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &self.fragment,
    // rust: entry_point: Some("main"),
                // ColorTargetState.DEFAULT: no blending.
    // rust: targets: &[Some(format.into())],
    // rust: compilation_options: Default::default(),
    // rust: }),
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: self.pipelines.insert(format, pipeline);
}
}

Pass :: struct {
    // Every input in the chain's order (translated passes).
    refs: [dynamic]InputRef,
    translated: Maybe(Translated),
    vs: ^'static str,
    fs: ^'static str,
    // Per sampler slot: the target read and its filter.
    inputs: [(uint,
    output: uint,
    info: wgpu::Buffer,
    vs_block: wgpu::Buffer,
    fs_block: wgpu::Buffer,
}

// A loaded chain (`PostChain`): its targets are 0 = the frame, then the internal
// ones in id order.
Chain :: struct {
    targets: Vec<(string,
    passes: [dynamic]Pass,
    // Textures for `targets[1..]`, with the size they were made at.
    textures: Vec<(wgpu::Texture,
    // A depth buffer per target a pass reads the depth of (`DEFAULT_DEPTH`, cleared to 1;
    // the frame's own when it has one).
    depths: Vec<Option<(wgpu::Texture,
    // The `textures/effect/` images the passes read, with their size.
    images: Vec<(wgpu::Texture,
    size: [u32,
}

// What a frame asks for.
Request :: struct {
    // `GameRenderer.requestedPostEffects`, in order.
    effects: ^'a [string],
    // The active resource root (`assets/<namespace>/post_effect/<path>.json`).
    root: ^'a Path,
    // `menuBackgroundBlurriness`, the radius of a `box_blur` pass with `Radius` 0.
    menu_blur_radius: f32,
    // What the `Globals` block holds besides the screen size and the blur radius.
    globals: Globals,
}

// `GlobalSettingsUniform.update`'s other values.
Globals :: struct {
    camera_block_pos: [i32,
    glint_alpha: f32,
    // The camera's offset inside its block.
    camera_offset: [f32,
    // `(gameTime % 24000 + partialTick) / 24000`.
    game_time: f32,
    use_rgss: bool,
}

    // rust: impl Globals {
    // The std140 block: `ivec3, float, vec3, float, vec2, int, int`.
    // rust: pub(crate) fn bytes(&self, size: [u32; 2], menu_blur_radius: i32) -> [u8; 48] {
    // rust: let mut out = Vec::with_capacity(48);
    // rust: for v in self.camera_block_pos {
    // rust: out.extend_from_slice(&v.to_le_bytes());
}
    // rust: out.extend_from_slice(&self.glint_alpha.to_le_bytes());
    // rust: for v in self.camera_offset {
    // rust: out.extend_from_slice(&v.to_le_bytes());
}
    // rust: out.extend_from_slice(&self.game_time.to_le_bytes());
    // rust: out.extend_from_slice(&(size[0] as f32).to_le_bytes());
    // rust: out.extend_from_slice(&(size[1] as f32).to_le_bytes());
    // rust: out.extend_from_slice(&menu_blur_radius.to_le_bytes());
    // rust: out.extend_from_slice(&i32::from(self.use_rgss).to_le_bytes());
    // rust: out.try_into().expect("48 bytes")
}
}

    // rust: impl<'a> Request<'a> {
    // No chains.
none :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Request {
    // rust: effects: &[],
    // rust: root: Path::new(""),
    // rust: menu_blur_radius: 0.0,
    // rust: globals: Globals::default(),
}
}
}

// Every chain, the pipelines and the frame copy they work on.
PostEffects :: struct {
    layout: wgpu::BindGroupLayout,
    shader: wgpu::ShaderModule,
    pipelines: HashMap<(^'static str,
    nearest: wgpu::Sampler,
    bilinear: wgpu::Sampler,
    // `ShaderManager`'s chains by id; `None` when the file is missing.
    chains: HashMap<string,
    // `GameRenderer.failedPostEffects`.
    failed: map[string]struct{},
    root: PathBuf,
    // The frame as the chains see `minecraft:main`.
    work: Option<(wgpu::Texture,
    // The frame as copied, before it is flipped into `work`.
    staging: Option<(wgpu::Texture,
    // The flip between the frame and GL's rows.
    blit: Maybe(Pass),
    // The `Globals` block.
    globals: wgpu::Buffer,
    // Chains loading on a thread of their own ([`PostEffects::preload`]), for the
    // root they load from; `pending` until they arrive.
    preloading: Option<(PathBuf,
    pending: map[string]struct{},
}

// A chain [`PostEffects::preload`] loaded, by id.
    // rust: type Preloaded = (String, Result<Option<Chain>, String>);

// The chains a spectated entity applies (`GameRenderer.checkEntityPostEffect`): the
// first frame through a creeper's eyes compiled its pipelines, a 0.1-0.9 s freeze on
// the Mac mini.
    // rust: pub const SPECTATOR_CHAINS: [&str; 3] =
    // rust: ["minecraft:creeper", "minecraft:spider", "minecraft:invert"];

resource_path :: proc(root: ^Path, id: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: root.join("assets")
    // rust: .join(ns)
    // rust: .join("post_effect")
    // rust: .join(format!("{path}.json"))
}

    // rust: impl PostEffects {
new :: proc(device: ^wgpu::Device) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Post effects"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("post_chain.wgsl").into()),
    // rust: });
    // rust: let uniform = |binding| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
}
    // rust: let texture = |binding| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
}
    // rust: let sampler = |binding| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: count: None,
}
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Post effect bindings"),
    // rust: entries: &[
    // rust: uniform(0),
    // rust: uniform(1),
    // rust: uniform(2),
    // rust: texture(3),
    // rust: sampler(4),
    // rust: texture(5),
    // rust: sampler(6),
    // rust: ],
    // rust: });
        // SamplerCache.getClampToEdge.
    // rust: let make = |filter| {
    // rust: device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Post effect"),
    // rust: mag_filter: filter,
    // rust: min_filter: filter,
    // rust: address_mode_u: wgpu::AddressMode::ClampToEdge,
    // rust: address_mode_v: wgpu::AddressMode::ClampToEdge,
    // rust: ..Default::default()
    // rust: })
}
    // rust: Self {
    // rust: layout,
    // rust: shader,
    // rust: pipelines: HashMap::new(),
    // rust: nearest: make(wgpu::FilterMode::Nearest),
    // rust: bilinear: make(wgpu::FilterMode::Linear),
    // rust: chains: HashMap::new(),
    // rust: failed: HashSet::new(),
    // rust: preloading: None,
    // rust: pending: HashSet::new(),
    // rust: root: PathBuf::new(),
    // rust: work: None,
    // rust: staging: None,
    // rust: blit: None,
    // rust: globals: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Post effect globals"),
    // rust: size: UNIFORM_BYTES,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: }),
}
}

    // `GameRenderer.reloadPostEffects`-alike: forget chains loaded from another
    // root, and the failures with them (`shouldResetFailedPostEffects`).
use_root :: proc(self: ^Self, root: ^Path) {
}
    // rust: if self.root != root {
    // rust: self.root = root.to_owned();
    // rust: self.chains.clear();
    // rust: self.failed.clear();
    // rust: self.preloading = None;
    // rust: self.pending.clear();
}
}

    // Loads the `ids` chains (namespaced) not loaded yet and compiles their pipelines for
    // `format`, on a thread of their own: `apply` leaves a chain out until it has
    // arrived instead of compiling it in the frame that first asks for it.
    // rust: pub fn preload(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: root: &Path,
    // rust: ids: &[&str],
    // rust: format: wgpu::TextureFormat,
    // rust: ) {
    // rust: self.use_root(root);
    // rust: if self.preloading.is_some() {
    // rust: return;
}
    // rust: let ids: Vec<String> = ids
    // rust: .iter()
    // rust: .filter(|id| !self.chains.contains_key(**id) && !self.failed.contains(**id))
    // rust: .map(|id| normalise(id))
    // rust: .collect();
    // rust: if ids.is_empty() {
    // rust: return;
}
    // rust: let (tx, rx) = mpsc::channel();
    // rust: let (device, queue, root) = (device.clone(), queue.clone(), root.to_owned());
    // rust: let format = format.remove_srgb_suffix();
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("Post effects".into())
    // rust: .spawn({
    // rust: let ids = ids.clone();
    // rust: move || {
    // rust: for id in ids {
    // rust: let mut chain = Self::load(&root, &device, &queue, &id);
    // rust: if let Ok(Some(chain)) = &mut chain {
    // rust: for pass in &mut chain.passes {
    // rust: if let Some(translated) = &mut pass.translated {
    // rust: translated.ensure_pipeline(&device, format);
}
}
}
    // rust: if tx.send((id, chain)).is_err() {
    // rust: return;
}
}
}
    // rust: });
    // rust: if spawned.is_ok() {
    // rust: self.pending.extend(ids);
    // rust: self.preloading = Some((self.root.clone(), rx));
}
}

    // Takes the chains `preload` has finished.
collect_preloaded :: proc(self: ^Self) {
}
    // rust: let Some((root, rx)) = &self.preloading else {
    // rust: return;
}
    // rust: if *root != self.root {
    // rust: self.preloading = None;
    // rust: self.pending.clear();
    // rust: return;
}
    // rust: loop {
    // rust: match rx.try_recv() {
    // rust: Ok((id, loaded)) => {
    // rust: self.pending.remove(&id);
    // rust: let loaded = loaded.unwrap_or_else(|e| {
    // rust: log::warn!("Failed to load post effect {id}: {e}");
    // rust: self.failed.insert(id.clone());
    // rust: None
    // rust: });
    // rust: self.chains.insert(id, loaded);
}
    // rust: Err(mpsc::TryRecvError::Empty) => return,
    // rust: Err(mpsc::TryRecvError::Disconnected) => {
    // rust: self.preloading = None;
    // rust: self.pending.clear();
    // rust: return;
}
}
}
}

    // rust: fn pipeline(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: key: (&'static str, &'static str),
    // rust: format: wgpu::TextureFormat,
    // rust: ) -> &wgpu::RenderPipeline {
    // rust: let layout = &self.layout;
    // rust: let shader = &self.shader;
    // rust: self.pipelines
    // rust: .entry((key.0, key.1, format))
    // rust: .or_insert_with(|| {
    // rust: let pipeline_layout =
    // rust: device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Post effect"),
    // rust: bind_group_layouts: &[Some(layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Post effect pass"),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: shader,
    // rust: entry_point: Some(key.0),
    // rust: buffers: &[],
    // rust: compilation_options: Default::default(),
    // rust: },
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: shader,
    // rust: entry_point: Some(key.1),
                        // ColorTargetState.DEFAULT: no blending.
    // rust: targets: &[Some(format.into())],
    // rust: compilation_options: Default::default(),
    // rust: }),
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
    // rust: })
}

    // `PostChain.load` for the file of `id`: `Ok(None)` when it does not exist.
    // rust: fn load(
    // rust: root: &Path,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: id: &str,
    // rust: ) -> Result<Option<Chain>, String> {
    // rust: let Ok(text) = std::fs::read_to_string(resource_path(root, id)) else {
    // rust: return Ok(None);
}
    // rust: let config = Config::parse(&text)?;
        // isPostEffectValid / LevelTargetBundle.MAIN_TARGETS: the frame is the one
        // external target Horizon has.
    // rust: if let Some(bad) = config.external_targets().into_iter().find(|t| *t != MAIN) {
    // rust: return Err(format!(
    // rust: "Referenced external targets are not available in this context: [{bad}]"
    // rust: ));
}
    // rust: let targets: Vec<(String, InternalTarget)> = std::iter::once((
    // rust: MAIN.to_owned(),
    // rust: InternalTarget {
    // rust: width: None,
    // rust: height: None,
    // rust: persistent: true,
    // rust: clear: [0.0; 4],
    // rust: },
    // rust: ))
    // rust: .chain(config.targets.iter().map(|(k, v)| (k.clone(), v.clone())))
    // rust: .collect();
    // rust: let index = |name: &str| targets.iter().position(|(t, _)| t == name);
    // rust: let mut images = Vec::new();
    // rust: let mut passes = Vec::new();
    // rust: for (n, p) in config.passes.iter().enumerate() {
    // rust: let output = index(&p.output).ok_or("a target is missing")?;
    // rust: let pass =
    // rust: match Self::translated_pass(root, device, queue, n, p, output, &index, &mut images)
    // rust: {
    // rust: Ok(pass) => pass,
    // rust: Err(e) => match Self::standin_pass(device, queue, n, p, output, &index) {
    // rust: Ok(pass) => {
    // rust: log::debug!("post effect {id} pass {n} uses the built-in shaders: {e}");
    // rust: pass
}
    // rust: Err(_) => return Err(e),
    // rust: },
}
    // rust: passes.push(pass);
}
    // rust: Ok(Some(Chain {
    // rust: targets,
    // rust: passes,
    // rust: textures: Vec::new(),
    // rust: depths: Vec::new(),
    // rust: images,
    // rust: size: [0, 0],
    // rust: }))
}

    // A pass over the resources' own GLSL (`PostChain.createPass`).
    // rust: fn translated_pass(
    // rust: root: &Path,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: n: usize,
    // rust: p: &PassConfig,
    // rust: output: usize,
    // rust: index: &dyn Fn(&str) -> Option<usize>,
    // rust: images: &mut Vec<(wgpu::Texture, wgpu::TextureView, [u32; 2])>,
    // rust: ) -> Result<Pass, String> {
    // rust: let program = crate::post_glsl::translate(root, &p.vertex, &p.fragment)?;
    // rust: let mut refs = Vec::new();
    // rust: for input in &p.inputs {
    // rust: let src = match &input.source {
    // rust: Source::Target { id, depth } => {
    // rust: let target = index(id).ok_or("a target is missing")?;
    // rust: if target == output && !depth {
    // rust: return Err(format!("pass {n}: reads the target it writes"));
}
    // rust: Src::Target {
    // rust: index: target,
    // rust: depth: *depth,
}
}
    // rust: Source::Texture { location } => {
    // rust: images.push(Self::image(root, device, queue, location)?);
    // rust: Src::Image(images.len() - 1)
}
}
    // rust: refs.push(InputRef {
    // rust: src,
    // rust: bilinear: input.bilinear,
    // rust: });
}
    // rust: let mut pass = Pass::new(device, "", "", [(0, false); 2], output);
    // rust: let mut entries = Vec::new();
    // rust: let mut blocks = Vec::new();
    // rust: for (name, binding) in &program.blocks {
    // rust: let block = match name.as_str() {
    // rust: "SamplerInfo" => Block::Info,
    // rust: "Globals" => Block::Globals,
    // rust: other => {
    // rust: let values = p
    // rust: .uniforms
    // rust: .get(other)
    // rust: .ok_or(format!("pass {n}: the uniform block {other} is missing"))?;
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Post effect uniforms"),
    // rust: size: UNIFORM_BYTES,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: queue.write_buffer(&buffer, 0, &pack_block(values)?);
    // rust: Block::Custom(buffer)
}
}
    // rust: entries.push(wgpu::BindGroupLayoutEntry {
    // rust: binding: *binding,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: });
    // rust: blocks.push((*binding, block));
}
    // rust: let mut samplers = Vec::new();
    // rust: for (name, texture) in &program.samplers {
    // rust: let input = name.strip_suffix("Sampler").unwrap_or(name);
    // rust: let slot = p
    // rust: .inputs
    // rust: .iter()
    // rust: .position(|i| i.sampler == input)
    // rust: .ok_or(format!("pass {n}: no input for the sampler {name}"))?;
            // A depth buffer is read unfiltered.
    // rust: let depth = matches!(refs[slot].src, Src::Target { depth: true, .. });
    // rust: entries.push(wgpu::BindGroupLayoutEntry {
    // rust: binding: *texture,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: !depth },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: });
    // rust: entries.push(wgpu::BindGroupLayoutEntry {
    // rust: binding: texture + 1,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(if depth {
    // rust: wgpu::SamplerBindingType::NonFiltering
    // rust: } else {
    // rust: wgpu::SamplerBindingType::Filtering
    // rust: }),
    // rust: count: None,
    // rust: });
    // rust: samplers.push((*texture, slot));
}
    // rust: let module = |module: naga::Module| {
    // rust: device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Post effect shader"),
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(module)),
    // rust: })
}
    // rust: pass.refs = refs;
    // rust: pass.translated = Some(Translated {
    // rust: layout: device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Post effect bindings"),
    // rust: entries: &entries,
    // rust: }),
    // rust: vertex: module(program.vertex),
    // rust: fragment: module(program.fragment),
    // rust: pipelines: HashMap::new(),
    // rust: blocks,
    // rust: samplers,
    // rust: });
    // rust: Ok(pass)
}

    // A pass over Horizon's WGSL stand-ins for the vanilla post shaders.
    // rust: fn standin_pass(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: n: usize,
    // rust: p: &PassConfig,
    // rust: output: usize,
    // rust: index: &dyn Fn(&str) -> Option<usize>,
    // rust: ) -> Result<Pass, String> {
    // rust: let &(_, vs, vs_block) = VERTEX
    // rust: .iter()
    // rust: .find(|v| v.0 == p.vertex)
    // rust: .ok_or(format!("pass {n}: no vertex shader {}", p.vertex))?;
    // rust: let &(_, fs, fs_block, samplers) = FRAGMENT
    // rust: .iter()
    // rust: .find(|f| f.0 == p.fragment)
    // rust: .ok_or(format!("pass {n}: no fragment shader {}", p.fragment))?;
    // rust: let mut inputs = [(0, false); 2];
    // rust: for (slot, name) in SAMPLERS.iter().enumerate().take(samplers) {
    // rust: let input = p
    // rust: .inputs
    // rust: .iter()
    // rust: .find(|i| i.sampler == *name)
    // rust: .ok_or(format!("pass {n}: {} needs the sampler {name}", p.fragment))?;
    // rust: let Source::Target { id, depth: false } = &input.source else {
    // rust: return Err(format!(
    // rust: "pass {n}: the built-in shaders read target colours"
    // rust: ));
}
    // rust: let target = index(id).ok_or("a target is missing")?;
    // rust: if target == output {
    // rust: return Err(format!("pass {n}: reads the target it writes"));
}
    // rust: inputs[slot] = (target, input.bilinear);
}
        // A shader reading one sampler binds the same texture to the other,
        // never the target it writes.
    // rust: if samplers == 1 {
    // rust: inputs[1] = inputs[0];
}
    // rust: let block = |name: &str| match p.uniforms.get(name) {
    // rust: Some(values) => pack_block(values),
    // rust: None if name.is_empty() => Ok([0; BLOCK_BYTES]),
    // rust: None => Err(format!("pass {n}: the uniform block {name} is missing")),
}
    // rust: let pass = Pass::new(device, vs, fs, inputs, output);
    // rust: queue.write_buffer(&pass.vs_block, 0, &block(vs_block)?);
    // rust: queue.write_buffer(&pass.fs_block, 0, &block(fs_block)?);
    // rust: Ok(pass)
}

    // `textures/effect/<location>.png` as a texture (`PostChain.createPass`'s `TextureInput`).
    // rust: fn image(
    // rust: root: &Path,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: location: &str,
    // rust: ) -> Result<(wgpu::Texture, wgpu::TextureView, [u32; 2]), String> {
    // rust: let (ns, path) = location.split_once(':').unwrap_or(("minecraft", location));
    // rust: let file = root
    // rust: .join("assets")
    // rust: .join(ns)
    // rust: .join("textures/effect")
    // rust: .join(format!("{path}.png"));
    // rust: let mut decoder = png::Decoder::new(std::io::BufReader::new(
    // rust: std::fs::File::open(&file).map_err(|e| format!("{}: {e}", file.display()))?,
    // rust: ));
        // As the other resource-pack images: stb_image never checks chunk CRCs.
    // rust: decoder.ignore_checksums(true);
    // rust: decoder.set_transformations(png::Transformations::EXPAND | png::Transformations::STRIP_16);
    // rust: let mut reader = decoder.read_info().map_err(|e| e.to_string())?;
    // rust: let mut data = vec![0; reader.output_buffer_size().ok_or("a huge image")?];
    // rust: let info = reader.next_frame(&mut data).map_err(|e| e.to_string())?;
    // rust: let rgba: Vec<u8> = match info.color_type {
    // rust: png::ColorType::Rgba => data[..info.buffer_size()].to_vec(),
    // rust: png::ColorType::Rgb => data[..info.buffer_size()]
    // rust: .as_chunks::<3>()
    // rust: .0
    // rust: .iter()
    // rust: .flat_map(|p| [p[0], p[1], p[2], 255])
    // rust: .collect(),
    // rust: png::ColorType::Grayscale => data[..info.buffer_size()]
    // rust: .iter()
    // rust: .flat_map(|g| [*g, *g, *g, 255])
    // rust: .collect(),
    // rust: png::ColorType::GrayscaleAlpha => data[..info.buffer_size()]
    // rust: .as_chunks::<2>()
    // rust: .0
    // rust: .iter()
    // rust: .flat_map(|p| [p[0], p[0], p[0], p[1]])
    // rust: .collect(),
    // rust: png::ColorType::Indexed => return Err("an indexed image".into()),
}
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Post effect image"),
    // rust: size: wgpu::Extent3d {
    // rust: width: info.width,
    // rust: height: info.height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: queue.write_texture(
    // rust: texture.as_image_copy(),
    // rust: &rgba,
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(info.width * 4),
    // rust: rows_per_image: Some(info.height),
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width: info.width,
    // rust: height: info.height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
    // rust: let view = texture.create_view(&Default::default());
    // rust: Ok((texture, view, [info.width, info.height]))
}

    // rust: fn texture(
    // rust: device: &wgpu::Device,
    // rust: format: wgpu::TextureFormat,
    // rust: size: [u32; 2],
    // rust: ) -> (wgpu::Texture, wgpu::TextureView) {
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Post effect target"),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = texture.create_view(&Default::default());
    // rust: (texture, view)
}

    // Runs the chains `req` names over `frame` (the frame's texture, copied from)
    // and puts the result on `target` (its view): `GameRenderer.preparePostEffects`
    // then `applyPostEffects`. `frame` must allow `COPY_SRC`. `depth` is the frame's
    // depth buffer, for a pass that reads the depth of `minecraft:main` (it must
    // allow `TEXTURE_BINDING`; without it that depth reads as 1). Returns whether
    // any chain ran.
    // rust: pub fn apply(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: frame: &wgpu::Texture,
    // rust: target: &wgpu::TextureView,
    // rust: size: [u32; 2],
    // rust: depth: Option<&wgpu::TextureView>,
    // rust: req: &Request,
    // rust: mut timing: Option<&mut crate::gfx::pack_timing::PassTiming>,
    // rust: ) -> bool {
    // rust: self.use_root(req.root);
    // rust: self.collect_preloaded();
    // rust: let mut applied = Vec::new();
    // rust: for effect in req.effects {
    // rust: let id = normalise(effect);
            // A chain still compiling on `preload`'s thread waits for it.
    // rust: if self.failed.contains(&id) || applied.contains(&id) || self.pending.contains(&id) {
    // rust: continue;
}
    // rust: if !self.chains.contains_key(&id) {
    // rust: let loaded = match Self::load(&self.root, device, queue, &id) {
    // rust: Ok(chain) => chain,
    // rust: Err(e) => {
    // rust: log::warn!("Failed to load post effect {id}: {e}");
    // rust: self.failed.insert(id.clone());
    // rust: None
}
}
    // rust: self.chains.insert(id.clone(), loaded);
}
    // rust: if matches!(self.chains.get(&id), Some(Some(_))) {
    // rust: applied.push(id);
}
}
    // rust: if applied.is_empty() {
    // rust: return false;
}
    // rust: let format = frame.format().remove_srgb_suffix();
    // rust: if self.work.as_ref().is_none_or(|(t, _)| {
    // rust: t.size().width != size[0] || t.size().height != size[1] || t.format() != format
    // rust: }) {
    // rust: self.work = Some(Self::texture(device, format, size));
}
    // rust: if self.staging.as_ref().is_none_or(|(t, _)| {
    // rust: t.size().width != size[0] || t.size().height != size[1] || t.format() != format
    // rust: }) {
    // rust: self.staging = Some(Self::texture(device, format, size));
}
    // rust: queue.write_buffer(
    // rust: &self.globals,
    // rust: 0,
    // rust: &req.globals.bytes(size, req.menu_blur_radius as i32),
    // rust: );
    // rust: if self.blit.is_none() {
    // rust: let pass = Pass::new(device, "vs_quad", "fs_blit", [(0, false); 2], 0);
    // rust: queue.write_buffer(&pass.vs_block, 0, &[0; BLOCK_BYTES]);
    // rust: queue.write_buffer(
    // rust: &pass.fs_block,
    // rust: 0,
    // rust: &[1.0f32; 32].map(f32::to_le_bytes).concat(),
    // rust: );
    // rust: self.blit = Some(pass);
}
    // rust: let copy_size = wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
}
    // rust: let work = self.work.take().expect("made above");
    // rust: let staging = self.staging.take().expect("made above");
    // rust: let blit = self.blit.take().expect("made above");
        // The chains see GL's rows: flip the frame in, and back out below.
    // rust: encoder.copy_texture_to_texture(
    // rust: frame.as_image_copy(),
    // rust: staging.0.as_image_copy(),
    // rust: copy_size,
    // rust: );
    // rust: self.run_pass(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: &blit,
    // rust: [(&staging.1, size), (&staging.1, size)],
    // rust: (&work.1, size),
    // rust: 0.0,
    // rust: format,
    // rust: timing.as_deref_mut(),
    // rust: );
    // rust: self.staging = Some(staging);
    // rust: for id in &applied {
    // rust: let mut chain = self.chains.remove(id).flatten().expect("loaded above");
    // rust: self.run_chain(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: &work.1,
    // rust: &mut chain,
    // rust: size,
    // rust: depth,
    // rust: req.menu_blur_radius,
    // rust: format,
    // rust: timing.as_deref_mut(),
    // rust: );
    // rust: self.chains.insert(id.clone(), Some(chain));
}
        // The frame, as the chains left it.
    // rust: self.run_pass(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: &blit,
    // rust: [(&work.1, size), (&work.1, size)],
    // rust: (target, size),
    // rust: 0.0,
    // rust: format,
    // rust: timing,
    // rust: );
    // rust: self.blit = Some(blit);
    // rust: self.work = Some(work);
    // rust: true
}

    // rust: fn run_chain(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: main: &wgpu::TextureView,
    // rust: chain: &mut Chain,
    // rust: size: [u32; 2],
    // rust: main_depth: Option<&wgpu::TextureView>,
    // rust: menu_radius: f32,
    // rust: format: wgpu::TextureFormat,
    // rust: mut timing: Option<&mut crate::gfx::pack_timing::PassTiming>,
    // rust: ) {
    // rust: for pass in &mut chain.passes {
    // rust: if let Some(translated) = &mut pass.translated {
    // rust: translated.ensure_pipeline(device, format);
}
}
    // rust: let sizes: Vec<[u32; 2]> = chain
    // rust: .targets
    // rust: .iter()
    // rust: .map(|(_, t)| [t.width.unwrap_or(size[0]), t.height.unwrap_or(size[1])])
    // rust: .collect();
        // PostChain.addToFrame: internal targets at their size, cleared to their
        // colour; a persistent one only when it is made.
    // rust: let remade = chain.size != size || chain.textures.len() + 1 != chain.targets.len();
    // rust: if remade {
    // rust: chain.size = size;
    // rust: chain.textures = sizes[1..]
    // rust: .iter()
    // rust: .map(|s| Self::texture(device, format, *s))
    // rust: .collect();
    // rust: let mut wanted = vec![false; chain.targets.len()];
    // rust: for r in chain.passes.iter().flat_map(|p| &p.refs) {
    // rust: if let Src::Target { index, depth: true } = r.src {
    // rust: wanted[index] = true;
}
}
    // rust: chain.depths = wanted
    // rust: .iter()
    // rust: .zip(&sizes)
    // rust: .map(|(wanted, s)| {
    // rust: wanted.then(|| {
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Post effect depth"),
    // rust: size: wgpu::Extent3d {
    // rust: width: s[0],
    // rust: height: s[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::RENDER_ATTACHMENT,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = texture.create_view(&Default::default());
    // rust: (texture, view)
    // rust: })
    // rust: })
    // rust: .collect();
}
        // The depth of a target nothing draws depth into stays at the far plane.
    // rust: for (i, depth) in chain.depths.iter().enumerate() {
    // rust: if let Some((_, view)) = depth
    // rust: && !(i == 0 && main_depth.is_some())
    // rust: {
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Post effect depth clear"),
    // rust: timestamp_writes: timing.as_deref_mut().and_then(|t| t.writes("Post clear")),
    // rust: color_attachments: &[],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(1.0),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
}
}
    // rust: for (i, (_, t)) in chain.targets.iter().enumerate().skip(1) {
    // rust: if remade || !t.persistent {
    // rust: let c = t.clear.map(f64::from);
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Post effect target clear"),
    // rust: timestamp_writes: timing.as_deref_mut().and_then(|t| t.writes("Post clear")),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &chain.textures[i - 1].1,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color {
    // rust: r: c[0],
    // rust: g: c[1],
    // rust: b: c[2],
    // rust: a: c[3],
    // rust: }),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
}
}
    // rust: let chain = &*chain;
    // rust: let view = |i: usize| {
    // rust: if i == 0 {
    // rust: main
    // rust: } else {
    // rust: &chain.textures[i - 1].1
}
}
    // rust: let depth_view = |i: usize| match (i, main_depth) {
    // rust: (0, Some(depth)) => depth,
    // rust: _ => &chain.depths[i].as_ref().expect("made for the pass").1,
}
    // rust: for pass in &chain.passes {
    // rust: if let Some(translated) = &pass.translated {
    // rust: let inputs: Vec<(&wgpu::TextureView, [u32; 2])> = pass
    // rust: .refs
    // rust: .iter()
    // rust: .map(|r| match r.src {
    // rust: Src::Target {
    // rust: index,
    // rust: depth: false,
    // rust: } => (view(index), sizes[index]),
    // rust: Src::Target { index, depth: true } => (depth_view(index), sizes[index]),
    // rust: Src::Image(i) => (&chain.images[i].1, chain.images[i].2),
    // rust: })
    // rust: .collect();
    // rust: self.draw_translated(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: pass,
    // rust: translated,
    // rust: &inputs,
    // rust: (view(pass.output), sizes[pass.output]),
    // rust: format,
    // rust: timing.as_deref_mut(),
    // rust: );
    // rust: continue;
}
    // rust: let [a, b] = pass.inputs.map(|(t, _)| (view(t), sizes[t]));
    // rust: self.run_pass(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: pass,
    // rust: [a, b],
    // rust: (view(pass.output), sizes[pass.output]),
    // rust: menu_radius,
    // rust: format,
    // rust: timing.as_deref_mut(),
    // rust: );
}
}

    // `PostPass.addToFrame`'s execution for a translated pass.
    // rust: fn draw_translated(
    // rust: &self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: pass: &Pass,
    // rust: translated: &Translated,
    // rust: inputs: &[(&wgpu::TextureView, [u32; 2])],
    // rust: output: (&wgpu::TextureView, [u32; 2]),
    // rust: format: wgpu::TextureFormat,
    // rust: timing: Option<&mut crate::gfx::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let Some(pipeline) = translated.pipelines.get(&format) else {
    // rust: return;
}
        // SamplerInfo: OutSize, then each input's size.
    // rust: let sizes = std::iter::once(output.1).chain(inputs.iter().map(|i| i.1));
    // rust: let info: Vec<u8> = sizes
    // rust: .flat_map(|s| s.map(|v| (v as f32).to_le_bytes()))
    // rust: .flatten()
    // rust: .collect();
    // rust: queue.write_buffer(
    // rust: &pass.info,
    // rust: 0,
    // rust: &info[..info.len().min(UNIFORM_BYTES as usize)],
    // rust: );
    // rust: let mut entries = Vec::new();
    // rust: for (binding, block) in &translated.blocks {
    // rust: let buffer = match block {
    // rust: Block::Info => &pass.info,
    // rust: Block::Globals => &self.globals,
    // rust: Block::Custom(buffer) => buffer,
}
    // rust: entries.push(wgpu::BindGroupEntry {
    // rust: binding: *binding,
    // rust: resource: buffer.as_entire_binding(),
    // rust: });
}
    // rust: for (binding, slot) in &translated.samplers {
    // rust: let ref_ = &pass.refs[*slot];
    // rust: let depth = matches!(ref_.src, Src::Target { depth: true, .. });
    // rust: entries.push(wgpu::BindGroupEntry {
    // rust: binding: *binding,
    // rust: resource: wgpu::BindingResource::TextureView(inputs[*slot].0),
    // rust: });
    // rust: entries.push(wgpu::BindGroupEntry {
    // rust: binding: binding + 1,
    // rust: resource: wgpu::BindingResource::Sampler(if ref_.bilinear && !depth {
    // rust: &self.bilinear
    // rust: } else {
    // rust: &self.nearest
    // rust: }),
    // rust: });
}
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Post effect pass"),
    // rust: layout: &translated.layout,
    // rust: entries: &entries,
    // rust: });
    // rust: let mut rp = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Post effect pass"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("Post effect")),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: output.0,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: rp.set_pipeline(pipeline);
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: rp.draw(0..3, 0..1);
}

    // `PostPass.addToFrame`'s execution: one fullscreen triangle.
    // rust: fn run_pass(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: pass: &Pass,
    // rust: inputs: [(&wgpu::TextureView, [u32; 2]); 2],
    // rust: output: (&wgpu::TextureView, [u32; 2]),
    // rust: menu_radius: f32,
    // rust: format: wgpu::TextureFormat,
    // rust: timing: Option<&mut crate::gfx::pack_timing::PassTiming>,
    // rust: ) {
        // SamplerInfo: OutSize, then each input's size.
    // rust: let info = [
    // rust: output.1[0] as f32,
    // rust: output.1[1] as f32,
    // rust: inputs[0].1[0] as f32,
    // rust: inputs[0].1[1] as f32,
    // rust: inputs[1].1[0] as f32,
    // rust: inputs[1].1[1] as f32,
    // rust: menu_radius,
    // rust: 0.0,
    // rust: ];
    // rust: queue.write_buffer(&pass.info, 0, &info.map(f32::to_le_bytes).concat());
    // rust: self.pipeline(device, (pass.vs, pass.fs), format);
    // rust: let Some(pipeline) = self.pipelines.get(&(pass.vs, pass.fs, format)) else {
    // rust: return;
}
    // rust: let sampler = |bilinear| {
    // rust: if bilinear {
    // rust: &self.bilinear
    // rust: } else {
    // rust: &self.nearest
}
}
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Post effect pass"),
    // rust: layout: &self.layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: pass.info.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: pass.vs_block.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: pass.fs_block.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(inputs[0].0),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: wgpu::BindingResource::Sampler(sampler(pass.inputs[0].1)),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 5,
    // rust: resource: wgpu::BindingResource::TextureView(inputs[1].0),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 6,
    // rust: resource: wgpu::BindingResource::Sampler(sampler(pass.inputs[1].1)),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let mut rp = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Post effect pass"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("Post effect")),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: output.0,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: rp.set_pipeline(pipeline);
    // rust: rp.set_bind_group(0, &group, &[]);
    // rust: rp.draw(0..3, 0..1);
}
}

    // rust: impl Pass {
    // rust: fn new(
    // rust: device: &wgpu::Device,
    // rust: vs: &'static str,
    // rust: fs: &'static str,
    // rust: inputs: [(usize, bool); 2],
    // rust: output: usize,
    // rust: ) -> Self {
    // rust: let buffer = |label, size| {
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(label),
    // rust: size,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: })
}
    // rust: Pass {
    // rust: vs,
    // rust: fs,
    // rust: inputs,
    // rust: output,
    // rust: info: buffer("Post effect sampler info", UNIFORM_BYTES),
    // rust: vs_block: buffer("Post effect vertex uniforms", BLOCK_BYTES as u64),
    // rust: fs_block: buffer("Post effect fragment uniforms", BLOCK_BYTES as u64),
    // rust: refs: Vec::new(),
    // rust: translated: None,
}
}
}

    // rust: mod tests {
//     use super::*;

    // rust: const INVERT_THEN_BLIT: &str = r#"{
    // rust: "targets": { "swap": {} },
    // rust: "passes": [
    // rust: { "vertex_shader": "minecraft:core/screenquad",
    // rust: "fragment_shader": "minecraft:post/invert",
    // rust: "inputs": [ { "sampler_name": "In", "target": "minecraft:main" } ],
    // rust: "output": "swap",
    // rust: "uniforms": { "InvertConfig": [ { "name": "InverseAmount", "type": "float", "value": 1.0 } ] } },
    // rust: { "vertex_shader": "minecraft:core/screenquad",
    // rust: "fragment_shader": "minecraft:post/blit",
    // rust: "inputs": [ { "sampler_name": "In", "target": "swap", "bilinear": true } ],
    // rust: "output": "minecraft:main",
    // rust: "uniforms": { "BlitConfig": [ { "name": "ColorModulate", "type": "vec4", "value": [1.0, 0.0, 0.5, 1.0] } ] } }
    // rust: ]
    // rust: }"#;

shaders_validate :: proc() {
}
    // rust: let module = naga::front::wgsl::parse_str(include_str!("post_chain.wgsl")).unwrap();
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap();
}

a_chain_is_read_like_postchainconfig :: proc() {
}
    // rust: let config = Config::parse(INVERT_THEN_BLIT).unwrap();
        // Ids without a namespace are minecraft's.
    // rust: assert_eq!(
    // rust: config.targets.keys().collect::<Vec<_>>(),
    // rust: ["minecraft:swap"]
    // rust: );
    // rust: assert_eq!(config.passes.len(), 2);
    // rust: assert_eq!(config.passes[0].output, "minecraft:swap");
    // rust: assert_eq!(
    // rust: config.passes[1].inputs,
    // rust: [Input {
    // rust: sampler: "In".into(),
    // rust: source: Source::Target {
    // rust: id: "minecraft:swap".into(),
    // rust: depth: false
    // rust: },
    // rust: bilinear: true
    // rust: }]
    // rust: );
    // rust: assert_eq!(
    // rust: config.passes[1].uniforms["BlitConfig"],
    // rust: [Uniform::Vec4([1.0, 0.0, 0.5, 1.0])]
    // rust: );
        // Only the frame is outside the chain.
    // rust: assert_eq!(config.external_targets(), HashSet::from(["minecraft:main"]));
}

target_options_and_clear_colour :: proc() {
}
    // rust: let config = Config::parse(
    // rust: r#"{"targets":{"a":{"width":16,"height":8,"persistent":true,"clear_color":2180972544}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let t = &config.targets["minecraft:a"];
    // rust: assert_eq!((t.width, t.height, t.persistent), (Some(16), Some(8), true));
        // 0x81FF0000: alpha 129, red 255.
    // rust: assert_eq!(t.clear, [1.0, 0.0, 0.0, 129.0 / 255.0]);
    // rust: assert!(Config::parse(r#"{"targets":{"a":{"width":0}}}"#).is_err());
}

inputs_are_checked :: proc() {
}
    // rust: let pass = |inputs: &str| {
    // rust: format!(
    // rust: r#"{{"passes":[{{"vertex_shader":"a","fragment_shader":"b","output":"o","inputs":{inputs}}}]}}"#
    // rust: )
}
        // Repeated sampler names are refused.
    // rust: assert!(
    // rust: Config::parse(&pass(
    // rust: r#"[{"sampler_name":"In","target":"x"},{"sampler_name":"In","target":"y"}]"#
    // rust: ))
    // rust: .is_err()
    // rust: );
        // A texture input needs its size; an input is a target or a texture, not both.
    // rust: assert!(Config::parse(&pass(r#"[{"sampler_name":"In","location":"noise"}]"#)).is_err());
    // rust: assert!(
    // rust: Config::parse(&pass(
    // rust: r#"[{"sampler_name":"In","location":"noise","target":"x","width":4,"height":4}]"#
    // rust: ))
    // rust: .is_err()
    // rust: );
    // rust: let config = Config::parse(&pass(
    // rust: r#"[{"sampler_name":"A","location":"noise","width":4,"height":4,"bilinear":true},
    // rust: {"sampler_name":"B","target":"x","use_depth_buffer":true}]"#,
    // rust: ))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: config.passes[0].inputs[0].source,
    // rust: Source::Texture {
    // rust: location: "minecraft:noise".into()
}
    // rust: );
    // rust: assert_eq!(
    // rust: config.passes[0].inputs[1].source,
    // rust: Source::Target {
    // rust: id: "minecraft:x".into(),
    // rust: depth: true
}
    // rust: );
        // Only targets can be external.
    // rust: assert_eq!(
    // rust: config.external_targets(),
    // rust: HashSet::from(["minecraft:x", "minecraft:o"])
    // rust: );
}

blocks_are_packed_as_std140 :: proc() {
}
        // BlurConfig { vec2 BlurDir; float Radius }.
    // rust: let block = pack_block(&[Uniform::Vec2([1.0, 0.0]), Uniform::Float(7.0)]).unwrap();
    // rust: let words: Vec<f32> = block
    // rust: .chunks(4)
    // rust: .map(|c| f32::from_le_bytes(c.try_into().unwrap()))
    // rust: .collect();
    // rust: assert_eq!(words[..3], [1.0, 0.0, 7.0]);
        // ColorConfig { vec3, vec3, vec3 }: each starts on 16 bytes.
    // rust: let block = pack_block(&[
    // rust: Uniform::Vec3([1.0, 2.0, 3.0]),
    // rust: Uniform::Vec3([4.0, 5.0, 6.0]),
    // rust: ])
    // rust: .unwrap();
    // rust: let words: Vec<f32> = block
    // rust: .chunks(4)
    // rust: .map(|c| f32::from_le_bytes(c.try_into().unwrap()))
    // rust: .collect();
    // rust: assert_eq!(words[..7], [1.0, 2.0, 3.0, 0.0, 4.0, 5.0, 6.0]);
        // RotScaleConfig { vec2, vec2, float }.
    // rust: let block = pack_block(&[
    // rust: Uniform::Vec2([1.0, 2.0]),
    // rust: Uniform::Vec2([3.0, 4.0]),
    // rust: Uniform::Float(5.0),
    // rust: ])
    // rust: .unwrap();
    // rust: let words: Vec<f32> = block
    // rust: .chunks(4)
    // rust: .map(|c| f32::from_le_bytes(c.try_into().unwrap()))
    // rust: .collect();
    // rust: assert_eq!(words[..5], [1.0, 2.0, 3.0, 4.0, 5.0]);
    // rust: assert!(pack_block(&[Uniform::Matrix([0.0; 16]); 3]).is_err());
}

device :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

scratch :: proc(name: string, json: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-post-chain-{}-{name}", std::process::id()));
    // rust: let dir = root.join("assets/minecraft/post_effect");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join(format!("{name}.json")), json).unwrap();
    // rust: root
}

    // rust: fn run(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: effects: &mut PostEffects,
    // rust: root: &Path,
    // rust: names: &[String],
    // rust: ) -> (bool, [u8; 4]) {
    // rust: let frame = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 8,
    // rust: height: 4,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = frame.create_view(&Default::default());
    // rust: let scope = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
        // The frame drawn so far: (0.2, 0.4, 0.6).
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color {
    // rust: r: 0.2,
    // rust: g: 0.4,
    // rust: b: 0.6,
    // rust: a: 1.0,
    // rust: }),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: let ran = effects.apply(
    // rust: device,
    // rust: queue,
    // rust: &mut encoder,
    // rust: &frame,
    // rust: &view,
    // rust: [8, 4],
    // rust: None,
    // rust: &Request {
    // rust: effects: names,
    // rust: root,
    // rust: menu_blur_radius: 5.0,
    // rust: globals: Globals::default(),
    // rust: },
    // rust: None,
    // rust: );
    // rust: let buffer = crate::gfx::copy_frame(device, &mut encoder, &frame, [8, 4]);
    // rust: queue.submit([encoder.finish()]);
    // rust: if let Some(error) = pollster::block_on(scope.pop()) {
    // rust: panic!("{error}");
}
    // rust: buffer.map_async(wgpu::MapMode::Read, .., |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let data = buffer.get_mapped_range(..).unwrap();
    // rust: (ran, [data[0], data[1], data[2], data[3]])
}

    // The chain runs over the frame and the result lands on it: invert into
    // `swap`, then a blit modulated by (1, 0, 0.5, 1) back onto the frame.
a_chain_draws_onto_the_frame :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let root = scratch("invert_then_blit", INVERT_THEN_BLIT);
    // rust: let mut effects = PostEffects::new(&device);
    // rust: let names = ["minecraft:invert_then_blit".to_owned()];
    // rust: let (ran, px) = run(&device, &queue, &mut effects, &root, &names);
    // rust: assert!(ran);
        // (0.8, 0.6, 0.4) * (1, 0, 0.5): 204, 0, 51.
    // rust: let near = |a: u8, b: u8| a.abs_diff(b) <= 2;
    // rust: assert!(
    // rust: near(px[0], 204) && px[1] == 0 && near(px[2], 51) && px[3] == 255,
    // rust: "{px:?}"
    // rust: );
        // A second frame is the same (the chain and its targets are reused).
    // rust: let (_, again) = run(&device, &queue, &mut effects, &root, &names);
    // rust: assert_eq!(again, px);
        // Missing chains and a chain that does not load change nothing.
    // rust: let (ran, px) = run(
    // rust: &device,
    // rust: &queue,
    // rust: &mut effects,
    // rust: &root,
    // rust: &["minecraft:nothing".to_owned()],
    // rust: );
    // rust: assert!(!ran);
    // rust: assert!(
    // rust: near(px[0], 51) && near(px[1], 102) && near(px[2], 153),
    // rust: "{px:?}"
    // rust: );
    // rust: std::fs::remove_dir_all(root).unwrap();
}

a_chain_naming_an_unknown_shader_fails_once :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let root = scratch(
    // rust: "unknown",
    // rust: r#"{"passes":[{"vertex_shader":"minecraft:core/screenquad","fragment_shader":"minecraft:post/nope",
    // rust: "inputs":[{"sampler_name":"In","target":"minecraft:main"}],"output":"minecraft:main"}]}"#,
    // rust: );
    // rust: let mut effects = PostEffects::new(&device);
    // rust: let names = ["minecraft:unknown".to_owned()];
    // rust: assert!(!run(&device, &queue, &mut effects, &root, &names).0);
    // rust: assert!(effects.failed.contains("minecraft:unknown"));
    // rust: std::fs::remove_dir_all(root).unwrap();
}

    // The chains the prepared vanilla resources hold all load (skipped without
    // them): none names a shader Horizon lacks.
    // Renders `names` over a frame whose top half is red and bottom half green,
    // returning the pixel rows 0 and 3 of the 8x4 result.
    // rust: fn run_halves(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: effects: &mut PostEffects,
    // rust: root: &Path,
    // rust: names: &[String],
    // rust: ) -> [[u8; 4]; 2] {
    // rust: let frame = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 8,
    // rust: height: 4,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: let mut pixels = Vec::new();
    // rust: for y in 0..4 {
    // rust: for _ in 0..8 {
    // rust: pixels.extend_from_slice(if y < 2 {
    // rust: &[255, 0, 0, 255]
    // rust: } else {
    // rust: &[0, 255, 0, 255]
    // rust: });
}
}
    // rust: queue.write_texture(
    // rust: frame.as_image_copy(),
    // rust: &pixels,
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(32),
    // rust: rows_per_image: Some(4),
    // rust: },
    // rust: frame.size(),
    // rust: );
    // rust: let view = frame.create_view(&Default::default());
    // rust: let scope = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: assert!(effects.apply(
    // rust: device,
    // rust: queue,
    // rust: &mut encoder,
    // rust: &frame,
    // rust: &view,
    // rust: [8, 4],
    // rust: None,
    // rust: &Request {
    // rust: effects: names,
    // rust: root,
    // rust: menu_blur_radius: 0.0,
    // rust: globals: Globals::default(),
    // rust: },
    // rust: None,
    // rust: ));
    // rust: let buffer = crate::gfx::copy_frame(device, &mut encoder, &frame, [8, 4]);
    // rust: queue.submit([encoder.finish()]);
    // rust: if let Some(error) = pollster::block_on(scope.pop()) {
    // rust: panic!("{error}");
}
    // rust: buffer.map_async(wgpu::MapMode::Read, .., |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let data = buffer.get_mapped_range(..).unwrap();
    // rust: let row = |y: usize| {
    // rust: let at = y * 256;
    // rust: [data[at], data[at + 1], data[at + 2], data[at + 3]]
}
    // rust: [row(0), row(3)]
}

    // Frame orientation survives a chain through an intermediate target.
a_chain_keeps_the_frame_upright :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let root = scratch(
    // rust: "upright",
    // rust: r#"{"targets":{"swap":{}},"passes":[
    // rust: {"vertex_shader":"minecraft:core/screenquad","fragment_shader":"minecraft:post/blit",
    // rust: "inputs":[{"sampler_name":"In","target":"minecraft:main"}],"output":"swap",
    // rust: "uniforms":{"BlitConfig":[{"name":"ColorModulate","type":"vec4","value":[1.0,1.0,1.0,1.0]}]}},
    // rust: {"vertex_shader":"minecraft:core/screenquad","fragment_shader":"minecraft:post/blit",
    // rust: "inputs":[{"sampler_name":"In","target":"swap"}],"output":"minecraft:main",
    // rust: "uniforms":{"BlitConfig":[{"name":"ColorModulate","type":"vec4","value":[1.0,1.0,1.0,1.0]}]}}]}"#,
    // rust: );
    // rust: let mut effects = PostEffects::new(&device);
    // rust: let [top, bottom] = run_halves(
    // rust: &device,
    // rust: &queue,
    // rust: &mut effects,
    // rust: &root,
    // rust: &["minecraft:upright".to_owned()],
    // rust: );
    // rust: assert_eq!(top, [255, 0, 0, 255]);
    // rust: assert_eq!(bottom, [0, 255, 0, 255]);
    // rust: std::fs::remove_dir_all(root).unwrap();
}

    // A chain with its own GLSL, a target read twice, a depth input and a
    // `textures/effect` image: nothing here is one of vanilla's shaders.
a_chain_runs_its_own_glsl :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let root = scratch(
    // rust: "custom",
    // rust: r#"{"targets":{"half":{"width":4,"height":2}},"passes":[
    // rust: {"vertex_shader":"minecraft:core/quad","fragment_shader":"minecraft:post/mine",
    // rust: "inputs":[{"sampler_name":"In","target":"minecraft:main","bilinear":true},
    // rust: {"sampler_name":"Depth","target":"minecraft:main","use_depth_buffer":true},
    // rust: {"sampler_name":"Tint","location":"tint","width":1,"height":1}],
    // rust: "output":"half",
    // rust: "uniforms":{"MineConfig":[{"name":"Scale","type":"float","value":0.5}]}},
    // rust: {"vertex_shader":"minecraft:core/quad","fragment_shader":"minecraft:post/mine",
    // rust: "inputs":[{"sampler_name":"In","target":"half"},
    // rust: {"sampler_name":"Depth","target":"half","use_depth_buffer":true},
    // rust: {"sampler_name":"Tint","location":"tint","width":1,"height":1}],
    // rust: "output":"minecraft:main",
    // rust: "uniforms":{"MineConfig":[{"name":"Scale","type":"float","value":1.0}]}}]}"#,
    // rust: );
    // rust: own_glsl(&root);
    // rust: let mut effects = PostEffects::new(&device);
    // rust: let [top, bottom] = run_halves(
    // rust: &device,
    // rust: &queue,
    // rust: &mut effects,
    // rust: &root,
    // rust: &["minecraft:custom".to_owned()],
    // rust: );
        // Red (1, 0, 0) * the image (0.5, 1, 1) * 0.5 * depth 1, then again * 1: 0.125.
    // rust: let near = |a: u8, b: u8| a.abs_diff(b) <= 3;
    // rust: assert!(near(top[0], 32) && top[1] == 0 && top[3] == 255, "{top:?}");
        // Green stays below it: 0.5 * 1 * 1.
    // rust: assert!(bottom[0] == 0 && near(bottom[1], 128), "{bottom:?}");
    // rust: assert!(effects.failed.is_empty());
    // rust: std::fs::remove_dir_all(root).unwrap();
}

    // `core/quad.vsh`, `post/mine.fsh` and the `tint` image of `a_chain_runs_its_own_glsl`.
own_glsl :: proc(root: ^Path) {
}
    // rust: let shaders = root.join("assets/minecraft/shaders");
    // rust: std::fs::create_dir_all(shaders.join("core")).unwrap();
    // rust: std::fs::create_dir_all(shaders.join("post")).unwrap();
    // rust: std::fs::write(
    // rust: shaders.join("core/quad.vsh"),
    // rust: "#version 330\nlayout(location = 0) out vec2 texCoord;\nvoid main() {\n  vec2 uv = vec2((gl_VertexIndex << 1) & 2, gl_VertexIndex & 2);\n  gl_Position = vec4(uv * 2.0 - 1.0, 0.0, 1.0);\n  texCoord = uv;\n}\n",
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(
    // rust: shaders.join("post/mine.fsh"),
    // rust: "#version 330\nuniform sampler2D InSampler;\nuniform sampler2D DepthSampler;\nuniform sampler2D TintSampler;\n\
    // rust: layout(std140) uniform SamplerInfo { vec2 OutSize; vec2 InSize; };\n\
    // rust: layout(std140) uniform MineConfig { float Scale; };\n\
    // rust: layout(location = 0) in vec2 texCoord;\nlayout(location = 0) out vec4 fragColor;\n\
    // rust: void main() {\n  vec4 c = texture(InSampler, texCoord);\n  float d = texture(DepthSampler, texCoord).r;\n\
    // rust: vec4 t = texture(TintSampler, texCoord);\n  fragColor = vec4(c.rgb * t.rgb * Scale * d, 1.0);\n}\n",
    // rust: )
    // rust: .unwrap();
        // A 1x1 image, (0.5, 1, 1).
    // rust: let effect = root.join("assets/minecraft/textures/effect");
    // rust: std::fs::create_dir_all(&effect).unwrap();
    // rust: let mut png_bytes = Vec::new();
    // rust: {
    // rust: let mut encoder = png::Encoder::new(&mut png_bytes, 1, 1);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer.write_image_data(&[128, 255, 255, 255]).unwrap();
}
    // rust: std::fs::write(effect.join("tint.png"), png_bytes).unwrap();
}

    // A chain `preload` loaded arrives with its pipelines compiled on the loading
    // thread, and runs as one loaded in its frame does.
a_preloaded_chain_arrives_compiled :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let root = scratch(
    // rust: "preloaded",
    // rust: r#"{"targets":{"half":{"width":4,"height":2}},"passes":[
    // rust: {"vertex_shader":"minecraft:core/quad","fragment_shader":"minecraft:post/mine",
    // rust: "inputs":[{"sampler_name":"In","target":"minecraft:main","bilinear":true},
    // rust: {"sampler_name":"Depth","target":"minecraft:main","use_depth_buffer":true},
    // rust: {"sampler_name":"Tint","location":"tint","width":1,"height":1}],
    // rust: "output":"half",
    // rust: "uniforms":{"MineConfig":[{"name":"Scale","type":"float","value":0.5}]}},
    // rust: {"vertex_shader":"minecraft:core/quad","fragment_shader":"minecraft:post/mine",
    // rust: "inputs":[{"sampler_name":"In","target":"half"},
    // rust: {"sampler_name":"Depth","target":"half","use_depth_buffer":true},
    // rust: {"sampler_name":"Tint","location":"tint","width":1,"height":1}],
    // rust: "output":"minecraft:main",
    // rust: "uniforms":{"MineConfig":[{"name":"Scale","type":"float","value":1.0}]}}]}"#,
    // rust: );
    // rust: own_glsl(&root);
    // rust: let mut effects = PostEffects::new(&device);
    // rust: let format = wgpu::TextureFormat::Rgba8Unorm;
    // rust: effects.preload(&device, &queue, &root, &["minecraft:preloaded"], format);
    // rust: assert!(effects.pending.contains("minecraft:preloaded"));
    // rust: let started = std::time::Instant::now();
    // rust: while !effects.pending.is_empty() {
    // rust: assert!(started.elapsed().as_secs() < 60, "the chain never arrived");
    // rust: std::thread::sleep(std::time::Duration::from_millis(1));
    // rust: effects.collect_preloaded();
}
    // rust: let chain = effects.chains["minecraft:preloaded"]
    // rust: .as_ref()
    // rust: .expect("loaded");
    // rust: assert!(chain.passes.iter().all(|pass| {
    // rust: pass.translated
    // rust: .as_ref()
    // rust: .is_some_and(|t| t.pipelines.contains_key(&format))
    // rust: }));
    // rust: let [top, bottom] = run_halves(
    // rust: &device,
    // rust: &queue,
    // rust: &mut effects,
    // rust: &root,
    // rust: &["minecraft:preloaded".to_owned()],
    // rust: );
    // rust: let near = |a: u8, b: u8| a.abs_diff(b) <= 3;
    // rust: assert!(near(top[0], 32) && top[1] == 0 && top[3] == 255, "{top:?}");
    // rust: assert!(bottom[0] == 0 && near(bottom[1], 128), "{bottom:?}");
    // rust: std::fs::remove_dir_all(root).unwrap();
}

    // Vanilla's own chains run on the GPU without a validation error (skipped
    // without the prepared resources).
vanilla_chains_run :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3");
    // rust: if !root
    // rust: .join("assets/minecraft/post_effect/invert.json")
    // rust: .exists()
    // rust: {
    // rust: return;
}
    // rust: for name in ["blur", "creeper", "invert", "spider"] {
    // rust: let mut effects = PostEffects::new(&device);
    // rust: run_halves(
    // rust: &device,
    // rust: &queue,
    // rust: &mut effects,
    // rust: &root,
    // rust: &[format!("minecraft:{name}")],
    // rust: );
    // rust: assert!(effects.failed.is_empty(), "{name}");
            // The chain ran on the resources' own GLSL, not the stand-ins.
    // rust: let chain = effects.chains[&format!("minecraft:{name}")]
    // rust: .as_ref()
    // rust: .unwrap();
    // rust: assert!(
    // rust: chain.passes.iter().all(|p| p.translated.is_some()),
    // rust: "{name}"
    // rust: );
}
}

vanilla_chains_load :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3");
    // rust: if !root
    // rust: .join("assets/minecraft/post_effect/invert.json")
    // rust: .exists()
    // rust: {
    // rust: return;
}
    // rust: for name in ["blur", "creeper", "invert", "spider"] {
    // rust: let id = format!("minecraft:{name}");
    // rust: assert!(
    // rust: PostEffects::load(&root, &device, &queue, &id)
    // rust: .unwrap()
    // rust: .is_some(),
    // rust: "{id}"
    // rust: );
}
        // entity_outline needs targets and shaders the world pass has of its own.
    // rust: assert!(PostEffects::load(&root, &device, &queue, "minecraft:entity_outline").is_err());
}
}
