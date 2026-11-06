//! Transpiled from Horizon Rust crate
package horizon_client_render_timing

import "core:fmt"
import "core:mem"
import "core:math"

// GPU frame time from timestamp queries, read back a few frames late so the
// CPU never waits for it. Frames whose readback slot is still busy go untimed.
//
// Where the GPU can only time pass boundaries (Apple GPUs on Metal), a
// one-thread compute pass stamps the frame's start, and a render pass over
// the frame's target that shades one pixel with every write masked stamps
// its end (Metal leaves the timestamps of a pass that does nothing at zero).
// A pass that loads the target runs after every pass that draws into it; a
// compute pass, which depends on nothing, ran alongside them. Metal also
// resolves timestamps without waiting for the passes that write them, so
// they are resolved in a later frame, once the GPU has finished this one.
// Resolved in the frame itself, the end was mostly the one an earlier frame
// left in the query, and frames read about 0.01 ms.
// use std::sync::{
    // rust: Arc,
    // rust: atomic::{AtomicU8, Ordering},
}

// Frames in flight at once; on Metal a slot is busy for about five frames.
SLOTS :: 8
// Each slot's timestamps have their own queries and resolve range.
RESOLVE_STRIDE :: wgpu::QUERY_RESOLVE_BUFFER_ALIGNMENT
// The frame's target and its format.
    // rust: pub type Target<'a> = (&'a wgpu::TextureView, wgpu::TextureFormat);
FREE :: 0
// Its frame is submitted; with markers, until the GPU has finished it.
RUNNING :: 1
// Its frame is finished: its timestamps can be resolved.
DONE :: 2
// Resolved and on its way back.
PENDING :: 3
MAPPED :: 4
// Readback failed; stop timing rather than reuse an invalid buffer.
FAILED :: 5

Slot :: struct {
    buffer: wgpu::Buffer,
    state: ^AtomicU8,
}

GpuTimer :: struct {
    queries: wgpu::QuerySet,
    resolve: wgpu::Buffer,
    slots: [dynamic]Slot,
    // The slot this frame writes into, when one was free at `begin`.
    current: Maybe(uint),
    next: uint,
    period_ns: f32,
    // Timestamps between commands, or else these passes' boundaries.
    markers: Maybe(Markers),
    // Slots resolved in this frame's commands, read back once it is submitted.
    resolved: [dynamic]uint,
}

// The marker passes: the start's compute pipeline, and the end's shader and
// pipeline, for the target format it was made for.
Markers :: struct {
    module: wgpu::ShaderModule,
    start: wgpu::ComputePipeline,
    end: Option<(wgpu::TextureFormat,
}

// The start's one thread; the end's triangle over the whole target (the
// pass's scissor keeps one pixel), shading nothing it writes.
    // rust: pub(super) const MARKER: &str =
    // rust: "@vertex fn cover(@builtin(vertex_index) i: u32) -> @builtin(position) vec4<f32> {
    // rust: return vec4<f32>(f32(i & 1u) * 4.0 - 1.0, f32(i >> 1u) * 4.0 - 1.0, 0.0, 1.0);
}
    // rust: @fragment fn nothing() -> @location(0) vec4<f32> { return vec4<f32>(0.0); }
    // rust: @compute @workgroup_size(1) fn mark() {}";

    // rust: impl GpuTimer {
    // The features timing uses that the adapter has (none: no timing).
features :: proc(adapter: ^wgpu::Adapter) -> w {
    // Ported from Horizon
    return {}
}
    // rust: adapter.features()
    // rust: & (wgpu::Features::TIMESTAMP_QUERY | wgpu::Features::TIMESTAMP_QUERY_INSIDE_ENCODERS)
}
new :: proc(device: ^wgpu::Device, queue: ^wgpu::Queue) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !device.features().contains(wgpu::Features::TIMESTAMP_QUERY) {
    // rust: return None;
}
    // rust: let queries = device.create_query_set(&wgpu::QuerySetDescriptor {
    // rust: label: Some("Frame timestamps"),
    // rust: ty: wgpu::QueryType::Timestamp,
    // rust: count: 2 * SLOTS as u32,
    // rust: });
    // rust: let resolve = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Frame timestamp resolve"),
    // rust: size: RESOLVE_STRIDE * SLOTS as u64,
    // rust: usage: wgpu::BufferUsages::QUERY_RESOLVE | wgpu::BufferUsages::COPY_SRC,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let slots = (0..SLOTS)
    // rust: .map(|_| Slot {
    // rust: buffer: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Frame timestamp readback"),
    // rust: size: 16,
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: }),
    // rust: state: Arc::new(AtomicU8::new(FREE)),
    // rust: })
    // rust: .collect();
    // rust: Some(Self {
    // rust: queries,
    // rust: resolve,
    // rust: slots,
    // rust: current: None,
    // rust: next: 0,
    // rust: period_ns: queue.get_timestamp_period(),
    // rust: markers: (!device
    // rust: .features()
    // rust: .contains(wgpu::Features::TIMESTAMP_QUERY_INSIDE_ENCODERS))
    // rust: .then(|| {
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Frame timestamp"),
    // rust: source: wgpu::ShaderSource::Wgsl(MARKER.into()),
    // rust: });
    // rust: Markers {
    // rust: start: device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    // rust: label: Some("Frame timestamp"),
    // rust: layout: None,
    // rust: module: &module,
    // rust: entry_point: Some("mark"),
    // rust: compilation_options: Default::default(),
    // rust: cache: None,
    // rust: }),
    // rust: module,
    // rust: end: None,
}
    // rust: }),
    // rust: resolved: Vec::new(),
    // rust: })
}
begin :: proc(self: ^Self, encoder: ^wgpu::CommandEncoder) {
}
    // rust: if self
    // rust: .slots
    // rust: .iter()
    // rust: .any(|slot| slot.state.load(Ordering::Acquire) == FAILED)
    // rust: {
    // rust: self.current = None;
    // rust: return;
}
    // rust: if self.markers.is_some() {
    // rust: for slot in 0..SLOTS {
    // rust: if self.slots[slot].state.load(Ordering::Acquire) == DONE {
    // rust: self.resolve(encoder, slot);
}
}
}
    // rust: let slot = self.next;
    // rust: self.current = (self.slots[slot].state.load(Ordering::Acquire) == FREE).then_some(slot);
    // rust: let Some(slot) = self.current else { return };
    // rust: let index = 2 * slot as u32;
    // rust: let Some(markers) = &self.markers else {
    // rust: encoder.write_timestamp(&self.queries, index);
    // rust: return;
}
    // rust: let mut pass = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
    // rust: label: Some("Frame timestamp"),
    // rust: timestamp_writes: Some(wgpu::ComputePassTimestampWrites {
    // rust: query_set: &self.queries,
    // rust: beginning_of_pass_write_index: Some(index),
    // rust: end_of_pass_write_index: None,
    // rust: }),
    // rust: });
    // rust: pass.set_pipeline(&markers.start);
    // rust: pass.dispatch_workgroups(1, 1, 1);
}
    // After the frame's last pass into `target` (the frame's own, of `format`).
    // rust: pub fn end(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: (target, format): Target,
    // rust: ) {
    // rust: let Some(slot) = self.current else { return };
    // rust: let index = 2 * slot as u32 + 1;
    // rust: let Some(markers) = &mut self.markers else {
    // rust: encoder.write_timestamp(&self.queries, index);
    // rust: self.resolve(encoder, slot);
    // rust: return;
}
    // rust: if markers.end.as_ref().is_none_or(|(f, _)| *f != format) {
    // rust: markers.end = Some((format, end_pipeline(device, &markers.module, format)));
}
    // rust: let (_, pipeline) = markers.end.as_ref().expect("made above");
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Frame timestamp"),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: target,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: timestamp_writes: Some(wgpu::RenderPassTimestampWrites {
    // rust: query_set: &self.queries,
    // rust: beginning_of_pass_write_index: None,
    // rust: end_of_pass_write_index: Some(index),
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_scissor_rect(0, 0, 1, 1);
    // rust: pass.draw(0..3, 0..1);
}
    // Copy `slot`'s timestamps to its readback buffer.
resolve :: proc(self: ^Self, encoder: ^wgpu::CommandEncoder, slot: uint) {
}
    // rust: let (first, at) = (2 * slot as u32, RESOLVE_STRIDE * slot as u64);
    // rust: encoder.resolve_query_set(&self.queries, first..first + 2, &self.resolve, at);
    // rust: encoder.copy_buffer_to_buffer(&self.resolve, at, &self.slots[slot].buffer, 0, 16);
    // rust: self.slots[slot].state.store(RUNNING, Ordering::Release);
    // rust: self.resolved.push(slot);
}
    // After the frame's submission: start reading back what it resolved,
    // and with markers, wait for the GPU to finish the frame it timed.
submitted :: proc(self: ^Self, queue: ^wgpu::Queue) {
}
    // rust: for slot in self.resolved.drain(..) {
    // rust: let state = self.slots[slot].state.clone();
    // rust: state.store(PENDING, Ordering::Release);
    // rust: self.slots[slot]
    // rust: .buffer
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, move |result| {
    // rust: state.store(
    // rust: if result.is_ok() { MAPPED } else { FAILED },
    // rust: Ordering::Release,
    // rust: );
    // rust: });
}
    // rust: let Some(slot) = self.current.take() else {
    // rust: return;
}
    // rust: if self.markers.is_some() {
    // rust: let state = self.slots[slot].state.clone();
    // rust: state.store(RUNNING, Ordering::Release);
    // rust: queue.on_submitted_work_done(move || state.store(DONE, Ordering::Release));
}
    // rust: self.next = (slot + 1) % SLOTS;
}
    // GPU milliseconds of frames whose timestamps have arrived, oldest first.
collect :: proc(self: ^Self, device: ^wgpu::Device, out: ^[dynamic]f32) {
}
    // rust: if device.poll(wgpu::PollType::Poll).is_err() {
    // rust: return;
}
    // rust: for i in 0..SLOTS {
    // rust: let slot = &self.slots[(self.next + i) % SLOTS];
    // rust: if slot.state.load(Ordering::Acquire) != MAPPED {
    // rust: continue;
}
    // rust: {
    // rust: let Ok(data) = slot.buffer.slice(..).get_mapped_range() else {
                    // Device loss can destroy a buffer after its mapping succeeded.
                    // Unmapping it would turn the failed readback into a panic.
    // rust: slot.state.store(FAILED, Ordering::Release);
    // rust: continue;
}
                // Read unaligned: the mapping isn't guaranteed to be 8-byte aligned.
    // rust: let stamps: [u64; 2] = bytemuck::pod_read_unaligned(&data[..16]);
                // A start marker that ran late (rare on Metal) leaves the frame untimed.
    // rust: if let Some(ticks) = stamps[1].checked_sub(stamps[0]) {
    // rust: out.push((ticks as f64 * f64::from(self.period_ns) / 1e6) as f32);
}
}
    // rust: slot.buffer.unmap();
    // rust: slot.state.store(FREE, Ordering::Release);
}
}
}

// The end marker's pipeline for a `format` target, every write masked.
    // rust: pub(super) fn end_pipeline(
    // rust: device: &wgpu::Device,
    // rust: module: &wgpu::ShaderModule,
    // rust: format: wgpu::TextureFormat,
    // rust: ) -> wgpu::RenderPipeline {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Frame timestamp"),
    // rust: layout: None,
    // rust: vertex: wgpu::VertexState {
    // rust: module,
    // rust: entry_point: Some("cover"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState::default(),
    // rust: depth_stencil: None,
    // rust: multisample: wgpu::MultisampleState::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module,
    // rust: entry_point: Some("nothing"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::empty(),
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}

    // rust: mod tests {
//     use super::*;

mapped_timer :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut descriptor = wgpu::InstanceDescriptor::new_without_display_handle();
        // WGL can hang while creating a test instance on Windows (#5238).
    // rust: descriptor.backends = wgpu::Backends::PRIMARY;
    // rust: let instance = wgpu::Instance::new(descriptor);
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: if !adapter.features().contains(wgpu::Features::TIMESTAMP_QUERY) {
    // rust: return None;
}
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_features: GpuTimer::features(&adapter),
    // rust: ..Default::default()
    // rust: }))
    // rust: .unwrap();
    // rust: let mut timer = GpuTimer::new(&device, &queue).unwrap();
    // rust: queue.write_buffer(
    // rust: &timer.slots[0].buffer,
    // rust: 0,
    // rust: bytemuck::cast_slice(&[10_u64, 20]),
    // rust: );
    // rust: queue.submit([]);
    // rust: timer.resolved.push(0);
    // rust: timer.submitted(&queue);
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: assert_eq!(timer.slots[0].state.load(Ordering::Acquire), MAPPED);
    // rust: Some((device, queue, timer))
}

successful_readback_releases_slot :: proc() {
}
    // rust: let Some((device, _queue, mut timer)) = mapped_timer() else {
    // rust: eprintln!("Skipping GPU timer test: no timestamp-capable adapter");
    // rust: return;
}
    // rust: let mut samples = Vec::new();
    // rust: timer.collect(&device, &mut samples);
    // rust: assert_eq!(
    // rust: samples,
    // rust: vec![(10.0 * f64::from(timer.period_ns) / 1e6) as f32]
    // rust: );
    // rust: assert_eq!(timer.slots[0].state.load(Ordering::Acquire), FREE);
}

destroyed_readback_stops_timing_without_unmapping :: proc() {
}
    // rust: let Some((device, queue, mut timer)) = mapped_timer() else {
    // rust: eprintln!("Skipping GPU timer test: no timestamp-capable adapter");
    // rust: return;
}
        // Reproduce a buffer destroyed after its successful map callback (#6320).
    // rust: timer.slots[0].buffer.destroy();
    // rust: let mut samples = Vec::new();
    // rust: timer.collect(&device, &mut samples);
    // rust: assert!(samples.is_empty());
    // rust: assert_eq!(timer.slots[0].state.load(Ordering::Acquire), FAILED);
        // Later frames must not resolve or copy into the failed readback buffer.
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: timer.begin(&mut encoder);
    // rust: assert!(timer.current.is_none());
    // rust: assert!(timer.resolved.is_empty());
    // rust: queue.submit([encoder.finish()]);
    // rust: timer.submitted(&queue);
    // rust: timer.collect(&device, &mut samples);
    // rust: assert!(samples.is_empty());
}
}
