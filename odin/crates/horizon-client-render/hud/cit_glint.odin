//! Transpiled from Horizon Rust crate
package horizon_client_render_cit_glint

import "core:fmt"
import "core:mem"
import "core:math"

// OptiFine CIT enchantment glints on GUI items (`type=enchantment`, see `crate::cit_glint` for
// which layers a stack draws): every rule's texture in one texture array, each layer an extra
// pass over the item's quads with its rule's blend. A layer's vertices carry its texture slot
// (red) and its intensity (alpha) in their colour; its scrolled UV is worked out on the CPU, as
// vanilla's glint's is. Without enchantment rules nothing here is made.

// use super::HudVertex;
// use horizon_optifine::cit::{Blend, Factor, Kind, Rule};
// use std::path::Path;

// Slots the shader's table holds; rules past it draw no layer (and match no stack).
MAX_SLOTS :: 256
// The largest side the shared texture size takes: bigger glints are scaled down to it.
MAX_SIDE :: 1024
// The most the texture array takes, in bytes: past it the shared size is halved.
MAX_BYTES :: 64 << 20

// One slot's constants.
Slot :: struct {
    // The rule's `r`, `g`, `b`, `a`.
    rgba: [f32,
    // Linear filtering (`blur`), else nearest.
    blur: bool,
    // An index into `GlintTextures::blends`.
    blend: u8,
}

// The enchantment rules' textures, resized to one size.
GlintTextures :: struct {
    width: u32,
    height: u32,
    // One `width` x `height` RGBA image per slot, slot after slot. Kept after the upload: every
    // split-screen player's renderer builds its own array from it.
    pixels: [dynamic]u8,
    // Per rule (an index into `CitRules::rules`): its slot; `None` for other kinds of rules,
    // textures that did not load and rules past `MAX_SLOTS`.
    slot_of: [dynamic]Maybe(u8),
    slots: [dynamic]Slot,
    // The blends the slots use, once each: the HUD makes a pipeline per entry.
    blends: [dynamic]Maybe(Blend),
}

    // rust: impl GlintTextures {
    // The textures of `rules` under the overlay resource root.
load :: proc(root: ^Path, rules: ^[Rule]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut images = Vec::new();
    // rust: let mut past = 0;
    // rust: for (i, rule) in rules.iter().enumerate() {
    // rust: let Some(path) = rule.texture.as_deref() else {
    // rust: continue;
}
    // rust: if rule.kind != Kind::Enchantment {
    // rust: continue;
}
    // rust: if images.len() == MAX_SLOTS {
    // rust: past += 1;
    // rust: continue;
}
    // rust: match super::decode(&root.join(path)) {
    // rust: Ok(image) => images.push((i, image)),
    // rust: Err(e) => log::warn!("custom item textures: glint {path} left out: {e}"),
}
}
    // rust: if past > 0 {
    // rust: log::warn!(
    // rust: "custom item textures: {past} glint rules past the first {MAX_SLOTS} left out"
    // rust: );
}
    // rust: Self::new(rules, images, MAX_BYTES)
}

    // `images`: (rule, (width, height, RGBA)), in at most `budget` bytes.
new :: proc(rules: ^[Rule], images: Vec<(uint) {
}
    // rust: let sizes = images.iter().map(|(_, (w, h, _))| (*w, *h));
    // rust: let Some((width, height)) = shared_size(sizes, images.len(), budget) else {
    // rust: return Self::default();
}
    // rust: let mut out = Self {
    // rust: width,
    // rust: height,
    // rust: slot_of: vec![None; rules.len()],
    // rust: ..Self::default()
}
    // rust: for (rule, (w, h, rgba)) in images {
    // rust: let glint = &rules[rule].glint;
    // rust: out.pixels
    // rust: .extend(resize(&rgba, (w, h), (width, height), glint.blur));
    // rust: let blend = match out.blends.iter().position(|b| *b == glint.blend) {
    // rust: Some(i) => i,
    // rust: None => {
    // rust: out.blends.push(glint.blend);
    // rust: out.blends.len() - 1
}
}
    // rust: out.slot_of[rule] = Some(out.slots.len() as u8);
    // rust: out.slots.push(Slot {
    // rust: rgba: glint.rgba,
    // rust: blur: glint.blur,
    // rust: blend: blend as u8,
    // rust: });
}
    // rust: out
}

is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.slots.is_empty()
}
}

// The size every slot takes: the largest width and height of `sizes`, each at most
// `MAX_SIDE`, then halved until `layers` RGBA images of it fit in `budget` bytes.
    // rust: fn shared_size(
    // rust: sizes: impl Iterator<Item = (u32, u32)>,
    // rust: layers: usize,
    // rust: budget: u64,
    // rust: ) -> Option<(u32, u32)> {
    // rust: let (mut w, mut h) = sizes.fold(None, |max: Option<(u32, u32)>, (w, h)| {
    // rust: let (w, h) = (w.clamp(1, MAX_SIDE), h.clamp(1, MAX_SIDE));
    // rust: Some(max.map_or((w, h), |(mw, mh)| (mw.max(w), mh.max(h))))
    // rust: })?;
    // rust: let bytes = |w: u32, h: u32| u64::from(w) * u64::from(h) * 4 * layers as u64;
    // rust: while bytes(w, h) > budget && (w > 1 || h > 1) {
    // rust: (w, h) = ((w / 2).max(1), (h / 2).max(1));
}
    // rust: Some((w, h))
}

// `rgba` (`from` texels) scaled to `to`: bilinearly for a `blur` glint, as the GPU would have
// filtered the texture at its own size, else to the nearest texel. Both wrap at the edges, as
// the glint repeats over the item.
resize :: proc(rgba: []u8, from: (u32) {
}
    // rust: if from == to {
    // rust: return rgba.to_vec();
}
    // rust: let ((w, h), (to_w, to_h)) = (from, to);
    // rust: let texel = |x: i64, y: i64| {
    // rust: let (x, y) = (x.rem_euclid(i64::from(w)), y.rem_euclid(i64::from(h)));
    // rust: let at = (y as usize * w as usize + x as usize) * 4;
    // rust: &rgba[at..at + 4]
}
    // Where texel `i` of `n` samples the source's `size` texels, in source texels.
    // rust: let centre = |i: u32, n: u32, size: u32| (f64::from(i) + 0.5) * f64::from(size) / f64::from(n);
    // rust: let mut out = Vec::with_capacity(to_w as usize * to_h as usize * 4);
    // rust: for y in 0..to_h {
    // rust: let sy = centre(y, to_h, h);
    // rust: for x in 0..to_w {
    // rust: let sx = centre(x, to_w, w);
    // rust: if !smooth {
    // rust: let pick = |i: u32, n: u32, size: u32| {
    // rust: (u64::from(i) * u64::from(size) / u64::from(n)) as i64
}
    // rust: out.extend_from_slice(texel(pick(x, to_w, w), pick(y, to_h, h)));
    // rust: continue;
}
    // rust: let (fx, fy) = (sx - 0.5, sy - 0.5);
    // rust: let (x0, y0) = (fx.floor() as i64, fy.floor() as i64);
    // rust: let (tx, ty) = (fx - fx.floor(), fy - fy.floor());
    // rust: let [a, b, c, d] = [
    // rust: texel(x0, y0),
    // rust: texel(x0 + 1, y0),
    // rust: texel(x0, y0 + 1),
    // rust: texel(x0 + 1, y0 + 1),
    // rust: ];
    // rust: let lerp =
    // rust: |p: &[u8], q: &[u8], k: usize| f64::from(p[k]) * (1.0 - tx) + f64::from(q[k]) * tx;
    // rust: out.extend((0..4).map(|k| {
    // rust: let (top, bottom) = (lerp(a, b, k), lerp(c, d, k));
    // rust: (top * (1.0 - ty) + bottom * ty).round() as u8
    // rust: }));
}
}
    // rust: out
}

// CIT Resewn's glint texturing for one layer: `translation(-x, y)`, `rotateZ(rotation)`, then
// `scale`, where `x` and `y` run through vanilla's 110000 and 30000 periods of the clock
// `millis * speed` (vanilla's own glint runs at `millis * glintSpeed * 8`). `rotation` is in
// degrees, as OptiFine's doc has it.
layer_uv :: proc(model: [f32; 2], millis: f32, speed: f32, rotation: f32, scale: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let clock = f64::from(millis) * f64::from(speed);
    // rust: let x = (clock % 110_000.0 / 110_000.0) as f32;
    // rust: let y = (clock % 30_000.0 / 30_000.0) as f32;
    // rust: let (sin, cos) = rotation.to_radians().sin_cos();
    // rust: let (u, v) = (model[0] * scale, model[1] * scale);
    // rust: [u * cos - v * sin - x, u * sin + v * cos + y]
}

// The colour of a layer's vertices: its slot in red, its intensity in alpha.
vertex_color :: proc(slot: u8, intensity: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let alpha = (intensity.clamp(0.0, 1.0) * 255.0).round() as u8;
    // rust: super::rgba(slot, 0, 0, alpha)
}

factor :: proc(f: Factor) -> w {
    // Ported from Horizon
    return {}
}
//     use wgpu::BlendFactor as W;
    // rust: match f {
    // rust: Factor::Zero => W::Zero,
    // rust: Factor::One => W::One,
    // rust: Factor::SrcColor => W::Src,
    // rust: Factor::OneMinusSrcColor => W::OneMinusSrc,
    // rust: Factor::SrcAlpha => W::SrcAlpha,
    // rust: Factor::OneMinusSrcAlpha => W::OneMinusSrcAlpha,
    // rust: Factor::DstAlpha => W::DstAlpha,
    // rust: Factor::OneMinusDstAlpha => W::OneMinusDstAlpha,
    // rust: Factor::DstColor => W::Dst,
    // rust: Factor::OneMinusDstColor => W::OneMinusDst,
    // rust: Factor::SrcAlphaSaturate => W::SrcAlphaSaturated,
}
}

// `glBlendFuncSeparate` with the rule's factors; `replace` draws unblended.
blend_state :: proc(blend: Maybe(Blend)) -> w {
    // Ported from Horizon
    return {}
}
    // rust: let Some(b) = blend else {
    // rust: return wgpu::BlendState::REPLACE;
}
    // rust: let component = |src, dst| wgpu::BlendComponent {
    // rust: src_factor: factor(src),
    // rust: dst_factor: factor(dst),
    // rust: operation: wgpu::BlendOperation::Add,
}
    // rust: wgpu::BlendState {
    // rust: color: component(b.src, b.dst),
    // rust: alpha: component(b.src_alpha, b.dst_alpha),
}
}

// The GPU side: the texture array and slot table (bind group 1 of `fs_cit_glint`), and one
// pipeline per blend.
    // rust: pub(super) struct CitGlintPass {
    // rust: group: wgpu::BindGroup,
    // rust: pipelines: Vec<wgpu::RenderPipeline>,
}

    // rust: impl CitGlintPass {
    // `None` without textures. `hud` is the HUD's bind group layout (group 0).
    // rust: pub(super) fn new(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: format: wgpu::TextureFormat,
    // rust: hud: &wgpu::BindGroupLayout,
    // rust: textures: &GlintTextures,
    // rust: ) -> Option<Self> {
//         use wgpu::util::DeviceExt;
    // rust: if textures.is_empty() {
    // rust: return None;
}
        // wgpu's OpenGL backend makes 1 layer a 2D texture and 6n a cube map
        // (`gfx::array_layers`): pad with empty layers, within the GPU's limit. Slots past the
        // layers kept sample the last one.
    // rust: let gl = device.adapter_info().backend == wgpu::Backend::Gl;
    // rust: let max = device.limits().max_texture_array_layers.max(1);
    // rust: let slots = textures.slots.len() as u32;
    // rust: let mut kept = slots.min(max);
    // rust: while kept > 1 && crate::gfx::array_layers(kept, gl) > max {
    // rust: kept -= 1;
}
    // rust: if kept < slots {
    // rust: log::warn!("custom item textures: the GPU holds {kept} of {slots} glint textures");
}
    // rust: let layers = crate::gfx::array_layers(kept, gl).min(max);
    // rust: let layer_bytes = textures.width as usize * textures.height as usize * 4;
    // rust: let mut data = std::borrow::Cow::Borrowed(&textures.pixels[..]);
    // rust: if layers != slots {
    // rust: let mut padded = textures.pixels[..layer_bytes * kept as usize].to_vec();
    // rust: padded.resize(layer_bytes * layers as usize, 0);
    // rust: data = std::borrow::Cow::Owned(padded);
}
    // rust: let texture = device.create_texture_with_data(
    // rust: queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some("CIT glints"),
    // rust: size: wgpu::Extent3d {
    // rust: width: textures.width,
    // rust: height: textures.height,
    // rust: depth_or_array_layers: layers,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &data,
    // rust: );
    // rust: let view = texture.create_view(&wgpu::TextureViewDescriptor {
    // rust: dimension: Some(wgpu::TextureViewDimension::D2Array),
    // rust: ..Default::default()
    // rust: });
    // rust: let sampler = |label, filter| {
    // rust: device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some(label),
    // rust: address_mode_u: wgpu::AddressMode::Repeat,
    // rust: address_mode_v: wgpu::AddressMode::Repeat,
    // rust: mag_filter: filter,
    // rust: min_filter: filter,
    // rust: ..Default::default()
    // rust: })
}
    // rust: let linear = sampler("CIT glint blur", wgpu::FilterMode::Linear);
    // rust: let nearest = sampler("CIT glint", wgpu::FilterMode::Nearest);
        // hud.wgsl's `CitSlot`: rgba, then blur in x.
    // rust: let mut table = vec![[0.0f32; 8]; MAX_SLOTS];
    // rust: for (row, slot) in table.iter_mut().zip(&textures.slots) {
    // rust: row[..4].copy_from_slice(&slot.rgba);
    // rust: row[4] = if slot.blur { 1.0 } else { 0.0 };
}
    // rust: let table = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("CIT glint slots"),
    // rust: contents: bytemuck::cast_slice(&table),
    // rust: usage: wgpu::BufferUsages::UNIFORM,
    // rust: });
    // rust: let fragment = wgpu::ShaderStages::FRAGMENT;
    // rust: let filtering = wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering);
    // rust: let entry = |binding, ty| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: fragment,
    // rust: ty,
    // rust: count: None,
}
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("CIT glint bindings"),
    // rust: entries: &[
    // rust: entry(
    // rust: 0,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2Array,
    // rust: multisampled: false,
    // rust: },
    // rust: ),
    // rust: entry(1, filtering),
    // rust: entry(2, filtering),
    // rust: entry(
    // rust: 3,
    // rust: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: ),
    // rust: ],
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("CIT glint resources"),
    // rust: layout: &layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(&view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::Sampler(&linear),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&nearest),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: table.as_entire_binding(),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon HUD (CIT glints)"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("../hud.wgsl").into()),
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("CIT glint layout"),
    // rust: bind_group_layouts: &[Some(hud), Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let attributes =
    // rust: wgpu::vertex_attr_array![0=>Float32x2,1=>Float32x2,2=>Unorm8x4,3=>Float32,4=>Float32x2];
    // rust: let pipelines = textures
    // rust: .blends
    // rust: .iter()
    // rust: .map(|&blend| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("CIT glint"),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_main"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<HudVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &attributes,
    // rust: })],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some("fs_cit_glint"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: Some(blend_state(blend)),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: Some(Self { group, pipelines })
}

    // Draw `vertices` with blend `blend` (an index into `GlintTextures::blends`).
    // rust: pub(super) fn draw(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: blend: u8,
    // rust: vertices: std::ops::Range<u32>,
    // rust: ) {
    // rust: if let Some(pipeline) = self.pipelines.get(usize::from(blend)) {
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_bind_group(1, &self.group, &[]);
    // rust: pass.draw(vertices, 0..1);
}
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_optifine::Properties;
//     use horizon_optifine::cit::parse_blend;

rule :: proc(name: string, text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let path = format!("assets/minecraft/optifine/cit/{name}.properties");
    // rust: let text = format!("texture=glint\n{text}");
    // rust: Rule::parse(&path, &Properties::parse_equals_first(&text), |_| true).unwrap()
}

slots_share_one_size_and_their_blends :: proc() {
}
    // rust: let rules = [
    // rust: rule("a", "type=enchantment\nr=0.5"),
    // rust: rule("item", "items=stick"),
    // rust: rule("b", "type=enchantment\nblend=multiply\nblur=false"),
    // rust: rule("c", "type=enchantment"),
    // rust: ];
        // A 1x1 red glint and a 2x2 one: the red texel fills 2x2.
    // rust: let red = vec![255, 0, 0, 255];
    // rust: let quad: Vec<u8> = (0..16).collect();
    // rust: let t = GlintTextures::new(
    // rust: &rules,
    // rust: vec![
    // rust: (0, (1, 1, red)),
    // rust: (2, (2, 2, quad.clone())),
    // rust: (3, (2, 2, quad.clone())),
    // rust: ],
    // rust: MAX_BYTES,
    // rust: );
    // rust: assert_eq!((t.width, t.height), (2, 2));
    // rust: assert_eq!(t.slot_of, [Some(0), None, Some(1), Some(2)]);
    // rust: assert_eq!(&t.pixels[..16], [255, 0, 0, 255].repeat(4));
    // rust: assert_eq!(&t.pixels[16..32], &quad[..]);
    // rust: assert_eq!(
    // rust: t.blends,
    // rust: [
    // rust: parse_blend("add").unwrap(),
    // rust: parse_blend("multiply").unwrap()
    // rust: ]
    // rust: );
    // rust: let blends: Vec<_> = t.slots.iter().map(|s| s.blend).collect();
    // rust: assert_eq!(blends, [0, 1, 0]);
    // rust: assert_eq!(t.slots[0].rgba, [0.5, 1.0, 1.0, 1.0]);
    // rust: assert!(!t.slots[1].blur && t.slots[2].blur);
    // rust: assert!(GlintTextures::new(&rules, Vec::new(), MAX_BYTES).is_empty());
}

big_glints_are_scaled_down_to_the_largest_side :: proc() {
}
    // rust: let rules = [rule("wide", "type=enchantment\nblur=false")];
        // 2048 x 1, texel x holding x in red and green: every other texel is kept.
    // rust: let wide: Vec<u8> = (0..2048u32)
    // rust: .flat_map(|x| [(x % 256) as u8, (x / 256) as u8, 0, 255])
    // rust: .collect();
    // rust: let t = GlintTextures::new(&rules, vec![(0, (2048, 1, wide))], MAX_BYTES);
    // rust: assert_eq!((t.width, t.height), (1024, 1));
    // rust: for x in [0u32, 1, 300, 1023] {
    // rust: let at = x as usize * 4;
    // rust: let source = 2 * x;
    // rust: let want = [(source % 256) as u8, (source / 256) as u8, 0, 255];
    // rust: assert_eq!(t.pixels[at..at + 4], want, "texel {x}");
}
}

the_array_is_halved_until_it_fits :: proc() {
}
    // rust: let sizes = |n: usize| std::iter::repeat_n((1024, 1024), n);
        // 16 layers of 1024 x 1024 RGBA are 64 MiB; a 17th halves both sides.
    // rust: assert_eq!(shared_size(sizes(16), 16, 64 << 20), Some((1024, 1024)));
    // rust: assert_eq!(shared_size(sizes(17), 17, 64 << 20), Some((512, 512)));
        // The largest of each side, never past MAX_SIDE.
    // rust: let mixed = [(16, 4096), (64, 32)].into_iter();
    // rust: assert_eq!(shared_size(mixed, 2, 64 << 20), Some((64, 1024)));
    // rust: assert_eq!(shared_size(std::iter::empty(), 0, 64 << 20), None);
}

blurred_glints_grow_smoothly_and_sharp_ones_by_texel :: proc() {
}
        // Black then white, doubled: the wrapping blend of the two, or each texel twice.
    // rust: let row = [0, 0, 0, 255, 255, 255, 255, 255];
    // rust: let red = |rgba: Vec<u8>| rgba.chunks(4).map(|t| t[0]).collect::<Vec<_>>();
    // rust: assert_eq!(red(resize(&row, (2, 1), (4, 1), true)), [64, 64, 191, 191]);
    // rust: assert_eq!(red(resize(&row, (2, 1), (4, 1), false)), [0, 0, 255, 255]);
}

a_layer_vertex_carries_its_slot_and_intensity :: proc() {
}
        // Unorm8x4 reads the colour's bytes in memory order: r, g, b, a.
    // rust: assert_eq!(vertex_color(3, 0.5).to_le_bytes(), [3, 0, 0, 128]);
    // rust: assert_eq!(vertex_color(200, 2.0).to_le_bytes(), [200, 0, 0, 255]);
    // rust: assert_eq!(vertex_color(0, -1.0).to_le_bytes(), [0, 0, 0, 0]);
}

a_still_layer_is_scaled_and_turned :: proc() {
}
    // rust: let close =
    // rust: |a: [f32; 2], b: [f32; 2]| (a[0] - b[0]).abs() < 1e-5 && (a[1] - b[1]).abs() < 1e-5;
        // No speed: no scroll whatever the clock.
    // rust: assert!(close(
    // rust: layer_uv([0.25, 0.5], 12_345.0, 0.0, 0.0, 8.0),
    // rust: [2.0, 4.0]
    // rust: ));
        // A quarter turn takes (1, 0) to (0, 1).
    // rust: assert!(close(layer_uv([1.0, 0.0], 0.0, 0.0, 90.0, 1.0), [0.0, 1.0]));
        // 1500 ms at speed 2: 3000 / 110000 back, 3000 / 30000 up.
    // rust: assert!(close(
    // rust: layer_uv([0.0, 0.0], 1500.0, 2.0, 0.0, 8.0),
    // rust: [-3.0 / 110.0, 0.1]
    // rust: ));
}

named_blends_take_their_gl_factors :: proc() {
}
    // rust: let multiply = blend_state(parse_blend("multiply").unwrap());
    // rust: assert_eq!(multiply.color.src_factor, wgpu::BlendFactor::Dst);
    // rust: assert_eq!(
    // rust: multiply.color.dst_factor,
    // rust: wgpu::BlendFactor::OneMinusSrcAlpha
    // rust: );
        // The alpha factors default to GL_ZERO, GL_ONE: the target's alpha stays.
    // rust: assert_eq!(multiply.alpha.src_factor, wgpu::BlendFactor::Zero);
    // rust: assert_eq!(multiply.alpha.dst_factor, wgpu::BlendFactor::One);
    // rust: assert_eq!(
    // rust: blend_state(parse_blend("replace").unwrap()),
    // rust: wgpu::BlendState::REPLACE
    // rust: );
}
}
