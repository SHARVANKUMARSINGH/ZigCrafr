//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_visbuffer
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A visibility buffer for solid terrain, opt-in with `HORIZON_VISBUFFER=1` (read once, at
//! startup): pass 1 rasterises the solid flat draws (near sections and far tiles, phase 1 and,
//! with occlusion culling, phase 2) writing only depth and the ID of the quad each pixel shows
//! (`visbuffer.wgsl`'s `vis_id`: arena page and quad); cutout and fading
//! quads keep their alpha test and dither there, the rest never discard. Pass 2 is one
//! full-screen draw with up to `PAGE_SLOTS` arena pages bound at once (more pages, more draws)
//! that reads the quad back from its page and its section's origin (through a copy of every
//! drawn page's block table in one buffer), and runs terrain.wgsl's
//! vertex work and solid shading once per pixel with analytic screen gradients. Every solid
//! pixel is shaded once, however many quads were drawn over it and however small they are.
//! A draw per page instead made each GPU thread group run the shading once for every page
//! among its pixels, with most lanes idle: the pages' sections lie all over the screen.
//!
//! It runs only in frames drawn flat (`flat`: Metal past `flat::MIN_SECTIONS`, or
//! `HORIZON_FLAT_DRAWS=1`) and falls back to the normal solid passes in frames with a shader
//! pack drawing terrain, one of Horizon's own packs with a material stage or a shadow pass, a
//! pack's surface target, and on the title screen. The water mirror's own pass stays as it is.
// use super::arena::Arena;
// use super::flat::Flat;
// use super::pack_timing::PassTiming;

/// Arena pages one resolve draw reads (`visbuffer.wgsl`'s `vis_page_0`...).
pub const PAGE_SLOTS: u32 = 16;
/// Arena pages an ID names (`visbuffer.wgsl`'s `vis_id`): frames with more draw without it.
pub const MAX_PAGES: u32 = 64;
/// The resolve binds that many pages, the block tables and the origins by section id.
pub const STORAGE_BUFFERS: u32 = PAGE_SLOTS + 2;
pub const IDS: wgpu::TextureFormat = wgpu::TextureFormat::R32Uint;

/// Whether the visibility buffer is asked for, and the device binds storage buffers enough.
pub fn wanted(device: *wgpu::Device) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::var("HORIZON_VISBUFFER").as_deref() == Ok("1")
    // rust: && device.limits().max_storage_buffers_per_shader_stage >= STORAGE_BUFFERS
}

pub const Visbuffer = struct {
    /// Pass 1 over the quads `fs_opaque` draws (no discard) and the rest.
    opaque: wgpu::RenderPipeline,
    cutout: wgpu::RenderPipeline,
    resolve: wgpu::RenderPipeline,
    /// Pass 2's group 1: the block tables (binding 0), the origins by section id (1),
    /// `PAGE_SLOTS` pages' vertices (from 2), the IDs (after them).
    page_layout: wgpu::BindGroupLayout,
    /// Every page's block table, page after page (`Flat::blocks_per_page` entries each),
    /// copied each frame from the drawn pages' own, and its size in pages.
    blocks: Option<(wgpu::Buffer,
    blocks_per_page: u64,
    /// The IDs, the size of the world's depth.
    ids: Option<(wgpu::TextureView,
};

    // rust: impl Visbuffer {
    /// `terrain_layout`: terrain.wgsl's group 0; `flat_layout`: the flat draws' group 1;
    /// `color`: the world pass's colour format; `constants`: the sprite arrays' pipeline
    /// constants.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: terrain_layout: &wgpu::BindGroupLayout,
    // rust: flat: &Flat,
    // rust: color: wgpu::TextureFormat,
    // rust: constants: &[(&str, f64)],
    // rust: ) -> Self {
    // rust: let flat_layout = &flat.draw_layout;
    // rust: let blocks_per_page = flat.blocks_per_page();
    // rust: let resolve_constants: Vec<(&str, f64)> = constants
    // rust: .iter()
    // rust: .copied()
    // rust: .chain([("VIS_BLOCKS_PER_PAGE", blocks_per_page as f64)])
    // rust: .collect();
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon visibility buffer"),
    // rust: source: wgpu::ShaderSource::Wgsl(
    // rust: (include_str!("../terrain.wgsl").to_owned() + include_str!("../visbuffer.wgsl"))
    // rust: .into(),
    // rust: ),
    // rust: });
    // rust: let fragment = wgpu::ShaderStages::FRAGMENT;
    // rust: let storage = |binding| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: fragment,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Storage { read_only: true },
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
}
    // rust: let entries: Vec<_> = (0..2 + PAGE_SLOTS)
    // rust: .map(storage)
    // rust: .chain([wgpu::BindGroupLayoutEntry {
    // rust: binding: 2 + PAGE_SLOTS,
    // rust: visibility: fragment,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Uint,
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: }])
    // rust: .collect();
    // rust: let page_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Visibility buffer pages"),
    // rust: entries: &entries,
    // rust: });
    // rust: let id_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Visibility buffer IDs"),
    // rust: bind_group_layouts: &[Some(terrain_layout), Some(flat_layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let resolve_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Visibility buffer resolve"),
    // rust: bind_group_layouts: &[Some(terrain_layout), Some(&page_layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let ids = |label: &'static str, vertex: &'static str, fragment: &'static str| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(label),
    // rust: layout: Some(&id_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: Some(vertex),
    // rust: compilation_options: Default::default(),
                    // `section_corner` reads the arena page (`flat::ARENA_BINDING`).
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: topology: wgpu::PrimitiveTopology::TriangleList,
    // rust: cull_mode: Some(wgpu::Face::Back),
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(true),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: Some(fragment),
    // rust: compilation_options: wgpu::PipelineCompilationOptions {
    // rust: constants,
    // rust: ..Default::default()
    // rust: },
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: IDS,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let opaque = ids("Visibility buffer opaque", "vs_vis_opaque", "fs_vis_id");
    // rust: let cutout = ids("Visibility buffer cutout", "vs_vis_cutout", "fs_vis_cutout");
    // rust: let resolve = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Visibility buffer resolve"),
    // rust: layout: Some(&resolve_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: Some("vs_vis_resolve"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: Some("fs_vis_resolve"),
    // rust: compilation_options: wgpu::PipelineCompilationOptions {
    // rust: constants: &resolve_constants,
    // rust: ..Default::default()
    // rust: },
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: color,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: Self {
    // rust: opaque,
    // rust: cutout,
    // rust: resolve,
    // rust: page_layout,
    // rust: blocks: None,
    // rust: blocks_per_page,
    // rust: ids: None,
}
}

    /// Makes the IDs the world depth's `size`, and the block tables hold the pages `flat`
    /// draws this frame.
pub fn fit(self: *Self, device: *wgpu::Device, size: [u32; 2], flat: *Flat) void {
}
    // rust: let pages = flat.calls[..flat.solid_calls]
    // rust: .iter()
    // rust: .map(|c| c.page + 1)
    // rust: .max()
    // rust: .unwrap_or(1);
    // rust: if self.blocks.as_ref().is_none_or(|(_, n)| *n < pages) {
    // rust: let pages = pages.next_power_of_two();
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Visibility buffer block tables"),
    // rust: size: u64::from(pages) * self.blocks_per_page * 4,
    // rust: usage: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: self.blocks = Some((buffer, pages));
}
    // rust: if self.ids.as_ref().is_some_and(|(_, s)| *s == size) {
    // rust: return;
}
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Visibility buffer IDs"),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0].max(1),
    // rust: height: size[1].max(1),
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: IDS,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: });
    // rust: self.ids = Some((texture.create_view(&Default::default()), size));
}

    /// Pass 1's render pass over the world's `depth`: the IDs cleared (`clear`, phase 1) or
    /// kept (phase 2 of occlusion culling).
    // rust: pub fn id_pass<'e>(
    // rust: &self,
    // rust: encoder: &'e mut wgpu::CommandEncoder,
    // rust: depth: &wgpu::TextureView,
    // rust: clear: bool,
    // rust: timing: Option<&mut PassTiming>,
    // rust: ) -> wgpu::RenderPass<'e> {
    // rust: let (ids, _) = self.ids.as_ref().expect("fitted before the world pass");
    // rust: let name = if clear {
    // rust: "Visibility IDs"
    // rust: } else {
    // rust: "Visibility IDs after culling"
}
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Horizon visibility buffer"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes(name)),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: ids,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: if clear {
    // rust: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT)
    // rust: } else {
    // rust: wgpu::LoadOp::Load
    // rust: },
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
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

    /// Phase 1's solid calls into the IDs, as the normal passes draw them: the opaque
    /// pipeline over `calls[..pass_calls[0]]`, the cutout one over
    /// `calls[pass_calls[1]..phase1_calls]` (each leaves out the other's quads).
    // rust: pub fn draw_ids<'a>(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: flat: &Flat,
    // rust: vertices: impl Fn(u32) -> wgpu::BufferSlice<'a> + Copy,
    // rust: ) {
    // rust: let [opaque, cutout, _] = flat.pass_calls;
    // rust: pass.set_pipeline(&self.opaque);
    // rust: flat.draw_paged(pass, &flat.calls[..opaque], vertices);
    // rust: pass.set_pipeline(&self.cutout);
    // rust: flat.draw_paged(pass, &flat.calls[cutout..flat.phase1_calls], vertices);
}

    /// Phase 2's calls as `Flat::flatten_phase2` left them (their first instance is their
    /// page: `Flat::page_instances`), through both pipelines.
    // rust: pub fn draw_ids_phase2<'a>(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: flat: &Flat,
    // rust: vertices: impl Fn(u32) -> wgpu::BufferSlice<'a> + Copy,
    // rust: ) {
        // Phase 2 lists each section's opaque runs first, its cutout runs after.
    // rust: let split = flat.pass_calls[2] - flat.phase1_calls;
    // rust: let total = flat.solid_calls - flat.phase1_calls;
    // rust: pass.set_pipeline(&self.opaque);
    // rust: flat.draw_phase2(pass, 0..split, vertices);
    // rust: pass.set_pipeline(&self.cutout);
    // rust: flat.draw_phase2(pass, split..total, vertices);
}

    /// Bytes of its block tables and IDs.
pub fn bytes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let blocks = self.blocks.as_ref().map_or(0, |(b, _)| b.size());
    // rust: let ids = self
    // rust: .ids
    // rust: .as_ref()
    // rust: .map_or(0, |(_, [w, h])| u64::from(*w) * u64::from(*h) * 4);
    // rust: blocks + ids
}

    /// Pass 2: shades the solid terrain the IDs show into `target`, the world's colour,
    /// over the sky drawn before. `terrain`: terrain.wgsl's group 0.
    // rust: pub fn resolve(
    // rust: &self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: target: &wgpu::TextureView,
    // rust: terrain: &wgpu::BindGroup,
    // rust: flat: &Flat,
    // rust: arena: &Arena,
    // rust: timing: Option<&mut PassTiming>,
    // rust: ) {
    // rust: let (Some((ids, _)), Some((blocks, _))) = (&self.ids, &self.blocks) else {
    // rust: return;
}
    // rust: let mut pages: Vec<u32> = flat.calls[..flat.solid_calls]
    // rust: .iter()
    // rust: .map(|c| c.page)
    // rust: .collect();
    // rust: pages.sort_unstable();
    // rust: pages.dedup();
    // rust: let Some(&any) = pages.first() else {
    // rust: return;
}
    // rust: let table = self.blocks_per_page * 4;
    // rust: for &page in &pages {
    // rust: if let Some(from) = flat.block_table(page) {
    // rust: encoder.copy_buffer_to_buffer(from, 0, blocks, u64::from(page) * table, table);
}
}
        // Pages in groups of `PAGE_SLOTS` by number: a page's slot is its number's remainder.
        // Slots no drawn page fills take one that is, which no pixel's ID names.
    // rust: let mut chunks: Vec<u32> = pages.iter().map(|p| p / PAGE_SLOTS).collect();
    // rust: chunks.dedup();
    // rust: let groups: Vec<(u32, wgpu::BindGroup)> = chunks
    // rust: .into_iter()
    // rust: .map(|chunk| {
    // rust: let mut entries = vec![
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: blocks.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: flat.origins().as_entire_binding(),
    // rust: },
    // rust: ];
    // rust: entries.extend((0..PAGE_SLOTS).map(|slot| {
    // rust: let page = chunk * PAGE_SLOTS + slot;
    // rust: let page = if pages.binary_search(&page).is_ok() {
    // rust: page
    // rust: } else {
    // rust: any
}
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2 + slot,
    // rust: resource: arena.buffer(page).as_entire_binding(),
}
    // rust: }));
    // rust: entries.push(wgpu::BindGroupEntry {
    // rust: binding: 2 + PAGE_SLOTS,
    // rust: resource: wgpu::BindingResource::TextureView(ids),
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Visibility buffer pages"),
    // rust: layout: &self.page_layout,
    // rust: entries: &entries,
    // rust: });
    // rust: (chunk, group)
    // rust: })
    // rust: .collect();
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Horizon visibility buffer resolve"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("Visibility resolve")),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: target,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: None,
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&self.resolve);
    // rust: pass.set_bind_group(0, terrain, &[]);
        // The group of pages goes as the instance: each draw shades the pixels whose quad is
        // in one of its pages (one draw, up to `PAGE_SLOTS` pages).
    // rust: for (chunk, group) in &groups {
    // rust: pass.set_bind_group(1, group, &[]);
    // rust: pass.draw(0..3, *chunk..*chunk + 1);
}
}
}
