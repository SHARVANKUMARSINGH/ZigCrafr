//! Transpiled from Horizon Rust crate
package horizon_client_render_pack_atlas

import "core:fmt"
import "core:mem"
import "core:math"

// The block atlas of shader packs (spec 5.1, `atlasSize` in 5.2): packs sample one 2D atlas
// with atlas coordinates, Horizon keeps block sprites in texture arrays. With a pack, every
// layer is copied into the atlas, and an animated layer again whenever its frame changes.
//
// Flat draws, which read a table per sprite layer, get the game's own layout
// ([`PackAtlas::stitched`]): every sprite at its own size, placed by vanilla's `Stitcher` with its
// padding; this gives the `atlasSize` and spans our probes read in Iris 1.11.7. Other draws get
// a grid of array-sized cells ([`PackAtlas::new`]).

    // rust: mod stitch;

    // rust: pub(super) struct PackAtlas {
    // rust: texture: wgpu::Texture,
    // rust: pub view: wgpu::TextureView,
    // Sprites per row.
    // rust: pub columns: u32,
    // A sprite's edge in pixels, at the first level.
    // rust: pub sprite: u32,
    // Layers per sprite array.
    // rust: split: u32,
    // OptiFine/Iris separate ambient occlusion: pass vertex alpha to hz_Color.a.
    // rust: pub separate_ao: bool,
    // The stitched layout, when the atlas has one.
    // rust: stitched: Option<Stitched>,
}

// A stitched atlas: where each layer's sprite is, and the pipeline that draws them in.
Stitched :: struct {
    // Each layer's sprite at the first level: its top left corner and its side.
    rects: Vec<[u32,
    padding: u32,
    pipeline: wgpu::RenderPipeline,
    // One per sprite array.
    groups: [dynamic]wgpu::BindGroup,
}

// One sprite drawn into one level of a stitched atlas (`BLIT`'s instance).
BlitSprite :: struct {
    // The sprite's top left corner, side and padding at that level.
    rect: [i32,
    // Its layer in its array, the array's level it comes from, the atlas level's size.
    source: [u32,
}

// Draws sprites into a stitched atlas level, padding included: a pixel of the padding repeats
// the sprite's nearest edge pixel, as vanilla's `animate_sprite` shaders do with a clamped sampler.
    // rust: const BLIT: &str = r#"
Out :: struct {
    // rust: @builtin(position) position: vec4<f32>,
    // rust: @location(0) @interpolate(flat) rect: vec4<i32>,
    // rust: @location(1) @interpolate(flat) source: vec2<u32>,
}
    // rust: @group(0) @binding(0) var sprites: texture_2d_array<f32>;
    // rust: @vertex
vs :: proc() {
}
    // rust: var corners = array<vec2<f32>, 6>(vec2(0.0, 0.0), vec2(1.0, 0.0), vec2(0.0, 1.0),
    // rust: vec2(0.0, 1.0), vec2(1.0, 0.0), vec2(1.0, 1.0));
    // rust: let pixel = vec2<f32>(rect.xy - rect.w) + corners[v] * f32(rect.z + 2 * rect.w);
    // rust: let size = vec2<f32>(source.zw);
    // rust: var out: Out;
    // rust: out.position = vec4(pixel.x / size.x * 2.0 - 1.0, 1.0 - pixel.y / size.y * 2.0, 0.0, 1.0);
    // rust: out.rect = rect;
    // rust: out.source = source.xy;
    // rust: return out;
}
    // rust: @fragment
fs :: proc(in: Out) -> @ {
    // Ported from Horizon
    return {}
}
    // rust: let texel = clamp(vec2<i32>(floor(in.position.xy)) - in.rect.xy, vec2(0), vec2(in.rect.z - 1));
    // rust: return textureLoad(sprites, texel, i32(in.source.x), i32(in.source.y));
}
    // rust: "#;

// The side a layer of `sprite`-wide arrays has in a stitched atlas: its own, when the arrays
// hold it scaled up by a power of two (else the array's).
atlas_side :: proc(native: u32, sprite: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if native == 0
    // rust: || native > sprite
    // rust: || !sprite.is_multiple_of(native)
    // rust: || !(sprite / native).is_power_of_two()
    // rust: {
    // rust: sprite
    // rust: } else {
    // rust: native
}
}

// `SpriteLoader.stitch`'s mip level: the option, lowered to fit the smallest sprite.
stitch_mip_level :: proc(sides: ^[u32], option: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut lowest = 1u32 << option.min(16);
    // rust: let mut smallest = u32::MAX;
    // rust: for &side in sides {
    // rust: smallest = smallest.min(side);
    // rust: lowest = lowest.min(side & side.wrapping_neg());
}
    // rust: let level = smallest.min(lowest).max(1).ilog2();
    // rust: level.min(option)
}

    // rust: impl PackAtlas {
    // Copies `layers` layers of `arrays` (`split` per array, `sprite` pixels wide, `levels`
    // mip levels); `None` when the grid is larger than the device allows.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: arrays: &[wgpu::Texture],
    // rust: split: u32,
    // rust: layers: u32,
    // rust: sprite: u32,
    // rust: ) -> Option<Self> {
    // rust: Self::with_levels(
    // rust: device,
    // rust: encoder,
    // rust: arrays,
    // rust: split,
    // rust: layers,
    // rust: sprite,
    // rust: arrays[0].mip_level_count(),
    // rust: )
}

    // Encoded material channels must select an existing texel, including at distance.
    // rust: pub fn material(
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: arrays: &[wgpu::Texture],
    // rust: split: u32,
    // rust: layers: u32,
    // rust: ) -> Option<Self> {
    // rust: Self::with_levels(device, encoder, arrays, split, layers, arrays[0].width(), 1)
}

    // rust: fn with_levels(
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: arrays: &[wgpu::Texture],
    // rust: split: u32,
    // rust: layers: u32,
    // rust: sprite: u32,
    // rust: levels: u32,
    // rust: ) -> Option<Self> {
    // rust: let layers = layers.max(1);
    // rust: let columns = (f64::from(layers).sqrt().ceil() as u32).max(1);
    // rust: let rows = layers.div_ceil(columns);
    // rust: let max = device.limits().max_texture_dimension_2d;
    // rust: if columns * sprite > max || rows * sprite > max {
    // rust: return None;
}
        // Levels past a sprite's single pixel would mix neighbours: stop there.
    // rust: let levels = levels.min(sprite.ilog2() + 1);
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Shader pack block atlas"),
    // rust: size: wgpu::Extent3d {
    // rust: width: columns * sprite,
    // rust: height: rows * sprite,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: levels,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_DST
    // rust: | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = texture.create_view(&Default::default());
    // rust: let atlas = Self {
    // rust: texture,
    // rust: view,
    // rust: columns,
    // rust: sprite,
    // rust: split,
    // rust: separate_ao: false,
    // rust: stitched: None,
}
    // rust: atlas.copy(device, encoder, arrays, 0..layers);
    // rust: Some(atlas)
}

    // Every layer of `arrays` at its own size (`native`, its side before the arrays scaled it up
    // to `sprite`), placed as vanilla's `Stitcher` places them with the padding of the Mipmap
    // Levels option and the anisotropy bit; `None` when they don't fit the device.
    // rust: pub fn stitched(
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: arrays: &[wgpu::Texture],
    // rust: split: u32,
    // rust: sprite: u32,
    // rust: native: &[u32],
    // rust: mip_option: u32,
    // rust: anisotropy_bit: u32,
    // rust: ) -> Option<Self> {
    // rust: let sides: Vec<u32> = if native.is_empty() {
    // rust: vec![sprite]
    // rust: } else {
    // rust: native.iter().map(|&n| atlas_side(n, sprite)).collect()
}
        // A level of the atlas comes from the arrays' level as many halvings further down.
    // rust: let array_levels = arrays[0].mip_level_count();
    // rust: let deepest = sides
    // rust: .iter()
    // rust: .map(|&s| (sprite / s).ilog2())
    // rust: .max()
    // rust: .unwrap_or(0);
    // rust: let mip =
    // rust: stitch_mip_level(&sides, mip_option).min(array_levels.saturating_sub(deepest + 1));
    // rust: let max = device.limits().max_texture_dimension_2d;
    // rust: let layout = stitch::stitch(&sides, mip, anisotropy_bit, max)?;
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Shader pack block atlas"),
    // rust: size: wgpu::Extent3d {
    // rust: width: layout.width.max(1),
    // rust: height: layout.height.max(1),
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: mip + 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_DST
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | wgpu::TextureUsages::RENDER_ATTACHMENT,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = texture.create_view(&Default::default());
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Shader pack atlas sprites"),
    // rust: source: wgpu::ShaderSource::Wgsl(BLIT.into()),
    // rust: });
    // rust: let group_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Shader pack atlas sprites"),
    // rust: entries: &[wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: false },
    // rust: view_dimension: wgpu::TextureViewDimension::D2Array,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: }],
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Shader pack atlas sprites"),
    // rust: bind_group_layouts: &[Some(&group_layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Shader pack atlas sprites"),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: Some("vs"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<BlitSprite>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &wgpu::vertex_attr_array![0 => Sint32x4, 1 => Uint32x4],
    // rust: })],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: Some("fs"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::TextureFormat::Rgba8Unorm.into())],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let groups = arrays
    // rust: .iter()
    // rust: .map(|array| {
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack atlas sprites"),
    // rust: layout: &group_layout,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(&array.create_view(
    // rust: &wgpu::TextureViewDescriptor {
    // rust: dimension: Some(wgpu::TextureViewDimension::D2Array),
    // rust: ..Default::default()
    // rust: },
    // rust: )),
    // rust: }],
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let rects = layout
    // rust: .holders
    // rust: .iter()
    // rust: .zip(&sides)
    // rust: .map(|(&[x, y], &side)| [x + layout.padding, y + layout.padding, side])
    // rust: .collect::<Vec<_>>();
    // rust: let layers = rects.len() as u32;
    // rust: let atlas = Self {
    // rust: texture,
    // rust: view,
    // rust: columns: 1,
    // rust: sprite,
    // rust: split,
    // rust: separate_ao: false,
    // rust: stitched: Some(Stitched {
    // rust: rects,
    // rust: padding: layout.padding,
    // rust: pipeline,
    // rust: groups,
    // rust: }),
}
    // rust: atlas.copy(device, encoder, arrays, 0..layers);
    // rust: Some(atlas)
}

    // Whether the sprites keep their own sizes ([`PackAtlas::stitched`]).
is_stitched :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.stitched.is_some()
}

    // The table flat terrain reads (`hz_sprite_rects`): per layer, its sprite's top left corner
    // (x | y << 16) and side, in atlas pixels.
rects_table :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(stitched) = &self.stitched {
    // rust: return stitched
    // rust: .rects
    // rust: .iter()
    // rust: .flat_map(|&[x, y, side]| [x | (y << 16), side])
    // rust: .collect();
}
    // rust: (0..self.columns * self.texture.height() / self.sprite)
    // rust: .flat_map(|layer| {
    // rust: let (x, y) = (layer % self.columns, layer / self.columns);
    // rust: [(x * self.sprite) | ((y * self.sprite) << 16), self.sprite]
    // rust: })
    // rust: .collect()
}

    // The atlas's size in pixels (`atlasSize`).
size :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [self.texture.width(), self.texture.height()]
}

    // Copies `layers` from the sprite arrays again, every level.
    // rust: pub fn copy(
    // rust: &self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: arrays: &[wgpu::Texture],
    // rust: layers: impl IntoIterator<Item = u32>,
    // rust: ) {
    // rust: if let Some(stitched) = &self.stitched {
    // rust: return self.draw_sprites(stitched, device, encoder, layers);
}
    // rust: for layer in layers {
    // rust: let Some(array) = arrays.get((layer / self.split) as usize) else {
    // rust: continue;
}
    // rust: let (column, row) = (layer % self.columns, layer / self.columns);
    // rust: for level in 0..self.texture.mip_level_count() {
    // rust: let edge = self.sprite >> level;
    // rust: encoder.copy_texture_to_texture(
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture: array,
    // rust: mip_level: level,
    // rust: origin: wgpu::Origin3d {
    // rust: x: 0,
    // rust: y: 0,
    // rust: z: layer % self.split,
    // rust: },
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture: &self.texture,
    // rust: mip_level: level,
    // rust: origin: wgpu::Origin3d {
    // rust: x: column * edge,
    // rust: y: row * edge,
    // rust: z: 0,
    // rust: },
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width: edge,
    // rust: height: edge,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
}
}
}

    // Draws `layers` into every level of a stitched atlas, from the arrays' level where each
    // sprite has its own size.
    // rust: fn draw_sprites(
    // rust: &self,
    // rust: stitched: &Stitched,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: layers: impl IntoIterator<Item = u32>,
    // rust: ) {
    // rust: let mut layers: Vec<u32> = layers
    // rust: .into_iter()
    // rust: .filter(|&l| (l as usize) < stitched.rects.len())
    // rust: .collect();
    // rust: if layers.is_empty() {
    // rust: return;
}
    // rust: layers.sort_unstable_by_key(|&l| (l / self.split, l));
    // rust: let levels = self.texture.mip_level_count();
    // rust: let mut sprites = Vec::with_capacity(layers.len() * levels as usize);
    // rust: for level in 0..levels {
    // rust: let size = [
    // rust: self.texture.width() >> level,
    // rust: self.texture.height() >> level,
    // rust: ];
    // rust: for &layer in &layers {
    // rust: let [x, y, side] = stitched.rects[layer as usize];
    // rust: sprites.push(BlitSprite {
    // rust: rect: [x, y, side, stitched.padding].map(|v| (v >> level) as i32),
    // rust: source: [
    // rust: layer % self.split,
    // rust: (self.sprite / side).ilog2() + level,
    // rust: size[0],
    // rust: size[1],
    // rust: ],
    // rust: });
}
}
    // rust: let buffer = wgpu::util::DeviceExt::create_buffer_init(
    // rust: device,
    // rust: &wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Shader pack atlas sprites"),
    // rust: contents: bytemuck::cast_slice(&sprites),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: },
    // rust: );
    // rust: let per_level = layers.len() as u32;
    // rust: for level in 0..levels {
    // rust: let view = self.texture.create_view(&wgpu::TextureViewDescriptor {
    // rust: base_mip_level: level,
    // rust: mip_level_count: Some(1),
    // rust: ..Default::default()
    // rust: });
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Shader pack atlas sprites"),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&stitched.pipeline);
    // rust: pass.set_vertex_buffer(0, buffer.slice(..));
    // rust: let first = level * per_level;
    // rust: let mut start = 0;
    // rust: while start < layers.len() {
    // rust: let array = layers[start] / self.split;
    // rust: let end = start
    // rust: + layers[start..]
    // rust: .iter()
    // rust: .take_while(|&&l| l / self.split == array)
    // rust: .count();
    // rust: if let Some(group) = stitched.groups.get(array as usize) {
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.draw(0..6, first + start as u32..first + end as u32);
}
    // rust: start = end;
}
}
}
}

// A `TerrainVertex` of flat draws' arena page (`hz_vertices`, six words each) into the vertex
// inputs, for vertex `hz_vertex_index`.
PULL :: "        uint hz_pw = hz_vertex_index * 6u
    // rust: hz_v_pos = uintBitsToFloat(uvec3(hz_vertices[hz_pw], hz_vertices[hz_pw + 1u], hz_vertices[hz_pw + 2u]));\n        \
    // rust: hz_v_uv = uvec2(hz_vertices[hz_pw + 3u] & 65535u, hz_vertices[hz_pw + 3u] >> 16u);\n        \
    // rust: hz_v_layer = hz_vertices[hz_pw + 4u] & 65535u;\n        \
    // rust: uint hz_pl = hz_vertices[hz_pw + 4u] >> 16u;\n        \
    // rust: hz_v_light = uvec2(hz_pl & 255u, hz_pl >> 8u);\n        \
    // rust: hz_v_color = unpackUnorm4x8(hz_vertices[hz_pw + 5u]);\n";

// GLSL: the face normal and tangent of a flat-drawn vertex, from its quad's first three corners
// (quads are four consecutive vertices of the page; position words 0-2, UV word 3).
FACE :: "    uint hz_q = (uint(gl_VertexIndex) & ~3u) * 6u
    // rust: vec3 hz_p0 = uintBitsToFloat(uvec3(hz_vertices[hz_q], hz_vertices[hz_q + 1u], hz_vertices[hz_q + 2u]));\n    \
    // rust: vec3 hz_p1 = uintBitsToFloat(uvec3(hz_vertices[hz_q + 6u], hz_vertices[hz_q + 7u], hz_vertices[hz_q + 8u]));\n    \
    // rust: vec3 hz_p2 = uintBitsToFloat(uvec3(hz_vertices[hz_q + 12u], hz_vertices[hz_q + 13u], hz_vertices[hz_q + 14u]));\n    \
    // rust: uvec3 hz_w = uvec3(hz_vertices[hz_q + 3u], hz_vertices[hz_q + 9u], hz_vertices[hz_q + 15u]);\n    \
    // rust: vec2 hz_t0 = vec2(hz_w.x & 65535u, hz_w.x >> 16u);\n    \
    // rust: vec2 hz_d1 = vec2(hz_w.y & 65535u, hz_w.y >> 16u) - hz_t0;\n    \
    // rust: vec2 hz_d2 = vec2(hz_w.z & 65535u, hz_w.z >> 16u) - hz_t0;\n    \
    // rust: uint hz_w3 = hz_vertices[hz_q + 21u];\n    \
    // rust: vec2 hz_t3 = vec2(hz_w3 & 65535u, hz_w3 >> 16u);\n    \
    // rust: hz_mid = (clamp(hz_t0 * hz_uv_scale, 0.0, 1.0) + clamp((hz_t0 + hz_d1) * hz_uv_scale, 0.0, 1.0)\n        \
    // rust: + clamp((hz_t0 + hz_d2) * hz_uv_scale, 0.0, 1.0) + clamp(hz_t3 * hz_uv_scale, 0.0, 1.0)) * 0.25;\n    \
    // rust: vec3 hz_e1 = hz_p1 - hz_p0;\n    \
    // rust: vec3 hz_e2 = hz_p2 - hz_p0;\n    \
    // rust: vec3 hz_n = cross(hz_e1, hz_e2);\n    \
    // rust: if (dot(hz_n, hz_n) > 1e-12) {\n        \
    // rust: hz_Normal = normalize(hz_n);\n        \
    // rust: float hz_r = hz_d1.x * hz_d2.y - hz_d2.x * hz_d1.y;\n        \
    // rust: vec3 hz_t = (hz_e1 * hz_d2.y - hz_e2 * hz_d1.y) * sign(hz_r);\n        \
    // rust: vec3 hz_b = (hz_e2 * hz_d1.x - hz_e1 * hz_d2.x) * sign(hz_r);\n        \
    // rust: if (dot(hz_t, hz_t) > 1e-12) {\n            \
    // rust: hz_t = normalize(hz_t - hz_Normal * dot(hz_Normal, hz_t));\n            \
    // rust: hz_tangent = vec4(hz_t, dot(cross(hz_t, hz_Normal), hz_b) < 0.0 ? -1.0 : 1.0);\n        \
    // rust: }\n    \
    // rust: }\n";

// `terrain` (`PackAtlas::terrain_inputs`) drawing only solid terrain, then only cutout terrain:
// each leaves the other part's quads outside the clip volume. Solid: the quads over opaque
// texels and opaque leaves (`mesher::OPAQUE_LAYER`), as vanilla picks `ChunkSectionLayer.SOLID`
// per quad (`FaceBakery.computeMaterialTransparency`, `SectionCompiler.compile`), and lava's
// faces (sprite layers `lava`, its still and flowing sprites), which Iris 1.11.7 drew with
// `gbuffers_terrain_solid` in our probes, with and without `separateAo`.
//
// The test reads only the vertex's sprite layer, which all four vertices of a quad share: a
// quad lands whole in one part. The colour's alpha can't decide it, as with `separateAo` it
// holds each vertex's own ambient occlusion.
    // rust: pub fn terrain_parts(
    // rust: terrain: &horizon_shaders::GbuffersInputs,
    // rust: lava: &[u16],
    // rust: ) -> [horizon_shaders::GbuffersInputs; 2] {
    // rust: let opaque = crate::mesher::OPAQUE_LAYER;
    // rust: let lava: String = lava
    // rust: .iter()
    // rust: .map(|l| format!(" || hz_v_layer == {l}u"))
    // rust: .collect();
    // rust: let part = |solid: bool| {
    // rust: let mut inputs = terrain.clone();
    // rust: inputs.after.push_str(&format!(
    // rust: "    bool hz_solid = (hz_v_layer & {opaque}u) != 0u{lava};\n    \
    // rust: if (hz_solid != {solid}) gl_Position = vec4(2.0, 2.0, 2.0, 1.0);\n"
    // rust: ));
    // rust: inputs
}
    // rust: [part(true), part(false)]
}

    // rust: impl PackAtlas {
    // The vertex inputs of a gbuffers program drawing terrain (`TerrainVertex`, terrain.wgsl's
    // `vs_terrain` or, for `flat` draws, `vs_terrain_flat`), in atlas coordinates.
terrain_inputs :: proc(self: ^Self, flat: bool) -> h {
    // Ported from Horizon
    return {}
}
    // rust: let mut declarations = String::from(
    // rust: "layout(location = 0) in vec3 hz_v_pos;\nlayout(location = 1) in uvec2 hz_v_uv;\n\
    // rust: layout(location = 2) in uint hz_v_layer;\nlayout(location = 3) in vec4 hz_v_color;\n\
    // rust: layout(location = 4) in uvec2 hz_v_light;\n",
    // rust: );
    // rust: let origin = if flat {
    // rust: declarations.push_str(
    // rust: "layout(set = 1, binding = 0) readonly buffer HzBlockSlots { uint hz_block_slots[]; };\n\
    // rust: layout(set = 1, binding = 1) readonly buffer HzSlotOrigins { vec4 hz_slot_origins[]; };\n",
    // rust: );
            // Of each sprite layer, `mc_Entity` (id, then 1 for fluids or -1) and
            // `at_midBlock.w` (its block's light), the game's table; and the arena page's
            // vertices (`TerrainVertex`, six words each).
    // rust: declarations.push_str(
    // rust: "layout(set = 3, binding = 0) readonly buffer HzBlockIds { int hz_block_ids[]; };\n\
    // rust: layout(set = 3, binding = 1) readonly buffer HzVertices { uint hz_vertices[]; };\n\
    // rust: layout(set = 3, binding = 2) readonly buffer HzSpriteRects { uvec2 hz_sprite_rects[]; };\n",
    // rust: );
    // rust: "hz_slot_origins[hz_block_slots[uint(gl_VertexIndex) >> 8u]]"
    // rust: } else {
    // rust: declarations.push_str("layout(location = 5) in vec4 hz_v_origin;\n");
    // rust: "hz_v_origin"
}
    // rust: let [width, height] = self.size();
        // A sprite's cell in its own sides, and the share of the atlas a side is: from the table
        // in flat draws (`rects_table`), from the grid in others.
    // rust: let columns = self.columns;
    // rust: let (cell, side, scale) = if flat {
    // rust: (
    // rust: "uvec2 hz_rect = hz_sprite_rects[hz_layer];\n    \
    // rust: hz_cell = vec2(float(hz_rect.x & 65535u), float(hz_rect.x >> 16u)) / float(hz_rect.y);\n    "
    // rust: .to_owned(),
    // rust: "float(hz_rect.y)",
    // rust: [1.0 / width as f32, 1.0 / height as f32],
    // rust: )
    // rust: } else {
    // rust: (
    // rust: format!(
    // rust: "hz_cell = vec2(float(hz_layer % {columns}u), float(hz_layer / {columns}u));\n    "
    // rust: ),
    // rust: "1.0",
    // rust: [
    // rust: self.sprite as f32 / width as f32,
    // rust: self.sprite as f32 / height as f32,
    // rust: ],
    // rust: )
}
        // UVs past a sprite (models up to 2, distant tiles) cannot repeat in an atlas: clamped.
        // The colour's alpha holds HDR's emission level (`mesher::EMISSION_BITS`): packs get 1 unless separate_ao.
    // rust: let color_a = if self.separate_ao {
    // rust: "hz_v_color.a"
    // rust: } else {
    // rust: "1.0"
}
        // A vertex's place in its section goes down to the 32768th of a block below it: read back
        // with a probe pack of ours, Iris 1.11.7's terrain `gl_Vertex` has that for every position
        // we read (water tops at 8/9 - 0.001, plants' offsets), on all three axes (#8464). A fit,
        // not Iris's code. Whole and half blocks, and every 1/16, are on that grid already. A place
        // up to 1/32 of a 32768th (one float step below 16) under a grid line is on it: plants whose
        // random offset is 9/15 of a block read exactly on a half block in Iris, and a 32768th
        // under it in Horizon (our guess, not tested: Horizon's float sum lands just under the
        // line) (#8464). Also a fit.
    // rust: let body = format!(
    // rust: "    vec4 hz_origin = {origin};\n    \
    // rust: uint hz_layer = hz_v_layer & 32767u;\n    \
    // rust: {cell}\
    // rust: hz_scale = vec2({:?}, {:?}) * {side};\n    \
    // rust: hz_Vertex = vec4(floor(hz_v_pos * 32768.0 + 0.03125) / 32768.0 + hz_origin.xyz, 1.0);\n    \
    // rust: hz_uv_scale = hz_origin.w > 0.0 ? uintBitsToFloat(floatBitsToUint(hz_origin.w) & 0xff800000u) : fract(abs(hz_origin.w));\n    \
    // rust: hz_mid = vec2(0.5);\n    \
    // rust: hz_MultiTexCoord0 = vec4((hz_cell + clamp(vec2(hz_v_uv) * hz_uv_scale, 0.0, 1.0)) * hz_scale, 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord1 = vec4(float(hz_v_light.y), float(hz_v_light.x), 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord2 = hz_MultiTexCoord1;\n    \
    // rust: hz_Color = vec4(hz_v_color.rgb, {color_a});\n    \
    // rust: hz_Normal = vec3(0.0, 1.0, 0.0);\n    \
    // rust: hz_tangent = vec4(1.0, 0.0, 0.0, 1.0);\n",
    // rust: scale[0], scale[1],
    // rust: );
    // rust: let mut body = body;
    // rust: if flat {
    // rust: body.push_str(FACE);
}
    // rust: declarations.push_str(
    // rust: "vec2 hz_cell; vec2 hz_scale; vec2 hz_mid; float hz_uv_scale; vec4 hz_tangent;\n",
    // rust: );
    // rust: let entity = if flat {
    // rust: "vec4(float(hz_block_ids[3u * hz_layer]), float(hz_block_ids[3u * hz_layer + 1u]), 0.0, 0.0)"
    // rust: } else {
    // rust: "vec4(-1.0, -1.0, 0.0, 0.0)"
}
        // The block a face belongs to: half a block behind its centre (the quad's diagonal);
        // w, the light it gives (Iris's `BLOCK_EMISSION_ATTRIBUTE`, 0 to 15).
    // rust: let mid_block = if flat {
    // rust: "vec4((floor((hz_p0 + hz_p2) * 0.5 - 0.5 * hz_Normal) + 0.5 - hz_v_pos) * 64.0, \
    // rust: float(hz_block_ids[3u * hz_layer + 2u]))"
    // rust: } else {
    // rust: "vec4(0.0)"
}
    // rust: let attributes = [
            // section_instance stores 1 - visibility in a positive origin's mantissa.
            // Negative origins encode a distant-terrain handover, fully visible here
            // just as terrain.wgsl's instance_visibility treats them.
    // rust: (
    // rust: "mc_chunkFade",
    // rust: "(hz_origin.w > 0.0 ? 1.0 - float(floatBitsToUint(hz_origin.w) & 0x7fffffu) / 8388608.0 : 1.0)",
    // rust: ),
    // rust: ("mc_Entity", entity),
    // rust: ("at_midBlock", mid_block),
    // rust: (
    // rust: "mc_midTexCoord",
    // rust: "vec4((hz_cell + hz_mid) * hz_scale, 0.0, 1.0)",
    // rust: ),
    // rust: ("at_tangent", "hz_tangent"),
    // rust: ("vaPosition", "hz_Vertex.xyz"),
    // rust: ("vaUV0", "hz_MultiTexCoord0.xy"),
    // rust: ("vaUV2", "hz_MultiTexCoord1.xy"),
    // rust: ("vaColor", "hz_Color"),
    // rust: ("vaNormal", "hz_Normal"),
    // rust: ];
    // rust: horizon_shaders::GbuffersInputs {
    // rust: declarations,
    // rust: body,
    // rust: attributes: attributes
    // rust: .iter()
    // rust: .map(|&(n, v)| (n.to_owned(), v.to_owned()))
    // rust: .collect(),
    // rust: after: String::new(),
    // rust: alpha_test: None,
    // rust: item_id_declared: false,
    // rust: far_depth: false,
}
}
}

    // rust: mod fade_test;

    // rust: mod midpoint_test;

    // rust: mod tests {
//     use super::*;

    // Two arrays of 2x2 sprites, one layer split; each layer a colour of its own.
layers_land_in_their_cells :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let (device, queue) =
    // rust: pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let (split, layers, sprite) = (3u32, 5u32, 2u32);
    // rust: let arrays: Vec<wgpu::Texture> = (0..2)
    // rust: .map(|a| {
    // rust: let count = (layers - a * split).min(split);
    // rust: let pixels: Vec<u8> = (0..count)
    // rust: .flat_map(|l| [(a * split + l) as u8 * 40, 0, 0, 255].repeat(4))
    // rust: .collect();
    // rust: wgpu::util::DeviceExt::create_texture_with_data(
    // rust: &device,
    // rust: &queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: sprite,
    // rust: height: sprite,
    // rust: depth_or_array_layers: count,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &pixels,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let atlas = PackAtlas::new(&device, &mut encoder, &arrays, split, layers, sprite).unwrap();
    // rust: assert_eq!((atlas.columns, atlas.size()), (3, [6, 4]));
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 256 * 4,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_texture_to_buffer(
    // rust: atlas.texture.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(256),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width: 6,
    // rust: height: 4,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let data = read.slice(..).get_mapped_range().unwrap();
    // rust: let red = |x: usize, y: usize| data[y * 256 + x * 4];
        // Layer 4 (second array, its second layer) is in row 1, column 1.
    // rust: assert_eq!([red(0, 0), red(2, 0), red(4, 0)], [0, 40, 80]);
    // rust: assert_eq!([red(1, 3), red(3, 2), red(5, 2)], [120, 160, 0]);
}

    // An array of `sprite`-pixel layers (`sprite` the largest of `native`), as the game builds
    // them: each layer scaled up by whole pixels at level 0, its own pixels from the level where
    // it has its own size. Every pixel of a layer's own image differs: (layer, x, y, 255).
    // rust: pub(super) fn upscaled_array(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: native: &[u32],
    // rust: ) -> wgpu::Texture {
    // rust: let sprite = native.iter().copied().max().unwrap();
    // rust: let levels = sprite.ilog2() + 1;
    // rust: let mut data = Vec::new();
    // rust: for (layer, &side) in native.iter().enumerate() {
    // rust: for level in 0..levels {
    // rust: let edge = sprite >> level;
                // Above its own size a level repeats each pixel; below, it shrinks to the first.
    // rust: let scale = (edge / side).max(1);
    // rust: for y in 0..edge {
    // rust: for x in 0..edge {
    // rust: let (x, y) = if edge >= side {
    // rust: (x / scale, y / scale)
    // rust: } else {
    // rust: (0, 0)
}
    // rust: data.extend([layer as u8 * 50, x as u8 * 16, y as u8 * 16, 255]);
}
}
}
}
    // rust: wgpu::util::DeviceExt::create_texture_with_data(
    // rust: device,
    // rust: queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: sprite,
    // rust: height: sprite,
    // rust: depth_or_array_layers: native.len() as u32,
    // rust: },
    // rust: mip_level_count: levels,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &data,
    // rust: )
}

    // Sprites of 2, 4 and 1 px in a 4 px array, no mipmaps (one pixel of padding). Worked through
    // vanilla's `Stitcher` by hand: holders of 6, 4 and 3 px at (0, 0), (8, 0) and (8, 4) in a 16
    // by 8 atlas. Each sprite has its own pixels, and its padding repeats its edge.
stitched_sprites_keep_their_own_size_and_padding :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let (device, queue) =
    // rust: pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let array = upscaled_array(&device, &queue, &[2, 4, 1]);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let atlas =
    // rust: PackAtlas::stitched(&device, &mut encoder, &[array], 3, 4, &[2, 4, 1], 0, 0).unwrap();
    // rust: assert_eq!(atlas.size(), [16, 8]);
    // rust: assert_eq!(
    // rust: atlas.rects_table(),
    // rust: [9 | 1 << 16, 2, 1 | 1 << 16, 4, 9 | 5 << 16, 1]
    // rust: );
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 256 * 8,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_texture_to_buffer(
    // rust: atlas.texture.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(256),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width: 16,
    // rust: height: 8,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let data = read.slice(..).get_mapped_range().unwrap();
    // rust: let at = |x: usize, y: usize| {
    // rust: let i = y * 256 + x * 4;
    // rust: [data[i], data[i + 1], data[i + 2], data[i + 3]]
}
        // Layer 0's own 2 px: (layer 0, x, y); its padding repeats the nearest edge pixel.
    // rust: assert_eq!(
    // rust: [at(9, 1), at(10, 1), at(10, 2)],
    // rust: [[0, 0, 0, 255], [0, 16, 0, 255], [0, 16, 16, 255]]
    // rust: );
    // rust: assert_eq!(
    // rust: [at(8, 0), at(11, 3), at(11, 1)],
    // rust: [[0, 0, 0, 255], [0, 16, 16, 255], [0, 16, 0, 255]]
    // rust: );
        // Layer 1 fills its 4 px, padded; layer 2 is one pixel in the middle of its padding.
    // rust: assert_eq!(
    // rust: [at(1, 1), at(4, 4), at(0, 5), at(5, 0)],
    // rust: [
    // rust: [50, 0, 0, 255],
    // rust: [50, 48, 48, 255],
    // rust: [50, 0, 48, 255],
    // rust: [50, 48, 0, 255]
    // rust: ]
    // rust: );
    // rust: assert_eq!([at(9, 5), at(8, 4), at(10, 6)], [[100, 0, 0, 255]; 3]);
}

terrain_inputs_respects_separate_ao :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let (device, _) = pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 16,
    // rust: height: 16,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = texture.create_view(&Default::default());
    // rust: let mut atlas = PackAtlas {
    // rust: texture,
    // rust: view,
    // rust: columns: 1,
    // rust: sprite: 16,
    // rust: split: 1,
    // rust: separate_ao: false,
    // rust: stitched: None,
}
    // rust: let inputs_default = atlas.terrain_inputs(false);
    // rust: assert!(
    // rust: inputs_default
    // rust: .body
    // rust: .contains("hz_Color = vec4(hz_v_color.rgb, 1.0);")
    // rust: );

    // rust: atlas.separate_ao = true;
    // rust: let inputs_separate = atlas.terrain_inputs(false);
    // rust: assert!(
    // rust: inputs_separate
    // rust: .body
    // rust: .contains("hz_Color = vec4(hz_v_color.rgb, hz_v_color.a);")
    // rust: );
}
}
