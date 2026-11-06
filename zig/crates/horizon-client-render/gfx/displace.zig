//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_displace
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `[displacement]` of Horizon's own shader packs (docs/api/shaders.md): near the camera the
//! solid faces whose textures have LabPBR heights are drawn again as a grid of cells, each
//! corner moved along the face's normal by the pack's `displacement`, while the flat quads
//! leave those pixels to them (`native_material.rs`'s `horizon_displaced_layer`).
//!
//! Each frame the solid quads of the sections around the camera are copied out of the arena
//! into one buffer, a compute pass picks the ones the grid draws (opaque, with relief, within
//! the distance, facing the eye and in view) into an indirect draw, and the material's
//! displaced pipeline draws one instance a quad.

// use crate::mesher::TerrainVertex;

/// The solid quads the grid can draw a frame, and the sections they come from.
pub const MAX_QUADS: u64 = 1 << 16;
pub const MAX_SECTIONS: usize = 64;
/// Bytes of one quad's corners.
pub const QUAD_BYTES: u64 = 4 * std::mem::size_of::<TerrainVertex>() as u64;
/// How far past the flat face the relief may reach, in blocks, for the view test.
pub const RELIEF_MARGIN: f32 = 0.5;

/// Which quads the grid takes over, for the flat terrain's pipelines (the material's and the
/// shadow's) and the grid's: `horizon_displace_distance` and the LabPBR normal maps
/// `horizon_pbr_normals` (group 3, binding 12), declared by the module.
    // rust: pub const RELIEF: &str = "
// `[displacement] distance` (0 without): the flat quads leave the pixels within it on faces
// with relief to the grid.
    // rust: override horizon_displace_distance: f32 = 0.0;
// The mean LabPBR height of a sprite: its normal map's last mip level (1 without one).
pub fn horizon_relief_mean(layer: u32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if textureDimensions(horizon_pbr_normals).x <= 1u
    // rust: || layer >= textureNumLayers(horizon_pbr_normals) {
    // rust: return 1.0;
}
    // rust: let top = i32(textureNumLevels(horizon_pbr_normals)) - 1;
    // rust: return textureLoad(horizon_pbr_normals, vec2(0i), i32(layer), top).a;
}
// The quads the grid redraws near the camera (`PICK`): opaque, on a texture whose height
// varies.
pub fn horizon_displaced_layer(layer: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: return horizon_displace_distance > 0.0 && (layer & 0x8000u) != 0u
    // rust: && horizon_relief_mean(layer & 0x7fffu) < 0.998;
}
    // rust: ";

/// The grid's points (`horizon_displace_point`): one instance a quad the pick chose, its
/// corners read from the copy of the arena, each of its `horizon_displace_cells` squared
/// cells two triangles moved along the face's normal by the pack's `displacement`, measured
/// from the texture's mean height so that the face's edges, pinned there, meet their
/// neighbours whatever their relief. Needs `RELIEF`, the pack's `displacement` and
/// `horizon_material_displace` (its vertex stage).
    // rust: pub const GRID: &str = "
pub const HorizonDisplaceSection = struct {
    origin: vec4<f32>,
    first: u32,
    quads: u32,
    pad0: u32,
    pad1: u32,
};
    // rust: @group(1) @binding(8) var<storage, read> horizon_displace_vertices: array<u32>;
    // rust: @group(1) @binding(9) var<storage, read> horizon_displace_picked: array<vec2<u32>>;
    // rust: @group(1) @binding(10) var<storage, read> horizon_displace_sections: array<HorizonDisplaceSection>;
// The grid's cells along a face's side.
    // rust: override horizon_displace_cells: u32 = 16u;
// Each cell a flat step with walls to its neighbours (`grid_vertices`), not a smooth surface.
    // rust: override horizon_displace_steps: bool = false;
pub const HorizonDisplaceCorner = struct {
    position: vec3<f32>,
    uv: vec2<f32>,
    layer: u32,
    light: vec2<f32>,
    color: vec4<f32>,
};
// A corner of a quad as `TerrainVertex` holds it (24 bytes); light: sky, block.
pub fn horizon_displace_corner(quad: u32, i: u32, step: f32) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = (quad * 4u + i) * 6u;
    // rust: var c: HorizonDisplaceCorner;
    // rust: c.position = vec3(bitcast<f32>(horizon_displace_vertices[b]),
    // rust: bitcast<f32>(horizon_displace_vertices[b + 1u]),
    // rust: bitcast<f32>(horizon_displace_vertices[b + 2u]));
    // rust: let uv = horizon_displace_vertices[b + 3u];
    // rust: c.uv = vec2<f32>(vec2(uv & 0xffffu, uv >> 16u)) * step;
    // rust: let w = horizon_displace_vertices[b + 4u];
    // rust: c.layer = w & 0xffffu;
    // rust: c.light = vec2(f32((w >> 16u) & 0xffu), f32(w >> 24u));
    // rust: c.color = unpack4x8unorm(horizon_displace_vertices[b + 5u]);
    // rust: return c;
}
// The height map at `uv`, filtered between the texels of mip level `lod`.
pub fn horizon_displace_height(uv: vec2<f32>, layer: u32, lod: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = vec2<i32>(textureDimensions(horizon_pbr_normals, lod));
    // rust: let p = clamp(uv, vec2(0.0), vec2(1.0)) * vec2<f32>(size) - 0.5;
    // rust: let i = vec2<i32>(floor(p));
    // rust: let f = p - floor(p);
    // rust: let m = size - 1;
    // rust: let l = i32(layer);
    // rust: let a = textureLoad(horizon_pbr_normals, clamp(i, vec2(0), m), l, lod).a;
    // rust: let b = textureLoad(horizon_pbr_normals, clamp(i + vec2(1, 0), vec2(0), m), l, lod).a;
    // rust: let c = textureLoad(horizon_pbr_normals, clamp(i + vec2(0, 1), vec2(0), m), l, lod).a;
    // rust: let d = textureLoad(horizon_pbr_normals, clamp(i + vec2(1, 1), vec2(0), m), l, lod).a;
    // rust: return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}
// The height map's texel at `uv` of mip level `lod`.
pub fn horizon_displace_texel(uv: vec2<f32>, layer: u32, lod: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = vec2<i32>(textureDimensions(horizon_pbr_normals, lod));
    // rust: let i = clamp(vec2<i32>(uv * vec2<f32>(size)), vec2(0), size - 1);
    // rust: return textureLoad(horizon_pbr_normals, i, i32(layer), lod).a;
}
pub const HorizonDisplacePoint = struct {
    // Where it is drawn, and where it lies on the flat face (both camera-relative).
    position: vec3<f32>,
    base: vec3<f32>,
    uv: vec2<f32>,
    layer: u32,
    light: vec2<f32>,
    color: vec4<f32>,
    // The face's normal, and how much of the relief the point has by its distance.
    normal: vec3<f32>,
    near: f32,
};
// A quad's corners, for the steps.
pub const HorizonDisplaceQuad = struct {
    c0: HorizonDisplaceCorner,
    c1: HorizonDisplaceCorner,
    c2: HorizonDisplaceCorner,
    c3: HorizonDisplaceCorner,
    origin: vec3<f32>,
    normal: vec3<f32>,
};
pub fn horizon_displace_at(q: HorizonDisplaceQuad, s: f32, t: f32) v {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: return mix(mix(q.c0.position, q.c1.position, s), mix(q.c3.position, q.c2.position, s), t)
    // rust: + q.origin;
}
pub fn horizon_displace_uv(q: HorizonDisplaceQuad, s: f32, t: f32) v {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: return mix(mix(q.c0.uv, q.c1.uv, s), mix(q.c3.uv, q.c2.uv, s), t);
}
// How far cell (`i`, `j`) sinks: nothing outside the face, whose edges keep the mean height so
// that they meet their neighbours.
pub fn horizon_displace_cell_depth(q: HorizonDisplaceQuad, i: i32, j: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let g = i32(horizon_displace_cells);
    // rust: if i < 0 || j < 0 || i >= g || j >= g {
    // rust: return 0.0;
}
    // rust: let s = (f32(i) + 0.5) / f32(g);
    // rust: let t = (f32(j) + 0.5) / f32(g);
    // rust: let base = horizon_displace_at(q, s, t);
    // rust: let uv = horizon_displace_uv(q, s, t);
    // rust: let layer = q.c0.layer & 0x7fffu;
    // rust: let lods = i32(textureNumLevels(horizon_pbr_normals)) - 1;
    // rust: let size = f32(textureDimensions(horizon_pbr_normals).x);
    // rust: let lod = clamp(i32(floor(log2(size / f32(g)))), 0, lods);
    // rust: let material_id = horizon_sprite_material(layer);
    // rust: let height = horizon_displace_texel(uv, layer, lod);
    // rust: let mean = horizon_relief_mean(layer);
    // rust: let depth = displacement(DisplacementInput(base, q.normal, uv, material_id, height))
    // rust: - displacement(DisplacementInput(base, q.normal, uv, material_id, mean));
    // rust: let r = horizon_displace_distance;
    // rust: return depth * (1.0 - smoothstep(0.75 * r, r - 0.1, length(base)));
}
// Vertex `v` of a stepped grid: per cell, from -1 so that the first walls have a cell before
// them, its flat top and its walls to the next cell along each side. A wall faces the way
// out of the higher cell and takes that cell's texture.
pub fn horizon_displace_step(v: u32, q: HorizonDisplaceQuad) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let g = horizon_displace_cells;
    // rust: let cell = v / 18u;
    // rust: let part = (v / 6u) % 3u;
    // rust: let i = i32(cell % (g + 1u)) - 1;
    // rust: let j = i32(cell / (g + 1u)) - 1;
    // rust: let cells = f32(g);
    // rust: var k = v % 6u;
    // rust: var s = 0.0;
    // rust: var t = 0.0;
    // rust: var uv_s = 0.0;
    // rust: var uv_t = 0.0;
    // rust: var depth = 0.0;
    // rust: if part == 0u {
    // rust: if i >= 0 && j >= 0 {
    // rust: s = (f32(i) + f32((0x16u >> k) & 1u)) / cells;
    // rust: t = (f32(j) + f32((0x34u >> k) & 1u)) / cells;
    // rust: depth = horizon_displace_cell_depth(q, i, j);
}
    // rust: uv_s = s;
    // rust: uv_t = t;
    // rust: } else if part == 1u {
    // rust: if j >= 0 {
    // rust: let here = horizon_displace_cell_depth(q, i, j);
    // rust: let next = horizon_displace_cell_depth(q, i + 1, j);
    // rust: if next < here {
    // rust: k = (0x453120u >> (k * 4u)) & 15u;
}
    // rust: s = f32(i + 1) / cells;
    // rust: t = (f32(j) + f32((0x16u >> k) & 1u)) / cells;
    // rust: depth = select(max(here, next), min(here, next), ((0x34u >> k) & 1u) == 1u);
    // rust: uv_s = s + select(0.25, -0.25, here <= next) / cells;
    // rust: uv_t = t;
}
    // rust: } else {
    // rust: if i >= 0 {
    // rust: let here = horizon_displace_cell_depth(q, i, j);
    // rust: let next = horizon_displace_cell_depth(q, i, j + 1);
    // rust: if here < next {
    // rust: k = (0x453120u >> (k * 4u)) & 15u;
}
    // rust: s = (f32(i) + f32((0x16u >> k) & 1u)) / cells;
    // rust: t = f32(j + 1) / cells;
    // rust: depth = select(max(here, next), min(here, next), ((0x34u >> k) & 1u) == 1u);
    // rust: uv_s = s;
    // rust: uv_t = t + select(0.25, -0.25, here <= next) / cells;
}
}
    // rust: var p: HorizonDisplacePoint;
    // rust: let position = horizon_displace_at(q, s, t);
    // rust: let c = clamp(vec2(uv_s, uv_t), vec2(0.0), vec2(1.0));
    // rust: p.uv = horizon_displace_uv(q, c.x, c.y);
    // rust: p.light = mix(mix(q.c0.light, q.c1.light, s), mix(q.c3.light, q.c2.light, s), t);
    // rust: p.color = mix(mix(q.c0.color, q.c1.color, s), mix(q.c3.color, q.c2.color, s), t);
    // rust: p.layer = q.c0.layer;
    // rust: p.normal = q.normal;
    // rust: p.base = horizon_material_displace(position, p.uv, q.c0.layer, p.color,
    // rust: vec2<u32>(p.light + 0.5));
    // rust: p.near = 1.0 - smoothstep(0.75 * horizon_displace_distance, horizon_displace_distance - 0.1,
    // rust: length(p.base));
    // rust: p.position = p.base - p.normal * depth;
    // rust: return p;
}
// Vertex `v` of instance `instance`'s grid.
pub fn horizon_displace_point(v: u32, instance: u32) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pick = horizon_displace_picked[instance];
    // rust: let section = horizon_displace_sections[pick.y];
    // rust: let c0 = horizon_displace_corner(pick.x, 0u, section.origin.w);
    // rust: let c1 = horizon_displace_corner(pick.x, 1u, section.origin.w);
    // rust: let c2 = horizon_displace_corner(pick.x, 2u, section.origin.w);
    // rust: let c3 = horizon_displace_corner(pick.x, 3u, section.origin.w);
    // rust: if horizon_displace_steps {
    // rust: return horizon_displace_step(v, HorizonDisplaceQuad(c0, c1, c2, c3, section.origin.xyz,
    // rust: normalize(cross(c1.position - c0.position, c2.position - c0.position))));
}
    // The cell's two triangles wind as the quad's (0, 1, 2) and (0, 2, 3).
    // rust: let g = horizon_displace_cells;
    // rust: let cell = v / 6u;
    // rust: let k = v % 6u;
    // rust: let s = f32(cell % g + ((0x16u >> k) & 1u)) / f32(g);
    // rust: let t = f32(cell / g + ((0x34u >> k) & 1u)) / f32(g);
    // rust: var p: HorizonDisplacePoint;
    // rust: let position = mix(mix(c0.position, c1.position, s), mix(c3.position, c2.position, s), t);
    // rust: p.uv = mix(mix(c0.uv, c1.uv, s), mix(c3.uv, c2.uv, s), t);
    // rust: p.light = mix(mix(c0.light, c1.light, s), mix(c3.light, c2.light, s), t);
    // rust: p.color = mix(mix(c0.color, c1.color, s), mix(c3.color, c2.color, s), t);
    // rust: p.layer = c0.layer;
    // rust: p.normal = normalize(cross(c1.position - c0.position, c2.position - c0.position));
    // rust: p.base = horizon_material_displace(position + section.origin.xyz, p.uv, c0.layer, p.color,
    // rust: vec2<u32>(p.light + 0.5));
    // rust: let layer = c0.layer & 0x7fffu;
    // The heights at about a texel a cell.
    // rust: let lods = i32(textureNumLevels(horizon_pbr_normals)) - 1;
    // rust: let size = f32(textureDimensions(horizon_pbr_normals).x);
    // rust: let lod = clamp(i32(floor(log2(size / f32(g)))), 0, lods);
    // rust: let material_id = horizon_sprite_material(layer);
    // rust: let height = horizon_displace_height(p.uv, layer, lod);
    // rust: let mean = horizon_relief_mean(layer);
    // rust: let depth = displacement(DisplacementInput(p.base, p.normal, p.uv, material_id, height))
    // rust: - displacement(DisplacementInput(p.base, p.normal, p.uv, material_id, mean));
    // Pinned at the face's edges, easing out toward the distance.
    // rust: let edge = min(min(s, 1.0 - s), min(t, 1.0 - t)) * f32(g);
    // rust: let r = horizon_displace_distance;
    // rust: p.near = 1.0 - smoothstep(0.75 * r, r - 0.1, length(p.base));
    // rust: p.position = p.base - p.normal * depth * clamp(edge, 0.0, 1.0) * p.near;
    // rust: return p;
}
    // rust: ";

    // rust: const PICK: &str = "
pub const Params = struct {
    view_proj: mat4x4<f32>,
    distance: f32,
    sections: u32,
    margin: f32,
    capacity: u32,
    // 1 for the shadow map's list: every side, wherever the eye looks.
    shadow: u32,
    pad0: u32,
    pad1: u32,
    pad2: u32,
};
pub const Section = struct {
    origin: vec4<f32>,
    first: u32,
    quads: u32,
    pad0: u32,
    pad1: u32,
};
    // rust: @group(0) @binding(0) var<uniform> params: Params;
    // rust: @group(0) @binding(1) var<storage, read> sections: array<Section>;
    // rust: @group(0) @binding(2) var<storage, read> vertices: array<u32>;
    // rust: @group(0) @binding(3) var<storage, read_write> picked: array<vec2<u32>>;
    // rust: @group(0) @binding(4) var<storage, read_write> draw: array<atomic<u32>, 4>;
    // rust: @group(0) @binding(5) var normals: texture_2d_array<f32>;

pub fn corner(quad: u32, i: u32, origin: vec3<f32>) v {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = (quad * 4u + i) * 6u;
    // rust: return vec3(bitcast<f32>(vertices[b]), bitcast<f32>(vertices[b + 1u]),
    // rust: bitcast<f32>(vertices[b + 2u])) + origin;
}

// Every corner of the box beyond one side of the view.
pub fn outside(lo: vec3<f32>, hi: vec3<f32>) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: var out = vec4(true);
    // rust: var behind = true;
    // rust: for (var i = 0u; i < 8u; i++) {
    // rust: let p = select(lo, hi, vec3((i & 1u) != 0u, (i & 2u) != 0u, (i & 4u) != 0u));
    // rust: let c = params.view_proj * vec4(p, 1.0);
    // rust: out = out & vec4((c.x < -c.w), (c.x > c.w), (c.y < -c.w), (c.y > c.w));
    // rust: behind = behind && c.w <= 0.0;
}
    // rust: return any(out) || behind;
}

    // rust: @compute @workgroup_size(64) fn pick(@builtin(global_invocation_id) id: vec3<u32>) {
    // rust: if id.y >= params.sections {
    // rust: return;
}
    // rust: let section = sections[id.y];
    // rust: if id.x >= section.quads {
    // rust: return;
}
    // rust: let quad = section.first + id.x;
    // As `horizon_displaced_layer`: opaque, with a LabPBR height that varies.
    // rust: let layer = vertices[quad * 24u + 4u] & 0xffffu;
    // rust: let l = layer & 0x7fffu;
    // rust: if (layer & 0x8000u) == 0u || textureDimensions(normals).x <= 1u
    // rust: || l >= textureNumLayers(normals) {
    // rust: return;
}
    // rust: let top = i32(textureNumLevels(normals)) - 1;
    // rust: if textureLoad(normals, vec2(0i), i32(l), top).a >= 0.998 {
    // rust: return;
}
    // rust: let p0 = corner(quad, 0u, section.origin.xyz);
    // rust: let p1 = corner(quad, 1u, section.origin.xyz);
    // rust: let p2 = corner(quad, 2u, section.origin.xyz);
    // rust: let p3 = corner(quad, 3u, section.origin.xyz);
    // rust: let lo = min(min(p0, p1), min(p2, p3));
    // rust: let hi = max(max(p0, p1), max(p2, p3));
    // rust: if length(clamp(vec3(0.0), lo, hi)) >= params.distance {
    // rust: return;
}
    // Facing away from the eye (at the origin), where the flat quad is culled too, or out of
    // its view; the shadow map takes them all, as the flat terrain draws both sides there.
    // rust: if params.shadow == 0u && (dot(cross(p1 - p0, p2 - p0), p0) >= 0.0
    // rust: || outside(lo - params.margin, hi + params.margin)) {
    // rust: return;
}
    // rust: let i = atomicAdd(&draw[1], 1u);
    // rust: if i >= params.capacity {
    // rust: atomicSub(&draw[1], 1u);
    // rust: return;
}
    // rust: picked[i] = vec2(quad, id.y);
}
    // rust: ";

pub const Params = struct {
    view_proj: [[f32,
    distance: f32,
    sections: u32,
    margin: f32,
    capacity: u32,
    shadow: u32,
    pad: [u32,
};

pub const Section = struct {
    origin: [f32,
    first: u32,
    quads: u32,
    pad: [u32,
};

/// A section the grid may draw from this frame: its arena range of solid quads and its
/// camera-relative origin.
pub const Near = struct {
    buffer: *'a wgpu::Buffer,
    start: u64,
    quads: u32,
    origin: [f32,
};

/// One list of picked quads and its indirect draw.
pub const Picks = struct {
    /// The grid's cells along a face's side.
    cells: u32,
    /// Each cell a flat step with walls.
    steps: bool,
    params: wgpu::Buffer,
    /// The indirect draw: the grid's vertices, then the quads picked.
    draw: wgpu::Buffer,
    pick_group: wgpu::BindGroup,
    /// Group 1 of the pipelines drawing it (bindings 8 to 10).
    draw_group: wgpu::BindGroup,
};

pub const Displacement = struct {
    /// `[displacement] distance`, in blocks.
    distance: f32,
    vertices: wgpu::Buffer,
    sections: wgpu::Buffer,
    pick: wgpu::ComputePipeline,
    /// The quads the eye sees, and the ones the shadow map draws (when the pack has one).
    view: Picks,
    shadow: ?Picks,
    /// Group 1's layout for the grid's pipelines.
    draw_layout: wgpu::BindGroupLayout,
    /// Sections the pick ran over this frame (0: nothing to draw).
    drawn: usize,
};

    // rust: fn storage(
    // rust: binding: u32,
    // rust: read_only: bool,
    // rust: visibility: wgpu::ShaderStages,
    // rust: ) -> wgpu::BindGroupLayoutEntry {
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Storage { read_only },
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
}
}

/// The shadow map's grid is coarser: its texels near the camera are a 32nd of a block.
pub const SHADOW_CELLS: u32 = 16;

/// The vertices of one quad's grid: two triangles a cell, or in `steps` also two walls a cell,
/// with a row and a column more for the walls at the face's first edges.
pub fn grid_vertices(cells: u32, steps: bool) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if steps {
    // rust: (cells + 1) * (cells + 1) * 18
    // rust: } else {
    // rust: cells * cells * 6
}
}

    // rust: impl Displacement {
    /// The grid's buffers and pick pass for `[displacement]` with `distance` and `cells`, in
    /// `steps` or not, reading the LabPBR normal maps `normals`; with a list for the shadow map
    /// when `shadow`.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: distance: f32,
    // rust: cells: u32,
    // rust: steps: bool,
    // rust: normals: &wgpu::TextureView,
    // rust: shadow: bool,
    // rust: ) -> Self {
    // rust: let buffer = |label, size, usage| {
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(label),
    // rust: size,
    // rust: usage,
    // rust: mapped_at_creation: false,
    // rust: })
}
//         use wgpu::BufferUsages as U;
    // rust: let vertices = buffer(
    // rust: "Displacement quads",
    // rust: MAX_QUADS * QUAD_BYTES,
    // rust: U::STORAGE | U::COPY_DST,
    // rust: );
    // rust: let sections = buffer(
    // rust: "Displacement sections",
    // rust: (MAX_SECTIONS * std::mem::size_of::<Section>()) as u64,
    // rust: U::STORAGE | U::COPY_DST,
    // rust: );
    // rust: let compute = wgpu::ShaderStages::COMPUTE;
    // rust: let pick_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Displacement pick"),
    // rust: entries: &[
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: compute,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: storage(1, true, compute),
    // rust: storage(2, true, compute),
    // rust: storage(3, false, compute),
    // rust: storage(4, false, compute),
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 5,
    // rust: visibility: compute,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2Array,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: ],
    // rust: });
    // rust: let vertex = wgpu::ShaderStages::VERTEX;
    // rust: let draw_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Displacement draw"),
    // rust: entries: &[
    // rust: storage(8, true, vertex),
    // rust: storage(9, true, vertex),
    // rust: storage(10, true, vertex),
    // rust: ],
    // rust: });
pub fn entry(binding: u32, resource: wgpu::BindingResource<'_>) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: wgpu::BindGroupEntry { binding, resource }
}
    // rust: let picks = |cells: u32| {
    // rust: let params = buffer(
    // rust: "Displacement parameters",
    // rust: std::mem::size_of::<Params>() as u64,
    // rust: U::UNIFORM | U::COPY_DST,
    // rust: );
    // rust: let picked = buffer("Displacement picks", MAX_QUADS * 8, U::STORAGE);
    // rust: let draw = buffer(
    // rust: "Displacement draw",
    // rust: 16,
    // rust: U::STORAGE | U::INDIRECT | U::COPY_DST,
    // rust: );
    // rust: let pick_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Displacement pick"),
    // rust: layout: &pick_layout,
    // rust: entries: &[
    // rust: entry(0, params.as_entire_binding()),
    // rust: entry(1, sections.as_entire_binding()),
    // rust: entry(2, vertices.as_entire_binding()),
    // rust: entry(3, picked.as_entire_binding()),
    // rust: entry(4, draw.as_entire_binding()),
    // rust: entry(5, wgpu::BindingResource::TextureView(normals)),
    // rust: ],
    // rust: });
    // rust: let draw_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Displacement draw"),
    // rust: layout: &draw_layout,
    // rust: entries: &[
    // rust: entry(8, vertices.as_entire_binding()),
    // rust: entry(9, picked.as_entire_binding()),
    // rust: entry(10, sections.as_entire_binding()),
    // rust: ],
    // rust: });
    // rust: Picks {
    // rust: cells,
    // rust: steps,
    // rust: params,
    // rust: draw,
    // rust: pick_group,
    // rust: draw_group,
}
}
    // rust: let view = picks(cells);
        // A step's flat top has to lie where its shadow was cast from, or it shadows itself in
        // grain; a smooth surface hides the difference and can take fewer cells.
    // rust: let shadow = shadow.then(|| {
    // rust: picks(if steps {
    // rust: cells
    // rust: } else {
    // rust: cells.min(SHADOW_CELLS)
    // rust: })
    // rust: });
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Displacement pick"),
    // rust: source: wgpu::ShaderSource::Wgsl(PICK.into()),
    // rust: });
    // rust: let pick = device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    // rust: label: Some("Displacement pick"),
    // rust: layout: Some(
    // rust: &device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Displacement pick"),
    // rust: bind_group_layouts: &[Some(&pick_layout)],
    // rust: ..Default::default()
    // rust: }),
    // rust: ),
    // rust: module: &module,
    // rust: entry_point: Some("pick"),
    // rust: compilation_options: Default::default(),
    // rust: cache: None,
    // rust: });
    // rust: Self {
    // rust: distance,
    // rust: vertices,
    // rust: sections,
    // rust: pick,
    // rust: view,
    // rust: shadow,
    // rust: draw_layout,
    // rust: drawn: 0,
}
}

    /// Copies the solid quads of `near` (nearest first) and picks this frame's in `encoder`.
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: near: &[Near<'_>],
    // rust: view_proj: glam::Mat4,
    // rust: ) {
    // rust: let mut table = Vec::with_capacity(near.len().min(MAX_SECTIONS));
    // rust: let mut first = 0u64;
    // rust: let mut most = 0u32;
    // rust: for n in near.iter().take(MAX_SECTIONS) {
    // rust: let quads = u64::from(n.quads).min(MAX_QUADS - first);
    // rust: if quads == 0 {
    // rust: break;
}
    // rust: let stride = std::mem::size_of::<TerrainVertex>() as u64;
    // rust: encoder.copy_buffer_to_buffer(
    // rust: n.buffer,
    // rust: n.start * stride,
    // rust: &self.vertices,
    // rust: first * QUAD_BYTES,
    // rust: quads * QUAD_BYTES,
    // rust: );
    // rust: table.push(Section {
    // rust: origin: [
    // rust: n.origin[0],
    // rust: n.origin[1],
    // rust: n.origin[2],
    // rust: 1.0 / crate::mesher::UV_STEPS,
    // rust: ],
    // rust: first: first as u32,
    // rust: quads: quads as u32,
    // rust: pad: [0; 2],
    // rust: });
    // rust: first += quads;
    // rust: most = most.max(quads as u32);
}
    // rust: self.drawn = table.len();
    // rust: if table.is_empty() {
    // rust: return;
}
    // rust: queue.write_buffer(&self.sections, 0, bytemuck::cast_slice(&table));
    // rust: let lists = std::iter::once((&self.view, 0)).chain(self.shadow.iter().map(|s| (s, 1)));
    // rust: let mut pass = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
    // rust: label: Some("Displacement pick"),
    // rust: timestamp_writes: None,
    // rust: });
    // rust: pass.set_pipeline(&self.pick);
    // rust: for (picks, shadow) in lists {
    // rust: let params = Params {
    // rust: view_proj: view_proj.to_cols_array_2d(),
    // rust: distance: self.distance,
    // rust: sections: table.len() as u32,
    // rust: margin: RELIEF_MARGIN,
    // rust: capacity: MAX_QUADS as u32,
    // rust: shadow,
    // rust: pad: [0; 3],
}
    // rust: queue.write_buffer(&picks.params, 0, bytemuck::bytes_of(&params));
    // rust: let vertices = grid_vertices(picks.cells, picks.steps);
    // rust: queue.write_buffer(&picks.draw, 0, bytemuck::cast_slice(&[vertices, 0, 0, 0]));
    // rust: pass.set_bind_group(0, &picks.pick_group, &[]);
    // rust: pass.dispatch_workgroups(most.div_ceil(64), table.len() as u32, 1);
}
}

    /// Draws `picks`' grids with `pipeline`, its other groups bound.
    // rust: pub fn draw(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: picks: &Picks,
    // rust: pipeline: &wgpu::RenderPipeline,
    // rust: ) {
    // rust: if self.drawn == 0 {
    // rust: return;
}
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_bind_group(1, &picks.draw_group, &[]);
    // rust: pass.draw_indirect(&picks.draw, 0);
}
}

    // rust: mod tests {
pub fn a_stepped_grid_has_a_top_and_two_walls_a_cell_and_the_first_edges() void {
}
    // rust: assert_eq!(super::grid_vertices(16, false), 16 * 16 * 6);
    // rust: assert_eq!(super::grid_vertices(16, true), 17 * 17 * 18);
}

pub fn the_pick_validates() void {
}
    // rust: let module = naga::front::wgsl::parse_str(super::PICK)
    // rust: .unwrap_or_else(|e| panic!("{}", e.emit_to_string(super::PICK)));
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap_or_else(|e| panic!("{}", e.emit_to_string(super::PICK)));
}
}
