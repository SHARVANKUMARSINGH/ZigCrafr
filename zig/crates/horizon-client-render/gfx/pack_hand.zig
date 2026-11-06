//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_pack_hand
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The first-person hand and held items drawn by a shader pack's `gbuffers_hand` (spec 2.3):
//! `Frame::hand`'s entity vertices, read as entities are (`pack_entities::inputs`), with the
//! hand's own projection as `gl_ProjectionMatrix` (5.2: `gbufferProjection` stays the world's).

// use glam::Mat4;

// use super::Vertex;

/// `MC_HAND_DEPTH`'s value (1.5): the hand's depth is scaled by it through its projection, so
/// that it sits in front of the world in the shared depth buffer.
pub const HAND_DEPTH: f32 = 0.125;

/// `HzHand`: the hand's projection and its inverse.
pub const UNIFORM: u64 = 2 * 64;

/// `HzDraw`'s size (pack_draw.rs).
pub const SLOT: u64 = 32;

/// What `gbuffers_hand` reads: the entity inputs, and the hand's projection from set 1.
pub fn inputs() h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut inputs = super::pack_entities::inputs();
    // Iris 1.11.7 declares `currentRenderedItemId` in the hand's programs (observed).
    // rust: inputs.item_id_declared = true;
    // rust: inputs.declarations.push_str(
    // rust: "layout(set = 1, binding = 1) uniform HzHand { mat4 hz_hand_projection; mat4 hz_hand_projection_inverse; };\n",
    // rust: );
    // rust: inputs.body.push_str(
    // rust: "    hz_ProjectionMatrix = hz_hand_projection;\n    \
    // rust: hz_ProjectionMatrixInverse = hz_hand_projection_inverse;\n    \
    // rust: hz_ModelViewProjectionMatrix = hz_hand_projection * hz_ModelViewMatrix;\n",
    // rust: );
    // rust: inputs
}

/// The hand's projection in GL's conventions: `hud_fov` degrees, depth scaled by
/// `MC_HAND_DEPTH` (the view bob is in `gbufferModelView`).
pub fn projection(hud_fov: f32, aspect: f32, far: f32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Mat4::from_scale(glam::Vec3::new(1.0, 1.0, HAND_DEPTH))
    // rust: * Mat4::perspective_rh_gl(hud_fov.to_radians(), aspect, 0.05, far)
}

/// The hand's vertices (also read at set 1 for normals and tangents), its uniform and quad
/// indices.
pub const PackHand = struct {
    layout: wgpu::BindGroupLayout,
    vertices: wgpu::Buffer,
    uniform: wgpu::Buffer,
    group: wgpu::BindGroup,
    indices: wgpu::Buffer,
    capacity: u32,
    /// Quads uploaded this frame.
    quads: u32,
    /// `HzDraw` (set 2) of each run: the arm or one held item, and its `currentRenderedItemId`.
    slots: wgpu::Buffer,
    slot_group: wgpu::BindGroup,
    stride: u64,
    /// This frame's runs: first quad, quads, and the dynamic offset of their slot.
    runs: Vec<(u32,
};

    // rust: impl PackHand {
    /// `draws`: the layout of `HzDraw` (pack_draw.rs).
pub fn new(device: *wgpu::Device, draws: *wgpu::BindGroupLayout) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entry = |binding, ty| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::VERTEX,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
}
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Shader pack hand"),
    // rust: entries: &[
    // rust: entry(0, wgpu::BufferBindingType::Storage { read_only: true }),
    // rust: entry(1, wgpu::BufferBindingType::Uniform),
    // rust: ],
    // rust: });
    // rust: let uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack hand"),
    // rust: size: UNIFORM,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let capacity = 256;
    // rust: let (vertices, group) = Self::vertex_buffer(device, &layout, &uniform, capacity);
    // rust: let stride = SLOT.max(u64::from(
    // rust: device.limits().min_uniform_buffer_offset_alignment,
    // rust: ));
        // The arm and the two hands' items: a few runs a frame.
    // rust: let slots = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack hand draws"),
    // rust: size: SLOTS * stride,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let slot_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack hand draws"),
    // rust: layout: draws,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::Buffer(wgpu::BufferBinding {
    // rust: buffer: &slots,
    // rust: offset: 0,
    // rust: size: wgpu::BufferSize::new(SLOT),
    // rust: }),
    // rust: }],
    // rust: });
    // rust: Self {
    // rust: indices: super::pack_entities::quad_indices(device, capacity),
    // rust: layout,
    // rust: vertices,
    // rust: uniform,
    // rust: group,
    // rust: capacity,
    // rust: quads: 0,
    // rust: slots,
    // rust: slot_group,
    // rust: stride,
    // rust: runs: Vec::new(),
}
}

    // rust: fn vertex_buffer(
    // rust: device: &wgpu::Device,
    // rust: layout: &wgpu::BindGroupLayout,
    // rust: uniform: &wgpu::Buffer,
    // rust: quads: u32,
    // rust: ) -> (wgpu::Buffer, wgpu::BindGroup) {
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack hand vertices"),
    // rust: size: u64::from(quads) * 4 * std::mem::size_of::<Vertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX
    // rust: | wgpu::BufferUsages::STORAGE
    // rust: | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack hand"),
    // rust: layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: buffer.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: uniform.as_entire_binding(),
    // rust: },
    // rust: ],
    // rust: });
    // rust: (buffer, group)
}

    /// Uploads this frame's hand, its projection, and the `HzDraw` of each run `items` starts
    /// (first vertex, `currentRenderedItemId`; the slots past [`SLOTS`] share the last).
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: hand: &[Vertex],
    // rust: items: &[(u32, i32)],
    // rust: projection: Mat4,
    // rust: ) {
    // rust: self.quads = (hand.len() / 4) as u32;
    // rust: self.runs.clear();
    // rust: if self.quads == 0 {
    // rust: return;
}
    // rust: let mut contents = Vec::new();
    // rust: for (start, quads, id) in runs(self.quads, items) {
    // rust: let slot = (self.runs.len() as u64).min(SLOTS - 1);
    // rust: if slot as usize == self.runs.len() {
    // rust: contents.extend_from_slice(&draw_slot(id));
    // rust: contents.resize(((slot + 1) * self.stride) as usize, 0);
}
    // rust: self.runs.push((start, quads, (slot * self.stride) as u32));
}
    // rust: queue.write_buffer(&self.slots, 0, &contents);
    // rust: if self.quads > self.capacity {
    // rust: self.capacity = self.quads.next_power_of_two();
    // rust: (self.vertices, self.group) =
    // rust: Self::vertex_buffer(device, &self.layout, &self.uniform, self.capacity);
    // rust: self.indices = super::pack_entities::quad_indices(device, self.capacity);
}
    // rust: queue.write_buffer(&self.vertices, 0, bytemuck::cast_slice(hand));
    // rust: let matrices = [projection, projection.inverse()].map(|m| m.to_cols_array());
    // rust: queue.write_buffer(&self.uniform, 0, bytemuck::cast_slice(&matrices));
}

pub fn vertices(self: *Self) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.vertices.slice(..)
}
}

/// The hand's runs a frame keeps slots for.
pub const SLOTS: u64 = 8;

/// `HzDraw` of a hand run: `renderStage` the solid hand's, `blockEntityId` -1 as outside block
/// entities, and `currentRenderedItemId`.
pub fn draw_slot(id: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut bytes = [0u8; SLOT as usize];
    // rust: let stage = horizon_shaders::render_stage("HAND_SOLID") as i32;
    // rust: bytes[0..4].copy_from_slice(&stage.to_le_bytes());
    // rust: bytes[8..12].copy_from_slice(&(-1i32).to_le_bytes());
    // rust: bytes[12..16].copy_from_slice(&id.to_le_bytes());
    // rust: bytes
}

/// The runs of `quads` quads that `items` starts (first vertex, id), as first quad, quads and
/// id; geometry before the first start, or with no starts at all, reads 0, as the arm does.
pub fn runs(quads: u32, items: *[(u32) void {
}
    // rust: let mut starts: Vec<(u32, i32)> = vec![(0, 0)];
    // rust: for &(start, id) in items {
    // rust: let q = (start / 4).min(quads);
    // rust: match starts.last_mut() {
    // rust: Some(last) if last.0 == q => last.1 = id,
    // rust: _ => starts.push((q, id)),
}
}
    // rust: (0..starts.len())
    // rust: .map(|i| {
    // rust: let end = starts.get(i + 1).map_or(quads, |s| s.0);
    // rust: (starts[i].0, end - starts[i].0, starts[i].1)
    // rust: })
    // rust: .filter(|r| r.1 > 0)
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;

    /// Each item's quads draw with its id; geometry before the first item is the arm's (0).
pub fn runs_split_the_hand_by_item() void {
}
    // rust: assert_eq!(runs(3, &[]), [(0, 3, 0)]);
    // rust: assert_eq!(runs(5, &[(0, 11), (8, 65535)]), [(0, 2, 11), (2, 3, 65535)]);
    // rust: assert_eq!(runs(4, &[(4, 21)]), [(0, 1, 0), (1, 3, 21)]);
        // An item that drew nothing gives way to the next.
    // rust: assert_eq!(runs(2, &[(0, 11), (0, 22)]), [(0, 2, 22)]);
}

    /// The hand's window depth lies within `MC_HAND_DEPTH` of the middle (packs tell the hand
    /// apart by it), and x, y match the plain projection.
pub fn hand_depth_is_scaled_around_the_middle() void {
}
    // rust: let p = projection(70.0, 16.0 / 9.0, 512.0);
    // rust: let plain = Mat4::perspective_rh_gl(70f32.to_radians(), 16.0 / 9.0, 0.05, 512.0);
    // rust: for z in [-0.06f32, -0.5, -3.0, -400.0] {
    // rust: let v = glam::Vec4::new(0.1, -0.2, z, 1.0);
    // rust: let (a, b) = (p * v, plain * v);
    // rust: let window = (a.z / a.w) * 0.5 + 0.5;
    // rust: assert!(
    // rust: (window - 0.5).abs() <= HAND_DEPTH * 0.5 + 1e-6,
    // rust: "{z}: {window}"
    // rust: );
    // rust: assert!((a.x / a.w - b.x / b.w).abs() < 1e-6);
}
}
}
