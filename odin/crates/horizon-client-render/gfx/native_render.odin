//! Transpiled from Horizon Rust crate
package horizon_client_render_native_render

import "core:fmt"
import "core:mem"
import "core:math"

// Render hook points for native mods (docs/native-mods.md): empty functions the renderer calls at
// fixed places of a frame, which a mod's mixins hook like those of
// `horizon-client/src/game/native_hooks.rs`, and listed with them in `native-hooks.json`. API
// 58.

// use super::Vertex;
// use super::pack_draw::EntitySpan;
// use glam::{DVec3, Mat4};
// use std::sync::{
    // rust: OnceLock,
    // rust: atomic::{AtomicBool, Ordering},
}

    // rust: mod generated {
    // rust: include!(concat!(env!("OUT_DIR"), "/native_render_generated.rs"));
}
    // rust: pub use generated::{HandDrawnEvent, RenderHooks, RenderNeedsEvent, WorldDrawnEvent};
    // rust: pub use wgpu;

RENDERERS :: OnceLock::new()

// Install trait mod renderers in dispatch order, once per process.
    // rust: pub fn install(
    // rust: renderers: Box<[&'static dyn RenderHooks]>,
    // rust: ) -> Result<(), Box<[&'static dyn RenderHooks]>> {
    // rust: RENDERERS.set(renderers)
}

MODS_BUILT_IN :: AtomicBool::new(false)

// The game was built with native mods (the game sets it at start): one of them may draw in
// [`native_world_drawn`], so the first-person hand keeps its own pass after it.
set_mods_built_in :: proc(on: bool) {
}
    // rust: MODS_BUILT_IN.store(on, Ordering::Relaxed);
}
// Whether [`native_world_drawn`] may draw ([`set_mods_built_in`]).
world_drawn_hooked :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: MODS_BUILT_IN.load(Ordering::Relaxed)
    // rust: || RENDERERS
    // rust: .get()
    // rust: .is_some_and(|renderers| !renderers.is_empty())
}

// What a mod can draw with once the world is drawn: after the sky, terrain, entities,
// particles, weather and the world post pass, before the first-person hand ([`HandDrawn`]),
// the HUD and the screens. `color` holds the world's picture (copy it out before reading it: it is the target
// drawn into), `depth` the world's depth, reversed (0 is the sky).
WorldDrawn :: struct {
    device: ^'a wgpu::Device,
    queue: ^'a wgpu::Queue,
    encoder: ^'a mut wgpu::CommandEncoder,
    // The frame's target and a view of it in `color_format`.
    color: ^'a wgpu::Texture,
    color_view: ^'a wgpu::TextureView,
    color_format: wgpu::TextureFormat,
    // The size of `color`.
    size: [u32,
    // The world's depth (Depth32Float, sampleable), and its size: smaller than `size` when the
    // world draws at a lower resolution. It holds the frame's depth only when a mod asked for
    // it ([`RenderNeeds::world_depth`]) or something else kept it.
    depth: ^'a wgpu::TextureView,
    depth_size: [u32,
    // Camera-relative world to clip space, without TAA's jitter, and with it (what the world
    // was drawn with).
    view_proj: Mat4,
    jittered: Mat4,
    // The camera's position in the world.
    camera: DVec3,
    // The camera-relative entity geometry of the frame (`Frame::entities`), quads of 4
    // vertices, and its runs by entity when a mod asked for them
    // ([`RenderNeeds::entity_spans`]) or a shader pack draws them.
    entities: ^'a [Vertex],
    spans: ^'a [EntitySpan],
    // Which entity each run of `entities` is, recorded every frame (`Frame::entity_motion`):
    // the run's first vertex and the entity, `(1 << 32) | id` for a mob or a player and
    // `(2 << 32) | id` for a dropped item (their entity ids), 0 for anything else. A run lasts
    // until the next. Unlike `spans`, whose ids name a type, these follow one entity from
    // frame to frame (API 371).
    motion: ^'a [(u32,
    // The shared atlas entity UVs point into.
    atlas: Maybe(^'a wgpu::Texture),
    // Quad indices (0 1 2 0 2 3 for each 4 vertices), for as many quads as `entities` holds.
    quad_indices: ^'a wgpu::Buffer,
    // The block textures the terrain samples, for drawing blocks with the player's own
    // textures (`native_block_sprites` says where a block's are). API 380.
    block_sprites: BlockSpriteArrays<'a>,
}

// The block sprite arrays ([`WorldDrawn::block_sprites`]): each texture a whole square layer,
// its UVs 0 to 1 across it, as the world uses them (gamma-encoded, animated layers at the frame
// shown).
BlockSpriteArrays :: struct {
    // The arrays as `D2Array` views, terrain.wgsl's eight (`sprites`, `sprites_1`...): a 1-layer
    // stand-in past the ones in use, each with the mip levels the Mipmap Levels option leaves.
    views: ^'a [wgpu::TextureView],
    // Layers per array on this device (2048 on most; fewer where the GPU holds fewer, and
    // OpenGL pads each array past it): a sprite's `array` and `layer` are cut by it.
    split: u32,
    // A layer's width and height in texels.
    size: u32,
    // Nearest, repeating, the nearest mip level: texels drawn sharp.
    nearest: ^'a wgpu::Sampler,
    // The terrain's own (linear, clamped, anisotropic under that Texture Filtering).
    filtered: ^'a wgpu::Sampler,
}

// What a mod can draw with once the first-person hand is drawn ([`native_hand_drawn`]): after
// the world and the hand, before entity outlines, post effects, screen effects and the HUD.
// `color` holds the frame's picture with the hand in it (copy it out before reading it).
HandDrawn :: struct {
    device: ^'a wgpu::Device,
    queue: ^'a wgpu::Queue,
    encoder: ^'a mut wgpu::CommandEncoder,
    // The frame's target and a view of it in `color_format`.
    color: ^'a wgpu::Texture,
    color_view: ^'a wgpu::TextureView,
    color_format: wgpu::TextureFormat,
    // The size of `color`.
    size: [u32,
    // The hand and held item just drawn, camera-relative quads of 4 vertices: empty when no
    // hand drew (third person, F1, a sleeping or spectating player) or a shader pack drew it.
    hand: ^'a [Vertex],
    // Camera-relative world to clip space for the hand: its own field of view
    // (`hand_fov_degrees`) and the view bob, without TAA's jitter (the hand has none). Its
    // depth is the hand's own: the hand's pass clears depth and keeps none.
    view_proj: Mat4,
    // The camera's position in the world.
    camera: DVec3,
    // The shared atlas the hand's UVs point into.
    atlas: Maybe(^'a wgpu::Texture),
    // Quad indices (0 1 2 0 2 3 for each 4 vertices).
    quad_indices: ^'a wgpu::Buffer,
}

// What the mods need from a frame that the game doesn't make for itself. Each mod sets what it
// needs and leaves the rest, so several can ask.
RenderNeeds :: struct {
    // Record `Frame::entity_spans` without a shader pack: entity runs get a stable id from
    // their type's name, block entity runs their block state.
    entity_spans: bool,
    // Keep the world pass's depth for [`native_world_drawn`] when nothing else does.
    world_depth: bool,
}

// The world is drawn (see [`WorldDrawn`]). Not called on the title screen's panorama.
native_world_drawn :: proc(world: ^WorldDrawn<'_>) {
}
    // rust: generated::dispatch_world_drawn(RENDERERS.get().map_or(&[], |renderers| renderers), world);
}

// The first-person hand is drawn (see [`HandDrawn`]), on every frame [`native_world_drawn`]
// runs, with no hand too. API 364.
native_hand_drawn :: proc(hand: ^HandDrawn<'_>) {
}
    // rust: generated::dispatch_hand_drawn(RENDERERS.get().map_or(&[], |renderers| renderers), hand);
}

// Asked as a frame is built and drawn: set what your mod needs.
native_render_needs :: proc(needs: ^RenderNeeds) {
}
    // rust: generated::dispatch_render_needs(RENDERERS.get().map_or(&[], |renderers| renderers), needs);
}

// What the mods need this frame ([`native_render_needs`]).
render_needs :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut needs = RenderNeeds::default();
    // rust: native_render_needs(&mut needs);
    // rust: needs
}

    // rust: mod tests {
//     use super::*;

Depth :: struct {
    // rust: impl RenderHooks for Depth {
render_needs :: proc(self: ^Self, event: ^RenderNeedsEvent<'_>) {
}
    // rust: event.needs.world_depth = true;
}
}
Spans :: struct {
    // rust: impl RenderHooks for Spans {
render_needs :: proc(self: ^Self, event: ^RenderNeedsEvent<'_>) {
}
    // rust: event.needs.entity_spans = event.needs.world_depth;
}
}

    // A mod samples `BlockSpriteArrays` as the renderer hands them over: a layer of the second
    // array through its view, texels sharp and repeating with the nearest sampler.
a_pass_samples_a_sprite_layer_sharp :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Some((device, queue)) =
    // rust: pollster::block_on(instance.request_adapter(&Default::default()))
    // rust: .ok()
    // rust: .and_then(|adapter| {
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
    // rust: })
    // rust: else {
    // rust: return;
}
    // rust: let gl = device.adapter_info().backend == wgpu::Backend::Gl;
        // two arrays of two 2 by 2 layers; array 1's layer 1 red, green / blue, white
    // rust: let layers = super::super::array_layers(2, gl);
    // rust: let quad = [
    // rust: [255, 0, 0, 255],
    // rust: [0, 255, 0, 255],
    // rust: [0, 0, 255, 255],
    // rust: [255; 4],
    // rust: ];
    // rust: let textures: Vec<wgpu::Texture> = (0..2)
    // rust: .map(|array| {
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 2,
    // rust: height: 2,
    // rust: depth_or_array_layers: layers,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: let mut texels = vec![0u8; 16 * layers as usize];
    // rust: if array == 1 {
    // rust: texels[16..32].copy_from_slice(quad.as_flattened());
}
    // rust: queue.write_texture(
    // rust: texture.as_image_copy(),
    // rust: &texels,
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(8),
    // rust: rows_per_image: Some(2),
    // rust: },
    // rust: texture.size(),
    // rust: );
    // rust: texture
    // rust: })
    // rust: .collect();
    // rust: let unused = textures[0].create_view(&wgpu::TextureViewDescriptor {
    // rust: dimension: Some(wgpu::TextureViewDimension::D2Array),
    // rust: ..Default::default()
    // rust: });
    // rust: let views = super::super::sprite_views(&textures, &unused, Some(1));
    // rust: let nearest = device.create_sampler(&super::super::SPRITE_NEAREST);
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: None,
    // rust: source: wgpu::ShaderSource::Wgsl(
    // rust: "@group(0) @binding(0) var sprites: texture_2d_array<f32>;
    // rust: @group(0) @binding(1) var sprites_1: texture_2d_array<f32>;
    // rust: @group(0) @binding(2) var nearest: sampler;
    // rust: @vertex fn vs(@builtin(vertex_index) i: u32) -> @builtin(position) vec4<f32> {
    // rust: return vec4(f32(i & 1u) * 4.0 - 1.0, f32(i >> 1u) * 4.0 - 1.0, 0.0, 1.0);
}
    // rust: @fragment fn fs(@builtin(position) at: vec4<f32>) -> @location(0) vec4<f32> {
                     // inside each texel, and past the edge (repeating); the last reads array 0
    // rust: let uv = array(vec2(1.3, 0.2), vec2(0.7, 0.45), vec2(-0.8, 0.9), vec2(0.6, 0.6));
    // rust: let x = u32(at.x);
    // rust: if x == 4u {
    // rust: return textureSampleLevel(sprites, nearest, vec2(0.3), 1, 0.0);
}
    // rust: return textureSampleLevel(sprites_1, nearest, uv[x], 1, 0.0);
    // rust: }"
    // rust: .into(),
    // rust: ),
    // rust: });
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: None,
    // rust: layout: None,
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some("fs"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::TextureFormat::Rgba8Unorm.into())],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout: &pipeline.get_bind_group_layout(0),
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(&views[0]),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(&views[1]),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&nearest),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let target = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 5,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let out = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT),
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let view = target.create_view(&Default::default());
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&pipeline);
    // rust: pass.set_bind_group(0, &group, &[]);
    // rust: pass.draw(0..3, 0..1);
}
    // rust: encoder.copy_texture_to_buffer(
    // rust: target.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &out,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: target.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: out.slice(..).map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let texels = out.slice(..).get_mapped_range().unwrap()[..20].to_vec();
    // rust: let mut expected = quad.as_flattened().to_vec();
    // rust: expected.extend([0, 0, 0, 0]);
    // rust: assert_eq!(texels, expected);
}

needs_accumulate_in_mod_order :: proc() {
}
    // rust: let mut needs = RenderNeeds::default();
    // rust: generated::dispatch_render_needs(&[&Depth, &Spans], &mut needs);
    // rust: assert_eq!(
    // rust: needs,
    // rust: RenderNeeds {
    // rust: world_depth: true,
    // rust: entity_spans: true
}
    // rust: );
}
}
