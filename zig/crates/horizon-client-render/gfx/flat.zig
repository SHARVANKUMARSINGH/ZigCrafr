//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_flat
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Flat section draws: where indirect multi-draw is emulated, as on Metal
//! (wgpu replays it as one draw call per indirect entry), the frame's section
//! draws are copied by a compute pass into one index list, in draw order, and
//! drawn with one draw call per run of sections in the same arena page.
//!
//! The picture is the one the per-section draws give: the same triangles
//! from the same vertices in the same order, through the same vertex and
//! fragment code. Only where a vertex finds its section's origin changes:
//! from the instance attribute to a table. A section's vertices fill whole
//! blocks of `GRAIN` vertices of its page (the arena rounds every range up),
//! so each block names one section: its id here, which indexes the frame's
//! camera-relative origins (computed on the CPU exactly as for the instance
//! attribute).
//!
//! With occlusion culling (`cull`), phase 1's draws and the translucent ones
//! are copied before the world pass, as without it. Phase 2's draws are
//! copied after the test, which tells which ones it saw: each run of a page
//! reserves room for all of its draws, the copy packs the seen ones at its
//! start, and the run is drawn indirectly with the count the copy reached.
// use super::arena::GRAIN;

/// One section draw for `flatten.wgsl`: index count, first sorted index (or
/// `QUADS` for a solid draw; phase 2: its entry in phase 2's draws), base
/// vertex, first index in the list (phase 2: its draw call in phase 2).
    // rust: type Range = [u32; 4];

/// Where a group of ranges takes its indices.
pub const Source = enum {
    /// Solid draws: quads.
    Quads,
    /// Occlusion culling's phase 2: quads, of the sections its test saw.
    Seen,
    /// Translucent draws: this sorted index page.
    Sorted(u32),
};

/// The frame's draw calls, as `plan` lays them out.
pub const Plan = struct {
    phase1_calls: usize,
    solid_calls: usize,
    /// Where the shadow camera's solid and translucent calls begin.
    shadow_calls: [usize,
    /// Where Metal's opaque pass ends and its cutout pass begins in phase 1's calls,
    /// and where its cutout pass begins in phase 2's.
    pass_calls: [usize,
    total: u64,
};
pub const QUADS: u32 = u32::MAX;
pub const GROUP_LIMIT: u32 = 65535;
/// The page keys of the translucent arena (`Renderer::translucent_arena`, Translucent
/// Batching): its page plus this. The section arena's pages are their own keys, all far
/// below it. A call names its key: its vertices come from that arena's page.
pub const TRANSLUCENT_KEYS: u32 = 1 << 10;

/// terrain.wgsl's `arena_page`: the page the solid draws read their vertices from.
pub const ARENA_BINDING: u32 = 19;

pub const PageTable = struct {
    /// Section id of every block of the page.
    blocks: wgpu::Buffer,
    group: ?wgpu::BindGroup,
    /// The section arena's page `group` binds at `ARENA_BINDING` (`bind_pages`).
    arena: ?wgpu::Buffer,
};

/// Writes the fragment's alpha over the frame's and leaves its colour.
    // rust: pub(super) const ALPHA_ONLY: wgpu::BlendState = wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::Zero,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: alpha: wgpu::BlendComponent::REPLACE,
}
/// A run of the frame's index list drawn from one arena page.
pub const Call = struct {
    /// The page's key (`TRANSLUCENT_KEYS`).
    page: u32,
    first: u32,
    count: u32,
};

pub const Flat = struct {
    /// The solid draws in one pass (`fs_solid`), where the GPU doesn't hide pixels
    /// by tiles (`split_solid` in `Renderer::draw_frame`: elsewhere than Metal).
    solid: wgpu::RenderPipeline,
    /// The solid draws in two passes, each over its own part of the draws (terrain.wgsl's
    /// `opaque_quad`): the quads with no cutout first, through a shader that never discards,
    /// then the rest.
    solid_opaque: wgpu::RenderPipeline,
    solid_cutout: wgpu::RenderPipeline,
    /// The solid draws as the water mirror's camera draws them (`fs_solid_mirror`).
    solid_mirror: wgpu::RenderPipeline,
    translucent: wgpu::RenderPipeline,
    translucent_mark: wgpu::RenderPipeline,
    flatten: wgpu::ComputePipeline,
    compute_layout: wgpu::BindGroupLayout,
    flatten_seen: wgpu::ComputePipeline,
    seen_layout: wgpu::BindGroupLayout,
    /// Phase 2's draw calls (`DrawIndexedIndirectArgs`), whose index counts
    /// `flatten_seen` makes.
    phase2_calls: wgpu::Buffer,
    phase2_call_capacity: u64,
    phase2_call_data: Vec<[u32,
    /// The copy of phase 2's draws, and its ranges.
    phase2_group: Option<(wgpu::BindGroup,
    /// The layout of a page's bind group 1 (shader packs' terrain pipelines share it).
    // rust: pub(super) draw_layout: wgpu::BindGroupLayout,
    blocks_per_page: u64,
    /// Blocks of a translucent arena page (`TRANSLUCENT_KEYS`), whose pages are larger.
    translucent_blocks_per_page: u64,
    /// Block tables by page key.
    pages: std.ArrayList(?PageTable),
    free_ids: std.ArrayList(u32),
    next_id: u32,
    origins: wgpu::Buffer,
    origin_capacity: u64,
    origin_data: Vec<[f32,
    /// The frame's index list.
    indices: wgpu::Buffer,
    index_capacity: u64,
    ranges: wgpu::Buffer,
    range_capacity: u64,
    range_data: std.ArrayList(Range),
    /// Segments of `range_data` by index source: (source, first range,
    /// ranges).
    segments: Vec<(Source,
    empty: wgpu::Buffer,
    /// This frame's draw calls: solid ones (phase 1's, then phase 2's when
    /// culling), then translucent ones.
    calls: std.ArrayList(Call),
    phase1_calls: usize,
    solid_calls: usize,
    /// Metal's two solid passes over phase 1: the opaque one draws
    /// `calls[..pass_calls[0]]`, the cutout one `calls[pass_calls[1]..phase1_calls]`;
    /// over phase 2, `calls[phase1_calls..pass_calls[2]]` and the rest.
    pass_calls: [usize,
    /// Where a shader pack's shadow camera's solid and translucent calls
    /// begin (`calls.len()` without them): the camera's translucent calls
    /// end at the first.
    shadow_calls: [usize,
    /// Frames with fewer sections in view keep the per-section draws.
    min_sections: usize,
    range_align: u64,
    /// Phase 2's calls draw their page key as their first instance, as `draw_paged` does:
    /// the visibility buffer's ID pass (`visbuffer`) reads it. The other flat pipelines
    /// have no instance-rate inputs.
    page_instances: bool,
};

/// Sections in view (and distant tiles) from which a frame is drawn flat.
/// Below it the index list costs the GPU more than the draw calls cost the
/// CPU: on an M4 Pro at render distance 16 (2,900 draws) the copy and the
/// list add about 0.4 ms of GPU time for 0.5–0.8 ms less CPU time; at 32
/// (9,300 draws) the CPU saves 1.3 ms. The bar was 4,096 draws when they
/// were 2.2 to 2.5 per section; a section's draw count now depends on the
/// sides it shows the eye (`mesher::Sides`), so it counts sections.
pub const MIN_SECTIONS: usize = 1600;

/// Whether flat draws exist: vertex shaders can read storage buffers large
/// enough for an index page. A shader pack's terrain draws flat wherever they
/// do, since only there does it read each quad's face normal and `mc_Entity`;
/// frames without one draw flat only where `for_vanilla` says.
/// `HORIZON_FLAT_DRAWS=1` draws every frame flat, `0` none.
pub fn wanted(adapter: *wgpu::Adapter, device: *wgpu::Device) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::var("HORIZON_FLAT_DRAWS").as_deref() != Ok("0") && supported(adapter, device)
}

/// Whether frames without a shader pack's terrain draw flat: where the backend
/// emulates multi-draw (Metal, past `MIN_SECTIONS`), on Intel Gen11/Gen12's Vulkan
/// driver, or with `HORIZON_FLAT_DRAWS=1`. Elsewhere per-section draws stay.
pub fn for_vanilla(info: *wgpu::AdapterInfo) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::var("HORIZON_FLAT_DRAWS").as_deref() == Ok("1")
    // rust: || info.backend == wgpu::Backend::Metal
    // rust: || is_broken_intel_vulkan(info)
}

/// Intel Gen11 (Ice Lake) and Gen12 (Tiger Lake, Rocket Lake, Alder Lake,
/// Raptor Lake) ANV Vulkan drivers have broken `first_instance` for
/// instance-step vertex attributes (#3529, #4599), causing terrain sections to
/// be drawn with another section's origin and flicker.
pub fn is_broken_intel_vulkan(info: *wgpu::AdapterInfo) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: info.backend == wgpu::Backend::Vulkan
    // rust: && info.vendor == 0x8086
    // rust: && (matches!(
    // rust: info.device,
    // rust: 0x8a50..=0x8a71 // Gen11: Ice Lake
    // rust: | 0x9a40..=0x9a7f // Gen12: Tiger Lake
    // rust: | 0x4c80..=0x4c9a // Gen12: Rocket Lake
    // rust: | 0x4600..=0x46ff // Gen12: Alder Lake (incl. 0x46a8 in #4599)
    // rust: | 0xa700..=0xa7ff // Gen12: Raptor Lake
    // rust: ) || [
    // rust: "ICL",
    // rust: "Ice Lake",
    // rust: "TGL",
    // rust: "Tiger Lake",
    // rust: "RKL",
    // rust: "Rocket Lake",
    // rust: "ADL",
    // rust: "Alder Lake",
    // rust: "RPL",
    // rust: "Raptor Lake",
    // rust: ]
    // rust: .iter()
    // rust: .any(|tag| info.name.contains(tag)))
}

pub fn supported(adapter: *wgpu::Adapter, device: *wgpu::Device) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let flags = adapter.get_downlevel_capabilities().flags;
    // rust: let limits = device.limits();
    // rust: flags.contains(wgpu::DownlevelFlags::VERTEX_STORAGE | wgpu::DownlevelFlags::COMPUTE_SHADERS)
    // rust: && limits.max_storage_buffers_per_shader_stage >= 3
    // rust: && limits.max_storage_buffer_binding_size >= super::arena::PAGE_BYTES
}

pub fn storage(binding: u32, stage: wgpu::ShaderStages, read_only: bool) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: stage,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Storage { read_only },
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
}
}

    // rust: fn buffer(
    // rust: device: &wgpu::Device,
    // rust: label: &str,
    // rust: size: u64,
    // rust: usage: wgpu::BufferUsages,
    // rust: ) -> wgpu::Buffer {
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(label),
    // rust: size: size.max(16),
        // Tests read the tables back.
    // rust: usage: usage
    // rust: | wgpu::BufferUsages::COPY_DST
    // rust: | if cfg!(test) {
    // rust: wgpu::BufferUsages::COPY_SRC
    // rust: } else {
    // rust: wgpu::BufferUsages::empty()
    // rust: },
    // rust: mapped_at_creation: false,
    // rust: })
}

/// Lays out the frame's index list: each draw's range (destinations in draw
/// order) grouped by index source into `ranges`, every group padded to
/// `align` entries for binding, with `segments` naming each group; and the
/// draw calls, one per run of draws in the same vertex page, phase 1's solid
/// ones, phase 2's (draws `phase1_draws..solid_draws`) and translucent ones
/// apart. A phase 2 range names its draw in phase 2 and its call in phase 2
/// instead of a destination: the call's room holds all of its draws. Draws
/// from `shadow[0]` (solid) and `shadow[1]` (translucent) on are a shader
/// pack's shadow camera's, with calls of their own. Phase 1's draws before
/// `passes[0]` and from `passes[1]` on, the two solid passes' on Metal, too,
/// and phase 2's from `passes[2]` on (its cutout pass's).
    // rust: fn plan(
    // rust: draws: &[[u32; 5]],
    // rust: pages: &[(u32, Option<u32>)],
    // rust: phase1_draws: usize,
    // rust: solid_draws: usize,
    // rust: shadow: [usize; 2],
    // rust: passes: [usize; 3],
    // rust: align: u64,
    // rust: key: impl Fn(u32, Option<u32>) -> u32,
    // rust: calls: &mut Vec<Call>,
    // rust: ranges: &mut Vec<Range>,
    // rust: segments: &mut Vec<(Source, u64, u64)>,
    // rust: ) -> Plan {
    // rust: calls.clear();
    // rust: ranges.clear();
    // rust: segments.clear();
    // rust: let (mut phase1_calls, mut solid_calls) = (None, None);
    // rust: let mut shadow_calls = [None; 2];
    // rust: let mut pass_calls = [None; 3];
    // rust: let mut total = 0u64;
    // rust: let mut by_source: Vec<(Source, Vec<Range>)> = Vec::new();
    // rust: for (i, (d, &(page, sorted))) in draws.iter().zip(pages).enumerate() {
    // rust: if i == phase1_draws {
    // rust: phase1_calls.get_or_insert(calls.len());
}
    // rust: if i == solid_draws {
    // rust: solid_calls = Some(calls.len());
}
    // rust: for (k, &from) in shadow.iter().enumerate() {
    // rust: if i == from {
    // rust: shadow_calls[k].get_or_insert(calls.len());
}
}
    // rust: for (k, &from) in passes.iter().enumerate() {
    // rust: if i == from {
    // rust: pass_calls[k].get_or_insert(calls.len());
}
}
    // rust: let starts =
    // rust: i == phase1_draws || i == solid_draws || shadow.contains(&i) || passes.contains(&i);
    // rust: let page = key(page, sorted);
    // rust: match calls.last_mut() {
    // rust: Some(last) if last.page == page && !starts => last.count += d[0],
    // rust: _ => calls.push(Call {
    // rust: page,
    // rust: first: total as u32,
    // rust: count: d[0],
    // rust: }),
}
    // rust: let (source, range) = match sorted {
    // rust: Some(p) => (Source::Sorted(p), [d[0], d[2], d[3], total as u32]),
    // rust: None if (phase1_draws..solid_draws).contains(&i) => (
    // rust: Source::Seen,
    // rust: [
    // rust: d[0],
    // rust: (i - phase1_draws) as u32,
    // rust: d[3],
    // rust: (calls.len() - 1 - phase1_calls.unwrap_or(0)) as u32,
    // rust: ],
    // rust: ),
    // rust: None => (Source::Quads, [d[0], QUADS, d[3], total as u32]),
}
    // rust: match by_source.iter_mut().find(|(s, _)| *s == source) {
    // rust: Some((_, list)) => list.push(range),
    // rust: None => by_source.push((source, vec![range])),
}
    // rust: total += u64::from(d[0]);
}
    // rust: for (source, list) in by_source {
    // rust: segments.push((source, ranges.len() as u64, list.len() as u64));
    // rust: ranges.extend(list);
    // rust: let padded = (ranges.len() as u64).next_multiple_of(align);
    // rust: ranges.resize(padded as usize, [0; 4]);
}
    // rust: let solid_calls = solid_calls.unwrap_or(calls.len());
    // rust: let phase1_calls = phase1_calls.unwrap_or(calls.len()).min(solid_calls);
    // rust: Plan {
    // rust: phase1_calls,
    // rust: solid_calls,
    // rust: shadow_calls: shadow_calls.map(|c| c.unwrap_or(calls.len())),
    // rust: pass_calls: {
    // rust: let [opaque, cutout, phase2] = pass_calls.map(|c| c.unwrap_or(calls.len()));
    // rust: [
    // rust: opaque.min(phase1_calls),
    // rust: cutout.min(phase1_calls),
    // rust: phase2.clamp(phase1_calls, solid_calls),
    // rust: ]
    // rust: },
    // rust: total,
}
}

    // rust: impl Flat {
    /// `pipeline(layout, label, vertex entry, fragment entry, blend, cull, pulled)` builds a
    /// terrain pipeline as the per-section ones, without the origin buffer, and without
    /// vertex buffers when `pulled` (its vertex shader reads the page, `ARENA_BINDING`).
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: terrain_layout: &wgpu::BindGroupLayout,
    // rust: page_vertices: u64,
    // rust: min_sections: usize,
    // rust: pipeline: impl Fn(
    // rust: &wgpu::PipelineLayout,
    // rust: &str,
    // rust: &str,
    // rust: &str,
    // rust: Option<wgpu::BlendState>,
    // rust: Option<wgpu::Face>,
    // rust: bool,
    // rust: ) -> wgpu::RenderPipeline,
    // rust: ) -> Self {
    // rust: let vertex = wgpu::ShaderStages::VERTEX;
    // rust: let compute = wgpu::ShaderStages::COMPUTE;
    // rust: let draw_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Flat section draws"),
    // rust: entries: &[
    // rust: storage(0, vertex, true),
    // rust: storage(1, vertex, true),
    // rust: storage(ARENA_BINDING, vertex, true),
    // rust: ],
    // rust: });
    // rust: let layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Flat terrain layout"),
    // rust: bind_group_layouts: &[Some(terrain_layout), Some(&draw_layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let compute_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Flatten section draws"),
    // rust: entries: &[
    // rust: storage(0, compute, true),
    // rust: storage(1, compute, true),
    // rust: storage(2, compute, false),
    // rust: ],
    // rust: });
    // rust: let seen_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Flatten phase 2 section draws"),
    // rust: entries: &[
    // rust: storage(0, compute, true),
    // rust: storage(2, compute, false),
    // rust: storage(3, compute, true),
    // rust: storage(4, compute, false),
    // rust: ],
    // rust: });
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Flatten section draws"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("flatten.wgsl").into()),
    // rust: });
    // rust: let compute_pipeline = |layout: &wgpu::BindGroupLayout, entry| {
    // rust: device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    // rust: label: Some("Flatten section draws"),
    // rust: layout: Some(
    // rust: &device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Flatten section draws"),
    // rust: bind_group_layouts: &[Some(layout)],
    // rust: ..Default::default()
    // rust: }),
    // rust: ),
    // rust: module: &module,
    // rust: entry_point: Some(entry),
    // rust: compilation_options: Default::default(),
    // rust: cache: None,
    // rust: })
}
    // rust: let flatten = compute_pipeline(&compute_layout, "flatten");
    // rust: let flatten_seen = compute_pipeline(&seen_layout, "flatten_seen");
    // rust: let storage_usage = wgpu::BufferUsages::STORAGE;
    // rust: let back = Some(wgpu::Face::Back);
    // rust: Self {
            // The solid draws read either layout of the solid quads (`mesher::packed`) from
            // the page; translucent ones keep their vertex buffer.
    // rust: solid: pipeline(
    // rust: &layout,
    // rust: "Terrain solid (flat)",
    // rust: "vs_section_flat",
    // rust: "fs_solid",
    // rust: None,
    // rust: back,
    // rust: true,
    // rust: ),
    // rust: solid_opaque: pipeline(
    // rust: &layout,
    // rust: "Terrain solid opaque (flat)",
    // rust: "vs_section_flat_opaque",
    // rust: "fs_opaque",
    // rust: None,
    // rust: back,
    // rust: true,
    // rust: ),
    // rust: solid_cutout: pipeline(
    // rust: &layout,
    // rust: "Terrain solid cutout (flat)",
    // rust: "vs_section_flat_cutout",
    // rust: "fs_solid",
    // rust: None,
    // rust: back,
    // rust: true,
    // rust: ),
            // The mirror flips the winding: its solid terrain culls the front.
    // rust: solid_mirror: pipeline(
    // rust: &layout,
    // rust: "Terrain solid mirrored (flat)",
    // rust: "vs_section_flat",
    // rust: "fs_solid_mirror",
    // rust: None,
    // rust: Some(wgpu::Face::Front),
    // rust: true,
    // rust: ),
    // rust: translucent: pipeline(
    // rust: &layout,
    // rust: "Terrain translucent (flat)",
    // rust: "vs_terrain_flat",
    // rust: "fs_translucent",
    // rust: Some(wgpu::BlendState::ALPHA_BLENDING),
    // rust: back,
    // rust: false,
    // rust: ),
    // rust: translucent_mark: pipeline(
    // rust: &layout,
    // rust: "Terrain translucent HDR mark (flat)",
    // rust: "vs_terrain_flat",
    // rust: "fs_translucent_mark",
    // rust: Some(ALPHA_ONLY),
    // rust: back,
    // rust: false,
    // rust: ),
    // rust: flatten,
    // rust: compute_layout,
    // rust: flatten_seen,
    // rust: seen_layout,
    // rust: phase2_calls: buffer(
    // rust: device,
    // rust: "Flat section draw calls, phase 2",
    // rust: 20,
    // rust: wgpu::BufferUsages::INDIRECT | storage_usage,
    // rust: ),
    // rust: phase2_call_capacity: 1,
    // rust: phase2_call_data: Vec::new(),
    // rust: phase2_group: None,
    // rust: draw_layout,
    // rust: blocks_per_page: page_vertices.div_ceil(GRAIN),
    // rust: translucent_blocks_per_page: page_vertices.div_ceil(GRAIN),
    // rust: pages: Vec::new(),
    // rust: free_ids: Vec::new(),
    // rust: next_id: 0,
    // rust: origins: buffer(device, "Section origins by id", 16, storage_usage),
    // rust: origin_capacity: 1,
    // rust: origin_data: Vec::new(),
    // rust: indices: buffer(
    // rust: device,
    // rust: "Flat section indices",
    // rust: 16,
    // rust: wgpu::BufferUsages::INDEX | storage_usage,
    // rust: ),
    // rust: index_capacity: 4,
    // rust: ranges: buffer(device, "Flat section ranges", 16, storage_usage),
    // rust: range_capacity: 1,
    // rust: range_data: Vec::new(),
    // rust: segments: Vec::new(),
    // rust: empty: buffer(device, "No sorted indices", 16, storage_usage),
    // rust: calls: Vec::new(),
    // rust: phase1_calls: 0,
    // rust: solid_calls: 0,
    // rust: pass_calls: [0; 3],
    // rust: shadow_calls: [0; 2],
    // rust: min_sections,
    // rust: range_align: (u64::from(device.limits().min_storage_buffer_offset_alignment) / 16)
    // rust: .max(1),
    // rust: page_instances: false,
}
}
    /// A section uploaded to `vertices` vertices from `start` of the page keyed `page`:
    /// its id, which its blocks now name (written through `uploads` in `encoder`).
    // rust: pub fn add(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: uploads: &mut super::upload::Uploads,
    // rust: page: u32,
    // rust: start: u64,
    // rust: vertices: u64,
    // rust: ) -> u32 {
    // rust: let id = self.free_ids.pop().unwrap_or_else(|| {
    // rust: self.next_id += 1;
    // rust: self.next_id - 1
    // rust: });
    // rust: self.place(device, encoder, uploads, id, page, start, vertices);
    // rust: id
}
    /// Makes the blocks of `vertices` vertices from `start` of the page keyed `page` name
    /// `id`: a section's other range (its translucent quads, in the translucent arena), or
    /// a range that moved.
    // rust: pub fn place(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: uploads: &mut super::upload::Uploads,
    // rust: id: u32,
    // rust: page: u32,
    // rust: start: u64,
    // rust: vertices: u64,
    // rust: ) {
    // rust: let blocks = if page >= TRANSLUCENT_KEYS {
    // rust: self.translucent_blocks_per_page
    // rust: } else {
    // rust: self.blocks_per_page
}
    // rust: let page = page as usize;
    // rust: if self.pages.len() <= page {
    // rust: self.pages.resize_with(page + 1, || None);
}
    // rust: let table = self.pages[page].get_or_insert_with(|| PageTable {
            // Copied whole into the visibility buffer's table of every page (`visbuffer`).
    // rust: blocks: buffer(
    // rust: device,
    // rust: "Section ids by block",
    // rust: blocks * 4,
    // rust: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::COPY_SRC,
    // rust: ),
    // rust: group: None,
    // rust: arena: None,
    // rust: });
    // rust: let first = start / GRAIN;
    // rust: let ids = vec![id; vertices.div_ceil(GRAIN) as usize];
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: &table.blocks,
    // rust: first * 4,
    // rust: bytemuck::cast_slice(&ids),
    // rust: );
}
    /// The block table of the page keyed `page`, for tests that read it back.
    // rust: pub(super) fn blocks(&self, page: u32) -> &wgpu::Buffer {
    // rust: &self.pages[page as usize]
    // rust: .as_ref()
    // rust: .expect("a page table")
    // rust: .blocks
}
    /// The most vertices a page of the translucent arena holds: its block tables' size.
    /// Tables made before keep theirs, so this goes with `clear`.
pub fn set_translucent_page_vertices(self: *Self, vertices: u64) void {
}
    // rust: self.translucent_blocks_per_page = vertices.div_ceil(GRAIN);
}
pub fn remove(self: *Self, id: u32) void {
}
    // rust: self.free_ids.push(id);
}
pub fn clear(self: *Self) void {
}
    // rust: self.pages.clear();
    // rust: self.free_ids.clear();
    // rust: self.next_id = 0;
}
    /// Forgets the tables of pages the arenas released (`live`, by page key).
pub fn trim(self: *Self, live: impl Fn(u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for (i, page) in self.pages.iter_mut().enumerate() {
    // rust: if page.is_some() && !live(i as u32) {
    // rust: *page = None;
}
}
}
    /// Builds the frame's index list from `draws` (`DrawIndexedIndirectArgs`:
    /// index count, instances, first index, base vertex, first instance),
    /// solid ones first, with their (vertex page, sorted index page) and
    /// the origins of the sections they draw by id. Records the copy into
    /// `encoder`; `calls` then lists the frame's draw calls. False when the
    /// frame cannot be drawn flat (the per-section draws then apply).
    ///
    /// When culling, the solid draws from `phase1_draws` are phase 2's, which
    /// `phase2` holds as the test leaves them: `flatten_phase2` copies them.
    /// Draws from `shadow` on are a shader pack's shadow camera's (`plan`).
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: uploads: &mut super::upload::Uploads,
    // rust: draws: &[[u32; 5]],
    // rust: pages: &[(u32, Option<u32>)],
    // rust: phase1_draws: usize,
    // rust: solid_draws: usize,
    // rust: shadow: [usize; 2],
    // rust: passes: [usize; 3],
    // rust: phase2: Option<&wgpu::Buffer>,
    // rust: translucent_arena: bool,
    // rust: origins: impl Iterator<Item = (u32, [f32; 4])>,
    // rust: sorted_page: impl Fn(u32) -> wgpu::Buffer,
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) -> bool {
    // rust: self.phase2_group = None;
    // rust: let phase1_draws = if phase2.is_some() {
    // rust: phase1_draws
    // rust: } else {
    // rust: solid_draws
}
        // Origins by section id.
    // rust: self.origin_data.clear();
    // rust: for (id, o) in origins {
    // rust: let id = id as usize;
    // rust: if self.origin_data.len() <= id {
    // rust: self.origin_data.resize(id + 1, [0.0; 4]);
}
    // rust: self.origin_data[id] = o;
}
    // rust: if self.origin_data.len() as u64 > self.origin_capacity {
    // rust: self.origin_capacity = (self.origin_data.len() as u64).next_power_of_two();
    // rust: self.origins = buffer(
    // rust: device,
    // rust: "Section origins by id",
    // rust: self.origin_capacity * 16,
    // rust: wgpu::BufferUsages::STORAGE,
    // rust: );
    // rust: for page in self.pages.iter_mut().flatten() {
    // rust: page.group = None;
}
}
    // rust: if !self.origin_data.is_empty() {
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: &self.origins,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.origin_data),
    // rust: );
}
    // rust: let Plan {
    // rust: phase1_calls,
    // rust: solid_calls,
    // rust: shadow_calls,
    // rust: pass_calls,
    // rust: total,
    // rust: } = plan(
    // rust: draws,
    // rust: pages,
    // rust: phase1_draws,
    // rust: solid_draws,
    // rust: shadow,
    // rust: passes,
    // rust: self.range_align,
            // Translucent draws, and only they, have sorted indices.
    // rust: |page, sorted| match sorted {
    // rust: Some(_) if translucent_arena => page + TRANSLUCENT_KEYS,
    // rust: _ => page,
    // rust: },
    // rust: &mut self.calls,
    // rust: &mut self.range_data,
    // rust: &mut self.segments,
    // rust: );
    // rust: self.phase1_calls = phase1_calls;
    // rust: self.solid_calls = solid_calls;
    // rust: self.shadow_calls = shadow_calls;
    // rust: self.pass_calls = pass_calls;
    // rust: if total == 0 || total * 4 > device.limits().max_storage_buffer_binding_size {
    // rust: self.calls.clear();
    // rust: self.phase1_calls = 0;
    // rust: self.solid_calls = 0;
    // rust: self.shadow_calls = [0; 2];
    // rust: self.pass_calls = [0; 3];
    // rust: return false;
}
    // rust: if self.range_data.len() as u64 > self.range_capacity {
    // rust: self.range_capacity = (self.range_data.len() as u64).next_power_of_two();
    // rust: self.ranges = buffer(
    // rust: device,
    // rust: "Flat section ranges",
    // rust: self.range_capacity * 16,
    // rust: wgpu::BufferUsages::STORAGE,
    // rust: );
}
    // rust: if total > self.index_capacity {
    // rust: self.index_capacity = total.next_power_of_two();
    // rust: self.indices = buffer(
    // rust: device,
    // rust: "Flat section indices",
    // rust: self.index_capacity * 4,
    // rust: wgpu::BufferUsages::INDEX | wgpu::BufferUsages::STORAGE,
    // rust: );
}
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: &self.ranges,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.range_data),
    // rust: );
        // Phase 2's calls start empty, each at the start of its room.
    // rust: self.phase2_call_data.clear();
    // rust: let page_instances = self.page_instances;
    // rust: self.phase2_call_data.extend(
    // rust: self.calls[phase1_calls..solid_calls]
    // rust: .iter()
    // rust: .map(|c| [0, 1, c.first, 0, if page_instances { c.page } else { 0 }]),
    // rust: );
    // rust: let phase2_calls = self.phase2_call_data.len() as u64;
    // rust: if phase2_calls > self.phase2_call_capacity {
    // rust: self.phase2_call_capacity = phase2_calls.next_power_of_two();
    // rust: self.phase2_calls = buffer(
    // rust: device,
    // rust: "Flat section draw calls, phase 2",
    // rust: self.phase2_call_capacity * 20,
    // rust: wgpu::BufferUsages::INDIRECT | wgpu::BufferUsages::STORAGE,
    // rust: );
}
    // rust: if phase2_calls > 0 {
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: &self.phase2_calls,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.phase2_call_data),
    // rust: );
}
    // rust: let ranges_at = |first: u64, count: u64| {
    // rust: wgpu::BindingResource::Buffer(wgpu::BufferBinding {
    // rust: buffer: &self.ranges,
    // rust: offset: first * 16,
    // rust: size: wgpu::BufferSize::new(count * 16),
    // rust: })
}
    // rust: if let (Some(phase2), Some(&(_, first, count))) = (
    // rust: phase2,
    // rust: self.segments.iter().find(|(s, ..)| *s == Source::Seen),
    // rust: ) {
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Flatten phase 2 section draws"),
    // rust: layout: &self.seen_layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: ranges_at(first, count),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: self.indices.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: phase2.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: self.phase2_calls.as_entire_binding(),
    // rust: },
    // rust: ],
    // rust: });
    // rust: self.phase2_group = Some((group, count as u32));
}
    // rust: let groups: Vec<(wgpu::BindGroup, u32)> = self
    // rust: .segments
    // rust: .iter()
    // rust: .filter_map(|&(source, first, count)| {
    // rust: let sorted = match source {
    // rust: Source::Quads => None,
    // rust: Source::Seen => return None,
    // rust: Source::Sorted(page) => Some(sorted_page(page)),
}
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Flatten section draws"),
    // rust: layout: &self.compute_layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: ranges_at(first, count),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: sorted.as_ref().unwrap_or(&self.empty).as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: self.indices.as_entire_binding(),
    // rust: },
    // rust: ],
    // rust: });
    // rust: Some((group, count as u32))
    // rust: })
    // rust: .collect();
    // rust: let mut pass = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
    // rust: label: Some("Flatten section draws"),
    // rust: timestamp_writes: timing.and_then(|t| t.compute_writes("Flatten")),
    // rust: });
    // rust: pass.set_pipeline(&self.flatten);
    // rust: for (group, count) in &groups {
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.dispatch_workgroups((*count).min(GROUP_LIMIT), count.div_ceil(GROUP_LIMIT), 1);
}
    // rust: drop(pass);
    // rust: true
}
    /// Gives every page table its bind group (`bind_page`): its blocks, the origins and, for
    /// a page of the section arena, that page (`arena`, by page) for the solid draws to read.
    /// Before each frame's draws, flat or not: the per-section solid draws bind the groups too
    /// (`page_group`), and a page that grew is another buffer.
    // rust: pub fn bind_pages<'a>(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: arena: impl Fn(u32) -> Option<&'a wgpu::Buffer>,
    // rust: ) {
    // rust: for (key, slot) in self.pages.iter_mut().enumerate() {
    // rust: let Some(table) = slot else {
    // rust: continue;
}
    // rust: let page = (key < TRANSLUCENT_KEYS as usize)
    // rust: .then(|| arena(key as u32))
    // rust: .flatten();
    // rust: if table.group.is_some() && table.arena.as_ref() == page {
    // rust: continue;
}
    // rust: table.arena = page.cloned();
    // rust: table.group = Some(device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Flat section draws"),
    // rust: layout: &self.draw_layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: table.blocks.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: self.origins.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: ARENA_BINDING,
    // rust: resource: page.unwrap_or(&self.empty).as_entire_binding(),
    // rust: },
    // rust: ],
    // rust: }));
}
}
    /// The bind group of the section arena's page `page` (`bind_pages`), which the solid
    /// draws read their vertices through.
pub fn page_group(self: *Self, page: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pages.get(page as usize)?.as_ref()?.group.as_ref()
}
    /// After occlusion culling's test: copies the phase 2 draws it saw.
    // rust: pub fn flatten_phase2(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let Some((group, count)) = &self.phase2_group else {
    // rust: return;
}
    // rust: let mut pass = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
    // rust: label: Some("Flatten phase 2 section draws"),
    // rust: timestamp_writes: timing.and_then(|t| t.compute_writes("Flatten phase 2")),
    // rust: });
    // rust: pass.set_pipeline(&self.flatten_seen);
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.dispatch_workgroups((*count).min(GROUP_LIMIT), count.div_ceil(GROUP_LIMIT), 1);
}

    /// The camera's translucent calls.
pub fn translucent_calls(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.calls[self.solid_calls..self.shadow_calls[0]]
}

    /// Draws `calls` with a flat pipeline set and `vertices` giving each
    /// page's vertex buffer.
    // rust: pub fn draw<'a>(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: calls: &[Call],
    // rust: vertices: impl Fn(u32) -> wgpu::BufferSlice<'a>,
    // rust: ) {
    // rust: self.draw_with(pass, calls, vertices, |_, _| {});
}
    /// `draw`, calling `page` before each run of calls from one arena page (a shader pack binds
    /// that page's vertices for reading).
    // rust: pub fn draw_with<'a>(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: calls: &[Call],
    // rust: vertices: impl Fn(u32) -> wgpu::BufferSlice<'a>,
    // rust: page: impl Fn(&mut wgpu::RenderPass<'_>, u32),
    // rust: ) {
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: for call in calls {
    // rust: self.bind_page(pass, call.page, &vertices);
    // rust: page(pass, call.page);
    // rust: pass.draw_indexed(call.first..call.first + call.count, 0, 0..1);
}
}
    /// `draw`, each call as the instance its page key names: the visibility buffer's ID
    /// pass (`visbuffer`) tells the pages apart by it.
    // rust: pub(super) fn draw_paged<'a>(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: calls: &[Call],
    // rust: vertices: impl Fn(u32) -> wgpu::BufferSlice<'a>,
    // rust: ) {
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: for call in calls {
    // rust: self.bind_page(pass, call.page, &vertices);
    // rust: pass.draw_indexed(
    // rust: call.first..call.first + call.count,
    // rust: 0,
    // rust: call.page..call.page + 1,
    // rust: );
}
}
    /// Bytes of its buffers: the index list, ranges, origins and block tables.
pub fn bytes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tables: u64 = self.pages.iter().flatten().map(|t| t.blocks.size()).sum();
    // rust: self.indices.size()
    // rust: + self.ranges.size()
    // rust: + self.origins.size()
    // rust: + self.phase2_calls.size()
    // rust: + tables
}
    /// The origins by section id, which the visibility buffer's resolve (`visbuffer`) reads
    /// in its fragment shader.
    // rust: pub(super) fn origins(&self) -> &wgpu::Buffer {
    // rust: &self.origins
}
    /// The block table of the section arena's page `page` (`blocks_per_page` entries), which
    /// the visibility buffer copies into its table of every page.
    // rust: pub(super) fn block_table(&self, page: u32) -> Option<&wgpu::Buffer> {
    // rust: Some(&self.pages.get(page as usize)?.as_ref()?.blocks)
}
    // rust: pub(super) fn blocks_per_page(&self) -> u64 {
    // rust: self.blocks_per_page
}
    /// Draws `calls` without their index buffer, `instances` times: a shader pack's geometry
    /// stage reads the indices itself (`hz_indices`) and stands for one emitted triangle per
    /// instance.
    // rust: pub fn draw_geometry<'a>(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: calls: &[Call],
    // rust: vertices: impl Fn(u32) -> wgpu::BufferSlice<'a>,
    // rust: page: impl Fn(&mut wgpu::RenderPass<'_>, u32),
    // rust: instances: u32,
    // rust: ) {
    // rust: for call in calls {
    // rust: self.bind_page(pass, call.page, &vertices);
    // rust: page(pass, call.page);
    // rust: pass.draw(call.first..call.first + call.count, 0..instances);
}
}
    /// Draws phase 2's `calls` (`calls[phase1_calls..solid_calls]` counted from 0), as
    /// `flatten_phase2` left them.
    // rust: pub fn draw_phase2<'a>(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: calls: std::ops::Range<usize>,
    // rust: vertices: impl Fn(u32) -> wgpu::BufferSlice<'a>,
    // rust: ) {
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: let first = self.phase1_calls + calls.start;
    // rust: for (k, call) in self.calls[first..self.phase1_calls + calls.end]
    // rust: .iter()
    // rust: .enumerate()
    // rust: {
    // rust: self.bind_page(pass, call.page, &vertices);
    // rust: pass.draw_indexed_indirect(&self.phase2_calls, (calls.start + k) as u64 * 20);
}
}
    // rust: fn bind_page<'a>(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: page: u32,
    // rust: vertices: &impl Fn(u32) -> wgpu::BufferSlice<'a>,
    // rust: ) {
    // rust: let table = self.pages[page as usize]
    // rust: .as_ref()
    // rust: .and_then(|t| t.group.as_ref())
    // rust: .expect("prepared page");
    // rust: pass.set_vertex_buffer(0, vertices(page));
    // rust: pass.set_bind_group(1, table, &[]);
}
}

    // rust: mod tests {
//     use super::*;

    /// Draws as `render` writes them: solid (page, quads at a base vertex)
    /// first, then translucent (page, sorted page, count, first sorted index,
    /// base vertex).
pub fn sample() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let draws = vec![
    // rust: [6 * 3, 1, 0, 0, 0],
    // rust: [6 * 2, 1, 0, 512, 1],
    // rust: [6, 1, 0, 256, 2],
    // rust: [6 * 4, 1, 0, 1024, 3],
    // rust: [6 * 2, 1, 6, 768, 1],
    // rust: [6, 1, 0, 40, 0],
    // rust: ];
    // rust: let pages = vec![
    // rust: (0, None),
    // rust: (0, None),
    // rust: (1, None),
    // rust: (0, None),
    // rust: (0, Some(0)),
    // rust: (0, Some(1)),
    // rust: ];
    // rust: (draws, pages, 4)
}

pub fn plan_draws_runs_of_a_page_in_order() void {
}
    // rust: let (draws, pages, solid) = sample();
    // rust: let (mut calls, mut ranges, mut segments) = (Vec::new(), Vec::new(), Vec::new());
    // rust: let Plan {
    // rust: phase1_calls,
    // rust: solid_calls,
    // rust: total,
    // rust: ..
    // rust: } = plan(
    // rust: &draws,
    // rust: &pages,
    // rust: solid,
    // rust: solid,
    // rust: [draws.len(); 2],
    // rust: [draws.len(), 0, solid],
    // rust: 4,
    // rust: |page, _| page,
    // rust: &mut calls,
    // rust: &mut ranges,
    // rust: &mut segments,
    // rust: );
    // rust: assert_eq!(total, 6 * 13);
    // rust: assert_eq!(phase1_calls, solid_calls);
    // rust: let call = |page, first, count| Call { page, first, count };
        // Pages 0, 0 | 1 | 0, then translucent 0, 0 (never merged with solid).
    // rust: assert_eq!(
    // rust: calls,
    // rust: [
    // rust: call(0, 0, 30),
    // rust: call(1, 30, 6),
    // rust: call(0, 36, 24),
    // rust: call(0, 60, 18)
    // rust: ]
    // rust: );
    // rust: assert_eq!(solid_calls, 3);
        // Solid ranges, then each sorted page's, every group padded to 4.
    // rust: assert_eq!(
    // rust: segments,
    // rust: [
    // rust: (Source::Quads, 0, 4),
    // rust: (Source::Sorted(0), 4, 1),
    // rust: (Source::Sorted(1), 8, 1)
    // rust: ]
    // rust: );
    // rust: assert_eq!(ranges[3], [24, QUADS, 1024, 36]);
    // rust: assert_eq!(ranges[4], [12, 6, 768, 60]);
    // rust: assert_eq!(ranges[8], [6, 0, 40, 72]);
    // rust: assert_eq!(ranges.len(), 12);
}

    /// Metal's opaque pass draws the lists before `passes[0]`, its cutout
    /// pass those from `passes[1]`: each bound starts a call of its own,
    /// though its page goes on.
pub fn plan_splits_calls_where_the_solid_passes_end_and_begin() void {
}
    // rust: let (draws, pages, solid) = sample();
    // rust: let (mut calls, mut ranges, mut segments) = (Vec::new(), Vec::new(), Vec::new());
    // rust: let plan = plan(
    // rust: &draws,
    // rust: &pages,
    // rust: solid,
    // rust: solid,
    // rust: [draws.len(); 2],
    // rust: [3, 1, solid],
    // rust: 4,
    // rust: |page, _| page,
    // rust: &mut calls,
    // rust: &mut ranges,
    // rust: &mut segments,
    // rust: );
    // rust: assert_eq!((plan.pass_calls, plan.solid_calls), ([3, 1, 4], 4));
    // rust: let call = |page, first, count| Call { page, first, count };
    // rust: assert_eq!(
    // rust: calls,
    // rust: [
    // rust: call(0, 0, 18),
    // rust: call(0, 18, 12),
    // rust: call(1, 30, 6),
    // rust: call(0, 36, 24),
    // rust: call(0, 60, 18)
    // rust: ]
    // rust: );
}

    /// A shader pack's shadow draws follow the camera's, in calls of their
    /// own even from the same page: solid ones, then translucent ones.
pub fn plan_gives_the_shadow_lists_calls_of_their_own() void {
}
    // rust: let (mut draws, mut pages, solid) = sample();
    // rust: let camera = draws.len();
    // rust: draws.extend([[6, 1, 0, 40, 6], [6 * 2, 1, 0, 64, 7], [6, 1, 6, 80, 7]]);
    // rust: pages.extend([(0, None), (0, None), (0, Some(0))]);
    // rust: let (mut calls, mut ranges, mut segments) = (Vec::new(), Vec::new(), Vec::new());
    // rust: let plan = plan(
    // rust: &draws,
    // rust: &pages,
    // rust: solid,
    // rust: solid,
    // rust: [camera, camera + 2],
    // rust: [camera, 0, solid],
    // rust: 4,
    // rust: |page, _| page,
    // rust: &mut calls,
    // rust: &mut ranges,
    // rust: &mut segments,
    // rust: );
    // rust: assert_eq!((plan.solid_calls, plan.shadow_calls), (3, [4, 5]));
    // rust: let call = |page, first, count| Call { page, first, count };
    // rust: assert_eq!(
    // rust: &calls[3..],
    // rust: [call(0, 60, 18), call(0, 78, 18), call(0, 96, 6)]
    // rust: );
    // rust: assert_eq!(plan.total, 6 * 17);
}

    /// Phase 2's draws (here the third and fourth) get calls of their own,
    /// each with room for all of its draws, and ranges naming their draw
    /// and call in phase 2.
pub fn plan_gives_phase_2_calls_of_its_own() void {
}
    // rust: let (draws, pages, solid) = sample();
    // rust: let (mut calls, mut ranges, mut segments) = (Vec::new(), Vec::new(), Vec::new());
    // rust: let plan = plan(
    // rust: &draws,
    // rust: &pages,
    // rust: 2,
    // rust: solid,
    // rust: [draws.len(); 2],
    // rust: [draws.len(), 0, solid],
    // rust: 4,
    // rust: |page, _| page,
    // rust: &mut calls,
    // rust: &mut ranges,
    // rust: &mut segments,
    // rust: );
    // rust: assert_eq!(
    // rust: plan,
    // rust: Plan {
    // rust: phase1_calls: 1,
    // rust: solid_calls: 3,
    // rust: shadow_calls: [4, 4],
    // rust: pass_calls: [1, 0, 3],
    // rust: total: 6 * 13
}
    // rust: );
    // rust: let call = |page, first, count| Call { page, first, count };
        // Phase 1: page 0 | phase 2: page 1, page 0 | translucent: page 0.
    // rust: assert_eq!(
    // rust: calls,
    // rust: [
    // rust: call(0, 0, 30),
    // rust: call(1, 30, 6),
    // rust: call(0, 36, 24),
    // rust: call(0, 60, 18)
    // rust: ]
    // rust: );
    // rust: assert_eq!(segments[1], (Source::Seen, 4, 2));
    // rust: assert_eq!(ranges[4], [6, 0, 256, 0]);
    // rust: assert_eq!(ranges[5], [24, 1, 1024, 1]);
}

    /// The compute pass writes exactly the indices the per-section draws
    /// read: quads 0 1 2 0 2 3 for solid draws, sorted indices otherwise,
    /// plus the base vertex. With culling, phase 2's runs hold the indices
    /// of the draws the test saw, in order, and their calls count them.
pub fn flatten_writes_the_indices_of_the_per_section_draws() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let Ok((device, queue)) = pollster::block_on(adapter.request_device(&Default::default()))
    // rust: else {
    // rust: eprintln!("no GPU device: skipped");
    // rust: return;
}
//         use wgpu::util::DeviceExt;
    // rust: let (draws, pages, solid) = sample();
    // rust: let align = (u64::from(device.limits().min_storage_buffer_offset_alignment) / 16).max(1);
    // rust: let sorted: [Vec<u32>; 2] = [
    // rust: (0..32).map(|i| (i * 7) % 32).collect(),
    // rust: (0..8).rev().collect(),
    // rust: ];
    // rust: let indices = |d: &[u32; 5], sorted_page: Option<u32>| -> Vec<u32> {
    // rust: (0..d[0])
    // rust: .map(|k| {
    // rust: d[3] + match sorted_page {
    // rust: None => (k / 6) * 4 + [0, 1, 2, 0, 2, 3][(k % 6) as usize],
    // rust: Some(p) => sorted[p as usize][(d[2] + k) as usize],
}
    // rust: })
    // rust: .collect()
}
    // rust: let storage = |entries: &[u32], usage| {
    // rust: device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents: bytemuck::cast_slice(entries),
    // rust: usage: wgpu::BufferUsages::STORAGE | usage,
    // rust: })
}
    // rust: let none = wgpu::BufferUsages::empty();
    // rust: let sorted_buffers = [
    // rust: storage(&sorted[0], none),
    // rust: storage(&sorted[1], none),
    // rust: storage(&[0; 4], none),
    // rust: ];
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: None,
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("flatten.wgsl").into()),
    // rust: });
    // rust: let pipeline = |entry| {
    // rust: device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    // rust: label: None,
    // rust: layout: None,
    // rust: module: &module,
    // rust: entry_point: Some(entry),
    // rust: compilation_options: Default::default(),
    // rust: cache: None,
    // rust: })
}
    // rust: let (flatten, flatten_seen) = (pipeline("flatten"), pipeline("flatten_seen"));
    // rust: let read_back = |buffer: &wgpu::Buffer, words: u64| -> Vec<u32> {
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: words * 4,
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.copy_buffer_to_buffer(buffer, 0, &read, 0, words * 4);
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: bytemuck::cast_slice(&read.slice(..).get_mapped_range().unwrap()).to_vec()
}
        // Without culling, then with the third and fourth draws in phase 2,
        // of which the test saw only the fourth.
    // rust: for phase1 in [solid, 2] {
    // rust: let (mut calls, mut ranges, mut segments) = (Vec::new(), Vec::new(), Vec::new());
    // rust: let plan = plan(
    // rust: &draws,
    // rust: &pages,
    // rust: phase1,
    // rust: solid,
    // rust: [draws.len(); 2],
    // rust: [draws.len(), 0, solid],
    // rust: align,
    // rust: |page, _| page,
    // rust: &mut calls,
    // rust: &mut ranges,
    // rust: &mut segments,
    // rust: );
            // Phase 2's draws as the test leaves them: instance counts of 0,
            // 1 where it saw the section.
    // rust: let mut phase2: Vec<[u32; 5]> = draws[phase1..solid]
    // rust: .iter()
    // rust: .map(|&[count, _, first, base, instance]| [count, 0, first, base, instance])
    // rust: .collect();
    // rust: if let Some(last) = phase2.last_mut() {
    // rust: last[1] = 1;
}
    // rust: let phase2_calls: Vec<[u32; 5]> = calls[plan.phase1_calls..plan.solid_calls]
    // rust: .iter()
    // rust: .map(|c| [0, 1, c.first, 0, 0])
    // rust: .collect();
    // rust: let range_buffer = storage(bytemuck::cast_slice(&ranges), none);
    // rust: let phase2_buffer = storage(
    // rust: bytemuck::cast_slice(&[phase2.as_slice(), &[[0; 5]]].concat()),
    // rust: none,
    // rust: );
    // rust: let calls_buffer = storage(
    // rust: bytemuck::cast_slice(&[phase2_calls.as_slice(), &[[0; 5]]].concat()),
    // rust: wgpu::BufferUsages::COPY_SRC,
    // rust: );
    // rust: let out = storage(&vec![0; plan.total as usize], wgpu::BufferUsages::COPY_SRC);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let mut pass = encoder.begin_compute_pass(&Default::default());
    // rust: for &(source, first, count) in &segments {
    // rust: let ranges = wgpu::BindingResource::Buffer(wgpu::BufferBinding {
    // rust: buffer: &range_buffer,
    // rust: offset: first * 16,
    // rust: size: wgpu::BufferSize::new(count * 16),
    // rust: });
    // rust: let entry = |binding, resource| wgpu::BindGroupEntry { binding, resource };
    // rust: let (pipeline, entries) = match source {
    // rust: Source::Seen => (
    // rust: &flatten_seen,
    // rust: vec![
    // rust: entry(0, ranges),
    // rust: entry(2, out.as_entire_binding()),
    // rust: entry(3, phase2_buffer.as_entire_binding()),
    // rust: entry(4, calls_buffer.as_entire_binding()),
    // rust: ],
    // rust: ),
    // rust: Source::Quads | Source::Sorted(_) => {
    // rust: let page = match source {
    // rust: Source::Sorted(p) => p as usize,
    // rust: _ => 2,
}
    // rust: (
    // rust: &flatten,
    // rust: vec![
    // rust: entry(0, ranges),
    // rust: entry(1, sorted_buffers[page].as_entire_binding()),
    // rust: entry(2, out.as_entire_binding()),
    // rust: ],
    // rust: )
}
}
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout: &pipeline.get_bind_group_layout(0),
    // rust: entries: &entries,
    // rust: });
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_bind_group(0, &group, &[]);
    // rust: pass.dispatch_workgroups(count as u32, 1, 1);
}
}
    // rust: queue.submit([encoder.finish()]);
    // rust: let got = read_back(&out, plan.total);
            // Phase 1's and the translucent calls: each of their draws, in order.
    // rust: let expected: Vec<u32> = (0..draws.len())
    // rust: .filter(|i| !(phase1..solid).contains(i))
    // rust: .flat_map(|i| indices(&draws[i], pages[i].1))
    // rust: .collect();
    // rust: let drawn: Vec<u32> = calls
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(c, _)| !(plan.phase1_calls..plan.solid_calls).contains(c))
    // rust: .flat_map(|(_, c)| got[c.first as usize..(c.first + c.count) as usize].to_vec())
    // rust: .collect();
    // rust: assert_eq!(drawn, expected);
            // Phase 2: page 1's run drew nothing; page 0's holds the fourth
            // draw's indices.
    // rust: if phase1 < solid {
    // rust: let counts = read_back(&calls_buffer, phase2_calls.len() as u64 * 5);
    // rust: assert_eq!(counts[0], 0);
    // rust: assert_eq!(counts[5], draws[3][0]);
    // rust: let run = &calls[plan.phase1_calls + 1];
    // rust: assert_eq!(
    // rust: got[run.first as usize..(run.first + draws[3][0]) as usize],
    // rust: indices(&draws[3], None)
    // rust: );
}
}
}
}
