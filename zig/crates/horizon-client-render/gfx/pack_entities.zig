//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_pack_entities
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entities, block entities, translucent entity parts and particles drawn by a shader pack's
//! `gbuffers_entities`, `gbuffers_block`, `gbuffers_entities_translucent` and
//! `gbuffers_particles` (spec 2.3, 5.3, 5.4): the runs of `Frame::entities` the game marked (`EntitySpan`), each its
//! own draw with its `entityId` or `blockEntityId` and `entityColor` in a per-draw slot of
//! `HzDraw` (set 2). Horizon draws whatever the pack does not.

// use std::ops::Range;

// use horizon_shaders::render_stage;

// use super::Vertex;
// use super::pack_draw::EntitySpan;

/// `HzDraw`'s size (pack_draw.rs).
pub const SLOT: u64 = 32;

    // rust: const ATTRIBUTES: [wgpu::VertexAttribute; 6] = wgpu::vertex_attr_array![
    // rust: 0 => Float32x3, 1 => Float32x2, 2 => Uint32, 3 => Unorm8x4, 4 => Uint8x4, 5 => Snorm8x4
    // rust: ];

/// The entity vertex: Horizon's own (`Vertex`).
pub fn buffers() [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &ATTRIBUTES,
    // rust: })]
}

/// What `gbuffers_entities` and `gbuffers_block` read from an entity vertex: camera-relative
/// position, the shared atlas's UV, colour, light (block, sky in 16ths) and the world-oriented
/// normal. The quad's corners, read from the same vertices at set 1, give the face normal where
/// the vertex has none (block entities) and `at_tangent` along the texture's u, as for terrain.
pub fn inputs() h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let declarations = "layout(location = 0) in vec3 hz_v_pos;\nlayout(location = 1) in vec2 hz_v_uv;\n\
    // rust: layout(location = 2) in uint hz_v_overlay;\nlayout(location = 3) in vec4 hz_v_color;\n\
    // rust: layout(location = 4) in uvec4 hz_v_light;\nlayout(location = 5) in vec4 hz_v_normal;\n\
    // rust: layout(set = 1, binding = 0) readonly buffer HzEntityVertices { uint hz_entity_vertices[]; };\n\
    // rust: vec4 hz_tangent; vec2 hz_mid;\n"
    // rust: .to_owned();
    // rust: let words = std::mem::size_of::<Vertex>() / 4;
    // rust: let corner = |k: usize, field: &str| {
    // rust: let at = |o: usize| format!("hz_entity_vertices[hz_q + {}u]", k * words + o);
    // rust: match field {
    // rust: "pos" => format!("uintBitsToFloat(uvec3({}, {}, {}))", at(0), at(1), at(2)),
    // rust: _ => format!("uintBitsToFloat(uvec2({}, {}))", at(3), at(4)),
}
}
    // rust: let body = format!(
    // rust: "    uint hz_q = (uint(gl_VertexIndex) & ~3u) * {words}u;\n    \
    // rust: vec3 hz_e1 = {p1} - {p0};\n    \
    // rust: vec3 hz_e2 = {p2} - {p0};\n    \
    // rust: vec2 hz_t0 = {t0};\n    \
    // rust: vec2 hz_d1 = {t1} - hz_t0;\n    \
    // rust: vec2 hz_d2 = {t2} - hz_t0;\n    \
    // rust: hz_mid = (hz_t0 + {t2}) * 0.5;\n    \
    // rust: vec3 hz_n = cross(hz_e1, hz_e2);\n    \
    // rust: hz_Normal = dot(hz_v_normal.xyz, hz_v_normal.xyz) > 0.01 ? normalize(hz_v_normal.xyz)\n        \
    // rust: : dot(hz_n, hz_n) > 1e-12 ? normalize(hz_n) : vec3(0.0, 1.0, 0.0);\n    \
    // rust: hz_tangent = vec4(1.0, 0.0, 0.0, 1.0);\n    \
    // rust: float hz_r = hz_d1.x * hz_d2.y - hz_d2.x * hz_d1.y;\n    \
    // rust: vec3 hz_t = (hz_e1 * hz_d2.y - hz_e2 * hz_d1.y) * sign(hz_r);\n    \
    // rust: vec3 hz_b = (hz_e2 * hz_d1.x - hz_e1 * hz_d2.x) * sign(hz_r);\n    \
    // rust: hz_t -= hz_Normal * dot(hz_Normal, hz_t);\n    \
    // rust: if (dot(hz_t, hz_t) > 1e-12) {{\n        \
    // rust: hz_t = normalize(hz_t);\n        \
    // rust: hz_tangent = vec4(hz_t, dot(cross(hz_t, hz_Normal), hz_b) < 0.0 ? -1.0 : 1.0);\n    \
    // rust: }}\n    \
    // rust: hz_Vertex = vec4(hz_v_pos, 1.0);\n    \
    // rust: hz_MultiTexCoord0 = vec4(hz_v_uv, 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord1 = vec4(float(hz_v_light.y), float(hz_v_light.x), 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord2 = hz_MultiTexCoord1;\n    \
    // rust: hz_Color = hz_v_color;\n",
    // rust: p0 = corner(0, "pos"),
    // rust: p1 = corner(1, "pos"),
    // rust: p2 = corner(2, "pos"),
    // rust: t0 = corner(0, "uv"),
    // rust: t1 = corner(1, "uv"),
    // rust: t2 = corner(2, "uv"),
    // rust: );
    // rust: let attributes = [
    // rust: ("at_tangent", "hz_tangent"),
    // rust: ("mc_midTexCoord", "vec4(hz_mid, 0.0, 1.0)"),
    // rust: ("vaPosition", "hz_Vertex.xyz"),
    // rust: ("vaUV0", "hz_v_uv"),
    // rust: ("vaUV1", "ivec2(0, 10)"),
    // rust: ("vaUV2", "ivec2(hz_MultiTexCoord1.xy)"),
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
        // Cutout, as vanilla's entity types mostly are (OQ-23): the loader's test at 0.1.
    // rust: alpha_test: Some(horizon_shaders::AlphaTest {
    // rust: op: ">",
    // rust: reference: 0.1,
    // rust: }),
    // rust: item_id_declared: false,
    // rust: far_depth: false,
}
}

/// What a shadow program with a geometry stage reads of entities and block entities: the
/// inputs of [`inputs`], each vertex read from set 1 (`hz_entity_vertices`), as `Vertex` lays
/// it out. The draw's corners walk its quads two triangles each, as `quad_indices` does: corner
/// `c` of a draw from vertex `first` (a whole quad) is drawn as vertex `first / 4 * 6 + c`.
pub fn geometry_inputs() h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let words = std::mem::size_of::<Vertex>() / 4;
    // rust: let pull = format!(
    // rust: "        uint hz_pw = hz_vertex_index * {words}u;\n        \
    // rust: hz_v_pos = uintBitsToFloat(uvec3(hz_entity_vertices[hz_pw], hz_entity_vertices[hz_pw + 1u], hz_entity_vertices[hz_pw + 2u]));\n        \
    // rust: hz_v_uv = uintBitsToFloat(uvec2(hz_entity_vertices[hz_pw + 3u], hz_entity_vertices[hz_pw + 4u]));\n        \
    // rust: hz_v_overlay = hz_entity_vertices[hz_pw + 5u];\n        \
    // rust: hz_v_color = unpackUnorm4x8(hz_entity_vertices[hz_pw + 6u]);\n        \
    // rust: uint hz_pl = hz_entity_vertices[hz_pw + 7u];\n        \
    // rust: hz_v_light = uvec4(hz_pl & 255u, (hz_pl >> 8u) & 255u, (hz_pl >> 16u) & 255u, hz_pl >> 24u);\n        \
    // rust: hz_v_normal = unpackSnorm4x8(hz_entity_vertices[hz_pw + 8u]);\n"
    // rust: );
    // rust: horizon_shaders::GeometryInputs {
    // rust: inputs: inputs(),
    // rust: pull,
        // Quad `c / 6`, corner 0, 1, 2, 0, 2, 3 of it.
    // rust: index:
    // rust: "((@) / 6u * 4u + ((@) % 6u < 3u ? (@) % 6u : ((@) % 6u == 3u ? 0u : (@) % 6u - 2u)))"
    // rust: .to_owned(),
}
}

/// What `gbuffers_clouds` reads from the clouds' mesh (entity vertices, `vs_cloud`): the
/// position moved by the clouds' offset, the colour of the face's shade from their palette,
/// full light, the face's normal. Set 1 holds the clouds' uniform (`clouds::Uniform`).
pub fn cloud_inputs() h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let declarations = "layout(location = 0) in vec3 hz_v_pos;\nlayout(location = 1) in vec2 hz_v_uv;\n\
    // rust: layout(location = 2) in uint hz_v_overlay;\nlayout(location = 3) in vec4 hz_v_color;\n\
    // rust: layout(location = 4) in uvec4 hz_v_light;\nlayout(location = 5) in vec4 hz_v_normal;\n\
    // rust: layout(set = 1, binding = 0) uniform HzCloud { vec4 hz_cloud_offset; vec4 hz_cloud_colors[4]; };\n"
    // rust: .to_owned();
    // rust: let body = "    hz_Vertex = vec4(hz_v_pos + hz_cloud_offset.xyz, 1.0);\n    \
    // rust: hz_MultiTexCoord0 = vec4(hz_v_uv, 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord1 = vec4(240.0, 240.0, 0.0, 1.0);\n    \
    // rust: hz_MultiTexCoord2 = hz_MultiTexCoord1;\n    \
    // rust: hz_Color = hz_cloud_colors[min(hz_v_light.x, 3u)];\n    \
    // rust: hz_Normal = dot(hz_v_normal.xyz, hz_v_normal.xyz) > 0.01 ? normalize(hz_v_normal.xyz) : vec3(0.0, 1.0, 0.0);\n"
    // rust: .to_owned();
    // rust: let attributes = [
    // rust: ("vaPosition", "hz_Vertex.xyz"),
    // rust: ("vaUV0", "hz_v_uv"),
    // rust: ("vaUV2", "ivec2(240, 240)"),
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

/// `entityColor` for a run whose first quad carries overlay code `overlay`: the hurt red or a
/// white flash, its alpha how much of that colour shows over the entity (vanilla mixes the
/// overlay texel's colour in by one minus the texel's alpha).
pub fn entity_color(overlay: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [r, g, b, a] = crate::overlay::HURT_TEXEL.map(|v| f32::from(v) / 255.0);
    // rust: let white = |u: u32| {
    // rust: let a = f32::from(crate::overlay::white_alpha(u)) / 255.0;
    // rust: [1.0, 1.0, 1.0, 1.0 - a]
}
    // rust: match overlay {
    // rust: 1 | 8 => [r, g, b, 1.0 - a],
    // rust: 5 => white(15),
    // rust: 16..32 => white(overlay - crate::overlay::WHITE),
    // rust: _ => [0.0; 4],
}
}

/// One draw: its quads in `PackEntities`' buffer, its program and its slot of `HzDraw`.
    // rust: pub(super) struct Draw {
    /// The first vertex.
    // rust: pub base: u32,
    // rust: pub quads: u32,
    /// The kind of program that draws it (`ENTITY`, `BLOCK`, `TRANSLUCENT`, `PARTICLE`).
    // rust: pub program: usize,
    /// The pack's gbuffers program draws it (else Horizon does).
    // rust: pub pack: bool,
    /// The pack's shadow program draws it into the shadow map too.
    // rust: pub shadow: bool,
    // rust: pub slot: u32,
    /// End portal or gateway faces: drawn with `end_portal.png` bound as the atlas.
    // rust: pub portal: bool,
}

/// Which entity runs a pack's shadow pass draws (2.4, 3.2).
pub const Casters = struct {
    /// `shadow_entities` (or `shadow`) draws entities...
    entities: bool,
    /// ...only the local player (`shadowPlayer` without `shadowEntities`).
    only_player: bool,
    /// `shadow_block` (or `shadow`) draws block entities...
    blocks: bool,
    /// ...only those whose block emits light (`shadowLightBlockEntities`).
    only_lit: bool,
};

    // rust: impl Casters {
    /// Whether the shadow pass draws `span`'s run, of kind `program`.
pub fn cast(self: *Self, span: *EntitySpan, program: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match program {
    // rust: ENTITY => self.entities && (!self.only_player || span.player),
    // rust: BLOCK => self.blocks && (!self.only_lit || span.emissive),
    // rust: _ => false,
}
}
}

/// The vertices and per-draw uniforms of the runs a pack draws, rebuilt each frame.
    // rust: pub(super) struct PackEntities {
    // rust: vertices: wgpu::Buffer,
    /// Set 1: the vertices again, for the quads' corners.
    // rust: pub table: wgpu::BindGroupLayout,
    // rust: pub table_group: wgpu::BindGroup,
    // rust: slots: wgpu::Buffer,
    // rust: pub group: wgpu::BindGroup,
    // rust: stride: u64,
    /// Two triangles per quad, for `quads` quads.
    // rust: pub indices: wgpu::Buffer,
    // rust: quads: u32,
    // rust: scratch: Vec<Vertex>,
    // rust: uniforms: Vec<u8>,
    // rust: pub draws: Vec<Draw>,
}

    // rust: impl PackEntities {
pub fn new(device: *wgpu::Device, layout: *wgpu::BindGroupLayout) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stride = SLOT.max(u64::from(
    // rust: device.limits().min_uniform_buffer_offset_alignment,
    // rust: ));
    // rust: let table = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Shader pack entity vertices"),
    // rust: entries: &[wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::VERTEX,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Storage { read_only: true },
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: }],
    // rust: });
    // rust: let (vertices, table_group) = Self::vertex_buffer(device, &table, 4096);
    // rust: let (slots, group) = Self::slot_buffer(device, layout, 64, stride);
    // rust: Self {
    // rust: vertices,
    // rust: table,
    // rust: table_group,
    // rust: slots,
    // rust: group,
    // rust: stride,
    // rust: indices: quad_indices(device, 1024),
    // rust: quads: 1024,
    // rust: scratch: Vec::new(),
    // rust: uniforms: Vec::new(),
    // rust: draws: Vec::new(),
}
}

    // rust: fn vertex_buffer(
    // rust: device: &wgpu::Device,
    // rust: table: &wgpu::BindGroupLayout,
    // rust: vertices: u64,
    // rust: ) -> (wgpu::Buffer, wgpu::BindGroup) {
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack entity vertices"),
    // rust: size: vertices * std::mem::size_of::<Vertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX
    // rust: | wgpu::BufferUsages::STORAGE
    // rust: | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack entity vertices"),
    // rust: layout: table,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: buffer.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: (buffer, group)
}

    // rust: fn slot_buffer(
    // rust: device: &wgpu::Device,
    // rust: layout: &wgpu::BindGroupLayout,
    // rust: slots: u64,
    // rust: stride: u64,
    // rust: ) -> (wgpu::Buffer, wgpu::BindGroup) {
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack entity draws"),
    // rust: size: slots * stride,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack entity draws"),
    // rust: layout,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::Buffer(wgpu::BufferBinding {
    // rust: buffer: &buffer,
    // rust: offset: 0,
    // rust: size: wgpu::BufferSize::new(SLOT),
    // rust: }),
    // rust: }],
    // rust: });
    // rust: (buffer, group)
}

pub fn skin_target(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.vertices
}

pub fn vertices(self: *Self) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.vertices.slice(..)
}

    /// The dynamic offset of draw slot `slot`.
pub fn offset(self: *Self, slot: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (u64::from(slot) * self.stride) as u32
}

    /// Splits `entities` between the pack, which draws the runs of `spans` its programs cover
    /// (`drawn`: whether it has `gbuffers_entities`, `gbuffers_block` or their fallbacks), and
    /// Horizon, which draws the rest (`rest`). Uploads the pack's part, and the runs its shadow
    /// programs draw (`shadow`). Runs hidden from the camera only ever cast shadows.
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: layout: &wgpu::BindGroupLayout,
    // rust: entities: &[Vertex],
    // rust: spans: &[EntitySpan],
    // rust: drawn: [bool; PROGRAMS],
    // rust: crack: ([f32; 4], [u32; 2]),
    // rust: shadow: Casters,
    // rust: rest: &mut Vec<Vertex>,
    // rust: skin: Option<&super::entity_skin::SkinFrame>,
    // rust: ) {
    // rust: self.draws.clear();
    // rust: self.scratch.clear();
    // rust: self.uniforms.clear();
    // rust: rest.clear();
    // rust: let posed = skin.map_or(0, |s| s.vertices);
    // rust: if let Some(skin) = skin {
    // rust: for (span, range, overlay) in skin_runs(skin) {
    // rust: let program = program_of(&span).expect("tagged skin stage");
    // rust: let pack = drawn[program] && !span.hidden;
    // rust: let casts = shadow.cast(&span, program);
    // rust: if !pack && !casts {
    // rust: continue;
}
    // rust: self.push_draw(
    // rust: span,
    // rust: range.start,
    // rust: range.len() as u32,
    // rust: program,
    // rust: pack,
    // rust: casts,
    // rust: overlay,
    // rust: false,
    // rust: );
}
}
    // rust: let first = spans.first().map_or(entities.len(), |s| s.start as usize);
    // rust: extend_without_portals(rest, &entities[..first.min(entities.len())]);
    // rust: let (mut other, mut portal_faces, mut beam_faces) = (Vec::new(), Vec::new(), Vec::new());
    // rust: for (span, range) in runs(entities.len(), spans) {
    // rust: let whole = &entities[range];
            // A block entity's run can hold End portal faces and beams beside plain parts (an End
            // gateway: its cube and its beam): each goes to its own program.
            // Beacon beams come in a run of their own, at stage NONE (game.rs: no stage of 5.4
            // is theirs), for gbuffers_beaconbeam.
    // rust: let split = (program_of(&span) == Some(BLOCK) || span.stage == render_stage("NONE"))
    // rust: && whole
    // rust: .chunks(4)
    // rust: .any(|q| matches!(q[0].layer & 0xffff, 6 | 9 | 10));
    // rust: let parts: [(&[Vertex], Part); 3] = if split {
    // rust: other.clear();
    // rust: portal_faces.clear();
    // rust: beam_faces.clear();
    // rust: for quad in whole.chunks(4) {
    // rust: match quad[0].layer & 0xffff {
    // rust: 9 | 10 => portal_faces.extend_from_slice(quad),
    // rust: 6 => beam_faces.extend_from_slice(quad),
    // rust: _ => other.extend_from_slice(quad),
}
}
    // rust: [
    // rust: (&other, Part::Plain),
    // rust: (&portal_faces, Part::Portal),
    // rust: (&beam_faces, Part::Beam),
    // rust: ]
    // rust: } else {
    // rust: [(whole, Part::Plain), (&[], Part::Plain), (&[], Part::Plain)]
}
    // rust: for (run, part) in parts {
    // rust: if run.is_empty() {
    // rust: continue;
}
    // rust: let program = match part {
    // rust: Part::Portal => Some(BLOCK),
    // rust: Part::Beam => Some(BEAM),
    // rust: Part::Plain => program_of(&span).filter(|&p| {
    // rust: plain(run)
    // rust: || (p == DESTROY && run.iter().all(|v| matches!(v.layer, 11 | 12)))
    // rust: }),
}
    // rust: let pack = program.is_some_and(|p| drawn[p]) && !span.hidden;
                // Portal faces cast too (a pack's shadow pass sees block entities whole, as Iris
                // draws them); beams do not.
    // rust: let casts = part != Part::Beam && program.is_some_and(|p| shadow.cast(&span, p));
    // rust: if !pack && !span.hidden {
    // rust: extend_without_portals(rest, run);
}
    // rust: let Some(program) = program.filter(|_| pack || casts) else {
    // rust: continue;
}
    // rust: let start = self.scratch.len() as u32;
    // rust: match part {
    // rust: Part::Beam => beam_segments(run, &mut self.scratch),
    // rust: _ => self.scratch.extend_from_slice(run),
}
    // rust: if program == DESTROY {
    // rust: project_cracks(&mut self.scratch[start as usize..], crack.0, crack.1);
}
    // rust: if part == Part::Portal {
    // rust: as_portal_texture(&mut self.scratch[start as usize..]);
}
    // rust: let vertices = self.scratch.len() as u32 - start;
    // rust: let overlay = self.scratch[start as usize].layer & 0xffff;
    // rust: let portal = part == Part::Portal;
    // rust: self.push_draw(
    // rust: span,
    // rust: posed + start,
    // rust: vertices,
    // rust: program,
    // rust: pack,
    // rust: casts,
    // rust: overlay,
    // rust: portal,
    // rust: );
}
}
    // rust: if self.draws.is_empty() && posed == 0 {
    // rust: return;
}
    // rust: let vertex_size = std::mem::size_of::<Vertex>() as u64;
    // rust: let (need_vertices, need_slots) = (
    // rust: u64::from(posed) + self.scratch.len() as u64,
    // rust: self.draws.len() as u64,
    // rust: );
    // rust: let have_vertices = self.vertices.size() / vertex_size;
    // rust: let have_slots = self.slots.size() / self.stride;
    // rust: if need_vertices > have_vertices {
    // rust: (self.vertices, self.table_group) =
    // rust: Self::vertex_buffer(device, &self.table, need_vertices.next_power_of_two());
}
    // rust: if need_slots > have_slots {
    // rust: (self.slots, self.group) =
    // rust: Self::slot_buffer(device, layout, need_slots.next_power_of_two(), self.stride);
}
    // rust: let quads = self.draws.iter().map(|d| d.quads).max().unwrap_or(0);
    // rust: if quads > self.quads {
    // rust: self.quads = quads.next_power_of_two();
    // rust: self.indices = quad_indices(device, self.quads);
}
    // rust: if !self.scratch.is_empty() {
    // rust: queue.write_buffer(
    // rust: &self.vertices,
    // rust: u64::from(posed) * vertex_size,
    // rust: bytemuck::cast_slice(&self.scratch),
    // rust: );
}
    // rust: if !self.uniforms.is_empty() {
    // rust: queue.write_buffer(&self.slots, 0, &self.uniforms);
}
}

    // rust: fn push_draw(
    // rust: &mut self,
    // rust: span: EntitySpan,
    // rust: start: u32,
    // rust: vertices: u32,
    // rust: program: usize,
    // rust: pack: bool,
    // rust: casts: bool,
    // rust: overlay: u32,
    // rust: portal: bool,
    // rust: ) {
    // rust: let (entity_id, block_id) = match program {
    // rust: BLOCK => (0, span.id),
    // rust: _ => (span.id, 0),
}
    // rust: let mut bytes = [0u8; SLOT as usize];
    // rust: bytes[0..4].copy_from_slice(&(span.stage as i32).to_le_bytes());
    // rust: bytes[4..8].copy_from_slice(&entity_id.to_le_bytes());
    // rust: bytes[8..12].copy_from_slice(&block_id.to_le_bytes());
        // The overlay: the layer's low 16 bits (HDR output's tier rides in the high ones).
    // rust: for (i, c) in entity_color(overlay & 0xffff).iter().enumerate() {
    // rust: bytes[16 + 4 * i..20 + 4 * i].copy_from_slice(&c.to_le_bytes());
}
    // rust: self.uniforms.extend_from_slice(&bytes);
    // rust: self.uniforms
    // rust: .resize(self.uniforms.len() + (self.stride - SLOT) as usize, 0);
    // rust: self.draws.push(Draw {
    // rust: base: start,
    // rust: quads: vertices / 4,
    // rust: program,
    // rust: pack,
    // rust: shadow: casts,
    // rust: slot: self.draws.len() as u32,
    // rust: portal,
    // rust: });
}
}

/// Two triangles for each of `quads` quads, from vertex 0.
    // rust: pub(super) fn quad_indices(device: &wgpu::Device, quads: u32) -> wgpu::Buffer {
    // rust: let indices: Vec<u32> = (0..quads)
    // rust: .flat_map(|q| [0, 1, 2, 0, 2, 3].map(|i| q * 4 + i))
    // rust: .collect();
    // rust: wgpu::util::DeviceExt::create_buffer_init(
    // rust: device,
    // rust: &wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Shader pack entity indices"),
    // rust: contents: bytemuck::cast_slice(&indices),
    // rust: usage: wgpu::BufferUsages::INDEX,
    // rust: },
    // rust: )
}

/// Whether a run holds only geometry a gbuffers program can draw from the shared atlas: no
/// celestial body, cloud, beam, End portal, crack or energy swirl (overlay codes Horizon's entity
/// shader draws in its own way; entity.wgsl).
pub fn plain(run: *[Vertex]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: run.iter()
    // rust: .step_by(4)
    // rust: .all(|v| !matches!(v.layer & 0xffff, 2 | 4 | 6 | 9 | 10 | 11 | 12 | 34))
}

/// What part of a block entity's run goes to which program (`prepare`).
pub const Part = enum {
    Plain,
    Portal,
    Beam,
};

/// Beam faces (`block_entity_render::beam`: layer 6, v counting the sprite's repeats up the
/// beam, the sprite's v range in the light bytes) for a pack: each face cut where its texture
/// repeats, so every piece holds one copy of the sprite in plain atlas coordinates (at most 64
/// pieces a face; a taller beam stretches its copies), white light and its colour kept.
pub fn beam_segments(run: *[Vertex], out: *mut std.ArrayList(Vertex)) void {
}
    // rust: for quad in run.as_chunks::<4>().0 {
    // rust: let wrap = quad[0].light;
    // rust: let (v0, size) = (
    // rust: (wrap & 65535) as f32 / 65535.0,
    // rust: (wrap >> 16) as f32 / 65535.0,
    // rust: );
        // Corners 0 and 3 at the beam's end (v1), 1 and 2 at its start (v2); 0 and 1 on one
        // side, 2 and 3 on the other.
    // rust: let (v1, v2) = (quad[0].uv[1], quad[1].uv[1]);
    // rust: if (v1 - v2).abs() < 1e-6 {
    // rust: continue;
}
    // rust: let (lo, hi) = (v1.min(v2), v1.max(v2));
    // rust: let first = lo.floor();
    // rust: let repeats = (hi.ceil() - first).max(1.0);
    // rust: let step = (repeats / 64.0).ceil().max(1.0);
    // rust: let pieces = (repeats / step).ceil() as u32;
    // rust: let at = |side: usize, v: f32| {
    // rust: let (a, b) = if side == 0 {
    // rust: (quad[1], quad[0])
    // rust: } else {
    // rust: (quad[2], quad[3])
}
    // rust: let t = (v - v2) / (v1 - v2);
    // rust: glam::Vec3::from(a.pos)
    // rust: .lerp(glam::Vec3::from(b.pos), t)
    // rust: .to_array()
}
    // rust: for k in 0..pieces {
    // rust: let base = first + k as f32 * step;
    // rust: let (a, b) = (base.max(lo), (base + step).min(hi));
    // rust: if b <= a {
    // rust: continue;
}
            // The end-side corners take the piece's bound nearer v1.
    // rust: let (end_v, start_v) = if v1 > v2 { (b, a) } else { (a, b) };
    // rust: for (i, corner) in quad.iter().enumerate() {
    // rust: let side = usize::from(i >= 2);
    // rust: let v = if i == 0 || i == 3 { end_v } else { start_v };
    // rust: let mut out_v = *corner;
    // rust: out_v.pos = at(side, v);
    // rust: out_v.uv = [corner.uv[0], v0 + (v - base) / step * size];
    // rust: out_v.layer = 0;
    // rust: out_v.light = 0x0000_f0f0;
    // rust: out.push(out_v);
}
}
}
}

/// `run` added to Horizon's own draw without End portal faces: under a shader pack Horizon's
/// entity shader would put its screen-projected starfield into the pack's buffers as if they
/// were its own frame (misplaced where the pack renders at another size), so a portal the pack
/// does not draw (its programs not there, or not yet) is better left out.
pub fn extend_without_portals(rest: *mut std.ArrayList(Vertex), run: *[Vertex]) void {
}
    // rust: for quad in run.chunks(4) {
    // rust: if !quad.iter().all(|v| matches!(v.layer & 0xffff, 6 | 9 | 10)) {
    // rust: rest.extend_from_slice(quad);
}
}
}

/// End portal faces for a pack's `gbuffers_block` (block entities): each face textured with the
/// whole of `end_portal.png`, which the draw binds as the atlas (a texture of its own, so a
/// pack's own portal effect can wrap it), white, at full light; the pack tells the portal by its
/// `blockEntityId`.
pub fn as_portal_texture(run: *mut [Vertex]) void {
}
pub const CORNERS: [[f32; 2]; 4] = [[0.0, 0.0], [0.0, 1.0], [1.0, 1.0], [1.0, 0.0]];
    // rust: for (i, v) in run.iter_mut().enumerate() {
    // rust: v.uv = CORNERS[i % 4];
    // rust: v.layer = 0;
    // rust: v.color = 0xFFFF_FFFF;
    // rust: v.light = 0x0000_f0f0;
}
}

/// The programs of entity runs, in the order they draw.
pub const ENTITY: usize = 0;
pub const BLOCK: usize = 1;
pub const TRANSLUCENT: usize = 2;
pub const PARTICLE: usize = 3;
pub const DESTROY: usize = 4;
/// Beacon and End gateway beams (`gbuffers_beaconbeam`).
pub const BEAM: usize = 5;
pub const PROGRAMS: usize = 6;

/// Which program draws `span`'s run, given which of them (or their fallbacks) the pack has;
/// `None`: Horizon draws it.
pub fn drawn_by_pack(span: *EntitySpan, drawn: [bool; PROGRAMS]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: program_of(span).filter(|&p| drawn[p])
}

/// The kind of program that draws `span`'s run, when a pack may.
pub fn program_of(span: *EntitySpan) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(if span.stage == render_stage("ENTITIES") {
    // rust: if span.translucent {
    // rust: TRANSLUCENT
    // rust: } else {
    // rust: ENTITY
}
    // rust: } else if span.stage == render_stage("BLOCK_ENTITIES") {
    // rust: BLOCK
    // rust: } else if span.stage == render_stage("PARTICLES") {
    // rust: PARTICLE
    // rust: } else if span.stage == render_stage("DESTROY") {
    // rust: DESTROY
    // rust: } else {
    // rust: return None;
    // rust: })
}

/// Each span with its vertex range: from its start to the next span's (or the end).
    // rust: pub fn runs(
    // rust: len: usize,
    // rust: spans: &[EntitySpan],
    // rust: ) -> impl Iterator<Item = (EntitySpan, Range<usize>)> + '_ {
    // rust: spans.iter().enumerate().map(move |(i, s)| {
    // rust: let end = spans.get(i + 1).map_or(len, |n| n.start as usize);
    // rust: let start = (s.start as usize).min(len);
    // rust: (*s, start..end.clamp(start, len))
    // rust: })
}

    // rust: mod tests {
//     use super::*;

pub fn destroy_stage_uses_the_pack_only_when_a_program_is_available() void {
}
    // rust: let destroy = EntitySpan {
    // rust: stage: render_stage("DESTROY"),
    // rust: ..Default::default()
}
    // rust: assert!(drawn_by_pack(&destroy, [true; PROGRAMS]).is_some());
    // rust: assert_eq!(drawn_by_pack(&destroy, [false; PROGRAMS]), None);
}

pub fn runs_split_the_list_between_pack_and_horizon() void {
}
    // rust: let v = |layer| Vertex {
    // rust: layer,
    // rust: ..bytemuck::Zeroable::zeroed()
}
    // rust: let span = |start, stage: &str, id| EntitySpan {
    // rust: start,
    // rust: stage: render_stage(stage),
    // rust: id,
    // rust: ..Default::default()
}
    // rust: let spans = [
    // rust: span(2, "ENTITIES", 7),
    // rust: span(5, "PARTICLES", 0),
    // rust: span(6, "BLOCK_ENTITIES", 9),
    // rust: ];
    // rust: let ranges: Vec<_> = runs(10, &spans).map(|(_, r)| r).collect();
    // rust: assert_eq!(ranges, [2..5, 5..6, 6..10]);
    // rust: let all = [true; PROGRAMS];
    // rust: assert_eq!(drawn_by_pack(&spans[0], all), Some(ENTITY));
    // rust: assert_eq!(drawn_by_pack(&spans[1], all), Some(PARTICLE));
    // rust: assert_eq!(
    // rust: drawn_by_pack(&spans[1], [true, true, true, false, true, true]),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: drawn_by_pack(&spans[2], [true, false, true, true, true, true]),
    // rust: None
    // rust: );
    // rust: assert_eq!(drawn_by_pack(&spans[2], all), Some(BLOCK));
    // rust: let shadow = EntitySpan {
    // rust: translucent: true,
    // rust: ..spans[0]
}
    // rust: assert_eq!(drawn_by_pack(&shadow, all), Some(TRANSLUCENT));
    // rust: assert_eq!(drawn_by_pack(&span(0, "DESTROY", 0), all), Some(DESTROY));
        // A beacon beam's quads stay Horizon's.
    // rust: assert!(plain(&[v(0), v(0), v(0), v(0), v(1)]));
    // rust: assert!(!plain(&[v(0), v(0), v(0), v(0), v(6)]));
    // rust: assert_eq!(entity_color(1)[0], 1.0);
    // rust: assert!((entity_color(1)[3] - (1.0 - 178.0 / 255.0)).abs() < 1e-6);
    // rust: assert_eq!(entity_color(0), [0.0; 4]);
        // The shadow pass: entities, the player alone, block entities, those that emit light.
    // rust: let all = Casters {
    // rust: entities: true,
    // rust: blocks: true,
    // rust: ..Default::default()
}
    // rust: let player = EntitySpan {
    // rust: player: true,
    // rust: ..spans[0]
}
    // rust: let lit = EntitySpan {
    // rust: emissive: true,
    // rust: ..spans[2]
}
    // rust: assert!(all.cast(&spans[0], ENTITY) && all.cast(&spans[2], BLOCK));
    // rust: assert!(!all.cast(&spans[1], PARTICLE));
    // rust: let some = Casters {
    // rust: only_player: true,
    // rust: only_lit: true,
    // rust: ..all
}
    // rust: assert!(!some.cast(&spans[0], ENTITY) && some.cast(&player, ENTITY));
    // rust: assert!(!some.cast(&spans[2], BLOCK) && some.cast(&lit, BLOCK));
}
}

/// Decode the destroy-stage origin stored in the light bytes and project one continuous
/// sprite over each model face. Pack geometry uses ordinary atlas UVs, not Horizon's overlay codes.
pub fn project_cracks(vertices: *mut [Vertex], sprite: [f32; 4], atlas: [u32; 2]) void {
}
    // rust: let dims = [atlas[0].max(1) as f32, atlas[1].max(1) as f32];
    // rust: for quad in vertices.as_chunks_mut::<4>().0 {
    // rust: let origin = [
    // rust: (quad[0].light & 65535) as f32 / 65535.0,
    // rust: (quad[0].light >> 16) as f32 / 65535.0,
    // rust: ];
    // rust: let origin = [0, 1].map(|i| (origin[i] * dims[i]).round() / dims[i]);
    // rust: let min = [0, 1]
    // rust: .map(|i| (quad.iter().map(|v| v.uv[i]).fold(f32::INFINITY, f32::min) + 0.0001).floor());
    // rust: for v in quad {
    // rust: v.uv =
    // rust: [0, 1].map(|i| origin[i] + (v.uv[i] - min[i]).clamp(0.001, 0.999) * sprite[i + 2]);
    // rust: v.layer = 0;
    // rust: v.light = 0x0000_f0f0;
}
}
}

    // rust: mod portal_beam_tests {
//     use super::*;

pub fn quad(layer: u32, light: u32, corners: [([f32; 3]) void {
}
    // rust: corners.map(|(pos, uv)| Vertex {
    // rust: pos,
    // rust: uv,
    // rust: layer,
    // rust: color: 0xFF20_40FF,
    // rust: light,
    // rust: ..bytemuck::Zeroable::zeroed()
    // rust: })
}

pub fn a_beam_face_becomes_one_sprite_copy_per_repeat() void {
}
        // `block_entity_render::beam`'s corner order: 0 and 3 at the end (v1), 1 and 2 at the
        // start (v2); the sprite's v range (0.25, height 0.5) in the light bytes.
    // rust: let wrap = (0.25f32 * 65535.0).round() as u32 | ((0.5f32 * 65535.0).round() as u32) << 16;
    // rust: let face = quad(
    // rust: 6,
    // rust: wrap,
    // rust: [
    // rust: ([0.0, 3.0, 0.0], [0.9, 3.0]),
    // rust: ([0.0, 0.0, 0.0], [0.9, 0.0]),
    // rust: ([1.0, 0.0, 0.0], [0.1, 0.0]),
    // rust: ([1.0, 3.0, 0.0], [0.1, 3.0]),
    // rust: ],
    // rust: );
    // rust: let mut out = Vec::new();
    // rust: beam_segments(&face, &mut out);
    // rust: assert_eq!(out.len(), 12, "three repeats, three pieces");
    // rust: for (k, piece) in out.chunks(4).enumerate() {
    // rust: let (bottom, top) = (k as f32, k as f32 + 1.0);
    // rust: assert_eq!([piece[0].pos[1], piece[1].pos[1]], [top, bottom]);
    // rust: assert_eq!([piece[2].pos[1], piece[3].pos[1]], [bottom, top]);
    // rust: for v in piece {
    // rust: assert!((0.25 - 1e-4..=0.75 + 1e-4).contains(&v.uv[1]), "{:?}", v.uv);
    // rust: assert_eq!(v.layer, 0);
    // rust: assert_eq!(v.light, 0x0000_f0f0);
    // rust: assert_eq!(v.color, 0xFF20_40FF);
}
    // rust: assert!((piece[0].uv[1] - 0.75).abs() < 1e-4 && (piece[1].uv[1] - 0.25).abs() < 1e-4);
    // rust: assert_eq!([piece[0].uv[0], piece[2].uv[0]], [0.9, 0.1]);
}
}

pub fn a_very_tall_beam_is_cut_into_at_most_64_pieces() void {
}
    // rust: let face = quad(
    // rust: 6,
    // rust: 0xFFFF_0000,
    // rust: [
    // rust: ([0.0, 2000.0, 0.0], [1.0, 2000.0]),
    // rust: ([0.0, 0.0, 0.0], [1.0, 0.0]),
    // rust: ([1.0, 0.0, 0.0], [0.0, 0.0]),
    // rust: ([1.0, 2000.0, 0.0], [0.0, 2000.0]),
    // rust: ],
    // rust: );
    // rust: let mut out = Vec::new();
    // rust: beam_segments(&face, &mut out);
    // rust: assert!(out.len() / 4 <= 64, "{} pieces", out.len() / 4);
    // rust: let top = out.iter().map(|v| v.pos[1]).fold(f32::MIN, f32::max);
    // rust: let bottom = out.iter().map(|v| v.pos[1]).fold(f32::MAX, f32::min);
    // rust: assert_eq!(
    // rust: (bottom, top),
    // rust: (0.0, 2000.0),
    // rust: "the pieces still span the whole beam"
    // rust: );
}

pub fn portal_faces_take_the_whole_portal_texture_at_full_light() void {
}
    // rust: let mut face = quad(9, 0, [([0.0; 3], [0.0; 2]); 4]).to_vec();
    // rust: as_portal_texture(&mut face);
    // rust: let uvs: Vec<[f32; 2]> = face.iter().map(|v| v.uv).collect();
    // rust: assert_eq!(uvs, [[0.0, 0.0], [0.0, 1.0], [1.0, 1.0], [1.0, 0.0]]);
    // rust: assert!(
    // rust: face.iter()
    // rust: .all(|v| v.layer == 0 && v.color == 0xFFFF_FFFF && v.light == 0x0000_f0f0)
    // rust: );
}

pub fn horizon_keeps_no_portal_or_beam_face_under_a_pack() void {
}
    // rust: let mut run = Vec::new();
    // rust: for layer in [0, 6, 9, 10, 2] {
    // rust: run.extend(quad(layer, 0, [([0.0; 3], [0.0; 2]); 4]));
}
    // rust: let mut rest = Vec::new();
    // rust: extend_without_portals(&mut rest, &run);
    // rust: let kept: Vec<u32> = rest.chunks(4).map(|q| q[0].layer).collect();
    // rust: assert_eq!(kept, [0, 2]);
}
}

    // rust: mod crack_projection_tests {
//     use super::*;
pub fn crack_uvs_keep_a_full_sprite_and_decode_each_stage() void {
}
    // rust: let mut vertices: Vec<Vertex> = [[-1.0, -1.0], [-1.0, 0.0], [0.0, 0.0], [0.0, -1.0]]
    // rust: .into_iter()
    // rust: .map(|uv| Vertex {
    // rust: uv,
    // rust: layer: 11,
    // rust: light: crate::breaking::stage_light([0.25, 0.5]),
    // rust: ..bytemuck::Zeroable::zeroed()
    // rust: })
    // rust: .collect();
    // rust: project_cracks(
    // rust: &mut vertices,
    // rust: [0.0, 0.0, 16.0 / 4096.0, 16.0 / 9216.0],
    // rust: [4096, 9216],
    // rust: );
    // rust: assert!(
    // rust: vertices
    // rust: .iter()
    // rust: .all(|v| v.layer == 0 && v.uv[0] >= 0.25 && v.uv[0] < 0.25 + 16.0 / 4096.0)
    // rust: );
    // rust: assert!((vertices[2].uv[0] - vertices[0].uv[0]) > 15.0 / 4096.0);
    // rust: assert!((vertices[1].uv[1] - vertices[0].uv[1]) > 15.0 / 9216.0);
}
}

/// Intersects shader identities with overlay runs, without reading posed vertices back.
pub fn skin_runs(skin: *super::entity_skin::SkinFrame) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: Vec<(EntitySpan, Range<u32>, u32)> = Vec::new();
    // rust: let mut span_index = 0;
    // rust: for job in &skin.jobs {
    // rust: let mut at = job.dst;
    // rust: let end = at + job.count;
    // rust: while at < end {
    // rust: while span_index + 1 < skin.spans.len() && skin.spans[span_index + 1].start <= at {
    // rust: span_index += 1;
}
    // rust: let Some(&span) = skin.spans.get(span_index) else {
    // rust: break;
}
    // rust: let stop = end.min(skin.spans.get(span_index + 1).map_or(end, |s| s.start));
    // rust: if stop <= at {
    // rust: break;
}
    // rust: if let Some((old, range, overlay)) = out.last_mut()
    // rust: && (EntitySpan { start: 0, ..*old }) == (EntitySpan { start: 0, ..span })
    // rust: && *overlay == job.overlay
    // rust: && range.end == at
    // rust: {
    // rust: range.end = stop;
    // rust: } else {
    // rust: out.push((span, at..stop, job.overlay));
}
    // rust: at = stop;
}
}
    // rust: out
}

    // rust: mod gpu_span_tests {
//     use super::*;
//     use crate::gfx::entity_skin::{SkinFrame, SkinJob};
pub fn posed_draws_preserve_subject_ids_overlays_and_hidden_shadow_casters() void {
}
    // rust: let mut skin = SkinFrame {
    // rust: vertices: 24,
    // rust: ..Default::default()
}
    // rust: skin.spans = vec![
    // rust: EntitySpan {
    // rust: start: 0,
    // rust: stage: render_stage("ENTITIES"),
    // rust: id: 40,
    // rust: ..Default::default()
    // rust: },
    // rust: EntitySpan {
    // rust: start: 12,
    // rust: stage: render_stage("ENTITIES"),
    // rust: id: 41,
    // rust: hidden: true,
    // rust: ..Default::default()
    // rust: },
    // rust: ];
    // rust: skin.jobs = vec![
    // rust: SkinJob {
    // rust: dst: 0,
    // rust: count: 4,
    // rust: overlay: 1,
    // rust: ..Default::default()
    // rust: },
    // rust: SkinJob {
    // rust: dst: 4,
    // rust: count: 4,
    // rust: overlay: 1,
    // rust: ..Default::default()
    // rust: },
    // rust: SkinJob {
    // rust: dst: 8,
    // rust: count: 12,
    // rust: overlay: 5,
    // rust: ..Default::default()
    // rust: },
    // rust: SkinJob {
    // rust: dst: 20,
    // rust: count: 4,
    // rust: overlay: 5,
    // rust: ..Default::default()
    // rust: },
    // rust: ];
    // rust: let runs = skin_runs(&skin);
    // rust: assert_eq!(
    // rust: runs.iter()
    // rust: .map(|(s, r, o)| (s.id, r.clone(), *o, s.hidden))
    // rust: .collect::<Vec<_>>(),
    // rust: [
    // rust: (40, 0..8, 1, false),
    // rust: (40, 8..12, 5, false),
    // rust: (41, 12..24, 5, true)
    // rust: ]
    // rust: );
    // rust: assert_eq!(entity_color(runs[0].2)[3], 0.30196077);
    // rust: assert!(
    // rust: Casters {
    // rust: entities: true,
    // rust: ..Default::default()
}
    // rust: .cast(&runs[2].0, ENTITY)
    // rust: );
    // rust: skin.truncate((2, 0, 8));
    // rust: assert_eq!(skin.vertices, 8);
    // rust: assert_eq!(skin.spans.len(), 1);
}

pub fn end_portal_faces_reach_the_shadow_pass_with_their_block_entity() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let Ok((device, queue)) = pollster::block_on(adapter.request_device(&Default::default()))
    // rust: else {
    // rust: return;
}
    // rust: let layout = super::super::pack_draw::DrawUniforms::new(&device);
    // rust: let mut geometry = PackEntities::new(&device, &layout.layout);
        // One block entity: a plain face, then an End portal face (overlay layer 9).
    // rust: let cpu: Vec<Vertex> = [0, 0, 0, 0, 9, 9, 9, 9]
    // rust: .into_iter()
    // rust: .map(|layer| Vertex {
    // rust: layer,
    // rust: ..bytemuck::Zeroable::zeroed()
    // rust: })
    // rust: .collect();
    // rust: let spans = [EntitySpan {
    // rust: start: 0,
    // rust: id: 99,
    // rust: stage: render_stage("BLOCK_ENTITIES"),
    // rust: ..Default::default()
    // rust: }];
    // rust: let mut rest = Vec::new();
    // rust: geometry.prepare(
    // rust: &device,
    // rust: &queue,
    // rust: &layout.layout,
    // rust: &cpu,
    // rust: &spans,
    // rust: [true; PROGRAMS],
    // rust: ([0.; 4], [1; 2]),
    // rust: Casters {
    // rust: blocks: true,
    // rust: ..Default::default()
    // rust: },
    // rust: &mut rest,
    // rust: None,
    // rust: );
    // rust: assert_eq!(
    // rust: (geometry.draws.iter())
    // rust: .map(|d| (d.portal, d.shadow))
    // rust: .collect::<Vec<_>>(),
    // rust: [(false, true), (true, true)],
    // rust: "the portal face casts as its block entity does"
    // rust: );
}

pub fn posed_and_cpu_draws_keep_offsets_uniforms_and_special_fallbacks() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let Ok((device, queue)) = pollster::block_on(adapter.request_device(&Default::default()))
    // rust: else {
    // rust: return;
}
    // rust: let layout = super::super::pack_draw::DrawUniforms::new(&device);
    // rust: let mut geometry = PackEntities::new(&device, &layout.layout);
    // rust: let entity = |start, id| EntitySpan {
    // rust: start,
    // rust: id,
    // rust: stage: render_stage("ENTITIES"),
    // rust: ..Default::default()
}
    // rust: let mut skin = SkinFrame {
    // rust: vertices: 12,
    // rust: spans: vec![
    // rust: entity(0, 40),
    // rust: EntitySpan {
    // rust: hidden: true,
    // rust: ..entity(4, 41)
    // rust: },
    // rust: EntitySpan {
    // rust: start: 8,
    // rust: id: 99,
    // rust: stage: render_stage("BLOCK_ENTITIES"),
    // rust: emissive: true,
    // rust: ..Default::default()
    // rust: },
    // rust: ],
    // rust: jobs: [1 | (2 << 16), 5, 0]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(i, overlay)| SkinJob {
    // rust: dst: i as u32 * 4,
    // rust: count: 4,
    // rust: overlay,
    // rust: ..Default::default()
    // rust: })
    // rust: .collect(),
    // rust: ..Default::default()
}
    // rust: let cpu = vec![
    // rust: Vertex {
    // rust: layer: 0,
    // rust: ..bytemuck::Zeroable::zeroed()
}
    // rust: 8
    // rust: ];
    // rust: let spans = [entity(4, 50)];
    // rust: let mut rest = Vec::new();
    // rust: let shadows = Casters {
    // rust: entities: true,
    // rust: blocks: true,
    // rust: ..Default::default()
}
    // rust: geometry.prepare(
    // rust: &device,
    // rust: &queue,
    // rust: &layout.layout,
    // rust: &cpu,
    // rust: &spans,
    // rust: [true; PROGRAMS],
    // rust: ([0.; 4], [1; 2]),
    // rust: shadows,
    // rust: &mut rest,
    // rust: Some(&skin),
    // rust: );
    // rust: assert_eq!(rest.len(), 4, "untagged CPU prefix stays in Horizon's draw");
    // rust: assert_eq!(geometry.scratch.len(), 4, "only CPU geometry is uploaded");
    // rust: assert_eq!(
    // rust: geometry
    // rust: .draws
    // rust: .iter()
    // rust: .map(|d| (d.base, d.quads, d.pack, d.shadow))
    // rust: .collect::<Vec<_>>(),
    // rust: [
    // rust: (0, 1, true, true),
    // rust: (4, 1, false, true),
    // rust: (8, 1, true, true),
    // rust: (12, 1, true, true)
    // rust: ]
    // rust: );
    // rust: let slot = |i: usize| &geometry.uniforms[i * geometry.stride as usize..][..SLOT as usize];
    // rust: let word = |bytes: &[u8], at| i32::from_le_bytes(bytes[at..at + 4].try_into().unwrap());
    // rust: assert_eq!((word(slot(0), 4), word(slot(0), 8)), (40, 0));
    // rust: assert_eq!((word(slot(1), 4), word(slot(1), 8)), (41, 0));
    // rust: assert_eq!((word(slot(2), 4), word(slot(2), 8)), (0, 99));
    // rust: assert_eq!((word(slot(3), 4), word(slot(3), 8)), (50, 0));
    // rust: let hurt: &[f32] = bytemuck::cast_slice(&slot(0)[16..32]);
    // rust: assert_eq!(&hurt[..3], &[1.0, 0.0, 0.0]);
    // rust: assert!((hurt[3] - 77.0 / 255.0).abs() < 1e-6);
    // rust: let flash: &[f32] = bytemuck::cast_slice(&slot(1)[16..32]);
    // rust: assert_eq!(&flash[..3], &[1.0, 1.0, 1.0]);
    // rust: assert!((flash[3] - 192.0 / 255.0).abs() < 1e-6);
    // rust: assert_eq!(word(slot(2), 0), render_stage("BLOCK_ENTITIES") as i32);

    // rust: let mut special = cpu.clone();
    // rust: special[4..].iter_mut().for_each(|v| v.layer = 2);
    // rust: geometry.prepare(
    // rust: &device,
    // rust: &queue,
    // rust: &layout.layout,
    // rust: &special,
    // rust: &spans,
    // rust: [true; PROGRAMS],
    // rust: ([0.; 4], [1; 2]),
    // rust: shadows,
    // rust: &mut rest,
    // rust: None,
    // rust: );
    // rust: assert!(geometry.draws.is_empty());
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<_, u8>(&rest),
    // rust: bytemuck::cast_slice::<_, u8>(&special)
    // rust: );

        // Culling can retain hidden jobs for a pack whose entity caster is absent.
        // The compute output must still fit, even though no visible/shadow draw uses it.
    // rust: skin.vertices = 5000;
    // rust: skin.jobs.truncate(1);
    // rust: skin.jobs[0].count = 5000;
    // rust: skin.spans = vec![EntitySpan {
    // rust: hidden: true,
    // rust: ..entity(0, 60)
    // rust: }];
    // rust: geometry.prepare(
    // rust: &device,
    // rust: &queue,
    // rust: &layout.layout,
    // rust: &[],
    // rust: &[],
    // rust: [false; PROGRAMS],
    // rust: ([0.; 4], [1; 2]),
    // rust: Casters::default(),
    // rust: &mut rest,
    // rust: Some(&skin),
    // rust: );
    // rust: assert!(geometry.draws.is_empty());
    // rust: assert!(geometry.skin_target().size() >= 5000 * 44);
}
}
