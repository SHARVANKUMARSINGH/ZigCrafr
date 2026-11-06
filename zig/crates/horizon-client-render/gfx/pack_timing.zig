//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_pack_timing
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! GPU time of each pass of a shader pack, of either kind, and of Horizon's own passes: shown in
//! the F3 overlay while it is open, and logged every `REPORT` timed frames with
//! `HORIZON_SHADER_PACK_TIMING=1`. One frame
//! at a time is timed, and the CPU never waits for it: its timestamps are resolved in a later
//! frame, once the GPU has finished it (Metal resolves them without waiting for the passes that
//! write them), then read back when mapped. The next frame after that is timed again.

// use std::collections::VecDeque;
// use std::sync::{
    // rust: Arc,
    // rust: atomic::{AtomicBool, Ordering},
}

pub const REPORT: usize = 30;
/// Passes timed per frame at most (two timestamps each).
pub const CAPACITY: u32 = 64;
/// Timed frames each pass's median is taken over.
pub const WINDOW: usize = 15;

pub const Stage = enum {
    /// The next frame is timed.
    Idle,
    /// The frame being recorded is timed.
    Recording,
    /// Submitted; the flag is set once the GPU has finished it.
    Running(Arc<AtomicBool>),
    /// Resolved and copied; the flag is set once the copy is mapped.
    Reading(Arc<AtomicBool>, u64),
};

pub const PassTiming = struct {
    queries: wgpu::QuerySet,
    resolve: wgpu::Buffer,
    read: wgpu::Buffer,
    period_ns: f32,
    stage: Stage,
    /// The passes of the timed frame, in order.
    names: std.ArrayList([]const u8),
    /// Each pass's last `WINDOW` times, in milliseconds.
    samples: Vec<([]const u8,
    /// Log the medians every `REPORT` timed frames.
    log: bool,
    /// `mark`'s pipeline, for the target format it was made for.
    marker: Option<(wgpu::TextureFormat,
    reports: usize,
};

    // rust: impl PassTiming {
    /// `None` when the device can't time passes.
pub fn new(device: *wgpu::Device, queue: *wgpu::Queue) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !device.features().contains(wgpu::Features::TIMESTAMP_QUERY) {
    // rust: return None;
}
    // rust: let size = u64::from(CAPACITY) * 2 * 8;
    // rust: let buffer = |label, usage| {
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(label),
    // rust: size,
    // rust: usage,
    // rust: mapped_at_creation: false,
    // rust: })
}
    // rust: Some(Self {
    // rust: queries: device.create_query_set(&wgpu::QuerySetDescriptor {
    // rust: label: Some("Shader pack pass timing"),
    // rust: ty: wgpu::QueryType::Timestamp,
    // rust: count: CAPACITY * 2,
    // rust: }),
    // rust: resolve: buffer(
    // rust: "Shader pack timing resolve",
    // rust: wgpu::BufferUsages::QUERY_RESOLVE | wgpu::BufferUsages::COPY_SRC,
    // rust: ),
    // rust: read: buffer(
    // rust: "Shader pack timing read",
    // rust: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: ),
    // rust: period_ns: queue.get_timestamp_period(),
    // rust: stage: Stage::Idle,
    // rust: names: Vec::new(),
    // rust: samples: Vec::new(),
    // rust: log: Self::logging(),
    // rust: marker: None,
    // rust: reports: 0,
    // rust: })
}

    /// Whether `HORIZON_SHADER_PACK_TIMING` asks for timing without the F3 overlay.
pub fn logging() b {
    // Implementation ported from Horizon
    return undefined;
}
pub const LOG: std::sync::OnceLock<bool> = std::sync::OnceLock::new();
    // rust: *LOG.get_or_init(|| std::env::var_os("HORIZON_SHADER_PACK_TIMING").is_some())
}

    /// At the start of a frame's passes: moves the last timed frame along, and decides whether
    /// this one is timed.
pub fn begin(self: *Self, device: *wgpu::Device, queue: *wgpu::Queue) void {
}
    // rust: match &self.stage {
            // A timed frame that was never submitted: time this one instead.
    // rust: Stage::Recording => self.stage = Stage::Idle,
    // rust: Stage::Running(done) if done.load(Ordering::Acquire) => {
    // rust: let bytes = self.names.len() as u64 * 16;
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.resolve_query_set(
    // rust: &self.queries,
    // rust: 0..self.names.len() as u32 * 2,
    // rust: &self.resolve,
    // rust: 0,
    // rust: );
    // rust: encoder.copy_buffer_to_buffer(&self.resolve, 0, &self.read, 0, bytes);
    // rust: queue.submit([encoder.finish()]);
    // rust: let mapped = Arc::new(AtomicBool::new(false));
    // rust: let flag = mapped.clone();
    // rust: self.read
    // rust: .slice(..bytes)
    // rust: .map_async(wgpu::MapMode::Read, move |r| {
    // rust: flag.store(r.is_ok(), Ordering::Release)
    // rust: });
    // rust: self.stage = Stage::Reading(mapped, bytes);
}
    // rust: Stage::Reading(mapped, bytes) if mapped.load(Ordering::Acquire) => {
    // rust: let bytes = *bytes;
    // rust: self.collect(bytes);
    // rust: self.stage = Stage::Idle;
}
    // rust: _ => {}
}
    // rust: if matches!(self.stage, Stage::Idle) {
    // rust: self.names.clear();
    // rust: self.stage = Stage::Recording;
}
}

    /// Whether the frame being recorded is timed.
pub fn recording(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.stage, Stage::Recording)
}

    /// Timestamp writes for the pass `name`, in a timed frame.
pub fn writes(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = self.push(name)?;
    // rust: Some(stamps(&self.queries, i))
}

    /// Timestamp writes for the compute pass `name`, in a timed frame.
pub fn compute_writes(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = self.push(name)?;
    // rust: Some(compute_stamps(&self.queries, i))
}

    /// The index of the timed frame's next pass, `name`.
pub fn push(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = self.names.len() as u32;
    // rust: if !matches!(self.stage, Stage::Recording) || i >= CAPACITY {
    // rust: return None;
}
    // rust: self.names.push(name.to_owned());
    // rust: Some(i)
}

    /// A pass that ends once everything drawn into `target` before it has, in a timed frame:
    /// the next pass counts from there, not from when the GPU queued it behind them.
    // rust: pub fn mark(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: (target, format): super::timing::Target,
    // rust: ) {
    // rust: if self.marker.as_ref().is_none_or(|(f, _)| *f != format) {
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Shader pack timing mark"),
    // rust: source: wgpu::ShaderSource::Wgsl(super::timing::MARKER.into()),
    // rust: });
    // rust: let pipeline = super::timing::end_pipeline(device, &module, format);
    // rust: self.marker = Some((format, pipeline));
}
        // An unnamed pass: its end counts, it is never listed.
    // rust: let Some(i) = self.push("") else {
    // rust: return;
}
    // rust: let (_, pipeline) = self.marker.as_ref().expect("made above");
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Shader pack timing mark"),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: target,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: timestamp_writes: Some(stamps(&self.queries, i)),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_scissor_rect(0, 0, 1, 1);
    // rust: pass.draw(0..3, 0..1);
}

    /// After the frame is submitted.
pub fn submitted(self: *Self, queue: *wgpu::Queue) void {
}
    // rust: if !matches!(self.stage, Stage::Recording) {
    // rust: return;
}
    // rust: if self.names.is_empty() {
    // rust: self.stage = Stage::Idle;
    // rust: return;
}
    // rust: let done = Arc::new(AtomicBool::new(false));
    // rust: let flag = done.clone();
    // rust: queue.on_submitted_work_done(move || flag.store(true, Ordering::Release));
    // rust: self.stage = Stage::Running(done);
}

pub fn collect(self: *Self, bytes: u64) void {
}
    // rust: let slice = self.read.slice(..bytes);
    // rust: let Ok(data) = slice.get_mapped_range() else {
    // rust: return;
}
    // rust: let stamps: Vec<u64> = data
    // rust: .as_chunks::<8>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|b| u64::from_le_bytes(*b))
    // rust: .collect();
    // rust: drop(data);
    // rust: self.read.unmap();
    // rust: let times = pass_times(&stamps, self.period_ns);
    // rust: for (name, ms) in self.names.iter().zip(times) {
    // rust: let Some(ms) = ms.filter(|_| !name.is_empty()) else {
    // rust: continue;
}
    // rust: let i = match self.samples.iter().position(|s| s.0 == *name) {
    // rust: Some(i) => i,
    // rust: None => {
    // rust: self.samples.push((name.clone(), VecDeque::new()));
    // rust: self.samples.len() - 1
}
}
    // rust: let window = &mut self.samples[i].1;
    // rust: if window.len() == WINDOW {
    // rust: window.pop_front();
}
    // rust: window.push_back(ms);
}
    // rust: self.reports += 1;
    // rust: if self.log && self.reports.is_multiple_of(REPORT) {
    // rust: let medians = self.medians();
    // rust: let total: f32 = medians.iter().map(|m| m.1).sum();
    // rust: let parts: Vec<String> = medians
    // rust: .iter()
    // rust: .map(|(n, ms)| format!("{n} {ms:.3}"))
    // rust: .collect();
    // rust: log::info!(
    // rust: "shader pack GPU time per pass (median ms of the last {WINDOW} timed frames): {} = {total:.3}",
    // rust: parts.join(", ")
    // rust: );
}
}

    /// Each pass's median time in milliseconds over its last timed frames, in the order the
    /// passes first ran.
pub fn medians(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.samples
    // rust: .iter()
    // rust: .filter(|s| !s.1.is_empty())
    // rust: .map(|(name, v)| {
    // rust: let mut v: Vec<f32> = v.iter().copied().collect();
    // rust: v.sort_by(f32::total_cmp);
    // rust: (name.clone(), v[v.len() / 2])
    // rust: })
    // rust: .collect()
}
}

/// Pass `i`'s beginning and end timestamps.
pub fn stamps(queries: *wgpu::QuerySet, i: u32) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: wgpu::RenderPassTimestampWrites {
    // rust: query_set: queries,
    // rust: beginning_of_pass_write_index: Some(2 * i),
    // rust: end_of_pass_write_index: Some(2 * i + 1),
}
}

/// The compute pass's twin of `stamps`.
pub fn compute_stamps(queries: *wgpu::QuerySet, i: u32) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: wgpu::ComputePassTimestampWrites {
    // rust: query_set: queries,
    // rust: beginning_of_pass_write_index: Some(2 * i),
    // rust: end_of_pass_write_index: Some(2 * i + 1),
}
}

/// Each pass's time in milliseconds from its (beginning, end) timestamps, `None` for a pass
/// the GPU left unstamped. Passes overlap on tiled GPUs (a pass begins before the one before it
/// ends): a pass costs the time from the later of its beginning and the previous pass's end.
pub fn pass_times(stamps: *[u64], period_ns: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut previous_end = 0;
    // rust: stamps
    // rust: .as_chunks::<2>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|&[begin, end]| {
    // rust: if begin == 0 || end < begin {
    // rust: return None;
}
    // rust: let from = begin.max(previous_end).min(end);
    // rust: previous_end = end;
    // rust: Some((end - from) as f32 * period_ns / 1e6)
    // rust: })
    // rust: .collect()
}

    // rust: mod tests {
//     use super::pass_times;

pub fn overlapping_passes_cost_from_the_previous_end() void {
}
        // Pass 2 begins before pass 1 ends; pass 3 was never stamped.
    // rust: let stamps = [1_000_000, 3_000_000, 2_000_000, 5_000_000, 0, 0];
    // rust: assert_eq!(pass_times(&stamps, 1.0), [Some(2.0), Some(2.0), None]);
}
}
