//! Transpiled from Horizon Rust crate
package horizon_client_render_cull

import "core:fmt"
import "core:mem"
import "core:math"

// Occlusion culling of solid section draws, in two phases.
//
// Frustum and cave culling leave many sections that terrain in front hides
// entirely (about half of the solid vertices drawn from the ground at render
// distance 16, more at 32), and drawing fewer vertices is what helps an
// integrated GPU. Phase 1 draws the sections that the last test read back
// saw. Then, in the same pass, the box of every other section (and of a
// share of phase 1's, to notice when they go out of sight) is drawn against
// phase 1's depth with no writes but to the test's results. Phase 2, in a
// second pass, draws the sections whose box was seen; the others' draws have
// an instance count of 0.
//
// The picture stays the one without culling: the boxes (grown by a block,
// the farthest a block model reaches out of its cell) are drawn front faces
// only, so a fragment is the box's nearest point on its pixel, and the
// fragment shader runs only where the depth test passes (forced early), so a
// section is left out only where all of its fragments would fail the depth
// test against the final depth, which is only nearer. What the CPU knows of
// the results only sorts sections between the phases: a stale result draws
// a hidden section in phase 1, or tests a section that is in sight.
//
// Far terrain tiles are tested the same way, with their meshes' own
// bounds for a box (grown by a block too, which keeps their faces off the
// box's), and resident slots of their own (`TILE`).
//
// Every solid draw is an entry of one of the two lists, so the CPU records
// as many draws as without culling: drivers that unroll an indirect
// multi-draw on the CPU (Mesa's on Intel Gen9) pay per entry. Phase 2's
// counts come from the GPU, which reads them from the draws themselves:
// Vulkan's native multi-draw, and Metal's, which wgpu replays as one
// indirect draw per entry. Translucent draws are not culled.
//
// Metal cannot force the depth test before a fragment shader that writes
// storage (naga writes no `[[early_fragment_tests]]`), so there the boxes
// are drawn in a pass of their own between the phases, which reads phase
// 1's depth as a texture and makes the same comparison in the shader: the
// fragment's depth against the stored one, greater or equal passing. The
// same fragments pass, so the same sections are seen.
// use std::num::NonZeroU64;
// use std::sync::{
    // rust: Arc,
    // rust: atomic::{AtomicU8, Ordering},
}

WORDS :: 5 * 4
// A tested section's box, around its origin: its cell grown by a block.
SECTION_BOX :: [[-1.0; 3], [17.0; 3]]
// The bit that marks a far tile's slot (`Renderer::tile_cull_slot`): tiles
// count their slots apart from the sections' resident ones.
TILE :: 1 << 31
// Phase 1's sections are each tested every `RETEST` frames.
RETEST :: 8
// Culling runs while the last result read back hid at least this share of
// the frame's solid indices: below it the test and the second pass cost
// more than they save. Else one frame in `PROBE` tests every section.
MIN_SHARE :: 0.1
PROBE :: 64
// The gate, for frame `stamp`, with `share` the newest result's hidden share:
// whether the frame culls, and whether it probes (tests every section). GPU
// culling's frames take it too.
    // rust: pub(super) fn gate(share: f32, stamp: u32) -> (bool, bool) {
    // rust: let probe = share < MIN_SHARE;
    // rust: (!probe || stamp.is_multiple_of(PROBE), probe)
}
// On Metal, sections in view from which a frame culls. Apple's GPUs store
// and reload the whole frame at each of the passes the test adds, a fixed
// cost that the sections it hides repay only at high render distances: on
// an M4 Pro at 1080p and render distance 12 (1,000–1,600 draws) culling
// added about 0.05 ms of GPU time while hiding 15–30% of the solid
// indices; at 32 (over 4,096 draws) it saved 0.25–1.6 ms. Those draws were
// 2.2 to 2.5 per section; a section's draw count now depends on the sides
// it shows the eye (`mesher::Sides`), so the bar counts sections.
TILED_MIN_SECTIONS :: 1600
// Boxes over more than this share of the screen count as seen untested.
BIG :: 0.25
// Results read back at once, some frames late so the CPU never waits.
READBACKS :: 3
FREE :: 0
PENDING :: 1
MAPPED :: 2

// One test, as `cull.wgsl` reads it: visible index and phase 2 draws
// (`place`), then its box's corners around the origin.
Test :: struct {
    data: [u32,
    low: [f32,
    high: [f32,
}
TEST_BYTES :: std::mem::size_of::<Test>() as u64

Params :: struct {
    stamp: u32,
    big: f32,
    pad: [u32,
}

// One frame's results on their way back.
Readback :: struct {
    buffer: wgpu::Buffer,
    capacity: u64,
    state: ^AtomicU8,
    stamp: u32,
    // The resident slot of each test, and its section's solid indices.
    slots: [dynamic]u32,
    indices: [dynamic]u32,
    // The frame's solid indices.
    total: u64,
}

// The bind group and the buffers from outside it was made with.
Group :: struct {
    origins: wgpu::Buffer,
    globals: wgpu::Buffer,
    group: wgpu::BindGroup,
}

// Where the boxes' depth test runs.
DepthTest :: enum {
    // Forced before the fragment shader, in phase 1's pass (Vulkan).
    Early,
    // In the fragment shader, against phase 1's depth read as a texture,
    // in a pass of its own (Metal).
    InShader,
}

// The Vulkan entry point: the depth test forced early, which naga cannot
// write for Metal (so it is not in `cull.wgsl`, which every backend takes).
    // rust: const EARLY_TEST: &str = "
    // rust: @fragment
    // rust: @early_depth_test(force)
fs_box_early :: proc(in: Box) -> @ {
    // Ported from Horizon
    return {}
}
    // rust: see(in.test);
    // rust: return vec4(0.0);
}
    // rust: ";

// The test's depth texture binding (`InShader`), for the view it was made with.
DepthGroup :: struct {
    view: wgpu::TextureView,
    group: wgpu::BindGroup,
}

Cull :: struct {
    pipeline: wgpu::RenderPipeline,
    layout: wgpu::BindGroupLayout,
    group: Maybe(Group),
    depth_test: DepthTest,
    depth_layout: Maybe(wgpu::BindGroupLayout),
    depth_group: Maybe(DepthGroup),
    params: wgpu::Buffer,
    // Phase 2's draws: the solid draws after phase 1's in the frame's list.
    phase2: wgpu::Buffer,
    phase2_capacity: u64,
    tests: wgpu::Buffer,
    tests_capacity: u64,
    // This frame's tests: visible index, then its phase 2 draws in each
    // solid pass (`place`): the first of the first pass's, both counts (the
    // second's in the high half), the first of the second pass's; and its box.
    test_data: [dynamic]Test,
    test_slots: [dynamic]u32,
    test_indices: [dynamic]u32,
    total: u64,
    // The frame tests every section, as culling was off.
    probe: bool,
    results: wgpu::Buffer,
    readbacks: [dynamic]Readback,
    next: uint,
    current: Maybe(uint),
    // Per resident slot: whether the last result read back saw it; and per
    // far tile's slot (`TILE`).
    seen: [dynamic]bool,
    seen_tiles: [dynamic]bool,
    stamp: u32,
    // Of the boxes the last test read back drew, how many it did not see
    // and how many it drew, and the share of solid indices hidden.
    hidden: ([uint,
    // Cull every frame, whatever the hidden share (A/B checks).
    always: bool,
    // Frames with fewer sections in view than this do not cull.
    min_sections: uint,
}

    // rust: fn buffer(
    // rust: device: &wgpu::Device,
    // rust: label: &str,
    // rust: size: u64,
    // rust: usage: wgpu::BufferUsages,
    // rust: ) -> wgpu::Buffer {
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(label),
    // rust: size,
    // rust: usage,
    // rust: mapped_at_creation: false,
    // rust: })
}

    // rust: const PHASE2_USAGE: wgpu::BufferUsages = wgpu::BufferUsages::INDIRECT
    // rust: .union(wgpu::BufferUsages::STORAGE)
    // rust: .union(wgpu::BufferUsages::COPY_DST);
    // rust: const TESTS_USAGE: wgpu::BufferUsages =
    // rust: wgpu::BufferUsages::STORAGE.union(wgpu::BufferUsages::COPY_DST);
    // rust: const RESULTS_USAGE: wgpu::BufferUsages =
    // rust: wgpu::BufferUsages::STORAGE.union(wgpu::BufferUsages::COPY_SRC);
    // rust: const READBACK_USAGE: wgpu::BufferUsages =
    // rust: wgpu::BufferUsages::MAP_READ.union(wgpu::BufferUsages::COPY_DST);

    // rust: impl Cull {
    // The device feature culling needs, where the adapter has it.
features :: proc(adapter: ^wgpu::Adapter) -> w {
    // Ported from Horizon
    return {}
}
    // rust: adapter.features() & wgpu::Features::SHADER_EARLY_DEPTH_TEST
}
    // Where the device can run the test, if it can: Vulkan with early
    // depth tests, or Metal, both drawing an indirect multi-draw's entries
    // with the instance counts the GPU wrote, with fragment shaders that
    // write storage.
supported :: proc(adapter: ^wgpu::Adapter, device: ^wgpu::Device) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let depth_test = match adapter.get_info().backend {
    // rust: wgpu::Backend::Vulkan
    // rust: if device
    // rust: .features()
    // rust: .contains(wgpu::Features::SHADER_EARLY_DEPTH_TEST) =>
    // rust: {
    // rust: DepthTest::Early
}
    // rust: wgpu::Backend::Metal => DepthTest::InShader,
    // rust: _ => return None,
}
    // rust: (device
    // rust: .features()
    // rust: .contains(wgpu::Features::INDIRECT_FIRST_INSTANCE)
    // rust: && adapter.get_downlevel_capabilities().flags.contains(
    // rust: wgpu::DownlevelFlags::VERTEX_STORAGE
    // rust: | wgpu::DownlevelFlags::FRAGMENT_WRITABLE_STORAGE,
    // rust: ))
    // rust: .then_some(depth_test)
}
    // Its test runs in phase 1's pass, the depth test forced early (Vulkan):
    // GPU culling's frames can run it too.
early :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.depth_test == DepthTest::Early
}
    // `color` is the world pass's colour format.
new :: proc(device: ^wgpu::Device, color: wgpu::TextureFormat, depth_test: DepthTest) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let entry = |binding, visibility, ty| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility,
    // rust: ty,
    // rust: count: None,
}
    // rust: let storage = |read_only| wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Storage { read_only },
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
}
    // rust: let uniform = wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
}
    // rust: let both = wgpu::ShaderStages::VERTEX_FRAGMENT;
    // rust: let vertex = wgpu::ShaderStages::VERTEX;
    // rust: let fragment = wgpu::ShaderStages::FRAGMENT;
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Section culling"),
    // rust: entries: &[
    // rust: entry(0, both, storage(true)),
    // rust: entry(1, fragment, storage(false)),
    // rust: entry(2, fragment, storage(false)),
    // rust: entry(3, vertex, storage(true)),
    // rust: entry(4, vertex, uniform),
    // rust: entry(5, both, uniform),
    // rust: ],
    // rust: });
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Section culling"),
    // rust: source: wgpu::ShaderSource::Wgsl(source(depth_test).into()),
    // rust: });
    // rust: let depth_layout = (depth_test == DepthTest::InShader).then(|| {
    // rust: device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Section culling depth"),
    // rust: entries: &[entry(
    // rust: 0,
    // rust: fragment,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: false },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: )],
    // rust: })
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Section culling"),
    // rust: bind_group_layouts: &[Some(&layout), depth_layout.as_ref()],
    // rust: ..Default::default()
    // rust: });
        // In the shader (`InShader`): no colour target, and the depth
        // attached read only (a pass needs an attachment), its test left to
        // the shader.
    // rust: let color_target = [Some(wgpu::ColorTargetState {
    // rust: format: color,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::empty(),
    // rust: })];
    // rust: let (fragment_entry, targets, depth_compare) = match depth_test {
    // rust: DepthTest::Early => (
    // rust: "fs_box_early",
    // rust: &color_target[..],
    // rust: wgpu::CompareFunction::GreaterEqual,
    // rust: ),
    // rust: DepthTest::InShader => ("fs_box", &[][..], wgpu::CompareFunction::Always),
}
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Section culling"),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: Some("vs_box"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: Some(wgpu::Face::Back),
    // rust: ..Default::default()
    // rust: },
            // The world pass's reversed depth test, without writes.
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(false),
    // rust: depth_compare: Some(depth_compare),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: Some(fragment_entry),
    // rust: compilation_options: Default::default(),
    // rust: targets,
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: Self {
    // rust: pipeline,
    // rust: layout,
    // rust: group: None,
    // rust: depth_test,
    // rust: depth_layout,
    // rust: depth_group: None,
    // rust: params: buffer(
    // rust: device,
    // rust: "Section culling parameters",
    // rust: std::mem::size_of::<Params>() as u64,
    // rust: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: ),
    // rust: phase2: buffer(device, "Section draws, phase 2", WORDS, PHASE2_USAGE),
    // rust: phase2_capacity: 1,
    // rust: tests: buffer(device, "Section tests", TEST_BYTES, TESTS_USAGE),
    // rust: tests_capacity: 1,
    // rust: test_data: Vec::new(),
    // rust: test_slots: Vec::new(),
    // rust: test_indices: Vec::new(),
    // rust: total: 0,
    // rust: probe: false,
    // rust: results: buffer(device, "Section test results", 4, RESULTS_USAGE),
    // rust: readbacks: (0..READBACKS)
    // rust: .map(|_| Readback {
    // rust: buffer: buffer(device, "Section test readback", 4, READBACK_USAGE),
    // rust: capacity: 1,
    // rust: state: Arc::new(AtomicU8::new(FREE)),
    // rust: stamp: 0,
    // rust: slots: Vec::new(),
    // rust: indices: Vec::new(),
    // rust: total: 0,
    // rust: })
    // rust: .collect(),
    // rust: next: 0,
    // rust: current: None,
    // rust: seen: Vec::new(),
    // rust: seen_tiles: Vec::new(),
    // rust: stamp: 0,
    // rust: hidden: ([0; 2], 1.0),
    // rust: always: false,
    // rust: min_sections: 0,
}
}

    // Start a frame: take in the results that came back, and tell whether
    // the frame culls.
begin :: proc(self: ^Self, device: ^wgpu::Device) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let _ = device.poll(wgpu::PollType::Poll);
    // rust: for i in 0..READBACKS {
    // rust: let r = &mut self.readbacks[(self.next + i) % READBACKS];
    // rust: if r.state.load(Ordering::Acquire) != MAPPED {
    // rust: continue;
}
    // rust: let mapped = r.buffer.slice(..r.slots.len() as u64 * 4);
    // rust: if let Ok(data) = mapped.get_mapped_range() {
                // The mapping isn't guaranteed to be 4-byte aligned (a Vega 11
                // on Windows panicked in cast_slice), so copy the words out.
    // rust: let results: Vec<u32> = bytemuck::pod_collect_to_vec(&data);
    // rust: let (mut hidden, mut indices) = (0, 0u64);
    // rust: for (&result, &n) in results.iter().zip(&r.indices) {
    // rust: if result != r.stamp {
    // rust: hidden += 1;
    // rust: indices += u64::from(n);
}
}
    // rust: let share = indices as f32 / r.total.max(1) as f32;
    // rust: self.hidden = ([hidden, results.len()], share);
    // rust: for (&slot, &result) in r.slots.iter().zip(&results) {
    // rust: let (seen, slot) = if slot & TILE != 0 {
    // rust: (&mut self.seen_tiles, (slot & !TILE) as usize)
    // rust: } else {
    // rust: (&mut self.seen, slot as usize)
}
    // rust: if slot >= seen.len() {
    // rust: seen.resize(slot + 1, false);
}
    // rust: seen[slot] = result == r.stamp;
}
}
    // rust: r.buffer.unmap();
    // rust: r.state.store(FREE, Ordering::Release);
}
    // rust: self.stamp = self.stamp.wrapping_add(1).max(1);
    // rust: self.test_data.clear();
    // rust: self.test_slots.clear();
    // rust: self.test_indices.clear();
    // rust: self.total = 0;
    // rust: let (culls, probe) = match self.always {
    // rust: true => (true, false),
    // rust: false => gate(self.hidden.1, self.stamp),
}
    // rust: self.probe = probe;
    // rust: culls
}

    // Whether phase 1 draws the section in resident `slot` (or the far tile
    // in its `TILE` slot).
first :: proc(self: ^Self, slot: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if slot & TILE != 0 {
    // rust: return self
    // rust: .seen_tiles
    // rust: .get((slot & !TILE) as usize)
    // rust: .copied()
    // rust: .unwrap_or(false);
}
    // rust: self.seen.get(slot as usize).copied().unwrap_or(false)
}

    // A section phase 1 draws, `index` in the visible list, with `indices`
    // solid indices and the box `bounds` around its origin: tested in turn.
drawn :: proc(self: ^Self, index: uint, slot: u32, indices: u32, bounds: [[f32; 3]; 2]) {
}
    // rust: self.total += u64::from(indices);
    // rust: if indices > 0 && (self.probe || slot.wrapping_add(self.stamp).is_multiple_of(RETEST)) {
    // rust: self.push(index, bounds, slot, indices);
}
}

    // A section left to phase 2, with `draws` draws there: its test, whose
    // draws `place` gives once phase 2's list is in its final order.
    // rust: pub fn deferred(
    // rust: &mut self,
    // rust: index: usize,
    // rust: slot: u32,
    // rust: draws: usize,
    // rust: indices: u32,
    // rust: bounds: [[f32; 3]; 2],
    // rust: ) -> Option<u32> {
    // rust: self.total += u64::from(indices);
    // rust: (draws > 0).then(|| {
    // rust: self.push(index, bounds, slot, indices);
    // rust: self.test_data.len() as u32 - 1
    // rust: })
}

    // `test`'s draws in solid pass `pass` (0 or 1): `draws` from phase 2's
    // `first`. Each pass draws its own part of the section's quads.
place :: proc(self: ^Self, test: u32, pass: u32, first: u32, draws: u32) {
}
    // rust: debug_assert!(pass < 2 && draws < 1 << 16);
    // rust: let t = &mut self.test_data[test as usize].data;
    // rust: t[1 + 2 * pass as usize] = first;
    // rust: t[2] |= draws << (16 * pass);
}

push :: proc(self: ^Self, index: uint, bounds: [[f32; 3]; 2], slot: u32, indices: u32) {
}
    // rust: let [low, high] = bounds.map(|[x, y, z]| [x, y, z, 0.0]);
    // rust: self.test_data.push(Test {
    // rust: data: [index as u32, 0, 0, 0],
    // rust: low,
    // rust: high,
    // rust: });
    // rust: self.test_slots.push(slot);
    // rust: self.test_indices.push(indices);
}

    // Stage this frame's inputs: phase 2's draws, with instance counts of 0,
    // and the tests, which read the frame's camera-relative `origins` and
    // view projection (the start of `globals`).
    // rust: pub fn upload(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: uploads: &mut super::upload::Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: phase2: &[[u32; 5]],
    // rust: origins: &wgpu::Buffer,
    // rust: globals: &wgpu::Buffer,
    // rust: ) {
    // rust: let draws = phase2.len() as u64;
    // rust: if draws > self.phase2_capacity {
    // rust: self.phase2_capacity = draws.next_power_of_two();
    // rust: self.phase2 = buffer(
    // rust: device,
    // rust: "Section draws, phase 2",
    // rust: self.phase2_capacity * WORDS,
    // rust: PHASE2_USAGE,
    // rust: );
    // rust: self.group = None;
}
    // rust: let tests = self.test_data.len() as u64;
    // rust: if tests > self.tests_capacity {
    // rust: self.tests_capacity = tests.next_power_of_two();
    // rust: self.tests = buffer(
    // rust: device,
    // rust: "Section tests",
    // rust: self.tests_capacity * TEST_BYTES,
    // rust: TESTS_USAGE,
    // rust: );
    // rust: self.results = buffer(
    // rust: device,
    // rust: "Section test results",
    // rust: self.tests_capacity * 4,
    // rust: RESULTS_USAGE,
    // rust: );
    // rust: self.group = None;
}
    // rust: if draws > 0 {
    // rust: uploads.buffer(encoder, &self.phase2, 0, bytemuck::cast_slice(phase2));
}
    // rust: if tests > 0 {
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: &self.tests,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.test_data),
    // rust: );
}
    // rust: let params = Params {
    // rust: stamp: self.stamp,
    // rust: big: BIG,
    // rust: pad: [0; 2],
}
    // rust: uploads.buffer(encoder, &self.params, 0, bytemuck::bytes_of(&params));
    // rust: if !self
    // rust: .group
    // rust: .as_ref()
    // rust: .is_some_and(|g| g.origins == *origins && g.globals == *globals)
    // rust: {
    // rust: self.group = Some(self.make_group(device, origins, globals));
}
}

    // In the world pass after phase 1 (`Early`): draw the tested boxes
    // against its depth. Leaves the pass's pipeline and group 0 changed.
test :: proc(self: ^Self, pass: ^wgpu::RenderPass<'_>) {
}
    // rust: let Some(Group { group, .. }) = &self.group else {
    // rust: return;
}
    // rust: if self.depth_test != DepthTest::Early || self.test_data.is_empty() {
    // rust: return;
}
    // rust: pass.set_pipeline(&self.pipeline);
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.draw(0..36, 0..self.test_data.len() as u32);
}

    // Before the world pass (`InShader`): the binding of the depth the
    // world is drawn with this frame.
bind_depth :: proc(self: ^Self, device: ^wgpu::Device, depth: ^wgpu::TextureView) {
}
    // rust: let Some(layout) = &self.depth_layout else {
    // rust: return;
}
    // rust: if self.depth_group.as_ref().is_none_or(|g| g.view != *depth) {
    // rust: self.depth_group = Some(DepthGroup {
    // rust: view: depth.clone(),
    // rust: group: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Section culling depth"),
    // rust: layout,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(depth),
    // rust: }],
    // rust: }),
    // rust: });
}
}

    // Between the phases (`InShader`): draw the tested boxes in a pass of
    // their own that reads phase 1's depth, bound by `bind_depth`.
    // rust: pub fn test_pass(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let (Some(Group { group, .. }), Some(DepthGroup { view, group: depth })) =
    // rust: (&self.group, &self.depth_group)
    // rust: else {
    // rust: return;
}
    // rust: if self.test_data.is_empty() {
    // rust: return;
}
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Section culling"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("Occlusion test")),
    // rust: color_attachments: &[],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view,
    // rust: depth_ops: None,
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&self.pipeline);
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.set_bind_group(1, depth, &[]);
    // rust: pass.draw(0..36, 0..self.test_data.len() as u32);
}

    // After the world passes: copy the results for reading back, when a
    // readback buffer is free.
end :: proc(self: ^Self, device: ^wgpu::Device, encoder: ^wgpu::CommandEncoder) {
}
    // rust: let tests = self.test_data.len() as u64;
    // rust: let r = &mut self.readbacks[self.next];
    // rust: if tests == 0 || r.state.load(Ordering::Acquire) != FREE {
    // rust: return;
}
    // rust: if tests > r.capacity {
    // rust: r.capacity = tests.next_power_of_two();
    // rust: r.buffer = buffer(
    // rust: device,
    // rust: "Section test readback",
    // rust: r.capacity * 4,
    // rust: READBACK_USAGE,
    // rust: );
}
    // rust: encoder.copy_buffer_to_buffer(&self.results, 0, &r.buffer, 0, tests * 4);
    // rust: r.stamp = self.stamp;
    // rust: r.slots.clear();
    // rust: r.slots.extend_from_slice(&self.test_slots);
    // rust: r.indices.clear();
    // rust: r.indices.extend_from_slice(&self.test_indices);
    // rust: r.total = self.total;
    // rust: self.current = Some(self.next);
}

    // The frame's results to read back, started by calling it right after the frame's
    // submission (on the submit thread, when the frame goes there).
submitted :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let i = self.current.take()?;
    // rust: let r = &self.readbacks[i];
    // rust: let state = r.state.clone();
    // rust: state.store(PENDING, Ordering::Release);
    // rust: let (buffer, bytes) = (r.buffer.clone(), r.slots.len() as u64 * 4);
    // rust: self.next = (i + 1) % READBACKS;
    // rust: Some(move || {
    // rust: buffer
    // rust: .slice(..bytes)
    // rust: .map_async(wgpu::MapMode::Read, move |result| {
    // rust: state.store(
    // rust: if result.is_ok() { MAPPED } else { FREE },
    // rust: Ordering::Release,
    // rust: );
    // rust: });
    // rust: })
}

    // rust: fn make_group(
    // rust: &self,
    // rust: device: &wgpu::Device,
    // rust: origins: &wgpu::Buffer,
    // rust: globals: &wgpu::Buffer,
    // rust: ) -> Group {
whole :: proc(binding: u32, buffer: ^wgpu::Buffer) -> w {
    // Ported from Horizon
    return {}
}
    // rust: wgpu::BindGroupEntry {
    // rust: binding,
    // rust: resource: buffer.as_entire_binding(),
}
}
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Section culling"),
    // rust: layout: &self.layout,
    // rust: entries: &[
    // rust: whole(0, &self.tests),
    // rust: whole(1, &self.results),
    // rust: whole(2, &self.phase2),
    // rust: whole(3, origins),
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: wgpu::BindingResource::Buffer(wgpu::BufferBinding {
    // rust: buffer: globals,
    // rust: offset: 0,
    // rust: size: NonZeroU64::new(64),
    // rust: }),
    // rust: },
    // rust: whole(5, &self.params),
    // rust: ],
    // rust: });
    // rust: Group {
    // rust: origins: origins.clone(),
    // rust: globals: globals.clone(),
    // rust: group,
}
}
}

// The test's shader for `depth_test`.
source :: proc(depth_test: DepthTest) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let common = include_str!("cull.wgsl");
    // rust: match depth_test {
    // rust: DepthTest::Early => format!("{common}{EARLY_TEST}"),
    // rust: DepthTest::InShader => common.to_owned(),
}
}

    // rust: mod tests {
//     use super::*;

    // Culling while the newest result hid enough; else one frame in `PROBE`
    // tests every section. GPU culling's frames take the same gate.
the_gate_culls_while_enough_is_hidden_and_probes_else :: proc() {
}
    // rust: assert_eq!(gate(MIN_SHARE, 3), (true, false));
    // rust: assert_eq!(gate(MIN_SHARE / 2.0, 3), (false, true));
    // rust: assert_eq!(gate(MIN_SHARE / 2.0, PROBE), (true, true));
}

shaders_validate :: proc() {
}
    // rust: for (depth_test, capabilities) in [
    // rust: (DepthTest::Early, naga::valid::Capabilities::all()),
            // What wgpu's Metal backend allows: no early depth test.
    // rust: (
    // rust: DepthTest::InShader,
    // rust: naga::valid::Capabilities::all() - naga::valid::Capabilities::EARLY_DEPTH_TEST,
    // rust: ),
    // rust: ] {
    // rust: let module = naga::front::wgsl::parse_str(&source(depth_test)).unwrap();
    // rust: naga::valid::Validator::new(naga::valid::ValidationFlags::all(), capabilities)
    // rust: .validate(&module)
    // rust: .unwrap_or_else(|e| panic!("{depth_test:?}: {e:?}"));
}
}
}
