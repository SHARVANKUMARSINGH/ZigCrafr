//! Transpiled from Horizon Rust crate
//! Module: horizon-client_debug_chart
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The debug charts (26.3 `debugchart`): F3+2 shows the frame times and, in
//! single player, the integrated server's tick times; F3+3 the ping and, on a
//! remote server, the bandwidth. Each chart keeps the last 240 samples
//! (`LocalSampleLogger`) and draws one bar per sample over a 60 pixel high
//! box (`AbstractDebugChart`).
// use crate::{
    // rust: font::Font,
    // rust: hud_layout::{GuiDraw, argb, fill},
    // rust: text::Text,
}
// use std::{
    // rust: collections::VecDeque,
    // rust: time::{Duration, Instant},
}

/// `LocalSampleLogger.CAPACITY`.
pub const CAPACITY: usize = 240;
/// `AbstractDebugChart.CHART_HEIGHT`.
pub const CHART_HEIGHT: i32 = 60;
pub const TICK_SERVER_METHOD: usize = 1;
pub const SCHEDULED_TASKS: usize = 2;
pub const IDLE: usize = 3;

/// `LocalSampleLogger`: the last [`CAPACITY`] samples, oldest first; a
/// sample has up to four values (`TpsDebugDimensions`), the first the main.
pub const SampleLogger = struct {
    samples: VecDeque<[i64,
};
    // rust: impl SampleLogger {
    /// `logSample`.
pub fn log(self: *Self, value: i64) void {
}
    // rust: self.log_full([value, 0, 0, 0]);
}
    /// `logFullSample`.
pub fn log_full(self: *Self, sample: [i64; 4]) void {
}
    // rust: if self.samples.len() == CAPACITY {
    // rust: self.samples.pop_front();
}
    // rust: self.samples.push_back(sample);
}
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.samples.len()
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.samples.is_empty()
}
pub fn reset(self: *Self) void {
}
    // rust: self.samples.clear();
}
pub fn get(self: *Self, index: usize, dimension: usize) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.samples[index][dimension]
}
}

/// `DebugScreenOverlay`'s chart switches and the samples behind them.
pub const DebugCharts = struct {
    /// `renderFpsCharts` (F3+2).
    fps: bool,
    /// `renderNetworkCharts` (F3+3).
    network: bool,
    /// `renderLightmapTexture` (F3+4).
    lightmap: bool,
    /// `frameTimeLogger`: nanoseconds between frames.
    frame_times: SampleLogger,
    /// `tickTimeLogger`: the integrated server's ticks.
    tick_times: SampleLogger,
    /// `pingLogger`: milliseconds.
    ping: SampleLogger,
    /// `bandwidthLogger`: bytes received per tick.
    bandwidth: SampleLogger,
    /// `MinecraftServer.smoothedTickTimeMillis`.
    smoothed_tick_ms: f32,
    /// Connection's smoothed packets per second, sent then received.
    packet_rates: [f32,
    packet_totals: [i64,
    packet_tick: u8,
    previous_tick: ?Instant,
    bytes_seen: ?i64,
};
    // rust: impl DebugCharts {
    /// `toggleFpsCharts`; `overlay` is the debug overlay's visibility.
pub fn toggle_fps(self: *Self, overlay: *mut bool) void {
}
    // rust: self.fps = !*overlay || !self.fps;
    // rust: if self.fps {
    // rust: *overlay = true;
    // rust: self.network = false;
    // rust: self.lightmap = false;
}
}
    /// `toggleNetworkCharts`.
pub fn toggle_network(self: *Self, overlay: *mut bool) void {
}
    // rust: self.network = !*overlay || !self.network;
    // rust: if self.network {
    // rust: *overlay = true;
    // rust: self.fps = false;
    // rust: self.lightmap = false;
}
}
    /// `toggleLightmapTexture`.
pub fn toggle_lightmap(self: *Self, overlay: *mut bool) void {
}
    // rust: self.lightmap = !*overlay || !self.lightmap;
    // rust: if self.lightmap {
    // rust: *overlay = true;
    // rust: self.fps = false;
    // rust: self.network = false;
}
}
    /// `reset`: leaving a world.
pub fn reset(self: *Self) void {
}
    // rust: self.tick_times.reset();
    // rust: self.ping.reset();
    // rust: self.bandwidth.reset();
    // rust: self.previous_tick = None;
    // rust: self.bytes_seen = None;
    // rust: self.smoothed_tick_ms = 0.0;
    // rust: self.packet_rates = [0.0; 2];
    // rust: self.packet_totals = [0; 2];
    // rust: self.packet_tick = 0;
}
    /// One integrated server tick that started at `started` and ran its
    /// tick method for `method` (`MinecraftServer.logFullTickTime` and
    /// `logTickMethodTime`): the full tick runs from one start to the next,
    /// and what the tick method leaves of it is idle.
pub fn log_tick(self: *Self, started: Instant, method: Duration) void {
}
    // rust: let method = method.as_nanos() as i64;
    // rust: let full = self
    // rust: .previous_tick
    // rust: .map_or(method, |p| (started - p).as_nanos() as i64)
    // rust: .max(method);
    // rust: self.previous_tick = Some(started);
    // rust: self.tick_times.log_full([full, method, 0, full - method]);
    // rust: self.smoothed_tick_ms = self.smoothed_tick_ms * 0.8 + method as f32 / 1e6 * 0.199_999_99;
}
    /// `BandwidthDebugMonitor.tick`: the bytes received since the last
    /// tick, from the connection's running total.
pub fn log_bandwidth(self: *Self, total: i64) void {
}
    // rust: if let Some(seen) = self.bytes_seen {
    // rust: self.bandwidth.log(total - seen);
}
    // rust: self.bytes_seen = Some(total);
}
    /// `Connection.tickSecond`: sampled on the first tick, then every 20 ticks.
pub fn log_packets(self: *Self, totals: [i64; 2]) void {
}
    // rust: if self.packet_tick == 0 {
    // rust: for (i, total) in totals.into_iter().enumerate() {
    // rust: let count = (total - self.packet_totals[i]).max(0) as f32;
    // rust: self.packet_rates[i] = count + 0.75 * (self.packet_rates[i] - count);
}
    // rust: self.packet_totals = totals;
}
    // rust: self.packet_tick = (self.packet_tick + 1) % 20;
}
    /// Whether `draw` (or the lightmap view) puts something in the bottom
    /// left and the bottom right corner, for a `remote` server or not.
pub fn corners(self: *Self, remote: bool) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: self.fps || (self.network && remote),
    // rust: (self.fps && !self.tick_times.is_empty()) || self.network || self.lightmap,
    // rust: ]
}
    /// The charts along the bottom of the screen (`extractRenderState`):
    /// frame times left and tick times right, or bandwidth left (remote
    /// servers only) and ping right. `mspt` is the level's milliseconds
    /// per tick.
    // rust: pub fn draw(
    // rust: &self,
    // rust: font: &Font,
    // rust: width: i32,
    // rust: height: i32,
    // rust: framerate_limit: u32,
    // rust: mspt: f32,
    // rust: remote: bool,
    // rust: ) -> Vec<GuiDraw> {
    // rust: let mut out = Vec::new();
    // rust: let max_width = width / 2;
    // rust: let chart_width = Chart::width(max_width);
    // rust: if self.fps {
    // rust: let fps = Chart::Fps { framerate_limit };
    // rust: out.extend(fps.draw(font, &self.frame_times, 0, chart_width, height));
    // rust: if !self.tick_times.is_empty() {
    // rust: let tps = Chart::Tps { mspt };
    // rust: out.extend(tps.draw(
    // rust: font,
    // rust: &self.tick_times,
    // rust: width - chart_width,
    // rust: chart_width,
    // rust: height,
    // rust: ));
}
}
    // rust: if self.network {
    // rust: if remote {
    // rust: out.extend(Chart::Bandwidth.draw(font, &self.bandwidth, 0, chart_width, height));
}
    // rust: out.extend(Chart::Ping.draw(
    // rust: font,
    // rust: &self.ping,
    // rust: width - chart_width,
    // rust: chart_width,
    // rust: height,
    // rust: ));
}
    // rust: out
}
}

/// The lightmap view (`showLightmapTexture`): the 16 by 16 texture at 64
/// by 64 in the bottom right corner on a black border, sky light up and
/// block light right (the blit flips the texture's rows). `pixels` are RGBA
/// rows of sky level by block level.
pub fn lightmap(pixels: *[u8; 16 * 16 * 4], width: i32, height: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x, y) = (width - 64 - 2, height - 64 - 2);
    // rust: let mut out = vec![fill(x - 1, y - 1, x + 64 + 1, y + 64 + 1, 0xFF00_0000)];
    // rust: for (i, p) in pixels.as_chunks::<4>().0.iter().enumerate() {
    // rust: let (sky, block) = ((i / 16) as i32, (i % 16) as i32);
    // rust: let color = argb(255, u32::from(p[0]), u32::from(p[1]), u32::from(p[2]));
    // rust: let (cx, cy) = (x + block * 4, y + (15 - sky) * 4);
    // rust: out.push(fill(cx, cy, cx + 4, cy + 4, color));
}
    // rust: out
}

/// The four charts and what each needs to scale its bars.
pub const Chart = enum {
    /// `FpsDebugChart`: frame durations in nanoseconds; the frame rate limit
    /// option (`maxFps`).
    Fps { framerate_limit: u32 },
    /// `TpsDebugChart`: tick samples in nanoseconds; the level's
    /// milliseconds per tick.
    Tps { mspt: f32 },
    /// `PingDebugChart`: round trips in milliseconds.
    Ping,
    /// `BandwidthDebugChart`: bytes received per tick.
    Bandwidth,
};

/// The labels' colour and the backdrop of the box and shaded labels.
pub const LABEL: u32 = 0xFFE0_E0E0;
pub const BACKDROP: u32 = 0x9050_5050;
pub const WHITE: u32 = 0xFFFF_FFFF;
pub const GREEN: u32 = 0xFF00_FF00;
pub const YELLOW: u32 = 0xFFFF_FF00;
pub const RED: u32 = 0xFFFF_0000;
pub const CYAN: u32 = 0xFF00_FFFF;
/// `BandwidthDebugChart.MID_COLOR`.
pub const LAVENDER: u32 = 0xFFA0_A0FF;
/// `TpsDebugChart`'s bar parts.
pub const TICK_METHOD_COLOR: u32 = 0xFF99_1111;
pub const TASK_COLOR: u32 = 0xFFBA_995F;
pub const OTHER_COLOR: u32 = 0xFF5F_0E8C;
pub const MEGABYTE: f64 = 1_048_576.0;

    // rust: impl Chart {
    /// `AbstractDebugChart.getWidth`.
pub fn width(max_width: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (CAPACITY as i32 + 2).min(max_width)
}
    /// `AbstractDebugChart.extractRenderState`.
    // rust: pub fn draw(
    // rust: self,
    // rust: font: &Font,
    // rust: samples: &SampleLogger,
    // rust: left: i32,
    // rust: width: i32,
    // rust: bottom: i32,
    // rust: ) -> Vec<GuiDraw> {
    // rust: let mut out = vec![fill(
    // rust: left,
    // rust: bottom - CHART_HEIGHT,
    // rust: left + width,
    // rust: bottom,
    // rust: BACKDROP,
    // rust: )];
    // rust: let (mut sum, mut min, mut max) = (0i64, i64::from(i32::MAX), i64::from(i32::MIN));
    // rust: let start = CAPACITY.saturating_sub((width - 2).max(0) as usize);
    // rust: let count = samples.len().saturating_sub(start);
    // rust: for i in 0..count {
    // rust: let x = left + i as i32 + 1;
    // rust: let index = start + i;
    // rust: let value = self.aggregated(samples, index);
    // rust: min = min.min(value);
    // rust: max = max.max(value);
    // rust: sum += value;
    // rust: self.bars(&mut out, samples, bottom, x, index);
}
    // rust: horizontal_line(
    // rust: &mut out,
    // rust: left,
    // rust: left + width - 1,
    // rust: bottom - CHART_HEIGHT,
    // rust: WHITE,
    // rust: );
    // rust: horizontal_line(&mut out, left, left + width - 1, bottom - 1, WHITE);
    // rust: vertical_line(&mut out, left, bottom - CHART_HEIGHT, bottom, WHITE);
    // rust: vertical_line(
    // rust: &mut out,
    // rust: left + width - 1,
    // rust: bottom - CHART_HEIGHT,
    // rust: bottom,
    // rust: WHITE,
    // rust: );
    // rust: if count > 0 {
    // rust: let y = bottom - CHART_HEIGHT - 9;
    // rust: let min_text = format!("{} min", self.display(min as f64));
    // rust: let avg_text = format!("{} avg", self.display(sum as f64 / count as f64));
    // rust: let max_text = format!("{} max", self.display(max as f64));
    // rust: text(&mut out, min_text, left + 2, y, LABEL, true);
    // rust: let avg_x = left + width / 2 - font.width(&avg_text) as i32 / 2;
    // rust: text(&mut out, avg_text, avg_x, y, LABEL, true);
    // rust: let max_x = left + width - font.width(&max_text) as i32 - 2;
    // rust: text(&mut out, max_text, max_x, y, LABEL, true);
}
    // rust: self.lines_and_labels(&mut out, font, left, width, bottom);
    // rust: out
}
    // rust: fn bars(
    // rust: self,
    // rust: out: &mut Vec<GuiDraw>,
    // rust: samples: &SampleLogger,
    // rust: bottom: i32,
    // rust: x: i32,
    // rust: index: usize,
    // rust: ) {
    // rust: let value = samples.get(index, 0);
    // rust: let height = self.height(value as f64);
    // rust: out.push(fill(x, bottom - height, x + 1, bottom, self.color(value)));
    // rust: if let Chart::Tps { .. } = self {
    // rust: let method = samples.get(index, TICK_SERVER_METHOD);
    // rust: let method_h = self.height(method as f64);
    // rust: out.push(fill(x, bottom - method_h, x + 1, bottom, TICK_METHOD_COLOR));
    // rust: let tasks = samples.get(index, SCHEDULED_TASKS);
    // rust: let tasks_h = self.height(tasks as f64);
    // rust: out.push(fill(
    // rust: x,
    // rust: bottom - method_h - tasks_h,
    // rust: x + 1,
    // rust: bottom - method_h,
    // rust: TASK_COLOR,
    // rust: ));
    // rust: let other = value - samples.get(index, IDLE) - method - tasks;
    // rust: let other_h = self.height(other as f64);
    // rust: out.push(fill(
    // rust: x,
    // rust: bottom - other_h - tasks_h - method_h,
    // rust: x + 1,
    // rust: bottom - tasks_h - method_h,
    // rust: OTHER_COLOR,
    // rust: ));
}
}
    /// `getValueForAggregation`: a tick's time without its idle part.
pub fn aggregated(self: *Self, samples: *SampleLogger, index: usize) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Chart::Tps { .. } => samples.get(index, 0) - samples.get(index, IDLE),
    // rust: _ => samples.get(index, 0),
}
}
    /// `extractAdditionalLinesAndLabels`.
    // rust: fn lines_and_labels(
    // rust: self,
    // rust: out: &mut Vec<GuiDraw>,
    // rust: font: &Font,
    // rust: left: i32,
    // rust: width: i32,
    // rust: bottom: i32,
    // rust: ) {
    // rust: match self {
    // rust: Chart::Fps { framerate_limit } => {
    // rust: shaded(out, font, "30 fps", left + 1, bottom - CHART_HEIGHT + 1);
    // rust: shaded(out, font, "60 fps", left + 1, bottom - 30 + 1);
    // rust: horizontal_line(out, left, left + width - 1, bottom - 30, WHITE);
    // rust: if framerate_limit > 0 && framerate_limit <= 250 {
    // rust: let y = bottom - self.height(1.0e9 / f64::from(framerate_limit)) - 1;
    // rust: horizontal_line(out, left, left + width - 1, y, CYAN);
}
}
    // rust: Chart::Tps { mspt } => {
    // rust: let tps = 1000.0 / mspt;
    // rust: shaded(
    // rust: out,
    // rust: font,
    // rust: &format!("{tps:.1} tps"),
    // rust: left + 1,
    // rust: bottom - CHART_HEIGHT + 1,
    // rust: );
}
    // rust: Chart::Ping => shaded(out, font, "500 ms", left + 1, bottom - CHART_HEIGHT + 1),
    // rust: Chart::Bandwidth => {
    // rust: for bytes in [64.0, 1024.0, 16384.0] {
    // rust: let y = bottom - bandwidth_height(bytes);
    // rust: shaded(out, font, &bandwidth_display(bytes), left + 1, y + 1);
    // rust: horizontal_line(out, left, left + width - 1, y, WHITE);
}
    // rust: let y = bottom - bandwidth_height(MEGABYTE) + 1;
    // rust: shaded(out, font, &bandwidth_display(MEGABYTE), left + 1, y);
}
}
}
    /// `toDisplayString`.
pub fn display(self: *Self, sample: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Chart::Fps { .. } | Chart::Tps { .. } => format!("{} ms", java_round(sample / 1.0e6)),
    // rust: Chart::Ping => format!("{} ms", java_round(sample)),
    // rust: Chart::Bandwidth => bandwidth_display(sample * 20.0),
}
}
    /// `getSampleHeight`.
pub fn height(self: *Self, sample: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Chart::Fps { .. } => java_round(sample / 1.0e6 * 60.0 / 33.333333333333336) as i32,
    // rust: Chart::Tps { mspt } => java_round(sample / 1.0e6 * 60.0 / f64::from(mspt)) as i32,
    // rust: Chart::Ping => java_round(sample * 60.0 / 500.0) as i32,
    // rust: Chart::Bandwidth => bandwidth_height(sample * 20.0),
}
}
    /// `getSampleColor`.
pub fn color(self: *Self, sample: i64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = sample as f64;
    // rust: match self {
    // rust: Chart::Fps { .. } => gradient(s / 1.0e6, 0.0, GREEN, 28.0, YELLOW, 56.0, RED),
    // rust: Chart::Tps { mspt } => {
    // rust: let m = f64::from(mspt);
    // rust: gradient(s / 1.0e6, m, GREEN, m * 1.125, YELLOW, m * 1.25, RED)
}
    // rust: Chart::Ping => gradient(s, 0.0, GREEN, 250.0, YELLOW, 500.0, RED),
    // rust: Chart::Bandwidth => gradient(s * 20.0, 0.0, CYAN, 8192.0, LAVENDER, 1.048576e7, RED),
}
}
}

/// `BandwidthDebugChart.toDisplayStringInternal`.
pub fn bandwidth_display(bytes_per_second: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if bytes_per_second >= MEGABYTE {
    // rust: format!("{:.1} MiB/s", bytes_per_second / MEGABYTE)
    // rust: } else if bytes_per_second >= 1024.0 {
    // rust: format!("{:.1} KiB/s", bytes_per_second / 1024.0)
    // rust: } else {
    // rust: format!("{} B/s", bytes_per_second.floor() as i64)
}
}
/// `BandwidthDebugChart.getSampleHeightInternal`: logarithmic, 1 MiB/s at
/// the top.
pub fn bandwidth_height(bytes_per_second: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: java_round((bytes_per_second + 1.0).ln() * 60.0 / MEGABYTE.ln()) as i32
}
/// `Math.round(double)`: halves round up.
pub fn java_round(v: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (v + 0.5).floor() as i64
}
/// `AbstractDebugChart.getSampleColor(sample, min, minColor, mid, ...)`.
    // rust: fn gradient(
    // rust: sample: f64,
    // rust: min: f64,
    // rust: min_color: u32,
    // rust: mid: f64,
    // rust: mid_color: u32,
    // rust: max: f64,
    // rust: max_color: u32,
    // rust: ) -> u32 {
    // rust: let sample = sample.clamp(min, max);
    // rust: if sample < mid {
    // rust: srgb_lerp(((sample - min) / (mid - min)) as f32, min_color, mid_color)
    // rust: } else {
    // rust: srgb_lerp(((sample - mid) / (max - mid)) as f32, mid_color, max_color)
}
}
/// `ARGB.srgbLerp`: each channel by `Mth.lerpInt`.
pub fn srgb_lerp(alpha: f32, p0: u32, p1: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let channel = |shift: u32| {
    // rust: let (a, b) = (((p0 >> shift) & 255) as i32, ((p1 >> shift) & 255) as i32);
    // rust: (a + (alpha * (b - a) as f32).floor() as i32) as u32
}
    // rust: argb(channel(24), channel(16), channel(8), channel(0))
}
/// `GuiGraphicsExtractor.horizontalLine`.
pub fn horizontal_line(out: *mut std.ArrayList(GuiDraw), x0: i32, x1: i32, y: i32, color: u32) void {
}
    // rust: out.push(fill(x0.min(x1), y, x0.max(x1) + 1, y + 1, color));
}
/// `GuiGraphicsExtractor.verticalLine`.
pub fn vertical_line(out: *mut std.ArrayList(GuiDraw), x: i32, y0: i32, y1: i32, color: u32) void {
}
    // rust: out.push(fill(x, y0.min(y1) + 1, x + 1, y0.max(y1), color));
}
pub fn text(out: *mut std.ArrayList(GuiDraw), s: []const u8, x: i32, y: i32, color: u32, shadow: bool) void {
}
    // rust: out.push(GuiDraw::Text {
    // rust: text: Text::literal(s),
    // rust: x,
    // rust: y,
    // rust: color,
    // rust: shadow,
    // rust: });
}
/// `extractStringWithShade`: a label on a dark backdrop, without shadow.
pub fn shaded(out: *mut std.ArrayList(GuiDraw), font: *Font, s: []const u8, x: i32, y: i32) void {
}
    // rust: out.push(fill(x, y, x + font.width(s) as i32 + 1, y + 9, BACKDROP));
    // rust: text(out, s.to_owned(), x + 1, y + 1, LABEL, false);
}

    // rust: mod tests {
//     use super::*;

pub fn the_logger_keeps_the_last_240_samples() void {
}
    // rust: let mut l = SampleLogger::default();
    // rust: for i in 0..300 {
    // rust: l.log(i);
}
    // rust: assert_eq!(l.len(), CAPACITY);
    // rust: assert_eq!(l.get(0, 0), 60);
    // rust: assert_eq!(l.get(CAPACITY - 1, 0), 299);
}

pub fn chart_toggles_show_the_overlay_and_exclude_each_other() void {
}
    // rust: let mut c = DebugCharts::default();
    // rust: let mut overlay = false;
    // rust: c.toggle_fps(&mut overlay);
    // rust: assert!(overlay && c.fps);
    // rust: c.toggle_network(&mut overlay);
    // rust: assert!(c.network && !c.fps);
    // rust: c.toggle_network(&mut overlay);
    // rust: assert!(!c.network && overlay);
    // rust: c.toggle_lightmap(&mut overlay);
    // rust: c.toggle_fps(&mut overlay);
    // rust: assert!(c.fps && !c.lightmap);
        // With the overlay hidden, the key shows it again with the chart on.
    // rust: c.toggle_fps(&mut overlay);
    // rust: overlay = false;
    // rust: c.toggle_fps(&mut overlay);
    // rust: assert!(overlay && c.fps);
}

pub fn corners_are_where_the_charts_are_drawn() void {
}
    // rust: let mut c = DebugCharts::default();
    // rust: assert_eq!(c.corners(true), [false, false]);
        // Frame times left; tick times right once the server logged a tick.
    // rust: c.fps = true;
    // rust: assert_eq!(c.corners(false), [true, false]);
    // rust: c.tick_times.log(1);
    // rust: assert_eq!(c.corners(false), [true, true]);
        // Ping right; bandwidth left on a remote server only.
    // rust: c.fps = false;
    // rust: c.network = true;
    // rust: assert_eq!(c.corners(false), [false, true]);
    // rust: assert_eq!(c.corners(true), [true, true]);
        // The lightmap view, bottom right.
    // rust: c.network = false;
    // rust: c.lightmap = true;
    // rust: assert_eq!(c.corners(true), [false, true]);
}

pub fn the_lightmap_puts_full_sky_light_at_the_top_left() void {
}
    // rust: let mut pixels = [0u8; 16 * 16 * 4];
        // Sky 15, block 0: the last row's first texel.
    // rust: pixels[15 * 64..15 * 64 + 4].copy_from_slice(&[10, 20, 30, 255]);
    // rust: let draws = lightmap(&pixels, 427, 240);
    // rust: assert_eq!(draws[0], fill(360, 173, 426, 239, 0xFF00_0000));
    // rust: assert_eq!(draws.len(), 257);
    // rust: assert!(draws.contains(&fill(361, 174, 365, 178, 0xFF0A_141E)));
}

pub fn packet_rates_follow_connection_smoothing_and_reset_between_worlds() void {
}
    // rust: let mut charts = DebugCharts::default();
    // rust: charts.log_packets([80, 400]);
    // rust: assert_eq!(charts.packet_rates, [20.0, 100.0]);
    // rust: for _ in 1..20 {
    // rust: charts.log_packets([180, 800]);
}
    // rust: assert_eq!(charts.packet_rates, [20.0, 100.0]);
    // rust: charts.log_packets([180, 800]);
    // rust: assert_eq!(charts.packet_rates, [40.0, 175.0]);
    // rust: for _ in 0..20 {
    // rust: charts.log_packets([180, 800]);
}
    // rust: assert_eq!(charts.packet_rates, [30.0, 131.25]);
    // rust: charts.reset();
    // rust: assert_eq!(charts.packet_rates, [0.0, 0.0]);
    // rust: charts.log_packets([4, 8]);
    // rust: assert_eq!(charts.packet_rates, [1.0, 2.0]);
}

pub fn ticks_and_bandwidth_log_their_differences() void {
}
    // rust: let mut c = DebugCharts::default();
    // rust: let t0 = Instant::now();
    // rust: c.log_tick(t0, Duration::from_millis(5));
    // rust: c.log_tick(t0 + Duration::from_millis(50), Duration::from_millis(7));
    // rust: assert_eq!(
    // rust: c.tick_times.samples[1],
    // rust: [50_000_000, 7_000_000, 0, 43_000_000]
    // rust: );
    // rust: c.log_bandwidth(1000);
    // rust: c.log_bandwidth(1600);
    // rust: assert_eq!(c.bandwidth.len(), 1);
    // rust: assert_eq!(c.bandwidth.get(0, 0), 600);
}

pub fn heights_match_vanilla_scales() void {
}
    // rust: let fps = Chart::Fps {
    // rust: framerate_limit: 260,
}
        // 33.3 ms (30 fps) fills the chart; 16.7 ms half of it.
    // rust: assert_eq!(fps.height(33_333_333.0), 60);
    // rust: assert_eq!(fps.height(16_666_667.0), 30);
    // rust: let tps = Chart::Tps { mspt: 50.0 };
    // rust: assert_eq!(tps.height(25e6), 30);
    // rust: assert_eq!(Chart::Ping.height(250.0), 30);
        // 1 MiB/s at the top; 52 bytes per tick is 1 KiB/s.
    // rust: assert_eq!(bandwidth_height(MEGABYTE), 60);
    // rust: assert_eq!(Chart::Bandwidth.height(51.2), 30);
}

pub fn labels_match_vanilla_formats() void {
}
    // rust: assert_eq!(
    // rust: Chart::Fps { framerate_limit: 0 }.display(16_500_000.0),
    // rust: "17 ms"
    // rust: );
    // rust: assert_eq!(Chart::Ping.display(12.4), "12 ms");
    // rust: assert_eq!(Chart::Bandwidth.display(3.0), "60 B/s");
    // rust: assert_eq!(Chart::Bandwidth.display(100.0), "2.0 KiB/s");
    // rust: assert_eq!(bandwidth_display(MEGABYTE), "1.0 MiB/s");
}

pub fn colours_go_green_yellow_red() void {
}
    // rust: let fps = Chart::Fps { framerate_limit: 0 };
    // rust: assert_eq!(fps.color(0), GREEN);
    // rust: assert_eq!(fps.color(28_000_000), YELLOW);
    // rust: assert_eq!(fps.color(100_000_000), RED);
        // Halfway between green and yellow: Mth.lerpInt floors.
    // rust: assert_eq!(fps.color(14_000_000), 0xFF7F_FF00);
    // rust: let tps = Chart::Tps { mspt: 50.0 };
    // rust: assert_eq!(tps.color(10_000_000), GREEN);
    // rust: assert_eq!(Chart::Bandwidth.color(0), CYAN);
}
}
