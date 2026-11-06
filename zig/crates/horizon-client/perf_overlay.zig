//! Transpiled from Horizon Rust crate
//! Module: horizon-client_perf_overlay
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The performance overlay (Horizon's Overlay setting): frames per second,
//! frame, CPU and GPU times, and a graph of recent frame times.
// use crate::{
    // rust: graphics::Overlay,
    // rust: hud::{HudAtlas, HudBatch, rgba},
    // rust: text::Text,
}
// use std::collections::VecDeque;

pub const HISTORY: usize = 160;

pub const FrameGraph = struct {
    /// Frame, CPU and GPU milliseconds of recent frames, oldest first.
    frames: VecDeque<(f32,
};
    // rust: impl FrameGraph {
pub fn record(self: *Self, frame_ms: f32, cpu_ms: f32, gpu_ms: ?f32) void {
}
    // rust: let gpu = gpu_ms.unwrap_or_else(|| self.frames.back().map_or(0.0, |f| f.2));
    // rust: if self.frames.len() == HISTORY {
    // rust: self.frames.pop_front();
}
    // rust: self.frames.push_back((frame_ms, cpu_ms, gpu));
}
pub fn draw(self: *Self, mode: Overlay, batch: *mut HudBatch, atlas: *HudAtlas) void {
}
    // rust: if mode == Overlay::Off || self.frames.is_empty() {
    // rust: return;
}
    // rust: let n = self.frames.len() as f32;
    // rust: let avg = |f: fn(&(f32, f32, f32)) -> f32| self.frames.iter().map(f).sum::<f32>() / n;
    // rust: let (frame, cpu, gpu) = (avg(|f| f.0), avg(|f| f.1), avg(|f| f.2));
    // rust: let worst = self.frames.iter().map(|f| f.0).fold(0.0f32, f32::max);
    // rust: let lines = [
    // rust: format!("{:.0} fps", 1000.0 / frame.max(0.001)),
    // rust: format!("frame {frame:.1} ms  max {worst:.1}"),
    // rust: format!("cpu {cpu:.1}  gpu {gpu:.1} ms"),
    // rust: ];
    // rust: let width = 120.0f32.max(
    // rust: lines
    // rust: .iter()
    // rust: .map(|l| atlas.font.width(l))
    // rust: .fold(0.0, f32::max)
    // rust: + 6.0,
    // rust: );
    // rust: let x = batch.width - width - 2.0;
    // rust: let graph = if mode == Overlay::Graph { 42.0 } else { 0.0 };
    // rust: batch.fill(
    // rust: atlas,
    // rust: x,
    // rust: 2.0,
    // rust: width,
    // rust: 4.0 + lines.len() as f32 * 10.0 + graph,
    // rust: rgba(0, 0, 0, 144),
    // rust: );
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: let color = if i == 0 {
    // rust: rgba(255, 255, 255, 255)
    // rust: } else {
    // rust: rgba(200, 200, 200, 255)
}
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &Text::literal(line.clone()),
    // rust: x + 3.0,
    // rust: 4.0 + i as f32 * 10.0,
    // rust: color,
    // rust: true,
    // rust: );
}
    // rust: if mode != Overlay::Graph {
    // rust: return;
}
        // Bars of frame time on a 0..33 ms scale; lines at 60 and 30 fps.
    // rust: let (gy, gh) = (4.0 + lines.len() as f32 * 10.0 + 2.0, 36.0);
    // rust: let scale = gh / 33.3;
    // rust: let bar = (width - 6.0) / HISTORY as f32;
    // rust: for (i, &(ms, cpu, _)) in self.frames.iter().enumerate() {
    // rust: let height = (ms * scale).min(gh);
    // rust: let bx = x + 3.0 + i as f32 * bar;
    // rust: let color = if ms > 33.3 {
    // rust: rgba(240, 90, 80, 255)
    // rust: } else if ms > 16.7 {
    // rust: rgba(240, 200, 90, 255)
    // rust: } else {
    // rust: rgba(110, 210, 120, 255)
}
    // rust: batch.fill(atlas, bx, gy + gh - height, bar.max(1.0), height, color);
    // rust: let cpu_height = (cpu * scale).min(height);
    // rust: batch.fill(
    // rust: atlas,
    // rust: bx,
    // rust: gy + gh - cpu_height,
    // rust: bar.max(1.0),
    // rust: cpu_height,
    // rust: rgba(80, 140, 230, 200),
    // rust: );
}
    // rust: for target in [16.7, 33.3] {
    // rust: let ly = gy + gh - target * scale;
    // rust: batch.fill(
    // rust: atlas,
    // rust: x + 3.0,
    // rust: ly,
    // rust: width - 6.0,
    // rust: 1.0,
    // rust: rgba(255, 255, 255, 90),
    // rust: );
}
}
}
