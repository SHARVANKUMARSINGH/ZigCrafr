//! Transpiled from Horizon Rust crate
package horizon_client_render_pack_shadow

import "core:fmt"
import "core:mem"
import "core:math"

// A shader pack's shadow buffers (spec 6.3): the shadow map's depth (`shadowtex0`, and
// `shadowtex1` without translucent geometry), and the colour buffers `shadowcolor0` to `7`, each
// with two sides that `shadowcomp` programs flip as composite programs flip colortex (6.1.6).
// Square, `shadowMapResolution` pixels.

// use horizon_shaders::SHADOW_COLORS;

    // rust: type Ops<T> = wgpu::Operations<T>;
    // rust: type Color = wgpu::Color;

// Loaded and stored.
    // rust: pub(super) fn load<T>() -> Ops<T> {
    // rust: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
}
}

clear :: proc(c: [f32; 4]) -> O {
    // Ported from Horizon
    return {}
}
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

// What the shadow pass writes and the programs read.
    // rust: pub(super) struct ShadowTargets {
    // rust: pub size: u32,
    // `shadowtex0`, written by the shadow pass.
    // rust: pub depth: (wgpu::Texture, wgpu::TextureView),
    // `shadowtex1`: a copy of `shadowtex0` taken before translucent terrain, when read.
    // rust: pub depth1: Option<(wgpu::Texture, wgpu::TextureView)>,
    // Both sides of each shadowcolor buffer used; one texture for both when no `shadowcomp`
    // program draws into or flips the buffer.
    // rust: pub color: [Option<[wgpu::TextureView; 2]>; SHADOW_COLORS],
    // The clear colour of each buffer cleared every frame.
    // rust: pub clears: [Option<[f32; 4]>; SHADOW_COLORS],
    // Bit n set: B is shadowcolor n's "main".
    // rust: pub main: u16,
    // Nothing cleared yet this frame: the first pass into the shadow buffers clears them as it
    // begins (`clear_ops`), which saves a pass that loads and stores them all on tiled GPUs.
    // rust: fresh: bool,
    // Bit n set: shadowcolor n was cleared that way.
    // rust: cleared: u8,
    // Depth comparison for `sampler2DShadow` (hardware filtering): linear, as GL filters it.
    // rust: pub comparison: wgpu::Sampler,
}

    // rust: fn target(
    // rust: device: &wgpu::Device,
    // rust: label: &str,
    // rust: size: u32,
    // rust: format: wgpu::TextureFormat,
    // rust: copy: wgpu::TextureUsages,
    // rust: ) -> (wgpu::Texture, wgpu::TextureView) {
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: wgpu::Extent3d {
    // rust: width: size,
    // rust: height: size,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::RENDER_ATTACHMENT | copy,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = texture.create_view(&Default::default());
    // rust: (texture, view)
}

    // rust: impl ShadowTargets {
    // The buffers of `shadow` the pack uses: `colors` (bit n: shadowcolor n), `depth1` when
    // some program reads `shadowtex1`, `doubled` (bit n: shadowcolor n needs a B texture). The
    // resolution is kept within the device's limit.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: shadow: &horizon_shaders::Shadow,
    // rust: formats: [wgpu::TextureFormat; SHADOW_COLORS],
    // rust: colors: u16,
    // rust: doubled: u16,
    // rust: depth1: bool,
    // rust: ) -> Self {
    // rust: let size = shadow
    // rust: .resolution
    // rust: .clamp(1, device.limits().max_texture_dimension_2d);
    // rust: let copy = wgpu::TextureUsages::COPY_SRC | wgpu::TextureUsages::COPY_DST;
    // rust: let depth = wgpu::TextureFormat::Depth32Float;
    // rust: let color = std::array::from_fn(|n| {
    // rust: (colors & 1 << n != 0).then(|| {
    // rust: let side = |side: &str| {
    // rust: let label = format!("Shader pack shadowcolor{n} {side}");
    // rust: target(
    // rust: device,
    // rust: &label,
    // rust: size,
    // rust: formats[n],
    // rust: wgpu::TextureUsages::empty(),
    // rust: )
    // rust: .1
}
    // rust: let a = side("A");
    // rust: let b = if doubled & 1 << n != 0 {
    // rust: side("B")
    // rust: } else {
    // rust: a.clone()
}
    // rust: [a, b]
    // rust: })
    // rust: });
    // rust: Self {
    // rust: size,
    // rust: depth: target(device, "Shader pack shadowtex0", size, depth, copy),
    // rust: depth1: depth1.then(|| target(device, "Shader pack shadowtex1", size, depth, copy)),
    // rust: color,
    // rust: clears: std::array::from_fn(|n| {
    // rust: let b = &shadow.colors[n];
    // rust: b.clear.then(|| b.clear_color.unwrap_or([1.0; 4]))
    // rust: }),
    // rust: main: 0,
    // rust: fresh: false,
    // rust: cleared: 0,
    // rust: comparison: device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Shader pack shadow comparison"),
    // rust: compare: Some(wgpu::CompareFunction::LessEqual),
    // rust: mag_filter: wgpu::FilterMode::Linear,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: ..Default::default()
    // rust: }),
}
}

    // Side `alt` (of "main" and "alt") of shadowcolor `n`.
color :: proc(self: ^Self, n: uint, alt: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let side = usize::from(self.main & 1 << n != 0) ^ usize::from(alt);
    // rust: self.color.get(n)?.as_ref().map(|c| &c[side])
}

    // A new frame: the shadow map and the shadowcolor buffers cleared every frame (6.3) are
    // cleared by the first pass that begins (`clear_ops`), or else by `clear_rest`.
begin_frame :: proc(self: ^Self) {
}
    // rust: self.fresh = true;
    // rust: self.cleared = 0;
}

    // The load operations of a pass into the shadow map and shadowcolor buffers `writes`:
    // clears in the frame's first one, loads after.
    // rust: pub fn clear_ops(
    // rust: &mut self,
    // rust: writes: impl Iterator<Item = usize>,
    // rust: ) -> (Ops<f32>, [Ops<Color>; SHADOW_COLORS]) {
    // rust: if !std::mem::take(&mut self.fresh) {
    // rust: return (load(), [load(); SHADOW_COLORS]);
}
    // rust: let mut colors = [load(); SHADOW_COLORS];
    // rust: for n in writes.filter(|&n| n < SHADOW_COLORS) {
    // rust: if let Some(c) = self.clears[n] {
    // rust: colors[n] = clear(c);
    // rust: self.cleared |= 1 << n;
}
}
    // rust: let depth = wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(1.0),
    // rust: store: wgpu::StoreOp::Store,
}
    // rust: (depth, colors)
}

    // Clears what no pass has cleared this frame: all of it when no shadow program drew, the
    // cleared shadowcolor buffers the first one did not write. One buffer a pass: eight wide
    // formats together would pass the device's bytes-per-sample limit.
clear_rest :: proc(self: ^Self, encoder: ^wgpu::CommandEncoder) {
}
    // rust: let mut depth = std::mem::take(&mut self.fresh);
    // rust: let cleared = std::mem::replace(&mut self.cleared, u8::MAX);
    // rust: let attachments = (0..SHADOW_COLORS)
    // rust: .filter(|n| cleared & 1 << n == 0)
    // rust: .filter_map(|n| {
    // rust: Some(Some(wgpu::RenderPassColorAttachment {
    // rust: view: self.color(n, false)?,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: clear(self.clears[n]?),
    // rust: }))
    // rust: });
    // rust: let passes: Vec<Vec<_>> = attachments.map(|a| vec![a]).collect();
    // rust: let passes = if passes.is_empty() && depth {
    // rust: vec![Vec::new()]
    // rust: } else {
    // rust: passes
}
    // rust: for attachments in &passes {
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Shader pack shadow clear"),
    // rust: color_attachments: attachments,
    // rust: depth_stencil_attachment: std::mem::take(&mut depth).then_some(
    // rust: wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &self.depth.1,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(1.0),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: },
    // rust: ),
    // rust: ..Default::default()
    // rust: });
}
}

    // `shadowtex1`: the shadow map as it is now (before translucent geometry).
copy_depth1 :: proc(self: ^Self, encoder: ^wgpu::CommandEncoder) {
}
    // rust: if let Some((copy, _)) = &self.depth1 {
    // rust: encoder.copy_texture_to_texture(
    // rust: self.depth.0.as_image_copy(),
    // rust: copy.as_image_copy(),
    // rust: self.depth.0.size(),
    // rust: );
}
}
}
