//! Transpiled from Horizon Rust crate
package horizon_client_render_entity_skin

import "core:fmt"
import "core:mem"
import "core:math"

// Entity models posed on the GPU. The CPU path (`mobs::render::draw`) walks a
// model's parts and pushes every vertex of every polygon, transformed by its
// part's matrix: ~280 vertices of 44 bytes per mob, then copied by material
// and uploaded each frame. Here each model's vertices are uploaded once, in
// model space, and a frame only sends each drawn part's matrices and one job
// per run of drawn parts; `entity_skin.wgsl` writes the same vertices, in the
// same order, into the entity vertex buffer, after the CPU's ordinary entities
// (`EntityBatch` leaves the gap). Every pass that draws ordinary entities
// then draws them as before.
//
// The game decides which draws come here (`SkinFrame`): models whose
// polygons all face an axis, drawn as ordinary opaque or cutout entities.
// The rest stays on the CPU path. Item models come too ([`SkinJob::item`]):
// their quads all face an axis, and their shading is baked into the colour.

// use super::upload::Uploads;
// use crate::mesher::Vertex;

// A model vertex: position / 16, model UV, the face's normal as an axis (0..2
// = +x, +y, +z; 3..5 = -x, -y, -z), the part's index in its model.
SkinVertex :: struct {
    pos: [f32,
    uv: [f32,
    axis: u32,
    part: u32,
}

// A drawn part: its geometry matrix and its normal matrix, by columns, the
// normal matrix's columns normalized when the part's scale is not uniform.
SkinPart :: struct {
    matrix: [f32,
    normal: [f32,
}

    // rust: impl SkinPart {
    // An item layer's part: its pose, and its quads' colours by axis.
item :: proc(matrix: glam::Mat4, colors: [u32; 6]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut normal = [0.0; 9];
    // rust: for (word, color) in normal.iter_mut().zip(colors) {
    // rust: *word = f32::from_bits(color);
}
    // rust: Self {
    // rust: matrix: matrix.to_cols_array(),
    // rust: normal,
}
}
}

// One run of a model's vertices drawn with one texture rect, colour, light
// and overlay. `dst` counts from the frame's first posed vertex.
SkinJob :: struct {
    first: u32,
    count: u32,
    part: u32,
    dst: u32,
    rect: [f32,
    scroll: f32,
    color: u32,
    light: u32,
    overlay: u32,
    // 1 when the overlay is the armour glint: the model UV rides in `glint_uv`.
    glint: u32,
    // How the vertices are finished: [`SkinJob::MODEL`], [`SkinJob::ITEM`] or
    // [`SkinJob::FLAT`].
    mode: u32,
    // 1 for a model whose render type culls back faces (`mobs::Polygon::cull_back`):
    // the normal's w is `mesher::SHADED_CULL_W` instead of -127.
    cull: u32,
    // Always 0: the shader reads it as a zero it cannot fold away.
    spare: u32,
}

    // rust: impl SkinJob {
    // A model's polygons: the face normal posed, the job's colour.
MODEL :: 0
    // An item model's quads (`item_render::WorldSink`): the colour by the face's
    // axis rides in the part's first 6 normal words ([`SkinPart::item`]), shaded on
    // the CPU, and the normal is `mesher::CULL_BACK`.
ITEM :: 1
    // A model's polygons with no normal at all (all four bytes 0): the eyes render
    // type's layers, which entity.wgsl leaves unshaded.
FLAT :: 2
}

_ :: assert!(std::mem::size_of::<Vertex>() == 44)
_ :: assert!(std::mem::size_of::<SkinVertex>() == 7 * 4)
_ :: assert!(std::mem::size_of::<SkinPart>() == 25 * 4)
_ :: assert!(std::mem::size_of::<SkinJob>() == 16 * 4)

// What the game hands the renderer for one frame.
SkinFrame :: struct {
    // The model store restarted (models are registered again from 0).
    reset: bool,
    // The store's size before `new_model`: the renderer takes the frame only
    // when its own store is that large (it missed none of the earlier ones).
    base: u32,
    // Model vertices registered since the last frame, at the store's end.
    new_model: [dynamic]SkinVertex,
    parts: [dynamic]SkinPart,
    jobs: [dynamic]SkinJob,
    // Shader identities in the GPU output vertex space; empty without a pack.
    spans: [dynamic]super::pack_draw::EntitySpan,
    // Vertices the jobs write: a whole number of quads.
    vertices: u32,
    // Glowing entities' silhouettes posed here (`OutlineBufferSource`'s copy of
    // their draws, [`SkinFrame::outline_since`]): `dst` counts from the first.
    outline_jobs: [dynamic]SkinJob,
    // Vertices the outline jobs write.
    outline_vertices: u32,
}

    // rust: impl SkinFrame {
    // Starts a frame's draws; models not yet handed to the renderer stay.
clear_draws :: proc(self: ^Self) {
}
    // rust: self.parts.clear();
    // rust: self.jobs.clear();
    // rust: self.spans.clear();
    // rust: self.vertices = 0;
    // rust: self.outline_jobs.clear();
    // rust: self.outline_vertices = 0;
}

    // Copies the draws since job `first` into the glowing entities' outline
    // (`Frame::glowing`'s, on the GPU), as `glowing.rs`'s `mark_outline` copies
    // vertices: the same ones, in `color` (`Vertex::color`) with no normal.
outline_since :: proc(self: ^Self, first: uint, color: u32) {
}
    // rust: for i in first..self.jobs.len() {
    // rust: let job = self.jobs[i];
    // rust: self.outline_jobs.push(SkinJob {
    // rust: dst: self.outline_vertices,
    // rust: color,
    // rust: mode: SkinJob::FLAT,
    // rust: ..job
    // rust: });
    // rust: self.outline_vertices += job.count;
}
}

    // The renderer took the new models.
handed :: proc(self: ^Self) {
}
    // rust: self.base += self.new_model.len() as u32;
    // rust: self.new_model.clear();
    // rust: self.reset = false;
}

    // Where the draws stand, to take back a mob's (`truncate`).
mark :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (self.jobs.len(), self.parts.len(), self.vertices)
}

    // Takes back the draws since `mark` (a mob culled after drawing).
truncate :: proc(self: ^Self) {
}
    // rust: self.jobs.truncate(jobs);
    // rust: self.parts.truncate(parts);
    // rust: self.vertices = vertices;
    // rust: self.spans.retain(|s| s.start <= vertices);
}

    // Whether the renderer has anything to take.
pending :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.reset
    // rust: || !self.new_model.is_empty()
    // rust: || !self.jobs.is_empty()
    // rust: || !self.outline_jobs.is_empty()
}
}

// Jobs per row of workgroups (the dispatch limit is 65535 per dimension).
ROW :: 32_768

    // rust: pub(super) struct EntitySkin {
    // rust: pipeline: wgpu::ComputePipeline,
    // rust: layout: wgpu::BindGroupLayout,
    // rust: model: Vec<SkinVertex>,
    // rust: model_buffer: Option<wgpu::Buffer>,
    // rust: parts: Grow,
    // rust: jobs: Grow,
    // The jobs with `dst` moved to the frame's gap, as uploaded.
    // rust: staged: Vec<SkinJob>,
    // The bind group and the buffers it binds (buffers compare by identity).
    // rust: group: Option<(wgpu::BindGroup, [wgpu::Buffer; 4])>,
}

// A storage buffer that grows to the next power of two.
Grow :: struct {
    label: ^'static str,
    buffer: Maybe(wgpu::Buffer),
}

    // rust: impl Grow {
ensure :: proc(self: ^Self, device: ^wgpu::Device, bytes: u64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = bytes.max(256).next_power_of_two();
    // rust: if self.buffer.as_ref().is_some_and(|b| b.size() >= bytes) {
    // rust: return false;
}
    // rust: self.buffer = Some(device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(self.label),
    // rust: size: bytes,
    // rust: usage: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: }));
    // rust: true
}
}

    // rust: impl EntitySkin {
    // The entity vertex buffer's usage: the jobs write into it.
    // rust: pub(super) fn usage(skinning: bool) -> wgpu::BufferUsages {
    // rust: let usage = wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST;
    // rust: if skinning {
    // rust: usage | wgpu::BufferUsages::STORAGE
    // rust: } else {
    // rust: usage
}
}

    // The compute pipeline, or `None` without compute shaders (the CPU path
    // then draws every model).
    // rust: pub(super) fn new(device: &wgpu::Device, compute: bool) -> Option<Self> {
        // HORIZON_NO_ENTITY_SKIN: every model on the CPU path (A/B runs, a driver's bug).
    // rust: if !compute
    // rust: || device.limits().max_storage_buffers_per_shader_stage < 4
    // rust: || std::env::var_os("HORIZON_NO_ENTITY_SKIN").is_some()
    // rust: {
    // rust: return None;
}
    // rust: let validation = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let internal = device.push_error_scope(wgpu::ErrorFilter::Internal);
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Entity skinning"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("entity_skin.wgsl").into()),
    // rust: });
    // rust: let pipeline = device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    // rust: label: Some("Entity skinning"),
    // rust: layout: None,
    // rust: module: &module,
    // rust: entry_point: Some("skin"),
    // rust: compilation_options: Default::default(),
    // rust: cache: None,
    // rust: });
    // rust: let layout = pipeline.get_bind_group_layout(0);
    // rust: let internal = pollster::block_on(internal.pop());
    // rust: if let Some(e) = internal.or(pollster::block_on(validation.pop())) {
    // rust: log::warn!("Horizon renderer: entity models posed on the CPU ({e})");
    // rust: return None;
}
    // rust: Some(Self {
    // rust: pipeline,
    // rust: layout,
    // rust: model: Vec::new(),
    // rust: model_buffer: None,
    // rust: parts: Grow {
    // rust: label: "Entity skinning parts",
    // rust: buffer: None,
    // rust: },
    // rust: jobs: Grow {
    // rust: label: "Entity skinning jobs",
    // rust: buffer: None,
    // rust: },
    // rust: staged: Vec::new(),
    // rust: group: None,
    // rust: })
}

    // The model vertices stored (`SkinFrame::base` of the next frame).
    // rust: pub(super) fn stored(&self) -> u32 {
    // rust: self.model.len() as u32
}

    // Takes the frame's new models; whether its jobs can run (the store
    // holds every model they read).
    // rust: pub(super) fn register(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: uploads: &mut Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: frame: &SkinFrame,
    // rust: ) -> bool {
    // rust: if frame.reset {
    // rust: self.model.clear();
    // rust: self.model_buffer = None;
}
    // rust: if self.model.len() as u32 != frame.base {
            // Out of step with the game's store: it restarts it.
    // rust: return false;
}
    // rust: if frame.new_model.is_empty() {
    // rust: return self.model_buffer.is_some() || frame.jobs.is_empty();
}
    // rust: let old = self.model.len();
    // rust: self.model.extend_from_slice(&frame.new_model);
    // rust: let bytes = (self.model.len() * std::mem::size_of::<SkinVertex>()) as u64;
    // rust: if self
    // rust: .model_buffer
    // rust: .as_ref()
    // rust: .is_some_and(|b| b.size() >= bytes)
    // rust: {
    // rust: let buffer = self.model_buffer.as_ref().expect("checked");
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: buffer,
    // rust: (old * std::mem::size_of::<SkinVertex>()) as u64,
    // rust: bytemuck::cast_slice(&frame.new_model),
    // rust: );
    // rust: } else {
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Entity skinning models"),
    // rust: size: bytes.max(256).next_power_of_two(),
    // rust: usage: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: uploads.buffer(encoder, &buffer, 0, bytemuck::cast_slice(&self.model));
    // rust: self.model_buffer = Some(buffer);
}
    // rust: true
}

    // Records the frame's jobs: they write `frame.vertices` vertices into
    // `out` from vertex `base` on, and the outline jobs `frame.outline_vertices`
    // from vertex `outline_base` on. Call after the CPU vertices' upload.
    // rust: pub(super) fn dispatch(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: uploads: &mut Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: frame: &SkinFrame,
    // rust: out: &wgpu::Buffer,
    // rust: base: u32,
    // rust: outline_base: u32,
    // rust: ) {
    // rust: self.dispatch_jobs(
    // rust: device,
    // rust: uploads,
    // rust: encoder,
    // rust: &frame.parts,
    // rust: frame
    // rust: .jobs
    // rust: .iter()
    // rust: .map(|job| SkinJob {
    // rust: dst: job.dst + base,
    // rust: ..*job
    // rust: })
    // rust: .chain(frame.outline_jobs.iter().map(|job| SkinJob {
    // rust: dst: job.dst + outline_base,
    // rust: ..*job
    // rust: })),
    // rust: out,
    // rust: );
}

    // A standard pack owns the body output; glowing silhouettes keep the ordinary
    // entity buffer. Both routes use the same model/normal/back-face decoder.
    // rust: pub(super) fn dispatch_pack(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: uploads: &mut Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: frame: &SkinFrame,
    // rust: out: &wgpu::Buffer,
    // rust: outline_out: &wgpu::Buffer,
    // rust: outline_base: u32,
    // rust: ) {
    // rust: self.dispatch_jobs(
    // rust: device,
    // rust: uploads,
    // rust: encoder,
    // rust: &frame.parts,
    // rust: frame.jobs.iter().copied(),
    // rust: out,
    // rust: );
    // rust: self.dispatch_jobs(
    // rust: device,
    // rust: uploads,
    // rust: encoder,
    // rust: &frame.parts,
    // rust: frame.outline_jobs.iter().map(|job| SkinJob {
    // rust: dst: job.dst + outline_base,
    // rust: ..*job
    // rust: }),
    // rust: outline_out,
    // rust: );
}

    // rust: fn dispatch_jobs(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: uploads: &mut Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: parts: &[SkinPart],
    // rust: jobs: impl Iterator<Item = SkinJob>,
    // rust: out: &wgpu::Buffer,
    // rust: ) {
    // rust: self.staged.clear();
    // rust: self.staged.extend(jobs);
    // rust: if self.staged.is_empty() {
    // rust: return;
}
    // rust: let Some(model) = &self.model_buffer else {
    // rust: return;
}
        // Whole rows of workgroups past `ROW` jobs: the padding jobs write nothing.
    // rust: let count = self.staged.len() as u32;
    // rust: let rows = count.div_ceil(ROW);
    // rust: let padded = if rows > 1 {
    // rust: (rows * ROW) as usize
    // rust: } else {
    // rust: count as usize
}
    // rust: self.staged.resize(padded, SkinJob::default());
    // rust: self.parts
    // rust: .ensure(device, std::mem::size_of_val(parts) as u64);
    // rust: self.jobs
    // rust: .ensure(device, (padded * std::mem::size_of::<SkinJob>()) as u64);
    // rust: let (Some(parts_buffer), Some(jobs)) = (&self.parts.buffer, &self.jobs.buffer) else {
    // rust: return;
}
    // rust: uploads.buffer(encoder, parts_buffer, 0, bytemuck::cast_slice(parts));
    // rust: uploads.buffer(encoder, jobs, 0, bytemuck::cast_slice(&self.staged));
    // rust: let key = [
    // rust: model.clone(),
    // rust: parts_buffer.clone(),
    // rust: jobs.clone(),
    // rust: out.clone(),
    // rust: ];
    // rust: if self.group.as_ref().is_none_or(|(_, k)| *k != key) {
    // rust: let entries: Vec<_> = key
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(binding, buffer)| wgpu::BindGroupEntry {
    // rust: binding: binding as u32,
    // rust: resource: buffer.as_entire_binding(),
    // rust: })
    // rust: .collect();
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Entity skinning"),
    // rust: layout: &self.layout,
    // rust: entries: &entries,
    // rust: });
    // rust: self.group = Some((group, key));
}
    // rust: let Some((group, _)) = &self.group else {
    // rust: return;
}
    // rust: let mut pass = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
    // rust: label: Some("Entity skinning"),
    // rust: timestamp_writes: None,
    // rust: });
    // rust: pass.set_pipeline(&self.pipeline);
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.dispatch_workgroups(count.min(ROW), rows, 1);
}
}

// What `entity_skin.wgsl` writes for `frame`'s jobs, computed on the CPU
// the same way: the reference its tests hold the shader and the game's walk
// (`mobs::skin`) to. `model` is the whole store.
expand :: proc(model: ^[SkinVertex], frame: ^SkinFrame) -> V {
    // Ported from Horizon
    return {}
}
    // rust: expand_jobs(model, frame, &frame.jobs, frame.vertices)
}

// [`expand`] of the frame's outline jobs: the silhouettes they write.
expand_outline :: proc(model: ^[SkinVertex], frame: ^SkinFrame) -> V {
    // Ported from Horizon
    return {}
}
    // rust: expand_jobs(model, frame, &frame.outline_jobs, frame.outline_vertices)
}

    // rust: fn expand_jobs(
    // rust: model: &[SkinVertex],
    // rust: frame: &SkinFrame,
    // rust: jobs: &[SkinJob],
    // rust: vertices: u32,
    // rust: ) -> Vec<Vertex> {
    // rust: let mut out = vec![bytemuck::Zeroable::zeroed(); vertices as usize];
    // rust: for job in jobs {
    // rust: for k in 0..job.count {
    // rust: let v = model[(job.first + k) as usize];
    // rust: let part = &frame.parts[(job.part + v.part) as usize];
    // rust: let m = glam::Mat4::from_cols_array(&part.matrix);
    // rust: let pos = m.transform_point3(glam::Vec3::from_array(v.pos));
    // rust: let c = (v.axis % 3) as usize * 3;
    // rust: let column = glam::Vec3::from_slice(&part.normal[c..c + 3]);
    // rust: let n = if v.axis >= 3 { -column } else { column };
    // rust: let packed = n.to_array().map(|v| (v.clamp(-1.0, 1.0) * 127.0) as i8);
    // rust: let u = if job.scroll == 0.0 {
    // rust: v.uv[0]
    // rust: } else {
    // rust: (v.uv[0] + job.scroll) % 1.0
}
    // rust: let r = job.rect;
    // rust: let (color, normal) = if job.mode == SkinJob::ITEM {
    // rust: let color = part.normal[v.axis as usize].to_bits();
    // rust: (color, crate::mesher::CULL_BACK)
    // rust: } else if job.mode == SkinJob::FLAT {
    // rust: (job.color, [0; 4])
    // rust: } else {
    // rust: let w = if job.cull != 0 {
    // rust: crate::mesher::SHADED_CULL_W
    // rust: } else {
    // rust: -127
}
    // rust: (job.color, [packed[0], packed[1], packed[2], w])
}
    // rust: out[(job.dst + k) as usize] = Vertex {
    // rust: pos: pos.to_array(),
    // rust: uv: [r[0] + (r[2] - r[0]) * u, r[1] + (r[3] - r[1]) * v.uv[1]],
    // rust: layer: job.overlay,
    // rust: color,
    // rust: light: job.light,
    // rust: normal,
    // rust: glint_uv: if job.glint != 0 { v.uv } else { [0.0, 0.0] },
}
}
}
    // rust: out
}

    // rust: mod tests {
//     use super::*;

device :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

    // A cube's 24 vertices for part `part`, its faces on every axis.
cube :: proc(part: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for axis in 0..6u32 {
    // rust: for corner in 0..4u32 {
    // rust: let a = (axis % 3) as usize;
    // rust: let sign = if axis >= 3 { -0.25 } else { 0.25 };
    // rust: let mut pos = [0.0f32; 3];
    // rust: pos[a] = sign;
    // rust: pos[(a + 1) % 3] = if corner & 1 == 0 { -0.25 } else { 0.25 } + 0.1 * part as f32;
    // rust: pos[(a + 2) % 3] = if corner & 2 == 0 { -0.3 } else { 0.3 };
    // rust: out.push(SkinVertex {
    // rust: pos,
    // rust: uv: [corner as f32 / 3.0, 0.125 * axis as f32 + 0.0625],
    // rust: axis,
    // rust: part,
    // rust: });
}
}
    // rust: out
}

part :: proc(m: glam::Mat4, normal: glam::Mat3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: SkinPart {
    // rust: matrix: m.to_cols_array(),
    // rust: normal: normal.to_cols_array(),
}
}

    // Two draws of a two-part model with turned, scaled parts, a scrolled
    // texture and the armour glint, and an item's: the shader writes what
    // `expand` does, to the bit, after the vertices before them.
the_shader_writes_what_the_cpu_reference_computes :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let Some(mut skin) = EntitySkin::new(&device, true) else {
    // rust: eprintln!("no compute shaders: skipped");
    // rust: return;
}
    // rust: let model: Vec<SkinVertex> = cube(0).into_iter().chain(cube(1)).collect();
    // rust: let turn =
    // rust: glam::Mat4::from_quat(glam::Quat::from_euler(glam::EulerRot::ZYX, 0.3, -1.1, 2.0));
    // rust: let base = glam::Mat4::from_translation(glam::Vec3::new(-3.7, 1.25, 9.1)) * turn;
    // rust: let child = base
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.2, -0.4, 0.05))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(1.0, 2.5, 0.5));
    // rust: let normals = glam::Mat3::from_mat4(child).inverse().transpose();
    // rust: let normals = glam::Mat3::from_cols(
    // rust: normals.x_axis.normalize_or_zero(),
    // rust: normals.y_axis.normalize_or_zero(),
    // rust: normals.z_axis.normalize_or_zero(),
    // rust: );
    // rust: let frame = SkinFrame {
    // rust: spans: Vec::new(),
    // rust: reset: false,
    // rust: base: 0,
    // rust: new_model: model.clone(),
    // rust: parts: vec![
    // rust: part(base, glam::Mat3::from_mat4(turn)),
    // rust: part(child, normals),
    // rust: part(base * turn, glam::Mat3::from_mat4(turn * turn)),
    // rust: part(child * turn, glam::Mat3::IDENTITY),
                // Colours whose bits as floats are NaNs and denormals: copied, never computed.
    // rust: SkinPart::item(
    // rust: child * turn,
    // rust: [
    // rust: 0xff80_4020,
    // rust: 0x7fc0_0001,
    // rust: 0x0000_0001,
    // rust: 0xffff_ffff,
    // rust: 0x7f80_0001,
    // rust: 0x1234_5678,
    // rust: ],
    // rust: ),
    // rust: ],
    // rust: jobs: vec![
    // rust: SkinJob {
    // rust: first: 0,
    // rust: count: 48,
    // rust: part: 0,
    // rust: dst: 0,
    // rust: rect: [0.25, 0.5, 0.375, 0.5625],
    // rust: scroll: 0.0,
    // rust: color: 0xff80_40ff,
    // rust: light: 0xf0_70,
    // rust: overlay: 1,
                    // The bat's encoding: the shader must write -126 like `expand`.
    // rust: cull: 1,
    // rust: ..Default::default()
    // rust: },
    // rust: SkinJob {
    // rust: first: 24,
    // rust: count: 24,
    // rust: part: 2,
    // rust: dst: 48,
    // rust: rect: [0.0, 0.0, 0.0625, 0.0625],
    // rust: scroll: 0.73,
    // rust: color: u32::MAX,
    // rust: light: 0xf0f0,
    // rust: overlay: 36,
    // rust: glint: 1,
    // rust: ..Default::default()
    // rust: },
                // An item's quads: colour by axis from its part, `CULL_BACK` normals.
    // rust: SkinJob {
    // rust: first: 0,
    // rust: count: 24,
    // rust: part: 4,
    // rust: dst: 72,
    // rust: rect: [0.5, 0.25, 0.5625, 0.3125],
    // rust: light: 0xa0_30,
    // rust: overlay: 2 << 16,
    // rust: mode: SkinJob::ITEM,
    // rust: ..Default::default()
    // rust: },
                // An eyes layer: no normal, even over a culled model's encoding; the
                // tier and OIT tag ride in the overlay word.
    // rust: SkinJob {
    // rust: first: 24,
    // rust: count: 24,
    // rust: part: 1,
    // rust: dst: 96,
    // rust: rect: [0.125, 0.75, 0.25, 0.875],
    // rust: color: 0x80ff_ffff,
    // rust: light: 0xf0f0,
    // rust: overlay: crate::gfx::OIT_ENTITY | 3 << 16 | 7,
    // rust: mode: SkinJob::FLAT,
    // rust: cull: 1,
    // rust: ..Default::default()
    // rust: },
    // rust: ],
    // rust: vertices: 120,
    // rust: outline_jobs: Vec::new(),
    // rust: outline_vertices: 0,
}
        // A glowing entity's silhouette: the item job and the first job again,
        // in its team colour with no normal.
    // rust: let mut frame = frame;
    // rust: frame.jobs.push(frame.jobs[2]);
    // rust: frame.jobs.last_mut().expect("pushed").dst = 120;
    // rust: frame.jobs.push(SkinJob {
    // rust: dst: 144,
    // rust: ..frame.jobs[0]
    // rust: });
    // rust: frame.vertices = 192;
    // rust: frame.outline_since(4, 0xff20_c0e0);
    // rust: assert_eq!(frame.outline_vertices, 72);
    // rust: let expected = expand(&model, &frame);
    // rust: let outline = expand_outline(&model, &frame);
        // The posed vertices land after 5 others, which they leave alone, and the
        // silhouettes 3 past them.
    // rust: let before = 5u32;
    // rust: let outline_base = before + frame.vertices + 3;
    // rust: let out = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(outline_base + frame.outline_vertices) * 44,
    // rust: usage: EntitySkin::usage(true) | wgpu::BufferUsages::COPY_SRC,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let sentinel = vec![0xabu8; before as usize * 44];
    // rust: queue.write_buffer(&out, 0, &sentinel);
    // rust: let mut uploads = Uploads::new(&device);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: assert!(skin.register(&device, &mut uploads, &mut encoder, &frame));
    // rust: skin.dispatch(
    // rust: &device,
    // rust: &mut uploads,
    // rust: &mut encoder,
    // rust: &frame,
    // rust: &out,
    // rust: before,
    // rust: outline_base,
    // rust: );
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: out.size(),
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_buffer_to_buffer(&out, 0, &read, 0, out.size());
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let data = read.slice(..).get_mapped_range().unwrap();
    // rust: assert_eq!(&data[..sentinel.len()], &sentinel[..]);
    // rust: let got: &[Vertex] = bytemuck::cast_slice(&data[sentinel.len()..]);
    // rust: for (i, (got, want)) in got.iter().zip(&expected).enumerate() {
    // rust: assert_eq!(
    // rust: bytemuck::bytes_of(got),
    // rust: bytemuck::bytes_of(want),
    // rust: "vertex {i}: {got:?} != {want:?}"
    // rust: );
}
    // rust: let silhouettes = &got[(outline_base - before) as usize..];
    // rust: assert_eq!(silhouettes.len(), outline.len());
    // rust: for (i, (got, want)) in silhouettes.iter().zip(&outline).enumerate() {
    // rust: assert_eq!(
    // rust: bytemuck::bytes_of(got),
    // rust: bytemuck::bytes_of(want),
    // rust: "silhouette {i}: {got:?} != {want:?}"
    // rust: );
}
        // A silhouette is its draw's vertex with the colour and no normal
        // (`mark_outline`).
    // rust: for (copy, of) in outline.iter().zip(&expected[120..]) {
    // rust: let marked = Vertex {
    // rust: color: 0xff20_c0e0,
    // rust: normal: [0; 4],
    // rust: ..*of
}
    // rust: assert_eq!(bytemuck::bytes_of(copy), bytemuck::bytes_of(&marked));
}

        // Standard packs own the model buffer, while outlines follow unrelated CPU
        // geometry in the ordinary buffer. Neither output may overwrite the other's gap.
    // rust: let buffers = [frame.vertices + 3, before + frame.outline_vertices + 2].map(|vertices| {
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(vertices) * 44,
    // rust: usage: EntitySkin::usage(true) | wgpu::BufferUsages::COPY_SRC,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: queue.write_buffer(&buffer, 0, &vec![0xab; buffer.size() as usize]);
    // rust: buffer
    // rust: });
    // rust: let reads = buffers.each_ref().map(|buffer| {
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: buffer.size(),
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: })
    // rust: });
    // rust: let mut uploads = Uploads::new(&device);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: skin.dispatch_pack(
    // rust: &device,
    // rust: &mut uploads,
    // rust: &mut encoder,
    // rust: &frame,
    // rust: &buffers[0],
    // rust: &buffers[1],
    // rust: before,
    // rust: );
    // rust: for (buffer, read) in buffers.iter().zip(&reads) {
    // rust: encoder.copy_buffer_to_buffer(buffer, 0, read, 0, buffer.size());
}
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: for read in &reads {
    // rust: read.slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
}
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: for (i, (expected, start)) in [(&expected, 0usize), (&outline, before as usize)]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let data = reads[i].slice(..).get_mapped_range().unwrap();
    // rust: let first = start * 44;
    // rust: let last = first + expected.len() * 44;
    // rust: assert!(data[..first].iter().all(|b| *b == 0xab), "prefix {i}");
    // rust: assert_eq!(
    // rust: &data[first..last],
    // rust: bytemuck::cast_slice::<_, u8>(expected),
    // rust: "output {i}"
    // rust: );
    // rust: assert!(data[last..].iter().all(|b| *b == 0xab), "suffix {i}");
}
}
}
