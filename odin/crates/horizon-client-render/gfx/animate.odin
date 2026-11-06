//! Transpiled from Horizon Rust crate
package horizon_client_render_animate

import "core:fmt"
import "core:mem"
import "core:math"

// Animated block sprites, drawn on the GPU as vanilla 26.3 draws them:
// `SpriteContents.AnimatedTexture` keeps every frame in video memory, and
// each tick `animate_sprite_blit` or `animate_sprite_interpolate` draws the
// frame shown (mixed with the next one for `interpolate`) into the atlas.
//
// Every frame's mip chain is uploaded once, at the sprite's own size. A tick
// that changes sprites writes one small job per changed sprite and runs one
// compute dispatch per mip level (`animate.wgsl`), which repeats the chain
// into the array's larger layers by whole pixels and mixes interpolated
// frames. Blending on the CPU at the array's size and copying every changed
// sprite level by level (a copy command each, a blit each in Mesa) was about
// a fifth of the render thread on an integrated GPU.
//
// Without compute shaders (OpenGL before 4.3, the last fallback) the same
// jobs run on the CPU, the same integer mix as `animate.wgsl`, and each
// changed level is copied into its layer.
// use super::upload::Uploads;
// use crate::mipmap::Settings;
// use crate::sprites::{FrameBlend, SpriteAnimation};
// use wgpu::util::DeviceExt;

// Bytes of `animate.wgsl`'s `Job`.
JOB_BYTES :: 20
// `animate.wgsl`'s workgroup edge.
WORKGROUP :: 8

Sprite :: struct {
    animation: SpriteAnimation,
    // What its layer shows (`None`: the frame the array was created with,
    // rewritten on the first tick).
    shown: Maybe(FrameBlend),
    // Its layer in its sprite array.
    layer: u32,
    // Each frame's mip chain: its offset in words in the group's frames.
    frames: [dynamic]u32,
    // Edge of the chains' first level.
    edge: u32,
    group: uint,
}

// The animated sprites of one sprite array whose frames share one buffer.
Group :: struct {
    // Where its jobs start in `SpriteAnimator::jobs`, in bytes.
    offset: u64,
    // One bind group per mip level of the array (none on the CPU).
    levels: [dynamic]wgpu::BindGroup,
    // This tick's jobs.
    jobs: [dynamic]u8,
    // Its sprite array and its frames, for the CPU.
    array: uint,
    buffer: uint,
}

// Where the jobs run.
Writer :: enum {
    Gpu {,
    jobs: wgpu::Buffer,
    pipeline: wgpu::ComputePipeline,
    // rust: },
    // Every frames buffer's words, and the sprite arrays to copy into.
    Cpu {,
    frames: Vec<Vec<u8>>,
    textures: Vec<wgpu::Texture>,
    // rust: },
}

    // rust: pub(super) struct SpriteAnimator {
    // rust: sprites: Vec<Sprite>,
    // rust: groups: Vec<Group>,
    // rust: writer: Writer,
    // Edge of the arrays' layers.
    // rust: size: u32,
    // The layers the last `animate` rewrote, counted over all arrays.
    // rust: changed: Vec<u32>,
    // Whether each sprite layer has an animation.
    // rust: is_animated: Vec<bool>,
}

    // rust: impl SpriteAnimator {
    // `textures` are the sprite arrays, `split` layers each, `size` pixels
    // wide; `animations` hold their frames at that size. `compute`: whether
    // the device says it runs compute shaders writing storage textures.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: animations: &[SpriteAnimation],
    // rust: size: u32,
    // rust: settings: &[Settings],
    // rust: textures: &[wgpu::Texture],
    // rust: split: u32,
    // rust: compute: bool,
    // rust: ) -> Self {
    // rust: let pipeline = if compute { pipeline(device) } else { None };
    // rust: let limits = device.limits();
    // rust: let limit = if pipeline.is_some() {
    // rust: limits
    // rust: .max_storage_buffer_binding_size
    // rust: .min(limits.max_buffer_size)
    // rust: } else {
            // Word offsets.
    // rust: u64::from(u32::MAX) * 4
}
    // rust: let mut frames: Vec<Vec<u8>> = Vec::new();
        // Each group's sprite array and frames buffer.
    // rust: let mut keys: Vec<(u32, usize)> = Vec::new();
    // rust: let mut counts: Vec<usize> = Vec::new();
    // rust: let mut sprites = Vec::with_capacity(animations.len());
    // rust: for animation in animations {
    // rust: let pixels: Vec<_> = (0..animation.frame_count())
    // rust: .map(|frame| animation.pixels(frame))
    // rust: .collect();
    // rust: let (chains, edge) = source_chains(&pixels, size, settings, animation.layer);
    // rust: let bytes: u64 = chains.iter().map(|chain| chain.len() as u64).sum();
    // rust: if bytes > limit {
    // rust: log::warn!(
    // rust: "Horizon: layer {}'s animation ({bytes} bytes) does not fit in a storage buffer; it stays still",
    // rust: animation.layer
    // rust: );
    // rust: continue;
}
    // rust: if frames
    // rust: .last()
    // rust: .is_none_or(|data| data.len() as u64 + bytes > limit)
    // rust: {
    // rust: frames.push(Vec::new());
}
    // rust: let buffer = frames.len() - 1;
    // rust: let data = &mut frames[buffer];
    // rust: let offsets = chains
    // rust: .iter()
    // rust: .map(|chain| {
    // rust: let offset = (data.len() / 4) as u32;
    // rust: data.extend_from_slice(chain);
    // rust: offset
    // rust: })
    // rust: .collect();
    // rust: let key = (animation.layer / split, buffer);
    // rust: let group = keys.iter().position(|&k| k == key).unwrap_or_else(|| {
    // rust: keys.push(key);
    // rust: counts.push(0);
    // rust: keys.len() - 1
    // rust: });
    // rust: counts[group] += 1;
    // rust: sprites.push(Sprite {
    // rust: animation: animation.clone(),
    // rust: shown: None,
    // rust: layer: animation.layer % split,
    // rust: frames: offsets,
    // rust: edge,
    // rust: group,
    // rust: });
}
    // rust: let max_layer = animations.iter().map(|a| a.layer).max().unwrap_or(0);
    // rust: let mut is_animated = vec![false; (max_layer + 1) as usize];
    // rust: for a in animations {
    // rust: is_animated[a.layer as usize] = true;
}
    // rust: let Some((pipeline, layout)) = pipeline else {
    // rust: let groups = keys
    // rust: .iter()
    // rust: .zip(&counts)
    // rust: .map(|(&(array, buffer), &count)| Group {
    // rust: offset: 0,
    // rust: levels: Vec::new(),
    // rust: jobs: Vec::with_capacity(count * JOB_BYTES),
    // rust: array: array as usize,
    // rust: buffer,
    // rust: })
    // rust: .collect();
    // rust: return Self {
    // rust: sprites,
    // rust: groups,
    // rust: writer: Writer::Cpu {
    // rust: frames,
    // rust: textures: textures.to_vec(),
    // rust: },
    // rust: size,
    // rust: changed: Vec::new(),
    // rust: is_animated,
}
}
    // rust: let frames: Vec<_> = frames
    // rust: .iter()
    // rust: .map(|data| {
    // rust: device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Animated sprite frames"),
    // rust: contents: data,
    // rust: usage: wgpu::BufferUsages::STORAGE,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let align = u64::from(limits.min_storage_buffer_offset_alignment);
    // rust: let mut offsets = Vec::with_capacity(counts.len());
    // rust: let mut total = 0;
    // rust: for &count in &counts {
    // rust: offsets.push(total);
    // rust: total = (total + (count * JOB_BYTES) as u64).next_multiple_of(align);
}
    // rust: let jobs = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Animated sprite jobs"),
    // rust: size: total.max(align),
    // rust: usage: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let groups = keys
    // rust: .iter()
    // rust: .zip(&counts)
    // rust: .zip(offsets)
    // rust: .map(|((&(array, buffer), &count), offset)| {
    // rust: let texture = &textures[array as usize];
    // rust: let levels = (0..texture.mip_level_count())
    // rust: .map(|level| {
    // rust: let view = texture.create_view(&wgpu::TextureViewDescriptor {
    // rust: label: Some("Animated sprites"),
    // rust: dimension: Some(wgpu::TextureViewDimension::D2Array),
    // rust: base_mip_level: level,
    // rust: mip_level_count: Some(1),
    // rust: ..Default::default()
    // rust: });
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Animated sprites"),
    // rust: layout: &layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: frames[buffer].as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::Buffer(wgpu::BufferBinding {
    // rust: buffer: &jobs,
    // rust: offset,
    // rust: size: wgpu::BufferSize::new((count * JOB_BYTES) as u64),
    // rust: }),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::TextureView(&view),
    // rust: },
    // rust: ],
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: Group {
    // rust: offset,
    // rust: levels,
    // rust: jobs: Vec::with_capacity(count * JOB_BYTES),
    // rust: array: array as usize,
    // rust: buffer,
}
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: sprites,
    // rust: groups,
    // rust: writer: Writer::Gpu { jobs, pipeline },
    // rust: size,
    // rust: changed: Vec::new(),
    // rust: is_animated,
}
}

    // Whether the sprite layer has an animation.
is_animated :: proc(self: ^Self, layer: u16) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_animated
    // rust: .get(layer as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
}

    // Number of words needed to mark the animated layers visible this frame.
active_layer_words :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.is_animated.len().div_ceil(u64::BITS as usize)
}

    // Whether the jobs can run on the GPU: compute shaders writing a
    // storage texture and reading two storage buffers (not OpenGL before
    // 4.3).
compute :: proc(adapter: ^wgpu::Adapter, device: ^wgpu::Device) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let limits = device.limits();
    // rust: adapter
    // rust: .get_downlevel_capabilities()
    // rust: .flags
    // rust: .contains(wgpu::DownlevelFlags::COMPUTE_SHADERS)
    // rust: && limits.max_storage_textures_per_shader_stage >= 1
    // rust: && limits.max_storage_buffers_per_shader_stage >= 2
}

    // The layers the last `animate` rewrote (for the shader pack atlas).
changed :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.changed
}

    // Show every sprite's frame at `tick`, rewriting only the sprites whose
    // frame or mix changed (`SpriteContents.AnimationState.tick`), skipping
    // sprites not present in `active` when provided.
    // rust: pub fn animate(
    // rust: &mut self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: uploads: &mut Uploads,
    // rust: tick: u64,
    // rust: active: Option<&[u64]>,
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: if self.collect(tick, active) == 0 {
    // rust: return;
}
    // rust: let (jobs, pipeline) = match &self.writer {
    // rust: Writer::Gpu { jobs, pipeline } => (jobs, pipeline),
    // rust: Writer::Cpu { frames, textures } => {
    // rust: for group in &mut self.groups {
    // rust: let (frames, texture) = (&frames[group.buffer], &textures[group.array]);
    // rust: for job in group.jobs.as_chunks::<JOB_BYTES>().0 {
    // rust: let (words, _) = job.as_chunks::<4>();
    // rust: let job: [u32; 5] = std::array::from_fn(|i| u32::from_le_bytes(words[i]));
    // rust: for level in 0..texture.mip_level_count() {
    // rust: let width = self.size >> level;
    // rust: uploads.texture(
    // rust: encoder,
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture,
    // rust: mip_level: level,
    // rust: origin: wgpu::Origin3d {
    // rust: x: 0,
    // rust: y: 0,
    // rust: z: job[0],
    // rust: },
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: width,
    // rust: width,
    // rust: &mix_level(frames, job, width),
    // rust: );
}
}
    // rust: group.jobs.clear();
}
    // rust: return;
}
}
    // rust: for group in &self.groups {
    // rust: uploads.buffer(encoder, jobs, group.offset, &group.jobs);
}
    // rust: let mut pass = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
    // rust: label: Some("Animated sprites"),
    // rust: timestamp_writes: timing.and_then(|t| t.compute_writes("Animated sprites")),
    // rust: });
    // rust: pass.set_pipeline(pipeline);
    // rust: for group in &mut self.groups {
    // rust: let count = (group.jobs.len() / JOB_BYTES) as u32;
    // rust: if count == 0 {
    // rust: continue;
}
    // rust: for (level, bind) in group.levels.iter().enumerate() {
    // rust: let groups = (self.size >> level).div_ceil(WORKGROUP);
    // rust: pass.set_bind_group(0, bind, &[]);
    // rust: pass.dispatch_workgroups(groups, groups, count);
}
    // rust: group.jobs.clear();
}
}

    // Queue a job for every sprite whose blend at `tick` differs from what
    // its layer shows; the number of jobs.
collect :: proc(self: ^Self, tick: u64, active: Maybe(^[u64])) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut count = 0;
    // rust: self.changed.clear();
    // rust: for sprite in &mut self.sprites {
    // rust: if let Some(active) = active {
    // rust: let layer = sprite.animation.layer as usize;
    // rust: let word = layer / u64::BITS as usize;
    // rust: let bit = 1_u64 << (layer % u64::BITS as usize);
    // rust: if active.get(word).is_none_or(|active| active & bit == 0) {
    // rust: continue;
}
}
    // rust: let blend = sprite.animation.blend(tick);
    // rust: if sprite.shown == Some(blend) {
    // rust: continue;
}
    // rust: sprite.shown = Some(blend);
    // rust: self.changed.push(sprite.animation.layer);
    // rust: let job = [
    // rust: sprite.layer,
    // rust: sprite.frames[blend.frame],
    // rust: sprite.frames[blend.next],
    // rust: blend.millis,
    // rust: sprite.edge,
    // rust: ];
    // rust: let jobs = &mut self.groups[sprite.group].jobs;
    // rust: for word in job {
    // rust: jobs.extend_from_slice(&word.to_le_bytes());
}
    // rust: count += 1;
}
    // rust: count
}
}

// `animate.wgsl`'s pipeline and the bind group layout of its group 0,
// unless the device fails to make the pipeline: an OpenGL driver can list
// compute shaders among its extensions while wgpu writes the GLSL version
// of its core version, which has none (Mesa's `MESA_GL_VERSION_OVERRIDE`,
// older drivers). A device lost between the scopes' pushes answers pipeline
// creation with a silent placeholder and reports its invalidity only when
// the layout is asked for — inside the scopes that error is caught, outside
// them it is uncaptured and panics (#3866).
pipeline :: proc(device: ^wgpu::Device) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let validation = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let internal = device.push_error_scope(wgpu::ErrorFilter::Internal);
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Animated sprites"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("animate.wgsl").into()),
    // rust: });
    // rust: let pipeline = device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    // rust: label: Some("Animated sprites"),
    // rust: layout: None,
    // rust: module: &module,
    // rust: entry_point: Some("animate"),
    // rust: compilation_options: Default::default(),
    // rust: cache: None,
    // rust: });
    // rust: let layout = pipeline.get_bind_group_layout(0);
    // rust: let internal = pollster::block_on(internal.pop());
    // rust: match internal.or(pollster::block_on(validation.pop())) {
    // rust: None => Some((pipeline, layout)),
    // rust: Some(e) => {
    // rust: log::warn!("Horizon renderer: animated sprites drawn on the CPU ({e})");
    // rust: None
}
}
}

// `animate.wgsl` on the CPU: one `width` wide level of a job
// (`[layer, current, next, millis, edge]`) from `frames`' chains.
mix_level :: proc(frames: []u8, edge]: [u32; 5], width: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::with_capacity((width * width * 4) as usize);
    // rust: for y in 0..width {
    // rust: for x in 0..width {
    // rust: let texel = if width >= edge {
    // rust: let scale = width / edge;
    // rust: y / scale * edge + x / scale
    // rust: } else {
    // rust: 4 * (edge * edge - width * width) / 3 + y * width + x
}
    // rust: let at = |chain: u32| ((chain + texel) * 4) as usize;
    // rust: let a = &frames[at(current)..at(current) + 4];
    // rust: if millis == 0 {
    // rust: out.extend_from_slice(a);
    // rust: continue;
}
    // rust: let b = &frames[at(next)..at(next) + 4];
    // rust: out.extend(a.iter().zip(b).map(|(&a, &b)| {
    // rust: ((u32::from(a) * (1000 - millis) + u32::from(b) * millis + 500) / 1000) as u8
    // rust: }));
}
}
    // rust: out
}

// The mip chain a frame's layer is made of, and its first level's edge.
// `mipmap::generate` makes a sprite scaled up by whole pixels to the
// array's size from its own size's chain, its first level repeated into the
// larger levels: that chain, which the shader repeats. Any other sprite: its
// chain at the array's size.
source_chain :: proc(pixels: []u8, size: u32, settings: ^[Settings], layer: u32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (mut chains, edge) = source_chains(&[pixels], size, settings, layer);
    // rust: (chains.swap_remove(0), edge)
}

// Every frame's chain, laid out as one frame's `source_chain`, but mipmapped as
// vanilla's `SpriteContents.increaseMipLevel` does: over the whole animation
// sheet (the frames stacked), so `solidify` and the alpha-to-coverage scale
// of each level are the sheet's, not each frame's. A frame alone has a
// single texel square at its 2x2 level, and its coverage scale could round
// a whole far frame transparent (kelp blinking out at distance).
    // rust: fn source_chains(
    // rust: frames: &[&[u8]],
    // rust: size: u32,
    // rust: settings: &[Settings],
    // rust: layer: u32,
    // rust: ) -> (Vec<Vec<u8>>, u32) {
    // rust: let s = settings.get(layer as usize).copied().unwrap_or_default();
    // rust: let edge = if s.native_size.is_power_of_two() && s.native_size < size {
    // rust: s.native_size
    // rust: } else {
    // rust: size
}
    // rust: let mut sheet = crate::mipmap::Image {
    // rust: width: edge,
    // rust: height: edge * frames.len() as u32,
    // rust: pixels: Vec::with_capacity((edge * edge) as usize * frames.len()),
}
    // rust: for frame in frames {
    // rust: let frame = crate::sprites::resample(frame, size, edge);
    // rust: sheet.pixels.extend_from_slice(frame.as_chunks::<4>().0);
}
    // rust: let has_transparent = s.has_transparent || sheet.pixels.iter().any(|p| p[3] == 0);
    // rust: let levels = crate::mipmap::generate(
    // rust: sheet,
    // rust: edge.trailing_zeros(),
    // rust: Settings {
    // rust: has_transparent,
    // rust: ..s
    // rust: },
    // rust: );
    // rust: let chains = (0..frames.len())
    // rust: .map(|frame| {
    // rust: let mut chain = Vec::new();
    // rust: for level in &levels {
    // rust: let texels = (level.width * level.width) as usize;
    // rust: chain.extend(
    // rust: level.pixels[frame * texels..(frame + 1) * texels]
    // rust: .iter()
    // rust: .flatten(),
    // rust: );
}
    // rust: chain
    // rust: })
    // rust: .collect();
    // rust: (chains, edge)
}

    // rust: mod tests {
//     use super::*;
//     use crate::mipmap::Strategy;

    // `animate.wgsl` on the CPU: `chain` (first level `edge` wide) as the
    // full chain of a `size` layer, mixed `millis` thousandths of the way
    // towards `next`.
reference :: proc(chain: []u8, next: []u8, millis: u32, edge: u32, size: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let levels = size.trailing_zeros() + 1;
    // rust: let mut out = Vec::new();
    // rust: for level in 0..levels {
    // rust: let width = size >> level;
    // rust: for y in 0..width {
    // rust: for x in 0..width {
    // rust: let texel = if width >= edge {
    // rust: let scale = width / edge;
    // rust: y / scale * edge + x / scale
    // rust: } else {
    // rust: 4 * (edge * edge - width * width) / 3 + y * width + x
    // rust: } as usize;
    // rust: for c in 0..4 {
    // rust: let (a, b) = (
    // rust: u32::from(chain[texel * 4 + c]),
    // rust: u32::from(next[texel * 4 + c]),
    // rust: );
    // rust: out.push(((a * (1000 - millis) + b * millis + 500) / 1000) as u8);
}
}
}
}
    // rust: out
}

frame :: proc(size: u32, seed: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..size * size)
    // rust: .flat_map(|i| {
    // rust: let v = i
    // rust: .wrapping_mul(2654435761)
    // rust: .wrapping_add(seed.wrapping_mul(40503));
    // rust: let alpha = match v >> 29 {
    // rust: 0 => 0,
    // rust: 1 => 77,
    // rust: _ => 255,
}
    // rust: [(v >> 3) as u8, (v >> 11) as u8, (v >> 19) as u8, alpha]
    // rust: })
    // rust: .collect()
}

settings :: proc(native: u32, strategy: Strategy) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Settings {
    // rust: native_size: native,
    // rust: strategy,
    // rust: alpha_cutoff_bias: -0.1,
    // rust: ..Default::default()
}
}

source_chains_repeat_into_the_array_chain :: proc() {
}
        // Sprites scaled up by whole pixels, at the array's size, and of a
        // size that is not a power of two (scaled up to the next one).
    // rust: for (native, size) in [(16, 16), (16, 64), (8, 32), (32, 64), (1, 16), (24, 32)] {
    // rust: for strategy in [
    // rust: Strategy::Auto,
    // rust: Strategy::Mean,
    // rust: Strategy::Cutout,
    // rust: Strategy::StrictCutout,
    // rust: Strategy::DarkCutout,
    // rust: ] {
    // rust: for item in [false, true] {
    // rust: let settings = [
    // rust: Settings::default(),
    // rust: Settings {
    // rust: item,
    // rust: ..settings(native, strategy)
    // rust: },
    // rust: ];
    // rust: let pixels = crate::sprites::resample(&frame(native, 3), native, size);
    // rust: let (expected, _) = super::super::mip_chain(&pixels, size, &settings, 1, 1);
    // rust: let (chain, edge) = source_chain(&pixels, size, &settings, 1);
    // rust: let fits = native.is_power_of_two() && native < size;
    // rust: assert_eq!(edge, if fits { native } else { size });
    // rust: assert_eq!(
    // rust: reference(&chain, &chain, 0, edge, size),
    // rust: expected,
    // rust: "{native} in {size}, {strategy:?}, item {item}"
    // rust: );
}
}
}
}

real_animation_chains_repeat_into_the_array_chain :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root
    // rust: .join("assets/minecraft/textures/block/water_still.png")
    // rust: .exists()
    // rust: {
    // rust: return;
}
    // rust: let mut sprites = crate::sprites::Sprites::default();
    // rust: for name in [
    // rust: "water_still",
    // rust: "water_flow",
    // rust: "lava_still",
    // rust: "fire_0",
    // rust: "nether_portal",
    // rust: "sea_lantern",
    // rust: "prismarine",
    // rust: "magma",
    // rust: "kelp",
    // rust: "straw_bed",
    // rust: ] {
    // rust: sprites
    // rust: .insert(&root, &format!("minecraft:block/{name}"))
    // rust: .unwrap();
}
    // rust: sprites.finish();
    // rust: assert_eq!(sprites.size, 64);
    // rust: assert_eq!(sprites.animations.len(), 9);
    // rust: for animation in &sprites.animations {
    // rust: for frame in 0..animation.frame_count() {
    // rust: let pixels = animation.pixels(frame);
    // rust: let (expected, _) =
    // rust: super::super::mip_chain(pixels, 64, &sprites.mips, animation.layer, 1);
    // rust: let (chain, edge) = source_chain(pixels, 64, &sprites.mips, animation.layer);
    // rust: assert!(edge < 64, "layer {}", animation.layer);
    // rust: assert_eq!(reference(&chain, &chain, 0, edge, 64), expected);
}
}
}

kelp_frames_share_the_sheet_mips :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root
    // rust: .join("assets/minecraft/textures/block/kelp.png")
    // rust: .exists()
    // rust: {
    // rust: return;
}
    // rust: let mut sprites = crate::sprites::Sprites::default();
    // rust: for name in ["kelp", "kelp_plant", "seagrass", "tall_seagrass_top"] {
    // rust: sprites
    // rust: .insert(&root, &format!("minecraft:block/{name}"))
    // rust: .unwrap();
}
    // rust: sprites.finish();
        // A level drawn nowhere: no texel passes the cutout's alpha test.
    // rust: let blank = |chain: &[u8], edge: u32| {
    // rust: let mut start = 0;
    // rust: let mut level = edge;
    // rust: let mut blank = Vec::new();
    // rust: while level > 0 {
    // rust: let bytes = (level * level * 4) as usize;
    // rust: let texels = &chain[start..start + bytes];
    // rust: blank.push(texels.as_chunks::<4>().0.iter().all(|p| p[3] < 128));
    // rust: start += bytes;
    // rust: level >>= 1;
}
    // rust: blank
}
    // rust: let mut blinked = 0;
    // rust: for animation in &sprites.animations {
    // rust: let size = sprites.size;
    // rust: let pixels: Vec<_> = (0..animation.frame_count())
    // rust: .map(|f| animation.pixels(f))
    // rust: .collect();
    // rust: let (chains, edge) = source_chains(&pixels, size, &sprites.mips, animation.layer);
    // rust: for (frame, chain) in chains.iter().enumerate() {
                // The 1x1 level has no texel square to measure coverage on
                // (vanilla leaves it unscaled); every larger level shows.
    // rust: let levels = blank(chain, edge);
    // rust: assert!(
    // rust: !levels[..levels.len() - 1].contains(&true),
    // rust: "layer {} frame {frame}: {levels:?}",
    // rust: animation.layer
    // rust: );
    // rust: let (alone, _) = source_chain(pixels[frame], size, &sprites.mips, animation.layer);
    // rust: let alone = blank(&alone, edge);
    // rust: blinked += usize::from(alone[..alone.len() - 1].contains(&true));
}
}
        // Mipmapped frame by frame, some kelp frames vanished at the 2x2 level.
    // rust: assert!(blinked > 0);
}

rounding_matches_f32_mix_but_for_exact_halves :: proc() {
}
        // The CPU blend this replaced: f32 mix, then rounded. They differ
        // only where the exact mix is a half, which f32 rounded either way.
    // rust: for millis in 1..1000u32 {
    // rust: let t = millis as f32 / 1000.0;
    // rust: for a in 0..=255u32 {
    // rust: for b in (0..=255u32).step_by(3) {
    // rust: let f = ((a as f32 / 255.0) * (1.0 - t) + (b as f32 / 255.0) * t) * 255.0;
    // rust: let exact = a * (1000 - millis) + b * millis;
    // rust: let ours = (exact + 500) / 1000;
    // rust: if exact % 1000 != 500 {
    // rust: assert_eq!(ours, f.round() as u32, "{a} {b} {millis}");
}
}
}
}
}

device :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

    // Every layer's full mip chain, layer major.
    // rust: fn read_back(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: texture: &wgpu::Texture,
    // rust: ) -> Vec<Vec<u8>> {
    // rust: let layers = texture.depth_or_array_layers();
    // rust: let mut out = vec![Vec::new(); layers as usize];
    // rust: for level in 0..texture.mip_level_count() {
    // rust: let edge = texture.width() >> level;
    // rust: let padded = (edge * 4).next_multiple_of(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT);
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(padded * edge * layers),
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.copy_texture_to_buffer(
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture,
    // rust: mip_level: level,
    // rust: origin: wgpu::Origin3d::ZERO,
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(padded),
    // rust: rows_per_image: Some(edge),
    // rust: },
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width: edge,
    // rust: height: edge,
    // rust: depth_or_array_layers: layers,
    // rust: },
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: buffer
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let data = buffer.slice(..).get_mapped_range().unwrap();
    // rust: for (layer, image) in data.chunks((padded * edge) as usize).enumerate() {
    // rust: for row in image.chunks(padded as usize) {
    // rust: out[layer].extend_from_slice(&row[..edge as usize * 4]);
}
}
}
    // rust: out
}

gpu_layers_match_the_cpu_chains_every_tick :: proc() {
}
    // rust: layers_match_the_cpu_chains_every_tick(true);
}

    // Without compute shaders (OpenGL before 4.3): the same layers.
copied_layers_match_the_cpu_chains_every_tick :: proc() {
}
    // rust: layers_match_the_cpu_chains_every_tick(false);
}

layers_match_the_cpu_chains_every_tick :: proc(compute: bool) {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let size = 32;
        // Layers 1 and 3: 8-pixel sprites with and without interpolation;
        // layer 4: one at the array's size. Two layers per array.
    // rust: let clips = [
    // rust: (
    // rust: 1,
    // rust: 8,
    // rust: r#"{"frametime":3,"interpolate":true,"frames":[0,2,1]}"#,
    // rust: ),
    // rust: (3, 8, r#"{"frametime":2}"#),
    // rust: (4, 32, r#"{"frametime":5,"interpolate":true}"#),
    // rust: ];
    // rust: let mut mips = vec![Settings::default(); 6];
    // rust: let animations: Vec<_> = clips
    // rust: .iter()
    // rust: .map(|&(layer, native, metadata)| {
    // rust: mips[layer as usize] = settings(native, Strategy::Cutout);
    // rust: let frames = (0..3)
    // rust: .map(|f| crate::sprites::resample(&frame(native, layer * 7 + f), native, size))
    // rust: .collect();
    // rust: crate::sprites::test_frames(layer, frames, metadata)
    // rust: })
    // rust: .collect();
    // rust: let split = 2;
    // rust: let textures: Vec<_> = (0..3)
    // rust: .map(|_| {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: size,
    // rust: height: size,
    // rust: depth_or_array_layers: split,
    // rust: },
    // rust: mip_level_count: size.trailing_zeros() + 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::STORAGE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let mut animator =
    // rust: SpriteAnimator::new(&device, &animations, size, &mips, &textures, split, compute);
    // rust: let mut uploads = Uploads::new(&device);
    // rust: let mut writes = Vec::new();
    // rust: for tick in [0, 0, 1, 2, 3, 4, 7, 7, 12, 30] {
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let shown: Vec<_> = animator.sprites.iter().map(|s| s.shown).collect();
    // rust: animator.animate(&mut encoder, &mut uploads, tick, None, None);
    // rust: writes.push(
    // rust: animator
    // rust: .sprites
    // rust: .iter()
    // rust: .zip(shown)
    // rust: .filter(|(s, shown)| s.shown != *shown)
    // rust: .count(),
    // rust: );
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: for animation in &animations {
    // rust: let blend = animation.blend(tick);
    // rust: let pixels: Vec<_> = (0..animation.frame_count())
    // rust: .map(|f| animation.pixels(f))
    // rust: .collect();
    // rust: let (chains, edge) = source_chains(&pixels, size, &mips, animation.layer);
    // rust: let (current, next) = (&chains[blend.frame], &chains[blend.next]);
    // rust: let layers = read_back(
    // rust: &device,
    // rust: &queue,
    // rust: &textures[(animation.layer / split) as usize],
    // rust: );
    // rust: assert_eq!(
    // rust: layers[(animation.layer % split) as usize],
    // rust: reference(current, next, blend.millis, edge, size),
    // rust: "layer {} at tick {tick}",
    // rust: animation.layer
    // rust: );
}
}
        // Every sprite on the first tick, then only those whose frame or mix
        // changed since they were written: the interpolated ones every tick
        // but layer 1 at tick 30 (two 9-tick loops after 12), layer 3 when
        // its frame turns over (every 2 ticks, but 12 shows 7's frame).
    // rust: assert_eq!(writes, [3, 0, 2, 3, 2, 3, 3, 0, 2, 1]);
}

inactive_sprites_are_skipped_by_collect :: proc() {
}
    // rust: let Some((device, _)) = device() else {
    // rust: return;
}
    // rust: let size = 16;
    // rust: let clips = [
    // rust: (1, 16, r#"{"frametime":1}"#),
    // rust: (3, 16, r#"{"frametime":1}"#),
    // rust: (5, 16, r#"{"frametime":1}"#),
    // rust: ];
    // rust: let mut mips = vec![Settings::default(); 6];
    // rust: let animations: Vec<_> = clips
    // rust: .iter()
    // rust: .map(|&(layer, native, metadata)| {
    // rust: mips[layer as usize] = settings(native, Strategy::Cutout);
    // rust: let frames = (0..3)
    // rust: .map(|f| crate::sprites::resample(&frame(native, layer * 7 + f), native, size))
    // rust: .collect();
    // rust: crate::sprites::test_frames(layer, frames, metadata)
    // rust: })
    // rust: .collect();
        // Construct with CPU writer (empty textures is fine for collect testing)
    // rust: let mut animator = SpriteAnimator::new(&device, &animations, size, &mips, &[], 2, false);
    // rust: assert!(animator.is_animated(1));
    // rust: assert!(!animator.is_animated(2));
    // rust: assert!(animator.is_animated(3));
    // rust: assert!(animator.is_animated(5));

        // When active layer is [1], only sprite 1 is collected
    // rust: let active = [1_u64 << 1];
    // rust: let count = animator.collect(1, Some(&active));
    // rust: assert_eq!(count, 1);
    // rust: assert_eq!(animator.changed, vec![1]);

        // When active is empty, 0 are collected
    // rust: let count = animator.collect(2, Some(&[0]));
    // rust: assert_eq!(count, 0);
    // rust: assert!(animator.changed.is_empty());

        // When active is [3, 5], both 3 and 5 are collected
    // rust: let active = [1_u64 << 3 | 1_u64 << 5];
    // rust: let count = animator.collect(3, Some(&active));
    // rust: assert_eq!(count, 2);
    // rust: assert_eq!(animator.changed, vec![3, 5]);

        // When active is None, all out-of-date sprites update
    // rust: let count = animator.collect(5, None);
    // rust: assert_eq!(count, 3);
    // rust: assert_eq!(animator.changed, vec![1, 3, 5]);
}
}
