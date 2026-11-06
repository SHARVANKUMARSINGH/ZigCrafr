//! Transpiled from Horizon Rust crate
package horizon_client_input_window

import "core:fmt"
import "core:mem"
import "core:math"

// Window sizing and frame pacing of 26.3: `Window.calculateScale` and
// `setGuiScale`, `MouseHandler`'s scaled positions, `FramerateLimitTracker`,
// `FramerateLimiter`, the vsync present-mode choice and the fullscreen
// request/state pair.

// `Window.calculateScale`: the largest scale that leaves at least 320x240
// GUI pixels, capped by `max_scale` (0 = automatic); an odd result is bumped
// to even when unicode is enforced.
calculate_scale :: proc(framebuffer: [i32; 2], max_scale: i32, enforce_unicode: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let [width, height] = framebuffer;
    // rust: let mut scale = 1;
    // rust: while scale != max_scale
    // rust: && scale < width
    // rust: && scale < height
    // rust: && width / (scale + 1) >= 320
    // rust: && height / (scale + 1) >= 240
    // rust: {
    // rust: scale += 1;
}
    // rust: if enforce_unicode && scale % 2 != 0 {
    // rust: scale += 1;
}
    // rust: scale
}

// `Window.setGuiScale`: the GUI-scaled size of a framebuffer.
gui_scaled_size :: proc(framebuffer: [i32; 2], gui_scale: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let scaled = |v: i32| (f64::from(v) / f64::from(gui_scale)).ceil() as i32;
    // rust: [scaled(framebuffer[0]), scaled(framebuffer[1])]
}

// `MouseHandler.getScaledXPos`/`getScaledYPos`.
scaled_pos :: proc(pos: f64, gui_scaled: i32, screen: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: pos * f64::from(gui_scaled) / f64::from(screen)
}

// `InactivityFpsLimit`.
InactivityFpsLimit :: enum {
    Minimized,
    Afk,
}

// `FramerateLimitTracker.FramerateThrottleReason`.
ThrottleReason :: enum {
    None,
    WindowIconified,
    LongAfk,
    ShortAfk,
    OutOfLevelMenu,
}

// What `FramerateLimitTracker` looks at.
FrameContext :: struct {
    inactivity: InactivityFpsLimit,
    iconified: bool,
    focused: bool,
    exclusive_fullscreen: bool,
    now_ms: i64,
    latest_input_ms: i64,
    has_level: bool,
    has_screen: bool,
    has_overlay: bool,
}

// `getThrottleReason`.
throttle_reason :: proc(c: FrameContext) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if !c.iconified && (c.focused || !c.exclusive_fullscreen) {
    // rust: if c.inactivity == InactivityFpsLimit::Afk {
    // rust: let afk = c.now_ms - c.latest_input_ms;
    // rust: if afk > 600_000 {
    // rust: return ThrottleReason::LongAfk;
}
    // rust: if afk > 60_000 {
    // rust: return ThrottleReason::ShortAfk;
}
}
    // rust: if c.has_level || (!c.has_screen && !c.has_overlay) {
    // rust: ThrottleReason::None
    // rust: } else {
    // rust: ThrottleReason::OutOfLevelMenu
}
    // rust: } else {
    // rust: ThrottleReason::WindowIconified
}
}

// `getFramerateLimit`.
framerate_limit :: proc(option_limit: i32, c: FrameContext) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match throttle_reason(c) {
    // rust: ThrottleReason::None => option_limit,
    // rust: ThrottleReason::WindowIconified | ThrottleReason::LongAfk => 10,
    // rust: ThrottleReason::ShortAfk => option_limit.min(30),
    // rust: ThrottleReason::OutOfLevelMenu => 60,
}
}

// `isHeavilyThrottled`.
heavily_throttled :: proc(reason: ThrottleReason) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: reason,
    // rust: ThrottleReason::WindowIconified | ThrottleReason::LongAfk
    // rust: )
}

// Present modes the renderer can choose between.
PresentMode :: enum {
    Fifo,
    Mailbox,
    Immediate,
}

// `GpuSurface.PresentMode.getSupportedVsyncMode`: vsync means Fifo only,
// otherwise the first of Immediate, Mailbox, Fifo that is supported.
vsync_present_mode :: proc(supported: ^[PresentMode], vsync: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let preferred: &[PresentMode] = if vsync {
    // rust: &[PresentMode::Fifo]
    // rust: } else {
    // rust: &[
    // rust: PresentMode::Immediate,
    // rust: PresentMode::Mailbox,
    // rust: PresentMode::Fifo,
    // rust: ]
}
    // rust: preferred.iter().copied().find(|m| supported.contains(m))
}

// The present mode for the VSync option and Horizon's present-mode setting
// (`None` for Auto). VSync on always means Fifo, in a window and in
// fullscreen alike, as in vanilla; the setting chooses only while VSync is
// off, when the surface supports it, and otherwise vanilla's choice applies.
    // rust: pub fn chosen_present_mode(
    // rust: supported: &[PresentMode],
    // rust: vsync: bool,
    // rust: setting: Option<PresentMode>,
    // rust: ) -> Option<PresentMode> {
    // rust: setting
    // rust: .filter(|m| !vsync && supported.contains(m))
    // rust: .or_else(|| vsync_present_mode(supported, vsync))
}

// `FramerateLimiter.limitDisplayFPS` with an injectable clock so the sleep
// and spin decisions are testable.
FramerateLimiter :: struct {
    last_frame_time: i64,
    average_overshoot_ns: i64,
    last_framerate_limit: i32,
}

// Time source of the limiter.
    // rust: pub trait LimiterClock {
nanos :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // `LockSupport.parkNanos`.
park :: proc(self: ^Self, nanos: i64) {
}
    // `Thread.onSpinWait`.
spin :: proc(self: ^Self) {
}
    // `Thread.interrupted`: an interrupted limiter skips that sleep.
interrupted :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
}

// The real clock: `System.nanoTime` from a fixed origin, sleeping for
// `LockSupport.parkNanos` and a CPU spin hint for `Thread.onSpinWait`.
SystemClock :: struct {
    origin: std::time::Instant,
}
    // rust: impl Default for SystemClock {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: origin: std::time::Instant::now(),
}
}
}
    // rust: impl LimiterClock for SystemClock {
nanos :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: i64::try_from(self.origin.elapsed().as_nanos()).unwrap_or(i64::MAX)
}
park :: proc(self: ^Self, nanos: i64) {
}
    // rust: let end = self.nanos().saturating_add(nanos);
    // rust: park_in_steps(
    // rust: end,
    // rust: || self.nanos(),
    // rust: |step| {
    // rust: std::thread::sleep(std::time::Duration::from_nanos(step as u64));
    // rust: },
    // rust: );
}
spin :: proc(self: ^Self) {
}
    // rust: std::hint::spin_loop();
}
}

// The longest single sleep of [`SystemClock::park`].
PARK_STEP_NS :: 1_000_000

// Sleeps until `now()` reaches `end`, at most [`PARK_STEP_NS`] at a time. macOS lets
// a sleep run late by a share of its length (timer coalescing: 1.8-3.5 ms on a 14 ms
// sleep, 0.25 ms on 1 ms), more than the limiter's overshoot margin can learn (capped
// at 2 ms): a 60 FPS cap gave frames of 17-20 ms. Short steps keep the lateness to
// the last step's.
park_in_steps :: proc(end: i64, mut now: impl FnMut() -> i {
    // Ported from Horizon
    return {}
}
    // rust: loop {
    // rust: let left = end - now();
    // rust: if left <= 0 {
    // rust: return;
}
    // rust: sleep(left.min(PARK_STEP_NS));
}
}

// The real clock without busy waiting: where vanilla spins on
// `Thread.onSpinWait` for the last half millisecond, this sleeps in short
// steps, so a capped frame rate leaves the core idle.
SleepingClock :: struct {
    // rust: impl LimiterClock for SleepingClock {
nanos :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0.nanos()
}
park :: proc(self: ^Self, nanos: i64) {
}
    // rust: self.0.park(nanos);
}
spin :: proc(self: ^Self) {
}
    // rust: std::thread::sleep(std::time::Duration::from_micros(50));
}
}

// `Minecraft.runTick`'s frame-limiter step: only limits below 260
// (the "unlimited" setting) pace frames.
    // rust: pub fn end_frame(
    // rust: limiter: &mut FramerateLimiter,
    // rust: framerate_limit: i32,
    // rust: clock: &mut impl LimiterClock,
    // rust: ) {
    // rust: if framerate_limit < 260 {
    // rust: limiter.limit_display_fps(framerate_limit, clock);
}
}

// [`end_frame`] on a fixed grid of frame slots ([`FramerateLimiter::limit_on_grid`]):
// Horizon's Efficient pacing.
    // rust: pub fn end_frame_on_grid(
    // rust: limiter: &mut FramerateLimiter,
    // rust: framerate_limit: i32,
    // rust: clock: &mut impl LimiterClock,
    // rust: ) {
    // rust: if framerate_limit < 260 {
    // rust: limiter.limit_on_grid(framerate_limit, clock);
}
}

    // rust: impl FramerateLimiter {
new :: proc(now_ns: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::with_state(now_ns, 0, 0)
}
    // The limiter's static state: `lastFrameTime`, `averageOvershootNs`
    // and `lastFramerateLimit`.
    // rust: pub fn with_state(
    // rust: last_frame_time: i64,
    // rust: average_overshoot_ns: i64,
    // rust: last_framerate_limit: i32,
    // rust: ) -> Self {
    // rust: Self {
    // rust: last_frame_time,
    // rust: average_overshoot_ns,
    // rust: last_framerate_limit,
}
}
average_overshoot_ns :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.average_overshoot_ns
}
last_framerate_limit :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.last_framerate_limit
}
limit_display_fps :: proc(self: ^Self, framerate_limit: i32, clock: ^impl LimiterClock) {
}
    // rust: let target_time_per_frame = 1_000_000_000 / i64::from(framerate_limit);
    // rust: let target_time_ns = self.last_frame_time + target_time_per_frame;
    // rust: if framerate_limit != self.last_framerate_limit {
    // rust: self.average_overshoot_ns = 0;
    // rust: self.last_framerate_limit = framerate_limit;
}
    // rust: self.wait_until(target_time_ns, clock);
    // rust: self.last_frame_time = clock.nanos();
}
    // Horizon's Efficient pacing: [`Self::limit_display_fps`]'s wait, but each frame's
    // slot starts where the last one's ended (its deadline), not when the thread woke
    // up. Vanilla's way adds every late wake-up to the frame (on the Mac, 50 us sleeps
    // running 0.2 ms late made a 144 FPS cap 139); on a fixed grid the cap holds on
    // average. A frame that ends past its slot, or wakes up more than half a frame
    // late, starts the grid again from now: no frame is rushed out to catch up.
limit_on_grid :: proc(self: ^Self, framerate_limit: i32, clock: ^impl LimiterClock) {
}
    // rust: let period = 1_000_000_000 / i64::from(framerate_limit);
    // rust: if framerate_limit != self.last_framerate_limit {
    // rust: self.average_overshoot_ns = 0;
    // rust: self.last_framerate_limit = framerate_limit;
}
    // rust: let deadline = self.last_frame_time + period;
    // rust: if clock.nanos() >= deadline {
    // rust: self.last_frame_time = clock.nanos();
    // rust: return;
}
    // rust: self.wait_until(deadline, clock);
    // rust: let woke = clock.nanos();
    // rust: self.last_frame_time = if woke - deadline > period / 2 {
    // rust: woke
    // rust: } else {
    // rust: deadline
}
}
    // `limitDisplayFPS`'s wait: sleep to within the learned overshoot and half a
    // millisecond of `target_time_ns`, then spin.
wait_until :: proc(self: ^Self, target_time_ns: i64, clock: ^impl LimiterClock) {
}
    // rust: loop {
    // rust: let remaining = target_time_ns - clock.nanos();
    // rust: if remaining <= 0 {
    // rust: break;
}
    // rust: if remaining > self.average_overshoot_ns + 500_000 {
    // rust: let sleep_start = clock.nanos();
    // rust: let expected = remaining - self.average_overshoot_ns - 500_000;
    // rust: if !clock.interrupted() {
    // rust: clock.park(expected);
    // rust: let duration = clock.nanos() - sleep_start;
    // rust: let overshoot = duration - expected;
    // rust: if overshoot > 0 && overshoot < 25_000_000 {
    // rust: self.average_overshoot_ns = (0.1 * overshoot as f64
    // rust: + 0.9 * self.average_overshoot_ns as f64)
    // rust: as i64;
    // rust: self.average_overshoot_ns = self.average_overshoot_ns.min(2_000_000);
}
}
    // rust: } else {
    // rust: clock.spin();
}
}
}
last_frame_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.last_frame_time
}
}

// blaze3d `Window`'s `fullscreenRequested` / `fullscreen` pair. The window
// system has the last word: a change it makes on its own (a compositor
// shortcut, a window rule) is adopted by the Fullscreen option
// (`Window.updateFullscreenState` -> `Minecraft.fullscreenStateChanged`), and
// the window is only asked to change when the option itself changes
// (`Window.updateFullscreenIfChanged`), never re-forced to the option.
FullscreenState :: struct {
    // The state the window system last reported (`Window.fullscreen`).
    actual: bool,
    // The state last asked of the window system, or adopted from it.
    requested: bool,
    // `Window.exclusiveFullscreen`.
    exclusive: bool,
    // `Window.preferredFullscreenVideoMode`.
    mode: Maybe(VideoMode),
    // `Window.dirty`: the preferred mode changed and the screen has not been left yet.
    mode_dirty: bool,
}

    // rust: impl FullscreenState {
    // A window created windowed or, when `requested`, asked to be fullscreen.
new :: proc(requested: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: actual: false,
    // rust: requested,
    // rust: exclusive: false,
    // rust: mode: None,
    // rust: mode_dirty: false,
}
}

    // `Window.updateFullscreenIfChanged` with the exclusive option and preferred mode: asks the
    // window to enter, leave or change its fullscreen only when one of them changed.
    // `in_video_screen` holds a changed mode back until the Video Settings screen closes
    // (`changeFullscreenVideoMode`).
    // rust: pub fn apply(
    // rust: &mut self,
    // rust: window: &winit::window::Window,
    // rust: wanted: bool,
    // rust: exclusive: bool,
    // rust: preferred: Option<VideoMode>,
    // rust: in_video_screen: bool,
    // rust: ) {
    // rust: let request = self.request(wanted);
    // rust: let reapply = self.set_exclusive(exclusive);
    // rust: self.set_preferred_mode(preferred);
    // rust: let mode_change = !in_video_screen && self.take_mode_change();
    // rust: match request {
    // rust: Some(false) => window.set_fullscreen(None),
    // rust: Some(true) => window.set_fullscreen(Some(fullscreen_request(
    // rust: window,
    // rust: exclusive,
    // rust: preferred.as_ref(),
    // rust: ))),
    // rust: None if reapply || mode_change => window.set_fullscreen(Some(fullscreen_request(
    // rust: window,
    // rust: exclusive,
    // rust: preferred.as_ref(),
    // rust: ))),
    // rust: None => {}
}
}

    // `Window.setExclusiveFullscreen`: true when the option changed while fullscreen is
    // requested, so the window has to enter the other kind of fullscreen at once.
set_exclusive :: proc(self: ^Self, exclusive: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let changed = self.exclusive != exclusive;
    // rust: self.exclusive = exclusive;
    // rust: changed && self.requested
}

    // `Window.setPreferredFullscreenVideoMode`: a changed mode waits for `take_mode_change`.
set_preferred_mode :: proc(self: ^Self, mode: Maybe(VideoMode)) {
}
    // rust: if self.mode != mode {
    // rust: self.mode = mode;
    // rust: self.mode_dirty = true;
}
}

    // `Window.changeFullscreenVideoMode` (the Video Settings screen closing): true once when
    // a changed mode has to be applied to a fullscreen window.
take_mode_change :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let apply = self.requested && self.mode_dirty;
    // rust: if apply {
    // rust: self.mode_dirty = false;
}
    // rust: apply
}

    // `Window.updateFullscreenIfChanged`: the state to ask of the window
    // when the option `wanted` differs from what was last asked or adopted.
request :: proc(self: ^Self, wanted: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (wanted != self.requested).then(|| {
    // rust: self.requested = wanted;
    // rust: wanted
    // rust: })
}

    // `Window.updateFullscreenState`: the window now reports `now`; returns
    // it when it changed, for the option to adopt.
observe :: proc(self: ^Self, now: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (now != self.actual).then(|| {
    // rust: self.actual = now;
    // rust: self.requested = now;
    // rust: now
    // rust: })
}
}

// `VideoMode`: one display mode of a monitor, as `fullscreenResolution` in options.txt keeps it.
VideoMode :: struct {
    width: i32,
    height: i32,
    red_bits: i32,
    green_bits: i32,
    blue_bits: i32,
    refresh_rate: f32,
}

    // rust: impl VideoMode {
    // `VideoMode.read`: the JSON object `write` makes; any other string is None.
read :: proc(text: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let number = |key: &str| -> Option<f64> {
    // rust: let at = text.find(&format!("\"{key}\""))? + key.len() + 2;
    // rust: let rest = text[at..].trim_start().strip_prefix(':')?.trim_start();
    // rust: let end = rest
    // rust: .find(|c: char| !(c.is_ascii_digit() || matches!(c, '-' | '+' | '.' | 'e' | 'E')))
    // rust: .unwrap_or(rest.len());
    // rust: rest[..end].parse().ok()
}
    // rust: if !text.trim_start().starts_with('{') {
    // rust: return None;
}
    // rust: Some(Self {
    // rust: width: number("width")? as i32,
    // rust: height: number("height")? as i32,
    // rust: red_bits: number("red_bits")? as i32,
    // rust: green_bits: number("green_bits")? as i32,
    // rust: blue_bits: number("blue_bits")? as i32,
    // rust: refresh_rate: number("refresh_rate")? as f32,
    // rust: })
}

    // `VideoMode.write`: the Codec's JSON through Gson (a float prints as `60.0`).
write :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let rate = if self.refresh_rate == self.refresh_rate.trunc() {
    // rust: format!("{:.1}", self.refresh_rate)
    // rust: } else {
    // rust: self.refresh_rate.to_string()
}
    // rust: format!(
    // rust: "{{\"width\":{},\"height\":{},\"red_bits\":{},\"green_bits\":{},\"blue_bits\":{},\"refresh_rate\":{rate}}}",
    // rust: self.width, self.height, self.red_bits, self.green_bits, self.blue_bits
    // rust: )
}

    // `VideoMode.refreshRateLabel`: a whole rate without decimals, any other with two.
refresh_rate_label :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if self.refresh_rate == self.refresh_rate.round_ties_even() {
    // rust: (self.refresh_rate as i32).to_string()
    // rust: } else {
    // rust: format!("{:.2}", self.refresh_rate)
}
}

    // The colour depth `options.fullscreen.entry` shows.
bits :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.red_bits + self.green_bits + self.blue_bits
}

    // A winit mode: its depth is the total, split evenly over the channels.
from_winit :: proc(mode: ^winit::monitor::VideoModeHandle) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let depth = i32::from(mode.bit_depth());
    // rust: let size = mode.size();
    // rust: Self {
    // rust: width: size.width as i32,
    // rust: height: size.height as i32,
    // rust: red_bits: depth / 3,
    // rust: green_bits: depth / 3,
    // rust: blue_bits: depth - 2 * (depth / 3),
    // rust: refresh_rate: mode.refresh_rate_millihertz() as f32 / 1000.0,
}
}
}

// `Monitor.videoModes`: the modes a monitor offers.
monitor_video_modes :: proc(monitor: ^winit::monitor::MonitorHandle) -> V {
    // Ported from Horizon
    return {}
}
    // rust: monitor
    // rust: .video_modes()
    // rust: .map(|m| VideoMode::from_winit(&m))
    // rust: .collect()
}

// The video modes of the window's monitor, listed once per monitor. Listing them takes tens of
// milliseconds on Windows, and settings apply at every step of a dragged slider: listing them
// each time made the slider stutter.
VideoModeList :: struct {
    listed: Maybe(M),
}

    // rust: impl<M> Default for VideoModeList<M> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { listed: None }
}
}

    // rust: impl<M: PartialEq> VideoModeList<M> {
    // The modes of `monitor` when it is not the monitor listed last, else `None` (the list
    // stands). No monitor lists none.
    // rust: pub fn refresh(
    // rust: &mut self,
    // rust: monitor: Option<M>,
    // rust: list: impl FnOnce(&M) -> Vec<VideoMode>,
    // rust: ) -> Option<Vec<VideoMode>> {
    // rust: if monitor.is_some() && monitor == self.listed {
    // rust: return None;
}
    // rust: let modes = monitor.as_ref().map(list).unwrap_or_default();
    // rust: self.listed = monitor;
    // rust: Some(modes)
}
}

// `Monitor.currentMode`: the monitor's desktop mode; winit has no such query, so the mode of
// the monitor's own size with the highest refresh rate and depth.
    // rust: fn monitor_current_mode(
    // rust: monitor: &winit::monitor::MonitorHandle,
    // rust: ) -> Option<winit::monitor::VideoModeHandle> {
    // rust: let size = monitor.size();
    // rust: monitor
    // rust: .video_modes()
    // rust: .filter(|m| m.size() == size)
    // rust: .max_by_key(|m| (m.refresh_rate_millihertz(), m.bit_depth()))
}

// `Window.applyFullscreen`: the fullscreen the window asks for. Exclusive fullscreen takes
// `Monitor.getPreferredVideoMode` (the preferred mode if the monitor has it, else the desktop
// mode); a monitor with no usable mode falls back to borderless, as vanilla does.
    // rust: pub fn fullscreen_request(
    // rust: window: &winit::window::Window,
    // rust: exclusive: bool,
    // rust: preferred: Option<&VideoMode>,
    // rust: ) -> winit::window::Fullscreen {
//     use winit::window::Fullscreen;
    // rust: if !exclusive {
    // rust: return Fullscreen::Borderless(None);
}
    // rust: let Some(monitor) = window
    // rust: .current_monitor()
    // rust: .or_else(|| window.primary_monitor())
    // rust: else {
    // rust: return Fullscreen::Borderless(None);
}
    // rust: let wanted = preferred.and_then(|p| {
    // rust: monitor
    // rust: .video_modes()
    // rust: .find(|m| VideoMode::from_winit(m) == *p)
    // rust: });
    // rust: match wanted.or_else(|| monitor_current_mode(&monitor)) {
    // rust: Some(mode) => Fullscreen::Exclusive(mode),
    // rust: None => Fullscreen::Borderless(None),
}
}

// Horizon's icon for the window's title bar and the task bar (X11 and Windows; Wayland takes
// it from the `horizon.desktop` entry, macOS from the app bundle). `None` if it can't be read.
icon :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut decoder = png::Decoder::new(std::io::Cursor::new(horizon_theme::ICON_PNG));
    // rust: decoder.ignore_checksums(true);
    // rust: decoder.set_transformations(png::Transformations::EXPAND | png::Transformations::STRIP_16);
    // rust: let mut reader = decoder.read_info().ok()?;
    // rust: let mut bytes = vec![0; reader.output_buffer_size()?];
    // rust: let info = reader.next_frame(&mut bytes).ok()?;
    // rust: if info.color_type != png::ColorType::Rgba {
    // rust: return None;
}
    // rust: bytes.truncate(info.buffer_size());
    // rust: winit::window::Icon::from_rgba(bytes, info.width, info.height).ok()
}

    // rust: mod tests {
//     use super::*;

video_mode_round_trips_the_options_json :: proc() {
}
    // rust: let mode = VideoMode {
    // rust: width: 1920,
    // rust: height: 1080,
    // rust: red_bits: 8,
    // rust: green_bits: 8,
    // rust: blue_bits: 8,
    // rust: refresh_rate: 60.0,
}
    // rust: let text = mode.write();
    // rust: assert_eq!(
    // rust: text,
    // rust: r#"{"width":1920,"height":1080,"red_bits":8,"green_bits":8,"blue_bits":8,"refresh_rate":60.0}"#
    // rust: );
    // rust: assert_eq!(VideoMode::read(&text), Some(mode));
    // rust: assert_eq!(VideoMode::read("1920x1080"), None);
    // rust: assert_eq!(VideoMode::read(r#"{"width":1}"#), None);
}
refresh_rate_label_is_whole_or_two_decimals :: proc() {
}
    // rust: let mut mode = VideoMode::read(
    // rust: r#"{"width":1,"height":1,"red_bits":8,"green_bits":8,"blue_bits":8,"refresh_rate":144.0}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(mode.refresh_rate_label(), "144");
    // rust: mode.refresh_rate = 59.94;
    // rust: assert_eq!(mode.refresh_rate_label(), "59.94");
    // rust: assert_eq!(mode.bits(), 24);
}
the_window_icon_decodes :: proc() {
}
    // rust: assert!(icon().is_some());
}

exclusive_fullscreen_reapplies_only_while_fullscreen_is_requested :: proc() {
}
    // rust: let mut f = FullscreenState::new(false);
    // rust: assert!(!f.set_exclusive(true));
    // rust: assert!(!f.set_exclusive(true));
    // rust: assert_eq!(f.request(true), Some(true));
    // rust: assert!(f.set_exclusive(false));
    // rust: assert!(!f.set_exclusive(false));
}
a_changed_video_mode_applies_once_when_fullscreen :: proc() {
}
    // rust: let mode = VideoMode::read(
    // rust: r#"{"width":1,"height":1,"red_bits":8,"green_bits":8,"blue_bits":8,"refresh_rate":60.0}"#,
    // rust: );
    // rust: let mut f = FullscreenState::new(false);
    // rust: f.set_preferred_mode(mode);
    // rust: assert!(!f.take_mode_change());
    // rust: f.request(true);
    // rust: f.set_preferred_mode(mode);
    // rust: assert!(f.take_mode_change());
    // rust: assert!(!f.take_mode_change());
}
fullscreen_follows_the_option_only_when_it_changes :: proc() {
}
    // rust: let mut f = FullscreenState::new(false);
        // Settings applied again with nothing changed: the window is left alone.
    // rust: assert_eq!(f.request(false), None);
        // The compositor makes the window fullscreen on its own: the option adopts it,
        // and applying the settings afterwards does not undo it.
    // rust: assert_eq!(f.observe(true), Some(true));
    // rust: assert_eq!(f.request(true), None);
    // rust: assert_eq!(f.observe(true), None);
        // F11: one request, not repeated while the compositor catches up.
    // rust: assert_eq!(f.request(false), Some(false));
    // rust: assert_eq!(f.request(false), None);
    // rust: assert_eq!(f.observe(false), Some(false));
    // rust: assert_eq!(f.request(false), None);
}

fullscreen_requests_changed_before_the_compositor_answers :: proc() {
}
        // Created fullscreen from options.txt.
    // rust: let mut f = FullscreenState::new(true);
    // rust: assert_eq!(f.request(true), None);
    // rust: assert_eq!(f.observe(true), Some(true));
        // Toggled twice before any configure: the second request cancels the first.
    // rust: assert_eq!(f.request(false), Some(false));
    // rust: assert_eq!(f.request(true), Some(true));
    // rust: assert_eq!(f.observe(true), None);
        // A compositor that refuses leaves the option where the player put it.
    // rust: assert_eq!(f.request(false), Some(false));
    // rust: assert_eq!(f.request(false), None);
}

Virtual :: struct {
    now: i64,
    oversleep: i64,
}
    // rust: impl LimiterClock for Virtual {
nanos :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.now
}
park :: proc(self: ^Self, nanos: i64) {
}
    // rust: self.now += nanos + self.oversleep;
}
spin :: proc(self: ^Self) {
}
    // rust: self.now += 1000;
}
}

scale_matches_the_320_by_240_rule :: proc() {
}
    // rust: assert_eq!(calculate_scale([854, 480], 0, false), 2);
    // rust: assert_eq!(calculate_scale([1920, 1080], 0, false), 4);
    // rust: assert_eq!(calculate_scale([1920, 1080], 3, false), 3);
    // rust: assert_eq!(calculate_scale([1920, 1080], 3, true), 4);
    // rust: assert_eq!(gui_scaled_size([1921, 1081], 4), [481, 271]);
}
    // A clock whose sleeps run late by a quarter of their length, as macOS's do,
    // sleeping as [`SystemClock::park`] does.
Coalescing :: struct {
    now: std::cell::Cell<i64>,
}
    // rust: impl LimiterClock for Coalescing {
nanos :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.now.get()
}
park :: proc(self: ^Self, nanos: i64) {
}
    // rust: let now = &self.now;
    // rust: park_in_steps(
    // rust: now.get() + nanos,
    // rust: || now.get(),
    // rust: |step| {
    // rust: now.set(now.get() + step + step / 4);
    // rust: },
    // rust: );
}
spin :: proc(self: ^Self) {
}
    // rust: self.now.set(self.now.get() + 1000);
}
}
a_frame_cap_holds_when_sleeps_run_late :: proc() {
}
    // rust: let mut clock = Coalescing {
    // rust: now: std::cell::Cell::new(0),
}
    // rust: let mut limiter = FramerateLimiter::new(0);
    // rust: let mut last = 0;
    // rust: for frame in 0..120 {
            // The frame's own work.
    // rust: clock.now.set(clock.now.get() + 2_000_000);
    // rust: limiter.limit_display_fps(60, &mut clock);
    // rust: let period = clock.now.get() - last;
    // rust: last = clock.now.get();
    // rust: assert!(
    // rust: (16_666_666..16_666_666 + 100_000).contains(&period),
    // rust: "frame {frame}: {period} ns"
    // rust: );
}
}
    // A clock whose sleeps and spins each run up to `late` ns late (a different
    // share each time), as a loaded machine's do.
Late :: struct {
    now: i64,
    late: i64,
    seed: u64,
}
    // rust: impl Late {
new :: proc(late: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: now: 0,
    // rust: late,
    // rust: seed: 0x9e37_79b9_7f4a_7c15,
}
}
lateness :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.seed ^= self.seed << 13;
    // rust: self.seed ^= self.seed >> 7;
    // rust: self.seed ^= self.seed << 17;
    // rust: (self.seed % 1000) as i64 * self.late / 1000
}
}
    // rust: impl LimiterClock for Late {
nanos :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.now
}
park :: proc(self: ^Self, nanos: i64) {
}
    // rust: self.now += nanos + self.lateness();
}
spin :: proc(self: ^Self) {
}
    // rust: self.now += 50_000 + self.lateness();
}
}
    // Frame periods of 144 FPS frames whose work takes `work(frame)` ns.
grid_periods :: proc(late: i64, work: impl Fn(uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut clock = Late::new(late);
    // rust: let mut limiter = FramerateLimiter::new(0);
    // rust: let mut ends = Vec::new();
    // rust: for frame in 0..300 {
    // rust: clock.now += work(frame);
    // rust: limiter.limit_on_grid(144, &mut clock);
    // rust: ends.push(clock.now);
}
    // rust: ends.windows(2).map(|w| w[1] - w[0]).collect()
}
the_grid_holds_the_cap_when_wake_ups_run_late :: proc() {
}
    // rust: let period = 1_000_000_000 / 144;
    // rust: for late in [0, 50_000, 200_000, 1_000_000] {
    // rust: let periods = grid_periods(late, |_| 2_000_000);
    // rust: let mean = periods[10..].iter().sum::<i64>() / (periods.len() - 10) as i64;
    // rust: assert!(
    // rust: (mean - period).abs() < 10_000,
    // rust: "{late} ns late: mean period {mean} ns"
    // rust: );
            // Each slot waits at least half a frame: the grid never rushes one out.
    // rust: assert!(
    // rust: periods.iter().all(|&p| p > period / 2),
    // rust: "{late} ns late: {periods:?}"
    // rust: );
}
        // Vanilla's way adds the lateness to the frames: the cap isn't held.
    // rust: let mut clock = Late::new(400_000);
    // rust: let mut limiter = FramerateLimiter::new(0);
    // rust: for _ in 0..300 {
    // rust: clock.now += 2_000_000;
    // rust: limiter.limit_display_fps(144, &mut clock);
}
    // rust: assert!(
    // rust: clock.now / 300 > period + 50_000,
    // rust: "vanilla: {} ns",
    // rust: clock.now / 300
    // rust: );
}
a_long_frame_starts_the_grid_again_without_a_burst :: proc() {
}
    // rust: let period = 1_000_000_000 / 144;
        // Frame 100 works 30 ms: four slots go by.
    // rust: let periods = grid_periods(
    // rust: 50_000,
    // rust: |frame| if frame == 100 { 30_000_000 } else { 2_000_000 },
    // rust: );
    // rust: assert!(periods[99] >= 30_000_000);
    // rust: for (i, &p) in periods.iter().enumerate().skip(100) {
            // On the grid a slot is a late wake-up (50 us at most) short or long.
    // rust: assert!(
    // rust: (period - 100_000..period + 100_000).contains(&p),
    // rust: "frame {}: {p} ns",
    // rust: i + 1
    // rust: );
}
}
limiter_paces_frames_at_the_target :: proc() {
}
    // rust: let mut limiter = FramerateLimiter::new(0);
    // rust: let mut clock = Virtual {
    // rust: now: 1_000_000,
    // rust: oversleep: 200_000,
}
    // rust: limiter.limit_display_fps(100, &mut clock);
    // rust: assert!(clock.now >= 10_000_000);
    // rust: assert!(clock.now < 10_000_000 + 1_000_000);
}
vsync_only_uses_fifo :: proc() {
}
    // rust: let all = [
    // rust: PresentMode::Mailbox,
    // rust: PresentMode::Fifo,
    // rust: PresentMode::Immediate,
    // rust: ];
    // rust: assert_eq!(vsync_present_mode(&all, true), Some(PresentMode::Fifo));
    // rust: assert_eq!(
    // rust: vsync_present_mode(&all, false),
    // rust: Some(PresentMode::Immediate)
    // rust: );
    // rust: assert_eq!(
    // rust: vsync_present_mode(&[PresentMode::Fifo], false),
    // rust: Some(PresentMode::Fifo)
    // rust: );
        // Regression guard: GLES capabilities report [Fifo, Immediate] without Mailbox.
    // rust: assert_eq!(
    // rust: vsync_present_mode(&[PresentMode::Fifo, PresentMode::Immediate], false),
    // rust: Some(PresentMode::Immediate)
    // rust: );
}
vsync_on_waits_for_the_display_whatever_the_present_mode :: proc() {
}
//         use PresentMode::*;
    // rust: let all = [Mailbox, Fifo, Immediate];
    // rust: for setting in [None, Some(Fifo), Some(Mailbox), Some(Immediate)] {
    // rust: assert_eq!(chosen_present_mode(&all, true, setting), Some(Fifo));
}
    // rust: assert_eq!(chosen_present_mode(&all, false, None), Some(Immediate));
    // rust: assert_eq!(
    // rust: chosen_present_mode(&all, false, Some(Mailbox)),
    // rust: Some(Mailbox)
    // rust: );
    // rust: assert_eq!(chosen_present_mode(&all, false, Some(Fifo)), Some(Fifo));
        // Metal has no Mailbox: vanilla's choice instead.
    // rust: assert_eq!(
    // rust: chosen_present_mode(&[Fifo, Immediate], false, Some(Mailbox)),
    // rust: Some(Immediate)
    // rust: );
}

video_modes_are_listed_again_only_for_another_monitor :: proc() {
}
    // rust: let mode = |width| VideoMode {
    // rust: width,
    // rust: height: 1080,
    // rust: red_bits: 8,
    // rust: green_bits: 8,
    // rust: blue_bits: 8,
    // rust: refresh_rate: 60.0,
}
    // rust: let mut list = VideoModeList::default();
    // rust: let mut listings = 0;
    // rust: let mut modes = |monitor: &i32| {
    // rust: listings += 1;
    // rust: vec![mode(*monitor)]
}
    // rust: assert_eq!(list.refresh(Some(1), &mut modes), Some(vec![mode(1)]));
    // rust: assert_eq!(list.refresh(Some(1), &mut modes), None);
    // rust: assert_eq!(list.refresh(Some(2), &mut modes), Some(vec![mode(2)]));
    // rust: assert_eq!(list.refresh(None, &mut modes), Some(vec![]));
    // rust: assert_eq!(list.refresh(Some(2), &mut modes), Some(vec![mode(2)]));
    // rust: assert_eq!(listings, 3);
}
}
